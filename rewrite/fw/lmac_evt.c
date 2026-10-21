// SPDX-License-Identifier: AGPL-3.0-or-later
/* Обработчики событий ucode → fw (типы из lmac_if__ucode_event_dispatch 0x8df07c, lmac.c).
 * Каждый обработчик получает тело события (запись кольца + 0x10).
 * Вызываемые глубже функции портированы в своих файлах (bf_result.c, l2mgr_key.c,
 * scan_mngr.c, conn.c, link_sm.c и др.); слабых заглушек нет. */
#include "../include/types.h"
#include "../include/power.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/sysapi_mgr.h"
#include "../include/fwdata.h"
#include "../include/conn.h"
#include "../include/link_sm.h"
#include "../include/radio_mgr.h"
#include "../include/vring_schd.h"
#include "../include/mbox.h"
#include "../include/mid.h"
#include "../include/stream.h"
#include "../include/lmac_cmd.h"
#include "../include/sys_cfg.h"
#include "../include/wmi.h"

struct mem_pool;

/* ======================= radio_mgr (объект 0x806214) ======================= */

/* Объект, конструкторы, методы и действия автоматов — radio_mgr.c (include/radio_mgr.h). */

/* rm_main_sm (0x8cc148): mid текущего канала (cur_mid). */
static u32 rm_main_sm_get_byte_90(const struct rm_main_sm *sm)
{
    return sm->cur_mid;
}

/* (0x8cc150) метод radio_mgr cur_mid: rm_main_sm_get_byte_90(&this->sm). */
u32 radio_mgr_vt_cur_mid(struct radio_mgr *self)
{
    return rm_main_sm_get_byte_90(&self->sm);
}

/* rm_main_sm__handle_lock_evt (0x8cd294): событие ucode → событие вложенного
 * rm_ch_switch_sm: 0→5, 1→3, 2→2, 3→1, иначе ассерт 0x1179 и 7. */
void rm_main_sm_handle_lock_evt(struct rm_main_sm *sm, u32 evt)
{
    u32 l;
    switch (evt) {
    case 0: l = 5; break;
    case 1: l = 3; break;
    case 2: l = 2; break;
    case 3: l = 1; break;
    default:
        fw_sysassert_fatal((void *)__builtin_return_address(0), 0x1179);
        l = 7;
        break;
    }
    basic_sm_handle_event(&sm->cs, l, 0, 0, 0);
}

/* (0x8ed5e4) метод radio_mgr inject_lock_evt: rm_main_sm_handle_lock_evt(&this->sm, evt). */
void radio_mgr_vt_inject_lock_evt(struct radio_mgr *self, u32 evt)
{
    rm_main_sm_handle_lock_evt(&self->sm, evt);
}

/* rm_main_sm__inject_lock_evt (0x8cd288): radio_mgr->inject_lock_evt(evt). */
void rm_main_sm_inject_lock_evt(u32 evt)
{
    struct radio_mgr *rm = radio_mgr_obj;
    rm->vt->inject_lock_evt(rm, evt);
}

/* new_link_evt (0x8cc158): radio_mgr->cur_mid() — mid текущего канала rm_main_sm; его
 * dispatch передаёт вторым аргументом обработчикам 0x05/0x16. */
u32 new_link_evt(void)
{
    struct radio_mgr *rm = radio_mgr_obj;
    return rm->vt->cur_mid(rm);
}

/* radio_mgr__request (0x8dcaf4): radio_mgr->request_secondary(cb, arg, param, ch, mid). */
struct rm_req *radio_mgr_request(rm_req_cb cb, u32 arg, u32 param, u32 ch, u32 mid)
{
    struct radio_mgr *rm = radio_mgr_obj;
    return rm->vt->request_secondary(rm, cb, arg, param, ch, mid);
}


/* ======================= 0x02 EVENT_ECHO ======================= */

/* lmac_if__echo_pair (0x8c32e8): буфер из пула debug-ящика. */
static u32 *lmac_if_echo_pair(void)
{
    return (u32 *)mem_pool_alloc_locked(&debug_mbox_get_or_init()->mb);
}

/* lmac_if__echo_evt_body (0x8e557c): событие хосту через debug-ящик. */
static void lmac_if_echo_evt_body(void *buf, u32 id, u32 len, u32 a3)
{
    wmi_evt_post(debug_mbox_get_or_init(), buf, 0, id, len, a3, 0, 0);
}

