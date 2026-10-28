// SPDX-License-Identifier: AGPL-3.0-or-later
/* RF kill (W_DISABLE): действия автомата rf_mgmt_sm (описатель 0x802338, объект 0x804c34,
 * состояния ENABLED / PENDING_DISABLED / DISABLED; события 0 W_ENABLE, 1 W_DISABLE,
 * 2 DISABLE_DONE, 3 ENABLE_SELF), статус хосту (WMI 0x1853) и останов при RF kill: TX,
 * скан/поиск, PCP. Флаги причины: [0x800190] — аппаратный W_DISABLE, [0x800194] —
 * программный (по аргументу события); объединение — oob__mode_flags (0x8ccac8). */
#include "../include/types.h"
#include "../include/vring_schd.h"
#include "../include/mid.h"
#include "../include/sys_cfg.h"
#include "../include/fwdata.h"
#include "../include/rf_kill.h"
#include "../include/fwdata.h"
#include "../include/wmi.h"


#define RF_KILL_STOP  (rf_kill_stop_stages)   /* [gp,-0xc]: этапы останова RF kill */
#define PCP_COUNT     (pcp_active_count)    /* [gp,0xd6]: активных PCP */

/* ======================= автомат rf_mgmt_sm (vendor sm_802338, fw_data 0x802338..0x802388) ======================= */
/* 0x80234c: таблица переходов [событие][состояние] (4 × 3). */
FWDATA(80234c) const struct sm_trans rf_mgmt_sm_table[4][3] = {
    [RF_MGMT_EV_W_ENABLE][RF_MGMT_ENABLED] = { SM_ACT(rf_mgmt_sm_w_enable_enabled), RF_MGMT_ENABLED },
    [RF_MGMT_EV_W_ENABLE][RF_MGMT_DISABLED] = { SM_ACT(rf_mgmt_sm_w_enable_disabled), RF_MGMT_DISABLED },
    [RF_MGMT_EV_W_ENABLE][RF_MGMT_PENDING_DISABLED] = { SM_ACT(rf_mgmt_sm_w_enable_disabled), RF_MGMT_PENDING_DISABLED },
    [RF_MGMT_EV_W_DISABLE][RF_MGMT_ENABLED] = { SM_ACT(rf_mgmt_sm_w_disable_enabled), RF_MGMT_PENDING_DISABLED },
    [RF_MGMT_EV_W_DISABLE][RF_MGMT_DISABLED] = { SM_ACT(rf_mgmt_sm_w_disable_disabled), RF_MGMT_DISABLED },
    [RF_MGMT_EV_W_DISABLE][RF_MGMT_PENDING_DISABLED] = { SM_ACT(rf_mgmt_sm_w_disable_pending), RF_MGMT_PENDING_DISABLED },
    [RF_MGMT_EV_DISABLE_DONE][RF_MGMT_ENABLED] = { SM_ACT(sm_action_nop_b), RF_MGMT_ENABLED },
    [RF_MGMT_EV_DISABLE_DONE][RF_MGMT_DISABLED] = { SM_ACT(basic_sm_error_handler), RF_MGMT_DISABLED },
    [RF_MGMT_EV_DISABLE_DONE][RF_MGMT_PENDING_DISABLED] = { SM_ACT(low_sme_send_rf_mgmt_status), RF_MGMT_DISABLED },
    [RF_MGMT_EV_ENABLE_SELF][RF_MGMT_ENABLED] = { SM_ACT(basic_sm_error_handler), RF_MGMT_ENABLED },
    [RF_MGMT_EV_ENABLE_SELF][RF_MGMT_DISABLED] = { SM_ACT(low_sme_send_rf_mgmt_status), RF_MGMT_ENABLED },
    [RF_MGMT_EV_ENABLE_SELF][RF_MGMT_PENDING_DISABLED] = { SM_ACT(low_sme_send_rf_mgmt_status), RF_MGMT_ENABLED },
};

