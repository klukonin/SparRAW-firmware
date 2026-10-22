// SPDX-License-Identifier: AGPL-3.0-or-later
/* Порты vendor, не получившие отдельного модуля (исторически — место заглушек init-функций;
 * заглушек здесь больше нет): DMG-бикон и discovery-бикон, analog/RF-восстановление,
 * ящики хоста, разное. Переносятся в свои модули при случае. */
#include "../include/abft_cfg.h"
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/fwq_tx.h"
#include "../include/temp_sense.h"
#include "../include/rf_obj.h"
#include "../include/power.h"
#include "../include/mbox.h"
#include "../include/mid.h"
#include "../include/calib_engine.h"
#include "../include/sys_cfg.h"
#include "../include/fwdata.h"
#include "../include/ieee80211.h"
#include "../include/lmac_cmd.h"

/* 1. boot__init_subsystems — в subsys.c (портирована). */

/* boot_diag (0x803b70, 16 Б): в образе fw_data — нули. */
FWDATA(803b70) struct boot_diag boot_diag = { 0 };

/* 2. boot__install_diag_magic — vendor 0x8d8ec0 (56 Б): diag-magic + адреса reg-окон.
 * Ключ 0xbacacafe в 0x880a80 — кандидат на разблокировку mbox/rx-ring. */
void boot_install_diag_magic(void)
{
    MMIO32(HW_FW_POINTER_TABLE_VALIDATION_PATTERN) = 0xbacacafe;
    MMIO32(HW_FW_POINTER_TABLE_BASE_ADDRESS) = (u32)&boot_diag;
    boot_diag.status = 0;
    boot_diag.reg0_addr = HW_RGF_USER_USER_SCRATCH_PAD;   /* boot_diag__reg_8802bc_addr */
    boot_diag.reg1_addr = HW_DEBUG_MBOX_CTL;   /* boot_diag__reg_8803e8_addr */
    boot_diag.fw_stats_addr = (u32)&fw_stats_hdr;   /* boot_diag__fw_stats_blk_addr */
}

/* 3. fw_stats_blk__init (0x8f538c, 44 Б): обнулить блок статистики 0x853800 (0x1c0 Б),
 * [+0] = 5, u16 [+4] = 0x1c0 (размер), поле [24..27] слова +0x118 = 0xf (0x8ed46c).
 * Прежде записи [+0]/[+4] отсутствовали. */
void fw_stats_blk_init(void)
{
    memset0_words(&fw_stats_hdr, FW_STATS_BLK_SIZE);   /* весь блок от заголовка */
    VOL(fw_stats_hdr.ver) = 5;
    VOL(fw_stats_hdr.size) = FW_STATS_BLK_SIZE;
    bits_set_word(&fw_stats_dash.state, 24, 4, 0xf);
}

/* 4. fw_log__init_ring */
/* fw_log_init_ring — в log.c (портирована). */

/* 6. defer-пул (0x8d9b58): mem_pool__init(0x803cbc, 0x803cd0, 0x10, 4). Пул кадров
 * (0x8ea694 → 0x8f5a00) — l2mgr_init_frame_pool (pool.c), fw_main зовёт его напрямую. */
void sm_init_defer_pool(void)
{
    mem_pool_init(&sm_defer_pool, sm_defer_nodes, sizeof(struct sm_defer_node), SM_DEFER_NODES);
}

/* 7. mbox-указатели */
/* vendor: sched_step(0x804c3c, 0x254cc) — 0x254cc = vendor 0x8e54cc в младшем отображении;
 * наш код по этому адресу не лежит, поэтому — адрес нашего порта. */
FWDATA(804c3c) struct operational_mbox *operational_mbox_ref = 0;
void operational_if_init_mbox_ptr(void) { sched_step(&operational_mbox_ref, operational_if_evt_send); }

/* debug_mbox__get_or_init: отладочный ящик debug_mbox (include/mbox.h), описатели колец —
 * RGF 0x8803e8/0x8803f8. */
struct wmi_mbox *debug_mbox_get_or_init(void)
{
    fw_log_emit0(0x20, 0x1003a80);
    if (dbg_mbox_inited != 0)     /* [gp,-0xb0] — уже инициализирован */
        return &debug_mbox;
    gpio19_pulse_count = 0;          /* [gp,0x6a] */
    debug_mbox.vt = &debug_mbox_vtbl;   /* vendor: [0x843084] = 0x8006fc */
    u32 desc[4];
    desc[0] = 4; desc[1] = 7; desc[2] = 0x64; desc[3] = 0x100;
    /* ring1 base = vendor `sub r2,r3,0x18` = 0x88042c-0x18 = 0x880414 (не 0x8803cc —
     * тот был `sub2`(<<2) и попадал внутрь operational RX-ring 0x880318..0x8803e8). */
    mbox_init_descriptor(&debug_mbox, (struct mbox_ring_hw *)HW_DEBUG_MBOX_CTL, HW_DEBUG_MBOX_TX_RING, HW_DEBUG_MBOX_RX_RING,
                         dbg_mbox_rx_bufs, dbg_mbox_tx_bufs, 2, 5, desc);
    dbg_mbox_inited = 1;          /* [gp,-0x2c] */
    return &debug_mbox;
}

/* calib_vt_method1_noop (0x8d90a4): j_s [blink] — пустой метод [1] пяти классов калибровки
 * (fw_data 0x800608/0x800638/0x800668/0x8006c8/0x800730; у LO power в 0x800698 —
 * calib_obj__reset_results). Слоты переносит fw_ptrmap.py. */
void calib_vt_method1_noop(struct calib_obj *a)
{
    (void)a;
}

/* Поставить vtable-указатели калибровочных движков (у vendor — статические конструкторы;
 * ctors.c пока конструирует только 0x804b5c). Метод reset больше не перезаписывается
 * (прежняя запись noop во все 6 таблиц затирала calib_obj__reset_results в 0x800698).
 * Вынесено сюда (stubs.c после rf.c), чтобы не сдвигать код rf.c при изменении power.c. */
void calib_vtable_setup(void)
{
    static struct calib_obj *const calib_objs[CALIB_ENG_NUM] = {
        &calib_sar_obj, &calib_vga_obj, &calib_if_gain_obj,
        &calib_lo_leakage_obj, &calib_silent_rssi_obj.base, &calib_lo_power_obj.base};
    static const struct calib_vt *const calib_vt[CALIB_ENG_NUM] = {
        &calib_sar_vtbl, &calib_vga_vtbl, &calib_if_gain_vtbl,
        &calib_lo_leakage_vtbl, &calib_silent_rssi_vtbl, &calib_lo_power_vtbl};
    u32 k;
    for (k = 0; k < CALIB_ENG_NUM; k++)
        calib_objs[k]->vt = calib_vt[k];
}

/* 8. fw__init_link_defaults (0x8f53dc, 92 Б): дефолты связи. Прежний порт делал только
 * первые три записи — 0x800020..0x80002c (параметры температурного сервиса и
 * STREAM_MGR__ready_for_modify) и [gp,-0x90] = 0x8000f4 оставались 0 (снимок стенда). */
