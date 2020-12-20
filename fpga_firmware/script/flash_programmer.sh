#!/bin/sh
#
# This file was automatically generated.
#
# It can be overwritten by nios2-flash-programmer-generate or nios2-flash-programmer-gui.
#

#
# Converting SOF File: D:\Saturn\wasca\GIT\wasca\fpga_firmware\output_files\wasca.sof to: "..\flash/wasca_onchip_flash_0.flash"
#
sof2flash --input="D:/Saturn/wasca/GIT/wasca/fpga_firmware/output_files/wasca.sof" --output="../flash/wasca_onchip_flash_0.flash" --offset=0x0 

#
# Programming File: "..\flash/wasca_onchip_flash_0.flash" To Device: onchip_flash_0
#
nios2-flash-programmer "../flash/wasca_onchip_flash_0.flash" --base=0x0 --accept-bad-sysid --device=1 --instance=0 '--cable=USB-Blaster on localhost [USB-0]' --program 

#
# Converting ELF File: D:\Saturn\wasca\GIT\wasca\fpga_firmware\software\wasca_test9\wasca_test9.elf to: "..\flash/wasca_test9_onchip_flash_0.flash"
#
elf2flash --input="wasca_test9.elf" --output="../flash/wasca_test9_onchip_flash_0.flash" --boot="$SOPC_KIT_NIOS2/components/altera_nios2/boot_loader_cfi.srec" --base=0x0 --end=0x2b000 --reset=0x80000 

#
# Programming File: "..\flash/wasca_test9_onchip_flash_0.flash" To Device: onchip_flash_0
#
nios2-flash-programmer "../flash/wasca_test9_onchip_flash_0.flash" --base=0x0 --accept-bad-sysid --device=1 --instance=0 '--cable=USB-Blaster on localhost [USB-0]' --program 

