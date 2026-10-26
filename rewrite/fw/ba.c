// SPDX-License-Identifier: AGPL-3.0-or-later
/* Жизненный цикл стрима и Block Ack (TX-сторона): автомат стрима (stream_sm, описатель
 * 0x80296c, объект ctx+0x10), вложенные автоматы — установка BA (ba_setup_sm, 0x802b50,
 * ctx+0x18) и ожидание (wait_sm, 0x802ba0, ctx+0x3c); методы контекста стрима
 * (таблица 0x800888, vptr ctx+0x68); команды WMI_VRING_BA_EN/DIS; WMI_BA_STATUS_EVENT.
 * Объекты — include/stream.h (struct stream_ctx / stream_sm / ba_setup_sm / ba_wait_sm).
 *
 * Таблица stream_sm (12 событий × 5 состояний; ba_sm_evt_type переводит тип стрима в
 * событие 0,1,5,3,4,6,0xa): 0 — BA_EN, 1 — BA_DIS/удаление, 2 — готов к изменению,
 * 3/4 — ответ ADDBA, 5/6 — DELBA, 7/8 — итог установки, 9 — пауза, 10 — удаление
 * соединения, 11 — завершение. Действия — (адреса в fw_data). */
#include "../include/types.h"
#include "../include/mid.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/vring_schd.h"
#include "../include/conn.h"
#include "../include/fwdata.h"
#include "../include/stream.h"
#include "../include/macq_desc.h"
#include "../include/ieee80211.h"
#include "../include/wmi.h"

/* События автоматов (basic_sm_handle_event — объект указателем). */
#define SM_EV(o, ev, a0, a1, a2) basic_sm_handle_event((o), (ev), (a0), (a1), (a2))

/* Пустая задержка vendor: mov_s r0,n; mov lp_count,r0; nop_s; lp — тело 2×nop_s
 * (0x8c458e, 0x8c45ba, 0x8e8286). n > 0. */
static inline __attribute__((always_inline)) void lp_delay(u32 n)
{
    arc_zol_nops2_mb(n);
}

/* ---------------- вспомогательные ---------------- */

/* ba_sm__get_param_byte7 (0x8cce9c, 6 Б) / byte6 (0x8cca30, 6 Б): vring / тип pring.
 * noinline — у vendor вызовы (с полями по имени gcc их встраивает). */
__attribute__((noinline)) u32 ba_sm_get_param_byte7(const struct stream_sm *s) { return s->ctx->vr; }
__attribute__((noinline)) u32 ba_sm_get_param_byte6(const struct stream_sm *s)
{
    return s->ctx->pring_type;
}

/* send_ba_status_report (0x8e5174, 144 Б): WMI_BA_STATUS_EVENT (0x1823)
 * {status u16, reserved[2], ringid, agg_wsize, ba_timeout u16, amsdu}. */
void send_ba_status_report(const struct stream_ctx *ctx, u32 ringid, u32 status, u32 agg,
                           u32 timeout, u32 amsdu)
{
    u8 *e;
    struct conn *conn = ctx->conn;
    if (conn == 0 || conn->mid == 0) {
        fw_log_emit0(0x1b, 0x1011030);
        return;
    }
    e = (u8 *)host_if_send_pair();
    e[0] = (u8)status;
    e[6] = (u8)timeout;
    e[1] = (u8)(status >> 8);
    e[7] = (u8)(timeout >> 8);
    e[2] = 0;
    e[3] = 0;
    e[4] = (u8)ringid;
    e[5] = (u8)agg;
    e[8] = (u8)amsdu;
    fw_log_emit1(0x2b, 0x101108c, ctx->conn->mid->id);
    low_sme_send_evt2sw(e, 0x1823, 9, ctx->conn->mid->id, 0, 0, 0);
}

/* vring_is_empty (0x8d47a0, 66 Б): указатели DMA vring vr (+0x440c0c0 / +0x440c100) равны. */
u32 vring_is_empty(u32 vr, u32 log)
{
    u32 a = MMIO32((((vr << 8) + 0x440c0c0u) >> 3) & ~3u);
    u32 b = MMIO32((((vr << 8) + 0x440c100u) >> 3) & ~3u);
    if (log != 0)
        fw_log_emit2(0x20, 0x101d528, a, b);
    return a == b;
}

/* dmaq_hw__reset_ptrs (0x8d0d44, 74 Б). */
void dmaq_hw_reset_ptrs(u32 vr)
{
    MMIO32(((vr << 8) + 0x440c0e0u) >> 3) = 0x80000000u;
    arc_sync();
    MMIO32(((vr << 8) + 0x440c140u) >> 3) = 0x80000000u;
    arc_sync();
    MMIO32(((vr << 8) + 0x440c100u) >> 3) = 0;
    arc_sync();
}

/* Поле w бит [lo .. lo+n-1] = v (bits__set32_*). */
static void bf32(u32 *w, u32 lo, u32 n, u32 v)
{
    u32 m = ((n >= 32) ? 0xffffffffu : ((1u << n) - 1u)) << lo;
    *w = (*w & ~m) | ((v << lo) & m);
}

/* stream_params__copy_hdr (0x8cc19c, 80 Б): дескриптор окна TX MACQ записи e в d. */
void stream_params_copy_hdr(const struct vring_tbl_entry *e, struct macq_desc *d)
{
    d->base = e->win_start;
    d->lines = e->win_lines;
    d->rd = e->win_start;
    d->wr = e->win_start;
    bf32(&d->w2, 0, 12, 997);
    bf32(&d->w2, 12, 12, e->param_a & 0xfffu);
    d->param_a_lo = (u8)e->param_a;
    bf32(&d->w3, 0, 4, (e->param_a >> 8) & 0xfu);
    bf32(&d->w3, 4, 12, e->param_b & 0xfffu);
    bf32(&d->w3, 16, 12, e->param_a & 0xfffu);
}

/* stream_mgr__build_params (0x8e2a50, 92 Б): тип очереди, флаги и окно MACQ (LMAC 0x1f);
 * для типов кроме 5/6 — очередь MAC выключена. */
void stream_mgr_build_params(struct vring_tbl_entry *e, u32 mode, u32 flag, u32 tid)
{
    struct macq_qdesc buf;
    memset0_words(&buf, sizeof(buf));
    e->mode = (u8)mode;
    buf.ba.w0 = (buf.ba.w0 & ~1u) | (flag & 1u);
    bf32(&buf.ba.w0, 16, 4, tid & 0xfu);
    stream_params_copy_hdr(e, &buf.win);
    qh_write_or_conn_alloc(e->macq, 0x1f, &buf, 0);
    if (e->mode != 5 && e->mode != 6)
        mac_ring_disable(e->macq);
    e->state = 1;
}

/* sw_vring__ba_params (0x8eabc8, 52 Б): окно записи e с числом блоков (mpdu+7)/8. */
void sw_vring_ba_params(const struct vring_tbl_entry *e)
{
    struct macq_qdesc buf;
    s32 n;
    stream_params_copy_hdr(e, &buf.win);
    n = (s32)e->max_mpdu + 7;
    if (n < 0)
        n += 7;                                     /* asr со знаком (add.n) */
    bf32(&buf.win.w2, 0, 12, (u32)(n >> 3) & 0xfffu);
    qh_write_or_conn_alloc(e->macq, 0x20, &buf, 0);
}

/* ba_sm__build_addba_params (0x8ea62c, 88 Б): тип mode, секторный и типовой дескрипторы
 * очереди e (LMAC 0x16). */
void ba_sm_build_addba_params(struct vring_tbl_entry *e, u32 mode, u32 a2, u32 a3, u32 a4, u32 a5)
{
    struct macq_qdesc buf;
    e->mode = (u8)mode;
    ba_sm_addba_at_10(e, &buf, e->sector_mode, (e->ctl >> 1) & 1u, e->to_res, a5);
    sm_pring_all_wb_done_evt(e, &buf);
    ba_sm_addba_at_08(e, &buf, a4, a2, a3, 0, 0);
    qh_write_or_conn_alloc(e->macq, 0x16, &buf, a3);
}

/* sw_vring__program_ba_win (0x8e4094, 64 Б): окно BA RX-MACQ q (rx_macq_bufs.ba_win 0x847fc8). */
void sw_vring_program_ba_win(u32 q, u32 win)
{
    struct macq_desc *d = &rx_macq_bufs.ba_win;
    macq_desc_read(d, q, 1, 0, 2);                  /* macq_desc__read_t1_w0_n2 0x8e4430 */
    d->rd = d->wr;
    bf32(&d->w3, 4, 12, win & 0xfffu);
    macq_desc_write(d, q, 1, 0, 0, 0, 0, 1);
}

/* vring__wait_drain (0x8c4554, 128 Б): ждать опустошения RX-MACQ rq (буферы rx_macq_bufs
 * 0x847fe8 и 0x847fc8), затем снятия бита очереди в 0x88682c. */
void vring_wait_drain(u32 rq)
{
    const struct rx_macq_cfg *c = (const struct rx_macq_cfg *)rq;
    u32 q = c->queue;
    fw_log_emit0(0x27, 0x1018fd4);
    do {
        macq_desc_read(rx_macq_bufs.chain.w, c->queue, 1, 3, 3);    /* 0x8e4424 */
        macq_desc_read(&rx_macq_bufs.ba_win, c->queue, 1, 0, 2);   /* 0x8e4430 */
        macq_desc_read(rx_macq_bufs.ctl, c->queue, 1, 2, 1);       /* 0x8e443c, 0x847fc8+0x50 */
        lp_delay(0xa0);
    } while (rx_macq_bufs.chain.b[0xd] != rx_macq_bufs.chain.b[0xb]);
    fw_log_emit0(0x27, 0x1018ff8);
    for (;;) {
        u32 v = MMIO32(HW_PRP_AVAIL_VEC);
        lp_delay(0xa0);
        q = c->queue;
        if (!((v >> q) & 1u))
            break;
    }
}

/* stream_mgr__prepare_buf30_by_id (0x8cccb4 → 0x8dd8ec, 30 Б): номер блока начала окна
 * (поле 12 бит слова 1) MACQ-дескриптора очереди e. */
u32 stream_mgr_prepare_buf30_by_id(const struct vring_tbl_entry *e)
{
    u32 b[0xc];
    macq_desc_read(b, e->macq, 2, 3, 1);
    return b[1] & 0xfffu;
}

/* ---------------- методы контекста стрима (таблица 0x800888) ---------------- */

/* sw_vring::ba_teardown (0x8c43a0, 140 Б) — vt[1]: сбросить BA; удаляемый стрим (+0x58) —
 * LMAC 8 на остановку, иначе вернуть параметры очереди без BA и возобновить vring. */
void stream_ctx_vt_ba_teardown(struct stream_ctx *ctx, u32 a0, u32 a1)
{
    struct vring_tbl_entry *e;
    (void)a0;                                       /* vendor (0x8c4394) передаёт, метод не читает */
    (void)a1;
    ctx->ba_en = 0;
    ctx->vt->ba_failed(ctx, 1);
    e = vring_tbl_entry_addr(ctx->vr);
    if (ctx->removing != 0) {
        u32 busy = vring_is_empty(ctx->vr, 0) == 0;
        lmac_if_send_cmd_0x08(3, 1, (u8)vring_get_pring_id(ctx), ctx->tbl_vr, 0, 0, busy);
        vring_tbl_entry_addr(ctx->tbl_vr)->state = 2;
        fw_log_emit2(0x2b, 0x1010fec, ctx->vr, busy);
    } else {
        struct conn *conn = ctx->conn;
        u32 cid = conn->cid;
        struct vring_schd_if *tbl;
        ba_sm_build_addba_params(e, 5, ctx->tid, 0, cid, conn_sec_mode_not_1(conn));
        tbl = vring_active_ring_table();
        tbl->vt->resume_vring(tbl, ctx->vr);
    }
}

