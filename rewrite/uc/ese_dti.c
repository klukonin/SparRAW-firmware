/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Доступ к среде по расписанию DTI (802.11-2020 10.39.4, 10.39.5, 10.39.6.2): станция — по ESE своей точки, точка —
 * по своему строгому TDMA (fw/tdma.c, docs/TDMA.md).
 *
 * При CBAP Only = 0 DTI распределён Extended Schedule: узел может инициировать обмен только в CBAP, где ему это
 * разрешено, и в своих SP как источник; вне них — молчать (в SP, где он назначение, — только отвечать). Vendor 6.2
 * доступ расписанием не ограничивал: вне окон он закрывал кольца хоста, а в SP, где станция только назначение, кольцо
 * к пиру открывал — станция инициировала обмен в чужом SP (стенд 2026-10-23, запись ToA: под iperf вверх станция
 * передаёт плотнее всего именно в SP точки).
 *
 * Таблица окон:
 *  - станция: ese_slot_tbl — fw по каждому маяку своей точки (fwsh_diag.ese_dti_sched, fw/rx.c ese_rx_on_own_beacon)
 *    оставляет в ней только разрешённые окна и SP, где станция назначение, и ставит в записи б7 «инициировать можно»;
 *  - точка (строгий TDMA): ese_own_tbl, только окна, где точка начинает обмен (общее CBAP, SP точка → станция), с
 *    маской получателей (peer_cid); признак — ese_slot_tbl.mode = ESE_TBL_MODE_OWN (fw/tdma.c tdma_own_apply).
 * Аппаратный массив SP даёт события начала и конца записей (dti_worker_scheduled_dti_allocation_event, uc/tail.c).
 *
 * Рычаги:
 *  1. Пауза передачи пира (bf_pause_sta_tx / bf_resume_sta_tx): маска причин на станцию (tx_dis_mask), очереди пира
 *     убираются из опубликованных масок qset и возвращаются, только когда снята последняя причина. BF — причина 3,
 *     расписание — своя причина 8: гонки с запретом на время BF нет. Мгновенные ответы (Ack, BlockAck, DMG CTS) идут
 *     мимо очередей — роль назначения в SP сохраняется. У точки в окне открыты только очереди получателей окна.
 *  2. Проверка перед доступом (ese_dti_tx_gate, tx_slot_dispatch): события массива SP сливаются (конец окна и начало
 *     соседнего через Tguard), очереди без пауз (внутренняя, широковещательная точки) маски не закрывают — поэтому на
 *     каждом доступе к среде: начинать обмен можно только внутри своего окна и только если TXOP (лимит MAC) кончится
 *     до конца окна (10.39.6.2: «In no case … beyond the end of the SP»; 10.39.5: обмен в CBAP — до его конца). Иначе
 *     отказ (как «нет очереди»), а лимит TXOP урезается до остатка окна — следующий доступ уложится; на начало окна
 *     лимит возвращается.
 *  3. Цикл источника в своём SP (10.39.6.2; docs/TDMA.md §2.3): в SP право на среду у источника по расписанию, TXOP
 *     CBAP (10.23.2) не нужен. Доступ — без RTS (получатель «should be in the receive state» весь SP и слушает
 *     источник — рычаг 4), обмен — кадр → ответ через SIFS → следующий кадр (продолжение MAC), конец обмена — без
 *     CF-End: CF-End в SP — усечение SP (10.39.8.1), у наших SP Truncatable = 0. Следующий доступ в своём SP — сразу,
 *     без отсрочки EDCA (ese_dti_sp_src_cycle): кадр после неудачи уходит не раньше срока ответа (> PIFS — «may
 *     retransmit … PIFS after», 10.39.6.2), обмен — не за конец SP (проверка доступа, рычаг 2). Первый доступ — на
 *     начале своего SP («shall initiate … at the start of the SP»), не по отсрочке MAC.
 *  4. Наведение приёма назначения SP на источник: в SP, где узел — назначение (станция — SP точки к ней из ESE,
 *     точка — SP станции к ней, следующий за своим SP к этой станции: rx_tail_us записи своей таблицы), приём
 *     слушает источник его направленным сектором (sta_tab[].rx_sel), а не квази-omni простоя — без RTS иначе нечем
 *     навести приём под первый PPDU (стенд, docs/MAC-STAND.md «Режим доступа очереди данных»).
 * Только при расписании: без него, у точки без строгого TDMA и при фиксированном расписании vendor (dti_qset_mode) —
 * ничего не делается. Порт 6.4 (uc/new/ese_dti.cpp) + строгий TDMA точки. */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/sta_max.h"
