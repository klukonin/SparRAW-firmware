// SPDX-License-Identifier: AGPL-3.0-or-later
/* Синхронизация TSF члена DMG IBSS, грубая ступень (6.4, прошивка mesh;
 * 802.11-2020 11.1.5, 11.1.3.7, 11.1.3.9).
 *
 * Член IBSS, приняв DMG Beacon своей ячейки (BSS Type = 1, Discovery Mode
 * = 0), сравнивает его Timestamp со своим TSF и принимает более поздний.
 * В 6.2 программного приёма TSF нет.  Здесь — по каждому маяку ячейки в
 * ветке «свой BSS» dmg_bcon__rx_handler (после сравнения BSSID).
 *
 * Загрузка TSF — mac__reload_tsf64: защёлка 0x886dc0/c4, MAC 0x0d000006
 * (загрузить) и 0x0d0a1e53 (сетка TBTT пересчитывается от нового TSF;
 * без второго слова узел перестаёт маячить — проверено на стенде).
 *
 * Точность ограничена задержкой от приёма кадра до этого места
 * (не измерена): узел отстаёт от соседа на эту задержку.  Её выбирает
 * точная ступень в окне задержки BTI (ucode), куда маяк соседа теперь
 * попадает.  Поправка 11.1.3.9 (задержка приёма PHY) не вносится.
 */
#include "ibss.h"
#include "fw_uc_shared.h"

enum {
	BCN_TIMESTAMP_OFS   = 0x0a,     /* DMG Beacon: FC 2, Duration 2, BSSID 6 */
	BCN_BI_CONTROL_OFS  = 0x17,
	BCN_DMG_PARAMS_OFS  = 0x1d,
	BI_CTRL_DISCOVERY   = 0x02,     /* Discovery Mode */
	DMG_PARAMS_BSS_TYPE = 0x03,
	BSS_TYPE_IBSS       = 1,
	TSF_ADOPT_MARGIN_US = 50,       /* меньше — шум чтения, не «позже» */
};

#define g_tsf_lo  FW_GLOBAL(u32, 0x00886eb8)
#define g_tsf_hi  FW_GLOBAL(u32, 0x00886ebc)
#define g_ibss_tsf (*(volatile struct ibss_tsf_state *)UC_EXT_DATA_FW(IBSS_TSF_OFS))

extern "C" {
void *mid_list__find_by(void *mid, const u8 *addr);
void mac__reload_tsf64(u32 lo, u32 hi);
}

static u64 read_tsf64(void)
{
	u32 hi, lo;

	do {
		hi = g_tsf_hi;
		lo = g_tsf_lo;
	} while (hi != g_tsf_hi);
	return ((u64)hi << 32) | lo;
}

static u64 get_le64(const u8 *p)
{
	u64 v = 0;

	for (int i = 7; i >= 0; i--)
		v = (v << 8) | p[i];
	return v;
}

static void ibss_tsf__adopt_if_later(const u8 *frame)
{
	if (g_ibss_tsf.valid != IBSS_TSF_VALID) {
		g_ibss_tsf.seen = 0;
		g_ibss_tsf.adopted = 0;
		g_ibss_tsf.last_diff_us = 0;
		g_ibss_tsf.links = 0;
		g_ibss_tsf.lost = 0;
		g_ibss_tsf.valid = IBSS_TSF_VALID;
	}
	if ((frame[BCN_DMG_PARAMS_OFS] & DMG_PARAMS_BSS_TYPE) != BSS_TYPE_IBSS ||
	    (frame[BCN_BI_CONTROL_OFS] & BI_CTRL_DISCOVERY))
		return;         /* 11.1.3.7: только маяки IBSS без Discovery */

	g_ibss_tsf.seen = g_ibss_tsf.seen + 1;
	u64 ts = get_le64(frame + BCN_TIMESTAMP_OFS);
	u64 own = read_tsf64();
	s64 diff = (s64)(ts - own);

	g_ibss_tsf.last_diff_us = (u32)diff;
	if (diff <= TSF_ADOPT_MARGIN_US)
		return;         /* свой не раньше — 11.1.5 не велит принимать */

	u64 own_now = read_tsf64();
	u64 adj = own_now + (u64)diff;
	mac__reload_tsf64((u32)adj, (u32)(adj >> 32));
	g_ibss_tsf.adopted = g_ibss_tsf.adopted + 1;
}