void fw_init_link_defaults(void)
{
    u32 i;
    temp_bb_mdeg = 0xffffffffu;            /* [gp,-0x38] */
    for (i = 0; i < 8; i++)
        temp_rf_mdeg[i] = 0xffffffffu;
    temp_pending_cb = 0;                      /* [gp,-0x37] */
    temp_pending_ctx = 0;                      /* [gp,-0x36] */
    temp_timer_task = 0;                      /* [gp,-0x2] */
    temp_stopping = 0;                      /* [gp,-0xd] */
    temp_enabled = 0;                      /* [gp,-0x4] */
    temp_last_meas_time = 0xffffffffu;            /* [gp,-0x24] */
    temp_radio_req = 0;                      /* [gp,-0x11] */
    temp_period = 0x989680;               /* [gp,-0x59] */
    temp_min_delay = 0xbb8;                  /* [gp,-0x58] */
    temp_rf_meas_flag = 1;                      /* [gp,-0x57] */
    temp_rf_meas_mode = 2;                      /* [gp,-0x56] */
}

/* 9. boot__load_from_flash */
/* boot_load_from_flash — в flash.c (портирована). */
/* hwd_spi_read, hwd_spi_poll_done, hwd_spi_release_lock — в spi.c (портированы). */
/* boot_save_mac_address, hwd_abif_uses_rgf_88af80 — в flash.c (портированы). */
/* flash_cfg_set_* — в flash.c (портированы). */
/* *all_rows — в car.c (портированы). */
/* hwd_abif_rx_table_config_vga_bias — в car.c. */
/* hwd_abif_rx_table_config_vga_stg1_fine_bias — в car.c. */

/* 10. sdp_gpio__boot_init — в hw_init.c (портирована). */

/* 11. pcie_serdes_init — в pcie.c (портирована). */
/* pcie_force_clear_l0s — в pcie.c. */
/* pcie_dbi_read — в pcie.c. */
/* dbi_write — в pcie.c. */
/* pcie_dbi_transfer — в pcie.c. */
/* pcie_dbi_set_addr — в pcie.c. */
/* pcie_dbi_set_data — в pcie.c. */
/* pcie_dbi_start_cmd — в pcie.c. */
/* pcie_ack_8e026c — в pcie.c. */
/* pcie_wait_882644_ready — в pcie.c. */
/* pcie_dbi_ack_done — в pcie.c. */
/* pcie_pm_host_config — в pcie.c. */
/* hwd_pcie_is_l1_state, config_lnkctl, l1_pm_sub_ctl_get, lnkctl_set — в pcie.c. */
/* hwd_pcie_get_ltssm_state — в pcie.c. */
/* pcie_serdes_program_all/init_seq, uses_rgf_880c00, l1ss_enable, clear_88b000_bits,
   rgf_882f80, mirror_link_bit, program_seq_fw_8825c0 — в pcie.c (портированы). */
/* mac_set_* — в mac.c (портированы). */
/* hwd_pcie_is_ep_under_serdes — в pcie.c. */
/* pcie_fix_max_read_req, hwd_pcie_l1_sub_timing_config — в pcie.c. */
/* pcie_bits_set32_s2_w4 — в pcie.c. */

/* 12. cnt_handler__clear_all — в hw_init.c (портирована). */

/* 13. radio_mgr__init_global (0x8f56b8) — в radio_mgr.c. */

/* 14. hwm__reset_analog_block (0x8d7760, «Switch from XTAL to 165MHZ»): питание ABIF,
 * ADC-клок, PLL-unlock IRQ, переключение такта на PLL3. Порядок — как vendor. */
void hwm_reset_analog_block(void)
{
    abif_power_up_analog(1);
    hwd_abif_adc_clk_ctrl(1);
    abif_ack_unmask_pll_unlock_irq();
    car_enable_pll3_and_wait_on();
}

/* 15. led_scheme */
/* led_scheme__init (0x8da81c): a >= 4 — сисассерт 0x1157 (и дальше); a != 3 —
 * [0x8003bc] ([gp,142] .as) = a; затем всегда led__set([0x8003bc], 0, 0x64). Прежде канал
 * брался из 0x800a64 и led__set звался только при a != 3. */
void led_scheme_init(u32 a)
{
    if (a >= 4)
        fw_sysassert_fatal(__builtin_return_address(0), 0x1157);
    if (a != 3)
        led_scheme_channel = a;
    hw_ch_enable_once(led_scheme_channel, 0, 0x64);
}
/* led_scheme_apply — в led.c (портирована). */
/* u_schd_cancel — в sched.c. */
/* u_schd_arm_timer — в sched.c. */
/* u_schd_insert_timer — в sched.c. */
/* u_schd_alloc_task — в sched.c. */
/* u_schd_fill_task_b — в sched.c. */
/* u_schd_timer_set_fields — в sched.c. */
/* list_find_entry — в sched.c. */
/* list_find_entry_c — в sched.c. */
/* list_find_entry_b — в sched.c. */
/* u_schd_schedule — в sched.c (портирована). */

/* 16. hwd_phy_init — в phy.c (портирована). */

/* 17. init_rf_hw — в rf.c (портирована); хелперы ниже. */
/* hwd_abif_fs_off, dvs_if_splitter_enable, dvs_rf_activate — в car.c (портированы). */
/* abif_mask_fs_unlock_irq, abif_ack_unmask_fs_unlock_irq — в car.c (портированы). */
/* hwd_abif_* — в car.c (портированы). */
/* hwf_rf_wait_reset_done, hwm_calib_set_loopback_mode — в rf.c (портированы). */
/* hwf_rf_wait_ready_log, rfc_write_field_434_2ec33 — в rf.c. */
/* hwd_abif_caf_lpbk_mode, lpbk_mode_switches_config, dvs_lo_splitter_config_buf_val — в car.c;
   hwd_mac_sxd_rx_mode_entry, sxd_mode_neutral — в mac.c (портированы). */
/* xpm_accumulate_bits — в rf.c. */
/* marlon_r_if_class_init_board_file_interface — в brd_if.c. */
/* ut_hw_modes_chain_3, rf_configure_chain — в rf.c; dvs_rfca_cmd_enable — в car.c. */
/* rfc_write_field_434_2ec33 — в rf.c. */
/* rfc_write_packed_fields, rfc_field_write, rfc_write_chain_field, hwd_rfc_write_core_fw_mode1 — в rf.c. */
/* rf_identify_type, rf_configure_role_power — в rf.c (портированы). */
/* rf_power_off (0x8e2fa8): журнал + SDP-порт 4 (пин 12, питание/сброс RF) = 0 через
 * sdp_drive_pin_timed. Вызывающие vendor кладут в r0 объект RF (0x8042c8), но функция его
 * не читает (r0 сразу затирается уровнем журнала 0x10) — аргумента нет. Прежняя версия
 * пропускала запись (эксперимент «AXI-запись в 0x880b88 виснет»); vendor зовёт её только
 * на ошибках (role_power == 2, сбой секции параметров board-файла) — порт как есть. */
void rf_power_off(void)
{
    fw_log_emit0(0x10, 0x1005a54);
    sdp_drive_pin_timed(0);
}

/* 21. arc_action_point__install_default (0x8c3b68, аргумент 0x3ffff из fw_main): точка 1 —
 * AMV1 = 0, AMM1 = 0x3ffff, AC1 = 2 | 3 << 4 | 1 << 8 (защита ICCM). Аргумент vendor
 * передаёт в r0 — у нас константа (единственный вызов). */
