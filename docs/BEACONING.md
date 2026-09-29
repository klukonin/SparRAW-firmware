# Биконинг: конфигурация, передача маяка, рандомизатор, NAV, окна BI

Общая для 4.1.0.1000 и 6.2.0.1000 механика биконинга в микрокоде (ucode) и прошивке (fw):
команда конфигурации `CMD_BCON_MGT` и блок `fui_bi_cfg_params_s`, путь от события TBTT до
развёртки маяка по секторам, рандомизатор отсрочки маяка и его гейт, NAV-отсрочка, автомат BI
и окно AW, период BI, отчёт MAC_MON, состояние механизмов на железе.

Метки доказанности: **[железо]** — проверено на стенде, **[код]** — по листингу/дизассемблеру,
**[пак]** — по вендорским именам пака 11ad, **[гипотеза]** — не проверено. Пометки версии:
**[4.1]**, **[6.2]**, **[обе]**. Адрес без пометки версии относится к 4.1. Адреса данных ucode —
в пространстве ucode; с хоста (debugfs `mem_addr`/`mem_write`) те же ячейки видны как
host = A + 0x140000 (`0x801438` → `0x941438`); запись по линкерному адресу 0x80xxxx попадает в
данные прошивки.

Специфика версий: раскладка блока конфигурации 4.1, обработчик 0x0B 4.1 и его читатели —
[../4.1/docs/BEACON-CONFIG.md](../4.1/docs/BEACON-CONFIG.md); лог ucode 4.1, телеметрия
MAC_MON 4.1 (блок счётчиков `0x854de0`), ATIM и допуск к передаче 4.1, совместимость WMI 4.1 —
[../4.1/docs/UCODE-BEACON.md](../4.1/docs/UCODE-BEACON.md); однобайтовый патч гейта и образы —
[../4.1/docs/DISTBCN-PATCH.md](../4.1/docs/DISTBCN-PATCH.md); поведение 6.2 на стенде (таймер
BI станции, двойной буфер MAC_MON 6.2) — [../6.2/docs/BENCH.md](../6.2/docs/BENCH.md).

