// SPDX-License-Identifier: AGPL-3.0-or-later
/* vring_schd — планировщик TX-vring хоста (класс vendor, статический объект 0x804dbc
 * и его вариант 0x804e64 для режима [0x80006c] == 1) + аппаратные прерывания DMA vring.
 *
 * Раскладка объектов — include/vring_schd.h: struct vring_schd (0xa8 Б: vptr — таблица
 * методов 0x8008e8 / 0x800918 в fw_data, ставит статический конструктор 0x8c19ec (ctors.c);
 * список ожидания +0x04, два списка готовых +0x10/+0x1c, pring[2] +0x28, число pring +0xa0,
 * маска запрета +0xa4), struct pring (0x3c Б), struct vring_rec (0x28 Б, пул 0x804da8 →
 * элементы 0x804c40), struct vring_tbl_entry. */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/fwdata.h"
#include "../include/vring_schd.h"
#include "../include/stream.h"
#include "../include/lmac_cmd.h"
#include "../include/llist.h"
#include "../include/wmi.h"
#include "../include/mac_cnt.h"
#include "../include/radio_mgr.h"


/* Планировщик (0x804dbc) и вариант для [0x80006c] == 1 (0x804e64): в образе нули, vptr
 * ставит конструктор 0x8c19ec. */
FWDATA(804dbc) struct vring_schd vring_schd = { 0 };
FWDATA(804e64) struct vring_schd_alt vring_schd_alt = { 0 };

/* Элементы пула записей vring (0x804c40, 9 × 0x28 Б). */
FWDATA(804c40) struct vring_rec vring_recs[VRING_RECS_N] = { 0 };
/* Пул записей vring (0x804da8; инициализация — vring_schd_init_pool). */
FWDATA(804da8) struct mem_pool vring_rec_pool = { 0 };


/* ---------------- списки ---------------- */

/* iter__init (0x8e5df4, 6 Б): итератор = первый узел списка {count, first, last}. */
void iter_init(u32 *it, const struct llist *list)
{
    *it = list->head;
}

/* list__has_items (0x8cdcb8, 12 Б). */
u32 list_has_items(u32 *it)
{
    return *it != 0;
}

/* iter__next (0x8df438, 12 Б): текущий узел, итератор — на следующий. */
void *iter_next(u32 *it)
{
    u32 cur = *it;
    if (cur != 0)
        *it = *(u32 *)cur;
    return (void *)cur;
}

/* tx_list__remove (0x8e2884, 126 Б): снять узел entry {next, owner} со списка
 * head {count, first, last}. */
void tx_list_remove(struct llist *l, void *node)
{
    /* адреса списка и узла — словами: поля llist / llist_node — u32 (как у vendor) */
    u32 head = (u32)l, entry = (u32)node;
    struct llist_node *e = node;
    if (entry == 0)
        fw_sysassert_fatal(__builtin_return_address(0), 0xda);
    if (e->owner != head)
        fw_sysassert_fatal(__builtin_return_address(0), 0xdb);
    if (l->count == 0)
        fw_sysassert_fatal(__builtin_return_address(0), 0xdc);

    if (l->head == entry) {
        if (l->tail == entry)
            l->tail = 0;
        l->head = e->next;
    } else {
        u32 prev = l->head;
        while (prev != 0 && ((struct llist_node *)prev)->next != entry)
            prev = ((struct llist_node *)prev)->next;
        if (prev == 0) {
            fw_sysassert_fatal((void *)0, 0xdd);
            return;                                 /* vendor: выход без снятия */
        }
        ((struct llist_node *)prev)->next = e->next;
        if (l->tail == entry)
            l->tail = prev;
    }
    e->next = 0;
    e->owner = 0;
    l->count -= 1;
}

/* vring_list__find (0x8ebe80, 60 Б): найти в списке запись с vring == idx. */
u32 vring_list_find(struct vring_schd *s, struct llist *list, u32 idx, struct vring_rec **entry)
{
    u32 it;
    (void)s;
    *entry = 0;
    iter_init(&it, list);
    while (list_has_items(&it)) {
        struct vring_rec *e = iter_next(&it);
        if (idx == e->vr) {
            *entry = e;
            return 1;
        }
    }
    return 0;
}

/* vring_schd__find_bound (0x8ebebc, 68 Б): pring, к которому привязан vring vr. */
u32 vring_schd_find_bound(struct vring_schd *s, u32 vr, struct vring_rec **entry,
                          struct pring **pring)
{
    struct pring *p = s->pring;
    *pring = 0;
    *entry = 0;
    for (u32 i = 0; i < s->n_pring; i++, p++) {
        struct vring_rec *e = p->bound;
        if (e != 0 && e->vr == vr) {
            *pring = p;
            *entry = e;
            return 1;
        }
    }
    return 0;
}

/* vring__find_busy_index (0x8ccfe4, 40 Б): занятая запись пула, привязанная к pring. */
struct vring_rec *vring_find_busy_index(u32 pring)
{
    for (struct vring_rec *e = vring_recs; e != vring_recs + VRING_RECS_N; e++) {
        if (e->state != 0 && e->pring == pring)
            return e;
    }
    return 0;
}

/* pring__find_by_id (0x8cd00c, 40 Б): занятая запись пула с vring == vr. */
struct vring_rec *pring_find_by_id(u32 vr)
{
    for (struct vring_rec *e = vring_recs; e != vring_recs + VRING_RECS_N; e++) {
        if (e->state != 0 && e->vr == vr)
            return e;
    }
    return 0;
}

/* sm_pring__by_index (0x8cca20, 14 Б). */
struct pring *sm_pring_by_index(u32 i)
{
    return &vring_schd.pring[i];
}

/* ---------------- регистры DMA vring ---------------- */

/* vring__reg_write_locked_28 (0x8d0538, 48 Б): [0x881c28] = v при снятом E1. */
void vring_reg_write_locked_28(u32 v, u32 flag)
{
    u32 s = arc_irq_disable();
    MMIO32(HW_DMA_FW_ICR_C24_ICR) = v;
    if (flag != 0)
        arc_sync();
    arc_irq_restore(s);
}

/* vring__reg_write_locked_3c (0x8d0568, 48 Б): [0x881c3c] = v при снятом E1. */
void vring_reg_write_locked_3c(u32 v, u32 flag)
{
    u32 s = arc_irq_disable();
    MMIO32(HW_DMA_FW_ICR_C24_IMC) = v;
    if (flag != 0)
        arc_sync();
    arc_irq_restore(s);
}

/* vring_hw__set_ready_bit (0x8d0598, 38 Б): бит (idx*896 + 0x44099c3) в битовой карте
 * регистров (адрес = бит >> 3, слово выровнено; номер бита — младшие 5). */
void vring_hw_set_ready_bit(u32 idx)
{
    u32 b = idx * 896u + 0x44099c3u;
    volatile u32 *w = (volatile u32 *)((b >> 3) & ~3u);
    u32 m = 1u << (b & 0x1fu);
    *w = (*w & ~m) | m;
}

/* macq_hw__disable_queue_fw (0x8d0c9c, 78 Б): снять биты 0x44099c0 и 0x44096c4 очереди. */
void macq_hw_disable_queue_fw(u32 idx)
{
    u32 b = idx * 896u + 0x44099c0u;
    volatile u32 *w = (volatile u32 *)((b >> 3) & ~3u);
    *w &= ~(1u << (b & 0x1fu));
    arc_sync();
    b = idx * 896u + 0x44096c4u;
    w = (volatile u32 *)((b >> 3) & ~3u);
    *w &= ~(1u << (b & 0x1fu));
    arc_sync();
}

