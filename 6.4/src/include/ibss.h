// SPDX-License-Identifier: AGPL-3.0-or-later
/* DMG IBSS (прошивка mesh, 802.11-2020 11.1.3.5, 11.1.5).
 *
 * Ячейка IBSS работает поверх машинерии PCP: режим BSS остаётся 2 (маяк,
 * A-BFT, безролевое соединение), а отличия, которые стандарт требует для
 * IBSS, включает флаг g_ibss: BSS Type = 1 в DMG Beacon и Probe Response
 * (табл. 9-68), дальше — BSSID ячейки, синхронизация TSF, случайная задержка
 * маяка.
 */
#ifndef WIL6210_FW62_IBSS_H
#define WIL6210_FW62_IBSS_H

#include "fw.h"

/* Типы сети WMI (wmi.h: enum wmi_network_type). */
enum {
	WMI_NETTYPE_ADHOC         = 0x02,
	WMI_NETTYPE_ADHOC_CREATOR = 0x04,
};

/* BSS Type (DMG Parameters B0..B1, 9.4.1.46, табл. 9-68, Discovery Mode 0). */
enum {
	DMG_BSS_TYPE_IBSS = 1,
	DMG_BSS_TYPE_PBSS = 2,
	DMG_BSS_TYPE_AP   = 3,
};

#ifdef __cplusplus
extern "C" {
#endif
/* Не 0 — узел член DMG IBSS (ставит l2_mgr__pcp_start_flow, снимает pcp_stop). */
extern u32 g_ibss;
/* BSSID ячейки из WMI 0x85a (IBSS_BSSID) и признак, что он задан. */
extern u8  g_ibss_bssid[6];
extern u32 g_ibss_bssid_valid;
/* Применить BSSID к BSS интерфейса (регистр BSSID MAC, разборщик, офлоад). */
void l2mgr__apply_mac_address(void *bss, const u8 *addr);
#ifdef __cplusplus
}
#endif

static inline bool nettype_is_ibss(u32 t)
{
	return t == WMI_NETTYPE_ADHOC || t == WMI_NETTYPE_ADHOC_CREATOR;
}

/* BSS Type для кадров узла: IBSS — 1, иначе по режиму BSS (кодировка
 * прошивки 1/2/3 совпадает с табл. 9-68). */
static inline u32 dmg_bss_type(u32 bss_mode)
{
	return g_ibss ? DMG_BSS_TYPE_IBSS : (bss_mode & 3);
}

#endif
