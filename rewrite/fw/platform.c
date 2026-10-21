// SPDX-License-Identifier: AGPL-3.0-or-later
/* Определение платформы и strap-битов. */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/sys_cfg.h"
#include "../include/fwdata.h"

/* Описание платы и указатель на него ([gp,-0x18]). */
FWDATA(8009b4) struct plat_board_info plat_board = { 0 };
FWDATA(80016c) struct plat_board_info *volatile plat_board_info = &plat_board;

/* 0x880a3c при старте — тип платформы (драйвер записал 1=ASIC, 2=FPGA),
 * позже это поле станет boot_loader_ready. */
/* platform__is_asic (0x8da61c): [0x880a3c] == 1. Это boot_loader_ready: загрузчик пишет
 * BL_READY = 1 до загрузки fw (драйвер wil6210 ждёт его в wil_wait_device_ready), fw его
 * не трогает. Прежний эксперимент «всегда 1» убран — vendor читает регистр. */
u32 platform_is_asic(void)
{
    return MMIO32(BL_READY) == 1;
}

u32 platform_is_fpga(void)
{
    return MMIO32(BL_READY) == 2;
}

/* Strap-бит 0: прочитать, и при первом чтении — взвести (однократно). */
u32 boot_read_strap_bit(void)
{
    u32 v = MMIO32(HW_RGF_USER_USAGE_7);
    if (v & 1)
        return 1;
    MMIO32(HW_RGF_USER_USAGE_7) = v | 1;
    return 0;
}

/* Принудительный production-режим (magic 0x880ab8 = 1). */
void boot_force_production_mode(void)
{
    MMIO32(BL_MAGIC) = 1;
}

/* fw_status__set_state (0x8e8634): состояние прошивки для хоста (0x880a44). */
void fw_status_set_state(u32 v)
{
    MMIO32(BL_FW_STATE) = v;
}

/* fw_status__set_assert_marker (0x8e8640): маркер ассерта для хоста (0x880a48);
 * fw_sysassert_fatal пишет 0xdeaddead. */
void fw_status_set_assert_marker(u32 v)
{
    MMIO32(HW_FW_SUB_STATE) = v;
}

/* Публикация идентификаторов (MAC-адрес и размеры) — последний шаг перед
 * главным циклом. Портировано из boot__publish_ids (0x8e8578). */
void boot_publish_ids(void)
{
    u32 id = boot_publish_id;
    u8 *dst = plat_board_info->publish_id;
    dst[0] = (u8)id;
    dst[1] = (u8)(id >> 8);
    dst[2] = (u8)(id >> 16);
    dst[3] = (u8)(id >> 24);

    plat_board_info->uc_field28 = boot_uc_shared_field28;   /* vendor [gp-0x18]=0x80016c, НЕ 0x800124 (trace!) */

    /* vendor 0x8e85d6/0x8e85ea: sth.as [gp,63]/[gp,62] — .as у полуслова масштабирует на 2:
     * 0x800202 = 0x800202 и 0x800200 = 0x800200 (их читают qdesc_cfg — l2mgr.c,
     * mac_bringup.c). Прежде писалось в 0x800280/0x80027c (масштаб слова) — OUI-буфер. */
    u32 f = dashboard.cfg.special_flags;
    macq_desc_w1_len = (f & (1u << 12)) ? 0x64 : 0x17;
    macq_desc_mpdu_len = (f & (1u << 12)) ? 0x5dc : 0x320;
}
