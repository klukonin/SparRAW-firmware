// SPDX-License-Identifier: AGPL-3.0-or-later
/* Обработчики WMI-команд хоста: станции, статистика, связь, версия/статус, безопасность.
 * Сильные порты вместо слабых заглушек fw/wmi_handlers_todo.c (прототипы —
 * include/wmi_handlers.h, таблица — docs/WMI-DISPATCH.md). Порт по дизасму 6.2, адреса и
 * размеры — у каждой функции.
 *
 * Буферы событий из пула (mem_pool__alloc_locked / host_if__send_pair) vendor местами
 * заполняет не целиком — хвосты/резервные байты уходят хосту с содержимым прошлых событий.
 * У нас элемент пула обнуляет сам mem_pool_alloc_locked (fw/pool.c, единое правило);
 * у сборщиков отмечено, какие байты у vendor — остаток слота пула.
 *
 * Переменные fw_data (gp = 0x800184):
 *   [gp+200]  0x80024c — байт-счётчик WMI_NOTIFY_REQ (0..59);
 *   [gp+191]  0x800243 — байт «тип RF» для WMI_GET_RF_STATUS;
 *   [gp+0x278] 0x8003fc — задержка таймеров установки ключа (ld.as [gp,158]);
 *   0x8000a4 — температура BB (м°C, служба температуры). */
#include "../include/fwsh.h"
#include "../include/sta_max.h"
#include "../include/calib.h"
#include "../include/types.h"
#include "../include/rf_kill.h"
#include "../include/sysapi_mgr.h"
#include "../include/mid.h"
#include "../include/hw.h"
#include "../include/wmi_handlers.h"
#include "../include/mbox.h"
#include "../include/rf_obj.h"
#include "../include/conn.h"
#include "../include/link_sm.h"
#include "../include/link_loss.h"
#include "../include/sys_cfg.h"
#include "../include/fwdata.h"



#define G_NOTIFY_CNT    wmi_notify_req_count     /* [gp+200] */
#define G_RF_TYPE       rf_connected_mask     /* [gp+191] */
#define G_KEY_TMR_DELAY sta_key_timer_delay     /* ld.as [gp,158] */

/* MAC из тела команды в виде двух слов для журнала (vendor собирает побайтно через
 * ldb/asl/or — тело может быть не выровнено): lo32 = mac[0..3], hi16 = mac[4..5]. */
static u32 mac_lo32(const u8 *m)
{
    return (u32)m[0] | ((u32)m[1] << 8) | ((u32)m[2] << 16) | ((u32)m[3] << 24);
}
static u32 mac_hi16(const u8 *m)
{
    return (u32)m[4] | ((u32)m[5] << 8);
}

/* ======================= статистика станции (NOTIFY_REQ) ======================= */

/* 0x802fa8: таблица переходов vendor link_stats__mcs_to_rate_mbps (0x8ddd50): ldb.x, 12 записей, цель = 0x8ddd68 + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(802fa8) __attribute__((aligned(1))) const u8 link_stats_mcs_to_rate_mbps_jt[12] = {
    0x00, 0x04, 0x07, 0x0a, 0x23, 0x0d, 0x10, 0x13, 0x23, 0x17, 0x1b, 0x1f,
};

/* link_stats__mcs_to_rate_mbps (0x8ddd50, ~110 Б): PHY-скорость MCS 1..12 (Мбит/с ×1);
 * таблица переходов ldb.x 0x802fa8 (fw_data, база 0x8ddd68, цель = база + 2·запись):
 * 00 04 07 0a 23 0d 10 13 23 17 1b 1f — у MCS 5 и 9 запись 0x23 → ассерт 0x125c, ответ 0;
 * вне 1..12 — тот же ассерт. */
static u32 link_stats_mcs_to_rate_mbps(u32 mcs)
{
    switch (mcs) {
    case 1:  return 385;
    case 2:  return 770;
    case 3:  return 962;
    case 4:  return 1155;
    case 6:  return 1540;
    case 7:  return 1925;
    case 8:  return 2310;
    case 10: return 3080;
    case 11: return 3850;
    case 12: return 4620;
    default:
        fw_sysassert_fatal(__builtin_return_address(0), 0x125c);
        return 0;
    }
}

/* link_stats__calc_throughput_mbps (0x8c5554, 64 Б): пропускная способность =
 * (u8)(всего − ошибок) · скорость(mcs) / всего; 0 при mcs ∉ [1, 12], mcs 5/9 или всего < 1
 * (сравнения знаковые; оба счётчика — ldb). */
static u32 link_stats_calc_throughput_mbps(u32 total, u32 bad, u32 mcs)
{
    if ((s32)mcs < 1 || (s32)mcs >= 13 || mcs == 5 || mcs == 9 || (s32)total < 1)
        return 0;
    return fw_divmod_unsigned((u8)(total - bad) * link_stats_mcs_to_rate_mbps(mcs), total);
}

/* link_stats__fill_sta_entry (0x8ca554, 148 Б): тело WMI_NOTIFY_REQ_DONE_EVENT (0x2c Б)
 * из lm_if соединения:
 *   +0 статус снимка BF; +4/+8 TSF (0x886eb8 / 0x886ebc); +0x26 range = 0;
 *   статус 0 или 2 — нули, секторы 0xff; иначе +0xc rssi = snap.rssi − 72 (байт),
 *   +0x10 tx_tpt (mcs, счётчики mcs_total[mcs] / mcs_bad[mcs]),
 *   +0x14/+0x18 слова +0x58/+0x64 записи lm_sm (link_stats__get_sta_word58/64,
 *   0x8ccf64/0x8ccb50 — цепочки переходов +0x10+0x2c+0x1c / +0x28), +0x1c mcs,
 *   +0x1e..+0x24 секторы снимка; +0x28 sqi = bf_avg соединения. */
/* Сигнал станции, дБм (SparRAW): мощность принятых кадров станции — среднее uc (fwsh_rssi: RSSI АЦП + 16·строка AGC,
 * её кадры, её RX-сектор) через rx_energy_calc_rssi_q4 с калибровкой (calib_zero_db.row8, rf_if_gain_rssi_ofs),
 * округление к ближайшему. vendor отдавал «SNR связи − 72» (snap.rssi — SNR BRP/SLS, не мощность); он — запасной,
 * пока отсчётов нет. Абсолютная точность — по калибровке silent RSSI (пока значения образа). */
static s8 link_stats_rssi_dbm(struct lm_if *lm)
{
    u32 cid = lm->conn->cid;
    if (cid < SPARRAW_MAX_STA && fwsh_rssi.cnt[cid] != 0) {
        s32 raw = fwsh_rssi.q4x16[cid] / 16;
        s32 q4 = rx_energy_calc_rssi_q4((u32)raw, 0, calib_zero_db.row8, rf_if_gain_rssi_ofs);
        return (s8)((q4 + 8) >> 4);
    }
    return (s8)(lm->snap.rssi - 72);
}