/* 0x802338: описатель (ид [0x10] пишет конструктор). */
extern const u32 rf_kill_sm_state_names[3];   /* определение ниже */
extern const u32 rf_kill_sm_event_names[4];   /* определение ниже */
FWDATA(802338) struct sm_desc rf_mgmt_sm_desc = {
    .n_events = 4, .n_states = 3, .init_state = RF_MGMT_ENABLED,
    .table = &rf_mgmt_sm_table[0][0],
    .state_names = rf_kill_sm_state_names, .event_names = rf_kill_sm_event_names,
};

/* ======================= статус хосту ======================= */

/* rf_mgmt__set_state_flag (0x8eab30, 20 Б): флаг причины (sw ≠ 0 — программный
 * [0x800194], иначе [0x800190]) = (v == 1). */
static void rf_mgmt_set_state_flag(u32 v, u32 sw)
{
    u32 f = (v == 1) ? 1 : 0;
    if (sw == 0)
        rf_kill_hw = f;
    else
        rf_kill_sw = f;
}

/* low_sme__send_rf_mgmt_status (0x8e5ce0, 102 Б): WMI 0x1853 {причины RF kill} (4 Б).
 * Значение вне 0..3 — ассерт 0x107e (oob__mode_flags больше 3 не даёт). Действие
 * DISABLE_DONE в PENDING_DISABLED, ENABLE_SELF в DISABLED / PENDING_DISABLED. */
void low_sme_send_rf_mgmt_status(void)
{
    u32 *buf = (u32 *)host_if_send_pair();
    u32 f = oob_mode_flags(&rf_mgmt_sm);   /* oob__mode_flags_default (0x8ccaf0) */
    if (f <= 3)
        buf[0] = f;
    else
        fw_sysassert_fatal(__builtin_return_address(0), 0x107e);
    fw_log_emit1(0x20, 0x100b760, buf[0]);
    low_sme_send_evt2sw(buf, 0x1853, 4, 0xff, 0, 0, 0);
}

/* ======================= останов при RF kill ======================= */

/* find_mngr__stop (0x8e7efc, 48 Б): discovery выкл., событие 6 автомату поиска. */
static void find_mngr_stop(struct find_mngr *f)
{
    lmac_if_discovery_mode_cfg(0, 0);
    fw_log_emit0(0x2c, 0x1017a4c);
    basic_sm_handle_event(&f->sm, 6, 0, 0, 0);
}

/* stop_find_session (0x8f9b48, 30 Б). */
void stop_find_session(struct mid_disc *o)
{
    fw_log_emit0(0x2c, 0x1017004);
    find_mngr_stop(&o->find);
}

/* l2_mgr::scan_abort (0x8e4588, 116 Б): mid 0 — прервать скан или поиск; ни того, ни
 * другого — сразу задача «скан завершён» (low_sme__termination_check(1)). */
static void l2mgr_scan_abort(void)
{
    u32 mid;
    struct mid *e;
    struct mid_disc *o;
    for (mid = 0; (s32)mid < 1; mid++) {
        e = mid_list_by_mid_fw(mid);
        if (e == 0)
            continue;
        o = &e->disc;
        if (((volatile struct scan_mngr *)((volatile struct mid_disc *)o)->scan)->active != 0) {
            fw_log_emit1(0x2b, 0x100e58c, mid);
            scan_abort(o);
        } else if (((volatile struct mid_disc *)o)->find.active != 0) {
            fw_log_emit1(0x2b, 0x100e5c0, mid);
            stop_find_session(o);
        } else {
            fw_log_emit0(0x2b, 0x100e550);
            u_schd_add(low_sme_scan_done_task, 0, 0, 1);
        }
    }
}

/* l2mgr__send_pcp_stopped (0x8f8ac0, 54 Б): WMI 0x1919 (PCP остановлен) mid. */
static void l2mgr_send_pcp_stopped(u32 mid)
{
    fw_log_emit1(0x2b, 0x100ed64, mid);
    low_sme_send_evt2sw(host_if_send_pair(), 0x1919, 0, mid, 0, 0, 0);
    l2mgr_pending_op_clear(4);
}

/* pcp_stop (0x8f720c, 28 Б): снять бикон. */
static void pcp_stop(struct mid_disc *o)
{
    fw_log_emit0(0x2c, 0x1016dcc);
    tx_bcon_del_bcon(((volatile struct mid_disc *)o)->mid);
}

