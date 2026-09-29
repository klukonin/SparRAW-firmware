# Протокол прошивка ↔ микрокод (LMAC)

Справочник по интерфейсу между прошивкой (fw, ядро UMAC) и микрокодом (ucode, LMAC)
wil6210 Sparrow: транспорт (почтовый ящик, звонок, очередь событий), все команды
fw→ucode с раскладкой тел, события ucode→fw, соответствие вендорским структурам
`fui_*` пака 11ad, различия 4.1.0.1000 и 6.2.0.1000. Механизмы, которые задаются телами этих команд
(режим OOB, `special_flags`, ролевой гейт развёртки, связь до `READY_FOR_ASSOC`), —
в [ROLELESS-LINK.md](ROLELESS-LINK.md).

Метки: **[железо]** — проверено на стенде, **[код]** — по листингу,
**[пак]** — по вендорским именам пака 11ad, **[гипотеза]** — не проверено.
Адреса без пометки — 4.1.0.1000. Host-адреса (для `mem_write` драйвера):
данные ucode — host = A + 0x140000 (0x801438 → 0x941438), данные fw —
host = A + 0x100000 (0x803474 → 0x903474), fw_peri — host = 0x908000 + (A − 0x840000).

Почтовый ящик LMAC — уровень выше кольца команд MAC (uCode CORE WRITE, порт
0x886dc8, см. [MAC-COMMANDS.md](MAC-COMMANDS.md)); их не следует путать.

---

## Часть I. Протокол

## 1. Транспорт

### 1.1. Отправка команды (fw → ucode) **[код]**

`send_cmd2_lmac(r0=buf, r1=cmd, r2=len, r3=extra)` @0x8e0694:
* проверяет `[gp,0x238] == 1` (иначе `fw_sysassert_fatal`, строка 0x12b, текст 0x1003e50);
* печатает лог-строку 0x1003e5c;
* зовёт `basic_if__mailbox_send` @0x8e048c с объектом ящика **0x803e3c**
  (`+0x00` u16 — счётчик seq);
* звонит: `[0x886d80+0x58] = 1` (0x8e06f4) — регистр 0x886dd8 `fw2uc_ICS`
  (см. `6.2/ref/REGS-62.md`), затем `sync`.

`basic_if__mailbox_send` строит 16-байтовую шапку **ниже** буфера полезной
нагрузки (`r13 = buf - 0x10`, 0x8e04ce):

| смещ. | разм. | поле | инструкция |
|---|---|---|---|
| +0x00 | u16 | seq (из 0x803e3c, инкремент) | 0x8e04d6, 0x8e0524 |
| +0x02 | u16 | len | 0x8e04ee |
| +0x04 | u16 | **код команды** | 0x8e04d0 |
| +0x06 | u8 | флаги: b1 = есть arg r6, b2 = есть arg r7 | 0x8e0508..0x8e0520 |
| +0x07 | u8 | len (младший байт) | 0x8e04f2 |
| +0x08 | u8 | `extra` (arg3 `send_cmd2_lmac`) | 0x8e04f6 |
| +0x09 | u8 | 0 | 0x8e04fa |
| +0x0a | u16 | 0 | 0x8e0502 |
| +0x0c | u32 | TSF low (результат 0x8e4694) | 0x8e0506 |
| **+0x10** | — | **тело** | — |

Ассерты `basic_if__mailbox_send` (файл-строка 0x100269c): 0xc3 — нулевой
буфер, 0xc4 — нет места в кольце (проверка 0x8d739c, дамп 0x8d9ba8),
0xc5 — длина больше записи кольца без флагов.

### 1.2. Приём команды в ucode **[код]**

`uc_mailbox__dispatch_one` @0x92a2b0 делает `add r2,r1,0x10` (0x92a2b6) и зовёт
`umac_if_cmd_handler(msg, body)` @0x936dd0 — каждый обработчик получает указатель
на **тело** в r0, и r13 держит его весь дальнейший разбор.

Диспетчер: код индексирует **байтовую** таблицу по **0x800c68** (данные ucode),
байт × 2 = смещение заглушки от **0x936e5e**; предел кода 0x41. Перед ветвлением
код уходит в кольцо MAC как трассировка:
`ldw_s r0,[obj,0x4]` / `or r0,r0,0xcd0000` / `st.ab r0,[r25,4]` (маркер 0xcd).
Из 66 записей таблицы 30 ведут в одну общую заглушку-ассерт.

Таблица `0x800c68` в образе отсутствует и заполняется при работе, поэтому соответствие
cmd_id→обработчик статически снимается только по коду заглушек. Обработчики достижимы только
через таблицу (вызывающих у них нет); признак — вызов 0x92020c (`__st_r16_to_r13_uc`, пролог
милли-кода). Таких **16**: 0x9232a8, 0x923400, 0x923930 (BRP), 0x92639c (rf_sector), 0x92a558,
0x92a6f4 (nav_db), 0x92c44c, 0x930f44, 0x9331d8, 0x933454, 0x933e90 (tx_flows), 0x933f90,
**0x934de4 (DISCOVERY)**, 0x9354d4, 0x936dd0 (сам диспетчер), 0x93800c. Лог-строка диспетчера —
`umac_if_cmd_handler FW command 0x%x` (`umac_if_cmd_handler.cpp`); при коде вне предела — ASSERT.

### 1.3. События (ucode → fw) **[код]**

События используют ту же 16-байтовую шапку. Диспетчер fw
`lmac_if__ucode_event_dispatch` @0x8dae80 ставит `r14 = msg + 0x10` (0x8dae90),
тип индексирует таблицу **полуслов** 0x801b98, значение × 2 = смещение ветки от
0x8daeb8. Каждая ветка печатает строку `Ucode-><ИМЯ>` и зовёт обработчик. Типы
0x1a…0x26 без обработчика падают в заглушку-ассерт 0x8db138.

Отправители в ucode (тип в r1): 0x925b5c…0x925d80 (места установки типа — до 0x925d94), общие `uc_send_evt_typed`
@0x925da8 и `uc_send_event` @0x925dd8.

---

## 2. Команды fw → ucode

### 2.1. Сводная таблица (4.1)

| код | len | отправитель (fw) | обработчик (ucode) | тело |
|---|---|---|---|---|
| 0x00 | 0x44 | `lmac_if__send_init_cfg_cmd` @0x8d8550 | `ucode_cmd_0x00_handler` @0x934f68 | init_cfg + тайминги IFS (§3.1) |
| 0x01 | 0x24 | `lmac_if_send_cmd_0x01` @0x8d8a14 | `ucode_cmd__rx_on` | построение @0x8d89f0; +0x20 = 1 |
| 0x02 | 0x04 | `lmac_if__send_echo` @0x8c71ac | `ucode_cmd__echo` | эхо |
| 0x03 | 0x04 | `lmac_if_send_cmd_0x03` @0x8d89cc (через 0x8d89c4) | `ucode_cmd__rx_off` | RX OFF; ответ RX_OFF_RSP |
| 0x04 | 0x30 | `lmac_if_send_cmd_0x04` @0x8d8da4 (через 0x8d8d30) | `ucode_cmd_0x04_handler` | — |
| 0x05 | 0x24 | `lmac_if_send_cmd_0x05` @0x8d8e2c, `lmac_if_send_cmd_0x05_8f1074` @0x8f1074 | `ucode_cmd_0x05_handler` | запись соседа, подкод в +0x0c (§3.8) |
| 0x07 | 0x10 | `lmac_if_send_cmd_0x07` @0x8efb90 (два места) | `ucode_cmd_0x07_handler` | +0x0c = подкод 1/2, битовые поля в +4/+8 |
| 0x08 | 0x14 | `lmac_if_send_cmd_0x08` @0x8d8864 | `ucode_cmd__queue_delete` | удаление очереди |
| 0x09 | 0x0c | `lmac_if_trigger_bf` @0x8d8cb0, `wmi_handler_beamforming_mgmt` | `ucode_cmd_trigger_bf` | `{1, bf_cmd_type, cid}` (§3.9) |
| 0x0b | 0x94 | `lmac_if__send_bcon_mgt`, `lmac_if__stop_beacon` | `ucode_cmd__bi_config` @0x932f8c | §3.2 |
| 0x0c | 0x20 | `lmac_if_send_cmd_0x0c` @0x8d83ec | `ucode_cmd_0x0c_handler` | один 28-байтовый дескриптор развёртки (§3.2) |
| 0x0f | 0x08 | `lmac_if_send_cmd_0x0f` @0x8d8a5c | (встроен) | `{u32 arg0, u16 arg1}` |
| 0x10 | 0x30 | `lm_main_sm__config_lmac_bf_sm` @0x8c625c | `ucode_cmd_config_lmac_bf_sm` @0x922970 | §3.4 |
| 0x11 | 0x10 | `lmac_if_send_cmd_0x11` @0x8d8b40 | `ucode_cmd_0x11_handler` | 4 × u32 из gp-глобалов fw |
| 0x12 | — | нет отправителя | `ucode_cmd_0x12_handler` | — |
| 0x13 | 0x28 | `lmac_if_send_cmd_0x13` @0x8d88b8 | `ucode_cmd__rs_enable` | `{u8 cid, u8 en, 38 Б rs cfg}` |
| 0x14 | 0x08 | `lmac_if_send_cmd_0x14` @0x8d8390 | встроен (0x936fb0) | `{u32 cid, u32 flags b0..b4}` — маска причин ретриггера BF (§3.9) |
| 0x15 | 0x08 | `lmac_if__send_lmac_personality` @0x8d8b9c | встроен (0x936fba) | §3.3 |
| 0x16 | 0x04 | `lmac_if_send_cmd_0x16` @0x8d8bd0 | `ucode_cmd_0x16_handler` | байт `[0x800d08]` |
| 0x18 | 0x20 | `install_key_index_stub` @0x8e9440 | `ucode_cmd_install_key` | `{idx, class, 0x34, 0x10, key[16]}` (§3.9) |
| 0x19 | 0x04 | `lmac_if_send_cmd_0x19` @0x8d8800 | `ucode_cmd_0x19_handler` | `{u8, u16@+2, u32@+4}` |
| 0x1b | 0x03 | `lmac_if_send_cmd_0x1b` @0x8e0718 | `ucode_cmd_0x1b_handler` | `{u8 (arg2!=0), u8 arg1}` |
| 0x1e | 0x08 | `lmac_if__send_selective_neighbor_cfg` @0x8d8a7c | `ucode_cmd_selective_neighbor_cfg` | §3.5 |
| 0x20 | 0x24 | `lmac_if__send_phy_ina_det_cfg` @0x8d8824 | `ucode_cmd_phy_ina_det_cfg` | 36-байтовая структура от вызывающего (§3.9) |
| 0x21 | 0x08 | `lmac_if_send_cmd_0x21` @0x8d87b8 | `ucode_cmd_0x21_handler` (0x935030) | 4 × u16, все = `[gp,0x26c]` — пределы TXOP (§3.9) |
| 0x22 | 0x0c | `lmac_if_send_cmd_0x22` @0x8d8e68 | `psc_pending_agreement_cmd` | PSC pending agreement |
| 0x23 | 0x0c | `lmac_if__send_abft_resp_ctrl` @0x8d7efc | `ucode_cmd_0x23_handler` @0x921770 | §3.6 — управление ответчиком A-BFT |
| 0x24 | 0x08 | `lmac_if_discovery_mode_cfg_handler` @0x8d84a8 | `ucode_cmd__discovery_mode_cfg` (0x934de4) | `{discovery_mode, discovery_type}` |
| 0x25 | 0x14 | `lmac_if_update_aw_ie_handler` @0x8d8de0 | `ucode_cmd_update_aw_ie` | `{0x9d, tbtt_start_time, awake_window_duration, 1}` |
| 0x26 | 0x01 | `lmac_if_keep_alive_trigger_handler` @0x8d85e4 | `ucode_cmd_keep_alive_trigger` | `{u8 cid}` |
| 0x27 | 0x02 | `lmac_if_send_cmd_0x27` @0x8d8c80 | `traffic_deferral_cfg_cmd_handler` | `{u8 en, u8 val}` |
| 0x30 | 0x03 | `lmac_if_send_cmd_0x30` @0x8d852c | `ucode_cmd_0x30_handler` | `{u8 idx, u8 bit, u8 val7}` |
| 0x39 | 0x04 | `lmac_if_send_get_selected_rf_sector_index` | `get_selected_rf_sector_index_cmd_handler` | `{u8 idx, u8 type}` |
| 0x3a | 0x04 | `lmac_if_send_set_selected_rf_sector_index` | `set_selected_rf_sector_index_cmd_handler` | `{u8 cid, u8 type, u16 sector}`, 0xffff = сброс |
| 0x41 | 0x04 | `lmac_if_send_long_range` @0x8e7e00 | `txrx_umac_if_long_range_cmd_handler` @0x934fdc | тело не используется (§3.9) |

