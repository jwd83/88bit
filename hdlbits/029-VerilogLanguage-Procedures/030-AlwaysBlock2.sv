// synthesis verilog_input_version verilog_2001
module top_module(
    input clk,
    input a,
    input b,
    output wire out_assign,
    output reg out_always_comb,
    output reg out_always_ff   );

    // Continuous assignments
    assign out_assign = a ^ b;

    // Procedural blocking assignment
    always @(*) out_always_comb = a ^ b;

    // Procedural non-blocking assignment
    always @(posedge clk) out_always_ff <= a ^ b;


endmodule
