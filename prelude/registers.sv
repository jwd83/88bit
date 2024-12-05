module registers(
    input logic [2:0] src_a,
    input logic [2:0] src_b,
    input logic [2:0] dst,
    input logic write_enable,
    input logic [7:0] in,
    input logic clk,
    output logic [7:0] out_a,
    output logic [7:0] out_b,
    output logic [7:0] r0_out,
    output logic [7:0] r3_out;
    output logic [7:0] rio_out;

);
    logic [7:0] rfile [7:0];

    always_comb begin
        // hardwire special output registers
        r0_out = rfile[0];
        r3_out = rfile[3];
        rio_out = rfile[7];

        // output the value of the selected registers
        out_a = rfile[src_a];
        out_b = rfile[src_b];
    end


    always_ff @(posedge clk)
    begin
        if (write_enable)
            rfile[dst] <= in;
    end

endmodule