# WMI: команды и события 4.1 и 6.2

Оглавление управляющей плоскости: номер команды WMI → ветка диспетчера → обработчик,
для 4.1.0.1000 и 6.2.0.1000; события прошивка → хост для 6.2; сравнение сборок 6.2
разных производителей. Что делают обработчики — [HOST-INTERFACE.md](HOST-INTERFACE.md).

Метки: **[код]** — по листингу, **[пак]** — по `wmi.h`/вендорским именам.

## Источники номеров и имён

* Диспетчеры: `host_if__wmi_cmd_dispatch` @0x8da54c **[4.1]**, `wmi__host_cmd_dispatch` **[6.2]**.
  Для каждой ветки снято: номер команды → адрес ветки → строка лога ветки → вызываемый
  обработчик **[код]**.
* Имена команд и событий — из `wmi.h` драйвера backports-7.2 **[пак]**.
* События 6.2 сняты по вызовам `low_sme__send_evt2sw`, `wmi_evt__post`,
  `fw_sysapi_mgr__send_evt2host` (номер события — в регистре-аргументе).

## Сводка

| | 4.1 | 6.2 |
|---|---|---|
| команд в диспетчере | 68 | 102 |
| только в этой версии | 1 | 35 |

**Нет ни в одной версии** (есть в `wmi.h` мейнлайна): `WMI_TSF_SYNC`, `WMI_PCP_CONF`,
`WMI_SET_PROMISCUOUS_MODE`, `WMI_MEM_READ/WR`, `WMI_BF_TXSS_MGMT`, `WMI_BF_SM_MGMT`,
`WMI_BF_RXSS_MGMT`, `WMI_MAINTAIN_PAUSE/RESUME`, `WMI_RS_ENABLE`, кольца EDMA
(`*_RING_ADD`), `WMI_SEND_ASSOC_RES`, `WMI_SET_ASSOC_REQ_RELAY`, радар, sched scan.

**Есть в прошивке, нет в `wmi.h`:** 0x859 `WMI_BRP_RF_CHAINS_LIMIT` **[4.1]**,
0x960 `WMI_UPM_CFG` **[6.2]** (→ `lmac_if_upm_cfg_handler`), 0x995 `WMI_TOF_CHANNEL_INFO`
**[6.2]** (номер в `wmi.h` иной), 0xfff **[6.2]** (ветка `orig_fract` — отладочная перестройка дробной части частоты синтезатора, см. [VERSION-DIFF](VERSION-DIFF.md)).

## Новое в 6.2 по смыслу

| группа | команды |
|---|---|
| **управление BF с хоста** | 0x83a `WMI_BF_TRIG`, 0x9aa `WMI_BF_CONTROL`, 0x924 `WMI_BRP_SET_ANT_LIMIT`, 0x9a4 `WMI_SET_RF_SECTOR_ON`, 0x9a5..0x9a7 `WMI_PRIO_TX_SECTORS_*` |
| **фиксированное расписание (TDMA)** | 0xa02 `WMI_FIXED_SCHEDULING_CONFIG`, 0xa03 `WMI_ENABLE_FIXED_SCHEDULING`, 0x85f `..._UL_CONFIG`, 0xa0f `WMI_SET_AP_SLOT_SIZE`, 0xa0e `WMI_SET_GRANT_MCS` — параметры и обработка: [6.2/docs/FIXED-SCHED.md](../6.2/docs/FIXED-SCHED.md) |
| станции с хоста | 0x935 `WMI_NEW_STA`, 0x936 `WMI_DEL_STA`, 0xa06 `WMI_GET_ASSOC_LIST` |
| ToF/AoA | 0x991..0x998, 0x923 `WMI_AOA_MEAS` |
| РЧ/калибровки | 0x85c, 0x85d, 0x85e, 0x866, 0x867, 0xa04 |
| CCA | 0xa07, 0xa08 |
| rate search | 0x922 `WMI_GET_DETAILED_RS_RES` |

Для безролевой связи ключевые `WMI_BF_CONTROL` / `WMI_BF_TRIG` **[6.2]** — штатное
управление политикой и запуском BF. В 4.1 их нет: политика повторов BF выбирается
прошивкой по `m_bss_mode` (см. [BF-ENGINE.md](BF-ENGINE.md)).

Подкоманды `WMI_UNIT_TEST` (0x900) модуля драйверов 6.2 — [6.2/docs/UT-DRIVERS.md](../6.2/docs/UT-DRIVERS.md).

## Полная таблица команд

