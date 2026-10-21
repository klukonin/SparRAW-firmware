// SPDX-License-Identifier: AGPL-3.0-or-later
/* Обработчики WMI-команд области «PCP/AP, discovery, P2P» (docs/WMI-DISPATCH.md):
 * сильные порты вместо слабых заглушек wmi_handlers_todo.c, сигнатуры — include/
 * wmi_handlers.h (аргументы так, как их ставит диспетчер 0x8de43c: r13 — тело,
 * r14 — mid, r15 — ящик).
 *
 *   0x000f BCON_CTRL (0x8ec840)            0x0918 PCP_START (0x8ec91c)
 *   0x0822 BCAST_VRING_CFG (0x8fb4e0)      0x082b SW_TX_REQ (0x8fbe18)
 *   0x0829 SET_PCP_CHANNEL (0x8fbcc4)      0x082a GET_PCP_CHANNEL (0x8fb5ec)
 *   0x091b GET_PCP_FACTOR (0x8fb648)       0x0910 P2P_CFG (0x8fb69c)
 *   (0x0904 TRAFFIC_DEFERRAL / 0x0905 TRAFFIC_RESUME — вырезаны, см. fw/vectors.c pcie_pm_event_unsupported)
 *   0x0911 PORT_ALLOCATE (0x8fb77c)        0x0914..0x0917 LISTEN/SEARCH/DISCOVERY
 *
 * Мелкие функции других модулей зовутся по их глобальным портам (прототипы ниже).
 *
 * Переменные fw_data (gp = 0x800184):
 *   [gp-0xc0] 0x8000c4 — контекст кадра SW TX (payload − 0x24), [gp+0] 0x800184 — его
 *     колбэк завершения (у vendor — число 0x38e50 = l2mgr__send_sw_tx_complete),
 *   [gp+0xcb] 0x80024f — cid соединения кадра SW TX,
 *   [gp+0xd6] 0x80025a — число активных PCP,
 *   [gp-0x68] 0x80011c — power_source (WMI_POWER_MGMT_CFG), бит 0 — в PCP factor,
 *   [gp+0x268] 0x8003ec — число секторов A-BFT (2..8, BCON_CTRL),
 *   [gp+0x150] 0x8002d4 — интервал бикона (BCON_CTRL),
 *   [gp+0x86] 0x80020a — множитель длительности поиска (u16),
 *   [gp+0x274] 0x8003f8 — флаг правила парсера 2 при старте PCP,
 *   [gp-0x98] 0x8000ec — таймер информационного потока, 0x8000a0 + mid·4, 0x8000f0.
 * Конфигурация 0x803b80: +0 канал PCP, +4 SSID, +0x26 длина SSID, +0x6c/+0x70 — флаги
 *   безопасности BCON_CTRL, +0x8c (0x803c0c) — OOB-режим, +0xa8 (0x803c28) — split MAC. */
#include "../include/types.h"
#include "../include/ieee80211.h"
#include "../include/rf_sets.h"
#include "../include/power.h"
#include "../include/wmi_handlers.h"
#include "../include/mbox.h"
#include "../include/vring_schd.h"
#include "../include/conn.h"
#include "../include/mid.h"
#include "../include/stream.h"
#include "../include/sys_cfg.h"
#include "../include/fwq_tx.h"

/* vring / стримы */
/* SW TX (кадры управления от хоста) */


#define RA()  __builtin_return_address(0)      /* blink vendor для fw_sysassert_fatal */

#define SW_TX_CTX        sw_tx_mgmt_ctx    /* [gp-0xc0] */
#define SW_TX_CB         sw_tx_mgmt_cb    /* [gp+0] */
#define SW_TX_CID        wmi_sw_tx_cid    /* [gp+0xcb] */
#define PCP_COUNT        pcp_active_count    /* [gp+0xd6] */
#define POWER_SOURCE     power_source  /* [gp-0x68] */
#define ABFT_SECTORS     pcp_abft_sectors    /* [gp+0x268] */
#define BCON_INTERVAL    pcp_bcon_interval    /* [gp+0x150] */
#define INFO_FLOW_TMR    info_flow_timer    /* [gp-0x98] */

/* ======================= BCAST_VRING_CFG (0x822) ======================= */

/* init_bcast_queue (0x8d973c, 102 Б): запись vring_tbl vr (0x806014 + vr·16) под
 * широковещательную очередь: MACQ vr, max_mpdu, окно 0x40/0x10 с 0x4800 размером 0x800,
 * MPDU 0xfb0, тип 7. max_mpdu больше 0xfb0 — только журнал (сравнение со знаком, brge). */
static void init_bcast_queue(u32 mpdu, u32 vr)
{
    struct vring_tbl_entry *e = &vring_tbl[vr];

    e->macq = (u8)vr;
    e->max_mpdu = (u16)mpdu;
    e->state = 0;
    tx_macq_config_ring_params(e, 0x40, 0x10, 9u << 11, 0x800, 0xfb0);
    tx_macq_setup(e, 7, 0, 0, 0, 0, 0, 0);
    if ((s32)0xfb0 < (s32)mpdu)
        fw_log_emit2(0x10, 0x1018d20, 0xfb0, mpdu);
}

/* stream_mgr__add_bcast_vring (0x8c2720, 86 Б): стрим ctx в таблицу по vring (stream_by_vr,
 * 0x847f80 + vr·4; занято — ассерт 0x1287, vendor идёт дальше), vt[3] vring_schd (cfg, ctx, 0, 0),
 * vring в готовые, WMI_VRING_CFG_DONE (статус 0, devid — ctx->mid). */
static void stream_mgr_add_bcast_vring(struct stream_ctx *ctx, const struct wmi_sw_ring_cfg *cfg)
{
    u32 vr = ctx->vr;
    struct stream_ctx **slot = &stream_by_vr[vr];  /* add2 r15,r15,r14 */
    struct vring_schd_if *tbl;

    if (*slot != 0)
        fw_sysassert_fatal(RA(), 0x1287);
    *slot = ctx;
    tbl = vring_active_ring_table();
    tbl->vt->add_vring(tbl, cfg, ctx, 0, 0);
    vring_schd_alloc_pring(vr);
    l2mgr_send_vring_cfg_done(vr, hwd_dma_macq_reg_addr(vr), 0, ctx->mid);
}

/* wmi_bcast_vring_cfg (0x8fb4e0, 184 Б): WMI_BCAST_VRING_CFG (0x822). Тело: +0 action
 * (0 — add, 2 — delete), +4 tx_sw_ring {ring_mem_base, ring_size +0xc, max_mpdu_size
 * +0xe}, +0x10 ringid, +0x11 encap_trans_type. ringid ≥ 10 — ассерт 0x11f6, action 1 и
 * прочие — ассерт 0x11d1 (оба — выход). Нет записи mid — ассерт 0x16c0 (vendor идёт
 * дальше с нулём). */
void wmi_bcast_vring_cfg(const struct wmi_bcast_vring_cfg_cmd *cmd, u32 mid)
{
    u32 vr = cmd->vring_cfg.ringid;
    u32 act, mpdu;
    struct stream_ctx *ctx;
    struct mid *e;

    if (vr >= 0xa) {
        fw_sysassert_fatal(RA(), 0x11f6);
        return;
    }
    act = cmd->action;
    if (act == 2) {
        stream_mgr_delete_vring(vr);
        return;
    }
    if (act != 0) {
        fw_sysassert_fatal(RA(), 0x11d1);
        return;
    }
    fw_log_emit1(0x2b, 0x100db88, vr);
    ctx = vring_ctx_alloc();
    mpdu = cmd->vring_cfg.tx_sw_ring.max_mpdu_size;
    fw_log_emit1(0x2b, 0x100db9c, mpdu);
    e = mid_list_by_mid_fw(mid);
    if (e == 0)
        fw_sysassert_fatal(RA(), 0x5bu << 6);       /* 0x16c0 */
    init_bcast_queue(mpdu, vr);
    vring_configure_tx(ctx, vr, 0, 0, 0, cmd->vring_cfg.encap_trans_type, 0, 0, 1, (u8)mid_type_of(e),
                       mid, 1);
    stream_mgr_add_bcast_vring(ctx, &cmd->vring_cfg.tx_sw_ring);
}

