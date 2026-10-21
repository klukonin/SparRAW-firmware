// SPDX-License-Identifier: AGPL-3.0-or-later
/* RX-DMA цепочка (txrx_mgr__handle_dma_irq 0x8c9604 + примитивы). .textlate. */
#include "../include/types.h"
#include "../include/power.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/fwq_tx.h"
#include "../include/radio_mgr.h"
#include "../include/fwdata.h"
#include "../include/rx_ring.h"
#include "../include/conn.h"
#include "../include/mid.h"
#include "../include/ieee80211.h"
#include "../include/sys_cfg.h"
#include "../include/sched_scheme.h"

/* hwd_dma__uses_rgf_881c00_8d07d4 (0x8d07d4): чтение DMA-статуса [0x881c10] под IRQ-mask. */
__attribute__((section(".textlate"))) u32 hwd_dma_read_rx_tx_status(void)
{
    u32 s = arc_irq_disable();
    u32 r = MMIO32(HW_DMA_FW_ICR_C08_ICM);
    arc_irq_restore(s);
    return r;
}

/* hwd_dma__uses_rgf_881c00_8d0b44 (0x8d0b44): ack RX-ring [0x881c1c]. */
__attribute__((section(".textlate"))) void hwd_dma_ack_rx_ring(u32 value, u32 sync_flag)
{
    u32 s = arc_irq_disable();
    MMIO32(HW_DMA_FW_ICR_C08_IMS) = value;
    if (sync_flag) arc_sync();
    arc_irq_restore(s);
}

/* vring_hw__read_status_bit (0x8d0798, 32 Б): бит статуса vring idx. */
__attribute__((section(".textlate"))) u32 vring_hw_read_status_bit(u32 idx)
{
    u32 raw = idx * 0x380u + 0x44096e2u;
    return (MMIO32((raw >> 3) & ~3u) >> (raw & 0x1fu)) & 1u;
}

/* radio_mgr__get_current_channel (0x8cc130): radio_mgr->get_channel(ch) — *ch = текущий
 * канал, возврат — его параметр. */
__attribute__((section(".textlate"))) u32 radio_mgr_get_current_channel(u32 *ch)
{
    struct radio_mgr *rm = radio_mgr_obj;
    return rm->vt->get_channel(rm, ch);
}


/* Колбэк u_schd TX-кольца (0x8e9c40, 58 Б): завершённые пакеты своего TX_API —
 * кольцо 3 → 0x8421e4, 5 → 0x842274, 6 → 0x842154, иначе фатал 0x1222. Прежде здесь
 * ставился tx_desc_init_32 (tx.c, с подписью «0x8e9c40», но тело другое): индекс кольца
 * уходил указателем дескриптора — memset 0x20 Б по адресу 3/5/6. */
__attribute__((section(".textlate"))) void txrx_mgr_tx_complete_task(u32 idx, u32 a1)
{
    (void)a1;
    struct fwq_tx *api;
    switch (idx) {
    case 3: api = &tx_api_2; break;
    case 5: api = &tx_api_data; break;
    case 6: api = &tx_api_mgmt; break;
    default:
        fw_sysassert_fatal(0, 0x1222);
        return;
    }
    TX_API_handle_completed_packets(api);
}

/* txrx_mgr__handle_dma_irq (0x8c9604, 124 Б): обработчик RX/TX-DMA прерывания. */
__attribute__((section(".textlate"))) void txrx_mgr_handle_dma_irq(void)
{
    u32 status = hwd_dma_read_rx_tx_status();
    u32 bits = status & 0xfffu;
    txrx_dma_irq_count += 1;
    if ((status & 0xf0000000u) || ((status >> 12) & 0xfffu))
        fw_sysassert_fatal(0, 0x1207);
    while (bits) {
        u32 idx = 31 - (u32)__builtin_clz(bits);   /* vendor: rsub 0x1e,norm = старший бит */
        u_schd_fn cb = (vring_hw_read_status_bit(idx) == 1)
                     ? rx_api_drain_list_drain : txrx_mgr_tx_complete_task;
        u_schd_add(cb, idx, 0, 1);
        bits &= ~(1u << idx);
    }
    hwd_dma_ack_rx_ring(status & 0xfffu, 1);
}







/* rx_mgmt__action_no_ack (0x8c21e0, 72 Б): action no ack — категория 0x10 (DMG),
 * действие 3 → stream_mgr::action; прочее — дамп и освобождение. */
