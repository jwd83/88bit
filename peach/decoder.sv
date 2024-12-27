/*

Peach

a 32 bit RISC-V processor with a harvard architecture


multicycle rv32i controlled by a finite state machine

on reset set state to 255. copy rom into memory. when complete set pc to 0, state = 0
state 255: copy rom into memory. when complete set pc to 0, state = 0

state 0: ir <= memory[pc] state = 1
state 1: decode ir and determine op type, next state: = ?


alu reg=reg+reg ops
state 2:

alu reg+imm ops
state 3:

branch ops

load ops

store ops






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