#include "ifs.h"

#define ESE_PAUSE_REASON  8u

/* Хвост окна, который TXOP не занимает (такты 165 МГц, вверх до мкс): от проверки до начала TXOP — ожидание
 * границы слота (mac_select_all_sectors_and_wait, ≤ aSlotTime) и путь uc до пуска (≤ aSlotTime: событие слота →
 * 0x19 — 437 тактов по модели стоимости, 531 на стенде, test_uc_deadlines); после плана MAC — ответ на последний
 * кадр TXOP: SIFS + TXTIME(BlockAck 32 октета, Control PHY — худший MCS ответа; стенд: BlockAck последнего A-MPDU
 * кончается на ~3,5 мкс позже горизонта MAC, docs/MAC-STAND.md «NAV RTS и TBTT»). */
#define ESE_BA_LEN          32u
#define ESE_TXOP_TAIL_US    DMG_CLK_TO_US_CEIL(2u * DMG_SLOT_CLK + DMG_SIFS_CLK + DMG_CTRL_TXTIME_CLK(ESE_BA_LEN))
_Static_assert(ESE_TXOP_TAIL_US == 32u, "хвост окна: 2·aSlotTime + SIFS + TXTIME(BlockAck)");
/* Запас урезанного лимита на ожидание следующего доступа: AIFS + CWmin·aSlotTime класса AC_BE по умолчанию
 * (Table 9-155: AIFSN 3, CWmin 15) — следующая попытка после отказа приходит не позже, иначе урезание повторяется. */
#define ESE_TXOP_RETRY_US   (3u + 3u * DMG_SLOT_US + 15u * DMG_SLOT_US)
_Static_assert(ESE_TXOP_RETRY_US == 93u, "AIFS + CWmin·aSlotTime (AC_BE)");
/* Наименьший урезанный лимит: при остатке плана MAC ≤ 0x30 мкс uc TXOP не открывает (txop_initiator_open_txop_flow) */
#define ESE_TXOP_MIN_US     0x31u

/* Таблица окон этого узла: своя таблица точки (строгий TDMA) или таблица ESE станции / хоста. */
static inline volatile ese_tbl_t *ese_dti_tbl(void)
{
    return FWSH(ese_slot_tbl, mode) == ESE_TBL_MODE_OWN ? &ese_own_tbl : &ese_slot_tbl;
}

static inline u32 ese_dti_tbl_cap(const volatile ese_tbl_t *t)
{
    return t == &ese_own_tbl ? ESE_OWN_SLOTS_N : ESE_SLOTS_N;
}

static u32 ese_dti_scheduled(void)
{
    if (dti_qset_mode != 0)
        return 0;
    if (uc_role_ap == 1)
        return FWSH(ese_slot_tbl, mode) == ESE_TBL_MODE_OWN;
    return FWSH(fwsh_diag, ese_dti_sched) != 0;
}

/* Передача пиров из mask открыта, остальных — на паузе (причина ESE_PAUSE_REASON). */
static void ese_dti_apply(u32 mask)
{
    u32 closed = 0, opened = 0;
    for (u32 cid = 0; cid < SPARRAW_MAX_STA; cid++) {
        u32 paused = tx_dis_mask[cid] & (1u << ESE_PAUSE_REASON);
        if (mask & (1u << cid)) {
            if (paused) {
                bf_resume_sta_tx(ESE_PAUSE_REASON, cid);
                opened = 1;
            }
        } else if (!paused && (sta_tab[cid].flags & 1u)) {
            bf_pause_sta_tx(ESE_PAUSE_REASON, cid);
            closed = 1;
        }
    }
    if (closed)
        FWSH(fwsh_diag, ese_dti_closed) += 1;
    if (opened)
        FWSH(fwsh_diag, ese_dti_opened) += 1;
}

