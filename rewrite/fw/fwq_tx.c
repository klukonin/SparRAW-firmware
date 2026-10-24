// SPDX-License-Identifier: AGPL-3.0-or-later
/* TX_API / fwq_tx — отправка собственных кадров fw (управление, служебные данные)
 * через DMA-кольца TX и разбор их завершений.
 *
 * Три объекта TX_API (struct fwq_tx, include/fwq_tx.h): tx_api_mgmt (управление, кольцо
 * DMA 6, MACQ 0x1a), tx_api_2 (кольцо 3, MACQ 0x1e), tx_api_data (данные, кольцо 5, MACQ
 * 0x19). Кадр — struct tx_pkt (пул 0x842304). Таблицы методов — ниже, в fw_data по адресам
 * vendor (конструкторы ставят указатели на них). */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/fwq_tx.h"
#include "../include/vring_schd.h"
#include "../include/fwdata.h"
#include "../include/power.h"
#include "../include/conn.h"

/* fw_tx_packet_error_buffer (0x805ac0, 0x524 Б; в образе нули): кадр «пул пуст», статус 0xfd. */
FWDATA(805ac0) struct tx_pkt tx_err_buf = { 0 };

/* Режимы TX-очередей DMA по MACQ (vendor 0x8031c8, только чтение). */
/* Не const: vendor читает таблицу из памяти (ldb [0x8031c8+…]), gcc не должен сворачивать. */
FWDATA(8031c8) struct txq_dma_mode txq_dma_mode_tbl[32] = {
    { 0x00, 0 }, { 0x01, 0 }, { 0x02, 0 }, { 0x03, 0 }, { 0x04, 0 }, { 0x05, 0 }, { 0x06, 0 }, { 0x07, 0 },
    { 0x08, 0 }, { 0x09, 0 }, { 0x0a, 0 }, { 0x0b, 0 }, { 0x0c, 0 }, { 0x0d, 0 }, { 0x0e, 0 }, { 0x0f, 0 },
    { 0x10, 0 }, { 0x11, 0 }, { 0x12, 0 }, { 0x13, 0 }, { 0x14, 0 }, { 0x15, 0 }, { 0x16, 0 }, { 0x17, 0 },
    { 0x18, 2 }, { 0x19, 0 }, { 0x1a, 0 }, { 0x1b, 2 }, { 0x1c, 2 }, { 0x1d, 2 }, { 0x1e, 2 }, { 0x1f, 2 },
};

/* ---------------- поля-биты ---------------- */

static void bf32(void *p, u32 lo, u32 n, u32 v)
{
    u32 *w = (u32 *)p;
    u32 m = ((n >= 32) ? 0xffffffffu : ((1u << n) - 1u)) << lo;
    *w = (*w & ~m) | ((v << lo) & m);
}

/* ---------------- доступность (PS: есть данные для cid) ---------------- */

/* ps__mark_data_pending (0x8c2a90, 100 Б): +1 кадр cid в счётчиках fwq_tx_avail (0x857040). */
void ps_mark_data_pending(u32 idx, u32 flag)
{
    struct fwq_tx_avail *av = &fwq_tx_avail;
    u32 bit = 1u << idx;
    if ((s32)idx >= (s32)SPARRAW_STA_SLOTS)
        fw_sysassert_fatal((void *)0, 0x134e);
    av->count[idx] = (u8)(av->count[idx] + 1);
    av->mask |= bit;
    if ((s32)flag < 1)
        return;
    av->prio_count[idx] = (u8)(av->prio_count[idx] + 1);
    av->prio_mask |= bit;
    fw_log_emit3(0x27, 0x1018cac, av->prio_mask, idx, av->prio_count[idx]);
}

/* FWQ_TX_AVAILABILITY__remove_packet (0x8e26a4, 126 Б): −1 кадр cid. */
void FWQ_TX_AVAILABILITY_remove_packet(u32 q, u32 f)
{
    struct fwq_tx_avail *av = &fwq_tx_avail;
    u8 c;
    if ((s32)q >= 9)
        fw_sysassert_fatal((void *)0, 0x134f);
    if (av->count[q] == 0)
        fw_sysassert_fatal((void *)0, 0x134d);
    c = (u8)(av->count[q] - 1);
    av->count[q] = c;
    if (c == 0)
        av->mask &= ~(1u << q);
    if ((s32)f < 1)
        return;
    c = (u8)(av->prio_count[q] - 1);
    av->prio_count[q] = c;
    if (c == 0)
        av->prio_mask &= ~(1u << q);
    fw_log_emit3(0x27, 0x1018cac, av->prio_mask, q, c);
}

/* FWQ_TX_AVAILABILITY::init (0x8d9084, 30 Б): обнулить счётчики и маски (0x857044..0x857063). */
void FWQ_TX_AVAILABILITY_init(void)
{
    fw_log_emit0(0x27, 0x1018c90);
    memset0_words((void *)fwq_tx_avail.count, sizeof(fwq_tx_avail) - 4);
}

/* ---------------- очереди fwq_tx ---------------- */

/* brd_if_multi_array__get_chunk (0x8cbbc4, 38 Б; имя vendor ошибочно): очередь канала. */
struct llist *brd_if_multi_array_get_chunk_8cbbc4(struct fwq_tx *q, u32 ch)
{
    if (ch == 0)
        return &q->chq[0];
    if (ch == 1)
        return &q->chq[1];
    fw_sysassert_fatal((void *)0, 0x120f);
    return 0;
}

