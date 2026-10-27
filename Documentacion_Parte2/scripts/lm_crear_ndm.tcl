# Convierte la libreria M31 (tf + db + lef) al formato NDM que usa ICC2
source scripts/rutas_pdk.tcl
file mkdir ndm
file delete -force $NDM_LIB

create_workspace -flow normal -technology $TECH_FILE M31LLSC750GL150MS
read_db  $DB_SS
read_lef $CELL_LEF
report_workspace
check_workspace
commit_workspace -force -output $NDM_LIB

if {[file exists $NDM_LIB]} {
    puts ">>> NDM CREADO OK: $NDM_LIB"
} else {
    puts ">>> NDM NO SE CREO - revisar errores arriba"
}
exit
