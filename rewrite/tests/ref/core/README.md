# Ядро DMG MAC (этапы 1–4)

Исполняемое ядро DMG MAC по 802.11-2020 на Python: точка (AP, BSS Type 3) и станция (non-AP STA) как событийные
автоматы с интерфейсами стандарта, идеальная среда и журнал эфира в формате судей. Ядро не знает про регистры, очереди
MAC и антенны железа: только PHY-SAP, номера секторов и качество приёма из RXVECTOR. Задание и этапы —
`rewrite/docs/ARCHITECTURE.md`; текст стандарта — `docs/80211-2020.txt` (ссылки — номерами пунктов).

```
cd rewrite/tests && python3 -m pytest ref/core -q -p no:xdist
```

## Устройство

```
              SME (sme.py: ApSme, StaSme — сценарий, не часть MAC)
   MLME-SAP ↑↓ (sap_mlme.py)        MAC-SAP ↑↓ (sap_mac.py)
          ┌───────────────────────────────────────────────┐
          │ mac.py  DmgMac: EDCA/CBAP, NAV, TXNAV, обмены,│   ap.py  DmgApMac: BTI, A-BFT, Probe/Assoc,
          │         SIFS-ответы, Block Ack, SLS, BRP setup│   sta.py DmgStaMac: SCAN/JOIN, TSF, A-BFT, Assoc
          └───────────────────────────────────────────────┘
   PHY-SAP ↑↓ (sap_phy.py: TXVECTOR/RXVECTOR, Beam)   + точки разгрузки (offload.py)
          ┌───────────────────────────────────────────────┐
          │ medium_ideal.py  IdealPhy × N + IdealMedium   │ → journal.py (журнал эфира)
          └───────────────────────────────────────────────┘
   судьи: judge_run.py → ref/air_judge (+ air_wave*) и unit/ref_bridge2 (мост передаёт тест)
```

| Модуль | Что |
|---|---|
| `sim.py` | модельное время (Fraction, мкс), очередь событий; в один момент — окончания, начала, таймеры MAC |
| `sap_phy.py` | PHY-SAP 8.3.5 (PHY-TXSTART/DATA/TXEND, PHY-CCA, PHY-CCARESET, PHY-RXSTART/DATA/RXEND, PHY-CONFIG), TXVECTOR/RXVECTOR (табл. 20-1), TXSTATUS, PHYCONFIG_VECTOR (20.2.3), `Beam` — луч (антенна, сектор / квази-омни) |
| `sap_mac.py` | MAC-SAP 5.2: MA-UNITDATA.request/.indication, MA-UNITDATA-STATUS.indication |
| `sap_mlme.py` | MLME-SAP 6.3: START, SCAN, JOIN, ASSOCIATE, ADDBA (6.3.27), BF-TRAINING (6.3.91); имена параметров — стандарта |
| `offload.py` | точки разгрузки (таблица ARCHITECTURE.md), `AdapterCaps`, интерфейс ядро ↔ адаптер (OffloadSap/OffloadUser, OffloadNav); пустой набор — идеальная среда, `SPARROW` — этап 3 |
| `frames.py` | сборка/разбор MPDU и PSDU (FCS, A-MPDU с разделителями), EDCA Parameter Set; поля — кодеками `ref/*` |
| `mac.py` | общий MAC: доступ, обмены, ответы, Block Ack, MAC-SAP, SLS в DTI, BRP setup |
| `ap.py` / `sta.py` | роли |
| `medium_ideal.py` | идеальная среда без разгрузки |
| `journal.py` | журнал эфира → `to_snapshot()` (вход `unit/ref_bridge2.events`), `to_air()` (вход `ref/air_judge.judge`) |
| `judge_run.py` | прогон обоих судей над журналом |
| `scenario.py` | `Bss`: точка + N станций, прогон до конца обмена |

## Что ядро умеет (по стандарту)

**Точка.** MLME-START → TBTT каждые BeaconPeriod (TSF 0 — TBTT, 11.1.3.3.1). BTI: DMG Beacon по всем секторам через
SBIFS, CDOWN до 0, Duration — остаток BTI (10.42.4, 9.3.4.2), Timestamp — TSF начала символа данных с первым битом
кадра (11.1.3.1). BIC: ATI Present 0, Next A-BFT 0, A-BFT Length/FSS, IsResponderTXSS 1; DMG Parameters: BSS Type 3,
CBAP Only 1 (DTI — один CBAP после guard до следующего TBTT, 10.39.6.3). A-BFT через MBIFS после BTI (10.42.5.1):
приём SSW квази-омни, SSW-Feedback одному ответчику в слоте через его Sector Select (10.42.5.2, `abft.ApAbft`), затем
обязательный BRP с Capability Request = 1 в aMinBTIPeriod BI (10.42.5.2, 10.42.3.2; повтор при потере). Probe
Response (Timestamp по 11.1.3.1), Association Response c EDCA Parameter Set, DMG Capabilities, DMG Operation; State 4
по Ack (11.3.5.3 n), `mlme.ApMlme`).

**Станция.** MLME-SCAN (пассивный по DMG Beacon; активный — Probe Request после BF), MLME-JOIN (TSF = Timestamp к
началу символа данных, 11.1.4.5), TSF по каждому маяку своей точки (11.1.3.7). BI по маякам: конец BTI — конец
последнего маяка + Duration (10.42.5.1, уточнение по CDOWN), A-BFT по BIC, CBAP до следующего TBTT по своему TSF.
A-BFT ответчиком RSS (`abft.Responder`: backoff по слотам, SSW через свои сектора, SSW Feedback — лучший сектор BTI);
по SSW-Feedback — луч к точке и MLME-BF-TRAINING.indication. SLS в DTI (MLME-BF-TRAINING.request): ISS-TXSS → RSS
ответчика через MBIFS → SSW-Feedback через MBIFS после конца RSS по CDOWN → SSW-Ack (10.42.2, 10.42.6.2); ответчик
SLS — общий код (точка). Ассоциация DMG без 802.11 Auth: State 2 → 4 (11.3.1, `mlme.StaMlme`), Supported Channels
(11.8.2.2), EDCA Parameter Set точки (10.2.3.2).

**Доступ и обмены (обе роли).** EDCAF AC_VO (кадры управления, 10.2.3.2) и AC_BE (данные TID 0); границы слотов —
опорная + AIFS[AC] + k·aSlotTime, опорная — max(конец физической занятости, конец NAV, конец TXNAV, начало CBAP),
после ошибки приёма — EIFS (10.3.2.3.7, 10.23.2.4); заморозка счётчика, вызовы backoff a/b/c и внутренняя коллизия
(10.23.2.2, 10.23.2.3); обмен — только если с ответами укладывается в CBAP и лимит TXOP (10.39.5, 10.23.2.9); вне
CBAP EDCAF и NAV заморожены (10.39.5). NAV — единый (`cbap.Nav`, 10.3.2.4, CF-End DMG 10.23.2.10); TXNAV держателя
(10.23.2.2). Немедленные ответы через SIFS: DMG CTS (при свободном NAV или NAV держателя, 10.3.2.9), Ack (кадры
управления, одиночные данные), BlockAck на A-MPDU (10.25.6.5), ответный CF-End (i = 1, 9.3.1.6), BRP-ответ (10.42.3.2);
MCS ответа — 10.6.7.2, Duration — 9.2.5.7/9.3.1.13. TXOP данных: RTS → DMG CTS → A-MPDU (Implicit BAR) → BlockAck →
[CF-End → CF-End], Duration — 9.2.5.2 b); A-MPDU — в окне Block Ack, ≤ aPPDUMaxTime и ≤ Maximum A-MPDU Length получателя
(10.12.2); тайм-ауты ответа — 10.3.2.11. Block Ack: MLME-ADDBA (HT-immediate, 10.25.2), `blockack.Originator/Recipient`
(scoreboard, буфер переупорядочения), MA-UNITDATA.indication по порядку SN, MA-UNITDATA-STATUS.indication.