/* mac_mem__write_slot (0x8d0620, 202 Б): запрограммировать очередь MAC idx: ready-бит,
 * слово 0x4409980 = val, бит 0x44099c0, затем 0x44096c0 = (n << 16 & 0x1f0000) | 0xf,
 * импульс 0x4409700 (1 → 0) и 0x44096c0 = … | 0x1f.
 * ХРУПКО: после каждой записи vendor держит sync + 3 nop (8d0680..8d06a4) — задержка
 * между шагами программирования очереди; повторено как есть, без подбора. */
void mac_mem_write_slot(u32 idx, u32 val, u32 n)
{
    u32 base = idx * 896u;
    vring_hw_set_ready_bit(idx);
    MMIO32(((base + 0x4409980u) >> 3) & ~3u) = val;
    {
        u32 b = base + 0x44099c0u;
        volatile u32 *w = (volatile u32 *)((b >> 3) & ~3u);
        u32 m = 1u << (b & 0x1fu);
        *w = (*w & ~m) | m;
    }
    MMIO32((base + 0x44096c0u) >> 3) = ((n << 16) & 0x1f0000u) | 0xfu;
    arc_sync();
    arc_nops_mb(3);
    MMIO32((base + 0x4409700u) >> 3) = 1;
    arc_sync();
    arc_nops_mb(3);
    MMIO32((base + 0x4409700u) >> 3) = 0;
    arc_sync();
    arc_nops_mb(3);
    MMIO32((base + 0x44096c0u) >> 3) = ((n << 16) & 0x1f0000u) | 0x1fu;
    arc_sync();
}

/* macq_hw__sync_dma_wptr_fw (0x8d4708, 50 Б): указатель записи DMA vring = 16 бит
 * поля очереди MAC q (бит 0x44098c0); запись дважды — затем с битом 31. */
void macq_hw_sync_dma_wptr_fw(u32 vr, u32 q)
{
    u32 b = q * 896u + 0x44098c0u;
    u32 v = (u16)(MMIO32((b >> 3) & ~3u) >> (b & 0x1fu));
    volatile u32 *r = (volatile u32 *)((((vr << 8) + 0x440c140u) >> 3) & ~3u);
    *r = v;
    *r = v | 0x80000000u;
}

/* dma_is_idle (0x8d08c0, 70 Б): поля 0x4409880 и 0x44098c0 очереди равны. */
u32 dma_is_idle(u32 q, u32 log)
{
    u32 a = MMIO32(((q * 896u + 0x4409880u) >> 3) & ~3u);
    u32 b = MMIO32(((q * 896u + 0x44098c0u) >> 3) & ~3u);
    if (log != 0)
        fw_log_emit2(0x20, 0x101d4f8, a, b);
    return a == b;
}

/* hwd_dma__get_rings_with_data (0x8d078c, 8 Б). */
u32 hwd_dma_get_rings_with_data(void)
{
    return MMIO32(HW_DMA_RINGS_WITH_DATA);
}

/* vring_hw__field_addr_440c0c0 (0x8d0848, 20 Б) / _440c100 (0x8d085c, 20 Б): прочитать
 * регистры vring (значения vendor не использует — диагностика). */
u32 vring_hw_field_addr_440c0c0(u32 vr)
{
    return MMIO32((((vr << 8) + 0x440c0c0u) >> 3) & ~3u);
}

u32 vring_hw_field_addr_440c100(u32 vr)
{
    return MMIO32((((vr << 8) + 0x440c100u) >> 3) & ~3u);
}

/* hwd_dma__read_8813c8 (0x8d0828, 8 Б) / hwd_dma__read_8813f0 (0x8d081c, 8 Б). */
u32 hwd_dma_read_8813c8(void)
{
    return MMIO32(HW_DMA_DESCQ2_SW_TAIL);
}

u32 hwd_dma_read_8813f0(void)
{
    return MMIO32(HW_DMA_DESCQ2_SW_HEAD_CRNT);
}

/* mac_tx_cnt__get_ok (0x8dd758, 6 Б) / __get_fail (0x8dd760, 6 Б): счётчики TX MAC
 * (блок статистики по указателю [0x8003d4]). */
u32 mac_tx_cnt_get_ok(void)
{
    return mac_tx_cnt_blk->ok;
}

u32 mac_tx_cnt_get_fail(void)
{
    return mac_tx_cnt_blk->fail;
}

/* mac_tx_cnt__delta_88_net_of_20 (0x8dd768, 20 Б). */
u32 mac_tx_cnt_delta_88_net_of_20(void)
{
    struct mac_tx_cnt *blk = mac_tx_cnt_blk;
    return (blk->cnt_88 - pring_tx_cnt_base_88) - blk->cnt_20;
}

/* sm_pring__latch_tx_counters (0x8d9b44, 18 Б): запомнить базы счётчиков TX. */
void sm_pring_latch_tx_counters(void)
{
    struct mac_tx_cnt *blk = mac_tx_cnt_blk;
    pring_tx_cnt_base_10 = blk->cnt_10;
    pring_tx_cnt_base_88 = blk->cnt_88;
}

/* hwd_dma__reset_vring (0x8d09a0, 162 Б): сбросить указатели DMA vring vr. */
void hwd_dma_reset_vring(u32 vr)
{
    u32 o = vr << 8;
    volatile u32 *r;
    fw_log_emit3(0x20, 0x101d62c, vr, MMIO32(((o + 0x440c0c0u) >> 3) & ~3u),
                 MMIO32(((o + 0x440c120u) >> 3) & ~3u));
    r = (volatile u32 *)(((o + 0x440c100u) >> 3) & ~3u);
    fw_log_emit2(0x20, 0x101d654, vr, *r);
    *r = 0;
    fw_log_emit2(0x20, 0x101d678, vr, *r);
    r = (volatile u32 *)(((o + 0x440c0e0u) >> 3) & ~3u);
    *r = 0;
    *r = 0x80000000u;
    r = (volatile u32 *)(((o + 0x440c140u) >> 3) & ~3u);
    *r = 0;
    *r = 0x80000000u;
}

/* hwd_dma__program_vring_desc (0x8d0d0c, 56 Б): база кольца хоста (lo, hi) и размер. */
void hwd_dma_program_vring_desc(u32 vr, u32 lo, u32 hi, u32 size)
{
    MMIO32((((vr << 8) + 0x440c160u) >> 3) & ~3u) = lo;
    dpal_cpl_timeout_evt(hi);
    MMIO32((((vr << 8) + 0x440c1a0u) >> 3) & ~3u) = size;
}

/* ---------------- MAC-очереди (0x886a00) ---------------- */

/* macq__kick_queue (0x8e1c7c, 22 Б). */
void macq_kick_queue(u32 q)
{
    MMIO32(HW_TXQ_REQ_SELECT) = 1u << q;
    MMIO32(HW_TXQ_REQ_VALUE) = 1u << q;
    MMIO32(HW_TXQ_REQ_APPLY) = 1;
}

/* mac_ring_enable (0x8ea438, 22 Б): бит q регистра 0x886a14 = en, затем kick. */
void mac_ring_enable(u32 q, u32 en)
{
    MMIO32(HW_TXQ_RING_ENABLE) = (en << q) | (MMIO32(HW_TXQ_RING_ENABLE) & ~(1u << q));
    macq_kick_queue(q);
}

