# Радио-менеджер и переключение канала

Радио — единственный ресурс, которым владеет автомат RADIO_MANAGER_MAIN_SM: потоки
(соединение, скан, P2P Find, FTM, температура, калибровки) берут его первичным или
вторичным захватом и отпускают. Подсистема есть в 4.1.0.1000 и 6.2.0.1000 **[обе]**.
Объект `radio_mgr` и его поля — [FW-OBJECTS.md §4](FW-OBJECTS.md#radio_manager),
разметка 4.1 по членам — [4.1/docs/STRUCTS.md §3](../4.1/docs/STRUCTS.md#3-radio_manager-кластер-0x8063f40x806500-0x8064xx);
автоматы — [STATE-MACHINES.md](STATE-MACHINES.md).

Метки: **[код]** — по листингу, **[стр]** — по собственной лог-строке блока,
**[выз]** — по вызывающим/вызываемым. Запись адреса: `имя` 0x… — адрес 6.2; «/ 4.1 0x…» —
адрес той же функции в 4.1 (по совпадению тела, таблице
[NAMES-FROM-62](../4.1/docs/NAMES-FROM-62.md) или имени); если в 4.1 имя другое, оно
указано. Функции без пометки 4.1 — соответствие не установлено. Описатели автоматов
(0x803210, 0x80338c, 0x802338) и пулы (0x803cbc) — адреса 6.2.

## 1. Общие примитивы **[код]**

* `radio_mgr__request` 0x8dcaf4 / 4.1 0x8e0218 — виртуальный вызов радио-менеджера: объект по
  указателю gp−0x40, метод +0x0c, пять аргументов проброшены. Запрос захвата
  радио; зовут все, кому нужно радио: `channels_switch_sm__action_allocate_radio`,
  P2P Find (0x8f0dd4), FTM (`state_sm_8034c0__action_8f058c` 0x8f058c),
  температура, `hw_sysapi_rfc_read_write_rgf`, сектора WMI, ложные тревоги.
* `sm__defer_call` 0x8e7044 — отложенный вызов для автомата: байт объекта +2
  должен быть 0xff (нет ожидающего, иначе фатал 0x16a2); из пула 0x803cbc
  берётся запись 0x14 Б {функция, a1, a2, a3}, её индекс кладётся в объект +2.
  Так автоматы соединения, радио-менеджера и LM откладывают свои события в
  контекст задачи. `sm__defer_call_thunk` 0x8e70c0 — хвост.
* Запросы радио — `radio_mgr__alloc_request` 0x8e2724 / 4.1 0x8de3d4,
  `radio_mgr__unlink_request` 0x8e2778 / 4.1 0x8de424, `radio_mgr__enqueue_request` 0x8e1f70 / 4.1 0x8ddc28
  (заодно запрещает CID в планировщике vring — `vring_schd__prohibit_cids`),
  `RADIO_MGR__remove_request` 0x8e2798 / 4.1 0x8de444, `radio_mgr__free_handle` 0x8ddb0c / 4.1 0x8d9c0c,
  `radio_mgr__init_list` 0x8d91a0 / 4.1 0x8d612c, `obj_vt803210__ctor` 0x8d8c1c (настройка
  автомата 0x803210).

## 2. rm_main_sm (0x803210): первичный и вторичный захват

Вендорские состояния: IDLE, PRIM_NON_LOCKED, PRIM_LOCKED, SWITCH_2_PRIM,
SECONDARY, SWITCH_2_SEC. Первичный захват — рабочий канал соединения,
вторичный — временный уход (скан, FTM, температура, калибровка).

* `rm_main_sm__lock_primary` 0x8dc9a4 / 4.1 0x8d91d4 — захват первичного с колбэком;
  `rm_main_sm__get_next_prim_request` 0x8cc5a8 / 4.1 0x8ca388 / `rm_main_sm__get_next_request`
  0x8cc5e0 / 4.1 0x8ca3c0 («RX is Off --> GOTO IDLE»), `rm_main_sm__primary_handle_free`
  0x8e0e58 / 4.1 0x8dcb3c, `rm_main_sm__secondary_handle_free` 0x8e4e48 / 4.1 0x8e02a0,
  `rm_main_sm__mark_as_pending_removal` 0x8ddcec / 4.1 0x8d9d9c, `rm_main_sm__call_cb` 0x8c59c4 / 4.1 0x8c4bc0.
* Переход на вторичный: `rm_sm__action_8e83f4` 0x8e83f4 («switch_2_secondary -
  pop request»), `switch_2_secondary` 0x8e83d4 / 4.1 0x8e32f4 (зовётся при
  PRIMARY_SET/UNSET и ведёт в SWITCH_2_PRIM), `rm_main_sm__kick_channel_switch_sm`
  0x8da6e4 / 4.1 0x8d75dc, `rm_main_sm__secondary_tune_done` 0x8e4f18 / 4.1 0x8e038c (колбэк владельца через
  `u_schd__add`).
* Возврат на первичный: `rm_sm__action_8e0eb0` 0x8e0eb0 (CH_SWITCH_DONE в
  SWITCH_2_PRIM) → `rm_main_sm__enter_primary_non_locked` 0x8c9950 / 4.1 0x8c80c8: если канал
  не тот (`rm__channel_matches` 0x8da394 / 4.1 0x8d7314) — «Primary Mismatch, retuning»;
  иначе `rm_main_sm__enter_step` 0x8c6954 — сброс кольца DMA
  (`hwd_dma__reset_ring`, `mac_ring_disable`), таймер в +0x2c
  (`rm_main_sm__check_field_2c` 0x8c5b08). Внутри того же блока с +0x104 —
  общий `basic_sm::error_handler`.
* `rm_main_sm__latch_ring_fields` 0x8d9b44,
  `rm_main_sm__count_and_sync_dma_wptr` 0x8ebff8, `rm__store_tune_request`,
  `rm__load_request_params`, `rm__invalidate_tune_slot` — поля состояния
  менеджера. `rm_main_sm__inject_lock_evt` 0x8cd288 / 4.1 0x8caf98 — событие захвата (от
  WMI-команд секторов, [6.2/docs/MISC-FW.md §3](../6.2/docs/MISC-FW.md#3-каталог-блоков-по-вендорским-исходным-файлам)).

## 3. rm_ch_switch_sm (0x80338c): IDLE → TURN_OFF → TURN_ON → IDLE

CH_SWITCH_KICK → `rm_ch_switch_sm__action_8c5be8` 0x8c5be8 (пауза TX,
`tx_api__pause_for_ch_switch`); ждёт трёх флагов — DATA_STOPPED
(`rm_ch_switch_sm__action_8c7f14` 0x8c7f14), FW_TX_CHANNEL_STOPPED
(`rm_ch_switch_sm__fwtx_channel_stopped_8cb6e8` 0x8cb6e8: «send ucode RX_OFF»,
LMAC cmd 0x03), UCODE_RX_OFF_EVT (`rm_ch_switch_sm__action_8e3a9c` 0x8e3a9c);
сверка флагов — `rm_ch_switch_sm__check_turn_completed` 0x8c6484 / 4.1 0x8c57b0 («pend flags /
recvd flags»). Включение: UCODE_RX_ON_EVT (`rm_ch_switch_sm__action_8e3ac8`
0x8e3ac8), `rm_ch_switch__resume_tx_queue` 0x8e7948 / 4.1 0x8e2728, MAC-адрес заново
(`l2_offload__set_own_mac_addr` 0x8df518 / 4.1 `set_reg_881b00` 0x8db278, `mac__set_own_addr` 0x8e8548 / 4.1 `set_reg_886d80_8e3458` 0x8e3458,
`mac__set_mcast_addr` 0x8e8560 / 4.1 `set_reg_886d80_8e3470` 0x8e3470), `rm_ch_switch_sm__notify_ch_switch_done_8c5bb8`
0x8c5bb8. Смена канала на железе — `channels_switch_sm__switch_to_channel`
0x8c5e64 («Switching to channel», `hwm__apply_channel_config`, аналоговое
переключение), `channels_switch_sm__channel_switched_cb` 0x8c5ed4 / 4.1 0x8ea180,
`chan_sw__set_active_channel` 0x8e639c.

## 4. channels_switch_sm (скан) — захват радио и стоянка

`channels_switch_sm__action_allocate_radio` 0x8c20b8 / 4.1 0x8e8f4c — запрос радио,
`discovery__rx_start`, сторож; `channels_switch_sm__action_pop_ch_and_tune`
(`…pop_ch_and_tune_8c2228`) 0x8c2228 / 4.1 0x8e9008 — следующий канал из списка («No need to
switch — working channel»); `channels_switch_sm__action_radio_tunned` 0x8c22ec / 4.1 0x8e90f4;
`channels_switch_sm__action_start_dwelling` 0x8c2354 / 4.1 0x8e9164 (стоянка с интервалом,
таймер); `channels_switch_sm__action_dwelling_stopped` 0x8c2174 / 4.1 0x8e8fd8; прерывания —
`channels_switch_sm__action_abort_allocate` 0x8c2018 / 4.1 0x8e8ed8,
`channels_switch_sm__action_abort_dwelling` 0x8c203c / 4.1 0x8e8f00,
`channels_switch_sm__scan_abort_tunning` 0x8c209c / 4.1 0x8e8f2c;
`channels_switch_sm__dwell_timeout_cb` 0x8c980c / 4.1 0x8eb86c («dwell timeout !!!»).
`pcie_dbg__rearm_irq_bit9` 0x8fa854 / 4.1 `set_reg_88268c_x2` 0x8f2910 и `pcie_dbg__rearm_irq_bit0` 0x8fa864 / 4.1 `set_reg_88268c_x2_8f2920` 0x8f2920 —
маски PCIe-debug на время захвата. `ftm_main_sm__radio_args` 0x8e4e18 —
параметры захвата (общие со сканом).

## 5. maintain_sm и радио

`maintain_sm__lock_radio` 0x8e2904 / 4.1 0x8de58c, `maintain_sm__release_radio_after_bf_evt`
0x8e2520 / 4.1 0x8de158 («remove_request»), BF_FAIL_RETRYING (`maintain_sm__action_8c494c`
0x8c494c, счётчик неудач), «FBF_DELAYED END — Start Rate Search»
(`maintain_sm__action_8cab64` 0x8cab64: LMAC cmd 0x13, selective neighbor cfg,
вектор MCS), «trigger long term BF, maximal_goodput»
(`maintain_sm__action_8dcf84` 0x8dcf84), `maintain_sm__action_8cdbd8` 0x8cdbd8
и `maintain_sm__action_8e2b9c` 0x8e2b9c — ожидаемые результаты BF и долгий
триггер (`schedule_long_term_trigger`; `bf_lt__get_max_goodput` 0x8cc3cc /
`lt_bf__reset_trigger_period` 0x8e2958 — его период; `hw_rand__below_n`
0x8e85f0 / 4.1 `get_reg_880b80` 0x8e3580). `channels_switch__check_g800104` 0x8e46f4 и
`channels_switch__check_g80017c` 0x8e494c — перевзвод таймеров (второй —
таймер температуры).

## 6. Температура через радио

`temp_service__radio_locked_cb` 0x8e20dc — `TEMPERATURE_SERVICE::radio_locked_cb`
(при выключенной/останавливаемой службе сразу отпускает радио) →
`perform_first_measurement_operations` 0x8e0908 / 4.1 0x8dc6f4 (калиброванные замеры BB и RF,
затем «periodic_info_flow» — Information Response соединениям).

## 7. Прочее группы

`hw_sysapi__set_freq_ratio` 0x8ce484 — `hw_sysapi_set_freq_ratio` просит радио;
`ftm_main_sm__timeout_cbs` 0x8f32b4 — сторожа FTM («ftm_rm_lock_timeout_cb»,
«ftm_wd_timeout_cb»); `app_ie__print_ies` 0x8e1008 / 4.1 0x8dce44; `l2mgr__arm_notify_timer`
0x8e48a4 / 4.1 0x8dfbe8; `detector__arm_timer` 0x8e7e8c / 4.1 0x8e2d84, `conn__arm_detect_step` 0x8e00e8,
`conn__arm_detect_tail` 0x8e0104; `rf_mgmt__set_state_flag` 0x8eab30 —
состояние RF management (автомат 0x802338);
`calib_engine__accumulate_if_enabled` 0x8eaa20.

`check_high_false_alarm_aging_cb` 0x8f1980 — печать g_high_false_alarm_cnt и
фатал 0x142e, если разница ≥ 8. Соседний блок `sdp_gpio__personality_step`
0x8f1920 — разбор «personality» порта SDP (`sdp_gpio__boot_init`).

## 8. Имена 4.1 **[стр]/[выз]**

Роли блоков 4.1 по лог-строкам (перечень блоков —
[4.1/docs/MISC.md §12](../4.1/docs/MISC.md#12-радио-менеджер-и-смена-канала-41)):

| роль | 4.1 | 6.2 |
|---|---|---|
| захват первичного / вторичного («m_allocated, free») | `radio_manager__lock_primary` 0x8d921c, `radio_manager__lock_secondary` 0x8d9314 | — |
| вторичный захват с настройкой («tune, channel») | `RADIO_MGR__lock_secondary` 0x8d938c | — |
| захват первичного с колбэком / освобождение (путь WMI_CONNECT, [HOST-INTERFACE](HOST-INTERFACE.md)) | `RADIO_MGR__lock_primary` 0x8d9288, `RADIO_MGR__unlock` 0x8e54d8 | — |
| настройка через таблицу методов | `radio_vtbl__call_tune` 0x8e0274 | `radio_mgr__request` 0x8dcaf4 (метод +0x0c) |
| «Switching to channel» | `calib_mngr__switch_channel` 0x8c5034 | `channels_switch_sm__switch_to_channel` 0x8c5e64 |
| инициализация автоматов | `rm_chan_sw_sm__init` 0x8d5d48, `channels_switch_sm__init` 0x8ed244 | `obj_vt803210__ctor` 0x8d8c1c, `obj_vt802fb4__ctor` 0x8d9058 |
| старение счётчика ложных тревог | `l2mgr__false_alarm_aging_cb` 0x8ea1d8 | `check_high_false_alarm_aging_cb` 0x8f1980 |

После смены канала обе версии перепрограммируют MAC-адрес (4.1: `set_reg_881b00`
0x8db278, `set_reg_886d80_8e3458` 0x8e3458, `set_reg_886d80_8e3470` 0x8e3470 — те же
тела, что у 6.2 `l2_offload__set_own_mac_addr`, `mac__set_own_addr`, `mac__set_mcast_addr`).

## Замечания

* `radio_mgr__request` 0x8dcaf4 к температуре отношения не имеет — это общий
  запрос захвата радио.
* `switch_2_secondary` 0x8e83d4 зовётся при PRIMARY_SET/UNSET и ведёт в
  SWITCH_2_PRIM, вопреки имени.
* `rm_main_sm__get_next_request` (0x8cc5e0) относится к радио-менеджеру; выборку
  задач планировщика делает `u_schd__pop_ready` ([SCHEDULER](SCHEDULER.md)).
* В файлах данных 6.2 `ref/` имя колбэка ложных тревог (`check_high_false_alarm_aging_cb`)
  записано за соседним блоком 0x8f1920 (`sdp_gpio__personality_step`) —
  [6.2/docs/MISC-FW.md, приложение А](../6.2/docs/MISC-FW.md#приложение-а-имена-блоков-в-файлах-данных-ref).

## Источники

* `6.2/src/asm/fw/blocks.json`, `4.1/src/asm/fw/blocks.json`, `6.2/ref/CORRELATION-FW.txt`,
  [6.2/ref/SM-TABLES.txt](../6.2/ref/SM-TABLES.txt).
* [FW-OBJECTS.md](FW-OBJECTS.md), [STATE-MACHINES.md](STATE-MACHINES.md), [MLME.md](MLME.md),
  [HOST-INTERFACE.md](HOST-INTERFACE.md).
