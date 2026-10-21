// SPDX-License-Identifier: AGPL-3.0-or-later
/* MAC-парсер и RX-фильтр (прошивка 6.2). Порт декомпилированных 6.4/src/c/fw.
 * Без этих правил MAC не доставляет RX-кадры (RX-DMA=0).
 *
 * Общий паттерн: функции строят 2-словный буфер-правило и пишут его через
 * mac_parser_write_rule() (= mac_parser__uses_rgf_886280). Упаковка буфера:
 *   [sp]=X (слово), [sp+2]=Y (слово, перекрывает sp+2..sp+5),
 *   [sp+4]=Z (слово)  →  buf[0] = (X&0xffff)|((Y&0xffff)<<16), buf[1] = Z.
 */
#include "../include/types.h"
#include "../include/mid.h"
#include "../include/sys_cfg.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/ieee80211.h"
#include "../include/fwdata.h"
#include "../include/mac_parser.h"


__attribute__((section(".textlate"))) void bits_set16h_s4_w5(void *p, u32 v){ u16 *w=p; *w=(u16)((*w&~((0x1fu)<<4))|((v&0x1f)<<4)); }


/* mac_parser__uses_rgf_886280 (0x8dfbd8)(buf, val, field): 0x886298=buf[0],
 * 0x88629c=buf[1], 0x886294=val, 0x886290=cmd, 0x88628c=0x40000000, ждать bit29.
 * Поле cmd[4..5] = field & 3 (vendor bmsk r1,r2,0x1 — маска битов 0..1, т. е. 2 бита).
 * Прежний порт брал field & 1: все вызовы (field = 3) писали правила в таблицу 1 вместо
 * таблицы 3 (на стенде 0x886290 = 0x80110000 против 0x80310000 у vendor). */
__attribute__((section(".textlate"))) void mac_parser_write_rule(const struct prs_rule *buf, u32 val, u32 field)
{
    u16 cmd = 0;
    bits_set16h_s0_w2(&cmd, 1);
    mac_filter_bits_set16h_s4_w2(&cmd, field & 3u);
    MMIO32(HW_PRS_TBL_B_CMD) = ((u32)cmd << 16) | 0x80000000u;
    MMIO32(HW_PRS_TBL_B_ADDR) = val;
    MMIO32(HW_PRS_TBL_B_DATA0) = buf->w[0];
    MMIO32(HW_PRS_TBL_B_DATA1) = buf->w[1];
    MMIO32(HW_PRS_TBL_B_CTRL) = 0x40000000u;
    arc_sync();
    while (MMIO32(HW_PRS_TBL_B_CTRL) & (1u << 29)) { }
}

/* mac_parser__pack_rule_halfword(buf, val): 0x886278/0x88627c/0x886280/0x886284. */
__attribute__((section(".textlate"))) void mac_parser_pack_rule_halfword(const struct prs_rule *buf, u32 val)
{
    u16 cmd = 0;
    bits_set16h_s0_w2(&cmd, 1);
    mac_filter_bits_set16h_s4_w2(&cmd, 1);
    MMIO32(HW_PRS_TBL_A_CMD) = ((u32)cmd << 16) | 0x80000000u;
    MMIO32(HW_PRS_TBL_A_ADDR) = val;
    MMIO32(HW_PRS_TBL_A_DATA0) = buf->w[0];
    MMIO32(HW_PRS_TBL_A_DATA1) = buf->w[1];
    MMIO32(HW_PRS_TBL_A_CTRL) = 0x40000000u;
    arc_sync();
    while (MMIO32(HW_PRS_TBL_A_CTRL) & (1u << 29)) { }
}

/* mac_parser__build_wildcard_rule (0x8dfac8): правило-«джокер» для cid.
 * Баг vendor: обнуляются полуслова 0/2/4 (sth.aw r0,[sp,-8]; sth [sp,2]; sth [sp,4]),
 * а [sp+6] до RMW в 0x8ed31c (поле s4 w5) не пишется — биты 1..3 и 9..15 берутся из
 * стека и уходят в 0x886284 (старшее полуслово правила фильтра RX). Обнуляем, как
 * остальные поля, — правило детерминировано. */
