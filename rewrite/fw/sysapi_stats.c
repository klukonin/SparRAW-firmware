// SPDX-License-Identifier: AGPL-3.0-or-later
/* fw_sysapi / hw_sysapi: статистика и измерения (RSSI/SNR, энергия, PLCP, A-MPDU,
 * PHY RX, сброс статистики, оценка канала, данные PHY принятого пакета) и модуль
 * юнит-тестов 10 UT_MODULE_HW_FLOWS_SYSAPI (WMI 0x900, ответ 0x1900).
 *
 * Менеджер fw_sysapi_mgr — объект 0x805170 (struct fw_sysapi_mgr, include/sysapi_mgr.h;
 * конструктор — ctors.c, 0x8c196c): номер запроса, контекст ответа UT, таймер, статус,
 * TSF, колбэк ответа ucode m_completion_cb (зовёт fw_sysapi_mgr::complete_pending_request
 * 0x8f1c50, lmac_evt.c: cb(mgr, статус, тело)) и данные команд (энергия, PLCP, LUT SNR,
 * база счётчиков A-MPDU).
 * Контекст UT (ctx) — 8 Б {u16 module, u16 subtype, u32 obj} на стеке обработчика
 * 0x8faf34; vendor передаёт его то указателем, то по значению в r6:r7 (повторено).
 *
 * Шаблоны параметров vendor (0x80359c, 0x8035bc, 0x8035c4, 0x8035dc, 0x8035f8 в
 * fw_data) — нули (6.2/build/fw_data.bin), поэтому структуры просто обнуляются.
 *
 * Здесь — ядро менеджера (start/stop_sysapi_cmd, send_evt2host, send_measure_evt,
 * get_rssi_and_snr_statistics), сброс статистики, PLCP и обработчик UT. Цепочки команд
 * энергии, оценки канала, данных PHY пакета и статистики PHY RX — phy_ext.c, A-MPDU —
 * mac_ext.c, аргументы UT и счётчики MAC — misc_ext_sysapi.c, регистры RFC — rf_sector.c.
 * Колбэки vendor (адреса без записи в SYMS) — с адресом в [ ] (tools/fw_ptrmap.py). */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/ut.h"
#include "../include/sysapi_mgr.h"
#include "../include/fwdata.h"
#include "../include/rf_obj.h"
#include "../include/radio_mgr.h"
#include "../include/conn.h"

/* 0x801170 / 0x801230: LUT RSSI ADC → SNR ADC (fw_sysapi_mgr.rssi_snr_lut, ctor_obj_805170;
 * lut__find_index): возрастающие ключи и значения SNR. */
FWDATA(801170) const s32 rssi_snr_lut_keys[RSSI_SNR_LUT_N] = {
    3, 4, 5, 7, 8, 10, 13, 16, 19, 23, 28, 34,
    41, 48, 57, 66, 76, 87, 99, 112, 125, 138, 152, 167,
    181, 196, 211, 227, 242, 258, 273, 289, 305, 321, 337, 352,
    368, 384, 400, 416, 432, 448, 464, 480, 496, 512, 528, 544,
};
FWDATA(801230) const s32 rssi_snr_lut_vals[RSSI_SNR_LUT_N] = {
    -13, -12, -11, -10, -9, -8, -7, -6, -5, -4, -3, -2,
    -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
    11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22,
    23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34,
};

/* 0x8012f0: PHY-скорость MCS 0..12, Мбит/с (сводка RX: s[0x80] = s[0x30]·rate / s[0x34]). */
FWDATA(8012f0) const u16 mcs_phy_rate_mbps[13] = {
    0x0000, 0x0181, 0x0302, 0x03c2, 0x0483, 0x04e3, 0x0604, 0x0785,
    0x0906, 0x09c6, 0x0c08, 0x0f0a, 0x120c,
};



/* (0x805170) экземпляр менеджера; в vendor fw_data — нули, LUT ставит конструктор
 * 0x8c196c (ctors.c). */
FWDATA(805170) struct fw_sysapi_mgr fw_sysapi_mgr = { 0 };

static inline void *caller(void) { return __builtin_return_address(0); }

/* fw_sysapi__zero_and_fill (0x8f7ffc, 44 Б): [+0] = 0, +4..+0xb, +0xc, +0x10,
 * +0x18..+0x34 — нули; +0x14 (байт параметра A-MPDU) не трогается. */
