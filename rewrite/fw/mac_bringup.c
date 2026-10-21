// SPDX-License-Identifier: AGPL-3.0-or-later
/* [ЧЕРНОВИК, сверен с asm] MAC bring-up: построение дескрипторов очередей и
 * RF-цепочки, конфигурация TX-очереди по режиму, последовательность init.
 *
 * Порт (исходники 6.2/src/asm/fw/_unknown/):
 *   qdesc__build_by_type            (0x8fa224, 372 Б)
 *   rf_chain__program_sector_desc   (0x8fa398, 812 Б)
 *   tx_queue__config_by_mode        (0x8f9fb0, 628 Б)
 *   mac_bringup__init_seq           (0x8fa6c4, 224 Б)
 *
 * Конвенции ARC, важные для этого файла:
 *   - gp = 0x800184 (см. start.S `mov gp, 0x800184`); смещения [gp,off] — байтовые.
 *   - ld_s/st_s — слово (32 бита), ldw_s/stw_s — полуслово (16 бит), ldb_s/stb_s — байт.
 *   - bf-хелперы (bits__set32_sX_wY) — это *p = bf_insert_field(*p, v, X, Y).
 *   - дескрипторы MACQ — struct macq_sector_desc / macq_mode_desc / macq_ba_desc /
 *     macq_desc (include/macq_desc.h).
 */
#include "../include/types.h"
#include "../include/mac_parser.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/macq_desc.h"
#include "../include/sys_cfg.h"
#include "../include/fwdata.h"

/* Хелперы, уже портированные в соседних файлах. */
__attribute__((section(".textlate"))) u32 bf_insert_field(u32 word, u32 value, u32 shift, u32 width);
__attribute__((section(".textlate"))) void memset0_words(void *dst, u32 len);

/* ------------------------------------------------------------------ */
/* Чтение конфигурации (адреса восстановлены из gp=0x800184, байтовые). */

__attribute__((section(".textlate"))) static u32 cfg_is_override(void)  { return qdesc_cfg_override; } /* ld_s  [gp,0x210] */
__attribute__((section(".textlate"))) static u32 cfg_flag_bit3(void)    { return qdesc_cfg_flag_bit3; } /* ld_s  [gp,0x214] */
__attribute__((section(".textlate"))) static u32 cfg_flag_bit13(void)   { return qdesc_cfg_flag_bit13; } /* ld_s  [gp,0x218] */
__attribute__((section(".textlate"))) static u16 cfg_w10_field(void)    { return qdesc_w10_field; } /* ldw_s [gp,0x118] */
__attribute__((section(".textlate"))) static u16 cfg_w14_field(void)    { return macq_desc_mpdu_len; } /* ldw_s [gp,0x7c]  */
__attribute__((section(".textlate"))) static u16 cfg_w13_field(void)    { return macq_desc_w1_len; } /* ldw_s [gp,0x7e]  */
__attribute__((section(".textlate"))) static u8  cfg_w3_field_a(void)   { return qdesc_w3_field_a; }  /* ldb_s [gp,0xb8]  */
__attribute__((section(".textlate"))) static u8  cfg_w4_field(void)     { return qdesc_w4_field; }  /* ldb_s [gp,0xb9]  */
__attribute__((section(".textlate"))) static u8  cfg_w3_field_b(void)   { return qdesc_w3_field_b; }  /* ldb_s [gp,0xba]  */

/* txq_cfg_*_or_default: «значение или дефолт», результат кэшируется обратно. */
__attribute__((section(".textlate"))) static u32 txq_cfg_enable(void)
{
    u32 v = (qdesc_txq_enable_custom == 0) ? 1u : qdesc_txq_enable;
    qdesc_txq_enable = v; /* st.as [gp,0x87] — слово */
    return v;
}
__attribute__((section(".textlate"))) static u32 txq_cfg_c70(void)
{
    u32 v = (qdesc_txq_cfg_custom == 0) ? 0xc8u : (u32)macq_reg_c70_val;
    macq_reg_c70_val = (u16)v; /* stw.as [gp,0x3c] — полуслово */
    return v;
}
__attribute__((section(".textlate"))) static u32 txq_cfg_c74(void)
{
    u32 v = (qdesc_txq_cfg_custom == 0) ? 0x40u : (u32)macq_reg_c74_val;
    macq_reg_c74_val = (u16)v; /* stw.as [gp,0x3d] */
    return v;
}
__attribute__((section(".textlate"))) static u32 txq_cfg_field_0e(void)
{
    u32 v = (qdesc_txq_cfg_custom == 0) ? 0u : (u32)macq_desc_field0e;
    macq_desc_field0e = (u16)v; /* stw.as [gp,0x40] */
    return v;
}

/* rf_chain__set_mode_field (0x8ea598): биты 22..23 = (mode==1||mode==2) ? 2 : 0.
 * Реализуется инлайн как w0 = bf_insert_field(w0, v, 22, 2). */

