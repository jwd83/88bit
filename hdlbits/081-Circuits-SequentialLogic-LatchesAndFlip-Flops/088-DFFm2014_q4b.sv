module top_module (
    input clk,
    input d,
    input ar,   // asynchronous reset
    output logic q);

    always_ff @(posedge clk, posedge ar) begin
        if (ar) begin
            // if ar asserted clear q
            q <= 0; // 0
        end else begin
            // otherwise store d in q
            q <= d;
        end
    end

endmodule