/* lmac_if_echo_evt_handler (0x8db768): «deep echo» — значение из события ucode обратно
 * хосту WMI_ECHO_RSP (0x1803) через debug-ящик (не operational). */
void lmac_if_echo_evt_handler(const struct lmac_cmd_echo *e)
{
    u32 *buf = lmac_if_echo_pair();
    buf[0] = e->value;
    fw_log_emit1(0x20, 0x1003b8c, e->value);
    lmac_if_echo_evt_body(buf, 0x1803, 4, 0);
}

/* ======================= 0x04 EVENT_FLUSH_Q_DONE ======================= */

/* vring_schd__flush_response (0x8dda68): найти pring, к которому привязан vring ring
 * (vring_schd.pring[i].bound), и поднять его бит (i + 8) в 0x881c3c. */
void vring_schd_flush_response(u32 ring)
{
    const struct pring *p = vring_schd.pring;
    fw_log_emit0(0x27, 0x100bc7c);
    for (u32 i = 0; i < vring_schd.n_pring; i++, p++) {
        struct vring_rec *e = p->bound;
        if (e == 0 || e->vr != ring)
            continue;
        vring_reg_write_locked_3c(1u << (i + 8), 1);
        return;
    }
}

/* event_flush_q_done (0x8db7f0). */
void event_flush_q_done(const struct lmac_evt_u32 *e)
{
    vring_schd_flush_response(e->val);
}

/* ======================= 0x08 QUEUE_DELETED_EVT ======================= */

/* stream_mgr__check_count_a (0x8c8774): счётчик vring соединения--, на нуле — 0x8e8354. */
static void stream_mgr_check_count_a(struct conn *obj)
{
    if (obj->n_vrings < 1)
        fw_sysassert_fatal((void *)__builtin_return_address(0), 0x47 << 6);
    u8 n = (u8)(obj->n_vrings - 1);
    obj->n_vrings = n;
    if (n == 0)
        stream_mgr_on_count_zero(obj);
}

/* STREAM_MGR: удаление стрима (0x8e81ac) — «STREAM [%d] REMOVED». Стрим из таблицы
 * stream_by_vr (10 слотов); элемент пула stream_pool (индексы < 9). Поля vr и mid
 * читаются и после mem_pool_free — как у vendor (free пишет только [s+0]). */
static void stream_mgr_remove(struct stream_ctx *s)
{
    u32 idx = s->vr;
    u32 bcast = s->bcast;

    if (s->configured != 0) {
        s->vt->remove(s);
        if (bcast == 0)
            stream_mgr_check_count_a(s->conn);
    }
    stream_by_vr[s->vr] = 0;
    if (s->vr < STREAM_CTX_N)
        mem_pool_free(&stream_pool, s);
    fw_log_emit1(0x2b, 0x1010ca8, s->vr);
    if (bcast != 0) {
        fw_log_emit1(0x2b, 0x1010ccc, idx);
        l2mgr_send_vring_cfg_done(idx, hwd_dma_macq_reg_addr(idx), 0, s->mid);
    }
}

/* stream_mgr__macq_removed (0x8c8d9c): стрим с MAC-очередью q ([s+5]) — удалить. */
static void stream_mgr_macq_removed(u32 q)
{
    for (u32 i = 0; i < STREAM_VR_N; i++) {
        struct stream_ctx *s = stream_by_vr[i];
        if (s == 0 || s->tbl_vr != q)
            continue;
        fw_log_emit1(0x2b, 0x1010d00, q);
        stream_mgr_remove(s);
        return;
    }
}

/* queue_deleted_evt (0x8dc4a4). */
void queue_deleted_evt(const struct lmac_evt_queue_deleted *e)
{
    stream_mgr_macq_removed(e->q);
}

/* ======================= 0x05/0x06/0x09: BF и связь ======================= */

/* 0x801f1c: таблица переходов switch vendor lmac_if__bf_done_evt (0x8db3c8;
 * ldb, цель = 0x8db4d0 + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(801f1c) const u8 lmac_if_bf_done_evt_jt[16] = {
    0x00, 0x04, 0x1b, 0x08, 0x1b, 0x1b, 0x1b, 0x0f, 0x1b, 0x1b, 0x1b, 0x1b,
    0x1b, 0x1b, 0x1b, 0x13,
};

/* lmac_if__bf_done_evt (0x8db3c8): журнал результата BF (e — событие ucode:
 * status 0/1/2, type, fail_reasons — маска причины). При ненулевом
 * [0x80030c] каждое N-е ([0x800318]) событие (кроме N-го) считается неудачным:
 * status = 0. */
