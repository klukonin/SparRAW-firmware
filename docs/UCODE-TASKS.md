# Микрокод: каркас задач, главный цикл и обмен с прошивкой

Как устроено исполнение в микрокоде (ucode): три слоя работы (L1 — события
интервала маяка, L2 — служебные события MAC, фон), главный цикл L1 в 6.2 и
общая память, через которую ucode обменивается с прошивкой (fw).

Метки: **[код]**, **[железо]**, **[гипотеза]**; пометки версии **[4.1]**,
**[6.2]**, **[обе]**. Адреса ucode — в пространстве ucode (host = 0x940000 +
(A − 0x800000)).

Смежные документы: тракт данных и TXOP — [DATAPATH.md](DATAPATH.md); автомат
BF — [BF-ENGINE.md](BF-ENGINE.md); протокол команд fw→ucode и событий ucode→fw —
[LMAC-PROTOCOL.md](LMAC-PROTOCOL.md); автоматы `basic_sm` —
[STATE-MACHINES.md](STATE-MACHINES.md); регистры R40..R56 —
[MAC-REGISTERS.md](MAC-REGISTERS.md); автомат BI, окна BTI/AW/DTI и развёртка маяка —
[BEACONING.md](BEACONING.md).

## 1. Три слоя [обе]

Планировщика в смысле fw `u_schd` у ucode нет. Работа идёт в трёх слоях.

### 1.1. L1 — события времени интервала маяка (высший приоритет) [4.1]

Четыре источника прерывания `uc_isr_l1_task0..3` → **`l1_task__entry`**
@0x929738 (572 Б, печатает `L1_TASK PRE TBTT`) **[код]**. Внутри:
`bi_manager__l1_entry_b`, `bi_manager__l1_rx_entry`,
`bi_manager__run_rx_flow_by_kind` (окна BTI/A-BFT/AW/DTI), `bi_ap_mon_if__trigger`,
`l1_bi_trigger_step`, `grant_detect_step`, `bf_sm__check_request_timeout`
(таймауты запросов BF), `power_manager__tick_if_elapsed`,
`l1_task__check_pending`, `l1_task__kick_and_dispatch`. События L1 — GP-таймеры
(биты r54); автомат BI ведут GP-таймеры. Путь L1 → DTI-передача —
[DATAPATH.md](DATAPATH.md) §3.1.

### 1.2. L2 — служебные события MAC [4.1]

`uc_isr_l2_task0..3` → **`l2_task__entry`** → `l2_task__report_error_bits`
@0x929974 (600 Б — разбор битов ошибок MAC, ассерты) и `l2_task__run` @0x929bfc
(712 Б — учёт энергопотребления: `power_manager__snapshot_marks`,
`__update_deltas`, `__scale_counters_ms`, TSF; `l2_task__kick_mac_events`).
Глобал `0x800608` **[код]**.

### 1.3. Фон — `background_task__dispatch` @0x921e2c [4.1]

Ожидающие задания — битовая маска **`0x800630`**, разрешённые — `[gp,0x60]`;
берётся **старший** бит, переход по таблице **uc_data 0x800ba0** (5 байт,
живьём `cb 06 0c 24 00`, база 0x921e80) **[код + железо]**:

| бит | ветка | действие |
|---|---|---|
| 4 | 0x921e80 | `l1_task__kick_and_dispatch` @0x925a08 |
| 3 | 0x921ec8 | `mac_mode__switch_sequence(0)` @0x925a50, если бит 1 `[0x886dd0]` сброшен (иначе ассерт) |
| 2 | 0x921e98 | `mac_mode__switch_sequence(1)`, если бит 0 `[0x886dd0]` сброшен |
| 1 | 0x921e8c | `rate_search__step` @0x92c05c ([BF-ENGINE.md](BF-ENGINE.md) §11) |
| 0 | 0x922016 | попадает в середину `mac_counter__program_3009` — вход, вероятно, не используется |

