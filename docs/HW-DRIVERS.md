# Драйверы железа и системные службы

Загрузка прошивки, прерывания, PCIe и питание устройства, энергосбережение,
калибровки, температурная служба, ABIF (baseband ↔ РЧ), board-файл и РЧ-интерфейс,
ToF/FTM/AoA и системные службы fw 4.1.0.1000 и 6.2.0.1000. Уровень описания —
структурный: что есть, где, в каком порядке запускается; побитовые раскладки регистров
сюда не входят (см. [MAC-REGISTERS.md](MAC-REGISTERS.md), `6.2/ref/REGS-62.md`).

Метки доказанности: **[железо]** — проверено на стенде, **[код]** — по листингу,
**[пак]** — по вендорским именам пака 11ad, **[гипотеза]** — не проверено.
Версии: **[4.1]**, **[6.2]**, **[обе]**. Блочные списки 4.1 (все мелкие функции
PCIe, ABIF, PHY, RFC, калибровок) — в [4.1/docs/MISC.md](../4.1/docs/MISC.md); каталоги
блоков 6.2 с соответствиями 4.1 — §12–§14. Планировщик задач — [SCHEDULER.md](SCHEDULER.md).

## 1. Загрузка: `main()` прошивки

`fw_boot__clear_bss` @0x8c165c обнуляет BSS (0x8033cc.., 0x840000..0x84ee7c,
0x857000..0x8572a8, 0x850800..0x852d00) и зовёт `main()`:

| | 4.1 | 6.2 |
|---|---|---|
| функция | `WBE_DRIVER__pcie_boot_init` @0x8e8a1c, 928 Б | `fw_main` @0x8f00dc, 872 Б |

Порядок по лог-строкам `MAIN() …` и вызовам **[код, обе]**:

| # | шаг | вызовы |
|---|---|---|
| 0 | подсистемы, диаг-метка, dashboard | `boot__init_subsystems` @0x8ed000 (читает бит OOB), `boot__install_diag_magic`, `dashboard__init` |
| 1 | BOOT STARTS; MAC_SXD_ERRORS_ISR → уровень 1 | `irq_set_level` |
| 2 | PCIe-шаги загрузки, «Running Full FW» | `pcie_boot_step_a/b` |
| 3 | опознание baseband, пул кадров, operational_if, отладочный mbox | `baseband__identify`, `l2mgr__init_frame_pool`, `l2mgr__init_operational_if`, `mbox__debug_init_flow` |
| 4 | «HW statemachine WA»; режим FPGA | чтение 0x880a3c |
| 5 | LO power, GPIO SDP, маскирование PCIe, strap-бит | `lo_power_gc_ctrl`, `sdp_gpio__boot_init`, `pcie__mask_interrupts`, `boot__read_strap_bit` |
| 6 | прерывания PCIe (PERST assert/deassert, D3, D3→D0), BUG_5382_WA | `set_reg_882670/882684…`, `mac__reset_882680` |
| 7 | SerDes PCIe, «Enable ARC interrupts» | `pcie__serdes_init`, `irq_enable` |
| 8 | счётчики MAC | `boot_fill_addr_tables`, `cnt_handler__clear_all` |
| 9 | RADIO_MGR::init | `l2mgr__init_radio_mgr` |
| 10 | **XTAL → 165 МГц** | `hwm__reset_analog_block` |
| 11 | светодиоды | `led_scheme__init/apply` |
| 12 | PHY | `hwd_phy_init` |
| 13 | RF: интерфейс board-файла, раздел baseband, тип RF, мощность по роли | `marlon_r_if_class__init_board_file_inteface`, `…load_brd_parameters_section`, `rf__identify_type`, `…rf_configure_role_power` |
| 14 | swap IQ («should this be removed?») | `hwd_PHY_STORE_TXRX_SWAP_IQ` |
| 15 | «Forcing production mode en (force root personality)» | `set_reg_880ab8` |
| 16 | LFSR | `user_lfsr__configure` |
| 17 | ошибки DMA (CPL_BAD_EOT, UNSUPPORTED_REQ_CPL) | `hwd_dma__init_881c00` |
| 18 | маски user-прерываний; защита ICCM action-point | `arc_action_point__install_default` |
| 19 | версии; WM_MNGR (пустой), CALIB_MNGR, POWER_MNGR | `fw_boot__log_versions`, `calib_mngr__init_schemes`, `POWER_MNGR__init` |
| 20 | запуск ucode | `lmac_if__ucode_init` |
| 21 | vendor DB и IO-очереди; ID; OTP | `boot__publish_ids`, `otp__log_params` |
| 22 | **SCHEDULER STARTS** — дальше цикл `u_schd` | |

`l2mgr__init` @0x8ed398 **[4.1]** (из шага 3) — OOB-бит, пул MID, детекторы, старт MAC
(`m_bss_mode=1`), подъём MAC, OOB-пулы TX, RX-пул, широковещательные очереди,
**`WMI_READY`** хосту.

