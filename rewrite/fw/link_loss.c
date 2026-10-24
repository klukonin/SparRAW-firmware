// SPDX-License-Identifier: AGPL-3.0-or-later
/* Мониторинг потери линка соединения: периодические сервисы (база, struct psvc),
 * детекторы «необходимости keep-alive» (ka_necessity_detector, struct ll_ka_det) и
 * «старения TX PPDU» (tx_ppdu_ageing_timeout_detector, struct ll_ageing_det), детектор
 * плохих биконов (struct ll_bcn_det), обработчики conn_mgr для PS (перевзвод детекторов,
 * возобновление vring, событие BI), таймер повтора соединения.
 * Раскладка объектов, контекст поддержания линка ll_ctx (0x857064) и экземпляры
 * ll_detectors (0x854dd4) — include/link_loss.h. Таблицы методов детекторов — здесь
 * (vendor 0x80075c — keep-alive, 0x8008c4 — старение). */
#include "../include/types.h"
#include "../include/power.h"
#include "../include/fwdata.h"
#include "../include/vring_schd.h"
#include "../include/conn.h"
#include "../include/link_loss.h"
#include "../include/sys_cfg.h"


/* [gp,0x240] = 0x8003c4: интервал журнала состояния детекторов (TSF, мкс). */
#define DET_LOG_INTERVAL  (link_det_log_interval)

/* Детекторы и контекст vendor перечитывает при каждом обращении (между вызовами и
 * записями в контекст) — доступ к ним здесь через volatile, как прежде D8/D32. */
#define VCTX(d)  ((volatile struct ll_ctx *)(d)->ctx)
#define LLC      ((volatile struct ll_ctx *)&ll_ctx)

/* ======================= периодический сервис (база) ======================= */


/* periodic_service__timer_expired (0x8c5b8c, 44 Б): колбэк u_schd таймера сервиса —
 * объект 0 — ассерт 0x1438 (vendor идёт дальше); задача снята — прогон (vt->run). */
void periodic_service_timer_expired(u32 a0, u32 a1)
{
    volatile struct psvc *o = (struct psvc *)a0;
    (void)a1;
    if (o == 0)
        fw_sysassert_fatal(__builtin_return_address(0), 0x1438);
    (void)u_schd_now();
    o->timer = 0;
    o->vt->run((struct psvc *)o);
}

/* periodic_service__tick (0x8e4828, 124 Б): завести таймер следующего прогона.
 * delay == 0xffffffff — вычислить: период минус прошедшее с конца прошлого прогона
 * (run_end; при «догонять» и прогоне короче периода — от начала, run_start); времени
 * u_schd — в тиках, период — в тиках << 4. Меньше 0x11 — прогон сразу. Возврат — задача. */
u32 periodic_service_tick(struct psvc *svc, u32 delay)
{
    volatile struct psvc *o = svc;
    u32 start, ref;
    s32 d;
    (void)u_schd_now();
    if (o->stopped != 0)
        return 0;
    start = o->run_start;
    ref = o->run_end;
    if (o->catch_up != 0 && ((ref - start) << 4) < o->period)
        ref = start;
    d = (s32)delay;
    if (delay == 0xffffffffu) {
        if (ref == 0xffffffffu)
            d = (s32)o->period;
        else
            d = (s32)(o->period - ((u_schd_now() - ref) << 4));
    }
    if (d < 0x11) {
        o->vt->run(svc);
    } else {
        timer_task_cancel(svc);
        o->timer = u_schd_schedule(periodic_service_timer_expired, (u32)svc, 0,
                                   o->timer_arg, (u32)d, 0, 0);
    }
    return o->timer;
}

/* periodic_service__start (0x8e77c4, 100 Б) — vt->start: снять таймер, снять
 * «остановлен» и запустить: 0 — прогон сразу, 1 — через период, 2 — через остаток
 * периода, 3 — прогон сразу и остановить; иное — ассерт 0x1439. */
void periodic_service_start(struct psvc *svc, u32 mode)
{
    volatile struct psvc *o = svc;
    (void)u_schd_now();
    timer_task_cancel(svc);
    o->stopped = 0;
    switch (mode) {
    case 0:
        o->vt->run(svc);
        break;
    case 1:
        periodic_service_tick(svc, o->period);
        break;
    case 2:
        periodic_service_tick(svc, 0xffffffffu);
        break;
    case 3:
        o->vt->run(svc);
        o->stopped = 1;
        break;
    default:
        fw_sysassert_fatal(__builtin_return_address(0), 0x1439);
        break;
    }
}

