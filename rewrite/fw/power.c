// SPDX-License-Identifier: AGPL-3.0-or-later
/* Менеджер питания и калибровочный движок — инициализация. */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/dbg.h"
#include "../include/rf_obj.h"
#include "../include/fwdata.h"
#include "../include/power.h"
#include "../include/calib_engine.h"


/* radio_mgr_init_list (0x8d91a0), obj_vt803210_ctor (0x8d8c1c) — в radio_mgr.c. */

/* Детектор 33kHz тактового генератора (0x8d777c). */

/* 0x8d03f4: два отдельных RMW 0x880c50 (бит 1, затем бит 2) и 10 nop_s выдержки. */
void pcie_set_880c50_b12(u32 a)
{
    (void)a;
    MMIO32(HW_RGF_USER_SPARROW_M_4) |= (1u << 1);
    MMIO32(HW_RGF_USER_SPARROW_M_4) |= (1u << 2);
    arc_nops_mb(10);
}

/* 0x8d0444: снять бит 2 0x880c50 и 10 nop_s выдержки. */
void pcie_clear_880c50_b2(u32 a)
{
    (void)a;
    MMIO32(HW_RGF_USER_SPARROW_M_4) &= ~(1u << 2);
    arc_nops_mb(10);
}

/* Загрузить TSF = {b:a}. MAC-команда 0x0d = регистр BI_TSF_CONTROL (MSXD_CMD+0x34, имя пака 11ad):
 * бит 1 — ход таймера TSF, бит 2 — загрузка TSF из защёлки 0x886dc0/0x886dc4; 0x0a1e53 —
 * штатное значение (бит 1 есть, бита 2 нет). Проверено на стенде — docs/MAC-COMMANDS.md §7.12. */
__attribute__((section(".textlate")))
void mac_reload_tsf64(u32 a, u32 b)
{
    MMIO32(HW_MAC_CMD0D_TIME_LO) = a;
    MMIO32(HW_MAC_CMD0D_TIME_HI) = b;
    MMIO32(HW_SXD_LOCAL_WR_DATA) = 0xd000006u;
    MMIO32(HW_SXD_LOCAL_WR_DATA) = 0xd0a1e53u;
}

/* 0x8e9924: команды MAC 0x63001e04/0x63000108, выдержка 0x8e99a4, результат —
 * биты 4..7 [0x88c180] нулевые. */
__attribute__((section(".textlate")))
u32 hwm_probe_33khz_clk(void)
{
    MMIO32(HW_SXD_LOCAL_WR_DATA) = 0x63001e04u;
    MMIO32(HW_SXD_LOCAL_WR_DATA) = 0x63000108u;
    hwm_measure_33khz_wait();
    return (MMIO32(HW_MAC_EXT_33K_MEAS_STAT) & 0xf0u) ? 0 : 1;
}


__attribute__((section(".textlate")))
void power_start_two_timers(void)
{
    timer_start(1, 0, 0x1f78a40, 2);
    timer_start(0, 0, 0xce4, 1);
}

__attribute__((section(".textlate")))
u32 hwm_power_33kHz_clk_detector(void)
{
    if (!(MMIO32(RGF_USER_CLKS_CTL_0) & (1u << 1))) {
        fw_log_emit0(0x2e, 0x101cf98);
        return 0;
    }
    u32 saved = arc_lr(ARC_STATUS32);
    arc_flag(saved & ~6u);
    pcie_set_880c50_b12(saved & ~7u);
    u32 r13 = hwm_probe_33khz_clk();
    pcie_clear_880c50_b2(r13);
    hwm_start_33khz_measure(0);
    mac_reload_tsf64(0, 0);
    arc_flag((saved & 6u) | arc_lr(ARC_STATUS32));
    return r13;
}

/* 0x803cbc: пул отложенных событий basic_sm (в образе нули; sm_init_defer_pool). */

/* power_mngr__init (0x8f5138). */
__attribute__((section(".textlate")))
void power_mngr_init(void)
{
    /* PS-менеджеры (ps_nonassoc/ps_assoc: автоматы, профиль по умолчанию, текущий объект
     * [gp,-0x64]) — вырезаны вместе с энергосбережением (см. fw/action.c psc_req_reject);
     * автомат питания PCIe (pcie_device_power_if_init) — тоже (см. fw/vectors.c
     * pcie_pm_event_unsupported). */
    ps_lmac_evt_cid_mask = 0;

    /* Детектор 33 кГц (с перезагрузкой TSF) — как у vendor; его копия ps_33khz_clk_detect и
     * счётчики ожидания хоста шли только в deep sleep — вырезаны. */
    power_33khz_clk_detect = hwm_power_33kHz_clk_detector();
}

