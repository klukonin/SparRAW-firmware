// SPDX-License-Identifier: AGPL-3.0-or-later
/* Слот 01 зазора в прошивке apsta (6.4).  В mesh слот 01 — ветка WMI 0x85a
 * (IBSS_BSSID, new/wmi_ibss_bssid.cpp); в apsta её нет, а слоты должны стоять
 * на своих адресах во всех вариантах (на них ведут записи таблицы переходов
 * диспетчера WMI) — здесь 16 байт заглушки.  Сюда никто не переходит. */
#include "fw.h"

extern "C" FW_GAP_SLOT("01") void gap_slot01_reserved(void)
{
	__asm__ volatile(
		"1: b 1b\n\t"
		".skip 16 - (. - 1b)");
}
