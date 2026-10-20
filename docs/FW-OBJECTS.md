# C++-каркас прошивки: объекты, классы, синглтоны

Прошивка обеих версий написана на C++ (имена вида `class::method`
восстановлены из лог-строк, см. `6.2/ref/FN-NAMES.txt`, `4.1/ref/FN-NAMES.txt`).
Документ описывает, как в образе представлены объекты, какие синглтоны и
классы известны, и общие для версий объекты `vif/mid`, `bss`, RX-пул и
`radio_manager`. Адреса помечены версией: **[4.1]**, **[6.2]**, **[обе]**.

Разметка структур 4.1 по членам — [4.1/docs/STRUCTS.md](../4.1/docs/STRUCTS.md),
`g_dbg_dashboard` 4.1 — [4.1/docs/DASHBOARD.md](../4.1/docs/DASHBOARD.md),
автоматы `basic_sm` — [STATE-MACHINES.md](STATE-MACHINES.md).

## 1. Представление объектов в коде **[обе]**

| сегмент | как адресуются поля | чем восстанавливать |
|---|---|---|
| ucode | база объекта грузится в регистр (`mov rN, base`), поля — `ld/st [rN,off]` | трекинг регистра (см. [UCODE-TASKS.md](UCODE-TASKS.md)) |
| fw | объект статический, `obj.field` свёрнут компилятором в **отдельный абсолютный адрес** | кластеризация соседних глобалов обратно в объекты |

В fw трекинг регистра даёт почти ничего (3 «поля» на 60 обращений), но
соседние адреса и есть поля одного объекта: дельты между соседними глобалами —
4/8/12/16/20/32 байта, 38 % соседей лежат в пределах 16 байт. Статические
синглтоны лежат в `fw_data`.

Исключение — объекты из пулов (`mem_pool__init`) и объекты с vtable, к которым
код обращается через указатель: `mid`, `bss`, `rm_sm`, элементы RX-пула.
Их поля адресуются смещением от базы (раздел 4).

### Метод
1. Собрать абсолютные адреса глобалов fw (`6.2/ref/GLOBALS-fw.txt`).
2. Кластеризовать по зазору ≤ 32 Б; кластер = объект, адреса внутри = члены.
3. Класс-владелец — голосование по именам функций, обращающихся к кластеру.
   Инстанс приписывается классу, если все классовые ссылки на кластер
   принадлежат одному классу.

Результат для 6.2: 258 глобалов → 109 объектов.

## 2. Синглтоны 6.2 **[6.2]**

### С однозначным классом-владельцем

| адрес | размер | полей | обращений | класс |
|-------|--------|-------|-----------|-------|
| `0x803d5c` | 0x58 | 5 | 17 | **PS_CFG_SCHEME** (power-save профили) |
| `0x803b18` | 0x6c | 8 | 16 | **RADIO_MGR** |
| `0x8038e0` | 0x2c | 6 | 9 | **RADIO_MGR** (второй объект того же класса) |
| `0x805140` | 0x34 | 3 | 14 | **l2_mgr** |
| `0x8031b8` | 0x5c | 6 | 8 | **TX_API** |
| `0x804c34` | 0x10 | 3 | 8 | **low_sme** |
| `0x8019bc` | 0x34 | 3 | 7 | **TEMPERATURE_SERVICE** |
| `0x803d10` | — | 1 | 8 | **POWER_MNGR** |
| `0x806518` | — | 1 | 6 | **tof_mgr** (FTM/AOA) |
| `0x80426c` | 0x18 | 2 | 21 | `lmac_if_*` (интерфейс к LMAC) |
| `0x80359c` | 0x68 | 6 | 8 | `hw_sysapi_*` (PLCP/энергия RX) |
| `0x803934` | 0x60 | 8 | 7 | `hwd_abif_rx_table_*` (таблицы VGA gain) |
| `0x8023b8` | 0x48 | 7 | 8 | `set_app_ie` / `remove_app_ie` (IE-хранилище) |
| `0x805fe4` | 0x34 | 3 | 9 | `init_bcast_queue` |

### Крупные разделяемые объекты