static void fw_sysapi_zero_and_fill(struct fw_sysapi_mgr *mgr)
{
    mgr->request_type = 0;                         /* st.ab r14,[r0,4] — слот bl.d */
    memset0_words((void *)&mgr->ut, 8);
    mgr->timeout = 0;
    mgr->timer = 0;
    mgr->active = 0;
    mgr->stopped = 0;
    mgr->status = 0;
    mgr->tsf_start[0] = 0;
    mgr->tsf_start[1] = 0;
    mgr->tsf_stop[0] = 0;
    mgr->tsf_stop[1] = 0;
    mgr->completion_cb = 0;
}

/* ===================== ядро fw_sysapi_mgr ===================== */

/* fw_sysapi_mgr::start_sysapi_cmd (0x8f9a20, 86 Б): занять менеджер под команду id с
 * контекстом ответа ctx {слово module|subtype, obj}. Занят — журнал, 0. Иначе сброс
 * полей, [+0] = id, активна, статус 2 (ждём), TSF старта в +0x24; 1. */
u32 fw_sysapi_mgr_start_sysapi_cmd(struct fw_sysapi_mgr *mgr, u32 id, const u32 *ctx)
{
    if (bf_req_is_claimable(mgr, 0) != 0) {
        fw_log_emit0(0x10, 0x1012444);
        return 0;
    }
    fw_sysapi_zero_and_fill(mgr);
    mgr->request_type = id;
    mgr->active = 1;
    mgr->stopped = 0;
    mgr->ut.w[1] = ctx[1];
    mgr->ut.w[0] = ctx[0];
    mgr->status = 2;
    mac_read_tsf64(0, (u32 *)mgr->tsf_start, 0);
    return 1;
}

/* fw_sysapi_mgr::stop_sysapi_cmd (0x8f9bd0, 74 Б): команда id не активна или ответа
 * ещё нет ([+0x20] == 2) — журнал, 0. Иначе снять таймер, «остановлена», TSF
 * останова в +0x2c; 1. */
u32 fw_sysapi_mgr_stop_sysapi_cmd(struct fw_sysapi_mgr *mgr, u32 id)
{
    if (bf_req_is_claimable(mgr, id) == 0 || mgr->status == 2) {
        fw_log_emit1(0x10, 0x1012a64, id);
        return 0;
    }
    if (mgr->timer != 0) {
        u_schd_cancel(mgr->timer);
        mgr->timer = 0;
    }
    mgr->stopped = 1;
    mac_read_tsf64(0, (u32 *)mgr->tsf_stop, 0);
    return 1;
}

/* fw_sysapi_mgr::send_evt2host (0x8f8948, 90 Б): ответ UT {module, subtype, status,
 * data[len]} (0x1900, len + 8). Буфер — из пула ящика ctx[1] с заголовком из ctx,
 * отправка — в ящик mgr->ut.host_if. */
void fw_sysapi_mgr_send_evt2host(struct fw_sysapi_mgr *mgr, u32 status, const void *data,
                                 u32 len, const u32 *ctx)
{
    volatile struct ut_rsp *buf;

    fw_log_emit3(0x25, 0x10124a0, mgr->ut.module, mgr->ut.subtype,
                 (u32)mgr->ut.host_if);
    buf = ut_begin_response((struct wmi_mbox *)ctx[1], *(const u16 *)ctx, *((const u16 *)ctx + 1));  /* ctx[1] — слово контекста UT */
    memset0_words((void *)&buf->status, 0xec);
    buf->status = status;
    memcpy_fw((void *)buf->data, data, len);
    wmi_evt_send_words(mgr->ut.host_if, buf, (u16)(len + 8));
}

/* fw_sysapi__send_measure_evt (0x8f8af8, 212 Б): итог статистики PHY RX (src —
 * 0x8576ac, блок ucode) → ответ 0x8c Б: два блока по 0x40 (пары счётчиков u64,
 * нормализованные к 32 битам), +0x80 = [+0x30]·lut16[src+0x78] / [+0x34] (u64,
 * беззнаково; при [+0x34] == 0 не считается), +0x84/+0x88 = src +0x7c/+0x80. */
