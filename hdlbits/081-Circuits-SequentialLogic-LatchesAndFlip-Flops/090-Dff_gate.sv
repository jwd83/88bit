module top_module (
    input clk,
    input in,
    output out);

    always_ff @(posedge clk) begin
        out <= in ^ out;
    end

endmodule