void lmac_if_bf_done_evt(struct lmac_evt_bf_done *e)
{
    u32 ok = 0;
    if (bf_fail_inject_en != 0) {
        u32 n = bf_fail_inject_cnt + 1;
        bf_fail_inject_cnt = n;
        if (n == bf_fail_inject_period) {
            bf_fail_inject_cnt = 0;
        } else {
            fw_log_emit0(0x10, 0x1003bc8);
            e->status = 0;
        }
    }
    u32 st = e->status;
    if (st == 1) {
        u32 t = e->type;
        if (t == 0)
            fw_log_emit0(0x20, 0x1003bec);
        else if (t == 1)
            fw_log_emit0(0x20, 0x1003c20);
        else if (t == 2)
            fw_log_emit0(0x20, 0x1003c58);
        fw_log_emit3(0x20, 0x1003c8c, e->cid, e->diag_lo, e->diag_hi);
        fw_log_emit3(0x20, 0x1003cb4, e->tx_sector_b1, e->rx_sector, e->rf_sector);
        fw_log_emit1(0x20, 0x1003cf0, (u32)(s32)(s8)e->peer_snr);
        ok = 1;
    } else if (st == 0) {
        fw_log_emit3(0x10, 0x1003d10, e->cid, e->diag_lo, e->diag_hi);
        fw_log_emit2(0x10, 0x1003d4c, e->tx_sector_b1, e->tx_sector);
        ok = 1;
    } else if (st == 2) {
        ok = 1;
        fw_log_emit3(0x10, 0x1003d78, e->cid, e->diag_lo, e->diag_hi);
    }
    if (ok == 0)
        return;
    u32 why = e->fail_reasons;
    u32 tok;
    switch (why) {                       /* таблица 0x801f1c по why-1 (16) и 0x20 */
    case 0x01: tok = 0x1003db8; break;
    case 0x02: tok = 0x1003df8; break;
    case 0x04: tok = 0x1003e3c; break;
    case 0x08: tok = 0x1003e80; break;
    case 0x10: tok = 0x1003ebc; break;
    case 0x20: tok = 0x1003eec; break;
    default:
        fw_log_emit1(0, 0x1003f38, why);
        return;
    }
    fw_log_emit0(0x20, tok);
}

/* lmac_if__abft_notify_evt (0x8db330): «Discovery ABFT Notify status %d». Событие:
 * cid станции; status — статус BF (1 = BF_DONE_OK). */
void lmac_if_abft_notify_evt(struct lmac_evt_bf_done *e)
{
    struct conn *conn = conn_mgr_by_cid(e->cid);
    lmac_if_bf_done_evt(e);
    if (conn != 0) {
        conn_snapshot_step(&conn->lm, e);         /* add3 r0,r14,0xe */
        if (e->status == 1) {
            connection_on_bf_result(conn, e->type, e->snr);
            conn_arm_retry_timer(conn, 1);
            conn->rx_sector = e->rf_sector;
            conn->bf_byte = e->peer_snr;
        } else {
            conn_arm_retry_timer(conn, 0);
        }
    }
    dashboard_bf_results(e, conn);
}

/* find_main_sm__bcon_args (0x8da8fc): поиск записи маяка; 0 — не найдено. */
struct conn *find_main_sm_bcon_args(struct mid *mid, const void *mac, const void *snap, u32 a3, u32 a4)
{
    struct conn *out = 0;
    if (find_main_sm_bcon_lookup(mid, mac, snap, 0, &out, a3, 0, a4) == 0)
        return 0;
    return out;
}

/* l2_mgr::lmac_new_link_evt_handler (0x8f603c): новая связь после BF. st — байт
 * состояния rm_main_sm (new_link_evt) = id MID; mid+0x234 — его scan-контекст. */
