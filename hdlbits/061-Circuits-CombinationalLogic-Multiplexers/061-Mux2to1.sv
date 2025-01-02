module top_module(
    input a, b, sel,
    output out );

    always_comb begin
        if (sel == 1'b0) begin
            out = a;
        end else begin
            out = b;
        end
    end

    // provided solution:
    // 	assign out = (sel & b) | (~sel & a);	// Mux expressed as AND and OR

endmodule
