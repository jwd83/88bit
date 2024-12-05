module prelude(
    input logic clk,
    input logic [7:0] rio_in,
    output logic [7:0] rio_out,
);

    logic [7:0] pc; // program counter
    logic [7:0] ir; // instruction register

    rom instruction_rom (
        .address(pc),
        .data(ir)
    );

    always_comb begin
        next_pc = pc + 1;
    end

    always_ff @(posedge clk) begin
        // determine the type of instruction by the top 2 bits
        case (ir[7:6])
            2'b00: begin
                // write to register 0 with the value in
                // the lower bits of the instruction
                pc <= next_pc;
            end
            2'b01: begin
                // perform an ALU operation
                pc <= next_pc;

            end
            2'b10: begin
                // perform a copy operation
                pc <= next_pc;

            end
            2'b11: begin
                // perform a branch operation
                pc <= next_pc;

            end
        endcase
    end
endmodule