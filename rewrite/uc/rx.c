// SPDX-License-Identifier: AGPL-3.0-or-later
/* RX-путь uCode. */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/sta_max.h"
#include "ifs.h"
#include "abft.h"



static inline s32 min_i32(s32 a, s32 b) { return a < b ? a : b; }


/* Выбрать регистр R40 sel (MAC_SEL_…): mac_sel_shadow с этим номером и команда MAC_CMD_STATUS_SEL с ним же. */
static inline __attribute__((always_inline)) void uc_mac_sel(u32 sel)
{
    u32 g = mac_sel_shadow & ~MAC_SEL_FIELD;
    mac_sel_shadow = g | sel;
    uc_mac_cmd(g | MAC_CMD_STATUS_SEL | sel);
}

/* Поля sta_tab[i] (шаг 80) / rs_state[i] (шаг 12) сдвигами, как у vendor (add2/add1 + asl /
 * ld.as), а не mul64: на ARC600 mul64 многотактный и чтение mlo ждёт результата (-Os выбирал
 * mul64; пути со сроком P0.2 и RD). */
static inline __attribute__((always_inline)) u32 rx_sta_tx_sel(u32 i)
{
    u32 r;
    __asm__ volatile("add2 %0,%1,%1\n\tasl %0,%0,4\n\tld %0,[%0,%2]"
                     : "=&r"(r) : "r"(i), "i"((u32)&sta_tab[0].tx_sel) : "memory");
    return r;
}
/* rs_stats[i].mcs_try (шаг 0x2c) — тело rs_sta_mcs_try (rate_search.c) без вызова. */
static inline __attribute__((always_inline)) u32 rx_rs_mcs_try(u32 i)
{
    u32 r;
    __asm__ volatile("add2 %0,%1,%1\n\tadd1 %0,%1,%0\n\tadd2 %0,%2,%0\n\tldb %0,[%0,%3]"
                     : "=&r"(r) : "r"(i), "i"((u32)rs_stats), "i"(__builtin_offsetof(struct rs_sta_stats, mcs_try))
                     : "memory");
    return r;
}
static inline __attribute__((always_inline)) u32 rx_rs_active(u32 i)
{
    u32 r;
    __asm__ volatile("add1 %0,%1,%1\n\tld.as %0,[%2,%0]"
                     : "=&r"(r) : "r"(i), "i"((u32)&rs_state[0].active) : "memory");
    return r;
}

/* 3×nop_s после MAC-команды до чтения регистров ядра (r40/r42…) — группа vendor. */
static inline __attribute__((always_inline)) void uc_nop3(void)
{
    arc_nops(3);
}


void rx_nav_clear_flags(void)
{
    rx_nav.flags = 0;
}

void rx_nav_arm_flag_if_enabled(void)
{
    if (rx_nav.enable == 0) {
        rx_nav.flags = 0;
        return;
    }
    if (!(rx_nav.flags & (1u << 1)))
        rx_nav.flags = 2;
}

void rx_nav_reset_flags_arm(u32 a)
{
    if (rx_nav.enable == 0) {
        rx_nav.flags = 0;
        return;
    }
    rx_nav.flags = (a != 0) ? 2 : 0;
}

u32 rx_is_brp_frame(void)
{
    if (rx_buf_body18 == 0x14 && rx_buf_body19 == 1)
        return 1;
    return 0;
}

void rx_latch_cur_gain_db(void)
{
    /* 0x930da4: stb всегда, затем 0, если > 0x3f (знаковое ble). */
    s32 v = (s32)phy_read_signal_gain_adc_db_sfd_locked();
    sel_nbr.cur_gain_db = (u8)v;
    if (v > 0x3f)
        sel_nbr.cur_gain_db = 0;
}

void rx_cfg_set_sta_omni_sector(u32 a)
{
    rf_chain_word = sta_tab[a].omni_rx_sel;
}

void rx_listen_set_flag_and_stamp_tsf(void)
{
    rx_listen_active = 1;
    mac_read_tsf64_uc(rx_listen_tsf);
}


/* 0x9228d4 */
void rx_arm_window(void)
{
    uc_wait_event_busy(MAC_EVT1_PPDU_REPORT, 0);
    RX_BUF_TOGGLE();
    ppdu_evt_cnt += 1;
    uc_stats.rx_arm += 1;
    uc_mac_cmd(0x2011000);
}

/* Переключение с приёма на передачу после конца принятого PPDU: дождаться конца приёма и перевести MAC на передачу
 * (mac_switch_rx_to_tx), затем проверить SIFS_CNT — опоздание отменяет передачу (0x1f000601, rx_end_tx_late_cnt).
 * Перед DMG CTS на RTS, ответным CF-End, SSW-Ack, продолжением TXOP и ответом TXSS.
 * СРОК: вызывается из rx_flow_handle_frame до запроса ответа в MTP (RTS / CF-End с Duration /
 * бит r40.sifs_resp) — входит в путь до ответа через SIFS 3 мкс (802.11-2020 10.3.2.3.3, Table 20-30).
 * Путь ~25 инструкций + mac_switch_rx_to_tx (vendor 0x924fc4 — так же); запас общий с
 * rx_frame_tx_resp_seq: единицы. Порог SIFS_CNT > 0x500 (5 мкс) или = 0 — сторож vendor:
 * команда 0x1f000601 и счётчик rx_end_tx_late_cnt (полезен на стенде как счётчик опозданий;
 * см. docs/UC-REGISTERS.md §2.16 — отсчёт SIFS_CNT со сроком ответа не совпадает). */
UC_HOT
void rx_end_switch_to_tx(void)
{
    /* 6.2 asm 0x924fc4. */
    mac_switch_rx_to_tx(0);
    uc_mac_cmd_nl(0x4d000000);
    arc_nops(3);
    u32 r1 = mac_timer_sel();                   /* rx_sw_sifs_cnt (vendor) никто не читает — запись снята */
    if (r1 > SIFS_CNT_RESP_LATE || r1 == 0) {
        uc_mac_cmd_nl(0x1f000601);
        rx_end_tx_late_cnt += 1;                  /* ld_s [gp,4] (байты) / st.as [gp,1] */
    }
}

u32 rx_flow_run_and_check_bf_abort(u32 a)
{
    /* 6.2 asm 0x926310. */
    (void)a;
    u32 r14 = rx_flow_main();
    if (r14 != 1)
        return r14;
    if (bf_abort_unexpected(VOL(rxf.sta), 0xa) != 0) {
        bf_store_flow_status(VOL(rxf.sta), 0);
        bf_sm_run_sta(VOL(rxf.sta));
    }
    return r14;
}

u32 rx_ppdu_is_ack(void)
{
    uc_wait_event_busy(MAC_EVT1_PPDU_REPORT, 0);
    RX_BUF_TOGGLE();
    ppdu_evt_cnt += 1;                      /* ld_s [gp,80] / st.as [gp,20] */
    uc_stats.rx_arm += 1;
    uc_mac_cmd(0x2011000);
    return mac_rx_rep1() & MAC_RX_REP1_IMM_ACK;
}


u32 rx_ppdu_is_cts(void)
{
    uc_wait_event_busy(MAC_EVT1_PPDU_REPORT, 0);
    RX_BUF_TOGGLE();
    ppdu_evt_cnt += 1;                      /* ld_s [gp,80] / st.as [gp,20] */
    uc_stats.rx_arm += 1;
    uc_mac_cmd(0x2011000);
    return mac_rx_rep2() & MAC_RX_REP2_CTS;
}


/* uc_wait_event_busy — в stubs.c. */
/* mac_switch_rx_to_tx — в mac.c. */

/* 0x92c568: возврат r37 & (1 << 24). */
u32 rx_ppdu_is_ssw(void)
{
    uc_wait_event_busy(MAC_EVT1_PPDU_REPORT, 0);
    RX_BUF_TOGGLE();
    ppdu_evt_cnt += 1;
    uc_stats.rx_arm += 1;
    uc_mac_cmd(0x2011000);
    return mac_rx_rep2() & MAC_RX_REP2_SSW;
}

void rx_mac_prepare(void)
{
    uc_mac_cmd(0x3d000400);
    uc_mac_cmd(0x1f003000);
    uc_mac_cmd(0x83u << 25);
}

u32 rx_flow_decode_result(void)
{
    /* 6.2 asm 0x932de8. */
    u32 v = txrx_state2;
    if (v & (1u << 24))
        return 0;
    if (v & (1u << 25))
        return 1;
    if (v & (1u << 12))
        return 2;
    uc_assert((u32)__builtin_return_address(0), 0x3e);
    return 3;
}


void rx_check_mode_2(struct rx_meas_ctx *m, u32 b)
{
    /* 6.2 asm 0x936e04. */
    if (m->state != 2)
        return;
    u32 v = m->kind;
    if (v == 0 || v >= 7)
        return;
    if (rx_capture_match_filter(m) == 0) {
        if (v == RX_MEAS_PHYSTAT)
            phy_rx_stats_clear();
    } else {
        if (v == RX_MEAS_PHYSTAT)
            phy_stats_accumulate_to_shared(m, b);
    }
}


void rx_enter_listen_mode(void)
{
    /* 6.2 asm 0x93c818. */
    mac_wait_mode_ack_if_idle();
    rx_mode_configure(3, 0xff);
    rx_nav_check_idle(0, 1, 1);
    rx_listen_set_flag_and_stamp_tsf();
    rx_listen_enter_cnt += 1;
    uc_wait_two_events(5, 5, 0xa);
    arc_nops(3);   /* vendor: 3×nop до чтения r42 */
    if (!(mac_evt1() & MAC_EVT1_BUSY2))
        uc_assert((u32)__builtin_return_address(0), 0x10);
}
void rx_flow_accumulate_busy_time(u32 a)
{
    /* 0x924960: a — TSF начала занятости; учёт в 0x8010d8 с «склейкой» короткого
     * промежутка (≤ [0x800640] мкс) с предыдущим интервалом. */
    u32 now = uc_read_tsf_lo();
    u32 d = now - a;
    u32 last = busy_acct.last_end_tsf;
    if (last != 0 && (u32)busy_gap_us >= a - last)
        d += a - last;
    busy_acct.last_end_tsf = now;
    mac_mon_report.busy_time += d;
}


/* CF-End, адресованный нам: 10.23.2.10 — в DMG BSS приём CF-End сбрасывает NAV в конце интервала Duration (от
 * конца кадра), независимо от RA. исправлено (vendor): CF-End нам NAV не трогал (чужие CF-End — rx_update_nav_from_frame,
 * то же правило). dur — от момента вызова: без ответа — Duration принятого (отсчёт от его конца); после нашего
 * ответного CF-End — Duration ответа (принятый − TXTIME(CF-End) − SIFS): отсчёт идёт уже от конца нашей передачи,
 * и тот же конец интервала (RXEND + Duration), а не на SIFS + TXTIME позже. */
void rx_cf_end_nav_reset(u32 dur)
{
    rx_nav_set_from_duration(1, 0xe4u, dur, (u32)rx_buf_ta);
}

/* СРОК: ответный CF-End (fc 0x00e4) должен уйти через SIFS 3 мкс после принятого CF-End с Duration ≠ 0
 * (802.11-2020 10.39.8.1; 10.3.2.3.3). Медленный путь (switch в хвосте rx_flow_handle_frame, случай 8):
 * от входа rx_flow_handle_frame — rx_get_required_response + ~30 инструкций до вызова, здесь
 * tx_send_imm_response (~60, команда 0x37000020 и ожидание r45) — как у vendor 0x93626c; запас не
 * замерен, по аналогии с ACK/BA — единицы–десятки. Кадр (fc через r33 и 0x33…) пишется уже после
 * 0x37000020: заполнение должно успеть до того, как MAC начнёт передавать MPDU (аппаратный, не
 * установлен). Срыв — поздняя команда (MAC_HW_ICR б4/б5, assert 0x26, см. rx_frame_tx_resp_seq). */
u32 rx_send_cf_end_response(void)
{
    /* 6.2 asm 0x93626c. */
    /* 9.3.1.6: Duration CF-End DMG — остаток последовательности усечения (i − 1)·(TXTIME(CF-End) + SIFS), т. е.
     * Duration принятого минус TXTIME(CF-End) + SIFS; исправлено (vendor): отвечал с Duration = 0 */
    u32 d = dmg_cf_end_resp_dur_us(rx_buf_duration);
    tx_send_imm_response(0, d, 0x10);
    arc_core_wr(33, 0xe4);
    tx_fifo_free -= 0x10;
    uc_mac_cmd_nl(0x33000063);
    uc_wait_direct_tx_ready();
    direct_tx_commit();
    txr.imm_resp += 1;
    return d;
}

/* phy_stats_accumulate_to_shared — в tail.c; tx_send_imm_response — в tx.c. */

/* По формату это Grant Ack, а не DMG CTS: fc 0x0764 (расширение управления 7) и 7 Б тела
 * (Reserved + BF Control, 9.3.1.18); вызывается на принятый Grant (MAC_RX_REP2_GRANT, случай 9).
 * СРОК: Grant Ack — через SIFS 3 мкс после Grant (802.11-2020 10.39.4, 10.3.2.3.3). Медленный путь
 * через switch rx_flow_handle_frame; здесь до 0x37000020 — расчёт длительности,
 * direct_tx_init_grant_ack (~15) и tx_send_imm_response (~60); тело (7 Б) пишется после 0x37000020.
 * Как у vendor 0x936320; запас не замерен (единицы–десятки). Срыв — поздняя команда, assert 0x26. */
void rx_send_grant_ack(void)
{
    /* 6.2 asm 0x936320. */
    struct dtx_ctrl_frame sp;
    /* 9.3.1.18: Duration Grant Ack = Duration Grant − (TXTIME(Grant Ack) + SIFS), не меньше 0; vendor вычитал
     * 20 без отсечки — Grant с Duration < 20 давал Grant Ack с Duration ≈ 32,7 мс (NAV соседям). */
    u32 d = rx_buf_duration;
    u32 r1 = d > DMG_RESP_DUR_SUB_US(DMG_GRANT_ACK_LEN) ? d - DMG_RESP_DUR_SUB_US(DMG_GRANT_ACK_LEN) : 0u;
    tx_send_imm_response(ctrl_frame_mcs, r1, 0x17);  /* [gp,-0xec] = [0x80043c] */
    /* Beamforming Training — копия из Grant (10.39.4); при 0 остальные подполя BF Control зарезервированы (9.5.5).
     * исправлено (vendor): всегда 7 — Beamforming Training = 1 и TXSS обеих сторон, даже на Grant без обучения */
    direct_tx_init_grant_ack(&sp, (rx_buf_grant_bf & 1u) ? 7u : 0u);
    arc_core_wr(33, sp.fc);
    tx_fifo_free -= 0x10;
    uc_mac_cmd(0x33000063);
    uc_wait_direct_tx_ready();
    tx_fifo_write_bytes((u32)&sp.alloc, 7);
    direct_tx_commit();
    uc_stats.dmg_cts_tx += 1;
}

void rx_handle_brp_frame(void)
{
    /* 6.2 asm 0x92e16c. */
    brp_frame_rx_cnt += 1;   /* ldh.as [gp,70]: масштаб ×2 → 0x8005b4 */
    if (rx_buf_body18 != 0x14)
        return;
    if (rx_buf_body19 != 1)
        return;
    u32 lrx = rx_buf_brp_lrx();
    if (lrx != 0) {
        sls_rx.brp_lrx = (u8)lrx;
        sls_rx.flags |= 0x600;
    }
    u16 r2 = ((u8 *)&rx_buf_brp_elem)[0] | (((u8 *)&rx_buf_brp_elem)[1] << 8);   /* байтами */
    if (r2 & (1u << 10))
        sls_rx.flags |= 0xa00;
}

void rx_update_nav_from_frame(u32 a)
{
    /* 6.2 asm 0x9343a8. */
    u32 r5 = rx_buf_status1;
    if (!(r5 & (1u << 23)))
        return;
    u16 r1 = rx_buf_fc;
    u16 r2 = rx_buf_duration;
    u32 r3 = (u32)rx_buf_ta;
    if (((r1 >> 2) & 3) == 3) {
        if (rx_nav_update_en == 0)
            return;
        r3 = (u32)rx_buf_ra;
        /* исправлено (vendor): к Duration DMG Beacon прибавлял 1600 мкс (a ≠ 0) — NAV по маяку соседа = его Duration
         * (до конца BTI, 9.3.4.2; 10.3.2.4). */
        (void)a;
    }
    if (!(rx_mode_flags & 1u)) {
        sel_nbr.gain_snapshot = sel_nbr.cur_gain_db;
        r1 = rx_buf_fc;
    }
    rx_nav_set_from_duration(1, r1, r2, r3);
}

UC_HOT
u32 rx_flow_ctrl_qid_empty(struct tx_ctx_s *a)
{
    /* 6.2 asm 0x93daf0. */
    u32 r2 = a->qid;
    u8 r1 = qid_cfg[r2].ctrl_b6;
    if (r1 == 0)
        return 0;
    u32 g = mac_sel_shadow & 0xfffff0ff;
    mac_sel_shadow = g | 0xb00;
    uc_mac_cmd(g | 0x1d000b00);
    arc_nops(3);
    u32 r15 = mac_queue_sel();
    g = mac_sel_shadow & 0xfffff0ff;
    mac_sel_shadow = g | 0xc00;
    uc_mac_cmd(g | 0x1d000c00);
    arc_nops_nop(2);
    u32 r13 = mac_queue_sel() | r15;
    u32 r6 = a->qid;
    if (!(r13 & (1u << r6)))
        return 1;
    return 0;
}

/* --- Крупные функции RX (структурные порты: поток + stub подвызовов) --- */

/* Продолжение TXOP (vendor 0x9314a0..0x931668, хвост rx_flow_run): запрос в MTP следующей передачи
 * (с ответом BA/ACK при RD), 0x37000020, разрешение на передачу. Копии: rx_flow_run (from_step 0) и конец
 * rx_flow_step (1 — с отложенными записями); копию в rx_flow_handle_frame (ответ RD) убрали — RD отключён
 * (rx_flow_handle_frame, «RD отключён»).
 * ХРУПКО: срок — SIFS от конца принятого кадра; запас у vendor и у нас — единицы инструкций
 * (P0.2 на железе 2026-10-21: +16 nop перед 0x1b001111 — норма, +20 — FWERR, коды assert 0/0; после
 * переделки rx_flow_step путь короче на 67 инструкций по эмулятору — запас заново мерить pad_sweep).
 * Железо 2026-10-18: +4 nop перед 0x1b001111 (UC_DBG_TXOP_PAD=4) — наш uc 9 из 9 загрузок
 * (с нашим fw и с vendor fw) — assert uc 0x26/0x6000 через ~10 с iperf up, MAC_HW_ICR б5 (поздняя
 * команда); vendor с тем же сдвигом — 1 сбой из 3. Срабатывает ветка RD: кадр данных AP в нашем
 * TXOP (rxf.flags б3), нужен BA (mtp_state 2), ответ уходит отсюда, а не быстрым путём
 * rx_frame_tx_resp_seq. Гибрид «наш rx_flow_run + vendor rx_flow_handle_frame» с +4 выдерживал
 * (2 из 2), с нашим обработчиком — нет (2 из 2). Поэтому обработчик зовёт эту функцию сам, сразу
 * по решению (см. хвост rx_flow_handle_frame): без его эпилога и проверок rx_flow_run после
 * возврата. Порядок команд MAC тот же, между возвратом и 0x1b001111 vendor их не шлёт.
 * Стандарт: первая PPDU ответа RD-ответчика — через SIFS после RDG PPDU (802.11-2020 10.29.4);
 * следующий кадр TXOP держателя — через SIFS после Ack/BlockAck (10.23.2.8); aSIFSTime 3 мкс
 * (Table 20-30), допуск DMG −0 %/+10 %×(aSlotTime − aAirPropagationTime) ≈ +0,49 мкс ≈ 80 тактов
 * (10.3.2.3.3). Сюда ведут и rx_flow_step (держатель TXOP принял Ack/BA), и RD-ветка обработчика. */
/* В копии из rx_flow_step (-Os) — вставки без mul64 и вызова; в копиях rx_flow_run /
 * rx_flow_handle_frame (O2) gcc и так строит add1 + ld.as — там код прежний. */
#define RX_TXOP_RS_ACTIVE(i) (from_step ? rx_rs_active(i) : rs_state[i].active)
#define RX_TXOP_MCS_TRY(i)   (from_step ? rx_rs_mcs_try(i) : (u32)rs_sta_mcs_try(i))
static inline __attribute__((always_inline)) void rx_txop_continue(struct tx_ctx_s *ctx, int from_step)
{
    u32 a, b;
    if (__builtin_expect(txrx_state2 & (1u << 30), 0)) {   /* раскладка: ветка RD/обычная — прямым ходом */
        a = (ctx->qid << 16) | 4;
        b = 0;
        if (RX_TXOP_RS_ACTIVE(ctx->sta) != 0)
            b = MTP_RATE(RX_TXOP_MCS_TRY(ctx->sta));
    } else {
        u32 m = ctx->mtp_state;
        a = ctx->qid << 16;
        b = 0;
        if (m == 2 || m == 1) {
            a |= (m == 2) ? 0x103 : 3;
            a |= 0x20;
            b = MTP_CTX(ctx->resp_ctx8);
        } else {
            a |= 1;
        }
        if ((txrx_state1 & 2) && RX_TXOP_RS_ACTIVE(ctx->sta) != 0)
            b |= MTP_RATE(RX_TXOP_MCS_TRY(ctx->sta));
    }
    UC_PAD(PAD_TXOP);   /* стресс запаса: uc/dbg.h (прежде UC_DBG_TXOP_PAD) */
    UC_EVM(0x13);
    UC_STAMP_T0(STAMP_MTP_LAT, mtp_t0);
    MTP_REQUEST(MTP_W16(a), MTP_W17(b));
    while (!(mac_mtp_resp() & MAC_MTP_RESP_VALID))
        ;
    UC_EVM(0x14);
    UC_STAMP(STAMP_MTP_LAT, 1u << 16 | (arc_lr(0x100) - mtp_t0), 0);
    u32 r51 = mac_mtp_desc();
    mtp_desc_lo = r51 & 0xf;
    mtp_desc_hi = r51 >> 4;
    u32 mcs = MAC_MTP_RESP_MCS_OF(mac_mtp_resp());
    uc_mac_cmd((mcs << 4) | 0x3e000000);
    uc_mac_cmd(0x37000020);
    if (from_step) {
        /* Отложенное из rx_flow_step (r13 = 1): записи флагов (MAC их не читает; до 0x1b001111
         * стоили ~9 инструкций) — до чтения ctx->flags ниже, итог тот же; метка входа 0xeeee0b. */
        rxf.flags |= 2u;
        ctx->flags |= 1u;
        uc_mac_cmd(0xeeee0b);
    }
    VOL(uc_stats.tx_start) += 1;
    u32 r8 = (abif_dvs_rf_ctrl_shadow & 0xfcffffff) | (rf_set_tx << 24);
    abif_dvs_rf_ctrl_shadow = r8;
    MMIO32(HW_ABIF_DVS_RF_CTRL) = r8;
    u32 c3 = ctx->flags;
    ctx->flags = (((c3 >> 11) & 1) << 12) | (c3 & ~(1u << 12));
    mtp_get_tx_permission(ctx, mcs);
    ctx->flags = (ctx->flags & ~(1u << 12)) | (1u << 5);
}

/* Принятый PPDU кончился до проверки счётчиков в rx_flow_run и его можно разобрать с ответом в срок: новый PPDU не
 * начался (начал CCA PHY_SIGNALS [21:16] столько же, сколько концов [13:8]), отчёт о нём (r42 б16) не снят, кадр SC
 * (r38 [24:20] received_mcs ≠ 0), SIFS_CNT (sifs_cnt) не 0 (0 — как у rx_end_switch_to_tx: счёт не идёт) и меньше
 * порога SIFS_CNT_RX_LATE_END_SC (uc/ifs.h). */
static inline __attribute__((always_inline)) u32 rx_late_end_ok(u32 physig, u32 evt1, u32 sifs_cnt, u32 rep3)
{
    if (MAC_PHYSIG_CCA_EVT_CNT_OF(physig) != MAC_PHYSIG_PPDU_EVT_CNT_OF(physig) || !(evt1 & MAC_EVT1_PPDU_REPORT) ||
        MAC_RX_REP3_RX_MCS_OF(rep3) == 0 || sifs_cnt == 0)
        return 0;
    return sifs_cnt < SIFS_CNT_RX_LATE_END_SC;
}

