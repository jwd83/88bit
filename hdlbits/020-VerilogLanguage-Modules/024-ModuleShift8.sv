module top_module (
    input clk,
    input [7:0] d,
    input [1:0] sel,
    output [7:0] q
);

    // wires for intermediate shift register connections
    wire [7:0] a_b;
    wire [7:0] b_c;
    wire [7:0] c_out;


    // instantiate the shift registers
    my_dff8 md_a (.clk(clk), .d(d),   .q(a_b));
    my_dff8 md_b (.clk(clk), .d(a_b), .q(b_c));
    my_dff8 md_c (.clk(clk), .d(b_c), .q(c_out));

    // my first multiplexer - huzzah!
    always @(*) begin
        case (sel)
            2'b00: q = d;
            2'b01: q = a_b;
            2'b10: q = b_c;
            2'b11: q = c_out;
        endcase
    end

endmodule
