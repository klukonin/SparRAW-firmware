# Тракт данных: передача и приём (4.1 и 6.2)

Путь кадров данных и управления между кольцами хоста, аппаратными очередями
MAC, микрокодом (ucode) и прошивкой (fw) в обеих версиях. Отдельно описан
запрет передачи по CID на время beamforming — механизм, которым BF
останавливает юникаст.

Метки: **[код]** — по листингу (адрес инструкции), **[железо]** — измерено на
стенде (пара узлов 4.1, только чтение, либо пара 6.2↔6.2), **[пак]** —
имя/раскладка из вендорского пака 11ad, **[гипотеза]**. Пометки версии:
**[4.1]**, **[6.2]**, **[обе]**; адрес без пометки относится к 4.1.

Адресация с хоста: fw_data host = 0x900000+(A−0x800000), fw_peri host =
0x908000+(A−0x840000), uc_data host = 0x940000+(A−0x800000); регистры 0x88xxxx
читаются по своему адресу. gp ucode = 0x800528 **[обе]**, gp fw 6.2 =
0x800184.

Смежные документы: каркас задач ucode и IPC — [UCODE-TASKS.md](UCODE-TASKS.md);
автомат BF, BRP, SLS — [BF-ENGINE.md](BF-ENGINE.md); приёмный тракт ucode 6.2
(контекст станции, захват, замеры) — [../6.2/docs/RX-BRP-UC.md](../6.2/docs/RX-BRP-UC.md);
MAC-команды и кольцо команд — [MAC-COMMANDS.md](MAC-COMMANDS.md); тела
LMAC-команд — [LMAC-PROTOCOL.md](LMAC-PROTOCOL.md); регистры R40..R56 —
[MAC-REGISTERS.md](MAC-REGISTERS.md).

## 1. Архитектура

Данные **не проходят через процессоры**. Хост кладёт дескрипторы в кольца
(vring) в своей памяти и пишет регистр-хвост; **DMA** перекладывает пакеты в
**аппаратные очереди MAC (qid)** — номер очереди стоит в самом дескрипторе
(`d0[16..20]`) и в 4.1 равен индексу vring. Какая очередь передаётся, решает
**железо MAC**: backoff CBAP (EDCA-подобные движки, параметры задаёт ucode) и
**наборы очередей qset** — маски qid в регистрах 0x886d8c+4·i, которые
публикует ucode. ucode (второй ARC) управляет TXOP: получает событие «backoff
истёк», читает выбранный qid, открывает TXOP (RTS/Self-CTS или сразу),
запрашивает у передающего процессора **MTP** голову очереди и разрешение, ждёт
ACK/BA; окна Block Ack ведёт аппаратный **BAP**. fw (первый ARC) —
управляющая плоскость: WMI от хоста, привязка кольца к CID/TID (`STREAM_MGR`,
`vring_schd`, `sm_pring`), LMAC-команды в ucode (конфиг очереди 0x08, EDCA 0x04,
диапазоны 0x07, запуск BF 0x09 и т. д.), управляющие кадры fw (`tx_api`, свои
DMA-очереди), BA-переговоры, детекторы старения/keep-alive.

Приём зеркален: MAC-разборщик по правилам (фильтры адреса/типа) раскладывает
MPDU по RX-очередям; данные уходят DMA прямо в RX-кольцо хоста, управление и
Action — в RX-пул fw и дальше хосту событием WMI или внутренним обработчикам;
немедленный ACK/BA-ответ формирует ucode за SIFS.

Архитектура тракта fw в 6.2 та же, что в 4.1 (планировщик колец, STREAM_MGR,
FWQ, TX_API, BA-автоматы, разбор кадров управления); изменения точечные
(§6, §8) **[код]**.

## 2. Аппаратная модель, на которую опирается ucode [обе]

* **Очереди MAC (qid 0..31)** наполняются DMA из колец хоста: поле QID
  дескриптора `vring_tx_dma.d0[16..20]` (драйвер `txrx.h`) — «в какую очередь
  MAC положить пакет». В 4.1 **qid = индекс vring** (fw `vring_schd__add_vring`
  @0x8c276c печатает `V-ring #%d … mac_qid=%d` одним и тем же r18) **[код]**.
  qid 31 — внутренняя очередь ucode (internal TX), 25/26 — служебные (sta 8 =
  broadcast) **[железо]**.
* **MTP** (вендорское сокращение без расшифровки в паке; по полям — передающий
  процессор MAC) держит голову каждой очереди: регистр `MTP_Q_AVAIL` (R41[11],
  у fw — 0x886f9c) = какие очереди непусты; запрос `0x16 (qid<<16|1)` + `0x17…`
  возвращает в R43 `MTP_QUERY_RESPONSE_1` {query_type, packet_mode, dest_id,
  nid, ack_policy, mcs, source_index, aggregation_enabled, valid[31]}
  **[пак+код: `mac__program_tx_with_qid` @0x92a36c, ожидание `r43` бит 31
  @0x934926]**. Разрешение на передачу — команда `0x19…` и ответ R45
  `MTP_TX_PERMISSION_RESP` {null_status[7:0], max_retry, retry_val, mng_data,
  bcq_ucq, valid[31]} **[пак+код: @0x93493c, @0x9349c6]**; конец — R46
  `MTP_TX_END_RESPONSE` {duration, tx_queue, internal_tx, bar_tx, null_tx,
  internal_tx_type}.
* **BAP** (Block Ack Processor — по полям `bap_tx_update_ind`,
  `bap_rx_update_ind`, `bap_rel_done_ind`, `bap_discard_mpdu_cnt`) **[пак,
  расшифровка — гипотеза]** — ведёт окна BA в железе; `BAP_Q_AVAIL` (R41[12], у
  fw 0x886548).
* **Наборы очередей (qset 0..7)**: маски qid в регистрах **0x886d8c + 4·i**
  (R41[3..10] `QSETn_MASK_VECTOR` в паке) **[пак+железо]**. Поиск: MAC-команда
  `0x0f000001`, затем R41 `QUEUE_SEL_STATUS` {lowest_queue_set_found 8..11
  (1-based, 0 = нет), qid 16..21}. Назначение наборов в 4.1 **[код+железо]**:

  | qset | тень | кто пишет | содержимое на стенде |
  |---|---|---|---|
  | 0 | — | — | 0xffffffff |
  | 3 | — | `rx_funcs__rx_flow` @0x92f40c/@0x92f71c — очереди соседа, от которого только что принят кадр (ответчик/RD) | 0x2 |
  | 4 | 0x800414 → 0x800a28 | LMAC 0x08 тип 0/1 (+0x10 соседа); LMAC 0x07 диапазоны | 0x06000000 |
  | 5 | 0x80041c → 0x800a2c | +0x18 соседа | 0 |
  | 6 | 0x800424 → 0x800a30 | LMAC 0x08 тип 3 = данные (+0x14 соседа) | 0x1 |
  | 7 | 0x800a34 | internal TX (qid 31), включается при pending | 0 / 0x80000000 |

  Включение 4..6 — маска `[gp-0x74]` = 0x8004b4 (=0x70), бит 7 —
  `mac__enable_qset_bit7` @0x928e38 при первом pending-бите; публикация —
  `mac__publish_masks` @0x9373b0 **[код]**. Адреса 6.2 — в §8.
* **CBAP/EDCA в железе.** LMAC 0x04 (fw `lmac_if__build_cmd_0x04` @0x8d8d30,
  4 записи по 12 Б {ac, cwmin_exp, cwmax_exp, aifsn=2}) → `txrx_api_step_c`
  @0x9319e8: `[0x886d68+4·ac] = aifsn<<28 | 0x1ff`, `[0x886d78+4·ac] =
  0xc0adc0ad<<ac` (затравка ГПСЧ backoff — гипотеза), MAC-команда
  **`(0x09+ac)<<24 | (2^cwmin−1)`** — окно CW движка ac; `0x800ac8+4·ac =
  {cwmin, cwmax, cw}` **[код]**. Профили fw: 0x800b1c {4,4}, 0x800b20 {4,7},
  0x800b24 {1,1} (для ac 0 min(·,4)), выбор по аргументу 0/1/2 от
  `wmi_handler_bcon_ctrl`, `pcp_start`, `conn_main_sm__linkup_ntf` **[код]**.
  Удвоение CW при неудаче — `tx__pick_slot_for_peer` @0x924db8 (r0≠0:
  `cw=min(cw+1,cwmax)`, иначе `cw=cwmin`, команда `0x09+ac`) — имя не отражает
  назначение (§10) **[код]**. Живое: `0x800ac8 = 04 04 04 | 04 07 04 | 04 07 04 |
  04 07 07` **[железо]**.

## 3. Микрокод: цикл DTI-передачи

### 3.1. 4.1 (CBAP)

1. Истечение backoff в железе → событие → `l1_task__entry` @0x929738 →
   `bi_manager__l1_rx_entry` @0x928534 (`[ctx+0x38]`: 1 = TX, 2 = RX-поток) →
   `bi_manager__start_tx_or_initiator` @0x928588 → `bi_tx_initiator_wrap`
   @0x932844 (счётчик TXOP `0x801458+0`) **[код]**. Каркас L1 —
   [UCODE-TASKS.md](UCODE-TASKS.md).
2. `tx_initiator_flow` @0x9337c8: слот контекста `tx_ctx__next_slot` @0x933414
   (два слота по 0x30 в **0x801a18**, текущий в +0x60, счётчик +0x68; поля: +0
   cid, +4 qid(0xff), +0xc флаги, +0x14 маска режима, +0x18=0xf, +0x1c, +0x20,
   +0x24 channel_access, +0x28 rx_awv (из 0x80087c), +0x2c) — совпадает по
   смыслу с вендорской `ucode_txrx_tx_context_s` (флаги +0xc: бит 0
   context_valid, 1 bap_release, 3 no_imm_response, 8 response_only — сверено
   по употреблению) **[код+пак]**.
3. `tx_initiator__build_tx_vector` @0x933e90 — qid из R41 (§2); qid 0x1a —
   особый; иначе `get_tx_eligibility__precheck(sta_id=[0x801132+3·qid])`
   («Abort Tx to shallow sleep STA», @0x9337fe) **[код]**.
4. CCA/энергия → «Check for busy2 (CCA)… abort» (`0x801458+4`).
5. qid 31 (@0x933942 `breq r1,0x1f`) → `internal_tx__pending_sm` @0x928e68: sm
   = старший бит (`0x800674` pending & ~`0x80067c` pm_denied): **1** — заглушка
   в 4.1, **2** — `internal_tx_step` @0x9339f0 (keep-alive: сосед из `[gp,0x13]`
   через `tx__take_eligibility_slot` @0x926354, счётчики `0x857838+0x14·cid`
   +0 u16 KA, +9 KA-fail), **3** — beamforming (`bf_sm__step_by_state`,
   проверка @0x928edc `brne r14,0x3`) **[код]**.