**Идеальная среда.** Уровень = base(пара) − штраф луча передатчика − штраф луча приёмника (сектор — шаг × расстояние до
лучшего, квази-омни — до 15 дБ, 20.9.1) — «качество луча», по нему SLS выбирает лучший сектор. Задержка
распространения (10 нс по умолчанию), синхронизация по чувствительности заголовка, CCA (20.5.4.2.2), коллизии без
захвата, полудуплекс, чувствительность MCS (табл. 20-3), SNR в RXVECTOR.

## Тесты

| Файл | Что |
|---|---|
| `test_core_units.py` | кадры, PSDU/A-MPDU, время, среда (доставка, CCA, задержка, коллизия, полудуплекс, чувствительность, луч), EDCA (слоты, заморозка), тайм-ауты, SAP-имена, наборы разгрузки и ядро при разгрузке (заглушка адаптера: ответы, арбитр доступа, Duration, NAV), TXTIME BRP-RX, форматы журнала |
| `test_core_integration.py` | точка + станция: 1 МиБ в обе стороны, данные целиком и по порядку, последовательность MLME, состав эфира, оба судьи — 0 нарушений, покрытие правил; варианты: только SLS в DTI, A-BFT + SLS с 16/8 секторами, 2 и 3 станции, BI 5 TU и 3 МБ (обмены у границы CBAP) |
| `test_core_negative.py` | порча поведения ловится: AIFSN 1 у STA, Duration DMG CTS, CF-End без запаса, Duration маяка, ответ через 5 мкс, данные до ассоциации, Duration SSW в A-BFT, обмен за TBTT, нет Supported Channels, A-MPDU длиннее предела получателя |
| `test_core_boundary.py` | ядро не импортирует tests/unit, в т. ч. адаптер Sparrow (AST и sys.modules в отдельном процессе) |

Вне набора (дольше) прогнан перебор 54 конфигураций — seed 1–6 × 1/2/3 станции × BF (A-BFT, SLS в DTI, оба) ×
задержка 0–30 нс, 150 КБ в обе стороны: все соединяются, оба судьи — 0 нарушений.

## Судьи над журналом

`judge_run.air` — все правила `ref/air_judge` (с волнами `air_wave3/4/5`): журнал ядра даёт им всё (время, Duration,
тела, кто принял), поэтому «не проверяемо» остаётся только там, где в сценарии нет нужных кадров (SP, TDMA, DMS, …)
или правило ограничено самим судьёй (например, `access` проверяет только RTS после CF-End).

`judge_run.bridge` — судьи моста эмулятора (`unit/ref_bridge2.judge_*`) над `to_snapshot()` — тот же вход, что от
`air.Air` эмулятора; модуль моста передаёт тест (ядро его не импортирует). Отличия от `RB.judge_all`, все — потому что
мост рассчитан на эмулятор, где трафик идёт одной AC:
1. доступ CBAP — AIFSN по AC кадра (кадры управления — AC_VO) и окна CBAP (EDCAF возобновляется в начале CBAP);
2. Duration кадров управления — по AC_VO (TXOP Limit 0); TPENDING RTS — без следующего доступа (мост объединяет кадры
   пары с промежутком ≤ SIFS + 10 мкс, туда попадает доступ на AIFS[AC_VO] = 13 мкс);
3. TXNAV держателя после BRP setup/SLS (10.23.2.2) — `cbap.LogParams.txnav_kinds` (кадры инициатора обмена);
4. SLS в DTI — последовательности по каждой паре (`sls_pairs`): мост ведёт один поток, и одновременные ISS двух
   станций (коллизия на одной границе слота) рвут его на одиночные кадры.

Уточнения судей `ref/*`, сделанные на журнале ядра (правила, которые на записи стенда не встречались):
`air_judge.r_dur_bf` — Duration SSW/SSW-Feedback в A-BFT (до конца слота / 0, 9.3.1.15–16); `r_brp` — BRP setup
(10.42.3.2) через `brp.check_setup`, кадры setup — phase 'setup'; `r_responder` — BRP-ответ и коллизия двух доступов
не «чужая передача в TXOP»; `r_nav_rx` — SSW в A-BFT (доступ по слотам, не по NAV); `r_sls` — последовательности по парам, повтор ISS — новый SLS;
`cbap.LogParams` — AIFSN как функция кадра, `txnav_kinds`.

## Спорные трактовки (СПОРНО → принято)

| Место | Принято |
|---|---|
| Точка Timestamp (11.1.3.1) | control: T_STF-CM + T_CE-CM + 40·32·Tc (заголовок перед кадром в первом кодовом слове, 20.4.3.3); SC: T_STF + T_CE + T_HEADER — как `air_pcap.PRE` |
| PHY-RXSTART | SC — конец заголовка (2,47 мкс; Ack на MCS 1 короче aRxPHYStartDelay = 3,6 мкс), control — aRxPHYStartDelay; тайм-ауты ответа — с aRxPHYStartDelay (10.3.2.11) |
| Остаток для CF-End с Duration ≠ 0 (10.23.2.10) | air_judge/cbap — от начала CF-End, мост — от конца; запас в NAV — SIFS + 3·TCF-End + 2·SIFS, выполняются оба |
| TXOP Limit AC_BE | точка объявляет 2048 мкс: при лимите 0 (табл. 9-155) нельзя ни запаса под CF-End, ни нескольких кадров |
| Тайм-аут SSW-Ack (10.42.6.2) | MBIFS + aSlotTime + aRxPHYStartDelay (стандарт срок не задаёт) |
| Граница CBAP у STA | по своему TSF; обмен укладывается с запасом aTSFResolution (свой TSF отстаёт до 1 мкс + распространение) |
| BI маяка у STA | ближайший TBTT по своему TSF |
| NAV вне CBAP | не обновляется (10.39.5: «remain unchanged until the start of the following CBAP») |
| MA-UNITDATA-STATUS при исчерпании повторов | «Undeliverable» (5.2.5.2 такого значения не перечисляет) |
| Луч приёма | расширение модели PHYCONFIG_VECTOR.RX_ANT_CONFIG (20.2.3 задаёт только канал) |
| Адаптация MCS | модель: SNR ≥ чувствительность(MCS) − чувствительность(MCS 0) + запас |
| Sector Select / выбор при нескольких ответчиках A-BFT | `abft.ApAbft` (максимум SNR) |
| Последовательность при занятой среде в момент своего шага | обмен прерывается как неудачный |

Прочие трактовки — `ref/PLAN.md` (FSS в формулах — число кадров, Total Sectors = N − 1, конец BTI по Duration и т. д.).

## Не сделано на этапе 1

BRP с TRN по запросу SME (MLME-BF-TRAINING с RequestBRP = true) и обучение передачи (TX-TRN-REQ; ответчиком обучения
приёма ядро стало на этапе 3), ATI, SP/PP/GP и строгий TDMA, сопровождение луча, Link Measurement,
кластеризация, RSNA, энергосбережение, несколько DMG-антенн, BlockAckReq/DELBA, фрагментация, A-MSDU, RD.

## Этап 2: сравнение по эфиру (прошивка в эмуляторе против ядра)

Один сценарий исполняют обе стороны, журналы сравниваются по смыслу общими судьями.

```
cd rewrite/tests
python3 -m ref.core.diff_report --list
python3 -m ref.core.diff_report --scenario sls-1sta --build <каталог с fw.elf и uc.elf>        # текст в stdout
pypy3 -m ref.core.diff_report --scenario all --build <dir> --out-dir <dir> --save-snapshot     # + JSON, SUMMARY.txt
python3 -m ref.core.diff_report --scenario all --load-snapshot <dir> --out-dir <dir2>          # сравнить заново
python3 -m ref.core.diff_report --scenario sls-1sta --against core                             # ядро против ядра
```

| Модуль | Что |
|---|---|
| `diff_scenario.py` | `Scenario` — одно описание (станции, BF A-BFT/SLS в DTI, BI, секторы, A-BFT, EDCA с TXOP AC_BE 2048, объём и направление данных, пачки, seed, пределы); `SCENARIOS`; `run_core` — ядро в идеальной среде; `Scenario.limits()` — что сценарий не задаёт одной из сторон |
| `unit/fw_scenario.py` | тот же сценарий на прошивке: fw + uc узлов в `air.Air`, драйвер — WMI (PCP_START, CONNECT, VRING_CFG, RING_BA_EN/RCP_ADDBA_RESP), данные хоста; срыв эмуляции не роняет прогон (`Run.notes`) |
| `diff_compare.py` | сравнитель: `snapshot_air` (снимок эмулятора → `air_pcap.Air`), `Side` (роли, фазы BI, обмены, нарушения судей), аспекты и классы, `compare` |
| `diff_report.py` | CLI и отчёт (текст, JSON, итог по сценариям); tests/unit подключает лениво, внутри функций |