void fw_sysapi_send_measure_evt(struct fw_sysapi_mgr *mgr, const volatile struct phy_rx_stats *st)
{
    const u64 *acc = (const u64 *)st->acc;
    u32 s[0x8c / 4];

    memset0_words(s, 0x8c);
    hwd_apply_table_entry(mgr, s, &acc[0], &acc[1], &acc[2], &acc[3]);
    hwd_apply_table_entry_b(mgr, s, st->cnt[6], st->cnt[5], st->cnt[0],
                            st->cnt[4], st->cnt[1], st->cnt[2]);
    hwd_apply_table_entry(mgr, s + 0x40 / 4, &acc[4], &acc[5], &acc[6], &acc[7]);
    hwd_apply_table_entry_b(mgr, s + 0x40 / 4, st->cnt[13], st->cnt[12],
                            st->cnt[7], st->cnt[11], st->cnt[8], st->cnt[9]);
    if (s[0x34 / 4] != 0) {
        u32 k = *(const volatile u16 *)&mcs_phy_rate_mbps[st->max_mcs];   /* ldh.as */
        u64 prod = (u64)s[0x30 / 4] * k;                                  /* fw_mul64 0x8c045c */
        s[0x80 / 4] = (u32)(prod / s[0x34 / 4]); /* 0x8c047c: u64 / u64 */
    }
    s[0x84 / 4] = st->rx_sector;
    s[0x88 / 4] = st->rx_gain;
    fw_sysapi_mgr_send_evt2host(mgr, mgr->status, s, 0x8c, (const u32 *)mgr->ut.w);
}

/* ===================== сброс статистики (7) ===================== */

/* [0x8f3538]: ответ 0xe Б и останов команды 7. */
static void flush_stats_done(struct fw_sysapi_mgr *mgr, const void *body)
{
    fw_sysapi_mgr_send_evt2host(mgr, mgr->status, body, 0xe,
                                (const u32 *)mgr->ut.w);
    fw_sysapi_mgr_stop_sysapi_cmd(mgr, 7);
}

/* [0x8f3558]: колбэк ответа ucode (+0x34) — статус в +0x20. */
static void flush_stats_cb(struct fw_sysapi_mgr *mgr, u32 status, const void *body)
{
    mgr->status = status;
    flush_stats_done(mgr, body);
}

/* fw_sysapi_mgr::get_flush_statistics_cmd_start (0x8f34fc, 60 Б): команда 7 → LMAC 0x48
 * (4 Б). Тело vendor не заполняет (у vendor — остаток слота пула), у нас нули (mem_pool_alloc_locked обнуляет). */
void fw_sysapi_mgr_get_flush_statistics_cmd_start(struct fw_sysapi_mgr *mgr, const u32 *ctx)
{
    if (fw_sysapi_mgr_start_sysapi_cmd(mgr, 7, ctx) == 0) {
        fw_log_emit2(0x20, 0x10129c0, mgr->request_type, 7);
        return;
    }
    mgr->completion_cb = flush_stats_cb;
    lmac_if_post_cmd(lmac_cmd_pool_alloc(), 0x48, 4, 0);
}

/* ut_sysapi__flush_stats_start (0x8ebbbc, 12 Б). */
void ut_sysapi_flush_stats_start(const u32 *ctx)
{
    fw_sysapi_mgr_get_flush_statistics_cmd_start(&fw_sysapi_mgr, ctx);
}

/* ===================== аргументы UT (8) ===================== */

/* sysapi_mgr__apply_ut_args (0x8cdd60, 26 Б): тело UT с +4 → команда 8. */
void sysapi_mgr_apply_ut_args(const struct ut_cmd *c, const u32 *ctx, u32 len)
{
    sched_apply_entry(&fw_sysapi_mgr, c->arg, ctx, len);
}

/* ===================== PLCP-заголовок (2) ===================== */

/* [0x8f7344]: ответ — 0x20 Б тела (копия в +0x68), останов 2, журнал полей. */
static void plcp_header_done(struct fw_sysapi_mgr *mgr, u32 status, const void *body)
{
    const volatile struct lmac_evt_plcp_hdr *h = body;

    memcpy_fw(mgr->plcp_rsp, body, 0x20);
    fw_sysapi_mgr_send_evt2host(mgr, status, mgr->plcp_rsp, 0x20,
                                (const u32 *)mgr->ut.w);
    fw_sysapi_mgr_stop_sysapi_cmd(mgr, 2);
    fw_log_emit3(0x20, 0x1012f48, status, h->mcs, h->length);
    fw_log_emit3(0x20, 0x1012fac, h->train_length, h->packet_type, h->add_ppdu);
    fw_log_emit1(0x20, 0x1013024, h->aggregation);
}

/* [0x8f7448]: колбэк ответа ucode. */
static void plcp_header_cb(struct fw_sysapi_mgr *mgr, u32 status, const void *body)
{
    mgr->status = status;
    plcp_header_done(mgr, status, body);
}