6. qid широковещания: ветка по qid == `[gp-0xc4]` (0x800464, bcast qid)
   @0x933946 → лог «tx_bcast_flow», `tx_rate_select_and_program` **[код]**.
7. qid данных → `tx_initiator_step` @0x93466c → `txop_initiator_open_txop_flow`
   @0x934884: режим MAC 3, `mtp_queue__release_mgmt` (запрос к MTP;
   mgmt-кадр к недоступному соседу сбрасывается: «Released one management
   frame due to no PEER availability»), затем по `ctx+0x24`: 0 — сразу, 1 — RTS
   (`direct_tx__program_cmd34(0x10)` + `mac__program_tx_with_rate`), ожидание
   CTS; `0x19000b00|…` — разрешение MTP; `txop__open_window` @0x93409c (режим
   0xa, `0x19000001`, `0x1b|0x18|0x0e…`); «TRUE TxOP opened (sent RTS/Self-CTS)»
   **[код]**.
8. Внутри TXOP: `tx_initiator_substep` @0x934354 / `tx_flow_size_step`
   @0x93448c крутят `tx_flows__program_mac_tx` @0x933568 (MPDU/A-MPDU из MTP:
   `0x37…`, `0x3f`+TX-вектор соседа `[0x801198+0x48·cid]`, `0x1b001111`, запрос
   `0x16 qid`, `0x17`), `tx_mtp_queue_gate` @0x93413c, ожидание `tx_end` (бит
   15) и `rx_frame` (бит 14) — ACK/BA **[код]**.
9. Итог: `tx_initiator_step` @0x93475c..: счётчик неудач соседа
   `0x857838+0x14·cid+0x10` ≥ порога `[0x8010e8+0x14/0x16]` → бит 2
   (`MAX_CTS_FAILURE_IN_TXOP`) в байте причин BF (при `[gp,0xb8]` бит 2), иначе
   счётчик = 0; затем `bf__trigger_if_pending` (@0x93479e) — точка, где данные
   переходят в режим «ждём BF» (§7) **[код]**. `tx__pick_slot_for_peer` —
   обновление CW.

Завершение для хоста: дескриптор возвращает DMA (бит DU в
`vring_tx_dma.status`), ucode в этом не участвует **[гипотеза, по отсутствию
обращений ucode к кольцам хоста]**.

### 3.2. 6.2: CBAP и фиксированное расписание

`fixed_sched__run_tx_slot` @0x93768c разводит потоки по `[gp,-0x34]`
(@0x937700..0x93770a): 0 → CBAP `tx_slot__dispatch` 0x938e34 (в корреляции —
`macreg_r42__938e34`, аналог `tx_initiator_flow`), иначе
`tx_initiator_flow_fixed_scheduling` @0x938f10 **[код]**. Поток fixed
scheduling выбирает qid по MTP_Q_AVAIL ИЛИ BAP_Q_AVAIL (R41 селекторы 0xb/0xc),
старший qid 0..9 — **мимо qset-масок** **[код]**. Расписание — см.
[../6.2/docs/FIXED-SCHED.md](../6.2/docs/FIXED-SCHED.md).

`tx_slot__dispatch` 0x938e34 увеличивает счётчик `0x8022cc`, если в момент
выбора очереди взведён `r42.busy2_event` (фаза 0x800, парный счётчик
`0x8010f4`) **[код]**. Широковещание — отдельная функция `tx_bcast_flow` по qid
`[gp,-0xc0]` @0x938e9c. Precheck «shallow sleep STA» удалён.

Контексты передачи 6.2 — `tx_ctx__alloc_next` 0x9384d4: двойной буфер
`0x802978 + 0x3c·k`, текущий в `0x8029f0`; при выделении для станции
загружается текущая конфигурация приёма `0x801024` (подробно —
[../6.2/docs/RX-BRP-UC.md](../6.2/docs/RX-BRP-UC.md) §3).

### 3.3. 6.2: открытие TXOP и CTS **[код]**

`txop_initiator_open_txop_flow` 0x93a250: способ доступа к каналу — RTS, если
бит станции в `0x802948`, иначе `ctx[10] & 3`
(`ucode_txrx_tx_context_channel_access_e`: 0 немедленно, 1 RTS, 2 self-CTS, 3 по
мощности). Для RTS нужно ≥ 0x31 единиц до конца периода (`R40` — остаток),
иначе фаза `0x8000` и счётчик **`0x8022e8`**; RTS уходит в эфир, при срыве
передачи — счётчик **`0x8022e4`**. Затем `txop__await_cts_ppdu` 0x9399a4 (в корреляции `uses_g_801be8__9399a4`):
«CTS получен» = нет `busy2_event` (`r42` б14) и есть `cca_ppdu_comp`
(`R40[10] PHY_SIGNALS` б24) — **чисто физическая проверка: принят какой-то
PPDU в окне ответа**, отправитель не сверяется. Нет — фаза `0x800` и счётчик
**`0x8022cc`** (TXOP не открыт). Успех — MAC `0x27004000 | …`, роль `gp+0xcc =
2`, счётчик **`0x8010de`** (TXOP открыт).

Счётчики `0x8022cc`/`0x8022e4`/`0x8022e8`/`0x8010de` читаются с хоста
(`mem_addr` host `0x94xxxx`). `0x8022cc` растёт и в `tx_slot__dispatch` (§3.2),
поэтому мерой именно отказов CTS не является; различать по `0x8010f4`.

**Ответ на RTS:** `rx__send_dmg_cts` 0x936320 — программная отправка DMG CTS
через `tx__send_imm_response` 0x9385d8: длительность = Duration принятого кадра
− 0x14, длина 0x17, тело MAC `0x33000063`; **счётчик отправленных CTS
`0x8022f4`**. Вместе со счётчиками инициатора (`0x8022cc`, `0x8010de`) даёт
проверку, отвечает ли узел на RTS и слышит ли ответ сосед
(`SparRAW-tools/bench/62/navc.sh`).

Бит станции в маске `0x802948` проверяется в txop и в fixed-потоке (бит 30 в
`[gp,0xd0]`); смысл маски — [гипотеза] «принудительный RTS».

### 3.4. 6.2: NAV по принятому кадру **[код]**

`rx__update_nav_from_frame` 0x9343a8 (в корреляции ошибочно `rx__read_phy_status`): при бите 23 `0x804004` передаёт FC,
длительность (+1600 для кадров расширения, т. е. маяков DMG) и адрес в
`rx_nav__set_from_duration` 0x92dd30 (в корреляции `macreg_r55__92dd30`). Там длительность ограничивается
`0x801484` (случаи — `0x801486`); конец NAV = сейчас + длительность +
`0x801488` − `SIFS_CNT` (`r55`, MAC 0x4d); если позже текущего `0x801470` —
продление, флаг `0x80146c` б0, MAC-команда, TA в `0x80147c`; суммарное время
под NAV — `0x801498` (64 бит) и копия в общем блоке `0x853914`, по соседям —
`0x8571a4`.

### 3.5. 6.2: TX FIFO и ожидания ответов **[код]**

* `tx_fifo__push_frame_3ies` 0x938358 (в корреляции `mac_cmd_0x33__938358`) — запись кадра в TX FIFO: заголовок
  командами MAC `0x33000443`/`0x33000123`, номер последовательности из
  регистра `0x886544`, параметры `0x8577b8`, затем три набора IE из общего
  блока (`0x8577d4`, `0x8577f8`, `0x85781c`) кусками по свободному месту FIFO
  (`r47` б8..).
* `tx__await_rx_or_timeout` 0x924c78 — после передачи ждёт `rx_frame_event`
  или конец GP0.
* `sta__queue_class` 0x927a00 — класс очереди станции по маскам контекста
  +0x18/+0x20/+0x1c.
* Внутренние передачи: `itx__wait_cts`/`_b` (0x93df4c/0x93dfb0),
  `itx__wait_ack` 0x93dbb0, `itx__wait_ack_rf` 0x93dbec (таймауты →
  `0x802aa8`), `itx__wait_cts_rf` 0x93dfec: цикл `uc_wait(rx_frame_event |
  gp0_end)`; на каждый принятый PPDU — `rx__ppdu_is_cts` (0x92e318, копии
  0x92e388/0x92e3e0: `r37.mmWaveCTS`) или `rx__ppdu_is_ack` (0x92e260, копия
  0x92e2bc: `r36.imm_ack`); таймаут GP0 — провал. Варианты `_rf` перед
  проверкой переключают РЧ (MAC 0x1f006000, 0x38000300, 0x3600003f,
  0x06000101).

### 3.6. Справочник блоков передачи и приёма микрокода 6.2

Роли — по строкам и графу вызовов, места с **[код]** — по листингу. Адрес 4.1 в скобках, если
блок с тем же именем есть в дереве 4.1.

* **Internal TX (служебные кадры ucode):** автомат по прерыванию `internal_tx_isr` —
  `internal_tx__flow_sm4` 0x926cc4 (1532 Б: слот для пира `tx__pick_slot_for_peer` (0x925698;
  4.1 0x924db8), заголовок `tx__write_header_16` 0x939a64, окно RX после передачи, выбор всех
  секторов, ожидание двух событий; состояние — `internal_tx__update_state_locked` 0x9272e0) и
  `internal_tx__flow_sm6` 0x93d348 (1484 Б: TX с заданной скоростью, `direct_tx__send_after_delay`,
  `handle_bf_triggers`, `tx__submit_frame` 0x9396a0). Регистры результата —
  `internal_tx__read_result_889568` 0x929ed4 / `internal_tx__read_result_889570` 0x929ec8. Снятие
  ожидания — `internal_tx__clear_pending` 0x9394d0 (4.1 0x933d78), голосование за ресурс —
  `uc_res_vote__release` 0x92bb94 (4.1 0x928df4; `internal_tx__drop_event_mask_and_publish`
  0x92bb18 публикует маски). Мелочь: `tx_ctx__clear_flag_179` 0x926774, `tx_ctx__post_status`
  (PS_AWAKE_PEER при TX), `itx__set_result_code`, `itx__rr_pick_pending_a`, `itx__slot_ready`,
  `sta__queue_class`, `rx_cfg__select_sta`, `itx__wait_ack_rf` 0x93dbec / `itx__wait_cts_rf`
  0x93dfec (MAC cmd 0x02, ожидание event1|event4, §3.5), `uc_exception__bad_instruction` 0x920484.
  Keep-alive: `keep_alive__arm_slot` 0x939484 (4.1 0x933d2c).
