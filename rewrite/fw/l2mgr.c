// SPDX-License-Identifier: AGPL-3.0-or-later
/* L2-менеджер: l2mgr__mac_bringup (0x8f6ab8) + trigger. Размещается в .textlate. */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/rf_obj.h"
#include "../include/rx_ring.h"
#include "../include/mbox.h"
#include "../include/conn.h"
#include "../include/link_loss.h"
#include "../include/phy_monitor.h"
#include "../include/mid.h"
#include "../include/stream.h"
#include "../include/vring_schd.h"
#include "../include/ieee80211.h"
#include "../include/lmac_cmd.h"
#include "../include/sys_cfg.h"
#include "../include/fwdata.h"
#include "../include/rf_kill.h"
#include "../include/macq_desc.h"
#include "../include/fwdata.h"

/* 0x801518: наборы параметров поддержания линка (link_maintain_cfg_copy). Пороги (мкс): старение TX — 5 с, keep-alive
 * в простое у точки (наборы 0, 1) — 1 с. Изменено (vendor: старение 60 с, keep-alive точки 30 / 5 с — пропавшая без
 * разъединения станция числилась у точки ~90 с; длинное старение терпело сон станции, энергосбережения в SparRAW
 * нет — очередь без продвижения 5 с = линк потерян). Хост меняет их WMI_LINK_MAINTAIN_CFG_WRITE. */
FWDATA(801518) const struct ll_cid_cfg ll_cfg_presets[4] = {
    { .flags = 0x3, .period = 10000, .ageing_thr = 5000000, .ka_period_hi = 1000000, .ka_period_lo = 1000000,
      .snr_lo = 5, .snr_hi = 15, .bcn_thr = 20, .bcn_snr = -255 },
    { .flags = 0x3, .period = 10000, .ageing_thr = 5000000, .ka_period_hi = 1000000, .ka_period_lo = 1000000,
      .snr_lo = 5, .snr_hi = 15, .bcn_thr = 10, .bcn_snr = -255 },
    { .flags = 0x7, .period = 10000, .ageing_thr = 5000000, .ka_period_hi = 31000000, .ka_period_lo = 1000000,
      .snr_lo = 5, .snr_hi = 15, .bcn_thr = 20, .bcn_snr = -255 },
    { .flags = 0x7, .period = 10000, .ageing_thr = 5000000, .ka_period_hi = 1000000, .ka_period_lo = 1000000,
      .snr_lo = 5, .snr_hi = 15, .bcn_thr = 10, .bcn_snr = -255 },
};

/* 14 шагов mac_bringup (портированы в mac_bringup.c/macq.c). */


/* Поле слова w, биты [lo .. lo+n−1] = v (bits__set32_s* → bf__set_field_word_fw 0x8edcb8). */
static void l2_bf32(u32 *w, u32 lo, u32 n, u32 v)
{
    u32 m = ((1u << n) - 1u) << lo;
    *w = (*w & ~m) | ((v << lo) & m);
}

/* Шаг 4 (0x8f7f38, 98 Б; в справке vendor-имя ftm_main_sm__radio_allocated_cb — строки журнала у
 * функции нет): две LMAC-команды 0x07 (0x10 Б) — диапазоны очередей MAC для наборов qset
 * (ucode_cmd_0x07_handler): подтип 1 — слово @4 {0..4 = 0x19, 8..12 = 0x1c,
 * 16..20 = 0x18, 24..28 = 0x19} (qset4: очереди 0x19..0x1c, qset5: 0x18..0x19); подтип 2 —
 * слово @8 {0..4 = 0, 8..12 = 0xa} (qset6: 0..0xa). Прочие биты слов — как в буфере пула
 * (как у vendor; ucode их не читает). */
__attribute__((section(".textlate"))) void lmac_if_send_qset_ranges(void)
{
    struct lmac_cmd_qset_ranges *b = lmac_cmd_pool_alloc();
    b->sub = 1;
    l2_bf32(&b->range_q4_q5, 0, 5, 0x19);
    l2_bf32(&b->range_q4_q5, 8, 5, 0x1c);
    l2_bf32(&b->range_q4_q5, 16, 5, 0x18);
    l2_bf32(&b->range_q4_q5, 24, 5, 0x19);
    lmac_if_post_cmd(b, 7, 0x10, 0);
    b = lmac_cmd_pool_alloc();
    b->sub = 2;
    l2_bf32(&b->range_q6, 0, 5, 0);
    l2_bf32(&b->range_q6, 8, 5, 0xa);
    lmac_if_post_cmd(b, 7, 0x10, 0);
}

