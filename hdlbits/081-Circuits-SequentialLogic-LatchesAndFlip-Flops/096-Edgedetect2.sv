// For each bit in an 8-bit vector, detect when the input signal changes from
// one clock cycle to the next (detect any edge). The output bit should be set
// the cycle after a 0 to 1 transition occurs.

module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);

    // pretty sure we just use a xor with the prior lesson's code

    // store the prior state in last_in
    logic [7:0] last_in;

    always_ff @( posedge clk ) begin
        // store the last received value
        last_in <= in;

        // xor the new value with the last value to detect change
        anyedge <= in ^ last_in;
    end

endmodule