/* mac_ring_disable (0x8ea418, 30 Б). */
void mac_ring_disable(u32 q)
{
    u32 v = MMIO32(HW_TXQ_REQ_VALUE) & ~(1u << q);
    MMIO32(HW_TXQ_REQ_SELECT) = 1u << q;
    MMIO32(HW_TXQ_REQ_VALUE) = v;
    MMIO32(HW_TXQ_REQ_APPLY) = 1;
}

/* macq__clear_886a28_low2 (0x8ea450, 42 Б): импульс битов 0..1 регистра 0x886a28. */
void macq_clear_886a28_low2(void)
{
    MMIO32(HW_TXQ_PTR_RESET) |= 3u;
    arc_sync();
    MMIO32(HW_TXQ_PTR_RESET) &= ~3u;
    arc_sync();
}

/* txq_ptp_sw_is_fifo_idle (0x8ea47c, 60 Б). */
u32 txq_ptp_sw_is_fifo_idle(u32 a)
{
    u32 v;
    MMIO32(HW_TXQ_FIFO_SM_C) = 0x80000000u;
    MMIO32(HW_TXQ_PTP_SM) = 0x80000000u;
    v = (MMIO32(HW_TXQ_FIFO_SM_C) & 3u) | (MMIO32(HW_TXQ_PTP_SM) & 7u);
    fw_log_emit1(a << 4, 0x10134d8, v);
    return v == 0;
}

/* tx_macq::is_empty (0x8da15c, 100 Б): MACQ-дескриптор кольца пуст (голова == хвост). */
u32 tx_macq_is_empty(const struct vring_tbl_entry *e, u32 log)
{
    union { u16 h[8]; u32 w[4]; u8 b[16]; } d;
    macq_desc_read(d.h, e->macq, 2, 0, 1);
    if (log != 0) {
        fw_log_emit2(0x20, 0x1018f7c, d.h[0], d.h[1]);
        fw_log_emit2(0x20, 0x1018fa8, (d.w[2] >> 12) & 0xfffu, d.b[11] | ((d.w[3] & 0xfu) << 8));
    }
    return d.h[0] == d.h[1];
}

/* vring__program_macq_and_ba (0x8ea9d4, 76 Б): переписать начало/конец окна
 * MACQ-дескриптора кольца e. */
void vring_program_macq_and_ba(const struct vring_tbl_entry *e, u32 start, u32 size)
{
    u16 d[8];
    macq_desc_read(d, e->macq, 2, 0, 1);
    d[0] = (u16)start;
    d[1] = (u16)start;
    d[3] = (u16)start;
    d[2] = (u16)size;
    macq_desc_write(d, e->macq, 2, 0, 0, 0, 0, 1);
}

/* ---------------- LMAC-команды vring ---------------- */

/* lmac_if_send_cmd_0x08 (0x8dbb60, 84 Б): LMAC-команда 8 (конфигурация vring). */
void lmac_if_send_cmd_0x08(u32 a0, u32 a1, u32 pring, u32 vr, u32 f6, u32 f5, u32 flag)
{
    struct lmac_cmd_vring_cfg *c = lmac_cmd_pool_alloc();
    c->qid = (u8)vr;
    c->cid = (u8)pring;
    c->qset = a0;
    c->op = a1;
    c->flags_b0 = 0;
    c->qflags = ((f6 & 1u) << 6) | ((f5 & 1u) << 5);
    if (flag != 0)
        c->flags |= 2u;
    lmac_if_post_cmd(c, 8, 0x14, 0);
}

/* lmac_if_send_cmd_0x47 (0x8db79c, 32 Б): LMAC-команда 0x47 {vr, on}. */
void lmac_if_send_cmd_0x47(u32 vr, u32 on)
{
    struct lmac_cmd_fsched_peer *c = lmac_cmd_pool_alloc();
    c->vr = (u8)vr;
    c->on = (u8)on;
    lmac_if_post_cmd(c, 0x47, 2, 0);
}

/* ---------------- pring ---------------- */

/* pring__init (0x8d9174, 42 Б; vendor-имя wmi_evt__init_desc ошибочно): свободный pring. */
void wmi_evt_init_desc(struct pring *p, u32 id, u32 b, u32 c)
{
    p->state = 0;
    p->id = (u16)id;
    p->vr = 0x18;
    p->win_start = b;
    p->win_size = c;
    p->bound = 0;
    p->state = 1;
    p->stop_timer = 0;
    p->dma_timer = 0;
    p->conn_timer = 0;
    p->slot_timer = 0;
    p->polls = 0;
    p->bind_time = 0;
    p->stop_start = 0;
    p->l1_hold = 0;
}

/* vring_schd__add_sniffer_vring (0x8c2c14, 72 Б): завести очередной pring (до 3). */
void vring_schd_add_sniffer_vring(u32 id, u32 b, u32 c)
{
    u32 n = vring_schd.n_pring + 1;
    vring_schd.n_pring = n;
    if (n >= 3)
        fw_sysassert_fatal((void *)0, 0x12b5);
    wmi_evt_init_desc(&vring_schd.pring[id], (u16)id, b, c);
}

/* pring__set_done_handler (0x8e7334, 10 Б): обработчик завершения остановки pring
 * [0x800188] и его аргумент [0x80018c]. vendor ставит туда 0x9200 — младшее
 * отображение 0x8c9200; у нас — полный адрес порта. */
FWDATA(800188) pring_done_fn pring_done_handler = 0;

void pring_set_done_handler(pring_done_fn fn, u32 arg)
{
    pring_done_handler = fn;
    pring_done_arg = arg;
}

/* pring__init_pool (0x8d8cb0, 46 Б): пул записей vring, маска готовности, обработчик. */
void pring_init_pool(void)
{
    vring_schd.blocked = 0;
    mem_pool_init(&vring_rec_pool, vring_recs, sizeof(struct vring_rec), VRING_RECS_N);
    pring_set_done_handler(vring_schd_reconnect_next, 0);
}

/* sm_pring__cancel_timers (0x8c5b08, 60 Б; vendor-имя rm_main_sm__check_field_2c). */
void sm_pring_cancel_timers(struct pring *p)
{
    if (p->slot_timer != 0) {
        u_schd_cancel(p->slot_timer);
        p->slot_timer = 0;
    }
    if (p->stop_timer != 0) {
        u_schd_cancel(p->stop_timer);
        p->stop_timer = 0;
    }
    if (p->conn_timer != 0) {
        u_schd_cancel(p->conn_timer);
        p->conn_timer = 0;
    }
    if (p->dma_timer != 0) {
        u_schd_cancel(p->dma_timer);
        p->dma_timer = 0;
    }
}

/* sm_pring__count_and_sync_dma_wptr (0x8ebff8, 18 Б). */
void sm_pring_count_and_sync_dma_wptr(struct pring *p)
{
    pring_dma_wptr_sync_count += 1;
    macq_hw_sync_dma_wptr_fw(p->vr, p->id);
}

/* sm_pring__stop_done (0x8c6954, 64 Б; vendor-имя rm_main_sm__enter_step): очередь
 * остановлена — разобрать pring и позвать обработчик завершения [0x800188]. */
