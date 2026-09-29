// SPDX-License-Identifier: AGPL-3.0-or-later
/* BUILDER_push_dmg_parameters — поле DMG Parameters DMG Beacon (6.2: 0x8c06d0,
 * 116 байт).
 *
 * Зовёт tx_mgmt_build_step при сборке маяка.  Поле (9.4.1.46): B0..B1 BSS
 * Type, B2 CBAP Only, B3 CBAP Source, B4 DMG Privacy, B5 ECAPC Policy
 * Enforced, B6..B7 резерв.
 *
 * Изменения 6.4:
 *  - CBAP Only = 1 только когда весь DTI — CBAP: нет ни расписания ESE, ни
 *    вендорского фиксированного расписания (802.11-2020 10.39.6.3).  В 6.2
 *    схема ESE, наоборот, ставила 1, и точка объявляла «весь DTI — CBAP»
 *    вместе с расписанием; стоковые станции 6.2 без фиксированного
 *    расписания такой маяк теперь не примут (решено: по стандарту);
 *  - mesh: у члена DMG IBSS BSS Type = 1 (табл. 9-68), хотя режим BSS
 *    прошивки — 2 (PCP).
 */
#ifdef FW64_MESH
#include "ibss.h"
#else
#include "fw.h"
#endif

/* "BUILDER_push_dmg_parameters: bss_type %x, privacy %d" */
enum { MSG_PUSH_DMG_PARAMS = 0x0100fa74 };

enum {
	DMG_PARAM_CBAP_ONLY   = 1u << 2,
	DMG_PARAM_CBAP_SOURCE = 1u << 3,
	DMG_PARAM_PRIVACY     = 1u << 4,
	DMG_PARAM_ECAPC       = 1u << 5,
};

/* Вендорское фиксированное расписание включено (байт +5 объекта 0x847adc,
 * WMI 0xa03). */
#define g_fixed_sched_enabled FW_GLOBAL(u8, 0x847adc + 5)

extern "C" {
void bits__set8_s0_w2(u8 *byte, u32 value);
void bits__set8_s6_w2(u8 *byte, u32 value);
u32  mid__get_field_0c(void *obj);
}

static inline u32 mid_word(const void *mid, u32 ofs)
{
	return *(const volatile u32 *)((const u8 *)mid + ofs);
}

extern "C" u32 BUILDER_push_dmg_parameters(u8 *param, void *mid)
{
#ifdef FW64_MESH
	bits__set8_s0_w2(param, dmg_bss_type(mid_word(mid, 0x50)));
#else
	bits__set8_s0_w2(param, mid_word(mid, 0x50) & 3);
#endif

	/* [схема ESE +0xc] ≠ 0 — схема активна, маяк несёт ESE */
	bool ese_active = mid__get_field_0c((void *)mid_word(mid, 0x290)) != 0;
	bool cbap_only = !g_fixed_sched_enabled && !ese_active;
	u8 v = *param & ~(DMG_PARAM_CBAP_ONLY | DMG_PARAM_CBAP_SOURCE);
	if (cbap_only)
		v |= DMG_PARAM_CBAP_ONLY;
	*param = v;

	v &= ~(DMG_PARAM_PRIVACY | DMG_PARAM_ECAPC);
	if (mid_word(mid, 0x3c))
		v |= DMG_PARAM_PRIVACY;
	*param = v;
	bits__set8_s6_w2(param, 0);

	fw_log_emit2(FWLOG_HDR(13, FWLOG_LVL_INFO), MSG_PUSH_DMG_PARAMS,
	             *param & 3, (*param >> 4) & 1);
	return 1;
}
