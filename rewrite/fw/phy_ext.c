// SPDX-License-Identifier: AGPL-3.0-or-later
/* PHY: буфер записи (recording) и воспроизведения (play buffer), BRP RAM, SAR RSSI,
 * энергия/RSSI приёма, онлайн-измерения DC/усиления, пред-/пост-искажение DC/IQ и
 * запросы fw_sysapi_mgr (0x805170) поверх них: оценка канала, статистика энергии,
 * PHY-данные пакета, статистика приёма PHY.
 *
 * Сисассерты: vendor передаёт blink (mov r0,blink) — здесь __builtin_return_address(0).
 * Числовые адреса данных — как у vendor ([gp,N] пересчитаны: gp = 0x800184). */
#include "../include/types.h"
#include "../include/fwdata.h"
#include "../include/hw.h"
#include "../include/sysapi_mgr.h"
#include "../include/lmac_cmd.h"



/* Ядро fw_sysapi_mgr (0x805170) и помощники его команд. */

#define CALLER() __builtin_return_address(0)

/* Глобальные данные vendor (байтовые [gp,N]: gp = 0x800184). */
/* Поправки RSSI: строка «0 дБ» calib_zero_db.row8 (0x800508) и rf_if_gain_rssi_ofs (0x800227,
 * ldb [gp,163]); vendor читает их заново при каждом использовании — volatile. */
#define G_ZERO_DB_ROW   (calib_zero_db.row8)

/* ======================= мелкие регистровые помощники ======================= */

/* hwd_mac__sxd_tx_phy_frame_start (0x8d1044, 16 Б): команда SXD 0x3d002000 в
 * 0x886dc8 (mac_sxd_base + 0x48). */
void hwd_mac_sxd_tx_phy_frame_start(void)
{
    MMIO32(HW_SXD_LOCAL_WR_DATA) = 0x3d002000u;
}

/* rx_energy__calc_rssi_q4 (0x8d1b70, 24 Б): RSSI (Q4) из отсчёта ADC adc, индекса
 * усиления gain и двух поправок (a2 = u8 [0x800508], a3 = u8 [0x800227]):
 * adc - ((a3 >> 1) + 5 + (a2 - gain) - 17) * 16 - 560 - 608 (два вычитания — как vendor). */
s32 rx_energy_calc_rssi_q4(u32 adc, u32 gain, u32 a2, u32 a3)
{
    u32 t = ((a3 >> 1) + 5u + (a2 - gain) - 0x11u) << 4;
    return (s32)(adc - t - 560u - 608u);
}

/* phy__get_885178_3bit (0x8d1b88, 12 Б). */
u32 phy_get_885178_3bit(void)
{
    return MMIO32(PHY_RAM_READ_SEL) & 7u;
}

/* phy__set_885178_3bit (0x8d1b94, 42 Б): v вне 3 бит — ассерт 0xac (затем запись как есть). */
void phy_set_885178_3bit(u32 v)
{
    if (v & ~7u)
        fw_sysassert_fatal(CALLER(), 0xac);
    MMIO32(PHY_RAM_READ_SEL) = (MMIO32(PHY_RAM_READ_SEL) & ~7u) | v;
}

/* hwd_phy__online_dc_measurement_read (0x8d1d94, 50 Б): idx-е слово 0x885110 —
 * два 11-битных знаковых поля (биты 16..26 → out[0], 0..10 → out[1]); значение > 1024
 * переводится в отрицательное (−2048, как vendor: 1024 остаётся положительным). */
void hwd_phy_online_dc_measurement_read(u32 idx, s16 *out)
{
    u32 w = MMIO32(PHY_ONLINE_DC_MEAS + idx * 4);
    s32 a = (s32)((w >> 16) & 0x7ffu);
    s32 b = (s32)(w & 0x7ffu);

    if (a > 1024)
        a -= 2048;
    if (b > 1024)
        b -= 2048;
    out[0] = (s16)a;
    out[1] = (s16)b;
}

/* hwd_phy__online_gain_measurement_read (0x8d1dc8, 24 Б): idx-е слово 0x885130 —
 * биты 16..26 → out[0], 0..10 → out[1] (без знака). */
void hwd_phy_online_gain_measurement_read(u32 idx, u16 *out)
{
    u32 w = MMIO32(PHY_ONLINE_GAIN_MEAS + idx * 4);

    out[0] = (u16)((w >> 16) & 0x7ffu);
    out[1] = (u16)(w & 0x7ffu);
}

/* hwd_phy__online_measurement_completed (0x8d1de0, 14 Б): ждать бит 12 0x885004 —
 * без предела, как vendor (bbit0 на себя). */
void hwd_phy_online_measurement_completed(void)
{
    while (!(MMIO32(PHY_SAR_MEAS_STATUS) & (1u << 12)))
        ;
}

/* hwd_phy__online_measurement_config (0x8d1df0, 66 Б): длина окна 2^a5 (64 бита:
 * [0x885008] = 1 << a5, [0x88500c] = знак младшего слова — asr 31, т. е. 0xffffffff
 * только при a5 = 31; bset по модулю 32), [0x885004] = 1, затем
 * [0x885000] = a0*2 + 1 + a1<<4 + a2<<5 + a3<<8 + a4<<20. */
void hwd_phy_online_measurement_config(u32 a0, u32 a1, u32 a2, u32 a3, u32 a4, u32 a5)
{
    u32 lo = 1u << (a5 & 31u);

    MMIO32(PHY_SAR_MEAS_LENGTH_LO) = lo;
    MMIO32(PHY_SAR_MEAS_LENGTH_HI) = (u32)((s32)lo >> 31);
    MMIO32(PHY_SAR_MEAS_STATUS) = 1;
    MMIO32(PHY_SAR_MEAS_CTL) = (a4 << 20) + (a3 << 8) + (a2 << 5) + (a1 << 4) + (a0 << 1) + 1u;
}

/* hwd_phy__online_measurement_start (0x8d1e34, 20 Б): биты 0 и 6 0x885000 — снять и
 * поставить одной записью. */
void hwd_phy_online_measurement_start(void)
{
    u32 v = MMIO32(PHY_SAR_MEAS_CTL);

    v &= ~1u;
    v &= ~(1u << 6);
    MMIO32(PHY_SAR_MEAS_CTL) = v | 0x41u;
}

/* hwd_phy__online_measurement_stop (0x8d1e48, 14 Б). */
void hwd_phy_online_measurement_stop(void)
{
    MMIO32(PHY_SAR_MEAS_CTL) &= ~1u;
}

/* hwd_phy__online_sar_measurement_valid (0x8d1e58, 14 Б): бит 12 0x885004. */
u32 hwd_phy_online_sar_measurement_valid(void)
{
    return (MMIO32(PHY_SAR_MEAS_STATUS) >> 12) & 1u;
}

/* hwd_phy__rx_is_enabled (0x8d21c4, 12 Б): бит 0 0x883010. */
u32 hwd_phy_rx_is_enabled(void)
{
    return MMIO32(HW_PHY_RX_CTL) & 1u;
}

