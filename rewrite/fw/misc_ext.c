// SPDX-License-Identifier: AGPL-3.0-or-later
/* Разное (область E): мелкие функции vendor 6.2.0.1000, прежде не портированные, —
 * помощники юнит-тестов UT_HW_DRIVERS / UT_HW_MODES / UT_HW_FLOWS / UT_MODULE_HW_FLOWS
 * (WMI 0x900), PLL, SDP, LMAC-команды, журнал со строковыми аргументами. Помощники
 * fw_sysapi_mgr (статистика, измерения) — в misc_ext_sysapi.c.
 *
 * Имена NAMES-EXTRA у части функций неверны (сверено по ассемблеру) — тогда в
 * комментарии указано, что функция делает на самом деле.
 *
 * Уже портированы под другими именами/внутри вызывающих (поиск по адресу их не находит):
 *   0x8c01b4..0x8c0260 millicode push/pop (__st_r14_to_r13 и др.) — у нас libgcc;
 *   0x8c05f4 shl64_fw, 0x8c0620 fw_ashr64 — 64-битные сдвиги: в C — u64 <<, s64 >> (libgcc);
 *   0x8c32f8 u_schd__alloc_task     — sched.c u_schd_alloc_task;
 *   0x8c37ec fw_mailbox__has_pending — инлайн (fw_mailbox_is_empty(&mb->rx) == 0) в
 *                                     lmac.c lmac_mbox_drain_task, wmi_cmd.c mbox_drain_*;
 *   0x8c6414 mem_pool__put_block    — mbox.c mem_pool_put_block;
 *   0x8c64d4 u_schd__invoke_callback — инлайн в rx.c u_schd_reschedule;
 *   0x8cc160/0x8cc168/0x8cc6b4 boot_diag__*_addr — инлайн-константы в stubs.c
 *                                     boot_install_diag_magic;
 *   0x8cc308/0x8cc31c/0x8cc330/0x8cc348 txq_cfg__*_or_default — static txq_cfg_c70/
 *                                     _enable/_c74/_field_0e в mac_bringup.c;
 *   0x8cdcd0 ies__iter_has_more     — инлайн в link_sm.c ies_scan_for_match;
 *   0x8d0188 car__get_pll3_status_bit3 — car.c car_get_pll3_status_bit3;
 *   0x8d4768 sdp__init_pair         — инлайн в hw_init.c sdp_int_ack_unmask;
 *   0x8d478c hw__has_cause_880b54, 0x8da774 user_led__prepare_halt,
 *   0x8d7714 hw_modes__pll_engage, 0x8d772c hw_modes__enable_pll, 0x8d7748
 *   hw_modes__pll_bypass, 0x8d7864 ut_hw_modes_cmd_0x308, 0x8d7c04 ut_hw_modes_cmd_0x304_fw,
 *   0x8d7c84 hw__pll_mode_switch, 0x8d7cc4 ut_hw_modes_cmd_0x30b — power_halt.c (без
 *                                     адресов в комментариях; сверены, совпадают);
 *   0x8da00c user_icr__timer_bit, 0x8e91a4 u_schd__hw_timer_a_start, 0x8e94f8
 *   u_schd__timer_irq_pending, 0x8e9500 u_schd__program_hw_timer, 0x8e916c
 *   sys_timer__read_now             — sched.c (одноимённые);
 *   0x8da3bc/0x8da3d8/0x8da658 regd__* — power.c regd_is_*;
 *   0x8da810 host_irq__mask_awake_tsf — isr.c host_irq_mask_awake_tsf;
 *   0x8e2958 lt_bf__reset_trigger_period, 0x8e85f0 hw_rand__below_n — инлайн в link_sm.c
 *                                     schedule_long_term_trigger;
 *   0x8e41a8 rx_chain__build_desc_b, 0x8e4220 ese__set_alloc_type, 0x8ed2c8/0x8ed2e0/
 *   0x8ed4e4 rx_chain/ese bits-помощники — rx_chain.c (одноимённые);
 *   0x8e7474 mem_pool__tag_block    — зовётся только из cxx::vec_new (0x8c1700); все три
 *                                     вызова vec_new — без заголовка (флаги 0x402, бит 0 = 0)
 *                                     → размер заголовка 0, tag_block — no-op (ctors.c);
 *   0x8ed1a8..0x8ed574 bits__set*   — обёртки 0x8edc34/0x8edccc/0x8edcb8 (r10 — сдвиг,
 *   0x8edce0 bf__set_field_half_fw    r11 — ширина-1): у портированных вызывающих инлайн
 *                                     bf_insert_field/bf_set32 или локальные помощники;
 *   0x8f33ac/0x8f33b8/0x8f3414 fw_image_info__set_flavor / fw_version__log_date /
 *   fw_version__log                 — log.c (у log_date в комментарии ошибочный 0x8f4938);
 *   0x8f4424 hw_personality__read_strap, 0x8f4480 gpio__write_ctrl_b84 — hw_init.c.
 *
 * Здесь же — исправления двух прежних упрощённых портов (определения перенесены сюда):
 *   hwd_wait_pll_lock (0x8d041c; был в wmi.c) и ut_hw_drivers_cmd_0x203 (0x8d03d8; был в
 *   power_halt.c) — см. комментарии у функций. */
