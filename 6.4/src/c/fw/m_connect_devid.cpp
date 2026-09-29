// SPDX-License-Identifier: AGPL-3.0-or-later
/* m_connect_devid (имя блока ложное; по смыслу ps_connection_mgr__on_disassoc)
 * — соединение отключается (6.2: 0x8c9024, 44 байта).  Зовёт диспетчер
 * событий PS (PS-событие 1, sys_state 7 из conn_main_sm::start_disc).
 *
 * Снимает CID с маски PS-соединений и сообщает PS_CONNECTION.
 * 6.4 apsta: затем выключает UPM станции (upm.cpp).
 */
#include "ps.h"

extern "C" void PS_CONNECTION__disassoc_ntf(void *ps_conn);

extern "C" void m_connect_devid(u32 cid)
{
	u32 bit = 1u << cid;
	if (g_ps_conn_mask & bit) {
		g_ps_conn_mask = g_ps_conn_mask & ~bit;
		PS_CONNECTION__disassoc_ntf(PS_CONNECTION(cid));
	}
	upm__sync();
}
