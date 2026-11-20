/* SPDX-License-Identifier: AGPL-3.0-or-later */
#ifndef UC_CLKK_H
#define UC_CLKK_H
/* Константы uc, зависящие от такта ядра, — непосредственные значения в коде, вписанные при старте.
 *
 * CLKK(имя) в uc — инструкция mov rX, limm: в поле limm при сборке стоит значение при такте сброса PLL (165 МГц, код
 * работает и без правки), адрес поля и номер величины — запись секции .clkpatch (uc/uc.ld: сразу за кодом, адрес — слово
 * CLKK_TABLE_PTR_UC; метка CLKK_MAGIC, число записей, записи «адрес | номер << 24»). fw перед пуском uc (lmac_if_ucode_init) читает таблицу через окно кода uc 0x920000 и вписывает
 * значения при текущем такте (clkk_patch_uc, fw/lmac.c) — горячие пути uc без загрузок и делений; от прежних литералов
 * отличие одно: значение сначала в регистре (mov), в циклах — вне цикла. limm лежит последними 4 байтами инструкции (и у
 * mov, и у mov_s), полусловами старшим вперёд (ARC600).
 *
 * CLKK_LIST — все такие величины: (имя, значение при такте f МГц); формулы — uc/ifs.h, uc/abft.h (*_AT). Одна таблица
 * для fw (расчёт) и uc (номер и значение по умолчанию). tests/unit/test_clk_cfg.py — значения при 165 МГц равны прежним
 * константам uc, при 140…170 — формулам стандарта. */
#include "../include/types.h"
#include "../include/clk.h"

#define CLKK_TABLE_PTR_UC 0xf8u         /* слово с адресом таблицы в ICCM uc (0-базовые; в окне fw — 0x920000 + это): uc/uc.ld */
#define CLKK_MAGIC     0x4b4b4c43u      /* 'CLKK' — первое слово таблицы; второе — число записей (адрес limm | номер << 24) */
#define CLKK_RECIP36(d)  ((u32)(((1ull << 36) + (d) - 1u) / (d)))   /* ⌈2^36/d⌉ */
#define CLKK_RECIP(k, d) ((u32)(((u64)(k) + (d) - 1u) / (d)))       /* ⌈k/d⌉ */
#define CLKK_CEIL(a, d)  (((a) + (d) - 1u) / (d))
#define CLKK_NS(ns, f)   SIFS_CNT_CODE_NS_AT(ns, f)