void arc_action_point_install_default(void)
{
    struct arc_ap_cfg cfg;
    cfg.idx = 1;
    cfg.value = 0;
    cfg.mask = 0x3ffff;  /* vendor r0 = 0x3ffff → AMM1 (aux 0x224) */
    cfg.target = 2;
    cfg.ttype = 3;
    cfg.mode = 0;
    cfg.pair = 0;
    cfg.ac8 = 1;
    arc_action_point_arm(&cfg);
}

/* 22. fw_boot__log_versions */
void fw_boot_log_versions(void)
{
    bootloader_version_log();
    fw_version_log(fw_ver_major, fw_ver_minor, fw_ver_sub, fw_ver_build);
    fw_version_log_date(fw_build_sec, fw_build_min, fw_build_hour,
                        fw_build_day, fw_build_month, fw_build_year);
    fw_image_info_set_flavor(2);
}

/* 23-24. calib_engine__init_all, power_mngr__init — в power.c (портированы). */
/* hwm_power_33kHz_clk_detector — в power.c. */
/* hwm_measure_33khz_wait — в power.c. */
/* hwm_start_33khz_measure — в power.c. */
/* mac_read_tsf_hi — в mac.c. */
/* (L_8e9954 = hwm_measure_33khz_wait, исправлено) */
/* obj_vt801bec_ctor, obj_vt801c30_ctor, basic_sm_bind_descriptor — в power.c;
   radio_mgr_init_list — в radio_mgr.c. */
/* calib_engine_sm_init, chan_sw_set_active_channel — в power.c (портированы). */
/* basic_sm_bind_descriptor — в power.c. */

/* 25. lmac_if__ucode_init — в lmac.c (портирована). */

/* 28. вход в главный цикл (0x8ea698 → 0x8e76a8) — u_schd_run (sched.c), зовёт fw_main. */

/* --- цели тонких обёрток (реализуются по мере портирования) --- */
/* l2mgr_init_frame_pool — в pool.c. */
/* ba_sm_prepare_ba_td — в pool.c. */
/* operational_if__mbox_init (0x8d9f00): инициализация operational_mbox (include/mbox.h),
 * описатели колец — RGF 0x8802bc/0x8802cc (mbox_ctl драйвера). */
struct operational_mbox *operational_if_mbox_init(mbox_evt_send_fn handler)
{
    /* vendor 0x8d9f0c: при повторе — сисассерт 0x105d и (если вернулся) всё равно init. */
    if (wmi_op_mbox_inited != 0)            /* [gp,-0x78] уже инициализирован */
        fw_sysassert_fatal(__builtin_return_address(0), 0x5d | (1u << 12));
    fw_log_emit0(0x20, 0x1003a50);         /* "Operational MBOX init" */
    u32 desc[4];
    desc[0] = 5; desc[1] = 0x1b; desc[2] = 0x518; desc[3] = 0x100;
    /* vendor ставит таблицу методов при загрузке (0x8c1ae8: [0x804234] = 0x800790);
     * нужна до mbox_init_descriptor (vt[2]). */
    operational_mbox.wm.vt = &operational_mbox_vtbl;
    mbox_init_descriptor(&operational_mbox.wm, (struct mbox_ring_hw *)HW_RGF_USER_USER_SCRATCH_PAD, HW_OP_MBOX_TX_RING, HW_OP_MBOX_RX_RING,
                         op_mbox_rx_bufs, op_mbox_tx_bufs, 5, 0x1a, desc);
    wmi_op_mbox_inited = 1;                  /* [gp,-0x1e] */
    operational_mbox.evt_send = handler;     /* [0x804268] = event-send handler */
    return &operational_mbox;
}

/* operational_if__get_mbox (0x8d9f7c): operational_mbox (assert 0x5e, если не инициализирован). */
struct operational_mbox *operational_if_get_mbox(void)
{
    if (wmi_op_mbox_inited != 1)            /* [gp,-0x78] */
        fw_sysassert_fatal((void *)0, 0x5e | (1u << 12));
    return &operational_mbox;
}

/* sched__step_8d9f00 (0x8f58e4): init mbox + установить handler в слот. */
void sched_step(struct operational_mbox **a, mbox_evt_send_fn b)
{
    /* vendor sched__step_8d9f00: *(a) = operational_if__mbox_init(b) — mbox-ctx */
    *a = operational_if_mbox_init(b);
}
/* led__set (0x8da790): LED ch (< 3) — on/период. В 6.2 тела драйвера LED пусты
 * (0x8da7fc, 0x8da78c — j_s [blink]; 0x8da75c — только проверка ch < 3, сисассерт 0x100b),
 * поэтому видимый эффект — сисассерт 0x1008 при ch >= 3 и флаг [0x8019bc + ch*4] = 1
 * при первом обращении. Ничего не делает, если [0x8003b0] ([gp,0x22c]) == 0. */
void hw_ch_enable_once(u32 ch, u32 on, u32 period)
{
    if (led_enabled == 0)
        return;
    if (ch >= 3)
        fw_sysassert_fatal(__builtin_return_address(0), 0x1008);
    volatile u32 *once = &led_ch_used[ch];
    if (*once == 0)
        *once = 1;                      /* перед этим vendor зовёт пустую 0x8da7fc(ch) */
    if (on == 0)
        return;                         /* пустая 0x8da78c(ch, 1) */
    if (period != 0 && ch >= 3)         /* 0x8da75c(ch, on, period): проверка ch */
        fw_sysassert_fatal(__builtin_return_address(0), 0x100b);
    /* period == 0: пустая 0x8da78c(ch, 0) */
}
/* mem_pool_free_locked_evt — в pool.c. */
/* field_set_0x19_8caf4c — в power.c. */
/* field_set_0x00_8d8db8, mem_pool_get_field14 — в pool.c. */
/* u_schd_hw_timer_load_start — в sched.c. */
/* power_start_two_timers — в power.c. */
/* timer_start — в sched.c. */
/* irq_set_level — в irq.c. */
/* u_schd_hw_timer_a_start, u_schd_timer_irq_pending — в sched.c (портированы). */
/* user_icr_timer_bit — в sched.c. */
/* gpio_reset_config, hw_personality_detect, hw_personality_read_strap — в hw_init.c (портированы). */
/* sdp_gpio_personality_step, SDP_hwd_sdp_is_defined_sdp — в hw_init.c. */
/* SDP_sdp_init_2 — в hw_init.c. */
/* gpio_set_pin_func_and_dump — в hw_init.c. */
/* sdp_set_defined_bit — в hw_init.c. */
/* hwd_sdp_drive_value — в hw_init.c. */
/* power_mngr_check_mode — в power.c. */
/* radio_get_channel — в power.c. */
/* phy_program_channel_regs — в phy.c. */
/* regd_is_country_not_jp — в power.c. */
/* regd_is_unset_or_jp — в power.c. */
/* regd_is_country_us — в power.c. */
/* phy_load_88416c_table — в phy.c. */
/* rf_set_889494_low_nibble — в rf.c. */
/* hwd_rfc_tx_power_cfg — в rf.c. */
/* u_schd_timer_irq_pending — в sched.c. */
/* u_schd_expire_timers_thunk — в sched.c; isr_step_22f70_80044c — в isr.c. */
/* u_schd_expire_timers, u_schd_pop_expired, time_cmp, u_schd_deadline_less — в sched.c. */
/* rf_kill_mask_irq — в isr.c. */
/* rf_kill_irq_task — в isr.c. */
/* basic_sm_handle_event — в power.c. */
/* basic_sm_do_transition — в power.c. */
/* mac_toggle_880288_b1 — в mac.c. */
/* rf_kill_ack_irq — в isr.c. */
/* rf_kill_unmask_irq — в isr.c. */
/* gpio_pulse_880b60_18/19 — в hw_init.c. */
/* uc_evt_mask_irq_and_defer_drain — в isr.c. */
/* isr_step_22f70_80044c — в isr.c. */
/* host_irq_mask_awake_tsf — в isr.c. */
/* mac_read_tsf64 — в mac.c (портирована). */
/* hwd_dma_read_status/get_881c80/op/ack_881c44/bad_cause — в dma.c (портированы). */
/* tx_list_remove, vring_list_find, vring_schd_move_to_ready — в vring.c (портированы). */
/* iter_init, list_has_items, iter_next — в vring.c. */
/* rm_ch_switch_sm_notify_ch_switch_done — в vring.c. */
/* vring_schd_bind_if_free — в vring.c. */
/* sm_pring_bind_vring — в vring.c (структура). */
/* sm_pring_notify_step — в vring.c. */
/* vring_schd_stop_vring — в vring.c. */
/* sm_pring_state_step — в vring.c. */
/* vring_reg_write_locked_28 — в vring.c. */
/* vring_reg_write_locked_3c — в vring.c. */
/* macq_hw_disable_queue_fw — в vring.c. */
/* vring_schd_is_vring_ready, vring_hw_set_ready_bit — в vring.c. */
/* list_find_entry_d — в sched.c. */
/* rfc_read_or_dead — в rf.c. */
/* hwd_rfc_write_verify — в rf.c. */
/* check_rf_boardfile — в rf.c. */
/* rf_boardfile_read_platform_info — в rf.c. */
/* hwd_rfc_write_core_fw — в rf.c; hwd_abif_rfc_divider_restart — в car.c (портированы). */
/* marlon_r_if_class_load_brd_rf_cfg_section — в brd_if.c. */

