/*

Implement the following circuit:

*/

module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);

    logic [3:0] q;

    always_comb begin
        out = q[3];
    end

    always_ff @(posedge clk) begin
        if (!resetn) begin
            q <= 4'b0;
        end else begin
            q[3] <= q[2];
            q[2] <= q[1];
            q[1] <= q[0];
            q[0] <= in;
        end
    end

endmodule