Бит снимается `rw_g_800630_921fb0` перед вызовом. Нет заданий →
`background_bi_step` @0x936bac (с запретом прерываний, `flag`). Фоновый
диспетчер BF `bf_sm__background_step` — [BF-ENGINE.md](BF-ENGINE.md).

### 1.4. Окно AW [4.1]

`bi_manager__on_aw` → `aw_worker__begin_window` → `aw__open_event_mask`,
`aw_worker__collect_awake_peers` @0x925ea4 (704 Б: сворачивает маски соседей,
`power_mngr_peer_update`, проверка AID), `sxd_hal__write_qset_field` (наборы
очередей на время AW), захват ресурса `uc_res_886f00__acquire`. Отсюда fw
получает `PS_AWAKE_PEER_EVT` (в живом логе «AWAKE PEERS EVENT») **[код]**.
Блоки окна AW обеих версий — [BEACONING.md §6.4](BEACONING.md#64-блоки-bi-bti-и-aw-микрокода).

## 2. Главный цикл L1 [6.2]

`l1_task__main_step` 0x92cae0 — событийный цикл по `r42`
(`6.2/ref/MSXD-LR-RGF.txt`) **[код]**:

* `bi1_event` (б4) — начало BI, счётчик `0x802ec0`, затем `l1_task__dispatch(0,0)`
  или вход в фиксированное расписание;
* `backoff_event` (б18) и `busy_event` (б19) — учёт времени
  `0x800634/0x800638` (+10 к `0x8010d8`, если прошло > 9 единиц) и
  `bi__dispatch_by_role`;
* режим фиксированного расписания (`gp-0x34` = 1/2) — свои автоматы
  ([../6.2/docs/FIXED-SCHED.md](../6.2/docs/FIXED-SCHED.md));
* на каждом шаге проверяется флаг **`0x800624`**.

**События L1 по битам r54 [обе] [код]:** 6.2 — `l1__on_event4` 0x92cd20: бит 15 →
квитирование MAC-командой 0x49 (0x49008000) и `l1_task__dispatch(4)`; бит 4 → квитирование
0x49000010 и таймер-объект 0x802f44 (`dti_alloc__dispatch` →
`dti_worker__scheduled_dti_allocation_event`); бит 17 → 0x49020000 и объект 0x802f80
(`ps__hold_awake_if_active`); иначе фатал 0x2c. 4.1 — ветка r54 в `l1_task__entry` 0x929738
(0x929900…: бит 15 → 0x49008000 и событие автомата BI AW_TO_DTI; бит 4 `service_period_0` →
0x49000010), листинг — [MAC-COMMANDS.md, приложение В.1](MAC-COMMANDS.md#в1-автомат-bi-микрокод-41).
`l1_fixed_sched__event_entry` 0x92cd94 (в том же блоке, отдельная функция) [6.2] — вход
фиксированного расписания: бит 15 → событие 4, бит 17 → событие 0, затем `l1_fixed_sched_ap_sm`
(если роль-переменная gp = 1) или `l1_fixed_sched_sta_sm`. `uc__check_g8004f4_0_1_2` 0x92cd0c —
вход из `l1_task__entry`.

**Каркас L1 [6.2]:** `l1_task__select_by_mode` 0x921840, `l1_task__check_ready` 0x928a48,
`l1_task__phase_of` 0x92b648, `l1_task__reset_units` 0x92ec50, `l1_task__kick_and_dispatch_uc`
0x927378 → `uc_queue__dispatch_and_commit` 0x92fb40 (4.1 0x92bd40), `l1_task__entry_uc` 0x92cae0,
`rx_flow__run_and_check_bf_abort` 0x926310 / `l1__rx_then_check_bf_abort` 0x92b6ac (RX-поток или
аварийный abort BF), `l1_task__mask_halt_req_and_defer` 0x9274e0 /
`l1_task__mask_wake_req_and_defer` 0x9274f4 (регистр 0x886d80), `phy__signal_gain_adc_in_range`,
`uc_irq_set_level` 0x921018 (4.1 0x9219b4), `bi_init__set_mac_arg_pair` 0x934e0c,
`power_mngr__stats_calc_delta` 0x92e6e8 / `power_mngr__stats_mark_base` 0x92e704 (сторож и тик
учёта питания).

Прочие блоки L1: `l1__snapshot_bi_counter` 0x9239dc, `l1__enter_fixed_sched`
0x92c7ec, `mac__set_slot_mask_924000` 0x9267d4, `l1__rx_then_check_bf_abort`
0x92b6ac, `bi__dispatch_by_role` 0x92b448, `phy__signal_gain_adc_in_range`
0x924f28, `uc_sm__handle_event` 0x92b6fc (шаг автомата ucode, запись таблицы 5
Б — формат `basic_sm`).

### 2.1. Путь «связь потеряна» из ucode **[код + железо]**

`l2_handle_watchdog` 0x92cf90 (сторож уровня прерываний) печатает «***
l2_handle_watchdog ilink1/ilink2» и «phy_fa_rate, txrx_state = gp+0xcc/+0xd0»,
сохраняет счётчики в `0x85701c/0x857020` и ставит `0x800624 = 1`;
`l1_task__report_link_lost` 0x928ab8 увеличивает счётчик в `0x80242c+0x20`, зовёт
`l1_task__dispatch(1)`, уводит ucode в простой (`uc_pm__enter_idle` 0x93c7d4; 4.1 0x936ca8) и
шлёт fw `uc_send_evt__link_lost` (6.2 0x927690, 4.1 0x925c40) для старшей станции маски
`0x802194` (или 8) со словом `0x8025dc`. Во всех трассах
стенда 6.2↔6.2 (оба узла, десятки окон) сторож не срабатывал ни разу —
LOST_LINK станции приходит от детекторов fw (`bad_beacons_detector`,
[../6.2/docs/BENCH.md](../6.2/docs/BENCH.md)).

### 2.2. Лог ucode [6.2]

`uc_log__emit3` 0x92d338 — запись лога ucode с тремя аргументами (кольцо
`0x803248`, индекс `0x803234`, заголовок `0xac000000 | метка`) **[код]**.

## 3. IPC fw ↔ ucode (общая память) [6.2]

Анализ по образу 6.2 (Ghidra, с именами функций fw) **[код]**.

### 3.1. Поверхность обращений ucode

| область | ссылок | различных адресов | функций ucode |
|---|---|---|---|
| `fw_data` (linker 0x80xxxx) | 1512 | **288** | **401** |
| MAC/периферия 0x88xxxx | 255 | 61 | 171 |

401 из ~716 функций ucode трогают `fw_data`: ucode — тесно связанный с fw слой,
а не изолированный тракт.

fw трогает 388 адресов `fw_data`, ucode — 288, **пересечение — 30**. Общая
память — узкое окно обмена; остальное у каждой стороны своё.

Протокол команд и событий (очереди, коды) — [LMAC-PROTOCOL.md](LMAC-PROTOCOL.md).

### 3.2. Общие переменные, охарактеризованные по именам fw-функций

| адрес (linker) | fw-функции | смысл |
|---|---|---|
| `0x80242c` | `stream_mgr::action` | поток/BA — 9 функций ucode, самая «горячая» с точки зрения ucode |
| `0x802224` | `calib_silent_rssi_sparrow::run_calibration_fragment` | калибровка silent-RSSI |
| `0x801a8c` | `hwd_rfc_read_calibrate`, `hwd_rfc_read_handle_driver_input` | обмен с RF-калибровкой |
| `0x80147c` | `maintain_sm::config_mcs_en_vec` | вектор разрешённых MCS (link maintain → ucode); см. замечание |
| `0x80114c` | `perform_first_measurement_operations` | первичные измерения |
| `0x800000` | `evt_table_ptr` | базовая таблица событий |

Самые «горячие» для ucode адреса `fw_data` вне пересечения (пишет только ucode):
`0x8022c8` (72 ссылки), `0x802288` (47), `0x801104` (36, таблица станций —
[../6.2/docs/RX-BRP-UC.md](../6.2/docs/RX-BRP-UC.md)), `0x8021e0` (34),
`0x802470` (31, очередь событий ucode→fw), `0x802610` (30), `0x80212c` (28),
`0x802978` (28, TX-контексты — [DATAPATH.md](DATAPATH.md)), `0x802f80` (28).

Кластер 0x802000–0x802600 (49 различных адресов) — **не массив колец**: шаг
адресов нерегулярный (12, 8, 16, 32, 4, 28 …), равномерной сетки `base +
i*stride` нет; это набор отдельных глобалов. Кольца, вероятно, адресуются через
указатель-контекст с индексной адресацией.

### 3.3. MAC/PHY-регистры, которыми управляет ucode (топ)

`0x889480` (34) и `0x889488` (14) — PHY; `0x886d00` (24), `0x886d80` (17),
`0x886a00` (13), `0x886500` (12), `0x886000/886800/886e00/886f00` — блоки MAC;
`0x887000` (14), `0x883000` (10), `0x889000/889800`, `0x880800`, `0x881000`.

Терминология тракта из лог-строк ucode: `PRING` / `SW_HEAD_4_RD` / `sw_head` /
`sw_head4read` (указатели колец), `PTP` и `PFIFO2` (конвейер TX), `Vring
disconnect flow timeout`, `dma_is_idle` / `dma_is_tx_pipe_idle`, `QH Write while
DMA is open (qid %d)`, `MTP Queue is empty`, слоты
`dti_worker::scheduled_dti_allocation_event`.

### 3.4. Размеры структур по примитиву init(addr, size)

`FUN_00920a84(&global, size)` — примитив инициализации/очистки; 39 вызовов дают
размеры глобальных структур ucode:

| адрес | размер | поля (трекинг) | польз. |
|---|---|---|---|
| `0x800814` | 0x10 | +0,+2,+4,+6,+8,+a,+c,+e — все u16, плотный массив (вектор параметров) | 3 |
| `0x801084` | **0x80** | крупнейшая в fw_data | |
| `0x802110` | 0x1c | +0,+1,+10,+14,+18 | 4 |
| `0x80212c` | 0x0c | +0,+1,+4,+8 … +68(13),+69 — выходит за 0xc: init чистит только заголовок | 22 |
| `0x8021e0` | 0x18 | **+0 (43 обращения)**,+c,+12,+14; маски `\| 0x600`, `\| 0xa00` — поле флагов | 12 |
| `0x802210` | 0x18 | +0,+4,+8,**+c**(7),+14 | 7 |
| `0x802a14` | **0x58** | +0,+4,+8,+c,+10,+54 | 4 |
| `0x802a6c` | 0x24 | +0,+8,+10,+14,+18,+20,+22 | 7 |
| `0x802f14` | 0x1c | +0..+8 побайтно, далее +c..+2e — упакованный битовый заголовок | 15 |
| `0x802f32` | 0x02 | | |
| `0x8576ac` | 0x84 | вне fw_data — отдельная область | |

Из восьми структур с известным размером и размеченными полями шесть укладываются
в размер полностью — перекрёстная проверка обоих методов.

Смысл отдельных полей, установленный позже по коду: `0x8021e0` — флаги приёма
SLS (бит 0 ISS соседа, 1 развёртка соседа окончена, 2 SSW-Feedback, 3 SSW-ACK,
4 RTS), `0x80212c`/`0x80212d` — лучший сектор/антенна RSS — см.
[BF-ENGINE.md](BF-ENGINE.md) §8.

### 3.5. Структуры без известного размера

| база | польз. | характер |
|---|---|---|
| `0x8022c8` | **51** | центральный контекст ucode (§3.6) |
| `0x801030` | 15 | крупная: массив u32 на +0x50…+0x90 (шаг 4, ~16 записей; per-queue/per-chain таблица — гипотеза), до +0xd0 |
| `0x802940` | 17 | 12 байт: +0 (14), +4, +8 (+0 — набор RF для TX, +4 — для RX, см. [BF-ENGINE.md](BF-ENGINE.md)) |
| `0x801024` | 16 | +0 (13 обращений), +8 — по сути одно горячее поле (текущая конфигурация приёма) |
| `0x8014a4` | 17 | доминирует +0x1c (16 обращений); также +0x10,+0x14,+0x18,+0x20 |
| `0x8021b8` | 11 | побайтовые поля +8,+9,+a,+b (упакованный массив байт), далее u32 до +0x24 |
| `0x80216c` | 4 | +0x1c,+0x1e,+0x20 (по 6 обращений) |
| `0x80207c` | 8 | +0x34 (11), +0x40 (10), +0x44 (6) |
| `0x802f80` | 18 | разрежённая, до **+0x179** — самая большая |
| `0x802470` | 30 | сборка сообщения (§3.7) |
| `0x802288` | | переменная-указатель: грузится значением (`ld r0,[0x802288]`) и передаётся первым аргументом (`FUN_0092b254(ptr,10)`, `FUN_009357cc(ptr,0)`) |

### 3.6. Центральный контекст `0x8022c8`

Передаётся по адресу (`mov rN, 0x8022c8`) в 51 функцию. Синглтон, размер ≈
**0x80 байт** (следующий отдельно адресуемый глобал — `0x802348` = `0x8022c8 +
0x80`); 29 полей:

| смещение | ссылок | доступ | трактовка |
|---|---|---|---|
| `+0x00` | 14 | почти только `ld` | конфиг/указатель (пишется один раз) |
| `+0x04` | 11 | ld/st поровну | изменяемое состояние |
| `+0x0c` | **34** | ld 17 / st 17 | самое горячее — счётчик или head/tail |
| `+0x14` | 16 | ld 8 / st 8 | изменяемое состояние |
| `+0x1c`, `+0x1e` | 3+1 | `ldw_s` (16 бит) | пара u16 |
| `+0x3c` | **24** | ld 12 / st 12 | второе по горячести изменяемое поле |
| `+0x40`, `+0x44` | 5, 8 | смешанный | |
| `+0x60 … +0x80` | по 2 | ld/st парами, шаг 4 | массив ~9 × u32 |
| `+0x8b` | 1 | `ldb` | байтовое поле |

### 3.7. `0x802470` — сборка сообщения

Доступ через аксессор `FUN_00920d4c(0x802470)` (30 функций). Это очередь
событий ucode→fw (`uc_evt__enqueue`, [LMAC-PROTOCOL.md](LMAC-PROTOCOL.md)).

| смещение | доступ | трактовка |
|---|---|---|
| `+0x00` | `st_s` ×9, `stb_s` ×3, `stw_s` | заголовок, заполняется с разной гранулярностью |
| `+0x01` | `stb_s` ×2 | байтовое поле |
| `+0x02` | `stw_s` ×2 | u16 |
| `+0x04` | `st_s`/`stw_s` | |
| `+0x08` | `ld_s` | чтение |
| `+0x58`, `+0x5c` | `st_s` | хвост (структура ≥ 0x60) |

### 3.8. Метод

* Размеры: все вызовы `FUN_00920a84(&g, size)`.
* Поля: трекинг `mov rN,<base>` → сбор `ld/st [rN,off]` в окне 12 инструкций, с
  жёсткой инвалидацией регистра при любой его перезаписи и на любом вызове.
  Применим к любому глобалу fw и ucode.

## 4. Вектора прерываний, загрузка, аварийный путь [обе]

### 4.1. Таблица векторов **[код]**

Таблица векторов ucode — 20 переходов по 8 байт с 0x920000 в обеих версиях (`j <обработчик>`);
номер вектора N — адрес 0x920000 + 8·N.

| N | 4.1 | 6.2 | назначение |
|---|---|---|---|
| 00 | `uc_reset_init` 0x920140 | `uc_vector_00` 0x920160 | сброс |
| 01 | `uc_isr_memory_error` 0x921548 | `uc_vector_01` 0x9208f8 | трактовки расходятся (ниже и «Не установлено») |
| 02 | `uc_isr_instruction_error` 0x921170 | `uc_vector_02` 0x9204bc | «Bad instruction (action point %X)» (ARC action point) с дампом стека `uc_sysassert__scan_stack` 0x92635c «stack dump %08x-%08x» |
| 03 | `uc_isr_l1_task3` 0x928a9c | `uc_vector_03` 0x92b89c | L1 → `l1_task__entry` |
| 06 | `uc_isr_l2_task0` 0x921374 | `uc_vector_06` 0x9207b8 | L2 → `l2_task__entry` |
| 07 | `uc_isr_l2_task3` 0x928b38 | `uc_isr_l2_task3` 0x92b938 | L2 |
| 08 | `uc_isr_l1_task0` 0x921410 | `uc_isr_l1_task0` 0x9207c0 | L1 |
| 09 | `uc_isr_l1_task1` 0x9214ac | `uc_vector_09` 0x92085c | L1 → `l1_task__entry` |
| 10 | `uc_isr_l2_task1` 0x921180 | `uc_vector_10` 0x9205c4 | L2 → `l2_task__entry` |
| 12 | `uc_isr_l1_task2` 0x921220 | `uc_isr_l1_task2` 0x920664 | L1 |
| 14 | `uc_isr_l2_task2` 0x9212c0 | `uc_isr_l2_task2` 0x920704 | L2 |
| 04, 05, 11, 13, 15–18 | `uc_isr_vec04/05/11/13/15/16/17/18` (0x92136c, 0x921370, 0x92121c, 0x9212bc, 0x92135c…0x921368) | `uc_vector_04/05/11/13/15/16/17/18` (0x9207b0, 0x9207b4, 0x920660, 0x920700, 0x9207a0…0x9207ac; `uc_vector_16` 0x9207a4, `uc_vector_17` 0x9207a8) | пустые возвраты |
| 19 | `uc_isr_vec19` 0x9380a4 | `uc_vector_19` 0x93eca4 | — |

`l1_task__entry`: 4.1 0x929738, 6.2 0x92c974; `l2_task__entry`: 4.1 0x929ec4, 6.2 0x92d010.
Вектор 01 в 6.2 по соседям — сброс/старт **[6.2]**: `boot_uc__init_g800610` 0x920a10 →
`bi_mode_init_sequence` (6.2 0x9365fc, 4.1 0x93171c), `boot_uc__init_tail` 0x9215b8;
`boot_uc__init_more` 0x92aedc; обёртка `uc__init_globals` 0x92094c чистит BSS перед стартом.

### 4.2. Загрузка **[6.2]**

`boot_uc__init_structs` 0x920114 (списки по приоритету — `uc_list__insert_by_prio` 0x920a00;
4.1 — `uc_boot__init_list_80095c` 0x920114, `uc_list__insert_by_prio` 0x9215fc),
`boot_uc__set_88000c` 0x92a6e4, `bf_pending__clear_bit` 0x921750. Action points:
`arc__program_action_point` 0x920f10, `arc_protect_addr_uc` 0x920fb4 (включается командой 0x41
Long Range — сторож записи в память).

Подъём железа из ucode:

* DMA MAC — три окна конфигурации: `dma_mac__cfg_880c14` (6.2 0x929424, 4.1 0x926c68),
  `dma_mac__cfg_880c28` (0x92961c / 0x926e8c), `dma_mac__cfg_880c2c` (0x9298f8 / 0x927250);
  `hwd_dma__set_mode_map` (0x929150 / 0x926bc0) **[обе]**; `hw__bring_up_phy_dma` 0x92a980 [6.2].
* PHY: `hwd_phy_init__2` (0x929684 / 0x926ef4), `hwd_phy__set_mode_uc` (0x9299d8 / 0x927340)
  **[обе]**; `hwd_phy_pwr` 0x9297f0, `hwd_phy__uses_rgf_881000_9296e0`,
  `hwd_phy__uses_rgf_881000_929730`, `hwd_phy__uses_rgf_883000` 0x929960,
  `hwd_phy__uses_rgf_884000` 0x92999c, `hwd_phy__uses_rgf_883800_929af4`,
  `hwd_phy__uses_rgf_883800_929b94`, `phy__read_signal_gain_adc_db_sfd_locked` 0x929b84,
  `phy_params__snapshot` 0x93cedc (параметры PHY принятого PPDU) [6.2].
* РЧ [6.2]: `hw__power_sequence_rf` 0x92ab40, `hw__power_step` 0x929eec,
  `hwd_rfc_powerup_deep_all_rfs` 0x92a0a0 / `hwd_rfc_powerdown_deep_all_rfs` 0x929fa0,
  `hwd_rfc_read_rgf_uc` 0x92a1cc, `rf_utils_auto_fill_uc` 0x92ed84 (580 Б — автозаполнение
  регистров RF по шаблону) с проверкой `hwd_rfc_auto_fill_verify` 0x93e7c4 и шагом
  `rf_utils__fill_step` 0x929f34, `rfc__issue_cmd_20_uc` 0x92f8c8, `rfc__clear_core_reg1` 0x929f94.

### 4.3. Аварийный путь **[код]**

`uc_sysassert` — 4.1 0x925548, 6.2 0x926618. Общие блоки: `uc_sysassert__emit_mac_trace`
(6.2 0x92f2f0, 4.1 0x92b7f8), `uc_sysassert__snapshot_mac` (0x93756c / 0x9325e4),
`uc_sysassert__idle_hist` (0x926478 / 0x92522c; «IDLE SM histogram on SYSASSERT» — гистограмма
состояний простоя). Только 6.2 по имени: `uc_sysassert__write_code` 0x929d04,
`mailbox_debug_dump_uc` 0x92d608, `dump_pring_hw` 0x9291d8 («PRING: hw_head hw_tail»).
Сторож L2 — `l2_handle_watchdog` 0x92cf90 (§2.1).

Очередь событий к fw 6.2: `list__push_locked` 0x926984, `evt_queue__take_locked` 0x926a3c;
`bf_req__claim_and_report_2b` и `bf_req__claim_and_report_23` — отправка событий через
`uc_evt__send_2b` 0x92783c / `uc_evt__send_23` 0x92787c ([LMAC-PROTOCOL.md §5.3](LMAC-PROTOCOL.md#53-события-62)).

Таблицы-диспетчеры ISR 6.2: `bf_sm__run_sta` 0x921940 (кадр по слоту STA —
`bf_sm__dispatch_by_state`), `txss__sweep_duration_for_sta` 0x939cfc (internal TX ISR),
`bi__bti_timer_step` 0x92e7c8 (L1 dispatch по TSF).

## Замечания

* `0x80147c` в 6.2 описан двумя способами: как вектор разрешённых MCS (по
  fw-функции `maintain_sm::config_mcs_en_vec`) и как TA продления NAV (по
  `rx_nav__set_from_duration`, [DATAPATH.md](DATAPATH.md) §3.4).
* Кластер 0x8021xx–0x8024xx не является массивом дескрипторных колец (§3.2).

## Не установлено

* Бит 0 фонового диспетчера 4.1 (вход 0x922016) — используется ли.
* Поля `0x8022c8`: какие из горячих (+0x0c, +0x3c) — индексы/счётчики чего.
* Связь `qid`/`pring_idx` из лог-строк с конкретными смещениями.
* Как `dti_worker` получает расписание от fw (кандидат-источник —
  `schedule_scheme_builder::build_allocations_from_beacon`).
* Каркас L2 и фона в 6.2 — не сверен с 4.1 построчно.
* Назначение вектора 01: в 4.1 его обработчик назван `uc_isr_memory_error`, в 6.2 блок 0x9208f8
  по соседям описан как сброс/старт — какая трактовка верна, не сверено.
