// SPDX-License-Identifier: AGPL-3.0-or-later
/* Мелкие функции MAC / MACQ / DMA / PCIe / XPM (RF), не попавшие в другие
 * файлы: геттеры и сеттеры регистров, помощники бит-полей, упаковка RX-дескриптора
 * MACQ, кольцо дескрипторов, TSF, конфигурация XPM RF, статистика A-MPDU (fw_sysapi).
 *
 * У каждой vendor-функции один порт: чужие функции вызываются из файлов-владельцев
 * (прототип с файлом и адресом у места вызова). */
#include "../include/types.h"
#include "../include/power.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/bitfield.h"
#include "../include/sysapi_mgr.h"
#include "../include/phy_monitor.h"
#include "../include/fwdata.h"
#include "../include/mac_cnt.h"

/* 0x8003d0 / 0x8003d4 ([gp,0x24c] / [gp,0x250]): указатели блоков счётчиков MAC (в образе
 * vendor — 0x8872c4 / 0x887744). */
FWDATA(8003d0) struct mac_rx_cnt *volatile mac_rx_cnt_blk = &mac_rx_cnt_regs;
FWDATA(8003d4) struct mac_tx_cnt *volatile mac_tx_cnt_blk = &mac_tx_cnt_regs;

/* fw_sysapi_mgr (0x805170): ядро и помощники команд. */

/* Глобальные функции этого файла (прототипы — для порядка определения). */

#define RA()  __builtin_return_address(0)      /* blink vendor для fw_sysassert_fatal */

/* ======================= power / PCIe / DMA: регистры ======================= */

/* pcie__toggle_880c50_bit2 (0x8d029c, 130 Б): бит 2 [0x880c60] = 1; бит 2 [0x880c50] =
 * !on (on — снять, 0 — поставить), ожидание бита 2 [0x880c60] (до 1000 опросов; нет —
 * «DO_WHILE_WITH_MAX_ITER OCCUR» и ассерт 0x1329 / 0x132a); в конце бит 2 [0x880c60] = 1.
 * ХРУПКО: опрос — lp 1000 (тело: ld; btst; bne на конец цикла; nop_s), перед циклом nop_s;
 * проверка после цикла — по ПОСЛЕДНЕМУ прочитанному значению (без повторного чтения).
 * Число итераций и nop сохранены — это единственная выдержка на переключение. */
void pcie_toggle_880c50_bit2(u32 on)
{
    u32 i, v = 0;
    MMIO32(CLK_SWITCH_STATUS) |= 1u << 2;
    if (on != 0)
        MMIO32(HW_RGF_USER_SPARROW_M_4) &= ~(1u << 2);
    else
        MMIO32(HW_RGF_USER_SPARROW_M_4) |= 1u << 2;
    arc_nop_s();
    for (i = 0; i < 1000; i++) {
        v = MMIO32(CLK_SWITCH_STATUS);
        if (v & (1u << 2))
            break;
        arc_nop_s();
    }
    if (!(v & (1u << 2))) {
        fw_log_emit0(0, 0x101f7a4);                   /* «DO_WHILE_WITH_MAX_ITER OCCUR» */
        fw_sysassert_fatal(RA(), on != 0 ? 0x1329 : 0x132a);
    }
    MMIO32(CLK_SWITCH_STATUS) |= 1u << 2;
}

/* pcie__set_l1_bit11 (0x8f8f50, 14 Б): *p: биты 10 и 18 — 0, бит 11 — 1. */
void pcie_set_l1_bit11(u32 *p)
{
    u32 v = *p;
    v &= ~((1u << 10) | (1u << 11) | (1u << 18));
    v |= 1u << 11;
    *p = v;
}

/* ======================= MAC: счётчики ======================= */

/* mac_rx_cnt__get_crc_total (0x8dd7ac, 10 Б): счётчики RX MAC ([gp+0x24c] = 0x8003d0):
 * +4 (CRC_ERR) + +8 (CRC_OK). */
