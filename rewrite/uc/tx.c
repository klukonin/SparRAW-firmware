// SPDX-License-Identifier: AGPL-3.0-or-later
/* Внутренний TX uCode. */
#include "../include/bitfield.h"
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/sta_max.h"
#include "abft.h"
static inline s32 min(s32 a, s32 b) { return a < b ? a : b; }   /* ARC min (знаковое) */
static inline s32 max(s32 a, s32 b) { return a > b ? a : b; }   /* ARC max (знаковое) */


void internal_tx_noop_isr_hook(void)
{
}



void internal_tx_clear_exclude_mask(void)
{
    itx_pending.exclude = 0;
}

/* Снять очередь internal TX (qset 7, qid 31) без публикации масок qset — её делает вызывающий. */
void internal_tx_drop_event_mask(void)
{
    u32 r0 = qset_enable_mask & ~(1u << 7);
    qset_enable_mask = r0;
    u32 r1 = mac_tx_qid_en_shadow & 0x7fffffffu;
    mac_tx_qid_en_shadow = r1;
    MMIO32(HW_MAC_TX_QID_ENABLE_MASK) = r1;
}

void internal_tx_drop_event_mask_and_publish(void)
{
    internal_tx_drop_event_mask();
    mac_publish_masks();
}


void internal_tx_set_pending_flag(void)
{
    u32 r0 = qset_enable_mask | (1u << 7);
    qset_enable_mask = r0;
    mac_publish_masks();
    u32 r0b = mac_tx_qid_en_shadow | (1u << 31);   /* перечитать 0x8004c8 */
    mac_tx_qid_en_shadow = r0b;
    MMIO32(HW_MAC_TX_QID_ENABLE_MASK) = r0b;
}

#include "../include/arc.h"

void internal_tx_isr(void);                  /* tail.c */


void internal_tx_clear_pending_bit(u32 bit)
{
    u32 saved = arc_lr(ARC_STATUS32);
    arc_flag(saved & ~(1u << 1));
    u32 r1 = itx_pending.mask & ~(1u << bit);
    itx_pending.mask = r1;
    if (r1 == 0)
        internal_tx_drop_event_mask_and_publish();
    arc_flag((saved & (1u << 1)) | arc_lr(ARC_STATUS32));
}

void internal_tx_set_pending_bit(u32 a)
{
    u32 saved = arc_lr(ARC_STATUS32);
    arc_flag(saved & ~(1u << 1));
    if (itx_pending.mask == 0 && itx_pending.mask2 == 0)
        internal_tx_set_pending_flag();
    itx_pending.mask |= (1u << a);
    arc_flag((saved & (1u << 1)) | arc_lr(ARC_STATUS32));
}


void direct_tx_commit(void)
{
    uc_mac_cmd(0x33000002);
    if (tx_fifo_free != 0)
        uc_assert((u32)__builtin_return_address(0), 0x36);
}

void direct_tx_program_desc(u32 a, u32 b)
{
    uc_mac_cmd(0x33000001);
    tx_fifo_free = b;
    direct_tx_cmd34_hi = a;
    uc_mac_cmd((a << 16) | (b | 0x34000000));
}

/* bf_ctl — младший октет BF Control (9.5.5, рис. 9-851/9-852): 0 — без обучения (Beamforming Training = 0, остальные
 * подполя зарезервированы). */
void direct_tx_init_grant_ack(struct dtx_ctrl_frame *a, u32 bf_ctl)
{
    a->fc = 0x764;
    /* Grant Ack (802.11-2020 9.3.1.18, рис. 9-57): после TA — 5 октетов Reserved, затем BF Control. исправлено (vendor
     * direct_tx__init_rx_desc 0x9246c4): байт +0x14 не обнулялся (уходил остаток стека), в B4..B6 ставился код
     * AllocationType от Grant — у Grant Ack это Reserved. */
    a->alloc = 0;
    a->alloc_hi = 0;
    a->bf_ctl0 = (u8)bf_ctl;
    a->bf_ctl1 = 0;
}


u32 itx_wait_ack(void)
{
    uc_mac_cmd(0x2011000);
    for (;;) {
        uc_wait_event1_or_event4(MAC_EVT1_RX_FRAME, MAC_EVT4_GP0_END, 0);
        if (mac_evt1() & MAC_EVT1_RX_FRAME) {
            if (rx_ppdu_is_ack() != 0)
                return 1;
        } else if (mac_evt4() & MAC_EVT4_GP0_END) {
            return 0;
        }
    }
}

u32 itx_wait_cts_b(void)
{
    uc_mac_cmd(0x2011000);
    for (;;) {
        uc_wait_event1_or_event4(MAC_EVT1_RX_FRAME, MAC_EVT4_GP0_END, 0);
        if (mac_evt1() & MAC_EVT1_RX_FRAME) {
            if (rx_ppdu_is_cts() != 0)
                return 1;
        } else if (mac_evt4() & MAC_EVT4_GP0_END) {
            return 0;
        }
    }
}


/* Кадр управления FIFO с RA = MAC станции a: FC (Type 1, Subtype b, Control Frame Extension c), RA — r34, TA — свой
 * адрес (0x33000443). Вызовы — RTS (b = 0xb) и CF-End (0xe), c = 0. Ветвь vendor c = 5 (DMG CTS, TA = MAC станции a)
 * — DMG CTS-to-self перед групповыми данными tx_bcast_flow — удалена вместе с ним (MAC-STAND «Групповые данные точки
 * без DMG CTS-to-self»). */
void direct_tx_send_after_delay(u32 a, u32 b, u32 c)  /* 6.2 asm 0x938218 */
{
    arc_core_wr(33, ((b << 4) | (1u << 2)) | (c << 8));
    tx_fifo_free = tx_fifo_free - 4;
    const u16 *mac = sta_tab[a].mac;
    arc_core_wr(34, mac[0] | (1u << 24));
    arc_core_wr(34, mac[1] | (1u << 24));
    arc_core_wr(34, mac[2] | (1u << 24));
    tx_fifo_free -= 0xc;
    uc_mac_cmd(0x33000443);
    uc_wait_direct_tx_ready();
    direct_tx_commit();
}
void mac_program_tx_result_ctx_uc(u32 a, u32 b, u32 c)  /* 6.2 asm 0x92db20 */
{
    (void)c;
    MTP_REQUEST(MTP_W16_Q(a, 0x10u), MTP_W17((b == 0) ? 0u : 0x103u));
}

void tx_crypto_ctl_arm(void)
{
    MMIO32(HW_TX_CRYPTO_CTL) = 0x102;
}

void tx_initiator_reset_slot_counters(u32 a)
{
    struct rs_sta_state *st = &rs_state[a];
    st->active = 0;
    st->phase_prev = st->phase;
    st->phase = 0;
}


u32 tx_submit_frame(struct tx_ctx_s *a, u32 b, u32 c, u32 d)
{
    UC_STAMP_T0(STAMP_MTP_LAT, mtp_t0);
    mac_program_tx_result_ctx_uc(a->qid, b, c);
    while (!(mac_mtp_resp() & MAC_MTP_RESP_VALID))
        ;
    UC_STAMP_T0(STAMP_MTP_LAT, mtp_t1);
    { u32 _r51 = mac_mtp_desc(); mtp_desc_lo = _r51 & 0xf; mtp_desc_hi = _r51 >> 4; }
    while (!(mac_mtp_perm() & MAC_MTP_PERM_VALID))
        ;
    UC_STAMP(STAMP_MTP_LAT, 2u << 16 | (mtp_t1 - mtp_t0), arc_lr(0x100) - mtp_t0);
    if (c == 1) {
        d |= (1u << 15) | (1u << 27) | (1u << 28);
        uc_mac_cmd(d);
    }
    return (((u8)mac_mtp_perm() & a->ack_mask) != 0) ? 1 : 0;
}


