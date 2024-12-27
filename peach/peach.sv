/*

Peach

a 32 bit RISC-V processor with a harvard architecture

architecture components:

pc: program counter
ir: instruction register
a: operand a
b: operand b
rd: destination register
next_pc: next program counter


multicycle rv32i controlled by a finite state machine

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