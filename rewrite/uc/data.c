// SPDX-License-Identifier: AGPL-3.0-or-later
/* Начальный образ DCCM uc (uc_data): рантайм 0x800000.., в .fw — по 0x940000.
 *
 * Каждый объект — в секции .ucdata.<адрес>; Makefile ставит её по этому адресу и удерживает
 * от --gc-sections, tools/build_fw.py собирает образ (до 0x801be8, остальное — нули).
 * Адреса фиксированы: код uc обращается к этим данным по абсолютным адресам.
 *
 * Происхождение значений — vendor 6.2 (смысл установлен по чтениям vendor-кода и нашего
 * кода; где не установлен — так и написано). Таблицы переходов vendor-кода, которые читали
 * только его switch'и, сюда не перенесены (0x8017d8 .. 0x801be0, 20 таблиц, 496 Б):
 * в нашем образе там нули. Указатели на код и на данные образа — C-инициализаторы. */
#include "../include/types.h"
/* Здесь — сами объекты: макросы dccm.h выключены (-DUC_DCCM_OBJECTS в Makefile). */
#include "dccm.h"

#define UCDATA(addr) __attribute__((section(".ucdata." #addr), used))

/* Упакованные обёртки: выравнивание 1 и точный размер (массив GCC выровнял бы на 4 и
 * добил до кратного 4 — соседние объекты перекрылись бы). */
#define UCD_BYTES(n) struct __attribute__((packed)) { u8 b[n]; }
#define UCD_PACKED(t) struct __attribute__((packed)) { t v; }
#define UCD_ARRAY(t, n) struct __attribute__((packed)) { t v[n]; }

/* Строки имён автомата BI — определены в конце файла. */
extern char bi_sm_name[], bi_state_name_bti[], bi_state_name_abft[], bi_state_name_dti[],
            bi_state_name_aw[], bi_event_name_dti_to_bti[], bi_event_name_bti_to_abft[],
            bi_event_name_bhi_to_dti[], bi_event_name_bhi_to_aw[], bi_event_name_aw_to_dti[];

/* ---- gp-окно 0x800429..0x80051c (gp = 0x800528) ---- */
/* Значение поля abif 0x88a204 в нормальном режиме RF, если 0x80042a != 0 (rf_set_normal_mode). */
UCDATA(800429) u8 rf_normal_abif_field = 0x2a;
/* MCS управляющих кадров (аргумент rate у direct_tx_send_from_desc / tx_send_imm_response);
 * пишет ucode_cmd_0x49_handler. В 6.4 ps.h назван «PS разрешён» — какое толкование верно, не установлено. */
UCDATA(80043c) u8 ctrl_frame_mcs = 0x1;
/* Четыре 6-битных поля PHY base+0x1c0/0x1c4 (биты 5:0, 11:6) для режима != 1 (hwd_phy_set_mode_uc). */
UCDATA(80043d) UCD_ARRAY(u8, 4) phy_mode_fields = {{
    0x1b, 0x1b, 0x1d, 0x1d,
}};
/* Указатели round-robin выбора станции внутренней передачи (8 = начать сверху). */
UCDATA(800441) u8 itx_rr_a = 0x8;
UCDATA(800442) u8 itx_rr_b = 0x8;
/* Обновлять NAV по принятому кадру (rx_update_nav_from_frame). */
UCDATA(800445) u8 rx_nav_update_en = 0x1;
/* Текущий набор TX/RX RFC (rfc_restore_txrx_sets; пишет hwd_rfc_powerup_deep_all_rfs). */
UCDATA(800446) u8 rfc_txrx_set = 0xa;
/* Холодный старт: != 0 — обнулить BSS 0x801be8..0x803234 (uc_main). Никем не пишется. */
UCDATA(80044c) u32 uc_cold_boot = 0x1;
/* Маска MAC-команды каналов/слотов: 0x924000 или 0x924f00 (mac_set_slot_mask / mac_set_chain_mask).
 * Не адрес кода, хотя похоже. */
