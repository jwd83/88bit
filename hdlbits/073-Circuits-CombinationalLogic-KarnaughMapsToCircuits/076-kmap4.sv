// this sounds like just xoring all the bits together
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  );

    assign out = a ^ b ^ c ^ d;

endmodule