static void link_stats_fill_sta_entry(struct lm_if *lm, struct wmi_notify_req_done_event *ev)
{
    /* volatile — как прежние W()/H(): порядок и ширина записей vendor */
    volatile struct wmi_notify_req_done_event *e = ev;
    u32 st;
    e->status = lm->snap.status;
    e->tsf[1] = MMIO32(HW_MAC_TSF_HI);
    e->tsf[0] = MMIO32(HW_MAC_TIMING_INDIRECT_REG_5);
    e->range = 0;
    st = lm->snap.status;
    if (st == 0 || st == 2) {
        ev->rssi = 0;
        e->tx_tpt = 0;
        e->tx_goodput = 0;
        e->rx_goodput = 0;
        e->bf_mcs = 0;
        e->my_rx_sector = 0xff;
        e->my_tx_sector = 0xff;
        e->other_rx_sector = 0xff;
        e->other_tx_sector = 0xff;
    } else {
        u32 mcs = lm->mcs;
        ev->rssi = link_stats_rssi_dbm(lm);
        e->tx_tpt = link_stats_calc_throughput_mbps(lm->mcs_total[mcs], lm->mcs_bad[mcs], mcs);
        e->tx_goodput = lm->lm_sm->msm.stats.tx_goodput;
        e->rx_goodput = lm->lm_sm->msm.stats.rx_goodput;
        e->bf_mcs = (u16)lm->mcs;
        e->my_rx_sector = (u16)lm->snap.sector[0];
        e->my_tx_sector = (u16)lm->snap.sector[1];
        e->other_rx_sector = (u16)lm->snap.sector[2];
        e->other_tx_sector = (u16)lm->snap.sector[3];
    }
    ev->sqi = lm->conn->bf_avg;
}

static void lm_if_notify_timer_expired(u32 a0, u32 unused);

/* l2mgr__arm_notify_timer (0x8e48a4, 44 Б): периодическая статистика включена
 * (notify_en) и таймера нет — завести его на notify_period. */
static void l2mgr_arm_notify_timer(struct lm_if *lm)
{
    if (lm->notify_en != 0 && lm->notify_timer == 0)
        lm->notify_timer = u_schd_schedule(lm_if_notify_timer_expired, (u32)lm, 0, 0,
                                           lm->notify_period, 0, 0);
}

/* Колбэк таймера статистики (0x8e0a20, 86 Б; vendor передаёт смещение 0x20a20):
 * снять отметку таймера, WMI_NOTIFY_REQ_DONE_EVENT (0x1863, 0x2c Б) через evt2sw
 * с mid — номером записи mid соединения, перезавести при ненулевом периоде. */
static void lm_if_notify_timer_expired(u32 a0, u32 unused)
{
    struct lm_if *lm = (struct lm_if *)a0;
    struct wmi_notify_req_done_event *e;
    (void)unused;
    lm->notify_timer = 0;
    e = host_if_send_pair();
    /* Байты 0xd..0xf и 0x29..0x2b (резерв) у vendor — остаток слота пула (0x8e0a2a: send_pair
     * → сразу fill_sta_entry); у нас нули (mem_pool_alloc_locked обнуляет). */
    link_stats_fill_sta_entry(lm, e);
    fw_log_emit0(0x2b, 0x10143cc);
    low_sme_send_evt2sw(e, 0x1863, sizeof(*e), ((volatile struct mid *)lm->conn->mid)->id, 0, 0, 0);
    if (lm->notify_period != 0)
        l2mgr_arm_notify_timer(lm);
}

/* lm_if__notify_req_start (0x8e0a78, 8 Б; NAMES-EXTRA «rx_mgmt_prs__alloc_ei» — неверно):
 * период notify_period = interval, notify_en = 1, переход в l2mgr__arm_notify_timer. */
static void lm_if_notify_req_start(struct lm_if *lm, u32 interval)
{
    lm->notify_period = interval;
    lm->notify_en = 1;
    l2mgr_arm_notify_timer(lm);
}

/* wmi__bump_cmd_counter (0x8dd4b8, 110 Б): WMI_NOTIFY_REQ_CMDID {cid u8, …,
 * interval_usec u32 @+4}. Счётчик [gp+200] по модулю 60. Нет соединения — нулевое событие (у vendor ничего:
 * хост ждал таймаута). interval = 0 — сразу событие 0x1863 (0x2c Б,
 * mid 0) через ящик obj; иначе — периодическая статистика по таймеру, сейчас без ответа.
 * ХРУПКО: u_schd_schedule ассертит при задержке < 0x11 — interval 1..16 от хоста
 * останавливает ядро (у vendor так же, 0x8e0c6a). */
void wmi_notify_req(struct wmi_mbox *mb, const struct wmi_notify_req_cmd *cmd)
{
    struct conn *conn;
    struct lm_if *lm;
    u32 interval;
    u8 c = (u8)(G_NOTIFY_CNT + 1);
    G_NOTIFY_CNT = c;
    if (c == 0x3c)
        G_NOTIFY_CNT = 0;
    conn = conn_mgr_by_cid(cmd->cid);
    if (conn == 0) {
        /* исправлено (vendor): нет соединения — ответа не было, хост ждал таймаута (wmi_call, 100 мс на каждый CID
         * при обходе станций). Нулевое событие: статус BF 0, драйвер такие ответы пропускает. Периодическую
         * статистику (interval ≠ 0) для несуществующего соединения не заводим. */
        if (cmd->interval_usec == 0) {
            struct wmi_notify_req_done_event *e = mem_pool_alloc_locked(&mb->mb);
            if (e != 0)
                wmi_evt_post(mb, e, 0, 0x1863, sizeof(*e), 0, 0, 0);
        }
        return;
    }
    interval = cmd->interval_usec;
    lm = &conn->lm;                                 /* add3 r13,r0,0xe */
    if (interval != 0 && interval < 0x11)
        interval = 0x11;                            /* vendor: 1..16 → ассерт 0x1068 u_schd_schedule (останов fw) */
    if (interval != 0) {
        lm_if_notify_req_start(lm, interval);
        return;
    }
    {
        struct wmi_notify_req_done_event *e = mem_pool_alloc_locked(&mb->mb);
        /* Резерв 0xd..0xf и 0x29..0x2b у vendor — остаток слота пула (0x8dd4ea: alloc →
         * fill_sta_entry); у нас нули (mem_pool_alloc_locked обнуляет). */
        link_stats_fill_sta_entry(lm, e);
        wmi_evt_post(mb, e, 0, 0x1863, sizeof(*e), 0, 0, 0);
    }
}

