/**
 *  Wasca Link - PC/Nios shared definition
 *  by cafe-alpha.
 *  WWW: http://ppcenter.free.fr/devblog/
 *
 *  See LICENSE file for details.
**/

#ifndef WASCA_LINK_H
#define WASCA_LINK_H

/* Select compilation target : BCB or NIOS or STM32. */
#ifdef TARGET_STM32
#else
#   ifndef _BCB
#       define TARGET_NIOS
#   else // _BCB
#       undef TARGET_NIOS
#   endif
#endif


/* Inclusion of structure alignment macros. */
#ifdef TARGET_STM32
#   define SC_ALIGN_4_BYTES(_STRUCT_NAME_) _STRUCT_NAME_
#   define SC_ALIGN_2_BYTES(_STRUCT_NAME_) _STRUCT_NAME_
#else
#   ifdef TARGET_NIOS
#       define SC_ALIGN_4_BYTES(_STRUCT_NAME_) _STRUCT_NAME_ __attribute__((aligned(4)))
#       define SC_ALIGN_2_BYTES(_STRUCT_NAME_) _STRUCT_NAME_ __attribute__((aligned(2)))
#   else // _BCB
#       define SC_ALIGN_4_BYTES(_STRUCT_NAME_) _STRUCT_NAME_
#       define SC_ALIGN_2_BYTES(_STRUCT_NAME_) _STRUCT_NAME_
#   endif
#endif


/* Definition of 64 bits integer type. */
#ifdef TARGET_STM32
#   define ulonglong_t unsigned __int64
#else // !TARGET_STM32
#   ifdef TARGET_NIOS
#       include <alt_types.h>
#       define ulonglong_t alt_u64
#   else // _BCB
#       define ulonglong_t unsigned __int64
#   endif
#endif



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
//#define WL_SPI_DATA_LEN 512
#define WL_SPI_DATA_LEN 896

/* Maximum length of the full path of a file, 
 * including terinating null character.
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

    /* Command-dependant parameter. */
    unsigned char param;

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
} SC_ALIGN_4_BYTES(wl_spi_common_hdr_t);

typedef struct _wl_spi_pkt_t
{
    wl_spi_common_hdr_t cmn;

    /* Parameters, whose contents differ for each datagram. */
    unsigned char params[WL_SPI_PARAMS_LEN];

    /* Data block. */
    unsigned char data[WL_SPI_DATA_LEN];

    /* Dummy bytes, do not access. */
    unsigned short dummy[2];
} SC_ALIGN_4_BYTES(wl_spi_pkt_t);


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
 *     | wl_spi_pkt_t
 *     |  -> params is ignored.
 *     |  -> data is ignored.
 *  2. Send back read data to MAX10
 *     | wl_spi_pkt_t
 *     |  -> params is empty.
 *     |  -> data contains wl_spicomm_version_t.
 */
#define WL_SPICMD_VERSION 0x10
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
} SC_ALIGN_4_BYTES(wl_spicomm_version_t);



/* STM32 Register (or memory) read (or write) access.
 * Also featuring backup memory block access and management.
 *
 * READ Transfer outline :
 *  1. Send read request from MAX10
 *     | wl_spi_pkt_t
 *     |  -> params contains wl_spicomm_memacc_t.
 *     |  -> data is ignored.
 *  2. Send back read data to MAX10
 *     | wl_spi_pkt_t
 *     |  -> params is empty.
 *     |  -> data contains the read data.
 *
 * WRITE Transfer outline :
 *  1. Send write request and data from MAX10
 *     | wl_spi_pkt_t
 *     |  -> params contains wl_spicomm_memacc_t.
 *     |  -> data contains data to write.
 *  2. Send back ACK to MAX10
 *     | wl_spi_pkt_t
 *     |  -> params contains wl_spicomm_memacc_t.
 *     |  -> data   is empty.
 */
#define WL_SPICMD_MEMREAD  0x20
#define WL_SPICMD_MEMWRITE 0x21



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
 *
 * -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 * Command     : WL_SPICMD_BOOTINFO
 * Description : Check boot ROM file and return details about it.
 * Outline     : 
 *    1. Send request from MAX10
 *       | unsigned char params[]
 *       |  -> unused
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
 *       |  -> addr : offset within boot ROM, in byte unit
 *       |  -> len  : read data length, maximum WL_SPI_DATA_LEN bytes
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
 *       | unsigned char params[]
 *       |  -> unused
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
} SC_ALIGN_4_BYTES(wl_spicomm_bootinfo_t);



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

    /* Unused, reserved for future usage if any. */
    unsigned char unused[WL_SPI_PARAMS_LEN - 4 - 4];
} SC_ALIGN_4_BYTES(wl_spicomm_memacc_t);





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
} SC_ALIGN_4_BYTES(wla_logs_stats_t);