/* lmac_if_send_cmd_0x00 (0x8db8cc, 124 Б): LMAC-команда 0x00 (0x44 Б) — конфигурация MAC
 * (ucode_cmd_0x00_handler): 0xc Б cfg, cfg w0c/w10 → regs.w0c/w10 (@0xc/@0x10), cfg w[0..3] →
 * regs.w14[2..5] (@0x1c..@0x28), regs.qset_mode (@0x2c) бит 0..3 = 8, ifs_us[0] = a1,
 * ifs_us[1] = a2, ifs_us[2] = 825, ifs_us[3]/[4] = 0xa5, x3c = 4, x3e = 2, rf_chain — байт
 * rf_obj.rf_idx (0x8042c8). regs.w14[0..1] и прочие биты qset_mode — как в буфере пула (vendor
 * их не пишет). Нет буфера — команды нет. */
__attribute__((section(".textlate"))) void lmac_if_send_cmd_0x00(const struct lmac_mac_cfg_src *cfg, u32 a1, u32 a2)
{
    /* volatile: с полями struct gcc сливает пары sth (+0x34/+0x36, +0x3c/+0x3e) в одно st —
     * vendor пишет полусловами в этом порядке. */
    volatile struct lmac_cmd_mac_cfg *b = mem_pool_alloc_locked(&lmac_mbox.mb);
    if (b == 0)
        return;
    b->ifs_us[0] = (u16)a1;
    b->rf_chain = *(volatile u8 *)&rf_obj.rf_idx;
    b->ifs_us[3] = 0xa5;
    b->ifs_us[4] = 0xa5;
    b->ifs_us[2] = 825;
    b->ifs_us[1] = (u16)a2;
    memcpy_fw((void *)b->regs.b0, cfg->b0, 0xc);
    b->regs.w10 = cfg->w10;
    b->regs.w0c = cfg->w0c;
    b->regs.w14[3] = cfg->w[1];
    b->regs.w14[2] = cfg->w[0];
    b->regs.w14[5] = cfg->w[3];
    b->regs.w14[4] = cfg->w[2];
    b->regs.qset_mode = (b->regs.qset_mode & ~0xfu) | 8u;
    b->x3c = 4;
    b->x3e = 2;
    lmac_if_post_cmd(b, 0, 0x44, 0);
}

/* lmac_if__send_init_cfg (0x8f3db8, 164 Б): шаг 9 — конфигурация MAC (0x24 Б на стеке) в
 * LMAC 0x00 с a1 = 495, a2 = 0xa. Байты 0..0x13: 4, 1, 0x96, 0, 0xa1, 0, 0x7b, 0, 0x16, 0,
 * 0x12, 0, 0x60, 0, 0x91, 2, 0xa, 2, 0x6a, 0; слова @0x14 |= 0xf, @0x18 |= 0x3f,
 * @0x1c = (… & ~0xf) | 8, @0x20 = 0x38 (биты 6..31 = 0 через bits__set32_s6_w26).
 * vendor не инициализирует стек: старшие биты @0x14/@0x18/@0x1c — остатки стека
 * (в ucode уходят в mac_cfg +0x1c..+0x24 копией, разбираемые ucode поля — младшие биты).
 * У нас буфер обнулён — значения определены. */
__attribute__((section(".textlate"))) void lmac_if_send_init_cfg(void)
{
    static const u8 head[0x14] = {
        4, 1, 0x96, 0, 0xa1, 0, 0x7b, 0, 0x16, 0, 0x12, 0, 0x60, 0, 0x91, 2,
        0xa, 2, 0x6a, 0,
    };
    struct lmac_mac_cfg_src c;
    memset0_words(&c, sizeof(c));
    memcpy_fw(c.head, head, sizeof(head));
    c.w[0] |= 0xf;
    c.w[1] |= 0x3f;
    c.w[2] = (c.w[2] & ~0xfu) | 8u;
    c.w[3] = (c.w[3] & ~0xfu) | 0x38u;
    l2_bf32(&c.w[3], 6, 26, 0);
    lmac_if_send_cmd_0x00(&c, 495, 0xa);
}

/* l2mgr__mac_bringup, хвост при [gp,400] = [0x800314] != 0 (0x8f6b0c, 62 Б): регистры MAC
 * 0x886438/0x88644c = 0x1f, 0x886210/0x886224 = 0xa3ff, 0x886508/0x88651c = 3,
 * 0x886840/0x886854 = 7, 0x886028 = −120. */
__attribute__((section(".textlate"))) void l2mgr_post_bringup(void)
{
    MMIO32(HW_MAC_ICR_886434_ICR) = 0x1f;
    MMIO32(HW_MAC_ICR_886434_IMC) = 0x1f;
    MMIO32(HW_PRS_ICR) = 0xa3ff;
    MMIO32(HW_PRS_IMC) = 0xa3ff;
    MMIO32(HW_MAC_ICR_886504_ICR) = 3;
    MMIO32(HW_MAC_ICR_886504_IMC) = 3;
    MMIO32(HW_MAC_ICR_88683C_ICR) = 7;
    MMIO32(HW_MAC_ICR_88683C_IMC) = 7;
    MMIO32(HW_MAC_IRQ_CTL_886028) = (u32)-120;
}