void sm_pring_stop_done(struct pring *p)
{
    sm_pring_count_and_sync_dma_wptr(p);
    mac_ring_disable(p->vr);
    hwd_dma_reset_ring(p->id);
    p->vr = 0x18;
    p->polls = 0;
    sm_pring_cancel_timers(p);
    p->state = 1;
    sm_pring_latch_tx_counters();
    (void)vring_active_ring_table();                /* vendor: результат затирается */
    pring_done_handler(p->id, pring_done_arg);
}

/* sm_pring__notify_step (0x8eaa38, 80 Б): накопить время работы записи по TSF. */
void sm_pring_notify_step(struct vring_rec *e, u32 a)
{
    u32 tsf[2];
    u32 dt = 0;
    u32 lo = e->tsf_lo, hi = e->tsf_hi;
    mac_read_tsf64(0, tsf, 0);
    if ((lo | hi) != 0 && (hi < tsf[1] || (hi == tsf[1] && lo < tsf[0])))
        dt = tsf[0] - lo;
    e->time += dt;
    if (a == 0) {
        tsf[0] = 0;
        tsf[1] = 0;
    }
    e->tsf_lo = tsf[0];
    e->tsf_hi = tsf[1];
}

/* 0x8023dc: таблица переходов switch vendor sm_pring__state_step (0x8ea69c;
 * ldb, цель = 0x8ea6ba + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(8023dc) const u8 sm_pring_state_step_jt[5] = {
    0x44, 0x3d, 0x00, 0x3d, 0x3d,
};

/* sm_pring__state_step (0x8ea69c, 184 Б): начать остановку работающего pring
 * (состояние 2 → 3) с таймаутом [0x800348]. Jump-table 0x8023dc: 0 — ассерт,
 * 1/3/4 — журнал, 2 — остановка. */
void sm_pring_state_step(struct pring *p)
{
    u32 st = p->state;
    u32 bit;

    if (st >= 5) {
        fw_sysassert_fatal((void *)0, 0x12a5);
        return;
    }
    if (st == 0) {
        fw_sysassert_fatal((void *)0, 0x12a5);
        return;
    }
    if (st != 2) {
        fw_log_emit0(0x27, 0x100d098);
        return;
    }
    bit = p->id + 8;
    p->state = 3;
    vring_reg_write_locked_28(1u << bit, 1);
    if (p->slot_timer != 0) {
        u_schd_cancel(p->slot_timer);
        p->slot_timer = 0;
    }
    if (p->conn_timer != 0) {
        u_schd_cancel(p->conn_timer);
        p->conn_timer = 0;
    }
    {
        u32 now = u_schd_now();
        p->stop_end = 0;
        p->stop_start = now << 4;
    }
    macq_hw_disable_queue_fw(p->id);
    pring_stop_count += 1;
    if (p->stop_timer != 0)
        fw_sysassert_fatal((void *)0, 0x12e8);
    p->stop_timer = u_schd_schedule(sm_pring_timeout_task, p->id, 0, 1,
                                    pring_stop_timeout, 0, 0);
    vring_reg_write_locked_3c(1u << bit, 1);
}

/* 0x8023ec: таблица переходов switch vendor sm_pring__timeout (0x8e9268;
 * ldb, цель = 0x8e92a4 + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(8023ec) const u8 sm_pring_timeout_jt[5] = {
    0xb6, 0xb6, 0xb6, 0x00, 0xb6,
};

/* sm_pring__timeout (0x8e9268, 460 Б): таймер остановки pring. Пока очередь MAC не
 * опустела — перевзвод (счётчик +0xc против лимита [0x800232]); пустая очередь DMA
 * → sm_pring_stop_done. Jump-table 0x8023ec: 3 — проверка, остальные — журнал. */
void sm_pring_timeout(struct pring *p)
{
    u32 hw = MMIO32(HW_TXQ_PTP_AVAIL);
    u32 had_timer;
    u32 now16;
    struct vring_tbl_entry *e;

    if (p->stop_timer == 0) {
        had_timer = 0;
        if (p->dma_timer == 0)
            fw_sysassert_fatal((void *)0, 0x12ae);
        else
            p->dma_timer = 0;
    } else {
        had_timer = 1;
        p->stop_timer = 0;
        if (p->dma_timer != 0)
            fw_sysassert_fatal((void *)0, 0x12a7);
    }

    if (p->state > 4) {
        fw_sysassert_fatal((void *)0, 0x12ab);
        return;
    }
    if (p->state != 3) {
        fw_log_emit1(0x27, 0x100d1d8, u_schd_now() << 4);
        return;
    }

    {
        u32 idle = dma_is_idle(p->id, 0);
        hwd_pcie_exit_l1(1);
        /* vendor пишет сюда r0 после hwd_pcie_exit_l1 (0x8e92bc) — у той функции нет
         * результата, r0 — остаток последней записи регистра PCIe. Поле — «L1 удерживается»:
         * ненулевое до выхода (ниже обнуляется вместе с exit_l1(0)), поэтому 1. */
        p->l1_hold = 1;
        if (idle != 0) {
            hwd_pcie_exit_l1(0);
            p->l1_hold = 0;
            fw_log_emit1(0x27, 0x100d1b4, p->vr);
            sm_pring_stop_done(p);
            return;
        }
    }

    e = vring_tbl_entry_addr(p->vr);
    if (tx_macq_is_empty(e, 0) != 0) {
        p->polls += 1;
        if (vring_pring_stop_max_polls < p->polls) {
            fw_log_emit1(7, 0x100d178, p->vr);
            fw_sysassert_fatal((void *)0, 0x12aa);
            return;
        }
        p->stop_timer = u_schd_schedule(sm_pring_timeout_task, p->id, 0, 1,
                                        pring_stop_timeout, 0, 0);
        fw_log_emit1(0x27, 0x100d144, p->polls);
        return;
    }

    now16 = u_schd_now() << 4;
    p->polls += 1;
    if (p->polls >= vring_pring_stop_max_polls) {
        dma_is_idle(p->id, 1);
        txq_ptp_sw_is_fifo_idle(0);
        tx_macq_is_empty(e, 1);
        fw_log_emit3(7, 0x100d0d8, p->vr, had_timer, hw);
        fw_sysassert_fatal((void *)0, 0x12a9);
    }
    p->stop_timer = u_schd_schedule(sm_pring_timeout_task, p->id, 0, 1,
                                    pring_stop_timeout, 0, 0);
    fw_log_emit3(0x27, 0x100d108, p->vr, now16, now16 - p->bind_time);
    {
        struct vring_rec *v = pring_find_by_id(p->vr8);
        if (v == 0)
            fw_sysassert_fatal((void *)0, 0x16ca);
        lmac_if_send_cmd_0x08(3, 3, v->pring, p->vr8, 0, 1, 0);
    }
}

/* Колбэк таймера остановки (0x8e0f3c, 16 Б): pring по номеру → sm_pring_timeout. */
void sm_pring_timeout_task(u32 i, u32 a1)
{
    (void)a1;
    sm_pring_timeout(&vring_schd.pring[i]);
}

/* vring_schd__has_waiting (0x8c3800, 44 Б; vendor-имя obj__has_pending_1c_10): есть ли
 * vring в очередях готовых приоритетов 0/1 (счётчики +0x10 и +0x1c). */
u32 obj_has_pending_1c_10(const struct vring_schd *s)
{
    return (s->ready[1].count != 0 || s->ready[0].count != 0) ? 1u : 0u;
}

/* sm_pring__notify_vring_state (0x8ea1b4, 134 Б): pring i, к которому привязана запись e,
 * либо останавливается (есть другие ждущие vring), либо перепривязывается к e. */