/* sw_vring::suspend (0x8e0e40, 22 Б) — vt[2] и (0x8e0e28, 22 Б) — vt[3]: vt[5] vring_schd. */
void stream_ctx_vt_suspend(struct stream_ctx *ctx)
{
    struct vring_schd_if *tbl = vring_active_ring_table();
    tbl->vt->suspend_vring(tbl, ctx->vr);
}

/* (0x8e0e28, 22 Б) — vt[3]: то же, что vt[2]. */
void stream_ctx_vt_suspend_b(struct stream_ctx *ctx)
{
    struct vring_schd_if *tbl = vring_active_ring_table();
    tbl->vt->suspend_vring(tbl, ctx->vr);
}

/* sw_vring::ready_for_modify (0x8e2408, 108 Б) — vt[4]: запомнить начало окна и, если
 * stream_sm ждёт (ба-установка в 6 при состоянии 1, либо состояния 3/4), — событие 2. */
void stream_ctx_vt_ready(struct stream_ctx *ctx)
{
    struct vring_tbl_entry *e = vring_tbl_entry_addr(ctx->vr);
    struct stream_sm *s = &ctx->sm;
    u32 go;
    if (fixed_sched.enabled == 0)
        ctx->ssn = (u16)stream_mgr_prepare_buf30_by_id(e);
    go = (s->setup.hdr.state == 6 && s->hdr.state == 1) || s->hdr.state == 3 || s->hdr.state == 4;
    if (go)
        SM_EV(s, 2, 0, 0, 0);
}

/* sw_vring::status (0x8c4294, 14 Б) — vt[5]: WMI_BA_STATUS {status}. */
void stream_ctx_vt_status(struct stream_ctx *ctx, u32 status)
{
    send_ba_status_report(ctx, ctx->vr, status, 0, 0, 0);
}

/* sw_vring::ba_agreed (0x8c4124, 168 Б) — vt[6]: BA с окном win установлен: окно MACQ,
 * параметры очереди с BA, возобновить vring, WMI_BA_STATUS (успех), для режима RX-цепочки
 * 0 — RX MACQ 2 и окно BA RX. */
void stream_ctx_vt_ba_agreed(struct stream_ctx *ctx, u32 win, u32 timeout,
                                               u32 amsdu)
{
    struct vring_tbl_entry *e = vring_tbl_entry_addr(ctx->tbl_vr);
    struct conn *conn;
    u32 cid;
    struct vring_schd_if *tbl;
    sw_vring_ba_params(e);
    fw_log_emit3(0x27, 0x1010fb0, win, e->max_mpdu, ctx->tbl_vr);
    hwd_dma_set_ring_field_99e0(0, (u32)((s32)win >> 3));
    conn = ctx->conn;
    cid = conn->cid;
    ba_sm_build_addba_params(e, 6, ctx->tid, win, cid, conn_sec_mode_not_1(conn));
    tbl = vring_active_ring_table();
    tbl->vt->resume_vring(tbl, ctx->vr);
    send_ba_status_report(ctx, ctx->vr, 0, win, timeout, (u8)amsdu);
    if (rx_reorder_sw == 0) {
        /* vendor (8c419c..8c41c6, слоты задержки): cfg = RX MACQ 2, a3 = режим цепочки,
         * a4 = слово конфигурации [0x80020c] (rx_chain__get_cfg_word 0x8cceb4). */
        u32 rq = rx_macq_entry_addr(2);
        u32 mode = rx_chain_get_cfg_mode();
        u32 w = rx_chain_payload_size;
        rx_chain_configure(rq, ctx->tid, 0, (u8)mode, (u16)w);
        sw_vring_program_ba_win(2, w);
    }
}

/* sw_vring::ba_failed (0x8c41cc, 50 Б) — vt[7]: BA не установлен: для действующего (не
 * удаляемого) стрима с флагом — возобновить vring; WMI_BA_STATUS (1). */
void stream_ctx_vt_ba_failed(struct stream_ctx *ctx, u32 resume)
{
    if (ctx->bcast != 0)
        return;
    if (ctx->removing == 0 && resume == 1) {
        struct vring_schd_if *tbl = vring_active_ring_table();
        tbl->vt->resume_vring(tbl, ctx->vr);
    }
    send_ba_status_report(ctx, ctx->vr, 1, 0, 0, 0);
}

/* sw_vring::remove (0x8e822c, 180 Б) — vt[8]: при удалении стрима — удалить vring из
 * vring_schd (vt[4]), сбросить указатели DMA, очередь в тип 5; для режима 0 RX-цепочки —
 * дождаться опустошения RX MACQ 2 и снять очередь с BA (бит 18 дескриптора). */
void stream_ctx_vt_remove(struct stream_ctx *ctx)
{
    struct vring_schd_if *tbl;
    fw_log_emit1(0x2b, 0x10110c4, ctx->vr);
    ctx->configured = 0;
    tbl = vring_active_ring_table();
    tbl->vt->delete_vring(tbl, ctx->vr);
    dmaq_hw_reset_ptrs(ctx->vr);
    stream_mgr_build_params(vring_tbl_entry_addr(ctx->vr), 5, 0, ctx->tid);
    if (rx_reorder_sw == 0) {
        u32 rq, d[4];
        ctx->ssn = 0;
        rq = rx_macq_entry_addr(2);
        for (;;) {
            u32 v = MMIO32(HW_MAC_BUSY_STATUS);
            lp_delay(0xa0);
            if (!(v & 8u))
                break;
        }
        stream_mgr_prepare_1f(ctx->conn->cid, ctx->tid);
        vring_wait_drain(rq);
        macq_desc_read(d, 2, 1, 2, 1);
        d[0] |= 1u << 18;
        macq_desc_write(d, 2, 1, 2, 0, 0, 0, 1);
    }
}

/* Таблица методов контекста стрима (0x800888); ставит конструктор элемента 0x8ed190. */
FWDATA(800888) const struct stream_ctx_vt stream_ctx_vtbl = {
    .rsv0 = 0,
    .ba_teardown = stream_ctx_vt_ba_teardown,   /* 0x8c43a0 */
    .suspend = stream_ctx_vt_suspend,           /* 0x8e0e40 */
    .suspend_b = stream_ctx_vt_suspend_b,       /* 0x8e0e28 */
    .ready = stream_ctx_vt_ready,               /* 0x8e2408 */
    .status = stream_ctx_vt_status,             /* 0x8c4294 */
    .ba_agreed = stream_ctx_vt_ba_agreed,       /* 0x8c4124 */
    .ba_failed = stream_ctx_vt_ba_failed,       /* 0x8c41cc */
    .remove = stream_ctx_vt_remove,             /* 0x8e822c */
};

/* ---------------- действия stream_sm (таблица 0x802840) ---------------- */

/* (0x8e0d9c, 62 Б): BA_EN — ba_setup_sm событие 0 (параметры), затем 1 (старт) для
 * обычного стрима (vring ≠ 9). */
void stream_sm_act_ba_en(struct stream_sm *s, u32 a0, u32 a1, u32 a2)
{
    SM_EV(&s->setup, 0, a0, a1, a2);
    if (ba_sm_get_param_byte7(s) != 9)
        SM_EV(&s->setup, 1, 0, 0, 0);
}

/* (0x8ea754, 42 Б): BA_EN не к месту — статус по (новому) состоянию: 1 → 3, 3/4 → 2,
 * иначе 4; vt[5] контекста. */
void stream_sm_act_en_status(struct stream_sm *s)
{
    u32 st;
    switch (s->hdr.state) {
    case 1:  st = 3; break;
    case 3:
    case 4:  st = 2; break;
    default: st = 4; break;
    }
    s->ctx->vt->status(s->ctx, (u16)st);
}

/* 0x802980: таблица переходов vendor ba_sm__action_8ea780 (0x8ea780): ldb.x, 5 записей, цель = 0x8ea798 + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(802980) __attribute__((aligned(1))) const u8 stream_sm_act_dis_status_jt[5] = {
    0x00, 0x02, 0x05, 0x04, 0x04,
};

/* (0x8ea780, 44 Б): BA_DIS не к месту — статус по состоянию (jump-table 0x802980:
 * 0 → 5, 1 → 3, 2 → 4, 3/4 → 2). */
void stream_sm_act_dis_status(struct stream_sm *s)
{
    u32 st;
    switch (s->hdr.state) {
    case 0:  st = 5; break;
    case 1:  st = 3; break;
    case 3:
    case 4:  st = 2; break;
    default: st = 4; break;
    }
    s->ctx->vt->status(s->ctx, (u16)st);
}

/* (0x8e0ddc, 74 Б): удаление/отключение — wait_sm событие 0 (причина a0, флаг 1),
 * vt[2] контекста (приостановить vring). */
void stream_sm_act_teardown(struct stream_sm *s, u32 a0)
{
    fw_log_emit3(0x2b, 0x1013500, ba_sm_get_param_byte7(s), ba_sm_get_param_byte6(s),
                 vring_get_pring_id_of_obj(s));
    SM_EV(&s->wait, 0, a0, 1, 0);
    s->ctx->vt->suspend(s->ctx);
}

/* (0x8ebfe8, 14 Б): ba_setup_sm событие 2. */
void stream_sm_act_setup_ev2(struct stream_sm *s)
{
    SM_EV(&s->setup, 2, 0, 0, 0);
}

/* (0x8e7938, 14 Б): wait_sm событие 1. */
void stream_sm_act_wait_ev1(struct stream_sm *s)
{
    SM_EV(&s->wait, 1, 0, 0, 0);
}

/* (0x8c4394, 10 Б): vt[1] контекста (сброс BA). */
void stream_sm_act_vt1(struct stream_sm *s, u32 a0, u32 a1)
{
    s->ctx->vt->ba_teardown(s->ctx, a0, (u16)a1);
}

/* (0x8c3110, 20 Б): EVT_ADDBAREQ_TX_COMPLETE — итог передачи ADDBA Request: ba_setup_sm
 * событие 4 (передан, a0 == 1) или 5 (EVT_ADDBAREQ_TX_FAILED). */
void stream_sm_act_addba_rsp(struct stream_sm *s, u32 a0)
{
    SM_EV(&s->setup, a0 == 1 ? 4 : 5, 0, 0, 0);
}

/* (0x8c3154, 42 Б): EVT_ADDBARSP_ARRIVED — ba_setup_sm событие 7 (a0 — тело ответа). */
void stream_sm_act_setup_ev7(struct stream_sm *s, u32 a0)
{
    fw_log_emit0(0x2b, 0x1013540);
    SM_EV(&s->setup, 7, a0, 0, 0);
}

/* (0x8c8d5c, 14 Б): wait_sm событие 2. */
void stream_sm_act_wait_ev2(struct stream_sm *s)
{
    SM_EV(&s->wait, 2, 0, 0, 0);
}

/* (0x8e2a30, 28 Б): wait_sm событие 3 (a0) и vt[2] контекста. */
void stream_sm_act_wait_ev3_suspend(struct stream_sm *s, u32 a0)
{
    SM_EV(&s->wait, 3, a0, 0, 0);
    s->ctx->vt->suspend(s->ctx);
}

/* (0x8e21c4, 44 Б): wait_sm событие 3 (a0). */
void stream_sm_act_wait_ev3(struct stream_sm *s, u32 a0)
{
    fw_log_emit0(0x2b, 0x1013554);
    SM_EV(&s->wait, 3, a0, 0, 0);
}

/* (0x8c4314, 104 Б): итог установки BA: a0 == 0 — vt[6] (согласованные окно, таймаут,
 * amsdu ba_setup_sm), иначе vt[7]. */
