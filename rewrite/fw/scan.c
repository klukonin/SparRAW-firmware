// SPDX-License-Identifier: AGPL-3.0-or-later
/* Ход скана (WMI_START_SCAN → WMI_SCAN_COMPLETE): find_sm__start_search (0x8f9920),
 * scan_mngr::start_scan (0x8f9780), автомат каналов channels_switch_sm (описатель
 * 0x802fb4, объект [scan+0x80]) и автомат скана при соединении swc_psc_sm (описатель
 * 0x8030e0, объект scan+0x1d0), завершение скана → SCAN_COMPLETE / ACS-событие.
 *
 * Объекты — struct scan_mngr (0x8052ec + 0x228·mid; mid_disc.scan записи mid), struct
 * channels_switch_sm (0x842d00 + 0x24·mid, scan_mngr.cs), struct swc_psc_sm (scan_mngr.swc),
 * элементы списка каналов struct scan_ch — include/scan_mngr.h.
 *
 * Колбэки радио-менеджера и таймеров — полные адреса наших функций (vendor кладёт
 * адреса в младшем отображении: 0x220b8 и т. п.). */
#include "../include/types.h"
#include "../include/wmi.h"
#include "../include/rf_sets.h"
#include "../include/hw.h"
#include "../include/rf_obj.h"
#include "../include/radio_mgr.h"
#include "../include/vring_schd.h"
#include "../include/mbox.h"
#include "../include/conn.h"
#include "../include/link_sm.h"
#include "../include/mid.h"
#include "../include/fwdata.h"
#include "../include/scan_mngr.h"
#include "../include/lmac_cmd.h"
#include "../include/sys_cfg.h"

#define CH_POOL         (&scan_ch_pool)  /* элементы списка каналов (0x842c74) */

/* События channels_switch_sm (0x802fb4). */
enum { CS_EVT_START_SCAN, CS_EVT_RADIO_ALLOCATED, CS_EVT_CHANNEL_TUNED, CS_EVT_START_DWELLING,
       CS_EVT_STOP_DWELL, CS_EVT_SM_STOPPED, CS_EVT_SCAN_COMPLETED, CS_EVT_STOP_SCAN };
/* События swc_psc_sm (0x8030e0). */
enum { SWC_EVT_SCAN_START, SWC_EVT_SOB_STARTED, SWC_EVT_DWELLING_DONE, SWC_EVT_SCAN_ABORT };
/* Состояния swc_psc_sm (имена — swc_psc_sm_state_names). */
enum { SWC_ST_SCAN_IDLE, SWC_ST_WAIT_SOB_START, SWC_ST_DWELLING };


/* ======================= создание объектов ======================= */

/* Объект scan_mngr записи mid (0x8052ec, radio_req__addr_of 0x8f3698) и счётчики скана
 * (0x805514). В образе — нули; строят scan_mngr__init / mid_ctx_pool__init. */
FWDATA(8052ec) struct scan_mngr scan_mngrs[SCAN_MNGR_N] = { 0 };
FWDATA(805514) volatile struct scan_stats scan_stats = { 0 };

/* scan_mngr__init (0x8f1cb8), channels_switch_sm ctor (0x8d9058), entry_addr (0x8cc6a4)
 * — mid.c. */

/* swc_psc_sm::ctor (0x8c179c, 24 Б): автомат 0x8030e0, журнал переходов включён (vendor
 * зовёт из boot__install_handler_ptrs 0x8c1c68 для 0x8054bc = scan_mngr 0 + 0x1d0). */
void swc_psc_sm_ctor(struct swc_psc_sm *sm)
{
    basic_sm_bind_descriptor(sm, &swc_psc_sm_desc);
    sm->hdr.trace = 1;
}

/* ======================= запуск ======================= */

/* sort_scan_ch_list (0x8f91c8, 128 Б): каналы команды (cmd+0x12, по 2 Б: channel,
 * reserved) в dst (u32) с конца; текущий канал радио — первым. Каналов не больше 4
 * (иначе ассерт 0x1470; vendor продолжает). */
void sort_scan_ch_list(const u8 *cmd, u32 *dst)
{
    u32 cur;
    radio_mgr_get_current_channel(&cur);
    if (cmd[0x11] >= 5)
        fw_sysassert_fatal((void *)0, 0x1470);
    s32 n = cmd[0x11];
    s32 j = n - 1;
    for (s32 i = n - 1; i >= 0; i--) {
        u32 ch = cmd[0x12 + i * 2];
        if (ch != cur)
            dst[j--] = ch;
        else
            dst[0] = cur;
    }
    fw_log_emit3(0x29, 0x101508c, cur, dst[0], cmd[0x11]);
    fw_log_emit3(0x29, 0x10150c8, dst[1], dst[2], dst[3]);
}

/* find_sm__start_search (0x8f9920, 114 Б): сохранить поля команды START_SCAN
 * (wmi_start_scan_cmd) в scan_mngr, упорядочить каналы и запустить скан.
 * a2 — результат паузы колец (≠ 0 — скан отложен), a3 — есть соединение (скан через
 * swc_psc_sm). */
void find_sm_start_search(struct scan_mngr *scan, u8 *cmd, u32 a2, u32 a3)
{
    const u16 *h = (const u16 *)cmd;
    scan->postpone_arg = a2;
    scan->connected_arg = a3;
    scan->cmd.discovery_mode = cmd[6];
    scan->cmd.dwell_time = h[4] | (u32)h[5] << 16;
    scan->cmd.force_scan_interval = h[6] | (u32)h[7] << 16;
    scan->cmd.scan_type = cmd[0x10];
    scan->cmd.num_channels = cmd[0x11];
    memcpy_fw(scan->cmd.direct_mac, cmd, 6);
    scan->rx_omni = 0;                                      /* RX-сектор 0 */
    memset0_words(scan->peer_cnt, 4);
    sort_scan_ch_list(cmd, scan->ch_order);
    scan_mngr_start_scan(scan, cmd, a2, a3);
}

/* hw_sysapi_rx_omni_sector_set (0x8ce40c, 74 Б): RX-сектор s (< числа секторов
 * rf_obj.sector_cfg_cnt) — запомнить в rf_obj.sector_cfg_idx и передать uc (LMAC 0x19). 1 — принято. */
u32 hw_sysapi_rx_omni_sector_set(u32 s)
{
    fw_log_emit1(0x25, 0x101a510, s);
    if (s >= *(volatile u16 *)&rf_obj.sector_cfg_cnt) {
        fw_log_emit1(0x5, 0x101a53c, s);
        return 0;
    }
    *(volatile u8 *)&rf_obj.sector_cfg_idx = (u8)s;
    hw_sysapi_rx_alloc_and_store(*(volatile u8 *)&rf_obj.rf_idx, s);
    return 1;
}