static void ese_dti_close(void)
{
    ese_dti_apply(0);
}

static void ese_dti_open(void)
{
    ese_dti_apply(0xffffffffu);
}

/* Лимит TXOP MAC — как задан LMAC 0x21 (txop_apply_limits_regs: txop_limit_cur — уже со сдвигом короткого TXOP), если
 * его урезала ese_dti_tx_gate (fwsh_sp_gate.txop_cap_us ≠ 0); не урезан — регистры не трогаются. */
static void ese_dti_txop_restore(void)
{
    if (FWSH(fwsh_sp_gate, txop_cap_us) == 0)
        return;
    u32 a = txop_limit_cur, b = txop_limit_us[0];
    FWSH(fwsh_sp_gate, txop_cap_us) = 0;
    MMIO32(HW_MAC_TXOP_LIMIT_0) = (a << 16) | (b < a ? b : a);
    MMIO32(HW_MAC_TXOP_LIMIT_1) = txop_limit_us[2] | (txop_limit_us[3] << 16);
}

static void ese_dti_txop_cap(u32 cap)
{
    u32 b = txop_limit_us[0], c = txop_limit_us[2], d = txop_limit_us[3];
    FWSH(fwsh_sp_gate, txop_cap_us) = (u16)cap;
    MMIO32(HW_MAC_TXOP_LIMIT_0) = (cap << 16) | (b < cap ? b : cap);
    MMIO32(HW_MAC_TXOP_LIMIT_1) = (c < cap ? c : cap) | ((d < cap ? d : cap) << 16);
    FWSH(fwsh_sp_gate, capped) += 1;
}

/* Окно-SP, где узел — источник: б7 «начинать можно» и Allocation Type 0 (ctrl_b0 [5:4]). */
static inline u32 ese_dti_ctrl_is_src_sp(u32 ctrl)
{
    return (ctrl & (ESE_SLOT_MAY_INIT | (3u << ESE_SLOT_TYPE_SHIFT))) == ESE_SLOT_MAY_INIT;
}

/* Наведение приёма (рычаг 4): rx — маска cid источника SP, где узел назначение (0 — нет), end — TSF конца этого SP.
 * Смена — режим прослушивания заново (rx_mode_configure(3, cid): сектор приёма берётся там же, с наведением —
 * sta_tab[].rx_sel источника, без — сектор простоя). Зовут события окон (L1, вне потоков TX/RX — среда не занята
 * своим обменом). */
static void ese_dti_rx_steer(u32 rx, u32 end)
{
    u32 cid1 = rx != 0 ? 31u - arc_norm(rx) : 0u;    /* старший бит маски + 1 (у SP пир один) */
    if (cid1 != 0 && (cid1 > SPARRAW_MAX_STA || !(sta_tab[cid1 - 1u].flags & 1u)))
        cid1 = 0;
    u32 old = FWSH(fwsh_sp_gate, rx_peer);
    FWSH(fwsh_sp_gate, rx_end_tsf) = end;
    if (cid1 == old)
        return;
    FWSH(fwsh_sp_gate, rx_peer) = (u8)cid1;
    if (cid1 != 0) {
        FWSH(fwsh_sp_gate, rx_steers) += 1;
        rx_mode_configure(3, cid1 - 1u);
    } else {
        rx_mode_configure(3, old - 1u);            /* наведение снято — сектор простоя этого пира */
    }
}

