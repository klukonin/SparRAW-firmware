// SPDX-License-Identifier: AGPL-3.0-or-later
/* UPSIM в DMG Beacon (6.4, прошивка apsta; 802.11-2020 9.4.2.166, 11.2.7.2.2).
 *
 * Пока хоть одна станция в PS без графика, AP обязан включать UPSIM в каждый
 * DMG Beacon; карта отражает состояние станций на момент передачи.  Маску
 * спящих CID ведёт ucode (ps.h); маяк собирается шаблоном, поэтому при смене
 * маски шаблон пересобирается (ps_upsim__refresh_bcon, из обработчика события
 * ucode 0x16 через conn_mgr__start_all_detector_services).
 */
#include "ps.h"
#include "strings-fw.h"

/* Состояния conn_main_sm (описатель 0x802744), в которых станция ассоциирована. */
enum {
	CONN_MSM_ASSOCIATED = 5,
	CONN_MSM_KEY_ASSOC  = 7,
	MAX_CID             = 8,
};

struct conn_hdr {
	u8 unknown_00[8];
	u8 cid;                 /* +0x08 */
	u8 aid;                 /* +0x09: AID станции (mid__cid_by_aid) */
	u8 unknown_0a[0x124 - 0x0a];
	u8 conn_msm_state;      /* +0x124 */
};
static_assert(__builtin_offsetof(struct conn_hdr, conn_msm_state) == 0x124, "conn+0x124");

extern "C" {
struct conn_hdr *conn_mgr__by_cid(u32 cid);
void add_bcon(void *mid);
void memset0_words(void *dst, u32 len);
}

u32   g_upsim_bcon_upm;
void *g_upsim_bcon_mid;

static bool conn_is_associated(const struct conn_hdr *c)
{
	return c && (c->conn_msm_state == CONN_MSM_ASSOCIATED ||
	             c->conn_msm_state == CONN_MSM_KEY_ASSOC);
}

extern "C" u32 ie__push_upsim(u8 *p, u32 upm_cids)
{
	u32 words[UPSIM_MAP_OCTETS / 4];
	memset0_words(words, sizeof(words));    /* без libc memset */
	u8 *map = (u8 *)words;
	u32 nsta = 0, nps = 0;

	for (u32 cid = 0; cid < MAX_CID; cid++) {
		struct conn_hdr *c = conn_mgr__by_cid(cid);
		if (!conn_is_associated(c))
			continue;
		nsta++;
		if (!(upm_cids & (1u << cid)))
			continue;
		nps++;
		if (c->aid >= UPSIM_AID_MIN && c->aid <= UPSIM_AID_MAX)
			map[c->aid / 8] |= 1u << (c->aid % 8);
	}
	if (!nps)
		return 0;

	u8 flags = nps == nsta ? UPSIM_PS_NON_PCP : 0;
	int n1 = 0, n2 = UPSIM_MAP_OCTETS - 1;
	while (n1 < UPSIM_MAP_OCTETS && !map[n1])
		n1++;
	p[0] = EID_UPSIM;
	if (n1 == UPSIM_MAP_OCTETS) {
		/* биты 1..254 одинаковы (все 0): без частичной карты */
		p[1] = 1;
		p[2] = flags;
		return 3;
	}
	while (!map[n2])
		n2--;
	p[1] = (u8)(n2 - n1 + 2);
	p[2] = flags | (u8)(n1 << UPSIM_OFFSET_SHIFT);
	for (int i = n1; i <= n2; i++)
		p[3 + i - n1] = map[i];
	return 3 + n2 - n1 + 1;
}

extern "C" void ps_upsim__refresh_bcon(void)
{
	u32 upm = g_uc_upm_vector;
	if (upm == g_upsim_bcon_upm || !g_upsim_bcon_mid)
		return;
	u8 *mid = (u8 *)g_upsim_bcon_mid;
	struct bss *bss = (struct bss *)(mid + 0x48);
	if (bss->state != BSS_STATE_ACTIVE ||
	    (bss->mode != BSS_MODE_AP && bss->mode != BSS_MODE_PBSS))
		return;
	fw_log_emit2(FWLOG_HDR(FWLOG_MOD_POWER_MNGR, FWLOG_LVL_INFO), MSG64_UPSIM_BCON,
	             g_upsim_bcon_upm, upm);
	add_bcon(mid);      /* сборка зовёт tx_mgmt_build_step, та обновит g_upsim_bcon_upm */
}
