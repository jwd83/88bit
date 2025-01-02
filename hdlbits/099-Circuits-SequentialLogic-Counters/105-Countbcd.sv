/*

Build a 4-digit BCD (binary-coded decimal) counter. Each decimal digit is
encoded using 4 bits: q[3:0] is the ones digit, q[7:4] is the tens digit, etc.
For digits [3:1], also output an enable signal indicating when each of the upper
three digits should be incremented.

You may want to instantiate or modify some one-digit decade counters.

*/

module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);


    logic [3:0] q_0, q_1, q_2, q_3;

    bcd_counter bcd0(clk, reset, 1'b1,   q_0);
    bcd_counter bcd1(clk, reset, ena[1], q_1);
    bcd_counter bcd2(clk, reset, ena[2], q_2);
    bcd_counter bcd3(clk, reset, ena[3], q_3);

    always_comb begin
        ena[1] = (q_0 == 9);
        ena[2] = (q_0 == 9) & (q_1 == 9);
        ena[3] = (q_0 == 9) & (q_1 == 9) & (q_2 == 9);
        q = {q_3, q_2, q_1, q_0};
    end

endmodule


module bcd_counter (
    input clk,
    input reset,        // Synchronous active-high reset
    input enable,
    output [3:0] q);


    always_ff @(posedge clk ) begin
        if (reset)
            q <= 0;
        else
            if (enable)
                if (q == 9)
                    q <= 0;
                else
                    q <= q + 1;

    end

endmodule