/* scan_mngr__set_rx_omni_sector (0x8f8f44, 12 Б). */
u32 scan_mngr_set_rx_omni_sector(struct scan_mngr *scan)
{
    return hw_sysapi_rx_omni_sector_set(scan->rx_omni);
}

/* RADIO_MGR::unset_primary_channel (0x8ea87c, 50 Б): radio_mgr->set_primary(0, 0xffff,
 * 0, …). */
void radio_mgr_unset_primary_channel(void)
{
    fw_log_emit0(0x28, 0x1019044);
    struct radio_mgr *rm = radio_mgr_obj;
    rm->vt->set_primary(rm, 0, 0xffff, 0, 0, 0, 0, 0);
}

/* discovery::tsf_wa (0x8f9cfc, 94 Б): нет текущего канала (0xffff) — на время поставить
 * первичный канал ch и снять (обход для TSF). Аргументы 2 и 3 set_primary_channel
 * vendor берёт из неинициализированных слов стека (sp+4, sp+8; метод +0x1c пишет только
 * sp+0) — недетерминированы; здесь 0. */
void discovery_tsf_wa(struct mid_disc *obj, u32 ch, u32 a3, u32 mid)
{
    u32 cur;
    (void)obj;
    (void)mid;
    radio_mgr_get_current_channel(&cur);
    if (cur == 0xffff) {
        fw_log_emit2(0x2c, 0x1016e90, ch, cur);
        radio_mgr_set_primary_channel(ch, 0, 0, a3, 1, 0);
        radio_mgr_unset_primary_channel();
    }
    radio_mgr_get_current_channel(&cur);
    fw_log_emit1(0x2c, 0x1016ed4, cur);
}

/* scan_mngr::config_dwell_time (0x8f1d14, 176 Б): время пребывания на канале [+0x70], мкс:
 * (OOB R1 — только SparRAW-pro); при бите 7 [0x803c20] — 500 мс; иначе 5 мс + dwell(мс) ×
 * число RX-секторов [0x800231] (dwell = 0 — по 100 мс на сектор). */
void scan_mngr_config_dwell_time(struct scan_mngr *scan, u32 dwell)
{
    if (dashboard.cfg.special_flags & 0x80) {
        fw_log_emit0(0x29, 0x1014f2c);
        scan->dwell_us = 0x7a120;
        return;
    }
    scan->dwell_us = 0x1388;
    u32 n = conn_multi_omni_count;
    if (dwell != 0) {
        scan->dwell_us = 0x1388 + dwell * 1000 * n;
        fw_log_emit3(0x29, 0x1014f88, dwell, n, fw_divmod_unsigned(scan->dwell_us, 1000));
    } else {
        scan->dwell_us = 0x1388 + n * 100000;
        fw_log_emit2(0x29, 0x1015008, n, fw_divmod_unsigned(scan->dwell_us, 1000));
    }
}

/* Режим discovery-биконов: scan_type 0 (активный) или 3 при discovery_mode == 1 и идущем
 * скане (общая проверка 0x8f9160, 0x8f90e8, 0x8f985a). */
static u32 scan_discovery_bcon_on(const struct scan_mngr *scan)
{
    u32 t = scan->scan_type;
    return (t == 0 || t == 3) && scan->discovery_mode == 1 && scan->active == 1;
}

/* scan_mngr::start_scan (0x8f9780, 416 Б): начать (или продолжить следующим RX-сектором)
 * скан: сбросить счётчики, тип/режим, RX-сектор, TSF старта, режим discovery для uc,
 * время пребывания, список каналов из упорядоченных scan+0x1e4; затем запуск автомата
 * (если кольца не на паузе) и [scan+0x78] = 1. */
void scan_mngr_start_scan(struct scan_mngr *scan, u8 *cmd, u32 a2, u32 a3)
{
    const u16 *h = (const u16 *)cmd;
    fw_log_emit2(0x29, 0x10151fc, cmd[0x10], cmd[6]);
    fw_log_emit2(0x29, 0x1015238, a2, a3);
    for (u32 i = 0; i < 7; i++)
        scan_stats.h[i] = 0;
    scan->aborted = 0;
    scan->is_connected = a3;
    scan->num_channels = cmd[0x11];
    memset0_words(scan->passive, 0x3c);
    scan->discovery_mode = cmd[6];
    scan->scan_type = cmd[0x10];
    scan_mngr_set_rx_omni_sector(scan);
    u32 t = cmd[0x10];
    if (t == 0 || t == 3)
        scan->ucode_scan_type = cmd[6] != 0;
    else if (t == 2)
        scan->ucode_scan_type = 2;
    else {
        fw_log_emit3(0, 0x1015264, t, cmd[6], 0);
        fw_sysassert_fatal((void *)0, 0x1442);
    }
    mac_read_tsf64(0, scan->tsf_start, 0);
    fw_log_emit1(0x29, 0x10152ac, scan->ucode_scan_type);
    lmac_if_discovery_mode_cfg(1, scan->ucode_scan_type);
    if (scan_discovery_bcon_on(scan)) {
        struct mid *e = scan->mid;
        discovery_tsf_wa(&e->disc, 1, 0x47, e->id);
    }
    memcpy_fw(scan->direct_mac, cmd, 6);
    scan_mngr_config_dwell_time(scan, h[4] | (u32)h[5] << 16);
    for (u32 i = 0; i < scan->num_channels; i++) {
        struct scan_ch *e = mem_pool_allocate(CH_POOL);
        if (e == 0)
            fw_sysassert_fatal((void *)0, 0x1248);
        e->channel = scan->ch_order[i];
        list_find_entry_d(&scan->channels, e);
    }
    fw_log_emit1(0x29, 0x1015304, a2);
    if (a2 == 0) {
        scan_mngr_kick_scan_state_machine(scan);
    } else {
        fw_log_emit1(0x29, 0x1015330, scan->mid->id);
        scan->postponed = 1;
    }
    scan->active = 1;
}

/* ======================= приём на время скана ======================= */

/* discovery::rx_start (0x8f80b8, 52 Б): правило парсера 2 (0x3702, бит 11 — если не
 * discovery-режим) и фильтр приёма. */
void discovery_rx_start(u32 discovery)
{
    fw_log_emit0(0x2c, 0x1016f98);
    mac_parser_set_886260(2, (discovery == 0 ? 0x800u : 0u) | 0x3702u);
    hwd_mac_parser_set_rx_filter(0, 1);
}

/* discovery::rx_stop (0x8f80ec, 46 Б). */
void discovery_rx_stop(void)
{
    fw_log_emit0(0x2c, 0x1016fb0);
    mac_parser_set_886260(2, 0x102);
    mac_parser_set_886260(3, 0x102);
    hwd_mac_parser_set_rx_filter(0, 0);
}

