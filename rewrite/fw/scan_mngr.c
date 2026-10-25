// SPDX-License-Identifier: AGPL-3.0-or-later
/* Приём биконов: scan_mngr__dband_beacon_ind (0x8c7f9c) + MID-helper'ы. */
#include "../include/types.h"
#include "../include/sched_scheme.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/mbox.h"
#include "../include/conn.h"
#include "../include/link_sm.h"
#include "../include/mid.h"
#include "../include/scan_mngr.h"
#include "../include/ieee80211.h"
#include "../include/sys_cfg.h"
#include "../include/fwdata.h"

FWDATA(800338) struct scan_peer *volatile conn_multi_omni_target = 0;   /* include/scan_mngr.h */


/* mids__get_count (0x8cc484, 12 Б): [gp,213] — число MID. */
__attribute__((section(".textlate"))) u8 mids_get_count(void)
{
    return mid_open_bitmap;
}

/* mid__copy_ssid (0x8ccc98, 28 Б): скопировать SSID объекта BSS записи mid в dst, вернуть
 * длину. */
__attribute__((section(".textlate"))) u32 mid_copy_ssid(const struct mid_bss *b, void *dst)
{
    u32 len = b->ssid_len;
    if (len != 0)
        memcpy_fw(dst, b->ssid, len);
    return len;
}

/* ring__is_full_8db1ec (0x8df49c, 16 Б): пул буферов кольца tx ящика исчерпан
 * (занято pool.used >= count). */
__attribute__((section(".textlate"))) u32 ring_is_full(const struct fw_mailbox *mb)
{
    const struct mem_pool *q = mb->tx.pool;
    u32 read = q->used;
    u32 write = q->count;
    return (read >= write) ? 1u : 0u;
}

/* lmac_mbox__is_full (0x8db948, 24 Б): полон ли ящик ucode lmac_mbox. */
__attribute__((section(".textlate"))) u32 lmac_mbox_is_full(void)
{
    return ring_is_full(&lmac_mbox.mb);
}


/* alloc_dband_info (0x8f0cf8, 48 Б): выделить dband-info (0x4c Б) из пула + очистить. */
__attribute__((section(".textlate"))) struct dband_info *alloc_dband_info(void)
{
    fw_log_emit0(0x2d, 0x1016f70);
    struct dband_info *p = mem_pool_allocate(&dband_info_pool);
    if (p != 0)
        memset0_words(p, sizeof(*p));
    return p;
}


/* memcmp_fw (0x8ddf4c, 56 Б): побайтовое сравнение, 0 = совпали. */
__attribute__((section(".textlate"))) int memcmp_fw(const u8 *a, const u8 *b, u32 len)
{
    u32 i;
    for (i = 0; i < len; i++)
        if (a[i] != b[i]) return 1;
    return 0;
}

/* mid_list__by_mid_fw (0x8cc3dc, 56 Б): запись mid с номером mid в mid_list или 0. */
__attribute__((section(".textlate"))) struct mid *mid_list_by_mid_fw(u32 mid)
{
    u32 it;
    iter_init(&it, &mid_list);
    while (list_has_items(&it)) {
        struct mid *e = iter_next(&it);
        if (e->id == mid) return e;                 /* vendor: breq r14 — слово целиком */
    }
    return 0;
}

/* mid_list__find_by_kind (0x8cc424, 96 Б): соединение записи mid по состоянию MLME:
 * kind 0 — ASSOCIATE (1), 1 — ASSOCIATED (2), 2 — идёт обмен Assoc или ASSOCIATED. */
__attribute__((section(".textlate"))) struct conn *mid_list_find_by_kind(struct mid *obj, u32 kind)
{
    u32 it;
    iter_init(&it, &obj->conns);
    while (list_has_items(&it)) {
        struct conn *e = (struct conn *)iter_next(&it);
        if (kind == 0) {
            if (e->mlme.sm.state == 1) return e;
        } else if (kind == 1) {
            if (e->mlme.sm.state == 2) return e;
        } else if (kind == 2) {
            if (e->mlme.busy != 0) return e;
            if (e->mlme.sm.state == 2) return e;
        } else {
            return 0;
        }
    }
    return 0;
}