__attribute__((section(".textlate"))) void rx_mgmt_action_no_ack(struct rx_pkt *pkt)
{
    const struct ieee80211_action *a = (const struct ieee80211_action *)(pkt->body + IEEE80211_HDR_LEN);
    if (a->category == ACT_CAT_DMG && a->action == 3) {
        fw_log_emit2(0x2b, 0x101088c, a->action, a->category);
        stream_mgr_action(pkt);
    } else {
        fw_log_emit2(0x2b, 0x10108c0, a->action, a->category);
        hexdump_words(pkt->body, pkt->info.len);
        mem_pool_free_thunk(pkt);
    }
}

/* 0x802c58: таблица переходов vendor rx_mgmt_srvs__distribute (0x8e3ba4): ldb.x, 15 записей, цель = 0x8e3bca + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(802c58) __attribute__((aligned(1))) const u8 rx_mgmt_srvs_distribute_jt[15] = {
    0x00, 0x00, 0x00, 0x00, 0x0c, 0x0c, 0x31, 0x31, 0x31, 0x31, 0x00, 0x31,
    0x31, 0x21, 0x25,
};

/* rx_mgmt_srvs__distribute (0x8e3ba4, 152 Б): mgmt-кадр по подтипу (таблица 0x802c58):
 * 0..3, 10 (assoc/reassoc req/resp, disassoc) → rx_pkt_handler; 4, 5 (probe req/resp) →
 * метод [1] объекта e+0x234 записи mid info.mid (discovery__rx_pkt_handler);
 * 13 (action) → stream_mgr::action; 14 (action no ack) → rx_mgmt__action_no_ack;
 * остальные (в т. ч. 8 — DMG-бикон приходит extension-кадром через rx_pkt__mid_accepts)
 * — только журнал. */
__attribute__((section(".textlate"))) void rx_mgmt_srvs_distribute(struct rx_pkt_srvs *obj, struct rx_pkt *pkt)
{
    u32 sub = FC_STYPE(pkt->hdr->fc);
    (void)obj;
    switch (sub) {
    case 0: case 1: case 2: case 3: case 10:
        fw_log_emit2(0x2d, 0x1013efc, sub, pkt->info.mid);
        rx_pkt_handler(pkt);
        break;
    case 4: case 5: {
        struct mid_disc *e = &mid_list_by_mid_fw(pkt->info.mid)->disc;
        fw_log_emit1(0x2d, 0x1013f38, pkt->info.mid);
        e->vt->rx_pkt(e, pkt);
        break;
    }
    case 13:
        stream_mgr_action(pkt);
        break;
    case 14:
        fw_log_emit1(0x2d, 0x1013f5c, pkt->info.mid);
        rx_mgmt_action_no_ack(pkt);
        break;
    default:
        fw_log_emit1(0x1d, 0x1013f80, sub);
        break;
    }
}

/* rx_pkt_srvs__distribute_data (0x8e3af4, 136 Б): data-кадр — лог, проверка
 * frame-control, счётчик и освобождение пакета. */
__attribute__((section(".textlate"))) void rx_pkt_srvs_distribute_data(struct rx_pkt_srvs *obj, struct rx_pkt *pkt)
{
    const struct ieee80211_hdr *h;
    u32 fc, cid, len;
    (void)obj;
    if (pkt == 0) fw_sysassert_fatal(0, 0x117e);
    if (pkt->body == 0) fw_sysassert_fatal(0, 0x117f);
    h = (const struct ieee80211_hdr *)pkt->body;
    fc = h->fc_dur;
    cid = pkt->info.cid;
    len = pkt->info.len;
    fw_log_emit3(0x1d, 0x1013fd4, cid, FC_STYPE(fc), len);
    if (FC_TYPE(fc) != FC_TYPE_DATA)
        fw_sysassert_fatal(0, 0x1180);
    fc = h->fc_dur;
    fw_log_emit1(0x1d, 0x1014000, FC_STYPE(fc));
    rx_pkt_srvs.data_rx_count += 1;
    mem_pool_free_thunk(pkt);
}

/* rx_pkt__mid_accepts (0x8e3b7c, 40 Б): extension-кадр (type 3) подтипа 0 (DMG-бикон)
 * → метод [1] объекта e+0x234 записи mid (discovery__rx_pkt_handler). Прежний порт
 * передавал методу саму запись mid вместо e+0x234. */