void l2_mgr_lmac_new_link_evt_handler(const struct lmac_evt_bf_done *e, u32 st)
{
    fw_log_emit3(0x2b, 0x100f530, e->peer_mac[0], e->peer_mac[1], e->peer_mac[2]);
    struct mid *mid = mid_list_by_mid_fw(st);
    if (mid == 0)
        fw_sysassert_fatal((void *)__builtin_return_address(0), 0x16b5);
    struct mid_disc *sc = &mid->disc;
    struct scan_mngr *scan = sc->scan;

    if (e->status != 1) {
        fw_log_emit0(0x2b, 0x100f7ac);
        struct scan_mngr *p = sc->scan;
        if (p->active != 0) {
            u32 stop = 0;
            if (p->scan_type == 3)
                stop = (p->discovery_mode == 1);
            if (stop)
                scan_mngr_stop_dwelling(scan);
        }
        return;
    }

    fw_log_emit0(0x2b, 0x100f588);
    if (sc->find.sm.hdr.state == 4) {
        fw_log_emit0(0x2b, 0x100f5bc);
        find_main_sm_bcon_args(mid, e->peer_mac, e, 0, 0xffff);
        return;
    }
    if (sc->scan->active != 0 && e->type == 2) {
        scan_mngr_handle_abft_bf_result_in_scan(scan, e);
        return;
    }
    if (mid_state_is_2_or_3(mid->id) != 0) {
        fw_log_emit0(0x2b, 0x100f610);
        struct conn *r = find_main_sm_bcon_args(mid, e->peer_mac, e, 0, e->rf_sector);
        if (r == 0) {
            fw_log_emit0(0x2b, 0x100f6d4);
            return;
        }
        r->rx_sector = e->rf_sector;
        r->bf_byte = e->peer_snr;
        return;
    }
    if (scan->active == 0) {
        fw_log_emit0(0x2b, 0x100f764);
        return;
    }
    fw_log_emit0(0x2b, 0x100f650);
    struct dband_info *f = find_main_sm_bcon_step(&scan->scanned, (const u8 *)e->peer_mac);
    if (f == 0) {
        fw_log_emit0(0x2b, 0x100f710);
        return;
    }
    fw_log_emit0(0x2b, 0x100f68c);
    struct conn *r = find_main_sm_bcon_args(mid, e->peer_mac, e, 0, 0xffff);
    f->conn = r;
    if (r == 0)
        fw_log_emit0(0x2b, 0x100f6d4);
}

/* lmac_if__bf_done_and_new_link (0x8db518). */
void lmac_if_bf_done_and_new_link(struct lmac_evt_bf_done *e, u32 st)
{
    lmac_if_bf_done_evt(e);
    l2_mgr_lmac_new_link_evt_handler(e, st);
}

/* l2_mgr::lmac_high_false_alarm_evt_handler (0x8f5f90): запрос radio_mgr на обработку
 * потери связи (колбэк 0x8f3ce8); хэндл запроса — [gp-0x48] = 0x80013c. */
void l2_mgr_lmac_high_false_alarm_evt_handler(void)
{
    u32 h = conn_link_lost_rm_req;
    if (h != 0) {
        fw_log_emit1(0x2b, 0x100f3ac, h);
        return;
    }
    u32 now = u_schd_now();
    fw_log_emit0(0x2b, 0x100f370);
    conn_link_lost_rm_req = (u32)radio_mgr_request(l2mgr_link_lost_radio_cb, now, 0, 0xffff, 0);
}

/* lmac_if_link_lost_evt_handler (0x8db960): cid (8 — широковещательная),
 * confirmed == 1 — потеря подтверждена. Для cid ≠ 8 — синтетическое событие ABFT с
 * отказом (статус 0, fail_reasons = 0x10). Не при флаге [0x803c20] б1. */
void lmac_if_link_lost_evt_handler(const struct lmac_evt_link_lost *e)
{
    if (dashboard.cfg.special_flags & 2)
        return;
    if (e->confirmed != 1)
        return;
    if (e->cid != 8) {
        struct lmac_evt_bf_done n;
        fw_log_emit1(0x20, 0x1003fdc, e->cid);
        memset0_words(&n, sizeof(n));
        n.status = 0;
        n.cid = (u8)e->cid;
        n.fail_reasons = 0x10;
        lmac_if_abft_notify_evt(&n);
    } else {
        fw_log_emit0(0x20, 0x1004048);
    }
    l2_mgr_lmac_high_false_alarm_evt_handler();
}