UCDATA(800454) u32 mac_chain_mask = 0x924f00;
/* Флаг фиксированного расписания для L1 (l1_enter_fixed_sched пишет 0, l1_task_dispatch читает). */
UCDATA(80045c) u32 l1_fsched_flag = 0x1;
/* Станция/очередь фиксированного расписания, 0xff — нет (пишет ucode_cmd_0x08_handler). */
UCDATA(800468) u32 fsched_peer_id = 0xff;
/* При assert перевести детектор в режим 0 (uc_assert -> phy_rx_set_ina_det_mode_uc(0)). */
UCDATA(800474) u32 assert_reset_ina_det = 0x1;
/* Разрешение команды 0x08 MAC-очереди (mac_q_tx_ppdu_cmd08). */
UCDATA(80047c) u32 macq_cmd08_en = 0x1;
/* Флаг PM из команды 0x1b (читает background_bi_step). */
UCDATA(8004dc) u32 pm_cfg_flag = 0x1;
/* Разрешение ожидания ответа / RX-потока (tx_send_and_await_rx_frame, rx_flow_step, fixed_sched_run_tx_slot). */
UCDATA(8004ec) u32 rx_resp_wait_en = 0x1;
/* Сдвиг лимита TXOP (txop_apply_limits_regs). */
UCDATA(800504) u32 txop_limit_shift = 0x2;
/* Порог, мкс, от TSF-метки 0x80053c (rx_funcs_rx_flow). */
UCDATA(800518) u32 rx_flow_timeout_us = 0x12c;

/* ---- 0x80057c..0x8006ca ---- */
/* Пороги фоновой задачи BI (background_bi_step). */
UCDATA(80057c) u32 bg_bi_thr_a = 0xc8;
UCDATA(800580) u32 bg_bi_thr_b = 0x3;
/* Маска разрешённых фоновых задач (background_task_dispatch; uc_set_evt_id_5c пишет). */
UCDATA(800584) u32 bg_task_mask = 0xffffffff;
/* Указатель на имя автомата BI; uc_init_cb_801aec копирует его в bi_sm_desc.name. В uc больше никем не читается. */
UCDATA(8005ac) u32 bi_sm_name_ptr = (u32)bi_sm_name;
/* Побитовая маска станций для BF/BRP. */
UCDATA(8005b8) u16 bf_sta_mask = 0xffff;
/* Тень текущего значения IFS/SIFS в MAC (сравнивается с 0x802974; bi_run_bti_cycle ждёт 0x300). */
UCDATA(8005be) u16 mac_ifs_shadow = 0x300;
/* Структура 0x800610: те же значения пишет boot_uc_init_g800610, читателей нет ни у vendor, ни у нас.
 * Смысл не установлен. */
UCDATA(800610) UCD_BYTES(18) g800610_init = {{
    0x06, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0xe8, 0x03, 0x00, 0x00,
    0x1b, 0x24, 0x0f, 0x1e, 0x01, 0x13,
}};
/* Максимальный промежуток, мкс, при склейке busy-интервалов (rx_flow_accumulate_busy_time). */
UCDATA(800640) u8 busy_gap_us = 0xf;
/* Порог АЦП (phy_signal_gain_adc_in_range, база 0x800634 + 0xd). */
UCDATA(800641) u8 adc_gain_thresh = 0x2;
/* Порог времени L1 (×16 из команды 0x4a; читает l1_task_entry). */
UCDATA(800644) u32 l1_time_thresh = 0x3e80;
/* Биты ожидающих фоновых задач, исходно 1 и 5. */
UCDATA(800648) u32 bg_task_pending = 0x22;
/* Порог счётчика структуры фиксированного расписания 0x80064c (+0x18). */
UCDATA(800664) u8 fsched_max_cnt = 0xc8;
/* Структура 0x80066c (BRP RF): +4 разрешение/режим. */
UCDATA(800670) u32 brp_rf_cfg_enable = 0x1;
/* +8: номер RF (config_brp_rf). */
UCDATA(800674) u8 brp_rf_cfg_rf = 0x5;
/* +9: маска RF. */
UCDATA(800675) u8 brp_rf_cfg_mask = 0xff;
/* +0xc: по-секторная настройка BRP (brp_pick_sector_cfg). */
UCDATA(800678) UCD_ARRAY(u8, 8) brp_rf_cfg_sector = {{
    0x60, 0x60, 0x60, 0x60, 0x60, 0x60, 0x60, 0x60,
}};
/* Конфигурация RF-модулей (пишет ucode_cmd_0x01; читают ~20 функций BRP/RF). */
UCDATA(8006b4) struct rf_modules_cfg rf_modules = { .count = 1, .cur = 1, .mask = 1, .x4 = 0, .cur_mask = 1 };
/* Широковещательный MAC ff:ff:ff:ff:ff:ff — подставляется вместо MAC станции
 * (direct_tx_send_with_seq, «вне станции»). */