/* СРОК: весь путь от конца принятого кадра до вызова rx_flow_handle_frame / rx_flow_step входит
 * в срок ответа через SIFS 3 мкс (802.11-2020 10.3.2.3.3; Ack 10.3.2.11, BlockAck 10.25.3,
 * DMG CTS 10.3.2.9, RD 10.29.4). Вход при состоянии 2/3/5: от выхода из цикла ожидания
 * MAC_EVT1_BUSY2/MAC_EE2_BRP_ON_AIR (ХРУПКО ниже) до bl rx_flow_handle_frame ~32 инструкции + латч PHY (~4)
 * (vendor 0x9311e4…0x93146c ~38); вход при состоянии 0 (кадр уже кончился): весь пролог
 * ~50 инструкций + sls_clear_rx_state (6) + 3 команды 0x1d/0x4d с nop — как у vendor. Ветка
 * txrx_state2 б2 добавляет rx_mode_configure (~190 инструкций, 12 вызовов) и mac_load_tx_key — так
 * же у vendor (0x9313d8). Запас общий с rx_frame_tx_resp_seq: единицы. Не добавлять код на этом
 * пути (трассу 0xeeee.. тоже) без замера tools/arcemu/resp_lat.py. Порог SIFS_CNT ≥ 0x120
 * (1 мкс + 32 такта) при состоянии 5 — сторож vendor: опоздавший вход не шлёт 0x1f006000…
 * 0x6000101 (rx_not_ready). Кадр SC, кончившийся раньше проверки счётчиков PPDU (короткий, или вход задержан), —
 * свой путь в ветке r13 ≠ seq: срок — порог SIFS_CNT_RX_LATE_END_SC (uc/ifs.h) плюс путь до 0x37000020. */
/* Маска движка событий 7 на приёме (0x27…, мл. 16 бит): 0x7300 — как vendor; опыт (а) — другие значения через UC_DBG. */
#ifndef EXP_E27_MASK
#define EXP_E27_MASK 0x7300u
#endif
UC_HOT
u32 rx_flow_run(void)
{
    /* 6.2 asm 0x930dd4. */
    struct tx_ctx_s *ctx;                       /* r15 = tx_ctx_pool.cur */
    u32 ok = 1;                                 /* r17 */
    u32 res = 1;                                /* r16 — возврат */
    u32 hit = 0;                                /* r18 */
    u32 seq;                                    /* r14 */
    u32 st, r13;
    u32 txop_sent = 0;                          /* продолжение TXOP уже отправил rx_flow_handle_frame */
    volatile u32 *cnt = uc_stats.rx_cnt;
#if defined(UC_STAMP_MASK) && !defined(UC_DCCM_OBJECTS)
    /* опыт E-R3 (STAMP_HDR_EARLY): моменты от выхода из ожидания sfd_sync — такты Timer1 */
    u32 e3_sfd = 0, e3_snr = 0, e3_b10 = 0, e3_b12 = 0, e3_fc = 0, e3_fc0 = 0, e3_end = 0, e3_plcp_h = 0;
    u32 e3_st[4] = {0, 0, 0, 0}, e3_nst = 0, e3_last = 0xff;
    u32 t_le = 0, t_tl = 0, t_ac = 0;                          /* STAMP_RESP_PATH: конец кадра, tail, после учёта занятости */
#endif

    uc_mac_cmd(0xeeee09);
    uc_mac_cmd(arc_lr(uc_timer[1].count) & 0xffffff);
    RX_POST_CHECK();                              /* сторож: отложенная работа после пуска — до приёма (ХРУПКО, rx_post_run) */
    rx_ppdu_report_seen = 0;
    uc_mac_sel(0);
    uc_nop3();
    sls_clear_rx_state();
    st = mac_status_sel() & MAC_BIFS_IDLE_DETECT;
    rx_flow_mac_state = st;
    rx_cts_rf_restore = 0;
    rx_ack_rcvd = 0;
    if (st == 5) {
        uc_mac_cmd(0x4d000000);
        uc_nop3();
        u32 r55 = mac_timer_sel();
        st = rx_flow_mac_state;
        if (r55 >= SIFS_CNT_RX_ENTRY_LATE)
            ok = 0;
    }
    if (st == 0)
        ok = 0;
    if (ok == 0) {
        VOL(uc_stats.rx_not_ready) += 1;
    } else {
        uc_mac_cmd(0x1f006000);
        uc_mac_cmd(0x38000300);
        uc_mac_cmd(0x3600003f);
        uc_mac_cmd(0x6000101);
        ok = 1;
    }
    uc_mac_cmd(0x4d000000);
    uc_nop3();
    rx_flow_r55_snap = mac_timer_sel();
    uc_mac_sel(MAC_SEL_PHY_SIGNALS);
    uc_nop3();
    {
        u32 r3 = mac_status_sel();
        r13 = MAC_PHYSIG_PPDU_EVT_CNT_OF(r3);
        if (((MAC_PHYSIG_CCA_EVT_CNT_OF(r3) - r13) & 0x3f) >= 2)
            uc_assert((u32)__builtin_return_address(0), 68);
    }
    seq = ppdu_evt_cnt & 0x3f;
    rxf.sta = SPARRAW_PEER_UNKNOWN;
    ctx = tx_ctx_pool.cur;
    rxf.resp_type = 0;
    rxf.flags = (rxf.flags & 8) | 0x80000000;

    if (r13 != seq) {
        /* исправлено (vendor: любой r13 ≠ seq — «события нет», кадр без ответа). PPDU, ради которого uc вошёл сюда
         * (busy_event), кончился раньше этой проверки: короткий кадр SC (Action ADDBA Response 3,4 мкс, Association
         * Response 4,8 мкс; заголовок SC разобран через 2,47 мкс, 20.4.3) кончается, пока uc идёт от прерывания
         * (sfd_sync) через l1_task_on_evt1 → rx_flow_main до сюда (~460 тактов, эмулятор), и тем более — если вход
         * задержан тиком L1 (до ~330 тактов, vendor-порядок обработчиков одного уровня). Признак «этот кадр, он
         * цел и только что кончился»: концов PPDU ровно на один больше своего счётчика, начал CCA столько же (новый
         * PPDU не начался, assert 68 выше — разница ≥ 2), отчёт о PPDU (r42 б16) ещё не снят, и SIFS_CNT (снимок
         * выше, от конца PPDU) не дальше срока ответа минус путь отсюда (rx_late_end_ok выше). Тогда кадр
         * разбирается как после цикла ожидания конца (ХРУПКО ниже: защёлка усиления, затем «кадр принят»): ответ
         * через SIFS обязателен (802.11-2020 10.3.2.11 Ack, 10.25.3 BlockAck, 10.3.2.9 DMG CTS). Иначе — прежний
         * разбор рассинхронизации. Только при ok: без 0x1f006000…0x6000101 (сторож состояния 5) ответа нет и так.
         * ХРУПКО: путь отсюда до 0x37000020 входит в порог SIFS_CNT_RX_LATE_END_SC (test_uc_deadlines
         * test_sifs_response_late_end_sc); свой блок, а не переход в блок после цикла ожидания — иначе GCC кладёт тот
         * блок сюда, и обычный путь после цикла получает взятый переход (сверено по дизассемблеру). */
        if (__builtin_expect(ok && ((r13 - seq) & 0x3f) == 1 &&
                             rx_late_end_ok(mac_status_sel(), mac_evt1(), rx_flow_r55_snap, mac_rx_rep3()), 0)) {
            rx_latch_cur_gain_db();
            goto tail;                          /* res = 1, hit = 0 — как «hi ≠ seq» после цикла */
        }
        ppdu_evt_cnt = r13;
        uc_mac_cmd(0x20d2000);
        if (!(mac_status_sel() & MAC_PHYSIG_CCA_PPDU_COMP)) {
            mac_wait_evt1_or_status(MAC_EVT1_PPDU_REPORT, MAC_PHYSIG_CCA_PPDU_COMP);
            ppdu_evt_cnt += 1;
        }
        rx_flow_noevt_cnt += 1;
        uc_mac_cmd(0xeeee04);
        res = 0;
        goto tail;
    }

    uc_mac_sel(0);
    uc_nop3();
    uc_mac_cmd(mac_status_sel() & MAC_BIFS_IDLE_DETECT);
    switch (mac_status_sel() & MAC_BIFS_IDLE_DETECT) {
    case 0:
        uc_mac_sel(MAC_SEL_PHY_SIGNALS);
        uc_nop3();
        if (seq == MAC_PHYSIG_CCA_EVT_CNT_OF(mac_status_sel())) {
            u32 v = VOL(uc_stats.rx_ppdu) + 1;
            FWSH(fw_stats_dash, rx_ppdu) = v;
            VOL(uc_stats.rx_ppdu) = v;
            res = 0;
        }
        goto tail;
    case 1:
        uc_wait_two_events(1, 1, 4);
        if ((mac_status_sel() & MAC_BIFS_IDLE_DETECT) != 2) {
            VOL(uc_stats.rx_type_err) += 1;
            res = 0;
            uc_mac_cmd(0xeeee05);
            goto busy;
        }
        /* fallthrough */
    case 2:
    case 3:
    case 5: {
        uc_mac_cmd(mac_evt_en_shadow | 0x27000000 | EXP_E27_MASK);
        uc_mac_cmd(0x2004000);
        uc_nop3();
        uc_wait_event_busy(MAC_EVT1_SFD_SYNC | MAC_EVT1_BUSY2, 0);
        UC_EVM(0x00);
#if defined(UC_STAMP_MASK) && !defined(UC_DCCM_OBJECTS)
        if (UC_STAMP_ON(STAMP_HDR_EARLY)) {
            e3_sfd = arc_lr(0x100);
            e3_fc0 = rx_buf_fc | (u32)rx_buf_duration << 16;
        }
#endif
        if (!(mac_evt1() & MAC_EVT1_BUSY2) && (rx_mode_flags & 2) &&
            (mac_status_sel() & MAC_BIFS_IDLE_DETECT) == 2 && (MMIO32(HW_PHY_RX_STATUS_8837B0) & 2)) {
            rx_flow_measure_snr_select_best();
#if defined(UC_STAMP_MASK) && !defined(UC_DCCM_OBJECTS)
            if (UC_STAMP_ON(STAMP_HDR_EARLY))
                e3_snr = (arc_lr(0x100) - e3_sfd) | 1u << 31;
#endif
        }
        uc_mac_sel(MAC_SEL_PHY_SIGNALS);
        uc_nop3();
        uc_mac_cmd(mac_evt_en_shadow | 0x27000000 | EXP_E27_MASK);
        uc_mac_cmd(0x2004000);
        uc_nop3();
        {   /* ХРУПКО: тайминг без запаса. Как vendor: 4 инструкции на проход;
             * -Os уводил проверку r49 за дальний переход (6a30636f).
             * Отсюда (конец кадра: MAC_EVT1_BUSY2 / BRP-стадия MAC_EE2_BRP_ON_AIR) отсчитывается SIFS до ответа
             * (802.11-2020 10.3.2.3.3); задержка выхода — до одного прохода (4 инструкции). */
            u32 t;
#if defined(UC_STAMP_MASK) && !defined(UC_DCCM_OBJECTS)
            if (UC_STAMP_ON(STAMP_HDR_EARLY)) {
                /* опыт E-R3 (только чтение): до конца кадра — первые б10/б12 r42, смены r49 [19:16], смена FC/Duration
                 * в rx_buf, PLCP PHY 0x8830ec на б12 */
                while (!(mac_evt1() & (1u << 14)) && !(mac_evt_eng2() & (1u << 13))) {
                    u32 t = arc_lr(0x100) - e3_sfd, e = mac_evt1(), st = (mac_evt_eng2() >> 16) & 0xf;
                    if (!e3_b10 && (e & (1u << 10)))
                        e3_b10 = t | 1u << 31;
                    if (!e3_b12 && (e & MAC_EVT1_RX_FRAME)) {
                        e3_b12 = t | 1u << 31;
                        e3_plcp_h = MMIO32(0x8830ec);
                    }
                    if (!e3_fc && (rx_buf_fc | (u32)rx_buf_duration << 16) != e3_fc0)
                        e3_fc = t | 1u << 31;
                    if (st != e3_last && e3_nst < 4) {
                        e3_st[e3_nst++] = st << 28 | (t & 0xfffffff);
                        e3_last = st;
                    } else if (st != e3_last) {
                        e3_st[3] = st << 28 | (t & 0xfffffff);    /* последняя смена — в последний слот */
                        e3_last = st;
                    }
                }
                e3_end = arc_lr(0x100) - e3_sfd;
                uc_mac_cmd(0x4d000000);                         /* опыт E-R4: SIFS_CNT на выходе из цикла (+~10 тактов) */
                arc_nops(3);
                e3_plcp_h = e3_plcp_h ? e3_plcp_h : 0;
                e3_fc = (e3_fc & 0xffff) | mac_timer_sel() << 16;
            } else
#endif
            __asm__ volatile("1:\tmov\t%0,r42\n\tbbit1\t%0,14,2f\n"
                             "\tmov\t%0,r49\n\tbbit0\t%0,13,1b\n2:" : "=&r"(t) :: "memory");
        }
        (void)mac_evt_eng2();                  /* delay-слот vendor: mov r3,r49 */
        UC_EVM(0x01);
#if defined(UC_STAMP_MASK) && !defined(UC_DCCM_OBJECTS)
        if (UC_STAMP_ON(STAMP_RESP_PATH))
            t_le = arc_lr(0x100);
#endif
        rx_latch_cur_gain_db();
        u32 lo = MAC_PHYSIG_PPDU_EVT_CNT_OF(mac_status_sel());
        u32 hi = MAC_PHYSIG_CCA_EVT_CNT_OF(mac_status_sel());
        if (((hi - lo) & 0x3f) >= 2)
            uc_assert((u32)__builtin_return_address(0), 69);
        if (hi != seq)
            goto tail;
        uc_mac_cmd(0xeeee07);
        uc_mac_cmd(seq);
        u32 v = VOL(uc_stats.rx_ppdu) + 1;
        VOL(uc_stats.rx_ppdu) = v;
        rx_flow_hit += 1;
        FWSH(fw_stats_dash, rx_ppdu) = v;
        hit = 1;
        u32 f = cmd20_cfg_rx_flags;
        if (rx_mode_flags & 2) {
            if (f & 2) {
                cnt[2] += 1;
                FWSH(fw_stats_dash, fa_cnt[5]) = cnt[2];
            } else {
                cnt[1] += 1;
                FWSH(fw_stats_dash, fa_cnt[3]) = cnt[1];
            }
        } else if (f & 1) {
            cnt[3] += 1;
            FWSH(fw_stats_dash, fa_cnt[2]) = cnt[3];
        } else {
            cnt[0] += 1;
            FWSH(fw_stats_dash, fa_cnt[1]) = cnt[0];
        }
        res = 0;
        goto tail;
    }
    default:                                    /* 4, 6, 7 */
        goto tail;
    }

tail:                                           /* 0x931218 */
#if defined(UC_STAMP_MASK) && !defined(UC_DCCM_OBJECTS)
    if (UC_STAMP_ON(STAMP_RESP_PATH))
        t_tl = arc_lr(0x100);
#endif
    if (hit == 1) {
busy:
        if (busy_acct.busy_start_tsf != 0)
            rx_flow_accumulate_busy_time(busy_acct.busy_start_tsf);
    }
#if defined(UC_STAMP_MASK) && !defined(UC_DCCM_OBJECTS)
    if (UC_STAMP_ON(STAMP_RESP_PATH))
        t_ac = arc_lr(0x100);
#endif
    /* busy_acct.busy_start_tsf = 0 (vendor здесь) — в каждой ветке ниже; на ветке «кадр принят» —
     * после rx_flow_step / rx_flow_handle_frame (срок SIFS): до выхода её никто не читает. */
    if (ok == 0 && res == 1) {
        busy_acct.busy_start_tsf = 0;
        uc_mac_cmd(0xeeee06);
        ppdu_evt_cnt += 1;
        VOL(uc_stats.rx_arm) += 1;
        FWSH(fwsh_diag, rx_arm) = VOL(uc_stats.rx_arm);
        /* исправлено (vendor: без ограничения): отчёт о PPDU (r42 б16) приходит по концу принимаемого PPDU — не позже
         * aPPDUMaxTime (Table 20-30) + SIFS; нет — PHY кадр потерял (ложное обнаружение), uc не висит: метка 0xff33
         * в fwsh_uc_wait, дальше — как «кадра нет» (тот же путь). */
        uc_spin_until_event_tmo(MAC_EVT1_PPDU_REPORT, UC_SPIN_PASSES(DMG_PPDU_MAX_CLK + DMG_SIFS_CLK), 0xff33);
        VOL(uc_stats.rx_no_frame) += 1;
        goto noframe;
    }
    if (res == 0) {
        busy_acct.busy_start_tsf = 0;
noframe:                                        /* 0x931244 */
        if (((mac_rx_rep2() & MAC_RX_REP2_SSW) || (mac_rx_rep3() & MAC_RX_REP3_MY_BSS_BEACON)) &&
            (mac_rx_misc() & MAC_RX_MISC_ZERO_CDOWN) && (mac_evt1() & MAC_EVT1_PPDU_REPORT))
            sls_rx.flags |= 2;
        rx_mac_prepare();
        rx_nav_update(0, 0, 0, 0);
        uc_mac_cmd(0x20d2800);
        return 0;
    }

    /* 0x9313c0: кадр принят */
    UC_EVM(0x18);
    ppdu_evt_cnt += 1;
    if (txrx_state2 & 4) {
        rx_mode_configure(0, ctx->sta);
        struct sta_entry *sta = &sta_tab[ctx->sta];
        if (sta->key_valid != 0 && (sta->qid_mask_q6 & (1u << (ctx->qid & 31)))) {
            mac_load_tx_key((const u32 *)sta->tx_key);
            ctx->flags |= (1u << 11);
        }
    }
    UC_EVM(0x19);
    {
        u32 f = txrx_state1;
        if (f & 0x7e0) {
            rx_handle_ppdu_report();
        } else if (f & 2) {
            uc_mac_sel(MAC_SEL_REM_TIME);
            uc_nop3();
            txop_sent = rx_flow_step(ctx, mac_status_sel() & MAC_REM_TIME);
            UC_STAMP(STAMP_RESP_WAIT, (rx_flow_r55_snap & 0xffff) | mac_rx_rep1() << 16,
                     (txrx_state2 & 0xffff) | txop_sent << 31);
            UC_STAMP(STAMP_RESP_WAIT, mac_rx_rep2(), mac_rx_rep3());
            UC_STAMP(STAMP_RESP_WAIT, mac_rx_misc(), mac_bap_if());
        } else {
#if defined(UC_STAMP_MASK) && !defined(UC_DCCM_OBJECTS)
            UC_STAMP_T0(STAMP_RESP_PATH, t_call);
            u32 fl = (txrx_state2 & 4) | (rx_mode_flags & 2) << 4;
#endif
            txop_sent = rx_flow_handle_frame(ctx);
#if defined(UC_STAMP_MASK) && !defined(UC_DCCM_OBJECTS)
            UC_STAMP(STAMP_RESP_PATH, (t_tl - t_le) | (t_ac - t_le) << 16, (t_call - t_le) | fl << 16 | 1u << 31);
#endif
            UC_STAMP(STAMP_RX_DUR, rx_buf_fc | (u32)rx_buf_duration << 16, rx_buf_ta[0] | (u32)rx_buf_ta[1] << 16);
#if defined(UC_STAMP_MASK) && !defined(UC_DCCM_OBJECTS)
            if (UC_STAMP_ON(STAMP_HDR_EARLY) && e3_sfd) {
                UC_STAMP(STAMP_HDR_EARLY, e3_end, e3_snr);
                UC_STAMP(STAMP_HDR_EARLY, e3_b10, e3_b12);
                UC_STAMP(STAMP_HDR_EARLY, e3_fc, e3_plcp_h);
                UC_STAMP(STAMP_HDR_EARLY, e3_st[0], e3_st[1]);
                UC_STAMP(STAMP_HDR_EARLY, e3_st[2], e3_st[3]);
                UC_STAMP(STAMP_HDR_EARLY, mac_rx_rep2() | (mac_rx_rep3() & (1u << 25)) << 6, MMIO32(0x8830ec));
                e3_sfd = 0;
            }
#endif
            if (!txop_sent && (txrx_state2 & 0x3001000)) {
                busy_acct.busy_start_tsf = 0;
                return 0;
            }
        }
    }
    busy_acct.busy_start_tsf = 0;
    r13 = 0;
    if (!txop_sent) {
        if (rx_ppdu_report_seen != 0)
            goto done;
        if (ctx->flags & 1)
            rx_txop_continue(ctx, 0);
    }
    rx_nav_update((rxf.flags >> 1) & 1, mac_rx_rep1(), mac_rx_rep2(), mac_rx_rep3());
done:
    rx_flow_hit = r13;
    VOL(uc_stats.rx_arm) += 1;
    FWSH(fwsh_diag, rx_arm) = VOL(uc_stats.rx_arm);
    uc_mac_cmd(0x20d2800);
    return res;
}

/* Общий хвост отправки ответа (0x932a80.. ×3): mtp_service_dispatch + ожидания TX.
 * ХРУПКО: тайминг практически без запаса. Ответ ACK/BA должен уйти в SIFS (3 мкс,
 * ~500 тактов). Наша -Os версия rx_flow_handle_frame (на 7-18 инструкций медленнее
 * до запроса) ловила assert 0x26 под iperf в каждой загрузке; чистый vendor — 0 из 3.
 * Механизм (железо, 2026-10-16, 3 сбоя): это не зависание. MTP отвечает (MAC_MTP_RESP_VALID) за 0-1
 * проход опроса; ilink2 uc на INT6 — в прямом коде через 3-6 инструкций после команды
 * 0x37000020; причина — MAC_SXD.MAC_HW_ICR (0x886e24) бит 5 (раз ещё и бит 4). MAC сам
 * поднимает INT6 на запоздавшую команду ответа, l2_task_report_error_bits -> 0x26.
 * Значение битов 4/5 не документировано. Глушить их нельзя (железо, 2026-10-16): vendor
 * с опозданием каждого 8-го ответа и обработчиком IRQ6, который квитирует биты 4/5 и
 * возвращается, — FWERR нет, но связь мертва (ассоциация есть, данных нет, 2 из 2);
 * без обработчика — assert и восстановление драйвером. Assert 0x26 оставлен как у vendor:
 * падение с восстановлением лучше тихо зависшей связи. Защита — только скорость пути.
 * Запас доказан на железе (2026-10-16): vendor, у которого перед каждым из трёх вызовов
 * mtp_service_dispatch (0x932a88/0x932b88/0x932c74) вставлен цикл 6×(sub.f+bnz),
 * ~12-18 тактов, не ассоциируется ни разу (20 попыток в 5 загрузках); трамплин без цикла
 * (~4 инструкции) и чистый vendor — 4 из 4 без ошибок, чередуя прогоны.
 * Участок после ответа MTP (MAC_MTP_RESP_VALID -> 0x37000020 -> 0x2008000) так же критичен: +20..30
 * инструкций учёта между r43 и командами MAC — ни одной ассоциации.
 * Решение (2026-10-16): быстрый путь в rx_flow_handle_frame (O2, запрос в MTP сразу после
 * 0x3f-команды, записи ctx/0x802298/0x802294/0x800608/0x8022d4 — после 0x19000001, где uc
 * всё равно ждёт r45). Эмулятор (80 сидов): до 0x37000020 на 17..25 инструкций (медиана
 * 20) меньше vendor, до 0x19000001 — на 20..28; железо: гибрид 3 из 3 nolost (iperf 240 с),
 * прежняя -Os версия — ошибка в каждой загрузке. Не добавлять код между входом
 * rx_flow_handle_frame и командой 0x19000001 без замера (tools/arcemu/resp_lat.py). Стенд 2026-10-30 (nop в
 * PAD_RESP_CMD, iperf): 32 nop — без ошибок, 48 — ошибка MAC уже при ассоциации: запас 32–48 тактов; с битами
 * скорости, посчитанными до пути (rx_resp_rate), — 40 nop без ошибок, 48 — ошибка: 40–48 тактов (docs/MAC-STAND.md).
 * Стандарт: Ack (802.11-2020 10.3.2.11), BlockAck на A-MPDU/BAR (10.25.3, 10.25.6), DMG CTS на RTS
 * (10.3.2.9) — через SIFS; aSIFSTime 3 мкс (Table 20-30), допуск DMG −0 %/+10 %×(aSlotTime −
 * aAirPropagationTime) ≈ +0,49 мкс (10.3.2.3.3). Момент запуска ответа, по гипотезе
 * docs/LMAC-PROTOCOL.md, держит сам MAC (0x886d10, см. rx_flow_step); от uc нужно, чтобы команды
 * успели раньше этого момента — опоздание MAC отмечает битами MAC_HW_ICR (см. выше). */