/* boot__init_named_object (0x8f2044): имя с позиции off строки name — длина n до нуля,
 * n + 1 байт (с нулём) в dst (0x8f2070 → memcpy 0x8c0380); возврат n (extw). obj не
 * используется (r0 только сохраняется). */
u32 boot_init_named_object(void *obj, void *name, u32 off, void *dst)
{
    (void)obj;
    const u8 *src = (const u8 *)name + off;
    u32 n = 0;
    while (src[n] != 0)
        n++;
    memcpy_fw(dst, src, (u8)(n + 1));
    return (u16)n;
}
/* abif_power_up_analog — в car.c (портирована). */
/* sdp_drive_pin_timed — в hw_init.c. */
/* bootloader_version_log — в log.c. */
/* mac_read_880a2c_38 — в mac.c. */
/* fw_version_log, fw_version_log_date, fw_image_info_set_flavor — в log.c. */
/* radio_mgr_init_list, obj_vt803210_ctor — в radio_mgr.c. */
/* field_set_0x08_8d8eb4 — в radio_mgr.c. */
/* arc_action_point_arm — в hw_init.c. */
/* tx_api_free_memory — в pool.c. */
/* stream_mgr_check_vring — в pool.c. */
/* fw_divmod_unsigned — в pool.c. */
/* tx_api_mask_from_queue — в dma.c. */
/* hwd_dma_uses_rgf_881c00_8d0b14 — в dma.c. */
/* mem_pool_get_field14 — в pool.c. */

/* power_halt_seq — в power.c. */
/* hwd_abif_caf_pwdn_mode — в car.c. */
/* rf_get_connected_mask — в rf.c. */
/* ut_hw_modes_chain_3 — в rf.c. */
/* rf_configure_chain — в rf.c. */
/* rf_cfg_get_rf_mask_45e — в rf.c. */
/* rf_configure_role_power — в rf.c (0x8e2e88). */
/* marlon_r_if_class_config_channel — в rf.c. */
/* field_set_0x00_8e5dfc — в power.c. */
/* bitmap_alloc_bit — в power.c. */
/* bit_iter_has_more — в power.c. */
/* lo_power_restore_rfc_field — в power.c. */
/* rfc_write_field_484 — в rf.c. */
/* fw2uc_signal_wake_and_wait_ack — в power.c. */
/* evt_ring_push_1c — в pool.c. */
/* calib_obj4_reset_d4 — в power.c. */
/* calib_engine_get_by_index — в power.c. */
/* rfca_touch_rf_module — в car.c. */

/* hwd_pcie_set_low_power — в pcie.c. */
/* pcie_lp_set_byte_field — в pcie.c. */
/* pcie_mask_l1_enter_irq — в pcie.c. */
/* hwd_pcie_get_88b0c0_state4 — в pcie.c. */
/* hwd_pcie_get_882b80 — в pcie.c. */
/* fw2uc_signal_halt_and_wait_ack — в power.c. */
/* hwd_pcie_ltssm_is_l1_idle — в pcie.c. */
/* hwd_pcie_get_ltssm_state — в pcie.c (0x8d13fc). */

/* brd_if_multi_array_* (init, verify/get_board_file_format_version, методы vtable),
 * brd_if_scan_sections, marlon_r_if_class_load_brd_parameters_section,
 * brd_if_build_tx_sector_list, brd_section_info_reset, brd_if_clear_block_info,
 * rf_tbl_lookup_by_module, rf_if_num_tx_sectors — в brd_if.c. */
/* fw_divmod_signed — в pool.c. */

/* RX-калибровка — calib.c. */

/* hwm_analog__prepare_buf (0x8e2960): инициализация analog-буфера + 2×power_halt_seq. */
__attribute__((section(".textlate"))) void hwm_analog_prepare_buf(u32 a)
{
    struct ps_ctx ctx;                     /* PS-контекст на стеке: шаги 2..4 */
    memset0_words(&ctx, sizeof(ctx));      /* L_8c1cd8 */
    ctx.flags |= 0x1c;
    fw_log_emit0(0x1e, 0x1001e54);
    fw2uc_signal_halt_and_wait_ack();      /* L_8db148 */
    power_halt_seq(1, &ctx);
    power_halt_seq(0, &ctx);
    if (a != 0)
        rf_restore_if_needed(a);
    fw2uc_signal_wake_and_wait_ack();      /* L_8db0d0 */
}

/* rf__restore_if_needed (0x8e2acc, 192 Б): восстановить RF после останова питания (hwm_analog_prepare_buf).
 * Аргумент (r0) не читается — проверку «нужно ли» делает вызывающий
 * (hwm_analog__prepare_buf: if (a != 0) ...). Тело: pwdn_mode(0) + 2 задержки,
 * перенастроить цепочку/роль/канал, затем для каждого RF-бита маски 0x45e
 * с индексом < 8 — calib reset + touch модуля. */