u32 mac_rx_cnt_get_crc_total(void)
{
    struct mac_rx_cnt *p = mac_rx_cnt_blk;
    return p->crc_err + p->crc_ok;
}

/* ======================= помощники бит-полей (bf__set_field_word_fw 0x8edcb8) ===========
 * mov r10 = младший бит, r11 = ширина − 1; слово *p, соседние биты не меняются. */

/* tx_queue__bits_set32_s0_w3 (0x8ed364, 12 Б). */
void tx_queue_bits_set32_s0_w3(void *p, u32 v) { bf_set32((u32)p, 0, 3, v); }
/* tx_queue__bits_set32_s14_w3 (0x8ed3d0, 12 Б). */
void tx_queue_bits_set32_s14_w3(void *p, u32 v) { bf_set32((u32)p, 14, 3, v); }
/* tx_queue__bits_set32_s17_w4 (0x8ed418, 12 Б). */
void tx_queue_bits_set32_s17_w4(void *p, u32 v) { bf_set32((u32)p, 17, 4, v); }
/* tx_queue__bits_set32_s20_w10 (0x8ed424, 12 Б). */
void tx_queue_bits_set32_s20_w10(void *p, u32 v) { bf_set32((u32)p, 20, 10, v); }
/* rx_macq__bits_set32_s21_w5 (0x8ed43c, 12 Б). */
void rx_macq_bits_set32_s21_w5(void *p, u32 v) { bf_set32((u32)p, 21, 5, v); }
/* rx_macq__bits_set32_s26_w2 (0x8ed490, 12 Б). */
void rx_macq_bits_set32_s26_w2(void *p, u32 v) { bf_set32((u32)p, 26, 2, v); }
/* tx_queue__bits_set32_s6_w14 (0x8ed544, 12 Б). */
void tx_queue_bits_set32_s6_w14(void *p, u32 v) { bf_set32((u32)p, 6, 14, v); }
/* lmac_if__bits_set32_s6_w26 (0x8ed550, 12 Б). */
void lmac_if_bits_set32_s6_w26(void *p, u32 v) { bf_set32((u32)p, 6, 26, v); }

/* ======================= XPM (RF): регистры конфигурации ======================= */

extern const struct xpm_cfg xpm_cfg_preset0;   /* 0x801a0c, ниже */

/* 0x800528: пресеты конфигурации XPM по режиму (0 — 0x801a0c, 1 — нет). vendor таблицу не
 * пишет; не const — чтение из памяти, как у vendor. */
FWDATA(800528) const u32 *xpm_cfg_presets[2] = { (const u32 *)&xpm_cfg_preset0, 0 };

/* xpm__get_cfg_preset (0x8d336c, 20 Б): пресет idx (< 2) из xpm_cfg_presets; иначе 0. */
const u32 *xpm_get_cfg_preset(u32 idx)
{
    if (idx >= 2)
        return 0;
    return xpm_cfg_presets[idx];
}

/* xpm__read_3c8 (0x8d45c0, 18 Б): RFC 0x3c8, младшие 24 бита. */
u32 xpm_read_3c8(u32 rf)
{
    return hwd_rfc_read_rgf(rf & 0xff, 0x3c8) & 0xffffff;
}

/* xpm__write_3c8 (0x8d45d4, 12 Б). */
void xpm_write_3c8(u32 rf, u32 v)
{
    rfc_field_write(rf & 0xff, 0x3c8, v, 0);
}

/* xpm__read_cfg_350 (0x8d4640, 14 Б): RFC 0x350 + idx·4 (add2). */
u32 xpm_read_cfg_350(u32 rf, u32 idx)
{
    return hwd_rfc_read_rgf(rf & 0xff, 0x350 + idx * 4);
}

/* xpm__write_cfg_350 (0x8d4650, 14 Б). */
void xpm_write_cfg_350(u32 rf, u32 idx, u32 v)
{
    rfc_field_write(rf & 0xff, 0x350 + idx * 4, v, 0);
}