| адрес | размер | полей | обращений | примечание |
|-------|--------|-------|-----------|------------|
| `0x8004a0` | **0xd4** | 20 | 42 | крупнейший; тяготеет к `scan_mngr` |
| `0x803c00` | 0x24 | 2 | **44** | `l2_mgr`, `maintain_sm`, `scan_mngr`, `discovery_*`, `schedule_scheme_builder` — общий контекст линка |
| `0x8042c8` | — | 1 | **60** | самый разделяемый одиночный word: POWER_MNGR, RADIO_MGR, TEMPERATURE_SERVICE, calib_*, bcn_tx_* — глобальный флаг/состояние устройства, не объект |
| `0x8037ec` | 0x50 | 8 | 10 | без явного владельца |

Для классов с эксклюзивным владением (`PS_CFG_SCHEME`, `RADIO_MGR`, `TX_API`,
`low_sme`, `TEMPERATURE_SERVICE`, `tof_mgr`) пара «объект + список методов»
даёт каркас класса: адрес инстанса, размер, число членов и методы.

## 3. Карточки классов **[6.2]**

Сведение трёх источников: методы из лог-строк (`6.2/ref/FN-NAMES.txt`),
инстансы из кластеризации (раздел 2), таблицы переходов автоматов
([STATE-MACHINES.md](STATE-MACHINES.md)). Формат: инстанс (адрес, размер,
членов, обращений), смещения членов, методы.

Классы `rm_main_sm`, `find_main_sm`, `maintain_sm` содержат action-функции
автоматов `RADIO_MANAGER_MAIN_SM`, `FIND_MAIN_SM`, `MAINTAIN_SM`, опознанных
независимо по name-таблицам описателей; имена классов и автоматов совпадают.

