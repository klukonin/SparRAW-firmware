// SPDX-License-Identifier: AGPL-3.0-or-later
/* Соединение STA: автомат соединения conn_main_sm (описатель 0x802744, объект conn+0x124)
 * и его окружение — захват линка (mid__connect), бикон/линк-ап, переход к ассоциации.
 *
 * Объект соединения — struct conn (include/conn.h: пул conn_mgr 0x8540c0, 8 × 0x1a0 Б;
 * вложенные lm_if +0x70, автомат MLME +0xf0, conn_main_sm struct conn_msm +0x124 с
 * автоматом разрыва +0x130, резерв +0x164 — автомат FTM только в SparRAW-pro).
 * Состояния conn_main_sm: 0 UNRESOURCED, 1 WAIT_FOR_BCON_RX, 2 WAIT_FOR_LINKUP,
 * 3 READY_FOR_ASSOC, 4 WAIT_FOR_ASSOC_DONE, 5 ASSOCIATED, 6 WAIT_FOR_LM_START, 7 KEY_ASSOC,
 * 8 WAIT_FOR_DISCONN. События: 0 OWN_START_LINK, 1 BCON_RX, 2 NTF_LINKUP, 3 OWN_ASSOC,
 * 4 NTF_ASSOC_START, 5 NTF_ASSOC_DONE, 6 NTF_LM_STARTED, 7 NTF_KEY_INSTALLED, 8 OWN_DISC,
 * 9 NTF_DISC_COMPLETE, 10 —. */
#include "../include/types.h"
#include "../include/mac_parser.h"
#include "../include/rf_sets.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/conn.h"
#include "../include/link_sm.h"
#include "../include/mid.h"
#include "../include/stream.h"
#include "../include/ieee80211.h"
#include "../include/lmac_cmd.h"
#include "../include/fwdata.h"
#include "../include/sys_cfg.h"
#include "../include/sta_max.h"
#include "../include/wmi.h"

/* Шаблон LMAC-команды 0x10 (vendor 0x8014b0; образ: коды управляющих кадров 0x0e/0x0f,
 * stat_shift 0x10, txss_mode/brp_mode 1). Правит wmi_bf_control, шлёт config_lmac_bf_sm. */
FWDATA(8014b0) struct lmac_cmd_bf_ctrl lmac_bf_ctrl_tpl = {
    .w0 = 0, .cid = 0,
    .ctrl_code_tx = 0x0e, .ctrl_code_rx = 0x0f, .ctrl_code_tx_alt = 0x0e, .ctrl_code_rx_alt = 0x0f,
    .stat_shift = 0x10, .txss_mode = 1, .brp_mode = 1, .rsv0f = 0,
};


/* ---------------- мелкие помощники ---------------- */

/* conn__get_cid (0x8cbed0, 8 Б): cid соединения lm_if. */
u32 conn_get_cid(struct lm_if *lm)
{
    return lm->conn->cid;
}

/* conn__get_cid_of_obj (0x8cbeb8, 8 Б): cid линка записи lm_sm. */
u32 conn_get_cid_of_obj(struct lm_sm *l)
{
    return conn_get_cid(l->lm);
}

/* conn__get_radio_ctx_byte10 (0x8cc414, 8 Б): номер mid соединения lm_if. */
u32 conn_get_mid_idx(struct lm_if *lm)
{
    return lm->conn->mid->id;
}

/* maintain_sm__get_mid_idx (0x8cc3d4, 8 Б): то же для записи lm_sm. */
u32 lm_sm_get_mid_idx(struct lm_sm *l)
{
    return conn_get_mid_idx(l->lm);
}


/* maintain_ctx__set_field_9c (0x8ea9c8 → 0x8ea9c0, 12 Б): режим линк-менеджера
 * (lm_sm.lm_mode). */
void maintain_ctx_set_field_9c(struct lm_if *lm, u32 v)
{
    lm->lm_sm->lm_mode = v;
}

/* lmac_if_trigger_bf (0x8dc228, 52 Б): LMAC-команда 9 {1, a1, cid} — запуск BF к cid. */
void lmac_if_trigger_bf(u32 cid, u32 a1)
{
    struct lmac_cmd_trigger_bf *b;
    fw_log_emit2(0x20, 0x100498c, cid, a1);
    b = lmac_cmd_pool_alloc();
    b->kind = 1;
    b->arg = a1;
    b->cid = cid;
    lmac_if_post_cmd(b, 9, 0xc, 0);
}

/* lm_main_sm::config_lmac_bf_sm (0x8c6fbc, 68 Б): LMAC-команда 0x10 (0x10 Б): шаблон
 * lmac_bf_ctrl_tpl (0x8014b0), w0 = a1, cid — линка lm_sm. */
void lm_main_sm_config_lmac_bf_sm(struct lm_sm *l, u32 a1)
{
    struct lmac_cmd_bf_ctrl *b = lmac_cmd_pool_alloc();
    memcpy_fw(b, &lmac_bf_ctrl_tpl, 0x10);
    b->w0 = a1;
    b->cid = conn_get_cid(l->lm);
    fw_log_emit1(0x20, 0x101475c, b->cid);
    lmac_if_post_cmd(b, 0x10, 0x10, 0);
}

/* rx_macq__program_desc_for_conn (0x8e7690 → 0x8df968, 24 + 60 Б): правило MAC-парсера
 * для cid: MAC пира, поле 5 бит = 0x1f при [0x800478] != 0, бит 0 — «правило
 * действительно». ХРУПКО: у vendor полуслово правила [sp+6] на стеке не инициализировано
 * (bits__set16h_s4_w5 меняет только биты 4..8, затем bset бит 0) — остальные биты уходят
 * в 0x886284 мусором стека; здесь они 0. */
void rx_macq_program_desc_for_conn(struct conn *conn)
{
    struct prs_rule buf;
    const u8 *mac = conn->peer;
    buf.h[0] = (u16)(mac[0] | mac[1] << 8);
    buf.h[1] = (u16)(mac[2] | mac[3] << 8);
    buf.h[2] = (u16)(mac[4] | mac[5] << 8);
    buf.h[3] = 0;
    bits_set16h_s4_w5(&buf.h[3], (mac_parser_rule_f5_en != 0) ? 0x1fu : 0u);
    buf.h[3] |= 1u;
    mac_parser_pack_rule_halfword(&buf, conn->cid);
}

/* conn_mgr__ranking_remove (0x8ca6fc, 100 Б; переход 0x8e7978): убрать соединение из
 * списка ранжирования (элемент — в пул rank_pool). 1 — было в списке. */
u32 conn_mgr_ranking_remove(struct conn *conn)
{
    u32 it;
    struct conn_rank *e;
    iter_init(&it, &conn_mgr.rank_list);
    while (list_has_items(&it)) {
        e = (struct conn_rank *)iter_next(&it);
        if (e->conn == conn) {
            tx_list_remove(&conn_mgr.rank_list, e);
            e->conn = 0;
            stream_mgr_check_vring(&conn_mgr.rank_pool, e);
            fw_log_emit1(0x2b, 0x100be68, conn->cid);
            return 1;
        }
    }
    return 0;
}

/* ---------------- линк-ап ---------------- */

/* conn::linkup_ntf (0x8dae44, 48 Б): NTF_LINKUP (2) автомату соединения. */
void conn_linkup_ntf(struct conn *conn, u32 v)
{
    fw_log_emit1(0x2d, 0x1010348, v);
    conn_msm_event(&conn->msm, 2, v, 0, 0);
}

/* lm__notify_linkup (0x8dae74, 16 Б): conn::linkup_ntf(владелец lm_if, v != 0). */
void lm_notify_linkup(struct lm_if *lm, u32 v)
{
    conn_linkup_ntf(lm->conn, v != 0);
}

/* lm_if__on_linkup_ready (0x8dae84, 84 Б): на FPGA — сразу линк-ап; иначе событие 0
 * (LINKUP_REQ) линк-менеджеру; свежий (< 2000 тиков u_schd) снимок BF передаётся
 * аргументом. */
void lm_if_on_linkup_ready(struct lm_if *lm)
{
    u32 now;
    if (platform_is_fpga()) {
        lm_notify_linkup(lm, 0);
        return;
    }
    if (lm->lm_sm == 0)
        fw_sysassert_fatal((void *)0, 0x125f);
    now = u_schd_now();
    if (now - lm->snap_time < 2000)
        lm_sm_event(lm->lm_sm, 0, (u32)&lm->snap, 0, 0);
    else
        lm_sm_event(lm->lm_sm, 0, 0, 0, 0);
}

/* (0x8ddba4, 16 Б; у vendor ещё переход 0x8cae6c, задача числом 0xae6c): NTF_LM_STARTED
 * (6) автомату соединения a0. */