/* mid_list__find_by (0x8cc024, 72 Б): соединение записи mid с MAC пира key. */
__attribute__((section(".textlate"))) struct conn *mid_list_find_by(struct mid *obj, const void *key)
{
    u32 it;
    iter_init(&it, &obj->conns);
    while (list_has_items(&it)) {
        struct conn *e = (struct conn *)iter_next(&it);
        if (memcmp_fw(e->peer, key, 6) == 0) return e;
    }
    return 0;
}

/* find_main_sm__bcon_step (0x8f8574, 96 Б): dband-инфо списка list с BSSID key или 0. */
__attribute__((section(".textlate"))) struct dband_info *find_main_sm_bcon_step(const struct llist *list,
                                                                              const u8 *key)
{
    u32 it;
    iter_init(&it, list);
    while (list_has_items(&it)) {
        struct dband_info *e = iter_next(&it);
        u32 i, ok = 1;
        for (i = 0; i < 6; i++)
            if (key[i] != e->bssid[i]) { ok = 0; break; }
        if (ok) return e;
    }
    return 0;
}

/* hexdump_words (0x8c9790, 124 Б): дамп буфера словами (12 байт/строку, big-endian). */
__attribute__((section(".textlate"))) void hexdump_words(const void *ptr, u32 len)
{
    u32 i;
    fw_log_emit1(0x20, 0x1001278, len);
    for (i = 0; i < len; i += 12) {
        const u8 *p = i + (const u8 *)ptr;
        fw_log_emit3(0x20, 0x1001284,
                     ((u32)p[0] << 24) | ((u32)p[1] << 16) | ((u32)p[2] << 8) | (u32)p[3],
                     ((u32)p[4] << 24) | ((u32)p[5] << 16) | ((u32)p[6] << 8) | (u32)p[7],
                     ((u32)p[8] << 24) | ((u32)p[9] << 16) | ((u32)p[10] << 8) | (u32)p[11]);
    }
}

/* ======================= активная проба найденного BSS ======================= */


/* probe_req tx-колбэк (0x8f7aa8, 60 Б): кадр отправлен — при status и a2 счётчик
 * mgmt_stats.probe_req_tx_ok (0x843160), освободить payload. */
void scan_mngr_probe_req_tx_done_cb(u32 payload, u32 status, u32 a2)
{
    fw_log_emit1(0x2c, 0x1016f30, status);
    if (status != 0 && a2 != 0)
        mgmt_stats.probe_req_tx_ok += 1;
    if (payload != 0)
        TX_API_free_memory(payload);
}

/* scan_mngr::prob_timeout_cb (0x8f7670, 104 Б): ответа на пробу нет — снять счётчик
 * проб active_probs и закончить пробу (причина 3). Таймер u_schd: a0 — scan_mngr,
 * a1 — dband-инфо. */
void scan_mngr_prob_timeout_cb(u32 a0, u32 a1)
{
    struct scan_mngr *scan = (struct scan_mngr *)a0;
    struct dband_info *e = (struct dband_info *)a1;
    fw_log_emit2(0x29, 0x101649c, (u32)scan, (u32)e);
    if (e == 0)
        fw_sysassert_fatal((void *)0, 0x1440);
    fw_log_emit2(0x29, 0x10164d8, scan->active_probs, e->probe_tmr);
    e->probe_tmr = 0;
    scan->active_probs = (u8)(scan->active_probs - 1);
    fw_log_emit2(0x29, 0x101650c, e->bssid_hi, e->bssid_lo);
    scan_mngr_prob_done(scan, 3, e);
}

