// SPDX-License-Identifier: AGPL-3.0-or-later
/* conn_main_sm__linkup_ntf — переход WAIT_FOR_LINKUP → READY_FOR_ASSOC по
 * NTF_LINKUP (6.2: 0x8daddc, 104 байта; 4.1: 0x8d7ca0).
 *
 * Вызывается из таблицы переходов conn_main_sm после beamforming.  Сбросить
 * признаки запуска LM, сообщить LMAC, и если соединение создано штатным
 * connect (following_connect) — сразу начать ассоциацию (OWN_ASSOC).
 *
 * Добавлено в 6.4: безролевой линк — соединение, созданное A-BFT без ролей,
 * становится прямым членом PBSS (conn.h: roleless_adopt) и тоже идёт в
 * ассоциацию; та дальше проходит без Assoc-кадров и кончается
 * WMI_PBSS_JOINED и DATA_PORT_OPEN.
 */
#include "conn.h"
#include "strings-fw.h"

/* "conn_main_sm::linkup_ntf() status=%d, CID=%d." */
enum { MSG_LINKUP_NTF = 0x01011a30 };
/* Обработчик u_schd, отложенный на 0x35e0c: уведомление о linkup. */
enum { U_SCHD_LINKUP_CB = 0x35e0c };
enum { ROLELESS_AT_LINKUP = 1 };

extern "C" {
void lmac_if__send_cmd_04_thunk(u32 arg);
void maintain_ctx__set_field_9c(void *lm_if, u32 value);
void u_schd__add(u32 handler, void *arg1, u32 arg2, u32 prio);
}

extern "C" void conn_main_sm__linkup_ntf(struct basic_sm *sm, u32 status)
{
	struct conn *c = sm->parent;

	fw_log_emit2(FWLOG_HDR(FWLOG_MOD_BSS, FWLOG_LVL_INFO), MSG_LINKUP_NTF, status, c->cid);
	sm->lm_started = 0;
	sm->lm_started_pending = 0;
	lmac_if__send_cmd_04_thunk(1);
	maintain_ctx__set_field_9c(c->lm_if, 0);

	if (roleless_adopt(c, status))
		fw_log_emit2(FWLOG_HDR(FWLOG_MOD_BSS, FWLOG_LVL_INFO), MSG64_ROLELESS_ADOPT,
		             c->cid, ROLELESS_AT_LINKUP);

	if (status == 0 && c->following_connect == 1)
		sm__defer_call(sm, CONN_SM_EVT_OWN_ASSOC, 0, 0, 0);

	u_schd__add(U_SCHD_LINKUP_CB, c, status, 1);
}