#include "../include/types.h"
#include "../include/arc.h"
#include "../include/sys_cfg.h"
#include "../include/dbg.h"
#include "../include/mid.h"
#include "../include/hw.h"
#include "../include/ut.h"
#include "../include/rf_obj.h"
#include "../include/lmac_cmd.h"


/* Глобальные функции файла (вызываются портами других областей / UT-обработчиками). */

/* ---------------------------------------------------------------------------------- */
/* UT_HW_DRIVERS (модуль 12, 0x8eaec8) и связанное                                    */
/* ---------------------------------------------------------------------------------- */

/* mdm_stt_rx_crc_ok (0x8caeac, 36 Б): счётчик принятых с верным CRC — RFC-регистр 0x428
 * модуля 0 (hwd_rfc_read_rgf), журнал, значение — результат. Зовёт rfc__collect_rx_crc_stats
 * (0x8d4010, UT_HW_DRIVERS). */
u32 mdm_stt_rx_crc_ok(void)
{
    u32 v = hwd_rfc_read_rgf(0, 0x428);
    fw_log_emit1(0x20, 0x10060b4, v);
    return v;
}

/* ut_hw_drivers__reply_not_supported (0x8cdb18, 14 Б): хвостовой вызов
 * wmi_evt__send_command_not_supported(obj, 0x900 = WMI_UNIT_TEST, 0x700, mid = u16 [payload]).
 * (r1 = 9 << 8, r2 = 0x700 в слоте задержки b.d.) */
void ut_hw_drivers_reply_not_supported(struct wmi_mbox *mb, const struct ut_cmd *c)
{
    wmi_evt_send_command_not_supported(mb, 0x900, 0x700, c->module_id);
}

/* ut_hw_drivers__check_index (0x8cfc0c, 114 Б): запись 5-битного поля idx (< 13) значением
 * v (< 32). Битовый адрес поля = idx·32 + 0x4448da0 → слово ((бит >> 3) & ~3) = 0x8891b4 +
 * idx·4, позиция (бит & 0x1f) = 0; маска = (1 << (pos+4)) | ((1 << (pos+4)) − (1 << pos)).
 * Нарушение — журнал / ассерт 0x1450 (idx, знаковое сравнение brge) или 0xac (v), после
 * ассерта vendor продолжает запись. */
void ut_hw_drivers_check_index(u32 idx, u32 v)
{
    if ((s32)idx >= 0xd) {
        fw_log_emit3(0, 0x101f0ac, idx, 0xc, 0);
        fw_sysassert_fatal(__builtin_return_address(0), 0x1450);
    }
    if (v & ~0x1fu)
        fw_sysassert_fatal(__builtin_return_address(0), 0xac);

    u32 bit = (idx << 5) + 0x4448da0u;
    volatile u32 *w = (volatile u32 *)((bit >> 3) & ~3u);
    u32 pos = bit & 0x1f;
    u32 hi = 1u << (pos + 4);
    u32 mask = hi | (hi - (1u << pos));
    u32 old = *w;
    *w = (v << pos) | (old & ~mask);
}

/* ut_hw_drivers_cmd_0x203 (0x8d03d8, 18 Б): снять бит 1 [0x880c50], затем хвостом
 * 0x8d029c(0) (b.d, mov_s r0,0 в слоте). Прежний порт (power_halt.c) вместо 0x8d029c звал
 * car_enable_pll3_and_wait(0) (0x8d0320 — переключение такта ARC XTAL↔PLL3): цель b.d
 * 0x8d03e4 — 0x8d029c (-328 от 0x8d03e4). Зовётся из hw_modes__pll_bypass (0x8d7748). */