void stream_sm_act_setup_done(struct stream_sm *s, u32 a0)
{
    u32 win = s->setup.win;
    u32 to = s->setup.timeout;
    if (a0 == 0) {
        u32 amsdu = s->setup.amsdu;
        fw_log_emit3(0x2b, 0x1013560, win, to, amsdu);
        if (win == 0) {                             /* vendor: ассерт 0x133e; окно 0 сюда больше не доходит */
            fw_log_emit2(0x2b, 0x1013594, a0, win);
            s->ctx->vt->ba_failed(s->ctx, 0);
            return;
        }
        s->ctx->vt->ba_agreed(s->ctx, win, to, amsdu);
    } else {
        fw_log_emit2(0x2b, 0x1013594, a0, win);
        s->ctx->vt->ba_failed(s->ctx, 0);
    }
}

/* (0x8c437c, 14 Б): ba_setup_sm событие 0xc. */
void stream_sm_act_setup_ev12(struct stream_sm *s)
{
    SM_EV(&s->setup, 0xc, 0, 0, 0);
}

/* (0x8c438c, 8 Б): vt[2] контекста. vendor (ld r1,[r0,0x68]; ld r1,[r1,8]; j [r1]) затирает
 * r1 адресом метода — аргументы события методу не передаются (он их и не читает). */
void stream_sm_act_vt2(struct stream_sm *s)
{
    s->ctx->vt->suspend(s->ctx);
}

/* 0x802838: 8 Б перед таблицей stream_sm — обращений в vendor-коде не найдено (ни адреса, ни
 * базы ldb.x; по виду — байтовая таблица, как соседние 0x802810/0x802818 rx_chain). Держит образ. */
FWDATA(802838) const u8 vendor_unref_802838[8] = { 0x06, 0x06, 0x00, 0x09, 0x0e, 0x0e, 0x00, 0x00 };

/* 0x802840: таблица переходов stream_sm [событие][состояние] (событий 12, состояний 5) —
 * {действие, следующее состояние}; комментарий — «состояние → следующее» по vendor-именам. */
FWDATA(802840) const struct sm_trans stream_sm_trans[12][5] = {
    [0] = {   /* EVT_START_BA_SETUP */
        { SM_ACT(stream_sm_act_ba_en), 1 },                  /* NOT_BA_AGR_STATE → BA_SETUP_STATE */
        { SM_ACT(stream_sm_act_en_status), 1 },              /* BA_SETUP_STATE → BA_SETUP_STATE */
        { SM_ACT(stream_sm_act_en_status), 2 },              /* BA_AGREED_STATE → BA_AGREED_STATE */
        { SM_ACT(stream_sm_act_en_status), 3 },              /* BA_TEARDOWN_STATE → BA_TEARDOWN_STATE */
        { SM_ACT(stream_sm_act_en_status), 4 },              /* WAIT_REMOVE_STREAM_STATE → WAIT_REMOVE_STREAM_STATE */
    },
    [1] = {   /* EVT_START_BA_TEARDOWN */
        { SM_ACT(stream_sm_act_dis_status), 0 },             /* NOT_BA_AGR_STATE → NOT_BA_AGR_STATE */
        { SM_ACT(stream_sm_act_dis_status), 1 },             /* BA_SETUP_STATE → BA_SETUP_STATE */
        { SM_ACT(stream_sm_act_teardown), 3 },               /* BA_AGREED_STATE → BA_TEARDOWN_STATE */
        { SM_ACT(stream_sm_act_dis_status), 3 },             /* BA_TEARDOWN_STATE → BA_TEARDOWN_STATE */
        { SM_ACT(stream_sm_act_dis_status), 4 },             /* WAIT_REMOVE_STREAM_STATE → WAIT_REMOVE_STREAM_STATE */
    },
    [2] = {   /* EVT_VRING_STOPPED */
        { SM_ACT(basic_sm_error_handler), 0 },               /* NOT_BA_AGR_STATE → NOT_BA_AGR_STATE */
        { SM_ACT(stream_sm_act_setup_ev2), 1 },              /* BA_SETUP_STATE → BA_SETUP_STATE */
        { SM_ACT(basic_sm_error_handler), 2 },               /* BA_AGREED_STATE → BA_AGREED_STATE */
        { SM_ACT(stream_sm_act_wait_ev1), 3 },               /* BA_TEARDOWN_STATE → BA_TEARDOWN_STATE */
        { SM_ACT(stream_sm_act_vt1), 0 },                    /* WAIT_REMOVE_STREAM_STATE → NOT_BA_AGR_STATE */
    },
    [3] = {   /* EVT_ADDBAREQ_TX_COMPLETE */
        { SM_ACT(sm_action_nop_b), 0 },                      /* NOT_BA_AGR_STATE → NOT_BA_AGR_STATE */
        { SM_ACT(stream_sm_act_addba_rsp), 1 },              /* BA_SETUP_STATE → BA_SETUP_STATE */
        { SM_ACT(sm_action_nop_b), 2 },                      /* BA_AGREED_STATE → BA_AGREED_STATE */
        { SM_ACT(sm_action_nop_b), 3 },                      /* BA_TEARDOWN_STATE → BA_TEARDOWN_STATE */
        { SM_ACT(stream_sm_act_addba_rsp), 4 },              /* WAIT_REMOVE_STREAM_STATE → WAIT_REMOVE_STREAM_STATE */
    },
    [4] = {   /* EVT_ADDBARSP_ARRIVED */
        { SM_ACT(sm_action_nop_b), 0 },                      /* NOT_BA_AGR_STATE → NOT_BA_AGR_STATE */
        { SM_ACT(stream_sm_act_setup_ev7), 1 },              /* BA_SETUP_STATE → BA_SETUP_STATE */
        { SM_ACT(sm_action_nop_b), 2 },                      /* BA_AGREED_STATE → BA_AGREED_STATE */
        { SM_ACT(sm_action_nop_b), 3 },                      /* BA_TEARDOWN_STATE → BA_TEARDOWN_STATE */
        { SM_ACT(sm_action_nop_b), 4 },                      /* WAIT_REMOVE_STREAM_STATE → WAIT_REMOVE_STREAM_STATE */
    },
    [5] = {   /* EVT_DELBA_TX_COMPLETE */
        { SM_ACT(sm_action_nop_b), 0 },                      /* NOT_BA_AGR_STATE → NOT_BA_AGR_STATE */
        { SM_ACT(sm_action_nop_b), 1 },                      /* BA_SETUP_STATE → BA_SETUP_STATE */
        { SM_ACT(basic_sm_error_handler), 2 },               /* BA_AGREED_STATE → BA_AGREED_STATE */
        { SM_ACT(stream_sm_act_wait_ev2), 3 },               /* BA_TEARDOWN_STATE → BA_TEARDOWN_STATE */
        { SM_ACT(sm_action_nop_b), 4 },                      /* WAIT_REMOVE_STREAM_STATE → WAIT_REMOVE_STREAM_STATE */
    },
    [6] = {   /* EVT_RCP_DELBA_ARRIVED */
        { SM_ACT(sm_action_nop_b), 0 },                      /* NOT_BA_AGR_STATE → NOT_BA_AGR_STATE */
        { SM_ACT(sm_action_nop_b), 1 },                      /* BA_SETUP_STATE → BA_SETUP_STATE */
        { SM_ACT(stream_sm_act_wait_ev3_suspend), 3 },       /* BA_AGREED_STATE → BA_TEARDOWN_STATE */
        { SM_ACT(stream_sm_act_wait_ev3), 3 },               /* BA_TEARDOWN_STATE → BA_TEARDOWN_STATE */
        { SM_ACT(sm_action_nop_b), 4 },                      /* WAIT_REMOVE_STREAM_STATE → WAIT_REMOVE_STREAM_STATE */
    },
    [7] = {   /* EVT_BA_SETUP_SUCCESS_NTF */
        { SM_ACT(basic_sm_error_handler), 0 },               /* NOT_BA_AGR_STATE → NOT_BA_AGR_STATE */
        { SM_ACT(stream_sm_act_setup_done), 2 },             /* BA_SETUP_STATE → BA_AGREED_STATE */
        { SM_ACT(basic_sm_error_handler), 2 },               /* BA_AGREED_STATE → BA_AGREED_STATE */
        { SM_ACT(basic_sm_error_handler), 3 },               /* BA_TEARDOWN_STATE → BA_TEARDOWN_STATE */
        { SM_ACT(basic_sm_error_handler), 4 },               /* WAIT_REMOVE_STREAM_STATE → WAIT_REMOVE_STREAM_STATE */
    },
    [8] = {   /* EVT_BA_SETUP_FAIL_NTF */
        { SM_ACT(basic_sm_error_handler), 0 },               /* NOT_BA_AGR_STATE → NOT_BA_AGR_STATE */
        { SM_ACT(stream_sm_act_setup_done), 0 },             /* BA_SETUP_STATE → NOT_BA_AGR_STATE */
        { SM_ACT(basic_sm_error_handler), 2 },               /* BA_AGREED_STATE → BA_AGREED_STATE */
        { SM_ACT(basic_sm_error_handler), 3 },               /* BA_TEARDOWN_STATE → BA_TEARDOWN_STATE */
        { SM_ACT(basic_sm_error_handler), 4 },               /* WAIT_REMOVE_STREAM_STATE → WAIT_REMOVE_STREAM_STATE */
    },
    [9] = {   /* EVT_BA_TEARDOWN_DONE_NTF */
        { SM_ACT(basic_sm_error_handler), 0 },               /* NOT_BA_AGR_STATE → NOT_BA_AGR_STATE */
        { SM_ACT(basic_sm_error_handler), 1 },               /* BA_SETUP_STATE → BA_SETUP_STATE */
        { SM_ACT(basic_sm_error_handler), 2 },               /* BA_AGREED_STATE → BA_AGREED_STATE */
        { SM_ACT(stream_sm_act_vt1), 0 },                    /* BA_TEARDOWN_STATE → NOT_BA_AGR_STATE */
        { SM_ACT(basic_sm_error_handler), 4 },               /* WAIT_REMOVE_STREAM_STATE → WAIT_REMOVE_STREAM_STATE */
    },
    [10] = {   /* EVT_REMOVE_STREAM */
        { SM_ACT(stream_sm_act_teardown), 4 },               /* NOT_BA_AGR_STATE → WAIT_REMOVE_STREAM_STATE */
        { SM_ACT(stream_sm_act_setup_ev12), 4 },             /* BA_SETUP_STATE → WAIT_REMOVE_STREAM_STATE */
        { SM_ACT(stream_sm_act_teardown), 4 },               /* BA_AGREED_STATE → WAIT_REMOVE_STREAM_STATE */
        { SM_ACT(sm_action_nop_b), 3 },                      /* BA_TEARDOWN_STATE → BA_TEARDOWN_STATE */
        { SM_ACT(sm_action_nop_b), 4 },                      /* WAIT_REMOVE_STREAM_STATE → WAIT_REMOVE_STREAM_STATE */
    },
    [11] = {   /* EVT_BA_SETUP_SM_ABORT_DONE */
        { SM_ACT(basic_sm_error_handler), 4 },               /* NOT_BA_AGR_STATE → WAIT_REMOVE_STREAM_STATE */
        { SM_ACT(basic_sm_error_handler), 4 },               /* BA_SETUP_STATE → WAIT_REMOVE_STREAM_STATE */
        { SM_ACT(basic_sm_error_handler), 4 },               /* BA_AGREED_STATE → WAIT_REMOVE_STREAM_STATE */
        { SM_ACT(basic_sm_error_handler), 4 },               /* BA_TEARDOWN_STATE → WAIT_REMOVE_STREAM_STATE */
        { SM_ACT(stream_sm_act_vt2), 4 },                    /* WAIT_REMOVE_STREAM_STATE → WAIT_REMOVE_STREAM_STATE */
    },
};
/* 0x80296c: описатель stream_sm (состояний 5, событий 12, старт NOT_BA_AGR_STATE); ид [0x10] пишет
 * статический конструктор. Имена — массивы ид строк журнала в fw_data. */
