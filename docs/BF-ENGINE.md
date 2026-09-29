# Движок beamforming (4.1 и 6.2)

Автомат BF в микрокоде: потоки SLS (TXSS инициатора и ответчика), BRP, rate
search, очередь запросов, развилка «BRP после SLS» и её рычаги, наблюдения на
стенде обеих версий.

Метки: **[код]** — по листингу (адрес инструкции), **[железо]** — измерено на
стенде (4.1: пара узлов, сток, `oob_mode=1`, безролевой линк — 4 записи с
хоста, `m_bss_mode=1`; 6.2: пара 6.2↔6.2), **[пак]** — имена из вендорского
пака 11ad, **[гипотеза]**. Пометки версии **[4.1]**, **[6.2]**, **[обе]**; адрес
без пометки относится к 4.1. Адреса ucode — в пространстве ucode (host =
0x940000 + (A − 0x800000)); общий блок 0x857xxx виден и из fw_peri (0x908000 +
(A − 0x840000)).

Смежные документы: запрет передачи по CID на время BF —
[DATAPATH.md](DATAPATH.md) §6; каркас задач L1/фон —
[UCODE-TASKS.md](UCODE-TASKS.md); контекст станции 6.2, конфигурация приёма
ответа, замеры приёма — [../6.2/docs/RX-BRP-UC.md](../6.2/docs/RX-BRP-UC.md);
вендорские перечисления — [VENDOR-ENUMS.md](VENDOR-ENUMS.md); ролевой гейт
развёртки и ответчик A-BFT — [MAC-COMMANDS.md](MAC-COMMANDS.md).

## 1. Потоки BF [4.1]

| поток | где | кто запускает | чем кончается |
|---|---|---|---|
| SLS в BTI/A-BFT (развёртка маяка + ответ в A-BFT) | ucode `bcon_txss_sweep_step`, `abft_responder_*`, `mac_mode_program_c` | расписание BI (GP-таймеры), без запроса BF SM | событие BF_DONE, flow 2 `ABFT_TXSS`, поля STATE=3/SUBSTATE фиктивные (@0x9293a6 `mov r10,3`) **[код]** |
| I-TXSS в DTI (свой SLS как инициатор) | слой B, состояние 3: `txss__flow_body` → `txss__init_sweep` | запрос BF (LMAC 0x09 или причина-триггер) | подсост. 5 = успех (пришёл SSW-ACK) |
| R-TXSS в DTI (ответ на чужой SLS) | слой B, состояние 4: `txss_flow_step_b` → `txss__init_sweep_b` | приём SSW соседа в `rx_funcs__rx_flow` @0x92f89c | подсост. 9 = успех (пришёл SSW-Feedback) |
| BRP-I (инициатор BRP) | слой B, состояние 9: `brp__mode_step` → `mac_mode_step_b`/`mac_mode_brp_step` → `brp__flow_main` | успешный TXSS + сосед «связан» (`0x801034`) | 0x30 успех / 0x31 провал |
| BRP-R (ответчик BRP) | слой B, состояние 10: `bf_sm__post_slot_result` → `brp_flow_step` | приём BRP-кадра (`rx_funcs__rx_flow`, r14=0xa) или TXSS-R с запрошенным L-RX | 0x33 успех / 0x34 провал |
| Rate search | `rate_search__*`, LMAC 0x13 | LMAC 0x13, успешный BF (`bf_sm__start_request` @0x92259e), LMAC 0x12, 0x30 | события RS_STARTED (0x13) / RS_DONE (0x14) |
| Обратная связь о секторе | `rx_funcs__handle_ppdu_report` → `rf_sector__program_selected` | приём SSW-Feedback/SSW-ACK | — |

`brp__mode_step` ставит подсостояние 0x31 заранее (@0x922e08/0x922e0c) и
заменяет на 0x30 только при успехе (@0x922e2e/0x922e32) **[код]**.

## 2. Состояния и подсостояния [обе]

Имена — из файла глобалов ucode пака 11ad (`ucode_image_globals.xml`),
структура `bf_connection_db_s` → `ucode_bf_state_u {state, substate}` **[пак]**.
Номера совпадают со всем, что видно на 4.1 в коде и на стенде.

### ucode_bf_state_e

| № | имя | где видно в 4.1 |
|---|---|---|
| 0 | BF_STATE_IDLE | |
| 1 | BF_STATE_PEND_TXSS_RESP | |
| 2 | BF_STATE_PRE_TXSS_INIT | `bf_sm__check_request_timeout` @0x922106 |
| 3 | BF_STATE_TXSS_INIT | `bf_sm__substate_advance` @0x92266a |
| 4 | BF_STATE_TXSS_RESP | стенд: `STATE=4 SUBSTATE=11` |
| 5 | BF_STATE_PRE_MID_BRP_RX_INIT | |
| 9 | BF_STATE_BRP_INIT | @0x9226a6; стенд `STATE=9` |
| 10 | BF_STATE_BRP_RESP | `bf_substate__dispatch_by_state` @0x922910 |
| 11 | BF_STATE_TXSS_FAILURE | @0x9226b4 |
| 13 | BF_STATE_DONE | @0x9226a8, @0x9226e4 |
| 14 | BF_STATE_RXSS_FAILURE | @0x9226f8 |
| 17 | BF_STATE_ABORT | `bf__abort_to_state11` @0x924fdc (ставит 0x11 = 17 ABORT, не 11) |
| 18 | BF_STATE_RETRY_TIMEOUT | `bf_sm__check_sta_timeout` @0x92252e |

### ucode_bf_substate_e

| № | имя |
|---|---|
| 0 | IDLE |
| 1 | TXSS_INIT_ENERGY_FAILURE_SS |
| 2 | TXSS_INIT_NO_SS_RESP_FAILURE |
| 3 | TXSS_INIT_GLOBAL_TIMEOUT_FAILURE |
| 4 | TXSS_INIT_NO_SS_ACK_FAILURE |
| 5 | TXSS_INIT_SUCCESS |
| 6 | TXSS_INIT_UNEXPECTED_SS_FRAME |
| 7 | TXSS_INIT_UNEXPECTED_SS_FDBK_FRAME |
| 8 | TXSS_INIT_UNEXPECTED_RTS_FRAME |
| 9 | TXSS_RESP_SUCCESS |
| 10 | TXSS_RESP_NO_SS_FDBK_FAILURE |
| 11 | TXSS_RESP_FAILURE |
| 39/40/41 | INIT_RATE_SEARCH_PENDING / _FAILURE / _SUCCESS |
| 47 | BRP_INIT_UNEXPECTED_ScS_FRAME_FAILURE_1 |
| **48** | **BRP_INIT_SUCCESS** (0x30, @0x922e32) |
| **49** | **BRP_INIT_FAILURE** (0x31, @0x922e0c) |
| 50 | BRP_RESP_UNEXPECTED_ScS_FRAME_FAILURE_1 |
| 51/52 | BRP_RESP_SUCCESS / _FAILURE |
| 53 | BRP_RESP_NO_TRAINING |
| 54 | ABORT_UNKNOWN_STA |