/* [0x8f7450]: тайм-аут — ответа нет: ucode LMAC 0x2b {3} (останов сбора; ответ придёт
 * через колбэк). mgr == 0 — ассерт 0x145e, дальше как у vendor. */
static void plcp_header_timeout(u32 a0, u32 a1)
{
    struct fw_sysapi_mgr *mgr = (struct fw_sysapi_mgr *)a0;

    (void)a1;
    if (mgr == 0)
        fw_sysassert_fatal(caller(), 0x145e);
    mgr->timer = 0;
    if (mgr->request_type == 2 && mgr->status == 2)
        field_set_0x00_8dbe88(0x2b, 3);
}

/* fw_sysapi_mgr::start_plcp_header (0x8f73b0, 152 Б): команда 2; занят — ответ из
 * нулей (0x20 Б) со статусом [+0x20]. Иначе LMAC 0x2a (5 Б параметров). */
void fw_sysapi_mgr_start_plcp_header(struct fw_sysapi_mgr *mgr, const u8 *prm, u32 timeout,
                                     const u32 *ctx)
{
    u32 t[8];

    fw_log_emit0(0x20, 0x1012658);
    print_input_filter_params(mgr, prm, timeout);
    if (fw_sysapi_mgr_start_sysapi_cmd(mgr, 2, ctx) == 0) {
        memset0_words(t, 0x20);
        fw_log_emit2(0x20, 0x1012678, mgr->request_type, 2);
        fw_sysapi_mgr_send_evt2host(mgr, mgr->status, t, 0x20, (const u32 *)mgr->ut.w);
        return;
    }
    memset0_words(mgr->plcp_rsp, 0x20);
    mgr->completion_cb = plcp_header_cb;
    channel_est_clamp_64(mgr, timeout, plcp_header_timeout);
    memcpy_fw(t, prm, 8);
    channel_est_stack_args(0x2a, t[0], t[1], 0);
}

/* hw_sysapi_plcp_header (0x8ce120, 136 Б): 5 байт параметров (шаблон 0x8035a4 — нули;
 * байты 5..7 у vendor — неинициализированный стек, у нас нули) → start_plcp_header. */
void hw_sysapi_plcp_header(u32 a0, u32 a1, u32 a2, u32 a3, u32 a4, u32 timeout,
                           const u32 *ctx)
{
    u8 prm[8] = { 0 };

    fw_log_emit3(0x25, 0x101a41c, a0, a1, a2);
    fw_log_emit2(0x25, 0x101a468, a3, timeout);
    fw_log_emit3(0x25, 0x101a1f4, *(const u16 *)ctx, *((const u16 *)ctx + 1), ctx[1]);
    prm[0] = (u8)a0;
    prm[1] = (u8)a1;
    prm[2] = (u8)a2;
    prm[3] = (u8)a3;
    prm[4] = (u8)a4;
    fw_sysapi_mgr_start_plcp_header(&fw_sysapi_mgr, prm, timeout, ctx);
}

/* ===================== статистика A-MPDU (5) ===================== */

/* fw_sysapi__start_ampdu_stats (0x8ce088, 76 Б): 5 байт параметров (шаблон 0x8035bc —
 * нули; байты 5..7 у vendor — неинициализированный стек, у нас нули), контекст UT по
 * значению (r6:r7). */
void fw_sysapi_start_ampdu_stats(u32 a0, u32 a1, u32 a2, u32 a3, u32 a4, u32 timeout,
                                 u32 ctx0, u32 ctx1)
{
    u8 prm[8] = { 0 };
    u32 ctx[2];

    ctx[0] = ctx0;
    ctx[1] = ctx1;
    prm[0] = (u8)a0;
    prm[1] = (u8)a1;
    prm[2] = (u8)a2;
    prm[3] = (u8)a3;
    prm[4] = (u8)a4;
    fw_sysapi_mgr_mac_ampdu_statistics_cmd_start(&fw_sysapi_mgr, prm, timeout, ctx);
}

/* ===================== RSSI/SNR (энергия, 1) ===================== */

/* fw_sysapi_mgr::get_rssi_and_snr_statistics (0x8f3780, 332 Б): n замеров (из массивов
 * rssi/idx, если оба заданы, иначе — чтение АЦП: locked → 0x8d2208, иначе 0x8d21f8;
 * индекс — 0x88306c) → min/max RSSI ADC, индекса LUT rssi_snr_lut (snr_adc) и RSSI Q4
 * (rssi_ant), со знаком; samples_num = n. */
