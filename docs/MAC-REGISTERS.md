# Регистры локального чтения MAC (MSXD_LR_RGF)

Как ucode читает регистры MAC через команду 0x1d и ARC-регистры результата r36…r56,
какой регистр стоит за каждым селектором и что означают поля, важные для биконинга
(`BI_COUNTER.bi_sync`, `BACKOFF_IFS_STATUS`, NAV). Регистровый файл взят из символьного
пака 11ad 7.5 (соседний чип wil6436, раздел `globals/`) и сверен с Sparrow по группе R40.
Метки: **[код]** — по листингу, **[пак]** — по именам пака, **[железо]** — на стенде.
Номера сайтов и адреса — **[4.1]**.

## Идиома чтения **[код]**

```asm
ld.as r2,[gp,-0x44]        ; теневая копия слова-селектора
and   r2,r2,0xffff0fff     ; очистить поле индекса (здесь биты 12..15)
bset  r0,r2,0xe            ; поставить индекс (здесь 4) и сохранить копию
st.as r0,[gp,-0x44]
or    r2,r2,0x1d004000     ; 0x1d00 = операция чтения, 0x4000 = индекс 4
mov_s r32,r2               ; отправить запрос MAC
st.ab r2,[r25,0x4]         ; та же запись в кольцо команд MAC (r25)
bclr  r25,r25,0xa          ; заворот кольца (256 записей по 4 Б)
nop; nop; mov 0,0          ; задержка конвейера
<использовать r40>         ; результат — в ARC-регистре группы (здесь r40)
```

Пример — `uc_read_tsf64` (0x930cda: `or r1,r1,0x1d005000`, `mov_s r32,r1`,
`st.ab r1,[r25,0x4]`, `bclr r25,r25,0xa`).

**Младшие 16 бит (и биты 16..19) — не адрес, а селектор.** Положение поля индекса
зависит от группы (регистра результата):

| группа | поле индекса | пример запроса |
|---|---|---|
| r40 | биты 12..15 (биты 0..11 — субселектор, используется только при индексе 0) | `0x1d004000` |
| r41 | биты 8..11 | `0x1d000300` |
| r47 | биты 16..19 | `0x1d010000` |

Старшие 16 бит — код операции (`0x1d00` = чтение). В кольцо пишутся и десятки других
префиксов — записи и команды MAC, трассировочные метки `0x00caxxxx`/`0x00eeeexx`
(см. [MAC-COMMANDS.md](MAC-COMMANDS.md)). В ucode 4.1 — **825 записей в кольцо**,
из них **65 запросов чтения** `0x1d0x_xxxx`; построчный список с именами —
`4.1/ref/MAC-LR-READS.txt` (69 сайтов, `tools/mac_lr_reads.py`).

## Регистровый файл **[пак]**

`MSXD_LR_RGF` (MAC local-read) сгруппирован по ARC-регистру результата: группы
R36…R56 (R36–R39 — single-mapped), плюс `AC_PENDING_EXTENSION_R40` и
`SP_EXTENSION_R47`. Порядок внутри группы — индекс селектора. Всего 263 регистра с
битовыми полями: `6.2/ref/MSXD-LR-RGF.txt` (то же содержимое — `4.1/ref/MSXD-LR-RGF.txt`).
Пак относится к wil6436, но регистровый файл унаследован: совпали порядок и
использование (TSF low/high парой, 16-битный remaining time и т. д.).

### Группа R40: индекс ↔ регистр

| индекс | селектор | регистр | использование в ucode 4.1 |
|---|---|---|---|
| 0 | `0x0000` | **`BACKOFF_IFS_STATUS`** | `bmsk r40,0x2` = `idle_detect` |
| 1 | — | `AC_PENDING_SLOT_1_2` | — |
| 2 | — | `AC_PENDING_SLOT_3_4` | — |
| 3 | `0x3000` | `REMAINING_TIME_RD` | `extw` (16 бит) |
| 4 | `0x4000` | **`BI_COUNTER`** | `bmsk r40,0x19` и `lsr r40,0x1f` |
| 5 | `0x5000` | `TSF_LOW_R40` | `uc_read_tsf64` (0x930cb0) → `[r13]` |
| 6 | `0x6000` | `TSF_HIGH_R40` | `uc_read_tsf64` → `[r13,0x4]` |
| 7 | — | `REMAINING_BI` | — |
| 8/9 | — | `GP_TIMERS_0_1` / `GP_TIMERS_2_3` | — |
| a | `0xa000` | **`PHY_SIGNALS`** | самый частый |
| b | `0xb000` | `PHY_PLCP_RX_SIGNALS` | 1 сайт |
| c | — | `PHY_PLCP_RX_LEN` | — |
| d | `0xd000` | **`BF_METRIC`** (`BF_METRIC_R40`) | `lsr r40,0x9` |
| e | — | `REMAINING_SLOT` | — |
| f | — | `AC_PENDING_EXTENSION` | — |

### Число сайтов чтения **[4.1]**

По `4.1/ref/MAC-LR-READS.txt`:

| группа | регистр | сайтов |
|---|---|---|
| r40 | `PHY_SIGNALS` | 12 |
| r40 | `BACKOFF_IFS_STATUS` | 8 |
| r40 | `REMAINING_TIME_RD` | 5 |
| r40 | `BI_COUNTER` | 5 |
| r40 | `BF_METRIC_R40` | 5 |
| r40 | `TSF_LOW_R40`, `TSF_HIGH_R40` | по 1 |
| r47 | `COUNTER_EVENT_STATUS` | 8 |
| r47 | `RFC_SWITCH_ERROR_STATUS` | 5 |
| r47 | `LFSR_VAL` | 3 |
| r47 | `MTP_AGGREGATION` | 2 |
| r47 | `SP_CURR_CMD`, `RFC_SWITCH2RX_STATUS`, `DIRECT_TX_CMD_STATUS` | по 1 |
| r41 | `QSET_1_MASK_VECTOR` | 3 |
| r41 | `BAP_Q_AVAIL` | 2 |
| r41 | `QUEUE_SEL_STATUS_R41`, `QUEUE_SEL_FOUND_SET1_4_R41`, `MTP_Q_AVAIL` | по 1 |
| r49 | `NAV_COUNTER_VAL_ENTRY5` | 1 |
| r54, r37 | нет в регистровом файле | по 1 |

## `BI_COUNTER` и бит 31 = `bi_sync`

```
BI_COUNTER (группа R40, индекс 4):
    bi_counter   биты 0..25     ; позиция внутри Beacon Interval
    reserved0    биты 26..30
    bi_sync      бит  31        ; счётчик BI синхронизирован
```

Использование в воротах передачи маяка **[код]** (см.
[BEACONING.md](BEACONING.md#32-ворота-передачи-маяка-обе-код)):

* `uc_bi_counter_in_window` (0x932508), **ворота A**: `bmsk r1,r40,0x19` = `bi_counter`;
  открыто, если `bi_counter > BI − 15` **или** `bi_counter < 0x9c4` (2500 мкс), т. е.
  внутри окна BTI (`BI` — из `0x801434`);
* `uc_read_bi_sync` (0x931c64), **ворота B**: `lsr r0,r40,0x1f` = **`bi_sync`**.

`bti__bi2_event_step` (0x931f8c) комбинирует: `if (!gateA) return 0; if (!gateB) return 0;`.
Маяк уходит только внутри BTI и только при синхронизированном BI.

## Отсрочка маяка по занятости среды

Программная часть — NAV-ветка развёртки маяка
`bti_worker__bti_transmitter_beacon_sweep_flow` (4.1 0x923de0, 6.2 0x923cb4) над объектом
`nav_db` 0x800994: листинг, поля, условие взвода и замер на стенде —
[BEACONING.md §5](BEACONING.md#5-nav-отсрочка-маяка-обе-код-41-железо).

Аппаратная часть **[пак]**:

* `BACKOFF_IFS_STATUS` (R40, индекс 0): `idle_detect` биты 0..2, `nav_active` бит 3,
  `pending_ac` 4..7, `nav_active_bus` 8..15, `remaining_slot_ac1..ac4` по 4 бита
  (16..31);
* `PHY_SIGNALS_AND_CCA_MONITOR` (R44, индекс 1): `cca` 0..2, `phy_rx_frame` 3,
  `rx_on_air` 4, `tx_on_air` 5, `mac_rx_en` 6, `ppdu_event_counter` 8..13,
  `cca_event_counter` 16..21, `cca_ppdu_comp` 24.

Развёртка маяка перед работой проверяет `idle_detect == 5` (иначе ассерт `0x9243b4`), то
есть ожидает конкретное состояние среды. В направленном 60 ГГц NAV слышен только от узла, на
который наведён луч (`SparRAW-docs/research/WHY-MESH-ABANDONED.md`).

## Детекторы маяка в отчётах PPDU **[пак]**

| регистр | поле |
|---|---|
| `PPDU_REPORT_1_R36` (R36) | `beacon_detected` бит 7 |
| `PPDU_REPORT_3_R38` (R38) | `my_bssid_beacon_detected` бит 0, `other_beacon_detected` бит 1, `beacon_qid` 3..7 |
| `PPDU_REPORT_1_R50` (R50, индекс 2) | `beacon_detected` бит 7 |

Кандидаты на аппаратный детектор чужого маяка. В ucode 4.1 селекторы группы R36
через `0x1d0x` не читаются.

## Прочее

* `uc_read_tsf64` (0x930cb0) — чтение 64-битного TSF (`TSF_LOW_R40` + `TSF_HIGH_R40`).
* `PHY_SIGNALS` (0xa000) — самый читаемый регистр ucode.
* Адреса регистров MAC в пространстве памяти — [HARDWARE-BLOCKS.md](HARDWARE-BLOCKS.md);
  карта 6.2 — `6.2/ref/REGS-62.md`.

## Замечания

* Бит 31 `BI_COUNTER` — `bi_sync`, а не CCA, не NAV и не «принят чужой маяк».
  Отсрочка по занятости среды существует в программе (NAV), а не только в железе.
* Число сайтов по группам расходится между текстовым подсчётом по шаблонам
  (`BACKOFF_IFS_STATUS` 12, `BI_COUNTER` 4+1, `PHY_SIGNALS` 15, `BF_METRIC` 6,
  `REMAINING_TIME_RD` 5, `PHY_PLCP_RX_SIGNALS` 1) и `4.1/ref/MAC-LR-READS.txt`
  (таблица выше); список `MAC-LR-READS.txt` строится по полной идиоме с `mov r32`.

## Не установлено

* Регистры за чтениями `r54` сел. 0xd (`brp__program_and_measure`, 0x9239dc) и
  `r37` сел. 0xb (`rx_flow__handle_frame`, 0x92e258): в регистровом файле пака их нет.
* Используется ли в Sparrow `other_beacon_detected` (R38) и как его прочитать.

## Источники

`6.2/ref/MSXD-LR-RGF.txt`, `4.1/ref/MAC-LR-READS.txt`, `4.1/tools/mac_lr_reads.py`,
`4.1/src/asm/uc/`; команды MAC — [MAC-COMMANDS.md](MAC-COMMANDS.md).
