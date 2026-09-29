// SPDX-License-Identifier: AGPL-3.0-or-later
/* Переассоциация уже связанной станции «на месте» (6.4, прошивка apsta;
 * 802.11-2020 11.3.5.5 a), j), l), o), p)).
 *
 * В 6.2 (Re)Association Request от станции, уже связанной с точкой (mlme_sm
 * в ASSOCIATED), шёл событием EVT_CONNECT в mlme_sm__disconnect_ev_handle:
 * точка слала Disassociation и рвала связь.  Теперь (патч 0015):
 *  - запрос перехватывается в rx_pkt_handler (rx_pkt__mlme_event вместо
 *    basic_sm__handle_event для EVT_CONNECT);
 *  - точка сразу отвечает успехом тем же AID (построитель 8f9e88: на
 *    Reassociation Request — подтип 3), связь, кольца и BF не трогаются;
 *  - после ACK ответа (11.3.5.5 l): ключ станции снимается (j), в
 *    защищённой сети автоматы возвращаются к «ассоциирована, ждём ключ» и
 *    взводится таймер ассоциации — hostapd проведёт новый 4-way (n), по
 *    новому ключу снова придёт WMI_RING_EN_EVENT; хост получает
 *    WMI_CONNECT_EVENT для того же CID (o), драйвер сбрасывает
 *    переупорядочивание, PN и BA (p — то, что по 11.3.5.4 c) сбрасывает
 *    станция).
 * Включает драйвер командой WMI 0x85b, если знает об этом (бит возможности
 * 28): со стоковым драйвером снятый ключ и открытый порт пустили бы данные
 * открытым текстом, поэтому по умолчанию выключено — штатный путь.
 */
#include "fw.h"
#include "strings-fw.h"

enum {
	/* соединение (conn) */
	CONN_CID        = 0x08,
	CONN_MID        = 0x18,
	CONN_MLME       = 0xf0,         /* объект mlme_sm */
	CONN_STATUS     = 0x118,        /* статус ответа (mlme_sm +0x28) */
	CONN_MAIN_SM    = 0x124,        /* состояние conn_main_sm */
	/* объект mlme_sm */
	MLME_TIMER      = 0x14,
	MLME_REQ        = 0x2c,         /* сохранённый кадр запроса */
	/* пакет приёма */
	PKT_EI          = 0x0c,
	/* mid */
	MID_ID          = 0x10,
	/* состояния */
	MLME_ASSOCIATE  = 1,
	MLME_ASSOCIATED = 2,
	CMS_ASSOCIATED  = 5,
	CMS_KEY_ASSOC   = 7,
	MLME_EVT_CONNECT = 0,
	/* отправка ответа — как mlme_sm_802458__action_8c5cfc */
	TX_A1 = 0, TX_A2 = 1, TX_A5 = 7, TX_A6 = 0x50, TX_OP_ASSOC_RESP = 4,
	KEY_CLASS_PTK   = 1,
	KEY_LEN         = 16,
	FW_CODE_WINDOW  = 0x8c0000,     /* указатели на код в fw — от окна исполнения */
};

/* Таймаут ассоциации, мс (ставит его штатный путь в 8c5cfc). */
#define g_assoc_timeout_ms FW_GLOBAL(u32, 0x008002e4)

u32 g_reassoc_inplace_en;

extern "C" {
extern u32 g_reassoc_last_req;
void  basic_sm__handle_event(void *sm, u32 ev, void *a2, u32 a3, u32 a4);
void *TX_API__alloc_tx_payload(void);
void  mgmt_tx__build_assoc_resp_8f9e88(void *buf, u32 *len, void *mid, void *conn);
void  tx_api__send_mgmt_with_cb(void *conn, u32 a1, u32 a2, void *buf, u32 len,
                                u32 a5, u32 a6, u32 cb, u32 tx_op);
void  mgmt_pkt__release(void *pkt);
void  mem_pool__free_thunk(void *p);
void  TX_API__post_tx_payload(void *buf, u32 mid_id);
void  TX_API__free_memory(void *buf);
void  install_key_index_stub(u32 cid, u32 key_class, const u8 *key, u32 a3, u32 a4);
u32   conn__sec_mode_not_1(void *conn);
u32   u_schd__schedule(u32 fn, void *arg, u32 a2, u32 a3, u32 usec, u32 a5, u32 a6);
void  l2mgr__send_host_event(u32 mid_id, u32 cid);
void  mlme__assoc_timeout_cb(void);
u32   reassoc_inplace__tx_done(void *buf, u32 tx_status, u8 *conn);
}

template <typename T> static inline volatile T &fld(void *p, u32 ofs) { return *(volatile T *)((u8 *)p + ofs); }