/* ------------------------------------------------------------------ */

/* 0x802804: таблица переходов switch vendor qdesc__build_by_type (0x8fa224;
 * ldb, цель = 0x8fa260 + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(802804) const u8 qdesc_build_by_type_jt[11] = {
    0x17, 0x17, 0x17, 0x17, 0x3f, 0x17, 0x26, 0x17, 0x00, 0x17, 0x5a,
};

/* qdesc__build_by_type (0x8fa224): построить дескриптор очереди по типу.
 * a0=desc a1=type a2..a6 — параметры полей (см. switch). */
__attribute__((section(".textlate"))) void qdesc_build_by_type(struct macq_ba_desc *d, u32 type, u32 a2,
                         u32 a3, u32 a4, u32 a5, u32 a6)
{
    u32 w0;

    memset0_words(d, sizeof(*d)); /* 48 байт */

    w0 = d->w0;
    switch (type) {
    case 8: /* Block A: bit0=0, s8_w3=a2&7, bit1=1, s16_w4=0, bit2=0, s24_w7=0 */
        w0 &= ~1u;
        w0 = bf_insert_field(w0, a2 & 7, 8, 3);
        w0 |= 1u << 1;
        w0 = bf_insert_field(w0, 0, 16, 4);
        w0 &= ~(1u << 2);
        w0 = bf_insert_field(w0, 0, 24, 7);
        break;

    case 0: case 1: case 2: case 3: case 5: case 7: case 9:
        /* Block B: bit0=0, s8_w3=a2&7, bit1=0, s16_w4=a3&15, bit2=0, s24_w7=0 */
        w0 &= ~1u;
        w0 = bf_insert_field(w0, a2 & 7, 8, 3);
        w0 &= ~(1u << 1);
        w0 = bf_insert_field(w0, a3 & 15, 16, 4);
        w0 &= ~(1u << 2);
        w0 = bf_insert_field(w0, 0, 24, 7);
        break;

    case 6: /* Block C: bit0=1, s8_w3=a2&7, bit1=0, s16_w4=a3&15, bit2=0, s24_w7=a4&127 */
        w0 |= 1u;
        w0 = bf_insert_field(w0, a2 & 7, 8, 3);
        w0 &= ~(1u << 1);
        w0 = bf_insert_field(w0, a3 & 15, 16, 4);
        w0 &= ~(1u << 2);
        w0 = bf_insert_field(w0, a4 & 0x7f, 24, 7);
        break;

    case 4: { /* Block D: override-aware (is_override читается один раз) */
        u32 ov = cfg_is_override();
        w0 &= ~1u;
        if (ov)
            w0 |= 1u;
        w0 = bf_insert_field(w0, a2 & 7, 8, 3);
        w0 &= ~(1u << 1);
        w0 = bf_insert_field(w0, a3 & 15, 16, 4);
        w0 &= ~(1u << 2);
        w0 = bf_insert_field(w0, ov ? (a4 & 0x7f) : 0, 24, 7);
        break;
    }

    case 10: /* Block E: полный дескриптор с байтовыми полями и -1-словами */
        w0 |= 1u;
        w0 = bf_insert_field(w0, 0, 8, 3);
        w0 &= ~(1u << 1);
        w0 = bf_insert_field(w0, 6, 16, 4);
        w0 &= ~(1u << 2);
        w0 = bf_insert_field(w0, 0, 24, 7);
        d->w2 = bf_insert_field(d->w2, 0xc27, 0, 12);
        d->w2_b[2] = 7;
        d->w3_b[0] = 0;
        d->w2 &= ~(1u << 12);
        d->line2[0] = 0xffffffffu;
        d->line2[1] = 0xffffffffu;
        break;

    default:
        /* type > 10: ветка fw_sysassert_fatal(blink, 0x22|0x1000) */
        fw_sysassert_fatal(0, 0x1022);
    }
    d->w0 = w0;

    if (a6 != 0) { /* общий «хвост»: только если a6 != 0 */
        d->w1_b[2] = 0;
        d->w1 = bf_insert_field(d->w1, a5 & 0xfff, 0, 12);
        d->w2_b[2] = (u8)(a4 - 1);
        d->w2 = bf_insert_field(d->w2, (a5 + a4 - 1) & 0xfff, 0, 12);
    }
}

/* 0x8027dc: таблица переходов switch vendor rf_chain__program_sector_desc (0x8fa398;
 * ldw, цель = 0x8fa3de + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(8027dc) const u16 rf_chain_program_sector_desc_jt[11] = {
    0x0116, 0x00ee, 0x0116, 0x00cd, 0x0000, 0x0079, 0x003d, 0x00a3,
    0x00b8, 0x0116, 0x013c,
};

/* rf_chain__program_sector_desc (0x8fa398): RF-секторный дескриптор по режиму.
 * a0=desc a1=mode(0..10) a2=mode_field a3=bit9 a4=w4_w5 a5=flag29. */
