// SPDX-License-Identifier: AGPL-3.0-or-later
/* PHY-хелперы uCode. */
#include "../include/types.h"
#include "../include/hw.h"


u32 uc_sysassert_read_hw_state3(void)
{
    return MMIO32(HW_STATE3) & 7;               /* bmsk 2 — 3 бита */
}

u32 phy_read_signal_gain_adc_db(void)
{
    return MMIO32(HW_PHY_RX_SIGNAL_GAIN_ADC_DB) & 0x7f; /* bmsk 6 — 7 бит */
}

u32 phy_read_signal_gain_adc_db_sfd_locked(void)
{
    return (MMIO32(HW_PHY_RX_SIGNAL_GAIN_ADC_DB) >> 14) & 0x7f;
}

void phy_rx_set_ina_det_mode_uc(u32 a)
{
    MMIO32(HW_PHY_RX_INA_DET_MODE) = a;
}

void hwd_phy_uses_rgf_883000(u32 v)
{
    if (v & ~1u)
        uc_assert((u32)__builtin_return_address(0), 0xac);
    MMIO32(HW_PHY_RX_CTL) = (MMIO32(HW_PHY_RX_CTL) & ~1u) | v;
}

void hwd_phy_uses_rgf_884000(u32 v)
{
    if (v & ~1u)
        uc_assert((u32)__builtin_return_address(0), 0xac);
    MMIO32(HW_PHY_TX_EN) = (MMIO32(HW_PHY_TX_EN) & ~1u) | v;
}

/* ===== uCode PHY/DMA (портировано по заказу) ===== */

/* Таблица патчей PHY (0x929684). */
void hwd_phy_init_2(void)
{
    u32 *table = (u32 *)0x1003174;
    u32 addr = table[0];
    if (addr == 0x0e0d0e0du)
        return;
    u32 i = 0;
    for (;;) {
        (void)MMIO32(addr);            /* прочитать перед записью */
        MMIO32(addr) = table[2 * i + 1];   /* пары (адрес, значение): add3 r2,r14,r13; ld [r2,4] */
        i++;
        if (i >= 0x28)
            uc_assert((u32)__builtin_return_address(0), 0x133f);
        addr = table[2 * i];
        if (addr == 0x0e0d0e0du)
            return;
    }
}

/* RGF 0x880c78 биты 3..5 (0x9296e0). */
void hwd_phy_uses_rgf_881000_9296e0(u32 v)
{
    if (v != 0) {
        MMIO32(HW_PHY_PWR_CTL) &= ~(1u << 3);
        MMIO32(HW_PHY_PWR_CTL) &= ~(1u << 4);
        MMIO32(HW_PHY_PWR_CTL) &= ~(1u << 5);
    } else {
        MMIO32(HW_PHY_PWR_CTL) |= (1u << 3);
        MMIO32(HW_PHY_PWR_CTL) |= (1u << 4);
        MMIO32(HW_PHY_PWR_CTL) |= (1u << 5);
    }
}

/* RGF 0x880c04/0x880c08 — повторяющийся ниббл (0x929730). */
void hwd_phy_uses_rgf_881000_929730(u32 v)
{
    /* 0x929730: допустимо 0,1,2,4 (assert иначе, но запись всё равно). */
    if (!(v == 0 || v == 1 || v == 2 || v == 4))
        uc_assert((u32)__builtin_return_address(0), 0x12da);
    u32 pat = v | v << 4 | v << 8 | v << 12 | v << 16 | v << 20 | v << 24 | v << 28;
    MMIO32(HW_PWR_MODE_MAP_C04) = pat;
    MMIO32(HW_PWR_MODE_MAP_C08) = pat & 0xfffffffu; /* bmsk 0x1b — 28 бит */
}

