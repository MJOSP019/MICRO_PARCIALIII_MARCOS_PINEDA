###############################################################################
# alu_restricciones.sdc  -  Restricciones de timing de alu_sync_top (ALU+ 16 bits)
# Reloj de 10 ns (100 MHz), igual que el XDC usado en Vivado.
###############################################################################

set CLK_PERIOD 70.0

# Reloj principal
create_clock -name clk -period $CLK_PERIOD [get_ports clk]

# Incertidumbre (jitter + skew estimado antes de CTS)
set_clock_uncertainty -setup [expr {$CLK_PERIOD * 0.10}] [get_clocks clk]
set_clock_uncertainty -hold  0.05                        [get_clocks clk]

# Transicion y latencia estimadas del reloj (solo aplican mientras el reloj es ideal;
# despues de CTS ICC2 usa los valores reales del arbol)
set_clock_transition 0.15 [get_clocks clk]
set_clock_latency -source 0.5 [get_clocks clk]

# Retardos de entrada/salida: 40 % del periodo para el mundo externo
set DATA_IN [remove_from_collection [all_inputs] [get_ports clk]]

set_input_delay  -max [expr {$CLK_PERIOD * 0.4}] -clock clk $DATA_IN
set_input_delay  -min 0.1                        -clock clk $DATA_IN
set_output_delay -max [expr {$CLK_PERIOD * 0.4}] -clock clk [all_outputs]
set_output_delay -min 0.1                        -clock clk [all_outputs]

# Carga en las salidas (pF)
set_load 0.02 [all_outputs]

# Grupos de caminos para ver el "bottleneck" por separado en report_qor
group_path -name INREG  -from [all_inputs]
group_path -name REGOUT -to   [all_outputs]
group_path -name REGREG -from [all_registers] -to [all_registers]