/* ======================= PCP channel / factor (0x829 / 0x82a / 0x91b) ======================= */

/* wmi_set_pcp_channel (0x8fbcc4, 40 Б): [0x803b80] = channel (≥ 4 — ассерт 0x11df,
 * vendor всё равно пишет). */
void wmi_set_pcp_channel(const struct wmi_set_pcp_channel_cmd *cmd)
{
    if (cmd->channel >= 4)
        fw_sysassert_fatal(RA(), 0x11df);
    dashboard.pcp_channel = cmd->channel;
}

/* wmi_get_pcp_channel (0x8fb5ec, 92 Б): WMI_GET_PCP_CHANNEL_EVENTID (0x182a, 4 Б) —
 * канал записи mid ([e+0x94]) или, без записи, [0x803b80].
 * vendor пишет только байт 0, байты 1..3 (reserved) у vendor — остаток слота пула; у нас нули
 * (mem_pool_alloc_locked обнуляет). */
void wmi_get_pcp_channel(u32 mid, struct wmi_mbox *mb)
{
    struct wmi_get_pcp_channel_event *p = mem_pool_alloc_locked(&mb->mb);
    struct mid *e = mid_list_by_mid_fw(mid);

    p->channel = (u8)((e != 0) ? e->bss.channel : dashboard.pcp_channel);
    fw_log_emit1(0x2b, 0x100dc44, mid);
    wmi_evt_post(mb, p, 0, 0x182a, sizeof(*p), mid, 0, 0);
}

/* pcp_factor_evt_step (0x8c5594, 152 Б): слово PCP factor из своего DMG Capabilities
 * c (= mobj + 0x5e) и флага: биты 0..6 — 0, 7..14 — байт из битов 3..10
 * слова c[0xf..0x10], 15..21 — 7 бит из битов 7..13 слова c[7..8], 22 — бит 1 c[0xf],
 * 23 — бит 0 c[0xf], 24 — бит 4 c[0x10], 25 — бит 0 флага, 26..31 — 0. mobj (r0) vendor
 * не использует. Слово стека у vendor не инициализировано, но все 32 бита пишутся
 * (bits__set32_s0_w7 0x8ed394, bits__set32_s7_w8 0x8ed55c, bits__set16_s7_w7 0x8ed214 по
 * sp+1, байтовые поля, bits__set8_s2_w6 0x8ed280 по sp+3). */
static void pcp_factor_evt_step(const struct mid_bss *mobj, const struct dmg_cap *cap, u32 flag,
                                u32 *out)
{
    const u8 *c = (const u8 *)cap;
    u32 w = 0;
    u32 v;

    (void)mobj;
    v = ((((u32)c[0x10] << 8) | c[0xf]) >> 3) & 0xffu;
    w |= v << 7;
    v = ((((u32)c[8] << 8) | c[7]) >> 7) & 0x7fu;
    w |= v << 15;
    w |= (((u32)c[0xf] >> 1) & 1u) << 22;
    w |= ((u32)c[0xf] & 1u) << 23;
    w |= (((u32)c[0x10] >> 4) & 1u) << 24;
    w |= (flag & 1u) << 25;
    *out = w;
}

/* wmi_get_pcp_factor (0x8fb648, 82 Б): событие 0x191a (4 Б) — PCP factor записи mid.
 * Запись mid vendor на 0 не проверяет. */
void wmi_get_pcp_factor(u32 mid)
{
    u32 *p = host_if_send_pair();
    struct mid *e = mid_list_by_mid_fw(mid);

    pcp_factor_evt_step(&e->bss, &e->bss.dmg_cap, POWER_SOURCE, p);
    fw_log_emit1(0x2b, 0x100e0ac, mid);
    low_sme_send_evt2sw(p, 0x191a, 4, mid, 0, 0, 0);
}

/* ======================= PORT_ALLOCATE (0x911) ======================= */

/* wmi_port_allocate (0x8fb77c, 126 Б): WMI_PORT_ALLOCATE {mac[6], port_role, mid} —
 * открыть mid с MAC (l2mgr__mac_started_log, без SSID). mid 0 и групповой MAC (бит 0
 * mac[0]) — отказ. Ответ 0x1911 (4 Б) {status: 0 — успех, 1 — отказ}.
 * vendor пишет только байт 0 из 4 (байты 1..3 у vendor — остаток слота пула); у нас нули
 * (mem_pool_alloc_locked обнуляет). */
void wmi_port_allocate(const struct wmi_port_allocate_cmd *cmd)
{
    struct wmi_status_event *p = host_if_send_pair();
    u32 mid = cmd->mid;

    if (mid == 0) {
        fw_log_emit0(0x1b, 0x100e67c);
        p->status = 1;
    } else if ((cmd->mac[0] & 1u) != 0) {
        fw_log_emit0(0xb, 0x100e620);
        p->status = 1;
    } else {
        p->status = (l2mgr_mac_started_log(mid, cmd->mac, 0, 0) == 1) ? 0 : 1;
    }
    fw_log_emit1(0x2b, 0x100e63c, cmd->mid);
    low_sme_send_evt2sw(p, 0x1911, sizeof(*p), cmd->mid, 0, 0, 0);
}

/* ======================= discovery: find_mngr (x = e + 0x240) ======================= */
/* Поля x (см. link_sm.c): +0xc — тихий режим (P2P discovery_mode == 1), +0x10 — канал,
 * +0x12 — интервал (u16), +0x14 — режим, +0x18 — таймер, +0x1c — find_sm, +0x40 —
 * discovery идёт, +0x44 — discovery-бикон, +0x48 — запись mid. o = e + 0x234 = x − 0xc:
 * [o+4] — запись mid, [o+8] — скан. */

/* l2mgr__send_discovery_started (0x8f88d4, 48 Б): событие 0x1916 без тела. */
static void l2mgr_send_discovery_started(u32 mid)
{
    fw_log_emit1(0x2b, 0x100ec10, mid);
    low_sme_send_evt2sw(host_if_send_pair(), 0x1916, 0, mid, 0, 0, 0);
}

static void find_mng_listen(struct find_mngr *x);
static void find_mng_search(struct find_mngr *x);

/* Колбэк таймера прослушивания (0x8db004; у vendor — число 0x1b004 в find_mngr__listen_start):
 * таймер снят; без тихого режима — ассерт 0x1244 (vendor идёт дальше); переход в поиск. */
static void find_mngr_listen_timer_cb(u32 a0, u32 a1)
{
    struct find_mngr *x = (struct find_mngr *)a0;
    (void)a1;
    fw_log_emit0(0x2c, 0x1017a78);
    x->timer = 0;
    if (x->quiet == 0)
        fw_sysassert_fatal(RA(), 0x1244);
    find_mng_search(x);
}

/* Колбэк таймера поиска (0x8e4ca0; у vendor — число 0x24ca0 в find_mngr__search_start):
 * таймер снят; без тихого режима — ассерт 0x1245; переход в прослушивание. */
static void find_mngr_search_timer_cb(u32 a0, u32 a1)
{
    struct find_mngr *x = (struct find_mngr *)a0;
    (void)a1;
    fw_log_emit0(0x2c, 0x1017a94);
    x->timer = 0;
    if (x->quiet == 0)
        fw_sysassert_fatal(RA(), 0x1245);
    find_mng_listen(x);
}

/* find_mngr__listen_start (0x8daf40, 104 Б): discovery-режим LMAC (1, 0), событие 0
 * автомату find_sm, при dur ≠ 0 — таймер dur·1000 (mul64, младшее слово). */
