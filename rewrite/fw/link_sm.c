// SPDX-License-Identifier: AGPL-3.0-or-later
/* Автоматы линка STA после начала ассоциации: lm_sm (0x802da0, ведение линка), maintain_sm
 * (0x802cc4, BF/RS-сопровождение), sm_802f58 (статистика линка), sm_8027a0 (разрыв
 * соединения: остановка данных/LMS/TX и сброс) и find_sm (0x8030f4, поиск/прослушивание).
 * Действия — из таблиц переходов автоматов (struct sm_trans, FWDATA в модулях),
 * вызываются basic_sm_do_transition как (автомат, a0, a1, a2).
 *
 * Объекты (конструкторы — discovery.c / mid.c):
 *   conn (include/conn.h): lm_if I (conn->lm), автомат MLME, conn_main_sm C (conn->msm),
 *   автомат разрыва D (conn->msm.disc); I->lm_sm = l = &lm_sm_recs[cid] (include/link_sm.h):
 *   l->lm = I, l->msm — maintain_sm m (m->lm_sm = l), m->stats — sm_802f58 s (s->msm = m);
 *   find_mngr x (e+0x240 записи mid): x+0x1c — find_sm F ([F+0x10] = x), [x+0x48] — запись mid.
 *
 * Колбэки, которые vendor передаёт числом в младшем отображении ICCM (0x5e48, 0x19c0c,
 * 0x3251c, 0x323f8 …), здесь передаются полным адресом нашей функции. */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/fwq_tx.h"
#include "../include/mac_cnt.h"
#include "../include/radio_mgr.h"
#include "../include/conn.h"
#include "../include/mid.h"
#include "../include/link_sm.h"
#include "../include/ieee80211.h"
#include "../include/lmac_cmd.h"
#include "../include/sys_cfg.h"
#include "../include/fwdata.h"
#include "../include/fwdata.h"

/* 0x801448: период долгосрочного BF по MCS (мкс; schedule_long_term_trigger). */
FWDATA(801448) volatile u32 maintain_lt_period[MAINTAIN_LT_PERIOD_N] = {
    0x186a0, 0xf4240, 0x1e8480, 0x1e8480, 0x2dc6c0, 0x0, 0x3d0900, 0x4c4b40,
    0x1c9c380, 0x0, 0x1c9c380, 0x1c9c380, 0x1c9c380,
};

/* 0x80147c: шаблон LMAC 0x13 (параметры RS, struct wmi_rs_cfg 0x26 Б) — тело для
 * maintain_sm_stop_lmac / maintain_sm_on_timer_fbf_done. Здесь — первые 0x22 Б; его
 * mcs_en_vec — переменные link_mcs_en_vec_lo/hi (0x80149e/0x8014a0, fw/dccm_names.txt) сразу
 * за ним: отдельные символы — как у vendor, доступ к ним — по абсолютным адресам
 * (с полями одного объекта gcc держал бы базу в регистре). lmac_if_send_cmd_0x13 копирует
 * все 0x26 Б с начала шаблона. */
struct maintain_rs_cfg_head {
    u8  per_threshold[13];                     /* 0x00 */
    u8  min_frame_cnt[13];                     /* 0x0d */
    u8  stop_th;                               /* 0x1a */
    u8  mcs1_fail_th;                          /* 0x1b */
    u8  max_back_failure_th;                   /* 0x1c */
    u8  dbg_disable_internal_trigger;          /* 0x1d */
    u16 back_failure_mask[2];                  /* 0x1e */
};
_Static_assert(sizeof(struct maintain_rs_cfg_head) == 0x22, "maintain_rs_cfg_head");
FWDATA(80147c) const struct maintain_rs_cfg_head maintain_rs_cfg = {
    .per_threshold = { 0x00, 0x00, 0x28, 0x0f, 0x0a, 0x00, 0x14, 0x0f, 0x0a, 0x00, 0x0f, 0x0a, 0x0a },
    .min_frame_cnt = { 0x00, 0x20, 0x40, 0x40, 0x40, 0x00, 0x50, 0x50, 0x50, 0x00, 0xa0, 0xa0, 0xa0 },
    .stop_th = 0x50,
    .mcs1_fail_th = 0x50,
    .max_back_failure_th = 0x03,
    .dbg_disable_internal_trigger = 0,
    .back_failure_mask = { 0x0010, 0x0000 },
};
#include "../include/fwdata.h"


/* Глобалы vendor (gp = 0x800184). */
#define G_LT_MAX_GOODPUT  (lt_bf_max_goodput)   /* [gp,-0x84]: максимум TX goodput */
#define G_MAINTAIN_PAUSED (maintain_paused)   /* [gp,-0x80]: сопровождение на паузе */
#define G_FBF_PARAM       (lm_bf_cfg_param)   /* [gp,-0xec]: параметр LMAC 0x10 */
#define G_TXSS_TIMEOUT    (maintain_txss_timeout)   /* [gp,-0xe8] */
#define G_TX_FLUSH_MASK   (tx_flush_cid_mask)   /* [gp,-0xd0]: cid в сбросе TX */

/* ======================= мелкие методы соединения ======================= */


/* conn__get_cid_via_field8 (0x8cbec0, 6 Б): cid линка maintain_sm (владелец m->lm_sm). */
static u32 conn_get_cid_via_field8(struct maintain_sm *m)
{
    return conn_get_cid_of_obj(m->lm_sm);
}

/* lm_if записи lm_sm. */
static inline struct lm_if *lm_sm_if(struct lm_sm *l)
{
    return l->lm;
}

/* conn__inject_evt3 (0x8dc4cc, 12 Б): событие 3 автомату разрыва. */
static void conn_inject_evt3(struct conn *conn)
{
    conn_sm_handle_event(conn, 3, 0, 0, 0);
}

/* lm__inject_conn_evt3 (0x8e81a4, 6 Б). */
static void lm_inject_conn_evt3(struct lm_if *i)
{
    conn_inject_evt3(i->conn);
}



/* ======================= LMAC-команды линка ======================= */

/* lmac_if_send_cmd_0x15 (0x8dbf80, 32 Б): параметры RS. */
static void lmac_if_send_cmd_0x15(u32 a0, u32 a1)
{
    struct lmac_cmd_rs_params *b = lmac_cmd_pool_alloc();
    b->personality = a0;
    b->failure_policy = a1;
    lmac_if_post_cmd(b, 0x15, 8, 0);
}

/* lmac_if_send_cmd_0x0f (0x8dbd74, 32 Б): {cid, флаг u16}. */
void lmac_if_send_cmd_0x0f(u32 cid, u32 a1)
{
    struct lmac_cmd_maint_sta *b = lmac_cmd_pool_alloc();
    b->cid = cid;
    b->on = (u16)a1;
    lmac_if_post_cmd(b, 0xf, 8, 0);
}

/* lmac_if_send_cmd_0x13 (0x8dbbb4, 48 Б): {cid, a1, 0x26 Б из src}. Оба вызова vendor
 * (0x8f234c, 0x8cab64) передают src = шаблон maintain_rs_cfg (0x80147c) — параметр src
 * свёрнут (как gcc сам делал .constprop при литерале). */
static void lmac_if_send_cmd_0x13(u32 cid, u32 a1)
{
    struct lmac_cmd_rs_cfg *b = lmac_cmd_pool_alloc();
    b->cid = (u8)cid;
    b->enable = (u8)a1;
    memcpy_fw(b->cfg, &maintain_rs_cfg, 0x26);
    lmac_if_post_cmd(b, 0x13, 0x28, 0);
}

/* field_rw_0x00 (0x8db534, 98 Б): LMAC 0x14 — шесть флагов в слове буфера (биты 3, 2,
 * 1, 0, 4, 5 — a1..a6); первый аргумент (cid) vendor не использует. Остальные биты
 * слова — как были в буфере пула (vendor читает-модифицирует). */
static void lmac_if_send_cmd_0x14(u32 cid, u32 a1, u32 a2, u32 a3, u32 a4, u32 a5, u32 a6)
{
    struct lmac_cmd_bf_triggers *b = lmac_cmd_pool_alloc();
    u32 w = b->triggers;
    (void)cid;
    w = (w & ~8u) | ((a1 & 1u) << 3);
    w = (w & ~4u) | ((a2 & 1u) << 2);
    w = (w & ~2u) | ((a3 & 1u) << 1);
    w = (w & ~1u) | (a4 & 1u);
    w = (w & ~0x10u) | ((a5 & 1u) << 4);
    w = (w & ~0x20u) | ((a6 & 1u) << 5);
    b->triggers = w;
    lmac_if_post_cmd(b, 0x14, 4, 0);
}

/* 0x80026c ([gp,0xe8]): конфигурация CMD_SELECTIVE_NEIGHBOR_CFG (include/link_sm.h); vendor
 * её не пишет. const volatile: читается словом (биты разрешений) и байтами — как у vendor. */
FWDATA(80026c) const volatile union sel_nbr_cfg sel_nbr_cfg = {
    .b = { .det_threshold = 0x10, .nav_threshold = 0x14, .en = 0x04 },
};

/* lmac_if__send_selective_neighbor_cfg (0x8dbd94, 190 Б): LMAC 0x1e. Разрешения — биты
 * 16/17/18 слова sel_nbr_cfg, значения — его байты 0/1; копия флагов в биты 21/22/15
 * слова [0x853918]. */
static void lmac_if_send_selective_neighbor_cfg(u32 a0, u32 a1, u32 a2, u32 a3)
{
    struct lmac_cmd_sel_nbr *b = lmac_cmd_pool_alloc();
    u32 r;
    if ((sel_nbr_cfg.w & SEL_NBR_DET_EN) && a0 == 1) {
        b->cap_en = 1;
        b->threshold = sel_nbr_cfg.b.det_threshold;
    } else {
        b->cap_en = 0;
        b->threshold = 0x2d;
    }
    if ((sel_nbr_cfg.w & SEL_NBR_NAV_EN) && a1 == 1) {
        b->b_en = 1;
        b->b_val = sel_nbr_cfg.b.nav_threshold;
    } else {
        b->b_en = 0;
        b->b_val = 0x2d;
    }
    b->short_txop = ((sel_nbr_cfg.w & SEL_NBR_SHORT_TXOP_EN) && a2 == 1) ? 1 : 0;
    b->rs_param = (u8)a3;
    r = VOL(fw_stats_dash.state);
    r &= ~((1u << 21) | (1u << 22) | (1u << 15));
    r |= (a0 & 1u) << 21;
    r |= (a1 & 1u) << 22;
    r |= (a2 & 1u) << 15;
    VOL(fw_stats_dash.state) = r;
    fw_log_emit3(0x2b, 0x1004b98, b->cap_en, b->threshold, b->rs_param);
    fw_log_emit3(0x2b, 0x1004c00, b->b_en, b->b_val, b->short_txop);
    lmac_if_post_cmd(b, 0x1e, 8, 0);
}

/* install_key_index_stub (0x8f0c98, 96 Б): LMAC 0x18 {индекс, a1, 0x38, 0x10, ключ 16 Б};
 * в OOB-режиме при a4 != 0 индекс 8. a3 vendor не использует. */
void lmac_if_install_key(u32 idx, u32 a1, const void *key, u32 a3, u32 a4)
{
    struct lmac_cmd_sta_field *b = lmac_cmd_pool_alloc();
    (void)a3;
    b->mode = a1;
    (void)a4;                            /* OOB R1 (только SparRAW-pro): индекс 8 при a4 != 0 */
    b->sta = idx;
    fw_log_emit0(0x20, 0x100eda0);
    b->offset = 0x38;
    b->len = 0x10;
    memcpy_fw(b->data, key, 0x10);
    lmac_if_post_cmd(b, 0x18, 0x20, 0);
}

/* maintain_sm__set_rs_params (0x8f1cdc, 42 Б): mode 0/1 → LMAC 0x15 {mode, v}. */
static void maintain_sm_set_rs_params_m(struct maintain_sm *m, u32 mode, u32 v)
{
    m->rs_mode = mode;
    m->rs_val = v;
    if (mode != 0 && mode != 1) {
        fw_sysassert_fatal((void *)0, 0x126a);
        return;
    }
    lmac_if_send_cmd_0x15(mode == 1 ? 1u : 0u, v);
}

/* maintain_sm__set_rs_params_of_conn (0x8c6cb4, 6 Б): maintain_sm записи l.
 * Подменяет weak-заглушку lmac_evt.c (там же имя maintain_sm_set_rs_params). */
void maintain_sm_set_rs_params(struct lm_sm *l, u32 mode, u32 v)
{
    maintain_sm_set_rs_params_m(&l->msm, mode, v);
}

/* ======================= радио-менеджер ======================= */

/* radio_mgr->request_primary — как l2_mgr__connect_args [0x8dca38] (wmi_cmd.c); vendor
 * возвращает описатель запроса (maintain_sm хранит его в [M+0x24]). */
static struct rm_req *radio_mgr_request_primary(rm_req_cb cb, u32 arg, u32 mid)
{
    struct radio_mgr *rm = radio_mgr_obj;
    return rm->vt->request_primary(rm, cb, arg, mid);
}

/* radio_mgr->request_secondary — как radio_mgr__request [0x8dcaf4] (lmac_evt.c). */
static struct rm_req *radio_mgr_request_secondary(rm_req_cb cb, u32 arg, u32 param, u32 ch,
                                                  u32 mid)
{
    struct radio_mgr *rm = radio_mgr_obj;
    return rm->vt->request_secondary(rm, cb, arg, param, ch, mid);
}

/* radio_mgr->sec_tune (0x8e4e18, 46 Б; vendor-имя ftm_main_sm__radio_args) — настройка канала. */
static void radio_mgr_sec_tune(rm_req_cb cb, u32 arg, struct rm_req *req, u32 param, u32 ch,
                               u32 mid)
{
    struct radio_mgr *rm = radio_mgr_obj;
    rm->vt->sec_tune(rm, cb, arg, req, param, ch, mid);
}

/* ======================= lm_sm (0x802da0) ======================= */


/* conn_main_sm (0x8c4894, 4 Б): предикат, всегда 1. */
static u32 conn_main_sm_bf_ok(struct lm_sm *l, struct lm_sm *a)
{
    (void)l;
    (void)a;
    return 1;
}

/* lm_sm__action_8dab0c (0x8dab0c): LM_EVT_LINK_LOST — разрыв соединения (1, 1). */
void lm_sm_on_link_lost(struct lm_sm *l)
{
    struct lm_if *i = lm_sm_if(l);
    fw_log_emit0(0x2b, 0x1014270);
    conn_disconnect(i->conn, 1, 1);
}

/* lm_sm__action_8dabdc (0x8dabdc): LM_EVT_LINK_STAT_UPDATE — запомнить [L+0x98], если
 * не запрещено битами 1/2 [0x803c20]. */
void lm_sm_on_link_stat_update(struct lm_sm *l, u32 a)
{
    if (l->link_stat == a)
        return;
    if (dashboard.cfg.special_flags & 6u)
        return;
    l->link_stat = a;
}

/* lm_sm__action_8dad54 (0x8dad54): LM_EVT_SELF_LINKUP_DONE — при отложенной остановке
 * ([L+0xc]) событие 3 разрыву, иначе «линк поднят» conn_main_sm. */
void lm_sm_on_linkup_done(struct lm_sm *l)
{
    struct lm_if *i = lm_sm_if(l);
    if (l->stop_pending != 0) {
        l->stop_pending = 0;
        lm_inject_conn_evt3(i);
    } else {
        lm_notify_linkup(i, 0);
    }
}

