#!/bin/bash
# Simulacion RTL con VCS y apertura en Verdi
# Uso (desde ~/parcial3_icc2):   bash scripts/sim_vcs.sh
mkdir -p sim && cd sim

vcs -full64 -sverilog -debug_access+all -kdb +define+FSDB \
    ../rtl/prefix_adder.sv ../rtl/divider_hw.sv ../rtl/alu_plus.sv ../rtl/alu_sync_top.sv \
    ../tb/tb_alu_sync_top.sv -top tb_alu_sync_top -o simv -l compile.log \
|| { echo "Fallo con FSDB, reintentando solo con VCD...";
     vcs -full64 -sverilog -debug_access+all -kdb \
        ../rtl/prefix_adder.sv ../rtl/divider_hw.sv ../rtl/alu_plus.sv ../rtl/alu_sync_top.sv \
        ../tb/tb_alu_sync_top.sv -top tb_alu_sync_top -o simv -l compile.log || exit 1; }

./simv -l sim.log

echo
echo "Para ver las ondas en Verdi:"
if [ -f alu_sync_top.fsdb ]; then
    echo "   cd sim && verdi -dbdir simv.daidir -ssf alu_sync_top.fsdb &"
else
    echo "   cd sim && vcd2fsdb alu_sync_top.vcd -o alu_sync_top.fsdb && verdi -dbdir simv.daidir -ssf alu_sync_top.fsdb &"
fi
