// SPDX-License-Identifier: AGPL-3.0-or-later
/* brp_update_omni_sector_idx — сектор приёма станции после BRP (ucode 6.2:
 * 0x923970, 108 байт).
 *
 * Зовут brp_init__flow и brp_responder_flow_enter.  Задаёт, какой RX-сектор
 * станция использует для приёма вне BTI: поле «omni»-индекса (биты 8..22
 * слова +0x0c записи станции).  Меняет поле и пишет в журнал, только если
 * значение изменилось.
 *
 * Исправление 6.4 (было патчем 0002).  6.2 после успешного BRP ставила
 * индекс «направленного omni» 96 + sta — приём через обученный BRP RX-AWV,
 * а после неудачного — с вероятностью ½ его же или quasi-omni 0x7fff.  На
 * стенде направленный приём глух: станция не слышит данные и ACK точки
 * доступа, пинг ~30 %.  Теперь всегда quasi-omni 0x7fff, как у точки
 * доступа: пинг ≥ 95 %, ~980 Мбит/с.  802.11-2020 11.1.3.7 прямо разрешает
 * станции, обученной на приём, quasi-omni в окне после TBTT; для DTI
 * стандарт выбор диаграммы приёма не предписывает.
 */
#include "uc.h"

enum {
	RX_SECTOR_QUASI_OMNI = 0x7fff,
	RX_SECTOR_DIRECTED_OMNI_BASE = 96,   /* 96 + sta — «направленный omni» 6.2 */
	OMNI_IDX_SHIFT = 8,
	OMNI_IDX_MASK  = 0x7fff,             /* 15 бит */
};

/* Запись станции в ucode: 0x801104 + sta * 80; только нужное поле. */
struct uc_sta {
	u8  unknown_00[0x0c];
	u32 rx_cfg;          /* +0x0c: биты 8..22 — индекс RX-сектора omni */
	u8  unknown_10[80 - 0x10];
};
static_assert(sizeof(struct uc_sta) == 80, "uc_sta");
#define uc_sta_table ((struct uc_sta *)0x00801104)

/* Флаг 0x8014c0: ставит команда ucode 0x1b (привязка станции к BSS). */
#define g_8014c0 UC_GLOBAL(u32, 0x008014c0)
/* Байт +0x14 общего блока 0x8577a0: пишет fw из WMI_PCP_START (байт +0x0d
 * команды, журнал fw называет его «max assoc sta»). */
#define g_pcp_start_cmd_0d UC_GLOBAL(u8, 0x008577b4)

/* "brp_update_omni_sector_idx sta:%u directed_omni rx sect idx:%u" */
enum { MSG_BRP_UPDATE_OMNI = 0x01000958 };

extern "C" void bits__uc_set32_s8_w15(volatile u32 *word, u32 value);

/* brp_ok — результат BRP; в 6.4 на выбор сектора не влияет. */
extern "C" void brp_update_omni_sector_idx(u32 sta, u32 brp_ok)
{
	(void)brp_ok;

	if (g_8014c0 && g_pcp_start_cmd_0d >= 2)
		return;

	struct uc_sta *s = &uc_sta_table[sta];
	u32 idx = RX_SECTOR_QUASI_OMNI;
	u32 cur = (s->rx_cfg >> OMNI_IDX_SHIFT) & OMNI_IDX_MASK;

	if (idx == cur)
		return;

	uc_log__emit2(UCLOG_HDR(UCLOG_MOD_SYSTEM, UCLOG_LVL_ERR), MSG_BRP_UPDATE_OMNI, sta, idx);
	bits__uc_set32_s8_w15(&s->rx_cfg, idx & OMNI_IDX_MASK);
}
