// SPDX-License-Identifier: AGPL-3.0-or-later
/* bss_set_active — перевести BSS в активное состояние (6.2: 0x8c4ec8, 28 байт).
 *
 * Зовут из l2_mgr__connect и l2_mgr__pcp_start_flow: записать в журнал
 * режим BSS и выставить состояние «активен».  Тот же код, что в 4.1.
 */
#include "fw.h"

/* "bss_set_active (mode %x)" */
enum { MSG_BSS_SET_ACTIVE = 0x0100c420 };

extern "C" void bss_set_active(struct bss *bss)
{
	fw_log_emit1(FWLOG_HDR(FWLOG_MOD_BSS, FWLOG_LVL_INFO), MSG_BSS_SET_ACTIVE, bss->mode);
	bss->state = BSS_STATE_ACTIVE;
}
