module top_module(
    input a,
    input b,
    output out );


    // ^ is the XOR
    // ~ is the NOT


    // XNOR = NOT (A XOR B)
    assign out = ~(a ^ b);

endmodule