__attribute__((section(".textlate"))) void rf_restore_if_needed(u32 a)
{
    u32 it;
    (void)a;

    fw_log_emit0(0x1e, 0x1001e60);          /* "Restore RF was needed" */

    arc_zol_nops2(0x5dc0);                  /* vendor 0x8e2ae6: lp 24000 × 2 nop_s */
    hwd_abif_caf_pwdn_mode(0);
    arc_zol_nops2(0x27100);                 /* vendor 0x8e2b00: lp 160000 × 2 nop_s */

    ut_hw_modes_chain_3(rf_get_connected_mask(&rf_obj));
    rf_configure_chain(0, 0);
    ut_hw_modes_chain_3(rf_cfg_get_rf_mask_45e(&rf_obj));
    rf_configure_role_power(&rf_obj);
    marlon_r_if_class_config_channel(&rf_obj, radio_get_channel(&rf_obj), 1);

    field_set_0x00_8e5dfc(&it, rf_cfg_get_rf_mask_45e(&rf_obj));
    while (bit_iter_has_more(&it)) {
        u32 bit = bitmap_alloc_bit(&it);
        if (bit < 8) {
            calib_obj4_reset_d4();
            rfca_touch_rf_module(0, bit, 1);
        }
    }
    lo_power_restore_rfc_field();
    hwd_abif_caf_pwdn_mode(1);
}

/* rf__check_state (0x8c74b4): RF-комм-тест + чтение рег + лог. obj (silent_rssi) не читается. */
void rf_check_state(const struct calib_silent_rssi *obj)
{
    (void)obj;
    u32 r14 = rf_comm_test(&rf_obj, rf_obj.rf_idx);
    u32 r3 = hwd_rfc_read_rgf(rf_obj.rf_idx, 0x1b4);
    fw_log_emit2(0x6, 0x1009f2c, r14, r3);
}

/* rf_comm_test (0x8c6a40): RF-комм-тест — счётчик + rf_type_is_marlon +
 * hwd_rfc_read_rgf + запись 0x880a68. */
__attribute__((section(".textlate"))) u32 rf_comm_test(struct rf_obj *base, u8 idx)
{
    u32 s = arc_irq_disable();
    u8 cnt = (u8)(base->comm_test_cnt + 1);
    base->comm_test_cnt = cnt;
    u32 marlon = rf_type_is_marlon();      /* L_8da594(cnt) — cnt игнорируется */
    u8 r1 = base->comm_test_cnt;
    u32 reg_off, expected;
    if (marlon == 0) {
        if (r1 & 1) { expected = 0x97479747; reg_off = 0x3d8; }
        else        { reg_off = 0x3e0; expected = 0x7fd; }
    } else {
        if (r1 & 1) { reg_off = 0xad0; expected = 0x97479747; }
        else        { reg_off = 0xad8; expected = 0x4007fd; }
    }
    u32 result = hwd_rfc_read_rgf((u32)idx, reg_off);   /* vendor 0x8c6aa8: extb_s — беззнаково */
    arc_irq_restore(s);
    if (result == expected) {
        MMIO32(RF_STATUS) = 0;               /* 0x880a3c + 0x2c */
        return 1;
    }
    /* vendor 0x8c6acc: breq r0,0 → «SPARROW-R COMM TEST FAILED» (0x100528c), иначе MARLON
     * (0x1005254). Прежде строки были перепутаны. */
    u32 marlon2 = rf_type_is_marlon();     /* L_8da594(0) */
    u32 token = (marlon2 == 0) ? 0x100528c : 0x1005254;
    fw_log_emit2(0, token, expected, result);
    MMIO32(RF_STATUS) = 1;
    return 0;
}
/* rf__get_active_index (0x8ccb20): активный RF-индекс = позиция младшего
 * установленного бита маски [gp,0xbe]=0x800242, минус 1 (0xff при маске 0). */
u32 rf_get_active_index(void)
{
    u8 m = rf_active_mask;
    if (m == 0)
        return 0xff;
    u32 lo = m & ~(m - 1);   /* младший установленный бит */
    /* norm (ARC) — число избыточных знаковых бит = clz - 1 для положительного: для бита 0
     * norm = 30 → 0x1e - 30 = 0. Прежде здесь считался clz (индекс на 1 меньше, бит 0 →
     * 0xff…ff → ассерт 0x1581 в temp__get_active_rf). Результат — extb_s (без знака). */
    u32 norm = 0;
    while (!(lo & 0x40000000u)) { lo <<= 1; norm++; }
    return (u8)(0x1e - norm);
}
__attribute__((section(".textlate"))) void hwd_args_to_regs(u32 a, u32 b, u32 c, u32 d)
{
    u8 buf = 0;
    hwd_abif_dvs_rfca_cmd_enable(a, &buf);
    hwd_rfc_write_core_fw(0, d, b, c);
    if (a != buf) hwd_abif_dvs_rfca_cmd_enable(buf, 0);
}
/* rf_mask__count_modules (0x8ccb04), bitmap__expand_byte4_to_list (0x8ccafc) — в calib.c. */

/* temp__get_rf_by_index (0x8cca40): таблица температуры RF 0x847fa8 (м°C); 0xff→активный RF,
 * >=8→-1; при b == 1 и известной температуре — в °C (знаковое деление на 1000:
 * 0x8cca6a brne r13,1 / cmp r0,-1 / blne 0x8c02dc — раньше b игнорировался). */
__attribute__((section(".textlate"))) u32 temp_get_rf_by_index(u32 a, u32 b)
{
    u32 r;
    if (a == 0xff)
        r = temp_get_active_rf(0);
    else if (a >= 8)
        r = 0xffffffff;
    else
        r = temp_rf_mdeg[a];
    if (b == 1 && r != 0xffffffff)
        r = (u32)fw_divmod_signed((s32)r, 1000);
    return r;
}
/* temp__get_active_rf (0x8ccbf4): активный RF → таблица 0x847fa8; 0xff→-1;
 * при a==1 (агрегат) — знаковое деление на 1000. */
__attribute__((section(".textlate"))) u32 temp_get_active_rf(u32 a)
{
    u32 idx = rf_get_active_index();
    u32 r0;
    if (idx >= 8)
        fw_sysassert_fatal((void *)0, 0x1581);
    if (idx == 0xff)
        r0 = 0xffffffff;
    else
        r0 = temp_rf_mdeg[idx];
    if (a == 1 && r0 != 0xffffffff)   /* brne r13,1 / cmp r0,-1 / mov.ne/bl.ne */
        r0 = (u32)fw_divmod_signed((s32)r0, 0x3e8);
    return r0;
}
/* calib__log_if_nonzero (0x8d6b20) — в calib.c. */

s64 fw_ashr64(s64 v, u32 n) { return v >> n; }
/* schedule_scheme_builder__build_allocations (0x8c68a0): лог + remove_app_ie +
 * add_bcon + reset_alloc_list + [a+0xc]=0. */
__attribute__((section(".textlate"))) void schedule_scheme_builder_build_allocations(struct sched_scheme *a)
{
    fw_log_emit0(0x2b, 0x1014510);
    remove_app_ie((u32)a->mid, 0, 0x90);
    add_bcon(a->mid);
    sched_builder_reset_alloc_list(a->ese);
    a->built = 0;
}

/* 0x8023c0: таблица переходов switch vendor remove_app_ie (0x8e2600; ldb, цель = 0x8e263a +
 * 2·запись). Порт берёт из неё номер случая (0..4 → блок IE) и переключается по нему. */
FWDATA(8023c0) const s8 remove_app_ie_jt[5] = {
    0x00, 0x0a, 0x0d, 0x03, 0x06,
};