__attribute__((section(".textlate"))) void rx_pkt_mid_accepts(struct rx_pkt_srvs *obj, struct rx_pkt *pkt)
{
    struct mid_disc *e = &mid_list_by_mid_fw(pkt->info.mid)->disc;
    (void)obj;
    if ((pkt->hdr->fc & 0xf0u) == 0)
        e->vt->rx_pkt(e, pkt);
}

/* rx_pkt_srvs__dispatch (0x8e3c70, 152 Б): диспетчер по типу кадра. */
__attribute__((section(".textlate"))) void rx_pkt_srvs_dispatch(struct rx_pkt_srvs *obj, struct rx_pkt *pkt)
{
    pkt->hdr = (struct ieee80211_hdr *)pkt->body;
    pkt->rsv_10 = 0;
    rx_pkt_lookup_handler(obj, &pkt->info.channel);
    if (rx_drop_all != 0) {
        mem_pool_free_thunk(pkt);
        return;
    }
    {
        const struct ieee80211_hdr *hid = pkt->hdr;
        u32 ft = FC_TYPE(hid->fc_dur);
        u32 r4 = pkt->info.len;
        if (r4 >= IEEE80211_HDR_LEN) {
            if (ft == FC_TYPE_MGMT) rx_mgmt_srvs_distribute(obj, pkt);
            else if (ft == FC_TYPE_DATA) rx_pkt_srvs_distribute_data(obj, pkt);
            else if (ft == FC_TYPE_EXT) rx_pkt_mid_accepts(obj, pkt);
            else {                          /* type 1 (control) — журнал и освободить */
                fw_log_emit1(0x2d, 0x1013ed4, pkt->info.mid);
                mem_pool_free_thunk(pkt);
            }
        } else {
            fw_log_emit3(0xd, 0x1013eac, pkt->info.mid, ft, r4);   /* r2, r3, r4 (8e3cae) */
            mem_pool_free_thunk(pkt);
            rx_short_frame_drop_count += 1;
        }
    }
}

/* Таблицы методов объекта RX-служб rx_pkt_srvs (include/ieee80211.h; ставит конструктор
 * 0x8c19b8 — ctor_obj_842840_vtables). */
/* 0x800874 */
FWDATA(800874) const struct rx_pkt_srvs_vt rx_pkt_srvs_vtbl = {
    .alloc_ei = rx_mgmt_prs_alloc_ei,          /* vendor 0x8e0a84 */
    .dispatch = rx_pkt_srvs_dispatch,          /* vendor 0x8e3c70 */
};
/* 0x800880 */
FWDATA(800880) const struct rx_pkt_srvs_vt2 rx_pkt_srvs_vtbl2 = {
    .dispatch = rx_pkt_srvs_dispatch_thunk,    /* vendor 0x8ed58c */
};

/* rx_pkt_srvs__dispatch_default (0x8e3a90, 12 Б). */
__attribute__((section(".textlate"))) void rx_pkt_srvs_dispatch_default(struct rx_pkt *pkt)
{
    rx_pkt_srvs_dispatch(&rx_pkt_srvs, pkt);
}

/* rx_api__drain_list init (0x8e39dc): настройка RX-списка. */
__attribute__((section(".textlate"))) void rx_api_drain_list_init(struct rx_desc *d, u32 mask, u32 arg2, u32 arg3)
{
    u32 ctrl;
    memset0_words(d, 0x20);
    d->buf = mask;
    d->w6 = arg2;
    ctrl = d->ctrl;
    d->ctrl = (ctrl & ~(1u << 10)) | (1u << 10);
    d->len = (u16)arg3;
    d->ctrl = ctrl | 0x600u;
}

/* ---------------- RX-кольцо DMA (struct rx_ring, include/rx_ring.h) ---------------- */

/* Объект RX-кольца (в образе нули; таблицу методов ставит ctor_obj_805fe4_vtable, кольцо и
 * пул — rx_pool__init, fw/l2mgr.c). */
/* vendor 0x805fe4 */
FWDATA(805fe4) struct rx_ring rx_ring = { 0 };

/* fwq_tx__count_below_limit (0x8e3c48, 26 Б): 1, если занято RX-буферов (rx_ring.pool.used)
 * меньше их числа (rx_ring.pool.count). */
__attribute__((section(".textlate"))) u32 fwq_tx_count_below_limit(void)
{
    return (*(volatile u32 *)&rx_ring.pool.used < *(volatile u32 *)&rx_ring.pool.count) ? 1u : 0u;
}