Прочие поля вендорской `bf_connection_db_s`: `mcs`, `other_l_rx`,
`my_training_req`, `flags.skip_brp_setup_phase`, `p_brp_cfg_info`,
`notify_cancel`, `notify_results_func`.

Хранение состояния: **[4.1]** **0x800ef4 + 12·cid** (`bf_state__set` @0x9283c8:
+0 state, +4 обнуляется; +0xa — байт, по вендорской раскладке, предположительно, запрос
тренировки) **[код]**; **[6.2]** `0x801ffc + 20·sta` (+4 подсостояние, +0xa байт,
+0xc аргумент), §7.

## 3. Два диспетчера BF [4.1] **[код + железо]**

1. **Фоновый** — `bf_sm__background_step` @0x9225ec: метка трассы MAC-кольца
   `0xfaf000 | state | substate<<4`, переключатель по state через таблицу **uc_data
   0x800ba8** (18 байт, база 0x922654; блок `bf_sm__substate_advance` — тело
   этого переключателя, своих вызывающих у него нет):

   | state | ветка |
   |---|---|
   | 0 IDLE | 0x922824 |
   | 1, 6–8, 12, 15, 16 | 0x922812 (ничего) |
   | 2 PRE_TXSS_INIT | 0x922658 (сброс скорости, TX-запрет CID `mid_vring_mask_update(3)`, state 3, байт 5 в `[r13+9]` — смысл не доказан) |
   | 3 TXSS_INIT | 0x922676 → `bf_substate_sm__step` |
   | 4 TXSS_RESP | 0x922688 → `bf_substate_sm__is_state_9_11` |
   | 5 PRE_MID_BRP_RX_INIT | 0x9226c2 |
   | 9 BRP_INIT | 0x9226d0 → `bf_sm__substate_result_by_slot` (1 → DONE, 2 → 14) |
   | 10 BRP_RESP | 0x9226ec → `bf_sm__advance_if_slot33` (1 → DONE, 2 → 14 RXSS_FAILURE) |
   | 11, 14 | 0x92271a (`bf_sm__state_failure_path`) |
   | 13 DONE | 0x922724 |
   | 17 ABORT | 0x922654 |

   Успех и для state 3, и для state 4 сходится в @0x922698 (§4). **Маска
   `[gp,0xaa]` здесь не смотрится.**
2. **Слотовый** — `bf_substate__dispatch_by_state` @0x922850 (из
   `bf_sm__step_by_state` @0x9221f8), метка `0xfcf000 | …`, switch по state−3
   (таблица 0x800c58); здесь учитывается маска `[gp,0xaa]` (§5) и есть вход в 10
   BRP_RESP.

Следствие: **ответчик SLS, прошедший фоновый путь, сам становится
BRP-инициатором**, а не ответчиком (переход 4→9 для ответчика @0x922698, 3→9 для
инициатора). При двух «связанных» соседях обе стороны уходят в BRP_INIT и ждут
друг друга — взаимная блокировка **[код + железо]**, §10.1.

## 4. Развилка после SLS: бит «связан» 0x801034 [4.1] **[код]**

`bf_sm__substate_advance` @0x922698..0x9226b6: по итогу подсостояния SLS
(`bf_substate_sm__step` / `bf_substate_sm__is_state_9_11`, код 1 = успех)
читается байт **0x801034** и `btst` бита CID: бит 0 → `mov.eq r1,0xd` — **сразу
DONE**, бит 1 → 9 **BRP_INIT**. Код 2 → 0xb TXSS_FAILURE. Живьём `0x801034` = 1 на
обоих узлах (бит CID 0 взведён) **[железо]** — отсюда обязательный BRP.

Писатель — **LMAC 0x0f**, ветка `umac_if_cmd_handler` @0x936ee0 (таблица
0x800c68, вход 0xf = 0x41, база `pcl`=0x936e54+0xa); отправляет её fw из
`maintain_sm__on_start_maintain`. Тело `{u32 cid, u16 flag}`; flag≠0 → бит CID в
**`[0x800fcc+0x68]` = 0x801034** (адрес через базу, литералом не находится);
flag=0 → снять бит, прервать висящий BF (`0x924fd0`), `[gp,0xaa] |= бит`,
`[gp,0xa8] &= ~бит`. Читатели: `rx_funcs__rx_flow`, `rx_flow__handle_frame`
(ответчик A-BFT UNASSOCIATED/ASSOCIATED_ONLY), `bti__bi2_event_step`,
`aw__set_new_tbtt`, `power_mngr_peer_update`, `get_tx_eligibility__precheck`,
`traffic_deferral__is_enabled`, `bf_sm__check_sta_timeout`.

Для ассоциированного соседа DTI-BF всегда тянет BRP. Без бита 0x801034 BF после
SLS завершался бы DONE, запрос BF закрывался, и TX-запрет CID снимался бы
**[гипотеза, не проверено на железе]**. Сброс бита на 4.1 затронул бы девять
читателей (ответчик A-BFT, TX-eligibility, power manager, NAV) — вероятны
побочные эффекты **[гипотеза]**.

Аналог в 6.2 — бит CID в `[0x80217c+0x18]`; карта LMAC 0x0f 6.2 —
`0x80218c+8` ([DATAPATH.md](DATAPATH.md) §8).

## 5. Маска пропуска BRP `[gp,0xaa]` (ucode 0x8005d2) [4.1] **[код + железо]**

Слотовый диспетчер `bf_substate__dispatch_by_state` @0x922850 (switch по
state−3, таблица 0x800c58) после успешного TXSS проверяет, кроме бита 0x801034,
**u16 `[gp,0xaa]`**:

* TXSS_INIT успешен (@0x9228a6..0x9228d2): `[0x8011d4+9·cid]`≠0 → 0x9258d0; иначе
  бит CID в `[gp,0xaa]` → **BRP пропускается** (r13=3); иначе бит в 0x801034 → 9
  BRP_INIT.
* TXSS_RESP успешен (@0x9228e2..0x922914): байт `[0x800efe+12·cid]` (поле +0xa
  записи состояния) ≥1 и бит CID **не** в `[gp,0xaa]` → **10 BRP_RESP**; иначе
  конец.

Писатели маски:

* `brp__build_tx_params` @0x92ab1c (из `brp_flow_step`, `mac_mode_brp_step`,
  `mac_mode_step_b`): разбирает поле **BRP Request принятого кадра** в буфере
  0x804010 (+0x20/+0x21, +0x24, +0x1b). Байт +0x20 ≠ 0 (сосед просит тренировку)
  → снять бит (делать BRP); = 0 и `[0x857280+0x24]` = 0 → **взвести бит (пропуск
  BRP)**; иначе снять. Всегда ставит бит в `[gp,0xa8]` (u16 0x8005d0).
* `bf_sm__process_request_fifo` @0x9227bc — снимает бит.
* LMAC 0x0f с flag=0 (разрыв связи) — взводит.

Живьём слово 0x8005d0 = `0xffff0000` на узле A (маска 0xffff — CID 0 пропускает
BRP) и `0xfffe0000` на узле B (бит 0 снят — делает BRP) **[железо]**: узлы
по-разному прочли BRP Request друг друга.

Рычаг-кандидат (не проверен): флаг `0x857280+0x24` в общем блоке, виден и
прошивке (fw пишет 0x857280 при загрузке, `WBE_DRIVER__pcie_boot_init`). При нуле
и отсутствии запроса тренировки от соседа BRP пропускается штатно.

## 6. Выключение BRP с хоста: WMI_BF_CONTROL 0x9aa [6.2] **[код]**

1. fw `wmi_bf_control` @0x8ec068 разбирает команду **не по раскладке wmi.h
   мейнлайна**: +0x05 txss_mode и +0x06 brp_mode → `[0x8014b0+0xd/+0xe]`; +0x07 →
   `[gp,0x92]`; +0x08 — флаг обновления long-term порогов, тогда 13 слов с +0x1e
   ×1000 → `0x801448[13]`; +0x09/+0x0a/+0x0b/+0x10 → байты
   `0x8014b0+8/+0xa/+9/+0xb` (только ненулевые); u32 из +0x0c/+0x0e →
   `[0x8014b0]`. Лог: «BF control: BRP en/dis=%d, TXSS en/dis=%d, long_term
   is_TH_update=%d».
2. Затем две LMAC-команды через 0x8e5204: **0x10** (16 Б — копия 0x8014b0) и
   **0x14** (u32 из +0x00/+0x02 — «Updating triggers enable dword»); ответ хосту
   — событие **0x19aa**.
3. ucode `ucode_cmd_0x10_handler` @0x9220d4 кладёт txss_mode → **0x8021dc**,
   brp_mode → **0x8021dd** (база 0x8021b8 +0x24/+0x25).
4. Развилка после SLS, `bf_sm__process_request_fifo` @0x921e08..0x921e36:
   `brp_mode == 1` **и** бит CID в `[0x80217c+0x18]` → 9 BRP_INIT, иначе → **0xd
   DONE**; код 2 → 0xb TXSS_FAILURE.
5. `bf_init_sm` @0x921ac8..0x921ad4: запрос чистого BRP при `brp_mode == 0` →
   0x11 ABORT вместо 9.

**[4.1]** этого гейта нет: развилка @0x922698 смотрит только бит `0x801034`, тело
LMAC 0x10 в 4.1 (0x30 Б, вендорская подструктура с +0x24) кончается раньше, чем
пришлось бы поле brp_mode; `WMI_BF_CONTROL` в диспетчере 4.1 отсутствует
([WMI.md](WMI.md)).

Следствие: на 6.2 прямой линк может жить без BRP штатной командой хоста: SLS →
DONE → запрос BF закрыт → TX-запрет CID снят **[гипотеза]**.

## 7. Очередь запросов BF и политика отказа

### 7.1. Политика отказа [4.1] **[код + железо]**

`failure_policy` в ucode — `0x8005f0`; живьём 1 (`BF_RETRY_FOREVER`) на обоих
узлах. fw выбирает её в `lm_main_sm__on_maintain_started` @0x8d9c6e..0x8d9c8e
по `m_bss_mode`: ∈ {2,3} (PCP/AP) → r2=0 (ABORT), иначе r2=1 (RETRY_FOREVER),
передаётся в 0x8c5f10. Безролевой линк ставит `m_bss_mode=1`, отсюда
RETRY_FOREVER. В режиме повтора запрос никогда не завершается, поэтому ни
снятия запрета TX, ни сброса причины `BF_TRIGGER_FW_MSK` не бывает
([DATAPATH.md](DATAPATH.md) §6).

### 7.2. Очередь запросов [6.2] **[код]**

| блок | смысл |
|---|---|
| `bf_req__enqueue` 0x921bd4 | ставит бит станции в **маску ожидающих `0x8020b0`**, состояние `0x801ffc + 20·sta` (+4 подсостояние, +0xa байт, +0xc аргумент), номер станции в FIFO `0x8020b4` (8 мест, хвост `0x8020c0`); переполнение — ассерт 0x12; возвращает «очередь была пуста» |
| `bf_req__dequeue_head` 0x921b38 | снимает голову (`0x8020bc`), сбрасывает бит и состояние; если есть следующая станция — **MAC в `0x802188`** (адрес, с которым сверяются кадры SLS) и запуск её потока; иначе уведомление fw, счётчик `0x80211c` |
| `bf_sm__process_request_fifo` 0x921d50 | для головы очереди — переход по состоянию через байтовую таблицу `0x801804` (состояний < 0x13) |
| `bf__pause_sta_tx` / `bf__resume_sta_tx` 0x92ba54 / 0x92bb34 | маска запрета передачи станции `0x802a90[sta]` (бит — причина); [DATAPATH.md](DATAPATH.md) §6, §8 |
| `bf_sm__txss_init_result` 0x93b840 | итог TXSS_INIT по таблице `0x801830` |
| `bf_sm__txss_resp_result` 0x93bdf0 | 9 → успех, 10 → 3, 11 → 2 |
| `bf_sm__brp_init_result` 0x922494 | 0 → старт BRP, 0x30 → успех, 0x31 → до 3 повторов, иначе провал |
| `bf_sm__brp_resp_result` 0x922e74 | 0x33 → успех |
| `bf_sm__set_state` 0x92af2c | таблица переходов `0x801815` для состояний 3…10 |
| `brp_init__flow` 0x922728 | §9 |