/* calib_engine__init_all (0x8f50c8). noinline: у vendor — отдельная функция (конструкторы зовут
 * bl); с объектом-указателем gcc встраивал её в конструкторы power.c. */
__attribute__((noinline)) void basic_sm_bind_descriptor(void *obj, const void *desc)
{
    /* volatile: vendor пишет desc, state и два stb по порядку; без volatile gcc сливает
     * stb deferred/trace в одно stw (объект выровнен на 4) */
    volatile struct basic_sm *sm = obj;
    const struct sm_desc *d = desc;
    u8 st = d->init_state;
    sm->desc = d;
    sm->state = st;
    sm->deferred = 0xff;
    sm->trace = 0;
}

/* calib_engine__sm_init: автомат движка idx (описатель 0x802234) с объектом класса obj;
 * метод reset объекта. */
void calib_engine_sm_init(struct calib_engine *sm, u32 idx, struct calib_obj *obj)
{
    if (obj == 0)
        fw_sysassert_fatal((void *)0, 0x127d);
    basic_sm_bind_descriptor(sm, &calib_engine_sm_desc);
    sm->idx = idx;
    sm->obj = obj;
    obj->vt->reset(obj);
}

/* Установить активный канал. */
void chan_sw_set_active_channel(u32 v)
{
    chsw_active_channel = v;   /* [gp,-0x31] */
}

void calib_engine_init_all(void)
{
    if (platform_is_asic() == 0)
        return;

    calib_vtable_setup();

    memset0_words(calib_mngr.scheme_active, sizeof(calib_mngr.scheme_active));
    memset0_words(calib_mngr.timer, sizeof(calib_mngr.timer));

    u32 i;
    for (i = 0; i < CALIB_ENG_NUM; i++)
        calib_engine_sm_init(&calib_mngr.eng[i], i, calib_engine_objs[i]);

    chsw_cur_channel = 1;
    chan_sw_set_active_channel(1);
    chsw_configured = 0;
    chsw_pcp_ap_mode = 0;
    calib_sys_state = 3;          /* vendor 0x8f512a: st.as 3,[gp,-5] (прежде 0) */
    calib_scheme_enabled = 1;
}

/* Получить канал радио (0x8cc140). */
u32 radio_get_channel(struct rf_obj *a)
{
    return a->channel;
}

/* Проверка режима питания (0x8e24e0). */

__attribute__((section(".textlate")))
void power_mngr_check_mode(u32 a)
{
    u32 r14 = 0;
    u32 r13 = 0;
    /* vendor: cmp [gp,0xce],1; cmp.ne a,1 — ИЛИ (прежний порт: И); r13 — результат
     * regd_is_unset_or_jp (mov_s r13,r0 в слоте задержки), r14 — regd_is_country_us. */
    if (chsw_pcp_ap_mode == 1 || a == 1) {
        regd_is_country_not_jp();
        r13 = regd_is_unset_or_jp();
        r14 = regd_is_country_us();
    }
    phy_load_88416c_table(1);
    rf_set_889494_low_nibble(r13);
    hwd_rfc_tx_power_cfg(r14);
}

/* field_set_0x08_8d8eb4 (0x8d8eb4) — в radio_mgr.c. */

/* Снять флаг таймера задачи u_schd (0x8caf4c; include/sched.h). */
struct u_schd_task *field_set_0x19_8caf4c(struct u_schd_task *t)
{
    t->armed = 0;
    return t;
}

/* Проверка страны (regd). */
u32 regd_is_country_not_jp(void)
{
    if (chsw_active_channel != 0)
        return 0;
    return (regd_country_code == 0x4a50) ? 0 : 1;
}

u32 regd_is_unset_or_jp(void)
{
    if (chsw_active_channel == 0)
        return 1;
    return (regd_country_code == 0x4a50) ? 1 : 0;
}

u32 regd_is_country_us(void)
{
    if (chsw_active_channel != 0)
        return 0;
    return (regd_country_code == 0x5553) ? 1 : 0;
}

/* 0x8e99a4: [0x800418] раз — команда MAC 0x63000001 и выдержка nop_s + 0x1f40 × 2 nop_s
 * (lp-цикл vendor). Прежде под этим именем был порт 0x8e9954 (опрос, см. ниже) — он и
 * вызывался из пробы 0x8e9924 вместо выдержки.
 * ХРУПКО: выдержка — время, за которое MAC исполняет команду 0x63000001 (такт 33 кГц);
 * длину цикла не менять (vendor 0x8e99be: 0x7d << 6 итераций). */
