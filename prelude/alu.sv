/*

ALU operations for Prelude are defined as follows:

----------|-----------|----------------------------------------
  ALU op  |           |
  bits    | Operation | Description
----------|-----------|----------------------------------------
   000000 | OR        | out = in_a or in_b
   000001 | NAND      | out = ~(in_a and in_b)
   000010 | NOR       | out = ~(in_a or in_b)
   000011 | AND       | out = in_a and in_b
   000100 | ADD       | out = in_a + in_b
   000101 | SUB       | out = in_a - in_b
   000110 | XOR       | out = in_a ^ in_b, Prelude specific
   000111 | SHL       | out = in_a << in_b, Prelude specific
----------|-----------|----------------------------------------

*/

`define ALU_OR      6'b000000
`define ALU_NAND    6'b000001
`define ALU_NOR     6'b000010
`define ALU_AND     6'b000011
`define ALU_ADD     6'b000100
`define ALU_SUB     6'b000101
`define ALU_XOR     6'b000110
`define ALU_SHL     6'b000111

module alu (
    input logic [5:0] alu_op,
    input logic [7:0] in_a,
    input logic [7:0] in_b,
    output logic [7:0] out
);
    always_comb begin
        casez (alu_op)
            `ALU_OR:     out = in_a | in_b;
            `ALU_NAND:   out = ~(in_a & in_b);
            `ALU_NOR:    out = ~(in_a | in_b);
            `ALU_AND:    out = in_a & in_b;
            `ALU_ADD:    out = in_a + in_b;
            `ALU_SUB:    out = in_a - in_b;
            `ALU_XOR:    out = in_a ^ in_b;
            `ALU_SHL:    out = in_a << in_b;
            default: out = 8'b0;
        endcase
    end
endmodule