/* fwq_tx__get_count (0x8e3c64, 10 Б): число занятых RX-буферов (rx_ring.pool.used). */
__attribute__((section(".textlate"))) u32 fwq_tx_get_count(void)
{
    return *(volatile u32 *)&rx_ring.pool.used;
}

/* fwq_tx__handle_completion (0x8cc7c4, 284 Б): снять принятые кадры RX-кольца r в список
 * list. Дескриптор (struct rx_desc): buf — 18 младших бит адреса буфера (буфер = кадр
 * +0x38), status бит 0 — готов, бит 2 → info.status; len — длина. Каждый снятый дескриптор
 * получает новый буфер (rx_buf__alloc), голова кольца уходит в DMA. Пул исчерпан
 * (count_below_limit = 0) — журнал «RING PENDED», r->pended = 1, выход. */
__attribute__((section(".textlate"))) void fwq_tx_handle_completion(struct rx_dma_ring *r, struct llist *list)
{
    u32 n = 0;
    struct rx_desc *d;
    vring_reg_write_locked_0c(1u << r->dma_ring, 0);
    d = (struct rx_desc *)tx_desc_by_index(&r->r, r->r.tail);
    while (d->status & 1u) {
        u32 buf;
        struct rx_pkt *pkt;
        if (fwq_tx_count_below_limit() == 0) {
            fw_log_emit2(0x27, 0x1018ce4, fwq_tx_get_count(), n);
            r->pended = 1;
            break;
        }
        r->pended = 0;
        /* vendor: bset.f по результату с уже поставленными битами 18/23 — флаг Z не
         * поднимается никогда, ассерт 0x1002 недостижим; повторено как есть. */
        buf = d->buf | (1u << 18) | (1u << 23);
        if (buf == 0)
            fw_sysassert_fatal(0, 0x1002);
        pkt = RX_PKT_OF_BUF(buf);
        pkt->info.status = (u16)((d->status >> 2) & 1u);
        pkt->info.len = d->len;
        pkt->info.qid = (u8)((d->w1 >> 16) & 0x1fu);
        pkt->info.mid = (u8)new_link_evt();
        pkt->info.cid = (u8)((d->w0 >> 4) & 7u);
        pkt->info.mcs = (u8)((d->w1 >> 21) & 0xfu);
        pkt->rsv_10 = 0;
        pkt->body = (u8 *)buf;
        list_find_entry_d((u32 *)list, (u32 *)pkt);
        n++;
        d->buf = (u32)rx_buf_alloc() & 0x3ffffu;
        d->status &= (u8)~1u;
        tx_ring_advance_index(&r->r, &r->r.tail);
        tx_ring_advance_index(&r->r, &r->r.head);
        hwd_dma_write_ring_reg(r->dma_ring, r->r.head);
        d = (struct rx_desc *)tx_desc_by_index(&r->r, r->r.tail);
    }
    vring_reg_write_locked_20(1u << r->dma_ring, 0);
}

/* fwq_tx__handle_completion_thunk (0x8cc740, 6 Б; rx_ring_vtbl [1]): кольцо — объект +4. */
void fwq_tx_handle_completion_thunk(struct rx_ring *obj, struct llist *list)
{
    fwq_tx_handle_completion(&obj->ring, list);
}

/* Таблица методов RX-кольца (include/rx_ring.h). */
/* vendor 0x800714 */
FWDATA(800714) const struct rx_ring_vt rx_ring_vtbl = {
    .rsv0 = 0,
    .drain = fwq_tx_handle_completion_thunk,
};

/* rx_api__drain_list (0x8e3a0c, 132 Б): колбэк u_schd от txrx_mgr__handle_dma_irq —
 * idx = номер DMA-кольца (только RX-кольцо 4, иначе ассерт 0x1215). Снятые из кольца
 * кадры (список на стеке) по одному — диспетчеру кадров; пустой элемент — ассерт 0x1001,
 * info.qid не 0/1 — ассерт 0x1216 (кадр не разбирается). Прежний порт: аргумент
 * считался списком, кольцо не снималось — ни один принятый кадр не доходил до разбора. */
__attribute__((section(".textlate"))) void rx_api_drain_list_drain(u32 idx, u32 a1)
{
    (void)a1;
    struct llist list;
    if (idx != 4)
        fw_sysassert_fatal(0, 0x1215);
    llist_init((u32 *)&list);
    fwq_tx_handle_completion_thunk(&rx_ring, &list);
    while (list.count != 0) {
        struct rx_pkt *pkt = (struct rx_pkt *)llist_pop_front((u32 *)&list);
        if (pkt == 0) {
            /* vendor после ассерта разбирает элемент по адресу 0 — не повторяем */
            fw_sysassert_fatal(0, 0x1001);
            continue;
        }
        if (pkt->info.qid != 0 && pkt->info.qid != 1) {
            fw_sysassert_fatal(0, 0x1216);
            continue;
        }
        rx_pkt_srvs_dispatch_default(pkt);
    }
}