__attribute__((section(".textlate"))) void mac_parser_build_wildcard_rule(u32 a0)
{
    struct prs_rule buf;
    buf.h[0] = 0;
    buf.h[1] = 0;
    buf.h[2] = 0;
    buf.h[3] = 0;
    bits_set16h_s4_w5(&buf.h[3], 0x1f);
    buf.h[3] = (u16)(buf.h[3] & ~1u);
    mac_parser_pack_rule_halfword(&buf, a0);
}

/* 0x803966: 9 байт — обращений в vendor-коде не найдено (по виду — байтовая таблица переходов
 * без кода). Держит образ. */
FWDATA(803966) __attribute__((aligned(1))) const u8 vendor_unref_803966[9] = { 0x09, 0x09, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x06 };

/* 0x803970: 4 правила mac_parser_step_a (слова; копируются на стек). */
FWDATA(803970) const u32 mac_parser_step_a_rules[4] = { 0x400, 0x400, 0x400, 0x0 };

/* mac_parser_step_a (0x8dfee4): 4 правила по таблице 0x803970 (4 СЛОВА: add2 r0,sp,r14;
 * ld_s r0,[r0,8] — {0x400, 0x400, 0x400, 0}; прежний порт брал байты tab[i]).
 * Флаги в 0x8dff50/0x8dff60: Z от asr.f (hi == 0), btst.ne r14,0 — только при hi != 0,
 * т. е. условие «hi && lo» (прежний порт: «lo» для 8 и «!hi && !lo» для 0x1a). */
__attribute__((section(".textlate"))) void mac_parser_step_a(u32 obj)
{
    u32 tab[4];
    u32 i;
    memcpy_fw(tab, mac_parser_step_a_rules, 0x10);

    for (i = 0; i < 4; i++) {
        u32 lo = i & 1;
        u32 hi = (i & 2) >> 1;
        u32 X, Y, Z, r2;
        struct prs_rule buf;

        /* [sp] = X = (lo<<6)|0x22|(hi<<7)|tab[i] (sth — младшие 16 бит) */
        X = (lo << 6) | 0x22u | (hi << 7) | tab[i];

        /* [sp+2] = Y = (hi&&lo ? 8 : 0)|0x17 | (hi&&lo ? 0x20 : 0x1a)<<9 |
         * ((i+0x3c) == 0x2c ? 0 : 1)<<14 | 1<<15 */
        Y = ((hi != 0 && lo != 0) ? 8u : 0u) | 0x17u;
        Y |= ((hi != 0 && lo != 0) ? 0x20u : 0x1au) << 9;
        Y |= ((i + 0x3c) == 0x2cu ? 0u : 1u) << 0xe;
        Y |= 1u << 0xf;

        /* r2 = 1 если (i&1)==0 и hi==0, иначе 0 */
        r2 = ((i & 1) == 0 && hi == 0) ? 1u : 0u;

        /* [sp+4] = Z = (obj<<18)|0x3ef7f|r2|0x5c00000 */
        Z = (obj << 0x12) | 0x3ef7fu | r2 | 0x5c00000u;

        buf.w[0] = (X & 0xffffu) | ((Y & 0xffffu) << 16);
        buf.w[1] = Z;
        mac_parser_write_rule(&buf, i + 0x3c, 3);
    }

    /* финальное правило: [sp]=0x432, [sp+2]=0xb417, [sp+4]=obj<<18|0x5c3ef7f */
    {
        struct prs_rule buf;
        buf.w[0] = 0x432u | (0xb417u << 16);
        buf.w[1] = (obj << 0x12) | 0x5c3ef7fu;
        mac_parser_write_rule(&buf, 0x2c, 3);
    }
}

/* Общие поля правил mac_parser__step_b (0x8dfe14) и mac_parser__install_default_rules
 * (0x8dfc58) — одинаковые фрагменты кода в обеих функциях.
 * a (0x8dfcbe/0x8dfe8e): v ∈ {0x1c, 0x36, 0x34, 0x37} → 1, иначе 3. */
