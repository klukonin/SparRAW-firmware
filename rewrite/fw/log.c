// SPDX-License-Identifier: AGPL-3.0-or-later
/* Журнал прошивки: кольцо 0x843900 и запись в него (fw_log_emit0..3). */
#include "../include/types.h"
#include "../include/dbg.h"
#include "../include/hw.h"


/* Лог версии прошивки (0x8f492c). */
void fw_version_log(u32 a0, u32 a1, u32 a2, u32 a3)
{
    fw_log_emit3(0x20, 0x100169c, a0, a1, a3);
    MMIO32(HW_FW_VERSION_MAJOR) = a0;
    MMIO32(HW_FW_VERSION_MINOR) = a1;
    MMIO32(HW_FW_VERSION_SUBMINOR) = a2;
    MMIO32(HW_FW_VERSION_BUILD) = a3;
}

/* Лог даты версии (0x8f4938). */
void fw_version_log_date(u8 a0, u8 a1, u8 a2, u8 a3, u8 a4, u8 a5)
{
    fw_log_emit3(0x20, 0x1001668, a3, a4, a5);
    fw_log_emit3(0x20, 0x1001680, a2, a1, a0);
    MMIO32(HW_FW_TIMESTAMP_HOUR) = a2;
    MMIO32(HW_FW_TIMESTAMP_MINUTE) = a1;
    MMIO32(HW_FW_TIMESTAMP_SECOND) = a0;
    MMIO32(HW_FW_TIMESTAMP_DAY) = a3;
    MMIO32(HW_FW_TIMESTAMP_MONTH) = a4;
    MMIO32(HW_FW_TIMESTAMP_YEAR) = a5;
}

/* Установить «flavor» образа (0x8f43cc). */
void fw_image_info_set_flavor(u32 v)
{
    MMIO32(HW_FW_IMAGE_FLAVOR) = v;
}

/* Лог версии bootloader (0x8f8184). */
void bootloader_version_log(void)
{
    u32 a, b, c, d;
    mac_read_880a2c_38(&a, &b, &c, &d);
    MMIO32(HW_BL_VERSION_BUILD) = d;
    MMIO32(HW_BL_VERSION_SUBMINOR) = c;
    MMIO32(HW_BL_VERSION_MINOR) = b;
    MMIO32(HW_BL_VERSION_MAJOR) = a;
    fw_log_emit3(0x20, 0x10016b4, a, b, d);
}

/* Инициализация кольца журнала и публикация адреса драйверу (0x880004).
 * Портировано из fw_log__init_ring (0x8dcb1c). */
void fw_log_init_ring(void)
{
    fw_log.wr_idx = 0;
    if (fw_log_ring_en == 0)
        fw_sysassert_fatal((void *)0, 0xf8);

    for (u32 i = 0; i < 0x10; i++)   /* 16 байт масок уровня = 7 */
        fw_log.lvl_mask[i] = 7;

    memset0_words(fw_log.ring, sizeof(fw_log.ring));
    MMIO32(HW_RGF_USER_USAGE_1) = (u32)&fw_log; /* публикация адреса журнала */
}

/* Запись журнала в кольцо 0x843900 (fw_log_emit0..3, 0x8dcba8/0x8dcc10/0x8dcc80/0x8dcd00).
 * Кольцо: [0] — счётчик слов (не маскируется), +4 — 16 байт масок уровней по модулям,
 * +0x14 — 0x400 слов. hdr: [3:0] модуль, [5:4] уровень — запись только при бите уровня
 * в маске модуля. Запись: слово заголовка (токен[19:0] | min(TSF_hi, 0xff) << 18 | n << 26
 * | бит 29 | бит 31), слово TSF_lo, n аргументов. Прежде emit-функции были пустыми — на стенде
 * журнал нашего fw нечем было сравнить с vendor. */
static void fw_log_put(u32 hdr, u32 token, u32 n, u32 a0, u32 a1, u32 a2)
{
    u32 tsf[2];
    u32 idx, hi;

    if (!((VOL(fw_log.lvl_mask[hdr & 0xf]) >> ((hdr >> 4) & 3)) & 1))
        return;
    idx = VOL(fw_log.wr_idx);
    if ((n & 3) >= 3)
        VOL(fw_log.ring[(idx + 4) & 0x3ff]) = a2;
    if ((n & 3) >= 2)
        VOL(fw_log.ring[(idx + 3) & 0x3ff]) = a1;
    if ((n & 3) >= 1)
        VOL(fw_log.ring[(idx + 2) & 0x3ff]) = a0;
    mac_read_tsf64(0, tsf, 0);
    hi = tsf[1] < 0xff ? tsf[1] : 0xff;
    idx = VOL(fw_log.wr_idx);
    VOL(fw_log.ring[(idx + 1) & 0x3ff]) = tsf[0];
    VOL(fw_log.ring[idx & 0x3ff]) = (token & 0xfffff) | ((hi & 0xff) << 18) | (n << 26)
                                     | (1u << 29) | (1u << 31);
    VOL(fw_log.wr_idx) = idx + 2 + (n & 3);
}

void fw_log_emit0(u32 hdr, u32 token)
{
    fw_log_put(hdr, token, 0, 0, 0, 0);
}

void fw_log_emit1(u32 hdr, u32 token, u32 a0)
{
    fw_log_put(hdr, token, 1, a0, 0, 0);
}

void fw_log_emit2(u32 hdr, u32 token, u32 a0, u32 a1)
{
    fw_log_put(hdr, token, 2, a0, a1, 0);
}

void fw_log_emit3(u32 hdr, u32 token, u32 a0, u32 a1, u32 a2)
{
    fw_log_put(hdr, token, 3, a0, a1, a2);
}

/* Варианты со строковыми аргументами (0x8dcd90 — один, 0x8dce04 — два): аргументы —
 * токены строк журнала; в заголовке дополнительно бит 28 (0xb4000000 / 0xb8000000 вместо
 * 0xa4000000 / 0xa8000000) — n | 4 даёт его через n << 26. */
void fw_log_emit_str1(u32 hdr, u32 token, u32 s0)
{
    fw_log_put(hdr, token, 1 | 4, s0, 0, 0);
}

void fw_log_emit_str2(u32 hdr, u32 token, u32 s0, u32 s1)
{
    fw_log_put(hdr, token, 2 | 4, s0, s1, 0);
}