/* ======================= статус / список станций ======================= */

/* host_if__get_status_hal (0x8cccbc, 344 Б): WMI_GET_STATUS → 0x1864 (64 Б):
 * +0 is_associated, +4 cid, +8 bssid, +0xe channel, +0x10 network_type, +0x14 ssid_len,
 * +0x18 ssid, +0x38 rf_status (oob__mode_flags 0..3), +0x3c is_secured.
 * Нет MID — ассерт 0x1040; vendor идёт дальше с нулевым указателем (ассерт останавливает
 * ядро, продолжение — только после возобновления из отладчика; повторяем как есть). */
void host_if_get_status_hal(struct wmi_mbox *mb, const void *cmd, u32 mid)
{
    struct wmi_get_status_done_event *p;
    volatile struct wmi_get_status_done_event *vp;   /* прежние W(): слова — volatile */
    struct mid *m;
    u32 f;
    struct conn *conn;
    (void)cmd;
    fw_log_emit0(0x25, 0x1006568);
    p = mem_pool_alloc_locked(&mb->mb);
    vp = p;
    memset0_words(p, sizeof(*p));
    m = mid_list_by_mid_fw(mid);
    if (m == 0)
        fw_sysassert_fatal(__builtin_return_address(0), 0x1040);
    /* vendor: ld_s [m+0xa] — невыровненное слово (mac[0..3]), как есть */
    fw_log_emit2(0x2b, 0x1006580, ((volatile struct mid *)m)->mac_h[2],
                 *(const volatile u32 *)((volatile struct mid *)m)->mac);
    conn = mid_list_find_by_kind(m, 1);
    if (conn != 0) {
        struct mid_bss *e = &m->bss;                /* add3 r15,r14,0x9 */
        vp->is_associated = 1;
        p->cid = conn->cid;
        p->channel = ((volatile struct mid_bss *)e)->channel;
        p->network_type = (u8)((volatile struct mid *)m)->network_type;
        mid_copy_bssid(e, p->bssid);
        vp->ssid_len = mid_copy_ssid(e, p->ssid);
        vp->is_secured = conn_sec_mode_not_1(conn);
    } else {
        vp->is_associated = 0;
    }
    f = oob_mode_flags(&rf_mgmt_sm);                   /* oob__mode_flags_default (0x8ccaf0) */
    if (f <= 3)
        vp->rf_status = f;
    else
        fw_sysassert_fatal(__builtin_return_address(0), 0x1041);
    fw_log_emit1(0x25, 0x10065a0, vp->is_associated);
    fw_log_emit1(0x25, 0x10065b4, p->cid);
    fw_log_emit3(0x25, 0x10065c0, p->bssid[0], p->bssid[1], p->bssid[2]);
    fw_log_emit1(0x25, 0x10065d4, p->channel);
    fw_log_emit1(0x25, 0x10065e4, p->network_type);
    fw_log_emit1(0x25, 0x10065f8, vp->ssid_len);
    fw_log_emit1(0x25, 0x1006608, vp->rf_status);
    wmi_evt_post(mb, p, 0, 0x1864, sizeof(*p), mid, 0, 0);
}

/* wmi_get_assoc_list (0x8ec68c, 150 Б): WMI_GET_ASSOC_LIST → 0x1a06 (68 Б): до 8 записей
 * {mac[6], aid = (u8)ldw [conn+0xc], 0} — соединения cid 0..7 в состоянии [conn+0xf0] = 2;
 * число — байт +0x40 (add3 r17,r16,0x8). */
void wmi_get_assoc_list(struct wmi_mbox *mb, u32 mid)
{
    struct wmi_get_assoc_list_res_event *p = mem_pool_alloc_locked(&mb->mb);
    u32 cid;
    /* vendor обнуляет 0x40 Б из 0x44 (0x8ec6a2: r1 = 0x40) и пишет только счётчик +0x40 —
     * резерв +0x41..+0x43 у vendor — остаток слота пула; у нас нули (mem_pool_alloc_locked обнуляет). */
    p->count = 0;
    for (cid = 0; cid < SPARRAW_MAX_STA; cid++) {
        struct conn *conn = conn_mgr_by_cid(cid);
        if (conn != 0 && conn->mlme.sm.state == 2) {
            u32 n = p->count;
            struct wmi_assoc_sta_info *e = &p->assoc_sta_list[n];   /* add3 r15,r16,r18 */
            memcpy_fw(e->mac, conn->peer, 6);
            e->omni_index_address = (u8)conn->rx_sector;
            p->count = (u8)(n + 1);
        }
    }
    fw_log_emit0(0x20, 0x1006914);
    wmi_evt_post(mb, p, 0, 0x1a06, sizeof(*p), mid, 0, 0);
}

/* wmi__post_pct_stats_evt (0x8fb598, 82 Б): WMI_GET_CCA_INDICATIONS → 0x1a07 (8 Б):
 * {0, [0x80426e], [0x804274], [0x804275], [0x80427c]}. Результат mid_list__by_mid vendor
 * не использует (зов оставлен). */
void wmi_get_cca_indications(struct wmi_mbox *mb, u32 mid)
{
    struct wmi_get_cca_indications_event *p = mem_pool_alloc_locked(&mb->mb);
    const volatile struct cca_pct_stats *cca = &cca_pct_stats;   /* чтения volatile (ldb), как прежде */
    /* Байты 5..7 у vendor — остаток слота пула; у нас нули (mem_pool_alloc_locked обнуляет). */
    (void)mid_list_by_mid_fw(mid);
    p->cca_ed_percent = cca->pct2;
    p->cca_ed_avg_percent = cca->avg2;
    p->nav_percent = cca->pct1;
    p->status = 0;
    p->nav_avg_percent = cca->avg1;
    wmi_evt_post(mb, p, 0, 0x1a07, sizeof(*p), mid, 0, 0);
}

/* ======================= NEW_STA / DEL_STA ======================= */

/* l2_mgr::wmi_cmd_handler_del_sta (0x8ec184, 124 Б): WMI_DEL_STA {mac[6], reason u16}.
 * L2 не активен ([0x803c28] = 0) или станции нет — WMI_DISCONNECT_EVENT (1, 2);
 * иначе — незавершённая операция 5 и событие 0xd автомату MLME соединения.
 * obj vendor не читает. */