/* Распаковка дескриптора PPDU (0x9297ac). */
void ppdu_unpack_desc_word(u32 a, u32 *o0, u32 *o1, u32 *o2,
                           u32 *o3, u32 *o4, u32 *o5)
{
    *o0 = a & 0x1f;
    *o1 = (a >> 5) & 0x3ffff;
    *o2 = (a >> 23) & 0x1f;
    *o3 = (a >> 28) & 1u;
    *o4 = (a >> 29) & 1u;
    *o5 = (a >> 30) & 1u;
}


/* Питание PHY: запись конфига + опрос 0x880c7c (0x9297f0). */
/* СРОК: PHY должен выставить статус питания (0x880c7c б0..2 = v) за 200 проходов опроса
 * (аппаратный); окно задаётся скоростью цикла: у нас ~9 инструкций и 2 взятых перехода на проход,
 * vendor 0x9297f0 — lp 0xc8 × ~11 инструкций; ≈ 2200 тактов ≈ 13 мкс у обоих. Запас не известен.
 * Срыв (медленный PHY или ускоренный цикл) — assert 0x1334. */
void hwd_phy_pwr(u32 v)
{
    /* 0x9297f0 */
    u32 hi = v & ~1u;
    if (hi)
        uc_assert((u32)__builtin_return_address(0), 175);
    if (hi)
        uc_assert((u32)__builtin_return_address(0), 176);
    if (hi)
        uc_assert((u32)__builtin_return_address(0), 177);
    u32 t = (MMIO32(HW_PHY_PWR_CTL) & ~1u) | v;
    t = ((t & ~2u) | (v << 1)) & ~4u;
    MMIO32(HW_PHY_PWR_CTL) = t | (v << 2);
    u32 b0 = 0, b1 = 0, b2 = 0;
    for (u32 i = 0; i < 200; i++) {
        u32 r = MMIO32(HW_PHY_PWR_STATUS);
        b0 = r & 1;
        b1 = (r >> 1) & 1;
        b2 = (r >> 2) & 1;
        if (v == b0 && v == b1 && v == b2)
            break;
    }
    if (!(v == b0 && v == b1 && v == b2)) {
        uc_log_emit_snapshot(0, 0x10028f4);
        uc_assert((u32)__builtin_return_address(0), 0x1334);
    }
    if (!(v == b0 && v == b2 && v == b1))
        uc_log_emit3(9, 0x1002abc, b0, b1, b2);
}

/* Конфигурация DMA/MAC 0x880c2c (0x9298f8). */
void dma_mac_cfg_880c2c(u32 v)
{
    if (v != 0) {
        MMIO32(HW_RGF_USER_CLKS_CTL_SW_RST_VEC_1) |= 0x3fu;
        MMIO32(HW_RGF_USER_CLKS_CTL_SW_RST_VEC_0) = (MMIO32(HW_RGF_USER_CLKS_CTL_SW_RST_VEC_0) & 0x3ffffu) | 0xfffc0000u;
        MMIO32(HW_RGF_USER_CLKS_CTL_EXT_SW_RST_VEC_1) |= 0xfu;
    } else {
        MMIO32(HW_RGF_USER_CLKS_CTL_SW_RST_VEC_1) &= ~0x3fu;
        MMIO32(HW_RGF_USER_CLKS_CTL_SW_RST_VEC_0) &= 0x3ffffu;
        MMIO32(HW_RGF_USER_CLKS_CTL_EXT_SW_RST_VEC_1) &= ~0xfu;
    }
}