void fw_sysapi_mgr_get_rssi_and_snr_statistics(struct fw_sysapi_mgr *mgr, u32 n, u32 locked,
                                               const u32 *rssi, const u32 *idx,
                                               struct sysapi_energy_stats *out)
{
    u32 i, left;

    out->rssi_adc_min = 0xffffff;
    out->rssi_adc_max = -0xffffff;
    out->snr_adc_min = 0xffffff;
    out->snr_adc_max = -0xffffff;
    out->rssi_ant_min = 0xffffff;
    out->rssi_ant_max = -0xffffff;
    out->samples_num = n;
    for (i = 0, left = n; left >= 1; left--, i++) {
        s32 r, q, l;
        u32 x;

        if (rssi != 0 && idx != 0) {
            r = (s32)rssi[i];
            x = idx[i];
        } else {
            r = (s32)(locked != 0 ? phy_rx_read_rssi_adc_locked() : phy_rx_read_rssi_adc());
            x = phy_get_88306c_6bit();
        }
        q = (s32)rx_energy_calc_rssi_q4((u32)r, x, calib_zero_db.row8, rf_if_gain_rssi_ofs);
        if (r > out->rssi_adc_max)
            out->rssi_adc_max = r;
        if (r < out->rssi_adc_min)
            out->rssi_adc_min = r;
        l = (s32)sysapi_mgr_stats_lut_find_index(mgr, (u32)r);
        if (l > out->snr_adc_max)
            out->snr_adc_max = l;
        if (l < out->snr_adc_min)
            out->snr_adc_min = l;
        if (q < out->rssi_ant_min)
            out->rssi_ant_min = q;
        if (q > out->rssi_ant_max)
            out->rssi_ant_max = q;
        fw_log_emit3(0x20, 0x1012ae8, i, (u32)r, (u32)q);
        fw_log_emit3(0x20, 0x1012b40, (u32)l, x, calib_zero_db.row8);   /* g_zero_db_row */
        fw_log_emit1(0x20, 0x1012b7c, rf_if_gain_rssi_ofs);
    }
    fw_log_emit3(0x20, 0x1012ba4, out->samples_num, out->rssi_adc_min, out->rssi_adc_max);
    fw_log_emit2(0x20, 0x1012c08, out->rssi_ant_min, out->rssi_ant_max);
    fw_log_emit3(0x20, 0x1012c34, out->snr_adc_min, out->snr_adc_max, locked);
}

/* ===================== MCS, beamforming, частоты ===================== */

/* hw_sysapi_force_mcs (0x8cdde8, 92 Б): a (со знаком) < 8 и бит c маски 0x1dde
 * (bbit1 — c по модулю 32) → LMAC 0x30 {a, b, c}, 1; иначе журнал, 0. */
u32 hw_sysapi_force_mcs(u32 a, u32 b, u32 c)
{
    fw_log_emit3(0x25, 0x101a49c, a, b, c);
    if ((s32)a >= (s32)SPARRAW_MAX_STA) {
        fw_log_emit1(5, 0x101a4d8, a);
        return 0;
    }
    if (!((0x1ddeu >> (c & 31u)) & 1u)) {
        fw_log_emit1(5, 0x101a4f4, c);
        return 0;
    }
    lmac_if_send_cmd_0x30(a, b, c);
    return 1;
}

/* hw_sysapi_get_beamforming_statistics (0x8cde44, 138 Б): статистика BF соединения cid
 * (байт тела +4) → ответ UT (0x34 Б): статус 1 и 0x2c Б (шаблон 0x8035c4 — нули);
 * соединения нет — статус 0, нули. */
void hw_sysapi_get_beamforming_statistics(struct wmi_mbox *mb, const struct ut_cmd *cmd)
{
    const volatile struct ut_cmd *c = cmd;
    struct ut_bf_stats st;
    u32 cid;
    struct conn *conn;
    volatile struct ut_rsp *buf;

    fw_log_emit0(0x20, 0x101a96c);
    cid = c->arg8[0];
    memset0_words(&st, 0x2c);
    buf = ut_begin_response(mb, 0xa, c->subtype_id);
    buf->status = 0;
    conn = conn_mgr_by_cid(cid);
    if (conn == 0) {
        fw_log_emit1(0x10, 0x101a998, cid);
    } else {
        buf->status = 1;
        /* снимок lm_if.snap — копия отчёта BF (struct lmac_evt_bf_done); add_0c_ret 0x8cc364 */
        link_stats_pack_conn_entry((const struct lmac_evt_bf_done *)&conn->lm.snap, &st);
    }
    memcpy_fw((void *)buf->data, &st, 0x2c);
    wmi_evt_send_words(mb, buf, 0x34);
    fw_log_emit0(0x20, 0x101a9dc);
}

