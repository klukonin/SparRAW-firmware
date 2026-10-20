# Фиксированное расписание (TDMA) в 6.2.0.1000

Слой фиксированного расписания: команды WMI, конфигурация в fw_peri, включение в fw,
автоматы и потоки передачи в ucode. В 4.1 этого слоя нет вовсе (ни команд WMI, ни
автоматов). Номера всех команд WMI — [WMI.md](../../docs/WMI.md).

Метки: **[код]**, **[пак]** (`wmi.h` мейнлайна), **[гипотеза]**.

## Модель

Координатор раздаёт время: слоты AP, **гранты** станциям, **RD** (reverse
direction — передача станции внутри чужого TXOP), виртуальные слоты, слот
ассоциации. Расписание задаётся «от центра»; станция его исполняет.

## Команды WMI [пак]

* `WMI_FIXED_SCHEDULING_CONFIG` 0xa02 — на каждый из 13 MCS:
  `time_in_usec_before_initiate_tx` (15), `rd_enabled`,
  `time_in_usec_to_stop_vring`, `flush_to_in_usec`, `mac_buff_size_in_bytes`;
  плюс `max_sta_rd_ppdu_duration` (150 мкс), `max_sta_grant_ppdu_duration`
  (300), `assoc_slot_duration` (1000), `virtual_slot_duration` (360),
  `number_of_ap_slots_for_initiate_grant` (2);
* `WMI_ENABLE_FIXED_SCHEDULING` 0xa03; `WMI_FIXED_SCHEDULING_UL_CONFIG` 0x85f
  (`rd_count_per_slot` на MCS); `WMI_SET_AP_SLOT_SIZE` 0xa0f;
  `WMI_SET_GRANT_MCS` 0xa0e.

## fw [код]

* Конфигурация — в fw_peri: **0x847a3c** (основная, 0xa0+ Б), 0x847abc,
  0x847adc (байт +5 = «уже включено»).
* `wmi_fixed_scheduling_config` @0x8ec56c — копирование в 0x847abc/0x847a3c,
  ответ-событие; `wmi_fixed_scheduling_ul_config` @0x8ec5fc — байт 0x847a3d.
* `wmi_enable_fixed_scheduling` @0x8ec500:
  1. `[0x847adc+5]==1` → «fixed scheduling is already enabled», выход;
  2. если MID в режиме PCP/AP (`mid__state_is_2_or_3` 0x8da488) — через
     vtable объекта (`[+0x1c]`) и отложенный вызов `0x8c9854`
     (`wmi_fixed_sched__apply`); иначе
  3. сразу `0x8c9884`: байт `[0x847a3c+0xa5]=1`, **указатель на конфигурацию
     кладётся в общий блок ucode `0x857700+0x44` = 0x847a3c**, флаг
     `0x800236=1`, пороги `0x801448[8..11] = 10 000 000` (выключают
     long-term BF-триггеры для 4 MCS — **[гипотеза]** по соседству с
     `WMI_BF_CONTROL`, см. [BF-ENGINE.md](../../docs/BF-ENGINE.md)), LMAC **0x3e**
     (4 Б), событие **0x1a03**.
  Путь 3 доступен и станции — расписание включается на обеих сторонах.
* Обработчик LMAC 0x3e встроен в `ucode_cmd_dispatch` @0x93cbae: ставит два gp-байта
  в 1, тело (4 Б) не читает — [../../docs/LMAC-PROTOCOL.md §2.2](../../docs/LMAC-PROTOCOL.md#22-сводная-таблица-62).

## ucode [код, имена по листингу]

Автоматы `l1_fixed_sched_ap_sm` @0x92c66c и `l1_fixed_sched_sta_sm` @0x92c840
(события уровня L1), обработчики `l1_fixed_sched_ap__ev4_state2/state4`;
передача — `fixed_sched__run_tx_slot` @0x93768c →
`tx_initiator_flow_fixed_scheduling` @0x938f10, служебные кадры —
`tx_non_data_flow_fixed_scheduling` @0x939594; слот — `fixed_sched__slot_setup`,
`__slot_prepare`, `__read_slot_id`, `__check_slot_flag`; RD —
`fixed_sched_manager__decrement_curr_sta_rd_counter`. Конфигурацию ucode
читает через `0x857744` (`get_mem_857744_x2*`).

Блоки слотов (роль — по строкам и соседям): `l1_fixed_sched_ap__ev4_state4` 0x938880 (408 Б —
слот AP: TSF-дельта, простаивает ли TX-конвейер DMA, подготовка/настройка слота,
`fixed_sched__run_tx_slot`, MAC cmd 0x1b), `fixed_sched__check_slot_flag` 0x922458,
`fixed_sched__slot_prepare` 0x925b50, `fixed_sched__read_slot_id` 0x928824 (событие fw
`uc_evt__send_2e`), `fsched_ap__next_station`, `fsched__time_left_class` 0x924f48,
`fsched__arm_slot_from_cfg` 0x935a6c, `fsched__run_tx_slot_twice` 0x938a18,
`fsched__arm_slot_timer` (наборы очередей), `fsched__rx_slot`, `fsched__log_phase`; чтение
конфигурации из общего блока 0x857700 → 0x847a3c: `fsched__slot_half4` 0x927d5c,
`fixed_sched__slot_word8` 0x927d78, `fsched__slot_byte0` 0x927dc8, `fsched_ap__station_done`
0x92bddc, `fsched_ap__copy_slot_byte1` 0x92ec28 и `fsched__cur_entry_byte0`;
`fsched__drop_station`, `delay_800_iters` 0x938a64 (STA: выдержка, затем TX-слот),
`mac__set_sector_arg_and_select_all` 0x9351ec. Вход из L1 — `l1_fixed_sched__event_entry`
0x92cd94, `l1__enter_fixed_sched` 0x92c7ec ([../../docs/UCODE-TASKS.md §2](../../docs/UCODE-TASKS.md#2-главный-цикл-l1-62));
QH по пиру — `peer__lookup_if_fixed_sched` 0x926890 / `sched_cfg__merge_update` 0x9268c0. В
файлах данных `ref/` часть этих блоков записана под групповыми именами
(`uses_g_80064c_801be8__*`, `uses_g_857700__*`, `uses_g_801be8__*`) —
[MISC-UC.md, приложение А](MISC-UC.md#приложение-а-имена-блоков-в-файлах-данных-ref).

Потоки фиксированного расписания **не обращаются к u16 запрета TX по CID
`0x802a90`** (нет литерала в трёх блоках) — **[код, неполно]**: выбор очереди
может идти через аппаратные маски, которые запрет тоже правит.

## Применимость к распределённому TDMA

Расписание централизованное (гранты от AP), но исполняется на обеих сторонах, а
конфигурация — плоская таблица в общей памяти (0x847a3c → 0x857744). Правдоподобный
путь к распределённому TDMA на 6.2 — задавать согласованные расписания обоим узлам с
хоста, без нового протокола в прошивке. На железе не проверено.

## Не установлено

1. Раскладка 0x847a3c по полям (сопоставить с `wmi_fixed_scheduling_config_cmd`).
2. Таблицы переходов `l1_fixed_sched_ap_sm` / `_sta_sm` (не `basic_sm` — свой
   формат L1).
3. Действует ли BF-запрет TX (0x802a90) на слоты расписания.
