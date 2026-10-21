// SPDX-License-Identifier: AGPL-3.0-or-later
/* ABIF (аналоговый интерфейс): листовые аксессоры регистров, недостающие в calib_hw.c /
 * car.c / power_halt.c (порт vendor 6.2.0.1000, диапазон 0x8ce518..0x8cff4c). Регистры:
 * 0x88a000/0x88a004 (TX-таблица, 32 строки × 4 слова), 0x88a200/0x88a208 (RX-таблица,
 * 64 строки × 4 слова), 0x88a608 (SAR DC таблица), 0x88ae00/0x88af00/0x88af80 (ABIF RGF),
 * 0x889100/0x889300/0x889480 (CAF/RFC RGF).
 * Сравнения индексов у vendor знаковые (brge/bge) — повторены через (s32).
 * Ассерты: fw_sysassert_fatal(blink, код) и продолжение работы — как у vendor. */
#include "types.h"
#include "hw.h"


#define CALLER() ((void *)__builtin_return_address(0))

/* Прототипы (глобальные порты этого файла). */

/* hwd_abif__adc_sar_vreg_ctrl (0x8ce518, 26 Б): [0x88af48] биты 0..4 очистить, затем
 * on == 1 → бит 3, иначе → бит 4. */
void hwd_abif_adc_sar_vreg_ctrl(u32 on)
{
    u32 v = MMIO32(HW_ABIF_ADC_SAR_VREG_CTRL) & ~0x1fu;
    v |= (on == 1) ? (1u << 3) : (1u << 4);
    MMIO32(HW_ABIF_ADC_SAR_VREG_CTRL) = v;
}

/* hwd_abif__caf_phy_control_mode (0x8ce648, 22 Б): бит 0 [0x88afe8] = (on == 1). */
void hwd_abif_caf_phy_control_mode(u32 on)
{
    u32 v = MMIO32(ABIF_CAF_MODE);
    MMIO32(ABIF_CAF_MODE) = (on == 1) ? (v | 1u) : (v & ~1u);
}

/* hwd_abif__dvs_rfca_activate (0x8ce89c, 114 Б): маска RFCA (8 бит) временно в
 * [0x889488][23:16], затем en (0/1) в биты 11 и 16 [0x889154], и маска снова очищается.
 * mask > 0xff → ассерт 0xac; en > 1 → ассерты 0xad И 0xae (vendor: после 0xad ветка
 * возвращается на проверку r16 != 0 — та же величина en & ~1). Маска в поле пишется
 * без усечения (asl r16,16 при mask > 0xff портит биты 24+) — как у vendor. */
void hwd_abif_dvs_rfca_activate(u32 en, u32 mask)
{
    u32 v;

    if (mask & ~0xffu)
        fw_sysassert_fatal(CALLER(), 0xac);
    MMIO32(HW_ABIF_DVS_RF_CTRL) = (MMIO32(HW_ABIF_DVS_RF_CTRL) & 0xff00ffffu) | (mask << 16);
    if (en & ~1u) {
        fw_sysassert_fatal(CALLER(), 0xad);
        fw_sysassert_fatal(CALLER(), 0xae);
    }
    v = MMIO32(HW_RFC_RFCA_CFG);
    v &= ~((1u << 11) | (1u << 16));
    MMIO32(HW_RFC_RFCA_CFG) = v | (en << 16) | (en << 11);
    MMIO32(HW_ABIF_DVS_RF_CTRL) &= 0xff00ffffu;
}

/* hwd_abif__dvs_rfca_config_en (0x8ce9d4, 48 Б): [0x889488][23:16] = mask
 * (mask > 0xff → ассерт 0xac, запись без усечения). */
void hwd_abif_dvs_rfca_config_en(u32 mask)
{
    if (mask & ~0xffu)
        fw_sysassert_fatal(CALLER(), 0xac);
    MMIO32(HW_ABIF_DVS_RF_CTRL) = (MMIO32(HW_ABIF_DVS_RF_CTRL) & 0xff00ffffu) | (mask << 16);
}

/* hwd_abif__out_to_bump_ctl (0x8cebdc, 178 Б): вывод аналоговых сигналов на bump-пины
 * через [0x88af44]. Журнал (0x21, 0x101f104, en, sel). en == 0 → регистр = 0.
 * sel 0: [17:14] := 0b0011, затем |= бит 10, |= бит 12;
 * sel 1: [23:18] := 0b000011, затем |= бит 11, |= бит 13;
 * sel 2: |= бит 8, затем |= бит 10, |= бит 12;
 * sel 3: [17:14] := 0b1100, затем |= бит 11, |= бит 13;
 * иное — журнал (1, 0x101f148, sel). Каждый шаг — отдельная пара ld/st (как у vendor). */