/*****************************************************************************
 * The type of the CRC values.
 *
 * This type must be big enough to contain at least 8 bits.
 *****************************************************************************/
typedef unsigned char wl_crc_t;


/*****************************************************************************
 * Send/Receive transfer header.
 * Sent at the begining of each transfer.
 *****************************************************************************/
typedef struct _wl_sndrcv_hdr_t
{
    /* Always set to WL_HDR_MAGIC (0xCA), 
     * or WL_HDR_MAGIC_WARP (0x57).
     */
    unsigned char magic;

    /* Packet type. */
    unsigned char type;

    /* Data length, including this header. */
    unsigned short len;
} SC_ALIGN_4_BYTES(wl_sndrcv_hdr_t);


/*****************************************************************************
 * Header first byte, used for synchronization.
 *  - 0xCA : historical header, for normal communication with target CPLD
 *  - 0x57 ('W') : warp communication with MAX 10 Board via SIM
 *****************************************************************************/
#define WL_HDR_MAGIC_CA   (0xCA)
#define WL_HDR_MAGIC_WARP (0x57)

/*****************************************************************************
 * Header & data maximum length.
 * Too short length causes transmission overhead.
 * Too long length may cause a lot of packet
 * exchange retries error at high baud rate.
 *
 * As a consequence, a reasonable value between
 * transfer speed, stability and memory usage
 * is set.
 *****************************************************************************/
//#define WL_PKT_MAXLEN (64)
//#define WL_PKT_MAXLEN (4096)
#define WL_PKT_MAXLEN (1024)

/*****************************************************************************
 * Definition of each packet types and
 * associated data structures.
 *****************************************************************************/


/* Log message direct output.
 *
 * Transfer outline :
 *  1. Output from MAX10 to PC
 *       [header]
 *       [log string]
 *       [CRC]
 *
 * Notes :
 *  - Message is not null terminated.
 *  - Line break is appended on PC side.
 *  - Log output can happen anytime, including
 *    between unrelated packet exchange.
 */
//#define WL_PKT_LOGOUT  (0x10)


/* Log message polling.
 *
 * Transfer outline :
 *  1. Poll log messages from PC
 *       [header]
 *       [CRC]
 *  2. Send back log message(s) to PC
 *       [header]
 *       [log message(s)]
 *       [CRC]
 *
 * Notes :
 *  - When no log messages are available, only
 *    header is sent back to PC.
 *  - On MAX10 side, log messages are accumulated
 *    in a circular buffer, and on poll from PC,
 *    log messages are sent from this circular buffer.
 *  - Several messages can be sent at once, but theses are
 *    limited by packet maxumum length (WL_PKT_MAXLEN).
 *  - Single log message is not segmented into several
 *    packets : if is doesn't fits in current packet, it
 *    will then be sent in next one.
 */
//#define WL_PKT_LOGPOLL  (0x11)




/* Retrieve MAX10 version.
 *  - NIOS program build date
 *  - Pointer to log informations structure
 *
 * Transfer outline :
 *  1. Request from PC
 *       [header]
 *       [CRC]
 *  2. Answer back to PC
 *       [header]
 *       [version info]
 *       [CRC]
 *
 * Note : WL_PKT_VERSION_ARM retrieves version information
 *        from STM32, which may freeze MAX10 if SPI is not
 *        correctly set.
 */
#define WL_PKT_VERSION     (0x01)
#define WL_PKT_VERSION_ARM (0x02)
typedef struct _wl_verinfo_t
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


    /* STM32 firmware version.
     * (Structure size : 32 bytes)
     */
    wl_spicomm_version_t arm;
} SC_ALIGN_4_BYTES(wl_verinfo_t);


/* Retrieve MAX10 extended version.
 *  - Device type
 *  - Project name
 *
 * Transfer outline :
 *  1. Request from PC
 *       [header]
 *       [CRC]
 *  2. Answer back to PC
 *       [header]
 *       [version info]
 *       [CRC]
 */
#define WL_PKT_VERSION_EXT (0x03)
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
} SC_ALIGN_4_BYTES(wl_verinfo_ext_t);




/* Register/memory read access.
 *
 * Transfer outline :
 *  1. Send read request from PC
 *       [header]
 *       [access parameters]
 *       [CRC]
 *  2. Send back read data to PC
 *       [header]
 *       [data]
 *       [CRC]
 */
