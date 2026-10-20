/* Обычная сборка сегмента uc_code.  Сгенерировано gen_layout.py --plain. */
SECTIONS
{
  .text 0x00920000 : {
    KEEP(*(.text.uc_code))
    *(.text .text.*)
    . = ALIGN(4);
    *(EXCLUDE_FILE(*uc_data.o) .rodata EXCLUDE_FILE(*uc_data.o) .rodata.*) *(.data .data.*) *(.bss .bss.* COMMON)
    . = ALIGN(4);
    __uc_code_end = .;
  }
  ASSERT(. <= 0x00940000, "код сегмента не влезает в область")
  .rodata.uc_data 0x00800000 : { KEEP(*(.rodata.uc_data)) }
  /DISCARD/ : { *(.comment) *(.note*) *(.ARC.attributes) }
}