/* ======================= discovery-бикон ======================= */

/* add_discovery_bcon (0x8c2904) — fw/stubs.c, рядом с add_bcon (общие помощники полей). */

/* tx_bcon::del_bcon (0x8c8be8, 26 Б): снять бикон — LMAC 0x0b (0x70 Б) с op = 1,
 * bi.bi_mode = 0 (lmac_if__send_bcon_del_0b 0x8db304). */
void tx_bcon_del_bcon(struct mid *mid_e)
{
    fw_log_emit1(0x2c, 0x1017208, mid_e->id);
    struct lmac_cmd_bcn_sweep *b = mem_pool_alloc_locked(&lmac_mbox.mb);
    if (b == 0)
        return;
    b->bi.bi_mode = 0;
    b->op = 1;
    lmac_if_post_cmd(b, 0xb, 0x70, 0);
}

/* ======================= пребывание на канале ======================= */

/* scan_mngr::start_dwelling task (0x8f95fc): событие START_DWELLING автомату каналов. */
void scan_mngr_start_dwelling_task(u32 a0, u32 a1)
{
    struct scan_mngr *scan = (struct scan_mngr *)a0;
    (void)a1;
    fw_log_emit0(0x29, 0x101666c);
    scan->dwell_stopped = 0;
    basic_sm_handle_event(scan->cs, CS_EVT_START_DWELLING, 0, 0, 0);
}

/* scan_mngr::sm_ready_for_dwelling (0x8f9160, 102 Б): канал настроен — (discovery-бикон)
 * и задачей START_DWELLING. */
void scan_mngr_sm_ready_for_dwelling(struct scan_mngr *scan)
{
    fw_log_emit0(0x29, 0x1016544);
    scan->active_probs = 0;
    if (scan_discovery_bcon_on(scan)) {
        fw_log_emit0(0x29, 0x1016568);
        add_discovery_bcon(scan->mid, 0);
    }
    u_schd_add(scan_mngr_start_dwelling_task, (u32)scan, 0, 1);
}

/* Инфо пассивного скана канала ch: адрес считается один раз — с &scan->passive[ch] gcc -Os
 * повторяет ch·12 (__mulsi3) перед каждым доступом. */
static inline struct scan_passive_info *scan_passive_of(struct scan_mngr *scan, u32 ch)
{
    u32 a = (u32)scan + ch * sizeof(struct scan_passive_info);
    return (struct scan_passive_info *)(a + __builtin_offsetof(struct scan_mngr, passive));
}

/* scan_mngr::save_initial_passive_scan_info (0x8f81c0, 60 Б): на входе в канал ch —
 * время [0x853914] / 1000 и счётчик [0x805518] в инфо канала. */
void scan_mngr_save_initial_passive_scan_info(struct scan_mngr *scan, u32 ch)
{
    fw_log_emit0(0x29, 0x1016448);
    struct scan_passive_info *info = scan_passive_of(scan, ch);
    info->busy_ms = fw_divmod_unsigned(VOL(fw_stats_dash.nav_time), 1000);
    info->bcon_found = scan_stats.bcon_ind;
}

/* scan_mngr::calculate_passive_scan_info (0x8f16ec, 78 Б): на выходе из канала ch —
 * длительность и признак «счётчик вырос», инфо действительна ([+0x28] = 1). */
void scan_mngr_calculate_passive_scan_info(struct scan_mngr *scan, u32 ch)
{
    fw_log_emit0(0x29, 0x1016474);
    struct scan_passive_info *info = scan_passive_of(scan, ch);
    info->busy_ms = fw_divmod_unsigned(VOL(fw_stats_dash.nav_time), 1000) - info->busy_ms;
    info->bcon_found = ((s32)info->bcon_found >= (s32)scan_stats.bcon_ind) ? 0 : 1;
    info->valid = 1;
}

/* conn_tbl__slot_is_free (0x8da10c, 20 Б): слот cid соединения в cid_db свободен. */
u32 conn_tbl_slot_is_free(struct conn *e)
{
    return conn_mgr.cid_db[e->cid].used == 0;
}

/* scan_mngr::clean_all_lists (0x8f1aa0, 202 Б): освободить dband-инфо (+0xc) и
 * кандидатов (+0): снять таймер пробы [e+0x48], для найденного соединения [e+0x44]
 * без [e+0x34] — link_down (если cid занят). */
void scan_mngr_clean_all_lists(struct scan_mngr *scan)
{
    while (scan->scanned.count != 0) {
        struct dband_info *e = llist_pop_front(&scan->scanned);
        fw_log_emit3(0x29, 0x101544c, e->bssid_hi, e->bssid_lo, e->status);
        free_dband_info(e);
    }
    while (scan->pend.count != 0) {
        struct dband_info *e = llist_pop_front(&scan->pend);
        if (e->probe_tmr != 0) {
            u_schd_cancel(e->probe_tmr);
            e->probe_tmr = 0;
        }
        if (e->conn != 0 && e->own_bss == 0) {
            fw_log_emit3(0x29, 0x101549c, e->bssid_hi, e->bssid_lo, e->status);
            struct conn *conn = e->conn;
            if (conn_tbl_slot_is_free(conn) == 0)
                conn_mgr_link_down_evt(conn);
            else
                fw_log_emit1(0x19, 0x10154f0, (u32)conn);
        }
        fw_log_emit1(0x29, 0x1015538, (u32)e);
        free_dband_info(e);
    }
    fw_log_emit0(0x29, 0x1015578);
    scan->active_probs = 0;
}

/* scan_mngr::sm_stopped task (0x8f9ba8): событие SM_STOPPED автомату каналов. */
void scan_mngr_sm_stopped_task(u32 a0, u32 a1)
{
    struct scan_mngr *scan = (struct scan_mngr *)a0;
    (void)a1;
    fw_log_emit0(0x29, 0x101664c);
    basic_sm_handle_event(scan->cs, CS_EVT_SM_STOPPED, 0, 0, 0);
}

/* scan_mngr::sm_dwelling_ended (0x8f90e8, 120 Б): пребывание окончено — снять
 * discovery-бикон, очистить списки, задачей SM_STOPPED (следующий канал). */
void scan_mngr_sm_dwelling_ended(struct scan_mngr *scan)
{
    scan->dwell_stopped = 1;
    if (scan_discovery_bcon_on(scan)) {
        fw_log_emit0(0x29, 0x10165b4);
        tx_bcon_del_bcon(scan->mid);
    }
    if (scan->active_probs != 0)
        fw_log_emit1(0x19, 0x10165f0, scan->active_probs);
    scan_mngr_clean_all_lists(scan);
    u_schd_add(scan_mngr_sm_stopped_task, (u32)scan, 0, 1);
}

