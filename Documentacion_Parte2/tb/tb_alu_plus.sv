`timescale 1ns / 1ps

module tb_alu_plus;

    // Parámetro de 16 bits como solicita el parcial
    parameter WIDTH = 16;

    // Entradas
    logic [WIDTH-1:0] A;
    logic [WIDTH-1:0] B;
    logic [2:0]       ALUControl;

    // Salidas
    logic [WIDTH-1:0] Result;
    logic [3:0]       Flags; // {N, Z, C, V}

    // Instancia de la ALU+
    alu_plus #(WIDTH) uut (
        .A(A),
        .B(B),
        .ALUControl(ALUControl),
        .Result(Result),
        .Flags(Flags)
    );

    initial begin
        // Inicialización
        A = 0; B = 0; ALUControl = 0;
        #10;

        // 1. Suma (000)
        A = 16'd150; B = 16'd50; ALUControl = 3'b000;
        #20;

        // 2. Resta (001)
        A = 16'd150; B = 16'd50; ALUControl = 3'b001;
        #20;

        // 3. AND (010) - Probando tri-estado
        A = 16'hFF00; B = 16'h0F0F; ALUControl = 3'b010;
        #20;

        // 4. OR (011) - Probando tri-estado
        A = 16'hFF00; B = 16'h0F0F; ALUControl = 3'b011;
        #20;

        // 5. División: Cociente (101)
        A = 16'd200; B = 16'd3; ALUControl = 3'b101;
        #20; // Resultado esperado: 66

        // 6. División: Residuo (110)
        A = 16'd200; B = 16'd3; ALUControl = 3'b110;
        #20; // Resultado esperado: 2

        // 7. Todos en Cero (111)
        A = 16'hFFFF; B = 16'hFFFF; ALUControl = 3'b111;
        #20;

        // 8. Prueba de Flags (Zero y Negative)
        A = 16'd50; B = 16'd100; ALUControl = 3'b001; // 50 - 100 = -50 (Negativo)
        #20;

        $display("Simulación completada.");
        $finish;
    end

endmodule