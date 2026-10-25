// SPDX-License-Identifier: AGPL-3.0-or-later
/* BRP (Beam Refinement Protocol) uCode. */
#include "../include/sta_max.h"
#include "../include/types.h"
#include "../include/bitfield.h"
#include "../include/hw.h"
#include "../include/arc.h"


/* Forward-декларации вызываемых функций (портированы в других .c). */

u8 rfca_get_rf_mask_uc(void)                 /* 6.2 asm 0x928c68 */
{
    return (u8)(MMIO32(HW_ABIF_DVS_RF_CTRL) >> 8); /* ld (32 бит), lsr 8, extb — беззнаковый байт */
}
void rf_utils_auto_fill_with_byte(u32 a, u32 b)  /* 6.2 asm 0x92f160 */
{
    u32 buf[4];
    buf[0] = rf_fill_template[0];
    buf[1] = rf_fill_template_1;
    buf[2] = rf_fill_template_2;
    buf[3] = rf_fill_template_3;
    *(u8 *)buf = (u8)a;
    rf_utils_auto_fill_uc((const struct rf_fill_info *)buf, b);         /* r1 сквозь (флаг assert при сбое) */
}

/* Локальные stub-ы глубоких подфункций (ещё не портированы). */
/* rfca_select_rf_uc — в tail.c (полный порт 0x928b8c). */
/* bf_rmw_word_unaligned_uc — в bf.c. */
/* bf_set_field_word — в bf.c. */
/* uc_log_emit2 — в bf.c (0x92d27c). */
/* rng_rand_below — в util.c (0x936de0). */

/* ------------------------------------------------------------------ */

/* Сохранение байта RF-модуля (0x9213c0). */
void brp_rf_store_module_byte(u32 a)
{
    brp_rf.module_byte[a] = brp_rf_module_byte;
}

/* Запись в PHY-регистр 0x884060 (0x929ee0). */
void brp_set_phy_884060(u32 a)
{
    MMIO32(HW_PHY_TX_BRP_884060) = a;
}

/* Разделение id на (id&0xf, id>>8) и выдача команды 0x20 (0x934dc8). */
u32 brp_split_id(u32 a)
{
    u32 r = rfc_issue_cmd_20_uc(a & 0xf, (a >> 8) & 0x7fff);
    rf_cur_sector_word = a;
    return r;
}

/* Установка TX-сектора (0x93e33c): r10=0xb, r11=0x5 (ширина 6). */
void brp_set_tx_sector_id(u32 ptr, u32 value)
{
    bf_set32_unaligned(ptr, 11, 6, value);
}

/* Установка битового поля 32 (0x93e3c0): r10=1, r11=7 (ширина 8). */

/* Установка битового поля 32 (0x93e3fc): r10=4, r11=4 (ширина 5). */

/* Проверка: peer-управляющий кадр (0x9232d4). */
u32 brp_is_peer_ctrl_frame(void)
{
    /* vendor перечитывает r38 и r37 перед каждой проверкой */
    u32 v = (arc_core_rd(38) & (1u << 11)) ? ((arc_core_rd(38) >> 8) & 7) : SPARRAW_PEER_UNKNOWN;
    if (brp_ctx.resp_sta != v)
        return 0;
    if (arc_core_rd(37) & (1u << 16)) return 1;
    if (arc_core_rd(37) & 1u) return 1;
    if (arc_core_rd(37) & (1u << 10)) return 1;
    if (arc_core_rd(37) & (1u << 24)) return 1;
    return 0;
}

/* Программирование MAC-последовательности (0x9259d0). */
void brp_program_mac_sequence_uc(void)
{
    uc_mac_cmd(0x3d020000);
    uc_mac_cmd(0x05000000);
    uc_mac_cmd(0x04000020);
    uc_mac_cmd(0x58000000);
}

/* Чтение RF-id (0x92ed5c). */
/* 6.2 asm 0x92ed5c: vendor возвращает r0 последнего вызова (rfca_select_rf_uc) —
 * значения нет, вызывающие его не используют. */
void brp_read_rf_id(u32 a)
{
    u8 mask = rfca_get_rf_mask_uc();
    rf_utils_auto_fill_with_byte(a, 1);
    brp_iterate_rf_mask(a);
    rfca_select_rf_uc(mask, 0);
}

/* Обновление индекса omni-сектора (0x923970). b = 1 — BRP этой станции прошёл (сектор
 * a + 0x60 натренирован), b = 0 — BRP провалился.
 *
 * Баг vendor (исправлен 2026-10-20): при b = 0 vendor выбирает СЛУЧАЙНО (бит 0 ГСЧ 0x880bc4,
 * rng__rand_below 0x936de0) между 0x7fff (ненаправленный omni) и a + 0x60 — направленным
 * omni-сектором, который в этой связи BRP не тренировал (там шаблон по умолчанию). На
 * 0x60 приёмник глух: CTS не приходит, BF по триггеру uc (только TXSS, BRP не повторяет)
 * не помогает — шторм BF_TRIGGER_MAX_CTS_FAILURE_IN_TXOP до разрыва связи (vendor тоже:
 * стенд 2026-10-20, журнал uc vendor 004742 — failure 3 → idx 96 → 113 триггеров → разрыв).
 * Доказательство: отладочные образы с принудительным провалом BRP — всегда 0x60: шторм 2/3
 * загрузок; всегда 0x7fff: 0/3, данные идут. Поэтому при провале — всегда 0x7fff.
 * Подробно (признаки в журналах, серии 2026-10-21 с WPA2) — docs/BF-ENGINE.md §10.3. */
void brp_update_omni_sector_idx(u32 a, u32 b)
{
    if (uc_role_ap != 0 && FWSH(fwsh_sets, abft_sectors) >= 2)
        return;
    struct sta_entry *r14 = &sta_tab[a];
    u32 r13;
    if (b == 0)
        r13 = 0x7fff;
    else
        r13 = a + 0x60;                   /* add3 = a + 0xc*8 */
    u32 cur = (r14->omni_rx_sel >> 8) & 0x7fff;
    if (r13 == cur)
        return;
    uc_log_emit2(0, 0x1000958, a, r13);
    bf_set32((u32)&r14->omni_rx_sel, 8, 15, r13 & 0x7fff);
}

