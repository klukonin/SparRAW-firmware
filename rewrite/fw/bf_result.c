// SPDX-License-Identifier: AGPL-3.0-or-later
/* Итоги BF (ABFT / RS done) → соединение, скан, find_sm, dashboard; LUT-поиск;
 * Вызываются из обработчиков событий ucode (lmac_evt.c). */
#include "../include/types.h"
#include "../include/conn.h"
#include "../include/mid.h"
#include "../include/lmac_cmd.h"
#include "../include/fwdata.h"
#include "../include/sysapi_mgr.h"



/* ======================= BF id соединения ======================= */

/* Пороги BF id (fw_data): число порогов, не превышающих значение → 20 + 20·i. */
/* 0x80103c: итог ABFT st 0 — прямо в BF id. */
FWDATA(80103c) const s32 bf_thr_abft_direct[4] = { -4, -2, 1, 17 };
/* 0x80104c: итог ABFT st 1 — через скользящее окно. */
FWDATA(80104c) const s32 bf_thr_abft_win[4] = { 2, 6, 10, 14 };
/* 0x80105c: MCS RS done — через скользящее окно. */
FWDATA(80105c) const s32 bf_thr_rs_mcs[4] = { 3, 6, 8, 10 };

/* conn__threshold_to_offset (0x8c7528, 30 Б): число порогов таблицы tbl[0..3]
 * (знаковое сравнение), не превышающих v → 20 + 20·i (u8). r0 на входе vendor
 * обнуляет — первый аргумент не используется. */
static u32 conn_threshold_to_offset(const s32 *tbl, s32 v)
{
    u32 i = 0;
    while (i < 4 && v >= tbl[i])
        i = (i + 1) & 0xff;
    return (i * 20 + 20) & 0xff;
}

/* Хвост 0x8c54d4/0x8c552c: BF id → bf_avg (add3 r,conn,0x30 = conn+0x180, +0xd),
 * счётчик [0x800010]++ ([gp,-372] / st.as [gp,-93]), копия в байт [0x800247] ([gp,195]).
 * vendor перечитывает bf_avg после записи — доступы volatile. */
static void conn_store_bf_id(struct conn *conn, u32 v)
{
    *(volatile u8 *)&conn->bf_avg = (u8)v;
    bf_id_update_count = bf_id_update_count + 1;
    bf_last_id = *(volatile u8 *)&conn->bf_avg;
}

/* conn__update_bf_id_on_rs_done (0x8c54b4, 56 Б): MCS RS done → порог по таблице
 * 0x80105c, в скользящее окно; среднее окна — BF id. */
void conn_update_bf_id_on_rs_done(struct conn *conn, u32 mcs)
{
    u32 v = conn_threshold_to_offset(bf_thr_rs_mcs, (s32)mcs);
    connection_cmp_bf_id(conn, v);
    conn_store_bf_id(conn, connection_bf_id_at_6c(conn));
}

/* connection__on_bf_result (0x8c54ec, 102 Б): итог ABFT (st = e[0x30], a2 = e[0]).
 * st 0 — порог по таблице 0x80103c прямо в BF id (окно не трогается); st 1 — порог
 * по 0x80104c через окно; st 2 — в окно 0; st ≥ 3 — ассерт 0x11c1, далее как 2. */
void connection_on_bf_result(struct conn *conn, u32 st, u32 a2)
{
    u32 v = 0;
    if (st == 0)
        v = conn_threshold_to_offset(bf_thr_abft_direct, (s32)a2);
    else if (st == 1)
        v = conn_threshold_to_offset(bf_thr_abft_win, (s32)a2);
    if (st >= 3)
        fw_sysassert_fatal((void *)__builtin_return_address(0), 0x11c1);
    if (st != 0) {
        connection_cmp_bf_id(conn, v);
        v = connection_bf_id_at_6c(conn);
    }
    conn_store_bf_id(conn, v);
}

/* ======================= ABFT → find_sm / scan ======================= */

/* scan_mngr::handle_abft_bf_result_in_scan (0x8f3a8c, 224 Б): итог ABFT при
 * пребывании на канале. Пир e[0x34..0x39] уже в кандидатах (pend) — обновить
 * сектор/тип; уже в scanned — ничего; иначе при < 8 кандидатов новая запись
 * (статус ABFT) в кандидаты и задача scan_mngr::connect (vendor передаёт 0x395bc).
 * e — событие LMAC новой связи. */
void scan_mngr_handle_abft_bf_result_in_scan(struct scan_mngr *s, const struct lmac_evt_bf_done *e)
{
    struct { u32 lo; u16 hi; u16 pad; } key;
    struct dband_info *x;

    key.lo = e->peer_lo;
    key.hi = e->peer_hi;
    fw_log_emit0(0x29, 0x1015aa8);
    x = find_main_sm_bcon_step(&s->pend, (const u8 *)&key);
    if (x != 0) {
        x->bf_sector = e->tx_sector_b1;
        x->bf_time = e->snr;
        x->bf_kind = (u8)e->type;
        return;
    }
    if (find_main_sm_bcon_step(&s->scanned, (const u8 *)&key) != 0)
        return;
    if (s->pend.count >= 8) {
        fw_log_emit0(0x19, 0x1015ad4);
        return;
    }
    x = alloc_dband_info();
    if (x == 0) {
        fw_log_emit0(0x19, 0x1015b44);
        return;
    }
    x->bssid_lo = key.lo;
    x->bssid_hi = key.hi;
    x->bf_sector = e->tx_sector_b1;
    x->bf_time = e->snr;
    x->bf_kind = (u8)e->type;
    x->status = DBAND_ST_ABFT;
    x->conn = 0;
    x->rx_omni = s->rx_omni;
    list_find_entry_d(&s->pend, x);
    fw_log_emit2(0x29, 0x1015b8c, x->bssid_hi, x->bssid_lo);
    fw_log_emit1(0x29, 0x1015a1c, (u32)x->list);
    u_schd_add(scan_mngr_connect_task, (u32)s, (u32)x, 1);
}

