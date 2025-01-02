module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);


/*
this module implements a 32-bit carry select adder that depends on 3 of the
following 16-bit adders:

module add16 (
    input[15:0] a,
    input[15:0] b,
    input cin,
    output[15:0] sum,
    output cout
);

*/


    wire carry_out_1;
    wire [15:0] lower_result;
    wire [15:0] upper_result_c;
    wire [15:0] upper_result_nc;
    wire [15:0] upper_result_final;

    add16 lower16(
        .a(a[15:0]),
        .b(b[15:0]),
        .cin(1'b0),
        .sum(lower_result),
        .cout(carry_out_1)
    );


    add16 upper16NoCarry(
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(1'b0),
        .sum(upper_result_nc),
        .cout()
    );

    add16 upper16Carry(
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(1'b1),
        .sum(upper_result_c),
        .cout()
    );

    always @(*) begin
        case (carry_out_1)
            1'b0: sum = {upper_result_nc, lower_result};
            1'b1: sum = {upper_result_c, lower_result};
        endcase
    end



endmodule
