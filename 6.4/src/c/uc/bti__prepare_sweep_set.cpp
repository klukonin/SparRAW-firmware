// SPDX-License-Identifier: AGPL-3.0-or-later
/* bti__prepare_sweep_set — начало BTI: набор секторов и выбор «передавать
 * маяк или слушать» (ucode 6.2: 0x935b9c, 368 байт).
 *
 * Зовёт bti__dispatch_sweep_step по событию автомата BI DTI_TO_BTI (TBTT).
 * Берёт следующий по кругу набор секторов развёртки (диапазоны из
 * board-файла, docs/BF-ENGINE.md §8.5), а затем, если режим маяков включён
 * и в очереди MAC есть маяк, передаёт его развёрткой; иначе слушает BTI
 * чужого узла.  Возвращает байт состояния контекста BTI.
 *
 * Прошивка mesh (DMG IBSS, 802.11-2020 11.1.3.5): перед развёрткой — задержка,
 * равномерная в [0, 2·aCWminDMGIBSS·длительность своего BTI].  Если за это
 * время пришёл DMG Beacon своей IBSS (BSSID совпал), свой BTI отменяется и
 * узел слушает BTI отправителя.  Так маяк в каждом BI уходит от одного-двух
 * членов ячейки, а не от всех сразу (распределённый биконинг, US8520648).
 */
#include "uc.h"
#include "fw_uc_shared.h"

/* Контекст BTI (передаётся всем потокам BTI). */
struct bti_ctx {
	u32 kind;               /* +0x00: 1 — маяк уже принят, развёртка не нужна */
	u8  status;             /* +0x04: итог BTI для диспетчера (0..6) */
};
enum { BTI_STATUS_STARTED = 6 };

/* Номер набора секторов текущего BTI ([gp-0xf7]); по кругу 0..N−1. */
#define g_bti_sweep_set       UC_GLOBAL(u8, 0x00800431)
/* Общий блок с прошивкой: число наборов и указатель на таблицу диапазонов
 * секторов (по 2 байта [первый, последний] на набор). */
#define g_sweep_set_count     UC_GLOBAL(u8, 0x0085773c)
typedef const u8 *sweep_ranges_t;
#define g_sweep_set_ranges    UC_GLOBAL(sweep_ranges_t, 0x008577b0)
/* Роль узла: не 0 (1 — AP/PCP, по tx_ctx__post_status) — номер набора
 * записывается в поле биты 8..22 слова 0x801024 (смысл слова не установлен). */
#define g_uc_role_pcp         UC_GLOBAL(u32, 0x008014c0)
#define g_sweep_set_word      UC_GLOBAL(u32, 0x00801024)
enum { SWEEP_SET_WORD_SHIFT = 8, SWEEP_SET_WORD_MASK = 0x7fffu };

/* Список секторов развёртки: тождественный 0, 1, 2 … с меткой 0xff после
 * последнего сектора набора. */
struct sweep_list {
	u8 unknown_00[8];
	u8 sector[0x40];        /* +0x08 */
	u8 count;               /* +0x48: число секторов набора (позиция метки) */
	u8 set;                 /* +0x49: номер набора */
};
static_assert(__builtin_offsetof(struct sweep_list, count) == 0x48, "sweep_list+0x48");
#define g_sweep_list (*(volatile struct sweep_list *)0x00801694)
enum { SWEEP_LIST_END = 0xff };

/* Сохранённый маяк BTI (0x802f14): байт 0 — «маяк своей BSS принят». */
#define g_bti_rx_bcon_mine    UC_GLOBAL(u8, 0x00802f14)
/* Не 0 — BTI начат с kind ≠ 0 ([gp+0x74]); при kind = 0 сбрасывается. */
#define g_bti_kind_nonzero    UC_GLOBAL(u32, 0x0080059c)
#define g_tx_idle_ctx         ((void *)0x00802f80)

/* Режим маяков (bi_mode, первое слово блока конфигурации BI 0x8022a8). */
#define g_bi_mode             UC_GLOBAL(u32, 0x008022a8)
enum {
	BI_MODE_OFF             = 0,
	BI_TX_DISCOVERY_BCON    = 2,    /* discovery-маяк, 11.1.3.4 */
};

enum {
	MAC_CMD_BTI_START       = 0x0f000001,
	R41_BCON_QUEUED         = 1u << 30,
};

extern "C" {
u32  uc_tx__is_idle(void);
void mac__cmd_0f_step(void *ctx, u32 arg);
void bti_transmitter_bi2_flow(struct bti_ctx *ctx);
void bti_worker__bti_transmitter_beacon_sweep_flow(struct bti_ctx *ctx);
}

#ifdef FW64_MESH
extern "C" {
u32  uc_read_tsf_lo(void);
void gp0__arm_usec(u32 unused, u32 usec);
void gp_timer__stop(u32 timer);
u32  uc_wait_event1_or_event4(u32 ev1_mask, u32 ev4_mask, u32 timeout);
/* Разобрать принятый в BTI кадр (дождаться отчёта PPDU, освободить буфер);
 * при kind = 0 и use_hw = 1 — 1, если это маяк своей BSS (r38 бит 0). */
u32  bti_worker_bi2_step(u32 kind, u32 use_hw);
}

enum {
	A_CW_MIN_DMG_IBSS = 3,      /* aCWminDMGIBSS, 802.11-2020 табл. 11-22 */
	MAC_CMD_EVT_CLEAR_RX = 0x02011000,
};