void conn_post_lm_started(u32 a0, u32 a1)
{
    struct conn *conn = (struct conn *)a0;
    (void)a1;
    conn_msm_event(&conn->msm, 6, 0, 0, 0);
}

/* lm_sm__post_evt6_via_owner (0x8ddbb4, 8 Б). */
void lm_sm_post_evt6_via_owner(struct lm_if *lm)
{
    conn_post_lm_started((u32)lm->conn, 0);
}

/* conn_main_sm__action_step_b (0x8ddb18, 64 Б): запуск линк-менеджера после ассоциации —
 * событие 5 (START_MAINTAIN_REQ) lm_sm; на FPGA — сразу NTF_LM_STARTED задачей. */
void conn_main_sm_action_step_b(struct lm_if *lm)
{
    if (platform_is_fpga()) {
        u_schd_add(conn_post_lm_started, (u32)lm->conn, 0, 1);
        return;
    }
    if (lm->lm_sm == 0)
        fw_sysassert_fatal((void *)0, 0x1260);
    lm_sm_event(lm->lm_sm, 5, 0, 0, 0);
}

/* find_sm__on_link_up (0x8c48c4, 52 Б): при активном поиске (find_mngr active) —
 * событие 5 автомату поиска. */
void find_sm_on_link_up(struct find_mngr *f, struct conn *conn, u32 v)
{
    if (f->active == 0)
        return;
    fw_log_emit0(0x2c, 0x1017960);
    basic_sm_handle_event(&f->sm, 5, (u32)conn, v, 0);
}

/* scan_mngr::handle_link_up_event (0x8cd790, 212 Б): линк к BSS, найденному сканом
 * (автомат каналов в DWELLING): запись кандидата по MAC пира; при пробе в ходе (1/2) —
 * привязать соединение и завершить пробу (v == 1, успех) или послать probe req. */
void scan_mngr_handle_link_up_event(struct scan_mngr *scan, struct conn *conn, u32 v)
{
    struct dband_info *e;
    u32 st;
    if (scan->dwell_stopped != 0)
        return;
    fw_log_emit2(0x29, 0x10161ec, scan->cs->hdr.state, scan->active_probs);
    if (scan->cs->hdr.state != CS_ST_DWELLING)
        return;
    if (conn == 0)
        fw_sysassert_fatal((void *)0, 0x1249);
    fw_log_emit2(0x29, 0x1016234, conn->peer_hi, conn->peer_lo);
    e = find_main_sm_bcon_step(&scan->pend, conn->peer);
    if (e == 0) {
        fw_log_emit0(0x29, 0x101634c);
        return;
    }
    fw_log_emit1(0x29, 0x1016278, e->status);
    fw_log_emit2(0x29, 0x10162b4, (u32)e->conn, (u32)conn);
    st = e->status;
    if (st != DBAND_ST_NEW && st != DBAND_ST_ABFT)
        return;
    e->conn = conn;
    if (v == 1) {
        if (st != 1)
            return;
        fw_log_emit1(0x29, 0x1016304, conn->cid);
        scan_mngr_prob_done(scan, 2, e);
    } else {
        scan_mngr_send_prob_req(scan, e);
    }
}

/* l2mgr__notify_link_up (0x8cd76c, 36 Б): o — объект discovery записи mid (e+0x234). */
void l2mgr_notify_link_up(struct mid_disc *o, struct conn *conn, u32 v)
{
    scan_mngr_handle_link_up_event(o->scan, conn, v);
    find_sm_on_link_up(&o->find, conn, v);
}

/* conn__notify_link_via_l2mgr (0x8dace4, 8 Б): mid — запись mid соединения. */
void conn_notify_link_via_l2mgr(struct mid *mid, struct conn *conn, u32 v)
{
    l2mgr_notify_link_up(&mid->disc, conn, v);
}


/* conn_mgr::link_up_evt (0x8dad1c, 52 Б): линк поднят (v == 0) — в список ранжирования,
 * иначе — вон из списка и разрыв. */
void conn_mgr_link_up_evt(struct conn *conn, u32 v)
{
    fw_log_emit3(0x2b, 0x100be90, (u32)conn, v, conn->initiator);
    if (v == 0) {
        conn_mgr_add_to_rinking_list(conn);
    } else {
        conn_mgr_link_down_evt(conn);             /* убирает и из списка ранжирования */
    }
}

/* НЕ vendor: уточнение причины разрыва для хоста по cid (enum wmi_sparraw_disc_reason; 0 — нет). Ставит
 * источник отказа (остаётся первая причина), забирает mlme_sm_disconnect_ev_handle → disconnect_reason
 * события; сброс — новое соединение и повторный поиск того же пира (scan_mngr.c). Свободный промежуток DCCM
 * 0x806920..0x8069ff (tx_power.c, wmi_cmd.c). */
FWDATA(806950) volatile u8 conn_disc_detail[SPARRAW_STA_SLOTS] = { 0 };

void conn_disc_detail_set(u32 cid, u32 detail)
{
    if (cid < SPARRAW_STA_SLOTS && conn_disc_detail[cid] == 0)
        conn_disc_detail[cid] = (u8)detail;
}

u32 conn_disc_detail_take(u32 cid)
{
    u32 d;
    if (cid >= SPARRAW_STA_SLOTS)
        return 0;
    d = conn_disc_detail[cid];
    conn_disc_detail[cid] = 0;
    return d;
}

/* Все соединения записи mid (разрыв по сбою железа — vring_schd_disconnect_notify). */
void conn_disc_detail_set_mid(struct mid *mid, u32 detail)
{
    u32 it;
    iter_init(&it, &mid->conns);
    while (list_has_items(&it))
        conn_disc_detail_set(((struct conn *)iter_next(&it))->cid, detail);
}

/* Задача линк-апа (0x8f5e0c, 96 Б; conn_main_sm__linkup_ntf ставит её числом 0x35e0c):
 * a0 — соединение, v — 0 линк есть, 1 — нет. Инициатор без линка — разрыв MLME
 * (0x10002); иначе уведомить скан/поиск, SW TX и менеджер соединений (инициатор). */
void conn_link_up_task(u32 a0, u32 v)
{
    struct conn *conn = (struct conn *)a0;
    u32 init = conn->initiator;
    fw_log_emit3(0x2b, 0x100d364, v, conn->cid, (u32)conn);
    if (v == 1 && init != 0) {
        mlme_sm_disconnect_ev_handle((u32)conn, 0x10002);
        return;
    }
    conn_notify_link_via_l2mgr(conn->mid, conn, v);
    sw_tx_mgmt_link_up_evt(conn, v);
    if (init != 0)
        conn_mgr_link_up_evt(conn, v);
}

/* ---------------- ожидание бикона ---------------- */

/* conn_main_sm__bcon_rx_timeout_evt (0x8c4808, 140 Б; таймер числом 0x4808): бикон пира не
 * пришёл (a0 — автомат). Попытки < [0x85773c] и RX-сектор не выбран — следующий RX-сектор
 * и повтор таймера; иначе BCON_RX (1) с a0 = 0 — «бикона нет». */
void conn_main_sm_bcon_rx_timeout_evt(u32 a0, u32 a1)
{
    struct conn_msm *sm = (struct conn_msm *)a0;
    struct conn *conn;
    u32 n;
    (void)a1;
    fw_log_emit1(0x2b, 0x1011b64, sm->bcon_tries);
    n = (u8)(sm->bcon_tries + 1);
    sm->bcon_tries = (u8)n;
    conn = sm->conn;
    if ((s32)n < (s32)fwsh_sets.n_sec[1][0] && conn->rx_sector == 0xffff) {
        hw_sysapi_rx_omni_sector_set(n);
        sm->bcon_timer = u_schd_schedule(conn_main_sm_bcon_rx_timeout_evt, (u32)sm, 0, 1,
                                         (conn_multi_omni_count + 1) * 300000u, 0, 0);
        return;
    }
    fw_log_emit0(0x1b, 0x1011ba0);
    sm->bcon_timer = 0;
    conn_disc_detail_set(conn->cid, WMI_SPARRAW_DISC_LINKUP_NO_BEACON);
    conn_msm_event(sm, 1, 0, 0, 0);
}

/* conn_msm__check_field_2c (0x8e6308, 80 Б): (пере)взвести таймер ожидания бикона:
 * 500 мс при [0x800231] ≤ 1, иначе ([0x800231] + 1) × 300 мс; счётчик попыток — 0. */
void conn_msm_arm_bcon_timer(struct conn_msm *sm)
{
    u32 n, delay;
    if (sm->bcon_timer != 0) {
        u_schd_cancel(sm->bcon_timer);
        sm->bcon_timer = 0;
    }
    sm->bcon_tries = 0;
    n = conn_multi_omni_count;
    delay = ((s32)n <= 1) ? 500000u : (n + 1) * 300000u;
    sm->bcon_timer = u_schd_schedule(conn_main_sm_bcon_rx_timeout_evt, (u32)sm, 0, 1,
                                     delay, 0, 0);
}