/* scan_mngr__send_prob_req (0x8f8bcc, 190 Б): проба BSS e (dband-инфо): если проба ещё
 * не идёт (e->probe_tmr — таймер ответа) — статус PROBING, таймер [0x8004e8] (0x8f7670),
 * probe request на BSSID / SSID e через соединение e->conn, active_probs++. Нет payload —
 * ассерт 0x124d (vendor продолжает с 0).
 * Прежний порт: проверял e[0x30] вместо [e+0x48], колбэки — ловушка и число 0x8f7aa8. */
__attribute__((section(".textlate"))) void scan_mngr_send_prob_req(struct scan_mngr *scan,
                                                                   struct dband_info *e)
{
    struct tx_probe_param sp;
    sp.ra = e->conn->peer;
    fw_log_emit2(0x29, 0x1015748, e->bssid_hi, e->bssid_lo);
    sp.bssid = (const u8 *)e->bssid;
    sp.channel = 1;
    sp.ssid = (const u8 *)e->ssid;
    sp.ssid_len = e->ssid_len;
    if (e->probe_tmr != 0)
        return;
    e->status = DBAND_ST_PROBING;
    u32 t = u_schd_schedule(scan_mngr_prob_timeout_cb, (u32)scan, (u32)e, 1,
                            scan_probe_timeout_us, 0, 0);
    e->probe_tmr = t;
    fw_log_emit2(0x29, 0x1015778, t, (u32)e);
    u32 payload = TX_API_alloc_tx_payload();
    if (payload == 0)
        fw_sysassert_fatal((void *)0, 0x124d);
    tx_probe_send_probe_req(payload, scan->mid, e->conn, &sp,
                            scan_mngr_probe_req_tx_done_cb);
    scan->active_probs = (u8)(scan->active_probs + 1);
    fw_log_emit1(0x29, 0x10157cc, scan->active_probs);
}

/* ---------------- захват связи с BSS (запись соединения mid) ---------------- */


/* tx_bcon__inject_evt4 (0x8dffb8, 42 Б): бикон e — событие 4 автомату lm_sm и событие 1
 * его maintain_sm. */
__attribute__((section(".textlate"))) void tx_bcon_inject_evt4(struct lm_sm *l, u32 e)
{
    lm_sm_event(l, 4, e, 0, 0);
    maintain_sm_event(&l->msm, 1, e, 0, 0);
}

/* conn__snapshot_step (0x8c28d0, 50 Б): копия dband-инфо e (0x44 Б) в снимок lm_if, время
 * снимка, событие биконов автомату lm_sm (если есть). На FPGA — ничего. Подменяет
 * weak-заглушку lmac_evt.c. */
__attribute__((section(".textlate"))) void conn_snapshot_step(struct lm_if *lm, const void *e)
{
    if (platform_is_fpga() != 0)
        return;
    memcpy_fw(&lm->snap, e, 0x44);
    lm->snap_time = u_schd_now();
    if (lm->lm_sm != 0)
        tx_bcon_inject_evt4(lm->lm_sm, (u32)e);   /* аргумент события автомата — u32 */
}

/* conn_mgr__find_reusable_cid (0x8c656c, 140 Б): нет свободной записи соединения —
 * освободить первое соединение ранжированного списка в состоянии conn_main_sm < 4 без
 * кадра хоста (sw_tx_busy): элемент списка — в пул rank_pool, link_down. 1 — освобождено.
 * Пустой элемент — ассерт 0x10d2 (vendor идёт дальше). */
__attribute__((section(".textlate"))) u32 conn_mgr_find_reusable_cid(void)
{
    u32 it;
    iter_init(&it, &conn_mgr.rank_list);
    while (list_has_items(&it)) {
        struct conn_rank *el = (struct conn_rank *)iter_next(&it);
        struct conn *conn = el->conn;
        if (conn == 0)
            fw_sysassert_fatal(0, 0x10d2);
        if (el->conn->msm.sm.state < 4 && conn->sw_tx_busy == 0) {
            fw_log_emit2(0x2b, 0x100bd68, conn->cid, el->conn->msm.sm.state);
            tx_list_remove(&conn_mgr.rank_list, el);
            el->conn = 0;
            stream_mgr_check_vring(&conn_mgr.rank_pool, el);
            conn_mgr_link_down_evt(conn);
            return 1;
        }
    }
    fw_log_emit0(0x1b, 0x100bd48);
    return 0;
}