/* remove_app_ie (0x8e2600, 94 Б): выбрать IE-блок по таблице 0x8023c0[idx] → app_ie_remove_tlv. */
__attribute__((section(".textlate"))) u32 remove_app_ie(u32 obj, u32 idx, u32 flag)
{
    u32 r16 = obj + 0x48;
    fw_log_emit2(0x2b, 0x100c8d0, idx, flag);
    if (idx >= 5) {
        fw_sysassert_fatal((void *)0, 0x1370);
        return 0;
    }
    s32 case_idx = remove_app_ie_jt[idx];
    u32 r0 = 0;
    switch (case_idx) {
    case 0: r0 = r16 + 0x1e0; break;
    case 1: r0 = r16 + 0x1b0; break;
    case 2: r0 = r16; break;
    case 3: r0 = r16 + 0x1bc; break;
    case 4: r0 = r16 + 0x1c8; break;
    case 5: r0 = r16 + 0x1d4; break;
    }
    return app_ie_remove_tlv((struct app_ies *)r0, flag);
}

/* app_ie__remove_tlv (0x8e255c, 134 Б): удалить TLV из app-IE блока (сдвиг + total). */
__attribute__((section(".textlate"))) u32 app_ie_remove_tlv(struct app_ies *b, u32 tlv_id)
{
    fw_log_emit2(0x2d, 0x1010edc, tlv_id, b->buf);
    struct ie_iter it;
    ie_iter_init(&it, b);
    u8 *r13 = app_ie_walk_list(&it);
    while (r13 != 0 && *(u8 *)r13 < tlv_id)
        r13 = app_ie_walk_list(&it);
    if (r13 == 0)
        return 0;
    if (tlv_id < *(u8 *)r13) {
        fw_log_emit1(0x2d, 0x1010f08, tlv_id);
        return 0;
    }
    u32 r16 = (u32)r13[1] + 2;
    u32 base = b->buf;
    u32 total = b->len;
    u32 rem = total - ((u32)r13 - base) - r16;
    memcpy_fw(r13, r13 + r16, rem);
    b->len = (u16)(total - r16);
    fw_log_emit3(0x2d, 0x1010f28, tlv_id, (u32)r13, total - r16);
    return 1;
}
/* add_bcon (0x8c2778, 186 Б): построить DMG beacon, выделить post-send-info
 * и отправить в очередь (TX_API__send_dband_bcon). */
__attribute__((section(".textlate"))) void add_bcon(struct mid *obj)
{
    struct mid_bss *r13 = &obj->bss;      /* add3 obj,9 */
    u32 payload = TX_API_alloc_tx_payload();
    if (payload == 0)
        fw_sysassert_fatal((void *)0, 0x124f);   /* vendor: после assert идёт в тело */

    bcon_tx_build_step(r13, 0);
    u32 len = 0;
    tx_mgmt_srvs_build_dmg_beacon(payload, &len, obj, 0);

    if (bcon_pool_inited == 0) {
        bcon_pool_inited = 1;
        mem_pool_init(&bcon_info_pool, bcon_info_mem, sizeof(struct bcon_post_info), 8);
    }
    struct bcon_post_info *r18 = mem_pool_allocate(&bcon_info_pool);
    if (r18 == 0) {
        fw_log_emit1(0x1c, 0x1017104, bcon_pool_empty_count);   /* "pool is empty" */
        bcon_pool_empty_count += 1;
        r18 = &bcon_info_static;          /* статическая память */
    }

    bcon_bits_set16_s7_w3(r13->bi_ctrl, r13->abft_len & 7);
    r13->bi_ctrl[0] &= ~(1u << 1);
    memcpy_fw(r18->bi_ctrl, r13->bi_ctrl, 6);
    r18->mac = 0;
    r18->cfg = ((r13->state == 2) ? 1u : 0u) << 1;
    r18->bi_mode = 1;

    /* vendor передаёт колбэки числом в младшем отображении ICCM (0x36fec = pcp_bcon_wb,
     * 0x470c = L_8c470c); у нас там чужой код — только полные адреса наших портов
     * (было: PCP_START → исключение в fwq_tx_queue_step, ilink2 0x471c, стенд 2026-10-19). */
    if (TX_API_send_dband_bcon(payload, (u16)len, pcp_bcon_wb, bcon_post_send_cb, r18, 0) == 0)
        fw_log_emit0(0x1c, 0x101717c);   /* "send_dband_bcon() failure" */
}

/* pcp_bcon_wb (0x8f6fec, 44 Б): write-back DMG beacon — журнал статуса, счётчик
 * mgmt_stats.bcon_wb, вернуть кадр в пул. */
__attribute__((section(".textlate"))) void pcp_bcon_wb(u32 payload, u32 status, u32 conn)
{
    (void)conn;
    fw_log_emit1(0x1c, 0x1016f00, status);   /* "pcp_bcon_wb()...free beacon memory status = %x" */
    mgmt_stats.bcon_wb += 1;
    TX_API_free_memory(payload);
}

/* L_8c470c (0x8c470c, 80 Б): колбэк после отправки DMG beacon (info — post-send-info из
 * add_bcon): журнал; при sent != 0 — CMD_BCON_MGT с параметрами info; вернуть info в пул
 * 0x805a98 (кроме статической ячейки 0x805a98+0x14). */
__attribute__((section(".textlate"))) void bcon_post_send_cb(struct bcon_post_info *info, u32 sent)
{
    if (info == 0)
        return;
    fw_log_emit3(0x2c, 0x1017148, info->cfg, info->bi_mode, sent);
    if (sent != 0)
        lmac_if_send_bcon_mgt(info->cfg, info->bi_mode, info->bi_ctrl_w[0], info->bi_ctrl_w[1], info->mac);
    if (info != &bcon_info_static)
        mem_pool_free(&bcon_info_pool, info);
}
/* --- sub-хелперы add_bcon (портированы) --- */

/* Побайтовая вставка bit-поля: байт (bf__set_field_byte_fw) и LE-полуслово
 * (bf__set_field_u16_le). Адрес может быть нечётным — работаем побайтово. */
static inline void bf8(u8 *p, u32 start, u32 width, u32 v)
{
    u32 m = ((1u << width) - 1) << start;
    *p = (u8)((*p & ~m) | ((v << start) & m));
}
static inline void bf16le(u8 *p, u32 start, u32 width, u32 v)
{
    u32 w = (u32)p[0] | ((u32)p[1] << 8);
    u32 m = ((1u << width) - 1) << start;
    w = (w & ~m) | ((v << start) & m);
    p[0] = (u8)w;
    p[1] = (u8)(w >> 8);
}

/* add_discovery_bcon (0x8c2904, 300 Б): бикон discovery-режима на время пребывания на канале
 * (scan_type — второй аргумент). Поле Beacon Interval Control записи (bss.bi_ctrl): б1 = 1
 * (discovery), [5][5:4] = 0 (0x8ed298), A-BFT len [9:7] = 1 (0x8ed1f0), [3][7:5] = 1
 * (0x8ed2b0), [1..2][12:7] = 0 (0x8ed208); при scan_type 3 — ещё б0 = 1, A-BFT len = 3,
 * MAC в CMD_BCON_MGT — direct_scan_mac скана записи, bi_mode 3; иначе без MAC, bi_mode 2.
 * Затем кадр DMG-бикона (tx_mgmt_srvs__build_dmg_beacon), post-send-info из пула 0x805a98
 * (как add_bcon: cfg 0) и TX_API__send_dband_bcon на канале 1 без write-back (кадр
 * освобождает очередь), колбэк L_8c470c. Нет кадра — ассерт 0x1537 (vendor идёт дальше). */