/* SLS в DTI с соседом по ячейке (802.11-2020 10.42.6).  Индивидуальный адрес
 * соседа — STA Address элемента DMG Capabilities его маяка (9.4.2.127): его
 * разбор уже лежит в таблице элементов кадра.  Нет соединения — завести и
 * обучить луч штатным захватом линка (find_main_sm__bcon_args: conn, SLS в
 * DTI, затем безролевой путь до «готов к данным», conn.h roleless_enabled).
 * Начинает узел с меньшим MAC, чтобы соседи не шли навстречу друг другу;
 * ответчик-PCP заводит соединение сам по «new link».  Повтор к тому же
 * соседу — не чаще IBSS_LINK_RETRY_US; соседей в ячейке может быть
 * несколько (по CID, до 8). */
enum {
	EI_DMG_CAP_EID  = 0x70,         /* таблица элементов: EID, длина, тело */
	EI_DMG_CAP_LEN  = 0x71,
	EI_DMG_CAP_BODY = 0x74,
	EID_DMG_CAP     = 148,
	MID_OWN_MAC     = 0x0a,
	MAC_LEN         = 6,
	IBSS_LINK_RETRY_US = 1000000,
};

extern "C" void *find_main_sm__bcon_args(void *mid, const u8 *mac, u32 bcon_info,
                                         u32 arg3, u32 arg4);

/* Последние попытки захвата линка: по соседу, до IBSS_LINK_SLOTS (с
 * вытеснением самой старой). */
enum { IBSS_LINK_SLOTS = 8 };
static struct {
	u8  mac[MAC_LEN];
	u32 tsf;
} g_ibss_link_try[IBSS_LINK_SLOTS];

static int mac_cmp(const u8 *a, const u8 *b)
{
	for (int i = 0; i < MAC_LEN; i++)
		if (a[i] != b[i])
			return a[i] < b[i] ? -1 : 1;
	return 0;
}

static void ibss_link__on_beacon(u8 *mid, const u8 *ei)
{
	if (ei[EI_DMG_CAP_EID] != EID_DMG_CAP || ei[EI_DMG_CAP_LEN] < MAC_LEN)
		return;
	const u8 *peer = *(const u8 *const *)(ei + EI_DMG_CAP_BODY);
	const u8 *own = mid + MID_OWN_MAC;

	if (!peer || mac_cmp(own, peer) >= 0)
		return;         /* свой маяк или инициатор — сосед */
	if (mid_list__find_by(mid, peer))
		return;         /* соединение уже есть или заводится */
	u32 now = g_tsf_lo;
	u32 slot = 0;
	for (u32 i = 0; i < IBSS_LINK_SLOTS; i++) {
		if (!mac_cmp(peer, g_ibss_link_try[i].mac)) {
			if (now - g_ibss_link_try[i].tsf < IBSS_LINK_RETRY_US)
				return;
			slot = i;
			break;
		}
		if (now - g_ibss_link_try[i].tsf > now - g_ibss_link_try[slot].tsf)
			slot = i;
	}
	for (int i = 0; i < MAC_LEN; i++)
		g_ibss_link_try[slot].mac[i] = peer[i];
	g_ibss_link_try[slot].tsf = now;
	g_ibss_tsf.links = g_ibss_tsf.links + 1;
	find_main_sm__bcon_args(mid, peer, 0, 0, 0xffff);
}

/* Уход соседа.  В IBSS ассоциации нет, и штатные детекторы потери связи
 * на этом пути не включены: сосед, пропавший из эфира, оставался станцией
 * ячейки навсегда.  Время последнего маяка соседа запоминается по CID; на
 * каждый отчёт MAC_MON сосед без маяков IBSS_PEER_LOST_BI отчётов подряд
 * отключается штатным l2mgr__disconnect_sta, хосту уходит
 * WMI_DISCONNECT_EVENT.  Возраст считается в отчётах, не по TSF: TSF прыгает
 * при приёме более позднего (11.1.5).  Членов по очереди глушит случайная
 * задержка 11.1.3.5, маяк соседа доходит лишь в части BI (на стенде ~16 %),
 * поэтому порог 100 отчётов (на стенде сосед снимается за 3–6 с). */
