# FPGA Experiments

This directory contains experiments for FPGA development, targeting the **Tang Nano 20K** (Gowin GW2A-18C).

## Hardware Setup
- **Board:** Tang Nano 20K
- **FPGA:** GW2AR-LV18QN88C8/I7
- **Toolchain:** OSS CAD Suite (Yosys, nextpnr-himbaechel, gowin_pack, openFPGALoader)

## Using the Makefile

The provided `Makefile` automates the synthesis, PNR, and flashing process. It supports both **VHDL** and **SystemVerilog**.

### Compilation Commands

1. **Build the project:**
   ```bash
   make
   ```
   This will generate the bitstream (`.fs` file). By default, it uses the top module `top_xor2_and3`.

2. **Flash to SRAM (temporary):**
   ```bash
   make flash
   ```

3. **Flash to External Flash (persistent):**
   ```bash
   make flash-external
   ```

4. **Clean build artifacts:**
   ```bash
   make clean
   ```

### Customizing the Build

You can override variables from the command line:

- **Change Top Module:**
  ```bash
  make TOP=your_module_name
  ```

- **Target Different Board (e.g., Tang Nano 9K):**
  ```bash
  make BOARD=tangnano9k DEVICE=GW1NR-LV9QN88C6/I5 FAMILY=GW1N-9C
  ```

## Language Support

### SystemVerilog
To add SystemVerilog files, simply place your `.sv` files in this directory. The Makefile will automatically include them. If no VHDL files are detected, it will default to a SystemVerilog-only flow.

### VHDL
The current project uses VHDL. Synthesis is performed via the `ghdl` plugin for Yosys.

## Pin Constraints
Physical constraints are defined in `tangnano20k.cst`. Ensure your top-level port names match the names in this file.

- **Clock:** `i_clk` (mapped to H11)
- **LEDs:** `o_led[0:5]`
- **Buttons:** `i_sw[0:1]` (mapped to onboard S1, S2)
