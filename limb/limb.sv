/*

Limb
-A tribute to "LEG"
Written by Jared De Blander in December of 2024

This is designed to be a simple 8 bit RISC CPU inspired by "LEG" from the hit
Steam game "Turing Complete" which itself was inspired by "ARM".

###################################
|| Instruction Set Architecture  ||
###################################
# register to register operations #
###################################
ADD rd, rs1, rs2
SUB rd, rs1, rs2
AND rd, rs1, rs2
OR rd, rs1, rs2
NAND rd, rs1, rs2
NOR rd, rs1, rs2
NOT rd, rs1 // note this could be achieved with xor and 8'b11111111
XOR rd, rs1, rs2

######################################
# register with immediate operations #
######################################
ADDI rd, rs1, imm
SUBI rd, rs1, imm
ANDI rd, rs1, rs2
ORI rd, rs1, imm
XORI rd, rs1, rs2

################################
# load/store memory operations #
################################
LOAD rd, ra
STORE rs, ra
STOREI ra, imm // this is a little redundant.. wasn't sure if I wanted to include it

###########################
# control flow operations #
###########################

>> branches <<
-> branches set the next_pc to the immediate address if the condition is met
BEQ rs1, rs2, immediate address
BNE rs1, rs2, immediate address
BLT rs1, rs2, immediate address
BGT rs1, rs2, immediate address
BLE rs1, rs2, immediate address
BGE rs1, rs2, immediate address
BRA immediate address | JMP immediate address

>> calls <<
-> calls push the return address onto the stack if they are taken
CEQ rs1, rs2, immediate address
CNE rs1, rs2, immediate address
CLT rs1, rs2, immediate address
CGT rs1, rs2, immediate address
CLE rs1, rs2, immediate address
CGE rs1, rs2, immediate address
CALL immediate address
-> ret pops the return address off the stack and jumps to it
RET

+-----------------+
| Register Layout |
+-----------------+

16 general purpose registers
r0 is hardwired to 0
r15 is the RAM address register for load/store
r14 is the stack pointer register

special registers
pc - program counter
ir - instruction register
sp - stack pointer register (handled in hardware, not user accessible)

+-----------------+
| Memory Layout   |
+-----------------+

Limb uses a Harvard architecture with dedicated program ROM and a separate RAM
and stack for variable tracking and an internal call stack for call/ret PC tracking.

+----------------+
| Reset Behavior |
+----------------+

state, program counter and registers set to 0,
stack pointer set to ff


*/

module limb(
    input logic clk,
    input logic reset,
    input logic [7:0] rio_in,
    output logic [7:0] rio_out
);

    logic [3:0] state;              // state machine state
    logic [7:0] pc;                 // program counter
    logic [7:0] ir;                 // instruction register
    logic [7:0] next_pc;            // next program counter

    logic [7:0] alu_out;            // alu result
    logic       alu_in_a;           // alu control signals from decoder
    logic       alu_in_b;           // alu control signals from decoder
    logic       alu_eq;             // branching signals from alu comparisons
    logic       alu_ne;             // branching signals from alu comparisons
    logic       alu_lt;             // branching signals from alu comparisons
    logic       alu_gt;             // branching signals from alu comparisons
    logic       alu_le;             // branching signals from alu comparisons
    logic       alu_ge;             // branching signals from alu comparisons

    logic       rf_write_enable;    // register file signals
    logic [3:0] rf_src_a;           // register file signals
    logic [3:0] rf_src_b;           // register file signals
    logic [3:0] rf_dst;             // register file signals
    logic [7:0] rf_in;              // register file signals
    logic [7:0] rf_out_a;           // register file signals
    logic [7:0] rf_out_b;           // register file signals

    // instantiate modules
    rom rom ();
    decoder decoder ();
    registers registers ();
    ram ram ();
    alu alu ();



endmodule

module decoder(
    input logic [31:0] ir,
    output logic [3:0] src_a,
    output logic [3:0] src_b,
    output logic [3:0] dst,
    output logic [3:0] dst_selection,
    output logic write_enable,
    output logic opcode,
);

endmodule

// 16 registers r0-r15.
// r0 is always 0
// r15 sets load/store address from RAM
module registers(
    input logic [3:0] src_a,
    input logic [3:0] src_b,
    input logic [3:0] dst,
    input logic write_enable,
    input logic [7:0] in,
    input logic clk,
    input logic reset,
    output logic [7:0] out_a,
    output logic [7:0] out_b,
    output logic [7:0] rio_out
  );

    logic [7:0] registers[15:1];

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            registers <= 0;
        end else if (write_enable) begin
            if(dst != 0) begin
                registers[dst] <= in;
            end
            registers[dst] <= in;
        end
    end

    assign out_a = ((src_a == 0) ? 8'b00000000 : registers[src_a]);
    assign out_b = ((src_b == 0) ? 8'b00000000 : registers[src_b]);
endmodule

module ram(
    input logic clk,
    input logic reset,
    input logic [7:0] data_in,
    input logic [7:0] address,
    input logic write_enable,
    output logic [7:0] data_out
);

    logic [7:0] ram[255:0];

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            ram <= 0;
        end else if (write_enable) begin
            ram[address] <= data_in;
        end
    end

    assign data_out = ram[address];

endmodule

module alu(
    input logic [7:0] opcode,
    input logic [7:0] a,
    input logic [7:0] b,
    output logic [7:0] out
);

endmodule

module rom(
    input logic [7:0] address,
    output logic [31:0] data
);

    always_comb begin
        case (address)
            0: data = 32'h00000000;
            1: data = 32'h00000000;
            2: data = 32'h00000000;
            default: data = 32'h00000000;
        endcase
    end
endmodule

module stack(
    input logic clk,
    input logic reset,
    input logic [7:0] data_in,
    input logic push,
    input logic pop,
    output logic [7:0] data_out
);

    logic [7:0] stack[255:0];
    logic [7:0] sp;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            sp <= 0;
        end else if (push) begin
            sp <= sp + 1;
            stack[sp] <= data_in;
        end else if (pop) begin
            data_out <= stack[sp];
            sp <= sp - 1;
        end
    end
endmodule