static void find_mngr_listen_start(struct find_mngr *x, u32 dur)
{
    lmac_if_discovery_mode_cfg(1, 0);
    basic_sm_handle_event(&x->sm, 0, 0, 0, 0);
    fw_log_emit1(0x2c, 0x1017974, dur);
    if (dur == 0)
        return;
    x->timer = u_schd_schedule(find_mngr_listen_timer_cb, (u32)x, 0, 0, dur * 1000u, 0, 0);
    fw_log_emit2(0x2c, 0x1017990, x->channel, dur);
}

/* find_mngr__search_start (0x8e4b28, 98 Б): discovery-режим LMAC (1, 1), событие 1
 * автомату find_sm, при dur ≠ 0 — таймер dur·1000. */
static void find_mngr_search_start(struct find_mngr *x, u32 dur)
{
    lmac_if_discovery_mode_cfg(1, 1);
    basic_sm_handle_event(&x->sm, 1, 0, 0, 0);
    fw_log_emit1(0x2c, 0x10179c4, dur);
    if (dur == 0)
        return;
    x->timer = u_schd_schedule(find_mngr_search_timer_cb, (u32)x, 0, 0, dur * 1000u, 0, 0);
    fw_log_emit1(0x2c, 0x10179e0, dur);
}

/* find_mng::listen (0x8dafa8, 70 Б): при первом входе — discovery идёт, приём discovery;
 * длительность = интервал x->bi × (тихий режим ? (u_schd_now() & 3, 0 → 1) : 0). */
static void find_mng_listen(struct find_mngr *x)
{
    u32 k = 0;

    if (x->active == 0) {
        x->active = 1;
        fw_log_emit0(0x2c, 0x1017a14);
        discovery_rx_start(0);
    }
    if (x->quiet != 0) {
        k = u_schd_now() & 3u;                      /* bmsk.f r0,r0,1 */
        if (k == 0)
            k = 1;                                  /* mov.eq r0,1 */
    }
    find_mngr_listen_start(x, (x->bi * k) & 0xffffu);
}

/* find_mng::search (0x8e4b8c, 60 Б): то же для поиска; множитель — u16 [0x80020a]
 * (ldw_s r0,[gp,134]) в тихом режиме, иначе 0. */
static void find_mng_search(struct find_mngr *x)
{
    u32 k = 0;

    if (x->active == 0) {
        x->active = 1;
        fw_log_emit0(0x2c, 0x1017a30);
        discovery_rx_start(0);
    }
    if (x->quiet != 0)
        k = find_search_mult;
    find_mngr_search_start(x, (x->bi * k) & 0xffffu);
}

/* find_mngr__session_start (0x8e7ca0, 50 Б): первый вход — discovery идёт, приём,
 * событие DISCOVERY_STARTED хосту; затем прослушивание. */
static void find_mngr_session_start(struct find_mngr *x)
{
    if (x->active == 0) {
        fw_log_emit0(0x2c, 0x1017a60);
        x->active = 1;
        discovery_rx_start(0);
        l2mgr_send_discovery_started(x->mid->id);
    }
    find_mng_listen(x);
}

/* Проверки входа в discovery (start_find_session / find_mngr__enter_*): идёт скан
 * (scan_mngr.active) — ассерт c1, BSS записи mid не в состоянии 1 — ассерт c2;
 * vendor после обоих идёт дальше. */
static void find_enter_checks(struct mid_disc *o, u32 c1, u32 c2)
{
    if (o->scan->active != 0)
        fw_sysassert_fatal(RA(), c1);
    if (o->mid->bss.state != 1)
        fw_sysassert_fatal(RA(), c2);
}

/* start_find_session (0x8f9628, 72 Б). */
static void start_find_session(struct mid_disc *o)
{
    fw_log_emit0(0x2c, 0x1016fec);
    find_enter_checks(o, 0x1235, 0x1236);
    find_mngr_session_start(&o->find);
}

/* find_mngr__enter_listen (0x8f5f14, 72 Б). */
static void find_mngr_enter_listen(struct mid_disc *o)
{
    fw_log_emit0(0x2c, 0x1016fd4);
    find_enter_checks(o, 0x1237, 0x1238);
    find_mng_listen(&o->find);
}

/* find_mngr__enter_search (0x8f852c, 72 Б). */
static void find_mngr_enter_search(struct mid_disc *o)
{
    fw_log_emit0(0x2c, 0x1016fe0);
    find_enter_checks(o, 0x1239, 0x123a);
    find_mng_search(&o->find);
}

/* l2mgr__start_discovery (0x8fbd1c, 32 Б; диспетчер — переход 0x8ec3e0): системное
 * состояние 0xf и сессия поиска. Запись mid vendor на 0 не проверяет. */
void l2mgr_start_discovery(u32 mid)
{
    sys_state_broadcast(0xf, 0);
    start_find_session(&mid_list_by_mid_fw(mid)->disc);
}

/* l2_mgr::wmi_cmd_handler_start_listen (0x8fbd3c, 84 Б; переход 0x8ec3e4). Нет записи
 * mid — ассерт 0x16c2 (vendor идёт дальше). PCP/AP запись ([e+0x9c]) или mid в
 * состоянии 2 — отказ: журнал и LISTEN_STARTED.
 * Особенность vendor: при отказе статус 0 (как успех), у START_SEARCH — 1 (bl.d с
 * mov_s r0,0 в 0x8fbd62 против mov_s r0,0x1 в 0x8fbdb6); оставлено как у vendor. */
void l2mgr_start_listen(u32 mid)
{
    struct mid *e = mid_list_by_mid_fw(mid);

    if (e == 0)
        fw_sysassert_fatal(RA(), 0x16c2);
    if (e->bss.is_go != 0 || mid_list_any_in_state2() != 0) {
        fw_log_emit0(0x2b, 0x100e128);
        l2mgr_send_listen_started(0, e->id);
        return;
    }
    sys_state_broadcast(0xd, 0);
    find_mngr_enter_listen(&e->disc);
}

/* l2_mgr::wmi_cmd_handler_start_search (0x8fbd90, 84 Б; переход 0x8ec3e8). Нет записи
 * mid — ассерт 0x16c3. Отказ — SEARCH_STARTED со статусом 1. */
void l2mgr_start_search(u32 mid)
{
    struct mid *e = mid_list_by_mid_fw(mid);

    if (e == 0)
        fw_sysassert_fatal(RA(), 0x16c3);
    if (e->bss.is_go != 0 || mid_list_any_in_state2() != 0) {
        fw_log_emit0(0x1b, 0x100e1d4);
        l2mgr_send_search_started(1, e->id);
        return;
    }
    sys_state_broadcast(0xe, 0);
    find_mngr_enter_search(&e->disc);
}

/* l2mgr__stop_discovery (0x8fbde4, 50 Б; переход 0x8ec3ec): остановить поиск и вернуть
 * BSS записи mid к умолчаниям (MAC 0x8004a4, SSID 0x803b84 длиной [0x803ba6], режим 1).
 * add3 r0,r13,0x9 = e + 0x48. Запись mid vendor на 0 не проверяет. */
void l2mgr_stop_discovery(u32 mid)
{
    struct mid *e = mid_list_by_mid_fw(mid);

    stop_find_session(&e->disc);
    mid_reset_bss_defaults(&e->bss, dev_mac_addr, dashboard.ssid,
                           dashboard.ssid_len, 1);
}

/* ======================= P2P_CFG (0x910) ======================= */

/* l2mgr__send_p2p_cfg_done (0x8f8684, 70 Б): WMI_P2P_CFG_DONE_EVENTID (0x1910, 4 Б). */
static void l2mgr_send_p2p_cfg_done(u32 status, u32 mid)
{
    struct wmi_status_event *p = host_if_send_pair();
    memset0_words(p, sizeof(*p));
    p->status = (u8)status;
    fw_log_emit1(0x2b, 0x100df94, mid);
    low_sme_send_evt2sw(p, 0x1910, sizeof(*p), mid, 0, 0, 0);
}

