###############################################################################
# icc2_04_export.tcl - Fillers, verificaciones finales y exportacion (GDSII)
###############################################################################

set RPT reports/icc2/50_final
file mkdir $RPT

###############################################################################
# 1. Celdas de relleno M31 (de mayor a menor) y reconexion de alimentacion
###############################################################################
set FILLERS {}
foreach n {64 32 16 8 4 2 1} {
    set c [get_lib_cells -quiet */FILLER${n}TAS7]
    if {[sizeof_collection $c] > 0} { lappend FILLERS [get_object_name $c] }
}
if {[llength $FILLERS] > 0} {
    create_stdcell_fillers -lib_cells $FILLERS
    connect_pg_net -automatic
    catch { remove_stdcell_fillers_with_violation }
}

###############################################################################
# 2. Verificaciones finales (inciso 7.2.5)
###############################################################################
catch { redirect -file $RPT/check_routes.rpt            { check_routes } }
catch { redirect -file $RPT/check_legality.rpt          { check_legality } }
catch { redirect -file $RPT/check_pg_connectivity.rpt   { check_pg_connectivity } }
catch { redirect -file $RPT/check_pg_drc.rpt            { check_pg_drc } }
catch { redirect -file $RPT/check_lvs.rpt               { check_lvs } }
catch { redirect -file $RPT/report_qor.rpt              { report_qor } }
catch { redirect -file $RPT/report_constraints_viol.rpt { report_constraints -all_violators } }
catch { redirect -file $RPT/report_utilization.rpt      { report_utilization } }
catch { redirect -file $RPT/report_power.rpt            { report_power } }

save_block -as ${DESIGN}_final
save_lib

###############################################################################
# 3. Exportacion
###############################################################################
write_verilog outputs/${DESIGN}_final.v
catch { write_sdc -output outputs/${DESIGN}_final.sdc }
catch { write_def outputs/${DESIGN}_final.def }
catch { write_parasitics -output outputs/${DESIGN}_final }

# GDSII (la libreria no trae GDS de celdas: las celdas salen como contorno)
if {[catch { write_gds -hierarchy all -long_names -layer_map $GDS_MAP outputs/${DESIGN}.gds } err]} {
    puts "AVISO write_gds con layer_map: $err"
    write_gds -hierarchy all -long_names outputs/${DESIGN}.gds
}

puts "=================================================================="
puts " EXPORTACION OK -> outputs/${DESIGN}.gds  y  outputs/${DESIGN}_final.v"
puts " Base de datos final: alu_icc2.dlib  (bloque ${DESIGN}_final)"
puts "=================================================================="
