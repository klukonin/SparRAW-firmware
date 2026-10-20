// SPDX-License-Identifier: AGPL-3.0-or-later
/* link_stats__phy_counters — счётчики PHY в сводке LINK_STATS (6.2: 0x8d27d8,
 * 28 байт).
 *
 * Единственный вызывающий — link_stats__report, раз в 100 отчётов (ветка
 * сводки MCS0_FRAMES_CRC / GOODPUT).  6.2 печатает здесь только ошибки CRC
 * заголовка (PHY_ERROR_CP/DP).
 *
 * Возвращено из 4.1 (строки 1:1): PPDU_REP_CNT / CCA2_TO_CCA3 /
 * HANDLED_PPDUS, ложные тревоги в TXOP и вне его, счётчики INA sync и
 * SFD sync.  Исправлены две ошибки 4.1: PHY_INA_SYNC_DP читал тот же регистр,
 * что CP, а PHY_SFD_SYNC_* — регистры SFD timeout.
 */
#include "fw.h"
#include "strings-fw.h"

#define PHY_REG(a) (*(volatile u32 *)(a))
/* Счётчики приёма PHY (карта ref/REGS-62.md). */
#define PHY_INA_SYNC_CP   PHY_REG(0x8839a0)
#define PHY_INA_SYNC_DP   PHY_REG(0x883964)
#define PHY_SFD_SYNC_CP   PHY_REG(0x8839a4)
#define PHY_SFD_SYNC_SC   PHY_REG(0x883968)
#define PHY_CRC_ERROR_CP  PHY_REG(0x8839b4)
#define PHY_CRC_ERROR_SC  PHY_REG(0x883978)

/* Регистр состояния MAC: бит 3 — занятость; биты 8..13 и 16..21 4.1
 * печатала как PPDU_REP_CNT и CCA2_TO_CCA3 (в 6.2 их никто не читает —
 * смысл перенесён из 4.1 по тому же кремнию). */
#define MAC_BUSY_STATUS   PHY_REG(0x886ecc)

/* Счётчик обработанных PPDU: зеркало ucode rx_flow__run (в 4.1 — 0x857048). */
#define g_handled_ppdus   FW_GLOBAL(u32, 0x857034)

/* Ложные тревоги PHY (в 4.1 — 0x854d84): общий счётчик и по видам — в TXOP
 * и вне его, Control PHY / Data PHY / «AD». */
struct false_alarms {
	u32 total_fa;       /* +0x00 */
	u32 in_txop_cp;     /* +0x04 */
	u32 in_txop_dp;     /* +0x08 */
	u32 in_txop_ad;     /* +0x0c */
	u32 out_txop_cp;    /* +0x10 */
	u32 out_txop_dp;    /* +0x14 */
	u32 out_txop_ad;    /* +0x18 */
};
#define g_false_alarms (*(volatile struct false_alarms *)0x853924)

/* "LINK_STATS PHY_ERROR_CP=%d PHY_ERROR_DP=%d" */
enum { MSG_LS_PHY_ERROR = 0x0101db34 };

static u32 bits(u32 v, u32 shift, u32 width)
{
	return (v >> shift) & ((1u << width) - 1);
}

extern "C" void link_stats__phy_counters(void)
{
	const u32 h = FWLOG_HDR(FWLOG_MOD_SYSTEM, FWLOG_LVL_INFO);
	volatile struct false_alarms *fa = &g_false_alarms;
	u32 mac = MAC_BUSY_STATUS;

	fw_log_emit3(h, MSG64_LS_PPDU, bits(mac, 8, 6), bits(mac, 16, 6), g_handled_ppdus);
	fw_log_emit3(h, MSG64_LS_FA_IN, fa->in_txop_ad, fa->in_txop_cp, fa->in_txop_dp);
	fw_log_emit3(h, MSG64_LS_FA_OUT, fa->out_txop_ad, fa->out_txop_cp, fa->out_txop_dp);
	fw_log_emit2(h, MSG64_LS_INA_SYNC, PHY_INA_SYNC_CP, PHY_INA_SYNC_DP);
	fw_log_emit2(h, MSG64_LS_SFD_SYNC, PHY_SFD_SYNC_CP, PHY_SFD_SYNC_SC);

	fw_log_emit2(h, MSG_LS_PHY_ERROR, PHY_CRC_ERROR_CP, PHY_CRC_ERROR_SC);
}