/* pcp_stop__flow (0x8e0878, 138 Б): BSS PCP/AP (тип 2, режим 2/3) — бикон снять, режим
 * BSS 1, первичный канал снять; иначе журнал. Затем таймеры PCP (при [0x803c0c]) и WMI.
 * Доступы к записи — volatile, как в прежнем порте. */
static void pcp_stop_flow(struct mid *e)
{
    volatile struct mid *ve = e;
    struct mid_bss *b = &e->bss;
    u32 m;
    if (ve->pcp_ready_tmr != 0) {
        u_schd_cancel(ve->pcp_ready_tmr);
        ve->pcp_ready_tmr = 0;
    }
    m = ve->bss.mode;
    if (ve->bss.state == 2 && (m == 2 || m == 3)) {
        pcp_stop(&e->disc);
        bss_set_mode(b, 1);
        obj_set_field4_one(b);
        radio_mgr_unset_primary_channel();
        fw_log_emit0(0x1b, 0x100ce68);
    } else {
        fw_log_emit2(0xb, 0x100ce94, ve->bss.mode, ve->bss.state);
    }
    l2mgr_send_pcp_stopped(ve->id);
}

/* Остановка PCP при живых соединениях mid: станции отключаются (Disassoc, reason 3 — DEAUTH_LEAVING, 9.4.1.7),
 * остановка повторяется по таймеру, пока соединения не снимутся (шаг 5 мс, предел 1 с). исправлено (vendor: при
 * ассоциированной станции только журнал — BSS не останавливался, маяки шли, WMI_PCP_STOPPED хосту не уходил
 * (wmi_pcp_stop драйвера — тайм-аут), бит 4 l2mgr_pending_ops оставался навсегда, а PCP_COUNT уже был уменьшен). */
#define PCP_STOP_RETRY_US    5000u
#define PCP_STOP_RETRY_MAX   200u

static void l2mgr_pcp_stop_try(u32 mid, u32 tries);

static void l2mgr_pcp_stop_retry_cb(u32 mid, u32 tries)
{
    l2mgr_pcp_stop_try(mid, tries);
}

/* l2_mgr::pcp_stop (0x8f7160, 170 Б): остановить PCP mid (счётчик PCP, состояния
 * системы 0xb/0xc, mid-соединение заново, vring кольца 1). Нет записи mid — ассерт 0x16b4. */
void l2mgr_pcp_stop(u32 mid)
{
    l2mgr_pending_op_set(4);
    l2mgr_pcp_stop_try(mid, 0);
}

static void l2mgr_pcp_stop_try(u32 mid, u32 tries)
{
    struct mid *e;
    if (mid_state_is_2_or_3(mid) == 0)
        return;
    e = mid_list_by_mid_fw(mid);
    if (e == 0)
        fw_sysassert_fatal(__builtin_return_address(0), 0x16b4);
    if (mid_list_find_by_kind(e, 1) != 0) {
        fw_log_emit0(0xb, 0x100f338);
        if (tries == 0)
            mid_list_disconnect_all(e, 2, 3);
        if (tries < PCP_STOP_RETRY_MAX) {
            u_schd_schedule(l2mgr_pcp_stop_retry_cb, mid, tries + 1, 1, PCP_STOP_RETRY_US, 0, 0);
            return;
        }
        /* за 1 с не снялись — остановить всё равно: хосту нужен WMI_PCP_STOPPED */
    }
    PCP_COUNT = (u8)(PCP_COUNT - 1);
    fw_log_emit1(0x2b, 0x100f2f8, PCP_COUNT);
    if (PCP_COUNT == 0)   /* l2_mgr__has_active_pcp (0x8da47c): ≤ 0 — нет */
        fw_log_emit0(0x2b, 0x100f314);
    sys_state_broadcast(0xb, 0);
    pcp_stop_flow(e);
    if (mid_list_find_by_kind(e, 2) == 0)
        conn_alloc_and_link(0, 1, 0);   /* conn__alloc_and_link__thunk_0_1_0 (0x8da730) */
    sys_state_broadcast(0xc, 0);
    low_sme_termination_check(2);
    stream_mgr_delete_vring(((volatile struct pring *)sm_pring_by_index(1))->vr8);
}

