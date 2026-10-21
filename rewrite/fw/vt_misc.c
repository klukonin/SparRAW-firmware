// SPDX-License-Identifier: AGPL-3.0-or-later
/* Методы таблиц из vendor fw_data без отдельной подсистемы (порт vendor 6.2):
 *   - eapol_frame_builder::build (0x8f15ec) — метод [1] таблицы 0x8006f4 (объект — слово
 *     0x8002f0, его ставит конструктор 0x8c1928; vendor больше нигде его не читает) и
 *     помощники 802.11/LLC (0x8d7cec, 0x8d7d90, поля полуслов 0x8ed2f8/0x8ed310);
 *   - rx_pkt_srvs::dispatch_thunk (0x8ed58c) — метод [1] таблицы 0x800880 второй базы
 *     объекта RX-служб (0x842844): this − 4 → rx_pkt_srvs__dispatch.
 */
#include "../include/types.h"
#include "../include/ieee80211.h"
#include "../include/conn.h"
#include "../include/fwdata.h"


/* bits__set16h_s2_w2 (0x8ed2f8): поле [2..3] полуслова (bf__insert_field_fw: r10 — сдвиг,
 * r11 — ширина − 1). */
static void bits_set16h_s2_w2(u16 *p, u32 v)
{
    *p = (u16)((*p & ~(0x3u << 2)) | ((v & 0x3u) << 2));
}

/* bits__set16h_s4_w4 (0x8ed310): поле [4..7] полуслова. */
static void bits_set16h_s4_w4(u16 *p, u32 v)
{
    *p = (u16)((*p & ~(0xfu << 4)) | ((v & 0xfu) << 4));
}

/* wlan_hdr__build_qos_data (0x8d7cec; vendor-имя tx_hdr_build_step): 802.11 QoS-заголовок
 * (0x1a Б) в buf: Frame Control — протокол 0, тип 2 (data), подтип subtype; Duration 0;
 * to_ds == 1 — ToDS, адреса {a4, a3, a2}, иначе FromDS, адреса {a2, a4, a3}; Sequence 0;
 * QoS Control: TID tid, остальные поля (биты 4..7, 9) — 0. Возврат — длина 0x1a. */
static u32 wlan_hdr_build_qos_data(u8 *buf, u32 subtype, const u8 *a2, const u8 *a3,
                                   const u8 *a4, u32 to_ds, u32 tid)
{
    struct ieee80211_qos_hdr *h = (struct ieee80211_qos_hdr *)buf;
    u16 *fc = &h->h.fc;
    u16 *qos = &h->qos_ctrl;

    bits_set16h_s0_w2(fc, 0);
    bits_set16h_s4_w4(fc, subtype & 0xf);
    bits_set16h_s2_w2(fc, 2);
    h->h.duration = 0;
    if (to_ds == 1) {
        *fc = (u16)(*fc | (1u << 8));
        memcpy_fw(h->h.addr1.b, a4, 6);
        memcpy_fw(h->h.addr2.b, a3, 6);
        memcpy_fw(h->h.addr3.b, a2, 6);
    } else {
        *fc = (u16)(*fc | (1u << 9));
        memcpy_fw(h->h.addr1.b, a2, 6);
        memcpy_fw(h->h.addr2.b, a4, 6);
        memcpy_fw(h->h.addr3.b, a3, 6);
    }
    h->h.seq = 0;
    *qos = 0;
    bits_set16h_s5_w2(qos, 0);
    *qos = (u16)(*qos & ~((1u << 7) | (1u << 4) | (1u << 9)));
    bits_set16h_s0_w4(qos, tid & 0xf);
    return 0x1a;
}

/* llc_snap__write_header (0x8d7d90): LLC/SNAP AA AA 03 00 00 00 + EtherType; возврат 8.
 * EtherType vendor кладёт младшим байтом вперёд (sth в кадр, затем побайтно) — для
 * 0x888e получается 8e 88, а не сетевой порядок 88 8e. Единственный вызов — из
 * eapol_frame_builder::build, который в vendor недостижим (см. шапку), поэтому
 * повторено как есть. */
static u32 llc_snap_write_header(u8 *p, u32 ethertype)
{
    p[0] = 0xaa;
    p[1] = 0xaa;
    p[2] = 3;
    p[3] = 0;
    p[4] = 0;
    p[5] = 0;
    p[6] = (u8)ethertype;
    p[7] = (u8)(ethertype >> 8);
    return 8;
}

/* eapol_frame_builder::build (0x8f15ec): кадр EAPOL в buf (0xc4 Б обнуляются): QoS-data
 * заголовок (TID 7) с адресами соединения ctx (DA — MAC пира, SA — свой MAC записи mid,
 * BSSID — bss.bssid; to_ds — направление), LLC/SNAP 0x888e, затем тело src/len. *out_len —
 * полная длина; журнал адресов (vendor читает MAC словом + полусловом, SA — по адресу
 * mid+0xa, не выровненному на 4) и дампы заголовков/кадра. ctx->mid == 0 — ассерт 0x1184
 * (vendor идёт дальше). Возврат 0. */
u32 eapol_frame_builder_build(u32 obj, u8 *buf, u32 *out_len, struct conn *ctx,
                                                u32 to_ds, const void *src, u32 len)
{
    struct mid *peer;
    u32 hlen, n;
    u8 *da, *sa, *bssid, *p;

    (void)obj;
    *out_len = 0;
    peer = ctx->mid;
    if (peer == 0)
        fw_sysassert_fatal(__builtin_return_address(0), 0x1184);
    memset0_words(buf, 0xc4);
    da = ctx->peer;
    sa = peer->mac;
    bssid = peer->bss.bssid;
    fw_log_emit2(0x2d, 0x10141a4, ((const union mac_addr *)da)->h[2], mac_lo32((const union mac_addr *)da));
    fw_log_emit2(0x2d, 0x10141b8, ((const union mac_addr *)sa)->h[2], mac_lo32((const union mac_addr *)sa));
    fw_log_emit2(0x2d, 0x10141cc, ((const union mac_addr *)bssid)->h[2],
                 mac_lo32((const union mac_addr *)bssid));
    hlen = (u16)wlan_hdr_build_qos_data(buf, 8, da, sa, bssid, to_ds, 7);
    p = buf + hlen;
    n = (u16)llc_snap_write_header(p, 0x888e);
    hlen = (u16)(hlen + n);
    p += n;
    fw_log_emit1(0x2d, 0x10141e0, hlen);
    hexdump_words(buf, hlen);
    memcpy_fw(p, src, len);
    *out_len = (u16)(hlen + len);
    fw_log_emit1(0x2d, 0x1014210, *out_len);
    hexdump_words(buf, *out_len);
    fw_log_emit0(0x2d, 0x1014240);
    return 0;
}

/* 0x8006f4: таблица методов eapol_frame_builder (include/ieee80211.h). */
FWDATA(8006f4) const struct eapol_builder_vt eapol_builder_vtbl = {
    .build = eapol_frame_builder_build,        /* vendor 0x8f15ec */
};

/* rx_pkt_srvs::dispatch_thunk (0x8ed58c): метод второй базы (this = 0x842844) →
 * rx_pkt_srvs__dispatch(this − 4, pkt). */
void rx_pkt_srvs_dispatch_thunk(const struct rx_pkt_srvs_vt2 **base2, struct rx_pkt *pkt)
{
    rx_pkt_srvs_dispatch((struct rx_pkt_srvs *)((u8 *)base2 - __builtin_offsetof(struct rx_pkt_srvs, vt2)),
                         pkt);
}