/* fwq_tx__queue_step (0x8e5620, 92 Б): отдавать кадры в кольцо, пока vt->send_next берёт;
 * каждый — из текущей очереди в «переданные», отметить доступность, колбэк. */
u32 fwq_tx_queue_step(struct fwq_tx *q)
{
    u32 sent = 0;
    u32 r;
    do {
        r = q->vt->send_next(q);
        if (r == 1) {
            struct tx_pkt *pkt = llist_pop_front((u32 *)q->cur);
            list_find_entry_d((u32 *)&q->sent, (u32 *)pkt);
            if (q->mode == 1)
                ps_mark_data_pending(pkt->cid, TX_PKT_PRIO(pkt));
            q->stats->sent += 1;
            if (pkt->sent_cb != 0) {
                pkt->sent_cb(pkt->sent_info, 1);
                pkt->sent_cb = 0;
            }
            sent = 1;
        }
    } while (r == 1);
    return sent;
}

/* fwq_tx::add_packet (0x8c2af4, 92 Б). */
u32 fwq_tx_add_packet(struct fwq_tx *q, struct tx_pkt *pkt, u32 ch)
{
    list_find_entry_d((u32 *)brd_if_multi_array_get_chunk_8cbbc4(q, ch), (u32 *)pkt);
    q->stats->added += 1;
    if (ch == q->channel && q->state == 1) {
        u32 r = fwq_tx_queue_step(q);
        if (r != 0)
            return r;
        fw_log_emit3(0x17, 0x1018ac0, q->channel, q->mode, ch);
    } else {
        fw_log_emit3(0x27, 0x1018b14, q->state, q->channel, ch);
    }
    return 0;
}

/* fwq_tx__enable_queue (0x8e787c, 58 Б): включить очередь на канале ch. Ассерт 0x120d —
 * с адресом возврата (vendor 0x8e78a8: mov_s r0,blink), после него работа продолжается
 * (b_s 0x8e788a). */
void fwq_tx_enable_queue(struct fwq_tx *q, u32 ch)
{
    if (q->state != 0)
        fw_sysassert_fatal(__builtin_return_address(0), 0x120d);
    q->state = 1;
    q->channel = ch;
    q->cur = brd_if_multi_array_get_chunk_8cbbc4(q, ch);
    q->flush_cid_mask = 0;
    fwq_tx_queue_step(q);
}

/* fwq_tx__init (0x8d92e0, 98 Б). У vendor FWQ_TX_AVAILABILITY::init получает r0 = режим
 * (bleq без слота задержки) — функция аргументов не читает. */
void fwq_tx_init(struct fwq_tx *q, u32 mode, struct fwq_tx_stats *stats)
{
    if (stats == 0)
        fw_sysassert_fatal((void *)0, 0x1212);
    q->mode = mode;
    q->stats = stats;
    q->flush_timer = 0;
    llist_init((u32 *)&q->sent);
    llist_init((u32 *)&q->retry);
    llist_init((u32 *)&q->chq[0]);
    llist_init((u32 *)&q->chq[1]);
    if (q->mode == 1)
        FWQ_TX_AVAILABILITY_init();
    fwq_tx_enable_queue(q, 0);
}

/* fwq_tx::find_packet (0x8cc710, 48 Б): кадр cid в списке. */
struct tx_pkt *fwq_tx_find_packet(struct fwq_tx *q, struct llist *list, u32 cid)
{
    u32 it;
    (void)q;
    iter_init(&it, list);
    while (list_has_items(&it)) {
        struct tx_pkt *e = iter_next(&it);
        if (cid == e->cid)
            return e;
    }
    return 0;
}

/* fwq_tx::flush_list_packets_by_cid (0x8cac6c, 144 Б): кадры cid из src в dst со
 * статусом 0xff (кроме 0xfd), отменив таймеры повторов. */
u32 fwq_tx_flush_list_packets_by_cid(struct fwq_tx *q, u32 cid, struct llist *dst, struct llist *src)
{
    u32 it, r = 0;
    struct tx_pkt *cur = 0, *prev = 0;
    (void)q;
    iter_init(&it, src);
    while (list_has_items(&it)) {
        cur = iter_next(&it);
        if (prev != 0) {
            tx_list_remove(src, prev);
            list_find_entry_d((u32 *)dst, (u32 *)prev);
            prev = 0;
        }
        if (cur->cid == cid) {
            if (cur->retry_timer != 0) {
                u_schd_cancel(cur->retry_timer);
                cur->retry_timer = 0;
            }
            if (cur->status != 0xfd) {
                fw_log_emit1(0x27, 0x1018a68, (u32)cur);
                cur->status = 0xff;
            }
            r = 1;
            prev = cur;
        }
    }
    if (prev != 0) {
        tx_list_remove(src, prev);
        list_find_entry_d((u32 *)dst, (u32 *)prev);
    }
    return r;
}

/* fwq_tx__flush_by_prio (0x8cacfc, 74 Б): обе очереди каналов и очередь повторов. */
u32 fwq_tx_flush_by_prio(struct fwq_tx *q, u32 cid, struct llist *dst)
{
    u32 r = fwq_tx_flush_list_packets_by_cid(q, cid, dst, brd_if_multi_array_get_chunk_8cbbc4(q, 0));
    r |= fwq_tx_flush_list_packets_by_cid(q, cid, dst, brd_if_multi_array_get_chunk_8cbbc4(q, 1));
    return r | fwq_tx_flush_list_packets_by_cid(q, cid, dst, &q->retry);
}