## 8. SLS в DTI [6.2] **[код + железо]**

### 8.1. Приём кадров развёртки — `sls__rx_ssw_frame` 0x928520

В корреляции — `mac_cmd_0x38__928520`.

Зовётся из `rx_flow__handle_frame`, только если кадр — SSW (`r36.ss_detected`) или
no-action mgmt, и **`[0x801424]` бит 0 = 1** (MAC в режиме SLS; иначе кадр
сбрасывается, а в общем блоке ставится бит 2 байта причин BF `0x857e49 + 20·sta`
— рядом со счётчиком отказов CTS `0x857e48`, см. [DATAPATH.md](DATAPATH.md) §8).

1. `[gp+0xcc]` бит 3 = 0 → отброс, счётчик `0x802334`.
2. Маска ожидающих станций `0x8020b0 == 0` (кадр пришёл без запущенного потока
   BF): при `[0x8014c0] == 0` и ненулевой маске ожидаемых станций `0x802194` TA
   (`0x80401a`) сверяется с MAC старшей станции маски; несовпадение → счётчик
   **`0x8006e8`**; иначе счётчик **`0x8006e4`** и TA запоминается в **`0x802188`**.
   `0x8020b0 ≠ 0` — TA сверяется с `0x802188` молча; кадр станции в состоянии BF
   0x11 (ABORT) игнорируется.
3. По `r37.ss_bitmap`: бит 0 SSW — только с `direction = 0` (ISS): флаг `0x8021e0`
   бит 0; на последнем кадре (`r39.zero_cdown`) — `rx__mac_prepare` и запуск
   ответной развёртки, бит 1; бит 1 SSW-Feedback — если станция в маске
   `0x802192`: разбор (`rx__parse_ssw_field`), установка сектора станции
   (`uses_g__93d180_…`), бит 2; бит 2 SSW-ACK — бит 3. Перед SSW программируется
   `0x886d00` из `0x802974` и MAC 0x38000200.

Флаги `0x8021e0` (бит 0 ISS соседа, 1 развёртка соседа окончена, 2 SSW-Feedback,
3 SSW-ACK, 4 RTS) читают потоки §8.2–8.3.

**Железо:** AP `0x8006e4` = 72 000+ (ISS станции доходят), отказов по TA 0;
станция — 15 за всё время. Адрес соседа в `0x802188` верный на обеих сторонах
(`24:18:1d:24:3b:0b` / `24:18:1d:26:d4:7b`), `[0x801424] = 3`. RSS (`direction =
1`) этот обработчик не разбирает — инициатор получает их через
`rx_funcs__handle_ppdu_report` (§8.3).

### 8.2. Поток TXSS инициатора и окно ожидания RSS

`txss_init__flow` 0x93bc90 (в корреляции `tx__mark_start_and_program`) — весь
поток TXSS инициатора: на время SLS пишет в регистр SIFS `0x886d00` значение
`0x802974` (после SLS — обратно `0x802968`), `txss__program_tx_frame(sta, 5, …)`
отправляет ISS (иначе подсостояние 1 `ENERGY_FAILURE_SS`), затем
`txss_init__wait_rss` ждёт RSS; при успехе лучший сектор и SNR копируются
(`0x80212c`/`0x80212d` → `0x802a8c`/`0x802a8e`) и вызывается
`txss_init__send_fdbk_wait_ack`.

`txss_init__wait_rss` 0x93bb18 (в корреляции `txss__prepare_frames`) — ожидание
RSS: MAC `0x020d2200`, `0x49000001`; GP0 = **`[0x8020c4 + 4·sta]`**, GP1 =
`0x1489b5` (≈ 8,2 мс); цикл по событиям:

| событие | итог (подсостояние TXSS_INIT) |
|---|---|
| `r54` бит 0 или `0x8021e0` бит 1 | успех, выход 1 |
| `r42` бит 19 (`busy_event`) → `rx_flow__run`, затем `0x8021e0` бит 2 | 7 `UNEXPECTED_SS_FDBK_FRAME` |
| то же, `0x8021e0` бит 4 | 8 `UNEXPECTED_RTS_FRAME` |
| **`r54` бит 6 (конец GP0)** | **2 `NO_SS_RESP_FAILURE`** |
| `r54` бит 7 (конец GP1) без бита 1 | 3 `GLOBAL_TIMEOUT_FAILURE` |
| `0x8021e0` бит 0 (ISS соседа — оба инициаторы) | сброс бита, `txss__rank_best_sector`, GP0 стоп, ждать дальше |

**Окно ожидания RSS** пишет `ucode_cmd_0x18_handler` (LMAC 0x18, поле типа 8 —
`l2_mgr__set_rf_params`):

    [0x8020c4 + 4·sta] = [0x857280 + 0xc] × (N × 0xa40 + 0x528)

`0xa40` = 2624 такта = **15,9 мкс на кадр SSW** (тот же шаг, что в расписании
маяков), `0x528` = 1320 тактов = 8 мкс, N = `[0x801151 + 0x50·sta]` — число
секторов соседа (из его DMG Capabilities). Живьём на обоих узлах N = 64,
множитель 1: **`0x29528` = 169 256 тактов ≈ 1026 мкс** **[железо]**. RSS из 64
кадров управляющего PHY с MBIFS занимает ≈ 1010 мкс — запас ≈ 15–20 мкс. У 4.1
соседи объявляют 35 секторов (≈ 565 мкс).

GP-таймеры потока: `gp_timer__arm` 0x93512c (в корреляции
`brp__issue_mac_cmd`) — взвод GP-таймера i на длительность (MAC `0x52+i`, `0x49`
бит i+6, `0x4f+i` | значение, `0x52+i` | 0xb); `gp_timer__stop` 0x925998 —
остановка GP-таймера i; `rss_wait__get(sta)` — окно ожидания;
`txss__rank_best_sector` 0x935938 — ведение топ-4 секторов по SNR (`0x802138 +
12·k`, порядок `0x802174`) и копия лучшего в `0x80212c`.

### 8.3. Ответчик TXSS и завершение развёртки