UCDATA(8006c4) u16 bcast_mac[3] = {
    0xffff, 0xffff, 0xffff,
};

/* ---- 0x800718..0x8008b8 ---- */
/* Разрешение сбора «бодрствующих» станций (aw_worker_collect_awake_peers). */
UCDATA(800718) u32 aw_collect_en = 0x1;
/* Смысл не установлен: статически никто не читает (ни vendor, ни мы). */
UCDATA(800728) u32 g800728 = 0x1;
/* Дескриптор кольца команд 0x800730: +4 — обработчик (uc_init_cb_cmdq кладёт дескриптор в uc_mbox.cmd_desc). */
UCDATA(800734) u32 cmdq_desc_handler = (u32)&ucode_cmdq_handler;
/* Номера AUX-регистров таймеров ARC (uc_timer_start: 0x800738 + 16·n; +0xc — рантайм). */
UCDATA(800738) struct uc_timer_aux uc_timer[2] = {
    { .count = 0x21, .ctrl = 0x22, .limit = 0x23 },     /* COUNT0 / CONTROL0 / LIMIT0 */
    { .count = 0x100, .ctrl = 0x101, .limit = 0x102 },  /* COUNT1 / CONTROL1 / LIMIT1 */
};
/* Дескрипторы строк журнала (0x01000000 + 12·i) — вероятно имена 16 модулей журнала. uc_log_init_ring проверяет
 * только [0] != 0; остальные никем не читаются. */
UCDATA(800778) u32 uc_log_module_tab[16] = {
    0x01000000, 0x0100000c, 0x01000018, 0x01000024,
    0x01000030, 0x0100003c, 0x01000048, 0x01000054,
    0x01000060, 0x0100006c, 0x01000078, 0x01000084,
    0x01000090, 0x0100009c, 0x010000a8, 0x010000b4,
};
/* Init-дескриптор 0x8007c8 {ключ, функция, приоритет}: функция. */
UCDATA(8007cc) u32 init_desc_globals_fn = (u32)&uc_init_cb_globals;
/* Слово конфигурации BRP: биты 15..20 = 10, 24..26 = 5 (brp_pick_sector_cfg, config_brp_rf).
 * +4 (0x800828) пишет uc_init_cb_copy_8006b7. */
UCDATA(800824) u32 brp_ctx_cfg = 0x5850000;
/* Структура 0x80088c: BRP по SNR (пишет ucode_cmd_0x3b). */
UCDATA(80088c) u32 brp_snr_cfg_enable = 0x1;
/* +4: флаги допустимых конфигураций по дельте SNR (биты 6..3). */
UCDATA(800890) u8 brp_snr_cfg_flags = 0x7c;
/* +7..+9: пороги. */
UCDATA(800893) UCD_ARRAY(u8, 3) brp_snr_cfg_thr = {{
    0x06, 0x06, 0x0a,
}};
/* Шаблон BRP-кадра (mac_mode_send_direct_frame: заголовок 10 Б с 0x800898, тело 14 Б с 0x8008b0;
 * поле запроса 0x8008b3..0x8008b6 заполняют brp_*). */
UCDATA(800898) struct brp_frame_tpl brp_frame = {
    .fc = 0x00e0,                       /* Action No Ack */
    .category = 0x14,                   /* Unprotected DMG */
    .action = 1,                        /* BRP */
    .elem_id = 0x99,                    /* вероятно ID следующего элемента */
};

/* ---- 0x800fc0..0x801025 ---- */
/* Линейное -> дБ в единицах 1/8 дБ: T[n] = round(80·log10 n), n = 0..31 (brp_select_cfg_by_snr). */
UCDATA(800fc0) UCD_ARRAY(u8, 32) lin_to_db8_32 = {{
    0x00, 0x00, 0x18, 0x26, 0x30, 0x38, 0x3e, 0x44, 0x48, 0x4c, 0x50, 0x53, 0x56, 0x59, 0x5c, 0x5e,
    0x60, 0x62, 0x64, 0x66, 0x68, 0x6a, 0x6b, 0x6d, 0x6e, 0x70, 0x71, 0x73, 0x74, 0x75, 0x76, 0x77,
}};
/* Init-дескриптор 0x800fe0: функция (копия маски RF 0x8006b7 -> 0x800828). */
UCDATA(800fe4) u32 init_desc_copy_8006b7_fn = (u32)&uc_init_cb_copy_8006b7;
/* Дескриптор BF-запроса по умолчанию (bf_init_sm, bf_reset_sta_slot, bf_abort_unexpected -> bf_req_enqueue).
 * +8 и +0x10 никем не читаются статически. */