/* find_mngr__cfg_offload (0x8c6b88, 124 Б): параметры discovery в x (discovery уже идёт
 * — ассерт 0x1242, интервал 0 — ассерт 0x1243; vendor идёт дальше), обход TSF на канале
 * и P2P_CFG_DONE (0). */
static void find_mngr_cfg_offload(struct find_mngr *x, struct mid *e, u32 quiet, u32 ch, u32 bi,
                                  u32 mode)
{
    if (x->active != 0)
        fw_sysassert_fatal(RA(), 0x1242);
    if (bi == 0)
        fw_sysassert_fatal(RA(), 0x1243);
    x->mid = e;
    x->quiet = quiet;
    x->channel = (u8)ch;
    x->bi = (u16)bi;
    x->mode = mode;
    x->bcon_added = 0;
    fw_log_emit3(0x2c, 0x10178dc, quiet, bi, mode);
    discovery_tsf_wa(&x->mid->disc, x->channel, x->bi, e->id);
    l2mgr_send_p2p_cfg_done(0, e->id);
}

/* p2p_cfg (0x8f6d20, 52 Б): объект discovery записи mid. */
static void p2p_cfg(struct mid_disc *o, u32 quiet, u32 ch, u32 bi, u32 mode)
{
    fw_log_emit0(0x2c, 0x1016fc8);
    find_mngr_cfg_offload(&o->find, o->mid, quiet, ch & 0xffu, bi, mode);
}

/* l2_mgr::wmi_cmd_handler_p2p_cfg (0x8fb69c, 154 Б; переход 0x8ec34c): WMI_P2P_CFG
 * {discovery_mode, channel, bcon_interval (u16)}. Нет записи mid — ассерт 0x16b9 (vendor
 * идёт дальше). Свободный mid (не PCP/AP, никто не в состоянии 2) — настроить
 * discovery; иначе ответ: 0, если канал записи ([e+0x94]) совпадает с запрошенным,
 * иначе 1 (запись ищется заново, нет — ассерт 0x1535). */
void l2mgr_p2p_cfg(const struct wmi_p2p_cfg_cmd *cmd, u32 mid)
{
    struct mid *e = mid_list_by_mid_fw(mid), *e2;
    u32 st;
    if (e == 0)
        fw_sysassert_fatal(RA(), 0x16b9);
    if (e->bss.is_go == 0 && mid_list_any_in_state2() == 0) {
        p2p_cfg(&e->disc, cmd->discovery_mode == 1, cmd->channel, cmd->bcon_interval,
                cmd->discovery_mode);
        return;
    }
    e2 = mid_list_by_mid_fw(mid);
    if (e2 == 0)
        fw_sysassert_fatal(RA(), 0x1535);
    if (e2->bss.channel != cmd->channel) {
        fw_log_emit1(0x1b, 0x100e040, cmd->channel);
        st = 1;
    } else {
        fw_log_emit1(0x2b, 0x100dfd0, cmd->channel);
        st = 0;
    }
    l2mgr_send_p2p_cfg_done(st, e->id);
}

/* ======================= PCP_START / BCON_CTRL (0x918 / 0xf) ======================= */

/* l2_mgr::send_pcp_start_status_evt (0x8f8a3c, 130 Б): WMI_PCP_STARTED_EVENTID (0x1918,
 * 4 Б: status). status 1 (отказ) — счётчик PCP −1. Снимает операцию 3. Вызывается и
 * таймером u_schd (cb(0, mid, 0) — у vendor число 0x38a3c в l2_mgr::pcp_start). */
static void send_pcp_start_status_evt(u32 status, u32 mid)
{
    struct wmi_status_event *p = host_if_send_pair();

    if (status == 1) {
        PCP_COUNT = (u8)(PCP_COUNT - 1);
        fw_log_emit1(0x1b, 0x100ec90, PCP_COUNT);
        if (PCP_COUNT == 0)        /* l2_mgr__has_active_pcp (0x8da47c): ldb, sub.le */
            fw_log_emit0(0x2b, 0x100ece0);
    }
    memset0_words(p, sizeof(*p));
    p->status = (u8)status;
    fw_log_emit3(0x2b, 0x100ed14, mid, status, u_schd_now());
    low_sme_send_evt2sw(p, 0x1918, sizeof(*p), mid, 0, 0, 0);
    l2mgr_pending_op_clear(3);
}

/* pcp_start (0x8f7110, 80 Б): объект discovery записи. Снять бит 1 байта bi_ctrl[0]
 * (+0x14f записи mid, discovery-бикон), поставить бикон PCP (add_bcon), счётчик mgmt_stats.bcon_set
 * +1, LMAC 0x23 (1). */
static void pcp_start(struct mid_disc *o)
{
    u8 *b;
    u32 v;

    fw_log_emit0(0x2c, 0x1016d24);
    b = o->mid->bss.bi_ctrl;
    v = b[0] & ~2u;
    b[0] = (u8)v;
    fw_log_emit2(0x2c, 0x1016d30, (v >> 1) & 1u, ((u32)b[5] >> 4) & 3u);
    add_bcon(o->mid);
    mgmt_stats.bcon_set = mgmt_stats.bcon_set + 1;
    lmac_if_send_cmd_0x23(1);
}

/* l2_mgr__pcp_start_flow (0x8e0778, 256 Б): поднять BSS записи e как PCP/AP. Групповой
 * MAC записи (бит 0 [e+0xa]) или BSS уже активен ([e+0x4c] == 2) — отказ (1). Иначе:
 * тип сети, число секторов A-BFT в [e+0x11], первичный канал [0x803b80] (u32 в [e+0x94]
 * байтом), режим BSS (AP 0x10 — 3, иначе 2), is_go/abft-1 в [e+0x9c]/[e+0x9d], бикон,
 * hidden в [e+0xa0] (field_set_0x58 0x8e6788); BSS активен (OOB и ADHOC* — только SparRAW-pro;
 * ADHOC* здесь — отказ 1); при [0x8003f8] — правило парсера 2 = 0x3f02.
 * Возврат 0 — успех. [e+0x2a8] = 0 (st.as r15,[r0,170]). */
static u32 l2mgr_pcp_start_flow(struct mid *e, u32 nettype, u32 abft, u32 hidden, u32 is_go,
                                u32 a5)
{
    struct mid_bss *o = &e->bss;                    /* add3 r14,r13,0x9 */
    u32 ch;
    e->pcp_ready_tmr = 0;
    if ((e->mac_h[0] & 1u) != 0) {                  /* bxor + bbit1 */
        fw_log_emit0(0xb, 0x100cd48);
        return 1;
    }
    if (nettype == 0x02 || nettype == 0x04) {       /* ADHOC* (IBSS) — только SparRAW-pro: отказ */
        fw_log_emit1(0xb, 0x100cd24, nettype);      /* «unknown network type» */
        return 1;
    }
    mid_log_network_type(e, nettype);
    e->max_assoc = (u8)abft;
    ch = dashboard.pcp_channel;
    if (o->state == 2) {
        fw_log_emit3(0xb, 0x100ce08, o->mode, 2, ch);
        return 1;
    }
    fw_log_emit3(0x2b, 0x100cd6c, ch, BCON_INTERVAL, nettype);
    radio_mgr_set_primary_channel(ch, 0, 0, BCON_INTERVAL, 0, e->id);
    o->channel = (u8)ch;
    bss_set_mode(o, (nettype == 0x10) ? 3 : 2);
    o->is_go = (u8)is_go;
    o->abft_len = (u8)a5;
    pcp_start(&e->disc);
    o->hidden = hidden;                             /* field_set_0x58__8e6788 */
    bss_set_active(o);
    if (pcp_parser_rule2_en != 0)
        mac_parser_set_886260(2, 0x3f02);
    return 0;
}

