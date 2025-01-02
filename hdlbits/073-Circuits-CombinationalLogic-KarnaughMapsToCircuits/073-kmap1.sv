module top_module(
    input a,
    input b,
    input c,
    output out  );

    // this looks like a | b | c to me
    assign out = a | b | c;

endmodule
