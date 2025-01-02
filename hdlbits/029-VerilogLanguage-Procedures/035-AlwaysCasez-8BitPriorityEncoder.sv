// synthesis verilog_input_version verilog_2001

// in a casez statement the z's are don't care bits. if the input matches the
// pattern of the case statement, the output is assigned the value of the case
// statement. if the input does not match any of the case statements, the
// default statement is executed.

// you can also use a ? in place of the z. there is also a casex statement which
// is similar to casez but the x's are don't care bits. this is redundant and
// hdlbits sees not much purpose to use it over casez

module top_module (
    input [7:0] in,
    output reg [2:0] pos );
    always @(*) begin
        casez (in)
            8'bzzzzzzz1: pos = 3'd0;
            8'bzzzzzz10: pos = 3'd1;
            8'bzzzzz100: pos = 3'd2;
            8'bzzzz1000: pos = 3'd3;
            8'bzzz10000: pos = 3'd4;
            8'bzz100000: pos = 3'd5;
            8'bz1000000: pos = 3'd6;
            8'b10000000: pos = 3'd7;
            default: pos = 3'b000;
        endcase
    end
endmodule