/* conn_mgr__alloc_cid (0x8c3290, 72 Б): запись соединения из пула conn_pool (8 × 0x1a0);
 * пул полон — освободить переиспользуемое соединение. Нет — 0 (ассерт 0x11ca vendor
 * ставит на ветку «пул не полон», т. е. недостижимую — как есть). Поля пула vendor
 * перечитывает после вызова — volatile. */
__attribute__((section(".textlate"))) struct conn *conn_mgr_alloc_cid(void)
{
    volatile struct mem_pool *pool = &conn_mgr.conn_pool;
    if (pool->used >= pool->count && conn_mgr_find_reusable_cid() == 0) {
        if (pool->used < pool->count)
            fw_sysassert_fatal(0, 0x11ca);
        return 0;
    }
    return mem_pool_allocate(&conn_mgr.conn_pool);
}

/* mid__link_acquis_step (0x8e6558, 62 Б): RX-сектор связи conn из лучшего ответа на пробу
 * (peer_info_array scan_mngr записи mid по текущему каналу): rx_sector = сектор, bcon_time —
 * время бикона; нет ответа — rx_sector = 0xffff и сектор 0. */
__attribute__((section(".textlate"))) void mid_link_acquis_step(struct conn *conn)
{
    u32 ch, s = 0;
    struct scan_peer *peer;
    radio_mgr_get_current_channel(&ch);
    peer = l2_mgr_connect_next(conn->mid->disc.scan, conn->peer, ch);
    if (peer == 0) {
        conn->rx_sector = 0xffff;
    } else {
        conn->bcon_time = peer->bcon_time;
        s = peer->rx_omni;
        conn->rx_sector = (u16)s;
    }
    hw_sysapi_rx_omni_sector_set(s);
}

/* mid__link_acquisition_action (0x8da928, 356 Б; имя порта — как у weak-заглушки
 * lmac_evt.c): соединение mid с BSSID key. Свой адрес — отказ (0). Есть — обновить
 * (сектор a7 ≠ 0xffff, шаг a6, [+0x24] = a3, [+0x2c] = a5) и find_sm__start_listen;
 * нет — новое (conn_mgr__alloc_cid, connection__init, снимок dband-инфо e, в список
 * mid+0x18, cid в битовую карту [mid+0x24]). *out — запись соединения. */
__attribute__((section(".textlate"))) u32 find_main_sm_bcon_lookup(struct mid *mid, const void *key, const void *e,
                                                                   u32 a3,
                                                                   struct conn **out,
                                                                   u32 a5, u32 a6, u32 a7)
{
    struct conn *conn;
    u32 cid;
    fw_log_emit2(0x2b, 0x100ca58, ((const union mac_addr *)key)->h[2], mac_lo32((const union mac_addr *)key));
    if (memcmp_fw(key, mid->mac, 6) == 0) {
        fw_log_emit0(0x1b, 0x100ca9c);
        return 0;
    }
    conn = mid_list_find_by(mid, key);
    *out = conn;
    if (conn != 0) {
        fw_log_emit2(0x2b, 0x100cae4, conn->cid, conn->msm.sm.state);
        if ((a7 & 0xffffu) != 0xffffu)
            (*out)->rx_sector = (u16)a7;
        if (a6 != 0)
            mid_link_acquis_step(*out);
        (*out)->initiator = a3;
        (*out)->skip_bf = a5;
        find_sm_start_listen(*out, (*out)->cid);
        return 1;
    }
    fw_log_emit1(0x2b, 0x100cb3c, a3);
    conn = conn_mgr_alloc_cid();
    *out = conn;
    if (conn == 0) {
        fw_log_emit0(0xb, 0x100cbd0);
        return 0;
    }
    connection_init(conn, key, mid);
    if (e != 0) {
        conn_snapshot_step(&(*out)->lm, e);
        (*out)->rx_sector = ((const struct conn_bf_snap *)e)->rx_sector;   /* e — снимок BF (0x44 Б) */
    }
    if ((a7 & 0xffffu) != 0xffffu)
        (*out)->rx_sector = (u16)a7;
    if (a6 != 0)
        mid_link_acquis_step(*out);
    (*out)->initiator = a3;
    (*out)->skip_bf = a5;
    list_find_entry_d((u32 *)&mid->conns, (u32 *)*out);
    fw_log_emit2(0x2b, 0x100cb74, ((const union mac_addr *)key)->h[2], mac_lo32((const union mac_addr *)key));
    cid = conn_mgr_activate_conn(*out, 1);
    mid->cid_mask |= (u8)(1u << cid);
    return 1;
}