/* conn__inject_evt4 (0x8cb69c, 12 Б): событие 4 автомату разрыва соединения. */
void conn_inject_evt4(struct conn *conn)
{
    conn_disc_event(&conn->msm.disc, 4, 0, 0, 0);
}

/* Колбэк «flush cid завершён» (0x8f3468, 14 Б). */
void tx_internal_api_conn_task(u32 cid, u32 a1)
{
    (void)a1;
    conn_inject_evt4(conn_mgr_by_cid(cid));
}

/* TX_INTERNAL_API::connection (0x8cb604, 152 Б): если cid ждал flush ([0x8000b4]) и в
 * очередях управления и данных он уже не во flush — сообщить соединению. */
void TX_INTERNAL_API_connection(u32 cid)
{
    u32 bit = 1u << cid;
    u32 m = (tx_api_mgmt.flush_cid_mask & bit) == 0;   /* vendor: [0x842148 + 0x20] */
    u32 d = (tx_api_data.flush_cid_mask & bit) == 0;
    fw_log_emit3(0x27, 0x1018134, tx_flush_cid_mask, m, d);
    if (!(tx_flush_cid_mask & bit) || !m || !d)
        return;
    fw_log_emit1(0x27, 0x1018170, cid);
    tx_flush_cid_mask &= ~bit;
    u_schd_add(tx_internal_api_conn_task, cid, 0, 1);
}

/* notify_conn_flush_done (0x8df4ac, 66 Б). */
void notify_conn_flush_done(struct fwq_tx *q, u32 cid)
{
    q->flush_cid_mask &= ~(1u << cid);
    q->stats->flush_done += 1;
    if (q->flush_cid_mask == 0 && q->flush_timer != 0) {
        u_schd_cancel(q->flush_timer);
        q->flush_timer = 0;
    }
    fw_log_emit1(0x27, 0x1018a28, q->flush_cid_mask);
    TX_INTERNAL_API_connection(cid);
}

/* fwq_tx__on_flush_done (0x8e9838, 46 Б): если кадров cid в кольце нет — снять их из
 * очередей в list и завершить flush. */
void fwq_tx_on_flush_done(struct fwq_tx *q, u32 cid, struct llist *list)
{
    if (fwq_tx_find_packet(q, &q->sent, cid) != 0)
        return;
    fwq_tx_flush_by_prio(q, cid, list);
    notify_conn_flush_done(q, cid);
}

/* link_lost_diag__dump_phy (0x8d2660, 92 Б): журнал регистров PHY. Порядок чтений MMIO
 * как у vendor (порядок вычисления аргументов в C не задан — поэтому через локальные);
 * 0x883830 и 0x883a84 vendor читает дважды. */
void link_lost_diag_dump_phy(void)
{
    u32 a = MMIO32(HW_PHY_RX_INA_AGC_START);
    u32 b = MMIO32(HW_PHY_RX_INA_RSSI_ADC_DB);
    u32 c = MMIO32(HW_PHY_RX_INA_RSSI_ADC_DB_SFD_LOCKED);
    fw_log_emit3(0x20, 0x101da44, a & 0x3fu, b, c);
    a = MMIO32(HW_PHY_RX_SIGNAL_GAIN_ADC_DB);
    b = MMIO32(HW_PHY_RX_SIGNAL_GAIN_ADC_DB);
    fw_log_emit2(0x20, 0x101da94, a & 0x7fu, (b >> 14) & 0x7fu);
    a = MMIO32(HW_PHY_RX_LDPC_ITER);
    b = MMIO32(HW_PHY_RX_LDPC_ITER);
    fw_log_emit2(0x20, 0x101dae8, a & 0xffu, (b >> 8) & 0x3fffffu);
}

/* link_lost_diag__dump_false_alarms (0x8c8678, 58 Б): журнал счётчиков 0x853900. */
void link_lost_diag_dump_false_alarms(void)
{
    const volatile u32 *fa = fw_stats_dash.fa_cnt;
    u32 a, b, c;
    c = fa[1]; a = fa[2]; b = fa[0];               /* порядок чтений — как vendor 0x8c8678 */
    fw_log_emit3(0x20, 0x1000fec, a, b, c);
    c = fa[4]; a = fa[5]; b = fa[3];
    fw_log_emit3(0x20, 0x1001050, a, b, c);
    link_lost_diag_dump_phy();
}

/* Колбэк таймера повтора кадра (0x8dcf14, 108 Б): вернуть кадр из очереди повторов в
 * очередь канала, если очередь не во flush (vendor проверяет маску flush целиком —
 * asl.f 0,1,cid всегда ≠ 0). Задача u_schd: a0 — очередь, a1 — кадр. */
void fwq_tx_retry_task(u32 a0, u32 a1)
{
    struct fwq_tx *q = (struct fwq_tx *)a0;
    struct tx_pkt *pkt = (struct tx_pkt *)a1;
    pkt->retry_timer = 0;
    if (q->flush_cid_mask != 0) {
        fw_log_emit1(0x17, 0x1018bd0, (u32)pkt);
        return;
    }
    fw_log_emit1(0x27, 0x1018b68, (u32)pkt);
    tx_list_remove(&q->retry, pkt);
    if (fwq_tx_add_packet(q, pkt, TX_PKT_CHAN(pkt)) == 0)
        fw_log_emit0(0x17, 0x1018ba0);
}

