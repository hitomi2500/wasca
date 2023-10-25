TRELLIS?=/usr/share/trellis
BOOTSTRAP_SOURCES := start.s bootstrap.c mmc.c ocsdc.c stdlib_tiny.c
BOOTSTRAP_OBJECTS := $(BOOTSTRAP_SOURCES:%.c=%.o)
BOOTSTRAP_OBJECTS := $(BOOTSTRAP_OBJECTS:%.s=%.o)

%.o: %.c
	riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32 -ffreestanding -nostdlib -S $<
	riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32 -ffreestanding -nostdlib -c $< -o $@

%.o: %.s
	riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32 -ffreestanding -nostdlib -c $< -o $@

bootstrap.elf: sections.lds $(BOOTSTRAP_OBJECTS)
	riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32 -Wl,-Map,bootstrap.map,-Bstatic,-T,sections.lds,--strip-debug -ffreestanding -nostdlib $(BOOTSTRAP_OBJECTS) -o bootstrap.elf

bootstrap.bin: bootstrap.elf
	riscv64-unknown-elf-objcopy -O binary bootstrap.elf bootstrap.bin

bootstrap.hex: bootstrap.bin
	python3 makehex.py $^ 4096 > $@

attosoc_tb.vvp: attosoc_tb.v sd_fake.v sd_fake_rom.v attosoc.v picorv32.v simpleuart.v sd/sdc_controller.v sd/bistable_domain_cross.v sd/byte_en_reg.v sd/edge_detect.v sd/generic_dpram.v sd/generic_fifo_dc_gray.v sd/monostable_domain_cross.v sd/sd_clock_divider.v sd/sd_cmd_master.v sd/sd_cmd_serial_host.v sd/sd_controller_wb.v sd/sd_crc_7.v sd/sd_crc_16.v sd/sd_data_master.v sd/sd_data_serial_host.v sd/sd_data_xfer_trig.v sd/sd_fifo_filler.v sd/sd_wb_sel_ctrl.v
	iverilog -s testbench -I sd -o $@ $^

attosoc_sim: attosoc_tb.vvp bootstrap.hex
	vvp -N $<

attosoc.json: top.v pll.v attosoc.v picorv32.v simpleuart.v  sd/sdc_controller.v sd/bistable_domain_cross.v sd/byte_en_reg.v sd/edge_detect.v sd/generic_dpram.v sd/generic_fifo_dc_gray.v sd/monostable_domain_cross.v sd/sd_clock_divider.v sd/sd_cmd_master.v sd/sd_cmd_serial_host.v sd/sd_controller_wb.v sd/sd_crc_7.v sd/sd_crc_16.v sd/sd_data_master.v sd/sd_data_serial_host.v sd/sd_data_xfer_trig.v sd/sd_fifo_filler.v sd/sd_wb_sel_ctrl.v bootstrap.hex
	yosys -p "synth_ecp5 -json $@ -top top" top.v pll.v attosoc.v picorv32.v simpleuart.v sd/sdc_controller.v sd/bistable_domain_cross.v sd/byte_en_reg.v sd/edge_detect.v sd/generic_dpram.v sd/generic_fifo_dc_gray.v sd/monostable_domain_cross.v sd/sd_clock_divider.v sd/sd_cmd_master.v sd/sd_cmd_serial_host.v sd/sd_controller_wb.v sd/sd_crc_7.v sd/sd_crc_16.v sd/sd_data_master.v sd/sd_data_serial_host.v sd/sd_data_xfer_trig.v sd/sd_fifo_filler.v sd/sd_wb_sel_ctrl.v

attosoc_out.config: attosoc.json wasca.lpf
	nextpnr-ecp5 --json attosoc.json --lpf wasca.lpf --textcfg $@ --25k --freq 50 --package CABGA256

attosoc.bit: attosoc_out.config
	ecppack --svf-rowsize 100000 --svf attosoc.svf $< $@

%.svf: %.bit

prog: attosoc.svf
	openocd -f ${TRELLIS}/misc/openocd/ecp5-versa5g.cfg -c "transport select jtag; init; svf $<; exit"

clean:
	rm -f *.o *.vvp *.vcd *.elf *.bin *.hex *.bit *.svf *_out.config *.json

.PHONY: attosoc_sim clean prog
.PRECIOUS: attosoc.json attosoc_out.config attosoc.bit