__attribute__((section(".textlate"))) static u32 mac_parser_rule_a_of(u32 v)
{
    return (v == 0x1c || v == 0x36 || v == 0x34 || v == 0x37) ? 1u : 3u;
}

/* Y — старшее полуслово buf[0] ([sp+2], 0x8dfcd4..0x8dfd0c / 0x8dfea4..0x8dfedc):
 * (v != 0x1c) | (v ∈ {0x17, 0x18} ? 0x20 : 0) | (v == 0x18 ? 0x40 : 0) |
 * (v == 0x1c ? 0xa : 0x10) << 9 | (v ∈ {0x1c, 0x18, 0x17} ? 0x8000 : 0). */
__attribute__((section(".textlate"))) static u32 mac_parser_rule_y(u32 v)
{
    u32 y = (v == 0x1c) ? 0u : 1u;
    y |= (v == 0x17 || v == 0x18) ? 0x20u : 0u;
    y |= (v == 0x18) ? 0x40u : 0u;
    y |= ((v == 0x1c) ? 0xau : 0x10u) << 9;
    y |= (v == 0x1c || v == 0x18 || v == 0x17) ? 0x8000u : 0u;
    return y;
}

/* Z — buf[1] ([sp+4], 0x8dfc6e..0x8dfc9a / 0x8dfe2a..0x8dfe56):
 * (v != 0x1c) << 16 | 0x8f7f | (v == 0x17) << 17 | obj << 18 | a << 22 | (v == 0x17) << 30. */
__attribute__((section(".textlate"))) static u32 mac_parser_rule_z(u32 v, u32 obj, u32 a)
{
    u32 z = ((v == 0x1c) ? 0u : 1u) << 0x10;
    z |= 0x8f7fu;
    z |= ((v == 0x17) ? 1u : 0u) << 0x11;
    z |= obj << 0x12;
    z |= a << 0x16;
    z |= ((v == 0x17) ? 1u : 0u) << 0x1e;
    return z;
}

/* mac_parser__step_b (0x8dfe14): 9 правил, r13 = 2..10 (выход brhs r13,0xb).
 * v = r13 + 0x2e (0x35 → 0x10); X = (r13 << 6) | 0x419; Y — общий фрагмент плюс
 * бит 8 при r13 >= 8 (cmp_s r13,8; sub.c — 0 при r13 < 8). Прежний порт делал 10 правил
 * (до 11) и брал в Y младшие 16 бит слова Z. */
__attribute__((section(".textlate"))) void mac_parser_step_b(u32 obj)
{
    u32 i;
    for (i = 2; i < 0xb; i++) {
        u32 v = i + 0x2e;
        u32 X, Y;
        struct prs_rule buf;

        if (v == 0x35)
            v = 0x10;
        X = (i << 6) | 0x419u;
        Y = mac_parser_rule_y(v) | ((i < 8) ? 0u : 0x100u);
        buf.w[0] = (X & 0xffffu) | ((Y & 0xffffu) << 16);
        buf.w[1] = mac_parser_rule_z(v, obj, mac_parser_rule_a_of(v));
        mac_parser_write_rule(&buf, v, 3);
    }
}

/* mac_parser__install_default_rules (0x8dfc58): 7 правил, r13 = 8..14 (выход brhs r13,0xf).
 * v = r13 + 0xf (0x1d → 0x35); X = (r13 << 2) | 0x401. Прежний порт для v == 0x18 ставил
 * в Y бит 0 вместо бита 6 (mov_s r3,1; sub_s.ne; asl_s r3,r3,6). */
__attribute__((section(".textlate"))) void mac_parser_install_default_rules(u32 obj)
{
    u32 i;
    for (i = 8; i < 0xf; i++) {
        u32 v = i + 0xf;
        u32 X;
        struct prs_rule buf;

        if (v == 0x1d)
            v = 0x35;
        X = (i << 2) | 0x401u;
        buf.w[0] = (X & 0xffffu) | ((mac_parser_rule_y(v) & 0xffffu) << 16);
        buf.w[1] = mac_parser_rule_z(v, obj, mac_parser_rule_a_of(v));
        mac_parser_write_rule(&buf, v, 3);
    }
}