/* phy_rx__read_rssi_adc (0x8d21f8, 16 Б): 10-битный знаковый RSSI ADC ([0x883be4]). */
u32 phy_rx_read_rssi_adc(void)
{
    return bits_sign_extend_n(MMIO32(PHY_RX_RSSI_ADC) & 0x3ffu, 10);
}

/* phy_rx__read_rssi_adc_locked (0x8d2208, 16 Б): то же из снимка по SFD ([0x883bec]). */
u32 phy_rx_read_rssi_adc_locked(void)
{
    return bits_sign_extend_n(MMIO32(PHY_RX_RSSI_ADC_LOCKED) & 0x3ffu, 10);
}

/* phy__get_88312c_6bit (0x8d25a8, 12 Б): стартовый индекс AGC. */
u32 phy_get_88312c_6bit(void)
{
    return MMIO32(HW_PHY_RX_INA_AGC_START) & 0x3fu;
}

/* phy__get_88306c_6bit (0x8d25b4, 12 Б). */
u32 phy_get_88306c_6bit(void)
{
    return MMIO32(HW_PHY_RX_AGC_ROW) & 0x3fu;
}

/* hwd_phy__rx_cal_gain_measurement_read (0x8d24bc, 64 Б): два 56-битных накопителя idx
 * как u64: out[0] = [0x885090+8i] + ([0x885094+8i] << 24), out[1] = 0; out[2..3] — то же
 * из 0x8850d0/0x8850d4 (старшее слово vendor обнуляет — перенос сложения теряется). */
void hwd_phy_rx_cal_gain_measurement_read(u32 idx, u32 *out)
{
    u32 lo = MMIO32(PHY_RX_CAL_GAIN_ACC_A_LO + idx * 8);
    u32 hi = MMIO32(PHY_RX_CAL_GAIN_ACC_A_HI + idx * 8);

    out[0] = (hi << 24) + lo;
    out[1] = 0;
    lo = MMIO32(PHY_RX_CAL_GAIN_ACC_B_LO + idx * 8);
    hi = MMIO32(PHY_RX_CAL_GAIN_ACC_B_HI + idx * 8);
    out[3] = 0;
    out[2] = (hi << 24) + lo;
}

/* hwd_phy__rx_postdist_dc_enable (0x8d26d0, 48 Б): бит 9 0x883584 = !en (бит запрета). */
void hwd_phy_rx_postdist_dc_enable(u32 en)
{
    u32 v = (en != 0) ? 0u : 1u;

    if (v & 0xfeu)                       /* bic.f r12,r12,0xffffff01 — не срабатывает */
        fw_sysassert_fatal(CALLER(), 0xac);
    MMIO32(PHY_RX_POSTDIST_DC) = (MMIO32(PHY_RX_POSTDIST_DC) & ~(1u << 9)) | (v << 9);
}

/* hwd_phy__rx_postdist_dc_per_sar_mode (0x8d2700, 40 Б): бит 0 0x8851a0 = v. */
void hwd_phy_rx_postdist_dc_per_sar_mode(u32 v)
{
    if (v & ~1u)
        fw_sysassert_fatal(CALLER(), 0xac);
    MMIO32(PHY_RX_POSTDIST_DC_PER_SAR) = (MMIO32(PHY_RX_POSTDIST_DC_PER_SAR) & ~1u) | v;
}

/* hwd_phy__rx_postdist_force_dc_config (0x8d2728, 48 Б): принудительный DC I/Q —
 * 4-битные дополнительные коды (отрицательное + 16) в младший байт 0x883584:
 * биты 0..3 = i, 4..7 = q (сумма q<<4 + i усечена до байта, как extb vendor). */
void hwd_phy_rx_postdist_force_dc_config(s32 i, s32 q)
{
    u32 a = (i < 0) ? (u8)(i + 16) : (u8)i;
    u32 b = (q < 0) ? (u8)(q + 16) : (u8)q;
    u32 v = (u8)((b << 4) + a);

    MMIO32(PHY_RX_POSTDIST_DC) = (MMIO32(PHY_RX_POSTDIST_DC) & ~0xffu) | v;
}

/* hwd_phy__rx_postdist_force_dc_set (0x8d2758, 42 Б): бит 8 0x883584 = v. */
void hwd_phy_rx_postdist_force_dc_set(u32 v)
{
    if (v & ~1u)
        fw_sysassert_fatal(CALLER(), 0xac);
    MMIO32(PHY_RX_POSTDIST_DC) = (MMIO32(PHY_RX_POSTDIST_DC) & ~(1u << 8)) | (v << 8);
}

/* hwd_phy__rx_postdist_sar_dc_config (0x8d2784, 84 Б): DC пост-искажения для SAR-режима
 * sar (< 8, иначе ассерт 0x10de) и ветви iq (< 2, иначе 0x10df): 6-битное значение в байт
 * (sar & 3) слова 0x8851a4 + 4*((sar >> 2) + 2*iq). vendor: bic с маской (-1 << sh)
 * оставляет только поля НИЖЕ записываемого — старшие байты слова обнуляются
 * (0x8d27ae..0x8d27b4); поведение сохранено. */
void hwd_phy_rx_postdist_sar_dc_config(s32 sar, s32 iq, u32 v)
{
    if (sar >= 8)
        fw_sysassert_fatal(CALLER(), 0x10de);
    if (iq >= 2)
        fw_sysassert_fatal(CALLER(), 0x10df);
    u32 w = (u8)((sar >> 2) + ((u32)iq << 1));
    u32 sh = ((u32)sar & 3u) << 3;
    u32 a = 0x8851a4u + w * 4;              /* массив postdist DC по SAR; нет в REGS-KNOWN, 1 обращение */

    MMIO32(a) = ((v & 0x3fu) << sh) | (MMIO32(a) & ~(0xffffffffu << sh));
}

/* hwd_phy__self_digital_loopback (0x8d2b0c, 42 Б): бит 1 0x883010 = v. */
void hwd_phy_self_digital_loopback(u32 v)
{
    if (v & ~1u)
        fw_sysassert_fatal(CALLER(), 0xac);
    MMIO32(HW_PHY_RX_CTL) = (MMIO32(HW_PHY_RX_CTL) & ~2u) | (v << 1);
}

/* hwd_phy__tx_predist_dc_config (0x8d2eb8, 100 Б): en = 0 — обход ([0x88413c] = 1) и
 * обнуление полей I/Q 0x884138; иначе [0x88413c] = 0, i (10 бит, иначе ассерт 0xad) в
 * биты 0..9, q (10 бит, иначе 0xae) в 16..25, биты 10..15 и 26..31 сохраняются. */
void hwd_phy_tx_predist_dc_config(u32 en, u32 i, u32 q)
{
    if (en == 0) {
        MMIO32(PHY_TX_PREDIST_DC_BYPASS) = 1;
        MMIO32(PHY_TX_PREDIST_DC) &= 0xfc00fc00u;
        return;
    }
    MMIO32(PHY_TX_PREDIST_DC_BYPASS) = 0;
    if (i & 0xfffffc00u)
        fw_sysassert_fatal(CALLER(), 0xad);
    if (q & 0xfffffc00u)
        fw_sysassert_fatal(CALLER(), 0xae);
    u32 keep = MMIO32(PHY_TX_PREDIST_DC) & 0xfffffc00u & 0xfc00ffffu;
    MMIO32(PHY_TX_PREDIST_DC) = (q << 16) | (i & 0xfc00ffffu) | keep;
}