/* [0x8ce458]: колбэк захвата радио — переключение канала с параметрами p =
 * sysapi_freq_ratio_args (0x806690), затем освобождение радио. */
static void set_freq_ratio_radio_cb(struct rm_req *radio, u32 p)
{
    const volatile u32 *a = (const volatile u32 *)p;

    fw_log_emit1(0x25, 0x101a560, (u32)radio);
    hwm_analog_channel_switch(a[0], a[1], a[2]);
    radio_mgr_call_method_10(radio);
}

/* hw_sysapi__set_freq_ratio (0x8ce484, 100 Б): i — не текущий канал → сразу регистры
 * channel__check_range (i, v1, v2); текущий — через захват радио (0x806690 = {i, v1,
 * v2}, колбэк — переключение канала). */
void hw_sysapi_set_freq_ratio(u32 i, u32 v1, u32 v2)
{
    u32 h;

    if (i != radio_get_channel(&rf_obj)) {
        channel_check_range(i, v1, v2);
        return;
    }
    fw_log_emit0(0x25, 0x101a5a8);
    sysapi_freq_ratio_args[0] = i;
    sysapi_freq_ratio_args[1] = v1;
    sysapi_freq_ratio_args[2] = v2;
    h = (u32)radio_mgr_request(set_freq_ratio_radio_cb, (u32)sysapi_freq_ratio_args, 0, 0xffff, 0);
    fw_log_emit1(0x25, 0x101a5d8, h);
}

/* ===================== регистры RFC (UT 11/12) ===================== */

/* 0x80669c: запрос доступа к RGF RFC (UT 10/11, 10/12; в образе нули). */
FWDATA(80669c) struct rfc_rgf_req rfc_rgf_req = { 0 };

/* ===================== модуль UT 10 ===================== */

/* 0x803600: таблица переходов vendor UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler (0x8faf34): ldh.as.x, 73 записей, цель = 0x8faf88 + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(803600) __attribute__((aligned(2))) const u16 ut_module_hw_flows_sysapi_cmd_handler_jt[73] = {
    0x002, 0x01f, 0x02f, 0x03d, 0x053, 0x063, 0x06f, 0x08b, 0x0cb, 0x0a0,
    0x0db, 0x000, 0x1d7, 0x1d7, 0x1d7, 0x1d7, 0x1d7, 0x1d7, 0x138, 0x147,
    0x157, 0x1d7, 0x1d7, 0x19b, 0x1d7, 0x1b0, 0x1d7, 0x1d7, 0x1d7, 0x1d7,
    0x1d7, 0x178, 0x1d7, 0x1d7, 0x1d7, 0x1d7, 0x1d7, 0x15c, 0x1ba, 0x1d7,
    0x1d7, 0x1d7, 0x1d7, 0x1d7, 0x1d7, 0x1d7, 0x1d7, 0x1d7, 0x1d7, 0x1d7,
    0x1d7, 0x1d7, 0x1d7, 0x1d7, 0x1d7, 0x1d7, 0x1d7, 0x1d7, 0x1d7, 0x1d7,
    0x1d7, 0x1d7, 0x1d7, 0x1d7, 0x1d7, 0x1d7, 0x1d7, 0x1d7, 0x1d7, 0x1d7,
    0x1d7, 0x1d7, 0x1d3,
};

/* UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler (0x8faf34, до 0x8fb348; SYMS — 102 Б, неверно).
 * obj — ящик, payload — тело {u16 module, u16 subtype, слова параметров с +4}.
 * Контекст ответа ctx на стеке = {module | subtype << 16, obj} (шаблон 0x8035f8 — нули).
 * Подкоманды (таблица 0x803600: 73 записи ldh.as.x, subtype − 1, цель = 0x8faf88 +
 * 2·запись; JUMPTABLES-fw.txt): 1 энергия free-run, 2 статистика энергии пакетов,
 * 3 PLCP, 4 данные PHY пакета, 5 LMAC 0x2c, 6 force MCS, 7 LMAC 0x12, 8 RX omni-сектор,
 * 9 статистика PHY RX, 10 частота, 11/12 чтение/запись регистров RFC, 19 A-MPDU,
 * 20 уровни SDP, 21 BF-статистика, 24 оценка канала, 26 сброс статистики,
 * 32 температура (temp_first_meas_done + temp_first_meas), 38 ассерт по таймеру, 39 аргументы UT,
 * 73 дамп регистров RFC 0..0x5f8 в журнал; прочие — COMMAND_NOT_SUPPORTED. */