/* ---------------- действия conn_main_sm ---------------- */

/* conn_msm__on_own_start_link__ready_for_assoc (0x8e2aac, 32 Б; OWN_START_LINK в
 * WAIT_FOR_BCON_RX / WAIT_FOR_LINKUP / READY_FOR_ASSOC): ждать бикон пира (таймер), если
 * a1 != 0 и [0x800304] == 0; иначе сразу BCON_RX (a0 = 1 — «бикон есть»). */
void conn_msm_on_own_start_link(struct conn_msm *sm, u32 a0, u32 a1)
{
    (void)a0;
    if (conn_skip_bcon_wait == 0 && a1 != 0)
        conn_msm_arm_bcon_timer(sm);
    else
        conn_msm_defer(sm, 1, 1, 0, 0);
}

/* автомат соединения conn_main_sm: таблица 0x802554, описатель 0x802744 */
/* 0x802554: таблица переходов [событие][состояние] (11 × 9). */
FWDATA(802554) const struct sm_trans conn_msm_table[11][9] = {
    [CONN_MSM_EV_OWN_START_LINK][CONN_MSM_UNRESOURCED] = { SM_ACT(conn_msm_on_own_start_link_unres), CONN_MSM_WAIT_FOR_BCON_RX },
    [CONN_MSM_EV_OWN_START_LINK][CONN_MSM_WAIT_FOR_BCON_RX] = { SM_ACT(conn_msm_on_own_start_link), CONN_MSM_WAIT_FOR_BCON_RX },
    [CONN_MSM_EV_OWN_START_LINK][CONN_MSM_WAIT_FOR_LINKUP] = { SM_ACT(conn_msm_on_own_start_link), CONN_MSM_WAIT_FOR_BCON_RX },
    [CONN_MSM_EV_OWN_START_LINK][CONN_MSM_READY_FOR_ASSOC] = { SM_ACT(conn_msm_on_own_start_link), CONN_MSM_WAIT_FOR_BCON_RX },
    [CONN_MSM_EV_OWN_START_LINK][CONN_MSM_WAIT_FOR_ASSOC_DONE] = { SM_ACT(sm_action_nop_b), CONN_MSM_WAIT_FOR_ASSOC_DONE },
    [CONN_MSM_EV_OWN_START_LINK][CONN_MSM_ASSOCIATED] = { SM_ACT(sm_action_nop_b), CONN_MSM_ASSOCIATED },
    [CONN_MSM_EV_OWN_START_LINK][CONN_MSM_WAIT_FOR_LM_START] = { SM_ACT(sm_action_nop_b), CONN_MSM_WAIT_FOR_LM_START },
    [CONN_MSM_EV_OWN_START_LINK][CONN_MSM_KEY_ASSOC] = { SM_ACT(sm_action_nop_b), CONN_MSM_KEY_ASSOC },
    [CONN_MSM_EV_OWN_START_LINK][CONN_MSM_WAIT_FOR_DISCONN] = { SM_ACT(sm_action_nop_b), CONN_MSM_WAIT_FOR_DISCONN },
    [CONN_MSM_EV_BCON_RX][CONN_MSM_UNRESOURCED] = { SM_ACT(conn_msm_log_state), CONN_MSM_UNRESOURCED },
    [CONN_MSM_EV_BCON_RX][CONN_MSM_WAIT_FOR_BCON_RX] = { SM_ACT(conn_msm_on_bcon_rx), CONN_MSM_WAIT_FOR_LINKUP },
    [CONN_MSM_EV_BCON_RX][CONN_MSM_WAIT_FOR_LINKUP] = { SM_ACT(sm_action_nop_b), CONN_MSM_WAIT_FOR_LINKUP },
    [CONN_MSM_EV_BCON_RX][CONN_MSM_READY_FOR_ASSOC] = { SM_ACT(sm_action_nop_b), CONN_MSM_READY_FOR_ASSOC },
    [CONN_MSM_EV_BCON_RX][CONN_MSM_WAIT_FOR_ASSOC_DONE] = { SM_ACT(sm_action_nop_b), CONN_MSM_WAIT_FOR_ASSOC_DONE },
    [CONN_MSM_EV_BCON_RX][CONN_MSM_ASSOCIATED] = { SM_ACT(sm_action_nop_b), CONN_MSM_ASSOCIATED },
    [CONN_MSM_EV_BCON_RX][CONN_MSM_WAIT_FOR_LM_START] = { SM_ACT(sm_action_nop_b), CONN_MSM_WAIT_FOR_LM_START },
    [CONN_MSM_EV_BCON_RX][CONN_MSM_KEY_ASSOC] = { SM_ACT(conn_msm_on_bcon_rx_key_assoc), CONN_MSM_KEY_ASSOC },
    [CONN_MSM_EV_BCON_RX][CONN_MSM_WAIT_FOR_DISCONN] = { SM_ACT(sm_action_nop_b), CONN_MSM_WAIT_FOR_DISCONN },
    [CONN_MSM_EV_NTF_LINKUP][CONN_MSM_UNRESOURCED] = { SM_ACT(sm_action_nop_b), CONN_MSM_UNRESOURCED },
    [CONN_MSM_EV_NTF_LINKUP][CONN_MSM_WAIT_FOR_BCON_RX] = { SM_ACT(sm_action_nop_b), CONN_MSM_WAIT_FOR_BCON_RX },
    [CONN_MSM_EV_NTF_LINKUP][CONN_MSM_WAIT_FOR_LINKUP] = { SM_ACT(conn_main_sm_linkup_ntf), CONN_MSM_READY_FOR_ASSOC },
    [CONN_MSM_EV_NTF_LINKUP][CONN_MSM_READY_FOR_ASSOC] = { SM_ACT(conn_msm_on_linkup_ready), CONN_MSM_READY_FOR_ASSOC },
    [CONN_MSM_EV_NTF_LINKUP][CONN_MSM_WAIT_FOR_ASSOC_DONE] = { SM_ACT(sm_action_nop_b), CONN_MSM_WAIT_FOR_ASSOC_DONE },
    [CONN_MSM_EV_NTF_LINKUP][CONN_MSM_ASSOCIATED] = { SM_ACT(sm_action_nop_b), CONN_MSM_ASSOCIATED },
    [CONN_MSM_EV_NTF_LINKUP][CONN_MSM_WAIT_FOR_LM_START] = { SM_ACT(sm_action_nop_b), CONN_MSM_WAIT_FOR_LM_START },
    [CONN_MSM_EV_NTF_LINKUP][CONN_MSM_KEY_ASSOC] = { SM_ACT(sm_action_nop_b), CONN_MSM_KEY_ASSOC },
    [CONN_MSM_EV_NTF_LINKUP][CONN_MSM_WAIT_FOR_DISCONN] = { SM_ACT(sm_action_nop_b), CONN_MSM_WAIT_FOR_DISCONN },
    [CONN_MSM_EV_OWN_ASSOC][CONN_MSM_UNRESOURCED] = { SM_ACT(sm_action_nop_b), CONN_MSM_UNRESOURCED },
    [CONN_MSM_EV_OWN_ASSOC][CONN_MSM_WAIT_FOR_BCON_RX] = { SM_ACT(sm_action_nop_b), CONN_MSM_WAIT_FOR_BCON_RX },
    [CONN_MSM_EV_OWN_ASSOC][CONN_MSM_WAIT_FOR_LINKUP] = { SM_ACT(sm_action_nop_b), CONN_MSM_WAIT_FOR_LINKUP },
    [CONN_MSM_EV_OWN_ASSOC][CONN_MSM_READY_FOR_ASSOC] = { SM_ACT(conn_msm_on_own_assoc), CONN_MSM_WAIT_FOR_ASSOC_DONE },
    [CONN_MSM_EV_OWN_ASSOC][CONN_MSM_WAIT_FOR_ASSOC_DONE] = { SM_ACT(sm_action_nop_b), CONN_MSM_WAIT_FOR_ASSOC_DONE },
    [CONN_MSM_EV_OWN_ASSOC][CONN_MSM_ASSOCIATED] = { SM_ACT(sm_action_nop_b), CONN_MSM_ASSOCIATED },
    [CONN_MSM_EV_OWN_ASSOC][CONN_MSM_WAIT_FOR_LM_START] = { SM_ACT(sm_action_nop_b), CONN_MSM_WAIT_FOR_LM_START },
    [CONN_MSM_EV_OWN_ASSOC][CONN_MSM_KEY_ASSOC] = { SM_ACT(sm_action_nop_b), CONN_MSM_KEY_ASSOC },
    [CONN_MSM_EV_OWN_ASSOC][CONN_MSM_WAIT_FOR_DISCONN] = { SM_ACT(sm_action_nop_b), CONN_MSM_WAIT_FOR_DISCONN },
    [CONN_MSM_EV_NTF_ASSOC_START][CONN_MSM_UNRESOURCED] = { SM_ACT(basic_sm_error_handler), CONN_MSM_UNRESOURCED },
    [CONN_MSM_EV_NTF_ASSOC_START][CONN_MSM_WAIT_FOR_BCON_RX] = { SM_ACT(basic_sm_error_handler), CONN_MSM_WAIT_FOR_BCON_RX },
    [CONN_MSM_EV_NTF_ASSOC_START][CONN_MSM_WAIT_FOR_LINKUP] = { SM_ACT(basic_sm_error_handler), CONN_MSM_WAIT_FOR_LINKUP },
    [CONN_MSM_EV_NTF_ASSOC_START][CONN_MSM_READY_FOR_ASSOC] = { SM_ACT(conn_msm_on_assoc_done), CONN_MSM_WAIT_FOR_ASSOC_DONE },
    [CONN_MSM_EV_NTF_ASSOC_START][CONN_MSM_WAIT_FOR_ASSOC_DONE] = { SM_ACT(sm_action_nop_b), CONN_MSM_WAIT_FOR_ASSOC_DONE },
    [CONN_MSM_EV_NTF_ASSOC_START][CONN_MSM_ASSOCIATED] = { SM_ACT(basic_sm_error_handler), CONN_MSM_ASSOCIATED },
    [CONN_MSM_EV_NTF_ASSOC_START][CONN_MSM_WAIT_FOR_LM_START] = { SM_ACT(basic_sm_error_handler), CONN_MSM_WAIT_FOR_LM_START },
    [CONN_MSM_EV_NTF_ASSOC_START][CONN_MSM_KEY_ASSOC] = { SM_ACT(basic_sm_error_handler), CONN_MSM_KEY_ASSOC },
    [CONN_MSM_EV_NTF_ASSOC_START][CONN_MSM_WAIT_FOR_DISCONN] = { SM_ACT(basic_sm_error_handler), CONN_MSM_WAIT_FOR_DISCONN },
    [CONN_MSM_EV_NTF_ASSOC_DONE][CONN_MSM_UNRESOURCED] = { SM_ACT(basic_sm_error_handler), CONN_MSM_UNRESOURCED },
    [CONN_MSM_EV_NTF_ASSOC_DONE][CONN_MSM_WAIT_FOR_BCON_RX] = { SM_ACT(basic_sm_error_handler), CONN_MSM_WAIT_FOR_BCON_RX },
    [CONN_MSM_EV_NTF_ASSOC_DONE][CONN_MSM_WAIT_FOR_LINKUP] = { SM_ACT(conn_msm_on_assoc_done), CONN_MSM_WAIT_FOR_LM_START },
    [CONN_MSM_EV_NTF_ASSOC_DONE][CONN_MSM_READY_FOR_ASSOC] = { SM_ACT(conn_msm_on_assoc_done), CONN_MSM_WAIT_FOR_LM_START },
    [CONN_MSM_EV_NTF_ASSOC_DONE][CONN_MSM_WAIT_FOR_ASSOC_DONE] = { SM_ACT(conn_msm_on_assoc_done), CONN_MSM_WAIT_FOR_LM_START },
    [CONN_MSM_EV_NTF_ASSOC_DONE][CONN_MSM_ASSOCIATED] = { SM_ACT(sm_action_nop_b), CONN_MSM_ASSOCIATED },
    [CONN_MSM_EV_NTF_ASSOC_DONE][CONN_MSM_WAIT_FOR_LM_START] = { SM_ACT(sm_action_nop_b), CONN_MSM_WAIT_FOR_LM_START },
    [CONN_MSM_EV_NTF_ASSOC_DONE][CONN_MSM_KEY_ASSOC] = { SM_ACT(sm_action_nop_b), CONN_MSM_KEY_ASSOC },
    [CONN_MSM_EV_NTF_ASSOC_DONE][CONN_MSM_WAIT_FOR_DISCONN] = { SM_ACT(sm_action_nop_b), CONN_MSM_WAIT_FOR_DISCONN },
    [CONN_MSM_EV_NTF_LM_STARTED][CONN_MSM_UNRESOURCED] = { SM_ACT(basic_sm_error_handler), CONN_MSM_UNRESOURCED },
    [CONN_MSM_EV_NTF_LM_STARTED][CONN_MSM_WAIT_FOR_BCON_RX] = { SM_ACT(basic_sm_error_handler), CONN_MSM_WAIT_FOR_BCON_RX },
    [CONN_MSM_EV_NTF_LM_STARTED][CONN_MSM_WAIT_FOR_LINKUP] = { SM_ACT(basic_sm_error_handler), CONN_MSM_WAIT_FOR_LINKUP },
    [CONN_MSM_EV_NTF_LM_STARTED][CONN_MSM_READY_FOR_ASSOC] = { SM_ACT(basic_sm_error_handler), CONN_MSM_READY_FOR_ASSOC },
    [CONN_MSM_EV_NTF_LM_STARTED][CONN_MSM_WAIT_FOR_ASSOC_DONE] = { SM_ACT(conn_msm_on_lm_started_early), CONN_MSM_WAIT_FOR_ASSOC_DONE },
    [CONN_MSM_EV_NTF_LM_STARTED][CONN_MSM_ASSOCIATED] = { SM_ACT(basic_sm_error_handler), CONN_MSM_ASSOCIATED },
    [CONN_MSM_EV_NTF_LM_STARTED][CONN_MSM_WAIT_FOR_LM_START] = { SM_ACT(conn_msm_on_lm_started), CONN_MSM_ASSOCIATED },
    [CONN_MSM_EV_NTF_LM_STARTED][CONN_MSM_KEY_ASSOC] = { SM_ACT(basic_sm_error_handler), CONN_MSM_KEY_ASSOC },
    [CONN_MSM_EV_NTF_LM_STARTED][CONN_MSM_WAIT_FOR_DISCONN] = { SM_ACT(sm_action_nop_b), CONN_MSM_WAIT_FOR_DISCONN },
    [CONN_MSM_EV_NTF_KEY_INSTALLED][CONN_MSM_UNRESOURCED] = { SM_ACT(basic_sm_error_handler), CONN_MSM_UNRESOURCED },
    [CONN_MSM_EV_NTF_KEY_INSTALLED][CONN_MSM_WAIT_FOR_BCON_RX] = { SM_ACT(basic_sm_error_handler), CONN_MSM_WAIT_FOR_BCON_RX },
    [CONN_MSM_EV_NTF_KEY_INSTALLED][CONN_MSM_WAIT_FOR_LINKUP] = { SM_ACT(basic_sm_error_handler), CONN_MSM_WAIT_FOR_LINKUP },
    [CONN_MSM_EV_NTF_KEY_INSTALLED][CONN_MSM_READY_FOR_ASSOC] = { SM_ACT(basic_sm_error_handler), CONN_MSM_READY_FOR_ASSOC },
    [CONN_MSM_EV_NTF_KEY_INSTALLED][CONN_MSM_WAIT_FOR_ASSOC_DONE] = { SM_ACT(basic_sm_error_handler), CONN_MSM_WAIT_FOR_ASSOC_DONE },
    [CONN_MSM_EV_NTF_KEY_INSTALLED][CONN_MSM_ASSOCIATED] = { SM_ACT(conn_msm_on_key_installed), CONN_MSM_KEY_ASSOC },
    [CONN_MSM_EV_NTF_KEY_INSTALLED][CONN_MSM_WAIT_FOR_LM_START] = { SM_ACT(basic_sm_error_handler), CONN_MSM_WAIT_FOR_LM_START },
    [CONN_MSM_EV_NTF_KEY_INSTALLED][CONN_MSM_KEY_ASSOC] = { SM_ACT(sm_action_nop_b), CONN_MSM_KEY_ASSOC },
    [CONN_MSM_EV_NTF_KEY_INSTALLED][CONN_MSM_WAIT_FOR_DISCONN] = { SM_ACT(sm_action_nop_b), CONN_MSM_WAIT_FOR_DISCONN },
    [CONN_MSM_EV_OWN_DISC][CONN_MSM_UNRESOURCED] = { SM_ACT(conn_main_sm_start_disc), CONN_MSM_WAIT_FOR_DISCONN },
    [CONN_MSM_EV_OWN_DISC][CONN_MSM_WAIT_FOR_BCON_RX] = { SM_ACT(conn_main_sm_start_disc), CONN_MSM_WAIT_FOR_DISCONN },
    [CONN_MSM_EV_OWN_DISC][CONN_MSM_WAIT_FOR_LINKUP] = { SM_ACT(conn_main_sm_start_disc), CONN_MSM_WAIT_FOR_DISCONN },
    [CONN_MSM_EV_OWN_DISC][CONN_MSM_READY_FOR_ASSOC] = { SM_ACT(conn_msm_log_state), CONN_MSM_READY_FOR_ASSOC },
    [CONN_MSM_EV_OWN_DISC][CONN_MSM_WAIT_FOR_ASSOC_DONE] = { SM_ACT(conn_main_sm_start_disc), CONN_MSM_WAIT_FOR_DISCONN },
    [CONN_MSM_EV_OWN_DISC][CONN_MSM_ASSOCIATED] = { SM_ACT(conn_main_sm_start_disc), CONN_MSM_WAIT_FOR_DISCONN },
    [CONN_MSM_EV_OWN_DISC][CONN_MSM_WAIT_FOR_LM_START] = { SM_ACT(conn_main_sm_start_disc), CONN_MSM_WAIT_FOR_DISCONN },
    [CONN_MSM_EV_OWN_DISC][CONN_MSM_KEY_ASSOC] = { SM_ACT(conn_main_sm_start_disc), CONN_MSM_WAIT_FOR_DISCONN },
    [CONN_MSM_EV_OWN_DISC][CONN_MSM_WAIT_FOR_DISCONN] = { SM_ACT(conn_msm_log_state), CONN_MSM_WAIT_FOR_DISCONN },
    [CONN_MSM_EV_NTF_DISC_COMPLETE][CONN_MSM_UNRESOURCED] = { SM_ACT(basic_sm_error_handler), CONN_MSM_UNRESOURCED },
    [CONN_MSM_EV_NTF_DISC_COMPLETE][CONN_MSM_WAIT_FOR_BCON_RX] = { SM_ACT(basic_sm_error_handler), CONN_MSM_WAIT_FOR_BCON_RX },
    [CONN_MSM_EV_NTF_DISC_COMPLETE][CONN_MSM_WAIT_FOR_LINKUP] = { SM_ACT(basic_sm_error_handler), CONN_MSM_WAIT_FOR_LINKUP },
    [CONN_MSM_EV_NTF_DISC_COMPLETE][CONN_MSM_READY_FOR_ASSOC] = { SM_ACT(basic_sm_error_handler), CONN_MSM_READY_FOR_ASSOC },
    [CONN_MSM_EV_NTF_DISC_COMPLETE][CONN_MSM_WAIT_FOR_ASSOC_DONE] = { SM_ACT(basic_sm_error_handler), CONN_MSM_WAIT_FOR_ASSOC_DONE },
    [CONN_MSM_EV_NTF_DISC_COMPLETE][CONN_MSM_ASSOCIATED] = { SM_ACT(basic_sm_error_handler), CONN_MSM_ASSOCIATED },
    [CONN_MSM_EV_NTF_DISC_COMPLETE][CONN_MSM_WAIT_FOR_LM_START] = { SM_ACT(basic_sm_error_handler), CONN_MSM_WAIT_FOR_LM_START },
    [CONN_MSM_EV_NTF_DISC_COMPLETE][CONN_MSM_KEY_ASSOC] = { SM_ACT(basic_sm_error_handler), CONN_MSM_KEY_ASSOC },
    [CONN_MSM_EV_NTF_DISC_COMPLETE][CONN_MSM_WAIT_FOR_DISCONN] = { SM_ACT(conn_msm_on_disc_complete), CONN_MSM_READY_FOR_ASSOC },
    [CONN_MSM_EV_OWN_ABORT][CONN_MSM_UNRESOURCED] = { SM_ACT(sm_action_nop_b), CONN_MSM_UNRESOURCED },
    [CONN_MSM_EV_OWN_ABORT][CONN_MSM_WAIT_FOR_BCON_RX] = { SM_ACT(basic_sm_error_handler), CONN_MSM_WAIT_FOR_BCON_RX },
    [CONN_MSM_EV_OWN_ABORT][CONN_MSM_WAIT_FOR_LINKUP] = { SM_ACT(sm_action_nop_b), CONN_MSM_UNRESOURCED },
    [CONN_MSM_EV_OWN_ABORT][CONN_MSM_READY_FOR_ASSOC] = { SM_ACT(sm_action_nop_b), CONN_MSM_UNRESOURCED },
    [CONN_MSM_EV_OWN_ABORT][CONN_MSM_WAIT_FOR_ASSOC_DONE] = { SM_ACT(basic_sm_error_handler), CONN_MSM_WAIT_FOR_ASSOC_DONE },
    [CONN_MSM_EV_OWN_ABORT][CONN_MSM_ASSOCIATED] = { SM_ACT(basic_sm_error_handler), CONN_MSM_ASSOCIATED },
    [CONN_MSM_EV_OWN_ABORT][CONN_MSM_WAIT_FOR_LM_START] = { SM_ACT(basic_sm_error_handler), CONN_MSM_WAIT_FOR_LM_START },
    [CONN_MSM_EV_OWN_ABORT][CONN_MSM_KEY_ASSOC] = { SM_ACT(basic_sm_error_handler), CONN_MSM_KEY_ASSOC },
    [CONN_MSM_EV_OWN_ABORT][CONN_MSM_WAIT_FOR_DISCONN] = { SM_ACT(basic_sm_error_handler), CONN_MSM_UNRESOURCED },
};

