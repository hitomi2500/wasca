/**
 *  Wasca Link - Nios <-> STM32 link related definition
 *  by cafe-alpha.
 *  WWW: http://ppcenter.free.fr/devblog/
 *
 *  See LICENSE file for details.
**/

#ifndef WASCA_LINK_SPI_H
#define WASCA_LINK_SPI_H

/*****************************************************************************
 * SPI transaction header.
 * This is used when communicating between MAX10 and STM32.
 *
 * Outline of transmission headers exchange :
 * ___________________________________________________________________________
 * | Contents | Idle (1)|       (2)|       (3)|      (4) |      (5) | Idle (1)
 * ___________________________________________________________________________
 * | SPI      |         | M10->STM |          | STM->M10 |          |         
 * ___________________________________________________________________________
 * | SYNC     | ______________________________|---------------------|_________
 * ___________________________________________________________________________
 *  (1) Idle : STM32 is ready to receive transmission header
 *  (2) Reception of header from MAX10
 *  (3) Processing of datagram contents and preparation of response header
 *  (4) Send back reponse to MAX10
 *  (5) Preparation for reception of next header
 *      On STM32 side, SYNC must be reset after setting up reception settings.
 *
 *****************************************************************************/

/* Enough space for each parameters. */
#define WL_SPI_PARAMS_LEN 16

/* Enough space to hold at least one backup memory block = 512 bytes. */
#define WL_SPI_DATA_LEN 512
//#define WL_SPI_DATA_LEN 896

/* Maximum length of the full path of a file, 
 * including terminating null character.
 */
#define WL_MAX_PATH 256

typedef struct _wl_spi_common_hdr_t
{
    /* Always set to 0xCA. */
    unsigned char magic_ca;

    /* Always set to 0xFE. */
    unsigned char magic_fe;

    /* Command ID. */
    unsigned char command;

    /* Reserved for future use. */
    unsigned char reserved;

    /* Packet length.
     * Direction : MAX10 -> STM32.
     *
     * Currently unused, because length of all packets is
     * considered as maximum length = sizeof(wl_spi_pkt_t).
     */
    unsigned short pkt_len;

    /* Response length, excluding heading packet.
     * Direction : STM32 -> MAX10.
     *
     * Note #1 : length must be a multiple of two bytes.
     *
     * Note #2 : When set to zero, full packet = sizeof(wl_spi_pkt_t)
     *           is sent back to MAX 10.
     */
    unsigned short rsp_len;
} wl_spi_common_hdr_t;

typedef struct _wl_spi_pkt_t
{
    wl_spi_common_hdr_t cmn;

    /* CRC value for parameters and data blocks.
     * 
     * CRC is computed on specified length, so that
     * unused data is not taken into account, and also
     * to make possible to disable CRC check by setting
     * a length of zero.
     * 
     * CRC integrity check is experimental and may be
     * removed if it is not necessary, so that the
     * enable/disable switch #defined below.
     */
#define WL_SPI_CRC_USE 1
    unsigned long  params_crc_val;
    unsigned short params_crc_len;
    unsigned short data_crc_len;
    unsigned long  data_crc_val;

    /* Parameters, whose contents differ for each datagram. */
    unsigned char params[WL_SPI_PARAMS_LEN];

    /* Data block. */
    unsigned char data[WL_SPI_DATA_LEN];

    /* Dummy bytes, do not access. */
    unsigned short dummy[2];
} wl_spi_pkt_t;


/* Compute packet size according to custom data length specified.
 * 
 * Examples :
 *  - No data block    -> WL_SPI_CUSTOM_PKTLEN(0)
 *  - 16 bytes of data -> WL_SPI_CUSTOM_PKTLEN(16)
 *  - Full packet      -> WL_SPI_CUSTOM_PKTLEN(WL_SPI_DATA_LEN)
 * 
 * Also, the following macros are available :
 *  - WL_SPI_ACK_ONLY_RSPLEN : only header = smallest possible length
 *  - WL_SPI_PARAMS_RSPLEN   : header + parameters
 *  - WL_SPI_FULL_RSPLEN     : full packet
 */