`txss_resp__flow` 0x93bff0 (в корреляции `rgf_886d00__93bff0`): роль `[gp+0xcc] =
0x40`, для cid 8 копирует адрес соседа в `0x8013b4`, затем
`txss_resp__wait_iss_end` 0x93bf1c (в корреляции `mac_cmd_0x49__93bf1c`): GP1 =
окно `rss_wait__get(sta)`; при `r54.txss_end_ind` или `0x8021e0` бит 1 —
запоминает лучший сектор ISS и **отправляет RSS** (`txss__program_tx_frame(sta,
1, 1, 0, 0)`), иначе по GP1 — подсостояние **11**. Затем `txss_resp__wait_fdbk`
0x93be68 (в корреляции `uses_rgf_886d00_93be68`): SSW-Feedback (бит 2) → сектор
станции задан, подсостояние **9**; новый ISS посреди ожидания (бит 0) → **11**;
таймаут GP0 → **10**.

Бит 1 `0x8021e0` («развёртка соседа окончена») ставит
`rx_funcs__handle_ppdu_report` 0x9316cc только на кадре с `r39.zero_cdown` и
только через **ролевой гейт** развёртки (как в 4.1): кадр SSW от
зафиксированного соседа (`TA == 0x802188`) в фазе `[gp+0xd0]` = 0x100000/0x200000
принимается, если (Direction = 0 и роль 0x40) или (Direction = 1 и роль 0x20).
Иначе завершение даёт только аппаратный `r54.txss_end_ind` (бит 0).

### 8.4. Кадры завершения SLS

* `txss_init__send_ssw_fdbk` 0x93c0d4 (в корреляции `macreg_r45__93c0d4`) —
  **SSW-Feedback** инициатора: FC = управляющий кадр, подтип 6 (Control Frame
  Extension), расширение **9**; поле сектора = `0x80212c | 0x80212d << 6` (лучший
  сектор RSS и антенна), SNR = `(0x802134 − 19) · 4`, BRP-поля по маске
  `0x802194`, адреса из контекста станции (`0x801134..0x801138 + 0x50·sta`).
  Перед передачей задержка MAC 0x15 = `0x8015a0 + SIFS` (`0x886d00`), затем
  прямая передача (MAC 0x33000443) и ожидание события 0x8000.
* `sls__build_ssw_ack` 0x93b220 / `sls__send_ssw_ack` 0x934424 — **SSW-Ack**
  ответчика (расширение **10**): сектор — лучший из ISS или из таблицы станции
  `0x857c1c + 0x3c·sta`. На время передачи набор RF в `0x889488` меняется на TX
  (`0x802940`), после — обратно на RX (`0x802944`).
* `txss__store_sector_ranking` 0x93e210 — топ-5 секторов по порядку `0x802174` →
  таблица станции (`0x857c1c`, бит станции в `0x802192`) или вторая таблица
  `0x857a00`.

### 8.5. Число и порядок секторов развёртки

`lmac_if_config_txss` 0x8db60c (fw): для записи cid берёт диапазон секторов из
таблицы по указателю `[0x8577b0]` (по 2 байта `[первый, последний]` на набор,
индекс — поле соединения +0xc), число = последний − первый + 1, не больше 64
(иначе фатал), при `[0x85773c] < 2` или cid 8 — набор по умолчанию. Список
0…N−1 уходит в ucode (LMAC), отсюда запись `0x802b68 + sta·0x4c` (таблица ниже). Таблица диапазонов
заполняется из board-файла (секции RF-наборов/секторов, `handle_rf_sets_info`,
[HW-DRIVERS.md](HW-DRIVERS.md)); в board-файле `wap60g-60deg` TX-секция — 64
записи **[код]**.

**Таблица развёртки TXSS по станциям [6.2] [код + железо]:** `0x802b68 + sta·0x4c`,
9 записей (0–7 — станции, 8 — широковещательная/маячная):

| смещение | размер | содержимое |
|---|---|---|
| +0 | 4 | слово (0) |
| +4 | 4 | флаг «задано хостом» (ставит `wmi_cmd_txss_set_sectors_number` 0x93e168) |
| +8…+0x47 | 64 | порядок секторов (0xff = конец) |
| +0x48 | 4 | число кадров SSW (`update_sector_sweep_frames_number` 0x93d100: минимум из запрошенного и длины порядка) |

Живьём на AP и STA 6.2: записи 0 и 8 = 64 сектора `00 01 02 …`, остальные пустые.

**Порядок секторов с хоста:** `WMI_PRIO_TX_SECTORS_ORDER` 0x9A5 в 6.2 — массив
**64 Б**, `sector_sweep_type` в +0x40, `cid` в +0x41, всего 68 Б
(`lmac_if_set_ss_sectors_order_handler` 0x8dc080: `add3 r13,r14,8` = +0x40;
проверка `sector_list__validate`, затем LMAC 0x35). Порядок держится (прошивка
его не переписывает, в отличие от прямой записи в `0x802b68`, которую
`lmac_if_config_txss` затирает быстрее секунды).

**Опыт [железо]:** порядок «сектор 35 (центр) последним» на обоих узлах, окна по
30 с: AP `4:11` 3 292 / 3 397 против базы 3 176 / 3 821, STA `triggers:4` 1 309 /
1 763 против 1 619 / 2 157 — без эффекта. Потеря последнего кадра развёртки на
угловом секторе причиной провалов не является.

## 9. BRP-инициатор [6.2] **[код]**

* `brp_init__flow` 0x922728: подсостояние 0x31 по умолчанию;
  `brp_initiator_brp_transaction_flow`; при успехе 0x30 и для каждого RF-модуля
  (`0x8006b7`) 32 AWV из `0x801ef4 + 32·rf` + `config_brp_rf`; затем
  `brp_update_omni_sector_idx(sta, успех)`, стоп GP0, MAC 0x52000000.
* `brp_init__tx_request` 0x9229c0 (в корреляции `macreg_r45__9229c0`) — сборка
  кадра запроса BRP в `0x800898` (RA = MAC станции из контекста, номер
  последовательности из регистра `0x886544`, поля BRP `0x105`, TX-вектор станции
  `+0x0c`), передача (MAC `0x19000001`, ожидание `r45` б31), затем окно приёма
  ответа (`0x02013800`, GP через `0x92f42c`).