/* l2mgr__mac_bringup (0x8f6ab8, 84 Б): 14-шаговая инициализация MAC. */
__attribute__((section(".textlate"))) void l2mgr_mac_bringup(void)
{
    hwd_mac_enable_multicast();          /* 1 */
    mac_bringup_init_seq();              /* 2 — пишет MACQ (здесь был вис) */
    mac_bringup_init_rx_desc();          /* 3 */
    lmac_if_send_qset_ranges();          /* 4 */
    mac_parser_configure(0, 0x1f);       /* 5 */
    mac_bringup_prog_881000();           /* 6 */
    mac_bringup_prog_881b00();           /* 7 */
    vring_reg_write_locked_0c((u32)-1, 0); /* 8 */
    lmac_if_send_init_cfg();             /* 9 */
    l2mgr_bringup_pair(1);               /* 10 */
    mac_bringup_init_dma_ctrl();         /* 11 */
    mac_bringup_init_tx_queues();        /* 12 */
    mac_set_886838_b0(0);                /* 13 */
    mac_bringup_set_886a80_ctl_bit0();   /* 14 */
    if (l2mgr_mac_post_bringup_en != 0)
        l2mgr_post_bringup();
}

/* rx_macq__init (0x8d97f4, 118 Б): две RX-MACQ (0 и 1) и привязка всех их очередей к
 * RX-кольцу 4. */
__attribute__((section(".textlate"))) void rx_macq_init(void)
{
    rx_macq_setup(rx_macq_entry_addr(0), 0, 0, 1312, 0xc00, 421, 0, 4, 0);
    rx_macq_bind_all_queues(rx_macq_entry_addr(0), 4, 0);
    rx_macq_setup(rx_macq_entry_addr(1), 1, 5, 544, 0xda5, 393, 4, 4, 0);
    rx_macq_bind_all_queues(rx_macq_entry_addr(1), 4, 0);
}

/* rx_pool__configure_ring (0x8d8ef8, 46 Б): кольцо дескрипторов r (n шт.) объекта c
 * (c->ring: rx_pool__configure_step) и DMA-кольцо m. */
__attribute__((section(".textlate"))) void rx_pool_configure_ring(struct rx_ring *c, u32 r, u32 n, u32 m)
{
    rx_pool_configure_step(&c->ring, r, n, m);
    dma_mgr_configure_ring(m, r & 0x3ffffu, 0, n, 1, 1, 0, 0);
}
/* wmi_evt__notify_fw_ready (0x8f5d60): WMI_READY_EVENTID (0x1001, 0x14 Б) хосту.
 * Поля wmi_ready_event, которые vendor не пишет (abi, phy_capability, max_assoc_sta),
 * остаются как в буфере пула — как у vendor. */
__attribute__((section(".textlate"))) void wmi_evt_notify_fw_ready(void *mac, u32 mid)
{
    u8 *p = (u8 *)host_if_send_pair();
    memcpy_fw(p + 8, mac, 6);
    *(u32 *)p = fw_ver_build;               /* sw_version (vendor — 1000, его build) */
    p[0xf] = 0;                             /* numof_additional_mids */
    p[0x10] = hwd_rfc_read_get_result();    /* rfc_read_calib_result */
    fw_log_emit3(0x2b, 0x100f7e4, 0 /* OOB — только SparRAW-pro */, *(u16 *)((u8 *)mac + 4), *(u32 *)mac);
    low_sme_send_evt2sw(p, 0x1001, 0x14, mid, 0, 0, 0);
}
/* ---------------- sys_state__broadcast ---------------- */

/* l2_mgr__chk_sys_idle (0x8c6508, 84 Б): 1 — ни у одного открытого mid (битовая карта
 * [0x800259]) нет активных соединений. st не используется. Записи нет — ассерт 0x16c5
 * (vendor после него идёт дальше). */
static u32 l2_mgr_chk_sys_idle(u32 st)
{
    u32 it = mids_get_count(), idle = 1;
    (void)st;
    while (bit_iter_has_more(&it)) {
        struct mid *e = mid_list_by_mid_fw(bitmap_alloc_bit(&it));
        if (e == 0)
            fw_sysassert_fatal(__builtin_return_address(0), 0x16c5);
        if (mid_count_active_conns(e) != 0)
            idle = 0;
    }
    return idle;
}

/* Обработчики смены системного состояния (вызовы sys_state__broadcast 0x8e8a14 — все
 * портированы: служба температуры ниже, calib_mngr (power_mgr_ut_dispatch — PS, вырезан),
 * conn_mgr, phy_monitor, scan_mngr; переходы — по таблицам vendor в fw_data). */

/* Служба температуры (gp-переменные vendor): [0x80017c] — задача таймера, [0x800150] —
 * «остановлена», [0x800174] — разрешена по системному состоянию, [0x8000f4] — время
 * последнего измерения, [0x800020] — период (×16 тиков u_schd), [0x800024] — минимальная
 * задержка, [0x80002c]/[0x800028] — режим 3 → флаг, [0x8002c8] — запрет. */