/* lm_sm__action_8dad74 (0x8dad74): LM_EVT_SELF_LINKUP_FAIL — повтор BF; после [0x800400]
 * неудач подряд — «линк не поднят» и автомат lm_sm прямо в LM_STATE_IDLE (байт
 * состояния 0, как vendor). */
void lm_sm_on_linkup_fail(struct lm_sm *l)
{
    struct lm_if *i;
    fw_log_emit1(0x20, 0x1014784, l->stop_pending);
    if (l->stop_pending != 0) {
        l->stop_pending = 0;
        lm_inject_conn_evt3(lm_sm_if(l));
        return;
    }
    l->linkup_fails = (u8)(l->linkup_fails + 1);
    fw_log_emit1(0x20, 0x10147a4, l->linkup_fails);
    i = lm_sm_if(l);
    if (l->linkup_fails == lm_linkup_fail_max) {      /* ld_s [gp,0x27c] */
        l->linkup_fails = 0;
        lm_notify_linkup(i, 1);
        l->hdr.state = 0;
    } else {
        lmac_if_trigger_bf((u8)conn_get_cid(i), 0);
    }
}

/* lm_sm__action_8daed8 (0x8daed8): LM_EVT_LINKUP_REQ в LM_STATE_IDLE — сброс счётчика
 * неудач, RS выкл., LMAC 0x10, TXSS; a0 != 0 — отложенное событие 2 самому себе, иначе BF. */
void lm_sm_on_linkup_req_idle(struct lm_sm *l, u32 a0)
{
    l->linkup_fails = 0;
    maintain_sm_set_rs_params(l, 0, 0);
    lm_main_sm_config_lmac_bf_sm(l, G_FBF_PARAM);
    lmac_if_config_txss((u8)conn_get_cid(lm_sm_if(l)));
    if (a0 != 0)
        lm_sm_defer(l, 2, 0, 0, 0);
    else
        lmac_if_trigger_bf((u8)conn_get_cid(lm_sm_if(l)), 0);
}

/* lm_sm__action_8daf2c (0x8daf2c): LM_EVT_LINKUP_REQ в LM_STATE_CONFIGURED — BF. */
void lm_sm_on_linkup_req_configured(struct lm_sm *l)
{
    lmac_if_trigger_bf((u8)conn_get_cid(lm_sm_if(l)), 0);
}

/* lm_sm__action_8ddb58 (0x8ddb58): LM_EVT_MAINTAIN_STARTED — RS (вкл., кроме mid в
 * состоянии 2/3), LMAC 0x10, событие 6 conn_main_sm. */
void lm_sm_on_maintain_started(struct lm_sm *l)
{
    struct mid *e = mid_list_by_mid_fw(lm_sm_get_mid_idx(l));
    u32 st = e->bss.mode;
    l->link_stat = 1;
    maintain_sm_set_rs_params(l, 0, (st == 2 || st == 3) ? 0u : 1u);
    lm_main_sm_config_lmac_bf_sm(l, G_FBF_PARAM);
    lm_sm_post_evt6_via_owner(lm_sm_if(l));
}

/* lm_sm__action_8df614 (0x8df614): LM_EVT_BF_RESULTS в LM_STATE_CONFIGURED. */
void lm_sm_on_bf_results_configured(struct lm_sm *l, const struct lmac_evt_bf_done *res)
{
    lm_notify_linkup(lm_sm_if(l), res->status != 1 ? 1u : 0u);
}

/* lm_sm__action_8dfff4 (0x8dfff4): LM_EVT_PAUSE — EVT_PAUSE (8) maintain_sm. */
void lm_sm_on_pause(struct lm_sm *l)
{
    maintain_sm_event(&l->msm, 8, 0, 0, 0);
}

/* lm_sm__action_8e11c8 (0x8e11c8): LM_EVT_BF_RESULTS в LM_STATE_WAIT_LINK — статус
 * res->status == 0 → отложенное событие 1 (неудача), иначе 2 (предикат 0x8c4894 всегда 1). */
void lm_sm_on_bf_results_wait_link(struct lm_sm *l, const struct lmac_evt_bf_done *res)
{
    u32 ev = 1;
    if (res->status != 0 && conn_main_sm_bf_ok(l, l) != 0)
        ev = 2;
    lm_sm_defer(l, ev, 0, 0, 0);
}

/* lm_sm__action_8e2c64 (0x8e2c64): LM_EVT_RESUME_MAINTAIN_REQ — EVT_RESUME_MAINTAIN (9). */
void lm_sm_on_resume_maintain(struct lm_sm *l)
{
    maintain_sm_event(&l->msm, 9, 0, 0, 0);
}

/* lm_sm__action_8e7acc (0x8e7acc): LM_EVT_START_MAINTAIN_REQ — EVT_START_MAINTAIN (0). */
void lm_sm_on_start_maintain(struct lm_sm *l)
{
    maintain_sm_event(&l->msm, 0, 0, 0, 0);
}

/* lm_sm__action_8e7f94 (0x8e7f94): LM_EVT_STOP_LINK в LM_STATE_WAIT_LINK. vendor откладывал (stop_pending) до
 * результата BF; исправлено: после начала разрыва результат BF не приходит (стенд 2026-10-25: WMI_DISCONNECT через
 * 0,8 мс после запуска BF — ни BF_DONE, ни LMS_STOPPED, разрыв висит, хост — wmi_call timeout и «is DISCONNECTING»).
 * Останов сразу, как в IDLE/CONFIGURED (LMAC 0x10, событие 3 разрыву), автомат — в IDLE: поздний BF_RESULTS там
 * не обрабатывается (nop). */
void lm_sm_on_stop_link_wait(struct lm_sm *l)
{
    l->stop_pending = 0;
    l->hdr.state = 0;
    lm_sm_on_stop_link(l);
}

/* lm_sm__action_8e7f9c (0x8e7f9c): LM_EVT_STOP_LINK — LMAC 0x10 и событие 3 разрыву. */
void lm_sm_on_stop_link(struct lm_sm *l)
{
    lm_main_sm_config_lmac_bf_sm(l, G_FBF_PARAM);
    lm_inject_conn_evt3(lm_sm_if(l));
}

/* lm_sm__action_8e8004 (0x8e8004): LM_EVT_STOP_LINK при сопровождении — EVT_STOP (3). */
void lm_sm_on_stop_link_maintain(struct lm_sm *l)
{
    maintain_sm_event(&l->msm, 3, 0, 0, 0);
}

/* lm_if__on_data_stopped (0x8e8014, 58 Б): снять таймер статистики, событие 3
 * (STOP_LINK) lm_sm. */
static void lm_if_on_data_stopped(struct lm_if *i)
{
    if (i->lm_sm == 0)
        fw_sysassert_fatal((void *)0, 0x1261);
    if (i->notify_timer != 0) {
        u_schd_cancel(i->notify_timer);
        i->notify_timer = 0;
    }
    i->notify_en = 0;
    lm_sm_event(i->lm_sm, 3, 0, 0, 0);
}

/* 0x802db4: таблица переходов lm_sm [событие][состояние] (событий 12, состояний 7) —
 * {действие, следующее состояние}; комментарий — «состояние → следующее» по vendor-именам. */
FWDATA(802db4) const struct sm_trans lm_sm_trans[12][7] = {
    [0] = {   /* LM_EVT_LINKUP_REQ */
        { SM_ACT(lm_sm_on_linkup_req_idle), 1 },             /* LM_STATE_IDLE → LM_STATE_WAIT_LINK */
        { SM_ACT(basic_sm_error_handler), 1 },               /* LM_STATE_WAIT_LINK → LM_STATE_WAIT_LINK */
        { SM_ACT(lm_sm_on_linkup_req_configured), 1 },       /* LM_STATE_CONFIGURED → LM_STATE_WAIT_LINK */
        { SM_ACT(basic_sm_error_handler), 3 },               /* LM_STATE_WAIT_MAINTAIN → LM_STATE_WAIT_MAINTAIN */
        { SM_ACT(basic_sm_error_handler), 4 },               /* LM_STATE_MAINTAINING → LM_STATE_MAINTAINING */
        { SM_ACT(basic_sm_error_handler), 5 },               /* LM_STATE_WAIT_STOP → LM_STATE_WAIT_STOP */
        { SM_ACT(basic_sm_error_handler), 6 },               /* LM_STATE_PAUSED → LM_STATE_PAUSED */
    },
    [1] = {   /* LM_EVT_SELF_LINKUP_FAIL */
        { SM_ACT(basic_sm_error_handler), 0 },               /* LM_STATE_IDLE → LM_STATE_IDLE */
        { SM_ACT(lm_sm_on_linkup_fail), 1 },                 /* LM_STATE_WAIT_LINK → LM_STATE_WAIT_LINK */
        { SM_ACT(basic_sm_error_handler), 2 },               /* LM_STATE_CONFIGURED → LM_STATE_CONFIGURED */
        { SM_ACT(basic_sm_error_handler), 3 },               /* LM_STATE_WAIT_MAINTAIN → LM_STATE_WAIT_MAINTAIN */
        { SM_ACT(basic_sm_error_handler), 4 },               /* LM_STATE_MAINTAINING → LM_STATE_MAINTAINING */
        { SM_ACT(basic_sm_error_handler), 5 },               /* LM_STATE_WAIT_STOP → LM_STATE_WAIT_STOP */
        { SM_ACT(basic_sm_error_handler), 6 },               /* LM_STATE_PAUSED → LM_STATE_PAUSED */
    },
    [2] = {   /* LM_EVT_SELF_LINKUP_DONE */
        { SM_ACT(basic_sm_error_handler), 0 },               /* LM_STATE_IDLE → LM_STATE_IDLE */
        { SM_ACT(lm_sm_on_linkup_done), 2 },                 /* LM_STATE_WAIT_LINK → LM_STATE_CONFIGURED */
        { SM_ACT(basic_sm_error_handler), 2 },               /* LM_STATE_CONFIGURED → LM_STATE_CONFIGURED */
        { SM_ACT(basic_sm_error_handler), 3 },               /* LM_STATE_WAIT_MAINTAIN → LM_STATE_WAIT_MAINTAIN */
        { SM_ACT(basic_sm_error_handler), 4 },               /* LM_STATE_MAINTAINING → LM_STATE_MAINTAINING */
        { SM_ACT(basic_sm_error_handler), 5 },               /* LM_STATE_WAIT_STOP → LM_STATE_WAIT_STOP */
        { SM_ACT(basic_sm_error_handler), 6 },               /* LM_STATE_PAUSED → LM_STATE_PAUSED */
    },
    [3] = {   /* LM_EVT_STOP_LINK */
        { SM_ACT(lm_sm_on_stop_link), 0 },                   /* LM_STATE_IDLE → LM_STATE_IDLE */
        { SM_ACT(lm_sm_on_stop_link_wait), 1 },              /* LM_STATE_WAIT_LINK → LM_STATE_WAIT_LINK */
        { SM_ACT(lm_sm_on_stop_link), 2 },                   /* LM_STATE_CONFIGURED → LM_STATE_CONFIGURED */
        { SM_ACT(lm_sm_on_stop_link_maintain), 5 },          /* LM_STATE_WAIT_MAINTAIN → LM_STATE_WAIT_STOP */
        { SM_ACT(lm_sm_on_stop_link_maintain), 5 },          /* LM_STATE_MAINTAINING → LM_STATE_WAIT_STOP */
        { SM_ACT(basic_sm_error_handler), 5 },               /* LM_STATE_WAIT_STOP → LM_STATE_WAIT_STOP */
        { SM_ACT(lm_sm_on_stop_link_maintain), 5 },          /* LM_STATE_PAUSED → LM_STATE_WAIT_STOP */
    },
    [4] = {   /* LM_EVT_BF_RESULTS */
        { SM_ACT(sm_action_nop_b), 0 },                      /* LM_STATE_IDLE → LM_STATE_IDLE */
        { SM_ACT(lm_sm_on_bf_results_wait_link), 1 },        /* LM_STATE_WAIT_LINK → LM_STATE_WAIT_LINK */
        { SM_ACT(lm_sm_on_bf_results_configured), 2 },       /* LM_STATE_CONFIGURED → LM_STATE_CONFIGURED */
        { SM_ACT(sm_action_nop_b), 3 },                      /* LM_STATE_WAIT_MAINTAIN → LM_STATE_WAIT_MAINTAIN */
        { SM_ACT(sm_action_nop_b), 4 },                      /* LM_STATE_MAINTAINING → LM_STATE_MAINTAINING */
        { SM_ACT(sm_action_nop_b), 5 },                      /* LM_STATE_WAIT_STOP → LM_STATE_WAIT_STOP */
        { SM_ACT(sm_action_nop_b), 6 },                      /* LM_STATE_PAUSED → LM_STATE_PAUSED */
    },
    [5] = {   /* LM_EVT_START_MAINTAIN_REQ */
        { SM_ACT(basic_sm_error_handler), 0 },               /* LM_STATE_IDLE → LM_STATE_IDLE */
        { SM_ACT(basic_sm_error_handler), 1 },               /* LM_STATE_WAIT_LINK → LM_STATE_WAIT_LINK */
        { SM_ACT(lm_sm_on_start_maintain), 3 },              /* LM_STATE_CONFIGURED → LM_STATE_WAIT_MAINTAIN */
        { SM_ACT(basic_sm_error_handler), 3 },               /* LM_STATE_WAIT_MAINTAIN → LM_STATE_WAIT_MAINTAIN */
        { SM_ACT(basic_sm_error_handler), 4 },               /* LM_STATE_MAINTAINING → LM_STATE_MAINTAINING */
        { SM_ACT(basic_sm_error_handler), 5 },               /* LM_STATE_WAIT_STOP → LM_STATE_WAIT_STOP */
        { SM_ACT(basic_sm_error_handler), 4 },               /* LM_STATE_PAUSED → LM_STATE_MAINTAINING */
    },
    [6] = {   /* LM_EVT_LINK_LOST */
        { SM_ACT(basic_sm_error_handler), 0 },               /* LM_STATE_IDLE → LM_STATE_IDLE */
        { SM_ACT(basic_sm_error_handler), 1 },               /* LM_STATE_WAIT_LINK → LM_STATE_WAIT_LINK */
        { SM_ACT(basic_sm_error_handler), 2 },               /* LM_STATE_CONFIGURED → LM_STATE_CONFIGURED */
        { SM_ACT(lm_sm_on_link_lost), 2 },                   /* LM_STATE_WAIT_MAINTAIN → LM_STATE_CONFIGURED */
        { SM_ACT(lm_sm_on_link_lost), 2 },                   /* LM_STATE_MAINTAINING → LM_STATE_CONFIGURED */
        { SM_ACT(basic_sm_error_handler), 5 },               /* LM_STATE_WAIT_STOP → LM_STATE_WAIT_STOP */
        { SM_ACT(lm_sm_on_link_lost), 2 },                   /* LM_STATE_PAUSED → LM_STATE_CONFIGURED */
    },
    [7] = {   /* LM_EVT_MAINTAIN_STARTED */
        { SM_ACT(basic_sm_error_handler), 0 },               /* LM_STATE_IDLE → LM_STATE_IDLE */
        { SM_ACT(basic_sm_error_handler), 1 },               /* LM_STATE_WAIT_LINK → LM_STATE_WAIT_LINK */
        { SM_ACT(basic_sm_error_handler), 2 },               /* LM_STATE_CONFIGURED → LM_STATE_CONFIGURED */
        { SM_ACT(lm_sm_on_maintain_started), 4 },            /* LM_STATE_WAIT_MAINTAIN → LM_STATE_MAINTAINING */
        { SM_ACT(basic_sm_error_handler), 4 },               /* LM_STATE_MAINTAINING → LM_STATE_MAINTAINING */
        { SM_ACT(basic_sm_error_handler), 5 },               /* LM_STATE_WAIT_STOP → LM_STATE_WAIT_STOP */
        { SM_ACT(basic_sm_error_handler), 6 },               /* LM_STATE_PAUSED → LM_STATE_PAUSED */
    },
    [8] = {   /* LM_EVT_MAINTAIN_STOPPED */
        { SM_ACT(basic_sm_error_handler), 0 },               /* LM_STATE_IDLE → LM_STATE_IDLE */
        { SM_ACT(basic_sm_error_handler), 1 },               /* LM_STATE_WAIT_LINK → LM_STATE_WAIT_LINK */
        { SM_ACT(basic_sm_error_handler), 2 },               /* LM_STATE_CONFIGURED → LM_STATE_CONFIGURED */
        { SM_ACT(basic_sm_error_handler), 3 },               /* LM_STATE_WAIT_MAINTAIN → LM_STATE_WAIT_MAINTAIN */
        { SM_ACT(basic_sm_error_handler), 4 },               /* LM_STATE_MAINTAINING → LM_STATE_MAINTAINING */
        { SM_ACT(lm_sm_on_stop_link), 2 },                   /* LM_STATE_WAIT_STOP → LM_STATE_CONFIGURED */
        { SM_ACT(basic_sm_error_handler), 6 },               /* LM_STATE_PAUSED → LM_STATE_PAUSED */
    },
    [9] = {   /* LM_EVT_PAUSE */
        { SM_ACT(sm_action_nop_b), 0 },                      /* LM_STATE_IDLE → LM_STATE_IDLE */
        { SM_ACT(sm_action_nop_b), 1 },                      /* LM_STATE_WAIT_LINK → LM_STATE_WAIT_LINK */
        { SM_ACT(sm_action_nop_b), 2 },                      /* LM_STATE_CONFIGURED → LM_STATE_CONFIGURED */
        { SM_ACT(sm_action_nop_b), 3 },                      /* LM_STATE_WAIT_MAINTAIN → LM_STATE_WAIT_MAINTAIN */
        { SM_ACT(lm_sm_on_pause), 6 },                       /* LM_STATE_MAINTAINING → LM_STATE_PAUSED */
        { SM_ACT(sm_action_nop_b), 5 },                      /* LM_STATE_WAIT_STOP → LM_STATE_WAIT_STOP */
        { SM_ACT(sm_action_nop_b), 6 },                      /* LM_STATE_PAUSED → LM_STATE_PAUSED */
    },
    [10] = {   /* LM_EVT_LINK_STAT_UPDATE */
        { SM_ACT(basic_sm_error_handler), 0 },               /* LM_STATE_IDLE → LM_STATE_IDLE */
        { SM_ACT(basic_sm_error_handler), 1 },               /* LM_STATE_WAIT_LINK → LM_STATE_WAIT_LINK */
        { SM_ACT(basic_sm_error_handler), 2 },               /* LM_STATE_CONFIGURED → LM_STATE_CONFIGURED */
        { SM_ACT(basic_sm_error_handler), 3 },               /* LM_STATE_WAIT_MAINTAIN → LM_STATE_WAIT_MAINTAIN */
        { SM_ACT(lm_sm_on_link_stat_update), 4 },            /* LM_STATE_MAINTAINING → LM_STATE_MAINTAINING */
        { SM_ACT(basic_sm_error_handler), 5 },               /* LM_STATE_WAIT_STOP → LM_STATE_WAIT_STOP */
        { SM_ACT(lm_sm_on_link_stat_update), 6 },            /* LM_STATE_PAUSED → LM_STATE_PAUSED */
    },
    [11] = {   /* LM_EVT_RESUME_MAINTAIN_REQ */
        { SM_ACT(basic_sm_error_handler), 0 },               /* LM_STATE_IDLE → LM_STATE_IDLE */
        { SM_ACT(sm_action_nop_b), 1 },                      /* LM_STATE_WAIT_LINK → LM_STATE_WAIT_LINK */
        { SM_ACT(sm_action_nop_b), 2 },                      /* LM_STATE_CONFIGURED → LM_STATE_CONFIGURED */
        { SM_ACT(sm_action_nop_b), 3 },                      /* LM_STATE_WAIT_MAINTAIN → LM_STATE_WAIT_MAINTAIN */
        { SM_ACT(sm_action_nop_b), 4 },                      /* LM_STATE_MAINTAINING → LM_STATE_MAINTAINING */
        { SM_ACT(sm_action_nop_b), 5 },                      /* LM_STATE_WAIT_STOP → LM_STATE_WAIT_STOP */
        { SM_ACT(lm_sm_on_resume_maintain), 4 },             /* LM_STATE_PAUSED → LM_STATE_MAINTAINING */
    },
};
/* 0x802da0: описатель lm_sm (состояний 7, событий 12, старт LM_STATE_IDLE); ид [0x10] пишет
 * статический конструктор. Имена — массивы ид строк журнала в fw_data. */