/* 0x803980: таблица переходов vendor hwd_mac_parser__set_rx_filter (0x8dfd14): ldb.x, 15 записей, цель = 0x8dfd7a + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(803980) __attribute__((aligned(1))) const u8 hwd_mac_parser_set_rx_filter_jt0[15] = {
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x06, 0x06, 0x02, 0x02, 0x02, 0x02,
    0x02, 0x02, 0x04,
};

/* 0x803990: таблица переходов vendor hwd_mac_parser__set_rx_filter (0x8dfd14): ldb.x, 11 записей, цель = 0x8dfdaa + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(803990) __attribute__((aligned(1))) const u8 hwd_mac_parser_set_rx_filter_jt1[11] = {
    0x07, 0x09, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x00, 0x0b, 0x0b, 0x07,
};

/* hwd_mac_parser__set_rx_filter (0x8dfd14)(obj, flag): 13 правил, r14 = 0..14 без 6, 7
 * (выход brhs r14,0xf). Значение v — переход по байтовой таблице 0x803980
 * {0,0,0,0,0,0,6,6,2,2,2,2,2,2,4}: 0 → r14 + 1, 2 → r14 − 1, 4 → 0xf, 6 → ассерт 0x100e
 * (недостижим). Поле a — по таблице 0x803990 для v − 5 < 0xb
 * {7,9,11,11,11,11,11,0,11,11,7}: v = 5, 0xf → 3; v = 6 → 0; v = 0xc → (flag == 0 ? 3 : 0)
 * (mov 1; sub.ne при r15 != 0; neg; bmsk 1); остальные → 1.
 * X = (r14 << 2) | 0x400; Y = (v == 0xc) << 8 | 0x3007 | (v ∉ {0xf, 8}) << 14 | 1 << 15;
 * Z = obj << 18 | 0x1af7f | a << 19 | 1 << 22 | 1 << 23.
 * На стенде у vendor последнее правило (r14 = 14, v = 0xf): 0x886294 = 0xf,
 * 0x886298 = 0xb0070438, 0x88629c = 0xd9af7f — совпадает с этой формулой. Прежний порт
 * делал 15 правил (до r14 = 15), v = 0xf при r14 = 8, без 0x3007/бита 14 в Y и с иной
 * таблицей a. */
__attribute__((section(".textlate"))) void hwd_mac_parser_set_rx_filter(u32 obj, u32 flag)
{
    u32 i;
    for (i = 0; i < 0xf; i++) {
        u32 v, a, X, Y, Z;
        struct prs_rule buf;

        if (i >= 6 && i < 8)
            continue;
        if (i < 6)
            v = i + 1;
        else if (i < 14)
            v = i - 1;
        else
            v = 0xf;

        a = 1;
        if (v == 5 || v == 0xf)
            a = 3;
        else if (v == 6)
            a = 0;
        else if (v == 0xc)
            a = (flag == 0) ? 3u : 0u;

        X = (i << 2) | (1u << 0xa);
        Y = ((v == 0xc) ? 0x100u : 0u) | 0x3007u;
        Y |= (v == 0xf || v == 8) ? 0u : (1u << 0xe);
        Y |= 1u << 0xf;
        Z = (obj << 0x12) | 0x1af7fu | (a << 0x13) | (1u << 0x16) | (1u << 0x17);

        buf.w[0] = (X & 0xffffu) | ((Y & 0xffffu) << 16);
        buf.w[1] = Z;
        mac_parser_write_rule(&buf, v, 3);
    }
}