/* l2_mgr::pcp_start (0x8f706c, 162 Б): операция 3, состояние системы 9; запуск
 * (нет записи mid — ассерт 0x16bd, vendor идёт дальше). Отказ — сразу PCP_STARTED (1);
 * успех — счётчик PCP +1, состояние 0xa, PCP_STARTED (0) таймером через 0x7530. */
static void l2mgr_pcp_start(u32 mid, u32 nettype, u32 hidden, u32 is_go, u32 a4)
{
    struct mid *e;

    l2mgr_pending_op_set(3);
    sys_state_broadcast(9, 0);
    e = mid_list_by_mid_fw(mid);
    if (e == 0)
        fw_sysassert_fatal(RA(), 0x16bd);
    if (l2mgr_pcp_start_flow(e, nettype, ABFT_SECTORS, hidden, is_go, a4) == 1) {
        send_pcp_start_status_evt(1, mid);
        return;
    }
    PCP_COUNT = (u8)(PCP_COUNT + 1);
    fw_log_emit3(0x2b, 0x100f2b8, PCP_COUNT, is_go, a4);
    sys_state_broadcast(0xa, 0);
    (void)u_schd_schedule(send_pcp_start_status_evt, 0, mid, 0, 0x7530, 0, 0);
}

/* bcon_ctrl__prepare_mid_fw (0x8f8624, 72 Б): [e+0x3c] = sec; безопасность записи mid
 * (e+0x28): с защитой — (2, 0x10, 0x20, 1) и RSN IE по умолчанию, без — (1, 1, 1, 3) и
 * RSN IE снят; offload — wpa_offload. */
static void bcon_ctrl_prepare_mid(u32 mid, u32 sec, u32 offload)
{
    struct mid *e = mid_list_by_mid_fw(mid);

    e->sec.privacy = sec;
    if (sec != 0) {
        l2mgr_config_security(&e->sec, 2, 0x10, 0x20, 1, offload);
        mid_set_default_rsn_ie(e);
    } else {
        l2mgr_config_security(&e->sec, 1, 1, 1, 3, offload);
        mid_clear_rsn_ie_len(e);
    }
}

/* wmi_pcp_start_cmd_handler (0x8ec840, 218 Б): WMI_BCON_CTRL (0xf), им же пользуется
 * PCP_START. Тело: +0 bcon_interval (u16; 0 — PCP_STOP), +0xc network_type, +0xd число
 * секторов A-BFT (берётся при 2..8 в [0x8003ec]), +0xe disable_sec_offload, +0xf
 * disable_sec, +0x10 hidden_ssid, +0x11 is_go, +0x12 abft_len (1..8 → −1, иначе 1). */
void wmi_bcon_ctrl(const struct wmi_bcon_ctrl_cmd *cmd, u32 mid)
{
    u32 sec, offload, n, a4;

    if (cmd->bcon_interval < 1) {
        fw_log_emit1(0x20, 0x100b518, mid);
        l2mgr_pcp_stop(mid);
        return;
    }
    sec = (cmd->disable_sec == 0) ? 1u : 0u;
    n = cmd->pcp_max_assoc_sta;
    if (n >= 2 && n < 9)
        ABFT_SECTORS = n;
    /* литеральным адресом: с символом gcc не перечитывает ABFT_SECTORS для журнала (vendor — ldb, затем ld) */
    VOL(FWSH(fwsh_sets, abft_sectors)) = (u8)ABFT_SECTORS;
    fw_log_emit3(0x20, 0x100b448, cmd->bcon_interval, ABFT_SECTORS, sec);
    fw_log_emit1(0x20, 0x100b488, cmd->is_go);
    BCON_INTERVAL = cmd->bcon_interval;
    fw_log_emit3(0x20, 0x100b49c, mid, cmd->bcon_interval, cmd->network_type);
    offload = (cmd->disable_sec_offload == 0) ? 1u : 0u;
    dashboard.pcp_security_en = sec;
    dashboard.pcp_sec_offload_en = offload;
    bcon_ctrl_prepare_mid(mid, sec, offload);
    n = cmd->abft_len;
    a4 = (n >= 1 && n < 9) ? ((n - 1) & 0xffu) : 1u;
    fw_log_emit2(0x20, 0x100b4c8, a4, n);
    l2mgr_pcp_start(mid, cmd->network_type, cmd->hidden_ssid, cmd->is_go, a4);
    conn_alloc_and_link(0, 1, mid);
    lmac_if_send_cmd_0x04(1);                       /* lmac_if__send_cmd_04_thunk 0x8db718 */
}

/* wmi_pcp_start (0x8ec91c, 84 Б): WMI_PCP_START {bcon_interval, pcp_max_assoc_sta +2,
 * hidden_ssid +3, is_go +4, …, abft_len +0xa, ap_sme_offload_mode +0xb, network_type
 * +0xc, channel +0xd, disable_sec_offload +0xe, disable_sec +0xf} → тело BCON_CTRL на
 * стеке (20 Б), канал — в [0x803b80], ap_sme_offload_mode — в [0x803c28] (split MAC).
 * Байт +0x13 стекового тела vendor не пишет (BCON_CTRL его не читает); здесь 0. */
void wmi_pcp_start(const struct wmi_pcp_start_cmd *cmd, u32 mid)
{
    struct wmi_bcon_ctrl_cmd b;

    b.bcon_interval = cmd->bcon_interval;
    b.frag_num = 0;
    b.ss_mask[0] = 0;
    b.ss_mask[1] = 0;
    b.network_type = cmd->network_type;
    b.pcp_max_assoc_sta = cmd->pcp_max_assoc_sta;
    b.hidden_ssid = cmd->hidden_ssid;
    /* volatile: два ldb/stb, как у vendor (без него gcc сливает их в ldh/sth) */
    b.disable_sec_offload = ((const volatile struct wmi_pcp_start_cmd *)cmd)->disable_sec_offload;
    b.disable_sec = ((const volatile struct wmi_pcp_start_cmd *)cmd)->disable_sec;
    b.is_go = cmd->is_go;
    b.abft_len = cmd->abft_len;
    b.reserved = 0;
    dashboard.pcp_channel = cmd->channel;
    dashboard.cfg.ap_sme_offload_mode = cmd->ap_sme_offload_mode;
    wmi_bcon_ctrl(&b, mid);
}

/* ======================= SW_TX_REQ (0x82b): кадры управления от хоста ======================= */

/* l2mgr__send_sw_tx_complete (0x8f8e50, 72 Б): WMI_SW_TX_COMPLETE_EVENTID (0x182b, 4 Б:
 * status). Колбэк кадра SW TX (у vendor — число 0x38e50; SW_TX_MGMT_API::packet_release
 * зовёт его как cb(status ? 2 : 0, mid)). */
static void l2mgr_send_sw_tx_complete(u32 status, u32 mid)
{
    struct wmi_status_event *p = host_if_send_pair();
    memset0_words(p, sizeof(*p));
    p->status = (u8)status;
    fw_log_emit2(0x2b, 0x100dc84, mid, status);
    low_sme_send_evt2sw(p, 0x182b, sizeof(*p), mid, 0, 0, 0);
}

/* sw_tx_mgmt__acquire_link (0x8dab34, 168 Б): соединения с адресатом кадра SW TX нет —
 * поднять его (find_main_sm__bcon_args по MAC ctx+0xc, сектор 0xffff); вышло — cid в
 * [0x80024f] (кадр уйдёт по link_up_evt), нет — кадр вернуть хосту со статусом 1→2 и
 * контекст снять. Нет контекста — ассерты 0x1219/0x11d6, нет записи mid — 0x16bc (vendor
 * идёт дальше). */