/* scan_mngr::stop_dwelling (0x8f9b24, 36 Б): прервать пребывание (действие
 * channels_switch_sm::action_abort_dwelling напрямую). */
void scan_mngr_stop_dwelling(struct scan_mngr *scan)
{
    fw_log_emit0(0x29, 0x1016398);
    channels_switch_sm_abort_dwelling(scan->cs);
}

/* ======================= завершение ======================= */

/* scan_mngr__update_step (0x8cbee8, 46 Б): время скана при соединении с учётом идущего
 * скана (TSF − TSF старта). */
u32 scan_mngr_update_step(struct scan_mngr *scan)
{
    if (scan->active == 0)
        return scan->connected_scan_time;
    u32 tsf[2];
    mac_read_tsf64(0, tsf, 0);
    return scan->connected_scan_time + (tsf[0] - scan->tsf_start[0]);
}

/* scan_mngr::update_connected_scan_time (0x8eaa88, 32 Б). */
void scan_mngr_update_connected_scan_time(struct scan_mngr *scan)
{
    u32 t = scan_mngr_update_step(scan);
    scan->connected_scan_time = t;
    fw_log_emit1(0x29, 0x10153c4, t);
}

/* l2mgr: WMI_ACS_PASSIVE_SCAN_COMPLETE_EVENTID (0x9005), vendor 0x8e5a5c (184 Б; в
 * NAMES-EXTRA l2mgr__send_scan_complete_evt): {dwell_time u32, starting_channel u16 = 3,
 * filled u8, status u8, scan_acs_info[filled] по 12 Б: channel, beacon_found,
 * busy_time u16}. info — 5 записей scan_mngr.passive (по номеру канала); заполненных
 * должно быть ровно filled (ассерт 0x1340). */
void l2mgr_send_acs_scan_complete_evt(u32 status, u32 mid, u32 dwell_ms, u32 filled,
                                      const struct scan_passive_info *info)
{
    struct wmi_scan_acs_info tmp[5];
    struct wmi_acs_passive_scan_complete_event *p = host_if_send_pair();
    p->dwell_time = dwell_ms;
    p->filled = (u8)filled;
    p->starting_channel = 3;
    p->status = (u8)status;
    memset0_words(tmp, sizeof(tmp));
    u32 n = 0;
    for (u32 i = 0; i < 5; i++) {
        const struct scan_passive_info *in = &info[i];
        if (in->valid == 0)
            continue;
        struct wmi_scan_acs_info *o = &tmp[n];
        o->channel = (u8)i;
        o->busy_time = (u16)in->busy_ms;
        o->beacon_found = (u8)in->bcon_found;
        n++;
    }
    if (filled != n)
        fw_sysassert_fatal((void *)0, 0x1340);
    u32 len = (u8)(filled * sizeof(struct wmi_scan_acs_info));
    memcpy_fw(p->scan_info, tmp, len);
    fw_log_emit3(0x2b, 0x100eb68, p->dwell_time, p->filled, p->starting_channel);
    low_sme_send_evt2sw(p, 0x9005, (u16)(len + 8), mid, 0, 0, 0);
    l2mgr_pending_op_clear(0);
}

/* vring_schd__resume_vring (0x8e2cbc, 42 Б): событие 0xb автомату lm_sm линка p. */
void vring_schd_resume_vring(struct lm_if *p)
{
    if (p->lm_sm == 0)
        fw_sysassert_fatal((void *)0, 0x1263);
    lm_sm_event(p->lm_sm, 0xb, 0, 0, 0);
}

/* l2_mgr::scan_complete_handle (0x8e45fc, 154 Б): после скана — у всех mid с
 * соединением (find_by_kind 1) при resume — событие 0xb в lm_sm соединения и метод [8]
 * активной таблицы колец (cid); затем при resume — системное состояние 3.
 * Аргумент mid vendor не читает (r0 затирается числом mid). */
void l2mgr_scan_complete_handle(u32 mid, u32 resume)
{
    u32 it;
    (void)mid;
    u32 cnt = mids_get_count();
    fw_log_emit0(0x29, 0x100f844);
    field_set_0x00_8e5dfc(&it, cnt);
    while (bit_iter_has_more(&it)) {
        struct mid *m = mid_list_by_mid_fw(bitmap_alloc_bit(&it));
        if (m == 0)
            fw_sysassert_fatal((void *)0, 0x16c4);
        struct conn *conn = mid_list_find_by_kind(m, 1);
        if (conn == 0)
            continue;
        if (resume != 0)
            vring_schd_resume_vring(&conn->lm);
        u32 cid = m->cid_mask;
        fw_log_emit2(0x29, 0x100f864, m->id, cid);
        struct vring_schd_if *tbl = vring_active_ring_table();
        tbl->vt->allow(tbl, cid);
    }
    if (resume != 0)
        sys_state_broadcast(3, 0);
}

/* scan_mngr::scan_done (0x8f8220, 226 Б): итог скана хосту. status (enum wmi_scan_status):
 * 0 — успех, 1 — сбой, 3 — без остановки приёма; при [scan+0x1c8] (прерван) — 2.
 * ACS (scan_type 2) — событие 0x9005, иначе WMI_SCAN_COMPLETE (0x100a). */
void scan_mngr_scan_done(struct scan_mngr *scan, u32 status)
{
    fw_log_emit0(0x29, 0x10155a8);
    if (scan->is_connected != 0)
        scan_mngr_update_connected_scan_time(scan);
    if (status != 3)
        discovery_rx_stop();
    scan_stats.scan_done += 1;
    scan_mngr_free_channel_list(scan);
    scan_mngr_clean_all_lists(scan);
    if (scan->aborted != 0)
        status = 2;
    u32 mid = scan->mid->id;
    if (scan->scan_type != 2) {
        fw_log_emit3(0x29, 0x10155c0, status, u_schd_now(), scan->scan_type);
        l2mgr_send_scan_complete_evt(status, mid);
    } else {
        fw_log_emit3(0x29, 0x1015614, status, u_schd_now(), scan->scan_type);
        l2mgr_send_acs_scan_complete_evt((u8)status, mid,
                                         fw_divmod_unsigned(scan->dwell_us, 1000),
                                         scan->num_channels, scan->passive);
    }
    scan->active = 0;
    fw_log_emit0(0x29, 0x1015670);
    lmac_if_discovery_mode_cfg(0, scan->ucode_scan_type);
    l2mgr_scan_complete_handle(scan->mid->id, 1);
}

/* scan_mngr::dwelling_done (0x8f2b88, 126 Б): все каналы пройдены (flag: 0 — успех,
 * 1 — сбой). Пока RX-секторы не исчерпаны ([0x85773c]) — скан заново со следующим
 * сектором по сохранённой команде scan+0x1f8; иначе итог (через swc_psc_sm при
 * соединении). */