/* periodic_service__run (0x8cdc18, 104 Б) — vt->run: прогон — счётчик (насыщение:
 * ≥ 254 → 0), время начала, задача (vt->task с номером прогона), время и TSF конца,
 * следующий таймер. Остановленный сервис не прогоняется. */
void periodic_service_run(struct psvc *svc)
{
    volatile struct psvc *o = svc;
    u32 now = u_schd_now();
    u32 n;
    if (o->stopped != 0)
        return;
    n = o->runs;
    n = (n >= 254) ? 0 : n + 1;
    o->runs = (u8)n;
    if (o->run_start != 0xffffffffu)
        (void)u_schd_now();
    if (o->run_end != 0xffffffffu)
        (void)u_schd_now();
    o->run_start = now;
    o->vt->task(svc, o->runs);
    o->run_end = u_schd_now();
    mac_read_tsf64(0, svc->end_tsf, 0);
    periodic_service_tick(svc, 0xffffffffu);
}

/* ======================= общие проверки детекторов ======================= */

/* detector__deadline_is_unset (0x8da2ac, 28 Б): TSF конца прогона не задан. */
static u32 detector_deadline_is_unset(volatile struct psvc *d)
{
    return (d->end_tsf[0] == 0xffffffffu && d->end_tsf[1] == 0xffffffffu) ? 1 : 0;
}

/* Флаг cid в контексте: ctx->cfg[cid].flags бит b и детекторы не запрещены (cid и ctx —
 * поля детектора keep-alive или старения, у обоих +0x30/+0x34). */
static u32 detector_flag_enabled(volatile u8 *cid, struct ll_ctx *volatile *ctx, u32 bit,
                                 u32 code, void *ra)
{
    u32 f;
    if (*cid >= 8)
        fw_sysassert_fatal(ra, code);
    f = ((volatile struct ll_ctx *)*ctx)->cfg[*cid].flags;
    if (((f >> bit) & 1) == 0)
        return 0;
    return 1;                            /* OOB R1 (только SparRAW-pro): 0 */
}

/* ka_detector__is_enabled (0x8da214, 76 Б): привязан, бит 1 флагов cid, нет запрета;
 * cid ≥ 8 — ассерт 0x1546. */
u32 ka_detector_is_enabled(struct ll_ka_det *d)
{
    if (ll_detector_is_armed(d) == 0)
        return 0;
    return detector_flag_enabled(&d->cid, &d->ctx, 1, 0x1546, __builtin_return_address(0));
}

/* tx_ageing_detector__is_enabled (0x8da260, 76 Б): то же, бит 0; ассерт 0x1504. */
u32 tx_ageing_detector_is_enabled(struct ll_ageing_det *d)
{
    if (ll_detector_is_armed_b(d) == 0)
        return 0;
    return detector_flag_enabled(&d->cid, &d->ctx, 0, 0x1504, __builtin_return_address(0));
}

/* bad_beacons_detector__is_enabled (0x8da1cc, 72 Б): слот привязан, бит 2 флагов, нет
 * запрета; ассерт 0x1527. */
static u32 bad_beacons_detector_is_enabled(struct ll_bcn_det *det)
{
    volatile struct ll_bcn_det *o = det;
    u32 f;
    if (detector_slot_is_bound(det) == 0)
        return 0;
    if (o->cid >= 8)
        fw_sysassert_fatal(__builtin_return_address(0), 0x1527);
    f = o->ctx->cfg[o->cid].flags;
    if ((f & 4) == 0)
        return 0;
    return 1;                            /* OOB R1 (только SparRAW-pro): 0 */
}

/* arc_protect_addr (0x8c3b90, 70 Б): ARC action point idx на запись по addr (маска m). */
static void arc_protect_addr(u32 idx, u32 addr, u32 mask)
{
    struct arc_ap_cfg cfg;
    fw_log_emit3(0, 0x1000acc, idx, addr, mask);
    cfg.idx = idx;
    cfg.value = addr;
    cfg.mask = mask;
    cfg.target = 2;                     /* адрес ld/st */
    cfg.ttype = 1;                      /* запись */
    cfg.mode = 0;
    cfg.pair = 0;
    cfg.ac8 = 1;
    arc_action_point_arm(&cfg);
}

