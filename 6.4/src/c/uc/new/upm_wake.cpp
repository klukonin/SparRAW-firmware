// SPDX-License-Identifier: AGPL-3.0-or-later
/* Выход станции из UPM-doze (6.4, прошивка apsta; 802.11-2020 11.2.7.2.2,
 * 11.2.7.4).
 *
 * В 6.2 станция выходила из doze только сама по хосту: ни принятый ATIM, ни
 * свои исходящие данные её не будили — нисходящие кадры точка держит, пока
 * станция спит, а восходящие стояли в кольцах.  Теперь:
 *  - путь приёма ATIM (rx_get_required_response, rx_flow__handle_frame)
 *    отмечает приём флагом (upm__on_atim_rx вместо peer_masks__apply_op,
 *    патч 0007);
 *  - в начале DTI (bi__dti_step), то есть после AW — в AW по 11.2.7.4 можно
 *    передавать только ATIM, — станция в doze выходит обменом с PM = 0,
 *    если был ATIM или у неё есть данные к точке;
 *  - точка шлёт ATIM спящим станциям, к которым есть кадры
 *    (upm__collect_awake_peers, патч 0012).
 */
#include "uc_ps.h"
#include "fw_uc_shared.h"

#define g_upm_atim_rx UC_GLOBAL(u32, UC_EXT_DATA_UC(UPM_ATIM_RX_OFS))

/* Кольца TX с непрочитанными дескрипторами (DMA), кольцо широковещания,
 * кольцо → CID, CID с кадрами fw, CID точки с поддержанием связи. */
#define DMA_RINGS_WITH_DATA  (*(volatile u32 *)0x00881c84)
#define g_bcast_ring         UC_GLOBAL(u8, 0x00800468)
/* таблица очередей 0x802228: по 3 байта {b6, b5, cid} (sta__get_sweep_byte) */
#define g_ring_to_cid(r)     UC_GLOBAL(u8, 0x0080222a + 3 * (r))
#define g_fw_mac_queue       UC_GLOBAL(u32, 0x00857050)
#define g_maintained_sta_mask UC_GLOBAL(u8, 0x00802194)

enum { PEER_OP_ATIM_RX = 3 };

extern "C" u32 peer_masks__apply_op(volatile struct pm_ctx *ctx, u32 op, u32 mask);

extern "C" u32 upm__on_atim_rx(volatile struct pm_ctx *ctx, u32 op, u32 mask)
{
	if (op == PEER_OP_ATIM_RX && g_uc_role_pcp != 1)
		g_upm_atim_rx = 1;
	return peer_masks__apply_op(ctx, op, mask);
}

/* CID, к которым есть кадры: кольца TX с дескрипторами (кроме кольца
 * широковещания) и кадры fw. */
static u32 upm__cids_with_data(void)
{
	u32 rings = DMA_RINGS_WITH_DATA;
	u32 bc = g_bcast_ring;
	if (bc < 32)
		rings &= ~(1u << bc);
	u32 cids = g_fw_mac_queue & 0xff;
	for (; rings; rings &= rings - 1)
		cids |= 1u << g_ring_to_cid(__builtin_ctz(rings));
	return cids;
}

/* Есть ли у станции данные к точке. */
static bool upm__uplink_pending(void)
{
	return (upm__cids_with_data() & g_maintained_sta_mask) != 0;
}

/* Точка: цели ATIM в окне AW (вектор 0x802f68, байт 0 — юникаст-CID).
 * Вызывается вместо aw_worker__collect_awake_peers (патч 0012).  В 6.2
 * станция, уснувшая по PM без договора PSC, в вектор не попадала, ATIM ей
 * не шёл, и нисходящие кадры стояли, пока она не проснётся сама.  Теперь
 * к вектору добавляются спящие по upm_vector станции с буферизованными
 * кадрами (802.11-2020 11.2.7.4). */
extern "C" u32 aw_worker__collect_awake_peers(volatile u32 *atim_vec, u32 tsf);

extern "C" u32 upm__collect_awake_peers(volatile u32 *atim_vec, u32 tsf)
{
	u32 r = aw_worker__collect_awake_peers(atim_vec, tsf);
	if (g_uc_role_pcp != 1)
		return r;
	u32 need = g_pm_ctx.upm_vector & upm__cids_with_data() & g_maintained_sta_mask;
	if (need) {
		((volatile u8 *)atim_vec)[0] |= need;
		r = 1;
	}
	return r;
}

extern "C" void upm__dti_start(void)
{
	volatile struct pm_ctx *ctx = &g_pm_ctx;
	if (g_uc_role_pcp != 1 && ctx->upm_enable == 1 && ctx->in_doze == 1 &&
	    (g_upm_atim_rx || upm__uplink_pending()))
		ps__hold_awake_for_sta(ctx, 0);
	g_upm_atim_rx = 0;
}
