`timescale 1ns / 1ps

module alu_sync_top #(parameter WIDTH = 16) (
    input  logic             clk,
    input  logic             rst,
    input  logic [WIDTH-1:0] A_in,
    input  logic [WIDTH-1:0] B_in,
    input  logic [2:0]       ALUControl_in,
    output logic [WIDTH-1:0] Result_out,
    output logic [3:0]       Flags_out
);

    // Registros intermedios de entrada
    logic [WIDTH-1:0] reg_A, reg_B;
    logic [2:0]       reg_ALUControl;

    // Cables internos desde la ALU combinacional a los registros de salida
    logic [WIDTH-1:0] alu_result;
    logic [3:0]       alu_flags;

    // Instancia de tu ALU+
    alu_plus #(WIDTH) alu_inst (
        .A(reg_A),
        .B(reg_B),
        .ALUControl(reg_ALUControl),
        .Result(alu_result),
        .Flags(alu_flags)
    );

    // Lógica Secuencial (Flip-Flops de entrada y salida)
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            reg_A          <= 0;
            reg_B          <= 0;
            reg_ALUControl <= 0;
            Result_out     <= 0;
            Flags_out      <= 0;
        end else begin
            // Captura síncrona de entradas
            reg_A          <= A_in;
            reg_B          <= B_in;
            reg_ALUControl <= ALUControl_in;
            
            // Captura síncrona de salidas
            Result_out     <= alu_result;
            Flags_out      <= alu_flags;
        end
    end

endmodule