static void sw_tx_mgmt_acquire_link(void)
{
    struct sw_tx_hdr *ctx;
    u32 payload;
    struct mid *e;
    struct conn *conn;

    if (SW_TX_CTX == 0)
        fw_sysassert_fatal(RA(), 0x1219);
    ctx = SW_TX_CTX;
    if (ctx == 0)
        fw_sysassert_fatal(RA(), 0x11d6);
    payload = (u32)ctx->payload;
    e = mid_list_by_mid_fw(SW_TX_CTX->mid);
    if (e == 0)
        fw_sysassert_fatal(RA(), 0x16bc);
    conn = find_main_sm_bcon_args(e, SW_TX_CTX->dst, 0, 0, 0xffff);
    if (conn != 0) {
        SW_TX_CID = conn->cid;
        fw_log_emit0(0x27, 0x1018860);
        return;
    }
    fw_log_emit0(0x17, 0x1018888);
    sw_tx_mgmt_packet_release(payload, 1, SW_TX_CTX->mid, SW_TX_CB);
    sw_tx_mgmt_clear_link_ctx();
}

/* SW_TX_MGMT_API::send_packet (0x8e577c, 248 Б): кадр хоста payload (len Б) адресату
 * dst (6 Б) через mid. Один кадр за раз ([0x8000c4]) и есть место в пуле TX (0x842304:
 * [+0xc] < [+0x10]) — иначе кадр сразу возвращается (статус 1). Контекст — 0x24 Б перед
 * payload: +8 len, +0xc dst, +0x12 mid; колбэк cb — в [0x800184]. Соединение с dst есть —
 * cid в [0x80024f] и отправка (link_up_evt(conn, 0)), нет — поднять (acquire_link).
 * payload 0 — ассерт 0x11e9 (vendor идёт дальше). */
static void sw_tx_mgmt_send_packet(const u8 *dst, u32 mid, u32 payload, u32 len, sw_tx_done_fn cb)
{
    struct sw_tx_hdr *ctx;
    struct conn *conn;
    struct mid *e;
    fw_log_emit0(0x27, 0x10186e4);
    if (SW_TX_CTX != 0 || *(volatile u32 *)&tx_pkt_pool.used >= *(volatile u32 *)&tx_pkt_pool.count) {
        fw_log_emit0(0x17, 0x1018808);
        sw_tx_mgmt_packet_release(payload, 1, mid, cb);
        return;
    }
    e = mid_list_by_mid_fw(mid);
    conn = mid_list_find_by(e, dst);
    hexdump_words((void *)payload, len);
    if (payload == 0)
        fw_sysassert_fatal(RA(), 0x11e9);
    ctx = SW_TX_HDR_OF(payload);
    fw_log_emit3(0x27, 0x1018708, len, (u32)cb, (u32)ctx);
    ctx->len = (u16)len;
    memcpy_fw(ctx->dst, dst, 6);
    ctx->mid = (u16)mid;
    SW_TX_CTX = ctx;
    SW_TX_CB = cb;
    if (conn != 0) {
        fw_log_emit1(0x27, 0x1018750, (u32)conn);
        SW_TX_CID = conn->cid;
        sw_tx_mgmt_link_up_evt(conn, 0);
        return;
    }
    fw_log_emit1(0x27, 0x10187b4, (u32)conn);
    sw_tx_mgmt_acquire_link();
}

/* tx_mgmt_get_ie (0x8e9db0, 82 Б): IE с eid в списке buf (len — байт, сравнения со
 * знаком). *outlen: 0 в начале, при каждом пропуске — оставшаяся длина ДО пропуска.
 * Не нашли — 0 и *outlen = 0.
 * Ошибка vendor (доказательство — 0x8e9dec: brge r13,0x3 не взят → сразу 0x8e9df0, где
 * проверяется только размер): когда остаётся < 3 Б, текущий IE возвращается без сравнения
 * eid — например, последний IE нулевой длины с другим eid. Оставлено как у vendor. */
static u8 *tx_mgmt_get_ie(u8 *buf, u32 len, u32 eid, u8 *outlen)
{
    u32 n;

    if ((s32)len < 2)
        return 0;
    fw_log_emit2(0x2d, 0x100fc64, eid, len);
    *outlen = 0;
    while (buf[0] != eid && (s32)len >= 3) {
        *outlen = (u8)len;
        n = (u32)buf[1] + 2;
        len = (len - n) & 0xffu;
        buf += n;
    }
    if ((s32)len >= (s32)((u32)buf[1] + 2))
        return buf;
    *outlen = 0;
    return 0;
}

/* ie__classify_vendor_oui (0x8e9e04, 184 Б): vendor IE (eid) нужного вида: kind 0 —
 * 00:50:f2 type 4 (WPS), 1 — 50:6f:9a type 9 (P2P), 4 — 00:0f:24 (OUI 5b). Найден —
 * *outlen = длина IE с заголовком.
 * Ошибка vendor: после неподходящего IE поиск продолжается с длиной (u8)(*outlen −
 * размер IE), где *outlen — значение из tx_mgmt_get_ie (0 для первого IE списка, иначе
 * остаток ДО последнего пропуска), а не остаток после найденного IE; при 0 длина
 * становится 256 − размер и поиск идёт за конец списка (0x8e9e78: ldb r1,[r13] / sub /
 * extb). Оставлено как у vendor. */
static u8 *ie_classify_vendor_oui(u8 *buf, u32 len, u32 eid, u32 kind, u8 *outlen)
{
    u8 *ie;
    u32 n;

    if ((s32)len < 2)
        return 0;
    for (;;) {
        ie = tx_mgmt_get_ie(buf, len, eid, outlen);
        if (ie == 0) {
            *outlen = 0;
            return 0;
        }
        if (kind == 0 && ie[2] == 0x00 && ie[3] == 0x50 && ie[4] == 0xf2 && ie[5] == 4) {
            *outlen = (u8)(ie[1] + 2);
            fw_log_emit1(0x2d, 0x100fc84, *outlen);
            return ie;
        }
        if (kind == 1 && ie[2] == 0x50 && ie[3] == 0x6f && ie[4] == 0x9a && ie[5] == 9) {
            *outlen = (u8)(ie[1] + 2);
            fw_log_emit1(0x2d, 0x100fc9c, *outlen);
            return ie;
        }
        n = (u32)ie[1] + 2;
        if (kind == 4 && ie[2] == 0x0f && ie[3] == 0x24 && ie[4] == 0x5b) {
            *outlen = (u8)n;
            fw_log_emit1(0x2d, 0x100fcb4, n & 0xffu);
            return ie;
        }
        len = ((u32)*outlen - n) & 0xffu;
        buf = ie + n;
    }
}

/* Одна IE хоста src (eid) в dst: найдена — копия, счёт total += длина, журнал tok. */
static u32 sm_copy_host_ie(u8 **dst, u8 *src, u32 len8, u32 eid, u8 *ielen, u32 *total, u32 tok)
{
    u8 *ie = tx_mgmt_get_ie(src, len8, eid, ielen);
    if (ie == 0)
        return 0;
    *ielen = (u8)(ie[1] + 2);
    memcpy_fw(*dst, ie, *ielen);
    *dst += *ielen;
    *total = (*total + *ielen) & 0xffffu;
    fw_log_emit2(0x2d, tok, *ielen, *total);
    return 1;
}

/* IE собственного сборщика (длина n) в dst: счёт и журнал tok. */
static void sm_add_own_ie(u8 **dst, u32 n, u8 *ielen, u32 *total, u32 tok)
{
    *ielen = (u8)n;
    *dst += (u8)n;
    *total = (*total + (u8)n) & 0xffffu;
    fw_log_emit2(0x2d, tok, (u8)n, *total);
}

/* Vendor IE хоста вида kind: найден и короче всего списка хоста (brge r2,r16 — со
 * знаком) — копия. */
static void sm_copy_host_vendor_ie(u8 **dst, u8 *src, u32 len8, u32 len, u32 kind, u8 *ielen,
                                   u32 *total, u32 tok)
{
    u8 *ie = ie_classify_vendor_oui(src, len8, 0xdd, kind, ielen);
    if (ie == 0)
        return;
    fw_log_emit2(0x2d, tok, *ielen, *total);
    if ((s32)*ielen >= (s32)len)
        return;
    memcpy_fw(*dst, ie, *ielen);
    *total = (*total + *ielen) & 0xffffu;
    *dst += *ielen;
}