UCDATA(800fec) struct bf_req_desc bf_req_desc_default = {
    .done_cb = (u32)&notify_aoa_build,
    .x8 = 1,
    .x10 = 1,
};
/* Минимум (старт 0xff) в снимке параметров PHY 0x801014 + 0xc (phy_params_snapshot). */
UCDATA(801020) u8 phy_snap_min = 0xff;
/* Текущее слово RF-цепей/сектора: биты 8..22 — сектор (mac_set_rf_chain_state; ~25 функций). */
UCDATA(801024) u32 rf_chain_word = 0x10;

/* ---- 0x8013ec..0x8014fd ---- */
/* Init-дескриптор 0x8013e8: функция (регистрация дескриптора очереди команд). */
UCDATA(8013ec) u32 init_desc_cmdq_fn = (u32)&uc_init_cb_cmdq;
/* Флаги режима RX (биты 0, 1; пишет rx_mode_configure). */
UCDATA(801424) u32 rx_mode_flags = 0x3;
/* Структура 0x80146c (NAV/события): маска событий текущая и сохранённая. */
UCDATA(801474) u32 rx_nav_ev_mask[2] = { 0xffffffff, 0xffffffff };
/* Разрешение NAV-флагов (rx_nav_arm_flag_if_enabled). */
UCDATA(801482) u16 rx_nav_enable = 0x1;
/* Предел/запас NAV, мкс (rx_nav_set_from_duration, bi_remaining_time_us). */
UCDATA(801484) u16 rx_nav_max_us = 0x1388;
/* Смысл не установлен, статически никто не читает (+8 = 0x801494 пишет ucode_cmd_selective_neighbor_cfg). */
UCDATA(80148c) u32 g80148c = 0x1388;
/* Смысл не установлен, статически никто не читает. */
UCDATA(801490) u32 g801490 = 0x1;
/* Смысл не установлен, статически никто не читает. */
UCDATA(801495) u8 g801495 = 0x9;
/* Флаги конфигурации TX/RX (проверяется бит 9; исходно бит 10). */
UCDATA(8014a0) u32 txrx_cfg_flags = 0x400;
/* PM-структура 0x8014a4 + 0x18, бит 0 (mac_mode_enter_idle_seq). */
UCDATA(8014bc) u32 pm_idle_flags = 0x1;
/* Маска шагов последовательности питания RF (rf_power_seq_and_save). */
UCDATA(8014d8) u32 rf_power_seq_mask = 0x9;
/* Структура 0x8014e8 «избирательный сосед» / слежение за уровнем: +1 = 0x7f минимум уровня, +2 = 0xff индекс,
 * +7 = 0x50, +8 = 5, +0xb = 0x2d, +0xd = 0x10, +0xe = 5, +0xf = 0x14, +0x10 = 1, +0x12 = 6, +0x13/+0x14 = 0x7f.
 * Смысл полей не установлен. */
UCDATA(8014e9) UCD_BYTES(20) sel_nbr_init = {{
    0x7f, 0xff, 0x00, 0x00, 0x00, 0x00, 0x50, 0x05, 0x00, 0x00, 0x2d, 0x00,
    0x10, 0x05, 0x14, 0x01, 0x00, 0x06, 0x7f, 0x7f,
}};