extern const u32 lm_sm_state_names[7];   /* определение ниже */
extern const u32 lm_sm_event_names[12];   /* определение ниже */
FWDATA(802da0) struct sm_desc lm_sm_desc = {
    .n_events = 12, .n_states = 7, .init_state = 0,
    .table = &lm_sm_trans[0][0],
    .state_names = lm_sm_state_names,   /* {LM_STATE_IDLE, LM_STATE_WAIT_LINK, LM_STATE_CONFIGURED, LM_STATE_WAIT_MAINTAIN, LM_STATE_MAINTAINING, LM_STATE_WAIT_STOP, LM_STATE_PAUSED} */
    .event_names = lm_sm_event_names,
};

/* ======================= maintain_sm (0x802cc4) ======================= */

/* mcs__is_restricted (0x8da568, 26 Б). */
static u32 mcs_is_restricted(void)
{
    if (chsw_active_channel != 0)                         /* [gp,-0xc4] */
        return 0;
    return (regd_country_code != 0x4a50) ? 1u : 0u;     /* ldw [gp,0x90] */
}

/* maintain_sm::config_mcs_en_vec (0x8c7000, 68 Б): разрешённые MCS (32 бита полусловами
 * 0x80149e/0x8014a0 — хвост шаблона maintain_rs_cfg): 0x1dde, при ограничении 0x1de, при [0x803c10] — только MCS 4. */
static void maintain_sm_config_mcs_en_vec(void)
{
    u32 r = mcs_is_restricted();
    u32 v = r ? 0x1deu : 0x1ddeu;
    link_mcs_en_vec_lo = (u16)v;
    link_mcs_en_vec_hi = (u16)(v >> 16);
    fw_log_emit1(0x20, 0x1014634, r);
}

/* uses_g_80147c (0x8d97d4, 32 Б): номер младшего разрешённого MCS выше 0 (бит ≥ 1
 * маски). ХРУПКО: пустая маска (кроме бита 0) — бесконечный цикл, как у vendor; маска
 * всегда ставится config_mcs_en_vec непосредственно перед вызовом. */
static u32 mcs_en_vec_first(void)
{
    u32 m = ((u32)link_mcs_en_vec_lo | ((u32)link_mcs_en_vec_hi << 16)) & ~1u;
    u32 n = 0;
    for (;;) {
        n++;
        if (m & 2u)
            return n;
        m >>= 1;
    }
}

/* bf_lt__get_max_goodput (0x8cc3cc, 4 Б). */
static u32 bf_lt_get_max_goodput(void)
{
    return G_LT_MAX_GOODPUT;
}

/* process_expected_bf_results (0x8e11f8, 30 Б): MCS вне маски 0x1dde — журнал. */
static void process_expected_bf_results(struct maintain_sm *m, u32 mcs)
{
    (void)m;
    if (!((0x1ddeu >> (mcs & 31)) & 1u))
        fw_log_emit1(0, 0x1014608, mcs);
}

/* maintain_sm__lt_timer_cb (0x8d9c3c, 14 Б): таймер [M+0x1c] — EVT_TIMER (4). */
void maintain_sm_lt_timer_cb(u32 a0, u32 a1)
{
    struct maintain_sm *m = (struct maintain_sm *)a0;
    (void)a1;
    m->lt_timer = 0;
    maintain_sm_event(m, 4, 0, 0, 0);
}

/* schedule_long_term_trigger (0x8e476c, 188 Б): таймер долгосрочного BF [M+0x1c] —
 * период maintain_lt_period[mcs] (0x801448) × (min(n, 5) + 1) + случайно 0..15 × 3000. */
static void schedule_long_term_trigger(struct maintain_sm *m, u32 mcs, u32 n)
{
    u32 k, t, d;
    if (G_MAINTAIN_PAUSED != 0)
        return;
    k = (n < 5) ? n : 5;
    if (bf_long_term_enable == 0)                         /* [gp,0x248] */
        return;
    if (mcs >= 0xd)
        fw_sysassert_fatal((void *)0, 0x126d);
    if (m->lt_timer != 0) {
        u_schd_cancel(m->lt_timer);
        m->lt_timer = 0;
    }
    t = maintain_lt_period[mcs] * (k + 1);
    if (t == 0)
        return;
    d = (*(volatile u32 *)(HW_RNG_VALUE) & 0xfu) * 3000u + t;   /* hw_rand__below_n(0) */
    fw_log_emit3(0, 0x101454c, mcs, bf_lt_get_max_goodput(), d);
    G_LT_MAX_GOODPUT = 0;                                       /* lt_bf__reset_trigger_period */
    m->lt_timer = u_schd_schedule(maintain_sm_lt_timer_cb, (u32)m, 0, 0, d, 0, 0);
}

static void channels_switch_check_g8004a8(struct maintain_sm *m);

/* Колбэк таймера [M+0x20] (0x8c5ef8, 128 Б): итог окна BF-ответов; при числе ответов ниже
 * порогов ([0x8002c0]/[0x8002c4] или байты 0x80021b/0x80021c по биту 3 [0x803c20]) —
 * проверка, что соединение cid живо (ассерт 0x126c); окно перевзводится всегда. */
void maintain_sm_window_timer_cb(u32 a0, u32 a1)
{
    struct maintain_sm *m = (struct maintain_sm *)a0;
    (void)a1;
    u32 a = m->win_ok, b = m->win_bad, lim1, lim2, f;
    m->win_timer = 0;
    if (a + b != 0) {
        fw_log_emit3(0x20, 0x101471c, m->win_max_mcs, a, b);
        a = m->win_ok;
        b = m->win_bad;
    }
    f = dashboard.cfg.special_flags;
    lim1 = (f & 8u) ? link_bad_first_thr_alt : link_bad_first_thr;
    lim2 = (f & 8u) ? link_bad_thr_alt : link_bad_thr;
    a += b;
    if ((m->win_max_mcs == 1 && a >= lim1) || a >= lim2) {
        if (conn_mgr_by_cid(conn_get_cid_via_field8(m)) == 0)
            fw_sysassert_fatal((void *)0, 0x126c);
    }
    channels_switch_check_g8004a8(m);
}

/* channels_switch__check_g8004a8 (0x8e46f4, 62 Б): перевзвести окно [M+0x20] на
 * [0x8002bc] (не на паузе). */
static void channels_switch_check_g8004a8(struct maintain_sm *m)
{
    if (G_MAINTAIN_PAUSED != 0)
        return;
    if (m->win_timer != 0) {
        u_schd_cancel(m->win_timer);
        m->win_timer = 0;
    }
    m->win_max_mcs = 1;
    m->win_ok = 0;
    m->win_bad = 0;
    m->win_timer = u_schd_schedule(maintain_sm_window_timer_cb, (u32)m, 0, 0,
                                   link_bad_win_period, 0, 0);
}

/* Колбэк выделения радио для BF (0x8c5e48, 28 Б): радио получено — BF. */
void maintain_sm_radio_locked_cb(struct rm_req *req, u32 arg)
{
    struct maintain_sm *m = (struct maintain_sm *)arg;
    (void)req;
    if (m->radio_req == 0)
        return;
    m->radio_locked = 1;
    lmac_if_trigger_bf((u8)conn_get_cid_of_obj(m->lm_sm), 0);
}

/* maintain_sm__lock_radio (0x8e2904, 40 Б): запросить радио (request_primary) под BF. */
static void maintain_sm_lock_radio(struct maintain_sm *m)
{
    if (m->radio_req != 0)
        return;
    m->radio_req = radio_mgr_request_primary(maintain_sm_radio_locked_cb, (u32)m,
                                             (u8)lm_sm_get_mid_idx(m->lm_sm));
    m->radio_locked = 0;
}

/* Тело maintain_sm::release_radio_after_bf_evt (действие ниже, 50 Б): вернуть радио BF. */
static void maintain_sm_release_radio(struct maintain_sm *m)
{
    struct rm_req *r = m->radio_req;
    if (r == 0)
        return;
    if (m->radio_locked == 0) {
        fw_log_emit1(0x20, 0x1014588, (u32)r);
        radio_mgr_remove_request(m->radio_req);
    } else {
        radio_mgr_call_method_10(r);
    }
    m->radio_req = 0;
    m->radio_locked = 0;
}

/* WBE_DRIVER::CLOSE (0x8f9b68, 28 Б): [0x882a74] = 2. */
static void wbe_driver_close(void)
{
    fw_log_emit0(0x2f, 0x1002f98);
    MMIO32(HW_WBE_CLOSE_CTL) = 2;
}

/* l2_mgr__chk_sys_idle [0x8c6508] — копия static из l2mgr.c: 1, если ни у одного
 * открытого mid нет активных соединений. */
static u32 link_chk_sys_idle(void)
{
    u32 it, idle = 1;
    field_set_0x00_8e5dfc(&it, mids_get_count());
    while (bit_iter_has_more(&it)) {
        struct mid *e = mid_list_by_mid_fw(bitmap_alloc_bit(&it));
        if (e == 0)
            fw_sysassert_fatal((void *)0, 0x16c5);
        if (mid_count_active_conns(e) != 0)
            idle = 0;
    }
    return idle;
}

/* uses_g_80147c__8f234c (0x8f234c, 82 Б): остановка сопровождения — соседи выкл., маска
 * MCS, LMAC 0x13 {cid, 0, маска}; система простаивает — LMAC 0x14 с нулями. */
static void maintain_sm_stop_lmac(struct maintain_sm *m)
{
    u32 cid;
    lmac_if_send_selective_neighbor_cfg(0, 0, 0, 0);
    maintain_sm_config_mcs_en_vec();
    cid = (u8)conn_get_cid_of_obj(m->lm_sm);
    lmac_if_send_cmd_0x13(cid, 0);
    if (link_chk_sys_idle() != 0)
        lmac_if_send_cmd_0x14((u8)conn_get_cid_of_obj(m->lm_sm), 0, 0, 0, 0, 0, 0);
}