#define TS_TASK     (temp_timer_task)
#define TS_STOPPED  (temp_stopping)
#define TS_ENABLED  (temp_enabled)

/* temp_sense__schedule (0x8e494c, 62 Б): снять задачу службы; delay ≠ 0 — поставить
 * TEMPERATURE_SERVICE::timer_exp_handler (vendor передаёт его числом 0x29438 — у нас
 * адрес функции) через delay, иначе вызвать сразу с 0. */
void temp_sense_schedule(u32 delay)
{
    if (TS_TASK != 0) {
        u_schd_cancel(TS_TASK);
        TS_TASK = 0;
    }
    if (delay != 0)
        TS_TASK = u_schd_schedule(temperature_service_timer_exp_handler, 0, 0, 1, delay, 0, 0);
    else
        temperature_service_timer_exp_handler(0, 0);
}

/* temp_sense__read_and_check (0x8e7828, 82 Б): только ASIC и без запрета [0x8002c8]:
 * служба работает; задержка до измерения — остаток периода (период − прошедшее × 16) не
 * меньше [0x800024], если с прошлого измерения прошло меньше периода и остаток > 0x10;
 * иначе [0x800024]. */
static void temp_sense_read_and_check(void)
{
    u32 now, last, per, el, rem, d;
    if (platform_is_asic() == 0 || temp_sense_disable != 0)
        return;
    TS_STOPPED = 0;
    now = u_schd_now();
    last = temp_last_meas_time;
    per = temp_period;
    el = (now - last) << 4;
    rem = per - el;
    if (temp_rf_meas_mode == 3)
        temp_rf_meas_flag = 1;
    d = temp_min_delay;
    if (last != 0xffffffffu && el < per && rem >= 0x11 && d <= rem)
        d = rem;
    temp_sense_schedule(d);
}

/* temp_sense__stop (0x8e7ea4, 32 Б): только ASIC — снять задачу, служба остановлена. */
static void temp_sense_stop(void)
{
    if (platform_is_asic() == 0)
        return;
    if (TS_TASK != 0) {
        u_schd_cancel(TS_TASK);
        TS_TASK = 0;
    }
    TS_STOPPED = 1;
}

/* 0x8027b4: таблица переходов switch vendor temp_sense__on_system_state (0x8e890c;
 * ldb, цель = 0x8e8920 + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(8027b4) const u8 temp_sense_on_system_state_jt[23] = {
    0x18, 0x18, 0x04, 0x00, 0x04, 0x00, 0x00, 0x04, 0x00, 0x04, 0x00, 0x04,
    0x00, 0x04, 0x04, 0x04, 0x00, 0x10, 0x0c, 0x12, 0x10, 0x0c, 0x18,
};

/* temp_sense__on_system_state (0x8e890c, 72 Б; таблица байт 0x8027b4): по состоянию st —
 * A (3, 5, 6, 8, 10, 12, 16): система простаивает (idle, нет соединения) — запрет и стоп,
 * иначе разрешить и измерять; B (2, 4, 7, 9, 11, 13..15): запрет и стоп; 0, 1, 22 — ничего;
 * 17..21 и ≥ 23 — ассерт 0x3001 (у vendor 17/20 — стоп, 18/21 — измерять, если разрешено:
 * PS, больше не рассылаются). */
void temp_sense_on_system_state(u32 st, u32 idle, u32 conn)
{
    static const u8 kind[23] = {
        0, 0, 'B', 'A', 'B', 'A', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'B', 'B',
        'A', 'F', 'F', 'F', 'F', 'F', 0,        /* 17/18/20/21 (PS, у vendor D/C) — не рассылаются */
    };
    if (st >= 23) {
        fw_sysassert_fatal(__builtin_return_address(0), 0x3001);
        return;
    }
    switch (kind[st]) {
    case 'A':
        if (conn == 0 && idle == 1) {
            TS_ENABLED = 0;
            temp_sense_stop();
        } else {
            TS_ENABLED = 1;
            temp_sense_read_and_check();
        }
        break;
    case 'B':
        TS_ENABLED = 0;
        temp_sense_stop();
        break;
    case 'F':
        fw_sysassert_fatal(__builtin_return_address(0), 0x3001);
        break;
    default:
        break;
    }
}
/* link_maintain_cfg__copy (0x8cc170, 42 Б): набор параметров поддержания линка idx
 * (ll_cfg_presets[idx], 0x801518) в dst; idx ≥ 4 или dst = 0 — 0. */
static u32 link_maintain_cfg_copy(u32 idx, void *dst)
{
    if (idx >= 4 || dst == 0)
        return 0;
    memcpy_fw(dst, &ll_cfg_presets[idx], 0x24);
    return 1;
}

