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

void rx_nav_set_flag_b1_if_enabled(u32 a)
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

void rx_flow_latch_phy_8014e8__930da4(void)
{
    /* 0x930da4: stb всегда, затем 0, если > 0x3f (знаковое ble). */
    s32 v = (s32)phy_read_signal_gain_adc_db_sfd_locked();
    sel_nbr.cur_gain_db = (u8)v;
    if (v > 0x3f)
        sel_nbr.cur_gain_db = 0;
}

void rx_cfg_select_sta(u32 a)
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
    if (rx_buf_toggle_dis == 0) {
        uc_mac_cmd((rx_buf_toggle_cnt & 1u) | 0x32000000);
        rx_buf_toggle_cnt += 1;
    }
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
    uc_mac_cmd(0x4d000000);
    arc_nops(3);
    u32 r1 = mac_timer_sel();
    rx_sw_sifs_cnt = r1;
    if (r1 > SIFS_CNT_RESP_LATE || r1 == 0) {
        uc_mac_cmd(0x1f000601);
        rx_end_tx_late_cnt += 1;                  /* ld_s [gp,4] (байты) / st.as [gp,1] */
    }
}

u32 rx_flow_run_and_check_bf_abort(u32 a)
{
    /* 6.2 asm 0x926310. */
    (void)a;
    u32 r14 = rx_funcs_rx_flow();
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
    if (rx_buf_toggle_dis == 0) {
        u32 v = (rx_buf_toggle_cnt & 1) | 0x32000000u;
        uc_mac_cmd(v);
        rx_buf_toggle_cnt += 1;
    }
    ppdu_evt_cnt += 1;                      /* ld_s [gp,80] / st.as [gp,20] */
    uc_stats.rx_arm += 1;
    uc_mac_cmd(0x2011000);
    return mac_rx_rep1() & MAC_RX_REP1_IMM_ACK;
}


u32 rx_ppdu_is_cts_b(void)
{
    uc_wait_event_busy(MAC_EVT1_PPDU_REPORT, 0);
    if (rx_buf_toggle_dis == 0) {
        u32 v = (rx_buf_toggle_cnt & 1) | 0x32000000u;
        uc_mac_cmd(v);
        rx_buf_toggle_cnt += 1;
    }
    ppdu_evt_cnt += 1;                      /* ld_s [gp,80] / st.as [gp,20] */
    uc_stats.rx_arm += 1;
    uc_mac_cmd(0x2011000);
    return mac_rx_rep2() & MAC_RX_REP2_CTS;
}


/* uc_wait_event_busy — в stubs.c. */
/* mac_switch_rx_to_tx — в mac.c. */

void rx_arm_window_b(void)
{
    /* 0x923280: как rx_arm_window_c, но без возврата r37. */
    uc_wait_event_busy(MAC_EVT1_PPDU_REPORT, 0);
    if (rx_buf_toggle_dis == 0) {
        uc_mac_cmd((rx_buf_toggle_cnt & 1u) | 0x32000000);
        rx_buf_toggle_cnt += 1;
    }
    ppdu_evt_cnt += 1;
    uc_stats.rx_arm += 1;
    uc_mac_cmd(0x2011000);
}

/* 0x92c568: возврат r37 & (1 << 24). */
u32 rx_arm_window_c(void)
{
    uc_wait_event_busy(MAC_EVT1_PPDU_REPORT, 0);
    if (rx_buf_toggle_dis == 0) {
        uc_mac_cmd((rx_buf_toggle_cnt & 1u) | 0x32000000);
        rx_buf_toggle_cnt += 1;
    }
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

u32 rx_check_g8005f8_bit24(void)
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
            phy_stats_clear_counters_883960();
    } else {
        if (v == RX_MEAS_PHYSTAT)
            phy_stats_accumulate_to_shared(m, b);
    }
}


