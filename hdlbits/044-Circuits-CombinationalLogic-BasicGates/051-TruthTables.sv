/*

implement the following truth table

inputs     | output
x3  x2  x1 | f
----------------------
0   0   0  | 0
0   0   1  | 0
0   1   0  | 1
0   1   1  | 1
1   0   0  | 0
1   0   1  | 1
1   1   0  | 0
1   1   1  | 1

*/

module top_module(
    input x3,
    input x2,
    input x1,  // three inputs
    output f   // one output
);

    always_comb begin
        case({x3, x2, x1})
            3'b000: f = 1'b0;
            3'b001: f = 1'b0;
            3'b010: f = 1'b1;
            3'b011: f = 1'b1;
            3'b100: f = 1'b0;
            3'b101: f = 1'b1;
            3'b110: f = 1'b0;
            3'b111: f = 1'b1;
            default: f = 1'b0;
        endcase
    end

    /*


	// This truth table has four minterms.
	assign f = ( ~x3 & x2 & ~x1 ) |
				( ~x3 & x2 & x1 ) |
				( x3 & ~x2 & x1 ) |
				( x3 & x2 & x1 ) ;

	// It can be simplified, by boolean algebra or Karnaugh maps.
	// assign f = (~x3 & x2) | (x3 & x1);

	// You may then notice that this is actually a 2-to-1 mux, selected by x3:
	// assign f = x3 ? x1 : x2;

    */


endmodule
