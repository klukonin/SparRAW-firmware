// SPDX-License-Identifier: AGPL-3.0-or-later
/* Разбор принятого mgmt-кадра (rx_mgmt__prepare 0x8e3c3c и rx_mgmt_prs 0x8de190).
 *
 * Запись разбора — struct rx_mgmt_ei (include/ieee80211.h; 5 штук в rx_pkt_srvs.ei,
 * у пакета — pkt->ei): ссылки на IE {eid, len, тело} и указатели на поля
 * фиксированной части в теле кадра.
 * .textlate. */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/ieee80211.h"
#include "../include/fwdata.h"


/* Поле IE в записи разбора: eid, длина, указатель на тело. */
static void ei_slot_set(struct ie_ref *slot, u32 eid, u32 len, u8 *p)
{
    slot->body = p;
    slot->len = (u8)len;
    slot->eid = (u8)eid;
}

/* 0x802c74: таблица переходов vendor set_parse_ei (0x8e6a54): ldb.x, 56 записей, цель = 0x8e6a84 + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(802c74) __attribute__((aligned(1))) const u8 set_parse_ei_jt0[56] = {
    0x2e, 0x3d, 0xe6, 0xe6, 0xe6, 0xe6, 0xe6, 0x42, 0xe6, 0xe6, 0xe6, 0xe6,
    0x4a, 0xe6, 0xe6, 0xe6, 0xe6, 0xe6, 0xe6, 0xe6, 0xe6, 0xe6, 0xe6, 0xe6,
    0xe6, 0xe6, 0xe6, 0xe6, 0xe6, 0xe6, 0xe6, 0xe6, 0xe6, 0xe6, 0xe6, 0xe6,
    0xe6, 0xe6, 0xe6, 0xe6, 0xe6, 0xe6, 0xe6, 0xe6, 0xe6, 0xe6, 0xe6, 0xe6,
    0x56, 0xe6, 0xe6, 0xe6, 0xe6, 0xe6, 0xe6, 0xe6,
};

/* 0x802cac: таблица переходов vendor set_parse_ei (0x8e6a54): ldb.x, 9 записей, цель = 0x8e6ab8 + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(802cac) __attribute__((aligned(1))) const u8 set_parse_ei_jt1[9] = {
    0xcc, 0xb9, 0xcc, 0xcc, 0xcc, 0x45, 0xcc, 0xcc, 0x4f,
};

/* 0x802cb8: таблица переходов vendor set_parse_ei (0x8e6a54): ldb.x, 9 записей, цель = 0x8e6ae0 + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(802cb8) __attribute__((aligned(1))) const u8 set_parse_ei_jt2[9] = {
    0xb8, 0xb8, 0xb8, 0xb8, 0x99, 0x4d, 0xb8, 0xb8, 0xb8,
};

/* set_parse_ei (0x8e6a54, 512 Б): занести IE eid (тело p, длина len) в запись ei.
 * Возврат: 0 — занесён (или известен и пропущен), 1 — неизвестен / не нужен,
 * -1 — повтор IE (кроме 0x94: повтор молча пропускается). rem — остаток кадра после
 * заголовка IE (только журнал), type — тип кадра (журнал повтора SSID).
 * Таблицы переходов 0x802c74 (eid 0..0x37), 0x802cac (0x8f..0x97), 0x802cb8 (0x99..0xa1)
 * — ветви switch ниже. */
__attribute__((section(".textlate"))) s32 set_parse_ei(struct rx_pkt_srvs *ctx, u8 *p, struct rx_mgmt_ei *ei,
                                                       u32 eid, u32 len, u32 rem, u32 type)
{
    const u8 *b = p;
    struct ie_ref *slot;
    (void)ctx;
    switch (eid) {
    case 0x00:                                              /* SSID */
        if (ei->ssid.body != 0) {
            fw_log_emit3(0xd, 0x1014120, 0, type, len);
            return -1;
        }
        ei_slot_set(&ei->ssid, 0, len, p);
        return 0;
    case 0x01: slot = &ei->rates; break;                    /* Supported Rates */
    case 0x07: slot = &ei->country; break;                  /* Country */
    case 0x0c: slot = &ei->ie_0c; break;
    case 0x30: slot = &ei->rsn; break;                      /* RSN */
    case 0x90:                                              /* Extended Schedule */
        if (ei->ext_sched.body != 0)
            return -1;
        ei_slot_set(&ei->ext_sched, 0x90, len, p);
        fw_log_emit3(0x2d, 0x1014150, 0x90, len, rem);
        return 0;
    case 0x94:                                              /* DMG Capabilities */
        if (ei->dmg_cap.body == 0)
            ei_slot_set(&ei->dmg_cap, 0x94, len, p);
        return 0;
    case 0x97: slot = &ei->dmg_op; break;                   /* DMG Operation */
    case 0x9d: slot = &ei->ie_9d; break;
    case 0x9e: slot = &ei->multi_band; break;               /* Multi-band */
    case 0xbe: slot = &ei->ie_be; break;
    case 0xdd:                                              /* Vendor Specific */
        if (b[0] == 0x00 && b[1] == 0xaa && b[2] == 0x6c) {  /* Wilocity, старый формат */
            ei_slot_set(&ei->vs_wil_old, eid, len, p);
            ei->vs_wil.body = 0;
            return 0;
        }
        if (b[0] == 0x04 && b[1] == 0xce && b[2] == 0x14) {  /* Wilocity */
            ei_slot_set(&ei->vs_wil, eid, len, p);
            ei->vs_wil_old.body = 0;
            return 0;
        }
        if (b[0] == 0x50 && b[1] == 0x6f && b[2] == 0x9a && b[3] == 0x09)   /* WFA P2P */
            return 0;
        if (b[0] == 0x00 && b[1] == 0x50 && b[2] == 0xf2 && b[3] == 0x04)   /* WPS */
            return 0;
        return 1;
    default:                                                /* в т. ч. 0x38, 0x3d, 0x66, 0x98 */
        fw_log_emit2(0x1d, 0x1014180, eid, len);
        return 1;
    }
    if (slot->body != 0)
        return -1;
    ei_slot_set(slot, eid, len, p);
    return 0;
}

