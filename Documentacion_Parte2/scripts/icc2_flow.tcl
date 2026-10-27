###############################################################################
# icc2_flow.tcl - Flujo completo de ICC2 (corre las 4 etapas en orden)
#
# Uso (desde ~/parcial3_icc2):
#     icc2_shell -f scripts/icc2_flow.tcl | tee logs/icc2.log
#
# Si algo falla, puedes correr etapa por etapa dentro de icc2_shell:
#     source scripts/icc2_01_setup.tcl
#     source scripts/icc2_02_floorplan.tcl
#     source scripts/icc2_03_impl.tcl
#     source scripts/icc2_04_export.tcl
###############################################################################

source -echo scripts/icc2_01_setup.tcl
source -echo scripts/icc2_02_floorplan.tcl
source -echo scripts/icc2_03_impl.tcl
source -echo scripts/icc2_04_export.tcl

puts ""
puts ">>> FLUJO COMPLETO. Para ver el layout escribe:  start_gui"