Мест отправки — 34. Карты строятся автоматически: `4.1/tools/lmac_cmd_map.py`
(команды), `4.1/tools/lmac_evt_map.py` (события).

### 2.2. Сводная таблица (6.2)

Отправка в fw 6.2 — `lmac_if__post_cmd` 0x8e5204 (буф, **код в r1**, длина, …);
отправители найдены сканом всех `bl 0x8e5204` с `mov r1,код` рядом. Приём —
`ucode_cmd_dispatch` 0x93c928, таблица полуслов 0x8019dc
(`6.2/tools/uc_cmd_table.py --table 0x8019dc --stub-base 0x93c966`). Смысл
кодов 0x00–0x41 — как в 4.1 (§2.1), если не сказано иное; коды ≥0x28 в основном новые.
Метки: **[код]** — прочитан листинг; остальное — по строкам и графу вызовов.

| код | отправитель fw 6.2 | обработчик ucode 6.2 | назначение |
|---|---|---|---|
| 0x00 | `lmac_if_send_cmd_0x00` (из `lmac_if__send_init_cfg`) | `ucode_cmd_0x00_handler` → `ucode_cmd__apply_mac_cfg` 0x92f320, `rf__compute_tx_rx_sets`, `mac__cmd_56_57` | начальная конфигурация MAC (§3.1) |
| 0x01 | `lmac_if_send_cmd_0x01` | `ucode_cmd_0x01_handler` 0x93a9ec (520 Б) | RX ON: режим MAC, RF-цепочка, grant detect, событие RX_ON_RSP |
| 0x02 | `wmi_deep_echo` | `ucode_cmd__echo` | эхо |
| 0x03 | `lmac_if_send_cmd_0x03` | `ucode_cmd_0x03_handler` 0x93a9d0 | RX OFF: сброс TSF-защёлки BI, событие RX_OFF_RSP |
| 0x04 | `lmac_if_send_cmd_0x04` | `ucode_cmd_0x04_handler_uc` 0x93adf0 | конфиг (шаг `txrx_api_step_c`) |
| 0x05 | `lmac_if__send_sta_cfg_05`, `lmac_if__send_sta_cfg_05_b` 0x8dc380, `lmac_if__send_sta_cfg_05_c` 0x8dc3c4 | `ucode_cmd_0x05_handler` (индекс — `ucode_cmd_05__index` 0x920cdc) | запись станции/правила по индексу |
| 0x07 | `ftm_main_sm__radio_allocated_cb` | `ucode_cmd_0x07_handler` | FTM: радио получено |
| 0x08 | `lmac_if_send_cmd_0x08` (из `tx_api__mask_from_queue`) | `ucode_cmd_0x08_handler` 0x93aea8 (848 Б) | удаление/маскирование очереди (в 4.1 queue_delete); событие ответа |
| 0x09 | `lmac_if_trigger_bf`, `wmi_beamforming_mgmt` | `ucode_cmd_trigger_bf` | запуск BF |
| 0x0b | `lmac_if__send_bcon_mgt`, `lmac_if__send_bcon_del_0b` (удаление маяка) | `ucode_cmd_0x0b_handler` → `ucode_cmd_0b__apply` 0x92b198, `rf__store_last_module_index` | bi_config / стоп маяка |
| 0x0c | `lmac_if_config_txss` | `ucode_cmd_0x0c_handler` (тоже `ucode_cmd_0b__apply`) | TXSS |
| 0x0f | `lmac_if_send_cmd_0x0f` | `ucode_cmd_0x0f_handler` → `ucode_cmd__reset_queue_state` 0x92b210, `ps__release_awake_for_sta` | сброс состояния CID (abort BF, снятие pending) |
| 0x10 | `lm_main_sm__config_lmac_bf_sm`, `wmi_bf_control` | `ucode_cmd_0x10_handler` | конфиг BF-автомата |
| 0x11 | `silent_rssi__report_agc_tables` | `ucode_cmd_0x11_handler` | AGC-старт/таблица усиления |
| 0x12 | `field_set_0x00__8dbc94` (UT) | `ucode_cmd_0x12_handler_uc` 0x9301e4 | RS старт/стоп (UT) |
| 0x13 | `lmac_if_send_cmd_0x13` | `ucode_cmd_0x13_handler` 0x92fcc4 | «enable RS» |
| 0x14 | `field_rw_0x00__8db534`, `wmi_bf_control` | встроен в диспетчер (0x93ca22) | слово в 0x8021b8+0x20 **[код]** |
| 0x15 | `lmac_if_send_cmd_0x15` (из `maintain_sm__set_rs_params`) | встроен (0x93ca30) | два слова в gp-переменные — `personality`/`failure_policy`, как в 4.1 (§3.3) **[код]** |
| 0x16 | `lmac_if__send_cmd_0x16_calib_b4` | `ucode_cmd_0x16_handler` | байт поля +0xb4 калибровочного объекта → [gp+0x24] ucode **[код]** |
| 0x18 | `install_key_index_stub`, `l2_mgr__set_rf_params` | `ucode_cmd_0x18_handler` 0x93ad54 → `uc_send_evt__sta_update_field_rsp` 0x927810 | поле STA (ключ, RF-параметры) |
| 0x19 | `hw_sysapi_rx__alloc_and_store` | `ucode_cmd_0x19_handler` | RX omni-сектор (UT) |
| 0x1b | `conn__alloc_and_link` | `ucode_cmd_0x1b_handler` | привязка соединения |
| 0x1e | `lmac_if__send_selective_neighbor_cfg` | `ucode_cmd_selective_neighbor_cfg` | selective neighbor |
| 0x20 | `lmac_if__send_phy_ina_det_cfg` | `ucode_cmd_0x20_handler` 0x92e458 | детектор INA; ответ `uc_evt__send_26` 0x9278a8 |
| 0x21 | `lmac_if__send_txop_limits` | `ucode_cmd_0x21_set_txop_limits` 0x93a9b0 → `txop__apply_limits_regs` 0x936ba8 | **пределы TXOP**: 4 значения ≤0x7ff мкс ([gp+0x26c], 0x500 в OOB R1) → 0x886f70 (пара, второе сдвинуто на [gp-0x24]) и 0x886f74; на стенде 0x07d007d0 = 2000 мкс **[код]** |
| 0x22 | `lmac_if_send_cmd_0x22` | `ucode_cmd_0x22_handler` 0x92e840 | PSC pending agreement: запись в таблицу 0x802f80 по индексу пира (<8) или общая (0xff) **[код]** |
| 0x23 | `lmac_if_send_cmd_0x23` | `ucode_cmd_0x23_handler` (+`ucode_cmd__load_table_803124_803128__920b1c`) | загрузка таблицы 0x803124/0x803128 |
| 0x24 | `lmac_if_discovery_mode_cfg_handler` | `ucode_cmd_0x24_handler` 0x93a830 | «DISCOVERY ON/OFF (Type)», сброс всех STA BF, проверка `ucode_cmd_24__check` 0x93d31c |
| 0x25 | `lmac_if_update_aw_ie_handler` | `ucode_cmd_0x25_handler` 0x93b1f8 → `aw_ie__copy_to_bcon` | AW IE в маяк |
| 0x26 | — (отправителя по коду в 6.2 нет) | `ucode_cmd_0x26_handler` 0x92c5dc → `keep_alive__arm_slot` 0x939484 | keep-alive |
| 0x27 | `lmac_if_send_cmd_0x27` | `traffic_deferral_cfg_cmd_handler` | traffic deferral |
| 0x28, 0x2a, 0x2e, 0x37, 0x3c | прямым сканом не найдены (вероятно, UT-построители с кодом в регистре: `channel_est__stack_args`, `field_set_0x00__8dbe88`) **[гипотеза]** | `ucode_cmd_0x28/2a/2e/37/3c_handler` → общий `ucode_cmd_28__apply` 0x935e30 | статистические/измерительные запросы: состояние запроса (+0x0c=2), буфер заполняется 0xff, запуск через `mac__read_tsf64_uc` |
| 0x29, 0x2b, 0x2f, 0x38, 0x3d | то же | `ucode_cmd_0x29/2b/2f/38/3d_handler` (по 144 Б) | две команды MAC-ядра (0x1d005000/0x1d006000 с полем из gp) с чтением ответа, затем `bf_pending__set_bit` 0x9216f8 (бит в 0x800648) **[код для 0x29]** |
| 0x2c | `hwm__alloc_and_store` (из `wmi_tof_set_tx_rx_offset`) | `ucode_cmd_0x2c_handler` 0x9373fc | TX/RX-смещение ToF (0x889800) |
| 0x2d | `ftm__send_ucode_session_cfg` (FTM) | `ucode_cmd_0x2d_handler` 0x926ab4 → `ucode_cmd_2d__set_bit` 0x9272c0 | FTM-кадр/голос за ресурс |
| 0x30 | `lmac_if_send_cmd_0x30` | `ucode_cmd_0x30_handler_uc` 0x92ff04 | RS start/abort (force MCS) |
| 0x31 | `tof_mgr__aoa_session_start` | `ucode_cmd_0x31_handler` 0x920dc8 | **AoA**: «AOA was started», отказ «BRP is pending or sta isn't connected» |
| 0x32 | `wmi_brp__alloc_and_store` (`wmi_brp_set_ant_limit`) | `ucode_cmd_0x32_handler` 0x923940 | ограничение антенн BRP |
| 0x33 | `lmac_if_upm_cfg_handler` | `ucode_cmd_0x33_handler` 0x93d2a8 | UPM: режим 0/1, период в [5000, 80000) **[код]** |
| 0x34 | — | `ucode_cmd_0x34_handler` 0x93d9d0 | ответ через `uc_evt__send_25` 0x9279a0 |
| 0x35 | `lmac_if_set_ss_sectors_default_cfg_handler`, `…order_handler` | `wmi_cmd_txss_set_sectors_order` | порядок секторов TXSS |
| 0x36 | `lmac_if_set_ss_sectors_number_handler` | `wmi_cmd_txss_set_sectors_number` | число секторов |
| 0x39/0x3a | `lmac_if_send_get/set_selected_rf_sector_index` | `get/set_selected_rf_sector_index_cmd_handler` | выбранный RF-сектор |
| 0x3b | `field_set_0x00__8db5bc` (UT) | `ucode_cmd_0x3b_handler` 0x926954 | слово в 0x80088c **[код]** |
| 0x3e | `fixed_sched__start` (`wmi_enable_fixed_scheduling`) | встроен в диспетчер (0x93cbae) | **включение фиксированного расписания: два gp-байта = 1**, тела не читает ([../6.2/docs/FIXED-SCHED.md](../6.2/docs/FIXED-SCHED.md)) **[код]** |
| 0x41 | `wmi_set_long_range` | `ucode_cmd_0x41_handler` 0x93a970 | Long Range; ставит action point (`arc_protect_addr_uc` 0x920fb4) |
| 0x42 | `sched__alloc_entry` (из `sched__apply_entry`) | `txrx_umac_if_config_pmc_triggers_handler` 0x93a7d4 | триггеры записи PMC («stop recording»); имя fw-отправителя `sched__*` не отражает назначения |
| 0x45 | `conn__alloc_and_fill` | `fwif_write_qh` | запись заголовка очереди (QH) |
| 0x47 | `lmac_if_echo_evt_handler` | `ucode_cmd_0x47_handler` 0x927368 → `peer_masks__or_into_8571c4` | QH-дескриптор по эхо |
| 0x48 | `fw_sysapi_mgr__get_flush_statistics_cmd_start` | `ucode_cmd_0x48_handler` 0x927618 | статистика flush → событие |
| 0x49 | `wmi_set_grant_mcs` | `ucode_cmd_0x49_handler` 0x9351e4 | байт MCS для grant в gp-переменную **[код]** |
| 0x4a | `wmi_set_ap_slot_size` | `ucode_cmd_0x4a_handler` 0x934ba4 | слово размера слота AP в gp-переменную **[код]** |