void ut_hw_drivers_cmd_0x203(void)
{
    MMIO32(HW_RGF_USER_SPARROW_M_4) &= ~2u;
    pcie_toggle_880c50_bit2(0);
}

/* hwd__wait_pll_lock (0x8d041c, 40 Б): бит 2 [0x880c50] стоит → 0x8d029c(1) (снять его с
 * ожиданием подтверждения); бит 1 [0x880abc] стоит → car_enable_pll3_and_wait(0). Аргумент
 * (вызывающие кладут 0x14) не используется. Прежний порт (wmi.c) вместо 0x8d029c(1) делал
 * [0x880c50] |= 4 — бит, и так стоявший, не снимался и подтверждение не ждалось. */
void hwd_wait_pll_lock(void)
{
    if (MMIO32(HW_RGF_USER_SPARROW_M_4) & 4u)
        pcie_toggle_880c50_bit2(1);
    if (MMIO32(RGF_USER_CLKS_CTL_0) & 2u)
        car_enable_pll3_and_wait(0);
}

/* ut_hw_drivers__pair_2568 (0x8d2a50, 26 Б): слово AGC = hwd_phy__uses_rgf_883100(base,
 * d1..d4) (0x8d2568, r0..r4 — транзитом), затем hwd_phy_rx_set_agc_start_val_and_gain_array
 * (base, слово) — base сохранён в r5 (0x8d2568 r5 не трогает); результат — слово. */
u32 ut_hw_drivers_pair_2568(u32 base, u32 d1, u32 d2, u32 d3, u32 d4)
{
    u32 w = hwd_phy_uses_rgf_883100(base, d1, d2, d3, d4);
    hwd_phy_rx_set_agc_start_val_and_gain_array(base, w);
    return w;
}

/* ut_hw_drivers_cmd_0x507 (0x8d3808, 72 Б): RFC core-fw команда 9 модуля rf: значение
 * (val & 0xf) << 7 | (idx & 0x7f). idx > 0x7f (знаковое) — ассерт 0x1151, val >= 0x10 —
 * 0x1155; после ассертов vendor продолжает с замаскированными значениями. */
void ut_hw_drivers_cmd_0x507(u32 rf, u32 idx, u32 val)
{
    if ((s32)idx > 0x7f)
        fw_sysassert_fatal(__builtin_return_address(0), 0x1151);
    if ((s32)val >= 0x10)
        fw_sysassert_fatal(__builtin_return_address(0), 0x1155);
    val &= 0xf;
    hwd_rfc_write_core_fw(rf, 9, (idx & 0x7f) | (val << 7), 0);
}

/* ut_hw_drivers_cmd_0x50f (0x8d3b90, 116 Б): 2-битное поле elem (0..31) сектора из RFC-
 * таблицы: база записи — sector·192 бит (asl 6 + add1 = ·3), RX — +0x8000, TX — +0x10000 бит.
 * Читаются два слова: A — по биту база+0, B — по биту база+0x20 (адрес = (бит >> 3) & ~3).
 * elem < 16 — (B >> 2·elem) & 3, иначе (A >> (2·elem − 32)) & 3 (сдвиг — extb). */
u32 ut_hw_drivers_cmd_0x50f(u32 rf, u32 sector, u32 rx, u32 elem)
{
    u32 base = (sector << 6) * 3u;
    u32 a, b, sh;

    if (rx == 0) {
        a = hwd_rfc_read_rgf(rf, ((base + 0x10000u) >> 3) & ~3u);
        base += 0x10020u;
    } else {
        a = hwd_rfc_read_rgf(rf, ((base + 0x8000u) >> 3) & ~3u);
        base += 0x8020u;
    }
    b = hwd_rfc_read_rgf(rf, (base >> 3) & ~3u);
    sh = elem << 1;
    /* vendor lsr_s по регистру — сдвиг по младшим 5 битам; & 31 — то же без UB при elem >= 0x30
     * или «отрицательном» elem (байт UT-аргумента). */
    if ((s32)elem < 0x10)
        return (b >> (sh & 31u)) & 3u;
    return (a >> ((sh - 0x20) & 31u)) & 3u;
}

/* ut_hw_drivers_cmd_0x513 (0x8d3d64, 58 Б): бит 28 + (bit & 1) слова сектора (база sector·192
 * бит + 0x80; RX — +0x8000, TX — +0x10000), результат — байт 0/1. */
