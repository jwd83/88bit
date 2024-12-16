/*



        ##### ##                       ###                     ##
     ######  /###                       ###                     ##
    /#   /  /  ###                       ##                     ##
   /    /  /    ###                      ##                     ##
       /  /      ##                      ##                     ##
      ## ##      ## ###  /###     /##    ##  ##   ####      ### ##    /##
      ## ##      ##  ###/ #### / / ###   ##   ##    ###  / ######### / ###
    /### ##      /    ##   ###/ /   ###  ##   ##     ###/ ##   #### /   ###
   / ### ##     /     ##       ##    ### ##   ##      ##  ##    ## ##    ###
      ## ######/      ##       ########  ##   ##      ##  ##    ## ########
      ## ######       ##       #######   ##   ##      ##  ##    ## #######
      ## ##           ##       ##        ##   ##      ##  ##    ## ##
      ## ##           ##       ####    / ##   ##      /#  ##    /# ####    /
      ## ##           ###       ######/  ### / ######/ ##  ####/    ######/
 ##   ## ##            ###       #####    ##/   #####   ##  ###      #####
###   #  /
 ###    /           Prelude
  #####/            ... A tribute to "Overture"
    ###

    * A simple 8 bit RISC CPU inspired by Overture from Turing Complete *

TODO:
* optimize signal routing
* connect reset line to register file to reset all registers to 0

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
    input logic reset,
    input logic [7:0] rio_in,
    output logic [7:0] rio_out,
);

    logic [7:0] pc; // program counter
    logic [7:0] ir; // instruction register
    logic [7:0] next_pc; // next program counter

    // alu result
    logic [7:0] alu_out;

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
        .src_a(src_a),
        .src_b(src_b),
        .dst(dst),
        .write_enable(write_enable),
        .in(in),
        .clk(clk),
        .out_a(out_a),
        .out_b(out_b),
        .r0_out(r0_out),
        .r3_out(r3_out),
        .rio_out(rio_out)
    );

    rom instruction_rom (
        .address(pc),
        .data(ir)
    );

    alu alu (
        .alu_op(ir[5:0]),
        .in_a(out_a),
        .in_b(out_b),
        .out(alu_out)
    );

    conditions condition_engine (
        .r3(r3_out),
        .condition(ir[2:0]),
        .result(condition_result)
    );

    // calculate our incrementing program counter and send control signals
    // to the functional units
    always_comb begin
        next_pc = pc + 1;

        casez (ir)
            // immediate
            8'b00zzzzzz: begin
                dst = 3'b000;
                in = {2'b00, ir[5:0]};
                write_enable = 1'b1;

            end

            // calculate
            8'b01zzzzzz: begin
                dst = 3'b011;
                in = alu_out;
                write_enable = 1'b1;
            end

            // copy
            8'b10zzzzzz: begin
                src_a = ir[5:3];
                dst = ir[2:0];
                in = out_a;
                write_enable = 1'b1;
            end

            // branch
            8'b11zzzzzz: begin
                dst = 3'b000;
                write_enable = 1'b0;
            end
        endcase
    end

    // advance the program counter, branching
    // when appropriate
    always_ff @(posedge clk) begin
        // when reset is high, reset the program counter
        if (reset) pc <= 8'b00000000;
        else begin
            if ((ir[7:6] == 2'b11) & condition_result) pc <= r0_out;
            else pc <= next_pc;
        end
    end
endmodule