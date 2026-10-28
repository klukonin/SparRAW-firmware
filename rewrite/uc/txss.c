// SPDX-License-Identifier: AGPL-3.0-or-later
/* TXSS/SLS/STA/RFC/RF/QH/DMA/TXOP uCode. */
#include "../include/types.h"
#include "../include/bitfield.h"
#include "ifs.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/sta_max.h"
#include "abft.h"
#include "../include/macq_desc.h"

static inline u32 ror32(u32 x, u32 n) { return (x >> n) | (x << (32 - n)); }


/* ---------------- RFC/RF ---------------- */

void rfc_clear_core_reg1(u32 a)
{
    hwd_rfc_write_core(a, 1, 0, 0);
}

void rf_store_last_module_index(void)
{
    bti_sweep_set = fwsh_n_sets - 1;
}

u32 rf_compute_tx_rx_sets(void)
{
    u32 r14 = 0, r13 = 0;
    u32 i = 0;
    for (i = 0; i < FWSH(fwsh_sets, n_sets); i++) {
        r14 |= FWSH_AT(fwsh_sets, set_tx_mask, i);
        r13 |= FWSH_AT(fwsh_sets, set_rf_mask, i);
    }
    if (r14 == 0) { uc_assert((u32)__builtin_return_address(0), 0x10b); }
    if (r13 == 0) { uc_assert((u32)__builtin_return_address(0), 0x10c); }
    u32 r2 = 0;
    rf_set_tx = 0;
    rf_set_rx = 0;
    if (r14 & 0xcc) { r2 = 1; rf_set_tx = 1; }
    if (r14 & 0x33) { r2 |= 2; rf_set_tx = r2; }   /* bic -0x34 = &0x33 */
    u32 r0;
    if (r13 & 0xcc) { r0 = 1; rf_set_rx = 1; }
    else r0 = 0;
    if (r13 & 0x33) { r0 |= 2; rf_set_rx = r0; }   /* bic -0x34 = &0x33 */
    return r0;   /* vendor возвращает результат r13 (r0), не r14 */
}

void rf_set_txrx_sets_save(u32 a, u32 b, u32 *o0, u32 *o1)   /* 6.2 asm 0x92a314 */
{
    if (o0 != 0)
        *o0 = *(volatile u32 *)HW_ABIF_DVS_RF_CTRL; /* ld.as [0x889800-0xde*4] */
    if (o1 != 0)
        *o1 = *(volatile u32 *)HW_RFC_RFCA_CFG; /* ld.as [0x889000+0x55*4] */
    if (b & 0xffffff00)
        uc_assert((u32)__builtin_return_address(0), 0xac);
    *(volatile u32 *)HW_ABIF_DVS_RF_CTRL = (b << 16) | (*(volatile u32 *)HW_ABIF_DVS_RF_CTRL & 0xff00ffff);
    if (a & ~0xfu)
        uc_assert((u32)__builtin_return_address(0), 0xad);
    if (a & ~0xfu)
        uc_assert((u32)__builtin_return_address(0), 0xae);
    u32 r4 = *(volatile u32 *)HW_RFC_RFCA_CFG;
    r4 &= ~0xfu;
    r4 |= a;
    r4 &= ~0xf0u;
    r4 |= a << 4;
    *(volatile u32 *)HW_RFC_RFCA_CFG = r4;
}

void rf_set_normal_mode(u32 a)
{
    /* 6.2 asm 0x92abe4. */
    if (a == 1) {
        hwd_phy_uses_rgf_884000(0);
        hwd_phy_uses_rgf_883000(0);
        mac_core_write_3d_0200();
        mac_core_write_3e_then_3d_0007();
        abif_set_enable_bit(1);
    } else {
        abif_set_enable_bit(0);                 /* r0 = 0 из delay-слота brne.d */
        MMIO32(HW_ABIF_RX_TABLE_CTRL) |= 0x7e000;
        u32 r0, r1;
        if (rf_normal_abif_en != 0) {
            r1 = rf_normal_abif_field;
            r0 = 1;
        } else {
            r0 = 0;
            r1 = 0;
        }
        abif_set_88a204_field(r0, r1);
        u32 m = (rf_normal_phy_mode == 0) ? 0 : 1;
        hwd_phy_set_mode_uc(m);
        mac_core_write_3d_0200();
        mac_core_write_3e_then_3d_0007();
        hwd_phy_uses_rgf_884000(1);
        hwd_phy_uses_rgf_883000(1);
    }
}

/* СРОК: выбор селектора r47 (команда 0x1d03…) → чтение MAC_RFC_ACCESS_BUSY не раньше чем через 3 такта
 * (аппаратный: «через 3 такта результат в r40/r41/r47», MAC-COMMANDS §7.3). Путь: хвост
 * uc_mac_cmd (st.ab + bclr) + 2×nop — ровно как vendor; запас: нет/единицы тактов. Короче —
 * опрос читает старое r47, проходит мимо «mailbox занят», и команда 0x41 (сектор/AWV) теряется.
 * То же в rf_write_sector_awv, rfc_issue_cmd_10, rfc_issue_cmd_20_uc (и brp_write_reg_pair). */
void rf_select_sector_cmd41(u32 a, u32 b)
{
    /* 6.2 asm 0x92f934: выбор RF-сектора — две mailbox-последовательности
     * (arm → команда 0x41 → commit), каждая с poll aux47[17]. */
    u32 r1 = mac_sel_shadow & 0xfff0ffff;
    mac_sel_shadow = r1 | 0x30000;
    uc_mac_cmd(r1 | 0x1d030000);
    arc_nops_nop(2);
    while (mac_txctl_sel() & MAC_RFC_ACCESS_BUSY)
        ;
    uc_mac_cmd(a | 0x41000000 | (b << 8) | (1u << 5));
    u32 r0 = mac_sel_shadow & 0xfff0ffff;
    mac_sel_shadow = r0 | 0x30000;
    uc_mac_cmd(r0 | 0x1d030000);
    arc_nops_nop(2);
    while (mac_txctl_sel() & MAC_RFC_ACCESS_BUSY)
        ;
}

void rf_write_sector_awv(u32 a, u32 b)
{
    /* 6.2 asm 0x92fa6c: запись AWV сектора — два mailbox (low/high b),
     * затем arm → команда 0x41 → commit. */
    uc_mac_cmd((u16)b | 0x42000000);
    uc_mac_cmd((b >> 16) | 0x43000000);
    u32 r1 = mac_sel_shadow & 0xfff0ffff;
    mac_sel_shadow = r1 | 0x30000;
    uc_mac_cmd(r1 | 0x1d030000);
    arc_nops_nop(2);
    while (mac_txctl_sel() & MAC_RFC_ACCESS_BUSY)
        ;
    uc_mac_cmd((a << 8) | rf_chain_cfg | 0x41000000);
    u32 r0 = mac_sel_shadow & 0xfff0ffff;
    mac_sel_shadow = r0 | 0x30000;
    uc_mac_cmd(r0 | 0x1d030000);
    arc_nops_nop(2);
    while (mac_txctl_sel() & MAC_RFC_ACCESS_BUSY)
        ;
}

void rf_power_seq_and_save(u32 a)
{
    /* 6.2 asm 0x93c888. */
    if (a != 0) {
        mac_set_mode_a000(a);
    } else {
        uc_mac_cmd(0x3d000004);
        arc_nops(3);
        uc_mac_cmd(0x41 << 19);
    }
    hw_power_sequence_rf(a, (u32)&rf_power_seq_mask);
    abif_dvs_rf_ctrl_shadow = *(volatile u32 *)HW_ABIF_DVS_RF_CTRL; /* ld [0x889488]; st.as [gp,0x5e] */
}

