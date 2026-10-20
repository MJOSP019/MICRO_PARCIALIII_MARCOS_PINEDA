# Parcial 3: ALU+ y Flujo de Diseño Físico (ASIC Flow Emulado en Vivado)

**Estudiante:** Marcos Pineda (Carné: 16771)  
**Curso:** Arquitectura de Computadoras  
**Tecnología Objetivo:** AMD Artix-7 (xc7a35tcpg236-1)  

---

## 🎥 Video 
En el siguiente video se explica el diseño de la ALU+ en SystemVerilog, la simulación de comportamiento y el análisis del flujo de síntesis, tiempos y área utilizando Vivado:
**[Ver Video de Presentación (YouTube)](https://www.youtube.com/watch?v=1h812HtGHYY)**

---

## 📂 Contenido del Repositorio
* `hdl/`: Módulos SystemVerilog del diseño RTL (`alu_plus`, `prefix_adder`, `divider_hw`, `alu_sync_top`) y el Testbench.
* `scripts_and_constraints/`: Archivo de restricciones de reloj a 100 MHz (`timing_alu.xdc` equivalente a SDC).
* `evidencias_vivado/`: Capturas de simulación, esquemático RTL, esquemático sintetizado, y reportes de WNS y Critical Path.
* `Informe_Parcial3.docx`: Respuestas a la discusión técnica y análisis de resultados.

---

## 🛠️ Resumen de la Discusión Técnica

**1. Área y Celdas:**
El diseño consume un área total de **643 Slice LUTs** (lógica combinacional) y **54 Slice Registers** (Flip-Flops de sincronización).

**2. Reloj y Frecuencia:**
El sistema está restringido mediante el archivo XDC a un período de **10 ns**, lo que representa una frecuencia objetivo de **100 MHz**.

**3. Cumplimiento de Tiempos (WNS y TNS):**
El diseño **NO cumple** con el timing requerido. El reporte arroja un **WNS de -27.232 ns**, lo que significa que el retardo lógico excede por mucho los 10 ns permitidos por el reloj.

**4. Análisis de la Ruta Crítica (Critical Path):**
* **Startpoint:** `reg_B_reg[0]/C` (Registro de entrada)
* **Endpoint:** `Flags_out_reg[2]/D` (Registro de salida de bandera Zero)
* **Retardo:** 37.073 ns a través de 89 niveles lógicos (77 celdas CARRY4).

**5. Identificación del Cuello de Botella y Optimización:**
El mayor retraso es provocado por el **Divisor de Hardware combinacional**, que intenta calcular todas las restas y desplazamientos en un solo ciclo de reloj. La optimización necesaria es aplicar **Pipelining (Segmentación)**, insertando registros intermedios en la cascada del divisor para fracturar el camino crítico y permitir que el sistema alcance los 100 MHz.