/* 0x802744: описатель (ид [0x10] пишет конструктор). */
extern const u32 conn_main_sm_state_names[9];   /* определение ниже */
extern const u32 conn_main_sm_event_names[11];   /* определение ниже */
FWDATA(802744) struct sm_desc conn_msm_desc = {
    .n_events = 11, .n_states = 9, .init_state = CONN_MSM_UNRESOURCED,
    .table = &conn_msm_table[0][0],
    .state_names = conn_main_sm_state_names, .event_names = conn_main_sm_event_names,
};

/* conn_main_sm__action_8e7a3c (0x8e7a3c, 62 Б; OWN_START_LINK в UNRESOURCED): cid
 * соединения, STA-конфиг uc (команда 5), правило MAC-парсера пира, далее как 0x8e2aac. */
void conn_msm_on_own_start_link_unres(struct conn_msm *sm, u32 cid, u32 a1)
{
    if (cid >= SPARRAW_MAX_STA) {
        fw_sysassert_fatal((void *)0, 0x1543);
        return;
    }
    sm->conn->cid = (u8)cid;
    lmac_if_send_sta_cfg_05(sm->conn, 0);
    rx_macq_program_desc_for_conn(sm->conn);
    conn_msm_on_own_start_link(sm, cid, a1);
}

/* conn_main_sm__action_8c475c (0x8c475c, 132 Б; BCON_RX в WAIT_FOR_BCON_RX): таймер
 * бикона снять, uc — режим 2 (команда 4), режим lm_sm (2 — инициатор, 1 — нет). Линк уже
 * есть (skip_bf) — сразу NTF_LINKUP. Бикон есть (a0) или в DMG-параметрах бикона
 * (ei+0xc0, байт 5) бит 3 или биты 4..5 — запустить линк-менеджер; иначе (журнал при
 * pkt) — NTF_LINKUP с a0 = 1 («линка нет»). */
