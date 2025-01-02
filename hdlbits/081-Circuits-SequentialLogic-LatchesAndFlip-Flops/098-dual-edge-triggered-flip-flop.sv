module top_module (
    input clk,
    input d,
    output q
);

    /*

    my thought is we make a register that trigers on each edge and then xor
    their output so when they are different we get a trigger

        HDLbits solution:

	reg p, n;

	// A positive-edge triggered flip-flop
    always @(posedge clk)
        p <= d ^ n;

    // A negative-edge triggered flip-flop
    always @(negedge clk)
        n <= d ^ p;

    // Why does this work?
    // After posedge clk, p changes to d^n. Thus q = (p^n) = (d^n^n) = d.
    // After negedge clk, n changes to d^p. Thus q = (p^n) = (p^d^p) = d.
    // At each (positive or negative) clock edge, p and n FFs alternately
    // load a value that will cancel out the other and cause the new value of d to remain.
    assign q = p ^ n;


	// Can't synthesize this.
	// always @(posedge clk, negedge clk) begin
	// 	q <= d;
	// end


    */

    logic d_pos;
    logic d_neg;

    always_ff @( posedge clk ) begin
        d_pos = d ^ d_neg;

    end

    always_ff @(negedge clk) begin
        d_neg = d ^ d_pos;
    end

    assign q = d_pos ^ d_neg;

endmodule