/* hwd_phy__tx_predist_iq_config (0x8d2f1c, 106 Б): en = 0 — поля 0..9/16..25 и бит 28
 * 0x884024 сброшены, затем бит 28 = 1 (обход); иначе a (биты 0..9, иначе ассерт 0xb0),
 * b (16..25, иначе 0xb1), бит 28 = 0. */
void hwd_phy_tx_predist_iq_config(u32 en, u32 a, u32 b)
{
    if (en == 0) {
        MMIO32(PHY_TX_PREDIST_IQ) = (MMIO32(PHY_TX_PREDIST_IQ) & 0xec00fc00u) | (1u << 28);
        return;
    }
    if (a & 0xfffffc00u)
        fw_sysassert_fatal(CALLER(), 0xb0);
    if (b & 0xfffffc00u)
        fw_sysassert_fatal(CALLER(), 0xb1);
    u32 keep = MMIO32(PHY_TX_PREDIST_IQ) & 0xec00fc00u;
    MMIO32(PHY_TX_PREDIST_IQ) = (b << 16) | (a & 0xfc00ffffu) | keep;
}

/* ======================= буфер записи / воспроизведения ======================= */

/* Режим выборки буфера в 0x8801e0: биты 6..8 — бит 6 всегда 1, бит 7 = b7, бит 8 = b8
 * (общий кусок hwd_phy__recording_mode_set и hwd_phy__tx_play_buffer_start). */
static void phy_rec_window_bits(void *caller, u32 b7, u32 b8)
{
    if (b7 & ~1u)
        fw_sysassert_fatal(caller, 0xb0);
    if (b8 & ~1u)
        fw_sysassert_fatal(caller, 0xb1);
    u32 v = (MMIO32(RGF_USER_USER_CPU_0) & ~0xc0u) | (1u << 6);
    v = ((b7 << 7) | v) & ~(1u << 8);
    MMIO32(RGF_USER_USER_CPU_0) = (b8 << 8) | v;
}

/* hwd_phy_recording_get (0x8d1f24, 164 Б): прочитать n слов записи PHY со смещения off.
 * Окно: биты 6..8 0x8801e0 → число банков по 16 КБ (сумма битов). out[0] — статус:
 * 3 — n > 32; 2 — off + n больше окна (банки << 14); 1 — успех, тогда out[2..] — слова.
 * out[1] = [0x8835a4] & 0x1fff (во всех случаях). Адрес чтения — как vendor:
 * 0x8f0000 - (старшие 16 бит off*4 << 16) + младшие 16 бит off*4 (окно растёт вниз
 * по 64 КБ от 0x8f0000). */
void hwd_phy_recording_get(u32 off, u32 n, u32 *out)
{
    u32 r3 = (MMIO32(RGF_USER_USER_CPU_0) >> 6) & 1u;
    u32 banks = (MMIO32(RGF_USER_USER_CPU_0) >> 7) & 1u;
    banks += r3;
    banks += (MMIO32(RGF_USER_USER_CPU_0) >> 8) & 1u;
    banks = (u8)banks;

    out[1] = MMIO32(PHY_REC_LAST_ADDRESS) & 0x1fffu;
    if (n >= 0x21) {
        out[0] = 3;
        return;
    }
    if ((banks << 14) < n + off) {
        out[0] = 2;
        return;
    }
    out[0] = 1;
    out[1] = MMIO32(PHY_REC_LAST_ADDRESS) & 0x1fffu;

    u32 byteoff = off << 2;
    u32 base = 0x8f0000u - ((byteoff >> 16) << 16);
    fw_log_emit1(0x21, 0x101d8ac, base);
    base += byteoff & 0xffffu;
    fw_log_emit1(0x21, 0x101d8d8, base);

    u32 i;
    for (i = 0; i < n; i++)
        out[2 + i] = *(volatile u32 *)(base + i * 4);
}

/* hwd_phy__recording_mode_set (0x8d1fc8, 400 Б): режим записи PHY.
 *   mode (знаковый): <= 1 — окно 1 банк, выборка 1; 2 — 2 банка, 3; > 2 — 3 банка, 7.
 *   0x8801e0[8:6] — окно (см. phy_rec_window_bits), 0x8838a8[2:0] — выборка.
 *   save_rx != 0: запомнить биты 0 и 2 0x883010, на время настройки RX выкл. (бит 0 = 0,
 *   бит 2 = 1, бит 0 = 1 — тремя отдельными RMW, как vendor) и вернуть в конце.
 *   src: бит 0 0x8838a4 = (src != 4); src == 0xb — ещё раз сбросить бит 0, к src бит 15.
 *   Младшие 16 бит: 0x883594 = src, 0x88359c = trig, 0x883598 = 0 (при len == 0x1f
 *   сперва 0x1e), затем len. Значение больше 16 бит — ассерт 0xac. */
void hwd_phy_recording_mode_set(u32 mode, u32 save_rx, u32 trig, u32 src, u32 len)
{
    u32 b7 = ((s32)mode > 1) ? 1u : 0u;
    u32 b8 = ((s32)mode > 2) ? 1u : 0u;
    u32 sel = ((s32)mode > 2) ? 7u : (1u + (b7 << 1));
    u32 rx_en = 0, rx_b2 = 0;

    phy_rec_window_bits(CALLER(), b7, b8);
    if (sel & ~7u)
        fw_sysassert_fatal(CALLER(), 0xac);
    MMIO32(PHY_REC_RAM_MASK) = (MMIO32(PHY_REC_RAM_MASK) & ~7u) | sel;

    if (save_rx != 0) {
        rx_en = MMIO32(HW_PHY_RX_CTL) & 1u;
        rx_b2 = (MMIO32(HW_PHY_RX_CTL) >> 2) & 1u;
        MMIO32(HW_PHY_RX_CTL) &= ~1u;
        MMIO32(HW_PHY_RX_CTL) |= 1u << 2;
        MMIO32(HW_PHY_RX_CTL) |= 1u;
    }

    if (src == 4)
        MMIO32(HW_PHY_8838A4) &= ~1u;
    else
        MMIO32(HW_PHY_8838A4) |= 1u;
    if (src == 0xb) {
        src |= 1u << 15;
        MMIO32(HW_PHY_8838A4) &= ~1u;
    }

    if (src & 0xffff0000u)
        fw_sysassert_fatal(CALLER(), 0xac);
    MMIO32(PHY_REC_DATA_MODE) = (MMIO32(PHY_REC_DATA_MODE) & 0xffff0000u) | src;
    if (trig & 0xffff0000u)
        fw_sysassert_fatal(CALLER(), 0xac);
    MMIO32(PHY_REC_POST_TRIGGER_DURATION) = (MMIO32(PHY_REC_POST_TRIGGER_DURATION) & 0xffff0000u) | trig;
    MMIO32(PHY_REC_TRIGGER_MODE) &= 0xffff0000u;
    if (len == 0x1f)
        MMIO32(PHY_REC_TRIGGER_MODE) = (MMIO32(PHY_REC_TRIGGER_MODE) & 0xffff0000u) | 0x1eu;
    if (len & 0xffff0000u)
        fw_sysassert_fatal(CALLER(), 0xac);
    MMIO32(PHY_REC_TRIGGER_MODE) = (MMIO32(PHY_REC_TRIGGER_MODE) & 0xffff0000u) | len;

    if (save_rx == 0)
        return;
    MMIO32(HW_PHY_RX_CTL) &= ~1u;
    if (rx_b2 & ~1u)
        fw_sysassert_fatal(CALLER(), 0xac);
    MMIO32(HW_PHY_RX_CTL) = (MMIO32(HW_PHY_RX_CTL) & ~(1u << 2)) | (rx_b2 << 2);
    if (rx_en & ~1u)
        fw_sysassert_fatal(CALLER(), 0xac);
    MMIO32(HW_PHY_RX_CTL) = (MMIO32(HW_PHY_RX_CTL) & ~1u) | rx_en;
}

