# Различия 4.1.0.1000 и 6.2.0.1000: что убрано и что добавлено

Функциональные различия двух версий прошивки Sparrow по fw_code и uc_code: что есть только в 4.1,
что появилось в 6.2, что сохранило номер команды при другом смысле и что переписано без изменения
функциональности. Доли общего кода и перенос имён — [CROSS-VERSION](CROSS-VERSION.md).

Уровни: **[код]** — по листингу, таблицам диспетчеров, строкам и графу вызовов; **[гипотеза]** —
не проверено. Адреса fw и ucode — линкерные; адреса данных ucode переводятся в адрес хоста
прибавлением 0x140000.

## 1. Назначение и метод

**Сопоставление блоков.** `tools/version_diff.py fw|uc [--list only41|only62|pairs]` ставит блоку
4.1 пару в 6.2 по признакам в порядке надёжности:

* `body` — тело совпало после нормализации адресов (корреляция из [CROSS-VERSION](CROSS-VERSION.md));
* `string` — общая лог-строка, которую в каждой версии печатает ровно один блок;
* `name` — одинаковое имя после нормализации;
* `graph` — у сопоставленной пары ровно по одному несопоставленному вызываемому (или вызывающему)
  блоку с каждой стороны, и они совместимы: общая лог-строка либо обе без строк при размерах в
  пределах 1,5× и косинусе гистограмм мнемоник ≥ 0,85; повторяется до неподвижной точки.

Результат прогона на текущем дереве:

| сегмент | блоков 4.1 / 6.2 | пар (body / string / name / graph) | без пары в 4.1 | без пары в 6.2 |
|---|---|---|---|---|
| fw | 2608 (211 800 Б) / 2597 (247 140 Б) | 1518 (550 / 620 / 199 / 149) | 1090 блоков, 54 160 Б | 1079 блоков, 84 140 Б |
| uc | 730 (98 500 Б) / 870 (126 148 Б) | 325 (160 / 20 / 92 / 53) | 405 блоков, 45 732 Б | 545 блоков, 73 220 Б |

**«Без пары» ≠ «удалено».** Блок остаётся без пары по трём причинам: функциональность действительно
убрана или добавлена; код переписан (функция разрезана, слита, встроена); сопоставитель не связал
два имени одного и того же. Вывод «убрано» или «добавлено» принимается только после проверки
отсутствия эквивалента в другой версии:

* по лог-строкам — с нормализацией (без `[NNL]`/`[PHY_LOG]`, пробелов, пунктуации) и нечётким
  сравнением;
* по ссылкам на строку из кода — адрес строки ищется во всех сегментах образа в двух кодировках
  (32-битное слово и ARC-limm из двух полуслов);
* по именам (`4.1|6.2/src/asm/{fw,uc}/blocks.json`), регистрам, глобалам и константам;
* по таблицам диспетчеров WMI, UT, LMAC и событий ucode и по таблицам автоматов
  (`4.1|6.2/ref/SM-TABLES*.txt`).

**Мёртвые строки.** Текст строки есть в блоке строк сборки, ссылок на него из кода нет. В fw 6.2 таких
строк 170 из 2 595, в fw 4.1 — 115 из 2 299. Мёртвая строка не доказывает наличие кода: печатающий
её код в образе отсутствует.

Размеры групп в разделах 3–9 подсчитаны на промежуточном прогоне с менее строгим графовым признаком
(fw: 914 и 903 блока без пары). Классификация проверялась вручную по признакам выше и от строгости
графового признака не зависит.

## 2. Сводка

**Убрано из 4.1**

1. Программная плавающая арифметика ucode (softfloat, 8 блоков, 3,3 КБ) вместе с генератором таблиц
   расписания BI: в 6.2 таблицы — константы uc_data **[код]**.
2. Неглубокий сон (shallow sleep) и пробуждение PCIe из ucode (~1,8 КБ): события ucode→fw 0x15
   PS_SHALLOW_SLEEP_NTF и 0x19 PS_WAKE_PCIE в 6.2 не отправляются, обработчики в fw остались **[код]**.
3. Аппаратная маска «бодрствующих пиров» (0x886f84/0x886f88/0x88c050) и допуск к передаче по
   PM-состоянию пира (`get_tx_eligibility`) **[код]**.
4. UT_HW_FLOWS: BER-тесты цифровой и ПЧ-петли PHY, производственный петлевой тест, отдельные шаги
   калибровки, чтение массива РЧ-цепочек сектора; UT SYSAPI 0x48 `config_short_vec` **[код]**.
5. WMI 0x859 `WMI_BRP_RF_CHAINS_LIMIT` (роль выполняет новая 0x924 `WMI_BRP_SET_ANT_LIMIT`) и
   синхронизация даты хоста по WMI 0x863 **[код]**.
6. `WBE_DRIVER__link_down` (сброс PERST док-станции из ассерта) **[код]**.
7. Имя файла в ассерте и обширная печать: отчёт MAC_MON, часть `LINK_STATS` и дампа PHY, лог каждой
   команды LMAC, строки `Ucode->` для шести событий **[код]**. Всего в fw реально вырезано около
   2,7 КБ функционального кода (19 блоков).

**Добавлено в 6.2**

1. ToF/FTM/AoA: 9 команд WMI, два автомата fw, LMAC 0x2c/0x2d/0x31, события ucode 0x22/0x24 **[код]**.
2. Фиксированное расписание (TDMA): WMI 0xa02/0xa03/0x85f/0xa0e/0xa0f, автоматы L1 ucode, LMAC
   0x3e/0x49/0x4a, событие 0x30 ([FIXED-SCHED](../6.2/docs/FIXED-SCHED.md)) **[код]**.
3. Управление станциями с хоста (NEW_STA/DEL_STA, splitmac): 5 новых событий `MLME_SM` **[код]**.
4. Управление BF с хоста: `WMI_BF_CONTROL`, `WMI_BF_TRIG`, приоритетные TX-сектора, порядок и число
   секторов TXSS (LMAC 0x35/0x36) **[код]**.
5. Несколько РЧ-модулей: разбор omni-секторов и RF-наборов из board-файла, выбор активного модуля,
   BRP по RF-модулям, auto-fill секторов, глубокое выключение всех RF **[код]**.
6. UT SYSAPI (~20 подтипов вместо 2) и канал событий SYSAPI; UT-драйверы +30 кодов; программирование
   XPM РЧ-модуля **[код]**.
7. В ucode: QH и очереди MAC, отключение vring, внутренние TX-потоки 4 и 6, DTI-аллокации с
   событием 0x29, сторож L2, триггеры записи PMC, диагностика исключений **[код]**.
8. Ответ `WMI_COMMAND_NOT_SUPPORTED` (0xffff) на неизвестную UT-подкоманду **[код]**.

**Изменено при сохранении номера**

1. WMI 0x803 `WMI_ECHO` отвечает с интервалом маяка; станция 6.2 берёт из него период BI **[код]**.
2. WMI 0x863 `WMI_NOTIFY_REQ`: синхронизация даты хоста → статистика станции **[код]**.
3. WMI 0x856/0x857: в 4.1 «OTP» — это XPM-память единственного РЧ-модуля (`otp__read_bytes` → `xpm_read_cnt`), в 6.2 — та же XPM с выбором модуля (`rf_id`) и битовым адресом; меняется раскладка тела команды **[код]**.
4. WMI 0xa01 (ESE): в 6.2 появился ответ 0x1a01; разбор ESE переписан **[код]**.
5. Ассерт: `fw_sysassert_fatal(blink, код)` с номером строки исходника вместо имени файла **[код]**.
6. Формат записи лога fw: слово TSF за заголовком, модуля и уровня в заголовке нет **[код]**.
7. 11 команд LMAC с тем же номером имеют другое тело (0x07, 0x0f, 0x11, 0x14, 0x16, 0x19, 0x21 и др.) **[код]**.
8. Неизвестная UT-подкоманда: 4.1 — `fw_sysassert_fatal`, 6.2 — `WMI_COMMAND_NOT_SUPPORTED` **[код]**.

## 3. Убрано из 4.1 (функциональность)

### 3.1. fw

| что | признаки 4.1 | состояние в 6.2 | уровень |
|---|---|---|---|
| UT: цифровая и ПЧ-петля BER | `hwf_PHY_DIG_LOOPBACK_BER_TEST` 0x8d4124 (224 Б), `hwf_PHY_IF_LOOPBACK_BER_TEST` 0x8d4204 (300), `phy_ber__enable_dig_loopback`, `phy_ber__read_counters`, `ber_test__read_lane_counters`; строки `UT_HW_FLOWS_SUBTYPE_{DIG,IF}_LOOPBACK_BER_TEST`, `hwf_PHY_*_LOOPBACK_BER_TEST START/END` | строк нет (и мёртвых тоже), вызовов из `UT_HW_FLOWS_OPERATIONAL_cmd_handler` нет; `ber_test__measure` остался только в калибровке (`calib_lo_leakage__sweep`) | [код] |
| UT: производственный петлевой тест | `hwf_phy_production_loopback_test` 0x8d4330 (644), строки `PRODUCTION FLOWS:: IF_LOOPBACK_TEST took`, `hwf_phy_production_loopback_test: …` | нет | [код] |
| UT: отдельные шаги калибровки | строки `reached UT_HW_FLOWS_SUBTYPE_CALIB_{VGA_DC_ALG_FINE, VGA_DC_ALG_LAST_STAGE_ONLY, BB_GAIN_ALG, IF_GAIN_ENTRY, IF_GAIN_EXIT, IF_GAIN_ALG, GAIN_CONVERGE_LOOP}`; блоки `calib_mngr_step_b` (156), `ut_hw_flows_cmd_0x404/0x407/0x408` (80/40/164), `power_mngr_on_unassoc_start` 0x8d3228 (84) | обработчик HW_FLOWS зовёт только `hwf_calib_all` и `hwf_calib_lo_power_flow` (новый вход `CALIB_LO_POWER_FLOW`); функции `hwf_calib_bb_gain_alg`, `hwf_calib_sar_alg` есть в обеих; калибровка целиком сохранена | [код] |
| UT: чтение массива РЧ-цепочек сектора | `hwf_sector_rf_chains_array_get` (192), строка `SECTOR_RF_CHAINS_ARRAY_GET completed` | нет; остались `hwf_sector_rf_chain_get/set` | [код] |
| UT SYSAPI 0x48 `config_short_vec` и смещение усиления по региону | `hw_sysapi_config_short_vec` (64) → `regulatory_domain_set_tx_gain_offset` (60) | подтип 0x48 → «не поддерживается»; строк нет. Низкое усиление печатает `hwd_rfc_tx_power_cfg` из `power_mngr__check_mode` | UT-путь [код]; перенос настройки [гипотеза] |
| `WBE_DRIVER::link_down` | `WBE_DRIVER__link_down` 0x8ed8d8 (352, зовётся из `fw_sysassert_fatal`), `WBE_DRIVER__Force` (136), `WBE_DRIVER__HOST` (64) | строки `link_down DOCK PERST is 1!!`, `Force Perst` мёртвые; `fw_sysassert_fatal` 6.2 `link_down` не зовёт | [код] |
| WMI 0x859 `WMI_BRP_RF_CHAINS_LIMIT` | ветка 0x8da8f0 → `wmi_handler_brp_rf_chains_limit` (12 Б): `[0x857050] = arg`; ucode `brp__reset_db` читает `[0x857050] & 0x3f` | ветки и строки нет. Ограничение антенн BRP задаёт 0x924 `WMI_BRP_SET_ANT_LIMIT` → LMAC 0x32. Ячейка 0x857050 в 6.2 занята другим: маска CID с данными в очереди — ставит `ps__mark_data_pending` @0x8c2ab6, снимает `FWQ_TX_AVAILABILITY__remove_packet` @0x8e26d6, читает ucode `aw_worker__collect_awake_peers` @0x927b56; вернуть 0x859 записью в неё нельзя. Смысл 4.1 по коду: 6 бит — длина списка лучших секторов BRP (граница цикла в `brp__count_active_sectors`, `brp__sum_sector_counts`; по умолчанию 10 из `l2mgr__init_operational_if`). В 6.2 то же поле (биты 15..20 дескриптора BRP 0x800824, читает `brp__pick_sector_cfg`) никто не пишет — константа 10 из образа; 0x924 задаёт поверх него лимит по станции (0x800678+cid). В 6.4 0x859 возвращена: запись таблицы диспетчера → ветка в зазоре, ячейка 0x803a48, вставка в `brp_init__reset_ctx` **[железо]** | [код] |
| синхронизация даты хоста | WMI 0x863 → `host_if__timestamp_sync`: печать `HOST TIMESTAMP SYNC %02d/%02d/%04d`, таймер синхронизации, `fill_statistics_to_host`, событие 0x1863 | строки нет; команда отдаёт статистику станции (раздел 6) | [код] |
| ограничение канала 4 (64,8 ГГц) | `wmi_handler_set_pcp_channel` и `validate_connect`: индекс 3 → `FW_CHANNEL_4_64800MHZ is not supported`, без записи | `wmi_set_pcp_channel` принимает индекс 3 — ограничение снято | [код] |
| РЧ «Falcon» | `Identify RF Type : Falcon`, `FALCON COMM TEST FAILED`; `BASEBAND Type is not defined` | `Sparrow-R`, `SPARROW-R COMM TEST`; `BASEBAND_UNKNOWN`, добавлены D0/C0 | [код] (строки) |
| `radio_manager::lock_primary/lock_secondary` | строки второго радио (`lock_secondary` — 2 строки) | строк нет; класс `RADIO_MGR` — 2 экземпляра (0x8038e0, 0x803b18) | [код] (строки) |

