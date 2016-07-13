# (C) 2001-2016 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and other 
# software and tools, and its AMPP partner logic functions, and any output 
# files any of the foregoing (including device programming or simulation 
# files), and any associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License Subscription 
# Agreement, Altera MegaCore Function License Agreement, or other applicable 
# license agreement, including, without limitation, that your use is for the 
# sole purpose of programming logic devices manufactured by Altera and sold by 
# Altera or its authorized distributors.  Please refer to the applicable 
# agreement for further details.


# $File: //acds/main/ip/avalon_st/altera_avalon_st_handshake_clock_crosser/altera_avalon_st_handshake_clock_crosser.sdc $
# $Revision: #1 $
# $Date: 2014/04/09 $
# $Author: kespence $
#------------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Altera timing constraints for Avalon clock domain crossing (CDC) paths.
# The purpose of these constraints is to remove the false paths and replace with timing bounded 
# requirements for compilation.
#
# ***Important note *** 
#
# The clocks involved in this transfer must be kept synchronous and no false path
# should be set on these paths for these constraints to apply correctly.
# -----------------------------------------------------------------------------

set temp_inst "altera_avalon_st_clock_crosser:"
set_net_delay -from [get_registers *${temp_inst}*|in_data_buffer* ] -to [get_registers *${temp_inst}*|out_data_buffer* ] -max 2
set_max_delay -from [get_registers *${temp_inst}*|in_data_buffer* ] -to [get_registers *${temp_inst}*|out_data_buffer* ] 100
set_min_delay -from [get_registers *${temp_inst}*|in_data_buffer* ] -to [get_registers *${temp_inst}*|out_data_buffer* ] -100

set temp_inst "altera_avalon_st_clock_crosser:*|altera_std_synchronizer_nocut:"
set_net_delay -from [get_registers * ] -to [get_registers *${temp_inst}*|din_s1 ] -max 2
set_max_delay -from [get_registers * ] -to [get_registers *${temp_inst}*|din_s1 ] 100
set_min_delay -from [get_registers * ] -to [get_registers *${temp_inst}*|din_s1 ] -100

# -----------------------------------------------------------------------------
# This procedure constrains the skew between the token and data bits, and should
# be called from the top level SDC, once per instance of the clock crosser.
#
# The hierarchy path to the handshake clock crosser instance is required as an 
# argument.
#
# In practice, the token and data bits tend to be placed close together, making
# excessive skew less of an issue.
# -----------------------------------------------------------------------------
proc constrain_alt_handshake_clock_crosser_skew { path } {

    set in_regs  [ get_registers $path|*altera_avalon_st_clock_crosser*|in_data_buffer* ] 
    set out_regs [ get_registers $path|*altera_avalon_st_clock_crosser*|out_data_buffer* ] 

    set in_regs [ add_to_collection $in_regs  [ get_registers $path|*altera_avalon_st_clock_crosser*|in_data_toggle ] ]
    set out_regs [ add_to_collection $out_regs [ get_registers $path|*altera_avalon_st_clock_crosser:*|altera_std_synchronizer_nocut:in_to_out_synchronizer|din_s1 ] ]

    set_max_skew -from $in_regs -to $out_regs 1.5 
}

