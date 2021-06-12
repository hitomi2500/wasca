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
 * Outline of SPI communication between MAX 10 and STM32 :
 *  - MAX 10 is SPI master
 *  - Two synchronization signals are shared between master and slave :
 *    - MOSI SYNC : indicate that MAX 10 is requesting communication
 *                  (direction from MAX 10 to STM32)
 *    - MISO SYNC : indicate that STM32 is ready to communicate
 *                  (direction from STM32 to MAX 10)
 * ==========================================================================
 * | Contents | (1)     | (2) | (3) | (4)    | (5) | (6) | (7)      | (1)    
 * ==========================================================================
 * | MOSI SYNC|_________             ________________________________________
 * |          |         |___________|                                        
 * ==========================================================================
 * | MISO SYNC|_______________                      ________________________
 * |          |               |____________________|                         
 * ==========================================================================
 * | SPI      |                     |  M->S  |           |  S<->M  |         
 * ==========================================================================
 *  (1) Idle : MAX 10 and STM32 are doing non-SPI things
 *  (2) MAX 10 requesting communication with STM32
 *  (3) STM32 indicating it is ready to listen
 *  (4) Transfer of packet from MAX 10 to STM32
 *      -> Fixed (and small) data size
 *  (5) Processing of packet and preparation of response data on STM32 side
 *      -> Use synchronization signal to indicate when response is ready
 *  (6) STM32 indicating it is ready to send response
 *  (7) Full duplex data transfer between MAX 10 and STM32
 *      -> Variable (large if necessary) data size, depending of packet contents
 *         (Data size upper limit depends on implementation on STM32 side)
 *      -> If MAX 10 needs to send a large chunk of data, this is done here
 *         Example : write backup memory block on SD card
 *      -> If MAX 10 needs to receive a large chunk of data, this is done here
 *         Example : boot ROM data read from SD card
 *
 *****************************************************************************/


/* Size (byte unit) to hold parameters included in communication header.
 * Usage varies from a kind of packet to another, and this size is set
 * to be large enough to hold each cases.
 */
#define WL_SPI_PARAMS_LEN 16

/* Maximum length of data block exchanged after SPI header.
 * 
 * It must be large enough to hold :
 *  - at least one backup memory block = 512 bytes.
 *  - MAX 10 logs buffer = WL_LOG_BUFFER_SIZE bytes.
 *  - Data length of other commands, which shouldn't take more than 512 bytes.
 * 
 * 
 * This is the maximum value of a data block, and each command is designed
 * to set data length to only what is actually needed. So tuning this value to
 * a larger one shall not degrade SPI transfer speed.
 * However the larger length the less transmission overhead, but the more
 * memory it takes on STM32 sides.
 *
 *
 * About memory usage :
 *  - MAX 10 : header x1, data block x0 (*)
 *  - STM32  : header x1, data block x2
 * (*) Refers to onchip RAM usage, data blocks are declared on SDRAM.
 *
 *
 * Some notes about SPI transfer speed according to block data length :
 *  -  512 bytes : 1MB ROM loaded at 467 KB/s (2.2 sec)
 *  - 1024 bytes : 1MB ROM loaded at 544 KB/s (1.9 sec)
 *  - 2048 bytes : 1MB ROM loaded at 615 KB/s (1.7 sec)
 *  - 8192 bytes : 1MB ROM loaded at 641 KB/s (1.6 sec)
 *  - 16K  bytes : 1MB ROM loaded at 669 KB/s (1.5 sec)
 * Remark : first ROM read after MAX 10 and STM32 startup is a bit (8%-ish)
 *          slower than the results above. Maybe caused by SD card access, or
 *          to initialize some FatFs internals ?
 * Example (8KB block) : 606 KB/s on first read, then 641 KB/s after that
 */
#define WL_SPI_DATA_MAXLEN (8*1024)


/* Maximum length of the full path of a file, 
 * including terminating null character.
 */