void rf_update_active_antenna(u32 a, u32 b)
{
    /* 6.2 asm 0x9238cc. rf_modules. */
    u32 count = rf_modules.count;
    if (count >= 2) {
        u8 r2 = rf_modules.x4;
        if (r2 != 0) {
            u32 r0 = uc_role_ap;
            rf_modules.mask = r2;
            if (r0 == 0 || FWSH(fwsh_sets, abft_sectors) < 2) {   /* 0x9238f0: breq r0,0 / brge ≥2 → выход */
                rf_modules.mask = 1;
                rf_modules.cur_mask = 1;
            }
            return;
        }
    }
    u8 r13 = rf_modules.cur;
    if (count == 1) {
        rf_modules.mask = r13;
        rf_modules.cur_mask = r13;
        return;
    }
    /* count==0 (div-by-zero, инвариант) или count>=2 с r2==0 */
    u32 q = uc_divmod_unsigned(b, count);
    u32 q2 = uc_divmod_unsigned(a, (u16)q);
    u32 n = (u16)(q2 + 1);
    if (n >= 2)
        for (n--; n; n--)
            r13 &= r13 - 1;      /* сброс младших установленных бит */
    r13 &= ~(r13 - 1);           /* изоляция младшего установленного бита */
    rf_modules.mask = r13;
    rf_modules.cur_mask = r13;
}

/* ---------------- STA/PEER ---------------- */

/* Индекс пира с данным qid среди станций maint_sta_mask, 0xff — нет. */
u32 sta_find_by_byte(struct fsched_peer_ctx *p, u32 qid)
{
    for (u32 i = 0; i < SPARRAW_MAX_STA; i++) {
        if ((maint_sta_mask & (1u << i)) && p->ent[i].qid == qid)   /* brne r1,r3 — r1 целиком */
            return i;
    }
    return 0xff;
}

/* 1 — пир с qid активен и сейчас в слоте. */
u32 peer_lookup_or_ff(struct fsched_peer_ctx *p, u32 qid)
{
    u32 r = sta_find_by_byte(p, qid);           /* 0x92be68: r1 проходит насквозь */
    if (r == 0xff)
        return 0;
    if (!(p->active_mask & (1u << (r & 0x1f))))
        return 0;
    return (r == p->cur_idx) ? 1 : 0;
}

u32 peer_lookup_if_fixed_sched(u32 a0)
{
    if (dti_qset_mode == 0)
        return 0;
    if (a0 == fsched_peer_id)                 /* ld_s [gp,-0xc0] — байтовое смещение */
        return 0;
    if (a0 >= 0x18)
        return 0;
    if (fixed_sched_is_engaged() == 0)
        return 0;
    return peer_lookup_or_ff(&fsched_peers, a0);
}

void sta_apply_rx_sector_and_mcs(u32 a)
{
    struct sta_entry *e = &sta_tab[a];
    u32 v = rf_chain_cfg;
    v = v | (1u << 5) | (e->fixed_sector << 8);
    e->rx_sel = v;
    rate_search_apply_mcs(e->fixed_mcs, a);   /* r1 = a (mov_s r1,r0) */
}

void sta_set_rx_sector(u32 a, u32 b)
{
    struct sta_entry *e = &sta_tab[a];
    u32 v = rf_chain_cfg | (1u << 5);
    if (bf_ctrl.rx_sector_force == 0) {
        e->rx_sel = v | (b << 8);
        bf_ctrl.rx_sector = (u8)b;
    } else {
        u32 s = bf_ctrl.rx_sector;
        e->rx_sel = v | (s << 8);
    }
    bf_res.rx_sector = bf_ctrl.rx_sector;
}

void sta_set_tx_sector(u32 a, u32 b, u32 c, u32 d)
{
    struct sta_entry *e = &sta_tab[a];
    u32 v = rf_chain_cfg | 0x30;
    u32 sec;
    if (bf_ctrl.tx_sector_force == 0) {
        e->tx_sel = v | (b << 8);
        bf_ctrl.tx_sector = (u8)b;
        sec = (u8)b;
    } else {
        sec = bf_ctrl.tx_sector;
        e->tx_sel = v | (sec << 8);
    }
    rf_update_active_antenna(sec, 0x40);        /* vendor bl.d L_9238cc (r1 = 0x40) */
    bf_res.tx_sector = bf_ctrl.tx_sector;
    if (d == 1) {
        *(volatile u8 *)((u32)fwsh_sls_rank_b1 + a * 0x3c) = (u8)b;
        *(volatile u8 *)((u32)fwsh_sls_rank_b1 + a * 0x3c + 1) = (u8)c;
    }
}

u32 sta_queue_class(u32 a, u32 b)
{
    struct sta_entry *e = &sta_tab[a];
    u32 mask = 1u << b;
    u32 r13 = e->qid_mask_q4;
    if (!(mask & r13)) {
        if (mask & e->qid_mask_q5)
            return 1;
        if (mask & e->qid_mask_q6)
            return 2;
        return 3;
    }
    return 0;
}

u32 sta_get_sweep_byte(u32 a, u32 out)
{
    /* 6.2 asm 0x93dad0. */
    u8 r0 = qid_cfg[a].cid;
    *(u32 *)out = (a != fsched_peer_id) ? 1 : 0;
    return r0;
}

void sta_reset_link_state(u32 a, u32 b, u32 c)
{
    /* 6.2 asm 0x921900: memset 3 байта @0x8005fc; при b!=0 сброс
     * *(u8*)(0x857e49+a*20); при c!=0 проверка sta_link → rs_abort. */
    memset0_words_uc(txss_retry_cnt, 3);
    if (b != 0 && a < SPARRAW_MAX_STA)      /* у пира 8 (A-BFT) записи link_stat нет */
        VOL(link_stat[a].bf_reasons) = 0;
    if (c != 0) {
        if (sta_link_byte_by_index(a) == 0)
            rs_abort(a);
    }
}

void sta_apply_bf_result(u32 a, u32 b)
{
    /* 6.2 asm 0x921ca8. */
    u32 flag = (b >= SPARRAW_MAX_STA || (VOL(link_stat[b].bf_reasons) & 0x40) == 0) ? 1 : 0; /* bic -0x41 = & 0x40; пир 8 — без link_stat */
    sta_reset_link_state(b, 1, flag);
    if (a == 1) {
        bf_tx_sector = bf_res.rx_sector;
        bf_rx_sector = bf_res.tx_sector;
        if (sta_tab[b].fixed_link != 0 || flag == 0)
            return;
        u32 r1 = sta_link_byte_by_index(b);
        rs_start(b, r1);
        if (!rs_is_sta_enabled(b))
            return;
        bf_resume_sta_tx(3, b);
        ucode_pm_set_busy_flag(1);
    } else {
        if (b == SPARRAW_PEER_UNKNOWN)
            return;
        u32 r2 = rf_chain_cfg;
        struct sta_entry *r14 = &sta_tab[b];
        r14->rx_sel = (r2 | (1u << 5)) | (bf_tx_sector << 8);
        r14->tx_sel = (r2 | 0x30) | (bf_rx_sector << 8);
    }
}

/* ---------------- SLS/TXSS ---------------- */

void sls_clear_rx_state(void)
{
    memset0_words_uc((void *)&sls_rx, 0x18);
}



   /* r10=1,r11=1 */

void txss_set_sweep_param(u32 s, const struct ss_cfg_s *p, u32 a2, u32 a3, u32 a4, u32 a5)
{
    /* 6.2 asm 0x9357ec. */
    ss_plan_cdown = a4;
    ss_plan_sector = 0;
    ss_plan_set_base = *(u8 *)(fwsh_set_ranges + a5 * 2);   /* [0x8577b0] — указатель */
    ss_plan_passes_left = a2;
    const struct ss_timing *t = (const struct ss_timing *)s;
    ss_plan_tx_dur = t->gap + t->total;          /* порядок слагаемых — как у vendor (ldw [r13,4] первым) */
    if (a3 != 0)
        txss_order_known_sectors_first((u32)p->order, (u32)ss_order_cur);
    else
        memcpy_uc(ss_order_cur, p->order, p->n_frames < 0x40 ? p->n_frames : 0x40);   /* ss_order_cur[64]: n_frames — байт от хоста/платы */
    if (p->n_frames < 0x40)
        ss_order_cur[p->n_frames] = 0xff;
    ss_plan_idx = 0;
    ss_plan_next_sector(s, 0);
}