/* fwq_tx::long_retry_failures (0x8c66ac, 216 Б): кадры с ошибкой (статус ≠ 0) и
 * оставшимися повторами — на повтор через retry_backoff << 10 (из list в очередь
 * повторов, −1 в доступности). Возврат 1, если такие были. */
u32 fwq_tx_long_retry_failures(struct fwq_tx *q, struct llist *list)
{
    u32 it, r = 0;
    struct tx_pkt *cur = 0, *prev = 0;
    iter_init(&it, list);
    while (list_has_items(&it)) {
        cur = iter_next(&it);
        if (prev != 0) {
            tx_list_remove(list, prev);
            list_find_entry_d((u32 *)&q->retry, (u32 *)prev);
            FWQ_TX_AVAILABILITY_remove_packet(prev->cid, TX_PKT_PRIO(prev));
            prev = 0;
        }
        if (cur->status == 0)
            continue;
        if ((s32)cur->retries_left < 1)
            continue;
        if ((q->flush_cid_mask >> cur->cid) & 1u)
            continue;                               /* cid во flush (8c66c6: prev = 0) */
        fw_log_emit3(0x27, 0x1018c3c, (u32)cur, cur->retries_left, cur->retry_backoff);
        link_lost_diag_dump_false_alarms();
        cur->retries_left = (u8)(cur->retries_left - 1);
        cur->retry_timer = u_schd_schedule(fwq_tx_retry_task, (u32)q, (u32)cur, 1,
                                           (u32)cur->retry_backoff << 10, 0, 0);
        if (cur->status != 0xfd)
            cur->status = 0xfe;
        r = 1;
        prev = cur;
    }
    if (prev != 0) {
        tx_list_remove(list, prev);
        FWQ_TX_AVAILABILITY_remove_packet(prev->cid, TX_PKT_PRIO(prev));
        list_find_entry_d((u32 *)&q->retry, (u32 *)prev);
    }
    return r;
}

/* rm_ch_switch_sm::fwtx_channel_stopped (0x8cb6a8, 64 Б). */
void rm_ch_switch_sm_fwtx_channel_stopped(void)
{
    if (tx_ch_switch_paused != 1)
        return;
    if (tx_api_mgmt.state != 0)                     /* vendor: [0x842148 + 0x14] */
        return;
    if (tx_api_data.state != 0)
        return;
    tx_ch_switch_paused = 0;
    rm_main_sm_inject_lock_evt(3);
}

/* sm__null_handler (0x8df4f0, 16 Б): очередь остановлена. */
void sm_null_handler(struct fwq_tx *q)
{
    q->state = 0;
    q->stats->stopped += 1;
    rm_ch_switch_sm_fwtx_channel_stopped();
}

/* tx_api__call_vmethod_04 (0x8cc748, 124 Б): завершения кольца (vt->handle_completion) в
 * list, повторы, flush по cid, затем — продолжить очередь или остановить. */
void tx_api_call_vmethod_04(struct fwq_tx *q, struct llist *list)
{
    u32 it;
    q->vt->handle_completion(q, list);
    fwq_tx_long_retry_failures(q, list);
    field_set_0x00_8e5dfc(&it, q->flush_cid_mask);
    while (bit_iter_has_more(&it) != 0)
        fwq_tx_on_flush_done(q, (u32)bitmap_alloc_bit(&it), list);
    switch (q->state) {
    case 0:
        break;
    case 1:
        fwq_tx_queue_step(q);
        break;
    case 2:
        if (q->sent.count == 0)
            sm_null_handler(q);
        break;
    default:
        fw_sysassert_fatal((void *)0, 0x1211);
        break;
    }
}

/* tx_api__count_completion_status (0x8ead70, 68 Б). */
void tx_api_count_completion_status(struct fwq_tx *q, u32 status)
{
    struct fwq_tx_stats *st = q->stats;
    st->completed += 1;
    switch (status) {
    case 0:   st->st_ok += 1; break;
    case 2:   st->st_2 += 1; break;
    case 4:   st->st_4 += 1; break;
    case 255: st->st_255 += 1; break;
    default:  break;
    }
}

/* TX_API::free_memory (0x8cb10c, 78 Б): вернуть кадр в пул (кроме буфера ошибки). */
void TX_API_free_memory(u32 payload)
{
    struct tx_pkt *pkt;
    if (payload == 0)
        fw_sysassert_fatal((void *)0, 0x11e9);
    pkt = TX_PKT_OF(payload);
    if (pkt->status != 0xfd)
        stream_mgr_check_vring(&tx_pkt_pool, pkt);
    else
        fw_log_emit0(0x27, 0x10181d8);
}

/* TX_API::alloc_tx_payload (0x8c3414, 124 Б): кадр из пула 0x842304 (данные 0x500 Б
 * обнулены); при нехватке — буфер ошибки 0x805ac0 (статус 0xfd). */
u32 TX_API_alloc_tx_payload(void)
{
    struct tx_pkt *pkt = mem_pool_allocate(&tx_pkt_pool);
    if (pkt == 0) {
        pkt = &tx_err_buf;
        fw_log_emit1(0x17, 0x1018388, pkt->status);
        if (pkt->status != 0xfd)
            fw_sysassert_fatal((void *)0, 0x134c);
    }
    memset0_words(pkt->payload, 0x500);
    pkt->sent_cb = 0;
    pkt->sent_info = 0;
    return (u32)pkt->payload;
}

