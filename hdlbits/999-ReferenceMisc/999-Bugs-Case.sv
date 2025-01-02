/*


This combinational circuit is supposed to recognize 8-bit keyboard scancodes
for keys 0 through 9. It should indicate whether one of the 10 cases were
recognized (valid), and if so, which key was detected. Fix the bug(s).

// scan codes can be verified here:

https://www.scs.stanford.edu/23wi-cs212/pintos/specs/kbd/scancodes-9.html

// they look correct


*/
module top_module (
    input logic [7:0] code,
    output logic [3:0] out,
    output logic valid );//


    always_comb begin
        case (code)
            8'h45: valid = 1;
            8'h16: valid = 1;
            8'h1e: valid = 1;
            8'h26: valid = 1;
            8'h25: valid = 1;
            8'h2e: valid = 1;
            8'h36: valid = 1;
            8'h3d: valid = 1;
            8'h3e: valid = 1;
            8'h46: valid = 1;
            default: valid = 0;
        endcase

        case (code)
            8'h45: out = 0;
            8'h16: out = 1;
            8'h1e: out = 2;
            8'h26: out = 3;
            8'h25: out = 4;
            8'h2e: out = 5;
            8'h36: out = 6;
            8'h3d: out = 7;
            8'h3e: out = 8;
            8'h46: out = 9;
            default: out = 0 ;
        endcase
    end

endmodule
