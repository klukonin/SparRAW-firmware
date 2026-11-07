# Эталонная модель DMG MAC (802.11-2020) — план полной реализации

Цель: исполняемая спецификация DMG MAC (Clause 9, 10.39–10.42, 11) для дифференциальной проверки прошивки
(fw + uc в эмуляторе cosim) и для генерации эталонного поведения. Правила — только из текста стандарта
(`docs/80211-2020.txt`, формулы — `docs/80211-2020.formulas.jsonl`), с номером пункта/таблицы/рисунка в
комментарии; код fw/uc и vendor не источник (иначе проверка становится тавтологией). Расхождения 2020/2024 —
отмечать, нормой считать 2020. Время — `fractions.Fraction`, мкс, моменты «на эфире» (10.3.7); такты 165 МГц —
только на границе с эмулятором (`timing.us_to_clk`).

## Модули

Готово (этап 1):
- `timing.py` — DMG PHY-тайминги (табл. 20-30, 20-4, TXTIME 20.11.3), IFS (10.3.2.3).
- `cbap.py` — EDCA backoff, NAV, TXOP, CBAP-окна, дискретно-событийный эфир «все слышат всех», `check_air_log`.
- `blockack.py` — Block Ack HT-immediate для DMG (10.25), кодеки ADDBA/DELBA/BA/BAR.
- `duration.py` — поле Duration/ID всех кадров DMG (9.2.5, 9.3.1.x, 10.39), `check_duration`.

Волна A (независимые модули, свой файл + свой test_*.py):
- `fields.py` — поля BF и управления DMG бит-в-бит: SSW field (9.5.1), SSW Feedback field (9.5.2), BRP Request
  field (9.5.3), BF Control field (9.5.5), Beamformed Link Maintenance (9.5.6), Dynamic Allocation Info (9.5.4?),
  Beacon Interval Control, Clustering Control, DMG Parameters (9.3.4.2), кадры управления DMG с Control Frame
  Extension (Poll, SPR, Grant, DMG CTS, DMG DTS, SSW, SSW-Feedback, SSW-Ack, Grant Ack, TDD…) и DMG Beacon
  (9.3.4.2) — encode/parse/validate.
- `elements.py` — элементы и тела кадров управления, нужные DMG: DMG Capabilities (9.4.2.127), DMG Operation
  (9.4.2.128), Extended Schedule (9.4.2.131) с Allocation, Next DMG ATI, DMG BSS Parameter Change, Relay/
  Multi-band — по мере нужды; тела Probe Request/Response, Association/Reassociation, Authentication,
  Disassociation/Deauthentication (9.3.3), порядок элементов (табл. 9-xx).
- `bi.py` — структура BI DMG (10.39.1–10.39.6): TBTT, BTI, A-BFT, ATI, DTI, CBAP/SP по Extended Schedule,
  длительности и границы, псевдостатичные SP, проверка журнала эфира на инварианты BI.
- `sls.py` — SLS (10.42.2, 10.42.4, 10.42.6.2): ISS/RSS/Feedback/Ack, CDOWN, выбор сектора, MBIFS/SBIFS/LBIFS,
  повторы и тайм-ауты; автоматы инициатора и ответчика.
- `abft.py` — A-BFT (10.42.5): слоты, FSS, выбор слота, счётчики неудач, повторы, ответ точки, несколько антенн.
- `brp.py` — BRP (10.42.3, 10.42.6.4): BRP setup, BRP-кадры, TRN, BRPIFS, транзакции уточнения; MIDC (10.42.6.3).
- `mlme.py` — DMG MLME: сканирование (11.1.4), ATI (10.39.3), аутентификация/ассоциация (11.3), состояния
  STA (11.3.1), тайм-ауты.

Волна B (интеграция):
- `medium.py` — направленный эфир: сектор передачи × конфигурация приёма → принят/не принят, квази-омни.
- `dmg_sta.py` — станция DMG (AP/PCP и non-AP) из модулей: BI, BF, доступ, MLME, BA; режимы «генератор» (ведёт
  себя по стандарту) и «судья» (проверяет поток событий).
- мосты cosim → эталон для BTI/A-BFT/SLS/BRP/ассоциации (как `unit/ref_bridge.py` для CBAP); дифференциальные
  тесты на сценариях: старт AP, вход STA (A-BFT → SLS → ассоциация → BA → данные), потеря и восстановление связи.
- `beamtrack.py` — сопровождение луча и поддержание связи (10.42.7, 10.42.9?), если нужно прошивке.

Эфир стенда (захват сниффером узлов, rewrite/docs/CAPTURE.md):
- `air_pcap.py` — pcap wilmon одного или двух узлов → журнал эфира `AirEv` (вид `unit/ref_bridge2.Ev` + что известно:
  время, Duration, тело, MCS); слияние по TSF точки, кадр TX одного узла и синтетический RX другого — одно событие;
  калибровка точки метки и сдвига TSF по парам кадров (если пар «TX станции — RX точки» нет — сдвиг по ответам MAC
  в обе стороны, RTS → DMG CTS по меткам RX); `to_cbap_log`/`to_bi_log` — кортежи судей cbap/bi.
- `air_judge.py` — судья над захватом: каждое правило модели, проверяемое по записанному (поля 9.x, Duration, MCS
  10.6.7, SIFS, продолжение TXOP, CF-End 10.23.2.10, доступ, BI, SLS), — проверено / нарушения с примерами и вердиктом
  (наше / трактовка модели / запись) / «не проверяемо» с причиной. `python3 -m ref.air_judge ap.pcap:AP sta.pcap:STA`
  `[--edca-from assoc_ap.pcap]`; при записях данных (`rxqos,txqos`) — Ack Policy, RD (10.29), окно BlockAck, Duration
  MPDU A-MPDU (9.7.3); с ассоциацией — тела кадров управления, ADDBA, EDCA Parameter Set → AIFSN и лимит TXOP.

Волна C (покрытие стандарта — `COVERAGE.md`: каждый DMG-пункт 9/10/11 со статусом модель/судья/нет/вне охвата):
- `nav.py` — несколько NAV (10.39.10, псевдокод буквально), виртуальный CS при нескольких NAV (10.3.2.1), сброс по
  NAVTimeout и CF-End, NAV_DTSCANCELABLE и конец SP (10.39.6.6.5); правила единого NAV DMG (10.3.2.4) и судья журнала
  узла `check_nav_log`.
- `beamtrack.py` — сопровождение луча (10.42.7): предел времени по табл. 10-31, условия запроса TRN-T, неудача и
  «опоздавший» ответ, обязанности ответчика (TRN-R на следующем PPDU с MCS > 0 в том же распределении, тип обратной
  связи), судья `check_bt_log`.
- `linkmaint.py` — поддержание направленной связи (11.27.1): согласование dot11BeamLinkMaintenanceTime (табл. 9-345),
  таймер связи с остановками (BTI, A-BFT, чужие SP/CBAP), события установки, судья `check_blm_log`.
- `air_judge` — правила `abft` (BIC по BI через abft.check_bic_sequence и кадры в объявленной A-BFT через
  abft.check_abft_log), `ati`, `assoc_state` (mlme.check_assoc_log: классы кадров 11.3.3, Disassociation 11.3.5.1),
  `brp_role` (10.42.3.1, 10.42.6.4.2–3), `nav_rx` (единый NAV узла по его RX-записям), `cts_self` (9.3.1.13),
  `blm` (11.27.1), `beam_track` (поле Beam Tracking Time Limit, табл. 10-31). Тесты правил — `test_air_judge_c.py`
  (журнал из событий, без pcap).

Волна D (агрегация MSDU и групповая доставка; `COVERAGE.md`):
- `amsdu.py` — A-MSDU DMG (9.3.2.2, 10.11): Basic и Short (кодирование/разбор, паддинг до 4, последний без паддинга),
  A-MSDU Present/Type QoS Control (табл. 9-11), адреса по табл. 9-30, пределы табл. 9-25 (MSDU 7920, A-MSDU 7935) и
  DMG Capabilities получателя (табл. 9-253/9-254), A-MSDU Supported ADDBA Response (9.4.1.13, 10.25.2), A-MSDU в A-MPDU
  (10.12.1, табл. 9-530), aPPDUMaxTime (10.13), время жизни; генератор `Aggregator`.
- `dms.py` — DMS (11.21.16.2): элементы DMS Request/Response (9.4.2.87/88), кадры WNM (9.6.13.26/27), TCLAS 0/1/4 и
  TCLAS Processing (9.4.2.30/32), бит DMS Extended Capabilities (11.21.1); точка `DmsProvider` (DMSID, копии, групповой
  MSDU → индивидуальный A-MSDU с групповым DA подкадра, групповая копия, Last Sequence Control) и станция
  `DmsRecipient` (отброс групп и дублей). GCR — вне охвата («DMG STAs do not use GCR»).