__attribute__((section(".textlate")))
void hwm_measure_33khz_wait(void)
{
    u32 r13;
    for (r13 = 0; r13 < hwm_33khz_wait_repeats; r13++) {
        MMIO32(HW_SXD_LOCAL_WR_DATA) = 0x63000001u;
        arc_zol_nops2_shl_mb(0x7d, 6);  /* vendor 0x8e99be: mov_s 0x7d; asl_s 6; lp × 2 nop_s */
    }
}

/* 0x8e9954: [0x800414] раз — команда MAC 0x63000002 и опрос битов 4..7 [0x88c180] до нуля,
 * не более 1000 чтений (lp; beq на lp_end — выход из цикла). Не дождались — лог
 * DO_WHILE_WITH_MAX_ITER с blink (адрес возврата этой функции), как vendor (r2 = blink;
 * прежде в лог шло значение битов, отсюда «curr_blink=0x7»). Маска — 4 бита (bmsk 3;
 * прежде 3 бита). */
__attribute__((section(".textlate"))) __attribute__((noinline))
static void hwm_33khz_wait_ready(void)
{
    u32 r13;
    for (r13 = 0; r13 < hwm_33khz_poll_repeats; r13++) {
        MMIO32(HW_SXD_LOCAL_WR_DATA) = 0x63000002u;
        u32 r0 = 0;
        for (u32 i = 0; i < 1000; i++) {
            r0 = (MMIO32(HW_MAC_EXT_33K_MEAS_STAT) >> 4) & 0xf;
            if (r0 == 0)
                break;
        }
        if (r0 != 0)
            fw_log_emit1(0, 0x101d480, (u32)__builtin_return_address(0));
    }
}


/* 0x8e9a14: a != 0 — команды 0x63001e04/0x63000108, чтение TSF, выдержка 0x8e99a4;
 * a == 0 — опрос 0x8e9954, чтение TSF. */
__attribute__((section(".textlate")))
void hwm_start_33khz_measure(u32 a)
{
    if (a != 0) {
        MMIO32(HW_SXD_LOCAL_WR_DATA) = 0x63001e04u;
        MMIO32(HW_SXD_LOCAL_WR_DATA) = 0x63000108u;
        mac_read_tsf_hi(0);
        hwm_measure_33khz_wait();
    } else {
        hwm_33khz_wait_ready();
        mac_read_tsf_hi(0);
    }
}

/* Каллее power_halt_seq — перенесены в power_halt.c (.textlate). */


/* Итератор bitmap / выделение бита / установка поля. */
u32 bit_iter_has_more(const u32 *p)
{
    return *p != 0;
}

u32 bitmap_alloc_bit(u32 *p)
{
    u32 r1 = *p;
    if (r1 == 0)
        return 0xffffffff;
    u32 r0;
    if (r1 & 0x80000000u)
        r0 = 31;
    else
        r0 = 31 - __builtin_clz(r1);
    *(u32 *)p = r1 & ~(1u << r0);
    return r0;
}

void field_set_0x00_8e5dfc(u32 *a, u32 b)
{
    *a = b;
}

/* Установить время пробуждения (0x8e9a48). */

/* Сигнал ucode о пробуждении + ожидание ACK (0x8db0d0). */
__attribute__((section(".textlate")))
void fw2uc_signal_wake_and_wait_ack(void)
{
    MMIO32(HW_FW2UC_ICS) = 4;
    arc_sync();
    u32 r14 = 0x3e9;
    u32 ack = 0;
    for (;;) {
        u32 i;
        arc_zol_nops2(0x50);            /* vendor 0x8db0e8: lp 0x50 × 2 nop_s */
        ack = 0;
        for (i = 0; i < 0x12c; i++) {
            ack = (MMIO32(HW_FW2UC_ICR) >> 2) & 1;
            if (ack)
                break;
        }
        if (ack)
            break;
        fw_log_emit1(0, 0x1004c38, 0);
        r14--;
        if (r14 < 1)
            break;
    }
    if (!ack)
        fw_sysassert_fatal((void *)0, 0x1317);
}

/* Восстановить RFC-поле после low-power (0x8dc654). */
__attribute__((section(".textlate")))
void lo_power_restore_rfc_field(void)
{
    rfc_write_field_484(0, (u32 *)calib_lo_power_fields);
}

