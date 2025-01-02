/*
Create a 100-bit binary ripple-carry adder by instantiating 100 full adders. The
adder adds two 100-bit numbers and a carry-in to produce a 100-bit sum and carry
out. To encourage you to actually instantiate full adders, also output the
carry-out from each full adder in the ripple-carry adder. cout[99] is the final
carry-out from the last full adder, and is the carry-out you usually see.
*/

module top_module(
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );

    genvar i;
    generate
        for (i = 0; i < 100; i = i + 1) begin: adder

            if (i == 0) begin
                // use the provided cin as the cin for the first full adder
                add1 u_add1 (.a(a[i]), .b(b[i]), .cin(cin), .sum(sum[i]), .cout(cout[i]));
            end else begin
                //  otherwise use the cout from the previous full adder as cin
                add1 u_add1 (.a(a[i]), .b(b[i]), .cin(cout[i-1]), .sum(sum[i]), .cout(cout[i]));
            end
        end
    endgenerate

endmodule

module add1 ( input a, input b, input cin, output sum, output cout );

    // Full adder module here
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);

endmodule