__attribute__((section(".textlate"))) void rf_chain_program_sector_desc(struct macq_sector_desc *d, u32 mode,
                                  u32 a2, u32 a3, u32 a4, u32 a5)
{
    u32 w0, w1;
    u32 v29 = (a5 != 0) ? 2u : 0u; /* mov.f r1,r2; mov.ne r1,1; asl r1 */

    d->w0 = 0;
    d->w1 = 0;
    d->w2 = 0;
    d->w3 = 0xa0a0a0a0u;
    d->w1 = (a3 & 1) << 9;
    d->w1 = bf_insert_field(d->w1, a4 & 0x1f, 4, 5);

    if (mode > 10) {
        /* bhi: недопустимый режим — молча выходим (в asm это L_8fa6be). */
        return;
    }

    w0 = d->w0;
    w1 = d->w1;

    switch (mode) {
    case 4: /* Block 0 */
        w0 = bf_insert_field(w0, 0, 14, 2);
        w0 |= 1u << 21;
        w0 = bf_insert_field(w0, v29, 29, 2);
        w0 = bf_insert_field(w0, 0, 24, 2);
        w0 = bf_insert_field(w0, qdesc_sector_field16 & 0x1f, 16, 5);
        w0 = bf_insert_field(w0, 1, 4, 4);
        w0 = bf_insert_field(w0, 2, 22, 2);
        w0 = bf_insert_field(w0, 0, 0, 4);
        w0 &= 0x7fffffffu;
        w1 &= ~(1u << 1);
        w1 = bf_insert_field(w1, 0, 2, 2);
        w1 &= ~(1u << 9);
        if (cfg_is_override())
            w1 = (w1 & ~1u) | (qdesc_override_bit0 & 1u); /* override bit0 */
        else
            w1 &= ~1u;
        break;

    case 6: { /* Block 1 */
        u32 bit0 = 0;
        w0 = bf_insert_field(w0, 0, 14, 2);
        w0 &= ~(1u << 21);
        w0 = bf_insert_field(w0, v29, 29, 2);
        w0 = bf_insert_field(w0, 0, 24, 2);
        w0 = bf_insert_field(w0, 1, 16, 5);
        w0 = bf_insert_field(w0, rf_chain_sector_desc_f4 & 0xf, 4, 4);
        w0 = bf_insert_field(w0, 2, 22, 2);
        w0 = bf_insert_field(w0, 0, 0, 4);
        w0 |= 1u << 31;
        w1 &= ~(1u << 1);
        w1 = bf_insert_field(w1, 0, 2, 2);
        bit0 = macq_desc_default_bit0;     /* rf_chain__get_default_desc_bit0 (без OOB R1) */
        w1 = (w1 & ~1u) | (bit0 & 1u);
        w0 = bf_insert_field(w0, (a2 == 1 || a2 == 2) ? 2u : 0u, 22, 2);
        break;
    }

    case 5: /* Block 2 */
        w0 = bf_insert_field(w0, 0, 14, 2);
        w0 &= ~(1u << 21);
        w0 = bf_insert_field(w0, v29, 29, 2);
        w0 = bf_insert_field(w0, 0, 24, 2);
        w0 = bf_insert_field(w0, 1, 16, 5);
        w0 = bf_insert_field(w0, rf_chain_sector_desc_f4 & 0xf, 4, 4);
        w0 = bf_insert_field(w0, 0, 0, 4);
        w0 |= 1u << 31;
        w1 &= ~(1u << 1);
        w1 = bf_insert_field(w1, 0, 2, 2);
        w1 &= ~1u;
        w0 = bf_insert_field(w0, (a2 == 1 || a2 == 2) ? 2u : 0u, 22, 2);
        break;

    case 7: /* Block 3 */
        w0 = bf_insert_field(w0, 1, 14, 2);
        w0 &= ~(1u << 21);
        w0 = bf_insert_field(w0, v29, 29, 2);
        w0 = bf_insert_field(w0, 0, 24, 2);
        w0 = bf_insert_field(w0, 0, 16, 5);
        w0 = bf_insert_field(w0, 0, 4, 4);
        w0 = bf_insert_field(w0, 0, 0, 4);
        w0 |= 1u << 31;
        w1 &= ~(1u << 1);
        w1 = bf_insert_field(w1, 0, 2, 2);
        w1 &= ~1u;
        w0 = bf_insert_field(w0, (a2 == 1 || a2 == 2) ? 2u : 0u, 22, 2);
        break;

    case 8: /* Block 4 */
        w0 = bf_insert_field(w0, 0, 14, 2);
        w0 &= ~(1u << 21);
        w0 = bf_insert_field(w0, 0, 29, 2);
        w0 = bf_insert_field(w0, 0, 24, 2);
        w0 = bf_insert_field(w0, 1, 16, 5);
        w0 = bf_insert_field(w0, 1, 4, 4);
        w0 = bf_insert_field(w0, 1, 22, 2);
        w0 = bf_insert_field(w0, 2, 0, 4);
        w0 |= 1u << 31;
        w1 &= ~(1u << 1);
        w1 = bf_insert_field(w1, 0, 2, 2);
        w1 &= ~1u;
        break;

    case 3: /* Block 5 */
        w0 = bf_insert_field(w0, 0, 14, 2);
        w0 &= ~(1u << 21);
        w0 = bf_insert_field(w0, 0, 29, 2);
        w0 = bf_insert_field(w0, 0, 24, 2);
        w0 = bf_insert_field(w0, 1, 16, 5);
        w0 = bf_insert_field(w0, 1, 4, 4);
        w0 = bf_insert_field(w0, 1, 22, 2);
        w0 = bf_insert_field(w0, 0, 0, 4);
        w0 |= 1u << 31;
        w1 &= ~(1u << 1);
        w1 = bf_insert_field(w1, 0, 2, 2);
        w1 &= ~1u;
        break;

    case 1: /* Block 6 */
        w0 = bf_insert_field(w0, 1, 14, 2);
        w0 &= ~(1u << 21);
        w0 = bf_insert_field(w0, 0, 29, 2);
        w0 = bf_insert_field(w0, 0, 24, 2);
        w0 = bf_insert_field(w0, 1, 16, 5);
        w0 = bf_insert_field(w0, 0, 4, 4);
        w0 = bf_insert_field(w0, 1, 22, 2);
        w0 = bf_insert_field(w0, 2, 0, 4);
        w0 &= 0x7fffffffu;
        w1 &= ~(1u << 1);
        w1 = bf_insert_field(w1, 0, 2, 2);
        w1 |= 1u;
        w1 &= ~(1u << 9);
        break;

    case 0: case 2: case 9: /* Block 7 */
        w0 = bf_insert_field(w0, 1, 14, 2);
        w0 &= ~(1u << 21);
        w0 = bf_insert_field(w0, 0, 29, 2);
        w0 = bf_insert_field(w0, 0, 24, 2);
        w0 = bf_insert_field(w0, 1, 16, 5);
        w0 = bf_insert_field(w0, 0, 4, 4);
        w0 = bf_insert_field(w0, 1, 22, 2);
        w0 = bf_insert_field(w0, 2, 0, 4);
        w0 &= 0x7fffffffu;
        w1 &= ~(1u << 1);
        w1 = bf_insert_field(w1, 0, 2, 2);
        w1 &= ~1u;
        w1 &= ~(1u << 9);
        break;

    case 10: /* Block 8 */
        w0 = bf_insert_field(w0, 0, 14, 2);
        w0 &= ~(1u << 21);
        w0 = bf_insert_field(w0, 0, 29, 2);
        w0 = bf_insert_field(w0, 0, 24, 2);
        w0 = bf_insert_field(w0, 1, 16, 5);
        w0 = bf_insert_field(w0, 0, 4, 4);
        w0 = bf_insert_field(w0, 0, 22, 2);
        w0 = bf_insert_field(w0, 0, 0, 4);
        w0 &= 0x7fffffffu;
        w1 &= ~(1u << 1);
        w1 = bf_insert_field(w1, 0, 2, 2);
        w1 |= 1u;                          /* без OOB R1 (OOB — только SparRAW-pro) */
        w1 = bf_insert_field(w1, 0x18, 4, 5);
        d->w3 = 0x1c36ffe0u;
        w1 &= ~(1u << 9);
        break;
    }

    d->w0 = w0;
    d->w1 = w1;
}