extern const u32 ba_sm_state_names[5];   /* определение ниже */
extern const u32 ba_sm_event_names[12];   /* определение ниже */
FWDATA(80296c) struct sm_desc stream_sm_desc = {
    .n_events = 12, .n_states = 5, .init_state = 0,
    .table = &stream_sm_trans[0][0],
    .state_names = ba_sm_state_names,   /* {NOT_BA_AGR_STATE, BA_SETUP_STATE, BA_AGREED_STATE, BA_TEARDOWN_STATE, WAIT_REMOVE_STREAM_STATE} */
    .event_names = ba_sm_event_names,
};

/* ---------------- действия wait_sm (таблица 0x802b64) ---------------- */

/* (0x8e6a4c, 6 Б): причина (16 бит) и флаг DELBA. */
void wait_sm_act_store(struct ba_wait_sm *w, u32 reason, u32 flag)
{
    w->reason = (u16)reason;
    w->send_delba = (u8)flag;
}

/* (0x8e7cd4, 36 Б): отправить DELBA либо (без флага) сразу событие 2. */
void wait_sm_act_delba(struct ba_wait_sm *w)
{
    if (w->send_delba != 0)
        ba_sm_send_delba(w->sm, w->reason);
    else
        SM_EV(w, 2, 0, 0, 0);
}

/* (0x8e2b8c, 14 Б): отложенное событие 9 автомату стрима (причина). */
void wait_sm_act_done(struct ba_wait_sm *w, u32 a0, u32 a1, u32 a2)
{
    (void)a0;
    (void)a1;
    sm_defer_call(w->sm, 9, 1, w->reason, a2);
}

/* 0x802b64: таблица переходов wait_sm [событие][состояние] (событий 4, состояний 3) —
 * {действие, следующее состояние}; комментарий — «состояние → следующее» по vendor-именам. */
FWDATA(802b64) const struct sm_trans wait_sm_trans[4][3] = {
    [0] = {   /* START */
        { SM_ACT(wait_sm_act_store), 1 },                    /* WAIT_FOR_START → WAIT_FOR_PERMIT */
        { SM_ACT(basic_sm_error_handler), 1 },               /* WAIT_FOR_PERMIT → WAIT_FOR_PERMIT */
        { SM_ACT(basic_sm_error_handler), 2 },               /* WAIT_FOR_DELBA_TX_COMPLETE → WAIT_FOR_DELBA_TX_COMPLETE */
    },
    [1] = {   /* READY_TO_RUN */
        { SM_ACT(basic_sm_error_handler), 0 },               /* WAIT_FOR_START → WAIT_FOR_START */
        { SM_ACT(wait_sm_act_delba), 2 },                    /* WAIT_FOR_PERMIT → WAIT_FOR_DELBA_TX_COMPLETE */
        { SM_ACT(basic_sm_error_handler), 2 },               /* WAIT_FOR_DELBA_TX_COMPLETE → WAIT_FOR_DELBA_TX_COMPLETE */
    },
    [2] = {   /* DELBA_TX_COMPLETE */
        { SM_ACT(basic_sm_error_handler), 0 },               /* WAIT_FOR_START → WAIT_FOR_START */
        { SM_ACT(sm_action_nop_b), 1 },                      /* WAIT_FOR_PERMIT → WAIT_FOR_PERMIT */
        { SM_ACT(wait_sm_act_done), 0 },                     /* WAIT_FOR_DELBA_TX_COMPLETE → WAIT_FOR_START */
    },
    [3] = {   /* RCP_DELBA_ARRIVED */
        { SM_ACT(wait_sm_act_store), 1 },                    /* WAIT_FOR_START → WAIT_FOR_PERMIT */
        { SM_ACT(sm_action_nop_b), 1 },                      /* WAIT_FOR_PERMIT → WAIT_FOR_PERMIT */
        { SM_ACT(sm_action_nop_b), 0 },                      /* WAIT_FOR_DELBA_TX_COMPLETE → WAIT_FOR_START */
    },
};
/* 0x802ba0: описатель wait_sm (состояний 3, событий 4, старт WAIT_FOR_START); ид [0x10] пишет
 * статический конструктор. Имена — массивы ид строк журнала в fw_data. */
extern const u32 ba_wait_sm_state_names[3];   /* определение ниже */
extern const u32 ba_wait_sm_event_names[4];   /* определение ниже */
FWDATA(802ba0) struct sm_desc wait_sm_desc = {
    .n_events = 4, .n_states = 3, .init_state = 0,
    .table = &wait_sm_trans[0][0],
    .state_names = ba_wait_sm_state_names,   /* {WAIT_FOR_START, WAIT_FOR_PERMIT, WAIT_FOR_DELBA_TX_COMPLETE} */
    .event_names = ba_wait_sm_event_names,
};

/* 0x802bb4: строки имён wait_sm — на них указывают массивы имён в fw_data (состояния 0x8013c4,
 * события 0x8013d0; vendor держит их в DCCM, а не в таблице строк журнала). */
FWDATA(802bb4) const struct {
    char st_wait_for_start[15];                 /* 0x802bb4 */
    char st_wait_for_permit[16];                /* 0x802bc3 */
    char st_wait_for_delba_tx_complete[27];     /* 0x802bd3 */
    char ev_start[6];                           /* 0x802bee */
    char ev_ready_to_run[13];                   /* 0x802bf4 */
    char ev_delba_tx_complete[18];              /* 0x802c01 */
    char ev_rcp_delba_arrived[18];              /* 0x802c13 */
    char sm_name[12];                           /* 0x802c25 */
} wait_sm_strs = {
    .st_wait_for_start = "WAIT_FOR_START",
    .st_wait_for_permit = "WAIT_FOR_PERMIT",
    .st_wait_for_delba_tx_complete = "WAIT_FOR_DELBA_TX_COMPLETE",
    .ev_start = "START",
    .ev_ready_to_run = "READY_TO_RUN",
    .ev_delba_tx_complete = "DELBA_TX_COMPLETE",
    .ev_rcp_delba_arrived = "RCP_DELBA_ARRIVED",
    .sm_name = "BA_TD_subSM",
};

/* ---------------- команды и события ---------------- */

/* stream_mgr__ba_disable (0x8c4200, 64 Б): WMI_VRING_BA_DIS. */
void stream_mgr_ba_disable(u32 vr)
{
    struct stream_ctx *s = stream_by_vr[vr];
    if (s == 0)
        fw_sysassert_fatal((void *)0, 0x128c);
    s->ba_en = 0;
    ba_sm_evt_type(s, 1, 0x25, 1, 0);
}

/* vring_ba_en__race_check (0x8c4240, 82 Б): WMI_VRING_BA_EN — стрим есть и не удаляется. */
void vring_ba_en_race_check(u32 vr, u32 agg, u32 timeout, u32 amsdu)
{
    struct stream_ctx *s = stream_by_vr[vr];
    if (s == 0) {
        fw_log_emit1(0x2b, 0x1010b94, vr);
        return;
    }
    if (s->removing == 1) {
        fw_log_emit1(0x2b, 0x1010be4, vr);
        return;
    }
    s->ba_en = 1;
    ba_sm_evt_type(s, 0, agg, timeout, amsdu);
}

/* wmi_vring_ba_dis (0x8fb490, 34 Б): {ringid, reserved, reason u16}. */
void wmi_vring_ba_dis(const u8 *cmd, u32 mid)
{
    (void)mid;
    if (cmd[0] >= 0xa)
        fw_sysassert_fatal((void *)0, 0x11de);
    stream_mgr_ba_disable(cmd[0]);
}

/* wmi_vring_ba_en (0x8fb4b4, 44 Б): {ringid, agg_max_wsize, ba_timeout u16, amsdu}. */
void wmi_vring_ba_en(const struct wmi_vring_ba_en_cmd *cmd, u32 mid)
{
    (void)mid;
    if (cmd->ringid >= 0xa)
        fw_sysassert_fatal((void *)0, 0x11dd);
    vring_ba_en_race_check(cmd->ringid, cmd->agg_max_wsize, cmd->ba_timeout, cmd->amsdu);
}

/* conn__sm_handle_event (0x8d9cc0, 8 Б): событие автомату разрыва соединения. */
void conn_sm_handle_event(struct conn *conn, u32 ev, u32 a0, u32 a1, u32 a2)
{
    conn_disc_event(&conn->msm.disc, ev, a0, a1, a2);
}

/* stream__inject_evt1 (0x8e8354, 12 Б): стримов соединения не осталось — событие 1. */
void stream_mgr_on_count_zero(struct conn *conn)
{
    conn_sm_handle_event(conn, 1, 0, 0, 0);
}

/* STREAM_MGR (0x8e2808, 122 Б): удалить первый стрим соединения (событие 6/0x24 →
 * stream_sm 10); если стримов нет — событие 1 соединению. Возврат 1 — стрим найден. */
u32 stream_mgr_remove_conn_stream(struct conn *conn, u32 a1, u32 a2)
{
    for (u32 i = 0; i < STREAM_VR_N; i++) {
        struct stream_ctx *s = stream_by_vr[i];
        if (s == 0 || s->conn != conn)
            continue;
        s->rm_flag = a1;
        s->rm_reason = a2;
        s->removing = 1;
        s->ba_en = 0;
        fw_log_emit2(0x2b, 0x1010c34, s->vr, conn->cid);
        ba_sm_evt_type(s, 6, 0x24, 0, 0);
        return 1;
    }
    fw_log_emit1(0x2b, 0x1010c68, conn->cid);
    stream_mgr_on_count_zero(conn);
    return 0;
}

/* vring_tbl__ptr_by_index (0x8cce84, 22 Б): стрим vring idx. */
struct stream_ctx *vring_tbl_ptr_by_index(u32 idx)
{
    return stream_by_vr[idx];
}

/* vring__enable_first_pending_gtk (0x8cd0a4, 96 Б): первый bcast-стрим (не 9) —
 * установить ключ группы (0x8eacb0) и событие 0x1865. */
void vring_enable_first_pending_gtk(void)
{
    for (u32 i = 0; i < STREAM_VR_N; i++) {
        struct stream_ctx *s = stream_by_vr[i];
        struct mid *m;
        if (s == 0 || s->bcast == 0 || s->vr == 9)
            continue;
        m = mid_list_by_mid_fw(s->mid);                            /* mid_list__by_obj_mid */
        vring_reinstall_key(s, 1, m->gtk_idx);                     /* add r15,r15,0x294; [+0x10] */
        fw_log_emit1(0x2b, 0x1010c98, m->gtk_idx);
        l2mgr_send_vring_en_evt((u8)i, s->mid);                    /* vring__send_en_evt_u8 */
        return;
    }
}

/* ---------------- ba_setup_sm: инициатор ADDBA (таблица 0x802988) ----------------
 * Объект — struct ba_setup_sm (include/stream.h), ctx + 0x18 = stream_sm + 8.
 * Состояния: 0 WAIT_FOR_START, 1 WAIT_FOR_PERMIT, 2 ADDBAREQ_CHECKING_MAX_RETRY,
 * 3 WAIT_ADDBAREQ_SENT, 4 WAIT_FOR_ADDBARSP, 5 ABORT_PENDING, 6 WAIT_FOR_VRING_STOP.
 * Путь запроса: 2 —(3 TX_PERMITTED: send_req)→ 3 —(4 TX_COMPLETE: req_sent, таймер ответа
 * [0x8002b0])→ 4; в 3 — (5 TX_FAILED: arm_retry, пауза [0x8002ac])→ 4; в 4 — (6 таймаут
 * ответа/паузы: ba_retry_flow)→ 2, после 30 попыток — отказ; ответ — 7 (resp). */


/* Поле u16 (младший байт первым) по невыровненному адресу (bf__set_field_u16 0x8edc34). */
static void bf16_le(u8 *p, u32 lo, u32 n, u32 v)
{
    u32 w = p[0] | ((u32)p[1] << 8);
    u32 m = ((1u << n) - 1u) << lo;
    w = (w & ~m) | ((v << lo) & m);
    p[0] = (u8)w;
    p[1] = (u8)(w >> 8);
}