Аспекты: судьи (все правила `air_judge` и судей моста `judge_run.bridge_snapshot` над обоими журналами), обмены
(виды и сигнатуры обменов DTI, порядок фаз станции), поля (BI Control, DMG Parameters, DMG Capabilities, адреса и биты
DS, Ack Policy, Retry, ADDBA, BRP, MCS, RA CF-End = партнёр обмена 9.3.1.6, MPDU в A-MPDU против окна BA), Duration
(первый кадр обмена; сдвиг конца NAV ответом — 9.2.5.7, 9.3.1.13), промежутки (SIFS/SBIFS/MBIFS/BRPIFS внутри
обменов против номинала с допуском 10.3.2.3), доступ (раньше AIFS), роли (кто начинает обмен), счётчики, параметры
BSS, прогон (замечания эмулятора).

Классы: «прошивка ≠ стандарт» (судья или своя проверка отвергает только прошивку, часть — не разгрузка), «ядро ≠
стандарт» (отвергает ядро), «модель MAC эмулятора» (точки разгрузки ARCHITECTURE.md §2 и допущения H-*: ответы через
SIFS, Duration RTS/кадров очереди H-DURQ, доступ H-BACKOFF, Timestamp маяка H-BIC, окно A-MPDU H-AMPDU, сетка A-BFT
H-ORIGIN, RA CF-End в эфире > 2 узлов), «трактовка» (`ref/PLAN.md`, вердикт судьи 'model', скрытая станция при
направленной развёртке), «неопределённо» (обе стороны в рамках стандарта — выбор реализации, или номинала нет).

Уточнения для полного журнала (ядро и эмулятор знают всё): `air_judge/brp` «нет ответа в пределах BRPIFS»
перепроверяется от настоящего конца PPDU с полями TRN (запись PMC их не несёт); «начат во время чужого кадра» судьи
моста при направленной скрытой станции (передатчик не принимал занявший среду кадр, rx_nodes) — «трактовка».

Сценарии: `abft-1sta`, `sls-1sta` (вверх), `sls-1sta-dl` (вниз), `sls-1sta-both`, `sls-2sta`, `sls-1sta-burst`
(48 MSDU одной пачкой — длина A-MPDU против окна BA), `sls-1sta-bi10` (BI 10 TU, данные пачками через границы BI). Ядро — секунды, прошивка — 1–10 мин под PyPy на сценарий.

Тесты: `test_diff_compare.py` (синтетические журналы с внесёнными отличиями → класс; ядро против ядра — 0 расхождений и
с другим seed; отчёт), `unit/test_fw_diff.py` (прошивка против ядра на `sls-1sta`: прогон до данных, отчёт строится,
точки разгрузки — «модель MAC эмулятора»; нужна сборка прошивки).

### Результат на прошивке open 2026-11 (7 сценариев, эмулятор)

Счёт (прошивка ≠ стандарт / ядро ≠ стандарт / модель MAC / трактовка / неопределённо): 1-STA сценарии — 1 / 0 / 46–59 /
2 / 40–47; `sls-2sta` — 6 / 0 / 45 / 3 / 63. Ядро против ядра — 0 во всех сценариях, кроме `sls-2sta` (одна
«трактовка»: скрытая станция при направленной развёртке).

| Класс | Расхождение | Доказательство |
|---|---|---|
| прошивка ≠ стандарт | BTI начинается через 12–14 мкс после TBTT при свободной среде (11.1.3.3.1) | air_judge `bti_delay`, все сценарии; путь uc (два ожидания slot_event), стенд — 20–34 мкс (MAC-STAND «Начало BTI») |
| прошивка ≠ стандарт (2 STA) | CF-End точки с RA другой станции после обмена с STA2 (9.3.1.6: RA — адресат обмена или широковещательный) | поле «RA = партнёр обмена», 2 из 7 CF-End |
| прошивка ≠ стандарт (2 STA) | BRP точки к STA2 с Initiator = 0, где точка — инициатор (10.42.6.4.1) | air_judge `brp/initiator` |
| прошивка ≠ стандарт (2 STA) | одиночный CF-End точки после неотвеченного кадра управления — 37,2 мкс после AIFS, не на границе слота (10.23.2.4) | мост `cbap/slot`; повод — STA1 не отвечает (ниже) |
| трактовка | нет Supported Channels в Association Request (11.8.2.2, ref/PLAN.md №41) | air_judge `supp_channels` |
| модель MAC | Duration ответов MAC: Ack 0, DMG CTS/BlockAck на 1 мкс меньше (9.2.5.7, 9.3.1.13) | air.py собирает ответы сам |
| модель MAC | ответы через SIFS 4,5–6,4 мкс, данные после DMG CTS 7,5–7,9 мкс | H-RESPCMD, H-TXAFTERACK (на железе так же) |
| модель MAC | Duration RTS 1982 и кадров управления очереди 1958–1977 — остаток лимита TXOP; следом CF-End после каждого одиночного обмена управления, судья моста — `cf_end`/`aifs`/`cf_end_dur` | H-DURQ (стенд) |
| модель MAC | NAV RTS за TBTT при BI 10 TU | H-DURQ без урезания до TBTT (стенд: REMAINING_TIME = min(лимит, до TBTT − 2 мкс)) |
| модель MAC | A-MPDU из 48 MPDU при окне BA 32 (10.25.2) | `sls-1sta-burst`; cosim берёт окно 160 из слова 0x20002800 дескриптора очереди, стенд — 1…32 MPDU |
| модель MAC | первая SSW пачки A-BFT на 0,31 мкс позже начала слота, Duration SSW +1 мкс | H-ORIGIN; стенд std4/5 — в норме |
| модель MAC | Timestamp маяка = TSF начала PPDU (−5 мкс от 11.1.3.1) | H-BIC (air.py) |
| неопределённо (2 STA) | после SLS/BRP STA2 с точкой STA1 не шлёт свой CF-End и не отвечает Ack на кадры управления точки (21 ADDBA Response без Ack), позже ответ на RTS через ~50 мкс → uc_assert 0x6002 | прогон `sls-2sta`; отчёт приёма air.py не зависит от RA (кадры чужих SLS/BRP приходят как «свои») — пробел модели вероятен; опыт с фильтром по RA перенёс срыв к точке (поздний ответ через SIFS, 47 мкс) — нужен стенд |
| неопределённо | BRP после SLS, повтор SLS после ассоциации, SLS от точки — только у прошивки; DMG Capabilities (RD, heartbeat, Grant Ack, RXSS Length 31, reciprocity); EDCA AC_VO TXOP 512 / AC_VI 2048; A-BFT раз в 4 BI; кадры управления на MCS 0 | выбор реализации, стандарт допускает обе стороны; ядро BRP после SLS не делает (этап 4) |

## Этап 3: ядро на адаптере Sparrow, смешанные пары

Ядро работает поверх модели MAC эмулятора: функции, которые у Sparrow делает железо (точки разгрузки), ядро не
делает, а получает о них события; узел ядра стоит в эфире `air.Air` наравне с узлами прошивки (CoSim fw + uc).

```
cd rewrite/tests
python3 -m pytest unit/test_adapter_sparrow.py -q                                   # без сборки прошивки
SPARRAW_UNIT_BUILD=<dir> python3 -m pytest unit/test_mixed_pairs.py -n 4 -q          # смешанные пары (~5 мин)
pypy3 -m ref.core.diff_report --scenario all --against core-sparrow --out-dir <dir>  # ядро-Sparrow против ядра
pypy3 -m ref.core.diff_report --scenario all --against fw-sparrow --load-snapshot <снимки прошивки> --out-dir <dir>
pypy3 -m ref.core.diff_report --scenario all --against mixed-ap  --mixed-preset core   --build <dir> --out-dir <dir>
pypy3 -m ref.core.diff_report --scenario all --against mixed-sta --mixed-preset compat --build <dir> --out-dir <dir>
```