/* 0x8027f4: таблица переходов switch vendor tx_queue__config_by_mode (0x8f9fb0;
 * ldw, цель = 0x8f9fd8 + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(8027f4) const u16 tx_queue_config_by_mode_jt[7] = {
    0x004a, 0x0000, 0x0020, 0x0030, 0x011e, 0x011e, 0x00f8,
};

/* tx_queue__config_by_mode (0x8f9fb0): TX-очередь по режиму (mode 4..10). */
__attribute__((section(".textlate"))) void tx_queue_config_by_mode(struct macq_mode_desc *d, u32 mode)
{
    u32 w0, w1;

    memset0_words(d, sizeof(*d)); /* 16 байт */

    w0 = d->w0;
    w1 = d->w1;

    switch (mode) {
    case 5: /* Block 0 */
        w0 = bf_insert_field(w0, 0, 20, 10);
        w0 = bf_insert_field(w0, 0, 0, 3);
        w0 = bf_insert_field(w0, 0x2028, 6, 14);
        w0 &= ~0x38u;
        w1 &= ~(1u << 13);
        w1 = bf_insert_field(w1, 0x140, 0, 13);
        w1 = bf_insert_field(w1, 5, 14, 3);
        d->field0e = 0;
        break;

    case 6: /* Block 1 */
        w0 = bf_insert_field(w0, 1, 20, 10);
        w0 = bf_insert_field(w0, 7, 0, 3);
        w0 = bf_insert_field(w0, 0x2028, 6, 14);
        w0 = (w0 & ~0x38u) | (1u << 4);
        w1 &= ~(1u << 13);
        w1 = bf_insert_field(w1, 0x140, 0, 13);
        w1 = bf_insert_field(w1, 5, 14, 3);
        d->field0e = 0;
        break;

    case 7: /* Block 2 */
        w0 = bf_insert_field(w0, 0, 20, 10);
        w0 = bf_insert_field(w0, 0, 0, 3);
        w0 = bf_insert_field(w0, 0x1000, 6, 14);
        w0 &= ~0x38u;
        w1 &= ~(1u << 13);
        w1 = bf_insert_field(w1, 0x140, 0, 13);
        w1 = bf_insert_field(w1, 5, 14, 3);
        d->field0e = 0;
        break;

    case 4: /* Block 3 / Block 4 (override-aware) */
        if (cfg_is_override()) {
            w0 = bf_insert_field(w0, cfg_w10_field() & 0x3ff, 20, 10);
            w0 = bf_insert_field(w0, cfg_w14_field() & 0x3fff, 6, 14);
            w0 |= 1u << 4;
            w0 = bf_insert_field(w0, cfg_w3_field_a() & 7, 0, 3);
            w0 = ((cfg_flag_bit3() & 1u) << 3) | (w0 & ~(1u << 3));

            if (txq_cfg_enable()) {
                u32 c70, c74;
                w0 |= 1u << 30;
                /* MMIO 0x886c70 / 0x886c74 (enable != 0) */
                c70 = txq_cfg_c70();
                if (c70 & 0xffff0000u)
                    fw_sysassert_fatal(0, 0xac);
                MMIO32(HW_MAC_TX_MCS_PARAM16) = c70 | (MMIO32(HW_MAC_TX_MCS_PARAM16) & 0xffff0000u);

                c74 = txq_cfg_c74();
                if (c74 & 0xffffff00u)
                    fw_sysassert_fatal(0, 0xac);
                MMIO32(HW_MAC_TX_MCS_PARAM8) = c74 | (MMIO32(HW_MAC_TX_MCS_PARAM8) & 0xffffff00u);
            } else {
                w0 &= ~(1u << 30);
                /* MMIO 0x886c70 / 0x886c74 (enable == 0) */
                MMIO32(HW_MAC_TX_MCS_PARAM16) = (MMIO32(HW_MAC_TX_MCS_PARAM16) & 0xffff0000u) | 1u;
                MMIO32(HW_MAC_TX_MCS_PARAM8) &= ~0xffu;
            }

            /* общий «хвост» override-ветки */
            w0 |= 1u << 5;
            w1 &= ~(1u << 13);
            if (cfg_flag_bit13())
                w1 |= 1u << 13;
            w1 = bf_insert_field(w1, cfg_w13_field() & 0x1fff, 0, 13);
            w1 = bf_insert_field(w1, cfg_w4_field() & 0xf, 17, 4);
            d->field0e = (u16)txq_cfg_field_0e();
            w1 = bf_insert_field(w1, cfg_w3_field_b() & 7, 14, 3);
        } else {
            /* Block 4: не-override */
            w0 = bf_insert_field(w0, 0, 20, 10);
            w0 = bf_insert_field(w0, cfg_w14_field() & 0x3fff, 6, 14);
            w0 &= ~(1u << 4);
            w0 = bf_insert_field(w0, 0, 0, 3);
            w0 &= ~(1u << 30);
            w0 = (w0 & ~0x28u) | ((cfg_flag_bit3() & 1u) << 3) | (1u << 5);
            w1 &= ~(1u << 13);
            w1 = bf_insert_field(w1, 0x1fff, 0, 13);
            d->field0e = 0;
        }
        break;

    case 10: /* Block 5 */
        w0 = bf_insert_field(w0, 0x29a, 20, 10);
        w0 = bf_insert_field(w0, 0x219, 6, 14);
        w0 |= 1u << 4;
        w0 = bf_insert_field(w0, 4, 0, 3);
        w0 = (w0 & ~0x28u) | (1u << 5);
        w1 &= ~(1u << 13);
        w1 = bf_insert_field(w1, 0x1cc2, 0, 13);
        w1 = bf_insert_field(w1, 7, 14, 3);
        d->field0e = 0xaf23;
        break;

    default: /* Block 6 (mode<4, mode 8/9, mode>10) */
        w1 = bf_insert_field(w1, 0x1fff, 0, 13);
        break;
    }

    d->w0 = w0;
    d->w1 = w1;
}