/* Поле байта (bf__set_field_byte_fw 0x8edccc). */
static void bf8(u8 *p, u32 lo, u32 n, u32 v)
{
    u32 m = ((1u << n) - 1u) << lo;
    *p = (u8)((*p & ~m) | ((v << lo) & m));
}

/* vring_tbl__find_by_tid_cid (0x8cce44, 62 Б): обычный (не bcast) стрим TID соединения cid. */
struct stream_ctx *vring_tbl_find_by_tid_cid(u32 tid, u32 cid)
{
    for (u32 i = 0; i < STREAM_VR_N; i++) {
        struct stream_ctx *s = stream_by_vr[i];
        if (s == 0 || s->bcast != 0)
            continue;
        if (tid == s->tid && cid == s->conn->cid)
            return s;
    }
    return 0;
}

/* frame__build_addba_req (0x8f4dc8, 104 Б): тело действия ADDBA Request (9 Б). */
u32 frame_build_addba_req(struct ieee80211_addba *d, u32 token, u32 win, u32 tid, u32 timeout,
                          u32 ssn, u32 amsdu)
{
    memset0_words(d, sizeof(*d));
    d->category = ACT_CAT_BA;
    d->action = WLAN_ACT_ADDBA_REQ;
    d->params[0] = (u8)((d->params[0] & ~1u) | (amsdu & 1u));
    d->params[0] &= (u8)~2u;                      /* политика: немедленный BA */
    d->token = (u8)token;
    bf8(&d->params[0], 2, 4, tid & 0xfu);
    bf16_le(d->params, 6, 10, win & 0x3ffu);
    d->timeout[0] = (u8)timeout;
    d->timeout[1] = (u8)(timeout >> 8);
    bf16_le(d->ssn, 4, 12, ssn & 0xfffu);
    return sizeof(*d);
}

/* frame__build_delba (0x8f5004, 58 Б): тело действия DELBA (6 Б). */
u32 frame_build_delba(struct ieee80211_delba *d, u32 initiator, u32 tid, u32 reason)
{
    memset0_words(d, sizeof(*d));
    /* volatile: байтовые stb как у vendor (иначе gcc сливает их в stw — тело выровнено на 2) */
    *(volatile u8 *)&d->category = ACT_CAT_BA;
    *(volatile u8 *)&d->action = WLAN_ACT_DELBA;
    bf8(&d->params[1], 4, 4, tid & 0xfu);
    d->params[1] = (u8)((d->params[1] & ~8u) | ((initiator & 1u) << 3));
    d->reason = (u16)reason;
    return sizeof(*d);
}

/* Завершение TX ADDBA Request (0x8c30c4, 76 Б): событие 3 (успех) стриму TID. */
void ba_addba_req_tx_done(u32 pl, u32 status, u32 a2)
{
    struct conn *conn = (struct conn *)a2;
    if (conn == 0) {
        fw_log_emit0(0x1b, 0x1010930);
    } else {
        const struct ba_action_frame *f = (const struct ba_action_frame *)pl;
        struct stream_ctx *s = vring_tbl_find_by_tid_cid((f->addba_req.params[0] >> 2) & 0xfu,
                                                         conn->cid);
        if (s == 0)
            fw_log_emit0(0x1b, 0x10108f8);
        else
            ba_sm_evt_type(s, 3, status == 0, 0, 0);
    }
    TX_API_free_memory(pl);
}

/* stream_mgr__delba_tx_complete (0x8c8d14, 72 Б): событие 2 (успех) стриму TID. */
void stream_mgr_delba_tx_complete(u32 pl, u32 status, u32 a2)
{
    struct conn *conn = (struct conn *)a2;
    if (conn == 0) {
        fw_log_emit0(0x1b, 0x10109b4);
    } else {
        const struct ba_action_frame *f = (const struct ba_action_frame *)pl;
        struct stream_ctx *s = vring_tbl_find_by_tid_cid(f->delba.params[1] >> 4, conn->cid);
        if (s == 0)
            fw_log_emit0(0x1b, 0x1010980);
        else
            ba_sm_evt_type(s, 2, status == 0, 0, 0);
    }
    TX_API_free_memory(pl);
}

/* ba_sm__send_addba_req (0x8e50c8, 170 Б): кадр ADDBA Request соединению стрима. */
void ba_sm_send_addba_req(struct stream_sm *s, u32 token, u32 win, u32 timeout, u32 amsdu)
{
    u32 pl = TX_API_alloc_tx_payload();
    struct stream_ctx *ctx = s->ctx;
    struct mid *mid = mid_list_by_mid_fw(ctx->mid);            /* mid_list__by_obj_mid */
    u32 len;
    if (mid == 0)
        fw_sysassert_fatal((void *)0, 0x1283);
    len = 0;
    mgmt_tx_begin_frame(pl, &len, mid, ctx->conn, 0xd);
    /* Starting Sequence Number — SN первого MSDU под соглашением (802.11-2020 9.4.1.8, 10.25.2): текущее начало
     * окна TX MACQ стрима. Исправлено (vendor): ctx->ssn обновлялся только в ready (после ADDBA Response, при
     * остановке vring) — запрос уходил с прежним 0, а очередь начинает с 0x800 (стенд 2026-10-26: группа 3, слово 1
     * дескриптора = 0x800 = SN первого кадра под BA); получатель сдвигал окно костылём «1-st frame wrong sequence». */
    if (fixed_sched.enabled == 0)
        ctx->ssn = (u16)stream_mgr_prepare_buf30_by_id(vring_tbl_entry_addr(ctx->vr));
    len += frame_build_addba_req((struct ieee80211_addba *)(pl + len), (u8)token, win, ctx->tid, timeout,
                                 ctx->ssn, amsdu != 0);
    fw_log_emit2(0x2b, 0x10135bc, ctx->vr, ctx->tid);
    tx_api_send_mgmt(ctx->conn, 0, 1, pl, (u16)len, ba_addba_req_tx_done, 0);
}

/* ba_sm__send_delba (0x8e530c, 126 Б): кадр DELBA (инициатор) соединению стрима. */
void ba_sm_send_delba(struct stream_sm *s, u32 reason)
{
    u32 pl = TX_API_alloc_tx_payload();
    struct stream_ctx *ctx = s->ctx;
    struct mid *mid = mid_list_by_mid_fw(ctx->mid);
    u32 len;
    if (mid == 0)
        fw_sysassert_fatal((void *)0, 0x1282);
    len = 0;
    mgmt_tx_begin_frame(pl, &len, mid, ctx->conn, 0xd);
    len += frame_build_delba((struct ieee80211_delba *)(pl + len), 1, ctx->tid, reason);
    tx_api_send_mgmt(ctx->conn, 0, 1, pl, (u16)len, stream_mgr_delba_tx_complete, 0);
}

/* ba_setup_sm::close_addba_req_retry_timeout_event (0x8f1bb4, 36 Б). */
void ba_setup_close_retry_timer(struct ba_setup_sm *b)
{
    if (b->retry_timer != 0) {
        fw_log_emit0(0x27, 0x1013674);
        u_schd_cancel(b->retry_timer);
    }
    b->retry_timer = 0;
}

/* ba_setup_sm::close_addba_resp_timeout (0x8f1bd8, 36 Б). */
void ba_setup_close_resp_timer(struct ba_setup_sm *b)
{
    if (b->resp_timer != 0) {
        fw_log_emit0(0x27, 0x10135e8);
        u_schd_cancel(b->resp_timer);
    }
    b->resp_timer = 0;
}

/* ba_setup_sm::close_ba_setup_global_timeout (0x8f1bfc, 52 Б). */
void ba_setup_close_global_timer(struct ba_setup_sm *b)
{
    fw_log_emit0(0x27, 0x1013630);
    if (b->global_timer == 0)
        fw_sysassert_fatal((void *)0, 0x12c6);
    u_schd_cancel(b->global_timer);
    b->global_timer = 0;
}

/* ba_setup_sm__close_all_timers (0x8f1b84, 46 Б). */
void ba_setup_close_all_timers(struct ba_setup_sm *b)
{
    if (b->resp_timer != 0)
        ba_setup_close_resp_timer(b);
    if (b->global_timer != 0)
        ba_setup_close_global_timer(b);
    if (b->retry_timer != 0)
        ba_setup_close_retry_timer(b);
}

/* ba__retry_flow (0x8f1a48, 86 Б): ещё попытка (событие 3) либо, после 30, — отказ
 * (stream_sm 8 с ошибкой, событие 0xa). Сверено с vendor: brge r2,0x1e (со знаком),
 * add_s/extb перед записью — как здесь. */
void ba_retry_flow(struct ba_setup_sm *b)
{
    if ((s32)b->tries >= 0x1e) {
        fw_log_emit1(0x25, 0x10136cc, b->tries);
        ba_setup_close_global_timer(b);
        SM_EV(b->sm, 8, 1, 0, 0);
        SM_EV(b, 0xa, 0, 0, 0);
        return;
    }
    b->tries = (u8)(b->tries + 1);
    fw_log_emit1(0x25, 0x10136b4, b->tries);
    SM_EV(b, 3, 0, 0, 0);
}

/* Общий таймер установки (0x8f13b4, 68 Б): событие 0xb. */
void ba_setup_global_timeout_cb(u32 arg, u32 a1)
{
    struct ba_setup_sm *b = (struct ba_setup_sm *)arg;
    (void)a1;
    if (b == 0)
        fw_sysassert_fatal((void *)0, 0x1293);
    b->global_timer = 0;
    if (b->resp_timer != 0) {
        fw_log_emit0(0x15, 0x10137f0);
        ba_setup_close_resp_timer(b);
    }
    SM_EV(b, 0xb, 0, 0, 0);
}

/* Таймер повтора запроса (0x8f0ab4, 54 Б): событие 6. */
void ba_setup_retry_timeout_cb(u32 arg, u32 a1)
{
    struct ba_setup_sm *b = (struct ba_setup_sm *)arg;
    (void)a1;
    fw_log_emit0(0x25, 0x101385c);
    if (b == 0)
        fw_sysassert_fatal((void *)0, 0x1430);
    b->retry_timer = 0;
    SM_EV(b, 6, 0, 0, 0);
}

/* Таймер ответа ADDBA (0x8f0c1c, 54 Б): событие 6. */
void ba_setup_resp_timeout_cb(u32 arg, u32 a1)
{
    struct ba_setup_sm *b = (struct ba_setup_sm *)arg;
    (void)a1;
    fw_log_emit0(0x25, 0x1013834);
    if (b == 0)
        fw_sysassert_fatal((void *)0, 0x1539);
    b->resp_timer = 0;
    SM_EV(b, 6, 0, 0, 0);
}

/* (0x8f58f8, 18 Б): параметры BA_EN (окно, таймаут, amsdu), сброс попыток. */
void ba_setup_act_store(struct ba_setup_sm *b, u32 win, u32 timeout, u32 amsdu)
{
    b->win = (u8)win;
    b->req_win = (u8)win;
    b->timeout = (u16)timeout;
    b->req_timeout = (u16)timeout;
    b->amsdu = (u8)amsdu;
    b->req_amsdu = (u8)amsdu;
    b->tries = 0;
}

/* (0x8f99e4, 60 Б): старт — общий таймер [0x8002b8] и первая попытка. */
void ba_setup_act_start(struct ba_setup_sm *b)
{
    if (b->global_timer != 0)
        fw_sysassert_fatal((void *)0, 0x129a);
    b->global_timer = u_schd_schedule(ba_setup_global_timeout_cb, (u32)b, 0, 0,
                                      ba_setup_total_timeout, 0, 0);
    ba_retry_flow(b);
}

/* (0x8f866c, 24 Б): отправить ADDBA Request (новый dialog token). */
void ba_setup_act_send_req(struct ba_setup_sm *b)
{
    b->token = (u8)(b->token + 1);
    ba_sm_send_addba_req(b->sm, b->token, b->req_win, b->req_timeout, b->req_amsdu);
}