void conn_msm_on_bcon_rx(struct conn_msm *sm, u32 a0, struct rx_pkt *pkt)
{
    struct conn *conn;
    if (sm->bcon_timer != 0) {
        u_schd_cancel(sm->bcon_timer);
        sm->bcon_timer = 0;
    }
    lmac_if_send_cmd_0x04(2);
    conn = sm->conn;
    maintain_ctx_set_field_9c(&conn->lm, (conn->initiator == 1) ? 2u : 1u);
    if (conn->skip_bf != 0) {
        conn_msm_event(sm, 2, 0, 0, 0);
        return;
    }
    if (a0 == 0) {
        u8 fl;
        if (pkt == 0)
            goto no_link;
        fl = pkt->ei->bi_ctrl[5];
        /* PCP Association Ready — B43 (байт 5 б3, 9.3.4.2); vendor принимал и Reserved B44–B45 (свой флаг). Правило
         * 11.1.3.7 — только для маяка PCP: у AP (BSS Type 3, 9.4.1.46) подполе зарезервировано и не проверяется */
        if (!(fl & 8u) && !dmg_bss_type_is_ap(pkt->ei)) {
            fw_log_emit0(0xb, 0x1011a08);
            conn_disc_detail_set(conn->cid, WMI_SPARRAW_DISC_LINKUP_NOT_ASSOC_READY);
            goto no_link;
        }
    }
    lm_if_on_linkup_ready(&conn->lm);
    return;
no_link:
    conn_msm_defer(sm, 2, 1, 0, 0);
}