#define WL_MAX_PATH 256

typedef struct _wl_spi_header_t
{
    /* Always set to 0xCA. */
    unsigned char magic_ca;

    /* Always set to 0xFE. */
    unsigned char magic_fe;

    /* Command ID. */
    unsigned char command;

    /* Reserved for future use. */
    unsigned char reserved1[1];

    /* Parameters, whose contents differ for each kind of packet. */
    unsigned char params[WL_SPI_PARAMS_LEN];

    /* Length of data exchanged after this header, in byte unit.
     *
     * Note #1 : length must be a multiple of two bytes.
     *
     * Note #2 : length excludes this header, so that zero means that
     *           data block is not exchanged.
     */
    unsigned short data_len;

    /* Reserved for future use. */
    unsigned char reserved2[2];
} wl_spi_header_t;




/* MAX 10 / STM32 firmware version exchange.
 *
 * Transfer outline :
 *  1. Send header from MAX 10
 *     | M->S : wl_spi_header_t
 *     | S->M : nothing special
 *  2. Exchange version information between MAX 10 and STM32
 *     | M->S : wl_verinfo_max_t : MAX 10 firmware version
 *     | S->M : wl_verinfo_stm_t : STM32 firmware version
 *
 * Note : Version is requested from MAX 10 to STM32 during firmware startup, 
 *        so that if it is kept in a global variable, STM32 is able to
 *        check MAX 10 version any time after that.
 */
#define WL_SPICMD_VERSION 0x10

typedef struct _wl_verinfo_max_t
{
    /* MAX 10 device type.
     * Example : "10M16SAE144C8G"
     * Note : null-terminated string.
     */
    char dev_type[16];

    /* MAX 10 firmware (PL part) synthesis time.
     * It is formatted as unsigned integer at 32 bits
     * and 16 bits data size for respectively date and time.
     * Example : "2019/08/28 19:44" -> 20190828 (32 bits) and 1944 (16 bits)
     */
    unsigned long  pl_date;
    unsigned short pl_time;

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

    /* Onchip RAM size.
     * From Nios BSP's system.h.
     * Unit : byte
     */
    unsigned long ocram_size;

    /* Reserved for future usage if any.
     * (Pack the size of this structure 64 bytes)
     */
    unsigned char reserved[16];
} wl_verinfo_max_t;

typedef struct _wl_verinfo_stm_t
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

    /* Reserved for future usage if any.
     * (Pack the size of this structure 64 bytes)
     */
    unsigned char reserved[42];
} wl_verinfo_stm_t;

/* Packet data size required when requesting
 * firmware version information.
 */
#define WL_SPIDATALEN_VERSION ((sizeof(wl_verinfo_max_t) > sizeof(wl_verinfo_stm_t)) ? sizeof(wl_verinfo_max_t) : sizeof(wl_verinfo_stm_t))


/* Send log messages to STM32.
 *
 * Transfer outline :
 *  1. Send header from MAX 10
 *     | M->S : wl_spi_header_t
 *     | S->M : nothing special
 *  2. Send log message(s) from MAX 10
 *     | M->S : unsigned char data[] (size specified in header sent above)
 *     | S->M : nothing special
 *     | 
 *     | Note : log messages must be separated with null character
 *     | Note : final null character at the end of data block is not necessary
 */
#define WL_SPICMD_LOGS 0x11


/* Log levels :
 *  - 1 : critical messages
 *    ...
 *  - 5 : debug messages
 *
 * Level can be used to filter logs on MAX 10 / STM32 side, 
 * or sent with message to PC so that it can be dynamically
 * filtered there.
 */
#define WL_LOG_ERROR       1
#define WL_LOG_IMPORTANT   2
#define WL_LOG_DEBUGEASY   3
#define WL_LOG_DEBUGNORMAL 4
#define WL_LOG_DEBUGHARD   5



