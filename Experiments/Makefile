# Makefile for Tang Nano 20K (Gowin GW2A-18C)
# Target board: Tang Nano 20K (Note: User mentioned 21K, but 20K is the standard)

BOARD  ?= tangnano20k
FAMILY ?= GW2A-18C
DEVICE ?= GW2AR-LV18QN88C8/I7

# Top module name
TOP ?= top_xor2_and3

# Source files
# VHDL files (Current project uses these)
VHDL_SRCS = and3_behav.vhd xor2_behav.vhd top_xor3_and.vhd

# SystemVerilog/Verilog files (Add your .sv files here)
VERILOG_SRCS = $(wildcard *.sv) $(wildcard *.v)

# Constraints file
CST = tangnano20k.cst

# Tools (Paths from oss-cad-suite)
YOSYS          = yosys
NEXTPNR        = nextpnr-himbaechel
GOWIN_PACK     = gowin_pack
OPENFPGALOADER = openFPGALoader

all: $(TOP).fs

# Synthesis
$(TOP).json: $(VHDL_SRCS) $(VERILOG_SRCS)
	@if [ -n "$(VHDL_SRCS)" ]; then \
		echo "Synthesizing VHDL and Verilog..."; \
		GHDL_PREFIX=/Users/hughsignoriello/fpga_tools/oss-cad-suite/lib/ghdl $(YOSYS) -m ghdl -p "ghdl --std=08 $(VHDL_SRCS) -e $(TOP); synth_gowin -json $@" ; \
	else \
		echo "Synthesizing Verilog/SystemVerilog..."; \
		$(YOSYS) -p "read_verilog -sv $(VERILOG_SRCS); synth_gowin -top $(TOP) -json $@" ; \
	fi

# Place and Route
$(TOP)_pnr.json: $(TOP).json $(CST)
	$(NEXTPNR) --json $< --write $@ --device $(DEVICE) --vopt family=$(FAMILY) --vopt cst=$(CST)

# Pack bitstream
$(TOP).fs: $(TOP)_pnr.json
	$(GOWIN_PACK) -d $(FAMILY) -o $@ $<

# Program board (SRAM)
flash: $(TOP).fs
	$(OPENFPGALOADER) -b $(BOARD) $<

# Program board (Flash)
flash-external: $(TOP).fs
	$(OPENFPGALOADER) -b $(BOARD) -f $<

clean:
	rm -f *.json *.fs

.PHONY: all flash flash-external clean