* `brp_initiator_brp_transaction_flow` 0x922514 — цикл обмена BRP с исходами
  «failure 1…5»:

  | строка | условие | счётчик |
  |---|---|---|
  | failure 1 (`0x1000a80`) | 10 раз `brp__program_and_measure` вернул 0 | `0x801ee6` |
  | failure 2 (`0x1000ab4`) | во время обмена принят кадр SSW (`r37` бит 24, `ss_bitmap`) | — |
  | failure 3 (`0x1000ae8`) | 10 таймаутов GP0 (`r54` бит 6) подряд при разрешённом повторе (`0x800874` бит 0) | `0x801ee8` |
  | failure 4 (`0x1000b1c`) | таймаут GP0 без права повтора | `0x801eea` |
  | failure 5 (`0x1000b50`) | ни кадра (`r42` бит 12), ни таймаута | — |

  Успешный ответ: `r42` бит 12 → разбор, `r36` бит 25 (`no_action_mgmt`) →
  `rx__is_brp_frame` → `uses_g_801820__92e1e4` → `brp__program_and_measure`
  (счётчик успехов `0x801ee4`).
* **Направленный omni:** `brp_update_omni_sector_idx` 0x923970: если `[0x8014c0]
  == 0` или `[0x8577b4] < 2` — пишет в поле +0x10 записи станции (биты 8..22,
  см. [../6.2/docs/RX-BRP-UC.md](../6.2/docs/RX-BRP-UC.md)) 96+sta, а при провале
  BRP (второй аргумент 0) и `FUN_936de0(0) & 1` — **0x7fff** (обычный
  quasi-omni); печать «brp_update_omni_sector_idx sta:%d directed_omni rx sect
  idx:%d». Следствие для приёма ответов — там же, раздел о конфигурации приёма.
* Вспомогательные: `rfca__select_rf_uc` 0x928b8c — маска RF-контроллеров
  `0x889488` б8..15 (ожидание `r47` б17, «RFC занят» `0x8890cc` б29 → ассерт),
  двойник fw-функции ([HW-DRIVERS.md](HW-DRIVERS.md)); `brp__parse_request_fields`
  0x92e1e4, `brp__rf_module_done` 0x923208, `brp__rank_insert` 0x92e904 (топ-N по
  метрике на RF-модуль, `0x801c94 + 64·rf`, N = `[0x801ff4]`), `bf__flow_exit`
  0x921c50, `brp__is_peer_ctrl_frame` 0x9232d4, `brp__select_cfg_by_snr` 0x922d2c
  (пороги 5/12/20/28/37, маска `0x800890`, таблица `0x800fc0`).

## 10. Наблюдения на стенде

### 10.1. 4.1: STATE 9 / SUBSTATE 49 **[железо]**

* STATE=9 — фаза BRP в роли инициатора, SUBSTATE=49 = 0x31 — «BRP не завершён».
  В STATE 9 попадают только после успешного SLS (TXSS) в DTI — своего
  (подсостояние 5) или ответного (подсостояние 9) — и только при бите «связан» в
  `0x801034`. Рвётся не SLS, а следующий за ним BRP.
* BRP-инициатор шлёт BRP-кадр 4 раза и ни разу не получает BRP-ответа: счётчик
  принятых BRP `0x8014d8` = 0 на обоих узлах, счётчик «4 таймаута GP0 подряд»
  `0x8010a4` растёт (~8–9/с при ~72 BF_DONE/с; в другом замере ~18/с на узле A);
  остальные провалы — тихие выходы по окончанию TXOP или по приёму SSW соседа.
* Трасса команд MAC (без патчей): узел A проходит ответный TXSS успешно (`0xfaf094`
  = состояние 4/подсост. 9), сразу уходит в 9 и начинает BRP как инициатор
  (`0xfcf009`, `0x4f005a3c 0x52000408`, четыре попытки, `0xfcc319` = 9/0x31).
* Пока BF висит, очередь соседа снята с передачи (живьём `0x801b2c[0]=0x0008`,
  `0x80041c=0`), [DATAPATH.md](DATAPATH.md) §6.
* Причина провала [гипотеза]: оба узла одновременно шлют BRP и слушают в одни и
  те же интервалы (полудуплекс, симметричные тайминги), плюс SLS встречной
  стороны рвёт ожидание (§3).

### 10.2. 6.2: асимметрия AP/STA **[железо]**

AP в роли инициатора BRP проваливается по failure 3 (не получает ответ станции),
после чего `brp_update_omni_sector_idx` ставит ему 0x7fff — приём от этой станции
идёт обычным quasi-omni из board (единичные элементы, [HW-DRIVERS.md](HW-DRIVERS.md)).
Станция BRP проходит и слушает AP направленным omni 96. Отсюда асимметрия: AP не
слышит ответы BRP и RTS станции. Запись `0x941110 = 0x00006020` на AP держится
меньше секунды — следующий провал BRP снова ставит 0x7fff.

**Опыт:** на AP `0x8577b4 := 2` (host `0x91f7b4`, было `0x3401`) — обновление
индекса пропускается — и `0x941110 := 0x6020`. Связь хуже (аплинк 100 %,
даунлинк 83 %), через несколько секунд поле снова `0x7fff20` (переподключение
пересоздаёт контекст). Слот 96 у AP, чей BRP не проходит, вероятно, содержит
негодную AWV. Узел возвращается к исходному после передёргивания питания.

## 11. Rate search [4.1, 6.2] **[код]**

Вендорские состояния ([VENDOR-ENUMS.md](VENDOR-ENUMS.md)): `ucode_rs_state_e`
IDLE / COARSE_ACTIVE / TRACKING, `rs_converge_state_e` NONE/PARTIAL/FULL. В ucode
4.1 перебора скоростей нет — есть выбор и фиксация MCS на соседа:

* `rate_search__start_for_sta` @0x92c34c (зовут `bf_sm__start_request`, LMAC
  0x12/0x30, `ucode_cmd__rs_enable`): cid 8 или `get_g_80051c()==0` → отказ;
  запись `0x8016d8+12·cid` (+0 «активно», не должна быть занята — иначе ассерт),
  счётчик запусков `[0x801958+4·cid+0x70]`, контекст **`0x801738 + 0x2c·cid`**
  обнуляется, +0x1e=1, +0x1c = начальный MCS из `rate_search__build_mcs_mask`;
  кольцевая команда MAC `0x1f000601`. Если `0x800658[cid]` бит 7 — сразу шаг.
