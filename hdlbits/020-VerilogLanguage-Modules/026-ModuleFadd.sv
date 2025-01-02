module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);//
// we have been supplied the following module:
// module add16 ( input[15:0] a, input[15:0] b, input cin, output[15:0] sum, output cout );


    wire carry_out_1;

    add16 lower16(
        .a(a[15:0]),
        .b(b[15:0]),
        .cin(1'b0),
        .sum(sum[15:0]),
        .cout(carry_out_1)
    );
    add16 upper16(
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(carry_out_1),
        .sum(sum[31:16]),
        .cout()
    );
endmodule

module add1 ( input a, input b, input cin,   output sum, output cout );

    // Full adder module here

    // this is pretty slick... expansion, baby!
    // assign {cout, sum} = a + b + cin;

    // this provides the same functionality as the above line
    // but uses the provided full adder formula that are a bit more clear
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);



endmodule
