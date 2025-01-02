`default_nettype none
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   );

    wire and_ab;
    wire and_cd;

    wire or_ab_cd;

    assign and_ab = a & b;
    assign and_cd = c & d;

    assign or_ab_cd = and_ab | and_cd;

    assign out = or_ab_cd;
    assign out_n = ~or_ab_cd;

endmodule
