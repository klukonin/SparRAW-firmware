# Подсистемы микрокода (ucode) 6.2 — справочник

Каталог блоков сегмента uc 6.2.0.1000, не относящихся к тематическим документам: вспомогательные
блоки группы команд, DTI-аллокации ESE в ucode, блоки MAC-ядра и регистров, каталог мелких
блоков, соответствие имён блоков в файлах данных `ref/`.

Механизмы, общие для 4.1 и 6.2, описаны в корневых документах с адресами обеих версий:
команды прошивка→ucode и события (таблица 6.2) — [LMAC-PROTOCOL §2.2, §5](../../docs/LMAC-PROTOCOL.md);
вектора, загрузка, подъём DMA/PHY/РЧ, аварийный путь, события L1 по r54 и каркас L1 —
[UCODE-TASKS §2, §4](../../docs/UCODE-TASKS.md); автомат BI, окна BTI/AW, отчёт MAC_MON —
[BEACONING](../../docs/BEACONING.md); BF/BRP/TXSS, rate search, таблица развёртки TXSS —
[BF-ENGINE §8.5, §11, §12](../../docs/BF-ENGINE.md); internal/direct TX, RX-поток, очереди и
QH — [DATAPATH §3.6](../../docs/DATAPATH.md); фиксированное расписание —
[FIXED-SCHED](FIXED-SCHED.md). Команды MAC-ядра — [MAC-COMMANDS](../../docs/MAC-COMMANDS.md);
автоматы — [STATE-MACHINES](../../docs/STATE-MACHINES.md); fw — [MISC-FW](MISC-FW.md).

Метки доказанности: **[железо]** — проверено на стенде, **[код]** — прочитан
листинг, **[стр]** — по собственной строке блока, **[выз]** — по соседям,
**[пак]** — по вендорским именам пака 11ad, **[гипотеза]** — не проверено.

**Чтение листингов.** Инструкции вида `mov_s r32,rX ; st.ab rX,[r25,4] ; … ;
st r40,[…]` — запись команды в кольцо MAC-ядра и чтение ответа (интерфейс
core write и PMC, [MAC-COMMANDS](../../docs/MAC-COMMANDS.md)); в именах блоков
они дают `mac_cmd_0xNN`.

## 1. Команды прошивка → ucode

