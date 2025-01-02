/*

from the waveform...

x   y | z
---------
0   0 | 1
1   0 | 0
0   1 | 0
1   1 | 1

looks like an XNOR gate

*/

module top_module ( input x, input y, output z );

    assign z = ~(x ^ y);

endmodule
