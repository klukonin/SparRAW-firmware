// SPDX-License-Identifier: AGPL-3.0-or-later
/* set_tsf_event — измерительный вариант: тот же взвод компаратора TSF плюс
 * запись в журнал того, что происходит с регистром событий r42.
 *
 * Зачем: развёртка маяка взводит аппаратный компаратор (0x886d30/34/38) и
 * тут же идёт передавать маяк, не дожидаясь события. Чтобы заставить её
 * ждать, нужно знать, КАКОЙ бит r42 взводит компаратор. Известные биты
 * событий: 4, 7, 9, 12, 14, 16, 18, 19; первый
 * кандидат — 9, потому что uc_sleep_until_event добавляет его к маске
 * всегда.
 *
 * Поведение по отношению к прошивке не меняется: взвод тот же, добавлены
 * только записи в кольцо журнала и ограниченный опрос. Ждать здесь пока
 * НЕЛЬЗЯ — если ошибиться битом, развёртка встанет намертво.
 */
#include "uc.h"

struct tsf64 {
	u32 lo;
	u32 hi;
};

enum {
	UCLOG_MOD_SYSTEM = 0,
	UCLOG_LVL_INFO   = 2,
	MSG_SET_TSF_EVENT = 0xa2000d8c,  /* "set_tsf_event()" */
	MSG_MASK          = 0xa600188c,  /* "[NNL] non_idle_mask: 0x%x", один аргумент */
	MAC_CMD_TSF_ARM   = 0x02000040,
	SPIN_LIMIT        = 256,         /* опрос ограничен: развёртка не должна встать */
};

extern "C" void set_tsf_event(const struct tsf64 *when)
{
	bool log = uclog_enabled(UCLOG_MOD_SYSTEM, UCLOG_LVL_INFO);

	if (log)
		uclog(MSG_SET_TSF_EVENT);

	mac_cmd(MAC_CMD_TSF_ARM);

	TSF_CMP_LO = when->lo;
	TSF_CMP_HI = when->hi;
	TSF_CMP_CTL = TSF_CMP_ARM;

	if (!log)
		return;

	/* что было сразу после взвода и что изменилось за ограниченный опрос */
	u32 before = uc_events();
	uclog1(MSG_MASK, before);

	u32 seen = 0;
	for (int i = 0; i < SPIN_LIMIT; i++) {
		u32 now = uc_events();
		seen |= now ^ before;
		if (seen)
			break;
	}
	uclog1(MSG_MASK, seen);
}