/* ba_setup_sm::addba_req_sent (0x8f0aec, 84 Б): ждать ответ — таймер [0x8002b0]. */
void ba_setup_act_req_sent(struct ba_setup_sm *b)
{
    u32 tsf[2];
    mac_read_tsf64(0, tsf, 0);
    fw_log_emit2(0x27, 0x10137c0, tsf[1], tsf[0]);
    if (b->resp_timer != 0)
        fw_sysassert_fatal((void *)0, 0x127f);
    b->resp_timer = u_schd_schedule(ba_setup_resp_timeout_cb, (u32)b, 0, 0,
                                    ba_addba_resp_timeout, 0, 0);
}

/* ba_setup_sm::addba_req_retry_timeout_cb (0x8f0a78, 58 Б): EVT_ADDBAREQ_TX_FAILED (в
 * WAIT_ADDBAREQ_SENT) — повтор через [0x8002ac]. Если retry_timer уже не 0 — не взводится
 * (как у vendor: brne_s r0,0 мимо u_schd_schedule). */
void ba_setup_act_arm_retry(struct ba_setup_sm *b)
{
    if (b->resp_timer != 0)
        fw_sysassert_fatal((void *)0, 0x1431);
    if (b->retry_timer == 0)
        b->retry_timer = u_schd_schedule(ba_setup_retry_timeout_cb, (u32)b, 0, 0,
                                         ba_addba_retry_delay, 0, 0);
}

/* ba_setup_sm::addba_req_tx_failed (0x8f0b40, 30 Б): только журнал (состояние
 * WAIT_FOR_VRING_STOP). */
void ba_setup_act_tx_failed(struct ba_setup_sm *b)
{
    fw_log_emit1(0x17, 0x1013888, b->hdr.state);
    fw_log_emit0(0x17, 0x10138c4);
}

#define BA_WIN_MAX 32u                    /* окно BA Sparrow (драйвер: WIL_MAX_AGG_WSIZE «FW/HW limit») */

/* ba_setup_sm::addba_resp (0x8f0b60, 184 Б): ответ ADDBA (тело действия f): при своём
 * dialog token — согласованные окно/таймаут/amsdu; статус 0 → успех (событие 8), иначе 9. */
void ba_setup_act_resp(struct ba_setup_sm *b, const struct ieee80211_addba_resp *r)
{
    u32 status = r->status[0] | ((u32)r->status[1] << 8);
    u32 win = ((r->params[0] | ((u32)r->params[1] << 8)) >> 6) & 0x3ffu;
    u32 to = r->timeout[0] | ((u32)r->timeout[1] << 8);
    ba_setup_close_resp_timer(b);
    fw_log_emit3(0x27, 0x1013734, status, win, to);
    if (b->token != r->token)
        return;
    fw_log_emit2(0x27, 0x1013764, r->params[0] & 1u, (r->params[0] >> 1) & 1u);
    if ((s32)win < (s32)b->req_win)
        fw_log_emit2(0x27, 0x101378c, win, b->req_win);
    /* Ошибка vendor (исправлено): Buffer Size — 10 бит (9.4.1.13), сужался в u8; ответ SUCCESS с 0/256/512/768
     * давал окно 0 и фатальный ассерт 0x133e (из эфира). Окно передачи — не больше ответа, нашего запроса и
     * предела железа (BA_WIN_MAX); SUCCESS с Buffer Size 0 — отказ установки. */
    if (b->req_win != 0 && win > b->req_win)
        win = b->req_win;
    if (win > BA_WIN_MAX)
        win = BA_WIN_MAX;
    b->win = (u8)win;
    b->timeout = (u16)to;
    b->amsdu = r->params[0] & 1u;
    if (status != 0 || win == 0) {
        SM_EV(b, 9, 0, 0, 0);
    } else {
        ba_setup_close_global_timer(b);
        SM_EV(b, 8, 0, 0, 0);
    }
}

/* ba_setup_sm::addba_session_success_ntf (0x8f0c70, 36 Б): stream_sm событие 7 (успех). */
void ba_setup_act_success(struct ba_setup_sm *b)
{
    fw_log_emit1(0x25, 0x10136f4, b->win);
    SM_EV(b->sm, 7, 0, 0, 0);
}

/* (0x8f0c54, 28 Б): прервано — таймеры, stream_sm событие 8 (ошибка). */
void ba_setup_act_abort(struct ba_setup_sm *b)
{
    ba_setup_close_all_timers(b);
    SM_EV(b->sm, 8, 1, 0, 0);
}

/* (0x8f7fdc, 32 Б): stream_sm событие 0xb, таймеры. */
void ba_setup_act_finish(struct ba_setup_sm *b)
{
    SM_EV(b->sm, 0xb, 0, 0, 0);
    ba_setup_close_all_timers(b);
}

/* (0x8f95b0, 10 Б; второе имя vendor scan_mngr__start_connection_cb ошибочно):
 * vt[3] контекста стрима (приостановить vring). */
void ba_setup_act_suspend(struct ba_setup_sm *b)
{
    struct stream_ctx *ctx = b->sm->ctx;
    ctx->vt->suspend_b(ctx);
}

/* 0x802988: таблица переходов ba_setup_sm [событие][состояние] (событий 13, состояний 7) —
 * {действие, следующее состояние}; комментарий — «состояние → следующее» по vendor-именам. */