/* maintain_sm__action_8f96c4 (0x8f96c4): EVT_START_MAINTAIN в STOPPED. */
void maintain_sm_on_start(struct maintain_sm *m)
{
    struct mid *e;
    u32 st;
    m->hdr.trace = 1;
    e = mid_list_by_mid_fw(lm_sm_get_mid_idx(m->lm_sm));
    st = e->bss.mode;
    {
        /* записи — в порядке vendor (0x7c, 0x1c..0x78, пауза, 0x80): volatile, иначе gcc
         * переставляет их относительно записи глобала */
        volatile struct maintain_sm *vm = m;
        vm->mid_ap = (st == 2 || st == 3) ? 1u : 0u;
        vm->lt_timer = 0;
        vm->win_timer = 0;
        vm->radio_req = 0;
        vm->radio_locked = 0;
        vm->lt_fails = 0;
        G_MAINTAIN_PAUSED = 0;
        vm->lt_paused = 0;
    }
    obj_vt802cc4_noop_vmethod(m);
    lmac_if_send_cmd_0x0f((u8)conn_get_cid_of_obj(m->lm_sm), 1);
    m->fbf_tries = 0;
    if (m->rs_mode != 1)
        maintain_sm_lock_radio(m);
}

/* maintain_sm__action_8c48f8 (0x8c48f8): EVT_BF_RESULTS в BEFORE_FIRST_FBF — успех
 * (res->status == 1) → отложенное SELF_FIRST_FBF_SUCCESS (6); иначе повтор BF до
 * [0x800251] попыток, затем SELF_FBF_FAIL (5). */
void maintain_sm_on_bf_results_first(struct maintain_sm *m, const struct lmac_evt_bf_done *res)
{
    if (res->status == 1) {
        maintain_sm_release_radio(m);
        maintain_sm_defer(m, 6, 0, 0, 0);
        return;
    }
    if (m->rs_mode == 1)
        return;
    m->fbf_tries = (u8)(m->fbf_tries + 1);
    if (m->fbf_tries == link_first_fbf_max_tries) {        /* ldb_s [gp,0xcd] */
        maintain_sm_release_radio(m);
        maintain_sm_defer(m, 5, 0, 0, 0);
        return;
    }
    lmac_if_trigger_bf((u8)conn_get_cid_of_obj(m->lm_sm), 0);
}

/* maintain_sm__action_8c494c (0x8c494c): EVT_BF_RESULTS в FBF_DONE/ACTIVE — счётчики
 * окна; неудача — долгосрочный BF. */
void maintain_sm_on_bf_results(struct maintain_sm *m, const struct lmac_evt_bf_done *res)
{
    u32 r;
    maintain_sm_release_radio(m);
    r = res->status;
    if (r == 2) {
        m->win_bad += 1;
        fw_log_emit1(0x20, 0x10145c8, m->win_bad);
    } else if (r == 1) {
        m->win_ok += 1;
        m->lt_fails = 0;
    } else {
        m->mcs = 0;
        m->win_bad += 1;
        m->lt_fails += 1;
        schedule_long_term_trigger(m, 0, m->lt_fails);
    }
}

/* maintain_sm__action_8f2dc8 (0x8f2dc8): EVT_SELF_FBF_FAIL — остановить, вернуть радио,
 * событие 6 (SELF_LINKUP_FAIL) lm_sm. */
void maintain_sm_on_fbf_fail(struct maintain_sm *m)
{
    if (m->lt_timer != 0) {
        u_schd_cancel(m->lt_timer);
        m->lt_timer = 0;
    }
    maintain_sm_stop_lmac(m);
    if (m->radio_req != 0) {
        fw_log_emit1(0x2c, 0x10146b4, (u32)m->radio_req);
        radio_mgr_call_method_10(m->radio_req);
        m->radio_req = 0;
    }
    lm_sm_event(m->lm_sm, 6, 0, 0, 0);
}

/* maintain_sm__action_8f2f0c (0x8f2f0c): EVT_SELF_FIRST_FBF_SUCCESS — запуск статистики
 * (S, событие 0), MAINTAIN_STARTED (7) lm_sm, LMAC 0x14 и сразу EVT_TIMER (→ ACTIVE). */
void maintain_sm_on_first_fbf_success(struct maintain_sm *m)
{
    u32 a2, a1;
    if (m->lt_timer != 0)
        return;
    (void)mid_list_by_mid_fw(lm_sm_get_mid_idx(m->lm_sm));
    link_stats_event(&m->stats, 0, 0, 0, 0);
    lm_sm_event(m->lm_sm, 7, 0, 0, 0);
    process_expected_bf_results(m, m->mcs);
    fw_log_emit0(0x20, 0x1014668);
    a1 = 1;                              /* OOB R1 (только SparRAW-pro): 0 */
    a2 = m->rs_mode == 0 ? 1u : 0u;
    lmac_if_send_cmd_0x14((u8)conn_get_cid_of_obj(m->lm_sm), a1, a2, a1, a1, a1, a1);
    m->txss_timeout = G_TXSS_TIMEOUT;
    maintain_sm_lt_timer_cb((u32)m, 0);                                 /* field_set_0x1c__8d9c3c */
}

/* maintain_sm__action_8cab64 (0x8cab64): EVT_TIMER в FBF_DONE → ACTIVE. */
void maintain_sm_on_timer_fbf_done(struct maintain_sm *m)
{
    fw_log_emit0(0x20, 0x10146e8);
    maintain_sm_config_mcs_en_vec();
    MMIO32(HW_FW_BF_MCS) = mcs_en_vec_first();   /* bf_mcs (REGS-KNOWN); в hw.h это BL_SHUTDOWN_HS */
    lmac_if_send_cmd_0x13((u8)conn_get_cid_of_obj(m->lm_sm), 1);
    lmac_if_send_selective_neighbor_cfg(0, 0, 0, 0);
    maintain_sm_lock_radio(m);
    if (link_bad_win_enable != 0)                          /* ldb_s [gp,0xa6] */
        channels_switch_check_g8004a8(m);
    wbe_driver_close();
    m->hdr.trace = 0;
}

/* maintain_sm__action_8dcf84 (0x8dcf84): EVT_TIMER в ACTIVE — BF по таймеру. */
void maintain_sm_on_timer_active(struct maintain_sm *m)
{
    fw_log_emit1(0x20, 0x1014688, bf_lt_get_max_goodput());
    maintain_sm_lock_radio(m);
}

/* maintain_sm__action_8cdbd8 (0x8cdbd8): EVT_RS_RESULTS в ACTIVE. */
void maintain_sm_on_rs_results(struct maintain_sm *m, const struct lmac_rs_result *res)
{
    if (res->status == 0) {
        u32 mcs = res->mcs;
        m->mcs = (u8)mcs;
        process_expected_bf_results(m, mcs);
        mcs = m->mcs;
        m->lt_fails = 0;
        if (m->win_max_mcs <= mcs)
            m->win_max_mcs = mcs;
        schedule_long_term_trigger(m, mcs, 0);
    } else {
        m->mcs = 1;
        m->win_bad += 1;
        m->lt_fails += 1;
    }
}

/* maintain_sm__action_8c7348 (0x8c7348): EVT_CONSECUTIVE_HIGH_PER — при [0x8002e8]
 * проверить, что соединение cid живо (ассерт 0x126b). */
void maintain_sm_on_high_per(struct maintain_sm *m)
{
    if (link_high_per_check_en == 0)                         /* ld.as [gp,89] */
        return;
    if (conn_mgr_by_cid(conn_get_cid_via_field8(m)) == 0)
        fw_sysassert_fatal((void *)0, 0x126b);
}

/* maintain_sm__action_8e0004 (0x8e0004): EVT_PAUSE в ACTIVE. */
void maintain_sm_on_pause(struct maintain_sm *m)
{
    if (G_MAINTAIN_PAUSED != 0)
        return;
    G_MAINTAIN_PAUSED = 1;
    {
        /* vendor: пауза, чтение таймера, затем lt_paused = 0 — volatile, иначе gcc ставит
         * запись поля раньше записи глобала */
        volatile struct maintain_sm *vm = m;
        u32 t = vm->lt_timer;
        vm->lt_paused = 0;
        if (t != 0) {
            u_schd_cancel(t);
            vm->lt_timer = 0;
            vm->lt_paused = 1;
        }
    }
    if (m->win_timer != 0) {
        u_schd_cancel(m->win_timer);
        m->win_timer = 0;
    }
    link_stats_event(&m->stats, 4, 0, 0, 0);
}

/* maintain_sm::release_radio_after_bf_evt (0x8e2520): EVT_BF_RESULTS в STOPPED. */
void maintain_sm_release_radio_after_bf_evt(struct maintain_sm *m)
{
    maintain_sm_release_radio(m);
}

/* maintain_sm__action_8e2b9c (0x8e2b9c): EVT_RESUME_MAINTAIN в ACTIVE. */
void maintain_sm_on_resume(struct maintain_sm *m)
{
    if (G_MAINTAIN_PAUSED == 0)
        return;
    G_MAINTAIN_PAUSED = 0;
    link_stats_event(&m->stats, 5, 0, 0, 0);
    if (m->lt_paused != 0) {
        schedule_long_term_trigger(m, m->mcs, m->lt_fails);
        m->lt_paused = 0;
    }
    if (link_bad_win_enable != 0)
        channels_switch_check_g8004a8(m);
}

/* maintain_sm__action_8f9a78 (0x8f9a78): EVT_STOP — LMAC-останов, таймеры, радио;
 * STOP (3) статистике, событие 8 lm_sm. */
void maintain_sm_on_stop(struct maintain_sm *m)
{
    G_MAINTAIN_PAUSED = 0;
    maintain_sm_stop_lmac(m);
    if (m->lt_timer != 0) {
        u_schd_cancel(m->lt_timer);
        m->lt_timer = 0;
    }
    if (m->win_timer != 0) {
        u_schd_cancel(m->win_timer);
        m->win_timer = 0;
    }
    maintain_sm_release_radio(m);
    link_stats_event(&m->stats, 3, 0, 0, 0);
    lm_sm_event(m->lm_sm, 8, 0, 0, 0);
}

/* 0x802cd8: таблица переходов maintain_sm [событие][состояние] (событий 10, состояний 4) —
 * {действие, следующее состояние}; комментарий — «состояние → следующее» по vendor-именам. */
FWDATA(802cd8) const struct sm_trans maintain_sm_trans[10][4] = {
    [0] = {   /* EVT_START_MAINTAIN */
        { SM_ACT(maintain_sm_on_start), 1 },                 /* STOPPED → BEFORE_FIRST_FBF */
        { SM_ACT(basic_sm_error_handler), 1 },               /* BEFORE_FIRST_FBF → BEFORE_FIRST_FBF */
        { SM_ACT(basic_sm_error_handler), 2 },               /* FBF_DONE → FBF_DONE */
        { SM_ACT(basic_sm_error_handler), 3 },               /* ACTIVE → ACTIVE */
    },
    [1] = {   /* EVT_BF_RESULTS */
        { SM_ACT(maintain_sm_release_radio_after_bf_evt), 0 }, /* STOPPED → STOPPED */
        { SM_ACT(maintain_sm_on_bf_results_first), 1 },      /* BEFORE_FIRST_FBF → BEFORE_FIRST_FBF */
        { SM_ACT(maintain_sm_on_bf_results), 2 },            /* FBF_DONE → FBF_DONE */
        { SM_ACT(maintain_sm_on_bf_results), 3 },            /* ACTIVE → ACTIVE */
    },
    [2] = {   /* EVT_RS_RESULTS */
        { SM_ACT(sm_action_nop_b), 0 },                      /* STOPPED → STOPPED */
        { SM_ACT(sm_action_nop_b), 1 },                      /* BEFORE_FIRST_FBF → BEFORE_FIRST_FBF */
        { SM_ACT(sm_action_nop_b), 2 },                      /* FBF_DONE → FBF_DONE */
        { SM_ACT(maintain_sm_on_rs_results), 3 },            /* ACTIVE → ACTIVE */
    },
    [3] = {   /* EVT_STOP */
        { SM_ACT(basic_sm_error_handler), 0 },               /* STOPPED → STOPPED */
        { SM_ACT(maintain_sm_on_stop), 0 },                  /* BEFORE_FIRST_FBF → STOPPED */
        { SM_ACT(maintain_sm_on_stop), 0 },                  /* FBF_DONE → STOPPED */
        { SM_ACT(maintain_sm_on_stop), 0 },                  /* ACTIVE → STOPPED */
    },
    [4] = {   /* EVT_TIMER */
        { SM_ACT(basic_sm_error_handler), 0 },               /* STOPPED → STOPPED */
        { SM_ACT(basic_sm_error_handler), 1 },               /* BEFORE_FIRST_FBF → BEFORE_FIRST_FBF */
        { SM_ACT(maintain_sm_on_timer_fbf_done), 3 },        /* FBF_DONE → ACTIVE */
        { SM_ACT(maintain_sm_on_timer_active), 3 },          /* ACTIVE → ACTIVE */
    },
    [5] = {   /* EVT_SELF_FBF_FAIL */
        { SM_ACT(basic_sm_error_handler), 0 },               /* STOPPED → STOPPED */
        { SM_ACT(maintain_sm_on_fbf_fail), 0 },              /* BEFORE_FIRST_FBF → STOPPED */
        { SM_ACT(basic_sm_error_handler), 2 },               /* FBF_DONE → FBF_DONE */
        { SM_ACT(basic_sm_error_handler), 3 },               /* ACTIVE → ACTIVE */
    },
    [6] = {   /* EVT_SELF_FIRST_FBF_SUCCESS */
        { SM_ACT(basic_sm_error_handler), 0 },               /* STOPPED → STOPPED */
        { SM_ACT(maintain_sm_on_first_fbf_success), 2 },     /* BEFORE_FIRST_FBF → FBF_DONE */
        { SM_ACT(basic_sm_error_handler), 2 },               /* FBF_DONE → FBF_DONE */
        { SM_ACT(basic_sm_error_handler), 3 },               /* ACTIVE → ACTIVE */
    },
    [7] = {   /* EVT_CONSECUTIVE_HIGH_PER */
        { SM_ACT(sm_action_nop_b), 0 },                      /* STOPPED → STOPPED */
        { SM_ACT(sm_action_nop_b), 1 },                      /* BEFORE_FIRST_FBF → BEFORE_FIRST_FBF */
        { SM_ACT(sm_action_nop_b), 2 },                      /* FBF_DONE → FBF_DONE */
        { SM_ACT(maintain_sm_on_high_per), 3 },              /* ACTIVE → ACTIVE */
    },
    [8] = {   /* EVT_PAUSE */
        { SM_ACT(basic_sm_error_handler), 0 },               /* STOPPED → STOPPED */
        { SM_ACT(basic_sm_error_handler), 1 },               /* BEFORE_FIRST_FBF → BEFORE_FIRST_FBF */
        { SM_ACT(basic_sm_error_handler), 2 },               /* FBF_DONE → FBF_DONE */
        { SM_ACT(maintain_sm_on_pause), 3 },                 /* ACTIVE → ACTIVE */
    },
    [9] = {   /* EVT_RESUME_MAINTAIN */
        { SM_ACT(sm_action_nop_b), 0 },                      /* STOPPED → STOPPED */
        { SM_ACT(sm_action_nop_b), 1 },                      /* BEFORE_FIRST_FBF → BEFORE_FIRST_FBF */
        { SM_ACT(sm_action_nop_b), 2 },                      /* FBF_DONE → FBF_DONE */
        { SM_ACT(maintain_sm_on_resume), 3 },                /* ACTIVE → ACTIVE */
    },
};
/* 0x802cc4: описатель maintain_sm (состояний 4, событий 10, старт STOPPED); ид [0x10] пишет
 * статический конструктор. Имена — массивы ид строк журнала в fw_data. */