/* ---- 0x80150e..0x801694 ---- */
/* Опорное усиление (brp_rf_store_cfg, 0x801504 + 0xa). */
UCDATA(80150e) s16 brp_rf_gain_ref = 0x64;
/* Линейное -> дБ, 1/8 дБ, 48 записей (brp_rf_store_cfg). */
UCDATA(80152c) UCD_ARRAY(u8, 48) lin_to_db8_48 = {{
    0x00, 0x00, 0x18, 0x26, 0x30, 0x38, 0x3e, 0x44, 0x48, 0x4c, 0x50, 0x53, 0x56, 0x59, 0x5c, 0x5e,
    0x60, 0x62, 0x64, 0x66, 0x68, 0x6a, 0x6b, 0x6d, 0x6e, 0x70, 0x71, 0x73, 0x74, 0x75, 0x76, 0x77,
    0x78, 0x79, 0x7b, 0x7c, 0x7d, 0x7d, 0x7e, 0x7f, 0x80, 0x81, 0x82, 0x83, 0x83, 0x84, 0x85, 0x86,
}};
/* Смысл не установлен, статически никто не читает (u16 0,10,..,80,1000; байты 4 3 2 1 0 ff..).
 * Внимание: 0x80156c — база mac_publish_masks, но читаются только [4..7] = 0x80157c..0x801588. */
UCDATA(80155c) UCD_BYTES(32) g80155c = {{
    0x00, 0x00, 0x0a, 0x00, 0x14, 0x00, 0x1e, 0x00, 0x28, 0x00, 0x32, 0x00,
    0x3c, 0x00, 0x46, 0x00, 0x50, 0x00, 0xe8, 0x03, 0x04, 0x03, 0x02, 0x01,
    0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
}};
/* mac_publish_masks: маска [7] для 0x886d8c + 7·4 ([4..6] заполняет код). */
UCDATA(801588) u32 mac_pub_mask7 = 0x80000000;
/* Тайминги TXSS/SSW (структура 0x80158c: +0xc, +0x10 не читается, +0x14). */
UCDATA(801598) u32 txss_timing_base = 0xf;
/* Статически никто не читает. */
UCDATA(80159c) u32 txss_timing_x10 = 0x11;
UCDATA(8015a0) u32 txss_timing_add = 0x11;
/* Включение слотов очередей (таблица 0x8015a4 + 0x10). */
UCDATA(8015b4) u32 qset_slots_en = 0x1;
/* Имена состояний и событий автомата BI (bi_sm_desc.state_names/event_names). В uc никем не читаются —
 * отладочные, для внешних дампов. */
UCDATA(8015b8) u32 bi_state_names[4] = {
    (u32)bi_state_name_bti, (u32)bi_state_name_abft, (u32)bi_state_name_dti, (u32)bi_state_name_aw,
};
UCDATA(8015c8) u32 bi_event_names[5] = {
    (u32)bi_event_name_dti_to_bti, (u32)bi_event_name_bti_to_abft, (u32)bi_event_name_bhi_to_dti,
    (u32)bi_event_name_bhi_to_aw, (u32)bi_event_name_aw_to_dti,
};
/* Таблица автомата BI: 5 событий × 4 состояния, {действие, следующее состояние} (uc_sm_handle_event через bi_sm_desc). */
UCDATA(8015dc) struct bi_sm_entry bi_sm_table[20] = {
    { (u32)&bi_sm_action_935b4c, 0 },   /* событие 0 */
    { (u32)&bi_sm_action_92646c, 1 },
    { (u32)&bi_sm_action_935b4c, 0 },
    { (u32)&bi_sm_action_92156c, 3 },
    { (u32)&bi_sm_action_935a08, 1 },   /* событие 1 */
    { (u32)&bi_sm_action_92646c, 1 },
    { (u32)&bi_sm_action_9262e8, 2 },
    { (u32)&bi_sm_action_92646c, 3 },
    { (u32)&bi_sm_action_935d0c, 2 },   /* событие 2 */
    { (u32)&bi_sm_action_935d0c, 2 },
    { (u32)&bi_sm_action_9262e8, 2 },
    { (u32)&bi_sm_action_92153c, 3 },
    { (u32)&bi_sm_action_935a94, 3 },   /* событие 3 */
    { (u32)&bi_sm_action_935a94, 3 },
    { (u32)&bi_sm_action_9262e8, 2 },
    { (u32)&bi_sm_action_92150c, 3 },
    { (u32)&bi_sm_action_923a5c, 0 },   /* событие 4 */
    { (u32)&bi_sm_action_92646c, 1 },
    { (u32)&bi_sm_action_9262e8, 2 },
    { (u32)&bi_sm_action_935d0c, 2 },
};
/* Init-дескриптор 0x801640: функция (копия bi_sm_name_ptr -> bi_sm_desc.name).
 * Внимание: 0x801644 = «база −8» таблицы ssw_tab_a (см. ниже) — индекс < 4 до чтения не доходит. */