void l2mgr_del_sta(const struct wmi_disconnect_sta_cmd *cmd, u32 mid, struct wmi_mbox *mb)
{
    struct mid *m;
    struct conn *conn;
    (void)mb;
    fw_log_emit3(0x2b, 0x100e4d0, cmd->disconnect_reason, cmd->dst_mac16[2],
                 (u32)cmd->dst_mac16[0] | ((u32)cmd->dst_mac16[1] << 16));
    if (dashboard.cfg.ap_sme_offload_mode == 0) {
        fw_log_emit0(0xb, 0x100e514);
    } else {
        l2mgr_pending_op_set(5);
        m = mid_list_by_mid_fw(mid);
        conn = mid_list_find_by(m, cmd->dst_mac);
        if (conn != 0) {
            mlme_sm_event(&conn->mlme, 0xd, (u32)cmd, 0, 0);
            return;
        }
        fw_log_emit0(0x1b, 0x100e538);
    }
    l2mgr_send_disconnect_evt(cmd->dst_mac, 1, 2, mid);
}

/* l2_mgr::wmi_cmd_handler_new_sta (0x8ec2b8, 146 Б): WMI_NEW_STA {mac[6], …}. L2 не
 * активен или станции нет в MID — WMI_DISCONNECT_EVENT (1, 6); иначе событие 0xb
 * автомату MLME соединения (add3 r0,r14,0x1e = conn + 0xf0). obj vendor не читает. */
void l2mgr_new_sta(const struct wmi_new_sta_cmd *cmd, u32 mid, struct wmi_mbox *mb)
{
    struct mid *m;
    struct conn *conn;
    (void)mb;
    fw_log_emit2(0x2b, 0x100e428, mac_hi16(cmd->dst_mac), mac_lo32(cmd->dst_mac));
    if (dashboard.cfg.ap_sme_offload_mode == 0) {
        fw_log_emit0(0xb, 0x100e464);
    } else {
        m = mid_list_by_mid_fw(mid);
        conn = mid_list_find_by(m, cmd->dst_mac);
        if (conn != 0) {
            fw_log_emit0(0x2b, 0x100e488);
            mlme_sm_event(&conn->mlme, 0xb, (u32)cmd, 0, 0);
            return;
        }
        fw_log_emit0(0x2b, 0x100e4b4);
    }
    l2mgr_send_disconnect_evt(cmd->dst_mac, 1, 6, mid);
}

/* ======================= параметры поддержания линка ======================= */

/* link_maintain_cfg__copy (0x8cc170, 42 Б; копия static-порта l2mgr.c): набор idx < 4
 * (ll_cfg_presets[idx], 0x801518) в dst; idx ≥ 4 или dst = 0 — 0. */
static u32 lm_cfg_copy_preset(u32 idx, void *dst)
{
    if (idx >= 4 || dst == 0)
        return 0;
    memcpy_fw(dst, &ll_cfg_presets[idx], 0x24);
    return 1;
}

/* link_stats__copy_entry (0x8cc368, 40 Б): параметры cid < 8 (ll_ctx.cfg[cid],
 * add3_s r0,r0,r0 = 9·(4·cid)) в dst; иначе 1. */
static u32 lm_cfg_read(u32 cid, void *dst)
{
    if (cid >= SPARRAW_MAX_STA)
        return 1;
    memcpy_fw(dst, &ll_ctx.cfg[cid], 0x24);
    return 0;
}

/* 0x8e105c (70 Б): журнал набора параметров поддержания линка. */
static void lm_cfg_log(const u32 *c)
{
    fw_log_emit3(0x2b, 0x100c07c, c[0], c[7], c[8]);
    fw_log_emit3(0x2b, 0x100c108, c[1], c[2], c[3]);
    fw_log_emit3(0x2b, 0x100c174, c[4], c[5], c[6]);
}

/* 0x8e67d0 (202 Б): записать параметры поддержания линка. cid = 0xffffffff — все 8, иначе
 * cid < 8 (≥ 8 — журнал, 1). type = 4 — параметры из команды, иначе набор type < 4
 * (≥ 5 — журнал, 1). Для каждого cid с соединением в состоянии 2 мониторинг потери линка
 * останавливается до записи и запускается после. Возврат 0. */
static u32 lm_cfg_write(u32 type, u32 cid, const u8 *cfg)
{
    u32 buf[0x24 / 4];
    u32 last, n;
    fw_log_emit2(0x2b, 0x100c1ec, type, cid);
    if (cid != 0xffffffffu && cid >= SPARRAW_MAX_STA) {
        fw_log_emit1(0xb, 0x100c228, cid);
        return 1;
    }
    if (type != 4) {
        if (lm_cfg_copy_preset(type, buf) == 0) {
            fw_log_emit1(0xb, 0x100c280, type);
            return 1;
        }
        cfg = (const u8 *)buf;
    }
    lm_cfg_log((const u32 *)cfg);
    if (cid == 0xffffffffu) {
        cid = 0;
        last = SPARRAW_MAX_STA - 1;               /* все cid */
    } else {
        last = cid;
    }
    if (last < cid)
        return 0;
    n = last - cid + 1;
    do {
        struct conn *conn = conn_mgr_by_cid(cid);
        u32 active = (conn != 0 && conn->mlme.sm.state == 2);
        if (active)
            lm_if_stop_link_loss_monitoring(&conn->lm);   /* 0x8e7fb4 → lm_if conn+0x70 */
        memcpy_fw(&ll_ctx.cfg[cid], cfg, sizeof(ll_ctx.cfg[0]));
        if (active)
            conn_mgr_start_link_loss_monitoring(conn);
        cid++;
    } while (--n != 0);
    return 0;
}

/* wmi_link_maintain_cfg_read (0x8ec7b0, 70 Б): {cid u32} → 0x1843 (0x2c Б, evt2sw, mid 0):
 * {cid, статус, параметры 0x24 Б}. */
void wmi_link_maintain_cfg_read(const struct wmi_link_maintain_cfg_read_cmd *cmd)
{
    struct wmi_link_maintain_cfg_read_done_event *p = host_if_send_pair();
    volatile struct wmi_link_maintain_cfg_read_done_event *vp = p;
    u32 st;
    /* При cid ≥ 8 vendor параметры не пишет — +8..+0x2b у vendor — остаток слота пула; у нас
     * нули (mem_pool_alloc_locked обнуляет). */
    st = lm_cfg_read(cmd->cid, p->lm_cfg);
    vp->status = st;
    vp->cid = cmd->cid;
    fw_log_emit2(0x2b, 0x100b824, st, cmd->cid);
    low_sme_send_evt2sw(p, 0x1843, sizeof(*p), 0, 0, 0, 0);
}

/* wmi_link_maintain_cfg_write (0x8ec7f8, 72 Б): {type u32, cid u32, параметры @+8} →
 * 0x1842 (8 Б, evt2sw, mid 0): {cid, статус}. */