u32 itx_ka_rr_pick(u32 out)
{
    /* 0x927f00: циклический выбор старшей ожидающей станции ниже указателя [0x800442];
     * указатель 0 или пустая выборка — заново с 8. */
    u32 pending = itx_ka_pending;
    if ((pending & 0xff) == 0)
        return 0;
    for (;;) {
        u32 rr = itx_rr_b;
        if (rr == 0) {
            rr = 8;
            itx_rr_b = 8;
        }
        u32 mask = pending & ((2u << rr) - 1) & ~(1u << rr);
        if (mask != 0) {
            *(u32 *)out = 30 - arc_norm(mask);
            return 1;
        }
        itx_rr_b = 0;                         /* заставить взять 8 (vendor: r1 = 0) */
    }
}


void direct_tx_send_short_frame(u32 a)   /* 6.2 asm 0x93b32c */
{
    direct_tx_program_desc(0x10, 0x16);
    tx_fifo_write_bytes((u32)&ssw_tpl_fc, 4);
    tx_fifo_free -= 0xf;
    uc_mac_cmd((a << 10) | (a << 8) | 0x330000e3);
    uc_wait_direct_tx_ready();
    arc_core_wr(34, ssw_tpl_fb_sector);
    arc_core_wr(34, ssw_tpl_fb_snr);
    arc_core_wr(34, ssw_tpl_fb_b2);
    tx_fifo_free -= 3;
    direct_tx_commit();
}

void internal_tx_clear_pending(u32 a)
{
    u32 saved = arc_lr(ARC_STATUS32);
    arc_flag(saved & ~(1u << 1));
    u32 r0 = itx_ka_pending;   /* ld_s [gp,0x48] = 0x800570 */
    if (r0 != 0) {
        r0 &= ~(1u << a);
        itx_ka_pending = r0;
    }
    if (r0 == 0) {
        internal_tx_clear_pending_bit(2);
        uc_res_vote_release(2);
    }
    arc_flag((saved & (1u << 1)) | arc_lr(ARC_STATUS32));
    r0 = itx_ka_pending;
    FWSH(ll_ctx, pending_mask) = r0;                        /* delay-слот brhs.d — всегда */
    if (a < SPARRAW_MAX_STA) {
        VOL(link_stat[a].ka_fail) = 0;
        VOL(link_stat[a].ka_cca_busy) = 0;
    }
}

u32 tx_await_rx_or_timeout(void)   /* 6.2 asm 0x924c78 */
{
    uc_mac_cmd(0x2011000);
    for (;;) {
        uc_wait_event1_or_event4(MAC_EVT1_RX_FRAME, MAC_EVT4_GP0_END, 0);
        if (mac_evt1() & MAC_EVT1_RX_FRAME) {
            /* кадр принят */
            uc_wait_event_busy(MAC_EVT1_PPDU_REPORT, 0);
            if (rx_buf_toggle_dis == 0) {   /* ldb [gp,-0xf2] */
                u32 v = (rx_buf_toggle_cnt & 1) | (1u << 25) | (1u << 28) | (1u << 29);
                uc_mac_cmd(v);
                rx_buf_toggle_cnt = rx_buf_toggle_cnt + 1;
            }
            ppdu_evt_cnt += 1;                    /* ld_s [gp,0x50] → st.as [gp,0x14]: 0x800578 */   /* st.as [gp,0x14] / ld [gp,0x50] */
            uc_stats.rx_arm = uc_stats.rx_arm + 1;   /* [0x8022c8 + 0x3c] */
            uc_mac_cmd(0x20d2000);
            return mac_rx_rep2() & MAC_RX_REP2_CF_END;
        } else if (mac_evt4() & MAC_EVT4_GP0_END) {
            return 1;   /* таймаут */
        }
    }
}


/* СРОК: запуск передачи (tx_submit_frame: 0x1b/0x16/0x17 → r43 → r45 → 0x18008000) после
 * события слота CBAP (r42.slot_event, ожидание в mac_select_all_sectors_and_wait) и проверки
 * CCA (r40[a].cca_ppdu_comp, !r42.busy2) — пока не кончился слот отсрочки (aSlotTime 5 мкс,
 * 802.11-2020 10.23.2.2, 10.39.5), иначе проверка CCA устаревает и растёт риск коллизии.
 * Аппаратный срок MAC (что считает «поздно» после 0x29000001) не установлен.
 * Путь ~160 инструкций + ответ MTP (vendor ~ так же, тот же порядок команд); запас: сотни
 * тактов до конца слота. Тот же участок «слот → CCA → mac_program_tx_vector(5) → 0x19000001»
 * есть в internal_tx_keepalive_flow (~78 инструкций), tx_bcast_flow,
 * bcon_txss_sweep_step (b == 5), txop_await_cts_ppdu (txss.c). Срыв: поздний старт после
 * слота — коллизия с соседом, отсчитавшим отсрочку; кадр/TXOP теряется, растёт CW. */
/* Закрытие TXOP очереди управления без передачи: запроса итога у неё нет (tx_send_and_await_rx_frame), CF-End
 * (10.23.2.10) не уйдёт, если до конца остатка TXOP его не вместить, MAC уже закрыл TXOP (txop_event) или настал TBTT
 * (bi1_event) — дальше BTI, передавать нельзя (10.39.2, 10.39.5: CBAP кончается к TBTT). Остаток — по сроку,
 * запомненному при открытии (txop_rem_end_tsf: TSF + REMAINING_TIME), а не по REMAINING_TIME сейчас: за ~2 мкс до
 * TBTT он перескакивает на следующий BI (снова большой), bi1_event у станции к этому моменту ещё не поднят — стенд
 * u6000f2 (проверка REMAINING) и u6000f3 (+ bi1_event: ожидание Ack кончилось за 0,7 мкс до TBTT, слот и CCA ушли за
 * TBTT) упали так же. Нужно: слот + CF-End (CF_END_CLOSE = CF_END_MIN_REM_US · такт + aSlotTime). Срок — по TSF
 * (мкс; разность со знаком — срок прошёл), не по Timer1: COUNT1 обнуляет каждый тик L1 (txop_note_rem_end, tail.c).
 * Отдельная функция (noipa): путь «слот → CCA → пуск» в tx_cca_check_and_send не получает живых регистров. */
static __attribute__((noipa)) u32 tx_close_mgmt_nothing_to_send(void)
{
    s32 left = (s32)(txop_rem_end_tsf - MMIO32(HW_MAC_TSF_LO));
    return left <= 0 || (u32)left * CLKK(MHZ) < CLKK(CF_END_CLOSE) || (mac_evt1() & (MAC_EVT1_TXOP | MAC_EVT1_BI1));
}

