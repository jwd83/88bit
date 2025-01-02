module top_module (
    input a, b, c, d, e,
    output [24:0] out );//

    /*

        Given five 1-bit signals (a, b, c, d, and e), compute all 25 pairwise
        one-bit comparisons in the 25-bit output vector. The output should be 1
        if the two bits being compared are equal.

        out[24] = ~a ^ a;   // a == a, so out[24] is always 1.
        out[23] = ~a ^ b;
        out[22] = ~a ^ c;
        ...
        out[ 1] = ~e ^ d;
        out[ 0] = ~e ^ e;


        As the diagram shows, this can be done more easily using the replication
        and concatenation operators.

        The top vector is a concatenation of 5 repeats of each input The bottom
        vector is 5 repeats of a concatenation of the 5 inputs

    */

    // The output is XNOR of two vectors created by
    // concatenating and replicating the five inputs.
    // assign out = ~{ ... } ^ { ... };

    wire [24:0] v1 = {{5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}}};
    wire [24:0] v2 = {5{a, b, c, d, e}};
    assign out = ~(v1 ^ v2);


endmodule
