module top_module (
    input clk,
    input x,
    output z
);

    logic xor_out, and_out, or_out;
    logic dff0_q, dff1_q, dff2_q;
    logic dff0_q_bar, dff1_q_bar, dff2_q_bar;

    always_comb begin
        xor_out = x ^ dff0_q;
        and_out = x & dff1_q_bar;
        or_out = x | dff2_q_bar;
        z = ~(dff0_q | dff1_q | dff2_q); // nor the Q's together, not xnor dummy.
    end


    my_dff dff0 (.clk(clk), .d(xor_out), .q(dff0_q), .q_bar(dff0_q_bar));
    my_dff dff1 (.clk(clk), .d(and_out), .q(dff1_q), .q_bar(dff1_q_bar));
    my_dff dff2 (.clk(clk), .d(or_out),  .q(dff2_q), .q_bar(dff2_q_bar));

endmodule


module my_dff (
    input logic clk,    // Clocks are used in sequential circuits
    input logic d,
    output logic q,
    output logic q_bar);//

    // Use a clocked always block
    //   copy d to q at every positive edge of clk
    //   Clocked always blocks should use non-blocking assignments

    assign q_bar = ~q;

    always_ff @(posedge clk) begin

        q <= d;

    end

endmodule