* **Direct TX (кадр «здесь и сейчас»):** `direct_tx_step` 0x92c3a4 (4.1 0x929488; дескриптор
  `direct_tx__build_desc` 0x92bf38 (4.1 0x92902c), команды 0x33/0x34, FIFO),
  `direct_tx__init_rx_desc` 0x9246c4 (4.1 0x9243fc), `direct_tx__send_short_frame` 0x93b32c
  (4.1 0x935920), `direct_tx__send_after_delay`, `cf_end__send_frame` 0x938568 (4.1 0x933454;
  CF-End), `rx_flow__send_imm_response` 0x93626c (4.1 0x9313e8; немедленный ответ),
  `rx_funcs__send_direct_frame` 0x93b2b8 (4.1 0x9358ac), `bi_rx__send_response` 0x939530
  (4.1 0x933dd8), `mac__program_tx_common` 0x92d990 (4.1 0x92a3c0),
  `mac__program_tx_result_ctx_uc` 0x92db20, `mac__cmd_29000001` 0x936520 (4.1 0x931640),
  `mac__select_all_sectors_and_wait` 0x936870 (4.1 0x931980), `mac_evt__enable_bit_sync` 0x9361bc /
  `mac_evt__enable_bit_sync_b` 0x936544 (ожидание готовности), `uc_wait_one_event` 0x936588,
  `tx_flow__arm_88606c_0x102` 0x92949c.
* **Слотовый TX/RX-диспетчер:** `tx_sta__flow_loop` 0x939e88 (512 Б — окно TX/RX: rate search,
  MTP-ворота очереди, RX-поток), `tx_flow_substep` 0x92fbc0 (4.1 0x92bdc8), `txss_init__flow`
  0x93bc90 (MAC cmd 0x38), `tx_sta__wait_slot_and_tx`, `txop__await_cts_ppdu` (TXOP-инициатор с
  учётом RD фиксированного расписания, §3.3), `mtp_service__dispatch` 0x92d9d4 (4.1 0x92a404),
  `tx_initiator__reset_slot_counters` 0x92fd74 (4.1 0x92c01c), `bi_tx__check_idle_and_start_uc`
  0x93696c, `qset1_mask__any_pending_uc` 0x93c678, `txss__store_sector_ranking`.