/* rx_pkt__lookup_handler (0x8cc118, 24 Б): текущий канал радио (байт) в out. Прежде —
 * заглушка «канал 2». */
__attribute__((section(".textlate"))) void rx_pkt_lookup_handler(struct rx_pkt_srvs *ctx, u8 *out)
{
    u32 ch;
    (void)ctx;
    radio_mgr_get_current_channel(&ch);
    *out = (u8)ch;
}

/* mem_pool__free_thunk (0x8cb15c → 0x8cb19c): вернуть RX-пакет в пул rx_ring.pool
 * (mbox.c mem_pool_free_8cb19c). Прежний порт освобождал в 0x842840 — это таблица
 * разбора кадров (5 × 0xd4 Б, rx_mgmt__find_free_ei 0x8c3370), не пул пакетов. */
__attribute__((section(".textlate"))) void mem_pool_free_thunk(struct rx_pkt *pkt)
{
    mem_pool_free_8cb19c((u32)pkt);
}

/* find_mngr__detect_discovery_bcon (0x8c7f40, 86 Б): детект discovery-бикона. */
__attribute__((section(".textlate"))) u32 find_mngr_detect_discovery_bcon(struct find_mngr *obj, struct rx_pkt *bcn)
{
    const union mac_addr *r15 = &bcn->hdr->addr1;
    u32 r17 = *bcn->ei->bi_ctrl >> 1;   /* lsr r17,r0 = байт>>1 */
    if (find_main_sm_first_detection(&obj->sm, r15, obj->mode) == 0)
        return 0;
    fw_log_emit3(0x29, 0x1017918, mac_lo32(r15), r15->h[2], r17 & 1);
    basic_sm_handle_event(&obj->sm, 3, (u32)bcn, obj->mode, 0);
    return (obj->mode == 2) ? 1u : 0u;
}
/* find_main_sm__first_detection (0x8f2ee0, 45 Б): 1 если НЕ найден (первое обнаружение). */
__attribute__((section(".textlate"))) u32 find_main_sm_first_detection(struct find_sm *obj, const void *ptr, u32 field)
{
    (void)field;
    fw_log_emit0(0x2c, 0x1017b50);
    return (find_main_sm_bcon_step(&obj->found, ptr) == 0) ? 1u : 0u;
}

/* Схема расписания записи mid (0x805234) и курсор слотов ESE (0x8052e4); в образе нули,
 * заполняют конструкторы (fw/ctors.c) и mid__init_sched_scheme (fw/mid.c). */
FWDATA(805234) struct sched_scheme sched_scheme = { 0 };
FWDATA(8052e4) struct ese_sched ese_sched = { 0 };

/* dmg_bcon__build_allocations (0x8df698, 21 Б): tail-call в build_allocations_from_beacon. */
__attribute__((section(".textlate"))) void dmg_bcon_build_allocations(struct mid *a, struct rx_pkt *b)
{
    schedule_scheme_builder_build_allocations_from_beacon(a->sched, &b->ei->ext_sched);
}
/* schedule_scheme_builder__build_allocations_from_beacon (0x8c5248, 120 Б). */
__attribute__((section(".textlate"))) void schedule_scheme_builder_build_allocations_from_beacon(struct sched_scheme *obj, const struct ie_ref *bcn)
{
    obj->ese->tbl->mode = 2;
    obj->built = 1;
    const struct ese_alloc *r13 = (const struct ese_alloc *)bcn->body;
    u32 r16 = (u8)fw_divmod_signed(bcn->len, sizeof(struct ese_alloc));   /* vendor 0x8c5266: extb — беззнаково */
    if (sched_alloc_changed(obj, r13, r16) == 0)
        return;
    sched_builder_reset_alloc_list(obj->ese);
    u32 r18 = mac_get_bi_start_tsf();
    u32 r15 = 0;
    if (r16 >= 1) {
        u32 r17 = r16;
        do {
            if (cid_pair_matches(obj, r13->src_aid, r13->dst_aid) != 0) {
                ese_alloc_to_slot(obj, r18, r13);
                r15++;
            }
            r17--;
            r13++;
        } while (r17 >= 1);
    }
    fw_log_emit2(0x2b, 0x1014498, r15 & 0xff, r16);
    schedule_scheme_sum_two(obj);
}
/* sched__alloc_changed (0x8da3f4, 108 Б): изменилась ли alloc. ESE-режим: число слотов
 * ≠ c или 0x10 биконов без изменений — сброс счётчика и 1. Иначе — сравнение первого
 * распределения бикона с первым слотом таблицы: номер (биты 0..3), src/dst aid.
 * Исправлено (порт): сравнивались номер по маске 7 и байты [tbl+2]/[tbl+3] заголовка
 * таблицы. Vendor: 0x8da432 ld.a r3,[r2,0x4] (r2 += 4 — указатель на слот 0),
 * 0x8da438/0x8da43a bmsk_s …,0x3 (биты 0..3 у обоих), 0x8da442 ldb_s r3,[r2,0x2] и
 * 0x8da44a ldb_s r2,[r2,0x3] — src/dst aid слота 0 (таблица + 6/+7). */