static inline __attribute__((always_inline)) void
rx_frame_tx_resp_after_req(u32 kind, struct tx_ctx_s *ctx, u32 sta, u32 resp, int fast)
{
    while (!(mac_mtp_resp() & MAC_MTP_RESP_VALID))
        ;
    UC_EVM(0x0600 | kind);
#if defined(UC_STAMP_MASK) && !defined(UC_DCCM_OBJECTS)
    if (UC_STAMP_ON(STAMP_SIFS_PTS)) {
        uc_mac_cmd_nl(0x4d000000);
        arc_nops(3);
        UC_STAMP(STAMP_SIFS_PTS, 2 | kind << 8, mac_timer_sel());
    }
#endif
    u32 r51 = mac_mtp_desc();
    if (!fast) {
        mtp_desc_lo = r51 & 0xf;
        mtp_desc_hi = r51 >> 4;
    }
    uc_mac_cmd_nl((MAC_MTP_RESP_MCS_OF(mac_mtp_resp()) << 4) | 0x3e000000);
    uc_mac_cmd_nl(0x37000020);
    if (!fast)
        uc_stats.tx_start += 1;
    u32 v = (abif_dvs_rf_ctrl_shadow & 0xfcffffff) | (rf_set_tx << 24);
    abif_dvs_rf_ctrl_shadow = v;
    MMIO32(HW_ABIF_DVS_RF_CTRL) = v;
    uc_mac_cmd_nl(0x2008000);
    uc_mac_cmd_nl(0x19000001);
    UC_EVM(0x0700 | kind);
#ifdef UC_STAMP_MASK
    if ((UC_STAMP_MASK) & (1u << STAMP_RESP_SIFS_CNT)) {   /* после срока: SIFS_CNT = от конца приёма до сюда */
        uc_mac_cmd_nl(0x4d000000);
        arc_nops(3);
        UC_STAMP(STAMP_RESP_SIFS_CNT, mac_timer_sel(), kind | (u32)rx_buf_fc << 16);
    }
#endif
    if (fast) {
        /* Отложено сюда из участка до запроса/команды 0x37000020: никто между ними эти
         * слова не читает (mtp_service_dispatch читает только 0x8005f4, rs_state[].active,
         * rs_stats[].mcs_try), а здесь uc всё равно ждёт конца передачи ответа (r45). */
        mtp_desc_lo = r51 & 0xf;
        mtp_desc_hi = r51 >> 4;
        uc_stats.tx_start += 1;
        ctx->flags &= ~1u;
        ctx->sta = sta;
        rxf.flags = (rxf.flags & ~2u) | 4;
        rxf.resp_type = resp;
    }
    while (!(mac_mtp_perm() & MAC_MTP_PERM_VALID))
        ;
    uc_mac_cmd_nl(0x18000000);
}

static inline __attribute__((always_inline)) void
rx_frame_tx_resp_seq(u32 kind, struct tx_ctx_s *ctx, u32 sta, u32 resp, int fast, u32 rate)
{
    UC_PAD(PAD_RESP_CMD);
    UC_EVM(0x0800 | kind);
    mtp_service_dispatch(kind, sta, ctx->resp_ctx8, rate);
    rx_frame_tx_resp_after_req(kind, ctx, sta, resp, fast);
}

/* ХРУПКО (СРОК SIFS): выпуск ответа через SIFS — одна последовательность для раннего и прежнего путей Ack/BlockAck,
 * DMG CTS и ответа из rx_flow_handle_frame: сектор передачи станции (0x37000005, 0x37000002, 0x3f | tx_sel — sel),
 * доп. команда (extra ≠ 0: 0x20000400 у DMG CTS), точка стресса pad, запрос MTP словами w16/w17 (MTP_W16_RESP,
 * MTP_W17_RESP — посчитаны вызывающим, до пути: прежде их считал вызов mtp_service_dispatch между сектором и запросом),
 * ожидание MTP и пуск (rx_frame_tx_resp_after_req). Команды — без журнала (uc_mac_cmd_nl). */
#define RX_RESP_ISSUE(kind, ctx, sta, resp, sel, extra, pad, w16, w17) do { \
    uc_mac_cmd_nl(0x37000005);                                             \
    uc_mac_cmd_nl(0x37000002);                                             \
    uc_mac_cmd_nl(sel);                                                    \
    if ((extra) != 0)                                                      \
        uc_mac_cmd_nl(extra);                                              \
    UC_PAD(pad);                                                           \
    UC_EVM(0x0800 | (kind));                                               \
    MTP_REQUEST_NL(w16, w17);                                              \
    rx_frame_tx_resp_after_req(kind, ctx, sta, resp, 1);                   \
} while (0)

/* Биты скорости ответа через SIFS для команды MTP 0x17 ([12:8] MCS, [1:0] = 3; 0 — MCS выбирает MAC).
 * исправлено (vendor): MCS Ack/BlockAck не задавался — MAC слал BlockAck на кадр MCS 8 на MCS 1 (стенд 2026-10-30,
 * наш uc и vendor-AP: r38 received_mcs 1 у принятого BlockAck). 802.11-2020 10.6.7.2: на кадр SC — MCS из
 * обязательных SC (1–4) не быстрее запроса и с кратчайшей передачей = min(MCS, 4); на кадр control PHY — control.
 * Без явного MCS MAC отвечает на кадр control PHY на control, на кадр SC — на MCS 1: для запросов MCS 0/1 это и есть
 * 10.6.7.2, поэтому явный MCS — только при MCS ≥ 2. RTS всегда на control PHY (10.6.7.1) — у DMG CTS биты 0.
 * СРОК: считать до пути ответа (rx_flow_handle_frame — сразу после чтения r38). Стенд, PAD_RESP_CMD 32 nop: выбор
 * MCS внутри rx_frame_tx_resp_seq — ошибка MAC 3 из 3 при ассоциации; явный MCS только при MCS ≥ 2 там же — ошибка
 * под данными 2 из 2; вычисленный, но не переданный — 2 из 2 без ошибок. */
static inline __attribute__((always_inline)) u32 rx_resp_rate(u32 mcs)
{
    return mcs >= 2 ? ((mcs < 4 ? mcs : 4) << 8) | 3 : 0;
}

/* Медленный путь (через switch в конце rx_flow_handle_frame) — без переноса записей. */
static __attribute__((noinline)) void rx_frame_tx_resp(u32 kind, struct tx_ctx_s *ctx)
{
    rx_frame_tx_resp_seq(kind, ctx, ctx->sta, 0, 0, rx_resp_rate(rx_last_mcs));
}

/* Предел ожидания MAC_BAP_RX_UPDATE в rx_get_required_response (проходов по ≥ 4 тактов; первый — вход): aPPDUMaxTime + SIFS. */
#define BAP_RX_WAIT_PASSES  ((DMG_PPDU_MAX_CLK + DMG_SIFS_CLK) / 4u + 2u)

/* Срыв ожидания MAC_BAP_RX_UPDATE: BAP не отметил приём за предел — ответа нет (возврат 0, как «ответ не нужен»),
 * rx_bap_rx_up = 0 (тень счётчика PPDU — заново в uc_hw_wait_tmo). Отдельной функцией (хвостовой переход) —
 * горячая функция не платит за неё. */
__attribute__((noinline, cold)) static u32 rx_bap_rx_timeout(void)
{
    uc_hw_wait_tmo(0xff31);
    rx_bap_rx_up = 0;
    return 0;
}

/* Общее ядро проверок быстрых путей ответа через SIFS (rx_fast_resp_ok, rx_fast_resp_pre_ok, rx_fast_cts_ok,
 * rx_fast_cfend_ok). Иначе — разбор прежним путём (rx_get_required_response решает то же по полному разбору). */
/* одиночный кадр нам от известной станции: TA в таблице адресов, не групповой, не соседа, FCS частично ок */
static inline __attribute__((always_inline)) u32 rx_fast_known_ucast(u32 r3)
{
    return (r3 & (MAC_RX_REP3_ADDR2_VALID | MAC_RX_REP3_MCAST | MAC_RX_REP3_BCAST | MAC_RX_REP3_NEIGHBOUR |
                  MAC_RX_REP3_FCS_OK_PART)) == (MAC_RX_REP3_ADDR2_VALID | MAC_RX_REP3_FCS_OK_PART);
}
/* управляющий кадр (RTS, CF-End): не SS, не Beacon, не QoS Data, не управление */
static inline __attribute__((always_inline)) u32 rx_fast_ctrl_rep1_ok(u32 r1)
{
    return !(r1 & (MAC_RX_REP1_SS | MAC_RX_REP1_NOACK_MGMT | MAC_RX_REP1_BEACON | MAC_RX_REP1_QOS_DATA |
                   MAC_RX_REP1_MGMT));
}
/* без измерения кадра (rx_meas), пропуска ответов (rx_resp_skip_cnt) и фиксированного расписания (dti_qset_mode) */
static inline __attribute__((always_inline)) u32 rx_fast_allowed(void)
{
    return VOL(rx_meas.state) != 2 && rx_resp_skip_cnt == 0 && dti_qset_mode == 0;
}
/* Ack/BlockAck: без режима BF приёма; станция s не уходит из сопровождения (как midbrp в rx_get_required_response) */
static inline __attribute__((always_inline)) u32 rx_fast_ack_sta_ok(u32 s)
{
    return !(rx_mode_flags & 1) &&
           !(uc_role_ap != 0 && !(maint_sta_mask & (1u << s)) && (maint_sta_mask_prev & (1u << s)));
}

/* Берёт ли кадр быстрый путь ответа Ack/BlockAck (rx_fast_resp) — проверка по отчёту в теле rx_flow_handle_frame, без
 * вызова: пролог rx_fast_resp (сохранение регистров) на кадре, которому быстрый путь не подходит, стоил ~90 тактов
 * (стенд 2026-11-11: Ack на кадр с б17 — 4,24 мкс от входа до MTP против 3,68). */
static inline __attribute__((always_inline)) u32 rx_fast_resp_ok(void)
{
    /* порядок — от дешёвого (регистры отчёта) к чтениям DCCM: у QoS Null (б17) и прочих отказ — за несколько
     * инструкций (иначе прежний путь Ack на QoS Null длиннее на ~75 тактов, эмулятор и стенд) */
    u32 r1 = mac_rx_rep1(), r3 = mac_rx_rep3();
    if ((r1 & (MAC_RX_REP1_QOS_DATA | MAC_RX_REP1_SS | MAC_RX_REP1_BEACON | MAC_RX_REP1_BACK | MAC_RX_REP1_NOACK_MGMT |
               MAC_RX_REP1_MGMT)) != MAC_RX_REP1_QOS_DATA)
        return 0;
    u32 agg = (r3 & MAC_RX_REP3_MPDU_AGG) || (r1 & MAC_RX_REP1_BAR);
    if (!agg && MAC_RX_MISC_TYPE_IDX_OF(mac_rx_misc()) == 8)
        return 0;                                 /* ATIM — разбор rx_get_required_response */
    if (!rx_fast_known_ucast(r3) || MAC_RX_REP3_ACK_POLICY_OF(r3) != 0)
        return 0;
    return rx_fast_allowed() && rx_fast_ack_sta_ok(MAC_RX_REP3_ADDR2_IDX_OF(r3));
}

/* Общее для учёта после пуска и отказа быстрых путей (хвосты rx_fast_*_tail, rx_post_run) — вне срока. */
/* учёт sel_nbr: станция с наименьшим усилением приёма среди тех, у кого не идёт поиск скорости; не при rx_mode_flags
 * б0/б1 (режимы приёма, bf.c) */
__attribute__((optimize("Os"), noinline))
static void rx_sel_nbr_note(u32 s)
{
    if (!(rx_mode_flags & 3) && rs_state[s].active == 0 && sel_nbr.cur_gain_db < sel_nbr.min_gain_db) {
        sel_nbr.min_gain_db = sel_nbr.cur_gain_db;
        sel_nbr.min_sta = (u8)s;
    }
}
/* ответа нет — RF обратно на приём */
static inline __attribute__((always_inline)) void rx_rf_set_rx(void)
{
    u32 v = (abif_dvs_rf_ctrl_shadow & 0xfcffffff) | (rf_set_rx << 24);
    abif_dvs_rf_ctrl_shadow = v;
    MMIO32(HW_ABIF_DVS_RF_CTRL) = v;
}
/* ответа нет — приём заново, кадр разобран без ответа (как rx_get_required_response с ответом 0) */
static inline __attribute__((always_inline)) void rx_fast_no_resp(struct tx_ctx_s *ctx)
{
    ctx->mtp_state = 0;
    rx_mac_prepare();
    rxf.flags |= 4;
    rxf.resp_type = 0;
    ctx->flags &= ~1u;
}

/* Учёт быстрого пути Ack/BlockAck после пуска (f: [7:0] — r5, б8 — QoS Null) или без ответа (f = 0) — вне срока, на
 * размер (ICCM). */
__attribute__((optimize("Os"), cold))
static __attribute__((noinline)) u32 rx_fast_resp_tail(struct tx_ctx_s *ctx, u32 s, u32 r3, u32 f)
{
    u32 r5 = f & 0xff;
    if (!r5)                                      /* ответа нет — RF обратно на приём */
        rx_rf_set_rx();
    uc_mac_cmd(0xeeee0c);
    rxf.flags &= ~0x10u;
    rxf.sta = s;
    if (!r5) {
        rx_fast_no_resp(ctx);
        uc_mac_cmd(0x14000000);
        return 1;
    }
    rx_sel_nbr_note(s);                           /* rx_mode_flags б0 исключён проверкой (rx_fast_ack_sta_ok) */
    rx_last_mcs = MAC_RX_REP3_RX_MCS_OF(r3);
    if (f >> 8) {                                 /* QoS Null — как L_9330b4 в rx_get_required_response */
        if (*(u16 *)&rx_buf_body18 & (1u << 4))
            ctx->flags |= (1u << 10);
        ctx->x34 = 1;
        ctx->x38 = mac_rx_rep3() & MAC_RX_REP3_PWR_MGMT;
    }
    ctx->mtp_state = r5;
    rx_resp_finish_restore_rx((u32)ctx, r5 == 2 ? 1 : 0, 0);
    uc_mac_cmd(0x14000000);
    if (r5 == 2)
        rx_resp_abort_t2 = 1;
    else
        rx_resp_abort_t1 = 1;
    return 1;
}

/* ХРУПКО (СРОК SIFS): быстрый путь ответа — Ack на QoS Data (802.11-2020 10.3.2.11) и BlockAck на A-MPDU / BAR
 * (10.25.3, 10.25.6) через aSIFSTime 3 мкс, допуск +0,49 (10.3.2.3.3). Стенд 2026-11-11 (метки SIFS_CNT, опыты E-R3,
 * E-R4): у кадра SC uc видит конец PPDU (r42 б14) через 1,26–1,65 мкс после конца в эфире, запрос MTP → готовность
 * ~0,87 мкс, переход RX→TX ~0,85 мкс (команды; ожидание PHY — ~50 тактов), а команда пуска позже точки SIFS даёт
 * ответ через ~0,55 мкс после неё (H-RESPCMD). Прежний путь (разбор, поиск станции, rx_get_required_response) до
 * запроса MTP шёл ~2,3–2,8 мкс. Здесь — только нужное до пуска: проверка отчёта, ожидание BAP (Ack),
 * запрос MTP, пуск; учёт (sel_nbr, rx_last_mcs, флаги, восстановление приёма) — после пуска. Перехода RX→TX нет:
 * ответ через MTP уводит тракт с приёма секвенсор ответа MAC (так же путь ответа Talyn). Стенд 2026-11-14 (опыт E-S1,
 * захваты с записью данных, оценка по двум узлам): SIFS BlockAck станции 4,67 → 3,82 мкс, Ack на QoS Null 4,74 → 3,87;
 * гейт STA 14/14, AP 8/8, FWERR 0. Ещё выше нормы 3,49 — остаток: сигнал конца PPDU SC для uc (1,26–1,65 мкс).
 * Берёт кадр: нам от известной станции (TA в таблице адресов, не групповой, не соседа), FCS частично ок, QoS Data с
 * политикой Normal Ack / BAR (не ATIM, не б17), без измерения кадра (rx_meas), без пропуска ответов
 * (rx_resp_skip_cnt), без фиксированного расписания и режима BF приёма; точка: станция не уходит из сопровождения
 * (как midbrp в rx_get_required_response — там ответа нет). Иначе — 0, кадр ничем не тронут, разбор прежним путём.
 * (Прежде, с переходом RX→TX на этом пути, запрос MTP до перехода давал uc_assert 0x26 — стенд 2026-11-11, опыт P1.)
 * Возврат 1 — кадр разобран (с ответом или без: BAP не отметил приём — ответа нет, как в rx_get_required_response). */
__attribute__((optimize("O2", "no-inline")))
static __attribute__((noinline)) u32 rx_fast_resp(struct tx_ctx_s *ctx)
{
    u32 r1 = mac_rx_rep1(), r3 = mac_rx_rep3();   /* кадр уже проверен rx_fast_resp_ok */
    UC_EVM(0x04);
    u32 s = MAC_RX_REP3_ADDR2_IDX_OF(r3);
    u32 agg = (r3 & MAC_RX_REP3_MPDU_AGG) || (r1 & MAC_RX_REP1_BAR);
    u32 kind = agg ? 1 : 0, r5 = agg ? 2 : 1;
    /* без перехода RX→TX: секвенсор ответа MAC (MTP) уводит тракт с приёма сам (как путь ответа Talyn; опыт E-S1) */
    u32 qnull = !agg && (r1 & (1u << 17));       /* б17 (QoS Null): без ожидания BAP, как в rx_get_required_response */
    /* RF «передача» до запроса MTP не пишется: её пишет rx_frame_tx_resp_after_req после 0x37000020 (как в
     * rx_fast_resp_early; стенд 2026-11-15: без ранней записи BlockAck на 0,14 мкс раньше, FWERR 0) */
    if (agg || qnull) {
        if (qnull)
            rx_bap_rx_up = 1;
    } else {
        /* как bap_rx_check: ожидание MAC_BAP_RX_UPDATE (r53 б3) с пределом — до Ack */
        VOL(uc_wait_marker) = 0xff31;
        __asm__ goto("mov\tr12,%0\n"
                     "1:\tsub.f\tr12,r12,1\n\tbeq\t%l[tmo]\n"
                     "\tmov\tr11,r53\n\tbbit0\tr11,3,1b"
                     :: "i"(BAP_RX_WAIT_PASSES) : "r11", "r12", "memory", "cc" : tmo);
        VOL(uc_wait_marker) = 0;
        rx_bap_rx_up = (mac_bap_if() & MAC_BAP_RX_UP_STATUS) ? 1 : 0;
        uc_mac_cmd_nl(0x1c000008);
        if (!rx_bap_rx_up)
            goto no_resp;
    }
    u32 qid = MAC_RX_REP1_DATA_QID_OF(r1);
    u32 w17 = MTP_W17_RESP(0, s, qid, rx_resp_rate(MAC_RX_REP3_RX_MCS_OF(r3)));   /* виды 0/1 — одно слово */
    ctx->resp_ctx8 = qid;
    RX_RESP_ISSUE(kind, ctx, s, r5, sta_tab[s].tx_sel | 0x3f000000, 0, PAD_RESP_CMD, MTP_W16_RESP(kind), w17);
    return rx_fast_resp_tail(ctx, s, r3, r5 | qnull << 8);
tmo:
    rx_bap_rx_timeout();
no_resp:
    return rx_fast_resp_tail(ctx, s, r3, 0);
}

/* Предварительный отчёт для раннего пути (rx_fast_resp_early): как rx_fast_resp_ok, но r36/r38 могут быть ещё не
 * заполнены. Стенд 2026-11-15 (метки UC_EVM с битами отчёта на входе): у ~40 % ответов BlockAck к входу в r36 только
 * б3 reservation_detected, в r38 — ADDR2_VALID и FCS_OK_PART без MPDU_AGG; QoS Data и A-MPDU — вместе с отчётом. Тогда
 * кадр предсказывается как QoS Data в A-MPDU (ответ BlockAck), а сверка с окончательным отчётом (QoS, A-MPDU, станция,
 * политика) решает: не сошлось — ничего не выдано, разбор прежним путём. Тип известен (иные биты r36) — только QoS
 * Data. */
static inline __attribute__((always_inline)) u32 rx_fast_resp_pre_ok(u32 r1, u32 r3)
{
    if (r1 & MAC_RX_REP1_QOS_DATA) {
        if ((r1 & (MAC_RX_REP1_QOS_DATA | MAC_RX_REP1_SS | MAC_RX_REP1_BEACON | MAC_RX_REP1_BACK |
                   MAC_RX_REP1_NOACK_MGMT | MAC_RX_REP1_MGMT)) != MAC_RX_REP1_QOS_DATA)
            return 0;
        if (!(r3 & MAC_RX_REP3_MPDU_AGG) && !(r1 & MAC_RX_REP1_BAR) && MAC_RX_MISC_TYPE_IDX_OF(mac_rx_misc()) == 8)
            return 0;
    } else if (r1 & ~MAC_RX_REP1_RSV) {
        return 0;
    }
    if (!rx_fast_known_ucast(r3) || MAC_RX_REP3_ACK_POLICY_OF(r3) != 0)
        return 0;
    return rx_fast_allowed() && rx_fast_ack_sta_ok(MAC_RX_REP3_ADDR2_IDX_OF(r3));
}

/* Поля отчёта r37/r39, по которым rx_fast_resp_ok и rx_fast_resp выбирают ответ и его параметры: ранний путь сверяет
 * их в окончательном отчёте с предварительными. */
#define RX_EARLY_REP1_M (MAC_RX_REP1_QOS_DATA | MAC_RX_REP1_MGMT | MAC_RX_REP1_SS | MAC_RX_REP1_BEACON | MAC_RX_REP1_BACK | \
                         MAC_RX_REP1_BAR | MAC_RX_REP1_NOACK_MGMT | (1u << 17))   /* qid — из окончательного */
#define RX_EARLY_REP3_M ((7u << 8) | MAC_RX_REP3_ADDR2_VALID | MAC_RX_REP3_MCAST | MAC_RX_REP3_BCAST | \
                         MAC_RX_REP3_NEIGHBOUR | MAC_RX_REP3_FCS_OK_PART | MAC_RX_REP3_ACK_POLICY | MAC_RX_REP3_MPDU_AGG)
/* MCS принятого кадра (r38 [24:20]) в сверку не входит: до отчёта он 0 (стенд 2026-11-15, метки UC_EVM с расходящимися
 * битами: у 2516 из 2546 несошедшихся предсказаний — только MCS 0 → 8); скорость ответа — по окончательному. */

