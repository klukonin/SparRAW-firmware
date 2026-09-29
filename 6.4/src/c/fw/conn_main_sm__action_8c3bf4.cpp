// SPDX-License-Identifier: AGPL-3.0-or-later
/* conn_main_sm__action_8c3bf4 — READY_FOR_ASSOC × OWN_ASSOC: начать
 * ассоциацию по уже отбеамформленному соединению (6.2: 0x8c3bf4, 108 байт;
 * 4.1: send_assoc_resp_pbss).
 *
 * Прямому члену PBSS — событие ASSOC_RESPONSE в MLME (ассоциация без обмена
 * кадрами), иначе ASSOC_REQUEST.
 *
 * Исправление 6.4: 6.2 допускала этот путь только при режиме интерфейса
 * «станция» (m_bss_mode == 1), иначе фатальная ошибка 0x11c5.  Прямой член
 * PBSS безролевого линка идёт сюда и у PCP/AP (режим 2/3) — менять
 * m_bss_mode нельзя: при 1 не работает останов PCP, а BF уходит в вечные
 * повторы.
 */
#include "conn.h"

/* "Sending mlme_sm::ASSOC_RESPONSE for direct STA PBSS member" */
enum { MSG_DIRECT_PBSS_ASSOC = 0x01011a94 };
enum { ASSERT_NOT_STA = 0x11c5, ASSERT_NO_FOLLOWING_CONNECT = 0x11c6 };

extern "C" void conn_main_sm__action_8c3bf4(struct basic_sm *sm)
{
	struct conn *c = sm->parent;

	if (mid_bss_mode(c->mid) != BSS_MODE_STA && !(roleless_enabled() && c->direct_pbss))
		fw_sysassert_fatal(__builtin_return_address(0), ASSERT_NOT_STA);
	if (!c->following_connect)
		fw_sysassert_fatal(__builtin_return_address(0), ASSERT_NO_FOLLOWING_CONNECT);

	u32 evt = MLME_EVT_ASSOC_REQUEST;
	if (c->direct_pbss) {
		fw_log_emit0(FWLOG_HDR(FWLOG_MOD_BSS, FWLOG_LVL_INFO), MSG_DIRECT_PBSS_ASSOC);
		evt = MLME_EVT_ASSOC_RESPONSE;
	}
	basic_sm__handle_event(c->mlme_sm, evt, 0, 0, 0);
}
