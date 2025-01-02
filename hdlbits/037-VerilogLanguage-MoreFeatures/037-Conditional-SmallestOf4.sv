/*

Ternary operator examples from hdlbits

(0 ? 3 : 5)     // This is 5 because the condition is false.
(sel ? b : a)   // A 2-to-1 multiplexer between a and b selected by sel.


// A T-flip-flop.

always @(posedge clk)
  q <= toggle ? ~q : q;


// State transition logic for a one-input FSM
always @(*)
  case (state)
    A: next = w ? B : A;
    B: next = w ? A : B;
  endcase


// A tri-state buffer
assign out = ena ? q : 1'bz;


// A 3-to-1 mux
((sel[1:0] == 2'h0) ? a :
 (sel[1:0] == 2'h1) ? b :
                      c )

                      */


/*

Given four unsigned numbers, find the minimum. Unsigned numbers can be compared
with standard comparison operators (a < b). Use the conditional operator to make
two-way min circuits, then compose a few of them to create a 4-way min circuit.
You'll probably want some wire vectors for the intermediate results.

*/
module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);//

    wire [7:0] a_b;
    wire [7:0] c_d;

    always @(*) begin
      a_b = (a < b) ? a : b;
      c_d = (c < d) ? c : d;
      min = (a_b < c_d) ? a_b : c_d;
    end
    // assign intermediate_result1 = compare? true: false;

endmodule
