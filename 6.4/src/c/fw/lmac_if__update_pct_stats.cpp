// SPDX-License-Identifier: AGPL-3.0-or-later
/* lmac_if__update_pct_stats — обработчик события ucode 0x17 MAC_MONITOR_EVT
 * (6.2: 0x8db9c0, 224 байта).
 *
 * Каждый BI ucode публикует отчёт об окнах BTI/AW/DTI в общую память
 * (0x853940, 0x80 байт; публикатор — peer_slots__scan_by_masks) и шлёт
 * событие 0x17.  Здесь: SNR по RSSI маяка, доли NAV и занятости среды в
 * DTI (текущие и средние за период), рассылка системного события 0x16 —
 * по нему отчёт читают детекторы потери маяков и keep-alive.
 *
 * Возвращено из 4.1 (lmac_if__mac_monitor_report): печать отчёта в модуль
 * журнала MAC_MON — 12 строк 4.1, по смещениям 6.2.  Печать идёт из снимка,
 * снятого сразу после расчёта SNR: публикатор перезаписывает отчёт каждый BI
 * и ничем его не защищает.  Строка «update time» 4.1 не возвращена — в 6.2
 * ucode это время не сохраняет.  Возвращена и строка события
 * «Ucode->MAC_MONITOR_EVT» диспетчера 4.1.
 */
#include "fw.h"
#include "strings-fw.h"

/* Отчёт MAC_MON 6.2.  До +0x48 раскладка совпадает с 4.1 (0x854de0); с
 * +0x50 в 6.2 вставлены два поля, всё дальше сдвинуто на 8 байт. */
struct mac_mon_report {
	u32 size;                /* +0x00: 0x80 */
	u32 bcon_bitmap_lo;      /* +0x04: писателя нет ни в 4.1, ни в 6.2 */
	u32 bcon_bitmap_hi;      /* +0x08 */
	u32 bti_start_lo;        /* +0x0c: TSF начала BTI */
	u32 bti_start_hi;        /* +0x10 */
	u32 bti_duration;        /* +0x14 */
	u32 rssi_valid;          /* +0x18 */
	u32 rssi;                /* +0x1c: лучший RSSI маяка за BI */
	u8  snr_valid;           /* +0x20: пишет fw (здесь) */
	u8  unknown_21[3];
	u32 snr;                 /* +0x24: пишет fw (здесь) */
	u8  tx_bcon;             /* +0x28 */
	u8  rx_bcon;             /* +0x29 */
	u8  bcon_detected;       /* +0x2a */
	u8  unknown_2b;
	u32 aw_start_lo;         /* +0x2c */
	u32 aw_start_hi;         /* +0x30 */
	u32 aw_duration;         /* +0x34 */
	u8  aw_backoff;          /* +0x38 */
	u8  tx_atim_pass;        /* +0x39 */
	u8  tx_atim_fail;        /* +0x3a */
	u8  tx_atim_counter;     /* +0x3b */
	u8  rx_atim;             /* +0x3c */
	u8  bcons_atim_fail_vec; /* +0x3d: бит на связь, ≥ 11 BI подряд без ATIM */
	u8  unknown_3e[2];
	u32 dti_start_lo;        /* +0x40 */
	u32 dti_start_hi;        /* +0x44 */
	u32 dti_duration;        /* +0x48: BI − BTI − AW */
	u32 nav_accumulator;     /* +0x4c */
	u32 dti_x50;             /* +0x50: только 6.2, накопленная длительность от 0x8006e0; смысл не установлен */
	u32 dti_busy;            /* +0x54: только 6.2, занятость среды (по имени писателя) */
	u16 dti_backoff;         /* +0x58 (4.1: +0x50) */
	u16 tx_rts;              /* +0x5a */
	u16 rx_cts;              /* +0x5c */
	u16 rx_dts;              /* +0x5e */
	u16 rx_rts;              /* +0x60 */
	u16 tx_cts;              /* +0x62 */
	u16 tx_dts;              /* +0x64 */
	u16 cf_end;              /* +0x66 */
	u8  ka_pass;             /* +0x68 */
	u8  ka_fail;             /* +0x69 */
	u8  unknown_6a[2];       /* только 6.2 */
	u32 rx_off_duration;     /* +0x6c */
	u32 unknown_70[4];       /* только 6.2: +0x70/+0x74 — fixed scheduling, +0x78 — событий BI2 */
};
static_assert(sizeof(struct mac_mon_report) == 0x80, "mac_mon_report");
static_assert(__builtin_offsetof(struct mac_mon_report, dti_duration) == 0x48, "+0x48");
static_assert(__builtin_offsetof(struct mac_mon_report, dti_backoff) == 0x58, "+0x58");
static_assert(__builtin_offsetof(struct mac_mon_report, rx_off_duration) == 0x6c, "+0x6c");

#define g_mac_mon_report (*(volatile struct mac_mon_report *)0x853940)

enum { UCODE_EVT_MAC_MONITOR = 0x17 };

