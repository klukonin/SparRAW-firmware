# MLME: ассоциация, соединение, скан и P2P Find

Внутреннее устройство управляющей плоскости fw: автомат MLME ассоциации,
разъединение, объект соединения и CID, ключи, приём discovery-кадров и DMG-маяков,
скан, P2P Find, детектор плохих маяков, списки и пулы MID. Подсистема есть в
4.1.0.1000 и 6.2.0.1000 **[обе]**; путь команд хоста (WMI_CONNECT, PCP_START, скан,
Find) с адресами 4.1 — [HOST-INTERFACE.md](HOST-INTERFACE.md); связь без ролей и режим
OOB — [ROLELESS-LINK.md](ROLELESS-LINK.md); захват радио —
[RADIO-MANAGER.md](RADIO-MANAGER.md); автоматы и их обработчики —
[STATE-MACHINES.md](STATE-MACHINES.md).

Метки: **[код]** — по листингу, **[стр]** — по собственной лог-строке блока,
**[выз]** — по вызывающим/вызываемым, **[гипотеза]** — не проверено.
Запись адреса: `имя` 0x… — адрес 6.2; «/ 4.1 0x…» — адрес той же функции в 4.1
(по совпадению тела — `6.2/ref/CORRELATION-FW.txt`, по таблице
[NAMES-FROM-62](../4.1/docs/NAMES-FROM-62.md) или по имени в `4.1/src/asm/fw/blocks.json`);
если в 4.1 имя другое, оно указано. Функции без пометки 4.1 — соответствие не
установлено. Описатели автоматов (0x802458, 0x8027a0, 0x802fb4, 0x8030f4) и прочие
адреса данных — 6.2; состояния и события — вендорские, из описателей
([6.2/ref/SM-TABLES.txt](../6.2/ref/SM-TABLES.txt)).

## 1. MLME ассоциации — автомат 0x802458 (UNASSOCIATE/ASSOCIATE/ASSOCIATED, 14 событий)

* **EVT_CONNECT в UNASSOCIATE** → `mlme_sm_802458__action_8f1080` 0x8f1080
  **[стр+код]**: приём Assoc Req на стороне PCP. Проверка ёмкости
  `mlme_sm__check_assoc_capacity` 0x8c4e4c / 4.1 0x8c44ec (свободные MID через
  `mid__count_active_conns` 0x8cc66c + `bss_join_verify` 0x8c4e80 / 4.1 0x8c4520: PBC и SSID);
  при отказе — «REJECT ASSOCIATING REQ», Assoc Resp с отказом
  (`mgmt_tx__build_assoc_resp_8f9e88`), освобождение кадра. Иначе разбор
  vendor-specific Wilocity (networkType, test mode, srv_id, PBC), настройка
  TXSS (`conn__config_txss_and_sta` 0x8dc4ac → `lmac_if_config_txss`),
  `l2_mgr__connect_args` 0x8dca38, таймер.
* `mlme_sm__association_done` 0x8f1290 — обработчик association_done:
  «[L2MGR] publish/Ignore association_done_evt», привязка vring
  `l2mgr__program_assoc_vring` 0x8db090 / 4.1 0x8d7f40, `dashboard__add_connection`, событие
  хосту (`l2mgr__send_pbss_joined_evt` при PBSS — WMI_PBSS_JOINED 0x15 прямого
  линка без ролей), `conn__alloc_and_link_kind1` 0x8c733c / 4.1 `tail_lmac_if_send_cmd_0x1b` 0x8c63a4,
  `fw_status__set_state` 0x8e8634 / 4.1 `set_reg_880a44` 0x8e35cc.
* **EVT_RM_CHANNEL_LOCKED** → `mlme_sm_802458__action_8c5cfc` 0x8c5cfc: канал
  захвачен — строит и шлёт Assoc Req (STA) или Assoc Resp (PCP), «Send ASSOC
  REQ/RESP len %d», запускает BF (`lmac_if_trigger_bf`) и таймер ответа.