/* conn_main_sm__bcon_rx_timeout_evt (0x8c4804, 4 Б; BCON_RX в KEY_ASSOC): пусто. */
void conn_msm_on_bcon_rx_key_assoc(void)
{
}

/* conn_main_sm__linkup_ntf (0x8daddc, 100 Б; NTF_LINKUP в WAIT_FOR_LINKUP): a0 — 0 линк
 * есть. uc — режим 1, режим lm_sm 0. Инициатор с линком — OWN_ASSOC (3) себе; задача
 * линк-апа (0x8f5e0c) в любом случае. */
void conn_main_sm_linkup_ntf(struct conn_msm *sm, u32 a0)
{
    struct conn *conn = sm->conn;
    fw_log_emit2(0x2b, 0x1011a30, a0, conn->cid);
    sm->lm_start_req = 0;
    sm->lm_started = 0;
    lmac_if_send_cmd_0x04(1);
    maintain_ctx_set_field_9c(&sm->conn->lm, 0);
    if (a0 == 0 && sm->conn->initiator == 1)
        conn_msm_defer(sm, 3, 0, 0, 0);
    u_schd_add(conn_link_up_task, (u32)sm->conn, a0, 1);
}

/* conn_main_sm__action_8c4898 (0x8c4898, 44 Б; NTF_LINKUP в READY_FOR_ASSOC): уведомить
 * скан/поиск записи mid. */
void conn_msm_on_linkup_ready(struct conn_msm *sm, u32 a0)
{
    struct conn *conn = sm->conn;
    fw_log_emit2(0x2b, 0x1011a60, conn->cid, a0);
    conn_notify_link_via_l2mgr(conn->mid, conn, a0);
}

/* conn_main_sm__action_8c3bf4 (0x8c3bf4, 108 Б; OWN_ASSOC в READY_FOR_ASSOC): только STA
 * ([mid+0x50] == 1, иначе ассерт 0x11c5) и инициатор (0x11c6): автомату MLME — CONNECT (0)
 * или, если член PBSS (pbss), ASSOC_RESPONSE (4). */
void conn_msm_on_own_assoc(struct conn_msm *sm)
{
    struct conn *conn = sm->conn;
    if (conn->mid->bss.mode != 1)
        fw_sysassert_fatal((void *)0, 0x11c5);
    if (sm->conn->initiator == 0)
        fw_sysassert_fatal((void *)0, 0x11c6);
    conn = sm->conn;
    if (conn->pbss != 0) {
        fw_log_emit0(0x2b, 0x1011a94);
        mlme_sm_event(&sm->conn->mlme, 4, 0, 0, 0);
    } else {
        mlme_sm_event(&conn->mlme, 0, 0, 0, 0);
    }
}

/* conn_main_sm__action_8c3c60 (0x8c3c60, 120 Б; NTF_ASSOC_START в READY_FOR_ASSOC,
 * NTF_ASSOC_DONE в WAIT_FOR_LINKUP / READY_FOR_ASSOC / WAIT_FOR_ASSOC_DONE): один раз —
 * запустить линк-менеджер; если он уже запущен — NTF_LM_STARTED себе. AP/PCP — проверка
 * режима питания; STA без [0x803c28] — aid = cid + 1. */
void conn_msm_on_assoc_done(struct conn_msm *sm)
{
    struct conn *conn;
    u32 st;
    if (sm->lm_start_req == 0) {
        sm->lm_start_req = 1;
        conn_main_sm_action_step_b(&sm->conn->lm);
    }
    if (sm->lm_started != 0)
        conn_msm_defer(sm, 6, 0, 0, 0);
    conn = sm->conn;
    st = conn->mid->bss.mode;
    if (st == 2 || st == 3) {
        power_mngr_check_mode(1);
        return;
    }
    if (dashboard.cfg.ap_sme_offload_mode != 0)
        return;
    conn->aid = (u8)(conn->cid + 1);
    conn = sm->conn;
    fw_log_emit2(0x2b, 0x1011ad0, conn->cid, conn->aid);
}

/* ---------------- ассоциация завершена ---------------- */


/* Пустая задержка vendor: mov r0,n; mov lp_count,r0; nop_s; lp — тело 2×nop_s
 * (0x8f5ac8, 0x8f5b30, 0x8f5b50). n > 0. */
static inline __attribute__((always_inline)) void conn_lp_delay(u32 n)
{
    arc_zol_nops2_mb(n);
}

/* conn__alloc_and_link (0x8e5258, 42 Б): LMAC-команда 0x1b (3 Б) {тип mid [e+0x50], a1}.
 * Первый аргумент vendor не читает. */
void conn_alloc_and_link(u32 kind, u32 a1, u32 mid)
{
    struct lmac_cmd_role *c;
    (void)kind;
    c = lmac_cmd_pool_alloc();
    c->pm_cfg = (u8)a1;
    c->mode = (u8)mid_list_by_mid_fw(mid)->bss.mode;
    lmac_if_post_cmd(c, 0x1b, 3, 0);
}

/* conn__alloc_and_link_kind1 (0x8c733c, 12 Б). */
void conn_alloc_and_link_kind1(u32 a1, u32 mid)
{
    conn_alloc_and_link(1, a1, mid);
}

/* dashboard__add_connection (0x8eabfc, 92 Б): счётчик соединений (биты 29..31 [0x853918])
 * и бит cid в 0x853920 (первый — обнулить [0x853910]). */
void dashboard_add_connection(struct conn *conn)
{
    u32 cid, w;
    if (conn == 0)
        fw_sysassert_fatal((void *)0, 0x1119);
    cid = conn->cid;
    if ((s32)cid >= (s32)SPARRAW_MAX_STA)
        fw_sysassert_fatal((void *)0, 0x111a);
    w = VOL(fw_stats_dash.state);
    VOL(fw_stats_dash.state) = (w & 0x1fffffffu) | ((((w >> 29) + 1) & 7u) << 29);
    if (VOL(fw_stats_dash.conn_mask) == 0)
        VOL(fw_stats_dash.conn_time) = 0;
    VOL(fw_stats_dash.conn_mask) = (u8)(VOL(fw_stats_dash.conn_mask) | (1u << cid));
}

/* l2mgr__program_assoc_vring (0x8db090, 64 Б): RA/TA пира в дескрипторы очередей 0x1a и
 * 0x1e. Первый и последний аргументы vendor не читает. */
void l2mgr_program_assoc_vring(u32 a0, u32 cid, const u8 *peer, const u8 *own, u32 type, u32 a5)
{
    (void)a0;
    (void)a5;
    l2mgr_program_args(vring_tbl_entry_addr(0x1a), peer, own, (u8)cid, (u8)type, 0xff);
    l2mgr_program_args(vring_tbl_entry_addr(0x1e), peer, own, (u8)cid, (u8)type, 0xff);
}

/* l2mgr__send_pbss_joined_evt (0x8f6dac, 88 Б): событие 0x15 (0xc Б) {канал [mid+0x94],
 * MAC пира, тип сети, cid} — член PBSS без обмена Assoc. */
void l2mgr_send_pbss_joined_evt(struct conn *conn)
{
    struct mid *mid = conn->mid;
    u8 *p = (u8 *)host_if_send_pair();
    memset0_words(p, 0xc);
    memcpy_fw(p + 2, conn->peer, 6);
    p[8] = (u8)mid->network_type;
    p[9] = conn->cid;
    p[0] = mid->bss.channel;
    fw_log_emit1(0x2b, 0x100d398, conn->aid);
    low_sme_send_evt2sw(p, 0x15, 0xc, mid->id, 0, 0, 0);
}

/* l2mgr__send_host_event (0x8f86cc, 392 Б): WMI_CONNECT_EVENTID (0x1002; wil6210 wmi.h
 * struct wmi_connect_event): канал (из кадра Assoc), BSSID — MAC пира, beacon_interval
 * [e+0x96], network_type [e+0x14], cid, aid (STA — байт 8 записи mid, иначе aid
 * соединения), assoc_info — тело кадра Assoc Req/Resp, сохранённого MLME (mlme.rx_pkt);
 * длина в assoc_resp_len (STA) или assoc_req_len (AP), если влезает в 0xf0 Б. Сам кадр
 * перед этим уходит хосту WMI_RX_MGMT_PACKET_EVENTID (0x1840). При [0x803c28] кадр не
 * передаётся. Конец — снять флаг операции connect. */
