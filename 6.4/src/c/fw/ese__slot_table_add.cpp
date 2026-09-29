// SPDX-License-Identifier: AGPL-3.0-or-later
/* ese__slot_table_add — добавить запись слота в таблицу расписания узла
 * (6.2: 0x8e1d38, 64 байта).  Зовут ese__alloc_to_slot (ESE из маяка точки,
 * аллокации, где узел — источник или назначение) и
 * schedule__build_allocation_entry (своё расписание от хоста, WMI 0xa01).
 *
 * Таблица — 3 записи по 12 байт: больше ucode не обслуживает.  В 6.2 четвёртая
 * своя аллокация — фатальная ошибка 0x11bb (а без неё запись шла бы за край
 * таблицы), то есть чужая точка с богатым расписанием роняла станцию.
 * 6.4: лишняя аллокация не планируется, в журнал — предупреждение; узел
 * остаётся в сети и пропускает эти SP.  По 802.11-2020 10.39.6.2 назначению
 * SP быть в приёме лишь рекомендовано (should), а источник обязан (shall)
 * начать обмен — для SP, где узел источник, это остаётся отклонением.
 */
#include "fw.h"
#include "strings-fw.h"

enum {
	ESE_SLOTS_MAX   = 3,
	ESE_SLOT_SIZE   = 12,
};

struct ese_slot_table {
	u8 unknown_0;
	u8 count;               /* +1 */
	u8 unknown_2[2];
	u8 slot[ESE_SLOTS_MAX][ESE_SLOT_SIZE];   /* +4: байт 0 — ID и тип аллокации */
};

struct ese_sched {
	u32 unknown_0;
	struct ese_slot_table *table;   /* +4 */
};

extern "C" void memcpy_fw(void *dst, const void *src, u32 len);

extern "C" void ese__slot_table_add(struct ese_sched *s, const u8 *slot)
{
	struct ese_slot_table *t = s->table;
	if (t->count >= ESE_SLOTS_MAX) {
		fw_log_emit2(FWLOG_HDR(FWLOG_MOD_BSS, FWLOG_LVL_WARN), MSG64_ESE_SLOT_DROPPED,
		             t->count, slot[0]);
		return;
	}
	memcpy_fw(t->slot[t->count], slot, ESE_SLOT_SIZE);
	t->count++;
}