void tx_cca_check_and_send(struct tx_ctx_s *a, u32 b, u32 c, u32 d)
{
    /* Закрытие обмена в своём SP — без передачи (uc/ese_dti.c, рычаг 3): ни запроса итога (QoS Null), ни CF-End */
    if (ese_dti_sp_src_end(a->sta)) {
        txrx_state2 |= (1u << 9);
        return;
    }
    /* Очередь управления, CF-End не вмещается до конца TXOP (срок от открытия) или настал TBTT: передавать нечего — ни
     * слота, ни CCA, ни команд TX.
     * исправлено (наше):
     * прежде закрытие шло до решения о CF-End и за TBTT — после тайм-аута Ack кадра, кончившегося у границы
     * (10.39.5: обмен открыт до конца CBAP), uc давал 0x29000001, TX-вектор и 1 << 29 уже в BTI; через ~1 мкс —
     * MAC_HW_ICR б16 → INT6 → assert 0x6000. Стенд 2026-11-20 (u6000st, метки 45/38/40/11): Probe Request станции к
     * точке, не отвечающей Ack, открыт за 69 мкс до TBTT; ожидание ответа кончилось за TBTT, вход L2 — через 167
     * тактов после закрытия. */
    if (d == 0 && a->qid == MACQ_MGMT_QID && tx_close_mgmt_nothing_to_send()) {
        txrx_state2 |= (1u << 9);
        return;
    }
    u32 r0 = mac_sel_shadow & ~MAC_SEL_FIELD;
    mac_sel_shadow = r0 | (1u << 13) | (1u << 15);
    uc_mac_cmd(r0 | MAC_CMD_STATUS_SEL | MAC_SEL_PHY_SIGNALS);
    UC_STAMP_T0(STAMP_CCA_SLOT, t_s0);
    UC_STAMP_V(STAMP_CCA_SLOT, ps0, mac_status_sel());
    mac_select_all_sectors_and_wait();
    UC_STAMP_T0(STAMP_CCA_SLOT, t_s1);
    UC_STAMP_V(STAMP_CCA_SLOT, ps1, mac_status_sel());
    mac_cmd_29000001();
    if (mac_cca_ok()) {
        u32 r3 = a->sta;
        struct sta_entry *r3b = &sta_tab[r3];
        mac_program_tx_vector(5, r3b->tx_sel, b);
        tx_send_and_await_rx_frame(a, c, d, 0);
    } else {
        uc_mac_cmd(0x29000002);
    }
    UC_STAMP(STAMP_CCA_SLOT, (ps0 >> 8 & 0x3f) | (ps1 >> 8 & 0x3f) << 8 | (ps1 >> 16 & 0x3f) << 16 | (ps1 >> 24 & 1) << 24,
             (t_s1 - t_s0) | mac_rx_rep1() << 16);
    txrx_state2 |= (1u << 9);
}

void tx_program_vector_rf(u32 a, u32 b)
{
    (void)a;
    uc_mac_cmd(0x38000200);
    uc_mac_cmd(b | 0x3f000000);
    uc_mac_cmd(0x3e000000);
    uc_mac_cmd(0x37000020);
    uc_stats.tx_start += 1;
    u32 r0 = abif_dvs_rf_ctrl_shadow & 0xfcffffff;
    r0 |= rf_set_tx << 24;
    abif_dvs_rf_ctrl_shadow = r0;
    *(volatile u32 *)HW_ABIF_DVS_RF_CTRL = r0;
}

void direct_tx_build_desc(const struct sls_peer_rec *s, u32 *b)   /* 6.2 asm 0x92bf38 */
{
        u8 *d = (u8 *)b;
    /* FC = 0x0964 (SSW-Feedback). Vendor: stw 0 в d[0..1], затем ld/st всего слова с
     * битовыми полями FC (поворот на 32 бита в сумме) — Duration (d[2..3]) остаётся
     * мусором стека вызывающего (direct_tx_ssw_feedback), как в txss_init_send_ssw_fdbk.
     * Здесь Duration = 0, как в кадрах из шаблонов DCCM. */
    *(u32 *)d = 0x964;
    d[0x10] = s->rx_sector | (s->rx_antenna << 6);
    d[0x12] = 0;
    d[0x13] = 0;
    d[0x14] = 0;
    d[0x15] = 0;
    d[0x16] = 0;
    d[0x11] = s->rx_snr_rep;                        /* SNR Report (9.5.3), snr_report_phy (abft.h) */
    d[0x17] = 0;
    struct ssw_ack_frame *fr = (struct ssw_ack_frame *)b;   /* та же раскладка: RA +4 */
    fr->ra[0] = s->peer_mac[0];         /* ldh/sth */
    fr->ra[1] = s->peer_mac[1];
    fr->ra[2] = s->peer_mac[2];
}

/* СРОК: команда передачи ответа 0x19000001 (а за ней кадр в FIFO у вызывающего) до SIFS
 * (3 мкс, допуск −0/+0.49 мкс) от конца принятого кадра — DMG CTS на RTS, Grant Ack, немедленный
 * ответ (802.11-2020 10.3.2.3.3, 10.3.2.9). Зовут rx_send_grant_ack /
 * rx_send_cf_end_response (rx.c) из ветки rx_flow_handle_frame — путь до входа сюда и
 * подача кадра после 0x19 (MCS ctrl_frame_mcs = 1, SC) — там же.
 * Здесь: вход → 0x19000001 ~79 инструкций (vendor 0x9385d8 ~93, с __st_r15_to_r13); запас:
 * не измерен, по аналогии с rx_frame_tx_resp_seq (ХРУПКО, rx.c) — единицы-десятки
 * инструкций. Срыв: ответ позже SIFS — инициатор RTS не получает CTS (CTSTimeout, повтор
 * с отсрочкой); если MAC поднимает MAC_HW_ICR б5 на позднюю команду, как у ACK/BA, — assert
 * 0x26. Не добавлять код между входом и 0x19000001. */
void tx_send_imm_response(u32 a, u32 b, u32 c)
{
    UC_PAD(PAD_IMM_RESP);
    uc_mac_cmd_nl((a << 4) | 0x3e000000);
    uc_mac_cmd_nl(0x37000020);
    uc_stats.tx_start += 1;
    u32 r15 = b | (1u << 24);
    u32 r0 = abif_dvs_rf_ctrl_shadow;
    r0 &= ~(1u << 24);
    r0 &= ~(1u << 25);
    r0 |= rf_set_tx << 24;
    abif_dvs_rf_ctrl_shadow = r0;
    *(volatile u32 *)HW_ABIF_DVS_RF_CTRL = r0;
    direct_tx_program_desc(0x10, c);
    r15 |= (1u << 26) | (1u << 28);
    uc_mac_cmd_nl(r15);
    uc_mac_cmd_nl(0x14000007);
    mac_program_tx_with_rate(a);
    uc_mac_cmd_nl(0x2008000);
    uc_mac_cmd_nl(0x19000001);
    while (!(mac_mtp_perm() & MAC_MTP_PERM_VALID))
        ;
    uc_mac_cmd_nl(0x18001000);
}



void tx_ctx_post_status(struct pm_ctx_s *p, u32 arg, u32 type)   /* 6.2 asm 0x92845c */
{
    struct ps_evt_body *b = &p->evt;
    if (!p->ps_active) {
        b->awake = 0xff;                        /* ALL_CIDS */
        b->no_tx = 0;
    } else {
        u8 awake = ((u8 *)&p->awake_mask)[1] | (u8)p->awake_mask;
        b->awake = awake;
        b->doze_info = 0;                       /* vendor: AP — upm_vector, STA — in_doze; PS вырезан, fw не читает */
        if (uc_role_ap == 1 && type == 1) {     /* PS_EVT_CLEAR_PEER */
            struct tx_ctx_s *cid = tx_ctx_pool.cur;
            u32 mask = 1u << cid->sta;   /* asl r9,0x1,r8 */
            b->awake = (u8)(awake & ~mask);
        }
        b->no_tx = (u8)p->no_tx_mask;
    }
    b->arg = (u8)arg;
    b->doze_bi = 0;                             /* vendor: BI сна по расписанию — PS вырезан, fw не читает */
    b->type = type;
    uc_send_evt_ps_awake_peer((u32)b);
}