#define WL_SPI_CUSTOM_RSPLEN(_DATALEN_) (sizeof(wl_spi_pkt_t) - WL_SPI_DATA_LEN + (_DATALEN_))
#define WL_SPI_ACK_ONLY_RSPLEN (WL_SPI_CUSTOM_RSPLEN(0) - WL_SPI_PARAMS_LEN)
#define WL_SPI_PARAMS_RSPLEN   (WL_SPI_CUSTOM_RSPLEN(0)                    )
#define WL_SPI_FULL_RSPLEN     (WL_SPI_CUSTOM_RSPLEN(WL_SPI_DATA_LEN)      )


/* Dummy command ID, used for every unrecognized commands. */
#define WL_SPICMD_DUMMY 0x00


/* STM32 firmware version.
 *
 * Transfer outline :
 *  1. Send version request from MAX10
 *     | unsigned char params[]
 *     |  -> unused
 *     | (wl_verinfo_ext_t*)data[]
 *     |  -> contains MAX 10 firmware version.
 *  2. Send back read data to MAX10
 *     | unsigned char params[]
 *     |  -> unused
 *     | (wl_spicomm_version_t*)data[]
 *     |  -> contains STM32 firmware version.
 *
 * Note : Version is sent from MAX 10 to STM32 during firmware startup, 
 *        so that STM32 doesn't needs to retrieve it after that.
 */
#define WL_SPICMD_VERSION 0x10
typedef struct _wl_nios_verinfo_t
{
    /* NIOS program build date.
     * GCC date macro as-is.
     * Example : "Mar 20 2018"
     */
    char build_date[12];
    /* NIOS program build time.
     * GCC time macro as-is.
     * Example : "21:31:18"
     */
    char build_time[10];

    /* Board type.
     * This is basically used to indicate which board is currently connected, 
     * and hide unrelated settings on SerialTerm.
     * Setting to "Generic" type won't hide anything hence is recommended
     * when constantly merging code from a project to another.
     */
#define WL_DEVTYPE_GENERIC       0
#define WL_DEVTYPE_WASCA         1  /* Wasca cartridge                        */
#define WL_DEVTYPE_M10BRD        2  /* MAX 10 Board.                          */
#define WL_DEVTYPE_SIM           3  /* SIM (cartridge access tester).         */
#define WL_DEVTYPE_M10BRD_WARP   4  /* MAX 10 Board, used in couple with SIM. */
#define WL_DEVTYPE_SIM_WARP      5  /* SIM, used in couple with MAX 10 Board. */
#define WL_DEVTYPE_DUMMY       255
    unsigned char board_type;

    /* Unused space for Nios. */
    unsigned char unused_nios[3];

    /* MAX10 -> STM32 SPI frequency.
     * From Nios BSP's system.h.
     * Unit : KHz (example : 1234 -> 1.234 MHz)
     * Zero : SPI not used.
     */
    unsigned short stm32_spi_khz;

    /* MAX10 onchip RAM size.
     * From Nios BSP's system.h.
     * Unit : byte
     */
    unsigned long ocram_size;
} wl_nios_verinfo_t;

typedef struct _wl_verinfo_ext_t
{
    /* MAX 10 device type.
     * Example : "10M16SAE144C8G"
     * Note : null-terminated string.
     */
    char dev_type[16];

    /* MAX 10 project name.
     * Example : "brd_10m16sa"
     * Note : null-terminated string.
     */
    char prj_name[42];

    /* MAX 10 firmware (PL part) synthesis time.
     * It is formatted as unsigned integer at 32 bits
     * and 16 bits data size for respectively date and time.
     * Example : "2019/08/28 19:44" -> 20190828 (32 bits) and 1944 (16 bits)
     */
    unsigned short pl_time;
    unsigned long  pl_date;


    /* NIOS firmware version.
     * (Structure size : 32 bytes)
     */
    wl_nios_verinfo_t nios;
} wl_verinfo_ext_t;

