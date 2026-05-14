# wasca
wasca is a multipurpose Sega Saturn cartridge based on Lattice ECP5 FPGA with PicoRV32 RISC-V soft CPU core ([`picorv32`][2]). 

wasca can operate in several modes:

- Backup memory cartridge
- RAM expansion cartridge
- ROM cartridge
- Homebrew software compiled as a cartridge ROM (.ss in [`libyaul`][1])

> ODE support is not planned. Netlink support is planned via an ESP32-CAM module connected to the 6-pin expansion header.

Some ODEs can bypass the wasca boot process entirely. Consult your ODE documentation to learn how to return to cartridge boot mode after selecting a game.

---

# Quick Start

1. Format an SD card as FAT32
2. Copy `wasca.ss` to the SD card root directory
3. Insert the SD card into wasca
4. Insert wasca into the Sega Saturn cartridge slot
5. Power on the console

If setup is successful, the LED will turn blue and the boot menu will appear.

---

# Requirements

wasca requires:

- An SD card formatted as FAT32
- The `wasca.ss` firmware file placed in the SD card root directory

Only the first partition on the SD card is accessible by wasca.

Example:

```text
SD:/wasca.ss
```

---

# SD Card Recommendations

Recommended:
- FAT32 filesystem
- MBR partition table
- Single partition
- Standard SD or microSD cards with adapter

Unsupported:
- exFAT
- NTFS

Only the first partition on the SD card is accessible by wasca.

---

# LED Status Reference

| Color | Meaning |
|---|---|
| Red | Reading SD card at startup or system error |
| Blue | Firmware found on SD card, boot successful, waiting for menu selection |
| Green | Writing to RAM in RAM mode |
| Magenta | Writing to backup memory in backup mode |
| Cyan | Writing entire backup memory image (used during formatting) |
| Yellow | Preparing backup memory |

---

# Backup Memory Support

wasca supports four backup memory sizes:

- 0.5 MB (official Sega Saturn size)
- 1 MB
- 2 MB
- 4 MB

The following backup files are created automatically on the SD card when selected from the menu:

- `backup05.bin`
- `backup1.bin`
- `backup2.bin`
- `backup4.bin`

---

# RAM Expansion Support

wasca supports both official Sega Saturn RAM expansion modes:

- 1 MB RAM expansion
- 4 MB RAM expansion

A special RAM mode for the Heart of Darkness demo is also included.

---

# ROM Support

## Required ROM Files

The following games require corresponding ROM files placed in the SD card root directory:

| Game | Required File |
|---|---|
| King of Fighters '95 | `kof95.bin` |
| Ultraman | `ultraman.bin` |

Example:

```text
SD:/kof95.bin
SD:/ultraman.bin
```

---

# Homebrew Support

Any Sega Saturn homebrew ROM with the `.ss` extension can be placed in the SD card root directory.

wasca automatically scans and lists all `.bin` and `.ss` files found in the SD card root directory.

## Homebrew Development Support

In homebrew mode (when booting a `.ss` file), wasca exposes:

- 32 MB of CS0 space
- 16 MB of CS1 space

These regions are available to the developer as RAM.

---

# Firmware

wasca firmware consists of two parts:

- Internal FPGA firmware: `attosoc.bit`
- SH-2 firmware: `wasca.ss`

## Updating Internal Firmware

1. Disconnect wasca from the console
2. Remove the two screws on the back of the cartridge
3. Open the cartridge shell
4. Connect wasca to a computer using a USB-C cable
5. A removable drive will appear
6. Copy `attosoc.bit` onto the drive
7. Wait until tiny red LED on the module stops blinking (approximately one minute) before disconnecting the cartridge
8. Assemble the cartridge and connect to the console.

## Updating SH-2 Firmware

Replace the existing `wasca.ss` file on the SD card with the newer version.

---

# File Naming Rules

- `wasca.ss` must be entirely lowercase
- Other `.ss` and `.bin` filenames may use any letter case and charset
- Only Latin-1 and lowercase naming have been tested

wasca automatically scans and lists all `.bin` and `.ss` files found in the SD card root directory.

---

# Troubleshooting

## Red LED and/or "wasca : boot error"

Possible causes:
- Unsupported filesystem
- Missing `wasca.ss`
- Bad SD card
- Unstable SD card connection

Try:
- Re-insert the SD card
- Ensure only one partition exists on SD card
- Reformat the SD card partition as FAT32
- Verify that `wasca.ss` exists in the SD card root directory

## Blue LED but No Boot Menu

Possible causes:
- Poor cartridge connection
- Dirty cartridge connector
- ODE bypassing cartridge initialization

Try:
- Reseating the cartridge
- Cleaning cartridge contacts
- Consulting your ODE documentation for cartridge boot instructions
## Game ROM Does Not Appear

- Verify the file extension is `.bin` or `.ss`
- Verify the file is placed in the SD card root directory
- Check filename spelling


[1]: https://github.com/ijacquez/libyaul
[2]: https://github.com/YosysHQ/picorv32
