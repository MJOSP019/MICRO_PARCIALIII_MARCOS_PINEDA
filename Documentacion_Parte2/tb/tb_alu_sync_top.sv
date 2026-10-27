`timescale 1ns / 1ps
// Testbench del sistema sincrono (registros de entrada + ALU+ + registros de salida)
// Latencia: el resultado aparece 2 flancos de reloj despues de aplicar las entradas.
module tb_alu_sync_top;

    localparam WIDTH = 16;

    logic             clk = 0;
    logic             rst;
    logic [WIDTH-1:0] A_in, B_in;
    logic [2:0]       ALUControl_in;
    logic [WIDTH-1:0] Result_out;
    logic [3:0]       Flags_out;

    int errores = 0;

    alu_sync_top #(WIDTH) dut (.*);

    always #5 clk = ~clk;   // 10 ns -> 100 MHz

    // Modelo de referencia del resultado
    function automatic logic [WIDTH-1:0] esperado(input logic [WIDTH-1:0] a, b, input logic [2:0] op);
        case (op)
            3'b000: esperado = a + b;
            3'b001: esperado = a - b;
            3'b010: esperado = a & b;
            3'b011: esperado = a | b;
            3'b101: esperado = (b == 0) ? '1 : a / b;
            3'b110: esperado = (b == 0) ? a  : a % b;
            default: esperado = '0;
        endcase
    endfunction

    task automatic probar(input logic [WIDTH-1:0] a, b, input logic [2:0] op, input string nombre);
        logic [WIDTH-1:0] exp;
        @(negedge clk);
        A_in = a; B_in = b; ALUControl_in = op;
        exp = esperado(a, b, op);
        repeat (2) @(posedge clk);
        #1;
        if (Result_out !== exp) begin
            $display("ERROR %-10s A=%0d B=%0d -> %0d (esperado %0d)", nombre, a, b, Result_out, exp);
            errores++;
        end else
            $display("OK    %-10s A=%0d B=%0d -> %0d  Flags NZCV=%b", nombre, a, b, Result_out, Flags_out);
    endtask

    initial begin
`ifdef FSDB
        $fsdbDumpfile("alu_sync_top.fsdb");
        $fsdbDumpvars(0, tb_alu_sync_top);
`endif
        $dumpfile("alu_sync_top.vcd");
        $dumpvars(0, tb_alu_sync_top);

        rst = 1; A_in = 0; B_in = 0; ALUControl_in = 0;
        repeat (2) @(posedge clk);
        rst = 0;

        probar(16'd150,  16'd50,   3'b000, "SUMA");
        probar(16'd150,  16'd50,   3'b001, "RESTA");
        probar(16'd50,   16'd100,  3'b001, "RESTA_NEG");
        probar(16'hFF00, 16'h0F0F, 3'b010, "AND");
        probar(16'hFF00, 16'h0F0F, 3'b011, "OR");
        probar(16'd200,  16'd3,    3'b101, "COCIENTE");
        probar(16'd200,  16'd3,    3'b110, "RESIDUO");
        probar(16'd200,  16'd0,    3'b101, "DIV_CERO");
        probar(16'hFFFF, 16'hFFFF, 3'b111, "CEROS");
        probar(16'h7FFF, 16'd1,    3'b000, "OVERFLOW");

        // Pruebas aleatorias
        repeat (20) probar($urandom, $urandom, 3'($urandom_range(0, 7)), "RANDOM");

        $display("==== Simulacion terminada: %0d errores ====", errores);
        $finish;
    end

endmodule