- `air_judge` — правила `amsdu` (по записям rxqos/txqos; без них — «не проверяемо») и `dms` (DMS-кадры, DMS-элементы
  Reassociation, групповой DA подкадра — только по принятому DMS). Тесты — `test_amsdu.py`, `test_dms.py`.
Волна E (DTI по расписанию — охват open, 10.39.6–10.39.9):
- `schedule.py` — Extended Schedule целиком (9.4.2.131: поле Allocation ↔ bi.Allocation + BF Control 9.5.5),
  проверка расписания BI (поле, BF, bi.check_schedule, aDMGPPMinListeningTime), повтор ES внутри BI, псевдостатика по BI
  (10.39.6.4), знание расписания у STA (obsolete allocation, пропуск ES), генератор `plan`, общий вид журнала `events`.
- `sp.py` — правила SP (10.39.6.2), восстановление (10.39.6.7), усечение (10.39.8.1), продление (10.39.9), CBAP
  расписания (10.39.5); судья DTI одного BI `check_dti` (вместе с dynalloc); генераторы обменов.
- `dynalloc.py` — PP/GP (10.39.7.2–3, ур. (10-18)), Grant Ack (10.39.4), Poll в ATI (10.39.3), Grant в CBAP, окна
  выделения (`Window`); генераторы `pp`/`gp`/`relinquish_grant`.
- `tdma_scen.py` — позитивный BI (SP с продлением, PP/GP в SP broadcast/broadcast, SP с BF и Heartbeat, CBAP) и
  негативные варианты (`NEGATIVE`: имя → изменение, правило).
- `air_sched.py` — правила судьи эфира `schedule`, `sp_access`, `dynalloc` (подключены в `air_judge.RULES`).

Волна F (адаптация линка, смена канала и параметров BSS; `COVERAGE.md`):
- `linkadapt.py` — адаптация линка DMG (10.43.1–10.43.3) и Link Measurement (11.10.11): кадры Link Measurement
  Request/Report (9.6.6.4/9.6.6.5), элементы TPC Report (9.4.2.16), DMG Link Margin (9.4.2.142, табл. 9-266, коды MCS),
  DMG Link Adaptation Acknowledgment (9.4.2.143); отвечающая STA (токен ≠ 0 — измерение на следующем кадре, RA = TA,
  DMG Link Margin, игнор у AP без dot11RMLinkMeasurementActivated), `TpcPeer` (LA Ack, 2·aPPDUMaxTime), быстрая
  адаптация (Fast Link Adaptation ⇒ RD, условия PPDU, IFS ≤ SIFS, отчёт до BRPIFS на MCS 1, рис. 10-95).
- `chswitch.py` — смена канала DMG BSS (11.8.8.6) и ECS (11.9 в части DMG): ECSA (9.4.2.52), кадр ECSA (9.6.7.7),
  Supported Channels (9.4.2.17, 11.8.2.2), Supported Operating Classes (Current Operating Class, 11.9.2), DMG-классы
  табл. E-4 (180, 181); `ApChannelSwitch` (счётчик по TBTT, объявление до смены), `StaChannelSwitch`,
  `check_ecsa_sequence`.
- `bssparams.py` — смена параметров DMG BSS (11.29.1–11.29.3, 11.29.5): план маяков (dot11NbrOfChangeBeacons,
  Beacon Interval на N+1, новый TBTT/BI, сброс TSF 11.1.3.3.1), судья ряда BTI `check_beacon_sequence`, запрет STA
  передавать за новый TBTT, рекомендация STA и ответ точки; каркас Information Request/Response (9.6.19.4/9.6.19.5).
- `air_judge` — правила `link_meas`, `link_margin`, `ecsa`, `supp_channels`, `bss_params`; air_pcap — имена действий
  Link Measurement, ECSA, Information Request/Response, Announce. Тесты — `test_linkadapt.py`, `test_chswitch.py`,
  `test_bssparams.py`. Перенести в `timing.py`: aMinPPDUDurationForDMGMeasurement (5,27 мкс, табл. 11-22),
  dot11NbrOfChangeBeacons DEFVAL.

Волна 3 (оставшиеся «Н»/«Ч» open; свой модуль + свой test_*.py, правила судьи — `air_wave3.py`):
- `discovery.py` — Information Request/Response (9.6.19.4/5, 11.28): Request/Extended Request (9.4.2.9/10), Subject
  Address (broadcast — только точке), «пустой» ответ (не-член BSS / non-AP не о себе), критерии ответа точки (SSID,
  BSSID, DA — 11.28.2), RCPI/RSNI «нет измерения»; станция `InfoStation`.
- `qab.py` — QAB (11.35): Quiet Period Request/Response (9.4.2.149/150), QAB Request/Response (Public Action 16/17,
  9.6.7.34/35, Protected Dual), тихие интервалы, SP точки «сама себе» без передачи; `QabRequester`/`QabResponder`.
- `handover.py` — передача PCP (11.27.2): Next PCP List, PCP Handover (9.4.2.140/141), Handover Request/Response
  (9.6.19.6/7); явная (`HandoverPcp`, `HandoverMember`) и неявная (`ImplicitCandidate`, `choose_new_pcp`) передача,
  неизменность псевдостатического расписания.
- `protperiod.py` — защищённый период DMG (10.39.6.6): прослушивание aDMGPPMinListeningTime, RTS/DMG CTS/DMG DTS в SP,
  Duration DTS (через duration.duration_dts), DTS без RTS после aRTSTimeoutTime, отчёт о помехах (Constraint).
- `tspec.py` — DMG TSPEC (9.4.2.133), DMG ADDTS Request/Response и DELTS (9.6.3.x), правила 11.4 для DMG: Allocation ID,
  TS Delay, TCLAS/U-PID, ответ обеим сторонам, Extended Schedule после SUCCESS, удаление (11.4.9), форматы (11.4.13).
- `spsh.py` — spatial sharing (11.30): Directional Channel Quality request/report (9.4.2.20.16/9.4.2.21.15) в Radio
  Measurement Request/Report (9.6.6.2/3), запросы точки (ANIPI — оценка, RSNI — сопровождение), антенна измерения,
  совмещение SP после отчётов, устойчивость BSS к смене канала (11.30.4, `SwitchBackoff`).
- `capelems.py` — RSNE DMG (наборы шифров/AKM, умолчание GCMP-128, RSN Capabilities по роли, выбор STA 12.6.3, табл.
  12-5), Extended Capabilities (табл. 9-153 целиком), Supported Operating Classes (9.4.2.53, классы 60 ГГц табл. E-4).
- `ampdu.py` — A-MPDU DMG: разделитель (рис. 9-975), CRC (9.7.2), паддинг, предел длины (10.12.2), Minimum MPDU Start
  Spacing (10.12.3), групповой RA (10.12.4); `qosctl.py` — генератор и проверка QoS Control данных DMG (9.2.4.5).
- `air_wave3` — правила `info_req`, `qab`, `pcp_handover`, `prot_period`, `addts`, `spsh`, `rsne`, `ext_caps`,
  `op_classes`, `ampdu_limits`, `qos_ctl`; «не проверяемо» — `info_resp_supported`, `pp_listening`, `handover_implicit`,
  `qab_peer`, `spsh_measure`, `ampdu_spacing`, `tspec_admission`. Тесты — `test_air_wave3.py`.

Волна 4 (кластеризация AP/PCP — охват open; необязательные возможности, которых в open нет; решения 2026-11-07):
- `cluster.py` — кластеризация DMG AP/PCP (10.40, 11.29.4, 11.1.3.3.1): Beacon SP_n (ClusterTimeOffset, ClusterMaxMem —
  целые мкс, предел Beacon SP Duration), элементы Cluster Report (9.4.2.146), ECAPC Policy (9.4.2.154), Cluster Time
  Offset (9.4.2.155); децентрализованный кластер `DecentralizedAp` (S-AP, пустой Beacon SP, вход члена, Beacon SP других
  в Extended Schedule, мониторинг и передача роли S-AP, встреча двух S-AP, уход при S-AP с ECAPC = 1); централизованный
  `CentralizedSap`/`CentralizedMember` (шаги конфигурации/проверки, карта Available Cluster Time Offset, выбор индекса,
  копии полей, потеря S-AP, слепота), BHI/TXSS CBAP (10.40.3.4), Cluster Report от STA (10.40.4), Cluster Request
  (10.40.5), смена параметров BSS в кластере (11.29.4); проверки записей `check_own_beacon`, `check_beacon_series`,
  `check_member_vs_sap`, `check_beacon_sps_scheduled`, `check_sta_report`, `check_change_beacons`.