/* mac_filter__write_entries (0x8df9e8)(a = r16, b = r14, c = r13): команда 0x886278
 * (поле [0..1] = 1, [4..5] = a & 3 — bmsk r1,r16,0x1), данные 0x886280/0x886284, затем
 * для каждого индекса b..c — 0x88627c = индекс и запуск (0x886274 = 0x40000000, ждать
 * бит 29). Кадр vendor: [sp+2] — cmd, [sp+4..sp+0xb] обнулены (0x8c1cd8, 8 Б),
 * bits__set16h_s4_w5([sp+0xa], 0x1f) → [sp+8] = 0x01f00000; слово [sp+0xc] — ВНЕ
 * обнулённой области: bits__set_s8_w5([sp+0xc], 0x1f) (r1 = 0x1f, сохранён помощником
 * 0x8ed31c) и bits__set32_s0_w4(…, 0); cmp r16,1 перед ними задаёт флаги bne_s 0x8dfa54
 * (bl/помощники флагов не меняют): a == 1 → 0x886280 = [sp+4] = 0, 0x886284 = [sp+8];
 * иначе 0x886280 = [sp+0xc] без бита 4, 0x886284 = 0.
 * Баг vendor: [sp+0xc] не инициализирован — биты вне 0..4 и 8..12 из стека. Берём 0:
 * на стенде у vendor после (2, 0, 0x3f) 0x886280 = 0x1f00, т. е. мусорные биты там 0.
 * Ассерты (коды с bset 12): c < b → 0x100f; a == 1 и c >= 8 → 0x1010; a != 1 и
 * c >= 0x40 → 0x1011. Прежний порт: поле a & 1, s8_w5 только при a == 1, данные из
 * других ячеек и одна запись вместо цикла b..c. */
__attribute__((section(".textlate"))) void mac_filter_write_entries(u32 a, u32 b, u32 c)
{
    u16 cmd = 0;
    u32 fr[2];          /* [sp+4], [sp+8] */
    u32 w3 = 0;         /* [sp+0xc] (у vendor — неинициализированный стек) */
    u32 n;

    bits_set16h_s0_w2(&cmd, 1);
    mac_filter_bits_set16h_s4_w2(&cmd, a & 3u);
    memset0_words(fr, 8);
    bits_set16h_s4_w5((u8 *)fr + 6, 0x1f);
    bits_set_s8_w5(&w3, 0x1f);
    bits_set32_s0_w4(&w3, 0);

    MMIO32(HW_PRS_TBL_A_CMD) = ((u32)cmd << 16) | 0x80000000u;
    if (a == 1) {
        MMIO32(HW_PRS_TBL_A_DATA0) = fr[0];
        MMIO32(HW_PRS_TBL_A_DATA1) = fr[1];
    } else {
        MMIO32(HW_PRS_TBL_A_DATA0) = w3 & ~(1u << 4);
        MMIO32(HW_PRS_TBL_A_DATA1) = 0;
    }

    if (c < b)
        fw_sysassert_fatal(__builtin_return_address(0), 0x100f);
    if (a == 1) {
        if (c >= 8)
            fw_sysassert_fatal(__builtin_return_address(0), 0x1010);
    } else {
        if (c >= 0x40)
            fw_sysassert_fatal(__builtin_return_address(0), 0x1011);
    }
    if (c < b)
        return;
    for (n = c - b + 1; n >= 1; n--, b++) {
        MMIO32(HW_PRS_TBL_A_ADDR) = b;
        MMIO32(HW_PRS_TBL_A_CTRL) = 0x40000000u;
        arc_sync();
        while (MMIO32(HW_PRS_TBL_A_CTRL) & (1u << 29)) { }
    }
}

/* mac_parser__init (0x8df778). */
__attribute__((section(".textlate"))) void mac_parser_init(u32 obj)
{
    mac_parser_rule_a();
    mac_parser_set_default_ctrl();
    mac_parser_step_a(obj);
    mac_parser_rule_b(obj);
    mac_parser_step_b(obj);
    mac_parser_install_default_rules(obj);
    hwd_mac_parser_set_rx_filter(obj, 0);
}

/* --- Wilocity vendor-specific IE: обход TLV-списка (0x8df7ac, 60 Б). ---
 * buf — ссылка на элемент в записи разбора (struct ie_ref: длина, указатель на тело).
 * Тело: 3-байтовый OUI, затем TLV (struct wil_vs_tlv): type (u16 LE по байтам), len
 * (u16 LE по байтам), данные. a0 не используется (вендор перезаписывает r0). */
