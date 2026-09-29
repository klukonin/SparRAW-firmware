// SPDX-License-Identifier: AGPL-3.0-or-later
/* Приём Reassociation Request точкой/PCP (6.4, прошивка apsta;
 * 802.11-2020 9.3.3.7, 9.3.3.8, 11.3.5.5; PICS PC14.5, FR3, FT4).
 *
 * Тело Reassociation Request — как у Association Request, но между Listen
 * Interval и элементами стоит Current AP Address (6 байт, 9.4.1.5).  В 6.2
 * такой кадр не обрабатывался (патч 0009 — отбросить вместо падения).
 * Теперь (патч 0013):
 *  - обёртка разбора сохраняет Current AP Address, переносит элементы на
 *    его место и укорачивает кадр на 6 байт — дальше в буфере ровно
 *    Association Request, и прошивка ведёт обычную ассоциацию (таблица
 *    ветвей rx_pkt_handler: подтип 2 → ветка Assoc Req), а хост получает
 *    элементы станции без мусора;
 *  - ответ получает подтип Reassociation Response (3) вместо 1: вставка
 *    перед построителем заголовка в mgmt_tx__build_assoc_resp_8f9e88.
 * Формат ответа одинаков (9.3.3.6 и 9.3.3.8).
 *
 * Переассоциация станции, уже связанной с этой точкой, пока идёт тем же
 * путём, что повторная ассоциация (автомат mlme_sm рвёт связь).
 */
#include "fw.h"
#include "strings-fw.h"

enum {
	FC_TYPE_MGMT         = 0,
	SUBTYPE_ASSOC_REQ    = 0,
	SUBTYPE_REASSOC_REQ  = 2,
	CURRENT_AP_OFS       = 4,   /* после Capability (2) и Listen Interval (2) */
	CURRENT_AP_LEN       = 6,
	FIXED_ASSOC_REQ_LEN  = 4,
};

/* Не 0 — последний разобранный запрос ассоциации был Reassociation
 * Request, ответ — подтип 3 (читает вставка ниже). */
u32 g_reassoc_last_req;
/* Current AP Address последнего Reassociation Request. */
u8  g_reassoc_current_ap[CURRENT_AP_LEN];

extern "C" u32 rx_mgmt_prs__parse(void *ctx, u8 *body, void *ei, int len, u32 subtype, u32 type);

/* 1 — SME точки на хосте (split MAC, WMI_PCP_START ap_sme_offload_mode). */
#define g_split_mac_en FW_GLOBAL(u8, 0x00803c28)

/* Пакет приёма fw: +0x30 — длина кадра (заголовок + тело). */
enum { PKT_FRAME_LEN = 0x30 };

/* Вызывается вставкой rx_mgmt_prs__parse_reassoc_entry (pkt — r14 места
 * вызова в rx_mgmt_prs__alloc_ei). */
extern "C" u32 rx_mgmt_prs__parse_reassoc(void *ctx, u8 *body, void *ei, int len,
                                          u32 subtype, u32 type, u8 *pkt)
{
	if (type != FC_TYPE_MGMT ||
	    (subtype != SUBTYPE_ASSOC_REQ && subtype != SUBTYPE_REASSOC_REQ))
		return rx_mgmt_prs__parse(ctx, body, ei, len, subtype, type);

	g_reassoc_last_req = subtype == SUBTYPE_REASSOC_REQ;
	/* split MAC: запрос уходит хосту сырым, разбирает и отвечает hostapd */
	if (g_split_mac_en ||
	    subtype == SUBTYPE_ASSOC_REQ || len < FIXED_ASSOC_REQ_LEN + CURRENT_AP_LEN)
		return rx_mgmt_prs__parse(ctx, body, ei, len, subtype, type);

	for (int i = 0; i < CURRENT_AP_LEN; i++)
		g_reassoc_current_ap[i] = body[CURRENT_AP_OFS + i];
	/* Элементы — на место Current AP Address, кадр короче на 6 байт: дальше
	 * и разбор, и событие хосту (тело по [pkt+0x14] длиной [pkt+0x30] − 24),
	 * и сырой кадр видят ровно Association Request. */
	int ies = len - FIXED_ASSOC_REQ_LEN - CURRENT_AP_LEN;
	for (int i = 0; i < ies; i++)
		body[FIXED_ASSOC_REQ_LEN + i] = body[FIXED_ASSOC_REQ_LEN + CURRENT_AP_LEN + i];
	*(volatile u32 *)(pkt + PKT_FRAME_LEN) -= CURRENT_AP_LEN;

	const u8 *a = g_reassoc_current_ap;
	fw_log_emit2(FWLOG_HDR(FWLOG_MOD_BSS, FWLOG_LVL_INFO), MSG64_REASSOC_REQ,
	             (a[0] << 8) | a[1], (a[2] << 24) | (a[3] << 16) | (a[4] << 8) | a[5]);
	return rx_mgmt_prs__parse(ctx, body, ei, len - CURRENT_AP_LEN, SUBTYPE_ASSOC_REQ, type);
}

