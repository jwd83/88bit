module rom (
    input logic [7:0] address,
    output logic [7:0] data
);
    logic [7:0] rom_contents [0:255];

    // load our program ROM from rom.txt
    initial begin
        $readmemb("rom.txt", rom_contents);
    end

    always_comb begin
        data = rom_contents[address];
    end
endmodule
