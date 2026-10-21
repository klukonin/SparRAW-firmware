// SPDX-License-Identifier: AGPL-3.0-or-later
/* Разное (область E), помощники fw_sysapi_mgr (объект 0x805170): занятость запроса,
 * планирование записи расписания, статистика MAC (снимок/дельта/журнал), нормировка пар
 * 64-битных измерений, журнал входного фильтра, колбэк lock-а при высоком false alarm.
 *
 * Сами команды fw_sysapi_mgr (start/stop_sysapi_cmd, send_evt2host) — sysapi_stats.c.
 * Счётчики MAC: [gp,0x24c] = 0x8003d0 — блок
 * RX, [gp,0x250] = 0x8003d4 — блок TX. */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/ut.h"
#include "../include/sysapi_mgr.h"
#include "../include/lmac_cmd.h"
#include "../include/fwdata.h"
#include "../include/mac_cnt.h"


/* Глобальные функции файла (вызываются портами fw_sysapi_mgr / UT). */


/* ---------------------------------------------------------------------------------- */
/* Копии функций других областей                                                      */
/* ---------------------------------------------------------------------------------- */

/* ---------------------------------------------------------------------------------- */
/* Запросы fw_sysapi_mgr                                                              */
/* ---------------------------------------------------------------------------------- */

/* bf_req__is_claimable (0x8f5cac, 36 Б) — по сути «запрос id идёт»: активен ([+0x18] != 0)
 * и не завершён ([+0x1c] == 0); id != 0 — ещё и [+0] == id. Результат — байт 0/1. */
u32 bf_req_is_claimable(struct fw_sysapi_mgr *req, u32 id)
{
    u32 r = (req->active != 0 && req->stopped == 0) ? 1u : 0u;
    if (id != 0)
        r = (r != 0 && id == req->request_type) ? 1u : 0u;
    return r;
}

/* sched__alloc_entry (0x8db5d8, 50 Б): LMAC-команда 0x42 (0xc Б): байты 0..4 тела =
 * (u8)p[0], p[1], p[4], p[2], p[3] (p — слова), слово +8 = tsf. Байты 5..7 не пишутся:
 * у vendor — остаток слота пула, у нас нули (mem_pool_alloc_locked обнуляет). */
void sched_alloc_entry(const u32 *p, u32 tsf)
{
    struct lmac_cmd_meas_filter *body = lmac_cmd_pool_alloc();
    body->cid = (u8)p[0];
    body->mode = (u8)p[1];
    body->mcs = (u8)p[2];
    body->rx_mode = (u8)p[3];
    body->count = tsf;
    body->no_mcs = (u8)p[4];
    lmac_if_post_cmd(body, 0x42, 0xc, 0);
}

/* (0x8f1e10, 6 Б): колбэк завершения запроса, который ставит sched__apply_entry в
 * req->completion_cb (vendor — число 0x31e10, младшее отображение; зовёт его
 * fw_sysapi_mgr::complete_pending_request 0x8f1c50 как cb(req, a, b)): req->status = a,
 * хвостом l2_mgr__high_false_alarm_secondary_lock_cb(req, b). В SYMS этих 6 байт нет
 * (хвост 0x8f1dc4). */
static void sched_apply_entry_done_cb(struct fw_sysapi_mgr *req, u32 a, const void *b)
{
    req->status = a;
    l2_mgr_high_false_alarm_secondary_lock_cb(req, b);
}

/* sched__apply_entry (0x8f1dc4, 74 Б): начать запрос (start_sysapi_cmd(req, 8, hdr = a2)),
 * колбэк завершения req->completion_cb = 0x8f1e10, по TSF старта (младшее слово) — LMAC-команда
 * 0x42 (sched__alloc_entry(a1, tsf)), хосту — 4 Б {tsf_lo} (send_evt2host, статус 1),
 * затем u16 req->ut.subtype = a3. Результат start_sysapi_cmd не проверяется (как у vendor). */
void sched_apply_entry(struct fw_sysapi_mgr *req, const u32 *a1, const u32 *a2, u32 a3)
{
    u32 tsf[2];
    u32 lo;

    fw_sysapi_mgr_start_sysapi_cmd(req, 8, a2);
    req->completion_cb = sched_apply_entry_done_cb;
    mac_read_tsf64(0, tsf, 0);
    sched_alloc_entry(a1, tsf[0]);
    lo = tsf[0];
    fw_sysapi_mgr_send_evt2host(req, 1, &lo, 4, (const u32 *)req->ut.w);
    req->ut.subtype = (u16)a3;
}

/* l2_mgr__high_false_alarm_secondary_lock_cb (0x8f3c9c, 74 Б): ответ LMAC на запрос
 * расписания — 16 Б res[0..3] копируются на стек, журнал 0x10131a0, хосту (send_evt2host,
 * статус req->status); res[0] == 1 — запрос завершён: stop_sysapi_cmd(req, 8). */
