/*

The following module definition is provided:

    module bcd_fadd (
    input [3:0] a,
    input [3:0] b,
    input     cin,
    output   cout,
    output [3:0] sum );


*/

module top_module(
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );

    logic [99:0] carry_bits;

    genvar i;
    generate
        for (i = 0; i < 100; i = i + 1) begin: adder

            if (i == 0) begin
                // use the provided cin as the cin for the first full adder
                bcd_fadd bcdadder (.a(a[i*4+3:i*4]), .b(b[i*4+3:i*4]), .cin(cin), .sum(sum[i*4+3:i*4]), .cout(carry_bits[i]));
            end else begin
                //  otherwise use the cout from the previous full adder as cin
                bcd_fadd bcdadder (.a(a[i*4+3:i*4]), .b(b[i*4+3:i*4]), .cin(carry_bits[i-1]), .sum(sum[i*4+3:i*4]), .cout(carry_bits[i]));
            end
        end
    endgenerate

    assign cout = carry_bits[99];

endmodule