/* Завершение RF-модуля (0x923208). */
void brp_rf_module_done(u32 a)
{
    u32 bit = (u32)(u8)(1u << a);
    u8 saved = 0;
    rfca_select_rf_uc(bit, (u32)&saved);
    u32 rem = brp_ctx.resp_rf_pending & ~bit;           /* bic.f — флаг Z переживает вызов хелпера */
    brp_ctx.resp_rf_pending = rem;                      /* [0x800880] */
    u32 r0v = (u8)(brp_ctx.resp_flags >> 1);           /* [0x800884] >> 1 */
    bf_set32((u32)&brp_ctx.resp_flags, 1, 8, r0v | bit);
    if (rem != 0) {                          /* beq_s по Z от bic.f */
        if (rf_modules.cur_mask & bit)
            rf_utils_auto_fill_with_byte(bit, 1);
    } else {
        brp_ctx.resp_flags &= ~1u;
    }
    (brp_stats.resp_rf_done)++;
    rfca_select_rf_uc(saved, 0);
}

/* Вставка в ранг-список (0x92e904). */
void brp_rank_insert(u32 a, u32 b, u32 c)
{
    if (!(FWSH(fwsh_sets, brp_cfg_mask)[a] & (1u << c)))
        return;
    u8 *slot = (u8 *)brp_rank[a];
    u32 count = brp_pick.count;
    u32 r13 = 0;
    while (r13 < count) {
        if ((s32)b < (s32)slot[r13 * 2])
            r13++;
        else
            break;
    }
    if (r13 >= count)                           /* brhs r13,r14,L_92e972 — без вставки */
        return;
    /* Сдвиг вниз на 1 позицию (entry[r13..count-2] -> entry[r13+1..count-1]). */
    for (u32 i = count - 1; i > r13; i--) {
        slot[i * 2] = slot[(i - 1) * 2];
        slot[i * 2 + 1] = slot[(i - 1) * 2 + 1];
    }
    slot[r13 * 2] = (u8)b;
    slot[r13 * 2 + 1] = (u8)c;
}

/* Выбор конфигурации сектора (0x93cc90). */
void brp_pick_sector_cfg(u32 a)
{
    u8 r1;
    if (brp_snr_cfg_enable != 0) {
        if (brp_rf.snr < brp_snr_cfg_thr[2]) {
            brp_pick.count = (brp_ctx.cfg >> 0xf) & 0x3f;
            r1 = brp_snr_cfg_lo_sel;
        } else {
            brp_pick.count = brp_snr_cfg_thr[1];
            r1 = brp_snr_cfg_hi_sel;
        }
    } else {
        brp_pick.count = (brp_ctx.cfg >> 0xf) & 0x3f;
        r1 = 0;
    }
    brp_pick.snr_cfg = r1;
    u8 r0 = brp_rf_cfg.sta_sel[a];
    if (((r0 >> 6) & 3) != 0)
        brp_pick.count = r0 & 0x3f;
    /* исправлено (vendor): count из настроек (до 63 / 255) не ограничивался — brp_rank_insert сдвигал записи за
     * brp_rank[rf][32] (для RF 7 — в brp_stats/brp_trn_metric), config_brp_rf читал за массивом. Подполей TRN
     * в измерении всегда 32 (brp_program_and_measure). */
    if (brp_pick.count > 32u)
        brp_pick.count = 32u;
    brp_pick.selected = 0;
}

/* Разбор полей запроса (0x92e1e4). */
u32 brp_parse_request_fields(u32 a)
{
    u8 *r13 = rx_buf;
    u32 r3 = (r13[0x21] << 8 | r13[0x20]) >> 0xa;
    r3 &= 1;
    u32 r1 = (rx_buf_brp_x24 >> 0xa) & 1;
    u32 r14 = r1 << 3;
    u32 r13b = (rx_buf_brp_req >> 5) & 1;
    r13b <<= 1;
    r3 = (r3 & ~2) | (r14 & ~2) | r13b;
    u32 lrx = rx_buf_brp_lrx();
    u32 r0 = 0;
    if (lrx != 0 && (r3 & 8) == 0)
        r0 = 1;
    r0 &= 1;
    r3 = (r3 & ~4) | (r0 << 2);
    u32 sp_word = r3;
    bf_set32((u32)&sp_word, 4, 5, lrx);
    u32 bit = 1u << a;
    bf_sta_mask &= ~(u16)bit;
    bf_brp_req_mask |= (u16)bit;
    return sp_word;
}

/* Запись пары регистров RF (0x92f9d8). */
void brp_write_reg_pair(u32 a, u32 b)
{
    uc_mac_cmd((u16)b | 0x42000000);
    uc_mac_cmd((b >> 16) | 0x43000000);
    u32 g = mac_sel_shadow & 0xfff0ffff;
    mac_sel_shadow = g | 0x30000;
    uc_mac_cmd(g | 0x1d030000);
    arc_nops_nop(2);
    while (arc_core_rd(47) & (1u << 17))
        ;
    uc_mac_cmd((a << 8) | (rf_chain_cfg | 0x41000000));
}

/* ------------------------------------------------------------------ */
/* Крупные BRP-функции — структурные порты. */

/* Сохранение RF-конфигурации (0x9213d0). */
void brp_rf_store_cfg(u32 a, u32 b, u32 c)
{
    /* 0x9213d0: сумма метрик c первых записей brp_rank[a] → 0x80150c,
     * затем поправка усиления по таблице 0x80152c → 0x801510[b]. */
    u32 sum = 0;
    brp_rf.metric_sum = 0;
    for (u32 i = 0; c >= 1; c--, i++) {
        sum = (u16)(sum + brp_rank[a][i].metric);
        brp_rf.metric_sum = (u16)sum;
    }
    s32 i0 = (s32)(u8)((sum + 4) >> 3);
    if (i0 > 0x2f)
        i0 = 0x2f;
    s32 i1 = ((s32)brp_rf.meas_8837f4 + 1) >> 1;
    if (i1 > 0x2f)
        i1 = 0x2f;
    u32 v0 = lin_to_db8_48[(u8)i0];
    u32 v1 = lin_to_db8_48[(u8)i1];
    u32 d = brp_rf.agc_row - agc_cfg.agc_start;
    u32 t = (u32)(s32)brp_rf.gain_ref - (d << 2) - v0;  /* ldw.x, sub2 */
    brp_rf.sta_gain[b] = (u16)(v1 + t);
}