/* xpm__read_cfg_378 (0x8d4660, 14 Б): RFC 0x378 + idx·4. */
u32 xpm_read_cfg_378(u32 rf, u32 idx)
{
    return hwd_rfc_read_rgf(rf & 0xff, 0x378 + idx * 4);
}

/* xpm__wave_rd_set (0x8d4670, 14 Б): запись RFC 0x378 + idx·4 (парная к read_cfg_378). */
void xpm_wave_rd_set(u32 rf, u32 idx, u32 v)
{
    rfc_field_write(rf & 0xff, 0x378 + idx * 4, v, 0);
}

/* xpm__read_3cc (0x8d4680, 18 Б): RFC 0x3cc, младшие 24 бита. */
u32 xpm_read_3cc(u32 rf)
{
    return hwd_rfc_read_rgf(rf & 0xff, 0x3cc) & 0xffffff;
}

/* xpm__write_3cc (0x8d4694, 12 Б). */
void xpm_write_3cc(u32 rf, u32 v)
{
    rfc_field_write(rf & 0xff, 0x3cc, v, 0);
}

/* hwf_rf_xpm_cfg_get (0x8f47dc, 178 Б): конфигурация XPM RF rf → cfg: +0 время выборки
 * чтения (0x3c8), +4 — записи (0x3cc), +8 — 20 слов waveform записи (0x378..), +0x58 —
 * 10 слов waveform чтения (0x350..). Счётчики циклов vendor: 20 и 10 с декрементом до
 * проверки (brhs.d r15,1 после sub) — ровно 20 и 10 итераций. */
void hwf_rf_xpm_cfg_get(u32 rf, u32 *cfg)
{
    u32 i, v;
    for (i = 0; i < 20; i++) {
        v = xpm_read_cfg_378(rf, i);
        cfg[2 + i] = v;
        fw_log_emit2(0x20, 0x101bb3c, i, v);
        fw_log_emit2(0x20, 0x101bb70, cfg[2 + i] & 0xffff, (cfg[2 + i] >> 16) & 0x1ff);
    }
    for (i = 0; i < 10; i++) {
        v = xpm_read_cfg_350(rf, i);
        cfg[0x16 + i] = v;
        fw_log_emit2(0x20, 0x101bba4, i, v);
        fw_log_emit2(0x20, 0x101bbd8, cfg[0x16 + i] & 0xffff, (cfg[0x16 + i] >> 16) & 7);
    }
    cfg[0] = xpm_read_3c8(rf);
    cfg[1] = xpm_read_3cc(rf);
    fw_log_emit2(0x20, 0x101baec, cfg[0], cfg[1]);
}

/* hwf_rf_xpm_cfg_set (0x8f4890, 138 Б): обратное hwf_rf_xpm_cfg_get — waveform записи
 * (20), чтения (10), затем времена выборки 0x3c8 / 0x3cc; журнал каждого слова. */
void hwf_rf_xpm_cfg_set(u32 rf, const u32 *cfg)
{
    u32 i;
    for (i = 0; i < 20; i++) {
        fw_log_emit2(0x20, 0x101ba84, i, cfg[2 + i]);
        xpm_wave_rd_set(rf, i, cfg[2 + i]);
    }
    for (i = 0; i < 10; i++) {
        fw_log_emit2(0x20, 0x101bab8, i, cfg[0x16 + i]);
        xpm_write_cfg_350(rf, i, cfg[0x16 + i]);
    }
    fw_log_emit2(0x20, 0x101baec, cfg[0], cfg[1]);
    xpm_write_3c8(rf, cfg[0]);
    xpm_write_3cc(rf, cfg[1]);
}

/* xpm__enter_cfg_step (0x8f4960, 114 Б; hwf_rf_xpm_enter_cfg_mode_check_inputs): rf
 * проверен (rf__check_rf_id ≠ 1 — 3) и mode < 2 — 1; иначе журнал «cfg_mode out of valid
 * range [0,1]», при flag — ассерт 0x155f, 3. Нет RF (0 от проверки) — тоже 3. */
