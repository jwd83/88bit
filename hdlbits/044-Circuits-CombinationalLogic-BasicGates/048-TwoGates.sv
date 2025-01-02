module top_module (
    input in1,
    input in2,
    input in3,
    output out);

    // xnor in1 and in2 then xor in3

    assign out = ~(in1 ^ in2) ^ in3;



endmodule