static bool reassoc_inplace__start(u8 *conn, u8 *pkt)
{
	u8 *ctx = conn + CONN_MLME;
	void *mid = fld<void *>(conn, CONN_MID);

	fld<u16>(conn, CONN_STATUS) = 0;
	void *buf = TX_API__alloc_tx_payload();
	u32 len = 0;
	mgmt_tx__build_assoc_resp_8f9e88(buf, &len, mid, conn);

	/* запрос хранится до ACK: его тело уйдёт хосту в WMI_CONNECT_EVENT */
	mgmt_pkt__release(pkt);
	if (fld<void *>(ctx, MLME_REQ))
		mem_pool__free_thunk(fld<void *>(ctx, MLME_REQ));
	fld<void *>(ctx, MLME_REQ) = pkt;

	fw_log_emit2(FWLOG_HDR(FWLOG_MOD_BSS, FWLOG_LVL_INFO), MSG64_REASSOC_INPLACE,
	             conn[CONN_CID], g_reassoc_last_req);
	tx_api__send_mgmt_with_cb(conn, TX_A1, TX_A2, buf, len & 0xffff, TX_A5, TX_A6,
	                          (u32)reassoc_inplace__tx_done - FW_CODE_WINDOW,
	                          TX_OP_ASSOC_RESP);
	return true;
}

/* Колбэк TX ответа: (буфер, статус — 0 при ACK, conn). */
extern "C" u32 reassoc_inplace__tx_done(void *buf, u32 tx_status, u8 *conn)
{
	u8 *ctx = conn + CONN_MLME;
	u8 *mid = fld<u8 *>(conn, CONN_MID);
	u32 cid = conn[CONN_CID];

	if (tx_status == 0)
		TX_API__post_tx_payload(buf, mid[MID_ID]);
	else
		TX_API__free_memory(buf);

	/* нет ACK или состояние уже ушло (разрыв идёт) — ничего не менять */
	if (tx_status != 0 || ctx[0] != MLME_ASSOCIATED ||
	    (conn[CONN_MAIN_SM] != CMS_ASSOCIATED && conn[CONN_MAIN_SM] != CMS_KEY_ASSOC)) {
		fw_log_emit2(FWLOG_HDR(FWLOG_MOD_BSS, FWLOG_LVL_WARN), MSG64_REASSOC_INPLACE_TXFAIL,
		             cid, tx_status);
		if (fld<void *>(ctx, MLME_REQ)) {
			mem_pool__free_thunk(fld<void *>(ctx, MLME_REQ));
			fld<void *>(ctx, MLME_REQ) = 0;
		}
		return 0;
	}

	static const u8 zero_key[KEY_LEN] = {};
	install_key_index_stub(cid, KEY_CLASS_PTK, zero_key, 0, 0);
	if (conn__sec_mode_not_1(conn)) {
		/* RSNA: состояние 3 до нового 4-way; по ключу автоматы пройдут
		 * «ключ → порт открыт» заново */
		conn[CONN_MAIN_SM] = CMS_ASSOCIATED;
		ctx[0] = MLME_ASSOCIATE;
		if (!fld<u32>(ctx, MLME_TIMER))
			fld<u32>(ctx, MLME_TIMER) =
				u_schd__schedule((u32)mlme__assoc_timeout_cb - FW_CODE_WINDOW, ctx,
				                 0, 1, g_assoc_timeout_ms * 1000, 0, 0);
	}
	l2mgr__send_host_event(mid[MID_ID], cid);
	return 0;
}

/* Вместо basic_sm__handle_event в rx_pkt_handler (патч 0015). */
extern "C" void rx_pkt__mlme_event(u8 *ctx, u32 ev, void *pkt, u32 a3, u32 a4)
{
	u8 *conn = ctx - CONN_MLME;
	if (ev == MLME_EVT_CONNECT && g_reassoc_inplace_en && pkt &&
	    ctx[0] == MLME_ASSOCIATED &&
	    (conn[CONN_MAIN_SM] == CMS_ASSOCIATED || conn[CONN_MAIN_SM] == CMS_KEY_ASSOC) &&
	    reassoc_inplace__start(conn, (u8 *)pkt))
		return;
	basic_sm__handle_event(ctx, ev, pkt, a3, a4);
}

/* WMI 0x85b REASSOC_INPLACE_CFG (6.4): {u8 enable, u8 reserved[3]}. */
struct wmi_reassoc_inplace_cfg_cmd {
	u8 enable;
	u8 reserved[3];
};

extern "C" void wmi_reassoc_inplace_cfg(const struct wmi_reassoc_inplace_cfg_cmd *cmd)
{
	g_reassoc_inplace_en = cmd->enable != 0;
	fw_log_emit1(FWLOG_HDR(FWLOG_MOD_BSS, FWLOG_LVL_INFO), MSG64_REASSOC_INPLACE_CFG,
	             g_reassoc_inplace_en);
}

/* Ветка диспетчера WMI (r13 — тело команды), выход — общий хвост 0x8df070;
 * запись 0x85b таблицы переходов (патч 0015) ведёт в слот 02 зазора. */
extern "C" FW_GAP_SLOT("02") void wmi_branch_0x85b(void)
{
	__asm__ volatile(
		"1: mov_s r0,r13\n\t"
		"bl wmi_reassoc_inplace_cfg\n\t"
		"b L_8df070\n\t"
		".skip 16 - (. - 1b)");
}