* EVT_CTRL_NEW_STA → `mlme_sm_802458__action_8c7e88` 0x8c7e88 «NEW_STA event
  handler / injecting assoc_response event»; EVT_WAITFOR_CTRL_ASSOC_RES →
  `mlme_sm_802458__action_8fb430` 0x8fb430 и EVT_WAITFOR_CTRL_DEL_STA →
  `mlme_sm_802458__action_8ec00c` 0x8ec00c — «starting assoc res / del_sta
  timer» (режим splitmac: решение об ассоциации принимает хост).
* EVT_ASSOC_RESPONSE в UNASSOCIATE→ASSOCIATE → `mlme_sm_802458__action_8f0f4c`
  0x8f0f4c: Assoc Resp принят, разбор vendor-specific «Passphrase»
  (`mlme__parse_wilocity_vs`), событие хосту. EVT_ASSOC_RESPONSE_START →
  `mlme_sm_802458__action_8f102c` 0x8f102c.
* EVT_ASSOC_REJECT → `mlme_sm__assoc_reject_ev_handle` 0x8f0eb4 / 4.1 0x8e9710;
  EVT_ASSOC_TIMEOUT → `mlme_sm__association_timeout_ev_handle` 0x8f131c / 4.1 0x8e9c54;
  EVT_CONNECT/DISCONNECT в ASSOCIATE(D) → `mlme_sm__disconnect_ev_handle_8f26a8`
  0x8f26a8. Все три кончают «MLME_UNLOCK_RADIO»: снимают запрос у
  радио-менеджера (`RADIO_MGR__remove_request`), `radio_mgr__call_method_10`
  0x8ea800 и шлют хосту событие через `wmi__host_cmd_dispatch`; разрыв — с
  Disassoc (`mlme_sm__send_disassoc` → `tx_mgmt_srvs__build_disassoc` 0x8e9c9c / 4.1 0x8e4c04).
  `mlme__ctrl_new_sta_timeout_cb` 0x8f2188 — «ctrl_new_sta_timeout_cb».
* Построение кадров: `mgmt_tx__assoc_req_fixed_fields` 0x8f4e9c / 4.1 0x8ec6d0 и
  `push_cap_info` 0x8e1d78 / 4.1 0x8ef784 (Capability: тип BSS и Privacy),
  `mgmt_tx__assoc_req_ies` 0x8f4ec0 / 4.1 0x8ec6f4 (SSID, DMG Capabilities, QoS),
  `mgmt_tx__assoc_resp_tlv` 0x8f4fa0 / 4.1 0x8ec7e0 (DMG Cap, EDCA, IE 151 длины 10, AID),
  `ieee80211_mgt_information_response_construct` 0x8d7e78 / 4.1 0x8ec920 (Information Response
  с DMG Capabilities, зовёт `stream_mgr__send_info_response`).
  `mgmt_pkt__release` 0x8cb180 / 4.1 0x8c955c и `mem_pool__free_thunk` 0x8cb15c —
  освобождение принятого management-кадра.