/* ======================= 0x11 return_field_type ======================= */

/* 0x801f2c: таблица переходов switch vendor return_field_type (0x8dc14c;
 * ldb, цель = 0x8dc196 + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(801f2c) const u8 return_field_type_jt[17] = {
    0x06, 0x0a, 0x29, 0x29, 0x15, 0x29, 0x29, 0x29, 0x1e, 0x29, 0x29, 0x29,
    0x29, 0x29, 0x29, 0x29, 0x25,
};

/* return_field_type (0x8dc14c): ucode вернул поле ключа: cid, тип
 * (4/8/0x10 — без станции). */
void return_field_type(const struct lmac_evt_field_rsp *e)
{
    fw_log_emit2(0x20, 0x10040ac, e->type, e->cid);
    struct conn *conn = 0;
    u32 t = e->type;
    if (t != 4 && t != 8 && t != 0x10) {
        conn = conn_mgr_by_cid(e->cid);
        if (conn == 0)
            fw_sysassert_fatal((void *)__builtin_return_address(0), 0x4b | (1u << 12));
    }
    switch (e->type) {                   /* таблица 0x801f2c (17) */
    case 0x00:
        install_key_handle(conn);
        break;
    case 0x01:
        fw_log_emit1(0x20, 0x10040cc, e->cid);
        l2mgr_apply_key_to_prings(conn);
        break;
    case 0x04:
        fw_log_emit0(0x25, 0x10040f0);
        vring_enable_first_pending_gtk();
        break;
    case 0x08:
        fw_log_emit0(0x25, 0x1004124);
        break;
    case 0x10:
        fw_log_emit0(0x25, 0x1004160);
        break;
    default:
        fw_sysassert_fatal((void *)__builtin_return_address(0), 0x4c | (1u << 12));
        break;
    }
}

/* ======================= 0x13/0x14 rate search ======================= */

/* LMAC_IF::rs_started (0x8dbc6c): val — cid. */
void lmac_if_rs_started(const struct lmac_evt_u32 *e)
{
    if (conn_mgr_by_cid(e->val) != 0)
        fw_log_emit0(0x20, 0x10041ac);
    else
        fw_sysassert_fatal((void *)__builtin_return_address(0), 0xca | (1u << 12));
}

/* lmac_if__rs_done_noop_hook (0x8eacac): у vendor пустой. */
static void lmac_if_rs_done_noop_hook(struct lmac_rs_result *r, struct conn *conn)
{
    (void)r; (void)conn;
}

/* basic_sm__handle_event__r1_2_r3_0 (0x8dffe4): событие 2 maintain_sm записи l с аргументом a. */
static void basic_sm_evt2(struct lm_sm *l, u32 a)
{
    maintain_sm_event(&l->msm, 2, a, 0, 0);
}

/* lmac_if__rs_done_params (0x8c2c5c): ctx — lm_if соединения. Итог RS (res, 0x10 Б)
 * и 0x1f Б заголовка события; не на FPGA — заголовок в статистику MCS ctx (+0x50), итог —
 * событием 2 автомату maintain_sm lm_sm (если он есть). */
static void lmac_if_rs_done_params(struct lm_if *ctx, const struct lmac_evt_rs_done *e)
{
    u8 b[0x30];
    memcpy_fw(b, &e->res, 0x10);
    memcpy_fw(b + 0x10, e, 0x1f);
    if (platform_is_fpga() != 0)
        return;
    memcpy_fw(ctx->mcs_total, b + 0x10, 0x1f);             /* add3 r0,r14,0xa */
    if (ctx->lm_sm != 0)
        basic_sm_evt2(ctx->lm_sm, (u32)b);
}

/* lmac_if__rs_done_evt (0x8dbbe4): «RS DONE: CID=%d MCS:%d». Итог — копия res
 * (status 0 — успех, cid, mcs). dispatch перед вызовом кладёт TSF в tsf_lo/tsf_hi.
 * MCS → 0x880a60. */
