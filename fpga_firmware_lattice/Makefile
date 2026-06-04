TRELLIS?=/usr/share/trellis
BOOTSTRAP_SOURCES := picorv_bootstrap/start.S picorv_bootstrap/bootstrap.c picorv_bootstrap/filesystem.c picorv_bootstrap/stdlib_tiny.c picorv_bootstrap/mini-printf.c picorv_bootstrap/stdlib_tiny_asm.S fatfs/ff.c fatfs/diskio.c fatfs/ffsystem.c fatfs/ffunicode.c fatfs/sdiodrv.c
BOOTSTRAP_OBJECTS := $(BOOTSTRAP_SOURCES:%.c=%.o)
BOOTSTRAP_OBJECTS := $(BOOTSTRAP_OBJECTS:%.S=%.o)
FIRMWARE_SOURCES := picorv_firmware/start.S picorv_firmware/firmware.c picorv_firmware/filesystem.c picorv_firmware/stdlib_tiny.c picorv_firmware/mini-printf.c picorv_firmware/stdlib_tiny_asm.S fatfs/ff.c fatfs/diskio.c fatfs/ffsystem.c fatfs/ffunicode.c fatfs/sdiodrv.c
FIRMWARE_OBJECTS := $(FIRMWARE_SOURCES:%.c=%.o)
FIRMWARE_OBJECTS := $(FIRMWARE_OBJECTS:%.S=%.o)


%.o: %.c
	echo riscv64-unknown-elf-gcc -oS -march=rv32i -mabi=ilp32 -ffreestanding -nostdlib -S $<
	riscv64-unknown-elf-gcc -I../ -oS -march=rv32i -mabi=ilp32 -ffreestanding -nostdlib -c $< -o $@

%.o: %.S
	riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32 -ffreestanding -nostdlib -c $< -o $@

bootstrap.elf: picorv_bootstrap/sections.lds $(BOOTSTRAP_OBJECTS)
	riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32 -Wl,-Map,bootstrap.map,-Bstatic,-T,picorv_bootstrap/sections.lds,--strip-debug -ffreestanding -nostdlib $(BOOTSTRAP_OBJECTS) -o bootstrap.elf

bootstrap.bin: bootstrap.elf
	riscv64-unknown-elf-objcopy -O binary bootstrap.elf bootstrap.bin

bootstrap.hex: bootstrap.bin
	python3 makehex.py $^ 24576 > $@

firmware.elf: picorv_firmware/sections.lds $(FIRMWARE_OBJECTS)
	riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32 -Wl,-Map,firmware.map,-Bstatic,-T,picorv_firmware/sections.lds,--strip-debug -ffreestanding -nostdlib $(FIRMWARE_OBJECTS) -o firmware.elf

firmware.bin: firmware.elf
	riscv64-unknown-elf-objcopy -O binary firmware.elf firmware.bin

firmware.hex: firmware.bin
	python3 makehex.py $^ 24576 > $@

wasca.rv: firmware.bin
	cp $< $@

attosoc_tb.vvp: hdl/attosoc_tb.v hdl/sd_fake.v hdl/sd_fake_rom.v hdl/attosoc.v hdl/picorv32.v hdl/pulsesync.v hdl/sdram_bridge.v hdl/simpleuart.v hdl/sniff_fifo.v hdl/workram.v hdl/sd/sddma_mm2s.v hdl/sd/sddma_rxgears.v hdl/sd/sddma_txgears.v hdl/sd/sddma_s2mm.v hdl/sd/sddma.v hdl/sd/sdfifo.v hdl/sd/sdskid.v hdl/sd/sdio.v hdl/sd/sdwb.v hdl/sd/sdckgen.v hdl/sd/sdcmd.v hdl/sd/sdrxframe.v hdl/sd/sdtxframe.v hdl/sd/sdfrontend.v hdl/sd/sdio_top.v
	iverilog -s testbench -I sd -o $@ $^

attosoc_sim: attosoc_tb.vvp bootstrap.hex
	vvp -N $<

attosoc.json: hdl/top.v hdl/pll.v hdl/attosoc.v hdl/picorv32.v hdl/pulsesync.v hdl/sdram_bridge.v hdl/simpleuart.v hdl/sniff_fifo.v hdl/workram.v hdl/sd/sddma_mm2s.v hdl/sd/sddma_rxgears.v hdl/sd/sddma_txgears.v hdl/sd/sddma_s2mm.v hdl/sd/sddma.v hdl/sd/sdfifo.v hdl/sd/sdskid.v hdl/sd/sdio.v hdl/sd/sdwb.v hdl/sd/sdckgen.v hdl/sd/sdcmd.v hdl/sd/sdrxframe.v hdl/sd/sdtxframe.v hdl/sd/sdfrontend.v hdl/sd/sdio_top.v bootstrap.hex
	yosys -p "synth_ecp5 -json $@ -top top" hdl/top.v hdl/pll.v hdl/attosoc.v hdl/picorv32.v hdl/pulsesync.v hdl/sdram_bridge.v hdl/simpleuart.v hdl/sniff_fifo.v hdl/workram.v hdl/sd/sddma_mm2s.v hdl/sd/sddma_rxgears.v hdl/sd/sddma_txgears.v hdl/sd/sddma_s2mm.v hdl/sd/sddma.v hdl/sd/sdfifo.v hdl/sd/sdskid.v hdl/sd/sdio.v hdl/sd/sdwb.v hdl/sd/sdckgen.v hdl/sd/sdcmd.v hdl/sd/sdrxframe.v hdl/sd/sdtxframe.v hdl/sd/sdfrontend.v hdl/sd/sdio_top.v

attosoc_out.config: attosoc.json hdl/wasca.lpf
	nextpnr-ecp5 --force --speed 6 --seed 0 --json attosoc.json --lpf hdl/wasca.lpf --textcfg $@ --25k --freq 133 --package CABGA256 --parallel-refine

attosoc.bit: attosoc_out.config
	ecppack --svf-rowsize 100000 --svf attosoc.svf $< $@

%.svf: %.bit

prog: attosoc.svf
	openocd -f ${TRELLIS}/misc/openocd/ecp5-versa5g.cfg -c "transport select jtag; init; svf $<; exit"

clean:
	rm -f *.o *.vvp *.vcd *.elf *.bin *.hex *.bit *.svf *_out.config *.json fatfs/*.o

.PHONY: attosoc_sim clean prog
.PRECIOUS: attosoc.json attosoc_out.config attosoc.bit