/* Установка режима PHY (0x9299d8). */
void hwd_phy_set_mode_uc(u32 mode)
{
    u32 base = PHY_SELF_MODE_CTL_RX;       /* база блока PHY 0x883000 (первый регистр блока) */
    if (mode == 1) {
        MMIO32(base + 0x1c0) = (MMIO32(base + 0x1c0) & ~0x3fu) | 0x21;
        MMIO32(base + 0x1c4) = (MMIO32(base + 0x1c4) & ~0x3fu) | 0x21;
        return;
    }
    u32 a = phy_mode_fields[0];
    if (a & ~0x3fu) uc_assert((u32)__builtin_return_address(0), 0xac);
    MMIO32(base + 0x1c0) = a | (MMIO32(base + 0x1c0) & ~0x3fu);

    u32 b = phy_mode_fields[2];
    if (b & ~0x3fu) uc_assert((u32)__builtin_return_address(0), 0xac);
    MMIO32(base + 0x1c4) = b | (MMIO32(base + 0x1c4) & ~0x3fu);

    u32 c = phy_mode_fields[1];
    if (c & ~0x3fu) uc_assert((u32)__builtin_return_address(0), 0xac);
    MMIO32(base + 0x1c0) = (MMIO32(base + 0x1c0) & 0xfffff03fu) | (c << 6);

    u32 d = phy_mode_fields[3];
    if (d & ~0x3fu) uc_assert((u32)__builtin_return_address(0), 0xac);
    MMIO32(base + 0x1c4) = (MMIO32(base + 0x1c4) & 0xfffff03fu) | (d << 6);
}

/* Дамп регистров RGF 0x883800 (0x929af4). */
void hwd_phy_uses_rgf_883800_929af4(u32 *out)
{
    u32 base = HW_PHY_RGF_BASE;
    out[0]  = MMIO32(base + 0x180);
    out[1]  = MMIO32(base + 0x184);
    out[2]  = MMIO32(base + 0x188);
    out[3]  = MMIO32(base + 0x18c);
    out[4]  = MMIO32(base + 0x190);
    out[5]  = MMIO32(base + 0x194);
    out[6]  = MMIO32(base + 0x198);
    out[7]  = MMIO32(base + 0x19c);
    out[8]  = MMIO32(base + 0x1bc);
    out[9]  = MMIO32(base + 0x1c0);
    out[10] = MMIO32(base + 0x1c4);
    out[11] = MMIO32(base + 0x1c8);
    out[12] = MMIO32(base + 0x1cc);
    out[13] = MMIO32(base + 0x1d0);
    out[14] = MMIO32(base + 0x1d4);
    out[15] = MMIO32(base + 0x1d8);
}

/* Дамп регистров RGF 0x883800 (0x929b94). */
void hwd_phy_uses_rgf_883800_929b94(u32 *out)
{
    u32 base = HW_PHY_RGF_BASE;
    out[0]  = MMIO32(base + 0x59 * 4);
    out[1]  = MMIO32(base + 0x5a * 4);
    out[2]  = MMIO32(base + 0x5d * 4);
    out[3]  = MMIO32(base + 0x5b * 4);
    out[4]  = MMIO32(base + 0x5e * 4);
    out[5]  = MMIO32(base + 0x5c * 4);
    out[6]  = MMIO32(base + 0x5f * 4);
    out[7]  = MMIO32(base + 0x68 * 4);
    out[8]  = MMIO32(base + 0x69 * 4);
    out[9]  = MMIO32(base + 0x6c * 4);
    out[10] = MMIO32(base + 0x6a * 4);
    out[11] = MMIO32(base + 0x6d * 4);
    out[12] = MMIO32(base + 0x6b * 4);
    out[13] = MMIO32(base + 0x6e * 4);
}

void phy_stats_clear_counters_883960(void)
{
    MMIO32(HW_PHY_RX_STATISTICS_CLEAR) = 1;
}

void phy_stats_clear_counters_88395c(void)
{
    MMIO32(HW_PHY_RX_STATISTICS_LOCK) = 1;
}

u32 phy_signal_gain_adc_in_range(void)
{
    u32 gain = phy_read_signal_gain_adc_db();
    if (gain > 0x3f)
        return 0;
    u8 thresh = adc_gain_thresh;
    return (gain >= thresh) ? 1 : 0;
}


void phy_set_88306c_field(u32 v)
{
    if (v & ~0x3fu)
        uc_assert((u32)__builtin_return_address(0), 0xac);
    MMIO32(HW_PHY_RX_AGC_ROW) = (MMIO32(HW_PHY_RX_AGC_ROW) & ~0x3fu) | v;
}