/* ======================= запуск мониторинга ======================= */

/* tx_ppdu_ageing_timeout_detector::start_monitoring (0x8e7bc4, 220 Б). Действие
 * detector__arm_timer (0x8e7e8c) по факту — останов (снять таймер, «остановлен»). */
void tx_ppdu_ageing_timeout_detector_start_monitoring(struct ll_ageing_det *det)
{
    volatile struct ll_ageing_det *d = det;
    struct ll_ctx *ctx;
    u32 cid, en;
    struct vring_schd_if *tbl;
    if (ll_detector_is_armed_b(det) == 0) {
        fw_log_emit0(0xb, 0x10147d4);
        return;
    }
    if (d->cid >= 8)
        fw_sysassert_fatal(__builtin_return_address(0), 0x1589);
    en = tx_ageing_detector_is_enabled(det);
    ctx = d->ctx;
    cid = d->cid;
    fw_log_emit3(0x2b, 0x101482c, cid, en, ((volatile struct ll_ctx *)ctx)->cfg[cid].period);
    fw_log_emit1(0x2b, 0x101489c, VCTX(d)->cfg[d->cid].ageing_thr);
    detector_arm_timer(&det->svc);
    peer_check_flag_30(det);
    tbl = vring_active_ring_table();
    tbl->vt->clear_time(tbl, d->cid);
    VCTX(d)->traffic[d->cid] = 0;
    VCTX(d)->act_140[d->cid] = 0;
    detector_init_common(&det->svc, VCTX(d)->cfg[d->cid].period,
                         0, 1, 5);
    if (en != 0)
        periodic_service_start(&det->svc, 0);
    arc_protect_addr(0, (u32)&det->cid, 3);
}

/* ka_necessity_detector::start_monitoring (0x8e7af0, 210 Б). */
void ka_necessity_detector_start_monitoring(struct ll_ka_det *det)
{
    volatile struct ll_ka_det *d = det;
    volatile struct ll_cid_cfg *e;
    struct ll_ctx *ctx;
    u32 cid, en, p;
    if (ll_detector_is_armed(det) == 0) {
        fw_log_emit0(0xb, 0x1014ac4);
        return;
    }
    if (d->cid >= 8)
        fw_sysassert_fatal(__builtin_return_address(0), 0x1547);
    en = ka_detector_is_enabled(det);
    ctx = d->ctx;
    cid = d->cid;
    fw_log_emit3(0x2b, 0x1014b10, cid, en, ((volatile struct ll_ctx *)ctx)->cfg[cid].period);
    e = &d->ctx->cfg[d->cid];
    fw_log_emit2(0x2b, 0x1014b74, (u32)e->snr_lo, (u32)e->snr_hi);
    p = VCTX(d)->cfg[d->cid].ka_period_lo;
    fw_log_emit2(0x2b, 0x1014ba8, p, p);
    detector_arm_timer(&det->svc);
    ka_check_peer_state(det);
    VCTX(d)->ka_cnt[d->cid] = 0;
    detector_init_common(&det->svc, VCTX(d)->cfg[d->cid].period,
                         0, 1, 5);
    if (en != 0)
        periodic_service_start(&det->svc, 0);
}

/* bad_beacons_detector__arm (0x8e7adc, 18 Б): обнулить счётчик и включить. */
void bad_beacons_detector_arm(struct ll_bcn_det *o)
{
    bad_beacons_check_counter(o);
    ((volatile struct ll_bcn_det *)o)->armed = 1;
}

/* lm_if::start_link_loss_monitoring (0x8e7a7c → 0x8e7a84 с lm_if соединения, 76 Б):
 * журнал cid / наличия объекта мониторинга и запуск трёх детекторов. */
void conn_mgr_start_link_loss_monitoring(struct conn *conn)
{
    struct lm_if *lm = &conn->lm;
    struct ll_detectors *m = lm->detectors;
    fw_log_emit2(0x2b, 0x1014338, conn_get_cid(lm), m != 0);
    if (lm->detectors != 0)
        tx_ppdu_ageing_timeout_detector_start_monitoring(&lm->detectors->ageing);
    if (lm->detectors != 0)
        ka_necessity_detector_start_monitoring(&lm->detectors->ka);
    if (lm->detectors != 0)
        bad_beacons_detector_arm(&lm->detectors->bcn);
}

/* ======================= задачи детекторов ======================= */