/* ХРУПКО (СРОК SIFS): ранний путь Ack/BlockAck — то же, что rx_fast_resp, но всё, что не ждёт окончательного отчёта о
 * PPDU и не выдаёт команд, — до него. Стенд 2026-11-15 (метки UC_EVM в записях событий PMC, время от конца приёма
 * 0x1d): uc видит конец через 0,10 мкс, входит в rx_flow_handle_frame через 0,57, а отчёт (r42 б16) у PPDU с MPDU
 * длиннее ~200 Б приходит только через 1,9 мкс (у коротких — 0,73; у RTS — 0,79). От отчёта до запроса MTP прежний
 * путь шёл 0,85 мкс (проверки, пролог, скорость, команды сектора, mtp_service_dispatch); запрос → начало передачи у
 * MAC ~0,9 мкс на любом пути. es1: BlockAck через 3,64 мкс от 0x1d при нижней границе MAC 2,945 (DMG CTS, CF-End) —
 * сумма SIFS 7,53–7,56 мкс, нарушение 10.3.2.3.3 (норма ≤ 6,98).
 * Здесь по предварительному отчёту (тот же кадр: TA, политика известны по заголовку; тип в r36 может быть ещё не
 * известен — тогда QoS Data в A-MPDU, см. rx_fast_resp_pre_ok) до отчёта считаются станция, вид ответа, скорость
 * (MCS прошлого кадра), слова запроса MTP (0x16/0x17, как mtp_service_dispatch), сектор; после отчёта — сверка полей
 * RX_EARLY_REP*_M окончательного отчёта с предварительными, qid, MCS (пересчёт скорости только при расхождении),
 * команды сектора и запрос MTP. Решение об ответе — только по окончательному отчёту: поля разошлись — возврат 2
 * (ничего не выдано, буфер переключён), разбор прежним путём по окончательному. Возврат 1 — кадр разобран.
 * Чего здесь нет и почему (стенд 2026-11-15, чередование захватов, судья эфира, сумма SIFS BlockAck):
 *  - RF «передача» до запроса MTP у A-MPDU и QoS Null — её пишет rx_frame_tx_resp_after_req после 0x37000020; без
 *    ранней записи 7,02–7,05 → 6,87–6,90 мкс (норма), FWERR 0;
 *  - переключение буфера приёма до запроса — после пуска (RX_BUF_TOGGLE; до запроса ~12 тактов с журналом команд, а
 *    буфер читает только учёт после пуска), с пересчётом скорости только при расхождении MCS: 7,09–7,16 → 7,02–7,05;
 *  - RF «передача» и команды сектора до отчёта — uc_assert 0x26 (поздняя команда ответа) при ассоциации на обоих узлах;
 *  - опрос r36/r38 до отчёта — одиночные MPDU позже на 0,1–0,35 мкс, A-MPDU не раньше;
 *  - RF «передача» до запроса и в ветке Ack (ожидание BAP), и в прежнем rx_fast_resp; не сбылось только предсказание
 *    A-MPDU (одиночный QoS Data / QoS Null той же станции) — Ack здесь же, а не прежним путём (у коротких кадров отчёт
 *    к входу часто ещё не пришёл): Ack на QoS Null у ответчика 0x1d → 0x2e 3,13 → 2,59 мкс (стенд 2026-11-15, qn1,
 *    события PMC; BlockAck 2,98–3,0, DMG CTS 2,93), BlockAck 6,86–6,92, гейт STA 14/14, AP 8/8, FWERR 0.
 * Итог: от отчёта до запроса 0,85 → 0,39 мкс, ранний путь — у всех ответов BlockAck (прежде ~40 % отсекала проверка
 * предварительного отчёта); прибытие BlockAck у запросчика (его 0x35 → 0x13 BlockAck, без калибровки) на A-MPDU
 * 7,96 → 7,58 мкс, на одиночных MPDU без изменений; сумма SIFS BlockAck 7,55 → 6,87–6,90 мкс.
 * Запас (стенд 2026-11-16, PAD_EARLY_REQ — nop перед запросом MTP): 64 такта — момент ответа не сдвигается (его держит
 * MAC), 128 — станция теряет связь: на код от отчёта до запроса — меньше 128 тактов сверх нынешнего. */
__attribute__((optimize("O2", "no-inline")))
static __attribute__((noinline)) u32 rx_fast_resp_early(struct tx_ctx_s *ctx, u32 r1, u32 r3)
{
    /* r1, r3 — предварительный отчёт, проверен rx_fast_resp_pre_ok; тип в r36 ещё не известен — ожидается QoS Data в
     * A-MPDU (сверка — по окончательному) */
    UC_EVM(0x0a);
    u32 pred = !(r1 & MAC_RX_REP1_QOS_DATA);
    if (pred) {
        r1 = MAC_RX_REP1_QOS_DATA;
        r3 |= MAC_RX_REP3_MPDU_AGG;
    }
    u32 s = MAC_RX_REP3_ADDR2_IDX_OF(r3);
    u32 agg = (r3 & MAC_RX_REP3_MPDU_AGG) || (r1 & MAC_RX_REP1_BAR);
    u32 kind = agg ? 1 : 0, r5 = agg ? 2 : 1;
    u32 qnull = !agg && (r1 & (1u << 17));
    u32 sel = sta_tab[s].tx_sel | 0x3f000000;
    /* слова запроса MTP — как mtp_service_dispatch(kind, s, qid, rx_resp_rate(MCS)) для вида 0/1; qid и MCS принятого
     * (rx_resp_rate) — после отчёта */
    u32 w17 = MTP_W17(0), rs = (txrx_state1 & 2u) && rs_state[s].active != 0, pm = rx_last_mcs;
    if (rs)
        w17 |= MTP_RATE((u32)rs_sta_mcs_try(s));
    else
        w17 |= rx_resp_rate(pm);                  /* MCS — как у прошлого кадра; после отчёта — сверка */
    u32 w16 = MTP_W16_RESP(kind);
    while (!(mac_evt1() & MAC_EVT1_PPDU_REPORT))
        ;
    UC_EVM(0x03);
    u32 f1 = mac_rx_rep1(), f3 = mac_rx_rep3();
    if (((f1 ^ r1) & RX_EARLY_REP1_M) || ((f3 ^ r3) & RX_EARLY_REP3_M) ||
        (!agg && MAC_RX_MISC_TYPE_IDX_OF(mac_rx_misc()) == 8)) {
        /* не сбылось только предсказание A-MPDU (тип был неизвестен): одиночный QoS Data / QoS Null той же станции с
         * Normal Ack — Ack здесь же (вид 0), а не прежним путём (у коротких кадров отчёт к входу ещё не пришёл чаще) */
        if (!pred || ((f1 ^ r1) & RX_EARLY_REP1_M & ~(1u << 17)) ||
            ((f3 ^ r3) & RX_EARLY_REP3_M & ~MAC_RX_REP3_MPDU_AGG) || (f3 & MAC_RX_REP3_MPDU_AGG) ||
            MAC_RX_MISC_TYPE_IDX_OF(mac_rx_misc()) == 8) {
            UC_EVM(0x09);
            RX_BUF_TOGGLE();
            return 2;
        }
        UC_EVM(0x0b);
        agg = 0;
        kind = 0;
        r5 = 1;
        qnull = (f1 >> 17) & 1;
        w16 = MTP_W16_RESP(0);
    }
    r3 = f3;
    u32 qid = MAC_RX_REP1_DATA_QID_OF(f1);
    w17 |= MTP_CTX(qid);
    if (!rs && MAC_RX_REP3_RX_MCS_OF(f3) != pm)
        w17 = (w17 & ~0x1f03u) | rx_resp_rate(MAC_RX_REP3_RX_MCS_OF(f3));
    if (agg || qnull) {
        if (qnull)
            rx_bap_rx_up = 1;
    } else {
        /* как в rx_fast_resp: ожидание MAC_BAP_RX_UPDATE (r53 б3) с пределом — до Ack */
        VOL(uc_wait_marker) = 0xff31;
        __asm__ goto("mov\tr12,%0\n"
                     "1:\tsub.f\tr12,r12,1\n\tbeq\t%l[tmo]\n"
                     "\tmov\tr11,r53\n\tbbit0\tr11,3,1b"
                     :: "i"(BAP_RX_WAIT_PASSES) : "r11", "r12", "memory", "cc" : tmo);
        VOL(uc_wait_marker) = 0;
        rx_bap_rx_up = (mac_bap_if() & MAC_BAP_RX_UP_STATUS) ? 1 : 0;
        uc_mac_cmd_nl(0x1c000008);
        if (!rx_bap_rx_up)
            goto no_resp;
    }
    RX_RESP_ISSUE(kind, ctx, s, r5, sel, 0, PAD_EARLY_REQ, w16, w17);
    ctx->resp_ctx8 = qid;                         /* до этого места его никто не читает */
    RX_BUF_TOGGLE();
    return rx_fast_resp_tail(ctx, s, r3, r5 | qnull << 8);
tmo:
    rx_bap_rx_timeout();
no_resp:
    RX_BUF_TOGGLE();
    return rx_fast_resp_tail(ctx, s, r3, 0);
}

/* Берёт ли CF-End быстрый путь ответного CF-End (rx_fast_cfend) — проверка без вызова (см. rx_fast_resp_ok). */
static inline __attribute__((always_inline)) u32 rx_fast_cfend_ok(void)
{
    u32 r3 = mac_rx_rep3();
    return (mac_rx_rep2() & MAC_RX_REP2_CF_END) && rx_buf_duration != 0 &&
           rx_fast_known_ucast(r3) && rx_fast_ctrl_rep1_ok(mac_rx_rep1()) && rx_fast_allowed();
}

/* Учёт быстрого пути ответного CF-End после пуска — вне срока, на размер (ICCM); то, что прежний путь делал в
 * rx_flow_handle_frame и rx_get_required_response (CF-End нам с Duration ≠ 0 — ответ 8). */
__attribute__((optimize("Os"), cold))
static __attribute__((noinline)) u32 rx_fast_cfend_tail(struct tx_ctx_s *ctx, u32 s, u32 r3, u32 d)
{
    rx_cf_end_nav_reset(d);                       /* NAV — после ответа, как прежде */
    uc_mac_cmd(0xeeee0c);
    rxf.flags &= ~0x10u;
    if (r3 & MAC_RX_REP3_RX_MCS)
        sta_tab[s].flags &= ~2u;
    rx_sel_nbr_note(s);
    rx_last_mcs = MAC_RX_REP3_RX_MCS_OF(r3);
    ctx->mtp_state = 8;
    ctx->sta = s;
    rxf.flags = (rxf.flags & ~2u) | 4;
    rxf.resp_type = 8;
    ctx->flags &= ~1u;
    rx_resp_finish_restore_rx((u32)ctx, 3, 0);
    uc_mac_cmd(0x14000000);
    return 1;
}

/* ХРУПКО (СРОК SIFS): быстрый путь ответного CF-End (802.11-2020 10.39.8.1 — держатель TXOP усекает TXOP CF-End, ответ
 * CF-End через SIFS; 9.3.1.6 Duration). CF-End — control PHY: конец PPDU uc видит рано (как RTS, стенд 2026-11-11);
 * прежний путь (поиск станции, учёт, rx_get_required_response, нижний switch) шёл до пуска ~1,2 мкс лишних. Здесь —
 * команды режима Duration (0x15/0x14000007, как rx_get_required_response), пуск прямой передачи
 * (rx_send_cf_end_response: 0x19 — в tx_send_imm_response, кадр в FIFO — после, MAC держит точку SIFS); учёт после.
 * Перехода RX→TX (rx_end_switch_to_tx) нет — тракт уводит с приёма сам пуск, как у ответов через MTP: стенд 2026-11-16
 * (чередование 6 загрузок, события PMC) у ответчика 0x2e − 0x1d 2,964 → 2,885 мкс (нижняя граница MAC, как DMG CTS),
 * сумма SIFS 6,39 → 6,20–6,24, FWERR 0; эмуляция 388 → 288 тактов до 0x37000020. */
__attribute__((optimize("O2", "no-inline")))
static __attribute__((noinline)) u32 rx_fast_cfend(struct tx_ctx_s *ctx)
{
    u32 r3 = mac_rx_rep3();
    u32 s = MAC_RX_REP3_ADDR2_IDX_OF(r3);
    rxf.sta = s;
    uc_mac_cmd_nl(0x15000000);
    uc_mac_cmd_nl(0x14000007);
    /* сектор передачи станции — как прежний путь перед нижним switch (0x37000005/0x37000002/0x3f | tx_sel) */
    uc_mac_cmd_nl(0x37000005);
    uc_mac_cmd_nl(0x37000002);
    uc_mac_cmd_nl(sta_tab[s].tx_sel | 0x3f000000);
    u32 d = rx_send_cf_end_response();
    return rx_fast_cfend_tail(ctx, s, r3, d);
}

/* Берёт ли RTS быстрый путь DMG CTS (rx_fast_cts) — проверка без вызова (см. rx_fast_resp_ok). */
static inline __attribute__((always_inline)) u32 rx_fast_cts_ok(void)
{
    u32 r3 = mac_rx_rep3();
    return (mac_rx_rep2() & MAC_RX_REP2_RTS) &&
           rx_fast_known_ucast(r3) && rx_fast_ctrl_rep1_ok(mac_rx_rep1()) && rx_fast_allowed();
}

/* Учёт быстрого пути DMG CTS после пуска (ok = 1) или без ответа (ok = 0) — вне срока, на размер (ICCM). */
__attribute__((optimize("Os"), cold))
static __attribute__((noinline)) u32 rx_fast_cts_tail(struct tx_ctx_s *ctx, u32 s, u32 r3, u32 tsf, u32 t_in, u32 ok)
{
    rx_nav_check_idle_at(tsf + ((u8 *)&ifs.sifs)[1], 0, 0);   /* учёт rx_nav_check_idle_at: снятие истёкшего NAV */
    if (!ok)
        rx_rf_set_rx();
    uc_mac_cmd(0xeeee0c);
    rxf.flags &= ~0x10u;
    tx_busy_start_tsf = uc_read_tsf_lo() - 0xe - (arc_lr(0x100) - t_in) / 165u;
    mac_mon_report.rx_rts += 1;
    if (!(txrx_state1 & 8)) {
        uc_stats.rts_rx += 1;
        FWSH(fwsh_diag, rts_rx) += 1;
    }
    rx_last_mcs = MAC_RX_REP3_RX_MCS_OF(r3);
    if (ok) {
        rx_sel_nbr_note(s);
        ctx->mtp_state = 3;
        rx_resp_finish_restore_rx((u32)ctx, 5, 0);
        mac_mon_report.tx_cts += 1;
    } else {
        rx_fast_no_resp(ctx);
    }
    uc_mac_cmd(0x14000000);
    return 1;
}

/* ХРУПКО (СРОК SIFS): быстрый путь DMG CTS на RTS (802.11-2020 10.3.2.9; SIFS 10.3.2.3.3). RTS — control PHY: конец
 * PPDU uc видит через ~0,58 мкс после конца в эфире (стенд 2026-11-11, SIFS_CNT на входе rx_flow_handle_frame), прежний
 * путь (поиск станции, учёт, rx_get_required_response) шёл до запроса MTP ещё ~1,2 мкс. Здесь — условия ответа
 * rx_get_required_response (ack_cts: ждущий BF к отправителю при закрытом окне, NAV по 10.3.2.9 — занят не кадром
 * отправителя RTS — без ответа), запрос MTP и пуск; учёт — после пуска. Перехода RX→TX на пути ответа нет (тракт уводит
 * секвенсор MTP, как у Ack/BlockAck): стенд 2026-11-16 (чередование 6 загрузок) 0x2e − 0x1d 2,921 → 2,885 мкс, сумма
 * SIFS 6,31–6,33 → 6,24–6,27, FWERR 0; эмуляция 401 → 299 тактов. Без ответа — переход, как прежний путь на RTS.
 * Берёт RTS нам от известной станции (TA в таблице адресов, не групповой, не соседа, FCS частично ок), без измерения
 * кадра, пропуска ответов и фиксированного расписания; иначе 0 — разбор прежним путём. Возврат 1 — разобран. */
__attribute__((optimize("O2", "no-inline")))
static __attribute__((noinline)) u32 rx_fast_cts(struct tx_ctx_s *ctx)
{
    u32 r3 = mac_rx_rep3();                       /* кадр уже проверен rx_fast_cts_ok */
    u32 s = MAC_RX_REP3_ADDR2_IDX_OF(r3);
    UC_STAMP_T0(STAMP_CTS_FAST, c0);
#if defined(UC_STAMP_MASK) && !defined(UC_DCCM_OBJECTS)
    u32 e_sifs = 0;
    if (UC_STAMP_ON(STAMP_CTS_FAST)) {
        uc_mac_cmd_nl(0x4d000000);
        arc_nops(3);
        e_sifs = mac_timer_sel();
    }
#endif
    /* Условия ответа (ack_cts в rx_get_required_response: ждущий BF к отправителю при закрытом окне, NAV по 10.3.2.9).
     * RF «передача» — в rx_frame_tx_resp_after_req (ранняя запись на стенде пуск не ускоряла). */
    rxf.sta = s;
    /* TSF — только при взведённом NAV (rx_nav_check_idle_at смотрит его лишь при rx_nav.flags & 3 == 3; иначе ответ
     * «NAV свободен» и снятие б0 — то же без TSF); tx_busy_start_tsf — после пуска, с поправкой на прошедшее время
     * (чтение TSF на пути — ~12 тактов, до точки SIFS их не хватало, стенд 2026-11-11) */
    u32 t_in = arc_lr(0x100);
    u32 tsf = (rx_nav.flags & 3) == 3 ? uc_read_tsf_lo() : 0;
    u32 go = 1;
    if (VOL(link_stat[s].bf_reasons) != 0 && FWSH(fwsh_sp_gate, init_hold) == 0)
        go = 0;
    else if (__builtin_expect((rx_nav.flags & 3) == 3 &&
                              (s32)(tsf + ((u8 *)&ifs.sifs)[1] - rx_nav.end_tsf) < 0, 0) &&
             !(rx_nav.nav_ta[0] == rx_buf_ta[0] && rx_nav.nav_ta[1] == rx_buf_ta[1] &&
               rx_nav.nav_ta[2] == rx_buf_ta[2])) {
        /* NAV занят (решение rx_nav_check_idle_at — на месте, без вызова; сам вызов с его учётом — ниже) */
        txr.rts_nav_busy += 1;
        go = 0;
    }
    UC_STAMP_T0(STAMP_CTS_FAST, c1);
    if (!go) {
        rx_end_switch_to_tx();                    /* без ответа — переход, как прежний путь на RTS */
        goto no_resp;
    }
    UC_STAMP_T0(STAMP_CTS_FAST, c2);
    /* RTS — control PHY: MCS ответа выбирает MAC (rx_resp_rate) */
    RX_RESP_ISSUE(5, ctx, s, 3, sta_tab[s].tx_sel | 0x3f000000, 0x20000400, PAD_RESP_CMD, MTP_W16_RESP(5),
                  MTP_W17_RESP(5, s, 0, 0));
    UC_STAMP(STAMP_CTS_FAST, (c1 - c0) | (c2 - c0) << 16, e_sifs);
    return rx_fast_cts_tail(ctx, s, r3, tsf, t_in, 1);
no_resp:
    return rx_fast_cts_tail(ctx, s, r3, tsf, t_in, 0);
}

/* O2 точечно: путь до ответа MTP критичен по времени (ХРУПКО, см. rx_frame_tx_resp_seq);
 * no-inline — вызываемые vendor-функции остаются вызовами (eqcheck, размер ICCM). */