void l2mgr_send_host_event(u32 mid, u32 cid)
{
    struct mid *e;
    struct rx_pkt *pkt;
    u32 sta, len;
    struct conn *conn;
    u8 *p;
    e = mid_list_by_mid_fw(mid);
    if (e == 0)
        fw_sysassert_fatal((void *)0, 0x16bb);
    conn = conn_mgr_by_cid(cid);
    if (conn == 0)
        fw_sysassert_fatal((void *)0, 0x11e7);
    pkt = conn->mlme.rx_pkt;
    p = (u8 *)host_if_send_pair();
    sta = (conn->mid->bss.mode == 1) ? 1u : 0u;
    memset0_words(p, 0x17);
    memcpy_fw(p + 2, conn->peer, 6);
    p[8] = 0;
    p[9] = 0;
    p[0xa] = (u8)e->bss.bcon_int;
    p[0xb] = (u8)(e->bss.bcon_int >> 8);
    p[0x10] = 0;
    p[0xc] = (u8)e->network_type;
    p[0x13] = (u8)cid;
    p[0x14] = sta ? e->aid : conn->aid;
    p[0x11] = 0;
    p[0x10] = 0;
    p[0x12] = 0;
    len = 0x17;
    if (pkt != 0) {
        p[0] = pkt->info.channel;
        if (dashboard.cfg.ap_sme_offload_mode == 0) {
            u32 body = pkt->info.len - IEEE80211_HDR_LEN;
            u32 blen = body & 0xffffu;
            u32 total = blen + 0x17;
            if (0xf0u >= total) {                 /* l2mgr__host_evt_max_len (0x8cc3c8) */
                memcpy_fw(p + 0x17, pkt->body, blen);
                if (sta)
                    p[0x12] = (u8)body;
                else
                    p[0x11] = (u8)body;
                len = total & 0xffffu;
            }
            fw_log_emit1(0x2b, 0x100d3f8, mid);
            low_sme_send_evt2sw(&pkt->info, 0x1840, (u16)(pkt->info.len + sizeof(pkt->info)), mid, 1, 0, 0);
        } else {
            mem_pool_free_thunk(pkt);
        }
        conn->mlme.rx_pkt = 0;
    }
    fw_log_emit3(0x2b, 0x100d438, p[0x13], len, p[0]);
    fw_log_emit1(0x2b, 0x100d484, p[0x14]);
    low_sme_send_evt2sw(p, 0x1002, len, mid, 0, 0, 0);
    if (dashboard.cfg.ap_sme_offload_mode == 0)
        l2mgr_pending_op_clear(1);
}

/* mlme_sm__association_done (0x8f1290, 136 Б; задача из conn_main_sm 0x8db038 числом
 * 0x31290, a0 — соединение): ассоциация закончена — очереди mgmt пира, событие хосту
 * (CONNECT или PBSS joined), системное состояние 5, LMAC 0x1b, состояние fw 6, дашборд.
 * Без обмена Assoc (mlme.busy == 0) и не член PBSS — только журнал. */
void mlme_sm_association_done(u32 a0, u32 a1)
{
    struct conn *conn = (struct conn *)a0;
    (void)a1;
    struct mid *mid = conn->mid;
    if (conn->mlme.busy == 0 && conn->pbss == 0) {
        fw_log_emit2(0x2b, 0x100d4b4, conn->cid, mid->id);
        return;
    }
    fw_log_emit2(0x2b, 0x100d4fc, conn->cid, mid->id);
    l2mgr_program_assoc_vring(0, conn->cid, conn->peer,
                              conn->mid->mac,         /* vendor перечитывает [conn+0x18] */
                              mid_type_of(conn->mid), 1);
    if (conn->pbss != 0)
        l2mgr_send_pbss_joined_evt(conn);
    else
        l2mgr_send_host_event(mid->id, conn->cid);
    sys_state_broadcast(5, conn->cid);
    conn_alloc_and_link_kind1(0, mid->id);
    fw_status_set_state(6);
    dashboard_add_connection(conn);
    tdma_ap_update(conn->mid, 0);               /* простой TDMA точки (fw/tdma.c) */
}

/* vring_tbl__find_by_id (0x8cce14, 46 Б): стрим (таблица stream_by_vr, 10 шт.)
 * соединения conn или 0. */
struct stream_ctx *vring_tbl_find_by_id(struct conn *conn)
{
    for (u32 i = 0; i < STREAM_VR_N; i++) {
        struct stream_ctx *s = stream_by_vr[i];
        if (s != 0 && s->conn == conn)
            return s;
    }
    return 0;
}

/* vring__is_empty_by_id (0x8ebe64, 26 Б): 1 — у соединения нет стрима или его vring пуст. */
u32 vring_is_empty_by_id(struct conn *conn)
{
    struct stream_ctx *s = vring_tbl_find_by_id(conn);
    if (s == 0)
        return 1;
    return vring_is_empty(s->vr, 1);
}


/* Таймер информационного потока — [gp-0x98] = 0x8000ec (снимают pcp_start/pcp_stop
 * __cancel_timer 0x8d8750/0x8d8778). */
#define INFO_FLOW_TMR (info_flow_timer)

/* l2mgr__send_data_port_open_evt (0x8f8854, 128 Б): WMI_DATA_PORT_OPEN_EVENTID (0x1860,
 * 4 Б {cid}), системное состояние 6; в OOB-режиме — информационный поток AP/PCP. */
void l2mgr_send_data_port_open_evt(u32 cid, u32 mid)
{
    u8 *p = (u8 *)host_if_send_pair();
    memset0_words(p, 4);
    p[0] = (u8)cid;
    fw_log_emit1(0x2b, 0x100d56c, cid);
    low_sme_send_evt2sw(p, 0x1860, 4, mid, 0, 0, 0);
    sys_state_broadcast(6, cid);
    /* В OOB-режиме vendor здесь запускал информационный поток AP/PCP — OOB R1/R2 только в
     * SparRAW-pro. */
}

/* l2mgr__disconnect_sta (0x8c93a0, 96 Б): разорвать соединение с MAC mac записи mid;
 * нет такого — WMI_DISCONNECT_EVENT (protocol_reason 1, причина 2). */
void l2mgr_disconnect_sta(u32 mid, const u8 *mac, u32 protocol)
{
    struct mid *e;
    struct conn *conn;
    l2mgr_pending_op_set(2);
    e = mid_list_by_mid_fw(mid);
    if (e == 0)
        fw_sysassert_fatal((void *)0, 0x11e1);
    conn = mid_list_find_by(e, mac);
    if (conn == 0) {
        fw_log_emit0(0x1b, 0x100d5a8);
        l2mgr_send_disconnect_evt(mac, 1, 2, mid);
        return;
    }
    mid_disconnect_cmd(e, conn, 2, protocol);
}

/* l2mgr__data_port_open_and_keys (0x8f5a84, 312 Б; задача из conn_main_sm 0x8da6b0 числом
 * 0x35a84, a0 — соединение): ключ установлен — при пустом vring стрима, режиме
 * безопасности ≠ 1 и [0x8002a8] == 0 переключить RX-MACQ 2 на ключ (фильтр 0x1f, дренаж,
 * offload-дескриптор, бит 18 дескриптора, импульс битов 0/3 [0x880c18], флаги ключа); затем
 * события VRING_EN и DATA_PORT_OPEN. Непустой vring — разрыв. Состояние fw 6. */
void l2mgr_data_port_open_and_keys(u32 a0, u32 a1)
{
    struct conn *conn = (struct conn *)a0;
    (void)a1;
    struct stream_ctx *s;
    u32 q, mid, cid;
    u32 d[2];
    if (vring_is_empty_by_id(conn) == 0) {
        fw_log_emit1(0xb, 0x100d5c4, conn->cid);
        l2mgr_disconnect_sta(conn->mid->id, conn->peer, 1);
        goto out;
    }
    s = vring_tbl_find_by_id(conn);
    if (rx_reorder_sw == 0 && conn_sec_mode_not_1(conn) != 0) {
        u32 qi;
        if (s == 0)
            fw_sysassert_fatal((void *)0, 0x147d);
        qi = s->tid;
        q = rx_macq_entry_addr(2);
        do {
            conn_lp_delay(0xa0);
        } while (MMIO32(HW_MAC_BUSY_STATUS) & 8u);
        stream_mgr_prepare_1f(conn->cid, qi);
        vring_wait_drain(q);
        rx_macq_program_offload_desc((void *)q);
        macq_desc_read(d, 2, 1, 2, 1);
        d[0] &= ~(1u << 18);
        macq_desc_write(d, 2, 1, 2, 0, 0, 0, 1);
        MMIO32(HW_RGF_USER_CLKS_CTL_EXT_SW_RST_VEC_0) |= 9u;
        conn_lp_delay(800);
        MMIO32(HW_RGF_USER_CLKS_CTL_EXT_SW_RST_VEC_0) &= ~9u;
        conn_lp_delay(800);
        install_key_parse_flags(conn->cid, qi, 2);
    }
    cid = conn->cid;
    mid = conn->mid->id;
    if (s != 0)
        l2mgr_send_vring_en_evt(s->vr, mid);
    l2mgr_send_data_port_open_evt(cid, mid);
out:
    fw_status_set_state(6);
}



