// SPDX-License-Identifier: AGPL-3.0-or-later
/* conn_mgr__start_all_detector_services — после события ucode 0x16 (смена
 * масок бодрствующих и спящих соседей) снова запустить детекторы потери связи
 * всех ассоциированных соединений (6.2: 0x8c40f8, 40 байт).
 *
 * Зовёт только обработчик события PS 2 (ps_assoc_mgr__shallow_sleep_enter
 * 0x8e1404).  6.4 apsta: заодно пересобрать маяк, если изменилась маска
 * спящих станций — UPSIM должен быть верен в каждом DMG Beacon (11.2.7.2.2).
 */
#include "fw.h"
#include "ps.h"

enum {
	MAX_CID = 8,
	MLME_SM_ASSOCIATED = 2,     /* mlme_sm: UNASSOCIATE, ASSOCIATE, ASSOCIATED */
	CONN_MLME_SM_STATE = 0xf0,
};

extern "C" {
u8  *conn_mgr__by_cid(u32 cid);
void conn__start_detector_services(u8 *conn, u32 start);
}

extern "C" void conn_mgr__start_all_detector_services(void)
{
	for (u32 cid = 0; cid < MAX_CID; cid++) {
		u8 *conn = conn_mgr__by_cid(cid);
		if (conn && conn[CONN_MLME_SM_STATE] == MLME_SM_ASSOCIATED)
			conn__start_detector_services(conn, 1);
	}
	ps_upsim__refresh_bcon();
}