/* mac_bringup__init_seq (0x8fa6c4): инициализация секторов/очередей. */
__attribute__((section(".textlate"))) void mac_bringup_init_seq(void)
{
    /* Единый стековый кадр (sub sp,0x60), как в asm. */
    struct {
        struct macq_sector_desc sector;        /* 0x00: RF-сектор */
        struct macq_mode_desc mode;            /* 0x10: TX-очередь */
        struct macq_ba_desc ba;                /* 0x20: тип очереди */
        struct macq_desc win;                  /* 0x50: окно */
    } buf;
    u32 *w;
    /* В 0x8fa6c4 записи 0x886608 = 0 перед дескрипторами нет — прежний костыль («иначе
     * macq_desc__wait_window_free виснет на бите 31») убран: окно MACQ занимают только
     * macq_desc__write (0x8c5010) и ucode, и оба его освобождают; вис был до порта fw_main
     * (PCIe/SDP/таблицы как у vendor). Если на стенде загрузка встанет на l2mgr bring-up —
     * искать, кто оставил бит 31 0x886608, а не возвращать запись. */

    /* rf_chain__program_sector_desc(buf, mode=10, a2=0, a3=0, a4=10, a5=0) */
    rf_chain_program_sector_desc(&buf.sector, 10, 0, 0, 10, 0);
    macq_desc_write(&buf.sector, 0x1f, 2, 0, 0, 0, 1, 1);

    tx_queue_config_by_mode(&buf.mode, 10);
    macq_desc_write(&buf.mode, 0x1f, 2, 0, 0, 0, 2, 1);

    qdesc_build_by_type(&buf.ba, 10, 0, 6, 0, 0, 1);
    macq_desc_write(&buf.ba, 0x1f, 2, 3, 0, 0, 0, 3);

    /* Окно (rd/wr/lines/base = 0, MSDU 2 строки, param_a 0x1ff, param_b 1). Биты w3 [31:28]
     * полями не задаются — у vendor (0x8fa6c4) там остаток стека; по общему правилу
     * (стековые буферы в железо обнуляются) дескриптор сначала обнулён. */
    memset0_words(&buf.win, sizeof(buf.win));
    volatile struct macq_desc *win = &buf.win;   /* volatile: четыре sth, как у vendor
                                                  * (без него gcc сливает их в два st) */
    win->rd = 0;
    win->wr = 0;
    win->lines = 0;
    win->base = 0;
    w = &buf.win.w2;
    *w = bf_insert_field(*w, 2, 0, 12);
    *w = bf_insert_field(*w, 0x1ff, 12, 12);
    buf.win.param_a_lo = 0xff;
    w = &buf.win.w3;
    *w = bf_insert_field(*w, 1, 0, 4);
    *w = bf_insert_field(*w, 0x1ff, 16, 12);
    *w = bf_insert_field(*w, 1, 4, 12);

    macq_desc_write(&buf.win, 0x1f, 2, 0, 0, 0, 0, 1);

    /* rf_chain__zero_and_program(0x1ff): memset0_words + macq_desc__write_type6 */
    {
        u8 tmp[0x10];
        memset0_words(tmp, 0x10);
        macq_desc_write_type6(tmp, 0x1ff);
    }
}