/* ps__sta_has_pending_data (0x8ccf0c, 88 Б): у cid есть данные — в кольце хоста (метод
 * +0x24 планировщика vring даёт кольцо, 0xff — нет), или биты cid в ll_ctx.pending_mask
 * (0x8571c4) / fwq_tx_avail.prio_mask (0x857060) / ll_ctx.fsched_flush_mask (0x857248). */
static u32 ps_sta_has_pending_data(u32 cid)
{
    volatile struct ll_ctx *ctx = LLC;
    struct vring_schd_if *tbl = vring_active_ring_table();
    u32 ring = tbl->vt->vring_of_pring(tbl, cid);
    u32 host = (ring == 0xff) ? 0 : hwd_dma_get_881c80(ring);
    u32 bit = 1u << cid;
    u32 a = ctx->pending_mask & bit;
    u32 b = fwq_tx_avail.prio_mask & bit;
    u32 c = bit & ctx->fsched_flush_mask;
    return (host != 0 || a != 0 || b != 0 || c != 0) ? 1 : 0;
}

/* ka__period_for_snr (0x8c6b4c, 58 Б): период keep-alive cid по SNR: с данными SNR
 * (a1 и a2 ненулевые) — snr < snr_lo → ka_period_lo, snr > snr_hi → ka_period_hi, иначе
 * текущий ctx->ka_period[cid]. Сравнения знаковые. */
static u32 ka_period_for_snr(volatile struct ll_ka_det *d, u32 a1, u32 a2, s32 snr)
{
    volatile struct ll_ctx *ctx = d->ctx;
    u32 cid = d->cid;
    u32 r = ctx->ka_period[cid];
    if (a1 != 0 && a2 != 0) {
        volatile struct ll_cid_cfg *e = &ctx->cfg[cid];
        if (snr < e->snr_lo)
            r = e->ka_period_lo;
        else if (e->snr_hi < snr)
            r = e->ka_period_hi;
    }
    return r;
}

/* ka_detector__log_state (0x8e10a4, 102 Б) / ageing_detector__log_state (0x8e110c,
 * 102 Б): три журнала состояния и TSF последнего журнала в log_tsf детектора. cid — поле
 * детектора; s2 vendor передаёт в стеке, но не читает. */
static void detector_log_state(volatile u8 *cid, volatile u32 *log_tsf, const u32 *tsf,
                               u32 a2, u32 a3, u32 a4, u32 a5, u32 a6, u32 a7, u32 s0, u32 s1,
                               u32 ka)
{
    fw_log_emit3(0x2b, ka ? 0x1014d10 : 0x1014a34, *cid, a2, a3);
    fw_log_emit3(0x2b, ka ? 0x1014d3c : 0x1014a5c, a4, a5, a6);
    fw_log_emit3(0x2b, ka ? 0x1014d74 : 0x1014a94, a7, s0, s1);
    log_tsf[0] = tsf[0];
    log_tsf[1] = tsf[1];
}

/* Разница счётчиков с переполнением (vendor: v ≥ old ? v − old : (0xffffffff − old) + v). */
static u32 wrap_diff(u32 v, u32 old)
{
    return (v >= old) ? v - old : (0xffffffffu - old) + v;
}

/* Сравнение TSF: ref > now (64 бит, без знака). Прошедшее — разность младших слов. */
static u32 tsf_ref_gt(const u32 *ref, const u32 *now)
{
    if (ref[1] != now[1])
        return ref[1] > now[1];
    return ref[0] > now[0];
}

/* Команда uc 0x26 (CMD_KEEP_ALIVE_TRIGGER, тело 1 Б = cid): uc keep_alive_arm_slot ставит бит cid в itx_ka_pending,
 * internal_tx_flow_sm2 шлёт RTS → CTS → кадр из очередей станции → Ack. ОШИБКА vendor 6.2: task пишет в журнал
 * «Initiating CMD_KEEP_ALIVE_TRIGGER to uCode», но команду не шлёт — ни один из 60 вызовов lmac_if__post_cmd в fw 6.2
 * не передаёт 0x26, и keep-alive в простое не уходит никогда (стенд 2026-10-24: журнал fw каждые ~31 с, путь uc ни
 * разу). В 4.1 это делает lmac_if_keep_alive_trigger_handler (0x8d85e4, send_cmd2_lmac(0x26, 1)), вызов из task. */
