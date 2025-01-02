/*

A priority encoder is a combinational circuit that, when given an input bit
vector, outputs the position of the first 1 bit in the vector. For example, a
8-bit priority encoder given the input 8'b10010000 would output 3'd4, because
bit[4] is first bit that is high.

Build a 4-bit priority encoder. For this problem, if none of the input bits are
high (i.e., input is zero), output zero. Note that a 4-bit number has 16
possible combinations.

*/
// synthesis verilog_input_version verilog_2001
module top_module (
    input [3:0] in,
    output reg [1:0] pos  );


    // my original code for this problem

    always @(*) begin
        case (in)
            4'b0000: pos = 2'b00;
            4'b0001: pos = 2'b00;
            4'b0010: pos = 2'b01;
            4'b0011: pos = 2'b00;
            4'b0100: pos = 2'b10;
            4'b0101: pos = 2'b00;
            4'b0110: pos = 2'b01;
            4'b0111: pos = 2'b00;
            4'b1000: pos = 2'b11;
            4'b1001: pos = 2'b00;
            4'b1010: pos = 2'b01;
            4'b1011: pos = 2'b00;
            4'b1100: pos = 2'b10;
            4'b1101: pos = 2'b00;
            4'b1110: pos = 2'b01;
            4'b1111: pos = 2'b00;
            default: pos = 2'b00;
        endcase
    end

    // after seeing the next lesson i came back and shortened it to this one for
    // practice. both work but i'll leave the original uncommented as it was the
    // intended solution for the lesson.

    // always @(*) begin
    //     casez (in)
    //         4'bzzz1: pos = 2'b00;
    //         4'bzz10: pos = 2'b01;
    //         4'bz100: pos = 2'b10;
    //         4'b1000: pos = 2'b11;
    //         default: pos = 2'b00;
    //     endcase
    // end

endmodule