### 3.2. ucode

| что | признаки 4.1 | состояние в 6.2 | уровень |
|---|---|---|---|
| softfloat | `softfloat_df_add` 0x920974 (1888 Б), `df_mul` 0x9204ac (1204), `df_sub`, `negate_r3`, `int/u32_to_double`, `double_to_short(_b)`; вызываются только из `bi_build_schedule_tables` 0x927f00 и `abft_responder__tx_ssw` (@0x92cc84: `(double)r16 − 15.9` → short) | блоков нет; в `abft_responder__tx_ssw` @0x930bb8 — `sub r15,r15,0x10` (целое 16) | [код] |
| генератор таблиц расписания BI | `bi_build_schedule_tables` 0x927f00 (408 Б): 12 итераций, три таблицы u16 с 0x802030/0x802048/0x802060 (шаг второй 0x99b+0xa5 = 0xa40 = 2624 такта), команды GP 0x54, 0x54, 0x49000100, 0x51000284, 0x54000508 | таблицы — константы uc_data 0x80164c / 0x801664 / 0x80167c (по 12 × u16). Первые две равны значениям формулы 4.1 (0x4f…0xfe; 0x329b…0xa35b), третья больше ровно на 3300 тактов (граница слота A-BFT на 20 мкс позже стандартной, см. [STANDARD-MAPPING](STANDARD-MAPPING.md#длительность-слота-a-bft-таблицы-по-fss-код)) (20 мкс при 165 МГц). Команды GP перенесены в `bti__reset_sweep_state` 0x92ad3c; `bf_gpc__program_mac_by_mode_b` читает 0x801674+2·i вместо 0x802058+2·i | [код]; значения — расчёт по константам листинга и дамп uc_data |
| shallow sleep | `perform_shallow_sleep` 0x92af4c (592, строки ENTER/EXIT), `power_manager__decide_shallow_sleep` 0x92ad98 (436), `perform_bti_pm_cfg` 0x92ac60 (312, «force wakeup»), `shallow_sleep_step` 0x937304 (из LMAC 0x05), `shallow_sleep_rfc_step` 0x9219c8, `uc_send_evt__ps_shallow_sleep_ntf` 0x925d28 (событие 0x15) | строк `shallow` нет; `ucode_cmd_0x05_handler` 0x93abf4 шаг сна не зовёт; `bi__dti_step` 0x935d5c зовёт только `pm__wake_sequence` и `sxd_hal__write_qset_field` (в 4.1 `bi_dti__wake_and_evaluate_sleep` зовёт ещё решение о сне и уведомление пиров); `mac__cmd_0f_step` 0x92e438 на месте `perform_bti_pm_cfg` зовёт только `aw__set_new_tbtt`; событие 0x15 не шлёт ни один блок | [код] |
| пробуждение PCIe | `power_manager__maybe_wake_pcie` 0x926934 → `uc_send_evt__ps_wake_pcie` 0x925d80 (событие 0x19) | отправителя 0x19 нет; обработчик fw `ps_wake_pcie_evt` остался | [код] |
| маска бодрствующих пиров в железе | `ps__notify_awake_peers` 0x930098, `ps__program_awake_peers_mask` 0x92fff0 → `set_reg_886f84_x3` (0x886f84, 0x886f88, 0x88c050), `ps_awake_peer__build_evt` 0x92feec, `__send_full`, `__send_clear_peer` | литералов 0x88c050 и [0x887000−0x7c] нет; событие 0x16 шлют только `dti_worker__scheduled_dti_allocation_event` и `tx_ctx__post_status` | регистровая часть [код]; событие переписано |
| допуск к передаче по PM-состоянию пира | `get_tx_eligibility` 0x92616c (372, «Denide BF go to next internal», «no eligibility in Internal Queue»), `__precheck` 0x9264f0 (флаг 0x8009e8), `tx__take_eligibility_slot` 0x926354; проверка «Abort Tx to shallow sleep STA» | строк нет; `tx_slot__dispatch` 0x938e34 (аналог `tx_initiator_flow`) precheck не зовёт ([DATAPATH §8](DATAPATH.md#8-соответствие-41--62-микрокод)) | [код + строки] |
| PSC pending agreement (LMAC 0x22) | `psc_pending_agreement_cmd` 0x92b308 (220, лог `sleep_cycle / bi_start_time`) | `ucode_cmd_0x22_handler` 0x92e840 (104): запись {байт, 2 слова} в 0x802f80+0x2c (общая) или 0x802f80+0xa8+16·idx (idx < 8), без лога | урезано [код] |

## 4. Убрана только печать и диагностика (функциональность осталась)

| что | 4.1 | 6.2 | уровень |
|---|---|---|---|
| отчёт MAC_MON (окна BTI/AW/DTI) | `lmac_if__mac_monitor_report` 0x8d865c (348): `[BTI]/[AW ]/[DTI] start time`, `bcon bitmap`, ATIM, RTS/CTS/DTS, NAV, KA, `rx off duration` | событие ucode 0x17 обрабатывает `lmac_if__update_pct_stats` 0x8db9c0 (224): без печати, 64-битное деление, счётчики RX/TX MAC. Оба зовут рассылку sys_state 0x16 (`tail_L2MGR__system_state_evt_handler` / `sys_state__broadcast_16`) и поиск по LUT | [код] |
| сводка `LINK_STATS` | `link_stats__report`: `PPDU_REP_CNT`, `CCA2_TO_CCA3`, `HANDLED_PPDUS`, `FA_IN/OUT_TXOP_*`, `### LINK STATS:Neighbor Beacon/NAV/Keep Alive/receive RTS`; `link_stats__phy_counters`: `PHY_INA_SYNC`, `PHY_SFD_SYNC` | остались `CID:%u MCS0_FRAMES_CRC_*`, `TX/RX_GOODPUT/PER`, `PHY_ERROR_*`; новое `per … request bf` | [код] |
| дамп PHY | `phy_monitor__task_step`: `[PHY_LOG] curr_tm/tsf INA_SYNC`, `SFD_TIMEOUT`, `SFD_SYNC`, `HEADER_CRC_OK`, `BER_LAST_ZERO`, `false_alarms.*`, температуры, индексы silent RSSI | `phy_stats__dump`: `HEADER_CRC_ERROR`, `BER_LAST_NON_ZERO`, `SIGNAL_GAIN`, `INA_RSSI`, новые AGC omni/direct и `rf_rx/tx_gain_idx[%d]`; ложные тревоги печатает `link_lost_diag__dump_false_alarms` | [код] |
| лог команд LMAC | `send_cmd2_lmac: type 0x%x, curr tsf` | строки нет; протокол тот же | [код] |
| имена событий ucode | `Ucode->RX_ON_RSP/RX_OFF_RSP/BF_DONE_EVT/RS_DONE_EVT/PS_AWAKE_PEER_EVT/MAC_MONITOR_EVT` (19 имён всего) | 24 имени, этих шести нет; ветви 0x01, 0x03, 0x06, 0x14, 0x16, 0x17 обрабатываются без печати ([LMAC-PROTOCOL §5.3](LMAC-PROTOCOL.md#53-события-62)) | [код] |
| имя файла в ассерте | `fw_sysassert_fatal` 0x8c82c0: r1 — строка, r2 — имя файла; `Assert in file: %s`, `line: %d`; 724 вызова; 155 строк `*.cpp/*.c/*.h` (40 — полные пути сборочной машины) | `fw_sysassert_fatal` 0x8c9b28 (blink, код); `Crash TSF … assert 0x%04x`; код пишется в 0x85700c; 761 вызов; строк имён файлов 0 | [код] |
| отладочная печать fw | `awake_peers__log` (108, `[DBG AWAKE PEERS]`), `BIND::` в `sm_pring__bind_vring` (4 строки), `Temperatures: BaseBand=… RF=…` в `radio_locked_cb`, `radio_manager::lock_*() (m_allocated …)`, `fwq_tx::send_next`, `HOST CMD 0x%08X for MIDID`, `Temperature measurement command`, `WMI_RS_CFG_DONE_EVENTID`, `data0 is`, `xpm_read_cnt FAILED` | строк нет или они мёртвые (`[DBG AWAKE PEERS]`, `t_rf[%d]`); функции (`sm_pring__bind_vring` и др.) есть | [код] |
| печать температуры | `l2mgr__send_temp_sense_done` печатает BB/RF в милли-°C | `wmi__post_temp_sense_done` без печати | [код] |
| строки классов | `ies_block::merge`, `vr_obj::update_connected_duration`, `ps_nonassoc_mgr::ps_evt_handler`, `L2MGR::system_state_evt_handler`, `calib_engine_sm::check_correction_needed` (по одной) | строк нет; автоматы PS_NONASSOC и CALIB_ENGINE есть | [код] (строки) |
| трассировка автоматов | `basic_sm__inject_event`: `Inject %s event to %s. Next state: %s` | `basic_sm__do_transition`: `%s evt:%s state:%s` | [код] |
| рандомизатор и NAV-отсрочка маяка (ucode) | `bti_worker__bti_transmitter_beacon_sweep_flow` 0x923de0: `randomize beacon`; `Beacons delay due to NAV started`; `nav_db__update` 0x92a6f4 (560, `Received bigger NAV`, `MAC Address ADD0…`) | та же функция 0x923cb4: `mulu64 r0,0xbd` (+76), MAC 0x30 (`or r9,r14,0x30000000`), гейт по 0x8022a8; строка `uniform_random` сохранена. Порог `cmp r0,0x7530` в развёртке; `rx_nav__set_from_duration` 0x92dd30 (348, та же проверка `cmp_s r2,0xe`), `rx_nav__arm_flag_if_enabled`, `bi__remaining_time_us` — без логов ([BEACONING §4](BEACONING.md#4-рандомизатор-отсрочки-маяка-обе)) | [код] |
| автомат BI (ucode) | `BI_AP_MONITOR_SM: AW/DTI EVENT` | строк нет; автомат `bi_sm` (раздел 6) | [код] |
| TSF пробуждения (ucode) | `calc_awake_tsf` 0x924434, лог `calc_awake_tsf: %x` | `sched__calc_next_start_tsf` 0x924768 на том же месте (зовёт `aw__set_new_tbtt`), без лога | [код, граф] |
| диспетчер команд ucode | строка `umac_if_cmd_handler FW command 0x%x` | `ucode_cmd_dispatch` без строки | [код] |
| TX-инициатор CBAP (ucode) | `Backoff expired without Q availability` | строки нет; «Check for busy2», «Starting internal TX», «tx_bcast_flow» перешли в `tx_initiator_flow_fixed_scheduling` | [код + строки] |

## 5. Добавлено в 6.2

### 5.1. fw

Около 300 блоков (≈31,5 КБ) из блоков 6.2 без пары несут новую функциональность; ещё 8,9 КБ —
нулевая область перед 0x8f0000 (раздел 8), остальное — переписанный код (раздел 9).

| что | признаки 6.2 | состояние в 4.1 | уровень |
|---|---|---|---|
| ToF/FTM (инициатор и ответчик) | `tof_mgr` 0x8c382c (синглтон 0x806518), `ftm__responder_rx_req` 0x8cb3bc, `ftm__send_ucode_session_cfg` 0x8db81c, `frame__build_ftm_request` 0x8f5040, `tx_mgmt_ftm_req`; автоматы `state_sm_803424` (сеанс FTM, 3×9) и `state_sm_8034c0` (`ftm_main_sm`, 5×8), 20 действий; `l2_mgr__tof_ftm_req/get_capabilities/config_responder`, `wmi_tof_set/get_tx_rx_offset`; WMI 0x991–0x998; LMAC 0x07, 0x2c, 0x2d; 64 блока, 5,5 КБ ([HW-DRIVERS §10](HW-DRIVERS.md#10-измерение-расстояния-и-угла-tofftmaoa-62)) | строк TOF/FTM нет (0 против 55/44) | [код] |
| AoA | `wmi_aoa_meas` 0x8e9580 (WMI 0x923), `aoa__validate_request` 0x8e9680, `tof_mgr__aoa_session_start` 0x8c3930 → LMAC 0x31, `lmac_if_aoa_meas_evt_handler` 0x8db1b0 (событие ucode 0x24) | нет | [код] |
| фиксированное расписание | `wmi_fixed_scheduling_config` 0x8ec56c, `wmi_fixed_scheduling_ul_config`, `wmi_enable_fixed_scheduling` 0x8ec500, `fixed_sched__start` 0x8c9884 (→ LMAC 0x3e), `wmi_fixed_sched__apply`, `sched__init_default_alloc_table` 0x8ca388, `wmi_set_grant_mcs` (0x49), `wmi_set_ap_slot_size` (0x4a), `evt_fixed_scheduling_enabled` (событие 0x30), `vring__set_pair_mode`, `vring__reset_pair*`; 17 блоков, 1,4 КБ | нет | [код] |
| станции с хоста, splitmac | `l2_mgr__wmi_cmd_handler_new_sta` 0x8ec2b8, `…_del_sta` 0x8ec184 (WMI 0x935/0x936), `wmi_get_assoc_list` (0xa06), `handle_packet_splitmac` 0x8f3ba4, действия `mlme_sm` 0x8c7de0/0x8c7e88/0x8ec00c/0x8fb430/0x8f20bc, `mlme__ctrl_new_sta_timeout_cb`; строки `EVT_CTRL_NEW_STA`, `EVT_CTRL_DEL_STA`, `EVT_WAITFOR_CTRL_*`, `split_mac_en`; `mgmt_tx__build_assoc_resp` 0x8d8230 вызывается из splitmac; 14 блоков, 1,8 КБ | `MLME_SM` 3×9 | [код] |
| скан при подключении через PS | автомат `state_sm_8030e0` (`swc_psc_sm`, 3×4, ждёт начала SOB), 5 действий `swc_psc_sm__*`, `scan_mngr__sob_awake_bi_ntf`, `scan_mngr__kick_scan_state_machine`, `scan_mngr__update_connected_scan_time`; строки `STATE_WAIT_SOB_START`, `EVT_SOB_STARTED`; 10 блоков | только «Scan while connect. Ignoring beacon» | [код] |
| multi-directed omni | `l2_mgr__connect_multi_omni` 0x8c71fc, `…_cb`, `l2_mgr__connect_next`, `wmi_set_multi_directed_omnis_config_cmd` (0xa04), `scan_mngr__dwelling_done` 0x8f2b88 («rescan for omni»); строки `probe_resp_ind() directed omni`, `found better omni`; 5 блоков | строк с «omni» нет | [код] |
| BF и сектора с хоста | `wmi_bf_control` 0x8ec068 (0x9aa → LMAC 0x10/0x14), `wmi_trigger_beamforming_cmdid` 0x8fc11c (0x83a), `wmi_brp_set_ant_limit` + `ant_limit__validate` (0x924 → LMAC 0x32), `wmi_prio_tx_sectors_*` (0x9a5–0x9a7), `lmac_if_set_ss_sectors_order/number/default_cfg_handler` (LMAC 0x35/0x36), `sector_list__validate`, `wmi_set_rf_sector_on_cmd_handler` (0x9a4, только WMI_ONLY_FW); `lmac_if_config_txss` 0x8db60c проверяет список секторов; 14 блоков, 1,5 КБ | нет | [код] |
| CCA-индикации | `wmi_set_cca_indications_bi_avg_num` 0x8fbbe8 (0xa08), 0xa07 → `wmi__post_pct_stats_evt` 0x8fb598 | нет | [код] |
| UPM | `lmac_if_upm_cfg_handler` (WMI 0x960 → LMAC 0x33: `upm_enable`, `no_traffic_timeout`), событие ucode 0x25 | нет | [код] |
| прочие WMI | `wmi_get_rf_status` 0x8dd3c8 (0x866) + `rf__get_module_info`; `wmi_get_baseband_type` (0x867; 6.2 знает B0/C0/D0, 4.1 — A0/A1/B0); `wmi_get_detailed_rs_res` (0x922); `wmi_rf_pwr_on_delay` (0x85d); `wmi_set_high_power_table_params` (0x85e) + `rf_cfg__load_800d04`; `wmi_set_active_silent_rssi_table` (0x85c) + `calib__start_scheme4`; `wmi_evt__send_command_not_supported` | нет | [код] |
| WMI 0xfff | `orig_fract` 0x8dc4d8: читает дробь синтезатора канала 1 (0x889424) и в цикле с задержкой пишет в дробь канала 2 (0x88942c) `orig_fract + i·шаг`; строки «0xfff: addr/val/mask», «iter» — отладочная качалка частоты | нет | [код] |
| UT SYSAPI | `UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler` 1044 Б, таблица 0x803600 на 0x1–0x49: `fw_sysapi_mgr__*` (energy, plcp, phy_rx, ampdu, flush, rssi/snr, оценка канала), `hw_sysapi_*` (RFC read/write RGF, RX omni-сектор, FREQ_RATIO, статистика BF, energy free-run), `get_rx_pkt_phy_data_*`, `stats__*`, `mac_tx_cnt__*`/`mac_rx_cnt__*`, `hwd_phy_rx_read_and_parse_brp_ram`; канал событий `fw_sysapi_mgr__send_evt2host`; события ucode 0x20/0x21/0x23/0x26/0x2b/0x2f; 66 блоков, 6,2 КБ ([MISC-FW §1](../6.2/docs/MISC-FW.md#1-отладочные-команды-ut-hw_sysapi)) | 116 Б, подтипы 0x6 и 0x48; строк `sysapi` 4 | расширено [код] |
| UT-драйверы: 30 новых кодов | 0x146, 0x156–0x159, 0x160–0x164, 0x170, 0x171, 0x305, 0x42c–0x42e, 0x438, 0x514–0x51e, 0x610, 0x611 ([UT-DRIVERS](../6.2/docs/UT-DRIVERS.md)); 27 блоков, 3 КБ | 146 кодов | [код] |
| XPM РЧ-модуля | `host_if__read/write_rf_xpm_handler`, `hwf_rf_xpm_program_byte` (попытки, верификация), `hwf_rf_xpm_cfg_get/set`, `hwf_rf_xpm_enter_cfg_mode`, `xpm__*`, `hwd_rfc_xpm_get_write_status`; UT-подтипы `RF_XPM_ENTER_CFG_MODE`, `CFG_GET/SET`, `PROGRAM_BIT/BYTE/BLOCK`, `READ_BYTE/BLOCK`; 18 блоков, 1,6 КБ | `hwf_rf_xpm_read_byte/block`, OTP-запись | расширено [код] |
| несколько РЧ-модулей | `handle_omni_sector_info` 0x8cd940 («MASSIVE or SINGLE», «RX sectors info in brd file», diversity/topology), `handle_rf_sets_info` 0x8ed5ec, `update_rf_xx_gains_tables` 0x8ed9cc, `hwm_analog_select_active_rf_module` 0x8d7584, `rf__get_active_mask/index`, `rf__get_connected_mask`, `temp__get_rf_by_index`; строки `init_rf_hw: g_rfc_connected_indx_vec`, `MARLON-R rfc_idx=%d TEMP` | только `rf_modules_vec` в командах РЧ-секторов | [код] (строки) |
| калибровка silent RSSI и baseband gain | `calibrate_baseband_gain` 0x8c5708, `calib_silent_rssi_sparrow__find_rf_gain` 0x8ca8fc, `…__run_calibration_fragment`, `…__set_agc_start_val`, `silent_rssi__calibrate_single_rf_module`, `silent_rssi__hist_window_index`, `calib__classify_by_thresholds`, `calib_silent_rssi__ctor`; объект 0x80220c | одномодульная `calib_silent_rssi_sparrow` («SR silent RSSI calib», «did not converge») | расширено [код] (строки) |
| калибровка чтения RFC (rdac) | `hwd_rfc_read_calibrate` 0x8f3f7c (UT 0x51e), `rfc_read_calib_get_min_failures`, `get_min_failures_mid_biggest_range_index`, `hwd_rfc_read_handle_driver_input` («Driver set rdac val»), `hwd_rfc_read_get_result` (из `wmi_evt__notify_fw_ready`) | строк «rdac» нет | [код] |
| глубокое выключение и восстановление RF | `hwd_rfc_powerup_deep_all_rfs_fw` 0x8d34c0, `hwd_rfc_powerdown_deep_all_rfs_fw`, `rf__restore_if_needed` («Restore RF was needed»), `hwm_analog__prepare_buf` («RESET RF!!!»), `rf_power_off`; строка `deep_sleep_exit: Common RF load time` | `deep_sleep_exit/enter`, `pcie_pm_host_config` есть в обеих | [код] |
| auto-fill РЧ-секторов | `rf_utils_auto_fill` 0x8e3060, `rf_utils_auto_fill_set_pattern`, `rf_utils__fill_default_patterns`, строка `hwd_rfc_auto_fill_verify` | нет | [код] (строки) |
| отслеживание версии возможностей (VS IE) | `parse_wilocity_vs_get_features_version_tracking`, `discovery__init_probe_entry`, строка `SET_DEST_STA_FEATURES_VERSION_TRACKING` | разбор VS: test_mode, network_mode, version | [код] (строки) |
| разрыв при сбросе TSF у AP | `bad_beacons__on_bi_evt` 0x8cd880: сравнение TSF и начала BTI, «AP RESET -> TFS RESET -> DISCONNECT», затем `bad_beacons_detector__handle_bcons_info` | детектор есть, этой проверки нет | [код] |
| отладочные дампы | строки `MAC_MAC_RGF_MTP_DBG_FSM_*` (12), `HWD MAC: MTP HW SM`, `dump_rfc`, `hwf_cpr_flow_internal` (CPR) | нет (`Crash TSF` есть в обеих) | [код] (строки); блоки-владельцы не установлены |
| строки второго ряда | `host_if` (XPM), `vring_schd_ucode`, `lmac_if_link_lost_evt_handler`, `stream_mgr` (9 строк против 2; объект 0x802424) | нет или меньше | [код] (строки) |

### 5.2. ucode

| что | признаки 6.2 | состояние в 4.1 | уровень |
|---|---|---|---|
| фиксированное расписание | `l1_fixed_sched_ap_sm` 0x92c66c, `_sta_sm` 0x92c840 («unexpected event»), `l1_task__main_step` 0x92caf4 (`L1_FIXED_SCHED_TASK PRE TBTT`), `l1_fixed_sched__event_entry`, `l1__enter_fixed_sched`, `l1_fixed_sched_ap__ev4_state2/4`, `tx_initiator_flow_fixed_scheduling` 0x938f10, `tx_non_data_flow_fixed_scheduling`, `fixed_sched_manager__decrement_curr_sta_rd_counter`, `fsched_*`; конфигурация через 0x857744; LMAC 0x3e, 0x49, 0x4a; событие 0x30 (`uc_evt__send_30`); ~50 блоков, 4,9 КБ | строк `fixed_sched` нет ни в fw, ни в uc; предел команд 0x41 | [код] |
| TX через слоты | `fixed_sched__run_tx_slot` → `tx_slot__dispatch` (CBAP и расписание разведены по `[gp,-0x34]`), `mtp__get_tx_permission` 0x93e8c4 (RD-счётчик, `fsched_slot__f3_positive`) | в DTI только CBAP (`bi_tx_initiator_wrap` → `tx_initiator_flow`) | [код] |
| QH и очереди MAC | `fwif_write_qh` 0x9279c8 (LMAC 0x45, `fwif_write_qh qid`), `qh__write_by_flags`, `qh__pack_descriptor`, `qh__read/write_desc_window` (окно 0x886608/0x886800), `qh_write_while_dma_open_check` («QH Write while DMA is open»), `macq__kick_queue_tx`, `macq__flush_queue`, `macq__is_idle`, `macq_hw__*`; ~5,4 КБ вместе с vring | QH пишет fw; одна обёртка `mid_vring_mask_update` | [код + строки] |
| отключение vring | `vring__disconnect_flush` 0x925c8c (1040: «Flush VRing», «Vring disconnect flow timeout», «PTP was reset», «PTP stuck»), `dma_is_tx_pipe_idle`, `dump_vring_pring_info`, `dump_pring_hw`, `dump_mac_buffer_bases` | строки `VRING/PRING` в таблице uc 4.1 есть, но мёртвые | [код + строки] |
| BRP по RF-модулям | `config_brp_rf` 0x925050 (1608, «HH config_brp_rf rf_id», «Overriding rfmodule phase»), `brp__select_cfg_by_snr`, `brp_rf__store_cfg`, `brp__iterate_rf_mask`, `rf__write_sector_awv`, `rfca__select_rf_uc` (0x889488 б8..15; регистры 0x889480/0x889488 — 34 и 14 обращений), `rf_utils_auto_fill_uc` (580), `hwd_rfc_auto_fill_verify`, `brp_restore_sectors`, `brp_update_omni_sector_idx`, `brp_initiator_flow_successful_receive_training`, «failure 1…5» | BRP есть (`brp__flow_main`); литералов 0x889480/0x889488 нет | BRP переписан, RF-модули добавлены [код] |
| захват запросов BF с отчётом | `bf_req__enqueue/__dequeue_head/__try_claim/__claim_and_report_23/__claim_and_report_2b`, `bf_sm__process_request_fifo` (600, `bf_sm_handler in state`, `p_brp_cfg_info is NULL`), `bf_init_sm`; `handle_bf_triggers` (`cid set triggers`, бит 6 байта причин) | FIFO есть (`bf_sm__pop_request_fifo`, `bf_sm__process_request_fifo` 264 Б), `bf__trigger_if_pending` без лога | переписано, добавлены события 0x23/0x2b и логи [код] |
| порядок и число секторов TXSS с хоста | `sls__rx_ssw_frame`, `sls__send_ssw_ack`, `sls__build_ssw_ack`, `txss_init__*`, `txss_resp__*`, `txss__store_sector_ranking`; LMAC 0x35/0x36 (`wmi_cmd_txss_set_sectors_order/number`, `update_sector_sweep_frames_number`) | SLS есть; команд 0x35/0x36 нет | [код] ([BF-ENGINE §8.5](BF-ENGINE.md#85-число-и-порядок-секторов-развёртки)) |
| AoA | `ucode_cmd_0x31_handler` 0x920dc8 («AOA was started», «BRP is pending…»), `notify_aoa` 0x92de8c (540) → `uc_evt__send_24` (AOA_MEAS_EVT) | строк AOA нет | [код] |
| FTM/ToF | LMAC 0x2d (`ucode_cmd_2d__set_bit` → `internal_tx__check_idle`), 0x2c (`tof__set_tx_rx_offset_regs`, 0x889800), событие 0x22 (`itx__report_status_evt` → fw `ftm__responder_rx_req`) | нет | [код] |
| внутренние TX-потоки 4 и 6 | `internal_tx_isr` 0x92bbfc: переход по таблице 0x801a94 (sm ≤ 5) → `internal_tx__flow_sm2/4/6`; `internal_tx__flow_sm4` (1532), `_sm6` (1484), `itx__tx_frame_3ies`, `tx_fifo__push_frame_3ies`, `itx__wait_ack(_rf)`, `itx__wait_cts(_rf/_b)`, `itx__rr_pick_pending_a/b`, чтение 0x889568/0x889570; «Postpone TxSS … not enough time in current BI»; постановщики — AW, BF, keep-alive, UPM, FTM | `internal_tx__pending_sm`: 1 — заглушка, 2 — keep-alive, 3 — BF | [код]; sm4 = FTM-обмен [гипотеза] |
| измерения при приёме | `rx_meas__capture_frame` 0x927f6c, `rx_meas__append_sample`, `rx_meas__finish_with_8830ec`, `rx_capture__match_filter`, `phy_stats__accumulate_to_shared` (запись в 0x8576a0) в путях `bti__bi2_event_step`, `rx_flow__handle_frame`, `rx_flow_step` | те же вызывающие этих вызовов не содержат | [код] |
| команды-измерения SYSAPI | 0x28/0x2a/0x2e/0x37/0x3c → `ucode_cmd_28__apply` 0x935e30; 0x29/0x2b/0x2f/0x38/0x3d (по 144 Б, MAC 0x1d005000/0x1d006000, `bf_pending__set_bit`); события 0x20/0x21 (`bf__reset_sta_slot`), 0x23, 0x2b, 0x26 (INA, `ucode_cmd_0x20_handler`) | нет | [код] |
| UPM | LMAC 0x33/0x34 (`ps__hold_awake_for_sta`, `ps__release_awake_for_sta`, `ps__hold_awake_if_active`), событие 0x25 UPM_IMMEDIATE_RSP | нет | [код] |
| маски пиров | `peer_masks__or_into_8571c4` (LMAC 0x47, событие 0x2e → fw `ba__on_uc_timeout_evt`), `peer_masks__or_sta_bit_into_8571c4`; `peer_masks__apply_op` 0x934bb0 (пара 4.1 `power_mngr_peer_update`) | маски пиров есть | добавлены LMAC 0x47 и событие 0x2e [код] |
| DTI-аллокации (ESE) | `dti_worker__scheduled_dti_allocation_event` 0x934854 («starting slot id / closing slot»), `dti_alloc__dispatch`, `uc_evt__send_29_sync` (событие 0x29), вход по r54 б4 через объект 0x802f44 | r54 б4 → `bi_manager__l1_entry_b`: только PS_AWAKE_PEER в состоянии 1, иначе ассерт | [код] ([ESE](ESE.md)) |
| сторож L2 | `l2_handle_watchdog` 0x92cf90 (ilink1/ilink2, phy_fa_rate, txrx_state; флаг 0x800624) | нет | [код] |
| диагностика исключений | `uc_vector_02` 0x9204bc («Bad instruction (action point)», «ST/LD cmd before…», `regs%u`), `arc_protect_addr_uc` / `arc__program_action_point` (из LMAC 0x41), `uc_sysassert__scan_stack` («stack dump»), гистограмма CCA в `uc_sysassert__idle_hist` | `uc_isr_instruction_error` (16 Б), `uc_sysassert__idle_hist` без CCA | [код + строки] |
| глубокое выключение и включение РЧ | `hwd_rfc_powerdown_deep_all_rfs` 0x929fa0, `hwd_rfc_powerup_deep_all_rfs` 0x92a0a0 (из `hw__power_sequence_rf`), `rfc__restore_txrx_sets`, `rf__set_txrx_sets_save` | строк нет | [код] |
| триггеры записи PMC | LMAC 0x42 `txrx_umac_if_config_pmc_triggers_handler`, `handle_pmc_triggers`, `pmc__stop_recording`, метки `sends_pmc_mark_aaab02/20`, событие 0x2c `EVT_PMC_STATUS` | нет | [код] |
| AGC | `hwd_phy_rx_set_agc_start_val_and_gain_array_uc` (две строки), LMAC 0x11 (`silent_rssi__report_agc_tables`) | строк нет, у 0x11 другое тело | [код + строки] |
| лог rate search | строки `rs_start` / `rs_end` / `rs_abort` | функции есть, строк нет | [код] |
| GP-таймеры в функциях | `gp_timer__set_value` 0x935080, `gp_timer__arm` 0x93512c, `gp_timer__stop`, `gp0__arm_usec(_b/_c)` (мкс × 0xa5 → команды 0x52/0x49/0x4f); блоков с командами 0x4f…0x54/0x67/0x68 — 46 | те же коды MAC встроены по месту (34 блока) | переписано [код] |

## 6. Изменено при сохранении номера или интерфейса

| элемент | 4.1 | 6.2 | уровень |
|---|---|---|---|
| WMI 0x803 `WMI_ECHO` | `wmi_handler_echo` (48 Б): только эхо 0x1803 | `beacon_interval` 0x8e5418 (92 Б): лог `beacon_interval:%u align:%u`, эхо 0x1803 с интервалом маяка; станция берёт из него период BI ([HOST-INTERFACE](HOST-INTERFACE.md#отличия-62)) | [код] |
| WMI 0x863 `WMI_NOTIFY_REQ` | `host_if__timestamp_sync`: дата хоста, таймер синхронизации, событие 0x1863; второй отправитель 0x1863 — `l2mgr__send_notify_req_done` | `wmi__bump_cmd_counter`: `conn_mgr__by_cid` + `link_stats__fill_sta_entry`, событие 0x1863; второй отправитель — `calls__8e0a20` | [код] |
| WMI 0x856/0x857 | `wmi_handler_otp_read/_write` (`OTP read/write failed!`, `otp__read/write_bytes`, `marlon_r_if__otp_write`, `xpm_read_cnt`, `otp__log_params`; 804 Б), запись события не шлёт | `host_if__read/write_rf_xpm_handler` (`hwf_rf_xpm_*`, события 0x1856/0x1857), `otp_init`; OTP чипа → XPM РЧ-модуля по `rf_id` | [код] |
| WMI 0xa01 (ESE) | `wmi_handler_ese_cfg` → `ese_cfg__apply`, без события; разбор ESE маяка — `parse_ese` 0x8db3cc (484), `allocation_type` (112), `ese__find_alloc_by_id`, `ese__alloc_matches_id`, `ese__copy_alloc_header` | `wmi_ese_cfg`, событие 0x1a01; разбор — `schedule_scheme_builder__build_allocations_from_beacon` 0x8c5248, `ese__alloc_to_slot` 0x8c7d4c, `ese__slot_table_add` (≤ 3 записи, фатал 0x11bb), `[PRS] ESE EI`; слоты исполняет ucode (событие 0x29) ([ESE](ESE.md)) | [код]; раскладка слотов 4.1 не сверена |
| WMI 0x80e `WMI_TEMP_SENSE` | `wmi_handler_temp_sense` | `wmi__cmd_arg_check` 0x8e909c: `temp__get_rf_by_index`, событие 0x180e; `MARLON-R TEMP …` → `MARLON-R rfc_idx=%d TEMP …` | [код] |
| WMI 0xf `WMI_BCON_CTRL` | `wmi_handler_bcon_ctrl` | `wmi_pcp_start_cmd_handler`: `set abft_len = %d` — длина A-BFT из команды | [код] |
| WMI 0x900 `WMI_UNIT_TEST` | `wmi_ut_handler_dispatch` (128 Б) | `wmi_ut_handler` 0x8ed038 (356 Б): в лог пишутся subtype и 6 слов параметров | [код] |
| неизвестная UT-подкоманда | модуль драйверов: переход 0x8e64ec → `fw_sysassert_fatal` (код 0x49e); SYSAPI: всё, кроме 0x6 и 0x48, → `fw_sysassert_fatal` | `wmi_evt__send_command_not_supported` (событие 0xffff); 0x700 → `ut_hw_drivers__reply_not_supported` | [код] |
| модуль UT 1 (HW_FLOWS) | блок 2376 Б со строкой `UT_HW_FLOWS_OPERATIONAL_cmd_handler` | `UT_HW_FLOWS_OPERATIONAL_cmd_handler` 0x8fa884 (1312 Б), набор подкоманд заменён (раздел 7.3) | [код] |
| ассерт | `fw_sysassert_fatal(строка, имя файла)` | `fw_sysassert_fatal(blink, код)`; код = номер строки исходника: в `wmi_set_pcp_channel` 6.2 и `wmi_handler_set_pcp_channel` 4.1 одно значение 0x11df; код → 0x85700c | [код] |
| формат записи лога fw | заголовок: биты 0–19 — строка, 20–23 — модуль, 24–25 — уровень, 26–27 — число аргументов, 28 — `nonl`, биты 29 и 31 установлены; API `fw_log__emit0..3`, `_nonl`, `fw_log__commit` (r0 — модуль, r1 — бит уровня, r2 — строка) | биты 0–19 — строка, 26–27 — число аргументов, 29 и 31 установлены, 18–25 ← min(старшее слово TSF, 0xff); за заголовком младшее слово `mac_read_tsf64`; API `fw_log_emit0..3`, `fw_log__emit1_tsf`, `fw_log__emit2_tsf` (r0 = модуль \| уровень<<4, r1 — строка), `_nonl` нет; `fw_log__init_ring` 0x8dcb1c ([BENCH](../6.2/docs/BENCH.md#загрузка-и-лог)) | [код] |
| лог ucode | кольцо 0x8020b0, запись встроена по месту (36 блоков адресуют кольцо) | кольцо 0x803234, `uc_log__emit1..3`, `uc_log__emit_snapshot`, `uc_log__init_ring` ([UCODE-TASKS §2.2](UCODE-TASKS.md#22-лог-ucode-62)) | [код] |
| событие READY | `WMI_READY … (is OOB = %d)`, `l2mgr__send_ready_evt` | `(OOB mode = %d)`, `wmi_evt__notify_fw_ready` | [код] |
| режим OOB в L2MGR | `[L2MGR] OOB mode` (`l2mgr__init`), `l2mgr__init_oob_pool/_detector` | `[L2MGR] R1 OOB mode: disable power management`, `[L2MGR] R2 OOB mode`, `l2mgr__oob_pair`, `l2mgr__init_periodic_detector` ([ROLELESS-LINK §1.7](ROLELESS-LINK.md#17-режим-oob-в-62-код)) | [код]; соответствие блоков [гипотеза] |
| событие ucode 0x17 MAC_MONITOR | `lmac_if__mac_monitor_report` (печать окон) | `lmac_if__update_pct_stats` (процентная статистика, CCA) | [код] |
| команды LMAC с изменённым телом | 0x07 — подкод 1/2, битовые поля; 0x0f — `{u32, u16}`; 0x11 — 4×u32 → 0x8016b4; 0x14 — cid → `[gp,0xb4]`, flags → `[gp,0xb8]`; 0x15 → `[gp,0xc4]/[gp,0xc8]`; 0x16 — байт `[0x800d08]`; 0x19 — `{u8, u16, u32}`; 0x21 — 4×u16 = `[gp,0x26c]`; 0x23 → 0x802090/94/98; 0x12 — отправителя в fw нет | 0x07 — FTM «радио получено»; 0x0f — сброс состояния CID (`ucode_cmd__reset_queue_state`); 0x11 — AGC-старт и таблица усиления; 0x14 — одно слово → `[0x8021b8+0x20]`; 0x15 → `[gp,0xb4]/[gp,0xb8]`; 0x16 — байт +0xb4 калибровочного объекта; 0x19 — RX omni-сектор (UT); 0x21 — ≤ 0x7ff мкс, 0x500 в OOB, сдвиг второго значения; 0x23 → 0x803128/2c/30; 0x41 — + action point (`arc_protect_addr_uc`); 0x12 — отправитель UT (`field_set_0x00__8dbc94`) ([LMAC-PROTOCOL §5.2](LMAC-PROTOCOL.md#52-тела-команд-различающиеся-в-62-код)) | [код] |
| LMAC 0x05 и 0x22 | 0x05 ведёт шаг сна `shallow_sleep_step`; 0x22 — `psc_pending_agreement_cmd` с логом | 0x05 шаг сна не зовёт; 0x22 урезан (раздел 3.2) | [код] |
| транспорт LMAC | `send_cmd2_lmac` 0x8e0694, ящик 0x803e3c, гейт `[gp,0x238]`; ucode `uc_send_event` 0x925dd8 | `lmac_if__post_cmd` 0x8e5204, ящик 0x804280, гейт `[gp,0x244]`, шапка +0x06 b3; ucode — очередь 0x802470, `uc_evt__enqueue` 0x927958 (со снятием TSF) | раскладка шапки та же [код] |
| автомат BI ucode | `BI_AP_MONITOR_SM` на движке `basic_sm` (`basic_sm__dispatch_loop` 0x9287ec, `bi_ap_mon__init`, диспетчер триггеров на 6 входов, `bi_window_timing_update` 0x921ce8 пишет тайминги окон в 0x80088c+0x80…0x88) | `bi_sm`: экземпляр 0x800600, описатель 0x801adc, `uc_sm__handle_event` 0x92b6fc; нумерация состояний и событий (4×5) та же; счётчики окон — блок 0x802ec0 ([BEACONING §6.3](BEACONING.md#63-блок-счётчиков-окон-62-0x802ec0-62-код)) | [код] |
| описатель автоматов fw | вызовы `basic_sm__setup`, таблицы имён отдельно | описатель `{…, u32 state_names, u32 event_names}` ([STATE-MACHINES §1](STATE-MACHINES.md#описатель-62)) | [код] |
| вектор 7 fw | `isr_timer1` | `fw_vector_07` 0x8da03c: сохранение контекста и фатал 0x11ad — таймер 1 не используется ([HW-DRIVERS §2.1](HW-DRIVERS.md#21-таблица-векторов-код)) | [код] |
| LMAC 0x26 | отправитель `lmac_if_keep_alive_trigger_handler` | обработчик → `keep_alive__arm_slot`; отправитель в fw не установлен | [код] |

## 7. Интерфейсы

### 7.1. Команды WMI

| | 4.1 | 6.2 |
|---|---|---|
| диспетчер | `host_if__wmi_cmd_dispatch` 0x8da54c | `wmi__host_cmd_dispatch` 0x8de43c |
| веток | 68 | 102 |
| общих | 67 | 67 |
| только в этой версии | 1: 0x859 | 35 |
| имён `WMI_*_CMDID` в строках | 63 | 92 |

Из 67 общих тело обработчика совпало дословно у трёх: 0x4 (`wmi_handler_disconnect_sta`), 0x804
(`lmac_if__send_echo`), 0xf007 (`wmi_handler_abort_scan`). У 0x3f, 0x910, 0x913–0x917, 0xf003 ветка
6.2 ведёт на тот же обработчик через хвостовой переход `tail_*`. 0xa и 0x835 обработчика нет в обеих
версиях. Остальные общие переписаны; события хосту в 6.2 отправляют `wmi_evt__post` и
`low_sme__send_evt2sw` вместо `basic_if__post_event` / `operational_if__send_evt`. Полная таблица —
[WMI](WMI.md#полная-таблица-команд).

Добавленные 35 команд:

| группа | команды |
|---|---|
| BF с хоста | 0x83a `BF_TRIG`, 0x9aa `BF_CONTROL`, 0x924 `BRP_SET_ANT_LIMIT`, 0x9a4 `SET_RF_SECTOR_ON`, 0x9a5–0x9a7 `PRIO_TX_SECTORS_*` |
| фиксированное расписание | 0xa02, 0xa03, 0x85f, 0xa0e `SET_GRANT_MCS`, 0xa0f `SET_AP_SLOT_SIZE` |
| станции с хоста | 0x935 `NEW_STA`, 0x936 `DEL_STA`, 0xa06 `GET_ASSOC_LIST` |
| ToF/FTM/AoA | 0x991–0x998, 0x923 `AOA_MEAS` |
| РЧ, калибровки, питание | 0x85c `SET_ACTIVE_SILENT_RSSI_TABLE`, 0x85d `RF_PWR_ON_DELAY`, 0x85e `SET_HIGH_POWER_TABLE_PARAMS`, 0x866 `GET_RF_STATUS`, 0x867 `GET_BASEBAND_TYPE`, 0xa04 `SET_MULTI_DIRECTED_OMNIS_CONFIG` |
| CCA | 0xa07, 0xa08 |
| rate search | 0x922 `GET_DETAILED_RS_RES` |
| UPM | 0x960 `WMI_UPM_CFG` (→ LMAC 0x33) |
| отладка | 0xfff (`orig_fract`) |

### 7.2. События WMI

4.1 — скан вызовов `basic_if__post_event` 0x8e0460 (номер в r3) и `operational_if__send_evt` 0x8e0874
(номер в r1), с восстановлением номеров из сдвигов (`0x61<<6`, `0xc1<<5`, `bset 0xc`); 6.2 —
[WMI](WMI.md#события-прошивка--хост).

| | 4.1 | 6.2 |
|---|---|---|
| номеров | 55 | 83 |
| только в этой версии | 0 | 28 |

Общие 55: 0x15, 0x16, 0x1001–0x1003, 0x100a, 0x1801, 0x1803, 0x180e, 0x1820, 0x1821, 0x1823–0x1826,
0x1828, 0x182a, 0x182b, 0x1836, 0x1840–0x1843, 0x1853, 0x1856, 0x1860, 0x1862–0x1865, 0x1868, 0x1900,
0x1904, 0x1905, 0x1910, 0x1911, 0x1914–0x191a, 0x191c, 0x1921, 0x1930, 0x1931, 0x19a0–0x19a3, 0x1a05,
0x9003–0x9005.

Добавленные 28: 0x1857; 0x185c–0x185f, 0x1866, 0x1867; 0x1922–0x1924; 0x1991, 0x1992, 0x1995, 0x1997,
0x1998; 0x19a4, 0x19a5, 0x19aa; 0x1a01–0x1a04, 0x1a06–0x1a08, 0x1a0e, 0x1a0f; 0xffff
`WMI_COMMAND_NOT_SUPPORTED`. Кроме того, в 6.2 добавлен канал событий SYSAPI
`fw_sysapi_mgr__send_evt2host` (энергия, PLCP, оценка канала, статистика; строк `sysapi` 87 против 4).

### 7.3. Подкоманды `WMI_UNIT_TEST` (0x900)

Диспетчер модулей в обеих версиях — `sub 7; brhs 7` и байтовая таблица (4.1 0x801cdc, 6.2 0x8021e0)
одинакового содержимого `00 1c 04 09 0e 13 18`.

| индекс | 4.1 | 6.2 |
|---|---|---|
| 0 | `calib_mgr_ut` (104 Б) | `calib_mgr_ut` (92 Б) |
| 1 | блок 0x8e6514 (2376 Б), модуль HW_FLOWS | `UT_HW_FLOWS_OPERATIONAL_cmd_handler` (1312 Б) |
| 2 | `UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler` (116 Б) | то же (1044 Б) |
| 3 | `UT_HW_MODES_cmd_handler` (456 Б) | то же (400 Б) |
| 4 | `UT_HW_DRIVERS_cmd_handler` (2348 Б) | то же (3316 Б) |
| 5 | `power_mgr_ut` (88 Б), подкоманды 1/2 | `power_mgr_ut` (76 Б), подкоманды 1/2 |
| 6 | `fw_sysassert_fatal` | `fw_sysassert_fatal` |

**Модуль драйверов.** 4.1 (листинг 0x8e5be8): таблицы 0x803124 (0x101–0x203), 0x80332c (0x401–0x423),
0x803374 (0x425–0x437), 0x80339c (0x504–0x513) и одиночные сравнения 0x301–0x304, 0x424, 0x501–0x503,
0x601, 0x602. 6.2 — [UT-DRIVERS](../6.2/docs/UT-DRIVERS.md) (листинг 0x8eaec8).

| группа | 4.1 | 6.2 | новые коды |
|---|---|---|---|
| ABIF | 68 | 80 | 0x146, 0x156–0x159, 0x160–0x164, 0x170, 0x171 |
| CAR | 3 | 3 | — |
| MAC | 4 | 5 | 0x305 |
| PHY | 50 | 54 | 0x42c–0x42e, 0x438 |
| RFC | 19 | 30 | 0x514–0x51e |
| PCIe | 2 | 4 | 0x610, 0x611 |
| всего | 146 | 176 | 30; ни один код 4.1 не удалён |

**Модуль HW_FLOWS** (по строкам `UT_HW_FLOWS_SUBTYPE_*` и `hwf_*`): убраны BER-тесты петли PHY,
производственный петлевой тест, подкоманды `CALIB_BB_GAIN_ALG`, `CALIB_GAIN_CONVERGE_LOOP`,
`CALIB_IF_GAIN_ALG/ENTRY/EXIT`, `CALIB_VGA_DC_ALG_FINE`, `CALIB_VGA_DC_ALG_LAST_STAGE_ONLY`,
`hwf_sector_rf_chains_array_get`; добавлены `CALIB_LO_POWER_FLOW`, `RF_XPM_ENTER_CFG_MODE`,
`RF_XPM_CFG_GET/SET`, `RF_XPM_PROGRAM_BIT/BYTE/BLOCK`, `RF_XPM_READ_BYTE/BLOCK`,
`PHY_TX_REPETITIVE_PACKET`, `PHY_TX_SELF_TRANSMIT_W_MCS_GAIN` («applicabale only in WMI_ONLY_FW»);
`TEST_TRIAL_1` есть в обеих.

**Модуль SYSAPI:** 4.1 — 0x6 → `hw_sysapi_force_mcs`, 0x48 → `hw_sysapi_config_short_vec`, остальное →
`fw_sysassert_fatal`. 6.2 — таблица 0x803600 (0x1–0x49): 0x1–0xc, 0x13–0x15, 0x18, 0x1a, 0x20, 0x26,
0x27 (статистика энергии RX, PLCP, PHY data, RS trigger, omni-сектор RX, FREQ_RATIO, RFC read/write RGF,
GPIO toggle, оценка канала, flush-статистика, начальные температуры); 0x48 → «не поддерживается».

### 7.4. Протокол LMAC

Источники: 4.1 — байтовая таблица 0x800c68 (`4.1/tools/lmac_cmd_map.py`), 6.2 — таблица полуслов
0x8019dc (`6.2/tools/uc_cmd_table.py`); события — `lmac_evt_map.py`, `uc_evt_table.py`
([LMAC-PROTOCOL §5](LMAC-PROTOCOL.md#5-различия-41-и-62)).

| | 4.1 | 6.2 |
|---|---|---|
| диспетчер ucode | `umac_if_cmd_handler` 0x936dd0 (+ `uc_mailbox__dispatch_one` 0x92a2b0) | `ucode_cmd_dispatch` 0x93c928 |
| предел кода / записей | 0x41 / 66 | 0x4a / 75 |
| слотов с обработчиком | 36 (0x06 — встроенный фатал 0xa3) | 62 (0x06 — тот же фатал) |
| рабочих команд | 35 | 61 |
| типов событий ucode→fw в fw | 19 | 32 |

* Общие команды (35): 0x00–0x05, 0x07–0x09, 0x0b, 0x0c, 0x0f–0x16, 0x18, 0x19, 0x1b, 0x1e, 0x20–0x27,
  0x30, 0x39, 0x3a, 0x41. Ни одна не удалена.
* Новые команды (26): 0x28/0x2a/0x2e/0x37/0x3c и 0x29/0x2b/0x2f/0x38/0x3d (измерения SYSAPI), 0x2c ToF,
  0x2d FTM, 0x31 AoA, 0x32 BRP ant limit, 0x33 UPM, 0x34, 0x35/0x36 сектора TXSS, 0x3b, 0x3e
  фиксированное расписание, 0x42 триггеры PMC, 0x45/0x47 QH и маски пиров, 0x48 flush-статистика,
  0x49 grant MCS, 0x4a слот AP.
* События в fw 4.1: 0x00–0x06, 0x08, 0x09, 0x11, 0x13–0x19, 0x27, 0x28. Новые (13): 0x20, 0x21, 0x23,
  0x26, 0x2b (SYSAPI), 0x22 (FTM-ответчик), 0x24 AOA_MEAS, 0x25 UPM_IMMEDIATE_RSP, 0x29
  SCHEDULED_SCHEME_NOTIFY_FW_PUSH_SLOTS, 0x2c PMC_STATUS, 0x2e (BA timeout), 0x2f
  GET_FLUSH_STATISTICS_DONE, 0x30 FIXED_SCHEDULING_ENABLED.
* Ветви fw для 0x15 PS_SHALLOW_SLEEP_NTF и 0x19 PS_WAKE_PCIE есть в обеих версиях, но ucode 6.2 эти
  события не отправляет (скан всех вызовов `uc_evt__enqueue` / `uc_send_event`).
* Обработчики 0x01/0x03: 4.1 `lmac_if_rx_on_off_rsp_handler` → 6.2 `rm_main_sm__inject_lock_evt`,
  `rf__get_active_mask`.

### 7.5. Автоматы `basic_sm`

Источники: `4.1/ref/SM-TABLES.txt`, `6.2/ref/SM-TABLES.txt`, `*-UC.txt`,
[STATE-MACHINES](STATE-MACHINES.md#2-инвентарь-автоматов).

| автомат | 4.1 | 6.2 |
|---|---|---|
| всего fw / ucode | 21 / 1 | 24 / 1 |
| `swc_psc_sm` (скан под PS) | нет | `state_sm_8030e0`, 3×4, старт STATE_SCAN_IDLE |
| сеанс FTM | нет | `state_sm_803424`, 3×9, STATE_READY |
| `ftm_main_sm` | нет | `state_sm_8034c0`, 5×8, STATE_IDLE |
| MLME_SM | 3×9 (CONNECT … RM_CHANNEL_LOCKED, DATA_PORT_OPEN) | 3×14: + WAITFOR_CTRL_ASSOC_RES, CTRL_ASSOC_RESPONSE_RET, CTRL_NEW_STA, WAITFOR_CTRL_DEL_STA, CTRL_DEL_STA |
| BA_SETUP_SM | 6×12 (ST5 и EVT11 без имён) | 7×13: + состояние WAIT_FOR_VRING_STOP, событие EVT_VRING_STOPPED |
| CALIB_ENGINE | `calib_engine__init`, 4×6 | `sm_802234`, 4×6 (соответствие по размерности) |
| BI_AP_MONITOR_SM (ucode) | 4×5, `bi_ap_mon__init` | `bi_sm`, 4×5 |
| остальные 18 fw | LM 7×12, RM 6×12, CONN 9×11, BA 5×12, MAINTAIN 4×10, CHANNELS_SWITCH 7×8, FIND 5×7 и др. | размерности те же, тела переходов переписаны |

Ни один автомат не исчез.

### 7.6. Модули лога

Таблицы имён модулей совпадают побайтно: fw (начало `strings-fw.bin`, 0xa0 Б) — SYSTEM, DRIVERS,
MAC_MON, HOST_CMD, PHY_MON, INFRA, CALIBS, TXRX, RAD_MGR, SCAN, MLME, L2_MGR, DISC, MGMT_SRV, SEC/PSM,
WBE_MGR; ucode (начало `strings-uc.bin`, 0xc0 Б) — SYSTEM, TX, RX, ISR, BCON, BEAMFORM, SXD_UTILS, RSSI,
CALIBS, DRIVERS, NAME_10…NAME_15. Кольцо fw 0x843900, уровни `u8[16]` по +4, индекс по маске 0x3ff слов —
без изменений. Формат записи и кольцо ucode — раздел 6.

### 7.7. Глобальные объекты и классы

`6.2/ref/GLOBALS-{fw,uc}.txt` пусты, `4.1/ref/GLOBALS-fw.txt` содержит 231 глобал через gp —
поадресное сравнение невозможно. Классы C++ по префиксам `Class::` в лог-строках: 109 в 4.1, 113 в 6.2,
общих 102.

| объект | 4.1 | 6.2 |
|---|---|---|
| `tof_mgr`, `ftm_mngr`, `ftm_main_sm` | нет | есть; `tof_mgr` 0x806518 |
| `fw_sysapi_mgr` | нет | 20 строк |
| `calib_silent_rssi_sparrow` | 4 строки `silent_rssi` | 21 строка; объект 0x80220c |
| `swc_psc_sm` | нет | 12 строк |
| `schedule_scheme_builder` | строк нет (ESE — `parse_ese`) | `build_allocations`, `build_allocations_from_beacon` |
| `ka_detector` | `ka_detector__configure/rearm/is_active`, 4 строки | 1 строка |
| `stream_mgr` | 2 строки | 9 строк; объект 0x802424 |
| `RADIO_MGR` | есть; строки `lock_primary/lock_secondary` | 2 экземпляра 0x8038e0, 0x803b18; описатель `rm_sm` 0x803210 |
| mid / bss / RX-пул / radio_mgr | 0x8058f0 / mid+0x48 / 0x84af54 (12×0x538) / 0x8063f4 ([STRUCTS](../4.1/docs/STRUCTS.md)) | адреса не установлены |
| синглтоны 6.2 | кластеризация не выполнялась | `PS_CFG_SCHEME` 0x803d5c, `l2_mgr` 0x805140, `TX_API` 0x8031b8, `low_sme` 0x804c34, `TEMPERATURE_SERVICE` 0x8019bc, `POWER_MNGR` 0x803d10, `lmac_if` 0x80426c ([FW-OBJECTS §2](FW-OBJECTS.md#2-синглтоны-62-62)) |

## 8. Память

Из `4.1/ld/memory.ld`, `6.2/ld/memory.ld` и размеров `build/*.bin` **[код]**.

| сегмент | 4.1: занято / свободный хвост | 6.2: занято / свободный хвост |
|---|---|---|
| fw_code 0x8c0000, 256 КБ | 211 800 / 50 344 (0xc4a8 с 0x8f3b58) | 247 140 / 15 004 (0x3a9c с 0x8fc564) |
| fw_data 0x900000, 32 КБ | 26 748 / 0 (остаток 6 020 — стек) | 26 908 / 0 (остаток 5 860 — стек) |
| uc_code 0x920000, 128 КБ | 98 500 / 32 572 (с 0x9380c4) | 126 148 / 4 924 (с 0x93ecc4) |
| uc_data 0x940000, 16 КБ | образ 3 828 / 0 | образ 7 144 / 1 464 (с 0x943a48) |

* **Нулевая область внутри fw_code 6.2.** Блок `fw_vector_19__unused_zero_fill` 0x8edcf4 (8 972 Б) —
  8 NOP (цель вектора 19, аналог 32-байтового `isr_nop_pad` 4.1) и 8 940 нулевых байт
  0x8edd14–0x8f0000; с 0x8f0000 начинается код (`calib_silent_rssi__ctor`, `fw_main`). Область не
  входит в свободный хвост `fw_code_ext`. Нулевое слово в ARCompact — `b .`, поэтому вектор 19
  (`j 0x8edcf4` в 0x8c0098) после восьми NOP зацикливается на 0x8edd14: это слово живое. Остальные
  **0x8edd18–0x8f0000 (8 936 Б)** не адресует ни код, ни указатели в данных (ни абсолютные, ни
  смещения от базы сегмента), на обоих узлах стенда после работы с линком область целиком нулевая
  **[код, железо]** — это второй свободный участок fw_code. Чтобы класть туда код, сборке нужна
  вторая выходная секция с фиксированным адресом 0x8f0000 для кода за областью.
* **Свободный хвост** под новый код — [REWRITING §3](REWRITING.md#3-написать-файл).
* **`g_dbg_dashboard`.** 4.1: `dashboard__init` 0x8ed218, база 0x854800, revision 5, size 0x65c,
  `phy_mac_flags` по +0xf8, константа базы в данных 0x8033d8 ([DASHBOARD](../4.1/docs/DASHBOARD.md)).
  6.2: `fw_stats_blk__init` 0x8f538c (из `fw_main`), база 0x853800 (на 0x1000 ниже), revision 5, поле
  size 0x1c0, байт 0xf по +0x118; адрес отдаёт `boot_diag__fw_stats_blk_addr` 0x8cc160;
  `dashboard__add_connection/on_disconnect` адресуют 0x853900/0x853920. Объект SSID/passphrase:
  0x8033dc → 0x803b80, тела `dashboard__store_ssid` совпадают. Раскладка 4.1 к 6.2 не применима;
  `dashboard__count_bf_result` и `dashboard__update_rs_result` в 6.2 пары не имеют
  ([FW-OBJECTS](FW-OBJECTS.md#отладочная-сводка-g_dbg_dashboard)).
* **Хвосты данных.** Остаток `fw_data` за образом в обеих версиях — стек fw (`mov sp,0x807ffc`:
  4.1 0x8c0258, 6.2 0x8c0178); на стенде 6.2 (AP с линком) стек занят ~1,2 КБ сверху, но защиты от
  переполнения нет, поэтому под данные он не отдаётся **[код, железо]**. В ucode за образом лежат живые
  структуры: 4.1 — 0x801438, 0x801de8, 0x801e14, кольцо 0x8020b0, стек до 0x8028b0; 6.2 — BSS
  0x801be8–0x803648 (очередь событий 0x802470, состояние BI 0x802ec0, A-BFT 0x803124–0x803130, кольцо
  лога: заголовок 0x803234, буфер 0x803248–0x803648), стек 0x803648–0x803a48 (`mov sp,0x803a48`
  0x9201b8). Свободна только область 6.2 **0x803a48–0x804000 (1 464 Б)**: обращений к ней нет ни в
  коде, ни в указателях данных, на обоих узлах стенда после 7–11 минут работы с линком там нетронутый
  мусор включения SRAM **[код, железо]**. Стек ucode 6.2 на стенде занят ~408 Б из 1 КБ. Обращения
  ucode 6.2 к 0x804004–0x80402b лежат за окном `blob_uc_data` (16 КБ) и к этой области не относятся.
  `ld/memory.ld` обеих версий описывает это так; данные нашего кода кладутся рядом с кодом в
  `fw_code_ext`, как у блоков на C.

## 9. Переписано без изменения функциональности

Блоки без пары, для которых эквивалент в другой версии найден по строкам, вызовам, кодам команд или
таблицам. Для них пары нет из-за разрезания, слияния, встраивания функций, иной разметки блоков или
разных имён.

**fw, сторона 4.1**

| группа | блоков / байт | примеры и эквиваленты |
|---|---|---|
| драйверы HW | 101 / 9 444 | `hwd_phy__config_by_mode` (480), `ut_hw_drivers_cmd_0x40b` (268), `hwd_abif__write_checked` (240), `hwd_phy__set_mode` (220), `hwd_phy__write_884000` (196), `hwd_rfc__program_clocks`, `marlon_r_if__write_verify` (≈ `hwd_rfc_write_verify` [гипотеза]); все 27 блоков `ut_hw_drivers_cmd_0xNNN` и 24 вспомогательных имеют ветку с тем же UT-кодом в 6.2; тела не сверены |
| калибровка | ≈54 / ≈4,1 КБ | `hwf_calib_lo_leakage_res` (340), `calib_bb_gain_dc__vga_dc_fine` (320), `measure_rssi_using_histogram` (296; кандидат `silent_rssi__hist_window_index` [гипотеза]), `calib_engine__*`, `calib_*__vtNN`, `perform_first_measurement_operations` |
| действия и init автоматов | 122 / 4 776 | `find_main_sm__bf_ntf` (264), `mlme_sm__tx_complete_cb`, `maintain_sm__on_*`, `lm_main_sm__on_*`, `ba_sm__*`, `ba_setup_sm__*`, `ps_assoc/ps_nonassoc_mgr__vtNN`, `psc_if__*`, `radio_manager_main_sm__*`, `*_sm__init`, `ka_necessity_detector__init`, `tx_ppdu_ageing_timeout_detector__init` (→ `detector__init_per_cid_a/b`) |
| тракт данных | 66 / 4 956 | `tx_queue__config_by_mode_b` (376), `STREAM_MGR__ADD` (304), `rx_queue__program_desc`, `vring__on_macq_delete_ntf`, `sm_pring__eop_evt`, `tx_dma_if__submit`, `tx_api__prepare_descriptor`, `edca__set_default_ac_params`, `FWQ_TX_AVAILABILITY__add_packet`, `llist__*`, `TX_API__flush_pending_peer_pm_connection` |
| хост / LMAC / L2 | ≈40 / ≈3,1 КБ | `l2mgr__data_port_open` (320), `lmac_if_send_cmd_0x0c/0x07/0x11/0x21/0x05/0x19/0x16`, `lmac_if__wait_ucode_ack_2/4` (→ `fw2uc__signal_wake/halt_and_wait_ack`), `fw_mailbox__*`, `fill_statistics_to_host`, `l2mgr__send_ready_evt`, `lmac_if_send_long_range` (→ `wmi_set_long_range`), `sysassert__dump_stack` (→ `fw_sysassert__stack_dump`), `fw_log__*` |
| прочее | ≈80 / ≈4,5 КБ | `rf_sector_params_write` (332), `isr_timer1`, `pcie_boot_step_a/b` (из `WBE_DRIVER__pcie_boot_init` = 6.2 `fw_main`), `radio_manager__lock_*` (→ `rm_main_sm`), `search_scan_elem_in_list`, `pcp_ap__set_aid`, `regd__jp_*` (→ `regd__is_unset_or_jp`, `regd__is_country_not_jp`), `dashboard__*`, `rs__need_long_term` |
| механика | ≈420 / ≈5,1 КБ | `bf_*` (75 / 900), `get_g_/set_g_/set_reg_/rgf_reg_/boot__*` (110 / 1 564), `frag_/stub_ret_/tail_/epi_` (175 / 1 540), милли-код, векторы, IRQ (`reset`, `interrupt_vector_0N`, `__ld_*`, `irq_enable*`, `sar64_fw`, `umul64_fw`, `init_globals_sweep`; 58 / 1 120) |

**fw, сторона 6.2**

| группа | блоков / байт | примеры и эквиваленты |
|---|---|---|
| UT-драйверы с кодами 4.1 | 63 / 5 388 | ABIF 0x103–0x151, PHY 0x404–0x437 (`recording_mode_set` 400 Б на коде 0x42b), MAC SXD 0x301–0x304, RFC 0x501–0x50b (`hwd__program_889_group`) |
| аксессоры битовых полей | 69 / 828 | 68 совпадают с `bf_{u16,b,w,h}_sN_wM` 4.1 по типу, сдвигу и ширине ([FW-UTILITIES §1](FW-UTILITIES.md#1-семейство-bf_set_sn_wm-код)); без аналога `frame__bits_set8_s3_w5` |
| векторы | 5 / 9 428 | `fw_vector_19__unused_zero_fill`, `fw_vector_table` (288), `fw_vector_07` (160), `fw_vector_14/17` |
| прочее | 464 / 22 092 | загрузка и конструкторы (`boot__install_handler_ptrs` 972 Б, `obj_vt*__ctor`, `fw_stats_blk__init`, `calib_engine__sm_init`); тракт данных (`qdesc__build_by_type` 372, `qh__write_by_flags_fw` 348, `fwq_tx__queue_step` 264, `rx_macq__pack_desc` 228, `stream_mgr__ready_for_modify` 208, `edca__fill_default_ac_params` 200); ESE; действия автоматов, общих с 4.1 (`ba_sm__*`, `lm_sm__*`, `conn_main_sm__*`, `state_sm_8030f4__*` — P2P Find); калибровки; РЧ/brd (`channel__check_range` 304, `rf_boardfile__read_platform_info`); интерфейсы (`wmi_evt__notify_fw_ready`, `otp_init`, `arc_protect_addr`, `lmac_if__send_txop_limits`); регистровые помощники |

**ucode.** 4.1: BRP и программирование режима MAC (`brp__flow_main` 1152 Б, `mac_mode_program_a/b` 840/584 → `brp_init__flow`,
`brp_init__tx_request`, `brp_responder_transmission_flow`); автомат BF (`bf_sm_step`, `bf_sm__*` →
`bf_sm__dispatch_by_state`, `bf_sm__run_sta`, `bf_req__*`, [BF-ENGINE §12](BF-ENGINE.md#12-диспетчер-по-записи-станции-и-блоки-bf-62));
TXSS (`txss__init_sweep_b`, `txss_func__reorder_sectors` → `txss_init__*`,
`txss__order_known_sectors_first` [гипотеза]); развёртка маяка (`bcon_sweep_step_b`,
`bcon_sweep__next_sector`, `beacon_tx__build_slot_bitmap` → `ss_plan__next_sector`,
`bcon_txss__program_sector`); приём (`rx_flow__post_rx_act*` встроены в `rx_flow__handle_frame` 6.2,
3812 Б против 2416); грант RD (`rx_flow__grant_detected` 904 Б → `rx_get_required_response`);
TX-инициатор (`tx_initiator_flow` 552 Б → `tx_slot__dispatch`, `tx_slot__pick_queue`,
`tx_sta__run_txop`); программирование TX в MAC (`mac_counter__program_*` → `mac_q__tx_ppdu*`); BI-менеджер
(`bi_manager__*` → `bi__dispatch_by_role`, `bi_rx__slot_handler`); телеметрия MAC_MON
(`bi_window_transition_prep` → `peer_slots__scan_by_masks` 0x93cd2c, двойной буфер 0x801030+0x28·i →
0x853940); учёт энергии L2 (`l2_task__run` 712 Б → `l2_handle_watchdog`,
`power_mngr__stats_calc_delta`); каркас и векторы; регистровые обёртки. 6.2: разрезание и слияние
функций 4.1 (`rx_resp__finish_restore_rx` 592, `l1_task__dispatch` 292, `bti__arm_period_gp0` 332),
автомат `bi_sm`, каркас, битовые аксессоры и милли-код (`bits__*`, `__ld_rN_to_r13_ret`), регистровые
обёртки (`abif__save_override_restore` 392). Соответствие по разделу [DATAPATH §8](DATAPATH.md#8-соответствие-41--62-микрокод).

## 10. Замечания

* Блок 4.1 0x8e6514 (2376 Б) назван `UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST` по одной из своих
  строк; по строке `UT_HW_FLOWS_OPERATIONAL_cmd_handler` и месту в таблице модулей UT (индекс 1) это
  обработчик модуля HW_FLOWS — `UT_HW_FLOWS_OPERATIONAL_cmd_handler`, как в 6.2.
* `power_mngr_on_unassoc_start` 0x8d3228 (4.1) вызывается только из UT HW_FLOWS; имя не отражает
  назначение.
* `sched__alloc_entry` 0x8db5d8 и `sched__apply_entry` 0x8f1dc4 (6.2) — отправитель LMAC 0x42
  (триггеры записи PMC), зовутся из UT SYSAPI; к расписанию отношения не имеют.
* `bits__set_s8_w5` 0x8ed580 (6.2, 108 Б) — не аксессор битового поля: зовёт
  `rm_main_sm__inject_lock_evt` и `rx_pkt_srvs__dispatch`.
* `wmi__bump_cmd_counter` 0x8dd4b8 (6.2) — обработчик WMI 0x863 `WMI_NOTIFY_REQ`; `wmi__cmd_arg_check`
  0x8e909c — обработчик 0x80e `WMI_TEMP_SENSE`; `beacon_interval` 0x8e5418 — обработчик 0x803 `WMI_ECHO`.
  Имена механические или неточные.
* Проверка множителя ARC находится в 6.2 внутри чужих блоков: код `uc_check_mpy_build` 0x9378d0 (4.1,
  AUX 0x7b/0x7d, `flag 1`) — внутри `txss__store_sector_ranking` @0x93e2d0; код `fw_check_mpy_build`
  0x8e80a8 (4.1) — внутри `wmi_ut_handler` 0x8ed038. Границы этих блоков 6.2 проведены неверно.
* [HW-DRIVERS §1](HW-DRIVERS.md#1-загрузка-main-прошивки) указывает, что `otp_init` 0x8f6cb0 в 4.1
  отсутствует; в 4.1 те же строки `OTP params_0/1` печатает `otp__log_params` 0x8ee90c (92 Б). В 6.2
  добавлен отказ по `com_test`.
* Модуль драйверов 6.2 обрабатывает, кроме табличных кодов, одиночными сравнениями 0x170
  (`channel__check_range`, ветка `ABIF_SET_FREQ_RATIO`), 0x202 (`hwd__wait_pll_lock`, ветка 0x8eb016)
  и 0x602 (`hwd_pcie__set_mode_map`, ветка 0x8eb120) — строки в [UT-DRIVERS](../6.2/docs/UT-DRIVERS.md).
  Коды 0x202 и 0x602 есть в обеих версиях, 0x170 — только в 6.2; без них счёт кодов 6.2 даёт 173
  вместо 176.
* [WMI](WMI.md) относит назначение 0xfff к неустановленному; по листингу `orig_fract` — отладочная
  качалка дроби синтезатора (раздел 5.1).
* [FW-OBJECTS](FW-OBJECTS.md#отладочная-сводка-g_dbg_dashboard) не приводит базу dashboard 6.2; база
  0x853800 и поле size 0x1c0 — раздел 8.
* Ложные пары признака `graph` в ucode на промежуточном прогоне: `perform_shallow_sleep =
  l1_fixed_sched_ap__ev4_state2`, `shallow_sleep_rfc_step = tx_non_data_flow_fixed_scheduling`,
  `umac_if_cmd_handler = ucode_cmd_0x0f_handler`, `get_tx_eligibility__precheck =
  uc_log__emit_snapshot`. При использовании пар `graph` сверять лог-строки и размеры.
* Мёртвые строки ucode 4.1 (`LINK_STATS PHY_INA_SYNC_*` / `PHY_SFD_SYNC_*`, `VRING #%d head`,
  `PRING #%d sw_head`, `SW_HEAD_4_RD`, `HWD MAC: Enable Multi Cast traffic`,
  `hwd_rf_temperature_get_measured_value`, `hwd_rfc_read_rgf: read failed`, `data0 is`) и ucode 6.2
  (`hwd_phy_recording_get`, `hwd_phy_rx_sar_rssi_measure`, `hwd_phy_rx_read_and_parse_brp_ram`,
  `hwd_rfc_xpm_get_write_status`, `rf_utils_auto_fill_set_pattern`, `UT_HW_DRIVERS_SUBTYPE_ABIF_*`,
  `channel num … out of range`, `MCS %d is out of range`, `INVALID agrument cpr_ring_num`) не
  свидетельствуют о наличии или удалении кода.
* Soft-float в fw 4.1 нет; блоки `frag_*` (175) — фрагменты и заглушки разметки, не функциональность.

## 11. Не установлено

* Сохранились ли в 6.2 счётчики из вырезанной печати (`beacon_neighbor/_aw`, `beacon_nav`,
  `KA_cnt/KA_fail_cnt`, `FA_IN/OUT_TXOP_*`, `CCA2_TO_CCA3`) и поля MAC_MON с окнами BTI/AW/DTI и
  `bcon bitmap` в сводке 6.2; проверена только печать.
* Равнозначность 0x859 `BRP_RF_CHAINS_LIMIT` (6 бит в 0x857050) и 0x924 `BRP_SET_ANT_LIMIT` (команда
  ucode 0x32).
* Номера подкоманд `UT_HW_FLOWS_OPERATIONAL` и `UT_HW_MODES` по таблицам (сравнение сделано по
  строкам) и есть ли на местах убранных подкоманд ветка «не поддерживается».
* Чем в 6.2 заменены `measure_rssi_using_histogram` и `regulatory_domain_set_tx_gain_offset`
  (кандидаты `silent_rssi__hist_window_index` и `hwd_rfc_tx_power_cfg`, тела не сравнивались).
* Кодирует ли код ассерта 6.2 что-либо кроме номера строки (проверено одно совпадение, 0x11df).
* Эквивалентен ли учёт исходов ATIM в 6.2 (`bi_rx__slot_handler`: `peer_masks__apply_op` над
  0x802f80) счётчикам 4.1 0x800918…0x80091d.
* Как ucode 4.1 исполняет DTI-аллокации ESE: fw 4.1 разбирает ESE, слотового обработчика в ucode 4.1 нет.
* Назначение `internal_tx__flow_sm4` / `_sm6` (какой бит маски ожидания 0x8006cc запускает каждый),
  путь вызова `notify_aoa` 0x92de8c, связь `rx_meas__*` с командами SYSAPI 0x28/0x29 и событиями
  0x20/0x21/0x23/0x2b.
* Отправители в fw команд LMAC 0x28/0x2a/0x2e/0x37/0x3c, 0x29/0x2b/0x2f/0x38/0x3d и 0x26.
* Блоки-владельцы строк MTP-дампа, CPR и `dump_rfc`; назначение `boot__install_handler_ptrs`
  (кандидат — таблица статических конструкторов, слово 0x18d4 по 0x900dc0) [гипотеза].
* Смысл UPM и подтипов SYSAPI 0x5–0x8, 0xa, 0xc, 0x18–0x27 помимо названных строками.
* Какая доля блоков, отнесённых к «переписано», изменила поведение: вывод для них опирается на
  спаренных вызывающих и лог-строки, а не на сравнение тел; для ~420 механических блоков fw 4.1 пары
  не построены.
* Полный список событий WMI 4.1 вне двух отправителей; номер `ut_hw__post_response` (сдвиг `r3<<8`).
* Единица аргумента `memset0_words` в `fw_stats_blk__init` (0x1c0 слов или байт) и раскладка сводки 6.2.
* Соответствие CALIB_ENGINE ↔ `sm_802234` подтверждено только размерностью.

## Источники

* `tools/version_diff.py` — сопоставление блоков.
* `4.1|6.2/src/asm/{fw,uc}/blocks.json`, `4.1|6.2/ref/ANNO-{fw,uc}.json`, `4.1|6.2/ref/strings-*.bin`,
  `4.1|6.2/ref/SM-TABLES*.txt`, `4.1|6.2/ld/memory.ld`.
* [CROSS-VERSION](CROSS-VERSION.md), [WMI](WMI.md), [LMAC-PROTOCOL](LMAC-PROTOCOL.md),
  [STATE-MACHINES](STATE-MACHINES.md), [HW-DRIVERS](HW-DRIVERS.md), [BEACONING](BEACONING.md),
  [DATAPATH](DATAPATH.md), [ESE](ESE.md), [UT-DRIVERS](../6.2/docs/UT-DRIVERS.md),
  [FIXED-SCHED](../6.2/docs/FIXED-SCHED.md), [BENCH](../6.2/docs/BENCH.md).