Смежные документы: регистры TSF, компаратор и таймер BI —
[HARDWARE-BLOCKS.md](HARDWARE-BLOCKS.md#блок-tsf-и-таймеров-mac-0x886d180x886ec0); регистры
чтения MAC (`BI_COUNTER`, `BACKOFF_IFS_STATUS`) — [MAC-REGISTERS.md](MAC-REGISTERS.md); кольцо
команд MAC и маячные коды 0x2a/0x2b/0x2d/0x30 — [MAC-COMMANDS.md](MAC-COMMANDS.md); тела LMAC
0x0b/0x23/0x25 — [LMAC-PROTOCOL.md](LMAC-PROTOCOL.md); автоматы `basic_sm` —
[STATE-MACHINES.md](STATE-MACHINES.md); соответствие 802.11ad (ATI/ATIM, A-BFT, кластеризация,
интервал маяка станции) — [STANDARD-MAPPING.md](STANDARD-MAPPING.md).

## 1. Адреса по версиям

| объект | 4.1 | 6.2 |
|---|---|---|
| отправитель `CMD_BCON_MGT` (fw) | `lmac_if__send_bcon_mgt` 0x8d80dc | `lmac_if__send_bcon_mgt` 0x8db288 |
| сборка тела (fw) | `lmac_if__build_bcon_cfg` 0x8d80b4 | `lmac_if__build_bcon_cfg` 0x8db260 |
| поля BI Control / развёртки (fw) | `bcn_tx_init_bi_cfg` 0x8c3c98, `bcn_tx_init_ss_params` 0x8c3d2c | 0x8c45d4, 0x8c4664 |
| discovery-маяк (fw) | `add_discovery_bcon` 0x8c22e4, `find_mng__add_bcon` 0x8c225c | 0x8c2904, 0x8c2870 |
| активный скан (fw) | `scan_mngr__sm_ready_for_dwelling` 0x8f0d9c | 0x8f9160 |
| старт PCP (fw) | `pcp_start` 0x8eef18, `l2_mgr__pcp_start_flow` 0x8dc544 | 0x8f7110, 0x8e0778 |
| обработчик LMAC 0x0b (ucode) | `ucode_cmd__bi_config` 0x932f8c | `ucode_cmd_0x0b_handler` 0x937da4 → `ucode_cmd_0b__apply` 0x92b198 |
| блок `fui_bi_cfg_params_s` («bcon_kind» = `bi_mode`) | **0x801438** (host 0x941438) | **0x8022a8** |
| 64-битный накопитель TSF рандомизатора (+0x18/+0x1c) | 0x801450/0x801454 | 0x8022c0/0x8022c4 |
| развилка «что передавать» | `bi__decide_beacon_kind` 0x9311a4 | `bti__prepare_sweep_set` 0x935b9c |
| развёртка маяка с рандомизатором | `bti_worker__bti_transmitter_beacon_sweep_flow` 0x923de0 (1564 Б) | 0x923cb4 (1368 Б) |
| гейт `bi_mode == 2` | `0x923e0c cmp r7,0x2` | `0x923cda cmp r9,0x2` |
| шаг развёртки по секторам | `bcon_txss_sweep_step` 0x935a4c | 0x93b430 |
| ветка окон GP для BF-метрики | `bti_transmitter_bi2_flow` 0x923c74 | 0x923b50 |
| ворота BTI | `bti__bi2_event_step` 0x931f8c, `uc_bi_counter_in_window` 0x932508, `uc_read_bi_sync` 0x931c64 | 0x936e40, 0x937474, 0x936b60 |
| компаратор TSF | `set_tsf_event` 0x930c28, `disable_tsf_event` 0x925120 | 0x935680, 0x925a10 |
| чтение TSF | `uc_read_tsf_lo` 0x9315e8, `uc_read_tsf64` 0x930cb0 | `uc_read_tsf_lo` 0x9364c8, `mac__read_tsf64_uc` 0x9356cc |
| ожидание событий MAC | `uc_wait_event_busy` 0x931808 | 0x9366e8 |
| NAV | `nav_db__update` 0x92a6f4, `rx_nav_update` 0x92fd3c, `rx_nav_bi_step` 0x92fb20 | `rx_nav_update` 0x934590, `rx__update_nav_from_frame` 0x9343a8, `rx_nav__set_from_duration` 0x92dd30 |
| discovery_mode (LMAC 0x24) | `ucode_cmd__discovery_mode_cfg` 0x934de4 | `ucode_cmd_0x24_handler` 0x93a830 |
| AW IE (LMAC 0x25) | `ucode_cmd_update_aw_ie` 0x9357e4 → `aw_ie__copy_to_bcon` 0x930420 | `ucode_cmd_0x25_handler` 0x93b1f8 → 0x934d54 |
| установка AW | `aw__set_new_tbtt` 0x930770, `aw__set_tbtt_offset` 0x930488 | 0x93520c, 0x934dbc |
| автомат BI | `BI_AP_MONITOR_SM`, объект 0x801de8 | `bi_sm`, объект 0x800600 |
| событие MAC_MONITOR (ucode→fw) | `uc_send_evt__mac_monitor` 0x925b84 | 0x927530 |

Совпадение имён двух деревьев — перенос по телу функции или по вендорской лог-строке
([CROSS-VERSION.md](CROSS-VERSION.md), [../4.1/docs/NAMES-FROM-62.md](../4.1/docs/NAMES-FROM-62.md)).

## 2. Конфигурация биконинга

### 2.1. `CMD_BCON_MGT` (LMAC 0x0b) **[обе]** **[код]**

Содержимое и расписание маяка задаются однократно командой fw→ucode **0x0b** (в 4.1 длина
0x94). Тело: `+0x00` — `mode` (трёхпутевой разветвитель обработчика), `+0x04..` — дескрипторы
развёртки секторов, `+0x74` — 32-байтовый `fui_bi_cfg_params_s`, который обработчик копирует
в блок конфигурации (`memcpy(0x801438, cmd+0x74, 0x20)` в 4.1). Поля и вендорские имена —
[LMAC-PROTOCOL.md §3.2](LMAC-PROTOCOL.md#32-команда-0x0b-fui_bi_cfg_params_s-и-дескрипторы-развёртки-код-пак);
побайтовая раскладка 4.1 и её источники в поле `bss_bi_ctrl` —
[../4.1/docs/BEACON-CONFIG.md](../4.1/docs/BEACON-CONFIG.md).

Первое слово блока — `bi_mode` (в документах 4.1 — «bcon_kind») **[пак]**:

| значение | вендорское имя | смысл |
|---|---|---|
| 0 | `BI_RX_BCON` | не сконфигурирован / только приём |
| 1 | `BI_TX_BCON` | обычный маяк (PCP/AP) |
| 2 | `BI_TX_DISCOVERY_BCON` | DMG Discovery Beacon при активном скане |
| 3 | `BI_TX_DIRECT_SINGLE_BCON` | discovery при direct scan (MAC цели в `+0x0b`) |

Поле `mode` (cmd+0x00) и `bi_mode` (cmd+0x74) — разные поля: `bss_mode == 2`
(ADHOC/ADHOC_CREATOR) даёт `mode = 2`, но `bi_mode` обычного маяка всегда 1, поэтому
рандомизатор не включает ([../4.1/docs/BEACON-CONFIG.md](../4.1/docs/BEACON-CONFIG.md)).

Путь параметров BI от хоста до MAC [4.1, код]:

```
хост: WMI (BI и пр.)
  → fw: bcn_tx_init_bi_cfg (0x8c3c98) — упаковка битовых полей в cmd+0x78..0x88
        bcn_tx_init_ss_params (0x8c3d2c) — параметры секторной развёртки
  → fw: lmac_if__send_bcon_mgt (0x8d80dc, «Send CMD_BCON_MGT»):
        cmd+0x74 = bi_mode; ucode-команда 0x0B, 0x94 Б
  → ucode: ucode_cmd__bi_config (0x932f8c) → memcpy(0x801438, cmd+0x74, 0x20)
  → ucode: bi_cfg__apply (0x9331d8) — разбор 32-байтового конфига в битовые поля
  → ucode: длительность BI в 0x801434 → 0x886d18/1c через mac__program_deadline_slack;
           момент маяка — в компаратор 0x886d30/34/38
```

Команда 0x0b удаляет маяк тем же кодом: `lmac_if__stop_beacon` 0x8d815c [4.1],
`lmac_if__send_bcon_del_0b` 0x8db304 [6.2].

Покадрово прошивка в передаче маяка не участвует: на интервал маяка 1,00 события PRE TBTT
(0x17) и 1,00 события awake peers (0x16) ucode→fw, команд fw→ucode, связанных с маяком, —
0,00 (5944 интервала непрерывного потока лога ucode). Команды 0x03 (RX OFF) — 0,41 на интервал,
0x01 (RX ON) — 0,20 **[4.1, железо]**.

### 2.2. Кто ставит `bi_mode` **[обе]** **[код]**

```
networkType ADHOC(2)/ADHOC_CREATOR(4)                          [fw]
  (pcp_start_inner: bss_mode = (networkType==0x10 AP) ? 3 : 2)
  └─► bss_mode==2 (vif+0x4c) ─► tx_bcon ─► mode=2 (cmd+0x00), bi_mode=1
        └─► ucode, обработчик 0x0b: ветка mode 2 (adhoc) — пересборка
            BI-Control и программирование MAC

активный скан                                                  [fw]
  (find_mng::add_bcon / scan_mngr::sm_ready_for_dwelling)
  └─► add_discovery_bcon(ctx, scan_type) ─► bi_mode=2 (scan_type≠3) или 3 (scan_type==3)
        └─► bi_mode==2 ─► развилка ─► развёртка с рандомизатором
```

* `find_mng::add_bcon()` (4.1 0x8c225c, 6.2 0x8c2870) — лог
  `FIND:: <<<<< ADD DMG DISCOVERY BEACOM >>>>>`, затем
  `find_mng::add_bcon() - ACTIVE SCAN - add_discovery_bcon()`;
* `scan_mngr::sm_ready_for_dwelling()` (4.1 0x8f0d9c, 6.2 0x8f9160) —
  `... -> ACTIVE SCAN - add_discovery_bcon()`;
* `pcp_start()` (4.1 0x8eef18, 6.2 0x8f7110) перед передачей маяка сбрасывает бит
  discovery_mode (`*(vif+0x14f) &= 0xfd` в 4.1) и логирует
  `[NNL] discovery_mode %d, PCP_assoc_ready %d` ⇒ маяк PCP идёт с `bi_mode = 1`, по TBTT,
  без рандомизации.

Смысловая связь с патентом US8520648: случайная отсрочка применяется там, где общего
расписания ещё нет — при взаимном обнаружении; синхронизированные узлы передают по TBTT.

Цепочка 6.2 от WMI **[6.2, код]**:

```
WMI_PCP_START (0x918) / WMI_BCON_CTRL
  → wmi_pcp_start_cmd_handler 0x8ec840
  → l2_mgr__pcp_start_flow 0x8e0778
      m_bss_mode = 3 при network_type == 0x10 (AP), иначе 2 — оба «маячные»
  → LMAC 0x1b (conn__alloc_and_link 0x8e5258)
  → ucode_cmd_0x1b_handler 0x92e748: 0x8014c0 = (bss_mode ∈ {2,3})
  → 0x8004f4 = 1 (AP) либо 2 (STA) — выбор автомата в l1_task__main_step
содержимое маяка — LMAC 0x0b: lmac_if__send_bcon_mgt 0x8db288 → ucode_cmd_0x0b_handler 0x937da4
  (в обработчике add3 r1,r13,0xa = +0x50, а не +0xa)
```

Запретительной проверки «STA не маячит» в 6.2 нет: три гейта (`m_bss_mode`, 0x8014c0,
0x8004f4) питаются командами хоста; не обходится настройкой только `935ce2 bbit0 r7,0x1e` —
аппаратный признак из local-read MAC (запрос 0x1d000300).

Читатели `bi_mode` в 6.2 (по дереву исходников): `bti__prepare_sweep_set`,
`bti_worker__bti_transmitter_beacon_sweep_flow`, `ucode_cmd_0x0b_handler`,
`bi_cfg__pack_words_78_7c` 0x938004, `bi_cfg__tick_counters` 0x937cac, `l1_task__dispatch`
0x934e30 **[6.2, код]**. Читатели 4.1 —
[../4.1/docs/BEACON-CONFIG.md](../4.1/docs/BEACON-CONFIG.md#читатели-блока-в-ucode).

### 2.3. Снимок конфигурации на стенде (AP) **[4.1, железо]**

`g_bi_cfg_params` 0x801438 (host 0x941438): +0x00 bi_mode = 1, +0x04 n_bis_abft = 4,
+0x05 n_abft_in_ant = 0, +0x06 responder_abft_ratio = 0, +0x07 fss = 15, +0x08 bi_at_ratio = 0,
+0x09 txss_span = 1, +0x0a abft_length = 1, +0x0b abft_responder_address, +0x14 flags = 8
(pcp_assoc_ready), +0x18 tsf = 0x08113400.

`g_bi_ctrl_mgr` 0x80142c (host 0x94142c): next_abft = 2, n_abft_in_ant_index = 0xd5,
is_responder_txss = 1, next_beacon = 0, bi_at_ratio = 0, next_at = 0x0f, +0x08
beacon_interval_usec = 0x19000. Запись bi_at_ratio = 1 (0x941440) пересчитывает next_at в 0
(`next_at = bi_at_ratio − 1`, иначе 0xf); счётчики ATIM 0x857038/0x85703c остаются нулевыми.

### 2.4. Режим обнаружения — LMAC 0x24 **[обе]** **[код]**

fw: `lmac_if_discovery_mode_cfg_handler` (4.1 0x8d84a8, 6.2 0x8db724), тело
`{discovery_mode, discovery_type}`. ucode 4.1 — `ucode_cmd__discovery_mode_cfg` 0x934de4
(`txrx_api_cmd_handler.c`):

```c
cmd  = get_params();
type = cmd[1];                        // «Type» из лога, сохраняется в gp-0xef
if (cmd[0] == 0) {                    // DISCOVERY OFF
     LOG("DISCOVERY OFF (Type, tail, head)"); LOG("[NNL] non_idle_mask");
     *(gp+0x1c) = 0;
     if (tail < head) bf_clear_all_sta();          // 0x92211c
} else if (cmd[0] == 1) {             // DISCOVERY ON
     LOG("DISCOVERY ON (Type, tail, head)"); LOG("[NNL] non_idle_mask");
     perform_shallow_sleep(0x801ed0,0,0,1,1);      // 0x92af4c, запрет сна
     *(gp+0x1c) = 1;
} else ASSERT();
```

Глобалы 4.1: `0x800f60` = `non_idle_mask`, `0x800f6c`/`0x800f70` — tail/head очереди
discovery, флаг режима — `gp+0x1c`.

ucode 6.2 — `ucode_cmd_0x24_handler` 0x93a830: «DISCOVERY ON/OFF (Type)», сброс BF всех
станций (`bf_clear_all_sta` 0x9218b4), проверка `ucode_cmd_24__check` 0x93d31c; байт +0x164
копирует `ucode_cmd_0x24__copy_byte_164` 0x93dac0 **[6.2, код]**.

## 3. Путь передачи маяка

### 3.1. Контур событий **[4.1, код]**

```
аппаратные события
  ├─ 0x886dd4  причины L1-прерывания (биты 0/1/2)
  │     └─ l1_task__entry (0x929738), «L1_TASK PRE TBTT» (l1_task.c) — диспетчер L1-задач
  ├─ bti__bi2_event_step (0x931f8c) — «BI1 interrupt Out Of BTI period»
  └─ прочие входы: 0x9310f6 (в bi_ap_mon__aw_event), 0x9312ee (в bi_ap_mon__dti_event),
                   0x931154 bi_ap_mon__bti_event, 0x93171c bi_mode_init_sequence
                      │
                      ▼
        обёртка входа в автомат (напр. bi_ap_mon__bti_event, 0x931154):
            событие = байт аргумента, маска 4 бита (до 16 типов)
            метка трассировки 0xcaf000 | событие → кольцо MAC (r25)
            статистика: контекст 0x801e14 (счётчик +0x4, последнее событие +0x12)
            контекст автомата → 0x801e94
                      │
                      ▼
        bi_manager__kind_switch (0x9289e4) — диспетчер состояний
            state = bi__decide_beacon_kind(ctx, evt)
            if (state < 6) call table[0x800ed4 + state*4]()   (6 состояний)
                      │
                      ▼
        bi__decide_beacon_kind (0x9311a4)
            if (bi_mode != 0 && r41 бит 30 && ctx->kind != 1)
                  → bti_worker__bti_transmitter_beacon_sweep_flow (0x923de0)
            else  → bti_transmitter_bi2_flow (0x923c74)
                      │
                      ▼
        bti_worker__bti_transmitter_beacon_sweep_flow (0x923de0)
            гейт bi_mode == 2 && ctx->kind == 0 → рандомизатор (§4) → set_tsf_event
            NAV-отсрочка (§5)
            развёртка по секторам: bcon_txss_sweep_step (0x935a4c)
```

| адрес | назначение |
|---|---|
| `0x801e14` | контекст статистики событий автомата (счётчик +0x4, последнее событие +0x12) |
| `0x801e94` | контекст автомата биконинга (передаётся диспетчеру) |
| `0x800ed4` | таблица 6 обработчиков состояний (строится при работе) |
| `0x801434` | длительность BI |
| `0x801438` | 32-байтовый конфиг биконинга |
| `0xcaf000` / `0xcafcaf` / `0xcafcaa` | трассировочные маркеры в кольцо MAC (через r25) |

`ctx->kind` — аргумент события. На TBTT `l1_task__entry` подаёт `kind = 0`: вход code = 0
диспетчера `bi_ap_mon_if__trigger` 0x9304c8 передаёт аргумент насквозь
(`9298c4 mov_s r0,0 ; 9298c6 bl.d 0x9304c8 ; 9298ca mov_s r1,r0` — аргумент 0 в слоте
задержки; `mov r2,r13` @0x930508 → `basic_sm__dispatch_loop`), и `brne r0,0x1` @0x93124c
уводит в развёртку @0x923de0 **[код + железо: `ctx->kind = 0` измерено]**. Путь
`kind = 1 → bti_transmitter_bi2_flow` приходит из `bi_manager__run_rx_flow_by_kind` по биту 19
`busy_event` (среда занята), а не по TBTT. `bti_transmitter_bi2_flow` маяк не передаёт:
каталог `bf_gpc_service` (ассерт `bf_gpc_service.h:134`), обслуживает окна таймеров
GP0/GP1/GP2 для сбора BF-метрики, функций передачи не зовёт и TX-команд в кольцо не кладёт
**[код]**.

В развилке `bi__decide_beacon_kind` (0x9311f4..0x931246) перед проверкой бита 30 стоит запрос
к MAC: `mov_s r3,0xf000001` (0x9311fe, команда 0x0f — поиск набора очередей; число
`0x0f000001` в кольце равно числу вызовов развилки), чтение селектора 0x0300
(`or r2,r2,0x1d000300` @0x931224), три `nop`, результат в r41, `bbit0 r4,0x1e,0x931250`
@0x931246. Бит 30 r41 (`QSET_1_MASK_VECTOR`) — «маяк поставлен в очередь» (очередь 30); биты
0..29 того же регистра проверяет путь управления питанием (`in_r41 & 0x3fffffff`) **[код]**.
Позиция поля селектора зависит от регистра результата: для r40 — биты 12..15, для r41 —
биты 8..11.

Путь 6.2 **[6.2, код]**:

```
событие bi1 → l1_task__dispatch 0x934e30 → bi_sm → bi_sm__action_935b4c
  → bti__prepare_sweep_set 0x935b9c     развилка «что передавать» по [0x8022a8]
  → bti_worker__bti_transmitter_beacon_sweep_flow 0x923cb4
  → bcon_txss_sweep_step 0x93b430
```

### 3.2. Ворота передачи маяка **[обе]** **[код]**

`bti_transmitter_bi2_flow` начинается с

```c
if (*ctx != 1 && bti__bi2_event_step() == 0) return;   // не передавать
```

а `bti__bi2_event_step` (4.1 0x931f8c, 1108 Б) пропускает дальше, только если

```c
if (uc_bi_counter_in_window() == 0 || uc_read_bi_sync() == 0) {
      LOG("BI1 interrupt Out Of BTI period");  return 0;      // строка 0x2fa0
}
```

| ворота | функция (4.1 / 6.2) | условие |
|---|---|---|
| A — окно BTI | `uc_bi_counter_in_window` 0x932508 / 0x937474 | `pos = MAC_read(0x4000) & 0x3ffffff; return (BI_end − 15 < pos) \|\| (pos < 0x9c4);` (0x9c4 = 2500 мкс) |
| B — синхронизация BI | `uc_read_bi_sync` 0x931c64 / 0x936b60 | `return MAC_read(0x4000) >> 31;` |

Селектор `0x4000` в обоих воротах — регистр `BI_COUNTER`: младшие 26 бит — позиция в BI
(`bi_counter`), бит 31 — `bi_sync`. Маяк уходит только внутри BTI и только при
синхронизированном BI ([MAC-REGISTERS.md](MAC-REGISTERS.md#bi_counter-и-бит-31--bi_sync)).
`bti__bi2_event_step` в цикле зовёт `bti_worker_bi2_step` (4.1 0x923ba8, 6.2 0x923a84) и
работает с регистрами MAC через r25/r40/r42 и gp-относительные слоты. Длительность BI для ворот
A — `0x801434` (читают 0x93253e, `shallow_sleep_rfc_step` 0x9219c8,
`power_manager__decide_shallow_sleep` 0x92ad98).

### 3.3. Ожидания внутри развёртки **[код]**

Последний барьер перед выдачей кадра в MAC — `uc_wait_event_busy(0x4002, 0)` по **0x924058**
[4.1]: ждёт `slot_event` (r42 бит 1) или `busy2_event` (бит 14), при `busy2` отменяет развёртку на
этот BI. Всё после него — эфир (`0x29000002` и спин по r45 бит 31
`MTP_TX_PERMISSION_RESP.valid` в `bcon_txss_sweep_step`). В `4.1/ref/WAIT-SITES-UC.txt` маска
этого места занижена до `busy2`. Ожидание `txop_event` (r42 бит 7) — 0x924168/0x9241b8 [4.1].

6.2: внутри 0x923cb4 — ожидание `uc_wait_event_busy(0x4002)` (`slot_event | busy2`), затем
ожидание `txop_event` (r42 бит 7, 0x923fd4) и отмена по `busy2` (r42 бит 14, счётчик
0x80062c) **[6.2, код]**.

Ни одно из 168 мест ожидания ucode 4.1 (66 вызовов примитивов + 102 встроенных самоцикла) не
ждёт бит 6 r42 `tsf_event` **[4.1, код]**.

Кандидаты вставки задержки маяка (не применялись): пауза на GP0 перед 0x92400c пятью словами,
скопированными из `bti_transmitter_bi2_flow` (0x923ce0..0x923d10), с длительностью из слова ОЗУ,
меняемого с хоста; без правки прошивки — сдвиг TBTT через слова BI-конфига 0x8005a8/0x8005ac
**[гипотеза]**.

## 4. Рандомизатор отсрочки маяка **[обе]**

### 4.1. Ядро **[код]**

`bti_worker::bti_transmitter_beacon_sweep_flow()` (исходник `bti_worker.cpp`) несёт строки
`...randomize beacon`, `...current_tsf: 0x%08x, Next tsf: 0x%08x, uniform_random: %d`,
`Beacons delay due to NAV started at 0x%08x`. 4.1:

```c
if (bi_mode == 2 && ctx->kind == 0) {        // bi_mode = *(u32*)0x801438
    LOG("randomize beacon");
    uniform = (int)((u64)r47 * 0xbd >> 32) + 10;   // [10, 198]
    cur  = uc_read_tsf_lo();                       // 0x9315e8, текущий TSF (только в лог)
    dly  = shl64(uniform, 0, 10);                  // 0x920438: uniform << 10
    *(u64*)0x801450 += dly;                        // накопитель +0x18/+0x1c блока
    set_tsf_event(0x801450);                       // 0x930c28: компаратор TSF
    LOG("current_tsf: %x, Next tsf: %x, uniform_random: %d", cur, next, uniform);
}
LOG("Beacons delay due to NAV started at 0x%08x", ...)   // NAV-отсрочка (§5)
```

Листинг вокруг гейта и MAC-команды 0x30 (4.1):

    0x923dfc  mov r13,0x801438   ; g_bi_cfg_params
    0x923e04  ld  r7,[r13]
    0x923e0c  cmp r7,0x2         ; bi_mode == BI_TX_DISCOVERY_BCON ?
    0x923e14  bne 0x00923f4c     ; иначе в обход
              ld r10,[r17] ; cmp r10,0 ; bne 0x923f4c   ; ctx->kind == 0 ?
    0x923e74  or  r6,r6,0x1d020000   ; селектор 2 = LFSR_VAL
    0x923e92  mov r3,r47             ; аппаратный LFSR
    0x923e94  mulu64 r3,0xbd         ; x189
    0x923e98  mov r0,mhi             ; старшая половина (метод Лемира)
    0x923e9c  add r15,r0,0xa         ; +10 -> [10, 198]
    0x923ea0  or  r2,r15,0x30000000
    0x923ea8  mov r32,r2             ; MAC-команда 0x30 с задержкой
    0x923edc  bl  set_tsf_event

* Источник случайности — **r47**, аппаратный LFSR регистрового файла MAC (`LFSR_VAL`,
  селектор 2); деления нет: `(r47 * 0xbd) >> 32` — multiply-shift редукция, равномерно в
  [0, 189), `+10` ⇒ **uniform_random ∈ [10, 198]**. Тот же LFSR_VAL читает
  `abft_responder_worker` (слот ответа в A-BFT).
* `shl64` (0x920438) — 64-битный сдвиг влево (`bmsk.f r2,r2,0x5` и два `asl`), задержка
  **uniform × 1024 мкс** (≈ 10…203 мс, среднее ≈ 104 × 1024 ≈ BI 102 400 мкс) **[код + железо]**.
* Накопитель `0x801450/0x801454` (+0x18/+0x1c блока конфигурации) ни с чем не сверяется:
  каждый проход прибавляет задержку к прежнему значению, текущий TSF в цель не входит.
* В обходе 0x923e1c…0x923f4c лежат также запись в лог, отправка 0x1d020000, `uc_read_tsf_lo`,
  приращение накопителя и вызов `set_tsf_event` @0x923edc — при закрытом гейте компаратор TSF
  не взводится. Между 0x923f4c и вызовом развёртки 0x9240d4 есть не менее четырёх условных
  выходов: 0x923f54, 0x923f78, 0x924004 (порог 30000 мкс), 0x924068 (бит 14 r42).
* Перед работой развёртка проверяет `idle_detect == 5` (`BACKOFF_IFS_STATUS`), иначе ассерт
  `0x9243b4`.

`set_tsf_event` пишет `0x886d30 = цель_lo`, `0x886d34 = цель_hi`, `0x886d38 = 0xc0050`
(взвести), `disable_tsf_event` — `0xc0010` (снять); у компаратора в 4.1 один владелец
(развёртка), снимает его обработчик 0x0b ([HARDWARE-BLOCKS.md](HARDWARE-BLOCKS.md#компаратор-tsf-код)).

6.2 **[6.2, код]**: то же — `rand % 189 + 10` из r47, задержка уходит MAC-командой **0x30**
(`or r9,r14,0x30000000` @0x923d2c — единственная площадка с этим кодом в ucode 6.2), гейт
`0x923cda cmp r9,0x2` по `[0x8022a8]`. 64-битное поле 0x8022c0/0x8022c4 (= fw-буфер команды 0x0b,
+0x68/+0x6c) не заполняет ни один отправитель: оно приходит из пула 0x804280 как есть; текущий
TSF читается (0x923d40), но уходит только в лог.

Смысл MAC-команды 0x30 и опыты с перехватом развилки —
[MAC-COMMANDS.md §7.7](MAC-COMMANDS.md#77-0x30--задержка-маяка-железо).

### 4.2. Гейт и адреса по версиям **[код]**

Рандомизированная отсрочка включается только при **`bi_mode == 2`** (DMG Discovery Beacon при
активном скане) и `ctx->kind == 0`. Ветка развилки дополнительно гейтится аппаратным условием
(r41 бит 30).

| версия | рандомизатор | гейт | селектор `bi_mode` |
|---|---|---|---|
| 4.1.0.1000 | `0x923de0` | `0x923e0c cmp r7,0x2` | `0x801438` |
| 5.2.0.18 | `0x92377c` | `0x9237a0 brne.d r2,0x2` | `0x80191c` |
| 6.2.0.1000 | `0x923cb4` | `0x923cda cmp r9,0x2` | `0x8022a8` |

Селектор сопоставлять только по коду. Однобайтовые правки гейта всех трёх версий —
[../4.1/docs/DISTBCN-PATCH.md](../4.1/docs/DISTBCN-PATCH.md).

Второй читатель `bi_mode` на пути автомата BI — гейт C окна AW `bi_ap_mon_if__trigger_bhi`
0x930564 [4.1]: при `bi_mode == 2` автомат идёт BHI→DTI, минуя AW. Рандомизатор и окно AW
взаимоисключающи ([STANDARD-MAPPING.md](STANDARD-MAPPING.md#гейт-окна-aw--bi_ap_mon_if__trigger_bhi-0x930564)).

Рандомизатор (`mulu64 rX,189` над r47, +10, сдвиг на 10) присутствует во всех версиях
4.1…wil6436 7.5; в 1.4, 2.2 и Terragraph 10.x его нет (заменён детерминированным
расписанием) **[код]**. В 6.2 добавлено фиксированное расписание
([../6.2/docs/FIXED-SCHED.md](../6.2/docs/FIXED-SCHED.md)).

### 4.3. Сверка с патентом US8520648B2

«Beacon transmission techniques in directional wireless networks» (Intel, Carlos Cordeiro;
подача 2010-06-14, выдан 2013-08-27). Алгоритм: в каждом BI станция выбирает
`delay ~ U(0, RangeMax)`, ждёт TBTT, отсчитывает delay; если за это время услышала чужой
маяк — откладывает свой до следующего BI, иначе передаёт серию направленных маяков.
`RangeMax = 2·aCWminMMwaveIBSS·BT_Length`, `BT_Length = NDirTx·(B_Time + SBIFS)`; при
aCWminMMwaveIBSS = 5 и BT_Length = 4×80 мкс RangeMax = 3,2 мс, среднее 1,6 мс. Целевая среда —
mmWave IBSS.

| патент | прошивка |
|---|---|
| delay ~ U(0, RangeMax) | `uniform_random` в развёртке; диапазон **зашит** (189 + 10), а не вычисляется из aCWmin и BT_Length |
| «услышал → молчи» | счётчики `tx bcon`, `rx bcon`, `detected` отчёта MAC_MON |
| секторная серия маяков | развёртка, `bcn_tx_init_ss_params` |
| отдельное CW для маяков | `backoff`, накопитель NAV |
| — (надстройка вендора) | ATIM, `bcon bitmap`, `bad_beacons_detector`; длительность окна анонсов в IE (§6.3) |

Стандартный флаг *Decentralized PCP/AP Clustering* прошивка 4.1 безусловно гасит
(`bic r0,r0,0x38` @0x8e1882), в эфир он не объявляется **[4.1, код + железо]**
([ROLELESS-LINK.md §1.6](ROLELESS-LINK.md#16-decentralized-pcpap-clustering-не-объявляется-код-железо)).

## 5. NAV-отсрочка маяка **[обе код; 4.1 железо]**

Второй, штатный механизм расхождения маяков лежит в развёртке сразу за гейтом рандомизатора
[4.1]:

    923f4c  bl 0x0092a5ec          ; nav__refresh_state
    923f50  bl 0x0092a608          ; nav__remaining_time_us
    923f54  breq r0,0x0,0x92400c   ; NAV пуст -> обычный путь
    923f58  ld  r4,[0x857000+0x44] ; beacon_nav
    923f68  ld  r9,[0x800688]      ; g_beacon_nav_delay_active
    923f78  brne.d r9,0,0x923ff0   ; в слоте: st r4,[0x857044] — счётчик растёт всегда
    923f80  bl  uc_read_tsf_lo ; 923f86 st 1,[0x800688]
    923fa0  st  r0,[0x802030+0x48] ; «Beacons delay due to NAV started at 0x%08x»
    923f9c  beq.d 0x009243e4       ; маяк не передаётся
    923ff8  sub r0,r0,r7 ; 923ffc cmp r0,0x7530 ; 924004 blt.d 0x9243e4   ; до 30000 мкс — снова пропуск

* Остаток NAV используется только как «ноль/не ноль»: механизм не сдвигает маяк на остаток
  NAV, а **пропускает** проход, пока NAV не истечёт; потолок — **30 мс** (`cmp r0,0x7530`
  @0x923ffc), после чего маяк уходит принудительно.
* `nav__remaining_time_us` (0x92a608, вызов @0x923f50; строка лога отсрочки выводится @0x923f92) возвращает `min(cap, max(0, nav_end − current_TSF))`
  (текущий TSF — через `uc_read_tsf_lo`/0x9315e8); `nav__refresh_state` (0x92a5ec) пишет 0 или 2
  и может сбросить NAV (защитить бит 0 — 0x92a5fc).
* Состояние `g_nav_db` (`nav_db.c`) — 0x800994 (host 0x940994):

  | адрес | поле |
  |---|---|
  | `0x800994` +0x00 | флаги: бит 0 — NAV занят, бит 1 — подсистема взведена |
  | `0x800998` (+0x04) | TSF-lo окончания NAV |
  | +0x10…+0x16 | `nav_sa_addr[6]`, `nav_enable` (= 1 на обоих узлах) |
  | `0x8009ac` (+0x18) | `nav_max_us` = 0x1388 = 5000 мкс — обрезка Duration отдельного кадра (host 0x9409ac) |
  | `0x8009ae` | `duration_limit_cnt` — счётчик клампов |
  | `0x8009b0` | смещение |

* `nav_db__update` (0x92a6f4) разбирает тип/подтип кадра из битов, особый случай
  type == 1 && subtype == 0xe; лог `Received bigger NAV than Current` после 10 срабатываний.
* Общий блок fw↔ucode: 0x857014 `beacon_neighbor_cnt`, 0x857018 `beacon_neigh_aw_cnt`,
  0x857044 `beacon_nav` (подтверждено `link_stats__report` @0x8e2c46).
* NAV взводится из `rx_nav_bi_step` только при `PPDU_REPORT_3` (r38) бит 28
  `neighbour_indication` (`mov r3,r38; bbit0 r3,0x1c` на 0x92dd5c и 0x92e708) — узлы должны быть
  в разных BSS; для партнёра своего BSS железо ставит `my_bssid_beacon_detected`, который в NAV
  не ведёт. `rx_nav_update` @0x92fd3c, `nav_db__update` @0x92a6f4.
* Программный NAV — теневая копия: аппаратная таблица `NAV_DA_LOW_ENTRY0..7`,
  `NAV_SA_LOW_ENTRY0..7` и бит 3 `nav_active` r40 не читаются. Selective NAV (LMAC 0x1e →
  0x800a15..0x800a19) не читается. Аппаратные помощники занятости среды — `BACKOFF_IFS_STATUS`
  и `PHY_SIGNALS_AND_CCA_MONITOR` ([MAC-REGISTERS.md](MAC-REGISTERS.md#отсрочка-маяка-по-занятости-среды)).

6.2 **[6.2, код]**: NAV по принятому кадру — `rx__update_nav_from_frame` 0x9343a8 →
`rx_nav__set_from_duration` 0x92dd30 ([DATAPATH.md §3.4](DATAPATH.md#34-62-nav-по-принятому-кадру-код)),
`rx_nav_update` 0x934590, остаток — `bi__remaining_time_us` 0x92dc44; развёртка 0x923cb4
зовёт `bi__remaining_time_us` и `rx_nav__arm_flag_if_enabled` 0x92dc28.

**Стенд [4.1, железо]:** два маячащих узла, разные SSID (WL60TEST и PEER60):

| узел | чужих маяков | в окне AW | NAV-задержек | nav_flags |
|---|---|---|---|---|
| узел A | 2965 | 62 | 0 | 0x2 |
| узел B | 3236 | 0 | 14850 (100009 → 101827 → 103342) | 0x3 |

Интервалы DTI: узел A — 101815…102984 (медиана 102399, размах 1169 мкс); узел B —
99441…105355 (медиана 102395, размах 5914 мкс): маяк реально сдвигается штатно, без патча.
Размах 5914 мкс превышает `nav_max_us` 5000. В конфигурации «AP + станция» маячит один узел, и
NAV не взводится. В направленном 60 ГГц NAV слышен только от узла, на который наведён луч.

## 6. Автомат BI и окна

### 6.1. Состояния, события, объекты **[обе]**

Автомат интервала маяка — экземпляр движка `basic_sm`
([STATE-MACHINES.md](STATE-MACHINES.md)). Имена из таблицы строк 6.2 **[6.2, код]**; нумерация
2 = DTI, 3 = AW совпадает с установленной в 4.1:

| № | состояние | № | событие |
|---|---|---|---|
| 0 | `BI_STATE_BTI` | 0 | `BI_EVENT_DTI_TO_BTI` |
| 1 | `BI_STATE_ABFT` | 1 | `BI_EVENT_BTI_TO_ABFT` |
| 2 | `BI_STATE_DTI` (начальное) | 2 | `BI_EVENT_BHI_TO_DTI` |
| 3 | `BI_STATE_AW` | 3 | `BI_EVENT_BHI_TO_AW` |
| | | 4 | `BI_EVENT_AW_TO_DTI` |

BHI (Beacon Header Interval) = BTI + A-BFT.

| | 4.1 | 6.2 |
|---|---|---|
| имя автомата | `BI_AP_MONITOR_SM` | `bi_sm` |
| объект / экземпляр | 0x801de8 | 0x800600 (gp+0xd8) |
| таблица переходов / описатель | 0x800adc, запись 5 Б, индекс `состояние + 4·событие` | описатель 0x801adc (20 Б), настраивается из 0x92aec4 |
| инициализация | `bi_ap_mon__init` 0x928130 | `bi_sm__init` 0x92acf8 |

Обработчики переходов 6.2 **[6.2, код]**:

| адрес | переходы |
|---|---|
| 0x935b4c | DTI_TO_BTI: BTI→BTI, DTI→BTI |
| 0x935a08 | BTI_TO_ABFT: BTI→ABFT |
| 0x935a94 | BHI_TO_AW: BTI→AW, ABFT→AW |
| 0x935d0c | BHI_TO_DTI: BTI→DTI, ABFT→DTI; AW_TO_DTI: AW→DTI |
| 0x9262e8, 0x92646c, 0x92150c/0x92153c/0x92156c, 0x923a5c | «остаться на месте» |

Переходы 6.2 — `6.2/ref/SM-TABLES-UC.txt`. В описателе 6.2 +0 — число СОБЫТИЙ, +1 — число
СОСТОЯНИЙ; перестановка разбирается без сбоя, но даёт неверные пары (признак — массив имён
состояний «продолжается» именами событий).

В 4.1 обработчики AW (`bi_ap_mon__aw_event` 0x931078) и DTI (`bi_ap_mon__dti_event` 0x931270) —
близнецы: кладут в кольцо MAC маркеры `0xcaf220`/`0xcaf110` и инкрементируют счётчики 0x801e1e
(AW) и 0x801e1c (DTI) **[4.1, код + железо]**.

### 6.2. Кто подаёт события **[4.1, код]**

События приходят через `bi_ap_mon_if__trigger` 0x9304c8 — диспетчер на шесть входов (таблица
заглушек 0x800dd4). AW→DTI ведут GP-таймеры (r54 бит 15 `ext_gp_0_1_2_end_ind`), DTI→BTI —
r42 бит 4 (`bi1_event`, путь TBTT), а не компаратор TSF. Полная таблица входов, листинг ветки r54
`l1_task__entry` и счёт меток —
[MAC-COMMANDS.md, приложение В.1](MAC-COMMANDS.md#в1-автомат-bi-микрокод-41); коды GP-таймеров
0x49/0x4f..0x54/0x67/0x68 — [MAC-COMMANDS.md §7.6](MAC-COMMANDS.md#76-gp-таймеры-и-r54-0x49-0x4f0x54-0x670x68).

События L1 по битам r54 в 6.2 обрабатывает `l1__on_event4` 0x92cd20 тем же способом
([UCODE-TASKS.md §2](UCODE-TASKS.md#2-главный-цикл-l1-62)).

### 6.3. Блок счётчиков окон 6.2: 0x802ec0 **[6.2, код]**

Обработчики переходов 6.2 работают с блоком по 0x802ec0 (host 0x942ec0), которого нет в образе
(uc_data 7144 Б) — он живёт в ОЗУ. Это блок **счётчиков**, а не экземпляр автомата (тот по
0x800600).

| смещ. | поле |
|---|---|
| +0x04 u16 | счётчик интервалов маяка; инкремент в DTI_TO_BTI (0x935b4c) |
| +0x06 u16 | читается при BTI_TO_ABFT |
| +0x08 u16 | читается при BHI_TO_DTI |
| +0x0a u16 | читается при BHI_TO_AW |
| +0x0c, +0x0e, +0x10, +0x14 | остальные члены семейства счётчиков |
| +0x12 u8 | текущее окно: 0 BTI, 1 ABFT, 2 DTI, 3 AW; пишут только четыре настоящих обработчика |

Каждый обработчик кладёт в кольцо MAC маркер `0xcafNNN | состояние` (0xcaf000, 0xcaf110,
0xcaf220, 0xcaf440, 0xcaf550, 0xcaf660/1/2; без маркера — только заглушка 0x92646c): смену окон
видно в трассе кольца без патчей.

### 6.4. Блоки BI, BTI и AW микрокода

| роль | 4.1 | 6.2 |
|---|---|---|
| вход в AW: открыть маску событий AW, собрать бодрствующих пиров | `bi_manager__on_aw` 0x9289a0 → `aw_worker__begin_window` 0x931110 → `aw__open_event_mask` 0x921c2c | `bi__after_enter_aw` 0x92b798 → `aw__start_window` 0x935ae4, `aw__open_event_mask` 0x921450 |
| сбор бодрствующих пиров (`aw_worker.cpp`) | `aw_worker__collect_awake_peers` 0x925ea4 | 0x927a44 |
| свёртка масок пиров | `aw__fold_peer_masks` 0x924880 | 0x924ec0 |
| вход в DTI | `bi_manager__on_dti` 0x928a58 | `bi__after_enter_dti` 0x92b85c → `bi__dti_step` 0x935d5c → `pm__wake_sequence` 0x9262c0 (4.1: 0x925184) |
| новый TBTT для AW, период по 0x886d64 | `aw__compute_tbtt_from_hw` 0x9325ac, `aw_tbtt_set_step` 0x930b08 | 0x937518, 0x935560; `aw_tbtt__count_intervals` 0x9353ac |
| шаг BI-менеджера | `bi_manager_step_b` 0x922afc | 0x922258 |
| маска событий на время окна | `pm__event_mask_save_all_on` 0x92a630, `pm__event_mask_restore` 0x92a69c | 0x92dc6c, 0x92dcd8 |
| TSF-арифметика | `bi__tsf_delta64` 0x924544, `uc_tsf_elapsed` 0x924568 | 0x924818, 0x92483c |
| 1000 в единицах такта MAC 165 МГц | `bi_mode__set_1000_units165` 0x928194 | 0x92af20 |
| метрика BF в BTI | `bti__request_bf_metric` 0x923db8, `bti_bi2__gp2_end_flag` 0x923dd4 | 0x923c8c, 0x923ca8 |
| программирование регистров bi2 | `bti_tx__program_bi2_regs` 0x92c968 | 0x930774 |
| слот маяка | `bi_manager__eval_bcon_slot` 0x9262e0 | 0x927de0 |
| инициализация режима BI | `bi_mode_init_sequence` 0x93171c | 0x9365fc |

Только 6.2 (по строкам и соседям) **[6.2]**: `bi__state_from_g800600` 0x9282b4,
`bi__latch_tsf_and_reset` 0x92b9d4 (RX OFF), `bi_ctx__set_active` 0x92ad00,
`bi__run_bti_cycle` 0x928794 (шаг BI-менеджера: BF по роли), `bti__dispatch_sweep_step`
0x92b7dc (MAC cmd 0x0f), `bti__arm_period_gp0` 0x9307bc (лучшая метрика BI2),
`sched__calc_next_start_tsf` (новый TBTT), `mac__ddc_mask_all_on` 0x92732c,
`sta__get_sweep_byte` 0x93dad0, `aw_worker__read_dma_881c84` 0x928f9c (чтение DMA 0x881c84 для
AW; в fw — `hwd_dma__get_rings_with_data` 0x8d078c), `mac__get_beacon_interval_tu_uc` 0x9374d8,
`bi__bti_timer_step` 0x92e7c8 (L1-диспетчер по TSF), переходы автомата
`bi_sm__action_92150c/92153c/92156c/923a5c/9262e8`.

### 6.5. Окно AW (ATI)

**Установка AW — `aw__set_new_tbtt`** (4.1 0x930770, 6.2 0x93520c) **[4.1, код]**:

* арифметика в единицах **`0x400` = 1024 мкс** (TU);
* `ctx+0x12c/0x130` — 64-битный TBTT TSF; коррекция на N×1024 мкс, если `(tbtt − now) > 10000`;
* цикл по маске активных пиров **`0x801034`**: на пира — структуры `ctx+0x48+i*0xc` и
  `ctx+0xa8+i*0x10`; два **побайтовых** битмапа состояний: `ctx+0x128` (бит, если state != 2) и
  `ctx+0x129` (бит, если state == 0) ⇒ предел **8 пиров** (совпадает с assert `idx > 7` в
  `bad_beacons_detector.cpp` fw);
* установка AW: при `ctx+0x44 != 0` и `ctx+0x3c <= tbtt` → лог
  `Set new AW. TBTT TSF / tbtt_start_time`, `aw__set_tbtt_offset(0x801eb8, *(u16*)(ctx+0x40))`,
  счётчик `0x80202c`, значение `0x80202e`.

**Согласование длительности AW через IE (fw)** — `ps_assoc_mgr::aw_ie_reception` (4.1 0x8c34f4,
6.2 0x8c3e9c) **[код]**:

```c
ie = <AW IE из принятого кадра>;
new_aw = ie ? *(u16*)ie : 0;
cur_aw = get_aw_duration(ctx+0x48);
if (cur_aw != new_aw) {
    LOG("Previous AW Duration: %d. New AW Duration %d", cur_aw);
    mode = (cur_aw <= new_aw) ? 4 : 0;       // рост окна vs сжатие
    set_aw_duration(ctx+0x48, new_aw, mac__mul_886fc4_by_886d64(mode));   // 0x8e47b4
}
```

Длительность окна анонсов передаётся в IE и принимается от соседа — механизм вне патента
US8520648. Путь длительности AW (константа 1000 мкс в `power_mngr__recalc_aw`, LMAC 0x25), гейт
окна AW (три условия, в т. ч. `bi_mode == 2`), отказ ATIM и разрыв связи по ATIM —
[STANDARD-MAPPING.md, раздел ATI и механизм ATIM](STANDARD-MAPPING.md#ati-и-механизм-atim).
Счётчики ATIM, допуск к передаче `get_tx_eligibility` и живость пиров 4.1 —
[../4.1/docs/UCODE-BEACON.md](../4.1/docs/UCODE-BEACON.md).

## 7. Период BI и TBTT

Регистры TSF и таймера BI (`0x886d18`/`0x886d1c` перезарядка, `0x886d30..38` компаратор,
`0x886d64` период в TU, `0x886ec0` мкс до TBTT, `0x886fc4` TSF текущего TBTT) —
[HARDWARE-BLOCKS.md](HARDWARE-BLOCKS.md#блок-tsf-и-таймеров-mac-0x886d180x886ec0); ячейки,
пропорциональные периоду, и опыты горячей смены периода —
[MAC-COMMANDS.md §9.1](MAC-COMMANDS.md#91-период-маяка).

| | 4.1 | 6.2 |
|---|---|---|
| писатель `0x886d64` | микрокод, `0x931798 st_s r1,[r0,0x64]` при r1 = 0x64 (100 TU, константа) | `txrx_api_cmd_step` 0x936be4 (LMAC 0x01 RX_ON): `0x886d64 = период_мкс >> 10` |
| первый TBTT | — | защёлка `0x886dc0`/`0x886dc4`, MAC-команда 0x0d |
| тело LMAC 0x01 | 0x24 Б, построение @0x8d89f0, +0x20 = 1 ([LMAC-PROTOCOL.md](LMAC-PROTOCOL.md)) | [0..1] TSF начала, [4] бит 0 — включить таймер BI, [6] — период в мкс, [7] — флаги |
| источник периода у станции | зашитые 100 TU | глобал fw `0x8002d4` через `l2_mgr__connect` 0x8f1e18 → `RADIO_MGR__set_primary_channel` ([../6.2/docs/BENCH.md](../6.2/docs/BENCH.md#интервал-маяка-станции)) |

**[код 6.2; 4.1 — MAC-COMMANDS §9.1]**. `txrx_api_cmd_step` в 4.1 — 0x931ce8 (там же профиль
`mac__program_deadline_slack`).

Ни одна версия не берёт Beacon Interval из маяка AP, как требует 802.11-2020 §11.1.3.3.1: при BI
точки 200 у станции 4.1 `0x886d64` = 0x64 **[железо]**
([STANDARD-MAPPING.md](STANDARD-MAPPING.md#интервал-маяка-и-потеря-связи-у-станции)).

Расписание BTI/AW/DTI от `beacon_int` не зависит: строится `bi_build_schedule_tables`
(4.1 0x927f00) из `cfg[+0x07]`, `cfg[+0x0a]` ([MAC-COMMANDS.md §9.1](MAC-COMMANDS.md#91-период-маяка)).

## 8. Отчёт MAC_MON **[обе]**

ucode раз в BI публикует отчёт о маяках и окнах в общую память и сообщает fw событием
MAC_MONITOR_EVT (тип 0x17, [LMAC-PROTOCOL.md §4](LMAC-PROTOCOL.md#4-события-ucode--fw)); fw
печатает его модулем `MAC_MON` (`[BTI]`, `[AW ]`, `[NNL] tx bcon / rx bcon / detected`, `bcon
bitmap`) и кормит детектор плохих маяков `bad_beacons_detector` (6.2
`bad_beacons_detector__handle_bcons_info` 0x8cd1e8).

| | 4.1 | 6.2 |
|---|---|---|
| публикатор | `bi_window_transition_prep` 0x9370b8 (roll-up в конце BI) | `peer_slots__scan_by_masks` 0x93cd2c (432 Б) |
| рабочая копия / двойной буфер | 0x8008e0 (0x7c Б); слоты 0x80088c / 0x8008b4 (шаг 0x28), переключатель 0x8008dc | слоты `0x801030 + 0x28·i`, индекс 0x801080 |
| публикация | `memcpy(0x854de0, 0x8008e0, 0x7c)` | `memcpy(0x853940, 0x801084, 0x80)` из неактивного слота, затем обнуляет 0x8006e0, 0x800634..0x80063c |
| флаг «маяк принят» в отчёте | 0x854e0a | 0x85396a (+0x2a) |
| обработчик fw события 0x17 | `lmac_if__mac_monitor_report` 0x8d865c | `lmac_if__update_pct_stats` |
| подробно | [../4.1/docs/UCODE-BEACON.md](../4.1/docs/UCODE-BEACON.md) (раскладка блока счётчиков) | [../6.2/docs/BENCH.md](../6.2/docs/BENCH.md#двойной-буфер-отчёта-mac_mon) |

6.2 обходит 8 пиров по маскам 0x801030 и 0x802194 (данные 0x853940…0x85398c);
`peer_masks__apply_op` 0x934bb0 — операции над 64-битными масками пиров (согласованное
чтение пары регистров) **[6.2, код]**.

Приёмная половина распределённого биконинга работает штатно: станция, не маяча, принимает 64
маяка за развёртку и детектирует соседа (4.1: AP `tx bcon/rx bcon/detected` = 63/0/0, станция
0/64/1) **[4.1, железо]**.

Метрика MAC_MON `[BTI] start time` показывает начало окна BTI, которое задаёт расписание BI в
железе; для оценки сдвига кадра маяка внутри BTI она непригодна.

## 9. Состояние на железе

### 9.1. Открытие гейта с хоста **[4.1, железо]**

Штатно на стенде `bi_mode` = 1, и MAC-команда 0x30 не уходит (свыше 140 тыс. команд кольца, семь
состояний плюс рестарты). Запись **`0x941438 = 2`** (host-адрес; по линкерному 0x801438 запись
попадает в данные прошивки) открывает гейт без патча: 0x30 идёт (значения 66, 197, 62, далее
шесть разных в 58…182), связь не рвётся. Побочно: снимается окно AW (гейт C) и записи
`MAC_MON [DTI]` в логе прошивки перестают появляться (возобновляются при возврате 1).
Штатный способ получить `bi_mode = 2` — активный скан (discovery_mode), см. §2.2.

Однобайтовый патч гейта на железе включает расчёт на каждом BI: `randomize beacon` в 197 из 197
снимков против 0 из 900 на стоке, `uniform_random` 10…198, среднее 104,2
([../4.1/docs/DISTBCN-PATCH.md](../4.1/docs/DISTBCN-PATCH.md#проверка-на-железе)).

### 9.2. Рандомизатор маяк не сдвигает **[4.1, железо + код]**

Цепочка «случайное число → задержка → регистр» работает до железа:

| `bi_mode` | 0x886d30 | 0x886d38 |
|---|---|---|
| 1 | 0x00000000 | 0x000c0010 (снят) |
| 2 | 0x001a9400 → 0x001bd800 | 0x000c0050 (взведён) |

Но передача маяка от компаратора не зависит:

* интервалы маяка ровно 102 400 мкс (медиана и среднее, σ = 414 мкс, четыре дискретные группы
  101808/102304/102400/102944 — квантование таймера); зависимости интервала от
  `uniform_random` нет (отклонения ±10 мкс), корреляция `next_tsf − current_tsf` с
  `uniform_random` r = 0,012 (5942 интервала, все ×1, пропусков нет);
* фаза начала BTI при включённом рандомизаторе: младшие разряды `ff9` (65 раз), `ffa` (10),
  `ffb` (3) из 78 меток — дрожание ≤ 2 мкс;
* распределения длительности BTI (медиана 1367/1368 мкс, диапазон 1363…1955, двугорбость ~75/25 —
  секторная развёртка) и AW (1003…1006) у стока и патча неразличимы; у станции, связанной с
  пропатченной AP, интервал 102 400 мкс, σ = 416.

Причины **[код + железо]**:

1. **Путь передачи не ждёт события компаратора.** Развёртка ждёт только `slot_event|busy2` и
   `txop_event` (§3.3); `tsf_event` (r42 бит 6) не ждёт ни одно место ожидания. Передача маяка
   идёт в том же проходе сразу после `set_tsf_event`. Бит r42, соответствующий компаратору, не
   найден: чтения r42 на входе и после взвода совпадают (0x00f2c3bf / 0x00f2c1bf, различие в бите 9,
   который `uc_sleep_until_event` 0x93187c добавляет к маске при ненулевом втором аргументе); `uc_sleep_until_event(1<<9, 0)`
   усыпляет ucode навсегда.
2. **Цель в прошлом.** Накопитель 0x801450 не привязан к TSF: одновременно сняты накопитель
   0x003bb000 → 0x003ce800, тот же компаратор 0x886d30 и текущий TSF 0x07e8fffb (≈ в 34 раза
   больше); при другом замере `Next tsf` отстоял от текущего на ≈ 1,9 млн мкс (≈ 18 BI); при
   холодном старте накопитель нулевой. 6.2: поле 0x8022c0/0x8022c4 не заполняется (§4.1).
3. **Починка базы недостаточна.** С базой, подставленной как TSF + 200…300 мс (компаратор
   0x0bd4efd9 при TSF 0x0bcf6ff9), и с базой, привязанной к TSF в переписанной развилке
   (`uc_read_tsf64` в начале обработки BTI; `next − current = rand·1024`, например 188 → 192 509
   мкс, 68 → 69 628 мкс), интервалы остались 102 400 мкс, фаза `ff9`/`ffa`. Чтение TSF через
   `uc_read_tsf64` изнутри `set_tsf_event` останавливает ucode (реентрантность общего теневого
   слова команды MAC `gp[-0x44]` = 0x8004e4 и кольца r25).
4. **Автомат на TBTT может сидеть в AW**: событие DTI_TO_BTI из AW уходит в
   `bi_ap_mon__aw_on_dti_to_bti` 0x921c9c, мимо `bti_event → kind_switch → decide_beacon_kind`
   (метки на маячащей AP: aw ×9, dti ×9, bti ×2).

Вывод: механизм рандомизатора цел, но его результат с расписанием маяка не связан; расписание
задаётся конфигурацией BI в MAC (GP-таймеры, TBTT). Чтобы маяки расходились, менять надо
конфигурацию BI каждый интервал, а не компаратор TSF.

### 9.3. NAV-отсрочка работает штатно **[4.1, железо]**

См. §5: при двух маячащих узлах в разных BSS маяк откладывается (14 850 задержек, размах DTI
5914 мкс) без патча.

### 9.4. Сводка рычагов с хоста **[4.1, железо]**

| рычаг | адрес / способ | эффект |
|---|---|---|
| снять AW | 0x940458 = 0 или 0x94049c ≠ 0 | AW 1009 → 5 мкс, DTI +1005 |
| рандомизатор | 0x941438 = 2 | команда 0x30 идёт; AW снят; `MAC_MON [DTI]` глохнет |
| период A-BFT | 0x94143c (байт +0x04) | длинный BTI в каждом N-м BI |
| период BI | 0x886d64 | запись на лету останавливает маяк |
| CC Present | 0x905a3c = 0x81000000 | поле Clustering Control в эфире |
| маяки соседей к хосту | 0x903474 = 0x200 | снимает гейт PCP Assoc Ready |
| NAV-отсрочка | узлы в разных BSS, оба маячат | маяк пропускается до 30 мс |

## 10. Задержка маяка DMG IBSS в прошивке 6.4 mesh **[6.2, код; железо — проверено 29.09]**

802.11-2020 11.1.3.5 b)–e): в каждом TBTT член IBSS берёт задержку, равномерную в
[0, 2·aCWminDMGIBSS·длительность своего следующего BTI] (aCWminDMGIBSS = 3, табл. 11-22),
и отменяет свой BTI, если до её конца пришёл DMG Beacon своей IBSS. Вендорский
«рандомизатор» (§4) этого не делает — он задаёт поле Beacon Interval discovery-маяка
(11.1.3.4). В прошивке mesh задержка сделана заново в ucode:

| шаг | где | что |
|---|---|---|
| выбор «передавать/слушать» | `bti__prepare_sweep_set` 0x935b9c → C (`6.4/src/c/uc`) | при маяке в очереди и `bi_mode ≠ 2` вместо развёртки — задержка |
| задержка | там же | LFSR (селектор 0x1d, r47) · 6·T_BTI → старшие 32 бита (`mulu64`); отсчёт по TSF (`uc_read_tsf_lo`), **не GP0** |
| ожидание | опрос TSF и события rx_frame (r42) | кадр → `bti_worker_bi2_step(0, 1)` разбирает его; маяк своей BSS (r38 бит 0) — свой BTI отменён, приёмный поток `bti_transmitter_bi2_flow` |
| конец задержки | | штатная развёртка 0x923cb4; длительность замеряется по TSF и хранится для следующей задержки |
| ворота A | `uc_bi_counter_in_window` 0x937474 → C | окно приёма маяка 2500 мкс + 7·T_BTI (иначе маяк после задержки не был бы принят) |

**GP0 трогать нельзя.** Первая версия отсчитывала задержку таймером GP0 (`gp0__arm_usec` +
ожидание `gp0_end`). GP0..GP2 размечают окна BI (BTI, A-BFT, AW, DTI),
перевзвод GP0 сдвигал DTI узла, RTS шли соседу вне его DTI без CTS, и связь уходила в
переобучение луча: ping до секунд, ~100 Мбит/с. С отсчётом по TSF — ping 0,6–7 мс,
iperf3 ≈ 900 Мбит/с **[железо]**.

Состояние — общая ячейка `struct ibss_uc_state` (`fw_uc_shared.h`), ucode 0x803a4c /
host 0x943a4c: `+0` T_BTI (с признаком 0x11bd), `+4` BTI с развёрткой, `+8` отменённые BTI,
`+0xc` последняя задержка, мкс. Прошивка обнуляет её при старте ячейки. Пока BTI не
измерен, T_BTI = 1400 мкс.

Отличия от буквы стандарта: отсчёт задержки не останавливается при занятой среде (п. c —
backoff; аппаратный backoff не исследован); ATIM-окна нет. В прошивке apsta оба блока
остаются вендорскими.

## Метод

* Рандомизатор на стоке: `SparRAW-tools/host/wil_tsf_probe.py` во время активного скана
  (`iw dev wlan0 scan` или любой путь с WMI_START_DISCOVERY и active scan) — fw шлёт
  discovery-маяки, `0x801438[0]` = 2; `TSF_TARGET − TSF_CUR` меняется от прохода к проходу; вне
  скана не меняется. У маяка PCP (`bi_mode = 1`) компаратор рандомизатором не перевзводится.
* Проверка сдвига маяка: положение переданного кадра внутри BTI либо время прихода маяка на
  соседе; фаза начала BTI из MAC_MON сдвига кадра внутри BTI не показывает (§8).
* Поток лога ucode снимать непрерывно (`SparRAW-tools/host/wil_uc_stream.py`, склейка по
  `write_ptr`): кольцо ucode 4.1 держит ~126 записей (~1,5 с), выборочные снимки раз в 2 с
  теряют события и дают ложные «пропуски» маяка кратно BI.
* Смена окон BI видна без патчей по маркерам `0xcafNNN` и квитированиям 0x49 в кольце команд MAC
  ([MAC-COMMANDS.md](MAC-COMMANDS.md)).

## Замечания

* `bti_transmitter_bi2_flow` (4.1 0x923c74) в части документов 4.1 описан как «обычная
  (нерандомизированная) передача маяка»; по коду это ветка окон GP для BF-метрики, маяк
  передаёт развёртка 0x923de0 при любом `bi_mode` (§3.1).
* Единица задержки рандомизатора: `shl64(x, 0, 10)` — сдвиг на 10 (×1024 мкс); оценка
  «×10 мкс, 100…1980 мкс» по декомпиляции не подтверждается железом (`next − current = rand·1024`).
* Блок 0x92a608 — `nav__remaining_time_us`; в 6.2 одноимённая роль у `bi__remaining_time_us`
  0x92dc44.
* Адреса накопителя 0x8022c0/0x8022c4 относятся к 6.2; в 4.1 по ним лежит другое.
* Бит 30 r41 рычагом отсрочки маяка не является.

## Не установлено

* Что делает событие компаратора TSF при срабатывании и какой бит r42 (среди проверяемых в ucode
  4, 7, 9, 12, 14, 16, 18, 19) ему соответствует.
* Какое из двух условий гейта рандомизатора блокирует 0x30 в сборках с перехватом развилки;
  почему при `bi_mode = 2` записи `MAC_MON [DTI]` пропадают из лога.
* Чем ограничен размах NAV-отсрочки (5914 мкс против `nav_max_us` 5000) и асимметрия узлов A/B.
* Ветка «услышал чужой маяк → не передаю» вне NAV не локализована.
* Держится ли `bi_mode = 2` после окончания скана и можно ли штатно удерживать узел в
  discovery-биконинге постоянно.
* Гейт окна AW в 6.2 (аналог `bi_ap_mon_if__trigger_bhi`); ATIM и допуск к передаче в 6.2.
* Механика `tx_initiator_flow` / `get_tx_eligibility` как модели доступа к среде; `aw_worker.cpp`.

## Источники

* Деревья `4.1/src/asm/uc/`, `6.2/src/asm/uc/`, `4.1/src/asm/fw/`, `6.2/src/asm/fw/`
  (`blocks.json`); `4.1/ref/SM-TABLES-UC.txt`, `6.2/ref/SM-TABLES-UC.txt`,
  `4.1/ref/WAIT-SITES-UC.txt`, `4.1/ref/MAC-CMD-MAP.txt`.
* [HARDWARE-BLOCKS.md](HARDWARE-BLOCKS.md), [MAC-REGISTERS.md](MAC-REGISTERS.md),
  [MAC-COMMANDS.md](MAC-COMMANDS.md), [LMAC-PROTOCOL.md](LMAC-PROTOCOL.md),
  [STATE-MACHINES.md](STATE-MACHINES.md), [STANDARD-MAPPING.md](STANDARD-MAPPING.md),
  [UCODE-TASKS.md](UCODE-TASKS.md), [DATAPATH.md](DATAPATH.md), [CROSS-VERSION.md](CROSS-VERSION.md).
* [../4.1/docs/BEACON-CONFIG.md](../4.1/docs/BEACON-CONFIG.md),
  [../4.1/docs/UCODE-BEACON.md](../4.1/docs/UCODE-BEACON.md),
  [../4.1/docs/DISTBCN-PATCH.md](../4.1/docs/DISTBCN-PATCH.md), [../6.2/docs/BENCH.md](../6.2/docs/BENCH.md).
* `SparRAW-docs/research/RANDOMIZER-ROOT-CAUSE.md`, `SparRAW-docs/research/DISTBCN-PROVEN-ON-HW.md` —
  журналы опытов на железе.
* Инструменты: `SparRAW-tools/host/wil_tsf_probe.py`, `wil_uc_stream.py`, `wil_fw_log.py`,
  `wil_ucode_log.py`.
