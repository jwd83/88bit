/*

possible future upgrades:

> 10 bit instruction words to allow encode of full 8 bit immediate values.
> a UART module to send and receive data from a host computer.
> a RAM interface controlled by an existing register that has no other purpose.
> shift and/or rotate instructions.
> a load high and low nibble version of the load immediate instruction.
> carry select adder for a performance boost over the standard ripple carry.
> halt instruction to stop the processor. this could be accomplished with a
  load address of next instruction and branch always as next instruction.

a RAM interface is a bit more LEG than Overture in the game Turing Complete,
but it would allow for more complex programs to be run on the system as we
are limited to registers with the original overture design.

i think a first go at the RAM interface would be flip flop based SRAM on my
Tang Nano 20k but i think it would be interesting to try to implement a DRAM
interface but that might be left for the LEG tribute chip.

*/
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
    logic [2:0] src_a;
    logic [2:0] src_b;
    logic [2:0] dst;
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

    // module alu (
    //     logic [5:0] alu_op,
    //     logic [7:0] in_a,
    //     logic [7:0] in_b,
    //     logic [7:0] out
    // ) ;

    alu alu (
        ir[5:0],


    );



    conditions condition_engine (
        r3_out,
        ir[2:0],
        condition_result
    );

    // calculate our incrementing program counter and send control signals
    // to the functional units
    always_comb begin
        next_pc = pc + 1;

        // todo: need to do instruction decoding and signaling

        // examine the contents of the instruction register

    end

    // advance the program counter, branching
    // when appropriate
    always_ff @(posedge clk) begin
        if ((ir[7:6] == 2'b11) & condition_result) pc <= r0_out;
        else pc <= next_pc;
    end
endmodule