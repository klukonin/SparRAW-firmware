// SPDX-License-Identifier: AGPL-3.0-or-later
/* ps__release_awake_for_sta — станция больше не держит связь с точкой
 * (ucode 6.2: 0x93d980, 80 байт).  Зовёт ucode_cmd_0x0f_handler (LMAC 0x0f
 * disable, после отправки Disassociation).
 *
 * Снимает голос ресурса и ожидание внутренней передачи PS (номер 6),
 * сбрасывает +0x174 и два байта записи точки в общем блоке 0x857e38.
 * 6.4 apsta: если станция при этом в UPM-doze, выводит её из doze (в 6.2
 * флаг оставался до следующей связи, и новая начиналась «во сне»).
 */
#include "uc_ps.h"

enum { PS_RES_ID = 6 };

/* Запись станции в общем блоке с прошивкой (0x857e38 + 0x14·cid); байты
 * +0x12 и +0x13 — смысл не установлен. */
#define g_sta_shared ((volatile u8 *)0x00857e38)
enum { STA_SHARED_SIZE = 0x14 };

/* Станции с поддержанием связи (LMAC 0x0f), бит на CID. */
#define g_maintained_sta_mask UC_GLOBAL(u8, 0x00802194)

extern "C" {
void internal_tx__clear_pending_bit(u32 id);
void uc_res_vote__release(u32 id);
void tx_ctx__clear_flag_179(volatile struct pm_ctx *ctx);
}

extern "C" void ps__release_awake_for_sta(volatile struct pm_ctx *ctx)
{
	internal_tx__clear_pending_bit(PS_RES_ID);
	uc_res_vote__release(PS_RES_ID);
	((volatile u8 *)ctx)[0x174] = 0;

	u32 m = g_maintained_sta_mask;
	if (m) {
		u32 cid = 31 - __builtin_clz(m);        /* старший CID, как norm у вендора */
		volatile u8 *rec = g_sta_shared + STA_SHARED_SIZE * cid;
		rec[0x12] = 0;
		rec[0x13] = 0;
	}
	if (ctx->in_doze)
		tx_ctx__clear_flag_179(ctx);
}
