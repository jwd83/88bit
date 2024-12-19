/*

Limb
-A tribute to "LEG"
Written by Jared De Blander in December of 2024

This is designed to be a simple 8 bit RISC CPU inspired by "LEG" from the hit
Steam game "Turing Complete" which itself was inspired by "ARM".

+-----------------+
| Register Layout |
+-----------------+

16 general purpose registers
r0 is hardwired to 0
r15 is the RAM address register for load/store

special registers
pc - program counter
ir - instruction register
sp - stack pointer register (handled in hardware, not user accessible)

+-----------------+
| Memory Layout   |
+-----------------+

Limb uses a Harvard architecture with dedicated program ROM and a separate RAM
for variable storage and an internal call stack for call/ret PC tracking.

*/

module limb(
    input logic clk,
    input logic reset,
    input logic [7:0] rio_in,
    output logic [7:0] rio_out
);

    logic [7:0] pc;         // program counter
    logic [7:0] ir;         // instruction register
    logic [7:0] next_pc;    // next program counter
    logic [7:0] alu_out;    // alu result
    logic condition_result; // branching signals
    logic write_enable;     // register file signals
    logic [3:0] src_a;      // register file signals
    logic [3:0] src_b;      // register file signals
    logic [3:0] dst;        // register file signals
    logic [7:0] in;         // register file signals
    logic [7:0] out_a;      // register file signals
    logic [7:0] out_b;      // register file signals

    // instantiate modules
    rom rom ();
    decoder decoder ();
    registers registers ();
    ram ram ();
    alu alu ();



endmodule

module decoder();
endmodule

// 16 registers r0-r15.
// r0 is always 0
// r15 sets load/store address from RAM
module registers(
    logic [3:0] src_a,

);

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