static void ka_send_trigger(u32 cid)
{
    volatile u8 *b = lmac_cmd_pool_alloc();
    b[0] = (u8)cid;
    lmac_if_post_cmd(b, 0x26, 1, 0);
}

/* ka_necessity_detector::task (0x8e8bfc, 488 Б) — vt->task детектора keep-alive cid.
 * Без трафика (ctx->traffic[cid] не менялся) и без ожидающих данных копит прошедшее время
 * в ctx->ka_acc[cid]; превысив период (по SNR, ctx->ka_period[cid]) или по запросу
 * (fsched_flush_mask/fsched_flush_over при [0x847ae1]) — журнал, счётчик ctx->ka_cnt[cid]++, сброс
 * накопленного и битов cid. Раз в DET_LOG_INTERVAL — журнал состояния. Все поля
 * детектора и контекста vendor перечитывает при каждом обращении — volatile. */
void ka_necessity_detector_task(struct psvc *svc, u32 count)
{
    struct ll_ka_det *det = (struct ll_ka_det *)svc;
    volatile struct ll_ka_det *d = det;
    volatile struct ll_ctx *c;
    u32 now[2], dl[2];
    const u32 *ref;
    u32 cid, elapsed, traffic, pending, bit, mask160, acc, period;
    (void)count;
    if (ka_detector_is_enabled(det) == 0) {
        fw_log_emit0(0xb, 0x1014be8);
        lm_if_stop_link_a(det);
        return;
    }
    mac_read_tsf64(0, now, 0);
    if (detector_deadline_is_unset(&d->svc) != 0) {
        ref = now;
    } else {
        dl[0] = d->svc.end_tsf[0];
        dl[1] = d->svc.end_tsf[1];
        ref = dl;
    }
    if (tsf_ref_gt(ref, now))
        elapsed = VCTX(d)->ka_period[d->cid];
    else
        elapsed = now[0] - ref[0];
    traffic = VCTX(d)->traffic[d->cid];
    pending = ps_sta_has_pending_data(d->cid);
    bit = 1u << d->cid;
    mask160 = VCTX(d)->pending_mask;
    VCTX(d)->ka_period[d->cid] =
        ka_period_for_snr(d, VOL(mac_mon_pub.bti.detected), VOL(mac_mon_pub.bti.snr_valid),
                          VOL(mac_mon_pub.bti.snr));
    c = d->ctx;
    cid = d->cid;
    if (pending == 0 && d->last_traffic == traffic)
        c->ka_acc[cid] = c->ka_acc[cid] + elapsed;
    else
        c->ka_acc[cid] = 0;
    d->last_traffic = traffic;
    c = d->ctx;
    cid = d->cid;
    acc = c->ka_acc[cid];
    period = c->ka_period[cid];
    if (period < acc ||
        (*(volatile u8 *)&fixed_sched.enabled != 0 && ((LLC->fsched_flush_over >> cid) & 1) != 0)) {
        fw_log_emit1(0x2b, 0x1014c48, cid);
        c = d->ctx;
        cid = d->cid;
        detector_log_state(&d->cid, d->log_tsf, now, c->ka_acc[cid], traffic, d->last_traffic,
                           pending, mask160 & bit, c->ka_period[cid], c->ka_cnt[cid],
                           (u32)VOL(mac_mon_pub.bti.snr), 1);
        if (*(volatile u8 *)&fixed_sched.enabled != 0)
            fw_log_emit3(0x2b, 0x1014cc0, LLC->fsched_flush_mask,
                         d->cid, LLC->fsched_flush_over);
        c = d->ctx;
        cid = d->cid;
        c->ka_cnt[cid] = c->ka_cnt[cid] + 1;
        ka_send_trigger(cid);
        VCTX(d)->ka_acc[d->cid] = 0;
        LLC->fsched_flush_mask &= ~(1u << d->cid);
        LLC->fsched_flush_over &= ~(1u << d->cid);
    }
    if (DET_LOG_INTERVAL >= now[0] - d->log_tsf[0])
        return;
    c = d->ctx;
    cid = d->cid;
    detector_log_state(&d->cid, d->log_tsf, now, c->ka_acc[cid], traffic, d->last_traffic,
                       pending, mask160 & bit, c->ka_period[cid], c->ka_cnt[cid],
                       (u32)VOL(mac_mon_pub.bti.snr), 1);
}

