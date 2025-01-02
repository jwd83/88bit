module top_module (
    input a,
    input b,
    input c,
    input d,
    output out1,
    output out2
);

    // i just gave it a long random name to show that you can name it whatever
    // you want when you instantiate it
    mod_a the_module_im_making(out1, out2, a, b, c, d);

endmodule