u32 ut_hw_drivers_cmd_0x513(u32 rf, u32 sector, u32 rx, u32 bit)
{
    u32 a = (sector << 6) * 3u;
    u32 v, pos;

    a += (rx != 0) ? 0x8080u : 0x10080u;
    v = hwd_rfc_read_rgf(rf, (a >> 3) & ~3u);
    pos = (bit & 1u) + 0x1c;
    return (u8)((v & (1u << pos)) >> pos);
}

/* field_set_0x00__8db5bc (0x8db5bc, 26 Б): LMAC-команда 0x3b, тело — слово v (4 Б). */
void field_set_0x00_8db5bc(u32 v)
{
    struct lmac_cmd_u32 *body = lmac_cmd_pool_alloc();
    body->val = v;
    lmac_if_post_cmd(body, 0x3b, 4, 0);
}

/* field_set_0x00__8e6f2c (0x8e6f2c, 8 Б): байт [obj + 0x45e] = v (номер активного RF-модуля
 * в объекте RF-конфигурации; зовёт hwm_analog_select_active_rf_module 0x8d7584). */
void field_set_0x00_8e6f2c(struct rf_obj *obj, u32 v)
{
    obj->rf_mask = (u8)v;
}

/* sdp__read_880b98_bit (0x8f4404, 32 Б): бит pin регистра 0x880b98 (pin — через проверку
 * SDP_hwd_sdp_is_defined_sdp 0x8f4354, ассерт 0x1312 при i >= 0x1c). Пара к
 * hw_personality__read_strap (0x8f4424, регистр 0x880b7c). */
u32 sdp_read_880b98_bit(u32 i)
{
    u32 pin = SDP_hwd_sdp_is_defined_sdp(i);
    u32 v = MMIO32(HW_SDP_GPIO_IN);
    return ((1u << pin) & v) >> pin;
}

/* ut_hw_drivers__zero_result (0x8f3ed8, 66 Б): снимок 23 SDP-пинов (5..27): бит i
 * *out_b98 — sdp__read_880b98_bit(i + 5), бит i *out_strap — hw_personality__read_strap
 * (i + 5). Оба слова сначала обнуляются; цикл vendor — r13 = 0x17..1 (brhs.d r13,1), i в
 * слоте задержки. */
void ut_hw_drivers_zero_result(u32 *out_b98, u32 *out_strap)
{
    u32 i, n;

    *out_b98 = 0;
    *out_strap = 0;
    for (i = 0, n = 0x17; ; i++) {
        *out_b98 |= sdp_read_880b98_bit(i + 5) << i;
        *out_strap |= hw_personality_read_strap(i + 5) << i;
        n--;
        if (n < 1)
            break;
    }
}

/* ut_hw_drivers__step_8f4480 (0x8f3f1c, 96 Б): настройка 23 SDP-пинов (5..27) по маскам:
 * gpio__write_ctrl_b84(1); для бита i: func_mask — функция GPIO 0 (0x8f4294); out_mask —
 * «defined»/выход (0x8f43d4) = 1 и уровень (val_mask & бит) != 0 (0x8f4258), иначе
 * «defined» = 0. */
void ut_hw_drivers_step_8f4480(u32 func_mask, u32 out_mask, u32 val_mask)
{
    s32 i;

    gpio_write_ctrl_b84(1);
    for (i = 0; i < 0x17; i++) {
        u32 pin = (u32)i + 5;
        u32 m = 1u << i;
        if (m & func_mask)
            gpio_set_pin_func_and_dump(0, pin);
        if (m & out_mask) {
            sdp_set_defined_bit(1, pin);
            hwd_sdp_drive_value((m & val_mask) != 0 ? 1u : 0u, pin);
        } else {
            sdp_set_defined_bit(0, pin);
        }
    }
}

/* ---------------------------------------------------------------------------------- */
/* UT_HW_FLOWS_OPERATIONAL (9), UT_MODULE_HW_FLOWS_SYSAPI (10), UT_HW_MODES (11)      */
/* ---------------------------------------------------------------------------------- */

/* bits__lowest_set_bit8 (0x8d6fec, 8 Б): младший установленный бит v (v & ~(v − 1)),
 * обрезанный до байта (extb). Зовёт UT_HW_FLOWS_OPERATIONAL (0x8faa26). */
u32 bits_lowest_set_bit8(u32 v)
{
    return (u8)(v & ~(v - 1u));
}

