module top_module (
    input d,
    input ena,
    output logic q);

    always_ff @(posedge ena , posedge d) begin
        if (ena) begin
            q = d; // this should happen without delay so no <=
        end
    end

endmodule