/* mid__field_18_step (0x8cbf18, 20 Б): время скана при соединении (scan_mngr записи mid
 * соединения cid, [mid+0x23c]). */
static u32 mid_field_18_step(u32 cid)
{
    return scan_mngr_update_step(((volatile struct mid *)conn_mgr_by_cid(cid)->mid)->disc.scan);
}

/* tx_ppdu_ageing__hook_ret0 (0x8cbb80, 4 Б): всегда 0. */
static u32 tx_ppdu_ageing_hook_ret0(u32 v)
{
    (void)v;
    return 0;
}

/* lmac_if__get_evt_byte3 (0x8cb910, 4 Б): байт [gp,201] = 0x80024d (аргумент не читает). */
static u32 lmac_if_get_evt_byte3(u32 v)
{
    (void)v;
    return ps_lmac_evt_cid_mask;
}

/* ageing_detector__drop_connection (0x8c90f0, 32 Б): разорвать соединение cid. */
static void ageing_detector_drop_connection(u32 cid, u32 reason, u32 proto)
{
    struct conn *conn = conn_mgr_by_cid(cid);
    if (conn != 0)
        conn_disconnect(conn, reason, proto);
}

/* tx_ppdu_ageing_timeout_detector::task (0x8e8de4, 696 Б) — vt->task детектора старения
 * TX PPDU cid. Пока очередь cid не продвигается (ctx->traffic[cid] прежний) и есть
 * ожидающие данные — копит в ctx->idle[cid] время простоя (прошедшее минус прирост
 * счётчиков активности; при «на паузе» — не больше cfg.period); превысив порог
 * cfg.ageing_thr (или по запросу ctx->drop_req) — журнал и разрыв соединения (причина 1,
 * протокол 1). Поля детектора и контекста — volatile (vendor перечитывает). */
void tx_ppdu_ageing_timeout_detector_task(struct psvc *svc, u32 count)
{
    struct ll_ageing_det *det = (struct ll_ageing_det *)svc;
    volatile struct ll_ageing_det *d = det;
    u32 now[2], dl[2];
    const u32 *ref;
    u32 cid, elapsed, traffic, r15, r21, r17, r16, pending, m160, evt, add, i, p;
    struct vring_schd_if *tbl;
    (void)count;
    if (tx_ageing_detector_is_enabled(det) == 0) {
        fw_log_emit1(0xb, 0x10148c0, d->cid);
        lm_if_stop_link_b(det);
        return;
    }
    mac_read_tsf64(0, now, 0);
    if (detector_deadline_is_unset(&d->svc) != 0) {
        ref = now;
    } else {
        dl[0] = d->svc.end_tsf[0];
        dl[1] = d->svc.end_tsf[1];
        ref = dl;
    }
    elapsed = 0;
    if (!tsf_ref_gt(ref, now))
        elapsed = now[0] - ref[0];
    traffic = VCTX(d)->traffic[d->cid];
    tbl = vring_active_ring_table();
    r15 = tbl->vt->time_of_pring(tbl, d->cid);
    cid = d->cid;
    r21 = VCTX(d)->act_140[cid];
    if ((s32)cid >= 8)
        fw_log_emit2(0, 0x1014930, (u32)&det->cid, cid);
    if ((s32)d->cid >= 8) {
        /* vendor: недопустимый cid — дамп 0x28 пар слов перед детектором */
        p = (u32)det - 0x70;
        fw_log_emit3(0, 0x1014950, d->cid, (u32)&det->cid, p);
        for (i = 0; i < 0x28; i++) {
            const volatile u32 *w = (const volatile u32 *)p;   /* дамп памяти парами слов */
            fw_log_emit3(0, 0x1014970, p, w[0], w[1]);
            p += 8;
        }
    }
    r17 = mid_field_18_step(d->cid);
    r16 = tx_ppdu_ageing_hook_ret0(r17);
    pending = ps_sta_has_pending_data(d->cid);
    cid = d->cid;
    m160 = VCTX(d)->pending_mask & (1u << cid);
    evt = lmac_if_get_evt_byte3(m160);
    cid = d->cid;
    evt &= 1u << cid;
    if (pending == 0 || d->last_traffic != traffic) {
        VCTX(d)->idle[cid] = 0;
    } else {
        u32 idle = wrap_diff(r15, d->last_pring_time);
        u32 act = wrap_diff(r17, d->last_scan_step) + wrap_diff(r21, d->last_act) +
                  wrap_diff(r16, d->last_hook);
        volatile struct ll_ctx *ctx = d->ctx;
        if (idle != 0 && evt == 0) {
            add = (idle > act) ? idle - act : 0;
        } else if (evt == 0 && m160 == 0) {
            add = 0;
        } else {
            add = ctx->cfg[cid].period;
            if (add >= elapsed)
                add = elapsed;
        }
        ctx->idle[cid] = ctx->idle[cid] + add;
    }
    d->last_traffic = traffic;
    d->last_pring_time = r15;
    d->last_act = r21;
    d->last_scan_step = r17;
    d->last_hook = r16;
    {
        volatile struct ll_ctx *ctx = d->ctx;
        u32 tok = 0;
        cid = d->cid;
        if (ctx->cfg[cid].ageing_thr < ctx->idle[cid])
            tok = 0x1014980;
        else if ((ctx->drop_req >> cid) & 1)
            tok = 0x10149d0;
        if (tok != 0) {
            fw_log_emit1(0x1b, tok, cid);
            detector_log_state(&d->cid, d->log_tsf, now, VCTX(d)->idle[d->cid], traffic,
                               d->last_traffic, pending, m160, evt, r15, r21, 0);
            VCTX(d)->idle[d->cid] = 0;
            ageing_detector_drop_connection(d->cid, 1, 1);
        }
    }
    if (DET_LOG_INTERVAL >= now[0] - d->log_tsf[0])
        return;
    detector_log_state(&d->cid, d->log_tsf, now, VCTX(d)->idle[d->cid], traffic,
                       d->last_traffic, pending, m160, evt, r15, r21, 0);
}