/* 0x8031b8: таблица переходов vendor TX_API__handle_completed_packets (0x8cd5dc): ldb.x, 5 записей, цель = 0x8cd636 + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(8031b8) __attribute__((aligned(1))) const u8 TX_API_handle_completed_packets_jt[5] = {
    0x07, 0x0d, 0x13, 0x19, 0x1f,
};

/* TX_API::handle_completed_packets (0x8cd5dc, 268 Б): разобрать завершённые кадры
 * очереди q: счётчики, для «ждущих» управления (статус 5) — в список 0x842148, иначе
 * колбэк, обработчик завершения (payload, статус, conn) или освобождение. */
void TX_API_handle_completed_packets(struct fwq_tx *q)
{
    struct llist list;
    llist_init((u32 *)&list);
    tx_api_call_vmethod_04(q, &list);
    while (list.count != 0) {
        struct tx_pkt *pkt = llist_pop_front((u32 *)&list);
        u32 st, release = 1;
        if (pkt == 0)
            fw_sysassert_fatal((void *)0, 0x11d6);
        st = pkt->status;
        tx_api_count_completion_status(q, st);
        if (q == &tx_api_data && st < 5) {
            /* jump-table 0x8031b8: счётчики данных по статусу */
            static const u16 cnt[5] = { 0x4c, 0x3c, 0x48, 0x44, 0x40 };
            *(u32 *)(0x800000u + cnt[st]) += 1;
        }
        if (q == &tx_api_mgmt) {
            if (st == 5) {
                tx_mgmt_cmpl_st5_count += 1;
                list_find_entry_d((u32 *)&tx_pending, (u32 *)pkt);
                fw_log_emit1(0x27, 0x1018310, (u32)pkt);
                release = 0;
            } else if (st != 255 && st != 254) {
                FWQ_TX_AVAILABILITY_remove_packet(pkt->cid, TX_PKT_PRIO(pkt));
            }
        }
        if (release == 1) {
            if (pkt->sent_cb != 0) {
                pkt->sent_cb(pkt->sent_info, 0);
                pkt->sent_cb = 0;
            }
            if (pkt->done != 0)
                pkt->done((u32)pkt->payload, st, (u32)conn_mgr_by_cid(pkt->cid));
            else
                TX_API_free_memory((u32)pkt->payload);
        }
        if (st != 0 && tx_cpl_err_count_en != 0)
            tx_cpl_err_count += 1;
    }
}

/* tx_api__call_mem_pool_alloc_err_cb (0x8c5a34, 88 Б): кадр не выделен — обработчику
 * завершения буфер ошибки со статусом 0xfd. */
void tx_api_call_mem_pool_alloc_err_cb(u32 h, u32 conn)
{
    tx_done_fn done = (tx_done_fn)h;               /* аргумент задачи u_schd — числом */
    if (done == 0) {
        fw_log_emit0(0x17, 0x10186a4);
        return;
    }
    fw_log_emit1(0x27, 0x101863c, h);
    done((u32)tx_err_buf.payload, 0xfd, conn);
}

/* ---------------- кольцо TX (struct tx_ring, таблица tx_ring_vtbl) ---------------- */

/* ring__is_full (0x8da2d8, 22 Б): голова+1 == хвост. */
u32 tx_ring_is_full(const struct ring_idx *r)
{
    u32 n = r->head + 1;
    if (n == r->size)
        n = 0;
    return n == r->tail;
}

/* tx_desc_by_index (0x8cc1ec, 8 Б): дескриптор 32 Б (кольца TX и RX). */
u32 tx_desc_by_index(const struct ring_idx *r, u32 i)
{
    return r->base + (i << 5);
}

/* tx_ring__advance_index (0x8c7f00, 18 Б): индекс кольца r (TX и RX) + 1 по модулю size. */
void tx_ring_advance_index(struct ring_idx *r, u32 *idx)
{
    *idx += 1;
    if (*idx == r->size)
        *idx = 0;
}
/* hwd_dma__write_ring_reg (0x8d0c00, 22 Б): указатель головы кольца DMA. */
void hwd_dma_write_ring_reg(u32 ring, u32 v)
{
    MMIO32(((ring * 896u + 0x4409740u) >> 3) & ~3u) = v;
}


/* tx_desc__init_32 (0x8e9bf4, 76 Б): обнулить дескриптор, MACQ (QID), DMA_IT, адрес, длина,
 * число дескрипторов. */
void tx_desc_init_32(struct tx_desc *d, u32 macq, u32 dma_it, u32 addr, u32 len, u32 ndesc)
{
    u32 w;
    memset0_words(d, sizeof(*d));
    d->length = (u16)len;
    d->num_desc = (u8)ndesc;
    w = d->dma_d0;
    w = (w & ~0x700u) | 0x300u;                     /* EOP | MARK_WB */
    w |= (dma_it & 1u) << 10;
    d->dma_d0 = w;
    bf32(&d->dma_d0, 16, 5, macq & 0x1fu);
    d->addr_lo = addr & 0x3ffffu;
}

/* tx_desc__set_lifetime (0x8cc490, 54 Б). */
u32 tx_desc_set_lifetime(u32 shift, u32 v)
{
    u32 base = MMIO32(HW_RGF_MAC_MTRL_COUNTER_0);
    u32 t = ((v > 2 ? v : 2) << shift) + base;
    u32 r = (t >> shift) & 0x3ffu;
    fw_log_emit3(0x27, 0x1018d64, base, t, r);
    return r;
}