__attribute__((section(".textlate"))) u32 sched_alloc_changed(struct sched_scheme *obj, const struct ese_alloc *a, u32 c)
{
    struct ese_sched *r3 = obj->ese;
    /* OOB R2 (счётчик повторов таблицы) — только SparRAW-pro. */
    (void)c;
    const struct ese_slot_tbl *r2 = r3->tbl;
    if (r2->count == 0)
        return 1;
    if ((r2->slot[0].ctrl & 0xfu) != (a->ctrl[0] & 0xfu))
        return 1;
    if (r2->slot[0].src_aid != a->src_aid)
        return 1;
    return (r2->slot[0].dst_aid == a->dst_aid) ? 0u : 1u;
}
/* mac__get_bi_start_tsf (0x8e457c, 20 Б): [0x886f80+0x44]. */
__attribute__((section(".textlate"))) u32 mac_get_bi_start_tsf(void)
{
    return MMIO32(HW_MAC_BI_START_TSF_LO);
}
/* cid_pair__matches (0x8da62c, 50 Б): cid-пара с 0xff-wildcard (ARC cmp.cc-цепочка). */
__attribute__((section(".textlate"))) u32 cid_pair_matches(struct sched_scheme *obj, u32 a, u32 b)
{
    u32 cid = obj->mid->aid;
    if (a == cid || a == 0xff)
        return 1;
    return (b == cid || b == 0xff) ? 1u : 0u;
}
/* ese__alloc_to_slot (0x8c7d4c, 138 Б): собрать слот ESE (2×bit-set + таблица).
 * Исправлено (порт): номер распределения брался по маске 7; vendor 0x8c7d5a bmsk_s
 * r1,r1,0x3 — биты 0..3 (Allocation ID — 4 бита). */
__attribute__((section(".textlate"))) void ese_alloc_to_slot(struct sched_scheme *obj, u32 a, const struct ese_alloc *b)
{
    struct ese_slot sp;   /* vendor: стековый мусор в незаписанных битах слова 0 */
    sp.ctrl = 0;
    sp.start = 0;
    sp.dur = 0;
    sp.rsv_0a = 0;
    sp.ctrl = (sp.ctrl & ~0xfu) | (b->ctrl[0] & 0xfu);                      /* bits_set32_s0_w4 */
    sp.ctrl = (sp.ctrl & ~(3u << 4)) | (((b->ctrl[0] >> 4) & 3u) << 4);     /* bits_set32_s4_w2 */
    sp.ctrl &= ~(1u << 6);
    u32 cid = obj->mid->aid;
    u32 b4 = b->src_aid;
    sp.ctrl = (sp.ctrl & ~(1u << 7)) | (((b4 == cid || b4 == 0xff) ? 1u : 0u) << 7);
    sp.peer_cid = (u8)ese_peer_cid_by_aid(obj, b->src_aid, b->dst_aid);
    sp.src_aid = b->src_aid;
    sp.dst_aid = b->dst_aid;
    u32 r = b->start[0] | ((u32)b->start[1] << 8) | ((u32)b->start[2] << 16) | ((u32)b->start[3] << 24);
    sp.start = r - a;
    sp.dur = (u16)(b->block_dur[0] | ((u32)b->block_dur[1] << 8));
    ese_slot_table_add(obj->ese, &sp);
}
/* ese__peer_cid_by_aid (0x8cc9c8, 85 Б): маска cid пира по aid (у PCP/AP wildcard-выбор
 * инвертирован); obj+0x10 — запись mid схемы расписания. Сначала vendor зовёт
 * mid__state_is_2_or_3(0) (bl.d 0x8da488), затем читает [obj+0x10] и байт [mid+8]; итог —
 * extb_s (без знака; прежде — (s8), все вызывающие всё равно берут младший байт). */