void scan_mngr_dwelling_done(struct scan_mngr *scan, u32 flag)
{
    u8 s = (u8)(scan->rx_omni + 1);
    scan->rx_omni = s;
    if ((s32)s < (s32)VOL(fwsh_sets.n_sec[1][0])) {
        fw_log_emit1(0x29, 0x10156b0, s);
        scan_mngr_free_channel_list(scan);
        scan_mngr_clean_all_lists(scan);
        scan_mngr_start_scan(scan, (u8 *)&scan->cmd, scan->postpone_arg, scan->connected_arg);
        return;
    }
    fw_log_emit2(0x29, 0x10156e0, flag, scan->is_connected);
    if (scan->is_connected == 0)
        scan_mngr_scan_done(scan, flag);
    else
        basic_sm_handle_event(&scan->swc, SWC_EVT_DWELLING_DONE, flag, 0, 0);
}

/* ======================= channels_switch_sm (0x802fb4) ======================= */

/* channels_switch_sm::radio_allocated_cb (0x8e20b8): радио выделено. */
void channels_switch_sm_radio_allocated_cb(struct rm_req *x, u32 cs)
{
    (void)x;
    fw_log_emit0(0x29, 0x10175a0);
    basic_sm_handle_event((void *)cs, CS_EVT_RADIO_ALLOCATED, 0, 0, 0);
}

/* channels_switch_sm::channel_switched_cb (0x8c5ed4): канал настроен. */
void channels_switch_sm_channel_switched_cb(struct rm_req *x, u32 cs)
{
    (void)x;
    fw_log_emit0(0x29, 0x10175cc);
    basic_sm_handle_event((void *)cs, CS_EVT_CHANNEL_TUNED, 0, 0, 0);
}

/* channels_switch_sm::alloc_timeout_cb (0x8e4698): радио не выделено вовремя — STOP_SCAN. */
void channels_switch_sm_alloc_timeout_cb(u32 a0, u32 a1)
{
    struct channels_switch_sm *cs = (struct channels_switch_sm *)a0;
    (void)a1;
    fw_log_emit0(0x19, 0x1017634);
    cs->alloc_tmr = 0;
    basic_sm_handle_event(cs, CS_EVT_STOP_SCAN, 0, 0, 0);
}

/* channels_switch_sm::scan_timeout_cb (0x8e46c0): общий таймаут скана — STOP_SCAN. */
void channels_switch_sm_scan_timeout_cb(u32 a0, u32 a1)
{
    struct channels_switch_sm *cs = (struct channels_switch_sm *)a0;
    (void)a1;
    fw_log_emit0(0x19, 0x1017664);
    cs->scan_tmr = 0;
    basic_sm_handle_event(cs, CS_EVT_STOP_SCAN, 0, 0, 0);
}

/* channels_switch_sm::dwell_timeout_cb (0x8c980c): конец пребывания — STOP_DWELL. */
void channels_switch_sm_dwell_timeout_cb(u32 cs, u32 a1)
{
    (void)a1;
    fw_log_emit0(0x29, 0x10175f8);
    basic_sm_handle_event((void *)cs, CS_EVT_STOP_DWELL, 0, 0, 0);
}

/* channels_switch_sm::action_allocate_radio (0x8c20b8; START_SCAN в IDLE): включить
 * приём, запросить радио у радио-менеджера (request_secondary: cb, ctx, 0, 0xffff, mid) и
 * взвести таймеры выделения ([0x800484]) и скана ([0x800488]). */
void channels_switch_sm_action_allocate_radio(struct channels_switch_sm *cs)
{
    fw_log_emit0(0x29, 0x101723c);
    struct scan_mngr *scan = cs->scan;
    u32 disc = scan->scan_type == 3 && scan->discovery_mode == 1;
    discovery_rx_start(disc);
    u32 mid = cs->mid->id;
    struct radio_mgr *rm = radio_mgr_obj;
    cs->req = rm->vt->request_secondary(
        rm, channels_switch_sm_radio_allocated_cb, (u32)cs, 0, 0xffff, mid);
    cs->alloc_tmr = u_schd_schedule(channels_switch_sm_alloc_timeout_cb, (u32)cs, 0, 1,
                                    scan_alloc_timeout, 0, 0);
    cs->scan_tmr = u_schd_schedule(channels_switch_sm_scan_timeout_cb, (u32)cs, 0, 1,
                                   scan_timeout, 0, 0);
}

/* channels_switch_sm::action_pop_ch_and_tune (0x8c2228; RADIO_ALLOCATED, SM_STOPPED,
 * STOP_SCAN в STOPPING/ABORTING): снять таймер выделения, вернуть прошлый канал в пул;
 * каналов нет — SCAN_COMPLETED(1); иначе взять следующий: совпадает с текущим —
 * сразу CHANNEL_TUNED, нет — настройка радио-менеджером (sec_tune: cb, ctx, запрос,
 * 1, канал, mid). */
void channels_switch_sm_action_pop_ch_and_tune(struct channels_switch_sm *cs)
{
    if (cs->alloc_tmr != 0) {
        u_schd_cancel(cs->alloc_tmr);
        cs->alloc_tmr = 0;
        fw_log_emit0(0x29, 0x1017268);
    }
    if (cs->cur != 0) {
        mem_pool_free(CH_POOL, cs->cur);   /* 0x8f3154 */
        cs->cur = 0;
    }
    struct scan_mngr *scan = cs->scan;
    if (scan->channels.count == 0) {
        basic_sm_handle_event(cs, CS_EVT_SCAN_COMPLETED, 1, 0, 0);
        return;
    }
    u32 cur;
    radio_mgr_get_current_channel(&cur);
    struct scan_ch *e = llist_pop_front(&scan->channels);
    cs->cur = e;
    fw_log_emit2(0x29, 0x10172b8, e->channel, cur);
    u32 ch = e->channel;
    scan_stats.cur_channel = (u16)ch;
    if (cur == ch) {
        fw_log_emit1(0x29, 0x1017314, ch);
        basic_sm_handle_event(cs, CS_EVT_CHANNEL_TUNED, 0, 0, 0);
        return;
    }
    struct radio_mgr *rm = radio_mgr_obj;
    rm->vt->sec_tune(rm, channels_switch_sm_channel_switched_cb, (u32)cs, cs->req, 1, ch,
                     cs->mid->id);
}

/* channels_switch_sm::action_radio_tunned (0x8c22ec; CHANNEL_TUNED в TUNNING). */
void channels_switch_sm_action_radio_tunned(struct channels_switch_sm *cs, u32 a0)
{
    fw_log_emit1(0x29, 0x1017430, a0);
    scan_mngr_sm_ready_for_dwelling(cs->scan);
}

