// SPDX-License-Identifier: AGPL-3.0-or-later
/* bss_set_active — первый блок, переписанный с ассемблера на C++.
 *
 * Оригинал: 0x008c456c, 32 байта.  Делал ровно две вещи: писал в журнал
 * "bss_set_active (mode %x)" с полем mode и выставлял состояние BSS в 2.
 * Имя и формат строки взяты из таблицы строк прошивки (смещение 0xaf9c),
 * номер подсистемы 11 и уровень 2 — из самого кода.
 */
#include "fw.h"

/* Описание BSS в том виде, в каком его трогает эта функция.  Остальные
 * поля пока неизвестны и добиваются, чтобы смещения не поехали. */
struct bss_ctx {
	u32 unknown_00;
	u32 state;      /* +0x04: 2 — BSS переведён в активное состояние */
	u32 mode;       /* +0x08: режим, он же печатается в журнал */
};

/* смещение 0xaf9c в таблице строк + признаки уровня в старших битах */
enum { MSG_BSS_SET_ACTIVE = 0x0100af9c };

enum { BSS_STATE_ACTIVE = 2 };

extern "C" void bss_set_active(struct bss_ctx *bss)
{
	fw_log__emit1(FWLOG_MOD_BSS, FWLOG_LVL_INFO, MSG_BSS_SET_ACTIVE, bss->mode);
	bss->state = BSS_STATE_ACTIVE;
}