FWDATA(802988) const struct sm_trans ba_setup_sm_trans[13][7] = {
    [0] = {   /* EVT_START */
        { SM_ACT(ba_setup_act_store), 1 },                   /* WAIT_FOR_START_STATE → WAIT_FOR_PERMIT_STATE */
        { SM_ACT(basic_sm_error_handler), 1 },               /* WAIT_FOR_PERMIT_STATE → WAIT_FOR_PERMIT_STATE */
        { SM_ACT(basic_sm_error_handler), 2 },               /* ADDBAREQ_CHECKING_MAX_RETRY_STATE → ADDBAREQ_CHECKING_MAX_RETRY_STATE */
        { SM_ACT(basic_sm_error_handler), 3 },               /* WAIT_ADDBAREQ_SENT_STATE → WAIT_ADDBAREQ_SENT_STATE */
        { SM_ACT(basic_sm_error_handler), 4 },               /* WAIT_FOR_ADDBARSP_STATE → WAIT_FOR_ADDBARSP_STATE */
        { SM_ACT(basic_sm_error_handler), 5 },               /* ABORT_PENDING_STATE → ABORT_PENDING_STATE */
        { SM_ACT(basic_sm_error_handler), 6 },               /* WAIT_FOR_VRING_STOP_STATE → WAIT_FOR_VRING_STOP_STATE */
    },
    [1] = {   /* EVT_READY_TO_RUN */
        { SM_ACT(basic_sm_error_handler), 0 },               /* WAIT_FOR_START_STATE → WAIT_FOR_START_STATE */
        { SM_ACT(ba_setup_act_start), 2 },                   /* WAIT_FOR_PERMIT_STATE → ADDBAREQ_CHECKING_MAX_RETRY_STATE */
        { SM_ACT(basic_sm_error_handler), 2 },               /* ADDBAREQ_CHECKING_MAX_RETRY_STATE → ADDBAREQ_CHECKING_MAX_RETRY_STATE */
        { SM_ACT(basic_sm_error_handler), 3 },               /* WAIT_ADDBAREQ_SENT_STATE → WAIT_ADDBAREQ_SENT_STATE */
        { SM_ACT(basic_sm_error_handler), 4 },               /* WAIT_FOR_ADDBARSP_STATE → WAIT_FOR_ADDBARSP_STATE */
        { SM_ACT(basic_sm_error_handler), 5 },               /* ABORT_PENDING_STATE → ABORT_PENDING_STATE */
        { SM_ACT(basic_sm_error_handler), 6 },               /* WAIT_FOR_VRING_STOP_STATE → WAIT_FOR_VRING_STOP_STATE */
    },
    [2] = {   /* EVT_VRING_STOPPED */
        { SM_ACT(basic_sm_error_handler), 0 },               /* WAIT_FOR_START_STATE → WAIT_FOR_START_STATE */
        { SM_ACT(basic_sm_error_handler), 1 },               /* WAIT_FOR_PERMIT_STATE → WAIT_FOR_PERMIT_STATE */
        { SM_ACT(basic_sm_error_handler), 2 },               /* ADDBAREQ_CHECKING_MAX_RETRY_STATE → ADDBAREQ_CHECKING_MAX_RETRY_STATE */
        { SM_ACT(basic_sm_error_handler), 3 },               /* WAIT_ADDBAREQ_SENT_STATE → WAIT_ADDBAREQ_SENT_STATE */
        { SM_ACT(basic_sm_error_handler), 4 },               /* WAIT_FOR_ADDBARSP_STATE → WAIT_FOR_ADDBARSP_STATE */
        { SM_ACT(basic_sm_error_handler), 5 },               /* ABORT_PENDING_STATE → ABORT_PENDING_STATE */
        { SM_ACT(ba_setup_act_success), 0 },                 /* WAIT_FOR_VRING_STOP_STATE → WAIT_FOR_START_STATE */
    },
    [3] = {   /* EVT_TX_PERMITTED */
        { SM_ACT(basic_sm_error_handler), 0 },               /* WAIT_FOR_START_STATE → WAIT_FOR_START_STATE */
        { SM_ACT(basic_sm_error_handler), 2 },               /* WAIT_FOR_PERMIT_STATE → ADDBAREQ_CHECKING_MAX_RETRY_STATE */
        { SM_ACT(ba_setup_act_send_req), 3 },                /* ADDBAREQ_CHECKING_MAX_RETRY_STATE → WAIT_ADDBAREQ_SENT_STATE */
        { SM_ACT(basic_sm_error_handler), 3 },               /* WAIT_ADDBAREQ_SENT_STATE → WAIT_ADDBAREQ_SENT_STATE */
        { SM_ACT(basic_sm_error_handler), 4 },               /* WAIT_FOR_ADDBARSP_STATE → WAIT_FOR_ADDBARSP_STATE */
        { SM_ACT(basic_sm_error_handler), 5 },               /* ABORT_PENDING_STATE → ABORT_PENDING_STATE */
        { SM_ACT(basic_sm_error_handler), 6 },               /* WAIT_FOR_VRING_STOP_STATE → WAIT_FOR_VRING_STOP_STATE */
    },
    [4] = {   /* EVT_ADDBAREQ_TX_COMPLETE */
        { SM_ACT(sm_action_nop_b), 0 },                      /* WAIT_FOR_START_STATE → WAIT_FOR_START_STATE */
        { SM_ACT(sm_action_nop_b), 1 },                      /* WAIT_FOR_PERMIT_STATE → WAIT_FOR_PERMIT_STATE */
        { SM_ACT(sm_action_nop_b), 2 },                      /* ADDBAREQ_CHECKING_MAX_RETRY_STATE → ADDBAREQ_CHECKING_MAX_RETRY_STATE */
        { SM_ACT(ba_setup_act_req_sent), 4 },                /* WAIT_ADDBAREQ_SENT_STATE → WAIT_FOR_ADDBARSP_STATE */
        { SM_ACT(sm_action_nop_b), 4 },                      /* WAIT_FOR_ADDBARSP_STATE → WAIT_FOR_ADDBARSP_STATE */
        { SM_ACT(ba_setup_act_finish), 0 },                  /* ABORT_PENDING_STATE → WAIT_FOR_START_STATE */
        { SM_ACT(sm_action_nop_b), 6 },                      /* WAIT_FOR_VRING_STOP_STATE → WAIT_FOR_VRING_STOP_STATE */
    },
    [5] = {   /* EVT_ADDBAREQ_TX_FAILED */
        { SM_ACT(sm_action_nop_b), 0 },                      /* WAIT_FOR_START_STATE → WAIT_FOR_START_STATE */
        { SM_ACT(sm_action_nop_b), 1 },                      /* WAIT_FOR_PERMIT_STATE → WAIT_FOR_PERMIT_STATE */
        { SM_ACT(sm_action_nop_b), 2 },                      /* ADDBAREQ_CHECKING_MAX_RETRY_STATE → ADDBAREQ_CHECKING_MAX_RETRY_STATE */
        { SM_ACT(ba_setup_act_arm_retry), 4 },               /* WAIT_ADDBAREQ_SENT_STATE → WAIT_FOR_ADDBARSP_STATE */
        { SM_ACT(sm_action_nop_b), 4 },                      /* WAIT_FOR_ADDBARSP_STATE → WAIT_FOR_ADDBARSP_STATE */
        { SM_ACT(ba_setup_act_finish), 0 },                  /* ABORT_PENDING_STATE → WAIT_FOR_START_STATE */
        { SM_ACT(ba_setup_act_tx_failed), 6 },               /* WAIT_FOR_VRING_STOP_STATE → WAIT_FOR_VRING_STOP_STATE */
    },
    [6] = {   /* EVT_ADDBARSP_TIMEOUT */
        { SM_ACT(sm_action_nop_b), 0 },                      /* WAIT_FOR_START_STATE → WAIT_FOR_START_STATE */
        { SM_ACT(basic_sm_error_handler), 1 },               /* WAIT_FOR_PERMIT_STATE → WAIT_FOR_PERMIT_STATE */
        { SM_ACT(basic_sm_error_handler), 2 },               /* ADDBAREQ_CHECKING_MAX_RETRY_STATE → ADDBAREQ_CHECKING_MAX_RETRY_STATE */
        { SM_ACT(sm_action_nop_b), 0 },                      /* WAIT_ADDBAREQ_SENT_STATE → WAIT_FOR_START_STATE */
        { SM_ACT(ba_retry_flow), 2 },                        /* WAIT_FOR_ADDBARSP_STATE → ADDBAREQ_CHECKING_MAX_RETRY_STATE */
        { SM_ACT(basic_sm_error_handler), 5 },               /* ABORT_PENDING_STATE → ABORT_PENDING_STATE */
        { SM_ACT(sm_action_nop_b), 6 },                      /* WAIT_FOR_VRING_STOP_STATE → WAIT_FOR_VRING_STOP_STATE */
    },
    [7] = {   /* EVT_ADDBARSP_ARRIVED */
        { SM_ACT(sm_action_nop_b), 0 },                      /* WAIT_FOR_START_STATE → WAIT_FOR_START_STATE */
        { SM_ACT(sm_action_nop_b), 1 },                      /* WAIT_FOR_PERMIT_STATE → WAIT_FOR_PERMIT_STATE */
        { SM_ACT(sm_action_nop_b), 2 },                      /* ADDBAREQ_CHECKING_MAX_RETRY_STATE → ADDBAREQ_CHECKING_MAX_RETRY_STATE */
        { SM_ACT(ba_setup_act_resp), 4 },                    /* WAIT_ADDBAREQ_SENT_STATE → WAIT_FOR_ADDBARSP_STATE */
        { SM_ACT(ba_setup_act_resp), 4 },                    /* WAIT_FOR_ADDBARSP_STATE → WAIT_FOR_ADDBARSP_STATE */
        { SM_ACT(basic_sm_error_handler), 5 },               /* ABORT_PENDING_STATE → ABORT_PENDING_STATE */
        { SM_ACT(sm_action_nop_b), 6 },                      /* WAIT_FOR_VRING_STOP_STATE → WAIT_FOR_VRING_STOP_STATE */
    },
    [8] = {   /* EVT_ACCEPT_RECEIVED_ADDBARSP */
        { SM_ACT(basic_sm_error_handler), 0 },               /* WAIT_FOR_START_STATE → WAIT_FOR_START_STATE */
        { SM_ACT(basic_sm_error_handler), 1 },               /* WAIT_FOR_PERMIT_STATE → WAIT_FOR_PERMIT_STATE */
        { SM_ACT(basic_sm_error_handler), 2 },               /* ADDBAREQ_CHECKING_MAX_RETRY_STATE → ADDBAREQ_CHECKING_MAX_RETRY_STATE */
        { SM_ACT(basic_sm_error_handler), 3 },               /* WAIT_ADDBAREQ_SENT_STATE → WAIT_ADDBAREQ_SENT_STATE */
        { SM_ACT(ba_setup_act_suspend), 6 },                 /* WAIT_FOR_ADDBARSP_STATE → WAIT_FOR_VRING_STOP_STATE */
        { SM_ACT(basic_sm_error_handler), 5 },               /* ABORT_PENDING_STATE → ABORT_PENDING_STATE */
        { SM_ACT(sm_action_nop_b), 6 },                      /* WAIT_FOR_VRING_STOP_STATE → WAIT_FOR_VRING_STOP_STATE */
    },
    [9] = {   /* EVT_DISCARD_RECEIVED_ADDBARSP */
        { SM_ACT(basic_sm_error_handler), 0 },               /* WAIT_FOR_START_STATE → WAIT_FOR_START_STATE */
        { SM_ACT(basic_sm_error_handler), 1 },               /* WAIT_FOR_PERMIT_STATE → WAIT_FOR_PERMIT_STATE */
        { SM_ACT(basic_sm_error_handler), 2 },               /* ADDBAREQ_CHECKING_MAX_RETRY_STATE → ADDBAREQ_CHECKING_MAX_RETRY_STATE */
        { SM_ACT(basic_sm_error_handler), 3 },               /* WAIT_ADDBAREQ_SENT_STATE → WAIT_ADDBAREQ_SENT_STATE */
        { SM_ACT(ba_setup_act_arm_retry), 4 },               /* WAIT_FOR_ADDBARSP_STATE → WAIT_FOR_ADDBARSP_STATE */
        { SM_ACT(basic_sm_error_handler), 5 },               /* ABORT_PENDING_STATE → ABORT_PENDING_STATE */
        { SM_ACT(basic_sm_error_handler), 6 },               /* WAIT_FOR_VRING_STOP_STATE → WAIT_FOR_VRING_STOP_STATE */
    },
    [10] = {   /* EVT_MAX_RETRY_TH_PASS */
        { SM_ACT(basic_sm_error_handler), 0 },               /* WAIT_FOR_START_STATE → WAIT_FOR_START_STATE */
        { SM_ACT(basic_sm_error_handler), 1 },               /* WAIT_FOR_PERMIT_STATE → WAIT_FOR_PERMIT_STATE */
        { SM_ACT(sm_action_nop_b), 0 },                      /* ADDBAREQ_CHECKING_MAX_RETRY_STATE → WAIT_FOR_START_STATE */
        { SM_ACT(basic_sm_error_handler), 3 },               /* WAIT_ADDBAREQ_SENT_STATE → WAIT_ADDBAREQ_SENT_STATE */
        { SM_ACT(basic_sm_error_handler), 2 },               /* WAIT_FOR_ADDBARSP_STATE → ADDBAREQ_CHECKING_MAX_RETRY_STATE */
        { SM_ACT(basic_sm_error_handler), 5 },               /* ABORT_PENDING_STATE → ABORT_PENDING_STATE */
        { SM_ACT(basic_sm_error_handler), 6 },               /* WAIT_FOR_VRING_STOP_STATE → WAIT_FOR_VRING_STOP_STATE */
    },
    [11] = {   /* EVT_BA_SETUP_GLOBAL_TIMEOUT */
        { SM_ACT(sm_action_nop_b), 0 },                      /* WAIT_FOR_START_STATE → WAIT_FOR_START_STATE */
        { SM_ACT(basic_sm_error_handler), 1 },               /* WAIT_FOR_PERMIT_STATE → WAIT_FOR_PERMIT_STATE */
        { SM_ACT(ba_setup_act_abort), 0 },                   /* ADDBAREQ_CHECKING_MAX_RETRY_STATE → WAIT_FOR_START_STATE */
        { SM_ACT(ba_setup_act_abort), 0 },                   /* WAIT_ADDBAREQ_SENT_STATE → WAIT_FOR_START_STATE */
        { SM_ACT(ba_setup_act_abort), 0 },                   /* WAIT_FOR_ADDBARSP_STATE → WAIT_FOR_START_STATE */
        { SM_ACT(basic_sm_error_handler), 5 },               /* ABORT_PENDING_STATE → ABORT_PENDING_STATE */
        { SM_ACT(basic_sm_error_handler), 6 },               /* WAIT_FOR_VRING_STOP_STATE → WAIT_FOR_VRING_STOP_STATE */
    },
    [12] = {   /* EVT_ABORT */
        { SM_ACT(basic_sm_error_handler), 0 },               /* WAIT_FOR_START_STATE → WAIT_FOR_START_STATE */
        { SM_ACT(sm_action_nop_b), 0 },                      /* WAIT_FOR_PERMIT_STATE → WAIT_FOR_START_STATE */
        { SM_ACT(ba_setup_act_finish), 0 },                  /* ADDBAREQ_CHECKING_MAX_RETRY_STATE → WAIT_FOR_START_STATE */
        { SM_ACT(ba_setup_act_finish), 0 },                  /* WAIT_ADDBAREQ_SENT_STATE → WAIT_FOR_START_STATE */
        { SM_ACT(ba_setup_act_finish), 0 },                  /* WAIT_FOR_ADDBARSP_STATE → WAIT_FOR_START_STATE */
        { SM_ACT(basic_sm_error_handler), 5 },               /* ABORT_PENDING_STATE → ABORT_PENDING_STATE */
        { SM_ACT(sm_action_nop_b), 0 },                      /* WAIT_FOR_VRING_STOP_STATE → WAIT_FOR_START_STATE */
    },
};
/* 0x802b50: описатель ba_setup_sm (состояний 7, событий 13, старт WAIT_FOR_START_STATE); ид [0x10] пишет
 * статический конструктор. Имена — массивы ид строк журнала в fw_data. */
extern const u32 ba_setup_sm_state_names[7];   /* определение ниже */
extern const u32 ba_setup_sm_event_names[13];   /* определение ниже */
FWDATA(802b50) struct sm_desc ba_setup_sm_desc = {
    .n_events = 13, .n_states = 7, .init_state = 0,
    .table = &ba_setup_sm_trans[0][0],
    .state_names = ba_setup_sm_state_names,   /* {WAIT_FOR_START_STATE, WAIT_FOR_PERMIT_STATE, ADDBAREQ_CHECKING_MAX_RETRY_STATE, WAIT_ADDBAREQ_SENT_STATE, WAIT_FOR_ADDBARSP_STATE, ABORT_PENDING_STATE, WAIT_FOR_VRING_STOP_STATE} */
    .event_names = ba_setup_sm_event_names,
};

/* ---------------- кадры BA от пира и команды RX-BA хоста ---------------- */


/* frame__build_addba_resp (0x8f4e30, 106 Б): тело ADDBA Response (9 Б). */
u32 frame_build_addba_resp(struct ieee80211_addba_resp *d, u32 token, u32 win, u32 tid, u32 timeout,
                           u32 status, u32 amsdu)
{
    memset0_words(d, sizeof(*d));
    d->category = ACT_CAT_BA;
    d->action = WLAN_ACT_ADDBA_RESP;
    d->token = (u8)token;
    d->status[0] = (u8)status;
    d->params[0] = (u8)((d->params[0] & ~1u) | (amsdu & 1u));
    d->params[0] &= (u8)~2u;
    d->status[1] = (u8)(status >> 8);
    bf8(&d->params[0], 2, 4, tid & 0xfu);
    bf16_le(d->params, 6, 10, win & 0x3ffu);
    d->timeout[0] = (u8)timeout;
    d->timeout[1] = (u8)(timeout >> 8);
    return sizeof(*d);
}

/* stream_mgr::addba_req_handler (0x8c3028, 154 Б): ADDBA Request пира (тело действия f)
 * → WMI_ADDBA_REQ_EVENT (0x1824) хосту. */
