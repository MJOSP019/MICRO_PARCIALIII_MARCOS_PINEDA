###################################################################

# Created by write_sdc on Mon Oct 26 19:17:42 2026

###################################################################
set sdc_version 2.2

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_load -pin_load 0.02 [get_ports {Result_out[15]}]
set_load -pin_load 0.02 [get_ports {Result_out[14]}]
set_load -pin_load 0.02 [get_ports {Result_out[13]}]
set_load -pin_load 0.02 [get_ports {Result_out[12]}]
set_load -pin_load 0.02 [get_ports {Result_out[11]}]
set_load -pin_load 0.02 [get_ports {Result_out[10]}]
set_load -pin_load 0.02 [get_ports {Result_out[9]}]
set_load -pin_load 0.02 [get_ports {Result_out[8]}]
set_load -pin_load 0.02 [get_ports {Result_out[7]}]
set_load -pin_load 0.02 [get_ports {Result_out[6]}]
set_load -pin_load 0.02 [get_ports {Result_out[5]}]
set_load -pin_load 0.02 [get_ports {Result_out[4]}]
set_load -pin_load 0.02 [get_ports {Result_out[3]}]
set_load -pin_load 0.02 [get_ports {Result_out[2]}]
set_load -pin_load 0.02 [get_ports {Result_out[1]}]
set_load -pin_load 0.02 [get_ports {Result_out[0]}]
set_load -pin_load 0.02 [get_ports {Flags_out[3]}]
set_load -pin_load 0.02 [get_ports {Flags_out[2]}]
set_load -pin_load 0.02 [get_ports {Flags_out[1]}]
set_load -pin_load 0.02 [get_ports {Flags_out[0]}]
create_clock [get_ports clk]  -period 70  -waveform {0 35}
set_clock_latency -source 0.5  [get_clocks clk]
set_clock_uncertainty -setup 7  [get_clocks clk]
set_clock_uncertainty -hold 0.05  [get_clocks clk]
set_clock_transition -min -fall 0.15 [get_clocks clk]
set_clock_transition -min -rise 0.15 [get_clocks clk]
set_clock_transition -max -fall 0.15 [get_clocks clk]
set_clock_transition -max -rise 0.15 [get_clocks clk]
group_path -name INREG  -from [list [get_ports clk] [get_ports rst] [get_ports {A_in[15]}] [get_ports \
{A_in[14]}] [get_ports {A_in[13]}] [get_ports {A_in[12]}] [get_ports           \
{A_in[11]}] [get_ports {A_in[10]}] [get_ports {A_in[9]}] [get_ports {A_in[8]}] \
[get_ports {A_in[7]}] [get_ports {A_in[6]}] [get_ports {A_in[5]}] [get_ports   \
{A_in[4]}] [get_ports {A_in[3]}] [get_ports {A_in[2]}] [get_ports {A_in[1]}]   \
[get_ports {A_in[0]}] [get_ports {B_in[15]}] [get_ports {B_in[14]}] [get_ports \
{B_in[13]}] [get_ports {B_in[12]}] [get_ports {B_in[11]}] [get_ports           \
{B_in[10]}] [get_ports {B_in[9]}] [get_ports {B_in[8]}] [get_ports {B_in[7]}]  \
[get_ports {B_in[6]}] [get_ports {B_in[5]}] [get_ports {B_in[4]}] [get_ports   \
{B_in[3]}] [get_ports {B_in[2]}] [get_ports {B_in[1]}] [get_ports {B_in[0]}]   \
[get_ports {ALUControl_in[2]}] [get_ports {ALUControl_in[1]}] [get_ports       \
{ALUControl_in[0]}]]
group_path -name REGOUT  -to [list [get_ports {Result_out[15]}] [get_ports {Result_out[14]}]           \
[get_ports {Result_out[13]}] [get_ports {Result_out[12]}] [get_ports           \
{Result_out[11]}] [get_ports {Result_out[10]}] [get_ports {Result_out[9]}]     \
[get_ports {Result_out[8]}] [get_ports {Result_out[7]}] [get_ports             \
{Result_out[6]}] [get_ports {Result_out[5]}] [get_ports {Result_out[4]}]       \
[get_ports {Result_out[3]}] [get_ports {Result_out[2]}] [get_ports             \
{Result_out[1]}] [get_ports {Result_out[0]}] [get_ports {Flags_out[3]}]        \
[get_ports {Flags_out[2]}] [get_ports {Flags_out[1]}] [get_ports               \
{Flags_out[0]}]]
group_path -name REGREG  -from [list [get_cells Result_out_reg_0_] [get_cells Result_out_reg_1_]       \
[get_cells Result_out_reg_2_] [get_cells Result_out_reg_3_] [get_cells         \
Result_out_reg_4_] [get_cells Result_out_reg_5_] [get_cells Result_out_reg_6_] \
[get_cells Result_out_reg_7_] [get_cells Result_out_reg_8_] [get_cells         \
Result_out_reg_9_] [get_cells Result_out_reg_10_] [get_cells                   \
Result_out_reg_11_] [get_cells Result_out_reg_12_] [get_cells                  \
Result_out_reg_13_] [get_cells Result_out_reg_14_] [get_cells                  \
Result_out_reg_15_] [get_cells reg_ALUControl_reg_0_] [get_cells               \
reg_ALUControl_reg_1_] [get_cells reg_ALUControl_reg_2_] [get_cells            \
reg_B_reg_0_] [get_cells reg_B_reg_1_] [get_cells reg_B_reg_2_] [get_cells     \
reg_B_reg_3_] [get_cells reg_B_reg_4_] [get_cells reg_B_reg_5_] [get_cells     \
reg_B_reg_6_] [get_cells reg_B_reg_7_] [get_cells reg_B_reg_8_] [get_cells     \
reg_B_reg_9_] [get_cells reg_B_reg_10_] [get_cells reg_B_reg_11_] [get_cells   \
reg_B_reg_12_] [get_cells reg_B_reg_13_] [get_cells reg_B_reg_14_] [get_cells  \
reg_B_reg_15_] [get_cells reg_A_reg_0_] [get_cells reg_A_reg_1_] [get_cells    \
reg_A_reg_2_] [get_cells reg_A_reg_3_] [get_cells reg_A_reg_4_] [get_cells     \
reg_A_reg_5_] [get_cells reg_A_reg_6_] [get_cells reg_A_reg_7_] [get_cells     \
reg_A_reg_8_] [get_cells reg_A_reg_9_] [get_cells reg_A_reg_10_] [get_cells    \
reg_A_reg_11_] [get_cells reg_A_reg_12_] [get_cells reg_A_reg_13_] [get_cells  \
reg_A_reg_14_] [get_cells reg_A_reg_15_] [get_cells Flags_out_reg_0_]          \
[get_cells Flags_out_reg_1_] [get_cells Flags_out_reg_2_] [get_cells           \
Flags_out_reg_3_]]  -to [list [get_cells Result_out_reg_0_] [get_cells Result_out_reg_1_]         \
[get_cells Result_out_reg_2_] [get_cells Result_out_reg_3_] [get_cells         \
Result_out_reg_4_] [get_cells Result_out_reg_5_] [get_cells Result_out_reg_6_] \
[get_cells Result_out_reg_7_] [get_cells Result_out_reg_8_] [get_cells         \
Result_out_reg_9_] [get_cells Result_out_reg_10_] [get_cells                   \
Result_out_reg_11_] [get_cells Result_out_reg_12_] [get_cells                  \
Result_out_reg_13_] [get_cells Result_out_reg_14_] [get_cells                  \
Result_out_reg_15_] [get_cells reg_ALUControl_reg_0_] [get_cells               \
reg_ALUControl_reg_1_] [get_cells reg_ALUControl_reg_2_] [get_cells            \
reg_B_reg_0_] [get_cells reg_B_reg_1_] [get_cells reg_B_reg_2_] [get_cells     \
reg_B_reg_3_] [get_cells reg_B_reg_4_] [get_cells reg_B_reg_5_] [get_cells     \
reg_B_reg_6_] [get_cells reg_B_reg_7_] [get_cells reg_B_reg_8_] [get_cells     \
reg_B_reg_9_] [get_cells reg_B_reg_10_] [get_cells reg_B_reg_11_] [get_cells   \
reg_B_reg_12_] [get_cells reg_B_reg_13_] [get_cells reg_B_reg_14_] [get_cells  \
reg_B_reg_15_] [get_cells reg_A_reg_0_] [get_cells reg_A_reg_1_] [get_cells    \
reg_A_reg_2_] [get_cells reg_A_reg_3_] [get_cells reg_A_reg_4_] [get_cells     \
reg_A_reg_5_] [get_cells reg_A_reg_6_] [get_cells reg_A_reg_7_] [get_cells     \
reg_A_reg_8_] [get_cells reg_A_reg_9_] [get_cells reg_A_reg_10_] [get_cells    \
reg_A_reg_11_] [get_cells reg_A_reg_12_] [get_cells reg_A_reg_13_] [get_cells  \
reg_A_reg_14_] [get_cells reg_A_reg_15_] [get_cells Flags_out_reg_0_]          \
[get_cells Flags_out_reg_1_] [get_cells Flags_out_reg_2_] [get_cells           \
Flags_out_reg_3_]]
set_input_delay -clock clk  -max 28  [get_ports rst]
set_input_delay -clock clk  -min 0.1  [get_ports rst]
set_input_delay -clock clk  -max 28  [get_ports {A_in[15]}]
set_input_delay -clock clk  -min 0.1  [get_ports {A_in[15]}]
set_input_delay -clock clk  -max 28  [get_ports {A_in[14]}]
set_input_delay -clock clk  -min 0.1  [get_ports {A_in[14]}]
set_input_delay -clock clk  -max 28  [get_ports {A_in[13]}]
set_input_delay -clock clk  -min 0.1  [get_ports {A_in[13]}]
set_input_delay -clock clk  -max 28  [get_ports {A_in[12]}]
set_input_delay -clock clk  -min 0.1  [get_ports {A_in[12]}]
set_input_delay -clock clk  -max 28  [get_ports {A_in[11]}]
set_input_delay -clock clk  -min 0.1  [get_ports {A_in[11]}]
set_input_delay -clock clk  -max 28  [get_ports {A_in[10]}]
set_input_delay -clock clk  -min 0.1  [get_ports {A_in[10]}]
set_input_delay -clock clk  -max 28  [get_ports {A_in[9]}]
set_input_delay -clock clk  -min 0.1  [get_ports {A_in[9]}]
set_input_delay -clock clk  -max 28  [get_ports {A_in[8]}]
set_input_delay -clock clk  -min 0.1  [get_ports {A_in[8]}]
set_input_delay -clock clk  -max 28  [get_ports {A_in[7]}]
set_input_delay -clock clk  -min 0.1  [get_ports {A_in[7]}]
set_input_delay -clock clk  -max 28  [get_ports {A_in[6]}]
set_input_delay -clock clk  -min 0.1  [get_ports {A_in[6]}]
set_input_delay -clock clk  -max 28  [get_ports {A_in[5]}]
set_input_delay -clock clk  -min 0.1  [get_ports {A_in[5]}]
set_input_delay -clock clk  -max 28  [get_ports {A_in[4]}]
set_input_delay -clock clk  -min 0.1  [get_ports {A_in[4]}]
set_input_delay -clock clk  -max 28  [get_ports {A_in[3]}]
set_input_delay -clock clk  -min 0.1  [get_ports {A_in[3]}]
set_input_delay -clock clk  -max 28  [get_ports {A_in[2]}]
set_input_delay -clock clk  -min 0.1  [get_ports {A_in[2]}]
set_input_delay -clock clk  -max 28  [get_ports {A_in[1]}]
set_input_delay -clock clk  -min 0.1  [get_ports {A_in[1]}]
set_input_delay -clock clk  -max 28  [get_ports {A_in[0]}]
set_input_delay -clock clk  -min 0.1  [get_ports {A_in[0]}]
set_input_delay -clock clk  -max 28  [get_ports {B_in[15]}]
set_input_delay -clock clk  -min 0.1  [get_ports {B_in[15]}]
set_input_delay -clock clk  -max 28  [get_ports {B_in[14]}]
set_input_delay -clock clk  -min 0.1  [get_ports {B_in[14]}]
set_input_delay -clock clk  -max 28  [get_ports {B_in[13]}]
set_input_delay -clock clk  -min 0.1  [get_ports {B_in[13]}]
set_input_delay -clock clk  -max 28  [get_ports {B_in[12]}]
set_input_delay -clock clk  -min 0.1  [get_ports {B_in[12]}]
set_input_delay -clock clk  -max 28  [get_ports {B_in[11]}]
set_input_delay -clock clk  -min 0.1  [get_ports {B_in[11]}]
set_input_delay -clock clk  -max 28  [get_ports {B_in[10]}]
set_input_delay -clock clk  -min 0.1  [get_ports {B_in[10]}]
set_input_delay -clock clk  -max 28  [get_ports {B_in[9]}]
set_input_delay -clock clk  -min 0.1  [get_ports {B_in[9]}]
set_input_delay -clock clk  -max 28  [get_ports {B_in[8]}]
set_input_delay -clock clk  -min 0.1  [get_ports {B_in[8]}]
set_input_delay -clock clk  -max 28  [get_ports {B_in[7]}]
set_input_delay -clock clk  -min 0.1  [get_ports {B_in[7]}]
set_input_delay -clock clk  -max 28  [get_ports {B_in[6]}]
set_input_delay -clock clk  -min 0.1  [get_ports {B_in[6]}]
set_input_delay -clock clk  -max 28  [get_ports {B_in[5]}]
set_input_delay -clock clk  -min 0.1  [get_ports {B_in[5]}]
set_input_delay -clock clk  -max 28  [get_ports {B_in[4]}]
set_input_delay -clock clk  -min 0.1  [get_ports {B_in[4]}]
set_input_delay -clock clk  -max 28  [get_ports {B_in[3]}]
set_input_delay -clock clk  -min 0.1  [get_ports {B_in[3]}]
set_input_delay -clock clk  -max 28  [get_ports {B_in[2]}]
set_input_delay -clock clk  -min 0.1  [get_ports {B_in[2]}]
set_input_delay -clock clk  -max 28  [get_ports {B_in[1]}]
set_input_delay -clock clk  -min 0.1  [get_ports {B_in[1]}]
set_input_delay -clock clk  -max 28  [get_ports {B_in[0]}]
set_input_delay -clock clk  -min 0.1  [get_ports {B_in[0]}]
set_input_delay -clock clk  -max 28  [get_ports {ALUControl_in[2]}]
set_input_delay -clock clk  -min 0.1  [get_ports {ALUControl_in[2]}]
set_input_delay -clock clk  -max 28  [get_ports {ALUControl_in[1]}]
set_input_delay -clock clk  -min 0.1  [get_ports {ALUControl_in[1]}]
set_input_delay -clock clk  -max 28  [get_ports {ALUControl_in[0]}]
set_input_delay -clock clk  -min 0.1  [get_ports {ALUControl_in[0]}]
set_output_delay -clock clk  -max 28  [get_ports {Result_out[15]}]
set_output_delay -clock clk  -min 0.1  [get_ports {Result_out[15]}]
set_output_delay -clock clk  -max 28  [get_ports {Result_out[14]}]
set_output_delay -clock clk  -min 0.1  [get_ports {Result_out[14]}]
set_output_delay -clock clk  -max 28  [get_ports {Result_out[13]}]
set_output_delay -clock clk  -min 0.1  [get_ports {Result_out[13]}]
set_output_delay -clock clk  -max 28  [get_ports {Result_out[12]}]
set_output_delay -clock clk  -min 0.1  [get_ports {Result_out[12]}]
set_output_delay -clock clk  -max 28  [get_ports {Result_out[11]}]
set_output_delay -clock clk  -min 0.1  [get_ports {Result_out[11]}]
set_output_delay -clock clk  -max 28  [get_ports {Result_out[10]}]
set_output_delay -clock clk  -min 0.1  [get_ports {Result_out[10]}]
set_output_delay -clock clk  -max 28  [get_ports {Result_out[9]}]
set_output_delay -clock clk  -min 0.1  [get_ports {Result_out[9]}]
set_output_delay -clock clk  -max 28  [get_ports {Result_out[8]}]
set_output_delay -clock clk  -min 0.1  [get_ports {Result_out[8]}]
set_output_delay -clock clk  -max 28  [get_ports {Result_out[7]}]
set_output_delay -clock clk  -min 0.1  [get_ports {Result_out[7]}]
set_output_delay -clock clk  -max 28  [get_ports {Result_out[6]}]
set_output_delay -clock clk  -min 0.1  [get_ports {Result_out[6]}]
set_output_delay -clock clk  -max 28  [get_ports {Result_out[5]}]
set_output_delay -clock clk  -min 0.1  [get_ports {Result_out[5]}]
set_output_delay -clock clk  -max 28  [get_ports {Result_out[4]}]
set_output_delay -clock clk  -min 0.1  [get_ports {Result_out[4]}]
set_output_delay -clock clk  -max 28  [get_ports {Result_out[3]}]
set_output_delay -clock clk  -min 0.1  [get_ports {Result_out[3]}]
set_output_delay -clock clk  -max 28  [get_ports {Result_out[2]}]
set_output_delay -clock clk  -min 0.1  [get_ports {Result_out[2]}]
set_output_delay -clock clk  -max 28  [get_ports {Result_out[1]}]
set_output_delay -clock clk  -min 0.1  [get_ports {Result_out[1]}]
set_output_delay -clock clk  -max 28  [get_ports {Result_out[0]}]
set_output_delay -clock clk  -min 0.1  [get_ports {Result_out[0]}]
set_output_delay -clock clk  -max 28  [get_ports {Flags_out[3]}]
set_output_delay -clock clk  -min 0.1  [get_ports {Flags_out[3]}]
set_output_delay -clock clk  -max 28  [get_ports {Flags_out[2]}]
set_output_delay -clock clk  -min 0.1  [get_ports {Flags_out[2]}]
set_output_delay -clock clk  -max 28  [get_ports {Flags_out[1]}]
set_output_delay -clock clk  -min 0.1  [get_ports {Flags_out[1]}]
set_output_delay -clock clk  -max 28  [get_ports {Flags_out[0]}]
set_output_delay -clock clk  -min 0.1  [get_ports {Flags_out[0]}]
