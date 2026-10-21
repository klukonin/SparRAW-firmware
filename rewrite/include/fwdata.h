/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Объект начального образа DCCM fw по фиксированному адресу: секция .fwdata.<адрес>
 * (Makefile ставит её по адресу, tools/build_fw.py собирает образ). Адрес — шестнадцатеричный
 * без 0x. Вне fw/fw_data.c так определяются типизированные объекты (таблицы методов и т.п.);
 * их диапазон помечен в fw/dccm_names.txt как ext[N], чтобы генератор его не трогал. */
#ifndef FWDATA_H
#define FWDATA_H
#define FWDATA(addr) __attribute__((section(".fwdata." #addr), used))
/* Границы DCCM fw (0x800000..0x807fff) и вершина стека — символы fw/fw.ld. */
extern unsigned char __dccm_start[];
/* Последнее слово DCCM — вершина стека vendor (mov sp,0x807ffc); константой, а не через
 * __stack_top: с символом gcc держит её в лишнем регистре, и sysassert__dump_stack, читающий
 * стек от своего sp, сдвигается на слово пролога. */
#define FW_DCCM_LAST_WORD 0x807ffcu
#endif
