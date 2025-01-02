module top_module (
    input clk,
    input reset,            // Synchronous reset
    input [7:0] d,
    output [7:0] q
);

    always_ff @(posedge clk) begin
        if (reset) begin
            // if reset asserted clear q
            q <= 8'd0; // 8 bit representation of decimal 0
        end else begin
            // otherwise store d in q
            q <= d;
        end
    end

endmodule
