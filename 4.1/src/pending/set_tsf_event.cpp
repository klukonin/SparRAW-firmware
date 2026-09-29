// SPDX-License-Identifier: AGPL-3.0-or-later
/* set_tsf_event — взвод аппаратного сравнивателя TSF (ucode, 0x930c28).
 *
 * Вызывается из bti_worker::bti_transmitter_beacon_sweep_flow, когда тот
 * рассчитал момент следующего маяка.  Делает ровно три вещи: пишет в
 * журнал, толкает в кольцо команд MAC слово 0x02000040 и заряжает
 * сравниватель на переданное 64-битное значение TSF.
 *
 * Именно этот сравниватель — точка, в которой живёт распределённый
 * биконинг: событие от него и должно задерживать выход маяка.
 */
#include "uc.h"

struct tsf64 {
	u32 lo;
	u32 hi;
};

enum {
	UCLOG_MOD_SYSTEM = 0,  /* байт уровней по 0x008020a0 + 0 */
	UCLOG_LVL_INFO  = 2,
	MSG_SET_TSF_EVENT = 0xa2000d8c,  /* строка 0xd8c, уровень и модуль в старших битах */
	MAC_CMD_TSF_ARM   = 0x02000040,
};

extern "C" void set_tsf_event(const struct tsf64 *when)
{
	if (uclog_enabled(UCLOG_MOD_SYSTEM, UCLOG_LVL_INFO))
		uclog(MSG_SET_TSF_EVENT);

	mac_cmd(MAC_CMD_TSF_ARM);

	TSF_CMP_LO = when->lo;
	TSF_CMP_HI = when->hi;
	TSF_CMP_CTL = TSF_CMP_ARM;
}
