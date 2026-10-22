// SPDX-License-Identifier: AGPL-3.0-or-later
/* Базовые утилиты uCode: memset, списки, таймеры. */
#include "../include/types.h"
#include "../include/arc.h"
#include "../include/hw.h"


/* ---- Выдержки по часам ядра ----
 * Прежде выдержки задавались циклом nop (lp K × 2×nop_s = 2K тактов): длительность росла на время
 * каждого прерывания внутри цикла и зависела от формы цикла. Здесь время берётся из счётчика
 * тактов ядра Timer1 (AUX 0x100 COUNT1, 165 МГц: 1 мкс = 165 тактов; частота сверена с эфиром —
 * период SSW 2626 тактов = TXTIME 14,91 + SBIFS 1,01 мкс, замер на стенде).
 *
 * COUNT1 не монотонен: его обнуляют обработчик тика таймера 0 (l1_task_entry, режим 3) и
 * сторож L2 (l2_handle_watchdog), mac_mode_switch_sequence перезапускает таймер, а при пределе
 * 0x13ab6680 счётчик сам заворачивается в 0. Поэтому прошедшее время накапливается по шагам:
 * если новое значение меньше прежнего, был сброс и засчитывается только отсчёт от нуля (now).
 * Каждый шаг не больше истинного времени — сумма никогда не опережает реальное время, выдержка
 * может только удлиниться (на время до сброса), но не укоротиться. */
u32 uc_clk_now(void)
{
    u32 v;
    __asm__ volatile("lr %0,[0x100]" : "=r"(v) :: "memory");   /* COUNT1; барьер: MMIO-запись до старта */
    return v;
}

/* Тактов с *last (с учётом сброса/заворота COUNT1, см. выше); *last := сейчас. */
u32 uc_clk_since(u32 *last)
{
    u32 now = uc_clk_now();
    u32 d = (now >= *last) ? now - *last : now;
    *last = now;
    return d;
}

/* Выдержка не меньше clk тактов ядра. Безопасный выход: не больше clk проходов цикла — проход
 * занимает не меньше 1 такта, значит и при остановленном или испорченном Timer1 выдержка
 * всё равно не короче clk тактов, а цикл конечен (не дольше clk проходов ≈ 10·clk тактов). */
void uc_delay_clk(u32 clk)
{
    u32 last = uc_clk_now();
    u32 el = 0;
    for (u32 n = clk; el < clk && n != 0; n--)
        el += uc_clk_since(&last);
}

/* Обнуление памяти (0x920a84) — len в байтах; остаток (len&3) добиваем
 * побайтово (vendor-путь для невыровненной длины). */
/* memset0_words_uc — в mem.c (скорость важна для таймингов MAC). */

/* Сортированная вставка в список таймеров (0x92e788). */

/* Вставка в приоритетный список uc (0x920a00). */
void uc_list_insert_by_prio(u32 obj)
{
    timer_list_insert_sorted(obj, ((const struct init_desc *)obj)->prio, 0);
}

/* Инициализация списка таймеров (0x9209e0). */
void timer_list_init(void)
{
    u32 r13 = timer_list_head[0];
    timer_list_head[0] = 0;
    while (r13 != 0) {
        u32 fn = ((const struct init_desc *)r13)->fn;
        ((void (*)(u32, u32))fn)(fn, (u32)timer_list_head); /* jl_s [r0]: r0 = обработчик, r1 = 0x8017b8 */
        r13 = ((const struct init_desc *)r13)->next;
    }
}

/* Копирование памяти uc (0x920330). */
/* memcpy_uc — в mem.c. */

u32 popcount8(u32 a)
{
    u32 n = 0;
    for (u32 i = 0; i < 8; i++)
        n += (a >> i) & 1;
    return n;
}

u32 rng_rand_below(u32 a)
{
    /* 0x936de0: a < 2 — сырое значение ГСЧ; иначе старшее слово r0*a (равномерно в [0,a)). */
    u32 r0 = MMIO32(HW_RNG_VALUE);
    if (a < 2)
        return r0;
    return (u32)(((u64)r0 * a) >> 32);
}

/* СРОК: пауза 1600 тактов ≈ 9,7 мкс перед fixed_sched_run_tx_slot (станция в фиксированном
 * расписании: после принятого кадра AP — свой TX, вызов из l1_fixed_sched_sta_sm). Схема не из
 * 802.11 (9,7 мкс + путь — не SIFS/MBIFS), что ждёт пауза, не установлено — длительность как у
 * vendor 0x938a64 (lp 0x320 × 2×nop_s), но по часам ядра (uc_delay_clk). Изменение сдвигает начало
 * слота TX относительно события L1. */
