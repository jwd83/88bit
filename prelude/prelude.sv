module prelude(
    input logic clk,
    input logic [7:0] rio_in,
    output logic [7:0] rio_out,
);

    logic [7:0] pc; // program counter
    logic [7:0] ir; // instruction register
    logic [7:0] next_pc; // next program counter

    // branching signals
    logic condition_result;
    logic [7:0] r0_out; // register 0 output
    logic [7:0] r3_out; // register 3 output

    // register file signals
    logic write_enable;
    logic src_a;
    logic src_b;
    logic dst;
    logic [7:0] in;
    logic [7:0] out_a;
    logic [7:0] out_b;


    // instantiate modules
    registers r_file(
        src_a,
        src_b,
        dst,
        write_enable,
        in,
        clk,
        out_a,
        out_b,
        r0_out,
        r3_out;
        rio_out;
    )

    rom instruction_rom (
        .address(pc),
        .data(ir)
    );

    conditions condition_engine (
        r3_out,
        ir[2:0],
        condition_result
    );

    always_comb begin
        next_pc = pc + 1;
    end

    // advance the program counter, branching
    // when appropriate
    always_ff @(posedge clk) begin
        if ((ir[7:6] == 2'b11) & condition_result) pc <= r0_out;
        else pc <= next_pc;
    end
endmodule