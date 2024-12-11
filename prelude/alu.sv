module alu (
    input logic [5:0] alu_op,
    input logic [7:0] in_a,
    input logic [7:0] in_b,
    output logic [7:0] out
) ;


// 000000|OR|out = in_a or in_b
// 000001|NAND|out = ~(in_a and in_b)
// 000010|NOR|out = ~(in_a or in_b)
// 000011|AND|out = in_a and in_b
// 000100|ADD|out = in_a + in_b
// 000101|SUB|out = in_a - in_b
// 000110|XOR|out = in_a ^ in_b, Prelude specific
// 000111|SHL|out = in_a << in_b, Prelude specific (future unimplemented)

    casez (alu_op)
        6'b000000: out = in_a | in_b;
        6'b000001: out = ~(in_a & in_b);
        6'b000010: out = ~(in_a | in_b);
        6'b000011: out = in_a & in_b;
        6'b000100: out = in_a + in_b;
        6'b000101: out = in_a - in_b;
        6'b000110: out = in_a ^ in_b;
        default: out = 8'b0;
    endcase


endmodule