void lmac_if_rs_done_evt(const struct lmac_evt_rs_done *e)
{
    struct lmac_rs_result r;
    memcpy_fw(&r, &e->res, 0x10);
    if (r.status == 0)
        fw_log_emit2(0x20, 0x1003fac, r.cid, r.mcs);
    else
        fw_log_emit0(0x10, 0x1003fc4);
    struct conn *conn = conn_mgr_by_cid(r.cid);
    if (conn == 0)
        fw_sysassert_fatal((void *)__builtin_return_address(0), 0xcb | (1u << 12));
    if (r.status == 0)
        conn_update_bf_id_on_rs_done(conn, r.mcs);
    MMIO32(HW_FW_BF_MCS) = r.mcs;   /* bf_mcs (REGS-KNOWN); в hw.h это BL_SHUTDOWN_HS */
    lmac_if_rs_done_noop_hook(&r, conn);
    lmac_if_rs_done_params(&conn->lm, e);              /* add3 r0,r14,0xe */
}

/* 0x15/0x18/0x19/0x25 (shallow sleep, traffic deferral, PS wake PCIe, UPM) — энергосбережение
 * вырезано (см. fw/action.c psc_req_reject); ucode их не шлёт. */

/* ======================= 0x16 ======================= */

/* lmac_if__forward_evt_to_obj (0x8c3f08): [gp+0xc9] = no_tx (маска пиров без передачи по
 * опросу ATI). Vendor ещё уведомлял текущий PS-менеджер — вырезан вместе с PS. */
static void lmac_if_forward_evt_to_obj(struct lmac_evt_ps_peer *e)
{
    ps_lmac_evt_cid_mask = e->no_tx;     /* читает link_loss; уведомление PS-объекта — PS вырезан */
}

/* mid__lookup_step (0x8f5f5c): только для MID в состоянии 2/3. */
static void mid_lookup_step(u32 id)
{
    struct mid *mid = mid_list_by_mid_fw(id);
    u32 s = mid->bss.mode;
    if (s != 2 && s != 3)
        return;
    struct sched_scheme *p = mid->sched;               /* ld.as r0,[r13,164] (слот bl.d) */
    if (p->built != 0)                                 /* mid__get_field_0c (0x8cc360) */
        mid_lookup_at_48(mid);
}

/* lmac_if__ucode_evt_check_8 (0x8db240): маска no_tx; при type == 5 — mid. */
void lmac_if_ucode_evt_check_8(struct lmac_evt_ps_peer *e, u32 st)
{
    lmac_if_forward_evt_to_obj(e);
    if (e->type == 5)
        mid_lookup_step(st);
}

/* ======================= 0x17 статистика ======================= */

/* sysapi_mgr__stats_lut_find_index (0x8f2038): lut__find_index(0x8051f8, key) — LUT
 * экземпляра (vendor — абсолютный адрес, mgr не читается). */
u32 sysapi_mgr_stats_lut_find_index(struct fw_sysapi_mgr *mgr, u32 key)
{
    (void)mgr;
    return lut_find_index(&fw_sysapi_mgr.rssi_snr_lut, key);
}

/* lmac_if__update_pct_stats (0x8db9c0): две доли занятости эфира в процентах от
 * интервала [0x853988] - ([0x8539ac] + [0x853990]) (округление к ближайшему),
 * накопление в cca_pct_stats (0x80426c) и усреднение по окну [0x803c1c] + 1, затем рассылка
 * состояния 0x16. vendor ещё читает 2 счётчика u64 (0x8dd7a4/0x8dd798) без
 * использования результата — здесь опущено. */
void lmac_if_update_pct_stats(void)
{
    if (mac_mon_pub.bti.rssi_valid != 0) {
        mac_mon_pub.bti.snr = (s32)sysapi_mgr_stats_lut_find_index(&fw_sysapi_mgr, (u32)mac_mon_pub.bti.rssi);
        mac_mon_pub.bti.snr_valid = 1;
    }
    u32 span = mac_mon_pub.dti_duration - (mac_mon_pub.rx_off_duration + mac_mon_pub.rx_listen_time);
    if (span != 0) {
        u32 half = span >> 1;
        u32 p1 = (u32)(((u64)mac_mon_pub.nav_accum * 100 + half) / span);
        u32 p2 = (u32)(((u64)mac_mon_pub.busy_time * 100 + half) / span);
        volatile struct cca_pct_stats *s = &cca_pct_stats;   /* порядок доступов — как у vendor */
        s->pct2 = (u8)p2;
        u32 sum2 = p2 + s->sum2;
        s->pct1 = (u8)p1;
        u32 sum1 = s->sum1 + p1;
        s->sum1 = sum1;
        u32 n = s->n;
        s->sum2 = sum2;
        if ((s32)n < (s32)(dashboard.cfg.cca_bi_avg_num + 1)) {
            s->n = (u16)(n + 1);
        } else {
            s->avg2 = (u8)(sum2 / n);
            s->avg1 = (u8)(sum1 / n);
            s->sum2 = 0;
            s->sum1 = 0;
            s->n = 1;
        }
    }
    sys_state_broadcast(0x16, 0);                      /* sys_state__broadcast_16 (0x8dd8e4) */
}