| Модуль | Что |
|---|---|
| `offload.py`, `mac.py` | точки разгрузки в ядре: при флаге ядро не передаёт Ack/BlockAck/DMG CTS и не строит scoreboard, NAV — адаптера (`OffloadNav`), Duration RTS/кадров очереди берёт у адаптера (`offload_duration`), доступ для работ очереди (кадры управления с Ack, TXOP данных) выигрывает арбитр адаптера (`offload_access_request` → `offload_access_granted`); SLS и BRP setup — EDCAF ядра (у железа их пускает микрокод) |
| `unit/adapter_sparrow.py` | `CoreNode` — узел ядра (свои часы `Sim`, ось — TSF эмулятора, H-SYNC) + PHY-SAP + модель MAC Sparrow для разгруженных точек; `MixedAir` — `air.Air` с узлами ядра (кадр ядра идёт к узлам прошивки путём `Air._tx`: буфер приёма uc, отчёт r36..r39, NAV, ответ через SIFS); `snapshot` — снимок `ref_bridge2` с узлами ядра |
| `unit/sparrow_scenario.py` | сценарии `diff_scenario`: `run_core` — точка и станции на ядре поверх адаптера; `run_mixed(scn, 'ap'/'sta')` — смешанная пара с драйвером прошивки (WMI); `PRESETS` — выбор реализации ядра для пары |
| `diff_report.py`, `diff_compare.py` | режимы `core-sparrow`, `fw-sparrow`, `mixed-ap`, `mixed-sta`; класс «ядро на Sparrow ≠ стандарт»; нарушение стороны B на модели MAC, объяснимое допущением H-* (`b_hyp`), — «модель MAC эмулятора» |

Модель MAC в CoSim не отделяется от микрокода (machw отвечает на команды uc), поэтому адаптер — минимальная обвязка с
теми же допущениями и, где можно, тем же кодом:

| Точка | Ядро при разгрузке | Модель MAC адаптера (Sparrow) |
|---|---|---|
| SIFS_RESPONSE + BA_SCOREBOARD | не отвечает; «ответ назначен» и «ответ в эфире» — события, буфер переупорядочения и выдача MSDU — свои | кому отвечать — как `air.Air._tx` (uni); кадр и Duration — `air.Air._frame` (Ack Duration 0, BlockAck — карта MPDU принятого A-MPDU, H-AMPDU); момент — конец + IFS + MACLAT (H-RESPCMD, команда в срок) + `resp_cmd_delay_clk`; MCS — H-RESPMCS; DMG CTS — при свободном NAV MAC или держателю |
| DURATION | берёт поставленное значение для TXNAV и конца NAV держателя (запас под CF-End) | RTS и кадры очереди: остаток лимита TXOP AC_BE ядра от начала TXOP − SIFS (H-DURQ, `machw._dur_field`) — в каждый MPDU |
| EDCA_BACKOFF | просит доступ, начинает обмен по разрешению, если укладывается в CBAP | арбитр очередей H-BACKOFF (`machw._backoff_kick/_fire`): max(сейчас, NAV, конец занятости) + AIFS_CLK + U[0, 15]·SLOT_CLK, AIFS одна на все очереди |
| NAV | спрашивает адаптер | кадр не себе — конец + Duration (+ A-BFT у маяка, H-NAVABFT, `Air._nav_us`); CF-End NAV не сбрасывает |
| BEACON_TIMESTAMP | — | Timestamp = TSF начала PPDU (H-BIC) |

В идеальной среде набор пуст, поведение этапов 1–2 не изменилось: журналы ядра сценариев этапа 2 и `Bss` побайтно те
же (сверка с open), тесты ref-набора зелёные.

**Ядро, дополненное по находкам смешанных пар** (по стандарту; в идеальной среде журналы прежние):
- ответчик обучения приёма (10.42.6.4.1): на BRP с L-RX > 0 — BRP-RX с L-RX·4 подполями TRN-R, RX-train-response = 1,
  Initiator = 0; BRP инициатора, завершающий setup, — BRP-RX, если ответчик запросил L-RX (10.42.3.2); TXTIME с TRN —
  `ref/brp.brp_txtime` (20.11.3). Без этого станция-прошивка после SLS ждёт TRN и не подключается;
- ожидание ответа на BRP setup — BRPIFS (10.3.2.3.9; было SIFS — ответ прошивки через 18,9 мкс терялся);
- значение DMG BSS Parameter Configuration вне SYNTAX MIB (точка-прошивка: PS Request Suspension Interval = 0, MIB
  1..64) не принимается (11.3.5.2 d)), ассоциация не рвётся;
- SME: выбор BSS по BSSID, если DMG Beacon без SSID (табл. 9-45: SSID необязателен; маяк прошивки его не несёт);
  `StaSme.pause_us`; повтор MLME-ADDBA после отказа получателя (`ApSme.addba_retry_us`); `DmgMac.mgmt_mcs`.

### Результат (open, 7 сценариев этапа 2)

Счёт: прошивка ≠ стандарт / ядро ≠ стандарт / модель MAC / трактовка / неопределённо / ядро на Sparrow ≠ стандарт.

| Режим | Итог |
|---|---|
| ядро-Sparrow против ядра (`core-sparrow`) | 1-STA: 0 / 0 / 29–43 / 0 / 0–2 / 0; `sls-2sta`: 0 / 0 / 40 / 1 / 7 / 0 — всё расхождение — точки разгрузки |
| прошивка против ядра-Sparrow (`fw-sparrow`) | «прошивка ≠ стандарт» — те же 11 уникальных, что против ядра в идеальной среде (BTI через 12–14 мкс после TBTT; при 2 STA — CF-End с RA другой станции, BRP с Initiator 0, CF-End не на границе слота; при BI 10 TU — A-MPDU/CF-End станции в BTI, RTS за концом CBAP): находки прошивки не зависят от того, идеальна ли среда у ядра |
| `mixed-ap`, preset core | соединение и данные во всех 1-STA сценариях, кроме `sls-1sta-dl` (uc станции: uc_assert 0x26 в txop_await_cts_ppdu на 36 мс) |
| `mixed-ap`, preset compat | 6 из 6: соединение, данные в обе стороны |
| `mixed-sta`, preset core | срыв точки-прошивки в 5 из 6 (uc_assert 0x26/0x6019, ниже); BI 10 TU — вниз 48/48, вверх ADDBA станции без Ack. С допущением H-RESPEXP (machw, ветка строгого TDMA) `sls-1sta` проходит: поздняя команда ответа — уже не ответ, пир повторяет кадр |
| `mixed-sta`, preset compat | 5 из 6 целиком; BI 10 TU — uc_assert 0x6002 точки на 135,6 мс |

Расхождения железа/модели со стандартом (ядро-Sparrow против ядра; все — «модель MAC эмулятора»):

| Расхождение | Пункт | Допущение |
|---|---|---|
| ответы через 3,55 мкс (SIFS + MACLAT), мост — «не SIFS» | 10.3.2.3.3 | H-RESPCMD |
| Duration ответов MAC: Ack 0, DMG CTS/BlockAck на 1 мкс меньше; BlockAck на MCS 1 в ответ на MCS 11 (допустимо 2–4) | 9.2.5.7, 9.3.1.13, 10.6.7.2 | H-RESPCMD, H-RESPMCS |
| Duration RTS, A-MPDU и кадров управления — остаток лимита TXOP (2030/1944/2040 против 102/7); NAV RTS за TBTT при BI 10 TU | 9.2.5.2 | H-DURQ |
| доступ: AIFS AC_BE для кадров управления (AC_VO), не граница слота от AIFS[AC_VO] | 10.23.2.4 | H-BACKOFF |
| Timestamp маяка — TSF начала PPDU (−5/−6 мкс; при BTI ровно в TBTT судья `timestamp`) | 11.1.3.1 | H-BIC |

Найдено смешанными парами (прошивка или модель MAC, стандарт на стороне ядра; решает стенд):

