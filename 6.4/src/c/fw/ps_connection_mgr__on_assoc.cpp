// SPDX-License-Identifier: AGPL-3.0-or-later
/* ps_connection_mgr__on_assoc — порт данных соединения открыт (6.2: 0x8c3d50,
 * 96 байт).  Зовёт диспетчер событий PS (PS-событие 0, sys_state 6).
 *
 * Ставит CID в маску PS-соединений и сообщает объекту PS_CONNECTION, разрешён
 * ли соседу PS (только на AP/PCP и при разрешающем профиле).
 * 6.4 apsta: затем синхронизирует UPM станции с профилем хоста (upm.cpp).
 * 6.4 mesh: у члена DMG IBSS энергосбережение соседа запрещено всегда —
 * ATIM и буферизация для спящих членов ячейки (11.2.4) не реализованы.
 */
#include "ps.h"
#ifdef FW64_MESH
#include "ibss.h"
#endif

extern "C" {
u8  *conn_mgr__by_cid(u32 cid);
void PS_CONNECTION__assoc_ntf(void *ps_conn, u8 *conn, u32 ps_allowed);
}

enum { CONN_MID = 0x18, ASSERT_NO_CONN = 0x1428 };

extern "C" void ps_connection_mgr__on_assoc(u32 cid)
{
	u8 *conn = conn_mgr__by_cid(cid);
	if (!conn)
		fw_sysassert_fatal(__builtin_return_address(0), ASSERT_NO_CONN);

	u8 *mid = *(u8 **)(conn + CONN_MID);
	u32 mode = ((struct bss *)(mid + 0x48))->mode;
	u32 ps_allowed = (mode == BSS_MODE_PBSS || mode == BSS_MODE_AP) && g_ps_enabled;
#ifdef FW64_MESH
	if (g_ibss)
		ps_allowed = 0;
#endif

	g_ps_conn_mask = g_ps_conn_mask | (1u << cid);
	PS_CONNECTION__assoc_ntf(PS_CONNECTION(cid), conn, ps_allowed);
#ifdef FW64_APSTA
	upm__sync();
#endif
}