/* Доли NAV и занятости среды в DTI, % (0x80426c). */
struct pct_stats {
	u16 count;          /* +0x00: BI в текущем периоде */
	u8  busy_pct;       /* +0x02 */
	u8  unknown_03;
	u32 busy_sum;       /* +0x04 */
	u8  busy_avg;       /* +0x08 */
	u8  nav_pct;        /* +0x09 */
	u8  unknown_0a[2];
	u32 nav_sum;        /* +0x0c */
	u8  nav_avg;        /* +0x10 */
};
static_assert(__builtin_offsetof(struct pct_stats, nav_avg) == 0x10, "pct_stats");
#define g_pct_stats (*(volatile struct pct_stats *)0x80426c)

/* Период усреднения в BI минус 1 (байт 0x803c1c). */
#define g_pct_period FW_GLOBAL(u8, 0x803c1c)

/* Таблица перевода RSSI → SNR. */
#define SNR_LUT ((void *)0x805170)

extern "C" {
u32  sysapi_mgr__stats_lut_find_index(void *lut, u32 value);
void mac_tx_cnt__get_u64_14(void);
void mac_rx_cnt__get_u64_bc(void);
void sys_state__broadcast_16(void);
/* 64-битное деление прошивки (вход с r4 = 0 — без учёта знака); частное. */
unsigned long long fw_divmod64_signed(unsigned long long num, unsigned long long den);
}

/* value·100 / whole с округлением; 64 бита, как в 6.2. */
static u32 pct_of(u32 value, u32 whole)
{
	return (u32)fw_divmod64_signed((unsigned long long)value * 100 + (whole >> 1), whole);
}

static void mac_mon_print(const struct mac_mon_report *r)
{
	const u32 h = FWLOG_HDR(FWLOG_MOD_MAC_MON, FWLOG_LVL_INFO);

	fw_log_emit3(h, MSG64_MM_BTI, r->bti_start_hi, r->bti_start_lo, r->bti_duration);
	fw_log_emit3(h, MSG64_MM_BCON, r->tx_bcon, r->rx_bcon, r->bcon_detected);
	fw_log_emit2(h, MSG64_MM_SNR, r->snr_valid, r->snr);
	fw_log_emit2(h, MSG64_MM_BCON_BITMAP, r->bcon_bitmap_hi, r->bcon_bitmap_lo);
	fw_log_emit3(h, MSG64_MM_AW, r->aw_start_hi, r->aw_start_lo, r->aw_duration);
	fw_log_emit3(h, MSG64_MM_AW_ATIM_RX, r->aw_backoff, r->rx_atim, r->bcons_atim_fail_vec);
	fw_log_emit3(h, MSG64_MM_AW_ATIM_TX, r->tx_atim_pass, r->tx_atim_fail, r->tx_atim_counter);
	fw_log_emit3(h, MSG64_MM_DTI, r->dti_start_hi, r->dti_start_lo, r->dti_duration);
	fw_log_emit3(h, MSG64_MM_DTI_NAV, r->nav_accumulator, r->dti_backoff, r->cf_end);
	fw_log_emit3(h, MSG64_MM_DTI_TX_RTS, r->tx_rts, r->rx_cts, r->rx_dts);
	fw_log_emit3(h, MSG64_MM_DTI_RX_RTS, r->rx_rts, r->tx_cts, r->tx_dts);
	fw_log_emit3(h, MSG64_MM_DTI_KA, r->ka_pass, r->ka_fail, r->rx_off_duration);
}

#ifdef FW64_MESH
extern "C" void ibss_peer__age(void);
#endif

extern "C" void lmac_if__update_pct_stats(void)
{
	volatile struct mac_mon_report *rep = &g_mac_mon_report;
	volatile struct pct_stats *st = &g_pct_stats;

	fw_log_ucode_evt(MSG64_UCODE_MAC_MONITOR_EVT, UCODE_EVT_MAC_MONITOR);
#ifdef FW64_MESH
	ibss_peer__age();       /* уход соседа по ячейке (new/ibss_tsf.cpp) */
#endif

	if ((u8)rep->rssi_valid) {
		rep->snr = sysapi_mgr__stats_lut_find_index(SNR_LUT, rep->rssi);
		rep->snr_valid = 1;
	}

	struct mac_mon_report snap;
	__builtin_memcpy(&snap, (const void *)rep, sizeof(snap));

	u32 avail = rep->dti_duration - (rep->dti_x50 + rep->rx_off_duration);
	if (avail) {
		u32 nav = pct_of(rep->nav_accumulator, avail);
		u32 busy = pct_of(rep->dti_busy, avail);
		u32 busy_sum = busy + st->busy_sum;

		st->busy_pct = busy;
		st->nav_pct = nav;
		st->nav_sum += nav;
		st->busy_sum = busy_sum;

		u32 n = st->count;
		if (n < (u32)g_pct_period + 1) {
			st->count = n + 1;
		} else {
			st->busy_avg = busy_sum / n;
			st->nav_avg = st->nav_sum / n;
			st->busy_sum = 0;
			st->nav_sum = 0;
			st->count = 1;
		}
	}

	mac_mon_print(&snap);

	mac_tx_cnt__get_u64_14();
	mac_rx_cnt__get_u64_bc();
	sys_state__broadcast_16();
}