__attribute__((optimize("O2", "no-inline")))
u32 rx_flow_handle_frame(struct tx_ctx_s *a)
{
    /* 6.2 asm 0x931f04.
     * ХРУПКО: путь от входа до запроса ответа в MTP (rx_frame_tx_resp и др.) — без
     * запаса по времени, см. комментарий у rx_frame_tx_resp. */
    struct tx_ctx_s *ctx = a;                   /* r14 */
    u8 *f = rx_buf;                     /* r15 — принятый кадр */
    struct bcn_rx_s *ss = &bcn_rx;              /* r13 */
    volatile u32 *sta = (volatile u32 *)&rxf.sta;
    u32 local;                                  /* [sp] */

    UC_PAD(PAD_RESP_ENTRY);
    UC_EVM(0x02);
    UC_STAMP_T0(STAMP_CTS_PATH, t_in);
#if defined(UC_STAMP_MASK) && !defined(UC_DCCM_OBJECTS)
    if (UC_STAMP_ON(STAMP_SIFS_PTS)) {
        uc_mac_cmd(0x4d000000);
        arc_nops(3);
        UC_STAMP(STAMP_SIFS_PTS, 1, mac_timer_sel());
    }
#endif
    u32 early = 0;
#ifndef UC_BENCH
    /* Ранний путь Ack/BlockAck (rx_fast_resp_early, СРОК SIFS): отчёта ещё нет, а предварительный r36/r38 — кадр
     * быстрого пути. Одна проверка на входе, без ожидания: стенд 2026-11-15 (прибытие BlockAck у запросчика, события
     * PMC) — опрос r36/r38 до признака QoS Data / A-MPDU охватывал больше кадров, но одиночные MPDU приходили позже
     * на 0,1–0,35 мкс, A-MPDU — не раньше; ранний путь и после пришедшего отчёта — тоже без выигрыша. */
    u32 p1 = mac_rx_rep1(), p3 = mac_rx_rep3();
    if (!(mac_evt1() & MAC_EVT1_PPDU_REPORT) && rx_fast_resp_pre_ok(p1, p3)) {
        early = rx_fast_resp_early(ctx, p1, p3);
        if (early == 1)
            return 0;
    }
#endif
    if (!early) {
        if (!(mac_evt1() & MAC_EVT1_PPDU_REPORT))
            uc_wait_event_busy(MAC_EVT1_PPDU_REPORT, 0);
        UC_EVM(0x03);
        RX_BUF_TOGGLE();
    }
    UC_STAMP_T0(STAMP_CTS_PATH, t_rep);
    /* Быстрый путь ответа (rx_fast_resp, СРОК SIFS) — по виду кадра (r36, одно сравнение): прочим кадрам путь прежний. */
#ifndef UC_BENCH                              /* сборка микротестов (uc/bench.c) — без быстрых путей: места в ICCM нет */
    if (rx_fast_resp_ok()) {
        rx_fast_resp(ctx);
        return 0;
    }
    if (rx_fast_cts_ok()) {
        UC_STAMP_T0(STAMP_CTS_FAST, t_call);
        rx_fast_cts(ctx);
        UC_STAMP(STAMP_CTS_FAST, 0xd0000000u | (t_rep - t_in), t_call - t_in);
        return 0;
    }
    if (rx_fast_cfend_ok()) {
        rx_fast_cfend(ctx);
        return 0;
    }
#endif
    {
        /* Быстрая проверка — по абсолютному адресу, без базы в регистре: путь до ответа (ХРУПКО). */
        if (VOL(rx_meas.state) == 2) {
        struct rx_meas_ctx *m = &rx_meas;
        if (m->kind != 0 && m->kind <= 6 && rx_capture_match_filter(m) != 0) {
            switch (m->kind) {
            case RX_MEAS_ENERGY: rx_meas_append_sample(m, 0); break;
            case RX_MEAS_PLCP: rx_meas_finish_plcp(m); break;
            case RX_MEAS_PKT: rx_meas_capture_frame(m, 0); break;
            case 5:
                uc_mac_sel(MAC_SEL_TSF_LOW);
                uc_nop3();
                m->snap_sel5 = mac_status_sel();
                uc_mac_sel(MAC_SEL_TSF_HIGH);
                uc_nop3();
                m->snap_sel6 = mac_status_sel();
                m->state = 1;
                bg_task_set_pending_bit(0);
                break;
            default: break;
            }
        }
        }
    }

    if (mac_rx_rep1() & MAC_RX_REP1_BEACON) {
        /* 0x932098: маяк/SSW от сети */
        bti_cnt.net_bcn_rx += 1;
        UC_STAMP(STAMP_BCN_TSF, uc_read_tsf_lo() - MMIO32(HW_MAC_BI_START_TSF_LO),
                 (1u << 31) | ((mac_rx_rep3() & MAC_RX_REP3_MY_BSS_BEACON) << 30) | ((rx_buf_bcn_ssw >> 1) & 0x1ffu));
        uc_mac_cmd(0x49000100);
        u32 r2 = mac_rx_rep3() & MAC_RX_REP3_MY_BSS_BEACON;
        ss->my_bss = (u8)r2;
        if (((rx_buf_body18 | (rx_buf_body19 << 8)) & 0x780) == 0) {
            ss->bi_ctrl[0] = f[23]; ss->bi_ctrl[1] = rx_buf_body18; ss->bi_ctrl[2] = rx_buf_body19; ss->bi_ctrl[3] = rx_buf_body1a;
            ss->bi_ctrl[4] = rx_buf_brp_req; ss->bi_ctrl[5] = rx_buf_body1c;
            u32 r3 = rx_buf_bcn_dmg_params;
            u32 r4 = (ss->bi_ctrl[1] >> 2) & 0xf;
            ss->bss_type = r3 & 3;
            /* FSS < aSSFramesPerSlot (abft.h) или IsResponderTXSS = 0: в этом A-BFT не участвуем. RXSS ответчика
             * (10.42.2.3.3) — все SSW одним выбранным сектором; мы делаем только TXSS — исправлено (vendor: шёл
             * развёрткой секторов и в RXSS-A-BFT). */
            if (r4 < 4) {
                ss->abft_here = 0;
                ss->abft_go = 0;
                goto chk;
            }
            if (!(ss->bi_ctrl[1] & BCN_BIC1_IS_RESP_TXSS)) {
                ss->abft_here = 0;              /* маяк свой: BSSID записать (ниже), A-BFT пропустить */
                ss->abft_go = 0;
                goto bssid;
            }
            /* 0x9321e0 */
            ss->abft_here = 1;
            u32 r3b = abft_cfg.responder_mode, r7 = abft_cfg.beacon_type;
            int cnt36 = 0, cnt38 = 0;
            if (r3b == 3)
                cnt36 = 1;
            else if (r3b == 0 && maint_sta_mask != 0)
                cnt36 = 1;
            else if (r3b == 1 && maint_sta_mask == 0)
                cnt36 = 1;
            else {
                u32 h = ss->bi_ctrl[0] | (ss->bi_ctrl[1] << 8);
                if (r7 == 0 && (h & 2))
                    cnt38 = 1;
                else if (r7 == 1 && !((ss->bi_ctrl[0] | (ss->bi_ctrl[1] << 8)) & 2))
                    cnt38 = 1;
            }
            if (!cnt36 && !cnt38 && (ss->bi_ctrl[0] & 2u) && !abft_discovery_ok_call())
                cnt38 = 1;                      /* 10.42.5.1: условия Discovery Mode не выполнены (вызов — вне пути ответа) */
            if (cnt36) {
                ss->abft_skip_mode += 1;
                ss->abft_go = 0;
            } else if (cnt38) {
                ss->abft_skip_type += 1;
                ss->abft_go = 0;
            } else {
                if (!((ss->bi_ctrl[0] & 3u) == 3u && abft_discovery_addressed_call()) && abft_relax_skip()) {   /* 10.42.5.2 */
                    ss->abft_skip_relax += 1;
                    ss->abft_go = 0;
                } else {
                    ss->abft_try += 1;
                    ss->abft_go = 1;
                    uc_mac_sel(MAC_SEL_BF_METRIC);
                    uc_nop3();
                    u32 r11 = mac_status_sel();
                    local = r11;
                    r11 = MAC_BF_METRIC_OF(r11);
                    ss->metric = (r11 > 1023) ? r11 - 0x800 : r11;
                    ss->snr_rep = snr_report_phy();
                    ss->sector = (u8)(rx_buf_bcn_ssw >> 10);
                    ss->antenna = rx_buf_bcn_ssw_hi & 3;
                    r2 = ss->my_bss;
                }
            }
        } else {
            ss->abft_here = 0;
            ss->abft_go = 0;
        }
        /* 0x932144 */
bssid: {
        const struct ieee80211_hdr *bh = (const struct ieee80211_hdr *)f;   /* у маяка addr1 = BSSID */
        ss->bssid[0] = bh->addr1.h[0];
        ss->bssid[1] = bh->addr1.h[1];
        ss->bssid[2] = bh->addr1.h[2];
        }
chk:                                            /* 0x93215c */
        if (r2 != 0 || ss->abft_go != 0) {
            u32 r3 = txrx_state1 & 8;
            u32 r15 = 1;
            if (uc_role != 3 || !((ss->bi_ctrl[0] | (ss->bi_ctrl[1] << 8)) & 2) || ss->bss_type == 3)
                r15 = 0;
            if (r3 == 0) {
                uc_stats.rx_x68 += 1;
                txrx_state2 |= (1u << 10);
            }
            rx_mac_prepare();
            ctx->flags &= ~1u;
            if (r15) {
                rx_update_nav_from_frame(0);
                return 0;
            }
            struct mac_mon_slot_s *e = &mac_mon_slot[mac_mon_slot_idx];
            e->rx_bcon += 1;
            e->detected = 1;
            uc_stats.rx_bcn_resp += 1;
            txrx_state2 |= (1u << 24);
            return 0;
        }
    }

    /* 0x932070 */
    if ((mac_rx_rep1() & MAC_RX_REP1_NOACK_MGMT) && rx_is_brp_frame() != 0) {
        u32 r8 = 8;
        if (mac_rx_rep3() & MAC_RX_REP3_ADDR2_VALID)
            r8 = MAC_RX_REP3_ADDR2_IDX_OF(mac_rx_rep3());
        *sta = r8;
        uc_stats.brp_rx += 1;
        if (!(txrx_state1 & 4))
            txrx_state2 |= (1u << 25);
        rx_mac_prepare();
        ctx->flags &= ~1u;
        return 0;
    }

    /* 0x9323d4 */
    uc_mac_cmd(0xeeee0c);
    ctx->mtp_state = 0;
    /* vendor: local / rxf.flags б4 = 1, если прошлый кадр был с RD от известной станции (rxf.flags б3) и есть кадр в
     * очереди этой станции, — заготовка ответа RD. RD мы не принимаем (ниже, «RD отключён»): б3 не ставится, б4 — 0. */
    local = 0;
    rxf.flags &= ~0x10u;
    uc_nop3();
    uc_mac_sel(MAC_SEL_PLCP_RX);
    uc_nop3();
    if (((mac_rx_rep2() & MAC_RX_REP2_CF_END) && rx_buf_duration != 0) ||
        (mac_rx_rep2() & MAC_RX_REP2_RTS) || (mac_status_sel() & MAC_PLCP_SIFS_RESP))
        rx_end_switch_to_tx();
    UC_STAMP_T0(STAMP_CTS_PATH, t_sw);
    if (mac_rx_rep3() & MAC_RX_REP3_ADDR2_VALID) {
        *sta = MAC_RX_REP3_ADDR2_IDX_OF(mac_rx_rep3());
    } else if (mac_rx_rep1() & MAC_RX_REP1_BEACON) {
        *sta = sta_tbl_find_by_mac((u32)rx_buf_ra);
    } else if (mac_rx_rep1() & MAC_RX_REP1_SS) {
        *sta = sta_tbl_find_by_mac((u32)rx_buf_ta);
    } else {
        *sta = SPARRAW_PEER_UNKNOWN;
        local = 0;
    }

    if ((mac_rx_rep1() & MAC_RX_REP1_SS) || (mac_rx_rep1() & MAC_RX_REP1_NOACK_MGMT)) {
        /* 0x93256c: SSW */
        if (!(rx_mode_flags & 1)) {
            rx_mac_prepare();
            txrx_state2 |= (1u << 10);
            ctx->flags &= ~1u;
            if (*sta < SPARRAW_MAX_STA)             /* SSW от неизвестного TA: *sta = SPARRAW_PEER_UNKNOWN (vendor писал за link_stat) */
                VOL(link_stat[*sta].bf_reasons) |= 4;
            return 0;
        }
        if (sls_rx_ssw_frame() == 0)
            return 0;
        rx_mac_prepare();
        ctx->flags &= ~1u;
        if (sls_rx.flags & 0x221)
            return 0;
        u16 v = ifs.sifs;
        if (v == mac_ifs_shadow)
            return 0;
        mac_ifs_shadow = v;
        MMIO32(HW_MAC_IFS_SIFS) = v | 0x1730000;
        arc_sync();
        uc_mac_cmd(0x38000200);
        return 0;
    }

    if ((mac_rx_rep3() & (MAC_RX_REP3_ADDR2_VALID | MAC_RX_REP3_MCAST | MAC_RX_REP3_BCAST |
                          MAC_RX_REP3_NEIGHBOUR | MAC_RX_REP3_FCS_OK_PART)) ==
        (MAC_RX_REP3_ADDR2_VALID | MAC_RX_REP3_FCS_OK_PART)) {
        /* 0x93251e: кадр данных/управления для нас (распознавание Public Action FTM —
         * только SparRAW-pro) */
        u32 s2 = *sta;
        if (!(rx_mode_flags & 1) && !(rx_mode_flags & 2) && rs_state[s2].active == 0) {
            u8 r3 = sel_nbr.cur_gain_db, r1 = sel_nbr.min_gain_db;
            if (r3 < r1) {
                sel_nbr.min_gain_db = r3;
                sel_nbr.min_sta = (u8)s2;
            }
        }
        rx_last_mcs = MAC_RX_REP3_RX_MCS_OF(mac_rx_rep3());
        u32 rate = rx_resp_rate(rx_last_mcs);   /* до ожидания BAP и rx_get_required_response — вне срока */
        ctx->mtp_state = rx_get_required_response(ctx, &local);
        UC_STAMP_T0(STAMP_RESP_PATH, t_get);
        u8 lvl = (u8)rx_last_mcs;
        if ((mac_rx_rep1() & MAC_RX_REP1_BACK) && (mac_rx_rep3() & MAC_RX_REP3_BAP_EN)) {
            /* СРОК: ожидание r53.bap_tx_update_ind (таймаут — GP-таймер 0x23010003 = 3 мкс, стенд
             * 2026-11-17; при таймауте assert 0x3b) стоит до запроса ответа в MTP — каждый такт
             * ожидания идёт в срок SIFS 3 мкс (802.11-2020 10.3.2.3.3). Как у vendor 0x932726;
             * запас определяет BAP, не код. */
            if (mac_cmd31_mode != 0) {
                if (!(mac_bap_if() & MAC_BAP_TX_UPDATE)) {
                    uc_mac_cmd(0x23010003);
                    uc_mac_cmd(0x2000200);
                    uc_nop3();
                    while (!(mac_evt1() & MAC_EVT1_GP_TIMERS) && !(mac_bap_if() & MAC_BAP_TX_UPDATE))
                        ;
                    if (mac_evt1() & MAC_EVT1_GP_TIMERS)
                        uc_assert((u32)__builtin_return_address(0), 0x3b);
                }
                bap_tx_up_status = mac_bap_if() & MAC_BAP_TX_UP_STATUS;
                uc_mac_cmd(0x1c000001);
            }
            u32 x = MAC_BAP_NUM_TX_PKTS_OF(mac_bap_if());
            u32 y = MAC_BAP_NUM_NOACK_OF(mac_bap_if());
            ba_stats.tx_pkts += x;
            ba_stats.non_acked += y;
            ba_stats.ba_cnt += 1;
            if ((s32)(u32)(u8)lvl >= 1)
                ba_stats.active = 1;
        }
        /* RD (802.11-2020 10.29) отключён намеренно: RDG держателя (r38 б15 reverse_direction_detected) ответчик
         * отклоняет — отвечает только BlockAck/Ack, своих данных в TXOP держателя не шлёт (10.29.4: «The recipient of an
         * RDG may decline the RDG by … transmitting a control response frame with the RDG/More PPDU subfield set to 0»).
         * Стенд 2026-11-04 (PMC обоих узлов, MAC-STAND «Ответчик RD глохнет»): после своего ответа RD ответчик
         * ~200–275 мкс не принимал ничего — CF-End держателя без ответа в 11–50 % TXOP с RD у обоих узлов, RTS держателя
         * без DMG CTS; PHY эти PPDU не считала (у точки rx_flow_noevt_cnt 1 за прогон), эмулятор это не воспроизводит.
         * Без ответов RD (опыт exp/rd-decline): CF-End без ответа — 0 из 17 576 / 17 471, RTS без ответа —
         * на уровне встречных коллизий, пропускная способность 897/923 против 913/924. vendor отвечал RD при б15 и
         * данных в очереди станции (rx_txop_continue отсюда). */
        UC_STAMP_T0(STAMP_RESP_PATH, t_bap);
        u32 r5 = ctx->mtp_state;
        if (r5 == 0) {
            rx_mac_prepare();
            if (mac_rx_rep2() & MAC_RX_REP2_CF_END) {
                txrx_state2 |= (1u << 9);
                rx_cf_end_nav_reset(rx_buf_duration);   /* CF-End нам без ответа (Duration 0) — ответа нет, срока нет */
            }
            rxf.flags |= 4;
        } else {
            u32 s1 = *sta;
            u32 m = sta_tab[s1].tx_sel;
            if (r5 - 1 >= 3) {
                uc_mac_cmd(0x37000005);
                uc_mac_cmd(0x37000002);
                uc_mac_cmd(m | 0x3f000000);
            } else {
                /* Ответ Ack/BA/DMG CTS прежним путём (vendor 0x932a0c, случаи 1..3): сектор и запрос в MTP
                 * сразу (RX_RESP_ISSUE), записи ctx->flags/ctx->sta/0x802298/0x802294 — после команды 0x19000001.
                 * ХРУПКО: срок SIFS, см. комментарий у rx_frame_tx_resp_after_req. */
                u32 kind = r5 == 1 ? 0 : r5 == 2 ? 1 : 5;
                UC_STAMP_T0(STAMP_CTS_PATH, t_mtp);
                RX_RESP_ISSUE(kind, ctx, s1, r5, m | 0x3f000000, r5 == 3 ? 0x20000400u : 0, PAD_RESP_CMD,
                              MTP_W16_RESP(kind), MTP_W17_RESP(kind, s1, ctx->resp_ctx8, rate));
                UC_STAMP(STAMP_CTS_PATH, (t_rep - t_in) | (t_sw - t_in) << 16,
                         (t_mtp - t_in) | (arc_lr(0x100) - t_in) << 16);
                UC_STAMP(STAMP_RESP_PATH, (t_get - t_in) | (t_bap - t_in) << 16, r5);
                rx_resp_finish_restore_rx((u32)ctx, kind, 0);
                if (r5 == 3)
                    mac_mon_report.tx_cts += 1;
                uc_mac_cmd(0x14000000);
                if (ctx->mtp_state == 2)
                    rx_resp_abort_t2 = 1;
                else if (ctx->mtp_state == 1)
                    rx_resp_abort_t1 = 1;
                return 0;
            }
            ctx->flags &= ~1u;
            ctx->sta = s1;
            rxf.flags = (rxf.flags & ~2u) | 4;
        }
    } else {
        /* 0x932910 */
        rx_mac_prepare();
        /* DMG CTS-to-self нам (type_index 0x33 — DMG CTS; TA — наш адрес, 802.11-2020 9.3.1.13): ждать кадров TXOP
         * отправителя (RA); NAV не ставить (10.3.2.4). исправлено (vendor): TA сравнивался с копией адреса
         * prs_own_addr_boot, снятой один раз по LMAC 0x00 при загрузке fw — до WMI_SET_MAC_ADDRESS хоста; при адресе
         * интерфейса, отличном от адреса phy, ветка не срабатывала (стенд 2026-10-31: копия 24:18:1d:26:d4:7b,
         * интерфейс 26:18:1d:26:d4:7b). Сравнение — с регистром парсера 0x886018/0x88601c: в нём свой адрес записи
         * (mid->mac, WMI_SET_MAC_ADDRESS; имя vendor-карты «mcast» неточно), в 0x886020 — BSSID (WMI_CONNECT). Два
         * чтения — только у DMG CTS. */
        if ((mac_rx_rep3() & MAC_RX_REP3_FCS_OK_FULL) && MAC_RX_MISC_TYPE_IDX_OF(mac_rx_misc()) == 0x33 &&
            MMIO32(HW_PRS_OWN_ADDR_LO) == (rx_buf_ta[0] | (u32)rx_buf_ta[1] << 16) &&
            (u16)MMIO32(HW_PRS_OWN_ADDR_HI) == rx_buf_ta[2]) {
            u32 s = sta_tbl_find_by_mac((u32)rx_buf_ra);
            if (s >= SPARRAW_MAX_STA) {
                uc_stats.ra_unknown += 1;
            } else {
                *sta = s;
                rx_mode_configure(1, s);
                rxf.flags |= 4;
                uc_stats.ra_known += 1;
                rx_wait_start_tsf = uc_read_tsf_lo();
            }
        } else if (mac_rx_rep3() & MAC_RX_REP3_NEIGHBOUR) {
            rx_update_nav_from_frame(1);
        } else {
            u32 r39 = mac_rx_misc(), r38 = mac_rx_rep3();
            u32 is8 = MAC_RX_MISC_TYPE_IDX_OF(mac_rx_misc()) == 8;
            if ((r39 & 0x10) && (r38 & MAC_RX_REP3_BCAST) && is8) {
                /* vendor при td_enabled — op 4 вместо op 3; отсрочка трафика (LMAC 0x27, D3 PCIe) вырезана — см. fw/vectors.c pcie_pm_event_unsupported */
                peer_masks_apply_op(&pm_ctx, 3, (1u << *sta) << 8);
                mac_mon_report.rx_atim += 1;
            }
        }
    }

    /* 0x932a0c */
    {
        u32 r5 = ctx->mtp_state;
        rxf.resp_type = r5;
        ctx->flags &= ~1u;
        /* СРОК: медленный путь ответа — тот же срок SIFS 3 мкс (802.11-2020 10.3.2.3.3), но без
         * переноса записей. Случаи 1..3 уходят быстрым путём выше (прежде при ответе RD — в продолжение
         * TXOP), сюда по коду не доходят; 8 (CF-End), 9 (Grant Ack) — всегда здесь.
         * Путь длиннее быстрого на ~10 инструкций до switch + вызов; запас не замерен. См. rx_send_cf_end_response /
         * rx_send_grant_ack. */
        switch (r5) {
        case 0:
            break;
        case 1:
            rx_frame_tx_resp(0, ctx);
            rx_resp_finish_restore_rx((u32)ctx, 0, 0);
            break;
        case 2:
            rx_frame_tx_resp(1, ctx);
            rx_resp_finish_restore_rx((u32)ctx, 1, 0);
            break;
        case 3:
            uc_mac_cmd(0x20000400);
            rx_frame_tx_resp(5, ctx);
            rx_resp_finish_restore_rx((u32)ctx, 5, 0);
            mac_mon_report.tx_cts += 1;
            break;
        case 8:
            rx_cf_end_nav_reset(rx_send_cf_end_response());   /* NAV — после ответа, вне срока SIFS */
            rx_resp_finish_restore_rx((u32)ctx, 3, 0);
            break;
        case 9:
            rx_send_grant_ack();
            rx_resp_finish_restore_rx((u32)ctx, 0xa, 0);
            break;
        default:
            uc_assert((u32)__builtin_return_address(0), 66);
            break;
        }
        uc_mac_cmd(0x14000000);
        if (ctx->mtp_state == 2)
            rx_resp_abort_t2 = 1;
        else if (ctx->mtp_state == 1)
            rx_resp_abort_t1 = 1;
    }
    return 0;
}

u32 rx_flow_main(void)
{
    /* 6.2 asm 0x933928. */
    volatile u32 *st = &txrx_state2;
    volatile u32 *f4 = &txrx_state1;
    volatile u32 *sta = (volatile u32 *)&rxf.sta;
    struct tx_ctx_s **pctx = &tx_ctx_pool.cur;
    u32 ret = 3;                                /* r18 */
    u32 armed = 0;                              /* r17 */
    u32 tsf = 0;                                /* r14 в цикле */

    uc_mac_cmd(0xeeee08);
    uc_mac_cmd(arc_lr(uc_timer[1].count) & 0xffffff);
    rx_wait_slot_acc = 0;
    tx_resp_sent = 0;
    rx_resp_abort_t2 = 0;
    rx_resp_abort_t1 = 0;
    *f4 = 8;
    *st = 0;
    uc_mac_cmd(0x20c0080);
    uc_mac_cmd(0x490001c1);
    uc_mac_cmd(0x14000000);
    tx_ctx_alloc_next(1);
    (*pctx)->rf_word = rf_cur_sector_word;
    rxf.key_sta = 0xff;
    *sta = SPARRAW_PEER_UNKNOWN;
    rxf.flags = 0;
    rx_flow_run();
    if (*st & 0x3001000) {
        u32 r = rx_flow_decode_result();
        *f4 = 0;
        *st = 0;
        return r;
    }
    uc_mac_cmd(0x2000080);
    {
        struct sta_entry *e = &sta_tab[(*pctx)->sta];
        MMIO32(HW_QSET3_MASK_VECTOR) = e->qid_mask_q6 | e->qid_mask_q5;
        uc_mac_cmd(sta_tab[(*pctx)->sta].qid_top_q5 | 0x12000000);
    }

    if (rxf.flags & 4) {
        uc_mac_cmd((mac_chain_mask & 0xfffff0ff) | (1u << 27));
        struct sta_entry *e = &sta_tab[*sta];
        armed = 1;
        if (e->key_valid != 0) {
            mac_load_tx_key((const u32 *)e->tx_key);
            (*pctx)->flags |= (1u << 11);
        }
        uc_mac_cmd(0x20000400);
        for (;;) {                              /* 0x933c4c */
            if (rxf.flags & 2) {
                rx_program_mac_and_wait(*pctx);
                rxf.flags &= ~2u;
                tx_resp_sent = 1;
            }
            tsf = uc_read_tsf_lo();
            u32 v = *st;
            if (rx_flow_timeout_us < tsf - rx_wait_start_tsf) {
                v |= (1u << 16);
                *st = v;
            }
            if (v & 0x11600)
                break;
#ifdef UC_STAMP_MASK
            if (UC_STAMP_ON(STAMP_BUSY_LOST) && (mac_evt1() & MAC_EVT1_BUSY))
                UC_STAMP(STAMP_BUSY_LOST, 1, mac_evt1());
#endif
            uc_mac_cmd(0x2080002);
            struct tx_ctx_s *ctx = *pctx;
            u32 prev = ctx->qid;
            u32 qchg = 0;                       /* r15 */
            rx_qset4_hit = 0;
            if (queue_sel_get_qset4((u32)&ctx->qid) != 0) {
                rx_qset4_hit = 1;
                ctx = *pctx;
                u32 q = ctx->qid;
                if (q != prev) {
                    MTP_REQUEST(MTP_W16_Q(q, 1), MTP_W17(0));
                    qchg = 1;
                    (*pctx)->flags &= ~(1u << 9);
                }
            }
            ctx = *pctx;
            ctx->ack_mask = 0x13;
            if (qid_cfg[(*pctx)->qid].ctrl_b6 != 0)
                (*pctx)->ack_mask |= 0x40;
            txop_pick_ctrl_code_by_peer(*pctx);
            u32 busy = sxd_hal_wait_slot2_busy(busy_wait_slots);
            if (qchg) {
                while (!(mac_mtp_resp() & MAC_MTP_RESP_VALID))
                    ;
                u32 r51 = mac_mtp_desc();
                mtp_desc_lo = r51 & 0xf;
                mtp_desc_hi = r51 >> 4;
                if (mac_mtp_resp() & MAC_MTP_RESP_AGG_EN)
                    (*pctx)->flags |= (1u << 9);
                uc_mac_cmd(0x1b010000);
            }
            if (busy != 0) {
                *f4 = 4;
                rxf.key_sta = *sta;
                rx_flow_run();
                if (rxf.resp_type == 3)
                    uc_mac_cmd(0x2000080);
                if (*sta != rxf.key_sta) {
                    struct sta_entry *e2 = &sta_tab[*sta];
                    if (e2->key_valid != 0) {
                        mac_load_tx_key((const u32 *)e2->tx_key);
                        (*pctx)->flags |= (1u << 11);
                    }
                    (*pctx)->flags &= ~1u;
                    u32 s2 = *sta;
                    rxf.key_sta = s2;
                    MMIO32(HW_QSET3_MASK_VECTOR) = sta_tab[s2].qid_mask_q6 | sta_tab[s2].qid_mask_q5;
                }
                rx_wait_slot_acc = 0;
            } else {
                u32 n = rx_wait_slot_acc + ((u8 *)&ifs.slot)[1];
                rx_wait_slot_acc = n;
                u32 v2 = *st;
                if (n >= 0x1f) {
                    v2 |= (1u << 16);
                    *st = v2;
                }
                if (v2 & 2) {
                    struct tx_ctx_s *c2 = *pctx;
                    *st = (v2 & ~0x1fu) | 0x80;
                    mac_select_rf_module_cmd31(0, 0);
                    if (c2->flags & 2)
                        mac_q_tx_ppdu(c2, 2);
                    ba_stats.no_busy_cnt += 1;
                }
            }
            if (mac_evt1() & MAC_EVT1_TXOP)
                *st |= (1u << 10);
        }
        /* 0x933ca8 */
        if (*st & (1u << 12))
            ret = rx_flow_decode_result();
        u32 t0 = tx_busy_start_tsf;
        if (t0 != 0) {
            mac_mon_report.rx_listen_time += tsf - t0;
            tx_busy_start_tsf = 0;
        }
        if (rx_last_mcs >= 2 && rs_is_sta_enabled(*sta) == 0 &&
            (maint_sta_mask & (1u << (*sta & 31))))
            uc_send_evt_rs_started(*sta);
        uc_mac_cmd(0x20000000);
    }

    /* 0x933b28 */
    mac_select_rf_module_cmd31(0, 0);
    uc_mac_cmd(*(u16 *)&txrx_state1 | 0xcb0000);
    uc_mac_cmd((*f4 >> 16) | 0xcb0000);
    uc_mac_cmd(*(u16 *)&txrx_state2 | 0xcb0000);
    uc_mac_cmd((*st >> 16) | 0xcb0000);
    {
        volatile u32 *fl = (volatile u32 *)&sls_rx.flags;
        if (*fl & 0x221) {
            uc_mac_cmd((mac_chain_mask & 0xfffff0ff) | (1u << 27));
            u32 code = (*fl & 1) ? 4 : 10;
            armed = 1;
            if (!(rx_mode_flags & 1))
                uc_assert((u32)__builtin_return_address(0), 116);
            if (bf_abort_unexpected(*sta, code) != 0) {
                bf_store_flow_status(*sta, 0);
                bf_sm_run_sta(*sta);
            } else {
                uc_mac_cmd(0x83u << 25);
                uc_nop3();
                uc_mac_cmd(0x3800033f);
                mac_wait_mode_ack_if_idle();
                u16 v = ifs.sifs;
                if (mac_ifs_shadow != v) {
                    mac_ifs_shadow = v;
                    MMIO32(HW_MAC_IFS_SIFS) = v | 0x1730000;
                    arc_sync();
                    uc_mac_cmd(0x38000200);
                }
                uc_nop3();
                uc_mac_cmd(0x1f000601);
                rx_mode_configure(3, *sta);
            }
        } else {
            *fl &= ~2u;
        }
    }
    /* 0x934074 */
    if (!(*st & (1u << 9)))
        uc_mac_cmd(0x14000100);
    if (armed) {
        uc_mac_cmd((rx_nav.ev_mask & mac_chain_mask) | (1u << 27));
        uc_mac_cmd(0x2040000);
    }
    /* 0x934140 (итог пачки FTM инициатора и TOF-переопределение ABIF — только SparRAW-pro) */
    {
        u32 r3 = *f4 & 0x7e0;
        if (r3 == 0) {
            *f4 = 0;
            *st = 0;
        }
    }
    rxf.resp_type = 0;
    rxf.flags = 0;
    tx_ctx_pool.slot[0].flags = 0;
    tx_ctx_pool.slot[1].flags = 0;
    uc_mac_cmd(0x83u << 18);
    if (tx_resp_sent == 1 || rx_resp_abort_t2 == 1 || rx_resp_abort_t1 == 1) {
        u32 s0 = (*pctx)->sta;
        VOL(link_stat[s0].cts_fail) = 0;
        if (ba_stats.active != 0)
            FWSH_AT(ll_ctx, traffic, s0) += 1;
        bf_metrics_reset_and_stamp();
        rx_check_mode_2(&rx_meas, s0);
    }
    u32 t1 = uc_read_tsf_lo();
    mac_wait_mode_ack_if_idle();
    uc_mac_sel(0);
    uc_nop3();
    u32 is2 = (mac_status_sel() & MAC_BIFS_IDLE_DETECT) == 2;
    if (!(rx_mode_flags & 1))
        rx_mode_configure(2, *sta);
    if (!is2) {
        uc_mac_sel(0);
        uc_nop3();
        if ((mac_status_sel() & MAC_BIFS_IDLE_DETECT) == 2)
            is2 = 1;
    }
    if (is2) {
        u32 t2 = uc_read_tsf_lo();
        u32 d = t2 - t1;
        u32 last = busy_acct.last_end_tsf;
        if (last != 0 && t1 - last <= busy_gap_us)
            d += t1 - last;
        busy_acct.last_end_tsf = t2;
        mac_mon_report.busy_time += d;
    }
    {
        struct tx_ctx_s *ctx = *pctx;
        u32 c3 = ctx->flags;
        if (uc_role_ap == 1 && (ctx->x34 != 0 || (c3 & (1u << 10))))
            tx_ctx_post_status(&pm_ctx, 0, ((-(((c3 >> 10) ^ 1) & 1)) & 3) + 1);
    }
    return ret;
}