void wmi_link_maintain_cfg_write(const struct wmi_link_maintain_cfg_write_cmd *cmd)
{
    volatile struct wmi_link_maintain_cfg_write_done_event *p = host_if_send_pair();
    u32 st = lm_cfg_write(cmd->cfg_type, cmd->cid, (const u8 *)cmd->lm_cfg);
    p->status = st;
    p->cid = cmd->cid;
    fw_log_emit2(0x2b, 0x100b7d4, st, cmd->cid);
    low_sme_send_evt2sw((void *)p, 0x1842, sizeof(*p), 0, 0, 0, 0);
}

/* ======================= SSID / MAC / версия ======================= */

/* wmi_get_ssid (0x8ec264, 84 Б): → 0x1828 (36 Б): {ssid_len u32, ssid[32]}.
 * Vendor передаёт в событии mid = 0 (r5 = r2 = 0), а не mid команды — как есть. */
void wmi_get_ssid(u32 mid, struct wmi_mbox *mb)
{
    struct wmi_set_ssid_cmd *p = mem_pool_alloc_locked(&mb->mb);   /* WMI_GET_SSID_EVENT — та же раскладка */
    struct mid *m;
    /* Хвост ssid после ssid_len у vendor — остаток слота пула; у нас нули (mem_pool_alloc_locked обнуляет). */
    m = mid_list_by_mid_fw(mid);
    ((volatile struct wmi_set_ssid_cmd *)p)->ssid_len = mid_copy_ssid(&m->bss, p->ssid);
    fw_log_emit1(0x2b, 0x100dc0c, mid);
    wmi_evt_post(mb, p, 0, 0x1828, sizeof(*p), 0, 0, 0);
}

/* wmi_mac_addr_req (0x8ec724, 138 Б): WMI_MAC_ADDR_REQ → 0x9003 (12 Б):
 * {mac[6] = свой MAC, auth (+0x2c), group_crypto (+0x30) (байты), wpa_offload (+0x40)}.
 * Все 12 Б пишутся. */
void wmi_mac_addr_req(u32 mid, struct wmi_mbox *mb)
{
    struct wmi_mac_addr_resp_event *p = mem_pool_alloc_locked(&mb->mb);
    volatile struct wmi_mac_addr_resp_event *vp = p;
    struct mid *m = mid_list_by_mid_fw(mid);
    volatile struct mid *vm = m;
    memcpy_fw(p->mac, m->mac, 6);
    p->auth_mode = (u8)vm->sec.auth;
    p->crypt_mode = (u8)vm->sec.group_crypto;
    vp->offload_mode = vm->sec.wpa_offload;
    fw_log_emit2(0x20, 0x100b6e0, vp->mac_hi, vp->mac_lo);
    fw_log_emit3(0x20, 0x100b6f4, p->auth_mode, p->crypt_mode, vp->offload_mode);
    fw_log_emit1(0x20, 0x100b724, mid);
    wmi_evt_post(mb, p, 0, 0x9003, sizeof(*p), mid, 0, 0);
}

/* mac__read_880a14_28 (0x8f3354, 88 Б): младшие байты 0x880a14..0x880a28 в шесть выходов
 * (порядок vendor: o2 ← 14, o1 ← 18, o0 ← 1c, o3 ← 20, o4 ← 24, o5 ← 28; stb). */
static void mac_read_880a14_28(u8 *o0, u8 *o1, u8 *o2, u8 *o3, u8 *o4, u8 *o5)
{
    if (o2) *o2 = (u8)MMIO32(HW_FW_TIMESTAMP_HOUR);
    if (o1) *o1 = (u8)MMIO32(HW_FW_TIMESTAMP_MINUTE);
    if (o0) *o0 = (u8)MMIO32(HW_FW_TIMESTAMP_SECOND);
    if (o3) *o3 = (u8)MMIO32(HW_FW_TIMESTAMP_DAY);
    if (o4) *o4 = (u8)MMIO32(HW_FW_TIMESTAMP_MONTH);
    if (o5) *o5 = (u8)MMIO32(HW_FW_TIMESTAMP_YEAR);
}

/* mac__read_880a00_0c (0x8f34c4, 56 Б): четыре регистра 0x880a00..0x880a0c (с конца). */
static void mac_read_880a00_0c(u32 *a, u32 *b, u32 *c, u32 *d)
{
    if (d) *d = MMIO32(HW_BL_VERSION_BUILD);
    if (c) *c = MMIO32(HW_BL_VERSION_SUBMINOR);
    if (b) *b = MMIO32(HW_BL_VERSION_MINOR);
    if (a) *a = MMIO32(HW_BL_VERSION_MAJOR);
}

/* 0x801ba4: список возможностей FW (одно слово; не const — wmi_fw_ver читает из памяти). */
/* Бит 0 (WMI_FW_CAPABILITY_FTM) снят: FTM — только SparRAW-pro (vendor 0x305f). */
FWDATA(801ba4) u32 fw_caps_list[1] = { 0x305e };

/* 0x8f3560 (16 Б): список возможностей FW — fw_caps_list (0x801ba4). */
static void fw_caps_get(u32 *pp, u8 *pn)
{
    *pp = (u32)fw_caps_list;
    *pn = 1;
}

/* wmi_fw_ver (0x8dd130, 364 Б): WMI_FW_VER → 0x9004 (0x3c + 4·n Б): версии из
 * регистров 0x880a2c..38 (+0..+0xc), байты 0x880a14..28 (+0x10..+0x24), 0x880a00..0c
 * (+0x28..+0x34), +0x38 n, +0x3c слова возможностей. Нет буфера — ассерт 0x1039, vendor
 * идёт дальше. */