| Что | Доказательство |
|---|---|
| точка-прошивка не успевает с ответом через SIFS на кадр станции вскоре после SLS (Association Request через 23 мкс после SSW-Ack — команда ответа через 43 мкс) и сразу после ассоциации (ADDBA во время подготовки своей SLS — 39 мкс); uc_assert 0x26/0x6019 | `mixed-sta` preset core; uc в это время исполняет команды LMAC fw по событию BF или готовит развёртку (cmd_log) |
| короткий кадр управления на MCS 1 (ADDBA Request, 3,4 мкс) от ассоциированной станции uc точки не подтверждает: rx_flow_run уходит в ветку рассинхронизации счётчика PPDU (0xeeee04), 8 повторов без Ack | `mixed-sta`; на MCS 0 (control) — Ack есть; кадры управления SC у прошивки не встречаются — сроки H-HDR-SC/H-PHYRX для таких кадров не сняты |
| то же у станции-прошивки (`mixed-ap`): короткий кадр управления точки-ядра на SC (Action ADDBA Response 3,4 мкс, Association Response 4,8 мкс) без Ack — **исправлено (fix/sc-short-ack)**. Корень — uc `rx_flow_run`: PPDU, ради которого uc вошёл (busy_event), кончается раньше проверки счётчиков PPDU (путь от прерывания до неё ~460 тактов, заголовок SC разобран через 2,47 мкс), концов PPDU на один больше своего счётчика — ветка рассинхронизации 0xeeee04 считала кадр «без события». Теперь такой кадр (новый PPDU не начался, отчёт r42 б16 не снят, SC, SIFS_CNT < `SIFS_CNT_RX_LATE_END_SC` 1,55 мкс) разбирается с Ack. Тик L1 (таймер 0, ~330 тактов, тот же уровень L1) перед кадром сдвигал вход так, что и этот путь не успевал: между шагами тика — проверка busy_event и сначала обработчик событий L1 (`l1_tick_rx_first`). Прогоны, где ADDBA Response проходил с 3-й попытки, — допущение модели: спящий uc узнавал о кадре, вставленном эфиром, только со следующим событием железа (sfd_sync, +204 такта у SC) — линии прерываний теперь пересчитываются (`air.py`, H-IRQ; стенд H-PHYRX: вход L1 по busy_event раньше sfd_sync). Без исправления uc при тике за 0–240 тактов до кадра — ни одного Ack на ADDBA Response и uc_assert 0x26/0x6002 (так срывались ветки fix/cbap-end-nav, feat/lm-info) | `mixed-ap` preset core, `unit/test_mixed_pairs.py` `test_ap_core_sc_mgmt_acked_*`, `unit/test_uc_rx_late_end.py`; 802.11-2020 10.3.2.11: Ack на индивидуально адресованный кадр — через SIFS |
| Ack через 3,55 мкс (минимум железа) на свой кадр очереди ломает продолжение TXOP точки: machw.ModelGap «закрыт кадр FIFO, пока идёт передача» | `mixed-sta`; с ответом через 4,95 мкс (как у железа с микрокодом) — нет; H-TXAFTERACK. Исправлено в модели (fix/sc-short-ack): кадр, закрытый uc, пока свой одноадресный кадр очереди ещё в эфире, MAC держит до ответа (как закрытый во время ожидания Ack) — так на стенде (MAC-STAND «Следующий кадр TXOP и повторы»: slot_event и закрытие следующего кадра — во время своей передачи) |
| DMG BSS Parameter Configuration в Association Response: PS Request Suspension Interval = 0 (MIB 1..64) | ядро-станция: `dmg_bss_param_invalid` |
| станция-прошивка отказывает в ADDBA точки до WMI_CONNECT_EVENT (Status 1, Buffer Size 0) | `mixed-ap`; ядро повторяет MLME-ADDBA через 5 мс — соглашение есть |
| станция-прошивка отвечает на BRP setup точки только с ~20-й попытки | `mixed-ap`; судья `brp setup-end` относит это к кадрам ядра — в паре атрибуция по кадрам ограничена |

Preset compat (`sparrow_scenario.PRESETS`) — выбор реализации в рамках стандарта ближе к узлам прошивки: пауза SME 3 мс
перед MLME-ASSOCIATE и MLME-ADDBA, кадры управления на MCS 0, ответ MAC через 4,95 мкс (230 тактов; стенд: DMG CTS
через 4,93/4,96 мкс). Тест «станция-ядро с умолчаниями» — xfail strict (`unit/test_mixed_pairs.py`): исправленная
прошивка даст XPASS.

Тесты этапа 3: `test_core_units.py` (наборы разгрузки, ядро с заглушкой адаптера, TXTIME BRP-RX),
`test_core_boundary.py` (адаптер — в tests/unit, ядро его не импортирует), `unit/test_adapter_sparrow.py` (правила
ответа, NAV, ось времени; пара ядро–ядро на адаптере: данные в обе стороны, ответы через SIFS + MACLAT, Duration
H-DURQ, Timestamp H-BIC, слоты H-BACKOFF; против ядра в идеальной среде — только модель MAC), `unit/test_mixed_pairs.py`
(обе пары: соединение, данные в обе стороны, фазы, судьи по передатчику, отчёт).

Ограничения: канал адаптера идеальный (как у `air.Air`; столкновения — у узлов прошивки machw H-COLL, у узлов ядра —
перекрытие PPDU в CoreNode), SNR постоянный, секторы — только номера; моменты прямых передач
ядра — момент PHY-TXSTART (H-ORIGIN/H-ORIGIN-RX не добавляются); смешанные пары — одна станция; SSW_SWEEP не
разгружается (этап 4).

## Этап 4: расширение ядра

Функции, которые модели `ref/*` уже описывали как проверки, ядро теперь исполняет. Каждый пункт — исполняется в ядре,
тесты ядро ↔ ядро в идеальной среде (оба судьи — 0 нарушений), сценарии сравнения с прошивкой (`diff_scenario`).

### 4.1 BRP с TRN, сопровождение луча, поддержание направленной связи (`bf.py`)

```
cd rewrite/tests && python3 -m pytest ref/core/test_core_bf.py -q -p no:xdist
```

| Что исполняется | Пункт | Как |
|---|---|---|
| MLME-BF-TRAINING.request(RequestBRP = true) | 6.3.91, 11.36 | SLS в DTI, затем фаза BRP в том же TXOP |
| свои запросы BRP в SSW-Feedback / SSW-Ack | 9.3.1.16, 10.42.2.5 | L-RX — единиц TRN-R под свои AWV приёма, TX-TRN-REQ; Duration SSW-Feedback — SSW-Ack + 2·MBIFS (9.3.1.16 a)); ответчик — по `BfConfig.brp_on_sls` |
| транзакция уточнения | 10.42.6.4.1–10.42.6.4.3 | первый BRP — через MBIFS после SSW-Ack; при L-RX в SSW-Ack — BRP-RX; содержимое кадров — `ref/brp.Participant` (BRP-RX на L-RX, TX-TRN-OK/TX-train-response, BS-FBCK, FBCK-TYPE и Channel Measurement Feedback 9.4.2.136 на TRN-T); ответы через SIFS; конец по 10.42.3.1 a) или b) (повтор кадра через BRPIFS, 10.42.6.4.1); Duration — остаток TXOP; бит Initiator — по 10.42.6.4.1 (последний принятый / переданный PPDU) |
| BRP в отдельном TXOP | 10.42.3.1 | `start_brp` (EDCA AC_VO); ответчик SLS начинает транзакцию только в следующем распределении (в CBAP-only DTI — после BTI, PLAN №20) |
| итог BRP | 10.42.6.4.4 | AWV передачи — по BS-FBCK пира, AWV приёма — лучший SNR на TRN-R; приём ответов в транзакции — уточнённой AWV |
| сопровождение передачи | 10.42.7, табл. 10-31 | PPDU данных с BEAM_TRACKING_REQUEST, PPDU_TYPE TRN-T и подполями TRN-T (если пир объявил предел ≠ 0 и выполнено условие повтора); ответчик — BRP с обратной связью через EDCA не позже предела (FBCK-TYPE — как в последнем BRP инициатора с TX-TRN-REQ, иначе 0 и BS-FBCK); опоздавший ответ инициатор игнорирует |
| поддержание связи | 11.27.1, 9.5.6 | dot11BeamLinkMaintenanceTime по полям BLM (табл. 9-345); таймер на связь: ставят SLS/BRP, принятый немедленный ответ (инициатор), переданный ответ (получатель); стоит в BTI и A-BFT; без MSDU — QoS Null (Normal Ack); истечение — приём квази-омни, инициатор связи — ISS |
| деградация связи (политика) | 11.27.1 (последние абзацы) | `BfConfig.degrade_db`: падение SNR от пира против опоры (после BF, та же диаграмма приёма) → уточнение (сопровождение при данных, иначе BRP); после уточнения снова падение или ≥ `resls_db` / `fail_limit` неудач подряд → повторное BF: станция — RSS в A-BFT, если маяки объявляют A-BFT («should»), иначе SLS в DTI; неудачное SLS — снова через BI |

