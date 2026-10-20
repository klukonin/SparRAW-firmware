// SPDX-License-Identifier: AGPL-3.0-or-later
/* Интервал маяка станции — из маяка точки (исправление 6.2; 802.11-2020
 * 11.1.3.3.1: станция, входя в BSS, принимает Beacon Interval этой BSS).
 *
 * 6.2 берёт период BI станции (l2_mgr__connect → RADIO_MGR__set_primary_channel)
 * из глобала 0x8002d4, который пишет только команда хоста 0x803.  В 6.2 это
 * «beacon_interval + align», а в мейнлайн-драйвере 0x803 — WMI_ECHO: при
 * старте он шлёт 0x12345678, и станция считает BI = 0x5678 TU (~22,7 с).
 * Итог — нет bi1_event, ложные «плохие маяки», разрыв каждые 2–4 с.
 *
 * Здесь: по каждому принятому DMG Beacon (и при скане перед подключением)
 * запоминается пара BSSID → Beacon Interval; wmi_connect перед подключением
 * берёт интервал выбранной точки (sta_bi__apply).  Если маяка точки не было,
 * остаётся значение хоста, как в 6.2.  Команда 0x803 работает по-прежнему.
 *
 * Патч 0022: вызов dmg_bcon__rx_handler в discovery__rx_pkt_handler идёт
 * через sta_bi__bcon_rx.
 */
#include "fw.h"
#include "strings-fw.h"

enum {
	BCN_BSSID_OFS      = 0x04,      /* DMG Beacon: FC 2, Duration 2 */
	BCN_BI_OFS         = 0x15,      /* Timestamp 8, Sector Sweep 3 */
	BCN_BI_CONTROL_OFS = 0x17,
	BI_CTRL_DISCOVERY  = 0x02,      /* Discovery Mode */
	RX_FRAME           = 0x08,      /* rx-дескриптор: указатель на кадр */
	MAC_LEN            = 6,
	STA_BI_SLOTS       = 8,
};

struct sta_bi_entry {
	u8  bssid[MAC_LEN];
	u16 bi_tu;                      /* 0 — запись пуста */
};
static struct sta_bi_entry g_sta_bi[STA_BI_SLOTS];
static u32 g_sta_bi_next;

static int mac_eq(const u8 *a, const u8 *b)
{
	for (int i = 0; i < MAC_LEN; i++)
		if (a[i] != b[i])
			return 0;
	return 1;
}

static struct sta_bi_entry *sta_bi__find(const u8 *bssid)
{
	for (u32 i = 0; i < STA_BI_SLOTS; i++)
		if (g_sta_bi[i].bi_tu && mac_eq(g_sta_bi[i].bssid, bssid))
			return &g_sta_bi[i];
	return 0;
}

static void sta_bi__record(const u8 *frame)
{
	if (!frame || (frame[BCN_BI_CONTROL_OFS] & BI_CTRL_DISCOVERY))
		return;         /* маяк Discovery Mode — не маяк BSS */
	u32 bi = frame[BCN_BI_OFS] | (frame[BCN_BI_OFS + 1] << 8);
	if (!bi)
		return;
	const u8 *bssid = frame + BCN_BSSID_OFS;
	struct sta_bi_entry *e = sta_bi__find(bssid);
	if (!e) {
		e = &g_sta_bi[g_sta_bi_next];
		g_sta_bi_next = (g_sta_bi_next + 1) % STA_BI_SLOTS;
		for (int i = 0; i < MAC_LEN; i++)
			e->bssid[i] = bssid[i];
	}
	e->bi_tu = bi;
}

extern "C" u32 dmg_bcon__rx_handler(void *ctx, u8 *rx);

extern "C" u32 sta_bi__bcon_rx(void *ctx, u8 *rx)
{
	sta_bi__record(*(const u8 *const *)(rx + RX_FRAME));
	return dmg_bcon__rx_handler(ctx, rx);
}

extern "C" void sta_bi__apply(const u8 *bssid)
{
	struct sta_bi_entry *e = sta_bi__find(bssid);
	if (!e)
		return;
	fw_log_emit2(FWLOG_HDR(FWLOG_MOD_BSS, FWLOG_LVL_INFO), MSG64_STA_BI_FROM_BEACON,
	             e->bi_tu, g_bcon_interval_tu);
	g_bcon_interval_tu = e->bi_tu;
}
