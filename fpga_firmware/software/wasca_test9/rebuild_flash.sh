#!/bin/bash
#
# Rebuild flash files.

# Generate flash and remote update files
make mem_init_generate
nios2-elf-objcopy -I ihex -O binary mem_init/wasca_onchip_flash_0.hex mem_init/wasca_onchip_flash_0.rbf

# Generate CFM and UFM merged into a single .pof file.
# Note : it is saved here -> ../../output_files/nios2_ufm_boot_test9.pof
quartus_cpf -c nios_ufm_boot.cof
