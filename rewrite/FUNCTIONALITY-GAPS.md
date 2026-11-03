# Отличия rewrite от vendor (wil6210 6.2.0.1000) — состояние на 2026-10-20

## Итог

- **Образ целиком наш:** код fw (ARC600, C11) и код uc (MAC-CPU) — из rewrite; от vendor
  берутся только данные (fw_data, uc_data, AGC-таблицы).
- **Работает:** скан, BF, ассоциация с WL60TEST, данные. hwboot `RESULT: data`, linktest
  ping 0 %, iperf3 up ~975–985 / down ~1000–1020 Мбит/с (vendor ~988/968). `iw station dump`.
- **Покрытие fw:** из 2170 функций vendor (≥ 8 Б по SYMS.txt) 2132 упомянуты в портах —
  182 690 из 183 672 Б (99,5 %). Оставшиеся 38 адресов (`FUN_ram_008e4340` и т. п.) уже
  портированы под именами без vendor-адреса в комментарии (напр. 0x8e4340 —
  `rx_macq_pack_desc` в rx_chain.c, 0x8d8e5c — `calib_engine_sm_init` в power.c).
- **Weak-заглушек в fw.elf нет** (`arc-elf32-nm fw.elf | awk '$2=="W"'` пусто).
- **WMI:** все 102 команды vendor-диспетчера (docs/WMI-DISPATCH.md); UT 0x900 — модули 7, 9..13.

## Известные расхождения и незавершённое