Запрещённые коды 6.2 — §5.1. Вспомогательные блоки группы команд 6.2 —
[../6.2/docs/MISC-UC.md](../6.2/docs/MISC-UC.md) §1.

---

## 3. Тела команд и вендорские структуры

### 3.1. Команда 0x00: `fui_cmds_hw_cfg_ifs_timing_cfg_s` по body+0x30 **[код] [железо] [пак]**

12-байтовая подструктура по смещению 0x30 тела команды 0x00 (len 0x44):

| смещ. тела | смещ. структуры | вендорское поле | значение 4.1 | мкс |
|---|---|---|---|---|
| +0x30 | +0x00 | `sifs_clk` | 0x1ef = 495 | **3.000** |
| +0x32 | +0x02 | `sifs_add_clk_limit` | 0x0a = 10 | 0.061 |
| +0x34 | +0x04 | `slot_clk` | 0x339 = 825 | **5.000** |
| +0x36 | +0x06 | `rifs_clk` | 0xa5 = 165 | **1.000** |
| +0x38 | +0x08 | `sbifs_clk` | 0xa5 = 165 | **1.000** |
| +0x3a | +0x0a | `reserved0` | не пишется | — |

Цепочка:

    8ec102  mov_s r2,0xa       ; sifs_add_clk_limit
    8ec10a  mov   r1,0x1ef     ; sifs_clk  (единственный иммедиат)
      -> lmac_if__send_init_cfg_cmd @8d8550:
    8d8574  stw_s r15,[r13,0x30]   ; sifs_clk
    8d8578  mov_s r0,0xa5
    8d857a  stw_s r0,[r13,0x36]    ; rifs_clk
    8d857c  stw_s r0,[r13,0x38]    ; sbifs_clk
    8d857e  mov   r0,0x339         ; slot_clk  (единственный иммедиат)
    8d8582  stw_s r0,[r13,0x34]
    8d8584  stw   r16,[r13,0x32]   ; sifs_add_clk_limit (r16 = r2)

Ucode: `ucode_cmd_0x00_handler` @0x934f68 → 0x934f8a
`memcpy(0x8019fc, body+0x30, 0xc)`, затем 0x934f90 `bl 0x931bd0`
(`ifs_cfg__program_from_hw_cfg`). Он пересчитывает значения через
`us_from_ticks165` @0x931c98 (вычитание 0xa5 в цикле; результат — пара байт
`{остаток в [r1], целых мкс в [r1+1]}`) в теневую копию 0x801a08 и программирует MAC:

| регистр | формула | ожидание | на железе |
|---|---|---|---|
| 0x886d00 | conv(sifs) \| 0x01730000 (0x931c0a) | 0x01730300 | 0x01730300 |
| 0x886d04 | conv(slot), биты 22/24/25 (0x931c14) | 0x03400500 | 0x03400500 |
| 0x886d08 | conv(sifs+slot) \| conv(2 × slot)<<16 (0x931c3a) | 0x0a000800 | 0x0a000800 |
| 0x886d0c | conv(rifs) \| conv(sbifs)<<16 (0x931c58) | 0x01000100 | 0x01000100 |
| 0x801a08+0x0c | conv(3 × sifs) = MBIFS 9 мкс (0x931bf0) | — | — |
| 0x886d14 | 0x452 (0x931c16) | 0x452 | 0x452 |
| 0x886d10 | по коду 0x100 | 0x100 | **0x35d** |

Такт MAC — **165 МГц** (165 тиков/мкс): суффикс `_clk` вендорского имени
буквальный; `sifs_clk = 495` → 3 мкс и `slot_clk = 825` → 5 мкс совпадают со
значениями 802.11ad DMG. Четыре регистра совпали с железом до бита.

Рычаг доступа к среде: `slot_clk` в `mov r0,0x339` @0x8d857e и `sifs_clk` в
`mov r1,0x1ef` @0x8ec10a — по одному иммедиату (правка 4 байта каждая).

Кольцевая команда MAC 0x1e — не тайминги IFS. Блок
`mac_sxd__program_886d88_and_cmd_1e` @0x93160c:

    93160e mov  r0,0x886d80
    931614 st   0xc0a0f1e,[r0,0x8]   ; одна запись в 0x886d88
    93161c/931622  кольцо: 0x1e <- 0x010004
    93162c/931632  кольцо: 0x1e <- 0x010001

На железе `0x886d88 = 0x0c0a0f1e`, запись единственная. Байты `1e 0f 0a 0c` при
165 тик/мкс — доли микросекунды, не длительности IFS; смысл регистра не установлен.
Единственный вызывающий — `bi_mode_init_sequence` @0x93171c, который зовётся один
раз из `uc_main_init` @0x921654 (до начала любой трассы кольца).

**0x886d88 в других версиях [код].** Запись единственная (@0x931614), читателей нет ни
в fw, ни в ucode. В банк масок QID (0x886d8c…0x886da8) не входит — арифметика индексов
замыкается на 0x886d8c. Адрес и константа идентичны в Sparrow 4.1, 6.2 и в прошивке
wil6436 7.5 (декодированы байты `wil6436.fw`) — аппаратная константа. Вендорского имени
в паке нет (в диапазоне 0x886c00…0x886f00 `PmcRegistersAccessor.cpp` знает только
0x886dc8 и 0x886eb8). **[гипотеза]** ставочный регистр данных для кольцевой команды 0x1e
(локальная идиома блока именно такая).

#### Тайминги IFS в данных ucode **[пак]**

* **`0x8019fc = g_ifs_timing_cfg`** — `fui_cmds_hw_cfg_ifs_timing_cfg_s`, 12 Б.
* **`0x801a08 = g_ifs_cfg`** — `ifs_cfg_s`, 14 Б (112 бит), 7 полей
  `usec_clk_time_s {u8 clks; u8 usec}` (`clks` биты 0..7, `usec` 8..15):
  `+0 sifs, +2 slot, +4 sifs_plus_slot, +6 two_slots, +8 rifs, +0xa sbifs,
  +0xc three_sifs`. Порядок совпадает с записями `txrx_api_step_b`
  @0x931be0…0x931c50. Употребление: `0x801a09` (sifs.usec) читает
  `rx_flow__grant_detected`; `0x801a0b` (slot.usec) — `rx_funcs__rx_flow` и
  `mac__prepare_txrx_window`; `0x801a14` (three_sifs = MBIFS 9 мкс) —
  `mac_mode_kick`, `rx_funcs__handle_ppdu_report`, `txss__flow_body`.

#### Момент ответа RX→TX: 0x886d10 **[код] [железо]**

Живое значение пишет не инициализация, а приём. **4.1:** единственная запись в образе —
`st r1,[0x886d10]` @**0x92de00** в `rx_flow_step`:

    кольцо: 0x4d000000                  ; MAC-команда 0x4d -> R55[0] = SIFS_CNT
    clks = SIFS_CNT.clks + [0x801660](=4) + 13
    {rem,carry} = us_from_ticks165(clks)
    usec = SIFS_CNT.usec + [0x801661](=1) + carry
    [0x886d10] = (usec << 8) | rem

На железе `0x35d` → usec=3, rem=93 ⇒ `SIFS_CNT = {clks 76, usec 2}` без остатка.
`R55[0] = SIFS_CNT` (поля clks/usec, вендорское имя из `MSXD_LR_RGF`); `R42`
бит 0 = `sifs_event`, бит 2 = `start_sifs_rifs_bifs_event`; `R40[b]` бит 15 =
`sifs_resp`; `rx_flow__run` ждёт `sifs_event`. Формула и писатель — **[код]**,
смысл — **[гипотеза]**. Поправочные байты `0x801660[0]=4`, `[1]=1` приходят в
теле LMAC-команды 0x00 (иммедиаты @0x8ec074/0x8ec07a) — рычаг по 2 байта
(см. [MAC-REGISTERS.md](MAC-REGISTERS.md)).