void delay_800_iters(void)
{
    /* 6.2 asm 0x938a64. */
    uc_delay_clk(0x320 * 2);    /* vendor: lp 0x320 × 2×nop_s */
    mac_set_sector_arg_and_select_all(rx_resp_dur);
    fixed_sched_run_tx_slot();
}

u32 get_mem_857744_x2(void)
{
    /* 6.2 asm 0x927a34. */
    return FWSH(fwsh_sets, fsched_tbl)->assoc_slot_us;
}

u32 rss_wait_get(u32 a)
{
    return rss_wait_clk[a];
}

void evt_queue_noop_lock_hook(void)
{
}

void bg_task_call_cb20(struct rx_meas_ctx *m)
{
    u32 cb = m->report_cb;
    if (cb != 0)
        ((void (*)(struct rx_meas_ctx *, u32))cb)(m, cb);   /* vendor: r0 = m, r1 = cb */
}

u32 vring_is_empty_uc_quiet(u32 a)
{
    /* 6.2 asm 0x926298 (→0x92a6fc): r14/r13 = vring head/tail. */
    u32 r14 = *(u32 *)((((a << 8) + 0x440c0c0) >> 3) & ~3u);
    u32 r13 = *(u32 *)((((a << 8) + 0x440c100) >> 3) & ~3u);
    return (r14 == r13) ? 1 : 0;
}

s32 rx_funcs_record_level_8020f8_8020fc(u32 a)
{
    /* 6.2 asm 0x922168: уровень (s8, шаг 4) -> peer_snr, own_snr = порог,
     * link_snr = min(порог, уровень) (знаковое сравнение). */
    s32 r0 = (s8)(((s32)a >> 2) + 0x13);
    s32 thr = (s8)sls.best.snr_db;
    bf_rep.peer_snr = (s8)r0;
    bf_rep.own_snr = (s8)thr;
    r0 = thr < r0 ? thr : r0;
    bf_rep.link_snr = r0;
    return r0;
}

void clk_gate_880b00(u32 a)
{
    u32 r3 = MMIO32(HW_CLKS_CTL_SW_CLK_VEC_3);
    if (a == 0)
        r3 &= ~0x1b0u;
    else
        r3 |= 0x1b0u;
    MMIO32(HW_CLKS_CTL_SW_CLK_VEC_3) = r3;
}

void basic_sm_bind_descriptor_uc(struct sm_obj *a, const struct sm_desc *b)
{
    a->state = b->init_state;
    a->desc = b;
    a->prev = 0xff;
    a->active = 0;
}

void obj_vt801adc_ctor(struct sm_obj *a)
{
    basic_sm_bind_descriptor_uc(a, &bi_sm_desc);
    a->active = 1;
}

/* Сдвиг текущей записи кольца с переходом через конец. */
void buf_check_bounds(struct uc_ring *r)
{
    struct mbox_ring_desc *next = r->cur + 1;
    struct mbox_ring_desc *end = r->end;
    if (end < next) {                           /* 0x92ac90: один assert и перечитывание, без цикла */
        uc_assert((u32)__builtin_return_address(0), 0xcc);
        end = r->end;
    }
    if (next == end)
        r->cur = r->base;
    else
        r->cur = next;
}


void rx_flow_latch_phy_8014e8_930da4(void)
{
    u32 r0 = phy_read_signal_gain_adc_db_sfd_locked();
    if (r0 > 0x3f)
        r0 = 0;
    sel_nbr.cur_gain_db = (u8)r0;
}

void ucode_cmd_load_table_803124_803128_920b1c(u32 a, u32 b)
{
    (void)a;
    /* L_920b38..L_920b48: st r11/r10/r9 -> 0x803128/0x80312c/0x803130 (глобалы,
     * читаются в bti.c/rx.c), затем stw 0 -> 0x803124. */
    const struct lmac_cmd_bi_tbl *c = (const void *)b;
    abft_cfg.responder_mode = c->responder_mode;
    abft_cfg.beacon_type = c->beacon_type;
    abft_cfg.relax_period = c->relax_word;
    abft_cfg.relax_cnt = 0;
}

void internal_tx_isr(void);   /* tail.c */
