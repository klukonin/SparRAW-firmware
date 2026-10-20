// SPDX-License-Identifier: AGPL-3.0-or-later
/* tx_bcon::del_bcon — снять маяк с передачи (0x8c7578, 28 байт).
 *
 * Зовут: pcp_stop, scan_mngr::sm_dwelling_ended и обработчик
 * FIND_DEL_DMG_DISCOVERY. Печатает своё имя и mid, после чего отдаёт
 * команду остановки в LMAC. Возвращаемое значение — всегда 0, его
 * вызывающие не смотрят.
 */
#include "fw.h"

struct tx_bcon {
	u8 pad[0x10];
	u8 mid;     /* +0x10: номер MID, он и печатается */
};

/* "tx_bcon::del_bcon() - TX Beacon mid %d -> Stopping", смещение 0x12a10 */
enum { MSG_DEL_BCON = 0x01012a10 };

extern "C" int tx_bcon__del_bcon(void *p)
{
	struct tx_bcon *b = (struct tx_bcon *)p;

	fw_log__emit1(FWLOG_MOD_TX_BCON, FWLOG_LVL_INFO, MSG_DEL_BCON, b->mid);
	lmac_if__stop_beacon();
	return 0;
}