**6.2:** писатель — `rx_flow_step` (инструкция 0x931ea0, `st r3,[0x886d10]`), формула
та же: MAC-команда 0x4d → R55 = SIFS_CNT, `clks = SIFS_CNT.clks + [0x802588] + 13`,
`usec = SIFS_CNT.usec + [0x802589] + перенос` (`mac_clk__div165` 0x936b94).
Добавки в 6.2 лежат не в 0x801660, а в первых двух байтах тела LMAC 0x00
(0x802588) и живьём равны {4, 1} — как в 4.1. На другом узле 6.2 в другой
момент было 0x557 (5 мкс + 87 тактов): значение зависит от SIFS_CNT последнего
принятого кадра, поэтому разница двух снимков — не разница настроек.

#### Тело 0x00 в 6.2 **[код, fw и ucode]**

`lmac_if__send_init_cfg` 0x8f3db8 / 4.1 0x8ec070 строит на стеке
0x24 Б (константы 150, 161, 123, 22, 18, 96, 106, 0x91, 10, 2 и битовые маски)
и зовёт `lmac_if_send_cmd_0x00` 0x8db8cc / 4.1 `lmac_if__send_init_cfg_cmd` 0x8d8550 (`sifs_clk`=0x1ef,
`sifs_add_clk_limit`=0xa в регистрах), который копирует их в тело, дописывает
по +0x30 ту же 12-байтовую `fui_cmds_hw_cfg_ifs_timing_cfg_s`, что в 4.1
(sifs 495, add 10, slot 825, rifs 165, sbifs 165 тактов 165 МГц), и слово
+0x40 = байт 0x8042c8. В ucode (`ucode_cmd_0x00_handler` 0x93a8d0 / 4.1 0x934f68): +0x40 →
gp-переменная; +0x30 (12 Б) → 0x802940+0x1c → `txrx_api_step_b_uc`
пересчитывает такты и пишет регистры 0x886d00/+4/+8/+0x14; +0x00..+0x2f →
0x802588 → `mac__program_886e0c_20b` 0x92f1a0 / 4.1 0x92b6a8, который раскладывает байты тела
в регистры MAC:

| регистр | байты тела (старший…младший) | значение 6.2 |
|---|---|---|
| 0x886e08 | b1 b0 b5 b4 | 0x010400a1 |
| 0x886e0c | b7 b6 b3 b2 | 0x007b0096 |
| 0x886e10 | b11 b10 b9 b8 | 0x00120016 |
| 0x886e14 | b19 b18 b13 b12 | 0x006a0060 |
| 0x886e18 | b17 b16 b15 b14 | 0x020a0291 |