typedef struct _wl_spicomm_version_t
{
    /* STM32 firmware build date.
     * GCC date macro as-is.
     * Example : "Mar 20 2018"
     */
    char build_date[12];

    /* STM32 firmware build time.
     * GCC time macro as-is.
     * Example : "21:31:18"
     */
    char build_time[10];

    /* Unused, reserved for future usage if any.
     * (Size of this structure must be packet to 32 bytes)
     */
    unsigned char unused[10];
} wl_spicomm_version_t;


/* Send log messages to STM32.
 *
 * Transfer outline :
 *  1. Send log message(s) from MAX10
 *     | (wl_spicomm_logs_t*)params[]
 *     |  -> contains misc. informations about logs data block.
 *     | unsigned char data[]
 *     |  -> contains logs data block itself.
 *  2. Send back ACK to MAX10
 *     | unsigned char params[]
 *     |  -> unused
 *     | unsigned char data[]
 *     |  -> unused
 *
 * Note : Version is sent from MAX 10 to STM32 during firmware startup, 
 *        so that STM32 doesn't needs to retrieve it after that.
 */
#define WL_SPICMD_LOGS 0x11
typedef struct _wl_spicomm_logs_t
{
    /* Data length (byte unit) of this block. */
    unsigned short block_len;

    /* Block ID and total count.
     * Both start from 1.
     */
    unsigned char block_id;
    unsigned char block_cnt;
} wl_spicomm_logs_t;


/* Log messages buffer.
 * 
 * This is declared on both MAX 10 and STM32 sides :
 *  - MAX 10 uses a buffer to send multiple gather log messages in a few
 *    SPI transaction(s).
 *  - STM32 uses a buffer to parse logs after they are received.
 * 
 * (If needed, adjust the size of buffer according to resources available)
 */
#define WL_LOG_BUFFER_SIZE 2048

/* Maximum log message length.
 * 
 * Messages longer than this length are truncated.
 */
#define WL_LOG_MESSAGE_MAXLEN 100



/* Log levels :
 *  - 1 : critical messages
 *    ...
 *  - 5 : debug messages
 */
#define WL_LOG_ERROR       1
#define WL_LOG_IMPORTANT   2
#define WL_LOG_DEBUGEASY   3
#define WL_LOG_DEBUGNORMAL 4
#define WL_LOG_DEBUGHARD   5



/* Logs circular buffer size.
 *
 * The larger the more it can handle log messages between two link access.
 * But as onchip memory is a limited resource on MAX 10 side, circular buffer
 * is set to a modest (but reasonably large enough) size.
 */
//#define CIRCBUFF_SIZE (4*1024)
//#define CIRCBUFF_SIZE (16*1024)
#define CIRCBUFF_SIZE (2*1024)

/* Maximum length when formating log messages.
 * This doesn't includes terminating null character.
 */
#define LOG_STR_MAXLEN (256)


typedef struct _log_infos_t
{
    /* Circular buffer R/W pointers (address is relative from the begining of circular buffer). */
    unsigned long readptr;
    unsigned long writeptr;

    /* Circular buffer internals. */
    unsigned long buffer_size;
    unsigned long start_address;
    unsigned long end_address;

    /* Log level.
     *
     * Need to set value #defined in WL_LOG_* macros.
     * Logs with level stricly higher ( > ) than this level
     * are discarded from output.
     *
     * Note : log output can be stopped by setting this
     *        level value to zero.
     */
    char level;

    /* Unused, for structure alignment purpose. */
    unsigned char padding[3];

    /* Circular buffer used when reading/writing debug data. */
    unsigned char circbuff[CIRCBUFF_SIZE];

    /* Message format buffer, used just before appending to circular buffer.
     * First two bytes are used to store message length.
     * Message is NOT null-terminated.
     */
    unsigned char format_buff[sizeof(unsigned short) + LOG_STR_MAXLEN];
} log_infos_t;