- `optcaps.py` — что наши кадры не объявляют: relay (Relay Capabilities/Transfer Parameter Set, DMG Action 8–22), MMS
  (9.4.2.152), multi-band/FST (Multi-band, Switching Stream, Session Transition, категория FST — pro, будущее),
  энергосбережение (Triggered Unscheduled PS, PS-биты Extended Capabilities табл. 9-153, PS-элементы, PS-Poll/ATIM/PSC/
  WNM Sleep/TIM, Power Management = 1); PSC Response точки — только отказ.
- `air_wave4.py` — правила судьи `cluster` и `opt_caps`; «не проверяемо» — `cluster_monitor`, `cluster_ccsr`,
  `cluster_blind`, `cluster_handover`, `cluster_txss_cbap`. Тесты — `test_cluster.py`, `test_optcaps.py`,
  `test_air_wave4.py`.

Волна 5 (закрытие «Н» и «Ч» карты COVERAGE.md; трактовки №100–№110):
- `addrs.py` — поля адресов (9.2.4.3), Address 3 кадров управления (9.3.3.1 c)), Public Action (11.17), To DS/From DS
  (табл. 9-3/9-4), заголовок данных DMG (9.3.2.1, табл. 9-30): только QoS Data/QoS Null, без HT Control, QoS Null без
  тела.
- `actions.py` — табл. 9-51 и таблицы действий 9.6 с допустимостью для DMG (open/pro/out/nondmg), Action No Ack
  (9.3.3.14), возврат нераспознанного (10.28.4), функции WNM по битам Extended Capabilities (9.6.13.1, 11.21.1).
- `tpc.py` — TPC Request/Report (элементы 9.4.2.15/9.4.2.16, кадры 9.6.2.4/9.6.2.5, 11.7.7).
- `tclas.py` — TCLAS всех типов 0–10 (9.4.2.30): кодек, проверки, сопоставление MSDU/MPDU.
- `staavail.py` — STA Availability (9.4.2.132), Poll и PP Available (10.39.7.1).
- `addbaext.py` — ADDBA Extension (9.4.2.139), фрагментация DMG по соглашению (10.2.6).
- `sectorpat.py` — Antenna Sector ID Pattern (9.4.2.156): кодек, генераторы рис. 9-605/9-606, секторы маяков.
- `tsf.py` — Timestamp/TSF (9.4.1.10, 11.1.3.1): то, что проверяемо без внешней опоры времени.
- `sprecovery.py` — восстановление SP по ATI (10.39.6.7, 10.39.3); `sp.check_dti(reclaimed=…)`.
- `ecs.py` — Max Channel Switch Time (9.4.2.217), OCV/SA Query после смены канала (11.9.3.2); DSE — ВНЕ.
- `bftrain.py` — MLME-BF-TRAINING (6.3.91, 11.36) над моделью SLS/BRP.
- `air_wave5.py` — правила судьи `addr`, `data_hdr`, `action_fmt`, `wnm`, `tpc`, `tclas`, `sta_avail`, `addba_ext`,
  `asid_pattern`, `timestamp`, `sp_recovery`, `ecs`, `bf_training`; «не проверяемо» — `addr_rx_filter`,
  `tclas_classification`, `tpc_power_accuracy`, `ocv_validation`, `bf_request_brp`, `wnm_reject_status`. Тесты —
  `test_<модуль>.py`, `test_air_wave5.py`.

## Правила для каждого модуля
- Заголовок `# SPDX-License-Identifier: AGPL-3.0-or-later`, докстрока: охват (пункты) и что НЕ моделируется.
- Комментарии по-русски, у каждого правила — пункт/таблица/рисунок; цитаты из стандарта не длиннее строки.
- Тесты `test_<модуль>.py`: ожидания из текста стандарта (числа из таблиц и формул, примеры рисунков), не из кода.
- Только своя пара файлов; общие (`timing.py`, `__init__.py`, `cbap.py`) не править — нужное добавить в свой модуль
  и отметить «перенести в timing.py» в отчёте.
- Общие постоянные — только в `timing.py` (TU, табл. 11-22, MIB DEFVAL нескольких модулей, длины/TXTIME SSW-кадров,
  IFS и допуски, BRP-времена, aSSDuration/aSSSlotTime, пределы общих подполей, AID, коды AllocationType); модуль их
  импортирует и не определяет заново — это проверяет `test_consistency.py` (список `MODULES`: новый модуль добавить
  туда после сведения его постоянных; `medium.py` пока не сведён — свои MAX_SECTORS_PER_ANT/…_PER_STA).
- Спорное место: «СПОРНО:» в коде; если вопрос решается в двух модулях — одно решение здесь, в «Принятых
  трактовках», а в коде «СПОРНО → принято (PLAN.md №N)».

## Принятые трактовки

Норма — 802.11-2020; 802.11-2024 — для разрешения неоднозначностей (пункты 2024 на 1 меньше: 10.42 → 10.41).
Сводная проверка — `test_consistency.py`.

