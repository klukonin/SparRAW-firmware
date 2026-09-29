# Подсистемы прошивки (fw) 6.2: специфика версии и каталог блоков

Сведения о сегменте fw 6.2.0.1000, которых нет в 4.1.0.1000: отладочные команды UT
hw_sysapi, FTM/ToF, каталог блоков по вендорским исходным файлам (по
[FN-FILEMAP.txt](../ref/FN-FILEMAP.txt)) и соответствие имён блоков в файлах данных `ref/`.
Подсистемы, которые есть в обеих версиях, описаны в общих документах с адресами обеих
версий:

| подсистема | документ |
|---|---|
| таблица векторов, user-ICR хоста 0x880b50 | [HW-DRIVERS §2](../../docs/HW-DRIVERS.md#2-прерывания-fw-вектора-arc600-и-user-icr-обе) |
| планировщик `u_schd`, главный цикл | [SCHEDULER](../../docs/SCHEDULER.md) |
| MLME, разъединение, соединение и CID, ключи, приём маяка, скан, P2P Find | [MLME](../../docs/MLME.md) |
| прямой PBSS, режим OOB в 6.2 | [ROLELESS-LINK §4.7, §1.7](../../docs/ROLELESS-LINK.md) |
| радио-менеджер и переключение канала | [RADIO-MANAGER](../../docs/RADIO-MANAGER.md) |
| расписание ESE | [ESE](../../docs/ESE.md) |
| инициализация L2, подъём MAC, кольца и ящики, link loss, состояние системы, события хосту | [L2-MANAGER](../../docs/L2-MANAGER.md) |
| тело LMAC 0x00 и тайминги MAC, LMAC 0x20 | [LMAC-PROTOCOL §3.1, §3.9](../../docs/LMAC-PROTOCOL.md) |
| управляющие кадры, TX API, очереди (каталог) | [DATAPATH §11](../../docs/DATAPATH.md#11-каталог-блоков-fw-управляющие-кадры-tx-api-очереди-обе) |
| РЧ, board-файл, калибровки, PCIe, питание, периферия (каталог) | [HW-DRIVERS §12–§14](../../docs/HW-DRIVERS.md) |
| битовые поля, милли-код, аксессоры, мелкие функции | [FW-UTILITIES](../../docs/FW-UTILITIES.md) |
| счётчики приёма PHY | [HARDWARE-BLOCKS](../../docs/HARDWARE-BLOCKS.md#счётчики-приёма-phy-код--железо) |

Метки доказанности: **[железо]** — проверено на стенде, **[код]** — прочитан
листинг, **[стр]** — по собственной лог-строке блока, **[выз]** — только по
вызывающим/вызываемым, **[пак]** — по вендорским именам пака 11ad,
**[гипотеза]** — не проверено. Раздел 3 — каталог (имя, адрес, принадлежность
файлу и роль по соседям).

Связанные документы: автоматы и их обработчики — [STATE-MACHINES](../../docs/STATE-MACHINES.md);
драйверы железа — [HW-DRIVERS](../../docs/HW-DRIVERS.md); фиксированное расписание —
[FIXED-SCHED](FIXED-SCHED.md); карта регистров — [REGS-62](../ref/REGS-62.md);
ucode — [MISC-UC](MISC-UC.md).

## 1. Отладочные команды UT (hw_sysapi)

Ветви `UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler`: `hw_sysapi_channel_estimation`
0x8cdcdc, `hw_sysapi_force_mcs` 0x8cdde8 (→ LMAC cmd 0x30),
`hw_sysapi_get_beamforming_statistics` 0x8cde44, `hw_sysapi_plcp_header`
0x8ce120; `print_input_filter_params` 0x8f7490 — общий журнал фильтра
(sta_id, qid, is_cp, mcs, omni, timeout) для статистических команд.

## 2. FTM / ToF

Подробно — [HW-DRIVERS](../../docs/HW-DRIVERS.md) (раздел ToF/FTM).

* Инициализация `tof__init` 0x8d940c («[TOF] Init.», пул сессий, автомат
  0x8034c0); `tof__next_request` 0x8e0b58 — «[TOF] Non-associated state»,
  достаёт следующий запрос; `tof__alloc_session` — пул FTM-сессий.
* Запрос хоста: `tof_mgr__ftm_req_handle_8cb350` 0x8cb350 (поиск/создание
  сессии), `free_ftm_session` 0x8cb05c, `ftm__session_step` 0x8e4bc8,
  `state_sm_8034c0__action_step` 0x8cb5a4 / `state_sm_8034c0__step_b` 0x8e1dc8
  (старт AoA или FTM по TSF).
* Сессия (автомат 0x803424, READY/BURST/WAIT): START →
  `state_sm_803424__action_8f064c` 0x8f064c «action_ftm_start_session(): CID,
  FTM flags, ftm per burst» — строит FTM Request (`frame__build_ftm_request`
  0x8f5040, битовые поля параметров burst) и шлёт с колбэком; остальные
  переходы — [STATE-MACHINES](../../docs/STATE-MACHINES.md). Радио получено —
  `ftm_main_sm__radio_allocated_cb` 0x8f7f38 (LMAC cmd 0x07).
* Ответчик: `ftm__responder_rx_req` 0x8cb3bc — приём FTM-кадра («FTM Responder,
  MAC», «Station is not enabled as FTM responder»).
* `tof__get_rx_offset` 0x8d46a0 — TX/RX offset для `wmi_tof_get_tx_rx_offset`.
* `tof__find_session_by_addr` 0x8e1df8 — поиск/создание FTM-сессии (до
  0x8e1e96); `tx_ring__post_frame` 0x8e1e98 — постановка кадра в TX-кольцо
  (проверка заполненности, дескриптор `tx_desc__init_32` 0x8e9bf4, запуск DMA,
  0x886a00).

## 3. Каталог блоков по вендорским исходным файлам

Принадлежность вендорскому файлу — по [FN-FILEMAP.txt](../ref/FN-FILEMAP.txt)
(факт); роли — по собственным строкам и соседям **[стр]/[выз]**, тела не
читались, если не оговорено. После описания — полный перечень блоков файла.

* **hw_drivers_phy** (2532 Б): регистры PHY 0x883000–0x885xxx: питание (`hwd_phy_pwr_fw`, `hwd_phy__enable_880b00`), swap I/Q (`hwd_phy_get_rx/tx_swap_iq`), канал (`phy__program_channel_regs`), AGC (`hwd_phy_rx_set_agc_start_val_and_gain_array`), BRP RAM (`hwd_phy_rx_read_and_parse_brp_ram` — оценка канала), SAR, счётчики ошибок (`link_stats__phy_counters`), диагностика (`link_lost_diag__dump_phy`), UT-команды 0x40c/0x41d.  
  Блоки: `hwd_phy_get_rx_swap_iq` 0x8d1c30, `hwd_phy_get_tx_swap_iq` 0x8d1c90, `hwd_phy__uses_rgf_880c00_8d1d04` 0x8d1d04, `hwd_phy__uses_rgf_880c00_8d1d34` 0x8d1d34, `hwd_phy__online_measurement_start` 0x8d1e34, `hwd_phy__online_sar_measurement_valid` 0x8d1e58, `hwd_phy_pwr_fw` 0x8d1e68, `hwd_phy__enable_880b00` 0x8d2158, `hwd_phy__rx_enable` 0x8d219c, `hwd_phy__rx_is_enabled` 0x8d21c4, `hwd_phy__tx_enable` 0x8d21d0, `phy_rx__read_rssi_adc` 0x8d21f8, `phy_rx__read_rssi_adc_locked` 0x8d2208, `hwd_phy__rx_agc_steps_disable` 0x8d2260, `hwd_phy__rx_apu_calc` 0x8d2314, `hwd_phy__rx_cal_corr` 0x8d23a0, `phy__program_channel_regs` 0x8d24fc, `hwd_phy__uses_rgf_883100` 0x8d2568, `phy__get_88312c_6bit` 0x8d25a8, `phy__get_88306c_6bit` 0x8d25b4, `phy_stats__get_cfg_word` 0x8d25c0, `phy__get_signal_gain_adc_db` 0x8d25cc, `phy__get_signal_gain_adc_db_sfd_locked` 0x8d25d8, `phy__get_ina_rssi_adc_db` 0x8d2648, `phy__get_ina_rssi_adc_db_sfd_locked` 0x8d2654, `link_lost_diag__dump_phy` 0x8d2660, `hwd_phy__get_883180` 0x8d26bc, `hwd_phy__rx_postdist_dc_enable` 0x8d26d0, `hwd_phy__rx_postdist_dc_per_sar_mode` 0x8d2700, `hwd_phy__rx_postdist_force_dc_config` 0x8d2728, `hwd_phy__rx_postdist_force_dc_set` 0x8d2758, `link_stats__phy_counters` 0x8d27d8, `hwd_phy_rx_read_and_parse_brp_ram` 0x8d27f4, `hwd_phy__rx_sar_measurement_completed` 0x8d2920, `hwd_phy__rx_sar_measurement_start` 0x8d2958, `hwd_phy_rx_set_agc_start_val_and_gain_array` 0x8d2a6c, `hwd_phy__rx_statistics_clear` 0x8d2ae4, `hwd_phy__rx_statistics_lock` 0x8d2b00, `hwd_phy__self_digital_loopback` 0x8d2b0c, `hwd_phy__self_mode_exit` 0x8d2b38, `hwd_phy__self_rx_mode_entry` 0x8d2ba4, `hwd_phy__get_883b80` 0x8d2cf4, `hwd_phy__tx_play_buffer_stop` 0x8d2e18, `hwd_phy__get_884100` 0x8d2ea0.
* **layer2_mgr** (2472 Б): L2-менеджер: `scan_mngr__connect` (268 Б) — подключение к найденному DMG-BSS после скана; разрыв — `mlme_sm__disconnect_ev_handle`, `conn_disc_sm__disassoc_sent_cb` («disassoc_done() Stop…», flush соединения), `disconnect_by_peer`, `mlme_sm_8027a0__action_8f24d8` («DISCONNECT flow started m_graceful»), `link_lost_diag_part2` (диагностика при разрыве); MLME: `mlme_sm__data_port_open_ev_handle(_8f21c0)` («DATA PORT OPEN event», EVT_DATA_PORT_OPEN в ASSOCIATE→ASSOCIATED), `mlme_sm_802458__action_8f20bc` (ctrl_assoc_resp_ret), `mlme_sm_802458__action_8f2444` (Disassoc); инициализация — `init_rf_hw` (244 Б, тактирование РЧ, marlon), `mid_ctx_pool__init`, `radio_mgr__init_global` (радио-менеджер), `sched__step_8d9f00`/`operational_if__init_mbox_ptr` (рабочий ящик); `l2mgr__set_app_ie`, `l2mgr__set_mac_address` (печать «I'm ROOT», [L2-MANAGER §10](../../docs/L2-MANAGER.md#10-ошибка-печати-im-root-код)).  
  Блоки: `l2mgr__disconnect_sta` 0x8c93a0, `scan_mngr__connect` 0x8f1f2c, `sysapi_mgr__stats_lut_find_index` 0x8f2038, `mlme_sm__data_port_open_ev_handle` 0x8f2070, `mlme_sm_802458__action_8f20bc` 0x8f20bc, `mlme_sm__data_port_open_ev_handle_8f21c0` 0x8f21c0, `link_lost_diag_part2` 0x8f2250, `maintain_sm__reset_rate_params` 0x8f234c, `conn_disc_sm__disassoc_sent_cb` 0x8f23a0, `mlme_sm_802458__action_8f2444` 0x8f2444, `mlme_sm_8027a0__action_8f24c0` 0x8f24c0, `mlme_sm_8027a0__action_8f24d8` 0x8f24d8, `disconnect_by_peer` 0x8f2584, `mlme_sm__disconnect_ev_handle` 0x8f25c8, `operational_if__init_mbox_ptr` 0x8f5678, `obj_vt802458__ctor` 0x8f5688, `radio_mgr__init_global` 0x8f56b8, `mid_ctx_pool__init` 0x8f56d0, `sched__step_8d9f00` 0x8f58e4, `ba_setup_sm__action_8f58f8` 0x8f58f8, `init_rf_hw` 0x8f590c, `ber_stats__snapshot` 0x8f5a40, `l2mgr__set_app_ie` 0x8fbb90, `l2mgr__set_mac_address` 0x8fbc64.
* **mid** (2456 Б): объект MID и его списки. `conn_main_sm__action_8c3bf4` — OWN_ASSOC в READY_FOR_ASSOC: «Sending mlme_sm::ASSOC_RESPONSE for direct STA PBSS member» (впрыск Assoc Resp в MLME прямого PBSS-линка, [ROLELESS-LINK §4.7](../../docs/ROLELESS-LINK.md#47-прямой-pbss-в-62-код)) и `conn_main_sm__action_8c3c60` — «PCP AP after association. Set connection ID, AID»; `mid__update_aw_ie` — «PCP AP Update AW IE - TBTT» (окно AW в маяке); `set_parse_ei` (524 Б) — разбор информационных элементов принятого mgmt-кадра по подтипу («[PRS]set_parse_ei: EI_ID, stype, EI_LEN»); `arc_protect_addr`/`arc_action_point__arm` — аппаратные action points ARC как сторож памяти (ставит детектор TX ageing), `arc__debug_cause`/`arc__read_aux_by_index` — разбор причины ошибки инструкции; `set_app_ie`, `mid__apply_app_ies`, `mid__replace_rsn_ie` — app-IE хоста в маяк/probe; `rf_cfg__load_800d04` — таблица высокой мощности из WMI.  
  Блоки: `mid__update_aw_ie` 0x8c3a04, `conn_mgr__apply_default_link_maintain_cfg` 0x8c3a5c, `rm_ch_switch__program_mac` 0x8c3ac0, `arc_action_point__arm` 0x8c3af0, `arc__debug_cause` 0x8c3b50, `arc__read_aux_by_index` 0x8c3b5c, `arc_protect_addr` 0x8c3b90, `conn_main_sm__action_8c3bf4` 0x8c3bf4, `conn_main_sm__action_8c3c60` 0x8c3c60, `mid__lookup_for_tx` 0x8c7548, `mid__cid_by_aid` 0x8cc06c, `mid_list__insert` 0x8e5f0c, `rx_pool__configure_step` 0x8e60d0, `app_ies__bind_buffer` 0x8e6108, `u_schd__timer_set_fields` 0x8e6114, `mid__apply_app_ies` 0x8e61c0, `set_app_ie` 0x8e6224, `wait_sm__action_8e6a4c` 0x8e6a4c, `set_parse_ei` 0x8e6a54, `rx_api__drain_all_lists` 0x8e6c60, `rm_sm__action_at_2c` 0x8e6d34, `ps_cfg__apply_profile_0` 0x8e6d4c, `ps_cfg__apply_profile_1` 0x8e6da4, `field_rw_0x04__8e6e08` 0x8e6e08, `conn__set_rf_params_from_caps` 0x8e6e1c, `rf_cfg__load_800d04` 0x8e6e8c, `field_set_0x00__8e6f2c` 0x8e6f2c, `mid__replace_rsn_ie` 0x8e6f34.
* **lmac_if** (2092 Б): интерфейс с ucode. Обработчики событий ucode: `lmac_if_link_lost_evt_handler`, `lmac_if__bf_done_and_new_link`, `evt_fixed_scheduling_enabled`, `event_flush_q_done`, `ps_shallow_sleep_ntf_evt`, `ps_traffic_deferral_cfg_evt`, `ps_wake_pcie_evt`, `return_field_type` (172 Б — событие об установке ключа: `install_key_handle`, `l2mgr__apply_key_to_prings`), `lmac_if__update_pct_stats` (статистика с 64-битной арифметикой), `ftm__responder_rx_req__with_ctx` (FTM). Построители LMAC-команд — выделение записи (`mem_pool__alloc_locked`) и постановка в кольцо (`lmac_if__post_cmd`): `field_set_0x00__8db2fc/8db5bc/8dbc94/8dbcb0/8dbe88`, `field_rw_0x00__8db534`, `wmi_brp__alloc_and_store`, `sched__alloc_entry`, `hw_sysapi_rx__alloc_and_store`, `hwm__alloc_and_store`, `channel_est__stack_args`, `lmac_if__send_bcon_del_0b` (удаление маяка), `lmac_if__send_txop_limits`, `lmac_if__send_cmd_0x16_calib_b4`, `silent_rssi__report_agc_tables` (AGC), `lmac_if__build_rx_on_cmd` (cmd 0x01), `ftm__send_ucode_session_cfg` (FTM); сектора TXSS с хоста — `lmac_if_set_ss_sectors_default_cfg_handler`, `…number_handler`, `…order_handler`; `lmac_if__build_bcon_cfg` (BI и SS-параметры маяка), `lmac_mbox__is_full`, хвосты cmd 0x04 и config_txss. Соответствие кодов команд и обработчиков ucode — [MISC-UC](MISC-UC.md) §1.  
  Блоки: `lmac_if__build_bcon_cfg` 0x8db260, `field_set_0x00__8db2fc` 0x8db2fc, `lmac_if__send_bcon_del_0b` 0x8db304, `lmac_if__bf_done_and_new_link` 0x8db518, `field_rw_0x00__8db534` 0x8db534, `wmi_brp__alloc_and_store` 0x8db598, `field_set_0x00__8db5bc` 0x8db5bc, `sched__alloc_entry` 0x8db5d8, `lmac_if__send_cmd_04_thunk` 0x8db718, `lmac_if__config_txss_8` 0x8db71c, `evt_fixed_scheduling_enabled` 0x8db7bc, `event_flush_q_done` 0x8db7f0, `ftm__send_ucode_session_cfg` 0x8db81c, `ftm__responder_rx_req__with_ctx` 0x8db8c4, `lmac_mbox__is_full` 0x8db948, `lmac_if_link_lost_evt_handler` 0x8db960, `lmac_if__update_pct_stats` 0x8db9c0, `lmac_if__send_txop_limits` 0x8dbaa0, `hw_sysapi_rx__alloc_and_store` 0x8dbb04, `field_set_0x00__8dbc94` 0x8dbc94, `field_set_0x00__8dbcb0` 0x8dbcb0, `lmac_if__build_rx_on_cmd` 0x8dbcdc, `channel_est__stack_args` 0x8dbe54, `field_set_0x00__8dbe88` 0x8dbe88, `hwm__alloc_and_store` 0x8dbea8, `silent_rssi__report_agc_tables` 0x8dbec8, `lmac_if_set_ss_sectors_default_cfg_handler` 0x8dbfa0, `lmac_if_set_ss_sectors_number_handler` 0x8dc018, `lmac_if_set_ss_sectors_order_handler` 0x8dc080, `ps_shallow_sleep_ntf_evt` 0x8dc10c, `lmac_if__send_cmd_0x16_calib_b4` 0x8dc120, `return_field_type` 0x8dc14c, `ps_traffic_deferral_cfg_evt` 0x8dc218, `ps_wake_pcie_evt` 0x8dc224.
* **hw_drivers_dma** (1348 Б): DMA: `hwd_dma__bad_cause` («DMA BAD Interrupt»), `dma_is_idle`, `dma_reset` («DO.clr_all»), `hwd_dma__reset_vring` («Reset V-ring head/head_4_rd»), `hwd_dma__raise_host_fw_int`, `hwd_dma__set_power_mode_map`, поля колец (`hwd_dma__set_ring_field_99e0/9a10`, `hwd_dma__write_ring_reg`, `vring_hw__*`), регистры 0x881c00/0x881000/0x8813xx.  
  Блоки: `hwd_dma__bad_cause` 0x8d072c, `hwd_dma__init__8d0760` 0x8d0760, `hwd_dma__set_881c00` 0x8d0778, `hwd_dma__get_rings_with_data` 0x8d078c, `vring_hw__read_status_bit` 0x8d0798, `hwd_dma__get_881bf0_bit27` 0x8d07b8, `hwd_dma__uses_rgf_881c00_8d07d4` 0x8d07d4, `hwd_dma__uses_rgf_881c00_8d07f8` 0x8d07f8, `hwd_dma__read_8813f0` 0x8d081c, `hwd_dma__read_8813c8` 0x8d0828, `rx_chain__reg_8813c8_addr` 0x8d0834, `vring_hw__field_addr_440c100` 0x8d085c, `hwd_dma__uses_rgf_881c00_8d0870` 0x8d0870, `hwd_dma__get_881c80` 0x8d0894, `hwd_dma__get_8812d8` 0x8d08a4, `dma_is_idle` 0x8d08c0, `hwd_dma__set_power_mode_map` 0x8d0908, `dma_reset` 0x8d0970, `hwd_dma__reset_vring` 0x8d09a0, `field_set_0x00__8d0a44` 0x8d0a44, `hwd_dma__set_ring_field_99e0` 0x8d0a80, `hwd_dma__raise_host_fw_int` 0x8d0ad8, `hwd_dma__uses_rgf_881c00_8d0b14` 0x8d0b14, `hwd_dma__uses_rgf_881c00_8d0b44` 0x8d0b44, `hwd_dma__uses_rgf_881c00_8d0b74` 0x8d0b74, `hwd_dma__uses_rgf_881000` 0x8d0ba4, `hwd_dma__write_ring_reg` 0x8d0c00, `hwd_dma__uses_rgf_881c00_8d0c18` 0x8d0c18, `hwd_dma__set_ring_field_9a10` 0x8d0c48.
* **hw_drivers_mac_parser** (1120 Б): парсер MAC: разбор Wilocity VS — `parse_wilocity_vs__find_tlv` и геттеры (`…get_features_version_tracking`, `…get_netowork_mode`, `…get_test_mode`, `…get_version`, `…__get_flag3` = PBC); правила приёма 0x886000/0x886200/0x886260/0x886280 — `mac_parser__uses_rgf_886280`, `mac_filter__write_entries`, `mac_parser__build_wildcard_rule`, `mac_parser__rule_a`, `mac_parser__set_886000_*` (свой/multicast MAC), `mac_parser__set_886200`, `mac_parser__set_886260` (RX discovery on/off), `mac_parser__set_default_ctrl`; `install_key__parse_flags`, `stream_mgr__prepare_1f`, `rx_macq__program_desc_848018`.  
  Блоки: `parse_wilocity_vs__find_tlv` 0x8df7ac, `parse_wilocity_vs_get_features_version_tracking` 0x8df7e8, `parse_wilocity_vs_get_netowork_mode` 0x8df824, `parse_wilocity_vs_get_test_mode` 0x8df888, `parse_wilocity_vs_get_version` 0x8df8cc, `parse_wilocity_vs__get_flag3` 0x8df8ec, `rx_macq__program_desc_848018` 0x8df908, `install_key__parse_flags` 0x8df9a4, `mac_filter__write_entries` 0x8df9e8, `mac_parser__build_wildcard_rule` 0x8dfac8, `stream_mgr__prepare_1f` 0x8dfafc, `mac_parser__rule_a` 0x8dfb3c, `mac_parser__set_886000_8dfb68` 0x8dfb68, `mac_parser__set_886000_8dfb84` 0x8dfb84, `mac_parser__set_886200` 0x8dfba0, `mac_parser__set_886260` 0x8dfbbc, `mac_parser__set_default_ctrl` 0x8dfbc8, `mac_parser__uses_rgf_886280` 0x8dfbd8.
* **hw_flows_rf** (1060 Б): XPM (OTP РЧ) — `hwf_rf_xpm_cfg_get/set`, `xpm__enter_cfg_step`, чтение/программирование байта и блока; `hwf_rf__wait_reset_done`.  
  Блоки: `hwf_rf__wait_reset_done` 0x8d70b8, `hwf_rf_xpm_cfg_get` 0x8f47dc, `hwf_rf_xpm_cfg_set` 0x8f4890, `xpm__enter_cfg_step` 0x8f4960, `hwf_rf_xpm_program_byte` 0x8f49d4, `hwf_rf_xpm_read_block` 0x8f4a30, `hwf_rf_xpm_program_byte_8f4ab0` 0x8f4ab0, `hwf_rf_xpm_read_block_8f4b70` 0x8f4b70, `hwf_rf_xpm_read_byte` 0x8f4bd8.
* **hw_drivers_abif** (1036 Б): ABIF: `car`-связка и прерывания срыва захвата PLL5/FS8 блока CAF_ICR (`abif__ack_unmask_fs_unlock_irq`, `abif__ack_unmask_pll_unlock_irq`), выключение аналоговых блоков в halt (`abif__power_down_88af80/889300`), `channel__check_range` (304 Б — проверка номера канала и таблица параметров канала), `hwd_abif__rfc_divider_restart`, RMW поля AGC.  
  Блоки: `hwd_abif__get_88af00` 0x8ce5d8, `hwd_abif__uses_rgf_88af80_8ce614` 0x8ce614, `hwd_abif__uses_rgf_88af80_8ce660` 0x8ce660, `rfca__get_rf_set_lo8` 0x8ce82c, `hwd_abif__uses_rgf_889480_8cebac` 0x8cebac, `hwd_abif__uses_rgf_889480_8ced4c` 0x8ced4c, `hwd_abif__rgf_889380` 0x8ced8c, `hwd_abif__rfc_divider_restart` 0x8ceda4, `abif__agc_field_rmw` 0x8cf894, `channel__check_range` 0x8cfadc, `hwd_abif__uses_rgf_88af80_8d0010` 0x8d0010, `abif__power_down_88af80` 0x8d0048, `abif__power_down_889300` 0x8d0070, `hwd_abif__uses_rgf_889380` 0x8d0098, `hwd_abif__rgf_880b00` 0x8d00cc, `abif__mask_fs_unlock_irq` 0x8d00e8, `abif__mask_pll_unlock_irq` 0x8d00f4, `abif__ack_unmask_fs_unlock_irq` 0x8d0100, `abif__ack_unmask_pll_unlock_irq` 0x8d0114, `mac__set_880bf0_mode_fw` 0x8d0144, `car__get_pll3_status_bit3` 0x8d0188.
* **hw_drivers_rfc** (968 Б): поля RFC: запись/упаковка (`rfc__pack_field_value`, `rfc__write_packed_fields`, `rfc__write_chain_field`, `rfc__write_field_484/1136`), глубокое выключение всех RF (`hwd_rfc_powerdown_deep_all_rfs_fw`), включение (`rgf_889100_889480__8d3460/8d3efc`), `hwd__args_to_regs`.  
  Блоки: `rfc__write_core_reg6` 0x8d32a4, `rfc__read_field_484` 0x8d32b0, `rfc__pack_field_value` 0x8d32e4, `xpm__get_cfg_preset` 0x8d336c, `hwd__args_to_regs` 0x8d338c, `calib_silent_rssi__flag_step` 0x8d33c4, `hwd_rfc_powerdown_deep_all_rfs_fw` 0x8d3424, `rfc__restore_txrx_sets_fw` 0x8d3460, `rfc__read_core_result_fw` 0x8d3628, `rfc__write_chain_field` 0x8d3e58, `rfc__write_packed_fields` 0x8d3e80, `calib_lo_power__save_level` 0x8d3ef4, `rf__set_txrx_sets_save_fw` 0x8d3efc, `rfc__write_field_484` 0x8d3f80, `rfc__write_field_1136` 0x8d4064, `rfc__write_field_434_2ec33` 0x8d414c, `rfc__read_block_loop` 0x8d42e0.
* **hw_drivers_pcie** (960 Б): регистры PCIe 0x8825xx–0x882fxx: LTSSM (`hwd_pcie__get_ltssm_state`), L1/сон (`set_reg_882fd0/fd8/fe0/fe4`, `hwd_pcie__get_882fd4_bit19`), SerDes (`pcie__serdes_program_all`, `hwd_pcie__clear_88b000_bits`), карта режимов (`hwd_pcie__set_mode_map`), разбор причин вектора 16 (`pcie_irq__extract_bit_by_code_fw`), счётчики ошибок, DBI-последовательность `pcie__dbi_write_seq`.  
  Блоки: `hwd_pcie__rgf_882b80` 0x8d1294, `pcie__read_app_debug_if` 0x8d13a4, `pcie__get_driver_is_up` 0x8d13c4, `hwd_pcie__rgf_882600` 0x8d13d4, `hwd_pcie__get_88b0c0_state4` 0x8d13ec, `hwd_pcie__get_ltssm_state` 0x8d13fc, `hwd_pcie__read_8825c0` 0x8d141c, `hwd_pcie__get_882b80` 0x8d1428, `pcie__get_phy_pll_lock` 0x8d1434, `hwd_pcie__set_882600` 0x8d1444, `hwd_pcie__read_882650` 0x8d1458, `pcie__dbi_set_data` 0x8d1464, `hwd_pcie__is_ep_under_serdes` 0x8d1470, `pcie_irq__extract_bit_by_code_fw` 0x8d1484, `hwd_pcie__toggle_882f80_bits` 0x8d1554, `pcie_ltssm__code_to_index` 0x8d158c, `pcie__mask_l1_enter_irq` 0x8d15a4, `hwd_pcie__rgf_882f80_8d15b4` 0x8d15b4, `pcie__ack_l1_exit_irq` 0x8d15ec, `pcie__mask_l1_exit_irq` 0x8d15fc, `pcie__unmask_l1_exit_irq` 0x8d160c, `pcie__l1_exit_irq_recover` 0x8d161c, `hwd_pcie__get_882fd4_bit19` 0x8d163c, `pcie__dbi_write_seq` 0x8d167c, `pcie__serdes_program_all` 0x8d1720, `hwd_pcie__uses_rgf_880c00` 0x8d173c, `hwd_pcie__clear_88b000_bits` 0x8d1764, `hwd_pcie__set_mode_map` 0x8d18e8, `hwd_pcie__rgf_882f80_8d196c` 0x8d196c, `hwd_pcie__perst_assert_int_en` 0x8d1980, `hwd_pcie__perst_deassert_int_clear` 0x8d198c, `hwd_pcie__perst_deassert_int_en` 0x8d1998, `mac__set_bits_880af4_f8_fc` 0x8d19a4.
* **wmi_handlers** (780 Б): проверка входов WMI-команд секторов: `wmi_handler_get/set_rf_sector_params__*` (захват радио, «Radio is st…»), `wmi_handler_get/set_selected_rf_sector_index__*`; `rm_main_sm__inject_lock_evt`.  
  Блоки: `wmi_handler_get_rf_sector_params__check_inputs_valid` 0x8c6040, `wmi_handler_set_rf_sector_params__verify_inputs` 0x8c60d0, `wmi_handler_get_selected_rf_sector_index__check_inputs_valid` 0x8c6160, `wmi_handler_set_selected_rf_sector_index__check_inputs_valid` 0x8c61d4, `wmi_handler_get_rf_sector_params__handle` 0x8cd104, `wmi_handler_set_rf_sector_params__handle` 0x8cd14c, `rm_main_sm__inject_lock_evt` 0x8cd288.
* **vring_schdlr** (752 Б): планировщик vring и соседи: `sm_pring__notify_vring_state`, `vring_schd__add_sniffer_vring`, разрыв — `conn_main_sm__action_8c9050` (WMI disconnect по devid), `mid_list__disconnect_all`, `pbss__disconnect_by_peer` («PBSS Disconnection»), `PS_CONNECTION__disassoc_ntf`, `m_connect_devid`, `lm_if__disable_link_loss_monitoring`, `rf_mgmt_sm__action_8c8fcc` (RF kill → `low_sme__handle_rf_kill`).  
  Блоки: `vring_schd__add_sniffer_vring` 0x8c2c14, `lm_if__disable_link_loss_monitoring` 0x8c8f90, `ps_cfg__clear_ps_flags` 0x8c8fc0, `rf_mgmt_sm__action_8c8fcc` 0x8c8fcc, `PS_CONNECTION__disassoc_ntf` 0x8c8ff0, `m_connect_devid` 0x8c9024, `conn_main_sm__action_8c9050` 0x8c9050, `mid_list__disconnect_all` 0x8c9110, `pbss__disconnect_by_peer` 0x8c9164, `sm_pring__notify_vring_state` 0x8ea1b4.
* **wbe_driver** (636 Б): `WBE_DRIVER__link_up/down_notif` (PCIe link с хостом: «DEV2_LINK_UP»), `wbe_driver__pcie_debug` (316 Б — печать регистров отладки PCIe по кольцам).  
  Блоки: `WBE_DRIVER__link_down_notif` 0x8f5dd4, `WBE_DRIVER__link_up_notif` 0x8f5ea8, `wbe_driver__pcie_debug` 0x8f7d20.
* **tx_api** (468 Б): `TX_API__free_memory`, `TX_CTRL_API__flush_connection`, `SW_TX_MGMT_API__send_packet` (248 Б), `tx_api__tx_complete_cb`.  
  Блоки: `TX_CTRL_API__flush_connection` 0x8cabc4, `TX_API__free_memory` 0x8cb10c, `SW_TX_MGMT_API__send_packet` 0x8e577c, `tx_api__tx_complete_cb` 0x8e9ae8.
* **conn_mgr** (428 Б): CID: `conn_mgr__alloc_cid`, `…find_reusable_cid`, `…free_cid_db_element`, `…add_to_rinking_list`, `…by_cid`.  
  Блоки: `conn_mgr__add_to_rinking_list` 0x8c2d78, `conn_mgr__alloc_cid` 0x8c3290, `conn_mgr__find_reusable_cid` 0x8c656c, `conn_mgr__free_cid_db_element` 0x8caf54, `conn_mgr__by_cid` 0x8cbffc.
* **scan_mngr** (404 Б): `scan_mngr__handle_link_up_event`, `scan_mngr__send_prob_req`.  
  Блоки: `scan_mngr__handle_link_up_event` 0x8cd790, `scan_mngr__send_prob_req` 0x8f8bcc.
* **app_ies** (400 Б): `ies_block__merge` (300 Б — слияние своих IE с app-IE хоста), `app_ies__set_probe_req_ies`, `app_ies__set_buffer`.  
  Блоки: `ies_block__merge` 0x8ddfd0, `app_ies__set_probe_req_ies` 0x8e6908, `app_ies__set_buffer` 0x8e693c.
* **SDP_GPIO_srvs** (364 Б): `SDP__sdp_init__2` (256 Б — порты SDP по personality), `SDP__sdp_drive_value`, `SDP__sdp_is_in_use_sdp`.  
  Блоки: `SDP__sdp_drive_value` 0x8e4abc, `SDP__sdp_is_in_use_sdp` 0x8e4b04, `SDP__sdp_init__2` 0x8f83c0.
* **marlon_r_if** (356 Б): `marlon_r_if_class__config_brp_sectors`, `…rf_hw_write_buffer`.  
  Блоки: `marlon_r_if_class__config_brp_sectors` 0x8e32b4, `rf_utils__auto_fill_8021c8` 0x8e33ac, `marlon_r_if_class__rf_hw_write_buffer` 0x8e33d8.
* **hw_drivers_user_spi** (336 Б): `hwd_spi_read` — чтение SPI-флеш при загрузке («SPI READ: waited»).  
  Блоки: `hwd_spi_read` 0x8f9294.
* **tx_queue** (328 Б): `txq_ring_param_config_queue`, `txq_ptp_sw_is_fifo_idle`, `macq__clear_886a28_low2`.  
  Блоки: `macq__clear_886a28_low2` 0x8ea450, `txq_ptp_sw_is_fifo_idle` 0x8ea47c, `txq_ring_param_config_queue` 0x8ea4b8.
* **binary_search_lut** (324 Б): `lut__find_index`/`…__2` — двоичный поиск в таблице (RSSI/SNR-преобразования).  
  Блоки: `lut__find_index` 0x8c74e8, `lut__find_index__2` 0x8ca7f8.
* **fwq_tx** (272 Б): мелкие аксессоры и хвосты.  
  Блоки: `fwq_tx__request_flush` 0x8cac1c, `fwq_tx__handle_completion_thunk` 0x8cc740, `tx_api__call_vmethod_04` 0x8cc748, `fwq_tx__enable_queue` 0x8e787c.
* **tx_macq** (268 Б): `tx_macq__setup`, `tx_macq__config_ring_params`.  
  Блоки: `tx_macq__setup` 0x8d944c, `tx_macq__config_ring_params` 0x8e29b8.
* **tx_probe** (232 Б): `tx_probe__send_probe_resp` («Sending probe…»), `tx_probe__send_probe_req`.  
  Блоки: `tx_probe__send_probe_resp` 0x8f8c8c, `tx_probe__send_probe_req` 0x8f8cf8.
* **link_stats_sm** (228 Б): таймеры задержки и отчёта, `link_stats__mcs_to_rate_mbps`.  
  Блоки: `link_stats__mcs_to_rate_mbps` 0x8ddd50, `link_stats_sm__arm_latency_timer` 0x8e4734, `link_stats_sm__arm_report_timer` 0x8e4910.
* **ka_necessity_detector** (212 Б): `ka_necessity_detector__start_monitoring` — старт детектора keep-alive.  
  Блоки: `ka_necessity_detector__start_monitoring` 0x8e7af0.
* **stream_mgr** (204 Б): мелкие аксессоры и хвосты.  
  Блоки: `stream_mgr__ba_disable` 0x8c4200, `stream_mgr__pring_by_index` 0x8da0dc, `STREAM_MGR__ready_for_modify` 0x8e2348.
* **hw_drivers_mac** (200 Б): мелкие аксессоры и хвосты.  
  Блоки: `hwd_mac__set_power_mode_map` 0x8d0f40, `hwd_mac__uses_rgf_886200` 0x8d0fb4, `hwd_mac__sxd_mode_neutral` 0x8d0fe0, `hwd_mac__sxd_rx_mode_entry` 0x8d0ff8.
* **hw_drivers_car** (184 Б): мелкие аксессоры и хвосты.  
  Блоки: `car__enable_pll3_and_wait` 0x8d0320.
* **frame_builder** (184 Б): мелкие аксессоры и хвосты.  
  Блоки: `ie__push_raw` 0x8e1ff0, `frame_builder__assoc_resp_fix_fields` 0x8f4f20.
* **rx_macq** (180 Б): `rx_macq__bind_all_queues`, `rx_macq__program_ba_win`.  
  Блоки: `rx_macq__bind_all_queues` 0x8e1298, `rx_macq__program_ba_win` 0x8e37fc.
* **find_mngr** (164 Б): `find_mngr__cfg_offload` («Offload configured with BI, mode»), `…listen_end`, `…search_end`.  
  Блоки: `find_mngr__cfg_offload` 0x8c6b88, `find_mngr__listen_end` 0x8daff0, `find_mngr__search_end` 0x8e4c8c.
* **hw_drivers_sdp** (164 Б): проверки порта SDP: `SDP__hwd_sdp_is_defined_mode/_sdp`, `…is_gpio_sdp`, `…is_int_ctrl_sdp`.  
  Блоки: `SDP__hwd_sdp_is_defined_mode` 0x8f4330, `SDP__hwd_sdp_is_defined_sdp` 0x8f4354, `SDP__hwd_sdp_is_gpio_sdp` 0x8f4378, `SDP__hwd_sdp_is_int_ctrl_sdp` 0x8f43a4.
* **sm_pring_connectivity** (156 Б): мелкие аксессоры и хвосты.  
  Блоки: `sm_pring__connectivity_update` 0x8ea254, `sm_pring__slot_optimized` 0x8ea298.
* **rx_queue** (152 Б): `ese__set_alloc_type` — тип аллокации ESE в RX-правиле.  
  Блоки: `ese__set_alloc_type` 0x8e4220.
* **discovery** (144 Б): `find_mngr__enter_listen` / `…enter_search` (WMI start listen/search).  
  Блоки: `find_mngr__enter_listen` 0x8f5f14, `find_mngr__enter_search` 0x8f852c.
* **fwq_tx_availability** (128 Б): мелкие аксессоры и хвосты.  
  Блоки: `FWQ_TX_AVAILABILITY__remove_packet` 0x8e26a4.
* **operational_if** (124 Б): мелкие аксессоры и хвосты.  
  Блоки: `operational_if__mbox_init` 0x8d9f00.
* **connection** (104 Б): мелкие аксессоры и хвосты.  
  Блоки: `connection__on_bf_result` 0x8c54ec.
* **sta_psc_sm** (92 Б): мелкие аксессоры и хвосты.  
  Блоки: `sta_psc_sm__psc_req_tx_complete` 0x8e19b0, `sta_psc_sm__send_psc_req_flow_sm` 0x8e5bc0.
* **calib_mngr** (92 Б): мелкие аксессоры и хвосты.  
  Блоки: `calib_mgr_ut` 0x8eadb8.
* **pcp_psc_sm** (72 Б): мелкие аксессоры и хвосты.  
  Блоки: `pcp_psc_sm__send_psc_resp_flow` 0x8e5c98.
* **rm_ch_switch_sm** (64 Б): мелкие аксессоры и хвосты.  
  Блоки: `rm_ch_switch_sm__fwtx_channel_stopped` 0x8cb6a8.
* **tx_bcon** (52 Б): мелкие аксессоры и хвосты.  
  Блоки: `conn__snapshot_step` 0x8c28d0.
* **dashboard** (52 Б): мелкие аксессоры и хвосты.  
  Блоки: `sw_vring__ba_params` 0x8eabc8.
* **ba_setup_sm** (52 Б): мелкие аксессоры и хвосты.  
  Блоки: `ba_setup_sm__close_ba_setup_global_timeout` 0x8f1bfc.
* **maintain_sm** (44 Б): мелкие аксессоры и хвосты.  
  Блоки: `maintain_sm__set_rs_params` 0x8f1cdc.
* **hw_drivers_user_led** (24 Б): мелкие аксессоры и хвосты.  
  Блоки: `user_led__prepare_halt` 0x8da774.
* **rx_mgmt_prs** (12 Б): мелкие аксессоры и хвосты.  
  Блоки: `rx_mgmt_prs__alloc_ei_default` 0x8e3c3c.

## Приложение А. Имена блоков в файлах данных ref/

Часть блоков в [NAMES-EXTRA.txt](../ref/NAMES-EXTRA.txt),
[ANNO-fw.json](../ref/ANNO-fw.json) и RELOCS-fw.txt записана под другими
именами, чем в дереве исходников. Соответствие:

| адрес | имя в дереве | имя в файлах данных | назначение |
|---|---|---|---|
| 0x8c3248 | `u_schd__add` | `power_mngr__deep_sleep_step` | постановка задачи ([SCHEDULER](../../docs/SCHEDULER.md)) |
| 0x8e0c0c | `u_schd__schedule` | `ut_module_hw_flows__args` | постановка отложенной задачи ([SCHEDULER](../../docs/SCHEDULER.md)) |
| 0x8c8de0 | `u_schd__cancel` | `uses_g_803c54__8c8de0` | отмена таймера ([SCHEDULER](../../docs/SCHEDULER.md)) |
| 0x8cc534 | `u_schd__pop_ready` | `rm_main_sm__get_next_request` | выборка готовой задачи ([SCHEDULER](../../docs/SCHEDULER.md)); `rm_main_sm__get_next_request` в дереве — 0x8cc5e0 |
| 0x8c47e0 | `conn_main_sm__inject_bcon_rx` | `conn_main_sm__bcon_rx_timeout_evt` | впрыск SM_EVT_BCON_RX ([MLME §5](../../docs/MLME.md#5-приём-management-кадра-discovery-и-dmg-маяка-код)); `conn_main_sm__bcon_rx_timeout_evt` в дереве — 0x8c4804 |
| 0x8f55b8 | `l2mgr__init` | `l2mgr__oob_mode` | инициализация L2 ([L2-MANAGER §1](../../docs/L2-MANAGER.md#1-инициализация-l2-код)) |
| 0x8e1354 | `sm_obj__reset_evt5` | `tail_basic_sm__handle_event_8e1354` | впрыск события автомата ([L2-MANAGER §9](../../docs/L2-MANAGER.md#9-wmi-обработчики-и-настройка-bss)) |
| 0x8c9790 | `hexdump_words` | `channels_switch_sm__dwell_timeout_cb` | дамп буфера ([DATAPATH §11](../../docs/DATAPATH.md#11-каталог-блоков-fw-управляющие-кадры-tx-api-очереди-обе)); колбэк стоянки — 0x8c980c |
| 0x8f6f7c | `pcie_serdes__shlicht_wa` | `pcp_bcon_wb` | настройка SerDes PCIe ([HW-DRIVERS §13](../../docs/HW-DRIVERS.md#13-каталог-блоков-pcie-режимы-питания-и-ps-обе)); `pcp_bcon_wb` — 0x8f6fec |
| 0x8f1920 | `sdp_gpio__personality_step` | `check_high_false_alarm_aging_cb` | personality порта SDP ([RADIO-MANAGER §7](../../docs/RADIO-MANAGER.md#7-прочее-группы)); колбэк ложных тревог — 0x8f1980 |
| 0x8ccb20 | `rf__get_active_index` | `get_g_800242_8ccb20` | геттер ([FW-UTILITIES §4](../../docs/FW-UTILITIES.md#4-геттеры-и-сеттеры-глобалов-и-регистров)) |
| 0x8d0d44 | `dmaq_hw__reset_ptrs` | `tail___ld_r13_to_r13_ret_8d0d44` | шаг STREAM_MGR ([DATAPATH §11](../../docs/DATAPATH.md#11-каталог-блоков-fw-управляющие-кадры-tx-api-очереди-обе)) |
| 0x8e378c, 0x8e37c8 | `mbox__drain_operational`, `mbox__drain_debug` | `mbox__init_operational`, `mbox__init_debug` (то же тело, что 0x8ded20/0x8ded5c в 4.1) | обработчики прерывания почтовых ящиков ([HW-DRIVERS §2.2](../../docs/HW-DRIVERS.md#22-user-icr-хоста-0x880b50-код)) |
| 0x8c6040 | `wmi_handler_get_rf_sector_params__check_inputs_valid` | `wmi_handler_get_rf_sector_params__check_in` (усечённое) | проверка входов WMI (§3) |
| 0x8c60d0 | `wmi_handler_set_rf_sector_params__verify_inputs` | `wmi_handler_set_rf_sector_params__verify_i` (усечённое) | проверка входов WMI (§3) |

## Не установлено

* Отправители LMAC-команд 0x28/0x2a/0x2e/0x37/0x3c и 0x29/0x2b/0x2f/0x38/0x3d
  ([MISC-UC](MISC-UC.md) §1).

## Источники

* Дерево исходников `6.2/src/asm/fw/` (блоки и имена), [SYMS.txt](../ref/SYMS.txt).
* [SM-TABLES.txt](../ref/SM-TABLES.txt), [FN-FILEMAP.txt](../ref/FN-FILEMAP.txt),
  [NAMES-EXTRA.txt](../ref/NAMES-EXTRA.txt), [REGS-62](../ref/REGS-62.md).
* [STATE-MACHINES](../../docs/STATE-MACHINES.md), [HW-DRIVERS](../../docs/HW-DRIVERS.md),
  [LMAC-PROTOCOL](../../docs/LMAC-PROTOCOL.md), [FIXED-SCHED](FIXED-SCHED.md), [BENCH](BENCH.md).
