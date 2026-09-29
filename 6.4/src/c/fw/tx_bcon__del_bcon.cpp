// SPDX-License-Identifier: AGPL-3.0-or-later
/* tx_bcon::del_bcon — снять маяк с передачи (6.2: 28 байт).
 *
 * Зовут из pcp_stop, find_mngr__del_discovery_bcon и
 * scan_mngr__sm_dwelling_ended.  Записать в журнал номер MID и отправить в
 * LMAC команду удаления маяка.  Тот же код, что в 4.1.
 */
#include "fw.h"

struct tx_bcon {
	u8 reserved[0x10];
	u8 mid;         /* +0x10: номер MID, печатается в журнал */
};

/* "tx_bcon::del_bcon() - TX Beacon mid %d -> Stopping" */
enum { MSG_DEL_BCON = 0x01017208 };

extern "C" int tx_bcon__del_bcon(void *obj)
{
	struct tx_bcon *bcon = (struct tx_bcon *)obj;

	fw_log_emit1(FWLOG_HDR(FWLOG_MOD_TX_BCON, FWLOG_LVL_INFO), MSG_DEL_BCON, bcon->mid);
	lmac_if__send_bcon_del_0b();
	return 0;
}