/* ======================= плохие биконы ======================= */

/* bad_beacons_detector::handle_bcons_info (0x8cd1e8, 158 Б): BI без бикона — счётчик cid
 * (ctx->bcn_cnt) растёт, при хорошем SNR (известен и < cfg.bcn_snr) — сброс. Счётчик выше
 * cfg.bcn_thr × [0x800231] — журнал, разрыв соединения (1, 1) и сброс счётчика. */
static void bad_beacons_detector_handle_bcons_info(struct ll_bcn_det *det)
{
    volatile struct ll_bcn_det *o = det;
    volatile struct ll_ctx *ctx;
    u32 cid, good = 0, lim;
    volatile u16 *cnt;
    if (bad_beacons_detector_is_enabled(det) == 0)
        return;
    if (o->armed == 0)
        return;
    cid = o->cid;
    ctx = o->ctx;
    if (VOL(mac_mon_pub.bti.detected) != 0) {
        if (VOL(mac_mon_pub.bti.snr_valid) == 0)
            good = 1;
        else if (ctx->cfg[cid].bcn_snr < VOL(mac_mon_pub.bti.snr))
            good = 1;
    }
    cnt = &ctx->bcn_cnt[cid];
    *cnt = good ? 0 : (u16)(*cnt + 1);
    ctx = o->ctx;
    cid = o->cid;
    lim = conn_multi_omni_count * ctx->cfg[cid].bcn_thr;
    if (ctx->bcn_cnt[cid] <= lim)
        return;
    fw_log_emit1(0x1b, 0x1014dd4, cid);
    conn_disconnect(conn_mgr_by_cid(o->cid), 1, 1);
    bad_beacons_check_counter(det);
}

/* bad_beacons__on_bi_evt (0x8cd880 → 0x8cd888 с lm_if соединения, 114 Б): BI —
 * детектор плохих биконов; TSF [0x85394c] впереди текущего — три журнала. */
static void bad_beacons_on_bi_evt(struct conn *conn)
{
    struct lm_if *lm = &conn->lm;
    u32 tsf[2];
    u32 lo, hi;
    mac_read_tsf64(0, tsf, 0);
    if (lm->detectors != 0)
        bad_beacons_detector_handle_bcons_info(&lm->detectors->bcn);
    lo = VOL(mac_mon_pub.bti.bti_start[0]);
    hi = VOL(mac_mon_pub.bti.bti_start[1]);
    if (hi < tsf[1] || (hi == tsf[1] && lo <= tsf[0]))
        return;
    fw_log_emit2(0x1b, 0x1014374, tsf[1], tsf[0]);
    fw_log_emit2(0x1b, 0x101438c, VOL(mac_mon_pub.bti.bti_start[1]), VOL(mac_mon_pub.bti.bti_start[0]));
    fw_log_emit0(0x1b, 0x10143a8);
}

