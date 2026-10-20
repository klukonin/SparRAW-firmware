/* Карта памяти Sparrow (wil6210), 6.2.0.1000.
   ORIGIN/LENGTH — из sparrow_fw_mapping драйвера wil6210;
   *_EXT — свободный хвост области, куда кладётся НАШ код.

   Данные сегментов не кончаются на границе образа:
   * fw_data: статические данные образа идут до 0x80691c (последняя —
     таблица инициализации PHY 0x8067dc, 320 байт), выше — стек fw
     (`mov sp,0x807ffc` в стартовом коде 0x8c0178). Свободного хвоста
     у fw_data нет.
   * uc_data (адреса ucode 0x800000 = host 0x940000): образ до 0x801be8,
     BSS до 0x803648 (последнее — кольцо лога: заголовок 0x803234,
     буфер 0x803248..0x803648), стек ucode 0x803648..0x803a48
     (`mov sp,0x803a48` в 0x9201b8). За вершиной стека до конца окна
     0x804000 обращений нет ни в коде, ни в указателях данных; на стенде
     (AP и STA с линком) область хранит нетронутый мусор включения SRAM. */
MEMORY
{
  /* fw_code занято 247140 из 262144 */
  fw_code     : ORIGIN = 0x008c0000, LENGTH = 0x3c564
  fw_code_ext : ORIGIN = 0x008fc564, LENGTH = 0x3a9c
  /* fw_data занято  26908 из  32768, остаток 0x90691c..0x908000 — стек */
  fw_data     : ORIGIN = 0x00900000, LENGTH = 0x691c
  fw_stack    : ORIGIN = 0x0090691c, LENGTH = 0x16e4
  /* uc_code занято 126148 из 131072 */
  uc_code     : ORIGIN = 0x00920000, LENGTH = 0x1ecc4
  uc_code_ext : ORIGIN = 0x0093ecc4, LENGTH = 0x133c
  /* uc_data: образ 7144 байт, BSS и кольцо лога, стек ucode */
  uc_data     : ORIGIN = 0x00940000, LENGTH = 0x1be8
  uc_bss      : ORIGIN = 0x00941be8, LENGTH = 0x1a60
  uc_stack    : ORIGIN = 0x00943648, LENGTH = 0x400
  /* ucode 0x803a48..0x804000, 1464 байта */
  uc_data_ext : ORIGIN = 0x00943a48, LENGTH = 0x5b8
}

/* Новый код по умолчанию — в свободный хвост fw_code. Его данные лежат
   там же: память кода fw — ОЗУ, а в fw_data места нет (так же размещает
   данные сборка блоков на C, ld/image-fw.ld). */
SECTIONS
{
  /* KEEP обязателен: у блоба нет точки входа, и --gc-sections иначе
     выбрасывает весь наш код ("input file has no sections"). */
  .text.ext : { KEEP(*(.text.ext)) KEEP(*(.text.ext.*)) KEEP(*(.text)) KEEP(*(.text.*)) } > fw_code_ext
  .rodata.ext : { KEEP(*(.rodata)) KEEP(*(.rodata.*)) } > fw_code_ext
  /* .bss — внутри загружаемой секции: нули попадают в образ, иначе
     переменные остались бы с содержимым ОЗУ после включения */
  .data.ext : { KEEP(*(.data)) KEEP(*(.data.*)) *(.bss) *(.bss.*) *(COMMON) } > fw_code_ext
  /DISCARD/ : { *(.comment) *(.note*) *(.ARC.attributes) }
}
