/*

Peach: A series of 32 bit RISC-V processor



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

-------------------
state 0:  and use the alu to calculate next_pc, next state: 1
ir<=memory[pc]      // load the instruction from memory into instruction register
next_pc<=pc + 4     // calculate the program counter +4 with the alu
state <= 1           // advance to state 1
-------------------
state 1: decode ir and determine op type, next state: = ?
alu op <= ir decoded
rd <= ir decoded
rs1 <= ir decoded
rs2 <= ir decoded
imm12 <= ir decoded
imm20 <= ir decoded for upper 20 bits of imm (double check this)
state <= ? depends on opcode

? = 2 when alu reg[rd] = [rs1] op [rs2]
? = 3 when alu rsd = [rs1] op imm
? = 5 when branch ops pc + imm
? = 7 write to memory
? = 9 load from memory
-------------------
state 2:
a<=reg[rs1]
b<=reg[rs2]
state<=4
-------------------
state 3:
a<=reg[rs1]
b<=imm
state<=4
-------------------
state 4:
reg[rd]<=alu(a,b)
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

// Define the instruction types
`define I_TYPE     7'b0000011 //   3
`define I_TYPE_alt 7'b0010011 //  19
`define S_TYPE     7'b0100011 //  35
`define R_TYPE     7'b0110011 //  51
`define B_TYPE     7'b1100011 //  99
`define U_TYPE     7'b0010111 //  23
`define J_TYPE     7'b1100111 // 103
`define J_TYPE_alt 7'b1101111 // 111


module peach32 (
    input logic clk,
    input logic reset,
    output logic [7:0] out,
);

    logic [31:0] state;         // state stores the state of the current instructions phase
    logic [31:0] pc;            // pc stores the program counter
    logic [31:0] next_pc;       // next_pc is loaded into pc when the current instruction has finished executing
    logic [31:0] ir;            // ir is the instruction register holding the 32 bit instruction currently being executed

    // many of the following are only applicable to certain instruction types
    logic [2:0] funct3;         // funct3 is the 3 bit function code for the currently executing instruction
    logic [6:0] funct7;         // funct7 is the 7 bit function code for the currently executing instruction
    logic [6:0] opcode;         // opcode is the 7 bit opcode for the currently executing instruction
    logic [31:0] a;             // a is operand a for the currently executing instruction
    logic [31:0] b;             // b is operand b for the currently executing instruction
    logic [4:0] rs1;            // rs1 is the source register 1
    logic [4:0] rs2;            // rs2 is the source register 2
    logic [4:0] rd;             // rd is the destination register
    logic [11:0] imm12;         // imm12 is the lower 12 bit immediate value for the currently executing instruction
    logic [19:0] imm20;         // imm20 is the upper 20 bits of the immediate value for the currently executing instruction


    // modules



    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            out <= 8'b0;
            state <= 0;
        end else begin
            // rv32i multi-cycle state machine
            case (state)
                0: begin

                end
                1: begin

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

module rom (
    input logic [31:0] address,
    output logic [31:0] data
);


    logic [31:0] rom_contents [0:4095]; // 4k x 32 bit rom  (131,072 bits, verify fpga has enough bram for this)
    // pretty sure we can just chop off the lower 2 bits and then use the upper 30 bits as the address and that *should* work
    // with the way we are bringing in this rom from the text file. given we are only on 4 byte boundaries the lower 2 bits
    // should always be 0 and can be ignored. this should simplify the bram synthesis
    logic [29:0] upper_address;

    // load our program ROM from rom.txt
    initial begin
        $readmemb("rom.txt", rom_contents);
    end

    always_comb begin
        upper_address = address[31:2];
        data = rom_contents[upper_address];
    end
endmodule
