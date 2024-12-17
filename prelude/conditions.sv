/*

Condition bits for branch instructions are as follows:

---------------|-----------|------------------------------
Condition      |           |
bits           | Condition | Notes
---------------|-----------|------------------------------
           000 | Never     | No op, never take branch
           001 | R3 ==  0  |
           010 | R3 < 0    | signed
           011 | R3 <= 0   | signed
           100 | Always    |
           101 | R3 != 0   |
           110 | R3 >= 0   | signed
           111 | R3 > 0    | signed
---------------|-----------|------------------------------

...or all of r3 bits together then invert to get if all bits are zero
logic r_eq_zero = ~|r3;

...check if top bit set for less than zero
logic r_lt_zero = r3[7];

...check if top bit not set and any other bit set for greater than zero
logic r_gt_zero = (r3[7] == 1'b0) & ~(~|r3);

*/


`define BRN      3'b000
`define BZ       3'b001
`define BLT      3'b010
`define BLE      3'b011
`define BRA      3'b100
`define BNZ      3'b101
`define BGE      3'b110
`define BGT      3'b111

module conditions(
    input logic [7:0] r3,
    input logic [2:0] condition,
    output logic result
);
    always_comb begin
        case (condition)
            `BRN: result = 1'b0;
            `BZ:  result = (~|r3);
            `BLT: result = (r3[7]);
            `BLE: result = (~|r3) | (r3[7]);
            `BRA: result = 1'b1;
            `BNZ: result = ~(~|r3);
            `BGE: result = (~|r3) | ((r3[7] == 1'b0) & ~(~|r3));
            `BGT: result = ((r3[7] == 1'b0) & ~(~|r3));
        endcase
    end

endmodule