/* mid__link_acquisition (0x8da8fc, 42 Б): mid__link_acquisition_action(mid, key, e, 0,
 * &conn, a3, 0, a4) — запись соединения или 0. */
__attribute__((section(".textlate"))) struct conn *mid_link_acquisition(struct mid *mid, const void *key, const void *e, u32 a3,
                                                               u32 a4)
{
    struct conn *conn = 0;
    if (find_main_sm_bcon_lookup(mid, key, e, 0, &conn, a3, 0, a4) == 0)
        return 0;
    return conn;
}

/* scan_mngr::connect (0x8f1f2c, 132 Б): соединение для пробы найденного BSS e (dband-
 * инфо). Повторная проба (bf_kind == 2, ABFT) — с прежним сектором: снимок события BF
 * {bf_time, bf_sector} и сектор вне 0xffff. Нет соединения — scan_mngr::prob_done(scan, 1,
 * e); есть — время в bcon_time. Канал читается, как у vendor, без использования. */
__attribute__((section(".textlate"))) void scan_mngr_connect(struct scan_mngr *scan,
                                                             struct dband_info *e)
{
    u32 snap[0x11];
    u32 ch;
    const void *e2 = 0;
    u32 f = 0;
    struct conn *conn;
    fw_log_emit2(0x29, 0x1016690, e->bssid_hi, e->bssid_lo);
    if (e->bf_kind == 2) {
        fw_log_emit0(0x29, 0x10166c8);
        f = 1;
        memset0_words(snap, sizeof(snap));   /* vendor: стековый мусор вне записанных полей */
        *(u8 *)((u32)snap + 6) = e->bf_sector;
        snap[0] = e->bf_time;
        e2 = snap;
    }
    radio_mgr_get_current_channel(&ch);
    conn = mid_link_acquisition(scan->mid, e->bssid, e2, f, scan->rx_omni);
    e->conn = conn;
    if (conn == 0)
        scan_mngr_prob_done(scan, 1, e);
    else
        conn->bcon_time = u_schd_now();
}

/* scan_mngr::connect task (0x8f95bc, 64 Б): a0 — scan_mngr, a1 — dband-инфо. */
void scan_mngr_connect_task(u32 a0, u32 a1)
{
    struct scan_mngr *scan = (struct scan_mngr *)a0;
    struct dband_info *e = (struct dband_info *)a1;
    if (e == 0)
        fw_sysassert_fatal((void *)0, 0x1441);
    fw_log_emit3(0x29, 0x10166f4, e->bssid_hi, e->bssid_lo, scan->active_probs);
    scan_mngr_connect(scan, e);
}