extern const u32 maintain_sm_state_names[4];   /* определение ниже */
extern const u32 maintain_sm_event_names[10];   /* определение ниже */
FWDATA(802cc4) struct sm_desc maintain_sm_desc = {
    .n_events = 10, .n_states = 4, .init_state = 0,
    .table = &maintain_sm_trans[0][0],
    .state_names = maintain_sm_state_names,   /* {STOPPED, BEFORE_FIRST_FBF, FBF_DONE, ACTIVE} */
    .event_names = maintain_sm_event_names,
};

/* ======================= sm_802f58: статистика линка ======================= */

/* 0x8004dc: имена состояний LINK_STATS_SM (описатель 0x802f58), include/link_sm.h. */
FWDATA(8004dc) const u32 link_stats_sm_state_names[2] = {
    0x1020598,   /* IDLE */
    0x102059d,   /* ACTIVE */
};

/* Блоки счётчиков MAC (include/mac_cnt.h): [0x8003d0] — RX, [0x8003d4] — TX. */

/* link_stats__counter64_a_thunk (0x8ccb64 → 0x8dd798): RX u64 [+0xbc]. */
static u64 link_stats_counter64_rx(void)
{
    struct mac_rx_cnt *b = mac_rx_cnt_blk;
    return (u64)b->cnt64_lo | ((u64)b->cnt64_hi << 32);
}

/* link_stats__counter64_b_thunk (0x8ccf78 → 0x8dd7a4): TX u64 [+0x14]. */
static u64 link_stats_counter64_tx(void)
{
    struct mac_tx_cnt *b = mac_tx_cnt_blk;
    return (u64)b->cnt64_lo | ((u64)b->cnt64_hi << 32);
}

/* mac_rx_cnt__get_mcs0_crc_err (0x8dd77c) / _ok (0x8dd784). */
static u32 mac_rx_cnt_mcs0_crc_err(void)
{
    return mac_rx_cnt_blk->crc_err_mcs[0];
}

static u32 mac_rx_cnt_mcs0_crc_ok(void)
{
    return mac_rx_cnt_blk->crc_ok_mcs[0];
}

/* mac_tx_cnt__delta_10_since_base (0x8dd78c, 12 Б). */
static u32 mac_tx_cnt_delta_10_since_base(void)
{
    return mac_tx_cnt_blk->cnt_10 - pring_tx_cnt_base_10;
}

/* Таймер задержки статистики [S+8] (0x8d9c0c): EVT_LATENCY_TIMER (1). */
void link_stats_latency_timer_cb(u32 a0, u32 a1)
{
    struct link_stats_sm *s = (struct link_stats_sm *)a0;
    (void)a1;
    s->latency_timer = 0;
    link_stats_event(s, 1, 0, 0, 0);
}

/* Таймер отчёта статистики [S+0xc] (0x8d9c2c): EVT_STATS_TIMER (2). */
void link_stats_report_timer_cb(u32 a0, u32 a1)
{
    struct link_stats_sm *s = (struct link_stats_sm *)a0;
    (void)a1;
    s->report_timer = 0;
    link_stats_event(s, 2, 0, 0, 0);
}

/* link_stats_sm__arm_latency_timer (0x8e4734, 54 Б): период [0x8003c0]. */
static void link_stats_arm_latency_timer(struct link_stats_sm *s)
{
    if (s->latency_timer != 0)
        fw_sysassert_fatal((void *)0, 0x1257);
    s->latency_timer = u_schd_schedule(link_stats_latency_timer_cb, (u32)s, 0, 0,
                                       link_stats_latency_period, 0, 0);
}

/* link_stats_sm__arm_report_timer (0x8e4910, 58 Б): 100 мс. */
static void link_stats_arm_report_timer(struct link_stats_sm *s)
{
    if (s->report_timer != 0)
        fw_sysassert_fatal((void *)0, 0x1258);
    s->report_timer = u_schd_schedule(link_stats_report_timer_cb, (u32)s, 0, 0, 100000, 0, 0);
}

/* uses_tbl_805260__8dd6d4 (0x8dd6d4, 130 Б): кольцо 32 отметок 0x805260, заголовок
 * 0x8052e0 {число, голова, хвост} (байты). В хвост — счётчик TX [+0x10] с базы; из
 * головы выбрасываются отметки не новее текущего значения delta_88. */
struct link_stats_ts_ring {
    u32 ts[32];                                /* 0x00: отметки (индекс & 0x1f) */
    u8  cnt;                                   /* 0x80: число отметок */
    u8  head;                                  /* 0x81 */
    u8  tail;                                  /* 0x82 */
    u8  rsv_83;
};
_Static_assert(sizeof(struct link_stats_ts_ring) == 0x84, "link_stats_ts_ring");
FWDATA(805260) volatile struct link_stats_ts_ring link_stats_ts_ring = { 0 };

static void link_stats_ts_ring_update(struct link_stats_sm *s, struct link_stats_sm *o)
{
    volatile struct link_stats_ts_ring *r = &link_stats_ts_ring;
    u32 cur, head, tail, n;
    (void)s;
    r->ts[r->tail & 0x1f] = mac_tx_cnt_delta_10_since_base();
    cur = mac_tx_cnt_delta_88_net_of_20();
    (void)conn_get_cid_via_field8(o->msm);          /* vendor: результат не нужен */
    head = r->head;
    tail = r->tail;
    for (n = (u8)(tail - head); n != 0; n--) {
        u32 v = r->ts[head & 0x1f];
        if ((s32)(v - cur) >= 0 && v != cur)
            break;
        head = (u8)(head + 1);
    }
    r->cnt = (u8)(tail - head);
    tail = (u8)(tail + 1);
    r->tail = (u8)tail;
    r->head = (u8)head;
    if (((tail - head) & 0x1f) == 0)
        r->head = (u8)(head + 1);
}

/* sm_802f58__on_evt_latency_timer_in_active (0x8da73c): отметка и перевзвод (a == 0). */
void link_stats_on_latency_timer(struct link_stats_sm *s, u32 a)
{
    link_stats_ts_ring_update(s, s);
    if (a == 0)
        link_stats_arm_latency_timer(s);
}

/* link_stats__calc_goodput (0x8c5468, 74 Б): PER % по счётчикам TX ok/fail (0xffffffff
 * без кадров), total — число кадров с прошлого раза. */
static void link_stats_calc_goodput(struct link_stats_sm *s, u32 *per, u32 *total)
{
    u32 ok0 = s->tx_ok, fail0 = s->tx_fail, ok, fail, n, p;
    ok = mac_tx_cnt_get_ok();
    s->tx_ok = ok;
    fail = mac_tx_cnt_get_fail();
    s->tx_fail = fail;
    n = (s->tx_ok - ok0) + (fail - fail0);
    p = (n == 0) ? 0xffffffffu : ((fail - fail0) * 100u) / n;
    *per = p;
    *total = n;
}


/* link_stats__report (0x8e7cf8, 358 Б): TX/RX goodput (байты << 3 / время), PER, LED,
 * раз в 100 отчётов — журнал MCS0 CRC и PHY; PER > 90 % пять раз подряд — BF.
 * a == 0 — перевзвести таймер отчёта. Регистры 0x880a58/5c/6c — значения для хоста. */
void link_stats_report(struct link_stats_sm *s, u32 a)
{
    u32 cid = (u8)conn_get_cid_via_field8(s->msm);
    u32 now = u_schd_now();
    u64 tx = link_stats_counter64_tx();
    u64 rx = link_stats_counter64_rx();
    u32 dt, per, total, sum;
    u64 old;
    /* vendor здесь же переключал ASPM L1 по простою DMA (stats_timer_exp) — энергосбережение PCIe вырезано (см. fw/vectors.c pcie_pm_event_unsupported) */
    dt = (now - s->last_time) << 4;
    old = (u64)s->tx_base[0] | ((u64)s->tx_base[1] << 32);
    s->tx_goodput = (u32)((s64)((tx - old) << 3) / (s64)(u64)dt);
    MMIO32(HW_FW_TX_GOODPUT) = s->tx_goodput;   /* tx_goodput (REGS-KNOWN); в hw.h BL_ASSERT_CODE */
    old = (u64)s->rx_base[0] | ((u64)s->rx_base[1] << 32);
    s->rx_goodput = (u32)((s64)((rx - old) << 3) / (s64)(u64)dt);
    MMIO32(HW_FW_RX_GOODPUT) = s->rx_goodput;   /* rx_goodput (REGS-KNOWN); в hw.h BL_ASSERT_BLINK */
    link_stats_calc_goodput(s, &per, &total);
    s->snap_853924 = VOL(fw_stats_dash.rx_ppdu);
    MMIO32(HW_LINK_PER) = per;
    /* vendor: базы — до максимума goodput, tx_goodput читается дважды (после записи
     * максимума) — volatile, иначе gcc переставляет записи и сливает чтения */
    {
        volatile struct link_stats_sm *vs = s;
        u32 g, mx;
        vs->last_time = now;
        vs->tx_base[0] = (u32)tx;
        vs->tx_base[1] = (u32)(tx >> 32);
        vs->rx_base[0] = (u32)rx;
        vs->rx_base[1] = (u32)(rx >> 32);
        mx = G_LT_MAX_GOODPUT;                                /* максимум TX goodput */
        g = vs->tx_goodput;
        G_LT_MAX_GOODPUT = (mx > g) ? mx : g;
        /* tail_led_scheme__apply (0x8da8cc): схема LED по суммарному goodput. */
        sum = vs->rx_goodput + vs->tx_goodput;
    }
    if (sum > led_rate_thr_high)
        led_scheme_apply(3);
    else
        led_scheme_apply(sum > led_rate_thr_low ? 2 : 1);
    s->report_cnt = (u8)(s->report_cnt + 1);
    if (s->report_cnt == 100) {
        u32 ok = mac_rx_cnt_mcs0_crc_ok();
        u32 err = mac_rx_cnt_mcs0_crc_err();
        fw_log_emit3(0x20, 0x1014e3c, cid, ok, err);
        fw_log_emit3(0x20, 0x1014e7c, MMIO32(HW_FW_TX_GOODPUT), MMIO32(HW_FW_RX_GOODPUT), per);
        /* link_stats__phy_counters (0x8d27d8): два счётчика PHY в журнал. */
        fw_log_emit2(0x20, 0x101db34, MMIO32(HW_PHY_CRC_ERROR_COUNTER_CP), MMIO32(HW_PHY_CRC_ERROR_COUNTER_SC));
        s->report_cnt = 0;
    }
    if (per > 0x5a && per != 0xffffffffu) {
        u32 c = (u8)(s->high_per_cnt + 1);
        s->high_per_cnt = (u8)c;
        if (c >= 5) {
            fw_log_emit3(0, 0x1014eac, per, c, cid);
            s->high_per_cnt = 0;
            maintain_sm_lock_radio(s->msm);
        }
    } else {
        s->high_per_cnt = 0;
    }
    if (a == 0)
        link_stats_arm_report_timer(s);
}

/* sm_802f58__action_8e774c (0x8e774c): EVT_START — базы счётчиков, таймеры, LED 1,
 * кольцо отметок и максимум goodput обнулены. */
void link_stats_on_start(struct link_stats_sm *s)
{
    u64 v;
    s->last_time = u_schd_now();
    v = link_stats_counter64_tx();
    s->tx_base[0] = (u32)v;
    s->tx_base[1] = (u32)(v >> 32);
    v = link_stats_counter64_rx();
    s->rx_base[0] = (u32)v;
    s->rx_base[1] = (u32)(v >> 32);
    s->tx_ok = mac_tx_cnt_get_ok();
    s->tx_fail = mac_tx_cnt_get_fail();
    s->snap_853924 = VOL(fw_stats_dash.rx_ppdu);
    fw_log_emit0(0x20, 0x1014ee4);
    s->hdr.trace = 0;
    link_stats_arm_latency_timer(s);
    link_stats_arm_report_timer(s);
    led_scheme_apply(1);
    memset0_words((void *)&link_stats_ts_ring, sizeof(link_stats_ts_ring));
    memset0_words((void *)&lt_bf_max_goodput, 4);
    s->report_cnt = 0;
}

static void link_stats_cancel_timers(struct link_stats_sm *s)
{
    if (s->latency_timer != 0) {
        u_schd_cancel(s->latency_timer);
        s->latency_timer = 0;
    }
    if (s->report_timer != 0) {
        u_schd_cancel(s->report_timer);
        s->report_timer = 0;
    }
}

/* sm_802f58__action_8e0048 (0x8e0048): EVT_PAUSE — таймеры сняты, последний отчёт. */
void link_stats_on_pause(struct link_stats_sm *s)
{
    link_stats_cancel_timers(s);
    link_stats_on_latency_timer(s, 1);
    link_stats_report(s, 1);
}

/* sm_802f58__action_8e2be4 (0x8e2be4): EVT_RESUME — отметка и отчёт с перевзводом. */
void link_stats_on_resume(struct link_stats_sm *s)
{
    link_stats_on_latency_timer(s, 0);
    link_stats_report(s, 0);
}

/* sm_802f58__action_8e7e60 (0x8e7e60): EVT_STOP — таймеры сняты, LED 4. */
void link_stats_on_stop(struct link_stats_sm *s)
{
    s->hdr.trace = 1;
    link_stats_cancel_timers(s);
    led_scheme_apply(4);
}

/* 0x802f6c: таблица переходов link_stats_sm [событие][состояние] (событий 6, состояний 2) —
 * {действие, следующее состояние}; комментарий — «состояние → следующее» по vendor-именам. */
FWDATA(802f6c) const struct sm_trans link_stats_sm_trans[6][2] = {
    [0] = {   /* EVT_START */
        { SM_ACT(link_stats_on_start), 1 },                  /* IDLE → ACTIVE */
        { SM_ACT(basic_sm_error_handler), 1 },               /* ACTIVE → ACTIVE */
    },
    [1] = {   /* EVT_LATENCY_TIMER */
        { SM_ACT(sm_action_nop_b), 0 },                      /* IDLE → IDLE */
        { SM_ACT(link_stats_on_latency_timer), 1 },          /* ACTIVE → ACTIVE */
    },
    [2] = {   /* EVT_STATS_TIMER */
        { SM_ACT(sm_action_nop_b), 0 },                      /* IDLE → IDLE */
        { SM_ACT(link_stats_report), 1 },                    /* ACTIVE → ACTIVE */
    },
    [3] = {   /* EVT_STOP */
        { SM_ACT(sm_action_nop_b), 0 },                      /* IDLE → IDLE */
        { SM_ACT(link_stats_on_stop), 0 },                   /* ACTIVE → IDLE */
    },
    [4] = {   /* EVT_PAUSE */
        { SM_ACT(sm_action_nop_b), 0 },                      /* IDLE → IDLE */
        { SM_ACT(link_stats_on_pause), 0 },                  /* ACTIVE → IDLE */
    },
    [5] = {   /* EVT_RESUME */
        { SM_ACT(link_stats_on_resume), 1 },                 /* IDLE → ACTIVE */
        { SM_ACT(basic_sm_error_handler), 1 },               /* ACTIVE → ACTIVE */
    },
};
/* 0x802f58: описатель link_stats_sm (состояний 2, событий 6, старт IDLE); ид [0x10] пишет
 * статический конструктор. Имена — массивы ид строк журнала в fw_data. */