| id | имя (wmi.h) | 4.1 ветка / обработчик | 6.2 ветка / обработчик |
|---|---|---|---|
| 0x1 | WMI_CONNECT_CMDID | 0x8da970 `wmi_handler_connect` | 0x8de8cc `wmi_connect` |
| 0x3 | WMI_DISCONNECT_CMDID | 0x8da93e `wmi_handler_disconnect` | 0x8de89e `wmi_disconnect` |
| 0x4 | WMI_DISCONNECT_STA_CMDID | 0x8da956 `wmi_handler_disconnect_sta` | 0x8de8b4 `wmi_disconnect_sta` |
| 0x7 | WMI_START_SCAN_CMDID | 0x8da8b8 `low_sme__wmi_scan_cmd_handler` | 0x8de82e `low_sme__wmi_scan_cmd_handler` |
| 0xa | WMI_SET_PROBED_SSID_CMDID | 0x8dae70 `fw_mailbox__has_space` | 0x8df070 `lmac_if__evt_fields` |
| 0xf | WMI_BCON_CTRL_CMDID | 0x8dab68 `wmi_handler_bcon_ctrl` | 0x8deab8 `wmi_pcp_start_cmd_handler` |
| 0x16 | WMI_ADD_CIPHER_KEY_CMDID | 0x8dabd0 `WMI_ADD_CIPHER_KEY_CMD` | 0x8deb30 `wmi_add_cipher_key` |
| 0x17 | WMI_DELETE_CIPHER_KEY_CMDID | 0x8dabea `WMI_DELETE_CIPHER_KEY_CMD` | 0x8deb48 `wmi_delete_cipher_key` |
| 0x3f | WMI_SET_APPIE_CMDID | 0x8dac78 `wmi_handler_set_appie` | 0x8dec94 `tail_l2mgr__set_app_ie` |
| 0x42 | WMI_PXMT_RANGE_CFG_CMDID | 0x8dac92 `wmi_handler_pxmt_range_cfg` | 0x8decac `wmi_pxmt_range_cfg` |
| 0x803 | WMI_ECHO_CMDID | 0x8da64c `wmi_handler_echo` | 0x8de7b0 `beacon_interval` |
| 0x804 | WMI_DEEP_ECHO_CMDID | 0x8da90a `lmac_if__send_echo` | 0x8de856 `wmi_deep_echo` |
| 0x808 | WMI_ADD_DEBUG_TX_PCKT_CMDID | 0x8da67e `wmi_handler_add_debug_tx_pckt` | 0x8de86e `wmi_add_debug_tx_pckt` |
| 0x80e | WMI_TEMP_SENSE_CMDID | 0x8da8d6 `wmi_handler_temp_sense` | 0x8de84a `wmi__cmd_arg_check` |
| 0x820 | WMI_CFG_RX_CHAIN_CMDID | 0x8da924 `wmi_handler_cfg_rx_chain` | 0x8de886 `wmi_cfg_rx_chain` |
| 0x821 | WMI_VRING_CFG_CMDID | 0x8da6ac `encap_trans_type` | 0x8de8e8 `wmi_vring_cfg` |
| 0x822 | WMI_BCAST_VRING_CFG_CMDID | 0x8da98e `wmi_handler_bcast_vring_cfg` | 0x8de900 `wmi_bcast_vring_cfg` |
| 0x823 | WMI_RING_BA_EN_CMDID | 0x8daa86 `wmi_handler_vring_ba_en` | 0x8de9cc `wmi_vring_ba_en` |
| 0x824 | WMI_RING_BA_DIS_CMDID | 0x8daaa0 `wmi_handler_vring_ba_dis` | 0x8de9e4 `wmi_vring_ba_dis` |
| 0x825 | WMI_RCP_ADDBA_RESP_CMDID | 0x8daaba `wmi_handler_rcp_addba_resp` | 0x8de9fc `wmi_rcp_addba_resp` |
| 0x826 | WMI_RCP_DELBA_CMDID | 0x8daad4 `wmi_handler_rcp_delba` | 0x8dea14 `wmi_rcp_delba` |
| 0x827 | WMI_SET_SSID_CMDID | 0x8daaee `l2_mgr__wmi_cmd_handler_set_ssid` | 0x8dea44 `l2_mgr__wmi_cmd_handler_set_ssid` |
| 0x828 | WMI_GET_SSID_CMDID | 0x8dab08 `wmi_handler_get_ssid` | 0x8dea5c `wmi_get_ssid` |
| 0x829 | WMI_SET_PCP_CHANNEL_CMDID | 0x8dab20 `wmi_handler_set_pcp_channel` | 0x8dea74 `wmi_set_pcp_channel` |
| 0x82a | WMI_GET_PCP_CHANNEL_CMDID | 0x8dab38 `wmi_handler_get_pcp_channel` | 0x8dea8a `wmi_get_pcp_channel` |
| 0x82b | WMI_SW_TX_REQ_CMDID | 0x8dacd8 `wmi_handler_sw_tx_req` | 0x8ded0e `wmi_sw_tx_req` |
| 0x835 | WMI_MLME_PUSH_CMDID | 0x8dae70 `fw_mailbox__has_space` | 0x8df070 `lmac_if__evt_fields` |
| 0x836 | WMI_BEAMFORMING_MGMT_CMDID | 0x8dabb4 `wmi_handler_beamforming_mgmt` | 0x8deb16 `wmi_beamforming_mgmt` |
| 0x83a | WMI_BF_TRIG_CMDID | — | 0x8deafe `wmi_trigger_beamforming_cmdid` |
| 0x842 | WMI_LINK_MAINTAIN_CFG_WRITE_CMDID | 0x8dad06 `wmi_handler_link_maintain_cfg_write` | 0x8ded4c `wmi_link_maintain_cfg_write` |
| 0x843 | WMI_LINK_MAINTAIN_CFG_READ_CMDID | 0x8dad1c `wmi_handler_link_maintain_cfg_read` | 0x8ded62 `wmi_link_maintain_cfg_read` |
| 0x849 | WMI_SET_SECTORS_CMDID | 0x8dac04 `host_if__set_sectors_hal` | 0x8deb60 `host_if__set_sectors_hal` |
| 0x853 | WMI_RF_MGMT_CMDID | 0x8dacc2 `low_sme__wmi_rf_mgmt_cmd_handler` | 0x8decc4 `low_sme__wmi_rf_mgmt_cmd_handler` |
| 0x856 | WMI_RF_XPM_READ_CMDID | 0x8da87a `wmi_handler_otp_read` | 0x8de7fe `host_if__read_rf_xpm_handler` |
| 0x857 | WMI_RF_XPM_WRITE_CMDID | 0x8da898 `wmi_handler_otp_write` | 0x8de816 `host_if__write_rf_xpm_handler` |
| 0x859 | WMI_BRP_RF_CHAINS_LIMIT_CMDID | 0x8da8f0 `wmi_handler_brp_rf_chains_limit` | — |
| 0x85c | WMI_SET_ACTIVE_SILENT_RSSI_TABLE_CMDID | — | 0x8df01a `wmi_set_active_silent_rssi_table` |
| 0x85d | WMI_RF_PWR_ON_DELAY_CMDID | — | 0x8de7ca `wmi_rf_pwr_on_delay` |
| 0x85e | WMI_SET_HIGH_POWER_TABLE_PARAMS_CMDID | — | 0x8de7e4 `wmi_set_high_power_table_params` |
| 0x85f | WMI_FIXED_SCHEDULING_UL_CONFIG_CMDID | — | 0x8deed0 `wmi_fixed_scheduling_ul_config` |
| 0x862 | WMI_BF_CTRL_CMDID | 0x8dac10 `host_if__bf_ctrl_hal` | 0x8deb6c `host_if__bf_ctrl_hal` |
| 0x863 | WMI_NOTIFY_REQ_CMDID | 0x8dac1e `host_if__timestamp_sync` | 0x8deb7a `wmi__bump_cmd_counter` |
| 0x864 | WMI_GET_STATUS_CMDID | 0x8dac6a `host_if__get_status_hal` | 0x8dec86 `host_if__get_status_hal` |
| 0x866 | WMI_GET_RF_STATUS_CMDID | — | 0x8dec56 `wmi_get_rf_status` |
| 0x867 | WMI_GET_BASEBAND_TYPE_CMDID | — | 0x8dec6e `wmi_get_baseband_type` |
| 0x868 | WMI_VRING_SWITCH_TIMING_CONFIG_CMDID | 0x8dadac `wmi_handler_vring_switch_config` | 0x8deea0 `wmi_vring_switch_config` |
| 0x900 | WMI_UNIT_TEST_CMDID | 0x8dac2a `wmi_ut_handler_dispatch` | 0x8dec1a `wmi_ut_handler` |
| 0x904 | WMI_TRAFFIC_SUSPEND_CMDID | 0x8dad32 `POWER_MNGR__wmi_traffic_deferral_cmd` | 0x8ded78 `POWER_MNGR__wmi_traffic_deferral_cmd` |
| 0x905 | WMI_TRAFFIC_RESUME_CMDID | 0x8dad4a `wmi_handler_traffic_resume` | 0x8ded90 `wmi_traffic_resume` |
| 0x910 | WMI_P2P_CFG_CMDID | 0x8daa3c `l2_mgr__wmi_cmd_handler_p2p_cfg` | 0x8de988 `tail_l2_mgr__wmi_cmd_handler_p2p_cfg` |
| 0x911 | WMI_PORT_ALLOCATE_CMDID | 0x8daa56 `wmi_handler_port_allocate` | 0x8de9a0 `wmi_port_allocate` |
| 0x913 | WMI_POWER_MGMT_CFG_CMDID | 0x8da9a8 `wmi_handler_power_mgmt_cfg` | 0x8de918 `tail_wmi_power_mgmt_cfg` |
| 0x914 | WMI_START_LISTEN_CMDID | 0x8da9c2 `l2_mgr__wmi_cmd_handler_start_listen` | 0x8de930 `tail_l2_mgr__wmi_cmd_handler_start_listen` |
| 0x915 | WMI_START_SEARCH_CMDID | 0x8da9da `l2_mgr__wmi_cmd_handler_start_search` | 0x8de946 `tail_l2_mgr__wmi_cmd_handler_start_search` |
| 0x916 | WMI_DISCOVERY_START_CMDID | 0x8da9f2 `wmi_handler_discovery_start` | 0x8de95c `tail_l2mgr__start_discovery` |
| 0x917 | WMI_DISCOVERY_STOP_CMDID | 0x8daa0a `wmi_handler_discovery_stop` | 0x8de972 `tail_l2mgr__stop_discovery` |
| 0x918 | WMI_PCP_START_CMDID | 0x8dab82 `wmi_handler_pcp_start` | 0x8dead0 `wmi_pcp_start` |
| 0x919 | WMI_PCP_STOP_CMDID | 0x8dab9c `l2_mgr__pcp_stop` | 0x8deae8 `l2_mgr__pcp_stop` |
| 0x91b | WMI_GET_PCP_FACTOR_CMDID | 0x8daa6e `wmi_handler_get_pcp_factor` | 0x8de9b6 `wmi_get_pcp_factor` |
| 0x91c | WMI_PS_DEV_PROFILE_CFG_CMDID | 0x8dad5e `POWER_MNGR__wmi_ps_dev_profile_cfg_cmd` | 0x8deda4 `POWER_MNGR__wmi_ps_dev_profile_cfg_cmd` |
| 0x921 | WMI_RS_CFG_CMDID | 0x8da786 `wmi_handler_rs_cfg` | 0x8decda `wmi_rs_cfg` |
| 0x922 | WMI_GET_DETAILED_RS_RES_CMDID | — | 0x8dee0a `wmi_get_detailed_rs_res` |
| 0x923 | WMI_AOA_MEAS_CMDID | — | 0x8deb86 `wmi_aoa_meas` |
| 0x924 | WMI_BRP_SET_ANT_LIMIT_CMDID | — | 0x8decf4 `wmi_brp_set_ant_limit` |
| 0x930 | WMI_SET_MGMT_RETRY_LIMIT_CMDID | 0x8dad78 `l2_mgr__wmi_cmd_handler_set_mgmt_retry_limit` | 0x8dedbe `l2_mgr__wmi_cmd_handler_set_mgmt_retry_limit` |
| 0x931 | WMI_GET_MGMT_RETRY_LIMIT_CMDID | 0x8da7b8 `l2_mgr__wmi_cmd_handler_get_mgmt_retry_limit` | 0x8dedd8 `l2_mgr__wmi_cmd_handler_get_mgmt_retry_limit` |
| 0x935 | WMI_NEW_STA_CMDID | — | 0x8de610 `l2_mgr__wmi_cmd_handler_new_sta` |
| 0x936 | WMI_DEL_STA_CMDID | — | 0x8dedf0 `l2_mgr__wmi_cmd_handler_del_sta` |
| 0x960 | WMI_UPM_CFG_CMDID | — | 0x8dee24 `lmac_if_upm_cfg_handler` |
| 0x991 | WMI_TOF_SESSION_START_CMDID | — | 0x8de63e `mac_read_tsf64 l2_mgr__tof_ftm_req` |
| 0x992 | WMI_TOF_GET_CAPABILITIES_CMDID | — | 0x8deb9c `l2_mgr__tof_get_capabilities` |
| 0x993 | WMI_TOF_SET_LCR_CMDID | — | 0x8debc8 |
| 0x994 | WMI_TOF_SET_LCI_CMDID | — | 0x8debd8 |
| 0x995 | WMI_TOF_CHANNEL_INFO_CMDID | — | 0x8debe0 |
| 0x996 | WMI_TOF_CFG_RESPONDER_CMDID | — | 0x8debb2 `l2_mgr__tof_config_responder` |
| 0x997 | WMI_TOF_SET_TX_RX_OFFSET_CMDID | — | 0x8debe8 `wmi_tof_set_tx_rx_offset` |
| 0x998 | WMI_TOF_GET_TX_RX_OFFSET_CMDID | — | 0x8dec02 `wmi_tof_get_tx_rx_offset` |
| 0x9a0 | WMI_GET_RF_SECTOR_PARAMS_CMDID | 0x8dadc6 `wmi_handler_get_rf_sector_params__set` | 0x8def16 `boot__clear_object_48 wmi_handler_get_rf_sector_params__set` |
| 0x9a1 | WMI_SET_RF_SECTOR_PARAMS_CMDID | 0x8dadf0 `wmi_handler_set_rf_sector_params__set` | 0x8def54 `boot__clear_object_tail wmi_handler_set_rf_sector_params__set` |
| 0x9a2 | WMI_GET_SELECTED_RF_SECTOR_INDEX_CMDID | 0x8da7e6 `wmi_handler_get_selected_rf_sector_index` | 0x8def92 `wmi_get_selected_rf_sector_index` |
| 0x9a3 | WMI_SET_SELECTED_RF_SECTOR_INDEX_CMDID | 0x8dae1a `wmi_handler_set_selected_rf_sector_index` | 0x8defbe `wmi_set_selected_rf_sector_index` |
| 0x9a4 | WMI_SET_RF_SECTOR_ON_CMDID | — | 0x8defee `wmi_set_rf_sector_on_cmd_handler` |
| 0x9a5 | WMI_PRIO_TX_SECTORS_ORDER_CMDID | — | 0x8dee3a `wmi_prio_tx_sectors_order` |
| 0x9a6 | WMI_PRIO_TX_SECTORS_NUMBER_CMDID | — | 0x8dee54 `wmi_prio_tx_sectors_number` |
| 0x9a7 | WMI_PRIO_TX_SECTORS_SET_DEFAULT_CFG_CMDID | — | 0x8dee6e `wmi_prio_tx_sectors_set_default_cfg` |
| 0x9aa | WMI_BF_CONTROL_CMDID | — | 0x8df004 `wmi_bf_control` |
| 0xa01 | WMI_SCHEDULING_SCHEME_CMDID | 0x8daa22 `wmi_handler_ese_cfg` | 0x8de6d2 `wmi_ese_cfg` |
| 0xa02 | WMI_FIXED_SCHEDULING_CONFIG_CMDID | — | 0x8deeb8 `wmi_fixed_scheduling_config` |
| 0xa03 | WMI_ENABLE_FIXED_SCHEDULING_CMDID | — | 0x8deee8 `wmi_enable_fixed_scheduling` |
| 0xa04 | WMI_SET_MULTI_DIRECTED_OMNIS_CONFIG_CMDID | — | 0x8de700 `wmi_set_multi_directed_omnis_config_cmd` |
| 0xa05 | WMI_SET_LONG_RANGE_CONFIG_CMDID | 0x8dad92 `lmac_if_send_long_range` | 0x8dee88 `wmi_set_long_range` |
| 0xa06 | WMI_GET_ASSOC_LIST_CMDID | — | 0x8def00 `wmi_get_assoc_list` |
| 0xa07 | WMI_GET_CCA_INDICATIONS_CMDID | — | 0x8ded26 `uses_g_80426c__8fb598` |
| 0xa08 | WMI_SET_CCA_INDICATIONS_BI_AVG_NUM_CMDID | — | 0x8ded32 `wmi_set_cca_indications_bi_avg_num` |
| 0xa0e | WMI_SET_GRANT_MCS_CMDID | — | 0x8df032 `wmi_set_grant_mcs` |
| 0xa0f | WMI_SET_AP_SLOT_SIZE_CMDID | — | 0x8df048 `wmi_set_ap_slot_size` |
| 0xfff | отладка: перестройка дробной части частоты синтезатора (пишет 0x88942c) | — | 0x8df05e `orig_fract` |
| 0xf003 | WMI_SET_MAC_ADDRESS_CMDID | 0x8da842 `wmi_handler_set_mac_address` | 0x8dea2c `tail_l2mgr__set_mac_address` |
| 0xf007 | WMI_ABORT_SCAN_CMDID | 0x8dab50 `wmi_handler_abort_scan` | 0x8deaa2 `wmi_abort_scan` |
| 0xf049 | WMI_SET_PASSPHRASE_CMDID | 0x8dacaa `wmi_set_passphrase_handler` | 0x8de76e `wmi_set_passphrase_handler` |
| 0xf04d | WMI_MAC_ADDR_REQ_CMDID | 0x8dac36 `wmi_handler_mac_addr_req` | 0x8dec26 `wmi_mac_addr_req` |
| 0xf04e | WMI_FW_VER_CMDID | 0x8dac50 `wmi_handler_fw_ver` | 0x8dec3e `wmi_fw_ver` |
| 0xf04f | WMI_PMC_CMDID | 0x8dacf0 `wmi_handler_pmc` | 0x8de79a `wmi_pmc` |

