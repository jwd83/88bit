module top_module(
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out );

    // i initially tried but failed:
    // assign out = in[sel*4+3:sel*4];


    // i read the hint and looked at how to do bit slicing
    // the following code works.
    assign out = in[sel*4+:4];


    // the provided solution is:
    // assign out = {in[sel*4+3], in[sel*4+2], in[sel*4+1], in[sel*4+0]};
    // as well as some other alternatives.


    /*


        Hint...

        With this many options, a case statement isn't so useful.

        Vector indices can be variable, as long as the synthesizer can figure
        out that the width of the bits being selected is constant. It's not
        always good at this. An error saying "... is not a constant" means it
        couldn't prove that the select width is constant. In particular, in[
        sel*4+3 : sel*4 ] does not work.

        Bit slicing ("Indexed vector part select", since Verilog-2001) has an
        even more compact syntax.


    */

endmodule
