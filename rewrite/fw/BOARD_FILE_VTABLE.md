# Board-file interface (marlon_r_if_class) — vtable и методы

## Объект
- `marlon_r_if_class` объект: **0x8042c8** (BSS, zero-init).
- Под-объект `brd_if_multi_array`: **0x8042cc** (this+4).
- vtable-слот: **0x804310** (0x8042cc+0x44) — ставит C++-конструктор.

## vtable (подтверждено чтением vendor FW на стенде)
- **0x804310 = 0x8005e4** (адрес vtable-структуры в .data).

## Структура vtable @ 0x8005e4 (смещения от 0x8c0000)
| индекс | смещение | адрес | метод |
|---|---|---|---|
| [0] | 0x000000 | — | деструктор (0) |
| [1] | 0x00bbec | 0x8cbbec | read/get_section_info (вызывается в init_board_file_interface) |
| [2] | 0x00cb84 | 0x8ccb84 | brd_if_multi_array__get_section_info_8ccb84 |
| [3] | 0x00b978 | 0x8cb978 | (внутри get_block_info) |
| [4] | 0x00bc48 | 0x8cbc48 | (следующая за методом[1]) |
| [5] | 0x00b800 | 0x8cb800 | (внутри) |

## Boot-цепочка, которая это вызывает
1. `marlon_r_if_class_init_board_file_interface` (rf.c:499) → vt[1](obj,0,cfg)  [ЗАВИСАНИЕ шаг 331]
2. `marlon_r_if_class_load_brd_parameters_section` (rf.c:760) → vt[2](obj,0,info)
3. `brd_if_build_tx_sector_list` (rf.c:624)
4. `rf_if_num_tx_sectors` (rf.c:612)

## Подсистема board-file (блоки blocks.json, 0x8c5410–0x8d8fe4)
- brd_if__chunk_offset 0x8c5410, brd_if_multi_array 0x8c630c,
  brd_if__clear_block_info 0x8c6790, brd_if__scan_sections 0x8c6afc,
  marlon_r_if__read_step 0x8c6ccc, marlon_r_if_class__config_channel 0x8c6d00,
  brd_if__parse_chunk_header 0x8c7444,
  brd_if_multi_array__get_chunk 0x8ca760, find_section 0x8caab8,
  get_block_info 0x8cb940, get_board_file_format_version 0x8cbafc,
  get_chunk_8cbbc4 0x8cbbc4, get_chunk_in_address_data_pairs_format 0x8cbcd8,
  get_chunk_in_data_only_format 0x8cbd80, get_section_info 0x8ccb7c,
  get_section_info_8ccb84 0x8ccb84, init 0x8d8fe4.

## Диагностика (работает)
- vendor FW даёт `FW ready`; читаем память через
  `/sys/kernel/debug/ieee80211/phy0/wil6210/blob_fw_data` (ARC 0x800000+offset).
- Трасса boot: `*(volatile u32*)0x800100 = шаг` (читать offset 0x100).