/* channels_switch_sm::action_start_dwelling (0x8c2354; START_DWELLING в TUNED):
 * снимок инфо канала, таймер пребывания [scan+0x70]. */
void channels_switch_sm_action_start_dwelling(struct channels_switch_sm *cs)
{
    struct scan_mngr *scan = cs->scan;
    u32 ch = cs->cur->channel;
    scan_mngr_save_initial_passive_scan_info(scan, ch);
    fw_log_emit2(0x29, 0x101736c, ch, scan->dwell_us);
    fw_log_emit0(0x29, 0x10173b4);
    scan->active_probs = 0;
    cs->dwell_tmr = u_schd_schedule(channels_switch_sm_dwell_timeout_cb, (u32)cs, 0, 1,
                                    scan->dwell_us, 0, 0);
}

/* channels_switch_sm::action_dwelling_stopped (0x8c2174; STOP_DWELL в DWELLING). */
void channels_switch_sm_action_dwelling_stopped(struct channels_switch_sm *cs)
{
    u32 ch = cs->cur->channel;
    fw_log_emit1(0x29, 0x10173f4, ch);
    scan_mngr_calculate_passive_scan_info(cs->scan, ch);
    scan_mngr_sm_dwelling_ended(cs->scan);
}

/* channels_switch_sm::action_scan_complete (0x8c230c; SCAN_COMPLETED в ALLOCATING/
 * TUNNING): снять таймер скана, освободить радио (lock_free), итог: a0 ≠ 0 (каналы
 * кончились) — успех. */
void channels_switch_sm_action_scan_complete(struct channels_switch_sm *cs, u32 a0)
{
    fw_log_emit1(0x29, 0x1017460, a0);
    if (cs->scan_tmr != 0) {
        u_schd_cancel(cs->scan_tmr);
        cs->scan_tmr = 0;
    }
    fw_log_emit1(0x29, 0x101749c, (u32)cs->req);
    radio_mgr_call_method_10(cs->req);
    scan_mngr_dwelling_done(cs->scan, a0 == 0);
}

/* channels_switch_sm::action_abort_allocate (0x8c2018; STOP_SCAN в ALLOCATING):
 * SCAN_COMPLETED(0) — сбой. */
void channels_switch_sm_action_abort_allocate(struct channels_switch_sm *cs)
{
    fw_log_emit0(0x29, 0x10174dc);
    basic_sm_handle_event(cs, CS_EVT_SCAN_COMPLETED, 0, 0, 0);
}

/* channels_switch_sm::scan_abort_tunning (0x8c209c; STOP_SCAN в TUNNING): пребывание
 * на настраиваемом канале сократить до 0x20 мкс. */
void channels_switch_sm_scan_abort_tunning(struct channels_switch_sm *cs)
{
    fw_log_emit0(0x29, 0x1017524);
    cs->scan->dwell_us = 0x20;
}

/* 0x802fc8: таблица переходов channels_switch_sm [событие][состояние] (событий 8, состояний 7) —
 * {действие, следующее состояние}; комментарий — «состояние → следующее» по vendor-именам. */