* Прямой PBSS (SM_EVT_OWN_ASSOC в READY_FOR_ASSOC, `conn_main_sm__action_8c3bf4`) —
  [ROLELESS-LINK §4.7](ROLELESS-LINK.md#47-прямой-pbss-в-62-код).

## 2. Разъединение — автомат 0x8027a0 (INITIAL/WAIT_FOR_DISC_DONE)

Вендорские события: OWN_START, NTF_SW_DATA_STOPPED, NTF_LMS_STOPPED,
NTF_FW_TX_STOPPED, READY_FOR_FLUSH, OWN_DISC_DONE, NTF_MLME_DISC_DONE.
Порядок останова: SW-данные (`WBE_DRIVER__CLOSE`, `lm_if__on_data_stopped` в
`mlme_sm_8027a0__action_8f9ca8` 0x8f9ca8) → LMS (`mlme_sm_8027a0__action_8f6230`
0x8f6230) → FW TX (`mlme_sm_8027a0__action_8f3314` 0x8f3314, сброс ключей
`install_key_index_stub`) → flush → «MLME DISCONNECT: reason, protocol_reason»
(`mlme_sm_8027a0__action_8f6b94` 0x8f6b94 → `conn__disconnect`).
`mid__disconnect_cmd` 0x8c9360 / 4.1 0x8c7c3c — «Disconnection cmd for CID»,
`conn_main_sm__action_step` 0x8c9300 — «WMI Disconnect MID» с выключением
discovery-режима (`lmac_if_discovery_mode_cfg_handler`).

## 3. Соединение, CID, ранжирование

* `conn_mgr__allocate_cid_db_element` 0x8c36c0 / 4.1 0x8c2f84 — выдаёт свободный CID из
  списка, ищет свободный vring («Found #%d V-ring to run», «No free CID
  resource found»). `conn_mgr__link_down_evt` 0x8daae8 / 4.1 0x8d79cc — abort + освобождение
  элемента. `conn_mgr__ranking_remove` 0x8ca6fc / 4.1 0x8c8b8c /
  `conn_mgr__find_in_ranking_list_fw` 0x8da308 / 4.1 `conn_mgr__find_in_ranking_list` 0x8d725c — список ранжирования CID.
* Поиск: `get_connection_by_addr` 0x8cb560 (по MAC через `conn_mgr__find_by_mac`
  0x8cbf2c, memcmp; таблица соединений 0x854080), `pbss__cid_by_aid` 0x8cbf64 / 4.1 0x8c9da4
  («Requested AID / Found CID»), `pbss__free_sta_slot` 0x8c8c04 / 4.1 0x8c7594,
  `pbss__sta_entry_flag` 0x8cc9b0 / 4.1 0x8ca7c4, `mid_list__remove_entry` 0x8daa8c / 4.1 0x8d7970,
  `mid__count_active_conns` 0x8cc66c, `mid__clear_flag_1c9` 0x8c6948 / 4.1 0x8c5b88.
* Объект соединения: `connection__store_ptr` 0x8d9264, `connection__init_fields`
  0x8e7574, BF-идентификатор в +0x6c (`connection__bf_id_at_6c` 0x8e75e8,
  `connection__cmp_bf_id` 0x8e75a4, `connection__bf_notify_entry` 0x8e7530 —
  сверяет ID результата BF и взводит повтор), `conn__threshold_to_offset`
  0x8c7528 / 4.1 0x8c653c, `conn__update_bf_id_on_rs_done` 0x8c54b4 (от `lmac_if__rs_done_evt`).
* Детекторы потери связи: `conn__start_detector_services` 0x8e2bfc / 4.1 0x8de764 →
  `conn__start_detect_a/b` 0x8e2c74/0x8e2c98 → `periodic_service__start`;
  периодические службы `ka_detector__is_enabled` 0x8da214 и
  `tx_ageing_detector__is_enabled` 0x8da260, `periodic_service__run` 0x8cdc18 / 4.1 0x8cb600
  (по TSF). `conn__arm_detectors` 0x8e007c / 4.1 0x8dbf68, `conn_mgr__rearm_all_detectors`
  0x8e00a4 и `conn_mgr__resume_all_vrings` 0x8e2c2c — реакция на смену
  состояния системы по каждому CID (перезапуск детекторов, возобновление vring).
  `bad_beacons__on_bi_evt` 0x8cd880 — детектор сброса AP: сравнивает TSF с
  началом BTI, «AP RESET -> TSF RESET -> DISCONNECT» (через
  `bad_beacons_detector__handle_bcons_info`).
* Настройки link maintain (WMI): `conn_mgr__set_link_maintain_cfg` 0x8e67d0 / 4.1 0x8e1978,
  `link_maintain_cfg__copy` 0x8cc170 / 4.1 0x8c9fcc, `conn_mgr__print_link_maintain_cfg`
  0x8e105c / 4.1 0x8dcea4 (вектор детекторов, пороги bad beacons, период проверки, TX ageing,
  keep-alive по SNR), `ka_detector__log_state` 0x8e10a4 / 4.1 0x8dcef8, `link_stats__copy_entry`
  0x8cc368 (чтение). `rs_cfg__validate` 0x8dd5ac / 4.1 0x8d97a8 — проверка WMI_RS_CFG (пороги
  STOP/MCS1 FAIL/PER, вектор MCS, окно BACK); `ant_limit__validate` 0x8dd0d0 —
  проверка `wmi_brp_set_ant_limit`.
* Прочее: `TX_INTERNAL_API__connection` 0x8cb604 / 4.1 0x8c95e8 и `notify_conn_flush_done`
  0x8df4ac / 4.1 0x8db1fc — сброс очередей соединения (маска pending flush) с задачей через
  `u_schd__add`; три блока `ctrl_del_sta*` относятся к таблице слотов ESE ([ESE.md](ESE.md)),
  а не к удалению STA. `l2_mgr__connect_multi_omni` 0x8c71fc — подключение
  через несколько omni-секторов с отложенным событием по времени последнего
  маяка (§5), `l2_mgr__connect_next` 0x8e4c24.
* **Соединение/PS:** `lm__notify_linkup` 0x8dae74 / 4.1 0x8d7d0c, `conn__check_bad_link`
  0x8c5ef8 («Check bad link: max_mcs, success/failed BF» — решение о повторном
  BF), `conn_mgr__bi_evt_all_conns` 0x8cd8f4 (детектор сброса AP по CID, §3),
  `sta_rec__unpack_5bit_caps` 0x8e70c4 / 4.1 0x8cab58, `lmac_if__send_sta_cfg_05` 0x8e7604
  (команда LMAC 0x05 при старте линка), `rx_macq__program_desc_for_conn`
  0x8e7690, `conn_msm__check_field_2c` 0x8e6308, `conn_main_sm__action_step_b`
  0x8ddb18, `mac__tsf_lo_after_n_bi` 0x8e9874 / 4.1 `mac__mul_886fc4_by_886d64` 0x8e47b4 (AW),
  `mac__program_886c00_entry` 0x8ea360 / 4.1 0x8e4fc8, `pcie_debug__mask_tx_fifo_full_irq`
  0x8f6b88 / 4.1 `set_reg_88269c_8ee7c0` 0x8ee7c0, `mlme_sm__check_field_2c` 0x8c6888, `obj__set_field4_one`
  0x8c4ee4 / 4.1 0x8c458c, `conn__get_cid_of_obj` 0x8cbeb8, `conn__alloc_and_link__thunk_0_1_0`,
  `ftm__set_shared_active_flag` 0x8cb544 (FTM req done по адресу),
  `sm_pring__by_index`, `rf_tbl__lookup_by_module`,
  `ps_conn__profile_params_by_index` 0x8ccc7c / 4.1 0x8ca90c, `list__has_items` (первый элемент
  итератора — зовут десятки), `hw__is_fpga_platform`, `l2_mgr__has_active_pcp`,
  `seq__in_window`, `ll_detector__is_armed_b`.
  Настройка автоматов (привязка описателя к объекту через
  `basic_sm__bind_descriptor`): `obj_vt802da0__ctor` (lm_sm),
  `obj_vt801d64__ctor` (ps_mode_sm), `obj_vt801c30__ctor` +
  `ps_assoc_mgr__vt04` 0x8d8d5c / 4.1 0x8d5b68, `obj_vt801bec__ctor` + `ps_nonassoc_mgr__vt04`
  0x8d8e98 / 4.1 0x8d5d2c, `obj_vt803424__ctor` (сессия FTM). PSC:
  `sta_psc_sm__psc_done_sm` 0x8e194c / 4.1 0x8dd7c8, `ps_connection__psc_req_rx_handler`
  0x8e1990, `ps_connection__psc_rsp_rx_handler` 0x8e1be4,
  `pcp_psc_sm__psc_start_flow` 0x8e1c04 / 4.1 0x8ddad8, `ps_assoc_mgr__on_shallow_sleep_enter`
  0x8e138c, `ps_connection__copy_psc_req`.
* **Маяк PCP:** `pcp_bcon_wb` 0x8f6fec / 4.1 0x8eee38 — «free beacon memory».


## 4. Ключи

`set_gtk` 0x8e6704 / 4.1 0x8e1898 («New GTK / Fixed GTK») и `key__install_by_type` 0x8d6e68 / 4.1 0x8d4104 →
`add_key` 0x8d0edc / 4.1 0x8ce17c; `set_tk` 0x8e7140 / 4.1 0x8e2134 («New TK is handled»);
`wmi_add_key__pick_mid` 0x8cbb2c / 4.1 0x8c9ab8; `install_key_handle` 0x8f5a5c →
`vring__reinstall_keys_for_mid` 0x8ea7ac; `vring__enable_first_pending_gtk`
0x8cd0a4 («GTK key_id»); `mac_filter__write_one` 0x8df704 — упаковка флагов
ключа в битовые поля. `l2mgr__data_port_open_and_keys` 0x8f5a84 / 4.1 `l2mgr__data_port_open` 0x8ed5fc (552 Б) —
обработчик открытия порта данных (EVT_DATA_PORT_OPEN): «L2MGR Data port open
failed stream … not idle», «SET_KEYS API is sent to UCODE», «Sent KEY API to
UCODE», при неудаче — разрыв; шлёт `l2mgr__send_data_port_open_evt` и
`l2mgr__send_vring_en_evt` **[стр]**.

В 4.1 те же роли разделены между `l2mgr__data_port_open` 0x8ed5fc (320 Б),
`l2mgr__install_key` 0x8ed778 и `l2mgr__send_keys_to_ucode` 0x8ed73c («SET_KEYS API is
sent to UCODE with the following GTK») **[стр]**.

## 5. Приём management-кадра discovery и DMG-маяка **[код]**

`discovery__rx_pkt_handler` 0x8e3f0c / 4.1 0x8df338 — развилка по подтипу принятого кадра
(объект 0x843158): 4 → `discovery_handle_probe_req` 0x8f2798 / 4.1 0x8eb50c, 5 →
`discovery_handle_probe_resp` 0x8f294c / 4.1 0x8eb678, остальное (DMG Beacon) →
`dmg_bcon__rx_handler` 0x8c9404; кадр затем освобождается (`mgmt_pkt__release`).

`dmg_bcon__rx_handler` 0x8c9404 (512 Б) — обработчик принятого DMG-маяка:

1. Разбор заголовка маяка (+0xc0 разобранного кадра): два бита из байта +5.
   Если в `0x803c00+0x20` взведён **бит 9** (special_flags в g_sys_config) или
   `0x803c00+0x0c` ≠ 0 — оба бита принудительно 1, т. е. маяк пропускается
   дальше независимо от содержимого. `0x803c00+0x0c = 1` ставит `l2mgr__init`
   в режиме **R1 OOB** ([ROLELESS-LINK §1.7](ROLELESS-LINK.md#17-режим-oob-в-62-код)) — это параметр драйвера `oob_mode=1`.
2. Если MID ведёт P2P Find (+0x4c ≠ 0) — `find_mngr__detect_discovery_bcon`
   0x8c7f40 / 4.1 0x8c6d68 («FIND MNGR: Detect discovery beacon BSSID … discovery_mode») →
   `find_main_sm__first_detection`.
3. Иначе, по состоянию MID и типу BSS, — `scan_mngr__dband_beacon_ind`
   (обработка для скана).
4. Маяк своего BSS (тип 2, BSSID побайтно совпал): при включённом флаге —
   **проверка фазы**: Δ = (сейчас − время последнего маяка)·16 (системное время
   тикает по 16 мкс — ср. `u_schd__schedule`, где задержка делится на 16;
   сдвиги на 4 в `.S` оставлены сырыми байтами), остаток Δ mod n·T при
   T = BI·1000 + 2400 мкс; если остаток в (30 000, n·T − T) — печать
   «non_valid_becon, curr_systime, bcon_systime, time_since_last_loop_start» и
   отбрасывание. Единицы — мкс **[код]**.
5. Годный маяк: MID по BSSID (`mid_list__find_by` 0x8cc024 / 4.1 0x8c9e74); при включённом
   расписании — `dmg_bcon__build_allocations` 0x8df698 (разбор ESE); затем
   `conn_main_sm__inject_bcon_rx` 0x8c47e0 — впрыск события SM_EVT_BCON_RX в
   автомат соединения (объект +0x124, событие 1), и `u_schd__reschedule`
   сторожа маяков MID.

**Флаг фазовой проверки [код]** — указатель `[0x800338]` (gp+0x1b4; в `.S`
поле печатается сырым, `[gp,0x6d]` ×4). Единственный писатель —
`l2_mgr__connect_multi_omni` (инструкция 0x8c721e, из `wmi_connect`): туда
кладётся запись об AP из `l2_mgr__connect_next` (+0x0a — BI, +0x10 — время
последнего маяка, +0x06 — нужный omni). `n` — байт 0x800231. Проверка работает
только после WMI connect станции с перебором omni-секторов: маяки «своего» AP
вне ожидаемой фазы отбрасываются, пока STA ждёт маяк на нужном секторе. Без
WMI connect (безролевой/децентрализованный режим) указатель нулевой и проверка
не действует. Сбрасывающей записи в образе нет — указатель живёт до следующего
connect.

## 6. Скан (scan_mngr, channels_switch_sm, swc_psc_sm)

* Вход с хоста: `l2_mgr__aborting_scan` 0x8c1da4 / 4.1 0x8e8e70 (WMI abort; «rejected, other
  scan is ongoing»), `l2_mgr__scan_abort` 0x8e4588 / 4.1 0x8efed8 (по RF kill: стоп скана или
  P2P Find), `scan_abort` 0x8f81fc / 4.1 0x8eff54 → `scan_stop` 0x8f8368 / 4.1 0x8f0164 →
  `scan_mngr__abort_scan` 0x8f04bc / 4.1 0x8e8e0c; `scan_resume` 0x8f8304 / 4.1 0x8f00d4 →
  `scan_mngr__resume_scan` 0x8f8028 / 4.1 0x8efcc0 → `scan_mngr__kick_scan_state_machine`
  0x8f5d1c: без соединения — START_SCAN в `channels_switch_sm`, при
  соединении — в `swc_psc_sm` (скан с уходом в PS: ждёт начала SOB,
  EVT_SOB_STARTED).
* Обход каналов (`channels_switch_sm`, 0x802fb4): захват радио → настройка
  канала → «dwelling» → стоп (обработчики — [RADIO-MANAGER §4](RADIO-MANAGER.md#4-channels_switch_sm-скан--захват-радио-и-стоянка)). Пассивный скан:
  `scan_mngr__save_initial_passive_scan_info` 0x8f81c0 / 4.1 0x8efe98 при начале,
  `scan_mngr__calculate_passive_scan_info` 0x8f16ec / 4.1 0x8ea0d4 при конце стоянки;
  `scan_mngr__sm_dwelling_ended` 0x8f90e8 / 4.1 0x8f0d18 («ACTIVE SCAN — del_bcon», «MISSED %d
  Probe responses»); `scan_mngr__stop_dwelling` 0x8f9b24 / 4.1 0x8f1790.
* Активный скан: `tx_mgmt_builder_srvs__tx_mgmt_scan_probe_req` 0x8ea054 / 4.1 0x8e4cbc →
  `mgmt_tx__build_probe_req`; IE Probe: `mgmt_tx__probe_resp_ies` 0x8d7f78 / 4.1 0x8ecd10
  (SSID, DMG Cap), `ie__push_eid190_len4` 0x8e1fa4 / 4.1 0x8ef84c. Ответы:
  `discovery_handle_probe_resp` 0x8f294c / 4.1 0x8eb678 (сохраняет DMG Capabilities, RSSI/SNR,
  Wilocity VS с PBC, код страны; «[NNL] … send pkt to host») → `probe_resp_ind`
  0x8f7ae4 — выбор лучшего omni-сектора по SNR для каждого BSSID (массив
  peer_info) → `scan_mngr__prob_done` 0x8f74c4 / 4.1 0x8ef034: из pending в scanned, повтор с
  BF при LINK_ACQ/LINK_BF_FAILURE, освобождение `free_dband_info` 0x8f31a0 / 4.1 0x8ebb88.
  Таймаут ответа — `scan_mngr__prob_resp_timeout_cb` 0x8f7670 / 4.1 0x8ef1c4.
  `alloc_dband_info` 0x8f0cf8 / 4.1 0x8e94a4 — запись о найденном DMG-BSS.
* Завершение: `scan_mngr__scan_done` 0x8f8220 / 4.1 0x8f0000 — событие хосту (активный/
  пассивный), `discovery__rx_stop` 0x8f80ec / 4.1 0x8efdac, «send command to uCode scan_mode =
  FALSE» (`lmac_if_discovery_mode_cfg_handler`), чистка
  `scan_mngr__clean_all_lists` 0x8f1aa0 / 4.1 0x8ea324 и `scan_mngr__free_channel_list`
  0x8f3160, `scan_mngr__update_connected_scan_time` 0x8eaa88 →
  `l2_mgr__scan_complete_handle` 0x8e45fc / 4.1 0x8eff7c (возвращает разрешённые CID,
  возобновляет vring; строки двух сторожей скана — `scan_rm_lock_timeout_cb`,
  `scan_wd_timeout_cb`).
* Инициализация: `scan_mngr__init` 0x8f1cb8 / 4.1 0x8ea540 (автомат 0x802fb4 через
  `obj_vt802fb4__ctor` 0x8d9058), `scan_mngr__system_state_evt_handler`
  0x8e89f0 и `scan_mngr__handle_unassoc_start_evt` 0x8cdc80 (сброс времени
  скана при соединении).

## 7. P2P Find (find_main_sm 0x8030f4) и discovery

Автомат: IDLE → ALLOCATE_RADIO_LSN/SRC → LISTENING ⇄ SEARCHING → IDLE
([STATE-MACHINES](STATE-MACHINES.md)). Начало:
`find_mngr__session_start` 0x8e7ca0 / 4.1 0x8e2a8c («FIND:: Start session», событие хосту
`l2mgr__send_discovery_started`) → `find_mng__listen` 0x8dafa8 / 4.1 0x8d7e50 /
`find_mng__search` 0x8e4b8c / 4.1 0x8e0098 (оба — `discovery__rx_start`);
`find_mngr__search_phase_end` 0x8e4ca0 — «End of SEARCH phase» → снова LISTEN.
Останов: `stop_find_session` 0x8f9b48 / 4.1 0x8f17b8 → `find_mngr__stop` 0x8e7efc / 4.1 0x8e2dfc (discovery
mode off), `find_main_sm__stop` 0x8f9ac8 / 4.1 0x8f1730, `find_sm__stop_discovery` 0x8e80a4 / 4.1 0x8e2fc4,
`find_mngr__del_discovery_bcon` 0x8c8d6c / 4.1 0x8c771c (снимает discovery-маяк). В SEARCH
маяки идут в `find_main_sm__bcon` (`state_sm_8030f4__action_8f14d0` 0x8f14d0),
`find_main_sm__bcon_step` 0x8f8574, `find_main_sm__bcon_args` 0x8da8fc →
`mid__link_acquisition_action`. `find_sm__start_listen` 0x8f9670 / 4.1 0x8f138c /
`find_sm__start_search` 0x8f9920 / 4.1 0x8f1648 — входы с хоста; `find_sm__on_link_up`
0x8c48c4 — «FIND:: Link up». Захват радио для P2P Find —
`state_sm_8030f4__action_8f0dd4` 0x8f0dd4.

Probe Req в LISTEN — `state_sm_8030f4__action_8f76d8` 0x8f76d8 (488 Б): ищет
P2P IE (WFA) и WSC IE (`ies__scan_for_match` 0x8cb8ec / 4.1 0x8c9874, `ie__next_element`
0x8df474 / 4.1 0x8db1c4, `app_ie__walk_list` 0x8df404), атрибут DEVICE ID против своего
адреса; отвечает Probe Resp сам только если хост не должен («DO NOT reply …
Should be handled by HOST» для ADHOC). `discovery_is_ssid_approved` 0x8f2a90 / 4.1 0x8eb76c —
фильтр SSID «DIRECT-» (wildcard, ожидаемое содержимое, длина),
`discovery__ssid_matches` 0x8e82e0 / 4.1 0x8e3220, `str__eq_n` 0x8ddf30 / 4.1 0x8d9ff8;
`discovery__init_probe_entry` 0x8e7234 — версия Wilocity VS;
`discovery__inject_probe_evt` 0x8e11b4 / 4.1 0x8dd040.

## 8. Детектор плохих маяков

`bad_beacons_detector__arm` 0x8e7adc / 4.1 0x8e28d8 (из `lm_if__start_link_loss_monitoring`),
`bad_beacons__check_counter` 0x8c67bc, `bad_beacons_detector__is_enabled`
0x8da1cc — слоты детекторов (`detector__slot_is_free`). Пороги — из link
maintain cfg (§3). Инициализация — [L2-MANAGER §5](L2-MANAGER.md#5-контроль-потери-связи-link-loss).

## 9. Списки, пулы, MID

Списки: `list__find_entry` 0x8c2638 и варианты `list__find_entry_b` 0x8c26b4,
`list__find_entry_c` 0x8c25b0, `list__find_entry_d` 0x8c25f4 — поиск/вставка в
двусвязный список (с проверками целостности, фатал); `mem_pool__init` 0x8c7cf8 / 4.1 0x8c6c70
— инициализатор пула (`mem_pool__link_free_list` + проверка), его зовут все
`*_pool__init`; `sm__init_defer_pool` 0x8d9b58. `bcon_ctrl__prepare_mid_fw`
0x8f8624 / 4.1 `bcon_ctrl__prepare_mid` 0x8f02d4 — подготовка MID к PCP start (безопасность, DMG-параметры по
умолчанию). `mid__lookup_at_48` 0x8eaab0, `mid__init_find_sm` 0x8d9588 / 4.1 0x8d653c,
`mid__init_scan_and_pools` 0x8d9660 (открытие MID: пулы, find SM, скан),
`radio_req__addr_of` 0x8f3698, `obj_vt8030f4__ctor` 0x8f532c (настройка
автомата find). `llc_snap__write_header` 0x8d7d90 / 4.1 0x8ec598, `ie__scan_buf_10` 0x8e27bc,
`scan_mngr__update_step` 0x8cbee8 (TSF), `scan_mngr__free_with_842c74`
0x8f3154, `conn_tbl__slot_is_free` 0x8da10c / 4.1 `get_g_80469c` 0x8d7030, `power_mngr__post_evt5` 0x8c3e90,
`radio_mgr__get_current_channel` 0x8cc130, `mids__get_count` 0x8cc484,
`scan_mngr__entry_addr` 0x8cc6a4.
* **Скан/калибровка/пулы:** `mid_list__find_by_kind` 0x8cc424 / 4.1 0x8ca1f8,
  `calib_engine__cancel_timer` 0x8c68ec и `vring__find_busy_index` 0x8ccfe4 / 4.1 0x8cacf4
  (перезапуск схем калибровки ждёт свободный vring), `pring__init_pool`
  0x8d8cb0 (пулы при остановке SW data), `tx_ring__advance_index`,
  `macq__kick_queue` 0x8e1c7c, `tx_desc__init_32` 0x8e9bf4 (заполнение
  TX-дескриптора).

## Замечания

* Имена 6.2 `discovery__rx_pkt_handler` и `channels_switch_sm__action_pop_ch_and_tune`
  сопоставлены с 4.1 по совпадению тела; разбор имён — [HOST-INTERFACE.md](HOST-INTERFACE.md#замечания).

## Не установлено

* Последствия несброшенного указателя фазовой проверки `[0x800338]` при
  переподключении (§5).

## Источники

* `6.2/src/asm/fw/blocks.json`, `4.1/src/asm/fw/blocks.json`, `6.2/ref/CORRELATION-FW.txt`,
  [6.2/ref/SM-TABLES.txt](../6.2/ref/SM-TABLES.txt).
* [HOST-INTERFACE.md](HOST-INTERFACE.md), [STATE-MACHINES.md](STATE-MACHINES.md),
  [ROLELESS-LINK.md](ROLELESS-LINK.md), [ESE.md](ESE.md), [RADIO-MANAGER.md](RADIO-MANAGER.md).