/* === Простые шаги l2mgr__mac_bringup (0x8f6ab8) === */

/* mac_bringup__set_886a80_ctl_bit0 (0x8f6c34): [0x886aa0] |= 1. */
__attribute__((section(".textlate"))) void mac_bringup_set_886a80_ctl_bit0(void)
{
    MMIO32(HW_MAC_CTL_886AA0) |= 1u;
}

/* mac__set_886838_b0 (0x8f811c): [0x886838] bit0 = val (val&1 → assert). */
__attribute__((section(".textlate"))) void mac_set_886838_b0(u32 val)
{
    if (val & ~1u)
        fw_sysassert_fatal(0, 0xac);
    MMIO32(HW_PRP_CTRL) = (MMIO32(HW_PRP_CTRL) & ~1u) | val;
}

/* mac__set_txq_param (0x8ea3b8, 96 Б): значение v очереди q в [0x886b00 + q*4]
 * ((q*32 + 0x4435800) >> 3 & ~3); v должно быть в маске 0x1c1ddf (иначе ассерт 0x1023 —
 * bbit0 по номеру бита v). При flag: [0x886c74][7:0] = 0x30, [0x886c70][15:0] = 0x14. */
static void mac_set_txq_param(u32 q, u32 v, u32 flag)
{
    if (!((0x1c1ddfu >> (v & 31)) & 1u))
        fw_sysassert_fatal(__builtin_return_address(0), 0x1023);
    MMIO32((((q << 5) + 0x4435800u) >> 3) & ~3u) = v;
    if (flag != 0) {
        MMIO32(HW_MAC_TX_MCS_PARAM8) = (MMIO32(HW_MAC_TX_MCS_PARAM8) & ~0xffu) | 0x30u;
        MMIO32(HW_MAC_TX_MCS_PARAM16) = (MMIO32(HW_MAC_TX_MCS_PARAM16) & 0xffff0000u) | 0x14u;
    }
}

