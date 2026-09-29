// SPDX-License-Identifier: AGPL-3.0-or-later
/* WMI 0x85a IBSS_BSSID (6.4, прошивка mesh) — BSSID ячейки DMG IBSS.
 *
 * WMI_PCP_START не несёт BSSID, а IBSS по стандарту (11.1.4.4) создаётся со
 * случайным локально администрируемым BSSID, и присоединяющийся берёт BSSID
 * существующей ячейки.  Драйвер присылает его этой командой перед
 * WMI_PCP_START; l2_mgr__pcp_start_flow применяет его при старте ячейки.
 * Ответного события нет.
 *
 * Вход: запись 0x85a таблицы переходов диспетчера WMI (данные fw 0x802122,
 * патч 0005) → wmi_branch_0x85a, слот 01 зазора (fw.h).
 */
#include "ibss.h"
#include "strings-fw.h"

/* Тело команды. */
struct wmi_ibss_bssid_cmd {
	u8 bssid[6];
	u8 reserved[2];
};

extern "C" void wmi_ibss_set_bssid(const struct wmi_ibss_bssid_cmd *cmd)
{
	for (int i = 0; i < 6; i++)
		g_ibss_bssid[i] = cmd->bssid[i];
	g_ibss_bssid_valid = 1;
	fw_log_emit2(FWLOG_HDR(FWLOG_MOD_BSS, FWLOG_LVL_INFO), MSG64_IBSS_BSSID,
	             (cmd->bssid[0] << 8) | cmd->bssid[1],
	             (cmd->bssid[2] << 24) | (cmd->bssid[3] << 16) |
	             (cmd->bssid[4] << 8) | cmd->bssid[5]);
}

/* Ветка диспетчера (r13 — тело команды), выход — общий хвост 0x8df070. */
extern "C" FW_GAP_SLOT("01") void wmi_branch_0x85a(void)
{
	__asm__ volatile(
		"1: mov_s r0,r13\n\t"
		"bl wmi_ibss_set_bssid\n\t"
		"b L_8df070\n\t"
		".skip 16 - (. - 1b)");   /* слот ровно 16 байт */
}