/* scan_mngr__dband_beacon_ind (0x8c7f9c, 584 Б): DMG-бикон во время пребывания на
 * канале (автомат каналов в DWELLING, dwell_stopped != 1). Новый BSS (нет ни в
 * кандидатах pend, ни в scanned; кандидатов < 8) — запись dband-инфо (BSSID,
 * RX-сектор, SSID профиля mid; own_bss — BSSID совпал с BSS соединения mid). a2 ≠ 0
 * (бикон чужого PCP/AP по флагу ei+0x84) — в dband-инфо, иначе в кандидаты и: ACS —
 * вернуть 1 (кадр хосту); соединение — проба; нет — задача scan_mngr::connect.
 * Остальное — 0 (кадр хосту не передаётся: BSS сообщается ответом на пробу).
 * Прежний порт: обратная проверка [scan+0x1e0], всегда 1, SSID из 0x800000. */
__attribute__((section(".textlate"))) u32 scan_mngr_dband_beacon_ind(struct scan_mngr *scan,
                                                                     struct rx_pkt *pkt, u32 a2)
{
    u32 it;
    u8 ssid[0x20];
    const union mac_addr *bssid = &pkt->hdr->addr1;
    u32 r23 = *pkt->ei->bi_ctrl >> 1;
    if (a2 != 0 && find_main_sm_bcon_step(&scan->scanned, bssid->b) != 0)
        return 0;
    if (scan->cs->hdr.state != CS_ST_DWELLING)
        return 0;
    if (scan->dwell_stopped == 1)
        return 0;
    field_set_0x00_8e5dfc(&it, mids_get_count());
    struct mid *m = 0;
    u32 own = 0;
    while (bit_iter_has_more(&it)) {
        m = mid_list_by_mid_fw(bitmap_alloc_bit(&it));
        if (m == 0)
            continue;
        if (mid_list_find_by_kind(m, 1) == 0)
            continue;
        if (memcmp_fw(m->bss.bssid, bssid->b, 6) != 0)
            continue;
        fw_log_emit3(0x29, 0x10157e8, mac_lo32(bssid), bssid->h[2], m->id);
        own = 1;
        break;
    }
    scan_stats.bcon_ind += 1;
    if (lmac_mbox_is_full() == 1) {
        fw_log_emit2(0x19, 0x1015848, mac_lo32(bssid), bssid->h[2]);
        return 0;
    }
    if (find_main_sm_bcon_step(&scan->pend, bssid->b) != 0)
        return 0;
    if (find_main_sm_bcon_step(&scan->scanned, bssid->b) != 0)
        return 0;
    if (scan->pend.count >= 8) {
        fw_log_emit0(0x19, 0x10158b0);
        return 0;
    }
    struct dband_info *e = alloc_dband_info();
    if (e == 0) {
        fw_log_emit0(0x19, 0x1015910);
        return 0;
    }
    memcpy_fw(e->bssid, bssid, 6);
    /* 0x8c80ec..0x8c8108: stb [+0x40], stb [+0x41], st [+0x44], st [+0x34], stb [+0x39] — по порядку;
     * volatile — иначе gcc сливает bf_kind и status в одну sth и переставляет записи */
    volatile struct dband_info *ve = e;
    ve->bf_kind = 3;
    ve->status = DBAND_ST_NEW;
    ve->conn = 0;
    ve->own_bss = own;
    ve->rx_omni = scan->rx_omni;
    /* vendor: m — последняя запись цикла (при пустой битовой карте 0 — SSID читается с
     * адреса 0x48 + …, как у vendor) */
    u32 len = mid_copy_ssid(&m->bss, ssid);
    e->ssid_len = (u8)len;
    /* 8c8116: extb_s r2,r0 (без знака) + brlt.d r2,1 — копировать при (u8)len ≠ 0, длина
     * копии — тот же байт. Прежде (s8)len ≥ 1 и полная длина. */
    if ((u8)len != 0)
        memcpy_fw(e->ssid, ssid, (u8)len);
    if (a2 != 0) {
        fw_log_emit2(0x29, 0x101594c, e->bssid_hi, e->bssid_lo);
        list_find_entry_d(&scan->scanned, e);
        return 0;
    }
    list_find_entry_d(&scan->pend, e);
    scan_stats.bss_added += 1;
    fw_log_emit3(0x29, 0x10159bc, e->bssid_hi, e->bssid_lo, r23 & 1);
    fw_log_emit1(0x29, 0x1015a1c, (u32)e->list);
    hexdump_words(pkt->hdr, pkt->info.len);
    if (scan->scan_type == 2) {                             /* ACS: кадр хосту */
        fw_log_emit0(0x29, 0x1015a30);
        return 1;
    }
    if (own != 0) {
        e->conn = mid_list_find_by(m, bssid);
        scan_mngr_send_prob_req(scan, e);
    } else {
        fw_log_emit0(0x29, 0x1015a6c);
        u_schd_add(scan_mngr_connect_task, (u32)scan, (u32)e, 1);
    }
    return 0;
}


