/* Обычная сборка сегмента fw_code.  Сгенерировано gen_layout.py --plain. */
SECTIONS
{
  .text 0x008c0000 : {
    KEEP(*(.text.fw_code))
    __gap_8edd18_start = ASSERT(ABSOLUTE(.) == 0x8edd18, "fw_vector_19__unused_zero_fill: код перед ним сдвинулся");
    KEEP(*(SORT(.text.gap.head.*)))
    __slot_wmi_branch_0x859 = ASSERT((DEFINED(wmi_branch_0x859) ? ABSOLUTE(wmi_branch_0x859) : 0x008edd18) == 0x008edd18, "wmi_branch_0x859 не на своём адресе 0x008edd18: таблица переходов ведёт мимо");
    __slot_wmi_branch_0x85a = ASSERT((DEFINED(wmi_branch_0x85a) ? ABSOLUTE(wmi_branch_0x85a) : 0x008edd28) == 0x008edd28, "wmi_branch_0x85a не на своём адресе 0x008edd28: таблица переходов ведёт мимо");
    __slot_wmi_branch_0x85b = ASSERT((DEFINED(wmi_branch_0x85b) ? ABSOLUTE(wmi_branch_0x85b) : 0x008edd38) == 0x008edd38, "wmi_branch_0x85b не на своём адресе 0x008edd38: таблица переходов ведёт мимо");
    *(.text.gap .text.gap.*)
    __gap_8edd18_used = ASSERT(ABSOLUTE(.) <= 0x8f0000, "fw_vector_19__unused_zero_fill: код на C не влезает");
    . = 0x8f0000 - 0x008c0000;
    KEEP(*(.text.fw_code_p1))
    *(.text .text.*)
    . = ALIGN(4);
    *(EXCLUDE_FILE(*fw_data.o) .rodata EXCLUDE_FILE(*fw_data.o) .rodata.*) *(.data .data.*) *(.bss .bss.* COMMON)
    . = ALIGN(4);
    __fw_code_end = .;
  }
  ASSERT(. <= 0x00900000, "код сегмента не влезает в область")
  .rodata.fw_data 0x00800000 : { KEEP(*(.rodata.fw_data)) }
  /DISCARD/ : { *(.comment) *(.note*) *(.ARC.attributes) }
}