/* Сброс calib-объекта 4 (0x8cbb90): rf_idx = 0 (0x3f при режиме RF 3); возвращает объект
 * silent RSSI (vendor оставляет его в r0 — им пользуются if_gain/silent_rssi). */
struct calib_silent_rssi *calib_obj4_reset_d4(void)
{
    struct calib_silent_rssi *obj =
        (struct calib_silent_rssi *)calib_engine_get_by_index(CALIB_ENG_SILENT_RSSI);
    obj->rf_idx = 0;
    if (rf_obj.sets_mode == 3)
        obj->rf_idx = 0x3f;
    return obj;
}

/* Останов power-менеджера (0x8c89a0). */


/* Старт таймеров останова (0x8e9558). */

/* Сигнал ucode об останове + ожидание ACK (0x8db148). */
__attribute__((section(".textlate")))
void fw2uc_signal_halt_and_wait_ack(void)
{
    MMIO32(HW_FW2UC_ICS) = 2;
    arc_sync();
    u32 r14 = 0x3e9;
    u32 ack = 0;
    for (;;) {
        u32 i;
        for (i = 0; i < 0x12c; i++) {
            ack = (MMIO32(HW_FW2UC_ICR) >> 1) & 1;
            if (ack)
                break;
        }
        if (ack)
            break;
        fw_log_emit1(0, 0x1004c38, 0);
        r14--;
        if (r14 < 1)
            break;
    }
    if (!ack)
        fw_sysassert_fatal((void *)0, 0x1316);
}

/* Получить calib-объект по индексу (0x8cbb84). */
struct calib_obj *calib_engine_get_by_index(u32 idx)
{
    return calib_engine_objs[idx];
}

/* basic_sm__error_handler (0x8c9a54): событие, недопустимое в текущем состоянии автомата —
 * журнал (имя события [[sm+4]+0xc][ev], ид автомата [[sm+4]+0x10], имя состояния
 * [[sm+4]+8][state]) и фатальный ассерт 0x1033. */
void basic_sm_error_handler(const void *obj)
{
    const struct basic_sm *sm = obj;
    const struct sm_desc *desc = sm->desc;
    u32 ev = sm->event, st = sm->state;
    fw_log_emit_str3(5, 0x1001a3c, desc->event_names[ev], desc->id, desc->state_names[st]);
    fw_sysassert_fatal((void *)0, 0x1033);
}

/* sm__action_nop (0x8df510): пустое действие автомата. */
void sm_action_nop(void) { }

/* sm__action_nop_b (0x8df514): второе пустое действие (отдельная копия у vendor). */
void sm_action_nop_b(void) { }

/* basic_sm__handle_event (0x8d9b6c, 158 Б): переход по событию, затем разбор отложенных
 * событий автомата (очередь 0x803cd0 + n * 16, пул 0x803cbc) — не больше 0x14 за раз. */

void basic_sm_handle_event(void *obj, u32 ev, u32 a0, u32 a1, u32 a2)
{
    struct basic_sm *sm = obj;
    u32 n = 0;

    if (sm->deferred != 0xff)
        fw_sysassert_fatal((void *)__builtin_return_address(0), 0x16a1);

    basic_sm_do_transition(obj, ev, a0, a1, a2);

    while (sm->deferred != 0xff) {
        n++;
        if (n >= 0x14)
            fw_sysassert_fatal((void *)__builtin_return_address(0), 0x1031);
        if (sm->deferred >= SM_DEFER_NODES)
            fw_sysassert_fatal((void *)__builtin_return_address(0), 0x16b1);

        struct sm_defer_node *entry = &sm_defer_nodes[sm->deferred];
        sm->deferred = 0xff;
        basic_sm_do_transition(obj, entry->event, entry->a0, entry->a1, entry->a2);
        stream_mgr_check_vring(&sm_defer_pool, entry);
    }
}

/* basic_sm__do_transition (0x8ca2d0, 182 Б). Дескриптор: [0] число событий, [1] число
 * состояний, [2] начальное состояние, [4] таблица, [8] имена состояний, [0xc] имена
 * событий, [0x10] ид автомата. Таблица — записи по 5 Б {действие (4 Б, без
 * выравнивания), следующее состояние (1 Б)}, индекс = состояние + число_состояний * событие
 * (mulu64 + add2 r1,r15,r15 = 5 * индекс). Прежний порт умножал индекс на 2 — для любого
 * перехода, кроме (состояние 0, событие 0), читался мусор из середины записей. */
