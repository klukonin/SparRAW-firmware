// SPDX-License-Identifier: AGPL-3.0-or-later
/* Слот 01 зазора (6.4) не занят, а слоты должны стоять на своих адресах (на
 * них ведут записи таблицы переходов диспетчера WMI; слот 02 — WMI 0x85b) —
 * здесь 16 байт заглушки.  Сюда никто не переходит. */
#include "fw.h"

extern "C" FW_GAP_SLOT("01") void gap_slot01_reserved(void)
{
	__asm__ volatile(
		"1: b 1b\n\t"
		".skip 16 - (. - 1b)");
}
