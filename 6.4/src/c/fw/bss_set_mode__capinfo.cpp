// SPDX-License-Identifier: AGPL-3.0-or-later
/* bss_set_mode__capinfo — поле DMG Capability Information для Probe Response и
 * ассоциации (6.2: 0x8c4cd8, 76 байт).
 *
 * Зовёт bss_set_mode.  Слово bss+0x5c копирует в кадры push_cap_info: B0..B1
 * BSS Type, B2 CBAP Only = 1, B3 CBAP Source = 0, B4 DMG Privacy, B5 = 0.
 *
 * Изменение 6.4 (mesh): у члена DMG IBSS BSS Type = 1 (табл. 9-68).
 */
#include "ibss.h"

/* " FINAL -> Result m_capinfo %x (BSS TYPE = 0x%x, privacy %x)" */
enum { MSG_CAPINFO = 0x0100c368 };

enum {
	CAPINFO_CBAP_ONLY   = 1u << 2,
	CAPINFO_CBAP_SOURCE = 1u << 3,
	CAPINFO_PRIVACY     = 1u << 4,
	CAPINFO_B5          = 1u << 5,
	CAPINFO_B8_B12      = (1u << 8) | (1u << 12),
};

extern "C" void bits__set32_s0_w2(u32 *word, u32 value);

extern "C" void bss_set_mode__capinfo(u8 *bss, u32 mode, u32 privacy)
{
	u32 *cap = (u32 *)(bss + 0x5c);

	bits__set32_s0_w2(cap, dmg_bss_type(mode));
	u32 v = (*cap | CAPINFO_CBAP_ONLY) & ~(CAPINFO_CBAP_SOURCE | CAPINFO_PRIVACY);
	v |= (privacy & 1) << 4;
	*cap = v & ~CAPINFO_B5;
	*cap &= ~CAPINFO_B8_B12;

	u32 c = *cap;
	fw_log_emit3(FWLOG_HDR(FWLOG_MOD_BSS, FWLOG_LVL_INFO), MSG_CAPINFO,
	             *(u16 *)(bss + 0x5c), c & 3, (c >> 4) & 1);
}