/* ======================= dashboard ======================= */

/* (0x8ea9d0, 2 Б): пустое тело (j_s [blink]) — в 6.2 dashboard ничего не копит. */
static void dashboard_bf_results_store(u32 cid, u32 v)
{
    (void)cid;
    (void)v;
}

/* dashboard__bf_results (0x8eab44, 68 Б): «ABFT BF results received for already
 * removed» при conn == 0 (уровень 0x25 при st 2, иначе 0x15); cid ≥ 8 — журнал. */
void dashboard_bf_results(const struct lmac_evt_bf_done *e, struct conn *conn)
{
    if (conn == 0) {
        if (e->type == 2)
            fw_log_emit0(0x25, 0x1018094);
        else
            fw_log_emit0(0x15, 0x10180d8);
        return;
    }
    u32 cid = conn->cid;
    if ((s32)cid >= (s32)SPARRAW_MAX_STA) {
        fw_log_emit1(0x15, 0x1018110, cid);
        return;
    }
    if (e->status == 1)
        dashboard_bf_results_store(cid, e->fail_reasons);
}

/* ======================= Extended Schedule бикона ======================= */

/* ba_sm__lookup_stream (0x8eaad8, 86 Б): в IE Extended Schedule (eid 0x90) сдвинуть
 * Allocation Start (LE u32 по +6 каждого 15-байтного поля распределения) на BI (мкс)
 * и пересобрать бикон (add_bcon([p+0x10])). Число полей — ie[1] / 15 (знаковое). */
static void ba_sm_lookup_stream(struct sched_scheme *p, u8 *ie)
{
    u32 bi = mac_get_beacon_interval_us();
    u32 n = (u8)fw_divmod_signed(ie[1], 0xf);
    u8 *a = ie + 2;
    for (; (s32)n > 0; n--) {
        u32 v = a[6] | ((u32)a[7] << 8) | ((u32)a[8] << 16) | ((u32)a[9] << 24);
        v += bi;
        a[6] = (u8)v;
        a[7] = (u8)(v >> 8);
        a[8] = (u8)(v >> 16);
        a[9] = (u8)(v >> 24);
        a += 0xf;
    }
    add_bcon(p->mid);
}

/* mid__lookup_at_48 (0x8eaab0, 38 Б): блок IE бикона app_ie MID (объект mid+0x48,
 * подтип 8 → +0x1e0) — при наличии Extended Schedule сдвиг на BI ([mid+0x290]).
 * Возврат vendor — мусор r0 (0 / результат add_bcon), вызывающие его не читают. */
u32 mid_lookup_at_48(struct mid *mid)
{
    u8 *ie = app_ie_find_by_eid(mid_get_bcon_additional_ies(&mid->bss, 8), 0x90);
    if (ie == 0)
        return 0;
    ba_sm_lookup_stream(mid->sched, ie);                /* ld.as r0,[r13,164] */
    return 0;
}

/* ======================= LUT ======================= */

/* lut__find_index__2 (0x8ca7f8, 260 Б): индекс ближайшего к x ключа в отсортированном
 * массиве lut[0] (знаковые s32, lut[8] штук): края — сразу; иначе бисекция не более
 * 5·n шагов, точное совпадение — его индекс, на последней паре — ближайший (равное
 * расстояние → верхний). Ассерты 0x1443 (x вне [lo,hi]), 0x1444 (mid = 0),
 * 0x1446 (шаги кончились → lo). */
static u32 lut_find_index_bsearch(const struct sysapi_lut *lut, s32 x)
{
    const s32 *k = lut->keys;
    u32 n = lut->n;
    u32 lo = 0, hi, mid, it, lim;

    if (!(k[0] < x))
        return 0;
    hi = n - 1;
    if (x >= k[hi])
        return hi;
    lim = n * 5;
    it = 0;
    while (it < lim) {
        it++;
        if (!(k[lo] <= x && x <= k[hi])) {
            fw_log_emit3(0, 0x1013254, (u32)x, (u32)k[lo], (u32)k[hi]);
            fw_log_emit2(0, 0x1013288, lo, hi);
            fw_sysassert_fatal((void *)__builtin_return_address(0), 0x1443);
        }
        if (hi - lo < 2) {
            k = lut->keys;
            return (x - k[lo] < k[hi] - x) ? lo : hi;
        }
        mid = (hi + lo) >> 1;
        if (mid == 0) {
            fw_log_emit3(0, 0x10132b4, lo, hi, (u32)x);
            fw_sysassert_fatal((void *)__builtin_return_address(0), 0x1444);
        }
        k = lut->keys;
        if (k[mid] == x)
            return mid;
        if (x < k[mid])
            hi = mid;
        else
            lo = mid;
    }
    fw_log_emit2(0, 0x10132f8, it, lut->n);
    fw_sysassert_fatal((void *)__builtin_return_address(0), 0x1446);
    return lo;
}

/* lut__find_index (0x8c74e8, 62 Б): значение lut[4][индекс ключа]; не
 * инициализированная LUT (lut[0] или lut[4] = 0) — журнал, ассерт 0x1512, вернуть key. */
u32 lut_find_index(const struct sysapi_lut *lut, u32 key)
{
    if (lut->keys == 0 || lut->vals == 0) {
        fw_log_emit0(0, 0x101321c);
        fw_sysassert_fatal((void *)__builtin_return_address(0), 0x1512);
        return key;
    }
    u32 i = lut_find_index_bsearch(lut, (s32)key);
    return lut->vals[i];
}