void sm_pring_notify_vring_state(u32 i, struct vring_rec *e)
{
    struct pring *p;
    struct vring_rec *bound;
    if (e == 0)
        fw_sysassert_fatal((void *)0, 0x12bb);
    p = &vring_schd.pring[i];               /* vendor проверяет и p == 0 (ассерт 0x12bc) —
                                             * адрес элемента массива нулём не бывает */
    bound = p->bound;
    if (e != bound)
        return;
    if (obj_has_pending_1c_10(&vring_schd) == 1) {
        bound->state = 4;
        vring_schd_stop_vring(&vring_schd, p);
        return;
    }
    sm_pring_bind_vring(p, bound->vr, vring_switch_interval_us, vring_switch_idle_th_us,
                        vring_slot_opt_delay, bound);
    sm_pring_notify_step(bound, 1);
}

/* sm_pring__connectivity_update (0x8ea254, 44 Б): истёк таймер «окна связи» [+0x28]. */
void sm_pring_connectivity_update(struct pring *p, struct vring_rec *e)
{
    if (p->conn_timer == 0)
        fw_sysassert_fatal((void *)0, 0x12a3);
    p->conn_timer = 0;
    sm_pring_notify_vring_state(p->id, e);
}

/* Колбэк таймера [+0x28] (0x8ea23c, 22 Б): a0 — запись vring, a1 — номер pring. */
void sm_pring_connectivity_task(u32 e, u32 i)
{
    sm_pring_connectivity_update(sm_pring_by_index(i), (struct vring_rec *)e);
}

/* sm_pring__slot_optimized (0x8ea298, 88 Б): истёк таймер [+0x2c]; если с привязки
 * не было ни одной передачи — отдать pring. */
void sm_pring_slot_optimized(struct pring *p, struct vring_rec *e)
{
    u32 cnt = mac_tx_cnt_delta_88_net_of_20();
    if (p->slot_timer == 0)
        fw_sysassert_fatal((void *)0, 0x12e7);
    p->slot_timer = 0;
    if (cnt != p->tx_cnt)
        return;
    if (p->conn_timer != 0) {
        u_schd_cancel(p->conn_timer);
        p->conn_timer = 0;
    }
    fw_log_emit2(0x27, 0x100d06c, p->id, u_schd_now() << 4);
    sm_pring_notify_vring_state(p->id, e);
}

/* Колбэк таймера [+0x2c] (0x8ea280, 22 Б): a0 — запись vring, a1 — номер pring. */
void sm_pring_slot_optimized_task(u32 e, u32 i)
{
    sm_pring_slot_optimized(sm_pring_by_index(i), (struct vring_rec *)e);
}

/* 0x8023d4: таблица переходов switch vendor sm_pring__bind_vring (0x8c49a0;
 * ldb, цель = 0x8c4a2a + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(8023d4) const u8 sm_pring_bind_vring_jt[5] = {
    0xbc, 0x15, 0xa7, 0xbc, 0xbc,
};

/* sm_pring__bind_vring (0x8c49a0, 532 Б): привязать запись vring к pring p.
 * Jump-table 0x8023d4: 1 — привязка, 2 — перевзвод таймера связи, иначе ассерт. */
void sm_pring_bind_vring(struct pring *p, u32 vr, u32 a2, u32 a3, u32 a4,
                         struct vring_rec *entry)
{
    u8 *cnt;

    if (a2 == 0)
        fw_sysassert_fatal((void *)0, 0x129d);
    if (p->stop_timer != 0)
        fw_sysassert_fatal((void *)0, 0x129e);
    if (vr >= 0x1f)
        fw_sysassert_fatal((void *)0, 0x1477);
    p->polls = 0;
    cnt = &pring_bind_vr_count[vr];
    *cnt = (u8)(*cnt + 1);
    if (*cnt == 10) {
        /* vendor: чтения состояния без использования результата (8c49de..8c4a0a) */
        (void)hwd_dma_get_rings_with_data();
        (void)MMIO32(HW_MTP_Q_AVAIL);
        (void)MMIO32(HW_BAP_Q_AVAIL_VEC);
        (void)vring_hw_field_addr_440c0c0(vr);
        (void)vring_hw_field_addr_440c100(vr);
        (void)hwd_dma_read_8813c8();
        (void)hwd_dma_read_8813f0();
        (void)mac_tx_cnt_get_ok();
        (void)mac_tx_cnt_get_fail();
        *cnt = 0;
    }

    switch (p->state) {
    case 1: {
        u32 pr;
        struct vring_tbl_entry *e;
        if (p->conn_timer != 0)
            fw_sysassert_fatal((void *)0, 0x129f);
        if (p->slot_timer != 0)
            fw_sysassert_fatal((void *)0, 0x10e6);   /* vendor: mov_s r1,0xe6; bset_s r1,r1,0xc (0x8c4b6e); прежде 0x12e6 — код calib_engine_on_start */
        p->bound = entry;
        p->vr = (u16)vr;
        pr = stream_mgr_pring_by_index((u16)vr);
        e = vring_tbl_entry_addr(p->vr);
        if (tx_macq_is_empty(e, 0) == 0) {
            fw_log_emit0(7, 0x100d010);
            fw_sysassert_fatal((void *)0, 0x12a0);
        }
        p->bind_time = u_schd_now() << 4;
        p->stop_end = 0;
        vring_program_macq_and_ba(e, p->win_start16, p->win_size16);
        macq_clear_886a28_low2();
        mac_ring_enable(p->vr, 1);
        {
            u32 st = MMIO32(HW_TXQ_PTP_AVAIL) >> p->vr;
            if (!(st & 1u)) {
                fw_log_emit3(7, 0x100d03c, MMIO32(HW_TXQ_PTP_AVAIL), p->vr, st & 1u);
                fw_sysassert_fatal((void *)0, 0x12a1);
            }
        }
        mac_mem_write_slot(p->id, a3, p->vr);
        pring_bind_count += 1;
        p->state = 2;
        if (pr == 0) {
            p->conn_timer = u_schd_schedule(sm_pring_connectivity_task, (u32)entry,
                                            p->id, 1, a2, 0, 0);
            p->tx_cnt = mac_tx_cnt_delta_88_net_of_20();
            p->slot_timer = u_schd_schedule(sm_pring_slot_optimized_task, (u32)entry,
                                            p->id, 1, a4, 0, 0);
            vring_reg_write_locked_3c(1u << p->id, 1);
            vring_reg_write_locked_28(1u << (p->id + 4), 1);
        }
        break;
    }
    case 2:
        if (p->bound == entry && p->conn_timer == 0)
            p->conn_timer = u_schd_schedule(sm_pring_connectivity_task, (u32)entry,
                                            p->id, 1, a2, 0, 0);
        break;
    default:
        fw_sysassert_fatal((void *)0, 0x12a2);
        break;
    }
}

/* ---------------- vring_schd ---------------- */

/* vring_schd__is_vring_ready (0x8c655c, 14 Б): pring-id запрещён (бит маски +0xa4). */
u32 vring_schd_is_vring_ready(const struct vring_schd *s, u32 bit)
{
    return s->blocked & (1u << bit);
}

/* vring_schd__pring_by_type (0x8c5b44, 72 Б; vendor-имя rm_ch_switch_sm__notify_
 * ch_switch_done ошибочно): pring для типа t (проверки занятости — только ассерты). */