/* hwd_phy__tx_play_buffer_start (0x8d2d40, 216 Б): воспроизвести len отсчётов (< 0x1800,
 * иначе ассерт 0x10dd) из буфера записи. en → бит 0 0x88414c; включить 0x884008 бит 0;
 * окно 0x8801e0: бит 7 = (len > 2047), бит 8 = (len > 4095); 0x884150[12:0] = 0,
 * 0x884154[12:0] = len (13 бит, иначе ассерт 0xac); старт 0x884140 бит 0; [0x884158] =
 * val (vendor сперва читает регистр); 0x884144 бит 0. */
void hwd_phy_tx_play_buffer_start(u32 en, u32 len, u32 val)
{
    if (len > 0x17ffu)
        fw_sysassert_fatal(CALLER(), 0x10dd);
    if (en & ~1u)
        fw_sysassert_fatal(CALLER(), 0xac);
    MMIO32(PHY_TX_PLAY_BUFFER_MODE) = (MMIO32(PHY_TX_PLAY_BUFFER_MODE) & ~1u) | en;
    MMIO32(HW_PHY_TX_EN) |= 1u;

    phy_rec_window_bits(CALLER(), len > 2047u ? 1u : 0u, len > 0xfffu ? 1u : 0u);

    MMIO32(PHY_TX_PLAY_BUFFER_START_ADDR) &= 0xffffe000u;
    if (len & 0xffffe000u)
        fw_sysassert_fatal(CALLER(), 0xac);
    MMIO32(PHY_TX_PLAY_BUFFER_LAST_ADDR) = (MMIO32(PHY_TX_PLAY_BUFFER_LAST_ADDR) & 0xffffe000u) | len;
    MMIO32(PHY_TX_PLAY_BUFFER_EN) |= 1u;
    (void)MMIO32(PHY_TX_PLAY_BUFFER_LOOPS);
    MMIO32(PHY_TX_PLAY_BUFFER_LOOPS) = val;
    MMIO32(PHY_TX_PLAY_BUFFER_GO) |= 1u;
}

/* hwd_phy__tx_play_buffer_stop (0x8d2e18, 46 Б): 0x884008 бит 0 = 0, окно 0x8801e0[8:6]
 * = 0, 0x884140 бит 0 = 0, [0x884148] = 1 (vendor сперва читает регистр). */
void hwd_phy_tx_play_buffer_stop(void)
{
    MMIO32(HW_PHY_TX_EN) &= ~1u;
    MMIO32(RGF_USER_USER_CPU_0) &= ~0x1c0u;
    MMIO32(PHY_TX_PLAY_BUFFER_EN) &= ~1u;
    (void)MMIO32(PHY_TX_PLAY_BUFFER_STOP);
    MMIO32(PHY_TX_PLAY_BUFFER_STOP) = 1;
}

/* ======================= APU / BRP RAM / SAR RSSI ======================= */

/* hwd_phy__rx_apu_calc (0x8d2314, 138 Б): out == NULL — ассерт 0x10e1 (затем vendor
 * продолжает и пишет по NULL). out (12 Б) обнуляется; [0x883a74] = a0,
 * [0x883a68] = a2:a1, [0x883a6c] = a4:a3 (по 16 бит; регистры перед записью читаются),
 * [0x883a70] = (u16)a5. Результат (struct phy_apu_res): out_i/out_q — половины phy_apu_out
 * [0x883a78], div_man = [0x883a7c], div_exp = [0x883a80] & 0xf; он же — возвращаемое значение. */
u32 hwd_phy_rx_apu_calc(u32 a0, u32 a1, u32 a2, u32 a3, u32 a4, u32 a5, struct phy_apu_res *out)
{
    if (out == 0)
        fw_sysassert_fatal(CALLER(), 0x10e1);
    memset0_words(out, 0xc);
    MMIO32(PHY_APU_OPCODE) = a0;
    u32 lo = (u16)((MMIO32(PHY_APU_IN_1) & 0xffff0000u) | a1);
    MMIO32(PHY_APU_IN_1) = ((u32)(u16)a2 << 16) | lo;
    lo = (u16)((MMIO32(PHY_APU_IN_2) & 0xffff0000u) | a3);
    MMIO32(PHY_APU_IN_2) = ((u32)(u16)a4 << 16) | lo;
    MMIO32(PHY_APU_IN_PHASE) = (u16)a5;
    out->out_i = (u16)MMIO32(PHY_APU_OUT);
    out->out_q = (u16)(MMIO32(PHY_APU_OUT) >> 16);
    out->div_man = MMIO32(PHY_APU_DIV_OUT_MAN);
    u32 r = MMIO32(PHY_APU_DIV_OUT_EXP) & 0xfu;
    out->div_exp = (u8)r;
    return r;
}

/* hwd_phy_rx_read_and_parse_brp_ram (0x8d27f4, 246 Б): прочитать BRP RAM строками по
 * 0x20 байт (не более 8 строк, пока len >= 0x20) начиная со строки row. На время чтения
 * такт отладки PHY включён и 0x885178[2:0] = 3 (прежнее значение возвращается);
 * 0x883f40: бит 2 = 0, бит 0 = 1. Строка r: адрес r + row*8 (vendor add3 — row << 3; вне
 * байта — ассерт 0xac) в 0x883f84[7:0] и строб бит 8; 8 слов из 0x883f64.. (ld.as) —
 * слово k кладётся байтами в out[o], out[o+2], out[o+4], out[o+6], где
 * o = (k & 3)*8 + r*32 + k/4 (vendor считает k mod 4 через mul64: k - 4*(k/4)).
 * Первый аргумент vendor не использует. Результат hwd_phy__dbg_clk_enable_get —
 * тоже (вызов сохраняем: чтение регистра). */