| класс | инстанс | члены | методы | автомат |
|---|---|---|---|---|
| `l2_mgr` | 0x805140 / 0x34, 3 чл., 14 обр. | +0x0, +0x20, +0x30 | (25) aborting_scan, connect_multi_omni, connect_multi_omni_cb, scan_abort, scan_complete_handle, tof_config_responder, tof_ftm_req, tof_get_capabilities, validate_scan, wmi_cmd_handler_del_sta, wmi_cmd_handler_get_mgmt_retry_limit, wmi_cmd_handler_new_sta, wmi_cmd_handler_set_mgmt_retry_limit, wmi_scan_cmd, connect, lmac_high_false_alarm_evt_handler, lmac_new_link_evt_handler, pcp_start, pcp_stop, send | — |
| `scan_mngr` | 0x8054ec / 0x4, 1 чл., 4 обр. | +0x0 | (24) dband_beacon_ind, handle_link_up_event, handle_unassoc_start_evt, sob_awake_bi_ntf, system_state_evt_handler, update_connected_scan_time, abort_scan, calculate_passive_scan_info, clean_all_lists, config_dwell_time, connect, dwelling_done, free_channel_list, handle_abft_bf_result_in_scan, kick_scan_state_machine, prob_done, resume_scan, save_initial_passive_scan_info, scan_done, send_prob_req, sm_d | свой автомат скана (`kick_scan_state_machine`) |
| `fw_sysapi_mgr` | — | — | (11) channel_estimation_cmd_complete, complete_pending_request, start_energy_statistics, get_flush_statistics_cmd_start, get_rssi_and_snr_statistics, mac_ampdu_statistics_cmd_start, phy_rx_statistics_cmd_start, start_plcp_header, send_evt2host, start_sysapi_cmd, stop_sysapi_cmd | — |
| `conn_mgr` | — | — | (9) activate_conn, add_to_rinking_list, allocate_cid_db_element, apply_default_link_maintain_cfg, free_cid_db_element, link_down_evt, link_up_evt, print_link_maintain_cfg, set_link_maintain_cfg | — |
| `TX_API` | 0x8031b8 / 0x5c, 6 чл., 8 обр.; 0x805ac0 / 0x4, 1 чл., 2 обр. | +0x0, +0x8, +0x10, +0x30, +0x50, +0x58; второй: +0x0 | (9) alloc_tx_payload, awake_peer_ntf, callback_and_release, flush_pending_peer_pm_connection, free_memory, handle_completed_packets, post_tx_payload, send_dband_bcon, send_packet | — |
| `brd_if_multi_array` | 0x8022c0 / 0x4, 1 чл., 1 обр. | +0x0 | (8) get_chunk, find_section, get_board_file_format_version, get_chunk_in_address_data_pairs_format, get_chunk_in_data_only_format, init, physical_section_header_u, verify_board_file_format_version | — |
| `marlon_r_if_class` | 0x801fa4 / 0x4, 1 чл., 4 обр. | +0x0 | (7) config_channel, load_brd_parameters_section, load_brd_rf_cfg_section, rf_configure_role_power, rf_hw_write_buffer, rf_write_with_block_retries, init_board_file_interface | — |
| `tof_mgr` | 0x806518 / 0x4, 1 чл., 6 обр. | +0x0 | (6) ftm_req_handle, aoa_session_start, clean_all_lists, ftm_error_handler, ftm_req_done, ftm_req_handle | — |
| `stream_mgr` | 0x802424 / 0x38, 6 чл., 5 обр. | +0x0, +0x8, +0x14, +0x24, +0x2c, +0x34 | (5) action, addba_req_handler, addba_rsp_handler, delba_handler, delete_vring | — |
| `sta_psc_sm` | — | — | (5) m_psc_resp_rx_wb_timeout_event, m_psc_req_tx_wb_timeout_event, IDLE, psc_done_sm, send_psc_req_flow_sm | STA_PSC_SM |
| `PS_CONNECTION` | 0x801d54 / 0x14, 3 чл., 3 обр. | +0x0, +0x8, +0x10 | (4) assoc_ntf, awake_peer_ntf, disassoc_ntf, psc_complete | — |
| `wmi_handler_get_rf_sector_params` | 0x8021b0 / 0x3c, 5 чл., 5 обр. | +0x0, +0x18, +0x28, +0x30, +0x38 | (4) check_inputs_valid, handle, on_radio_locked_cb, set | — |
| `wmi_handler_set_rf_sector_params` | — | — | (4) verify_inputs, handle, set_rf_sector_params, set | — |
| `POWER_MNGR` | 0x803d10 / 0x4, 1 чл., 8 обр. | +0x0 | (4) halt, deep_sleep_exit, wmi_ps_dev_profile_cfg_cmd, wmi_traffic_deferral_cmd | — |
| `lm_if` | — | — | (4) disable_link_loss_monitoring, set_cid, start_link_loss_monitoring, stop_link_loss_monitoring | — |
| `calib_silent_rssi_sparrow` | 0x80220c / 0x2c, 3 чл., 5 обр. | +0x0, +0x18, +0x28 | (4) find_agc_start, find_rf_gain, run_calibration_fragment, set_agc_start_val | — |
| `low_sme` | 0x804c34 / 0x10, 3 чл., 8 обр. | +0x0, +0x8, +0xc | (4) handle_rf_kill, termination_check, wmi_rf_mgmt_cmd_handler, wmi_scan_cmd_handler | — |
| `psc_if` | — | — | (4) init, start_psc, psc_req_tx_wb_cb, psc_resp_tx_wb_cb | — |
| `RADIO_MGR` | 0x8038e0 / 0x2c, 6 чл., 9 обр.; 0x803b18 / 0x6c, 8 чл., 16 обр. | +0x0, +0x4, +0xc, +0x14, +0x1c, +0x28; второй: +0x0, +0x14, +0x28, +0x3c, +0x48, +0x50, +0x58, +0x68 | (4) remove_request, set_primary_channel, unset_primary_channel, init | — |
| `WBE_DRIVER` | — | — | (4) link_down_notif, link_up_notif, pxe_isoc_in_dir_bypass, CLOSE | — |
| `find_mng` | — | — | (3) add_bcon, listen, search | — |
| `fwq_tx` | — | — | (3) add_packet, long_retry_failures, flush_list_packets_by_cid | — |
| `schedule_scheme_builder` | — | — | (3) build_allocations_from_beacon, build_allocations, build_allocations | — |
| `rm_main_sm` | — | — | (3) enter_primary_non_locked, kick_channel_switch_sm, lock_primary | RADIO_MANAGER_MAIN_SM |
| `SW_TX_MGMT_API` | — | — | (3) link_up_evt, packet_release, send_packet | — |
| `conn` | — | — | (3) linkup_ntf, abort, disconnect | — |
| `find_main_sm` | — | — | (3) bcon, first_detection, stop | FIND_MAIN_SM |
| `ba_setup_sm` | — | — | (3) close_addba_req_retry_timeout_event, close_addba_resp_timeout, close_ba_setup_global_timeout | BA_SETUP_SM |
| `discovery` | — | — | (3) rx_start, rx_stop, tsf_wa | — |
| `maintain_sm` | 0x80147c / 0x4, 1 чл., 3 обр. | +0x0 | (2) config_mcs_en_vec, release_radio_after_bf_evt | MAINTAIN_SM |
| `TEMPERATURE_SERVICE` | 0x8019bc / 0x34, 3 чл., 7 обр. | +0x0, +0x10, +0x30 | (2) read_rf_sensor_calibration_parameters, timer_exp_handler | — |
| `lm_main_sm` | 0x8014b0 / 0x4, 1 чл., 2 обр. | +0x0 | (1) config_lmac_bf_sm | LM_MAIN_SM |
| `Calib` | 0x801930 / 0x4, 1 чл., 1 обр. | +0x0 | (1) Measure_VGA_Gains | — |
| `IF_GAIN` | 0x801954 / 0x2c, 3 чл., 2 обр. | +0x0, +0x14, +0x28 | (1) GAIN | — |
| `PS_CFG_SCHEME` | 0x800a28 / 0x3c, 4 чл., 5 обр.; 0x803d5c / 0x58, 5 чл., 17 обр. | +0x0, +0xc, +0x24, +0x38; второй: +0x0, +0x20, +0x34, +0x44, +0x54 | (1) switch_active_ps_profile | — |