FWDATA(802fc8) const struct sm_trans channels_switch_sm_trans[8][7] = {
    [CS_EVT_START_SCAN] = {   /* EVT_START_SCAN */
        { SM_ACT(channels_switch_sm_action_allocate_radio), 1 }, /* STATE_IDLE → STATE_ALLOCATING_RADIO */
        { SM_ACT(basic_sm_error_handler), 1 },               /* STATE_ALLOCATING_RADIO → STATE_ALLOCATING_RADIO */
        { SM_ACT(basic_sm_error_handler), 2 },               /* STATE_TUNNING → STATE_TUNNING */
        { SM_ACT(basic_sm_error_handler), 3 },               /* STATE_TUNED → STATE_TUNED */
        { SM_ACT(basic_sm_error_handler), 4 },               /* STATE_DWELLING → STATE_DWELLING */
        { SM_ACT(basic_sm_error_handler), 5 },               /* STATE_STOPPING → STATE_STOPPING */
        { SM_ACT(basic_sm_error_handler), 6 },               /* STATE_ABORTING → STATE_ABORTING */
    },
    [CS_EVT_RADIO_ALLOCATED] = {   /* EVT_RADIO_ALLOCATED */
        { SM_ACT(basic_sm_error_handler), 0 },               /* STATE_IDLE → STATE_IDLE */
        { SM_ACT(channels_switch_sm_action_pop_ch_and_tune), 2 }, /* STATE_ALLOCATING_RADIO → STATE_TUNNING */
        { SM_ACT(basic_sm_error_handler), 2 },               /* STATE_TUNNING → STATE_TUNNING */
        { SM_ACT(basic_sm_error_handler), 3 },               /* STATE_TUNED → STATE_TUNED */
        { SM_ACT(basic_sm_error_handler), 4 },               /* STATE_DWELLING → STATE_DWELLING */
        { SM_ACT(basic_sm_error_handler), 5 },               /* STATE_STOPPING → STATE_STOPPING */
        { SM_ACT(basic_sm_error_handler), 6 },               /* STATE_ABORTING → STATE_ABORTING */
    },
    [CS_EVT_CHANNEL_TUNED] = {   /* EVT_CHANNEL_TUNED */
        { SM_ACT(basic_sm_error_handler), 0 },               /* STATE_IDLE → STATE_IDLE */
        { SM_ACT(basic_sm_error_handler), 1 },               /* STATE_ALLOCATING_RADIO → STATE_ALLOCATING_RADIO */
        { SM_ACT(channels_switch_sm_action_radio_tunned), 3 }, /* STATE_TUNNING → STATE_TUNED */
        { SM_ACT(basic_sm_error_handler), 3 },               /* STATE_TUNED → STATE_TUNED */
        { SM_ACT(basic_sm_error_handler), 4 },               /* STATE_DWELLING → STATE_DWELLING */
        { SM_ACT(basic_sm_error_handler), 5 },               /* STATE_STOPPING → STATE_STOPPING */
        { SM_ACT(basic_sm_error_handler), 6 },               /* STATE_ABORTING → STATE_ABORTING */
    },
    [CS_EVT_START_DWELLING] = {   /* EVT_START_DWELLING */
        { SM_ACT(basic_sm_error_handler), 0 },               /* STATE_IDLE → STATE_IDLE */
        { SM_ACT(basic_sm_error_handler), 1 },               /* STATE_ALLOCATING_RADIO → STATE_ALLOCATING_RADIO */
        { SM_ACT(basic_sm_error_handler), 2 },               /* STATE_TUNNING → STATE_TUNNING */
        { SM_ACT(channels_switch_sm_action_start_dwelling), 4 }, /* STATE_TUNED → STATE_DWELLING */
        { SM_ACT(basic_sm_error_handler), 4 },               /* STATE_DWELLING → STATE_DWELLING */
        { SM_ACT(basic_sm_error_handler), 5 },               /* STATE_STOPPING → STATE_STOPPING */
        { SM_ACT(basic_sm_error_handler), 6 },               /* STATE_ABORTING → STATE_ABORTING */
    },
    [CS_EVT_STOP_DWELL] = {   /* EVT_STOP_DWELL */
        { SM_ACT(basic_sm_error_handler), 0 },               /* STATE_IDLE → STATE_IDLE */
        { SM_ACT(basic_sm_error_handler), 1 },               /* STATE_ALLOCATING_RADIO → STATE_ALLOCATING_RADIO */
        { SM_ACT(basic_sm_error_handler), 2 },               /* STATE_TUNNING → STATE_TUNNING */
        { SM_ACT(basic_sm_error_handler), 3 },               /* STATE_TUNED → STATE_TUNED */
        { SM_ACT(channels_switch_sm_action_dwelling_stopped), 5 }, /* STATE_DWELLING → STATE_STOPPING */
        { SM_ACT(basic_sm_error_handler), 5 },               /* STATE_STOPPING → STATE_STOPPING */
        { SM_ACT(basic_sm_error_handler), 6 },               /* STATE_ABORTING → STATE_ABORTING */
    },
    [CS_EVT_SM_STOPPED] = {   /* EVT_SM_STOPPED */
        { SM_ACT(basic_sm_error_handler), 0 },               /* STATE_IDLE → STATE_IDLE */
        { SM_ACT(basic_sm_error_handler), 1 },               /* STATE_ALLOCATING_RADIO → STATE_ALLOCATING_RADIO */
        { SM_ACT(basic_sm_error_handler), 2 },               /* STATE_TUNNING → STATE_TUNNING */
        { SM_ACT(basic_sm_error_handler), 3 },               /* STATE_TUNED → STATE_TUNED */
        { SM_ACT(basic_sm_error_handler), 4 },               /* STATE_DWELLING → STATE_DWELLING */
        { SM_ACT(channels_switch_sm_action_pop_ch_and_tune), 2 }, /* STATE_STOPPING → STATE_TUNNING */
        { SM_ACT(channels_switch_sm_action_pop_ch_and_tune), 2 }, /* STATE_ABORTING → STATE_TUNNING */
    },
    [CS_EVT_SCAN_COMPLETED] = {   /* EVT_SCAN_COMPLETED */
        { SM_ACT(basic_sm_error_handler), 0 },               /* STATE_IDLE → STATE_IDLE */
        { SM_ACT(channels_switch_sm_action_scan_complete), 0 }, /* STATE_ALLOCATING_RADIO → STATE_IDLE */
        { SM_ACT(channels_switch_sm_action_scan_complete), 0 }, /* STATE_TUNNING → STATE_IDLE */
        { SM_ACT(basic_sm_error_handler), 3 },               /* STATE_TUNED → STATE_TUNED */
        { SM_ACT(basic_sm_error_handler), 4 },               /* STATE_DWELLING → STATE_DWELLING */
        { SM_ACT(basic_sm_error_handler), 5 },               /* STATE_STOPPING → STATE_STOPPING */
        { SM_ACT(basic_sm_error_handler), 2 },               /* STATE_ABORTING → STATE_TUNNING */
    },
    [CS_EVT_STOP_SCAN] = {   /* EVT_STOP_SCAN */
        { SM_ACT(basic_sm_error_handler), 0 },               /* STATE_IDLE → STATE_IDLE */
        { SM_ACT(channels_switch_sm_action_abort_allocate), 1 }, /* STATE_ALLOCATING_RADIO → STATE_ALLOCATING_RADIO */
        { SM_ACT(channels_switch_sm_scan_abort_tunning), 2 }, /* STATE_TUNNING → STATE_TUNNING */
        { SM_ACT(basic_sm_error_handler), 3 },               /* STATE_TUNED → STATE_TUNED */
        { SM_ACT(channels_switch_sm_abort_dwelling), 4 },    /* STATE_DWELLING → STATE_DWELLING */
        { SM_ACT(channels_switch_sm_action_pop_ch_and_tune), 2 }, /* STATE_STOPPING → STATE_TUNNING */
        { SM_ACT(channels_switch_sm_action_pop_ch_and_tune), 2 }, /* STATE_ABORTING → STATE_TUNNING */
    },
};
/* 0x802fb4: описатель channels_switch_sm (состояний 7, событий 8, старт STATE_IDLE); ид [0x10] пишет
 * статический конструктор. Имена — массивы ид строк журнала в fw_data. */
FWDATA(802fb4) struct sm_desc channels_switch_sm_desc = {
    .n_events = 8, .n_states = 7, .init_state = 0,
    .table = &channels_switch_sm_trans[0][0],
    .state_names = chsw_sm_state_names,   /* {STATE_IDLE, STATE_ALLOCATING_RADIO, STATE_TUNNING, STATE_TUNED, STATE_DWELLING, STATE_STOPPING, STATE_ABORTING} */
    .event_names = chsw_sm_event_names,
};

/* ======================= swc_psc_sm (0x8030e0) ======================= */

/* swc_psc_sm::sob_timeout_cb (0x8e7500): SOB не начался за 1 с — SCAN_ABORT(1). */
void swc_psc_sm_sob_timeout_cb(u32 sm, u32 a1)
{
    (void)a1;
    fw_log_emit0(0x29, 0x1017724);
    basic_sm_handle_event((void *)sm, SWC_EVT_SCAN_ABORT, 1, 0, 0);
    fw_log_emit0(0x29, 0x1017754);
}

/* swc_psc_sm::action_start_scan (0x8c23ac; SCAN_START в SCAN_IDLE): ждать SOB 1 с. */
void swc_psc_sm_action_start_scan(struct swc_psc_sm *sm, struct scan_mngr *scan)
{
    fw_log_emit0(0x29, 0x10176d4);
    sm->scan = scan;
    sm->sob_tmr = u_schd_schedule(swc_psc_sm_sob_timeout_cb, (u32)sm, 0, 1,
                                  0xf4240, 0, 0);
    fw_log_emit0(0x29, 0x10176fc);
}

/* swc_psc_sm::action_kick_channel_sw_sm (0x8c21a0; SOB_STARTED в WAIT_SOB_START):
 * снять таймер ожидания, START_SCAN автомату каналов. */
void swc_psc_sm_action_kick_channel_sw_sm(struct swc_psc_sm *sm)
{
    fw_log_emit0(0x29, 0x1017784);
    struct channels_switch_sm *cs = sm->scan->cs;
    u_schd_cancel(sm->sob_tmr);
    basic_sm_handle_event(cs, CS_EVT_START_SCAN, 0, 0, 0);
    fw_log_emit0(0x29, 0x10177b4);
}

