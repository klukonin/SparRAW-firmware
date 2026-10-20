// SPDX-License-Identifier: AGPL-3.0-or-later
/* set_tsf_event — взвести аппаратный сравниватель TSF (ucode 6.2).
 *
 * Зовут из bti_worker__bti_transmitter_beacon_sweep_flow.  Записать в
 * журнал, отправить команду MAC 0x40 и загрузить в сравниватель момент
 * срабатывания.  Тот же код, что в 4.1 (другой только вызов журнала).
 */
#include "uc.h"

struct tsf64 {
	u32 lo;
	u32 hi;
};

enum {
	MSG_SET_TSF_EVENT = 0x01000f80,  /* "set_tsf_event()" */
	MAC_CMD_TSF_ARM   = 0x02000040,  /* команда MAC 0x40 с битом 25 */
};

extern "C" void set_tsf_event(const struct tsf64 *when)
{
	uc_log__emit_snapshot(UCLOG_HDR(UCLOG_MOD_SYSTEM, UCLOG_LVL_INFO), MSG_SET_TSF_EVENT);

	mac_cmd(MAC_CMD_TSF_ARM);

	TSF_CMP_LO = when->lo;
	TSF_CMP_HI = when->hi;
	TSF_CMP_CTL = TSF_CMP_ARM;
}
