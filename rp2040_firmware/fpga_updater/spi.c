#include "pico/stdlib.h"

// Replace these macros with your GPIO writes/reads
#define QSPI_CLK_PIN 7
#define QSPI_CS_PIN 3
#define QSPI_D0_PIN 5
#define QSPI_D1_PIN 11
#define QSPI_D2_PIN 1
#define QSPI_D3_PIN 12
#define PROGRAMN_PIN 18

#define CS_LOW()     gpio_put(QSPI_CS_PIN,0)
#define CS_HIGH()    gpio_put(QSPI_CS_PIN,1)
#define CLK_LOW()    gpio_put(QSPI_CLK_PIN,0)
#define CLK_HIGH()   gpio_put(QSPI_CLK_PIN,1)
#define MOSI_LOW()   gpio_put(QSPI_D0_PIN,0)
#define MOSI_HIGH()  gpio_put(QSPI_D0_PIN,1)
#define MISO_READ()  gpio_get(QSPI_D1_PIN)

static void spi_delay(void) {
    // small delay, or NOPs
}

static uint8_t spi_txrx(uint8_t v) {
    uint8_t r = 0;

    for (int i = 0; i < 8; i++) {
        CLK_LOW();

        if (v & 0x80) MOSI_HIGH();
        else          MOSI_LOW();

        spi_delay();

        CLK_HIGH();
        r <<= 1;
        if (MISO_READ()) r |= 1;

        spi_delay();
        v <<= 1;
    }

    CLK_LOW();
    return r;
}

static void w25q_write_enable(void) {
    CS_LOW();
    spi_txrx(0x06);          // Write Enable
    CS_HIGH();
}

static uint8_t w25q_read_status1(void) {
    uint8_t s;

    CS_LOW();
    spi_txrx(0x05);          // Read Status Register-1
    s = spi_txrx(0xFF);
    CS_HIGH();

    return s;
}

static void w25q_wait_busy(void) {
    while (w25q_read_status1() & 0x01) {
        // WIP/BUSY bit
    }
}

void w25q_page_program(uint32_t addr, const uint8_t *data, uint16_t len) {
    if (len > 256) len = 256;

    // Do not cross page boundary
    uint16_t page_remain = 256 - (addr & 0xFF);
    if (len > page_remain) len = page_remain;

    w25q_write_enable();

    CS_LOW();
    spi_txrx(0x02);                  // Page Program
    spi_txrx((addr >> 16) & 0xFF);   // A23..A16
    spi_txrx((addr >> 8) & 0xFF);    // A15..A8
    spi_txrx(addr & 0xFF);           // A7..A0

    for (uint16_t i = 0; i < len; i++) {
        spi_txrx(data[i]);
    }

    CS_HIGH();

    w25q_wait_busy();
}

void w25q_sector_erase_4k(uint32_t addr) {
    w25q_write_enable();

    CS_LOW();
    spi_txrx(0x20);                  // Sector Erase 4KB
    spi_txrx((addr >> 16) & 0xFF);
    spi_txrx((addr >> 8) & 0xFF);
    spi_txrx(addr & 0xFF);
    CS_HIGH();

    w25q_wait_busy();
}