# Регистры и управляющие биты ucode 6.2

Справочник по битам, которые микрокод (uc) 6.2.0.1000 читает, проверяет и выставляет:
расширенные core-регистры ARC r32…r56, вспомогательные (AUX) регистры ядра, управляющие слова
в DCCM и периферийные регистры 0x88xxxx…0x8bxxxx. Для каждого бита указаны источник имени
и места в vendor-листинге, где бит реально проверяется.

Метки: **[пак]** — имя из символьного пака 11ad (`6.2/ref/MSXD-LR-RGF.txt`, `REGS-KNOWN.txt`);
**[код]** — по листингу `6.2/src/asm/uc`; **[пак+код]** — имя из пака, а использование в uc ему
соответствует (это проверено по листингу); **[ISA]** — штатная семантика ARC600 (номера AUX-регистров и биты
STATUS32 из документации ядра, а не из пака); **[железо]** — подтверждено на стенде (только там, где
это уже сделано в других документах). «Предположение: …» — вывод без прямого доказательства.
«Назначение не установлено» — бит используется, но смысл неизвестен. Все адреса — **[6.2]**.

Обозначения: `0x93xxxx` — адрес инструкции в vendor-листинге (метка `L_93xxxx` в
`6.2/src/asm/uc/**/*.S`); имена функций — как в заголовках листинга (`a__b`); в
`rewrite/tools/ghidra/out/names.txt` и в нашем C те же имена с одним подчёркиванием.
gp uc = `0x800528`: `ld_s r0,[gp,0xd0]` — байтовое смещение (0x8005f8), `ld.as r0,[gp,0x34]` —
смещение ×4 (тот же 0x8005f8). Кольцо и формат MAC-команд — [MAC-COMMANDS.md](MAC-COMMANDS.md),
идиома локального чтения и группа R40 — [MAC-REGISTERS.md](MAC-REGISTERS.md).

Содержание:

1. [Сводка](#1-сводка)
2. [Core-регистры r32…r56](#2-core-регистры-r32r56)
3. [AUX-регистры ядра](#3-aux-регистры-ядра)
4. [Управляющие слова DCCM](#4-управляющие-слова-dccm)
5. [MMIO 0x88xxxx](#5-mmio-0x88xxxx)
6. [Формат MAC-команд](#6-формат-mac-команд)
7. [Расхождения](#7-расхождения)
8. [Не установлено](#8-не-установлено)

---

## 1. Сводка

| регистр | что это | как выбирается | чтений в uc | главное |
|---|---|---|---|---|
| r32 | порт команд MAC (только запись) | — | 1026 записей | [MAC-COMMANDS §1](MAC-COMMANDS.md#1-интерфейс-core-write) |
| r33 / r34 | FIFO передающего тракта (только запись) | — | 29 / 39 | слово / байт (полуслово) |
| r36…r39 | отчёт о принятом PPDU | single-mapped | 30 / 36 / 51 / 9 | тип кадра, адрес, MCS |
| r40 | группа R40 (16 регистров) | полубайт [15:12] селектора | 101 | PHY_SIGNALS, BACKOFF_IFS_STATUS, BI_COUNTER |
| r41 | группа R41 (очереди) | полубайт [11:8] | 16 | выбор очереди, маски qset |
| r42 | события EVENT1..3 | селектор не пишется (§2.3) | 80 | ожидания, главный цикл L1 |
| r43 | ответ MTP на запрос | — | 57 | `valid` б31, MCS, политика ACK |
| r45 | разрешение MTP на TX | — | 63 | `valid` б31, байт `null_status` |
| r47 | группа R47 | полубайт [19:16] | 35 | DIRECT_TX, RFC, LFSR, агрегация |
| r49 | EVENT_ENGINE2 (PHY BRP) | — | 8 | б5, б13, [19:16] |
| r51 | MTP_DESCRIPTOR_SCRATCHPAD | — | 34 | копируется в 0x800608/0x80060c |
| r53 | BAP_IF_0 | — | 23 | BA-интерфейс |
| r54 | события EVENT4 (GP-таймеры, TXSS) | — | 40 | таймауты, окна BI |
| r55 | группа R55 | MAC-команда 0x4d | 10 | TSF, SIFS_CNT, GP_CLK2 |
| r44, r46, r48, r50, r52, r56 | — | — | 0 | в uc 6.2 не читаются |

Число чтений — вхождения `rN` в vendor-листинге (`grep -rhoE '\br(3[2-9]|4[0-9]|5[0-6])\b'`).

---

## 2. Core-регистры r32…r56

Расширенные регистры ядра ARC читаются и пишутся командой `mov` (`arc_core_rd(N)` /
`arc_core_wr(N, v)` в `rewrite/include/arc.h`), не `lr/sr`. Регистры результата r36…r56 —
регистровый файл `MSXD_LR_RGF` (группа = номер регистра, индекс в группе = селектор) **[пак]**.

### 2.1. r32 — порт MAC-команд **[код]**

Запись `mov r32,rX` отправляет одно 32-битное слово блоку SXD MAC; сразу за ней та же запись
идёт в кольцо DCCM по r25 (`st.ab rX,[r25,4]; bclr r25,r25,0xa` — заворот на 1 КБ). Формат слова
(бит 31 — событие PMC, [30:24] код, [23:0] параметр) и все коды —
[MAC-COMMANDS.md §1.1](MAC-COMMANDS.md#11-формат-слова). Здесь только то, что связано с
регистрами результата:

| код | действие на регистры результата | источник |
|---|---|---|
| 0x1d | меняет один полубайт теневого селектора, через 3 такта результат в r40/r41/r47/… | [MAC-COMMANDS §7.3](MAC-COMMANDS.md#73-0x1d-и-0x4d--локальное-чтение-железо) |
| 0x4d | выбирает регистр группы R55, результат в r55 | там же; §2.16 |
| 0x02 | маска ожидаемых событий r42 (бит 9 — `gp_timers_event` для таймаута) | §2.4 |
| 0x27 | разрешение битов событий (`[0x8004e0] \| 0x27000000 \| (1<<n)<<8`) | `mac_evt__enable_bit_sync` 0x9361bc |
| 0x49 | квитирование битов r54 | [MAC-COMMANDS §7.6](MAC-COMMANDS.md#76-gp-таймеры-и-r54-0x49-0x4f0x54-0x670x68) |
| 0x23 | `0x23010000 \| t` — взвести GP-таймер таймаута ожидания | `uc_wait_event_busy` 0x9366e8 |

### 2.2. r33 / r34 — FIFO передающего тракта **[код]**

Оба регистра в uc только пишутся: так ucode кладёт байты кадра в FIFO TX MAC (direct TX),
параллельно уменьшая счётчик свободного места `0x800514` (`[gp,-0x14]`).

| регистр | запись | что уходит в FIFO | основание |
|---|---|---|---|
| r33 | `ldb r33,[p,0x13]; or r33,r33,b<<8; …` или `mov r33,imm` | 32-битное слово | после записи `0x800514 -= 4` (`uc_fifo_frame_tail`, 0x93b2e0) |
| r34 | `ldb r34,[p,N]` | один байт | `0x800514 -= 1` на байт (`uc_fifo_frame_tail`) |
| r34 | `bset r34,r0,0x18` (r0 — полуслово) | **бит 24 = признак полуслова** | `direct_tx__send_after_delay` 0x938266…0x938288: три записи с битом 24, затем `0x800514 -= 6` |

Предположение: бит 24 в r34 переключает запись на 16 бит. Во второй ветке той же функции
(0x938280…) после трёх таких записей вычитается 0xc, а не 6, то есть учёт там суммарный, и прямого
доказательства нет.

Свободное место FIFO uc узнаёт из `DIRECT_TX_CMD_STATUS.available_space` (r47, §2.11).

### 2.3. Селектор групп: теневое слово 0x8004e4 **[код]**

`0x8004e4` (`[gp,-0x44]`, `ld.as/st.as [gp,-0x11]`) — теневая копия селекторов. Перед чтением
ucode очищает полубайт, вписывает индекс, сохраняет копию и шлёт `0x1d000000 | копия`
(80 мест). Полубайты:

| биты селектора | группа | маска очистки | мест | пример |
|---|---|---|---|---|
| 3..0 | назначение не установлено | — | 0 | — |
| 7..4 | назначение не установлено; пишется только при инициализации (=2) | `bic 0xf0` | 1 | `bi_mode_init_substep`, `0x1d000020` |
| 11..8 | r41 | `0xfffff0ff` | 11 | `fsched__pick_ready_queue` 0x92bec6 |
| 15..12 | r40 (а также единичные чтения r37/r38/r54 сразу после) | `0xffff0fff` | 45 | `uc_read_bi_sync` 0x936b60 |
| 19..16 | r47 | `0xfff0ffff` | 22 | `brp__program_and_measure` 0x9238a6 |
| 23..20 | назначение не установлено; пишется только при инициализации (=2) | `0xff0fffff` | 1 | `bi_mode_init_substep`, `0x1d200000` |

Регистры r42, r43, r45, r49, r51, r53, r54 uc **никогда не выбирает**: в 6.2 нет ни одной
записи, после которой читался бы такой регистр. Все их чтения совпадают по смыслу с
регистром индекса 0 своей группы в паке (`EVENT1_STATUS_R42`, `MTP_QUERY_RESPONSE_1`,
`MTP_TX_PERMISSION_RESP`, `EVENT_ENGINE2_STATUS`, `MTP_DESCRIPTOR_SCRATCHPAD`, `BAP_IF_0`,
`EVENT4_STATUS`) — см. соответствующие разделы. Для r42 и r54 раскладка бит у индексов 0…2
одинакова, поэтому имена бит верны при любом индексе. Предположение: полубайты 7..4 и 23..20,
выставленные в 2 при инициализации, относятся к каким-то из этих групп, но к каким именно, не
установлено.

На стенде в простое наблюдаются селекторы `0x1d284320`, `0x1d230020`
([MAC-COMMANDS §7.3](MAC-COMMANDS.md#73-0x1d-и-0x4d--локальное-чтение-железо)), то есть полубайты
7..4 и 23..20 там всегда равны 2 **[железо]**.

### 2.4. Ожидания событий **[код]**

Почти все проверки r42/r54 идут через шесть помощников. Маска (r0, r1) берётся у вызывающего
места. Ниже по каждому помощнику — маски и места их вызова (по vendor-листингу; маски вычислены по
`mov/bset/asl` перед вызовом).

| помощник | адрес | условие выхода |
|---|---|---|
| `uc_spin_until_event(m)` | 0x9366dc | `r42 & m` |
| `uc_spin_until_event4(m)` | 0x9366d0 | `r54 & m` |
| `mac__wait_event_r42_or_r40(m42, m40)` | 0x93675c | `r42 & m42` или `r40 & m40` |
| `uc_wait_event_busy(m, t)` | 0x9366e8 | `r42 & m`; при `t≠0` шлёт `0x23010000\|t`, `0x02000200` и добавляет к маске бит 9 (`gp_timers_event`) — таймаут; возврат 1 = событие, 0 = таймаут |
| `uc_sleep_until_event(m, t)` | 0x93676c | то же, но пишет маску в `0x886d3c`, шлёт `0x21000002` и выполняет `sleep` |
| `uc_wait_event1_or_event4(m42, m54, t)` | 0x9367e4 | `r42 & m42` или `r54 & m54` |

| маска | биты (имена §2.8/§2.15) | помощник | места |
|---|---|---|---|
| r42 `0x8000` | 15 `tx_end_event` | spin | 20: `abft_responder__tx_ssw` 0x930b04, `bcon_txss_sweep_step` 0x93b604/0x93b832, `bi_rx__start_rx_window` 0x92127e, `direct_tx__send_from_desc` 0x938872, `direct_tx_step` 0x92c554, `brp_init__tx_request` 0x922cca, `tx_bcast_flow` 0x937a38, `txop_initiator_open_txop_flow` 0x93a598, `sls__send_ssw_ack` 0x93455e и др. |
| r42 `0x4000` | 14 `busy2_event` | spin | `mac_evt__enable_bit_sync` 0x9361f8, `_b` 0x936580, `tx_mtp_queue_gate` 0x939c24, `txop_initiator_open_txop_flow` 0x93a522, `brp_responder_flow_enter` 0x923088 |
| r42 `0x10000` | 16 `ppdu_report_event` | busy | 14: `rx__arm_window*`, `rx__ppdu_is_ack*`, `rx__ppdu_is_cts*`, `rx_flow__handle_frame` 0x931f34, `rx_flow_step` 0x931b3c, `rx_funcs__handle_ppdu_report` 0x9316ee, `tx__await_rx_or_timeout` 0x924caa, `abft_resp__parse_fdbk` 0x93062c |
| r42 `0x4002` | 1 `slot_event`, 14 | busy | `bti_worker__bti_transmitter_beacon_sweep_flow` 0x923e74, `mac__prepare_txrx_window` 0x920c60, `txss__program_tx_frame` 0x93c5c8, `mac__select_all_sectors_and_wait` 0x9368a4 |
| r42 `0x4800` | 11 `sfd_sync_event`, 14 | busy | `rx_flow__run` 0x931140 |
| r42 `0x1020` | 5 `bi2_event`, 12 `rx_frame_event` | busy | `bti__bi2_event_step` 0x936e94 |
| r42 `0x4100` | 8 `slot2_event`, 14 | busy | `sxd_hal__wait_slot2_busy2` 0x936d3c |
| r42 `0x80100` | 8, 19 `busy_event` | busy | `sxd_hal__wait_slot2_busy` 0x936db8 |
| r42 `0x4000`, t=0xa | 14 | sleep | `tx__send_and_await_rx_frame` 0x924a3a, 0x924b8a |
| r42 `0x1000` / r54 `0x40` | 12 / 6 `gp0_end_ind` | ev1\|ev4 | `itx__wait_ack*`, `itx__wait_cts*`, `tx__await_rx_or_timeout` 0x924c90 — ждать ответный кадр, таймаут — GP0 |
| r42 `0x1000` / r54 `0x80` | 12 / 7 `gp1_end_ind` | ev1\|ev4 | `abft_responder__respond_flow` 0x9304fc, `mac_mode_program_c` 0x92c144 |
| r42 `0x1080` / r54 `0x40` | 7 `txop_event`, 12 / 6 | ev1\|ev4 | `brp_init__exchange_request` 0x922954, `brp_initiator_brp_transaction_flow` 0x9225ce |
| r42 `0x4000` / r54 `0x40` | 14 / 6 | ev1\|ev4 | `mac__arm_events_0xc00` 0x93e0c0 |
| r42 `0x80000` / r54 `0x80`, `0x81`, `0xc1` | 19 / 7; 0+7; 0+6+7 (`txss_end_ind`) | ev1\|ev4 | `txss_init__send_fdbk_wait_ack` 0x93ba62, `txss_resp__wait_iss_end` 0x93bfca, `txss_init__wait_rss` 0x93bb72 |
| r42 `0x10000` / r40 `0x1000000` | 16 / r40 б24 `cca_ppdu_comp` | r42\|r40 | `rx_flow__run` 0x930fd4 |
| r54 `0x10000` | 16 `ext_gp_3_4_5_end_ind` | spin4 | `bcon_txss_sweep_step` 0x93b690 |
| r54 `0x140` | 6, 8 `gp2_end_ind` | spin4 | `mac_mode_kick` 0x92c05c |
| r54 `0x100` | 8 | spin4 | `uc_spin_until_event4_r0_100` 0x920b14 |

### 2.5. r36…r39 — отчёт о принятом PPDU **[пак+код]**

Single-mapped (селектор не нужен). Перед чтением uc ждёт `r42.ppdu_report_event` (б16, §2.4).
Ниже перечислены только биты, которые uc проверяет; полные раскладки — `6.2/ref/MSXD-LR-RGF.txt`.

**r36 = `PPDU_REPORT_1_R36`**

| бит(ы) | имя | смысл в uc | где (vendor) |
|---|---|---|---|
| 1, 2 | `qos_data_detected`, `mgmt_detected` | `and.f 0,r36,6`: кадр требует ответа | `rx_flow_step` 0x931cc8, `rx_get_required_response` 0x932ea4 |
| 1 | `qos_data_detected` | ветка QoS Data | `rx_get_required_response` 0x932f78, 0x93314c |
| 6 | `ss_detected` | принят SSW → разбор сектора | `sls__rx_ssw_frame` 0x928604, `rx_flow__handle_frame` 0x9324d4/0x9324fc, `rx_funcs__handle_ppdu_report` 0x93173c/0x9317e6 |
| 7 | `beacon_detected` | принят маяк | `rx_flow__handle_frame` 0x93206c/0x9324b8, `rx_funcs__handle_ppdu_report` 0x93172a |
| 8 | `imm_ack` | ожидаемый ACK пришёл (режим 1 в 0x8005f8) | `rx__dispatch_by_g_8005f8` 0x933438, `bi_rx__start_rx_window` 0x921302 |
| 9 | `back` | ожидаемый BlockAck пришёл (режим 2) | `rx__dispatch_by_g_8005f8` 0x9334fc, `rx_flow__handle_frame` 0x9326d4 |
| 18 | `back_request_frame_detected` | принят BAR → ответ BA | `rx_get_required_response` 0x932f2c |
| 19..23 | `data_frame_qid` | qid принятых данных | `rx_flow_step` 0x931cd8, `rx_get_required_response` 0x932f14 |
| 25 | `no_action_mgmt_detected` | BRP-кадр (Action No Ack) | `brp_init__exchange_request` 0x922966, `brp_initiator_brp_transaction_flow` 0x9225e4, `brp_responder_flow_enter` 0x922fe6, `rx_flow__handle_frame` 0x932072/0x932502, `rx_funcs__handle_ppdu_report` 0x931822 |

**r37 = `PPDU_REPORT_2_R37`**

| бит(ы) | имя | смысл в uc | где (vendor) |
|---|---|---|---|
| 0 | `rts` | принят RTS | `brp__is_peer_ctrl_frame` 0x9232fa, `rx_get_required_response` 0x9331d2, `rx_flow__handle_frame` 0x932488, `rx_funcs__handle_ppdu_report` 0x931754/0x93182e |
| 1 | `mmWaveCTS` | ожидаемый CTS пришёл (режим 4) | `rx__dispatch_by_g_8005f8` 0x93365a, `rx__ppdu_is_cts` 0x92e354, `_b` 0x92e3d8, `_c` 0x92e430 |
| 2 | `mmWaveDTS` | обновление NAV по DTS | `rx_nav_update` 0x93471a |
| 10 | `grant` | Grant | `brp__is_peer_ctrl_frame` 0x923300, `rx_get_required_response` 0x933304 |
| 16 | `mmWaveCF_END` | CF-End | `brp__is_peer_ctrl_frame` 0x9232f4, `rx_get_required_response` 0x933280, `tx__await_rx_or_timeout` 0x924cf4, `rx_flow__handle_frame` 0x932478 |
| 17 | `cfg1` | — | `rx_get_required_response` 0x9333c8 |
| 24 | `ss_bitmap` б0 | SSW | `sls__rx_ssw_frame` 0x92860a, `rx_funcs__handle_ppdu_report` 0x9317d6/0x9317ec/0x931916/0x931952, `rx_flow__run` 0x931248, `rx__arm_window_c` 0x92c5a4, BRP-потоки 0x922666/0x922998, `brp__is_peer_ctrl_frame` 0x923306 |
| 25 | `ss_bitmap` б1 | SSW-Feedback | `sls__rx_ssw_frame` 0x92869c, `abft_resp__parse_fdbk` 0x93066e, `rx_funcs__handle_ppdu_report` 0x9317fe/0x931a2e |
| 26 | `ss_bitmap` б2 | SSW-ACK | `sls__rx_ssw_frame` 0x9286f0, `rx_funcs__handle_ppdu_report` 0x931810/0x93187a |

Разбиение `ss_bitmap` на SSW / SSW-FB / SSW-ACK следует из веток `rx_funcs__handle_ppdu_report`
(флаги `0x8021e0` б0/б2/б3, см. [BF-ENGINE.md](BF-ENGINE.md)) **[код]**; в паке поле одно, 24..26.

**r38 = `PPDU_REPORT_3_R38`**

| бит(ы) | имя | смысл в uc | где (vendor) |
|---|---|---|---|
| 0 | `my_bssid_beacon_detected` | маяк своей BSS → свой BTI отменяется | `bti__bi2_event_step` 0x936ec4, `bti_worker_bi2_step` 0x923ae6, `rx_flow__handle_frame` 0x9320bc, `rx_flow__run` 0x931250 |
| 8..10 | `addr2_match_index` | индекс станции по TA | 8 мест: `rx_flow_step` 0x931c62, `rx_flow__handle_frame` 0x93208c/0x9324a4, `rx_funcs__handle_ppdu_report` 0x931720, `abft_resp__parse_fdbk` 0x93071c, `brp__is_peer_ctrl_frame` 0x9232da, `rx_meas__capture_frame` 0x92809c, `rx_capture__match_filter` 0x93e586, `mac_mode_program_c` 0x92c0d0 |
| 11 | `addr2_match_valid` | индекс действителен (иначе станция 8 = неизвестна) | те же места перед 8..10; `rx__capture_frame`: `r38.11 ? r38[10:8] : 8` |
| 11,13,14,28,29 | `addr2_match_valid`, `mcast_indication`, `bcast_indication`, `neighbour_indication`, `fcs_ok_partial` | `and r3,r38,0x30006800` — фильтр кадра | `rx_flow__handle_frame` 0x932506 |
| 11+15 | `addr2_match_valid` + `reverse_direction_detected` | `(r38 & 0x8800) == 0x8800` → `0x802298 \|= 8` | `rx_flow__handle_frame` 0x9327a8 |
| 12 | `bap_enable` | BA-интерфейс (дальше r53) | `rx__dispatch_by_g_8005f8` 0x933450/0x933514, `rx_flow__handle_frame` 0x9326e0 |
| 15 | `reverse_direction_detected` | RD: ответ не ждать / NAV | `rx__dispatch_by_g_8005f8` 0x933444/0x933508/0x93369e, `rx_flow_step` 0x931c4c, `rx_nav_update` 0x9345f2/0x9346be |
| 16..17 | `requested_ack_policy` | нужен ли ответ | `rx_flow_step` 0x931cce, `rx_get_required_response` 0x932eac |
| 20..24 | `received_mcs` | MCS принятого кадра | `rx_get_required_response` 0x933284, `rx_flow__handle_frame` 0x9326ac, `rx_capture__match_filter` 0x93e592, `rx__dispatch_by_g_8005f8` 0x933412 |
| 25 | `mpdu_aggregation` | A-MPDU | `rx_flow_step` 0x931cee, `rx_get_required_response` 0x932f20 |
| 26 | `pwr_mgmt_set` | PM-бит отправителя | `rx_get_required_response` 0x932fac/0x9330d0/0x9331a0 |
| 28 | `neighbour_indication` | обновить NAV по кадру соседа | `rx_flow_step` 0x931e00, `rx_flow__handle_frame` 0x9329b8 |
| 30 | `fcs_ok_full` | кадр целиком верен | `rx_flow__handle_frame` 0x93291e |

**r39 = `PPDU_REPORT_MISC_R39`**

| бит(ы) | имя | смысл в uc | где (vendor) |
|---|---|---|---|
| 8..13 | `type_index` | тип/подтип кадра | `rx_get_required_response` 0x932fd0, `rx_flow__handle_frame` 0x93251e/0x932922/0x9329e0 |
| 15 | `zero_cdown` | в SSW CDOWN = 0 (последний кадр развёртки) | `sls__rx_ssw_frame` 0x928668, `rx_flow__run` 0x931256, `rx_funcs__handle_ppdu_report` 0x9317dc/0x93198e |

Чтение r37 после селектора `0x1d00b000` (`rx_flow__handle_frame` 0x93246e) — это то же
single-mapped значение: полубайт 15..12 выбирает регистр группы R40 (`PHY_PLCP_RX_SIGNALS_R40`,
бит 15 `sifs_resp` проверяется у r40 в 0x932490), а на r37 не влияет **[код]**.

### 2.6. r40 — группа R40 **[пак+код]**

Индекс — полубайт 15..12 селектора. Таблица индексов и `BI_COUNTER` подробно —
[MAC-REGISTERS.md](MAC-REGISTERS.md#группа-r40-индекс--регистр). Здесь — биты по 6.2.

| сел. | регистр | бит(ы) | имя | смысл в uc | где (vendor) |
|---|---|---|---|---|---|
| 0x0 | `BACKOFF_IFS_STATUS` | 0..2 | `idle_detect` | состояние среды (5 — свободна для развёртки маяка) | 11 мест: `bti_worker__bti_transmitter_beacon_sweep_flow` 0x92413c, `rx_flow__run` 0x930e54/0x931042/0x931050, `rx_funcs__rx_flow` 0x93424e/0x9342a4, `mac__set_mode_0000` 0x93e104, `mac__rf_switch_cmd1f` 0x92c63c, `rx_resp__finish_restore_rx` 0x93371e/0x93374c (в трассу как `0xcac0xx`), `uc_sysassert__idle_hist` 0x9264e0 |
| 0x0 | | 16..19, 20..23, 24..27, 28..31 | `remaining_slot_ac1..ac4` | четыре полубайта; цикл до изменения (`brne r13,r40`) | `bi_tx__check_idle_and_start_uc` 0x93699c…0x9369d2, `mac__set_chain_modes` 0x936a0e…0x936a38 |
| 0x3 | `REMAINING_TIME_RD` | 0..15 | `dump___remaining_time` | остаток времени, `extw`; сравнивается с порогами (≤0x30 → `0x8005f8` б15) | `txop_initiator_open_txop_flow` 0x93a2bc, `mac__prepare_txrx_window` 0x920bcc, `internal_tx__flow_sm4` 0x926fd6, `tx__send_and_await_rx_frame` 0x924ab8, `tx_initiator_flow_fixed_scheduling` 0x938f68, `rx_flow__run` 0x93145c |
| 0x4 | `BI_COUNTER` | 0..25 | `bi_counter` | позиция в BI, мкс | `uc_bi_counter_in_window` 0x9374a6, `bti__bi2_event_step` 0x9372c6, `l1__snapshot_bi_counter` 0x923a42, `bi_timing_snapshot_b` 0x9223a8, `internal_tx_isr` 0x92bca0 |
| 0x4 | | 31 | `bi_sync` | BI синхронизирован | `uc_read_bi_sync` 0x936b8c |
| 0x5 / 0x6 | `TSF_LOW_R40` / `TSF_HIGH_R40` | 0..31 | — | 64-битный TSF | `uc_read_tsf64` |
| 0xa | `PHY_SIGNALS` | 0..2 | `cca` | — | `rx_flow__run` 0x9310d0, 0x931168 |
| 0xa | | 3 | `phy_rx_frame` | ждать окончания приёма (`while r40.3`); после — ассерт 147, если снова 1 | `mac__set_mode_a000` 0x92a7cc, 0x92a7f4, 0x92a8c8, 0x92a8fc |
| 0xa | | 8..13 | `ppdu_event_counter` | → `0x800578`; сравнение с прошлым значением | `mac__set_mode_a000` 0x92a854/0x92a95a, `rx_flow__run` 0x930f58/0x9311fc, `ucode_cmd_0x01_handler` 0x93aa20 |
| 0xa | | 16..21 | `cca_event_counter` | сравнение счётчиков CCA | `rx_flow__run` 0x930f5e/0x931098/0x931202, `ucode_cmd_0x01_handler` 0x93aa26 |
| 0xa | | 24 | `cca_ppdu_comp` | **канал свободен** (вместе с `!r42.busy2_event`) перед TX | 15 мест: `tx__cca_check_and_send` 0x924d44, `tx_bcast_flow` 0x937944, `txop__await_cts_ppdu` 0x9399e2, `txss__program_tx_frame` 0x93c5da, `internal_tx__flow_sm2/4/6`, `direct_tx__send_from_desc` 0x93874a, `bcon_txss_sweep_step` 0x93b4ea, `bi_rx__start_rx_window` 0x921174, `mac__set_mode_a000` 0x92a7b2 (ждать б24), `rx_flow__run` 0x930fc8 |
| 0xb | `PHY_PLCP_RX_SIGNALS_R40` | 15 | `sifs_resp` | кадр требует ответа через SIFS | `rx_flow__handle_frame` 0x932490 |
| 0xd | `BF_METRIC_R40` | 9..19 | см. §7.2 | 11-битная метрика со знаком (`lsr 9; bmsk 10; >0x3ff → −0x800`) | `bti__bi2_event_step` 0x936fa2/0x93702a, `bti_bi2__track_best_metric` 0x93dd16, `rx_flow__handle_frame` 0x932302, `rx_meas__capture_frame` 0x927fa8, `rx_meas__append_sample` 0x928890, `mac_mode_program_c` 0x92c196 |

Остальные регистры группы (1, 2, 7, 8, 9, 0xc, 0xe, 0xf) в uc 6.2 не выбираются.
`mac__wait_event_r42_or_r40` проверяет r40 произвольной маской (единственный вызов — `0x1000000`,
б24 при селекторе 0xa).

### 2.7. r41 — группа R41 (выбор очередей) **[пак+код]**

| сел. | регистр | бит(ы) | имя | смысл в uc | где (vendor) |
|---|---|---|---|---|---|
| 0x0 | `QUEUE_SEL_STATUS_R41` | 8..11 | `lowest_queue_set_found` | номер набора | `tx_slot__pick_queue` 0x939734 |
| 0x0 | | 16..20 | `qid_for_found_queue_set` (в паке 16..21) | qid | `tx_slot__pick_queue` 0x93973a |
| 0x1 | `QUEUE_SEL_FOUND_SET1_4_R41` | 24..28 | `qid_selected_qset4` (в паке 24..29) | qid набора 4 | `queue_sel__get_qset4` 0x92ea32 |
| 0x1 | | 31 | `qset4_valid` | возврат функции | `queue_sel__get_qset4` 0x92ea3a |
| 0x3 | `QSET_1_MASK_VECTOR` | 0..29 | (вектор) | есть ли ожидающие очереди, кроме 30/31 | `qset1_mask__any_pending_uc` 0x93c6ba |
| 0x3 | | 30 | (вектор) | очередь 30 ожидает | `bti__prepare_sweep_set` 0x935ce2; `background_bi_step` 0x93c73e (`bclr.f 0,r41,30` — «кроме 30») |
| 0xb | `MTP_Q_AVAIL` | 0..31 | `mtp_q_avail_vec` | OR с BAP_Q_AVAIL | `fsched__pick_ready_queue` 0x92bec6, `fsched__pick_queue_r41` 0x93983c, `rx_flow_substep_uc` 0x93db3e |
| 0xc | `BAP_Q_AVAIL` | 0..29 | `bap_q_avail_vec` | `asl.f 0,r41,2` | `bap_q_avail__check` 0x9302c0, `macq__is_idle` 0x926108 |

### 2.8. r42 — события (EVENT1_STATUS) **[пак+код]**

Селектор r42 uc не пишет (§2.3); раскладка `EVENT1/2/3_STATUS_R42` одинакова. Биты 0..23 —
события, 24..31 — резерв. Счётчик мест учитывает и прямые проверки, и маски помощников §2.4.

| бит | имя | смысл в uc | где (vendor) |
|---|---|---|---|
| 1 | `slot_event` | начало слота; ожидание развёртки маяка | маска `0x4002` (§2.4) |
| 4 | `bi1_event` | TBTT (путь DTI→BTI): L1 → `l1_task_dispatch(0,0)`, `++0x802ec0` | `l1_task__main_step` 0x92cba4/0x92cc86, цикл `while r42 & 0xc0010` 0x92cc38/0x92ccfc |
| 5 | `bi2_event` | событие BI2 для BTI | маска `0x1020` (`bti__bi2_event_step`) |
| 7 | `txop_event` | TXOP закончился/идёт | 10 мест: `bti_worker__bti_transmitter_beacon_sweep_flow` 0x923fce/0x923fd6/0x9241a4, `mac__prepare_txrx_window` 0x920bec, `tx__send_and_await_rx_frame` 0x924ac4, `tx_mtp_queue_gate` 0x939b1a, `rx_flow_step` 0x931c16/0x931dd4, `rx_funcs__rx_flow` 0x933e7c/0x933f80 |
| 8 | `slot2_event` | второй слот | `sxd_hal__wait_slot2_busy(2)` (маски `0x4100`, `0x80100`) |
| 9 | `gp_timers_event` | **таймаут ожидания** (GP-таймер из `0x23010000\|t`) | добавляется во все `uc_wait_event_busy/sleep` с `t≠0`; прямо: `rx__dispatch_by_g_8005f8` 0x933494…0x933566, `rx_flow__handle_frame` 0x932726 — `while (!r42.9 && !r53.0)`, при б9 ассерт 0x3b |
| 11 | `sfd_sync_event` | синхронизация SFD | маска `0x4800` (`rx_flow__run` 0x931140) |
| 12 | `rx_frame_event` | **принят кадр** (ответ ACK/CTS, BRP, SSW) | 13 прямых мест: `itx__wait_ack*`, `itx__wait_cts*`, `tx__await_rx_or_timeout` 0x924c98, BRP-потоки, `bti__bi2_event_step` 0x936e9e, `bti_bi2__track_best_metric` 0x93dcce, `abft_responder__respond_flow` 0x930508, `mac_mode_program_c` 0x92c158 |
| 14 | `busy2_event` | **среда занята / подтверждение команды**: перед TX — отказ, если взведён; после `0x27…+0x02004000` — ждать его | 26 прямых мест + маски: `tx__cca_check_and_send` 0x924d40, `tx_bcast_flow` 0x937940, `txop__await_cts_ppdu` 0x9399de, `tx_slot__dispatch` 0x938e52, `internal_tx__flow_sm2/4/6`, `bti_worker__…beacon_sweep_flow` 0x923e86/0x924158, `rx__program_mac_and_wait` 0x938d6c, `sxd_hal__wait_slot2_busy2` 0x936d46 и др. |
| 15 | `tx_end_event` | **передача закончена** | 20 мест `uc_spin_until_event(0x8000)` (§2.4) |
| 16 | `ppdu_report_event` | отчёт r36…r39 готов | `rx_flow_step` 0x931b34, `rx_flow__run` 0x93125c, `rx_flow__handle_frame` 0x931f20 + 14 мест `uc_wait_event_busy(0x10000)` |
| 18 | `backoff_event` | конец backoff → `bi_dispatch_by_role` (L1) | `l1_task__main_step` 0x92cbfa/0x92ccb6 |
| 19 | `busy_event` | L1: фаза автомата BI (`l1_task_phase_of(0x802f44)`); TXSS: неожиданный кадр | `l1_task__main_step` 0x92cb3c/0x92cc50, `background_bi_step` 0x93c74e, `txss_init__send_fdbk_wait_ack` 0x93ba6a, `txss_init__wait_rss` 0x93bb80, `sxd_hal__wait_slot2_busy` 0x936dc2 |
| 0..23 | все | `bmsk r?,r42,0x17` — снимок для лога L1 | `l1_task__main_step` 0x92cb06 |

Биты 0 (`sifs_event`), 2, 3, 6 (`tsf_event`), 10, 13 (`cca_event`), 17, 20…23 (`comb_event1..4`)
uc 6.2 не проверяет. Отсутствие ожидания `tsf_event` — см.
[BEACONING.md](BEACONING.md).

### 2.9. r43 — ответ MTP на запрос (MTP_QUERY_RESPONSE_1) **[пак+код]**

Порядок у всех 24 потоков TX одинаковый: команды `0x1b001111`, `0x16…`, `0x17…` (запрос MTP) →
`while (!r43.31)` → `r51` → `0x800608/0x80060c` → `while (!r45.31)`. Поля r43 полностью совпадают
с `MTP_QUERY_RESPONSE_1`:

| бит(ы) | имя | смысл в uc | где (vendor) |
|---|---|---|---|
| 31 | `valid` | **ответ MTP готов** (ожидание) | 34 места: `mac_q__tx_ppdu` 0x939972, `tx__submit_frame` 0x9396b4, `tx_bcast_flow` 0x9378b0…, `txop_initiator_open_txop_flow` 0x93a2f8/0x93a35a, `mtp_queue__release_mgmt` 0x93eac2, `ucode_cmd_0x08_handler` 0x93af92…, `rx_flow__handle_frame` 0x932a94…, `abft_responder__tx_ssw` 0x930bbe и др. |
| 27 | `aggregation_enabled` | ответ будет BlockAck → `0x8005f8 \|= 2`, иначе ACK → `\|= 1`; в `ucode_cmd_0x08` — поставить бит qid в `0x802948` | `txop_initiator_open_txop_flow` 0x93a4fe, `tx_mtp_queue_gate` 0x939c00, `rx__program_mac_and_wait` 0x938d50, `ucode_cmd_0x08_handler` 0x93afae/0x93b002, `rx_funcs__rx_flow` 0x933db4 |
| 26 | `reverse_direction_supported` | при `ack_policy≠0` без RD — без команды `0x20000400` | `txop_initiator_open_txop_flow` 0x93a464, `mtp__get_tx_permission` 0x93e8ee, `txop__await_cts_ppdu` 0x939a26 |
| 16..20 | `mcs` | MCS → `0x3e000000 \| mcs<<4`, в контекст | 8 мест: `rx__program_mac_and_wait` 0x938c6a, `rx_flow__handle_frame` 0x932aac/0x932baa/0x932c94, `rx_flow__run` 0x9315ce, `tx_bcast_flow` 0x937ab0, `fsched_ap__poll_station` 0x93d274, `mtp_queue__release_mgmt` 0x93ead6 |
| 14..15 | `ack_policy` | 0 → ждать ответ (ACK/BA); 1 → `ctx[0xc] \|= 0xe`; 2, 3 → ничего | `txop_initiator_open_txop_flow` 0x93a458/0x93a4da, `tx_mtp_queue_gate` 0x939bdc, `rx__program_mac_and_wait` 0x938d34 |
| 8..11 | `dest_id` | индекс станции (≥8 → ассерт 8) | `mtp_queue__release_mgmt` 0x93eb6c |
| 4..7 | `packet_mode` | → `ctx[0x28]` | `mtp_queue__release_mgmt` 0x93eba6 |

### 2.10. r45 — разрешение MTP на передачу (MTP_TX_PERMISSION_RESP) **[пак+код]**

| бит(ы) | имя | смысл в uc | где (vendor) |
|---|---|---|---|
| 31 | `valid` | **ответ готов** (ожидание после запроса и после `0x19…`/`0x29000002`) | 52 места, самое частое ожидание uc: `tx_bcast_flow`, `txop_initiator_open_txop_flow`, `internal_tx__flow_sm2/4/6`, `direct_tx_step` 0x92c480, `txss__program_tx_frame` 0x93c46e, `bcon_txss_sweep_step` 0x93b4fe…, `brp_init__tx_request` 0x922c8c, `rx_flow__handle_frame` 0x932b2c… |
| 0..7 | `dump___null_status` | `extb r45 & ctx[0x18]` = 0 → разрешено (возврат 1) | `mtp__get_tx_permission` 0x93e8fc, `tx__submit_frame` 0x9396e4, `cf_end__send_frame` 0x9385c4, `mtp_queue__release_mgmt` 0x93eb02, `txop_initiator_open_txop_flow` 0x93a2d4/0x93a382 |
| 1 | бит `null_status` (имя в паке не задано) | **очередь MTP пуста**: при 1 — лог «Error: MTP Queue is empty» (`0x10006a4`) и выход | `mtp_queue__release_mgmt` 0x93eaf8; `macq__probe_empty` 0x92db0a возвращает `!r45.1` (см. §7.1) |
| 5 | бит `null_status` | при 1 и непустом `0x802229[3·sta]` → `ctx[0xc] \|= 2`, `ctx[0x20] = 0` | `txop_initiator_open_txop_flow` 0x93a4b8, `tx_mtp_queue_gate` 0x939bba, `rx__program_mac_and_wait` 0x938d18 |

Назначение бит 1 и 5 внутри `null_status` по паку не установлено; приведено по коду. Поля
`max_retry` (8..15), `retry_val` (16..23), `mng_data` (24), `bcq_ucq` (25) uc не читает.

### 2.11. r47 — группа R47 **[пак+код]**

Индекс — полубайт 19..16.

| сел. | регистр | бит(ы) | имя | смысл в uc | где (vendor) |
|---|---|---|---|---|---|
| 0x0 | `DIRECT_TX_CMD_STATUS` | 0 | `cmd_ready` | ждать готовности direct TX | `uc_wait_direct_tx_ready` 0x9258a2 |
| 0x0 | | 8..15 | `available_space` | `(r47>>8) & 0xfc` — свободно в FIFO (кратно 4) | `tx_fifo__push_frame_3ies` 0x93845e…0x9384bc |
| 0x1 | `COUNTER_EVENT_STATUS` | 0 | `counter_interface_busy` | ждать снятия перед запуском PPDU | `mac_q__tx_ppdu` 0x93992e, `_3009` 0x9217e4, `_cmd08` 0x93a762, `tx_bcast_flow` 0x937c08, `ucode_cmd_0x08_handler` 0x93af4e, `ucode_cmd_0x0b_handler` 0x937e68/0x937f5c, `vring__disconnect_flush` 0x925ee0 |
| 0x2 | `LFSR_VAL` | 0..31 | `dump___value` | ГПСЧ: `(r47·0xbd)>>32 + 0xa` (случайная задержка маяка) | `bti_worker__bti_transmitter_beacon_sweep_flow` 0x923d1e, `abft_responder__respond_flow` 0x9303f4/0x9305c2 |
| 0x3 | `RFC_SWITCH_ERROR_STATUS` | 17 | `rfc_access_busy` | ждать снятия перед командой RFC | 11 мест: `rfc__issue_cmd_10` 0x92f8a6, `rfc__issue_cmd_20_uc` 0x92f90a, `rf__select_sector_cmd41` 0x92f978/0x92f9c8, `rf__write_sector_awv` 0x92fadc/0x92fb30, `brp__write_reg_pair` 0x92fa42, `config_brp_rf` 0x92557e/0x925686, `rfca__select_rf_uc` 0x928bd4, `brp__program_and_measure` 0x9238a8 |
| 0x4 | `RFC_SWITCH2TX_STATUS` | 4..6 | из `analog_rx_off_status` (4..7) | `bic.f r12,r47,~0x70`: 0 → ассерт 0x133b | `direct_tx__send_from_desc` 0x93880c |
| 0x5 | `RFC_SWITCH2RX_STATUS` | 0..3, 4..7, 12..15 | `analog_tx_off_status`, `analog_rx_on_status`, `rx_awv_cfg_status` | проверка статусов переключения на RX | `mac_mode_program_c` 0x92c32c/0x92c332/0x92c33c |
| 0x8 | `MTP_AGGREGATION` | 31 | `valid` | ждать | `bti__measure_frame_duration` 0x937d6e, `tx_bcast_flow` 0x937906 |
| 0x8 | | 0..15 | `dump___aggregation_duration` | длительность, `extw` | `bti__measure_frame_duration` 0x937d74, `tx_bcast_flow` 0x93790a |

### 2.12. r49 — EVENT_ENGINE2_STATUS (события PHY BRP) **[пак+код]**

| бит(ы) | имя | смысл в uc | где (vendor) |
|---|---|---|---|
| 5 | `phy_rx_brp_done` | конец приёма BRP | `brp__program_and_measure` 0x92373e |
| 13 | `phy_rx_brp_stage_on_air` | идёт BRP-стадия; выход из ожидания `while (!r42.14 && !r49.13)` | `brp__program_and_measure` 0x923690, `rx_flow__measure_snr_select_best` 0x92d752, `rx_flow__run` 0x9311f0 |
| 16..19 | часть `phy_mac_status_2_11` (14..23) | состояние PHY: <6 — можно переключать режим; 6..0xd — ждать | `mac__set_mode_a000` 0x92a796 (`asr 16; bmsk 3; cmp 6`), 0x92a890 |
| 0..31 | — | снимок в `0x80049c` | `mac__set_mode_a000` |

### 2.13. r51 — MTP_DESCRIPTOR_SCRATCHPAD **[пак: имя регистра; поля — код]**

Читается ровно в 34 местах, всегда сразу после `r43.valid`, и раскладывается на два слова
DCCM:

| бит(ы) | куда | дальнейшее использование | где (vendor) |
|---|---|---|---|
| 0..3 | `0x800608` (`[gp,0x38]`) | бит 1 → бит 6 команды `0x19000b00` / `0x19800830` | все места §2.9; потребитель — `txop_initiator_open_txop_flow`, `tx_mtp_queue_gate`, `abft_responder__tx_ssw` |
| 4..31 | `0x80060c` (`[gp,0x39]`) | `<< 14` в ту же команду 0x19 | там же |

Назначение полей не установлено: в паке у регистра одно поле `dump___desc_sceatchpad`.
Предположение: это поля дескриптора из очереди MTP (бит 1 младшего полубайта управляет битом 6
команды передачи 0x19).

### 2.14. r53 — BAP_IF_0 (интерфейс Block Ack) **[пак+код]**

| бит(ы) | имя | смысл в uc | где (vendor) |
|---|---|---|---|
| 0 | `bap_tx_update_ind` | конец ожидания `while (!r42.gp_timers_event && !r53.0)`; затем команда `0x1c000001` | `rx__dispatch_by_g_8005f8` 0x933460…0x933560, `rx_flow__handle_frame` 0x9326f0/0x93272c |
| 2 | `bap_rel_done_ind` | ждать снятия перед запуском PPDU из очереди | `mac_q__tx_ppdu` 0x9398fe, `_3009` 0x9217b4, `_cmd08` 0x93a732, `tx_bcast_flow` 0x937bd8, `ucode_cmd_0x08_handler` 0x93af1e, `ucode_cmd_0x0b_handler` 0x937e38/0x937f2c, `vring__disconnect_flush` 0x925eb0 |
| 3 | `bap_rx_update_ind` | — | `rx_get_required_response` 0x933006 |
| 4 | `bap_tx_up_status` | `0x800460 = r53 & 0x10`; при ненуле BA не учитывается | `rx__dispatch_by_g_8005f8` 0x9334a8/0x93356c, `rx_flow__handle_frame` 0x93273c |
| 5 | `bap_rx_up_status` | — | `rx_get_required_response` 0x93301a |
| 8..14 | `num_of_tx_pkts` | `0x802210 +=` | `rx__dispatch_by_g_8005f8` 0x933594, `rx_flow__handle_frame` 0x932758 |
| 16..22 | `num_of_non_acked_pkts` | `0x802214 +=`; оба → `bap_q_avail__check` | `rx__dispatch_by_g_8005f8` 0x93359c, `rx_flow__handle_frame` 0x932760 |

### 2.15. r54 — события EVENT4_STATUS **[пак+код]**

Квитирование — MAC-команда 0x49 ([MAC-COMMANDS §7.6](MAC-COMMANDS.md#76-gp-таймеры-и-r54-0x49-0x4f0x54-0x670x68)).

| бит | имя | смысл в uc | где (vendor) |
|---|---|---|---|
| 0 | `txss_end_ind` | развёртка TXSS окончена | `txss_init__wait_rss` 0x93bb7a/0x93bbd0, `txss_resp__wait_iss_end` 0x93bf34/0x93bfd2, маски `0x81`/`0xc1` |
| 1 | `rxss_bf_metric_ind` | метрика RXSS готова | `brp__program_and_measure` 0x923738/0x923744 |
| 4 | `service_period_0_ind` | вход DTI-аллокации (ESE) | `l1__on_event4` 0x92cd46 |
| 6 | `gp0_end_ind` | **таймаут GP0** (ответ не пришёл) | 14 мест + маски `0x40`: `itx__wait_ack*`, `itx__wait_cts*`, `tx__await_rx_or_timeout` 0x924c9e, BRP-потоки 0x92267c/0x9229a4, `txss_resp__wait_fdbk` 0x93bef8, `txss_init__wait_rss` 0x93bbb2, `bti_bi2__track_best_metric` 0x93dec8, `bti__r54_event_bit6` 0x92bf2c, `mac_mode_kick` 0x92c068, `mac__arm_events_0xc00` 0x93e0ce |
| 7 | `gp1_end_ind` | таймаут GP1 (глобальный) | `abft_responder__respond_flow` 0x930574, `bti__arm_period_gp0` 0x9307f2, `mac_mode_program_c` 0x92c150, `txss_init__send_fdbk_wait_ack` 0x93ba70, `txss_init__wait_rss` 0x93bbbe, `txss_resp__wait_iss_end` 0x93bf3e/0x93bfd8 |
| 8 | `gp2_end_ind` | конец GP2 | `bti_bi2__gp2_end_flag` 0x923ca8, `bti_bi2__track_best_metric` 0x93ded0, маски `0x100`, `0x140` |
| 15 | `ext_gp_0_1_2_end_ind` | переход AW→DTI | `l1__on_event4` 0x92cd24, `l1_fixed_sched__event_entry` 0x92cd96 |
| 16 | `ext_gp_3_4_5_end_ind` | — | маска `0x10000` (`bcon_txss_sweep_step` 0x93b690) |
| 17 | `ext_gp_6_7_8_9_end_ind` | — | `l1__on_event4` 0x92cd68, `l1_fixed_sched__event_entry` 0x92cdb0 |

`abft_responder__respond_flow` дополнительно проверяет r54 переменной маской (`tst r54,r15`,
0x930474) и сохраняет весь r54 (0x9303a0).

### 2.16. r55 — группа R55 (команда 0x4d) **[пак+код]**

Селектор — младшие биты команды `0x4d0000NN` **[железо]**
([MAC-COMMANDS §7.3](MAC-COMMANDS.md#73-0x1d-и-0x4d--локальное-чтение-железо)).

| команда | регистр | бит(ы) | смысл в uc | где (vendor) |
|---|---|---|---|---|
| `0x4d000000` | `SIFS_CNT` | 0..7 такты, 8..15 `usec` | пороги 0x120/0x160/0x500/0x700; `0x886d10` пересчитывается из него | `rx_flow__run` 0x930e88/0x930f22, `abft_responder__tx_ssw` 0x93095a, `rx_flow_step` 0x931e66 |
| `0x4d000005` | `G2_TSF_LOW` | 0..31 | младшие 32 бита TSF | `uc_read_tsf_lo` 0x9364e2 |
| `0x4d00000a` | `GP_CLK2_TIMER` | 0..23 `val` | сравнение с `[0x80167c]`; вычитание в `bti__arm_period_gp0` | `abft__arm_response_window` 0x930602, `bti__arm_period_gp0` 0x930838 |

`SIFS_CNT` — бегущий счётчик **[железо, 2026-10-16]**: в `rx_frame_tx_resp_seq` (наш быстрый путь
ответа ACK/BA, ~1,5 млн ответов под iperf) значение растёт между двумя чтениями (+~140 тактов за
запрос в MTP и команды 0x3e/0x37/0x02/0x19), после конца передачи ответа (r45.31) читается 0 —
передача его сбрасывает; один раз 0 и перед запросом (счётчик не шёл). Сравнение vendor ведёт по
сырому коду `usec<<8 | такты` (такты < 165, код монотонен). Перед запросом в MTP — 650..1005 тактов
(3,9..6,1 мкс), т. е. больше SIFS 3 мкс, и ни одного сбоя: срок ответа ACK/BA отсчитывается не от
нуля `SIFS_CNT`, абсолютный порог по нему опоздание на этом пути не ловит. Порог как защита есть у
vendor в `abft_responder__tx_ssw` 0x93095a: `SIFS_CNT ≥ 0x160` или `= 0` → SSW не передаётся
(возврат 0). `REMAINING_TIME_RD` (R40[3]) — остаток времени сессии/SP с флагами
`less_than_min_session_0..7`, к сроку ответа не относится.

В `mac_mode_program_c` 0x92c25a, `rx__switch_to_rx_mode` 0x924fe2 и `rx_nav__set_from_duration`
0x92dd7c r55 читается после вычисленной команды; какой регистр выбран, не установлено (у последнего
используется `(r55>>8)&0xff`, как `SIFS_CNT.usec`).

### 2.17. r29/r30 (ilink1/ilink2)

Регистры ядра, не расширение: `l2_handle_watchdog` печатает их значения строкой
«*** l2_handle_watchdog ilink1:%08x ilink2:%08x»; `uc_sleep_until_event` сохраняет ilink2
в `0x800488` (`[gp,-0x28]`) перед `sleep` **[код]**.

---

## 3. AUX-регистры ядра

uc обращается к AUX только через `lr`/`sr` и к STATUS32 через `flag` (`sr` в STATUS32 не
пишет нигде).

| AUX | имя | биты | как используется | где (vendor) | метка |
|---|---|---|---|---|---|
| 0xa | STATUS32 | 1 `E1` | критическая секция: `lr [0xa]; bclr 1; flag` … `bic x,x,-3; or; flag` (60 мест `lr [0xa]`, 58 `flag rX`) | `bf_pending__set_bit` 0x921700, `list__push_locked`, `evt_queue__take_locked`, `uc__set_evt_id_5c` и др. | [ISA]+[код] |
| 0xa | | 2 `E2` | не трогается в секциях — прерывания 2-го уровня остаются разрешены; включаются вместе с E1 перед `sleep` (`or 0x6; flag`) | `background_task__dispatch` 0x9216e2; `cpu__aux28_set_bits12` 0x9202f4 (три входа: E1\|E2, E1, E2) | [ISA]+[код] |
| 0xa | | 0 `H` | `flag 1` — останов ядра | `uc_sysassert`, `uc_vector_00` (после выхода из main), проверка ядра 0x93e2c0 | [ISA]+[код] |
| 0xa | | все | `flag 0` на входе сброса (E1/E2 = 0) | `uc_vector_00` 0x920160 | [ISA]+[код] |
| 0x2 / 0x3 | LP_START / LP_END | 0..31 | сохраняются/восстанавливаются в ISR вместе с `lp_count` | `uc_isr_l1_task2` 0x92069a…0x9206b8, `uc_isr_l2_task2`, `uc_isr_l2_task3` | [ISA]+[код] |
| 0x12 | MULHI | 0..31 | восстановление `mhi` в ISR (`mulu64 r12,1` → mlo; `sr r12,[0x12]`) | `uc_isr_l1_task2` 0x9206f4 и др. | [ISA]+[код] |
| 0x21 / 0x22 / 0x23 | COUNT0 / CONTROL0 / LIMIT0 | — | таблица таймера 0: `0x800738 = {0x21, 0x22, 0x23, режим}` (значения в `uc_data`) | `uc_timer__start` 0x937354 | [ISA]+[код] |
| 0x100 / 0x101 / 0x102 | COUNT1 / CONTROL1 / LIMIT1 | — | таблица таймера 1: `0x800748 = {0x100, 0x101, 0x102, режим}` | там же | [ISA]+[код] |
| CONTROLn | | 0 `IE`, 1 `NH`, 2 `W` | режим `uc_timer__start(a, count, limit, d)`: d=0 → 2 (NH), d=3 → 4 (W, сторожевой), иначе 3 (IE\|NH) + уровень IRQ `3+4·a` (d==2 → уровень 2) | `uc_timer__start` | [ISA]+[код] |
| COUNT1 | | 0..23 | **метка времени трассы**: `lr [[0x800748]] & 0xffffff` → MAC-команда с кодом 0 (в кольцо r25) | `l1_task__main_step` 0x92cb1c, `mac_mode__switch_sequence` 0x9273e2, `macq__flush_queue` 0x925bca, `rx_resp__finish_restore_rx` 0x93373c/0x93376c, `txss_init__flow` 0x93bcb4 | [код] |
| COUNT1/CONTROL1 | | — | сторожевой таймер L2: `sr [0x800754] → CONTROL1`, `sr 0 → COUNT1` | `l2_handle_watchdog` 0x92cfea/0x92cff0; для таймера 0 то же в `l1_task__entry` | [код] |
| 0x200 | AUX_IRQ_LEV | бит n = уровень IRQ n | `uc_irq_set_level(n, l)`: `bclr` + `or l<<n`; IRQ 6 → 2-й уровень (`irq__init_event_masks`), 0xa и 0xe (`bi_mode_init_substep`), 3/7 (таймеры) | `uc_irq_set_level` 0x921018 | [ISA]+[код] |
| 0x5 | DEBUG | 3..10 `ASR` | `(lr [0x5] >> 3) & 0xff` — какие точки останова сработали | `uc_ap__read_triggered_mask` 0x920f9c (из `uc_vector_02`) | [ISA]+[код] |
| 0x5 | | 24 | `sr 0x1000000,[0x5]` при программировании точки останова; назначение не установлено | `arc__program_action_point` 0x920f20 | [код] |
| 0x220+2n / 0x221+2n | AP_AMV / AP_AMM | — | значение/маска точки останова n (адрес `0x220 + 2·n`) | `arc__program_action_point` 0x920f62/0x920f72, `uc_ap__read_match_value` 0x920fa8 | [ISA]+[код] |
| 0x7b | MULTIPLY_BUILD | 0..7 версия | при сбросе: если `[0x80072c] ≠ 1` и версия не 1 и не 4 — `flag 1` | 0x93e2c0 (вызов `jl` из `uc_vector_00`) | [ISA]+[код] |
| 0x7d | NORM_BUILD | 0..7 версия | там же: версия 0 → `flag 1` | 0x93e308 | [ISA]+[код] |

Предположение: 0x93e2c0 — самопроверка конфигурации ядра (умножитель и `norm` обязательны).
Номера AUX 0x7b/0x7d взяты из списка BCR ARC600, по паку не проверены.

---

## 4. Управляющие слова DCCM

### 4.1. 0x8005f4 — txrx_state, слово 1 (контекст потока) **[код]**

`[gp,0xcc]` / `[gp,0x33]`. Имя «txrx_state» — из строки `l2_handle_watchdog`
«phy_fa_rate:%u txrx_state:%08x-%08x», которая печатает пару `0x8005f4`-`0x8005f8`. Слово
целиком пишется константой в начале потока и обнуляется в конце. Полуслова уходят в трассу
маркерами `0xdb…`/`0xdc…`/`0xcb…` (`fixed_sched__run_tx_slot`, `bi_rx__start_rx_window`).

| бит | значение | кто ставит (vendor) | кто проверяет и зачем |
|---|---|---|---|
| 1 (0x2) | передача данных/TXOP | `txop_initiator_open_txop_flow` (=2), `tx_bcast_flow` (=2), `bi_rx__start_rx_window` (=0x2002) | 12 мест: `rx_flow__run` 0x931424/0x931544, `rx__program_mac_and_wait` 0x938bee, `mtp__get_tx_permission` 0x93e9c0…, `rx_nav_update` 0x9345ea, `rx_resp__finish_restore_rx` 0x933850 (`!б1 \|\| (f8 & 0x11f) ≠ 0x100` → вернуть RF-цепь), `mac__prepare_txrx_window` 0x920b76 |
| 2 (0x4) | приём (`rx_funcs__rx_flow`) | `rx_funcs__rx_flow` (=4) | `rx_flow__handle_frame` (`!б2` → `0x8005f8 \|= б25`) |
| 3 (0x8) | приём (`rx_funcs__rx_flow`) | `rx_funcs__rx_flow` (=8) | `rx_get_required_response` 0x933200, `sls__rx_ssw_frame` 0x928532, `rx_flow__handle_frame` 0x932178 |
| 4 (0x10) | развёртка маяка (BTI) | `bti_worker__bti_transmitter_beacon_sweep_flow` (=0x10) | 14 мест: при б4 команда передачи `0x18000000`, иначе `0x18001000` (`txss__program_tx_frame`, `sls__send_ssw_ack`, `abft_responder__tx_ssw`, `bcon_txss_sweep_step`, `direct_tx_step`, `txss_init__send_ssw_fdbk`) |
| 5 (0x20) | TXSS-инициатор | `txss_init__flow` (=0x20) | `rx_funcs__handle_ppdu_report` 0x931976 (сектор с битом direction=1); группа `& 0x7e0` в `rx_flow__run` 0x931410 |
| 6 (0x40) | TXSS-ответчик | `txss_resp__flow` (=0x40) | `rx_funcs__handle_ppdu_report` 0x93196c (direction=0) |
| 7..9 | назначение не установлено | писатель в 6.2 не найден | только группа `& 0x7e0` (0x931410) |
| 10 (0x400) | назначение не установлено | писатель в 6.2 не найден | `rx_funcs__handle_ppdu_report` 0x93175a, группа `& 0x7e0` |
| 13 (0x2000) | окно приёма BI (с б1) | `bi_rx__start_rx_window` 0x9210b0 | — |
| 14 (0x4000) | internal TX | `internal_tx__flow_sm4` (=0x4000) | — |

`& 0x7e0` (биты 5..10) в `rx_flow__run` 0x931410 означает «поток BF» и ведёт в
`rx_funcs__handle_ppdu_report`; иначе при б1 — ветка данных. В 4.1 то же слово лежит по адресу
`0x800604` (те же значения 0x8/0x4/0x10/0x20/0x40/0x2/0x2002 по разбору микрокода 4.1);
соответствие адресов — вывод по совпадению значений.

### 4.2. 0x8005f8 — txrx_state, слово 2 (ожидаемый ответ и фаза) **[код]**

`[gp,0xd0]` / `[gp,0x34]`. Младшие 5 бит задают режим ожидания ответа, бит 8 — «ответ ещё не
получен», старшие биты — фазы BF-потоков. При срабатывании сторожевого таймера L2
`l2_task__report_error_bits` 0x92cdd8 ищет первый установленный бит из списка и вызывает ассерт
`0x60NN` (NN — номер бита десятичными цифрами); если ни одного нет — ассерт 0x26.

**Режим ответа (биты 0..4, `bmsk 4`)** — `rx__dispatch_by_g_8005f8` 0x9333fc, при б8 = 1:

| значение | ставит | ожидаемый кадр | проверка | ассерт L2 |
|---|---|---|---|---|
| 1 (б0) | `txop_initiator_open_txop_flow`, `tx_mtp_queue_gate`, `rx__program_mac_and_wait`: `r43.ack_policy = 0` и `!r43.aggregation_enabled` | ACK | `r36.imm_ack` (б8), `!r38.reverse_direction_detected`; при `r38.bap_enable` — ждать `r53.bap_tx_update_ind` | 0x6000 |
| 2 (б1) | те же, при `r43.aggregation_enabled` | BlockAck | `r36.back` (б9), `!r38.15`, `r38.12`; счётчики из r53 → 0x802210/0x802214; при б30 — снять бит qid в `0x802948` и б30 | 0x6001 |
| 4 (б2) | `txop_initiator_open_txop_flow` 0x93a340 (бит qid в `0x802948` установлен → RTS) | CTS | `r37.mmWaveCTS` (б1); `++0x802450[sta]`, команда `0x20000400` | 0x6002 |
| 8 (б3) | `rx_nav_update` 0x934590: после ACK при `0x8005f4.б1` и `r38.reverse_direction_detected` | кадр партнёра в режиме RD | `!r38.15` и станция кадра = `[0x8029f0]` | 0x6003 |
| 16 (б4) | писатель в 6.2 не найден | назначение не установлено | как 8 (плюс лишнее чтение r36); в `rx_nav_update` при `!r36.б1` → б7 | — |

Режим 0 означает «ответа не ждём»: `tx_sta__wait_slot_and_tx` 0x93a5fc при нуле снимает б17 и
выходит.

**Остальные биты:**

| бит | ставит / снимает | смысл (по коду) | проверяет (vendor) | ассерт L2 |
|---|---|---|---|---|
| 6 | `rx_flow_step`: `r38.addr2_match_valid` и станция ≠ текущей | кадр от чужой станции во время ожидания | `rx__handle_status_flags` (`& 0x140`) | — |
| 7 | `mac__prepare_txrx_window`, `rx_funcs__rx_flow` 0x933f80 (после таймаута в режиме BA), `rx_nav_update` (обнуляя 0..4); снимают `rx__handle_status_flags`, `tx_sta__flow_loop` | ответа нет — нужна повторная попытка | `tx_sta__wait_slot_and_tx` 0x93a620, `rx__handle_status_flags` | 0x6007 |
| 8 | `txop_initiator_open_txop_flow` (ставит после TX, вместе с `0x8005f4 = 2`); снимают `mac__prepare_txrx_window` (при `r42.busy2`), `tx_sta__*`, `rx__handle_status_flags` | **ответ ожидается** | `rx__dispatch_by_g_8005f8` 0x933406 (без б8 — 0), `(f8 & 0x11f) == 0x100`, `(f8 & 0x140) == 0x100` | — |
| 9 | `mtp__get_tx_permission`, `tx__cca_check_and_send`, `rx_flow__handle_frame` | передача не разрешена / отказ CCA | `rx__program_mac_and_wait` 0x938cd2 (при б9 — выход 1), `fixed_sched__run_tx_slot` 0x937762 (без б9 — команда `0x14000100`), `tx_non_data_flow_fixed_scheduling` 0x939670, `rx_funcs__rx_flow` 0x934078 | 0x6009 |
| 10 | `rx_flow_step`, `rx_flow__handle_frame`, `sls__rx_ssw_frame`, `mac__prepare_txrx_window` | кадр принят/обработан в окне | `rx_funcs__rx_flow` 0x933c9c (маска), `rx__handle_status_flags` (`& 0xe00` → снять б8) | 0x6010 |
| 11 (0x800) | `tx_bcast_flow`, `tx_slot__dispatch`, `tx_mtp_queue_gate`, `txop_initiator_open_txop_flow` и др. — константа 0x800 | поток TX начат / отказ (`=0x800` при неудаче CTS, `++0x8022cc`) | `rx__handle_status_flags` (`& 0xe00`) | 0x6011 |
| 12 | `rx_get_required_response` | нужен ответ на принятый кадр | `rx__check_g8005f8_bit24` (→ 2), `rx_flow__run` 0x931478, `rx_funcs__rx_flow` 0x933a70/0x933ca8 | — |
| 13 | `txop_initiator_open_txop_flow` (L_93a420) | TXOP не открыт (`++0x8022e4`) | — | 0x6013 |
| 15 | `txop_initiator_open_txop_flow` 0x93a440 | мало времени: `REMAINING_TIME_RD ≤ 0x30` (`++0x8022e8`) | — | 0x6015 |
| 16 | `rx_funcs__rx_flow` 0x933c9c/0x933f7c: истёк срок ожидания (`TSF − [0x80053c] > [0x800518]` или счётчик `0x8004b0` ≥ 0x1f) | **таймаут ожидания ответа** | `rx_funcs__rx_flow` 0x933c9c (маска) | 0x6016 |
| 17 | писатель не найден; снимает `tx_sta__wait_slot_and_tx` | назначение не установлено | `tx_mtp_queue_gate` 0x939b9a (`& 0x20004`) | 0x6017 |
| 18 | писатель не найден; назначение не установлено | без б18 — `mac__select_rf_module_cmd31(1, sta)` | `rx__program_mac_and_wait` 0x938d5e, `tx_mtp_queue_gate` 0x939c0e, `txop_initiator_open_txop_flow` 0x93a50c | 0x6018 |
| 19 (0x80000) | `txss_init__flow`, `txss_resp__wait_iss_end` | фаза TXSS | `rx_funcs__handle_ppdu_report` (`switch`: ничего не делать) | 0x6019 |
| 20 (0x100000) | назначение не установлено | фаза: обновить `0x886d00` по `0x802968+0xc` и как 0x200000 | `rx_funcs__handle_ppdu_report` | 0x6020 |
| 21 (0x200000) | `txss_init__flow`, `txss_resp__flow` | фаза TXSS: SSW по `r37.ss_bitmap.0` с проверкой direction через `0x8005f4` б5/б6 | `rx_funcs__handle_ppdu_report` 0x9317d0 | 0x6021 |
| 22 (0x400000) | `txss_init__send_fdbk_wait_ack` | ждать SSW-ACK (`r37` б26) | `rx_funcs__handle_ppdu_report` | 0x6022 |
| 23 (0x800000) | `txss_resp__wait_fdbk` | ждать SSW-Feedback (`r37` б25) | `rx_funcs__handle_ppdu_report` | 0x6023 |
| 24 | `rx_flow__handle_frame` | итог приёма → `rx__check_g8005f8_bit24` = 0 | `rx__check_g8005f8_bit24` 0x932de8, `rx_flow__run` 0x931478 | — |
| 25 | `rx_flow__handle_frame` (при `!0x8005f4.б2`) | итог приёма → 1 | там же | — |
| 26..29 (0x4000000…0x20000000) | писатель в 6.2 не найден | фазы BRP: `mac__set_mode_a000` по флагам кадра | `rx_funcs__handle_ppdu_report` | 0x6026…0x6029 |
| 30 | `rx_flow_step`, `tx_initiator_flow_fixed_scheduling`: бит qid станции в `0x802948` | после BlockAck снять бит qid в `0x802948` | `rx__dispatch_by_g_8005f8` 0x93360c, `tx_mtp_queue_gate` 0x939acc, `txop_initiator_open_txop_flow` 0x93a264 | — |
| 31 | `rx__detect_field_1b_change` (из `rx_flow__handle_frame`) | назначение не установлено (байт +0x1b кадра изменился) | — | — |

Значения `switch` в `rx_funcs__handle_ppdu_report` сравниваются со **всем словом** (0x800000,
0x100000, 0x200000, 0x400000, 0x80000, 0x8000000, 0x4000000, 0x20000000, 0x10000000; иначе
ассерт 0x18), то есть в BF-фазах остальные биты должны быть нулём. В 4.1 то же слово —
`0x800608` (значения 0x80000…0x20000000 совпадают с разбором микрокода 4.1); не путать с
6.2 `0x800608`, §4.5.

### 4.3. Фоновые задачи: 0x800584 / 0x800648 / 0x80058c **[код]**

`background_task__dispatch` 0x9215d2 — главный цикл uc:

* `0x800648` — **ожидающие** задачи. Ставит `bf_pending__set_bit(n)` 0x9216f8 (под `E1 = 0`),
  снимает `bf_pending__clear_bit(n)` 0x921750 перед вызовом обработчика.
* `0x800584` (`[gp,0x5c]`) — **разрешённые** задачи; `uc__set_evt_id_5c` 0x921724 пишет
  `0xffffffff` (все) или `0x39` (б0, б3, б4, б5; задачи 1 и 2 запрещены).
* `0x80058c` (`[gp,0x64]`) — **выполняемая** задача: обнуляется, затем ставится бит выбранной.
* Выбор — старший бит `0x800584 & 0x800648` (`norm; rsub 0x1e`), переход по байтовой таблице
  `0x8017d8`. Индекс ≥6 — ассерт 0x31. Нет задач — `background_bi_step`, затем `flag |0x6; sleep`.

| бит | обработчик (адрес ветки) | кто ставит | условие/ассерт |
|---|---|---|---|
| 0 | `bg_task__call_cb20(0x803134)` (0x92168c) | `rx_flow__handle_frame`, `rx_flow_step`, `bti__bi2_event_step`, `bti_bi2__track_best_metric`, `rx_meas__capture_frame`, `rx_meas__append_sample`, `rx_meas__finish_with_8830ec`, `ucode_cmd_0x29/0x2b/0x2f/0x38/0x3d_handler` | — |
| 1 | `bf_sm__process_request_fifo` (0x9215ba) | `bf__abort_step` 0x921824, `bf__flow_exit`, `bf_sm__process_request_fifo`, `ucode_cmd_0x0f_handler` 0x93477c, `internal_tx_isr` | запрещён маской 0x39 |
| 2 | `rs_end` (0x921630) | `tx_sta__run_txop` | запрещён маской 0x39 |
| 3 | `mac_mode__switch_sequence(1)` (0x92163c) — отложенная обработка `fw2uc_ICR` б1 (останов/смена режима) | `l1_task__mask_halt_req_and_defer` 0x9274e0 (сначала маскирует б1 записью 2 в `0x886de0`) | ассерт 0x1318, если `0x886dd0` б0 |
| 4 | `mac_mode__switch_sequence(0)` (0x921664) — отложенная обработка `fw2uc_ICR` б2 (выход из сна) | `l1_task__mask_wake_req_and_defer` 0x9274f4 (маскирует б2 записью 4 в `0x886de0`) | ассерт 0x1319, если `0x886dd0` б1 |
| 5 | `l1_task__kick_and_dispatch_uc` (0x921624) | писатель в 6.2 не найден | — |

### 4.4. Тени MAC: 0x8004e4, 0x8004e0, 0x8004c8, 0x8006a0 **[код]**

| слово | тень чего | биты |
|---|---|---|
| `0x8004e4` (`[gp,-0x44]`) | селекторы команды 0x1d | полубайты §2.3 |
| `0x8004e0` (`[gp,-0x48]`) | разрешение событий (команда 0x27) | OR-ится в `0x27000000 \| (1<<n)<<8`; при инициализации = 0xc (`stubs.c`) |
| `0x8004c8` (`[gp,-0x60]`) | `0x886f5c` `mac_tx_qid_enable_mask` | бит на qid; б31 = внутренняя очередь ucode. `tx_sta__run_txop` 0x93a136: `\|= 0x800564`, после TXOP `&= ~0x800564` |
| `0x8006a0` (`[gp,0x5e]`) | `0x889488` `abif_dvs_rf_ctrl` | ucode меняет только [25:24] (`dvs_if_splitter_enable`): `(тень & 0xfcffffff) \| [0x802940 или 0x802944] << 24` — набор RF на время TX/RX |

### 4.5. 0x800608 / 0x80060c — поля из r51 **[код]**

`0x800608` (`[gp,0x38]`) = `r51 & 0xf`, `0x80060c` (`[gp,0x39]`) = `r51 >> 4` (§2.13). Проверяется
только бит 1 `0x800608` (`bic r,r,-3`): становится битом 6 команды `0x19000b00` /
`0x19800830`, где `0x80060c << 14` — поле с бита 14 (`txop_initiator_open_txop_flow`,
`tx_mtp_queue_gate`, `abft_responder__tx_ssw` 0x930c66, `direct_tx_step`).

### 4.6. Маски по станциям и qid **[код]**

| слово | индекс бита | ставит | снимает | проверяет | смысл |
|---|---|---|---|---|---|
| `0x802948` | qid (`ctx[4]`, `fsched__cur_entry_byte0`) | `ucode_cmd_0x08_handler` (r0=3, тип 3, `r43.aggregation_enabled`); `l1_fixed_sched_ap_ev4_state4` 0x938880 | `ucode_cmd_0x08_handler` (r0=1, тип 3: `&= ~[0x801124+80·sta]`); `rx__dispatch_by_g_8005f8` (BlockAck при б30) | `txop_initiator_open_txop_flow` (бит есть → RTS/CTS, режим 4), `rx_flow_step`, `tx_initiator_flow_fixed_scheduling` (→ `0x8005f8` б30) | предположение: qid с открытым соглашением BA/агрегацией, для которых нужна защита RTS/CTS ([DATAPATH](DATAPATH.md) — «маска qid», [гипотеза]) |
| `0x800564` | qid станции | — | `ucode_cmd` (`&= ~(1<<sta)`), `tx_sta__run_txop` (=0) | `rx_flow_step` (бит есть → `ctx[8] = [0x800538]`, тип ответа 2), `rx_flow__handle_frame`, `tx_mtp_queue_gate`, `mtp__get_tx_permission` | OR-ится в `0x8004c8` (разрешённые qid); назначение не установлено |
| `0x8020b0` | станция 0..7, **б8 = неизвестный пир** | `bf_req__enqueue` 0x921bd4, `bf__abort_unexpected` 0x92b254 | `bf__abort_unexpected` (б8 → бит станции), `bf_clear_all_sta` 0x9218b4 | `bf__abort_unexpected` 0x92b288 (б8), `bf_sm` | маска станций с ожидающим запросом BF ([BF-ENGINE](BF-ENGINE.md)) |
| `0x802194` | станция | — | — | `l1_task__main_step` (`30 − norm` → индекс станции фиксированного расписания) | — |

Номер станции 8 в 6.2 означает «неизвестна» (`r38.addr2_match_valid = 0` → 8, §2.5).

### 4.7. Прочие проверяемые биты **[код]**

Частота — число проверок в vendor-листинге (`ld` из адреса + `bbit/btst/and` в пределах 6 инструкций).

| слово | бит(ы) | проверок | смысл / место |
|---|---|---|---|
| `0x801424` | 0 | 10 | MAC в режиме SLS: SSW/no-action mgmt обрабатываются (`rx_flow__handle_frame` 0x932574, `bti__bi2_event_step` 0x937238/0x937290, `bti_bi2__track_best_metric`, `rx__update_nav_from_frame` 0x9343fc, `rx_funcs__rx_flow`); RF-цепь `[0x801024]` вместо цепи станции (`ucode_cmd_0x01`) |
| `0x801424` | 1 | 1+ | `rx_flow__run` 0x931164: разрешает выбор лучшего сектора по SNR при `!r42.busy2` |
| `0x8021e0` | 0, 1, 2, 3, 4, 5, 9 | 6 | флаги TXSS: б0 ISS соседа, б1 развёртка соседа окончена, б2 SSW-FB, б3 SSW-ACK, б4 RTS ([BF-ENGINE](BF-ENGINE.md)); б5, б9 — в маске `rx_funcs__rx_flow` 0x933b9e, назначение не установлено |
| `0x8021d8` | 3, 4, 5 | 4 | б3 — `rx__handle_status_flags` 0x939e26, `tx_sta__flow_loop` 0x939f42 (статистика CTS, `0x857e49`); б4 — `internal_tx__flow_sm2` 0x939456; б5 — `internal_tx__flow_sm6` 0x93d840; назначение б4/б5 не установлено |
| `0x800874` | 0, 9, 16 | 3 | б0 — повтор BRP разрешён (`brp_initiator_brp_transaction_flow` 0x92269c, failure 3); б9 — `brp_init__flow` 0x922764; б16 — `brp_init__tx_request` 0x922d10 |
| `0x80146c` | 0, 1 | 5 | NAV: б0 — NAV включён (`rx_nav__set_from_duration` 0x92ddbc, `bi__remaining_time_us` 0x92dc52, `pm__event_mask_restore` 0x92dce4); б1 — `rx_nav__arm_flag_if_enabled` 0x92dc34; `grant_detect_step` берёт [1:0] |
| `0x802298` | 1, 2, 3, 4 | 2 | флаги приёма: б3 — RD-кадр от известной станции (§2.5); б1 — `rx_funcs__rx_flow` 0x933c58; б4 — `rx_get_required_response` 0x9333a8 |
| `0x80042f` | 0 | 16 | байт-счётчик чётности: `0x32000000 \| (b & 1)`, затем `++` (переключение двух буферов) |
| `0x80051c` | 0..3; 4, 5 | 21 | конфигурация RF-цепи: `& 0xf` в `0x563f0020`; `\| 0x30` (б4, б5) в векторы `tx__program_vector_rf`, `0x41000000` |
| `0x800878` | 2 | 1 | `brp_initiator_brp_transaction_flow` 0x9226a2 |
| `0x800884` | 0 | 1 | `brp_responder_flow_enter` 0x923008 |
| `0x80086c` | 3 | 1 | `brp_init__exchange_request` 0x92298e |
| `0x8014a0` | 9 | 2 | выбор кода управляющего кадра `0x8021c2/c3` вместо `0x8021c0/c1` (`tx_sta__run_txop` 0x93a0a4, `rx__handle_status_flags`) |
| `0x8025d8` | 1 | 1 | `rx_flow__run` 0x931310 |
| `0x8020bc` | 0..2 | 10 | индекс кольца FIFO запросов BF (8 мест, `& 7`) |
| `0x800514` | — | 26 записей | свободное место FIFO TX в байтах (§2.2) |

Неполный перечень: учтены слова с ≥1 битовой проверкой, найденные автоматически; байтовые поля кадра
(`0x804010…`) не включены.

---

## 5. MMIO 0x88xxxx

Имена и подробности — `6.2/ref/REGS-62.md` (генерируется из `REGS-KNOWN.txt`). Ниже — регистры,
к которым uc применяет битовые маски, и что он с ними делает **[код]**; имена — из REGS-KNOWN
(источник имени указан там: драйвер, debug-tools, пак, лог-строки).

| адрес | имя | биты | что делает uc | где (vendor) |
|---|---|---|---|---|
| 0x886dd0 | `fw2uc_ICR` | 0 команда LMAC, 1 смена режима MAC, 2 выход из сна (W1C) | квитирование записью 1/2/4; перед `mac_mode__switch_sequence` проверка б0/б1 (ассерты 0x1318/0x1319) | `background_task__dispatch` 0x92163c/0x921664, `l1_task__kick_and_dispatch_uc`, `mac_mode__switch_sequence` |
| 0x886dd4 | `fw2uc_ICM` | 0..2 | разбор причины в начале L1 | `l1_task__entry` |
| 0x886de0 | `fw2uc_IMS` | 0..2 | запись 1 маскирует источник: 2 и 4 — перед откладыванием в фоновые задачи 3/4 | `l1_task__mask_halt_req_and_defer`, `l1_task__mask_wake_req_and_defer`, `l1_task__kick_and_dispatch_uc` |
| 0x886ddc | `fw2uc_IMV` | 0..3 | 0xf — замаскировать всё (окно AW), 8 — открыть б0..2 | `mac__ddc_mask_bit3` 0x92735c |
| 0x886d3c | `uc_sleep_wake_mask` | маска r42 + б9 | перед `sleep` — маска, после — 0 | `uc_sleep_until_event` 0x9367a8 |
| 0x886d00 | `mac_ifs_sifs` | [7:0] такты, [15:8] мкс, [24:16] = 0x173 | SIFS ответа; на время SLS — 3·SIFS | `rx_funcs__handle_ppdu_report` (`v \| 0x1730000`) |
| 0x886544 | `mac_mgmt_seq_num` | чтение [11:0] = SN; запись `(SN+1)<<16 \| 1<<28` | номер последовательности кадров ucode | `tx_fifo__push_frame_3ies`, `brp_init__tx_request`, `brp_responder_transmission_flow`, `direct_tx__send_with_seq` |
| 0x88656c | `tx_engine_state` | [3:0] = 0 обязательно | иначе ассерт 3 перед PPDU из очереди | `mac_q__tx_ppdu*`, `tx_bcast_flow`, `ucode_cmd_0x08/0x0b` |
| 0x886608 | `qdesc_win_ctrl` | 30 пуск, 29 занято, 31 удержание | запись 0x40000000/0xc0000000, опрос б29; опрос б31 | `qh_pack_descriptor` 0x92420c, `qh_wait_desc_window_ready` 0x924480, `macq_desc__*` |
| 0x886a38 / 0x886a44 | `txq_fifo_sm_a/c` | запись б31 = снимок; [1:0] состояние | проверка простоя FIFO | `vring__disconnect_flush` |
| 0x886a48 | `txq_ptp_sm` | б31 снимок, [2:0] состояние (5 = зависание) | сброс 0 → 0x40000000 | `vring__disconnect_flush` |
| 0x886eb4 | `mac_timing_status` | 31 = значения времени готовы | опрос перед чтением TSF/BI | `mac__read_*_uc` (3 места) |
| 0x886ec0 | `mac_usec_to_tbtt` | [25:0] | до TBTT, мкс | `mac__read_usec_to_tbtt_uc` |
| 0x886f5c | `mac_tx_qid_enable_mask` | бит на qid, б31 internal TX | из тени `0x8004c8` (§4.4) | `tx_sta__run_txop` 0x93a142 |
| 0x886024 | `prs_own_addr_hi` | 31 = свой адрес действителен | снимается в `bti__bi2_event_step`, ставится в `bi_manager_step_a` | — |
| 0x88607c | `MAC_MAC_RGF_PMC_GENERAL_0` | 16 `rec_en_set`, 17 `rec_en_clr` | запуск/останов записи PMC | — |
| 0x889488 | `abif_dvs_rf_ctrl` | [7:0] activate, [15:8] rfca_en, [23:16] config_en, [25:24] if_splitter | uc меняет [25:24] и [23:16] (`& 0xff00ffff \| b<<16`) | `rf__set_txrx_sets_save` 0x92a314, тень `0x8006a0` (§4.4) |
| 0x8890cc | `rfc_core_ctrl` | 30 пуск, 29 занято | `\|= 1<<30`, опрос б29 (до 0x30d40 итераций) | `hwd_rfc_write_core` 0x92a3d8, `rfca__select_rf_uc` |
| 0x880bf0 | `pwr_mode_map_bf0` | [3:0], [7:4] | `(v & ~0xff) \| mode \| mode<<4` | `mac__set_880bf0_mode` |
| 0x88c120 | `mac_ext_window_remain` | [23:0] | остаток окна в тактах | `bi_rx__start_rx_window` |
| 0x883830 | `phy_rx_signal_gain_adc_db` | [6:0], [20:14] | усиление АЦП | `phy.c`, `rx` |
| 0x88306c | `phy_rx_agc_row` | [5:0] | строка AGC | `rx_mode__configure`, `rx_flow__measure_snr_select_best` |
| 0x8837b0 | `phy_rx_status_8837b0` | 1 | при `r40[2:0]==2` запускает выбор сектора по SNR | `rx_flow__run` |
| 0x880c7c | `phy_pwr_status` | 0..2 | подтверждение питания доменов PHY | `hwd_phy_pwr` |
| 0x8896ac | `hw_state3` | [2:0] | в историю ассерта | `uc_sysassert__read_hw_state3` |
| 0x881134 | `dma_descq_valid` | 0..3 | лог «descq valid» | `dump_vring_pring_info` |
| 0x881300…0x88130c | `DMA_RGF.DESCQ<n>.HW_HEAD` | 0..3 | лог PRING | там же; раскладка блока очереди — [HARDWARE-BLOCKS](HARDWARE-BLOCKS.md#очереди-дескрипторов-dma_rgfdescq) |
| 0x880af4 / 0x880b04 | `clks_ctl_sw_clk_vec_0` / `SW_RST_VEC_0` | [17:0] | маска `bmsk 0x11` | `dma_mac__cfg_880c14/28` |
| 0x8830ec, 0x883aa4, 0x8837f4, 0x883800, 0x8836c8 | замеры PHY | [4:0]…[21:0] | замеры после BRP/приёма → `0x801504…` | `brp__program_and_measure`, `rx_meas__capture_frame` |

---

## 6. Формат MAC-команд

Описан полностью в [MAC-COMMANDS.md §1.1](MAC-COMMANDS.md#11-формат-слова) (бит 31 — событие PMC,
[30:24] код, [23:0] параметр), карта кодов — §2, связь с регистрами результата — §7. Здесь он не
дублируется; дополнения по битам параметров, связанным с регистрами этого документа:

* `0x19000b00 | (0x800608.б1 << 6) | (0x80060c << 14)` — передача после ответа MTP (§4.5) **[код]**;
* `0x18000000` / `0x18001000` — выбор по `0x8005f4` б4 (§4.1) **[код]**;
* `0x3e000000 | r43.mcs << 4` — MCS из ответа MTP (§2.9) **[код]**;
* `0xcac000 | r40.idle_detect`, `0xcac100 | …` и `COUNT1 & 0xffffff` (код 0) — трассировочные
  записи в кольце (§2.6, §3) **[код]**.

---

## 7. Расхождения

### 7.1. Наш C ↔ vendor asm

Сверка: для каждой функции, которая есть и в `rewrite/uc/*.c`, и в листинге, сравнивались наборы
проверяемых бит r36…r55 (`arc_core_rd(N) & …`, `>> k & m`) с наборами бит в vendor
(`bbit/btst/and/lsr+bmsk` после чтения `rN`), а также маски ожиданий. Все найденные
автоматически различия при ручной проверке оказались артефактами разбора: бит проверяется
через промежуточную переменную, макрос `mac_cca_ok()`, `uc_spin_until_event(1<<15)` вместо
`tst r42`, или в слоте задержки (`bbit1.d`). Например, в `abft_responder__tx_ssw`
`while (!(r42 & (1<<15)))` = vendor `bl.d uc_spin_until_event; bset r0,r0,0xf` (0x930b04),
`direct_tx__send_from_desc` `& 0x70` = vendor `bic.f r12,r12,-0x71`. **Расхождений в битах
регистров и в управляющей логике не найдено.**

Расхождения в комментариях и именах нашего кода (код не правился):

| место | что написано | что говорит vendor | вывод |
|---|---|---|---|
| `rewrite/uc/mac.c:451` (`macq_probe_empty`, 0x92dab8) | «1 — очередь пуста (бит 1 r45 сброшен)» | `mtp_queue__release_mgmt` 0x93eb12: при `r45.1 = 1` — лог «Error: MTP Queue is empty» | код совпадает (возврат `!r45.1`), но смысл в комментарии противоположен vendor-строке; если строка верна, функция возвращает 1, когда очередь **не** пуста |
| `rewrite/include/hw.h` `HW_DMA_BASE 0x886d00` | «DMA-дескрипторы/каналы» | 0x886d00 — `mac_ifs_sifs`, 0x886d00…0x886dff — блок SXD MAC (`MAC-COMMANDS §1`) | имя базы неверно |
| `rewrite/include/hw.h` `HW_DMA_CTL 0x886d80` | «DMA kick/sync» | 0x886d80 — `mac_sxd_base`; `+0x50` = `fw2uc_ICR` 0x886dd0 | имя базы неверно |
| `rewrite/include/hw.h` `HW_TIMER_BASE 0x886a00` | «таймеры» | 0x886a18…0x886a48 — очереди TX (`macq__flush_queue`, `txq_fifo_sm`, `txq_ptp_sm`) | имя базы под вопросом |

### 7.2. Пак (wil6436) ↔ vendor asm Sparrow

| регистр | пак | uc 6.2 | вывод |
|---|---|---|---|
| `BF_METRIC_R40` (r40, сел. 0xd) | [8:0] `snr_ratio_out_db_sc_comp`, [14:9] `gain_adc_db`, [20:15] `gain_phasor_db` | одно 11-битное поле [19:9] со знаком (`lsr 9; bmsk 10; x>0x3ff → x−0x800`), 7 мест | раскладка в Sparrow отличается; предположение: [19:9] — метрика BF целиком |
| `QUEUE_SEL_STATUS_R41.qid_for_found_queue_set` | 16..21 | 16..20 | uc берёт 5 бит из 6 |
| `QUEUE_SEL_FOUND_SET1_4_R41.qid_selected_qset4` | 24..29 | 24..28 | то же |
| `PPDU_REPORT_2_R37.ss_bitmap` | одно поле 24..26 | три отдельных флага SSW / SSW-FB / SSW-ACK | уточнение, не противоречие |
| `MTP_TX_PERMISSION_RESP.null_status` | одно поле [7:0] | б1 = «очередь пуста», б5 — отдельный флаг, `[7:0] & маска станции` | уточнение |

---

## 8. Не установлено

* Группы, которые выбирают полубайты 3..0, 7..4, 23..20 теневого селектора (§2.3).
* Назначение бит 1 и 5 в `MTP_TX_PERMISSION_RESP.null_status` по паку; поля `r51` (§2.13).
* `0x8005f4` б7…б10 и `0x8005f8` б4 (режим 16), б17, б18, б20, б26…б29: писатель в 6.2 не
  найден (только проверки); возможно, это остатки 4.1. Смысл `0x8005f8` б31.
* `0x802948`, `0x800564` — точный смысл масок qid.
* Бит 24 `sr` в DEBUG (AUX 0x5) при программировании точки останова.
* Регистр r55 в `mac_mode_program_c`, `rx__switch_to_rx_mode`, `rx_nav__set_from_duration`.
* Признак полуслова в r34 (б24) — подтвердить на стенде или по второй ветке
  `direct_tx__send_after_delay`.

## Источники

`6.2/ref/MSXD-LR-RGF.txt` (имена полей r36…r56), `6.2/ref/REGS-KNOWN.txt` / `REGS-62.md`
(MMIO), `6.2/ref/strings-uc.bin` (лог-строки по смещению `0x1000000+N`), `6.2/build/uc_data.bin`
(таблица таймеров 0x800738), vendor-листинг `6.2/src/asm/uc/**/*.S`, имена функций
`rewrite/tools/ghidra/out/names.txt`, наш C `rewrite/uc/*.c`, `rewrite/include/arc.h`.
Связанные документы: [MAC-REGISTERS.md](MAC-REGISTERS.md), [MAC-COMMANDS.md](MAC-COMMANDS.md),
[UCODE-TASKS.md](UCODE-TASKS.md), [BF-ENGINE.md](BF-ENGINE.md), [DATAPATH.md](DATAPATH.md),
[BEACONING.md](BEACONING.md).
