# Биконинг в ucode 4.1.0.1000: лог, ATIM, телеметрия, WMI

Специфика 4.1.0.1000 в подсистеме распределённого биконинга: конвенция лога ucode, карта
функций 4.1, допуск к передаче пиру и живость пиров через ATIM, телеметрия MAC_MON (блок
счётчиков `0x854de0`), совместимость WMI 4.1 с mainline-драйвером.

Общая для 4.1 и 6.2 механика — конфигурация `CMD_BCON_MGT`, путь передачи маяка, рандомизатор
и его гейт, NAV-отсрочка, автомат BI, окно AW, состояние на железе — в
[../../docs/BEACONING.md](../../docs/BEACONING.md). Раскладка конфига `0x801438` и обработчик
команды 0x0B 4.1 — [BEACON-CONFIG.md](BEACON-CONFIG.md); патч гейта —
[DISTBCN-PATCH.md](DISTBCN-PATCH.md).

Ghidra-проект 4.1, сегмент uc_code @0x920000 (98500 Б, 568 функций, 28737 инструкций).
Уровень доказанности по умолчанию — **[код]**. Имена функций — по дереву `4.1/src/asm/uc/`
(в Ghidra-проекте — `FUN_00XXXXXX` по адресу).

## 1. Конвенция логирования ucode

```asm
mov  r5, 0x1002fd0        ; константа = 0x01000000 | <offset в ucode-таблице строк>
bmsk r5, r5, 0x13         ; оставить биты [19:0] → 0x02fd0
or   r4, r5, 0xa2000000   ; заголовок: модуль/уровень + число аргументов
st   r4, [r0]             ; записать слово в кольцо логов
```

* В инструкции лежит `0x01000000 | offset` — та же конвенция «полного указателя», что в fw,
  затем маскируется.
* Кольцо логов **`0x8020b0`** (записи по 4 Б), индекс **`0x80209c`**, маска разрешения
  **`0x8020a0`** (проверка `bbit0 r1,0x2` = бит 2).
* Аргументы кладутся в кольцо перед словом-заголовком; число аргументов — в старшем байте
  (0xa2 = 0 арг., 0xa6 = 1, 0xae = 3).

