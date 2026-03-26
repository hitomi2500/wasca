TRELLIS?=/usr/share/trellis
BOOTSTRAP_SOURCES := start.S bootstrap.c stdlib_tiny.c mini-printf.c stdlib_tiny_asm.S fatfs/ff.c fatfs/diskio.c fatfs/ffsystem.c fatfs/ffunicode.c fatfs/sdiodrv.c
BOOTSTRAP_OBJECTS := $(BOOTSTRAP_SOURCES:%.c=%.o)
BOOTSTRAP_OBJECTS := $(BOOTSTRAP_OBJECTS:%.S=%.o)

%.o: %.c
	echo riscv64-unknown-elf-gcc -oS -march=rv32i -mabi=ilp32 -ffreestanding -nostdlib -S $<
	riscv64-unknown-elf-gcc -oS -march=rv32i -mabi=ilp32 -ffreestanding -nostdlib -c $< -o $@

%.o: %.S
	riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32 -ffreestanding -nostdlib -c $< -o $@

bootstrap.elf: sections.lds $(BOOTSTRAP_OBJECTS)
	riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32 -Wl,-Map,bootstrap.map,-Bstatic,-T,sections.lds,--strip-debug -ffreestanding -nostdlib $(BOOTSTRAP_OBJECTS) -o bootstrap.elf

bootstrap.bin: bootstrap.elf
	riscv64-unknown-elf-objcopy -O binary bootstrap.elf bootstrap.bin

bootstrap.hex: bootstrap.bin
	python3 makehex.py $^ 24576 > $@

attosoc_tb.vvp: attosoc_tb.v sd_fake.v sd_fake_rom.v attosoc.v picorv32.v sdram_bridge.v simpleuart.v sniff_fifo.v sd/sddma_mm2s.v sd/sddma_rxgears.v sd/sddma_txgears.v sd/sddma_s2mm.v sd/sddma.v sd/sdfifo.v sd/sdskid.v sd/sdio.v sd/sdwb.v sd/sdckgen.v sd/sdcmd.v sd/sdrxframe.v sd/sdtxframe.v sd/sdfrontend.v sd/sdio_top.v
	iverilog -s testbench -I sd -o $@ $^

attosoc_sim: attosoc_tb.vvp bootstrap.hex
	vvp -N $<

attosoc.json: top.v pll.v attosoc.v picorv32.v sdram_bridge.v simpleuart.v sniff_fifo.v sd/sddma_mm2s.v sd/sddma_rxgears.v sd/sddma_txgears.v sd/sddma_s2mm.v sd/sddma.v sd/sdfifo.v sd/sdskid.v sd/sdio.v sd/sdwb.v sd/sdckgen.v sd/sdcmd.v sd/sdrxframe.v sd/sdtxframe.v sd/sdfrontend.v sd/sdio_top.v bootstrap.hex
	yosys -p "synth_ecp5 -json $@ -top top" top.v pll.v attosoc.v picorv32.v sdram_bridge.v simpleuart.v sniff_fifo.v sd/sddma_mm2s.v sd/sddma_rxgears.v sd/sddma_txgears.v sd/sddma_s2mm.v sd/sddma.v sd/sdfifo.v sd/sdskid.v sd/sdio.v sd/sdwb.v sd/sdckgen.v sd/sdcmd.v sd/sdrxframe.v sd/sdtxframe.v sd/sdfrontend.v sd/sdio_top.v

attosoc_out.config: attosoc.json wasca.lpf
	nextpnr-ecp5 --json attosoc.json --lpf wasca.lpf --textcfg $@ --25k --freq 50 --package CABGA256

attosoc.bit: attosoc_out.config
	ecppack --svf-rowsize 100000 --svf attosoc.svf $< $@

%.svf: %.bit

prog: attosoc.svf
	openocd -f ${TRELLIS}/misc/openocd/ecp5-versa5g.cfg -c "transport select jtag; init; svf $<; exit"

clean:
	rm -f *.o *.vvp *.vcd *.elf *.bin *.hex *.bit *.svf *_out.config *.json fatfs/*.o

.PHONY: attosoc_sim clean prog
.PRECIOUS: attosoc.json attosoc_out.config attosoc.bit
