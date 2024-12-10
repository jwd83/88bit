
module rom (
    input logic [7:0] address,
    output logic [7:0] data
);

    case (address)
        8'h00: data <= 8'b10110001;
        8'h01: data <= 8'b00000011;
        8'h02: data <= 8'b10000010;
        8'h03: data <= 8'b01000011;
        8'h04: data <= 8'b10011110;

        default: data = 8'b00000000;
    endcase
endmodule