struct pring *rm_ch_switch_sm_notify_ch_switch_done(struct vring_schd *s, u32 t)
{
    struct pring *p = &s->pring[t];
    if (p->bound == 0)
        return p;
    if (t == 1)
        fw_sysassert_fatal((void *)0, 0x140b);
    if (p->bound->prio != 0 && t == 1)
        fw_sysassert_fatal((void *)0, 0x140c);
    return p;
}

/* vring_schd__bind_if_free (0x8c7160, 72 Б): привязать запись к свободному pring
 * с параметрами окна [0x800074]/[0x800070]/[0x800078]. */
void vring_schd_bind_if_free(struct vring_schd *s, struct vring_rec *e, struct pring *p)
{
    (void)s;
    if (p->bound != 0)
        fw_sysassert_fatal((void *)0, 0x12be);
    e->state = 3;
    sm_pring_bind_vring(p, e->vr, vring_switch_interval_us, vring_switch_idle_th_us,
                        vring_slot_opt_delay, e);
    sm_pring_notify_step(e, 1);
}

/* vring_schd__stop_vring (0x8e80cc, 6 Б). */
void vring_schd_stop_vring(struct vring_schd *s, struct pring *p)
{
    (void)s;
    sm_pring_state_step(p);
}

/* vring_schd__move_to_ready (0x8c24b0, 256 Б): у vring есть данные — привязать к
 * pring или поставить в очередь готовых по приоритету e->prio. */
void vring_schd_move_to_ready(struct vring_schd *s, struct vring_rec *e)
{
    struct pring *p;
    struct vring_rec *bound;

    if (e->prio >= 2)
        fw_sysassert_fatal((void *)0, 0x1475);
    p = rm_ch_switch_sm_notify_ch_switch_done(s, e->pring_type);
    if (p == 0) {
        if (e->pring_type == 1)
            fw_sysassert_fatal((void *)0, 0x140d);
        list_find_entry_d((u32 *)&s->ready[e->prio], (u32 *)e);
        e->state = 2;
        return;
    }
    bound = p->bound;
    if (bound == 0 && vring_schd_is_vring_ready(&vring_schd, e->pring) == 0) {
        vring_schd_bind_if_free(s, e, p);
        return;
    }
    if (e->pring_type == 1)
        fw_sysassert_fatal((void *)0, 0x140e);
    if (e->prio == 1) {
        fw_log_emit1(0x27, 0x100bb08, e->vr);
        if (bound == 0)
            fw_sysassert_fatal((void *)0, 0x147c);
        bound->state = 4;
        vring_schd_stop_vring(s, p);
    }
    list_find_entry_d((u32 *)&s->ready[e->prio], (u32 *)e);
    e->state = 2;
    vring_reg_write_locked_28(1u << p->id, 0);
    vring_hw_set_ready_bit(p->id);
    vring_reg_write_locked_3c(1u << p->id, 1);
}

/* vring_schd__alloc_pring (0x8c2428, 56 Б): vring vr из списка ожидания → готов. */
void vring_schd_alloc_pring(u32 vr)
{
    struct vring_rec *e = 0;
    if (vring_list_find(&vring_schd, &vring_schd.waiting, vr, &e) == 0) {
        fw_sysassert_fatal((void *)0, 0x1498);
        return;
    }
    vring_schd_move_to_ready(&vring_schd, e);
}

/* vring_schd__move_ready_if_idle (0x8e8a70, 80 Б): колбэк прерывания DMA vring vr —
 * если vring разрешён (+0x20 == 1) и в кольце хоста есть данные — в готовые. */
void vring_schd_move_ready_if_idle(u32 vr, u32 a1)
{
    struct vring_rec *e = 0;
    (void)a1;
    if (vring_list_find(&vring_schd, &vring_schd.waiting, vr, &e) != 1)
        return;
    if (e->enabled != 1)
        return;
    if (hwd_dma_get_881c80(vr) == 0)
        return;
    tx_list_remove(&vring_schd.waiting, e);
    vring_schd_move_to_ready(&vring_schd, e);
}

/* vring_schdlr__isr_dispatch (0x8ebf90, 104 Б): по битам статуса DMA vring поставить
 * задачи vring_schd_move_ready_if_idle, затем замаскировать и квитировать. */
void vring_schdlr_isr_dispatch(void)
{
    u32 st = hwd_dma_read_status();
    u32 bits = st & 0xffffffu;
    if ((st >> 24) != 0)
        fw_sysassert_fatal((void *)0, 0x12b0);
    for (u32 m = bits; m != 0; ) {
        u32 i = 31u - (u32)__builtin_clz(m);   /* vendor: rsub 0x1e, norm — старший бит */
        u_schd_add(vring_schd_move_ready_if_idle, i, 0, 1);
        m &= ~(1u << i);
    }
    hwd_dma_op(bits, 1);
    hwd_dma_ack_881c44(bits, 1);
}

/* isr_vring_dma_fw (0x8c1350): тело вектора 9. */
void isr_vring_dma_fw(void)
{
    hwd_dma_bad_cause();
    vring_schdlr_isr_dispatch();
}

/* vring_schd__fill_vring_cfg (0x8e78cc, 108 Б): заполнить запись vring из ctx. */
void vring_schd_fill_vring_cfg(struct vring_rec *e, const struct stream_ctx *ctx, u32 prio, u32 slot, u32 bcast,
                               u32 en)
{
    if (en == 1) {
        if (slot == 0)
            fw_sysassert_fatal((void *)0, 0x12b2);
        if (e->state != 0)
            fw_sysassert_fatal((void *)0, 0x12b3);
    }
    e->pring_type = ctx->pring_type;
    e->vr = ctx->vr;
    e->pring = (u8)vring_get_pring_id(ctx);
    e->prio = (u8)prio;
    e->slot = (u16)slot;
    e->bcast = bcast;
    e->tsf_lo = 0;
    e->tsf_hi = 0;
    e->time = 0;
    e->enabled = en;
    vring_ack_and_unmask_irq(e);
}

/* vring__clear_hw_state (0x8caf30, 26 Б). */
void vring_clear_hw_state(struct vring_rec *e)
{
    e->state = 0;
    e->enabled = 0;
    e->tsf_lo = 0;
    e->tsf_hi = 0;
    e->time = 0;
    hwd_dma_op(1u << e->vr, 1);
}

/* vring_schd__remove_vring (0x8c8e90, 44 Б). */
void vring_schd_remove_vring(struct vring_schd *s, struct vring_rec *e)
{
    (void)s;
    fw_log_emit1(0x27, 0x100bb70, e->vr);
    vring_clear_hw_state(e);
    stream_mgr_check_vring(&vring_rec_pool, e);
}

/* vring_schd__prohibit_cids (0x8e1218, 14 Б): событие 3 автомату pring 0. */
void vring_schd_prohibit_cids(struct radio_mgr *rm)
{
    basic_sm_handle_event(&rm->sm, 3, 0, 0, 0);
}

/* ---------------- методы vring_schd (таблица 0x8008e8) ---------------- */

/* vring_schd::reset_irq (0x8c9830, 26 Б) — vt[1]. */
void vring_schd_vt_reset_irq(struct vring_schd_if *self)
{
    (void)self;
    vring_hw_unmask_irq(0xffffffffu, 1);
    vring_reg_write_locked_3c(0xffffffffu, 1);
}

/* vring_schd::reset (0x8c8f68, 38 Б) — vt[2]: таймеры снимает только у pring[0]
 * (vendor: add r0,r13,0x28). */