/* 0x8c3a5c (100 Б): выбрать набор параметров поддержания линка — есть соединение
 * (conn ≠ 0): набор (flag ≠ 0), иначе 2 + (flag ≠ 0) — и разложить его во все 8 записей
 * cid (ll_ctx.cfg). */
static void link_maintain_cfg_apply(u32 conn, u32 flag)
{
    u32 cfg[0x24 / 4];
    u32 sel = (conn != 0) ? (flag != 0) : 2u + (flag != 0);
    u32 i;
    link_maintain_cfg_copy(sel, cfg);
    fw_log_emit3(0x2b, 0x100bed0, conn, flag, sel);
    for (i = 0; i < SPARRAW_MAX_STA; i++)
        memcpy_fw(&ll_ctx.cfg[i], cfg, 0x24);
}

/* Мониторинг потери линка conn_mgr — link_loss.c. */


/* 0x802388: таблица переходов switch vendor conn_mgr__system_state_evt_handler (0x8e8954;
 * ldw, цель = 0x8e8970 + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(802388) const u16 conn_mgr_system_state_evt_handler_jt[23] = {
    0x0000, 0x003c, 0x003c, 0x003c, 0x003c, 0x0007, 0x003c, 0x0014,
    0x003c, 0x003c, 0x0000, 0x003c, 0x003c, 0x003c, 0x003c, 0x003c,
    0x003c, 0x0021, 0x002a, 0x0036, 0x0021, 0x002a, 0x0033,
};

/* conn_mgr::system_state_evt_handler (0x8e8954, 156 Б; таблица полуслов 0x802388):
 * 0, 10 — параметры поддержания линка по наличию соединения (0x8c3a5c); 5 — соединение
 * cid = arg установлено: мониторинг потери линка; 7 — разорвано: остановить мониторинг
 * (0x8e7fb4 → lm_if соединения); 22 — BI всем соединениям; 19 и ≥ 23 — ассерт 0x1341;
 * прочие — ничего. У vendor 17, 20 / 18, 21 — PS (перевзвод детекторов / возобновление
 * vring); здесь — ассерт, как 19: эти состояния больше не рассылаются. */
void conn_mgr_system_state_evt_handler(u32 st, u32 arg)
{
    switch (st) {
    case 0: case 10:
        link_maintain_cfg_apply(mid_state_is_2_or_3(0), 0);
        break;
    case 5:
        fw_log_emit1(0x2b, 0x100bf48, arg);
        conn_mgr_start_link_loss_monitoring(conn_mgr_by_cid(arg));
        break;
    case 7:
        fw_log_emit1(0x2b, 0x100bf90, arg);
        lm_if_stop_link_loss_monitoring(&conn_mgr_by_cid(arg)->lm);
        break;
    case 22:
        conn_mgr_bi_evt_all_conns();
        break;
    case 17: case 18: case 20: case 21:     /* 17/18/20/21 — вход/выход из сна (PS) — больше не рассылаются: энергосбережение вырезано (см. fw/action.c psc_req_reject) */
    case 19:
        fw_sysassert_fatal(__builtin_return_address(0), 0x1341);
        break;
    default:
        if (st >= 23)
            fw_sysassert_fatal(__builtin_return_address(0), 0x1341);
        break;
    }
}

/* 0x8cdc80 (56 Б): соединение cid разорвано — время скана при соединении scan_mngr его
 * записи mid = 0. Нет соединения — ассерт 0x1246 (vendor идёт дальше
 * с нулевым указателем — не повторяем). */
static void scan_mngr_on_conn_lost(u32 cid)
{
    struct conn *conn = conn_mgr_by_cid(cid);
    struct scan_mngr *scan;
    if (conn == 0) {
        fw_sysassert_fatal(__builtin_return_address(0), 0x1246);
        return;
    }
    scan = conn->mid->disc.scan;
    fw_log_emit0(0x29, 0x10163b4);
    scan->connected_scan_time = 0;
}

/* scan_mngr::system_state_evt_handler (0x8e89f0, 36 Б): при st == 7 — журнал и 0x8cdc80(arg). */
void scan_mngr_system_state_evt_handler(u32 st, u32 arg)
{
    if (st != 7)
        return;
    fw_log_emit1(0x2b, 0x10163fc, arg);
    scan_mngr_on_conn_lost(arg);
}

/* sys_state__broadcast (0x8e8a14, 90 Б): разослать подсистемам смену системного
 * состояния st (arg — параметр события). idle — l2_mgr__chk_sys_idle, conn —
 * mid__state_is_2_or_3(0) (запись mid 0 обязана существовать — как у vendor). */
