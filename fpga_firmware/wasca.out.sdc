## Generated SDC file "wasca.out.sdc"

## Copyright (C) 1991-2015 Altera Corporation. All rights reserved.
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, the Altera Quartus Prime License Agreement,
## the Altera MegaCore Function License Agreement, or other 
## applicable license agreement, including, without limitation, 
## that your use is for the sole purpose of programming logic 
## devices manufactured by Altera and sold by Altera or its 
## authorized distributors.  Please refer to the applicable 
## agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 15.1.0 Build 185 10/21/2015 SJ Lite Edition"

## DATE    "Sat Oct 24 19:48:44 2020"

##
## DEVICE  "10M08SAE144C8GES"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {altera_reserved_tck} -period 100.000 -waveform { 0.000 50.000 } [get_ports {altera_reserved_tck}]
create_clock -name {smpc_clk} -period 44.288 -waveform { 0.000 22.144 } [get_ports {clk_clk}]
create_clock -name {system_clk} -period 8.627 -waveform { 0.000 4.313 } [get_nets {my_little_wasca|altpll_1|sd1|wire_pll7_clk[0]}]


#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************



#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************

set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 


#**************************************************************
# Set False Path
#**************************************************************

set_false_path -to [get_keepers {*altera_std_synchronizer:*|din_s1}]
set_false_path -to [get_pins -nocase -compatibility_mode {*|alt_rst_sync_uq1|altera_reset_synchronizer_int_chain*|clrn}]
set_false_path -from [get_keepers {*wasca_nios2_gen2_0_cpu:*|wasca_nios2_gen2_0_cpu_nios2_oci:the_wasca_nios2_gen2_0_cpu_nios2_oci|wasca_nios2_gen2_0_cpu_nios2_oci_break:the_wasca_nios2_gen2_0_cpu_nios2_oci_break|break_readreg*}] -to [get_keepers {*wasca_nios2_gen2_0_cpu:*|wasca_nios2_gen2_0_cpu_nios2_oci:the_wasca_nios2_gen2_0_cpu_nios2_oci|wasca_nios2_gen2_0_cpu_debug_slave_wrapper:the_wasca_nios2_gen2_0_cpu_debug_slave_wrapper|wasca_nios2_gen2_0_cpu_debug_slave_tck:the_wasca_nios2_gen2_0_cpu_debug_slave_tck|*sr*}]
set_false_path -from [get_keepers {*wasca_nios2_gen2_0_cpu:*|wasca_nios2_gen2_0_cpu_nios2_oci:the_wasca_nios2_gen2_0_cpu_nios2_oci|wasca_nios2_gen2_0_cpu_nios2_oci_debug:the_wasca_nios2_gen2_0_cpu_nios2_oci_debug|*resetlatch}] -to [get_keepers {*wasca_nios2_gen2_0_cpu:*|wasca_nios2_gen2_0_cpu_nios2_oci:the_wasca_nios2_gen2_0_cpu_nios2_oci|wasca_nios2_gen2_0_cpu_debug_slave_wrapper:the_wasca_nios2_gen2_0_cpu_debug_slave_wrapper|wasca_nios2_gen2_0_cpu_debug_slave_tck:the_wasca_nios2_gen2_0_cpu_debug_slave_tck|*sr[33]}]
set_false_path -from [get_keepers {*wasca_nios2_gen2_0_cpu:*|wasca_nios2_gen2_0_cpu_nios2_oci:the_wasca_nios2_gen2_0_cpu_nios2_oci|wasca_nios2_gen2_0_cpu_nios2_ocimem:the_wasca_nios2_gen2_0_cpu_nios2_ocimem|*MonDReg*}] -to [get_keepers {*wasca_nios2_gen2_0_cpu:*|wasca_nios2_gen2_0_cpu_nios2_oci:the_wasca_nios2_gen2_0_cpu_nios2_oci|wasca_nios2_gen2_0_cpu_debug_slave_wrapper:the_wasca_nios2_gen2_0_cpu_debug_slave_wrapper|wasca_nios2_gen2_0_cpu_debug_slave_tck:the_wasca_nios2_gen2_0_cpu_debug_slave_tck|*sr*}]
set_false_path -from [get_keepers {*wasca_nios2_gen2_0_cpu:*|wasca_nios2_gen2_0_cpu_nios2_oci:the_wasca_nios2_gen2_0_cpu_nios2_oci|wasca_nios2_gen2_0_cpu_debug_slave_wrapper:the_wasca_nios2_gen2_0_cpu_debug_slave_wrapper|wasca_nios2_gen2_0_cpu_debug_slave_tck:the_wasca_nios2_gen2_0_cpu_debug_slave_tck|*sr*}] -to [get_keepers {*wasca_nios2_gen2_0_cpu:*|wasca_nios2_gen2_0_cpu_nios2_oci:the_wasca_nios2_gen2_0_cpu_nios2_oci|wasca_nios2_gen2_0_cpu_debug_slave_wrapper:the_wasca_nios2_gen2_0_cpu_debug_slave_wrapper|wasca_nios2_gen2_0_cpu_debug_slave_sysclk:the_wasca_nios2_gen2_0_cpu_debug_slave_sysclk|*jdo*}]
set_false_path -from [get_keepers {sld_hub:*|irf_reg*}] -to [get_keepers {*wasca_nios2_gen2_0_cpu:*|wasca_nios2_gen2_0_cpu_nios2_oci:the_wasca_nios2_gen2_0_cpu_nios2_oci|wasca_nios2_gen2_0_cpu_debug_slave_wrapper:the_wasca_nios2_gen2_0_cpu_debug_slave_wrapper|wasca_nios2_gen2_0_cpu_debug_slave_sysclk:the_wasca_nios2_gen2_0_cpu_debug_slave_sysclk|ir*}]
set_false_path -from [get_keepers {sld_hub:*|sld_shadow_jsm:shadow_jsm|state[1]}] -to [get_keepers {*wasca_nios2_gen2_0_cpu:*|wasca_nios2_gen2_0_cpu_nios2_oci:the_wasca_nios2_gen2_0_cpu_nios2_oci|wasca_nios2_gen2_0_cpu_nios2_oci_debug:the_wasca_nios2_gen2_0_cpu_nios2_oci_debug|monitor_go}]


#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************

set_max_delay -from [get_registers {*altera_avalon_st_clock_crosser:*|in_data_buffer*}] -to [get_registers {*altera_avalon_st_clock_crosser:*|out_data_buffer*}] 100.000
set_max_delay -from [get_registers *] -to [get_registers {*altera_avalon_st_clock_crosser:*|altera_std_synchronizer_nocut:*|din_s1}] 100.000


#**************************************************************
# Set Minimum Delay
#**************************************************************

set_min_delay -from [get_registers {*altera_avalon_st_clock_crosser:*|in_data_buffer*}] -to [get_registers {*altera_avalon_st_clock_crosser:*|out_data_buffer*}] -100.000
set_min_delay -from [get_registers *] -to [get_registers {*altera_avalon_st_clock_crosser:*|altera_std_synchronizer_nocut:*|din_s1}] -100.000


#**************************************************************
# Set Input Transition
#**************************************************************



#**************************************************************
# Set Net Delay
#**************************************************************

set_net_delay -max 2.000 -from [get_registers *] -to [get_registers {*altera_avalon_st_clock_crosser:*|altera_std_synchronizer_nocut:*|din_s1}]
set_net_delay -max 2.000 -from [get_registers {*altera_avalon_st_clock_crosser:*|in_data_buffer*}] -to [get_registers {*altera_avalon_st_clock_crosser:*|out_data_buffer*}]
