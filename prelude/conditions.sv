module conditions(
    input logic [7:0] r3,
    input logic [2:0] condition,
    output logic result
);

// Condition bits|Condition|Notes
// -|-|-
// 000|Never|No op, never take branch
// 001|R3 ==  0
// 010|R3 < 0|signed
// 011|R3 <= 0|signed
// 100|Always
// 101|R3 != 0
// 110|R3 >= 0|signed
// 111|R3 > 0|signed


    always_comb begin

        // or all of r3 bits together then invert to get if all bits are zero
        // logic r_eq_zero = ~|r3;

        // check if top bit set for less than zero
        // logic r_lt_zero = r3[7];

        // check if top bit not set and any other bit set for greater than zero
        // logic r_gt_zero = (r3[7] == 1'b0) & ~(~|r3);


        case (condition)
            3'b000: result = 1'b0;
            3'b001: result = (~|r3);
            3'b010: result = (r3[7]);
            3'b011: result = (~|r3) | (r3[7]);
            3'b100: result = 1'b1;
            3'b101: result = ~(~|r3);
            3'b110: result = (~|r3) | ((r3[7] == 1'b0) & ~(~|r3));
            3'b111: result = ((r3[7] == 1'b0) & ~(~|r3));
        endcase
    end

endmodule