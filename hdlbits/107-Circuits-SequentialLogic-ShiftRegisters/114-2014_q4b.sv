/*

Consider the n-bit shift register circuit shown below:



Write a top-level Verilog module (named top_module) for the shift register,
assuming that n = 4. Instantiate four copies of your MUXDFF subcircuit in your
top-level module. Assume that you are going to implement the circuit on the DE2
board.

Connect the R inputs to the SW switches,
clk to KEY[0],
E to KEY[1],
L to KEY[2], and
w to KEY[3].

Connect the outputs to the red lights LEDR[3:0].

(Reuse your MUXDFF from exams/2014_q4a.)

----- My code from exams/2014_q4a:

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


*/

module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //

    MUXDFF m_0 (.clk(), .w(), .R(), .E(), .L(), .Q());
    MUXDFF m_1 (.clk(), .w(), .R(), .E(), .L(), .Q());
    MUXDFF m_2 (.clk(), .w(), .R(), .E(), .L(), .Q());
    MUXDFF m_3 (.clk(), .w(), .R(), .E(), .L(), .Q());

endmodule

module MUXDFF (
    input clk,
    input w, R, E, L,
    output Q
);

    always_ff @(posedge clk) begin
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