## События прошивка → хост

### 6.2 (по отправителям)

Формат строки: номер события, место вызова (функция+смещение), имя по `wmi.h`.
«?» — номер не константа в месте вызова (показана инструкция, задающая регистр);
«-» — имени в `wmi.h` нет. Для `fw_sysapi_mgr__send_evt2host` приведены оба аргумента (r1 и r2).

```
## low_sme__send_evt2sw r1
0x1840  stream_mgr__action+0x202                                WMI_RX_MGMT_PACKET_EVENTID
0x1824  stream_mgr__addba_req_handler+0x8e                      WMI_RCP_ADDBA_REQ_EVENTID
0x1923  tof_mgr__aoa_session_start+0x5e                         WMI_AOA_MEAS_EVENTID
0x1826  stream_mgr__delba_handler+0xe0                          WMI_DELBA_EVENTID
0x1995  tof_mgr__ftm_error_handler+0x58                         WMI_TOF_FTM_PER_DEST_RES_EVENTID
0x1991  tof_mgr__alloc_entry+0x30                               WMI_TOF_SESSION_END_EVENTID
0x1995  state_sm_803424__action_cmp12+0x5c                      WMI_TOF_FTM_PER_DEST_RES_EVENTID
0x1923  lmac_if_aoa_meas_evt_handler+0x82                       WMI_AOA_MEAS_EVENTID
0x1904  l2mgr__send_traffic_deferral_evt+0x5a                   WMI_TRAFFIC_SUSPEND_EVENTID
0x1905  l2mgr__send_traffic_resume_evt+0x4c                     WMI_TRAFFIC_RESUME_EVENTID
0x1863  calls__8e0a20+0x3e                                      WMI_NOTIFY_REQ_DONE_EVENTID
0x1841  TX_API__post_tx_payload+0x42                            WMI_TX_MGMT_PACKET_EVENTID
0x1840  discovery__rx_pkt_handler+0x102                         WMI_RX_MGMT_PACKET_EVENTID
0x1840  discovery__rx_pkt_handler+0x194                         WMI_RX_MGMT_PACKET_EVENTID
0x1840  uses_g_843158__8e3f0c+0x78                              WMI_RX_MGMT_PACKET_EVENTID
0x1840  uses_g_843158__8e3f0c+0xd6                              WMI_RX_MGMT_PACKET_EVENTID
0x1840  uses_g_843158__8e3f0c+0x13a                             WMI_RX_MGMT_PACKET_EVENTID
0x1823  send_ba_status_report+0x84                              WMI_BA_STATUS_EVENTID
0x1003  l2mgr__send_disconnect_evt+0x6e                         WMI_DISCONNECT_EVENTID
0x9005  l2mgr__send_scan_complete_evt+0x98                      WMI_ACS_PASSIVE_SCAN_COMPLETE_EVENTID
0x1853  low_sme__send_rf_mgmt_status+0x5a                       WMI_RF_MGMT_STATUS_EVENTID
0x100a  pcp_psc_sm__send_usol_psc_resp_sm+0x34                  WMI_SCAN_COMPLETE_EVENTID
0x1991  l2_mgr__tof_ftm_req+0x48                                WMI_TOF_SESSION_END_EVENTID
0x1992  l2_mgr__tof_get_capabilities+0x48                       WMI_TOF_GET_CAPABILITIES_EVENTID
0x1843  wmi_link_maintain_cfg_read+0x3c                         WMI_LINK_MAINTAIN_CFG_READ_DONE_EVENTID
0x1842  wmi_link_maintain_cfg_write+0x3e                        WMI_LINK_MAINTAIN_CFG_WRITE_DONE_EVENTID
0x100a  host_if__send_scan_complete+0x46                        WMI_SCAN_COMPLETE_EVENTID
0x1825  wmi_rcp_addba_resp+0x58                                 WMI_RCP_ADDBA_RESP_SENT_EVENTID
0x1825  wmi_rcp_addba_resp+0x10c                                WMI_RCP_ADDBA_RESP_SENT_EVENTID
0x1995  state_sm_803424__action_8f08c0+0x10c                    WMI_TOF_FTM_PER_DEST_RES_EVENTID
0x1801  lmac_if__send_fw_ready_evt+0x2e                         WMI_FW_READY_EVENTID
0x1001  wmi_evt__notify_fw_ready+0x66                           WMI_READY_EVENTID
0x15    l2mgr__send_pbss_joined_evt+0x4e                        -
0x1910  l2mgr__send_p2p_cfg_done+0x3a                           WMI_P2P_CFG_DONE_EVENTID
0x1840  l2mgr__send_host_event+0x122                            WMI_RX_MGMT_PACKET_EVENTID
0x1002  l2mgr__send_host_event+0x16e                            WMI_CONNECT_EVENTID
0x1860  l2mgr__send_data_port_open_evt+0x38                     WMI_DATA_PORT_OPEN_EVENTID
0x1916  l2mgr__send_discovery_started+0x26                      WMI_DISCOVERY_STARTED_EVENTID
0x1917  l2mgr__send_discovery_stopped+0x36                      WMI_DISCOVERY_STOPPED_EVENTID
0x1914  l2mgr__send_listen_started+0x3a                         WMI_LISTEN_STARTED_EVENTID
0x16    l2mgr__send_pbss_leave_evt+0x44                         -
0x1918  l2_mgr__send_pcp_start_status_evt+0x70                  WMI_PCP_STARTED_EVENTID
0x1919  l2mgr__send_pcp_stopped+0x26                            WMI_PCP_STOPPED_EVENTID
0x1915  l2mgr__send_search_started+0x3c                         WMI_SEARCH_STARTED_EVENTID
0x182b  l2mgr__send_sw_tx_complete+0x3c                         WMI_SW_TX_COMPLETE_EVENTID
0x1821  l2mgr__send_vring_cfg_done+0x3e                         WMI_VRING_CFG_DONE_EVENTID
0x1865  l2mgr__send_vring_en_evt+0x3a                           WMI_RING_EN_EVENTID
0x191a  wmi_get_pcp_factor+0x46                                 WMI_PCP_FACTOR_EVENTID
0x1911  wmi_port_allocate+0x64                                  WMI_PORT_ALLOCATED_EVENTID
0x1820  wmi_cfg_rx_chain+0x314                                  WMI_CFG_RX_CHAIN_DONE_EVENTID
## wmi_evt__post r3
0x1a03  uses_g_800236_801448__8c9884+0xb2                       WMI_ENABLE_FIXED_SCHEDULING_COMPLETE_EVENTID
0x1864  host_if__get_status_hal+0x14c                           WMI_GET_STATUS_DONE_EVENTID
0x1998  wmi_tof_get_tx_rx_offset+0x50                           WMI_TOF_GET_TX_RX_OFFSET_EVENTID
0x19a0  wmi_handler_get_rf_sector_params__on_radio_locked_cb+0x124 WMI_GET_RF_SECTOR_PARAMS_DONE_EVENTID
0x19a1  wmi_handler_set_rf_sector_params__set_rf_sector_params+0x116 WMI_SET_RF_SECTOR_PARAMS_DONE_EVENTID
0x19a2  evt_get_selected_rf_sector_index_done+0x48              WMI_GET_SELECTED_RF_SECTOR_INDEX_DONE_EVENTID
0x19a3  evt_set_selected_rf_sector_index_done+0x42              WMI_SET_SELECTED_RF_SECTOR_INDEX_DONE_EVENTID
0x1836  wmi_beamforming_mgmt+0x68                               WMI_BEAMFORMING_MGMT_DONE_EVENTID
0x1862  host_if__bf_ctrl_hal+0x32                               WMI_BF_CTRL_DONE_EVENTID
0x1924  wmi_brp_set_ant_limit+0x5a                              WMI_BRP_SET_ANT_LIMIT_EVENTID
0x9004  wmi_fw_ver+0x154                                        WMI_FW_VER_EVENTID
0x1867  wmi_get_baseband_type+0x5a                              WMI_GET_BASEBAND_TYPE_EVENTID
0x1922  wmi_get_detailed_rs_res+0xaa                            WMI_GET_DETAILED_RS_RES_EVENTID
0x1866  wmi_get_rf_status+0xd6                                  WMI_GET_RF_STATUS_EVENTID
0x1863  wmi__bump_cmd_counter+0x58                              WMI_NOTIFY_REQ_DONE_EVENTID
0x1921  wmi_rs_cfg+0x78                                         WMI_RS_CFG_DONE_EVENTID
0x1856  host_if__read_rf_xpm_handler+0x82                       WMI_RF_XPM_READ_RESULT_EVENTID
0x1857  host_if__write_rf_xpm_handler+0x8a                      WMI_RF_XPM_WRITE_RESULT_EVENTID
0x1803  beacon_interval+0x4e                                    WMI_ECHO_RSP_EVENTID
?       low_sme__send_evt2sw+0xec                               ?mov_s r3,r14
?       lmac_if__echo_evt_body+0x22                             ?mov_s r3,r15
0xffff  wmi_evt__send_command_not_supported+0x48                WMI_COMMAND_NOT_SUPPORTED_EVENTID
0x180e  calls__8e5dac+0x2e                                      WMI_TEMP_SENSE_DONE_EVENTID
0x19a0  wmi_handler_get_rf_sector_params__set+0x74              WMI_GET_RF_SECTOR_PARAMS_DONE_EVENTID
0x19a1  wmi_handler_set_rf_sector_params__set+0x7a              WMI_SET_RF_SECTOR_PARAMS_DONE_EVENTID
0x19a2  wmi_get_selected_rf_sector_index+0x60                   WMI_GET_SELECTED_RF_SECTOR_INDEX_DONE_EVENTID
0x19a3  wmi_set_selected_rf_sector_index+0x60                   WMI_SET_SELECTED_RF_SECTOR_INDEX_DONE_EVENTID
0x185c  wmi_set_active_silent_rssi_table+0x4c                   WMI_SET_SILENT_RSSI_TABLE_DONE_EVENTID
0x1a0f  wmi_set_ap_slot_size+0x3a                               WMI_SET_AP_SLOT_SIZE_EVENTID
0x1a0e  wmi_set_grant_mcs+0x4a                                  WMI_SET_GRANT_MCS_EVENTID
0x185d  wmi_rf_pwr_on_delay+0x3e                                WMI_RF_PWR_ON_DELAY_RSP_EVENTID
0x1997  wmi_tof_set_tx_rx_offset+0x4a                           WMI_TOF_SET_TX_RX_OFFSET_EVENTID
0x1868  wmi_vring_switch_config+0x3e                            WMI_VRING_SWITCH_TIMING_CONFIG_EVENTID
0x180e  wmi__cmd_arg_check+0x66                                 WMI_TEMP_SENSE_DONE_EVENTID
0x1900  wmi_evt__send_words+0x38                                WMI_UNIT_TEST_EVENTID
0x19aa  wmi_bf_control+0x110                                    WMI_BF_CONTROL_EVENTID
0x1931  l2_mgr__wmi_cmd_handler_get_mgmt_retry_limit+0x58       WMI_GET_MGMT_RETRY_LIMIT_EVENTID
0x1828  wmi_get_ssid+0x48                                       WMI_GET_SSID_EVENTID
0x1930  l2_mgr__wmi_cmd_handler_set_mgmt_retry_limit+0x76       WMI_SET_MGMT_RETRY_LIMIT_EVENTID
0x185e  wmi_set_high_power_table_params+0x38                    WMI_SET_HIGH_POWER_TABLE_PARAMS_EVENTID
0x1a02  wmi_fixed_scheduling_config+0x84                        WMI_FIXED_SCHEDULING_CONFIG_COMPLETE_EVENTID
0x185f  wmi_fixed_scheduling_ul_config+0x82                     WMI_FIXED_SCHEDULING_UL_CONFIG_EVENTID
0x1a06  wmi_get_assoc_list+0x8a                                 WMI_GET_ASSOC_LIST_RES_EVENTID
0x9003  wmi_mac_addr_req+0x7e                                   WMI_MAC_ADDR_RESP_EVENTID
0x191c  POWER_MNGR__wmi_ps_dev_profile_cfg_cmd+0x54             WMI_PS_DEV_PROFILE_CFG_EVENTID
0x1a05  wmi_set_long_range+0x44                                 WMI_SET_LONG_RANGE_CONFIG_COMPLETE_EVENTID
0x1a04  wmi_set_multi_directed_omnis_config_cmd+0x36            WMI_SET_MULTI_DIRECTED_OMNIS_CONFIG_EVENTID
0x19a4  wmi_set_rf_sector_on_cmd_handler+0x58                   WMI_SET_RF_SECTOR_ON_DONE_EVENTID
0x19a5  wmi_prio_tx_sectors_set_default_cfg+0x40                WMI_PRIO_TX_SECTORS_ORDER_EVENTID
0x19a5  wmi_prio_tx_sectors_number+0x40                         WMI_PRIO_TX_SECTORS_ORDER_EVENTID
0x19a5  wmi_prio_tx_sectors_order+0x40                          WMI_PRIO_TX_SECTORS_ORDER_EVENTID
0x1a07  uses_g_80426c__8fb598+0x46                              WMI_GET_CCA_INDICATIONS_EVENTID
0x182a  wmi_get_pcp_channel+0x50                                WMI_GET_PCP_CHANNEL_EVENTID
0x1a01  wmi_ese_cfg+0x62                                        WMI_SCHEDULING_SCHEME_EVENTID
0x1a08  wmi_set_cca_indications_bi_avg_num+0x70                 WMI_SET_CCA_INDICATIONS_BI_AVG_NUM_EVENTID
## fw_sysapi_mgr__send_evt2host r1
?       fw_sysapi_mgr__channel_estimation_cmd_complete+0x52     ?mov_s r1,r14
0x2     channel_estimation_cmd_start+0x54                       -
0x1     sched__apply_entry+0x3c                                 -
?       scan_mngr__dwelling_done+0xd4                           ?mov_s r1,r17
?       fw_sysapi_mgr__start_energy_statistics+0x56             ?ld_s r1,[r14,0x20]
?       field_rw_0x20__8f3538+0xe                               ?ld_s r1,[r0,0x20]
?       get_rx_pkt_phy_data_cmd_complete+0xa0                   ?ld_s r1,[r13,0x20]
0x2     get_rx_pkt_phy_data_cmd_start+0x56                      -
?       l2_mgr__high_false_alarm_secondary_lock_cb+0x2e         ?ld_s r1,[r13,0x20]
?       fw_sysapi_mgr__mac_ampdu_statistics_cmd_start+0x54      ?ld_s r1,[r13,0x20]
?       stats__log_counters+0x6a                                ?ld_s r1,[r13,0x20]
?       fw_sysapi_mgr__phy_rx_statistics_cmd_start+0x56         ?ld_s r1,[r13,0x20]
?       fw_sysapi_mgr__phy_rx_statistics_cmd_start+0x140        ?mov_s r1,r16
?       fw_sysapi_mgr__start_plcp_header+0x54                   ?ld_s r1,[r13,0x20]
?       uses_tbl_8012f0__8f8af8+0xc6                            ?ld_s r1,[r15,0x20]
## fw_sysapi_mgr__send_evt2host r2
?       fw_sysapi_mgr__channel_estimation_cmd_complete+0x52     ?mov_s r2,r15
0x0     channel_estimation_cmd_start+0x54                       -
?       sched__apply_entry+0x3c                                 ?add_s r2,sp,0x8
?       scan_mngr__dwelling_done+0xd4                           ?mov_s r2,r16
?       fw_sysapi_mgr__start_energy_statistics+0x56             ?mov_s r2,sp
?       field_rw_0x20__8f3538+0xe                               ?mov_s r2,r1
?       get_rx_pkt_phy_data_cmd_complete+0xa0                   ?mov_s r2,sp
?       get_rx_pkt_phy_data_cmd_start+0x56                      ?mov_s r2,sp
?       l2_mgr__high_false_alarm_secondary_lock_cb+0x2e         ?mov_s r2,sp
?       fw_sysapi_mgr__mac_ampdu_statistics_cmd_start+0x54      ?mov_s r2,sp
?       stats__log_counters+0x6a                                ?mov_s r2,r14
?       fw_sysapi_mgr__phy_rx_statistics_cmd_start+0x56         ?mov_s r2,sp
?       fw_sysapi_mgr__phy_rx_statistics_cmd_start+0x140        ?mov_s r2,r15
?       fw_sysapi_mgr__start_plcp_header+0x54                   ?mov_s r2,sp
?       uses_tbl_8012f0__8f8af8+0xc6                            ?mov_s r2,sp
```