/* pcp_restart (0x8f7018, 84 Б): o — объект discovery записи mid. При активном BSS
 * (bss.state == 2) — собрать и поставить бикон заново (add_bcon), счётчик mgmt_stats.bcon_set +1;
 * иначе только журнал. */
void pcp_restart(struct mid_disc *o)
{
    struct mid *m = o->mid;
    u32 st = m->bss.state;
    if (st != 2) {
        fw_log_emit2(0xc, 0x1016d98, m->bss.mode, st);
        return;
    }
    add_bcon(m);
    mgmt_stats.bcon_set += 1;
    fw_log_emit3(0xc, 0x1016d60, m->bss.mode, m->bss.state,
                 dashboard.pcp_security_en);
}

/* (0x8c6264, 50 Б) таймер готовности PCP из assoc_ready_check_trig (аргумент — запись
 * mid): снять pcp_ready_tmr и проверить готовность заново. mid = 0 — ассерт 0x1461
 * (vendor продолжает). */
void pcp_ready_timer_cb(u32 a0, u32 a1)
{
    struct mid *mid = (struct mid *)a0;
    (void)a1;
    fw_log_emit0(0x2b, 0x100ca34);
    if (mid == 0)
        fw_sysassert_fatal(__builtin_return_address(0), 0x1461);
    mid->pcp_ready_tmr = 0;
    assoc_ready_check_trig(mid);
}

/* assoc_ready_check_trig (0x8c3db0, 224 Б): только AP/PCP (bss.mode 2/3) при [0x8002f4]:
 * готовность PCP по числу соединений (< max_assoc) и битам 4..5 bi_ctrl[5] ([mid+0x154]);
 * при смене — если пул 0x842304 не исчерпан, таймер 10 мс (pcp_ready_timer_cb 0x8c6264),
 * иначе перезапуск PCP. */
void assoc_ready_check_trig(struct mid *mid)
{
    struct mid_bss *o = &mid->bss;
    u32 st, ready, n;
    st = o->mode;
    if (st != 2 && st != 3)
        return;
    if (conn_assoc_ready_check_en == 0)
        return;
    if ((u32)o == 0)                                /* vendor проверяет адрес на 0 */
        fw_sysassert_fatal((void *)0, 0x11f3);
    ready = (o->bi_ctrl[5] & 0x30u) ? 1u : 0u;
    n = (mid_count_active_conns(mid) < mid->max_assoc) ? 1u : 0u;   /* rlc: перенос */
    fw_log_emit2(0x2b, 0x100c988, ready, n);
    if (ready == n)
        return;
    if (tx_pkt_pool.used < tx_pkt_pool.count) {
        if (mid->pcp_ready_tmr != 0)
            return;
        fw_log_emit1(0x2b, 0x100c9b4, mid->id);
        mid->pcp_ready_tmr = u_schd_schedule(pcp_ready_timer_cb, (u32)mid, 0, 1, 0x2710, 0, 0);
        return;
    }
    fw_log_emit3(0x2b, 0x100c9e8, mid->id, n, n);
    bss_bi_ctrl_pcp_ready_set(o, n);
    pcp_restart(&mid->disc);
}

/* ---------------- действия conn_main_sm: ассоциация, ключ, разрыв ---------------- */


/* conn_main_sm__action_8db038 (0x8db038, 20 Б; NTF_LM_STARTED в WAIT_FOR_LM_START): задача
 * mlme_sm__association_done (числом 0x31290). */
void conn_msm_on_lm_started(struct conn_msm *sm)
{
    u_schd_add(mlme_sm_association_done, (u32)sm->conn, 0, 1);
}

/* conn_main_sm__action_8e2554 (0x8e2554, 8 Б; NTF_LM_STARTED в WAIT_FOR_ASSOC_DONE):
 * запомнить «линк-менеджер запущен». */
void conn_msm_on_lm_started_early(struct conn_msm *sm)
{
    sm->lm_started = 1;
}

/* conn_main_sm__action_8da6b0 (0x8da6b0, 50 Б; NTF_KEY_INSTALLED в ASSOCIATED): MLME —
 * DATA_PORT_OPEN, готовность PCP, задача открытия порта данных (числом 0x35a84). */
void conn_msm_on_key_installed(struct conn_msm *sm)
{
    mlme_sm_event(&sm->conn->mlme, 8, 0, 0, 0);
    assoc_ready_check_trig(sm->conn->mid);
    u_schd_add(l2mgr_data_port_open_and_keys, (u32)sm->conn, 0, 1);
}

/* conn_main_sm__action_8c9050 (0x8c9050, 74 Б; NTF_DISC_COMPLETE в WAIT_FOR_DISCONN):
 * готовность PCP, задача разрыва mlme_sm__disconnect_ev_handle (числом 0x325c8) с кодом
 * (a1 << 16) | a0; AP/PCP — режим питания 0. */
void conn_msm_on_disc_complete(struct conn_msm *sm, u32 a0, u32 a1)
{
    u32 st;
    assoc_ready_check_trig(sm->conn->mid);
    u_schd_add(mlme_sm_disconnect_ev_handle, (u32)sm->conn, (a1 << 16) | a0, 1);
    st = sm->conn->mid->bss.mode;
    if (st == 2 || st == 3)
        power_mngr_check_mode(0);
}

/* conn_main_sm__action_8df500 (0x8df500, 16 Б; BCON_RX в UNRESOURCED, OWN_DISC в
 * READY_FOR_ASSOC / WAIT_FOR_DISCONN): только журнал состояния. */
void conn_msm_log_state(struct conn_msm *sm)
{
    fw_log_emit1(0x2b, 0x1011b40, sm->sm.state);
}

/* sys_state__broadcast_7 (0x8f2790, 8 Б). */
static void sys_state_broadcast_7(struct conn *conn)
{
    sys_state_broadcast(7, conn->cid);
}

/* conn_main_sm__start_disc (0x8e797c, 68 Б; OWN_DISC в UNRESOURCED / WAIT_FOR_BCON_RX /
 * WAIT_FOR_LINKUP / WAIT_FOR_ASSOC_DONE / ASSOCIATED / …): флаги и таймер бикона снять,
 * системное состояние 7, событие START (0) автомату разрыва с причиной/протоколом. */
void conn_main_sm_start_disc(struct conn_msm *sm, u32 reason, u32 protocol)
{
    fw_log_emit0(0x2b, 0x1011b0c);
    sm->lm_start_req = 0;
    sm->lm_started = 0;
    if (sm->bcon_timer != 0) {
        u_schd_cancel(sm->bcon_timer);
        sm->bcon_timer = 0;
    }
    sys_state_broadcast_7(sm->conn);
    conn_disc_event(&sm->disc, 0, reason, protocol, 0);
}

/* ======================= имена состояний и событий автоматов (fw_data) ======================= */

/* 0x8010c8: имена состояний conn_main_sm (описатель 0x802744). */
FWDATA(8010c8) const u32 conn_main_sm_state_names[9] = {
    0x0101fdbc,   /* UNRESOURCED */
    0x0101fdc8,   /* WAIT_FOR_BCON_RX */
    0x0101fdd9,   /* WAIT_FOR_LINKUP */
    0x0101fde9,   /* READY_FOR_ASSOC */
    0x0101fdf9,   /* WAIT_FOR_ASSOC_DONE */
    0x0101fe0d,   /* ASSOCIATED */
    0x0101fe18,   /* WAIT_FOR_LM_START */
    0x0101fe2a,   /* KEY_ASSOC */
    0x0101fe34,   /* WAIT_FOR_DISCONN */
};

/* 0x8010ec: имена событий conn_main_sm (описатель 0x802744). */
FWDATA(8010ec) const u32 conn_main_sm_event_names[11] = {
    0x0101fe45,   /* SM_EVT_OWN_START_LINK */
    0x0101fe5b,   /* SM_EVT_BCON_RX */
    0x0101fe6a,   /* SM_EVT_NTF_LINKUP */
    0x0101fe7c,   /* SM_EVT_OWN_ASSOC */
    0x0101fe8d,   /* SM_EVT_NTF_ASSOC_START */
    0x0101fea4,   /* SM_EVT_NTF_ASSOC_DONE */
    0x0101feba,   /* SM_EVT_NTF_LM_STARTED */
    0x0101fed0,   /* SM_EVT_NTF_KEY_INSTALLED */
    0x0101fee9,   /* SM_EVT_OWN_DISC */
    0x0101fef9,   /* SM_EVT_NTF_DISC_COMPLETE */
    0x0101ff12,   /* SM_EVT_OWN_ABORT */
};
