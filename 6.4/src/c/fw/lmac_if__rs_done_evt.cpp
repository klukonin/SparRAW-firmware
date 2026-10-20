// SPDX-License-Identifier: AGPL-3.0-or-later
/* lmac_if__rs_done_evt — обработчик события ucode 0x14 RS_DONE_EVT: поиск
 * скорости для станции закончен (6.2: 0x8dbbe4, 136 байт).
 *
 * Зовёт только диспетчер событий ucode.  Записать результат в журнал,
 * обновить соединение по новому MCS, выставить MCS в регистр bf_mcs
 * (0x880a60, его читают отладочные инструменты хоста) и передать параметры
 * дальше.
 *
 * Возвращено из 4.1: строка события «Ucode->RS_DONE_EVT» диспетчера.
 */
#include "fw.h"
#include "strings-fw.h"

enum {
	UCODE_EVT_RS_DONE = 0x14,
	ASSERT_RS_DONE_NO_CONN = 0x10cb,
	RS_DONE_BODY_OFS = 0x20,     /* тело события в сообщении */
};

/* Тело события RS_DONE (16 байт). */
struct rs_done_evt {
	u32 unknown_00[2];
	u32 status;        /* +0x08: 0 — успешно */
	u8  cid;           /* +0x0c */
	u8  mcs;           /* +0x0d */
	u8  unknown_0e[2];
};
static_assert(sizeof(struct rs_done_evt) == 16, "rs_done_evt");

/* Регистр bf_mcs: текущий MCS после поиска скорости. */
#define REG_BF_MCS (*(volatile u32 *)0x880a60)

/* "RS DONE: CID=%d MCS:%d" */
enum { MSG_RS_DONE = 0x01003fac, MSG_UNKNOWN_RS_END = 0x01003fc4 };

extern "C" {
void *memcpy_fw(void *dst, const void *src, u32 len);
void *conn_mgr__by_cid(u32 cid);
void conn__update_bf_id_on_rs_done(void *conn, u32 mcs);
void lmac_if__rs_done_noop_hook(struct rs_done_evt *evt, void *conn);
void lmac_if__rs_done_params(void *conn_rs, void *msg);
}

extern "C" void lmac_if__rs_done_evt(u8 *msg)
{
	struct rs_done_evt evt;

	fw_log_ucode_evt(MSG64_UCODE_RS_DONE_EVT, UCODE_EVT_RS_DONE);

	memcpy_fw(&evt, msg + RS_DONE_BODY_OFS, sizeof(evt));
	if (evt.status == 0)
		fw_log_emit2(FWLOG_HDR(FWLOG_MOD_SYSTEM, FWLOG_LVL_INFO), MSG_RS_DONE,
		             evt.cid, evt.mcs);
	else
		fw_log_emit0(FWLOG_HDR(FWLOG_MOD_SYSTEM, FWLOG_LVL_WARN), MSG_UNKNOWN_RS_END);

	u8 *conn = (u8 *)conn_mgr__by_cid(evt.cid);
	if (!conn)
		fw_sysassert_fatal(__builtin_return_address(0), ASSERT_RS_DONE_NO_CONN);

	if (evt.status == 0)
		conn__update_bf_id_on_rs_done(conn, evt.mcs);
	REG_BF_MCS = evt.mcs;
	lmac_if__rs_done_noop_hook(&evt, conn);
	lmac_if__rs_done_params(conn + 0x70, msg);
}