UCDATA(801644) u32 init_desc_801aec_fn = (u32)&uc_init_cb_801aec;
/* Три перекрывающиеся по использованию u16-таблицы по 4-битному коду (индексы 4..15, база «−8»):
 * A — abft_ssw_prep_sw (Duration SSW в A-BFT); B — ucode_cmd_0x0b_handler (0x80165c[r] = A[8+r], 0x801674[r] = B[8+r]);
 * C — abft_arm_response_window, bti_arm_period_gp0, bf_gpc_program_mac_by_mode_b. Переставлять по отдельности нельзя. */
UCDATA(80164c) u16 ssw_tab_a[12] = {
    0x004f, 0x005f, 0x006f, 0x007f, 0x008f, 0x009e, 0x00ae, 0x00be,
    0x00ce, 0x00de, 0x00ee, 0x00fe,
};
UCDATA(801664) u16 ssw_tab_b[12] = {
    0x329b, 0x3cdb, 0x471b, 0x515b, 0x5b9b, 0x65db, 0x701b, 0x7a5b,
    0x849b, 0x8edb, 0x991b, 0xa35b,
};
/* period_tab — конец слота A-BFT в тактах по FSS (4..15): aSSSlotTime (802.11-2020 10.42.5.2) =
 * aAirPropagationTime (100 нс) + aSSDuration (FSS × (TXTIME(SSW) + SBIFS) = ssw_tab_b) + MBIFS +
 * aSSFBDuration (TXTIME(SSW-Feedback) = 18,25 мкс) + MBIFS = ssw_tab_b + 5998 тактов. Vendor 6.2
 * держал + 9281 (на 3283 такта ≈ 20 мкс за концом слота: 0x56dc, 0x611c, …); исправление — как в
 * 6.4 (патч 0003-uc-abft-slot-end-per-standard). */
UCDATA(80167c) u16 period_tab[12] = {
    0x4a09, 0x5449, 0x5e89, 0x68c9, 0x7309, 0x7d49, 0x8789, 0x91c9,
    0x9c09, 0xa649, 0xb089, 0xbac9,
};

/* ---- 0x8016e4..0x801be8 ---- */
/* Init-дескриптор 0x8016e0: функция (boot_uc_init_more(&rx_meas)). */
UCDATA(8016e4) u32 init_desc_more_fn = (u32)&uc_init_cb_more;
/* Смысл не установлен, статически никто не читает (0x228, 0x00ffffff, затем пары u16 — похоже на
 * таблицу пар значение/адрес регистра). */