enum {
	IBSS_PEER_MAX      = 8,
	IBSS_PEER_LOST_BI  = 100,
	CONN_CID           = 0x08,
	REASON_INACTIVITY  = 4,         /* 802.11-2020 табл. 9-49 */
	WMI_DIS_LOST_LINK  = 2,
};

extern "C" {
void l2mgr__disconnect_sta(u32 mid_id, const u8 *mac, u32 reason);
void l2mgr__send_disconnect_evt(const u8 *bssid, u32 proto_reason, u32 wmi_reason, u32 mid);
}

struct ibss_peer {
	u8  mac[MAC_LEN];
	u8  valid;
	u32 last_bi;
};
static struct ibss_peer g_ibss_peer[IBSS_PEER_MAX];
static u8 *g_ibss_mid;
static u32 g_ibss_bi;           /* отчётов MAC_MON с запуска */

static void ibss_peer__seen(u8 *mid, const u8 *ei)
{
	if (ei[EI_DMG_CAP_EID] != EID_DMG_CAP || ei[EI_DMG_CAP_LEN] < MAC_LEN)
		return;
	const u8 *peer = *(const u8 *const *)(ei + EI_DMG_CAP_BODY);
	const u8 *conn = peer ? (const u8 *)mid_list__find_by(mid, peer) : 0;

	if (!conn || conn[CONN_CID] >= IBSS_PEER_MAX)
		return;
	g_ibss_mid = mid;
	struct ibss_peer *e = &g_ibss_peer[conn[CONN_CID]];
	for (int i = 0; i < MAC_LEN; i++)
		e->mac[i] = peer[i];
	e->valid = 1;
	e->last_bi = g_ibss_bi;
}

/* На каждый отчёт MAC_MON (lmac_if__update_pct_stats). */
extern "C" void ibss_peer__age(void)
{
	g_ibss_bi++;
	if (!g_ibss || !g_ibss_mid)
		return;
	for (u32 cid = 0; cid < IBSS_PEER_MAX; cid++) {
		if (!g_ibss_peer[cid].valid || g_ibss_bi - g_ibss_peer[cid].last_bi < IBSS_PEER_LOST_BI)
			continue;
		g_ibss_peer[cid].valid = 0;
		if (mid_list__find_by(g_ibss_mid, g_ibss_peer[cid].mac)) {
			g_ibss_tsf.lost = g_ibss_tsf.lost + 1;
			l2mgr__disconnect_sta(0, g_ibss_peer[cid].mac, REASON_INACTIVITY);
			/* на этом пути прошивка хосту не сообщает — сообщить явно */
			l2mgr__send_disconnect_evt(g_ibss_peer[cid].mac, REASON_INACTIVITY,
			                           WMI_DIS_LOST_LINK, 0);
		}
	}
}

/* Вход из dmg_bcon__rx_handler (патч 0021) вместо mid_list__find_by: r0 mid,
 * r1 адрес (BSSID кадра), r2 — контекст приёма (r14 вызывающего), его
 * +0x8 — кадр, +0xc — таблица элементов. */
extern "C" void *ibss_tsf__on_own_beacon(void *mid, const u8 *addr, u8 *rx)
{
	if (g_ibss) {
		ibss_tsf__adopt_if_later(*(const u8 *const *)(rx + 0x8));
		ibss_link__on_beacon((u8 *)mid, *(const u8 *const *)(rx + 0xc));
		ibss_peer__seen((u8 *)mid, *(const u8 *const *)(rx + 0xc));
	}
	return mid_list__find_by(mid, addr);
}

__asm__(
	"	.section .text.ibss_tsf_entry,\"ax\",@progbits\n"
	"	.p2align 2\n"
	"	.global ibss_tsf__on_own_beacon_entry\n"
	"ibss_tsf__on_own_beacon_entry:\n"
	"	b.d ibss_tsf__on_own_beacon\n"
	"	mov_s r2,r14\n");
