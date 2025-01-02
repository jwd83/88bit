module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);

    // when sub is true we need to xor the bits of b and set the carry in to 1

    wire carry_out_1;

    wire [31:0] b_final;

    assign b_final = b ^ {32{sub}}; // xor b with 32 copies of sub

    add16 lower16(
        .a(a[15:0]),
        .b(b_final[15:0]),
        .cin(sub), // set this to sub to perform the +1 for the negate +1
        .sum(sum[15:0]),
        .cout(carry_out_1)
    );
    add16 upper16(
        .a(a[31:16]),
        .b(b_final[31:16]),
        .cin(carry_out_1),
        .sum(sum[31:16]),
        .cout()
    );

endmodule