extern const u32 link_stats_sm_event_names[6];   /* определение ниже */
FWDATA(802f58) struct sm_desc link_stats_sm_desc = {
    .n_events = 6, .n_states = 2, .init_state = 0,
    .table = &link_stats_sm_trans[0][0],
    .state_names = link_stats_sm_state_names,   /* {IDLE, ACTIVE} */
    .event_names = link_stats_sm_event_names,
};

/* ======================= сброс TX соединения ======================= */

/* TX_API::callback_and_release (0x8c5a8c, 122 Б): снять кадр из «ждущих» (статус 0xff),
 * колбэк sent_cb(sent_info, 0); затем обработчик завершения done(буфер, статус,
 * соединение) или освобождение буфера. */
static void tx_api_callback_and_release(struct tx_pkt *pkt)
{
    fw_log_emit1(0x27, 0x1018220, (u32)pkt);
    if (pkt == 0)
        fw_sysassert_fatal((void *)0, 0x11d6);
    pkt->status = 0xff;
    tx_list_remove(&tx_pending, pkt);
    FWQ_TX_AVAILABILITY_remove_packet(pkt->cid, TX_PKT_PRIO(pkt));
    if (pkt->sent_cb != 0) {
        pkt->sent_cb(pkt->sent_info, 0);
        pkt->sent_cb = 0;
    }
    tx_done_fn done = pkt->done;                   /* одно чтение [pkt+0x20] */
    if (done != 0) {
        struct conn *conn = conn_mgr_by_cid(pkt->cid);
        done((u32)pkt->payload, pkt->status, (u32)conn);
    } else {
        TX_API_free_memory((u32)pkt->payload);
    }
}

/* TX_API::flush_pending_peer_pm_connection (0x8cad48, 122 Б): выбросить «ждущие» кадры
 * cid; освобождение на шаг позже обхода (итератор не должен стоять на удалённом). */
static void tx_api_flush_pending_peer_pm_connection(u32 cid)
{
    u32 it;
    struct tx_pkt *prev = 0;
    fw_log_emit1(0x27, 0x1018250, cid);
    iter_init(&it, &tx_pending);
    while (list_has_items(&it)) {
        struct tx_pkt *p = iter_next(&it);
        fw_log_emit1(0x27, 0x10182c8, p->cid);
        if (prev != 0) {
            tx_api_callback_and_release(prev);
            prev = 0;
        }
        if (p->cid == cid) {
            fw_log_emit1(0x27, 0x1018284, (u32)p);
            prev = p;
        }
    }
    if (prev != 0)
        tx_api_callback_and_release(prev);
}

/* Колбэк таймера сброса fwq_tx (0x8cadc4): метод [3] очереди. */
void fwq_tx_flush_timer_cb(u32 a0, u32 a1)
{
    struct fwq_tx *q = (struct fwq_tx *)a0;
    (void)a1;
    fw_log_emit1(0x27, 0x1018c18, (u32)q);
    q->flush_timer = 0;
    q->vt->enable_ring(q);                          /* vt[3] */
}

/* fwq_tx__request_flush (0x8cac1c, 78 Б): отметить cid в маске сброса, таймер сброса
 * на 300 мс. */
static void fwq_tx_request_flush(struct fwq_tx *q, u32 cid)
{
    u32 bit = 1u << cid;
    if (q->flush_cid_mask & bit)
        fw_sysassert_fatal((void *)0, 0x1210);
    q->flush_cid_mask |= bit;
    if (q->flush_timer == 0)
        q->flush_timer = u_schd_schedule(fwq_tx_flush_timer_cb, (u32)q, 0, 0, 300000, 0, 0);
}

/* TX_CTRL_API::flush_connection (0x8cabc4, 86 Б). */
static void tx_ctrl_api_flush_connection(u32 cid)
{
    u32 bit = 1u << cid;
    fw_log_emit1(0x27, 0x101835c, cid);
    if (G_TX_FLUSH_MASK & bit)
        fw_sysassert_fatal((void *)0, 0x1224);
    G_TX_FLUSH_MASK |= bit;
    tx_api_flush_pending_peer_pm_connection(cid);
    fwq_tx_request_flush(&tx_api_mgmt, cid);
    TX_API_handle_completed_packets(&tx_api_mgmt);
}

/* ======================= sm_8027a0: разрыв соединения ======================= */

/* автомат разрыва conn_disc_sm (vendor sm_8027a0): таблица 0x802758, описатель 0x8027a0 */
/* 0x802758: таблица переходов [событие][состояние] (7 × 2). */
FWDATA(802758) const struct sm_trans conn_disc_sm_table[7][2] = {
    [CONN_DISC_EV_OWN_START][CONN_DISC_INITIAL] = { SM_ACT(disc_on_own_start), CONN_DISC_WAIT_FOR_DISC_DONE },
    [CONN_DISC_EV_OWN_START][CONN_DISC_WAIT_FOR_DISC_DONE] = { SM_ACT(sm_action_nop_b), CONN_DISC_WAIT_FOR_DISC_DONE },
    [CONN_DISC_EV_NTF_SW_DATA_STOPPED][CONN_DISC_INITIAL] = { SM_ACT(sm_action_nop_b), CONN_DISC_INITIAL },
    [CONN_DISC_EV_NTF_SW_DATA_STOPPED][CONN_DISC_WAIT_FOR_DISC_DONE] = { SM_ACT(disc_on_sw_data_stopped), CONN_DISC_WAIT_FOR_DISC_DONE },
    [CONN_DISC_EV_NTF_MLME_DISC_DONE][CONN_DISC_INITIAL] = { SM_ACT(disc_on_mlme_disc_done), CONN_DISC_INITIAL },
    [CONN_DISC_EV_NTF_MLME_DISC_DONE][CONN_DISC_WAIT_FOR_DISC_DONE] = { SM_ACT(disc_wait_for_disconnect_action), CONN_DISC_WAIT_FOR_DISC_DONE },
    [CONN_DISC_EV_NTF_LMS_STOPPED][CONN_DISC_INITIAL] = { SM_ACT(sm_action_nop_b), CONN_DISC_INITIAL },
    [CONN_DISC_EV_NTF_LMS_STOPPED][CONN_DISC_WAIT_FOR_DISC_DONE] = { SM_ACT(disc_on_lms_stopped), CONN_DISC_WAIT_FOR_DISC_DONE },
    [CONN_DISC_EV_NTF_FW_TX_STOPPED][CONN_DISC_INITIAL] = { SM_ACT(sm_action_nop_b), CONN_DISC_INITIAL },
    [CONN_DISC_EV_NTF_FW_TX_STOPPED][CONN_DISC_WAIT_FOR_DISC_DONE] = { SM_ACT(disc_on_fw_tx_stopped), CONN_DISC_WAIT_FOR_DISC_DONE },
    [CONN_DISC_EV_OWN_DISC_DONE][CONN_DISC_INITIAL] = { SM_ACT(sm_action_nop_b), CONN_DISC_INITIAL },
    [CONN_DISC_EV_OWN_DISC_DONE][CONN_DISC_WAIT_FOR_DISC_DONE] = { SM_ACT(disc_on_own_disc_done), CONN_DISC_INITIAL },
    [CONN_DISC_EV_READY_FOR_FLUSH][CONN_DISC_INITIAL] = { SM_ACT(disc_on_mlme_disc_done), CONN_DISC_INITIAL },
    [CONN_DISC_EV_READY_FOR_FLUSH][CONN_DISC_WAIT_FOR_DISC_DONE] = { SM_ACT(disc_on_ready_for_flush), CONN_DISC_WAIT_FOR_DISC_DONE },
};

/* 0x8027a0: описатель (ид [0x10] пишет конструктор). */
extern const u32 disc_flush_sm_event_names[7];   /* определение ниже */
FWDATA(8027a0) struct sm_desc conn_disc_sm_desc = {
    .n_events = 7, .n_states = 2, .init_state = CONN_DISC_INITIAL,
    .table = &conn_disc_sm_table[0][0],
    .state_names = disconn_sm_state_names, .event_names = disc_flush_sm_event_names,
};

/* 0x8004d4: имена состояний DISCONN_SM (описатель 0x8027a0), include/link_sm.h. */
FWDATA(8004d4) const u32 disconn_sm_state_names[2] = {
    0x101ff2c,   /* INITIAL */
    0x101ff34,   /* WAIT_FOR_DISC_DONE */
};

/* D (conn->msm.disc): владелец D->msm, соединение D->msm->conn; steps — шаги разрыва
 * (бит 0 — TX, 1 — данные хоста, 2 — LMS, 3 — сброс); reason — причина, proto — код
 * протокола. */
static struct conn *disc_conn(struct conn_disc_sm *d)
{
    return d->msm->conn;
}

static void disc_wait_for_disconnect(struct conn_disc_sm *d);

/* Колбэк таймера ожидания разрыва (0x8f251c): срок вышел — ещё раз. */
void disc_wait_timeout_cb(u32 a0, u32 a1)
{
    struct conn_disc_sm *d = (struct conn_disc_sm *)a0;
    (void)a1;
    d->wait_timer = 0;
    fw_log_emit0(0x1b, 0x1011cb4);
    d->wait = 0;
    disc_wait_for_disconnect(d);
}

/* wait_for_disconnect (0x8fb3c8, 102 Б): ничего не ждём (wait == 0) — событие 6
 * самому себе; иначе таймер 1 с (wait_timer). */
void disc_wait_for_disconnect_action(struct conn_disc_sm *d)
{
    disc_wait_for_disconnect(d);
}

static void disc_wait_for_disconnect(struct conn_disc_sm *d)
{
    if (d->wait == 0) {
        fw_log_emit0(0x2b, 0x1011cd8);
        conn_disc_event(d, 6, 0, 0, 0);
    } else if (d->wait_timer == 0) {
        fw_log_emit0(0x2b, 0x1011d24);
        d->wait_timer = u_schd_schedule(disc_wait_timeout_cb, (u32)d, 0, 2, 1000000, 0, 0);
    } else {
        fw_log_emit0(0x2b, 0x1011d68);
    }
}

/* mlme_sm_8027a0__action_8f24d8 (0x8f24d8): SM_EVT_OWN_START — запомнить причину,
 * удалить стримы соединения (для причин 1/2/7 — с флагом). */
void disc_on_own_start(struct conn_disc_sm *d, u32 reason, u32 proto)
{
    u32 f = 0;
    d->reason = (u8)reason;
    d->proto = (u16)proto;
    d->steps |= 2;
    d->del_flag = 0;
    if (reason == 2 || reason == 7 || reason == 1) {
        d->del_flag = 1;
        f = 1;
    }
    fw_log_emit1(0x2b, 0x1011bc4, f);
    stream_mgr_remove_conn_stream(disc_conn(d), d->del_flag, d->reason);
}

/* mlme_sm_8027a0__action_8f23a0 (0x8f23a0): SM_EVT_READY_FOR_FLUSH — сброс TX cid и
 * LMAC 0x0f {cid, 0}. */
void disc_on_ready_for_flush(struct conn_disc_sm *d)
{
    if (d->wait_timer != 0) {
        fw_log_emit0(0x1b, 0x1011c54);
        u_schd_cancel(d->wait_timer);
        d->wait_timer = 0;
    }
    if (d->steps & 8u) {
        d->steps = (d->steps & ~9u) | 1u;
        tx_ctrl_api_flush_connection(disc_conn(d)->cid);
        lmac_if_send_cmd_0x0f(disc_conn(d)->cid, 0);
    } else {
        fw_log_emit0(0x2b, 0x1011c84);
    }
}

/* conn_disc_sm__disassoc_sent_cb (0x8f23f8, 76 Б): колбэк завершения TX disassoc
 * (передаётся автомату mlme событием 1 из 0x8f6230; a2 — соединение). */
void conn_disc_sm_disassoc_sent_cb(u32 payload, u32 status, u32 a2)
{
    struct conn *conn = (struct conn *)a2;
    (void)status;
    fw_log_emit0(0x2b, 0x1011de8);
    if (conn != 0) {
        conn->msm.disc.wait = 0;
        TX_API_free_memory(payload);
        conn_sm_handle_event(conn, 6, 0, 0, 0);
    } else {
        fw_log_emit0(0x2e, 0x1011e14);
        TX_API_free_memory(payload);
    }
}

/* mlme_sm_8027a0__action_8f24c0 (0x8f24c0): SM_EVT_OWN_DISC_DONE — событие 9
 * (разрыв завершён) conn_main_sm с причиной. */
void disc_on_own_disc_done(struct conn_disc_sm *d)
{
    d->wait = 0;
    conn_msm_event(d->msm, 9, d->reason, d->proto, 0);
}

/* mlme_sm_8027a0__action_8f3314 (0x8f3314): SM_EVT_NTF_FW_TX_STOPPED — шаг TX снят
 * (иных шагов быть не должно — ассерт 0x11c3), нулевой ключ cid (LMAC 0x18). */
void disc_on_fw_tx_stopped(struct conn_disc_sm *d)
{
    u32 key[4];
    u32 f = d->steps & ~1u;
    d->steps = f;
    if (f != 0)
        fw_sysassert_fatal((void *)0, 0x11c3);
    memset0_words(key, 0x10);
    lmac_if_install_key(disc_conn(d)->cid, 1, key, 0, 0);
}

/* mlme_sm_8027a0__action_8f6230 (0x8f6230): SM_EVT_NTF_LMS_STOPPED — событие 1
 * (отправить disassoc) автомату MLME соединения с колбэком завершения. */
void disc_on_lms_stopped(struct conn_disc_sm *d)
{
    if (d->steps & 4u) {
        d->steps = (d->steps & ~0xcu) | 8u;
        mlme_sm_event(&disc_conn(d)->mlme, 1, 0, d->proto,
                      (u32)conn_disc_sm_disassoc_sent_cb);   /* аргумент автомата (u32) — обработчик TX числом */
    } else {
        fw_log_emit0(0x2b, 0x1011da8);
    }
}

/* mlme_sm_8027a0__action_8f6b94 (0x8f6b94): SM_EVT_NTF_MLME_DISC_DONE в INITIAL —
 * conn::disconnect. */
void disc_on_mlme_disc_done(struct conn_disc_sm *d, u32 reason, u32 proto)
{
    fw_log_emit2(0x2b, 0x1011bf0, reason, proto);
    conn_disconnect(disc_conn(d), reason, proto);
}

/* mlme_sm_8027a0__action_8f9ca8 (0x8f9ca8): SM_EVT_NTF_SW_DATA_STOPPED — WBE close,
 * остановка линка (lm_sm STOP_LINK). */
void disc_on_sw_data_stopped(struct conn_disc_sm *d)
{
    if (d->steps & 2u) {
        wbe_driver_close();
        d->steps = (d->steps & ~6u) | 4u;
        lm_if_on_data_stopped(&disc_conn(d)->lm);
    } else {
        fw_log_emit0(0x2b, 0x1011c20);
    }
}

/* ======================= find_sm (0x8030f4) ======================= */

/* F — автомат find_sm (struct find_sm, x+0x1c), x — find_mngr (struct find_mngr,
 * include/mid.h): тихий режим (без событий хосту), таймер discovery, discovery идёт,
 * discovery-бикон поставлен, запись mid. */
static struct mid *find_mngr_mid_e(struct find_mngr *x)
{
    return x->mid;
}

