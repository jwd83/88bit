/*

Module A is supposed to implement the function z = (x^y) & x. Implement this
module.

*/
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


module top_module (input x, input y, output z);

    always_comb begin

        logic z_aia1, z_aia2, z_bib1, z_bib2,
        logic z_or;
        logic z_and;

        mod_a aia1 ( .x(x), .y(y), .z(z_aia1) );
        mod_b bib1 ( .x(x), .y(y), .z(z_bib1) );
        mod_a aia2 ( .x(x), .y(y), .z(z_aia2) );
        mod_b bib2 ( .x(x), .y(y), .z(z_bib2) );

        z_or = z_aia1 | z_bib1;
        z_and = z_aia2 & z_bib2;

        z = z_or ^ z_and;
    end
endmodule


module mod_a (input x, input y, output z);

    assign z = (x ^ y) & x;

endmodule

module mod_b ( input x, input y, output z );

    assign z = ~(x ^ y);

endmodule