/* Вход из rx_mgmt_prs__alloc_ei (патч 0013): седьмой аргумент — пакет из r14. */
__asm__(
	"	.section .text.rx_mgmt_prs_parse_reassoc_entry,\"ax\",@progbits\n"
	"	.p2align 2\n"
	"	.global rx_mgmt_prs__parse_reassoc_entry\n"
	"rx_mgmt_prs__parse_reassoc_entry:\n"
	"	b.d rx_mgmt_prs__parse_reassoc\n"
	"	mov r6,r14\n");

/* Вставка перед mgmt_tx__build_mac_header (r2 — подтип кадра): ответ на
 * Reassociation Request — подтип 3, иначе 1.  Меняет только r2. */
__asm__(
	"	.section .text.assoc_resp_mac_header,\"ax\",@progbits\n"
	"	.p2align 2\n"
	"	.global assoc_resp__build_mac_header\n"
	"assoc_resp__build_mac_header:\n"
	"	ld r2,[g_reassoc_last_req]\n"
	"	asl r2,r2,1\n"
	"	b.d L_8d7db8\n"
	"	add r2,r2,1\n");

/* --- Станция: передача Reassociation Request (PICS PC14.4, FT3; 11.3.5.4) ---
 *
 * Хост просит переассоциацию флагом WMI_CONNECT_SEND_REASSOC в WMI_CONNECT
 * (роуминг внутри ESS).  Current AP Address — BSSID предыдущего
 * подключения: при роуминге старая связь уже разорвана, а прошивка помнит,
 * к кому была подключена.  Патч 0014: в mgmt_tx__build_assoc_req подтип
 * заголовка 2 (assoc_req__build_mac_header) и после Capability и Listen
 * Interval — 6 байт адреса (mgmt_tx__assoc_req_fixed_fields_reassoc).
 *
 * g_reassoc_force ≠ 0 (запись с хоста через debugfs mem_write) — то же без
 * флага: отладка, пока драйвер флаг не ставит.
 */
enum { WMI_CONNECT_SEND_REASSOC = 0x02 };

u32 g_reassoc_send;             /* 0/1: текущий запрос — Reassociation Request */
u8  g_reassoc_send_ap[CURRENT_AP_LEN];
u32 g_reassoc_force;
u8  g_reassoc_prev_ap[CURRENT_AP_LEN];
u32 g_reassoc_prev_ap_valid;

extern "C" void reassoc__on_connect(const u8 *bssid, u32 ctrl_flags)
{
	bool want = (ctrl_flags & WMI_CONNECT_SEND_REASSOC) || g_reassoc_force;
	g_reassoc_send = want && g_reassoc_prev_ap_valid;
	if (g_reassoc_send) {
		for (int i = 0; i < CURRENT_AP_LEN; i++)
			g_reassoc_send_ap[i] = g_reassoc_prev_ap[i];
		const u8 *a = g_reassoc_send_ap;
		fw_log_emit2(FWLOG_HDR(FWLOG_MOD_BSS, FWLOG_LVL_INFO), MSG64_REASSOC_SEND,
		             (a[0] << 8) | a[1], (a[2] << 24) | (a[3] << 16) | (a[4] << 8) | a[5]);
	}
	for (int i = 0; i < CURRENT_AP_LEN; i++)
		g_reassoc_prev_ap[i] = bssid[i];
	g_reassoc_prev_ap_valid = 1;
}

extern "C" u32 mgmt_tx__assoc_req_fixed_fields(u8 *p, void *bss, void *conn);

extern "C" u32 mgmt_tx__assoc_req_fixed_fields_reassoc(u8 *p, void *bss, void *conn)
{
	u32 n = mgmt_tx__assoc_req_fixed_fields(p, bss, conn) & 0xffff;
	if (!g_reassoc_send)
		return n;
	for (int i = 0; i < CURRENT_AP_LEN; i++)
		p[n + i] = g_reassoc_send_ap[i];
	return n + CURRENT_AP_LEN;
}

/* Вставка перед mgmt_tx__build_mac_header в mgmt_tx__build_assoc_req:
 * подтип 2 (Reassociation Request) или 0.  Меняет только r2. */
__asm__(
	"	.section .text.assoc_req_mac_header,\"ax\",@progbits\n"
	"	.p2align 2\n"
	"	.global assoc_req__build_mac_header\n"
	"assoc_req__build_mac_header:\n"
	"	ld r2,[g_reassoc_send]\n"
	"	b.d L_8d7db8\n"
	"	asl r2,r2,1\n");