/* STM32 Register (or memory) read (or write) access.
 * Also featuring backup memory block access and management.
 *
 * READ Transfer outline :
 *  1. Send read request from MAX10
 *     | (wl_nios_verinfo_t*)params[]
 *     |  -> contains access parameters.
 *     | unsigned char data[]
 *     |  -> unused
 *  2. Send back read data to MAX10
 *     | unsigned char params[]
 *     |  -> unused
 *     | unsigned char data[]
 *     |  -> contains the read data.
 *
 * WRITE Transfer outline :
 *  1. Send write request and data from MAX10
 *     | (wl_nios_verinfo_t*)params[]
 *     |  -> contains access parameters.
 *     | unsigned char data[]
 *     |  -> contains data to write.
 *  2. Send back ACK to MAX10
 *     | (wl_nios_verinfo_t*)params[]
 *     |  -> contains access parameters as-is.
 *     | unsigned char data[]
 *     |  -> unused
 */
#define WL_SPICMD_MEMREAD  0x20
#define WL_SPICMD_MEMWRITE 0x21



/*****************************************************************************
 * STM32 Address Mapping.
 *
 * Reference : stm32f446re.pdf, "5  Memory mapping" (Page 67/202)
 * https://www.st.com/resource/en/datasheet/stm32f446re.pdf
 *****************************************************************************/

/* ---------------
 * --- Outline ---
 *
 * Address aliasing allows redirection of STM32 physical address and/or
 * application-specific features to user-defined (aliased) address.
 *
 * It can be accessed from MAX10 by using memory (or register) access commands :
 *  - WL_SPICMD_MEMREAD
 *  - WL_SPICMD_MEMWRITE
 *
 * Main purpose of this alias feature is to provide shortcuts to several STM32
 * from same commands from MAX10.
 *
 * This has the advantage to relieve code complexity on MAX10 side, which is
 * an important point since onchip memory (where NIOS programs is running) is
 * quite limited.
 * Additionally, this also allow complex STM32 operations in a single memory
 * access from MAX10, thus simplifying SPI transfer flow and consequently
 * improve application performance.
 *
 * -----------------------------
 * --- Address map (summary) ---
 *
 * | 0x0000_0000 - 0x001F_FFFF : Boot area
 * | 0x0020_0000 - 0x07FF_FFFF : Reserved ---> chip-specific alias
 * |+0x0100_0000 - 0x02FF_FFFF : | Flash memory       (ALIAS) Max 2MB
 * |+0x0300_0000 - 0x03FF_FFFF : | SRAM               (ALIAS) Max 1MB
 * |+0x0400_0000 - 0x07FF_FFFF : | Unused alias
 * | 0x0800_0000 - 0x081F_FFFF : Flash Memory
 * | 0x0820_0000 - 0x0FFF_FFFF : Reserved ---> application-specific alias
 * |+0x0820_0000 - 0x08FF_FFFF : | Unused (padding)
 * |+0x0900_0000 - 0x09FF_FFFF : | Logs circ. buffer  (ALIAS)
 * |+0x0A00_0000 - 0x0FFF_FFFF : | Unused alias
 * | 
 * (further reserved areas are skipped)
 * | 
 * | 0x1FFE_C000 - 0x1FFE_C00F : Option bytes
 * | 0x1FFF_0000 - 0x1FFF_7A0F : System Memory
 * | 0x1FFF_C000 - 0x1FFF_C00F : Option bytes
 * | 0x2000_0000 - 0x2001_BFFF : SRAM (112 KB)
 * | 0x2001_C000 - 0x2001_FFFF : SRAM ( 16 KB)
 *
 * ------------------------------------
 * --- Detail about alias address : ---
 *
 * |+0x0100_0000 - 0x02FF_FFFF : WL_STADR_FLASH : Flash memory (Max 2MB)
 * +-> Redirect to 0x0800_0000 physical address.
 *
 * |+0x0300_0000 - 0x03FF_FFFF : WL_STADR_SRAM  : SRAM         (Max 1MB)
 * +-> Redirect to 0x2000_0000 physical address.
 *
 * |+0x0900_0000 - 0x09FF_FFFF : Logs circular buffer
 * +-> 0x00_0000 -   0x00_FFFF : WL_STADR_LOGS_FIFO
 * |                           : Extract specified length from circular buffer.
 * |                           : (*) Address offset is ignored so that chunk
 * |                           :     read can be seen consecutive from PC.
 * +-> 0x01_0000               : WL_STADR_LOGS_STAT
 * |                           : Return circular buffer usage status.
 * |                           : (Associated structure : wla_logs_stats_t)
 * |                           : (*) Available only at 0x01_0000 offset.
 */
