# Ядро DMG MAC (этап 1)

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
| `offload.py` | точки разгрузки (таблица ARCHITECTURE.md), `AdapterCaps`; этап 1 принимает только пустой набор |
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
| `test_core_units.py` | кадры, PSDU/A-MPDU, время, среда (доставка, CCA, задержка, коллизия, полудуплекс, чувствительность, луч), EDCA (слоты, заморозка), тайм-ауты, SAP-имена, разгрузка, форматы журнала |
| `test_core_integration.py` | точка + станция: 1 МиБ в обе стороны, данные целиком и по порядку, последовательность MLME, состав эфира, оба судьи — 0 нарушений, покрытие правил; варианты: только SLS в DTI, A-BFT + SLS с 16/8 секторами, 2 и 3 станции, BI 5 TU и 3 МБ (обмены у границы CBAP) |
| `test_core_negative.py` | порча поведения ловится: AIFSN 1 у STA, Duration DMG CTS, CF-End без запаса, Duration маяка, ответ через 5 мкс, данные до ассоциации, Duration SSW в A-BFT, обмен за TBTT, нет Supported Channels, A-MPDU длиннее предела получателя |
| `test_core_boundary.py` | ядро не импортирует tests/unit (AST и sys.modules в отдельном процессе) |

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

BRP с TRN (MLME-BF-TRAINING с RequestBRP = true), ATI, SP/PP/GP и строгий TDMA, сопровождение луча, Link Measurement,
кластеризация, RSNA, энергосбережение, несколько DMG-антенн, BlockAckReq/DELBA, фрагментация, A-MSDU, RD.

## Дальше

- **Этап 2.** Тот же сценарий (`sme.py`) — прошивка в эмуляторе (`unit/test_ref_diff.run_live`) и ядро в идеальной
  среде; оба журнала — `ref_bridge2.events` (ядро — `journal.to_snapshot()`, эмулятор — `ref_bridge2.snapshot()`) и
  судьи `judge_run.bridge`; отчёт расхождений: правила, нарушенные только у одной стороны, и сравнение промежутков
  (SIFS, AIFS+k·слот, Duration) по видам кадров.
- **Этап 3.** `adapter_sparrow.py`: PHY-SAP поверх `unit/machw.py` + `air.py`; набор `offload.Offload` по фактам
  MAC-STAND (SIFS-ответы, Duration, backoff, NAV, scoreboard, Timestamp, развёртка SSW) — ядро получает события вместо
  того, чтобы делать это само; смешанные пары ядро ↔ прошивка.
- **Этап 4.** BRP (с TRN), сопровождение луча, SP/PP/GP, кластеризация, Link Measurement — в ядре, сравнении и парах.