/* ХРУПКО: работа после пуска, отложенная за его последнюю команду (rx_post_defer; прежде rx_txop_deferred — только
 * держатель TXOP). Сейчас откладывает только продолжение TXOP держателем: до конца mtp_get_tx_permission или до выхода
 * rx_flow_step без продолжения — в порядке прежнего пути: переключение буфера приёма 0x32, учёт sel_nbr (~0,3 мкс).
 * Срок — до приёма ответа на наш кадр (TXTIME + SIFS, QoS Null ~3,4 мкс): буфер должен быть переключён. Тяжёлое сюда не
 * переносить: rx_mode_configure здесь (3,7 мкс) — uc_assert 0x6002 на стенде (образ evT2, 2026-11-15). */
__attribute__((optimize("Os"), noinline))
void rx_post_run(void);

/* Сторожа порядка: отложенная работа после пуска не выполнена до следующего приёма — путь, забывший вызвать rx_post_run
 * (эмуляция 2026-11-15: запрос итога с приёмом ответного CF-End — буфер переключался после приёма, test_fw_sls_collision).
 * Два места: вход rx_flow_run (выполнить сейчас) и сама rx_post_run (счётчик взводов приёма uc_stats.rx_arm изменился
 * с откладывания). Сигнал — метка 0x80e500ff (тесты эмуляции падают на ней — tests/unit/conftest.py uc_order_guard) и
 * mac_mon_report.rx_defer_late (стенд: rdrun «defer_late», должно быть 0). Проверку в путях приёма (tx_await_rx_or_timeout
 * и др.) не ставить: одна загрузка с ветвлением там уже меняет исход test_fw_sls_collision. */
__attribute__((optimize("Os"), noinline, cold))
void rx_post_late(void)
{
    uc_mac_cmd(0x80e500ff);                       /* метка (MAC не исполняет: б31, код 0): эмуляция, захват evucmd */
    mac_mon_report.rx_defer_late += 1;
    rx_post_defer = (rx_post_defer & ~0xff00u) | (uc_stats.rx_arm & 0xff) << 8;   /* не считать второй раз */
    rx_post_run();
}

__attribute__((optimize("Os"), noinline))
void rx_post_run(void)
{
    u32 d = rx_post_defer;
    rx_post_defer = 0;
    if (((d >> 8) & 0xff) != (uc_stats.rx_arm & 0xff)) {     /* сторож: между откладыванием и сюда был приём */
        uc_mac_cmd(0x80e500ff);
        mac_mon_report.rx_defer_late += 1;
    }
    if (d & RX_POST_TOGGLE)
        RX_BUF_TOGGLE();
    if (d & RX_POST_NBR)
        rx_sel_nbr_note((d >> 16) & 0xff);
}

/* СРОК (ХРУПКО): путь держателя TXOP от принятого Ack/BlockAck (или ответа RD) до продолжения TXOP —
 * следующий кадр через SIFS 3 мкс (802.11-2020 10.23.2.8, 10.29.3, 10.3.2.3.3). Путь P0.2: конец
 * кадра (r49 в rx_flow_run) → rx_flow_step → rx_end_switch_to_tx/mac_switch_rx_to_tx →
 * rx_match_expected_response → 0x4d/r55/0x886d10 → 0x14/0x37/0x3f → rx_txop_continue (отсюда, без
 * возврата в rx_flow_run) → 0x1b001111. Железо 2026-10-21 (до переделки): +20 nop перед 0x1b001111 —
 * FWERR при ассоциации, +16 — норма, т. е. запас 16–19 инструкций. Эмулятор (P0.2,
 * медиана/макс): vendor 409/417, было 418/423, стало 351/358 (−67) — записи флагов, метка 0xeeee0b,
 * busy_acct отложены за 0x1b001111; mac_switch_rx_to_tx и rx_match_expected_response без пролога; без
 * mul64 и вызова rs_sta_mcs_try. Не добавлять код до 0x1b001111 без замера.
 * Стенд 2026-11-15 (метки UC_EVM 0x10..0x1b в записях событий PMC, время от конца приёма 0x1d, медианы): продолжение
 * после BlockAck — вход 0,65, отчёт 0,92, переход RX→TX до 1,67 (ожидание снятия phy_rx_frame у кадра SC), переключение
 * буфера и sel_nbr до 1,96, rx_match_expected_response (BlockAck: ожидание BAP) до 2,68, запрос MTP 3,28, начало
 * передачи 3,85–3,93 (ответы MAC — 2,93: продолжение позже SIFS + допуск, 10.23.2.8 / 10.3.2.3.3); после DMG CTS — ещё
 * rx_mode_configure 3,7 мкс в rx_flow_run до входа сюда (из них запись усиления РЧ 2,25), начало данных 8,1. Теперь на
 * пути продолжения перехода RX→TX нет (продолжение — запросом MTP, тракт уводит секвенсор MTP, как у ответов), буфер и
 * sel_nbr — за пуском (rx_post_run): начало передачи после BlockAck 2,98 (без меток; ответы MAC 2,93–3,0), после
 * DMG CTS 6,36. Без продолжения — переход и буфер до rx_mac_prepare, как прежде (иначе эмуляция теряет SSW при
 * столкновении SLS, test_fw_sls_collision). Настройка приёма во время RTS (2,89 после CTS на стенде, гейт 14/14 и 8/8)
 * ломает в эмуляции SLS с потерями и столкновениями — не взята. Возврат RX→TX сюда — только с замером. */
u32 rx_flow_step(struct tx_ctx_s *a, u32 b)
{
    /* 6.2 asm 0x931acc. */
    struct tx_ctx_s *r15 = a;
    u32 r16 = b;
    u32 r13 = 0;
    u32 r17 = 0;
    u32 r5 = 0;
    u32 r10 = 0;
    u32 r11 = 0;
    u32 r14 = 0;

    UC_EVM(0x10);
    if (dti_qset_mode == 1)
        fsched_slot_resetup_if_time_left(&fsched_peers, b);

    /* Метка 0xeeee0b (MAC: NOP 0x00, только журнал) — у vendor здесь; у нас на выходе (в
     * продолжении TXOP — после 0x37000020, иначе — перед возвратом): до 0x1b001111 не нужна. */

    u32 r11c = r15->x1c;
    if (r16 > r11c) {
        if (!(mac_evt1() & MAC_EVT1_TXOP))
            r13 = 1;
    }
    r13 = (u32)(u8)(u8)r13;
    if (rx_flow_ctrl_qid_empty(r15) != 1)
        r17 = r13;

    if (!(mac_evt1() & MAC_EVT1_PPDU_REPORT))
        uc_wait_event_busy(MAC_EVT1_PPDU_REPORT, 0);
    UC_EVM(0x11);

    struct rx_meas_ctx *r13p = &rx_meas;
    if (r13p->state == 2) {
        u32 r7 = r13p->kind;
        if (r7 != 0 && r7 <= 6) {
            if (rx_capture_match_filter(&rx_meas) != 0) {
                u32 r10v = r13p->kind - 1;
                if (r10v == 0)
                    rx_meas_append_sample(&rx_meas, 0);
                else if (r10v == 1)
                    rx_meas_finish_plcp(&rx_meas);
                else if (r10v == 2)
                    rx_meas_capture_frame(&rx_meas, 0);
                else if (r10v == 4) {
                    u32 g = mac_sel_shadow & ~MAC_SEL_FIELD;
                    mac_sel_shadow = g | MAC_SEL_TSF_LOW;
                    uc_mac_cmd(g | MAC_CMD_STATUS_SEL | MAC_SEL_TSF_LOW);
                    arc_nops_nop(2);
                    rx_meas.snap_sel5 = mac_status_sel();
                    g = mac_sel_shadow & ~MAC_SEL_FIELD;
                    mac_sel_shadow = g | MAC_SEL_TSF_HIGH;
                    uc_mac_cmd(g | MAC_CMD_STATUS_SEL | MAC_SEL_TSF_HIGH);
                    arc_nops_nop(2);
                    rx_meas.snap_sel6 = mac_status_sel();
                    rx_meas.state = 1;
                    bg_task_set_pending_bit(0);
                }
            }
        }
    }

    /* Перехода RX→TX (rx_end_switch_to_tx: ожидание снятия phy_rx_frame — у кадра SC ~0,7 мкс после отчёта) на пути
     * продолжения нет (без продолжения — ниже, после решения): продолжение идёт запросом MTP, а секвенсор MTP уводит тракт с приёма сам (как у ответов, опыт E-S1). Переключение
     * буфера приёма (0x32) и учёт sel_nbr — за 0x19000001 продолжения или на выходе (rx_post_run): до запроса MTP
     * их никто не читает. Стенд 2026-11-15 (метки UC_EVM 0x10..0x1b): см. ХРУПКО выше. */
    UC_EVM(0x1a);
    {
        u32 d = RX_POST_TOGGLE | (uc_stats.rx_arm & 0xff) << 8;   /* [15:8] — взводов приёма на момент: сторож порядка */
        /* L_931c5c */
        if (mac_rx_rep3() & MAC_RX_REP3_ADDR2_VALID) {
            u32 r7 = MAC_RX_REP3_ADDR2_IDX_OF(mac_rx_rep3());
            rxf.sta = r7;
            d |= RX_POST_NBR | r7 << 16;
        }
        rx_post_defer = d;
    }

    UC_EVM(0x1b);
    u32 disp = rx_match_expected_response();
    UC_EVM(0x12);
    r13 = disp & r17;
    if (r13 == 1) {
        if ((mac_rx_rep1() & (MAC_RX_REP1_QOS_DATA | MAC_RX_REP1_MGMT)) != 0 && (mac_rx_rep3() & MAC_RX_REP3_ACK_POLICY) == 0) {
            r15->resp_ctx8 = MAC_RX_REP1_DATA_QID_OF(mac_rx_rep1());
            r10 = 1u << r15->qid;        /* asl r10,0x1,r6 */
            if (mac_rx_rep3() & MAC_RX_REP3_MPDU_AGG) {
                r15->x30 = 0;
                r11 = 2;
            } else {
                r11 = 1;
            }
        } else {
            r5 = r15->qid;
            r10 = 1u << r5;                       /* asl r10,0x1,r5 */
            if (txop_qid_mask & r10) {
                r5 = rx_resp_ctx8;
                r15->resp_ctx8 = r5;
                r11 = 2;
            } else {
                r11 = 0;
            }
        }
        r15->mtp_state = r11;
        r14 = rx_sta_tx_sel(r15->sta);
        if (qid_agg_mask & r10)
            txrx_state2 |= (1u << 30);
    } else {
        /* без продолжения — переход RX→TX, как прежде (до rx_mac_prepare): он же сверяет счётчик PPDU (ppdu_evt_cnt) и
         * шлёт 0x3d000004 / 0x02093800 — без него эмуляция теряет SSW при столкновении SLS (test_fw_sls_collision) */
        if (!(mac_rx_rep3() & MAC_RX_REP3_RD))
            rx_end_switch_to_tx();
        rx_post_run();                       /* буфер 0x32 — до взвода приёма (rx_mac_prepare), как прежде */
        rx_mac_prepare();
        if ((mac_rx_rep3() & MAC_RX_REP3_ADDR2_VALID) &&
            rxf.sta != tx_ctx_pool.cur->sta) {
            txrx_state2 |= (1u << 6);
        }
        if (r17 == 0) {
            txrx_state2 |= (1u << 10);
            if ((mac_evt1() & MAC_EVT1_TXOP) && rx_resp_wait_en != 0) {   /* ld.as [gp,-15] */
                fsched_rx_resp_seen = 1;                                   /* st.as [gp,-14] */
                uc_mac_cmd(0x1f000601);
            }
        }
        if (mac_rx_rep3() & MAC_RX_REP3_NEIGHBOUR) {
            rx_update_nav_from_frame(1);
            r5 = txrx_state2;
            txrx_state2 = r5 | (1u << 10);
        }
    }

    /* L_931e18. При r13 = 1 записи флагов (rxf.flags б1, r15->flags б0 = 1) отложены за 0x1b001111
     * (rx_txop_continue(…, 1)) или в конец ветки — MAC их не читает. */
    if (r13 != 1) {
        r11 = r13 & 1;
        r5 = r11 << 1;      /* vendor L_931e18: 2-операндный `asl r5,r11` = сдвиг на 1 */
        rxf.flags = r5 | (rxf.flags & ~2u);
        r15->flags = (r13 & 1) | (r15->flags & ~1u);
    }

    /* Продолжение TXOP после ответа партнёра — через SIFS (802.11-2020 10.23.2.8). 0x886d10 (нижняя граница момента
     * ответа RX→TX) = SIFS пишет настройка IFS (txrx_api_program_ifs_timing). Vendor (0x931e72) писал сюда перед
     * каждым продолжением «SIFS_CNT + {[0x802588] + 13 тактов, [0x802589] мкс}» ≈ 5,4 мкс — позже SIFS (опыт E2,
     * 2026-10-21: зазор «BA партнёра → следующий PPDU» 10,4 мкс против 8,6 у константы и без записи).
     * ХРУПКО: момент продолжения держит этот путь (стенд 2026-11-17: nop здесь сдвигают 0x2e − 0x1d 1:1, 32 → +0,19,
     * 64 → +0,39 мкс). Сейчас 2,96 мкс от конца приёма BlockAck. Ускорять только с проверкой под нагрузкой: образы с
     * учётом BlockAck после пуска и стартом 2,95–3,0 мкс давали ошибку MAC (uc_assert 0x6001/0x6000 из l2_task_entry,
     * 1–3 за 30 с), со стартом ≥ 3,06 — нет; дело не в одном моменте старта — этот путь без отложенного учёта при 2,96
     * чист (MAC-STAND «Продолжение TXOP держателем»). Команды без журнала.
     * СОЗНАТЕЛЬНОЕ ОТСТУПЛЕНИЕ от 802.11-2020 10.23.2.8 / 10.3.2.3.3: продолжение после BlockAck выходит в эфир через
     * ~4,2 мкс после его конца (0x2e − 0x1d 2,96 + ~1,28), а не через SIFS 3,00–3,49. Предел — MAC, не этот путь: MTP
     * готов не раньше ~2,6 мкс от конца приёма при любом моменте запроса (BAP ещё обрабатывает BlockAck), от готовности
     * до 0x2e — не меньше ~0,4 мкс (стенд 2026-11-18, метки UC_EVM: ранний запрос MTP сразу после 0x1c000001 дал
     * 3,41 вместо 2,96). Безопасно: промежуток меньше PIFS = aSIFSTime + aSlotTime = 8 мкс и AIFS ≥ 13 мкс — ни одна
     * станция не займёт среду раньше держателя; партнёр, приславший BlockAck, ждёт данных (NAV по Duration). Способ
     * уложиться в SIFS пока не найден (FUNCTIONALITY-GAPS.md). */
    if (r13 == 1) {
        UC_PAD(PAD_D10_WRITE);
        uc_mac_cmd_nl(0x14000206);
        uc_mac_cmd_nl(0x37000005);
        uc_mac_cmd_nl(0x37000002);
        uc_mac_cmd_nl(r14 | 0x3f000000);
        /* Продолжение TXOP — сразу отсюда, без эпилога и проверок rx_flow_run (как в
         * rx_flow_handle_frame). Условия rx_flow_run: rx_ppdu_report_seen = 0 и r15->flags б0 —
         * последний здесь = r13 = 1. */
        if (rx_ppdu_report_seen == 0) {
            rx_txop_continue(r15, 1);
            if (rx_post_defer != 0)               /* ранний выход mtp_get_tx_permission — без отложенной работы */
                rx_post_run();
            return 1;
        }
        if (!(mac_rx_rep3() & MAC_RX_REP3_RD))  /* продолжения нет — переход RX→TX, как прежде */
            rx_end_switch_to_tx();
        rx_post_run();
        rxf.flags |= 2u;
        r15->flags |= 1u;
    }
    rx_post_run();
    uc_mac_cmd(0xeeee0b);
    return 0;
}


/* СРОК: вызывается из rx_flow_handle_frame до запроса ответа в MTP — вся функция в сроке SIFS
 * 3 мкс (802.11-2020 10.3.2.3.3): QoS Data/BAR → Ack/BlockAck (10.3.2.11, 10.25.3), RTS → DMG CTS /
 * DMG DTS (10.3.2.9, 10.39.6.6.2), CF-End (10.39.8.1), Grant → Grant Ack (10.39.4). Размер 1220 Б
 * против 1468 Б у vendor 0x932e40; ветка RTS — одно чтение TSF (~9 инструкций с командой 0x4d
 * и nop; проверка NAV — rx_nav_check_idle_at по нему же); ветка данных — ожидание MAC_BAP_RX_UPDATE с пределом (ниже).
 * Запас общий с rx_frame_tx_resp_seq: единицы. Логи uc_log_emit* — только на ветках без ответа. */