События 0x15 (`l2mgr__send_pbss_joined_evt`) и 0x16 (`l2mgr__send_pbss_leave_evt`)
в `wmi.h` мейнлайна отсутствуют: 0x15 = `WMI_PBSS_JOINED_EVENTID` (режим Direct
Connection, см. [HOST-INTERFACE.md](HOST-INTERFACE.md#подключение-станции-wmi_connect-0x1)).

### 4.1

Полной выгрузки событий нет. Установлено: 4.1 шлёт 0x15 `WMI_PBSS_JOINED_EVENTID`
(`l2mgr__send_pbss_joined_evt` @0x8eea68). Выход событий в 4.1 —
`operational_if__alloc_evt` @0x8c2b68 → заполнение → `operational_if__send_evt` @0x8e0874
(id события в r1) **[код]**.

## Сборки 6.2 разных производителей

Сравнение WMI-интерфейса UBNT 6.2.0.225 и MikroTik 6.2.0.1000 на общей базе Sparrow 6.2.
Образ MikroTik — проект `blobs/kit-6200/` (3133 функции, карта 0x8c0000/…, совпадает
с картой 4.1 1:1), образ UBNT — отдельный проект. Числовые значения WMI — из публичного
`wmi.h` debug-tools 2017 (88 команд, 65 событий).

| | общие | только UBNT | только MikroTik |
|-|--------|-----------|-----------|
| **команды** | 31 | 1 | 0 |
| **события** | 24 | 2 | 0 |

* Только UBNT, команда: `WMI_NOTIFY_REQ_CMDID` (0x0863).
* Только UBNT, события: `WMI_WBE_LINKDOWN_EVENTID` (0x1861, link-down проводного
  backhaul), `WMI_EAPOL_RX_EVENTID` (0x9002, 802.1X с разгрузкой на хост).
* Сборка MikroTik собственных команд и событий WMI не добавляет.

Поверхность WMI у двух производителей практически одна. Отличия — несколько
UBNT-специфичных обработчиков вокруг проприетарного datapath (WBE/GBE backhaul,
EAPOL/EAPOL-offload).

UBNT: диспетчер 0x8de070 (задача `wmi_rx_task`), 27 пар cmd_id → обработчик;
отправитель событий `wmi_send_event` 0x8e48ec, 42 пары event_id → производитель.
Обработчики MikroTik структурно те же; внутренние имена классов (`wmi_handler_*::`)
присутствуют в строках лога лишь для 5 обработчиков RF-секторов.

### Метод

Обработанные id найдены сканом immediate-операндов в fw_code (кандидаты-диспетчеры и
объединение id). Скан даёт нижнюю границу (31–32 команды): часть обработчиков
достигается через таблицы переходов и не видна как cmp-immediate. Для сравнения
производителей существенна симметричная разница, а не абсолют.

## Замечания

* 0x863 `WMI_NOTIFY_REQ_CMDID` по скану immediate отнесён к «только UBNT», однако в
  диспетчере MikroTik 6.2 ветка 0x863 есть (0x8deb7a `wmi__bump_cmd_counter`, событие
  0x1863 из `wmi__bump_cmd_counter`+0x58). Полная таблица диспетчера точнее скана.
* Для airFiber набор обработанных команд оценивается в ~41 из 161 (урезанный профиль);
  к паре UBNT 6.2.0.225 / MikroTik 6.2.0.1000 это не относится.
* Ветки 0xa `WMI_SET_PROBED_SSID` и 0x835 `WMI_MLME_PUSH` ведут на один адрес
  (0x8dae70 в 4.1, 0x8df070 в 6.2) — общий хвост диспетчера, отдельного обработчика нет.

## Не установлено

* Полная таблица событий прошивка → хост для 4.1.
* Номера событий, не являющихся константой в месте вызова (строки «?» выше).

## Источники

* `4.1/ref/SYMS.txt`, `4.1/ref/FN-NAMES.txt`, `6.2/ref/FN-NAMES.txt` — имена и адреса.
* `blobs/kit-6200/` — образ MikroTik 6.2.0.1000.
* `wmi.h` backports-7.2 и debug-tools 2017.