затем две маски наборов очередей (MAC cmd 0x35/0x39 из полей +0x14…), команды
0x38000200/0x3c000200 и константа 0x0be41190 в 0x886e1c. Шестнадцатибитные
поля 150, 161, 123, 22, 18, 96, 106 в тактах 165 МГц — 0,91…0,11 мкс,
правдоподобно задержки переключения RX/TX **[гипотеза]**. Порядок подъёма MAC,
в котором отправляется команда, — [L2-MANAGER.md §2](L2-MANAGER.md#2-подъём-mac--l2mgr__mac_bringup-порядок-вызовов-код).

**Живые значения 4.1 и 6.2 на одном узле [железо]:**

| регистр | 4.1 | 6.2 | смысл |
|---|---|---|---|
| 0x886d00 | 0x01730300 | 0x01730300 | SIFS 3 мкс |
| 0x886d04 | 0x03400500 | 0x03400500 | slot 5 мкс |
| 0x886d08 | 0x0a000800 | 0x0a000800 | SIFS+slot 8, 2·slot 10 |
| 0x886d0c | 0x01000100 | 0x01000100 | RIFS 1, SBIFS 1 |
| 0x886d10 | 0x0000035d | 0x00000389 / 0x557 | момент запуска ответа RX→TX, пересчитывается по каждому кадру (выше) |
| 0x886d14 | 0x00000452 | 0x00000452 | — |
| 0x886d18 | 0x00018ff8 | 0x00018ff8 | — |
| 0x886d88 | 0x0c0a0f1e | 0x0c0a0f1e | — |
| 0x886e08…0x886e1c | как в таблице выше | те же | — |
| 0x886f70/74 | 0x07d007d0 | 0x07d007d0 | предел TXOP 2000 мкс |

Тайминги MAC 6.2 и 4.1 совпадают до бита, кроме 0x886d10.

### 3.2. Команда 0x0b: `fui_bi_cfg_params_s` и дескрипторы развёртки **[код] [пак]**

Тело 0x94 Б, `ucode_cmd__bi_config` @0x932f8c:
* 0x932fa0: `memcpy(0x801a9c, body+0x04, 0x38)`;
* 0x932fb0: `memcpy(0x801438, body+0x74, 0x20)` — **`fui_bi_cfg_params_s`**;
* 0x932fb6: `[0x801a9c+0x54] = body[0x7d]` (= `txss_span`);
* 0x932fc0: `body[0x00]` — трёхсторонний разветвитель (0/1/2), отдельное поле от `bi_mode`.

`fui_bi_cfg_params_s` по body+0x74 = 0x801438 (host 0x941438) совпадает поле в поле
(раскладка — [../4.1/docs/BEACON-CONFIG.md](../4.1/docs/BEACON-CONFIG.md)):

| смещ. | вендорское поле | в 4.1 |
|---|---|---|
| +0x00 | `bi_mode`: `BI_RX_BCON`=0, `BI_TX_BCON`=1, `BI_TX_DISCOVERY_BCON`=2, `BI_TX_DIRECT_SINGLE_BCON`=3 | «bcon_kind»; гейт рандомизатора @0x923e0c сравнивает с 2 — DISCOVERY-маяк |
| +0x04 | `n_bis_abft` | `A>>29`; host 0x94143c |
| +0x05 | `n_abft_in_ant` | `(B>>6)&0x3f` |
| +0x06 | `responder_abft_ratio` | не пишется |
| +0x07 | `fss` | `(A>>10)&0xf` |
| +0x08 | `bi_at_ratio` | принудительно 0 |
| +0x09 | `txss_span` | `(A>>22)&0x7f` |
| +0x0a | `abft_length` | `(A>>7)&7` |
| +0x0b..0x10 | `abft_responder_address[6]` | MAC цели направленного скана (`memcpy(cmd+0x7f, mac_ptr, 6)` @0x8d8106) — слот переиспользован для `BI_TX_DIRECT_SINGLE_BCON` |
| +0x14 | `flags`: b0 `cc_present`, b1 `discovery_mode`, b2 `fragmented_txss`, b3 `pcp_assoc_ready` | порядок бит подтверждён логом `Send CMD_BCON_MGT: flags.pcp_assoc_ready = %x, discovery_mode = %d` |
| +0x18 | `tsf` (u64) | якорь TSF рандомизатора (`ld/st [r13,0x18]/[r13,0x1c]`) |

Снимок на стенде (PCP) **[железо]**:

    0x801438: 01 00 00 00  04 00 00 0f  00 01 01 00 ...
              bi_mode=1    n_bis_abft=4, fss=0x0f, txss_span=1, abft_length=1
    0x80144c: flags = 0x08  (бит 3 = pcp_assoc_ready)

**`fui_sector_sweep_params_s` (140 Б) в 4.1 не совпадает.** Область
`body+0x04..0x73` (112 Б, обнуляется `memset(cmd+4, 0, 0x70)` @0x8c3d3c) содержит
**28-байтовые дескрипторы развёртки секторов**; ucode копирует первые 0x38
(2 записи) в 0x801a9c и адресует их шагом 0x1c по счётчику TXSS
(0x92406c: `ld [0x801a9c+0x5c]`, `x0x1c`, `add r1,r11,r2`; также 0x932e18, 0x932f6e).

Дескриптор заполняют `bcn_tx_init_ss_params` @0x8c3d2c (для 0x0b) и
`lmac_if_send_cmd_0x0c` @0x8d83ec (для 0x0c; ucode копирует ровно 0x1c Б из
body+0x04 @0x935f22):

| смещ. | разм. | поле | доказательство |
|---|---|---|---|
| +0x00 | u32 | `tx_sector_mask_lo` (секторы 32..63) | лог `mask_lo[32:63]=0x%08x` ← `[cmd+0x04]` (0x8c3e30) |
| +0x04 | u32 | `tx_sector_mask_hi` (секторы 0..31) | лог `mask_hi[0:31]=0x%08x` ← `[cmd+0x08]` (0x8c3e2a) |
| +0x08 | u32 | читает `beacon_tx__build_slot_bitmap` (0x932e24) | — |
| +0x18 | u8 | антенна/контекст (`[vif+0x28]` для 0x0b, `1` для 0x0c) | 0x8c3d4a |
| +0x19 | u8 | `num_sectors_per_ant` = popcount(lo) + popcount(hi) | лог, 0x8c3e2e |
| +0x1a | u16 | `total_ss_frame_num` | 0x8c3d6e, 0x8c3dd4, 0x8c3dfe; ucode читает 0x924084, 0x932f76 |

С вендорской структурой общее только имя `total_ss_frame_num`: в паке 11ad пара
64-битных масок заменена байтовым списком `tx_sectors[128]` и двумя `is_*_custom`.

Область 0x801a9c за пределами копии (владеет ucode): `+0x38/+0x3c` битовая карта
слотов, `+0x44/+0x48`, `+0x54` = `txss_span`, `+0x5c` = счётчик развёртки
(заворачивается по `+0x54`, 0x924118), `+0x60/+0x64/+0x68` вычисляются на
0x9331b4..0x9331ca.

### 3.3. Команда 0x15: `fui_cmds_lmac_personality_s` **[код] [пак]**

Тело 8 Б; обработчик встроен в разветвитель, заглушка 0x936fba:

    936fba  ld_s  r1,[r13]        ; body+0x00
    936fbc  ld_s  r0,[r13,0x4]    ; body+0x04
    936fbe  st.as r1,[gp,0xc4]    ; -> personality
    936fc2  st.as r0,[gp,0xc8]    ; -> failure_policy

| смещ. | вендорское поле | перечисление по потребителю |
|---|---|---|
| +0x00 | `personality` | `ucode_cmd_trigger_bf` 0x92226e: при `[gp,0xc4] == 1` запуск BF пропускается → `LMAC_PASSIVE` = 1, `LMAC_ACTIVE` = 0 |
| +0x04 | `failure_policy` | `bf_sm__check_request_timeout` 0x9220ee и `bf_sm__check_sta_timeout` 0x922534: `[gp,0xc8] != 1` → путь отказа (0x9283c8, код 0x11); `== 1` → повтор → `BF_RETRY_FOREVER` = 1, `BF_ABORT_UPON_FAILURE` = 0 |

Отправитель: `maintain_sm__set_rs_params` @0x8ea564 (`maintain_sm.cpp`, ассерт
0x8ea578), `f(obj, mode, policy)`: кладёт оба в объект по `+0x30/+0x34`,
отображает `mode` 0→0, 1→1 (иначе ассерт), затем
`lmac_if__send_lmac_personality(personality, policy)` @0x8ea58c.

### 3.4. Команда 0x10: `fui_cmds_bf_sm_mgmt_s` по body+0x24 (частично) **[код] [пак]**

Тело 0x30; fw делает `memcpy(body, 0x80130c, 0x30)` (0x8c6272) и правит два слова.
`ucode_cmd_config_lmac_bf_sm` @0x922970 копирует 9 слов (36 Б) из body+0x00 в
0x800f74, затем читает:

| смещ. тела | вендорское (структура по body+0x24) | в 4.1 |
|---|---|---|
| +0x24 | +0x00 `wrong_sector_bis_threshold` | глобал `[gp,-0xe0]` (0x8c6278) **[гипотеза]** |
| +0x28 | +0x04 `cid` | результат `lm_if__get_cid` @0x8c9d8c; лог `lm_main_sm::config_lmac_bf_sm CID=%d` (0x8c6288) **[код]** |
| +0x2c | +0x08 `bf_trigger_max_cts_failure_cnt` | → `[0x8010e8+0x14]`, парная константа 0xe в `+0x16` (0x922996) |
| +0x2d | +0x09 `bf_trigger_max_back_failure_cnt` | → `[0x8010e8+0x15]`, парная 0xf в `+0x17` (0x9229a2) |
| +0x2e | +0x0a `bf_trigger_max_cts_failure_dense_thr` | → маска бита `32-v` в `[0x8010e8+0x18]` (0x9229b6) |

Вендорская структура 16 Б, команда 4.1 — 48 Б; видны первые 11 байт структуры,
положение `cid` на +0x04 закрепляет базу.

### 3.5. Команда 0x1e: CMD_SELECTIVE_NEIGHBOR_CFG **[код]**

Вендорской структуры нет; имена — из лог-строк 0x1004f24 + 0x1004f8c:
`Sending CMD_SELECTIVE_NEIGHBOR_CFG [selective_detection_en=%d, threshold=%d,
num_rates_reduction=%d, selective_nav_en=%d, threshold=%d, short_txop_en=%d]`.

| смещ. | поле | запись fw | получатель в ucode |
|---|---|---|---|
| +0x00 | `selective_detection_en` | 0x8d8a9e/0x8d8aa6 | `[0x800a0c+0x9]` = `[0x800a0c+0xf]` при 1, иначе 0 (0x937066) |
| +0x01 | порог детекции | 0x8d8aaa (иначе 0x2d) | `[0x800a0c+0xd]` (0x93706e) |
| +0x02 | `selective_nav_en` | 0x8d8ab6/0x8d8abe | `[0x800a0c+0xa]` (0x93706a) |
| +0x03 | порог NAV | 0x8d8ac2 (иначе 0x2d) | `[0x800a0c+0xb]` (0x937072) |
| +0x04 | `short_txop_en` | 0x8d8ad0 | `[gp,0x24]` ucode = 0x80054c (0x937076) |
| +0x05 | `num_rates_reduction` | 0x8d8ad8 | `[0x8009b4+0x8]` (0x937084) |

Поля публикуются в dashboard как биты 21/22/15 `dashboard_phy_mac_flags`
([../4.1/docs/DASHBOARD.md](../4.1/docs/DASHBOARD.md)).

**`short_txop_en` наблюдаемого эффекта в 4.1 не имеет [код].** Единственная запись
0x937076, единственное чтение — `mac__program_886f70_from_tbl` @0x931cac:

    931cac ld.as r3,[gp,0x24]   ; short_txop_en
    931cb8 cmp_s  r3,0x0
    931cba cmp.ne r0,0x0        ; только при short_txop_en != 0
    931cbe beq_s  0x931cc4      ; мимо сдвига
    931cc0 ld_s   r0,[gp,-0x28]
    931cc2 lsr    r2,r2,r0      ; деление предела TXOP

Единственный вход в блок — хвостовой переход 0x935046 из обработчика команды
0x21, в слоте задержки `_mov_s r0,0x0`, то есть r0 всегда 0 и сдвиг недостижим.
Проверены все каналы входа: прямые переходы (одна ссылка во всём листинге),
литералы `0x931cac` во всех трёх блобах (нет), fall-through (предыдущий блок
кончается `j_s.d blink` с занятым слотом), границы блоков. Делитель был бы
`>> 2` (`[gp-0x28]` = 2).

### 3.6. Команда 0x23: `fui_abft_resp_ctrl_s` **[код] [пак] [железо]**

Тело 0xc; `ucode_cmd_0x23_handler` @0x921770 → `ucode_cmd__load_table_80208c`
@0x921740: три слова в 0x802090/0x802094/0x802098 (host 0x942090/0x942094/0x942098) и
`stw 0,[0x80208c]`.

| смещ. | адрес | вендорское поле | значения 4.1 (`lmac_if__send_abft_resp_ctrl` @0x8d7efc) |
|---|---|---|---|
| +0x00 | 0x802090 | `abft_responder_mode` | 0x8d7f12/0x8d7f20: 2 (`ALWAYS`) или 0 (`UNASSOCIATED_ONLY`) |
| +0x04 | 0x802094 | `beacon_type` | 0x8d7f2a: 1 (`DISCOVERY`) или 2 (`ALL`) |
| +0x08 | 0x802098 | `relaxation_period` (u16) | 0x8d7f2e: всегда 1 |
| — | 0x80208c | рабочий счётчик отсрочки, сбрасывается | 0x92176c |

Перечисление по потребителю: `bti__bi2_event_step` 0x9321e0 и
`rx_flow__handle_frame` 0x92df78 читают `[0x802090]`: `==3` → выключено
(`ABFT_RESPONDER_MODE_EN_DISABLED`), `==0`/`==1` → проверка байта ассоциации
`[0x801034]` (`UNASSOCIATED_ONLY`/`ASSOCIATED_ONLY`), иначе работать (`ALWAYS`=2).
`abft_responder_worker` 0x92c72e перезаряжает 0x80208c из `[0x802098]` как u16.
Значения `beacon_type`: NOT_DISCOVERY / DISCOVERY / ALL.

Отправитель выдаёт ровно три набора:

    8d7f06 mov r1,0x80345c
    8d7f0c ld  r1,[r1,0xc]        ; гейт OOB = [0x803468]
    8d7f0e breq r1,0,0x8d7f16
    8d7f10 mov r1,0x2
    8d7f12 st  r1,[r0]            ; mode = 2 (ALWAYS)
    8d7f14 b   0x8d7f2a           ; r1 = 2 -> beacon_type = 2 (ALL)
    8d7f16 mov.f  r1,r13          ; r13 = аргумент
    8d7f1a mov.ne r1,0x1
    8d7f1e asl    r1,r1,1         ; mode = 2 при arg!=0, иначе 0
    8d7f20 st     r1,[r0]
    8d7f22 mov    r1,0x1
    8d7f24 cmp    r13,0x0
    8d7f26 sub_s.ne r1,r1         ; кодировка 0x79c0: major 0x0F, c=6 = SUB_S.NE b,b,b
    8d7f28 add_s  r1,0x1
    8d7f2a st     r1,[r0,0x4]     ; beacon_type = 1 при arg!=0, иначе 2
    8d7f2c mov    r1,0x1
    8d7f2e stw    r1,[r0,0x8]     ; relaxation = 1

| условие | mode | beacon_type | relax | вызывающие |
|---|---|---|---|---|
| гейт `[0x803468] != 0` | 2 ALWAYS | 2 ALL | 1 | любой |
| гейт 0, arg != 0 | 2 ALWAYS | 1 DISCOVERY | 1 | `pcp_start` @0x8eef18 (r0=1), `find_mng__add_bcon` @0x8c225c (r0=1) |
| гейт 0, arg == 0 | 0 UNASSOCIATED_ONLY | 2 ALL | 1 | `lmac_if__lmac_ready_evt` @0x8ede5c (r0=0) |

Та же структура задаётся с хоста прямой записью 0x942090/94/98 **[железо]**.
Работа ответчика и счётчики — §8.

### 3.7. Команда 0x21: пределы TXOP **[код] [железо]**

Тело 8 Б: 4 × u16 (в 4.1 все = `[gp,0x26c]`). Обработчик 0x935030
разворачивает их в четыре u32 по 0x8019ec/f0/f4/f8
(`mov r1,0x8019e8; add2 r1,r1,r2; st r3,[r1,0x4]`), затем
`mac__program_886f70_from_tbl` @0x931cac пишет
`[0x886f70] = (V1<<16) | min(V0,V1)` и `[0x886f74] = V2 | (V3<<16)`.

| регистр | без OOB | с OOB |
|---|---|---|
| 0x886f70 | 0x07d007d0 (2000 мкс) | 0x05000500 (1280 мкс) |
| 0x886f74 | 0x07d007d0 | 0x05000500 |

Значения приходят телом 0x21, а не через гейт `short_txop_en` (§3.5).

### 3.8. Команда 0x05: запись соседа **[код] [железо]**

Три подкода (0x93522e / 0x935344):
* **0 = CREATE** — memset 0x48 и заполнение всей записи, включая +0x44/+0x45/+0x46;
  байты +0x21/+0x22 тела пишутся только при подкоде 0;
* **1 = DESTROY** — `bf_sm__clear_sta`, сброс бита в 0x80091d, shallow-sleep;
* **2** — только обновление дескрипторов секторов.

Отправители: `lmac_if_send_cmd_0x05` @0x8d8e2c жёстко ставит 2, зовётся из
`host_if__set_sectors_hal` (лог `*** SET SECTORS HAL ***`);
`lmac_if_send_cmd_0x05_8f1074` — подкод 0 при подъёме линка (0x8e2858) и 1 при
`conn__teardown_mac_rules` (0x8f10de).

Запись соседа `0x801190 + 0x48·cid` (uc_data, host 0x941190):

| смещ. | поле |
|---|---|
| +0x04 | TX-селектор |
| +0x08 | RX-селектор (биты 0..3 CHIP ID, 4..7 тег 2/3, 8..22 ADDRESS) |
| +0x2c..+0x31 | MAC (сравнение в `rx_funcs__identify_peer` @0x9266b2) |
| +0x34 | ключ (команда 0x18) |
| +0x44 / +0x45 / +0x46 | тройка OOB: 0x01 / 0x04 (индекс MCS) / 0x43 (сектор) |
| +0x47 | флаг валидности ключа (`0x8011d7 + sta*0x48`) |

`0x04` — индекс в таблицу скоростей (`rate_search__apply_mcs` →
`hwd_mac__apply_timing_entry` @0x926dd0: `[0x886c70][15:0] = u16 tbl[0x800b64 + 2·idx]`,
`[0x886c74] = u8 tbl[0x800b80 + idx]`, `[0x886b00 + 4·cid] = idx`; 13 живых записей
= MCS 0..12, для idx 4 — 0x0020 и 0x50). `0x43` = 67 — строка (ADDRESS) таблицы
РЧ-секторов: `brp__apply_slot_mcs` @0x9258e0 (`bset r2,r2,0x5`, `st r2,[rec+0x4]`)
кладёт её в биты 8..15 TX-слова — слот, который `bf_sm__start_request` заполнил
бы из `[0x800fb1]`, а `bi_mode__reset_bf_state` @0x9222a8 инициализирует
значением 0x21 = 33. Смысл тройки: соседа не подстраивать, TX-сектор 0x43 и
MCS 4 фиксированы. Источник значений — `pf_mcs_value`/`pf_rx_sector_value` (§6.4).

Снимок при двух узлах в OOB без ассоциации **[железо]**:

| | узел A, cid 0 | узел B, cid 0 |
|---|---|---|
| MAC (+0x2c) | MAC узла B | MAC узла A |
| +0x44 / +0x45 / +0x46 | 0x01 / 0x04 / 0x43 | 0x01 / 0x04 / 0x43 |
| TX-сел (+0x04) | 0x00000020 | 0x00000020 |
| RX-сел (+0x08) | 0x00000b30 | 0x00000b30 |
| key_valid (+0x47) | 0 | 0 |

### 3.9. Прочие тела **[код]**

* **0x09 trigger_bf** (0xc): `{+0x00=1, +0x04=bf_cmd_type, +0x08=cid}`; лог
  `lmac_if_trigger_bf: cid=%d, bf_cmd_type=%d`; ucode индексует
  `0x857838 + cid*0x14`, ставит бит 4 (`BF_TRIGGER_FW_MSK`) в `+0x11` (0x922296).
  Вне OOB `bf_cmd_type` в body+4 принудительно обнуляется (0x8d8cc8).
* **0x14** (8): `{+0x00 u32 cid, +0x04 u32 flags b0..b4}` → `[gp,0xb4]`, `[gp,0xb8]`
  (0x936fb0); `[gp,0xb8]` читают все пути передачи (0x933cfa, 0x93442e, 0x934544,
  0x93462a, 0x93477c); `cid` (`[gp,0xb4]`) не читается — маска глобальная.
  Маска причин ретриггера BF (байт `0x857838 + 0x14·cid + 0x11`); декодер
  `lmac_if__bf_done_evt` @0x8d830c через байтовую таблицу
  `fw_data[0x801b88] = [00,04,1c,08,1c,1c,1c,10]` (цели `0x8d8328 + 2·tbl`):

  | бит | имя (строка) |
  |---|---|
  | 0 | `BF_TRIGGER_RS_MCS1_TH_FAILURE_MSK` (0x1004110) |
  | 1 | `BF_TRIGGER_RS_MCS1_NO_BACK_FAILURE_MSK` (0x1004150) |
  | 2 | `BF_TRIGGER_MAX_CTS_FAILURE_MSK_IN_TXOP` (0x1004194) |
  | 3 | `BF_TRIGGER_MAX_BACK_FAILURE_MSK` (0x10041d8) |
  | 4 | `BF_TRIGGER_FW_MSK` (0x1004214), ставит команда 0x09 |
  | 5 | `BF_TRIGGER_MAX_CTS_FAILURE_MSK_IN_KEEP_ALIVE` (0x1004244) |

  Лог вызывающего: `MAINTAIN_SM::OPEN BF Triggers` (0x1011f3c);
  `tx_initiator_substep` @0x93440a при ненулевом байте уводит решение об окне TX в
  другую ветку; `maintain_sm__reset_link_cfg` @0x8eafc4 шлёт нули при сбросе
  линка (0 = всё выключено). В OOB байт равен 0x00 для всех cid **[железо]**.
* **0x11** (0x10): 4 × u32 из gp-глобалов fw → `memcpy(0x8016b4, body, 0x10)` (0x93029c).
* **0x13 rs_enable** (0x28): 38-байтовая (0x26) конфигурация набора скоростей
  (0x8d88d6); ucode `memcpy(0x801898 + cid*0x26, body+2, 0x26)` @0x92bf8c.
* **0x18 install_key** (0x20): `{+0x00 u32 sta_index, +0x04 u32 key_class (0/4→1, 1→0),
  +0x08 u32 field_offset=0x34, +0x0c u32 key_len=0x10, +0x10 key[16]}`; ucode
  `memcpy(0x801190 + sta*0x48 + [body+8], body+0x10, [body+0xc])` @0x9353c8,
  байт флага `0x8011d7 + sta*0x48`. В OOB `install_key_index_stub` (0x8e945e)
  подменяет `sta_index` на 8 только при arg4 != 0; все три вызывающих (0x8ebbd6,
  0x8ed770, 0x8ed7d6) передают 0 — ветка недостижима.
* **0x20 phy_ina_det_cfg** (0x24): 36 Б → `memcpy(0x801690, body, 0x24)` (0x92b1a4);
  `body+0x20` бит 0 = `ad_in_txop_en`, бит 1 = `ad_out_of_txop_en` (лог 0x1003e8c).
  Вендорское имя — `CMD_PHY_INA_DET_CFG` **[код + железо]**: при LMAC READY шлётся
  глобальная `0x800af8` (4.1) / `0x800bdc` (6.2). Содержимое в образах 4.1 и 6.2 и
  живьём на 6.2 одинаково: `20 13 5a 13 01 00 00 00 20 13 5a 13 03 00 00 00
  20 13 5a 13 02 00 00 00 73 13 5f 13 03 00 00 00 02 00 00 00` (AD вне TXOP
  вкл, внутри — выкл). Менять его может только `wmi_cfg_rx_chain` в режиме
  сниффера (`sniffer_cfg.mode == 1`: CP → оба бита 0, DP → 0 и байт +4 = 2,
  AD → бит 1).
* **0x24 discovery_mode_cfg** (8): `{+0x00 discovery_mode, +0x04 discovery_type}` →
  `[gp,-0xef]` (0x934dec); лог 0x1004c90; обработчик печатает «DISCOVERY ON».
* **0x25 update_aw_ie** (0x14): `{+0x00 = 0x9d (магия, ассерт @0x9357e8),
  +0x04 tbtt_start_time, +0x08 awake_window_duration, +0x0c = 1}`; имена из лога
  0x1004ed4; `aw_ie__copy_to_bcon` @0x930420 вклеивает body+0x04.. в шаблон маяка
  по 0x801ed0+0x3c.
* **0x39/0x3a** (по 4): `{u8 idx/cid, u8 type}` и `{u8 cid, u8 type, u16 sector}`.
* **0x41 long_range** (4): `txrx_umac_if_long_range_cmd_handler` @0x934fdc тела не
  касается — читает `[0x857280+0x18]`, куда fw пишет перед отправкой (0x8e7e16).
  0x857280 — общая память fw/ucode; команда означает «перечитай».

### 3.10. Вендорские структуры, отсутствующие в 4.1 **[код] [пак]**

* `fui_rx2tx_pre_tx_timing_cfg_s` (12 Б) / `fui_tx2rx_post_tx_timing_cfg_s` (8 Б) —
  в паке 11ad члены `fui_tr_switch_cfg_s` (T/R-ключ), пары `{*_clks, *_usec}`, то
  есть форма после `us_from_ticks165`. В 4.1 команды нет; пофазные тайминги —
  вшитые записи в `bi_mode__program_mac_timing` @0x931b98. Значения на железе:

      0x886d58 = 0x005300a5   -> {0x00a5, 0x0053}
      0x886d5c = 0x00040063
      0x886d60 = 0x00010001
      0x886de8 = 0x00060025   -> {0x0025, 0x0006}
      0x886dec = 0x0002000b   -> {0x000b, 0x0002}

  Чтение как `{clks, usec}` **[гипотеза]**: соотношение не равно 165.
* `fui_rs_cfg_ex_s` (80 Б) — не совпадает: команда 0x13 несёт 38-байтовую
  конфигурацию; вариант `_ex` более поздний.
* `fui_cmds_tssi_*`, `fui_agc_start_values_s`, `fui_tr_switch_*`,
  `fui_get_rx_pkt_phy_data_evt_s`, `fui_events_linear_power_*`,
  `fui_events_ftm_res_evt_s` — команд и событий подходящего размера нет;
  строк FTM нет ни в одном блобе.

Строк `personality`/`IFS`/`sifs`/`relaxation`/`rx2tx` в блобах строк 4.1 нет;
соответствия §3 получены разбором потока данных.

### 3.11. Сводка по вендорским структурам

| вендорская структура | в 4.1 |
|---|---|
| `fui_bi_cfg_params_s` | точно: 0x0b body+0x74 → 0x801438 |
| `fui_abft_resp_ctrl_s` | точно: 0x23 → 0x802090, перечисления проверены |
| `fui_cmds_lmac_personality_s` | точно: 0x15, перечисления проверены |
| `fui_cmds_hw_cfg_ifs_timing_cfg_s` | точно: 0x00 body+0x30; такт 165 МГц; подтверждено регистрами |
| `fui_cmds_bf_sm_mgmt_s` | частично: 0x10 body+0x24; `cid` доказан |
| `fui_sector_sweep_params_s` | не совпадает; 28-байтовые дескрипторы с масками, общее имя `total_ss_frame_num` |
| `fui_events_awake_peer_evt_s` | имена да, раскладка нет (событие 0x16 — 4 байта) |
| `fui_rx2tx_pre_tx_timing_cfg_s` / `fui_tx2rx_post_tx_timing_cfg_s` | не команда; вшитые пары в `bi_mode__program_mac_timing` [гипотеза] |
| `fui_events_ftm_res_evt_s`, `fui_rs_cfg_ex_s`, `fui_cmds_tssi_*`, `fui_agc_*`, `fui_tr_switch_*` | отсутствуют |

---

## 4. События ucode → fw

### 4.1. Таблица (4.1)

| тип | имя (строка `Ucode->`) | обработчик fw | отправитель ucode | длина тела |
|---|---|---|---|---|
| 0x00 | EVENT_UCODE_READY | `lmac_if__lmac_ready_evt` | `uc_send_evt__ucode_ready` @0x925b5c | 0 |
| 0x01 | RX_ON_RSP | `lmac_if_rx_on_off_rsp_handler` | — | — |
| 0x02 | EVENT_ECHO | `lmac_if_echo_evt_handler` | — | — |
| 0x03 | RX_OFF_RSP | `lmac_if_rx_on_off_rsp_handler` | обработчик команды 0x03 (0x93504c) | — |
| 0x04 | EVENT_FLUSH_Q_DONE | `lmac_if_flush_q_done_handler` | — | — |
| 0x05 | NEW_LINK_EVT | `obj_800140__vt20` | `uc_send_evt__new_link` @0x925c6c | — |
| 0x06 | BF_DONE_EVT | `lmac_if__abft_notify_evt` | `uc_send_evt__bf_done` @0x925bd0 | 0x20 (8 слов r0..r7) |
| 0x08 | QUEUE_DELETED_EVT | `lmac_if_queue_deleted_handler` | — | — |
| 0x09 | LINK_LOST_EVT | `lmac_if_link_lost_handler` | `uc_send_evt__link_lost` @0x925c40 | — |
| 0x11 | STA_UPDATE_FIELD_RSP | `lmac_if__key_evt` | `uc_send_evt__sta_update_field_rsp` @0x925d54 | — |
| 0x13 | RS_STARTED_EVT | `LMAC_IF__rs_started` | `uc_send_evt__rs_started` @0x925cdc | — |
| 0x14 | RS_DONE_EVT | `lmac_if__rs_done_evt` | `uc_send_evt__rs_done` @0x925cb0 | — |
| 0x15 | PS_SHALLOW_SLEEP_NTF_EVT | `lmac_if_ps_shallow_sleep_ntf_handler` | `uc_send_evt__ps_shallow_sleep_ntf` @0x925d28 | — |
| 0x16 | PS_AWAKE_PEER_EVT | `lmac_if__awake_peers_evt` @0x8d8078 (через `obj_800140__vt20`) | `uc_send_evt__ps_awake_peer` @0x925ba4 | 4 |
| 0x17 | MAC_MONITOR_EVT | `lmac_if__mac_monitor_report` | `uc_send_evt__mac_monitor` @0x925b84 | 4 (значение аргумента — константа 1, не указатель; 0x925b94…0x925b98, r0 = 1 в 0x937208) |
| 0x18 | PS_TRAFFIC_DEFERRAL_CFG_EVT | `lmac_if_ps_traffic_deferral_cfg_handler` | — | — |
| 0x19 | PS_WAKE_PCIE_EVT | `lmac_if_ps_wake_pcie_handler` | `uc_send_evt__ps_wake_pcie` @0x925d80 | — |
| 0x27 | EVT_GET_SELECTED_RF_SECTOR_INDEX_DONE | `lmac_if__send_get_rf_sector_done` | `uc_send_evt__get_rf_sector_done` @0x925c14 | — |
| 0x28 | EVT_SET_SELECTED_RF_SECTOR_INDEX_DONE | `lmac_if__send_set_rf_sector_done` | `uc_send_evt__set_rf_sector_done` @0x925cfc | — |

### 4.2. Событие 0x16 PS_AWAKE_PEER_EVT **[код] [пак]**

Отправитель 0x925ba4: `memcpy(evt, r0, 4)`, `mov r1,0x16`, `mov r2,0x4` @0x925bc4.
Обработчик `lmac_if__awake_peers_evt` @0x8d8078, лог 0x1004488: `AWAKE PEERS EVENT:
awake peers vector = 0x%x, awake no tx peers vector = 0x%x, notification_type: %x`
с аргументами `body[1], body[2], body[3]`.

| смещ. | поле | смещ. в `fui_events_awake_peer_evt_s` |
|---|---|---|
| +0x00 | (mid?) — не читается | `mid` @+0x08 |
| +0x01 | `psc_awake_peer_vector` | @+0x09 |
| +0x02 | `psc_awake_no_tx_peer_vector` | @+0x0a |
| +0x03 | `notification_type` (u8; `==2` → путь `UPM_ENTRY_NTF` 0x8edc1c, 0x8d80a6) | @+0x00 как u32 |

В паке 11ad структура 16 Б с u32-перечислениями плюс `psc_state`, `upm_vector`,
`psc_not_set_sta_vector`; проверка `==2` согласуется с `UPM_ENTRY_NTF` = 2.

### 4.3. Событие 0x06 BF_DONE_EVT и Discovery A-BFT **[код]**

У `handle_abft_event` @0x8ebe88 ровно один вызывающий — `bl 0x8ebe88` @0x8d81e4 в
`lmac_if__abft_notify_evt`, за гейтом OOB:

    8d81c2 mov_s r0,0x80345c
    8d81c8 ld_s  r0,[r0,0xc]      ; гейт OOB
    8d81ca breq_s r0,0,0x8d820c   ; без OOB — мимо
    ...
    8d81e4 bl.d  0x008ebe88       ; handle_abft_event

Ссылок на 0x8ebe88 из данных нет: без OOB подъём линка по Discovery A-BFT
недостижим. В `handle_abft_event` на 0x8ebe98 `sub.eq r14,r14,r14` обнуляет статус
при `BF Status == 1` (BF_DONE_OK) — «status 0» означает успех.

---

## 5. Различия 4.1 и 6.2

Механизм и номера не менялись: все команды 4.1 есть в 6.2 под теми же кодами, все
типы событий 4.1 — под теми же номерами; обёртки отправки событий совпадают даже
размерами блоков (44/44/32/68 Б). Коды 0x0a, 0x0d, 0x0e, 0x17, 0x1a, 0x1c, 0x1d,
0x1f — дырки в середине диапазона в обеих версиях (зарезервированы).

### 5.1. Транспорт

| | 4.1 | 6.2 |
|---|---|---|
| отправка | `send_cmd2_lmac` @0x8e0694, гейт `[gp,0x238]` | `lmac_if__post_cmd` @0x8e5204, гейт `[gp,0x244]` |
| построение шапки | `basic_if__mailbox_send` @0x8e048c | 0x8e4ff8 (та же раскладка; +0x06 дополнительно b3 из стекового аргумента) |
| объект ящика | 0x803e3c | 0x804280 |
| звонок | `[0x886d80+0x58] = 1` (0x886dd8 `fw2uc_ICS`) | то же |
| диспетчер ucode | `umac_if_cmd_handler` @0x936dd0 | `ucode_cmd_dispatch` @0x93c928 |
| таблица команд | **байтовая** 0x800c68, заглушки от 0x936e5e | **полуслов** 0x8019dc, заглушки от 0x93c966 |
| предел кода | 0x41 | 0x4a |
| разных обработчиков | 36 команд (30 из 66 записей — общая заглушка) | 62 команды, 59 разных обработчиков (13 из 75 записей — заглушка) |
| диспетчер событий fw | `lmac_if__ucode_event_dispatch` @0x8dae80, таблица 0x801b98, ветки от 0x8daeb8 | @0x8df07c, таблица 0x801f40, ветки от 0x8df0bc, типы 0…0x30 |
| событий | 19 | 32 собственные ветви |
| очередь событий ucode | `uc_send_event` @0x925dd8 | объект 0x802470; `uc_evt__enqueue` 0x927958 (r1 — тип, r2 — длина, снимает TSF) → `uc_evt__queue_put` 0x9349dc |

В 6.2 коды 0x06 — встроенный фатал 0xa3; 0x0a, 0x0d, 0x0e, 0x17, 0x1a, 0x1c, 0x1d,
0x1f, 0x3f, 0x40, 0x43, 0x44, 0x46 ведут в `uc_sysassert`.

### 5.2. Тела команд, различающиеся в 6.2 **[код]**

| код | 4.1 | 6.2 |
|---|---|---|
| 0x07 | подкод 1/2, битовые поля | FTM «радио получено» (`ftm_main_sm__radio_allocated_cb`) |
| 0x0f | `{u32, u16}` | сброс состояния CID (`ucode_cmd__reset_queue_state` 0x92b210) |
| 0x11 | 4 × u32 → 0x8016b4 | AGC-старт/таблица усиления (`silent_rssi__report_agc_tables`) |
| 0x14 | `cid` → `[gp,0xb4]`, flags → `[gp,0xb8]` | одно слово → `[0x8021b8+0x20]` (встроен, 0x93ca22) |
| 0x15 | два слова → `[gp,0xc4]`/`[gp,0xc8]` (personality/failure_policy) | два слова → `[gp,0xb4]`/`[gp,0xb8]` (встроен, 0x93ca30); отправитель — тот же `maintain_sm__set_rs_params` |
| 0x16 | байт `[0x800d08]` | байт поля +0xb4 калибровочного объекта → `[gp+0x24]` ucode |
| 0x19 | `{u8, u16, u32}` | RX omni-сектор (UT) |
| 0x21 | 4 × u16 = `[gp,0x26c]` | 4 значения ≤ 0x7ff мкс, 0x500 в OOB; второе значение пары сдвигается на `[gp-0x24]` (`txop__apply_limits_regs` 0x936ba8) |
| 0x23 | 3 слова → 0x802090/94/98, счётчик 0x80208c | та же раскладка → 0x803128/0x80312c/0x803130, счётчик 0x803124 (0x920b1c) |
| 0x26 | отправитель есть | отправителя по коду не найдено; обработчик → `keep_alive__arm_slot` 0x939484 |
| 0x41 | тело не читается | дополнительно ставит action point (`arc_protect_addr_uc` 0x920fb4) |

Новые в 6.2 коды (0x28–0x4a): измерительные запросы 0x28/0x2a/0x2e/0x37/0x3c и
0x29/0x2b/0x2f/0x38/0x3d, ToF 0x2c, FTM 0x2d, AoA 0x31, ограничение антенн BRP 0x32,
UPM 0x33, 0x34, сектора TXSS 0x35/0x36, 0x3b, фиксированное расписание 0x3e,
триггеры PMC 0x42, QH 0x45/0x47, статистика flush 0x48, grant MCS 0x49, слот AP 0x4a.
Полная таблица — §2.2,
расписание — [../6.2/docs/FIXED-SCHED.md](../6.2/docs/FIXED-SCHED.md).

### 5.3. События 6.2

| тип | имя | обработчик fw 6.2 |
|---|---|---|
| 0x00 | EVENT_UCODE_READY | `lmac_if__lmac_ready_evt` |
| 0x01 | (RX_ON_RSP по 4.1) | `rm_main_sm__inject_lock_evt` |
| 0x02 | EVENT_ECHO | `lmac_if_echo_evt_handler` |
| 0x03 | (RX_OFF_RSP по 4.1) | `rf__get_active_mask` |
| 0x04 | EVENT_FLUSH_Q_DONE | `event_flush_q_done` |
| 0x05 | NEW_LINK_EVT | `new_link_evt` |
| 0x06 | (BF_DONE_EVT) | `lmac_if__abft_notify_evt` |
| 0x08 | QUEUE_DELETED_EVT | `queue_deleted_evt` |
| 0x09 | LINK_LOST_EVT | `lmac_if_link_lost_evt_handler` |
| 0x11 | STA_UPDATE_FIELD_RSP | `return_field_type` |
| 0x13 | RS_STARTED_EVT | `LMAC_IF__rs_started` |
| 0x14 | (RS_DONE_EVT) | `lmac_if__rs_done_evt` |
| 0x15 | PS_SHALLOW_SLEEP_NTF_EVT | `ps_shallow_sleep_ntf_evt` |
| 0x16 | (PS_AWAKE_PEER_EVT) | `new_link_evt` |
| 0x17 | (MAC_MONITOR_EVT) | `lmac_if__update_pct_stats` ([MAC-MON](MAC-MON.md)) |
| 0x18 | PS_TRAFFIC_DEFERRAL_CFG_EVT | `ps_traffic_deferral_cfg_evt` |
| 0x19 | PS_WAKE_PCIE_EVT | `ps_wake_pcie_evt` |
| 0x20 | SYSAPI_ENERGY_STATISTICS_READY_EVT | `fw_sysapi_mgr__complete_pending_request` |
| 0x21 | SYSAPI_ENERGY_PLCP_HEADER_READY_EVT | `fw_sysapi_mgr__complete_pending_request` |
| 0x22 | — | `ftm__responder_rx_req__with_ctx` |
| 0x23 | SYSAPI_GET_RX_PKT_DATA_EVT | `fw_sysapi_mgr__complete_pending_request` |
| 0x24 | AOA_MEAS_EVT | `lmac_if_aoa_meas_evt_handler` |
| 0x25 | UPM_IMMEDIATE_RSP | `upm_immediate_rsp` |
| 0x26 | SYSAPI_PHY_RX_STATISTICS_EVT | — |
| 0x27 | EVT_GET_SELECTED_RF_SECTOR_INDEX_DONE | `evt_get_selected_rf_sector_index_done` |
| 0x28 | EVT_SET_SELECTED_RF_SECTOR_INDEX_DONE | `evt_set_selected_rf_sector_index_done` |
| 0x29 | EVT_SCHEDULED_SCHEME_NOTIFY_FW_PUSH_SLOTS | `brd_if_multi_array__get_section_info` |
| 0x2b | SYSAPI_CHANNEL_ESTIMATION_EVT | — |
| 0x2c | EVT_PMC_STATUS | — |
| 0x2e | — | `ba__on_uc_timeout_evt` |
| 0x2f | EVT_GET_FLUSH_STATISTICS_DONE | — |
| 0x30 | EVT_FIXED_SCHEDULING_ENABLED | `evt_fixed_scheduling_enabled` |

Отправители событий на стороне ucode 6.2 (в скобках — 4.1, §4.1):
`uc_send_evt__ucode_ready` 0x927508 (0x925b5c; вместе с `uc_mailbox__init_rings` 0x9359b8
(0x930fc4), `uc_ring__init_desc` 0x92adf0 (0x928098), `mac__ddc_mask_bit3` 0x92735c),
`uc_send_evt__mac_monitor` 0x927530 (0x925b84), `uc_send_evt__link_lost` 0x927690 (0x925c40),
`uc_send_evt__rs_started` 0x927764 (0x925cdc), `uc_send_evt__sta_update_field_rsp` 0x927810
(0x925d54), `uc_send_evt__ps_awake_peer` 0x92757c (0x925ba4), `uc_send_evt__get_rf_sector_done`
0x927664 (0x925c14), `uc_send_evt__set_rf_sector_done` 0x9277e4 (0x925cfc), `uc_send_evt_typed`
0x927928 (0x925da8; тип в аргументе, с TSF); только 6.2 — `uc_evt__send_24` (AoA),
`uc_evt__send_26` 0x9278a8 (INA), `uc_evt__send_25` 0x9279a0 (ответ на 0x34), `uc_evt__send_2b`
0x92783c / `uc_evt__send_23` 0x92787c, `uc_evt__send_20` 0x92785c / `uc_evt__send_21` 0x9278c8
(из `bf__reset_sta_slot`). Свободное место очереди — `mailbox__free_space` 0x92be30 (4.1 0x929004).

Остальные типы 0…0x30 ведут в `fw_sysassert_fatal`. Имена в скобках — ветка 6.2
не печатает `Ucode->`, имя взято по номеру 4.1. Воспроизведение:
`6.2/tools/uc_evt_table.py --fw-data blobs/kit-6200/seg_00900000.bin --strings
blobs/kit-6200/fw_strings.bin --blocks 6.2/src/asm/fw/blocks.json --insns
blobs/insns/INSNS-6200.txt`.

---

## Часть II. Механизмы, задаваемые телами команд

Режим OOB (`pf_mode_en`), `special_flags`, маска классов принятого кадра 0x801038 и
ролевой гейт развёртки, ответчик A-BFT, связь без ролей до `READY_FOR_ASSOC`, CONN_MSM,
распределители управляющих кадров, IBSS и BSSID — [ROLELESS-LINK.md](ROLELESS-LINK.md).
Тела команд, через которые эти механизмы задаются: 0x23 (§3.6), 0x21 (§3.7), 0x05
(§3.8), 0x14 и 0x09 (§3.9).

---

## 12. Глушение шума в логе прошивки **[железо]**

Уровни модулей — байты заголовка кольца лога: `u8 module_level_enable[16]` по
адресу база+4, база = значение `RGF_USER_USAGE_1` (0x843900, fw_peri). Модули
(порядок декодера `wil_fw_log.py`): 0 SYSTEM, 1 DRIVERS, 2 MAC_MON, 3 HOST_CMD,
4 PHY_MON, 5 INFRA, … Биты уровня: b0 err, b1 warn, b2 info, b3 verbose (штатно 7).
Кольцо ~320 записей.

    echo "0x90b904 0x07010707" > mem_write   # MAC_MON -> только ошибки
    echo "0x90b908 0x07070701" > mem_write   # PHY_MON -> только ошибки

---

## 13. Прежние имена функций

| адрес | прежнее имя | текущее имя |
|---|---|---|
| 0x93160c | `bi_mode__program_ifs_timing` (предлагалось `bi_mode__program_886d88`) | `mac_sxd__program_886d88_and_cmd_1e` |
| 0x931bd0 | `txrx_api_step_b` (предлагалось `mac__program_ifs_timing_from_cfg`) | `ifs_cfg__program_from_hw_cfg` |
| 0x8d8b9c | `lmac_if_send_cmd_0x15` | `lmac_if__send_lmac_personality` |
| 0x8d7efc | `lmac_if_send_cmd_0x23` | `lmac_if__send_abft_resp_ctrl` |
| 0x8d8550 | `lmac_if_send_cmd_0x00` | `lmac_if__send_init_cfg_cmd` |
| 0x8dbee8 | `tx_bcon__inject_evt4` | `lm_if__deliver_bf_results` |
| 0x8c22a8 | `conn__snapshot_bcon_ts` (предлагалось `lm_if__on_bf_results`) | `conn__on_bf_results` |
| 0x8ca1a8 | `maintain__get_conn` | `lm__get_mid_id` (возвращает mid_id) |
| 0x8ca1e8 / 0x8c9d8c | `conn__get_mid_id` / `conn__get_cid` | `lm_if__get_mid_id` / `lm_if__get_cid` |

Переименование проверяется обеими целями (`make rebuild` и `make fw`).

---

## Замечания

* 0x886d10: `ifs_cfg__program_from_hw_cfg` при инициализации пишет 0x100; живое
  значение (0x35d в 4.1) задаёт `rx_flow_step` по каждому принятому кадру (§3.1).
* Кольцевая команда MAC 0x1e и регистр 0x886d88 не связаны с таймингами IFS.
* Вендор называет 0x43 `pf_rx_sector_value` (RX), а `brp__apply_slot_mcs` кладёт его
  в слово, соответствующее TX-селектору записи соседа. Какая пометка верна — не
  установлено.
* Команда 0x15 в 6.2 по имени отправителя (`maintain_sm__set_rs_params`) похожа на «параметры
  RS»; тело и отправитель те же, что у 4.1 (`personality`/`failure_policy`).
* Обработчик команды 0x21 пишет четыре u32 (0x8019ec..0x8019f8), а не четыре u16
  по 0x8019ec..0x8019f2.
* Начало блока диспетчера событий — 0x8dae80 (`blocks.json`); адрес 0x8dae84 лежит
  внутри того же блока.

## Не установлено

* Смысл регистра 0x886d88 (`0x0c0a0f1e`) и значение 0x886d10 после инициализации.
* Смысл 0x886d10 доказан только формулой, не опытом.
* Вендорские имена регистров 0x886e08–0x886e1c (раскладка тела 0x00 6.2 по
  ним известна, §3.1) и точный смысл полей 150, 161, 123, 22, 18, 96, 106.
* Семантика пар 0x886d58/5c/60/de8/dec как `{clks, usec}`.
* Поля `fui_cmds_bf_sm_mgmt_s`, кроме `cid` (`wrong_sector_bis_threshold` и др.).
* Раскладка 16-байтовой шапки в 6.2 для событий; объект очереди событий ucode в 4.1.
* Отправители команд 6.2 0x26, 0x28/0x2a/0x2e/0x37/0x3c, 0x29/0x2b/0x2f/0x38/0x3d, 0x34.

## Источники

* `4.1/tools/lmac_cmd_map.py`, `4.1/tools/lmac_evt_map.py`, `6.2/tools/uc_cmd_table.py`,
  `6.2/tools/uc_evt_table.py`.
* `4.1/src/asm/fw/blocks.json`, `4.1/src/asm/uc/blocks.json`, `blobs/insns/INSNS-4100.txt`,
  `blobs/insns/INSNS-6200.txt`.
* `4.1/ref/SM-TABLES.txt`, `6.2/ref/REGS-62.md`.
* [MAC-COMMANDS.md](MAC-COMMANDS.md) — кольцо команд MAC (порт 0x886dc8, байт кода —
  индекс локального регистра записи `sxd_local_wr_data`; вендорской таблицы имён
  индексов записи в паке нет, есть только сторона чтения `MSXD_LR_RGF_R36..R56` и
  глобалы `g_msxd_*_shadow`/`g_msxd_cmd_buf`; адрес подтверждён вендорским
  host_manager_11ad, `PmcRegistersAccessor.cpp`).
* [MAC-REGISTERS.md](MAC-REGISTERS.md), [STATE-MACHINES.md](STATE-MACHINES.md),
  [VENDOR-ENUMS.md](VENDOR-ENUMS.md), [BF-ENGINE.md](BF-ENGINE.md), [WMI.md](WMI.md),
  [../4.1/docs/BEACON-CONFIG.md](../4.1/docs/BEACON-CONFIG.md),
  [../4.1/docs/DASHBOARD.md](../4.1/docs/DASHBOARD.md),
  [../6.2/docs/MISC-UC.md](../6.2/docs/MISC-UC.md).
* Пак 11ad: структуры `fui_*`, `special_mode_flags_s` и `pf_*` из `fw_image_globals.xml`.