void hwd_phy_rx_read_and_parse_brp_ram(u32 unused, u32 row, u8 *out, u32 len)
{
    (void)unused;
    fw_log_emit1(0x20, 0x101db60, len);
    (void)hwd_phy_dbg_clk_enable_get();
    u32 saved = phy_get_885178_3bit();
    hwd_phy_dbg_clk_enable(1);
    phy_set_885178_3bit(3);
    MMIO32(PHY_BRP_RAM_CTL) &= ~(1u << 2);
    MMIO32(PHY_BRP_RAM_CTL) |= 1u;

    s32 r;
    for (r = 0; r < 8 && len >= 0x20; r++, len -= 0x20) {
        u32 addr = (u32)r + (row << 3);
        if (addr & 0xffffff00u)
            fw_sysassert_fatal(CALLER(), 0xac);
        MMIO32(PHY_BRP_RAM_ADDR) = (MMIO32(PHY_BRP_RAM_ADDR) & 0xffffff00u) | addr;
        MMIO32(PHY_BRP_RAM_ADDR) |= 1u << 8;
        s32 k;
        for (k = 0; k < 8; k++) {
            u32 w = MMIO32(PHY_BRP_RAM_DATA + (u32)k * 4);
            s32 q = k / 4;
            u32 o = (u8)((u32)((k - 4 * q) << 3) + ((u32)r << 5) + (u32)q);
            fw_log_emit2(0x20, 0x101db90, w, o);
            u8 *p = out + o;
            p[0] = (u8)w;
            p[2] = (u8)(w >> 8);
            p[4] = (u8)(w >> 16);
            p[6] = (u8)(w >> 24);
        }
    }
    hwd_phy_dbg_clk_enable(0);
    phy_set_885178_3bit(saved);
}

/* hwd_phy_rx_sar_rssi_measure (0x8d2968, 232 Б): SAR-измерение мощности по n отсчётам.
 * Такт отладки PHY вкл. (vendor не выключает), конфигурация SAR (1, 0, 1, 0, n, 0),
 * старт, ожидание. По 8 ветвям i: s = SAR-отсчёты (A, B как s64), g = накопители
 * квадратов (u64, 0x8d24bc); дисперсия ветви ((gA/n - A²/n²) + (gB/n - B²/n²)) / 2.
 * vendor: A², B², n² — младшие 32 бита (mul64 → mlo), A/B — младшее слово s64;
 * деления беззнаковые — 32/32 (0x8c02d4) и 64/32 (0x8c047c с r4 = 0, т. е. u64 / n,
 * старшее слово g всегда 0); (… - …) >> 1 — логический сдвиг. Сумма — в лог, затем
 * *out = if_gain_scale_value((sum >> 3) << 5, 5) / 2 (знаковое деление к нулю). */
void hwd_phy_rx_sar_rssi_measure(u32 n, s32 *out)
{
    u32 s[4];      /* vendor [sp+0x00]: A lo/hi, B lo/hi */
    u32 g[4];      /* vendor [sp+0x10]: gA lo/hi, gB lo/hi */
    u32 sum = 0;
    u32 i;

    fw_log_emit1(0x21, 0x101d848, n);
    /* vendor: n из WMI_UNIT_TEST без проверки; n = 0 — деление на 0 (libgcc ARC600 крутится бесконечно), n > 0xffff —
     * n² переполняется. Теперь такие n не меряются. */
    if (n == 0 || n > 0xffffu) {
        *out = 0;
        return;
    }
    hwd_phy_dbg_clk_enable(1);
    hwd_phy_rx_sar_cal_measurement_config(1, 0, 1, 0, n, 0);
    hwd_phy_rx_sar_measurement_start();
    hwd_phy_rx_sar_measurement_completed();
    for (i = 0; i < 8; i++) {
        hwd_phy_read_sar_sample((u8)i, s);
        hwd_phy_rx_cal_gain_measurement_read((u8)i, g);
        u32 a2 = fw_divmod_unsigned(s[0] * s[0], n * n);
        u32 da = (u32)((((u64)g[1] << 32) | g[0]) / n) - a2;
        u32 db = (u32)((((u64)g[3] << 32) | g[2]) / n) + da;
        u32 b2 = fw_divmod_unsigned(s[2] * s[2], n * n);
        sum += (db - b2) >> 1;
    }
    fw_log_emit1(0x21, 0x101d874, sum);
    s32 v = if_gain_scale_value((sum >> 3) << 5, 5);
    *out = v / 2;
}

/* ======================= fw_sysapi_mgr (0x805170) ======================= */
/* Объект — struct fw_sysapi_mgr (include/sysapi_mgr.h). Ядро менеджера (start/stop_sysapi_cmd,
 * send_evt2host, send_measure_evt, get_rssi_and_snr_statistics) — sysapi_stats.c. */

/* channel_est__stack_args (0x8dbe54, 50 Б): LMAC-команда type (0xc Б): 5 байт фильтра
 * (пара слов w0/w1, переданная по значению на стеке) и слово w2 по +8. Байты 5..7 тела
 * vendor не пишет (остаётся содержимое элемента пула). */
void channel_est_stack_args(u32 type, u32 w0, u32 w1, u32 w2)
{
    u32 f[2];
    f[0] = w0;
    f[1] = w1;
    struct lmac_cmd_meas_filter *b = lmac_cmd_pool_alloc();
    memcpy_fw(b, f, 5);
    b->count = w2;
    lmac_if_post_cmd(b, (u16)type, 0xc, 0);
}

/* channel_est__clamp_64 (0x8f9070, 58 Б; vendor-имя неточно): таймаут запроса
 * mgr->timeout = max(timeout, 100) (беззнаково); прежний таймер снять, новый — cb(mgr)
 * через mgr->timeout (u_schd_schedule(cb, mgr, 0, 1, …)). */
void channel_est_clamp_64(struct fw_sysapi_mgr *mgr, u32 timeout, u_schd_fn cb)
{
    mgr->timeout = (timeout > 100u) ? timeout : 100u;
    if (mgr->timer != 0) {
        u_schd_cancel(mgr->timer);
        mgr->timer = 0;
    }
    mgr->timer = u_schd_schedule(cb, (u32)mgr, 0, 1, mgr->timeout, 0, 0);
}

/* Фильтр запроса: 5 байт, vendor копирует 8 (memcpy 0x8c0380, 8) в пару слов для
 * channel_est__stack_args. Байты 5..7 у vendor — неинициализированный стек вызывающего
 * hw_sysapi_* (в LMAC не уходят: stack_args копирует 5); здесь обнулены. */
static void sysapi_filter_post(u32 type, const u8 *p, u32 w2)
{
    u32 f[2];
    memcpy_fw(f, p, 8);
    channel_est_stack_args(type, f[0], f[1], w2);
}

/* Шаблоны фильтров команд sysapi в DCCM (5 байт: слово + байт; в образе нули). */
struct sysapi_filter_tmpl {
    u32 w;                                     /* 0x00 */
    u8  b4;                                    /* 0x04 */
    u8  rsv_05[3];
};
_Static_assert(sizeof(struct sysapi_filter_tmpl) == 8, "sysapi_filter_tmpl");
FWDATA(80359c) const volatile struct sysapi_filter_tmpl sysapi_tmpl_rx_energy = { 0 };
FWDATA(8035ac) const volatile struct sysapi_filter_tmpl sysapi_tmpl_rx_pkt_phy = { 0 };
FWDATA(8035b4) const volatile struct sysapi_filter_tmpl sysapi_tmpl_phy_rx_stats = { 0 };
FWDATA(8035f0) const volatile struct sysapi_filter_tmpl sysapi_tmpl_ch_est = { 0 };