/* Накопитель долей занятости эфира (0x80426c); в образе нули. */
FWDATA(80426c) struct cca_pct_stats cca_pct_stats = { 0 };

/* ======================= 0x20.. fw_sysapi_mgr ======================= */

/* fw_sysapi_mgr::complete_pending_request (0x8f1c50): колбэк ожидающего запроса
 * m_completion_cb (ставит тот, кто запрос отправил) — (mgr, a, b). vendor читает поле
 * дважды (журнал и вызов). */
void fw_sysapi_mgr_complete_pending_request(struct fw_sysapi_mgr *mgr, u32 a, const void *b)
{
    fw_log_emit1(0x25, 0x1012354, (u32)mgr->completion_cb);
    sysapi_completion_cb cb = mgr->completion_cb;
    if (cb != 0)
        cb(mgr, a, b);
}


/* ======================= 0x27/0x28 RF-сектор ======================= */

/* evt_get_selected_rf_sector_index_done (0x8cd534): ответ хосту 0x19a2 (0x10 Б) в
 * ящик, запомненный при запросе (r = rf_sector_sel[GET]); затем запроса нет. */
void evt_get_selected_rf_sector_index_done(struct rf_sector_sel_req *r, u8 *e)
{
    struct wmi_get_selected_rf_sector_index_done_event *buf = mem_pool_alloc_locked((struct fw_mailbox *)r->mbox);
    memcpy_fw(buf, e, 0x10);
    fw_log_emit3(0x2b, 0x10087f8, buf->status, buf->sector_idx, buf->tsf[0]);
    wmi_evt_post((struct wmi_mbox *)r->mbox, buf, 0, 0x19a2, 0x10, 0, 0, 0);
    r->mbox = 0;
}

/* evt_set_selected_rf_sector_index_done (0x8cd58c): то же, 0x19a3 (4 Б), r = rf_sector_sel[SET]. */
void evt_set_selected_rf_sector_index_done(struct rf_sector_sel_req *r, u8 *e)
{
    u8 *buf = (u8 *)mem_pool_alloc_locked((struct fw_mailbox *)r->mbox);
    memcpy_fw(buf, e, 4);
    fw_log_emit1(0x2b, 0x1008b8c, buf[0]);
    wmi_evt_post((struct wmi_mbox *)r->mbox, buf, 0, 0x19a3, 4, 0, 0, 0);
    r->mbox = 0;
}

/* ======================= 0x2e/0x30 ======================= */

/* ba__schedule_timeout_update (0x8ead48): при b == 0 — [vring+92] (u16) = c и задача
 * stream_mgr__ready_for_modify(a) с приоритетом 1. */
static void ba_schedule_timeout_update(u32 a, u32 b, u32 c)
{
    if (b != 0)
        return;
    vring_tbl_ptr_by_index(a)->ssn = (u16)c;
    u_schd_add(stream_mgr_ready_for_modify, a, 0, 1);
}

/* ba__on_uc_timeout_evt (0x8dc430). */
void ba_on_uc_timeout_evt(const struct lmac_evt_ba_timeout *e)
{
    ba_schedule_timeout_update(e->vr, e->kind, e->ssn);
}

/* evt_fixed_scheduling_enabled (0x8db7bc): при val == 0, станции cid 0 и MID 0 не в
 * состоянии 2/3 — maintain_sm: параметры RS (1, 0) записи lm_sm соединения. */
void evt_fixed_scheduling_enabled(const struct lmac_evt_typed *e)
{
    struct conn *conn = conn_mgr_by_cid(0);
    if (e->val != 0 || conn == 0)
        return;
    if (mid_state_is_2_or_3(0) == 0)
        maintain_sm_set_rs_params(conn->lm.lm_sm, 1, 0);   /* 0x8c6cbc */
}