UCDATA(80170c) UCD_BYTES(128) g80170c = {{
    0x28, 0x02, 0x00, 0x00, 0xff, 0xff, 0xff, 0x00, 0x06, 0x00, 0x88, 0x01,
    0x0b, 0x01, 0x88, 0x00, 0x06, 0x00, 0x08, 0x00, 0x0b, 0x01, 0x88, 0x00,
    0x06, 0x00, 0xa8, 0x00, 0x06, 0x00, 0xa0, 0x00, 0x06, 0x00, 0xa8, 0x00,
    0x0c, 0x00, 0x88, 0x00, 0xf2, 0x00, 0x98, 0x00, 0xd7, 0x02, 0x9a, 0x00,
    0xca, 0x03, 0x92, 0x00, 0xe5, 0x01, 0x9a, 0x00, 0xd7, 0x02, 0x98, 0x00,
    0x18, 0x00, 0x88, 0x00, 0x06, 0x00, 0x88, 0x01, 0x01, 0x00, 0x88, 0x01,
    0x01, 0x00, 0x88, 0x01, 0x01, 0x00, 0x88, 0x01, 0x01, 0x00, 0x88, 0x01,
    0x01, 0x00, 0x88, 0x01, 0x06, 0x00, 0x06, 0x00, 0xff, 0x00, 0x02, 0x00,
    0x06, 0x00, 0x00, 0x00, 0xff, 0x00, 0x02, 0x00, 0x30, 0x00, 0x03, 0x00,
    0x1e, 0x00, 0x02, 0x00, 0x06, 0x00, 0x06, 0x00, 0x01, 0x00, 0x06, 0x00,
    0x01, 0x00, 0x06, 0x00, 0x01, 0x00, 0x06, 0x00,
}};
/* По-MCS значение для 0x886c70[15:0] (mac_set_cid_mcs_uc). */
UCDATA(80178c) u16 mcs_tab_886c70[14] = {
    0x0001, 0x0020, 0x0020, 0x0020, 0x0020, 0x0020, 0x008c,
    0x008c, 0x00c8, 0x00c8, 0x012c, 0x03e8, 0x03e8, 0x0000,
};
/* По-MCS значение для 0x886c74 (mac_set_cid_mcs_uc). */
UCDATA(8017a8) UCD_ARRAY(u8, 13) mcs_tab_886c74 = {{
    0x00, 0x50, 0x50, 0x50, 0x50, 0x50, 0x40, 0x40, 0x40, 0x48, 0x48, 0x50, 0x50,
}};
/* Узор 05 09 45 0e (повторён трижды перед бывшими таблицами переходов vendor); статически никто не читает. */
UCDATA(8017d1) UCD_BYTES(4) g8017d1 = {{
    0x05, 0x09, 0x45, 0x0e,
}};
/* Узор 05 09 45 0e (повторён трижды перед бывшими таблицами переходов vendor); статически никто не читает. */
UCDATA(8019d5) UCD_BYTES(4) g8019d5 = {{
    0x05, 0x09, 0x45, 0x0e,
}};
/* Узор 05 09 45 0e (повторён трижды перед бывшими таблицами переходов vendor); статически никто не читает. */
UCDATA(801a85) UCD_BYTES(4) g801a85 = {{
    0x05, 0x09, 0x45, 0x0e,
}};
/* Шаблон 16-байтового буфера RF-команды (rf_utils_auto_fill_with_byte; байт [0] заменяется). */
UCDATA(801820) u32 rf_fill_template[4] = {
    0x5f400100, 0x00000000, 0x00000000, 0x0000003f,
};
/* дБ -> линейно: round(10^(i/10)), i = 0..63 (rx_flow_measure_snr_select_best). */
UCDATA(80183c) u32 db_to_lin_tab[64] = {
    1, 1, 2, 2, 3, 3, 4, 5,
    6, 8, 10, 13, 16, 20, 25, 32,
    40, 50, 63, 79, 100, 126, 158, 200,
    251, 316, 398, 501, 631, 794, 1000, 1259,
    1585, 1995, 2512, 3162, 3981, 5012, 6310, 7943,
    10000, 12589, 15849, 19953, 25119, 31623, 39811, 50119,
    63096, 79433, 100000, 125893, 158489, 199526, 251189, 316228,
    398107, 501187, 630957, 794328, 1000000, 1258925, 1584893, 1995262,
};
/* Дескриптор автомата BI (basic_sm_bind_descriptor_uc, uc_sm_handle_event: +1, +2, +4). */
UCDATA(801adc) struct sm_desc bi_sm_desc = {
    .n_events = 5,
    .n_states = 4,
    .init_state = 2,                    /* DTI */
    .table = (u32)bi_sm_table,
    .state_names = (u32)bi_state_names,
    .event_names = (u32)bi_event_names,
    .name = 0,                          /* uc_init_cb_801aec копирует bi_sm_name_ptr */
};
UCDATA(801af0) char bi_state_name_bti[13] = "BI_STATE_BTI";
UCDATA(801b00) char bi_state_name_abft[14] = "BI_STATE_ABFT";
UCDATA(801b10) char bi_state_name_dti[13] = "BI_STATE_DTI";
UCDATA(801b20) char bi_state_name_aw[12] = "BI_STATE_AW";
UCDATA(801b2c) char bi_event_name_dti_to_bti[20] = "BI_EVENT_DTI_TO_BTI";
UCDATA(801b40) char bi_event_name_bti_to_abft[21] = "BI_EVENT_BTI_TO_ABFT";
UCDATA(801b58) char bi_event_name_bhi_to_dti[20] = "BI_EVENT_BHI_TO_DTI";
UCDATA(801b6c) char bi_event_name_bhi_to_aw[19] = "BI_EVENT_BHI_TO_AW";
UCDATA(801b80) char bi_event_name_aw_to_dti[19] = "BI_EVENT_AW_TO_DTI";
UCDATA(801b94) char bi_sm_name[17] = "BI_AP_MONITOR_SM";
