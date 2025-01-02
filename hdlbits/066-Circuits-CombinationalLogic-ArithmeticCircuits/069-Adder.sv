module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum);

    logic c_0, c_1, c_2;

    full_adder fa0(x[0], y[0], 1'b0,  c_0,   sum[0]);
    full_adder fa1(x[1], y[1], c_0,   c_1,   sum[1]);
    full_adder fa2(x[2], y[2], c_1,   c_2,   sum[2]);
    full_adder fa3(x[3], y[3], c_2,   sum[4],sum[3]);

    // verilog will also just genreate a ripple carry if you just use the
    // following code:

    //  assign sum = x+y;


endmodule
/*

Create a full adder. A full adder adds three bits (including carry-in) and
produces a sum and carry-out.

*/

module full_adder(
    input a, b, cin,
    output cout, sum );

    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);

endmodule