void l2_mgr_high_false_alarm_secondary_lock_cb(struct fw_sysapi_mgr *req, const u32 *res)
{
    u32 buf[4];

    buf[0] = res[0];
    buf[1] = res[1];
    buf[2] = res[2];
    buf[3] = res[3];
    fw_log_emit0(0x2b, 0x10131a0);
    fw_sysapi_mgr_send_evt2host(req, req->status, buf, 0x10, (const u32 *)req->ut.w);
    if (buf[0] == 1)
        fw_sysapi_mgr_stop_sysapi_cmd(req, 8);
}

/* ---------------------------------------------------------------------------------- */
/* Статистика MAC                                                                     */
/* ---------------------------------------------------------------------------------- */

/* stats__read_counter_by_id (0x8dd7b8, 240 Б; в SYMS ошибочно 44 Б — таблица переходов
 * 0x801b6c, 21 запись, JUMPTABLES-fw.txt): пара счётчиков блока RX id: *out =
 * crc_err_mcs[k], результат crc_err_mcs[k] + crc_ok_mcs[k] (блок перечитывается по
 * [gp,0x24c]). id 5, 9, 13..17 и > 20 — ассерт 0x125d, результат 0, *out не пишется.
 * Таблица — индекс k счётчика (у vendor — смещения 0x10 + 4·k в ветвях switch). */
u32 stats_read_counter_by_id(u32 id, u32 *out)
{
#define NO_CNT 0xffu
    static const u8 idx[21] = {
        0, 1, 2, 3, 4, NO_CNT, 5, 6, 7, NO_CNT, 8,
        9, 10, NO_CNT, NO_CNT, NO_CNT, NO_CNT, NO_CNT, 11, 12, 13,
    };
    u32 v, k;

    if (id > 0x14 || idx[id] == NO_CNT) {
        fw_sysassert_fatal(__builtin_return_address(0), 0x125d);
        return 0;
    }
    k = idx[id];
    v = mac_rx_cnt_blk->crc_err_mcs[k];
    *out = v;
    return v + mac_rx_cnt_blk->crc_ok_mcs[k];
#undef NO_CNT
}

/* stats__delta_since_baseline (0x8f64f4, 144 Б): out[0..9] — текущие счётчики минус базовые
 * fw_sysapi_mgr.mac_base (vendor — по абсолютному адресу 0x805170; снимок делает 0x8f6370):
 * u64 TX и u64 RX — 64-битное вычитание (sub.f/sbc), затем TX ok/fail (0x8dd758/0x8dd760),
 * RX +4 + +8, RX crc_err (0x8dd8a8), пара счётчиков id = req->ampdu_mcs (результат и *out).
 * Слот *out — 4 Б стека, обнулённый (push_s r0 = 0 в
 * слоте задержки первого вызова). */
void stats_delta_since_baseline(struct fw_sysapi_mgr *req, u32 *out)
{
    u32 tmp = 0;
    u64 v, base;

    v = mac_tx_cnt_get_u64_14();
    base = (u64)fw_sysapi_mgr.mac_base.tx_lo | ((u64)fw_sysapi_mgr.mac_base.tx_hi << 32);
    v -= base;
    out[0] = (u32)v;
    out[1] = (u32)(v >> 32);
    v = mac_rx_cnt_get_u64_bc();
    base = (u64)fw_sysapi_mgr.mac_base.rx_lo | ((u64)fw_sysapi_mgr.mac_base.rx_hi << 32);
    v -= base;
    out[2] = (u32)v;
    out[3] = (u32)(v >> 32);
    out[4] = mac_tx_cnt_get_ok() - fw_sysapi_mgr.mac_base.tx_ok;
    out[5] = mac_tx_cnt_get_fail() - fw_sysapi_mgr.mac_base.tx_fail;
    out[6] = mac_rx_cnt_get_crc_total() - fw_sysapi_mgr.mac_base.rx_crc_total;
    out[7] = mac_rx_stats_crc_err() - fw_sysapi_mgr.mac_base.rx_crc_err;
    out[8] = stats_read_counter_by_id(req->ampdu_mcs, &tmp) - fw_sysapi_mgr.mac_base.by_id;
    out[9] = tmp - fw_sysapi_mgr.mac_base.by_id_first;
}

/* stats__log_counters (0x8f62f8, 118 Б): дельты статистики (0x28 Б, буфер обнулён) —
 * четыре журнала (младшие слова u64 TX/RX; TX ok/fail; RX сумма/crc; id и пара счётчиков)
 * и хосту (send_evt2host, статус req->status). Зовёт mac_ampdu_statistics_timeout_cb
 * (0x8f6370 / 0x8f6406). */
