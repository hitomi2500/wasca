set_global_assignment -entity "wasca" -library "lib_wasca" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "wasca" -library "lib_wasca" -name IP_TOOL_VERSION "18.1"
set_global_assignment -entity "wasca" -library "lib_wasca" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_wasca" -name SPD_FILE [file join $::quartus(sip_path) "../wasca.spd"]
set_global_assignment -library "lib_wasca" -name MISC_FILE [file join $::quartus(sip_path) "../../wasca.qsys"]

set_global_assignment -library "lib_wasca" -name MISC_FILE [file join $::quartus(sip_path) "wasca.v"]