#define CLKK_LIST(X) \
    X(MHZ,                (f)) \
    X(SIFS,               DMG_SIFS_CLK_AT(f)) \
    X(SBIFS,              DMG_SBIFS_CLK_AT(f)) \
    X(SLOT,               DMG_SLOT_CLK_AT(f)) \
    X(PIFS,               DMG_PIFS_CLK_AT(f)) \
    X(MBIFS,              DMG_MBIFS_CLK_AT(f)) \
    X(LBIFS,              DMG_LBIFS_CLK_AT(f)) \
    X(PPDU_MAX,           DMG_PPDU_MAX_US * (f)) \
    X(RX_PHY_START_CTRL,  DMG_RX_PHY_START_DELAY_CTRL_US * (f)) \
    X(RESP_TIMEOUT,       DMG_RESP_TIMEOUT_US * (f)) \
    X(BRPIFS,             DMG_BRPIFS_US * (f)) \
    X(BRP_RESP_TIMEOUT,   (DMG_BRPIFS_US + DMG_SLOT_US + DMG_RX_PHY_START_DELAY_CTRL_US) * (f)) \
    X(RESP_FDBK_WAIT,     DMG_RESP_FDBK_WAIT_CLK_AT(f)) \
    X(TIMER1_LIMIT,       UC_TIMER1_LIMIT_US * (f)) \
    X(TIMER0_TICK,        UC_TIMER0_TICK_US * (f)) \
    X(CF_END_X,           DMG_CF_END_X_CLK_AT(f)) \
    X(CF_END_MX,          CLKK_RECIP36(DMG_CF_END_X_CLK_AT(f))) \
    X(CF_END_MF,          CLKK_RECIP36(f)) \
    X(GRANT_ACK_SUB_US,   DMG_RESP_DUR_SUB_US_AT(DMG_GRANT_ACK_LEN, f)) \
    X(CF_END_CMD_CTRL,    DMG_CF_END_HOLDER_CMD_CTRL_AT(f)) \
    X(CF_END_CMD_SC1,     DMG_CF_END_HOLDER_CMD_SC1_AT(f)) \
    X(CF_END_MIN_REM_US,  DMG_CF_END_MIN_REM_US_AT(f)) \
    X(CF_END_NZ_REM_US,   DMG_CF_END_NZ_REM_US_AT(f)) \
    X(CF_END_CLOSE,       DMG_CF_END_MIN_REM_US_AT(f) * (f) + DMG_SLOT_CLK_AT(f)) \
    X(KA_RTS_CMD,         DMG_KA_RTS_CMD_AT(f)) \
    X(ESE_TXOP_TAIL_US,   ESE_TXOP_TAIL_US_AT(f)) \
    X(ESE_SLS_TAIL_US,    ESE_SLS_TAIL_US_AT(f)) \
    X(ABFT_AIRPROP,       ABFT_AIRPROP_CLK_AT(f)) \
    X(ABFT_SLOT_TAIL,     ABFT_SLOT_TAIL_CLK_AT(f)) \
    X(ABFT_STA_STD_GP1,   ABFT_STA_STD_GP1_CLK_AT(f)) \
    X(ABFT_AP_TRIG03,     ABFT_AP_TRIG03_CLK_AT(f)) \
    X(ABFT_CLK2FX_MUL,    ABFT_CLK2FX_MUL_AT(f)) \
    X(ABFT_SSW_TXTIME_FX, ABFT_SSW_TXTIME_FX_AT(f)) \
    X(ABFT_SSW_STEP_FX,   ABFT_SSW_STEP_FX_AT(f)) \
    X(SLS_DUR_MUL,        SLS_DUR_MUL_AT(f)) \
    X(US_MUL22,           CLK_US_MUL22_AT(f)) \
    X(SSWFB_DUR_US,       SSWFB_DUR_US_AT(f)) \
    X(SSWFB_DUR_BRP_US,   SSWFB_DUR_BRP_US_AT(f)) \
    X(SSWACK_DUR_SUB,     SSWACK_DUR_SUB_AT(f)) \
    X(SSWFB_GP1,          SSWFB_GP1_CLK_AT(f)) \
    X(SSWFB_RETRY_NEED_US, SSWFB_RETRY_NEED_US_AT(f)) \
    X(SSWFB_FRAME_US,     SSWFB_FRAME_US_AT(f)) \
    X(SSW_FRAME_US,       SSW_FRAME_US_AT(f)) \
    X(BAP_RX_WAIT_PASSES, BAP_RX_WAIT_PASSES_AT(f)) \
    X(SIFS_CNT_ABFT_SSW_LATE,  CLKK_NS(SIFS_CNT_ABFT_SSW_LATE_NS, f)) \
    X(SIFS_CNT_ABFT_FB_LATE,   CLKK_NS(SIFS_CNT_ABFT_FB_LATE_NS, f)) \
    X(SIFS_CNT_RX_ENTRY_LATE,  CLKK_NS(SIFS_CNT_RX_ENTRY_LATE_NS, f)) \
    X(SIFS_CNT_RX_LATE_END_SC, CLKK_NS(SIFS_CNT_RX_LATE_END_SC_NS, f)) \
    X(SIFS_CNT_RESP_LATE,      CLKK_NS(SIFS_CNT_RESP_LATE_NS, f)) \
    X(TSF_RX_ADJ,         MAC_US_CLK_CODE_AT(UC_TSF_RX_ADJ_CLK, f)) \
    X(TX_STAMP_CTRL,      MAC_US_CLK_CODE_AT(UC_TX_STAMP_CTRL_CLK, f)) \
    X(TX_STAMP_SC,        MAC_US_CLK_CODE_AT(UC_TX_STAMP_SC_CLK, f))

#define CLKK_ENUM_(n, e) CLKK_ID_##n,
enum clkk_id { CLKK_LIST(CLKK_ENUM_) CLKK_N };
#undef CLKK_ENUM_

/* Значение при такте f (fw — при старте; хост-тесты — та же формула). */
#define CLKK_CASE_(n, e) case CLKK_ID_##n: return (u32)(e);
static inline u32 clkk_value(u32 id, u32 f)
{
    switch (id) {
    CLKK_LIST(CLKK_CASE_)
    default: return 0;
    }
}
#undef CLKK_CASE_

#ifdef UC_CLKK
/* uc: значения по умолчанию — при такте сброса PLL (константные выражения для операнда "i"). */
#define f CLK_MHZ_RESET
#define CLKK_DEF_(n, e) CLKK_DEF_##n = (long)(u32)(e),
enum clkk_def { CLKK_LIST(CLKK_DEF_) CLKK_DEF_END_ };
#undef CLKK_DEF_
#undef f
/* mov rX, limm + запись {адрес limm, номер} в .clkpatch. Значение — символом, заданным ПОСЛЕ инструкции (.set): при
 * ссылке вперёд ассемблер всегда кодирует поле limm (с числом малое значение он сжал бы в mov_s r,u8 без limm — правка
 * испортила бы код; test_clk_cfg проверяет каждое место). Без volatile: компилятор может выносить из циклов и сливать
 * одинаковые (правка общая для всех копий записи). */
#define CLKK_IMM_(v, id) __extension__ ({ u32 clkk_v_; \
    __asm__("mov\t%0,.Lclkk%=\n2:\n\t.pushsection .clkpatch,\"a\"\n\t.word\t2b-4+(%2<<24)\n\t.popsection\n" \
            "\t.set\t.Lclkk%=,%1" \
            : "=r"(clkk_v_) : "i"((u32)(v)), "i"(id)); clkk_v_; })
#define CLKK(n) CLKK_IMM_(CLKK_DEF_##n, CLKK_ID_##n)
#endif
#endif
