# Диспетчер WMI-команд хоста (vendor `wmi__host_cmd_dispatch` 0x8de43c)

Порт: `fw/wmi_cmd.c:wmi_host_cmd_dispatch`. Не портированные обработчики — слабые
заглушки в `fw/wmi_handlers_todo.c` (прототипы — `include/wmi_handlers.h`), отсортированы
по vendor-адресу. Чтобы портировать обработчик: написать сильное определение с той же
сигнатурой в файле своей области и удалить заглушку (и строку из этой таблицы).

В SparRAW вырезаны сознательно и отвечают «не поддерживается»: энергосбережение 802.11
(0x960 UPM_CFG, power_mgr_ut — модуль 13 в 0x900) и PCIe (0x904/0x905); FTM/TOF/AoA — только
в SparRAW-pro. Устройство vendor-диспетчера ниже описано как у vendor.

## Устройство vendor-диспетчера

Вход: `r0 = obj` (ящик: operational 0x8041f0 или debug 0x843040), `r1 = cmd`.
Регистры дальше: `r15 = obj`, `r16 = cmd`, `r14 = mid = cmd[8]` (ldb), `r13 = тело = cmd + 0x10`.

1. `flags = ldw [cmd+6]`: бит 1 → `fw_sysassert_fatal(blink, 0x1036)`, бит 2 →
   `fw_sysassert_fatal(blink, 0x1037)` (оба возвращаются, разбор продолжается).
2. `host_if__hw_ready_for_wmi` (0x8da5a4) = 0: id 1 → `host_if__connect_rf_kill(тело, mid)`
   (0x8ec484), id 7 → `host_if__send_scan_complete(mid)` (0x8ecb94); обе — выход.
   Прочие id идут в общий разбор.
3. `id = ldh [cmd+0xa]` (без знака). Дерево сравнений + 9 таблиц переходов
   (`ldh.as.x r2,[tbl, id − lo]` — знаковое полуслово, `r0 = pcl + k` = адрес сразу после
   `j_s`, `add1_s r0,r0,r2` → цель = база + 2·запись). Записи совпадают с
   `6.2/ref/JUMPTABLES-fw.txt` и перепроверены по образу (fw_data 0x900000 → 0x800000):

   | таблица | id | база |
   |---|---|---|
   | 0x802064 | 0x001..0x017 | 0x8de502 |
   | 0x802094 | 0x808..0x829 | 0x8de520 |
   | 0x8020d8 | 0x835..0x85d | 0x8de556 |
   | 0x80212c | 0x85f..0x866 | 0x8de580 |
   | 0x80213c | 0x900..0x911 | 0x8de5a8 |
   | 0x802160 | 0x914..0x924 | 0x8de5e2 |
   | 0x802184 | 0x993..0x998 | 0x8de670 |
   | 0x802190 | 0x9a1..0x9a5 | 0x8de6a8 |
   | 0x80219c | 0xa06..0xa0f | 0x8de744 |

   Отдельными сравнениями: 0x3f, 0x42, 0x803, 0x804, 0x82a, 0x82b, 0x85e, 0x867, 0x868,
   0x913, 0x930, 0x931, 0x935, 0x936, 0x960, 0x991, 0x992, 0x9a0, 0x9a6, 0x9a7, 0x9aa,
   0xa01..0xa05, 0xfff, 0xf003, 0xf007, 0xf049, 0xf04d, 0xf04e, 0xf04f.
4. Типовой case: `fw_log_emit0(0x20, «---->> [HOST CMD] WMI_xxx_CMDID»)`, затем обработчик.
   Без журнала: 0x80e, 0x849, 0x862, 0x863, 0x864, 0x900, 0x991, 0xa07, 0xfff.
   С аргументами: 0x1 — `emit1(…, [0x8000cc])`, 0x7 — `emit1(…, [0x8000d0])`,
   0x9a2 — `emit2(тело[0], тело[1])`, 0x9a3 — `emit3(тело[0], тело[1], ldh тело[2])`.