/* Log messages buffer.
 * 
 * This is declared on both MAX 10 and STM32 sides :
 *  - MAX 10 uses a log buffer to send multiple messages in a single SPI packet.
 *  - STM32 uses a log buffer to parse logs after they are received.
 * 
 * (If needed, the size should be adjusted according to resources available)
 */
#define WL_LOG_BUFFER_SIZE 512

/* Maximum length when formatting log messages on MAX 10 or STM32 side.
 * 
 * Messages longer than this length are truncated.
 */
#define WL_LOG_MESSAGE_MAXLEN 100




/* MAX 10 / STM32 SPI communication ping.
 *
 * Transfer outline :
 *  1. Send header from MAX 10
 *     | M->S : wl_spi_header_t
 *     |        | (wl_spi_ping_params_t*)params[]
 *     |        | | -> contains CRC test length, test pattern settings etc
 *     | S->M : nothing special
 *  2. Send ping parameters and test data from both MAX 10 and STM32 sides
 *     | M->S : wl_spi_ping_verif_t + data (variable size, indicated in step 1)
 *     | S->M : wl_spi_ping_verif_t + data (variable size, indicated in step 1)
 *
 * Note : wl_spi_ping_verif_t contains integrity result of received data.
 *        But because it is sent packed with test data, this result concerns
 *        previous ping request.
 */
#define WL_SPICMD_PING 0x12

typedef struct _wl_spi_ping_params_t
{
    /* Length of data to exchange with STM32.
     * It can be different from crc_len and can't be larger than : 
     *  WL_SPI_DATA_MAXLEN - sizeof(wl_spi_ping_verif_t)
     */
    unsigned short data_len;

    /* Length of data where to compute CRC from.
     * It must be set between zero (empty CRC) and data_len (all data).
     *
     * Protip : as it is possible to set this length independently from length
     *          specified in SPI header, setting crc_len to zero allows to
     *          measure SPI transfer speed without the overhead caused by
     *          CRC computation.
     */
    unsigned short crc_len;

    /* Test pattern types. */
#define WL_SPI_PING_NOTSET    0 /* Unitialized data, to measure speed. */
#define WL_SPI_PING_RANDOM    1 /* Random value.                       */
#define WL_SPI_PING_CONSTANT  2 /* Constant value.                     */
#define WL_SPI_PING_INCREMENT 3 /* Incremental value.                  */
    unsigned char pattern;

    /* Unused, for data alignment purpose. */
    unsigned char unused[3];

    /* Extra data that can be used when generating test pattern data.
     * Example : constant value, random seed, etc.
     */
    unsigned long pattern_seed;
} wl_spi_ping_params_t;

