// SPDX-License-Identifier: AGPL-3.0-or-later
/* lmac_if__post_cmd — отправить команду в ucode (LMAC) (6.2: 0x8e5204, 84 байта).
 *
 * Общая точка отправки всех команд fw → ucode: тело команды ставится в
 * очередь из пула 0x804280, затем звонок ucode записью 1 в 0x886dd8.  До
 * готовности ucode отправка — фатальная ошибка 0x1046.  В 4.1 это
 * send_cmd2_lmac.
 *
 * Возвращено из 4.1: запись в журнал о каждой команде с текущим TSF
 * (в 6.2 её нет).
 */
#include "fw.h"
#include "strings-fw.h"

/* Готовность канала команд в ucode ([gp+0x244]): 1 — можно слать. */
#define g_lmac_if_ready FW_GLOBAL(u32, 0x8003c8)

/* Пул записей очереди fw → ucode. */
#define LMAC_CMD_POOL ((void *)0x804280)

/* Звонок ucode: запись 1 — в очереди новая команда. */
#define LMAC_CMD_DOORBELL (*(volatile u32 *)0x886dd8)

enum { ASSERT_LMAC_NOT_READY = 0x1046 };

extern "C" void wmi_evt__build_and_post(void *pool, void *body, u32 type, u32 a3,
                                        u32 len, u32 flags, u32 a6, u32 a7, u32 a8);

extern "C" void lmac_if__post_cmd(void *body, u32 type, u32 len, u32 flags)
{
	if (g_lmac_if_ready != 1)
		fw_sysassert_fatal(__builtin_return_address(0), ASSERT_LMAC_NOT_READY);

	u32 tsf[2];
	mac_read_tsf64(0, tsf, 0);
	fw_log_emit3(FWLOG_HDR(FWLOG_MOD_SYSTEM, FWLOG_LVL_INFO), MSG64_SEND_CMD2_LMAC,
	             type, tsf[1], tsf[0]);

	wmi_evt__build_and_post(LMAC_CMD_POOL, body, type, 0, len, flags, 0, 0, 0);
	LMAC_CMD_DOORBELL = 1;
	__asm__ volatile("sync" ::: "memory");
}
