module top_module ( input clk, input d, output q );

    wire qd_12;
    wire qd_23;


    my_dff dff1 (.clk(clk), .d(d),     .q(qd_12));
    my_dff dff2 (.clk(clk), .d(qd_12), .q(qd_23));
    my_dff dff3 (.clk(clk), .d(qd_23), .q(q));

endmodule