/* Фильтр из шаблона в данных (5 байт: слово + байт), затем байты 0..4 заменяются
 * аргументами — шаблон фактически не используется, кроме чтения (как vendor). */
static void sysapi_filter_build(u8 *f, const volatile struct sysapi_filter_tmpl *tmpl, u32 a0, u32 a1,
                                u32 a2, u32 a3, u32 a4)
{
    *(u32 *)f = tmpl->w;
    f[4] = tmpl->b4;
    f[0] = (u8)a0;
    f[4] = (u8)a4;
    f[1] = (u8)a1;
    f[2] = (u8)a2;
    f[3] = (u8)a3;
}

/* ---------- оценка канала (тип 6) ---------- */

/* fw_sysapi_mgr::channel_estimation_cmd_complete (0x8f1740, 96 Б): остановить запрос 6;
 * при status == 1 — BRP RAM (0xe0 Б со строки 0) в ответ; иначе ответ из нулей. */
void fw_sysapi_mgr_channel_estimation_cmd_complete(struct fw_sysapi_mgr *mgr, u32 status)
{
    u8 buf[0xe0];

    memset0_words(buf, 0xe0);
    fw_log_emit1(0x20, 0x1013118, status);
    fw_sysapi_mgr_stop_sysapi_cmd(mgr, 6);
    if (status == 1)
        hwd_phy_rx_read_and_parse_brp_ram(0, 0, buf, 0xe0);
    fw_sysapi_mgr_send_evt2host(mgr, status, buf, 0xe0, (const u32 *)mgr->ut.w);
}

/* [0x8f1844] (6 Б): колбэк LMAC — статус в mgr->status и завершение (b не используется). */
static void chan_est_done_cb(struct fw_sysapi_mgr *mgr, u32 a, const void *b)
{
    (void)b;
    mgr->status = a;
    fw_sysapi_mgr_channel_estimation_cmd_complete(mgr, a);
}

/* [0x8f184c] (62 Б): таймаут оценки канала — если запрос 6 ещё ждёт LMAC, лог и
 * LMAC-команда 0x3d {3} (отмена); затем завершение со статусом 3. */
static void chan_est_timeout(u32 a0, u32 a1)
{
    struct fw_sysapi_mgr *mgr = (struct fw_sysapi_mgr *)a0;

    (void)a1;
    mgr->timer = 0;
    if (mgr->request_type == 6 && mgr->status == 2) {
        fw_log_emit0(0x20, 0x1013168);
        field_set_0x00_8dbe88(0x3d, 3);
    }
    fw_sysapi_mgr_channel_estimation_cmd_complete(mgr, 3);
}

/* channel_estimation_cmd_start (0x8f17a0, 164 Б): ctx = {ctx0, ctx1} (vendor — пара
 * стековых аргументов). Занят — лог и ответ статусом 2 без данных в ctx. Иначе: такт
 * отладки PHY вкл., 0x885178[2:0] = 1 (результаты чтений 0x8d1c20/0x8d1b88 vendor
 * отбрасывает), колбэк 0x8f1844, таймер 0x8f184c, LMAC 0x3c {фильтр, 0}. */
void channel_estimation_cmd_start(struct fw_sysapi_mgr *mgr, const u8 *p, u32 timeout, u32 ctx0,
                                  u32 ctx1)
{
    u32 ctx[2];
    ctx[0] = ctx0;
    ctx[1] = ctx1;

    fw_log_emit0(0x20, 0x101290c);
    fw_log_emit2(0x20, 0x1012930, p[0], p[4]);
    if (fw_sysapi_mgr_start_sysapi_cmd(mgr, 6, ctx) == 0) {
        fw_log_emit0(0x20, 0x101297c);
        fw_sysapi_mgr_send_evt2host(mgr, 2, 0, 0, ctx);
        return;
    }
    (void)hwd_phy_dbg_clk_enable_get();
    (void)phy_get_885178_3bit();
    hwd_phy_dbg_clk_enable(1);
    phy_set_885178_3bit(1);
    mgr->completion_cb = chan_est_done_cb;
    channel_est_clamp_64(mgr, timeout, chan_est_timeout);
    sysapi_filter_post(0x3c, p, 0);
}

/* hw_sysapi_channel_estimation (0x8cdcdc, 132 Б): фильтр (a0..a4) из шаблона 0x8035f0,
 * запрос оценки канала; ctx0 = {u16 модуль, u16 подтип}, ctx1 — ящик ответа. */
void hw_sysapi_channel_estimation(u32 a0, u32 a1, u32 a2, u32 a3, u32 a4, u32 timeout,
                                  u32 ctx0, u32 ctx1)
{
    u8 f[8] = { 0 };

    fw_log_emit2(0x25, 0x101aa34, a0, a4);
    fw_log_emit3(0x25, 0x101aa88, (u16)ctx0, ctx0 >> 16, ctx1);
    sysapi_filter_build(f, &sysapi_tmpl_ch_est, a0, a1, a2, a3, a4);
    channel_estimation_cmd_start(&fw_sysapi_mgr, f, timeout, ctx0, ctx1);
}

/* ---------- энергия приёма ---------- */

/* hw_sysapi_get_rx_energy_data_free_run (0x8cded0, 158 Б): out[0] — RSSI ADC, out[1] —
 * RSSI Q4. RX выкл. — нули, лог, 0. ADC == 0 — out[1] = 0, лог, 1. Индекс усиления —
 * принудительный ABIF (если включён) или старт AGC 0x88312c. */
u32 hw_sysapi_get_rx_energy_data_free_run(u32 *out)
{
    if (hwd_phy_rx_is_enabled() == 0) {
        out[0] = 0;
        out[1] = 0;
        fw_log_emit0(5, 0x101a268);
        return 0;
    }
    out[0] = phy_rx_read_rssi_adc();
    if (out[0] == 0) {
        out[1] = 0;
        fw_log_emit0(0x15, 0x101a2f4);
        return 1;
    }
    u32 forced = hwd_abif_rx_table_index_force_en_get();
    u32 gain = (forced != 0) ? abif_get_rx_table_index_force_val() : phy_get_88312c_6bit();
    s32 q4 = rx_energy_calc_rssi_q4(out[0], gain, G_ZERO_DB_ROW,
                                    rf_if_gain_rssi_ofs);
    out[1] = (u32)q4;
    fw_log_emit3(0x25, 0x101a384, out[0], (u32)q4, forced);
    fw_log_emit3(0x25, 0x101a3dc, gain, G_ZERO_DB_ROW,
                 rf_if_gain_rssi_ofs);
    return 1;
}

/* Накопитель отсчётов энергии — fwsh_energy (include/fwsh.h; заполняет uc по событию LMAC). */

/* fw_sysapi_mgr::energy_statistics_complete [0x8f2c08] (184 Б): число отсчётов >= 0x15 —
 * ассерт 0x9f (без бита 12: mov_s r1,0x9f). Статистика в mgr->energy, поверх неё TSF старта
 * и последнего отсчёта; ответ 0x2c Б, стоп запроса 1, логи. */
