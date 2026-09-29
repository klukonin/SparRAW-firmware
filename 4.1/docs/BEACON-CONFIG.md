# Конфиг биконинга 0x801438 и команда CMD_BCON_MGT (4.1.0.1000)

Раскладка 32-байтового блока конфигурации биконинга в данных ucode 4.1 (`0x801438`), код
отправителя команды fw→ucode `CMD_BCON_MGT` и её обработчика в 4.1, читатели блока.
Общая для 4.1 и 6.2 механика (значения `bi_mode`, цепочки, по которым туда попадают значения,
рандомизатор, который читает блок, адреса 6.2) — [../../docs/BEACONING.md](../../docs/BEACONING.md);
вендорские имена полей `fui_bi_cfg_params_s` —
[../../docs/LMAC-PROTOCOL.md §3.2](../../docs/LMAC-PROTOCOL.md#32-команда-0x0b-fui_bi_cfg_params_s-и-дескрипторы-развёртки-код-пак);
однобайтовый патч гейта — [DISTBCN-PATCH.md](DISTBCN-PATCH.md).

Все выводы — **[код]**, по сырому дизассемблеру (Ghidra-проект 4.1); см. «Замечания» о
декомпиляторе.

## 1. Отправитель: `Send CMD_BCON_MGT` (fw)

`lmac_if__send_bcon_mgt` 0x8d80dc `(r0=mode, r1=bcon_kind, r2=bictrl_lo, r3=bictrl_hi, r4=mac_ptr)` отправляет
ucode-команду **ID 0x0B, длина 0x94**.

```asm
0x8d80e8  mov r18,r0            ; mode
0x8d80ea  mov r15,r1            ; bcon_kind
0x8d8106  add.ne r0,r0,0x7f     ; if (mac_ptr) memcpy(cmd+0x7f, mac_ptr, 6)
0x8d8116  st_s r15,[r14,0x74]   ; cmd+0x74 = bcon_kind
0x8d811e  bl 0x008d80b4         ; (cmd, mode, bictrl_lo, bictrl_hi)
0x8d8148  bl 0x008e0694         ; FUN_008e0694(cmd, 0x0B, 0x94, 0) -> ucode
```

`lmac_if__build_bcon_cfg` 0x8d80b4: `st_s r1,[r0]` ⇒ **`cmd+0x00 = mode`**, затем
`bcn_tx_init_ss_params(cmd, lo, hi)` (0x8c3d2c) и `bcn_tx_init_bi_cfg(cmd, lo, hi)` (0x8c3c98).

### Вызывающие

| вызывающий | mode (cmd+0x00) | bcon_kind (cmd+0x74) | mac_ptr |
|---|---|---|---|
| `tx_bcon__update_bcon` 0x8c2190 (`tx_bcon.cpp`) | `2`, если `vif+0x4c==2` (bss_mode), иначе `0` | **1** (константа `mov_s r1,0x1` @0x8c224a) | 0 |
| `add_discovery_bcon` 0x8c22e4 | `0` | **2**, если scan_type≠3; **3**, если scan_type==3 | при scan_type==3 — 6 Б MAC цели (direct scan) |

## 2. Приёмник: обработчик команды 0x0B в ucode — `ucode_cmd__bi_config` 0x932f8c

Вызывается диспетчером `umac_if_cmd_handler` @0x936dd0 (см.
[../../docs/LMAC-PROTOCOL.md §1.2](../../docs/LMAC-PROTOCOL.md#12-приём-команды-в-ucode-код)).

```asm
0x932f96  mov r13,r0                    ; r13 = тело команды
0x932fa0  bl 0x920310 ; (0x801a9c, cmd+0x04, 0x38)   ; контекст sector sweep, 56 Б
0x932fa6  mov r0,0x801438
0x932fac  add2 r1,r13,0x1d              ; = r13 + 0x74
0x932fb0  bl 0x920310 ; r2=0x20         ; memcpy(0x801438, cmd+0x74, 0x20)
0x932fb6  ldb r0,[r13,0x7d] ; st r0,[r14,0x54]
0x932fc0  ld_s r1,[r13]                 ; r1 = cmd+0x00 = mode
          cmp 0 -> 0x9330ac ; cmp 1 -> 0x9330b4 ; cmp 2 -> иначе 0x933192
```

Два независимых поля команды:

* **`mode` (cmd+0x00)** — трёхпутевой диспетчер обработчика. Ветка 2 (adhoc) вызывает
  пересборщик `bi_cfg__apply` 0x9331d8 (§4) и программирует MAC через кольцо r25
  (см. [MAC-REGISTERS.md](../../docs/MAC-REGISTERS.md)).
* **`bcon_kind` (cmd+0x74)** — первое слово блока, `*(u32*)0x801438`.

## 3. Раскладка блока `0x801438` (32 Б)

Источник — 8-байтовое поле **`bss_bi_ctrl`** по адресу `vif+0x14f` (имя из строки
`[BSS] bss_bi_ctrl_PCP_ready_set %d ! <<<< security_en = %d >>>>`, `FUN_008c4298`) — это
**Beacon Interval Control field** DMG-маяка (802.11ad). `A` = младшие 4 байта
(`vif+0x14f..0x152`), `B` = старшие (`+0x153..0x156`).

| смещ. | из команды | источник (`bcn_tx_init_bi_cfg` 0x8c3c98) | смысл |
|---|---|---|---|
| +0x00 | cmd+0x74 | аргумент `bcon_kind` | **bcon_kind** (вендорское `bi_mode`): 0 = не сконфигурирован, 1 = обычный маяк, 2 = discovery beacon, 3 = discovery при direct scan ([../../docs/BEACONING.md §2.1](../../docs/BEACONING.md#21-cmd_bcon_mgt-lmac-0x0b-обе-код)) |
| +0x04 | cmd+0x78 | `A >> 29` | N BIs A-BFT (младшие биты) |
| +0x05 | cmd+0x79 | `(B >> 6) & 0x3f` | A-BFT Count (6 бит) |
| +0x06 | cmd+0x7a | не пишется | — |
| +0x07 | cmd+0x7b | `(A >> 10) & 0xf` | **FSS**; в ucode — индекс в таблицы 0x802040/0x802058 |
| +0x08 | cmd+0x7c | `0` | обнуляется |
| +0x09 | cmd+0x7d | `(A >> 22) & 0x7f` | TXSS Span (7 бит) |
| +0x0a | cmd+0x7e | `(A >> 7) & 7` | **A-BFT Length** |
| +0x0b..+0x10 | cmd+0x7f | `memcpy(…, mac_ptr, 6)` | MAC цели direct scan (иначе не пишется) |
| +0x14 | cmd+0x88 | b0=`A&1`, b1=`(A>>1)&1`, b2=`0`, b3=`(B>>12)&1` | флаги: **CC Present / Discovery Mode / FragmentedTXSS (=0) / PCP Assoc Ready** |
| +0x18, +0x1c | cmd+0x8c, 0x90 | — | 64-бит якорь TSF; рандомизатор читает и перезаписывает (`ld/st [r13,0x18]`, `[r13,0x1c]`) |

Имена флагов подтверждены лог-строками:
`Send CMD_BCON_MGT: flags.pcp_assoc_ready = %x, discovery_mode = %d` — аргументы ровно
`(cmd+0x88)>>3&1` и `(cmd+0x88)>>1&1`; `bcn_tx_init_bi_cfg(): discovery_mode = %x` —
аргумент `(A>>1)&1`.

### Читатели блока в ucode

| читатель | что читает | назначение |
|---|---|---|
| `bti_worker__bti_transmitter_beacon_sweep_flow` @0x923e0c | `[0]`, `+0x18/+0x1c` | гейт рандомизатора `cmp kind,2`, якорь TSF |
| `bi__decide_beacon_kind` @0x9311f4 | `[0]` | `breq kind,0` — только «сконфигурирован ли» |
| `bi_ap_mon_if__trigger_bhi` (0x930564) @0x930580 | `[0]` | `breq kind,2` → автомату `0x801de8` событие **2** вместо **3** (гейт C окна AW) |
| `bi_cfg__tick_counters` 0x932e9c, `bi_cfg__apply` 0x9331d8 | +4/+5/+7/+9/+0xa, +0x14 | не `[0]` |
| `ucode_cmd__bi_config` 0x932f8c | — | пишет блок (memcpy) |

## 4. Пересборка поля в ucode — `bi_cfg__apply` 0x9331d8

Вызывается из ветки `mode==2` обработчика 0x0B. Из блока и байта `0x80142c+3` собирает два слова
и применяет через `bi_cfg__fill_slot_desc(&0x80142c, &0x801438)` (0x92820c):

```
word0 = CC_Present<<0 | Discovery_Mode<<1 | NextBeacon<<2 | A-BFT_Length<<7
      | FSS<<10 | FragmentedTXSS<<19 | PCP_assoc_ready<<20      -> [gp,0x80]
word1 = TXSS_Span | N_BIs_ABFT<<7 | A-BFT_Count<<17 | flag<<23  -> [gp,0x84]
```

Позиции `word0` совпадают с 802.11ad Beacon Interval Control (B0 CC Present, B1 Discovery Mode,
B2–B5 Next Beacon, B6 ATIM Present, B7–B9 A-BFT Length, B10–B13 FSS, B19 FragmentedTXSS) —
независимое подтверждение раскладки. **Next Beacon** ucode подставляет свой (байт `0x80142f`),
а не хостовый.

## 5. Соседние данные

| адрес | смысл |
|---|---|
| `0x801434` | длительность BI; читают ворота BTI `uc_bi_counter_in_window` 0x932508, 0x9219c8, 0x92ad98 |
| `0x80142c` | смежная структура ucode; байт `+3` — счётчик **Next Beacon** |
| `0x801a9c` (56 Б) | контекст sector sweep, `memcpy` из `cmd+0x04` |

Контекст sector sweep заполняет `bcn_tx_init_ss_params` 0x8c3d2c: `cmd+0x04/+0x08` — маски
секторов hi/lo, `cmd+0x1d/+0x1e` — суммарное число секторов (popcount обеих масок). Выбор
набора масок: discovery → фиксировано **16 секторов**; иначе `PCP_assoc_ready==1` → набор
**IDLE**, иначе **WORK** (строки `bcn_tx_init_ss_params: IDLE/WORK  hi:low %x:%x  total sectors %d`).

## 6. Цепочки, ведущие в блок

Цепочки `bss_mode == 2 → tx_bcon → mode = 2, bcon_kind = 1` и
`активный скан → add_discovery_bcon → bcon_kind = 2`, сброс discovery_mode в `pcp_start` —
[../../docs/BEACONING.md §2.2](../../docs/BEACONING.md#22-кто-ставит-bi_mode-обе-код).

Константа `bcon_kind=1` в `tx_bcon__update_bcon` (`mov_s r1,0x1` @0x8c224a) лежит в общей точке
слияния ветвей bss_mode==2 и обычного AP (используется вариантом B патча,
[DISTBCN-PATCH.md](DISTBCN-PATCH.md)).

## Замечания

* `0x8c02b4`/`0x8c02c0` — не функции, а стабы пролога (милли-код ARC, см.
  [TOOLCHAIN.md](../../docs/TOOLCHAIN.md)):

  ```asm
  0x8c02b4  st.a r18,[sp,-0x4]
  0x8c02b8  st.a r17,[sp,-0x4]
  0x8c02bc  st.a r16,[sp,-0x4]
  0x8c02c0  st.a r15,[sp,-0x4]      ; точка входа = сколько регистров сохранить
  0x8c02c4  st.a r14,[sp,-0x4]
  0x8c02c8  j_s.d blink
  0x8c02ca  _st.a r13,[sp,-0x4]
  ```

  Спил callee-saved регистров (парный эпилог — `0x8c0316`/`0x8c032c`/…); r0–r3 стаб сохраняет.
  Ghidra моделирует стаб как функцию, возвращающую 64 бит в r0:r1, отсюда ложный шаблон
  `uVar2 = FUN_ram_008c02b4(); iVar1 = (int)uVar2; iVar3 = (int)(uVar2 >> 0x20);` (на деле
  `param_1`/`param_2`) — аргументы в декомпиляции «съезжают». Для функций, начинающихся с
  `bl 0x8c02xx`, раскладку аргументов проверять по дизассемблеру.

## Не установлено

* Смещения `word1` и позиции 20/23 для `PCP_assoc_ready` со стандартом 1:1 не совпадают: либо
  `word0/word1` — два разных MAC-регистра, либо раскладка своя.
* Держится ли `bcon_kind=2` после окончания скана: блок перезаписывается следующим `tx_bcon`
  ([../../docs/BEACONING.md](../../docs/BEACONING.md), «Не установлено»).