/* tx_desc__build (0x8ca4d8, 124 Б): поля TX-дескриптора. */
void tx_desc_build(u32 e, struct tx_desc *d, u32 flags, u32 a3, u32 a4, u32 prio, u32 a6, u32 retry,
                   u32 lifetime, u32 cid)
{
    u32 w1;
    (void)e;
    (void)a4;
    w1 = d->mac_d1 & ~((1u << 23) | (1u << 31));
    d->mac_d1 = w1;
    if (a6 == 0) {
        bf32(&d->mac_d1, 24, 7, retry & 0x7fu);
        d->mac_d1 |= 1u << 31;
    } else if (lifetime != 0) {
        d->mac_d1 = w1 | (1u << 23);
        bf32(&d->mac_d0, 0, 10, tx_desc_set_lifetime(tx_lifetime_shift, lifetime) & 0x3ffu);
    }
    d->mac_d0 |= 1u << 27;
    bf32(&d->mac_d0, 22, 5, prio & 0x1fu);
    d->mac_d1 |= 1u << 20;
    bf32(&d->mac_d1, 16, 4, cid & 0xfu);
    d->mac_d1 |= 1u << 4;
    bf32(&d->mac_d1, 0, 4, a3 & 0xfu);             /* r0 = d+4 от прошлого вызова */
    d->ucode_cmd = flags;
}

/* tx_ring::post_frame (0x8e1e98, 162 Б) — vt->post_frame: дескриптор кадра в кольцо DMA,
 * голова кольца и пинок MACQ. Возврат 1 — поставлен, 0 — кольцо полно. */
u32 tx_ring_post_frame(struct tx_ring *tr, u32 payload, u32 len, u32 a3, u32 retry,
                                         u32 lifetime, u32 a6, u32 prio, u32 cid, u32 flags)
{
    struct ring_idx *r = &tr->r;
    struct tx_desc *d;
    if (tx_ring_is_full(r))
        return 0;
    d = (struct tx_desc *)tx_desc_by_index(r, tr->r.head);
    if ((d->status_w >> 8) & 1u)
        fw_sysassert_fatal((void *)0, 0x1227);
    tx_desc_init_32(d, tr->macq, 1, payload, len, a6);
    tx_desc_build((u32)vring_tbl_entry_addr(tr->macq), d, flags, prio != 0, 1,
                  prio, a3, retry, lifetime, (u8)cid);
    tx_ring_advance_index(r, &tr->r.head);
    hwd_dma_write_ring_reg(tr->dma_ring, tr->r.head);
    macq_kick_queue(tr->macq);
    return 1;
}

/* tx_ring::init (0x8e60f0, 22 Б) — vt->init: MACQ, кольцо DMA, база и размер. */
void tx_ring_init(struct tx_ring *tr, u32 macq, u32 dma, u32 base, u32 size)
{
    tr->macq = macq;
    tr->dma_ring = dma;
    rx_pool_set_fields(&tr->r, base, size);
}

/* tx_ring::complete (0x8cc8e0, 184 Б) — vt->complete: снять завершённые дескрипторы: статус
 * в кадр, кадр из «переданных» (sent) в list. */
void tx_ring_complete(struct tx_ring *tr, struct llist *list, struct llist *sent)
{
    struct ring_idx *r = &tr->r;
    vring_reg_write_locked_0c(1u << tr->dma_ring, 0);
    for (;;) {
        struct tx_desc *d = (struct tx_desc *)tx_desc_by_index(r, tr->r.tail);
        u32 w = d->status_w;
        u32 pl;
        struct tx_pkt *pkt;
        if (!((w >> 8) & 1u))
            break;
        d->status_w = w & ~TX_DESC_DU;
        pl = d->addr_lo | (1u << 18) | (1u << 23);     /* 18 бит → 0x84xxxx */
        d->addr_lo = 0;
        if (((d->dma_d0 >> 16) & 0x1fu) == 0x19)        /* QID */
            tx_ring_cmpl_type19_count += 1;
        if (pl == 0)
            fw_sysassert_fatal((void *)0, 0x11e9);
        pkt = TX_PKT_OF(pl);
        pkt->status = (u8)(w & 7u);
        if (llist_pop_front((u32 *)sent) != pkt)
            fw_sysassert_fatal((void *)0, 0x1228);
        list_find_entry_d((u32 *)list, (u32 *)pkt);
        tx_ring_advance_index(r, &tr->r.tail);
    }
    vring_reg_write_locked_20(1u << tr->dma_ring, 0);
}

/* tx_ring::enable (0x8e9804, 20 Б) — vt->enable: LMAC 8 для MACQ кольца (a1 не читает). */
void tx_ring_enable(struct tx_ring *tr, u32 a1)
{
    (void)a1;
    lmac_if_send_cmd_0x08(0, 3, 0, (u8)tr->macq, 0, 1, 0);
}

/* tx_ring::dma_ring (0x8ed5d0, 4 Б) — vt->dma_ring. */
u32 tx_ring_dma_ring(struct tx_ring *tr)
{
    return tr->dma_ring;
}

/* Таблица методов кольца TX (vendor 0x8008ac). */
FWDATA(8008ac) const struct tx_ring_vt tx_ring_vtbl = {
    .rsv0 = 0,
    .post_frame = tx_ring_post_frame,
    .init = tx_ring_init,
    .complete = tx_ring_complete,
    .enable = tx_ring_enable,
    .dma_ring = tx_ring_dma_ring,
};

/* ---------------- fwq_tx (таблица fwq_tx_vtbl) ---------------- */

