module top_module (
    input clk,
    input [7:0] in,
    output logic [7:0] pedge
);

    // store the prior state in last_in
    logic [7:0] last_in;

    always_ff @( posedge clk ) begin
        // store the last received value
        last_in <= in;

        // and the new value with the inverse of last value
        pedge <= in & ~last_in;
    end

endmodule