| № | Вопрос | Решение (модули) | Пункт | Почему (2020 / 2024) |
|---|---|---|---|---|
| 1 | FSS: число кадров или значение поля в aSSDuration/aSSSlotTime и в «no less than aSSFramesPerSlot» | Число кадров = поле + 1 везде; минимум — ≥ 4 кадров (поле ≥ 3) (bi, abft, fields; формулы — `timing.ss_*`) | 9.3.4.2, 10.42.5.2, табл. 11-22, рис. 10-75 | 2020: поле — «number of SSW frames allowed minus one», рисунок «value of FSS is 8» при 8 SSW (и «A-BFT LENGTH = 8» при 8 слотах — рисунок везде считает количества). 2024: тот же рис. 10-89; табл. 10-36 «Value of the FSS subfield» — сырое поле, но только для Short SSW (EDMG) |
| 2 | CDOWN «including any LBIFS if required» | LBIFS — одна передача (CDOWN −2 через LBIFS); альтернатива — `sls.slots_cdown(lbifs_in_cdown=False)` (sls, abft) | 10.42.2.2.2, 10.42.2.3.2, 10.3.2.3.11 | Текст 2020 = 2024. LBIFS = TXTIME(SSW) + 2·SBIFS — ровно один шаг сетки TXTIME(SSW)+SBIFS, поэтому «expected end time» по CDOWN вычислим из любого кадра |
| 3 | Total Sectors in ISS: поле = N или N − 1 (пример «set to 24») | Поле = N − 1, модель хранит N; альтернатива — `fields.total_sectors_raw_alt` (fields, sls) | 9.5.3, 10.42.2.2.1 | 9.5.3 «0 to 511, representing 1 to 512 sectors» — определение кодирования; пример называет количество. 2024 — оба текста без изменений |
| 4 | Допуски слота A-BFT на эфире | Одна формула aSSSlotTime (`timing.ss_slot_time`); первая SSW — [начало слота, +aAirPropagationTime]; последняя — до начала + aAirPropagationTime + aSSDuration; SSW-Feedback — [точка рис. 10-76, +MBIFS_TOL] (bi, abft) | 10.42.5.2, рис. 10-76, 10.3.2.3.10 | Стандарт (2020 = 2024) задаёт точку без допуска; слагаемое aAirPropagationTime «accounts for the propagation delay»; MBIFS — «−0% or +10%» |
| 5 | Конец BTI | Конец последнего DMG Beacon + его Duration; генераторы — запас 0, Duration через `duration.duration_dmg_beacon` (bi, abft, sls) | 10.42.5.1, 9.3.4.2 | «BTI is completed at the expiration of the value within the Duration field of the last DMG Beacon» — 2020 = 2024 |
| 6 | Округление SNR Report | К ближайшему шагу 0,25 дБ, половина — вверх, насыщение −13…50,75 дБ (`fields.snr_quantize`; sls вызывает его) | 9.5.3 | Округление не задано ни в 2020, ни в 2024; ранее sls округлял половину вниз, fields — вверх |
| 7 | TX Sector ID «set to 0x63» в 6-битном поле | 63 (все единицы) (fields, brp; `timing.TX_SECTOR_NOT_SWEPT`) | 9.5.4 | 0x63 = 99 не кодируется в 6 бит; 2024 — тот же текст |
| 8 | Допуск PIFS в DMG | Как SIFS/MBIFS: −0 … +10 %·(aSlotTime − aAirPropagationTime) (`timing.PIFS_TOL`; sls) | 10.3.2.3.4 | Не задан ни в 2020, ни в 2024 |
| 9 | CBAP Source при CBAP Only = 0 | Должен быть 0 (bi, fields; `fields.check_dmg_params(cbap_source_strict=False)` — мягкое чтение) | 9.4.1.46 | «valid only if the CBAP Only subfield is 1 … set to 1 to indicate that the AP or PCP has higher priority … set to 0 otherwise» — 2020 = 2024; без CBAP Only приоритета нет → «otherwise». Ранее fields не проверял |
| 10 | dot11MaxLostBeacons: DEFVAL или aMinBTIPeriod | 4 — одно значение (`timing.DOT11_MAX_LOST_BEACONS`) (bi, mlme) | 11.1.3.3.3, MIB | DEFVAL { 4 } и «A DMG AP shall set dot11MaxLostBeacons to … aMinBTIPeriod» (= 4) совпадают |
| 11 | «within dot11MaxBFTime beacon intervals» | N·BI от начала SLS/BRP (sls T2, brp `bf_brp_expired`) | 10.42.1 | Граница N-го TBTT требовала бы сетки BI; текст 2020 = 2024 |
| 12 | Переход младших 32 бит TSF (Allocation Start) | Ближайшее к опорному TSF значение / сравнение по модулю 2³² (разность < 2³¹ — «не раньше») (bi `full_tsf`, elements) | 9.4.2.131, 10.39.6.1 | Поле — «lower 4 octets of the TSF», о переходе текст молчит |
| 13 | Единицы постоянных табл. 11-22 | В мкс (aMaxBIDuration = aMinChannelTime = 1000 TU = 1 024 000 мкс); MIB-значения в TU — целые TU (bi, mlme) | 3.1, табл. 11-22 | Раньше mlme держал aMaxBIDuration в TU, bi — в мкс |
| 14 | LBIFS между SSW ответчика в A-BFT | Допустим при смене DMG-антенны (иначе — только SBIFS) — судья bi приведён к abft | 10.3.2.3.11, 10.42.2.3.2, 10.42.5.2 | 2020 = 2024; расхождение найдено сверкой генератора abft с судьёй bi |
| 15 | Порядок Service Hash / RSN Extension в Probe Response | RSN Extension — 92, после Service Hash (91) (elements) | табл. 9-39 (2020) / 9-69 (2024) | 2020: у обоих номер 91 (опечатка); 2024 исправляет на 91/92 — следуем уточнению |
| 16 | Точка метки TSF записи PMC в PPDU (захват стенда) | Метка TX = точка Timestamp DMG Beacon (на стенде Timestamp == метке TX у всех маяков) = начало символа данных с первым битом кадра: начало PPDU + T_STF + T_CE + T_header (SC) / + 40·32·Tc (control) (`air_pcap.PRE`); метка RX и сдвиг TSF второго узла — по парам кадров в обе стороны, без пар «TX станции — RX точки» — сдвиг по ответам MAC в обе стороны (RTS → DMG CTS, метки RX; равное время ответа узлов — на стенде 4,52 / 4,54 мкс по меткам TX) (air_pcap.calibrate) | 11.1.3.1, 20.11.3 | Документации нет; промежутки внутри класса модуляции от выбора не зависят, control ↔ SC — ±0,75 мкс (`air_judge.PRE_UNCERT`); суммы SIFS двух узлов (`air_judge.sifs_sum`) не зависят ни от чего |
| 17 | Допуск сравнения времени в захвате | Номинал ± (1 мкс кванта меток + 0,25 мкс калибровки [+ 0,75 control ↔ SC]); средние по многим кадрам — без кванта (BTI: ±2/(n−1)) | 10.3.2.3.x | Метки TSF — целые мкс; допуски стандарта (SIFS +0,49, SBIFS +0,03) меньше кванта |
| 18 | BA Control B0 | Reserved — должен быть 0 (air_judge `ba_control`) | рис. 9-42, 9.2.2 | 2016: B0 — BA Ack Policy; 2020 и 2024 — Reserved |
| 19 | Duration DMG CTS: номинальный SIFS (9.3.1.13) или измеренный промежуток (9.2.5.7) | 9.3.1.13 — DMG-правило; разность с 9.2.5.7 — в info судьи (`dur_cts`) | 9.3.1.13, 9.2.5.7 | 9.2.5.7 — общее правило для CTS, 9.3.1.13 — частное для DMG CTS |
| 20 | Initiator в BRP после SLS: правило бита (10.42.6.4.1: 1, если «the previous received frame was not a BRP frame») или роль (10.42.3.1: в том же распределении «the SLS initiator is the beam refinement initiator») | Роль: ответчик SLS не шлёт BRP с Initiator = 1 в распределении SLS; правило бита — следствие роли (ответчик, не получивший BRP инициатора, ждёт, а не начинает свою транзакцию). «Распределение» в CBAP-only DTI — до следующего BTI (air_judge `brp_role`) | 10.42.3.1, 10.42.6.4.1–3, 9.4.2.129 | 2020 = 2024 (10.41.3.1). 10.42.6.4.2: «A beam refinement transaction starts with the beamforming initiator STA sending a BRP frame with the Initiator field set to 1» |
| 21 | Поиск таймера в NAV_TIMER_UPDATE: ветка «Ack \|\| NAVSRC(x)=R_DST» делает обратную пару недостижимой | Буквально (`nav.MultiNav(literal=True)`); `literal=False` — обратная пара совпадает (nav) | 10.39.10 | Текст 2020 = 2024 (10.38.10) |
| 22 | Исключение «DMG CTS с TA = свой — NAV не обновлять» при нескольких NAV | Только для единого NAV (10.3.2.4 — «DMG STAs that support a single NAV»); псевдокод 10.39.10 исключения не содержит (nav, air_judge `nav_rx` — единый NAV) | 10.3.2.4, 10.39.10 | 2020 = 2024 |
| 23 | A-BFT на эфире для судьи | BI с Next A-BFT = 0: начало — конец BTI (Duration последнего маяка, №5) + MBIFS (10.42.5.1), длина — (A-BFT Length + 1)·aSSSlotTime(FSS + 1) (№1); кадры в ней — abft.check_abft_log (air_judge `abft`) | 10.42.5.1, 10.42.5.2 | 2020 = 2024 |
| 24 | Вид синтетической RX-записи данных (FC по слоту парсера) для класса кадра | Тип Data → класс 3 в инфраструктуре при любом подтипе (11.3.3 c) 1)); подтип QoS Null — по длине 30 октетов (air_judge `assoc_state`) | 11.3.3 | Запись не несёт FC синтетических кадров (air_pcap) |
| 25 | Свой dot11BeamTrackingTimeLimit в табл. 10-31, если MIB не виден | = своему полю DMG STA Beam Tracking Time Limit (9.4.2.127.4: поле «contains the value of dot11BeamTrackingTimeLimit»), при 0/нет поля — DEFVAL 10 000 мкс (beamtrack, air_judge `beam_track`) | 9.4.2.127.4, табл. 10-31 | 2020 = 2024 |
| 26 | Порядок октетов Length в подкадре Short A-MSDU | Basic — как IEEE 802.3 (старший октет первым, 9.3.2.2.2 «same as the IEEE 802.3 frame format»); Short — по 9.2.2 (младший первым) (amsdu) | 9.3.2.2.2, 9.3.2.2.3, 9.2.2 | Для Short ссылки на 802.3 нет ни в 2020, ни в 2024 — действует общее правило 9.2.2 |
| 27 | Short A-MSDU «only between a pair of STAs that communicate directly», «cannot be used for frame forwarding» | DA/SA — из заголовка (табл. 9-30, столбец «MSDU and Short A-MSDU»); пересылка = 1/1, или 0/1 с Address 3 (SA) ≠ TA, или 1/0 с Address 3 (DA) ≠ RA (amsdu) | 10.11, табл. 9-30 | «Directly» не определено через адреса; критерий — MSDU не идёт дальше пары RA/TA |
| 28 | Адреса A-MSDU при пересылке через PCP (PBSS, PCP Forwarding = 1) | RA = такой PCP — DA подкадров любые (и групповые, не DMS); TA = такой PCP — SA подкадров исходные (правило TA = SA табл. 9-30 не применяется) (amsdu.check_addresses ra_is_pcp_fwd / ta_is_pcp_fwd) | 10.11, табл. 9-30 | 10.11: «The DA field of the A-MSDU shall be set to the destination's individual or group address»; о передаче PCP дальше текст 2020 = 2024 молчит |
| 29 | Несколько DMS Request/Response элементов | Новый элемент — только когда следующее поле не помещается в 255 октетов текущего (жадная упаковка); лишнее разбиение — нарушение (dms) | 11.21.16.2 | «If the length … exceeds 255 octets, then multiple … elements shall be included, each containing only those … completely contained within 255 octets» — 2020 = 2024 |
| 30 | Копии TCLAS в DMS Status против «предложения» при отказе и ответа на «Change» | Accept на Add — точная копия TCLAS/Processing/TSPEC/подэлементов; Denied — копия или предложение (меньше TCLAS, один TCLAS — без Processing); ответ на Change несёт TCLAS потока, сверяются TSPEC и подэлементы; «≥ 1 TCLAS» (9.4.2.88) проверяется у Accept (dms) | 11.21.16.2, 9.4.2.88 | 11.21.16.2 требует копию и при Accept, и при Denied, но тут же разрешает при Denied предлагать другие TCLAS; запрос Change TCLAS не несёт, а 9.4.2.88 требует их в Accept/Denied |
| 31 | Срок жизни DMS-соглашения | Повторная ассоциация к той же точке — сохраняется (11.3.5.4 c) «not affected»: «DMS agreements»); к другой и при потере ассоциации — снимается (dms.DmsProvider) | 11.3.5.4 | Про разассоциацию текст 2020 = 2024 молчит; соглашение относится к ассоциации (DMS provider — для «associated STAs») |
| 32 | Групповая копия, когда DMS просили все связанные станции | Не передаётся (dms.transmit_group); судья не проверяет (dms_group_copy) | 11.21.16.2 | «shall continue to transmit … as group addressed frames … if at least one associated STA has not requested DMS» — обязанности в обратном случае нет |
| 33 | «Дубли» после прекращения DMS по Last Sequence Control | Групповой кадр той же группы с SN не новее Last SN (в окне 2048 назад по модулю 4096) — дубль; первый более новый снимает фильтр; 65 534 и 65 535 — фильтра нет (NOTE 2) (dms.DmsRecipient) | 11.21.16.2, 9.4.2.88 | Окно дубля не задано; 2048 — как полуокно номеров 10.25.6 |
| 34 | A-MSDU вне соглашения BA у DMG | Разрешено (одиночный MPDU, любая Ack Policy, кроме ограничений A-MPDU), с пределами DMG Capabilities получателя (amsdu) | 10.11 | Обязанность приёма A-MSDU вне BA перечислена для HT/VHT/CMMG, для DMG — нет; запрета передачи тоже нет, предел — поля табл. 9-253/9-254 (2020 = 2024) |
| 35 | Отчёт быстрой адаптации не по условиям 10.43.3 (MCS ≠ 1, без агрегации, позже BRPIFS, IFS > SIFS) | Не нарушение — откат на 10.43.1 («If at least one of the conditions above … is not met, the STA may follow the rules in 10.43.1»); нарушения — только у начавшего (запрос: Action No Ack, токен 0, AGGREGATED, > aMinPPDUDurationForDMGMeasurement, обе стороны с Fast Link Adaptation) и Fast Link Adaptation = 1 при Reverse Direction = 0. В open RD выключен намеренно (10.29.4) — Fast Link Adaptation = 0 (linkadapt, air_judge `link_meas`) | 10.43.3, 10.29 | 2020 = 2024 (10.42.3) |
| 36 | Кодирование SNR в DMG Link Margin | Как SNR Report 9.5.3: 4·(SNR − 19) в дополнительном коде (тот же диапазон −13…50,75 дБ шагом 0,25; `fields.snr_report_raw`, квантование — №6) (linkadapt) | 9.4.2.142 | 9.4.2.142 даёт только диапазон и шаг (2020 = 2024); 256 значений диапазона совпадают с 8 битами 9.5.3 |
| 37 | Reference Timestamp DMG LA Ack и момент «acknowledged the reception» | LA Ack: Reference Timestamp — копия Reference Timestamp подтверждаемого DMG Link Margin (судья допускает и конец PPDU принятого отчёта ± 10 мкс); срок 2·aPPDUMaxTime — от конца Ack на отчёт, у Action No Ack — от конца PPDU отчёта; Reference Timestamp отчёта в TSF отвечающего сверяется с концом PPDU захвата ± 10 мкс, вердикт model (linkadapt, air_judge `link_margin`, `link_meas`) | 9.4.2.143, 10.43.2 | 9.4.2.143 дословно повторяет определение 9.4.2.142 (для LA Ack «feedback» не определён); ссылка «described in 10.42.9» — устаревшая (в 2024 — 10.41.9; по смыслу 10.43) |
| 38 | dot11NbrOfChangeBeacons: DEFVAL 4 и «shall be greater than dot11MaxLostBeacons» (= 4, №10) | Норма — требование: наименьшее допустимое 5, модель по умолчанию 5; судья требует > 4 объявлений (bssparams, air_judge `bss_params`) | 11.29.2, 11.29.3, MIB | DEFVAL { 4 } в 2020 и 2024 — противоречит тексту 11.29.2/11.29.3 обоих изданий |
| 39 | Элемент DMG BSS Parameter Change в маяках TBTT N+1 при переносе TBTT | Модель включает (11.29.1: «in every DMG Beacon … after … first included, stopping … immediately after the … change takes effect» — вступает на новом TBTT N+2); судья допускает и без него («sent at each TBTT dot11NbrOfChangeBeacons times»); после сброса TSF элемента быть не должно (bssparams) | 11.29.1, 11.29.2 | 2020 = 2024; два абзаца дают N и N+1 объявлений |
| 40 | Beacon Interval на TBTT N+1 при переносе TBTT (поле — в TU) | Разность нового TBTT и TBTT N+1 кратна TU (модель); судья — отклонение BI·TU от разности < 1 TU; точка, принимая рекомендацию STA, округляет TBTT вниз до сетки TU от TBTT N+1 (bssparams) | 11.29.2, 9.4.1.3 | TBTT Offset — мкс, Beacon Interval — TU: некратный сдвиг не представим; текст молчит (2020 = 2024) |
| 41 | Supported Channels DMG STA: 11.8.2.2 «shall provide … a list of channels» или условие табл. 9-34/9-36 («present if dot11SpectrumManagementRequired is true and dot11ExtendedChannelSwitchActivated is false») | DMG-правило 11.8.2.2: Supported Channels в (Re)Association Request или в Information Request STA — обязательно (chswitch, air_judge `supp_channels`) | 11.8.2.2, табл. 9-34, 9-36 | Частное DMG-правило против общего условия таблицы; 2020 = 2024 |
| 42 | ECSA в DMG BSS: счётчик при нескольких маяках BTI, кадр ECSA, режим 1 | Count — число TBTT: одинаков во всех кадрах BI, −1 на каждый TBTT; Count 0 — смена в любой момент после кадра (кадр без ECSA после него — уже после смены); объявление, оборванное до момента смены, — нарушение; кадр ECSA (Public Action) в DMG BSS не обязателен (11.8.8.6 называет DMG Beacon, Announce, Information Response), но если послан — Address 1 широковещательный (11.9.1); режим 1 в DMG STA может игнорировать — передачи STA после него не нарушение (chswitch, air_judge `ecsa`) | 11.8.8.6, 9.4.2.52, 11.9.1 | 2020 = 2024 |
| 43 | Dialog Token 0 в Link Measurement Request | Допустим у DMG (10.43.1 «If the Dialog Token field … is equal to 0», 10.43.3 — обязателен для быстрой адаптации) — не нарушение 9.6.6.4 «set to a nonzero value» (linkadapt) | 9.6.6.4, 10.43.1, 10.43.3 | Общий формат против DMG-правил; 2020 = 2024 |
| 44 | Источник полей отчёта при токене ≠ 0 | Буквально: TPC Report Link Margin, RCPI, RSNI, Receive Antenna ID — по кадру запроса (9.6.6.5, 9.4.2.16 «of the corresponding Link Measurement Request frame»); MCS, SNR, Link Margin DMG Link Margin и Reference Timestamp — по следующему кадру запросившего (10.43.1) (linkadapt) | 9.6.6.5, 10.43.1 | 2020 = 2024 |
| 45 | Начало отсчёта Response Offset в PP и Duration SPR | От конца Poll (10.39.7.2: «at the time offset from the end of the Poll frame»; O_1 = SIFS — «interval between the end of the last Poll … and the expected start time of the first SPR»; рис. 10-60), Duration SPR = Poll − RO − TXTIME(SPR); чтение 9.3.1.10/9.3.1.11 (RO «beginning SIFS after the end of the Poll», Duration − SIFS) — судья как 'model' (`dyn_spr_time_9.3.1.10`, `dyn_spr_dur_9.3.1.11`). ATI: RO = 0, SPR через SIFS (10.39.3) (dynalloc, duration) | 10.39.7.2, 9.3.1.10, 9.3.1.11, 10.39.3 | 2020 = 2024 (10.38.7.2); при чтении 9.3.1.10 формула (10-18) расходится с рис. 10-60 на SIFS |
| 46 | A_k и O_j в (10-18) | A_k — переключение антенны перед Poll_k (тот же промежуток, что SBIFS слагаемого k; буквально «frame k and frame k+1» — сдвиг на кадр, A_n — после последнего Poll); O_j — через TXTIME(SPR_j) буквально (`duration.pp_schedule(oj_spr='j')`); при одинаковых A и SPR одной длины чтения совпадают (dynalloc.pp) | 10.39.7.2 | 2020 = 2024 |
| 47 | Начало GP после PP | По тексту: «SIFS following the end of a PP», а конец PP уже «… plus SIFS» — первый Grant через 2·SIFS после ожидаемого конца последнего SPR; рис. 10-60 (SIFS) — судья 'model' (`dyn_gp_start_fig`) (dynalloc) | 10.39.7.2, 10.39.7.3, рис. 10-60 | 2020 = 2024; рисунок — пример |
| 48 | Duration последнего Grant GP и IFS между Grant | Duration покрывает «remaining Grant frame and Grant Ack frame transmissions, if any, plus all appropriate IFSs»: последнего — 0 без Grant Ack (судья допускает и SIFS), SIFS + TXTIME(Grant Ack) с ним; между Grant — SBIFS (рис. 10-60), после Grant Ack — SIFS; начало выделения = PHY-TXEND + Duration (каждый Grant GP указывает ту же точку, ±1 мкс округления) (dynalloc) | 10.39.7.3 | 2020 = 2024 |
| 49 | Grant Ack и копирование AID; пересылка Grant при продлении | Grant Ack — через SIFS после Grant при Grant Ack Supported = 1 (10.39.4); пересылка партнёру (10.39.9 «SIFS after the reception of a Grant») — через SIFS после Grant Ack, если он есть. «Copy the Source AID, Destination AID» — в Grant Ack этих полей нет (рис. 9-57: Reserved 5 октетов), копируется только Beamforming Training (dynalloc, sp) | 10.39.4, 10.39.9, 9.3.1.18 | 2020 = 2024 (рис. 9-74 в 2024 — тот же Reserved) |
| 50 | Повтор источника в SP | «may retransmit … PIFS after the end of the frame» — раньше PIFS нарушение (`sp_retx`), позже — допустимо; BF-кадры исключены (sp) | 10.39.6.2 | 2020 = 2024 |
| 51 | Когда время SP возвращается AP | Только после объявления AP в Truncatable SP: CF-End к AP или широковещательный Grant (остаток после CBAP), либо CF-End пиру, когда пир — AP; CF-End пиру без объявления — пара заканчивает SP, AP время не получает (sp.SpState.released) | 10.39.8.1 | «In order to advertise the availability … shall transmit a CF-End frame to the AP»; 2020 = 2024 |
| 52 | Grant AP в SP с индивидуальным AID | Не GP (GP — в SP broadcast/broadcast, CBAP с broadcast Destination AID, ATI, во времени после усечения/восстановления): продление 10.39.9 / уступка / чужая передача — правила sp (dynalloc, sp) | 10.39.7.3, 10.39.9 | 2020 = 2024 |
| 53 | «Previous pseudo-static allocation» при изменении/удалении | Прежнее повторяется с тем же смещением от TBTT (bi.Allocation.recur) в BI изменения и следующих до dot11MaxLostBeacons − 1; новое распределение (кортеж не был в прошлом ES), перекрывающее его, — `should_ps_overlap`, кроме CBAP/CBAP и того же источника (schedule) | 10.39.6.4 | 2020 = 2024 |
| 60 | Information Response «with no requested or provided elements», а табл. 9-461 требует «One or more DMG Capabilities elements» | Ответ несёт только DMG Capabilities самого отвечающего; чужой DMG Capabilities в таком ответе — нарушение (discovery, air_wave3 `info_req`) | 11.28.1, 9.6.19.5 | 2020 = 2024 (11.27.1) |
| 61 | 11.28.2 a) «The SSID in the Information Request frame» — у кадра нет поля SSID | SSID — элемент SSID среди provided elements; нет элемента — как wildcard (discovery.ap_should_respond) | 11.28.2, табл. 9-460 | 2020 = 2024 |
| 62 | Сколько Quiet Period Response в QAB Response при нескольких Quiet Period Request (11.35.2 a) — несколько элементов в запросе, табл. 9-382 — один элемент) | По одному на каждый элемент запроса с Target BSSID = своему; Quiet Duration > Quiet Period при Repetition Count > 1 (интервалы налезают) — нарушение запроса (qab) | 11.35.2, 11.35.3, 9.4.2.149 | 2020 = 2024 |
| 63 | Next PCP List без способных STA: «length … is 0» (11.27.2.1) при поле Token в рис. 9-581 | Элемент с Length 0 (без Token); Length 1 (Token без AID) — нарушение («one or more AID», 9.4.2.140) (handover) | 11.27.2.1, 9.4.2.140 | 2020 = 2024 |
| 64 | 11.27.2.2 «Handover Result field set to 1, 2, or 3» при 9.6.19.7 (Result — 0/1, причины 0–3 — в Handover Reject Reason) | Норма — 9.6.19.7: Result ∉ {0, 1} — резерв (вердикт model) (handover) | 11.27.2.2, 9.6.19.7 | 2020 = 2024 — текст процедуры смешивает Result и Reject Reason |
| 65 | Отсчёт Remaining BIs явной передачи и значения MIB | Элемент — с BI после ответа, начальное = Handover Remaining BI − (BI ответа − BI запроса) (Handover Remaining BI не считает BI запроса), −1 на каждом TBTT; кандидат — PCP с TBTT, где счётчик 0 (маяков старого PCP с 0 нет). dot11NbrOfChangeBeacons DEFVAL 4 не «greater than dot11MaxLostBeacons» (4, 11.29.2), dot11ImplicitHandoverLostBeacons DEFVAL 8 не «lower than dot11MaxLostBeacons» (11.27.2.3) — значения MIB параметры, DEFVAL лишь по умолчанию (handover) | 11.27.2.2, 9.4.2.141, 9.6.19.6, C.3 | 2020 = 2024 (DEFVAL те же) |
| 66 | Неявная передача: «Remaining BIs field initially set to dot11MaxLostBeacons and decremented by 1 at each TBTT» и «at least one DMG Beacon during each of the next dot11MaxLostBeacons BTIs», завершение — маяк с 0 | Срабатывание в конце BI, TBTT перед первым BTI уменьшает счётчик: маяки несут dot11MaxLostBeacons − 1 … 0 — ровно dot11MaxLostBeacons BTI (handover.ImplicitCandidate) | 11.27.2.3 | Иначе (первый маяк с dot11MaxLostBeacons) — dot11MaxLostBeacons + 1 BTI до нуля; 2020 = 2024 |
| 67 | WEP-40/WEP-104 как групповой шифр в DMG BSS («only valid … in a TSN to allow pre-RSNA STAs») | Нарушение у DMG: до-RSNA DMG STA стандарт не описывает (DMG Privacy = dot11RSNAActivated, 9.4.1.46) — TSN в DMG BSS не бывает (capelems.check_rsne) | 9.4.2.24.2 | 2020 = 2024 |
| 68 | Current Operating Class DMG STA: глобальный или из таблицы страны (E-1…E-3: 34, 18, 59) | Глобальный класс табл. E-4 (180, 181); иное — вердикт model (capelems.check_soc, air_wave3 `op_classes`) | 9.4.2.53, табл. E-4 | Локальные номера без Country неоднозначны |
| 69 | aRTSTimeoutTime = TXTIME(RTS) + aAirPropagationTime + aRxPHYDelay + aMACProcessingDelay — последние два у DMG не заданы | aRxPHYDelay + aMACProcessingDelay ∈ [0, aSIFSTime] (10.3.7: aSIFSTime = aRxPHYDelay + aMACProcessingDelay + aRxTxTurnaroundTime); генератор — верхняя оценка (DTS не раньше), судья — нижняя (protperiod.rts_timeout) | табл. 11-22, 10.3.7, 10.39.6.6.2 | 2020 = 2024 |
| 70 | TSCONST Period отчёта о помехах «set to 0 indicating that the field is not applicable», а по табл. 9-262 0/0 — Reserved («not periodic» — B15 = 1) | Частное правило 10.39.6.6.6 сильнее: в отчёте о помехах Period = 0; вне отчёта 0/0 — нарушение (tspec, protperiod) | 10.39.6.6.6, табл. 9-262 | 2020 = 2024; ссылка там же «DMG ADDTS Request frame variant (9.6.3.3.2)» — опечатка, 9.6.3.2.2 |
| 71 | Вариант ADDTS Response «по Element ID шестого поля» (табл. 9-349) при TS Delay, присутствующем только при REJECTED_FOR_DELAY_PERIOD | Вариант — по первому элементу после Status Code, кроме TS Delay (tspec.parse_addts) | 9.6.3.1, 9.6.3.3.2 | 2020 = 2024 |
| 72 | SUCCESS_STA_IN_PS_MODE (11.4.4.4) нет в табл. 9-50 | = SUCCESS_POWER_SAVE_MODE (85); power save у нас удалён — точка его не шлёт (нарушение 'ours'); в правилах Allocation ID — успех (tspec) | 11.4.4.4, табл. 9-50 | 2020 = 2024 |
| 80 | Beacon SP Duration «set to dot11BeaconSPDuration» (MIB — мкс, DEFVAL 600), а подполе — в единицах 8 мкс | Подполе = ⌈dot11BeaconSPDuration / 8⌉ (Beacon SP не короче MIB; DEFVAL → 75) (cluster.beacon_sp_field) | 10.40.2.1, 9.3.4.2, C.3 | 2020 = 2024 |
| 81 | Резерв карты Available Cluster Time Offset Bitmap: «n = 1 and greater than ClusterMaxMem (i.e., bit 0 and bits ClusterMaxMem+1 to 31)»; Cluster Time Offset Index: «Values equal to 0 and greater than ClusterMaxMem are reserved» | По формуле (n = 1, n > ClusterMaxMem): действительны биты/индексы n − 1 = 1…ClusterMaxMem − 1; бит и индекс = ClusterMaxMem (Beacon SP_{ClusterMaxMem+1} нет, 10.40.1: n ≤ ClusterMaxMem) — тоже резерв, нарушение (cluster.bitmap_valid_bits, check_ecapc_policy, check_cto) | 9.4.2.154, 9.4.2.155, 10.40.1 | 2020 = 2024; пояснение в скобках расходится с формулой на один бит |
| 82 | Cluster Report: Number of Constraints — 1 октет в рис. 9-589 без «0 or», Extended Schedule Element field «set to all 0s» без расписания в маяке, ECAPC Policy Element «defined in 9.4.2.150» | Number of Constraints и набор — только при TSCONST Present = 1 (текст 9.4.2.146); без Extended Schedule в маяке — Schedule Present = 0 и поля нет; поля ECAPC Policy Element / Extended Schedule Element — целые элементы с ID и Length (размеры 13/17 и 17…n рис. 9-589); ссылка 9.4.2.150 — опечатка, 9.4.2.154 (cluster.encode/parse_cluster_report) | 9.4.2.146 | 2020 = 2024 (в 2024 ссылка «9.4.2.149» — та же опечатка после перенумерации) |
| 83 | «shall schedule a Beacon SP … at each of ClusterTimeOffset_n» — входит ли Beacon SP_1 S-AP в расписание члена | Да: Beacon SP для «other cluster member APs and PCPs», S-AP — участник кластера; децентрализованный — все n ≠ своего, централизованный — только занятые по последней карте; Source/Destination AID = 255 (10.40.3.4 «such as for a Beacon SP»), Allocation ID — 1, 2, … по порядку в BI (кортеж уникален, 9.4.2.131; больше 15 Beacon SP отдельными SP не выразить) (cluster.beacon_sp_entries) | 10.40.2.1, 10.40.2.2, 10.40.3.4 | 2020 = 2024 |
| 84 | Порог Cluster Report «TBTTs … less than dot11BeaconPeriod/(2×ClusterMaxMem) apart» — единицы и чей ClusterMaxMem | dot11BeaconPeriod своей BSS в мкс (× 1024, как ClusterTimeOffset), ClusterMaxMem — из Clustering Control принятого маяка; расстояние TBTT не записано — вердикт capture (cluster.report_condition, check_sta_report) | 10.40.4 | 2020 = 2024 |
| 85 | T_Start/T_End TXSS CBAP: «T_o is the TXSS CBAP Offset, in microseconds», а поле — в единицах 8 мкс и формула уже умножает на 8 | T_o, T_d — значения полей (8·T_o, 8·T_d мкс); T_BI — TU (× 1024) (cluster.txss_cbap_windows) | 10.40.3.4, 9.4.2.154 | 2020 = 2024 |
| 86 | Случайная задержка маяка при ECAPC = 1: «up to min(4×TXTIME(DMG Beacon), 1024×dot11MinBHIDuration) µs», а dot11MinBHIDuration — уже мкс (UNITS «microseconds», DEFVAL 5000) | min(4·TXTIME(DMG Beacon), dot11MinBHIDuration) мкс: множитель 1024 — как для TU, иначе предел ≈ 5 с > aMaxBIDuration (cluster.beacon_random_delay_max) | 11.1.3.3.1, C.3 | 2020 = 2024 |
| 87 | Clustering Control от AP/PCP без бит Decentralized/Centralized Clustering; ECAPC Policy от точки с ECAPC Policy Enforced = 0 | Прямого запрета нет: «clustering enabled» — способный AP/PCP, передающий поле (10.40.1); ECAPC Policy выдают S-AP/члены централизованного кластера (ECAPC = 1), после ухода «shall not include» (10.40.3.3 c)) — оба случая вердикт model (cluster.check_own_beacon, air_wave4 `cluster`) | 10.40.1, 10.40.2.2, 10.40.3.3 | 2020 = 2024 |
| 88 | Какие биты возможностей — «энергосбережение» (правило `opt_caps`) | Критерий — описание бита ссылается на 11.2 (Power management) или PSMP (10.30): Extended Capabilities 4, 6, 11 (11.2.3.14), 17, 18, 28, 29, 45; Capability Information B9 Triggered Unscheduled PS. Не PS: Heartbeat/Heartbeat Elapsed Indication (ATI, DMG Control в начале SP/TXOP — 9.4.2.127.2), Power Source («battery powered»), TFS (11.21.12); PCP Forwarding — не relay. В DMG Capabilities 802.11-2020 битов relay/MMS/FST/PS нет (optcaps) | табл. 9-153, рис. 9-86, 9.4.2.127.2/3 | 2020 = 2024 |
| 89 | ECAPC Policy в (Re)Association Response: 10.40.2.2 «shall include the ECAPC Policy element in (Re)Association Response», а в табл. 9-35/9-37 строки ECAPC Policy нет | Частное правило 10.40.2.2 сильнее; место в теле не задано — судья `cluster` требует наличие, `mgmt_body` (elements.check_order) сочтёт элемент «не предусмотренным» — при реализации централизованного кластера в fw дополнить порядок (после DMG Operation) | 10.40.2.2, табл. 9-35, 9-37 | 2020 = 2024 |
| 90 | Децентрализованная передача S-AP: счёт «number of cluster monitoring periods performed» и «may become an S-AP» против «shall establish itself as an S-AP» | Первый период (потеря S-AP за 4 × aMinBTIPeriod BI) входит в счёт; > dot11MaxNumberOfClusteringMonitoringPeriods — «may» начать образование заново; без маяков S-AP и своего кластера: нет маяков кластеризующих STA вообще — shall стать S-AP, есть чужие — may (генератор становится S-AP) (cluster.DecentralizedAp.end_bi) | 10.40.3.2 | 2020 = 2024 |
| 100 | STA Availability: чьи AID, CBAP = 0 | STA сообщает только свой AID (9.4.2.132: «inform an AP or PCP about the STA availability»), точка — AID связанных STA; AID 0/255 и повтор — нарушение; CBAP = 0 от нашей STA без энергосбережения — model; PP Available — последнее от STA к моменту Poll (staavail, air_wave5 `sta_avail`) | 9.4.2.132, 10.39.7.1 | 2020 = 2024 |
| 101 | Фрагментация DMG по Block Ack: ADDBA Extension нет; общий запрет 10.2.6 «HT-immediate … shall not be fragmented» | Нет элемента — запрета нет (No-Fragmentation = 0); No-Fragmentation = 1 в запросе — обещание originator; DMG-абзац 10.2.6 (по ответу ADDBA, вне A-MPDU, Normal Ack) сильнее общего запрета для HT-immediate; в A-MPDU без S-MPDU — никогда (addbaext, air_wave5 `addba_ext`) | 10.2.6, 9.4.2.139 | В 2024 (9.4.2.138) B1–B2 — HE Fragmentation Operation (только HE STA), No-Fragmentation «reserved when transmitted by a non-DMG STA»; у DMG B1–B7 = 0 в обоих изданиях; Extended Buffer Size — после 2024 |
| 102 | Генераторы Antenna Sector ID Pattern: вид регистра, номер сектора, «initial state for the second time» | Регистр Фибоначчи: вход ячейки 0 = XOR(Tap_i · ячейка_i); бит i поля — ячейка i; сектор = значение состояния; первый маяк после элемента — State 1; нулевое состояние — после второго возврата к начальному; генератор 2 сдвигается перед взятием бит 0–5, нулевое начальное — пропуск (sectorpat) | 9.4.2.156, рис. 9-605/9-606 | 2020 = 2024; порядок бит на рисунке не задан |
| 103 | 10.39.6.7: «does not receive a response frame … as part of the ATI exchange» и «announced within an Extended Schedule element transmitted during the ATI» | Буквально: ответа нет и тогда, когда запроса к STA в ATI не было; SP — по ключу (Source AID, Destination AID, Allocation ID) в Extended Schedule кадра AP (Announce) в ATI; возвращается всё время SP с его начала (sprecovery, sp.check_dti(reclaimed), air_wave5 `sp_recovery`) | 10.39.6.7, 10.39.3 | 2020 = 2024 (10.38.6.7) |
| 104 | Max Channel Switch Time у DMG: правила 11.9.3.2 сказаны для Beacon frame, в табл. 9-45 строки нет | У DMG — только Probe Response вместе с ECSA (табл. 9-39); Count 0 — не включать, Switch Time ограничивает промежуток последний маяк старого канала — первый нового (по аналогии, вердикт model); в DMG Beacon — model (ecs, air_wave5 `ecs`) | 11.9.3.2, 9.4.2.217, табл. 9-45 | В 2024 (11.8.8, 11.9.3.2) — «should include … if the Channel Switch Count field is nonzero and it may include the element if the field is 0», в любом кадре с ECSA: запрет при Count 0 снят — вердикт model |
| 105 | Табл. 9-51 и таблицы действий: что считать недопустимым для DMG; пропуски таблиц | nondmg — стандарт исключает DMG (TDLS 11.20.1, FILS 11.45.1) или функция другого PHY/диапазона (HT, VHT, S1G, CDMG, CMMG, HCCA, TVWS, DSE) — нарушение; out — применимо, в open нет (FT, GAS, QMF, Robust AV, mesh) — model; табл. 9-457 без строки «23–255 Reserved» — резерв; у TFS Notify Response (9.6.13.18) кода в табл. 9-425 нет — опознать нельзя (actions, air_wave5 `action_fmt`) | 9.4.1.11, табл. 9-51, 9-425, 9-457 | В 2024 DMG Action 23 — Protected Announce (в 2020 — резерв); кода TFS Notify Response нет и в табл. 9-536 2024 |
| 106 | TCLAS: тип 10 и Classifier Mask «1 or 3» (рис. 9-303); порядок байт Filter Offset; типы 7–9 и HT Control у DMG | Тип 10 — без Classifier Mask (рис. 9-327, (Length − 4)/2); Filter Offset — little-endian (порядок не задан, общее правило 9.2.2); типы 7–9 (PV1 — S1G) и сравнение HT Control у DMG — model; «deprecated» (тип 2, тип 1 IPv6) — model (tclas, air_wave5 `tclas`) | 9.4.2.30 | Норма — 2020: тип 4 без бита Version — нарушение; в 2024 фразы «valid when the Classifier Mask Version bit is 1» нет |
| 107 | 11.21.1: биты 7–27 — все ли «функции»; «Beacon frames» у DMG; отказ | Буквально все биты 7–27 (и SSID List, Multiple BSSID, UTC TSF Offset): любой = 1 ⇒ WNM STA ⇒ Extended Channel Switching = 1 и Radio Measurement = 1; Ext Cap обязателен в (Re)Association и Probe — DMG Beacon не Beacon frame; FMS/WNM sleep/TIM broadcast/TIM — на TIM/DTIM, у DMG model; отказ проверяется у BTM (Status ≠ 0) и DMS (actions, air_wave5 `wnm`) | 11.21.1, 9.6.13.1 | 2020 = 2024 |
| 108 | Адреса: DMG CTS-to-self, кадры управления между non-AP STA, групповые данные non-AP STA | DMG CTS-to-self — исключение из «Address 2 … the transmitter» (9.3.1.13: TA — получатель следующего кадра, может быть групповым); Address 3 управления между STA BSS — BSSID (по аналогии 9.3.3.1 c) 4), model); групповой Address 1 данных non-AP STA при 0/0 — model (групповые идут через AP); 4 адреса — model (addrs, air_wave5 `addr`, `data_hdr`) | 9.2.4.3, 9.3.1.13, 9.3.3.1, табл. 9-3, 9-30 | 2020 = 2024 |
| 109 | Что из Timestamp проверяемо без внешней опоры | Монотонность; разности против меток RX пира (допуск — два кванта + 2 · aDMGTSFAccuracy · Δt); первый маяк BI — Timestamp − TBTT ≥ преамбула и заголовок control (иначе нарушено 11.1.3.1 или 11.1.3.3.1 — оба наши); кадры SC точки (Probe Response, Announce) — Timestamp ≈ начало PPDU + PRE[класс] в TSF точки (допущение air_pcap.PRE) (tsf, air_wave5 `timestamp`) | 9.4.1.10, 11.1.3.1, 11.1.3.3.1 | 2020 = 2024 |
| 110 | TPC вне Link Measurement у DMG: когда обязателен ответ и TPC Report в кадрах | Ответ на TPC Request обязателен при Spectrum Management = 1 (11.7.1 + 11.7.7), при одном бите TPC DMG Capabilities — model; TPC Report в DMG Beacon/Probe Response — при Spectrum Management или Radio Measurement (табл. 9-45/9-39), в Announce — при Spectrum Management (11.7.7); Link Margin = 0 (tpc, air_wave5 `tpc`) | 11.7.7, 11.7.1, 9.4.2.16 | 2020 = 2024 |