/* ---- Крупные flow-функции (>200Б) — структурные порты ---- */
void tx_pick_slot_for_peer(u32 a, u32 b, u32 c)
{
    if (qset_slots_en == 0)
        return;
    u32 q = sta_queue_class(b, c);
    u8 *slot = (u8 *)&qset_slot[q];
    u8 r2;
    if (a != 0) {
        u8 v = (u8)(slot[2] + 1);
        u8 lim = slot[1];
        if (v > lim) v = lim;
        slot[2] = v;
        uc_stats.slot_grow += 1;
        r2 = v;
    } else {
        r2 = slot[0];
        slot[2] = r2;
        uc_stats.slot_reset += 1;
    }
    uc_mac_cmd(((q + 9) << 24) | ((1u << r2) - 1));
    u32 w = qset_ack_cfg_default;
    u8 b0 = w & 0xff, b1 = (w >> 8) & 0xff, b2 = (w >> 16) & 0xff, b3 = (w >> 24) & 0xff;
    if (q < 4) { if (q == 0) b0 = 2; else if (q == 1) b1 = 2; else if (q == 2) b2 = 2; else b3 = 2; }
    u32 cfg = b0 | (1u << 27) | (b1 << 2) | (b2 << 4) | (b3 << 6)
            | (mac_chain_mask & rx_nav.ev_mask);
    uc_mac_cmd(cfg);
}

/* 0x9396f4. Таблица 0x801a8c по (n - 1): 0..2 → A, 3..5 → B, 6..7 → C. */
u32 tx_slot_pick_queue(u32 a, u32 b)
{
    u32 r16 = b;
    uc_mac_cmd(0xf000001);
    u32 r0 = mac_sel_shadow & 0xfffff0ff;
    mac_sel_shadow = r0;
    uc_mac_cmd(r0 | MAC_CMD_STATUS_SEL);
    arc_nops(3);

    u32 r13 = MAC_QSEL_LOWEST_QSET_OF(mac_queue_sel());
    u32 r15 = MAC_QSEL_QID_OF(mac_queue_sel());
    UC_STAMP(STAMP_QSEL, mac_queue_sel(), uc_read_tsf_lo() - MMIO32(HW_MAC_BI_START_TSF_LO));
    *(u32 *)a = r15;                                    /* st_s — слово */

    u32 r14 = r13 - 1;
    u32 r1;
    if (r13 < 7) {
        r1 = (u32)(uc_divmod_unsigned_qr(r14, 3) >> 32);   /* остаток из r1 */
    } else {
        r1 = r14 & 1;
    }
    if (r13 == 0)
        return 0;
    if (r16 != 1)
        return 1;
    if (r14 >= 8) {
        uc_assert((u32)__builtin_return_address(0), 0x8e);
        return 1;
    }
    r15++;
    u32 v;
    if (r14 < 3) {                                      /* 0x939778 */
        txq_slot_a[r1] = r15;
        v = txq_slot_a[0] | (1u << 24) | (1u << 28)
          | (txq_slot_a[1] << 8) | (txq_slot_a[2] << 16);
    } else if (r14 < 6) {                               /* 0x93979c */
        txq_slot_b[r1] = r15;
        v = txq_slot_b[0] | (1u << 25) | (1u << 28)
          | (txq_slot_b[1] << 8) | (txq_slot_b[2] << 16);
    } else {                                            /* 0x9397bc */
        qsel_last_qid_c[r1] = r15;
        v = qsel_last_qid_c[0] | (1u << 24) | (1u << 25) | (1u << 28)
          | (qsel_last_qid_c[1] << 8);
    }
    uc_mac_cmd(v);
    return 1;
}

void tx_slot_dispatch(u32 a)   /* 6.2 asm 0x938e34 */
{
    (void)a;
    u32 sp;
    struct tx_ctx_s *ctx = tx_ctx_alloc_next(1);
    /* Расписание DTI (802.11-2020 10.39.5, 10.39.6.2; uc/ese_dti.c): вне своего окна и в его хвосте, где TXOP не
     * кончится до конца окна, обмен не начинается — выход как «очереди нет» (выбор очереди без учёта слота: b = 0,
     * команды слота нет), MAC снова разыграет доступ. Без расписания — одно чтение. */
    u32 go = ese_dti_tx_gate();
    if (tx_slot_pick_queue((u32)&sp, go) == 0) {
        mac_backoff_settle_set_chain_modes(2);
        uc_stats.tx_no_queue += 1;           /* [0x8022c8 + 8] */
        uc_mac_cmd(0xeeee01);
        return;
    }
    if (go == 0) {
        mac_backoff_settle_set_chain_modes(2);
        uc_mac_cmd(0xeeee0d);                /* метка: доступ не по расписанию */
        return;
    }
    FWSH(fwsh_sp_gate, src_more) = FWSH(fwsh_sp_gate, init_sp);   /* своё SP — цикл источника продолжит (ese_dti.c) */
    mac_select_all_sectors_and_wait();
    if (mac_evt1() & MAC_EVT1_BUSY2) {
        txrx_state2 = 0x800;        /* st.as 0x800,[gp,0x34] */
        uc_stats.txop_fail += 1;           /* [0x8022c8 + 4] */
        mac_mon_report.fs_evt14_cnt += 1;           /* [0x8010b0 + 0x44] */
        return;
    }
    ctx->qid = sp;
    ctx->flags |= 1;
    if (sp == 0x1f) {
        uc_mac_cmd(0x80 | (1u << 25));
        uc_mac_cmd(0xeeee03);
        internal_tx_isr();
        uc_mac_cmd(mac_evt_en_shadow | 0x27003f00);
        mac_mon_report.fs_no_slot_cnt += 1;           /* [0x8010b0 + 0x48] */
        return;
    }
    u32 r0 = bcast_qid;           /* [gp,-0xc0] */
    if (sp != r0)
        tx_sta_run_txop(ctx);
    else if (r0 != 0xff)
        tx_bcast_flow(r0);
    else
        tx_sta_run_txop(ctx);
}

/* Конец обмена в своём SP после запроса итога (tx_send_and_await_rx_frame, ветка без CF-End): приём — после своего
 * кадра запроса итога (b ≠ 0), как в общем хвосте. Отдельная функция: в tx_send_and_await_rx_frame не добавляется
 * живых регистров — пролог и путь «слот → CCA → запрос итога» (СРОК) те же, что без цикла источника (codecmp). */
static __attribute__((noipa)) u32 tx_sp_end_restore_rx(u32 sta, u32 b, u32 qid)
{
    ese_dti_sp_src_end(sta);
    if (b != 0) {
        mac_set_rf_chain_state(1, sta_tab[sta].rx_sel);
        if (qid != MACQ_MGMT_QID)               /* событие 6 — конец QoS Null запроса итога; у очереди управления его нет */
            uc_wait_one_event(6);
        u32 r0 = abif_dvs_rf_ctrl_shadow;
        r0 &= ~(1u << 24);
        r0 &= ~(1u << 25);
        r0 |= rf_set_rx << 24;
        abif_dvs_rf_ctrl_shadow = r0;
        *(volatile u32 *)HW_ABIF_DVS_RF_CTRL = r0;
    }
    return 1;
}

