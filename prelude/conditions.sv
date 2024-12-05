module conditions(
    input logic [7:0] r3,
    input logic [2:0] condition,
    output logic result
);

// Condition bits|Condition|Notes
// -|-|-
// 000|Never|No op, never take branch
// 001|R3 ==  0
// 010|R3 < 0
// 011|R3 <= 0
// 100|Always
// 101|R3 != 0
// 110|R3 >= 0
// 111|R3 > 0

    case (condition)
        3'b000: result = 1'b0;
        3'b001: result = (r3 == 8'b00000000);
        3'b010: result = (r3 < 8'b00000000);
        3'b011: result = (r3 <= 8'b00000000);
        3'b100: result = 1'b1;
        3'b101: result = (r3 != 8'b00000000);
        3'b110: result = (r3 >= 8'b00000000);
        3'b111: result = (r3 > 8'b00000000);
    endcase

endmodule