void wmi_fw_ver(struct wmi_mbox *mb, u32 mid)
{
    u32 caps = 0;
    u8 ncaps;
    u32 i, len;
    struct wmi_fw_ver_event *p = mem_pool_alloc_locked(&mb->mb);
    volatile struct wmi_fw_ver_event *vp = p;      /* прежние W(): чтения журнала — volatile */
    if (p == 0)
        fw_sysassert_fatal(__builtin_return_address(0), 0x1039);
    memset0_words(p, sizeof(*p));
    mac_read_880a2c_38(&p->fw_major, &p->fw_minor, &p->fw_subminor, &p->fw_build);
    /* время сборки — младшими байтами слов (stb) */
    mac_read_880a14_28((u8 *)&p->second, (u8 *)&p->minute, (u8 *)&p->hour, (u8 *)&p->day,
                       (u8 *)&p->month, (u8 *)&p->year);
    mac_read_880a00_0c(&p->bl_major, &p->bl_minor, &p->bl_subminor, &p->bl_build);
    fw_log_emit0(0x20, 0x100631c);
    fw_log_emit2(0x20, 0x1006344, vp->fw_major, vp->fw_minor);
    fw_log_emit2(0x20, 0x1006358, vp->fw_subminor, vp->fw_build);
    fw_log_emit2(0x20, 0x1006364, vp->bl_major, vp->bl_minor);
    fw_log_emit2(0x20, 0x1006358, vp->bl_subminor, vp->bl_build);
    fw_log_emit3(0x20, 0x1006380, vp->day, vp->month, vp->year);
    fw_log_emit3(0x20, 0x10063b4, vp->hour, vp->minute, vp->second);
    fw_caps_get(&caps, &ncaps);
    fw_log_emit1(0x20, 0x10063cc, ncaps);
    for (i = 0; (s32)i < (s32)ncaps; i++) {
        vp->fw_capabilities[i] = ((u32 *)caps)[i];
        fw_log_emit2(0x20, 0x10063f4, i, ((u32 *)caps)[i]);
    }
    p->fw_capabilities_len = ncaps;
    len = (u16)(ncaps * 4 + sizeof(*p));
    fw_log_emit1(0x20, 0x100642c, len);
    wmi_evt_post(mb, p, 0, 0x9004, len, mid, 0, 0);
}

/* ======================= RF / baseband / температура ======================= */

/* rf__get_module_info (0x8f3704, 124 Б): o0 = ldw 0x880a8e, o1 = [gp+191], o2 = маска RF
 * [obj+0x45e], o3 = rfca__get_rf_set_lo8 (0x8ce82c: (u8)[0x889488]); arr[n] = 1, затем
 * для каждого бита маски i < n — arr[i] = (u8)[0x880a68]. */
static void rf_get_module_info(struct rf_obj *obj, u32 *o0, u32 *o1, u32 *o2, u32 *o3, u8 *arr, u32 n)
{
    if (o0) *o0 = MMIO16(HW_REV_ID_RF_TYPE);
    if (o1) *o1 = G_RF_TYPE;
    if (o2) *o2 = *(volatile u8 *)&obj->rf_mask;
    if (o3) *o3 = (u8)MMIO32(HW_ABIF_DVS_RF_CTRL);
    if (arr) {
        u32 it;
        memset_fw(arr, 1, n);
        field_set_0x00_8e5dfc(&it, *(volatile u8 *)&obj->rf_mask);
        while (bit_iter_has_more(&it)) {
            u32 i = bitmap_alloc_bit(&it);
            if (i < n)
                arr[i] = (u8)MMIO32(RF_STATUS);
        }
    }
}

/* wmi_get_rf_status (0x8dd3c8, 240 Б): WMI_GET_RF_STATUS → 0x1866 (64 Б): +0 rf_type,
 * +4 [gp+191], +8 маска RF, +0xc состояние RF по модулям (32 Б), +0x2c..+0x34 platform
 * info board-file, +0x38 набор RF. Нет буфера — ассерт 0x1455, vendor идёт дальше. */
void wmi_get_rf_status(struct wmi_mbox *mb, u32 mid)
{
    u32 it;
    struct wmi_get_rf_status_event *p = mem_pool_alloc_locked(&mb->mb);
    volatile struct wmi_get_rf_status_event *vp = p;   /* прежние W() — volatile */
    if (p == 0)
        fw_sysassert_fatal(__builtin_return_address(0), 0x1455);
    memset0_words(p, sizeof(*p));
    rf_get_module_info(&rf_obj, &p->rf_type, &p->attached_rf_vector, &p->enabled_rf_vector,
                       &p->enabled_xif_vector, p->rf_status, sizeof(p->rf_status));
    rf_boardfile_read_platform_info(&rf_obj, &p->board_file_rf_type,
                                    &p->board_file_platform_type, &p->board_file_version);
    fw_log_emit0(0x20, 0x100644c);
    fw_log_emit3(0x20, 0x100647c, vp->rf_type, vp->attached_rf_vector, vp->enabled_rf_vector);
    fw_log_emit0(0x20, 0x10064bc);
    field_set_0x00_8e5dfc(&it, vp->enabled_rf_vector);
    while (bit_iter_has_more(&it)) {
        u32 i = bitmap_alloc_bit(&it);
        fw_log_emit2(0x20, 0x10064d8, i, p->rf_status[i]);
    }
    fw_log_emit3(0x20, 0x10064e8, vp->board_file_rf_type, vp->board_file_platform_type,
                 vp->board_file_version);
    wmi_evt_post(mb, p, 0, 0x1866, sizeof(*p), mid, 0, 0);
}

/* wmi_get_baseband_type (0x8dd29c, 116 Б): → 0x1867 (4 Б): ldw 0x880a8c. Нет буфера —
 * ассерт 0x144f, vendor идёт дальше. */
void wmi_get_baseband_type(struct wmi_mbox *mb, u32 mid)
{
    volatile struct wmi_word_event *p = mem_pool_alloc_locked(&mb->mb);   /* {baseband_type} */
    if (p == 0)
        fw_sysassert_fatal(__builtin_return_address(0), 0x144f);
    memset0_words((void *)p, sizeof(*p));
    p->value = MMIO16(HW_RGF_USER_FW_REV_ID);
    fw_log_emit0(0x20, 0x1006520);
    fw_log_emit1(0x20, 0x1006554, p->value);
    wmi_evt_post(mb, (void *)p, 0, 0x1867, sizeof(*p), mid, 0, 0);
}

/* wmi__post_temp_sense_done (0x8e5dac, 58 Б; колбэк службы температуры, vendor передаёт
 * смещение 0x25dac): → 0x180e (36 Б, mid 0) через ящик ctx: {bb, rf}. */
static void wmi_post_temp_sense_done(u32 bb, u32 rf, u32 obj)
{
    struct wmi_mbox *mb = (struct wmi_mbox *)obj;  /* ctx колбэка службы температуры */
    struct wmi_temp_sense_done_event *p = mem_pool_alloc_locked(&mb->mb);
    volatile struct wmi_temp_sense_done_event *vp = p;
    /* vendor пишет 8 Б из 36 (0x8e5dc2) — +8..+0x23 у vendor — остаток слота пула; у нас нули
     * (mem_pool_alloc_locked обнуляет). */
    vp->baseband_t1000 = bb;
    vp->rf_t1000[0] = rf;
    wmi_evt_post(mb, p, 0, 0x180e, sizeof(*p), 0, 0, 0);
}

/* wmi__cmd_arg_check (0x8e909c, 114 Б; имя NAMES-EXTRA неверно — это WMI_TEMP_SENSE):
 * {measure_baseband_en, measure_rf_en, measure_mode @+8}. mode ≠ 1 — асинхронно через
 * temp_sense__get_cached (ответ — wmi__post_temp_sense_done); mode = 1 — сразу 0x180e
 * (36 Б, mid 0): {BB (basic_calib 0x8cb91c(0) = [0x8000a4]), RF 0..7 (temp 0x8cca40(i, 0))}. */