5. Особые case:
   - 0xa, 0x835 — запись таблицы указывает прямо на выход: команда молча поглощается.
   - 0x993/0x994/0x995 (TOF LCR/LCI/CHANNEL_INFO) — только журнал, обработчика нет.
   - 0x991 — `mac_read_tsf64(0, sp, 0)` (результат не используется), затем `tof_ftm_req(тело)`.
   - 0x9a0/0x9a1 — при первом вызове (`[0x8004c4]`/`[0x8004c5]` = 1 в fw_data) флаг
     сбрасывается и объект 0x80483c / 0x804848 обнуляется (0x8c1848 / 0x8c1854); затем
     `set(obj, тело, ящик)`, при ненуле — `handle(obj)`. 0x9a2/0x9a3 — то же без сброса,
     объекты 0x804914 / 0x80491c, продолжение — `lmac_if_send_*_selected_rf_sector_index`.
   - 0x905 — `wmi_traffic_resume` (0x8ecf48) = переход в `l2mgr__send_traffic_resume_evt(0x803d10)`
     (у нас вырезано вместе с энергосбережением PCIe).
6. Неизвестный id (все «дыры» таблиц и промахи сравнений) → 0x8df066:
   `wmi_evt__send_command_not_supported(obj, id, 0, mid)` (0x8e5728, событие 0xffff).
7. Выход (0x8df070): `*ring[0] = 0` (sync слота, `ring = obj + 0x24`), `lmac_if__evt_fields(ring)`.

Всего vendor обрабатывает **102** id: 26 — готово (21 с портированным обработчиком,
из них 0x900 частично; 5 — no-op/только журнал), **76** — через заглушки (80 заглушек:
у 0x9a0..0x9a3 по две функции).

## Заглушки

- Ответ vendor простой (wmi_evt__post / low_sme__send_evt2sw, постоянная длина) — заглушка
  шлёт то же событие с **нулевым телом** (т. е. статус 0 = «успех» без реальной работы!).
  mid — из аргумента, если vendor его передаёт, иначе 0.
- Иначе (ответа нет, асинхронный, переменной длины, или ложный «успех» опасен —
  RF_XPM_WRITE) — `WMI_COMMAND_NOT_SUPPORTED` (как до этого порта).
- 0x991 (TOF_SESSION_START) — как ветка отказа vendor: 0x1991 {session_id, status 2}.
- Глобальных переменных у заглушек нет (свой .bss пуст: fw_data — вендорский).

## Таблица

Размер — по `6.2/ref/SYMS.txt` (байты / число инструкций в fw62.asm). Имя — NAMES-EXTRA
(поздняя запись); имя WMI — из wil6210 `wmi.h` или из журнальной строки vendor.

