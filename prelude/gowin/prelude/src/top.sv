module top_module(
    input logic clk,
    input logic S1,
    input logic S2,
    output logic LED0,
    output logic LED1,
    output logic LED2,
    output logic LED3,
    output logic LED4,
    output logic LED5
);

    logic [7:0] leds;

    prelude prelude(
        .clk(clk),
        .reset(~S1),
        .rio_in({7'b0, ~S2}),
        .rio_out(leds)
    );

    always_comb begin
        LED0 = ~leds[0];
        LED1 = ~leds[1];
        LED2 = ~leds[2];
        LED3 = ~leds[3];
        LED4 = ~leds[4];
        LED5 = ~leds[5];
    end

endmodule