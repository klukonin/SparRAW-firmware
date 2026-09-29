// SPDX-License-Identifier: AGPL-3.0-or-later
/* WMI 0x859 WMI_BRP_RF_CHAINS_LIMIT — возвращено из 4.1 (в 6.2 команды нет).
 *
 * 4.1: wmi_handler_brp_rf_chains_limit клал слово тела в общую ячейку
 * 0x857050, ucode при каждом старте BRP (brp__reset_db) брал из неё 6 бит —
 * наибольшую длину списка лучших секторов BRP (по умолчанию 10).  В 6.2 та
 * ячейка занята маской CID для энергосбережения, поэтому значение идёт в
 * свою ячейку (fw_uc_shared.h), а вставляет его ucode brp_init__reset_ctx.
 * Ответного события, как и в 4.1, нет.
 *
 * Вход: запись 0x859 таблицы переходов диспетчера WMI (данные fw 0x802120,
 * патч 0004) ведёт на wmi_branch_0x859 — слот 00 в начале зазора (fw.h).
 * Соглашение веток диспетчера: r13 — тело команды, выход — на общий хвост
 * диспетчера 0x8df070.
 */
#include "fw.h"
#include "fw_uc_shared.h"

#define g_brp_list_len FW_GLOBAL(u32, UC_EXT_DATA_FW(BRP_LIST_LEN_OFS))

extern "C" void wmi_brp_rf_chains_limit(const u32 *body)
{
	g_brp_list_len = BRP_LIST_LEN_VALID | (body[0] & BRP_LIST_LEN_MASK);
}

/* Ветка диспетчера: не функция — в неё прыгают по таблице, кадр стека и
 * blink сохранены диспетчером. */
extern "C" FW_GAP_SLOT("00") void wmi_branch_0x859(void)
{
	__asm__ volatile(
		"1: mov_s r0,r13\n\t"
		"bl wmi_brp_rf_chains_limit\n\t"
		"b L_8df070\n\t"
		".skip 16 - (. - 1b)");   /* слот ровно 16 байт */
}
