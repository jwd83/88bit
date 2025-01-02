module top_module (
    input clk,
    input w, R, E, L,
    output Q
);

    always_ff @(posedge clk) begin
        // if L == 1 then
        //   Q = r
        // else
        //   if E == 1 then
        //      Q = w
        //   else
        //      Q = Q
        if (L == 1) begin
            Q = R;
        end else begin
            if (E == 1) begin
                Q = w;
            end else begin
                Q = Q;
            end
        end
    end

endmodule