/* ======================= обработчики conn_mgr (PS) ======================= */

/* connection__cmp_bf_id (0x8e75a4, 68 Б): скользящее окно ([0x80025b] — длина, степень
 * двойки) значений v: bf_win_fill — заполнено, bf_win_sum — сумма, bf_win_pos — позиция,
 * bf_win — окно; bf_last = v. */
void connection_cmp_bf_id(struct conn *conn, u32 v)
{
    u32 n = conn->bf_win_fill, idx;
    u32 len = conn_bf_id_win_len;
    if (n != len)
        conn->bf_win_fill = (u8)(n + 1);
    idx = conn->bf_win_pos;
    conn->bf_win_sum = conn->bf_win_sum + v - conn->bf_win[idx];
    conn->bf_win[idx] = (u8)v;
    conn->bf_win_pos = (u8)((len - 1) & (idx + 1));
    conn->bf_last = (u8)v;
}

/* connection__bf_id_at_6c (0x8e75e8, 18 Б): среднее по окну. */
u32 connection_bf_id_at_6c(struct conn *conn)
{
    return (u8)fw_divmod_unsigned(conn->bf_win_sum, conn->bf_win_fill);
}

/* connection__bf_notify_entry (0x8e7530, 26 Б): последнее значение bf_last в окно,
 * среднее — в bf_avg. */
static void connection_bf_notify_entry(struct conn *conn)
{
    connection_cmp_bf_id(conn, conn->bf_last);
    conn->bf_avg = (u8)connection_bf_id_at_6c(conn);
}


/* conn__retry_timer_expired (0x8e754c, 40 Б): колбэк таймера повтора (vendor передаёт
 * числом 0x2754c): задача снята, окно обновлено; не больше [0x80025b] раз — перевзвод. */
static void conn_retry_timer_expired(u32 a0, u32 a1)
{
    struct conn *conn = (struct conn *)a0;
    (void)a1;
    conn->retry_timer = 0;
    connection_bf_notify_entry(conn);
    if (conn->retry_cnt <= conn_bf_id_win_len)
        conn_arm_retry_timer(conn, 0);
}

/* conn__arm_retry_timer (0x8e48d0, 62 Б): restart == 1 — счётчик retry_cnt с нуля;
 * счётчик++, снять прежний таймер, завести новый на [0x80000c] (= [gp,-0x5e*4]). */
void conn_arm_retry_timer(struct conn *conn, u32 restart)
{
    if (restart == 1)
        conn->retry_cnt = 0;
    conn->retry_cnt = (u8)(conn->retry_cnt + 1);
    conn_check_field_50(conn);
    conn->retry_timer = u_schd_schedule(conn_retry_timer_expired, (u32)conn, 0, 0,
                                      conn_retry_delay, 0, 0);
}

/* conn_mgr__bi_evt_all_conns (0x8cd8f4, 74 Б): событие BI — без mid в состоянии 2/3
 * детектор плохих биконов каждого соединения в состоянии 2; детекторы не запрещены и
 * [0x803c10] == 0 — ll_ctx.drop_req (0x857260) = [0x85397d]. */
void conn_mgr_bi_evt_all_conns(void)
{
    u32 cid;
    struct conn *conn;
    if (mid_state_is_2_or_3(0) == 0) {
        for (cid = 0; cid < 8; cid++) {
            conn = conn_mgr_by_cid(cid);
            if (conn != 0 && conn->mlme.sm.state == 2)
                bad_beacons_on_bi_evt(conn);
        }
    }
    LLC->drop_req = VOL(mac_mon_pub.bcons_atim_fail_vec);
}

/* Таблица методов детектора keep-alive (vendor 0x80075c). */
FWDATA(80075c) const struct psvc_vt ll_ka_det_vtbl = {
    .rsv0 = 0,
    .start = periodic_service_start,
    .stop = detector_arm_timer,
    .task = ka_necessity_detector_task,
    .run = periodic_service_run,
};

/* Таблица методов детектора старения TX PPDU (vendor 0x8008c4). */
FWDATA(8008c4) const struct psvc_vt ll_ageing_det_vtbl = {
    .rsv0 = 0,
    .start = periodic_service_start,
    .stop = detector_arm_timer,
    .task = tx_ppdu_ageing_timeout_detector_task,
    .run = periodic_service_run,
};
