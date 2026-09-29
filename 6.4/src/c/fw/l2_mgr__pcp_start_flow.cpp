// SPDX-License-Identifier: AGPL-3.0-or-later
/* l2_mgr__pcp_start_flow — поднять PCP/AP на интерфейсе (6.2: 0x8e0778, 256 байт).
 *
 * Зовёт l2_mgr__pcp_start (обработка WMI_PCP_START).  Проверить MAC-адрес
 * интерфейса и состояние BSS, настроить первичный канал, режим BSS (AP или
 * PBSS) и параметры из команды, запустить PCP и сделать BSS активным.
 *
 * Возвращает 0 при успехе, 1 — если PCP не запущен.
 *
 * Прошивка apsta (FW64_APSTA): принимаются AP и PBSS (PCP, тип P2P); прочие
 * типы (IBSS) отвергаются — хост получает PCP_STARTED с ошибкой штатным путём.
 * Прошивка mesh (FW64_MESH): принимается только DMG IBSS (ADHOC,
 * ADHOC_CREATOR) — ставится флаг g_ibss (ibss.h).
 *
 * Исправление 6.4: BSS получает интервал маяка из настройки хоста.  В 4.1 и
 * 6.2 в полях интервала BSS оставались 100 TU, и Probe Response сообщал 100
 * при любом beacon_int, хотя DMG Beacon нёс верное значение.
 */
#include "fw.h"
#include "strings-fw.h"
#ifdef FW64_MESH
#include "ibss.h"
#include "fw_uc_shared.h"
#endif

/* Описатель интерфейса (mid); только известные поля. */
struct mid {
	u8  unknown_00[0x0a];
	u8  mac_addr[6];        /* +0x0a */
	u8  unknown_10;         /* +0x10: уходит в RADIO_MGR::set_primary_channel и pcp_start__cancel_timer */
	u8  unknown_11;         /* +0x11: байт +0xd команды WMI_PCP_START (журнал: «max assoc sta») */
	u8  unknown_12[2];
	u32 network_type;       /* +0x14: пишет mid__log_network_type */
	u8  unknown_18[0x30];
	struct bss bss;         /* +0x48 */
	u8  unknown_a4[0x234 - 0x48 - sizeof(struct bss)];
	u8  pcp[0x2a8 - 0x234]; /* +0x234: объект PCP (pcp_start) */
	u32 unknown_2a8;        /* +0x2a8: обнуляется при каждом старте */
};
static_assert(__builtin_offsetof(struct mid, bss) == 0x48, "mid.bss");
static_assert(__builtin_offsetof(struct mid, pcp) == 0x234, "mid.pcp");
static_assert(__builtin_offsetof(struct mid, unknown_2a8) == 0x2a8, "mid+0x2a8");
static_assert(__builtin_offsetof(struct bss, channel) == 0x4c, "bss.channel");
static_assert(__builtin_offsetof(struct bss, bcon_interval_tu) == 0x4e, "bss.bi");
static_assert(__builtin_offsetof(struct bss, is_go) == 0x54, "bss.is_go");
static_assert(__builtin_offsetof(struct bss, unknown_58) == 0x58, "bss+0x58");

/* Настройка PCP из WMI (объект 0x803b80); только известные поля. */
struct pcp_cfg {
	u32 channel;            /* +0x00 */
	u8  unknown_04[0x88];
	u32 dmg_info_flow;      /* +0x8c: не 0 — ветка «PBSS PCP Start DMG Information» */
};
static_assert(__builtin_offsetof(struct pcp_cfg, dmg_info_flow) == 0x8c, "pcp_cfg+0x8c");
#define g_pcp_cfg (*(volatile struct pcp_cfg *)0x803b80)

/* Флаг gp+0x274: не 0 — дописать регистр разборщика MAC 0x886268. */
#define g_8003f8 FW_GLOBAL(u32, 0x8003f8)

/* Типы сети WMI (wmi.h: enum wmi_network_type). */
enum {
	WMI_NETTYPE_AP  = 0x10,
	WMI_NETTYPE_P2P = 0x20,
};

enum {
	MAC_ADDR_GROUP_BIT = 0x01,   /* бит I/G первого октета */
};

/* Строки журнала */
enum {
	MSG_MAC_ADDR_ERROR = 0x0100cd48, /* "PCP Start failed, MAC address error" */
	MSG_HANDLE_CHANNEL = 0x0100cd6c, /* "PCP Start handle channel id %d  bcon_interval_msec %d networkType = %x" */
	MSG_DMG_INFO_FLOW  = 0x0100cdb4, /* "PBSS PCP Start DMG Information flow start networkType = %d WMI_NETTYPE_P2P = %d. " */
	MSG_BSS_NOT_READY  = 0x0100ce08, /* "PCP Start failed, BSS not ready or channel is not valid bss_mode: %d, bss_state:%d, channel:%d " */
};

