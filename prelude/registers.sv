module registers(
    input logic [2:0] src_a,
    input logic [2:0] src_b,
    input logic [2:0] dst,
    input logic write_enable,
    input logic [7:0] in,
    input logic clk,
    output logic [7:0] out_a,
    output logic [7:0] out_b
);

    logic [7:0] rfile [7:0];

    always_ff @(posedge clk)
    begin
        if (write_enable)
            rfile[dst] <= in;
    end

endmodule