// SPDX-License-Identifier: AGPL-3.0-or-later
/* Объект энергосбережения ucode 6.2 (0x802f80; в 4.1 — 0x801ed0) и PS без
 * графика (UPM, 802.11-2020 11.2.7.2.2).  Только известные поля.
 */
#ifndef WIL6210_UC62_PS_H
#define WIL6210_UC62_PS_H

#include "uc.h"

struct pm_ctx {
	u8  unknown_000[0x20];
	u32 psc_state;          /* +0x020: 0 — графика нет, 1 — бодрствующий BI, 2 — BI сна */
	u8  unknown_024[0x134 - 0x24];
	u8  awake_peers[2];     /* +0x134, +0x135: CID, бодрствующие в этом BI (объединяются) */
	u8  unknown_136[2];
	u8  no_tx_peers;        /* +0x138: бодрствуют, но передавать им нельзя */
	u8  unknown_139[7];
	u32 ps_active;          /* +0x140: не 0 — PS в BSS работает */
	u8  unknown_144[0x158 - 0x144];
	u8  evt_body[8];        /* +0x158: тело события 0x16 (см. tx_ctx__post_status) */
	u32 evt_type;           /* +0x160 */
	u8  upm_enable;         /* +0x164: LMAC 0x33 */
	u8  upm_enable_saved;   /* +0x165: копия на время скана (LMAC 0x24), после скана возвращается в +0x164 */
	u8  unknown_166[2];
	u32 upm_timeout_ticks;  /* +0x168: простой до сна, такты MAC 165 МГц */
	u8  upm_state_16c;      /* +0x16c, +0x16d: сбрасываются при выключении UPM */
	u8  upm_state_16d;
	u8  unknown_16e[0x178 - 0x16e];
	u8  upm_vector;         /* +0x178: AP — CID спящих станций (бит PM принятых кадров) */
	u8  in_doze;            /* +0x179: STA — сама в doze по UPM */
};
static_assert(__builtin_offsetof(struct pm_ctx, psc_state) == 0x20, "pm+0x20");
static_assert(__builtin_offsetof(struct pm_ctx, ps_active) == 0x140, "pm+0x140");
static_assert(__builtin_offsetof(struct pm_ctx, evt_body) == 0x158, "pm+0x158");
static_assert(__builtin_offsetof(struct pm_ctx, upm_enable) == 0x164, "pm+0x164");
static_assert(__builtin_offsetof(struct pm_ctx, upm_timeout_ticks) == 0x168, "pm+0x168");
static_assert(__builtin_offsetof(struct pm_ctx, upm_vector) == 0x178, "pm+0x178");

#define g_pm_ctx (*(volatile struct pm_ctx *)0x00802f80)

enum {
	PSC_STATE_DOZE_BI  = 2,
	GP_TIMER_UPM_IDLE  = 8,         /* простой до входа в UPM-doze */
	MAC_TICKS_PER_US   = 165,
};

/* Роль узла: 1 — AP/PCP (по использованию в tx_ctx__post_status). */
#define g_uc_role_pcp UC_GLOBAL(u32, 0x008014c0)

extern "C" {
/* enter = 1 — войти в UPM-doze обменом с PM = 1, 0 — выйти (PM = 0). */
void ps__hold_awake_for_sta(volatile struct pm_ctx *ctx, u32 enter);
void gp_timer__set_value(volatile struct pm_ctx *ctx, u32 timer, u32 ticks);
}

#endif