Когда стандарт **требует** переобучения (вопрос частых SLS на стенде): никогда. 11.27.1 и 10.42 только **разрешают**:
ISS «may» — в любой момент, в том числе до истечения таймера связи; при деградации «can use beam tracking or beam
refinement»; станция, ещё принимающая маяки с Next A-BFT = 0, «should» улучшать связь RSS в A-BFT. Обязательно: QoS
Null, если таймер связи определён и MSDU нет («shall transmit QoS Null frames to maintain a beamformed link»), приём
квази-омни у ответчика после истечения, BRP после SLS при запросах в SSW-Ack (10.42.6.4.3). Повторное SLS без
деградации и без истечения таймера — выбор реализации, не требование.

Расширение модели PHY-SAP (`sap_phy`, стандарт оставляет выбор AWV и измерение на TRN реализации): `Beam.awv`
(уточняющая AWV внутри сектора), `TXVECTOR.TRN_AWVS` (AWV подполей TRN-T), `PHYCONFIG_VECTOR.RX_TRN_AWVS` (перебор AWV
приёма на TRN-R), `RXVECTOR.TRN_SNR` (SNR на каждом подполе). Идеальная среда: положение луча = сектор + awv·¼
сектора; лучшее положение пары может быть дробным (SLS находит ближайший сектор, BRP — AWV); `move` — смена лучших
положений во времени (деградация), `block` — затенение.

Найдено и исправлено в ядре по ходу (поведение этапов 1–3, проявлялось только за пределами прежних сценариев):
- больше 4096 MSDU в очереди под соглашением BA: SN по модулю 4096 совпадали с неподтверждёнными, MSDU терялись
  (передача вставала на 4096-й) — SN выдаются только в окне передачи (10.25.6.2, `_ba_refill`);
- адаптация MCS: SNR на чувствительности MCS 0 входил с минусом — MCS выбиралась на 1 дБ ниже чувствительности
  (`la_mcs`, `LA_SNR_MCS0_DB`); журнал `Bss(n_sta=2)` изменился;
- Duration RTS: на оси передатчика TPENDING длиннее суммы TXTIME и SIFS на распространение (ответы начинаются через
  SIFS после конца приёма) — при целом pend Duration была меньше TPENDING; запас 3·aAirPropagationTime (журнал
  `sls-1sta-burst` изменился).

Уточнения судей (журнал ядра знает больше, чем запись PMC; на записях стенда поведение прежнее):
- `AirEv.trn` — TXVECTOR (TRN_LEN, PPDU_TYPE, запрос сопровождения, подполя добавлены): `air_judge.r_brp` с ним
  проверяет правила TRN (BRP-RX на L-RX, TRN-T, BS-FBCK, CMF) и «последний принятый PPDU» по всем PPDU;
  `r_beam_track` — `ref/beamtrack.check_bt_log` по парам; `brp.check_brp_log` — BS-FBCK обратной связи сопровождения
  (PLAN №111); `r_brp_role` — обратная связь сопровождения и ответ на неё — не начало уточнения;
- `r_blm` — успешный BRP тоже ставит таймер (11.27.1); `linkmaint.check_blm_log` — истечение после переданных, но не
  подтверждённых кадров (затенение) — не нарушение «shall transmit QoS Null» (PLAN №112), одно замечание на истечение;
- `r_sls` — кадры A-BFT не SLS в DTI (A-BFT после SLS в DTI склеивался с ним);
- `cbap.check_air_log` — необязательные ошибки приёма по STA (EIFS, 10.3.2.3.7) и кто PPDU обнаружил (скрытая STA при
  затенении: чужой PPDU не занимает её среду и NAV); `judge_run.cbap_ac` берёт их из снимка журнала ядра
  (`rx_err`, `sensed`); `r_responder` — узел, не принявший ни одного кадра TXOP, не «ответчик» в нём.

Трактовки и ограничения: BRP по политике MAC после ассоциации (не MLME-BF-TRAINING) судья `bf_training` по эфиру не
отличает от обучения по MLME и даёт вердикт model (тесты его допускают явно); уточнённая AWV приёма применяется только в
транзакциях BRP (10.42.6.4.4) — в обменах данными приём квази-омни (адаптация MCS ядра опирается на взаимность канала,
верную при одинаковых диаграммах приёма); QoS Null поддержания связи шлёт станция (у точки запас вдвое меньше — её QoS
Null нужен, только если станция не успела); не исполняются MIDC (MID/BC), TXSS-FBCK, сопровождение приёма (TRN-R,
добавляемые ответчиком к следующему PPDU), Other_AID, несколько DMG-антенн, RXSS.

Тесты `test_core_bf.py`: юниты (TRN во TXVECTOR и TXTIME, AWV и TRN_SNR среды, кодек CMF, исключение BS-FBCK, правила
инициатора сопровождения), SLS + BRP (кадры, промежутки MBIFS/SIFS, AWV +¼ сектора у обеих сторон, судьи 0),
сопровождение луча при уходе луча на ½ сектора (обе стороны, AWV +½, судьи 0), уход на 2 сектора — повторное BF (A-BFT
и SLS в DTI), BLM — QoS Null, затенение 22 мс, истечение и восстановление (A-BFT и DTI), негативные (нет QoS Null —
судья `blm`; неверная длина TRN-R — судья `brp`).

### 4.2 Расписание DTI: SP, PP/GP, продление, усечение, восстановление (`dti.py`)

```
cd rewrite/tests && python3 -m pytest ref/core/test_core_dti.py -q -p no:xdist
```

| Что исполняется | Пункт | Как |
|---|---|---|
| Extended Schedule точки | 9.4.2.131, 10.39.6.1–10.39.6.5 | политика SME (`DmgApMac.sched_policy`: BI → [schedule.Req]); `schedule.plan` от конца BHI + guard: guard time, aDMGPPMinListeningTime между SP с общей STA, Allocation Start — младшие 32 бита TSF; элемент в каждом DMG Beacon (табл. 9-45: после DMG Capabilities), CBAP Only = 0; без политики — CBAP Only (этапы 1–3). Политики: `policy_sp` (CBAP для входа, SP STA → AP и AP → STA, SP broadcast под PP/GP, CBAP на остаток), `policy_cbap_split` (как простой TDMA прошивки: общее CBAP + CBAP {STA → AP} поровну, псевдостатичные, при ≥ 2 STA) |
| расписание у станции | 10.39.6.1, 10.39.6.4 | `schedule.StaView` по маякам своего BSS (obsolete allocation, псевдостатичные при пропуске маяка) → периоды `bi.layout` по своему TSF |
| доступ EDCA | 10.39.5 | только в CBAP-распределениях, где STA вправе начинать обмен (broadcast или свой Source/Destination AID); окна по очереди, NAV и EDCAF между ними заморожены |
| SP: источник | 10.39.6.2 | обмен в начале SP без RTS: A-MPDU + BlockAck (MSDU + Ack) через SIFS, каждый с ответом до конца SP; повтор без ответа — через PIFS; Duration — SIFS + ответ (SP — не TXOP EDCA) |
| усечение SP | 10.39.8.1 | очередь пуста, SP Truncatable, время на обмен есть: CF-End к AP (если AP не пир), затем CF-End пиру |
| продление SP | 10.39.9 | к концу Extendable SP очередь не пуста — SPR к AP (Duration — остаток SP, Allocation Duration — сколько нужно, ≤ 4 мс); AP — Grant через SIFS, гарантирует только при следующем SP broadcast/broadcast длиннее запрошенного; Grant партнёру, если он не AP; PP точки сдвигается за продлённый SP |
| восстановление SP | 10.39.6.7 | AP-получатель Truncatable SP без кадров источника за dot11SPIdleTimeout — Grant источнику на остаток (10.39.7) |
| PP/GP | 10.39.7.2, 10.39.7.3, 10.39.4 | в SP broadcast/broadcast: Poll каждой связанной STA через SBIFS (Duration и Response Offset — ур. (10-18)); SPR станции через Response Offset (DAI — время под свою очередь); GP «SIFS following the end of a PP» (PLAN №47): Grant каждой запросившей, начало выделения — PHY-TXEND Grant + Duration (0 или SIFS + Grant Ack); станция — Grant Ack через SIFS при Grant Ack Supported, обмены в окне как источник SP; следующий GP — после конца окна |