**Различие версий [код]:** 25 строк `MAIN()` совпадают дословно и по порядку; отличие
одно — шаг 13: в 4.1 «Perform baseband configurations from board file», в 6.2 «Role power
configurations from board file» (см. [§9.2](#92-загрузка-board-файла-в-рч-marlon_r_if_class)).

Дополнительно в 6.2 **[код]**:
* `boot__install_handler_ptrs` 0x8c18d4 (972 Б, без строк) — заполнение таблиц указателей
  обработчиков при старте; `boot__init_named_object` 0x8f2044;
* `bootloader_version__log` 0x8f8184 — «Boot Loader version = %d.%d.%d»;
* `otp_init` 0x8f6cb0 — печать параметров OTP (seq_num, pcb_id8, silicon_id,
  wilocity_num); в 4.1 те же строки печатает `otp__log_params`.

## 2. Прерывания fw: вектора ARC600 и user-ICR **[обе]**

### 2.1 Таблица векторов **[код]**

Таблица в начале fw_code, по 8 Б на вектор (`j <адрес>`, линковка с 0): 20 записей
(вектора 0–19). Дальше в 4.1 — `b .` (петля на себя, вектора 20–31: срабатывание =
зависание), в 6.2 (`fw_vector_table` 0x8c0000) — нули 0x8c00a0–0x8c011f. Имена
обработчиков 4.1 и 6.2 разные; где тела совпадают, это указано в `6.2/ref/CORRELATION-FW.txt`.

| вектор | 4.1 | 6.2 | назначение |
|---|---|---|---|
| 0 | 0x8c0200 (`cpu_reset_init`) | `cpu_reset_init` 0x8c0120 | сброс |
| 1 | `isr_memory_error` 0x8c13a0 | `fw_vector_01` 0x8c13ec | исключение памяти; 6.2: печатает blink, sp, ilink1/2, фатал |
| 2 | `isr_instruction_error` 0x8c0774 | `fw_vector_02` 0x8c0774 | ошибка инструкции / action point (защита ICCM); 6.2: → `instruction_error__report`, фатал |
| 3 | `isr_timer0` 0x8d6f24 | `isr_timer0` 0x8da014 | таймер 0 |
| 4 | `isr_awake_tsf_led` 0x8c1000 | `fw_vector_04` 0x8c1064 | **user-прерывания от хоста (user-ICR)**: обёртка контекста → `isr_880b50__dispatch_causes` 0x8c161c / 4.1 0x8c15e8 (§2.2) |
| 5 | `isr_txrx_manager` 0x8c1098 | `fw_vector_05` 0x8c10fc | DMA TX/RX (см. [DATAPATH.md](DATAPATH.md), приём); 6.2: обёртка → `txrx_mgr__handle_dma_irq` |
| 6 | `isr_ucode_fault` 0x8c1130 | `fw_vector_06` 0x8c1194 | сбой микрокода. 6.2 **[код]**: ICR MAC 0x886e44 → ack 0x886e40: бит 15 = «Awake TSF interrupt expired» (квитирует `mac_icr__mask_awake_tsf` 0x8e9a90 — пишет 0x8000 в 0x886e50, печатает TSF); иначе **«LMAC CRASH detected»**: печатает код сисассерта ucode и blink из общего блока 0x857014/0x857018, sp/ilink1/ilink2 ucode из 0x886f4c/50/54, взводит флаг и фатал 0x11ac |
| 7 | `isr_timer1` 0x8d6f4c | `fw_vector_07` 0x8da03c | 4.1 — таймер 1; 6.2 — не используется: сохраняет контекст и сразу фатал 0x11ad |
| 8 | `isr_pring_dma` 0x8c126c | `fw_vector_08` 0x8c12b8 | DMA pring; 6.2: обёртка → `pring__isr_dispatch` |
| 9 | `isr_vring_dma` 0x8c1304 | `isr_vring_dma_fw` 0x8c1350 | DMA vring → `vring_schdlr__isr_dispatch` |
| 10 | `isr_icr_887000_mask` 0x8c0824 | `isr_vec10__ack_mac_icr` 0x8c08f0 | ICR 0x887000: блок RGF_ICR 0x88700c (счётчики MAC): читает ICM 0x887014 (`mac_icr__read_cause_887014` 0x8dd8b8 / 4.1 `get_reg_887014` 0x8d9b2c) и пишет его обратно в ICR 0x887010 — только квитирует, не маскирует |
| 11 | `isr_icr_88701c_mask` 0x8c08c4 | `isr_vec11__ack_mac_icr2` 0x8c0990 | ICR 0x88701c: блок RGF_ICR 0x887028: читает ICM 0x887030 (`mac_icr__read_cause_887030` 0x8dd8c4 / 4.1 `get_reg_887030` 0x8d9b38) и квитирует в ICR 0x88702c — только квитирует |
| 12 | `isr_mac_886028` 0x8c0964 | `isr_mac_886028_fw` 0x8c0a30 | MAC/PHY |
| 13 | `isr_pll_unlock` 0x8c0a20 | `fw_vector_13` 0x8c0aec | срыв PLL. 6.2: блок RGF_CAF_ICR 0x88946c — причина из ICM 0x889474, квитирование в ICR 0x889470; бит 2 «PLL5 UNLOCK», бит 7 «FS8 UNLOCK»; каждый — счётчик в gp-области, фатал (0x12ec/0x12ee) только при взведённом байт-флаге политики |
| 14 | `isr_return_only` 0x8c0b2c | `fw_vector_14` 0x8c0be0 | не используется (`j.f [ilink1]`) |
| 15 | `isr_pcie_debug` 0x8c0b30 | `fw_vector_15` 0x8c0be4 | PCIe debug. 6.2: причина `pcie_debug__read_and_ack_cause` 0x8d11b8 / 4.1 `rgf_reg_882680` 0x8ce474 (читает 0x882690, квитирует в 0x88268c); коды 0..3 через `pcie_debug__code_to_index` → `wbe_driver__pcie_debug_isr`, `dpal__cpl_timeout_log`, `pxe__isoc_in_dir_bypass_on` 0x8f7d10 / 4.1 `tail_WBE_DRIVER__pxe_isoc_in_dir_bypass` 0x8ef8fc / `pxe__isoc_in_dir_bypass_off` 0x8f7d18 (хвосты `WBE_DRIVER__pxe_isoc_in_dir_bypass`); неизвестная причина — «UN HANDLED PCIE DEBUG INTERRUPT», фатал 0x11a9 |
| 16 | `isr_pcie_main` 0x8c0c4c | `fw_vector_16` 0x8c0cf4 | PCIe: PERST, D3, L1. 6.2: PERST assert/deassert (ожидание phy_pll_lock, DBI-запись, обход A2 SSID/SSVID), D3 enter/exit → `WBE_DRIVER__link_up/down_notif`, `pcie_device_power_if__pcie_power_pcie_interrupt` **[стр]** |
| 17 | 0x8c0ef0 `j.f [ilink1]` | `fw_vector_17` 0x8c0f60 (`j.f [ilink1]`) | не используется (в 4.1 — хвост перед `isr_pcie_ltssm_dbg`) |
| 18 | `isr_pcie_ltssm_dbg` 0x8c0ef4 | `fw_vector_18` 0x8c0f64 | PCIe LTSSM. 6.2: блок RGF_ICR с ICC 0x882fcc — причина из ICM 0x882fd4, квитирование ICR 0x882fd0; код 0 → `hwd_pcie_l1_enter_isr`, код 1 → `fw_vector_18__pair`; иначе «UN HANDLED», фатал 0x130c. 0x882f80 — слово карты режима питания, а не отладка LTSSM |
| 19 | `isr_nop_pad` 0x8f3b38 | 0x8edcf4 (внутри `fw_vector_19__unused_zero_fill`) | заглушка |
| 20–31 | `b .` | нули | не используются |

Уровни задаёт `irq_set_level` (MAC_SXD_ERRORS_ISR → уровень 1 на шаге 1 загрузки).
Имя 4.1 `isr_awake_tsf_led` неполно — это общий обработчик user-ICR хоста.

`pcie_dbg__rearm_irq_bit3` 0x8fa874 **[6.2]** пишет 8 в 0x88268c (ICR, W1C) и 0x8826a0
(IMC) — квитирует и снова открывает код 3 PCIe-debug (раскладка struct RGF_ICR
драйвера); зовут `mgmt_tx__copy_ie_max96` и `wbe_driver__pcie_debug_isr` **[код]**.

Слоты векторов и обработчики ucode 4.1 — [4.1/docs/MISC.md §9](../4.1/docs/MISC.md#9-вектора-загрузка-лог-аварийный-путь-41).

### 2.2 User-ICR хоста 0x880b50 **[код]**

`isr_880b50__dispatch_causes` 0x8c161c / 4.1 0x8c15e8 (собственно функция — первые 0x70 Б
блока): будит из deep sleep (`POWER_MNGR__deep_sleep_exit(1)`), читает причину
0x880b54 и квитирует в 0x880b50, затем по битам (адреса — 6.2; в 4.1 квитирование
битов 18/19/27 с постановкой задачи через `u_schd__add` делают
`irq_880b60__ack_b18_post_mbox_oper` 0x8cb440, `irq_880b60__ack_b19_post_mbox_dbg`
0x8cb460, `irq_880b60__ack_b27_post_rf_kill` 0x8cb590):

| бит | действие |
|---|---|
| 2 | истёк программный таймер планировщика: `u_schd__timer_irq_pending` 0x8e94f8 → `user_icr__timer_bit` 0x8da00c возвращает `(cause>>2)&1`; при 1 — `u_schd__expire_timers_thunk` 0x8e952c → обработка истёкших таймеров ([SCHEDULER](SCHEDULER.md)) |
| 18 | рабочий почтовый ящик (WMI): `gpio__pulse_880b60_18` 0x8cd724 маскирует бит (0x40000 → 0x880b60) и ставит задачу `mbox__drain_operational` 0x8e378c / 4.1 `mbox__init_operational` 0x8ded20 |
| 19 | отладочный ящик: `gpio__pulse_880b60_19` 0x8cd744 — маска 0x80000, задача `mbox__drain_debug` 0x8e37c8 / 4.1 `mbox__init_debug` 0x8ded5c |
| 9 | `uc_evt__mask_irq_and_defer_drain` 0x8cd864 — маска 0x200, задача `lmac_mbox__drain_task` 0x8ca22c (разбор почтового ящика ucode). Бит 9 — прерывание ucode→fw: ucode взводит его через ICS 0x880b58 в `uc_evt__enqueue`; `lmac_if__ucode_init` открывает маску («Unmask the uCode interrupts») |
| 27 | RF kill: `isr__step_22f70_80044c__8cdbb4` 0x8cdbb4 — маска 0x8000000 (`rf_kill__mask_irq` 0x8c14bc / 4.1 `set_reg_880b00_8c1480` 0x8c1480, тот же приём в `rf_kill_sm__init`), таймерная задача `rf_kill__irq_task` 0x8e2f70 (вход внутри `hwf_rf_check_rf_id`); в 4.1 задача опроса — `rf_kill__poll_and_notify` 0x8de9c0 ([4.1/docs/MISC.md §1](../4.1/docs/MISC.md#1-рч-калибровки-abifphyrfc-board-файл-fw-41)) |
| 4 | Awake TSF LED: `host_irq__mask_awake_tsf` 0x8da810 / 4.1 `set_reg_880b60_8d7718` 0x8d7718 (маска 0x10), печать TSF |

Задачи битов 18/19 — обработчики прерывания ящика (тела не читались **[выз]**; имена в
файлах данных 6.2 — [6.2/docs/MISC-FW.md, приложение А](../6.2/docs/MISC-FW.md#приложение-а-имена-блоков-в-файлах-данных-ref)).

## 3. Подсистемы железа: состав и объём

Байты кода fw 4.1 по группам **[код, 4.1]**:

| группа | Б | что это | опорные места |
|---|---|---|---|
| калибровки `calib*` | 8 144 | менеджер схем + движок коррекций | CALIB_ENGINE, [§6](#6-калибровки) |
| потоки `hwf*` / `hw_flows_*` | 8 140 | сами калибровки и тесты | `hwf_calib_all` @0x8d19b0 («HWF_CALIB_ALL») |
| `hw_drivers_abif` | 7 128 | ABIF — последовательный интерфейс baseband ↔ РЧ-чип; батареи/банки таблиц, VGA | `hwd_abif_rx_table_config_vga_gain`, «battery_index … not legal» |
| `hw_drivers_phy` | 5 188 | PHY: init, swap IQ, отладочный такт (BUG_5661_WA) | `hwd_phy_init`, `hwd_phy_get_rx/tx_swap_iq` |
| `hw_drivers_rfc` | 3 704 | контроллер РЧ: чтение/запись регистров РЧ через ABIF с повторами, секторы и усиление | `hwd_rfc_read_rgf` (перезапуск делителя ABIF при сбое), `hwd_rfc_sector_dist_gain_set`, `rf_sector_commit_rx` |
| `pcie*`, `hw_drivers_pcie` | ≈5 600 | PCIe: SerDes, L0s/L1, PERST, D3, автомат питания устройства | PCIE_DEVICE_POWER_SM (`4.1/ref/SM-TABLES.txt`), `hwd_pcie_l1_enter_isr` |
| `brd_if*` | 2 632 | разбор board-файла (формат multi-array: секции, чанки, шаблоны валидации) | `brd_if_multi_array::find_section/get_chunk` |
| `rf*` | 2 528 | опознание РЧ: **Marlon** или **Falcon**, тест связи, RF_KILL | `rf__identify_type`, «MARLON/FALCON COMM TEST FAILED» |
| `marlon*` | 2 328 | класс РЧ Marlon: канал, антенны (`valid_antennas_vec`), board-файл | `marlon_r_if_class__config_channel` |
| `hwm*` | 688 | аналоговый блок: переключение канала, детектор 33 кГц | «hwm_ANALOG_CHANNEL_SWITCH» |
| `agc*` | 620 | калибровка silent RSSI (индекс усиления РЧ) | |
| `temp*`, `TEMPERATURE_SERVICE` | ≈1 000 | датчики BB/РЧ, калибровка датчика | `TEMPERATURE_SERVICE::radio_locked_cb` |
| `hw_drivers_car`, `_mac`, `led`, `sdp` | ≈1 000 | тактирование/сброс, мелочи MAC, светодиоды, GPIO | |

Объём групп в 6.2 (блоки, установленные по лог-строкам и таблицам) **[код, 6.2]**:
PCIe — 53 блока, 4 220 Б; энергосбережение — 65 блоков, 6 028 Б; системные службы —
25 блоков, 2 648 Б; температура — 9 блоков, 788 Б; board-файл и РЧ-интерфейс —
65 блоков, 10 068 Б; ToF/FTM/AoA — 30 блоков, 2 744 Б.

## 4. PCIe и питание устройства

Устройство одно в обеих версиях: строки блоков 6.2 дословно из 4.1 **[код]**. В 4.1
участвуют шаги 5–7 загрузки ([§1](#1-загрузка-main-прошивки)) и вектора 15–18
([§2](#2-прерывания-fw-вектора-arc600-и-user-icr-обе)).

Автомат PCIE_DEVICE_POWER_SM: 6.2 `pcie_device_power_sm` (5 состояний × 6 событий), по
сравнению с 4.1 нет события PERST_DEASSERT (таблицы — [STATE-MACHINES.md](STATE-MACHINES.md)).

Компоненты (адреса 6.2) **[код]**:
* **Настройка канала под топологию** — узел работает либо прямо на SerDes хоста
  («EP under Serdes»), либо за коммутатором («EP under switch», во многих местах «Not
  supported yet»): `pcie__l1_latency_wa` 0x8ed7b4 (536 Б; задержка входа в L1 = 16 мкс
  для обоих случаев), `pcie__fix_max_read_req` 0x8d1864 (MaxReadReq > 512 Б
  исправляется), `pcie__force_clear_l0s` 0x8d14d4 (L0s принудительно выключается),
  `hwd_pcie_lnkctl_set` 0x8d1828, `hwd_pcie_config_lnkctl` 0x8d17f8,
  `hwd_pcie_l1_sub_timing_config` 0x8d169c (тайминги L1.2), `pcie__l1ss_enable` 0x8d17a0
  («Sparrow PCIe L1SS Support enabled»), `hwd_pcie_l1_pm_sub_ctl_get` 0x8d164c.
* **Режимы питания канала:** `hwd_pcie_exit_l1` 0x8d12ac (выход из L1, контроль PERST),
  `pcie_pm_host_config` 0x8e033c (LnkCtl и `RGF_USER_USAGE_7`), `hwd_pcie__set_low_power`
  0x8d77dc, `hwd_pcie__set_clk_gating` 0x8d0e5c.
* **Питание устройства и хост:** `pcie_device_power_if__init` 0x8d90d8,
  `__pcie_power_pcie_interrupt` 0x8e0470 и `__pcie_power_wake_signal` 0x8e05b4 (сигнал
  Wake хосту), `pcie_device_power_sm__pcie_traffic_resume_req` 0x8e05ec (368 Б).
* **PERST и SerDes:** `pcie_perst_handler_step` 0x8f0d28, `pcie__dbi_read` 0x8c8208,
  `pcie_serdes__init_seq` 0x8f344c.
* **Конфигурационное пространство (DBI):** `pcie__dbi_transfer` 0x8c828c.
* Регистры: 0x8825c0 (последовательности программирования), 0x882644 (ожидание
  готовности), 0x882f80, 0x88b000, 0x880c00.

Блоки 4.1 (WBE-линк с хостом, DBI, L1/LTSSM, halt и такты) —
[4.1/docs/MISC.md §4](../4.1/docs/MISC.md#4-pcie-wbe-режимы-питания-halt-fw-41).

## 5. Энергосбережение (PS/PSC)

Устройство то же в обеих версиях: строки блоков 6.2, кроме одной, дословно известны по
4.1 **[код]**. Автоматы сопоставлены по таблицам переходов:

| 4.1 | 6.2 |
|---|---|
| PS_ASSOC_SM | `ps_sm_801c30` (без события PS_SHALLOW_SLEEP_ENTER) |
| PS_NONASSOC_SM | `ps_sm_801bec` |
| PS_MODE_SM | `sm_801d64` (без ABORT) |
| STA_PSC_SM | `sta_psc_sm` |
| PCP_PSC_SM | `pcp_psc_sm` |
| PCIE_DEVICE_POWER_SM | `pcie_device_power_sm` (без PERST_DEASSERT) |

Компоненты (адреса 6.2) **[код]**:
* **Глубокий сон:** `deep_sleep_enter` 0x8c87c0 (480 Б; проверка выхода из PCIe L1,
  LTSSM/L1SS), `deep_sleep_exit` 0x8c8aa0 (328 Б); **[6.2]** при выходе замеряется время
  загрузки общей конфигурации РЧ («Common RF load time measure start/end/total»);
  `POWER_MNGR__deep_sleep_exit` 0x8c8a34 (причина выхода).
* **Остановка микрокода:** `POWER_MNGR__halt` 0x8c89a0 («halt ucode took %d usec»),
  последовательность `power_halt_seq` 0x8d78cc (500 Б, без строк).
* **Обмен PSC** (802.11ad Power Save Configuration): станция —
  `sta_psc_sm__build_psc_req` 0x8e5b14 (bi_start_time, number_of_awake_bi, sleep_cycle,
  token), `__send_psc_req_flow_sm`, `__psc_req_tx_complete`, `__psc_done_sm`;
  координатор — `pcp_psc_sm__build_psc_resp` 0x8e5c0c, `__send_psc_resp_flow`; вход —
  `psc_if__start_psc` 0x8d9cc8 (PCP шлёт незапрошенный PSC-RESP, STA — запрос), приём —
  `ps_connection__psc_req_rx` 0x8d9d2c; завершение — `PS_CONNECTION__psc_complete_8e1794`
  (dpm, окно бодрствования).
* **Связь PS с соединением:** `PS_CONNECTION__assoc_ntf` 0x8c3cd8,
  `PS_CONNECTION__awake_peer_ntf` 0x8c3f1c (отладочный переход `g_dbg_psc_transition`
  INCREASE/DECREASE_PS), `ps_connection_mgr__on_assoc`, `ps_conn_mgr__notify_all`; окно AW
  соседа — `ps_assoc_mgr__aw_ie_reception` 0x8c3e9c (длительность AW из IE).
* **Профили:** `PS_CFG_SCHEME__switch_active_ps_profile` 0x8e8438 (текущий → следующий
  профиль; задаётся `WMI_PS_DEV_PROFILE_CFG` 0x91c).
* Прочее: `PS_NONASSOC_SM__ps_reenter_done`, `PS_ASSOC_SM__ps_schd_reenter_extend`,
  `power_mngr__load_defaults`, `power_mgr_ut` (отладочные подкоманды).

Блоки PS/PSC 4.1 (fw и ucode) — [4.1/docs/MISC.md §5, §13](../4.1/docs/MISC.md#5-соединение-pspsc-ключи-детекторы-fw-41).

## 6. Калибровки

### 6.1 Загрузочная калибровка `hwf_calib_all`

| | 4.1 | 6.2 |
|---|---|---|
| адрес | 0x8d19b0 | 0x8f448c (500 Б) |

**4.1 [код]:** R-ladder (`hwf_rladder_scan`, `hwf__rladder_calibrate`), LO leakage
(`hwf_calib_lo_leakage_res`, «LO LEAKAGE RESULTS: I=%d Q=%d»), таблица усиления BB
(`hwf_calib_bb_gain_*`), IF gain (`IF_GAIN__GAIN` @0x8d2828, 1360 Б,
`hwf_if_gain_fin_est`), VGA DC (`hwf_vga_dc__calibrate`), SAR (`hwf_calib_sar_alg`);
обвязка `hwf_calib__acquire_hw/release_hw`, петля `hwf_calib__setup_loopback`. Там же
производственные тесты BER (`hwf_PHY_DIG/IF_LOOPBACK_BER_TEST`,
`hwf_phy_production_loopback_test`).

**6.2 [код]:** печатает «Welcome Sparrow D0», затем этапы по порядку:

| # | этап (лог) | вызовы |
|---|---|---|
| 1 | LO_POWER | `temp_sense__get_cached`, `calib_obj__reset_results`, `calib__bits_set32_s20_w12`, `calib_silent_rssi_sparrow__correction_alg` |
| 2 | VGA-DC (LastDAC) | `calib__setup_loopback_hw_b`, `hwf_dc_calib_fix_dac1` @0x8d6948, `calib__log_if_nonzero` |
| 3 | SAR-DC | `calib__setup_loopback_hw`, `hwf_calib_sar_alg` @0x8d60bc, `calib_sar__enable_path` |
| 4 | BB-GAIN | `calib__setup_loopback_rx_path`, `Calib__Measure_VGA_Gains`, `hwf_calib__release_hw` |
| 5 | VGA-DC | `calib_vga_gain_step` @0x8d66cc, ABIF 0x88a200, `calib_lo_power_measure` @0x8d6ca0 |
| 6 | IF-GAIN | `calib_corr__estimate_and_apply_rx_gain`, `if_gain`, `hwf_calib__restore_path` |
| 7 | SILENT-RSSI (или «SILENT-RSSI IS DISABLED») | `rf_cfg__get_rf_mask_45e`, `calib_silent_rssi_sparrow__correction_alg` |
| — | итог | «CALIBRATION FLOWS:: HWF_CALIB_ALL took %d usec» |

Этапы SAR, VGA-DC, IF-GAIN, LO одинаковы по составу в обеих версиях; **только в 6.2** —
SILENT-RSSI (отключаемый) и явный LO_POWER с учётом температуры.

### 6.2 Фоновые калибровки: CALIB_MNGR и CALIB_ENGINE

**[обе]** Менеджер схем CALIB_MNGR и движок коррекций CALIB_ENGINE. Автомат
CALIB_ENGINE (`4.1/ref/SM-TABLES.txt` стр. 393; 6.2 — `sm_802234`, 6 событий ×
4 состояния, таблица та же): IDLE → CHECK_CORRECTION_NEEDED → (EVT_LOCK_RADIO →
WAIT_FOR_RADIO_LOCK) → CORRECTION → фрагмент готов → снова проверка → EVT_CALIB_DONE →
IDLE.

Обработчики переходов CALIB_ENGINE 6.2 (по таблице `sm_802234`) **[код]**:

| блок | переход | имя |
|---|---|---|
| 0x8c562c | EVT_CALIB_DONE в CHECK_CORRECTION_NEEDED → IDLE | `calib_engine__on_calib_done` |
| 0x8c5f78 | EVT_FRAG_DONE в CORRECTION → CHECK_CORRECTION_NEEDED | `calib_engine__on_frag_done` |
| 0x8c75c0 | EVT_READY_FOR_CORRECTION → CORRECTION | `calib_engine__on_ready_for_correction` |
| 0x8c9d2c | EVT_START в IDLE → CHECK_CORRECTION_NEEDED | `calib_engine__on_start` |
| 0x8dca54 | EVT_LOCK_RADIO → WAIT_FOR_RADIO_LOCK | `calib_engine__on_lock_radio` |
| 0x8c1d74 | EVT_ABORT → IDLE | `calib_engine__on_abort` |

**4.1 [код]:** `calib_mngr__init_schemes` @0x8d579c, планирование шагов
`calib_mngr__schedule_scheme_step`. Условия «нужна ли коррекция» —
`class_calib_lo_power::check_online_estimation_condition`,
`calib_bb_gain_dc::check_online_estimation_condition` (видны в живом логе **[железо]**).
Реакция на смену состояния системы — `CALIB_MNGR__system_state_evt_handler` (в логе:
`CALIB_SYSTEM_STATE_ASSOCIATED`). Классы калибровок с таблицами виртуальных методов и
прочие блоки менеджера — [4.1/docs/MISC.md §1](../4.1/docs/MISC.md#1-рч-калибровки-abifphyrfc-board-файл-fw-41).

**6.2 [код]:**
* менеджер: `calib_mngr__engine_start` @0x8ca25c («Engine of %s is already active»),
  `calib_mngr__engine_step` @0x8e79c0 → `basic_sm__handle_event`,
  `calib_mngr__schedule_scheme_step` @0x8e498c, `calib_mngr__restart_scheme` @0x8e4a94,
  `calib_engine__schedule_all_schemes`. Схема по индексу — `calib_cfg__get_scheme`
  @0x8cc6bc (таблицы 0x800fa8/0x800e2c);
* `CALIB_MNGR__system_state_evt_handler` @0x8e8688: пересчёт по состоянию системы и
  режиму PCP/AP; события **SYS_STATE_EVT_PAUSE_CALIBS / RESUME_CALIBS** перезапускают
  схему; колбэк смены канала;
* **когда нужна коррекция** — `basic_calib_sparrow__estimation_alg` @0x8c9da0 (1212 Б):
  «correction NEEDED» по трём причинам — **температура BB**, **температура РЧ-модуля
  [n]**, **онлайн-оценка**; выбор режима LO power по температуре —
  `class_calib_lo_power__change_state_by_temperature` @0x8c5c68: TEMPERATURE_LOW / ROOM /
  HIGH. Пороговая классификация — `calib__classify_by_thresholds` @0x8e2d5c.

Новые в 6.2 классы `calib_silent_rssi_sparrow`, `basic_calib_sparrow` — около 4 КБ кода.

### 6.3 Silent RSSI [6.2]

Цель — выставить стартовый индекс AGC и усиление РЧ так, чтобы измеренный «тихий» RSSI
совпал с целевым **[код, по лог-строкам]**:
* `calib_silent_rssi_sparrow__run_calibration_fragment` @0x8e3864 — работа фрагментами
  («total_frags=%d», «Last fragment»), время на модуль («calibrate_single_rf_module_gain()
  took %d usec»), затем baseband;
* `calib_silent_rssi_sparrow__find_agc_start` @0x8ca5e8 — подбор `agc_start_index` в
  пределах, «final_measured_rssi / final_error», исход «did not converge»; регистры PHY
  0x883100/0x883700;
* `calib_silent_rssi_sparrow__find_rf_gain` @0x8ca8fc — усиление РЧ RX,
  `update_rf_xx_gains_tables`;
* `calibrate_baseband_gain` @0x8c5708 — «Trigger AGC Calibration, Omni RF / ALL»,
  регистры 0x889080/0x889480.

**Включатели [код + железо]:**
* загрузочный этап 7 `hwf_calib_all` идёт только при **байте `[gp+0x9d]` = 0x80020d == 1**
  (иначе «SILENT-RSSI IS DISABLED»), затем нужен ненулевой **`[0x8042c8+0x468]`**.
  На стенде на обоих узлах: слово 0x80020c = `40 00 ff ff` (байт 0x80020d = 0 → этап
  выключен), `[0x8042c8+0x468]` = 0; в образе слово нулевое;
* после ассоциации STA печатает «Running FULL Silent RSSI Calibration» — это путь
  онлайн-оценки (`basic_calib_sparrow__estimation_alg` → «correction NEEDED - ONLINE
  Estimation»), а не загрузочный этап;
* `[0x8042c8+0x45e]` (`rf_cfg__get_rf_mask_45e`, 20 читателей) = 1 — маска РЧ-модулей, не
  выключатель.

Silent RSSI 4.1 (`agc_start_index`, гистограмма RSSI) — [4.1/docs/MISC.md §1](../4.1/docs/MISC.md#1-рч-калибровки-abifphyrfc-board-файл-fw-41).

### 6.4 Battery и XPM

* «Battery» **[6.2]** — `calib_battery_phy_step` @0x8d6b2c: четыре прохода
  `hwd_abif_battery_config` + `calib_battery__prepare`, разность `calib__delta__8d6c7c`.
  Батареи — банки таблиц ABIF ([§8](#8-abif-интерфейс-baseband--рч)).
* **XPM** — энергонезависимая память РЧ-чипа **[6.2]**: `hwf_rf_xpm_enter_cfg_mode`,
  `_read_byte/_read_block`, `_program_byte`, `_cfg_get/_cfg_set`, проверки аргументов
  (0x8f46f4..0x8f4c28). Это же — WMI 0x856/0x857: в 4.1 `OTP_READ/WRITE`, в 6.2
  `RF_XPM_READ/WRITE` ([WMI.md](WMI.md)). Контроль программирования —
  `hwd_rfc_xpm_get_write_status` ([§9.3](#93-контроллер-рч-hwd_rfc)). Путь OTP 4.1 —
  [4.1/docs/MISC.md §1](../4.1/docs/MISC.md#1-рч-калибровки-abifphyrfc-board-файл-fw-41).

## 7. Температурная служба

Устройство одинаково в обеих версиях **[код]** (адреса 6.2):
* периодический замер: `TEMPERATURE_SERVICE__timer_exp_handler` 0x8e9438 — по таймеру
  ставит замер в очередь; при `m_temp_enabled = FALSE` — ничего, при уже запланированном —
  отказ («unable to schedule temp measurement»). Строка про выключенную службу есть только
  в 6.2;
* чтение и проверка — `temp_sense__read_and_check` 0x8e7828; реакция на состояние
  системы — `temp_sense__on_system_state` 0x8e890c; остановка — `temp_sense__stop`
  0x8e7ea4;
* без РЧ-модуля: `temp_sense__no_rf` 0x8e221c («NO RF on current platform»),
  `temp_sense__prepare_no_rf` 0x8d7014;
* калибровочные параметры датчиков: `…read_rf_sensor_calibration_parameters` 0x8e2274
  (РЧ, «RF not calibrated»), `…consume_bb_sensor_calibration_parameters` 0x8c73f0 (BB:
  Tamb, начальная температура, шаг Q13).

Связи:
* температура запускает коррекции калибровок ([§6.2](#62-фоновые-калибровки-calib_mngr-и-calib_engine):
  причины «BB temperature», «RF[n] temperature»; режимы LO power LOW/ROOM/HIGH);
* датчик и bandgap программируются через ABIF 0x889300 (`sensor_measure_start`,
  `sensor_set_thermal_mode`, `sensor_set_bgp_params`, [§8](#8-abif-интерфейс-baseband--рч));
* WMI: `WMI_TEMP_SENSE` 0x80e (в 6.2 ветка диспетчера без строки лога).

Блоки 4.1 (`TEMPERATURE_SERVICE__radio_locked_cb`, `temp_sense__*`) — [4.1/docs/MISC.md §1](../4.1/docs/MISC.md#1-рч-калибровки-abifphyrfc-board-файл-fw-41).

### 7.1 Окно глухоты приёма при замере [железо, 4.1]

Температурная служба и фоновые калибровки берут радио **вторичным захватом**. В живом
логе стенда периодически идёт `RADIO_MGR::lock_secondary [tune=0, channelId=65535]` →
`RX_OFF` → `Temperatures: BaseBand=… RF=…` → `unlock` → `SWITCH_2_PRIMARY` → `RX_ON`.
Узел регулярно выключает приём на время измерения; для расписания без координатора это
окно глухоты.

Длительность по TSF в логах прошивки: RX_OFF_RSP → RX_ON_RSP ≈ **140 мкс** (139/140/141 в
трёх логах) плюс ≈ 33 мкс на возврат к основному каналу. Период не измерен: в кольцо лога
(~1,5 с) попадает одно событие. Температурные режимы и паузы калибровок 6.2 влияют на те
же окна.

## 8. ABIF: интерфейс baseband ↔ РЧ

ABIF — последовательный интерфейс baseband ↔ РЧ-чип; таблицы TX/RX, батареи (банки
таблиц), VGA. В 4.1 — группа `hw_drivers_abif`, 7 128 Б ([§3](#3-подсистемы-железа-состав-и-объём)).

### 8.1 Метод

Блоки ABIF почти без лог-строк. Роль каждого установлена через отладочный диспетчер
`UT_HW_DRIVERS_cmd_handler` (таблица «код → функция», [6.2/docs/UT-DRIVERS.md](../6.2/docs/UT-DRIVERS.md))
и перечисление `WMI_UT_MODULE_DRIVERS_CMD` пака 11ad **[пак]**. Для диапазона ABIF
(коды 0x101–0x171) соответствие подтверждено двумя независимыми способами:
1. функции со своими строками совпали с именем пака точно:
   `hwd_abif_rx_table_config_vga_gain` = 0x118, `hwd_abif_rx_table_read_vga_gain` = 0x145,
   `hwd_abif_battery_config` = 0x144;
2. имена пака согласуются с блоком регистров, который трогает функция.

Вне этого диапазона нумерация пака 11ad и Sparrow расходится (PHY 0x42c/0x42e, RFC
0x51c–0x51e) — там имена переносить нельзя.

### 8.2 Карта блоков регистров ABIF [6.2]

| регистры | назначение (имена пака) | функции 6.2 |
|---|---|---|
| 0x88a000/0x88a004 | **таблица TX**: `tx_table_config_dac_fssel`, `_iftx_ctrl`, `_iftx_gain`, `_lo_leak_ctrl`, `_lo_leak_gain`, `_tx_mixer_gate_ctrl`, `_xif_ctrl`, `_xif_gain`; `tx_table_force_reload`, `tx_table_index_force_mode`, `txrx_table_index_lpbk_mode` | 11 блоков, 780 Б |
| 0x88a200/0x88a208 | **таблица RX**: `rx_table_config/read_` пары для `vga_dc`, `vga_bias`, `vga_atten`, `vga_stg1_fine_bias`, `ifrx_ctrl/gain`, `vga_dc_dac_pwdn`; `read_row`/`write_row`; `rx_table_force_reload`, `rx_table_index_force_mode`; `rx_rgf_sar_dc_load`, `sar_dc_config_rgf_mode` | 17 блоков, 1 348 Б |
| 0x88a608 | `rx_table_config_sar_dc` | 1 |
| 0x88ae00 | питание CAF: `caf_pwdn_mode`, `rx_prepare_ifrx_pwdn`, `rx_prepare_rvga_pwdn` | 3 |
| 0x88af00 | `bgap_bias_init` | 1 |
| 0x88af10 | **SAR DC**: `rx_rgf_config/read/update_sar_dc` | 3 |
| 0x88af30 | `rx_rgf_config_sar_gain` | 1 |
| 0x88af80 | CAF и генераторы: `caf_lpbk_mode`, `caf_phy_control_mode`, `rosc_ctrl`, `xtal_ctrl` | 4 из 7 |
| 0x889300 | **датчик температуры и bandgap**: `bgap_ctrl`, `sensor_measure_start`, `sensor_set_bgp_params`, `sensor_set_thermal_mode` | 4 |
| 0x889400 | `rfc_clk_ctrl` (это бит 3 регистра управления синтезатором 0x88941c, не отдельный регистр) | 1 |
| 0x889480 | DVS: `dvs_if_splitter_enable`, `dvs_rfca_config_en` — поля регистра RF_STATE_REG 0x889488; сам 0x889480 — IMS блока RGF_CAF_ICR 0x88946c (маска прерываний PLL5/FS8), см. `6.2/ref/REGS-62.md` | 2 из 5 |
| прочие | `battery_config` (банки таблиц), `fs_off`, `pll_ctrl` (включение аналоговой части), `rx_table_all_vgas_dacs_config`, `rx_table_all_vgas_gain_config_n_force` | |

Отдельные функции со строками **[код, 6.2]**: `hwd_abif__fs_on` 0x8cea38 и
`abif__power_up_analog` 0x8cec90 (ожидания готовности), `hwd_abif__out_to_bump_ctl`
0x8cebdc — подкоманда `ABIF_OUT_TO_BUMP_CTL` (вывод на контакт, режимы), есть только в 6.2.

Связь с калибровками: LO leakage пишет в TX-таблицу 0x88a004, VGA/SAR DC — в RX-таблицу и
SAR-регистры, «battery» — в банки таблиц. Блоки ABIF 4.1 (регистровые обёртки,
UT-команды 0x1xx) — [4.1/docs/MISC.md §1](../4.1/docs/MISC.md#1-рч-калибровки-abifphyrfc-board-файл-fw-41).

## 9. Board-файл и РЧ-интерфейс

### 9.1 Board-файл (`brd_if_multi_array`) [обе]

Формат multi-array: секции с шаблонами проверки, блоки, чанки двух форматов («data only» и
«address/data pairs»). Строки в 6.2 дословно как в 4.1. Блоки 6.2 **[код]**:
`brd_if_multi_array__init` 0x8d8fe4 (размер файла против буфера), `__find_section`
0x8caab8, `__get_block_info` 0x8cb940, `__get_section_info` 0x8ccb84, `__get_chunk`
0x8ca760 / 0x8cbbc4, `__get_chunk_in_data_only_format` 0x8cbd80,
`__get_chunk_in_address_data_pairs_format` 0x8cbcd8, `brd_if__parse_chunk_header`
0x8c7444. Блоки 4.1 (проверка секций, печать заголовков, `map_tx_sectors`) —
[4.1/docs/MISC.md §1](../4.1/docs/MISC.md#1-рч-калибровки-abifphyrfc-board-файл-fw-41).

### 9.2 Загрузка board-файла в РЧ (`marlon_r_if_class`)

Адреса 6.2 **[код]**: `__init_board_file_interface` 0x8f5700 (484 Б) →
`__load_brd_parameters_section` 0x8dc690 («BRD Section Write to RF», пары
idx/address/value) и `__load_brd_rf_cfg_section` 0x8dc830; мощность по роли —
`__rf_configure_role_power` 0x8e2e88 (секция COMMON). Это шаг 13 `main()` — единственный
шаг загрузки, отличающийся от 4.1 («Role power configurations»). Запись с повторами
блоков — `__rf_write_with_block_retries` 0x8e3418.

### 9.3 Контроллер РЧ (`hwd_rfc`)

**[обе]** (адреса 6.2): запись ядра с проверкой занятости (`hwd_rfc_write_core_fw`
0x8d415c), запись с проверкой чтением и повторами (`hwd_rfc_write_verify` 0x8d4468),
мощность TX (`hwd_rfc_tx_power_cfg` 0x8d4070), программирование секторов
(`hwd_rfc_sector_edge_gain_set` 0x8d39f8, `_edge_phase_set` 0x8d3c04, `_x16_state_set`
0x8d3da0, чтение `rfc_read_sector_params` 0x8d3678).

**Только 6.2** (строк нет в 4.1) **[код]**:
* `hwd_rfc_read_calibrate` 0x8f3f7c (560 Б) — чтение калибровки РЧ по запросу с числом
  итераций и отметкой TSF; `hwd_rfc_read_handle_driver_input` 0x8f41c8 — значение RDAC,
  заданное драйвером;
* `hwd_rfc_powerup_deep_all_rfs_fw` 0x8d34c0 — глубокое включение всех РЧ-модулей с
  таймаутом;
* `rf__restore_if_needed` 0x8e2acc — «Restore RF was needed»;
* `rf_utils_auto_fill` 0x8e3060 (520 Б) — механизм auto-fill РЧ (флаг AUTO_FILL_BUSY по
  маске модулей);
* `hwd_rfc_xpm_get_write_status` 0x8d4564 — контроль программирования XPM ([§6.4](#64-battery-и-xpm)).

### 9.4 Маска RF-контроллеров для команд [код, 6.2]

`rgf_889080_889480__8ce910(mask, *old)` = `hwd_abif_dvs_rfca_cmd_enable` (UT-подкоманда
драйверов **0x158**, [6.2/docs/UT-DRIVERS.md](../6.2/docs/UT-DRIVERS.md)):
* ждёт снятия **бита 29 регистра 0x8890cc** («RFC занят»), до 200 000 итераций, иначе
  «DO_WHILE_WITH_MAX_ITER OCCUR» и фатал;
* **0x889488 биты 8..15 — маска RF-контроллеров, принимающих команды** (RFCA cmd enable);
  старая маска возвращается через `*old`, новая пишется, если отличается (маска > 0xff —
  фатал).

Вызывается перед адресной записью в РЧ: `handle_omni_sector_info`, калибровки (silent
RSSI, baseband gain), датчик температуры, powerup/powerdown deep. Драйвер RouterOS (эпоха
6.2) при старте запрашивает маску присутствующих РЧ (`WMI_UNIT_TEST` модуль 9, подтип
0xa01, ответ +8 в событии 0x1900) и шлёт модуль 0xc подтип 0x158 с этой маской (0 → 1);
mainline-драйвер этого не делает.

### 9.5 Опознание РЧ

`rf_comm_test` 0x8c6a40 (6.2) — тест связи с РЧ-чипом. В 4.1 — «MARLON/FALCON COMM TEST
FAILED» (РЧ Marlon или Falcon); в 6.2 кроме «MARLON COMM TEST FAILED» есть **«SPARROW-R
COMM TEST FAILED»** — поддержан ещё один тип РЧ **[код]**. Перечисление типов в паке
11ad — `rf_type_e` ([VENDOR-ENUMS.md](VENDOR-ENUMS.md)).

### 9.6 Секции секторов в board `wap60g-60deg` и их обработка драйвером RouterOS

**[код: board + wil6210.ko RouterOS 6.46.4; железо]**

* Используемый `wap60g-60deg` (e354b600, 3576 Б) — board из RouterOS 6.46.4 (эпоха 6.2):
  запись данных `02000000 b40d0000`, адрес **0x917800**, 3504 Б, совпадает побайтово;
  файл 0126 добавляет только заголовок. Board из 6.42.1 (эпоха 4.1) отличается 20 байтами и
  на 12 длиннее.
* Секции внутри данных: `<ключ><ключ><заголовок><тело>`, ключи `0xB000900D` (регистры РЧ,
  см. `SparRAW-docs/research/BRD-RF-REGS.md`), **`0xC00C900E` — RX-сектора (omni)**,
  **`0xC00C900D` — TX-сектора**. Число записей = `((заголовок >> 8) & 0xfff) / 6`; перед
  записями одно слово (RX 0x2000, TX 0x1000); запись = 6 слов = `wmi_rf_sector_info`
  (psh_hi, psh_lo, etype0..2, dtype_swch_off), 24 Б у Sparrow (32 у wil6436). В файле:
  смещения секций 1984 (RX, 1 запись) и 2024 (TX, 64 записи).
* **Omni RX-сектор** = `0, 0, 0x20, 0x20, 0x11000038, 0x20` — фазы нулевые, включены
  единичные элементы (слабый quasi-omni). TX-сектора — все элементы (`etype =
  0xffffffff…`).
* **Драйвер RouterOS 6.46/6.49** (в 6.42 этого нет) ищет обе секции в копии board
  (`could not find rx/tx sector section in brd`), сохраняет исходные omni-записи и при
  каждом цикле поиска («scan cycle») переписывает их: исходные / копия случайного
  TX-сектора («use tx sector») / последний удачный RX-сектор, считанный по
  `WMI_UNIT_TEST` «rfc read sector» («use last successful»), затем перегружает прошивку с
  новым board.
* **Геометрия секторов — из `wil6210-wap60g-60deg.msg`** (RouterOS, записи `12 00 4d 32 |
  01000008 <az> | 02000008 <el>`, единица 0,01°): 64 TX-сектора = сетка 8×8, сектор n:
  азимут = +26,6° − 7,6°·(n mod 8), угол места = −26,6° + 7,6°·(n div 8). Центральные —
  **27, 28, 35, 36** (±3,8°); 0, 7, 56, 63 — углы. Нумерация совпадает с индексами
  TX-секции board и с «TX Sector» в логе прошивки **[гипотеза: STA на соосной паре выбирает
  30/31/35]**.
* **Опыт на 6.2↔6.2 [железо]:** omni = TX-сектор к соседу (AP 5, STA 39 — оба краевые, т. е.
  выбор сектора неудачен) — линк держится, но 96 % потерь, выбор лучей меняется (AP 20,
  STA 30). Штатный omni лучше; сам по себе этот механизм нестабильность линка 6.2 не
  устраняет.

### 9.7 DMG Capabilities: сколько секторов и антенн объявляет узел [код + железо]

Поле DMG STA Capability Info собирают:

| | 4.1 | 6.2 |
|---|---|---|
| функция | `l2mgr__build_mac_config` 0x8e17xx | `dmg_cap__build_sta_capability` 0x8e6598 |
| Number of RX DMG Antennas | **константа 1** (→ 2 антенны, `bf_u16…` @0x8e8264 с r1=1) | 0 (→ 1) |
| Total Number of Sectors | **константа 0x22** (→ 35, `bf_u16_s7_w7` с r1=0x22) | `rf_if__num_tx_sectors(0x8042c8) − 1` (`bits__set16_s7_w7`) |
| зависимость от board | нет | число записей TX-секции |

`rf_if__num_tx_sectors` 0x8cb7e8 — виртуальный вызов: `obj = [0x8042c8+0x58]`
(= 0x8042cc), метод `[[obj+0x44]+0x18]` (в vtable — смещение от 0x8c0000, живьём 0xb7f0 →
`0x8cb7f0`: `ldb r0,[r0,0x40]`). Объект 0x8042cc — **список TX-секторов из board**:
байты 0…N−1 и число N в +0x40; живьём `00 01 … 3f`, N = 0x40 = 64. Заполняет
`marlon_r_if_class__init_board_file_interface`.

6.2 объявляет столько секторов, сколько записей в TX-секции board (`wap60g-60deg` — 64),
4.1 — зашитые 35 и 2 RX-антенны. ФАР модуля — 6×6 = 36 элементов; годных по board — 32
(`valid_antennas_count` в логе 4.1). От объявленного числа секторов соседа 6.2 считает окно
ожидания RSS ([BF-ENGINE.md](BF-ENGINE.md)).

### 9.8 Число секторов 6.2 и его задание через board [код + железо]

`brd_if__build_tx_sector_list` 0x8ddbbc зовётся из
`marlon_r_if_class__init_board_file_interface` после разбора board (буфер 0x84f800, до
9 КБ). Список объекта `brd_if` (0x8042cc, байты +0x00…) заранее заполнен 0xff; через метод
`brd_if` берётся секция типа 3 (TX-сектора) и её **блоки** из заголовка multi-array; для
каждого блока (по числу RF-цепочек, k-й взведённый бит маски РЧ) записи по 6 слов
проходятся, и индекс записи добавляется в список, если запись ненулевая и её слот ещё 0xff;
счётчик — байт +0x40 (`add3 r18,r13,8`; 0 — фатал 0x1562). Счётчик отдаёт
`rf_if__num_tx_sectors` → DMG Capabilities, `lmac_if_config_txss`, окно RSS.

Заголовок multi-array `wap60g-60deg` описывает TX-таблицу **четырьмя блоками** `(смещение
0x798, длина 0xc2 строк по 8 Б = 16 + 64·24)`. **Прошивка сама дополняет список
тождественными индексами до длины секции из её заголовка**: число секторов 6.2 = длина
TX-секции (поле `(hdr >> 8) & 0xfff` / 6), ненулевые записи определяют лишь порядок первых
позиций. **Записи TX-секции привязаны к позиции**: перенос AWV в другой слот ломает луч
(вероятно, у РЧ-чипа есть посекторные данные по индексу слота) **[железо]**. Поэтому
центральные 35 (позиции 9–53) через board получить нельзя: либо длина ≥ 54 с «мёртвыми»
слотами, либо первые N позиций. Рабочий способ задать число — укоротить секцию (вариант
`first35`).

Варианты board на стенде (оба узла перезагружены перед опытом) **[железо]**:

| вариант | изменение | итог |
|---|---|---|
| обнуление 29 из 64 записей | записи обнулены, заголовок не тронут | счётчик `+0x40 = 64`, список `09 0a … 35 23 24 … 3f`; в ucode порядок станции 0 начинается с `09 0a 0b 0c`, 64 кадра |
| `wil6210-wap60g-60deg-35s.brd` (md5 0b899462…, CRC 0x14db1968) | 35 центральных AWV перенесены в начало секции; длина секции `0xfd118000 → 0xfd10d200` (35·6 слов); длина четырёх блоков `0xc2 → 0x6b` (16 + 35·24 = 856 Б); хвост обнулён, размер файла тот же. Набор: строки 1–6 × столбцы 1–6 сетки 8×8 без сектора 54 (±19°), новый порядок 0…34 = прежние 9–14, 17–22, 25–30, 33–38, 41–46, 49–53 | счётчик 35, ucode развёртывает 35 кадров, **линк не поднимается**: станция за 10 с видит 100 преамбул CP и ни одного годного заголовка (со штатным board ~600 годных в секунду) |
| `wil6210-wap60g-60deg-first35.brd` (CRC 0x61e2cfd2) | первые 35 записей без перестановки | счётчик 35, ucode 35 кадров, станция подключается, ~285 годных CP-кадров в секунду (≈ 35 кадров маяка × 10 BI). Геометрия — строки 0–4 сетки (угол места −26,6…+3,8°). Окна по 30 с (`bfmeasure.sh`): AP `4:11` **0** / 1 689 (штатный board — 3 176 / 3 821), пинг 6 %/0 % и 20 %/100 %; линк нестабилен, нужна серия |
| `…-center35.brd` (md5 0e8b7b8b…) | штатная таблица 64, 29 нецентральных записей обнулены, TX-блоки 2–4 заголовка перенаправлены на RX-секцию `(0x770, 5)` | снова `+0x40 = 64`, список `09 … 35` + тождественные `23 … 3f` |

RX-антенна и RF-модуль и так одни (6.2 объявляет 1 RX-антенну, маска РЧ = 1).

## 10. Измерение расстояния и угла: ToF/FTM/AoA [6.2]

Подсистема есть только в 6.2 — ни одна её строка в 4.1 не встречается **[код]**.

### 10.1 Команды и события хоста

WMI (номера — [WMI.md](WMI.md)): `WMI_TOF_SESSION_START` 0x991, `_GET_CAPABILITIES` 0x992,
`_SET_LCR` 0x993, `_SET_LCI` 0x994, `_CHANNEL_INFO` 0x995, `_CFG_RESPONDER` 0x996,
`_SET/GET_TX_RX_OFFSET` 0x997/0x998, `WMI_AOA_MEAS` 0x923. События: `WMI_TOF_SESSION_END`
0x1991, `WMI_TOF_FTM_PER_DEST_RES` 0x1995, `WMI_AOA_MEAS` 0x1923 (отправители —
`tof_mgr__*`, `state_sm_803424__*`). Смещение TX/RX для ToF читается и из регистра
0x889548 (UT-код 0x438 `hwd_phy_tof_get_tx_rx_offset`, [6.2/docs/UT-DRIVERS.md](../6.2/docs/UT-DRIVERS.md)).

### 10.2 Управление — `tof_mgr` / `ftm_mngr`

* `tof_mgr` 0x8c382c: завершение AoA и FTM запросов; `tof_mgr__ftm_req_handle` 0x8c38e8 —
  приём запроса AoA/FTM (число адресатов); `__ftm_req_done` 0x8cb2bc; `__clean_all_lists`
  0x8c661c (список ожидания FTM).
* `aoa__validate_request` 0x8e9680 — число адресатов и измерений против возможностей.
* `tof__find_session_by_addr` 0x8e1df8 — сеанс по MAC соседа; `ftm_mngr` 0x8c2a30 —
  «can't add FTM session».

### 10.3 Автоматы

**Главный FTM** — `state_sm_8034c0` (5 состояний × 8 событий) **[код]**: STATE_IDLE →
(EVT_FTM_DO_TUNNING / RADIO_ALLOCATE) → STATE_ALLOCATE_RADIO → (EVT_FTM_RADIO_ALLOCATED) →
STATE_TUNNING → (EVT_FTM_CHANNEL_TUNED) → STATE_TUNED → (EVT_FTM_LINK_REQ) → STATE_LINK;
EVT_FTM_ABORT и EVT_FTM_ALL_SESSIONS_DONE → IDLE. Обработчики:
`ftm_main_sm__radio_allocated_cb` 0x8f7f38, `__action_pop_ch_and_tune` 0x8f080c,
`__action_radio_tunned` 0x8f088c, `__action_link_acquisition` 0x8f0780 («connection not
allocated» при отказе), `__action_abort_session` 0x8f0568. Радио берётся, как у скана и
калибровок, через радио-менеджер; связь для измерения — тем же захватом соединения, что у
остальных потоков.

**Сеанс FTM** — `state_sm_803424` (3 состояния × 9 событий): STATE_READY →
(EVT_FTM_SESSION_STARTED) → STATE_BURST → (EVT_FTM_SESSION_NEXT_REQ) → STATE_WAIT;
EVT_FTM_SESSION_DONE → READY; START/TO/ABORT → READY с отменой (`action_abort()` /
`action_abort_burst()` с кодом статуса). Обработчики — блоки `state_sm_803424__action_*`
0x8f0500..0x8f0a20; «not valid FTM request», «frame buffer allocate fail»,
`action_burst_fail()`.

## 11. Системные службы

### 11.1 Планировщик `u_schd`

Планировщик задач и главный цикл — [SCHEDULER.md](SCHEDULER.md).

### 11.2 sysapi — запросы статистики с хоста [6.2]

Менеджер `fw_sysapi_mgr` (строк нет в 4.1) **[код]**:
* `__start_sysapi_cmd` 0x8f9a20 / `__stop_sysapi_cmd` 0x8f9bd0 — один запрос за раз
  («Rejecting sysapi request since prev…», «sysapi id = %d is not pending»);
* `__complete_pending_request` 0x8f1c50 — вызов колбэка завершения;
* `__get_rssi_and_snr_statistics` 0x8f3780 (332 Б) — RSSI/SNR по индексам ADC, строка AGC,
  «нулевая» строка;
* `__get_flush_statistics_cmd_start` 0x8f34fc;
* заполнение ответа — `fw_sysapi__zero_and_fill`, `fw_sysapi__fill_at_3c`.

Перечисление типов запросов — `request_type_e` (`FW_SYSAPI_REQUEST_*`: ENERGY_STATISTICS,
PLCP, RX_GET_PKT_DATA, PHY_RX_STATISTICS) в [VENDOR-ENUMS.md](VENDOR-ENUMS.md) **[пак]**.

### 11.3 Аварийные дампы (sysassert) [6.2]

* `sysassert__dump_ucode_stack` 0x8c9ad0 — дамп стека микрокода;
* `sysassert__dump_ucode_int6` 0x8c9ce0 — «ucode WatchDog!!!!!», частота ложных
  срабатываний до и после;
* `sysassert__wmi_lock_notice` 0x8c9c58 — после ассерта команды WMI блокируются («change
  g_sysassert_wmi_lock to FALSE»);
* `sysassert__log_1003a68` 0x8e866c — «send interrupt to host» (нет в 4.1).

Аварийный путь 4.1 — [4.1/docs/MISC.md §9](../4.1/docs/MISC.md#9-вектора-загрузка-лог-аварийный-путь-41).

### 11.4 Прочее [6.2]

* dashboard — [FW-OBJECTS.md](FW-OBJECTS.md#отладочная-сводка-g_dbg_dashboard).
* `led__update_by_link_rate` 0x8da8cc — светодиод по скорости линка.

## 12. Каталог блоков: РЧ, board-файл и калибровки [обе]

Блоки fw 6.2 с соответствиями 4.1 (дополнение к §6, §9). Запись адреса: `имя` 0x… — адрес 6.2; «/ 4.1 0x…» — адрес той же функции в 4.1 (по
совпадению тела — `6.2/ref/CORRELATION-FW.txt`, по таблице
[NAMES-FROM-62](../4.1/docs/NAMES-FROM-62.md) или по имени); если в 4.1 имя другое, оно
указано; без пометки 4.1 — соответствие не установлено. Блоки 4.1 без пары в 6.2 — [4.1/docs/MISC.md §1](../4.1/docs/MISC.md#1-рч-калибровки-abifphyrfc-board-файл-fw-41).

Метки здесь в основном **[стр]/[выз]**; тела не читались, кроме оговорённых.

* **Board-файл (multi-array):**
  `brd_if_multi_array__verify_board_file_format_version` 0x8ebd18 / 4.1 0x8e70dc и
  `brd_if_multi_array__get_board_file_format_version` 0x8cbafc / 4.1 0x8c9a84; разбор секций —
  `brd_if__scan_sections` 0x8c6afc / 4.1 0x8c5d68, `brd_if__check_section_header` 0x8ebdc4 / 4.1 0x8e7198,
  `brd_if__bounds_check` 0x8e2188, `brd_if__chunk_offset` 0x8c5410 / 4.1 0x8c4894,
  `brd_if__clear_block_info` 0x8c6790 / 4.1 0x8c5a0c (+хвост `brd_if__clear_block_info_thunk`
  0x8c18cc / 4.1 `tail_brd_if__clear_block_info` 0x8c17e0); печать структур — `brd_if_multi_array__physical_section_header_u`
  0x8e0f4c, `brd_if__block_info` 0x8e0fa0, `brd_if__section_info` 0x8e0fd8;
  мелочь `edmg__channel_matches_mode`, `brd_section_info__reset` (+хвост
  `brd_if__section_info_reset_thunk` 0x8c18d0), `bitmap__nth_set_bit`,
  `brd_multi_array__elem_bits`, три `stub_ret_8ebd0c/10/14`.
  Из `brd_if_multi_array__get_block_info` 0x8cb940 / 4.1 0x8c98dc граф вызовов даёт три
  вызова регистров MAC: `mac__get_beacon_interval_tu` 0x8e9868 / 4.1 `get_reg_886d00_8e47a8` 0x8e47a8,
  `mac__read_next_tbtt64` 0x8e98b4 / 4.1 `mac__read_counter_886d64` 0x8e47f4, `mac__read_usec_to_tbtt` 0x8e98e4 / 4.1 `get_reg_886e80_8e4824` 0x8e4824.
  Вероятно, это ошибка графа: в 4.1 те же три геттера (0x886d00, счётчик
  0x886d64, 0x886e80) зовёт `psc__read_mac_counters` при завершении PSC
  ([4.1/docs/MISC](../4.1/docs/MISC.md)) **[гипотеза]**.
  Секции РЧ: `handle_rf_sets_info` 0x8ed5ec (наборы RF, «Wrong RF sets info»),
  `handle_omni_sector_info` 0x8cd940 (RX-сектора omni: режим MASSIVE/SINGLE,
  разнесение, топология; пишет в RF с повторами), `check_rf_boardfile`
  0x8f19b8 / 4.1 0x8ea224 — сверка платформы: board-файл и железо должны быть оба **MR** или
  оба **FR** (иначе RF_ERROR и фатал).
* **Обнаружение и питание РЧ:** `rf__is_present` 0x8da5d8 / 4.1 0x8d750c,
  `rf__type_is_known` 0x8da5c4 / 4.1 `get_reg_880a7c` 0x8d74f8, `rf__type_is_marlon` 0x8da594 / 4.1 `get_reg_880a7c_8d74c8` 0x8d74c8,
  `rf__check_state` 0x8c74b4 / 4.1 0x8c64bc («com_test, RX_GAIN_RTYPE_TBL_[13]»),
  `rfc__read_or_dead` 0x8cae70, `rf_power_off` 0x8e2fa8,
  `hwf_rf__wait_ready_log` 0x8d6ff4 («RF RESET DONE»), `sdp__drive_pin_timed`
  0x8d6e88 (журнал шагов РЧ с TSF и выводом SDP), `hwf_rf_config` 0x8d6f30
  («channel is %d» → канал и роль marlon), `rf__configure_chain` 0x8d705c / 4.1 0x8d46f4
  (после deep sleep), три регистра RF kill (`rf_kill__ack_irq`,
  `rf_kill__unmask_irq`, `mac__toggle_880288_b1`), **`low_sme__handle_rf_kill`
  0x8cdb28 / 4.1 0x8cb4fc** — RF kill: флаги termination (DISCONNECT, SCAN_ABORT, PCP_STOP=2),
  останов PCP/скана, отключение vring.
* **Выбор активных РЧ-модулей:** `hwm_analog_select_active_rf_module` 0x8d7584
  — вектор включения против подключённых портов XIF, включение/выключение по
  модулю, счётчики. `rfca__touch_rf_module` 0x8e2fc0, `rf_tbl__lookup_by_module`.
* **Сектора:** `hwf_sector_rf_chain_set` 0x8d7154 / 4.1 0x8d47f0 / `hwf_sector_rf_chain_get`
  0x8d70d4 / 4.1 0x8d4764 — по сектору и цепочке: edge gain/phase, dist gain, x16, индекс
  усиления; немедленное применение к текущей цепочке. `sector_list__validate`
  0x8d9ac8 (первый сектор ≠ 0xFF, номер < MAX_NUM_OF_SECTORS),
  `rf_chain__zero_and_program` 0x8ea398 / 4.1 0x8e5000, `rf_chain__set_mode_field` 0x8ea598 / 4.1 0x8e5270,
  `lmac_if__send_sta_cfg_05_b` (сектора из `host_if__set_sectors_hal`),
  `dma__set_881b24_bit1` 0x8df5c4, `l2_mgr__set_rf_params` 0x8f9028 (число RX
  DMG-антенн по CID), `rf_utils__fill_default_patterns` 0x8d9a54 и
  `rf_utils_auto_fill_set_pattern` 0x8e3268.
* **XPM (OTP РЧ):** `xpm__read_3c8` 0x8d45c0, `xpm__read_3cc` 0x8d4680,
  `xpm__read_data_byte` 0x8d45e0 / 4.1 0x8d1384, `xpm__write_addr` 0x8d4600 / 4.1 0x8d13a4,
  `rfc__write_core_c_flag` 0x8d460c (программирование байта),
  `xpm__accumulate_bits` 0x8d6f68, два хвоста записи полей RFC
  (`xpm__write_3c8` 0x8d45d4, `xpm__write_3cc` 0x8d4694),
  `bits__lowest_set_bit8`; `hwf_rf_xpm__read_block_8b` 0x8f6d0c (из `otp_init`).
* **Утилиты РЧ UT:** `hw_sysapi_rfc_fetch_rgf_util` 0x8ce1b4 (чтение/запись
  регистров RFC для хоста с проверкой подключения), `hwd__program_rf_regs_seq`
  0x8d4338 (последовательность полей RFC), `fw_sysapi__start_rx_pkt_phy_data`
  и `fw_sysapi__start_phy_rx_stats` 0x8ce0d4 (старт PHY-статистики),
  `channel_est__clamp_64` 0x8f9070.
* **Калибровка усиления BB/VGA:** `hwf_calib_bb_gain_rows` 0x8d4eb4 / 4.1 0x8d2064 (1052 Б —
  построчно: опорная строка, «Gain measure is out of BOUND VGA_INDEX»),
  `calib_row_step` 0x8d4e08 / 4.1 0x8d1fb8, `calib_vga_coarse` 0x8d53b8 / 4.1 0x8d2590 и
  `calib_vga_coarse_limit` 0x8d8604 / 4.1 0x8d5274 («Coarse VGA reached its limit»),
  `calib_bb_gain__pack_row` 0x8e97bc / 4.1 0x8e46fc, `hwf_calib_bb_gain__args` 0x8dcb6c / 4.1 `frag_8d93cc` 0x8d93cc,
  `bytes__pick4_by_index`, `calib__keep_closest`; VGA DC —
  `hwf_vga_dc__measure` 0x8d6ad4 / 4.1 0x8d3d74; `mem_resource__check_timeout_cb` 0x8c6264
  (в блоке две строки — «check_memory_resource_timeout_cb» и
  «calib_bb_gain_dc::check_online_estimation_condition»; зовёт
  `assoc_ready_check_trig`; роль по первой строке **[гипотеза]**).
* **IF gain:** `if_gain__compute_correction` 0x8d55b4 / 4.1 0x8d2780, `if_gain__apply_delta`
  0x8d561c / 4.1 0x8d27e8, `hwf_if_gain__apply_agc_table` 0x8d5f08 / 4.1 0x8d30a0, `if_gain__scale_value`
  0x8d6dcc / 4.1 0x8d406c, `approx_magnitude` 0x8d6490 / 4.1 0x8d3708,
  `hwd_phy__tx_self_transmit_wait_completion`, `hwd_phy__tx_singen_transmit`,
  `hwd_phy__tx_ctrl_884070`.
* **LO power / LO leakage / BER:** `hwf_calib_lo_power_flow` 0x8d5fa8,
  `calib_lo_power__step` 0x8d5f78, `calib_lo_power_substep` 0x8d530c / 4.1 0x8d24e4,
  `rf__set_8894a0_field`, `abif__set_nibble_all_chains` 0x8d01c8,
  `abif__set_3bit_all_chains`, `calib_lo_power__step_save_mode` /
  `lo_power__restore_rfc_field` (режим LO power для восстановления после сна);
  `calib_lo_leakage__sweep` 0x8e4cd4 — драйвер калибровки утечки LO: контекст
  (`calib_lo_leakage__prepare_ctx` 0x8f8f9c / 4.1 0x8f0c40), шаги (`calib_lo_leakage_step`
  0x8c839c / 4.1 0x8c6fd8, `calib_lo_leakage_substep` 0x8dc5bc / 4.1 0x8d8eac), BER-замер
  (`ber_test__measure` 0x8e8360 / 4.1 0x8e325c, `hwf__set_agc_index_1c` 0x8e67a4 / 4.1 0x8e1940), результат
  `calib_lo__set_result` 0x8f1d08 / 4.1 0x8ea598. `hwf__rf_lo_setup` 0x8d4978 / 4.1 0x8d190c (через
  `temp__store_lo_temp` от таймера температуры).
* **SAR:** `calib_sar_step2` 0x8d47e4 / 4.1 0x8d1734 (выборки SAR PHY 0x885000, 64-битный
  сдвиг `fw_ashr64` 0x8c0620).
* **Silent RSSI / AGC:** `calib_silent_rssi_sparrow__set_agc_start_val`
  0x8ea8d8, `silent_rssi__set_agc_search_window`,
  `silent_rssi__hist_window_index` 0x8dde0c (поиск старта AGC, тест связи с
  RF), `calib_silent_rssi__step` 0x8e3988, `silent_rssi__set_rf_gain_index`
  0x8c6c2c, `calib__start_scheme4` (таблица silent RSSI из WMI), геттеры
  `get_g_800254/55/56`, `stub_ret_8cc394/39c`, `rf_mask__count_modules`,
  `silent_rssi__load_params_b`, `silent_rssi__load_params_a`, `calib_req__fill`.
* **Менеджер калибровок:** `CALIB_MNGR__update_sys_state` 0x8ead00 / 4.1 0x8e5a2c,
  `calib_engine__abort_all` 0x8e49fc и `calib_engine__run_requested` 0x8e4a28
  (перезапуск схем), `fw_log__emit1_tsf` / `fw_log__emit2_tsf` 0x8dce04 (метки
  TSF для схем), `hwm_calib__set_loopback_mode` 0x8d7560 / 4.1 0x8d4c0c,
  `calib__release_hw_thunk` 0x8d4e04 / 4.1 `tail_hwf_calib__release_hw` 0x8d1f28, `basic_calib__check_g8000a4` 0x8cb91c,
  `temp__get_rf_by_index`, `temp__get_active_rf` 0x8ccbf4 (кэш температуры).
* **Чтение калибровки RFC:** `rfc__read_calib_block` 0x8f3610,
  `get_min_failures_mid_biggest_range_index` 0x8f35a8,
  `rfc_read_calib_get_min_failures` 0x8f8060, `rfc__read_temperature`,
  `rfc__read_block_34c` 0x8d3164 (без РЧ-модуля для температуры).
* **PHY/прочее:** `hwd_phy__power_up_seq` 0x8d7b84 / 4.1 0x8d50e4, `hwd_phy__enable_880a80`
  0x8d1b2c / 4.1 0x8cee90, `phy__get_885178_3bit`, `phy__set_885178_3bit` 0x8d1b94 (BRP RAM),
  `rladder__step_code` 0x8c15e4 / 4.1 0x8c15b0, `mid__link_acquis_step` 0x8e6558,
  `marlon_r_if__read_step` 0x8c6ccc, `rf_if__num_tx_sectors`,
  `agc__get_table_pair`, `math__square32`, `bits__sign_extend_n`,
  `qdesc_cfg__is_override`, `rf_chain__get_default_desc_bit0`,
  `rf__get_connected_mask`, `platform__is_asic`, `calib_obj4__reset_d4`,
  `bit_iter__has_more`, `field_set_0x00__8e5dfc`, `bitmap__alloc_bit` 0x8df444 / 4.1 0x8db194,
  `mids__count_active_conns` 0x8cb8b0 (работает с битовой картой MID, не с
  ABIF; точная роль **[гипотеза]**).
* Общие (см. [FW-UTILITIES](FW-UTILITIES.md)): `fw_divmod_signed` 0x8c02dc / 4.1 0x8c03bc, `fw_ashr64` 0x8c0620, милли-код
  `__st_r14..r25_to_r13` / `__ld_r14..r25_to_r13_ret`.

## 13. Каталог блоков: PCIe, режимы питания и PS [обе]

Дополнение к §4, §5. Блоки 4.1 без пары в 6.2 — [4.1/docs/MISC.md §4](../4.1/docs/MISC.md#4-pcie-wbe-режимы-питания-halt-fw-41).

Метки **[стр]/[выз]**.

* **DBI и SerDes PCIe:** `dbi_write` 0x8c8338 («dbi_write FAILED: address,
  data, port», ep_en/shadow), шлюз DBI — `pcie__dbi_start_cmd` 0x8d122c / 4.1 `set_reg_882600` 0x8ce4e8,
  `pcie__dbi_ack_done` 0x8d11e8, `pcie__dbi_set_addr` 0x8d1220,
  `pcie__ack__8e026c` 0x8e026c / 4.1 `pcie__ack_882644` 0x8eec3c + `pcie__wait_882644_ready` 0x8d11f8 / 4.1 0x8ce4b4,
  `pcie__clear_dbi_gateway` 0x8f1b6c / 4.1 0x8ea418 («Clearing DBI gateway», из вектора 16),
  `pcie__hp_ctrl_write_bit` 0x8f8094 / 4.1 `rgf_reg_882600` 0x8efd50, `pcie__serdes_clear_flag_if_bit1`
  0x8f3d6c; SerDes — `pcie__program_seq_fw_8825c0__8d1114`,
  `pcie__apply_mode_fw_8825c0__8d10c8`, `pcie__mirror_link_bit` 0x8d117c / 4.1 0x8ce438,
  `mac__set_880af8_afc_b30_b6`, `mac__set_880af8_afc_b25_b5`,
  `mac__set_880afc_bits9_11`; `pcie_serdes__shlicht_wa` 0x8f6f7c — «PCIe serdes
  configuration shlicht» (зовёт `pcie__serdes_init`).
* **L1/LTSSM и deep sleep:** `hwd_pcie__is_l1_state` 0x8d1054 / 4.1 0x8ce310,
  `hwd_pcie_ltssm_is_l1_idle` 0x8d1070 / 4.1 0x8ce32c, `pcie__ready_for_deep_sleep` 0x8d1088 / 4.1 0x8ce344
  и `pcie__l1_idle_and_park` 0x8d10ac / 4.1 0x8ce368 (из `deep_sleep_enter`),
  `pcie__set_l1_bit11` 0x8f8f50 / 4.1 0x8f0c30 и `isr16__pcie_l1_latency_wa` 0x8f173c / 4.1 `tail_pcie__l1_latency_wa` 0x8ea124 (обход
  латентности L1), `pcie__l1ss_config` 0x8d0d90 (L1 PM substates из
  `stats_timer_exp`), `link_lost_diag__dump_pcie` 0x8c8638 / 4.1 0x8eae1c,
  `pcie__set_event_bit` 0x8d1a98 / 4.1 0x8cedf0 (бит события хосту с выходом из L1),
  `pcie_lp__set_byte_field` (низкое потребление PCIe).
* **DPAL completion timeout:** `dpal__cpl_timeout_evt` 0x8c9680 / 4.1 0x8c7e98 (вектор
  валидности и счётчики completion; отключает vring), `pcie__clear_cpl_timeout`
  0x8fa818 / 4.1 0x8f28d4, `dpal__mask_cpl_timeout_irq` 0x8f6b4c.
* **WBE (PCIe link up/down):** `wbe__mask_link_down_irq` 0x8f6b5c,
  `wbe__mask_pcie_irqs_on_driver_up` 0x8f6b6c / 4.1 `set_reg_882680_8ee788` 0x8ee788, `wbe__rearm_link_down_irq`
  0x8fa83c / 4.1 `set_reg_882670_882684` 0x8f28f8, два хвоста `WBE_DRIVER__pxe_isoc_in_dir_bypass` (0x8f7d10,
  0x8f7d18 — коды 2 и 3 вектора 15),
  `tail_pcie_device_power_if__pcie_power_wake_s…` (`pcie_power__wake_signal`
  0x8ec05c / 4.1 `tail_pcie_device_power_if__pcie_power_wake_signal` 0x8e7400), `pcie_device_power_sm__init` (автомат питания устройства).
* **Режимы питания (hw_modes, UT):** `hwm__apply_mode_flags` 0x8d7818 / 4.1 0x8d4d5c,
  `ut_hw_modes_cmd_0x308` 0x8d7864 / 4.1 0x8d4da8 (режим питания), `ut_hw_modes_cmd_0x304_fw`
  0x8d7c04 / 4.1 `ut_hw_modes_cmd_0x304` 0x8d5164 (PLL bypass/engage — `hw_modes__pll_bypass` 0x8d7748 / 4.1 0x8d4c8c,
  `hw_modes__pll_engage` 0x8d7714 / 4.1 0x8d4c58, `hw_modes__enable_pll` 0x8d772c / 4.1 0x8d4c70,
  `hwd__wait_pll_lock` 0x8d041c / 4.1 0x8cd590), `ut_hw_modes_cmd_0x30b` 0x8d7cc4 / 4.1 0x8d521c,
  `ut_hw_modes_cmd_0x30c` 0x8d7c70 / 4.1 0x8d51d0, `hw_modes__program_rf_clocks` 0x8d7c3c / 4.1 0x8d519c,
  `hw__pll_mode_switch` 0x8d7c84, `abif__mode_switch` 0x8d7bd0 / 4.1 `rgf_reg_88a200` 0x8d5130,
  `hw_modes__set_loopback` 0x8d76ec / 4.1 0x8d4c30, `hwm__set_analog_path` 0x8d7528 / 4.1 0x8d4bd4,
  `ut_hw_modes_step` 0x8d7358 / 4.1 0x8d4aa8, `ut_hw_modes__chain_3` 0x8d7500,
  `hwm_analog_channel_switch__thunk_arg1_zero` 0x8d73ec,
  `hwm_analog__prepare_buf` 0x8e2960 («RESET RF!!!»), `ut__begin_response`
  0x8eae60 / 4.1 0x8e5b7c (ответ UT-команды), `ut_hw_flows__hwm_alloc_and_store_thunk` 0x8ce4e8.
* **Часы 33 кГц:** `hwm_power_33kHz_clk_detector` 0x8d777c / 4.1 0x8d4cc0 («External clock
  (33KHz) detected»), `hwm__probe_33khz_clk` 0x8e9924 / 4.1 0x8e4864,
  `hwm__start_33khz_measure` 0x8e9a14 / 4.1 0x8e4958 (замер по TSF), `mac__read_tsf_hi`
  0x8e9aa0 / 4.1 0x8e49e4, `hwm__measure_33khz_wait` 0x8e9954, `mac__cmd_63_repeat`.
* **POWER_MNGR:** `power_mngr__check_mode` 0x8e24e0 (режим по каналу/стране:
  `regd__is_country_us` 0x8da658 / 4.1 0x8d7550, TX power RFC), `power_mngr__read_g800380`
  0x8cc1fc (время по TSF для сна), `power_mngr__init` 0x8f5138 (init из
  `fw_main`: 33 кГц, PCIe-питание, умолчания),
  `g__set_defaults_803d90_803d94__8e64e0`, `power_mngr__set_traffic_deferral`
  0x8e04e8 (traffic deferral → LMAC cmd 0x27), `retry__try_next` →
  `backoff__add_and_schedule` 0x8f1c30 (т. е. `u_schd__add`, [SCHEDULER](SCHEDULER.md)),
  `fw2uc__signal_wake_and_wait_ack` / `fw2uc__signal_halt_and_wait_ack`
  0x8db148 (ожидания с «DO_WHILE_WITH_MAX_ITER»), `ps__set_wake_time64`,
  `mac_icr__rearm_awake_tsf`, `deep_sleep__host_evt_mbox_pending`,
  `hw_cfg__get_8004fc_bit0`, `rf__get_active_mask`, `radio__get_channel`,
  `get_g_8000c0_800214__8da3bc/8da3d8`, `rf__set_889494_low_nibble` 0x8d46b8 / 4.1 `rgf_reg_889480` 0x8d15cc,
  `phy__load_88416c_table` 0x8d46e4, `abif__set_ctrl48_bit18`,
  `rgf_reg_880c00_8cd568/8cd5b8`, `mac__set_880afc_bits26_31_fw`,
  `hwd_mac__trigger_sxd_tx_mode`.
* **PS соединения (PSC):** `psc_if__init` 0x8d9344 / 4.1 0x8d632c (автоматы 0x801eac pcp_psc и
  0x801f08 sta_psc — `obj_vt801eac__ctor`, `obj_vt801f08__ctor`),
  `frame__build_psc_resp` 0x8d8160 / 4.1 0x8ecc40 / `frame__build_psc_resp_short` 0x8d81cc / 4.1 0x8eccac,
  `psc_if__psc_req_tx_wb_cb` и `psc_if__psc_resp_tx_wb_cb` («received WB after
  disconnect»), `psc__set_two_flags` 0x8cd098 / 4.1 0x8cad48, `psc__store_time64`. Сон:
  `ps_assoc_mgr__shallow_sleep_enter` 0x8e13c8 — PS_EVT_SHALLOW_SLEEP_ENTER
  ассоциированного менеджера (m_awake_tsf_64),
  `ps_nonassoc__shallow_sleep_enter` 0x8e15fc (неассоциированный),
  `ps_shallow_sleep__step` 0x8e74a0, `scan_mngr__sob_awake_bi_ntf` 0x8e74d8
  (скан под PS ждёт awake BI), `ps_cfg__profile_matches` (профиль PS),
  `evt_ring__push_1c`.

## 14. Периферия и аварийный дамп [обе]

* **SDP/GPIO, светодиоды, SPI:** `sdp__init_int_ctrl` 0x8f42e4 / 4.1 0x8d1430 →
  `sdp__init_pair` 0x8d4768 (`sdp__icr_ack_bit`/`…8d16cc`),
  `sdp__set_int_ctrl_bit`, `sdp__set_defined_bit`, `sdp__read_880b98_bit`,
  `gpio__reset_config` («Resetting GPIOs configurations»),
  `hwd_sdp_drive_value` 0x8f4258, `gpio__set_pin_func_and_dump` 0x8f4294 / 4.1 `gpio__dump` 0x8d13dc,
  `hw_personality__read_strap` 0x8f4424 / 4.1 0x8d1578 (strap «personality» через SDP),
  `sdp__set_level_and_init`; светодиоды — `hw_ch__enable_once` (схема LED,
  проверка индекса < 3); SPI — `hwd_spi__poll_done` 0x8f9248 / 4.1 0x8f0e94,
  `hwd_spi__release_lock` 0x8f93e4 / 4.1 `set_reg_8801a8_x2` 0x8f1058.
* **Отладка и аварийный дамп:** `link_lost_diag__dump_all` 0x8c853c / 4.1 0x8eac24 (из
  `fw_sysassert_fatal`: DMA, ложные тревоги, MAC RX, PCIe, RF),
  `link_lost_diag__dump_rf` 0x8c86b4 / 4.1 0x8eaea4, `link_lost_diag__noop_dump_hook`,
  `fw_sysassert__stack_dump` 0x8c9a88 («Stack dump %08x-%08x» — дамп стека до
  0x807ffc), `assert__restore_hw_for_dump` 0x8e864c / 4.1 0x8e35e4 (питание PHY/PCIe для
  дампа), `fw_status__set_assert_marker` 0x8e8640 / 4.1 `set_reg_880a48` 0x8e35d8, `mailbox_debug_dump`
  0x8ddab4 / 4.1 0x8d9ba8 (указатели кольца ящика), `cpu__aux28_clear_bits12` (из
  `sysassert__wmi_lock_notice`), `ut_module_hw_flows__log_101aa08` 0x8cddc8
  («UT_HW_SYSAPI_FORCE_ASSERT: waiting %d mSec»),
  `pcie__set_event_bit_19_sysassert`, `rf__type_is_sparrow_r`,
  `get_g_8003d0_8dd8a8/8dd8b0`, три `stub_ret` из `boot__install_diag_magic`
  (`boot_diag__fw_stats_blk_addr` 0x8cc160, `boot_diag__reg_8803e8_addr`
  0x8cc168, `boot_diag__reg_8802bc_addr` 0x8cc6b4).

## Замечания

* Вызовы регистров MAC из разбора board-файла (§12) — вероятная ошибка графа.
* `calib_silent_rssi_sparrow__correction_alg` @0x8c766c (1640 Б) печатает
  `class_calib_lo_power::correction_alg` и вызывается и на этапе LO_POWER, и на
  SILENT-RSSI — вероятно, общий алгоритм коррекции (виртуальный метод); имя сомнительно.
* `hwf_rf_xpm_read_byte_8fa884` (1312 Б) — размер несоразмерен «чтению байта»; не
  проверено.
* Блоки 6.2 с именами `channels_switch_sm_802234__action_*` — обработчики движка
  калибровок, а не переключения каналов; в дереве переименованы в `calib_engine__on_*`
  ([§6.2](#62-фоновые-калибровки-calib_mngr-и-calib_engine)).
* 0x8ddbbc — не `sta_psc_sm__max_retry_handler` (повторы PSC станции), а
  `brd_if__build_tx_sector_list` ([§9.8](#98-число-секторов-62-и-его-задание-через-board-код--железо)).
* `rf_if__num_tx_sectors` 0x8cb7e8 в старых листингах — `leaf_8cb7e8`.
* Обнуление записей TX-секции не уменьшает число секторов 6.2: второй проход по блокам
  заголовка дописывает недостающие индексы ([§9.8](#98-число-секторов-62-и-его-задание-через-board-код--железо)).

## Не установлено

1. Раскладки регистров ABIF/RFC/PHY (имена полей есть в паке 11ad, не сопоставлены);
   раскладка строк таблиц TX/RX ABIF (сколько строк, поля I/Q).
2. Роль 0x889380 (2 блока) и остатка 0x88af80/0x889480 без UT-кода; переименование блоков
   ABIF по карте [§8.2](#82-карта-блоков-регистров-abif-62).
3. Таблица схем калибровок (`calib_cfg__get_scheme`): какие схемы и с каким периодом;
   какие калибровки идут фоном.
4. Числовые пороги температурных режимов.
5. Раскладка результатов калибровок в объекте `0x8042c8`.
6. Период таймера замера температуры (не измерен ни в 4.1, ни в 6.2).
7. Формат board-файла multi-array побайтово (заголовок чанка и секций); какие секции
   board-файла читаются в 6.2 сверх 4.1.
8. Кто вызывает `hwd_rfc_read_calibrate` (WMI или внутренний поток).
9. `pcie_device_power_sm__pcie_traffic_resume_req` — порядок возобновления трафика;
   раскладка регистров 0x8825c0..0x882f80.
10. `power_halt_seq` — порядок остановки (регистры, без строк); значения профилей PS и их
    параметры.
11. Содержимое таблиц, заполняемых `boot__install_handler_ptrs`; какие WMI-команды ведут в
    sysapi; отношение автоматов 6.2 `state_sm_8030e0`/`uses_*` к sysapi.
12. Формат кадров FTM и источник меток времени (TX/RX offset 0x889548); путь AoA до
    измерения в ucode (6.2 ucode `notify_aoa` 0x92de8c); имена обработчиков
    `state_sm_8034c0__*` / `state_sm_803424__*` по таблицам переходов.
13. Действительно ли `brd_if_multi_array__get_block_info` зовёт геттеры регистров MAC (§12).
14. Роли `mem_resource__check_timeout_cb` и `mids__count_active_conns` (§12).

## Источники

* `4.1/ref/SM-TABLES.txt`, `6.2/ref/SM-TABLES.txt` — таблицы автоматов (CALIB_ENGINE,
  PCIE_DEVICE_POWER_SM, PS, FTM).
* `6.2/ref/REGS-62.md` — карта регистров 6.2.
* [6.2/docs/UT-DRIVERS.md](../6.2/docs/UT-DRIVERS.md) — диспетчер UT-подкоманд драйверов.
* [WMI.md](WMI.md), [VENDOR-ENUMS.md](VENDOR-ENUMS.md), [STATE-MACHINES.md](STATE-MACHINES.md),
  [BF-ENGINE.md](BF-ENGINE.md), [DATAPATH.md](DATAPATH.md).
* [4.1/docs/MISC.md](../4.1/docs/MISC.md) — поблочные списки 4.1.
* `SparRAW-docs/research/BRD-RF-REGS.md` — регистры РЧ в board-файле.