u32 tx_send_and_await_rx_frame(struct tx_ctx_s *a, u32 b, u32 c, u32 d)   /* 6.2 asm 0x9249b4 */
{
    (void)d;
#define sta (*(volatile u32 *)a)                 /* vendor перечитывает [r13] в каждой точке */
    txr.awaiting = 0;                       /* [0x80242c + 8] */
    /* Запрос итога (tx_submit_frame: 0x16 qid | б4, пуск 0x18008000) MAC исполняет передачей: из очереди без кадров —
     * QoS Null (No Ack, Sequence Number — следующий за последним кадром очереди) перед CF-End (стенд 2026-11-06,
     * MAC-STAND «QoS Null перед CF-End держателя»; uc ждёт его busy2, иначе assert 0x92). После кадра очереди управления
     * это кадр класса 3 к пиру в State 2 — Probe Response, Association Request/Response, Disassociation, Action
     * (802.11-2020 11.3.3: «In State 2, only Class 1 or Class 2 frames are allowed»). исправлено: у очереди управления
     * запроса итога нет — TXOP закрывает CF-End (10.23.2.10), как у vendor с c == 0 (фиксированное расписание). Очереди
     * данных — как прежде (QoS Null в State 4 — класс 3 разрешён). */
    u32 res = (b != 0 && a->qid != MACQ_MGMT_QID);
    if (b != 0)
        uc_mac_cmd(1u << 29);
    if (res) {
        tx_submit_frame(a, 0, 1, 0);            /* vendor: 0x400 в UPM-doze — PS вырезан */
        UC_STAMP_T0(STAMP_MTP_RESULT, t_go);
        txr.submit += 1;                  /* [0x80242c + 2], ldw/stw */
        uc_mac_cmd(mac_evt_en_shadow | 0x27004000);
        uc_mac_cmd(0x2004000);
        arc_nops(3);
        uc_sleep_until_event(MAC_EVT1_BUSY2, 0xa);
        if (!(mac_evt1() & MAC_EVT1_BUSY2))
            uc_assert((u32)__builtin_return_address(0), 0x92);
        uc_spin_until_event(MAC_EVT1_TX_END);
        UC_STAMP(STAMP_MTP_RESULT, mac_mtp_resp(), (mac_mtp_perm() & 0xffff) | mac_mtp_desc() << 16);
        UC_STAMP(STAMP_MTP_RESULT, arc_lr(0x100) - t_go, a->qid | sta << 8);
    }
    u32 r14 = ((sta_tab[sta].flags >> 1) & 1) ^ 1;   /* ldw; lsr; bxor bit0 */
    /* Duration CF-End (9.3.1.6): CBAP — i = 2, ⌈TXTIME(CF-End) + SIFS⌉ = 18 (ответный CF-End пира — i = 1, последний).
     * исправлено (vendor): 0x22 = 34 или 0x17 = 23 по MCS CF-End
     * (sta_tab[].flags б1) — в эфире 19 на обоих MCS (H-DUR18), на 1 мкс больше 9.3.1.6.
     * 10.23.2.10: при остатке < 2·T(CF-End) + 2·SIFS после кадра — Duration 0; CF-End не шлём, если не хватает на сам
     * кадр (vendor не слал при остатке ≤ 27/38 мкс — пороги от своих Duration). Пороги — ifs.h.
     * В 0x15 — Duration + ⌈TXTIME⌉ своего CF-End на его MCS (r14): MAC вычитает его сам (H-DUR18, ifs.h); прежде
     * писали 18 — в эфире было 3. */
    u32 r17 = r14 ? CLKK(CF_END_CMD_SC1) : CLKK(CF_END_CMD_CTRL);
    if (c == 0) {
        u32 r0 = mac_sel_shadow & ~MAC_SEL_FIELD;
        mac_sel_shadow = r0 | (1u << 12) | (1u << 13);
        uc_mac_cmd(r0 | MAC_CMD_STATUS_SEL | MAC_SEL_REM_TIME);
        arc_nops(3);
        u32 rem = (u16)mac_status_sel();
        /* Своё SP (uc/ese_dti.c, цикл источника): CF-End пиру — усечение SP (10.39.8.1), не шлём. Закрытие из
         * tx_cca_check_and_send в своём SP сюда не доходит (без передачи), из mtp_get_tx_permission (MTP кадра не дал при
         * фазе поиска скорости) — доходит после запроса итога: QoS Null (No Ack) MAC в своём SP остаётся. Проверка не
         * раньше: на входе она удлиняла путь «слот → CCA → запрос итога» (СРОК, tx_cca_check_and_send) на 12 тактов
         * (эмулятор, test_air RD). Байт и переход в отдельную функцию (noipa) — без новых живых регистров (codecmp) */
        if (FWSH(fwsh_sp_gate, init_sp) != 0)
            return tx_sp_end_restore_rx(sta, b, a->qid);
        if (rem < CLKK(CF_END_MIN_REM_US) || (mac_evt1() & MAC_EVT1_TXOP))
            goto cf_end_done;
        if (rem < CLKK(CF_END_NZ_REM_US))
            r17 = 0;
    }
    txr.awaiting = 1;
    /* Срок ответа (GP0, мкс): CF-End с Duration ≠ 0 — ответный CF-End ждём AckTimeout 18 мкс. Duration 0 (усечение
     * SP, малый остаток TXOP) — ответ получатель не шлёт (10.23.2.10, 10.39.8.1): 1 мкс — сразу дальше. */
    u32 r18 = r17 ? 0x12 : 1;
    if (b != 0) {
        if (res)
            uc_wait_one_event(6);               /* конец передачи по запросу итога */
        mac_program_tx_vector(1, sta_tab[sta].tx_sel, r14);
    }
    txr.rx_wait = txr.rx_wait + 1;   /* [0x80242c + 4] */
    uc_mac_cmd(0x2008000);
    uc_mac_cmd(r17 | (1u << 24) | (1u << 26) | (1u << 28));
    uc_mac_cmd(0x14000007);
    u32 sp_buf;
    cf_end_send_frame(a, r14, 0xe, 1, (u32)&sp_buf);
    uc_mac_cmd(mac_evt_en_shadow | 0x27004000);
    uc_mac_cmd(0x2004000);
    arc_nops(3);
    uc_sleep_until_event(MAC_EVT1_BUSY2, 0xa);
    gp0_timer_arm_usec(r18);
    if (!(mac_evt1() & MAC_EVT1_BUSY2))
        uc_assert((u32)__builtin_return_address(0), 0xaa);
    uc_spin_until_event(MAC_EVT1_TX_END);
cf_end_done:   /* L_924ba4 */
    if (b != 0 || txr.awaiting != 0) {
        mac_set_rf_chain_state(1, sta_tab[sta].rx_sel);
        /* Событие 6 — конец своей передачи: CF-End (awaiting) или, без него, QoS Null запроса итога. исправлено
         * (наше): у очереди управления запроса итога нет, и при остатке TXOP меньше CF-End (или txop_event)
         * не передаётся ничего — события 6 нет, ожидание без срока. Стенд 2026-11-20 (u6000hold): assert 0x6000
         * (MAC_HW_ICR б16) застал uc в этом ожидании — txr.awaiting = 0, txr.submit = 0; б16 этим не объяснён (с
         * исправлением взводится и после выхода отсюда, docs/MAC-STAND.md H-RESULTGO). */
        if (txr.awaiting != 0 || a->qid != MACQ_MGMT_QID)
            uc_wait_one_event(6);
        u32 r0 = abif_dvs_rf_ctrl_shadow;
        r0 &= ~(1u << 24);
        r0 &= ~(1u << 25);
        r0 |= rf_set_rx << 24;
        abif_dvs_rf_ctrl_shadow = r0;
        *(volatile u32 *)HW_ABIF_DVS_RF_CTRL = r0;
    }
    uc_mac_cmd(0x14000000);
    if (rs_state[sta].active == 2)
        rs_state[sta].active = 1;
    mac_mon_report.cf_end += 1;     /* [0x8010b0 + 0x3a] */
    if (txr.awaiting != 0) {
        u32 r = tx_await_rx_or_timeout();
        rx_mode_configure(2, 0xff);
        if (r != 0) {
            uc_wait_txop_end();                 /* исправлено (vendor): ожидание без срока — см. uc_wait_txop_end */
            if (rx_resp_wait_en != 0) {
                uc_mac_cmd(0x1f000601);
                tx_slot_resp_seen = 1;
            }
        } else {
            uc_mac_cmd(0x14000100);
        }
    }
    return 1;
}
#undef sta