__attribute__((section(".textlate"))) u32 ese_peer_cid_by_aid(struct sched_scheme *obj, u32 a, u32 b)
{
    u32 st = mid_state_is_2_or_3(0);
    struct mid *r1 = obj->mid;
    u32 cid = r1->aid;
    u32 flag = (a == cid || a == 0xff) ? 1u : 0u;
    u32 arg = (st != 0) ? (flag ? b : a) : (flag ? a : b);
    return (u8)mid_cid_by_aid(r1, arg);
}
/* mid__cid_by_aid (0x8cc06c, 118 Б): маска cid (1 << cid, u16) соединения записи mid obj
 * с AID aid (wildcard 0xff → cid_mask записи). Соединение не в KEY_ASSOC (7) — ассерт
 * 0x1225 и поиск дальше по списку.
 * Исправлено (порт): обход шёл битовым итератором (field_set_0x00_8e5dfc /
 * bit_iter_has_more / bitmap_alloc_bit) по адресу списка — aid/cid читались из [номер бита
 * + 9 / + 8] (младшие адреса), состояние — из [obj+0x124] записи mid, после ассерта —
 * возврат. Vendor: 0x8cc07e iter__init (0x8e5df4) по obj+0x18, 0x8cc0aa list__has_items
 * (0x8cdcb8), 0x8cc09c iter__next (0x8df438), aid [c+9], cid [c+8], 0x8cc0d4 ldb
 * r0,[r14,0x124] — состояние conn_main_sm соединения, 0x8cc0ec b_s 0x8cc0aa — дальше по
 * списку; итог extw_s (u16). AID сравнивается со всем словом aid (breq r13,r0). */
__attribute__((section(".textlate"))) u32 mid_cid_by_aid(struct mid *obj, u32 aid)
{
    u32 it;
    struct conn *c;
    iter_init(&it, &obj->conns);
    if (aid == 0xff) {
        fw_log_emit0(0x2b, 0x100cf98);
        return obj->cid_mask;
    }
    while (list_has_items(&it)) {
        c = (struct conn *)iter_next(&it);
        if (c->aid != aid)
            continue;
        fw_log_emit2(0x2b, 0x100cfec, aid, c->cid);
        if (c->msm.sm.state != 7) {
            fw_sysassert_fatal((void *)0, 0x1225);
            continue;
        }
        return (u16)(1u << c->cid);
    }
    fw_log_emit1(0x2b, 0x100cfb0, aid);
    return 0;
}
/* ese__slot_table_add (0x8e1d38, 68 Б): вставить 12-байт слот (stride 0xc), count++. */
__attribute__((section(".textlate"))) void ese_slot_table_add(struct ese_sched *obj, const void *slot)
{
    struct ese_slot_tbl *r1 = obj->tbl;
    u32 r0 = r1->count;
    if (r0 >= ESE_SLOTS_N)
        fw_sysassert_fatal((void *)0, 0x11bb);
    memcpy_fw(&r1->slot[r0], slot, sizeof(struct ese_slot));
    r1->count = (u8)(r0 + 1);
}
/* schedule_scheme__sum_two (0x8e0d48, 36 Б): [obj+8] = TSF начала BI + BI (мкс), затем
 * дважды lmac_if__evt_walk(obj). Прежний порт брал TSF за указатель объекта (mov_s r13,r0
 * в слоте задержки сохраняет obj до вызова) и писал в [TSF+8]. */