UC_HOT
u32 rx_get_required_response(struct tx_ctx_s *frame, u32 *out)
{
    /* 6.2 asm 0x932e40. */
    u32 r14 = 0, r16 = 0, r17 = 0;
    UC_STAMP(STAMP_RESP_REP, mac_rx_rep1(), mac_rx_rep2());
    UC_STAMP(STAMP_RESP_REP, mac_rx_rep3(), mac_rx_misc());

    if (dti_qset_mode == 2 && maint_sta_mask != 0)
        mac_read_tsf64_uc(fsched_peers.rx_tsf);

    u32 r3 = rx_resp_skip_cnt;
    if (r3 == 1) {
        rx_resp_skip_cnt = rx_resp_skip_period;
        return 0;
    }
    if (r3 >= 2)
        rx_resp_skip_cnt = r3 - 1;

    if (!(mac_rx_rep1() & (MAC_RX_REP1_QOS_DATA | MAC_RX_REP1_MGMT)))
        goto ack_cts;

    u32 r4 = MAC_RX_REP3_ACK_POLICY_OF(mac_rx_rep3());
    if (r4 == 0)
        goto midbrp;
    if (r4 != 1)
        goto ack_cts;
    *out = 0;
    return 0;

midbrp:   /* L_932ecc */
    {
        u32 r2 = rxf.sta;
        u32 r5 = 1u << r2;                    /* asl r5,0x1,r2 */
        if (uc_role_ap != 0 && (maint_sta_mask & r5) == 0 &&
            (maint_sta_mask_prev & r5))
            r14 = 1;
    }
    frame->resp_ctx8 = MAC_RX_REP1_DATA_QID_OF(mac_rx_rep1());
    r14 = (u32)(u8)(u8)r14;
    if (!(mac_rx_rep3() & MAC_RX_REP3_MPDU_AGG) && !(mac_rx_rep1() & MAC_RX_REP1_BAR))   /* bbit1 r38.25; bbit0 r36.18 */
        goto bap_rx_check;
    if (r14 != 0) {   /* L_932f30 */
        u32 tsf = uc_read_tsf_lo();
        uc_log_emit3(0x10, 0x1000fc0, rxf.sta,
                     maint_sta_mask, maint_sta_mask_prev);
        uc_log_emit1(0x10, 0x1001048, tsf);
        return 0;
    }
    /* L_932f74: vendor при MAC_RX_REP1_QOS_DATA для станции из upm_vector (бит PM в принятых кадрах) отмечал
     * смену её режима PS — энергосбережение вырезано (см. fw/action.c psc_req_reject). */
    return 2;

bap_rx_check:   /* L_932fd0 */
    r17 = (MAC_RX_MISC_TYPE_IDX_OF(mac_rx_misc()) == 8) ? 1 : 0;
    r16 = mac_rx_rep1();
    if (!(r17 || (r16 & (1u << 17)))) {
        /* СРОК: ожидание MAC_BAP_RX_UPDATE (r53 б3, BAP: приём учтён) — на пути до Ack/BlockAck через SIFS
         * (802.11-2020 10.3.2.3.3); запас задаёт BAP. исправлено (vendor 0x933004: без ограничения — если BAP не
         * отметит приём, uc висит навсегда, метка 0xff31 в uc_wait_marker). Предел — BAP_RX_WAIT_PASSES проходов:
         * не меньше aPPDUMaxTime + SIFS (вход возможен с начала кадра — отчёт r36…r39 готов по заголовку, BAP
         * отмечает приём по концу PPDU; позже ответ всё равно опоздал). Проход — 4 инструкции ≥ 4 тактов (asm goto:
         * gcc строил 6 — mov/btst/bne/sub/tst/bne_s — и проверку счётчика после цикла). Выход по биту — как у vendor:
         * mov r53 / bbit0 без перехода (задержка реакции та же); на пути +3 инструкции (mov счётчика, sub.f, beq).
         * Срыв — rx_bap_rx_timeout: ответа нет (пир повторит кадр по своему AckTimeout), метка 0xff31 в
         * fwsh_uc_wait, uc возвращается в приём.
         * ХРУПКО: путь до 0x37000020 с запасом 32–48 тактов (стенд 2026-10-30, PAD_RESP_CMD); цикл сверять
         * дизассемблером (2026-11-07: начало цикла и mov r53 ≡ 0 mod 4, смещение в функции как до правки). */
        VOL(uc_wait_marker) = 0xff31;     /* метка ожидания: gcc выкидывал запись как мёртвую */
        __asm__ goto("mov\tr12,%0\n"
                     "1:\tsub.f\tr12,r12,1\n\tbeq\t%l[bap_tmo]\n"
                     "\tmov\tr11,r53\n\tbbit0\tr11,3,1b"
                     :: "i"(BAP_RX_WAIT_PASSES) : "r11", "r12", "memory", "cc" : bap_tmo);
        VOL(uc_wait_marker) = 0;
        UC_STAMP(STAMP_BAP_RX, mac_bap_if(), mac_rx_rep1());
        rx_bap_rx_up = (mac_bap_if() & MAC_BAP_RX_UP_STATUS) ? 1 : 0;
        uc_mac_cmd(0x1c000008);
        goto bap_rx_done;
    }
    if (0) {
bap_tmo:
        return rx_bap_rx_timeout();
    }
    /* L_93303c: vendor при td_enabled для ATIM — rx_bap_rx_up = 0 и op 4; отсрочка трафика (LMAC 0x27, D3 PCIe) вырезана — см. fw/vectors.c pcie_pm_event_unsupported */
    rx_bap_rx_up = 1;
    if (r16 & (1u << 17)) {   /* L_933080 */
        if (r14 != 0) {
            u32 tsf = uc_read_tsf_lo();
            uc_log_emit3(0x10, 0x1001070, rxf.sta,
                         maint_sta_mask, maint_sta_mask_prev);
            uc_log_emit1(0x10, 0x1001048, tsf);
            return 0;
        }
        /* L_9330b4 */
        if (*(u16 *)&rx_buf_body18 & (1u << 4))
            frame->flags |= (1u << 10);
        frame->x34 = 1;
        frame->x38 = mac_rx_rep3() & MAC_RX_REP3_PWR_MGMT;
        uc_read_tsf_lo();
        /* vendor: бит PM → upm_vector станции — PS вырезан */
    }

bap_rx_done:   /* L_9330f8 */
    if (rx_bap_rx_up == 1) {
        if (r17 != 0) {
            peer_masks_apply_op(&pm_ctx, 3, 1u << rxf.sta);
            mac_mon_report.rx_atim += 1;
            return 1;
        }
        if (!(r16 & (1u << 17))) {   /* L_93313c */
            if (r14 != 0 && (mac_rx_rep1() & MAC_RX_REP1_QOS_DATA)) {
                u32 tsf = uc_read_tsf_lo();
                uc_log_emit3(0x10, 0x10010f0, rxf.sta,
                             maint_sta_mask, maint_sta_mask_prev);
                uc_log_emit1(0x10, 0x1001048, tsf);
                return 0;
            }
            /* L_933174: vendor — смена режима PS станции из upm_vector; PS вырезан */
        }
        return 1;
    }
    rx_resp_ackcts_cnt += 1;   /* L_9331c4 */

ack_cts:   /* L_9331d0 */
    if (!(mac_rx_rep2() & MAC_RX_REP2_RTS))
        goto not_rts;
    {
        u32 tsf = uc_read_tsf_lo();
        *out = 0;
        tx_busy_start_tsf = tsf - 0xe;
        mac_mon_report.rx_rts += 1;
        if (!(txrx_state1 & 8)) {
            uc_stats.rts_rx += 1;
            FWSH(fwsh_diag, rts_rx) += 1;
        }
        /* BF к отправителю ждёт: vendor на RTS не отвечает — свой SLS идёт следом. Если расписание DTI не даёт начать
         * SLS до своего окна (uc/ese_dti.c, fwsh_sp_gate.init_hold: SP пира, Tguard), ждать окна — значит молчать на
         * все RTS пира весь его SP; тогда — ответ по 10.3.2.9 (DMG CTS при свободном NAV). Флаг читается только при
         * ожидающем BF (путь ответа через SIFS без него прежний). */
        if (VOL(link_stat[rxf.sta].bf_reasons) != 0 && FWSH(fwsh_sp_gate, init_hold) == 0)
            return 0;
        /* NAV занят. 10.3.2.9: если NAV поставил кадр самого отправителя RTS — отвечать (DMG CTS); иначе не
         * отвечать. исправлено (vendor): отвечал DMG DTS — по 10.39.6.6 он только для назначения SP (в open SP
         * нет), а поле NAV-SA заполнял MAC собственным адресом (заголовок 0x10 = FC, Duration, RA, TA). */
        if (__builtin_expect(rx_nav_check_idle_at(tsf + ((u8 *)&ifs.sifs)[1], 0, 0) == 0, 0) &&
            !(rx_nav.nav_ta[0] == rx_buf_ta[0] && rx_nav.nav_ta[1] == rx_buf_ta[1] && rx_nav.nav_ta[2] == rx_buf_ta[2])) {
            txr.rts_nav_busy += 1;
            return 0;
        }
        return 3;                               /* DMG CTS */
    }

not_rts:   /* L_93327c */
    if (!(mac_rx_rep2() & MAC_RX_REP2_CF_END))
        goto not_cf_end;
    if (mac_rx_rep3() & MAC_RX_REP3_RX_MCS) {
        sta_tab[rxf.sta].flags &= ~2u;
    }
    *out = 0;
    if (rx_buf_duration != 0) {
        uc_mac_cmd(0x15000000);
        uc_mac_cmd(0x14000007);
        return 8;
    }
    txr.cf_end_rx += 1;
    return 0;

not_cf_end:   /* L_933300 */
    if (!(mac_rx_rep2() & MAC_RX_REP2_GRANT))
        goto not_grant;
    if (dti_qset_mode == 2) {
        u32 r3 = rxf.sta;
        if (VOL(link_stat[r3].bf_reasons) != 0) {
            uc_log_emit2(0x22, 0x1001168, VOL(link_stat[r3].bf_reasons), r3);
            return 0;
        }
        rx_resp_dur = rx_buf_duration;
        txrx_state2 |= (1u << 12);
    }
    uc_stats.grant_rx += 1;
    *out = 0;
    return 9;

not_grant:   /* L_93339c */
    if ((rxf.flags & (1u << 4)) && rxf.sta == frame->sta) {
        frame->resp_ctx8 = rx_resp_ctx8;
        return 2;
    }
    if (mac_rx_rep2() & MAC_RX_REP2_CFG1) {
        struct tx_ctx_s *r0 = tx_ctx_pool.cur;
        rf_set_cur_sector_word(r0->rf_word);
        uc_stats.cfg1_rx += 1;
    }
    return 0;
}

/* СРОК: разбор отчёта в фазах SLS/RTS — несколько ответов со сроком:
 *  - RTS (MAC_RX_REP2_RTS) — без ответа (DMG DTS только в SP, 10.39.6.6);
 *  - фаза 0x100000/0x200000: SSW с CDOWN = 0 (MAC_RX_MISC_ZERO_CDOWN) → команды 0x37000005/0x37000002/0x3f для
 *    SSW-Feedback через MBIFS 9 мкс (10.42.2.4, 10.42.6.2, 10.3.2.3.10); до них — запись IFS = MBIFS
 *    (HW_MAC_IFS_SIFS), phy_params_snapshot (~90), sta_set_tx_sector (~38). Путь — сотни
 *    инструкций при сроке ~1485 тактов; запас оценочно десятки–сотни;
 *  - фаза 0x800000: SSW-Feedback → SSW-Ack через MBIFS (10.42.2.5) — rx_end_switch_to_tx и
 *    sta_set_tx_sector. Срыв — инициатор не получает FB/ACK, повтор SLS. */
void rx_handle_ppdu_report(void)
{
    /* 6.2 asm 0x9316cc. */
    u32 sec[2];                                 /* [sp,0], [sp,4] */
    s8 lvl[4];                                  /* [sp,8] */
    volatile u32 *flags = (volatile u32 *)&sls_rx.flags;
    volatile u32 *sta = (volatile u32 *)&rxf.sta;

    rx_ppdu_report_seen = 1;
    uc_mac_cmd(0xeeee0a);
    uc_wait_event_busy(MAC_EVT1_PPDU_REPORT, 0);
    RX_BUF_TOGGLE();                              /* [gp,-242] */
    if (mac_rx_rep3() & MAC_RX_REP3_ADDR2_VALID)
        *sta = MAC_RX_REP3_ADDR2_IDX_OF(mac_rx_rep3());
    else if (mac_rx_rep1() & MAC_RX_REP1_BEACON)
        *sta = sta_tbl_find_by_mac((u32)rx_buf_ra);
    else if (mac_rx_rep1() & MAC_RX_REP1_SS)
        *sta = sta_tbl_find_by_mac((u32)rx_buf_ta);
    else
        *sta = SPARRAW_PEER_UNKNOWN;

    if (mac_rx_rep2() & MAC_RX_REP2_RTS) {
        /* RTS в фазе SLS: исправлено (vendor) — отвечал DMG DTS без проверки NAV (только для назначения SP,
         * 10.39.6.6; NAV-SA — собственный адрес). Ответа нет: отправитель повторит RTS после таймаута */
        *flags |= (1u << 4);
        uc_stats.ppdu_resp += 1;
    }

    if (rx_buf_ta[0] != sls.peer_mac[0] || rx_buf_ta[1] != sls.peer_mac[1] ||
        rx_buf_ta[2] != sls.peer_mac[2])
        goto out;

    if ((txrx_state2 & (1u << 21)) && (mac_rx_rep2() & MAC_RX_REP2_SSW)) {
        if (mac_rx_misc() & MAC_RX_MISC_ZERO_CDOWN)
            rx_end_switch_to_tx();
    } else if (mac_rx_rep1() & MAC_RX_REP1_SS) {
        if (mac_rx_rep2() & MAC_RX_REP2_SSW)
            *flags |= 1;
        else if (mac_rx_rep2() & MAC_RX_REP2_SSW_FB)
            *flags |= (1u << 2);
        else if (mac_rx_rep2() & MAC_RX_REP2_SSW_ACK)
            *flags |= (1u << 3);
    } else if (mac_rx_rep1() & MAC_RX_REP1_NOACK_MGMT) {
        rx_handle_brp_frame();
    } else if (mac_rx_rep2() & MAC_RX_REP2_RTS) {
        *flags |= (1u << 4);
    }

    switch (txrx_state2) {
    case 1u << 23: {             /* значение фазы, не адрес */
        if (!(mac_rx_rep2() & MAC_RX_REP2_SSW_FB))
            goto out;
        rx_parse_ssw_field((u32)&sec[0], (u32)&sec[1], (u32)&lvl[0]);
        rx_end_switch_to_tx();
        bf_rep_record_snr_level((u32)(s32)lvl[0]);
        sta_set_tx_sector(*sta, sec[0], sec[1], 1);
        *flags |= (1u << 2);
        struct bf_sta_s *e = &bf_sta[*sta];
        e->peer_l_rx = rx_buf_ssw_fb0 & 0x1f;
        if (!(rx_buf_ssw_fb0 & 0x40) && !(rx_buf_ssw_fb0 & 0x80))
            e->brp_flags |= 1;
        else
            e->brp_flags &= ~1;
        return;
    }
    case 0x100000:
        if ((mac_rx_rep2() & MAC_RX_REP2_SSW) && mac_ifs_shadow != ifs.mbifs) {
            u16 v = ifs.mbifs;
            mac_ifs_shadow = v;
            MMIO32(HW_MAC_IFS_SIFS) = v | 0x1730000;
            arc_sync();
            uc_mac_cmd(0x38000200);
        }
        /* fallthrough */
    case 0x200000: {
        if (!(mac_rx_rep2() & MAC_RX_REP2_SSW))
            goto out;
        u16 b0 = rx_buf_ssw;
        u32 fl = *flags;
        if ((!(b0 & 1) && (txrx_state1 & (1u << 6))) ||
            ((b0 & 1) && (txrx_state1 & (1u << 5)))) {
            *flags = fl | 1;
            phy_params_snapshot((u32)&sec[0], (u32)&sec[1]);
            u32 g = txrx_state1;
            if (mac_rx_misc() & MAC_RX_MISC_ZERO_CDOWN) {
                u32 s = *sta;
                u32 r13 = sta_mode_word[s];
                *flags |= 2;
                if (g & (1u << 5)) {
                    sta_set_tx_sector(s, sec[0], sec[1], 1);
                    r13 = sta_tab[*sta].tx_sel;
                }
                uc_mac_cmd(0x37000005);
                uc_mac_cmd(0x37000002);
                uc_mac_cmd(r13 | 0x3f000000);
                return;
            }
            if (g & (1u << 5))
                sta_set_tx_sector(*sta, sec[0], sec[1], 1);
        } else {
            fl &= ~1u;
            /* Инициатор ждёт RSS, а пир (TA — тот же, проверено выше) шлёт нам ISS (Direction 0, 9.5.1): наша ISS до
             * него не дошла (столкновение в CBAP), его SLS идёт, и по 10.42.6.2 мы — его ответчик: RSS через MBIFS
             * после конца этой ISS. Признак для txss_init_wait_rss — уступить (SLS_RX_PEER_ISS); по последнему кадру
             * (CDOWN 0) — уже нет: до начала RSS остаётся MBIFS. */
            if (!(b0 & 1) && (txrx_state1 & (1u << 5)) && !(mac_rx_rep3() & MAC_RX_REP3_NEIGHBOUR) &&
                !(mac_rx_misc() & MAC_RX_MISC_ZERO_CDOWN))
                fl |= SLS_RX_PEER_ISS;
            *flags = fl;
        }
        goto out;
    }
    case 0x400000: {
        if (!(mac_rx_rep2() & MAC_RX_REP2_SSW_ACK))
            goto out;
        rx_parse_ssw_field((u32)&sec[0], (u32)&sec[1], (u32)&lvl[0]);
        bf_rep_record_snr_level((u32)(s32)lvl[0]);
        *flags |= (1u << 3);
        struct bf_sta_s *e = &bf_sta[*sta];
        e->peer_l_rx = rx_buf_ssw_fb0 & 0x1f;
        if (!(rx_buf_ssw_fb0 & 0x40) && !(rx_buf_ssw_fb0 & 0x80))
            e->brp_flags |= 1;
        else
            e->brp_flags &= ~1;
        goto out;
    }
    case 0x80000:
    case 0x8000000:
        goto out;
    case 0x4000000:
        if (!(*flags & (1u << 5)))
            goto out;
        mac_switch_rx_to_tx(*flags);
        return;
    case 0x20000000:
        if (!(*flags & (1u << 10)))
            goto out;
        mac_switch_rx_to_tx(*flags);
        return;
    case 0x10000000: {
        u32 fl = *flags;
        if (!(((fl & (1u << 11)) && (fl & (1u << 10))) || (fl & (1u << 2))))
            goto out;
        if (!(fl & (1u << 2)))
            return;
        mac_switch_rx_to_tx(fl);
        return;
    }
    default:
        uc_assert((u32)__builtin_return_address(0), 0x18);
        goto out;
    }
out:
    if (*flags != 0)
        ucode_pm_set_busy_flag(0);
    rx_mac_prepare();
}


/* СРОК: вызывается из rx_flow_step — на пути держателя TXOP от Ack/BlockAck до следующего кадра
 * через SIFS 3 мкс (802.11-2020 10.23.2.8, 10.3.2.3.3). Режимы 1/2 при mac_cmd31_mode ждут
 * r53.bap_tx_update_ind с таймаутом GP 0x23010003 (assert 0x3b) — время ожидания задаёт BAP;
 * порядок чтений и команд как у vendor 0x9333fc. Режим 1 (Ack): 24 инструкции (было 38, vendor 32) —
 * листовая функция; запас общий с rx_txop_continue (см. rx_flow_step). */
/* Ожидание BAP r53.bap_tx_update_ind (таймаут — GP 0x23010003, assert 0x3b) и квитанция 0x1c000001
 * (vendor 0x933436…/0x9334f8…, одинаковые блоки режимов 1/2). Встроено в обе ветки; uc_assert —
 * UC_ASSERT_LEAF (адрес возврата rx_match_expected_response = blink: до блока вызовов нет). */
static inline __attribute__((always_inline)) void rx_dispatch_bap_sync(void)
{
    if (!(mac_bap_if() & MAC_BAP_TX_UPDATE)) {
        uc_mac_cmd(0x23010003);
        uc_mac_cmd(0x2000200);
        arc_nops_nop(2);
        while (!(mac_evt1() & MAC_EVT1_GP_TIMERS) && !(mac_bap_if() & MAC_BAP_TX_UPDATE))
            ;
        if (mac_evt1() & MAC_EVT1_GP_TIMERS)
            UC_ASSERT_LEAF(0x3b);
    }
    bap_tx_up_status = mac_bap_if() & MAC_BAP_TX_UP_STATUS;
    uc_mac_cmd(0x1c000001);
}

/* Режим 2 (ждём BlockAck) — отдельной функцией (хвостовой переход): только здесь вызов
 * bap_q_avail_check, остальные режимы остаются без пролога. r14 = r38[24:20]. */
static __attribute__((noinline)) u32 rx_dispatch_mode2(u32 r14)
{
    /* L_9334f8 */
    if (!(mac_rx_rep1() & MAC_RX_REP1_BACK))
        return 0;
    if (mac_rx_rep3() & MAC_RX_REP3_RD)
        return 0;
    if (!(mac_rx_rep3() & MAC_RX_REP3_BAP_EN))
        return 0;
    if (mac_cmd31_mode != 0)
        rx_dispatch_bap_sync();
    if (bap_tx_up_status != 0)
        return 0;
    u32 r1 = MAC_BAP_NUM_TX_PKTS_OF(mac_bap_if());
    u32 r3 = MAC_BAP_NUM_NOACK_OF(mac_bap_if());
    ba_stats.tx_pkts += r1;
    ba_stats.non_acked += r3;
    ba_stats.ba_cnt += 1;
    if (r14 >= 1)
        ba_stats.active = 1;
    u32 r7 = rs_state[rxf.sta].active;
    if (r7 != 0)
        bap_q_avail_check(rxf.sta, r1, r3);
    if (!(txrx_state2 & (1u << 30)))
        return 1;                           /* vendor: L_9336c8 — r0 = r13 (= 1 с L_933592) */
    struct tx_ctx_s *r9 = tx_ctx_pool.cur;
    u32 r2v = r9->qid;
    /* vendor 0x93362e: bclr r8,r8,r2 (r2 = [cur+4] = qid) — сброс БИТА qid.
     * Порт-баг (исправлен 2026-10-19): было `&= ~r2v` — маска чистилась значением qid:
     * при qid 0 бит не сбрасывался никогда, при других — гасился чужой бит. Бит qid в
     * qid_agg_mask после первого BA не снимался, и txop_initiator_open_txop_flow
     * (L_93a314: r14 = 1 при бите qid) открывал КАЖДЫЙ TXOP через RTS (txrx_state2 б2,
     * ждём CTS) вместо chan_access → лишние CTS-ожидания → cts_fail → BF-триггер б2. */
    qid_agg_mask &= ~(1u << (r2v & 31));
    txrx_state2 &= ~(1u << 30);
    return 1;
}

u32 rx_match_expected_response(void)
{
    /* 6.2 asm 0x9333fc. Ветки — цепочкой сравнений (самая частая на пути P0.2 — режим 1, Ack)
     * вместо таблицы switch; режим 2 — rx_dispatch_mode2. Порядок чтений r36/r38/r53 и команд
     * внутри веток — как у vendor. */
    u32 r2 = txrx_state2;
    if (!(r2 & (1u << 8)))
        return 0;
    u32 mode = r2 & 0x1f;
    u32 r14 = MAC_RX_REP3_RX_MCS_OF(mac_rx_rep3());

    if (mode == 1) {   /* L_933436 */
        if (!(mac_rx_rep1() & MAC_RX_REP1_IMM_ACK))
            return 0;
        if (mac_rx_rep3() & MAC_RX_REP3_RD)
            return 0;
        if ((mac_rx_rep3() & MAC_RX_REP3_BAP_EN) && mac_cmd31_mode != 0)
            rx_dispatch_bap_sync();
        if (r14 >= 1)
            ba_stats.active = 1;
        rx_ack_rcvd = 1;
        return 1;
    }
    if (mode == 2)
        return rx_dispatch_mode2(r14);
    if (mode == 4) {   /* L_933658 */
        if (!(mac_rx_rep2() & MAC_RX_REP2_CTS))
            return 0;
        struct tx_ctx_s *r4 = tx_ctx_pool.cur;
        u32 r1 = r4->sta;
        cts_rx_cnt[r1] += 1;
        uc_mac_cmd(0x20000400);
        return 1;
    }
    if (mode == 16)    /* L_933698: лишнее чтение r36 (mov r3,r36), затем как 8 */
        (void)mac_rx_rep1();
    if (mode == 8 || mode == 16) {   /* L_93369c */
        if (mac_rx_rep3() & MAC_RX_REP3_RD)
            return 0;
        struct tx_ctx_s *r3 = tx_ctx_pool.cur;
        if (rxf.sta != r3->sta)
            return 0;
        return 1;
    }
    return 0;
}


/* СРОК: после ответа (Ack/BA/CTS/DTS…) РЧ надо вернуть в приём до преамбулы следующего кадра
 * партнёра, который идёт через SIFS 3 мкс после конца нашего (802.11-2020 10.3.2.3.3; после DMG CTS —
 * данные, 10.3.2.9). От tx_end_event (MAC_EVT1_TX_END, uc_spin_until_event) до записи HW_ABIF_DVS_RF_CTRL =
 * rf_set_rx: mac_evt_enable_bit_sync_b (~16 инструкций + ожидание MAC_EVT1_BUSY2 — подтверждение команды
 * MAC) + ~10 — как у vendor 0x9336d8. Запас оценочно сотни тактов (не замерен; время подтверждения
 * 0x27… не известно). Срыв — пропуск начала кадра партнёра (нет BA/повторы). Всё до ожидания
 * MAC_EVT1_TX_END (трасса 0xcac0xx, rx_mode_configure при b == 5) выполняется во время передачи ответа. */
void rx_resp_finish_restore_rx(u32 a, u32 b, u32 c)
{
    /* 6.2 asm 0x9336d8. */
    u32 r1 = mac_sel_shadow & ~MAC_SEL_FIELD;
    mac_sel_shadow = r1;
    uc_mac_cmd(r1 | MAC_CMD_STATUS_SEL);
    arc_nops(3);
    uc_mac_cmd((mac_status_sel() & MAC_BIFS_IDLE_DETECT) | 0xcac000);
    uc_mac_cmd(arc_lr(uc_timer[1].count) & 0xffffff);
    uc_mac_cmd((mac_status_sel() & MAC_BIFS_IDLE_DETECT) | 0xcac100);
    uc_mac_cmd(arc_lr(uc_timer[1].count) & 0xffffff);
    mac_evt_enable_bit_sync_b(6);

    (void)c;   /* c ≠ 0 — метки TOD/TOA ответа на кадр FTM: только SparRAW-pro */

    if (b == 5)
        rx_mode_configure(1, ((struct tx_ctx_s *)a)->sta);   /* b == 5: a — TX-контекст */

    u32 flag = 0;
    u32 r10 = txrx_state1;
    int do_flag1 = 0;
    if (!(r10 & 2))
        do_flag1 = 1;
    else if ((txrx_state2 & 0x11f) != 0x100)   /* bic -0x120 == & 0x11f */
        do_flag1 = 1;
    if (do_flag1) {
        flag = 1;
        if (rx_cts_rf_restore != 0) {
            tx_ctx_pool.cur->rf_word = sta_tab[rxf.sta].rx_sel;
        }
        struct tx_ctx_s *r8 = tx_ctx_pool.cur;
        mac_set_rf_chain_state(1, r8->rf_word);
        if (rx_cts_rf_restore != 0)
            rx_cts_rf_restore = 0;
    }
    uc_spin_until_event(MAC_EVT1_TX_END);
    mac_evt_enable_bit_sync_b(5);
    if (flag == 1) {
        u32 r10b = abif_dvs_rf_ctrl_shadow;
        u32 r11b = rf_set_rx;
        r10b = (r10b & 0xfcffffff) | (r11b << 24);
        abif_dvs_rf_ctrl_shadow = r10b;
        *(volatile u32 *)HW_ABIF_DVS_RF_CTRL = r10b;
    }
    rx_wait_start_tsf = uc_read_tsf_lo();
}