__attribute__((section(".textlate"))) void sys_state_broadcast(u32 st, u32 arg)
{
    u32 idle = l2_mgr_chk_sys_idle(st);
    u32 conn = mid_state_is_2_or_3(0);
    temp_sense_on_system_state(st, idle, conn);
    /* power_mgr_ut_dispatch (PS-менеджер по системному состоянию) — PS вырезан. */
    calib_mngr_system_state_evt_handler(st, arg);
    conn_mgr_system_state_evt_handler(st, arg);
    phy_monitor_on_system_state(&phy_monitor, st, idle, conn);
    scan_mngr_system_state_evt_handler(st, arg);
}

/* rx_pool__init (0x8d928c, 84 Б): RX-буферный пул + RX-MACQ init. */
__attribute__((section(".textlate"))) void rx_pool_init(void)
{
    memset0_words(rx_pkt_mem, sizeof(rx_pkt_mem));
    mem_pool_init(&rx_ring.pool, rx_pkt_mem, sizeof(rx_pkt_mem[0]), RX_PKT_MEM_N);
    rx_macq_init();
    memset0_words(rx_ring_mem, sizeof(rx_ring_mem));
    rx_pool_configure_ring(&rx_ring, (u32)rx_ring_mem, RX_RING_MEM_N, 0x4);
}


/* mid_ctx_pool__init (0x8f56d0, 48 Б): пул элементов списка каналов 0x842c74 (10 × 0xc)
 * и счётчики скана scan_stats (7 полуслов 0x805514). */
static void mid_ctx_pool_init(void)
{
    u32 i;
    mem_pool_init(&scan_ch_pool, scan_ch_mem, sizeof(struct scan_ch), SCAN_CH_N);
    for (i = 0; i < 7; i++)
        scan_stats.h[i] = 0;
}

/* mid_ctx__init_pools (0x8d91f4, 60 Б): пул записей mid mid_pool (0x804e7c, 1 × 0x2b0),
 * пустой список mid_list (0x804e70), битовая карта mid [0x800259] = 0, fwsh_long_range = 0. */
__attribute__((section(".textlate"))) void mid_ctx_init_pools(void)
{
    mid_ctx_pool_init();
    mem_pool_init(&mid_pool, mid_recs, sizeof(struct mid), MID_RECS_N);
    llist_init(&mid_list);
    mid_open_bitmap = 0;
    fwsh_long_range = 0;
}

/* ---------------- детекторы потери связи ---------------- */

/* detector__init_common (0x8d8fa0, 60 Б). Время u_schd vendor читает и не использует. */
void detector_init_common(struct psvc *o, u32 a1, u32 a2, u32 a3, u32 a4)
{
    o->type = a4;
    (void)u_schd_now();
    o->period = a1;
    o->timer_arg = a2;
    o->catch_up = a3;
    o->timer = 0;
    o->run_start = 0xffffffffu;
    o->run_end = 0xffffffffu;
    o->end_tsf[0] = 0xffffffffu;
    o->end_tsf[1] = 0xffffffffu;
    o->stopped = 1;
    o->runs = 0xff;
}

/* detector__slot_is_free (0x8da344, 24 Б): имя справки; фактически 1, если слот занят —
 * cid != 0xff и контекст задан. */
u32 detector_slot_is_bound(struct ll_bcn_det *o)
{
    return (o->cid != 0xff && o->ctx != 0) ? 1 : 0;
}

/* bad_beacons__check_counter (0x8c67bc, 50 Б): обнулить счётчик плохих биконов cid. */
void bad_beacons_check_counter(struct ll_bcn_det *o)
{
    if (detector_slot_is_bound(o) == 0)
        return;
    if (o->cid >= SPARRAW_MAX_STA)
        fw_sysassert_fatal(__builtin_return_address(0), 0x1526);
    o->ctx->bcn_cnt[o->cid] = 0;
}

/* bad_beacons_detector__init (0x8d90a8, 46 Б). */
static void bad_beacons_detector_init(struct ll_bcn_det *det, u32 cid, struct ll_ctx *ctx)
{
    volatile struct ll_bcn_det *o = det;
    if ((s32)cid >= (s32)SPARRAW_MAX_STA)
        fw_sysassert_fatal(__builtin_return_address(0), 0x147b);
    o->cid = (u8)cid;
    o->ctx = ctx;
    o->armed = 0;
    bad_beacons_check_counter(det);
}

/* detector__init_per_cid_a (0x8d9134, 62 Б): детектор keep-alive. Записи — в порядке
 * vendor (cid, ctx, log_tsf): volatile, иначе после встраивания в l2mgr_init gcc
 * переставляет их. */
static void detector_init_per_cid_a(struct ll_ka_det *det, u32 cid, struct ll_ctx *ctx)
{
    volatile struct ll_ka_det *o = det;
    if ((s32)cid >= (s32)SPARRAW_MAX_STA)
        fw_sysassert_fatal(__builtin_return_address(0), 0x147a);
    o->cid = (u8)cid;
    o->ctx = ctx;
    o->log_tsf[0] = 0;
    o->log_tsf[1] = 0;
    detector_init_common(&det->svc, 0xffffffffu, 0, 1, 5);
}

