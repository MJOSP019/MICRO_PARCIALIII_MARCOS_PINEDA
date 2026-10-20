`timescale 1ns / 1ps

module alu_plus #(parameter WIDTH = 8) (
    input  logic [WIDTH-1:0] A,
    input  logic [WIDTH-1:0] B,
    input  logic [2:0]       ALUControl, // Bus de 3 bits para acomodar nuevas funciones
    output logic [WIDTH-1:0] Result,
    output logic [3:0]       Flags       // {N, Z, C, V}
);

    // Señales internas
    logic [WIDTH-1:0] sum_res, and_res, or_res, div_quo, div_rem;
    logic Cout, overflow;
    logic [WIDTH-1:0] b_mux;

    // ---------------------------------------------------------
    // 1. Bus Tri-estado para AND y OR (Desconexión física)
    // ---------------------------------------------------------
    assign and_res = (ALUControl == 3'b010) ? (A & B) : {WIDTH{1'bz}};
    assign or_res  = (ALUControl == 3'b011) ? (A | B) : {WIDTH{1'bz}};

    // ---------------------------------------------------------
    // 2. Prefix Adder e Inversor de B para Resta
    // ---------------------------------------------------------
    assign b_mux = ALUControl[0] ? ~B : B; // ALUControl[0] maneja la resta
    
    prefix_adder #(WIDTH) adder_inst (
        .A(A),
        .B(b_mux),
        .Cin(ALUControl[0]),
        .Sum(sum_res),
        .Cout(Cout),
        .Overflow(overflow)
    );

    // ---------------------------------------------------------
    // 3. Divisor de Hardware
    // ---------------------------------------------------------
    divider_hw #(WIDTH) div_inst (
        .dividend(A),
        .divisor(B),
        .quotient(div_quo),
        .remainder(div_rem)
    );

    // ---------------------------------------------------------
    // 4. Multiplexor de Salida (Operador Ternario Nativo)
    // ---------------------------------------------------------
    assign Result = (ALUControl == 3'b000) ? sum_res : // Suma
                    (ALUControl == 3'b001) ? sum_res : // Resta
                    (ALUControl == 3'b010) ? and_res : // AND
                    (ALUControl == 3'b011) ? or_res  : // OR
                    (ALUControl == 3'b101) ? div_quo : // Cociente
                    (ALUControl == 3'b110) ? div_rem : // Residuo
                    (ALUControl == 3'b111) ? {WIDTH{1'b0}} : // Forzar a ceros
                    {WIDTH{1'b0}}; // Default

    // ---------------------------------------------------------
    // 5. Señales de Bandera (Flags: N, Z, C, V)
    // ---------------------------------------------------------
    assign Flags[3] = Result[WIDTH-1];                      // N: Negative
    assign Flags[2] = (Result == {WIDTH{1'b0}});            // Z: Zero
    assign Flags[1] = (ALUControl[1] == 1'b0) ? Cout : 1'b0;// C: Carry (solo suma/resta)
    assign Flags[0] = (ALUControl[1] == 1'b0) ? overflow : 1'b0; // V: Overflow

endmodule