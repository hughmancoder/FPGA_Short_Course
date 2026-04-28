## Configuration options, can be used for all designs
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

## SPI configuration mode options for QSPI boot, can be used for all designs
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]


create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 2 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list i_clk_IBUF_BUFG]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 48 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {w_accum_data[0]} {w_accum_data[1]} {w_accum_data[2]} {w_accum_data[3]} {w_accum_data[4]} {w_accum_data[5]} {w_accum_data[6]} {w_accum_data[7]} {w_accum_data[8]} {w_accum_data[9]} {w_accum_data[10]} {w_accum_data[11]} {w_accum_data[12]} {w_accum_data[13]} {w_accum_data[14]} {w_accum_data[15]} {w_accum_data[16]} {w_accum_data[17]} {w_accum_data[18]} {w_accum_data[19]} {w_accum_data[20]} {w_accum_data[21]} {w_accum_data[22]} {w_accum_data[23]} {w_accum_data[24]} {w_accum_data[25]} {w_accum_data[26]} {w_accum_data[27]} {w_accum_data[28]} {w_accum_data[29]} {w_accum_data[30]} {w_accum_data[31]} {w_accum_data[32]} {w_accum_data[33]} {w_accum_data[34]} {w_accum_data[35]} {w_accum_data[36]} {w_accum_data[37]} {w_accum_data[38]} {w_accum_data[39]} {w_accum_data[40]} {w_accum_data[41]} {w_accum_data[42]} {w_accum_data[43]} {w_accum_data[44]} {w_accum_data[45]} {w_accum_data[46]} {w_accum_data[47]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 16 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {w_rom_data[0]} {w_rom_data[1]} {w_rom_data[2]} {w_rom_data[3]} {w_rom_data[4]} {w_rom_data[5]} {w_rom_data[6]} {w_rom_data[7]} {w_rom_data[8]} {w_rom_data[9]} {w_rom_data[10]} {w_rom_data[11]} {w_rom_data[12]} {w_rom_data[13]} {w_rom_data[14]} {w_rom_data[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 1 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {o_led_OBUF[9]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 10 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {w_count[0]} {w_count[1]} {w_count[2]} {w_count[3]} {w_count[4]} {w_count[5]} {w_count[6]} {w_count[7]} {w_count[8]} {w_count[9]}]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets i_clk_IBUF_BUFG]