__attribute__((section(".textlate"))) void add_discovery_bcon(struct mid *mid_e, u32 scan_type)
{
    u8 *bi = mid_e->bss.bi_ctrl;
    const u8 *mac = 0;
    u32 bi_mode = 2, len = 0;
    u32 payload = TX_API_alloc_tx_payload();

    if (payload == 0)
        fw_sysassert_fatal(__builtin_return_address(0), 0x1537);
    bi[0] |= 1u << 1;
    bf8(&bi[5], 4, 2, 0);
    bcon_bits_set16_s7_w3(bi, 1);
    bf8(&bi[3], 5, 3, 1);
    bf16le(&bi[1], 7, 6, 0);
    if (scan_type == 3) {
        bi[0] |= 1u;
        bcon_bits_set16_s7_w3(bi, 3);
        bi_mode = 3;
        mac = mid_e->disc.scan->direct_mac;
    }
    tx_mgmt_srvs_build_dmg_beacon(payload, &len, mid_e, 0);
    fw_log_emit3(0x2c, 0x10171a0, mid_e->id, scan_type, len);

    if (bcon_pool_inited == 0) {
        bcon_pool_inited = 1;
        mem_pool_init(&bcon_info_pool, bcon_info_mem, sizeof(struct bcon_post_info), 8);
    }
    struct bcon_post_info *info = mem_pool_allocate(&bcon_info_pool);
    if (info == 0) {
        fw_log_emit1(0x1c, 0x1017104, bcon_pool_empty_count);   /* "pool is empty" */
        bcon_pool_empty_count += 1;
        info = &bcon_info_static;
    }
    memcpy_fw(info->bi_ctrl, bi, 6);
    info->mac = mac;
    info->cfg = 0;
    info->bi_mode = bi_mode;
    if (TX_API_send_dband_bcon(payload, (u16)len, 0, bcon_post_send_cb, info, 1) == 0)
        fw_log_emit0(0x1c, 0x10171d8);   /* "send_dband_bcon() failure" */
}

/* bss_bi_ctrl__PCP_ready_set (0x8c4be8, 56 Б): лог security_en + биты [4..5] байта
 * bi_ctrl[5] (obj+0x10c; 1 при security_en == 1, иначе 0). База полей — add3 r13,r15,0x20 =
 * obj+0x100. */
__attribute__((section(".textlate"))) void bss_bi_ctrl_pcp_ready_set(struct mid_bss *mid, u32 security_en)
{
    fw_log_emit2(0x2b, 0x100c3dc, security_en, dashboard.pcp_security_en);
    bf8(&mid->bi_ctrl[5], 4, 2, (security_en == 1) ? 1u : 0u);
}

/* bcon_tx_build_step (0x8c4c20, 142 Б): собрать frame-control/PCP-поля бикона
 * (obj+0x107..0x10c; obj — e+0x48 записи mid); при a1!=0 дополнительно взвести PCP_ready.
 * База полей — add3 r13,r0,0x20 = obj + (0x20 << 3) = obj+0x100 (прежде было +0x20). */
__attribute__((section(".textlate"))) void bcon_tx_build_step(struct mid_bss *mid, u32 a1)
{
    u8 *m = mid->bi_ctrl;                 /* obj+0x107: m[0..5] — байты obj+0x107..0x10c */
    u8 b;
    u32 is23;

    /* байт obj+0x10b: bits_set8_s2_w4(0) + bits_set8_s0_w2(0) → очистить [0..5] */
    m[4] &= ~0x3fu;

    /* u16@obj+0x107: bcon_bits_set16_s7_w3(1) → бит 7 = 1 (биты 8..9 = 0) */
    bcon_bits_set16_s7_w3(m, 1);

    /* байт obj+0x107: очистить биты 6 и 0 */
    b = m[0];
    b &= ~(1u << 6);
    b &= ~(1u << 0);
    m[0] = b;

    /* бит 1 байта obj+0x107 = 1 если тип [mid+8] НЕ в {2,3} */
    is23 = (mid->mode == 2 || mid->mode == 3) ? 1u : 0u;
    b = m[0];
    b &= ~(1u << 1);
    b |= (is23 ? 0u : 2u);
    m[0] = b;

    /* байт obj+0x109: очистить бит 5 */
    m[2] &= ~(1u << 5);

    /* байт obj+0x108: bits_set8_s2_w4(fwsh_long_range == 0 ? 0xf : 3) + бит 6
     * (ldb_s — беззнаковая загрузка байта; mov.le ⟺ ==0 для 0..255; mov.le r1,0xf —
     * прежде здесь было 7) */
    /* fwsh_long_range — литеральным адресом (FWSH_A_*): с символом gcc переносит записи m[0]/m[2] за
     * это чтение (порядок доступов vendor меняется) */
    /* Поле FSS: 15 (16 SSW в слоте); в long range vendor ставил 3 — ниже aSSFramesPerSlot = 4 (802.11-2020
     * 10.42.5.2, Table 11-22: «shall set the FSS subfield … no less than aSSFramesPerSlot»), такой маяк роняли
     * станции vendor и прежний uc (assert 0x1540/0x145d, чтение таблицы слотов за границей). Стандартный минимум — 4. */
    m[1] = (u8)((m[1] & ~(0xfu << 2)) |
                   (((*(volatile u8 *)FWSH_A_fwsh_long_range == 0) ? ABFT_FSS_FIELD : ABFT_FSS_FIELD_MIN) << 2));
    m[1] |= (1u << 6);

    /* u16@obj+0x10b: bits_set16_s6_w6(0) → очистить биты [6..11] */
    bf16le(m + 4, 6, 6, 0);

    /* байт obj+0x10a, биты [5..7] → bi_cfg.n_bi_abft (bcn_tx_init_bi_cfg: s[3] >> 5) → поле N BIs A-BFT
     * (include/abft_cfg.h: период A-BFT) */
    bf8(m + 3, 5, 3, ABFT_N_BI_ABFT);

    /* u16@obj+0x108: bcon_bits_set16_s7_w6(0) → очистить биты [7..12] */
    bf16le(m + 1, 7, 6, 0);

    /* байт obj+0x107: bits_set8_s2_w4(0) → очистить биты [2..5] */
    bf8(m, 2, 4, 0);

    if (a1 != 0)
        bss_bi_ctrl_pcp_ready_set(mid, 1);

    /* u16@obj+0x109: bcon_bits_set16_s6_w7(1) → бит 6 = 1, биты [7..12] = 0 */
    bf16le(m + 2, 6, 7, 1);
}

/* tx_mgmt_srvs__build_dmg_beacon (0x8e9ccc, 124 Б): тело DMG-бикона (tx_mgmt_build_step
 * 0x8d7df4 — ниже) + IE хоста для бикона. */
__attribute__((section(".textlate"))) void tx_mgmt_srvs_build_dmg_beacon(u32 payload, u32 *out_len,
                                                                         struct mid *obj, u32 a3)
{
    u32 len;
    struct app_ies *block;
    (void)a3;

