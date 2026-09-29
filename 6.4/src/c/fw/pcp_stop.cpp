// SPDX-License-Identifier: AGPL-3.0-or-later
/* pcp_stop — остановка PCP (6.2: 0x8f720c, 28 байт).
 *
 * Зовут из pcp_stop__flow. Записать в журнал и снять маяк с передачи;
 * объект маяка лежит в поле +0x04.  Тот же код, что в 4.1.
 * Прошивка mesh: заодно снять флаг DMG IBSS.
 */
#include "fw.h"
#ifdef FW64_MESH
#include "ibss.h"
#endif

struct pcp_ctx {
	u32 unknown_00;
	void *bcon;   /* +0x04: то, что уходит в tx_bcon::del_bcon */
};

/* "pcp_stop()" */
enum { MSG_PCP_STOP = 0x01016dcc };

extern "C" void pcp_stop(struct pcp_ctx *p)
{
	fw_log_emit0(FWLOG_HDR(FWLOG_MOD_TX_BCON, FWLOG_LVL_INFO), MSG_PCP_STOP);
	tx_bcon__del_bcon(p->bcon);
#ifdef FW64_MESH
	g_ibss = 0;     /* ячейка IBSS остановлена (mesh) */
#endif
}