Вопросы одного модуля (решение — в докстроке у «СПОРНО»): sls — момент старта ISS после Grant (чтение А), отсчёт
T1, Feedback в следующем распределении, слоты молчащих антенн, SSW-Ack после RXSS; abft — нет повторного прохода
для антенн инициатора в A-BFT, продолжение RSS только в A-BFT того же типа; bi — guard для непсевдостатичных
(D = BI), guard перед ATI, CBAP Only при одном CBAP в Extended Schedule, доступ non-AP при CBAP Source = 1,
broadcast-адресат SP, восстановление старших бит TSF; brp — BS-FBCK ≤ 63, ответ на кадр без запросов, MID через
SIFS или SBIFS, TRN-R единицами по 4, немедленный TRN-R после setup, ответ «филлером»; fields — BF Control в
Extended Schedule «but not both» буквально, повтор строк табл. 9-45, Dynamic Allocation Info 0…32 767; elements —
MCS 13/16 и 7/8, остаток Extended Schedule < 15 октетов, 
повтор элементов, AID при отказе, Multi-band в Authentication; mlme — Deauthentication по рис. 11-17, перевод
50 мс → TU вверх, Open System у DMG AP, PBSS BSSID, JOIN по DMG Beacon, «конфигурационные» коды статуса; air_judge
`dms` — по «Terminate» снимаются все группы пары (DMSID → группы не ведётся), `amsdu` — Short без записанного PTP
TSPEC — вердикт capture (ADDTS не разбирается); schedule — BF Training при broadcast AID, AllocationType 1,08 ГГц для DMG; sp — первый кадр SP при BF (SSW ISS/RSS),
число SSW в RXSS не проверяется, Duration Grant усечения с ответным CF-End и без; dynalloc — Allocation Duration = 0
(«one PPDU …»: не более одного PPDU источника кроме RTS), уступка TXOP (остаток — по NAV держателя); bssparams — пропуск BTI в записи посреди объявления — «не
проверяемо»; chswitch — канал после смены не виден (судья проверяет только ряд объявлений); волна 3 — discovery (критерии ответа точки), tspec (DELTS: хвост
только Multi-band), air_wave3 `addts` (Extended Schedule — в ближайших 4 BI после SUCCESS); волна 5 — bftrain (BRP без SLS
пары — model: обучение могло быть до записи), ecs (OCV: защищённый Action после смены — вердикт capture).
