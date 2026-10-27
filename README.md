# Parcial 3: ALU+ y Flujo de Diseño Físico (Vivado + Synopsys DC/ICC2)

**Estudiante:** Marcos Pineda (Carné: 16771)  
**Curso:** Arquitectura de Computadoras — Universidad del Istmo  

| Parte | Herramientas | Tecnología |
|---|---|---|
| Parte 1 — HDL + ALU + Adders | Vivado | AMD Artix-7 (xc7a35tcpg236-1) |
| Parte 2 — Physical Design | VCS, Verdi, Design Compiler, IC Compiler II | M31LLSC750GL150MS (0.15 µm, ASIC) |

---

## 🎥 Videos

| Inciso | Video |
|---|---|
| ALU+ en SystemVerilog, simulación y análisis en Vivado | **[Ver video (YouTube)](https://www.youtube.com/watch?v=1h812HtGHYY)** |

---

## 📂 Contenido del Repositorio

### Parte 1 (Vivado)
* `hdl/`: Módulos SystemVerilog del diseño RTL (`alu_plus`, `prefix_adder`, `divider_hw`, `alu_sync_top`) y el Testbench.
* `scripts_and_constraints/`: Restricción de reloj a 100 MHz (`timing_alu.xdc`).
* `evidencias_vivado/`: Capturas de simulación, esquemáticos y reportes de WNS y Critical Path.
* `Informe_Parcial3.docx`: Discusión técnica de la Parte 1.

### Parte 2 (Synopsys: RTL → GDSII)
* `rtl/`: RTL usado en el flujo ASIC (ALU+ instanciada a 16 bits con registros de entrada y salida).
* `tb/`: Testbench autoverificable del sistema síncrono (`tb_alu_sync_top.sv`).
* `sim/`: Log de VCS (`sim.log`, 0 errores) y ondas para Verdi (`alu_sync_top.fsdb`).
* `scripts/`: Tcl de Design Compiler, Library Manager e ICC2; UPF; ITF/TLU+ generado.
* `sdc/`: Restricciones de timing.
* `netlists/`: Netlist de DC y netlist final de ICC2.
* `gds/`: GDSII final (`alu_sync_top.gds`).
* `reportes/`: Reportes de DC (10 ns y 70 ns) e ICC2 por etapa.
* `icc2_db.zip`: Base de datos final de ICC2.
* `docs/Informe_Parcial3_Parte2.docx`: Informe y discusión técnica de la Parte 2.

---

## 🛠️ Parte 1 — Resumen (Vivado, Artix-7)

**1. Área y Celdas:** **643 Slice LUTs** (lógica combinacional) y **54 Slice Registers**.

**2. Reloj y Frecuencia:** **10 ns → 100 MHz** (archivo XDC).

**3. Cumplimiento de Tiempos:** **NO cumple**: **WNS = −27.232 ns**.

**4. Ruta Crítica:**
* **Startpoint:** `reg_B_reg[0]/C` (registro de entrada)
* **Endpoint:** `Flags_out_reg[2]/D` (bandera Zero)
* **Retardo:** 37.073 ns, 89 niveles lógicos (77 celdas CARRY4).

**5. Cuello de botella y optimización:** el **divisor combinacional** calcula todas las restas en un solo ciclo. La solución es **pipelining**: registros intermedios en la cascada del divisor.

---

## 🛠️ Parte 2 — Resumen (Synopsys, ASIC 0.15 µm)

### Verificación (VCS + Verdi)
30 pruebas (10 dirigidas + 20 aleatorias) con modelo de referencia: **0 errores**. El resultado aparece **2 ciclos de reloj** después de aplicar las entradas (registro de entrada + registro de salida).

### Síntesis (Design Compiler)

| Métrica | T = 10 ns | T = 70 ns |
|---|---|---|
| Frecuencia objetivo | 100 MHz | 14.29 MHz |
| Área de celdas | 72,947 µm² | **62,452 µm²** |
| Celdas | 5,231 | **4,712** (55 flip-flops) |
| Ruta crítica (REGREG) | 54.20 ns | 61.74 ns |
| WNS / TNS | −46.43 / −820.75 ns | **0.00 / 0.00 ns** ✅ |

* **Ruta crítica:** `reg_B_reg[3]` → `Flags_out_reg[2]` (bandera Z), grupo **REGREG**, 79 niveles lógicos.
* **Cuello de botella:** el divisor ocupa el **89 % del área** y el **91 % del retardo** de la ruta crítica.
* Como el divisor no cabe en 10 ns, el diseño se implementó físicamente a **70 ns**.

### Diseño físico (IC Compiler II)

| Etapa | Setup WNS (ns) | Hold WNS (ns) | Área (µm²) |
|---|---|---|---|
| DC (70 ns) | 0.00 | 0.00 | 62,452 |
| place_opt | −9.80 | −0.23 | 71,778 |
| clock_opt | −2.48 | −0.26 | 71,562 |
| route_auto | −2.59 | −0.18 | 71,562 |
| route_opt | **−2.28** | **+0.06** ✅ | **72,158** |

* **Floorplan:** utilización 0.40, core de ~394 × 394 µm, malla de potencia en METAL4/METAL5.
* **Árbol de reloj:** 55 sinks, 7 niveles, 25 buffers; el *useful skew* mejoró el setup de −9.8 a −2.5 ns.
* **Área:** +15.5 % respecto a DC por buffers, upsizing y el árbol de reloj.
* **Verificación física:** 0 nets abiertas, 0 shorts, 0 DRC; legalidad y red de alimentación correctas.
* **Frecuencia efectiva:** 1000 / (70 + 2.28) ≈ **13.8 MHz**.
* **Buses triestado:** DC los implementó con **32 inversores triestado (TRIINVX1TAS7)**.

### Cómo reproducir

```bash
bash scripts/sim_vcs.sh                              # VCS + Verdi
dc_shell -f scripts/dc_alu.tcl                       # síntesis
icc2_lm_shell -f scripts/lm_crear_ndm.tcl            # librería NDM
icc2_shell -f scripts/icc2_flow.tcl                  # diseño físico + GDSII
```

> La librería M31 es comercial y no se incluye en este repositorio. Las rutas se configuran en `scripts/rutas_pdk.tcl`.
> La librería no incluía modelo de parásitos (TLU+); se generó uno con `grdgenxo` a partir de los grosores reales del LEF y valores típicos de 0.15 µm (ver informe).