void txss_rank_best_sector(void)
{
    /* 6.2 asm 0x935938. */
    /* Новое измерение (sls_cand) заменяет худшую запись топа, если не хуже её; затем один проход
     * пузырька поднимает её по rank[], best = top[rank[4]]. */
    struct sector_rec *worst = &sls.top[sls.rank[0]];
    if (sls_cand.snr_lin < worst->snr_lin)
        return;
    memcpy_uc(worst, &sls_cand, sizeof(*worst));
    u32 r3 = 0, r0 = 1;
    while (r3 < 4 && r0 == 1) {
        u32 r14 = sls.rank[r3], r1 = sls.rank[r3 + 1];
        u32 m0 = sls.top[r14].snr_lin;
        u32 m1 = sls.top[r1].snr_lin;
        if (m0 < m1) {
            r0 = 0;
        } else {
            sls.rank[r3] = r1;
            sls.rank[r3 + 1] = r14;
            r0 = 1;
        }
        r3++;
    }
    memcpy_uc(&sls.best, &sls.top[sls.rank[4]], sizeof(sls.best));
}

void txss_order_known_sectors_first(u32 dst, u32 src)
{
    /* 6.2 asm 0x938088. norm→bitpos; маски 64-бит. */
    u32 bitmap = maint_sta_mask;
    u32 out_idx = 0;
    u64 mask1 = 0, mask2 = 0;
    if (bitmap == 0) {
        memcpy_uc((void *)src, (void *)dst, 0x40);   /* vendor: r0=r17(a1), r1=r20(a0) */
        return;
    }
    while (bitmap != 0) {
        u32 n;
        __asm__ volatile("norm %0, %1" : "=r"(n) : "r"(bitmap));
        u32 bitpos = 30 - n;
        u32 r0 = sta_tab[bitpos].tx_sel >> 8;
        u32 r16 = r0 & 0x7fff;
        u32 r19 = r0 & 0x3f;
        if (r16 >= 0x40)
            uc_assert((u32)__builtin_return_address(0), 0x5d);
        u64 *m = (r16 >= 0x40) ? &mask2 : &mask1;   /* vendor после assert — вторая маска */
        u64 shl = uc_shl64(1, 0, r19);
        if ((*m & shl) == 0) {
            *m |= shl;
            *(u8 *)(src + out_idx) = (u8)r16;
            out_idx = (out_idx + 1) & 0xff;
        }
        bitmap &= ~(1u << (bitpos & 31));
    }
    u32 r15 = 0;
    while (r15 < 0x40) {
        if (mask1 == 0 && mask2 == 0) {
            memcpy_uc((void *)(src + out_idx), (void *)(dst + r15), 0x40 - r15);
            return;
        }
        u32 r2 = *(u8 *)(dst + r15);
        u64 *m;
        if (r2 >= 0x40) {
            m = &mask2;
            r2 &= 0x3f;
        } else {
            m = &mask1;
        }
        u64 shl = uc_shl64(1, 0, r2);
        if ((*m & shl) != 0) {
            *m &= ~shl;
        } else {
            if (out_idx >= 0x40)
                uc_assert((u32)__builtin_return_address(0), 0x1463);
            *(u8 *)(src + out_idx) = *(u8 *)(dst + r15);
            out_idx = (out_idx + 1) & 0xff;
        }
        r15++;
    }
}

void txss_store_sector_ranking(u32 a, u32 b)
{
    /* 6.2 asm 0x93e210. Пересортировка 5×0xc записей по рангу. */
    u8 buf[0x3c];
    for (u32 i = 0; i < 5; i++) {
        u32 rank = sls.rank[4 - i];
        memcpy_uc(buf + i * 12, &sls.top[rank], sizeof(struct sector_rec));
    }
    for (u32 i = 0; i < 5; i++)
        sls.rank[i] = i;
    memcpy_uc(sls.top, buf, sizeof(sls.top));
    if (b == 0) {
        memcpy_uc((void *)fwsh_sls_rank[a], sls.top, sizeof(sls.top));
        sls_rank_valid_mask |= (1u << (a & 31));
    } else if (b == 1) {
        memcpy_uc((void *)fwsh_sls_rank_b1[a], sls.top, sizeof(sls.top));
    } else {
        uc_assert((u32)__builtin_return_address(0), 0x1f);
    }
}

/* СРОК (b = 1, RSS ответчика): первый кадр SSW RSS — через MBIFS (9 мкс, допуск −0/+0,49 мкс)
 * после конца ISS (802.11-2020 10.42.2.2, 10.3.2.3.10). Событие — r54.txss_end_ind или флаг
 * 0x8021e0 б1 (sls_rx_ssw_frame, последний кадр ISS) в txss_resp_wait_iss_end; действие —
 * команда 0x19…/0x18… ниже и 0x2d… в bcon_txss_sweep_step. Путь: ~150 инструкций приёма
 * последнего кадра + ~30 ожидания + здесь ~250 (txss_sweep_timing, txss_set_sweep_param с
 * копией 64 Б порядка секторов, ss_plan_next_sector — всё до пуска TX) + ожидания MAC_EVT1_BUSY2/MAC_MTP_PERM_VALID;
 * итого ~500–600 инструкций ≈ 4–5 мкс (vendor ~то же, порт 1:1); запас: десятки–сотни
 * инструкций до 9 мкс, без учёта задержки PHY RX-end → отчёт PPDU. Срыв: RSS позже MBIFS
 * (нарушение допуска), а при опоздании > ~15–20 мкс — инициатор не укладывает RSS в окно GP0
 * (BF-ENGINE §8.2) → NO_SS_RESP_FAILURE и повтор SLS.
 * СРОК (b = 5, ISS инициатора): проба CCA (0x29000001, mac_cca_ok) → пуск ISS; между ними
 * выбор сектора/таймингов уже сделан, CCA повторно проверяет bcon_txss_sweep_step перед TX —
 * запас большой. Опросы MAC_MTP_PERM_VALID здесь без ограничения времени. */
u32 txss_program_tx_frame(u32 a, u32 b, u32 c, u32 d, u32 e)
{
    /* 6.2 asm 0x93c2f8. */
    u32 r13 = a;
    u32 r16;
    if (uc_role_ap != 0 && (s32)(u8)fwsh_n_sets >= 2 && c != 0 &&
        (a == SPARRAW_PEER_UNKNOWN || (sta_tab[a].omni_rx_sel & 0x7fff00) == 0x7fff00))
        r16 = (u32)&ss_rfset;
    else
        r16 = (u32)&txss_ss[a];
    struct ss_cfg_s *ss = (struct ss_cfg_s *)r16;
    u32 sp4 = ss->x49;
    u8 r14 = sta_tab[a].peer_n_ant;
    u16 timing[3];
    txss_sweep_timing((u32)timing, ss->n_frames, r14);
    if (b == 1) {
        uc_mac_cmd(0x3e000000);
        uc_mac_cmd(0x37000020);
        uc_stats.tx_start = uc_stats.tx_start + 1;
        u32 t = abif_dvs_rf_ctrl_shadow;
        t &= ~(1u << 24);
        t &= ~(1u << 25);
        t |= rf_set_tx << 24;
        abif_dvs_rf_ctrl_shadow = t;
        *(volatile u32 *)HW_ABIF_DVS_RF_CTRL = t;
        u32 sv = (u8)((r14 - 1) + ss->n_frames * r14);
        txss_set_sweep_param((u32)timing, ss, r14, 0, sv, sp4);
        /* первый SSW RSS: до конца SSW с CDOWN 0 + MBIFS, вверх, буквально (9.3.1.15; SLS_SSW_DUR, abft.h) */
        uc_mac_cmd(SLS_SSW_DUR(ss_plan_tx_dur, SLS_MBIFS_US - timing[2], ss_plan_cdown, sls_ssw_dur_mul(timing[1])) |
                   (1u << 24) | (1u << 26) | (1u << 28));
        uc_mac_cmd(0x14000007);
    }
    direct_tx_program_cmd34(0x10, 0x16);
    mac_program_tx_common();
    if (b == 1) {
        mac_evt_enable_bit_sync_b(6);
        uc_mac_cmd(0x2008000);
        u32 v;
        if (txrx_state1 & 0x10) {
            u32 w = (mtp_desc_lo & 2) == 2 ? 1 : 0;
            v = (w << 6) | 0x19800830 | (mtp_desc_hi << 14);
        } else {
            v = 0x19000001;
        }
        uc_mac_cmd(v);
        while (!(mac_mtp_perm() & MAC_MTP_PERM_VALID))
            ;
        uc_mac_cmd((txrx_state1 & 0x10) ? (0x18 << 24) : 0x18001000);
    }
    if (e != 0)
        ((void (*)(void))e)();
    ssw_tpl_fc = 0x864;
    u32 r15fn;
    if (c != 0) {
        ssw_tpl_fb_sector = (sls.best.antenna << 6) | sls.best.sector;
        ssw_tpl_fb_snr = (u8)((sls.best.snr_db - 0x13) << 2);
        ssw_tpl_fb_b2 = 0;
    } else {
        u32 r4v = fwsh_total_sectors * r14 - 1;
        u16 r5w = (u16)r4v;
        u8 r1b = fwsh_n_rx_ant;
        ssw_tpl_fb_snr = 0;
        ssw_tpl_fb_sector = (u8)r4v;
        bf_set16((u32)&ssw_tpl_fb_w14, 1, 2, (r1b - 1) & 3);
        ssw_tpl_fb_b2 = 0;
        u16 w = ssw_tpl_fb_w14;
        ssw_tpl_fb_w14 = (w & ~1u) | ((r5w >> 8) & 1);
    }
    if (d == 0) {
        struct sta_entry *r0d = &sta_tab[a];
        ssw_tpl_ra[0] = r0d->mac[0];
        ssw_tpl_ra[1] = r0d->mac[1];
        ssw_tpl_ra[2] = r0d->mac[2];
        r15fn = VENDOR_CB(93b39c);   /* abft_send_ssw_feedback */
    } else if (d == 1) {
        r15fn = VENDOR_CB(93b404);   /* direct_tx_short_frame2_cb */
    } else if (d == 2) {
        r15fn = VENDOR_CB(93b3fc);   /* direct_tx_short_frame0_cb */
    } else {
        r15fn = 0;
    }
    if (b == 5) {                               /* cmp r17,5; bne_s L_93c608 */
        uc_mac_cmd(mac_evt_en_shadow | 0x27007e00);
        uc_mac_cmd(0x2004002);
        u32 sp8 = (u8)((r14 - 1) + ss->n_frames * r14);
        txss_set_sweep_param((u32)timing, ss, r14, 0, sp8, sp4);
        u32 g = mac_sel_shadow & 0xffff0fff;
        mac_sel_shadow = g | (1u << 13) | (1u << 15);
        uc_mac_cmd(g | 0x1d00a000);
        uc_wait_event_busy(MAC_EVT1_SLOT | MAC_EVT1_BUSY2, 0);
        mac_cmd_29000001();
        if (mac_cca_ok()) {
            /* L_93c5f8: aux40 bit24 (без poll), r13 без изменений. */
            uc_mac_cmd(0x29000002);
        } else {
            /* L_93c5de: poll aux45 bit31, затем b_s L_93c644 — возврат 0 без sweep. */
            while (!(mac_mtp_perm() & MAC_MTP_PERM_VALID))
                ;
            uc_mac_cmd(0x29000002);
            return 0;
        }
    }
    if (bf_sta[a].state >= 0x12)
        uc_assert((u32)__builtin_return_address(0), 0x103);
    r13 = bcon_txss_sweep_step((u32)&bcast_ctx, b, (u32)timing, r15fn, c, 1);
    if (r13 == 1)
        uc_mac_cmd(0x81 << 18);
    return r13;
}

u32 sls_rx_ssw_frame(void)
{
    /* 6.2 asm 0x928520. */
    struct ssw_parse sp;            /* rx_parse_ssw_field / phy_params_snapshot */
    rx_ppdu_report_seen = 1;
    u32 r2 = txrx_state2;
    if (txrx_state1 & 8) {
        if (bf_req.pending_mask == 0) {
            if (uc_role_ap == 0) {
                u8 byte = maint_sta_mask;
                if (byte != 0) {
                    u32 n;
                    __asm__ volatile("norm %0, %1" : "=r"(n) : "r"((u32)byte));
                    u32 bitpos = 30 - n;
                    struct sta_entry *base = &sta_tab[bitpos];
                    if (!(base->mac[0] == rx_buf_ta[0] &&
                          base->mac[1] == rx_buf_ta[1] &&
                          base->mac[2] == rx_buf_ta[2])) {
                        sls_ssw_ta_mismatch_cnt += 1;
                        return 1;
                    }
                }
            }
            sls_ssw_ta_ok_cnt += 1;
            sls.peer_mac[0] = rx_buf_ta[0];
            sls.peer_mac[1] = rx_buf_ta[1];
            sls.peer_mac[2] = rx_buf_ta[2];
        } else {
            if (rx_buf_ta[0] != sls.peer_mac[0] ||
                rx_buf_ta[1] != sls.peer_mac[1] ||
                rx_buf_ta[2] != sls.peer_mac[2])
                return 1;
            u32 idx = rxf.sta;
            if (bf_sta[idx].state == 0x11)
                return 1;
        }
    } else {
        uc_stats.ssw_drop_role += 1;
        txrx_state2 = r2 | (1u << 10);
        return 1;
    }
    u32 idx = rxf.sta;
    if (mac_rx_rep1() & MAC_RX_REP1_SS) {
        if (mac_rx_rep2() & MAC_RX_REP2_SSW) {
            if (mac_ifs_shadow != ifs.mbifs) {
                mac_ifs_shadow = ifs.mbifs;
                *(volatile u32 *)HW_MAC_IFS_SIFS = ifs.mbifs | 0x1730000;
                arc_sync();                     /* vendor 0x928630: sync */
                uc_mac_cmd(0x38000200);
            }
            if (rx_buf_ssw & 1)
                return 1;
            sls_rx.flags |= 1;
            phy_params_snapshot((u32)&sp.sector, (u32)&sp.antenna);
            if (!(mac_rx_misc() & MAC_RX_MISC_ZERO_CDOWN))
                return 1;
            /* СРОК: последний кадр ISS (r39.zero_cdown) → начало RSS через MBIFS (802.11-2020
             * 10.42.2.2). Здесь ~60 инструкций (rx_mac_prepare, mac_mode_switch_core_and_rf с
             * ожиданием PHY в mac_set_mode_a000) из ~500–600 всего пути — подробно у
             * txss_program_tx_frame. Запас: десятки–сотни инструкций. */
            rx_mac_prepare();
            mac_mode_switch_core_and_rf(sta_mode_word[VOL(rxf.sta)]);   /* [0x802288] перечитывается */
            sls_rx.flags |= 2;
            txss_rank_needed = 1;
            return 0;
        } else if (mac_rx_rep2() & MAC_RX_REP2_SSW_FB) {
            u32 r0;
            if (sls_rank_valid_mask & (1u << (idx & 31))) {
                /* СРОК: SSW-Feedback → SSW-Ack прямо из обработчика приёма, через MBIFS (9 мкс,
                 * 802.11-2020 10.42.2.2/10.42.2.5). До sls_send_ssw_ack ~130 инструкций (разбор,
                 * sta_set_tx_sector); при ≥ 2 RF-модулях и rf_modules.x4 = 0
                 * rf_update_active_antenna делает два программных деления (uc_divmod_unsigned,
                 * до ~200 тактов каждое). Vendor так же; запас: сотни инструкций (одномодульный
                 * RF), с делениями — десятки. Срыв — см. sls_send_ssw_ack. */
                rx_parse_ssw_field((u32)&sp.sector, (u32)&sp.antenna, (u32)&sp.snr);
                rx_funcs_record_level_8020f8_8020fc((s8)sp.snr);   /* ldb.x */
                sta_set_tx_sector(VOL(rxf.sta), sp.sector, sp.antenna, 1);
                sls_send_ssw_ack(VOL(rxf.sta), 1);   /* vendor перечитывает [r13] */
                r0 = 0;
            } else {
                r0 = 1;
            }
            sls_rx.flags |= 4;
            return r0;
        } else if (mac_rx_rep2() & MAC_RX_REP2_SSW_ACK) {
            rx_parse_ssw_field((u32)&sp.sector, (u32)&sp.antenna, (u32)&sp.snr);
            rx_funcs_record_level_8020f8_8020fc((s8)sp.snr);   /* ldb.x */
            sls_rx.flags |= 8;
            return 1;
        } else {
            uc_assert((u32)__builtin_return_address(0), 0x11);
            return 1;
        }
    } else {
        if (maint_sta_mask & (1u << (idx & 31))) {
            rx_handle_brp_frame();
            if (sls_rx.flags & (1u << 5))
                return 0;
        }
        return 1;
    }
}

/* СРОК: SSW-Ack ответчика — через MBIFS (9 мкс, допуск −0/+0,49 мкс) после конца принятого
 * SSW-Feedback (802.11-2020 10.42.2.2 «responder shall begin an SSW ack procedure an MBIFS
 * following the reception of an SSW-Feedback frame», 10.3.2.3.10). Событие — r42 (приём
 * SSW-Feedback, MAC_RX_REP2_SSW_FB); действие — 0x19…/0x18… и выдача кадра в FIFO
 * (rx_funcs_send_direct_frame → 0x33). Здесь ~300 инструкций до конца выдачи кадра (5 команд
 * TX-сектора/RF, сборка кадра, cmd34, tx_common, опрос MAC_MTP_PERM_VALID без ограничения), плюс путь приёма:
 * из txss_resp_flow — rx_flow_run + txss_resp_wait_fdbk, из sls_rx_ssw_frame — ~130 инструкций;
 * итого ≈ 450–600 ≈ 3,5–5 мкс (vendor ~то же, 107 инструкций у него против наших 103). Запас:
 * сотни инструкций до 9 мкс (задержка PHY RX-end → MAC_EVT1_PPDU_REPORT не учтена). Срыв: Ack позже MBIFS;
 * инициатор ждёт GP1 = MBIFS + TXTIME(SSW-Ack) + PIFS ≈ 35,3 мкс (tail.c, P12; vendor 0x2087 ≈ 50 мкс)
 * и повторяет SSW-Feedback (до 3 раз), затем
 * провал SLS. После TX: MAC_EVT1_TX_END → RF на приём ~15 инструкций (BRP после SLS — не раньше SIFS):
 * запас большой. */
void sls_send_ssw_ack(u32 a, u32 b)
{
    /* 6.2 asm 0x934424. */
    struct ssw_ack_frame buf;
    uc_mac_cmd(0x37000005);
    uc_mac_cmd(0x37000002);
    uc_mac_cmd(sta_tab[rxf.sta].tx_sel | 0x3f000000);
    uc_mac_cmd(0x3e000000);
    uc_mac_cmd(0x37000020);
    uc_stats.tx_start += 1;
    u32 r = (abif_dvs_rf_ctrl_shadow & ~(1u << 24) & ~(1u << 25)) | (rf_set_tx << 24);
    abif_dvs_rf_ctrl_shadow = r;
    *(volatile u32 *)HW_ABIF_DVS_RF_CTRL = r;
    sls_build_ssw_ack(&buf, a, b);
    direct_tx_program_cmd34(0x10, 0x18);
    {
        /* Duration SSW-Ack = Duration принятого SSW-Feedback − MBIFS − TXTIME(SSW-Ack), вверх (9.3.1.17;
         * SSWACK_DUR_SUB, abft.h), 0x15 буквально. vendor команды не давал — поле из буфера (не заполнялось). */
        u32 dfb = rx_buf_duration;
        uc_mac_cmd(((dfb > SSWACK_DUR_SUB) ? dfb - SSWACK_DUR_SUB : 0u) | 0x15000000);
        uc_mac_cmd(0x14000007);
    }
    mac_program_tx_common();
    uc_mac_cmd(0x2008000);
    u32 v;
    if (txrx_state1 & 0x10) {
        v = (((mtp_desc_lo & 2) == 2) ? 1u : 0u) << 6;
        v |= 0x19800830;
        v |= mtp_desc_hi << 14;
    } else {
        v = 0x19000001;
    }
    uc_mac_cmd(v);
    while (!(mac_mtp_perm() & MAC_MTP_PERM_VALID))
        ;
    uc_mac_cmd((txrx_state1 & 0x10) ? 0x18000000 : 0x18001000);
    rx_funcs_send_direct_frame((u32)&buf);
    mac_evt_enable_bit_sync_b(6);
    mac_set_rf_chain_state_with_sta_sector();
    while (!(mac_evt1() & MAC_EVT1_TX_END))
        ;
    mac_evt_enable_bit_sync_b(5);
    r = (abif_dvs_rf_ctrl_shadow & ~(1u << 24) & ~(1u << 25)) | (rf_set_rx << 24);
    abif_dvs_rf_ctrl_shadow = r;
    *(volatile u32 *)HW_ABIF_DVS_RF_CTRL = r;
}

/* no-store-merging: brp_req[0..3] — четыре stb, как у vendor (иначе gcc сливает [1..2] в stw). */
__attribute__((optimize("no-store-merging")))
void sls_build_ssw_ack(struct ssw_ack_frame *f, u32 idx, u32 flag)
{
    /* 6.2 asm 0x93b220. */
    f->fc = 0;
    bf_set32((u32)f, 2, 2, 1);
    bf_set32((u32)f, 4, 4, 6);
    bf_set32((u32)f, 8, 4, 0xa);
    u32 val;
    if (flag == 1) {
        /* лучший сектор из рейтинга fw (sector_rec), чтение не volatile — как у vendor */
        const struct sector_rec *r = (const struct sector_rec *)fwsh_sls_rank[idx];
        val = (r->antenna << 6) | r->sector;
    } else {
        val = (sls.best.antenna << 6) | sls.best.sector;
    }
    f->fb_sector = (u8)val;
    f->fb_b2 = 0;
    f->fb_snr = (u8)((sls.best.snr_db - 0x13) << 2);
    f->brp_req[0] = 0;
    f->brp_req[1] = 0;
    f->brp_req[2] = 0;
    f->brp_req[3] = 0;
    if (maint_sta_mask & (1u << (idx & 31)))
        f->brp_req[0] = (f->brp_req[0] & ~0x1f) | 0x10; /* [0,5)=0x10 */
    f->bf_maint = 0;
    struct sta_entry *src = &sta_tab[idx];
    f->ra[0] = src->mac[0];
    f->ra[1] = src->mac[1];
    f->ra[2] = src->mac[2];
}

/* ---------------- QH/DMA/TXOP ---------------- */

void qh_reset_desc_window(void)
{
    if (fsched_qh_mode != 0)
        return;
    MMIO32(HW_QDESC_WIN_CTRL) = 0;
}

u32 dmaq_hw_read_ptr(u32 q)
{
    u32 addr = ((q << 8) + 0x440c120) >> 3;
    return MMIO32(addr & ~3u);
}

void txop_clear_dma_ctl_bit1(void)
{
    MMIO32(HW_L2_OFFLOAD_TX_CTL) &= ~(1u << 1); /* 0x881800 + 0xc9*4 */
}

u32 txop_pick_ctrl_code_by_peer(struct tx_ctx_s *a)
{
    a->x1c = 0xc;
    u32 r1 = a->qid;
    u8 b = qid_cfg[r1].ctrl_b6;
    if (b != 0)
        a->x1c = 0xf;
    return (u32)a;   /* vendor возвращает r0=a */
}

u32 dma_read_881c28(void)
{
    u32 saved = arc_lr(ARC_STATUS32);
    arc_flag(saved & ~(1u << 1));
    u32 r = MMIO32(HW_DMA_FW_ICR_C24_ICR);
    arc_flag((saved & (1u << 1)) | arc_lr(ARC_STATUS32));
    return r;
}

void dma_write_881c28(u32 v)
{
    u32 saved = arc_lr(ARC_STATUS32);
    arc_flag(saved & ~(1u << 1));
    MMIO32(HW_DMA_FW_ICR_C24_ICR) = v;
    /* 0x928e18: vendor r1!=0 → sync; единственный вызов (0x9262b4) передаёт r1=1 */
    arc_sync();
    arc_flag((saved & (1u << 1)) | arc_lr(ARC_STATUS32));
}

void qh_pack_descriptor(u32 dst, u32 a, u32 count, u32 c, u32 flag, u32 loopcnt, u32 copycnt)
{
    /* 6.2 0x92420c: пакование дескриптора через DMA-окно. */
    u32 sp[4] = {0, 0, 0, 0};
    sp[1] = ror32((count & 7) | (ror32(sp[1], 4) & ~7u), 28) & ~3u;
    u32 r17 = 0;
    u32 cnt = count - 1;
    if (cnt < 6) {
        if (cnt <= 1) {
            sp[0] = ror32((a & 0x1f) | (ror32(c & 3, 2) & ~0x1fu), 28);
            r17 = 1;
        } else if (cnt >= 3) {
            sp[0] = flag;
        }
    }
    qh_wait_desc_window_ready();
    *(volatile u32 *)HW_QDESC_WIN_CMD = sp[1] << 16;
    u32 r13 = 0;
    u32 *d = (u32 *)dst;
    for (u32 r14 = loopcnt; r14 >= 1; r14--, r13++) {
        u32 r2;
        if (r17 == 0)
            r2 = r13 + flag;
        else
            r2 = ((r13 + flag) & 3) | (sp[0] & ~3u);
        *(volatile u32 *)HW_QDESC_WIN_ADDR = r2;
        sp[0] = r2;
        *(volatile u32 *)HW_QDESC_WIN_CTRL = (fsched_qh_mode != 0) ? 0x40000000 : 0xc0000000;
        arc_sync();
        while (*(volatile u32 *)HW_QDESC_WIN_CTRL & (1u << 29))
            ;
        for (u32 i = 0; i < copycnt; i++)
            *d++ = *(volatile u32 *)(HW_QDESC_WIN_DATA0 + i * 4);
    }
    qh_reset_desc_window();
}

void qh_write_desc_window(u32 data, u32 a1, u32 a2, u32 a3, u32 a4, u32 a5, u32 a6, u32 count)
{
    /* 6.2 asm 0x924348. DMA-окно дескриптора: запись count окон × (2|4) слова. */
    u32 packed_low = (a4 & 3) | ((a2 & 7) << 4);
    u32 base = ror32((a1 & 0x1f) | (ror32(a3 & 3, 2) & ~0x1fu), 28) & ~3u;
    qh_wait_desc_window_ready();
    *(volatile u32 *)HW_QDESC_WIN_CMD = a5 | ((u16)packed_low << 16) | (1u << 31);
    if (count < 1) {                            /* brlo r7,1 → L_924460: сброс окна */
        qh_reset_desc_window();
        return;
    }
    u32 r13 = 0;
    u32 *src = (u32 *)data;
    do {
        *(volatile u32 *)HW_QDESC_WIN_ADDR = ((r13 + a6) & 3) | base;
        u32 n = (a3 == 2) ? 2 : 4;
        for (u32 i = 0; i < n; i++)
            *(volatile u32 *)(HW_QDESC_WIN_DATA0 + i * 4) = *src++;
        *(volatile u32 *)HW_QDESC_WIN_CTRL = (fsched_qh_mode != 0) ? 0x40000000 : 0xc0000000;
        arc_sync();                             /* vendor: sync перед опросом */
        while (*(volatile u32 *)HW_QDESC_WIN_CTRL & (1u << 29))
            ;
        r13++;
        count--;
    } while (count >= 1);
    qh_reset_desc_window();
}

void qh_read_desc_window(u32 dst, u32 a1, u32 a2, u32 a3, u32 count)
{
    /* 6.2 asm 0x92449c. DMA-окно дескриптора: читает count окон × (2|4) слова. */
    u32 base = ror32((a1 & 0x1f) | (ror32(a3 & 3, 2) & ~0x1fu), 28) & ~3u;
    qh_wait_desc_window_ready();
    *(volatile u32 *)HW_QDESC_WIN_CMD = (a2 & 7) << 20;
    u32 r4 = count;
    u32 *d = (u32 *)dst;
    u32 r13 = 0;
    if (r4 < 1) {                               /* brlo r4,1 → L_924594: сброс окна */
        qh_reset_desc_window();
        return;
    }
    do {
        *(volatile u32 *)HW_QDESC_WIN_ADDR = base | (r13 & 3);
        *(volatile u32 *)HW_QDESC_WIN_CTRL = (fsched_qh_mode != 0) ? 0x40000000 : 0xc0000000;
        arc_sync();                             /* vendor: sync перед опросом */
        while (*(volatile u32 *)HW_QDESC_WIN_CTRL & (1u << 29))
            ;
        u32 n = (a3 == 2) ? 2 : 4;
        for (u32 i = 0; i < n; i++)
            *d++ = *(volatile u32 *)(HW_QDESC_WIN_DATA0 + i * 4);
        r13++;
        r4--;
    } while (r4 >= 1);
    qh_reset_desc_window();
}

/* tx_fifo_write_bytes — в mem.c. */

void txop_apply_limits_regs(u32 a0)
{
    /* 6.2 asm 0x936ba8: условный сдвиг + min + 2 регистра. */
    u32 cfg = short_txop_en;
    u32 a = txop_limit_us[1];
    if (cfg != 0 && a0 != 0)
        a >>= txop_limit_shift;
    txop_limit_cur = a;
    u32 b = txop_limit_us[0];
    u32 mn = (b < a) ? b : a;
    MMIO32(HW_MAC_TXOP_LIMIT_0) = (a << 16) | mn;
    MMIO32(HW_MAC_TXOP_LIMIT_1) = txop_limit_us[2] | (txop_limit_us[3] << 16);
}

u32 txop_await_cts_ppdu(struct tx_ctx_s *a, u32 b)
{
    /* 6.2 asm 0x9399a4. a (r0) не используется; b (r1) — буфер sp+4 вызывающего,
     * заполненный mtp_queue_release_mgmt: [b] = mcs, [b+8] = rx-конфиг. */
    (void)a;
    /* СРОК: проба CCA (0x29000001 + mac_cca_ok) → пуск TX (0x19000001 … итоговая 0x18…|б27|б28)
     * должен уложиться в окно, где проба ещё верна (aCCATime/aSlotTime = 5 мкс, 802.11-2020
     * 10.3.2.3, Table 20-30). Путь ~40 инструкций (mac_program_rx_window, 2 команды, чтение r43),
     * при dti_qset_mode ≠ 0 ещё fsched_slot_f3_positive и декремент счётчика RD — между 0x19 и
     * 0x18 (vendor так же); запас: десятки–сотни. Срыв: TX в уже занятую среду (коллизия
     * RTS/CTS-обмена TXOP). */
    u32 r0 = mac_sel_shadow & 0xffff0fff;
    mac_sel_shadow = r0 | (1u << 13) | (1u << 15);
    uc_mac_cmd(r0 | 0x1d00a000);
    mac_select_all_sectors_and_wait();
    mac_cmd_29000001();
    if (!mac_cca_ok()) {
        uc_mac_cmd(0x29000002);
        return 0;
    }
    const struct mtp_resp_info *ri = (const void *)b;
    mac_program_rx_window(5, ri->tx_sel, ri->mcs);
    uc_mac_cmd(0x2008000);
    uc_mac_cmd(0x19000001);
    u32 r13 = MAC_MTP_RESP_RD_SUPP_OF(mac_mtp_resp());
    if (dti_qset_mode != 0) {
        u32 r = fsched_slot_f3_positive(&fsched_peers);
        r13 &= r;
        if (r != 0)
            fixed_sched_manager_decrement_curr_sta_rd_counter(&fsched_peers);
    }
    uc_mac_cmd((r13 << 11) | (1u << 14) | (1u << 27) | (1u << 28));
    return 1;
}

/* ---- Локальные stub-ы глубоких подфункций ---- */
/* Ожидание сброса бита 29 (занято) регистра RFC 0x8890cc, до 0x30d40 опросов. */
static void rfc_wait_idle(void)
{
    for (u32 n = 0x30d40; n; n--)
        if (!(MMIO32(HW_RFC_CORE_CTRL) & (1u << 29)))
            break;
}

void hwd_rfc_write_core(u32 a, u32 b, u32 c, u32 d)
{
    /* 6.2 asm 0x92a3d8: запись (b: RF-ядро, c: адрес, d: данные) в RFC; assert не прерывает. */
    if ((s32)a >= 0x10)
        uc_assert((u32)__builtin_return_address(0), 0x1135);
    if ((s32)b >= 0x10)
        uc_assert((u32)__builtin_return_address(0), 0x45 << 6);
    if (c > 0x7fff)
        uc_assert((u32)__builtin_return_address(0), 0x1141);
    u32 r17 = (b & 0xf) << 4;
    if (MMIO32(HW_RFC_CORE_CTRL) & (1u << 29)) {
        uc_log_emit3(0x10, 0x100210c, b, c, d);
        rfc_wait_idle();
        if (MMIO32(HW_RFC_CORE_CTRL) & (1u << 29)) {
            uc_log_emit_snapshot(0, 0x1001ec0);
            uc_assert((u32)__builtin_return_address(0), 0x134a);
        }
    }
    if (r17 & 0xffff8000u)
        uc_assert((u32)__builtin_return_address(0), 172);
    MMIO32(HW_RFC_CORE_OPCODE) = (MMIO32(HW_RFC_CORE_OPCODE) & 0x8000ffffu) | (r17 << 16);
    (void)MMIO32(HW_RFC_CORE_ADDR);             /* vendor читает перед записью */
    MMIO32(HW_RFC_CORE_ADDR) = c;
    (void)MMIO32(HW_RFC_CORE_DATA);
    MMIO32(HW_RFC_CORE_DATA) = d;
    MMIO32(HW_RFC_CORE_CTRL) |= (1u << 30);
    rfc_wait_idle();
    if (MMIO32(HW_RFC_CORE_CTRL) & (1u << 29))
        uc_log_emit1(0, 0x1001e90, (u32)__builtin_return_address(0));
    if (MMIO32(HW_RFC_CORE_CTRL) & (1u << 29)) {
        uc_log_emit3(0x10, 0x1002164, b, c, d);
        uc_log_emit1(0x10, 0x10021bc, MMIO32(HW_RFC_MAC_GO_WHEN_BUSY_ERR_CNT) & 0x7fff);
        MMIO32(HW_RFC_CORE_CTRL) |= (1u << 30);
        rfc_wait_idle();
        if (MMIO32(HW_RFC_CORE_CTRL) & (1u << 29)) {
            uc_log_emit_snapshot(0, 0x1001ec0);
            uc_assert((u32)__builtin_return_address(0), 0x133d);
        }
    }
    rfc_write_cnt[a] += 1;
}
u32 hwd_rfc_read_rgf_uc(u32 a, u32 b)
{
    /* Чтение RFC RGF с ретраями (6.2 asm 0x92a1cc). a0=rf_rgf_addr (не используется),
     * a1=rfca_en. Эталон: 6.4/src/c/uc/hwd_rfc_read_rgf_uc.cpp, адреса — 6.2. */
    (void)a;
    s32 r3 = (u8)(MMIO32(HW_ABIF_DVS_RF_CTRL) >> 8); /* lsr_s 8 + extb_s */
    u32 r16 = 0xdeadbeef;
    if (((-r3) & r3) != r3) {               /* r3 не 0/степень двойки */
        uc_log_emit2(0, 0x1001f78, b, (u32)r3);
        uc_assert((u32)__builtin_return_address(0), 0x1513);               /* hard halt; fall-through при рекурсии */
    }
    u32 r14 = 5;                            /* ретраи */
    do {
        u32 r5 = MMIO32(HW_RFC_RESET_CTRL);
        MMIO32(HW_RFC_RESET_CTRL) = r5 | (1u << 6);
        u32 r6 = MMIO32(HW_RFC_RESET_CTRL);
        MMIO32(HW_RFC_RESET_CTRL) = r6 & ~(1u << 6);
        hwd_rfc_write_core(0, 4, b, 0);
        if (MMIO32(HW_RFC_READ_VALID) == 1) {
            r16 = MMIO32(HW_RFC_CORE_DATA);
            break;
        }
        hwd_abif_rfc_divider_restart_uc();
        r14 -= 1;
    } while (r14 >= 1);
    if (r16 == 0xdeadbeef)
        uc_log_emit2(0, 0x1001fac, 5, 0xdeadbeef);
    return r16;
}

/* ---------------- Дополнительные (небольшие/структурные) ---------------- */

u32 sector_mem_addr_of(u32 a)
{
    u32 r13 = (u8)(a + 0x60) << 6;
    r13 += r13 << 1;                     /* add1 r13,r13,r13 = ×3 */
    brp_write_reg_pair((r13 + 0x10060) >> 3 & ~3u, 0);
    brp_write_reg_pair((r13 + 0x10040) >> 3 & ~3u, 0);
    brp_write_reg_pair((r13 + 0x100a0) >> 3 & ~3u, 0);
    brp_write_reg_pair((r13 + 0x10080) >> 3 & ~3u, 0);
    return r13;
}

void qh_wait_desc_window_ready(void)
{
    if (fsched_qh_mode != 0)
        return;
    while (MMIO32(HW_QDESC_WIN_CTRL) & (1u << 31))
        ;
}

void qh_build_descriptor(u32 a, u32 b, struct qh_desc3_win *d)
{
    u32 r4 = a, r14 = b;
    u32 sp[0x30/4];
    qh_read_desc_window((u32)sp, r4, 2, 0, 1);  /* 0x92d448: bl qh__read_desc_window */
    u32 r0 = sp[1] & 0xfff;                     /* bmsk 0xb */
    d->start_b2 = 0;
    d->start = (d->start & 0xfffff000u) | r0;
    d->n_m1 = (u8)(r14 - 1);
    r0 = (r0 + r14 - 1) & 0xfff;
    d->end = (d->end & 0xfffff000u) | r0;
}
u32 qh_build_descriptor_b(u32 a)
{
    u32 sp[0x30/4];
    qh_read_desc_window((u32)sp, a, 2, 3, 1);   /* 0x92d410 */
    return sp[1] & 0xfff;
}
void qh_write_by_flags(u32 a, u32 b, u32 c, u32 d)
{
    u32 r14 = a, r15 = c, r17 = d;
    if ((b & 0x21) == 0x21)
        uc_assert((u32)__builtin_return_address(0), 0x1585);   /* затем b_s L_92d4b4 — продолжать */
    if (b & (1u << 4)) {
        u32 r16 = r15 + 0x40;            /* add3 r16,r15,0x8 = +0x40 */
        qh_build_descriptor(r14, r17, (struct qh_desc3_win *)r16);
        qh_write_desc_window(r16, r14, 2, 3, 0, 0, 0, 3);
    }
    if (b & (1u << 0))
        qh_write_desc_window(r15, r14, 2, 0, 0, 0, 0, 1);
    if (b & (1u << 1))
        qh_write_desc_window(r15 + 0x10, r14, 2, 0, 0, 0, 1, 1);
    if (b & (1u << 2))
        qh_write_desc_window(r15 + 0x20, r14, 2, 0, 0, 0, 2, 1);
    if (b & (1u << 3))
        qh_write_desc_window(r15 + 0x30, r14, 2, 0, 0, 0, 3, 1);
    if (b & (1u << 5)) {
        u32 sp[4];
        qh_pack_descriptor((u32)sp, r14, 2, 0, 0, 1, 4);
        /* sp — окно 0x20 («типизированное») по образцу окна набора (r15 = macq_qdesc.win).
         * Чтения окна r15 (lines +4, base +6, w2 +8, w3 +0xc) — на смещениях: через
         * const struct macq_desc * gcc меняет распределение регистров всей функции (codecmp). */
        struct macq_desc *spd = (struct macq_desc *)sp;
        spd->base = *(u16 *)((u8 *)r15 + 6);
        spd->lines = *(u16 *)((u8 *)r15 + 4);
        u32 r3 = sp[2] & 0xfffff000;
        r3 |= *(u32 *)((u8 *)r15 + 8) & 0xfff;
        sp[2] = r3;
        u32 r0 = (*(u32 *)((u8 *)r15 + 0xc) >> 4) & 0xfff;
        u32 r1 = ror32(sp[3], 4) & 0xfffff000;
        r0 |= r1;
        u32 r3b = ror32(r0, 28);
        sp[3] = r3b;
        u32 r1b = (*(u32 *)((u8 *)r15 + 0xc) >> 16) & 0xfff;
        u32 r2 = 0xfffff000 & ror32(r3b, 16);
        r1b |= r2;
        sp[3] = ror32(r1b, 16);
        qh_write_desc_window((u32)sp, r14, 2, 0, 0, 0, 0, 1);
    }
}
/* Одно слово дескриптора MAC-очереди через окно 0x886608..0x886618 (vendor 0x9245b0 /
 * 0x92462c). Командное слово 0x88660c: [31] запись, [22:20] поле A, [17:16] поле B,
 * [15:0] смещение — формат как у qh_read/write_desc_window; здесь A = 6, B = 0 (чтение)
 * или 1 (запись), смещение 0 / 8.
 * Отличие от vendor: он брал биты 18..19 и 23..31 (в т. ч. [31] у чтения) из
 * неинициализированной ячейки стека; соседние qh_*_desc_window пишут их нулями — здесь
 * тоже 0. На железе путь не проверен: единственный вызов — tx_bcast_flow, ветка не
 * сработала у станции ни под iperf, ни на ~100 ARP-широковещаниях (журнал на vendor,
 * 2026-10-16). */
static void macq_desc_window_go(u32 cmd, u32 addr)
{
    qh_wait_desc_window_ready();
    *(volatile u32 *)HW_QDESC_WIN_CMD = cmd;
    *(volatile u32 *)HW_QDESC_WIN_ADDR = addr;
}

static void macq_desc_window_run(void)
{
    *(volatile u32 *)HW_QDESC_WIN_CTRL = (fsched_qh_mode != 0) ? 0x40000000 : 0xc0000000;
    arc_sync();
    while (*(volatile u32 *)HW_QDESC_WIN_CTRL & (1u << 29))
        ;
}

u32 macq_desc_read_uc(u32 addr, u32 unused)
{
    (void)unused;
    macq_desc_window_go(6u << 20, addr);
    macq_desc_window_run();
    u32 v = *(volatile u32 *)HW_QDESC_WIN_DATA1;
    qh_reset_desc_window();
    return v;
}

void macq_desc_write_uc(u32 addr, u32 value)
{
    macq_desc_window_go((1u << 31) | (6u << 20) | (1u << 16) | 8, addr);
    *(volatile u32 *)HW_QDESC_WIN_DATA1 = value;
    macq_desc_window_run();
    qh_reset_desc_window();
}

u8 txq_fifo_ptp_idle_snapshot(void)
{
    MMIO32(HW_TXQ_FIFO_SM_A) = 0x80000000;
    MMIO32(HW_TXQ_FIFO_SM_C) = 0x80000000;
    MMIO32(HW_TXQ_FIFO_SM_B) = 0x80000000;
    MMIO32(HW_TXQ_PTP_SM) = 0x80000000;
    arc_sync();
    u32 r0 = MMIO32(HW_TXQ_FIFO_SM_A);
    u32 r3 = MMIO32(HW_TXQ_FIFO_SM_C);
    u32 r2 = MMIO32(HW_TXQ_PTP_SM);
    u32 r1 = MMIO32(HW_TXQ_FIFO_SM_B);
    u8 res = 0;
    if ((r0 & 3) == 0 && (r3 & 3) == 0 && (r2 & 7) == 0 && (r1 & 7) == 0)
        res = 1;
    return res;
}

/* СРОК (минимальная выдержка, аппаратный): импульс сброса RFC (HW_RFC_RESET_CTRL б4 = 0) —
 * rfc_txrx_set·160 тактов (≈ 0,97 мкс на единицу rfc_txrx_set), как vendor L_92a03c..L_92a054
 * (lp n × 2×nop_s, n = rfc_txrx_set·80; при n = 0 ARC600 исполняет тело один раз — 2 такта).
 * Минимум RFC не известен, поэтому длительность прежняя, но по часам ядра (uc_delay_clk). */
void rfc_restore_txrx_sets(void)
{
    u32 sp0, sp1;
    rf_set_txrx_sets_save(0xf, 0xff, &sp0, &sp1);
    MMIO32(HW_RFC_RESET_CTRL) &= ~(1u << 4);
    u32 n = (u32)rfc_txrx_set * 80;      /* vendor: ldb; asl 4; add2 (×5) */
    uc_delay_clk(n != 0 ? 2 * n : 2);    /* lp n × 2×nop_s; при n = 0 тело lp исполняется один раз */
    MMIO32(HW_RFC_RESET_CTRL) |= (1u << 4);
    MMIO32(HW_ABIF_DVS_RF_CTRL) = sp0;
    MMIO32(HW_RFC_RFCA_CFG) = sp1;
    hwd_rfc_write_core(0, 6, 0, 0);
    rfc_write_core_checked(0, 0x470, 0x10);
}
u32 rfc_read_core_result(u32 a0, u32 a1, u32 a2)
{
    /* Чтение результата RFC-ядра (6.2 asm 0x92a2a4). a0 не используется,
     * a1=данные (адрес RGF), a2=указатель на out-flag (1 = результат прочитан). */
    (void)a0;
    *(u32 *)a2 = 0;
    u32 r5 = MMIO32(HW_RFC_RESET_CTRL);
    MMIO32(HW_RFC_RESET_CTRL) = r5 | (1u << 6);
    u32 r4 = MMIO32(HW_RFC_RESET_CTRL);
    MMIO32(HW_RFC_RESET_CTRL) = r4 & ~(1u << 6);
    hwd_rfc_write_core(0, 4, a1, 0);
    u32 r15 = 0xdeadbeef;
    if (MMIO32(HW_RFC_READ_VALID) == 1) {
        r15 = MMIO32(HW_RFC_CORE_DATA);
        *(u32 *)a2 = 1;
    }
    return r15;
}
void rfc_write_core_checked(u32 a, u32 b, u32 c)
{
    (void)a;                                    /* vendor: r0 = r1 = 0, a не используется */
    if (b > 0x7fff)
        uc_assert((u32)__builtin_return_address(0), 0x1142);   /* и продолжает */
    hwd_rfc_write_core(0, 0, b, c);
}
void rfc_issue_cmd_10(u32 a)
{
    u32 r0 = mac_sel_shadow & 0xfff0ffff;
    mac_sel_shadow = r0 | 0x30000;
    uc_mac_cmd(r0 | 0x1d030000);
    arc_nops_nop(2);
    while (mac_txctl_sel() & MAC_RFC_ACCESS_BUSY)
        ;
    uc_mac_cmd(a | 0x41000010);
}
u32 rfc_issue_cmd_20_uc(u32 a, u32 b)
{
    u32 r13 = a, r14 = b;
    u32 r0 = mac_sel_shadow & 0xfff0ffff;
    mac_sel_shadow = r0 | 0x30000;
    uc_mac_cmd(r0 | 0x1d030000);
    arc_nops_nop(2);
    while (mac_txctl_sel() & MAC_RFC_ACCESS_BUSY)
        ;
    u32 r1 = r13 | 0x41000000 | (r14 << 8) | (1u << 5);
    uc_mac_cmd(r1);
    return r0 | 0x1d030000;                     /* r0 остаётся от первой команды */
}

u32 nav_read_hw_duration_flag(u32 *out) { /* 6.2 asm 0x9290d0. */
    u32 r2 = MMIO32(HW_DMA_DESCQ0_12D8);
    if (r2 & (1u << 4))
        *out = (r2 >> 16) & 0x1f;
    return (r2 >> 4) & 1;                       /* bmsk 0 */
}

void txss_sweep_timing(u32 out, u32 byte1, u32 byte2)
{
    /* 6.2 asm 0x939cc4: r0=out, r1=byte1, r2=byte2.
     * *(u16*)out = (byte2*0x11-0x11) + (base+r13)*byte1*byte2,
     * где base=*(0x801598), r13=(0x886d0c>>24). */
    u32 r13 = MMIO32(HW_MAC_IFS_RIFS_SBIFS) >> 24;
    u32 base = txss_timing_base;
    /* смена антенны пира: + (LBIFS − SBIFS) = frame + gap на каждую (ifs.h, P11); при byte2 = 0 (антенн у пира нет — не бывает) выражение из 6.2 */
    u32 r1 = (byte2 != 0 ? (byte2 - 1) * (base + r13) : byte2 * 0x11 - 0x11) + (base + r13) * byte1 * byte2;
    struct ss_timing *t = (struct ss_timing *)out;
    t->total = (u16)r1;
    t->frame = (u16)base;
    t->gap = (u16)r13;
}
u32 txss_sweep_duration_for_sta(u32 a)
{
    /* 6.2 asm 0x939cfc: длительность развёртки станции по числу кадров SS и антенн пира. */
    u32 buf[2];
    buf[0] = g801a9c;
    buf[1] = g801aa0;
    u32 byte1 = txss_ss[a].n_frames;
    u32 byte2 = sta_tab[a].peer_n_ant;
    txss_sweep_timing((u32)buf, byte1, byte2);
    return *(u16 *)buf;
}