/* detector__init_per_cid_b (0x8d91b4, 62 Б): детектор старения TX (порядок записей — как
 * у _a). */
static void detector_init_per_cid_b(struct ll_ageing_det *det, u32 cid, struct ll_ctx *ctx)
{
    volatile struct ll_ageing_det *o = det;
    if ((s32)cid >= (s32)SPARRAW_MAX_STA)
        fw_sysassert_fatal(__builtin_return_address(0), 0x1479);
    o->cid = (u8)cid;
    o->ctx = ctx;
    o->log_tsf[0] = 0;
    o->log_tsf[1] = 0;
    detector_init_common(&det->svc, 0xffffffffu, 0, 1, 5);
}

/* link_loss_detectors__init (0x8d94f0, 152 Б): база conn_mgr — пулы записей соединений
 * (8 × 0x1a0) и списка ранжирования (8 × 0xc), cid_db; три детектора на каждый из 8 CID
 * (ll_detectors; vendor считает от 0x854e00 = &ll_detectors[0].ageing.svc.vt), контекст
 * ll_ctx. */
static void link_loss_detectors_init(void)
{
    u32 cid;
    memset0_words(conn_mgr.conns, sizeof(conn_mgr.conns));
    mem_pool_init(&conn_mgr.conn_pool, conn_mgr.conns, sizeof(struct conn), CONN_MAX);
    memset0_words(conn_mgr.rank_elems, sizeof(conn_mgr.rank_elems));
    mem_pool_init(&conn_mgr.rank_pool, conn_mgr.rank_elems, sizeof(struct conn_rank),
                  CONN_MAX);
    memset0_words(conn_mgr.cid_db, sizeof(conn_mgr.cid_db));
    for (cid = 0; cid < SPARRAW_MAX_STA; cid++) {
        struct ll_detectors *d = &ll_detectors[cid];
        detector_init_per_cid_b(&d->ageing, cid, &ll_ctx);
        detector_init_per_cid_a(&d->ka, cid, &ll_ctx);
        bad_beacons_detector_init(&d->bcn, cid, &ll_ctx);
    }
}

/* l2mgr__init_periodic_detector (0x8d8ce0, 40 Б): период 10 000 000. */
static void l2mgr_init_periodic_detector(struct phy_monitor *o)
{
    detector_init_common(&o->svc, 10000000, 0, 1, 4);
    o->freeze_stats = 1;
    o->enabled = 0;
    o->dump_off = 0;
}

/* ---------------- TX-пулы, OOB-кольца ---------------- */

/* tx_api__init_pools (0x8f552c) и всё под ней (tx_macq_api_step 0x8d986c, очереди
 * 0x19/0x1e/0x1a, tx_api__reset_state_words 0x8f5270) — fwq_tx.c. */

/* l2mgr__reset_oob_rings (0x8e4058, 60 Б): записи разбора mgmt rx_pkt_srvs.ei[0..4]
 * (0xd4 Б) обнулить и освободить, счётчики data_rx_count / cnt_42c (0x842c70/6c) = 0. */
static void l2mgr_reset_oob_rings(void)
{
    u32 i;
    for (i = 0; i < RX_MGMT_EI_N; i++) {
        struct rx_mgmt_ei *e = &rx_pkt_srvs.ei[i];
        memset0_words(e, sizeof(*e));
        e->busy = 0;
    }
    *(volatile u32 *)&rx_pkt_srvs.data_rx_count = 0;
    *(volatile u32 *)&rx_pkt_srvs.cnt_42c = 0;
}


/* l2mgr__config_default_tx_ring (0x8d9948, 48 Б). Байт 0x18 пишется в слоте задержки
 * до чтения qdesc_cfg__get_w14_field (0x8cc2fc: полуслово [gp,0x7c] = 0x800200). */
static void l2mgr_config_default_tx_ring(void)
{
    vring_tbl[0x18].macq = 0x18;                    /* 0x806194 */
    tx_macq_config_ring_params(&vring_tbl[0x18], 0, 450, 0x3000, 0x2000, macq_desc_mpdu_len);
}

/* rx_macq__setup_default (0x8d9914, 52 Б). */
static void rx_macq_setup_default(void)
{
    rx_macq_setup((u32)&rx_macq_cfgs[3], 3, 2, 1632, 0x1000, 0x2000, 72, 64, 0);
}

/* l2mgr__oob_pair (0x8fb480, 14 Б). */
static void l2mgr_oob_pair(void)
{
    l2mgr_config_default_tx_ring();
    rx_macq_setup_default();
}


/* vring_tbl__init (0x8d8c7c, 52 Б). */
__attribute__((section(".textlate"))) void vring_tbl_init(void)
{
    memset0_words(stream_by_vr, sizeof(stream_by_vr));
    mem_pool_init(&stream_pool, stream_ctxs, sizeof(struct stream_ctx), STREAM_CTX_N);
    pcp_mid_timer_flag = 0;
    pcp_started = 0;
    info_flow_timer = 0;
}