/* conn_main_sm__inject_bcon_rx (0x8c47e0, 36 Б): событие 1 (бикон, a1 = pkt) автомату
 * conn_main_sm с выключенным на время журналом переходов (trace = 0, затем 1). */
__attribute__((section(".textlate"))) void conn_main_sm_inject_bcon_rx(struct conn *conn, struct rx_pkt *pkt)
{
    struct conn_msm *sm = &conn->msm;
    sm->sm.trace = 0;
    conn_msm_event(sm, 1, 0, (u32)pkt, 0);
    sm->sm.trace = 1;
}


/* dmg_bcon__rx_handler (0x8c9404, 512 Б): DMG-бикон для объекта obj = e+0x234 записи mid
 * ([obj+4] — запись mid e, [obj+8] — scan_mngr, obj+0xc — find_mngr). Возвращает 1, если
 * кадр передать хосту. Поиск (find_mngr [obj+0x4c]) — detect_discovery_bcon; иначе скан:
 * dband_beacon_ind, если идёт discovery-скан, или e+0x48 в состоянии 2/3, или в
 * Beacon Interval Control (ei->bi_ctrl, байт 5) биты 3 / 4..5 (принудительно при бите 9
 * [0x803c20] или [0x803c0c]). a2 = бикон с другим битом 2 DMG Parameters (ei->dmg_params)
 * чем у нас (0x847ae1).
 * Затем бикон своего BSS (e+0x48 в состоянии 2, BSSID e+0x54): проверка окна времени
 * ([0x800338]: BI ×1000 + 2400 мкс на RX-сектор), расписание, событие соединению,
 * PS-событие 5, перевзвод u_schd.
 * Прежний порт: obj вместо scan_mngr для dband_beacon_ind, obj+4 вместо [obj+4] для
 * записи mid, без инверсии бита dmg_params, без [0x803c0c] и проверки окна. */
