module top_module (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);



    always_ff @(posedge clk) begin
        if (L) begin
            // r_in is latched when L is 1
            Q = r_in; // 0
        end else begin
            // q_in is latched when L is 0

            Q = q_in;
        end
    end



endmodule
