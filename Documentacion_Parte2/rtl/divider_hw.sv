`timescale 1ns / 1ps

module divider_hw #(parameter WIDTH = 8) (
    input  logic [WIDTH-1:0] dividend,
    input  logic [WIDTH-1:0] divisor,
    output logic [WIDTH-1:0] quotient,
    output logic [WIDTH-1:0] remainder
);

    always_comb begin
        // Prevención de división por cero
        if (divisor == 0) begin
            quotient  = {WIDTH{1'b1}}; // Máximo valor posible
            remainder = dividend;
        end else begin
            quotient  = dividend / divisor;
            remainder = dividend % divisor;
        end
    end

endmodule