* `rate_search__step` @0x92c05c (фоновая задача, маска соседей `[gp,-0x8]`,
  старший бит первым): MCS = `ctx+0x1a` (или `+0x1c`, если 0); если бит 8
  `[0x8009c0+8]` — **понижение на `[0x8009b4+8]`** (`num_rates_reduction` из LMAC
  0x1e `CMD_SELECTIVE_NEIGHBOR_CFG`), при разнице 5 или 9 — на один больше (обход
  MCS 5/9 — [гипотеза]: несуществующие ступени), минимум 1; **`0x800658[cid]` бит
  7 → принудительный MCS = младшие 7 бит**; проверки cid<8, MCS<13 (ассерты);
  `rate_search__apply_mcs` → тайминги MAC; запись в `[gp,0x7c]` (+0x14 cid, +0x10
  MCS, +0x0c из `0x8016e0+12·cid`); событие fw `uc_send_evt__rs_done` @0x925cb0
  (RS_DONE, тип 0x14).

**[6.2]** (по строкам и графу вызовов): `rs_start` 0x9300ec («rs_start cid, next_tx_mcs»),
`rs_end` 0x92fdb4 («rs_end cid, mcs» → событие RS_DONE), `rs_abort` 0x92fb80. Общие с 4.1 по
имени (6.2 / 4.1): `rate_search__pick_tx_params` 0x9301fc / 0x92c44c, `rate_search__commit_mcs`
0x92fd8c / 0x92c034, `rate_search__reset_stats` 0x93003c / 0x92c29c, `rate_search__current_mcs`
0x930018 / 0x92c278, `rate_search__current_mcs_b` 0x92ff44 / 0x92c1c8, `bitstream__push` 0x93cd00
/ 0x93708c. Только 6.2: `sched_bitmap__next_set_bit`, `sched_bitmap__prev_set_bit` 0x92ffec,
`sta__apply_bf_result` (старт RS из BF), `rs__is_sta_enabled` 0x9300ac. На стенде 6.2↔6.2 AP
крутит ~11 000 циклов `rs_start/rs_abort` на MCS 1 за 2 мин
([../6.2/docs/BENCH.md](../6.2/docs/BENCH.md)).

Адаптация скорости («Start Rate Search», COARSE/TRACKING) живёт в fw
(`maintain_sm`, `LINK_STATS_SM`), ucode лишь применяет решение. Принудительный
MCS на соседа — байт 0x800658[cid], host 0x940658+cid; на железе не пробовался.

## 12. Диспетчер по записи станции и блоки BF [6.2]

### 12.1. Запись BF-состояния STA и диспетчер **[код + железо]**

Запись BF-состояния STA — 20 Б с 0x801ffc (+0 состояние, +4 подсостояние, байт запроса L-RX из
PPDU-отчёта). Значения — `ucode_bf_state_e` (§2). Пишет запись `bf_sm__set_sta_state` 0x92b220.
Диспетчер `bf_sm__dispatch_by_state` 0x921fa8 ставит метку трассы 0xfcf, затем берёт обработчик
по **индексу = состояние − 3** из таблицы 0x8019c4 (аналог слотового диспетчера 4.1 §3, switch по
state−3):

* TXSS_INIT → `bf_sm__on_txss_init` 0x93b8d0; при успехе SLS — **BRP_INIT (9)**, если байт
  0x8021d8+5 = 1 (BRP включён) и бит пира в 0x80218c+8; иначе DONE;
* TXSS_RESP → `bf_sm__on_txss_resp` 0x93be28; при успехе — **BRP_RESP (0x0a)**, если байт
  запроса L-RX записи ≥ 1 (запрошенный пиром L-RX из PPDU-отчёта, `rx_funcs__handle_ppdu_report`)
  и пир не в gp-маске;
* BRP_INIT → `bf_sm__on_brp_init` → `brp_init__flow` → `brp_initiator_brp_transaction_flow`;
* BRP_RESP → `bf_sm__on_brp_resp` 0x922e9c: подсостояние 0 → 0x0a и `brp_responder_flow_enter`
  0x922eec; 0x33 — готово (1).

Диспетчер крутит цикл `bf_sm__run_sta` 0x921940 (пока результат 2/3), его зовут
`rx_funcs__rx_flow` (6.2 0x933928, 4.1 0x92f280), `internal_tx_isr`, L1. Приём BRP-кадра (в
`rx_funcs__rx_flow`, место 0x933f8c, r14 = 0x0a) через `bf__abort_unexpected` пишет BRP_RESP
прямо в запись и сразу крутит `bf_sm__run_sta`: ответчик BRP запускается и по приёму кадра, и
после TXSS-R с запрошенным L-RX. Инициатор после своего SLS идёт в BRP_INIT только при
включённом BRP (0x8021d8+5; `bf_init_sm` так же выбирает 9 или ABORT для запроса BF типа 1).
В `.S` часть инструкций этого пути оставлена сырыми байтами — читать с их учётом.

**[железо]** BRP_RESP_SUCCESS на обоих узлах 6.2 ([../6.2/docs/BENCH.md](../6.2/docs/BENCH.md));
в 4.1 до ответчика не доходит.

### 12.2. Ответчик и инициатор BRP

* Поток ответчика: `brp__init_ctx` 0x92b068 (номер RF, `brp__split_id` 0x934dc8),
  `config_brp_rf` 0x925050 (1608 Б — настройка RF-модулей под BRP, «Overriding rfmodule phase /
  etype», сохранение `brp_rf__store_cfg` 0x9213d0, таблица `brp__select_cfg_by_snr`),
  `brp__program_and_measure` (6.2 0x923678, 4.1 0x923930; выбор конфигурации сектора
  `brp__pick_sector_cfg` 0x93cc90, программа MAC `brp__program_mac_sequence_uc` 0x9259d0),
  `brp_responder_transmission_flow` 0x923314 («l_rx, includes TRN-R»), `gp_timer__arm` 0x93512c,
  `brp_update_omni_sector_idx` 0x923970 (направленный omni RX-сектор, §9),
  `brp__rf_module_done`, `brp__is_peer_ctrl_frame` 0x9232d4, `brp__rank_insert`, `bf__flow_exit`.
* Инициатор: `brp_init__flow` (из `bf_sm__on_brp_init`) → `brp_initiator_brp_transaction_flow`
  0x922514 (§9), `brp__read_rf_id` 0x92ed5c, `rf_utils__auto_fill_with_byte` (auto-fill RF),
  `rx__is_brp_frame` 0x92bdbc / `brp__parse_request_fields` 0x92e1e4.