/* ut_module_hw_flows__log_101aa08 (0x8cddc8, 30 Б): журнал (0x25, 0x101aa08, v) и ассерт
 * 0x16a0 (0xb5 << 5). Колбэк отложенного «падения» из UT_MODULE_HW_FLOWS_SYSAPI: адрес
 * 0xddc8 (младшее отображение) — аргумент задачи шедулера (0x8fb254, mov_s r0,0xddc8;
 * задержка = u16 [payload+4] · 1000); при задержке 0 зовётся сразу (0x8fb248). vendor
 * передаёт в ассерт blink — уже указывающий внутрь функции (после bl журнала). */
void ut_module_hw_flows_log_101aa08(u32 v, u32 a1)
{
    (void)a1;
    fw_log_emit1(0x25, 0x101aa08, v);
    fw_sysassert_fatal(__builtin_return_address(0), 0xb5u << 5);
}

/* sdp__set_level_and_init (0x8f8510, 28 Б): поле [4:0] (пин) слова конфигурации SDP i
 * (таблица 0x800c34, bits__set32_s0_w5 0x8ed37c) = v & 0x1f, затем SDP::sdp_init(i)
 * (0x8f83c0; i сохранён в r2 — помощник 0x8edcb8 портит только r10..r12). */
void sdp_set_level_and_init(u32 i, u32 v)
{
    volatile u32 *w = &sdp_port_cfg[i];
    *w = (*w & ~0x1fu) | (v & 0x1fu);
    SDP_sdp_init_2(i);
}

/* hw_cfg__set_8004fc_and_levels (0x8ce060, 38 Б): байт [0x8004fc] = a, пины SDP 7 и 8 —
 * (u8)(b + 5) и (u8)(c + 5) с переинициализацией (sdp__set_level_and_init). */
void hw_cfg_set_8004fc_and_levels(u32 a, u32 b, u32 c)
{
    hw_cfg_sdp_flags = (u8)a;
    sdp_set_level_and_init(7, (u8)(b + 5));
    sdp_set_level_and_init(8, (u8)(c + 5));
}

/* ut_hw_modes_cmd_0x30c (0x8d7c70, 20 Б): on == 1 — 0x8d03f4 (биты 1 и 2 [0x880c50]),
 * иначе 0x8d0444 (снять бит 2). */
void ut_hw_modes_cmd_0x30c(u32 on)
{
    if (on == 1)
        pcie_set_880c50_b12(1);
    else
        pcie_clear_880c50_b2(on);
}

/* ---------------------------------------------------------------------------------- */
/* LMAC-команды, объекты, журнал                                                      */
/* ---------------------------------------------------------------------------------- */

/* field_set_0x00__8dbc94 (0x8dbc94, 26 Б): LMAC-команда 0x12, тело — байт v (1 Б).
 * Зовётся через thunk 0x8ce408 (UT_MODULE_HW_FLOWS_SYSAPI). */
void field_set_0x00_8dbc94(u32 v)
{
    struct lmac_cmd_u8 *body = lmac_cmd_pool_alloc();
    body->val = (u8)v;
    lmac_if_post_cmd(body, 0x12, 1, 0);
}

/* field_set_0x00__8dbe88 (0x8dbe88, 30 Б): LMAC-команда типа (u16)type, тело — слово v
 * (4 Б). Зовут команды fw_sysapi_mgr (start_*_statistics, plcp, channel_estimation). */
void field_set_0x00_8dbe88(u32 type, u32 v)
{
    struct lmac_cmd_u32 *body = lmac_cmd_pool_alloc();
    body->val = v;
    lmac_if_post_cmd(body, type & 0xffffu, 4, 0);
}

/* radio_mgr__alloc_request (0x8e2724, 14 Б) — имя NAMES-EXTRA неверно: байт
 * [obj + 0x75 + idx·17] = 8 (mul64 r1,0x11 → mlo; поле записи списка STA PBSS по 17 Б).
 * Зовёт pbss_sta_list_update (0x8d88c4, 0x8d8af2). */
void radio_mgr_alloc_request(struct mid_bss *obj, u32 idx)
{
    obj->pbss[(s32)idx].aid = 8;
}

/* link_stats__pack_conn_entry (0x8cdd7c, 76 Б): упаковка снимка отчёта BF соединения s
 * (lm_if.snap) в данные ответа d (зовёт hw_sysapi_get_beamforming_statistics 0x8cde44).
 * d->rsv07 не пишется. */
