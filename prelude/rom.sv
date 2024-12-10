// Generated with generate_rom.py

module rom (
    input logic [7:0] address,
    output logic [7:0] data
);

    case (address)
        8'b00000000: data = 8'b00000101; // load R0 with 5
        8'b00000001: data = 8'b00000000;
        8'b00000010: data = 8'b00000000;
        8'b00000011: data = 8'b00000000;
        8'b00000100: data = 8'b00000000;
        8'b00000101: data = 8'b00000000;
        8'b00000110: data = 8'b00000000;
        8'b00000111: data = 8'b00000000;
        8'b00001000: data = 8'b00000000;
        8'b00001001: data = 8'b00000000;
        8'b00001010: data = 8'b00000000;
        8'b00001011: data = 8'b00000000;
        8'b00001100: data = 8'b00000000;
        8'b00001101: data = 8'b00000000;
        8'b00001110: data = 8'b00000000;
        8'b00001111: data = 8'b00000000;
        default: data = 8'b00000000;

    endcase
endmodule