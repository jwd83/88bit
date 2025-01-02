module top_module (
    input clk,
    input d,
    input r,   // synchronous reset
    output q);

    always_ff @(posedge clk) begin
        if (r) begin
            // if reset asserted clear q
            q <= 0; // store 0 in q
        end else begin
            // otherwise store d in q
            q <= d;
        end
    end

endmodule