static void energy_stats_complete(struct fw_sysapi_mgr *mgr, u32 status)
{
    if (VOL(fwsh_energy.n) >= 0x15)
        fw_sysassert_fatal(CALLER(), 0x9f);
    fw_sysapi_mgr_get_rssi_and_snr_statistics(mgr, VOL(fwsh_energy.n), 1,
                                              fwsh_energy.adc, fwsh_energy.gain,
                                              &mgr->energy);
    mgr->energy.tsf_start_hi = mgr->tsf_start[1];
    mgr->energy.tsf_start_lo = mgr->tsf_start[0];
    mgr->energy.tsf_last_lo = VOL(fwsh_energy.tsf_last[0]);
    mgr->energy.tsf_last_hi = VOL(fwsh_energy.tsf_last[1]);
    fw_sysapi_mgr_send_evt2host(mgr, status, (const void *)&mgr->energy, 0x2c,
                                (const u32 *)mgr->ut.w);
    fw_sysapi_mgr_stop_sysapi_cmd(mgr, 1);
    fw_log_emit3(0x20, 0x1012d64, status, mgr->energy.samples_num,
                 mgr->energy.tsf_last_lo - mgr->energy.tsf_start_lo);
    fw_log_emit2(0x20, 0x1012dec, mgr->energy.rssi_adc_min, mgr->energy.rssi_adc_max);
    fw_log_emit2(0x20, 0x1012e60, mgr->energy.rssi_ant_min, mgr->energy.rssi_ant_max);
    fw_log_emit2(0x20, 0x1012ed4, mgr->energy.snr_adc_min, mgr->energy.snr_adc_max);
}

/* [0x8f2d80] (6 Б): колбэк LMAC статистики энергии. */
static void energy_done_cb(struct fw_sysapi_mgr *mgr, u32 a, const void *b)
{
    (void)b;
    mgr->status = a;
    energy_stats_complete(mgr, a);
}

/* [0x8f2d88] (62 Б): таймаут статистики энергии — mgr == 0: ассерт 0x1451; запрос 1 ещё
 * ждёт LMAC — LMAC 0x29 {3} (завершение придёт ответом LMAC). */
static void energy_timeout(u32 a0, u32 a1)
{
    struct fw_sysapi_mgr *mgr = (struct fw_sysapi_mgr *)a0;

    (void)a1;
    if (mgr == 0)
        fw_sysassert_fatal(CALLER(), 0x1451);
    mgr->timer = 0;
    if (mgr->request_type == 1 && mgr->status == 2)
        field_set_0x00_8dbe88(0x29, 3);
}

/* fw_sysapi_mgr::start_energy_statistics (0x8f2cc0, 192 Б): занят — ответ из нулей
 * (0x2c Б) со статусом mgr->status в прежний ctx mgr->ut (так у vendor). Иначе
 * mgr->energy_count = count (> 0x14 — лог и 0x14), обнулить статистику и накопитель
 * [0x8572a0], колбэк/таймер, LMAC 0x28 {фильтр, count — исходный, без ограничения}. */
void fw_sysapi_mgr_start_energy_statistics(struct fw_sysapi_mgr *mgr, const u8 *p, u32 count,
                                           u32 timeout, const u32 *ctx)
{
    fw_log_emit1(0x20, 0x101250c, count);
    print_input_filter_params(mgr, p, timeout);
    if (fw_sysapi_mgr_start_sysapi_cmd(mgr, 1, ctx) == 0) {
        u8 buf[0x2c];
        memset0_words(buf, 0x2c);
        fw_log_emit2(0x20, 0x1012544, mgr->request_type, 1);
        fw_sysapi_mgr_send_evt2host(mgr, mgr->status, buf, 0x2c, (const u32 *)mgr->ut.w);
        return;
    }
    mgr->energy_count = count;
    memset0_words((void *)&mgr->energy, 0x2c);
    VOL(fwsh_energy.n) = 0;
    if (mgr->energy_count >= 0x15) {
        fw_log_emit2(0x20, 0x10125e0, count, 0x14);
        mgr->energy_count = 0x14;
    }
    mgr->completion_cb = energy_done_cb;
    channel_est_clamp_64(mgr, timeout, energy_timeout);
    sysapi_filter_post(0x28, p, count);
}

/* hw_sysapi_get_rx_packet_energy_statistics (0x8cdf70, 168 Б): фильтр (a0..a4) из
 * шаблона 0x80359c, count, timeout; ctx — {u16 модуль, u16 подтип, u32 ящик}. */
void hw_sysapi_get_rx_packet_energy_statistics(u32 a0, u32 a1, u32 a2, u32 a3, u32 a4,
                                               u32 count, u32 timeout, const u32 *ctx)
{
    u8 f[8] = { 0 };

    fw_log_emit3(0x25, 0x101a0fc, a0, a1, a2);
    fw_log_emit3(0x25, 0x101a164, a3, a4, count);
    fw_log_emit1(0x25, 0x101a1b4, timeout);
    fw_log_emit3(0x25, 0x101a1f4, *(const u16 *)ctx, *((const u16 *)ctx + 1), ctx[1]);
    sysapi_filter_build(f, &sysapi_tmpl_rx_energy, a0, a1, a2, a3, a4);
    fw_sysapi_mgr_start_energy_statistics(&fw_sysapi_mgr, f, count, timeout, ctx);
}

/* ---------- PHY-данные пакета (тип 3) ---------- */

/* get_rx_pkt_phy_data_cmd_complete (0x8f38cc, 186 Б): body — тело ответа LMAC.
 * body == 0 — лог и выход (запрос не останавливается). Статус 1: ответ 0x28 Б —
 * body[0..2]; [3] = (body[6] + (-35 - u8[0x800508] - (u8[0x800227]/2 + 5) + 17)) * 16 +
 * body[2]; [5] = индекс LUT rssi_snr_lut по body[2] (0x8f2038); [6] = body[3];
 * [7] = body[5]*209 + body[4]*52; [8] = body[7]; байты 36/37 = body8[32]/body8[34].
 * Иначе — нули. Стоп запроса 3 (неудача — ассерт 0x1453), ответ со статусом mgr->status. */
void get_rx_pkt_phy_data_cmd_complete(struct fw_sysapi_mgr *mgr, const u32 *body)
{
    u32 half = (u32)((s32)rf_if_gain_rssi_ofs >> 1) + 5u;
    u32 buf[10];

    memset0_words(buf, 0x28);
    if (body == 0) {
        fw_log_emit0(0, 0x1012aac);
        return;
    }
    if (mgr->status == 1) {
        buf[0] = body[0];
        buf[1] = body[1];
        buf[2] = body[2];
        u32 adj = (u32)-35 - G_ZERO_DB_ROW - half + 0x11u;
        buf[3] = ((body[6] + adj) << 4) + body[2];
        buf[5] = sysapi_mgr_stats_lut_find_index(mgr, body[2]);
        ((u8 *)buf)[37] = ((const u8 *)body)[34];
        buf[6] = body[3];
        buf[7] = body[5] * 209u + body[4] * 0x34u;
        buf[8] = body[7];
        ((u8 *)buf)[36] = ((const u8 *)body)[32];
    }
    if (fw_sysapi_mgr_stop_sysapi_cmd(mgr, 3) == 0)
        fw_sysassert_fatal(CALLER(), 0x1453);
    fw_sysapi_mgr_send_evt2host(mgr, mgr->status, buf, 0x28, (const u32 *)mgr->ut.w);
}