/* mgmt_tx__probe_resp_ies_sm (0x8d8378, 604 Б; в NAMES-EXTRA — mgmt_tx__probe_resp_ies,
 * это имя у нас носит 0x8d7f78): IE probe response из кадра хоста (split MAC). Из IE хоста
 * src (len) берутся SSID (иначе — свой), 7 (Country), 0x30 (RSN), 0x9e; свои — EDCA,
 * DMG Capabilities (mobj+0x5e), 0x97 (mobj+0xf8); vendor IE хоста WPS / P2P / 00:0f:24.
 * Длина списка хоста в поиске — байт (extb r15,r3). WFA vendor IE пишется в dst, но
 * указатель dst после него не двигается (как у vendor). Возврат — суммарная длина. */
static u32 mgmt_tx_probe_resp_ies_sm(u8 *dst, struct mid *e, u8 *src, u32 len)
{
    u8 ielen = 0;                                   /* stb.aw r2,[sp,-36] */
    u8 ssid[32];
    struct mid_bss *mobj = &e->bss;
    u32 len8 = len & 0xffu;
    u32 total = 0, n;

    if (!sm_copy_host_ie(&dst, src, len8, 0, &ielen, &total, 0x100fcd4)) {
        n = mid_copy_ssid(mobj, ssid);
        n = ie_push_ssid(dst, ssid, n & 0xffu);
        sm_add_own_ie(&dst, n, &ielen, &total, 0x100fd14);
    }
    (void)sm_copy_host_ie(&dst, src, len8, 7, &ielen, &total, 0x100fd54);
    (void)sm_copy_host_ie(&dst, src, len8, 0x30, &ielen, &total, 0x100fd94);
    sm_add_own_ie(&dst, ie_push_edca(dst, mobj), &ielen, &total, 0x100fdd0);
    (void)sm_copy_host_ie(&dst, src, len8, 0x9e, &ielen, &total, 0x100fe10);
    sm_add_own_ie(&dst, ie_push_dmg_capabilities(dst, (u8 *)&mobj->dmg_cap, 0), &ielen, &total,
                  0x100fe50);
    sm_add_own_ie(&dst, ie_push_eid151_len10(dst, mobj->blk_f8), &ielen, &total,
                  0x100fe90);
    sm_copy_host_vendor_ie(&dst, src, len8, len, 0, &ielen, &total, 0x100fed0);
    sm_copy_host_vendor_ie(&dst, src, len8, len, 1, &ielen, &total, 0x100ff1c);
    sm_copy_host_vendor_ie(&dst, src, len8, len, 4, &ielen, &total, 0x100ff68);
    n = ie_push_wfa_vendor(dst, e->mac, 0) & 0xffu;
    ielen = (u8)n;
    total = (total + n) & 0xffffu;
    fw_log_emit2(0x2d, 0x100ffbc, n, total);
    return total;
}

/* mgmt_tx__build_fixed_probe_resp (0x8ea0d8, 132 Б): probe response из кадра хоста src
 * (len Б): MAC-заголовок хоста (0x18 Б), свои timestamp/интервал/Capability Info, IE
 * (0x8d8378) из IE хоста (src + 0x24, len − 0x24). Длина — в *lenp. */
static void mgmt_tx_build_fixed_probe_resp(u8 *dst, u16 *lenp, struct mid *e, u8 *src, u32 len)
{
    u8 *p;
    u32 n, total;

    memcpy_fw(dst, src, 0x18);
    p = dst + 0x18;
    src += 0x24;
    len = (len - 0x24) & 0xffffu;
    fw_log_emit3(0x2d, 0x1013cec, 0x18, 0x18, (u32)p);
    n = mgmt_tx_copy_ie_hdr(p, &e->bss);
    p += n;
    total = (n + 0x18) & 0xffffu;
    fw_log_emit3(0x2d, 0x1013d30, n, total, (u32)p);
    n = mgmt_tx_probe_resp_ies_sm(p, e, src, len);
    total = (total + n) & 0xffffu;
    hexdump_words(p, total);
    *lenp = (u16)total;
}

/* mgmt_tx__render_probe_resp (0x8f2b40, 72 Б): probe response хоста (подтип 5) собрать
 * заново во временном буфере TX и скопировать на место payload; *lenp — новая длина.
 * o — объект discovery записи mid. */
static void mgmt_tx_render_probe_resp(struct mid_disc *o, u8 *payload, u16 *lenp)
{
    u32 tmp = TX_API_alloc_tx_payload();
    u16 n = 0;

    mgmt_tx_build_fixed_probe_resp((u8 *)tmp, &n, o->mid, payload, *lenp);
    *lenp = n;
    memcpy_fw(payload, (const void *)tmp, n);
    TX_API_free_memory(tmp);
}

/* mgmt_tx__build_assoc_resp_sm (0x8d8230, 326 Б): тело Assoc Response из кадра хоста
 * (split MAC; src — после MAC-заголовка, len Б): своя Capability Info, status/AID хоста
 * (4 Б), свои IE (EDCA, DMG Capabilities, 0x97), слитые с IE хоста, WFA vendor IE.
 * Длина (u16) — возврат.
 * ХРУПКО: vendor копирует IE хоста (len − 6 Б, при SW_TX_REQ до 1280 − 0x18 − 6) в
 * 256-байтный буфер стека sp+0x100 (memcpy в 0x8d82ba, длина r15 без ограничения) — при
 * длине > 256 затираются блоки IE (sp+0x200) и сохранённые регистры. Здесь блок хоста
 * указывает прямо в кадр хоста (src + 4): кадр живёт до конца слияния, пишется не он,
 * а dst (другой буфер TX), — результат тот же, переполнения нет. */
static u32 mgmt_tx_build_assoc_resp_sm(u8 *dst, struct mid *e, u8 *src, u32 len)
{
    u8 tlv[0x100];
    struct app_ies blk_fw, blk_host;
    struct mid_bss *mobj = &e->bss;
    u32 dstp = (u32)dst;
    u32 n, hdr, aid, m, w;

    n = push_cap_info(dst, mobj->capinfo_b) & 0xffu;
    dstp += n;
    hdr = n;
    src += n;
    len = (len - n) & 0xffffu;
    fw_log_emit3(0x2d, 0x101002c, e->sec.privacy, n, hdr);
    memcpy_fw((void *)dstp, src, 4);
    aid = ((const struct ieee80211_status_aid *)src)->aid;
    dstp += 4;
    hdr = (hdr + 4) & 0xffffu;
    len = (len - 4) & 0xffffu;
    if (len == 0) {                                 /* brlt.d r15,1 (r15 — extw) */
        fw_log_emit0(0x2d, 0x10100bc);
        n = mgmt_tx_assoc_resp_tlv((u8 *)dstp, mobj, aid) & 0xffu;
        dstp += n;
    } else {
        m = mgmt_tx_assoc_resp_tlv(tlv, mobj, aid);
        fw_log_emit1(0x2d, 0x1010084, m);
        app_ies_set_buffer(&blk_fw, tlv, m, 0);
        app_ies_set_buffer(&blk_host, src + 4, len, 0);
        n = ies_block_merge(&dstp, &blk_host, &blk_fw) & 0xffu;
        fw_log_emit1(0x2d, 0x10100b0, n);
    }
    n = (n + hdr) & 0xffffu;
    w = ie_push_wfa_vendor((u8 *)dstp, e->mac, 0) & 0xffu;
    n = (n + w) & 0xffffu;
    fw_log_emit2(0x2d, 0x10100e0, w, n);
    return n;
}

/* handle_packet__args (0x8ea0a0, 54 Б): Assoc Response хоста собрать заново в dst:
 * MAC-заголовок хоста (0x18 Б) + тело (0x8d8230). *lenp (u16) — новая длина. */