/* l2mgr__send_listen_started (0x8f89a4, 70 Б): событие 0x1914 {status} хосту. */
void l2mgr_send_listen_started(u32 status, u32 mid)
{
    u8 *p = (u8 *)host_if_send_pair();
    memset0_words(p, 4);
    p[0] = (u8)status;
    fw_log_emit1(0x2b, 0x100e0e8, mid);
    low_sme_send_evt2sw(p, 0x1914, 4, mid, 0, 0, 0);
}

/* l2mgr__send_search_started (0x8f8d74, 72 Б): событие 0x1915 {status}. */
void l2mgr_send_search_started(u32 status, u32 mid)
{
    u8 *p = (u8 *)host_if_send_pair();
    memset0_words(p, 4);
    p[0] = (u8)status;
    fw_log_emit2(0x2b, 0x100e188, mid, status);
    low_sme_send_evt2sw(p, 0x1915, 4, mid, 0, 0, 0);
}

/* l2mgr__send_discovery_stopped (0x8f8904, 66 Б): системное состояние 0x10, событие
 * 0x1917 без тела. Результат l2_mgr__chk_sys_idle vendor не использует. */
static void l2mgr_send_discovery_stopped(u32 mid)
{
    (void)link_chk_sys_idle();
    sys_state_broadcast(0x10, 0);
    fw_log_emit1(0x2b, 0x100ec50, mid);
    low_sme_send_evt2sw(host_if_send_pair(), 0x1917, 0, mid, 0, 0, 0);
}

/* find_mngr__listen_end (0x8daff0, 20 Б). */
static void find_mngr_listen_end(struct find_mngr *x)
{
    if (x->quiet == 0)
        l2mgr_send_listen_started(0, find_mngr_mid_e(x)->id);
}

/* find_mngr__search_end (0x8e4c8c, 20 Б). */
static void find_mngr_search_end(struct find_mngr *x)
{
    if (x->quiet == 0)
        l2mgr_send_search_started(0, find_mngr_mid_e(x)->id);
}

/* find_mng::add_bcon (0x8c2870, 88 Б): поставить discovery-бикон (один раз). */
static void find_mngr_add_bcon(struct find_mngr *x)
{
    if (x->bcon_added == 1)
        return;
    fw_log_emit0(0x2c, 0x1017ab0);
    if (x->mid == 0) {
        x->mid = mid_list_by_mid_fw(0);
        if (x->mid == 0)
            fw_sysassert_fatal((void *)0, 0x16c9);
    }
    fw_log_emit0(0x2c, 0x1017ae0);
    add_discovery_bcon(x->mid, 0);
    lmac_if_send_cmd_0x23(1);
    x->bcon_added = 1;
}

/* find_mngr__del_discovery_bcon (0x8c8d6c, 48 Б): снять discovery-бикон, бит 1 байта
 * bi_ctrl[0] (+0x14f записи mid). */
static void find_mngr_del_discovery_bcon(struct find_mngr *x)
{
    if (x->bcon_added == 0)
        return;
    fw_log_emit0(0x2c, 0x1017b1c);
    x->bcon_added = 0;
    tx_bcon_del_bcon(x->mid);
    x->mid->bss.bi_ctrl[0] &= (u8)~2u;
}

/* find_sm__stop_discovery (0x8e80a4, 38 Б). */
static void find_sm_stop_discovery(struct find_mngr *x)
{
    if (x->timer != 0) {
        u_schd_cancel(x->timer);
        x->timer = 0;
    }
    discovery_rx_stop();
    x->active = 0;
    l2mgr_send_discovery_stopped(find_mngr_mid_e(x)->id);
}

/* Освободить все найденные BSS автомата (журнал tok на каждый). */
static void find_sm_free_found(struct find_sm *f, u32 tok)
{
    while (f->found.count != 0) {
        fw_log_emit0(0x1c, tok);
        free_dband_info(llist_pop_front(&f->found));
    }
}

/* Колбэк настройки канала find_sm (0x8f1910): EVT_RADIO_READY (2). */
void find_sm_radio_tuned_cb(struct rm_req *req, u32 f)
{
    (void)req;
    basic_sm_handle_event((void *)f, 2, 0, 0, 0);
}

/* Колбэк выделения радио find_sm (0x8f7fc0): настроить канал (sec_tune); arg — find_sm. */
void find_sm_radio_allocated_cb(struct rm_req *req, u32 arg)
{
    struct find_sm *f = (struct find_sm *)arg;
    struct find_mngr *x = f->owner;
    struct mid *e = x->mid;
    (void)req;
    radio_mgr_sec_tune(find_sm_radio_tuned_cb, (u32)f, (struct rm_req *)f->req, 1,
                       x->channel, e->id);
}

/* state_sm_8030f4__action_8f0dd4 (0x8f0dd4): EVT_START_LISTEN/START_SEARCH в STATE_IDLE —
 * сброс BF-состояний cid, запрос радио (request_secondary). */
void find_sm_on_start(struct find_sm *f)
{
    u32 i;
    for (i = 0; i < SPARRAW_MAX_STA; i++)
        f->bf_state[i] = SPARRAW_PEER_UNKNOWN;
    f->req = (u32)radio_mgr_request_secondary(find_sm_radio_allocated_cb, (u32)f, 0,
        0xffff, find_mngr_mid_e(f->owner)->id);
}

/* mid__link_acquisition [0x8da8fc] — копия: поиск записи по ключу. */
static struct conn *find_link_acquisition(struct mid *mid, const void *key, const void *e, u32 a3,
                                          u32 a4)
{
    struct conn *out = 0;
    if (find_main_sm_bcon_lookup(mid, key, e, 0, &out, a3, 0, a4) == 0)
        return 0;
    return out;
}

/* find_main_sm::bcon (0x8f13f8, 214 Б): новый BSS (по BSSID кадра) — в список найденных
 * (пул dband_info_pool полон — только журнал); SSID из записи разбора. */
void find_main_sm_bcon(struct find_sm *f, struct rx_pkt *pkt)
{
    volatile struct mem_pool *pool = &dband_info_pool;
    const union mac_addr *bssid = &pkt->hdr->addr1;
    struct dband_info *e;
    const struct rx_mgmt_ei *ei;
    fw_log_emit0(0x2c, 0x1017c3c);
    if (find_main_sm_bcon_step(&f->found, bssid->b) != 0)
        fw_sysassert_fatal((void *)0, 0x1035);
    if (!(pool->used < pool->count)) {
        fw_log_emit1(0x1c, 0x1017c54, u_schd_now());
        return;
    }
    e = alloc_dband_info();
    if (e == 0)
        fw_sysassert_fatal((void *)0, 0x1004);
    fw_log_emit2(0x29, 0x1017c80, bssid->h[2], mac_lo32(bssid));
    hexdump_words(pkt->hdr, pkt->info.len);
    memcpy_fw(e->bssid, bssid, 6);
    ei = pkt->ei;
    /* SSID 0..32 октета (9.4.2.2). Ошибка vendor (исправлено): длина из маяка до 255 копировалась в ssid[32]
     * записи dband_info — порча соседних полей и записей пула из эфира. Длиннее 32 — SSID не берётся. */
    if (ei != 0 && ei->ssid.len >= 1 && ei->ssid.len <= sizeof(e->ssid)) {
        memcpy_fw(e->ssid, ei->ssid.body, ei->ssid.len);
        e->ssid_len = pkt->ei->ssid.len;
    }
    (void)find_link_acquisition(find_mngr_mid_e(f->owner), bssid, 0, 0, 0xffff);
    list_find_entry_d(&f->found, e);
}

/* state_sm_8030f4__action_8f14d0 (0x8f14d0): EVT_BCON в STATE_SEARCHING (тип 2). */
void find_sm_on_bcon_searching(struct find_sm *f, struct rx_pkt *pkt, u32 type)
{
    fw_log_emit1(0x2c, 0x1017cb0, type);
    if (type == 2)
        find_main_sm_bcon(f, pkt);
}

/* state_sm_8030f4__action_8f1500 (0x8f1500): EVT_BEAMFORMING в STATE_SEARCHING — по
 * успешному BF с соединением c (a0) отправить probe request (повторный BF того же cid —
 * только сброс состояния). */
void find_sm_on_beamforming(struct find_sm *f, struct conn *c, u32 status)
{
    u8 ssid[0x20];
    u32 len = 0, cid, payload, slen;
    struct mid *e;
    struct ieee80211_hdr *hdr;
    fw_log_emit1(0x2c, 0x1017fd0, status);
    if (status != 0) {
        fw_log_emit1(0x2c, 0x1018070, status);
        return;
    }
    cid = c->cid;
    if (cid >= SPARRAW_MAX_STA)
        fw_sysassert_fatal((void *)0, 0x1474);
    if (f->bf_state[cid] != SPARRAW_PEER_UNKNOWN) {
        fw_log_emit1(0x2c, 0x1017ff4, u_schd_now());
        f->bf_state[cid] = SPARRAW_PEER_UNKNOWN;
        return;
    }
    payload = TX_API_alloc_tx_payload();
    e = find_mngr_mid_e(f->owner);
    slen = mid_copy_ssid(&e->bss, ssid);
    mgmt_tx_build_probe_req(payload, &len, find_mngr_mid_e(f->owner), c, ssid, slen);
    hdr = (struct ieee80211_hdr *)payload;
    memcpy_fw(hdr->addr1.b, c->peer, 6);
    {   /* побайтно (stb ×6, как vendor) — volatile, иначе gcc сливает в stw */
        volatile u8 *a3 = hdr->addr3.b;
        a3[0] = 0xff;
        a3[1] = 0xff;
        a3[2] = 0xff;
        a3[3] = 0xff;
        a3[4] = 0xff;
        a3[5] = 0xff;
    }
    fw_log_emit2(0x2c, 0x1018030, slen, u_schd_now());
    f->bf_state[cid] = (u8)cid;
    tx_api_send_mgmt(c, 1, 1, payload, (u16)len, 0, 0);
}

/* ie_list__first (0x8cbfc8, 52 Б): соединение записи mid e с cid или 0. */
struct conn *ie_list_first(struct mid *e, u32 cid)
{
    u32 it;
    iter_init(&it, &e->conns);
    while (list_has_items(&it)) {
        struct conn *c = (struct conn *)iter_next(&it);
        if (c->cid == cid)
            return c;
    }
    return 0;
}

/* Блок элементов с итератором в начале (app_ies__bind_buffer 0x8e6108): итератор
 * {текущий, позиция u16, блок} и сам блок {буфер, длина u16}. */
struct ie_elem_blk {
    const u8 *cur;                             /* 0x00: текущий элемент, 0 — конец */
    u16 pos;                                   /* 0x04 */
    u16 rsv_06;
    struct ie_elem_blk *blk;                   /* 0x08: блок итератора (= сам) */
    const u8 *buf;                             /* 0x0c */
    u16 len;                                   /* 0x10 */
    u16 rsv_12;
};
_Static_assert(__builtin_offsetof(struct ie_elem_blk, buf) == 0xc, "ie_elem_blk.buf");
_Static_assert(sizeof(struct ie_elem_blk) == 0x14, "ie_elem_blk");

/* app_ies__set_probe_req_ies (0x8e6908, 52 Б) + app_ies__bind_buffer (0x8e6108): буфер и
 * длина в блок, итератор — на начало. */
static const u8 *app_ies_set_probe_req_ies(struct ie_elem_blk *blk, const u8 *ie, u32 len)
{
    const u8 *old;
    if (len != 0 && ie == 0)
        fw_sysassert_fatal((void *)0, 0x121c);
    old = blk->buf;
    blk->buf = ie;
    blk->len = (u16)len;
    blk->blk = blk;
    blk->cur = blk->buf;
    blk->pos = 0;
    return old;
}

/* ie__next_element (0x8df474, 40 Б): элемент {id, len u8, …} с заголовком 3 Б. Позиция
 * растёт на len + 3, а указатель vendor двигает на 3·(len + 3) (арифметика по 3-байтной
 * структуре); на деле до второго элемента не доходит — блок здесь начинается с самого
 * IE (заголовок 2 Б), и позиция уже первого шага ≥ длины блока. Оставлено как vendor. */
static const u8 *ie_next_element(struct ie_elem_blk *it)
{
    const u8 *cur = it->cur;
    u32 pos;
    if (cur == 0)
        return 0;
    pos = (u16)(it->pos + cur[1] + 3);
    it->pos = (u16)pos;
    if ((s32)pos >= (s32)it->blk->len)
        it->cur = 0;
    else
        it->cur = cur + cur[1] * 3 + 9;
    return cur;
}

/* ies__scan_for_match (0x8cb8ec, 36 Б): элемент с данным id или 0. */
static const u8 *ies_scan_for_match(struct ie_elem_blk *it, u32 id)
{
    while (it->cur != 0) {                                      /* ies__iter_has_more */
        const u8 *el = ie_next_element(it);
        if (el[0] == id)
            return el;
    }
    return 0;
}

/* Общая часть ответа на probe request в find_sm (действия 8f76d8 / 8f78c0): searching — в
 * STATE_SEARCHING (иначе выход при [x+0x14] == 2, тип кадра ответа 0). P2P IE (WFA
 * 50:6f:9a:09) с атрибутом P2P Device ID, не совпадающим со своим MAC, — не отвечать. */
static void find_sm_probe_req(struct find_sm *f, struct rx_pkt *pkt, u32 searching)
{
    struct app_ies blk;
    struct ie_iter it;
    struct ie_elem_blk blk2;
    struct find_mngr *x = f->owner;
    const struct rx_mgmt_ei *ei = pkt->ei;
    u32 len = (u16)(pkt->info.len - ((u32)ei->ies - (u32)pkt->hdr));
    u32 peer, ie, reply = 1, ftype = 1, out_len, payload;
    struct conn *c;
    c = ie_list_first(x->mid, pkt->info.cid);
    if (c == 0) {
        fw_sysassert_fatal((void *)0, searching ? 0x1447 : 0x1448);
        return;
    }
    peer = (u32)c->peer;
    fw_log_emit2(0x2c, 0x1017ce0, ((const union mac_addr *)c->peer)->h[2],
                 mac_lo32((const union mac_addr *)c->peer));
    if (!searching && x->mode == 2) {
        fw_log_emit0(0x2c, 0x1017ea4);
        return;
    }
    app_ies_set_buffer(&blk, ei->ies, len, 0);
    ie_iter_init(&it, &blk);
    while ((ie = (u32)app_ie_walk_list(&it)) != 0) {
        u8 *o = (u8 *)(ie + 2);
        if (o[0] == 0x50 && o[1] == 0x6f && o[2] == 0x9a && o[3] == 9) {
            const u8 *a;
            const union mac_addr *da;
            struct mid *e;
            fw_log_emit0(0x2c, searching ? 0x1017d10 : 0x1017ef8);
            if (searching)
                ftype = 0;
            if (x->quiet == 0)
                continue;
            app_ies_set_probe_req_ies(&blk2, (const u8 *)ie, (u16)(((const u8 *)ie)[1] + 2));
            a = ies_scan_for_match(&blk2, 3);
            if (a == 0)
                continue;
            /* P2P Device ID: адрес после заголовка 3 Б (адрес не выровнен: журнал читает
             * ld/ldh как прежде, сравнение — побайтно через u8 *, иначе gcc сливает
             * сравнения union mac_addr в ldh) */
            a += 3;
            da = (const union mac_addr *)a;
            e = x->mid;
            fw_log_emit2(0x29, searching ? 0x1017d68 : 0x1017f30, da->h[2], mac_lo32(da));
            if (a[0] == e->mac[0] && a[1] == e->mac[1] &&
                a[2] == e->mac[2] && a[3] == e->mac[3] &&
                a[4] == e->mac[4] && a[5] == e->mac[5])
                continue;
            fw_log_emit0(0x2c, searching ? 0x1017dc0 : 0x1017f6c);
            reply = 0;
        } else if (o[0] == 0 && o[1] == 0x50 && o[2] == 0xf2 && o[3] == 4) {
            fw_log_emit0(0x2c, searching ? 0x1017e18 : 0x1017fa0);   /* WPS IE */
        }
    }
    if (reply == 0) {
        fw_log_emit0(0x2c, 0x1017e64);
        return;
    }
    payload = TX_API_alloc_tx_payload();
    out_len = 0;
    mgmt_tx_build_probe_resp(payload, &out_len, x->mid, c, searching ? ftype : 0);
    memcpy_fw(((struct ieee80211_hdr *)payload)->addr1.b, (const void *)peer, 6);
    if (x->mode != 2)
        memcpy_fw(((struct ieee80211_hdr *)payload)->addr3.b, &pkt->hdr->addr3, 6);
    tx_api_send_mgmt(c, 1, 1, payload, (u16)out_len, 0, 0);
}

