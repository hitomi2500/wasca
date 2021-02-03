make mem_init_generate
quartus_cpf -c nios_ufm_boot.cof
quartus_pgm -z --mode=JTAG --operation="p;C:\wasca\GIT\wasca\fpga_firmware\output_files\wasca.pof"