| Что | Где | Статус |
|---|---|---|
| Зависание fw в калибровке self-TX (IF_GAIN sub 2) — 3 из 23 прогонов | calib_hw.c | исправлено: предел ~20 мс (DBG_SELFTX_TO 0x806a40) |
| Ассерт uc 0x6000/0x26 (INT6, MAC_HW_ICR б5: поздняя команда 0x37000020 на пути продолжения TXOP; код 0x6000 — лишь б0 txrx_state2) — ~1 из 25 | uc/rx.c `rx_txop_continue` | исправлено 2026-10-18: ветка RD (BA в нашем TXOP) шлётся из обработчика без возврата в rx_flow_run, O2 (`UC_HOT`) на цепочке; запас ≥ 8 инструкций (стресс UC_DBG_TXOP_PAD: старый код +4 — 9/9 сбой, новый +4/+8 — 0 из 5) |
| Редкие `ready`/`assoc` без данных бывают и у vendor (3/4 в серии 2026-10-18) — стенд/эфир | — | учитывать при оценке |
| UT модуль 9, подкоманда 0x983 (`hwf_sector_rf_chain_set` 0x8d7154) — вызов как vendor 0x8faa2e (2026-10-20) | ut_flows.c, rf_sector.c | сделано; стенд не проверял |
| Режим AP/PCP (2026-10-19, tools/hwboot_ap.sh): .12 — AP, .11 vendor STA — 4/4 data, iperf ~950–977 / 886–1018 Мбит/с; исправлены колбэки DMG beacon (65c9d3f5) и rs_start для cid 8 (09d96d24). PBSS/GO, безопасность (WPA offload) — не проверены; несколько станций на стенде из 2 устройств не проверить | — | работает (базово) |
| Большинство новых WMI-обработчиков (кроме STA-пути и NOTIFY_REQ) на стенде не проверены | wmi_h_*.c | не проверено |
| Скан при подключённой STA (`iw scan`) сразу кончается «scan aborted» (стенд 2026-10-26): путь подключённого скана — автомат `swc_psc_sm` — ждёт SOB_STARTED (vendor `scan_mngr__sob_awake_bi_ntf`, поток энергосбережения), а PS вырезан; через 1 с `swc_psc_sm_sob_timeout_cb` → итог со статусом 1 | fw/scan.c | следствие отказа от PS; уход с канала при подключении без PS не сделан |
| Порядок IE в probe req: снимок «dd07/dd27 переставлены» был до беззнакового сравнения eid (0716c922); статически сверено — 00 7f 72 94 dd07 dd27 dd0f, как в журнале vendor (2026-10-20) | mgmt_tx.c | совпадает; сверить журналом на стенде |
| Дубли портов (149 групп, в т.ч. `_cp`-копии) | ut_hw_drivers.c, sysapi_stats.c, mac_ext.c и др. | сделано 2026-10-19 (bb55dbbe, 5116c8ce — одиночные `_cp` без суффикса); функций `*_cp` нет (остались только имена регистров PHY `*_COUNTER_CP` — имена REGS-KNOWN) |
| vectors.c: `wbe_driver_pcie_debug` (0x8f7d20), `pcie_device_power_sm_traffic_resume_req` (0x8e05ec, DBI 0x60/0x64), `pcie_l1_latency_wa` (0x8ed7b4, DBI 0x40/0x70c/0x7c/0x708), запись BAR 0x8f0e14 (DBI 0x10/0x14 в PERST) — портированы 2026-10-20; вызов vendor по [0x8000e8] в 0x8f5e6c — указатель всегда 0 (доказано), не повторён | vectors.c | сделано; стенд: PERST deassert / hot reset, L1 |
| Событие ucode 0x22: vendor 0x8db8c4 → 0x8cb484 (итог пачки FTM → BURST автомату сессии conn->ftm), r2/r3 не читаются — бага vendor нет; порт звал не ту функцию (разбор кадра 0x8cb3bc), исправлено 2026-10-20 | lmac_evt.c | сделано; стенд: FTM-инициатор |
| Неинициализированные байты пула в событиях хосту/LMAC — единое правило: тело элемента обнуляет mem_pool_alloc_locked (2026-10-20); у сборщиков — «у vendor остаток слота пула» | pool.c (+ комментарии wmi_h_*.c, sysapi_stats.c, misc_ext_sysapi.c, pcp_ext.c) | сделано (заметно: 0x1a0f — статус 0) |
| Прежние TODO в fw/*.c (2026-10-20): портированы sniffer WMI_CFG_RX_CHAIN, edca__fill_default_ac_params (EDCA IE был с нулевыми AC), add_discovery_bcon, l2_mgr::connect_multi_omni (+ копия команды вместо указателя в кольцо ящика); прочие — утверждения | wmi_cmd.c, mid.c, stubs.c | сделано; стенд не проверял (sniffer, discovery, multi-omni, EDCA в probe resp/биконе AP) |
| cnt_handler__clear_all (0x8f6424): опрос lp N+1 при счётчике N — при полном таймауте счётчик −1 и ассерт не срабатывает (особенность vendor, сохранена; исправление даст ассерт при загрузке, если биты готовности не встают — только со стендом) | hw_init.c | кандидат в баг vendor |
| SNR Report (9.5.3, 4·(SNR − 19)) в SSW A-BFT станции, SSW-Feedback AP и SLS DTI — был младший байт метрики BF (r40 сел. 0xd [19:9]), как vendor (стенд: метрика 197…299 при SNR PHY 10,8…14,8 дБ, корреляция 0,38 — не дБ). Теперь SNR оценки PHY (0x883aec [17:9], четверти дБ) кадра, лучшего по метрике, — `snr_report_phy` в момент обновления лучшего | uc/abft.h, bti.c, tail.c, tx.c | исправлено |
| Порог ICCM: код до 0x8fc7b4 из 0x900000 (~14 КБ запаса) | fw.ld | следить |

## Сознательные отличия от vendor (баги vendor исправлены, с доказательствами в комментариях)

- **Поля WMI** (2026-10-31; тест test_fw_wmi_fields): WMI_CFG_RX_CHAIN wb_thrsh / host_thrsh / max_rx_pl_per_desc —
  __le16 драйвера (vendor читал со знаком: 0x8001 проходил проверку степени двойки как «< 3»); TSF в
  WMI_NOTIFY_REQ_DONE — mac_read_tsf64 (старшее–младшее–старшее с повтором; vendor читал по разу — при переносе TSF
  на 2^32 мкс меньше). ACS (0x9005): значения как у vendor, поля названы по драйверу — по +4 маска filled = 3
  (beacon_found, busy_time — только они заполняются), по +6 число каналов.
- **Приём и мелкие поля кадров** (2026-10-31; тест test_fw_mgmt_frames): AID из Association Response — младший
  октет (9.4.1.8: в DMG старшие 8 бит — резерв; маска 0x3fff не-DMG отвергала AID с битами B8..B13, fw/mlme.c
  `DMG_AID`); ESE у станции — все Number of Blocks окон аллокации с шагом Allocation Block Period (9.4.2.131; vendor —
  только первое), записи таблицы по возрастанию начала (fw/rx.c); последний элемент нулевой длины в кадре разбирается
  (9.4.2.1; vendor: цикл до остатка ≥ 3, fw/rx_mgmt.c); Clustering Control маяка discovery — Reserved B48..B63 = 0
  (рис. 9-79; vendor — остаток буфера TX, fw/stubs.c); RSN по умолчанию — RSN Capabilities 0 целиком (рис. 9-289;
  vendor оставлял B14 OCVC и B15 прежнего буфера, fw/wmi_cmd.c).
- **Элементы Probe Response / Probe Request / QoS Info** (fw/mgmt_tx.c, 2026-10-31): vendor собирал Probe Response в
  порядке SSID, RSN, DMG Capabilities, Vendor Specific, DMG Operation, Antenna Sector ID, EDCA, QoS Capability и сливал
  с IE хоста по Element ID; теперь — порядок табл. 9-39 (RSN 16 → EDCA 18 → … Multi-band 53 → DMG Capabilities 54 →
  DMG Operation 55 → Antenna Sector ID 57 → Vendor Specific), QoS Capability убран (в табл. 9-39 его нет). Probe Request
  — без RSN (табл. 9-38). QoS Info в Association Request (рис. 9-101) — 0x00: 0x08 объявлял U-APSD AC_BE, а
  энергосбережения нет. Тест: test_fw_mgmt_frames.
- **CBAP Only в Capability Information ответов** (fw/mgmt_tx.c `push_cap_info_resp`, 2026-10-31): vendor в Probe
  Response и (Re)Association Response всегда ставил B2 = 1 — и при DTI, распределённом ESE (маяк — 0); по 802.11-2020
  9.4.1.46 поле значит то же, что в DMG Parameters маяка — общий `dmg_cbap_only`. В Association Request BSS Type,
  CBAP Only, CBAP Source, ECAPC (резерв вне маяка и ответов) — 0 (vendor: 1 и 1). Тест: test_fw_mgmt_frames.
- **DMG Operation: TDDTI и Pseudo-static allocations** (fw/mgmt_tx.c `ie_push_dmg_operation`): vendor всегда 0; теперь
  по ESE маяка (рис. 9-556, 10.39.6, 10.39.6.4) — при TDMA точки оба 1. В DMG Capabilities (рис. 9-553) TDDTI и
  Pseudo-static остаются 0 сознательно: способность «10.39.6 и 11.4» требует DMG ADDTS (11.4) и выделения по Poll
  Required в A-BFT (10.42.5) — их нет. Power Source (B11) — по power_source (vendor 0, «от батареи»).
  Тест: test_fw_mgmt_frames (тело Association Response и DMG Capabilities).
- **Block Ack Policy в ADDBA** (fw/ba.c, 2026-10-31): vendor ставил B1 = 0 (delayed BA) в Request и Response; по
  802.11-2020 9.4.1.13 — 1 (immediate). Тест: test_fw_peer_vanish (байты ADDBA в эфире), test_live_ampdu.
- **Capability Request элемента DMG Beam Refinement** (uc/brp.c): vendor ставил и читал B50 (раскладка 802.11ad-2012 с
  15-битным FBCK-TYPE); по рис. 9-558 — B53, B50 — бит Number of Beams в FBCK-TYPE. Тест: test_capability_request_bit53.
- **Тело Grant Ack** (uc/tx.c `direct_tx_init_grant_ack`): 5 октетов Reserved (рис. 9-57) — vendor не обнулял байт
  +0x14 (уходил остаток стека) и ставил код AllocationType в B4..B6. Тест: test_grant_ack_body_reserved.
- **Supported MCS Set, Code Rate 13/16** (fw/mid.c): vendor B21 = 0 — по 9.4.2.127.2 MCS 5 и 9 тогда не поддерживаются
  при любом Maximum SC MCS; теперь 1.
- **Extended Schedule из WMI** (fw/wmi_h_bf.c): PCP Active B10 = 1 (10.39.6.1); Allocation ID 1..15, 0 — только у CBAP с
  широковещательными AID (9.4.2.131; vendor — счётчик 0..15). Поля Allocation — по возрастанию начала (9.4.2.131;
  vendor — в порядке записей хоста). Number of Blocks > 1 — команда отвергается (статус 1): таблица слотов точки
  держит один блок на выделение (vendor молча объявлял 1 блок из шаблона). test_fw_ese.
- **Поле r51 в командах 0x19** (uc, MTP_DESC_HI_OF): `(r51 >> 4) << 14` без маски залезло бы в код команды; маска
  10 бит (б14..23), кроме цикла SSW A-BFT (ХРУПКО, запас 0…2 такта). Стенд: r51 [31:4] всегда 0.
- **DMG BSS Parameter Configuration** (fw/mgmt_tx.c ie_push_dmg_operation, рис. 9-557): MinBHIDuration — наименьший
  BHI (один BTI, bss_min_bhi_us), AssocRespConfirmTime — ⌈BI / 50 мс⌉ (vendor — 0: станция могла взять нулевой
  dot11AssociationResponseTimeOut); PSRequestSuspensionInterval, BroadcastSTAInfoDuration, MinPPDuration, SPIdleTimeout —
  0 сознательно (PS, рассылки сведений о станциях, PP/GP нет). test_fw_mgmt_frames.
- **Listen Interval Association Request** (fw/mlme.c, 9.4.1.6): 0 — станция не уходит в PS; vendor — Beacon Interval в
  TU (100 «интервалов»). test_fw_mgmt_frames.
- **Диагностика модулей RF** (fw/rf_sector.c rfc_probe_modules, rfc_collect_rx_crc_stats; WMI_UNIT_TEST 0x516/0x517):
  после обхода — прежний набор активных модулей; vendor оставлял активным последний, тень abif_dvs_rf_ctrl у uc
  расходилась с регистром, запись uc по тени откатывала выбор. test_fw_rf_modules.
- **Beacon Interval станции и Probe Response точки** (fw/scan_mngr.c bss_bi_cache, fw/wmi_cmd.c l2mgr_connect,
  fw/wmi_h_pcp.c wmi_bcon_ctrl): CONNECT задаёт MAC станции BI точки из её маяка, принятого при скане (кольцо
  BSSID → BI, 0x806990); vendor — pcp_bcon_interval (BI своей точки, 100 TU): при BI точки 200 TU станция вела сетку BI
  с шагом 100 (стенд 2026-10-31: HW_MAC_BEACON_INTERVAL точки 0xc8, станции 0x64). Точка: поле записи bss.bcon_int —
  BI из PCP_START; vendor оставлял прежнее — маяк 200 TU, Probe Response 100 TU. test_fw_beacon_interval.
- **Элементы DMG Beacon** (fw/stubs.c tx_mgmt_srvs_build_dmg_beacon): порядок табл. 9-45 (vendor — блок как есть: ESE
  TDMA и расписания хоста после IE хоста, в том числе Vendor Specific); AP/PCP — свой DMG Operation, если хост не дал
  (11.1.3.3.1: обязателен при CBAP Only = 1 и при ESE; vendor не ставил). WMI_SCHEDULING_SCHEME заменял весь блок IE
  маяка одним ESE (RSN и прочие IE хоста пропадали) — теперь ESE встаёт на место прежнего (mid_set_beacon_ese, как TDMA);
  TX-буфер команды без флага 3 не освобождался. test_fw_ese.
- **DMG Operation, MaxLostBeacons** (fw/mid.c): 20 → dot11MaxLostBeacons = 4 (DEFVAL, Annex C) — то же A, что в Tguard
  псевдостатических выделений (fw/tdma.c, 10.39.6.5); DOT11_MAX_LOST_BEACONS. Прочие поля DMG BSS Parameter
  Configuration (рис. 9-557) — 0: энергосбережения и динамических выделений нет (PSRequestSuspensionInterval, MinPPDuration,
  SPIdleTimeout не используются), MinBHIDuration / BroadcastSTAInfoDuration / AssocRespConfirmTime 0 — открыто.
- **DMG Capabilities в Association Response** (fw/mlme.c): AID = 0 — элемент описывает точку (STA Address — адрес
  точки, 9.4.2.127; AID 0 — AP/PCP, 9.4.1.8); vendor ставил AID станции. AID станции — поле AID кадра (9.3.3.6).
- **Шаблон Beacon Interval Control** (fw/stubs.c bcon_tx_build_step, add_bcon, add_discovery_bcon; fw/pcp_ext.c
  bcn_tx_init_bi_cfg; fw/conn.c): шаблон записи mid и копия в теле DMG Beacon — по рис. 9-77 (поля BIC_* в
  include/ieee80211.h). vendor держал свою раскладку (TXSS Span B22..B28, N BIs A-BFT B29..B31, N A-BFT in Ant
  B38..B43, PCP Association Ready B44..B45) и копировал её в тело; в эфир поле собирает MAC из команд uc 0x2a/0x2b —
  там верно (стенд 2026-10-31, MAC-STAND «Beacon Interval Control маяка»). Параметры BI для uc (LMAC 0x0b) — байт в
  байт прежние (AP, PCP, Discovery 1/3). Тело кадра — итоговое поле (A-BFT Length записи, у AP PCP Association Ready 0;
  vendor — шаблон до этих правок). test_fw_beacon_bic.
- **Слот multi-omni CONNECT** (fw/scan_mngr.c, fw/wmi_cmd.c): BI цели × 1024 мкс; vendor × 1000 + 2400 — верно только при
  100 TU (поле scan_peer «rssi» → bcn_int_tu, параметры probe_resp_ind — da/bssid). Период n × BI: BI = 0 в кадре пира
  или n × BI × 1024 ≥ 2^32 (BI 32768 TU, n = 128 — ровно 2^32) — окна нет, подключение сразу, маяк не отсеивается
  (multi_omni_period, include/scan_mngr.h; прежде — деление на 0, test_fw_multi_omni).
- **Роли в A-BFT Discovery Mode** (uc/abft.h, наше, исправлено): AP и PCP были перепутаны (uc_role = bss.mode: 3 — AP,
  2 — PCP, как табл. 9-69); тесты test_uc_beacon_rx и tools/test_abft_discovery кодировали ту же ошибку — исправлены.

- **Allocation Duration кадра Grant** (uc/misc.c `frame_hdr_init`, 2026-10-31): vendor (0x9246fc) клал в B23..B31
  длительность >> 7, в B32..B38 — длительность & 0x7f; по 802.11-2020 9.5.2 (рис. 9-847) младший бит — B23: [8:0] и
  [15:9]. 1000 мкс уходили как 53255. Наш uc поле при приёме не разбирает — ломалась совместимость с чужими станциями.
- **Ширина подполей Beacon Interval Control** (uc/bi.c `bi_cfg_pack_bcon_cfg`, `bi_ctrl_program_mac_bcon`, 2026-10-31):
  vendor упаковывал байты LMAC 0x0b и счётчики BI в команды MAC 0x2a/0x2b без маски — значение шире подполя рис. 9-77
  заходило в соседнее (TXSS Span → N BIs A-BFT, N A-BFT in Ant → PCP Association Ready), в Reserved B44..B47 и в код
  команды; при N BIs A-BFT = 0 счётчик 0xff давал Next A-BFT = 15, Fragmented TXSS = 1, B44..B46 = 1. Теперь каждое
  подполе — по своей ширине. Тест: test_uc_beacon_tx test_bic_field_wider_than_subfield, test_bic_counters_masked.
- **Grant фиксированного расписания** (uc/fsched.c `fsched_tx_ctrl_frame`, uc/tx.c, fw/conn.c, 2026-10-31): AP отдаёт
  TXOP станции — по 802.11-2020 10.39.7.3 Source AID = AID станции (ответчика), Destination AID = AID AP (0, 9.4.1.8),
  AllocationType CBAP, Allocation Duration = 32768 («в текущем TXOP», 9.5.2 b), Beamforming Training = 0. vendor:
  Source AID 0, Destination AID 1 (AID произвольной станции), Allocation Duration = длине слота (по 9.5.2 a — «AP начнёт
  доступ через …»), BF Control = 7 (обещание SLS, которого нет; при Beamforming Training = 1 роли TXOP не меняются).
  AID станций uc берёт из нового общего fwsh_peer_aid (0x857964; fw пишет при WMI_CONNECT_EVENT). Grant Ack:
  Beamforming Training — копия из Grant (10.39.4), при 0 BF Control = 0 (vendor — всегда 7). Тесты: test_uc_grant_frame
  test_fsched_grant_fields, test_grant_ack_copies_beamforming_training; test_fw_reassoc (fwsh_peer_aid).
- **Старт AP/PCP без своего BSSID** (fw/wmi_h_pcp.c `l2mgr_pcp_start_flow`, 2026-10-31): vendor не ставил BSSID = свой
  адрес (802.11-2020 3.1) — он оставался от последнего WMI_SET_MAC_ADDRESS / WMI_CONNECT (адрес прошлого AP) /
  WMI_DISCOVERY_STOP; DMG Capabilities не пересобирался с max_assoc из WMI_PCP_START (поле Max Associated STA Number,
  9.4.2.127.3 — прежнее значение). Теперь l2mgr_apply_mac_address(own) до смены канала.
- **WMI_DISCOVERY_STOP** (fw/wmi_h_pcp.c `l2mgr_stop_discovery`): vendor возвращал BSS к адресу phy из flash, не к адресу
  интерфейса — BSSID и регистры BSSID становились адресом phy. Теперь — mid->mac.

- **DMG CTS-to-self нам** (uc/rx.c `rx_flow_handle_frame`, 2026-10-31): vendor сравнивал TA с копией своего адреса,
  снятой по LMAC 0x00 при загрузке fw (до WMI_SET_MAC_ADDRESS хоста) — при адресе интерфейса ≠ адресу phy ветка не
  срабатывала (стенд: копия 24:18:1d:26:d4:7b, интерфейс 26:18:1d:26:d4:7b). TA — с регистром своего адреса 0x886018.

- **MCS ответа через SIFS** (uc/rx.c `rx_frame_tx_resp_seq`, 2026-10-30): vendor запрашивает Ack/BlockAck у MTP без
  MCS (0xff → `0x17` без [1:0] = 3), MAC шлёт BlockAck на кадр MCS 8 на MCS 1 (стенд: наш uc и vendor-AP, r38
  received_mcs принятого BlockAck). 802.11-2020 10.6.7.2 — min(MCS запроса, 4) для SC, control PHY для кадра MCS 0.
  Исправлено: явный MCS только при MCS запроса ≥ 2 (для 0/1 выбор MAC и так по 10.6.7.2), биты скорости считаются
  до пути ответа; BlockAck на MCS 4 (стенд lowpwr3, FWERR 0); запас срока 0x37000020 — 40–48 тактов.

- Причина разрыва: свои коды `disconnect_reason` ≥ 0x10 (что именно оборвало связь), при отказе точки proto —
  её Status Code (docs/WMI.md «Причины разрыва SparRAW»). Vendor сливал разные отказы в 2/3/6 и терял Status Code.
- Фатальный ассерт fw/uc: хосту и в журнал — точный адрес вызова, дамп стека fw по нашему диапазону кода
  (docs/WMI.md «Фатальная ошибка: место»). Vendor отдавал caller (у половины вызовов 0), стек фильтровал
  по своему младшему отображению ICCM — у нас был бы пуст.

- Стековые буферы, уходящие в железо/хосту, обнуляются (vendor отдаёт остатки стека):
  правила MAC-парсера, дескриптор окна MACQ (mac_bringup), DBI-чтения pcie_l1_latency_wa,
  UT 0x42c и др.
- Буферы ящиков (события хосту, UT-ответы, LMAC-команды) — элемент пула обнуляет
  mem_pool_alloc_locked (vendor 0x8c33d0 не чистит — уходило содержимое прошлого сообщения).
- l2_mgr::connect_multi_omni: отложенный CONNECT берёт копию команды (vendor — указатель в
  запись кольца ящика, которую mbox__consume_one сразу отдаёт хосту).
- 0x8f5e6c: вызов по указателю [0x8000e8] (всегда 0 — переход на адрес 0) не повторён.
- 0x8d8230 (split-MAC IE): копия IE хоста в 256-байтный стек без проверки длины — в порту
  чтение напрямую из кадра (без переполнения).
- Отладочная область DBG 0x806a00..0x806a7f (include/dbg.h) — наша, vendor её не пишет.
- RX-сектор станции до первого BF (fw/discovery.c lmac_if_send_sta_cfg_05). vendor 6.2 слал в LMAC 0x05 RX-сектор
  из ещё пустого снимка BF — 0 (узкий сектор), а не 0xff («не обучен» → uc ставит омни 0x60 + cid). Станция ждала
  TRN точки на секторе 0: BRP-инициатор не слышал ответа, бит bf_sta_mask не снимался, ответчиком BRP станция не
  становилась — BRP не шёл никогда (сигнал в отчёте −72 дБм, луч не уточнялся). vendor uc это маскировал (успевал
  BRP-измерение, оно ставит омни); наш — нет. Доказано заморозкой uc в ожидании TRN (RX-сектор 0x6020 у vendor против
  0x0020) и метками записей rx_sel. Теперь 0xff, пока нет успешного BF. Стенд: BRP 4/4 (было 0/4), сигнал −65 дБм.
- Keep-alive в простое (fw/link_loss.c, ka_send_trigger). В vendor 6.2 ka_necessity_detector::task
  пишет в журнал «Initiating CMD_KEEP_ALIVE_TRIGGER to uCode», но команду uc 0x26 не шлёт. Ни один из
  60 вызовов lmac_if__post_cmd в fw 6.2 не передаёт id 0x26, а в 4.1 её шлёт lmac_if_keep_alive_trigger_handler.
  Поэтому путь uc internal_tx_flow_sm2 (RTS → CTS → кадр → Ack) у vendor не запускается никогда, и линк без
  трафика держится только маяками. В порту команда шлётся, как в 4.1. Стенд 2026-10-24, 150 с простоя:
  STA — 4 keep-alive, Ack 4/4; AP — 5 keep-alive, Ack 5/5; у vendor и у нас без починки — ни одного.

- Проверка входных данных хоста и эфира (аудит 2026-10-24), vendor не проверял:
  - WMI_SET_PASSPHRASE: пароль и SSID копировались по старой длине SSID (до 255 Б в буферы 64/32 Б
    dashboard) — теперь по своей длине, не больше буфера;
  - WMI_FIXED_SCHEDULING_CONFIG: индекс MCS до 255 в таблицу из 13 — записи с MCS ≥ 13 пропускаются;
  - WMI_SCHEDULING_SCHEME: num_allocs до 255 (2 + 15·n Б в TX-буфер 0x500) — не больше 4, как в драйвере;
  - SW_TX_REQ (split MAC, Assoc Response): длина < 0x18 давала тело ~65 КБ — тело 0;
  - WMI_RF_XPM_READ: при отказе проверки событие уходило длиной num_bytes + 4 (память fw за элементом
    пула) — при отказе только статус;
  - mid заголовка WMI без записи mid_list — запись через нулевой указатель в обработчиках; теперь
    «не поддерживается» (кроме WMI_PORT_ALLOCATE);
  - DMG-маяк с более чем тремя подходящими полями ESE (до 17 по 9.4.2.131) — fatal 0x11bb, остановка
    fw кадром из эфира; лишние поля пропускаются.
  - uc, Grant Ack: Duration Grant − 20 без отсечки (Grant с Duration < 20 → Grant Ack с ~32,7 мс NAV);
    теперь по 9.3.1.18 с отсечкой в 0;
  - uc/fw, номер станции BF: WMI TRIGGER_BEAMFORMING тип 1 передавал cid до 255 — запись за
    sls.attempts[8] и link_stat[8]; пир 8 (A-BFT) законен для bf_sta, но не для link_stat;
  - uc, BRP: число лучших подполей из настроек (до 63/255) без ограничения — сдвиг за brp_rank[rf][32];
  - uc, SLS: n_frames 0 (SSW с сектором 0xff) и > 64 (CDOWN не доходил до 0 при плане из 64).
  - uc, очередь запросов BF (bf_req, 8 мест): станций с запросом до 9 (0..7 и пир A-BFT) — 9-й затирал голову
    и ронял uc (assert 0x12); теперь при полной очереди запрос не ставится (повторит триггер BF).
  - uc, очередь запросов BF: «неожиданный» SSW станции, уже стоящей дальше в очереди, заменял голову без
    удаления той записи — дубль в FIFO; после него запись оставалась при пустой маске, и следующий запрос
    запускал BF не той станции. Теперь поздняя запись убирается.
  - uc, A-BFT станции: свой слот уже прошёл (GP0 взведён заранее, abft_gp0_periods ≥ слота) — vendor передавал
    SSW в более позднем слоте; по 10.42.5.2 — только в слоте со счётчиком 0: в этом A-BFT не передаём.
  - uc, RTS при занятом NAV: vendor отвечал DMG DTS (и в фазе SLS — без проверки NAV). По 10.39.6.6 DTS — только
    назначению SP (в open SP нет), а MAC писал в NAV-SA собственный адрес. Теперь по 10.3.2.9: нет ответа, кроме
    случая, когда NAV поставил кадр самого отправителя RTS (тогда DMG CTS).
  - uc, CF-End: ответный CF-End уходил с Duration 0 — теперь остаток последовательности по 9.3.1.6; CF-End нам NAV
    не сбрасывал — теперь в конце интервала Duration (10.23.2.10), как для чужих CF-End.
  - uc, L-RX из BRP Request: резервные 17–31 (9.5.4) принимались как длина TRN-R — теперь как 0.
  - uc, фиксированное расписание: 5-битный MCS из MAC (0..31) индексировал таблицу из 13 — вне её запись MCS 1.
  - fw, TDMA точки (код SparRAW, не vendor): PCP Active (B10) = 0 во всех окнах ESE — по 10.39.6.1 AP ставит 1 везде; фиксированное
    расписание (WMI 0xa03) и TDMA работали одновременно — теперь включение первого снимает TDMA.
  - uc, маяк: флаг готовности PCP ставил и B43 (PCP Association Ready), и Reserved B44 (байт 5 BI Control
    0x18 в эфире) — теперь только B43 (0x08); станция вместо B43 принимала и Reserved B44–B45 — теперь только B43.
  - fw, маяк AP: PCP Association Ready (B43) по 9.3.4.2 зарезервирован у non-PCP STA — точка в режиме AP шлёт 0
    (PCP — по готовности); станция проверяет B43 только в маяке PCP (11.1.3.7; BSS Type 3 — AP — не проверяет).
    Сознательно по стандарту: vendor STA (6.2) к такой точке AP не ассоциируется (ждёт B43 = 1).
  - fw, board-файл: список TX-секторов (brd_if__build_tx_sector_list) читал строки секции 3 общим указателем на
    8 «блоков» цельной секции (rf_vector 0) — на 7 длин за конец секции и буфера board-файла; всё ненулевое там
    становилось секторами, список всегда добивался до 0..63, а нулевые строки таблицы не убирали сектор из
    перебора маяков/TXSS и из DMG Capabilities. Теперь строки блока — из его описателя, цельная секция — один проход.
  - fw, кадры управления из эфира: DMG Capabilities пира копировался длиной из кадра (до 255 Б) в conn.dmg_caps[17]
    (даже элемент 802.11-2020 в 22 октета писал за массив), SSID из маяка (до 255) — в dband_info.ssid[32]; IE, выходящий
    за конец кадра, заносился в разбор с полной длиной; фиксированная часть (Status/AID, поля DMG-маяка) читалась без
    проверки длины. Теперь: копии ограничены размером буфера, IE за концом кадра не берётся, усечённый кадр отбрасывается.
  - fw, Block Ack из эфира: Buffer Size ADDBA Response (10 бит) сужался в u8 — 0/256/512/768 давали фатальный ассерт
    0x133e; резервное Block Ack Action (3..127) — фатальный ассерт 0x1298; длина тела и TA (против пира cid) не
    проверялись. Теперь: окно ≤ запроса и предела железа (32), окно 0 — отказ установки, неизвестное действие — хосту.
  - fw, discovery-маяк: при списке секторов board-файла короче 16 в перебор попадали пустые позиции (регрессия
    исправления списка секторов): число маяков discovery — не больше длины списка.
  - uc, BF/BRP: пир SPARRAW_PEER_UNKNOWN (кадр SSW/BRP от неизвестного TA) — запись за link_stat[8] (три места) и
    сохранение результата BRP в brp_rf_regs[rf][8] (= станция 0 соседнего RF, для RF 7 — таблица lin_to_db8_32);
    инициатор BRP сохранял AWV в станцию прошлой сессии ответчика (resp_sta) — чужая станция при ≥ 2 STA;
    L-RX 17..31 из SSW-Feedback/SSW-Ack (резерв, 9.5.4) запускал BRP с до 124 TRN-R. Теперь — только станции,
    своя станция инициатора, L-RX вне 0..16 — без BRP.
  - fw, ввод от хоста (WMI): cid ≥ числа станций — фатальный ассерт 0x11c9 (теперь «нет соединения»); NOTIFY_REQ с
    интервалом 1..16 мкс — ассерт планировщика; RF_XPM_READ 237..252 Б — запись за элемент пула событий (звено
    free-list); утечки TX-буфера (ADD_DEBUG_TX_PCKT, RCP_ADDBA_RESP без соединения); RS_CFG с MCS ≥ 13 или без MCS 1..12
    — выход за таблицы uc и вечный цикл rs_start; SCHEDULING_SCHEME с 4+ своими аллокациями — фатал 0x11bb;
    UT SAR-измерение с n = 0 — деление на 0 (бесконечный цикл libgcc); отладочная 0xfff (вечный цикл) не перенесена.
  - fw, board-файл: метка секции читалась до проверки смещения; запись наборов RF (0x8ffffe) — без сверки с длиной
    порции и с числом диапазонов до 255 в rf_set_ranges[32]; деление на 0 при пустой RX-маске; u8-счётчик цикла при
    ≥ 256 конфигурациях секторов.
  - fw, TDMA: Tguard (10.39.6.5) переполнял u32 при BI > ~21 с.
  - fw, разбор из эфира (мелкое): Vendor Specific IE (OUI, «старый» Wilocity 12 Б) и TLV Wilocity читались за телом
    элемента; Country — без длины; дамп кадра в журнал — за его концом; список app IE — без сверки длины блока.
  - fw, ассоциация STA: AID из Association Response не проверялся (0/255 → станция брала SP точки/широковещательные
    аллокации ESE за свои) — успех с AID вне 1..254 считается отказом (9.4.1.8).
  - fw, DELBA от инициатора (сессия, где получатель — мы) терялся без TX-стрима на TID, при стриме 9 рвал соединение —
    теперь всегда хосту.
  - uc, BF/BRP: полная очередь BF — пауза TX станции не снималась; config_brp_rf читал пустые записи brp_rank при числе
    выбираемых подполей больше разрешённых маской.
  - fw, свой DMG Capabilities: тело 17 октетов (802.11ad-2012) → 22 по 802.11-2020 9.4.2.127 (Beam Tracking Time Limit 0,
    Extended SC MCS 0, предел подкадров A-MSDU 0). Стенд: vendor 6.2 (точка) ассоциирует такую станцию, но сам копирует
    элемент длиной из кадра в 17-байтный буфер (та же ошибка, что исправлена у нас) — 5 Б за буфер на стороне vendor.
  - uc, маяк: A-BFT Count (B31–B36) при N A-BFT in Ant = 0 (одна RX-антенна, оба поля зарезервированы, 9.3.4.2) рос
    до 255 и заходил в B37–B38 — теперь держится 0.
  - fw, STA: WMI_DISCONNECT до ассоциации терялся. (1) CONNECT ещё ждёт радио — соединения нет, разрывать нечего:
    событие хосту не уходило (wmi_call timeout 2 с), отложенное подключение затем ассоциировалось вопреки отмене.
    Теперь — событие разрыва сразу, колбэк радио пропускается с откатом канала/состояния, BSS STA — в покой.
    (2) Захват линка (WAIT_FOR_BCON_RX / WAIT_FOR_LINKUP) — mid_disconnect_cmd соединение не трогал; теперь разрыв,
    а STOP_LINK в LM WAIT_LINK не ждёт результата BF (после начала разрыва он не приходил — разрыв висел,
    «is DISCONNECTING» до перезагрузки). Стенд: отмена через 0…90 мс — событие ≤ 60 мс, без Connect.
  - uc, NAV по CF-End нам с ответом: конец NAV считался от конца нашего ответного CF-End с Duration принятого —
    на SIFS + TXTIME(CF-End) позже конца интервала (10.23.2.10: от PHY-RXEND принятого); теперь — Duration ответа.
  - fw, remove_app_ie (порт): записи таблицы переходов vendor (смещения 0, 0x0a, 0x0d, 3, 6) читались как номера
    случаев — idx 1, 2, 4 вели к блоку IE по адресу 0, idx 3 — к чужому блоку; теперь смещения блоков по idx из
    целей переходов (0x1e0, 0x1c8, 0x1d4, 0x1b0, 0x1bc). Вызов пока один (idx 0) — ошибка была скрытой (gcc -fanalyzer).
  - fw, WMI_NOTIFY_REQ для CID без соединения: ответа не было — хост ждал таймаута (100 мс на CID, debugfs bf
    обходил 20 CID ~2 с с ошибками в журнале); теперь нулевое событие (статус BF 0, драйвер такие пропускает).
  - fw, ADDBA Request: Starting Sequence Number брался из ctx->ssn, который обновлялся только при остановке vring
    после ADDBA Response — запрос уходил с SSN 0, а TX MACQ начинает с 0x800 (группа 3, слово 1 дескриптора; стенд:
    первый кадр под BA = 0x800). Теперь SSN читается из дескриптора при сборке запроса (802.11-2020 9.4.1.8,
    10.25.2). Получатель больше не «чинит» окно по первому кадру; у vendor-пиров (тот же баг) — остаётся.
  - fw, WMI_UNIT_TEST calib_mgr_ut (модуль 7, sub 1): индекс движка калибровки от хоста не проверялся — чтение
    calib_mngr.eng[] и calib_engine_names[] за концом (6 движков). Теперь запись в журнал и отказ. Стенд: idx 9 —
    «calib_mgr_ut: engine index 0x9 out of range», fw работает.
  - fw, коды ассертов (ошибка порта, не vendor): 0x10e6, 0x10e8, 0x10e7 (vring) и 0x108d (tx_queue) были записаны
    как 0x12xx — vendor собирает их `mov_s r1,0xNN; bset_s r1,r1,0xc`. 0x12e6 и 0x12e7 совпадали с кодами калибровки.
    Сверены коды всех портированных функций с vendor — других расхождений нет.
  - fw, неверный параметр команды хоста — отказ с журналом «wmi cmd 0x%x: invalid value %u at +0x%x, rejected» вместо
    фатального ассерта vendor: VRING_CFG (ringid, tid, action), BCAST_VRING_CFG, VRING_BA_EN/DIS, SET_PCP_CHANNEL,
    BF_TRIG, RF_MGMT, SET_APPIE (ie_len > 1024; драйвер длину не ограничивает). Ответ с ошибкой — где драйвер его ждёт.
    Гонки с разрывом (BA_DIS по снятому стриму, RCP_DELBA для ушедшего cid) — журнал и выход. Стенд: семь неверных
    команд подряд — записи «rejected», fw жива, линк с данными.
  - fw, WMI_SET_ACTIVE_SILENT_RSSI_TABLE(0): vendor принимал 0 как допустимое и тут же падал ассертом 0x1588;
    теперь 0 — таблица по умолчанию. Стенд: команда запускает калибровку silent RSSI, fw жива.
  - fw, split MAC SW_TX_REQ без соединения (гонка с уходом станции): кадр освобождается, хосту SW_TX_COMPLETE (1)
    (vendor: утечка TX-буфера, драйвер ждал 2 с).
  - fw, опросы готовности железа без предела (SPI, таблицы парсера MAC/PRS, окно дескрипторов MACQ, онлайн-измерение
    PHY): при зависшем блоке fw висела молча. Теперь предел 2^25 опросов, таймаут — запись «hw poll timeout» и ассерт
    0x3002 (SPI — отказ чтения). В окне MACQ (общем с uc) цикл длиннее на 2 инструкции — ХРУПКО, дизассемблер сверен.
  - fw, очистка счётчиков MAC (cnt_handler_clear_all): vendor не замечал настоящего таймаута и ассертил (0x1187..0x1189)
    успех на последнем опросе; теперь таймаут — все опросы неудачны, только запись в журнал.
  - fw, START_LISTEN при отказе (PCP/AP или mid в состоянии 2): vendor отвечал LISTEN_STARTED(0), как успех; теперь 1.

- uc, NAV по 10.3.2.4 (tests/unit/test_uc_nav_update.py): предел 32767 мкс вместо 5000; Duration/ID ≥ 32768 NAV не
  ставит (10.28.3); истёкший NAV ставится любым Duration (vendor сравнивал с давно истёкшим концом — после ~36 мин
  тишины NAV не ставился); NAV по DMG Beacon соседа — его Duration без надбавки 1600 мкс.
- uc, Duration ответов (9.2.5.1): Grant Ack и CF-End на CF-End — вверх и точно (было на 1 мкс меньше).

- uc, SLS/A-BFT (tests/unit test_uc_sls_*, test_uc_beacon_*): SNR Report насыщается (−13…50,75 дБ, 9.5.3; vendor
  заворачивал по модулю 256); Total Sectors in ISS — секторы этой ISS, а не Capability; в SSW станции в A-BFT RF-цепь
  не попадает в RXSS Length (9.5.1, 9.2.2); A-BFT с IsResponderTXSS = 0 (RXSS ответчика) — станция не участвует
  (vendor шёл развёрткой, 10.42.2.3.3); пропуск aMaxABFTAccessPeriod — по A-BFT, а не по маякам (10.42.5.2).
- fw, очистка после разрыва (tests/unit/test_fw_conn_cleanup.py): элемент списка ранжирования соединений снимается
  при освобождении записи (vendor оставлял висячий после тайм-аута/отказа ассоциации и разрыва во время неё).
  У STA при разрыве сбрасываются AID и таблица SP из ESE (vendor: новая ассоциация с другим AID по тому же маяку
  оставляла окно прежнего AID с «инициировать» — передача в чужом SP).
  WMI_PCP_STOP при ассоциированных станциях отключает их и останавливает BSS (vendor: только журнал — маяки шли,
  WMI_PCP_STOPPED не уходил, wmi_pcp_stop драйвера — тайм-аут).
  ≥ 8 потерь связи за 4,5 с — запись в журнал, а не фатальный ассерт 0x142e (костыль vendor: падение fw по эфиру).
- fw, поддержание линка: старение TX 5 с (vendor 60 с), keep-alive точки в простое через 1 с (vendor 30 / 5 с) —
  пропавшая без разъединения станция снимается точкой за ~6,5 с, а не ~90 с (длинное старение у vendor терпело сон
  станции; энергосбережения в SparRAW нет). Хост меняет пороги WMI_LINK_MAINTAIN_CFG_WRITE.
- fw, AP: станция после SLS в A-BFT, не приславшая Association Request за 10 с, снимается (разрыв
  ASSOC_TIMEOUT); WMI_DISCONNECT_STA снимает и такую (vendor: соединение без ассоциации висело до перезагрузки — cid,
  запись станции uc, переживало PCP_STOP; tests/unit/test_fw_peer_vanish.py).
- fw, AP: Reassociation Request (9.3.3.7) — разбор с Current AP Address, ответ Reassociation Response (9.3.3.8), хосту —
  тело в форме Assoc Request (vendor: подтип 2 от станции с cid — фатальный ассерт 0x1200, элементы разбирались со
  сдвигом на 6 Б; tests/unit/test_fw_reassoc.py).
- fw, AP: (Re)Association Request ассоциированной станции — ответ на месте (тот же cid/AID, без Disassociation; ключ
  станции снимается, при RSNA — снова 4-way; хосту — WMI_CONNECT_EVENT того же cid), 11.3.5.3 a, k, l / 11.3.5.5.
  Включает драйвер WMI_REASSOC_INPLACE_CFG (0x85b, бит возможностей 28); без него — прежний путь (разрыв) —
  vendor: запрос отбрасывался, станции — Disassociation, вход только со второй попытки.
- fw, значения хоста (tests/unit/test_fw_wmi_validation.py, test_fw_wmi_fuzz.py): отказ WMI_BAD_PARAM с ответом
  вместо фатальных ассертов/записи за массивом vendor — cid WMI_SET_SECTORS, тип сети и канал CONNECT/PCP_START/
  BCON_CTRL (0x11ec, 0x119b), список каналов START_SCAN (> 4 — 0x1470), CFG_RX_CHAIN повторный (0x127c) и
  max_rx_pl_per_desc не степень двойки (0x1343), VRING_CFG с timeslot_us 0 (0x12b2), RCP_ADDBA_RESP с TID ≥ 8
  (0x1013), P2P_CFG с интервалом 0 (0x1243), DISCOVERY_START/LISTEN/SEARCH при скане или поднятом BSS
  (0x1235..0x123a), BCAST_VRING_CFG на занятое кольцо или до подъёма BSS (0x1287, 0x11f5).
- uc, SLS: CDOWN — 9 бит (9.5.1, 0..511); vendor держал счётчик развёртки в байте — при 64 секторах × 4 антеннах пира
  (259 передач) CDOWN 258 уходил как 2, развёртка обрывалась, Duration неверны (tests/unit/test_uc_sls_sweep.py
  test_cdown_beyond_255_frames, test_uc_ifs_duration.py).
- uc, SLS ответчик: ожидание SSW-Feedback после RSS — срок на все повторы инициатора (10.42.6.2, ≈ 482 мкс); vendor
  взводил GP0 словом за концом таблицы rss_wait_clk (индекс 10, никем не пишется — 0) (test_uc_liveness.py).
- uc, Duration SSW (9.3.1.15) и SSW-Feedback без BRP (9.3.1.16 b) вне A-BFT — не дальше конца текущего выделения
  (меньшее из «до TBTT» и «до конца окна ESE»); vendor — всегда до конца последовательности
  (test_uc_ifs_duration.py test_ssw_duration_capped_by_allocation_end, …feedback_duration_capped…).
- uc, команды LMAC 0x0c, 0x18, порядок и число секторов набора: индекс набора/станции вне таблицы и длина поля > 16 —
  assert и выход; vendor после assert (он возвращается) писал за txss_ss / запись станции.
- uc, переход RX→TX (mac_switch_rx_to_tx): заголовок нового кадра, разобранный между ожиданиями «канал свободен /
  приёма нет» и проверкой после них, — переход заново (дождаться конца кадра) и счётчик uc_stats.rx_to_tx_rewait;
  vendor — uc_assert 0x93/0x94 (быстрая ветка) и 141 (ветка BRP). На железе phy_rx_frame и cca_ppdu_comp меняются
  только с разбором заголовка, ≈ 9 мкс от начала кадра (стенд, метка STAMP_CCA_DET): окно ≈ 24 такта есть у любого
  перехода, например у повтора SSW-Feedback по таймеру (test_machw.py test_rx_to_tx_header_in_switch_window).
- uc, A-BFT ответчик: SSW-Feedback принимается, только если RA — свой адрес (9.3.1.16, 10.42.5.2); vendor сверял один
  TA с BSSID, и Feedback AP другой станции того же слота (коллизия RSS) брал как свой — чужой сектор и пропуск A-BFT
  (tests/unit/test_uc_sls_feedback.py test_abft_feedback_to_other_sta_ignored).
- fw, STA: после разрыва (любой путь, и отмена CONNECT, ждущего радио) BSSID BSS и регистры BSSID (парсер 0x886020 с
  битом «действителен», MAC 0x886df0, L2 0x881b28) — снова свой адрес, как после загрузки (sta_bss_set_idle); vendor
  оставлял адрес прежней точки — MAC помечал её маяки «своей BSS» (11.3.5.6/11.3.5.7: станция уже не ассоциирована;
  tests/unit/fwflows.py idle_state — test_fw_conn_cleanup, test_fw_peer_vanish, test_fw_sta_disassoc).
- fw, поиск (WMI_START_SEARCH → START_LISTEN / DISCOVERY_STOP): снятие маяка поиска возвращает настройку ответчика
  A-BFT загрузки (LMAC 0x23: beacon_type «любые маяки»); vendor оставлял настройку поиска (только маяки Discovery
  Mode = 1) — станция до перезагрузки не отвечала в A-BFT обычных маяков (10.42.5.1/10.42.5.2;
  tests/unit/test_fw_abft_cfg.py).

## Сохранённые особенности vendor (с комментариями в коде)

Примеры: WMI 0x9a6/0x9a7 отвечают id 0x19a5; 0xfff вечный цикл;
UT-модули на неизвестной подкоманде теряют элемент пула; link_lost_diag сравнивает с 80 °C
температуру BB, а не RF. Полный список — в комментариях `ХРУПКО:`/«баг vendor» в fw/.

## Как проверить

```
make BUILD=$B $B/fw.elf $B/uc.elf
python3 tools/build_fw.py --elf $B/fw.elf --uc-elf $B/uc.elf --vendor ../images/openwrt/fw/wil6210_6.2.0.1000.fw --out X.fw
tools/hwboot.sh X.fw 150      # RESULT: data
tools/linktest.sh 30 10       # ping/iperf3
```

## Стендовые проверки 2026-10-20 (tools/stand_tests)

| Путь | Результат |
|---|---|
| temp, stations, link_stats, bf, LED, PMC, WMI_ECHO | = vendor |
| BA add/del_tx/del_rx | работает; после DELBA связь восстанавливается (у vendor — нет) |
| FTM: сессия и результаты | = vendor: 0x1995 (3 измерения) + 0x1991 через ~17 мс; сырой RTT ≈ −0,3 нс (смещения не откалиброваны), заглушки ответчика TSF Sync/TOD/TOA Error; драйвер событий не обрабатывает |
| monitor (sniffer, WMI_CFG_RX_CHAIN) | = vendor (~3800 кадров/6 с) |
| AP: маяк/probe IE, EDCA, данные | = vendor; QoS Info исправлен на 0x08 (баг vendor; с 2026-10-31 — 0x00, U-APSD нет) |
| multi-omni connect | путь выполняется; данных нет и у vendor (AP не поддерживает) |
| PCIe remove/rescan, reset | не проверить: вешают хост .12 и с vendor fw |
