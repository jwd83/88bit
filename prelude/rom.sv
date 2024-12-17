
module rom (
    input logic [7:0] address,
    output logic [7:0] data
);
    // a solution to The Maze from Turing Complete

    always_comb begin
        case (address)
            8'h00: data = 8'b00000001;
            8'h01: data = 8'b10000010;
            8'h02: data = 8'b00000000;
            8'h03: data = 8'b10000110;
            8'h04: data = 8'b00000100;
            8'h05: data = 8'b10000110;
            8'h06: data = 8'b10110001;
            8'h07: data = 8'b01000101;
            8'h08: data = 8'b00001110;
            8'h09: data = 8'b11000001;
            8'h0A: data = 8'b00000001;
            8'h0B: data = 8'b10000110;
            8'h0C: data = 8'b00000010;
            8'h0D: data = 8'b11000100;
            8'h0E: data = 8'b00000010;
            8'h0F: data = 8'b10000110;
            8'h10: data = 8'b00000100;
            8'h11: data = 8'b11000100;

            default: data = 8'b00000000;
        endcase
    end
endmodule