u32 xpm_enter_cfg_step(u32 rf, u32 mode, u32 flag)
{
    if (rf_check_rf_id(rf, 0x101bc0c, flag) != 1)
        return 3;
    if (mode < 2)
        return 1;
    fw_log_emit_str2(0, 0x101b680, 0x101bc0c, 0x101bc34);   /* «%s : Value <%s>=» */
    fw_log_emit3(0, 0x101b6a0, mode, 0, 1);         /* «[NNL]%d is out valid range [%d,%d]» */
    if (flag != 0)
        fw_sysassert_fatal(RA(), 0x155f);
    return 3;
}

/* hwf_rf_xpm_enter_cfg_mode (0x8f491c, 68 Б): проверка входа (с ассертом), пресет mode
 * (нет — журнал, 0) → hwf_rf_xpm_cfg_set; 1 — успех. */
u32 hwf_rf_xpm_enter_cfg_mode(u32 rf, u32 mode)
{
    const u32 *preset;
    if (xpm_enter_cfg_step(rf, mode, 1) != 1)
        return 0;
    preset = xpm_get_cfg_preset(mode);
    if (preset == 0) {
        fw_log_emit1(0, 0x101bc40, mode);
        return 0;
    }
    hwf_rf_xpm_cfg_set(rf, preset);
    return 1;
}

/* ======================= статистика A-MPDU (fw_sysapi_mgr, объект 0x805170) ============
 * Объект запроса — struct fw_sysapi_mgr (include/sysapi_mgr.h): запрос 5, MCS фильтра —
 * ampdu_mcs, база счётчиков (снимок на старте) — mac_base. */

/* mac_tx_cnt__get_u64_14 (0x8dd7a4, 8 Б): счётчик TX MAC u64 ([gp+0x250] = 0x8003d4, +0x14). */
u64 mac_tx_cnt_get_u64_14(void)
{
    struct mac_tx_cnt *p = mac_tx_cnt_blk;
    return (u64)p->cnt64_lo | ((u64)p->cnt64_hi << 32);
}

/* mac_rx_cnt__get_u64_bc (0x8dd798, 12 Б): счётчик RX MAC u64 ([gp+0x24c] = 0x8003d0,
 * +0xbc/+0xc0). */
u64 mac_rx_cnt_get_u64_bc(void)
{
    struct mac_rx_cnt *p = mac_rx_cnt_blk;
    return (u64)p->cnt64_lo | ((u64)p->cnt64_hi << 32);
}

/* Истечение таймера статистики A-MPDU [0x8f63c4, 96 Б; строка «mac_ampdu_statistics_
 * timeout_cb: !! TIMEOUT !!halt cmd» — у этой функции]: o == 0 — ассерт 0x145f (дальше).
 * Таймер погашен; запрос 5 в состоянии 2 — журнал, счётчики хосту, состояние 1, останов
 * запроса, флаг phy_monitor.dump_off = 0. */
static void mac_ampdu_stats_timer_expired(u32 a0, u32 a1)
{
    struct fw_sysapi_mgr *o = (struct fw_sysapi_mgr *)a0;

    (void)a1;
    if (o == 0)
        fw_sysassert_fatal(RA(), 0x145f);
    o->timer = 0;
    if (o->request_type != 5 || o->status != 2)
        return;
    fw_log_emit0(0x20, 0x10130e0);
    stats_log_counters(o);
    o->status = 1;
    fw_sysapi_mgr_stop_sysapi_cmd(o, 5);
    *(volatile u32 *)&phy_monitor.dump_off = 0;
}

/* mac_ampdu_statistics_timeout_cb (0x8f6370, 84 Б; имя справки по строке соседней
 * функции — по коду это снимок базы счётчиков на старте): база — fw_sysapi_mgr.mac_base
 * (vendor — по абсолютному адресу 0x805170 + 0x94.., аргумент o — только MCS o->ampdu_mcs). */
