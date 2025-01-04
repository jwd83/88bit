/*

Peach: A series of 32 bit RISC-V processor

Some of my notes:
https://docs.google.com/spreadsheets/d/1ICEoRUD06qAYWSxx6jYBzeptPAZinV3vcMwp9kGgkVI/edit?gid=136006519#gid=136006519

architecture components:

pc: program counter
ir: instruction register
a: operand a
b: operand b
rd: destination register
next_pc: next program counter


multi-cycle rv32i controlled by a finite state machine

on reset set state to 255. copy rom into memory. when complete set pc to 0, state = 0
state 255: copy rom into memory. when complete set pc to 0, state = 0

More Research and code prep:

https://stnolting.github.io/neorv32/


look into using ALU to calculate branch conditional results
-------------------
STATE_FETCH:  and use the alu to calculate next_pc, next state: 1
ir<=memory[pc]      // load the instruction from memory into instruction register
next_pc<=pc + 4     // calculate the program counter +4 with the alu
state <= STATE_DECODE          // advance to state 1

-------------------
STATE_DECODE: decode ir and determine op type, next state: = ?
alu op <= ir decoded
rd <= ir decoded
rs1 <= ir decoded
rs2 <= ir decoded
imm_??? <= ir decoded
state <= ? depends on opcode

copy these bit locations out of the spreadsheet

? = 2 when alu reg[rd] = [rs1] op [rs2]
? = 3 when alu rsd = [rs1] op imm
? = 5 when branch ops pc + imm
? = 7 write to memory
? = 9 load from memory
-------------------
STATE_ALU_REG_REG:
a<=reg[rs1]
b<=reg[rs2]
aluop<=ir[parsed]
state<=STATE_ALU_EXECUTE
-------------------
STATE_ALU_REG_IMM:
a<=reg[rs1]
b<=imm
state<=STATE_ALU_EXECUTE
-------------------
STATE_ALU_EXECUTE:
reg[rd]<=alu(a,b,op)
state<=0
-------------------
state 5:
branch ops
if (condition) state<=6
else state<=0
-------------------
state 6:
pc<=pc + imm
state<=0
-------------------
state 7:
write to memory
state<=8
-------------------
state 8:
if write to memory not complete state<=8
else state<=0
-------------------
state 9:
set load from memory address
state<=10
-------------------
state 10:
if (load from memory complete) {
    reg[rd]<=memory
    state<=0
} else {
    state<=10
}


*/

`define STATE_FETCH         32'd0
`define STATE_DECODE        32'd10
`define STATE_ALU_REG_REG   32'd20
`define STATE_ALU_REG_IMM   32'd30
`define STATE_ALU_EXECUTE   32'd40
`define STATE_LOAD          32'd40
`define STATE_STORE         32'd50
`define STATE_AUI_PC        32'd60
`define STATE_BRANCH        32'd70
`define STATE_JAL           32'd80
`define STATE_JALR          32'd90
`define STATE_LUI           32'd100

// Define the instruction types by opcode
`define I_TYPE     7'b0000011 //   3
`define I_TYPE_alt 7'b0010011 //  19
`define S_TYPE     7'b0100011 //  35
`define R_TYPE     7'b0110011 //  51
`define B_TYPE     7'b1100011 //  99
`define U_TYPE     7'b0010111 //  23
`define J_TYPE     7'b1100111 // 103
`define J_TYPE_alt 7'b1101111 // 111

// Define the op37 values for the different instruction types

