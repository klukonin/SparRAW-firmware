// SPDX-License-Identifier: AGPL-3.0-or-later
/* wmi_connect — WMI_CONNECT (0x1): подключение станции (6.2: 0x8ec434, 80 байт).
 *
 * Проверяет канал (validate_connect); при отказе сообщает хосту
 * WMI_DISCONNECT (протокольная причина 1, причина WMI 6).  Иначе подключение
 * одним лучом (l2_mgr__connect_setup + l2_mgr__connect) или, если включено,
 * несколькими направленными omni (l2_mgr__connect_multi_omni).
 *
 * Прошивка apsta (FW64_APSTA): подключение к инфраструктурной сети и к PBSS
 * (тип P2P); ADHOC и прочие типы отвергаются тем же сообщением хосту.  Флаг
 * WMI_CONNECT_SEND_REASSOC — запрос уйдёт Reassociation Request'ом
 * (new/reassoc.cpp).
 * Прошивка mesh (FW64_MESH): подключения станции нет вовсе — только DMG IBSS,
 * вход в ячейку через WMI_PCP_START (ADHOC).
 */
#include "fw.h"
#include "strings-fw.h"

/* Тело WMI_CONNECT (wmi.h: struct wmi_connect_cmd), только нужные поля. */
struct wmi_connect_cmd {
	u8 network_type;          /* +0x00: WMI_NETTYPE_* */
	u8 unknown_01[0x27];
	u8 channel;               /* +0x28 */
	u8 edmg_channel;          /* +0x29 */
	u8 bssid[6];              /* +0x2a */
	u32 ctrl_flags;           /* +0x30: WMI_CONNECT_* */
};
static_assert(__builtin_offsetof(struct wmi_connect_cmd, bssid) == 0x2a, "connect+0x2a");
static_assert(__builtin_offsetof(struct wmi_connect_cmd, ctrl_flags) == 0x30, "connect+0x30");

enum {
	WMI_NETTYPE_INFRA = 0x01,
	WMI_NETTYPE_P2P   = 0x20,     /* PBSS */
	CONNECT_FAIL_PROTO_REASON = 1,
	CONNECT_FAIL_WMI_REASON = 6,
};

/* Число команд WMI_CONNECT ([gp-0xb8]). */
#define g_connect_count   FW_GLOBAL(u32, 0x8000cc)
/* Способ подключения ([gp+0xad]): 1 — одним лучом, иначе — multi-omni. */
#define g_connect_mode    FW_GLOBAL(u8, 0x800231)
enum { CONNECT_MODE_SINGLE = 1 };

extern "C" {
int  validate_connect(u32 mid, u32 channel);
void l2_mgr__connect_setup(struct wmi_connect_cmd *cmd, u32 mid);
void l2_mgr__connect(struct wmi_connect_cmd *cmd, u32 mid);
void l2_mgr__connect_multi_omni(struct wmi_connect_cmd *cmd, u32 mid);
void l2mgr__send_disconnect_evt(const u8 *bssid, u32 proto_reason, u32 wmi_reason, u32 mid);
#ifdef FW64_APSTA
void reassoc__on_connect(const u8 *bssid, u32 ctrl_flags);
#endif
#ifdef FW64_FIX
void sta_bi__apply(const u8 *bssid);
#endif
}

extern "C" void wmi_connect(struct wmi_connect_cmd *cmd, u32 mid)
{
	g_connect_count = g_connect_count + 1;

#ifdef FW64_APSTA
	if (cmd->network_type != WMI_NETTYPE_INFRA && cmd->network_type != WMI_NETTYPE_P2P) {
		fw_log_emit1(FWLOG_HDR(FWLOG_MOD_BSS, FWLOG_LVL_ERR), MSG64_APSTA_CONNECT_REFUSED,
		             cmd->network_type);
		l2mgr__send_disconnect_evt(cmd->bssid, CONNECT_FAIL_PROTO_REASON,
		                           CONNECT_FAIL_WMI_REASON, mid);
		return;
	}
#endif
#ifdef FW64_MESH
	/* прошивка mesh: только DMG IBSS, а в ячейку входят через WMI_PCP_START */
	fw_log_emit1(FWLOG_HDR(FWLOG_MOD_BSS, FWLOG_LVL_ERR), MSG64_MESH_CONNECT_REFUSED,
	             cmd->network_type);
	l2mgr__send_disconnect_evt(cmd->bssid, CONNECT_FAIL_PROTO_REASON,
	                           CONNECT_FAIL_WMI_REASON, mid);
	return;
#endif

	if (!validate_connect(mid, cmd->channel)) {
		l2mgr__send_disconnect_evt(cmd->bssid, CONNECT_FAIL_PROTO_REASON,
		                           CONNECT_FAIL_WMI_REASON, mid);
		return;
	}
#ifdef FW64_APSTA
	/* переассоциация (флаг WMI_CONNECT_SEND_REASSOC): new/reassoc.cpp */
	reassoc__on_connect(cmd->bssid, cmd->ctrl_flags);
#endif
#ifdef FW64_FIX
	/* 6.2-fix: интервал маяка станции — из маяка выбранной точки, а не из
	 * команды хоста 0x803 (new/sta_bi.cpp).  В 6.4 то же делает драйвер
	 * (патч 914). */
	sta_bi__apply(cmd->bssid);
#endif
	if (g_connect_mode == CONNECT_MODE_SINGLE) {
		l2_mgr__connect_setup(cmd, mid);
		l2_mgr__connect(cmd, mid);
	} else {
		l2_mgr__connect_multi_omni(cmd, mid);
	}
}