void tx_sta_run_txop(struct tx_ctx_s *ctx)
{
    /* 6.2 asm 0x93a088. */
    u32 r16;
    if (txrx_cfg_flags & (1u << 9))
        r16 = bf_ctrl.ctrl_code_tx_alt;
    else
        r16 = bf_ctrl.ctrl_code_tx;
    u32 r19 = txop_qid_mask;
    txop_pick_ctrl_code_by_peer(ctx);
    u32 r0 = txop_initiator_open_txop_flow(ctx);
    u32 r13 = ctx->sta;
    if (r0 == 0) {
        txop_qid_mask = r19;
        txrx_state2 &= ~(1u << 8);
        mac_select_rf_module_cmd31(0, 0);
        return;
    }
    struct tx_ctx_s *r1v = tx_ctx_pool.cur;
    u32 r2 = r1v->sta;
    if (sta_tab[r2].qid_mask_q6 & (1u << r1v->qid)) {
        if (txop_dma_bit1_pending == 1) {
            txop_clear_l2_offload_tx_ctl_bit1();
            txop_dma_bit1_pending = 0;
        }
    }
    struct rs_sta_state *rst = &rs_state[r13];
    if (rst->active != 0)
        txop_qid_mask = 0;
    uc_mac_cmd(0x80 | (1u << 25));
    mac_tx_qid_en_shadow |= txop_qid_mask;
    *(volatile u32 *)HW_MAC_TX_QID_ENABLE_MASK = mac_tx_qid_en_shadow;
    u8 sp_buf[4] = {0, 0, 0, 0};                /* stb.a r15(=0),[sp,-4]; дальше ldb_s [sp] */
    u32 r20 = tx_sta_wait_slot_and_tx(ctx, (u32)sp_buf);
    /* исправлено (vendor): RTS без DMG CTS (r20 == 2) — TXOP не получен (802.11-2020 10.3.2.9: передача RTS не удалась,
     * backoff — tx_pick_slot_for_peer(1) в tx_sta_wait_slot_and_tx). vendor шёл дальше в поток TXOP: циклы сразу
     * выходили (б8 снят), а закрытие TXOP (tx_cca_check_and_send → tx_send_and_await_rx_frame) делало запрос итога
     * передачи, которой не было, слало CF-End — «A non-AP STA that is not the TXOP holder shall not transmit a CF-End
     * frame» (10.23.2.10) — и ждало событий MAC (tx_end, txop_event) о TXOP, которого MAC не открывал. С нашей точкой
     * (теряла ~0,1 % RTS, sxd_hal_wait_slot2_busy) стенд 2026-11-03: поток станции → AP вставал через ~1 с. Закрытия
     * нет — как у vendor при rx_mode_flags б1 = 0 и без причин BF. */
    if (r20 != 2) {
        if (rst->active != 0)
            tx_sta_flow_loop(ctx);
        else
            rx_handle_status_flags(ctx);
    }
    struct link_stat_s *r15 = &link_stat[r13];
    if ((u8)r15->cts_fail >= (u8)r16) {
        if (bf_ctrl.triggers & (1u << 2))
            r15->bf_reasons |= 0x4;
        r15->cts_fail = 0;
    }
    r16 = 0;
    mac_select_rf_module_cmd31(0, 0);
    handle_bf_triggers(r13, 1);
    u32 r15v = (r15->bf_reasons & 0xbf) != 0;   /* bic r0,r0,-0xc0 == & 0xbf */
    if (r15v == 0) {
        u32 v = rst->phase;
        if (v == 3 || v == 4 || v == 5)
            r16 = 1;
        if (r16 != 0) {
            tx_initiator_reset_slot_counters(r13);
            bg_task_set_pending_bit(2);
        }
    }
    if (ba_stats.active != 0)
        FWSH_AT(ll_ctx, traffic, r13) += 1;
    if (r15v != 0 || sp_buf[0] == 1) {
        bf_metrics_reset_and_stamp();
        rx_check_mode_2(&rx_meas, r13);
    }
    mac_tx_qid_en_shadow &= ~txop_qid_mask;
    *(volatile u32 *)HW_MAC_TX_QID_ENABLE_MASK = mac_tx_qid_en_shadow;
    txop_qid_mask = r19;
    if (r20 == 0)
        /* vendor 0x93a238 (слот задержки bl.d): ldb_s r2,[r14,0x4], r14 = ctx — младший байт
         * ctx->qid. Порт-баг (исправлен 2026-10-19): было *(u8 *)(ctx + 4) — арифметика
         * указателя на struct tx_ctx_s (+4·0x3c = +0xf0, за пределами объекта): третьим
         * аргументом уходил мусор вместо очереди. */
        tx_pick_slot_for_peer(0, (u8)r13, (u8)ctx->qid);
    uc_mac_cmd(1u << 29);
}