/* [0x8f3a1c] (44 Б): колбэк LMAC — mgr == 0: ассерт 0x1454; статус a, завершение с телом b. */
static void rx_pkt_done_cb(struct fw_sysapi_mgr *mgr, u32 a, const void *b)
{
    if (mgr == 0)
        fw_sysassert_fatal(CALLER(), 0x1454);
    mgr->status = a;
    get_rx_pkt_phy_data_cmd_complete(mgr, b);
}

/* [0x8f3a48] (68 Б): таймаут — запрос 3 ещё ждёт LMAC: (mgr == 0 — ассерт 0x1530; vendor
 * проверяет после чтения полей) лог, LMAC 0x2f {3}. */
static void rx_pkt_timeout(u32 a0, u32 a1)
{
    struct fw_sysapi_mgr *mgr = (struct fw_sysapi_mgr *)a0;

    (void)a1;
    mgr->timer = 0;
    if (mgr->request_type == 3 && mgr->status == 2) {
        if (mgr == 0)
            fw_sysassert_fatal(CALLER(), 0x1530);
        fw_log_emit0(0x20, 0x1013074);
        field_set_0x00_8dbe88(0x2f, 3);
    }
}

/* get_rx_pkt_phy_data_cmd_start (0x8f3988, 146 Б): ctx = {ctx0, ctx1}. Занят — ответ
 * 0x28 нулевых байт статусом 2 в ctx. Иначе колбэк/таймер, LMAC 0x2e {фильтр, 0}. */
void get_rx_pkt_phy_data_cmd_start(struct fw_sysapi_mgr *mgr, const u8 *p, u32 timeout, u32 ctx0,
                                   u32 ctx1)
{
    u32 ctx[2];
    ctx[0] = ctx0;
    ctx[1] = ctx1;

    fw_log_emit0(0x20, 0x1012710);
    print_input_filter_params(mgr, p, timeout);
    if (fw_sysapi_mgr_start_sysapi_cmd(mgr, 3, ctx) == 0) {
        u8 buf[0x28];
        memset0_words(buf, 0x28);
        fw_log_emit0(0x20, 0x1012738);
        fw_sysapi_mgr_send_evt2host(mgr, 2, buf, 0x28, ctx);
        return;
    }
    mgr->completion_cb = rx_pkt_done_cb;
    channel_est_clamp_64(mgr, timeout, rx_pkt_timeout);
    sysapi_filter_post(0x2e, p, 0);
}

/* fw_sysapi__start_rx_pkt_phy_data (0x8ce018, 72 Б): фильтр (a0..a4) из шаблона 0x8035ac. */
void fw_sysapi_start_rx_pkt_phy_data(u32 a0, u32 a1, u32 a2, u32 a3, u32 a4, u32 timeout,
                                     u32 ctx0, u32 ctx1)
{
    u8 f[8] = { 0 };

    sysapi_filter_build(f, &sysapi_tmpl_rx_pkt_phy, a0, a1, a2, a3, a4);
    get_rx_pkt_phy_data_cmd_start(&fw_sysapi_mgr, f, timeout, ctx0, ctx1);
}

/* ---------- статистика приёма PHY (тип 4) ---------- */

/* Флаг «статистика PHY идёт» (vendor [0x84e7e0 + 0x38]). */
#define PHY_RX_STATS_ON  0x84e818u

/* fw_sysapi_mgr::phy_rx_statistics_complete [0x8f72c8] (46 Б). */
static void phy_rx_stats_complete(struct fw_sysapi_mgr *mgr)
{
    fw_sysapi_send_measure_evt(mgr, &fwsh_phy.st);
    fw_sysapi_mgr_stop_sysapi_cmd(mgr, 4);
    hwd_phy_rx_statistics_clear();
    *(volatile u32 *)PHY_RX_STATS_ON = 0;
    hwd_phy_dbg_clk_enable(0);
}

/* [0x8f72f8] (6 Б): колбэк LMAC статистики PHY. */
static void phy_rx_stats_done_cb(struct fw_sysapi_mgr *mgr, u32 a, const void *b)
{
    (void)b;
    mgr->status = a;
    phy_rx_stats_complete(mgr);
}

/* [0x8f7300] (66 Б): таймаут — запрос 4 ещё ждёт LMAC: (mgr == 0 — ассерт 0x1531) лог,
 * LMAC 0x38 {3}. */
static void phy_rx_stats_timeout(u32 a0, u32 a1)
{
    struct fw_sysapi_mgr *mgr = (struct fw_sysapi_mgr *)a0;

    (void)a1;
    mgr->timer = 0;
    if (mgr->request_type == 4 && mgr->status == 2) {
        if (mgr == 0)
            fw_sysassert_fatal(CALLER(), 0x1531);
        fw_log_emit0(0x20, 0x10130ac);
        field_set_0x00_8dbe88(0x38, 3);
    }
}

/* fw_sysapi_mgr::phy_rx_statistics_cmd_start (0x8f7228, 160 Б): занят — ответ 0x8c
 * нулевых байт со статусом mgr->status в прежний ctx mgr->ut. Иначе флаг 0x84e818 = 1, такт
 * отладки PHY вкл., колбэк/таймер, LMAC 0x37 {фильтр, 0}. */
void fw_sysapi_mgr_phy_rx_statistics_cmd_start(struct fw_sysapi_mgr *mgr, const u8 *p, u32 timeout,
                                               const u32 *ctx)
{
    fw_log_emit0(0x20, 0x101277c);
    print_input_filter_params(mgr, p, timeout);
    if (fw_sysapi_mgr_start_sysapi_cmd(mgr, 4, ctx) == 0) {
        u8 buf[0x8c];
        memset0_words(buf, 0x8c);
        fw_log_emit2(0x20, 0x10127a0, mgr->request_type, 4);
        fw_sysapi_mgr_send_evt2host(mgr, mgr->status, buf, 0x8c, (const u32 *)mgr->ut.w);
        return;
    }
    *(volatile u32 *)PHY_RX_STATS_ON = 1;
    hwd_phy_dbg_clk_enable(1);
    mgr->completion_cb = phy_rx_stats_done_cb;
    channel_est_clamp_64(mgr, timeout, phy_rx_stats_timeout);
    sysapi_filter_post(0x37, p, 0);
}

/* fw_sysapi__start_phy_rx_stats (0x8ce0d4, 76 Б): фильтр (a0..a4) из шаблона 0x8035b4;
 * ctx = {ctx0, ctx1} (vendor кладёт r6/r7 в стековую область аргументов). */
void fw_sysapi_start_phy_rx_stats(u32 a0, u32 a1, u32 a2, u32 a3, u32 a4, u32 timeout,
                                  u32 ctx0, u32 ctx1)
{
    u8 f[8] = { 0 };
    u32 ctx[2];

    ctx[0] = ctx0;
    ctx[1] = ctx1;
    sysapi_filter_build(f, &sysapi_tmpl_phy_rx_stats, a0, a1, a2, a3, a4);
    fw_sysapi_mgr_phy_rx_statistics_cmd_start(&fw_sysapi_mgr, f, timeout, ctx);
}
