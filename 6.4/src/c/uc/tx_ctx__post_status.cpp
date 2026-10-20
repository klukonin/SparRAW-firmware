// SPDX-License-Identifier: AGPL-3.0-or-later
/* tx_ctx__post_status — событие ucode 0x16 (PS: бодрствующие и спящие
 * соседи) для прошивки (ucode 6.2: 0x92845c, 196 байт).
 *
 * Зовут internal_tx__flow_sm6 (вход/выход UPM-doze), rx_funcs__rx_flow
 * (смена бита PM у станции на AP), tx_ctx__clear_flag_179.  Прошивка по
 * маскам тела гасит кольца данных: разрешены CID из awake & ~upm.
 *
 * 6.4 apsta (11.2.7.2.2): у станции поле upm было флагом «сама сплю» (0/1),
 * а прошивка читает его как маску CID — верно выходило, только если CID
 * точки равен 0.  Спящая станция не передаёт данных никому (у неё все CID
 * ведут к точке), поэтому маска — все CID.
 */
#include "uc_ps.h"

/* Тело события 0x16. */
struct ps_evt_body {
	u8 arg;                 /* +0 */
	u8 doze_bi;             /* +1: идёт BI сна по графику PSC */
	u8 awake;               /* +2: CID бодрствующих (0xff — PS в BSS не работает) */
	u8 no_tx;               /* +3 */
	u8 upm;                 /* +4: CID спящих по UPM */
};

enum {
	PS_EVT_CLEAR_PEER = 1,  /* тип: убрать CID текущей передачи из масок */
	ALL_CIDS          = 0xff,
};

/* Текущий TX-контекст; слово +0 — CID (docs/DATAPATH.md §8). */
typedef u32 *tx_ctx_ptr;
#define g_cur_tx_ctx UC_GLOBAL(tx_ctx_ptr, 0x008029f0)

extern "C" void uc_send_evt__ps_awake_peer(volatile void *body);

extern "C" void tx_ctx__post_status(volatile struct pm_ctx *ctx, u32 arg, u32 type)
{
	volatile struct ps_evt_body *b = (volatile struct ps_evt_body *)ctx->evt_body;

	if (!ctx->ps_active) {
		b->awake = ALL_CIDS;
		b->no_tx = 0;
	} else {
		u32 awake = ctx->awake_peers[1] | ctx->awake_peers[0];
		b->awake = awake;
		if (g_uc_role_pcp == 1) {
			b->upm = ctx->upm_vector;
			if (type == PS_EVT_CLEAR_PEER)
				b->awake = awake & ~(1u << *g_cur_tx_ctx);
			/* в 6.2 здесь маскировался и no_tx, но значение тут же
			 * перезаписывалось — поведение сохранено */
		} else {
			b->upm = ctx->in_doze ? ALL_CIDS : 0;
		}
		b->no_tx = ctx->no_tx_peers;
	}
	b->arg = arg;
	b->doze_bi = ctx->psc_state == PSC_STATE_DOZE_BI;
	ctx->evt_type = type;
	uc_send_evt__ps_awake_peer(b);
}
