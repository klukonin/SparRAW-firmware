// SPDX-License-Identifier: AGPL-3.0-or-later
/* bi::decide_beacon_kind — выбор вида маяка и запуск его передачи
 * (ucode, 0x9311a4, 204 байта).
 *
 * Зовут из bi_manager::kind_switch на каждое событие BTI; возвращённый байт
 * состояния тот использует как индекс таблицы переходов по 0x800ed4.
 *
 * Здесь же стоит развилка, ради которой всё и затевалось: передачей маяка
 * занимается ЛИБО развёртка со случайной задержкой
 * (bti_worker::bti_transmitter_beacon_sweep_flow), ЛИБО bti_transmitter_bi2_flow из
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
void bti_transmitter_bi2_flow(struct bi_ctx *ctx);
void bti_worker__bti_transmitter_beacon_sweep_flow(struct bi_ctx *ctx);
}

/* Переменные в памяти данных ucode. g_8005a0 помечен в src/data/uc_data.S;
 * 0x801e68 и 0x801438 лежат за концом образа — это неинициализированная
 * область, туда пишет сама прошивка. */
#define G_8005A0    (*(volatile u32 *)0x008005a0)
#define G_8004E4    (*(volatile u32 *)0x008004e4)
#define BTI_FLAG    (*(volatile u8  *)0x00801e68)
#define BCON_KIND   (*(volatile u32 *)0x00801438)
/* Накопитель цели маяка: 0x801438 + 0x18. Развёртка адресует его как
 * [r13,0x18], где r13 = 0x801438. */
#define BCON_BASE_LO (*(volatile u32 *)0x00801450)
#define BCON_BASE_HI (*(volatile u32 *)0x00801454)

/* Диагностика: раз в BTI писать в журнал фактический ctx->kind. Строку
 * занимаем чужую — своих в таблице образа не добавить, а «[NNL]
 * non_idle_mask: 0x%x» как раз с одним шестнадцатеричным аргументом. */
#ifndef LOG_BEACON_KIND
#define LOG_BEACON_KIND 0
#endif

/* Ради чего всё затевалось.
 *
 * Развёртка маяка вызывается и сейчас (измерено: ctx->kind = 0, бит 30
 * регистра r41 взведён), но случайную задержку она считает только под
 * своим собственным условием, которое стоит у неё в первых инструкциях:
 *
 *     ld r7,[0x801438] ; cmp r7,2 ; bne прочь      — нужен bcon_kind == 2
 *     ld r10,[ctx]     ; cmp r10,0 ; bne прочь     — нужен ctx->kind == 0
 *
 * Второе условие выполняется, первое — нет: bcon_kind равен 1. Поэтому
 * здесь мы подменяем его на 2 РОВНО на время вызова развёртки и сразу
 * возвращаем обратно: то же значение читают ещё три места
 * (bi_ap_mon_if::trig3_aw_or_dti, bi_cfg::tick_counters и мы сами), и
 * менять его насовсем нельзя.
 *
 * Меняет поведение прошивки; откат — передёргивание питания. */
#ifndef FORCE_BEACON_SWEEP
#define FORCE_BEACON_SWEEP 0
#endif

/* FORCE_BEACON_SWEEP оказался бесполезен на железе: при штатной работе
 * ctx->kind равен 1, и развилка ниже уводит управление в
 * bti_transmitter_bi2_flow, мимо развёртки с подменой (проверено
 * 2026-09-25: команда 0x30 не ушла ни разу за 8594 команды, хотя сам
 * перехват работал).  Этот флаг направляет в развёртку И случай kind==1,
 * подменяя bcon_kind на время вызова. */
#ifndef SWEEP_ON_KIND1
#define SWEEP_ON_KIND1 0
#endif

/* Снимать реальный TSF в начале обработки BTI. Отдельным флагом, потому что
 * это первое, что надо проверить: безопасно ли вообще читать время отсюда. */
#ifndef SNAPSHOT_TSF
#define SNAPSHOT_TSF 0
#endif

#ifndef RESYNC_TSF_BASE
#define RESYNC_TSF_BASE 0
#endif
enum { MSG_KIND = 0xa600188c };

enum {
	BTI_PM_CFG      = 0x00801ed0,
	MAC_CMD_BI_A    = 0x0f000001,
	MAC_CMD_BI_B    = 0x1d000300,
	BI_FIELD_MASK   = 0xfffff0ff,
	BI_FIELD_VALUE  = 0x00000300,
	EVT_BIT_BEACON  = 30,          /* бит регистра событий r41 */
	BCON_KIND_SWEEP = 1,           /* при этом виде идёт bti_transmitter_bi2_flow */
	BCON_KIND_RANDOMIZED = 2,      /* только при нём развёртка считает задержку */
};

/* Чтение реального TSF. Делать это надо ЗДЕСЬ, в начале обработки BTI, а не
 * из set_tsf_event: тот вызывается из глубины развёртки, посреди чужой
 * последовательности команд MAC, и чтение оттуда вешает ucode (проверено).
 * Результат кладём на стек — память кода ucode для данных недоступна, а
 * свободного места в его памяти данных нет ни байта (проверено снимком). */
struct tsf64 {
	u32 lo;
	u32 hi;
};
extern "C" void uc_read_tsf64(struct tsf64 *out);
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
	if (SNAPSHOT_TSF || RESYNC_TSF_BASE) {
		struct tsf64 now;
		uc_read_tsf64(&now);
		if (RESYNC_TSF_BASE) {
			/* Развёртка прибавит к накопителю uniform_random << 10,
			 * то есть в среднем ровно BI. Ставим базу на «сейчас», и
			 * цель становится осмысленной: now + 20…183 мс. */
			BCON_BASE_LO = now.lo;
			BCON_BASE_HI = now.hi;
		}
		if (LOG_BEACON_KIND && uclog_enabled(0, 2)) {
			uclog1(MSG_KIND, now.hi);
			uclog1(MSG_KIND, now.lo);
		}
	}

	ctx->kind = kind;
	ctx->result = 5;

	if (LOG_BEACON_KIND && uclog_enabled(0, 2))
		uclog1(MSG_KIND, kind);

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

		/* В оригинале здесь ровно три nop_s. Что именно они выжидают —
		 * не установлено (вероятно, пока команда доедет до MAC и
		 * обновится регистр событий), поэтому воспроизводим как есть:
		 * следующей же строкой читается r41. */
		__asm__ volatile("nop_s\n\tnop_s\n\tnop_s" ::: "memory");

		u32 ev = uc_events2();
		if (LOG_BEACON_KIND && uclog_enabled(0, 2))
			uclog1(MSG_KIND, ev);

		if ((ev >> EVT_BIT_BEACON) & 1) {
			if (ctx->kind != BCON_KIND_SWEEP || SWEEP_ON_KIND1) {
				if (FORCE_BEACON_SWEEP || SWEEP_ON_KIND1) {
					u32 saved = BCON_KIND;
					BCON_KIND = BCON_KIND_RANDOMIZED;
					bti_worker__bti_transmitter_beacon_sweep_flow(ctx);
					BCON_KIND = saved;
				} else {
					bti_worker__bti_transmitter_beacon_sweep_flow(ctx);
				}
			} else
				bti_transmitter_bi2_flow(ctx);
			return ctx->result;
		}
	}

	bti_transmitter_bi2_flow(ctx);
	return ctx->result;
}
