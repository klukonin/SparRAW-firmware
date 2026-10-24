/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Доступ станции к среде по расписанию ESE своей точки (802.11-2020 10.39.4, 10.39.5, 10.39.6.2).
 *
 * При CBAP Only = 0 DTI распределён Extended Schedule: станция может инициировать обмен только в
 * CBAP, где ей это разрешено, и в своих SP как источник; вне них — молчать (в SP, где она
 * назначение, — только отвечать). Vendor 6.2 доступ расписанием не ограничивал: вне окон он
 * закрывал кольца хоста, а в SP, где станция только назначение, кольцо к пиру открывал —
 * станция инициировала обмен в чужом SP (стенд 2026-10-23, запись ToA: под iperf вверх
 * станция передаёт плотнее всего именно в SP точки).
 *
 * Флаг «DTI расписан» ставит fw по каждому маяку своей точки (fwsh_diag.ese_dti_sched,
 * fw/rx.c ese_rx_on_own_beacon); она же оставляет в таблице ESE только разрешённые окна и SP,
 * где станция назначение, и ставит в записи бит 7 «инициировать можно». Аппаратный массив SP
 * даёт события начала и конца записей (dti_worker_scheduled_dti_allocation_event, uc/tail.c).
 *
 * Рычаг — пауза передачи пира (bf_pause_sta_tx / bf_resume_sta_tx): маска причин на станцию
 * (tx_dis_mask), очереди пира убираются из опубликованных масок qset и возвращаются, только
 * когда снята последняя причина. BF — причина 3, расписание — своя причина 8: гонки с запретом
 * на время BF нет. Мгновенные ответы (Ack, BlockAck, DMG CTS) идут мимо очередей — роль
 * назначения в SP сохраняется. Только станция: у точки (uc_role_ap) и при фиксированном
 * расписании vendor (dti_qset_mode) — ничего не делается. Порт 6.4 (uc/new/ese_dti.cpp). */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/sta_max.h"

#define ESE_PAUSE_REASON  8u
#define ESE_SLOT_MAY_INIT (1u << 7)         /* бит 7 управляющего слова записи (fw ese_may_initiate) */

static u32 ese_dti_scheduled(void)
{
    return FWSH(fwsh_diag, ese_dti_sched) != 0 && uc_role_ap != 1 && dti_qset_mode == 0;
}

static void ese_dti_close(void)
{
    u32 any = 0;
    for (u32 cid = 0; cid < SPARRAW_MAX_STA; cid++) {
        if (!(sta_tab[cid].flags & 1u) || (tx_dis_mask[cid] & (1u << ESE_PAUSE_REASON)))
            continue;
        bf_pause_sta_tx(ESE_PAUSE_REASON, cid);
        any = 1;
    }
    if (any)
        FWSH(fwsh_diag, ese_dti_closed) += 1;
}

static void ese_dti_open(void)
{
    u32 any = 0;
    for (u32 cid = 0; cid < SPARRAW_MAX_STA; cid++) {
        if (!(tx_dis_mask[cid] & (1u << ESE_PAUSE_REASON)))
            continue;
        bf_resume_sta_tx(ESE_PAUSE_REASON, cid);
        any = 1;
    }
    if (any)
        FWSH(fwsh_diag, ese_dti_opened) += 1;
}

/* Запись таблицы ESE, в интервал которой попадает текущий TSF (номер + 1), или 0: смещение от
 * начала BI (0x886fc4) против [start, start + dur) записей (ese_slot.start — от начала BI). */
u32 ese_dti_window_now(void)
{
    u32 n = FWSH(ese_slot_tbl, count);
    u32 off = uc_read_tsf_lo() - MMIO32(HW_MAC_BI_START_TSF_LO);
    for (u32 k = 0; k < n && k < ESE_SLOTS_N; k++) {
        if (off - FWSH_AT(ese_slot_tbl, slot, k).start < FWSH_AT(ese_slot_tbl, slot, k).dur)
            return k + 1u;
    }
    return 0;
}

/* Мкс до конца записи таблицы ESE, в интервал которой попадает текущий TSF, или 0xffffffff, если
 * TSF вне записей (таблица пуста — без ESE). TSF в мкс с усечением: истинный остаток в (результат − 1,
 * результат]. Для проверки остатка выделения перед повтором SSW-Feedback (uc/tail.c sswfb_retry_fits). */
u32 ese_dti_us_to_window_end(void)
{
    u32 n = FWSH(ese_slot_tbl, count);
    u32 off = uc_read_tsf_lo() - MMIO32(HW_MAC_BI_START_TSF_LO);
    for (u32 k = 0; k < n && k < ESE_SLOTS_N; k++) {
        u32 d = off - FWSH_AT(ese_slot_tbl, slot, k).start;
        if (d < FWSH_AT(ese_slot_tbl, slot, k).dur)
            return FWSH_AT(ese_slot_tbl, slot, k).dur - d;
    }
    return 0xffffffffu;
}

/* Начало DTI (bi_dti_step): без расписания — снять свою паузу (расписание сняли); с ним —
 * закрыть, если сейчас не идёт разрешённое окно. */
void ese_dti_dti_start(void)
{
    if (!ese_dti_scheduled()) {
        ese_dti_open();
        return;
    }
    u32 win = ese_dti_window_now();
    if (win == 0 || !(FWSH_AT(ese_slot_tbl, slot, win - 1u).ctrl_b0 & ESE_SLOT_MAY_INIT))
        ese_dti_close();
    else
        ese_dti_open();
}

/* Начало окна: ctrl — управляющее слово записи (0x886f8c, r16 dti_worker). */
void ese_dti_slot_start(u32 ctrl)
{
    if (ese_dti_scheduled() && (ctrl & ESE_SLOT_MAY_INIT))
        ese_dti_open();
}

/* Конец окна. */
void ese_dti_slot_end(void)
{
    if (ese_dti_scheduled())
        ese_dti_close();
}