Найдено и исправлено в ядре: ответчик SLS, принявший кадры ISS, мог начать свой обмен EDCA до RSS (оставшиеся кадры
ISS направленной развёртки не слышны — среда «свободна»), и RSS не начинался (10.42.6.2: «shall begin an RSS MBIFS
following the completion of an ISS») — до RSS ответчик в EDCA не участвует (журнал `sls-2sta` изменился).

Уточнения судей (журнал ядра; на записях стенда CBAP Only — без изменений):
- мост `judge_run`: периоды BI — с распределениями Extended Schedule маяков (мост знал только CBAP Only — при CBAP Only
  = 0 весь DTI был «вне периодов»; относится и к простому TDMA прошивки); `bi_ac` — AID станций и окна Grant /
  продления (ref/sp.check_dti); SPR на Poll — не «чужой»; Duration кадров в SP — правило SP (не лимит TXOP), конец
  обмена TXOP в Duration RTS — в пределах периода;
- `air_judge`: TXOP (`_txops`: txop_limit, nav_txop, holder_gap, responder_tx) — только вне SP по расписанию;
  `responder_tx` — SPR на Poll, Grant Ack на Grant, Grant точки на SPR продления — ответы; `access` — статистика
  «фактический AIFS» только по доступам, которые мог задержать backoff (idle ≤ AIFS + CW·aSlotTime): после долгого
  простоя очередь была пуста.

Не исполняется: ATI (Announce, Poll в ATI, восстановление по ATI), DMG protected period (DTS), уступка SP Grant-ом,
усечение Grant-ом с CBAP, Heartbeat, BF в SP по Beamforming Training, PCP Active = 0, распределения из нескольких
блоков, spatial sharing.

Тесты `test_core_dti.py`: политики (`schedule.check` без нарушений, «как TDMA прошивки»), SP (обмены без RTS, усечение,
ни один кадр за концом SP), PP/GP с двумя станциями, продление, восстановление (маяки BTI затенены), CBAP {STA → AP}
двух станций, негативные (передача в чужом SP, обмен за концом SP — судья `sp_access`).

### 4.3 Link Measurement, DMG Link Margin, LA Ack, Information Request/Response (`lm.py`)

```
cd rewrite/tests && python3 -m pytest ref/core/test_core_lm.py -q -p no:xdist
```

| Что исполняется | Пункт | Как |
|---|---|---|
| MLME-LINKMEASURE.request/.confirm | 6.3.32 | Link Measurement Request (9.6.6.4, Action с Ack, токен ≠ 0); после Ack — кадр измерения (QoS Null, если данных к пиру нет); confirm с полями отчёта и DMG Link Margin; нет отчёта за 20 TU — UNSPECIFIED_FAILURE |
| отвечающая STA | 10.43.1, 11.10.11 | `rm_link_meas` (dot11RMLinkMeasurementActivated, бит RM Enabled Capabilities в Association Request/Response и Probe Response): отчёт `ref/linkadapt.LinkMeasResponder` — TPC Report, RCPI/RSNI и антенна кадра запроса, DMG Link Margin по следующему кадру запросившей (Activity, MCS, Link Margin, SNR, Reference Timestamp — конец PPDU измерения); выключено — запрос игнорируется (у точки — обязательно) |
| рекомендация MCS | 10.43.1, 9.4.2.142 | Activity «Change MCS» — верхняя граница своей MCS к пиру (`_la`: обратная связь о канале пира вместо одной взаимности) |
| DMG TPC | 10.43.2 | на совет «уменьшить/увеличить мощность» (отвечающая STA советует при `lm_power_advice` и запасе ≥ 10 дБ) — ядро мощность не меняет: отчёт с DMG LA Ack, Activity 0, токен 0, не позже 2·aPPDUMaxTime после Ack на полученный отчёт (`ref/linkadapt.TpcPeer`) |
| Information Request/Response | 11.28.1, 11.28.2 | `info_request(peer, subject, requested, presence)` (MLME-примитива в 6.3 нет — метод MAC для SME); ответ `ref/discovery.InfoStation`: точка — только при 11.28.2 a–c, о себе, о члене BSS, обо всех (DMG Capabilities членов); non-AP не о себе — «без элементов»; RCPI/RSNI — при dot11RadioMeasurementActivated; поддерживаемые элементы — RM Enabled Capabilities, DMG Operation (точка) |

Не исполняется: быстрая адаптация (10.43.3 — требует RD, у нас выключен, PLAN №35), управление мощностью по совету,
Radio Measurement, unsolicited Information Response, robust-защита Action (RSNA).

Тесты `test_core_lm.py`: обмен STA → AP и AP → STA (токен ≠ 0, кадр измерения, Reference Timestamp, совет мощности и LA
Ack с Activity 0, рекомендация MCS), Information Request о точке/обо всех/о чужой STA у non-AP/проверка присутствия,
точка без dot11RMLinkMeasurementActivated игнорирует запрос, RM Enabled Capabilities в ассоциации, негативные (отчёт
без DMG Link Margin — `link_meas`, LA Ack без совета мощности — `link_margin`).

### 4.4 Децентрализованная кластеризация AP (`cluster_ap.py`)

```
cd rewrite/tests && python3 -m pytest ref/core/test_core_cluster.py -q -p no:xdist
```

| Что исполняется | Пункт | Как |
|---|---|---|
| S-AP | 10.40.1, 10.40.2.1 | Clustering Control в каждом DMG Beacon (Beacon SP Duration = ⌈dot11BeaconSPDuration / 8⌉, PLAN №80; Cluster ID — свой MAC; роль S-AP; ClusterMaxMem — BI / ClusterMaxMem целое число мкс), CC Present = 1, ECAPC Policy Enforced = 0; DMG Capabilities: Decentralized AP or PCP Clustering = 1 |
| вход членом | 10.40.2.1 | MLME-START → прослушивание aMinChannelTime без своих маяков; S-AP децентрализованного кластера и пустой Beacon SP (`cluster.empty_beacon_sps`) — член: BI, Beacon SP Duration, ClusterMaxMem — копии S-AP; свой TBTT — TBTT S-AP (по Timestamp, 11.1.3.1) + ClusterTimeOffset_{n−1}, свой TSF сдвинут (11.1.3.3.1); пустых нет — S-AP своего кластера («may», PLAN №90) |
| расписание | 10.40.2.1, 10.39.6.5 | Extended Schedule — Beacon SP других AP (SP 255→255, PLAN №83) и CBAP broadcast в промежутках с guard time; в чужих Beacon SP ни точка, ни её станции не передают; Beacon SP не берутся под PP/GP |
| сопровождение | 10.40.3.2 | маяки S-AP — `DecentralizedAp.on_beacon`; конец BI — `end_bi` (потеря S-AP, периоды мониторинга, становление S-AP) |

Сценарий — `scenario.ClusterNet`: точка 1 (S-AP) и точка 2 (член), у каждой станция; судьи — по журналу каждого BSS
(`Journal.view`: свои узлы и маяки другой точки как чужие, время — TSF своей точки), мост — только свой BSS (рассчитан
на одну точку).