/* Счёт поля фиксированной части: +1 к числу полей записи, сдвиг указателя и остатка. */
#define PRS_FIELD(n) do { ei->nfields += 1; len -= (n); p += (n); } while (0)

/* rx_mgmt_prs_step (0x8de0fc, 148 Б): фиксированная часть DMG-бикона (extension-кадр,
 * подтип 0): Timestamp (8), SSW (3), Beacon Interval (2), BI Control (6), DMG Parameters
 * (1), при бите 0 BI Control — Clustering Control (8). *len уменьшается на размер
 * фиксированной части, *cnt — её размер в байтах. */
__attribute__((section(".textlate"))) u32 rx_mgmt_prs_step(struct rx_pkt_srvs *ctx, u8 *p, struct rx_mgmt_ei *ei, s32 *len, u8 *cnt)
{
    s32 n = *len - 0x14;
    (void)ctx;
    ei->nfields = 0;
    *cnt = 0;
    ei->timestamp = p;                ei->nfields += 1; *cnt += 8;
    ei->ssw = p + 0x8;                ei->nfields += 1; *cnt += 3;
    ei->bcn_int = p + 0xb;            ei->nfields += 1; *cnt += 2;
    ei->bi_ctrl = p + 0xd;            ei->nfields += 1; *cnt += 6;
    ei->dmg_params = p + 0x13;        ei->nfields += 1; *cnt += 1;
    if (p[0xd] & 1u) {
        ei->clustering = p + 0x14;
        n -= 8;
        ei->nfields += 1;
        *cnt += 8;
    }
    *len = n;
    return 1;
}

/* 0x802c68: таблица переходов vendor rx_mgmt_prs__parse (0x8de190): ldb.x, 11 записей, цель = 0x8de1e0 + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(802c68) __attribute__((aligned(1))) const u8 rx_mgmt_prs_parse_jt[11] = {
    0x1c, 0x2c, 0x1c, 0x2c, 0x6a, 0x00, 0x57, 0x57, 0x57, 0x57, 0x52,
};

/* rx_mgmt_prs__parse (0x8de190, 468 Б): разбор тела mgmt-кадра p (длина len без
 * 802.11-заголовка) в запись ei: фиксированная часть по подтипу (таблица 0x802c68 —
 * switch ниже), затем IE до остатка < 3 Б (set_parse_ei). Возврат 1 — разобран, 0 —
 * ошибка IE (журнал и дамп кадра). Подтипы 6..9 и ≥ 11 не-extension кадра — журнал,
 * дамп и ассерт 0x10a6, затем разбор IE как у vendor. */