| id | WMI | vendor | имя (NAMES-EXTRA) | статус | размер |
|---|---|---|---|---|---|
| 0x0001 | WMI_CONNECT_CMDID | 0x8ec434 | wmi_connect | ported: wmi_cmd.c:wmi_connect | 78 Б / ~29 |
| 0x0003 | WMI_DISCONNECT_CMDID | 0x8ec4ec | wmi_disconnect | ported: wmi_cmd.c:wmi_disconnect | 90 Б / ~29 |
| 0x0004 | WMI_DISCONNECT_STA_CMDID | 0x8ec4f4 | wmi_disconnect_sta | ported: wmi_cmd.c:wmi_disconnect_sta → conn.c:l2mgr_disconnect_sta (0x8c93a0) | 12 Б / ~5 |
| 0x0007 | WMI_START_SCAN_CMDID | 0x8ecb1c | low_sme::wmi_scan_cmd_handler | ported: wmi_cmd.c:low_sme_wmi_scan_cmd_handler | 120 Б / ~44 |
| 0x000a | WMI_SET_PROBED_SSID_CMDID | — | — | complete: таблица → сразу выход, без журнала и ответа | — |
| 0x000f | WMI_BCON_CTRL_CMDID | 0x8ec840 | wmi_pcp_start_cmd_handler | ported: wmi_h_pcp.c:wmi_bcon_ctrl | 218 Б / ~74 |
| 0x0016 | WMI_ADD_CIPHER_KEY_CMDID | 0x8fbf7c | wmi_add_cipher_key | ported: wmi_h_sta.c:wmi_add_cipher_key | 414 Б / ~132 |
| 0x0017 | WMI_DELETE_CIPHER_KEY_CMDID | 0x8ec4bc | wmi_delete_cipher_key | ported: wmi_h_sta.c:wmi_delete_cipher_key | 48 Б / ~20 |
| 0x003f | WMI_SET_APPIE_CMDID | 0x8ecdc8 | wmi__set_app_ie_thunk | ported: wmi_cmd.c:l2mgr_set_app_ie (переход → 0x8fbb90) | 4 Б / ~1 |
| 0x0042 | WMI_PXMT_RANGE_CFG_CMDID | 0x8ec9d0 | wmi_pxmt_range_cfg | ported: wmi_h_misc.c:wmi_pxmt_range_cfg | 22 Б / ~8 |
| 0x0803 | WMI_ECHO_CMDID | 0x8e5418 | beacon_interval | ported: wmi_cmd.c:wmi_echo_rsp | 90 Б / ~31 |
| 0x0804 | WMI_DEEP_ECHO_CMDID | 0x8c87a4 | wmi_deep_echo | ported: wmi_h_misc.c:wmi_deep_echo | 26 Б / ~10 |
| 0x0808 | WMI_ADD_DEBUG_TX_PCKT_CMDID | 0x8e55ac | wmi_add_debug_tx_pckt | ported: wmi_h_misc.c:wmi_add_debug_tx_pckt | 114 Б / ~39 |
| 0x080e | WMI_TEMP_SENSE_CMDID | 0x8e909c | wmi__cmd_arg_check | ported: wmi_h_sta.c:wmi_temp_sense | 114 Б / ~40 |
| 0x0820 | WMI_CFG_RX_CHAIN_CMDID | 0x8fb7fc | wmi_cfg_rx_chain | ported: wmi_cmd.c:wmi_cfg_rx_chain | 802 Б / ~258 |
| 0x0821 | WMI_VRING_CFG_CMDID | 0x8fc198 | wmi_vring_cfg | ported: tx.c:wmi_vring_cfg | 460 Б / ~145 |
| 0x0822 | WMI_BCAST_VRING_CFG_CMDID | 0x8fb4e0 | wmi_bcast_vring_cfg | ported: wmi_h_pcp.c:wmi_bcast_vring_cfg | 184 Б / ~65 |
| 0x0823 | WMI_RING_BA_EN_CMDID | 0x8fb4b4 | wmi_vring_ba_en | ported: ba.c:wmi_vring_ba_en | 44 Б / ~15 |
| 0x0824 | WMI_RING_BA_DIS_CMDID | 0x8fb490 | wmi_vring_ba_dis | ported: ba.c:wmi_vring_ba_dis | 34 Б / ~11 |
| 0x0825 | WMI_RCP_ADDBA_RESP_CMDID | 0x8ecbe8 | wmi_rcp_addba_resp | ported: ba.c:wmi_rcp_addba_resp | 308 Б / ~101 |
| 0x0826 | WMI_RCP_DELBA_CMDID | 0x8ecd1c | wmi_rcp_delba | ported: ba.c:wmi_rcp_delba | 172 Б / ~65 |
| 0x0827 | WMI_SET_SSID_CMDID | 0x8fbcec | l2_mgr::wmi_cmd_handler_set_ssid | ported: wmi_cmd.c:l2mgr_set_ssid | 46 Б / ~16 |
| 0x0828 | WMI_GET_SSID_CMDID | 0x8ec264 | wmi_get_ssid | ported: wmi_h_sta.c:wmi_get_ssid | 84 Б / ~30 |
| 0x0829 | WMI_SET_PCP_CHANNEL_CMDID | 0x8fbcc4 | wmi_set_pcp_channel | ported: wmi_h_pcp.c:wmi_set_pcp_channel | 40 Б / ~13 |
| 0x082a | WMI_GET_PCP_CHANNEL_CMDID | 0x8fb5ec | wmi_get_pcp_channel | ported: wmi_h_pcp.c:wmi_get_pcp_channel | 92 Б / ~32 |
| 0x082b | WMI_SW_TX_REQ_CMDID | 0x8fbe18 | wmi_sw_tx_req | ported: wmi_h_pcp.c:wmi_sw_tx_req | 354 Б / ~122 |
| 0x0835 | WMI_MLME_PUSH_CMDID | — | — | complete: таблица → сразу выход, без журнала и ответа | — |
| 0x0836 | WMI_BEAMFORMING_MGMT_CMDID | 0x8dcfa8 | wmi_beamforming_mgmt | ported: wmi_h_bf.c:wmi_beamforming_mgmt | 128 Б / ~44 |
| 0x083a | WMI_BF_TRIG_CMDID | 0x8fc11c | wmi_trigger_beamforming_cmdid | ported: wmi_h_bf.c:wmi_trigger_beamforming | 122 Б / ~39 |
| 0x0842 | WMI_LINK_MAINTAIN_CFG_WRITE_CMDID | 0x8ec7f8 | wmi_link_maintain_cfg_write | ported: wmi_h_sta.c:wmi_link_maintain_cfg_write | 72 Б / ~25 |
| 0x0843 | WMI_LINK_MAINTAIN_CFG_READ_CMDID | 0x8ec7b0 | wmi_link_maintain_cfg_read | ported: wmi_h_sta.c:wmi_link_maintain_cfg_read | 70 Б / ~24 |
| 0x0849 | WMI_SET_SECTORS_CMDID | 0x8dd64c | host_if__set_sectors_hal | ported: wmi_h_bf.c:host_if_set_sectors_hal | 134 Б / ~43 |
| 0x0853 | WMI_RF_MGMT_CMDID | 0x8ec9e8 | low_sme::wmi_rf_mgmt_cmd_handler | ported: wmi_h_misc.c:low_sme_wmi_rf_mgmt_cmd_handler | 84 Б / ~29 |
| 0x0856 | WMI_RF_XPM_READ_CMDID | 0x8e363c | host_if::read_rf_xpm_handler | ported: wmi_h_misc.c:host_if_read_rf_xpm | 144 Б / ~50 |
| 0x0857 | WMI_RF_XPM_WRITE_CMDID | 0x8e36cc | host_if::write_rf_xpm_handler | ported: wmi_h_misc.c:host_if_write_rf_xpm | 152 Б / ~51 |
| 0x085c | WMI_SET_ACTIVE_SILENT_RSSI_TABLE_CMDID | 0x8e6120 | wmi_set_active_silent_rssi_table | ported: wmi_h_bf.c:wmi_set_active_silent_rssi_table | 88 Б / ~33 |
| 0x085d | WMI_RF_PWR_ON_DELAY_CMDID | 0x8e6e40 | wmi_rf_pwr_on_delay | ported: wmi_h_misc.c:wmi_rf_pwr_on_delay | 74 Б / ~26 |
| 0x085e | WMI_SET_HIGH_POWER_TABLE_PARAMS_CMDID | 0x8ec3f0 | wmi_set_high_power_table_params | ported: wmi_h_bf.c:wmi_set_high_power_table_params | 68 Б / ~25 |
| 0x085f | WMI_FIXED_SCHEDULING_UL_CONFIG_CMDID | 0x8ec5fc | wmi_fixed_scheduling_ul_config | ported: wmi_h_bf.c:wmi_fixed_scheduling_ul_config | 142 Б / ~50 |
| 0x0862 | WMI_BF_CTRL_CMDID | 0x8dd028 | host_if__bf_ctrl_hal | ported: wmi_h_bf.c:host_if_bf_ctrl_hal | 62 Б / ~22 |
| 0x0863 | WMI_NOTIFY_REQ_CMDID | 0x8dd4b8 | wmi__bump_cmd_counter | ported: wmi_h_sta.c:wmi_notify_req | 110 Б / ~41 |
| 0x0864 | WMI_GET_STATUS_CMDID | 0x8cccbc | host_if__get_status_hal | ported: wmi_h_sta.c:host_if_get_status_hal | 344 Б / ~115 |
| 0x0866 | WMI_GET_RF_STATUS_CMDID | 0x8dd3c8 | wmi_get_rf_status | ported: wmi_h_sta.c:wmi_get_rf_status | 240 Б / ~75 |
| 0x0867 | WMI_GET_BASEBAND_TYPE_CMDID | 0x8dd29c | wmi_get_baseband_type | ported: wmi_h_sta.c:wmi_get_baseband_type | 116 Б / ~37 |
| 0x0868 | WMI_VRING_SWITCH_TIMING_CONFIG_CMDID | 0x8e7340 | wmi_vring_switch_config | ported: wmi_h_bf.c:wmi_vring_switch_config | 74 Б / ~28 |
| 0x0900 | WMI_UNIT_TEST_CMDID | 0x8ed038 | wmi_ut_handler | partial: wmi.c:wmi_ut_handler — только module 11 (UT_HW_DRIVERS), без журналов vendor | 104 Б / ~33 |
| 0x0904 | WMI_TRAFFIC_SUSPEND_CMDID | 0x8ecf1c | POWER_MNGR::wmi_traffic_deferral_cmd | cut: «не поддерживается» — энергосбережение PCIe вырезано (fw/vectors.c pcie_pm_event_unsupported) | 42 Б / ~13 |
| 0x0905 | WMI_TRAFFIC_RESUME_CMDID | 0x8e055c | l2mgr__send_traffic_resume_evt | cut: «не поддерживается» — энергосбережение PCIe вырезано (fw/vectors.c pcie_pm_event_unsupported) | 86 Б / ~29 |
| 0x0910 | WMI_P2P_CFG_CMDID | 0x8fb69c | l2_mgr::wmi_cmd_handler_p2p_cfg | ported: wmi_h_pcp.c:l2mgr_p2p_cfg | 154 Б / ~50 |
| 0x0911 | WMI_PORT_ALLOCATE_CMDID | 0x8fb77c | wmi_port_allocate | ported: wmi_h_pcp.c:wmi_port_allocate | 126 Б / ~41 |
| 0x0913 | WMI_POWER_MGMT_CFG_CMDID | 0x8ec358 | wmi__power_mgmt_cfg_thunk | ported: wmi_cmd.c:wmi_power_mgmt_cfg ([0x80011c] = body[0]) | 4 Б / ~1 |
| 0x0914 | WMI_START_LISTEN_CMDID | 0x8fbd3c | l2_mgr::wmi_cmd_handler_start_listen | ported: wmi_h_pcp.c:l2mgr_start_listen | 84 Б / ~27 |
| 0x0915 | WMI_START_SEARCH_CMDID | 0x8fbd90 | l2_mgr::wmi_cmd_handler_start_search | ported: wmi_h_pcp.c:l2mgr_start_search | 84 Б / ~27 |
| 0x0916 | WMI_DISCOVERY_START_CMDID | 0x8fbd1c | l2mgr__start_discovery | ported: wmi_h_pcp.c:l2mgr_start_discovery | 32 Б / ~11 |
| 0x0917 | WMI_DISCOVERY_STOP_CMDID | 0x8fbde4 | l2mgr__stop_discovery | ported: wmi_h_pcp.c:l2mgr_stop_discovery | 50 Б / ~14 |
| 0x0918 | WMI_PCP_START_CMDID | 0x8ec91c | wmi_pcp_start | ported: wmi_h_pcp.c:wmi_pcp_start | 84 Б / ~31 |
| 0x0919 | WMI_PCP_STOP_CMDID | 0x8f7160 | l2_mgr::pcp_stop | ported: rf_kill.c:l2mgr_pcp_stop | 170 Б / ~56 |
| 0x091b | WMI_GET_PCP_FACTOR_CMDID | 0x8fb648 | wmi_get_pcp_factor | ported: wmi_h_pcp.c:wmi_get_pcp_factor | 82 Б / ~25 |
| 0x091c | WMI_PS_DEV_PROFILE_CFG_CMDID | 0x8ec970 | POWER_MNGR::wmi_ps_dev_profile_cfg_cmd | changed: wmi_cmd.c:wmi_ps_dev_profile_cfg — DEFAULT/PS_DISABLED → 0, остальное → 1 (PS вырезан) | 96 Б / ~33 |
| 0x0921 | WMI_RS_CFG_CMDID | 0x8dd528 | wmi_rs_cfg | ported: wmi_h_bf.c:wmi_rs_cfg | 132 Б / ~47 |
| 0x0922 | WMI_GET_DETAILED_RS_RES_CMDID | 0x8dd310 | wmi_get_detailed_rs_res | ported: wmi_h_bf.c:wmi_get_detailed_rs_res | 182 Б / ~62 |
| 0x0923 | WMI_AOA_MEAS_CMDID | 0x8e9580 | wmi_aoa_meas | cut: «не поддерживается» — только SparRAW-pro | 122 Б / ~43 |
| 0x0924 | WMI_BRP_SET_ANT_LIMIT_CMDID | 0x8dd068 | wmi_brp_set_ant_limit | ported: wmi_h_bf.c:wmi_brp_set_ant_limit | 102 Б / ~36 |
| 0x0930 | WMI_SET_MGMT_RETRY_LIMIT_CMDID | 0x8ec35c | l2_mgr::wmi_cmd_handler_set_mgmt_retry_limit | ported: wmi_cmd.c:wmi_set_mgmt_retry_limit | 130 Б / ~45 |
| 0x0931 | WMI_GET_MGMT_RETRY_LIMIT_CMDID | 0x8ec200 | l2_mgr::wmi_cmd_handler_get_mgmt_retry_limit | ported: wmi_cmd.c:wmi_get_mgmt_retry_limit | 100 Б / ~34 |
| 0x0935 | WMI_NEW_STA_CMDID | 0x8ec2b8 | l2_mgr::wmi_cmd_handler_new_sta | ported: wmi_h_sta.c:l2mgr_new_sta | 146 Б / ~52 |
| 0x0936 | WMI_DEL_STA_CMDID | 0x8ec184 | l2_mgr::wmi_cmd_handler_del_sta | ported: wmi_h_sta.c:l2mgr_del_sta | 124 Б / ~42 |
| 0x0960 | WMI_UPM_CFG_CMDID | 0x8dc3f4 | lmac_if_upm_cfg_handler | cut: «не поддерживается» — энергосбережение вырезано (fw/action.c psc_req_reject) | 58 Б / ~20 |
| 0x0991 | WMI_TOF_SESSION_START_CMDID | 0x8e9620 | l2_mgr::tof_ftm_req | cut: «не поддерживается» — только SparRAW-pro | 96 Б / ~33 |
| 0x0992 | WMI_TOF_GET_CAPABILITIES_CMDID | 0x8e975c | l2_mgr::tof_get_capabilities | cut: «не поддерживается» — только SparRAW-pro | 82 Б / ~30 |
| 0x0993 | WMI_TOF_SET_LCR_CMDID | — | — | cut: «не поддерживается» — только SparRAW-pro | — |
| 0x0994 | WMI_TOF_SET_LCI_CMDID | — | — | cut: «не поддерживается» — только SparRAW-pro | — |
| 0x0995 | WMI_TOF_CHANNEL_INFO_CMDID | — | — | cut: «не поддерживается» — только SparRAW-pro | — |
| 0x0996 | WMI_TOF_CFG_RESPONDER_CMDID | 0x8e95fc | l2_mgr::tof_config_responder | cut: «не поддерживается» — только SparRAW-pro | 34 Б / ~11 |
| 0x0997 | WMI_TOF_SET_TX_RX_OFFSET_CMDID | 0x8e71a8 | wmi_tof_set_tx_rx_offset | cut: «не поддерживается» — только SparRAW-pro | 86 Б / ~30 |
| 0x0998 | WMI_TOF_GET_TX_RX_OFFSET_CMDID | 0x8ccf7c | wmi_tof_get_tx_rx_offset | cut: «не поддерживается» — только SparRAW-pro | 92 Б / ~32 |
| 0x09a0 | WMI_GET_RF_SECTOR_PARAMS_CMDID | 0x8e5e00 | wmi_handler_get_rf_sector_params::set | ported: wmi_h_bf.c:get_rf_sector_params_set | 130 Б / ~51 |
| 0x09a0 | WMI_GET_RF_SECTOR_PARAMS_CMDID | 0x8cd104 | wmi_handler_get_rf_sector_params::handle | ported: wmi_h_bf.c:get_rf_sector_params_handle | 70 Б / ~22 |
| 0x09a1 | WMI_SET_RF_SECTOR_PARAMS_CMDID | 0x8e5e84 | wmi_handler_set_rf_sector_params::set | ported: wmi_h_bf.c:set_rf_sector_params_set | 136 Б / ~51 |
| 0x09a1 | WMI_SET_RF_SECTOR_PARAMS_CMDID | 0x8cd14c | wmi_handler_set_rf_sector_params::handle | ported: wmi_h_bf.c:set_rf_sector_params_handle | 74 Б / ~22 |
| 0x09a2 | WMI_GET_SELECTED_RF_SECTOR_INDEX_CMDID | 0x8e5f44 | wmi_get_selected_rf_sector_index | ported: wmi_h_bf.c:get_selected_rf_sector_index_set | 110 Б / ~40 |
| 0x09a2 | WMI_GET_SELECTED_RF_SECTOR_INDEX_CMDID | 0x8cd198 | lmac_if_send_get_selected_rf_sector_index | ported: wmi_h_bf.c:lmac_if_send_get_selected_rf_sector_index | 38 Б / ~14 |
| 0x09a3 | WMI_SET_SELECTED_RF_SECTOR_INDEX_CMDID | 0x8e5fb4 | wmi_set_selected_rf_sector_index | ported: wmi_h_bf.c:set_selected_rf_sector_index_set | 110 Б / ~40 |
| 0x09a3 | WMI_SET_SELECTED_RF_SECTOR_INDEX_CMDID | 0x8cd1c0 | lmac_if_send_set_selected_rf_sector_index | ported: wmi_h_bf.c:lmac_if_send_set_selected_rf_sector_index | 38 Б / ~14 |
| 0x09a4 | WMI_SET_RF_SECTOR_ON_CMDID | 0x8eceb8 | wmi_set_rf_sector_on_cmd_handler | ported: wmi_h_bf.c:wmi_set_rf_sector_on | 100 Б / ~33 |
| 0x09a5 | WMI_PRIO_TX_SECTORS_ORDER_CMDID | 0x8ecfec | wmi_prio_tx_sectors_order | ported: wmi_h_bf.c:wmi_prio_tx_sectors_order | 76 Б / ~27 |
| 0x09a6 | WMI_PRIO_TX_SECTORS_NUMBER_CMDID | 0x8ecfa0 | wmi_prio_tx_sectors_number | ported: wmi_h_bf.c:wmi_prio_tx_sectors_number | 76 Б / ~27 |
| 0x09a7 | WMI_PRIO_TX_SECTORS_SET_DEFAULT_CFG_CMDID | 0x8ecf54 | wmi_prio_tx_sectors_set_default_cfg | ported: wmi_h_bf.c:wmi_prio_tx_sectors_set_default_cfg | 76 Б / ~27 |
| 0x09aa | WMI_BF_CONTROL_CMDID | 0x8ec068 | wmi_bf_control | ported: wmi_h_bf.c:wmi_bf_control | 284 Б / ~105 |
| 0x0a01 | WMI_SCHEDULING_SCHEME_CMDID | 0x8fbb20 | wmi_ese_cfg | ported: wmi_h_bf.c:wmi_ese_cfg | 110 Б / ~39 |
| 0x0a02 | WMI_FIXED_SCHEDULING_CONFIG_CMDID | 0x8ec56c | wmi_fixed_scheduling_config | ported: wmi_h_bf.c:wmi_fixed_scheduling_config | 144 Б / ~55 |
| 0x0a03 | WMI_ENABLE_FIXED_SCHEDULING_CMDID | 0x8ec500 | wmi_enable_fixed_scheduling | ported: wmi_h_bf.c:wmi_enable_fixed_scheduling | 108 Б / ~34 |
| 0x0a04 | WMI_SET_MULTI_DIRECTED_OMNIS_CONFIG_CMDID | 0x8ece20 | wmi_set_multi_directed_omnis_config_cmd | ported: wmi_h_bf.c:wmi_set_multi_directed_omnis_config | 66 Б / ~24 |
| 0x0a05 | WMI_SET_LONG_RANGE_CONFIG_CMDID | 0x8ecdcc | wmi_set_long_range | ported: wmi_h_bf.c:wmi_set_long_range | 80 Б / ~29 |
| 0x0a06 | WMI_GET_ASSOC_LIST_CMDID | 0x8ec68c | wmi_get_assoc_list | ported: wmi_h_sta.c:wmi_get_assoc_list | 150 Б / ~48 |
| 0x0a07 | WMI_GET_CCA_INDICATIONS_CMDID | 0x8fb598 | wmi__post_pct_stats_evt | ported: wmi_h_sta.c:wmi_get_cca_indications | 82 Б / ~31 |
| 0x0a08 | WMI_SET_CCA_INDICATIONS_BI_AVG_NUM_CMDID | 0x8fbbe8 | wmi_set_cca_indications_bi_avg_num | ported: wmi_h_bf.c:wmi_set_cca_indications_bi_avg_num | 124 Б / ~43 |
| 0x0a0e | WMI_SET_GRANT_MCS_CMDID | 0x8e66ac | wmi_set_grant_mcs | ported: wmi_h_bf.c:wmi_set_grant_mcs | 86 Б / ~33 |
| 0x0a0f | WMI_SET_AP_SLOT_SIZE_CMDID | 0x8e6178 | wmi_set_ap_slot_size | ported: wmi_h_bf.c:wmi_set_ap_slot_size | 70 Б / ~26 |
| 0x0fff | (0xfff) | 0x8dc4d8 | orig_fract | ported: wmi_h_misc.c:wmi_dbg_cmd_fff | 226 Б / ~68 |
| 0xf003 | WMI_SET_MAC_ADDRESS_CMDID | 0x8ece1c | wmi__set_mac_address_thunk | ported: wmi_cmd.c:l2mgr_set_mac_address (переход → 0x8fbc64) | 4 Б / ~1 |
| 0xf007 | WMI_ABORT_SCAN_CMDID | 0x8eca3c | wmi_abort_scan | ported: wmi_cmd.c:wmi_abort_scan | 28 Б / ~9 |
| 0xf049 | WMI_SET_PASSPHRASE_CMDID | 0x8ece64 | wmi_set_passphrase_handler | ported: wmi_h_sta.c:wmi_set_passphrase_handler | 82 Б / ~27 |
| 0xf04d | WMI_MAC_ADDR_REQ_CMDID | 0x8ec724 | wmi_mac_addr_req | ported: wmi_h_sta.c:wmi_mac_addr_req | 138 Б / ~49 |
| 0xf04e | WMI_FW_VER_CMDID | 0x8dd130 | wmi_fw_ver | ported: wmi_h_sta.c:wmi_fw_ver | 364 Б / ~116 |
| 0xf04f | WMI_PMC_CMDID | 0x8fb738 | wmi_pmc | ported: wmi_h_misc.c:wmi_pmc | 66 Б / ~23 |

