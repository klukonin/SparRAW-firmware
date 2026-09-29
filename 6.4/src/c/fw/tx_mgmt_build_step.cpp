// SPDX-License-Identifier: AGPL-3.0-or-later
/* tx_mgmt_build_step — фиксированная часть DMG Beacon и элементы, которые
 * строит сама прошивка (6.2: 0x8d7df4, 132 байта).
 *
 * Зовёт tx_mgmt_srvs__build_dmg_beacon; хостовые IE добавляются после.
 * Порядок полей — 802.11-2020 табл. 9-45: заголовок, Timestamp, Sector Sweep,
 * Beacon Interval, BI Control, DMG Parameters, Clustering Control (если в BI
 * Control стоит CC Present), Awake Window (15), UPSIM (17).  Возвращает длину.
 *
 * 6.4 apsta (11.2.7.2.2): пока спит хоть одна станция, Awake Window
 * объявляется независимо от профиля PS точки и добавляется UPSIM.
 * 6.4 mesh: маяк члена DMG IBSS несёт элемент DMG Capabilities (табл. 9-45,
 * п. 7) — в нём STA Address, индивидуальный MAC узла: адресное поле DMG
 * Beacon одно, BSSID ячейки общий (9.3.4.2), а сосед по этому адресу
 * запускает SLS в DTI (10.42.6).
 */
#include "fw.h"
#include "conn.h"
#include "ps.h"
#ifdef FW64_MESH
#include "ibss.h"
#endif

/* Смещения полей DMG Beacon (кадр расширения, 9.3.4.2). */
enum {
	DMG_BCON_TIMESTAMP   = 0x0a,
	DMG_BCON_TIMESTAMP_LEN = 8,
	DMG_BCON_FIXED_AFTER_HDR = 0x0d,   /* Timestamp 8 + SSW 3 + BI 2 */
	DMG_BCON_BI          = 0x15,
	DMG_BCON_BI_CONTROL  = 0x17,
	DMG_BCON_DMG_PARAMS  = 0x1d,
	BI_CONTROL_CC_PRESENT = 1u << 0,
};

extern "C" {
/* Заголовок кадра (FC, Duration, BSSID); длина. */
u32  mgmt_tx__set_frame_control(u8 *frame, void *mid);
/* Поле BI Control (имя блока неточное); длина. */
u32  mgmt_tx__copy_addr_from_mid(u8 *p, void *mid);
/* Элемент Clustering Control (имя блока неточное); длина. */
u32  mgmt_tx__copy_addr_from_conn(u8 *p, void *mid);
u32  BUILDER_push_dmg_parameters(u8 *p, void *mid);
void memset0_words(void *dst, u32 len);
/* Первые 4 байта блока — геттер флага «профиль PS точки разрешает AW»
 * ([0x800424]); имя блока неточное. */
u32  sw_vring__ba_agreed(struct bss *bss);
u16  mid__get_aw_len(struct bss *bss);
u32  ie__push_awake_window(u8 *p, u32 duration_us);
/* DMG Capabilities: EID 148, 17 байт тела из cap17, AID в байт 6; длина 0x13. */
u32  ie__push_dmg_capabilities(u8 *p, const u8 *cap17, u32 aid);
}

/* Тело DMG Capabilities узла (STA Address — свой MAC); из него же строит
 * элемент Probe Response. */
enum { BSS_DMG_CAP = 0x5e };

extern "C" u32 tx_mgmt_build_step(u8 *frame, void *mid)
{
	struct bss *bss = (struct bss *)((u8 *)mid + 0x48);
	u32 len = mgmt_tx__set_frame_control(frame, mid);

	memset0_words(frame + DMG_BCON_TIMESTAMP, DMG_BCON_TIMESTAMP_LEN);
	len += DMG_BCON_FIXED_AFTER_HDR;
	u32 bi = g_bcon_interval_tu;
	frame[DMG_BCON_BI] = bi;
	frame[DMG_BCON_BI + 1] = bi >> 8;
	len += mgmt_tx__copy_addr_from_mid(frame + DMG_BCON_BI_CONTROL, mid);
	len += BUILDER_push_dmg_parameters(frame + DMG_BCON_DMG_PARAMS, mid);
	if (frame[DMG_BCON_BI_CONTROL] & BI_CONTROL_CC_PRESENT)
		len += mgmt_tx__copy_addr_from_conn(frame + len, mid);

#ifdef FW64_MESH
	if (g_ibss)
		len += ie__push_dmg_capabilities(frame + len, (const u8 *)bss + BSS_DMG_CAP, 0);
	if (sw_vring__ba_agreed(bss) || g_oob_r1)
		len += ie__push_awake_window(frame + len, mid__get_aw_len(bss));
#else
	u32 upm = g_uc_upm_vector;
	g_upsim_bcon_upm = upm;
	g_upsim_bcon_mid = mid;
	if (sw_vring__ba_agreed(bss) || g_oob_r1 || upm)
		len += ie__push_awake_window(frame + len, mid__get_aw_len(bss));
	if (upm)
		len += ie__push_upsim(frame + len, upm);
#endif
	return len;
}
