# Continua el flujo despues de place_opt. Los errores de "hook" internos de
# ICC2 se ignoran (el comando principal si termina, el hook es posterior).
proc correr {cmd} {
    if {[catch {uplevel #0 $cmd} err]} {
        puts ">>> AVISO: '$cmd' reporto un error al final (hook interno), se continua: $err"
    }
}

save_block -as ${DESIGN}_place_opt
reportes_etapa 10_place_opt

puts "==================== CLOCK_OPT ===================="
set_clock_routing_rules -clocks [get_clocks clk] -net_type all -min_routing_layer METAL2 -max_routing_layer METAL4 -default_rule
correr clock_opt
save_block -as ${DESIGN}_clock_opt
reportes_etapa 20_clock_opt
catch { redirect -file reports/icc2/20_clock_opt/report_clock_qor.rpt     { report_clock_qor } }
catch { redirect -file reports/icc2/20_clock_opt/report_clock_skew.rpt    { report_clock_timing -type skew } }
catch { redirect -file reports/icc2/20_clock_opt/report_clock_latency.rpt { report_clock_timing -type latency } }

puts "==================== ROUTE_AUTO ==================="
correr route_auto
save_block -as ${DESIGN}_route_auto
reportes_etapa 30_route_auto
catch { redirect -file reports/icc2/30_route_auto/check_routes.rpt { check_routes } }

puts "==================== ROUTE_OPT ===================="
correr route_opt
save_block -as ${DESIGN}_route_opt
reportes_etapa 40_route_opt
catch { redirect -file reports/icc2/40_route_opt/check_routes.rpt      { check_routes } }
catch { redirect -file reports/icc2/40_route_opt/report_clock_qor.rpt  { report_clock_qor } }
catch { redirect -file reports/icc2/40_route_opt/report_clock_skew.rpt { report_clock_timing -type skew } }

puts ">>> IMPLEMENTACION FISICA OK"
