// SPDX-License-Identifier: AGPL-3.0-or-later
/* pcp_stop — остановка PCP (0x8ef014, 32 байта).
 *
 * Зовут из обработчика WMI «PCP Stop». Вся работа — записать в журнал и
 * снять маяк с передачи; объект маяка лежит в поле +0x04.
 */
#include "fw.h"

struct pcp_ctx {
	u32 unknown_00;
	void *bcon;   /* +0x04: то, что уходит в tx_bcon::del_bcon */
};

/* "pcp_stop()", смещение 0x125f0 */
enum { MSG_PCP_STOP = 0x010125f0 };

extern "C" void pcp_stop(struct pcp_ctx *p)
{
	fw_log__emit0(FWLOG_MOD_TX_BCON, FWLOG_LVL_INFO, MSG_PCP_STOP);
	tx_bcon__del_bcon(p->bcon);
}
