// SPDX-License-Identifier: AGPL-3.0-or-later
/* Соединение (conn), объект автомата basic_sm и режим безролевого линка
 * (fw 6.2).  Раскладка conn — по connection__init 0x8f54a4, сверено с 4.1
 * 0x8ed290; объект автомата — по basic_sm__do_transition 0x8ca2d0.
 */
#ifndef WIL6210_FW62_CONN_H
#define WIL6210_FW62_CONN_H

#include "fw.h"
#ifdef FW64_MESH
#include "ibss.h"
#endif

/* Описатель интерфейса (mid), только нужное: режим BSS в bss.mode (mid+0x50). */
struct mid;

/* Соединение с соседом.  Только известные поля. */
struct conn {
	u8   unknown_00[0x08];
	u8   cid;                 /* +0x08 */
	u8   unknown_09[0x0f];
	struct mid *mid;          /* +0x18 */
	u8   peer_mac[6];         /* +0x1c */
	u8   unknown_22[2];
	u32  following_connect;   /* +0x24: 1 — после linkup сразу OWN_ASSOC */
	u32  direct_pbss;         /* +0x28: «прямой член PBSS» — ассоциация без обмена Assoc-кадрами */
	u8   unknown_2c[0x44];
	u8   lm_if[0x80];         /* +0x70 */
	u8   mlme_sm[0x34];       /* +0xf0: автомат MLME */
	u8   conn_msm[0x40];      /* +0x124: главный автомат соединения */
};
static_assert(__builtin_offsetof(struct conn, following_connect) == 0x24, "conn+0x24");
static_assert(__builtin_offsetof(struct conn, direct_pbss) == 0x28, "conn+0x28");
static_assert(__builtin_offsetof(struct conn, lm_if) == 0x70, "conn+0x70");
static_assert(__builtin_offsetof(struct conn, mlme_sm) == 0xf0, "conn+0xf0");
static_assert(__builtin_offsetof(struct conn, conn_msm) == 0x124, "conn+0x124");

/* Объект автомата basic_sm.  Только известные поля. */
struct basic_sm {
	u8   state;               /* +0x00 */
	u8   last_evt;            /* +0x01 */
	u8   pending_evt;         /* +0x02: 0xff — нет */
	u8   trace;               /* +0x03 */
	void *desc;               /* +0x04 */
	struct conn *parent;      /* +0x08 */
	u8   unknown_0c[0x28];
	u32  lm_started_pending;  /* +0x34 */
	u32  lm_started;          /* +0x38 */
};
static_assert(__builtin_offsetof(struct basic_sm, lm_started) == 0x38, "sm+0x38");

/* События и состояния conn_main_sm (описатель 0x802744). */
enum {
	CONN_SM_EVT_OWN_ASSOC = 3,
	CONN_SM_READY_FOR_ASSOC = 3,
	MLME_EVT_ASSOC_REQUEST = 0,
	MLME_EVT_ASSOC_RESPONSE = 4,
};

enum { BSS_MODE_STA = 1 };

static inline u32 mid_bss_mode(const struct mid *m)
{
	return *(const volatile u32 *)((const u8 *)m + 0x50);
}

#ifdef __cplusplus
extern "C" {
#endif
/* Отложить событие автомату (выполнится после текущего перехода). */
void sm__defer_call(struct basic_sm *sm, u32 evt, u32 a2, u32 a3, u32 a4);
/* Подать событие автомату. */
void basic_sm__handle_event(void *sm, u32 evt, u32 a2, u32 a3, u32 a4);

/* Безролевой линк (6.4): включён хостом флагом в WMI_PCP_START. */
extern u32 g_roleless_link;
#ifdef __cplusplus
}
#endif

/* Режим OOB R1 (параметр драйвера oob_mode=1): открыт путь Discovery A-BFT. */
#define g_oob_r1 FW_GLOBAL(u32, 0x803c0c)

/* Сделать соединение, только что прошедшее A-BFT, прямым членом PBSS:
 * ассоциация пройдёт без обмена Assoc-кадрами (путь вендора «Direct
 * Connection», WMI_PBSS_JOINED).  Условия: включён безролевой линк, OOB R1,
 * linkup успешен, соединение не от штатного connect, узел — PCP/AP. */

/* Безролевой путь включён: безролевой линк с хоста (флаг WMI_PCP_START и
 * режим OOB) либо член DMG IBSS (прошивка mesh): в IBSS ассоциации нет, и
 * соединение после SLS в DTI (802.11-2020 10.42.6) становится прямым. */
static inline bool roleless_enabled(void)
{
#ifdef FW64_MESH
	if (g_ibss)
		return true;
#endif
	return g_roleless_link && g_oob_r1;
}

static inline bool roleless_adopt(struct conn *c, u32 status)
{
	if (!roleless_enabled() || status != 0 || c->following_connect)
		return false;
	u32 mode = mid_bss_mode(c->mid);
	if (mode != BSS_MODE_PBSS && mode != BSS_MODE_AP)
		return false;
	c->following_connect = 1;
	c->direct_pbss = 1;
	return true;
}

#endif