extern "C" {
void mid__log_network_type(struct mid *mid, u32 network_type);
void RADIO_MGR__set_primary_channel(u32 channel, u32 a1, u32 a2, u32 bcon_interval,
                                    u32 a4, u32 a5);
void pcp_start(void *pcp);
void field_set_0x58__8e6788(struct bss *bss, u32 value);
void pcp_start__cancel_timer(u32 idx);
void mac_parser__set_886260(u32 index, u32 value);
}

extern "C" FW_TEXT_GAP int l2_mgr__pcp_start_flow(struct mid *mid, u32 network_type, u32 cmd_0d,
                                      u32 cmd_10, u32 is_go, u32 abft_len)
{
	mid->unknown_2a8 = 0;

	if (mid->mac_addr[0] & MAC_ADDR_GROUP_BIT) {
		fw_log_emit0(FWLOG_HDR(FWLOG_MOD_BSS, FWLOG_LVL_ERR), MSG_MAC_ADDR_ERROR);
		return 1;
	}

#ifdef FW64_APSTA
	/* прошивка apsta: AP и PBSS (PCP); IBSS и прочие режимы недоступны */
	if (network_type != WMI_NETTYPE_AP && network_type != WMI_NETTYPE_P2P) {
		fw_log_emit1(FWLOG_HDR(FWLOG_MOD_BSS, FWLOG_LVL_ERR), MSG64_APSTA_PCP_REFUSED,
		             network_type);
		return 1;
	}
#endif
#ifdef FW64_MESH
	/* прошивка mesh: только DMG IBSS (ADHOC — присоединиться, ADHOC_CREATOR —
	 * создать); режим BSS остаётся PCP, отличия IBSS включает g_ibss */
	if (!nettype_is_ibss(network_type)) {
		fw_log_emit1(FWLOG_HDR(FWLOG_MOD_BSS, FWLOG_LVL_ERR), MSG64_MESH_PCP_REFUSED,
		             network_type);
		return 1;
	}
	g_ibss = 1;
	/* состояние задержки маяка в ucode (fw_uc_shared.h): BTI не измерен,
	 * счётчики с нуля */
	{
		volatile u32 *st = (volatile u32 *)UC_EXT_DATA_FW(IBSS_UC_OFS);
		for (u32 i = 0; i < sizeof(struct ibss_uc_state) / 4; i++)
			st[i] = 0;
	}
	fw_log_emit1(FWLOG_HDR(FWLOG_MOD_BSS, FWLOG_LVL_INFO), MSG64_MESH_IBSS_START,
	             network_type);
	/* BSSID ячейки (11.1.4.4): задан хостом командой 0x85a до старта;
	 * иначе остаётся собственный MAC, как у PCP */
	if (g_ibss_bssid_valid)
		l2mgr__apply_mac_address(&mid->bss, g_ibss_bssid);
#endif

	mid__log_network_type(mid, network_type);
	mid->unknown_11 = cmd_0d;

	struct bss *bss = &mid->bss;
	u32 channel = g_pcp_cfg.channel;

	if (bss->state == BSS_STATE_ACTIVE) {
		fw_log_emit3(FWLOG_HDR(FWLOG_MOD_BSS, FWLOG_LVL_ERR), MSG_BSS_NOT_READY,
		             bss->mode, bss->state, channel);
		return 1;
	}

	fw_log_emit3(FWLOG_HDR(FWLOG_MOD_BSS, FWLOG_LVL_INFO), MSG_HANDLE_CHANNEL,
	             channel, g_bcon_interval_tu, network_type);
	RADIO_MGR__set_primary_channel(channel, 0, 0, g_bcon_interval_tu, 0, mid->unknown_10);
	bss->channel = channel;

	/* 802.11-2020 9.4.1.3 и 11.1.3.3.1: интервал маяка входит в DMG Beacon,
	 * Announce и Probe Response, и станция при входе в BSS обязана его
	 * принять — поэтому в Probe Response он должен быть настоящим.  Поле BSS копирует в Probe Response mgmt_tx__copy_ie_hdr. */
	bss->bcon_interval_tu = g_bcon_interval_tu;
	bss->bcon_interval2_tu = g_bcon_interval_tu;
	fw_log_emit1(FWLOG_HDR(FWLOG_MOD_BSS, FWLOG_LVL_INFO), MSG64_BCON_INTERVAL_PUBLISHED,
	             bss->bcon_interval_tu);

	bss_set_mode(bss, network_type == WMI_NETTYPE_AP ? BSS_MODE_AP : BSS_MODE_PBSS);
	bss->is_go = is_go;
	bss->abft_len = abft_len;
	pcp_start(mid->pcp);
	field_set_0x58__8e6788(bss, cmd_10);

	if (g_pcp_cfg.dmg_info_flow) {
		fw_log_emit2(FWLOG_HDR(FWLOG_MOD_BSS, FWLOG_LVL_INFO), MSG_DMG_INFO_FLOW,
		             network_type, WMI_NETTYPE_P2P);
		if (network_type == WMI_NETTYPE_P2P)
			pcp_start__cancel_timer(mid->unknown_10);
	}

	bss_set_active(bss);

	if (g_8003f8)
		mac_parser__set_886260(2, 0x3f02);
	return 0;
}