#define WL_STADR_FLASH      (0x01000000)

#define WL_STADR_SRAM       (0x03000000)

#define WL_STADR_LOGS_FIFO  (0x09000000)
#define WL_STADR_LOGS_STAT  (WL_STADR_LOGS_FIFO + 0x00010000)
typedef struct _wla_logs_stats_t
{
    /* Circular buffer size.
     * Unit : byte.
     */
    unsigned short buffer_size;

    /* Circular buffer usage.
     * Unit : byte.
     *  - 0                  : no log message available.
     *  - <= (buffer_size-1) : log message(s) available.
     *  - else               : something is broken !
     */
    unsigned short usage;

    /* Reserved for future use.
     * (Structure size : 16 bytes)
     */
    unsigned char reserved[12];
} wla_logs_stats_t;




/* Command IDs for boot ROM access.
 * 
 * Boot ROM have the following features :
 *  - It is read-only.
 *    (But it is possible to overwrite when it is accessed as a file)
 *  - File name is decided on STM32 side.
 *    (Because it is not possible to specify it from Saturn when it boots)
 *  - It refers to a portion of STM32 ROM when SD card is unavailable.
 *    (For example to indicate on TV screen that SD card is not inserted, 
 *     or to allow to format it or that boot ROM file is not found etc)
 *
 * Limitation : boot ROM and backup memory features can't be used together.
 * As a countermeasure, it is required to load boot ROM and the setup backup
 * memory when initialyzing the cartridge.
 *
 * -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 * Command     : WL_SPICMD_BOOTINFO
 * Description : Check boot ROM file and return details about it.
 * Outline     : 
 *    1. Send request from MAX10
 *       | (wl_spicomm_memacc_t*)params[]
 *       |  -> rom_id : boot ROM ID
 *       |              (Pseudo Saturn Kai / KOF95 / Ultraman / etc)
 *       | unsigned char data[]
 *       |  -> unused
 *    2. Send back boot ROM details to MAX10
 *       | (wl_spicomm_bootinfo_t*)params[]
 *       |  -> status, length etc
 *       | unsigned char data[]
 *       |  -> full path to file
 * 
 * -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 * Command     : WL_SPICMD_BOOTREAD
 * Description : Read boot ROM data at specified offset and length.
 *             : Size is limited to one data block per transaction.
 *             : Contents outside of boot ROM are filled with FFh value.
 * Note #1     : Boot ROM file is opened on first read, and closed when 
 *             : last block is accessed, so it is recommended to read it
 *             : sequentially from its beginning to end on MAX 10 side.
 * Outline     : 
 *    1. Send read request from MAX10
 *       | (wl_spicomm_memacc_t*)params[]
 *       |  -> rom_id : unused
 *       |              (ID specified in WL_SPICMD_BOOTINFO command is used)
 *       |  -> addr   : offset within boot ROM, in byte unit
 *       |  -> len    : read data length, maximum WL_SPI_DATA_LEN bytes
 *       | unsigned char data[]
 *       |  -> unused
 *    2. Send back read data to MAX10
 *       | (wl_spicomm_bootinfo_t*)params[]
 *       |  -> status, length etc
 *       | unsigned char data[]
 *       |  -> read data itself
 * 
 * -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 * Command     : WL_SPICMD_BOOTREG
 * Description : Register specified file path as cartridge boot ROM.
 *             : (Save the path into a settings file)
 * Outline     : 
 *    1. Send request from MAX10
 *       | (wl_spicomm_memacc_t*)params[]
 *       |  -> rom_id : boot ROM ID
 *       |              (Pseudo Saturn Kai / KOF95 / Ultraman / etc)
 *       | unsigned char data[]
 *       |  -> Contains full path to cartridge boot ROM file
 *    2. Send back ACK to MAX10
 *       | unsigned char params[]
 *       |  -> unused
 *       | unsigned char data[]
 *       |  -> unused
 * 
 */
