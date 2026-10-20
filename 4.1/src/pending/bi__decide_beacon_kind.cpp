// SPDX-License-Identifier: AGPL-3.0-or-later
/* bi::decide_beacon_kind — выбор вида маяка и запуск его передачи
 * (ucode, 0x9311a4, 204 байта).
 *
 * Зовут из bi_manager::kind_switch на каждое событие BTI; возвращённый байт
 * состояния тот использует как индекс таблицы переходов по 0x800ed4.
 *
 * Здесь же стоит развилка, ради которой всё и затевалось: передачей маяка
 * занимается ЛИБО развёртка со случайной задержкой
 * (bti_worker::bti_transmitter_beacon_sweep_flow), ЛИБО sub_923c74 из
 * bf_gpc_service, который аппаратный компаратор TSF не трогает вовсе.
 * Развёртка берётся только при ctx->kind != 1, а в режиме AP/PCP kind
 * всегда 1 — измерено пробой в set_tsf_event.
 *
 * Этот файл — ПОКА ТОЧНАЯ КОПИЯ оригинала. Сначала надо доказать, что
 * переписан он верно (маяк продолжает ходить, линк живой), и только потом
 * менять развилку.
 */
#include "uc.h"

struct bi_ctx {
	u32 kind;     /* +0x00: вид маяка, он же условие развилки */
	u8  result;   /* +0x04: код возврата, индекс таблицы в kind_switch */
};

extern "C" {
void uc_tx__is_idle(void);
void perform_bti_pm_cfg(u32 cfg, u32 arg1);
void sub_923c74(struct bi_ctx *ctx);
void bti_worker__bti_transmitter_beacon_sweep_flow(struct bi_ctx *ctx);
}

/* Переменные в памяти данных ucode. g_8005a0 помечен в src/data/uc_data.S;
 * 0x801e68 и 0x801438 лежат за концом образа — это неинициализированная
 * область, туда пишет сама прошивка. */
#define G_8005A0    (*(volatile u32 *)0x008005a0)
#define G_8004E4    (*(volatile u32 *)0x008004e4)
#define BTI_FLAG    (*(volatile u8  *)0x00801e68)
#define BCON_KIND   (*(volatile u32 *)0x00801438)

enum {
	BTI_PM_CFG      = 0x00801ed0,
	MAC_CMD_BI_A    = 0x0f000001,
	MAC_CMD_BI_B    = 0x1d000300,
	BI_FIELD_MASK   = 0xfffff0ff,
	BI_FIELD_VALUE  = 0x00000300,
	EVT_BIT_BEACON  = 30,          /* бит регистра событий r41 */
	BCON_KIND_SWEEP = 1,           /* при этом виде идёт sub_923c74 */
};

/* r41 — второй регистр состояния событий ucode (первый, r42, опрашивает
 * uc_sleep_until_event). */
static inline u32 uc_events2(void)
{
	u32 v;
	__asm__ volatile("mov %0,r41" : "=r"(v));
	return v;
}

extern "C" u32 bi__decide_beacon_kind(struct bi_ctx *ctx, u32 kind)
{
	ctx->kind = kind;
	ctx->result = 5;

	if (kind == 0) {
		BTI_FLAG = 1;
		kind = ctx->kind;
	}

	if (kind != 0) {
		G_8005A0 = 1;
	} else {
		uc_tx__is_idle();
		perform_bti_pm_cfg(BTI_PM_CFG, G_8005A0);
		G_8005A0 = 0;
	}

	if (BCON_KIND != 0) {
		mac_cmd(MAC_CMD_BI_A);

		u32 f = G_8004E4 & BI_FIELD_MASK;
		G_8004E4 = f | BI_FIELD_VALUE;
		mac_cmd(f | MAC_CMD_BI_B);

		if ((uc_events2() >> EVT_BIT_BEACON) & 1) {
			if (ctx->kind != BCON_KIND_SWEEP)
				bti_worker__bti_transmitter_beacon_sweep_flow(ctx);
			else
				sub_923c74(ctx);
			return ctx->result;
		}
	}

	sub_923c74(ctx);
	return ctx->result;
}