/* Запись таблицы окон, в интервал которой попадает текущий TSF (номер + 1), или 0: смещение от начала BI (0x886fc4)
 * против [start, start + dur) записей (ese_slot.start — от начала BI). Зовут начало DTI и события массива SP — у
 * точки со своей таблицей заодно запоминается конец текущего окна (fwsh_sp_gate.own_end_tsf) для путей SLS. Здесь же
 * — роль в текущем окне: источник SP (init_sp), назначение SP (наведение приёма, рычаг 4). */
u32 ese_dti_window_now(void)
{
    volatile ese_tbl_t *t = ese_dti_tbl();
    u32 n = t->count, cap = ese_dti_tbl_cap(t);
    u32 tsf = uc_read_tsf_lo();
    u32 off = tsf - MMIO32(HW_MAC_BI_START_TSF_LO);
    u32 win = 0, ctrl = 0, rx = 0, rx_end = 0;
    for (u32 k = 0; k < n && k < cap; k++) {
        u32 d = off - t->slot[k].start, dur = t->slot[k].dur;
        if (d < dur) {
            FWSH(fwsh_sp_gate, own_end_tsf) = tsf + (dur - d);
            win = k + 1u;
            ctrl = t->slot[k].ctrl_b0;
            if (!(ctrl & (ESE_SLOT_MAY_INIT | (3u << ESE_SLOT_TYPE_SHIFT)))) {
                rx = t->slot[k].peer_cid;           /* SP, где узел назначение (ESE станции) */
                rx_end = tsf + (dur - d);
            }
            break;
        }
        /* за своим SP — SP получателя к точке (только своя таблица точки: в записях ESE станции поле не пишет vendor-fw
         * гибрида — мусор стека, fw/rx.c ese_alloc_to_slot) */
        if (t == &ese_own_tbl && d - dur < t->slot[k].rx_tail_us) {
            rx = t->slot[k].peer_cid;
            rx_end = tsf + (dur + t->slot[k].rx_tail_us - d);
        }
    }
    u32 sched = ese_dti_scheduled();
    FWSH(fwsh_sp_gate, own_in_win) = (u8)(win != 0 && t == &ese_own_tbl);
    FWSH(fwsh_sp_gate, init_hold) = (u8)(!(ctrl & ESE_SLOT_MAY_INIT) && sched);
    FWSH(fwsh_sp_gate, init_sp) = (u8)(ese_dti_ctrl_is_src_sp(ctrl) && sched);
    ese_dti_rx_steer(sched ? rx : 0u, rx_end);
    return win;
}

/* Мкс до конца записи таблицы окон, в интервал которой попадает текущий TSF, или 0xffffffff, если TSF вне записей
 * (таблица пуста — без ESE). TSF в мкс с усечением: истинный остаток в (результат − 1, результат]. Для проверки
 * остатка выделения перед повтором SSW-Feedback (uc/tail.c sswfb_retry_fits) и Duration SSW / SSW-Feedback (пути SLS,
 * сроки MBIFS — test_uc_deadlines). Станция: ≤ ESE_SLOTS_N записей ese_slot_tbl. Точка в строгом TDMA: без обхода
 * таблицы — конец текущего своего окна, запомненный на событии массива SP (ese_dti_window_now): обход до
 * ESE_OWN_SLOTS_N записей съел бы запас пути RSS (10.42.2.2). Окна SP станций, где точка — ответчик SLS, в её таблице
 * нет: там остаток — до TBTT. */
u32 ese_dti_us_to_window_end(void)
{
    u32 n = FWSH(ese_slot_tbl, count);
    if (n == 0) {                       /* без ESE — без чтения TSF (путь до первого SSW RSS, txss.c) */
        if (FWSH(ese_slot_tbl, mode) != ESE_TBL_MODE_OWN || FWSH(fwsh_sp_gate, own_in_win) == 0)
            return 0xffffffffu;
        u32 left = FWSH(fwsh_sp_gate, own_end_tsf) - uc_read_tsf_lo();
        return (s32)left > 0 ? left : 0xffffffffu;   /* окно кончилось, событие ещё не разобрано — окна нет */
    }
    u32 off = uc_read_tsf_lo() - MMIO32(HW_MAC_BI_START_TSF_LO);
    for (u32 k = 0; k < n && k < ESE_SLOTS_N; k++) {
        u32 d = off - FWSH_AT(ese_slot_tbl, slot, k).start;
        if (d < FWSH_AT(ese_slot_tbl, slot, k).dur)
            return FWSH_AT(ese_slot_tbl, slot, k).dur - d;
    }
    return 0xffffffffu;
}

