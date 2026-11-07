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
  калибровка точки метки и сдвига TSF по парам кадров; `to_cbap_log`/`to_bi_log` — кортежи судей cbap/bi.
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
| 16 | Точка метки TSF записи PMC в PPDU (захват стенда) | Метка TX = точка Timestamp DMG Beacon (на стенде Timestamp == метке TX у всех маяков) = начало символа данных с первым битом кадра: начало PPDU + T_STF + T_CE + T_header (SC) / + 40·32·Tc (control) (`air_pcap.PRE`); метка RX и сдвиг TSF второго узла — по парам кадров (air_pcap) | 11.1.3.1, 20.11.3 | Документации нет; промежутки внутри класса модуляции от выбора не зависят, control ↔ SC — ±0,75 мкс (`air_judge.PRE_UNCERT`); суммы SIFS двух узлов (`air_judge.sifs_sum`) не зависят ни от чего |
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
| 45 | Начало отсчёта Response Offset в PP и Duration SPR | От конца Poll (10.39.7.2: «at the time offset from the end of the Poll frame»; O_1 = SIFS — «interval between the end of the last Poll … and the expected start time of the first SPR»; рис. 10-60), Duration SPR = Poll − RO − TXTIME(SPR); чтение 9.3.1.10/9.3.1.11 (RO «beginning SIFS after the end of the Poll», Duration − SIFS) — судья как 'model' (`dyn_spr_time_9.3.1.10`, `dyn_spr_dur_9.3.1.11`). ATI: RO = 0, SPR через SIFS (10.39.3) (dynalloc, duration) | 10.39.7.2, 9.3.1.10, 9.3.1.11, 10.39.3 | 2020 = 2024 (10.38.7.2); при чтении 9.3.1.10 формула (10-18) расходится с рис. 10-60 на SIFS |
| 46 | A_k и O_j в (10-18) | A_k — переключение антенны перед Poll_k (тот же промежуток, что SBIFS слагаемого k; буквально «frame k and frame k+1» — сдвиг на кадр, A_n — после последнего Poll); O_j — через TXTIME(SPR_j) буквально (`duration.pp_schedule(oj_spr='j')`); при одинаковых A и SPR одной длины чтения совпадают (dynalloc.pp) | 10.39.7.2 | 2020 = 2024 |
| 47 | Начало GP после PP | По тексту: «SIFS following the end of a PP», а конец PP уже «… plus SIFS» — первый Grant через 2·SIFS после ожидаемого конца последнего SPR; рис. 10-60 (SIFS) — судья 'model' (`dyn_gp_start_fig`) (dynalloc) | 10.39.7.2, 10.39.7.3, рис. 10-60 | 2020 = 2024; рисунок — пример |
| 48 | Duration последнего Grant GP и IFS между Grant | Duration покрывает «remaining Grant frame and Grant Ack frame transmissions, if any, plus all appropriate IFSs»: последнего — 0 без Grant Ack (судья допускает и SIFS), SIFS + TXTIME(Grant Ack) с ним; между Grant — SBIFS (рис. 10-60), после Grant Ack — SIFS; начало выделения = PHY-TXEND + Duration (каждый Grant GP указывает ту же точку, ±1 мкс округления) (dynalloc) | 10.39.7.3 | 2020 = 2024 |
| 49 | Grant Ack и копирование AID; пересылка Grant при продлении | Grant Ack — через SIFS после Grant при Grant Ack Supported = 1 (10.39.4); пересылка партнёру (10.39.9 «SIFS after the reception of a Grant») — через SIFS после Grant Ack, если он есть. «Copy the Source AID, Destination AID» — в Grant Ack этих полей нет (рис. 9-57: Reserved 5 октетов), копируется только Beamforming Training (dynalloc, sp) | 10.39.4, 10.39.9, 9.3.1.18 | 2020 = 2024 (рис. 9-74 в 2024 — тот же Reserved) |
| 50 | Повтор источника в SP | «may retransmit … PIFS after the end of the frame» — раньше PIFS нарушение (`sp_retx`), позже — допустимо; BF-кадры исключены (sp) | 10.39.6.2 | 2020 = 2024 |
| 51 | Когда время SP возвращается AP | Только после объявления AP в Truncatable SP: CF-End к AP или широковещательный Grant (остаток после CBAP), либо CF-End пиру, когда пир — AP; CF-End пиру без объявления — пара заканчивает SP, AP время не получает (sp.SpState.released) | 10.39.8.1 | «In order to advertise the availability … shall transmit a CF-End frame to the AP»; 2020 = 2024 |
| 52 | Grant AP в SP с индивидуальным AID | Не GP (GP — в SP broadcast/broadcast, CBAP с broadcast Destination AID, ATI, во времени после усечения/восстановления): продление 10.39.9 / уступка / чужая передача — правила sp (dynalloc, sp) | 10.39.7.3, 10.39.9 | 2020 = 2024 |
| 53 | «Previous pseudo-static allocation» при изменении/удалении | Прежнее повторяется с тем же смещением от TBTT (bi.Allocation.recur) в BI изменения и следующих до dot11MaxLostBeacons − 1; новое распределение (кортеж не был в прошлом ES), перекрывающее его, — `should_ps_overlap`, кроме CBAP/CBAP и того же источника (schedule) | 10.39.6.4 | 2020 = 2024 |

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
(«one PPDU …»: не более одного PPDU источника кроме RTS), уступка TXOP (остаток — по NAV держателя).