void tx_sta_flow_loop(struct tx_ctx_s *a)   /* 6.2 asm 0x939e88 */
{
    struct tx_ctx_s *r14 = a;
    u32 sp[2];
    memset0_words_uc(sp, 8);
    u32 r15 = 0;

    for (;;) {
        u32 r0 = txrx_state2;
        if ((r0 & 0x140) != 0x100)   /* bic -0x141; cmp 0x100 */
            break;                    /* → L_939fd8 */

        /* L_939e9e */
        if (r0 & 0xe00) {
            txrx_state2 = r0 & ~(1u << 8);
            break;
        }
        if (r0 & 0x1f)
            goto check_state_bits;
        if (r0 & (1u << 7))
            goto bf_fdbk_step;

        /* L_939eb2 */
        rx_program_mac_and_wait(tx_ctx_pool.cur);
        if (r15 != 0) {
            /* L_939ec2 */
            u32 v = rs_state[r14->sta].active;
            if (v != 0)
                rate_search_pick_tx_params(r14, 0);
            else   /* L_939fa4 */
                bit_hist_push((u32)sp, bf_ctrl.ctrl_code_rx, 0,
                               bf_ctrl.stat_bit);
            tx_resp_sent = 1;   /* L_939fb6 */
        }
        r15 = 0;                     /* L_939fc0 */
    check_state_bits:   /* L_939fc2 */
        if (txrx_state2 & 0x1f)
            goto state_bits_set;
        continue;

    bf_fdbk_step:   /* L_939ef0 */
        {
            u32 v = rs_state[r14->sta].active;
            if (v == 0) {
                /* L_939f0c */
                u32 cfg = txrx_cfg_flags;
                u32 b = (cfg & (1u << 9)) ? bf_ctrl.ctrl_code_rx_alt
                                          : bf_ctrl.ctrl_code_rx;
                if (bit_hist_push((u32)sp, b, 1, bf_ctrl.stat_bit) == 1) {
                    if (bf_ctrl.triggers & (1u << 3))
                        VOL(link_stat[r14->sta].bf_reasons) |= (1u << 3);
                } else {
                    /* L_939f32 */
                    tx_mtp_queue_gate(0);
                    txrx_state2 &= ~(1u << 7);
                    r15 = 0;
                    goto check_state_bits;
                }
            } else {
                /* L_939f58 */
                if (rate_search_pick_tx_params(r14, 1) != 2)
                    goto bf_gate_off;
                if (bf_ctrl.triggers & (1u << 1))
                    VOL(link_stat[r14->sta].bf_reasons) |= (1u << 1);
            }
            tx_cca_check_and_send(r14, 1, 1, 0);   /* L_939f70 */
        }
        continue;

    bf_gate_off:   /* L_939f32 */
        tx_mtp_queue_gate(0);
        txrx_state2 &= ~(1u << 7);
        r15 = 0;
        goto check_state_bits;

    state_bits_set:   /* L_93a018 */
        {
            u32 v = rs_state[r14->sta].active;
            if (v != 0 && rate_search_per_check(r14) == 2 &&
                (bf_ctrl.triggers & 1)) {
                /* L_939f90 */
                VOL(link_stat[r14->sta].bf_reasons) |= 1;
                tx_cca_check_and_send(r14, 1, 1, 0);
                continue;
            }
            /* L_93a04a */
            uc_mac_cmd(2 | (1u << 25));
            if (sxd_hal_wait_slot2_busy2(busy_wait_slots) != 0) {
                rx_flow_run();
                r15 = 1;
                tx_rx_flow_ran = 1;
            } else {
                mac_prepare_txrx_window(r14, 2);
                ba_stats.no_busy_cnt += 1;
            }
        }
        continue;
    }

    /* L_939fd8 */
    if (VOL(link_stat[r14->sta].bf_reasons) != 0 ||
        (rx_mode_flags & (1u << 1))) {
        if (txr.awaiting == 0)
            tx_cca_check_and_send(r14, 1, 1, 0);
    }
    /* L_93a012: return */
}

u32 tx_sta_wait_slot_and_tx(struct tx_ctx_s *a, u32 b)   /* 6.2 asm 0x93a5fc */
{
    u32 sta = a->sta;
    u32 r0 = txrx_state2;   /* [gp,0xd0] */
    if ((r0 & 0x1f) == 0) {      /* bmsk 0x4 */
        txrx_state2 = r0 & ~(1u << 17);   /* bclr 0x11 */
        return 1;
    }
    UC_STAMP_T0(STAMP_TXOP_WAIT, t_w0);
    u32 got = sxd_hal_wait_slot2_busy2(resp_wait_slots);   /* [gp,-0x20] */
    UC_STAMP_T0(STAMP_TXOP_WAIT, t_w1);
    if (got == 0) {
        UC_STAMP(STAMP_TXOP_WAIT, t_w1 - t_w0, txrx_state2 & 0xffff);
        /* L_93a6bc */
        r0 = txrx_state2;
        r0 &= ~(1u << 8);
        txrx_state2 = r0;
        if (r0 & (1u << 2)) {                       /* RTS, ответа нет (CTSTimeout) — TXOP не получен */
            tx_pick_slot_for_peer(1, *(u8 *)&a->sta, *(u8 *)&a->qid);
            VOL(link_stat[sta].cts_fail) += 1;
            return 2;
        }
        if (a->flags & (1u << 1)) {
            mac_select_rf_module_cmd31(0, 0);
            mac_q_tx_ppdu(a, 2);
        }
        return 1;
    }
    rx_flow_run();
    UC_STAMP(STAMP_TXOP_WAIT, (t_w1 - t_w0) | 1u << 31, (txrx_state2 & 0xffff) | mac_rx_rep1() << 16);
    UC_STAMP(STAMP_TXOP_WAIT, mac_rx_rep2(), mac_rx_rep3());
    UC_STAMP(STAMP_TXOP_WAIT, mac_rx_misc(), mac_bap_if());
    r0 = txrx_state2;
    if (r0 & (1u << 7)) {
        /* L_93a648 */
        u32 r1 = r0 & ~(1u << 8);
        txrx_state2 = r1;
        if (r1 & (1u << 2)) {                       /* RTS, принят не DMG CTS — передача RTS не удалась (10.3.2.9) */
            tx_pick_slot_for_peer(1, *(u8 *)&a->sta, *(u8 *)&a->qid);
            VOL(link_stat[sta].cts_fail) += 1;
            return 2;
        }
        if (r0 & 0x5) {   /* bic -0x6 = &0x5 */
            VOL(link_stat[sta].cts_fail) = 0;
            tx_pick_slot_for_peer(0, *(u8 *)&a->sta, *(u8 *)&a->qid);
            mac_mon_report.rx_dts += 1;  
        }
        return 1;
    }
    /* bit7 сброшен — обычная передача */
    VOL(link_stat[sta].cts_fail) = 0;
    *(u8 *)b = 1;
    mac_mon_report.rx_cts += 1;                      /* ldw_s/extw_s/stw_s [0x8010b0,0x30] */
    return 0;
}

/* Keep-alive: RTS → CTS → кадр из очереди станции → ACK (6.2 asm 0x939100).
 * СРОК: команда передачи данных 0x19000001 до SIFS (3 мкс, допуск −0/+0.49 мкс) от конца
 * принятого CTS (802.11-2020 10.3.2.9, 10.23.2.8). Путь: выход из ожидания r42.rx_frame
 * (itx_wait_cts_b) → rx_ppdu_is_cts (ждёт r42.ppdu_report, 0x32, 0x2011000, r37) →
 * mac_program_tx_vector(1) → tx_submit_frame (0x1b/0x16/0x17, r43, r45) → 0x20000400 →
 * gp0_timer_arm_usec(0xc) → 0x2008000 → 0x19000001: ~208 инструкций + задержки ppdu_report и MTP
 * (vendor ~218). Запас: десятки инструкций (не измерен; ~300 тактов пути из 495). Срыв: данные
 * позже SIFS — сосед может занять среду; NAV из Duration RTS (40 мкс в эфире, фиксирован)
 * может кончиться до ACK — keep-alive считается неудачным (ka_noack, рост CW).
 * Участок слот → CCA → RTS (0x19000001) ~78 инструкций — см. tx_cca_check_and_send.
 * Переход TX→RX после RTS/данных (событие 5 → rf_set_rx, ~12 инструкций) — запас большой. */