/* Мкс до конца своего окна (б7 «инициировать можно»), в котором идёт текущий TSF; 0 — TSF не в своём окне;
 * 0xffffffff — расписания нет (доступ без ограничений). *ctrl — ctrl_b0 этого окна (0 — окна нет). */
static u32 ese_dti_own_left(u32 *ctrl)
{
    *ctrl = 0;
    if (!ese_dti_scheduled())
        return 0xffffffffu;
    volatile ese_tbl_t *t = ese_dti_tbl();
    u32 n = t->count, cap = ese_dti_tbl_cap(t);
    u32 off = uc_read_tsf_lo() - MMIO32(HW_MAC_BI_START_TSF_LO);
    for (u32 k = 0; k < n && k < cap; k++) {
        u32 d = off - t->slot[k].start;
        if (d < t->slot[k].dur) {
            *ctrl = t->slot[k].ctrl_b0;
            return (t->slot[k].ctrl_b0 & ESE_SLOT_MAY_INIT) ? t->slot[k].dur - d : 0u;
        }
    }
    return 0;
}

u32 ese_dti_init_left_us(void)
{
    u32 ctrl;
    return ese_dti_own_left(&ctrl);
}

/* SLS-инициатор (развёртка TxSS, tail.c internal_tx_isr): начинать можно, если весь обмен SLS (10.42.2: ISS, MBIFS,
 * RSS, MBIFS, SSW-Feedback, MBIFS, SSW-Ack) и установка BRP после него (10.42.3.2: два кадра BRP через BRPIFS)
 * кончаются до конца своего окна. iss_us — своя развёртка (txss_sweep_duration_for_sta); развёртка ответчика
 * принимается той же длины (число секторов пира uc не хранит; у стенда — 32/32); кадр BRP с TRN — не больше
 * ESE_BRP_FRAME_US (эмулятор: 65,7 мкс). Без расписания — 1. */
#define ESE_BRP_FRAME_US    100u
#define ESE_SLS_TAIL_US     (DMG_CLK_TO_US_CEIL(3u * DMG_MBIFS_CLK + DMG_TXTIME_SSW_FB_CLK + DMG_TXTIME_SSW_ACK_CLK + \
                                                2u * DMG_BRPIFS_CLK) + 2u * ESE_BRP_FRAME_US)
_Static_assert(ESE_SLS_TAIL_US == 352u, "хвост SLS: 3·MBIFS + Feedback + Ack + 2·(BRPIFS + BRP)");
/* Шаг цикла назначения (rx_flow_main): срок rx_flow_timeout_us проверяется между ожиданиями занятости слота
 * (sxd_hal_wait_slot2_busy, по 4 за проход — ~46 мкс в эмуляторе, H-SLOT2) — выход до прохода позже срока. */
#define ESE_RESP_LOOP_US    100u
u32 ese_dti_sls_fits(u32 iss_us)
{
    u32 left = ese_dti_init_left_us();
    if (left == 0xffffffffu)
        return 1;
    if (left < 2u * iss_us + ESE_SLS_TAIL_US)
        return 0;
    /* Обмен в своём SP кончается без CF-End (рычаг 3): назначение (наш uc — rx_flow_main) ещё rx_flow_timeout_us ждёт
     * следующего кадра обмена и SSW в это время берёт за кадр данных — на ISS не ответило бы (эмулятор, 2026-11-07).
     * Развёртку — не раньше этого срока (+ шаг цикла) после конца своего обмена. */
    u32 e = FWSH(fwsh_sp_gate, src_end_tsf);
    if (e != 0 && uc_read_tsf_lo() - e <= rx_flow_timeout_us + ESE_RESP_LOOP_US)
        return 0;
    return 1;
}