void hwd_abif_out_to_bump_ctl(u32 en, u32 sel)
{
    u32 v, b1, b2;

    fw_log_emit2(0x21, 0x101f104, en, sel);
    if (en == 0) {
        MMIO32(ABIF_OUT_TO_BUMP_CTL) = 0;
        return;
    }
    v = MMIO32(ABIF_OUT_TO_BUMP_CTL);
    switch (sel) {
    case 0:
        v = (v & 0xfffc3fffu) | (1u << 14) | (1u << 15);
        b1 = 10; b2 = 12;
        break;
    case 1:
        v = (v & 0xff03ffffu) | (1u << 18) | (1u << 19);
        b1 = 11; b2 = 13;
        break;
    case 2:
        v |= 1u << 8;
        b1 = 10; b2 = 12;
        break;
    case 3:
        v = (v & 0xfffc3fffu) | (1u << 16) | (1u << 17);
        b1 = 11; b2 = 13;
        break;
    default:
        fw_log_emit1(1, 0x101f148, sel);
        return;
    }
    MMIO32(ABIF_OUT_TO_BUMP_CTL) = v;
    MMIO32(ABIF_OUT_TO_BUMP_CTL) |= 1u << b1;
    MMIO32(ABIF_OUT_TO_BUMP_CTL) |= 1u << b2;
}

/* hwd_abif__uses_rgf_889480_8ced4c (0x8ced4c, 40 Б): on == 1 → [0x8894a0] |= 0xffe00000,
 * [0x8894a4] |= бит 5; иначе [0x8894a0] &= 0x1fffff (bmsk 20), [0x8894a4] &= ~бит 5. */
void hwd_abif_uses_rgf_889480_8ced4c(u32 on)
{
    if (on == 1) {
        MMIO32(HW_ABIF_DVS_CLK_CFG) |= 0xffe00000u;
        MMIO32(HW_ABIF_DVS_CTRL_24) |= 1u << 5;
    } else {
        MMIO32(HW_ABIF_DVS_CLK_CFG) &= 0x1fffffu;
        MMIO32(HW_ABIF_DVS_CTRL_24) &= ~(1u << 5);
    }
}

/* hwd_abif__rx_prepare_rvga_pwdn (0x8cee94, 44 Б): [0x88ae60][9:2] = v
 * (v > 0xff → ассерт 0xac, запись без усечения). */
void hwd_abif_rx_prepare_rvga_pwdn(u32 v)
{
    if (v & ~0xffu)
        fw_sysassert_fatal(CALLER(), 0xac);
    MMIO32(ABIF_RX_PREPARE_PWDN) = (MMIO32(ABIF_RX_PREPARE_PWDN) & ~0x3fcu) | (v << 2);
}

/* hwd_abif__rx_prepared_rvga_pwdn_get (0x8ceed0, 14 Б): [0x88ae60][9:2]. */
u32 hwd_abif_rx_prepared_rvga_pwdn_get(void)
{
    return (u8)(MMIO32(ABIF_RX_PREPARE_PWDN) >> 2);
}

/* hwd_abif__rx_rgf_config_sar_dc (0x8ceee0, 110 Б): 5-битное поле SAR DC в RGF 0x88af10.
 * idx ≥ 8 → ассерт 0x10ae, b ≥ 2 → 0x10af, c ≥ 2 → 0x10b0 (знаковые сравнения).
 * k = (u8)(7 - idx); слово = (u8)((k >> 2) + b·4 + c·2) (add1_s r15,r15,r13 = r15 + r13·2),
 * сдвиг = (k & 3)·8. */
void hwd_abif_rx_rgf_config_sar_dc(u32 idx, u32 b, u32 c, u32 v)
{
    u32 k, w, sh, addr;

    if ((s32)idx >= 8)
        fw_sysassert_fatal(CALLER(), 0x10ae);
    if ((s32)b >= 2)
        fw_sysassert_fatal(CALLER(), 0x10af);
    if ((s32)c >= 2)
        fw_sysassert_fatal(CALLER(), 0x10b0);
    k = (u8)(7 - idx);
    w = (u8)((u32)((s32)k >> 2) + (b << 2) + (c << 1));
    sh = (k & 3u) << 3;
    addr = ABIF_SAR_DC + (w << 2);
    MMIO32(addr) = (MMIO32(addr) & ~(0x1fu << sh)) | (v << sh);
}