void vring_schd_vt_reset(struct vring_schd_if *self)
{
    struct vring_schd *s = (struct vring_schd *)self;
    hwd_dma_op(0xffffffffu, 1);
    hwd_dma_write_881c38(0xffffffffu, 1);
    sm_pring_cancel_timers(&s->pring[0]);
}

/* vring_schd::add_vring (0x8c2efc, 208 Б) — vt[3]: зарегистрировать vring ctx
 * (cfg — wmi vring_cfg, schd — schd_params {priority, timeslot_us}), запрограммировать
 * кольцо хоста в DMA и сообщить LMAC (команда 8). */
void vring_schd_vt_add_vring(struct vring_schd_if *self, const struct wmi_sw_ring_cfg *cfg,
                             struct stream_ctx *ctx, const struct wmi_vring_cfg_schd *schd, u32 en)
{
    struct vring_rec *e;
    u32 vr, pr, bcast, prio, slot;
    (void)self;
    e = mem_pool_allocate(&vring_rec_pool);
    if (e == 0)
        fw_sysassert_fatal((void *)0, 0x12b7);
    list_find_entry_d((u32 *)&vring_schd.waiting, (u32 *)e);
    vr = ctx->vr;
    pr = vring_get_pring_id(ctx);
    bcast = ctx->bcast;
    if (bcast != 0) {
        prio = 0;
        slot = 0;
    } else {
        if (schd == 0)
            fw_sysassert_fatal((void *)0, 0x1480);
        prio = schd->priority;
        slot = schd->timeslot_us;
    }
    hwd_dma_reset_vring(vr);                        /* через thunk 0x8e292c */
    hwd_dma_program_vring_desc(vr, cfg->ring_mem_base32[0], cfg->ring_mem_base32[1], cfg->ring_size);
    lmac_if_send_cmd_0x08(3, 0, (u8)pr, vr, 0, 0, 0);
    vring_tbl_entry_addr(vr)->state = 3;
    fw_log_emit3(0x27, 0x100bb3c, vr, pr, vr);
    vring_schd_fill_vring_cfg(e, ctx, (u16)prio, (u16)slot, bcast, en);
}

/* vring_schd::delete_vring (0x8c8f24, 64 Б) — vt[4]. */
void vring_schd_vt_delete_vring(struct vring_schd_if *self, u32 vr)
{
    struct vring_rec *e = 0;
    (void)self;
    if (vring_list_find(&vring_schd, &vring_schd.waiting, vr, &e) == 0) {
        fw_sysassert_fatal((void *)0, 0x12b8);
        return;
    }
    tx_list_remove(&vring_schd.waiting, e);
    vring_schd_remove_vring(&vring_schd, e);
}

/* vring_schd::suspend_vring (0x8e80d4, 200 Б) — vt[5]: запретить vring; если привязан —
 * остановить pring, иначе вернуть в ожидание и отложить stream_mgr_ready_for_modify. */
void vring_schd_vt_suspend_vring(struct vring_schd_if *self, u32 vr)
{
    struct vring_rec *e = 0;
    struct pring *p = 0;
    (void)self;
    fw_log_emit1(0x27, 0x100bbe4, vr);
    if (vring_schd_find_bound(&vring_schd, vr, &e, &p) == 1) {
        e->enabled = 0;
        if (e->state == 3) {
            e->state = 4;
            vring_schd_stop_vring(&vring_schd, p);
        }
        return;
    }
    /* vendor 0x8e8120: mov_s r14,2; b_s → sub_s r14,1 до первой итерации — списков
     * два (+0x10, +0x1c), i = 1, 0. Прежний порт начинал с i = 2 и брал за список
     * +0x28 = pring[0] (0x804de4): итератор шёл по 0x2000 → ICCM action point, 0x11a8. */
    for (u32 i = 1; i != (u32)-1; i--) {
        struct llist *l = &vring_schd.ready[i];
        if (vring_list_find(&vring_schd, l, vr, &e) == 1) {
            tx_list_remove(l, e);
            break;
        }
    }
    if (e != 0) {
        list_find_entry_d((u32 *)&vring_schd.waiting, (u32 *)e);
        vring_ack_and_unmask_irq(e);
    } else if (vring_list_find(&vring_schd, &vring_schd.waiting, vr, &e) == 0) {
        fw_sysassert_fatal((void *)0, 0x12b9);
        return;
    }
    e->enabled = 0;
    u_schd_add(stream_mgr_ready_for_modify, e->vr, 0, 1);
}

/* vring_schd::resume_vring (0x8e2ce8, 106 Б) — vt[6]. */
void vring_schd_vt_resume_vring(struct vring_schd_if *self, u32 vr)
{
    struct vring_rec *e = 0;
    (void)self;
    fw_log_emit1(0x27, 0x100bc14, vr);
    if (vring_list_find(&vring_schd, &vring_schd.waiting, vr, &e) == 0) {
        fw_sysassert_fatal((void *)0, 0x12ba);
        return;
    }
    e->enabled = 1;
    if (hwd_dma_get_881c80(vr) == 1) {
        tx_list_remove(&vring_schd.waiting, e);
        vring_schd_move_to_ready(&vring_schd, e);
    } else {
        vring_ack_and_unmask_irq(e);
    }
}

/* vring_schd::prohibit_prings (0x8e1228, 110 Б) — vt[7]: запретить pring по маске
 * (бит 8 не трогать) и остановить привязанные к ним vring. */
u32 vring_schd_vt_prohibit(struct vring_schd_if *self, u32 mask)
{
    u32 r = 0;
    struct pring *p = vring_schd.pring;
    (void)self;
    mask &= ~(1u << 8);
    vring_schd.blocked |= mask;
    for (u32 i = 0; i < vring_schd.n_pring; i++, p++) {
        struct vring_rec *e = p->bound;
        if (e == 0)
            continue;
        if (!((vring_schd.blocked >> e->pring) & 1u))
            continue;
        fw_log_emit1(0x27, 0x100bb94, e->vr);
        e->state = 4;
        vring_schd_stop_vring(&vring_schd, p);
        r = 1;
    }
    return r;
}

/* vring_schd::allow_prings (0x8c371c, 142 Б) — vt[8]: снять запрет и привязать к
 * свободным pring первые ждущие vring (списки готовых 1 → 0).
 * vendor 0x8c3750: mov_s r3,2; b_s → sub_s r3,1 до первой итерации — k = 1, 0 (как в
 * suspend_vring). Прежний порт начинал с k = 2 и брал за список +0x28 = pring[0]: «голова»
 * — окно pring[0] (0x2000, ICCM), при совпадении типа llist_pop_front портил pring[0]. */
void vring_schd_vt_allow(struct vring_schd_if *self, u32 mask)
{
    struct pring *p = vring_schd.pring;
    (void)self;
    vring_schd.blocked &= ~mask;
    for (u32 i = 0; i < vring_schd.n_pring; i++, p++) {
        if (p->bound != 0)
            continue;
        for (u32 k = 1; k != (u32)-1; k--) {
            struct llist *l = &vring_schd.ready[k];
            struct vring_rec *e = (struct vring_rec *)l->head;
            if (e == 0)
                continue;
            if (vring_schd_is_vring_ready(&vring_schd, e->pring) != 0)
                continue;
            if (i != e->pring_type)
                continue;
            llist_pop_front((u32 *)l);
            fw_log_emit1(0x27, 0x100bbc8, e->vr);
            vring_schd_bind_if_free(&vring_schd, e, p);
            break;
        }
    }
}