/* low_sme::handle_rf_kill (0x8cdb28, 138 Б): этапы [0x800178]: б0 — TX (отключение
 * соединений vring_schd), б1 — скан/поиск, б2 — PCP mid 0. */
static void low_sme_handle_rf_kill(u32 x)
{
    u32 mid;
    struct mid *e;
    fw_log_emit1(0x20, 0x100b874, x);
    RF_KILL_STOP |= 1;
    fw_log_emit1(0x20, 0x100b89c, RF_KILL_STOP);
    vring_schd_disconnect_notify(x, WMI_SPARRAW_DISC_RF_KILL);
    RF_KILL_STOP |= 2;
    fw_log_emit1(0x20, 0x100b8e4, RF_KILL_STOP);
    l2mgr_scan_abort();
    for (mid = 0; (s32)mid < 1; mid++) {
        e = mid_list_by_mid_fw(mid);
        if (e == 0)
            continue;
        if (mid_state_is_2_or_3(((volatile struct mid *)e)->id) == 0)
            continue;
        RF_KILL_STOP |= 4;
        fw_log_emit1(0x20, 0x100b92c, RF_KILL_STOP);
        l2mgr_pcp_stop(((volatile struct mid *)e)->id);
    }
}

/* ======================= действия автомата ======================= */

/* rf_mgmt_sm::action_8c6010 (0x8c6010, 48 Б): W_ENABLE в DISABLED / PENDING_DISABLED —
 * снять аппаратный флаг; причин не осталось — ENABLE_SELF (3), иначе статус хосту. */
void rf_mgmt_sm_w_enable_disabled(u32 sm, u32 sw)
{
    rf_mgmt_set_state_flag(0, sw);
    if (rf_kill_hw == 0 && rf_kill_sw == 0)
        basic_sm_handle_event((void *)sm, 3, 0, 0, 0);
    else
        low_sme_send_rf_mgmt_status();
}

/* rf_mgmt_sm::action_8c8fcc (0x8c8fcc, 36 Б): W_DISABLE в ENABLED — флаг и останов
 * (аргумент: программный RF kill или [0x800241]). */
void rf_mgmt_sm_w_disable_enabled(u32 sm, u32 sw)
{
    (void)sm;
    rf_mgmt_set_state_flag(1, sw);
    low_sme_handle_rf_kill((sw != 0 || rf_kill_hw_force != 0) ? 1 : 0);
}

/* rf_mgmt_sm::action_8e247c (0x8e247c, 16 Б): W_DISABLE в DISABLED — флаг, статус. */
void rf_mgmt_sm_w_disable_disabled(u32 sm, u32 sw)
{
    (void)sm;
    rf_mgmt_set_state_flag(1, sw);
    low_sme_send_rf_mgmt_status();
}

/* rf_mgmt_sm::action_8e248c (0x8e248c, 16 Б): W_ENABLE в ENABLED — флаг, статус. */
void rf_mgmt_sm_w_enable_enabled(u32 sm, u32 sw)
{
    (void)sm;
    rf_mgmt_set_state_flag(0, sw);
    low_sme_send_rf_mgmt_status();
}

/* rf_mgmt_sm::action_8eaaa8 (0x8eaaa8, 8 Б): W_DISABLE в PENDING_DISABLED — флаг. */
void rf_mgmt_sm_w_disable_pending(u32 sm, u32 sw)
{
    (void)sm;
    rf_mgmt_set_state_flag(1, sw);
}

/* ======================= имена состояний и событий автоматов (fw_data) ======================= */

/* 0x800ff0: имена состояний автомата RF kill (описатель 0x802338). */
FWDATA(800ff0) const u32 rf_kill_sm_state_names[3] = {
    0x0101fc20,   /* ENABLED */
    0x0101fc28,   /* DISABLED */
    0x0101fc31,   /* PENDING_DISABLED */
};

/* 0x800ffc: имена событий автомата RF kill (описатель 0x802338). */
FWDATA(800ffc) const u32 rf_kill_sm_event_names[4] = {
    0x0101fc42,   /* W_ENABLE */
    0x0101fc4b,   /* W_DISABLE */
    0x0101fc55,   /* DISABLE_DONE */
    0x0101fc62,   /* ENABLE_SELF */
};