void link_stats_pack_conn_entry(const struct lmac_evt_bf_done *s, struct ut_bf_stats *d)
{
    d->status = (u8)s->status;
    d->type = (u8)s->type;
    d->diag_lo = s->diag_lo;
    d->diag_hi = s->diag_hi;
    d->ssw_rx_cnt = s->ssw_rx_cnt;
    d->tx_sector = s->tx_sector;
    d->tx_sector_b1 = s->tx_sector_b1;
    d->own_snr = s->own_snr;
    d->peer_snr = (s8)s->peer_snr;                  /* ldb.x — со знаком */
    d->sect_seen[0][1] = s->sect_seen[0][1];
    d->sect_seen[0][0] = s->sect_seen[0][0];
    d->sect_seen[1][1] = s->sect_seen[1][1];
    d->sect_seen[1][0] = s->sect_seen[1][0];
    d->brp_snr = s->brp_snr;
    d->brp_selected = (u16)s->brp_selected;
    d->rx_sector = s->rx_sector;
    d->tsf = s->tsf;
}

/* fw_log_emit_str3 (0x8dce84, 142 Б) — в NAMES-EXTRA ошибочно «fwq_tx__long_retry_handler»:
 * это третий вариант журнала со строковыми аргументами (пара к 0x8dcd90/0x8dce04 —
 * log.c fw_log_emit_str1/2): три аргумента-токена строк, в заголовке 0xbc000000
 * (n = 3 | 4 → биты 26..28 = 7, бит 29, бит 31). Запись — кольцо 0x843900: [0] счётчик,
 * +4 маски уровней модулей, +0x14 — 0x400 слов; s2/s1/s0 в idx+4/+3/+2, TSF_lo в idx+1,
 * заголовок (token[19:0] | min(TSF_hi, 0xff) << 18 | 0xbc000000) в idx; счётчик += 5.
 * Зовут basic_sm__do_transition (0x8ca2d0, трассировка автомата) и basic_sm__error_handler
 * (0x8c9a54) — с именами автомата/события/состояния. */
void fw_log_emit_str3(u32 hdr, u32 token, u32 s0, u32 s1, u32 s2)
{
    u32 tsf[2];
    u32 idx, hi;

    if (!((VOL(fw_log.lvl_mask[hdr & 0xf]) >> ((hdr >> 4) & 3)) & 1))
        return;
    idx = VOL(fw_log.wr_idx);
    VOL(fw_log.ring[(idx + 4) & 0x3ff]) = s2;
    VOL(fw_log.ring[(idx + 3) & 0x3ff]) = s1;
    VOL(fw_log.ring[(idx + 2) & 0x3ff]) = s0;
    mac_read_tsf64(0, tsf, 0);
    hi = tsf[1] < 0xff ? tsf[1] : 0xff;
    idx = VOL(fw_log.wr_idx);
    VOL(fw_log.ring[(idx + 1) & 0x3ff]) = tsf[0];
    VOL(fw_log.ring[idx & 0x3ff]) = (token & 0xfffff) | 0xbc000000u | ((hi & 0xff) << 18);
    VOL(fw_log.wr_idx) = idx + 5;
}

/* link_lost_diag__rx_status (0x8f4680, 114 Б): диагностика приёма PHY при потере линка
 * (зовёт link_lost_diag_part2 0x8f2250): сброс статистики, выдержка, фиксация, снимок 14
 * счётчиков (0x8d25e8). Счётчик [10] (+0x28) != 0 — журнал 0x101b284 с ним; иначе журнал
 * 0x101b2b8, повторный снимок и журналы 0x101b2ec / 0x101b328 для счётчиков [7] / [8]
 * (+0x1c / +0x20), если они >= 3. Буфер 0x38 Б заполняется целиком (14 слов).
 * ХРУПКО: vendor 0x8f468a..0x8f469e — выдержка nop_s; lp_count = 0x13880; тело 2 nop_s
 * (между clear 0x883960 и lock 0x88395c — окно накопления статистики); та же форма
 * arc_zol_nops2 — такты = vendor. */
void link_lost_diag_rx_status(void)
{
    u32 c[14];
    hwd_phy_rx_statistics_clear();
    arc_zol_nops2_mb(0x13880);
    hwd_phy_rx_statistics_lock();
    phy_read_rx_counters(c);
    if (c[10] != 0) {
        fw_log_emit1(0x20, 0x101b284, c[10]);
        return;
    }
    fw_log_emit0(0x20, 0x101b2b8);
    phy_read_rx_counters(c);
    if (c[7] >= 3)
        fw_log_emit1(0x20, 0x101b2ec, c[7]);
    if (c[8] >= 3)
        fw_log_emit1(0x20, 0x101b328, c[8]);
}
