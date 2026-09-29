// SPDX-License-Identifier: AGPL-3.0-or-later
/* conn_main_sm__action_8c4898 — READY_FOR_ASSOC × NTF_LINKUP: повторный
 * beamforming уже готового соединения (6.2: 0x8c4898, 44 байта; 4.1:
 * conn_main_sm__bf_ntf).
 *
 * Пишет в журнал и уведомляет l2_mgr о линке.
 *
 * Добавлено в 6.4: безролевой линк включили, когда соединение уже стояло в
 * READY_FOR_ASSOC, — оно становится прямым членом PBSS здесь и сразу идёт в
 * ассоциацию (OWN_ASSOC в READY_FOR_ASSOC допустим, запись таблицы 0x8025ea).
 */
#include "conn.h"
#include "strings-fw.h"

/* "conn_main_sm:: bf_ntf for CID %d with status %d." */
enum { MSG_BF_NTF = 0x01011a60 };
enum { ROLELESS_AT_BF_NTF = 2 };

extern "C" void conn__notify_link_via_l2mgr(struct mid *mid, struct conn *c, u32 status);

extern "C" void conn_main_sm__action_8c4898(struct basic_sm *sm, u32 status)
{
	struct conn *c = sm->parent;

	fw_log_emit2(FWLOG_HDR(FWLOG_MOD_BSS, FWLOG_LVL_INFO), MSG_BF_NTF, c->cid, status);
	conn__notify_link_via_l2mgr(c->mid, c, status);

	if (roleless_adopt(c, status)) {
		fw_log_emit2(FWLOG_HDR(FWLOG_MOD_BSS, FWLOG_LVL_INFO), MSG64_ROLELESS_ADOPT,
		             c->cid, ROLELESS_AT_BF_NTF);
		sm__defer_call(sm, CONN_SM_EVT_OWN_ASSOC, 0, 0, 0);
	}
}