/* Поток BRP-транзакции инициатора (0x922514). */
u32 brp_initiator_brp_transaction_flow(void)
{
    u32 ret;                                    /* vendor держит итог в r13 — базе brp_ctx */
    u8 r18 = brp_ctx.init_sta;
    u32 *r21 = (u32 *)bf_sta[r18].req_desc;
    u32 r20 = popcount8(rf_modules.mask);
    u32 r19 = (u16)r20;
    mac_program_4f_52(0x3a | (1u << 13), 4);
    (void)uc_read_tsf_lo();                     /* bl.d L_9364c8 — MAC-команда 0x4d000005 */
    u32 r14 = 0, r16 = 0;
    u32 r17;
    for (;;) {
        brp_init_tx_request();
        rfc_clear_core_reg1(0);
        r17 = 0;
        u32 r2 = brp_ctx.init_rf_pending;
        u8 r0 = rf_modules.cur_mask;
        u32 r15b;
        if (r2 == 0) {                          /* L_92259a: norm r1,r0 */
            r15b = (u8)(30 - arc_norm(r0));
        } else {
            u32 r1 = r0 & r2;
            if (r1 == 0)
                r0 = (u8)(r0 | (1u << (30 - arc_norm(r2))));
            r15b = (u8)(30 - arc_norm(r1 != 0 ? r1 : r2));
        }
        rfca_select_rf_uc(r0, 0);               /* r0 — маска RF (байт), r15b — номер */
        volatile u32 *m = (volatile u32 *)HW_PHY_BRP_883B78;
        *m &= ~((1u << 24) | (1u << 25));
        uc_mac_cmd(0x49000040);
        uc_wait_event1_or_event4(0x80 | (1u << 12), 0x40, 0);
        brp_ctx.init_peer_req = r17;
        /* СРОК: r42.12 (принят BRP-кадр ответчика с TRN-R) → цикл опроса метрик в
         * brp_program_and_measure до первого TRN-подполя и пока r49.13 (BRP-стадия в эфире):
         * по стандарту — AGC-поле 4N×0,18 мкс + CE 0,66 мкс (802.11-2020 20.9.2.2.5–6), где
         * относительно этого r42.12 — не установлено. Путь ~190 инструкций: rx_arm_window (ждёт
         * r42.16), rx_is_brp_frame, brp_parse_request_fields, вход в measure ~70 (vendor ~65:
         * bl L_920220 + 52 до первого опроса r54). Запас: единицы–десятки (по ХРУПКО у measure:
         * +23 инструкции входа уже давали assert 4). Срыв: meas_not_ready / assert 4, failure 1 после 10 неудач. */
        u32 r0a = arc_core_rd(42);
        if (r0a & (1u << 12)) {
            rx_arm_window();
            if ((arc_core_rd(36) & (1u << 25)) && rx_is_brp_frame() != 0) {
                uc_stats.brp_rx_txn = (u8)(uc_stats.brp_rx_txn + 1);
                u32 r0b = brp_parse_request_fields(r18);
                brp_ctx.init_peer_req = r0b;
                if (r0b & 1u) {
                    if (brp_program_and_measure(r18, r16, r15b) != 0) {
                        brp_stats.init_trn_ok = (u16)(brp_stats.init_trn_ok + 1);
                        r16 = (u16)(r16 + 1);
                        if ((s32)r16 <= (s32)r19)
                            brp_initiator_flow_successful_receive_training(r15b);
                    } else {
                        r14 = (u8)(r14 + 1);
                        if (r14 == 0xa) {
                            brp_stats.init_meas_fail = (u16)(brp_stats.init_meas_fail + 1);
                            uc_log_emit_snapshot(0, 0x1000a80);
                            ret = 0;
                            break;
                        }
                    }
                }
                /* → L_922694 (нижняя проверка) */
            } else if (arc_core_rd(37) & (1u << 24)) {   /* L_922664 */
                ret = 0;
                uc_log_emit_snapshot(0, 0x1000ab4);
                break;
            }
        } else {
            r0a = arc_core_rd(54);
            if (r0a & (1u << 6)) {
                if (!(brp_ctx.init_flags & 1u)) {
                    brp_stats.init_timeout_idle = (u16)(brp_stats.init_timeout_idle + 1);
                    uc_log_emit_snapshot(0, 0x1000b1c);
                    ret = 1;                        /* L_9226d8 */
                    break;
                }
                r14 = (u8)(r14 + 1);
                if (r14 == 0xa) {
                    brp_stats.init_timeout10 = (u16)(brp_stats.init_timeout10 + 1);
                    uc_log_emit_snapshot(0, 0x1000ae8);
                    ret = 0;
                    break;
                }
            } else {
                ret = 0;
                uc_log_emit_snapshot(0, 0x1000b50);
                break;
            }
        }
        if ((brp_ctx.init_flags & 1u) == 0 && (brp_ctx.init_peer_req & (1u << 2)) == 0) {
            ret = 1;
            break;
        }
    }
    u32 r14b = *(u8 *)((u32)r21 + 0x24);
    if (r14b & ~3u)                             /* bic.f 0,r14,0x3 */
        uc_assert((u32)__builtin_return_address(0), 0xac);
    volatile u32 *m = (volatile u32 *)HW_PHY_BRP_883B78;
    *m = ((r14b << 24) & 0xff000000) | (*m & ~((1u << 24) | (1u << 25)));
    if ((s32)r20 >= 2)
        brp_read_rf_id(rf_modules.cur_mask);
    return ret;
}

/* Инициализация BRP-потока (0x922728). */
void brp_init_flow(u32 a)
{
    u32 r17 = a;
    u32 saved_mask = rfca_get_rf_mask_uc();     /* st_s r0,[sp,0] */
    (void)*(struct bf_req_desc *volatile *)&bf_sta[r17].req_desc;  /* vendor читает и затирает */
    u32 r19 = (u8)r17;      /* 0x92275c: extb r0,r17 поверх ld → r19 = (u8)sta */
    brp_init_reset_ctx((u8)r17);
    bf_store_flow_status(r17, 0x31);
    u32 r0 = brp_ctx.init_flags;
    if (r0 & (1u << 9)) {
        if (brp_init_exchange_request() != 0) {
            brp_ctx.init_flags &= ~(1u << 9);
        } else {
            abif_dvs_rf_ctrl_shadow = *(volatile u32 *)HW_ABIF_DVS_RF_CTRL; /* [gp,0x5e] */
            return;                             /* b_s L_92281c — маска НЕ восстанавливается */
        }
    }
    if (brp_initiator_brp_transaction_flow() == 0) {
        brp_update_omni_sector_idx(r17, 0);     /* L_9227f8 → общий хвост */
    } else {
        abif_dvs_rf_ctrl_shadow = *(volatile u32 *)HW_ABIF_DVS_RF_CTRL;
        bf_store_flow_status(r17, 0x30);
        u32 r16 = rf_modules.mask;
        while (r16 != 0) {
            u32 r14 = (u8)(30 - arc_norm(r16));
            u32 r15 = 0x20;
            u32 r13 = 0;
            do {
                u8 v = brp_trn_metric[r14][r13];
                brp_rank_insert(r14, v, (u8)r13);
                r15--;
                r13 = (u8)(r13 + 1);
            } while (r15 >= 1);
            config_brp_rf(r14, brp_ctx.resp_sta);
            r16 = (u8)(r16 & ~(1u << r14));
        }
        rfca_access_sector_other_rf(r19);
        brp_update_omni_sector_idx(r17, 1);
    }
    gp_timer_stop(0);
    uc_mac_cmd(0x52000000);
    rfca_select_rf_uc(saved_mask, 0);   /* ld_s r0,[sp,0] */
}

/* Успешный приём тренировки инициатором (0x922824). */
void brp_initiator_flow_successful_receive_training(u32 a)
{
    u32 saved_mask = rfca_get_rf_mask_uc();     /* st_s r0,[sp,0] */
    u8 mask;
    u32 r16 = a;
    u32 r13 = 1u << r16;
    u8 r15 = (u8)r13;
    rfca_select_rf_uc((u8)r15, 0);
    u32 r0 = brp_ctx.init_rf_pending;
    u32 r1 = brp_ctx.init_flags;
    r0 &= ~r13;
    brp_ctx.init_rf_pending = r0;
    r1 = (u8)((r1 >> 1) | r13);
    bf_set32((u32)&brp_ctx.init_flags, 1, 8, r1);
    mask = rfca_get_rf_mask_uc();
    uc_log_emit2(0x20, 0x10009d8, r16, (u32)(u8)mask);
    u8 rb = rf_modules.cur_mask;
    u32 r0c = brp_ctx.init_rf_pending;
    if ((rb & r15) != 0 && r0c != 0) {
        uc_log_emit1(0x20, 0x1000a40, r16);
        rf_utils_auto_fill_with_byte((u8)r15, 1);
    }
    if (brp_ctx.init_rf_pending == 0)
        brp_ctx.init_flags &= ~1u;
    brp_stats.init_trn_ok = (u16)(brp_stats.init_trn_ok + 1);           /* +0x10 */
    if ((rf_modules.cur_mask & r13) == 0)
        rfc_clear_core_reg1(0);
    rfca_select_rf_uc(saved_mask, 0);   /* ld_s r0,[sp,0] */
}

/* Обмен запросом инициатора (0x922928). */
u32 brp_init_exchange_request(void)
{
    mac_program_4f_52(0x3a | (1u << 13), 4);
    u32 r14 = 0;
    for (;;) {
        brp_init_tx_request();                  /* L_92293a — в каждой итерации */
        uc_mac_cmd(0x49000040);
        uc_wait_event1_or_event4(0x80 | (1u << 12), 0x40, 0);
        u32 r0 = arc_core_rd(42);
        if (r0 & (1u << 12)) {
            rx_arm_window();
            r0 = arc_core_rd(36);
            if (r0 & (1u << 25)) {
                if (rx_is_brp_frame() != 0) {
                    u8 v = (u8)(uc_stats.brp_rx_req + 1);
                    uc_stats.brp_rx_req = v;
                    u32 r0b = brp_parse_request_fields(brp_ctx.init_sta);
                    brp_ctx.init_peer_req = r0b;     /* st_s r0,[r13,0x54] — результат */
                    if (r0b & (1u << 3))
                        continue;
                    return 1;
                }
            }
            r0 = arc_core_rd(37);
            if (r0 & (1u << 24))
                return 0;
            continue;
        }
        r0 = arc_core_rd(54);
        if (!(r0 & (1u << 6)))
            return 0;
        r14 = (r14 + 1) & 0xff;
        if (r14 != 3)
            continue;
        brp_stats.init_req_noresp = (u16)(brp_stats.init_req_noresp + 1);
        return 0;
    }
}

/* Отправка запроса инициатора (0x9229c0). */
void brp_init_tx_request(void)
{
    u8 r16 = brp_ctx.init_sta;
    rfca_select_rf_uc(rf_modules.cur, 0);
    mac_set_mode_a000(0);
    u32 r1 = brp_ctx.init_flags;                    /* +0x50 */
    u32 r15 = 0x38000300;
    u32 r17 = 0x3f000000;
    u32 r13v = 0x3e000000;
    u32 r14 = 0x37000020;
    u32 r21 = 0xfcffffff;
    u32 r0b;
    if (r1 & (1u << 16)) {
        uc_mac_cmd(0x2 | (1u << 25));
        uc_spin_until_event(2);
        uc_mac_cmd(0x14000100);
        r0b = sta_tab[r16].tx_sel;
        uc_mac_cmd(r15);
        uc_mac_cmd(0x3600003f);
        uc_mac_cmd(0x6000105);
        uc_mac_cmd(0x37000005);
        uc_mac_cmd(0x37000002);
    } else {
        mac_rf_switch_cmd1f(0);
        uc_mac_cmd(0x1f006000);
        r0b = sta_tab[r16].tx_sel;
        uc_mac_cmd(r15);
        uc_mac_cmd(0x3600003f);
        uc_mac_cmd(0x6000101);
        uc_mac_cmd(0x37000005);
        uc_mac_cmd(0x37000002);
    }
    uc_mac_cmd(r0b | r17);
    uc_mac_cmd(r13v);
    uc_mac_cmd(r14);
    uc_stats.tx_start++;                              /* +0xc */
    u32 r0c = abif_dvs_rf_ctrl_shadow;
    r0c &= r21;
    r0c |= rf_set_tx << 24;
    abif_dvs_rf_ctrl_shadow = r0c;
    *(u32 *)HW_ABIF_DVS_RF_CTRL = r0c;  /* не volatile — как в исходнике */
    uc_mac_cmd((sta_tab[r16].tx_sel | r17));
    brp_frame.brp_req[0] = 0;
    brp_frame.brp_req[1] = 0;
    brp_frame.brp_req[2] = 0;
    brp_frame.brp_req[3] = 0;
    brp_frame_dmg_br_elem = 0;
    brp_frame_dmg_br_tail = 0;
    u32 r0d = *(volatile u32 *)HW_MAC_MGMT_SEQ_NUM;
    u32 v = ((((r0d & 0xfff) + 1) << 16) & 0xfff0000) | (1u << 28);
    *(volatile u32 *)HW_MAC_MGMT_SEQ_NUM = v;
    brp_frame.seq_ctrl = (u16)((r0d & 0xfff) << 4);
    struct sta_entry *r13b = &sta_tab[r16];
    brp_frame.ra[0] = r13b->mac[0];
    brp_frame.ra[1] = r13b->mac[1];
    brp_frame.ra[2] = r13b->mac[2];
    brp_frame_dmg_br_elem |= (1u << 8);
    brp_frame_dmg_br_elem = (brp_frame_dmg_br_elem & 0xffffff00) | 5;
    brp_set_tx_sector_id((u32)brp_frame.brp_req, (r13b->tx_sel >> 8) & 0x3f);
    u32 r0e = brp_ctx.init_flags;            /* [0x800824+0x50] */
    if (r0e & (1u << 9)) {
        brp_frame_dmg_br_tail |= 1u << 10;      /* vendor: u32 |= по 0x8008bc, меняется только этот бит */
        bits_set_u8_s0_w5_uc((u32)brp_frame.brp_req, 0x10);
        uc_mac_cmd(0x20000400);
        /* b_s L_922c60 — проверка [0x800878] пропускается */
    } else {
        if (r0e & 1u) {
            bits_set_u8_s0_w5_uc((u32)brp_frame.brp_req, 0x10);
            uc_mac_cmd(0x20000400);
        }
        u32 r0f = brp_ctx.init_peer_req;        /* [0x800824+0x54] */
        if (r0f & (1u << 2)) {
            u32 r0g = ((((r0f >> 4) & 0x1f) << 4) & 0x1f0) | (1u << 10) | (1u << 29);   /* bic -0x1f1 == & 0x1f0 */
            uc_mac_cmd(r0g);
            brp_frame_dmg_br_elem |= (1u << 10);
        }
    }
    direct_tx_program_cmd34(0x18, 0x26);
    mac_program_tx_common();
    uc_mac_cmd(0x2008000);
    uc_mac_cmd(0x19000001);
    while (!(arc_core_rd(45) & (1u << 31)))
        ;
    uc_mac_cmd(0x18000000);
    mac_mode_send_direct_frame(0);
    mac_evt_enable_bit_sync_b(6);
    uc_mac_cmd(0x2013800);
    mac_set_rf_chain_state(1, rf_chain_word);
    uc_spin_until_event(1u << 15);
    uc_wait_one_event(6);
    u32 r0h = abif_dvs_rf_ctrl_shadow;
    r0h &= ~(1u << 24);
    r0h &= ~(1u << 25);
    r0h |= rf_set_rx << 24;
    abif_dvs_rf_ctrl_shadow = r0h;
    *(volatile u32 *)HW_ABIF_DVS_RF_CTRL = r0h;
    brp_set_phy_884060(0);
    uc_mac_cmd(1u << 29);
    r0h = brp_ctx.init_flags;
    if (r0h & (1u << 16)) {
        brp_ctx.init_flags = r0h & ~(1u << 16);
        uc_mac_cmd(0x80 | (1u << 25));
    }
}

/* Выбор конфигурации по SNR (0x922d2c). */
void brp_select_cfg_by_snr(u32 a, u32 b, u32 c, u32 d, u32 e, u32 f)
{
    u32 shift, off;
    if (b & 0x80) { shift = 3; off = 4; }
    else if (b & 0x40) { off = 2; shift = 2; }
    else if (b & 0x20) { off = 1; shift = 1; }
    else { off = 0; shift = 0; }
    s32 r2 = (u8)((c + off) >> shift);          /* asr; extb (беззнаковое) */
    s32 r0v = (r2 < 0x1f) ? r2 : 0x1f;          /* min signed */
    s32 r1 = (u8)((b + off) >> shift);
    s32 r1v = (r1 < 0x1f) ? r1 : 0x1f;
    u8 r14 = lin_to_db8_32[r0v];
    u8 r15 = lin_to_db8_32[r1v];
    u32 buf[3] = {0, 0, 0};
    s32 delta = (s8)((s8)(r15 - r14) + (s8)e);
    if (delta < 0)
        delta = 0;
    u8 flags = brp_snr_cfg_flags;
    if (delta < 5 && (flags & 0x40)) {
        buf[2] = d; buf[1] = d;                 /* st [sp,0xc]; b L_922e00 (st [sp,8]) */
    } else if (delta < 0xd && (flags & 0x20)) {
        buf[2] = d; buf[0] = d;
    } else if (delta < 0x15 && (flags & 0x10)) {
        buf[2] = d;
    } else if (delta < 0x1d && (flags & 0x8)) {
        buf[1] = d; buf[0] = d;
    } else if (delta < 0x25 && (flags & 0x4)) {
        buf[1] = d;
    } else if (f != 0) {
        buf[1] = d;
    }
    memcpy_uc((void *)a, buf, 0xc);
}

/* Вход в поток ответчика (0x922eec, 796 Б). */
void brp_responder_flow_enter(u32 a)
{
    u32 r18 = a;
    u32 r16 = 0x1000;                                   /* маска ожидания событий */
    u8 sp0 = (u8)(30 - arc_norm(rf_modules.cur_mask));      /* текущий RF-модуль */
    u32 r19 = popcount8(rf_modules.mask);
    u32 sp4 = (u32)rfca_get_rf_mask_uc();
    brp_init_ctx((u8)r18);
    uc_log_emit2(0, 0x1000998, rf_modules.mask, r19);
    gp_timer_arm(0, r19 * 0x10d18, 0, 0);               /* mulu64 r19*0x10d18 -> mlo */
    u32 r15 = 1;
    if (!(bf_sta_mask & (1u << (r18 & 31)))) {     /* ldw_s [gp,144] */
        uc_mac_cmd(0x2011000);
        uc_mac_cmd(0x14000100);
        uc_mac_cmd(0x14000000);
    } else if (rx_buf_toggle_dis == 0) {
        uc_mac_cmd((rx_buf_toggle_cnt & 1) | (1u << 25) | (1u << 28) | (1u << 29));
        rx_buf_toggle_cnt += 1;
    }
    uc_mac_cmd(0x80 | (1u << 25));
    for (;;) {
        brp_ctx.resp_peer_req = 0;                              /* L_922fb0 */
        uc_wait_event1_or_event4(r16, 0x40, 0);
        /* СРОК: r42.12 (принят BRP-кадр инициатора с TRN-R) → цикл опроса метрик в
         * brp_program_and_measure — то же окно, что у инициатора (brp_initiator_brp_transaction_flow):
         * AGC 4N×0,18 мкс + CE 0,66 мкс до первого TRN-подполя (802.11-2020 20.9.2.2.5–6). Путь
         * ~200 инструкций (rx_arm_window_b, при первом кадре ещё команда 0x80|б25, разбор, вход
         * ~70); запас: единицы–десятки. Ветка без resp_flags б0 (спин r42.14 без ограничения) —
         * не измеряет. */
        if (!(arc_core_rd(42) & (1u << 12))) {
            break;                                      /* -> L_923100 */
        }
        rx_arm_window_b();
        if (r15 != 0) {
            uc_mac_cmd(0x80 | (1u << 25));
            r15 = 0;
            r16 = 0x80 | (1u << 12);
        }
        if (!(arc_core_rd(36) & (1u << 25)) || rx_is_brp_frame() == 0) {
            if (brp_is_peer_ctrl_frame() != 0) {        /* L_9230e2 */
                break;
            }
        } else {
            u32 v = brp_parse_request_fields(r18);
            brp_ctx.resp_peer_req = v;
            if (v & 1) {
                if (!(brp_ctx.resp_flags & 1)) {             /* L_923030 */
                    u32 g = mac_sel_shadow & 0xffff0fff;
                    mac_sel_shadow = g | (1u << 13) | (1u << 15);
                    uc_mac_cmd(g | 0x1d00a000);
                    arc_nops(3);
                    uc_mac_cmd(mac_evt_en_shadow | 0x27007300);
                    uc_mac_cmd(0x2004000);
                    arc_nops(3);
                    uc_spin_until_event(1u << 14);
                } else if (brp_program_and_measure(brp_ctx.resp_sta, 0, sp0) != 0) {
                    brp_rf_module_done(sp0);
                } else {
                    brp_ctx.resp_peer_req = 0;
                }
            }
            brp_responder_transmission_flow();          /* L_92308e */
            rfc_clear_core_reg1(0);
            u32 sel = brp_ctx.resp_rf_pending;                    /* [0x800880] — маска выбранных модулей */
            u32 m = rf_modules.cur_mask;
            if (sel == 0) {
                sp0 = (u8)(30 - arc_norm(m));
            } else {
                u32 both = sel & m;
                if (both == 0)
                    m = (u8)(m | (1u << ((30 - arc_norm(sel)) & 31)));
                sp0 = (u8)(30 - arc_norm(both != 0 ? both : sel));
            }
            rfca_select_rf_uc(m, 0);
        }
        if ((u8)(brp_ctx.resp_flags >> 1) == brp_ctx.rf_mask_all) {   /* L_9230e8 */
            break;
        }
    }

    /* L_923100 */
    u32 done = (u8)(brp_ctx.resp_flags >> 1) == brp_ctx.rf_mask_all;
    if (done) {
        u32 r17 = rf_modules.mask;
        while (r17 != 0) {
            u32 r14 = (u8)(30 - arc_norm(r17));
            for (u32 k = 0; k < 0x20; k++)
                brp_rank_insert(r14, brp_trn_metric[r14][k], (u8)k);
            config_brp_rf(r14, brp_ctx.resp_sta);
            r17 = (u8)(r17 & ~(1u << (r14 & 31)));
        }
        rfca_access_sector_other_rf((u8)r18);
        gp_timer_stop(0);
        uc_mac_cmd(0x52000000);
    }
    done = (u8)(brp_ctx.resp_flags >> 1) == brp_ctx.rf_mask_all;       /* L_923178 */
    brp_update_omni_sector_idx(r18, done ? 1 : 0);
    done = (u8)(brp_ctx.resp_flags >> 1) == brp_ctx.rf_mask_all;
    bf_store_flow_status(brp_ctx.resp_sta, done ? 0x33 : 0x34);
    txrx_state1 = 0;                               /* st.as [gp,51] */
    txrx_state2 = 0;                               /* st.as [gp,52] */
    gp_timer_stop(0);
    uc_mac_cmd(0x52000000);
    bf_flow_exit(brp_ctx.resp_sta);
    if ((s32)r19 >= 2) {
        brp_read_rf_id(rf_modules.cur_mask);
        abif_dvs_rf_ctrl_shadow = MMIO32(HW_ABIF_DVS_RF_CTRL); /* st.as [gp,94] */
    }
    rfca_select_rf_uc(sp4, 0);
    brp_split_id(rf_chain_word);
}

/* Поток передачи ответчика (0x923314). */
void brp_responder_transmission_flow(void)
{
    u8 r13 = brp_ctx.resp_sta;
    rfca_select_rf_uc(rf_modules.cur, 0);
    mac_set_mode_a000(0);
    mac_rf_switch_cmd1f(0);
    uc_mac_cmd(0x1f006000);
    u32 r14 = sta_tab[r13].tx_sel;
    uc_mac_cmd(0x38000300);
    uc_mac_cmd(0x3600003f);
    uc_mac_cmd(0x6000101);
    uc_mac_cmd(0x37000005);
    uc_mac_cmd(0x37000002);
    uc_mac_cmd(r14 | 0x3f000000);
    uc_mac_cmd(0x3e000000);
    uc_mac_cmd(0x37000020);
    uc_stats.tx_start++;                                  /* +0xc */
    u32 r0 = abif_dvs_rf_ctrl_shadow;
    r0 &= ~(1u << 24);
    r0 &= ~(1u << 25);
    r0 |= rf_set_tx << 24;
    abif_dvs_rf_ctrl_shadow = r0;
    *(volatile u32 *)HW_ABIF_DVS_RF_CTRL = r0;
    brp_frame.brp_req[0] = 0;
    brp_frame.brp_req[1] = 0;
    brp_frame.brp_req[2] = 0;
    brp_frame.brp_req[3] = 0;
    brp_frame_dmg_br_elem = 0;
    brp_frame_dmg_br_tail = 0;
    u32 r0b = *(volatile u32 *)HW_MAC_MGMT_SEQ_NUM;
    u32 v = ((((r0b & 0xfff) + 1) << 16) & 0xfff0000) | (1u << 28);
    *(volatile u32 *)HW_MAC_MGMT_SEQ_NUM = v;
    brp_frame.seq_ctrl = (u16)((r0b & 0xfff) << 4);
    struct sta_entry *r13b = &sta_tab[r13];
    brp_frame.ra[0] = r13b->mac[0];
    brp_frame.ra[1] = r13b->mac[1];
    brp_frame.ra[2] = r13b->mac[2];
    brp_frame_dmg_br_elem &= ~(1u << 8);
    brp_frame_dmg_br_elem = (brp_frame_dmg_br_elem & 0xffffff00) | 5;
    brp_set_tx_sector_id((u32)brp_frame.brp_req, (r13b->tx_sel >> 8) & 0x3f);
    u32 r0c = brp_ctx.resp_flags;              /* [0x800824+0x60] */
    if (r0c & 1u) {
        bits_set_u8_s0_w5_uc((u32)brp_frame.brp_req, 0x10);
        uc_mac_cmd(0x20000400);
    }
    u32 r0d = brp_ctx.resp_peer_req;              /* [0x800824+0x64] */
    if (r0d & (1u << 2)) {
        u32 r0e = ((r0d >> 4) & 0x1f) << 4;
        r0e &= 0x1f0;                           /* bic -0x1f1 == & 0x1f0 */
        r0e |= (1u << 10) | (1u << 29);
        uc_mac_cmd(r0e);
        brp_frame_dmg_br_elem |= (1u << 10);
    }
    uc_log_emit2(0, 0x1000904, brp_frame.brp_req[0] & 0x1f, (brp_frame_dmg_br_elem >> 10) & 1);   /* ldb_s [r14,0x1b] */
    direct_tx_program_cmd34(0x18, 0x26);
    mac_program_tx_common();
    uc_mac_cmd(0x2008000);
    uc_mac_cmd(0x19000001);
    while (!(arc_core_rd(45) & (1u << 31)))
        ;
    uc_mac_cmd(0x18000000);
    mac_mode_send_direct_frame(0);
    mac_evt_enable_bit_sync_b(6);
    mac_set_rf_chain_state(1, rf_chain_word);
    uc_spin_until_event(1u << 15);
    uc_wait_one_event(6);
    u32 r0f = abif_dvs_rf_ctrl_shadow;
    r0f &= ~(1u << 24);
    r0f &= ~(1u << 25);
    r0f |= rf_set_rx << 24;
    abif_dvs_rf_ctrl_shadow = r0f;
    *(volatile u32 *)HW_ABIF_DVS_RF_CTRL = r0f;
    brp_set_phy_884060(0);
    uc_mac_cmd(1u << 29);
}

/* Восстановление секторов (0x923574). */
void brp_restore_sectors(u32 a)
{
    u32 r16 = a;
    u8 mask = rfca_get_rf_mask_uc();
    u32 r15 = maint_sta_mask;
    uc_log_emit1(0, 0x1000b84, r16);
    u32 r0 = 1u << r16;
    rfca_select_rf_uc((u8)r0, 0);
    while (r15 != 0) {
        u32 r14 = (30 - arc_norm(r15));
        r15 &= ~(1u << r14);
        u32 r13 = (u8)r14;
        sector_mem_addr_of(r13);
        r13 = (u8)(r13 + 0x60);                 /* extb */
        const struct brp_rf_regs_s *sh = &brp_rf_regs[r16][r14];
        u32 addr = (r13 << 6) * 3;   /* asl6 + add1 = ×0xc0 */
        brp_write_reg_pair((addr + 0x10020) >> 3 & ~3u, sh->reg_20);
        brp_write_reg_pair((addr + 0x10000) >> 3 & ~3u, sh->reg_00);
        brp_write_reg_pair((addr + 0x10060) >> 3 & ~3u, sh->reg_60);
        brp_write_reg_pair((addr + 0x10040) >> 3 & ~3u, sh->reg_40);
        brp_write_reg_pair((addr + 0x100a0) >> 3 & ~3u, sh->reg_a0);
        brp_write_reg_pair((addr + 0x10080) >> 3 & ~3u, sh->reg_80);
        brp_stats.restore_cnt[r16] = (u8)(brp_stats.restore_cnt[r16] + 1);
    }
    rfca_select_rf_uc(mask, 0);                 /* [sp] = исходная маска */
}

/* ХРУПКО: тайминг практически без запаса (доказано: assert 4 на железе, 6a30636f).
 * O2 + вынос адресов до команд: цикл опроса метрик критичен по времени (см. ниже),
 * -Os давал вход на ~23 инструкции и пропуск бита маски на 2 инструкции длиннее vendor.
 * Стандарт: TRN-подполе = [Ga128 −Gb128 Ga128 Gb128 Ga128] = 640 Tc ≈ 0,36 мкс ≈ 60 тактов,
 * CE (≈ 0,66 мкс) после каждых 4 подполей (802.11-2020 20.9.2.2.6, Figure 20-21); 32 метрики =
 * 8 TRN Units ≈ 17 мкс. Итерация цикла ниже — ~45–50 инструкций при попадании в маску
 * (с вызовом uc_shl64), от вызова до первого опроса ~70. */
/* Программирование и измерение (0x923678). */
__attribute__((optimize("O2")))
u32 brp_program_and_measure(u32 a, u32 b, u32 c)
{
    (void)b;
    u32 r15 = c;
    u32 r13;
    (void)*(struct bf_req_desc *volatile *)&bf_sta[a].req_desc;   /* vendor: мёртвая загрузка */
    if (!(arc_core_rd(49) & (1u << 13))) {
        brp_stats.meas_not_ready++;                                   /* L_9238b2 */
        return 0;
    }
    u32 r19 = FWSH(fwsh_sets, brp_cfg_mask)[r15];
    u8 *rank = brp_trn_metric[r15];
    u32 *w = brp_ctx.trn_bits[r15];
    __asm__ volatile("" :: "r"(rank), "r"(w));         /* вычислить до запуска измерения */
    brp_stats.meas_started++;
    uc_mac_cmd(0x49000002);
    uc_mac_cmd(0x5000020);
    uc_mac_cmd(0x20 | (1u << 26));
    uc_mac_cmd(0x3d010000);
    uc_mac_cmd(0x58000003);
    u32 r14 = 0, r17 = 0;
    r13 = 0;
    u32 cfg = mac_sel_shadow & 0xffff0fff;           /* ld_s [gp,-68] */
    mac_sel_shadow = cfg | (1u << 12) | (1u << 14) | (1u << 15);
    uc_mac_cmd(cfg | 0x1d00d000);
    arc_nops(3);
    u32 r18 = 0x20;
    for (;;) {
        /* ХРУПКО: метрика в r40 живёт до следующего TRN-подполя; опоздание
         * теряет индекс, и проверка ниже даёт assert 4 (гибрид vendor + лог в цикле
         * падает на первой же ассоциации). Как у vendor (L_923736..L_923748): ждать
         * r54.1 или r49.5, перечитать r54, в следующей же инструкции взять r40 и
         * сразу отправить uc_mac_cmd(0x49000002) (на таймауте — не отправлять).
         * В C -Os уводил чтение r40 за дальний переход. */
        u32 st, r16;
        __asm__ volatile("1:\tmov\t%0,r54\n\tbbit1\t%0,1,2f\n"
                         "\tmov\t%0,r49\n\tbbit0\t%0,5,1b\n"
                         "2:\tmov\t%0,r54\n\tbbit0\t%0,1,3f\n"
                         "\tmov\t%1,r40\n"
                         "\tmov\tr32,%2\n\tst.ab\t%2,[r25,4]\n\tbclr\tr25,r25,0xa\n3:"
                         : "=&r"(st), "=&r"(r16) : "r"(0x49000002u) : "memory");
        if (unlikely(!(st & (1u << 1)))) {
            brp_stats.meas_timeout++;                               /* L_9237de */
            r13 = 0;
            break;
        }
        UC_PAD(PAD_TRN_LOOP);
        while ((s32)r13 < 0x20 && !(r19 & (1u << r13))) {
            r13++;
            r14 += 2;
        }
        if ((s32)r13 < 0x20) {
            rank[r13] = (u8)((((r16 >> 14) & 0x3ff) + 2) >> 2);
            u64 sh = uc_shl64(r16 & 3, 0, r14);
            w[0] |= (u32)sh;
            w[1] |= (u32)(sh >> 32);
        }
        if (((r16 >> 24) & 0x7f) != r17)
            uc_assert((u32)__builtin_return_address(0), 4);
        r17++;
        r18--;
        r14 += 2;
        r13++;
        if (r18 < 1) {
            r13 = 1;
            break;
        }
    }
    if (brp_rf_cfg.enable != 0) {
        volatile u32 *r2 = (volatile u32 *)HW_PHY_RGF_BASE;
        brp_rf.agc_row = (u8)(r2[0xa9] & 0x3f);
        brp_rf.meas_8837f4 = (u8)(r2[-3] & 0x7f);
        brp_rf.snr = (u8)(r2[0] & 0x1f);
        brp_rf.meas_8836c8 = r2[-0x4e] & 0x3fffff;
    }
    brp_stats.meas_done += 1;
    uc_mac_cmd(0x3d020000);
    brp_stats.trn_copy[r15][0] = w[0];
    brp_stats.trn_copy[r15][1] = w[1];
    sta_set_rx_sector(a, a + 0x60);                   /* add3 r1,r0,0xc */
    u32 sw = VOL(rf_chain_word);
    rf_select_sector_cmd41(sw & 0xf, (sw >> 8) & 0x7fff);
    rf_cur_sector_word = VOL(rf_chain_word);     /* st.as [gp,-11] */
    cfg = mac_sel_shadow & 0xfff0ffff;
    mac_sel_shadow = cfg | (1u << 16) | (1u << 17);
    uc_mac_cmd(cfg | 0x1d030000);
    arc_nops(3);
    while (arc_core_rd(47) & (1u << 17))
        ;
    brp_program_mac_sequence_uc();
    if (r13 != 0)
        brp_pick_sector_cfg(a);
    return (u8)r13;
}

/* Сброс контекста (0x92afb8). */
void brp_init_reset_ctx(u32 a)
{
    /* 0x92afb8 */
    memset0_words_uc(&brp_ctx.init_sta, 0x10);       /* init_sta .. init_peer_req */
    u8 r1 = rf_modules.mask;
    brp_ctx.init_sta = (u8)a;
    brp_ctx.rf_mask_all = r1;
    u32 r16 = brp_ctx.init_flags | 1u | (1u << 16);
    brp_ctx.init_flags = r16;
    brp_ctx.init_rf_pending = r1;
    for (u32 i = 0; i < 8; i++) {
        brp_ctx.trn_bits[i][0] = 0;
        brp_ctx.trn_bits[i][1] = 0;
        memset0_words_uc(brp_rank[i], sizeof(brp_rank[i]));
        memset0_words_uc(brp_trn_metric[i], sizeof(brp_trn_metric[i]));
    }
    struct bf_sta_s *e = &bf_sta[a];
    if (!(e->brp_flags & 1)) {
        brp_ctx.init_flags = r16 | (1u << 9);
    } else if (e->peer_l_rx >= 1) {
        brp_ctx.init_peer_req |= (1u << 2);
        bf_set32((u32)&brp_ctx.init_peer_req, 4, 5, e->peer_l_rx & 0x1f);
    }
    uc_mac_cmd(0x2011000);
}

/* Инициализация контекста (0x92b068). */
void brp_init_ctx(u32 a)
{
    u32 r18 = a;
    memset0_words_uc(&brp_ctx.resp_sta, 0x10);   /* resp_sta .. resp_peer_req */
    u8 r17 = rf_modules.mask;
    brp_ctx.resp_sta = (u8)r18;               /* stb */
    brp_ctx.rf_mask_all = r17;                    /* stb_s */
    u8 r13 = 0, r15 = 8;
    do {
        brp_ctx.trn_bits[r13][0] = 0;
        brp_ctx.trn_bits[r13][1] = 0;
        memset0_words_uc(brp_rank[r13], sizeof(brp_rank[r13]));
        memset0_words_uc(brp_trn_metric[r13], sizeof(brp_trn_metric[r13]));
        r15--;
        r13 = (u8)(r13 + 1);
    } while (r15 >= 1);
    brp_ctx.resp_flags |= 1u;
    brp_stats.resp_start = (u16)(brp_stats.resp_start + 1);
    brp_ctx.resp_rf_pending = r17;
    if (!(bf_sta_mask & (1u << (r18 & 31)))) {  /* ldw_s [gp,0x90] = 0x8005b8; bbit1 r0,r18 */
        u8 rb = rf_modules.cur;
        rfca_select_rf_uc(rb, 0);
        rfc_clear_core_reg1(0);
        u8 rc = rf_modules.cur_mask;
        rfca_select_rf_uc(rc, 0);
        brp_split_id(rf_chain_word);
    }
}

/* Итерация по RF-маске (0x92efc8). */
void brp_iterate_rf_mask(u32 a)
{
    u32 r20 = a;
    u32 r21 = 0;
    if (r20 != 0) {
        u32 r6 = r20;
        do {
            r6 &= (r6 - 1);
            r21++;
        } while (r6 != 0);
        r21 &= 0xffff;
    }
    if (r21 < 1)
        return;
    u32 r19 = 1;
    const u32 *r22 = (const u32 *)FWSH(fwsh_sets, brp_cfg_mask);   /* vendor читает без перечитывания (ld) */
    u32 r18 = 6;
    do {
        u32 r13 = r20;
        u32 n = r19;
        while (n > 1) {
            r13 &= (r13 - 1);
            n--;
        }
        r13 &= ~(r13 - 1);            /* младший установленный бит */
        u8 r13b = (u8)r13;
        rfca_select_rf_uc(r13b, 0);
        u32 r14 = 0x2600;                     /* L_92f078 — заново для каждого RF */
        u32 r3 = 0;
        if (r13b > 8) {
            r3 = 4;
            r13b >>= 4;
        }
        if (r13b >= 3) {
            r3 += 2;
            r13b >>= 2;
        }
        r13b--;
        r3 = (u8)(r3 + r13b);
        u32 r17 = r22[r3];
        u32 r13c = 0;
        if (r17 != 0) {
            u32 t = r17;
            do { t &= (t - 1); r13c++; } while (t != 0);
        }
        u32 r15 = 0;
        while (r13c != 0) {
            u32 bit = 1u << r15;
            if (r17 & bit) {
                rf_write_sector_awv(r14 + 0x14, bit);
                rf_write_sector_awv(r14 + 0x8, bit);
                u32 v = r18 << ((r15 >> 2) * 3);    /* add1_s r2,r2,r2 = 3*r2 */
                if (r15 <= 0xf)
                    v += 0x10000000;
                else
                    v += 0x20000000;
                rf_write_sector_awv(r14 + 0x10, v);
                r14 += 0x18;
                r13c--;
            }
            r15++;
        }
        r21--;
        r19++;
    } while (r21 != 0);
}