/* hwd_abif__rx_rgf_config_sar_gain (0x8cef50, 80 Б): 4-битное поле усиления SAR
 * в [0x88af30 + c·4], сдвиг (u8)((u8)(7 - idx)·4). Первый аргумент (r0) vendor не
 * читает (сохраняет только r1..r3). idx ≥ 8 → ассерт 0x10b3, c ≥ 2 → 0x10b4. */
void hwd_abif_rx_rgf_config_sar_gain(u32 unused, u32 idx, u32 c, u32 v)
{
    u32 sh, addr;

    (void)unused;
    if ((s32)idx >= 8)
        fw_sysassert_fatal(CALLER(), 0x10b3);
    if ((s32)c >= 2)
        fw_sysassert_fatal(CALLER(), 0x10b4);
    sh = (u8)((u8)(7 - idx) << 2);
    addr = ABIF_SAR_GAIN + (c << 2);
    MMIO32(addr) = (MMIO32(addr) & ~(0xfu << sh)) | (v << sh);
}

/* hwd_abif__rx_table_config_ifrx_gain (0x8cf15c, 62 Б): RX-таблица, слово 3 строки row,
 * биты [16:12] = v. row ≥ 0x40 → ассерт 0x1510. */
void hwd_abif_rx_table_config_ifrx_gain(u32 row, u32 v)
{
    u32 addr;

    if ((s32)row >= 0x40)
        fw_sysassert_fatal(CALLER(), 0x1510);
    addr = ABIF_RX_TABLE + ((row << 2) + 3) * 4;
    MMIO32(addr) = (MMIO32(addr) & 0xfffe0fffu) | (v << 12);
}

/* hwd_abif__rx_table_config_sar_dc (0x8cf19c, 180 Б): 5-битное поле SAR DC в таблице
 * 0x88a608 (8 слов на строку). idx ≥ 8 → 0x10b5, b ≥ 2 → 0x10b6, c ≥ 2 → 0x10b7,
 * row ≥ 0x40 → 0x10b8; k = (u8)(7 - idx) ≥ 8 → 0x10b9; j = (u8)(c + b·2)
 * (add1 r13,r16,r15 = c + (b << 1)) ≥ 4 → 0x10ba. Позиция: e = k + j·8 (add3),
 * слово = abif_rx_sar_dc_word[e] + row·8, сдвиг = abif_rx_sar_dc_sh[e] (0x801ab4/0x801ad4). */
void hwd_abif_rx_table_config_sar_dc(u32 row, u32 idx, u32 b, u32 c, u32 v)
{
    u32 k, j, e, w, sh, addr;

    if ((s32)idx >= 8)
        fw_sysassert_fatal(CALLER(), 0x10b5);
    if ((s32)b >= 2)
        fw_sysassert_fatal(CALLER(), 0x10b6);
    if ((s32)c >= 2)
        fw_sysassert_fatal(CALLER(), 0x10b7);
    if ((s32)row >= 0x40)
        fw_sysassert_fatal(CALLER(), 0x10b8);
    k = (u8)(7 - idx);
    j = (u8)(c + (b << 1));
    if ((s32)k >= 8)
        fw_sysassert_fatal(CALLER(), 0x10b9);
    if ((s32)j >= 4)
        fw_sysassert_fatal(CALLER(), 0x10ba);
    e = k + (j << 3);
    w = abif_rx_sar_dc_word[e];
    sh = abif_rx_sar_dc_sh[e];
    w += row << 3;
    addr = ABIF_RX_SAR_DC_TABLE + (w << 2);
    MMIO32(addr) = (MMIO32(addr) & ~(0x1fu << sh)) | (v << sh);
}

/* hwd_abif__rx_table_config_vga_dc_dac_pwdn (0x8cf3e0, 56 Б): RX-таблица, слово 3 строки
 * row, биты [7:4] = v. row ≥ 0x40 → ассерт 0x10ff. */
void hwd_abif_rx_table_config_vga_dc_dac_pwdn(u32 row, u32 v)
{
    u32 addr;

    if ((s32)row >= 0x40)
        fw_sysassert_fatal(CALLER(), 0x10ff);
    addr = ABIF_RX_TABLE + ((row << 2) + 3) * 4;
    MMIO32(addr) = (MMIO32(addr) & ~0xf0u) | (v << 4);
}

/* hwd_abif__rx_table_force_reload (0x8cf588, 20 Б): строб перезагрузки RX-таблицы —
 * бит 0 [0x88a204] сбросить, затем установить. */