#define WL_PKT_READ    (0x20)
typedef struct _wl_reg_access_t
{
    /* Read start address.
     * This is the address within specified space.
     */
    unsigned long addr;

    /* Length, in byte unit.
     * This is the length of the data to write/read, 
     * which is not directly related to packet length.
     */
    unsigned short len;

    /* Address space codes :
     *  - NIOS address space.                   (SIM / Wasca)
     *  - Warp NIOS address space.              (Max 10 Board)
     *  - Saturn A-Bus.                         (Max 10 Board accessed from SIM)
     *  - ARM.                                  (Max 10 Board / Wasca)
     *  - Internals, including log stuff.       (SIM / Wasca)
     *  - Warp internals, including log stuff.  (MAX 10 Board)
     *  - Debug.                                (MAX 10 Board / Wasca)
     *
     * Theses codes are set to address upper 4 bits, 
     * except in Saturn A-Bus space which handles all
     * undefined space codes.
     */
#define WL_RDWR_ABUS_SPACE (0x0)
#define WL_RDWR_NIOS_SPACE (0xD)
#define WL_RDWR_ARM_SPACE  (0xA)
#define WL_RDWR_INT_SPACE  (0xE)
#define WL_RDWR_DBG_SPACE  (0xF)
    /* Additional address space codes, used to separate between
     * MAX 10 Board and SIM when warp communication is used.
     *
     * These codes are used on PC side only, to select appropriate
     * header (direct or warp) just before doing transmission.
     */
#define WL_SIMRDWR_NIOS_SPACE (0x4)
#define WL_SIMRDWR_INT_SPACE  (0x5)
    unsigned char space;

    /* Macros converting address to each spaces. */
#define WL_ABUS_ADDR(_ADR_) ((WL_RDWR_ABUS_SPACE << 28) | (_ADR_))
#define WL_NIOS_ADDR(_ADR_) ((WL_RDWR_NIOS_SPACE << 28) | (_ADR_))
#define WL_ARM_ADDR(_ADR_)  ((WL_RDWR_ARM_SPACE  << 28) | (_ADR_))
#define WL_INT_ADDR(_ADR_)  ((WL_RDWR_INT_SPACE  << 28) | (_ADR_))
#define WL_DBG_ADDR(_ADR_)  ((WL_RDWR_DBG_SPACE  << 28) | (_ADR_))

#define WL_SIM_NIOS_ADDR(_ADR_) ((WL_SIMRDWR_NIOS_SPACE << 28) | (_ADR_))
#define WL_SIM_INT_ADDR(_ADR_)  ((WL_SIMRDWR_INT_SPACE  << 28) | (_ADR_))
    /* Unused, for future usage if any. */
    unsigned char padding[1];
} SC_ALIGN_4_BYTES(wl_reg_access_t);

/* Packet data length for register/memory access.
 * Two data length are defined :
 *  - Fast, which uses mamimum length allowed for packet.
 *  - Safe, which restricts packet size to one UART transfer block.
 *
 * Note : read access have few bytes more available, 
 *        but in order to simplify things, the maximum
 *        length below is limited to read/write worst case.
 *
 * Note : the safe length is limited by UART implementation on
 *        MAX10 side :
 *         - RS232C : 128 bytes
 *         - MAX10 UART : #define ALT_AVALON_UART_BUF_LEN (WL_PKT_MAXLEN) -> 1KB
 *        It's probably possible to change this in a clean way, 
 *        but let's keep things simple from now.
 */
#define WL_RDWR_DATALEN_MAX  (WL_PKT_MAXLEN - sizeof(wl_sndrcv_hdr_t) - sizeof(wl_reg_access_t) - sizeof(wl_crc_t))

#define WL_RDWR_DATALEN_FAST (WL_RDWR_DATALEN_MAX)
#define WL_RDWR_DATALEN_SAFE (128 - 8       - sizeof(wl_sndrcv_hdr_t) - sizeof(wl_reg_access_t) - sizeof(wl_crc_t))


/* Definitions used when packet echange failed on PC side.
 *
 * WL_PKT_EXCHG_TRYCNT :
 *  Number of times packet exchanges are retried.
 *  When retry count exceeded this value, packet exchange
 *  function fails.
 *  Note : when using "safe" packet size packet exchange
 *         typically doesn't requires more than 3 retries.
 *
 * WL_RDWR_SAFE_SNDCNT : 
 *  Number of times packet at "safe" size must be sent
 *  after failure at fast size.
 *  This is based in the assumption that OS needs some
 *  time to put back resources in UART after consecutive
 *  error happened. Just a guess, and there's no theory
 *  behind that.
 */
#define WL_PKT_EXCHG_TRYCNT 5
#define WL_RDWR_SAFE_SNDCNT 100




/* Register/memory write access.
 *
 * Transfer outline :
 *  1. Send write request from PC
 *       [header]
 *       [access parameters]
 *       [data]
 *       [CRC]
 *  2. Send back ACK to PC
 *       [header]
 *       [CRC]
 *
 * Notes :
 *  - Access parameters structure
 *    is shared with read access.
 */
#define WL_PKT_WRITE   (0x30)