typedef struct _wl_spi_ping_verif_t
{
    /* CRC of data following this structure.
     * It concerns data set on this device.
     */
    unsigned long crc_val;

    /* Unused, for data alignment reason. */
    unsigned char unused;

    /* CRC verification result of previous ping request.
     *  0   : no error
     *  else: error
     *
     * It concerns data set on remote device.
     */
    unsigned char prev_crc_fail;

    /* Total count of CRC error(s) that happened so far.
     * Note : this doesn't includes result for this ping request.
     *
     * It concerns data set on remote device.
     */
    unsigned short crc_error_total;

    /* Total count of tests done so far. */
    unsigned long count_total;
} wl_spi_ping_verif_t;



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
 * Limitation : in order to optimize memory usage on STM32 side, boot ROM and
 *              backup memory features can't be used together.
 *              As a consequence, it is required to load boot ROM and then
 *              backup memory separately when initialyzing the cartridge.
 *
 * -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 * Command     : WL_SPICMD_BOOTINFO
 * Description : Check boot ROM file and return details about it.
 * Outline     : 
 *  1. Send header from MAX 10
 *     | M->S : wl_spi_header_t
 *     |        | data_len set to sizeof(wl_spi_bootinfo_t)
 *     |        | (wl_spi_memacc_t*)params[]
 *     |        | | rom_id : boot ROM ID
 *     |        | |          (Pseudo Saturn Kai / KOF95 / Ultraman / etc)
 *     | S->M : nothing special
 *  2. Send back boot ROM details to MAX 10
 *     | M->S : nothing special
 *     | S->M : wl_spi_bootinfo_t
 *     |        | -> status, length, path to file etc
 * 
 * -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 * Command     : WL_SPICMD_BOOTREAD
 * Description : Read boot ROM data at specified offset and length.
 *               Size is limited to one data block per transaction.
 *               Contents outside of boot ROM are filled with FFh value.
 * Note #1     : Boot ROM file is opened on first read, and closed when 
 *               last block is accessed, so it is recommended to read it
 *               sequentially from its beginning to end on MAX 10 side.
 * Outline     : 
 *  1. Send header from MAX 10
 *     | M->S : wl_spi_header_t
 *     |        | (wl_spi_memacc_t*)params[]
 *     |        | | rom_id : unused
 *     |        | |          (used when WL_SPICMD_BOOTINFO command is sent)
 *     |        | | addr   : offset within boot ROM, in byte unit
 *     |        | | len    : read data length, maximum WL_SPI_DATA_MAXLEN bytes
 *     | S->M : nothing special
 *  2. Send back boot ROM contents to MAX 10
 *     | M->S : unsigned char data[] (size specified in header sent above)
 *     | S->M : nothing special
 *     | 
 *     | Note : data read outside of ROM boundaries is returned as FFh bytes.
 * 
 * -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 * Command     : WL_SPICMD_BOOTREG
 * Description : Register specified file path as cartridge boot ROM.
 *               (Save the path into a settings file)
 * Outline     : 
 *  1. Send header from MAX 10
 *     | M->S : wl_spi_header_t
 *     |        | data_len set to sizeof(wl_spi_bootinfo_t)
 *     |        | (wl_spi_memacc_t*)params[]
 *     |        | | rom_id : boot ROM ID
 *     |        | |          (Pseudo Saturn Kai / KOF95 / Ultraman / etc)
 *     | S->M : nothing special
 *  2. Send path to file from MAX 10
 *     | M->S : wl_spi_bootinfo_t
 *     |        | -> Contains full path to cartridge boot ROM file
 *     | S->M : nothing special
 * 
 */
#define WL_SPICMD_BOOTINFO 0x24
#define WL_SPICMD_BOOTREAD 0x25
#define WL_SPICMD_BOOTREG  0x26 // (Implementation will be done later)

#define WL_SPICMD_IS_BOOTROM(_CMD_) (((_CMD_) >= WL_SPICMD_BOOTINFO) && ((_CMD_) <= WL_SPICMD_BOOTREG) ? 1 : 0)

typedef struct _wl_spi_bootinfo_t
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
     */
#define WL_BOOTROM_RECOV 0
#define WL_BOOTROM_FILE  1
    unsigned char status;

    /* Unused, reserved for future usage if any. */
    unsigned char reserved[3];

    /* Full path to file.
     * Set to empty string when loading from STM32 ROM.
     */
    char path[WL_MAX_PATH];
} wl_spi_bootinfo_t;