__attribute__((section(".textlate"))) const struct wil_vs_tlv *parse_wilocity_vs_find_tlv(
    u32 a0, const struct ie_ref *buf, u32 type)
{
    (void)a0;
    const u8 *data = buf->body;
    u32 len = buf->len;
    u32 idx = 3;
    const struct wil_vs_tlv *cur = (const struct wil_vs_tlv *)(data + 3);
    for (;;) {
        if ((s32)idx >= (s32)len)
            return 0;
        u32 t = (u32)(cur->type[1] << 8) | cur->type[0];
        if ((s32)(s16)(u16)t == (s32)(s16)(u16)type)
            return cur;
        u32 l = (u32)(cur->len[1] << 8) | cur->len[0];
        idx += l + 4;
        cur = (const struct wil_vs_tlv *)(data + idx);
    }
}

/* parse_wilocity_vs__get_flag3 (0x8df8ec, 28 Б): TLV type 3, вернуть val[0] == 1. */
__attribute__((section(".textlate"))) u32 parse_wilocity_vs_get_flag3(u32 a0, const struct ie_ref *buf)
{
    const struct wil_vs_tlv *tlv = parse_wilocity_vs_find_tlv(a0, buf, 3);
    if (tlv == 0)
        return 0;
    return (tlv->val[0] == 1) ? 1u : 0u;
}

/* parse_wilocity_vs_get_version (0x8df8cc, 32 Б): TLV type 5, вернуть val[0]. */
__attribute__((section(".textlate"))) u32 parse_wilocity_vs_get_version(u32 a0, const struct ie_ref *buf)
{
    const struct wil_vs_tlv *tlv = parse_wilocity_vs_find_tlv(a0, buf, 5);
    if (tlv == 0) {
        fw_log_emit0(0x2b, 0x100c880);
        return 0;
    }
    return tlv->val[0];
}

/* parse_wilocity_vs_get_features_version_tracking (0x8df7e8, 60 Б): TLV type 7,
 * вернуть 16-битное значение (ldw по адресу TLV + 4). */
__attribute__((section(".textlate"))) u32 parse_wilocity_vs_get_features_version_tracking(u32 a0,
                                                                                       const struct ie_ref *buf)
{
    const struct wil_vs_tlv *tlv = parse_wilocity_vs_find_tlv(a0, buf, 7);
    if (tlv == 0) {
        fw_log_emit0(0x2b, 0x100c77c);
        return 0;
    }
    u32 w = wil_vs_tlv_val16(tlv);
    fw_log_emit3(0x2b, 0x100c7b8, w, (u32)tlv->val[0], (u32)tlv->val[1]);
    return w;
}

/* set_old_wilocity_vs (0x8e69e0, 108 Б): собрать "старый" Wilocity VS-блок в
 * dst->vs_old (mid_bss+0x10e). При src == 0 — OUI 00:aa:6c, байты платы
 * (plat_board_info->publish_id), cap = a2, net_type = a3; иначе — 12 Б из src.
 * Порт-баг (исправлен): vendor «add3 r13,r0,0x20» — это r0 + 0x100 (add3 сдвигает на 3),
 * а порт брал dst + 0x20 и писал блок в mid_bss+0x2e — поверх байтов 8..19 SSID. */
__attribute__((section(".textlate"))) void set_old_wilocity_vs(struct mid_bss *dst, const struct wil_vs_old *src,
                                                               u32 a2, u32 a3)
{
    if (src == 0) {
        /* volatile: побайтные stb, как у vendor (иначе gcc сливает соседние байты в sth) */
        volatile struct wil_vs_own *o = &dst->vs_old;
        const u8 *id = plat_board_info->publish_id;   /* [gp,-0x18] */
        o->oui[0] = 0;
        o->oui[1] = 0xaa;
        o->oui[2] = 0x6c;
        o->rsv_03 = 0;
        o->board[0] = id[0];
        o->board[1] = id[1];
        o->board[2] = id[2];
        o->board[3] = id[3];
        o->cap = (u16)a2;
        o->net_type = (u16)a3;
        fw_log_emit3(0x2b, 0x100c6d8, (u32)(u16)a3, (u32)id[0], (u32)id[1]);
    } else {
        fw_log_emit3(0x2b, 0x100c6d8, wil_vs_old_net_type16(src), (u32)src->board[0], (u32)src->board[1]);
        memcpy_fw(&dst->vs_old, src, 0xc);
    }
}