void basic_sm_do_transition(void *obj, u32 ev, u32 a0, u32 a1, u32 a2)
{
    struct basic_sm *sm = obj;
    const struct sm_desc *desc = sm->desc;
    u32 idx = sm->state + desc->n_states * ev;
    u32 next = desc->table[idx].next;

    sm->state = (u8)next;
    sm->event = (u8)ev;

    if (sm->trace != 0)   /* трассировка автомата */
        fw_log_emit_str3(0x25, 0x10019ec, desc->id, desc->event_names[ev], desc->state_names[next]);

    desc = sm->desc;
    const struct sm_trans *table = desc->table;
    if ((u32)table < (u32)__dccm_start) {   /* таблица вне DCCM — испорченный описатель */
        fw_log_emit_str3(0x25, 0x1001a00, desc->id, desc->event_names[ev],
                         desc->state_names[sm->state]);
        fw_log_emit1(0x25, 0x1001a28, (u32)table);
    }

    sm_action_fn handler = table[idx].action;
    /* Не vendor: действие вне ICCM (мусор в описателе/состоянии, неперенесённый указатель)
     * у vendor — прыжок в никуда и исключение без контекста. Здесь — запись автомата в
     * DBG_SM_BAD (первый случай) и сисассерт с местом вызова. */
    if ((u32)handler < 0x8c0000u || (u32)handler >= 0x900000u) {
        if (*(volatile u32 *)DBG_SM_BAD == 0) {
            *(volatile u32 *)(DBG_SM_BAD + 4) = (u32)desc;
            *(volatile u32 *)(DBG_SM_BAD + 8) = sm->state | ev << 8 | next << 16;
            *(volatile u32 *)(DBG_SM_BAD + 12) = (u32)handler;
            *(volatile u32 *)DBG_SM_BAD = desc->id | 0x80000000u;
        }
        fw_sysassert_fatal((void *)__builtin_return_address(0), 0x1033);
        return;
    }
    handler((u32)obj, a0, a1, a2);
}

/* Последовательность останова питания (0x8d78cc) — реальный порт.
 * a=1: halt (RF power-down); a=0: wake (RF power-up). Зовут hwm_analog_prepare_buf и
 * UT_HW_MODES 0x309. У vendor ещё c — детектор 33 кГц, d/e — время пробуждения: с ними бит 8
 * флагов (сон с пробуждением по TSF) и бит 9 (дождаться L1 PCIe перед остановом) служили
 * deep sleep. Все вызовы передавали c = 0, бит 9 не ставит ни один контекст —
 * энергосбережение вырезано (см. fw/vectors.c pcie_pm_event_unsupported), ветки удалены. */
__attribute__((section(".textlate")))
void power_halt_seq(u32 a, struct ps_ctx *b)
{
    struct ps_ctx *r13 = b;   /* PS-контекст (флаги шагов) */
    u32 flags = r13->flags;

    if (a == 0) {
        /* --- WAKE branch --- */
        if (flags & (1u << 7))
            ut_hw_modes_cmd_0x304_fw(0, ps_halt_dma_b27);

        if (flags & (1u << 5))
            ut_hw_modes_cmd_0x308(0, &r13->hw.flags);

        if (flags & (1u << 6))
            hw_pll_mode_switch(0, (flags >> 10) & 1u);

        if (flags & (1u << 4))
            hw_modes_program_rf_clocks(0);

        if (flags & (1u << 3))
            abif_mode_switch(0);

        if (flags & (1u << 2))
            sdp_drive_pin_timed(1);

        if (flags & (1u << 1))
            hwd_rfc_powerup_deep_all_rfs_fw();
    } else {
        /* --- HALT branch --- */
        ps_halt_dma_b27 = hwd_dma_get_881bf0_bit27();

        if (flags & 1u)
            hwd_args_to_regs_default(rf_cfg_get_rf_mask_45e(&rf_obj));

        if (flags & (1u << 1))
            hwd_rfc_powerdown_deep_all_rfs_fw();

        if (flags & (1u << 2))
            sdp_drive_pin_timed(0);

        if (flags & (1u << 3))
            abif_mode_switch(1);

        if (flags & (1u << 4))
            hw_modes_program_rf_clocks(1);

        if (flags & (1u << 5))
            ut_hw_modes_cmd_0x308(1, &r13->hw.flags);

        if (flags & (1u << 6))
            hw_pll_mode_switch(1, (flags >> 10) & 1u);

        if (flags & (1u << 7))
            ut_hw_modes_cmd_0x304_fw(1, ps_halt_dma_b27);
    }
}

