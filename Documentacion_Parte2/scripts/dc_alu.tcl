###############################################################################
# dc_alu.tcl  -  Sintesis de alu_sync_top (ALU+ 16 bits) con Design Compiler
#
# Uso (desde ~/parcial3_icc2):
#     dc_shell -f scripts/dc_alu.tcl | tee logs/dc.log
#
# IMPORTANTE: se sintetiza con la libreria SkyWater 130 (sky130_fd_sc_hd), la
# MISMA que usa ICC2. Si se sintetiza con class.db, ICC2 no reconoce las celdas
# de la netlist y el diseno fisico falla.
###############################################################################

source scripts/rutas_pdk.tcl

set DESIGN alu_sync_top
file mkdir reports/dc
file mkdir outputs
file mkdir work

###############################################################################
# 1. Librerias
###############################################################################
set_app_var search_path       ". ./rtl [file dirname $DB_SS] $search_path"
set_app_var synthetic_library dw_foundation.sldb
set_app_var target_library    $DB_SS
set_app_var link_library      "* $DB_SS $synthetic_library"

if {$DB_FF ne ""} {
    set_min_library $DB_SS -min_version $DB_FF
}

# Celdas especiales de sky130 que no queremos (tienen pines de alimentacion extra)

# Los archivos intermedios de analyze van a ./work (no ensucian la carpeta)
define_design_lib WORK -path ./work

set_svf outputs/${DESIGN}.svf

###############################################################################
# 2. Lectura del RTL  (WIDTH = 16 es el default de alu_sync_top)
###############################################################################
analyze -format sverilog {
    rtl/prefix_adder.sv
    rtl/divider_hw.sv
    rtl/alu_plus.sv
    rtl/alu_sync_top.sv
}

elaborate $DESIGN
current_design $DESIGN
link

redirect -file reports/dc/check_design.rpt { check_design }

# Corner de operacion (si los nombres no coinciden con la libreria, solo avisa)
if {[catch {
} err]} { puts "AVISO set_operating_conditions: $err" }

###############################################################################
# 3. Restricciones (SDC)
###############################################################################
source scripts/alu_restricciones.sdc

###############################################################################
# 4. Compilacion
###############################################################################
# Evita puertos conectados directo a constantes / feedthroughs (problemas en ICC2)
set_fix_multiple_port_nets -all -buffer_constants

compile_ultra -no_autoungroup
compile_ultra -incremental

###############################################################################
# 5. Reportes que pide el parcial
###############################################################################
redirect -file reports/dc/report_qor.rpt            { report_qor }
redirect -file reports/dc/report_timing.rpt         { report_timing -max_paths 10 -input_pins -nets -transition_time -capacitance }
redirect -file reports/dc/report_timing_hold.rpt    { report_timing -delay_type min -max_paths 5 }
redirect -file reports/dc/report_area.rpt           { report_area }
redirect -file reports/dc/report_area_hier.rpt      { report_area -hierarchy }
redirect -file reports/dc/report_power.rpt          { report_power }
redirect -file reports/dc/report_constraint_viol.rpt { report_constraint -all_violators }
redirect -file reports/dc/report_reference.rpt      { report_reference -hierarchy }
redirect -file reports/dc/report_clock.rpt          { report_clock }

###############################################################################
# 6. Salidas para ICC2
###############################################################################
change_names -rules verilog -hierarchy
set_app_var verilogout_no_tri true

write_file -format verilog -hierarchy -output outputs/${DESIGN}.v
write_file -format ddc     -hierarchy -output outputs/${DESIGN}.ddc
write_sdc  outputs/${DESIGN}.sdc

set_svf -off

puts "=================================================================="
puts " DC TERMINADO. Netlist: outputs/${DESIGN}.v   SDC: outputs/${DESIGN}.sdc"
puts " Reportes en reports/dc/"
puts "=================================================================="
exit