* Восстановление секторов: `brp_restore_sectors` 0x923574 (при смене режима MAC),
  `sector_mem__addr_of` 0x922e14.

### 12.3. Автомат BF по STA, A-BFT, TXSS

* Автомат BF по STA: `bf__abort_unexpected` (6.2 0x92b254, 4.1 0x9283dc; «ABORT unexpected BF of
  new/default sta»), `bf__abort_step` 0x921824, `bf__reset_sta_slot` 0x92484c (события fw
  `uc_evt__send_20` 0x92785c / `uc_evt__send_21` 0x9278c8), `bf__enter_mode3` (0x920cb8 /
  0x9218f4), `bf_clear_all_sta` (0x9218b4 / 0x92211c; при discovery on/off), `bf__reset_sta`,
  `bf_req__enqueue`, `bf_req__dequeue_head`, `sta__reset_link_state`; ветки диспетчера запросов
  по состоянию — `bf_sm__brp_init_result` 0x922494, `bf_sm__brp_resp_result` 0x922e74,
  `bf_sm__txss_init_result` 0x93b840, `bf_sm__txss_resp_result` 0x93bdf0 (§7.2);
  `bf_sm__set_state` и `bf__clear_sta_bit_state34` (0x92ed2c / 0x92b678),
  `bf_sm__set_sta_state`, `bf_metrics__reset_and_stamp` (0x93d28c / 0x9374b4),
  `uc_spin_until_event4__r0_100` 0x920b14, `bf_pending__set_bit` (0x9216f8 / 0x921f58; бит в
  0x800648).
* A-BFT: `abft__send_ssw_feedback` (6.2 0x93b39c, 4.1 0x935990; SSW-Feedback ответчика через
  direct TX, команды 0x33/0x34).
* TXSS: `wmi_cmd_txss_set_sectors_number` 0x93e168 / `wmi_cmd_txss_set_sectors_order` 0x93e1c0
  (команды 0x36/0x35), `update_sector_sweep_frames_number` 0x93d100,
  `txss__order_known_sectors_first` и `ss_plan__next_sector` (параметры развёртки),
  `frame_hdr__init` 0x9246fc, `sls__build_ssw_ack`, `sta__set_rx_sector`; события сектора —
  `uc_send_evt__get_rf_sector_done` 0x927664 / `uc_send_evt__set_rf_sector_done` 0x9277e4;
  `brp__set_phy_884060` 0x929ee0. Таблица развёртки — §8.5.
* Битовые поля ucode (то же устройство, что `bf_set_*` в fw, [../6.2/docs/MISC-FW.md](../6.2/docs/MISC-FW.md)
  §13): `bf_set_s*_w*_uc` 0x93e390…0x93e420 (`txss_init__bits_uc_set32_s0_w2` 0x93e390 …
  `sls__bits_uc_set32_s8_w4` 0x93e420), общие `bf_b_core_uc` (6.2 0x93ec7c, 4.1 0x937f40),
  `bf_rmw_half_uc` (0x93ec90 / 0x937f54), `bf_rmw_word_unaligned_uc` (0x93ec10 / 0x937ed4) и
  хвосты 0x93e33c…0x93e384 (`brp__set_tx_sector_id` 0x93e33c … `txss__set_frame_half_s1_w2`
  0x93e384).

## Метод

Замеры по потоку ucode (`uc_trace`, сборщик драйвера — кольцевой буфер 1 МБ):
чтение `uc_trace` буфер не освобождает, каждый снимок — вся накопленная история,
и сборщик может остановиться. Окно замера задаётся по времени пачек:
`SparRAW-tools/host/wil_uc_collect.py --since/--until` (время пачки — монотонные
часы узла, как `/proc/uptime`); `SparRAW-tools/bench/62/bfmeasure.sh` меряет окно
по часам узла. Перед замером проверять, что свежая пачка не старше нескольких
секунд. Между прогонами без изменений картина провалов BF колеблется от «SLS
проходит, аплинк 0 %» до «тысячи провалов» — сравнивать только сериями.

## Замечания

* `bf__abort_to_state11` ставит 0x11 = 17 (ABORT), а не 11.
* Скорость роста `0x8010a4` на 4.1 записана двумя значениями (~8–9/с и ~18/с на
  узел A) — разные замеры.
* Описание приёмного тракта 6.2 утверждает, что в 4.1 нет механизма
  «направленного omni» и BRP-ответчика; при этом в 4.1 есть состояние 10
  BRP_RESP и поток BRP-R (§1, §3, §5). Отсутствие в 4.1 относится к
  `brp_update_omni_sector_idx` (поле направленного omni); наличие рабочего
  BRP-ответчика 4.1 на стенде не проверено.
* Переход 4→9 @0x922698 (ветка по 0x801034) по листингу подтверждён; трактовка
  бита как «сосед связан» — по писателю LMAC 0x0f.
* `r42` бит 19 — `busy_event`, а не «кадр принят» (`6.2/ref/MSXD-LR-RGF.txt`).
* Смещение байта запроса L-RX в записи состояния 6.2 указано двумя значениями: +9 (по разбору
  диспетчера TXSS_RESP, §12.1) и +0xa (раскладка записи, §2, §7.2).

## Не установлено

* Сопоставление полей записи состояния 4.1 (0x800ef4+12·cid) с вендорской
  `bf_connection_db_s`, кроме state и +0xa.
* Какой из двух диспетчеров 4.1 отрабатывает в каждом случае (от этого зависит,
  почему узла A с маской пропуска тоже уходит в STATE 9).
* Почему в штатной паре PCP–STA взаимной блокировки BRP_INIT нет (разные пути
  или политика ABORT по `m_bss_mode`).
* Точная причина провала BRP на 4.1 (STATE 9 / SUBSTATE 49).
* Эффект флага `0x857280+0x24` и сброса бита 0x801034 на железе.
* Работает ли на 6.2 прямой линк с `WMI_BF_CONTROL` brp_mode=0.
* Эффект расширения окна RSS: удвоение (`0x9420c4 := 0x52a50`, ≈ 2 мс) на обоих
  узлах измерено по накопленному буферу `uc_trace` (см. «Метод»), результат
  недействителен.
* Смысл байта 5 в `[r13+9]` в ветке PRE_TXSS_INIT фонового диспетчера.
* Строка «Обратная связь о секторе» таблицы потоков — чем кончается.