/* Command IDs for backup memory block access.
 * These commands re-use the same data structure and outline as memory access.
 *
 * Limitation : boot ROM and backup memory features can't be used together.
 *
 * -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 * Command     : WL_SPICMD_BUPOPEN
 * Description : Open backup file with specified data length.
 *               If already open, previous file is closed.
 *               If not exist, contents are allocated and initialized to FFh.
 *               File name is decided on STM32 side and depends on data size.
 * Outline     : 
 *  1. Send open request from MAX 10
 *     | M->S : wl_spi_header_t
 *     |        | data_len set to sizeof(wl_spi_memacc_t)
 *     |        | (wl_spi_memacc_t*)params[]
 *     |        | | len : backup data length, KB unit
 *     |        | |       (0.5MB = 512KB, 1MB = 1MB etc)
 *     | S->M : nothing special
 *  2. Send path to file from MAX 10
 *     | M->S : wl_spi_memacc_t
 *     |        | len : same as input parameter on success
 *     |        |       set to zero if file open failed
 *     | S->M : nothing special
 * 
 * -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 * Command     : WL_SPICMD_BUPREAD
 * Description : Read backup data from specified block ID.
 * Outline     : 
 *  1. Send read request from MAX 10
 *     | M->S : wl_spi_header_t
 *     |        | data_len set to a mutiple of 512 bytes = length of one block
 *     |        | (wl_spi_memacc_t*)params[]
 *     |        | | addr : read start block ID
 *     |        | |        (0 = first block, 1 = block #2 from 512th byte etc)
 *     |        | | len    : read data length, maximum WL_SPI_DATA_MAXLEN bytes
 *     | S->M : nothing special
 *  2. Send back read data to MAX 10
 *     | M->S : nothing special
 *     | S->M : unsigned char data[512 x N] : read data itself
 * 
 * -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 * Command     : WL_SPICMD_BUPWRITE
 * Description : Write backup data from specified block ID.
 *               Size is limited to one block (512 bytes) per transaction.
 * Note #1     : Write data is gathered on STM32 side and consecutive blocks
 *               are written in a single time.
 * Note #2     : Write data contents are automatically flushed to SD card
 *               after an interval of time without write request from MAX 10.
 * Outline     : 
 *  1. Send write request from MAX 10
 *     | M->S : wl_spi_header_t
 *     |        | data_len set to a mutiple of 512 bytes = length of one block
 *     |        | (wl_spi_memacc_t*)params[]
 *     |        | | addr : write start block ID
 *     |        | |        (0 = first block, 1 = block #2 from 512th byte etc)
 *     |        | | len    : write data length, maximum WL_SPI_DATA_MAXLEN bytes
 *     | S->M : nothing special
 *  2. Send data to write to STM32
 *     | M->S : unsigned char data[512 x N] : data to write
 *     | S->M : nothing special
 * 
 * -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 * Command     : WL_SPICMD_BUPCLOSE
 * Description : Close backup data access to SD card.
 *               (After that, backup data read/write return an error)
 * Note #1     : Write data is automatically gathered and synchronized on STM32
 *               side so that it should not be necessary to use this command
 *               in normal time.
 * Outline     : 
 *  1. Send open request from MAX 10
 *     | M->S : no parameter to set
 *     | S->M : nothing special
 *  2. Send back close ACK to MAX 10
 *     | M->S : wl_spi_memacc_t
 *     |        | len : length (in KB unit) of file just closed
 *     |        |       set to zero if couldn't close the file
 *     | S->M : nothing special
 * 
 */
#define WL_SPICMD_BUPOPEN  0x28
#define WL_SPICMD_BUPREAD  0x29
#define WL_SPICMD_BUPWRITE 0x2A
#define WL_SPICMD_BUPCLOSE 0x2B

#define WL_SPICMD_IS_BUP(_CMD_) (((_CMD_) >= WL_SPICMD_BUPOPEN) && ((_CMD_) <= WL_SPICMD_BUPCLOSE) ? 1 : 0)

typedef struct _wl_spi_memacc_t
{
    /* Read start address.
     * This is the address within boot ROM file.
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
     *  -  0    : Pseudo Saturn Kai
     *  -  1    : KOF95
     *  -  2    : Ultraman
     *  -  3-13 : (Reserved)
     *  - 14    : WascaLoader
     *  - 15    : Firmware internal boot ROM
     */
    unsigned char rom_id;

    /* Unused, reserved for future usage if any. */
    unsigned char reserved[3];

    /* Unused, reserved for future usage if any. */
    unsigned char unused[WL_SPI_PARAMS_LEN - 4 - 4 - 4];
} wl_spi_memacc_t;


#endif // WASCA_LINK_SPI_H