/* l2mgr__on_lmac_ready (0x8e78b8, 20 Б): LMAC-ready → l2mgr_init + rf_kill_sm_init. */

/* rf_kill_sm__init (0x8d8bc0, 88 Б): автомат RF kill (описатель 0x802338, старт ENABLED).
 * Линия RF kill не разрешена (бит 0 [0x880a94]) — IRQ замаскировать. Иначе
 * mac_toggle_880288_b1, при RF kill (бит 0 [0x880288] == 0) — журнал и событие W_DISABLE
 * (1); квитировать и размаскировать IRQ бита 27. */
/* 0x804c34: объект автомата rf_mgmt_sm (в образе нули). */
FWDATA(804c34) struct basic_sm rf_mgmt_sm = { 0 };

__attribute__((section(".textlate"))) void rf_kill_sm_init(u32 o)
{
    basic_sm_bind_descriptor((void *)o, &rf_mgmt_sm_desc);
    if ((MMIO32(HW_PLATFORM_FLAGS) & 1u) == 0) {
        rf_kill_mask_irq();
        return;
    }
    mac_toggle_880288_b1();
    if ((MMIO32(HW_RF_KILL_PIN) & 1u) == 0) {
        fw_log_emit0(0x20, 0x100ba50);
        basic_sm_handle_event((void *)o, 1, 0, 0, 0);
    }
    rf_kill_ack_irq();
    rf_kill_unmask_irq();
}
__attribute__((section(".textlate"))) void l2mgr_on_lmac_ready(void)
{
    l2mgr_init();
    rf_kill_sm_init((u32)&rf_mgmt_sm);
}

/* l2mgr__init (0x8f55b8, 192 Б): полная инициализация L2-менеджера.
 * [0x803c0c] / [0x803c10] — режим OOB по strap-битам (4 / 2). mid 0 — собственный MAC
 * 0x8004a4, SSID 0x803b84 длиной [0x803ba6]; без него — ассерт 0x11d8 (vendor идёт дальше).
 * (TOF/FTM — только SparRAW-pro.) */
__attribute__((section(".textlate"))) void l2mgr_init(void)
{
    l2mgr_pending_ops = 0;                    /* [gp,-0xd4] */
    /* OOB R1/R2 по strap-битам (0x880018 [31:29]) — только SparRAW-pro: режим не включается. */
    dashboard.cfg.oob_r1_mode = 0;
    dashboard.cfg.oob_r2_mode = 0;
    mid_ctx_init_pools();
    link_loss_detectors_init();
    radio_mgr_init_global();
    vring_tbl_init();
    l2mgr_init_periodic_detector(&phy_monitor);
    if (l2mgr_mac_started_log(0, dev_mac_addr, dashboard.ssid,
                              dashboard.ssid_len) == 0)
        fw_sysassert_fatal(__builtin_return_address(0), 0x11d8);
    l2mgr_mac_bringup();
    tx_api_init_pools();
    rx_pool_init();
    l2mgr_reset_oob_rings();
    l2mgr_oob_pair();
    wmi_evt_notify_fw_ready(dev_mac_addr, 0xff);
    sys_state_broadcast(0, 0);
}

/* Стабы tx_helpers.c; в вендоре lmac_cmd_pool__alloc(void) =
 * mem_pool_alloc_locked(0x804280), lmac_if__post_cmd(body,type,len,flags). */

/* l2_mgr__set_rf_params (0x8f9028, 72 Б): LMAC-команда 0x18 (cid, антенны,
 * число секторов) → lmac_if_post_cmd. */
__attribute__((section(".textlate"))) void l2_mgr_set_rf_params(u32 cid, u32 a1, u32 a2)
{
    fw_log_emit3(0x2b, 0x100eecc, cid, a1, a2);
    struct lmac_cmd_sta_field *buf = lmac_cmd_pool_alloc();
    buf->mode = 8;
    buf->sta = cid;
    buf->offset = 0x4c;
    buf->len = 2;
    buf->data[0] = (u8)a1;
    buf->data[1] = (u8)a2;
    lmac_if_post_cmd(buf, 0x18, 0x20, 0);
}

/* conn__set_rf_params_from_caps (0x8e6e1c, 36 Б): извлечь RF-параметры из
 * DMG Capabilities пира (u16 dmg_caps+7, при features_ver != 0) и l2_mgr_set_rf_params. */
__attribute__((section(".textlate"))) void conn_set_rf_params_from_caps(struct conn *p)
{
    u8 cid = p->cid;
    u32 a = 1, b = 0x40;
    if (p->features_ver != 0) {
        u16 caps = *(u16 *)&p->dmg_caps[7];
        a = ((caps >> 4) & 0x3u) + 1;
        b = ((caps >> 7) & 0x7fu) + 1;
    }
    l2_mgr_set_rf_params(cid, a, b);
}
