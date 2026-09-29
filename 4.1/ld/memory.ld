/* Карта памяти Sparrow (wil6210), 4.1.0.1000.
   ORIGIN/LENGTH — из sparrow_fw_mapping драйвера wil6210;
   *_EXT — свободный хвост области, куда кладётся НАШ код. */
MEMORY
{
  /* fw_code занято 211800 из 262144 */
  fw_code     : ORIGIN = 0x008c0000, LENGTH = 0x33b58
  fw_code_ext : ORIGIN = 0x008f3b58, LENGTH = 0xc4a8
  /* fw_data занято  26748 из  32768, остаток 0x90687c..0x908000 — стек fw
     (`mov sp,0x807ffc` в стартовом коде 0x8c0258); свободного хвоста нет */
  fw_data     : ORIGIN = 0x00900000, LENGTH = 0x687c
  fw_stack    : ORIGIN = 0x0090687c, LENGTH = 0x1784
  /* uc_code занято  98500 из 131072 */
  uc_code     : ORIGIN = 0x00920000, LENGTH = 0x180c4
  uc_code_ext : ORIGIN = 0x009380c4, LENGTH = 0x7f3c
  /* uc_data занято   3828 из  16384 */
  uc_data     : ORIGIN = 0x00940000, LENGTH = 0xef4
  /* ВНИМАНИЕ. Прежнее ORIGIN = 0x00940ef4, LENGTH = 0x310c в адресах ucode
     это 0x800ef4..0x804000 — ПОВЕРХ живых структур: bcon_kind/bi_cfg
     @0x801438, объект автомата @0x801de8, счётчики @0x801e14, кольцо
     журнала @0x8020b0. Любая переменная, положенная туда, затрёт их при
     загрузке образа. Область обнулена намеренно: пока не доказано, где у
     данных ucode настоящий свободный хвост, класть туда нечего. */
  uc_data_ext : ORIGIN = 0x00940ef4, LENGTH = 0x0
}

/* Новый код по умолчанию — в свободный хвост fw_code. Его данные лежат
   там же: память кода fw — ОЗУ, а в fw_data места нет. */
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
