# wasca
Sega Saturn multipurpose cartridge. It emulates Power Memory / Backup RAM, 1MB ROMs from KoF and Ultraman, and 1M/4M RAM expansion. Additionnaly, in can launch any 3rd party code compiled as a cartridge rom (.ss in [`libyaul`]). Netlink support is planned.
Cart is based on Lattice ECP5 FPGA with PicoRV32 RISC-V soft CPU core ([`picorv32`]) and external SDRAM. 
