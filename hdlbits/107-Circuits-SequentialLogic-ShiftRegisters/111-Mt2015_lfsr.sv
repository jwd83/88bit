/*

Taken from 2015 midterm question 5. See also the first part of this question:
mt2015_muxdff

Write the Verilog code for this sequential circuit (Submodules are ok, but the
top-level must be named top_module). Assume that you are going to implement the
circuit on the DE1-SoC board. Connect the R inputs to the SW switches, connect
Clock to KEY[0], and L to KEY[1]. Connect the Q outputs to the red lights LEDR.

The first part of this question is here in this repo:
------------------------------------------------------------------------------
    091-Mt2015_muxdff.sv :
------------------------------------------------------------------------------

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


*/

module top_module (
    input [2:0] SW,      // R
    input [1:0] KEY,     // L and clk
    output [2:0] LEDR);  // Q

    /*
    Write the Verilog code for this sequential circuit (Submodules are ok, but the
    top-level must be named top_module). Assume that you are going to implement the
    circuit on the DE1-SoC board. Connect the R inputs to the SW switches, connect
    Clock to KEY[0], and L to KEY[1]. Connect the Q outputs to the red lights LEDR.
    */

    logic q_0, q_1, q_2;
    logic r_0, r_1, r_2;
    logic clk;
    logic L;


    always_comb begin
        clk = KEY[0];
        L = KEY[1];
        r_0 = SW[0];
        r_1 = SW[1];
        r_2 = SW[2];

        LEDR[0] = q_0;
        LEDR[1] = q_1;
        LEDR[2] = q_2;

    end

    flip_mod f0(
        .clk(clk),
        .L(L),
        .r_in(r_0),
        .q_in(q_2),
        .Q(q_0)
    );

    flip_mod f1(
        .clk(clk),
        .L(L),
        .r_in(r_1),
        .q_in(q_0),
        .Q(q_1)
    );

    flip_mod f2(
        .clk(clk),
        .L(L),
        .r_in(r_2),
        .q_in(q_1 ^ q_2),
        .Q(q_2)
    );

endmodule

module flip_mod (
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