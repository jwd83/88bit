module top_module(
    input a, b,
    output cout, sum );

    assign sum = a ^ b;
    assign cout = a & b;

endmodule


/*


module top_module(
    input a, b,
    output reg cout, sum );

    // An always block that implements the same combinational logic
    // but requires the module definition to be output reg instead of
    // just output
    always @(*) begin
        sum = a ^ b;
        cout = a & b;
    end

endmodule


*/