void mac_ampdu_statistics_timeout_cb(struct fw_sysapi_mgr *o)
{
    struct sysapi_mac_stats_base *b = &fw_sysapi_mgr.mac_base;
    u64 v;
    v = mac_tx_cnt_get_u64_14();
    b->tx_lo = (u32)v;
    b->tx_hi = (u32)(v >> 32);
    v = mac_rx_cnt_get_u64_bc();
    b->rx_lo = (u32)v;
    b->rx_hi = (u32)(v >> 32);
    b->tx_ok = mac_tx_cnt_get_ok();
    b->tx_fail = mac_tx_cnt_get_fail();
    b->rx_crc_total = mac_rx_cnt_get_crc_total();
    b->rx_crc_err = mac_rx_stats_crc_err();
    b->by_id = stats_read_counter_by_id(o->ampdu_mcs, (u32 *)&b->by_id_first);
}

/* fw_sysapi_mgr::mac_ampdu_statistics_cmd_start (0x8f6270, 136 Б): статистика A-MPDU
 * (sysapi 5) на timeout мкс. Журнал фильтра; запрос не принят — ответ хосту с нулевым
 * буфером 0x28 Б (vendor обнуляет его сам). Принят — MCS фильтра в o->ampdu_mcs, флаг
 * phy_monitor.dump_off = 1, колбэка ответа нет, таймер (0x8f63c4) и снимок базы счётчиков. */
void fw_sysapi_mgr_mac_ampdu_statistics_cmd_start(struct fw_sysapi_mgr *o, const u8 *filter,
                                                  u32 timeout, const u32 *req)
{
    u32 b[10];
    fw_log_emit0(0x20, 0x1012840);
    print_input_filter_params(o, filter, timeout);
    if (fw_sysapi_mgr_start_sysapi_cmd(o, 5, req) == 0) {
        memset0_words(b, 0x28);
        fw_log_emit2(0x20, 0x1012868, o->request_type, 5);
        fw_sysapi_mgr_send_evt2host(o, o->status, b, 0x28, (const u32 *)o->ut.w);
        return;
    }
    o->ampdu_mcs = filter[3];
    *(volatile u32 *)&phy_monitor.dump_off = 1;
    o->completion_cb = 0;
    channel_est_clamp_64(o, timeout, mac_ampdu_stats_timer_expired);
    mac_ampdu_statistics_timeout_cb(o);
}

/* ======================= пресет конфигурации XPM (fw_data) ======================= */

/* Конфигурация XPM RF (0x80 Б; раскладка hwf_rf_xpm_cfg_get / hwf_rf_xpm_cfg_set). */
struct xpm_cfg {
    u32 t_3c8;                                 /* 0x00: время выборки (RFC 0x3c8) */
    u32 t_3cc;                                 /* 0x04: время выборки (RFC 0x3cc) */
    u32 wave_378[20];                          /* 0x08: waveform (RFC 0x378..) */
    u32 wave_350[10];                          /* 0x58: waveform (RFC 0x350..) */
};
_Static_assert(sizeof(struct xpm_cfg) == 0x80, "xpm_cfg");

/* 0x801a0c: пресет XPM 0 (xpm_get_cfg_preset(0) — указатель в таблице 0x800528; пресета 1
 * нет — 0). */
FWDATA(801a0c) const struct xpm_cfg xpm_cfg_preset0 = {
    .t_3c8 = 0x228,
    .t_3cc = 0xffffff,
    .wave_378 = {                              /* отсчёты формы (0x88010b, 0x88000c, 0x880018 — значения, не адреса) */
        0x1880006, 0x88010b, 0x80006, 0x88010b, 0xa80006, 0xa00006,
        0xa80006, 0x88000c, 0x9800f2, 0x9a02d7, 0x9203ca, 0x9a01e5,
        0x9802d7, 0x880018, 0x1880006, 0x1880001, 0x1880001, 0x1880001,
        0x1880001, 0x1880001,
    },
    .wave_350 = {
        0x60006, 0x200ff, 0x6, 0x200ff, 0x30030,
        0x2001e, 0x60006, 0x60001, 0x60001, 0x60001,
    },
};
