// SPDX-License-Identifier: AGPL-3.0-or-later
/* link_stats__calc_goodput — PER передачи за отчётный период (6.2: 0x8c5468,
 * 76 байт).  Имя дерева неточно: функция считает долю неуспешных передач.
 *
 * Единственный вызывающий — link_stats__report, на каждом отчёте.  Берёт
 * счётчики успешных и неуспешных передач MAC, запоминает их в статистике
 * соединения и возвращает PER = неуспешные · 100 / все за период (или
 * 0xffffffff, если передач не было) и число передач.
 *
 * Возвращено из 4.1: поотчётные строки «### LINK STATS» — отсрочки маяка по
 * NAV, keep-alive и принятые RTS в TXOP.  Строку Neighbor Beacon вернуть
 * нельзя: в 6.2 счётчика соседних маяков нет, его место в общем блоке занял
 * код ассерта ucode.
 */
#include "fw.h"
#include "strings-fw.h"

/* Статистика соединения (только поля, которые трогает функция). */
struct link_stats {
	u8  unknown_00[0x2c];
	u32 tx_ok;       /* +0x2c: счётчик успешных передач на прошлом отчёте */
	u32 tx_fail;     /* +0x30 */
};

enum { PER_NO_TX = 0xffffffff };

/* Общий блок fw ↔ ucode 0x857000 (6.2; в 4.1 смещения другие). */
struct shared_link_counters {
	u32 ka_cnt;          /* +0x00: keep-alive, internal_tx__flow_sm2 */
	u32 ka_fail_cnt;     /* +0x04 */
	u8  unknown_08[0x24];
	u32 rx_txop_rts;     /* +0x2c: RTS, принятые в TXOP (rx_get_required_response) */
	u32 beacon_nav;      /* +0x30: маяк отложен по NAV (развёртка маяка) */
};
static_assert(__builtin_offsetof(struct shared_link_counters, beacon_nav) == 0x30, "0x857030");
#define g_shared_link_counters (*(volatile struct shared_link_counters *)0x857000)

extern "C" {
u32 mac_tx_cnt__get_ok(void);
u32 mac_tx_cnt__get_fail(void);
u32 fw_divmod_unsigned(u32 num, u32 den);
}

static void link_stats__print_counters(void)
{
	const u32 h = FWLOG_HDR(FWLOG_MOD_SYSTEM, FWLOG_LVL_INFO);
	volatile struct shared_link_counters *c = &g_shared_link_counters;

	fw_log_emit1(h, MSG64_LS_NAV, c->beacon_nav);
	fw_log_emit2(h, MSG64_LS_KA, c->ka_cnt, c->ka_fail_cnt);
	fw_log_emit1(h, MSG64_LS_RX_RTS, c->rx_txop_rts);
}

extern "C" void link_stats__calc_goodput(struct link_stats *ls, u32 *per, u32 *total)
{
	u32 ok_prev = ls->tx_ok;
	u32 fail_prev = ls->tx_fail;

	ls->tx_ok = mac_tx_cnt__get_ok();
	ls->tx_fail = mac_tx_cnt__get_fail();

	u32 fail = ls->tx_fail - fail_prev;
	u32 n = (ls->tx_ok - ok_prev) + fail;

	*per = n ? fw_divmod_unsigned(fail * 100, n) : PER_NO_TX;
	*total = n;

	link_stats__print_counters();
}