/* fwq_tx::handle_completion (0x8cc998, 24 Б) — vt->handle_completion: complete кольца. */
void fwq_tx_vt_handle_completion(struct fwq_tx *q, struct llist *list)
{
    struct tx_ring *tr = q->ring_p;
    tr->vt->complete(tr, list, &q->sent);
}

/* fwq_tx::send_next (0x8e567c, 168 Б) — vt->send_next: первый кадр текущей очереди в кольцо.
 * Флаги дескриптора из категории: биты 0..2 → тип 2 и подтип (0 / 1 / 2), бит 3 → +4. */
u32 fwq_tx_vt_send_next(struct fwq_tx *q)
{
    struct llist *l = q->cur;
    struct tx_pkt *pkt;
    u32 cat, flags = 0;
    struct tx_ring *tr;
    if (l->count == 0)
        return 0;
    pkt = (struct tx_pkt *)l->head;
    if (pkt == 0)
        fw_sysassert_fatal((void *)0, 0x11d6);
    cat = pkt->cat;
    if (cat & 7u) {
        bf32(&flags, 0, 4, 2);
        if (cat & 1u)
            bf32(&flags, 4, 28, 0);
        else if (cat & 4u)
            bf32(&flags, 4, 28, 1);
        else if (cat & 2u)
            bf32(&flags, 4, 28, 2);
    }
    if (cat & 8u)
        bf32(&flags, 0, 4, (flags & 0xfu) | 4u);
    tr = q->ring_p;
    return tr->vt->post_frame(tr, (u32)pkt->payload, pkt->len, 0, pkt->retry_limit, 0, 1,
                              TX_PKT_PRIO(pkt), pkt->cid, flags);
}

/* fwq_tx::enable_ring (0x8cade8, 4 Б → 0x8e97f8) — vt->enable_ring: enable кольца. */
void fwq_tx_vt_enable_ring(struct fwq_tx *q)
{
    struct tx_ring *tr = q->ring_p;
    tr->vt->enable(tr, 1);
}

/* Таблица методов fwq_tx (vendor 0x80071c). */
FWDATA(80071c) const struct fwq_tx_vt fwq_tx_vtbl = {
    .rsv0 = 0,
    .handle_completion = fwq_tx_vt_handle_completion,
    .send_next = fwq_tx_vt_send_next,
    .enable_ring = fwq_tx_vt_enable_ring,
};

/* ---------------- объект повторов (struct tx_retry, таблица tx_retry_vtbl) ---------------- */

/* backoff__add_and_schedule (0x8f1c30, 32 Б): «кредит» += a (не больше pending) и разбор
 * завершений кольца DMA задачей 0x8e9c40. */
void backoff_add_and_schedule(struct tx_retry *o, u32 a)
{
    u32 n = a + o->credit;
    o->credit = n;
    if (o->pending < n)
        o->credit = o->pending;
    u_schd_add(txrx_mgr_tx_complete_task, o->dma_ring, 0, 1);
}

/* retry::try_next (0x8f7ce4, 42 Б) — vt->try_next. */
u32 tx_retry_vt_try_next(struct tx_retry *o)
{
    if (o->pending >= o->max)
        return 0;
    o->pending += 1;
    o->tries += 1;
    if (o->backoff_en != 0)
        backoff_add_and_schedule(o, 1);
    return 1;
}

/* retry::init (0x8f8f2c, 22 Б) — vt->init (база и размер кольца не нужны). */
void tx_retry_vt_init(struct tx_retry *o, u32 macq, u32 dma, u32 base, u32 size)
{
    (void)macq;
    (void)base;
    (void)size;
    o->pending = 0;
    o->credit = 0;
    o->max = 1;
    o->dma_ring = dma;
    o->backoff_en = 0;
    o->tries = 0;
    o->extra = 0;
    o->ok_credit = 0;
}

/* retry::drain (0x8f36a8, 88 Б) — vt->drain: min(pending, credit) кадров из src в list
 * (статус 1, пока есть ok_credit, иначе 0). */
u32 tx_retry_vt_drain(struct tx_retry *o, struct llist *list, struct llist *src)
{
    u32 n = (o->credit < o->pending) ? o->credit : o->pending;
    for (u32 k = n; k >= 1; k--) {
        struct tx_pkt *pkt = llist_pop_front((u32 *)src);
        u32 st = 0;
        if (o->ok_credit > 0) {
            o->ok_credit = (s16)(o->ok_credit - 1);
            st = 1;
        }
        pkt->status = (u8)st;
        list_find_entry_d((u32 *)list, (u32 *)pkt);
        o->pending -= 1;
        o->credit -= 1;
    }
    return o->extra + n;
}

/* (0x8f9cf8, 2 Б) — vt->nop: пусто. */
void tx_retry_vt_nop(struct tx_retry *o)
{
    (void)o;
}

/* (0x8ed5cc, 4 Б) — vt->dma_ring. */
u32 tx_retry_vt_dma_ring(struct tx_retry *o)
{
    return o->dma_ring;
}

/* Таблица методов объекта повторов (vendor 0x800778). */
FWDATA(800778) const struct tx_retry_vt tx_retry_vtbl = {
    .rsv0 = 0,
    .try_next = tx_retry_vt_try_next,
    .init = tx_retry_vt_init,
    .drain = tx_retry_vt_drain,
    .nop = tx_retry_vt_nop,
    .dma_ring = tx_retry_vt_dma_ring,
};

/* ---------------- инициализация ---------------- */

