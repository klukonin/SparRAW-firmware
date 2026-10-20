# `g_dbg_dashboard` в 4.1: разметка по членам

Отладочная сводка прошивки 4.1.0.1000: температуры, калибровки, статистика
связей, ложные срабатывания, power-save и публикуемый микрокодом монитор BI
(`ucode_mac_monitor`). Разметка сверена с памятью узла в роли PCP при поднятой
связи со станцией 26:18:1d:26:d4:7b **[железо]**; якоря — **[код]**.
Колонка «пак 11ad» сравнивает с вендорской структурой из пака 11ad.
Назначение сводки и функции-писатели обеих версий —
[docs/FW-OBJECTS.md](../../docs/FW-OBJECTS.md#отладочная-сводка-g_dbg_dashboard).

## База и границы

`g_dbg_dashboard = 0x854800`, размер `0x65c` = 1628 Б (0x854800…0x854e5c).

Якорь — `dashboard__init` @0x8ed218, 44 байта:

    8ed21c  mov_s r13,0x854800          ; база
    8ed224  bl 0x8c1a78 / r1=0x65c      ; memset(g_dbg_dashboard, 0x65c)
    8ed22e  st_s r0,[r13]      r0=5     ; header.revision = 5   (u32)
    8ed234  stw_s r0,[r13,0x4] r0=0x65c ; header.size = 0x65c   (u16) + reserved[2]
    8ed238  add3 r0,r13,0x1f            ; r13 + 0x1f<<3 = 0x8548f8
    8ed23c  bl 0x8e8444 (r1=0xf)        ; phy_mac_flags.direct_rx_active_sta_id = 0xf

Размер объявлен в коде. Второй независимый якорь базы — константа в данных
прошивки **`0x8033d8 = 0x00854800`** (аналог вендорского
`dashboard_base_address`; на железе читается это значение) и геттер-заглушка
`stub_ret_8c9fbc` @0x8c9fbc — элемент vtable.

Адресация: host = 0x908000 + A − 0x840000; смещение в `blob_fw_peri`
= A − 0x840000 (0x854800 → 0x14800).

## Секции

| секция | адрес | размер | пак 11ad |
|---|---|---|---|
| `header` | 0x854800 | 0x08 | 0x08 = |
| `dashboard_sys_and_calib` | 0x854808 | **0xec** | 0x64c ≠ |
| `dashboard_phy_mac_stats` | 0x8548f4 | 0x0c | 0x0c = |
| `active_links_bitmap` | 0x854900 | 0x04 (u8+pad) | = |
| `link_stats[8]` | 0x854904 | **0x480** (8 × **0x90**) | 8 × 0xc8 ≠ |
| `false_alarms` | 0x854d84 | 0x1c | 0x1c = |
| `ps_stats[8]` | 0x854da0 | 0x40 (8 × 8) | = |
| `ucode_mac_monitor` | 0x854de0 | **0x7c** | 0xb4 ≠ |

Сумма = 0x65c, ровно объявленный `size`. Границы замыкаются двумя
независимыми арифметиками:
* `link_stats` 0x854904 + 8 × 0x90 = **0x854d84** = база `false_alarms`;
* `ucode_mac_monitor` 0x854de0 + 0x7c = **0x854e5c** = 0x854800 + 0x65c; сразу
  за этим адресом в живом дампе начинаются посторонние данные.

Раскладка не совпадает с вендорской: наложение структуры пака 11ad расходится
начиная с `sys_and_calib+0x04`. По смещениям совпадают только `phy_mac_stats`,
`false_alarms`, `ps_stats`.

## 1. `dashboard_sys_and_calib` @0x854808 (0xec)

| смещ. | поле | разм. | якорь |
|---|---|---|---|
| +0x00 | `baseband_temperature` (м°C) | 4 | st 0x8ddda2 `rf_lo__refresh_periodic`; ld 0x8e3c60 (лог `rf_temperature %d \| baseband_temperature %d`, arg2) |
| +0x04 | `rf_temperature` (м°C) | 4 | st 0x8ddfba `temp_service__sample_without_rf`; ld 0x8e3c6c (та же строка, arg1) |
| +0x08 | `sar_dc_val_i[8]` int8 по RF-цепи | 8 | stb 0x8d3356 `calib_sar_step` |
| +0x10 | `sar_dc_val_q[8]` int8 | 8 | stb 0x8d3380 `calib_sar_step` |
| +0x18 | `vga_dc_est[2][0x40]` int8, индекс `path*0x40 + i-1` | 0x80 | stb 0x8d3bb8 `hwf_vga_dc__calibrate` (`asl r0,r17,0x6`) |
| +0x98 | **[гипотеза]** `iq_mismatch` (64 бита); писателей и читателей нет, в живой памяти нули | 8 | — |
| +0xa0 | результат калибровки утечки LO, знач. 1 (вендорский `opt_lo_val`) | 4 | st 0x8e01e0 `calib_lo_leakage_run` |
| +0xa4 | то же, знач. 2 | 4 | st 0x8e01e2 |
| +0xa8 | `gain_calib_and_atten` упакованный dword | 4 | `lmac_if_send_cmd_0x11`: 0x8d8b76 (shift 0, w 6), 0x8d8b80 (shift 0xc, w 4), 0x8d8b88 (shift 0x10, w 4) |
| +0xac | `calib_statistics[6]`, шаг **0x0a**, 5 × u16 | 0x3c | индексация `type*10` во всех четырёх функциях |
| … +0x00 | `started` | 2 | stw 0x8c854a `calib_engine__on_start` |
| … +0x02 | `no_correction_needed` | 2 | stw 0x8c51c0 `calib_engine_sm__check_correction_needed` |
| … +0x04/06/08 | `step_result_0..2` | 2×3 | stw 0x8c664a / 0x8c6660 / 0x8c6678 `calib_engine__step` |
| +0xe8 | `assoc_calibs_total_duration_usec` | 4 | ld/st 0x8e5680 `calib_engine__links_active`; сброс st 0x8e58de `dashboard__add_connection` |

Живое: `baseband_temperature`=53964 (54.0 °C), `rf_temperature`=36250,
`calib_statistics` — 6 записей, последняя кончается ровно на 0x8548f0.

Имена `sar_dc_val*`, `vga_dc_est`, `gain_calib_and_atten` — по вендорской
аналогии: слот и индексация доказаны кодом, вендорское имя — нет (в паке 11ad
эти поля на других смещениях и другой ширины).

`+0x98` — трактовка по порядку полей вендорской `sys_and_calib_s`:
`… vga_dc_est_arr, rf_rfc_rd_retries, dc_*_hist…, iq_mismatch (64 бита),
tx_gain_idexes, opt_lo_val, …`. В 4.1 сразу за дыркой идут два слова
`calib_lo_leakage_run` (0x8548a8/0x8548ac) — вендорский `opt_lo_val`, стоящий в
паке 11ad ровно за `iq_mismatch`; совпадают позиция и размер. Калибровки
IQ-mismatch в 4.1 нет (в строках только `swap_iq`).

## 2. `dashboard_phy_mac_stats` @0x8548f4 (0xc) — совпадает с паком 11ad

| адрес | поле | якорь |
|---|---|---|
| 0x8548f4 | `nav_accumulated_activity_usec` | st **0x92a8e6** `nav_db__update` (**микрокод**, публикует младшее слово 64-битного аккумулятора 0x8009c0); ld 0x8ea0f6 / 0x8efeb6 `scan_mngr__*` |
| 0x8548f8 | `dashboard_phy_mac_flags` dword | ниже |
| 0x8548fc | `pm_switch2off_cnt` | st **0x936cea** `uc_pm__enter_idle` (микрокод) |

Битовые поля 0x8548f8 (позиции как в паке 11ad, подтверждены аксессорами
`r10=сдвиг, r11+1=ширина`):

| биты | поле | якорь |
|---|---|---|
| 15 | `short_txop_en` | `bclr_s r1,r1,0xf` + `asl r2,r17,0xf` @0x8d8af8, st 0x8d8afe |
| 21 | `selective_detection_en` | `bclr_s r1,r1,0x15` @0x8d8ae0 |
| 22 | `selective_NAV_en` | `bclr_s r1,r1,0x16` @0x8d8ae2 |
| 24-27 | `direct_rx_active_sta_id` | bl 0x8e8444 (shift 0x18, w 4) @0x8ed23c, init=0xf |
| 29-31 | `active_connections_cntr` | bl 0x8e8498 (shift 0x1d, w 3) @0x8e583c (-1), @0x8e58d2 (+1) |
| 0-14 | `link_lost_cntr` | якоря нет (вендорская аналогия) |
| 16-20, 23, 28 | `active_roles`, `gain_mode`, `direct_rx_out_txop_en` | якоря нет |

Живое 0x2f000000 → `direct_rx_active_sta_id`=0xf, `active_connections_cntr`=1
при одной связи.

## 3. `active_links_bitmap` @0x854900, u8

stb 0x8e5850 `dashboard__on_disconnect` (`bclr r0,r0,cid`), stb 0x8e58e8
`dashboard__add_connection` (`bset`), ldb 0x8e5672
`calib_engine__links_active`. Живое 0x01 при одной связи.

## 4. `link_stats[8]` @0x854904 — шаг **0x90 = 144** (в паке 11ad 0xc8)

Индексация: `asl rX,cid,0x4; add3_s rX,rX,rX` = `cid*0x90`. Компилятор держит
базу 0x854900, поэтому в листингах смещения на 4 больше.

| смещ. | поле | разм. | якорь |
|---|---|---|---|
| +0x00 | `cur_stat.tpt` | 2 | stw 0x8e5990 `dashboard__update_rs_result` |
| +0x02 | `cur_stat.per` | 1 | stb 0x8e2bcc `link_stats__report` |
| +0x03 | `cur_stat.tx_mcs` (биты 24-28 dword +0x00) | — | bl 0x8e8450 (shift 0x18, w 5) @0x8e59a2 |
| +0x04 | `local_tx_sector` | 1 | stb 0x8e57f2 `dashboard__bf_results` |
| +0x05 | `local_rx_sector` | 1 | stb 0x8e57ea |
| +0x06 | `remote_tx_sector` | 1 | stb 0x8e57f6 |
| +0x07 | `remote_rx_sector` | 1 | stb 0x8e57ee |
| +0x08 | `tx_goodput` | 2 | stw 0x8e2bd8 `link_stats__report` (лог `TX_GOODPUT=%d`, arg1) |
| +0x0a | `rx_goodput` | 2 | stw 0x8e2bd4 (arg2 той же строки) |
| +0x0c | `latency_usec` | 4 | st 0x8d99c2 `link_stats__collect` |
| +0x10 | `metric_calc_result` | 2 | stw **0x921ba6** `brp__find_phase_index` (микрокод) |
| +0x12 | `atten_index` | 1 | stb **0x921ba8** |
| +0x14 | `tx_mcs_histogram[13]` | 0x34 | ld/st 0x8e59ba `dashboard__update_rs_result` (`[base+0x18 + mcs*4]`, проверка `mcs < 0xd`) |
| +0x48 | `bf_triggers[7]` | 0x1c | ld/st 0x8e5606 `dashboard__count_bf_result` (`[base+0x4c + bit*4]`, цикл `brlt r13,0x7`) |
| +0x64 | `bf_triggers_total` | 4 | ld/st 0x8e55ee |
| +0x68 | `unknown_bf_trigger` | 4 | ld/st 0x8e5618 (ни один бит не выставлен) |
| +0x6c | `failed_bf` | 4 | ld/st 0x8e580e `dashboard__bf_results` (status==0) |
| +0x70 | `failed_retrying_bf` | 4 | ld/st 0x8e581a (status==2) |
| +0x74 | `rs_done` | 4 | ld/st 0x8e599a |
| +0x78 | `rs_wip` | 4 | якоря нет, по вендорскому порядку |
| +0x7c | `rf_resets` u16 + reserved u16 | 4 | якоря нет |
| +0x80 | `initiator_txop_counter_with_data` | 4 | ld/st **0x9328de** `bi_tx_initiator_wrap` (микрокод); сохраняется через memset в `dashboard__add_connection` — ld 0x8e5886 / st 0x8e58a0 |
| +0x84 | `initiator_txop_counter` | 4 | st **0x93292e** (копия счётчика микрокода 0x8015f8+cid*4); сохраняется — ld 0x8e5896 / st 0x8e58a4 |
| +0x88 | `remote_mac[6]` | 6 | memcpy(dst=base+0xc, src=conn+0x10, 6) — bl 0x8e58b0 `dashboard__add_connection` |
| +0x8e | `reserved2[2]` | 2 | — |

Отличия от пака 11ad: `per_histogram` в 4.1 отсутствует — `tx_mcs_histogram`
начинается сразу на +0x14 (в паке 11ad на +0x2c); гистограмма MCS — 13 ячеек
(не 17), `bf_triggers` — 7 (не 11), `initiator_txop_*` на +0x80/+0x84 (в паке
11ad +0xb8/+0xbc). Полный сброс записи: `memset(link_base, 0x90)` — bl 0x8e589a.

**[железо]** `remote_mac` на 0x85498c = `26:18:1d:26:d4:7b` — байт в байт MAC
станции из `iw station dump`; `bf_triggers[4]=1`, `bf_triggers_total=1`.

## 5. `false_alarms` @0x854d84

| адрес | поле | якорь | живое |
|---|---|---|---|
| 0x854d84 | `total_fa` | st **0x92d174** `rx_flow__run` (микрокод, абсолютный `st r6,[0x854d84]`); ld 0x8e3c46 (лог `false_alarms.total_fa %d`), 0x8e2b84, 0x8e252c | 129419 |
| 0x854d88 | `in_txop_cp` | ld 0x8eae6a `link_lost_diag__dump_false_alarms` (`[0x854d80,0x8]`) | 0 |
| 0x854d8c | `in_txop_dp` | ld 0x8eae74 | 12 |
| 0x854d90 | `in_txop_ad` | ld 0x8eae80 | 0 |
| 0x854d94 | `out_txop_cp` | ld 0x8eae88 | 0 |
| 0x854d98 | `out_txop_dp` | ld 0x8eae8e | 0 |
| 0x854d9c | `out_txop_ad` | ld 0x8eae98; ld 0x8e3c52 | 126457 |

Компилятор держит базу-регистр 0x854d80 и ходит по +0x8…+0x1c; структура
начинается на 0x854d84, что подтверждено абсолютным store из микрокода.
0x854d80 — последние 4 байта `link_stats[7]`.

## 6. `ps_stats[8]` @0x854da0, шаг 8 — совпадает с паком 11ad

| смещ. | поле | якорь |
|---|---|---|
| +0x00 | `psc_agreement_counter` u32 | ld/st 0x8dd6ba `PS_CONNECTION__psc_complete` (`[0x854d80 + cid*8, 0x20]`) |
| +0x04 | `m_dpm_local_latest_agreement` u8 | stb 0x8dd66c |
| +0x05 | `sleep_cycle` u8 | stb 0x8dd672 |
| +0x06 | `number_of_awake_bi` u8 | stb 0x8dd678 |

## 7. `ucode_mac_monitor` @0x854de0 (0x7c)

### Публикация
`bi_window_transition_prep` @0x9370b8 (микрокод):
* `st r17,[r15,0x54]`, r17=0x7c @0x9371d8 → `db_size = 0x7c`;
* копирование дозревшего слота `mm_bti[1-idx]` (0x28 Б) в рабочую копию —
  st @0x937178…0x9371b4;
* **`memcpy(0x854de0, 0x8008e0, 0x7c)`** — dst @0x93715e, src @0x937168,
  len @0x937170, вызов bl 0x9371b8;
* `memset` слота (0x28) @0x9371c4 и рабочей копии (0x7c) @0x9371d0;
* переинициализация: `detected=0` @0x9371dc, `rssi_valid=0` @0x9371e0,
  `rssi=-0x100` @0x9371e8, `snr_valid=0` @0x9371ec, `snr=-0x100` @0x9371f0.

Рабочая копия — 0x8008e0, слот `mm_bti[i]` = 0x80088c + i*0x28 (пространство
**ucode**, host 0x9408e0 / 0x94088c).

### Поля (смещения от 0x854de0; «uc» — производитель в микрокоде, «fw» — читатель)

| смещ. | поле | разм. | производитель (uc) | читатель (fw) |
|---|---|---|---|---|
| +0x00 | `db_size` (=0x7c) | 4 | st 0x9371d8 | — |
| +0x04 | `mm_bti.bti_bcon_bitmap` | 8 | писателя нет ни в fw, ни в uc — только memset слота; поле мертво по коду | ld 0x8d86d0/0x8d86dc |
| +0x0c | `bti_start_time` | 8 | st 0x922c74/0x922c78 `bi_timing_snapshot_b` | ld 0x8d8688/0x8d869c |
| +0x14 | `bti_duration` | 4 | st 0x921d2a `bi_window_timing_update` | ld 0x8d8692 |
| +0x18 | `bti_max_bcon_rx_rssi_valid` | 1 | stb 0x9321c0 `bti__bi2_event_step`; reset 0x9371e0 | ldb 0x8d8668 |
| +0x1c | `bti_max_bcon_rx_rssi` | 4 | st 0x9321b8 (max-трекинг); reset 0x9371e8 (=-256) | ld 0x8d867e |
| +0x20 | `bti_max_bcon_rx_snr_valid` | 1 | stb **0x8d8684** — вычисляет **прошивка** из rssi; reset 0x9371ec | ldb 0x8d86c8 |
| +0x24 | `bti_max_bcon_rx_snr` | 4 | st **0x8d8680** (fw, из rssi через 0x8c64f4); reset 0x9371f0 | ld 0x8d86bc; `bad_beacons_detector` 0x8caef0/0x8caf22; `ka_necessity_detector` ×5 |
| +0x28 | `bti_num_tx_bcon` | 1 | stb 0x935dbc `bcon_txss_sweep_step` | ldb 0x8d86b4 |
| +0x29 | `bti_num_rx_bcon` | 1 | stb 0x923c68 `bti_worker_bi2_step` | ldb 0x8d86a0 |
| +0x2a | `bti_rx_bcon_detected` | 1 | stb 0x923c6c; reset 0x9371dc | ldb 0x8d86aa; 0x8e3d16 |
| +0x2b | `bti_reserved` | 1 | — | — |
| +0x2c | `mm_aw.aw_start_time` | 8 | st 0x921dd4 (lo), 0x921db6 (hi) `bi_window_timing_update` | ld 0x8d86e0/0x8d86f4 |
| +0x34 | `aw_duration` | 4 | st 0x921dbe | ld 0x8d86ea |
| +0x38 | `aw_num_backoff` | 1 | stb 0x9285f0 `bi_manager__rx_bi_flow` | ldb 0x8d870c |
| +0x39 | `aw_tx_atim_pass` | 1 | stb 0x92868e | ldb 0x8d8724 |
| +0x3a | `aw_tx_atim_fail` | 1 | stb 0x9286e2 | ldb 0x8d8710 |
| +0x3b | `aw_tx_atim_counter` | 1 | stb 0x93280e `bi_manager__rx_flow_body` | ldb 0x8d871a |
| +0x3c | `aw_rx_atim_pass` | 1 | stb 0x92e784 `rx_flow__handle_frame`, 0x92ec60 `rx_flow__grant_detected` | ldb 0x8d86f8 |
| +0x3d | `aw_consecutive_bcons_atim_fail_vec` | 1 | stb 0x937134 `bi_window_transition_prep` (`bset` по индексу связи при 11 подряд), 0x9371fc; stb 0x935366 `ucode_cmd_0x05_handler` | ldb 0x8d8702; ldb 0x8cb4ee `conn_mgr__foreach_on_boot_done` |
| +0x3e | `aw_reserved[2]` | 2 | — | — |
| +0x40 | `mm_dti.dti_start_time` | 8 | st 0x921e00 (lo), 0x921e04 (hi) | ld 0x8d8728/0x8d873c |
| +0x48 | `dti_duration` | 4 | st 0x921de0 (= BI - bti_dur - aw_dur) | ld 0x8d8732 |
| +0x4c | `dti_nav_accumulator` | 4 | ld/st 0x92a91a `nav_db__update` | ld 0x8d8754; `ld r2,[0x854e2c]` @0x9371f4 (uc) |
| +0x50 | `dti_num_backoff` | 2 | ld/stw 0x932854 `bi_tx_initiator_wrap`; ldw 0x934814 | ldw 0x8d8740 |
| +0x52 | `dti_num_tx_rts` | 2 | ld/stw 0x934bfe `txop_initiator_open_txop_flow` | ldw 0x8d876c |
| +0x54 | `dti_num_rx_cts` | 2 | ld/stw 0x934c50 `tx_initiator_rx_step` | ldw 0x8d8758 |
| +0x56 | `dti_num_rx_dts` | 2 | ld/stw 0x934cae | ldw 0x8d8762 |
| +0x58 | `dti_num_rx_rts` | 2 | ld/stw 0x92ec94 `rx_flow__grant_detected` | ldw 0x8d8784 |
| +0x5a | `dti_num_tx_cts` | 2 | ld/stw 0x92ea24 `rx_flow__post_rx_act3` | ldw 0x8d8770 |
| +0x5c | `dti_num_tx_dts` | 2 | ld/stw 0x9313da `rx__send_response_frame` | ldw 0x8d877a |
| +0x5e | `dti_num_cf_end` | 2 | ld/stw 0x92476c `cf_end__tx_flow` | ldw 0x8d874a |
| +0x60 | `dti_num_ka_initiated_pass` | 1 | ld/stb 0x933c64 `internal_tx_step` | ldb 0x8d879c |
| +0x61 | `dti_num_ka_initiated_fail` | 1 | ld/stb 0x933c8e, 0x933cb8 | ldb 0x8d8788 |
| +0x62 | `dti_num_ftm_responder_pass` | 1 | якоря нет, вендорская аналогия; живое 0 | — |
| +0x63 | `dti_num_ftm_responder_fail` | 1 | якоря нет | — |
| +0x64 | `dti_rx_off_duration` | 4 | ld/st 0x9350d8 `ucode_cmd__rx_on` | ld 0x8d8792 |
| +0x68 | `dti_rx_buffer_full_cnt` u8 + reserved | 4 | якоря нет | — |
| +0x6c | `mm_dbg.dbg_data_1` — «update time» | 4 | st 0x937218 `bi_window_transition_prep` (длительность перестановки окна: `after - before`) | ld 0x8d87ae (лог `[DBG] \| update time %d`) |
| +0x70 | остаток `mm_dbg` | 0xc | якоря нет, живое 0 | — |

**[железо]** `db_size`=0x7c, `bti_duration`=1951, `aw_duration`=1003,
`dti_duration`=99446 (сумма 102400 = BI 100 TU), `rssi`=`snr`=-256 (значение из
0x9371e8/0x9371f0), `tx_bcon`=63, «update time»=5, хвост +0x70..+0x7c нулевой,
за 0x854e5c — посторонние данные.

Особенности раскладки 4.1:
* Секция `mm_dbg` есть — 16 Б на +0x6c, первое слово живое
  (`[DBG] | update time`). Поэтому `mm_dti` = +0x40…+0x6c (0x2c Б).
* `dti_tx_ppdu`/`dti_rx_ppdu`/`dti_num_rx_bcast[9]`/`dti_energy_timeout_events`
  отсутствуют.
* Сдвиг −8 относительно пака 11ad сохраняется и после `dti_num_cf_end`.
* RSSI пишет микрокод (max-трекинг @0x9321b8), а SNR вычисляет прошивка из RSSI
  в `lmac_if__mac_monitor_report` (0x8d8680/0x8d8684) — `snr_valid/snr` в
  опубликованной копии заполняет читатель, а не микрокод.

## Блок статистики 0x857000 (вне dashboard)

`beacon_neighbor` / `beacon_neighbor_aw` лежат не в `g_dbg_dashboard`
(он кончается на 0x854e5c), а в отдельном блоке 0x857000. Поля расшифрованы
по лог-строкам `link_stats_sm.cpp`:

| адрес | поле | производитель | живое |
|---|---|---|---|
| 0x857000 | `KA_cnt` | st 0x933a42 `internal_tx_step` | 2302 |
| 0x857010 | `KA_fail_cnt` | st 0x933d16 | 0 |
| 0x857014 | `beacon_neighbor` | st **0x92fbb4** `rx_nav_bi_step` | 79214 |
| 0x857018 | `beacon_neighbor_aw` | st **0x92fbd0** `rx_nav_bi_step` | 62 |
| 0x857040 | `rx_txop_rts` | st 0x92ecc8 `rx_flow__grant_detected` | 12 |
| 0x857044 | `beacon_nav` | st 0x923f7c `bti_worker__…beacon_sweep_flow` | 0 |
| 0x857048 | `handled_ppdus` | найден только читатель ld 0x8e2c9c | 1834389 |

Единственный читатель пары neighbor — `link_stats__report`, ld 0x8e2cf8 (arg1) и
0x8e2cec (arg2) строки `### LINK STATS:Neighbor Beacon ### beacon_neighbor=%5d
beacon_neighbor_aw=%5d`.

## Замечания
- Цепочку базового регистра при разметке нужно обрывать на `ld rX,[gp,...]`:
  без этого возникают ложные якоря в `tx_initiator_step` (смещения
  +0x4c…+0x64). При переносе разметки на 6.2 это место требует проверки.
  Тот же класс ошибки: одна загрузка константы не доказывает обращение к глобалу.

## Не установлено
- Поля без якоря: `sys_and_calib+0x98` (`iq_mismatch`, **[гипотеза]**),
  `link_lost_cntr`, `active_roles`, `gain_mode`, `direct_rx_out_txop_en`,
  `rs_wip`, `rf_resets`, `dti_num_ftm_responder_*`, `dti_rx_buffer_full_cnt`,
  хвост `mm_dbg` (+0x70).
- Писатель `handled_ppdus` (0x857048).
- Разметка dashboard для 6.2.

## Источники
- [STRUCTS.md](STRUCTS.md) (константа 0x8033d8), [docs/FW-OBJECTS.md](../../docs/FW-OBJECTS.md)