## Разбивка по областям (2026-10-18: все заглушки заменены портами — wmi_h_sta.c, wmi_h_pcp.c,
## wmi_h_bf.c, wmi_h_misc.c; остаются UT-модули 9–12 команды 0x900, см. wmi.c)

- **Станции/статистика/связь** (нужно для `iw station dump`, AP-режима): 0x863 NOTIFY_REQ
  (0x8dd4b8), 0x864 GET_STATUS (0x8cccbc), 0xa06 GET_ASSOC_LIST, 0xa07 GET_CCA_INDICATIONS,
  0x935/0x936 NEW/DEL_STA, 0x842/0x843 LINK_MAINTAIN_CFG, 0x828 GET_SSID, 0xf04d MAC_ADDR_REQ,
  0xf04e FW_VER, 0x866 GET_RF_STATUS, 0x867 GET_BASEBAND_TYPE, 0x80e TEMP_SENSE.
- **Безопасность**: 0x16 ADD_CIPHER_KEY (414 Б), 0x17 DELETE_CIPHER_KEY (только журнал),
  0xf049 SET_PASSPHRASE.
- **PCP/AP, discovery, P2P**: 0xf BCON_CTRL, 0x918 PCP_START, 0x822 BCAST_VRING_CFG,
  0x829/0x82a/0x91b PCP channel/factor, 0x910 P2P_CFG, 0x911 PORT_ALLOCATE, 0x914..0x917,
  0x82b SW_TX_REQ (0x904/0x905 TRAFFIC_DEFERRAL/RESUME — вырезаны, энергосбережение PCIe).
- **BF/секторы/RS**: 0x836, 0x83a, 0x849, 0x862, 0x921, 0x922, 0x924, 0x9a0..0x9a7, 0x9aa,
  0x85c, 0x85e, 0xa05.
- **FTM/TOF** (только SparRAW-pro): 0x991, 0x992, 0x996, 0x997, 0x998, 0x923.
- **Планировщик**: 0xa01..0xa04, 0x85f, 0x868, 0xa08, 0xa0e, 0xa0f.
- **Отладка/прочее**: 0x804 DEEP_ECHO, 0x808, 0x856/0x857 RF_XPM, 0x85d, 0x853 RF_MGMT,
  0x42 PXMT_RANGE_CFG (0x960 UPM_CFG — вырезан вместе с PS), 0xf04f PMC, 0xfff, 0x900 (остальные модули UT).