void wmi_temp_sense(struct wmi_mbox *mb, const struct wmi_temp_sense_cmd *cmd)
{
    volatile struct wmi_temp_sense_done_event *p;
    u32 i;
    if (cmd->measure_mode != 1) {
        temp_sense_get_cached(wmi_post_temp_sense_done, (u32)mb);
        return;
    }
    p = mem_pool_alloc_locked(&mb->mb);
    p->baseband_t1000 = temp_bb_mdeg;
    for (i = 0; i < 8; i++)
        p->rf_t1000[i] = temp_get_rf_by_index(i, 0);
    wmi_evt_post(mb, (void *)p, 0, 0x180e, sizeof(*p), 0, 0, 0);
}

/* ======================= ключи / пароль ======================= */

/* add_key (0x8d0edc, 100 Б): ключ 16 Б (копия на стеке) в 0x886038..44, слот в
 * 0x886034, 0x886030 = 0x80000000, 0x88602c = 0x40000000, бит слота в 0x8860d8
 * (bic+or — по сути or). Порядок записей — как у vendor. */
static void add_key(const u8 *key, u32 slot)
{
    u32 k[4];
    u32 bit;
    memcpy_fw(k, key, 0x10);
    MMIO32(HW_RX_KEY_TBL_DATA0) = k[0];
    MMIO32(HW_RX_KEY_TBL_DATA1) = k[1];
    MMIO32(HW_RX_KEY_TBL_DATA2) = k[2];
    MMIO32(HW_RX_KEY_TBL_DATA3) = k[3];
    MMIO32(HW_RX_KEY_TBL_ADDR) = slot;
    MMIO32(HW_RX_KEY_TBL_CMD) = 0x80000000u;
    MMIO32(HW_RX_KEY_TBL_CTRL) = 0x40000000u;
    fw_log_emit1(0x20, 0x101f778, slot);
    bit = 1u << (slot & 31);                        /* bset r1,0,r13 */
    MMIO32(HW_RX_KEY_VALID_BITMAP) = (MMIO32(HW_RX_KEY_VALID_BITMAP) & ~bit) | bit;
}

/* key__install_by_type (0x8d6e68, 30 Б): тип 0 — слот (idx & 1) + 2·cid (add1_s), тип 1 —
 * то же + 0x10, прочие — ничего. */
static void key_install_by_type(const u8 *key, u32 idx, u32 type, u32 cid)
{
    u32 slot;
    if (type == 0)
        slot = (idx & 1) + (cid << 1);
    else if (type == 1)
        slot = (idx & 1) + (cid << 1) + 0x10;
    else
        return;
    add_key(key, (u8)slot);
}

/* set_tk (0x8e7140, 104 Б): парный ключ — 16 Б в обратном порядке в tk, индекс в
 * tk_idx, установка типа 0 для cid соединения. Запись ключа побайтно — volatile, как
 * прежде (B()). */
static void set_tk(struct conn *conn, const u8 *key, u32 idx)
{
    u32 i;
    fw_log_emit0(0x2e, 0x1010364);
    hexdump_words(key, 0x10);
    for (i = 0; i < 0x10; i++)
        *(volatile u8 *)&conn->tk[i] = key[0xf - i];
    conn->tk_idx = (u8)idx;
    fw_log_emit0(0x2e, 0x1010378);
    hexdump_words(conn->tk, 0x10);
    key_install_by_type(conn->tk, conn->tk_idx, 0, conn->cid);
}

/* set_gtk (0x8e6704, 132 Б): групповой ключ — 16 Б в обратном порядке в gtk (MID+0x294),
 * индекс в gtk_idx (MID+0x2a4), установка по типу usage для cid. */
static void set_gtk(struct mid *m, const u8 *key, u32 idx, u32 usage, u32 cid)
{
    volatile struct mid *vm = m;
    u32 i;
    fw_log_emit3(0x2e, 0x100cf34, idx, usage, cid);
    fw_log_emit0(0x2e, 0x100cf74);
    hexdump_words(key, 0x10);
    for (i = 0; i < 0x10; i++)
        vm->gtk[i] = key[0xf - i];
    vm->gtk_idx = (u8)idx;
    fw_log_emit0(0x2e, 0x100cf8c);
    hexdump_words(m->gtk, 0x10);
    key_install_by_type(m->gtk, vm->gtk_idx, usage, cid);
}

/* conn_mgr__first_active (0x8cc254, 54 Б): первое соединение списка MID с состоянием MLME ≠ 0;
 * нет такого — ПОСЛЕДНЕЕ просмотренное (0 у пустого списка), как у vendor. */
static struct conn *conn_mgr_first_active(struct mid *m)
{
    u32 it;
    struct conn *e = 0;
    iter_init(&it, &m->conns);
    while (list_has_items(&it)) {
        e = (struct conn *)iter_next(&it);
        if (e->mlme.sm.state != 0)
            break;
    }
    return e;
}

/* wmi_add_key__pick_mid (0x8cbb2c, 42 Б): у MID есть список ([m+0x18] ≠ 0) и активные
 * соединения — первое активное, иначе 0. */
static struct conn *wmi_add_key_pick_conn(struct mid *m)
{
    if (((volatile struct mid *)m)->conns.count == 0)
        return 0;
    if (mid_count_active_conns(m) == 0)
        return 0;
    return conn_mgr_first_active(m);
}

/* Колбэк таймера группового TX-ключа (0x8f5bbc, 56 Б; vendor передаёт смещение 0x35bbc):
 * ключ MID+0x294 — в LMAC с индексом 8, a1 = 4. */
static void wmi_add_key_gtk_timer(u32 mid, u32 unused)
{
    struct mid *k;
    (void)unused;
    k = mid_list_by_mid_fw(mid);
    fw_log_emit0(0x20, 0x100edd4);
    hexdump_words(k->gtk, 0x10);
    lmac_if_install_key(8, 4, k->gtk, ((volatile struct mid *)k)->gtk_idx, 0);
}

/* Колбэк таймера парного ключа (0x8f5bf4, 184 Б; vendor передаёт смещение 0x35bf4).
 * Нет MID — ассерт 0x16b8 (vendor идёт дальше); нет соединения cid — журнал, выход.
 * Режим безопасности 1 — ассерт 0x141e (дальше). Обмен Assoc не идёт (mlme.busy = 0) —
 * разорвать (disconnect_sta: mid байт [m+0x10], MAC пира, 1); иначе (журнал при
 * непустом vring) ключ tk в LMAC с индексом cid. */