void internal_tx_keepalive_flow(u32 a)
{
    (void)a;
    u32 sp[2];
    if (itx_ka_rr_pick((u32)sp) == 0) {
        internal_tx_clear_pending(8);
        return;
    }
    u32 sta = sp[0];
    if (sta_tab[sta].qid_mask_q6 == 0) {
        internal_tx_clear_pending(sta);
        return;
    }
    struct tx_ctx_s *ctx = tx_ctx_alloc_next(1);
    sta = sp[0];
    VOL(link_stat[sta].ka_sent) += 1;
    FWSH(fwsh_diag, ka_cnt) += 1;
    FWSH(ll_ctx, pending_mask) = itx_ka_pending;           /* ld_s [gp,0x48] (s9 byte) */
    ctx->resp_ctx8 = 0;
    u32 v = sta_tab[sta].qid_mask_q6;
    ctx->qid = (30 - arc_norm(v));      /* norm + rsub 0x1e */
    gp0_timer_arm_usec(0x12);
    /* Duration RTS = 40 мкс (vendor), оставлено. По 802.11-2020 9.2.5.2 a) 1) —
     * TXTIME(кадр) + TXTIME(DMG CTS) + TXTIME(Ack) + 3·SIFS, с округлением вверх. Известно:
     * DMG CTS 20 Б на control PHY = 14,04 мкс (ответ на RTS в control PHY; окно GP0 18 мкс от конца
     * RTS вмещает SIFS + 14,04), 3·SIFS = 9 мкс. Кадр берёт MTP из очереди станции только после
     * CTS (tx_submit_frame), его длина и MCS здесь неизвестны; окно Ack GP0 12 мкс (ниже) не
     * вмещает Ack на control PHY (SIFS + 13,16), значит кадр и Ack — SC (Ack на MCS1 = 3,09 мкс).
     * Итого 40 мкс покрывают кадр до 13,87 мкс в эфире (≈ 540 Б на MCS1; QoS Null 30 Б — 3,38 мкс,
     * тогда по стандарту было бы 30 мкс). Считать по TXTIME можно, только узнав кадр до RTS
     * (поставить его в MTP раньше и прочитать длительность PPDU из r47, как bti_measure_frame_duration)
     * — это перестройка пути CTS → данные (СРОК выше), без стенда не делается.
     * исправлено: RTS пускается 0x18000000 — MAC вычитает из 0x15 ⌈TXTIME(RTS)⌉ (H-DUR18, ifs.h; стенд 2026-11-04:
     * 0x15 40 → в эфире 25), поэтому в 0x15 — 40 + ⌈TXTIME(RTS, control PHY)⌉ = 55. */
    uc_mac_cmd(0x15000000u | CLKK(KA_RTS_CMD));
    uc_mac_cmd(0x14000007);
    direct_tx_program_desc(0x10, 0x10);
    mac_program_tx_with_rate(0);
    while (!(mac_mtp_resp() & MAC_MTP_RESP_VALID))
        ;
    { u32 _r51 = mac_mtp_desc(); mtp_desc_lo = _r51 & 0xf; mtp_desc_hi = _r51 >> 4; }
    while (!(mac_mtp_perm() & MAC_MTP_PERM_VALID))
        ;
    direct_tx_send_after_delay(sta, 0xb, 0);
    u32 r0 = mac_sel_shadow & ~MAC_SEL_FIELD;
    mac_sel_shadow = r0 | (1u << 13) | (1u << 15);   /* st.as [gp,-0x11] */
    uc_mac_cmd(r0 | MAC_CMD_STATUS_SEL | MAC_SEL_PHY_SIGNALS);
    mac_select_all_sectors_and_wait();
    mac_cmd_29000001();
    if (mac_cca_ok()) {
        /* L_939242 */
        mac_program_tx_vector(5, sta_tab[sta].tx_sel, 0);
        uc_mac_cmd(0x19000001);
        uc_mac_cmd(0x18000000);
        mac_evt_enable_bit_sync_b(6);
        mac_set_rf_chain_state(1, sta_tab[sta].rx_sel);
        tx_busy_start_tsf = uc_read_tsf_lo();
        mac_evt_enable_bit_sync(5);
        u32 r = abif_dvs_rf_ctrl_shadow;                       /* ld_s [gp,0x178] */
        r &= ~(1u << 24);
        r &= ~(1u << 25);
        r |= rf_set_rx << 24;
        abif_dvs_rf_ctrl_shadow = r;                           /* st.as [gp,0x5e] */
        *(volatile u32 *)HW_ABIF_DVS_RF_CTRL = r;
        if (itx_wait_cts_b() != 0) {
            mac_program_tx_vector(1, sta_tab[sta].tx_sel, 1);
            tx_submit_frame(ctx, 1, 0, 0);
            uc_mac_cmd(0x20000400);
            gp0_timer_arm_usec(0xc);
            uc_mac_cmd(0x2008000);
            uc_mac_cmd(0x19000001);
            while (!(mac_mtp_perm() & MAC_MTP_PERM_VALID))
                ;
            uc_mac_cmd(0x18000000);             /* vendor: 0x18000400 в UPM-doze — PS вырезан */
            mac_evt_enable_bit_sync_b(6);
            mac_set_rf_chain_state(1, sta_tab[sta].rx_sel);
            itx_rr_b = sta;                      /* stb [gp,-0xe6] */
            mac_evt_enable_bit_sync(5);
            r = abif_dvs_rf_ctrl_shadow;
            r &= ~(1u << 24);
            r &= ~(1u << 25);
            r |= rf_set_rx << 24;
            abif_dvs_rf_ctrl_shadow = r;
            *(volatile u32 *)HW_ABIF_DVS_RF_CTRL = r;
            if (itx_wait_ack() != 0) {
                tx_pick_slot_for_peer(0, (u8)sta, 0x1f);
                internal_tx_clear_pending(sta);
                FWSH_AT(ll_ctx, traffic, sta) += 1;
                mac_mon_report.ka_pass += 1;
                VOL(link_stat[sta].ka_ok) += 1;
            } else {
                mac_mon_report.ka_fail += 1;
                VOL(link_stat[sta].ka_noack) += 1;
                tx_pick_slot_for_peer(1, (u8)sta, 0x1f);
            }
        } else {
            VOL(link_stat[sta].ka_fail) += 1;
            mac_mon_report.ka_fail += 1;
            tx_pick_slot_for_peer(1, (u8)sta, 0x1f);
        }
        uc_mac_cmd(1u << 29);
        u32 r0b = txrx_cfg_flags;
        u8 r13 = (r0b & (1u << 9)) ? bf_ctrl.ctrl_code_tx_alt : bf_ctrl.ctrl_code_tx;
        volatile struct link_stat_s *r1 = &link_stat[sta];
        if (r1->ka_fail >= r13) {                     /* ldb (беззнаковые), brlt */
            if (bf_ctrl.triggers & (1u << 4)) {
                r1->bf_reasons |= (1u << 5);
                r1->ka_fail = 0;
                r1->ka_cca_busy = 0;
            }
            FWSH(fwsh_diag, ka_fail_cnt) += 1;
            r1->ka_bf_trig += 1;
        }
        handle_bf_triggers(sta, 0);             /* r0 = [sp,0] = sta, r1 = 0 (0x939478) */
    } else {
        while (!(mac_mtp_perm() & MAC_MTP_PERM_VALID))
            ;
        uc_mac_cmd(0x29000002);
        VOL(link_stat[sta].ka_cca_busy) += 1;
    }
}