static void handle_packet_args(u8 *dst, u16 *lenp, struct mid *e, u8 *src, u32 len)
{
    u32 n;

    memcpy_fw(dst, src, 0x18);
    n = mgmt_tx_build_assoc_resp_sm(dst + 0x18, e, src + 0x18,
                                    (len - 0x18) & 0xffffu);
    *lenp = (u16)(n + 0x18);
}

/* handle_packet_splitmac (0x8f3ba4, 248 Б): split MAC — Assoc Response (подтип 1) и
 * Disassociation (0xa) хоста пиру dst (body). Assoc Response пересобирается своими IE
 * (handle_packet__args), автомату MLME соединения — событие 0xa (payload);
 * Disassociation — событие 0xc. Затем кадр уходит через SW_TX_MGMT.
 * Ошибка vendor: нет соединения с dst или другой подтип — выход без освобождения кадра и
 * без SW_TX_COMPLETE хосту (payload теряется; 0x8f3bdc / 0x8f3be8 → 0x8f3c96). Оставлено
 * как у vendor (sw_tx_req зовёт только с подтипами 1 / 0xa). */
static void handle_packet_splitmac(const struct wmi_sw_tx_req_cmd *cmd, u32 payload, u32 len, u32 mid)
{
    u16 nlen = 0;                                   /* sth.aw r15,[sp,-4] */
    struct mid *e;
    u32 sub, tmp;
    struct conn *conn;

    e = mid_list_by_mid_fw(mid);
    conn = mid_list_find_by(e, cmd->dst_mac);
    if (conn == 0) {
        fw_log_emit2(0x1b, 0x100dcd0, cmd->dst_mac_hi, cmd->dst_mac_lo);
        return;
    }
    sub = (*(u16 *)payload >> 4) & 0xfu;
    if (sub == 1) {
        fw_log_emit0(0x2b, 0x100dd5c);
        tmp = TX_API_alloc_tx_payload();
        handle_packet_args((u8 *)tmp, &nlen, e, (u8 *)payload, len);   /* буферы TX (u32 fwq_tx) */
        len = nlen;
        memcpy_fw((void *)payload, (const void *)tmp, len);
        TX_API_free_memory(tmp);
        mlme_sm_event(&conn->mlme, 0xa, payload, 0, 0);   /* add3 r0,r16,0x1e */
        fw_log_emit2(0x1b, 0x100dd38, cmd->dst_mac_hi, cmd->dst_mac_lo);
        sw_tx_mgmt_send_packet(cmd->dst_mac, mid, payload, len, l2mgr_send_sw_tx_complete);
        return;
    }
    if (sub != 0xa)
        return;
    fw_log_emit0(0x2b, 0x100dd18);
    fw_log_emit2(0x1b, 0x100dd38, cmd->dst_mac_hi, cmd->dst_mac_lo);
    sw_tx_mgmt_send_packet(cmd->dst_mac, mid, payload, len, l2mgr_send_sw_tx_complete);
    mlme_sm_event(&conn->mlme, 0xc, 0, 0, 0);
}

/* send_sw_packet (0x8f8dbc, 148 Б): кадр хоста при идущем скане/поиске или PCP-записи
 * mid: журнал адресов, probe response (подтип 5) пересобирается своими IE; отправка через
 * SW_TX_MGMT. o — объект discovery записи. */
static void send_sw_packet(struct mid_disc *o, const struct wmi_sw_tx_req_cmd *cmd, u32 payload, u32 len,
                           u32 mid)
{
    const u16 *h = (const u16 *)payload;
    u16 n = (u16)len;                               /* sth r3,[sp,20] */

    fw_log_emit2(0x2b, 0x1017018, h[4], ((u32)h[3] << 16) | h[2]);
    fw_log_emit2(0x2b, 0x101705c, h[7], ((u32)h[6] << 16) | h[5]);
    fw_log_emit2(0x2b, 0x10170a0, h[10], ((u32)h[9] << 16) | h[8]);
    if (((h[0] >> 4) & 0xfu) == 5)
        mgmt_tx_render_probe_resp(o, (u8 *)payload, &n);
    fw_log_emit0(0x2c, 0x10170e4);
    sw_tx_mgmt_send_packet(cmd->dst_mac, mid, payload, n, l2mgr_send_sw_tx_complete);
}

/* Идёт скан или поиск (общий вид проверки у vendor, 0x8fbe94..0x8fbecc): s->active ≠ 0;
 * иначе при scan_type ∈ {0, 3} и discovery_mode == 1 — снова active == 1 (здесь всегда 0);
 * затем — discovery (find.active, [o+0x4c]). */
static u32 sw_tx_scan_or_find_active(struct mid_disc *o)
{
    struct scan_mngr *s = o->scan;
    u32 st;

    if (s->active != 0)
        return 1;
    st = s->scan_type;
    if ((st == 0 || st == 3) && s->discovery_mode == 1 && s->active == 1)
        return 1;
    return (o->find.active != 0) ? 1u : 0u;
}

/* wmi_sw_tx_req (0x8fbe18, 354 Б): WMI_SW_TX_REQ {dst_mac[6], len (u16) +6, payload +8}.
 * len > 1280 — SW_TX_COMPLETE (1). Кадр копируется в буфер TX. Скан/поиск или
 * (PCP-запись [e+0x9c] и probe response) — send_sw_packet; split MAC ([0x803c28] == 1)
 * и Assoc Response / Disassociation — handle_packet_splitmac; иначе probe response
 * отбрасывается с SW_TX_COMPLETE (0), прочее — SW_TX_MGMT_API::send_packet.
 * Запись mid vendor на 0 не проверяет. */
void wmi_sw_tx_req(const struct wmi_sw_tx_req_cmd *cmd, u32 mid)
{
    u32 len = cmd->len;
    u32 payload, fc, sub, pcp, probe;
    struct mid *e;
    struct mid_disc *o;

    if ((s32)len > 1280) {
        fw_log_emit0(0x1b, 0x100dd84);
        l2mgr_send_sw_tx_complete(1, mid);
        return;
    }
    payload = TX_API_alloc_tx_payload();
    memcpy_fw((void *)payload, cmd->payload, cmd->len);
    e = mid_list_by_mid_fw(mid);
    fc = *(u16 *)payload;
    pcp = e->bss.is_go;
    sub = (fc >> 4) & 0xfu;
    probe = (sub == 5) ? 1u : 0u;
    fw_log_emit2(0x2b, 0x100dda8, (fc >> 2) & 3u, sub);
    fw_log_emit2(0x2b, 0x100ddd8, pcp, probe);
    o = &e->disc;
    if (sw_tx_scan_or_find_active(o) != 0 || (pcp != 0 && probe != 0)) {
        send_sw_packet(o, cmd, payload, cmd->len, mid);
        return;
    }
    if (dashboard.cfg.ap_sme_offload_mode == 1) {
        fc = *(u16 *)payload;
        sub = (fc >> 4) & 0xfu;
        if (sub == 1 || sub == 0xa) {
            fw_log_emit2(0x2b, 0x100de00, (fc >> 2) & 3u, sub);
            handle_packet_splitmac(cmd, payload, cmd->len, mid);
            return;
        }
    }
    {
        /* volatile: три ldh, как у vendor (без него gcc сливает [0]/[1] в слово) */
        const volatile struct wmi_sw_tx_req_cmd *vc = cmd;
        fw_log_emit2(0x1b, 0x100dd38, vc->dst_mac16[2],
                     ((u32)vc->dst_mac16[1] << 16) | vc->dst_mac16[0]);
    }
    if (((*(u16 *)payload >> 4) & 0xfu) != 5) {
        sw_tx_mgmt_send_packet(cmd->dst_mac, mid, payload, cmd->len,
                               l2mgr_send_sw_tx_complete);
        return;
    }
    fw_log_emit0(0x17, 0x100de38);
    l2mgr_send_sw_tx_complete(0, mid);
    TX_API_free_memory(payload);
}