* **Состояние STA и init:** `sta_ctx__reset_counters` 0x93d004 (команда 0x05),
  `txrx_api_step_b_uc` 0x936acc (команда 0x00), `txrx_api_cmd_step` 0x936be4 (4.1 0x931ce8;
  команда 0x01: запас дедлайна, период BI — [BEACONING.md §7](BEACONING.md#7-период-bi-и-tbtt)),
  `bti__reset_sweep_state` и `bi_ctx__clear_state_words` (сброс контекста BI), `tx_ctx__alloc_next`
  (A-BFT/BI init), `power_manager__scale_counters_ms` 0x92e6c0 (4.1 0x92b1c8).
* **RX-поток:** `rx_get_required_response` 0x932e40 (1468 Б — решает, нужен ли ответ на принятый
  кадр: QoS/QoS-Null/BAR от отсоединённой STA, «NO_RESPONSE required», «ignoring grant due to BF
  trigger»; маски midbrp_sta_en/prev), `rx__program_mac_and_wait` 0x938b90 (разрешение TX у MTP,
  окно), `rx__handle_status_flags` 0x939d3c, `rx__update_nav_from_frame` 0x9343a8 (§3.4),
  `rx__mac_prepare` 0x92f2bc (4.1 0x92b7c4), `rx__check_mode_2` 0x936e04 и
  `phy_stats__accumulate_to_shared` 0x92e544 (PHY 0x883800; сброс счётчиков —
  [../6.2/docs/MISC-FW.md](../6.2/docs/MISC-FW.md) §15), `rx__check_g8005f8_bit24` 0x932de8,
  `rx_flow_substep_uc` 0x93daf0, `rx_flow__latch_phy_8014e8__930da4`,
  `rx_funcs__record_level_8020f8_8020fc__922168`, `rx_flow__measure_snr_select_best` (428 Б, лист),
  `rx_flow__accumulate_busy_time`, `itx__report_status_evt`, `rx__parse_ssw_field`,
  `rx__handle_brp_frame`, `sta_tbl__find_by_mac`, `mac__select_rf_module_cmd31` 0x93cfdc,
  `rx_capture__match_filter`, `nav__read_hw_duration_flag` 0x9290d0 (4.1 0x926b9c; NAV),
  `sxd_hal__wait_slot2_busy` 0x936d64 (4.1 0x931e74), `hwd_phy_rx_set_agc_start_val_and_gain_array_uc`
  0x929c10, хвосты `l1_task__rx_flow_thunk` 0x92b6a8 / `l1_task__rx_flow_thunk_b` 0x92b6f8.
  Писатель 0x886d10 — `rx_flow_step` (6.2 0x931acc, 4.1 0x92db44;
  [../6.2/docs/MISC-FW.md](../6.2/docs/MISC-FW.md) §7.1). Разбор PPDU-отчёта —
  `rx_funcs__handle_ppdu_report` (0x9316cc / 0x92d740), поток приёма — `rx_funcs__rx_flow`
  (0x933928 / 0x92f280).
* **Очереди и vring:** `vring__disconnect_flush` 0x925c8c (1040 Б, «Flush VRing %d» — слив vring
  при разрыве/смене слота фиксированного расписания: ждёт простоя DMA и TX-конвейера, печатает
  базы буферов), `dma_is_tx_pipe_idle` 0x926184, `dma_is_idle_uc` 0x9290f4, `vring_is_empty_uc`
  0x92a6f0 (+хвост `vring__is_empty_uc_quiet` 0x926298), `dump_mac_buffer_bases` 0x925c0c,
  `dump_vring_pring_info` 0x929320; заголовки очередей QH — `qh__write_by_flags` 0x92d488
  (команда 0x45 `fwif_write_qh`), `qh__build_descriptor` 0x92d428 / `qh__build_descriptor_b`
  0x92d400, `qh__pack_descriptor` 0x92420c (окно 0x886608, чтение 0x886800 —
  `qh__wait_desc_window_ready` 0x924480, `qh__reset_desc_window` 0x9246b0),
  `qh__write_desc_window`, `qh__read_desc_window`. Наборы очередей — `mac__build_qset_mask`
  0x92f738 (4.1 0x92bacc), `mac__replicate_bit_mask` 0x92f400 (4.1 0x92b908).

## 4. Прошивка: от WMI до аппаратной очереди [4.1]

```
WMI_VRING_CFG_CMDID ─► encap_trans_type @0x8f37b8   (фактически wmi_handler_vring_cfg)
    ─► stream_mgr__alloc_pring (пул потоков 0x847ddc) ─► mid__setup_bcast_vring
    ─► STREAM_MGR__ADD @0x8c263c
          ├─ vring_schd__add_vring @0x8c276c
          │     объект кольца из пула 0x80456c (0x28 Б × 9) → список ожидания 0x804580
          │     hwd_dma__program_vring_desc: база 0x88182c+0x20·idx, размер 0x881834+0x20·idx
          │     LMAC 0x08 {qid=idx, cid, тип 3, op 0} (@0x8c27f2) ──► ucode: qid в +0x14 соседа и qset 6
          ├─ stream_mgr__install_ba_rule @0x8dbb5c (6 правил разборщика MAC)
          ├─ agg_max_wsize≠0 и окно·max_msdu ≤ 0x14000 → «Automatic BA AGREEMENT» (vcall [conn+0xd4]+0x18)
          ├─ WMI_VRING_CFG_DONE (адрес звонка = hwd_dma__macq_reg_addr(idx) = 0x881820+0x20·idx)
          └─ [conn+0xfc]==7 (KEY_ASSOC) → WMI_VRING_EN_EVENTID
```

Тело `wmi_vring_cfg_cmd` (совпадает с драйвером) **[код]**: +0x00 action (0 ADD,
2 DELETE; 1 MODIFY — ассерт @0x8f3958), +0x04 ring_mem_base u64, +0x0c
ring_size, +0x0e max_mpdu_size, +0x10 ringid (**< 10** @0x8f37c6), +0x11
cidxtid (cid 0..3, tid 4..6, tid < 7), +0x12 encap, +0x15 mac_ctrl (b0
lifetime_en, b1 aggr_en), +0x16 to_resolution&0x3f, +0x17 agg_max_wsize. В OOB
max_mpdu принудительно 0x1f28 (@0x8f390a). `vring_ctl = 0x8062f4 + 8·idx`.

Ucode-сторона LMAC 0x08 (`ucode_cmd__queue_delete` @0x9354d4, фактически
конфиг очереди; @0x93571e..0x93578c): тип 3 → qset 6 и +0x14 соседа, op 1 =
удалить, иначе добавить; пишет HW qset напрямую **[код]**.

Широковещание: `wmi_handler_bcast_vring_cfg` @0x8f2bac → `init_bcast_queue` →
`stream_mgr__add_bcast_vring` @0x8c2138 (сразу `vring_schd__alloc_pring`).

**Регистры кольца idx**, B = 0x881818+0x20·idx **[код; head/tail — железо]**:
B+0x00 head DMA; B+0x04 b31 сброс; **B+0x08 tail = звонок драйвера**; B+0x0c
head_4_rd; B+0x10 b31; B+0x14 база; B+0x1c размер; 0x881c84 — битовая карта
колец с непрочитанными дескрипторами.

`hwtail` в `debugfs rings` — адрес звонка, который пишет сам драйвер
(`txrx.c:2005 wil_w(wil, vring->hwtail, vring->swhead)`), адрес приходит из
`WMI_VRING_CFG_DONE` (fw `hwd_dma__macq_reg_addr` @0x8cda90/@0x8cda92 =
0x881820+0x20·idx). Равенство `hwtail == swhead` значит лишь «звонок
выполнен». Голова потребителя DMA — регистр 0x881818+0x20·idx (fw читает его в
BIND как «Vring head», `vring_hw__field_addr_440c0c0` @0x8cda9c/@0x8cda9e)
**[код]**.

**Дескриптор TX (драйвер `txrx.h`)**: MAC-часть d0 {lifetime 0..9, int_en,
status_en, txss_override, ts_insert, dur_preserve, mcs 22..26, mcs_en,
sn_preserved}, d1 {pkt_mode, mac_id, ack_policy_en, dst_index 16..19, ack_policy
21..22, lifetime_en, max_retry 24..30, max_retry_en}, d2 {num_desc, l2_trans,
snap, vlan}, d3 ucode_cmd; DMA-часть d0 {l4_len, eop, mark_wb, dma_it, sbd, tse,
iic, itc, **qid 16..20**, po, l4t}, addr, ip_len, mac_len, error{mac_status
0..2}, **status{DU бит 0}**, length. Завершение пишет DMA (DU), fw пакеты хоста
не трогает **[код драйвера + отсутствие fw-обращений]**.

### 4.1. Планировщик колец — мультиплексор колец на PRING

`vs = 0x804580` = вендорский `g_vring_schd` **[пак+код+железо]**:

| смещ. | поле |
|---|---|
| +0x00 | m_waiting_list {size, head, tail} |
| +0x0c, +0x18 | m_ready_for_running_queues[2] (приоритет 1, 0) |
| +0x24 + i·0x38 | `sm_pring_connectivity` (слот PRING) |
| +0x94 | число PRING = **2** (PRINGS_PER_VR_SCHDLR) |
| +0x98 | маска запрещённых CID (`vring_schd__prohibit_cids` @0x8dd0b4) |

Слот PRING (0x38 Б) = вендорская `sm_pring_connectivity` без vtable: +0 u16
pring_index, +2 u16 vring_index, +4 mac_buffer_base, +8 mac_buffer_lines, +0xc
счётчик таймаутов, +0x14 connectedObj, **+0x18 m_state {0 DISABLED, 1 INACTIVE,
2 ACTIVE, 3 IN_TRANSITION, 4 FORCE_STOP}**, +0x1c EOP, +0x20 wb_done,
+0x24/+0x28 таймеры тайм-слота (0x8e4e90, период [gp-0x3f]=10000 мкс;
0x8e4edc, [gp-0x3e]=100000 мкс), +0x2c/+0x30 время привязки/отвязки.

Объект кольца (0x28 Б, `vring_schd__fill_vring_cfg` @0x8e267c): +8 слот PRING,
+9 idx, +0xa cid (8 = bcast), +0xb приоритет < 2, +0xc u16 timeslot, +0x10
bcast, +0x20 =1 юникаст, +0x24 состояние {2 READY, 3 BOUND, 4 STOP}.

Работа: `vring_schd__vring_task` @0x8e3aa0 — у кольца появились данные
(0x881c84) → `vring_schd__move_to_ready` @0x8c1e44 → свободный слот и CID не
запрещён → `vring_schd__bind_if_free` → `sm_pring__bind_vring` @0x8c3fdc: из
INACTIVE (@0x8c410a) — проверка пустоты MAC-очереди («Connect - Queue is not
empty: Call 911!!!»), `vring__program_macq_and_ba`, `mac_ring_enable(qid)`
(0x886a00+0x14), проверка PTP 0x886a00+0x24, `hw_rgf_block_program`
(0x8812d8/0x881330/0x881338 + 0x70·p), **`[слот+0x18]=2` @0x8c41a6**; из
ACTIVE — перевзвод тайм-слота. Отвязка: `sm_pring__state_step` @0x8e5358
(ACTIVE → IN_TRANSITION), `sm_pring__timeout` @0x8e43c8 (не опустело за 5
попыток → LMAC 0x08 op 3 = FLUSH @0x8e44f8; опустело → `vring__teardown`). Сон
соседа на fw-стороне: каждое PS_AWAKE_PEER_EVT → `ps_assoc_mgr__set_awake_tsf`
@0x8dd29c → `prohibit_cids(~awake)` → `find_runnable`.

Диагностика BIND:: — счётчик `0x805be4[idx]` на каждый вызов bind; на 10-м
печать (@0x8c401a), затем обнуление **[код]**. В 6.2 лог BIND:: вырезан.

**Живые значения, узел B [железо]:** слот 0 = {PRING 0 ↔ кольцо 1, ACTIVE, connectedObj
0x80451c}, слот 1 = {PRING 1 ↔ кольцо 0, ACTIVE}; `[vs+0x98] = 0xfffffefe` (CID
0 и 8 разрешены); поток кольца 1 = 0x84842c {conn 0x805218 (CID 0)}.

### 4.2. Собственные кадры fw (управление)

Три внутренних кольца (`dma_mgr__setup_queue_pair` @0x8d5dec → `fwq_tx__init`):

| qid | кольцо (fw_peri) | PRING | fwq | LMAC 0x08 |
|---|---|---|---|---|
| 0x19 | 0x840000 | 5 | 0x8425c8 | {тип 0, cid 8} @0x8e4b4a |
| 0x1a | 0x842800 | 6 | 0x842410 | {тип 0, cid 8} @0x8e4dea |
| 0x1e | 0x843000 | 3 | 0x8424a0 | не шлётся |

Путь: `TX_API__send_packet` @0x8e0c74 → `fwq_tx__enqueue` @0x8c2460 → списки по
приоритету (fwq+0x18/+0x24) → `fwq_tx__send_next` @0x8e0a28 →
`FWQ_TX_AVAILABILITY__add_packet` @0x8c23b8 (счётчик 0x85705c+cid, карта
**0x857068** = `fw_mac_queue` в AWAKE PEERS; для mcs≥1 — 0x85706c/0x857078) →
`tx_dma_if__push_desc` @0x8ddb68 (`tx_desc__build`, `tx_desc__set_lifetime`,
`mac_kick_ring`). Завершения: ISR `pring__isr_dispatch` @0x8e72fc (0x881c2c
биты 0/4/8) → `TX_API__handle_completed_packets` @0x8cb2c0 («TX WB from DMA
#%d») → `fwq_tx__handle_completion` @0x8ca540 (long-retry с таймером). Кадры
спящему соседу — в `m_pending_peer_pm_list`, перепосылка из
`TX_API__awake_peer_ntf` @0x8c3658. **Эти qid (тип 0 → qset 4) запретом CID на
время BF не блокируются** **[код]**. Раскладка FWQ_TX_AVAILABILITY
(0x857040/0x857068) в 6.2 та же.

### 4.3. Block Ack (fw)

`WMI_VRING_BA_EN` → `vring_ba_en__race_check` @0x8c3884 → `ul_stream__ba_sm_evt` →
BA_SM (5 состояний, таблица 0x8022cc fw_data); BA_SETUP_SM (6 состояний,
0x802400). Итог — `sw_vring__ba_agreed` @0x8c3724: окно и max_msdu/8 в
дескриптор MAC-очереди через `mac_indirect__write_entry` (таблица 2) @0x8c3770,
`sw_vring__setup_macq`, `vring_schd__resume_vring`, `WMI_BA_STATUS_EVENTID`. Окно
и счёт BA держит железо (BAP) **[код; «BAP» — пак]**. Путь данных от BA не
зависит: qid подключается в ucode на ADD, до BA. Автоматы — в
[STATE-MACHINES.md](STATE-MACHINES.md).

### 4.4. Детекторы

`tx_ppdu_ageing_timeout_detector__task` @0x8e3ed4 и `ka_necessity_detector`
стартуют из `lm_if__start_link_loss_monitoring`, работают на счётчиках MAC;
разрыв по ATIM («missing ack for ATIM in 10 consecutive beacons») только при бите
CID в `[obj+0x1ec]` (@0x8e413a) → `ageing_detector__drop_connection`.
`conn_mgr__awake_peer_ntf` @0x8c36e0 лишь запускает детекторы для conn с
`[+0xb0]==2`; данные не гейтит **[код]**.

## 5. Прошивка 6.2: опорные блоки [6.2]

125 блоков тракта данных fw 6.2 сверены по лог-строкам со строками 4.1: 33
печатают строки, дословно известные по 4.1, 10 — с новыми строками, у остальных
строк нет **[код]**. Точки входа по адресам 6.2: `wmi_vring_cfg` @0x8fc198,
`STREAM_MGR__ADD` @0x8c2dc4, `sm_pring__bind_vring` @0x8c49a0.

| компонент | блоки 6.2 (адрес, Б) | как в 4.1 |
|---|---|---|
| разбор кадров управления | `rx_mgmt_prs__parse` 0x8de190 (468), `rx_mgmt_prs__alloc_ei` 0x8e0a78 | те же строки «[PRS]Unhandled MGMT type», «failed to allocate EI buffer» |
| планировщик колец | `vring_schd__disconnect_notify` 0x8c91b8 (328), `vring_schd__stop_vring` 0x8e80cc, `vring__wait_drain` 0x8c4554 | «re-connected», «VR_SCHDLR received STOP» |
| STREAM_MGR | `stream_mgr__delete_vring` 0x8c8ebc, `stream_mgr__send_info_response` 0x8d885c, `stream_mgr__addba_rsp_handler` 0x8c3124 | |
| FWQ | `fwq_tx__queue_step` 0x8e5620, `fwq_tx__long_retry_handler` 0x8dce84, `fwq_tx__long_retry_failures` 0x8c66ac, `fwq_tx__flush_list_packets_by_cid` 0x8cac6c, `fwq_tx__add_packet` 0x8c2af4 | |
| TX_API | `TX_API__alloc_tx_payload` 0x8c3414, `TX_API__callback_and_release` 0x8c5a8c, `TX_API__flush_pending_peer_pm_connection` 0x8cad48, `TX_API__send_dband_bcon` 0x8e5284 | |
| Block Ack | `ba_sm__send_addba_req` 0x8e50c8, `ba_sm__send_delba` 0x8e530c, `ba_sm__setup_result` 0x8c42a4, `ba_setup_sm__addba_resp_timeout_cb` 0x8f0b60 | автоматы BA_SM/BA_SETUP_SM — пары 4.1 |
| сборка кадров | `mgmt_tx__build_probe_resp` 0x8e9f74, `mgmt_tx__probe_resp_ies_8d8378` (604), `mgmt_tx__append_probe_resp_ies` 0x8d8000, `mgmt_tx__build_fixed_probe_resp` 0x8ea0d8, `mgmt_tx__build_assoc_resp_8f9e88` | |
| связь для служебной передачи | `sw_tx_mgmt__acquire_link` 0x8dab34 («link acquisition activated», «LINK RESOURCES ARE NOT AVAILABLE») | тот же вход, что `mid__acquire_link` в 4.1 |

Новое в 6.2 (по новым строкам) **[код]**:

* **FWQ, долгие повторы:** `fwq_tx__long_retry_handler` («add_packet for
  packet… / add_packet() failure»), `fwq_tx__long_retry_failures` («Long retry is
  %d. Timer…»); `fwq_tx__add_packet` проверяет канал и состояние очереди
  («send_next() fail / wasn't called; m_state, m_channel»).
* **Block Ack:** `ba_setup_sm__addba_req_tx_failed` — «receiving addba response
  without receiving ack before that for the addba request»;
  `ba_setup_sm__addba_session_success_ntf` (фактический размер окна);
  `stream_mgr__addba_rsp_handler` — «AFTER DISCONNECTION». BA_SETUP_SM получил
  события `EVT_ADDBARSP_ARRIVED`, `EVT_ADDBARSP_TIMEOUT`, `EVT_VRING_STOPPED`;
  BA_SM — `EVT_VRING_STOPPED`.
* **Probe Response:** вендорский IE («Probe resp vendor specific length»), явное
  сочетание внутренних и внешних (от хоста) IE, «FIXED MGMT TX Probe resp use
  host SSID / use local SSID» — фиксированный ответ с SSID хоста или своим.
* **DMG-маяк на канале:** `TX_API__send_dband_bcon` («length=%d on channel %d»).
* **Энергосбережение соседа:** `TX_API__flush_pending_peer_pm_connection` —
  сброс ожидающих кадров соседа при смене его PM-состояния.
* `stream_mgr__delete_vring` — удаление широковещательного кольца вместе с
  pring.

## 6. Запрет передачи по CID на время BF [обе]

Механизм, которым незавершённый beamforming останавливает юникаст: очередь
соседа вынимается микрокодом из аппаратных масок qset; CBAP выбирает очередь
только из включённых qset, поэтому MAC не запрашивает у DMA дескрипторы этого
кольца. Широковещательная очередь от CID не зависит и остаётся в qset 6.

### 6.1. Взведение **[код]**

1. `bf__trigger_if_pending` @0x926840 читает байт причин BF соседа `0x857849 +
   0x14·cid` (общая память fw↔ucode; @0x92684c `ldb_s`, @0x926850 `bl.ne`).
   Биты: 0 RS_MCS1_TH_FAILURE, 1 RS_MCS1_NO_BACK, 2 MAX_CTS_FAILURE_IN_TXOP, 3
   MAX_BACK_FAILURE, **4 FW**, 5 MAX_CTS_FAILURE_IN_KEEP_ALIVE — декодер fw
   `lmac_if__bf_done_evt` @0x8d830c (@0x8d8318), таблица fw_data 0x801b88 = `00 04
   1c 08 1c 1c 1c 10 …`. Бит 4 ставит `ucode_cmd_trigger_bf`/`bf_sm__trigger`
   (@0x922332 `bset_s r0,r0,0x4`) по LMAC 0x09 от прошивки.
2. Ненулевой байт → `bf__trigger_for_mid` @0x92b63c → первым делом
   `mid_vring_mask_update(3, cid)` @0x92b646 (`mov_s` перед `bl.d`; даже при
   LMAC_PASSIVE — проверка `[gp,0xc4]==1` идёт после, @0x92b64c).
3. `mid_vring_mask_update` @0x928cb4 (по смыслу — «запрет TX для CID»):
   * `0x801b2c[cid] |= 1<<r0` (u16 на CID; @0x928ce2 `bset r1,r1,r0`, @0x928ce6
     `stw_s`) — вендорский `g_sm_disable_cid_tx_msk` (в паке — массив 8×u16)
     **[код+пак]**; причина 3 = BF;
   * если запись соседа валидна (`[0x801190+0x48·cid+2]` бит 0, @0x928cd4):
     `[0x80041c] &= ~[соседа+0x18]` (@0x928cf4) и **`[0x800424] &=
     ~[соседа+0x14]`** (@0x928cfa) — вычитание очередей соседа из теней qset 5 и
     6;
   * `mac__publish_masks` @0x9373b0 (0x9373b0..0x9373fe) копирует
     0x800414/0x80041c/0x800424 в тень 0x800a28/2c/30 и пишет **0x886d8c+4·i =
     тень[i]** для i=4..7, если бит i в `[gp-0x74]` (0x8004b4), иначе 0.
4. `tx_initiator__build_tx_vector` @0x933e90: MAC-команда `0x0f000001`
   (@0x933e9a), селектор 0 → R41 `QUEUE_SEL_STATUS`: `lowest_queue_set_found`
   биты 8..11 (@0x933ed0), `qid_for_found_queue_set` биты 16..21 (@0x933ed6); 0
   наборов → «Backoff expired without Q availability» **[код+пак]**. qid,
   отсутствующий во всех масках, железо не выбирает.

Все вызовы запрета/снятия передают причину 3 (`mov_s r0,0x3` перед `bl.d`):
@0x92b644, 0x921904, 0x9224de, 0x922660, 0x922734, 0x924fc4, 0x9225ac **[код]**.

### 6.2. Снятие **[код]**

`rf_sector__clear_sta_bit` @0x928d94 (по смыслу — «снять запрет TX для CID»):
`0x801b2c[cid] &= ~(1<<3)` (@0x928dae); **только если осталось 0** (@0x928dc4
`brne_s r13,0`) и запись валидна — возвращает `[соседа+0x18]` в 0x80041c и
`[соседа+0x14]` в 0x800424 (@0x928dd2/@0x928dd8) и публикует. Вызывающие:

* `bf__clear_pending_and_notify` @0x924fb8 ← `bf_sm__process_request_fifo`
  @0x9227e8 (штатное завершение BF: `bf_state__set(cid,0)`,
  `rate_search__apply_mcs`, снятие), `bf_sm__clear_sta` (LMAC 0x05 субкод 1 =
  удалить соседа), `bf__abort_to_state11` (LMAC 0x0f с аргументом 0 — из
  `disassoc_done`);
* `bf_sm__start_request` @0x9225ae — при старте запроса BF с r0==1 и готовым
  rate search.

Пока байт причин `0x857849+0x14·cid` ≠ 0, любой проход TX-инициатора по этому
CID (`tx_initiator_step` @0x93479e, `internal_tx_step`) снова зовёт
`bf__trigger_if_pending`, и запрет возвращается. Обнуляют байт
`bf_sm__reset_sta_rate(cid, 1)` @0x9221da (из `bf_sm__start_request`) и
`bf_sm__clear_sta` @0x9229fc.

### 6.3. Что к запрету отношения не имеет **[код+железо]**

* **ATIM/PS.** `tx atim fail N` — счётчик окна AW, к маскам qset отношения не
  имеет. `get_tx_eligibility__precheck` @0x9264f0 пропускает при
  `[0x8009e8]==0` (@0x926516); на стенде 0 на обоих узлах. `awake peers vector =
  0x1`, `local_in_doze=0`.
* **peer_eligibility = 0xff** — маска `[0x801ed0+0x128]`, которой AW-воркер
  режет векторы (@0x9260b4..0x9260c8), не запрет.
* **Блокировка внутренних** (`g_sm_lock_internal_msk`, [gp,0x2c]=0x800554)
  снимает qset 4..6 целиком (`uc_res_vote__acquire` @0x928d40 `bic 0x70`); на
  стенде 0, `[gp-0x74]=0x70`.
* **Ключ/порт.** Передающий путь ucode ключ не проверяет; ключ (`+0x47` записи
  соседа) используется только для шифрования (`rx_funcs__rx_flow` @0x92f6d4,
  `mac__load_tx_vector`). Порт данных открывается на хосте
  (`WMI_DATA_PORT_OPEN_EVENTID`).

### 6.4. Наблюдение на стенде (4.1, безролевой линк) **[железо]**

Юникаст CID 0 (qid 1 = кольцо tx_1) стоит, широковещание идёт.

| регистр | vring 0 (bcast) | vring 1 (CID 0) |
|---|---|---|
| head DMA 0x881818/0x881838 | 0x0f | **0x00** |
| tail (звонок) 0x881820/0x881840 | 0x0f | 0x15 (21) |
| 0x881c84 «кольца с данными» | бит 1 = 1 (только vring 1) | |

DMA не взял ни одного дескриптора кольца 1; лог BIND: `Vring tail: 15. Vring
head: 0`. На узел A кольцо 1 пустое (0/0).

| что | значение | смысл |
|---|---|---|
| `0x801b2c[0]` (host 0x941b2c) | **0x0008** | CID 0 запрещён, причина 3 (BF) |
| байт причин 0x857849 | 0x10 (оба узла) | бит 4 FW |
| запись CID 0 `+0x14` (0x8011a4) | 0x00000002 | очередь соседа = qid 1 |
| `0x800424` (тень qset 6) | 0x00000001 | только qid 0 (bcast), qid 1 вычтен |
| HW qset 6 `0x886da4` | 0x00000001 | то же в железе |
| HW qset 4 `0x886d9c` | 0x06000000 | qid 25, 26 (служебные, sta 8) |
| HW qset 5/7 `0x886da0/0x886da8` | 0 / 0 | |
| `[gp-0x74]` 0x8004b4 | 0x70 | qset 4,5,6 включены, 7 (internal) выключен |
| HW qset 3 `0x886d98` | 0x00000002 | qid 1 — набор ответчика (RD), пишет `rx_funcs__rx_flow`, инициатор его не ищет |
| MTP avail `0x886f9c` / BAP `0x886548` | 0x2 / 0x40000000 | MAC «знает», что в qid 1 есть данные |

На узел A то же: `0x801b2c[0]=8`, 0x800424=1. fw-сторона кольца готова:
`ADD_VRING`, LMAC 0x08 (qid 1 к CID 0, тип 3) отработали.

Цикл: fw `maintain_sm` шлёт LMAC 0x09 → ucode ставит бит 4 и запрещает CID → в
DTI железо выбирает только qid 31 (internal) → `internal TX pending sm = 3` (BF,
`internal_tx__pending_sm` @0x928ee0) → BF проваливается (STATE 9 / SUBSTATE 49)
→ BF_DONE (тип 6) → fw `maintain_sm__on_bf_results` @0x8e9fba снова
`lmac_if_trigger_bf` → … Лог ucode на узле B: каждая TXOP DTI —
`tx_initiator_flow() Starting internal TX` / `internal TX pending sm = 3`, ни
одной передачи данных. Политика `BF_RETRY_FOREVER`, `failed_bf_cnt` > 82 900.
Причины провала BF и политики повтора — [BF-ENGINE.md](BF-ENGINE.md).

### 6.5. Варианты обхода (не проверены)

* Пройти DTI-BF — штатный путь.
* Не запускать FW-BF в режиме прямой связи: fw запускает его из `maintain_sm`
  (`lm_main_sm__on_linkup_req__*`, `maintain__trigger_bf`,
  `maintain_sm__on_bf_results`). Если байт причин 0 и BF-FIFO пуст,
  `mid_vring_mask_update` не вызывается.
* 6.2: запрет тот же (§8), ставится до проверки LMAC_PASSIVE (@0x92eb72 раньше
  @0x92eb78); поток fixed scheduling выбирает qid мимо qset-масок, поэтому при
  включённом ESE-расписании запрет, возможно, не действует **[гипотеза]**. В 6.2
  BRP отключается командой хоста (см. [BF-ENGINE.md](BF-ENGINE.md) §6).
* Ответная передача (qset 3): `rx_funcs__rx_flow` кладёт очереди соседа в qset 3
  без учёта запрета; при TXOP/RD-гранте соседа юникаст, возможно, уйдёт ответом
  **[гипотеза]**.

## 7. Приём: эфир → хост

Разбор по 4.1 с проверкой по 6.2.

### 7.1. Два тракта

1. **Данные идут мимо прошивки.** Кадр данных, дошедший до fw, — ошибка:
   `rx_pkt_srvs__distribute_data` @0x8def44 проверяет тип (=2), печатает
   `Distribute data RX failed`, увеличивает счётчик `[0x842ea0+0x30]` и
   освобождает буфер **[код]**. Штатно данные уходят из MAC через DMA прямо в
   RX-кольцо хоста (настраивается `WMI_CFG_RX_CHAIN`, обработчик
   `wmi_handler_cfg_rx_chain` @0x8f2ed0, 864 Б).
2. **Управление идёт в прошивку**, куда его направляют правила аппаратного
   разборщика MAC.

### 7.2. Разборщик MAC (steering)

Таблица правил пишется косвенно через окно **0x886280** (`mac_parser__write_rule`
@0x8dbb00) **[код]**: +0x10 = `(ctrl<<16)|0x80000000` (ctrl собирается
аксессорами `bf_h_s0_w2`/`bf_h_s4_w2`), +0x14 = индекс правила, +0x18/+0x1c = 8
байт правила, запуск — запись 0x40000000 в +0x0c, ожидание сброса бита 29. Ключ
правила — полуслово Frame Control (`(подтип<<2)|0x400|…`, см.
`mac_parser__install_default_rules` @0x8dbb80: правила для индексов 8..14 с
особыми случаями для 0x17/0x18/0x1c и 0x34..0x37).
`hwd_mac_parser__set_rx_filter` @0x8dbc3c переписывает те же правила при
`discovery__rx_start/stop` — режим обнаружения меняет, какие кадры управления
видит прошивка.

### 7.3. Путь в прошивке

    DMA IRQ -> isr_txrx_manager 0x8c1098 -> txrx_mgr__handle_dma_irq 0x8c7de0
         (причины из 0x881c00: биты 0..11 и 12..23, задача u_schd 0x8e4ba0/0x8dee30)
      -> rx_api__drain_list 0x8dee30 (r0==4: очередь 0x8062c4; буфер: +0x28, +0x38, байт +0x34 ∈ {0,1})
      -> rx_pkt_srvs__dispatch 0x8df11c (контекст 0x842aa0)
           длина < 24 -> сброс, счётчик [gp,182]
           тип FC (биты 2..3):
             0 управление -> rx_mgmt_srvs__distribute 0x8df014
             1 контроль   -> ветка ошибки, освобождение
             2 данные     -> rx_pkt_srvs__distribute_data (ошибка, см. выше)
             3 расширение -> rx_pkt__mid_accepts 0x8defec: только подтип 0 (DMG Beacon),
                             объект PCP через vtable [mid+0x234]->[1]

Пул приёма: `rx_pool__init` @0x8d626c — 12 элементов по 0x538 Б от **0x84af54**
(`mem_pool__init`, пул 0x8062c4+0x1c), кольцо 0x843800 (8, 4). `rx_macq__init`
@0x8d6754 заводит две MAC-очереди прошивки: ctx 0 — `(0,0, 1312, 0xc00, 421, 0,
4)`, ctx 1 — `(1,5, 544, 0xda5, 393, 4, 4)`.

### 7.4. Распределение кадров управления

4.1 — таблица fw_data 0x802624 (проверено по дампу), переход `0x8df03e +
2·байт`:

| подтип | байт | куда |
|---|---|---|
| 0–3 Assoc/Reassoc Req/Resp, 10 Disassoc | 0x00 | MLME `rx_pkt_handler` @0x8df208 (своя таблица 0x801ff4, 11 подтипов) |
| 4 Probe Req, 5 Probe Resp | 0x0d | объект PCP: vtable `[mid+0x234]->[1]` |
| 6, 7, 8 Beacon, 9 ATIM, 11 Auth, 12 Deauth, ≥15 | 0x39 | **хосту**: `operational_if__send_evt` с id `0x61<<6 = 0x1840` (`WMI_RX_MGMT_PACKET_EVENTID`) |
| 13 Action | 0x21 | `stream_mgr__rx_action` (BA/ADDBA и пр.) |
| 14 Action No Ack | 0x2d | `rx_mgmt__action_no_ack` @0x8c1d5c |

`rx_pkt_handler` сам проверяет CID (`invalid cid ... drop pkt`), дубли Assoc-Req
и `m_bss_mode` ∈ {2,3} (PCP/AP) перед обработкой Assoc-Req.

**[6.2]** Схема та же, таблица подтипов — **0x802c58**, содержимое `00 00 00 00
0c 0c 31 31 31 31 00 31 31 21 25` — раскладка по подтипам идентична 4.1
(сдвинуты только смещения веток; база 0x8e3bca) **[код]**. Ветка 0x31 (хосту)
@0x8e3c2c содержит только лог `<<---- [HOST EVENT] WMI_RX_MGMT...` перед
выходом через милли-код; отправители события 0x1840 в 6.2 —
`discovery__rx_pkt_handler`, `stream_mgr__action`.

Приёмный путь ucode: `rx_flow`/`rx_funcs__rx_flow` 4.1 — см.
[MAC-COMMANDS.md](MAC-COMMANDS.md); 6.2 — [../6.2/docs/RX-BRP-UC.md](../6.2/docs/RX-BRP-UC.md)
и §3.4 (NAV).

## 8. Соответствие 4.1 ↔ 6.2 (микрокод)

| что | 4.1 | 6.2 | уровень |
|---|---|---|---|
| gp ucode | 0x800528 | 0x800528 (fw gp 0x800184) | [код] |
| запрет CID (set) | `mid_vring_mask_update` @0x928cb4 | `bf__pause_sta_tx` @0x92ba54 (в корреляции `uses_g_800400_801104_802a90__92ba54`); @0x92ba82/86 | [код] |
| снятие (clear) | `rf_sector__clear_sta_bit` @0x928d94 | `bf__resume_sta_tx` @0x92bb34 (`uses_g_800400_801104_802a90__92bb34`); проверка нуля @0x92bb64 | [код] |
| `g_sm_disable_cid_tx_msk` | 0x801b2c (8×u16) | 0x802a90 | [код+пак] |
| запись соседа | 0x801190 + 0x48·cid; очереди +0x14 (qset 6) / +0x18 (qset 5) | 0x801104 + **0x50**·cid; +0x18 / +0x1c (вычитание @0x92ba9a/@0x92ba94) | [код] |
| тени qset 4..7 | 0x800a18[i] (0x800a28/2c/30/34) | 0x80156c[i] (0x80157c/80/84) | [код] |
| публикация масок | `mac__publish_masks` 0x9373b0 | 0x93d0ac | [код] |
| маска включённых qset | [gp-0x74] = 0x8004b4 | [gp-0x7c] = 0x8004ac | [код] |
| регистры qset | 0x886d8c+4·i | те же | [код] |
| `g_sm_pending_internal_msk` | 0x800674 (set `uc_res_886f00__acquire` @0x928f2c, clear `uc_pending__clear_bit` @0x928f6c) | 0x8006cc (set `internal_tx__check_idle` @0x92bd30, clear `internal_tx__clear_pending_bit` @0x92bd70) | [код] |
| lock внутренних | [gp,0x2c] | [gp,0x28] | [код] |
| байт причин BF | 0x857838+0x14·cid, +0x11 (0x857849); биты 0..5 | 0x857e38+0x14·cid, +0x11 (0x857e49); биты 0..5 **+ бит 6** (смысл неизвестен) | [код] |
| маска разрешённых причин (LMAC 0x14) | [gp,0xb8] | [0x8021b8+0x20] | [код] |
| LMAC_PASSIVE (0x15) | [gp,0xc4] | [gp,0xb4] | [код] |
| проверка причин | `bf__trigger_if_pending` @0x926840 (молча) | `handle_bf_triggers` @0x928750, лог `handle_bf_triggers cid:%d set:%d triggers:%x` | [код] |
| таблица qid | 0x801130, 3 Б {b6, b5, cid} | 0x802228, те же 3 Б | [код] |
| data-qid соседа | нет | байт 0x801be8+5·cid (LMAC 0x08 тип 3) | [код] |
| TX-контекст | 0x801a18, 2 слота × 0x30, текущий +0x60 | 0x802978, 2 слота × **0x3c**, текущий +0x78 (0x8029f0); поля сдвинуты на +4 | [код] |
| диспетчер LMAC | байтовая таблица 0x800c68, cmd ≤ 0x41 | таблица полуслов 0x8019dc, cmd ≤ 0x4a | [код] |
| LMAC 0x0f (сосед на поддержании) | inline в `umac_if_cmd_handler` @0x936ee0, карта 0x800fcc+0x68 | `ucode_cmd_0x0f_handler` @0x93477c, карта 0x80218c+8 (+9 — прошлое значение) | [код] |
| LMAC 0x45 `fwif_write_qh` | нет (QH пишет fw) | есть: ucode пишет заголовки очередей через окно 0x886608/0x886800 | [код; «нет в 4.1» — по строке и вызову] |
| выбор потока в DTI | только CBAP: `bi_tx_initiator_wrap` @0x932844 → `tx_initiator_flow` | `fixed_sched__run_tx_slot` @0x93768c (§3.2) | [код] |
| выбор qid в fixed scheduling | — | MTP_Q_AVAIL ИЛИ BAP_Q_AVAIL, мимо qset-масок | [код]; «запрет не действует» — [гипотеза] |
| precheck «shallow sleep STA» | есть (@0x9337fe) | удалён | [код+строки] |
| bcast в инициаторе | ветка @0x933946; internal sm 1 — заглушка | отдельная функция `tx_bcast_flow` @0x938e9c | [код] |
| маска qid 0x802948 | — | txop и fixed-поток (бит 30 в [gp,0xd0]) | [код], смысл — [гипотеза] |

## 9. Опорные инструкции

| # | утверждение | где проверить |
|---|---|---|
| 1 | Запрет TX по CID ставит бит r0 в u16 `0x801b2c[cid]` | 4.1 @0x928ce2, @0x928ce6; 6.2 @0x92ba82/86 (база 0x802a90) |
| 2 | При запрете очереди соседа вычитаются из теней qset 6 и 5 | 4.1 @0x928cfa, @0x928cf4; 6.2 @0x92ba9a/@0x92ba94 |
| 3 | Тень qset публикуется в 0x886d8c+4·i при бите i маски | 4.1 0x9373b0..0x9373fe; 6.2 0x93d0ac, [gp-0x7c] |
| 4 | Снятие возвращает маски только при нулевом u16 причин | 4.1 @0x928dc4; 6.2 @0x92bb64 |
| 5 | Все вызовы запрета/снятия передают причину 3 | §6.1 |
| 6 | Байт причин = `0x857849+0x14·cid`, бит 4 = FW | @0x922332; fw @0x8d8318, таблица 0x801b88 |
| 7 | Ненулевой байт причин при каждом проходе инициатора снова запрещает CID | @0x92684c, @0x926850; вызов @0x93479e |
| 8 | Запрет ставится до проверки LMAC_PASSIVE | 4.1 @0x92b646 раньше @0x92b64c; 6.2 @0x92eb72 раньше @0x92eb78 |
| 9 | qid = R41 биты 16..21, набор = биты 8..11 | @0x933ed0/@0x933ed6 после @0x933e9a |
| 10 | qid 31 уводит TXOP во внутренние передачи; sm 3 = BF | @0x933942; @0x928edc |
| 11 | LMAC 0x08: тип 3 → qset 6, op 1 = удалить | @0x93571e..0x93578c; fw @0x8c27f2 |
| 12 | `hwtail` — звонок драйвера, голова DMA = 0x881818+0x20·idx | txrx.c:2005; @0x8cda92, @0x8cda9e; железо узел B: 0x881838=0, 0x881840=0x15 |
| 13 | LMAC 0x04 задаёт CW командой (0x09+ac)<<24 | `txrx_api_step_c` @0x931a20..0x931a28 |
| 14 | `tx__pick_slot_for_peer` — удвоение/сброс CW | @0x924de2..0x924df2, @0x924dfc, команда @0x924e0e |
| 15 | 6.2: CBAP и fixed scheduling разведены по [gp,-0x34] | @0x937700..0x93770a |
| 16 | precheck есть в 4.1, в 6.2 нет | 4.1 @0x9337fe; 6.2 `tx_slot__dispatch` без вызова |

## 10. Имена, не отражающие назначение (предлагаемые замены)

| версия | текущее имя | адрес | по смыслу |
|---|---|---|---|
| 4.1 uc | `mid_vring_mask_update` | 0x928cb4 | `cid_tx_disable__set` |
| 4.1 uc | `rf_sector__clear_sta_bit` | 0x928d94 | `cid_tx_disable__clear` |
| 4.1 uc | `uc_res_886f00__acquire` | 0x928f2c | `internal_tx__set_pending` |
| 4.1 uc | `uc_pending__clear_bit` | 0x928f6c | `internal_tx__clear_pending_bit` |
| 4.1 uc | `uc_res_vote__acquire` / `__release` | | `internal_tx__lock` / `__unlock` |
| 4.1 uc | `tx__pick_slot_for_peer` | 0x924db8 | `cbap__update_cw` |
| 4.1 uc | `mac__program_qset_slots` | 0x928308 | `cbap__program_cw_all` |
| 4.1 uc | `tx__take_eligibility_slot` | 0x926354 | `keep_alive__pick_next_peer` |
| 4.1 uc | `peer__aid_mismatch_flag` | 0x9374d0 | `qid__to_cid_is_unicast` |
| 4.1 uc | `ucode_cmd__queue_delete` | 0x9354d4 | `ucode_cmd__queue_cfg` |
| 4.1 fw | `encap_trans_type` | 0x8f37b8 | `wmi_handler_vring_cfg` |
| 4.1 fw | `lmac_if_send_cmd_0x08` | 0x8d8864 | `lmac_if__send_queue_cfg` |
| 4.1 fw | `stream_mgr__alloc_pring` | 0x8c2d04 | `stream_mgr__alloc_stream` |
| 4.1 fw | `vring_schd__is_vring_ready` | 0x8c588c | `vring_schd__is_cid_prohibited` |
| 6.2 uc | `uses_g_800400_801104_802a90__92ba54` | 0x92ba54 | `cid_tx_disable__set` (в дереве — `bf__pause_sta_tx`) |
| 6.2 uc | `uses_g_800400_801104_802a90__92bb34` | 0x92bb34 | `cid_tx_disable__clear` (в дереве — `bf__resume_sta_tx`) |
| 6.2 uc | `internal_tx__check_idle` | 0x92bd30 | `internal_tx__set_pending` |
| 6.2 uc | `macreg_r42__938e34` | 0x938e34 | `tx_initiator_flow` (в дереве — `tx_slot__dispatch`) |
| 6.2 uc | `mac_cmd_0x0f__9396f4` | 0x9396f4 | `tx_initiator__build_tx_vector` |
| 6.2 uc | `uses_tbl_80111c__93a088` | 0x93a088 | `tx_initiator_step` |

## 11. Каталог блоков fw: управляющие кадры, TX API, очереди [обе]

Блоки fw 6.2, установленные по лог-строкам и вызовам, с соответствиями 4.1. Запись адреса: `имя` 0x… — адрес 6.2; «/ 4.1 0x…» — адрес той же функции в 4.1 (по
совпадению тела — `6.2/ref/CORRELATION-FW.txt`, по таблице
[NAMES-FROM-62](../4.1/docs/NAMES-FROM-62.md) или по имени); если в 4.1 имя другое, оно
указано; без пометки 4.1 — соответствие не установлено.

* `hexdump_words` 0x8c9790 — шестнадцатеричный дамп буфера («len:%u», затем по
  12 Б тремя словами big-endian «%08x:%08x:%08x»); зовут построители кадров,
  `set_gtk`, discovery, SW TX **[код]**.
* SW TX management (кадры, которые строит хост, splitmac): `send_sw_packet`
  0x8f8dbc / 4.1 0x8f0a94, `handle_packet_splitmac` 0x8f3ba4 (Assoc Resp за хост,
  `handle_packet__args` 0x8ea0a0), `mgmt_tx__render_probe_resp` 0x8f2b40 / 4.1 0x8eb824,
  `SW_TX_MGMT_API__link_up_evt` 0x8dabfc / 4.1 0x8d7ae0, `SW_TX_MGMT_API__packet_release`
  0x8df624 / 4.1 0x8db394, TX-complete `sw_tx_mgmt__tx_complete_cb` 0x8e9b1c,
  `sw_tx_mgmt__clear_link_ctx` 0x8e2930.
* Построение кадров: `mgmt_tx__set_frame_control` 0x8c068c / 4.1 0x8e8974,
  `mgmt_tx__build_mac_header` 0x8d7db8 / 4.1 0x8ec5c0, `mac_hdr__copy_addr` 0x8cc3ac / 4.1 0x8ca180,
  `mgmt_tx__begin_frame` 0x8e9c7c / 4.1 0x8e4be4, `mgmt_tx__copy_ie_hdr` 0x8d7fd4,
  `tx_hdr_build_step` 0x8d7cec / 4.1 0x8ec4f4, `ies_block__is_empty` 0x8da1c0 / 4.1 0x8d70f0; IE —
  `ie__push_wfa_vendor` 0x8e1c94 / 4.1 0x8ef740, `ie__push_qos_capability` 0x8e1f4c / 4.1 0x8ef804,
  `ie__push_dmg_capabilities` 0x8e1fd4 / 4.1 0x8ef87c, `tx_mgmt_get_ie` 0x8e9db0 / 4.1 0x8f1d84,
  `ie__classify_vendor_oui` 0x8e9e04 / 4.1 0x8f1de4 (WSC/P2P по OUI); BA —
  `frame__build_addba_resp` 0x8f4e30 / 4.1 0x8ec664, `frame__build_delba` 0x8f5004 / 4.1 0x8ec860,
  `ba_sm__build_addba_params` 0x8ea62c, `ba_sm__addba_at_08/10`
  0x8c4540/0x8c7edc, `ba_sm__lookup_stream` 0x8eaad8, `ba_sm__prepare_ba_td`
  0x8e0d6c / 4.1 0x8dcad8, `ba_sm_evt_type` 0x8d9c4c, `stream_mgr__delba_tx_complete` 0x8c8d14
  (delba_tx_complete после разрыва), `ba__send_status_report_for_vring`
  0x8c41cc (отчёт о статусе BA), `ba_setup_sm__addba_resp` 0x8f0a44 / 4.1 0x8e92dc,
  `ba_setup_sm__close_all_timers` 0x8f1b84 / 4.1 0x8ea430 и два `ba_setup_sm__close_*`
  (`ba_setup_sm__close_addba_req_retry_timeout_event` 0x8f1bb4 / 4.1 0x8ea460,
  `ba_setup_sm__close_addba_resp_timeout` 0x8f1bd8 / 4.1 0x8ea488).
* TX API: `tx_api__send_mgmt` 0x8e5874 / 4.1 0x8e0c44 (лимит повторов
  `tx_api__get_mgmt_retry_limit` 0x8cc3d0), `tx_api__stamp_seq_bytes` 0x8c84ec / 4.1 0x8c7110,
  `tx_api__count_completion_status` 0x8ead70 / 4.1 0x8e5a78, `tx_api__mask_from_queue`
  0x8e97e8 (LMAC cmd 0x08 + DMA kick; четыре хвоста
  `tail_hwd_dma__kick_channel__*` 0x8d0cec…0x8d0d04, в т. ч.
  `host_irq__raise_fw_int2` 0x8d0cec и `host_irq__raise_mbox_evt` 0x8d0d04; два
  хвоста `tail_set_reg_882680_8d1a98*` — `pcie__set_event_bit_1b_txq` 0x8d1af0 /
  `pcie__set_event_bit_1a_txq` 0x8d1b08), `tx_api__check_state_2` 0x8e7ec4,
  `sm__null_handler` 0x8df4f0 / 4.1 `fwq_tx__on_queue_empty` 0x8db240, `tx_desc_by_index` 0x8cc1ec / 4.1 0x8c9ff8, `tx_list__remove`
  0x8e2884, `llist__pop_front` 0x8e2674 / 4.1 0x8de2d4.
* FWQ: `fwq_tx__on_flush_done` 0x8e9838 / 4.1 0x8e4778, `fwq_tx__flush_by_prio` 0x8cacfc / 4.1 0x8c900c,
  `fwq_tx__find_packet` 0x8cc710 / 4.1 0x8ca508, `FWQ_TX_AVAILABILITY__init` 0x8d9084 / 4.1 0x8d5f68,
  `ps__mark_data_pending` 0x8c2a90 (печать вектора доступности DP),
  `rx_buf__alloc` 0x8c3394, `fwq_tx__count_below_limit`, `fwq_tx__get_count`.
* Потоки и vring: `stream_mgr__check_vring` 0x8caed0 (проверка индекса — зовут
  очень многие), `stream_mgr__build_params` 0x8e2a50, `stream_params__copy_hdr`
  0x8cc19c, `stream_mgr__macq_removed` 0x8c8d9c / 4.1 0x8c774c, `stream_mgr__check_count_a`
  0x8c8774, `stream_mgr__action_step` 0x8cb288, `stream_mgr__ready_step`
  0x8e8310 / 4.1 `frag_8f1908` 0x8f1908, `stream_mgr__ready_for_modify` 0x8e23a4 (ready_for_modify),
  `stream__inject_evt1` 0x8e8354 / 4.1 0x8e3250; `vring_list__find` 0x8ebe80 / 4.1 0x8e727c,
  `vring_schd__find_by_cid` 0x8ebebc / 4.1 0x8e72b8, `vring_is_empty` 0x8d47a0 / 4.1 0x8d16f0,
  `vring__get_pring_id` 0x8cbed8 / 4.1 0x8c9d94, `vring__ack_and_unmask_irq` 0x8d85d4 / 4.1 `vring__disable_and_ack` 0x8d5244,
  `vring__reset_pair(_b)` 0x8c8f68/0x8c9830, `vring__clear_hw_state` 0x8caf30 / 4.1 0x8c92e0,
  `vring_hw__set_ready_bit` 0x8d0598 / 4.1 0x8cd70c, `vring_hw__unmask_irq` 0x8d05f0 / 4.1 `vring_hw__write_disable` 0x8cd764,
  `vring__reg_write_locked_20` 0x8d0508 / 4.1 0x8cd67c, `hwd_dma__set_ring_base` 0x8d0468 / 4.1 0x8cd5dc,
  `hwd_dma__ack_881c44` 0x8d05c0 / 4.1 0x8cd734, `sw_vring__program_ba_win` 0x8e4094 / 4.1 0x8df4cc,
  `vring_ctx__alloc` 0x8c3490 (из `wmi_vring_cfg`), `list__insert_obj__8c1cc0`.
* MAC-очереди: `macq_desc__write` 0x8c5010 и `macq_desc__read` 0x8c50f8 —
  запись/чтение дескриптора очереди MAC (окно 0x886600/0x886614, поля 2/3/5
  бит), три хвоста (`macq_desc__read_t1_w3_n3` 0x8e4424 / 4.1 `tail_vring__write_macq_desc` 0x8df88c,
  `macq_desc__read_t1_w0_n2` 0x8e4430 / 4.1 `tail_vring__write_macq_desc_8df898` 0x8df898, `macq_desc__read_t1_w2_n1` 0x8e443c / 4.1 `tail_vring__write_macq_desc_8df8a4` 0x8df8a4);
  `qh__write_by_flags_fw` 0x8dd90c (348 Б — запись заголовка очереди по
  флагам); `tx_macq__is_empty` 0x8da15c / 4.1 0x8d7084, `tx_macq__setup_params` 0x8c6e44,
  `tx_macq_api_step` 0x8d986c / 4.1 0x8d67cc, `mac__set_cid_mcs` 0x8ea3b8,
  `rx_macq__bind_queue` 0x8e42b8 / 4.1 0x8df710, `rx_chain__configure(_b)` 0x8c44bc/0x8c4508,
  `mac_bringup__init_rx_fields` 0x8e4510.
* DMA-менеджер: `dma_mgr__reset_queue` 0x8e7f6c / 4.1 0x8e2e78 (из `wmi_pmc`),
  `dma_mgr__reset_queue_0x19/0x1a` 0x8e9ba0/0x8ea15c, `tx_api__init_pools`
  0x8f552c (их общий вызов при init), `get_g_8031c8_8da528/8da544`,
  `tx_dma__build_desc` 0x8ea2f0 / 4.1 0x8e4f58; `dmaq_hw__reset_ptrs` 0x8d0d44 (76 Б, шаг
  STREAM_MGR).
* L2 offload RX: `l2_offload__cfg_rx_decap` 0x8c7070 / 4.1 0x8ea660 (тип decap, SNAP, VLAN,
  L3), `dma_offload__pack_decap_cfg` 0x8df530 / 4.1 0x8db290, `dma__set_881b94_bits45`,
  `l2_offload__set_rx_decap_cfg` 0x8df5a8 / 4.1 `set_reg_881b30` 0x8db318, `rx_macq__program_offload_desc`
  0x8df65c (+хвост `rx_macq__program_offload_desc_with_b4` 0x8e2474).
* RX management: `rx_mgmt__find_free_ei` 0x8c3370 / 4.1 0x8c2bd0, `rx_pkt__lookup_handler`
  0x8cc118 / 4.1 0x8c9f74, `rx_pkt_srvs__dispatch_default` 0x8e3a90 / 4.1 `tail_rx_pkt_srvs__dispatch` 0x8deecc, `rx_pool__set_fields`
  0x8d9394 / 4.1 0x8d6384.
* Отладка/UT: `hw_sysapi_get_rx_energy_data_free_run` 0x8cded0,
  `hw_sysapi_get_rx_packet_energy_statistics` 0x8cdf70,
  `hw_sysapi_rx_omni_sector_set` 0x8ce40c, `link_lost_diag__dump_dma` 0x8c84d4 / 4.1 0x8eac08,
  `link_lost_diag__rx_status` 0x8f4680 / 4.1 0x8d4600, `mdm_stt_rx_crc_ok` 0x8caeac,
  `ut_hw_cmd_008__params` 0x8e6f94; `txrx_sel` 0x8ea5f0 / 4.1 0x8e52c4 (RX/TX-сектор; «NO RF»).
* PSC TX-колбэки: `ps_conn_mgr__psc_req_tx_wb_cb` 0x8e1a18 и
  `ps_conn_mgr__psc_resp_tx_wb_cb` 0x8e1b30 (C++-переходник this+0x38 + тело
  PS_CONNECTION_MGR::…), собственно `psc_if__psc_req_tx_wb_cb` 0x8e1a58 и
  `psc_if__psc_resp_tx_wb_cb` 0x8e1b70.
* Мелочь: геттеры конфигурации очередей для `tx_queue__config_by_mode`
  (`qdesc_cfg__get_flag_bit3` 0x8cc2ec … `rf_chain__get_override_desc_bit0`
  0x8cc35c, в т. ч. `txq_cfg__field_0e_or_default`, и
  `tx_queue__default_size_140`), `rx_macq__get_cfg_word`,
  `rx_chain__get_cfg_word`/`rx_chain__set_payload_size` 0x8e7138,
  `rx_chain__get_cfg_mode`, `rx_macq__entry_addr`, `vring_tbl__entry_addr`,
  `vring__active_ring_table`, `vring_tbl__find_by_tid_cid`,
  `ps__sta_has_pending_data`, `peer__check_flag_30` 0x8c6844,
  `ba_sm__get_param_byte6`, `ba_sm__get_param_byte7`, `macq_hw__set_low_nibble`,
  `rx_energy__calc_rssi_q4`, `wmi_evt__init_desc`, `conn__sec_mode_not_1`,
  `vring__get_pring_id_of_obj`, `mid_list__by_obj_mid`,
  `stream_mgr__reset_vring_thunk`, `vring__send_en_evt_u8`, `bits__set32_s0_w4`.
  Милли-код сохранения/восстановления регистров (`__st_r16..r19_to_r13`,
  `__ld_r13..r19_to_r13_ret`) — [FW-UTILITIES](FW-UTILITIES.md#6-милли-код).

## Замечания

* В `4.1/ref/SM-TABLES.txt` имена состояний BA_SETUP_SM склеены (дефект
  генератора таблиц).
* `hwtail == swhead` в debugfs не означает, что MAC забрал дескрипторы: это
  адрес звонка, пишет его драйвер (§4).
* Адрес `0x80147c` в 6.2 описан двумя способами: как TA продления NAV (§3.4, по
  `rx_nav__set_from_duration`) и как вектор разрешённых MCS
  (`maintain_sm::config_mcs_en_vec`, [UCODE-TASKS.md](UCODE-TASKS.md) §3.2).
  Какое назначение верно (или поле разделяемое) — не проверено.
* `r42` бит 19 = `busy_event`, бит 14 = `busy2_event` (имена по
  `6.2/ref/MSXD-LR-RGF.txt`).

## Не установлено

* Побитовая раскладка правила разборщика MAC и живое содержимое таблицы правил.
* Что `wmi_handler_cfg_rx_chain` программирует для кольца хоста (декапсуляция
  `dma_offload__set_rx_decap` @0x8db2c0 и пр.).
* Смысл аргументов `rx_macq__setup` после индексов.
* Где в 6.2 фактически отправляется `WMI_RX_MGMT_PACKET_EVENTID` из ветки 0x31.
* Подозрительные имена 6.2: MLME-обработчик на месте 4.1 `rx_pkt_handler`
  назван `discovery__rx_pkt_handler` (0x8e3d08, 516 Б), обработчик Action No Ack
  — `channels_switch_sm__action_pop_ch_and_tune` (0x8c21e0); вероятно, ошибка
  переноса имён корреляцией.
* Смысл бита 6 в байте причин BF (6.2) и маски qid 0x802948 (6.2).
* Действует ли запрет CID в потоке fixed scheduling 6.2.
* Может ли qset 3 (ответчик) передавать юникаст при запрещённом CID.
* Роль тайм-слотов PRING при числе колец больше 2.
* Раскладки колец и очередей fw 6.2 против 4.1 (адреса глобалов сдвинуты).
* 82 блока тракта fw 6.2 без лог-строк — не разобраны по вызовам.

## Источники

* `4.1/ref/SM-TABLES.txt`, `4.1/ref/GLOBALS-uc.txt`, `6.2/ref/MSXD-LR-RGF.txt`,
  `6.2/ref/REGS-62.md`.
* Драйвер: `SparRAW-driver/…` (`txrx.h`, `txrx.c`).
* [STATE-MACHINES.md](STATE-MACHINES.md), [BF-ENGINE.md](BF-ENGINE.md),
  [UCODE-TASKS.md](UCODE-TASKS.md), [WMI.md](WMI.md).