### Назначение классов
- **`l2_mgr`** — центральный класс уровня 2: скан (`validate_scan`,
  `scan_abort`, `scan_complete_handle`), соединение (`connect`,
  `connect_multi_omni`), PCP (`pcp_start/stop`), WMI-обработчики
  (`wmi_cmd_handler_new_sta/del_sta`), ToF (`tof_ftm_req`,
  `tof_get_capabilities`), события LMAC (`lmac_new_link_evt_handler`,
  `lmac_high_false_alarm_evt_handler`).
- **`scan_mngr`** — полный цикл скана; `kick_scan_state_machine` указывает на
  отдельный автомат скана.
- **`RADIO_MGR`** — два инстанса (0x8038e0/0x2c и 0x803b18/0x6c) **[гипотеза]**
  primary/secondary радио, что согласуется с состояниями `RM_ST_PRIM_*` /
  `RM_ST_SECONDARY` автомата RADIO_MANAGER_MAIN_SM.
- **`TX_API`** — два инстанса (0x8031b8/0x5c и 0x805ac0/0x4).
- **`brd_if_multi_array`**, **`marlon_r_if_class`** — разбор board-файла и
  конфигурация RF (`get_board_file_format_version`, `find_section`,
  `load_brd_rf_cfg_section`, `rf_configure_role_power`) — потребитель формата
  .brd в прошивке (хостовая сторона — утилита `wil_brd.py`).