/* Memory Test.
 *
 * Transfer outline :
 *  1. Send request from PC
 *       [header]
 *       [test parameters]
 *       [CRC]
 *  2. (May append some log messages during testing)
 *  3. When finished, bumps counter in wl_memtest_res_t structure.
 */
#define WL_PKT_MEMTEST (0xFD)
typedef struct _wl_memtest_t
{
    /* Test start address.
     * Only NIOS address space supported.
     */
    unsigned long addr_stt;

    /* Test data length.
     * Unit : byte.
     */
    unsigned long len;

    /* Testing parameters.
     * (bitfield)
     */
#define WL_MEMTEST_8B     (1 <<  0)
#define WL_MEMTEST_16B    (1 <<  1)
#define WL_MEMTEST_32B    (1 <<  2)
#define WL_MEMTEST_55AA   (1 <<  4)
#define WL_MEMTEST_INCR   (1 <<  5)
    /* Memory random access test. */
#define WL_MEMTEST_R8B    (1 <<  8)
#define WL_MEMTEST_R16B   (1 <<  9)
#define WL_MEMTEST_R32B   (1 << 10)
    unsigned long params;

    /* (Pseudo) random number generation seed.
     * For use during random access test.
     */
    unsigned long rand_seed;
} SC_ALIGN_4_BYTES(wl_memtest_params_t);

typedef struct _wl_memtest_res_t
{
    /* Backup copy of test parameters. */
    wl_memtest_params_t params;

    /* Memory test availability.
     * 0: testing, 1: test finished (available).
     * Sending WL_PKT_MEMTEST packet is forbidden
     * when available status is set to zero.
     */
    unsigned char available;

    /* Random access error counts :
     *  - [0] : 8 bits access
     *  - [1] : 16 bits access (currently unused)
     *  - [2] : 32 bits access (currently unused)
     * Counts are clamped to maximum 255.
     */
    unsigned char ra_err_cnt[3];

    /* Error count during memory test.
     * Zero : test passed.
     */
    unsigned long err_cnt;

    /* Elapsed time during memory test.
     *
     * It is stored as 32 bits integer.
     * Unit : NIOS CPU clock count.
     * CPU frequency (typically, 116000000 Hz)
     * is set for reference.
     * As a consequence, maximum storable duration
     * is around 37 seconds, and larger values are
     * stored as 0xFFFFFFFF.
     *
     * Additionally, elapsed time for one
     * read (or write) access is indicated.
     * This elapsed time is relevant only
     * during fast memory test.
     *
     * And, iteration count is set too : this is
     * used to measure average read/write time.
     */
    unsigned long cntr_clk;
    unsigned long ite_cnt;

    /* Elapsed time (in CPU tick unit) between two
     * consecutive write access.
     * This can be used to get an idea of benchmark
     * in the MAX10/Nios/RAM/etc chain, but care must
     * be taken since its doesn't (can't) measure
     * a raw access to memory.
     */
    unsigned long write_time;
    /* The same as above, but for read access. */
    unsigned long read_time;
    /* Timing for miscellaneous access, specified
     * in testing parameters bitfield.
     */
    unsigned long misc_time;

    /* Random access test data size.
     *  - [0] : First test region size
     *  - [1] : Second test region size
     *          Set to zero when testing only one continous region.
     * (Set by MAX 10 from its few available resources)
     */
    unsigned short ra_length[2];
} SC_ALIGN_4_BYTES(wl_memtest_res_t);



#define WL_PKT_PING    (0xFE)




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



/* External memory (SDRAM or OCRAM) assignments.
 * MAX10 program runs in onchip RAM, which is relatively small.
 * So in order to reduce onchip RAM usage, the following global
 * variables are declared on SDRAM's last 1MB area :
 * - Link buffer, used when sending or receiving data.
 * - Logs circular buffer and miscellaneous internals.
 */
typedef struct _wasca_internals_t
{
    /* Log related informations :
     *  - Circular buffer
     *  - Message format buffer
     *  - Etc
     *
     * Note : this structure must be located
     *        at the top of this structure.
     *        If relocating is needed, then
     *        WL_LOGSINT_OFFSET
     *        must be changed accordingly.
     */
    log_infos_t log_infos;

    /* Memory test results.
     * Stores current memory test testing progress and result.
     */
    wl_memtest_res_t memtest_res;

    /* Can add more internal stuff below, if required. */

} wasca_internals_t;


/* Special definition for PC software, 
 * used when polling logs.
 *
 * This definition implies that log
 * informations must be stored at the
 * beginning of wasca_internals_t
 * structure.
 */
#define WL_LOGSINT_OFFSET (0)


/* Special definition for MAX10 software, 
 * used by modules having dependency with
 * Wasca internals.
 */
extern wasca_internals_t* wasca_internals;


#endif // WASCA_LINK_H