Покрытие: в ucode 4.1 — **237 call-sites / 130 различных строк** (из 331 в таблице); в ucode 6.2
— 151 строка в 155 местах (с учётом кодировки ссылок на строки в 6.2, см. [CROSS-VERSION-BEACON](https://github.com/klukonin/SparRAW-docs/blob/main/research/CROSS-VERSION-BEACON.md)). Инструмент: `SparRAW-tools/re/ghidra/uc_logmap2.py`.

В строках ucode есть путь сборки `/home/gatis/sdk/sparrow/fwsrc4/src` (`fwsrc4` — дерево исходников
v4). Обе прошивки несут билд-суффикс `.1000` (4.1.0.1000, 6.2.0.1000) **[гипотеза]**: обе собраны
MikroTik из Sparrow SDK с разными версиями SDK/флагами (в 4.1 распределённый слой скомпилирован
с отладкой).

## 2. Карта подсистемы 4.1 (по лог-строкам)

Функции, общие с 6.2 (развёртка маяка 0x923de0, ветка bi2 0x923c74, развилка 0x9311a4,
discovery_mode 0x934de4, установка AW 0x930770, воркер AW 0x925ea4, NAV 0x92a6f4, ворота BTI
0x931f8c), — в таблице адресов [../../docs/BEACONING.md §1](../../docs/BEACONING.md#1-адреса-по-версиям).
Прочие функции подсистемы в 4.1:

| адрес | имя | роль / исходник |
|---|---|---|
| 0x929738 | `l1_task__entry` | `L1_TASK PRE TBTT` (`l1_task.c`) |
| 0x9337c8 | `tx_initiator_flow` | `tx_initiator_flow()` — backoff, аборт по CCA/RSSI |
| 0x92ac60 | `perform_bti_pm_cfg` | `perform_bti_pm_cfg() - force wakeup` |
| 0x924434 | `calc_awake_tsf` | `calc_awake_tsf` |
| 0x932e00 | `beacon_tx__build_slot_bitmap` | `beacon_tx.c` |
| 0x9375ec | `bti_worker__collect_bf_metric` | вторая функция из `bti_worker.cpp` |
| 0x9264f0 | `get_tx_eligibility__precheck` | `get_tx_eligibility()` — допуск к передаче (§3) |
| 0x932488 | `traffic_deferral_cfg_cmd_handler` | обработчик LMAC 0x27 |
| 0x9285d4 | `bi_manager__rx_bi_flow` | обработчик результата передачи ATIM пиру (§4) |
| 0x9370b8 | `bi_window_transition_prep` | roll-up счётчиков в конце BI (§4, §5) |
| 0x92af4c | `perform_shallow_sleep` | `power_manager.cpp` — shallow sleep |
| 0x937b84 | `mtp_queue__release_mgmt` | MTP Queue / «no PEER availability for sta_id» |

Исходники ucode: `bti_worker.cpp`, `aw_worker.cpp`, `beacon_tx.c`, `nav_db.c`, `l1_task.c`,
`internal_tx.c`, `txrx_api_cmd_handler.c`, `power_manager.cpp`, `umac_if_cmd_handler.cpp`.

Диспетчер команд fw→ucode `umac_if_cmd_handler` @0x936dd0 и его таблица —
[../../docs/LMAC-PROTOCOL.md §1.2](../../docs/LMAC-PROTOCOL.md#12-приём-команды-в-ucode-код);
события ucode→fw — [../../docs/LMAC-PROTOCOL.md §4.1](../../docs/LMAC-PROTOCOL.md#41-таблица-41).

## 3. Допуск к передаче пиру — `get_tx_eligibility` @0x9264f0

```c
mask_active   = DAT_00801034;        // маска известных/активных пиров
mask_eligible = *(u32*)(ctx+0x134);  // маска «проснувшихся» пиров
// передавать пиру можно, если его бит в eligible; если он только в active — нельзя
```

Соответствует вендорским именам **[пак]** `m_peers_pm_eligibility_vec`, `peer_eligibility`.
Петля IBSS: ATIM анонсирует трафик → пир не засыпает → становится eligible → ему можно слать.
В 6.2 precheck «shallow sleep STA» удалён ([../../docs/DATAPATH.md](../../docs/DATAPATH.md)).

## 4. Живость пиров через ATIM

`bi_manager__rx_bi_flow` (0x9285d4) — обработчик результата передачи ATIM пиру:

```c
0x800918++;                                  // счётчик попыток
ok = decode(param_1, &peer_id, &kind);
res = bi_manager_rx_step(peer_id, kind);     // 0x921a48
if (res == 0) {                              // неудача
    power_manager(0x801ed0, 2, bit);
    0x80091a++;                              // tx atim fail  (→0x854e1a)
    *(u8*)(peer_id + 0x80063c) += 1;         // по-пировый счётчик неудач
} else {                                     // успех
    power_manager(0x801ed0, 1, bit);
    *param_1 &= ~bit;                        // снять pending
    0x800919++;                              // tx atim pass  (→0x854e19)
    *(u8*)(peer_id + 0x800644) += 1;         // по-пировый счётчик подтверждений
}
```

`kind` разделяет два класса (бит vs бит<<8) — **[гипотеза]** bcast vs unicast ATIM.

`bi_window_transition_prep` (0x9370b8) — roll-up в конце BI (по 8 пирам):

```c
for (i = 0; i < 8; i++) {
    if (acked[i]==0 && failed[i]!=0)          // 0x800644[i]==0 && 0x80063c[i]!=0
        if (++miss[i] > 10) {                 // 0x80064c[i] — подряд пропущенных BI
            lost_mask |= (1<<i);              // 0x80091d — маска потерянных пиров
            miss[i] = 0;
        }
    else miss[i] = 0;
    acked[i] = 0; failed[i] = 0;              // сброс на новый BI
}
publish_stats();                              // memcpy 0x854de0 <- 0x8008e0, 0x7c
```

Пир считается потерянным после **>10 BI подряд** без подтверждения ATIM; это питает
`bcons_atim_fail_vec` и fw-детектор `bad_beacons_detector.cpp`. По-пировые массивы (8 записей):
`0x80063c` (fail), `0x800644` (ack), `0x80064c` (подряд пропущенных); маска потерянных `0x80091d`.
Путь до разрыва связи и классы отказа ATIM —
[../../docs/STANDARD-MAPPING.md](../../docs/STANDARD-MAPPING.md#ati-и-механизм-atim).

## 5. Телеметрия MAC_MON 4.1

Общая схема отчёта MAC_MON и различия с 6.2 —
[../../docs/BEACONING.md §8](../../docs/BEACONING.md#8-отчёт-mac_mon-обе).

### 5.1. Дамп в fw — `lmac_if__mac_monitor_report` @0x8d865c

Дампит блок счётчиков (0x854de4..0x854e50) по событию `MAC_MONITOR_EVT`:

```
[BTI] | start time 0x%08x%08x | duration %d
[AW ] | start time 0x%08x%08x | duration %d
[NNL] | tx bcon %d | rx bcon %d | detected %d
[NNL] | bcon bitmap 0x%08x %08x
[NNL] | backoff %d | rx atim %d | bcons_atim_fail_vec 0x%x
[NNL] | tx atim pass %d | tx atim fail %d | tx atim counter %d
[NNL] atim_rx=0x%02x | bf_trigger=0x%02x | bcast=%d      (awake_peers__log @0x8dcdd8)
```

### 5.2. Раскладка блока счётчиков

База fw-видимого блока — **0x854d80**; публикуемая часть начинается с 0x854de0 (секция
`ucode_mac_monitor` dashboard, [DASHBOARD.md](DASHBOARD.md)).

| поле | адрес | примечание |
|---|---|---|
| **bcon bitmap lo / hi** | 0x854de4 / 0x854de8 | 64 бита |
| BTI start lo/hi, duration | 0x854dec / 0x854df0, 0x854df4 | |
| rx snr valid / rx snr | 0x854e00 / 0x854e04 | |
| **tx bcon / rx bcon / detected** | 0x854e08 / 0x854e09 / 0x854e0a | байты |
| AW start lo/hi, duration | 0x854e0c / 0x854e10, 0x854e14 | |
| backoff / rx atim / bcons_atim_fail_vec | 0x854e18 / 0x854e1c / 0x854e1d | |
| tx atim pass / fail / counter | 0x854e19 / 0x854e1a / 0x854e1b | |
| nav accum / backoff / cf end | 0x854e24 / 0x854e20 / 0x854e28 | |
| tx rts/rx cts/rx dts, rx rts/tx cts/tx dts | 0x854e2c.. / 0x854e32.. | |

Счётчики **двойно буферизованы**: рабочая копия — `0x8008e0` (0x7c байт), публикуется в конце BI
вызовом `memcpy_uc(0x854de0, &DAT_008008e0, 0x7c)` (0x920310; dst, src, len) внутри
`bi_window_transition_prep`. Источник двойного буфера — `0x80088c` / `0x8008b4` (шаг 0x28),
переключатель `DAT_008008dc`. Живые значения — по базе **0x8008e0** (смещения `+0x29` rx bcon,
`+0x2a` detected). Счётчики пишет ucode, fw только читает.

Живьём: AP `tx bcon/rx bcon/detected` = 63/0/0, станция 0/64/1 **[железо]**.

### 5.3. События, относящиеся к распределённому режиму

Из 19 событий ucode→fw 4.1 ([../../docs/LMAC-PROTOCOL.md §4.1](../../docs/LMAC-PROTOCOL.md#41-таблица-41))
к распределённому режиму относятся PS_AWAKE_PEER_EVT (0x16, пробуждение пира), MAC_MONITOR_EVT
(0x17) и PS_TRAFFIC_DEFERRAL_CFG_EVT (0x18, конфиг отсрочки трафика).

## 6. Сводка глобалов ucode 4.1

Глобалы конфигурации биконинга, NAV и AW — [../../docs/BEACONING.md](../../docs/BEACONING.md)
(0x801438, 0x80142c, 0x801450/0x801454, 0x800994…0x8009b0, 0x801eb8, 0x80202c/0x80202e,
0x800f60/0x800f6c/0x800f70). Прочие:

| адрес | смысл |
|---|---|
| 0x801034 | маска активных пиров (8 бит) |
| ctx+0x134 | маска eligible (проснувшихся) пиров |
| ctx+0x128 / +0x129 | битмапы состояний пиров |
| 0x800918 / 0x800919 / 0x80091a | ATIM: попытки / pass / fail |
| 0x80063c / 0x800644 / 0x80064c | по-пировые fail / ack / пропущенные BI |
| 0x80091d | маска потерянных пиров |
| 0x8008e0 | рабочая копия счётчиков (0x7c Б) |
| 0x801ed0 | контекст power_manager |
| 0x801eb8 | контекст AW |
| 0x8020b0 / 0x80209c / 0x8020a0 | кольцо логов / индекс / маска разрешения |
| 0x800c68 | индексная таблица команд ucode (рантайм) |
| 0x936e5e | база таблицы ветвления обработчиков |

## 7. Совместимость WMI 4.1.0.1000 с mainline-драйвером

Сравнение имён из таблицы строк fw 4.1 с `wmi.h` драйвера (backports-6.18.26); общий обзор WMI —
[WMI.md](../../docs/WMI.md).

| метрика | значение |
|---|---|
| WMI-имён в fw 4.1 | 102 (60 cmd + 43 event) |
| имён в `wmi.h` драйвера | 321 |
| общих | **90 из 102 (88 %)** |

В обоих присутствуют: WMI_CONNECT_CMDID, WMI_DISCONNECT_CMDID, WMI_PCP_START_CMDID,
WMI_PCP_STOP_CMDID, WMI_SET_SSID_CMDID, WMI_SET_PCP_CHANNEL_CMDID, WMI_READY_EVENTID,
WMI_CONNECT_EVENTID, WMI_DISCONNECT_EVENTID, WMI_SCAN_COMPLETE_EVENTID.

Размер структуры WMI_READY в 4.1 = **0x10**, в 6.2 = 0x14 (`operational_if__send_evt(evt, 0x1001, 0x10, ...)`,
0x8e0874).

### Числовые ID событий: 28/28 совпадений

ID извлечены из вызовов отправителя `operational_if__send_evt` @0x8e0874 (43 сайта) и сверены с
enum `wmi.h` (149 событий):

| ID | имя в драйвере | ID | имя в драйвере |
|---|---|---|---|
| 0x1001 | WMI_READY_EVENTID | 0x1865 | WMI_RING_EN_EVENTID (в fw 4.1 — WMI_VRING_EN_EVENTID) |
| 0x1801 | WMI_FW_READY_EVENTID | 0x1904 | WMI_TRAFFIC_SUSPEND_EVENTID |
| 0x1821 | WMI_VRING_CFG_DONE_EVENTID | 0x1905 | WMI_TRAFFIC_RESUME_EVENTID |
| 0x1823 | WMI_BA_STATUS_EVENTID | 0x1910 | WMI_P2P_CFG_DONE_EVENTID |
| 0x1824 | WMI_RCP_ADDBA_REQ_EVENTID | 0x1911 | WMI_PORT_ALLOCATED_EVENTID |
| 0x1825 | WMI_RCP_ADDBA_RESP_SENT_EVENTID | 0x1914 | WMI_LISTEN_STARTED_EVENTID |
| 0x1826 | WMI_DELBA_EVENTID | 0x1915 | WMI_SEARCH_STARTED_EVENTID |
| 0x1828 | WMI_GET_SSID_EVENTID | 0x1916 | WMI_DISCOVERY_STARTED_EVENTID |
| 0x182a | WMI_GET_PCP_CHANNEL_EVENTID | 0x1917 | WMI_DISCOVERY_STOPPED_EVENTID |
| 0x182b | WMI_SW_TX_COMPLETE_EVENTID | 0x1918 | WMI_PCP_STARTED_EVENTID |
| 0x1841 | WMI_TX_MGMT_PACKET_EVENTID | 0x1919 | WMI_PCP_STOPPED_EVENTID |
| 0x1842/43 | WMI_LINK_MAINTAIN_CFG_*_DONE | 0x191a | WMI_PCP_FACTOR_EVENTID |
| 0x1853 | WMI_RF_MGMT_STATUS_EVENTID | 0x9005 | WMI_ACS_PASSIVE_SCAN_COMPLETE |
| 0x1863 | WMI_NOTIFY_REQ_DONE_EVENTID | | |

`0x1865` — тот же номер при переименовании VRING→RING; **[гипотеза]** так же для VRING_BA_EN/DIS.

### Имена fw 4.1, отсутствующие в драйвере (12)

| имя | комментарий |
|---|---|
| WMI_PBSS_JOINED_EVENTID / WMI_PBSS_LEAVE_EVENTID | события Direct Connection (peer↔peer); драйвер их не знает и логирует как unknown; для peer-to-peer датапаса (per-peer VRING) их нужно обрабатывать в драйвере |
| WMI_TRAFFIC_DEFERRAL_CMDID/EVENTID | энергосбережение |
| WMI_VRING_BA_EN/DIS_CMDID, WMI_VRING_EN_EVENTID | старые имена BA/vring API |
| WMI_OTP_READ/WRITE, WMI_ESE_CFG, WMI_SET_LONG_RANGE, WMI_BRP_RF_CHAINS_LIMIT, WMI_DATA_PORT_CLOSE_EVENTID | прочие |

### События PBSS Direct Connection: ID 0x15 / 0x16

| событие | функция fw 4.1 | вызов отправителя | payload |
|---|---|---|---|
| WMI_PBSS_JOINED (Direct Connection) | `l2mgr__send_pbss_joined_evt` @0x8eea68 | `operational_if__send_evt(buf, 0x15, 0xc, mid,0,0)` | 12 Б: `[0]` — AID по разбору 4.1 (драйверный патч 913 читает его как индекс канала, как в `wmi_connect_event`; не сверено), `[2..7]`=MAC, `[8]`=networkType, `[9]`=CID |
| WMI_PBSS_LEAVE | `l2mgr__send_pbss_leave_evt` @0x8f0720 | `operational_if__send_evt(buf, 0x16, 10, mid,0,0)` | 10 Б: `[0..5]=MAC, [6]=networkType, [7]=CID` |

Длины (0xc / 10) совпадают с построенными структурами ⇒ 2-й аргумент — ID, 3-й — длина.
ID 0x15/0x16 лежат вне обычного диапазона событий (минимальные у драйвера — 0x200 и 0x1001) —
legacy-нумерация; в современном `wmi.h` событий `WMI_PBSS_*_EVENTID` нет (есть только константы
VRING/NWIFI-PBSS-переходов), номера 0x15/0x16 в пространстве событий драйвера свободны.

## Замечания

* `[NNL]` — лог-префикс продолжения строки (**[гипотеза]** «No New Line»), не подсистема; встречается
  по всей прошивке (`[NNL] rssi_raw_value`, `[NNL] rf_temperature`, `[NNL] invalid rf_id`,
  `[NNL] dwell_time`, `[NNL] channel[1]`, `[NNL] is_go` и т. д.).
* `bi_cfg__apply` 0x9331d8 фигурирует и среди 16 обработчиков команд
  ([../../docs/LMAC-PROTOCOL.md §1.2](../../docs/LMAC-PROTOCOL.md#12-приём-команды-в-ucode-код)), и
  как пересборщик BI-Control из ветки mode==2 обработчика 0x0B ([BEACON-CONFIG.md](BEACON-CONFIG.md)).
* Битмап соседей `bcon bitmap` — 64 бита, тогда как структуры ucode (AW, ATIM) ограничены 8
  пирами. Писателя у полей bitmap (+0x04/+0x08 отчёта) нет ни в прошивке, ни в микрокоде — только
  `memset` слота; единственный потребитель структуры, `bad_beacons_detector::handle_bcons_info`
  @0x8caeb4, работает по `detected` и SNR; `snr` в опубликованной копии считает прошивка из RSSI,
  который пишет ucode **[код]**.
* Номера событий ucode→fw 4.1 — по отправителям и диспетчеру fw (таблица полуслов 0x801b98),
  а не по порядку строк в таблице строк ucode.

## Не установлено

* Ветка «услышал чужой маяк → не передаю» вне NAV не локализована. Счётчики и флаги ucode
  адресуются через базовые регистры (`mov rX, base; st/ld [rX, off]`), поиск по абсолютным адресам
  их не находит. Подход — трекинг базового регистра (как для структур в
  [UCODE-TASKS.md](../../docs/UCODE-TASKS.md)) по `bti__bi2_event_step` 0x931f8c,
  `bti_worker_bi2_step` 0x923ba8, `bti_transmitter_bi2_flow` 0x923c74,
  `bti_worker__collect_bf_metric` 0x9375ec с базой 0x8008e0: инкременты `+0x29` (rx bcon),
  `+0x2a` (detected) и условие вокруг них. Факт учёта чужих маяков (rx bcon, detected) и
  NAV-отсрочка установлены.
* Механика `tx_initiator_flow` / `get_tx_eligibility` как модели доступа к среде; `aw_worker.cpp`.
* Точный маппинг cmd_id→обработчик (таблица `0x800c68` в ОЗУ).
* Длина WMI_READY 0x10 в 4.1 против ожиданий драйвера — на железе не проверялась.