Таблица команд 6.2 (код, отправитель fw, обработчик ucode, назначение) и отправители событий
ucode→fw — [LMAC-PROTOCOL §2.2, §5.3](../../docs/LMAC-PROTOCOL.md#22-сводная-таблица-62).

Прочее группы: `ps__hold_awake_for_sta` 0x93d914 (захват ресурса и проверка
простоя internal TX — общий для 0x24/0x33/0x34), `ucode_pm__set_busy_flag`
0x93c874, `uc__set_evt_id_5c` 0x921724, `mac__set_chain_mask_924f00`,
`peer__lookup_if_fixed_sched` 0x926890 / `sched_cfg__merge_update` 0x9268c0 (QH
по пиру), `phy_stats__clear_counters_883960` 0x929cec,
`ss__update_frames_number` (число кадров sector sweep), `ss__copy_cfg_from_cmd`.

Метки трассы PMC: `sends_pmc_mark_aaab20` 0x92eb94 и `sends_pmc_mark_aaab02`
0x93cc40 — core write с битом 31 (событие PMC).

## 2. L1: DTI-аллокации ESE

События L1 по битам r54 и каркас L1 — [UCODE-TASKS §2](../../docs/UCODE-TASKS.md#2-главный-цикл-l1-62);
фиксированное расписание — [FIXED-SCHED](FIXED-SCHED.md); потеря связи из ucode —
[UCODE-TASKS §2.1](../../docs/UCODE-TASKS.md#21-путь-связь-потеряна-из-ucode-код--железо);
MAC_MONITOR и блоки BI/AW/BTI — [BEACONING §6, §8](../../docs/BEACONING.md); ESE —
[ESE](../../docs/ESE.md).

* **DTI-аллокации (ESE):** `dti_worker__scheduled_dti_allocation_event`
  0x934854 — «starting slot id=%d at tsf_low» / «closing slot»; сообщает fw
  `PS_AWAKE_PEER` (`uc_send_evt__ps_awake_peer` 0x92757c) и событие через
  `uc_evt__send_29_sync`; хвост `dti_alloc__scheduled_event_thunk` 0x92b794.

## 3. MAC-ядро и регистры

**Имена блоков.** `mac_cmd_0xNN_*` — блок, выдающий команду MAC-ядра с кодом
NN (код — железо, одинаков в 4.1 и 6.2; смысл — [MAC-COMMANDS](../../docs/MAC-COMMANDS.md),
данные `4.1/ref/MAC-CMD-MAP.txt`: 0x02 — маска ожидаемых событий, 0x0f — поиск
набора очередей, 0x14/0x1b — маячный/передающий тракт, 0x1f — режим
РЧ-тракта, 0x29 — передача кадра сектора, 0x33 — этап прямой передачи, 0x38 —
режим покоя/нагрузки, 0x3d — A-BFT/BRP, 0x49 — квитирование битов r54).
`macreg_rNN_*` — блок, читающий MAC-регистр rNN (имена полей —
[MSXD-LR-RGF.txt](../ref/MSXD-LR-RGF.txt): r40–r56). `rgf_*`, `uses_rgf_*` —
работа с окном регистров по адресу из имени.

Очереди, vring и QH — [DATAPATH §3.6](../../docs/DATAPATH.md#36-справочник-блоков-передачи-и-приёма-микрокода-62);
подъём DMA, РЧ и PHY — [UCODE-TASKS §4.2](../../docs/UCODE-TASKS.md#42-загрузка-62).

* **Команды MAC-ядра:** `mac_prog__cmd02_body` 0x921460, `bti__count_sweep_round` 0x9222e0, `rx__arm_window` 0x9228d4, `brp_init__exchange_request` 0x922928, `rx__arm_window_b` 0x923280, `tx__await_rx_or_timeout` 0x924c78, `tx__cca_check_and_send` 0x924d00, `mac__program_4f_52` 0x924d8c, `mac__set_slot_mask_924000` 0x9267d4, `sls__rx_ssw_frame` 0x928520, `brp_init__reset_ctx` 0x92afb8, `fsched_ap__start_slot` 0x92b3bc, `mac_ifs__restore_sifs` 0x92bfc0, `rx__arm_window_c` 0x92c568, `mac__rf_switch_cmd1f` 0x92c5e4, `macq__probe_empty` 0x92dab8, `rx__ppdu_is_ack` 0x92e260, `rx__ppdu_is_ack_b` 0x92e2bc, `rx__ppdu_is_cts` 0x92e318, `rx__ppdu_is_cts_b` 0x92e388, `rx__ppdu_is_cts_c` 0x92e3e0, `mac__cmd_0f_step` 0x92e438, `mac_mode__send_direct_frame` 0x92e978, `mac__replicate_bit_mask` 0x92f400, `rx_mode__configure` 0x92f4bc, `mac__build_qset_mask` 0x92f738, `abft_resp__parse_fdbk` 0x93061c, `gp_timer__set_value` 0x935080, `rx__send_dmg_cts` 0x936320, `mac__read_bi_start_tsf64_uc` 0x9374e8, `mac__rx_off_seq` 0x93759c, `mac_mode__enter_idle_seq` 0x9375cc, `direct_tx__send_with_seq` 0x9382b0, `tx_fifo__push_frame_3ies` 0x938358, `txss_init__send_fdbk_wait_ack` 0x93b9c0, `txss_resp__wait_iss_end` 0x93bf1c, `mac__program_13ab6680` 0x93c8e0, `mac__program_13ab6680_b` 0x93c904, `fsched_ap__poll_station` 0x93d1ec, `itx__wait_ack` 0x93dbb0, `itx__wait_cts` 0x93df4c, `itx__wait_cts_b` 0x93dfb0, `mac__arm_events_0xc00` 0x93e084, `mac__set_mode_0000` 0x93e0dc.
* **Чтение регистров MAC:** `brp_init__tx_request` 0x9229c0, `macq__is_idle` 0x92609c, `rx_meas__capture_frame` 0x927f6c, `rx_meas__append_sample` 0x928854, `rfca__select_rf_uc` 0x928b8c, `fsched__pick_ready_queue` 0x92be90, `rx_nav__set_from_duration` 0x92dd30, `rf__select_sector_cmd41` 0x92f934, `rf__write_sector_awv` 0x92fa6c, `rx_resp__finish_restore_rx` 0x9336d8, `sls__send_ssw_ack` 0x934424, `mac__set_chain_modes` 0x9369e0, `fsched__pick_queue_r41` 0x9397f0, `txss_init__send_ssw_fdbk` 0x93c0d4, `rx__enter_listen_mode` 0x93c818.
* **Окна регистров:** `mac_q__tx_ppdu_3009` 0x921760, `qh__write_desc_window` 0x924348, `qh__read_desc_window` 0x92449c, `macq_desc__read_uc` 0x9245b0, `macq_desc__write_uc` 0x92462c, `macq__kick_queue_tx` 0x925a48, `macq__flush_queue` 0x925b7c, `rx_meas__finish_with_8830ec` 0x92893c, `abif__set_enable_bit` 0x928b4c, `rfca__get_rf_mask_uc` 0x928c68, `hwd_abif__rfc_divider_restart_uc` 0x928c78, `abif__set_88a204_field` 0x928cd8, `mac__set_880bf0_mode` 0x928d78, `mac__set_880afc_bits` 0x928dcc, `dma__write_881c28` 0x928dfc, `dma__read_881c28` 0x928fa8, `txop__clear_dma_ctl_bit1` 0x92930c, `mac__fill_mode_nibbles` 0x9294d8, `mac__set_cid_mcs_uc` 0x929568, `uc_sysassert__read_hw_state3` 0x929ae4, `phy__read_signal_gain_adc_db` 0x929b74, `phy__set_88306c_field` 0x929cac, `tof__set_tx_rx_offset_regs` 0x929d10, `abif__save_override_restore` 0x929d20, `phy__read_regs_883844` 0x929ea8, `rfc__restore_txrx_sets` 0x92a014, `rfc__read_core_result` 0x92a2a4, `rf__set_txrx_sets_save` 0x92a314, `rfc__write_core_checked` 0x92a5f8, `rf__set_normal_mode` 0x92abe4, `internal_tx__set_pending_flag` 0x92bbd8, `uc_log__init_ring` 0x92d0a0, `txq__fifo_ptp_idle_snapshot` 0x92e8a8, `tx__program_vector_rf` 0x9302d8, `fsched__tx_ctrl_frame` 0x934b14, `pmc__stop_recording` 0x936134, `mac_clk__div165` 0x936b94, `rng__rand_below` 0x936de0, `bti__measure_frame_duration` 0x937cf0, `tx__send_imm_response` 0x9385d8, `itx__tx_frame_3ies` 0x938a88, `mac_q__tx_ppdu` 0x939888, `txss__sweep_timing` 0x939cc4, `mac_q__tx_ppdu_cmd08` 0x93a6d8, `mac__set_slot_timing_886f60` 0x93b40c, `txss_resp__wait_fdbk` 0x93be68, `txss_resp__flow` 0x93bff0, `rf__power_seq_and_save` 0x93c888.
* **Прочие связки MAC:** `qh__wait_desc_window_ready` 0x924480, `qh__reset_desc_window` 0x9246b0, `sta__apply_rx_sector_and_mcs` 0x926960, `fixed_sched__slot_cfg_u16_2` 0x927d94, `mac__core_write_3e_then_3d_0007` 0x9295f4, `mac__core_write_3d_0200` 0x92960c, `l1__enter_fixed_sched` 0x92c7ec, `l2_handle_watchdog` 0x92cf90, `pm__event_mask_restore` 0x92dcd8, `rfca__access_sector_other_rf` 0x92e0a8, `bf__store_flow_status` 0x9357cc, `direct_tx__send_ctrl_frame` 0x9362b8, `uc_timer__start` 0x937354, `bf_sm__on_txss_init` 0x93b8d0, `bf_sm__on_txss_resp` 0x93be28, `sta__set_tx_sector` 0x93d180 — среди них
  `l2_handle_watchdog` 0x92cf90 («*** l2_handle_watchdog ilink1 ilink2» —
  сторожевой таймер L2), `uc_timer__start` 0x937354, `pm__event_mask_restore`
  0x92dcd8, `bf_sm__on_txss_init/on_txss_resp` (ветки разбора принятого кадра
  по состоянию BF STA, §4.1).

## 4. Каталог мелких блоков

Роль — по соседям **[выз]**; тела не читались.

* Обработчики команд-измерений (§1, группы 0x28 и 0x29): `ucode_cmd_0x3c_handler` 0x924dcc, `ucode_cmd_0x3d_handler` 0x924e0c, `sched_cfg__merge_update` 0x9268c0, `ucode_cmd_0x2e_handler` 0x92811c, `ucode_cmd_0x2f_handler` 0x928168, `ucode_cmd_0x37_handler` 0x92e47c, `ucode_cmd_0x38_handler` 0x92e4b4, `ucode_cmd_0x28_handler` 0x935d90, `ucode_cmd_0x2a_handler` 0x935de4, `ucode_cmd_0x29_handler` 0x936014, `ucode_cmd_0x2b_handler` 0x9360a4.
* Расписание и BI: `bi_sm__action_92153c` 0x92153c, `bi_sm__action_92156c` 0x92156c, `bi_sm__action_923a5c` 0x923a5c, `bi_sm__action_9262e8` 0x9262e8, `l1_task__mask_wake_req_and_defer` 0x9274f4, `fixed_sched__slot_word8` 0x927d78, `fsched__slot_byte0` 0x927dc8, `l1__rx_then_check_bf_abort` 0x92b6ac, `fsched_ap__station_done` 0x92bddc, `power_mngr__stats_mark_base` 0x92e704, `fsched_ap__copy_slot_byte1` 0x92ec28, `fsched__arm_slot_from_cfg` 0x935a6c, `fsched__run_tx_slot_twice` 0x938a18.
* BF и битовые поля: `bf_sm__brp_resp_result` 0x922e74, `uc_evt__send_21` 0x9278c8, `brp__parse_request_fields` 0x92e1e4, `bf_sm__txss_init_result` 0x93b840, `bf_sm__txss_resp_result` 0x93bdf0, `bits__set_u8_s0_w5_uc` 0x93e348, `bits__set_u8_s0_w6_uc` 0x93e354, `bits__set_u8_s0_w7_uc` 0x93e360, `bits__set_u8_s3_w5_uc` 0x93e36c, `bits__set_u8_s6_w2_uc` 0x93e378, `rx_mode__bits_uc_set32_s0_w4` 0x93e39c, `frame_hdr__bits_uc_set32_s0_w7` 0x93e3a8, `frame_hdr__bits_uc_set32_s15_w8` 0x93e3b4, `brp__bits_uc_set32_s1_w8` 0x93e3c0, `frame_hdr__bits_uc_set32_s23_w9` 0x93e3cc, `sls__bits_uc_set32_s2_w2` 0x93e3d8, `bits__uc_set32_s4_w3` 0x93e3e4, `bits__uc_set32_s4_w4` 0x93e3f0, `brp__bits_uc_set32_s4_w5` 0x93e3fc, `frame_hdr__bits_uc_set32_s7_w8` 0x93e408, `bits__uc_set32_s8_w15` 0x93e414.
* TX: `mtp_queue__byte_by_index` 0x92ff68, `mac_evt__enable_bit_sync_b` 0x936544, `itx__wait_cts_rf` 0x93dfec.
* Вектора: `uc_vector_16` 0x9207a4, `uc_vector_17` 0x9207a8.
* Разное: `timer_list__init` 0x9209e0, `uc_restore_status32` 0x9215c4, `sta__find_by_byte` 0x9267ac, `phy_stats__clear_counters_88395c` 0x929cf8, `peer__lookup_or_ff` 0x92be64, `timer_list__insert_sorted` 0x92e788, `sta_link__byte_by_index` 0x9300c0, `traffic_deferral__clear_node` 0x935644, `mac__read_usec_to_tbtt_uc` 0x937550, `ucode_pm__stamp_tsf_slots` 0x93c7a8 — `uc_restore_status32` (восстановление STATUS32 после
  критической секции), `peer__lookup_or_ff` (индекс пира или 0xff),
  `traffic_deferral__clear_node`, `ucode_pm__stamp_tsf_slots`.
* Аксессоры, хвосты, заглушки: `cpu__aux28_set_bits12` 0x9202f4, `uc_divmod_unsigned` 0x9203e0, `uc_divmod_signed` 0x9203e8, `field_set_0x00__920cd4` 0x920cd4, `uc_list__head_field4` 0x920da4, `uc_field_0x24_is_zero` 0x920dac, `field_rw_0x178__920ef4` 0x920ef4, `uc_ap__read_triggered_mask` 0x920f9c, `uc_ap__read_match_value` 0x920fa8, `brp_rf__store_module_byte` 0x9213c0, `bf_sm__clear_slot_diag` 0x9218f4, `peer_masks__or_sta_bit_into_8571c4` 0x921c34, `rf__update_active_antenna` 0x9238cc, `fsched_slot__clear_f3` 0x924f94, `fsched_slot__clear_f4` 0x924fa4, `field_rw_0x2c__924fb4` 0x924fb4, `bg_task__call_cb20` 0x925040, `mask__bit_from_index_plus8` 0x9262a0, `aw__walk_peer_bits_noop` 0x9263b8, `bits__clear_msb_loop_tail` 0x9263c8, `evt_queue__noop_lock_hook` 0x926a38, `bf__abort_noop_hook` 0x926ab0, `uc_evt_queue__peek_field04` 0x927320, `uc_evt__send_22` 0x9275ec, `uc_evt__send_2c_tsf` 0x927700, `uc_evt__send_30` 0x927784, `uc_evt__send_23` 0x92787c, `bi_cfg__get_half10` 0x927d04, `fsched__get_cur_idx` 0x927d54, `fsched__cur_entry_byte1` 0x927db0, `uc_queue__peek_head_word1` 0x927f64, `popcount8` 0x92828c, `rss_wait__get` 0x9282a8, `gp0__arm_usec` 0x928318, `gp0__arm_usec_c` 0x9283e0, `bit_iter__has_more_uc` 0x928aac, `macq_hw__clear_2d8` 0x928f78, `macq_hw__trigger_read_state` 0x928fcc, `macq_hw__read_state1` 0x929044, `macq_hw__read_wptr` 0x929068, `macq_hw__read_rptr` 0x929088, `dmaq_hw__read_ptr` 0x9290a8, `macq__read_hw_queue_word` 0x9290bc, `macq_hw__disable_queue` 0x9292a8, `ppdu__unpack_desc_word` 0x9297ac, `macq_hw__commit_rptr` 0x92a640, `macq_hw__sync_dma_wptr` 0x92a69c, `uc_mailbox__ring_reg_addr` 0x92a6dc, `buf__check_bounds` 0x92ac80, `fsched_slot__inc_f2` 0x92accc, `fsched_slot__inc_f4_reached_7` 0x92acdc, `bi_sm__init` 0x92acf8, `bi_ctx__clear_word0` 0x92adec, `obj_vt801adc__ctor` 0x92aeb4, `bti__clear_cid_sweep_counters` 0x92b184, `g_80212c__reset` 0x92b1d8, `bi__dispatch_by_role` 0x92b448, `internal_tx__clear_exclude_mask` 0x92ba48, `fixed_sched__is_engaged` 0x92bda4, `fsched_slot__f3_positive` 0x92be0c, `uc_indirect_is_zero` 0x92be20, `fsched__test_mask2c_bit` 0x92be4c, `bti__r54_event_bit6` 0x92bf2c, `bit_scan_msb` 0x92d034, `rx_nav__clear_flags` 0x92dc1c, `rx_nav__set_flag_b1_if_enabled` 0x92dcbc, `field_set_0x00__92ebe0` 0x92ebe0, `field_rw_0x29__92ebec` 0x92ebec, `bf_txss__reset_report_ctx` 0x92ebfc, `fsched_slot__clear_f2` 0x92ec18, `sls__clear_rx_state` 0x92ed50, `mac_cfg__set_gp20_default_15748` 0x92f4b0, `rs__is_sta_enabled` 0x9300ac, `bti__clear_sweep_counters` 0x930dc8, `field_set_0x00__934998` 0x934998, `field_set_0x00__934b8c` 0x934b8c, `field_rw_0x2c__9351f8` 0x9351f8, `bf_sm__brp_noop_hook_a` 0x935208, `mac__set_rf_chain_state__with_sta_sector` 0x935928, `bf_req__try_claim` 0x936184, `mac__wait_event_r42_or_r40` 0x93675c, `tof__store_tx_rx_offset` 0x937420, `internal_tx__noop_isr_hook` 0x93783c, `ucode_cmd08__noop_hook` 0x937840, `bi_cfg__pack_words_thunk` 0x938000, `bi_cfg__pack_words_78_7c` 0x938004, `bi_mode__init_sta_table` 0x93b908, `rx_listen__set_flag_and_stamp_tsf` 0x93c864, `bf_sm__brp_noop_hook_b` 0x93cc8c, `ucode_cmd_0x24__copy_byte_164` 0x93dac0, `txop__pick_ctrl_code_by_peer` 0x93db98.

## Приложение А. Имена блоков в файлах данных ref/

Часть блоков в [NAMES-EXTRA.txt](../ref/NAMES-EXTRA.txt),
[MAC-CMD-SITES.txt](../ref/MAC-CMD-SITES.txt), ANNO-uc.json и в данных 4.1
записана под групповыми или другими именами. Соответствие:

| адрес | имя в дереве | имя в файлах данных | назначение |
|---|---|---|---|
| 0x936b94 | `mac_clk__div165` | `us_from_ticks165` (4.1) | перевод тактов 165 МГц в мкс |
| 0x92960c | `mac__core_write_3d_0200` | `set_reg_886dc8_uc_92960c` | core write 0x3d |
| 0x929cf8 | `phy_stats__clear_counters_88395c` | `hwd_phy__rx_statistics_lock` (в fw — 0x8d2b00) | сброс счётчиков PHY |
| 0x928f9c | `aw_worker__read_dma_881c84` | `hwd_dma__get_rings_with_data` (в fw — 0x8d078c) | чтение DMA 0x881c84 для AW |
| 0x9283e0 | `gp0__arm_usec_c` | `tail___ld_r13_to_r13_ret_9283e0` | взвод GP0 в мкс |
| 0x922e9c | `bf_sm__on_brp_resp` | `uses_tbl_802000__922e9c` | обработчик BRP_RESP (§4.1) |
| 0x93b8d0 | `bf_sm__on_txss_init` | `uses_tbl_802000__93b8d0` | обработчик TXSS_INIT |
| 0x93be28 | `bf_sm__on_txss_resp` | `uses_tbl_802000__93be28` | обработчик TXSS_RESP |
| 0x922494, 0x922e74, 0x93b840, 0x93bdf0 | `bf_sm__brp_init_result`, `bf_sm__brp_resp_result`, `bf_sm__txss_init_result`, `bf_sm__txss_resp_result` | `uses_tbl_802000__922494/922e74/93b840/93bdf0` | ветки диспетчера запросов BF |
| 0x92783c, 0x92787c | `uc_evt__send_2b`, `uc_evt__send_23` | `uses_g_802470__92783c/92787c` | события fw (очередь 0x802470) |
| 0x92785c, 0x9278c8 | `uc_evt__send_20`, `uc_evt__send_21` | `uses_g_802470__92785c/9278c8` | события fw из `bf__reset_sta_slot` |
| 0x9278a8, 0x9279a0 | `uc_evt__send_26`, `uc_evt__send_25` | `…9278a8`, `…9279a0` | события INA и ответа 0x34 |
| 0x8dc380, 0x8dc3c4 (fw) | `lmac_if__send_sta_cfg_05_b`, `lmac_if__send_sta_cfg_05_c` | `uses_g_804280__8dc380/8dc3c4` | отправители LMAC 0x05 |
| 0x924f48, 0x935a6c, 0x938a18 | `fsched__time_left_class`, `fsched__arm_slot_from_cfg`, `fsched__run_tx_slot_twice` | `uses_g_80064c_801be8__924f48/935a6c/938a18` | фиксированное расписание |
| 0x927d5c, 0x927d78, 0x927dc8, 0x92bddc, 0x92ec28 | `fsched__slot_half4`, `fixed_sched__slot_word8`, `fsched__slot_byte0`, `fsched_ap__station_done`, `fsched_ap__copy_slot_byte1` | `uses_g_857700__927d5c/927d78/927dc8/92bddc/92ec28` | чтение конфигурации слотов из 0x857700 |
| 0x926890, 0x9268c0 | `peer__lookup_if_fixed_sched`, `sched_cfg__merge_update` | `uses_g_801be8__926890/9268c0` | QH по пиру |
| 0x9361bc, 0x936544 | `mac_evt__enable_bit_sync`, `mac_evt__enable_bit_sync_b` | `uses_g_8004e0_9361bc/936544` | ожидание готовности |
| 0x93dbec, 0x93dfec | `itx__wait_ack_rf`, `itx__wait_cts_rf` | `uses_g_802aa0__93dbec/93dfec` | MAC cmd 0x02, ожидание event1\|event4 |
| 0x926310, 0x92b6ac | `rx_flow__run_and_check_bf_abort`, `l1__rx_then_check_bf_abort` | `uses_g_802288__926310/92b6ac` | RX-поток или abort BF |
| 0x92e6e8, 0x92e704 | `power_mngr__stats_calc_delta`, `power_mngr__stats_mark_base` | `uses_g_8007b8_8022c8__92e6e8/92e704` | учёт питания |
| 0x9274e0, 0x9274f4 | `l1_task__mask_halt_req_and_defer`, `l1_task__mask_wake_req_and_defer` | `set_reg_886d80_9274e0/9274f4` | запросы halt/wake через 0x886d80 |
| 0x929c10 | `hwd_phy_rx_set_agc_start_val_and_gain_array_uc` | `hwd_phy_rx_set_agc_start_val_and_gain_array_` | старт AGC и массив усиления |
| 0x92d400 | `qh__build_descriptor_b` | `_b` | шаблон дескриптора QH |

## Не установлено

* Смысл большинства блоков раздела 7 (роль только по соседям).
* Отправители команд 0x26, 0x28/0x2a/0x2e/0x37/0x3c, 0x29/0x2b/0x2f/0x38/0x3d, 0x34 и назначение
  команды 0x42 со стороны fw — [LMAC-PROTOCOL](../../docs/LMAC-PROTOCOL.md).

## Источники

* Дерево исходников `6.2/src/asm/uc/`; `6.2/tools/uc_cmd_table.py`.
* [SM-TABLES-UC.txt](../ref/SM-TABLES-UC.txt), [MSXD-LR-RGF.txt](../ref/MSXD-LR-RGF.txt),
  [NAMES-EXTRA.txt](../ref/NAMES-EXTRA.txt), `4.1/ref/MAC-CMD-MAP.txt`.
* [LMAC-PROTOCOL](../../docs/LMAC-PROTOCOL.md), [MAC-COMMANDS](../../docs/MAC-COMMANDS.md),
  [UCODE-TASKS](../../docs/UCODE-TASKS.md), [BF-ENGINE](../../docs/BF-ENGINE.md),
  [DATAPATH](../../docs/DATAPATH.md), [BEACONING](../../docs/BEACONING.md),
  [FIXED-SCHED](FIXED-SCHED.md), [BENCH](BENCH.md).