__attribute__((section(".textlate"))) u32 rx_mgmt_prs_parse(struct rx_pkt_srvs *ctx, u8 *p, struct rx_mgmt_ei *ei,
                                                            s32 len, u32 subtype, u32 type)
{
    s32 len0 = len;
    u8 cnt = 0;
    ei->nfields = 0;
    if (type == 3) {
        if (subtype == 0) {
            rx_mgmt_prs_step(ctx, p, ei, &len, &cnt);
            p += cnt;
        }
    } else {
        switch (subtype) {
        case 0:                                             /* Association Request */
        case 2:                                             /* Reassociation Request */
            ei->capability = p;                             /* Capability */
            PRS_FIELD(2);
            ei->listen_int = *(u16 *)p;                     /* Listen Interval */
            PRS_FIELD(2);
            break;
        case 1:                                             /* Association Response */
        case 3:                                             /* Reassociation Response */
            ei->capability = p;                             /* Capability */
            PRS_FIELD(2);
            ei->status = *(u16 *)p;                         /* Status Code */
            PRS_FIELD(2);
            ei->aid = *(u16 *)p;                            /* AID */
            PRS_FIELD(2);
            break;
        case 4:                                             /* Probe Request */
            break;
        case 5:                                             /* Probe Response */
            ei->timestamp = p;                              /* Timestamp */
            PRS_FIELD(8);
            ei->bcn_int = p;                                /* Beacon Interval */
            PRS_FIELD(2);
            ei->capability = p;                             /* Capability */
            PRS_FIELD(2);
            break;
        case 10:                                            /* Disassociation */
            ei->status = *(u16 *)p;                         /* Reason Code */
            PRS_FIELD(2);
            break;
        default:
            fw_log_emit3(0xd, 0x101405c, subtype, type, (u32)len0);
            hexdump_words(p, (u32)len0);
            fw_sysassert_fatal(0, 0x10a6);
            break;
        }
    }
    ei->ies = p;
    ei->vs_wil_old.len = 0;
    ei->vs_wil_old.body = 0;
    ei->vs_wil.len = 0;
    ei->vs_wil.body = 0;
    while (len >= 3) {
        u32 eid = p[0];
        u32 elen = p[1];
        p += 2;
        len -= 2;
        if (set_parse_ei(ctx, p, ei, eid, elen, (u32)len, type) & 0x80000000u) {
            fw_log_emit3(0x2d, 0x1014094, type, subtype, (u32)len0);
            fw_log_emit3(0x2d, 0x10140c4, eid, elen, (u32)len);
            hexdump_words(p, (u32)len0);
            return 0;
        }
        len -= (s32)elen;
        ei->nfields += 1;
        p += elen;
        if (len < 0) {
            fw_log_emit2(0xd, 0x10140ec, eid, elen);
            return 0;
        }
    }
    return 1;
}

/* rx_mgmt__find_free_ei (0x8c3370, 36 Б): свободная запись разбора таблицы ctx->ei —
 * пометить занятой (1) и вернуть; нет — 0. */
__attribute__((section(".textlate"))) struct rx_mgmt_ei *rx_mgmt_find_free_ei(struct rx_pkt_srvs *ctx)
{
    u32 i;
    for (i = 0; i < RX_MGMT_EI_N; i++) {
        struct rx_mgmt_ei *e = &ctx->ei[i];
        if (e->busy == 0) {
            e->busy = 1;
            return e;
        }
    }
    return 0;
}

/* rx_mgmt_prs__alloc_ei (0x8e0a84, 166 Б): запись разбора в pkt->ei (нет — журнал,
 * ассерт 0x10a2, возврат 0), снять 802.11-заголовок (pkt->body += 0x18 при info.qid = 0,
 * += 0xa при 1, иначе ассерт 0x10a3), подтип в info.stype, дамп кадра (кроме
 * extension), разбор тела и счётчик [gp,0x270] = 0x8003f4. Метод [1] таблицы 0x800874
 * объекта rx_pkt_srvs (разбор mgmt-кадра). */
u32 rx_mgmt_prs_alloc_ei(struct rx_pkt_srvs *ctx, struct rx_pkt *pkt)
{
    u32 len = pkt->info.len;
    u8 *buf = pkt->body;
    u32 hdr = 0, fc;
    struct rx_mgmt_ei *ei = rx_mgmt_find_free_ei(ctx);
    pkt->ei = ei;
    if (ei == 0) {
        fw_log_emit0(0xd, 0x1014034);
        fw_sysassert_fatal(0, 0x10a2);
        return 0;
    }
    switch (pkt->info.qid) {
    case 0:
        hdr = IEEE80211_HDR_LEN;
        pkt->body += IEEE80211_HDR_LEN;
        break;
    case 1:
        hdr = IEEE80211_HDR_SHORT_LEN;
        pkt->body += IEEE80211_HDR_SHORT_LEN;
        break;
    default:
        fw_sysassert_fatal(0, 0x10a3);
        break;
    }
    fc = pkt->hdr->fc;
    pkt->info.stype = (u16)FC_STYPE(fc);
    if (FC_TYPE(fc) != FC_TYPE_EXT)
        hexdump_words(buf, len);
    fc = pkt->hdr->fc;
    rx_mgmt_prs_parse(ctx, pkt->body, pkt->ei, (s32)(pkt->info.len - hdr),
                      FC_STYPE(fc), FC_TYPE(fc));
    rx_mgmt_parsed_count += 1;
    return 1;
}

/* rx_mgmt__prepare (0x8e3c3c, 12 Б): разбор кадра в таблицу записей rx_pkt_srvs. */
__attribute__((section(".textlate"))) void rx_mgmt_prepare(struct rx_pkt *pkt)
{
    rx_mgmt_prs_alloc_ei(&rx_pkt_srvs, pkt);
}