#define WL_SPICMD_BOOTINFO 0x24
#define WL_SPICMD_BOOTREAD 0x25
#define WL_SPICMD_BOOTREG  0x26 // (Implementation will be done later)

#define WL_SPICMD_IS_BOOTROM(_CMD_) (((_CMD_) >= WL_SPICMD_BOOTINFO) && ((_CMD_) <= WL_SPICMD_BOOTREG) ? 1 : 0)

typedef struct _wl_spicomm_bootinfo_t
{
    /* Boot ROM size, in byte unit.
     * Typical values : 262144, 1048576 etc.
     *
     * This should never return zero even if SD card is not available, 
     * but care (of division by zero etc) should taken because of
     * any eventual change of this structure in the future.
     */
    unsigned long size;

    /* Boot ROM file status.
     *  - 0 : Recovery boot ROM.
     *  - 1 : Boot ROM loaded from SD card.
     *  - 2 : Boot ROM last block.
     */
#define WL_BOOTROM_RECOV 0
#define WL_BOOTROM_FILE  1
#define WL_BOOTROM_END   2
    unsigned char status;

    /* Unused, reserved for future usage if any. */
    unsigned char reserved[3];

    /* Size of block currently read.
     * Valid for WL_SPICMD_BOOTREAD command only, and should be used
     * when copying read data on MAX 10 side.
     */
    unsigned long block_len;

    /* Unused, reserved for future usage if any. */
    unsigned char unused[WL_SPI_PARAMS_LEN - 4 - 4 - 4];
} wl_spicomm_bootinfo_t;