/* swc_psc_sm::action_complete_scan (0x8c2144; DWELLING_DONE в DWELLING). */
void swc_psc_sm_action_complete_scan(struct swc_psc_sm *sm, u32 status)
{
    fw_log_emit0(0x29, 0x10177e4);
    scan_mngr_scan_done(sm->scan, status);
    fw_log_emit0(0x29, 0x1017810);
}

/* swc_psc_sm::action_abort_scan (0x8c2068; SCAN_ABORT в WAIT_SOB_START): итог
 * со статусом a0 (таймаут SOB — 1, scan_mngr::abort_scan — 2). Таймер ожидания SOB
 * vendor здесь не снимает (после abort_scan он остаётся взведённым). */
void swc_psc_sm_action_abort_scan(struct swc_psc_sm *sm, u32 a0)
{
    fw_log_emit0(0x29, 0x1017838);
    swc_psc_sm_action_complete_scan(sm, a0);
    fw_log_emit0(0x29, 0x1017860);
}

/* swc_psc_sm::action_stop_dwelling (0x8c23f4; SCAN_ABORT в DWELLING): STOP_SCAN
 * автомату каналов. */
void swc_psc_sm_action_stop_dwelling(struct swc_psc_sm *sm)
{
    fw_log_emit0(0x29, 0x1017888);
    basic_sm_handle_event(sm->scan->cs, CS_EVT_STOP_SCAN, 0, 0, 0);
    fw_log_emit0(0x29, 0x10178b4);
}

/* 0x8030e0: описатель swc_psc_sm (состояний 3, событий 4, старт STATE_SCAN_IDLE); ид [0x10] пишет
 * статический конструктор. Имена — массивы ид строк журнала в fw_data. */
FWDATA(8030e0) struct sm_desc swc_psc_sm_desc = {
    .n_events = 4, .n_states = 3, .init_state = 0,
    .table = &swc_psc_sm_trans[0][0],   /* таблица переходов — fw_data 0x801650 */
    .state_names = swc_psc_sm_state_names,   /* {STATE_SCAN_IDLE, STATE_WAIT_SOB_START, STATE_DWELLING} */
    .event_names = swc_psc_sm_event_names,
};

/* ======================= имена состояний и событий автоматов (fw_data) ======================= */

/* 0x801608: имена состояний channels_switch_sm (описатель 0x802fb4). */
FWDATA(801608) const u32 chsw_sm_state_names[7] = {
    0x010205fc,   /* STATE_IDLE */
    0x01020607,   /* STATE_ALLOCATING_RADIO */
    0x0102061e,   /* STATE_TUNNING */
    0x0102062c,   /* STATE_TUNED */
    0x01020638,   /* STATE_DWELLING */
    0x01020647,   /* STATE_STOPPING */
    0x01020656,   /* STATE_ABORTING */
};

/* 0x801624: имена событий channels_switch_sm (описатель 0x802fb4). */
FWDATA(801624) const u32 chsw_sm_event_names[8] = {
    0x01020665,   /* EVT_START_SCAN */
    0x01020674,   /* EVT_RADIO_ALLOCATED */
    0x01020688,   /* EVT_CHANNEL_TUNED */
    0x0102069a,   /* EVT_START_DWELLING */
    0x010206ad,   /* EVT_STOP_DWELL */
    0x010206bc,   /* EVT_SM_STOPPED */
    0x010206cb,   /* EVT_SCAN_COMPLETED */
    0x010206de,   /* EVT_STOP_SCAN */
};

/* 0x80168c: имена состояний swc_psc_sm (описатель 0x8030e0). */
FWDATA(80168c) const u32 swc_psc_sm_state_names[3] = {
    0x01020700,   /* STATE_SCAN_IDLE */
    0x01020710,   /* STATE_WAIT_SOB_START */
    0x01020725,   /* STATE_DWELLING */
};

/* 0x801698: имена событий swc_psc_sm (описатель 0x8030e0). */
FWDATA(801698) const u32 swc_psc_sm_event_names[4] = {
    0x01020734,   /* EVT_SCAN_START */
    0x01020743,   /* EVT_SOB_STARTED */
    0x01020753,   /* EVT_DWELLING_DONE */
    0x01020765,   /* EVT_SCAN_ABORT */
};

/* 0x801650: переходы swc_psc_sm [событие][состояние] (описатель 0x8030e0). */
FWDATA(801650) const struct sm_trans swc_psc_sm_trans[4][3] = {
    [SWC_EVT_SCAN_START] = {
        [SWC_ST_SCAN_IDLE] = { SM_ACT(swc_psc_sm_action_start_scan), SWC_ST_WAIT_SOB_START }, /* 0x8c23ac */
        [SWC_ST_WAIT_SOB_START] = { SM_ACT(basic_sm_error_handler), SWC_ST_WAIT_SOB_START }, /* 0x8c9a54 */
        [SWC_ST_DWELLING] = { SM_ACT(basic_sm_error_handler), SWC_ST_DWELLING }, /* 0x8c9a54 */
    },
    [SWC_EVT_SOB_STARTED] = {
        [SWC_ST_SCAN_IDLE] = { SM_ACT(basic_sm_error_handler), SWC_ST_SCAN_IDLE }, /* 0x8c9a54 */
        [SWC_ST_WAIT_SOB_START] = { SM_ACT(swc_psc_sm_action_kick_channel_sw_sm), SWC_ST_DWELLING }, /* 0x8c21a0 */
        [SWC_ST_DWELLING] = { SM_ACT(sm_action_nop_b), SWC_ST_DWELLING }, /* 0x8df514 */
    },
    [SWC_EVT_DWELLING_DONE] = {
        [SWC_ST_SCAN_IDLE] = { SM_ACT(basic_sm_error_handler), SWC_ST_SCAN_IDLE }, /* 0x8c9a54 */
        [SWC_ST_WAIT_SOB_START] = { SM_ACT(basic_sm_error_handler), SWC_ST_WAIT_SOB_START }, /* 0x8c9a54 */
        [SWC_ST_DWELLING] = { SM_ACT(swc_psc_sm_action_complete_scan), SWC_ST_SCAN_IDLE }, /* 0x8c2144 */
    },
    [SWC_EVT_SCAN_ABORT] = {
        [SWC_ST_SCAN_IDLE] = { SM_ACT(basic_sm_error_handler), SWC_ST_SCAN_IDLE }, /* 0x8c9a54 */
        [SWC_ST_WAIT_SOB_START] = { SM_ACT(swc_psc_sm_action_abort_scan), SWC_ST_SCAN_IDLE }, /* 0x8c2068 */
        [SWC_ST_DWELLING] = { SM_ACT(swc_psc_sm_action_stop_dwelling), SWC_ST_DWELLING }, /* 0x8c23f4 */
    },
};
