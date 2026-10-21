// SPDX-License-Identifier: AGPL-3.0-or-later
/* Чтение SPI (flash) — hwd_spi_read (0x8f9294). */
#include "../include/types.h"
#include "../include/arc.h"
#include "../include/hw.h"

/* Пустая задержка vendor: lp_count = n; nop_s; lp, тело — 2 nop_s (0x8f925e, 0x8f92b8). n > 0. */
static inline __attribute__((always_inline)) void spi_nop_delay(u32 n)
{
    arc_zol_nops2_mb(n);
}

/* hwd_spi__lock (0x8f9248): до a раз — прочитать [0x8801a8], выдержка 800 × 2 nop_s,
 * выход при сброшенном бите 31; успех — [0x880a88] = 0x1234 (FW locked). */
u32 hwd_spi_poll_done(u32 a)
{
    u32 status = 0;
    u32 i = 0;
    for (;;) {
        status = MMIO32(HW_SPI_FLASH_CTRL);
        spi_nop_delay(800);
        i++;
        if ((status & (1u << 31)) == 0)
            break;
        if (i >= a)
            break;
    }
    if (status & (1u << 31))
        return 0;
    MMIO32(HW_FLASH_LOCK_OWNER) = 0x1234;
    return 1;
}

/* Снять блокировку SPI. */
void hwd_spi_release_lock(void)
{
    MMIO32(HW_FLASH_LOCK_OWNER) = 0x4321;
    MMIO32(HW_SPI_FLASH_CTRL) = 0;
}

u32 hwd_spi_read(u32 offset, u32 len, void *buf)
{
    if (!hwd_spi_poll_done(0x4c4b40)) {
        u32 a = MMIO32(HW_GUI_FLASH_LOCK_CNT);
        u32 b = MMIO32(HW_GUI_FLASH_UNLOCK_CNT);
        fw_log_emit2(0, 0x101ed8c, a, b);
        u32 c = MMIO32(HW_FLASH_LOCK_OWNER);
        if (c == 0x1234)
            fw_log_emit0(0, 0x101edc0);
        else if (c == 0x4321)
            fw_log_emit0(0, 0x101ede4);
        else
            fw_log_emit1(0, 0x101ee08, c);
        return 0;
    }

    /* Ожидание интерфейса (vendor 0x8f92b4): до 0x65 раз — выдержка 0x50 × 2 nop_s и
     * проверка бита 29 [0x8801a8] (занят); счётчик r13 = 100 уменьшается на каждой неудаче
     * (delay-слот brhs.d), лог «waited %d usec» — при любом ожидании (r13 != 100), значение
     * 100 - r13. Прежде лог был только при полном таймауте и со значением 0x64 - 0x65. */
    u32 waited = 0;
    for (u32 r18 = 0x65;; r18--) {
        spi_nop_delay(0x50);
        if (!(MMIO32(HW_SPI_FLASH_CTRL) & 0x20000000))
            break;
        waited++;
        if (r18 - 1 < 1)
            break;
    }
    if (waited != 0)
        fw_log_emit1(0x10, 0x101ed60, waited);

    /* Сисассерты vendor продолжают выполнение: 0x101e — интерфейс занят, 0x10ea — len >
     * 0x100 (bset 12 к 0xea; прежде было 0xcea). */
    if (MMIO32(HW_SPI_FLASH_CTRL) & (1u << 29))
        fw_sysassert_fatal(__builtin_return_address(0), 0x101e);
    if (len > 0x100)
        fw_sysassert_fatal(__builtin_return_address(0), 0x10ea);

    /* Команда чтения SPI. */
    MMIO32(HW_SPI_FLASH_ADDR) = offset;
    MMIO32(HW_SPI_FLASH_CMD) = len | 0x3030000u;
    MMIO32(HW_SPI_FLASH_CTRL) = 0xc0000000u;
    while (MMIO32(HW_SPI_FLASH_CTRL) & (1u << 29))
        ;

    /* Выгрузка слов из FIFO 0x8800a8. */
    u8 *dst = (u8 *)buf;
    u32 words = len >> 2;
    u32 i;
    for (i = 0; i < words; i++)
        *(u32 *)(dst + i * 4) = MMIO32(HW_SPI_FLASH_RDATA + i * 4);

    /* Остаточные байты (len & 3) из последнего слова. */
    u32 tail = len & 3;
    u32 last = MMIO32(HW_SPI_FLASH_RDATA + words * 4);
    for (i = 0; i < tail; i++)
        dst[words * 4 + i] = ((u8 *)&last)[i];

    hwd_spi_release_lock();
    return 1;
}