void rx_enter_listen_mode(void)
{
    /* 6.2 asm 0x93c818. */
    mac_set_mode_0000();
    rx_mode_configure(3, 0xff);
    grant_detect_step(0, 1, 1);
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
u32 rx_flow_send_imm_response(void)
{
    /* 6.2 asm 0x93626c. */
    /* 9.3.1.6: Duration CF-End DMG — остаток последовательности усечения (i − 1)·(TXTIME(CF-End) + SIFS), т. е.
     * Duration принятого минус TXTIME(CF-End) + SIFS; исправлено (vendor): отвечал с Duration = 0 */
    u32 d = dmg_cf_end_resp_dur_us(rx_buf_duration);
    tx_send_imm_response(0, d, 0x10);
    arc_core_wr(33, 0xe4);
    tx_fifo_free -= 0x10;
    uc_mac_cmd(0x33000063);
    uc_wait_direct_tx_ready();
    direct_tx_issue_cmd_33();
    txr.imm_resp += 1;
    return d;
}

/* phy_stats_accumulate_to_shared — в tail.c; tx_send_imm_response — в tx.c. */

/* По формату это Grant Ack, а не DMG CTS: fc 0x0764 (расширение управления 7) и 7 Б тела
 * (Reserved + BF Control, 9.3.1.18); вызывается на принятый Grant (MAC_RX_REP2_GRANT, случай 9).
 * СРОК: Grant Ack — через SIFS 3 мкс после Grant (802.11-2020 10.39.4, 10.3.2.3.3). Медленный путь
 * через switch rx_flow_handle_frame; здесь до 0x37000020 — расчёт длительности,
 * direct_tx_init_rx_desc (~15) и tx_send_imm_response (~60); тело (7 Б) пишется после 0x37000020.
 * Как у vendor 0x936320; запас не замерен (единицы–десятки). Срыв — поздняя команда, assert 0x26. */
void rx_send_dmg_cts(void)
{
    /* 6.2 asm 0x936320. */
    struct dtx_ctrl_frame sp;
    /* 9.3.1.18: Duration Grant Ack = Duration Grant − (TXTIME(Grant Ack) + SIFS), не меньше 0; vendor вычитал
     * 20 без отсечки — Grant с Duration < 20 давал Grant Ack с Duration ≈ 32,7 мс (NAV соседям). */
    u32 d = rx_buf_duration;
    u32 r1 = d > DMG_RESP_DUR_SUB_US(DMG_GRANT_ACK_LEN) ? d - DMG_RESP_DUR_SUB_US(DMG_GRANT_ACK_LEN) : 0u;
    tx_send_imm_response(ctrl_frame_mcs, r1, 0x17);  /* [gp,-0xec] = [0x80043c] */
    direct_tx_init_rx_desc(&sp, 1, 1);
    arc_core_wr(33, sp.fc);
    tx_fifo_free -= 0x10;
    uc_mac_cmd(0x33000063);
    uc_wait_direct_tx_ready();
    tx_fifo_write_bytes((u32)&sp.alloc, 7);
    direct_tx_issue_cmd_33();
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
u32 rx_flow_substep_uc(struct tx_ctx_s *a)
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
 * (с ответом BA/ACK при RD), 0x37000020, разрешение на передачу.
 * ХРУПКО: срок — SIFS от конца принятого кадра; запас у vendor и у нас — единицы инструкций.
 * Стенд 2026-10-21 (UC_PAD(PAD_TXOP), tools/stand_tests/pad_sweep.sh, STA, ping + iperf 20 с):
 * +4 и +16 nop — 4 из 4 без сбоев; +20, +24, +28, +32, +64 — отказ fw при ассоциации 10 из 10
 * (FWERR, коды assert 0/0). Запас нынешнего кода — 16–19 инструкций.
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
static inline __attribute__((always_inline)) void rx_txop_continue(struct tx_ctx_s *ctx)
{
    u32 a, b;
    if (__builtin_expect(txrx_state2 & (1u << 30), 0)) {   /* раскладка: ветка RD/обычная — прямым ходом */
        a = (ctx->qid << 16) | 4;
        b = 0;
        if (rs_state[ctx->sta].active != 0)
            b = ((u32)mtp_queue_byte_by_index(ctx->sta) << 8) | 3;
    } else {
        u32 m = ctx->mtp_state;
        a = ctx->qid << 16;
        b = 0;
        if (m == 2 || m == 1) {
            a |= (m == 2) ? 0x103 : 3;
            a |= 0x20;
            b = ctx->resp_ctx8 << 16;
        } else {
            a |= 1;
        }
        if ((txrx_state1 & 2) && rs_state[ctx->sta].active != 0)
            b |= ((u32)mtp_queue_byte_by_index(ctx->sta) << 8) | 3;
    }
    UC_PAD(PAD_TXOP);   /* стресс запаса: uc/dbg.h (прежде UC_DBG_TXOP_PAD) */
    uc_mac_cmd(0x1b001111);
    uc_mac_cmd(a | 0x16000000);
    uc_mac_cmd(b | 0x17000000);
    uc_nop3();
    while (!(mac_mtp_resp() & MAC_MTP_RESP_VALID))
        ;
    u32 r51 = mac_mtp_desc();
    mtp_desc_lo = r51 & 0xf;
    mtp_desc_hi = r51 >> 4;
    u32 mcs = MAC_MTP_RESP_MCS_OF(mac_mtp_resp());
    uc_mac_cmd((mcs << 4) | 0x3e000000);
    uc_mac_cmd(0x37000020);
    VOL(uc_stats.tx_start) += 1;
    u32 r8 = (abif_dvs_rf_ctrl_shadow & 0xfcffffff) | (rf_set_tx << 24);
    abif_dvs_rf_ctrl_shadow = r8;
    MMIO32(HW_ABIF_DVS_RF_CTRL) = r8;
    u32 c3 = ctx->flags;
    ctx->flags = (((c3 >> 11) & 1) << 12) | (c3 & ~(1u << 12));
    mtp_get_tx_permission(ctx, mcs);
    ctx->flags = (ctx->flags & ~(1u << 12)) | (1u << 5);
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
 * 0x6000101 (rx_not_ready). */
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

    uc_mac_cmd(0xeeee09);
    uc_mac_cmd(arc_lr(uc_timer[1].count) & 0xffffff);
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
        ppdu_evt_cnt = r13;
        uc_mac_cmd(0x20d2000);
        if (!(mac_status_sel() & MAC_PHYSIG_CCA_PPDU_COMP)) {
            mac_wait_event_r42_or_r40(MAC_EVT1_PPDU_REPORT, MAC_PHYSIG_CCA_PPDU_COMP);
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
        uc_mac_cmd(mac_evt_en_shadow | 0x27007300);
        uc_mac_cmd(0x2004000);
        uc_nop3();
        uc_wait_event_busy(MAC_EVT1_SFD_SYNC | MAC_EVT1_BUSY2, 0);
        if (!(mac_evt1() & MAC_EVT1_BUSY2) && (rx_mode_flags & 2) &&
            (mac_status_sel() & MAC_BIFS_IDLE_DETECT) == 2 && (MMIO32(HW_PHY_RX_STATUS_8837B0) & 2))
            rx_flow_measure_snr_select_best();
        uc_mac_sel(MAC_SEL_PHY_SIGNALS);
        uc_nop3();
        uc_mac_cmd(mac_evt_en_shadow | 0x27007300);
        uc_mac_cmd(0x2004000);
        uc_nop3();
        {   /* ХРУПКО: тайминг без запаса. Как vendor: 4 инструкции на проход;
             * -Os уводил проверку r49 за дальний переход (6a30636f).
             * Отсюда (конец кадра: MAC_EVT1_BUSY2 / BRP-стадия MAC_EE2_BRP_ON_AIR) отсчитывается SIFS до ответа
             * (802.11-2020 10.3.2.3.3); задержка выхода — до одного прохода (4 инструкции). */
            u32 t;
            __asm__ volatile("1:\tmov\t%0,r42\n\tbbit1\t%0,14,2f\n"
                             "\tmov\t%0,r49\n\tbbit0\t%0,13,1b\n2:" : "=&r"(t) :: "memory");
        }
        (void)mac_evt_eng2();                  /* delay-слот vendor: mov r3,r49 */
        rx_flow_latch_phy_8014e8__930da4();
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
    if (hit == 1) {
busy:
        if (busy_acct.busy_start_tsf != 0)
            rx_flow_accumulate_busy_time(busy_acct.busy_start_tsf);
    }
    busy_acct.busy_start_tsf = 0;
    if (ok == 0 && res == 1) {
        uc_mac_cmd(0xeeee06);
        ppdu_evt_cnt += 1;
        VOL(uc_stats.rx_arm) += 1;
        FWSH(fwsh_diag, rx_arm) = VOL(uc_stats.rx_arm);
        uc_spin_until_event(MAC_EVT1_PPDU_REPORT);
        VOL(uc_stats.rx_no_frame) += 1;
        goto noframe;
    }
    if (res == 0) {
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
    ppdu_evt_cnt += 1;
    if (txrx_state2 & 4) {
        rx_mode_configure(0, ctx->sta);
        struct sta_entry *sta = &sta_tab[ctx->sta];
        if (sta->key_valid != 0 && (sta->qid_mask_q6 & (1u << (ctx->qid & 31)))) {
            mac_load_tx_key((const u32 *)sta->tx_key);
            ctx->flags |= (1u << 11);
        }
    }
    {
        u32 f = txrx_state1;
        if (f & 0x7e0) {
            rx_funcs_handle_ppdu_report();
        } else if (f & 2) {
            uc_mac_sel(MAC_SEL_REM_TIME);
            uc_nop3();
            rx_flow_step(ctx, mac_status_sel() & MAC_REM_TIME);
        } else {
            txop_sent = rx_flow_handle_frame(ctx);
            if (!txop_sent && (txrx_state2 & 0x3001000))
                return 0;
        }
    }
    r13 = 0;
    if (!txop_sent) {
        if (rx_ppdu_report_seen != 0)
            goto done;
        if (ctx->flags & 1)
            rx_txop_continue(ctx);
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
 * rx_flow_handle_frame и командой 0x19000001 без замера (tools/arcemu/resp_lat.py).
 * Стандарт: Ack (802.11-2020 10.3.2.11), BlockAck на A-MPDU/BAR (10.25.3, 10.25.6), DMG CTS на RTS
 * (10.3.2.9) — через SIFS; aSIFSTime 3 мкс (Table 20-30), допуск DMG −0 %/+10 %×(aSlotTime −
 * aAirPropagationTime) ≈ +0,49 мкс (10.3.2.3.3). Момент запуска ответа, по гипотезе
 * docs/LMAC-PROTOCOL.md, держит сам MAC (0x886d10, см. rx_flow_step); от uc нужно, чтобы команды
 * успели раньше этого момента — опоздание MAC отмечает битами MAC_HW_ICR (см. выше). */
static inline __attribute__((always_inline)) void
rx_frame_tx_resp_seq(u32 kind, struct tx_ctx_s *ctx, u32 sta, u32 resp, int fast)
{
    UC_PAD(PAD_RESP_CMD);
    mtp_service_dispatch(kind, sta, ctx->resp_ctx8, 0xff);
    while (!(mac_mtp_resp() & MAC_MTP_RESP_VALID))
        ;
    u32 r51 = mac_mtp_desc();
    if (!fast) {
        mtp_desc_lo = r51 & 0xf;
        mtp_desc_hi = r51 >> 4;
    }
    uc_mac_cmd((MAC_MTP_RESP_MCS_OF(mac_mtp_resp()) << 4) | 0x3e000000);
    uc_mac_cmd(0x37000020);
    if (!fast)
        uc_stats.tx_start += 1;
    u32 v = (abif_dvs_rf_ctrl_shadow & 0xfcffffff) | (rf_set_tx << 24);
    abif_dvs_rf_ctrl_shadow = v;
    MMIO32(HW_ABIF_DVS_RF_CTRL) = v;
    uc_mac_cmd(0x2008000);
    uc_mac_cmd(0x19000001);
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
    uc_mac_cmd(0x18000000);
}

/* Медленный путь (через switch в конце rx_flow_handle_frame) — без переноса записей. */
static __attribute__((noinline)) void rx_frame_tx_resp(u32 kind, struct tx_ctx_s *ctx)
{
    rx_frame_tx_resp_seq(kind, ctx, ctx->sta, 0, 0);
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
    u32 r16 = 0, r18 = 0;

    UC_PAD(PAD_RESP_ENTRY);
    if (!(mac_evt1() & MAC_EVT1_PPDU_REPORT))
        uc_wait_event_busy(MAC_EVT1_PPDU_REPORT, 0);
    if (rx_buf_toggle_dis == 0) {
        uc_mac_cmd((rx_buf_toggle_cnt & 1) | 0x32000000);
        rx_buf_toggle_cnt += 1;
    }
    {
        /* Быстрая проверка — по абсолютному адресу, без базы в регистре: путь до ответа (ХРУПКО). */
        if (VOL(rx_meas.state) == 2) {
        struct rx_meas_ctx *m = &rx_meas;
        if (m->kind != 0 && m->kind <= 6 && rx_capture_match_filter(m) != 0) {
            switch (m->kind) {
            case RX_MEAS_ENERGY: rx_meas_append_sample(m, 0); break;
            case RX_MEAS_PLCP: rx_meas_finish_with_8830ec(m); break;
            case RX_MEAS_PKT: rx_meas_capture_frame(m, 0); break;
            case 5:
                uc_mac_sel(MAC_SEL_TSF_LOW);
                uc_nop3();
                m->snap_sel5 = mac_status_sel();
                uc_mac_sel(MAC_SEL_TSF_HIGH);
                uc_nop3();
                m->snap_sel6 = mac_status_sel();
                m->state = 1;
                bf_pending_set_bit(0);
                break;
            default: break;
            }
        }
        }
    }

    if (mac_rx_rep1() & MAC_RX_REP1_BEACON) {
        /* 0x932098: маяк/SSW от сети */
        bti_cnt.net_bcn_rx += 1;
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
    {
        u32 r1 = rxf.flags;
        u32 r0 = 0;
        if (rx_qset4_hit != 0 && (r1 & 8))
            r0 = (txop_qid_mask & (1u << (ctx->qid & 31))) ? 1 : 0;
        local = (u8)r0;
        rxf.flags = (r1 & ~0x10u) | ((r0 & 1) << 4);
    }
    uc_nop3();
    uc_mac_sel(MAC_SEL_PLCP_RX);
    uc_nop3();
    if (((mac_rx_rep2() & MAC_RX_REP2_CF_END) && rx_buf_duration != 0) ||
        (mac_rx_rep2() & MAC_RX_REP2_RTS) || (mac_status_sel() & MAC_PLCP_SIFS_RESP))
        rx_end_switch_to_tx();
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
        ctx->mtp_state = rx_get_required_response(ctx, &local);
        u8 lvl = (u8)rx_last_mcs;
        u8 sta0 = *(u8 *)ctx;
        u32 r15 = 0;
        if ((mac_rx_rep1() & MAC_RX_REP1_BACK) && (mac_rx_rep3() & MAC_RX_REP3_BAP_EN)) {
            /* СРОК: ожидание r53.bap_tx_update_ind (таймаут — GP-таймер 0x23010003, единица не
             * установлена; при таймауте assert 0x3b) стоит до запроса ответа в MTP — каждый такт
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
        if ((mac_rx_rep3() & (MAC_RX_REP3_ADDR2_VALID | MAC_RX_REP3_RD)) == (MAC_RX_REP3_ADDR2_VALID | MAC_RX_REP3_RD)) {
            rxf.flags |= 8;
            r15 = 1;
        }
        if (dti_qset_mode != 0 && rs_state[sta0].active != 0)
            r15 = 0;
        if (ctx->mtp_state == 0)
            r15 = 0;
        if (rx_flow_substep_uc(ctx) == 0) {
            r16 = local;
            if ((r15 & rx_qset4_hit) && *sta == rxf.key_sta)
                r16 |= 1;
        }
        u32 r5 = ctx->mtp_state;
        if (r5 == 0 && r16 != 1) {
            rx_mac_prepare();
            if (mac_rx_rep2() & MAC_RX_REP2_CF_END) {
                txrx_state2 |= (1u << 9);
                rx_cf_end_nav_reset(rx_buf_duration);   /* CF-End нам без ответа (Duration 0) — ответа нет, срока нет */
            }
            rxf.flags |= 4;
        } else {
            if (r5 == 1)
                r16 = 0;
            if (r5 != 0 && !(ctx->flags & (1u << 9)))
                r16 = 0;
            u32 s1 = *sta;
            u32 m = sta_tab[s1].tx_sel;
            uc_mac_cmd(0x37000005);
            uc_mac_cmd(0x37000002);
            uc_mac_cmd(m | 0x3f000000);
            if (r16 == 0 && r5 - 1 < 3) {
                /* Быстрый путь ответа ACK/BA (vendor 0x932a0c, случаи 1..3): запрос в MTP
                 * сразу, записи ctx->flags/ctx->sta/0x802298/0x802294 — после команды 0x19000001
                 * (rx_frame_tx_resp_seq). ХРУПКО: тайминг практически без запаса у vendor;
                 * здесь запас ~20 инструкций, см. комментарий у rx_frame_tx_resp_seq. */
                u32 kind = r5 == 1 ? 0 : r5 == 2 ? 1 : 5;
                if (r5 == 3)
                    uc_mac_cmd(0x20000400);
                rx_frame_tx_resp_seq(kind, ctx, s1, r5, 1);
                rx_resp_finish_restore_rx((u32)ctx, kind, r5 == 1 ? r18 : 0);
                if (r5 == 3)
                    mac_mon_report.tx_cts += 1;
                uc_mac_cmd(0x14000000);
                if (ctx->mtp_state == 2)
                    rx_resp_abort_t2 = 1;
                else if (ctx->mtp_state == 1)
                    rx_resp_abort_t1 = 1;
                return 0;
            }
            ctx->flags = (ctx->flags & ~1u) | (r16 & 1);
            ctx->sta = s1;
            rxf.flags = (((r16 & 1) << 1) | (rxf.flags & ~2u)) | 4;
        }
    } else {
        /* 0x932910 */
        rx_mac_prepare();
        if ((mac_rx_rep3() & MAC_RX_REP3_FCS_OK_FULL) && MAC_RX_MISC_TYPE_IDX_OF(mac_rx_misc()) == 0x33 &&
            prs_mcast_addr[0] == f[10] && prs_mcast_addr[1] == f[11] && prs_mcast_addr[2] == f[12] &&
            prs_mcast_addr[3] == f[13] && prs_mcast_addr[4] == f[14] && prs_mcast_addr[5] == f[15]) {
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
        r18 = r16;
    }

    /* 0x932a0c */
    {
        u32 r5 = ctx->mtp_state;
        rxf.resp_type = r5;
        if (r16 != 0) {
            /* Продолжение TXOP — сразу, без возврата в rx_flow_run (ХРУПКО, см. rx_txop_continue).
             * Условия — те же, что rx_flow_run проверяет после возврата. */
            if ((txrx_state2 & 0x3001000) || rx_ppdu_report_seen != 0 || !(ctx->flags & 1))
                return 0;
            rx_txop_continue(ctx);
            return 1;
        }
        ctx->flags &= ~1u;
        /* СРОК: медленный путь ответа — тот же срок SIFS 3 мкс (802.11-2020 10.3.2.3.3), но без
         * переноса записей. Случаи 1..3 уходят быстрым путём выше (при r16 ≠ 0 — в продолжение
         * TXOP), сюда по коду не доходят; 8 (CF-End), 9 (Grant Ack) — всегда здесь.
         * Путь длиннее быстрого на ~10 инструкций до switch + вызов; запас не замерен. См. rx_flow_send_imm_response /
         * rx_send_dmg_cts. */
        switch (r5) {
        case 0:
            break;
        case 1:
            rx_frame_tx_resp(0, ctx);
            rx_resp_finish_restore_rx((u32)ctx, 0, r18);
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
            rx_cf_end_nav_reset(rx_flow_send_imm_response());   /* NAV — после ответа, вне срока SIFS */
            rx_resp_finish_restore_rx((u32)ctx, 3, 0);
            break;
        case 9:
            rx_send_dmg_cts();
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

u32 rx_funcs_rx_flow(void)
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
        u32 r = rx_check_g8005f8_bit24();
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
                    uc_mac_cmd(0x1b001111);
                    uc_mac_cmd(((q << 16) | 1) | 0x16000000);
                    uc_mac_cmd(0x17000000);
                    uc_nop3();
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
            ret = rx_check_g8005f8_bit24();
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
                mac_set_mode_0000();
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
    mac_set_mode_0000();
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

/* СРОК: путь держателя TXOP от принятого Ack/BlockAck (или ответа RD) до продолжения TXOP
 * (rx_txop_continue в rx_flow_run) — следующий кадр через SIFS 3 мкс (802.11-2020 10.23.2.8,
 * 10.29.3, 10.3.2.3.3). Вся функция на этом пути: ~330 инструкций кода (998 Б против 1080 Б у
 * vendor 0x931acc), основной проход оценочно 100–150 + rx_dispatch_by_g_8005f8 (с возможным
 * ожиданием BAP) + rx_end_switch_to_tx; запас общий с rx_txop_continue (ХРУПКО: +4 nop там
 * уже ломают RD-ветку) — единицы. */
void rx_flow_step(struct tx_ctx_s *a, u32 b)
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

    if (dti_qset_mode == 1)
        sends_pmc_mark_aaab02(&fsched_peers, b);

    uc_mac_cmd(0xeeee0b);

    u32 r11c = r15->x1c;
    if (r16 > r11c) {
        if (!(mac_evt1() & MAC_EVT1_TXOP))
            r13 = 1;
    }
    r13 = (u32)(u8)(u8)r13;
    if (rx_flow_substep_uc(r15) != 1)
        r17 = r13;

    if (!(mac_evt1() & MAC_EVT1_PPDU_REPORT))
        uc_wait_event_busy(MAC_EVT1_PPDU_REPORT, 0);

    struct rx_meas_ctx *r13p = &rx_meas;
    if (r13p->state == 2) {
        u32 r7 = r13p->kind;
        if (r7 != 0 && r7 <= 6) {
            if (rx_capture_match_filter(&rx_meas) != 0) {
                u32 r10v = r13p->kind - 1;
                if (r10v == 0)
                    rx_meas_append_sample(&rx_meas, 0);
                else if (r10v == 1)
                    rx_meas_finish_with_8830ec(&rx_meas);
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
                    bf_pending_set_bit(0);
                }
            }
        }
    }

    if (!(mac_rx_rep3() & MAC_RX_REP3_RD))
        rx_end_switch_to_tx();

    if (rx_buf_toggle_dis == 0) {
        uc_mac_cmd((rx_buf_toggle_cnt & 1) | 0x32000000);
        rx_buf_toggle_cnt += 1;
    }

    /* L_931c5c */
    if (mac_rx_rep3() & MAC_RX_REP3_ADDR2_VALID) {
        u32 r7 = MAC_RX_REP3_ADDR2_IDX_OF(mac_rx_rep3());
        rxf.sta = r7;
        u32 r8 = rx_mode_flags;
        if (!(r8 & 1) && !(r8 & 2)) {
            if (rs_state[r7].active == 0) {
                if (sel_nbr.cur_gain_db < sel_nbr.min_gain_db) {
                    sel_nbr.min_gain_db = sel_nbr.cur_gain_db;
                    sel_nbr.min_sta = (u8)r7;
                }
            }
        }
    }

    u32 disp = rx_dispatch_by_g_8005f8();
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
        r14 = sta_tab[r15->sta].tx_sel;
        if (qid_agg_mask & r10)
            txrx_state2 |= (1u << 30);
    } else {
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

    /* L_931e18 */
    r11 = r13 & 1;
    r5 = r11 << 1;          /* vendor L_931e18: 2-операндный `asl r5,r11` = сдвиг на 1 */
    rxf.flags = r5 | (rxf.flags & ~2u);
    r15->flags = (r13 & 1) | (r15->flags & ~1u);

    /* Продолжение TXOP после ответа партнёра — через SIFS (802.11-2020 10.23.2.8). 0x886d10 —
     * самый ранний момент старта ответа RX→TX {такты, мкс}; пишем ровно SIFS (ifs.sifs, 3 мкс).
     * Vendor (0x931e72) писал «SIFS_CNT на момент чтения r55 + {[0x802588] + 13 тактов, [0x802589]
     * мкс}» — значение зависело от длины пути uc и выходило ≈5,4 мкс (0x54x), т. е. позже SIFS.
     * Стенд 2026-10-21 (опыт E2): зазор «BA партнёра → следующий PPDU»
     * у получателя — vendor-формула ~10,4 мкс, константа SIFS 8,6, без записи (0x100) 8,6;
     * скорость и ошибки fw без изменений. Константа убирает подгонку и r55 с пути. */
    if (r13 == 1) {
        UC_PAD(PAD_D10_WRITE);
        *(volatile u32 *)HW_MAC_RX2TX_RESP_START = ifs.sifs;
        uc_mac_cmd(0x14000206);
        uc_mac_cmd(0x37000005);
        uc_mac_cmd(0x37000002);
        uc_mac_cmd(r14 | 0x3f000000);
    }
}

/* СРОК: вызывается из rx_flow_handle_frame до запроса ответа в MTP — вся функция в сроке SIFS
 * 3 мкс (802.11-2020 10.3.2.3.3): QoS Data/BAR → Ack/BlockAck (10.3.2.11, 10.25.3), RTS → DMG CTS /
 * DMG DTS (10.3.2.9, 10.39.6.6.2), CF-End (10.39.8.1), Grant → Grant Ack (10.39.4). Размер 1220 Б
 * против 1468 Б у vendor 0x932e40; ветка RTS — одно чтение TSF (~9 инструкций с командой 0x4d
 * и nop; проверка NAV — grant_detect_step_at по нему же); ветка данных — ожидание MAC_BAP_RX_UPDATE без ограничения (ниже).
 * Запас общий с rx_frame_tx_resp_seq: единицы. Логи uc_log_emit* — только на ветках без ответа. */
UC_HOT
u32 rx_get_required_response(struct tx_ctx_s *frame, u32 *out)
{
    /* 6.2 asm 0x932e40. */
    u32 r14 = 0, r16 = 0, r17 = 0;

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
        /* СРОК: ожидание MAC_BAP_RX_UPDATE (BAP: приём учтён) без таймаута — на пути до Ack/BlockAck через SIFS
         * (802.11-2020 10.3.2.3.3). Как у vendor 0x933004 (тоже без ограничения); запас задаёт BAP.
         * Если BAP не ответит — uc висит здесь (метка 0xff31 в uc_wait_marker). */
        VOL(uc_wait_marker) = 0xff31;     /* метка ожидания: gcc выкидывал запись как мёртвую */
        while (!(mac_bap_if() & MAC_BAP_RX_UPDATE))
            ;
        VOL(uc_wait_marker) = 0;
        rx_bap_rx_up = (mac_bap_if() & MAC_BAP_RX_UP_STATUS) ? 1 : 0;
        uc_mac_cmd(0x1c000008);
        goto bap_rx_done;
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
        if (VOL(link_stat[rxf.sta].bf_reasons) != 0)
            return 0;
        /* NAV занят. 10.3.2.9: если NAV поставил кадр самого отправителя RTS — отвечать (DMG CTS); иначе не
         * отвечать. исправлено (vendor): отвечал DMG DTS — по 10.39.6.6 он только для назначения SP (в open SP
         * нет), а поле NAV-SA заполнял MAC собственным адресом (заголовок 0x10 = FC, Duration, RA, TA). */
        if (__builtin_expect(grant_detect_step_at(tsf + ((u8 *)&ifs.sifs)[1], 0, 0) == 0, 0) &&
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
        brp_split_id(r0->rf_word);
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
void rx_funcs_handle_ppdu_report(void)
{
    /* 6.2 asm 0x9316cc. */
    u32 sec[2];                                 /* [sp,0], [sp,4] */
    s8 lvl[4];                                  /* [sp,8] */
    volatile u32 *flags = (volatile u32 *)&sls_rx.flags;
    volatile u32 *sta = (volatile u32 *)&rxf.sta;

    rx_ppdu_report_seen = 1;
    uc_mac_cmd(0xeeee0a);
    uc_wait_event_busy(MAC_EVT1_PPDU_REPORT, 0);
    if (rx_buf_toggle_dis == 0) {                 /* [gp,-242] */
        uc_mac_cmd((rx_buf_toggle_cnt & 1) | 0x32000000);
        rx_buf_toggle_cnt += 1;
    }
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
        rx_funcs_record_level_8020f8_8020fc((u32)(s32)lvl[0]);
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
            *flags = fl & ~1u;
        }
        goto out;
    }
    case 0x400000: {
        if (!(mac_rx_rep2() & MAC_RX_REP2_SSW_ACK))
            goto out;
        rx_parse_ssw_field((u32)&sec[0], (u32)&sec[1], (u32)&lvl[0]);
        rx_funcs_record_level_8020f8_8020fc((u32)(s32)lvl[0]);
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
 * код вокруг как у vendor 0x9333fc. Запас общий с rx_txop_continue: единицы. */
u32 rx_dispatch_by_g_8005f8(void)
{
    /* 6.2 asm 0x9333fc. */
    u32 r2 = txrx_state2;
    if (!(r2 & (1u << 8)))
        return 0;
    u32 mode = r2 & 0x1f;
    u32 r14 = MAC_RX_REP3_RX_MCS_OF(mac_rx_rep3());

    switch (mode) {
    case 1: {   /* L_933436 */
        if (!(mac_rx_rep1() & MAC_RX_REP1_IMM_ACK))
            return 0;
        if (mac_rx_rep3() & MAC_RX_REP3_RD)
            return 0;
        if ((mac_rx_rep3() & MAC_RX_REP3_BAP_EN) && mac_cmd31_mode != 0) {
            if (!(mac_bap_if() & MAC_BAP_TX_UPDATE)) {
                uc_mac_cmd(0x23010003);
                uc_mac_cmd(0x2000200);
                arc_nops_nop(2);
                while (!(mac_evt1() & MAC_EVT1_GP_TIMERS) && !(mac_bap_if() & MAC_BAP_TX_UPDATE))
                    ;
                if (mac_evt1() & MAC_EVT1_GP_TIMERS)
                    uc_assert((u32)__builtin_return_address(0), 0x3b);
            }
            bap_tx_up_status = mac_bap_if() & MAC_BAP_TX_UP_STATUS;
            uc_mac_cmd(0x1c000001);
        }
        if (r14 >= 1)
            ba_stats.active = 1;
        rx_ack_rcvd = 1;
        return 1;
    }
    case 2: {   /* L_9334f8 */
        if (!(mac_rx_rep1() & MAC_RX_REP1_BACK))
            return 0;
        if (mac_rx_rep3() & MAC_RX_REP3_RD)
            return 0;
        if (!(mac_rx_rep3() & MAC_RX_REP3_BAP_EN))
            return 0;
        if (mac_cmd31_mode != 0) {
            if (!(mac_bap_if() & MAC_BAP_TX_UPDATE)) {
                uc_mac_cmd(0x23010003);
                uc_mac_cmd(0x2000200);
                arc_nops_nop(2);
                while (!(mac_evt1() & MAC_EVT1_GP_TIMERS) && !(mac_bap_if() & MAC_BAP_TX_UPDATE))
                    ;
                if (mac_evt1() & MAC_EVT1_GP_TIMERS)
                    uc_assert((u32)__builtin_return_address(0), 0x3b);
            }
            bap_tx_up_status = mac_bap_if() & MAC_BAP_TX_UP_STATUS;
            uc_mac_cmd(0x1c000001);
        }
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
    case 4: {   /* L_933658 */
        if (!(mac_rx_rep2() & MAC_RX_REP2_CTS))
            return 0;
        struct tx_ctx_s *r4 = tx_ctx_pool.cur;
        u32 r1 = r4->sta;
        cts_rx_cnt[r1] += 1;
        uc_mac_cmd(0x20000400);
        return 1;
    }
    case 16:    /* L_933698: лишнее чтение r36 (mov r3,r36), затем как 8 */
        (void)mac_rx_rep1();
        /* fallthrough */
    case 8: {   /* L_93369c */
        if (mac_rx_rep3() & MAC_RX_REP3_RD)
            return 0;
        struct tx_ctx_s *r3 = tx_ctx_pool.cur;
        if (rxf.sta != r3->sta)
            return 0;
        return 1;
    }
    default:
        return 0;
    }
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
        r15 = (r14->qid << 16) | 1;
        u32 sta = r14->sta;
        if ((txrx_state1 & (1u << 1)) && rs_state[sta].active != 0)
            r13 = (mtp_queue_byte_by_index(sta) << 8) | 3;
        else
            r13 = 0;
        uc_mac_cmd(0x1b001111);
        uc_mac_cmd(r15 | (1u << 25) | (1u << 26) | (1u << 28));
        r13 |= 0x17000000;
        uc_mac_cmd(r13);
        arc_nops(3);
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
                if (bitstream_push((u32)sp, r1, 1, bf_ctrl.stat_bit) == 1) {
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
                    bitstream_push((u32)sp, bf_ctrl.ctrl_code_rx, 0, bf_ctrl.stat_bit);
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
        u32 st = bi_state_from_g800600();
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
        u8 sv = sta_get_sweep_byte(sp8, (u32)&spc);
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
    bf_pending_set_bit(0);
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

void rx_meas_finish_with_8830ec(struct rx_meas_ctx *m)
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