    len = tx_mgmt_build_step(payload, obj);
    fw_log_emit1(0x2d, 0x1013da0, len);              /* "Before IE push - len %d" */

    block = mid_get_bcon_additional_ies(&obj->bss, 8);
    if (block == 0 || ies_block_is_empty(block) != 0) {
        fw_log_emit1(0x2d, 0x1013e18, len);          /* "No App IE added ... - len %d" */
    } else {
        fw_log_emit1(0x2d, 0x1013dc8, len);
        memcpy_fw((void *)(payload + len), (const void *)block->buf, block->len);
        len += block->len;
        fw_log_emit1(0x2d, 0x1013df0, len);          /* "After IE push - len %d" */
    }

    hexdump_words((void *)payload, len);
    *out_len = len;
}
/* tx_mgmt_build_step (0x8d7df4, 109 Б): собрать mgmt-кадр (frame-ctrl + addr + IE). */
__attribute__((section(".textlate"))) u32 tx_mgmt_build_step(u32 payload, struct mid *obj)
{
    struct ieee80211_dmg_beacon *b = (struct ieee80211_dmg_beacon *)payload;
    u32 r13 = mgmt_tx_set_frame_control(payload, obj);
    memset0_words(b->timestamp, 8);
    b->bcn_int[0] = pcp_bcon_interval;
    b->bcn_int[1] = pcp_bcon_interval >> 8;
    r13 += 0xd;
    r13 += mgmt_tx_copy_addr_from_mid(b->bi_ctrl, obj);
    r13 += builder_push_dmg_parameters(&b->dmg_params, obj);
    if (b->bi_ctrl[0] & 1)
        r13 += mgmt_tx_copy_addr_from_conn((u8 *)(payload + r13), obj);
    /* Awake Window (IE 0x9d) vendor добавлял при разрешённом PS (ps_allowed) — энергосбережение
     * вырезано сознательно (см. fw/action.c psc_req_reject), элемента нет. */
    return r13;
}
/* mgmt_tx__set_frame_control (0x8c068c, 65 Б): frame-ctrl + BSSID-копия. */
__attribute__((section(".textlate"))) u32 mgmt_tx_set_frame_control(u32 dst, const struct mid *obj)
{
    struct ieee80211_hdr *h = (struct ieee80211_hdr *)dst;
    mid_copy_bssid(&obj->bss, h->addr1.b);
    h->duration = 0;
    h->fc = (h->fc & ~(3u << 2)) | (3u << 2);               /* s2_w2 = 3 */
    h->fc &= ~(0xfu << 4);                                  /* s4_w4 = 0 */
    h->fc_b[1] &= ~(0x7u | (1u << 6));
    h->fc &= ~3u;                                           /* s0_w2 = 0 */
    h->fc_b[1] &= ~(0x18u | (1u << 7));
    return 0xa;
}
/* mgmt_tx__copy_addr_from_mid (0x8c0678): Beacon Interval Control бикона записи (mid+0x14f),
 * 6 байт. */
__attribute__((section(".textlate"))) u32 mgmt_tx_copy_addr_from_mid(u8 *dst, const struct mid *obj)
{
    memcpy_fw(dst, obj->bss.bi_ctrl, 6);
    return 6;
}
/* BUILDER_push_dmg_parameters (0x8c06d0, 104 Б): DMG-параметры в байт IE. */
__attribute__((section(".textlate"))) u32 builder_push_dmg_parameters(u8 *dst, const struct mid *obj)
{
    *(u8 *)dst = (*(u8 *)dst & ~3u) | (obj->bss.mode & 3);
    u32 r15 = 1;
    if (fixed_sched.enabled == 0 && mid_get_field_0c(obj->sched) != 0)
        r15 = 0;
    u8 b = *(u8 *)dst;
    b = (b & ~0xcu) | ((r15 & 1) << 2);
    b = (b & ~0x30u) | ((obj->sec.privacy != 0) ? 0x10u : 0u);
    b &= ~0xc0u;   /* bits_set8_s6_w2 = 0 */
    *(u8 *)dst = b;
    fw_log_emit2(0x2d, 0x100fa74, b & 3, (b >> 4) & 1);
    return 1;
}
/* mid__get_field_0c (0x8cc360, 16 Б): схема расписания собрана (built). */
__attribute__((section(".textlate"))) u32 mid_get_field_0c(const struct sched_scheme *obj)
{
    return obj->built;
}
/* mgmt_tx__copy_addr_from_conn (0x8c0664): копия direct_scan_mac scan_mngr записи, 6 байт. */
__attribute__((section(".textlate"))) u32 mgmt_tx_copy_addr_from_conn(u8 *dst, const struct mid *obj)
{
    memcpy_fw(dst, obj->disc.scan->direct_mac, 6);
    return 8;
}
/* bcon__bits_set16_s7_w3 (0x8ed1f0): установить 3 бита [7..9] LE-полуслова.
 * Побайтовый read-modify-write (адрес может быть нечётным). */
__attribute__((section(".textlate"))) void bcon_bits_set16_s7_w3(u8 *p, u32 v)
{
    p[0] = (u8)((p[0] & ~(1u << 7)) | ((v & 1u) << 7));   /* бит 7 */
    p[1] = (u8)((p[1] & ~3u) | ((v >> 1) & 3u));         /* биты 8..9 */
}
/* TX_API__send_dband_bcon (0x8e5284, 136 Б): заполнить TX-дескриптор
 * (payload-0x24) и поставить пакет в очередь 0x8421e4. Возврат 0 = ok. */
__attribute__((section(".textlate"))) u32 TX_API_send_dband_bcon(u32 payload, u16 len, tx_done_fn wb, tx_sent_fn cb,
                                                                struct bcon_post_info *info, u32 channel)
{
    struct tx_pkt *pkt;
    u32 r;

    fw_log_emit2(0x27, 0x1018568, len, channel);   /* "send_dband_bcon. length=%d on channel %d" */
    if (payload == 0)
        fw_sysassert_fatal((void *)0, 0x11e9);     /* vendor: далее продолжает */

    pkt = TX_PKT_OF(payload);
    pkt->len = len;
    /* uc считает TXOP BTI по TXTIME маяка (uc/bti.c): длина PSDU = MPDU из шаблона + FCS (MAC дописывает 4 Б);
     * маяк 30 Б без IE → PSDU 34 Б (замер E4: PHY_PLCP_RX_LEN 34 у станции). Один шаблон на все маяки BTI. */
    fwsh_diag.bcn_psdu_len = (u32)len + 4u;
    pkt->done = wb;
    pkt->sent_cb = cb;
    pkt->sent_info = info;
    pkt->cat = 0;
    pkt->cat_w |= 1u;
    pkt->retry_limit = 0;
    pkt->cid = 0;
    pkt->owner = 0;

    r = fwq_tx_add_packet(&tx_api_2, pkt, channel);
    if (r == 0)
        fw_log_emit0(0x17, 0x101859c);             /* "send_dband_bcon: add_packet() failure" */
    return r;
}
/* sched_builder__reset_alloc_list (0x8e2948): курсор, режим и число слотов = 0. */
__attribute__((section(".textlate"))) void sched_builder_reset_alloc_list(struct ese_sched *a)
{
    struct ese_slot_tbl *list = a->tbl;
    a->cur = 0;
    list->mode = 0;
    a->tbl->count = 0;
}

/* otp_init — в otp.c. */