/* Command IDs for backup memory block access.
 * These commands re-use the same data structure and outline as memory access.
 *
 * Limitation : boot ROM and backup memory features can't be used together.
 *
 * -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 * Command     : WL_SPICMD_BUPOPEN
 * Description : Open backup file with specified data length.
 *             : If already open, previous file is closed.
 *             : If not exist, contents are allocated and initialized to FFh.
 *             : File name is decided on STM32 side and depends on data size.
 * Outline     : 
 *    1. Send open request from MAX10
 *       | (wl_spicomm_memacc_t*)params[]
 *       |  -> len : backup data length, KB unit
 *       |           (0.5MB = 512KB, 1MB = 1MB etc)
 *       | unsigned char data[]
 *       |  -> unused
 *    2. Send back open ACK to MAX10
 *       | (wl_spicomm_memacc_t*)params[]
 *       |  -> len : same as input parameter on success
 *       |           set to zero if file open failed
 *       | unsigned char params[]
 *       |  -> unused
 * 
 * -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 * Command     : WL_SPICMD_BUPREAD
 * Description : Read backup data at specified block ID.
 *             : Size is limited to one block (512 bytes) per transaction.
 * Outline     : 
 *    1. Send read request from MAX10
 *       | (wl_spicomm_memacc_t*)params[]
 *       |  -> addr : block ID
 *       |           (0 = first block, 1 = block from 512th byte etc)
 *       | unsigned char data[]
 *       |  -> unused
 *    2. Send back read data to MAX10
 *       | (wl_spicomm_memacc_t*)params[]
 *       |  -> len : read data length (512 bytes) on success
 *       |           set to zero if read failed
 *       | unsigned char data[]
 *       |  -> read data itself
 * 
 * -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 * Command     : WL_SPICMD_BUPWRITE
 * Description : Write backup data at specified block ID.
 *             : Size is limited to one block (512 bytes) per transaction.
 * Note #1     : Write data is gathered on STM32 side and consecutive blocks
 *             : are written in a single time.
 * Note #2     : Write data contents are automatically flushed to SD card
 *             : after an interval of time without write request from MAX 10.
 * Outline     : 
 *    1. Send write request from MAX10
 *       | (wl_spicomm_memacc_t*)params[]
 *       |  -> addr : block ID
 *       |           (0 = first block, 1 = block from 512th byte etc)
 *       | unsigned char data[]
 *       |  -> data to write
 *    2. Send back write ACK to MAX10
 *       | (wl_spicomm_memacc_t*)params[]
 *       |  -> len : written data length (512 bytes) on success
 *       |           set to zero if write failed
 *       | unsigned char data[]
 *       |  -> unused
 * 
 * -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 * Command     : WL_SPICMD_BUPCLOSE
 * Description : Close backup data access to SD card.
 *             : (After that, backup data read/write return an error)
 * Note #1     : Write data is automatically gathered and synchronized on STM32
 *             : side so that it should not be necessary to use this command
 *             : in normal time.
 * Outline     : 
 *    1. Send close request from MAX10
 *       | unsigned char params[]
 *       |  -> unused
 *       | unsigned char data[]
 *       |  -> unused
 *    2. Send back close ACK to MAX10
 *       | (wl_spicomm_memacc_t*)params[]
 *       |  -> len : length (in KB unit) of file just closed
 *       |           set to zero if close failed
 *       | unsigned char data[]
 *       |  -> unused
 * 
 */
#define WL_SPICMD_BUPOPEN  0x28
#define WL_SPICMD_BUPREAD  0x29
#define WL_SPICMD_BUPWRITE 0x2A
#define WL_SPICMD_BUPCLOSE 0x2B

#define WL_SPICMD_IS_BUP(_CMD_) (((_CMD_) >= WL_SPICMD_BUPOPEN) && ((_CMD_) <= WL_SPICMD_BUPCLOSE) ? 1 : 0)

typedef struct _wl_spicomm_memacc_t
{
    /* Read start address.
     * This is the address within STM32 space.
     *
     * When accessing backup memory, this is the block ID.
     */
    unsigned long addr;

    /* Length, in byte unit.
     * This is the length of the data to read, 
     * which is limited to length of packet .
     *
     * When reading or writing backup memory, this should
     * be set to actual data length, hence 512 bytes for now.
     *
     * When opening backup memory, this should be set to
     * backup memory size, in KB unit. (ex: 0.5MB -> set to 512)
     */
    unsigned long len;

    /* Boot ROM ID.
     * This is used to specify which ROM file should be read.
     *
     * Available values :
     *  - 0    : Pseudo Saturn Kai
     *  - 1    : KOF95
     *  - 2    : Ultraman
     *  - 3-14 : (Reserved)
     *  - 15   : Firmware internal boot ROM
     */
    unsigned char rom_id;

    /* Unused, reserved for future usage if any. */
    unsigned char unused[WL_SPI_PARAMS_LEN - 4 - 4 - 1];
} wl_spicomm_memacc_t;


#endif // WASCA_LINK_SPI_H
