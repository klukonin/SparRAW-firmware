# Слой L2: инициализация, подъём MAC, интерфейс с ucode, события хосту

Менеджер второго уровня прошивки (`layer2_mgr`): инициализация после готовности LMAC,
подъём MAC, кольца и почтовые ящики fw↔ucode, контроль потери связи, планировщик
vring, рассылка состояния системы, события хосту и обработчики WMI настройки BSS.
Подсистема есть в 4.1.0.1000 и 6.2.0.1000 **[обе]**; порядок `main()` и место в нём
`l2mgr__init` — [HW-DRIVERS.md §1](HW-DRIVERS.md#1-загрузка-main-прошивки), транспорт
команд LMAC — [LMAC-PROTOCOL.md](LMAC-PROTOCOL.md), режим OOB —
[ROLELESS-LINK.md](ROLELESS-LINK.md).

Метки: **[код]** — по листингу, **[стр]** — по собственной лог-строке блока,
**[выз]** — по вызывающим/вызываемым, **[гипотеза]** — не проверено.
Запись адреса: `имя` 0x… — адрес 6.2; «/ 4.1 0x…» — адрес той же функции в 4.1
(по совпадению тела — `6.2/ref/CORRELATION-FW.txt`, по таблице
[NAMES-FROM-62](../4.1/docs/NAMES-FROM-62.md) или по имени); если в 4.1 имя другое,
оно указано. Функции без пометки 4.1 — соответствие не установлено. Адреса данных — 6.2.

## 1. Инициализация L2 **[код]**

`l2mgr__init` 0x8f55b8 / 4.1 0x8ed398; зовёт его `l2mgr__on_lmac_ready`
0x8e78b8 / 4.1 0x8e2668 (вместе с `rf_kill_sm__init`). Сначала читается режим OOB
(биты 31..29 регистра 0x880018) — [ROLELESS-LINK §1.7](ROLELESS-LINK.md#17-режим-oob-в-62-код).
Дальше всегда: пулы MID-контекстов (`mid_ctx__init_pools` 0x8d91f4), пул
0x847b48/0x847f80 (`vring_tbl__init` 0x8d8c7c), периодический детектор с
периодом 10 000 000 (`l2mgr__init_periodic_detector` 0x8d8ce0 — к OOB
отношения не имеет), детекторы потери связи (`link_loss_detectors__init`, §5),
подъём MAC (§2), кольца (`l2mgr__reset_oob_rings` 0x8e4058 / 4.1 0x8df490), RX/TX MACQ по
умолчанию (`l2mgr__oob_pair` 0x8fb480 → `rx_macq__setup_default`,
`l2mgr__config_default_tx_ring` 0x8d9948), ToF-инициализация и первая рассылка
состояния системы (`sys_state__broadcast` 0x8e8a14, §7).

## 2. Подъём MAC — `l2mgr__mac_bringup` (порядок вызовов) **[код]**

`l2mgr__mac_bringup` — 4.1 0x8ee6cc.

`hwd_mac__enable_multicast` 0x8d0ebc / 4.1 0x8ce15c («Enable Multi Cast traffic») →
`mac_bringup__init_seq` 0x8fa6c4 (секторные дескрипторы RF-цепочки,
`tx_queue__config_by_mode`, поля 12-битных параметров) →
`mac_bringup__init_rx_desc` 0x8f8144 / 4.1 0x8efe10 → 0x8f7f38 (в дереве —
`ftm_main_sm__radio_allocated_cb`; присутствие в цепочке подъёма MAC не
объяснено) → `mac_parser__configure` 0x8f6d54 / 4.1 0x8ee9cc (фильтры 0x886200/0x886260) →
`mac_bringup__prog_881000` 0x8f3e5c / 4.1 0x8ec114 → `mac_bringup__prog_881b00` 0x8f6c4c / 4.1 0x8ee8a8 →
`vring__reg_write_locked_0c` 0x8d04d8 / 4.1 0x8cd64c → **`lmac_if__send_init_cfg` 0x8f3db8 / 4.1 0x8ec070**
(LMAC cmd 0x00) → `l2mgr__bringup_pair` 0x8dd8d0 (два PHY-блока
0x883000/0x884000) → `mac_bringup__init_dma_ctrl` 0x8fa7e8 / 4.1 `set_reg_886a00_x2` 0x8f28a4 →
`mac_bringup__init_tx_queues` 0x8fa7a4 / 4.1 0x8f2860 (0x886c00) → `mac__set_886838_b0`
0x8f811c → `mac_bringup__set_886a80_ctl_bit0` 0x8f6c34 → по условию
`mac_bringup__ack_and_unmask_irqs` 0x8f6b0c / 4.1 `mac_bringup__program_886800` 0x8ee720.

Тело команды 0x00 и живые значения регистров таймингов обеих версий —
[LMAC-PROTOCOL.md §3.1](LMAC-PROTOCOL.md#31-команда-0x00-fui_cmds_hw_cfg_ifs_timing_cfg_s-по-body0x30-код-железо-пак).

## 3. Готовность LMAC

`lmac_if__lmac_ready_evt` 0x8f61b0 / 4.1 0x8ede5c — обработчик «LMAC READY» («LMAC READY ::
driver_is_up_sts»; строка «lms_stopped()…» принадлежит соседнему
`mlme_sm_8027a0__action_8f6230` 0x8f6230): чтение калибровки RFC, конфиг TXSS,
LMAC cmd 0x04 и 0x23, `lmac_if__send_phy_ina_det_cfg`, светодиоды,
`lmac_if__send_fw_ready_evt`, `l2mgr__on_lmac_ready`.
`edca__fill_ac_table_by_mode` 0x8dc28c — сборка тела LMAC cmd 0x04.

## 4. Кольца и ящики

`lmac_if__build_cmd_rings` 0x8f94e4 / 4.1 0x8f11b4 и `mbox__init_descriptor` 0x8f942c — пулы
(`mem_pool__init`, [MLME §9](MLME.md#9-списки-пулы-mid)) и дескрипторы колец `ring__init_desc` 0x8d8b00 / 4.1 0x8d5898;
`debug_mbox__get_or_init` 0x8d9f9c — «Debug MBOX init» (0x88042c);
`mbox__consume_one` 0x8e3764 / 4.1 `mbox__ring_init` 0x8decf8, `mbox__load_obj_word4` 0x8cca38 / 4.1 `deref_0_4` 0x8ca7f4;
`fw_mailbox__has_pending` 0x8c37ec / 4.1 0x8c30bc; `ring__is_full` 0x8da2d8 / 4.1 0x8d7220,
`ring__is_full_8db1ec` 0x8df49c / 4.1 0x8db1ec; `lmac_if__echo_pair` 0x8c32e8 (эхо-событие
ucode). События ucode: `lmac_if__evt_walk` 0x8e1cd8 (обход записей, первое
поле `lmac_if__evt_first_field` 0x8c65fc, запись 0x886f84 ×3 —
`sched__program_alloc_slot_regs` 0x8d0ea8), `lmac_if__ucode_evt_check_8`
0x8db240 → `mid__lookup_step` 0x8f5f5c, `lmac_if__forward_evt_to_obj`,
`upm_immediate_rsp` 0x8eadb4 (пусто), `lmac_if__rs_done_params` 0x8c2c5c
(результат Rate Search → автомат). `l2_mgr__lmac_high_false_alarm_evt_handler`
0x8f5f90 / 4.1 0x8edc48 — по событию ложных тревог берёт вторичный захват радио.

## 5. Контроль потери связи (link loss)

`lm_if__stop_link_loss_monitoring` 0x8e7fbc / 4.1 0x8e2ed0 (+хвост
`conn_mgr__stop_link_loss_monitoring` 0x8e7fb4) →
`bad_beacons_detector__stop_monitoring` 0x8e8050 / 4.1 0x8e2f70, `lm_if__stop_link_a` 0x8e806c
(keep-alive: `ka__check_peer_state` 0x8c67f0), `lm_if__stop_link_b` 0x8e8088
(TX ageing). `tx_ppdu_ageing_timeout_detector__start_monitoring` 0x8e7bc4 / 4.1 0x8e29d4 —
период проверки и порог TX ageing из link maintain cfg.
`ll_detector__is_armed`, `lmac_evt__entry_end`, `rf_if__tx_sectors_vcall_14` —
поля детекторов/TXSS. `lm_sm__action_8daed8` 0x8daed8 — конфиг BF-автомата
LMAC и TXSS, затем BF и параметры RS.
* **Детекторы потери связи — инициализация:** `link_loss_detectors__init`
  0x8d94f0 (из `l2mgr__init`) зовёт `bad_beacons_detector__init`
  (`detector__init_per_cid_c`) 0x8d90a8 / 4.1 0x8d5f8c, `detector__init_per_cid_a` 0x8d9134,
  `detector__init_per_cid_b` 0x8d91b4, а те — `detector__init_common` 0x8d8fa0 / 4.1 0x8d5e80 и
  `bad_beacons__check_counter`: инициализация трёх детекторов (bad beacons,
  keep-alive, TX ageing) **[выз]**; к таблице секторов отношения не имеет.

## 6. vring и pring (планировщик vring)

`vring_schd__remove_vring` 0x8c8e90 / 4.1 0x8c7858, `vring_schd__flush_response` 0x8dda68 / 4.1 0x8d9b58
(«VR-Scheduler handles uCode Flush Response»), `vring__reg_write_locked_28`
0x8d0538 / 4.1 0x8cd6ac, `vring__stop_hw` 0x8e0eec (стоп vring по таймауту pring),
`pring__find_by_id` 0x8cd00c, `sm_pring__notify_step` 0x8eaa38 (TSF-метка),
`macq_hw__disable_queue_fw` 0x8d0c9c (80 Б — шаг состояния pring),
`mac_enable_bcast_ring` 0x8c14d4 / 4.1 0x8c1498.

## 7. Рассылка состояния системы и задачи детекторов

Блоки 0x8e8a14…0x8e8de4 (1672 Б, пять функций):

| адрес | имя | назначение |
|---|---|---|
| 0x8e8a14 | `sys_state__broadcast` | рассылка события состояния системы: вычисляет «система простаивает» (`l2_mgr__chk_sys_idle` 0x8c6508 / 4.1 0x8c5838 — свободные MID, биты занятости) и по очереди зовёт `temp_sense__on_system_state`, `power_mgr_ut__dispatch`, `CALIB_MNGR__system_state_evt_handler`, `conn_mgr__system_state_evt_handler`, `phy_monitor__on_system_state` (список 0x84e7e0), `scan_mngr__system_state_evt_handler`. Зовут connect, pcp_start/stop, скан, P2P listen/search, data port open, discovery stopped |
| 0x8e8a70 | `vring_schd__move_ready_if_idle` | поиск vring в списке 0x804dbc и перевод в готовые (`vring_schd__move_to_ready`), если DMA свободен |
| 0x8e8ac0 | `phy_stats__dump` | печать счётчиков PHY: CRC заголовка CP/SC, BER, усиление АЦП, INA RSSI, AGC omni/direct, индексы усиления RF RX/TX ([HARDWARE-BLOCKS](HARDWARE-BLOCKS.md#счётчики-приёма-phy-код--железо)) |
| 0x8e8bfc | `ka_necessity_detector__task` | `ka_necessity_detector::task` — нужен ли keep-alive: при необходимости «Initiating CMD_KEEP_ALIVE_TRIGGER to uCode»; вектор flush_no_ack и пропущенных слотов |
| 0x8e8de4 | `tx_ppdu_ageing_timeout_detector__task` | `tx_ppdu_ageing_timeout_detector::task` — «Link-Loss detected … Initiating disconnect flow», в т. ч. «missing ack for ATIM in 10 consecutive beacons»; дамп памяти при порче cid |

`sys_state__broadcast_7` 0x8f2790 и `sys_state__broadcast_16` 0x8dd8e4 — хвосты
к рассылке.

## 8. События хосту и почтовый ящик

`host_if__send_pair` 0x8c32d8 — общий путь событий L2 хосту (выделение из пула
+ постановка, `tx_api__ctx_8041f0` 0x8d9f7c — проверка готовности ящика,
фатал); `wmi_evt__fill_payload` 0x8cadf8 и `wmi_evt__walk_list` 0x8cafb4 —
сборка события из списка фрагментов; `low_sme__send_evt2_body` 0x8cb1bc /
`low_sme__check_state_1` 0x8cb0b4 («mailbox free_mem»); `fw_mailbox__is_empty`
0x8da150 / 4.1 0x8d7078; `l2mgr__pending_op_clear`, `l2mgr__pending_op_set` — счётчик/флаг
событий; `host_if__hw_ready_for_wmi` 0x8da5a4 / 4.1 0x8d74d8 (RF присутствует, не RF-kill);
`host_if__connect_rf_kill` 0x8ec484 / 4.1 0x8e7774 («Connect IGNORED due to RF-KILL»);
`low_sme__termination_check` 0x8e9110 / 4.1 0x8e426c; `oob__mode_flags_default` 0x8ccaf0
(состояние RF management); `pcie__set_event_bit_0_fw_ready` 0x8d1af8 — бит
события PCIe при FW READY; `pcie__set_traffic_deferral_flag` 0x8d1b10 / 4.1 `rgf_reg_88b080` 0x8cee78 —
traffic deferral/resume.

## 9. WMI-обработчики и настройка BSS

`mid__reset_bss_defaults` 0x8c4d24 — сброс/заполнение BSS при старте MAC и
останове discovery (режим BSS, SSID, область IE, MAC-адрес, EDCA по умолчанию
`l2mgr__set_edca_defaults` 0x8d97a4 / 4.1 0x8d6724, битовые поля 5-битных возможностей);
`l2mgr__apply_mac_address` 0x8e6368 / 4.1 0x8e15f0 (0x881b00, команда LMAC через кольцо,
парсер MAC), `mac__apply_multicast_addr` 0x8e68b4 / 4.1 0x8e1a68; `l2mgr__config_security`
0x8f1c84 / 4.1 0x8ea510 («m_wpa_offload, auth_mode»); `p2p_cfg` 0x8f6d20 / 4.1 0x8ee994;
`tx_api__set_mgmt_retry_limit` 0x8e6900 (лимит повторов mgmt),
`pring__set_done_handler` 0x8e7334 (из `wmi_enable_fixed_scheduling`);
`mac__read_880a00_0c`, `mac__read_880a2c_38`, `obj__set_vtable__8f3560` —
версии для `wmi_fw_ver` и загрузчика; `wmi_power_mgmt_cfg` 0x8ec350;
`ut_hw_drivers__reply_not_supported` 0x8cdb18; `link_stats__fill_sta_entry`
0x8ca554 (пропускная способность по счётчикам);
`mid_list__any_in_state2_fw` 0x8c37ac / 4.1 `mid_list__any_in_state2` 0x8c307c (проверка «уже соединены» для
скана/P2P/connect); `l2mgr__program_args` 0x8c6c04; `l2mgr__notify_link_up`
0x8cd76c / 4.1 0x8ebec0; `link_up_evt` 0x8dacec (FTM: EVT_FTM_START_SESSION);
`ftm__send_timeout_cb` 0x8f3254 («ftm_send_to»); `l2mgr__apply_key_to_prings`
0x8fa7f8 / 4.1 0x8f28b4; `fw_main__init_frame_pool_thunk` 0x8ea694 / 4.1 `tail_l2mgr__init_frame_pool` 0x8e5350.

Впрыски событий в автоматы (тонкие обёртки над `basic_sm__handle_event`):
`basic_sm__handle_event__r1_5_r2_0` 0x8c1d98 / 4.1 `tail_basic_sm__inject_event` 0x8c1b38, `basic_sm__handle_event__r1_4_r2_0`
0x8de384, `basic_sm__handle_event__r1_2_r3_0` 0x8dffe4, `conn__sm_handle_event`
0x8d9cc0, `sm_obj__reset_evt5` 0x8e1354, `conn__inject_evt3` 0x8dc4cc / 4.1 0x8d8ea0,
`conn__inject_evt4` 0x8cb69c / 4.1 0x8c9688, `wmi__host_cmd_at_124` 0x8de364, `new_link_evt`
0x8cc158, `queue_deleted_evt` 0x8dc4a4, `psc_if__post_req_sm_event` 0x8e1af8.

## 10. Ошибка печати «I'm ROOT» **[код]**

Лог «[Mid:%d] I'm ROOT: ADDR-%04X%08X» (`l2mgr__set_mac_address` 0x8fbc64 / 4.1 0x8f3284) печатает неверный адрес: функция копирует 6 байт MAC на стек и
передаёт в печать `ld [sp]` (байты 0–3) и `ldb [sp+2]` (байт 2) вместо байтов
4–5. Поэтому 26:18:1d:24:3b:0b выводится как `ADDR-001D241D1826`. Сам адрес
(`l2mgr__apply_mac_address`, мультикаст) применяется целиком — это ошибка
печати в вендорском коде, а не порча MAC.

## Замечания

* `l2mgr__init_periodic_detector` 0x8d8ce0 не связан с режимом OOB.

## Не установлено

* Тела задач `mbox__drain_operational` 0x8e378c, `mbox__drain_debug` 0x8e37c8
  (почтовые ящики) и `lmac_mbox__drain_task` 0x8ca22c (бит 9 user-ICR,
  [HW-DRIVERS §2.2](HW-DRIVERS.md#22-user-icr-хоста-0x880b50-код)).
* Присутствие 0x8f7f38 (`ftm_main_sm__radio_allocated_cb`) в цепочке подъёма MAC.

## Источники

* `6.2/src/asm/fw/blocks.json`, `4.1/src/asm/fw/blocks.json`, `6.2/ref/CORRELATION-FW.txt`.
* [HW-DRIVERS.md](HW-DRIVERS.md), [LMAC-PROTOCOL.md](LMAC-PROTOCOL.md), [MLME.md](MLME.md),
  [ROLELESS-LINK.md](ROLELESS-LINK.md), [DATAPATH.md](DATAPATH.md),
  [HARDWARE-BLOCKS.md](HARDWARE-BLOCKS.md).