void hwd_abif_rx_table_force_reload(void)
{
    MMIO32(HW_ABIF_RX_TABLE_CTRL) &= ~1u;
    MMIO32(HW_ABIF_RX_TABLE_CTRL) |= 1u;
}

/* hwd_abif__uses_rgf_88a208_8cf5fc (0x8cf5fc, 66 Б): чтение строки RX-таблицы —
 * out[i] = [0x88a208 + (row·4 + i)·4], i = 0..2 (lp 3). row ≥ 0x40 → ассерт 0x12ce. */
void hwd_abif_uses_rgf_88a208_8cf5fc(u32 row, u32 *out)
{
    u32 i;

    if ((s32)row >= 0x40)
        fw_sysassert_fatal(CALLER(), 0x12ce);
    for (i = 0; i < 3; i++)
        out[i] = MMIO32(ABIF_RX_TABLE + (i + (row << 2)) * 4);
}

/* hwd_abif__rx_table_read_vga_atten (0x8cf640, 112 Б): бит аттенюатора VGA ступени stage
 * (2..4) половины b (0/1): слово b + 1 строки row, сдвиг = байт
 * abif_rx_vga_atten_rd_sh[(u8)(4 - stage) + b·4] (0x80053c). stage ∉ [2,5) → ассерт 0x1303, b ≥ 2 → 0x1304,
 * row ≥ 0x40 → 0x1305. */
u32 hwd_abif_rx_table_read_vga_atten(u32 row, u32 stage, u32 b)
{
    u32 sh, v;

    if ((s32)stage >= 5 || (s32)stage < 2)
        fw_sysassert_fatal(CALLER(), 0x1303);
    if ((s32)b >= 2)
        fw_sysassert_fatal(CALLER(), 0x1304);
    if ((s32)row >= 0x40)
        fw_sysassert_fatal(CALLER(), 0x1305);
    sh = abif_rx_vga_atten_rd_sh[(u8)(4 - stage) + (b << 2)];
    v = MMIO32(ABIF_RX_TABLE + ((b + 1) + (row << 2)) * 4);
    return (v >> sh) & 1u;
}

/* hwd_abif__rx_table_read_vga_bias (0x8cf6b0, 102 Б): 4-битный bias VGA ступени stage
 * (1..5): слово abif_rx_vga_bias_rd_word[stage-1] + row·4 (0x801b08), сдвиг =
 * abif_rx_vga_bias_rd_sh[stage - 1] (0x80056c). row ≥ 0x40 → ассерт 0x12e1, stage ∉ [1,6) → 0x12e2.
 * Таблицы — копии таблиц записи (hwd_abif_rx_table_config_vga_bias: 0x801af4/0x800564) —
 * так у vendor. */
u32 hwd_abif_rx_table_read_vga_bias(u32 row, u32 stage)
{
    u32 w, sh;

    if ((s32)row >= 0x40)
        fw_sysassert_fatal(CALLER(), 0x12e1);
    if ((s32)stage >= 6 || (s32)stage < 1)
        fw_sysassert_fatal(CALLER(), 0x12e2);
    stage = (u8)(stage - 1);
    w = abif_rx_vga_bias_rd_word[stage] + (row << 2);
    sh = abif_rx_vga_bias_rd_sh[stage];
    return (MMIO32(ABIF_RX_TABLE + w * 4) >> sh) & 0xfu;
}

/* hwd_abif__rx_table_read_vga_stg1_fine_bias (0x8cf848, 76 Б): 4-битный fine-bias ступени 1
 * половины b: слово b + 1 строки row, сдвиг = abif_rx_stg1_fine_bias_sh[b] (0x800530). b ≥ 2 → ассерт 0x12fe,
 * row ≥ 0x40 → 0x12ff. */
u32 hwd_abif_rx_table_read_vga_stg1_fine_bias(u32 row, u32 b)
{
    u32 sh;

    if ((s32)b >= 2)
        fw_sysassert_fatal(CALLER(), 0x12fe);
    if ((s32)row >= 0x40)
        fw_sysassert_fatal(CALLER(), 0x12ff);
    sh = abif_rx_stg1_fine_bias_sh[b];
    return (MMIO32(ABIF_RX_TABLE + ((b + 1) + (row << 2)) * 4) >> sh) & 0xfu;
}

/* hwd_abif__rx_table_write_row (0x8cf8c0, 64 Б): [0x88a208 + (row·4 + i)·4] = in[i],
 * i = 0..2 (lp 3). row ≥ 0x40 → ассерт 0x12e3. */