- **`PS_CONNECTION`**, **`psc_if`**, **`sta_psc_sm`**, **`PS_CFG_SCHEME`**,
  **`POWER_MNGR`** — слой power-save; в сборке UBNT он отсутствует целиком
  (см. [STATE-MACHINES.md §4](STATE-MACHINES.md#4-сборка-ubnt-сравнение-инвентаря)).

## 4. Общие объекты: vif/mid, bss, RX-пул, radio_manager

Эти объекты создаются через `mem_pool__init` и адресуются от базы. Описание ниже
общее для версий; адреса и полная разметка по членам установлены для 4.1 —
[4.1/docs/STRUCTS.md](../4.1/docs/STRUCTS.md).

### Пул памяти `mem_pool`
Дескриптор пула: `+0x00 head`, `+0x04 база`, `+0x08 размер элемента`,
`+0x0c` (0 при init), `+0x10 кол-во`. `mem_pool__link_free_list` прошивает
свободный список: `*элемент = предыдущий head; head = элемент; элемент += [desc+8]`.
Порядок элементов в свободном списке произволен и зависит от истории
alloc/free — указатели `next` в дампе не являются структурными полями.

### vif / mid
Виртуальный интерфейс (MAC-сущность). Один экземпляр в пуле из одного
элемента. Содержит узел `llist`, собственный MAC, mid id, тип сети (маска
1/2/4/0x10/0x20), RSN IE по умолчанию, подобъект PCP с vtable,
объект программирования MAC в HW. **[4.1]** база 0x8058f0, размер 0x2e4.

### bss
Вложен в mid по **+0x48** (идиома `add3 rX,mid,0x9`). Содержит обратный
указатель на mid, состояние/режим BSS, BSSID, SSID и длину, индекс канала,
Awake Window, hidden_ssid, Capability Info, DMG Capabilities, слоты DMG-cap
станций PBSS, `bss_bi_ctrl` (6 Б, 48 бит Beacon Interval Control),
`old_vendor_specific` (12 Б) и дескрипторы IE-буферов маяка.
**[4.1]** 0x805938.

### RX-пул кадров (`rx_pool`)
Пул буферов приёма mgmt-кадров. Элемент: `next` свободного списка, указатель
`data = elem+0x38`, шапка WMI-события (`wil6210_mbox_hdr` + `wmi_cmd_hdr`),
`struct wmi_rx_mgmt_info` (+0x28, в т. ч. байт канала +0x37), тело кадра
802.11 (+0x38). Событие хосту — `WMI_RX_MGMT_PACKET_EVENTID` (0x1840);
BA/ADDBA/Action уходят внутренним обработчикам, и шапка для них не строится.
Пул не очищается: в нём остаются последние принятые mgmt-кадры.
**[4.1]** база 0x84af54, 12 × 0x538, кольцо 0x843800.

### radio_manager
Объект `radio_mgr` с vtable, пулом запросов (элемент 0x24), `llist` и
вложенным автоматом `rm_sm` (RADIO_MANAGER_MAIN_SM), внутри которого вложен
`rm_chan_sw_sm` (RM_CHAN_SW_SM). Хранит текущий primary-канал
(`rm_sm+0xd0`, 0xffff = нет) и канал в процессе переключения
(`rm_chan_sw_sm+0x3c`); записи запросов канала по 0x28 Б (канал, период
маяка в TU). Байт канала в каждом RX-буфере берётся из `rm_sm+0xd0`.
**[4.1]** `radio_mgr` 0x8063f4 (указатель в `[gp-0x30]`), `rm_sm` 0x80641c.
**[6.2]** описатель `rm_sm` 0x803210 (см. [STATE-MACHINES.md](STATE-MACHINES.md)).

### Отладочная сводка `g_dbg_dashboard`
Отладочная сводка прошивки: температуры, калибровки, статистика связей, ложные
тревоги, power-save и публикуемый микрокодом монитор BI. Есть в обеих версиях
**[обе]**: в 4.1 база 0x854800 (размер 0x65c), в 6.2 — 0x853800, размер в заголовке 0x1c0,
инициализация `fw_stats_blk__init` 0x8f538c; раскладка 4.1 к 6.2 не подходит. Писатели:

| функция | 4.1 | 6.2 |
|---|---|---|
| `dashboard__init` | 0x8ed218 | — |
| `dashboard__count_bf_result` | 0x8e55d4 | — |
| `dashboard__bf_results` | 0x8e57a4 | 0x8eab44 |
| `dashboard__on_disconnect` | 0x8e5820 | 0x8eab88 |
| `dashboard__add_connection` | 0x8e5868 | 0x8eabfc |
| `dashboard__store_passphrase` | 0x8e5954 | 0x8eac90 |
| `dashboard__update_rs_result` | 0x8e5970 | — |
| `dashboard__store_ssid` | 0x8e5a14 | 0x8eace8 |

**[4.1]** база 0x854800, размер 0x65c, указатель на базу — константа данных
0x8033d8; раскладка по членам расходится со структурой пака 11ad —
[4.1/docs/DASHBOARD.md](../4.1/docs/DASHBOARD.md). Разметка для 6.2 не выполнена.

## Замечания
- Кластеризация по зазору ≤ 32 Б — эвристика: два малых объекта подряд могут
  слипнуться, объект с неиспользуемыми членами — разорваться.
- Для объектов с обращениями из нескольких классов (`0x803c00`, `0x8042c8`)
  результат — общий контекст, а не `this` одного класса.
- Методы восстановлены только для логирующих функций (360 из ~2300 в 6.2),
  поэтому список методов класса — нижняя граница интерфейса.

## Не установлено
- Кластеризация синглтонов для 4.1 не выполнялась; соответствие инстансов
  4.1 ↔ 6.2 не построено.
- Адреса `mid`, `bss`, RX-пула и `radio_mgr` в 6.2.
- Владелец объекта `0x8037ec` **[6.2]**.

## Источники
- `6.2/ref/GLOBALS-fw.txt`, `6.2/ref/FN-NAMES.txt`, `6.2/ref/SM-TABLES.txt`
- [4.1/docs/STRUCTS.md](../4.1/docs/STRUCTS.md), [STATE-MACHINES.md](STATE-MACHINES.md)