Не исполняется: централизованная кластеризация (ECAPC, CCSR, 10.40.2.2), Cluster Report станций (10.40.4), Cluster
Request (10.40.5), смена параметров BSS в кластере (11.29.4), CDMG (10.41). Сравнения с прошивкой нет — кластеризацию
она не поддерживает (Decentralized/Centralized Clustering = 0), смешанные пары — одна точка.

Тесты `test_core_cluster.py`: вход в пустой Beacon SP после aMinChannelTime, маяки каждой точки — в своём Beacon SP,
поля Clustering Control и Beacon SP в Extended Schedule, ни одной передачи в чужом Beacon SP, судьи обоих BSS — 0,
ClusterMaxMem 1 — точка 2 становится S-AP, негативный (маяки члена вне своего Beacon SP — судья `cluster`).

### 4.5 Смена канала (ECSA) и длительности BI (`bsschg.py`)

```
cd rewrite/tests && python3 -m pytest ref/core/test_core_bsschg.py -q -p no:xdist
```

| Что исполняется | Пункт | Как |
|---|---|---|
| MLME-EXTCHANNELSWITCH.request/.confirm/.indication | 6.3.35, 11.8.8.6 | решение — только точка (`ecs_activated` = dot11ExtendedChannelSwitchActivated, бит Extended Channel Switching в Extended Capabilities — 11.9.1); ECSA (9.4.2.52) в каждом DMG Beacon до смены, Count — число TBTT, одинаков в BI, −1 на TBTT (`ref/chswitch.ApChannelSwitch`); смена канала перед TBTT (PHY-CONFIG OPERATING_CHANNEL); станция — к тому же TBTT (`StaChannelSwitch`), ECSA не передаёт |
| смена длительности BI | 11.29.3, 11.1.3.3.1 | `request_bss_change(new_bi_tu)` (метод SME): план `ref/bssparams.ApBssParamChange` — dot11NbrOfChangeBeacons (5 > dot11MaxLostBeacons, PLAN №38) TBTT с DMG BSS Parameter Change (табл. 9-45: после DMG Operation), на TBTT N+1 — новый BI и сброс TSF в 0; станция — BI по полю Beacon Interval маяка, TSF по Timestamp |

Идеальная среда: PPDU доставляется только PHY на том же OPERATING_CHANNEL (20.2.3). Судьи при смене BI — по участкам до
и после вступления (`Journal.view(t_from, t_to, shift, bi_tu)`: сетка BI судей постоянна), ряд маяков — `bss_params` по
всему журналу.

Не исполняется: перенос TBTT (11.29.2: BI N+1 = разность — станции нужен счёт BI по маякам, не по TSF), рекомендация STA
(11.29.5), кадр ECSA и ECSA в Announce/Information Response, Max Channel Switch Time. Сравнения с прошивкой нет: в
эмуляторе (`air.Air`) нет каналов, команд смены канала/параметров сценарий прошивки не задаёт.

Тесты `test_core_bsschg.py`: ECSA (Count 3, 2, 1 в маяках BI 3–5, смена у обеих сторон перед TBTT BI 6, данные после
смены, бит Extended Channel Switching), смена BI 100 → 50 TU (вступление после 5 объявлений, станция следует, судьи по
участкам — 0), негативный (объявление оборвано до смены — судья `ecsa`).

### Результат этапа 4: сравнение с прошивкой (сборка open, эмулятор)

Новые сценарии `diff_scenario`: `brp-1sta`, `idle-1sta` (п. 1), `tdma-2sta`, `sp-1sta`, `ppgp-1sta` (п. 2, последние два —
BI 10 TU), `lm-1sta` (п. 3). Ядро против ядра — 0 расхождений во всех 13 сценариях; «ядро ≠ стандарт» — 0 во всех
сравнениях с прошивкой.

```
pypy3 -m ref.core.diff_report --scenario all --build <dir> --out-dir <dir> --save-snapshot          # прошивка против ядра
pypy3 -m ref.core.diff_report --scenario brp-1sta --against mixed-ap --mixed-preset compat --build <dir>
```

| Сценарий / режим | Итог |
|---|---|
| все 13, прошивка против ядра | «прошивка ≠ стандарт» 1 (1-STA: BTI через 12–14 мкс после TBTT), `sls-2sta`/`tdma-2sta` 5, `sls-1sta-bi10` 5, `brp-1sta` 8, `sp-1sta` 4; модель MAC 45–63, трактовка 2 |
| `brp-1sta` | прошивка: L-RX 16 в SSW-Feedback и SSW-Ack, TX-TRN-REQ не просит, 4 SLS за подключение (одна — точкой); ядро: L-RX 2 + TX-TRN-REQ, транзакция с TRN-T и TRN-R, 1 SLS. «Прошивка ≠ стандарт» 8 — SLS точки и станции после ассоциации начаты на одной границе слота: ISS обеих чередуются поверх друг друга (судьи: «оборван на CDOWN», Total Sectors); это коллизия двух доступов, а модель эфира эмулятора коллизии не разбирает — по сути «неопределённо», решает стенд (прежние судьи дают то же — не следствие уточнений) |
| `idle-1sta` | за 250 мс простоя прошивка SLS не повторяет и QoS Null не шлёт (BLM у неё не определён — обязанности нет); ядро с BLM 10 мс — 27 QoS Null, повторного BF нет. Частые SLS стенда в эмуляторе с идеальным каналом не воспроизводятся — причина вне простоя (качество канала, которого эмулятор не моделирует) |
| `tdma-2sta` | прошивка падает до включения TDMA: вторая станция подключилась на 116 мс, uc_assert(0x6002) в txop_await_cts_ppdu на 128 мс (известно с этапа 2 для 2 STA) — простой TDMA прошивки с расписанием ядра не сравнён |
| `sp-1sta`, `ppgp-1sta` | прошивка (1 STA) — CBAP Only, SP/PP/GP не делает; в `sp-1sta` — две одновременные RTS (коллизия, та же оговорка) |
| `lm-1sta` | прошивка Link Measurement / Information Request не начинает (по сценарию не может) |
| `mixed-ap` compat, `brp-1sta` | точка-ядро + станция-прошивка: соединение, данные в обе стороны; «ядро на Sparrow ≠ стандарт» 3 — нарушения на кадрах ядра, вызванные станцией-прошивкой: на BRP setup она отвечает лишь с ~20-й попытки (этап 3) и не отвечает на BRP точки с запросами в транзакции после SLS (10.42.6.4.2: «shall respond») |
| `mixed-ap`, `sp-1sta` | preset core: uc_assert(0x26) станции-прошивки в txop_await_cts_ppdu (17 мс, как `sls-1sta-dl` этапа 3); compat: срыв эмуляции — в регистр uc попадает дробное значение времени (TypeError в arcemu write_reg) — ограничение адаптера, не исправлялось |
| `mixed-ap`, `ppgp-1sta` | срыв эмулятора: «отчёт приёма кадра ядра FC 0x0264 (Poll) не моделируется» — PP/GP со станцией-прошивкой в эмуляторе не проверить |
| `mixed-sta`, `brp-1sta`, `lm-1sta` | точка-прошивка срывается до данных (uc_assert 0x6019 в bcon_txss_sweep_step; compat — machw ModelGap «закрыт кадр FIFO») — известные срывы этапа 3; Link Measurement и Information Request к прошивке не дошли |

Уточнение судьи, изменившее вывод этапа 2: `air_judge.r_brp` брал «последний принятый PPDU» (бит Initiator,
10.42.6.4.1) только среди кадров BRP — SSW-Ack перед первым BRP не учитывался. После уточнения (все PPDU с известным
временем; BS-FBCK без полей TRN — «не проверяемо») находка «BRP точки к STA2 с Initiator = 0» (`sls-2sta`) исчезла — это
был артефакт судьи.

## Дальше

- Этап 4: SSW_SWEEP не разгружается; не исполняются — ATI, DMG protected period, централизованный кластер, быстрая
  адаптация (RD), перенос TBTT, MIDC. (расписание DTI, Link Measurement, кластеризация, смена канала/параметров BSS) — ниже по мере
  исполнения; SSW_SWEEP не разгружается.
