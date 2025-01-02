module top_module (
    input [4:0] a, b, c, d, e, f,
    output [7:0] w, x, y, z );//


    /*

    original solution. took me a while to figure out i needed to specify the
    width of the packed_data here.

    */
    // wire [31:0] packed_data;
    // assign packed_data = {a, b, c, d, e, f, 2'b11};
    // assign {w, x, y, z} = packed_data;

    // newer solution just skipping the wire i tried that just worked
    assign {w, x, y, z} = {a, b, c, d, e, f, 2'b11};


endmodule