__attribute__((section(".textlate"))) void schedule_scheme_sum_two(struct sched_scheme *obj)
{
    u32 tsf = mac_get_bi_start_tsf();
    obj->next_bi_tsf = mac_get_beacon_interval_us() + tsf;
    lmac_if_evt_walk(obj);
    lmac_if_evt_walk(obj);
}
/* mac__get_beacon_interval_us (0x8e456c, 24 Б): (u16)[0x886d64] << 10. */
__attribute__((section(".textlate"))) u32 mac_get_beacon_interval_us(void)
{
    /* vendor 0x8e4572: ld_s — чтение 32 бит, 0x8e4574: extw_s — беззнаково (было ldh.x). */
    return (MMIO32(HW_MAC_BEACON_INTERVAL) & 0xffffu) << 10;
}
/* lmac_if__evt_walk (0x8e1cd8, 85 Б): пройти 4 evt-слота + запрограммировать alloc-регистры. */
__attribute__((section(".textlate"))) void lmac_if_evt_walk(struct sched_scheme *obj)
{
    u32 r14 = 0;
    while (r14 < 4) {
        const struct ese_slot *ev = lmac_evt_entry_end(obj->ese);   /* текущий слот: 0x8c7ef0 */
        u32 r3 = ev->start + obj->next_bi_tsf;
        u32 r2 = ev->ctrl_lo;                       /* ldw_s r2,[r0,0] */
        u32 r15 = r2 | (1u << 6);
        u32 r1 = ev->dur + r3;                      /* ldw_s r1,[r0,0x8] */
        if (r14 == 3)
            r2 = r15;
        if ((ev->ctrl & (1u << 7)) == 0)            /* btst_s r0,7 + and.eq: бит 7 сброшен */
            r2 = (r2 & 0xc3ffffffu) | (1u << 26) | (1u << 28);
        /* vendor 0x8e1d14: bl.d 0x8d0ea8, в слоте mov_s r0,r3 → (r0 = начало, r1 = конец,
         * r2 = флаги). Прежний порт передавал (r3, r2, r1): конец и флаги менялись местами
         * в 0x886f84/0x886f88. */
        sched_program_alloc_slot_regs(r3, r1, r2);
        if (lmac_if_evt_first_field(obj->ese) != 0)
            obj->next_bi_tsf = mac_get_beacon_interval_us() + obj->next_bi_tsf;
        r14++;
    }
}
/* lmac_evt__entry_end (0x8c7ef0, 16 Б): текущий слот таблицы: &tbl->slot[cur]. noinline —
 * отдельная функция у vendor (встроенная, gcc -Os пересчитывает cur·12 на каждое поле). */
__attribute__((section(".textlate"), noinline)) struct ese_slot *lmac_evt_entry_end(struct ese_sched *obj)
{
    return &obj->tbl->slot[obj->cur];
}
/* sched__program_alloc_slot_regs (0x8d0ea8, 20 Б): 3 MMIO-записи alloc-слота (конец,
 * начало, флаги). volatile: vendor пишет 0x886f84, 0x88c050, 0x886f88 именно в этом
 * порядке; прежде (обычные записи) gcc при встраивании в lmac_if_evt_walk мог их
 * переставить. */
__attribute__((section(".textlate"))) void sched_program_alloc_slot_regs(u32 a, u32 b, u32 c)
{
    MMIO32(HW_MAC_SCHED_SLOT_END) = b;
    MMIO32(HW_MAC_EXT_SCHED_SLOT_START) = a;
    MMIO32(HW_MAC_SCHED_SLOT_CTRL) = c;
}
/* lmac_if__evt_first_field (0x8c65fc, 42 Б): cur = (cur + 1) % tbl->count, 1 если 0. */
__attribute__((section(".textlate"))) u32 lmac_if_evt_first_field(struct ese_sched *obj)
{
    u32 a = obj->cur + 1;
    u32 b = obj->tbl->count;
    u32 rem = (b == 0) ? 0u : (a % b);
    obj->cur = (u8)rem;
    return (rem == 0) ? 1u : 0u;
}

/* u_schd__reschedule (0x8e91fc, 108 Б): перевзвести шедулер после бикона.
 * invoke_callback (метод[1] очереди) → если изменился — слить истёкшие таймеры
 * и при необходимости перевзвести аппаратный таймер. */
__attribute__((section(".textlate"))) void u_schd_reschedule(u32 q)
{
    struct u_schd_tq *head = u_schd.tq[q];
    u32 r1;
    if (head->vt->time_base(head, 0) == head->now)
        return;
    u32 s = arc_irq_disable();
    for (;;) {
        if (head->list.count == 0) { r1 = 1u; break; }
        if (u_schd_pop_expired(q) == 0) { r1 = 0u; break; }
    }
    if (q == sched_hw_timer_queue || r1 == 0)
        u_schd_arm_timer();
    arc_irq_restore(s);
}

/* sched_builder__build_if_present (0x8ea86c): если собрано → build_allocations (сброс). */
__attribute__((section(".textlate"))) void sched_builder_build_if_present(struct sched_scheme *a)
{
    if (a->built != 0)
        schedule_scheme_builder_build_allocations(a);
}