/* vring_schd::vring_of_pring (0x8cd05c, 26 Б) — vt[9]. */
u32 vring_schd_vt_vring_of_pring(struct vring_schd_if *self, u32 pr)
{
    struct vring_rec *e = vring_find_busy_index(pr);
    (void)self;
    return e != 0 ? e->vr : 0xffu;
}

/* vring_schd::time_of_pring (0x8cd034, 26 Б) — vt[10]. */
u32 vring_schd_vt_time_of_pring(struct vring_schd_if *self, u32 pr)
{
    struct vring_rec *e = vring_find_busy_index(pr);
    (void)self;
    return e != 0 ? e->time : 0;
}

/* vring_schd::clear_time_of_pring (0x8c6924, 20 Б) — vt[11]. */
void vring_schd_vt_clear_time(struct vring_schd_if *self, u32 pr)
{
    struct vring_rec *e = vring_find_busy_index(pr);
    (void)self;
    if (e != 0)
        e->time = 0;
}

/* ---------------- методы варианта (таблица 0x800918) ---------------- */

/* (0x8c984c, 8 Б) — vt[1]: обнулить карту pring → vring. */
void vring_schd_alt_vt_reset(struct vring_schd_if *self)
{
    struct vring_schd_alt *a = (struct vring_schd_alt *)self;
    memset0_words(a->vr_of_pring, sizeof(a->vr_of_pring));
}

/* (0x8ed598, 2 Б) — vt[2]: пусто. */
void vring_schd_alt_vt_nop2(struct vring_schd_if *self)
{
    (void)self;
}

/* (0x8c2fcc, 90 Б) — vt[3]: зарегистрировать vring ctx без планирования.
 * Карта — 8 байт, а bcast-vring даёт pring-id 8 (vring_get_pring_id) — vendor пишет и
 * туда (0x804e70 — счётчик списка mid); повторено как есть. */
void vring_schd_alt_vt_add_vring(struct vring_schd_if *self, const struct wmi_sw_ring_cfg *cfg,
                                 struct stream_ctx *ctx, const struct wmi_vring_cfg_schd *schd,
                                 u32 en)
{
    struct vring_schd_alt *a = (struct vring_schd_alt *)self;
    u32 vr = ctx->vr;
    u32 pr = vring_get_pring_id(ctx);
    (void)schd;
    (void)en;
    a->vr_of_pring[pr] = (u8)vr;
    hwd_dma_reset_vring(vr);
    hwd_dma_program_vring_desc(vr, cfg->ring_mem_base32[0], cfg->ring_mem_base32[1], cfg->ring_size);
    lmac_if_send_cmd_0x08(3, 0, (u8)pr, vr, 0, 0, 0);
    fw_log_emit3(0x27, 0x100bca8, vr, pr, vr);
}

/* (0x8c8f64, 2 Б) — vt[4]: пусто. */
void vring_schd_alt_vt_nop4(struct vring_schd_if *self, u32 vr)
{
    (void)self;
    (void)vr;
}

/* (0x8e819c, 8 Б) — vt[5]: LMAC 0x47 {vr, 0}. */
void vring_schd_alt_vt_suspend(struct vring_schd_if *self, u32 vr)
{
    (void)self;
    lmac_if_send_cmd_0x47(vr, 0);
}

/* (0x8e2d54, 8 Б) — vt[6]: LMAC 0x47 {vr, 1}. */
void vring_schd_alt_vt_resume(struct vring_schd_if *self, u32 vr)
{
    (void)self;
    lmac_if_send_cmd_0x47(vr, 1);
}

/* (0x8ed9bc, 4 Б) — vt[7]: 0. */
u32 vring_schd_alt_vt_ret0(struct vring_schd_if *self, u32 mask)
{
    (void)self;
    (void)mask;
    return 0;
}

/* (0x8ed594, 2 Б) — vt[8]: пусто. */
void vring_schd_alt_vt_nop8(struct vring_schd_if *self, u32 mask)
{
    (void)self;
    (void)mask;
}

/* (0x8cd078, 6 Б) — vt[9]: vring по pring из карты. */
u32 vring_schd_alt_vt_vring_of_pring(struct vring_schd_if *self, u32 pr)
{
    struct vring_schd_alt *a = (struct vring_schd_alt *)self;
    return a->vr_of_pring[pr];
}

/* (0x8cd050, 10 Б) — vt[10]. */
u32 vring_schd_alt_vt_time_of_pring(struct vring_schd_if *self, u32 pr)
{
    (void)self;
    return fwsh_sets.fsched_airtime[pr];
}

/* (0x8c6938, 14 Б) — vt[11]. */
void vring_schd_alt_vt_clear_time(struct vring_schd_if *self, u32 pr)
{
    (void)self;
    fwsh_sets.fsched_airtime[pr] = 0;
}


/* ---------------- таблицы методов (fw_data) ---------------- */

/* Таблица методов vring_schd (vendor 0x8008e8; vptr объекта 0x804dbc). */
FWDATA(8008e8) const struct vring_schd_vt vring_schd_vtbl = {
    .rsv0 = 0,
    .reset_irq = vring_schd_vt_reset_irq,           /* 0x8c9830 */
    .reset = vring_schd_vt_reset,                   /* 0x8c8f68 */
    .add_vring = vring_schd_vt_add_vring,           /* 0x8c2efc */
    .delete_vring = vring_schd_vt_delete_vring,     /* 0x8c8f24 */
    .suspend_vring = vring_schd_vt_suspend_vring,   /* 0x8e80d4 */
    .resume_vring = vring_schd_vt_resume_vring,     /* 0x8e2ce8 */
    .prohibit = vring_schd_vt_prohibit,             /* 0x8e1228 */
    .allow = vring_schd_vt_allow,                   /* 0x8c371c */
    .vring_of_pring = vring_schd_vt_vring_of_pring, /* 0x8cd05c */
    .time_of_pring = vring_schd_vt_time_of_pring,   /* 0x8cd034 */
    .clear_time = vring_schd_vt_clear_time,         /* 0x8c6924 */
};

/* Таблица методов варианта (vendor 0x800918; vptr объекта 0x804e64). */
FWDATA(800918) const struct vring_schd_vt vring_schd_alt_vtbl = {
    .rsv0 = 0,
    .reset_irq = vring_schd_alt_vt_reset,                   /* 0x8c984c */
    .reset = vring_schd_alt_vt_nop2,                        /* 0x8ed598 */
    .add_vring = vring_schd_alt_vt_add_vring,               /* 0x8c2fcc */
    .delete_vring = vring_schd_alt_vt_nop4,                 /* 0x8c8f64 */
    .suspend_vring = vring_schd_alt_vt_suspend,             /* 0x8e819c */
    .resume_vring = vring_schd_alt_vt_resume,               /* 0x8e2d54 */
    .prohibit = vring_schd_alt_vt_ret0,                     /* 0x8ed9bc */
    .allow = vring_schd_alt_vt_nop8,                        /* 0x8ed594 */
    .vring_of_pring = vring_schd_alt_vt_vring_of_pring,     /* 0x8cd078 */
    .time_of_pring = vring_schd_alt_vt_time_of_pring,       /* 0x8cd050 */
    .clear_time = vring_schd_alt_vt_clear_time,             /* 0x8c6938 */
};