/* Проверка перед доступом к среде (tx_slot_dispatch, до выбора очереди): 1 — начинать обмен можно. Без расписания —
 * всегда 1 (одно чтение). Можно, если идёт своё окно и до его конца помещаются TXOP по текущему лимиту MAC и хвост
 * ESE_TXOP_TAIL_US. Не помещаются — отказ; если остатка хватает на урезанный TXOP с запасом на ожидание следующего
 * доступа (ESE_TXOP_RETRY_US), лимит урезается (действует со следующего TXOP: план текущего MAC уже сделал,
 * docs/MAC-STAND.md), иначе передача закрыта до начала следующего окна (очереди на паузу, событие SP откроет). */
u32 ese_dti_tx_gate(void)
{
    u32 ctrl;
    u32 left = ese_dti_own_left(&ctrl);
    /* роль в окне — на каждом доступе: событие окна могло ещё не дойти (L1 не разбирает его, пока идёт поток TX) */
    FWSH(fwsh_sp_gate, init_sp) = (u8)(left != 0xffffffffu && ese_dti_ctrl_is_src_sp(ctrl));
    if (left == 0xffffffffu)
        return 1;
    u32 lim = FWSH(fwsh_sp_gate, txop_cap_us);
    if (lim == 0)
        lim = txop_limit_cur;           /* не урезан — лимит LMAC 0x21 */
    if (lim == 0)
        lim = 0xffffu;                  /* лимит 0 — без лимита (горизонт MAC — TBTT) */
    if (left > lim + ESE_TXOP_TAIL_US)
        return 1;
    FWSH(fwsh_sp_gate, refused) += 1;
    if (left > ESE_TXOP_TAIL_US + ESE_TXOP_RETRY_US + ESE_TXOP_MIN_US)
        ese_dti_txop_cap(left - ESE_TXOP_TAIL_US - ESE_TXOP_RETRY_US);
    else
        ese_dti_close();
    return 0;
}

/* Конец обмена источника в своём SP (рычаг 3; tx_send_and_await_rx_frame — вместо запроса итога и CF-End): TXOP CBAP
 * здесь не было, закрывать нечего. План TXOP MAC (лимит, урезанный ese_dti_tx_gate до остатка окна) кончается сам и
 * внутри своего SP: Duration кадров обмена (остаток TXOP) — NAV третьих станций, которым в чужом SP передавать нельзя
 * и так (10.39.6.2). Ожидания txop_event нет (fixed_sched_run_tx_slot): событие MAC дало бы только конец этого плана —
 * до 2 мс глухоты uc в своём SP (эмулятор 2026-11-07). 1 — обмен закончен так (своё SP), 0 — обычное закрытие. */
u32 ese_dti_sp_src_end(u32 sta)
{
    if (FWSH(fwsh_sp_gate, init_sp) == 0)
        return 0;
    if (rs_state[sta].active == 2)
        rs_state[sta].active = 1;
    FWSH(fwsh_sp_gate, src_end_tsf) = uc_read_tsf_lo();
    FWSH(fwsh_sp_gate, src_ends) += 1;
    return 1;
}

/* Цикл источника в своём SP (рычаг 3): пока в своём SP был доступ (tx_slot_dispatch ставит src_more), следующий —
 * сразу, без отсрочки EDCA: кадр очереди (новый или неподтверждённый — MAC держит его с битом Retry) уходит после
 * границы слота на свободной среде (mac_select_all_sectors_and_wait), не раньше срока ответа на прежний (ожидание
 * ответа ~22 мкс, H-SLOT2) — повтор не раньше PIFS (10.39.6.2). Конец SP — проверка доступа (ese_dti_tx_gate: обмен
 * до конца окна), очередь пуста — выход. Не дольше ESE_SRC_ROUNDS доступов за вызов: L1 (события окон, фоновые
 * задачи) не ждёт весь SP; дальше — по отсрочке MAC, как прежде. */