/* state_sm_8030f4__action_8f76d8 (0x8f76d8): EVT_PROBE_REQ в STATE_LISTENING. */
void find_sm_on_probe_req_listening(struct find_sm *f, struct rx_pkt *pkt)
{
    find_sm_probe_req(f, pkt, 0);
}

/* state_sm_8030f4__action_8f78c0 (0x8f78c0): EVT_PROBE_REQ в STATE_SEARCHING. */
void find_sm_on_probe_req_searching(struct find_sm *f, struct rx_pkt *pkt)
{
    find_sm_probe_req(f, pkt, 1);
}

/* state_sm_8030f4__action_8f96a8 (0x8f96a8): EVT_RADIO_READY → STATE_LISTENING. */
void find_sm_on_radio_ready_listen(struct find_sm *f)
{
    fw_log_emit0(0x2c, 0x1017bb4);
    find_mngr_listen_end(f->owner);
}

/* state_sm_8030f4__action_8f9994 (0x8f9994): EVT_START_SEARCH / EVT_RADIO_READY →
 * STATE_SEARCHING — список найденных очищен, discovery-бикон, событие хосту. */
void find_sm_on_start_search(struct find_sm *f)
{
    fw_log_emit0(0x2c, 0x1017b70);
    find_sm_free_found(f, 0x1017b88);
    find_mngr_add_bcon(f->owner);
    find_mngr_search_end(f->owner);
}

/* find_main_sm::stop (0x8f9ac8, 92 Б): EVT_STOP в STATE_LISTENING → STATE_IDLE —
 * вернуть радио, очистить список, снять discovery. */
void find_main_sm_stop(struct find_sm *f)
{
    fw_log_emit1(0x2c, 0x1017bcc, f->req);
    radio_mgr_call_method_10((struct rm_req *)f->req);
    f->req = 0;
    find_sm_free_found(f, 0x1017bf8);
    find_mngr_del_discovery_bcon(f->owner);
    find_sm_stop_discovery(f->owner);
}

/* state_sm_8030f4__action_8f9b84 (0x8f9b84): EVT_STOP в STATE_SEARCHING. */
void find_sm_on_stop_searching(struct find_sm *f)
{
    fw_log_emit0(0x2c, 0x1017c1c);
    find_mngr_del_discovery_bcon(f->owner);
    find_main_sm_stop(f);
}

/* state_sm_8030f4__action_8f9ce0 (0x8f9ce0): EVT_START_LISTEN в STATE_SEARCHING. */
void find_sm_on_start_listen_searching(struct find_sm *f)
{
    find_mngr_del_discovery_bcon(f->owner);
    find_mngr_listen_end(f->owner);
}

/* 0x803108: таблица переходов find_sm [событие][состояние] (событий 7, состояний 5) —
 * {действие, следующее состояние}; комментарий — «состояние → следующее» по vendor-именам. */
FWDATA(803108) const struct sm_trans find_sm_trans[7][5] = {
    [0] = {   /* EVT_START_LISTEN */
        { SM_ACT(find_sm_on_start), 1 },                     /* STATE_IDLE → STATE_ALLOCATE_RADIO_LSN */
        { SM_ACT(sm_action_nop_b), 1 },                      /* STATE_ALLOCATE_RADIO_LSN → STATE_ALLOCATE_RADIO_LSN */
        { SM_ACT(sm_action_nop_b), 1 },                      /* STATE_ALLOCATE_RADIO_SRC → STATE_ALLOCATE_RADIO_LSN */
        { SM_ACT(basic_sm_error_handler), 3 },               /* STATE_LISTENING → STATE_LISTENING */
        { SM_ACT(find_sm_on_start_listen_searching), 3 },    /* STATE_SEARCHING → STATE_LISTENING */
    },
    [1] = {   /* EVT_START_SEARCH */
        { SM_ACT(find_sm_on_start), 2 },                     /* STATE_IDLE → STATE_ALLOCATE_RADIO_SRC */
        { SM_ACT(sm_action_nop_b), 2 },                      /* STATE_ALLOCATE_RADIO_LSN → STATE_ALLOCATE_RADIO_SRC */
        { SM_ACT(sm_action_nop_b), 2 },                      /* STATE_ALLOCATE_RADIO_SRC → STATE_ALLOCATE_RADIO_SRC */
        { SM_ACT(find_sm_on_start_search), 4 },              /* STATE_LISTENING → STATE_SEARCHING */
        { SM_ACT(basic_sm_error_handler), 4 },               /* STATE_SEARCHING → STATE_SEARCHING */
    },
    [2] = {   /* EVT_RADIO_READY */
        { SM_ACT(basic_sm_error_handler), 0 },               /* STATE_IDLE → STATE_IDLE */
        { SM_ACT(find_sm_on_radio_ready_listen), 3 },        /* STATE_ALLOCATE_RADIO_LSN → STATE_LISTENING */
        { SM_ACT(find_sm_on_start_search), 4 },              /* STATE_ALLOCATE_RADIO_SRC → STATE_SEARCHING */
        { SM_ACT(basic_sm_error_handler), 3 },               /* STATE_LISTENING → STATE_LISTENING */
        { SM_ACT(basic_sm_error_handler), 4 },               /* STATE_SEARCHING → STATE_SEARCHING */
    },
    [3] = {   /* EVT_BCON */
        { SM_ACT(sm_action_nop_b), 0 },                      /* STATE_IDLE → STATE_IDLE */
        { SM_ACT(sm_action_nop_b), 1 },                      /* STATE_ALLOCATE_RADIO_LSN → STATE_ALLOCATE_RADIO_LSN */
        { SM_ACT(sm_action_nop_b), 2 },                      /* STATE_ALLOCATE_RADIO_SRC → STATE_ALLOCATE_RADIO_SRC */
        { SM_ACT(find_main_sm_bcon), 3 },                    /* STATE_LISTENING → STATE_LISTENING */
        { SM_ACT(find_sm_on_bcon_searching), 4 },            /* STATE_SEARCHING → STATE_SEARCHING */
    },
    [4] = {   /* EVT_PROBE_REQ */
        { SM_ACT(sm_action_nop_b), 0 },                      /* STATE_IDLE → STATE_IDLE */
        { SM_ACT(sm_action_nop_b), 1 },                      /* STATE_ALLOCATE_RADIO_LSN → STATE_ALLOCATE_RADIO_LSN */
        { SM_ACT(sm_action_nop_b), 2 },                      /* STATE_ALLOCATE_RADIO_SRC → STATE_ALLOCATE_RADIO_SRC */
        { SM_ACT(find_sm_on_probe_req_listening), 3 },       /* STATE_LISTENING → STATE_LISTENING */
        { SM_ACT(find_sm_on_probe_req_searching), 4 },       /* STATE_SEARCHING → STATE_SEARCHING */
    },
    [5] = {   /* EVT_BEAMFORMING */
        { SM_ACT(sm_action_nop_b), 0 },                      /* STATE_IDLE → STATE_IDLE */
        { SM_ACT(sm_action_nop_b), 1 },                      /* STATE_ALLOCATE_RADIO_LSN → STATE_ALLOCATE_RADIO_LSN */
        { SM_ACT(sm_action_nop_b), 2 },                      /* STATE_ALLOCATE_RADIO_SRC → STATE_ALLOCATE_RADIO_SRC */
        { SM_ACT(sm_action_nop_b), 3 },                      /* STATE_LISTENING → STATE_LISTENING */
        { SM_ACT(find_sm_on_beamforming), 4 },               /* STATE_SEARCHING → STATE_SEARCHING */
    },
    [6] = {   /* EVT_STOP */
        { SM_ACT(sm_action_nop_b), 0 },                      /* STATE_IDLE → STATE_IDLE */
        { SM_ACT(sm_action_nop_b), 0 },                      /* STATE_ALLOCATE_RADIO_LSN → STATE_IDLE */
        { SM_ACT(sm_action_nop_b), 0 },                      /* STATE_ALLOCATE_RADIO_SRC → STATE_IDLE */
        { SM_ACT(find_main_sm_stop), 0 },                    /* STATE_LISTENING → STATE_IDLE */
        { SM_ACT(find_sm_on_stop_searching), 0 },            /* STATE_SEARCHING → STATE_IDLE */
    },
};
/* 0x8030f4: описатель find_sm (состояний 5, событий 7, старт STATE_IDLE); ид [0x10] пишет
 * статический конструктор. Имена — массивы ид строк журнала в fw_data. */
extern const u32 find_sm_state_names[5];   /* определение ниже */
extern const u32 find_sm_event_names[7];   /* определение ниже */
FWDATA(8030f4) struct sm_desc find_sm_desc = {
    .n_events = 7, .n_states = 5, .init_state = 0,
    .table = &find_sm_trans[0][0],
    .state_names = find_sm_state_names,   /* {STATE_IDLE, STATE_ALLOCATE_RADIO_LSN, STATE_ALLOCATE_RADIO_SRC, STATE_LISTENING, STATE_SEARCHING} */
    .event_names = find_sm_event_names,
};

/* ======================= имена состояний и событий автоматов (fw_data) ======================= */

/* 0x801124: имена событий автомата разрыва sm_8027a0 (описатель 0x8027a0; имена состояний — 0x8004d4). */
FWDATA(801124) const u32 disc_flush_sm_event_names[7] = {
    0x0101ff47,   /* SM_EVT_OWN_START */
    0x0101ff58,   /* SM_EVT_NTF_SW_DATA_STOPPED */
    0x0101ff73,   /* SM_EVT_NTF_MLME_DISC_DONE */
    0x0101ff8d,   /* SM_EVT_NTF_LMS_STOPPED */
    0x0101ffa4,   /* SM_EVT_NTF_FW_TX_STOPPED */
    0x0101ffbd,   /* SM_EVT_OWN_DISC_DONE */
    0x0101ffd2,   /* SM_EVT_READY_FOR_FLUSH */
};

/* 0x801410: имена состояний maintain_sm (описатель 0x802cc4). */
FWDATA(801410) const u32 maintain_sm_state_names[4] = {
    0x010203d0,   /* STOPPED */
    0x010203d8,   /* BEFORE_FIRST_FBF */
    0x010203e9,   /* FBF_DONE */
    0x010203f2,   /* ACTIVE */
};

/* 0x801420: имена событий maintain_sm (описатель 0x802cc4). */
FWDATA(801420) const u32 maintain_sm_event_names[10] = {
    0x01020328,   /* EVT_START_MAINTAIN */
    0x0102033b,   /* EVT_BF_RESULTS */
    0x0102034a,   /* EVT_RS_RESULTS */
    0x01020359,   /* EVT_STOP */
    0x01020362,   /* EVT_TIMER */
    0x0102036c,   /* EVT_SELF_FBF_FAIL */
    0x0102037e,   /* EVT_SELF_FIRST_FBF_SUCCESS */
    0x01020399,   /* EVT_CONSECUTIVE_HIGH_PER */
    0x010203b2,   /* EVT_PAUSE */
    0x010203bc,   /* EVT_RESUME_MAINTAIN */
};

/* 0x8014c0: имена состояний lm_sm (описатель 0x802da0). */
FWDATA(8014c0) const u32 lm_sm_state_names[7] = {
    0x01020408,   /* LM_STATE_IDLE */
    0x01020416,   /* LM_STATE_WAIT_LINK */
    0x01020429,   /* LM_STATE_CONFIGURED */
    0x0102043d,   /* LM_STATE_WAIT_MAINTAIN */
    0x01020454,   /* LM_STATE_MAINTAINING */
    0x01020469,   /* LM_STATE_WAIT_STOP */
    0x0102047c,   /* LM_STATE_PAUSED */
};

/* 0x8014dc: имена событий lm_sm (описатель 0x802da0). */
FWDATA(8014dc) const u32 lm_sm_event_names[12] = {
    0x0102048c,   /* LM_EVT_LINKUP_REQ */
    0x0102049e,   /* LM_EVT_SELF_LINKUP_FAIL */
    0x010204b6,   /* LM_EVT_SELF_LINKUP_DONE */
    0x010204ce,   /* LM_EVT_STOP_LINK */
    0x010204df,   /* LM_EVT_BF_RESULTS */
    0x010204f1,   /* LM_EVT_START_MAINTAIN_REQ */
    0x0102050b,   /* LM_EVT_LINK_LOST */
    0x0102051c,   /* LM_EVT_MAINTAIN_STARTED */
    0x01020534,   /* LM_EVT_MAINTAIN_STOPPED */
    0x0102054c,   /* LM_EVT_PAUSE */
    0x01020559,   /* LM_EVT_LINK_STAT_UPDATE */
    0x01020571,   /* LM_EVT_RESUME_MAINTAIN_REQ */
};

/* 0x8015cc: имена событий автомата статистики линка sm_802f58 (описатель 0x802f58; имена состояний — 0x8004dc). */
FWDATA(8015cc) const u32 link_stats_sm_event_names[6] = {
    0x010205a4,   /* EVT_START */
    0x010205ae,   /* EVT_LATENCY_TIMER */
    0x010205c0,   /* EVT_STATS_TIMER */
    0x010205d0,   /* EVT_STOP */
    0x010205d9,   /* EVT_PAUSE */
    0x010205e3,   /* EVT_RESUME */
};

/* 0x8016b4: имена состояний find_sm (описатель 0x8030f4). */
FWDATA(8016b4) const u32 find_sm_state_names[5] = {
    0x01020780,   /* STATE_IDLE */
    0x0102078b,   /* STATE_ALLOCATE_RADIO_LSN */
    0x010207a4,   /* STATE_ALLOCATE_RADIO_SRC */
    0x010207bd,   /* STATE_LISTENING */
    0x010207cd,   /* STATE_SEARCHING */
};

/* 0x8016c8: имена событий find_sm (описатель 0x8030f4). */
FWDATA(8016c8) const u32 find_sm_event_names[7] = {
    0x010207dd,   /* EVT_START_LISTEN */
    0x010207ee,   /* EVT_START_SEARCH */
    0x010207ff,   /* EVT_RADIO_READY */
    0x0102080f,   /* EVT_BCON */
    0x01020818,   /* EVT_PROBE_REQ */
    0x01020826,   /* EVT_BEAMFORMING */
    0x01020836,   /* EVT_STOP */
};