/* dma_mgr__queue_state_is_1 (0x8da528, 26 Б) / _is_0 (0x8da544, 26 Б): байт состояния
 * очереди q (0x8031c9 + q*2). */
u32 dma_mgr_queue_state_is_1(u32 q)
{
    if (q >= 0x20)
        return 0;
    return txq_dma_mode_tbl[q].mode == 1;
}

u32 dma_mgr_queue_state_is_0(u32 q)
{
    if (q >= 0x20)
        return 0;
    return txq_dma_mode_tbl[q].mode == 0;
}

/* dma_mgr__setup_queue_pair (0x8d8f28, 118 Б): кольцо и объект повторов (их vt->init),
 * кольцо DMA и очередь fwq_tx. */
void dma_mgr_setup_queue_pair(struct fwq_tx *q, u32 mode, struct fwq_tx_stats *stats, u32 macq,
                              u32 dma, u32 base, u32 size)
{
    struct tx_ring *tr = &q->ring;
    struct tx_retry *ro = &q->retry_obj;
    tr->vt->init(tr, macq, dma, base, size);
    ro->vt->init(ro, macq, dma, base, size);
    q->ring_p = tr;
    dma_mgr_configure_ring(dma, base & 0x3ffffu, 0, size, 1, 1, 0, 0);
    fwq_tx_init(q, mode, stats);
}

/* dma_mgr__reset_queue_0x19 (0x8e9ba0, 84 Б): очередь данных — кольцо 5, MACQ 0x19. */
void dma_mgr_reset_queue_0x19(void)
{
    u32 s0 = dma_mgr_queue_state_is_0(0x19);
    u32 s1 = dma_mgr_queue_state_is_1(0x19);
    memset0_words(tx_ring_mem_data, sizeof(tx_ring_mem_data));
    dma_mgr_setup_queue_pair(&tx_api_data, 2, &tx_api_stats[TX_STATS_DATA], 0x19, 5,
                             (u32)tx_ring_mem_data, 2);
    lmac_if_send_cmd_0x08(0, 0, 8, 0x19, s1, s0, 0);
}

/* tx_api__tx_complete_cb (0x8e9ae8, 52 Б; имя vendor ошибочно): очередь tx_api_2 —
 * кольцо 3, MACQ 0x1e. */
void tx_api_tx_complete_cb(void)
{
    memset0_words(tx_ring_mem_2, sizeof(tx_ring_mem_2));
    dma_mgr_setup_queue_pair(&tx_api_2, 0, &tx_api_stats[TX_STATS_2], 0x1e, 3, (u32)tx_ring_mem_2, 2);
}

/* dma_mgr__reset_queue_0x1a (0x8ea15c, 88 Б): очередь управления — кольцо 6, MACQ 0x1a. */
void dma_mgr_reset_queue_0x1a(void)
{
    u32 s0 = dma_mgr_queue_state_is_0(0x1a);
    u32 s1 = dma_mgr_queue_state_is_1(0x1a);
    memset0_words(tx_ring_mem_mgmt, sizeof(tx_ring_mem_mgmt));
    dma_mgr_setup_queue_pair(&tx_api_mgmt, 1, &tx_api_stats[TX_STATS_MGMT], 0x1a, 6,
                             (u32)tx_ring_mem_mgmt, 2);
    lmac_if_send_cmd_0x08(0, 0, 8, 0x1a, s1, s0, 0);
}

/* tx_api__reset_state_words (0x8f5270, 16 Б). */
void tx_api_reset_state_words(void)
{
    tx_api_state_word = 0;
    tx_flush_cid_mask = 0;
    tx_ch_switch_paused = 0;
}

/* tx_macq_api_step (0x8d986c, 168 Б): TX MACQ 0x1e и 0x1a (записи vring_tbl). */
void tx_macq_api_step(void)
{
    struct vring_tbl_entry *e = &vring_tbl[0x1e];
    u32 b;
    e->macq = 0x1e;
    tx_macq_config_ring_params(e, 0x1ca, 8, 0x50aa, 0x8a, 0x200);
    b = txq_dma_mode_tbl[0x1e].mode;
    tx_macq_setup(e, 9, b == 0, b == 1, 7, 0, 0, 0);
    e = &vring_tbl[0x1a];
    e->macq = 0x1a;
    tx_macq_config_ring_params(e, 0x1c2, 8, 0x5000, 0xaa, 0x500);
    b = txq_dma_mode_tbl[0x1a].mode;
    tx_macq_setup(e, 8, b == 0, b == 1, 7, 0, 0, 0);
}

/* tx_api__init_pools (0x8f552c, 138 Б): MACQ, пул кадров 0x842304 (8 × 0x524 Б от
 * 0x848020), буфер ошибки 0x805ac0 (статус 0xfd), три очереди TX_API, список ждущих. */
void tx_api_init_pools(void)
{
    tx_macq_api_step();
    memset0_words(tx_pkt_mem, sizeof(tx_pkt_mem));
    memset0_words(&tx_err_buf, sizeof(tx_err_buf));
    tx_err_buf.status = 0xfd;
    memset0_words(tx_api_stats, sizeof(tx_api_stats));  /* 0x842318: сразу за пулом */
    mem_pool_init(&tx_pkt_pool, tx_pkt_mem, sizeof(struct tx_pkt), TX_PKT_N);
    dma_mgr_reset_queue_0x19();
    tx_api_tx_complete_cb();
    dma_mgr_reset_queue_0x1a();
    tx_api_reset_state_words();
    llist_init((u32 *)&tx_pending);
}