#define ESE_SRC_ROUNDS      8u
void ese_dti_sp_src_cycle(void)
{
    for (u32 n = 0; n < ESE_SRC_ROUNDS && FWSH(fwsh_sp_gate, src_more) != 0; n++) {
        FWSH(fwsh_sp_gate, src_more) = 0;
        FWSH(fwsh_sp_gate, src_rounds) += 1;
        fixed_sched_run_tx_slot();
    }
    FWSH(fwsh_sp_gate, src_more) = 0;
}

/* Начало своего SP (событие массива SP, L1; uc/tail.c dti_worker): источник начинает обмен сразу (10.39.6.2: «shall
 * initiate the frame exchange sequence … at the start of the SP»), а не после отсрочки MAC; в фазе передачи DTI
 * (bi_ctx.phase 1 — тот же путь, что bi_dti_start_tx_slot) и при прослушивании. Нет кадров — tx_slot_dispatch выйдет
 * «нет очереди». */
void ese_dti_sp_src_start(void)
{
    if (FWSH(fwsh_sp_gate, init_sp) == 0 || bi_ctx.phase != 1)
        return;
    FWSH(fwsh_sp_gate, src_more) = 1;
    ese_dti_sp_src_cycle();
}

/* Остаток текущего выделения DTI, мкс: меньшее из «до TBTT» (DTI кончается началом BTI следующего BI, любое
 * выделение — не позже; HW_MAC_USEC_TO_TBTT [25:0], при выключенном MAC 0x3ffffff) и «до конца окна ESE». Для
 * Duration SSW / SSW-Feedback (9.3.1.15, 9.3.1.16 b: «until the end of the current allocation») и проверки
 * остатка перед повтором Feedback (10.42.6.2, tail.c sswfb_retry_fits). noinline — см. sswfb_retry_fits. */
__attribute__((noinline)) u32 dti_alloc_left_us(void)
{
    u32 rem = MMIO32(HW_MAC_USEC_TO_TBTT) & 0x3ffffffu;
    u32 win = ese_dti_us_to_window_end();
    if (win < rem)
        rem = win;
    return rem;
}

/* Начало DTI (bi_dti_step): лимит TXOP — прежний; без расписания — снять свою паузу (расписание сняли); с ним —
 * открыть передачу получателям текущего окна или закрыть, если сейчас не идёт своё окно. */
void ese_dti_on_dti_start(void)
{
    ese_dti_txop_restore();
    if (!ese_dti_scheduled()) {
        ese_dti_open();
        return;
    }
    u32 win = ese_dti_window_now();
    volatile ese_tbl_t *t = ese_dti_tbl();
    if (win == 0 || !(t->slot[win - 1u].ctrl_b0 & ESE_SLOT_MAY_INIT))
        ese_dti_close();
    else
        ese_dti_apply(t == &ese_own_tbl ? t->slot[win - 1u].peer_cid : 0xffffffffu);
}

/* Начало окна: ctrl — управляющее слово записи (0x886f8c, r16 dti_worker): б7 — начинать можно, [15:8] — маска cid
 * получателей (у станции открываются все её пиры — пир один, точка). */
void ese_dti_slot_start(u32 ctrl)
{
    ese_dti_txop_restore();
    if (!ese_dti_scheduled()) {
        ese_dti_open();                 /* расписание сняли — записи массива SP отрабатывают вхолостую */
        return;
    }
    if (ctrl & ESE_SLOT_MAY_INIT)
        ese_dti_apply(FWSH(ese_slot_tbl, mode) == ESE_TBL_MODE_OWN ? (ctrl >> 8) & 0xffu : 0xffffffffu);
    else
        ese_dti_close();
}

/* Конец окна (флаги окна обновил dti_worker — ese_dti_window_now). */
void ese_dti_slot_end(void)
{
    if (ese_dti_scheduled())
        ese_dti_close();
    else
        ese_dti_open();
}
