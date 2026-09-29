# Отчёт MAC_MON (окна BTI/AW/DTI)

Каждый BI ucode публикует в общую память отчёт о прошедшем интервале и шлёт fw
событие 0x17 `MAC_MONITOR_EVT`. В 4.1 fw печатает его в модуль журнала MAC_MON
(`lmac_if__mac_monitor_report` 0x8d865c); в 6.2 печать убрана, обработчик
`lmac_if__update_pct_stats` 0x8db9c0 только считает доли NAV и занятости среды. В 6.4
печать возвращена (`6.4/src/c/fw/lmac_if__update_pct_stats.cpp`).

## Публикация

| | 4.1 | 6.2 | уровень |
|---|---|---|---|
| опубликованная копия | 0x854de0, 0x7c Б | **0x853940, 0x80 Б** | [код] 4.1 0x93715e; 6.2 0x93cdf0 |
| рабочая копия (ОЗУ ucode) | 0x8008e0 | 0x801084 | [код] |
| двойной слот BTI (0x28 Б) | 0x80088c + 0x28·i | 0x801030 + 0x28·i | [код] |
| публикатор | `bi_window_transition_prep` 0x9370b8 | `peer_slots__scan_by_masks` 0x93cd2c | [код] |
| флаг взвода | `[gp−0x2c]` 0x8004fc, ставит `bi_ap_mon__dti_event` | `[gp−0x28]` 0x800500, ставит `bi_sm__action_935d0c` @0x935d3c | [код] |

Публикатор обеих версий: копирует дозревший слот BTI в рабочую копию, `memcpy` рабочей
копии в опубликованную, очищает слот и рабочую копию, шлёт `uc_send_evt__mac_monitor(1)`.
Нагрузка события — константа 1, не указатель. Отдельного признака готовности нет —
им служит само событие. Опубликованную копию перезаписывает только следующий `memcpy`
публикатора, защиты нет ни в одной версии; поэтому 6.4 печатает из снимка **[код]**.
6.2 не сохраняет длительность публикации (`update time` 4.1) **[код]**.

## Поля

Смещения — от начала опубликованной копии. До +0x48 раскладка 6.2 совпадает с 4.1; с
+0x50 в 6.2 вставлены два поля, всё дальше сдвинуто на 8 байт. Писатели в ucode сверены
по совпадающему коду (та же последовательность инструкций, базы 4.1 → 6.2 сдвинуты на
+0x7a4) **[код]**.

| поле | 4.1 | 6.2 | писатель 6.2 |
|---|---|---|---|
| bcon bitmap (lo, hi) | +0x04, +0x08 | то же | нет ни в одной версии: всегда 0 |
| BTI start (lo, hi) / duration | +0x0c, +0x10 / +0x14 | то же | `bi_timing_snapshot_b` 0x922444; `l1__snapshot_bi_counter` 0x923a16 |
| rssi valid / rssi | +0x18 / +0x1c | то же | `bti__bi2_event_step` 0x937264 |
| snr valid / snr | +0x20 / +0x24 | то же | fw, `lmac_if__update_pct_stats` (LUT 0x805170) |
| tx bcon / rx bcon / detected | +0x28 / +0x29 / +0x2a | то же | `bcon_txss_sweep_step` 0x93b748; `bti_worker_bi2_step` 0x923b44 |
| AW start (lo, hi) / duration | +0x2c, +0x30 / +0x34 | то же | `mac_prog__cmd02_body` 0x9214ba |
| backoff AW / tx atim pass / fail / counter | +0x38 / +0x39 / +0x3a / +0x3b | то же | `bi_rx__slot_handler` 0x92b4f8…; `bi_rx__start_rx_window` 0x921290 |
| rx atim / bcons_atim_fail_vec | +0x3c / +0x3d | то же | `rx_flow__handle_frame` 0x932a6c; публикатор 0x93cdbc |
| DTI start (lo, hi) / duration | +0x40, +0x44 / +0x48 | то же | `mac_prog__cmd02_body` 0x9214fa, 0x9214dc |
| nav accumulator | +0x4c | то же | `rx_nav__set_from_duration` 0x92de84 |
| — (только 6.2) | — | +0x50 u32 | `rx_funcs__rx_flow` 0x933cd4; смысл не установлен |
| — (только 6.2) | — | +0x54 u32, занятость среды [гипотеза] | `rx_flow__accumulate_busy_time` 0x9249a6 |
| backoff DTI | +0x50 | **+0x58** | `fixed_sched__run_tx_slot` 0x93769e |
| tx rts / rx cts / rx dts | +0x52 / +0x54 / +0x56 | **+0x5a / +0x5c / +0x5e** | `txop_initiator_open_txop_flow` 0x93a5f0; `tx_sta__wait_slot_and_tx` 0x93a644, 0x93a6a2 |
| rx rts / tx cts / tx dts | +0x58 / +0x5a / +0x5c | **+0x60 / +0x62 / +0x64** | `rx_get_required_response` 0x933210; `rx_flow__handle_frame` 0x932d58; `rx__send_response_frame` 0x93625e |
| cf end | +0x5e | **+0x66** | `tx__send_and_await_rx_frame` 0x924c18 |
| ka pass / ka fail | +0x60 / +0x61 | **+0x68 / +0x69** | `internal_tx__flow_sm2` 0x9393d2, 0x9393e8 |
| rx off duration | +0x64 | **+0x6c** | `ucode_cmd_0x01_handler` 0x93aa8e |
| update time | +0x6c | нет | — |
| — (только 6.2) | — | +0x70, +0x74 (fixed scheduling), +0x78 (событий BI2), +0x7c | `tx_slot__dispatch` 0x938e74; `bti__bi2_event_step` 0x937300; `aw_tbtt__count_intervals` 0x93546a |

## Обработчик 6.2

`lmac_if__update_pct_stats`: при `rssi valid` пишет SNR из RSSI; `avail = DTI − (+0x50 +
rx off)`; доли `nav accumulator` и +0x54 от `avail` в процентах (текущие, сумма и среднее
за период `[0x803c1c] + 1` BI) — структура 0x80426c, её отдаёт хосту WMI 0x1a07; затем
`mac_tx_cnt__get_u64_14`, `mac_rx_cnt__get_u64_bc` и рассылка системного события 0x16,
по которому отчёт читают `bad_beacons_detector`, `ka_necessity_detector`,
`conn_mgr__bi_evt_all_conns` **[код]**.

## Стенд [железо]

Сборка 6.4, AP и станция 6.2: отчёт печатается каждый BI. BTI ≈ 1,97 мс, AW ≈ 1 мс,
DTI ≈ 100 мс; AP — `tx bcon 63`, станция — `rx bcon 64`, `detected 1`; счётчики RTS/CTS
AP и станции зеркальны. У станции `rx snr valid 0`: поля BTI публикуются из залипшего
слота (см. `6.2/docs/BENCH.md`, «Двойной буфер»).