void hwd_abif_rx_table_write_row(u32 row, const u32 *in)
{
    u32 i;

    if ((s32)row >= 0x40)
        fw_sysassert_fatal(CALLER(), 0x12e3);
    for (i = 0; i < 3; i++)
        MMIO32(ABIF_RX_TABLE + (i + (row << 2)) * 4) = in[i];
}

/* hwd_abif__sensor_set_bgp_params (0x8cfa24, 122 Б): параметры bandgap термодатчика в
 * [0x889364]: поля [13:8] = a ^ 0x1e, [21:16] = b ^ 0x12, [29:24] = c ^ 0x34 (поля
 * хранятся с инверсией битов по умолчанию). Значение после xor > 0x3f → ассерты 0xaf /
 * 0xb0 / 0xb1 (запись без усечения: b, c выходят в старшие поля — как у vendor). */
void hwd_abif_sensor_set_bgp_params(u32 a, u32 b, u32 c)
{
    u32 x = a ^ 0x1e, y = b ^ 0x12, z = c ^ 0x34, v;

    if (x & ~0x3fu)
        fw_sysassert_fatal(CALLER(), 0xaf);
    if (y & ~0x3fu)
        fw_sysassert_fatal(CALLER(), 0xb0);
    if (z & ~0x3fu)
        fw_sysassert_fatal(CALLER(), 0xb1);
    v = MMIO32(ABIF_SENSOR_BGAP_CTRL) & 0xffc0c0ffu;
    v |= (x << 8) & 0xffc0ffffu;
    v |= y << 16;
    v &= 0xc0ffffffu;
    MMIO32(ABIF_SENSOR_BGAP_CTRL) = v | (z << 24);
}

/* hwd_abif__tx_table_config_iftx_gain (0x8cfd18, 54 Б): TX-таблица 0x88a004, слово 3
 * строки row, биты [4:0] = v (v без маски). row ≥ 0x20 → ассерт 0x1126. */
void hwd_abif_tx_table_config_iftx_gain(u32 row, u32 v)
{
    u32 addr;

    if ((s32)row >= 0x20)
        fw_sysassert_fatal(CALLER(), 0x1126);
    addr = ABIF_TX_TABLE + ((row << 2) + 3) * 4;
    MMIO32(addr) = (MMIO32(addr) & ~0x1fu) | v;
}

/* hwd_abif__tx_table_config_tx_mixer_gate_ctrl (0x8cfe24, 54 Б): TX-таблица, слово 2
 * строки row, биты [8:4] = v. row ≥ 0x20 → ассерт с кодом 0x20 (vendor mov_s r1,0x20 —
 * без bset 12, в отличие от соседей 0x1126/0x112b). */
void hwd_abif_tx_table_config_tx_mixer_gate_ctrl(u32 row, u32 v)
{
    u32 addr;

    if ((s32)row >= 0x20)
        fw_sysassert_fatal(CALLER(), 0x20);
    addr = ABIF_TX_TABLE + ((row << 2) + 2) * 4;
    MMIO32(addr) = (MMIO32(addr) & ~0x1f0u) | (v << 4);
}

/* hwd_abif__tx_table_config_xif_ctrl (0x8cfe5c, 62 Б): TX-таблица, слово 3 строки row,
 * биты [23:20] = v. row ≥ 0x20 → ассерт 0x112b. */
void hwd_abif_tx_table_config_xif_ctrl(u32 row, u32 v)
{
    u32 addr;

    if ((s32)row >= 0x20)
        fw_sysassert_fatal(CALLER(), 0x112b);
    addr = ABIF_TX_TABLE + ((row << 2) + 3) * 4;
    MMIO32(addr) = (MMIO32(addr) & 0xff0fffffu) | (v << 20);
}

/* hwd_abif__tx_table_force_reload (0x8cfed8, 20 Б): строб перезагрузки TX-таблицы —
 * бит 0 [0x88a000] сбросить, затем установить. */
void hwd_abif_tx_table_force_reload(void)
{
    MMIO32(ABIF_TX_TABLE_CTRL) &= ~1u;
    MMIO32(ABIF_TX_TABLE_CTRL) |= 1u;
}

/* hwd_abif__tx_table_read_dac_fssel (0x8cff4c, 28 Б): *out = слово 0 строки row TX-таблицы
 * [6:0] (без проверки row), хвостовой журнал (0x21, 0x101f068, значение). */
void hwd_abif_tx_table_read_dac_fssel(u32 row, u32 *out)
{
    u32 v = MMIO32(ABIF_TX_TABLE + (row << 4)) & 0x7fu;

    *out = v;
    fw_log_emit1(0x21, 0x101f068, v);
}