#define g_ibss_uc (*(volatile struct ibss_uc_state *)UC_EXT_DATA_UC(IBSS_UC_OFS))
#define g_ibss_ctl UC_GLOBAL(u32, UC_EXT_DATA_UC(IBSS_CTL_OFS))

static bool ibss_ctl(u32 flag)
{
	u32 w = g_ibss_ctl;
	return (w & IBSS_CTL_VALID_MASK) == IBSS_CTL_VALID && (w & flag);
}

/* Длительность своего BTI, мкс: последний замер или оценка по умолчанию. */
static u32 ibss_bti_us(void)
{
	u32 w = g_ibss_uc.bti_us;
	if ((w & ~IBSS_BTI_US_MASK) == IBSS_BTI_US_VALID)
		return w & IBSS_BTI_US_MASK;
	return IBSS_BTI_US_DEFAULT;
}

static u32 mac_lfsr(void)
{
	mac_select(MAC_SEL_R47_SHIFT, MAC_SEL_R47_LFSR);
	return UC_READ_REG(r47);
}

/* Случайная задержка маяка 11.1.3.5 b)–d).  true — передавать маяк, false —
 * принят DMG Beacon своей IBSS, свой BTI отменён. */
static bool ibss_beacon_backoff(void)
{
	u32 range = 2 * A_CW_MIN_DMG_IBSS * ibss_bti_us();
	u32 delay = ibss_ctl(IBSS_CTL_NO_DELAY) ? 0 : mul_hi32(mac_lfsr(), range);

	g_ibss_uc.last_delay_us = delay;
	if (!delay)
		return true;

	/* Отсчёт по TSF, а не таймером GP0: GP0..GP2 размечают окна BI (BTI,
	 * A-BFT, AW, DTI), и перевзвод GP0 здесь сдвигал DTI узла — RTS шли
	 * соседу вне его DTI, без CTS, связь уходила в переобучение луча. */
	u32 t0 = uc_read_tsf_lo();
	mac_cmd(MAC_CMD_EVT_CLEAR_RX);
	while (uc_read_tsf_lo() - t0 < delay) {
		if (!(UC_READ_REG(r42) & EV1_RX_FRAME))
			continue;
		if (bti_worker_bi2_step(0, 1))
			return false;
	}
	return true;
}

static void ibss_beacon_sweep(struct bti_ctx *ctx)
{
	if (ibss_ctl(IBSS_CTL_VENDOR_BTI)) {
		bti_worker__bti_transmitter_beacon_sweep_flow(ctx);
		return;
	}
	if (g_bi_mode != BI_TX_DISCOVERY_BCON && !ibss_beacon_backoff()) {
		g_ibss_uc.cancelled++;
		bti_transmitter_bi2_flow(ctx);
		return;
	}

	u32 t0 = uc_read_tsf_lo();
	bti_worker__bti_transmitter_beacon_sweep_flow(ctx);
	u32 bti = uc_read_tsf_lo() - t0;

	g_ibss_uc.sent++;
	if (bti >= IBSS_BTI_US_MIN && bti <= IBSS_BTI_US_MAX)
		g_ibss_uc.bti_us = IBSS_BTI_US_VALID | bti;
}
#endif

extern "C" u32 bti__prepare_sweep_set(struct bti_ctx *ctx, u32 kind)
{
	u32 nsets = g_sweep_set_count;
	u32 set = (u8)(g_bti_sweep_set + 1);

	if (set == nsets)
		set = 0;
	g_bti_sweep_set = set;

	if (g_uc_role_pcp && nsets >= 2)
		g_sweep_set_word = (g_sweep_set_word & ~(SWEEP_SET_WORD_MASK << SWEEP_SET_WORD_SHIFT))
		                 | (set << SWEEP_SET_WORD_SHIFT);

	/* Список секторов набора: вернуть на место прежнюю метку конца, взять
	 * число секторов из таблицы диапазонов и поставить метку за последним. */
	u32 prev = g_sweep_list.count;
	g_sweep_list.sector[prev] = prev;
	const u8 *range = g_sweep_set_ranges + 2 * set;
	u32 count = (u8)(range[1] - range[0] + 1);
	g_sweep_list.count = count;
	g_sweep_list.sector[count] = SWEEP_LIST_END;
	g_sweep_list.set = set;

	ctx->kind = kind;
	ctx->status = BTI_STATUS_STARTED;
	if (!kind) {
		g_bti_rx_bcon_mine = 1;
		uc_tx__is_idle();
		mac__cmd_0f_step(g_tx_idle_ctx, g_bti_kind_nonzero);
		g_bti_kind_nonzero = 0;
	} else {
		g_bti_kind_nonzero = 1;
	}

	bool sweep = false;
	if (g_bi_mode != BI_MODE_OFF) {
		mac_cmd(MAC_CMD_BTI_START);
		mac_select(MAC_SEL_R41_SHIFT, MAC_SEL_R41_BCON_Q);
		sweep = (UC_READ_REG(r41) & R41_BCON_QUEUED) && ctx->kind != 1;
	}

	if (!sweep)
		bti_transmitter_bi2_flow(ctx);
	else
#ifdef FW64_MESH
		ibss_beacon_sweep(ctx);
#else
		bti_worker__bti_transmitter_beacon_sweep_flow(ctx);
#endif
	return ctx->status;
}