/* mac_bringup__init_tx_queues (0x8fa7a4): инициализация 8 TX-очередей. Прежде шаг
 * 0x8ea3b8(0, 8, 1) был пропущен: [0x886c70] = 0x14 / [0x886c74] = 0x30 не ставились
 * (на стенде 0xa0000/0x2e против vendor 0xa0014/0x30). */
__attribute__((section(".textlate"))) void mac_bringup_init_tx_queues(void)
{
    u32 i;
    MMIO32(HW_CID_MCS_TBL) = 8;
    MMIO32(HW_MAC_TX_MCS_PARAM8) = 0x2e;
    mac_set_txq_param(0, 8, 1);
    for (i = 1; i <= 8; i++) {
        u32 addr = (((i << 5) + 0x4435800) >> 3) & ~3u;
        MMIO32(addr) = 8;
    }
}

/* hwd_mac__enable_multicast (0x8d0ebc): лог + сброс бита 13 [0x886250]. */
__attribute__((section(".textlate"))) void hwd_mac_enable_multicast(void)
{
    fw_log_emit0(0x20, 0x101f4d4);
    MMIO32(HW_PRS_RX_CTRL_886250) &= ~(1u << 13);
}

/* === Остальные шаги l2mgr__mac_bringup (0x8f6ab8) === */

/* mac_bringup__prog_881000 (0x8f3e5c, 124 Б): конфигурация MAC-дескрипторов. */
__attribute__((section(".textlate"))) void mac_bringup_prog_881000(void)
{
    MMIO32(HW_DMA_RING_SEL_102C) = 3; arc_sync();
    MMIO32(HW_DMA_CFG_1144) = 1; arc_sync();
    MMIO32(HW_DMA_CFG_1154) = 1; arc_sync();
    MMIO32(HW_DMA_CFG_114C) = 1; arc_sync();
    MMIO32(HW_DMA_CFG_1160) = 1; arc_sync();
    MMIO32(HW_DMA_CFG_1170) = 1; arc_sync();
    MMIO32(HW_DMA_CFG_1168) = 1; arc_sync();
    MMIO32(HW_DMA_CFG_128C) = 5;
    MMIO32(HW_DMA_CFG_1294) = 5;
    MMIO32(HW_DMA_CFG_129C) = 5;
    MMIO32(HW_DMA_CFG_12A8) = 5;
    MMIO32(HW_DMA_CFG_12B0) = 5;
    MMIO32(HW_DMA_CFG_12B8) = 5;
}

/* mac_bringup__prog_881b00 (0x8f6c4c, 100 Б): broadcast-ring конфигурация. */
__attribute__((section(".textlate"))) void mac_bringup_prog_881b00(void)
{
    MMIO32(HW_L2_OFFLOAD_CFG_B20) = 8;
    MMIO32(HW_L2_OFFLOAD_CFG_B18) = 0x3aaaa;
    MMIO32(HW_L2_OFFLOAD_CFG_B1C) = 0;
    MMIO32(HW_L2_OFFLOAD_TX_CTL) &= ~1u;
    MMIO32(HW_DMA_OFFLOAD_DECAP_CFG) &= ~(1u << 7);
    MMIO32(HW_L2_OFFLOAD_ETHERTYPES) = (MMIO32(HW_L2_OFFLOAD_ETHERTYPES) & 0xffff0000u) | (1u << 3);
    MMIO32(HW_L2_OFFLOAD_ETHERTYPES) |= 0xdd860000u;
    MMIO32(HW_DMA_OFFLOAD_CTL_B94) |= (1u << 1) | (1u << 11) | (1u << 10);
    MMIO32(HW_DMA_OFFLOAD_CTL_B94) &= ~((1u << 6) | (1u << 7));
}

/* vring__reg_write_locked_0c (0x8d04d8, 48 Б): запись в [0x881c0c] под IRQ-lock. */
__attribute__((section(".textlate"))) void vring_reg_write_locked_0c(u32 val, u32 do_sync)
{
    u32 saved = arc_irq_disable();
    MMIO32(HW_DMA_FW_ICR_C08_ICR) = val;
    if (do_sync) arc_sync();
    arc_irq_restore(saved);
}

