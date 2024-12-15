// a 256 byte RAM module with 8-bit data width and addressing
module ram256 (
    input  logic        clk,     // clock
    input  logic        we,      // write enable
    input  logic [7:0]  addr,    // address
    input  logic [7:0]  din,     // data in
    output logic [7:0]  dout     // data out
);

    logic [7:0] mem [255:0]; // 256-byte memory array

    always_ff @(posedge clk) begin
        if (we) begin           // write enable
            mem[addr] <= din;   // write data
        end
    end

    always_comb begin
        dout = mem[addr];
    end

endmodule