`define OP37_ADD_I 17'b00000000000010011
`define OP37_AND_I 17'b00000001110010011
`define OP37_OR_I  17'b00000001100010011


module peach32 (
    input logic clk,
    input logic reset,
    output logic [7:0] out,
);

    // main registers
    logic [31:0] state;         // state stores the state of the current instructions phase
    logic [31:0] pc;            // pc stores the program counter
    logic [31:0] next_pc;       // next_pc is loaded into pc when the current instruction has finished executing
    logic [31:0] ir;            // ir is the instruction register holding the 32 bit instruction currently being executed
    logic [31:0] memory_out;    // memory_out is the output from the memory module
    logic [31:0] memory_addr;   // memory_addr is the address to read/write from/to memory

    // many of the following are only applicable to certain instruction types
    logic [2:0] funct3;         // funct3 is the 3 bit function code for the currently executing instruction
    logic [6:0] funct7;         // funct7 is the 7 bit function code for the currently executing instruction, only used for R type instructions
    logic [6:0] opcode;         // opcode is the 7 bit opcode for the currently executing instruction
    logic [16:0] op37;          // op37 is the 17 bit opcode for the currently executing instruction
    logic [31:0] a;             // a is operand a for the currently executing instruction
    logic [31:0] b;             // b is operand b for the currently executing instruction
    logic [4:0] rs1;            // rs1 is the source register 1
    logic [4:0] rs2;            // rs2 is the source register 2, it may also contain the shift amount for shift instructions
    logic [4:0] rd;             // rd is the destination register
    logic [31:0] imm_u;
    logic [31:0] imm_j;
    logic [31:0] imm_b;
    logic [31:0] imm_s;
    logic [31:0] imm_i;

    // modules
    memory memory (
        .address(memory_addr),
        .data(memory_out)
    );

    always_comb begin
        op37 = {funct7, funct3, opcode};

    end




    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            out <= 8'b0;
            state <= 0;
        end else begin
            // rv32i multi-cycle state machine
            case (state)
                STATE_FETCH: begin
                    // load the instruction from memory into instruction register
                    ir <= memory_out;
                    // calculate the program counter +4 with the alu
                    next_pc <= pc + 4;
                    // advance to state 1
                    state <= STATE_DECODE;
                end
                STATE_DECODE: begin
                    // decode ir and determine op type
                    opcode <= ir[6:0];
                    funct3 <= ir[14:12];
                    funct7 <= ir[31:25];
                    rs1 <= ir[19:15];
                    rs2 <= ir[24:20];
                    rd <= ir[11:7];

                    imm_i <= {{21{ir[31]}}, ir[30:20]}; // sign extend imm_i, 21 copies of the msb
                    imm_u <= {ir[31:12], 12'b0};        // zero extend imm_u, 12 zeros
                    imm_j <= {{12{ir[31]}}, ir[19:12], ir[20], ir[30:21]}; // sign extend imm_j, 12 copies of the msb
                    imm_b <= {{20{ir[31]}}, ir[7], ir[30:25], ir[11:8], 1'b0}; // sign extend imm_b, 20 copies of the msb and an extra zero
                    imm_s <= {{21{ir[31]}}, ir[25:30],ir[11:7]}; // sign extend imm_s, 21 copies of the msb
                    // imm_r does not exist as r type instructions do not have an immediate field
                    // determine next state based on opcode
                    case (opcode)
                        `R_TYPE: state <= 2;
                        `I_TYPE: state <= 3;
                        `I_TYPE_alt: state <= 3;
                        `S_TYPE: state <= 5;
                        `B_TYPE: state <= 5;
                        `U_TYPE: state <= 5;
                        `J_TYPE: state <= 5;
                        `J_TYPE_alt: state <= 5;
                        default: state <= 0;
                    endcase

                end
                2: begin

                end
            endcase
        end
    end

endmodule

module decoder (
    input logic [31:0] instruction,
    output logic type_r,
    output logic type_i,
    output logic type_s,
    output logic type_b,
    output logic type_u,
    output logic type_j
);

    logic [6:0] opcode;


    always_comb begin
        opcode = instruction[6:0];

        type_r = (opcode == `R_TYPE);
        type_i = (opcode == `I_TYPE) | (opcode == `I_TYPE_alt);
        type_s = (opcode == `S_TYPE);
        type_b = (opcode == `B_TYPE);
        type_u = (opcode == `U_TYPE);
        type_j = (opcode == `J_TYPE) | (opcode == `J_TYPE_alt);
    end
endmodule

module memory (
    input logic clk,
    input logic reset,
    input logic write_enable,
    input logic [31:0] address,
    input logic [31:0] data_in,
    output logic [31:0] data_out
);


    logic [31:0] rom_contents [0:4095]; // 4k x 32 bit rom  (131,072 bits, verify fpga has enough bram for this)

    // load our program ROM from rom.txt
    initial begin
        $readmemb("rom.txt", rom_contents);
    end

    always_comb begin
        // pretty sure we can just chop off the lower 2 bits and then use the upper 30 bits as the address and that *should* work
        // with the way we are bringing in this rom from the text file. given we are only on 4 byte boundaries the lower 2 bits
        // should always be 0 and can be ignored. this should simplify the bram synthesis
        data = rom_contents[address[31:2]];
    end
endmodule
