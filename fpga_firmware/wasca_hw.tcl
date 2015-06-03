package require -exact qsys 14.0

# module properties
set_module_property NAME {wasca_export}
set_module_property DISPLAY_NAME {wasca_export_display}

# default module properties
set_module_property VERSION {1.0}
set_module_property GROUP {default group}
set_module_property DESCRIPTION {default description}
set_module_property AUTHOR {author}

set_module_property COMPOSITION_CALLBACK compose
set_module_property opaque_address_map false

proc compose { } {
    # Instances and instance parameters
    # (disabled instances are intentionally culled)
    add_instance altpll_0 altpll 14.1
    set_instance_parameter_value altpll_0 {HIDDEN_CUSTOM_ELABORATION} {altpll_avalon_elaboration}
    set_instance_parameter_value altpll_0 {HIDDEN_CUSTOM_POST_EDIT} {altpll_avalon_post_edit}
    set_instance_parameter_value altpll_0 {INTENDED_DEVICE_FAMILY} {MAX 10}
    set_instance_parameter_value altpll_0 {WIDTH_CLOCK} {5}
    set_instance_parameter_value altpll_0 {WIDTH_PHASECOUNTERSELECT} {}
    set_instance_parameter_value altpll_0 {PRIMARY_CLOCK} {}
    set_instance_parameter_value altpll_0 {INCLK0_INPUT_FREQUENCY} {125000}
    set_instance_parameter_value altpll_0 {INCLK1_INPUT_FREQUENCY} {}
    set_instance_parameter_value altpll_0 {OPERATION_MODE} {NORMAL}
    set_instance_parameter_value altpll_0 {PLL_TYPE} {AUTO}
    set_instance_parameter_value altpll_0 {QUALIFY_CONF_DONE} {}
    set_instance_parameter_value altpll_0 {COMPENSATE_CLOCK} {CLK0}
    set_instance_parameter_value altpll_0 {SCAN_CHAIN} {}
    set_instance_parameter_value altpll_0 {GATE_LOCK_SIGNAL} {}
    set_instance_parameter_value altpll_0 {GATE_LOCK_COUNTER} {}
    set_instance_parameter_value altpll_0 {LOCK_HIGH} {}
    set_instance_parameter_value altpll_0 {LOCK_LOW} {}
    set_instance_parameter_value altpll_0 {VALID_LOCK_MULTIPLIER} {}
    set_instance_parameter_value altpll_0 {INVALID_LOCK_MULTIPLIER} {}
    set_instance_parameter_value altpll_0 {SWITCH_OVER_ON_LOSSCLK} {}
    set_instance_parameter_value altpll_0 {SWITCH_OVER_ON_GATED_LOCK} {}
    set_instance_parameter_value altpll_0 {ENABLE_SWITCH_OVER_COUNTER} {}
    set_instance_parameter_value altpll_0 {SKIP_VCO} {}
    set_instance_parameter_value altpll_0 {SWITCH_OVER_COUNTER} {}
    set_instance_parameter_value altpll_0 {SWITCH_OVER_TYPE} {}
    set_instance_parameter_value altpll_0 {FEEDBACK_SOURCE} {}
    set_instance_parameter_value altpll_0 {BANDWIDTH} {}
    set_instance_parameter_value altpll_0 {BANDWIDTH_TYPE} {AUTO}
    set_instance_parameter_value altpll_0 {SPREAD_FREQUENCY} {}
    set_instance_parameter_value altpll_0 {DOWN_SPREAD} {}
    set_instance_parameter_value altpll_0 {SELF_RESET_ON_GATED_LOSS_LOCK} {}
    set_instance_parameter_value altpll_0 {SELF_RESET_ON_LOSS_LOCK} {}
    set_instance_parameter_value altpll_0 {CLK0_MULTIPLY_BY} {16}
    set_instance_parameter_value altpll_0 {CLK1_MULTIPLY_BY} {}
    set_instance_parameter_value altpll_0 {CLK2_MULTIPLY_BY} {}
    set_instance_parameter_value altpll_0 {CLK3_MULTIPLY_BY} {}
    set_instance_parameter_value altpll_0 {CLK4_MULTIPLY_BY} {}
    set_instance_parameter_value altpll_0 {CLK5_MULTIPLY_BY} {}
    set_instance_parameter_value altpll_0 {CLK6_MULTIPLY_BY} {}
    set_instance_parameter_value altpll_0 {CLK7_MULTIPLY_BY} {}
    set_instance_parameter_value altpll_0 {CLK8_MULTIPLY_BY} {}
    set_instance_parameter_value altpll_0 {CLK9_MULTIPLY_BY} {}
    set_instance_parameter_value altpll_0 {EXTCLK0_MULTIPLY_BY} {}
    set_instance_parameter_value altpll_0 {EXTCLK1_MULTIPLY_BY} {}
    set_instance_parameter_value altpll_0 {EXTCLK2_MULTIPLY_BY} {}
    set_instance_parameter_value altpll_0 {EXTCLK3_MULTIPLY_BY} {}
    set_instance_parameter_value altpll_0 {CLK0_DIVIDE_BY} {1}
    set_instance_parameter_value altpll_0 {CLK1_DIVIDE_BY} {}
    set_instance_parameter_value altpll_0 {CLK2_DIVIDE_BY} {}
    set_instance_parameter_value altpll_0 {CLK3_DIVIDE_BY} {}
    set_instance_parameter_value altpll_0 {CLK4_DIVIDE_BY} {}
    set_instance_parameter_value altpll_0 {CLK5_DIVIDE_BY} {}
    set_instance_parameter_value altpll_0 {CLK6_DIVIDE_BY} {}
    set_instance_parameter_value altpll_0 {CLK7_DIVIDE_BY} {}
    set_instance_parameter_value altpll_0 {CLK8_DIVIDE_BY} {}
    set_instance_parameter_value altpll_0 {CLK9_DIVIDE_BY} {}
    set_instance_parameter_value altpll_0 {EXTCLK0_DIVIDE_BY} {}
    set_instance_parameter_value altpll_0 {EXTCLK1_DIVIDE_BY} {}
    set_instance_parameter_value altpll_0 {EXTCLK2_DIVIDE_BY} {}
    set_instance_parameter_value altpll_0 {EXTCLK3_DIVIDE_BY} {}
    set_instance_parameter_value altpll_0 {CLK0_PHASE_SHIFT} {0}
    set_instance_parameter_value altpll_0 {CLK1_PHASE_SHIFT} {}
    set_instance_parameter_value altpll_0 {CLK2_PHASE_SHIFT} {}
    set_instance_parameter_value altpll_0 {CLK3_PHASE_SHIFT} {}
    set_instance_parameter_value altpll_0 {CLK4_PHASE_SHIFT} {}
    set_instance_parameter_value altpll_0 {CLK5_PHASE_SHIFT} {}
    set_instance_parameter_value altpll_0 {CLK6_PHASE_SHIFT} {}
    set_instance_parameter_value altpll_0 {CLK7_PHASE_SHIFT} {}
    set_instance_parameter_value altpll_0 {CLK8_PHASE_SHIFT} {}
    set_instance_parameter_value altpll_0 {CLK9_PHASE_SHIFT} {}
    set_instance_parameter_value altpll_0 {EXTCLK0_PHASE_SHIFT} {}
    set_instance_parameter_value altpll_0 {EXTCLK1_PHASE_SHIFT} {}
    set_instance_parameter_value altpll_0 {EXTCLK2_PHASE_SHIFT} {}
    set_instance_parameter_value altpll_0 {EXTCLK3_PHASE_SHIFT} {}
    set_instance_parameter_value altpll_0 {CLK0_DUTY_CYCLE} {50}
    set_instance_parameter_value altpll_0 {CLK1_DUTY_CYCLE} {}
    set_instance_parameter_value altpll_0 {CLK2_DUTY_CYCLE} {}
    set_instance_parameter_value altpll_0 {CLK3_DUTY_CYCLE} {}
    set_instance_parameter_value altpll_0 {CLK4_DUTY_CYCLE} {}
    set_instance_parameter_value altpll_0 {CLK5_DUTY_CYCLE} {}
    set_instance_parameter_value altpll_0 {CLK6_DUTY_CYCLE} {}
    set_instance_parameter_value altpll_0 {CLK7_DUTY_CYCLE} {}
    set_instance_parameter_value altpll_0 {CLK8_DUTY_CYCLE} {}
    set_instance_parameter_value altpll_0 {CLK9_DUTY_CYCLE} {}
    set_instance_parameter_value altpll_0 {EXTCLK0_DUTY_CYCLE} {}
    set_instance_parameter_value altpll_0 {EXTCLK1_DUTY_CYCLE} {}
    set_instance_parameter_value altpll_0 {EXTCLK2_DUTY_CYCLE} {}
    set_instance_parameter_value altpll_0 {EXTCLK3_DUTY_CYCLE} {}
    set_instance_parameter_value altpll_0 {PORT_clkena0} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_clkena1} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_clkena2} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_clkena3} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_clkena4} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_clkena5} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_extclkena0} {}
    set_instance_parameter_value altpll_0 {PORT_extclkena1} {}
    set_instance_parameter_value altpll_0 {PORT_extclkena2} {}
    set_instance_parameter_value altpll_0 {PORT_extclkena3} {}
    set_instance_parameter_value altpll_0 {PORT_extclk0} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_extclk1} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_extclk2} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_extclk3} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_CLKBAD0} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_CLKBAD1} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_clk0} {PORT_USED}
    set_instance_parameter_value altpll_0 {PORT_clk1} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_clk2} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_clk3} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_clk4} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_clk5} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_clk6} {}
    set_instance_parameter_value altpll_0 {PORT_clk7} {}
    set_instance_parameter_value altpll_0 {PORT_clk8} {}
    set_instance_parameter_value altpll_0 {PORT_clk9} {}
    set_instance_parameter_value altpll_0 {PORT_SCANDATA} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_SCANDATAOUT} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_SCANDONE} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_SCLKOUT1} {}
    set_instance_parameter_value altpll_0 {PORT_SCLKOUT0} {}
    set_instance_parameter_value altpll_0 {PORT_ACTIVECLOCK} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_CLKLOSS} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_INCLK1} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_INCLK0} {PORT_USED}
    set_instance_parameter_value altpll_0 {PORT_FBIN} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_PLLENA} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_CLKSWITCH} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_ARESET} {PORT_USED}
    set_instance_parameter_value altpll_0 {PORT_PFDENA} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_SCANCLK} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_SCANACLR} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_SCANREAD} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_SCANWRITE} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_ENABLE0} {}
    set_instance_parameter_value altpll_0 {PORT_ENABLE1} {}
    set_instance_parameter_value altpll_0 {PORT_LOCKED} {PORT_USED}
    set_instance_parameter_value altpll_0 {PORT_CONFIGUPDATE} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_FBOUT} {}
    set_instance_parameter_value altpll_0 {PORT_PHASEDONE} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_PHASESTEP} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_PHASEUPDOWN} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_SCANCLKENA} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_PHASECOUNTERSELECT} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_VCOOVERRANGE} {}
    set_instance_parameter_value altpll_0 {PORT_VCOUNDERRANGE} {}
    set_instance_parameter_value altpll_0 {DPA_MULTIPLY_BY} {}
    set_instance_parameter_value altpll_0 {DPA_DIVIDE_BY} {}
    set_instance_parameter_value altpll_0 {DPA_DIVIDER} {}
    set_instance_parameter_value altpll_0 {VCO_MULTIPLY_BY} {}
    set_instance_parameter_value altpll_0 {VCO_DIVIDE_BY} {}
    set_instance_parameter_value altpll_0 {SCLKOUT0_PHASE_SHIFT} {}
    set_instance_parameter_value altpll_0 {SCLKOUT1_PHASE_SHIFT} {}
    set_instance_parameter_value altpll_0 {VCO_FREQUENCY_CONTROL} {}
    set_instance_parameter_value altpll_0 {VCO_PHASE_SHIFT_STEP} {}
    set_instance_parameter_value altpll_0 {USING_FBMIMICBIDIR_PORT} {}
    set_instance_parameter_value altpll_0 {SCAN_CHAIN_MIF_FILE} {}
    set_instance_parameter_value altpll_0 {AVALON_USE_SEPARATE_SYSCLK} {NO}
    set_instance_parameter_value altpll_0 {HIDDEN_CONSTANTS} {CT#PORT_clk5 PORT_UNUSED CT#PORT_clk4 PORT_UNUSED CT#PORT_clk3 PORT_UNUSED CT#PORT_clk2 PORT_UNUSED CT#PORT_clk1 PORT_UNUSED CT#PORT_clk0 PORT_USED CT#CLK0_MULTIPLY_BY 16 CT#PORT_SCANWRITE PORT_UNUSED CT#PORT_SCANACLR PORT_UNUSED CT#PORT_PFDENA PORT_UNUSED CT#PORT_PLLENA PORT_UNUSED CT#PORT_SCANDATA PORT_UNUSED CT#PORT_SCANCLKENA PORT_UNUSED CT#WIDTH_CLOCK 5 CT#PORT_SCANDATAOUT PORT_UNUSED CT#LPM_TYPE altpll CT#PLL_TYPE AUTO CT#CLK0_PHASE_SHIFT 0 CT#PORT_PHASEDONE PORT_UNUSED CT#OPERATION_MODE NORMAL CT#PORT_CONFIGUPDATE PORT_UNUSED CT#COMPENSATE_CLOCK CLK0 CT#PORT_CLKSWITCH PORT_UNUSED CT#INCLK0_INPUT_FREQUENCY 125000 CT#PORT_SCANDONE PORT_UNUSED CT#PORT_CLKLOSS PORT_UNUSED CT#PORT_INCLK1 PORT_UNUSED CT#AVALON_USE_SEPARATE_SYSCLK NO CT#PORT_INCLK0 PORT_USED CT#PORT_clkena5 PORT_UNUSED CT#PORT_clkena4 PORT_UNUSED CT#PORT_clkena3 PORT_UNUSED CT#PORT_clkena2 PORT_UNUSED CT#PORT_clkena1 PORT_UNUSED CT#PORT_clkena0 PORT_UNUSED CT#PORT_ARESET PORT_USED CT#BANDWIDTH_TYPE AUTO CT#INTENDED_DEVICE_FAMILY {MAX 10} CT#PORT_SCANREAD PORT_UNUSED CT#PORT_PHASESTEP PORT_UNUSED CT#PORT_SCANCLK PORT_UNUSED CT#PORT_CLKBAD1 PORT_UNUSED CT#PORT_CLKBAD0 PORT_UNUSED CT#PORT_FBIN PORT_UNUSED CT#PORT_PHASEUPDOWN PORT_UNUSED CT#PORT_extclk3 PORT_UNUSED CT#PORT_extclk2 PORT_UNUSED CT#PORT_extclk1 PORT_UNUSED CT#PORT_PHASECOUNTERSELECT PORT_UNUSED CT#PORT_extclk0 PORT_UNUSED CT#PORT_ACTIVECLOCK PORT_UNUSED CT#CLK0_DUTY_CYCLE 50 CT#CLK0_DIVIDE_BY 1 CT#PORT_LOCKED PORT_USED}
    set_instance_parameter_value altpll_0 {HIDDEN_PRIVATES} {PT#GLOCKED_FEATURE_ENABLED 0 PT#SPREAD_FEATURE_ENABLED 0 PT#BANDWIDTH_FREQ_UNIT MHz PT#CUR_DEDICATED_CLK c0 PT#INCLK0_FREQ_EDIT 8.000 PT#BANDWIDTH_PRESET Low PT#PLL_LVDS_PLL_CHECK 0 PT#BANDWIDTH_USE_PRESET 0 PT#AVALON_USE_SEPARATE_SYSCLK NO PT#PLL_ENHPLL_CHECK 0 PT#OUTPUT_FREQ_UNIT0 MHz PT#PHASE_RECONFIG_FEATURE_ENABLED 1 PT#CREATE_CLKBAD_CHECK 0 PT#CLKSWITCH_CHECK 0 PT#INCLK1_FREQ_EDIT 100.000 PT#NORMAL_MODE_RADIO 1 PT#SRC_SYNCH_COMP_RADIO 0 PT#PLL_ARESET_CHECK 1 PT#LONG_SCAN_RADIO 1 PT#SCAN_FEATURE_ENABLED 1 PT#PHASE_RECONFIG_INPUTS_CHECK 0 PT#USE_CLK0 1 PT#PRIMARY_CLK_COMBO inclk0 PT#BANDWIDTH 1.000 PT#GLOCKED_COUNTER_EDIT_CHANGED 1 PT#PLL_FASTPLL_CHECK 0 PT#SPREAD_FREQ_UNIT KHz PT#PLL_AUTOPLL_CHECK 1 PT#LVDS_PHASE_SHIFT_UNIT0 deg PT#SWITCHOVER_FEATURE_ENABLED 0 PT#MIG_DEVICE_SPEED_GRADE Any PT#OUTPUT_FREQ_MODE0 1 PT#BANDWIDTH_FEATURE_ENABLED 1 PT#INCLK0_FREQ_UNIT_COMBO MHz PT#ZERO_DELAY_RADIO 0 PT#OUTPUT_FREQ0 128.00000000 PT#SHORT_SCAN_RADIO 0 PT#LVDS_MODE_DATA_RATE_DIRTY 0 PT#CUR_FBIN_CLK c0 PT#PLL_ADVANCED_PARAM_CHECK 0 PT#CLKBAD_SWITCHOVER_CHECK 0 PT#PHASE_SHIFT_STEP_ENABLED_CHECK 0 PT#DEVICE_SPEED_GRADE Any PT#PLL_FBMIMIC_CHECK 0 PT#LVDS_MODE_DATA_RATE {Not Available} PT#LOCKED_OUTPUT_CHECK 1 PT#SPREAD_PERCENT 0.500 PT#PHASE_SHIFT0 0.00000000 PT#DIV_FACTOR0 1 PT#CNX_NO_COMPENSATE_RADIO 0 PT#USE_CLKENA0 0 PT#CREATE_INCLK1_CHECK 0 PT#GLOCK_COUNTER_EDIT 1048575 PT#INCLK1_FREQ_UNIT_COMBO MHz PT#EFF_OUTPUT_FREQ_VALUE0 128.000000 PT#SPREAD_FREQ 50.000 PT#USE_MIL_SPEED_GRADE 0 PT#EXPLICIT_SWITCHOVER_COUNTER 0 PT#STICKY_CLK0 1 PT#EXT_FEEDBACK_RADIO 0 PT#MIRROR_CLK0 0 PT#SWITCHOVER_COUNT_EDIT 1 PT#SELF_RESET_LOCK_LOSS 0 PT#PLL_PFDENA_CHECK 0 PT#INT_FEEDBACK__MODE_RADIO 1 PT#INCLK1_FREQ_EDIT_CHANGED 1 PT#CLKLOSS_CHECK 0 PT#SYNTH_WRAPPER_GEN_POSTFIX 0 PT#PHASE_SHIFT_UNIT0 deg PT#BANDWIDTH_USE_AUTO 1 PT#HAS_MANUAL_SWITCHOVER 1 PT#MULT_FACTOR0 1 PT#SPREAD_USE 0 PT#GLOCKED_MODE_CHECK 0 PT#SACN_INPUTS_CHECK 0 PT#DUTY_CYCLE0 50.00000000 PT#INTENDED_DEVICE_FAMILY {MAX 10} PT#PLL_TARGET_HARCOPY_CHECK 0 PT#INCLK1_FREQ_UNIT_CHANGED 1 PT#RECONFIG_FILE ALTPLL1432240190565494.mif PT#ACTIVECLK_CHECK 0}
    set_instance_parameter_value altpll_0 {HIDDEN_USED_PORTS} {UP#locked used UP#c0 used UP#areset used UP#inclk0 used}
    set_instance_parameter_value altpll_0 {HIDDEN_IS_NUMERIC} {IN#WIDTH_CLOCK 1 IN#CLK0_DUTY_CYCLE 1 IN#PLL_TARGET_HARCOPY_CHECK 1 IN#SWITCHOVER_COUNT_EDIT 1 IN#INCLK0_INPUT_FREQUENCY 1 IN#PLL_LVDS_PLL_CHECK 1 IN#PLL_AUTOPLL_CHECK 1 IN#PLL_FASTPLL_CHECK 1 IN#PLL_ENHPLL_CHECK 1 IN#DIV_FACTOR0 1 IN#LVDS_MODE_DATA_RATE_DIRTY 1 IN#GLOCK_COUNTER_EDIT 1 IN#CLK0_DIVIDE_BY 1 IN#MULT_FACTOR0 1 IN#CLK0_MULTIPLY_BY 1 IN#USE_MIL_SPEED_GRADE 1}
    set_instance_parameter_value altpll_0 {HIDDEN_MF_PORTS} {MF#areset 1 MF#clk 1 MF#locked 1 MF#inclk 1}
    set_instance_parameter_value altpll_0 {HIDDEN_IF_PORTS} {IF#locked {output 0} IF#reset {input 0} IF#clk {input 0} IF#readdata {output 32} IF#write {input 0} IF#phasedone {output 0} IF#address {input 2} IF#c0 {output 0} IF#writedata {input 32} IF#read {input 0} IF#areset {input 0}}
    set_instance_parameter_value altpll_0 {HIDDEN_IS_FIRST_EDIT} {0}

    add_instance clk_0 clock_source 14.1
    set_instance_parameter_value clk_0 {clockFrequency} {8000000.0}
    set_instance_parameter_value clk_0 {clockFrequencyKnown} {1}
    set_instance_parameter_value clk_0 {resetSynchronousEdges} {NONE}

    add_instance external_sdram_controller altera_avalon_new_sdram_controller 14.1
    set_instance_parameter_value external_sdram_controller {TAC} {5.5}
    set_instance_parameter_value external_sdram_controller {TRCD} {20.0}
    set_instance_parameter_value external_sdram_controller {TRFC} {70.0}
    set_instance_parameter_value external_sdram_controller {TRP} {20.0}
    set_instance_parameter_value external_sdram_controller {TWR} {14.0}
    set_instance_parameter_value external_sdram_controller {casLatency} {3}
    set_instance_parameter_value external_sdram_controller {columnWidth} {10}
    set_instance_parameter_value external_sdram_controller {dataWidth} {16}
    set_instance_parameter_value external_sdram_controller {generateSimulationModel} {0}
    set_instance_parameter_value external_sdram_controller {initRefreshCommands} {2}
    set_instance_parameter_value external_sdram_controller {model} {single_Micron_MT48LC4M32B2_7_chip}
    set_instance_parameter_value external_sdram_controller {numberOfBanks} {2}
    set_instance_parameter_value external_sdram_controller {numberOfChipSelects} {1}
    set_instance_parameter_value external_sdram_controller {pinsSharedViaTriState} {0}
    set_instance_parameter_value external_sdram_controller {powerUpDelay} {100.0}
    set_instance_parameter_value external_sdram_controller {refreshPeriod} {15.625}
    set_instance_parameter_value external_sdram_controller {rowWidth} {13}
    set_instance_parameter_value external_sdram_controller {masteredTristateBridgeSlave} {0}
    set_instance_parameter_value external_sdram_controller {TMRD} {3.0}
    set_instance_parameter_value external_sdram_controller {initNOPDelay} {0.0}
    set_instance_parameter_value external_sdram_controller {registerDataIn} {1}

    add_instance nios2_gen2_0 altera_nios2_gen2 14.1
    set_instance_parameter_value nios2_gen2_0 {tmr_enabled} {0}
    set_instance_parameter_value nios2_gen2_0 {setting_disable_tmr_inj} {0}
    set_instance_parameter_value nios2_gen2_0 {setting_showUnpublishedSettings} {0}
    set_instance_parameter_value nios2_gen2_0 {setting_showInternalSettings} {0}
    set_instance_parameter_value nios2_gen2_0 {setting_preciseIllegalMemAccessException} {0}
    set_instance_parameter_value nios2_gen2_0 {setting_exportPCB} {0}
    set_instance_parameter_value nios2_gen2_0 {setting_exportdebuginfo} {0}
    set_instance_parameter_value nios2_gen2_0 {setting_clearXBitsLDNonBypass} {1}
    set_instance_parameter_value nios2_gen2_0 {setting_bigEndian} {0}
    set_instance_parameter_value nios2_gen2_0 {setting_export_large_RAMs} {0}
    set_instance_parameter_value nios2_gen2_0 {setting_asic_enabled} {0}
    set_instance_parameter_value nios2_gen2_0 {setting_asic_synopsys_translate_on_off} {0}
    set_instance_parameter_value nios2_gen2_0 {setting_asic_third_party_synthesis} {0}
    set_instance_parameter_value nios2_gen2_0 {setting_asic_add_scan_mode_input} {0}
    set_instance_parameter_value nios2_gen2_0 {setting_oci_version} {1}
    set_instance_parameter_value nios2_gen2_0 {setting_fast_register_read} {0}
    set_instance_parameter_value nios2_gen2_0 {setting_exportHostDebugPort} {0}
    set_instance_parameter_value nios2_gen2_0 {setting_oci_export_jtag_signals} {0}
    set_instance_parameter_value nios2_gen2_0 {setting_avalonDebugPortPresent} {0}
    set_instance_parameter_value nios2_gen2_0 {setting_alwaysEncrypt} {1}
    set_instance_parameter_value nios2_gen2_0 {io_regionbase} {0}
    set_instance_parameter_value nios2_gen2_0 {io_regionsize} {0}
    set_instance_parameter_value nios2_gen2_0 {setting_support31bitdcachebypass} {1}
    set_instance_parameter_value nios2_gen2_0 {setting_activateTrace} {0}
    set_instance_parameter_value nios2_gen2_0 {setting_allow_break_inst} {0}
    set_instance_parameter_value nios2_gen2_0 {setting_activateTestEndChecker} {0}
    set_instance_parameter_value nios2_gen2_0 {setting_ecc_sim_test_ports} {0}
    set_instance_parameter_value nios2_gen2_0 {setting_disableocitrace} {0}
    set_instance_parameter_value nios2_gen2_0 {setting_activateMonitors} {1}
    set_instance_parameter_value nios2_gen2_0 {setting_HDLSimCachesCleared} {1}
    set_instance_parameter_value nios2_gen2_0 {setting_HBreakTest} {0}
    set_instance_parameter_value nios2_gen2_0 {setting_breakslaveoveride} {0}
    set_instance_parameter_value nios2_gen2_0 {mpu_useLimit} {0}
    set_instance_parameter_value nios2_gen2_0 {mpu_enabled} {0}
    set_instance_parameter_value nios2_gen2_0 {mmu_enabled} {0}
    set_instance_parameter_value nios2_gen2_0 {mmu_autoAssignTlbPtrSz} {1}
    set_instance_parameter_value nios2_gen2_0 {cpuReset} {0}
    set_instance_parameter_value nios2_gen2_0 {resetrequest_enabled} {1}
    set_instance_parameter_value nios2_gen2_0 {setting_removeRAMinit} {0}
    set_instance_parameter_value nios2_gen2_0 {setting_shadowRegisterSets} {0}
    set_instance_parameter_value nios2_gen2_0 {mpu_numOfInstRegion} {8}
    set_instance_parameter_value nios2_gen2_0 {mpu_numOfDataRegion} {8}
    set_instance_parameter_value nios2_gen2_0 {mmu_TLBMissExcOffset} {0}
    set_instance_parameter_value nios2_gen2_0 {resetOffset} {0}
    set_instance_parameter_value nios2_gen2_0 {exceptionOffset} {32}
    set_instance_parameter_value nios2_gen2_0 {cpuID} {0}
    set_instance_parameter_value nios2_gen2_0 {breakOffset} {32}
    set_instance_parameter_value nios2_gen2_0 {userDefinedSettings} {}
    set_instance_parameter_value nios2_gen2_0 {tracefilename} {}
    set_instance_parameter_value nios2_gen2_0 {resetSlave} {onchip_memory2_0.s1}
    set_instance_parameter_value nios2_gen2_0 {mmu_TLBMissExcSlave} {None}
    set_instance_parameter_value nios2_gen2_0 {exceptionSlave} {onchip_memory2_0.s1}
    set_instance_parameter_value nios2_gen2_0 {breakSlave} {None}
    set_instance_parameter_value nios2_gen2_0 {setting_interruptControllerType} {Internal}
    set_instance_parameter_value nios2_gen2_0 {setting_branchpredictiontype} {Dynamic}
    set_instance_parameter_value nios2_gen2_0 {setting_bhtPtrSz} {8}
    set_instance_parameter_value nios2_gen2_0 {cpuArchRev} {1}
    set_instance_parameter_value nios2_gen2_0 {mul_shift_choice} {0}
    set_instance_parameter_value nios2_gen2_0 {mul_32_impl} {2}
    set_instance_parameter_value nios2_gen2_0 {mul_64_impl} {0}
    set_instance_parameter_value nios2_gen2_0 {shift_rot_impl} {1}
    set_instance_parameter_value nios2_gen2_0 {dividerType} {no_div}
    set_instance_parameter_value nios2_gen2_0 {mpu_minInstRegionSize} {12}
    set_instance_parameter_value nios2_gen2_0 {mpu_minDataRegionSize} {12}
    set_instance_parameter_value nios2_gen2_0 {mmu_uitlbNumEntries} {4}
    set_instance_parameter_value nios2_gen2_0 {mmu_udtlbNumEntries} {6}
    set_instance_parameter_value nios2_gen2_0 {mmu_tlbPtrSz} {7}
    set_instance_parameter_value nios2_gen2_0 {mmu_tlbNumWays} {16}
    set_instance_parameter_value nios2_gen2_0 {mmu_processIDNumBits} {8}
    set_instance_parameter_value nios2_gen2_0 {impl} {Tiny}
    set_instance_parameter_value nios2_gen2_0 {icache_size} {4096}
    set_instance_parameter_value nios2_gen2_0 {fa_cache_line} {2}
    set_instance_parameter_value nios2_gen2_0 {fa_cache_linesize} {0}
    set_instance_parameter_value nios2_gen2_0 {icache_tagramBlockType} {Automatic}
    set_instance_parameter_value nios2_gen2_0 {icache_ramBlockType} {Automatic}
    set_instance_parameter_value nios2_gen2_0 {icache_numTCIM} {0}
    set_instance_parameter_value nios2_gen2_0 {icache_burstType} {None}
    set_instance_parameter_value nios2_gen2_0 {dcache_bursts} {false}
    set_instance_parameter_value nios2_gen2_0 {dcache_victim_buf_impl} {ram}
    set_instance_parameter_value nios2_gen2_0 {dcache_size} {2048}
    set_instance_parameter_value nios2_gen2_0 {dcache_tagramBlockType} {Automatic}
    set_instance_parameter_value nios2_gen2_0 {dcache_ramBlockType} {Automatic}
    set_instance_parameter_value nios2_gen2_0 {dcache_numTCDM} {0}
    set_instance_parameter_value nios2_gen2_0 {setting_exportvectors} {0}
    set_instance_parameter_value nios2_gen2_0 {setting_usedesignware} {0}
    set_instance_parameter_value nios2_gen2_0 {setting_ecc_present} {0}
    set_instance_parameter_value nios2_gen2_0 {setting_ic_ecc_present} {1}
    set_instance_parameter_value nios2_gen2_0 {setting_rf_ecc_present} {1}
    set_instance_parameter_value nios2_gen2_0 {setting_mmu_ecc_present} {1}
    set_instance_parameter_value nios2_gen2_0 {setting_dc_ecc_present} {1}
    set_instance_parameter_value nios2_gen2_0 {setting_itcm_ecc_present} {1}
    set_instance_parameter_value nios2_gen2_0 {setting_dtcm_ecc_present} {1}
    set_instance_parameter_value nios2_gen2_0 {regfile_ramBlockType} {Automatic}
    set_instance_parameter_value nios2_gen2_0 {ocimem_ramBlockType} {Automatic}
    set_instance_parameter_value nios2_gen2_0 {ocimem_ramInit} {0}
    set_instance_parameter_value nios2_gen2_0 {mmu_ramBlockType} {Automatic}
    set_instance_parameter_value nios2_gen2_0 {bht_ramBlockType} {Automatic}
    set_instance_parameter_value nios2_gen2_0 {cdx_enabled} {0}
    set_instance_parameter_value nios2_gen2_0 {mpx_enabled} {0}
    set_instance_parameter_value nios2_gen2_0 {debug_enabled} {1}
    set_instance_parameter_value nios2_gen2_0 {debug_triggerArming} {1}
    set_instance_parameter_value nios2_gen2_0 {debug_debugReqSignals} {0}
    set_instance_parameter_value nios2_gen2_0 {debug_assignJtagInstanceID} {0}
    set_instance_parameter_value nios2_gen2_0 {debug_jtagInstanceID} {0}
    set_instance_parameter_value nios2_gen2_0 {debug_OCIOnchipTrace} {_128}
    set_instance_parameter_value nios2_gen2_0 {debug_hwbreakpoint} {0}
    set_instance_parameter_value nios2_gen2_0 {debug_datatrigger} {0}
    set_instance_parameter_value nios2_gen2_0 {debug_traceType} {none}
    set_instance_parameter_value nios2_gen2_0 {debug_traceStorage} {onchip_trace}
    set_instance_parameter_value nios2_gen2_0 {master_addr_map} {0}
    set_instance_parameter_value nios2_gen2_0 {instruction_master_paddr_base} {0}
    set_instance_parameter_value nios2_gen2_0 {instruction_master_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2_0 {flash_instruction_master_paddr_base} {0}
    set_instance_parameter_value nios2_gen2_0 {flash_instruction_master_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2_0 {data_master_paddr_base} {0}
    set_instance_parameter_value nios2_gen2_0 {data_master_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2_0 {tightly_coupled_instruction_master_0_paddr_base} {0}
    set_instance_parameter_value nios2_gen2_0 {tightly_coupled_instruction_master_0_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2_0 {tightly_coupled_instruction_master_1_paddr_base} {0}
    set_instance_parameter_value nios2_gen2_0 {tightly_coupled_instruction_master_1_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2_0 {tightly_coupled_instruction_master_2_paddr_base} {0}
    set_instance_parameter_value nios2_gen2_0 {tightly_coupled_instruction_master_2_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2_0 {tightly_coupled_instruction_master_3_paddr_base} {0}
    set_instance_parameter_value nios2_gen2_0 {tightly_coupled_instruction_master_3_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2_0 {tightly_coupled_data_master_0_paddr_base} {0}
    set_instance_parameter_value nios2_gen2_0 {tightly_coupled_data_master_0_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2_0 {tightly_coupled_data_master_1_paddr_base} {0}
    set_instance_parameter_value nios2_gen2_0 {tightly_coupled_data_master_1_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2_0 {tightly_coupled_data_master_2_paddr_base} {0}
    set_instance_parameter_value nios2_gen2_0 {tightly_coupled_data_master_2_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2_0 {tightly_coupled_data_master_3_paddr_base} {0}
    set_instance_parameter_value nios2_gen2_0 {tightly_coupled_data_master_3_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2_0 {instruction_master_high_performance_paddr_base} {0}
    set_instance_parameter_value nios2_gen2_0 {instruction_master_high_performance_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2_0 {data_master_high_performance_paddr_base} {0}
    set_instance_parameter_value nios2_gen2_0 {data_master_high_performance_paddr_size} {0.0}

    add_instance onchip_memory2_0 altera_avalon_onchip_memory2 14.1
    set_instance_parameter_value onchip_memory2_0 {allowInSystemMemoryContentEditor} {0}
    set_instance_parameter_value onchip_memory2_0 {blockType} {AUTO}
    set_instance_parameter_value onchip_memory2_0 {dataWidth} {32}
    set_instance_parameter_value onchip_memory2_0 {dualPort} {0}
    set_instance_parameter_value onchip_memory2_0 {initMemContent} {1}
    set_instance_parameter_value onchip_memory2_0 {initializationFileName} {onchip_mem.hex}
    set_instance_parameter_value onchip_memory2_0 {instanceID} {NONE}
    set_instance_parameter_value onchip_memory2_0 {memorySize} {4096.0}
    set_instance_parameter_value onchip_memory2_0 {readDuringWriteMode} {DONT_CARE}
    set_instance_parameter_value onchip_memory2_0 {simAllowMRAMContentsFile} {0}
    set_instance_parameter_value onchip_memory2_0 {simMemInitOnlyFilename} {0}
    set_instance_parameter_value onchip_memory2_0 {singleClockOperation} {0}
    set_instance_parameter_value onchip_memory2_0 {slave1Latency} {1}
    set_instance_parameter_value onchip_memory2_0 {slave2Latency} {1}
    set_instance_parameter_value onchip_memory2_0 {useNonDefaultInitFile} {0}
    set_instance_parameter_value onchip_memory2_0 {copyInitFile} {0}
    set_instance_parameter_value onchip_memory2_0 {useShallowMemBlocks} {0}
    set_instance_parameter_value onchip_memory2_0 {writable} {0}
    set_instance_parameter_value onchip_memory2_0 {ecc_enabled} {0}
    set_instance_parameter_value onchip_memory2_0 {resetrequest_enabled} {1}

    add_instance pio_0 altera_avalon_pio 14.1
    set_instance_parameter_value pio_0 {bitClearingEdgeCapReg} {0}
    set_instance_parameter_value pio_0 {bitModifyingOutReg} {0}
    set_instance_parameter_value pio_0 {captureEdge} {0}
    set_instance_parameter_value pio_0 {direction} {Bidir}
    set_instance_parameter_value pio_0 {edgeType} {RISING}
    set_instance_parameter_value pio_0 {generateIRQ} {0}
    set_instance_parameter_value pio_0 {irqType} {LEVEL}
    set_instance_parameter_value pio_0 {resetValue} {0.0}
    set_instance_parameter_value pio_0 {simDoTestBenchWiring} {0}
    set_instance_parameter_value pio_0 {simDrivenValue} {0.0}
    set_instance_parameter_value pio_0 {width} {4}

    add_instance sd_card_spi altera_avalon_spi 14.1
    set_instance_parameter_value sd_card_spi {clockPhase} {0}
    set_instance_parameter_value sd_card_spi {clockPolarity} {0}
    set_instance_parameter_value sd_card_spi {dataWidth} {8}
    set_instance_parameter_value sd_card_spi {disableAvalonFlowControl} {0}
    set_instance_parameter_value sd_card_spi {insertDelayBetweenSlaveSelectAndSClk} {0}
    set_instance_parameter_value sd_card_spi {insertSync} {0}
    set_instance_parameter_value sd_card_spi {lsbOrderedFirst} {0}
    set_instance_parameter_value sd_card_spi {masterSPI} {1}
    set_instance_parameter_value sd_card_spi {numberOfSlaves} {1}
    set_instance_parameter_value sd_card_spi {syncRegDepth} {2}
    set_instance_parameter_value sd_card_spi {targetClockRate} {128000.0}
    set_instance_parameter_value sd_card_spi {targetSlaveSelectToSClkDelay} {0.0}

    add_instance sega_saturn_abus_slave_0 sega_saturn_abus_slave 1.0

    # connections and connection parameters
    add_connection sega_saturn_abus_slave_0.avalon_master external_sdram_controller.s1 avalon
    set_connection_parameter_value sega_saturn_abus_slave_0.avalon_master/external_sdram_controller.s1 arbitrationPriority {1}
    set_connection_parameter_value sega_saturn_abus_slave_0.avalon_master/external_sdram_controller.s1 baseAddress {0x0000}
    set_connection_parameter_value sega_saturn_abus_slave_0.avalon_master/external_sdram_controller.s1 defaultConnection {0}

    add_connection nios2_gen2_0.data_master nios2_gen2_0.debug_mem_slave avalon
    set_connection_parameter_value nios2_gen2_0.data_master/nios2_gen2_0.debug_mem_slave arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2_0.data_master/nios2_gen2_0.debug_mem_slave baseAddress {0x0800}
    set_connection_parameter_value nios2_gen2_0.data_master/nios2_gen2_0.debug_mem_slave defaultConnection {0}

    add_connection nios2_gen2_0.data_master altpll_0.pll_slave avalon
    set_connection_parameter_value nios2_gen2_0.data_master/altpll_0.pll_slave arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2_0.data_master/altpll_0.pll_slave baseAddress {0x3000}
    set_connection_parameter_value nios2_gen2_0.data_master/altpll_0.pll_slave defaultConnection {0}

    add_connection nios2_gen2_0.data_master external_sdram_controller.s1 avalon
    set_connection_parameter_value nios2_gen2_0.data_master/external_sdram_controller.s1 arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2_0.data_master/external_sdram_controller.s1 baseAddress {0x04000000}
    set_connection_parameter_value nios2_gen2_0.data_master/external_sdram_controller.s1 defaultConnection {0}

    add_connection nios2_gen2_0.data_master onchip_memory2_0.s1 avalon
    set_connection_parameter_value nios2_gen2_0.data_master/onchip_memory2_0.s1 arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2_0.data_master/onchip_memory2_0.s1 baseAddress {0x1000}
    set_connection_parameter_value nios2_gen2_0.data_master/onchip_memory2_0.s1 defaultConnection {0}

    add_connection nios2_gen2_0.data_master pio_0.s1 avalon
    set_connection_parameter_value nios2_gen2_0.data_master/pio_0.s1 arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2_0.data_master/pio_0.s1 baseAddress {0x4000}
    set_connection_parameter_value nios2_gen2_0.data_master/pio_0.s1 defaultConnection {0}

    add_connection nios2_gen2_0.data_master sd_card_spi.spi_control_port avalon
    set_connection_parameter_value nios2_gen2_0.data_master/sd_card_spi.spi_control_port arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2_0.data_master/sd_card_spi.spi_control_port baseAddress {0x2000}
    set_connection_parameter_value nios2_gen2_0.data_master/sd_card_spi.spi_control_port defaultConnection {0}

    add_connection nios2_gen2_0.instruction_master nios2_gen2_0.debug_mem_slave avalon
    set_connection_parameter_value nios2_gen2_0.instruction_master/nios2_gen2_0.debug_mem_slave arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2_0.instruction_master/nios2_gen2_0.debug_mem_slave baseAddress {0x0800}
    set_connection_parameter_value nios2_gen2_0.instruction_master/nios2_gen2_0.debug_mem_slave defaultConnection {0}

    add_connection nios2_gen2_0.instruction_master onchip_memory2_0.s1 avalon
    set_connection_parameter_value nios2_gen2_0.instruction_master/onchip_memory2_0.s1 arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2_0.instruction_master/onchip_memory2_0.s1 baseAddress {0x1000}
    set_connection_parameter_value nios2_gen2_0.instruction_master/onchip_memory2_0.s1 defaultConnection {0}

    add_connection altpll_0.c0 sd_card_spi.clk clock

    add_connection altpll_0.c0 nios2_gen2_0.clk clock

    add_connection altpll_0.c0 external_sdram_controller.clk clock

    add_connection altpll_0.c0 pio_0.clk clock

    add_connection altpll_0.c0 onchip_memory2_0.clk1 clock

    add_connection altpll_0.c0 sega_saturn_abus_slave_0.clock clock

    add_connection clk_0.clk altpll_0.inclk_interface clock

    add_connection clk_0.clk_reset altpll_0.inclk_interface_reset reset

    add_connection nios2_gen2_0.debug_reset_request nios2_gen2_0.reset reset

    add_connection nios2_gen2_0.debug_reset_request external_sdram_controller.reset reset

    add_connection nios2_gen2_0.debug_reset_request sd_card_spi.reset reset

    add_connection nios2_gen2_0.debug_reset_request pio_0.reset reset

    add_connection nios2_gen2_0.debug_reset_request sega_saturn_abus_slave_0.reset reset

    add_connection nios2_gen2_0.debug_reset_request onchip_memory2_0.reset1 reset

    add_connection nios2_gen2_0.irq sd_card_spi.irq interrupt
    set_connection_parameter_value nios2_gen2_0.irq/sd_card_spi.irq irqNumber {0}

    # exported interfaces
    add_interface clk clock sink
    set_interface_property clk EXPORT_OF clk_0.clk_in
    add_interface external_sdram_controller_wire conduit end
    set_interface_property external_sdram_controller_wire EXPORT_OF external_sdram_controller.wire
    add_interface pio_0_external_connection conduit end
    set_interface_property pio_0_external_connection EXPORT_OF pio_0.external_connection
    add_interface reset reset sink
    set_interface_property reset EXPORT_OF clk_0.clk_in_reset
    add_interface sega_saturn_abus_slave_0_abus conduit end
    set_interface_property sega_saturn_abus_slave_0_abus EXPORT_OF sega_saturn_abus_slave_0.abus
    add_interface altpll_0_areset_conduit conduit end
    set_interface_property altpll_0_areset_conduit EXPORT_OF altpll_0.areset_conduit
    add_interface altpll_0_locked_conduit conduit end
    set_interface_property altpll_0_locked_conduit EXPORT_OF altpll_0.locked_conduit
    add_interface altpll_0_phasedone_conduit conduit end
    set_interface_property altpll_0_phasedone_conduit EXPORT_OF altpll_0.phasedone_conduit
    add_interface sd_card_spi_external conduit end
    set_interface_property sd_card_spi_external EXPORT_OF sd_card_spi.external

    # interconnect requirements
    set_interconnect_requirement {$system} {qsys_mm.clockCrossingAdapter} {HANDSHAKE}
    set_interconnect_requirement {$system} {qsys_mm.maxAdditionalLatency} {1}
    set_interconnect_requirement {$system} {qsys_mm.insertDefaultSlave} {FALSE}
}
