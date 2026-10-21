/* SPDX-License-Identifier: AGPL-3.0-or-later */
#ifndef UC_DBG_H
#define UC_DBG_H
/* Отладочные вставки для замера запаса по срокам (план тестов СРОК/ХРУПКО). В рабочей сборке
 * (без -D ниже) оба макроса пусты и код не меняется; сборки с флагами — только для стенда.
 *
 * UC_PAD(site): K команд nop в точке site, если сборка с -DUC_PAD_SITE=site -DUC_PAD_K=K
 * (UC_DBG="-DUC_PAD_SITE=… -DUC_PAD_K=…"). Ветка с ложным условием удаляется компилятором до
 * кодогенерации, поэтому остальные точки не влияют на код. K — из таблицы UC_NOPS_* ниже
 * (1, 2, 4, 8, 12, 16, 20, 24, 28, 32, 40, 48, 56, 64, 96, 128). Серия K = 0, 4, 8, 16, 32, 64 даёт
 * запас пути в инструкциях (tools/stand_tests/pad_sweep.sh).
 *
 * UC_STAMP(id, a0, a1): запись в кольцо журнала uc (формат записи с 2 аргументами, токен
 * 0xfff00 | id) — вместо TSF счётчик тактов Timer1 (AUX 0x100 COUNT1, 165 МГц, период
 * 0x13ab6680 тактов ≈ 2 с), затем a0, a1. Только при -DUC_STAMP_MASK с битом id; стоит ~14
 * инструкций. Разбор — tools/hwdbg/stamps.py. */

/* Точки вставки nop (номер = UC_PAD_SITE). */
#define PAD_RESP_CMD      1   /* rx: начало rx_frame_tx_resp_seq, перед запросом MTP (ответ Ack/BA) */
#define PAD_RESP_ENTRY    2   /* rx: вход rx_flow_handle_frame */
#define PAD_TXOP          3   /* rx: перед 0x1b001111 в rx_txop_continue (прежний UC_DBG_TXOP_PAD) */
#define PAD_TRN_LOOP      4   /* brp: тело цикла метрик TRN */
#define PAD_ABFT_SSW      5   /* bti: между SSW в abft_responder_tx_ssw */
#define PAD_IMM_RESP      6   /* tx: перед командой в tx_send_imm_response (DMG CTS/DTS) */
#define PAD_CTS_SWITCH    7   /* mac: mac_mode_switch_after_ppdu (CTS на RTS) */
#define PAD_SSWFB_ABFT    8   /* tail: direct_tx_step (SSW-Feedback в A-BFT) */
#define PAD_D10_WRITE     9   /* rx: перед записью 0x886d10 в rx_flow_step */
#define PAD_ABFT_SIFSCHK 10   /* bti: перед проверкой SIFS_CNT в abft_responder_respond_flow */

#if defined(UC_PAD_SITE) && defined(UC_PAD_K) && UC_PAD_K > 0
/* nop строками, а не .rept: GCC оценивает длину вставки по числу строк шаблона, и с .rept
 * короткие переходы вокруг вставки выходили за допустимую дальность (ошибка ассемблера). */
#define UC_NOPS_1   "nop\n\t"
#define UC_NOPS_2   UC_NOPS_1 UC_NOPS_1
#define UC_NOPS_4   UC_NOPS_2 UC_NOPS_2
#define UC_NOPS_8   UC_NOPS_4 UC_NOPS_4
#define UC_NOPS_12  UC_NOPS_8 UC_NOPS_4
#define UC_NOPS_16  UC_NOPS_8 UC_NOPS_8
#define UC_NOPS_20  UC_NOPS_16 UC_NOPS_4
#define UC_NOPS_24  UC_NOPS_16 UC_NOPS_8
#define UC_NOPS_28  UC_NOPS_24 UC_NOPS_4
#define UC_NOPS_32  UC_NOPS_16 UC_NOPS_16
#define UC_NOPS_40  UC_NOPS_32 UC_NOPS_8
#define UC_NOPS_48  UC_NOPS_32 UC_NOPS_16
#define UC_NOPS_56  UC_NOPS_48 UC_NOPS_8
#define UC_NOPS_64  UC_NOPS_32 UC_NOPS_32
#define UC_NOPS_96  UC_NOPS_64 UC_NOPS_32
#define UC_NOPS_128 UC_NOPS_64 UC_NOPS_64
#define UC_NOPS_CAT(k)  UC_NOPS_##k
#define UC_NOPS_XCAT(k) UC_NOPS_CAT(k)
#define UC_PAD(site) do { \
        if ((site) == UC_PAD_SITE) \
            __asm__ volatile(UC_NOPS_XCAT(UC_PAD_K)); \
    } while (0)
#else
#define UC_PAD(site) do { } while (0)
#endif

#ifdef UC_STAMP_MASK
#define UC_STAMP(id, a0, a1) do { \
        if ((UC_STAMP_MASK) & (1u << (id))) \
            uc_stamp((id), (u32)(a0), (u32)(a1)); \
    } while (0)
static inline __attribute__((always_inline)) void uc_stamp(u32 id, u32 a0, u32 a1)
{
    u32 t = arc_lr(0x100);                       /* COUNT1: такты */
    u32 idx = uc_log.wr_idx;
    uc_log.ring[(u8)(idx + 3)] = a1;
    uc_log.ring[(u8)(idx + 2)] = a0;
    uc_log.ring[(u8)(idx + 1)] = t;
    uc_log.ring[(u8)idx] = 0xa8000000u | 0xfff00u | id;
    uc_log.wr_idx = idx + 4;
}
#else
#define UC_STAMP(id, a0, a1) do { } while (0)
#endif

#endif