/* hwd_phy__tx_enable (0x8d21d0, 40 Б): [0x884008] bit0 = val. */
__attribute__((section(".textlate"))) void hwd_phy_tx_enable(u32 val)
{
    if (val & ~1u) fw_sysassert_fatal(0, 0xac);
    MMIO32(HW_PHY_TX_EN) = (MMIO32(HW_PHY_TX_EN) & ~1u) | val;
}

/* hwd_phy__rx_enable (0x8d219c, 40 Б): [0x883010] bit0 = val. */
__attribute__((section(".textlate"))) void hwd_phy_rx_enable(u32 val)
{
    if (val & ~1u) fw_sysassert_fatal(0, 0xac);
    MMIO32(HW_PHY_RX_CTL) = (MMIO32(HW_PHY_RX_CTL) & ~1u) | val;
}

/* l2mgr__bringup_pair (0x8dd8d0, 20 Б): включить TX и RX PHY. */
__attribute__((section(".textlate"))) void l2mgr_bringup_pair(u32 val)
{
    hwd_phy_tx_enable(val);
    hwd_phy_rx_enable(val);
}

/* === mac_parser__configure (0x8f6d54) — шаг 5 l2mgr__mac_bringup === */


/* mac_parser__set_886260 (0x8dfbbc): [0x886260 + idx*4] = val. */
__attribute__((section(".textlate"))) void mac_parser_set_886260(u32 idx, u32 val)
{
    MMIO32(HW_PRS_RULE_CTL + idx * 4) = val;
}

/* mac_parser__set_886200 (0x8dfba0): упаковать поля в [0x886258]/[0x88625c]. */
__attribute__((section(".textlate"))) void mac_parser_set_886200(u32 a0, u32 a1, u32 a2, u32 a3)
{
    u32 v = (a0 << 16) | a1 | (a2 << 24) | (a3 << 8);
    MMIO32(HW_PRS_CFG_886258) = v;
    MMIO32(HW_PRS_CFG_88625C) = a3;
}

/* mac_parser__configure (0x8f6d54, 88 Б): конфигурация MAC-парсера. Режим парсера —
 * mode при [gp,0xbc] != 0, иначе 1. ld.as [gp,0xbc] — смещение ×4: 0x800474 (у vendor на
 * стенде 0 → режим 1); прежний порт читал 0x800240 (= 0xff010002) и инициализировал
 * парсер режимом 0x1f (на стенде 0x886258 = 0x1f1f1f1f против 0x1f011f1f у vendor).
 * mac_parser__init получает r0 вызывающего (bl.d сразу после входа; l2mgr__mac_bringup
 * передаёт 0), прежний порт передавал режим (0x1f). */
__attribute__((section(".textlate"))) void mac_parser_configure(u32 r0, u32 mode)
{
    u32 r13 = (mac_parser_mode_en != 0) ? mode : 1;
    mac_parser_init(r0);                 /* vendor: r0 вызывающего (0), не r13 */
    mac_filter_write_entries(1, 0, 7);
    mac_filter_write_entries(2, 0, 0x3f);
    mac_parser_set_886260(1, 0x4102);
    mac_parser_set_886260(3, 258);
    mac_parser_set_886200(r13, mode, mode, mode);
}

/* mac_parser__set_default_ctrl (0x8dfbc8, 16 Б): [0x886288] = 0xf0c3f0f0. */
__attribute__((section(".textlate"))) void mac_parser_set_default_ctrl(void)
{
    MMIO32(HW_PRS_DEFAULT_CTRL) = 0xf0c3f0f0u;
}

/* === mac_parser (0x8df778 и его helper'ы) === */


/* mac_parser__rule_a (0x8dfb3c, 44 Б): 0x40 правил со значением i. */
__attribute__((section(".textlate"))) void mac_parser_rule_a(void)
{
    struct prs_rule buf;
    u32 i;
    memset0_words(&buf, 8);
    for (i = 0; i < 0x40; i++)
        mac_parser_write_rule(&buf, i, 3);
}

/* mac_parser__rule_b (0x8dfde4, 48 Б): одно правило по шаблону. */
__attribute__((section(".textlate"))) void mac_parser_rule_b(u32 v)
{
    struct prs_rule rule;                            /* правило (2 слова, include/mac_parser.h) */
    volatile u16 *h = rule.h;                       /* volatile: два sth, как у vendor */
    h[0] = 1027;
    h[1] = 0xd480;
    rule.w[1] = (v << 0x12) | 0x801f7fu;
    mac_parser_write_rule(&rule, 0, 3);
}

/* mac_bringup__init_dma_ctrl (0x8fa7e8, 16 Б): [0x886a00]=5, [0x886a04]=9. */
__attribute__((section(".textlate"))) void mac_bringup_init_dma_ctrl(void)
{
    MMIO32(HW_TXQ_REGS) = 5;
    MMIO32(HW_TXQ_CTRL_1) = 9;
}
