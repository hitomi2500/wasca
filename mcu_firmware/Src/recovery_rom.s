.section .rodata

.global _recovery_rom_dat
.global _recovery_rom_end
    .align 1
_recovery_rom_dat:
    .incbin "Src/recovery_rom.bin"
_recovery_rom_end:

