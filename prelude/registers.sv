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
    logic [7:0] register_file [7:0];

    always_comb begin
        // hard wire special output registers
        r0_out = register_file[0];
        r3_out = register_file[3];
        rio_out = register_file[7];

        // output the value of the selected registers
        // todo when RIO is specified as a source,
        // output the value of the `in` signal

        out_a = register_file[src_a];
        out_b = register_file[src_b];
    end


    always_ff @(posedge clk)
    begin
        if (write_enable)
            register_file[dst] <= in;
    end

endmodule