UC_HOT
void rx_nav_update(u32 a, u32 b, u32 c, u32 d)
{
    /* 6.2 asm 0x934590. b = r36, c = r37, d = r38 (снимки, переданные вызывающим);
     * внутри vendor дополнительно читает живые r37/r38. */
    volatile u32 *st = &txrx_state2;
    struct tx_ctx_s *r0 = tx_ctx_pool.cur;
    u32 r4 = *st & 0x1f;

    if (r4 == 1) {
        *st &= ~0x1fu;
        if (((b & MAC_RX_REP1_IMM_ACK) && ((d & MAC_RX_REP3_BAP_EN) || (*st & (1u << 18)))) ||
            (rx_ack_rcvd != 0 && (*st & (1u << 9)))) {
            *st &= ~0x1fu;
            r0->flags &= ~(1u << 1);
            r0->x20 = 0;
            if ((txrx_state1 & (1u << 1)) && (mac_rx_rep3() & MAC_RX_REP3_RD))
                *st |= (1u << 3);
            rx_ack_rcvd = 0;
            return;
        }
        uc_stats.nav_x10 += 1;
        goto prep;
    }
    if (r4 == 0x10) {
        if (!(b & MAC_RX_REP1_QOS_DATA)) {
            *st |= (1u << 7);
            return;
        }
        *st &= ~0x1fu;
        r0->flags &= ~(1u << 1);
        r0->x20 = 0;
        if (txrx_state1 & (1u << 1))
            (void)mac_rx_rep3();              /* vendor читает r38, обе ветви очищают биты 0..4 */
        *st &= ~0x1fu;
        return;
    }
    if (r4 == 2) {
        if (!(b & MAC_RX_REP1_BACK) || !(d & MAC_RX_REP3_BAP_EN)) {
            *st &= ~0x1fu;
            mac_prepare_txrx_window(r0, 2);
            ba_stats.no_busy_cnt += 1;
            return;
        }
        *st &= ~0x1fu;                          /* 0x934690 */
        if (bap_tx_up_status != 0)
            goto prep;
        r0->flags &= ~(1u << 1);
        r0->x20 = 0;
        if ((txrx_state1 & (1u << 1)) && (mac_rx_rep3() & MAC_RX_REP3_RD))
            *st |= (1u << 3);
        return;
    }
    if (r4 == 4) {
        if (c & MAC_RX_REP2_CTS) {
            *st &= ~0x1fu;
            rx_cts_rf_restore = 1;
            return;
        }
        if (mac_rx_rep2() & MAC_RX_REP2_DTS) {
            rx_nav_set_from_duration(1, rx_buf_fc, rx_buf_duration, (u32)rx_buf_ta);
            uc_stats.nav_dts += 1;
            *st = (*st & ~0x1fu) | 5;
        }
        *st |= (1u << 7);
        return;
    }
    if (r4 == 8 && a != 0)
        *st &= ~0x1fu;
    return;
prep:                                           /* 0x9346d0: биты 0..4 уже сброшены */
    mac_prepare_txrx_window(r0, 2);
}

/* 0x938b90: всегда возвращает 1. gp+204 = 0x8005f4, gp+208 = 0x8005f8.
 * СРОК: (1) запрос в MTP → r43 → 0x3e/0x37000020 — та же последовательность, что rx_txop_continue;
 * когда вызов продолжает TXOP после Ack/BA (rx_handle_status_flags), следующий кадр — через SIFS
 * 3 мкс (802.11-2020 10.23.2.8). Если rx_txop_continue уже отправил (flags б5), часть пропускается.
 * Путь до 0x37000020 ~40 инструкций + ожидание r43, как у vendor; запас не замерен.
 * (2) после MAC_EVT1_TX_END (конец передачи) — mac_q_tx_ppdu (при б3) и uc_wait_one_event(6) стоят ДО
 * записи rf_set_rx (как у vendor): РЧ должна вернуться в приём до Ack/BlockAck партнёра на наш
 * кадр, который идёт через SIFS (10.3.2.11, 10.3.2.3.3) — запас зависит от этих ожиданий, не
 * замерен; если РЧ всё ещё в TX — Ack не принят, повтор. */
u32 rx_program_mac_and_wait(struct tx_ctx_s *a)
{
    struct tx_ctx_s *r14 = a;
    u32 r13, r15, sp0;

    if (!(r14->flags & (1u << 5))) {
        r13 = sta_tab[r14->sta].tx_sel;
        uc_mac_cmd(0x37000005);
        uc_mac_cmd(0x37000002);
        uc_mac_cmd(r13 | 0x3f000000);
        MTP_REQUEST(MTP_W16_Q(r14->qid, 1), MTP_W17(MTP_RS_RATE_OR(r14->sta, 0)));
        while (!(mac_mtp_resp() & MAC_MTP_RESP_VALID))
            ;
        u32 v51 = mac_mtp_desc();
        mtp_desc_lo = v51 & 0xf;               /* st.as [gp,56] */
        mtp_desc_hi = v51 >> 4;                /* st.as [gp,57] */
        r13 = MAC_MTP_RESP_MCS_OF(mac_mtp_resp());        /* lsr r13,r43,0x10; bmsk 4 */
        uc_mac_cmd((r13 << 4) | 0x3e000000);
        uc_mac_cmd(0x37000020);
        uc_stats.tx_start += 1;
        u32 g = abif_dvs_rf_ctrl_shadow & ~((1u << 24) | (1u << 25));
        g |= rf_set_tx << 24;
        abif_dvs_rf_ctrl_shadow = g;
        MMIO32(HW_ABIF_DVS_RF_CTRL) = g;
        mtp_get_tx_permission(r14, r13);
        r14->flags |= 1u << 5;
    }
    /* L_938ccc */
    r14->flags &= ~(1u << 5);
    if (txrx_state2 & (1u << 9))
        return 1;

    uc_mac_cmd(mac_evt_en_shadow | 0x27004000);      /* ld_s [gp,-72] */
    uc_mac_cmd(0x2004000);
    struct tx_ctx_s *p = tx_ctx_pool.cur;
    if (qid_cfg[p->qid].null_b5 != 0) {
        if (MAC_MTP_PERM_NULL_B5_OF(mac_mtp_perm())) {           /* bxor + bbit1: пропуск при бите 0 */
            p->flags |= 1u << 1;
            p->x20 = 0;
        }
    }
    if (!(p->flags & (1u << 8))) {
        u32 m = MAC_MTP_RESP_ACK_POLICY_OF(mac_mtp_resp());
        if (m == 0) {
            u32 g = txrx_state2;
            if (mac_mtp_resp() & MAC_MTP_RESP_AGG_EN)
                g |= 1u << 1;
            else
                g |= 1u;
            txrx_state2 = g;                   /* st.as [gp,52] */
            if (!(g & (1u << 18)))
                mac_select_rf_module_cmd31(1, p->qid);
        } else if (m == 1) {
            p->flags |= 0xe;
        }
    }
    if (mac_evt1() & MAC_EVT1_BUSY2)
        r15 = 1;
    else
        r15 = uc_wait_event_busy(MAC_EVT1_BUSY2, 6);

    u32 sta = r14->sta;
    sp0 = 0;
    if (!((txrx_state1 & 2) != 0 && (txrx_state2 & 0x11f) == 0x100)) {
        sp0 = 1;
        if (rx_cts_rf_restore != 0)                  /* ld_s [gp,68] */
            tx_ctx_pool.cur->rf_word = sta_tab[sta].rx_sel;
        mac_set_rf_chain_state(1, tx_ctx_pool.cur->rf_word);
        if (rx_cts_rf_restore != 0)
            rx_cts_rf_restore = 0;                   /* st.as [gp,17] */
    }
    if (r15 == 0)
        uc_assert((u32)__builtin_return_address(0), 0x91);   /* возвращается — дальше как обычно */
    r14->mtp_state = 0;
    r14->flags &= ~0x120u;
    uc_spin_until_event(MAC_EVT1_TX_END);
    if (r14->flags & (1u << 3))
        mac_q_tx_ppdu(r14, 0);
    uc_wait_one_event(6);
    if (sp0 == 1) {
        u32 g = abif_dvs_rf_ctrl_shadow & ~((1u << 24) | (1u << 25));
        g |= rf_set_rx << 24;
        abif_dvs_rf_ctrl_shadow = g;
        MMIO32(HW_ABIF_DVS_RF_CTRL) = g;
    }
    rx_wait_start_tsf = uc_read_tsf_lo();            /* st.as [gp,5] */
    return 1;
}

void rx_handle_status_flags(struct tx_ctx_s *a)
{
    /* 6.2 asm 0x939d3c. */
    struct tx_ctx_s *r13 = a;
    u8 sp[8];
    memset0_words_uc(sp, 8);
    u32 r15 = 0;
    for (;;) {
        u32 r0 = txrx_state2;                  /* 0x939dd6 */
        if ((r0 & 0x140u) != 0x100)                 /* bic r1,r1,-0x141 == & 0x140 */
            break;
        if (r0 & 0xe00) {
            txrx_state2 = r0 & ~(1u << 8);
            break;
        }
        if (!(r0 & 0x1f)) {
            if (r0 & (1u << 7)) {
                u32 r0b = txrx_cfg_flags;
                u8 r1 = (r0b & (1u << 9)) ? bf_ctrl.ctrl_code_rx_alt : bf_ctrl.ctrl_code_rx;
                if (bit_hist_push((u32)sp, r1, 1, bf_ctrl.stat_bit) == 1) {
                    if (bf_ctrl.triggers & (1u << 3))
                        VOL(link_stat[(r13->sta)].bf_reasons) |= (1u << 3);
                    tx_cca_check_and_send(r13, 1, 1, 0);
                    continue;
                }
                tx_mtp_queue_gate(0);
                txrx_state2 &= ~(1u << 7);
            } else {
                rx_program_mac_and_wait(tx_ctx_pool.cur);
                if (r15 != 0) {
                    bit_hist_push((u32)sp, bf_ctrl.ctrl_code_rx, 0, bf_ctrl.stat_bit);
                    tx_resp_sent = 1;
                }
            }
            r15 = 0;
        }
        /* 0x939dce: vendor перечитывает флаги */
        if (VOL(txrx_state2) & 0x1f) {
            uc_mac_cmd(2 | (1u << 25));
            if (sxd_hal_wait_slot2_busy2(busy_wait_slots) != 0) {
                rx_flow_run();
                r15 = 1;                            /* delay-слот bl.d: mov_s r15,1 */
                tx_rx_flow_ran = r15;
            } else {
                mac_prepare_txrx_window(r13, 2);
                (ba_stats.no_busy_cnt)++;
            }
        }
    }
    /* 0x939de4 */
    u32 r0c = r13->sta;
    if (VOL(link_stat[r0c].bf_reasons) != 0 ||
        (rx_mode_flags & (1u << 1))) {           /* brne; bbit0 r0,1 → пропуск */
        if (txr.awaiting == 0)
            tx_cca_check_and_send(r13, 1, 1, 0);
    }
}

void rx_nav_set_from_duration(u32 a, u32 b, u32 c, u32 d)
{
    /* 6.2 asm 0x92dd30. */
    /* исправлено (vendor): Duration/ID ≥ 32768 — не длительность (Table 9-9; у DMG-кадров толкования нет, 10.28.3) —
     * NAV не ставится; vendor ставил (усекая до max_us). */
    if (c & 0x8000u)
        return;
    u32 r0 = (u32)(u16)MMIO32(HW_MAC_NAV_HW_VALUE);
    u32 r1 = rx_nav.max_us;
    if (r1 < r0)                                /* cmp_s r1,r0; mov.cs r0,r1 — min */
        r0 = r1;
    u32 r13 = c;
    if (r1 < c) {
        if (c == r0)
            uc_assert((u32)__builtin_return_address(0), 0x63);
        rx_nav.clip_cnt = rx_nav.clip_cnt + 1;
        r13 = rx_nav.max_us;
    }
    uc_mac_cmd(0x4d000000);
    arc_nops(3);
    u32 r55 = mac_timer_sel();                  /* stw r55,[sp,4] — до чтения TSF */
    u32 r1v = rx_nav.tsf_adjust + uc_read_tsf_lo() + r13 - MAC_SIFS_CNT_USEC_OF(r55);
    u32 flag = 0;
    if (((b >> 2) & 3) == 1 && ((b >> 4) & 0xf) == 0xe)
        flag = 1;
    if (a == 0)                                 /* breq r15,0 → L_92de86 (выход) */
        return;
    {
        u32 r2v = rx_nav.end_tsf;
        u32 r3 = rx_nav.flags;
        u32 r4 = r3;
        /* Новый конец раньше текущего — NAV не укорачивать (10.3.2.4), но только пока NAV активен (б0): истёкший NAV
         * равен 0, любой Duration его ставит. исправлено (vendor): сравнивал и с давно истёкшим концом — через 2^31 мкс
         * (~36 мин) тишины знак разности переворачивался и NAV не ставился следующие ~36 мин. */
        if (flag == 0 && (r3 & 1u) && (r1v - r2v) & (1u << 31))
            return;
        if (r3 & 1u) {
            u32 diff = r1v - (r2v + 0x32);
            if (!(diff & (1u << 31)) && flag == 0)
                nav_late_cnt = nav_late_cnt + 1;
        }
        u32 delta = r1v - r2v;
        if (r3 & 1u)                                       /* учёт времени NAV — только продление активного */
            r13 = ((s32)delta < (s32)r13) ? delta : r13;   /* min — знаковый */
        rx_nav.end_tsf = r1v;
        rx_nav.flags = r4 | 1;
        u32 st = bi_phase_from_sm_state();
        if ((u8)st != 2) {
            rx_nav.ev_mask = 0xfffff0ff;
            uc_mac_cmd((mac_chain_mask & 0xfffff0ff) | (1u << 27));
        } else {
            rx_nav.ev_mask_saved = 0xfffff0ff;
        }
    }
    for (int i = 0; i < 3; i++)
        rx_nav.nav_ta[i] = *(u16 *)(d + i * 2);
    u64 acc = ((u64)nav_accum64_hi << 32) | nav_accum64_lo;
    acc += (u64)(s64)(s32)r13;
    nav_accum64_lo = (u32)acc;
    nav_accum64_hi = (u32)(acc >> 32);
    FWSH(fw_stats_dash, nav_time) = (u32)acc;
    u32 sp8 = 0xff;
    if (nav_read_hw_duration_flag(&sp8) != 0) {
        u32 spc = 0;
        u8 sv = qid_cfg_get_sta(sp8, (u32)&spc);
        FWSH_AT(ll_ctx, act_140, sv) += r13;
    }
    mac_mon_report.nav_accum = mac_mon_report.nav_accum + r13;
}

/* Отсчёт измерения: *mp, либо (mp==0) MAC-команда 0x1d00d000 и знаковое
 * 11-битное поле lr40[19:9] (общий пролог 0x927f6c / 0x928854). */
static u32 rx_meas_read_sample(u32 mp)
{
    if (mp != 0)
        return *(u32 *)mp;
    u32 g = mac_sel_shadow & ~MAC_SEL_FIELD;
    mac_sel_shadow = g | (1u << 12) | (1u << 14) | (1u << 15);
    uc_mac_cmd(g | MAC_CMD_STATUS_SEL | MAC_SEL_BF_METRIC);
    arc_nops(3);
    u32 r0 = MAC_BF_METRIC_OF(mac_status_sel());
    return (r0 > 0x3ff) ? (r0 - 0x800) : r0;
}

/* Общий хвост захвата: снимок r40 по селекторам 0x5000/0x6000, запрос снят, отчёт fw. */
static inline __attribute__((always_inline)) void rx_meas_snap_done(struct rx_meas_ctx *m)
{
    u32 g = mac_sel_shadow & ~MAC_SEL_FIELD;
    mac_sel_shadow = g | (1u << 12) | (1u << 14);
    uc_mac_cmd(g | MAC_CMD_STATUS_SEL | MAC_SEL_TSF_LOW);
    arc_nops(3);
    m->snap_sel5 = mac_status_sel();
    g = mac_sel_shadow & ~MAC_SEL_FIELD;
    mac_sel_shadow = g | (1u << 13) | (1u << 14);
    uc_mac_cmd(g | MAC_CMD_STATUS_SEL | MAC_SEL_TSF_HIGH);
    arc_nops(3);
    m->snap_sel6 = mac_status_sel();
    m->state = 1;
    bg_task_set_pending_bit(0);
}

void rx_meas_capture_frame(struct rx_meas_ctx *m, u32 mp)
{
    /* 6.2 asm 0x927f6c. */
    m->pkt.sample = rx_meas_read_sample(mp);
    m->pkt.r88306c = *(volatile u32 *)HW_PHY_RX_AGC_ROW & 0x3f;
    u32 r = *(volatile u32 *)HW_PHY_RX_MEAS_8830EC;
    m->pkt.plcp_lo = r & 0x1f;
    m->pkt.plcp_hi = (r >> 5) & 0x3ffff;
    u32 s0 = (u16)*(volatile u32 *)HW_PHY_RX_MEAS_8837D8;             /* extw — zero-extend */
    u32 v0 = s0 - (1u << 16);
    if (s0 <= 0x7fff)
        v0 = s0;
    m->pkt.r8837d8 = v0;
    u32 s1 = (u16)*(volatile u32 *)HW_PHY_RX_MEAS_8837DC;
    u32 v1 = s1 - (1u << 16);
    if (s1 <= 0x7fff)
        v1 = s1;
    m->pkt.r8837dc = v1;
    u32 g = mac_sel_shadow & ~MAC_SEL_FIELD;
    mac_sel_shadow = g | (1u << 12) | (1u << 14);
    uc_mac_cmd(g | MAC_CMD_STATUS_SEL | MAC_SEL_TSF_LOW);
    arc_nops(3);
    m->pkt.sel5 = mac_status_sel();
    g = mac_sel_shadow & ~MAC_SEL_FIELD;
    mac_sel_shadow = g | (1u << 13) | (1u << 14);
    uc_mac_cmd(g | MAC_CMD_STATUS_SEL | MAC_SEL_TSF_HIGH);
    arc_nops(3);
    m->pkt.sel6 = mac_status_sel();
    u32 n;
    n = arc_norm((u32)rf_modules.mask);
    m->pkt.rf_byte = rf_rx_gain_hi[0x1e - n];
    m->pkt.sector = (rf_cur_sector_word >> 8) & 0x7fff;   /* [gp,-0x2c] */
    m->pkt.cid = (mac_rx_rep3() & MAC_RX_REP3_ADDR2_VALID) ? MAC_RX_REP3_ADDR2_IDX_OF(mac_rx_rep3()) : 8;   /* r38 читается дважды */
    rx_meas_snap_done(m);
}

/* ХРУПКО: число отсчётов зависит от скорости цикла, запаса нет (6a30636f).
 * O2: 0x883830 — живой SNR текущего кадра, число отсчётов до конца кадра идёт
 * в выбор MCS (0x802208/0x800560). -Os не разворачивал 8 чтений (7 инструкций
 * между чтениями против 1–2 у vendor) — отсчётов было в ~3.4 раза меньше.
 * Выход по MAC_EVT1_BUSY2/MAC_EE2_BRP_ON_AIR проверяется раз в 8 отсчётов: после конца кадра — до одного прохода
 * (~40 инструкций, 8 чтений PHY) + хвост ~30 до возврата; это время входит в путь rx_flow_run до
 * ответа через SIFS 3 мкс (802.11-2020 10.3.2.3.3). У vendor так же (8 чтений на проход). */
__attribute__((optimize("O2")))
void rx_flow_measure_snr_select_best(void)
{
    UC_STAMP_T0(STAMP_SNR_SEL, t_snr);
    /* 6.2 asm 0x92d688. */
    u32 r16 = *(volatile u32 *)HW_PHY_RX_AGC_ROW;
    *(volatile u32 *)HW_PHY_RX_AGC_ROW = agc_cfg.agc_start;
    u32 r9 = 0, r11 = 0, r15 = 0;
    u32 sp[16];
    volatile u32 *ph = (volatile u32 *)HW_PHY_RX_SIGNAL_GAIN_ADC_DB;
    const u32 *tab = db_to_lin_tab;
    __asm__ volatile("" :: "r"(ph), "r"(tab));     /* адреса — до цикла */
    while (r9 < VOL(bf_ctrl.snr_samples)) {     /* vendor перечитывает каждый проход */
        u32 v0 = *ph & 0x7f, v1 = *ph & 0x7f, v2 = *ph & 0x7f, v3 = *ph & 0x7f;
        u32 v4 = *ph & 0x7f, v5 = *ph & 0x7f, v6 = *ph & 0x7f, v7 = *ph & 0x7f;
        u32 sum = tab[v0] + tab[v1] + tab[v2] + tab[v3] + tab[v4] + tab[v5] + tab[v6] + tab[v7];
        if ((mac_evt1() & MAC_EVT1_BUSY2) || (mac_evt_eng2() & MAC_EE2_BRP_ON_AIR))
            break;
        r15 += sum;
        sp[r11] = r15;
        r9 += 8;
        r11 += 1;
    }
    UC_STAMP(STAMP_SNR_SEL, r11 | (mac_evt1() & MAC_EVT1_BUSY2) << 2, arc_lr(0x100) - t_snr);
    u32 r6 = (*(volatile u32 *)HW_PHY_RX_SNR_883AEC >> 9) & 0x1ff;
    u32 r0 = (r6 > 0xff) ? (r6 - 0x200) : r6;
    /* ХРУПКО: запись именно через u32 — при записи как s32 GCC перекладывает функцию, и в
     * цикле отсчётов выше появляется лишняя инструкция (cmp_s + bls.d вместо brhs.d). */
    *(u32 *)&sls_meas.snr_db = (u32)((s32)(r0 + 2) >> 2);
    *(volatile u32 *)HW_PHY_RX_AGC_ROW = r16;
    snr_meas_stats_last_samples = (u8)r9;
    if (r9 == 0)
        return;
    u32 n1, n2;
    n1 = arc_norm(r11);
    u32 r8 = (1u << (0x1e - n1)) - 1;
    n2 = arc_norm(r9);
    u32 r10 = sp[r8] << (7 - (0x1e - n2));
    sls_meas.snr_lin = r10;
    snr_meas_new = 1;                       /* delay-слот brlo.d — всегда */
    if (r10 < sls.best.snr_lin)
        snr_best_buf = (u32)&sls.best;
    else
        snr_best_buf = (u32)&sls_meas;
}

void rx_meas_append_sample(struct rx_meas_ctx *m, u32 mp)
{
    /* 6.2 asm 0x928854. */
    u32 r1 = rx_meas_read_sample(mp);
    u32 idx = m->n;
    m->sample[idx] = r1;
    m->sample_88306c[idx] = *(volatile u32 *)HW_PHY_RX_AGC_ROW & 0x3f;
    m->n = idx + 1;
    if (idx + 1 == m->n_max)
        rx_meas_snap_done(m);
}

void rx_meas_finish_plcp(struct rx_meas_ctx *m)
{
    /* 6.2 asm 0x92893c. */
    m->plcp = *(volatile u32 *)HW_PHY_RX_MEAS_8830EC;
    rx_meas_snap_done(m);
}


void rx_parse_ssw_field(u32 dst0, u32 dst1, u32 dst2)
{
    /* 6.2 asm 0x927d0c. */
    u32 r3 = *(u32 *)&rx_buf_ssw & 0x3f;           /* SSW-Feedback словом */
    if (fwsh_n_sets >= 2)
        r3 += *(u8 *)(fwsh_set_ranges + ((rf_chain_word >> 8) & 0x7fff) * 2);   /* [0x8577b0] — указатель */
    *(u32 *)dst0 = r3;
    *(u32 *)dst1 = (*(u32 *)&rx_buf_ssw >> 6) & 3;
    *(u8 *)dst2 = *(u8 *)&rx_buf_fb_snr;
}

u32 rx_capture_match_filter(struct rx_meas_ctx *m)
{
    /* 6.2 asm 0x93e56c. */
    u8 sp[5];
    sp[0] = rx_capture_defaults[0];
    sp[1] = rx_capture_defaults_mode;
    sp[2] = rx_capture_defaults_2;
    sp[3] = rx_capture_defaults_3;
    sp[4] = rx_capture_defaults_4;
    sp[0] = (mac_rx_rep3() & MAC_RX_REP3_ADDR2_VALID) ? MAC_RX_REP3_ADDR2_IDX_OF(mac_rx_rep3()) : 8;
    sp[3] = MAC_RX_REP3_RX_MCS_OF(mac_rx_rep3());
    sp[2] = (sp[3] == 0) ? 1 : 0;               /* mov 1; sub.ne */
    sp[4] = rx_mode_flags & 1;
    struct rx_meas_filter *f = &m->filt, *g = &m->got;
    u32 match = (f->cid == 0xff || f->cid == sp[0]) &&
                (f->mode == 0xff || f->mode == sp[1]) &&
                (f->mcs == 0xff || f->mcs == sp[3]) &&
                (f->no_mcs == 0xff || f->no_mcs == sp[2]) &&
                (f->rx_mode == 0xff || f->rx_mode == sp[4]);
    if (match) {
        g->cid = sp[0];
        g->mode = sp[1];
        g->no_mcs = sp[2];
        g->mcs = sp[3];
        g->rx_mode = sp[4];
    }
    return match;
}

