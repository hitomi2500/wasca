# wasca
wasca is a multipurpose Sega Saturn cartridge based on Lattice ECP5 FPGA with PicoRV32 RISC-V soft CPU core ([`picorv32`][2]). 

wasca can operate in several modes:

- Backup memory cartridge
- RAM expansion cartridge
- ROM cartridge
- Homebrew software compiled as a cartridge ROM 

> Netlink support is planned via an ESP32-CAM module connected to the 6-pin expansion header.

> Optical drive emulation (ODE) function is theoretically possible, but not planned currently.

> Profiling can be supported using a special firmware version, but it requires support from SH-2 code.

---

# Quick Start

1. Prepare the SD card formatted as FAT32. Other filesystems like NTFS and exFAT are not supported.
2. Copy `wasca.ss` and `wasca.rv` to the SD card root directory. Note that the file names should be in lowercase on the card, check FAT32 LFN support or reformat the card if they are not.
3. Insert the SD card into wasca, plug wasca into the cartridge slot, power on the console
4. Verify that the front LED on the cartridge turns red, then blue.
5. wasca menu should appear on screen after boot logo. Some ODEs can bypass wasca boot process entirely. In this case, consult your ODE documentation to learn how to return to cartridge boot mode after selecting a game.

---

# LED Status Reference

| Color | Meaning |
|---|---|
| Red | Reading SD card at startup or system error. |
| Red, blinking | Boot error, either `wasca.ss` and `wasca.rv` was not found on SD card, refer to on-screen error message. |
| Blue | Firmware found on SD card, boot successful, waiting for menu selection. |
| Green, blinking | Write access in RAM or Homebrew mode. |
| Magenta, blinking | Write access to backup memory in backup mode or filesystem write access. |
| Cyan, blinking | Massive write access to backup memory (happens during format) or filesystem read access. |
| Yellow, blinking | Preparing backup memory |
| White, blinking | Filesystem open, close, seek etc.|

---

# Backup Memory Support

wasca supports four backup memory sizes:

- 0.5 MB (official Sega Saturn size)
- 1 MB
- 2 MB
- 4 MB

If not already present, the following backup files are created automatically on the SD card when selected from the menu:

- `backup05.bin`
- `backup1.bin`
- `backup2.bin`
- `backup4.bin`

Syncronization is done automatically, led blinking with magenta color signals write access, led blinking with cyan signals massive write access and usually happens during cart format in BIOS.

---

# RAM Expansion Support

wasca supports these RAM expansion modes:

- 1 MB official RAM expansion (timings not 100% compatible)
- 4 MB official RAM expansion
- Heart of Darkness mode (HoD will work in homebrew mode as well)

---

# ROM Support

The following games require corresponding ROM files placed in the SD card root directory:

| Game | Required File |
|---|---|
| King of Fighters '95 | `kof95.bin` |
| Ultraman | `ultraman.bin` |

When present on SD card, ROM will appear in menu and should be selected prior to launching the game.

---

# Homebrew Support

Any Sega Saturn homebrew compiled for cartridge can be placed into the SD card root directory. `.ss` and `.bin` extensions are supported. wasca automatically scans and lists `.bin` and `.ss` files found in the SD card root directory.

In homebrew mode, wasca exposes:

- 32 MB of CS0 space
- 16 MB of CS1 space

These regions are available to the developer as RAM.

[`Yaul`][1] system library supports compiling sortware for cartridge with a special makefile include (build.post.ss.mk) that should be added to the project's Makefile instead of the default one (build.post.iso-cue.mk).

---

# Menu limit

Currently, wasca menu is limited to 18 items. If more `.bin` and `.ss` files that fit on screen are present in the SD card root, only first items will be shown. Use wasca commander (still under development) file manager to load extra files or files in non-root folders.

---

# Firmware update

wasca firmware consists of 3 parts:

- FPGA gateware: `attosoc.bit`
- RISC-V firmware: `wasca.rv`
- SH-2 firmware: `wasca.ss`

### Updating FPGA gateware

1. Disconnect wasca from the console
2. Remove two screws on the back of the cartridge
3. Open the cartridge shell
4. Connect wasca to PC using USB-C cable
5. A removable drive will appear
6. Copy `attosoc.bit` onto the drive
7. Wait for 2 minutes before disconnecting the cartridge
8. Assemble the cartridge and connect to the console.

### Updating RISC-V and SH-2 Firmware

1. Remove SD card from wasca
2. Replace the existing `wasca.rv` and `wasca.ss` files on the SD card with a newer version.
3. Re-insert the card. Console power cycle is necessary for wasca to load the new firmware.

---

# SD card removal
Removing the SD card when console is powered up is only recommended when the front LED is not lit and not blinking. Re-inserting the card without reset is possible if LED did not blink while the card was removed, but data integrity is not tested and not guaranteed.

---

# Troubleshooting

### Lit red LED and/or "wasca : boot error" on screen

Possible causes:
- Unsupported filesystem
- Bad SD card
- Unstable SD card connection

Try:
- Re-insert the SD card
- Reformat the SD card as FAT32
- Replace SD card

### Blinking red LED and/or missing file message on screen

Possible causes:
- Missing `wasca.ss` or `wasca.rv` in the SD card root
- Unsupported filesystem
- Bad SD card

Try:
- Verify that both `wasca.ss` and `wasca.rv` exists in the SD card root directory, named in lowercase
- Reformat the SD card as FAT32
- Replace the SD card

### Lit blue LED, wasca boot menu does not appear during boot

Possible causes:
- Poor cartridge connection
- Dirty cartridge connector
- ODE bypassing cartridge initialization

Try:
- Reseating the cartridge
- Cleaning the cartridge and connector
- Consulting your ODE documentation for cartridge boot instructions

### Game ROM of homebrew .ss file present in root folder, but does not appear in the menu

Possible causes:
- Too many files in SD card root
- Wrong charset

Try:
- Verify that there is enough place on the screen to print necessary menu item. If last menu item is 18, it's probably overfilled and extra items are not shown.
- Verify that the file extension is `.bin` or `.ss`, lowercase, latin1 characters.



[1]: https://github.com/ijacquez/libyaul
[2]: https://github.com/YosysHQ/picorv32
