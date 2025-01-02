module top_module ( input a, input b, output out );

    // instantiate my_module by name. notice the period immediately preceding
    // the port name in this syntax. this will NOT break if the order of the
    // ports in my_module changes

    // i prefer this way for the verbosity
    mod_a my_module (.in1(a), .in2(b), .out(out));

    // instantiate my_module by order. this will break if the order of the ports
    // in my_module ever changes
    // mod_a my_module (a, b, out);

endmodule