__attribute__((section(".textlate"))) u32 dmg_bcon_rx_handler(struct mid_disc *obj, struct rx_pkt *pkt)
{
    if (pkt->ei == 0)
        fw_sysassert_fatal(0, 0x1232);
    const struct rx_mgmt_ei *ei = pkt->ei;
    if (ei->bi_ctrl == 0) {
        fw_sysassert_fatal(0, 0x1233);
        ei = pkt->ei;
    }
    struct mid *e = obj->mid;
    struct mid_bss *lm = &e->bss;
    u8 fl = ei->bi_ctrl[5];
    /* PCP Association Ready, B43 (9.3.4.2); у AP (BSS Type 3) подполе зарезервировано — маяк AP годен всегда */
    u32 r1 = ((fl >> 3) & 1u) | (dmg_bss_type_is_ap(ei) ? 1u : 0u);
    u32 r2 = 0;                                     /* vendor: Reserved B44–B45 (свой флаг) как запасной признак */
    if (dashboard.cfg.special_flags & (1u << 9)) {
        r1 = 1;
        r2 = 1;
    }
    u32 other = 0;
    const u8 *p = ei->dmg_params;
    if (p != 0) {
        /* Маяк не свой только при включённом фиксированном расписании и CBAP Only = 1.
         * Vendor (0x8c9458..0x8c9464): «CBAP Only = 0 ⇔ фиксированное расписание» — маяк
         * точки с ESE (CBAP Only = 0, 802.11-2020 10.39.6.3) станция без фиксированного
         * расписания отбрасывала целиком: ни разбора ESE, ни BCON_RX, ни сторожа маяков. */
        u32 cbap_only = (*p >> 2) & 1u;
        other = (*(volatile u8 *)&fixed_sched.enabled != 0 && cbap_only != 0) ? 1u : 0u;
    }
    u32 r16;
    if (obj->find.active != 0) {
        r16 = find_mngr_detect_discovery_bcon(&obj->find, pkt);
    } else {
        struct scan_mngr *scan = obj->scan;
        u32 t = scan->scan_type;
        u32 go = (t == 0 || t == 3) && scan->discovery_mode == 1 && scan->active == 1;
        if (!go) {
            /* 0x8c94c8: состояние e+0x48 2/3 → 0x8c94f6 (r0 = 0, без dband_beacon_ind);
             * иначе — по битам DMG-параметров r1/r2. Прежде условие было обратным: при
             * состоянии 2/3 бикон уходил в dband (проба), а не хосту. */
            u32 st = lm->mode;
            go = !(st == 2 || st == 3) && (r1 != 0 || r2 != 0);
        }
        r16 = go ? scan_mngr_dband_beacon_ind(scan, pkt, other) : 0;
    }
    if (other != 0)
        return r16;
    if (lm->state != 2)
        return r16;
    if (memcmp_fw(e->bss.bssid, pkt->hdr->addr1.b, 6) != 0)
        return r16;
    struct scan_peer *tm = conn_multi_omni_target;
    if (tm != 0) {
        u32 now = u_schd_now();
        /* vendor: [+0xa] × 1000 + 2400 — поле rssi записи (у vendor по смыслу BI бикона) */
        u32 slot = tm->rssi * 1000 + 0x960;
        u32 period = conn_multi_omni_count * slot;
        u32 t0 = tm->bcon_time;
        u32 el = (now >= t0) ? (now - t0) << 4 : ((0xffffffffu - t0 + now) << 4) + 0x10;
        /* 0x8c02d4: остаток в r1. Делитель 0 у vendor — `j 0x64c` (вне образа), но он
         * недостижим: [0x800231] пишет только 0x8ece34 (`mov.le r0,1` — не меньше 1;
         * образ — 1), slot = BI × 1000 + 2400 ∈ [2400, 65537400] < 2^26, n ≤ 255 < 2^8;
         * n × slot ≡ 0 (mod 2^32) требует v2(n) + v2(slot) ≥ 32 при n × slot < 2^34, т. е.
         * n = 128 и slot = 2^25 (BI × 1000 = 33552032 — не делится на 1000) — невозможно. */
        u32 rem = el % period;
        if (rem < period - slot && rem > 0x7530) {
            fw_log_emit3(0x2b, 0x1016744, now, t0, rem);
            return r16;
        }
    }
    struct conn *conn = mid_list_find_by(obj->mid, &pkt->hdr->addr1);
    if (conn != 0) {
        ese_rx_on_own_beacon(pkt);              /* флаг «DTI расписан» для uc (fw/rx.c) */
        if (pkt->ei->ext_sched.body != 0)
            dmg_bcon_build_allocations(obj->mid, pkt);
        else if (VOL(ese_slot_tbl.mode) == 2)
            sched_builder_build_if_present(obj->mid->sched);
        conn_main_sm_inject_bcon_rx(conn, pkt);
        /* vendor: Awake Window пира (IE 0x9d) — PS-менеджеру; PS вырезан. */
    }
    u_schd_reschedule(obj->mid->id);
    return r16;
}