void ut_module_hw_flows_sysapi_cmd_handler(struct wmi_mbox *mb, const struct ut_cmd *cmd)
{
    const volatile struct ut_cmd *c = cmd;
    u32 ctx[2];
    u32 sub, r, i;
    volatile struct ut_rsp *buf;

    fw_log_emit1(0x20, 0x101ae34, c->subtype_id);
    ctx[0] = (u32)c->module_id | ((u32)c->subtype_id << 16);
    ctx[1] = (u32)mb;                                  /* слово контекста (vendor r7) */
    sub = c->subtype_id;
    switch (sub) {
    case 1: {                                          /* 0x8faf8c */
        u32 t[2];

        buf = ut_begin_response(mb, 0xa, 1);
        memset0_words((void *)&buf->status, 0xec);
        memset0_words(t, 8);
        r = hw_sysapi_get_rx_energy_data_free_run(t);
        buf->data[1] = t[1];
        buf->status = r;
        buf->data[0] = t[0];
        wmi_evt_send_words(mb, buf, 0x10);
        break;
    }
    case 2:                                            /* 0x8fafc6 */
        hw_sysapi_get_rx_packet_energy_statistics((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8], (u32)c->arg8[12], (u32)c->arg8[16],
                                                     c->arg[5], c->arg[6], ctx);
        break;
    case 3:                                            /* 0x8fafe6 */
        hw_sysapi_plcp_header((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8], (u32)c->arg8[12], (u32)c->arg8[16], c->arg[5], ctx);
        break;
    case 4:                                            /* 0x8fb002 */
        fw_log_emit0(0x20, 0x101ae70);
        fw_sysapi_start_rx_pkt_phy_data((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8], (u32)c->arg8[12], (u32)c->arg8[16],
                                           c->arg[5], ctx[0], ctx[1]);
        break;
    /* case 5 (0x8fb02e, смещения TOF → ucode LMAC 0x2c) — только SparRAW-pro; здесь default. */
    case 6:                                            /* 0x8fb04e: без memset (vendor) */
        buf = ut_begin_response(mb, 0xa, 6);
        buf->status = hw_sysapi_force_mcs((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8]);
        wmi_evt_send_words(mb, buf, 8);
        break;
    case 7:                                            /* 0x8fb066 */
        buf = ut_begin_response(mb, 0xa, 7);
        memset0_words((void *)&buf->status, 0xec);
        r = 0;
        if ((s32)(u32)c->arg8[0] >= 8) {
            fw_log_emit1(0, 0x101aeb0, (u32)c->arg8[0]);
        } else {
            field_set_0x00_8dbc94((u32)c->arg8[0]); /* thunk 0x8ce408 */
            r = 1;
        }
        buf->status = r;
        wmi_evt_send_words(mb, buf, 8);
        break;
    case 8:                                            /* 0x8fb09e */
        buf = ut_begin_response(mb, 0xa, 8);
        memset0_words((void *)&buf->status, 0xec);
        buf->status = hw_sysapi_rx_omni_sector_set(c->arg[0]);
        wmi_evt_send_words(mb, buf, 8);
        break;
    case 9:                                            /* 0x8fb11e */
        fw_sysapi_start_phy_rx_stats((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8], (u32)c->arg8[12], (u32)c->arg8[16], c->arg[5],
                                        ctx[0], (u32)mb);
        break;
    case 10: {                                         /* 0x8fb0c8 */
        u32 n = (u32)c->arg8[0];

        buf = ut_begin_response(mb, 0xa, 0xa);
        memset0_words((void *)&buf->status, 0xec);
        r = 0;
        if (n == 0 || n >= 5) {
            fw_log_emit1(0, 0x101aef4, n);
        } else {
            fw_log_emit3(0, 0x101af40, n, c->arg[1], c->arg[2]);
            hw_sysapi_set_freq_ratio(n - 1, c->arg[1], c->arg[2]);
            r = 1;
        }
        buf->status = r;
        wmi_evt_send_words(mb, buf, 8);
        break;
    }
    case 11:                                           /* 0x8fb13e: чтение */
    case 12: {                                         /* 0x8faf88: запись */
        volatile struct rfc_rgf_req *q = &rfc_rgf_req;   /* vendor: st по порядку (были W32) */
        u32 rd = (sub == 11) ? 1u : 0u;
        u32 len;

        if (rd)
            fw_log_emit0(0x20, 0x101af94);
        fw_log_emit0(0x20, 0x101afc8);
        buf = ut_begin_response(mb, 0xa, sub);
        q->host_if = mb;
        q->rsp = (struct ut_rsp *)buf;
        q->rf_mask = (u32)c->arg8[0];
        q->count = (c->arg[0] & 0xff00u) >> 8;
        q->nres = 0;
        q->read = rd;
        fw_log_emit2(0x20, 0x101b000, (u32)c->arg8[0], (c->arg[0] & 0xff00u) >> 8);
        memcpy_fw(rfc_rgf_req.regs, (const void *)&c->arg[1], 0x5c);   /* тело с +8 */
        memset0_words(rfc_rgf_req.out, 0x5c);
        len = rd ? 0x64u : 8u;
        r = hw_sysapi_rfc_read_write_rgf(&rfc_rgf_req);
        if (r != 5) {                                  /* 5 — ответ из колбэка радио */
            buf->status = r;
            if (rd)
                memcpy_fw((void *)buf->data, rfc_rgf_req.out, 0x5c);
            wmi_evt_send_words(mb, buf, (u16)len);
        }
        fw_log_emit0(0x20, 0x101b034);
        break;
    }
    case 19:                                           /* 0x8fb1f8 */
        fw_sysapi_start_ampdu_stats((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8], (u32)c->arg8[12], (u32)c->arg8[16], c->arg[5],
                                    ctx[0], (u32)mb);
        break;
    case 20:                                           /* 0x8fb216 */
        fw_log_emit3(0x20, 0x101b070, c->arg[0], c->arg[1], c->arg[2]);
        hw_cfg_set_8004fc_and_levels((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8]);
        break;
    case 21:                                           /* 0x8fb236 */
        hw_sysapi_get_beamforming_statistics(mb, cmd);
        break;
    case 24:                                           /* 0x8fb2be */
        fw_log_emit0(0x20, 0x101b1a4);
        hw_sysapi_channel_estimation((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8], (u32)c->arg8[12], (u32)c->arg8[16], c->arg[5],
                                        ctx[0], ctx[1]);
        break;
    case 26:                                           /* 0x8fb2e8 */
        fw_log_emit0(0x20, 0x101b1e0);
        ut_sysapi_flush_stats_start(ctx);
        break;
    case 32:                                           /* 0x8fb278 */
        fw_log_emit0(0x20, 0x101b110);
        buf = ut_begin_response(mb, 0xa, sub);
        buf->status = temp_first_meas_done; /* [gp,0x208] */
        memcpy_fw((void *)buf->data, (const void *)temp_first_meas, 0x24);
        fw_log_emit1(0x20, 0x101b154, 0x2c);
        wmi_evt_send_words(mb, buf, 0x2c);
        break;
    case 38: {                                         /* 0x8fb240 */
        u32 ms = c->arg16[0];

        if (sysapi_hw_flows_log_timer != 0) {                      /* [gp,0x1d4]: уже запланирован */
            fw_log_emit0(0x20, 0x101b0d0);
            break;
        }
        if (ms == 0) {
            ut_module_hw_flows_log_101aa08(0, 0);
            break;
        }
        sysapi_hw_flows_log_timer = u_schd_schedule(ut_module_hw_flows_log_101aa08, ms, 0, 0, ms * 1000u,
                                        0, 0);
        break;
    }
    case 39:                                           /* 0x8fb2fc */
        sysapi_mgr_apply_ut_args(cmd, ctx, 0x28);
        break;
    case 73:                                           /* 0x8fb32e */
        for (i = 0; i < 0x600; i += 8) {
            u32 a = hwd_rfc_read_rgf(0, i);
            u32 b = hwd_rfc_read_rgf(0, i + 4);

            fw_log_emit3(0x25, 0x101b218, i, a, b);
        }
        break;
    default:                                           /* 0x8fb336 */
        wmi_evt_send_command_not_supported(mb, 0x900, sub, c->module_id);
        break;
    }
}
