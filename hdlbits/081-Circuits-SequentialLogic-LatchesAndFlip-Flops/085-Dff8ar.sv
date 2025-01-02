module top_module (
    input clk,
    input areset,   // active high asynchronous reset
    input [7:0] d,
    output [7:0] q
);

    always_ff @(posedge clk, posedge areset) begin
        if (areset) begin
            // if areset asserted clear q
            q <= 8'd0; // 8 bit representation of decimal 0
        end else begin
            // otherwise store d in q
            q <= d;
        end
    end

endmodule