static void wmi_add_key_ptk_timer(u32 mid, u32 cid)
{
    struct mid *m;
    struct conn *conn;
    m = mid_list_by_mid_fw(mid);
    if (m == 0)
        fw_sysassert_fatal(__builtin_return_address(0), 0x16b8);
    conn = conn_mgr_by_cid(cid);
    if (conn == 0) {
        fw_log_emit1(0x10, 0x100ee0c, cid);
        return;
    }
    if (conn_sec_mode_not_1(conn) == 0)
        fw_sysassert_fatal(__builtin_return_address(0), 0x141e);
    if (conn->mlme.busy == 0) {
        fw_log_emit1(0x10, 0x100ee90, mid);
        l2mgr_disconnect_sta(((volatile struct mid *)m)->id, conn->peer, 1);
        return;
    }
    if (vring_is_empty_by_id(conn) == 0)
        fw_log_emit1(0x10, 0x100ee38, mid);
    hexdump_words(conn->tk, 0x10);
    lmac_if_install_key(conn->cid, 0, conn->tk, conn->tk_idx, 0);
    fw_log_emit0(0x20, 0x100ee78);
}

/* wmi_add_cipher_key (0x8fbf7c, 414 Б): WMI_ADD_CIPHER_KEY {key_index, key_type,
 * key_usage, key_len, rsc[8], key[32] @+0xc, key_op_ctrl, mac[6] @+0x2d}.
 * Нет MID — ассерт 0x16ba (дальше).
 *  usage 0 (парный): соединение по MAC (нет — журнал, выход; vendor ищет дважды,
 *    второй результат не нужен), set_tk, через [0x8003fc] — колбэк 0x8f5bf4(mid, cid, 2);
 *  usage 2 (TX группы): колбэк 0x8f5bbc(mid, 0, 2), cid = 0xff;
 *  иначе: соединение — по типу MID ([m+0x14] = 1 или 0x20 — первое активное), иначе по
 *    MAC (нет — журнал, выход); cid = [conn+8];
 *  для usage ≠ 0 — set_gtk(MID, ключ, индекс, usage, cid). */
void wmi_add_cipher_key(const struct wmi_add_cipher_key_cmd *cmd, u32 mid)
{
    const u8 *mac = cmd->mac;
    struct mid *m;
    u32 cid;
    struct conn *conn;
    u32 usage;
    m = mid_list_by_mid_fw(mid);
    if (m == 0)
        fw_sysassert_fatal(__builtin_return_address(0), 0x16ba);
    usage = cmd->key_usage;
    if (usage == 0) {
        conn = mid_list_find_by(m, mac);
        if (conn == 0) {
            fw_log_emit2(0x10, 0x100b628, mac_hi16(mac), mac_lo32(mac));
            return;
        }
        (void)mid_list_find_by(m, mac);
        set_tk(conn, cmd->key, cmd->key_index);
        fw_log_emit3(0x20, 0x100b578, conn->cid, mac_hi16(mac), mac_lo32(mac));
        u_schd_schedule(wmi_add_key_ptk_timer, mid, conn->cid, 2, G_KEY_TMR_DELAY, 0, 0);
        return;
    }
    if (usage == 2) {
        fw_log_emit0(0x20, 0x100b5a8);
        u_schd_schedule(wmi_add_key_gtk_timer, mid, 0, 2, G_KEY_TMR_DELAY, 0, 0);
        cid = 0xff;
    } else {
        u32 kind = ((volatile struct mid *)m)->network_type;
        if (kind == 1 || kind == 0x20)
            conn = wmi_add_key_pick_conn(m);
        else
            conn = mid_list_find_by(m, mac);
        if (conn == 0) {
            fw_log_emit0(0x20, 0x100b5fc);
            return;
        }
        cid = conn->cid;
        fw_log_emit1(0x20, 0x100b5b4, cid);
    }
    fw_log_emit3(0x20, 0x100b5c8, mid, mac_hi16(mac), mac_lo32(mac));
    set_gtk(m, cmd->key, cmd->key_index, cmd->key_usage, cid);
}

/* wmi_delete_cipher_key (0x8ec4bc, 48 Б): {key_index, mac[6]} — только журнал. */
void wmi_delete_cipher_key(const struct wmi_delete_cipher_key_cmd *cmd, u32 mid)
{
    (void)mid;
    fw_log_emit2(0x20, 0x100b664, mac_hi16(cmd->mac), mac_lo32(cmd->mac));
}

/* dashboard__store_passphrase (0x8eac90, 28 Б). Исправлено (баг vendor): vendor копировал по СТАРОЙ
 * длине SSID ldw [d+0x26] (в слоте задержки bl.d memcpy затирает r2), а не по len — пароль сохранялся
 * не той длины, а длина SSID от хоста (до 255) переполняла passphrase[64] и соседние поля dashboard
 * в DCCM. Здесь — длина пароля из команды, не больше буфера. */
static void dashboard_store_passphrase(struct dashboard *d, const u8 *src, u32 len)
{
    if (len > DASHBOARD_PASSPHRASE_MAX)
        len = DASHBOARD_PASSPHRASE_MAX;
    memcpy_fw(d->passphrase, src, len);
    d->passphrase_len = (u16)len;
}

/* dashboard__store_ssid (0x8eace8, 24 Б). Исправлено (баг vendor): vendor копировал по старой длине
 * [d+0x26] (первый SET_PASSPHRASE — 0 Б, дальше — длина прошлой команды до 255 в ssid[32]). Здесь —
 * длина из команды, не больше буфера. */
static void dashboard_store_ssid(struct dashboard *d, const u8 *src, u32 len)
{
    if (len > DASHBOARD_SSID_MAX)
        len = DASHBOARD_SSID_MAX;
    memcpy_fw(d->ssid, src, len);
    d->ssid_len = (u16)len;
}

/* wmi_set_passphrase_handler (0x8ece64, 82 Б): {ssid[32], passphrase[64], ssid_len @+0x60,
 * passphrase_len @+0x61}: SSID в MID, пароль и SSID в dashboard 0x803b80 (пароль — до
 * обновления длины SSID). Ответа нет. */
void wmi_set_passphrase_handler(const struct wmi_set_passphrase_cmd *cmd, u32 mid)
{
    struct mid *m = mid_list_by_mid_fw(mid);
    mid_set_ssid(&m->bss, cmd->ssid, cmd->ssid_len);
    dashboard_store_passphrase(&dashboard, cmd->passphrase, cmd->passphrase_len);
    dashboard_store_ssid(&dashboard, cmd->ssid, cmd->ssid_len);
    fw_log_emit3(0x20, 0x100b698, cmd->ssid_len, cmd->passphrase_len, mid);
}