void stream_mgr_addba_req_handler(const struct ieee80211_addba *f, u32 cid)
{
    struct conn *conn;
    struct wmi_addba_req_event *e;
    fw_log_emit0(0x2b, 0x10104b8);
    conn = conn_mgr_by_cid(cid);
    if (conn == 0) {
        fw_log_emit0(0x1b, 0x10104ec);
        return;
    }
    e = host_if_send_pair();
    e->cidxtid = (u8)((((f->params[0] >> 2) & 0xfu) << 4) | (cid & 0xfu));
    e->dialog_token = f->token;
    e->ba_param_set = (u16)(f->params[0] | ((u32)f->params[1] << 8));
    e->ba_timeout = (u16)(f->timeout[0] | ((u32)f->timeout[1] << 8));
    e->ba_seq_ctrl = (u16)(f->ssn[0] | ((u32)f->ssn[1] << 8));
    fw_log_emit1(0x2b, 0x1010520, conn->mid->id);
    low_sme_send_evt2sw(e, 0x1824, 8, conn->mid->id, 0, 0, 0);
}

/* stream_mgr::addba_rsp_handler (0x8c3124, 48 Б): ADDBA Response пира → stream_sm. */
void stream_mgr_addba_rsp_handler(const struct ieee80211_addba_resp *f, u32 cid)
{
    struct stream_ctx *s = vring_tbl_find_by_tid_cid((f->params[0] >> 2) & 0xfu, cid);
    if (s == 0) {
        fw_log_emit0(0x1b, 0x101055c);
        return;
    }
    ba_sm_evt_type(s, 4, (u32)f, 0, 0);
}

/* stream_mgr::delba_handler (0x8c8c18, 252 Б): DELBA пира — для нашей (TX) сессии
 * событие стриму, для сессии пира (инициатор) — WMI_DELBA_EVENT (0x1826) хосту;
 * для стрима 9 — разрыв соединения. */
void stream_mgr_delba_handler(const struct ieee80211_delba *f, u32 cid)
{
    struct stream_ctx *s = vring_tbl_find_by_tid_cid(f->params[1] >> 4, cid);
    struct conn *conn = conn_mgr_by_cid(cid);
    if (s != 0)
        fw_log_emit2(0x2b, 0x1010590, cid, s->tid);
    else
        fw_log_emit1(0x2b, 0x10105b4, cid);
    fw_log_emit1(0x2b, 0x10105e0, f->reason);
    if (conn == 0) {
        fw_log_emit0(0x1b, 0x1010614);
        return;
    }
    /* DELBA от инициатора (B11 = 1) снимает сессию, где получатель — мы: TX-стрима у неё нет. vendor требовал
     * TX-стрим по TID (иначе DELBA терялся, хост не снимал RX-reorder) и при стриме 9 рвал соединение. Теперь
     * хосту — всегда, до проверок TX-стрима. */
    if ((f->params[1] >> 3) & 1u) {
        struct wmi_delba_event *e;
        fw_log_emit0(0x2b, 0x1010658);
        e = host_if_send_pair();
        e->from_initiator = 1;
        e->cidxtid = (u8)((cid & 0xfu) | ((f->params[1] >> 4) << 4));
        e->reason = f->reason;
        fw_log_emit1(0x2b, 0x1010688, conn->mid->id);
        low_sme_send_evt2sw(e, 0x1826, 4, conn->mid->id, 0, 0, 0);
        return;
    }
    if (s == 0) {
        fw_log_emit0(0x1b, 0x1010614);
        return;
    }
    if (s->vr == 9) {
        fw_log_emit0(0x2b, 0x1010644);
        conn_disconnect(conn, 3, 3);
        return;
    }
    s->ba_en = 0;
    ba_sm_evt_type(s, 5, f->reason, 0, 0);
}

/* wmi_rcp_addba_resp (0x8ecbe8, 308 Б): WMI_RCP_ADDBA_RESP {cidxtid, dialog_token,
 * status_code u16, ba_param_set u16, ba_timeout u16} — кадр ADDBA Response пиру,
 * WMI_RCP_ADDBA_RESP_SENT_EVENT (0x1825) {cidxtid, status u16} хосту, правило ключа TID. */
void wmi_rcp_addba_resp(const struct wmi_rcp_addba_resp_cmd *cmd, u32 mid)
{
    u32 pl = TX_API_alloc_tx_payload();
    u32 cid = cmd->cidxtid & 0xfu;
    u32 tid = cmd->cidxtid >> 4;
    struct conn *conn = conn_mgr_by_cid(cid);
    struct mid *m;
    u32 len;
    struct wmi_rcp_addba_resp_sent_event *e;
    if (conn == 0) {
        TX_API_free_memory(pl);                     /* vendor не освобождал — утечка элемента TX-пула */
        e = host_if_send_pair();
        e->cidxtid = cmd->cidxtid;
        e->status = 1;
        fw_log_emit1(0x2b, 0x1007a24, mid);
        low_sme_send_evt2sw(e, 0x1825, 4, mid, 0, 0, 0);
        return;
    }
    m = mid_list_by_mid_fw(mid);
    if (m == 0)
        fw_sysassert_fatal((void *)0, 0x106e);
    len = 0;
    mgmt_tx_begin_frame(pl, &len, m, conn, 0xd);
    fw_log_emit3(0x23, 0x1007a7c, tid & 0xfu, cmd->ba_param_set >> 6, cmd->dialog_token);
    len += frame_build_addba_resp((struct ieee80211_addba_resp *)(pl + len), cmd->dialog_token,
                                  cmd->ba_param_set >> 6, tid & 0xfu, cmd->ba_timeout, cmd->status_code,
                                  cmd->ba_param_set & 1u);
    tx_api_send_mgmt(conn, 0, 1, pl, (u16)len, 0, 0);
    e = host_if_send_pair();
    e->status = 0;
    e->cidxtid = cmd->cidxtid;
    fw_log_emit1(0x2b, 0x1007aac, mid);
    low_sme_send_evt2sw(e, 0x1825, 4, mid, 0, 0, 0);
    install_key_parse_flags(cid, tid & 0xfu, 2);
}

/* wmi_rcp_delba (0x8ecd1c, 172 Б): WMI_RCP_DELBA {cidxtid, reserved, reason u16} — DELBA
 * (получатель) пиру. vendor кладёт в поле TID (cidxtid >> 4) & 0xf0 — всегда 0
 * (8ecd6c: and r2,r16,0xf0 после сдвига): DELBA для TID ≠ 0 уходил с TID 0 вопреки
 * 802.11-2016 9.4.1.16. Здесь — TID сессии. */
void wmi_rcp_delba(const struct wmi_rcp_delba_cmd *cmd, u32 mid)
{
    struct mid *m = mid_list_by_mid_fw(mid);
    u32 tid, pl, len = 0;
    struct conn *conn;
    if (m == 0)
        fw_sysassert_fatal((void *)0, 0x106f);
    tid = cmd->cidxtid >> 4;
    conn = conn_mgr_by_cid(cmd->cidxtid & 0xfu);
    pl = TX_API_alloc_tx_payload();
    if (pl == 0)
        fw_sysassert_fatal((void *)0, 0x1070);
    if (m == 0)
        fw_sysassert_fatal((void *)0, 0x1071);
    if (conn == 0)
        fw_sysassert_fatal((void *)0, 0x1072);
    mgmt_tx_begin_frame(pl, &len, m, conn, 0xd);
    len += frame_build_delba((struct ieee80211_delba *)(pl + len), 0, tid & 0xfu, cmd->reason);
    tx_api_send_mgmt(conn, 0, 1, pl, (u16)len, 0, 0);
}

/* ======================= имена состояний и событий автоматов (fw_data) ======================= */

/* 0x801318: имена состояний ba_sm (описатель 0x80296c). */
FWDATA(801318) const u32 ba_sm_state_names[5] = {
    0x0101fff4,   /* NOT_BA_AGR_STATE */
    0x01020005,   /* BA_SETUP_STATE */
    0x01020014,   /* BA_AGREED_STATE */
    0x01020024,   /* BA_TEARDOWN_STATE */
    0x01020036,   /* WAIT_REMOVE_STREAM_STATE */
};

/* 0x80132c: имена событий ba_sm (описатель 0x80296c). */
FWDATA(80132c) const u32 ba_sm_event_names[12] = {
    0x0102004f,   /* EVT_START_BA_SETUP */
    0x01020062,   /* EVT_START_BA_TEARDOWN */
    0x01020078,   /* EVT_VRING_STOPPED */
    0x0102008a,   /* EVT_ADDBAREQ_TX_COMPLETE */
    0x010200a3,   /* EVT_ADDBARSP_ARRIVED */
    0x010200b8,   /* EVT_DELBA_TX_COMPLETE */
    0x010200ce,   /* EVT_RCP_DELBA_ARRIVED */
    0x010200e4,   /* EVT_BA_SETUP_SUCCESS_NTF */
    0x010200fd,   /* EVT_BA_SETUP_FAIL_NTF */
    0x01020113,   /* EVT_BA_TEARDOWN_DONE_NTF */
    0x0102012c,   /* EVT_REMOVE_STREAM */
    0x0102013e,   /* EVT_BA_SETUP_SM_ABORT_DONE */
};

/* 0x801368: имена состояний ba_setup_sm (описатель 0x802b50). */
FWDATA(801368) const u32 ba_setup_sm_state_names[7] = {
    0x01020160,   /* WAIT_FOR_START_STATE */
    0x01020175,   /* WAIT_FOR_PERMIT_STATE */
    0x0102018b,   /* ADDBAREQ_CHECKING_MAX_RETRY_STATE */
    0x010201ad,   /* WAIT_ADDBAREQ_SENT_STATE */
    0x010201c6,   /* WAIT_FOR_ADDBARSP_STATE */
    0x010201de,   /* ABORT_PENDING_STATE */
    0x010201f2,   /* WAIT_FOR_VRING_STOP_STATE */
};

/* 0x801384: имена событий ba_setup_sm (описатель 0x802b50). */
FWDATA(801384) const u32 ba_setup_sm_event_names[13] = {
    0x0102020c,   /* EVT_START */
    0x01020216,   /* EVT_READY_TO_RUN */
    0x01020227,   /* EVT_VRING_STOPPED */
    0x01020239,   /* EVT_TX_PERMITTED */
    0x0102024a,   /* EVT_ADDBAREQ_TX_COMPLETE */
    0x01020263,   /* EVT_ADDBAREQ_TX_FAILED */
    0x0102027a,   /* EVT_ADDBARSP_TIMEOUT */
    0x0102028f,   /* EVT_ADDBARSP_ARRIVED */
    0x010202a4,   /* EVT_ACCEPT_RECEIVED_ADDBARSP */
    0x010202c1,   /* EVT_DISCARD_RECEIVED_ADDBARSP */
    0x010202df,   /* EVT_MAX_RETRY_TH_PASS */
    0x010202f5,   /* EVT_BA_SETUP_GLOBAL_TIMEOUT */
    0x01020311,   /* EVT_ABORT */
};

/* 0x8013c4: имена состояний wait_sm (описатель 0x802ba0) — адреса строк в DCCM (0x802bb4..). */
FWDATA(8013c4) const u32 ba_wait_sm_state_names[3] = {
    0x00802bb4,   /* WAIT_FOR_START */
    0x00802bc3,   /* WAIT_FOR_PERMIT */
    0x00802bd3,   /* WAIT_FOR_DELBA_TX_COMPLETE */
};

/* 0x8013d0: имена событий wait_sm (описатель 0x802ba0) — адреса строк в DCCM. */
FWDATA(8013d0) const u32 ba_wait_sm_event_names[4] = {
    0x00802bee,   /* START */
    0x00802bf4,   /* READY_TO_RUN */
    0x00802c01,   /* DELBA_TX_COMPLETE */
    0x00802c13,   /* RCP_DELBA_ARRIVED */
};
