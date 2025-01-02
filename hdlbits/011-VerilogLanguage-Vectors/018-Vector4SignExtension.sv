module top_module (
    input [7:0] in,
    output [31:0] out );

    // sign extend the 8-bit input to 32 bits make 24 copies of the sign bit and
    // concatenate the input to the sign bits

    assign out = {{ 24{in[7]}} , in };

    // my original code failed. i think i needed an extra set of curly braces to
    // make the 24 copies of the sign bit. assign out = { 24{in[7]} , in };

endmodule
