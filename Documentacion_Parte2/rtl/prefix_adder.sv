`timescale 1ns / 1ps

module prefix_adder #(parameter WIDTH = 8) (
    input  logic [WIDTH-1:0] A,
    input  logic [WIDTH-1:0] B,
    input  logic             Cin,
    output logic [WIDTH-1:0] Sum,
    output logic             Cout,
    output logic             Overflow
);

    // Señales de Generación (G) y Propagación (P)
    logic [WIDTH-1:0] G, P;
    logic [WIDTH:0]   C; // Vector de acarreos

    assign C[0] = Cin;

    // Cálculo de Propagación y Generación
    always_comb begin
        for (int i = 0; i < WIDTH; i++) begin
            P[i] = A[i] ^ B[i];
            G[i] = A[i] & B[i];
        end
    end

    // Red de cálculo de acarreos (Prefix network base)
    always_comb begin
        for (int i = 0; i < WIDTH; i++) begin
            C[i+1] = G[i] | (P[i] & C[i]);
            Sum[i] = P[i] ^ C[i];
        end
    end

    // Salidas finales de acarreo y overflow
    assign Cout = C[WIDTH];
    assign Overflow = C[WIDTH] ^ C[WIDTH-1];

endmodule