void stats_log_counters(struct fw_sysapi_mgr *req)
{
    u32 d[10];

    memset0_words(d, 0x28);
    stats_delta_since_baseline(req, d);
    fw_log_emit2(0x20, 0x1012c74, d[0], d[2]);
    fw_log_emit2(0x20, 0x1012ca8, d[4], d[5]);
    fw_log_emit2(0x20, 0x1012cdc, d[6], d[7]);
    fw_log_emit3(0x20, 0x1012d10, req->ampdu_mcs, d[8], d[9]);
    fw_sysapi_mgr_send_evt2host(req, req->status, d, 0x28, (const u32 *)req->ut.w);
}

/* print_input_filter_params (0x8f7490, 52 Б): два журнала параметров входного фильтра —
 * байты p[0..2], затем p[3], p[4] и x. self (r0) не используется. */
void print_input_filter_params(struct fw_sysapi_mgr *self, const u8 *p, u32 x)
{
    (void)self;
    fw_log_emit3(0x20, 0x1012394, p[0], p[1], p[2]);
    fw_log_emit3(0x20, 0x10123e8, p[3], p[4], x);
}

/* ---------------------------------------------------------------------------------- */
/* Нормировка 64-битных измерений (fw_sysapi__send_measure_evt 0x8f8af8)              */
/* ---------------------------------------------------------------------------------- */

/* norm (ARC): число знаковых разрядов слева — для x >= 0 clz(x) − 1, для x < 0
 * clz(~x) − 1; norm(0) = norm(−1) = 31. */
static u32 arc_norm32(u32 x)
{
    u32 v = ((s32)x < 0) ? ~x : x;
    return v == 0 ? 31u : (u32)__builtin_clz(v) - 1u;
}

/* hwd__apply_table_entry_c (0x8f8f60, 58 Б): пара (a, b) u64 сдвигается вправо на s (сдвиг
 * 0x8c0430 — логический), чтобы b уложилось в 32 бита: s = 0 при b_hi == 0, иначе
 * 31 − norm(b_hi). out[0] = (u32)(a >> s), out[1] = (u32)(b >> s). ctx не используется. */
void hwd_apply_table_entry_c(struct fw_sysapi_mgr *ctx, u32 *out, u64 a, u64 b)
{
    u32 bh = (u32)(b >> 32);
    u32 s = 0;

    (void)ctx;
    if (bh != 0)
        s = 0x1f - arc_norm32(bh);
    out[0] = (u32)(a >> s);
    out[1] = (u32)(b >> s);
}

/* hwd__apply_table_entry (0x8f2e0c, 104 Б): out+0 — (*pb, *pa), out+0x10 — (*pd, *pc),
 * out+0x30 — (*pc − *pd, *pc) нормированными парами; out[0x38/0x3c] = *pa >> 3 (u64). */
void hwd_apply_table_entry(struct fw_sysapi_mgr *ctx, u32 *out, const u64 *pa, const u64 *pb,
                           const u64 *pc, const u64 *pd)
{
    u64 v;

    hwd_apply_table_entry_c(ctx, out, *pb, *pa);
    hwd_apply_table_entry_c(ctx, out + 0x10 / 4, *pd, *pc);
    hwd_apply_table_entry_c(ctx, out + 0x30 / 4, *pc - *pd, *pc);
    v = *pa >> 3;
    out[0x38 / 4] = (u32)v;
    out[0x3c / 4] = (u32)(v >> 32);
}

/* hwd__apply_table_entry_b (0x8f2e74, 106 Б): нормированные пары (32-битные входы
 * расширяются нулём): out+8 — (a2, a2 + a3 с переносом в старшее слово), out+0x18 — (a5, a4),
 * out+0x20 — (a7, a4), out+0x28 — (a5, a6). */
void hwd_apply_table_entry_b(struct fw_sysapi_mgr *ctx, u32 *out, u32 a2, u32 a3, u32 a4,
                             u32 a5, u32 a6, u32 a7)
{
    hwd_apply_table_entry_c(ctx, out + 8 / 4, (u64)a2, (u64)a2 + (u64)a3);
    hwd_apply_table_entry_c(ctx, out + 0x18 / 4, (u64)a5, (u64)a4);
    hwd_apply_table_entry_c(ctx, out + 0x20 / 4, (u64)a7, (u64)a4);
    hwd_apply_table_entry_c(ctx, out + 0x28 / 4, (u64)a5, (u64)a6);
}

/* 0x801b6c: таблица переходов switch vendor stats__read_counter_by_id (0x8dd7c8) (ldb.x [0x801b6c, индекс] → переход на
 * 0x8dd7d0 + 2·байт; JUMPTABLES-fw.txt). Наш switch компилирует gcc — таблица не
 * используется, байты — данные образа fw_data. */
FWDATA(801b6c) const u8 vendor_jt_stats_read_counter_by_id[21] = {
    0x00, 0x07, 0x0e, 0x15, 0x1c, 0x62, 0x23, 0x2a, 0x31, 0x62, 0x38, 0x3f,
    0x46, 0x62, 0x62, 0x62, 0x62, 0x62, 0x4d, 0x54, 0x5b,
};
