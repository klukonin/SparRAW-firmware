// SPDX-License-Identifier: AGPL-3.0-or-later
/* rs_start — запустить поиск скорости (rate search) для станции (ucode 6.2).
 *
 * Зовут обработчики команд ucode 0x12, 0x13, 0x30 и sta__apply_bf_result
 * (после beamforming).  Сбросить состояние поиска станции, выбрать стартовый
 * MCS — ближайший поддерживаемый ниже прежнего, а если такого нет, первый
 * поддерживаемый, — записать его в журнал и применить к передаче.  Станции
 * с флагом RS_STA_FLAG_FINISH_NOW поиск тут же завершается через rs_end.
 *
 * Возвращает 1, если поиск запущен, 0 — если станция не подходит.
 */
#include "uc.h"

enum {
	RS_MAX_STATIONS = 8,     /* cid 0..7; 8 — «нет станции» */
	RS_ASSERT_ALREADY_RUNNING = 0x66,
};

/* Состояние поиска скорости станции: 0x802670 + cid * 0x2c. */
struct rs_sta {
	u8  unknown_00[0x1a];
	u8  unknown_1a;         /* +0x1a: rs_end при не 0 — sysassert 0x131b */
	u8  unknown_1b;
	u8  next_tx_mcs;        /* +0x1c: MCS, с которого начинается поиск */
	u8  tx_mcs;             /* +0x1d: текущий MCS передачи (rate_search__apply_mcs) */
	u8  last_mcs;           /* +0x1e: MCS прошлого поиска */
	u8  active;             /* +0x1f */
	u8  unknown_20[4];
	u8  stats[8];           /* +0x24: счётчики текущего шага поиска */
};
static_assert(sizeof(struct rs_sta) == 0x2c, "rs_sta");

/* Управление поиском станции: 0x802610 + cid * 12. */
struct rs_ctl {
	u32 running;            /* +0: поиск идёт */
	u32 unknown_04;
	u32 unknown_08;
};
static_assert(sizeof(struct rs_ctl) == 12, "rs_ctl");

#define rs_sta_table       ((struct rs_sta *)0x00802670)
#define rs_ctl_table       ((struct rs_ctl *)0x00802610)
/* Сколько раз для станции запускался поиск. */
#define rs_start_count     ((volatile u32 *)0x00802900)
/* Флаги станции по cid; бит 7 — завершить поиск сразу после запуска. */
#define rs_sta_flags       ((volatile u8 *)0x008006ac)
enum { RS_STA_FLAG_FINISH_NOW = 0x80 };
/* Маска станций, чей поиск ждёт завершения в rs_end ([gp-0x4]). */
#define g_rs_pending_mask  UC_GLOBAL(u32, 0x00800524)

/* "rs_start cid=%d next_tx_mcs:%u" */
enum { MSG_RS_START = 0x01001380 };

extern "C" {
int  rs__is_sta_enabled(u32 cid);
void mac__program_qset_slots(void);
/* Ближайший поддерживаемый станцией MCS ниже from; 0 — нет такого. */
u32  sched_bitmap__prev_set_bit(u32 cid, u32 from);
/* Первый поддерживаемый станцией MCS. */
u32  sched_bitmap__next_set_bit(u32 cid);
void rate_search__apply_mcs(u32 mcs, u32 cid);
void rs_end(void);
}

/* link_byte — байт состояния связи станции (sta_link__byte_by_index, его
 * передаёт sta__apply_bf_result; остальные вызывающие передают 0): при не 0
 * поиск не начинается. */
extern "C" int rs_start(u32 cid, u32 link_byte)
{
	if (cid == RS_MAX_STATIONS || !rs__is_sta_enabled(cid) || link_byte)
		return 0;

	struct rs_ctl *ctl = &rs_ctl_table[cid];
	struct rs_sta *sta = &rs_sta_table[cid];

	if (ctl->running)
		uc_sysassert(__builtin_return_address(0), RS_ASSERT_ALREADY_RUNNING);

	mac__program_qset_slots();
	rs_start_count[cid]++;

	u32 irq = irq_save();
	u8 mcs = sched_bitmap__prev_set_bit(cid, sta->last_mcs);
	memset0_words_uc(sta, sizeof(*sta));
	memset0_words_uc(ctl, sizeof(*ctl));
	ctl->running = 1;
	sta->last_mcs = mcs;
	sta->active = 1;
	if (mcs == 0)
		mcs = sched_bitmap__next_set_bit(cid);
	sta->next_tx_mcs = mcs;
	memset0_words_uc(sta->stats, sizeof(sta->stats));
	irq_restore(irq);

	uc_log__emit2(UCLOG_HDR(UCLOG_MOD_SYSTEM, UCLOG_LVL_INFO), MSG_RS_START,
	              cid, sta->next_tx_mcs);
	rate_search__apply_mcs(sta->next_tx_mcs, cid);

	if (rs_sta_flags[cid] & RS_STA_FLAG_FINISH_NOW) {
		g_rs_pending_mask = 1u << cid;
		ctl->unknown_04 = 1;
		ctl->unknown_08 = 1;
		ctl->running = 0;
		rs_end();
	}
	return 1;
}
