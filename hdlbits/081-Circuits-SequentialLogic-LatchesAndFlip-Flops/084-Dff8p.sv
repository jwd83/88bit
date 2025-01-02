module top_module (
    input clk,
    input reset,
    input [7:0] d,
    output [7:0] q
);
    always_ff @(negedge clk) begin
        if (reset) begin
            // if reset asserted clear q
            q <= 8'h34; // 8 bit representation of hex 34
        end else begin
            // otherwise store d in q
            q <= d;
        end
    end
endmodule
