// SPDX-License-Identifier: AGPL-3.0-or-later
/* tx_api: отправка mgmt-пакетов (TX_API__send_packet + обвязка).
 * Портировано из вендора (fw, ARC600, база 0x8c0000):
 *   - tx_api__get_mgmt_retry_limit (0x8cc3d0)
 *   - tx_api__send_mgmt           (0x8e5874)
 *   - TX_API__send_packet         (0x8e58a4, 11 аргументов)
 *   - tx_api__stamp_seq_bytes     (0x8c84ec)
 *   - tx_api__bits_set8_s0_w6 (0x8ed250) / bits__set8_s6_w2 (0x8ed2bc)
 * Все функции — новые → .textlate.
 */
#include "../include/types.h"
#include "../include/fwq_tx.h"
#include "../include/conn.h"
#include "../include/mid.h"
#include "../include/ieee80211.h"
#include "../include/fwdata.h"


/* уже портированы / стабы */

/* bits__set16h_s0_w4 (0x8ed2ec, 12 Б): поле [0..3] полуслова. */
__attribute__((section(".textlate"))) void bits_set16h_s0_w4(u16 *p, u32 v)
{ *p = (u16)((*p & ~0xfu) | (v & 0xfu)); }

/* bits__set16h_s5_w2 (0x8ed328, 12 Б): поле [5..6] полуслова. */
__attribute__((section(".textlate"))) void bits_set16h_s5_w2(u16 *p, u32 v)
{ *p = (u16)((*p & ~(0x3u << 5)) | ((v & 0x3u) << 5)); }


/* mid__lookup_for_tx (0x8c7548, 104 Б): найти в списке соединений записи mid соединение
 * с данным cid и скопировать MAC пира (6 Б) в out. */
__attribute__((section(".textlate"))) void mid_lookup_for_tx(struct mid *mid, u32 cid, u8 *out)
{
    u32 it;
    if (mid->conns.count == 0)
        fw_sysassert_fatal(0, 0x11ed);
    iter_init(&it, &mid->conns);
    while (list_has_items(&it)) {
        struct conn *e = iter_next(&it);
        if (e->cid == (u8)cid) {
            memcpy_fw(out, e->peer, 6);  /* mid__copy_mac_addr */
            return;
        }
    }
    fw_sysassert_fatal(0, 0x11ee);
}

/* tx_send_packet_step (0x8c736c, 132 Б): собрать тестовый FW2FW MAC-заголовок
 * payload[4..0x1a): RA/TA/BSSID + seq/descriptor. */
__attribute__((section(".textlate"))) void tx_send_packet_step(struct ieee80211_qos_hdr *q, u32 a1, u32 cid, u32 a3)
{
    u8 buf[0x18];
    struct mid *mid = mid_list_by_mid_fw(a1);
    mac_hdr_copy_addr(mid, buf);                          /* TA */
    mid_copy_bssid(&mid->bss, buf + 8);                   /* BSSID */
    mid_lookup_for_tx(mid, cid, buf + 0x10);              /* RA */
    memcpy_fw(q->h.addr1.b, buf + 0x10, 6);
    memcpy_fw(q->h.addr2.b, buf, 6);
    memcpy_fw(q->h.addr3.b, buf + 8, 6);
    q->h.seq = 0;
    q->qos_ctrl = 0;
    bits_set16h_s5_w2(&q->qos_ctrl, 0);                   /* ACK policy */
    {
        u16 w = q->qos_ctrl;
        w &= (u16)~(1u << 7);                             /* A-MSDU present */
        w &= (u16)~(1u << 4);                             /* EOSP */
        w &= (u16)~(1u << 9);
        q->qos_ctrl = w;
    }
    bits_set16h_s0_w4(&q->qos_ctrl, a3 & 0xfu);           /* TID */
}

/* tx_api__get_mgmt_retry_limit (0x8cc3d0, 4 Б): байт [gp+0xd3] = 0x800257. */
__attribute__((section(".textlate"))) u8 tx_api_get_mgmt_retry_limit(void)
{
    return tx_mgmt_retry_limit;
}

/* TX_API__send_packet (0x8e58a4, 11 аргументов) — объявление. */

/* tx_api__send_mgmt (0x8e5874, 48 Б): тонкая обёртка — читает retry_limit и
 * зовёт TX_API__send_packet, пробрасывая a5→a9, a6→a10, a8=0. */
__attribute__((section(".textlate"))) void tx_api_send_mgmt(struct conn *a0, u32 a1, u32 a2, u32 a3, u32 a4, tx_done_fn a5, u32 a6)
{
    u32 retry = tx_api_get_mgmt_retry_limit();
    tx_api_send_packet(a0, a1, a2, a3, a4, retry, 0, 0, 0, a5, a6);
}

/* tx_api__stamp_seq_bytes (0x8c84ec, 80 Б): заполнить dst[0..len) байтами
 * start, start+1, ... (по модулю 256). У vendor хвост len & 3 при len >= 4 не пишется
 * (8c8522: индекс сравнивается с len & 3, а не с len) — данные тестового кадра, буфер
 * обнулён при выделении; здесь пишутся все len байт. */
__attribute__((section(".textlate"))) void tx_api_stamp_seq_bytes(u8 *dst, u8 start, u32 len)
{
    u32 i;
    for (i = 0; i < len; i++)
        dst[i] = (u8)(start + i);
}

/* tx_api__bits_set8_s0_w6 (0x8ed250): поле [0..5] байта. */
__attribute__((section(".textlate"))) void tx_api_bits_set8_s0_w6(u8 *p, u32 v)
{
    *p = (u8)((*p & ~0x3fu) | (v & 0x3fu));
}

/* bits__set8_s6_w2 (0x8ed2bc): поле [6..7] байта. */
__attribute__((section(".textlate"))) void bits_set8_s6_w2(u8 *p, u32 v)
{
    *p = (u8)((*p & ~0xc0u) | ((v & 0x3u) << 6));
}



/* 0x8031c0: таблица переходов vendor TX_API__send_packet (0x8e58a4): ldb.x, 5 записей, цель = 0x8e59ee + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(8031c0) __attribute__((aligned(1))) const u8 tx_api_send_packet_jt[5] = {
    0x0d, 0x00, 0x03, 0x07, 0x0a,
};

/* TX_API::send_packet (0x8e58a4, 388 Б, 11 аргументов): заголовок кадра (payload-0x24)
 * и постановка в очередь fwq_tx.
 *   a0 conn, a1 канал (0/1), a2 очередь (1 — управление 0x842154, 2 — данные 0x842274),
 *   a3 payload, a4 длина, a5 лимит повторов, a6/a7 счётчик и шаг повторов (+0x13/+0x12),
 *   a8 приоритет (6 бит), a9 обработчик завершения, a10 категория.
 * Категория → флаги [+0xc] (jump-table 0x8031c0): 1 → бит 0, 2 → биты 1|3, 3 → бит 2,
 * 4 → бит 3 (прежний порт сдвигал на единицу). Длина и [+0xc] — 16 бит (stw). */
void tx_api_send_packet(struct conn *conn, u32 channel_type, u32 api_sel, u32 payload, u32 len,
                        u32 retry_limit, u32 a6, u32 a7, u32 a8, tx_done_fn a9, u32 a10)
{
    struct tx_pkt *pkt;
    struct fwq_tx *tx_api;
    u8 cid;

    if (payload == 0)
        fw_sysassert_fatal(0, 0x11e9);
    pkt = TX_PKT_OF(payload);
    if (conn == 0)
        fw_sysassert_fatal(0, 0x1220);
    cid = conn->cid;

    if (api_sel == 1) {
        tx_api = &tx_api_mgmt;
    } else if (api_sel == 2) {
        if (tx_fw2fw_test != 0) {
            /* тестовый FW2FW-кадр: заголовок данных + последовательность байт */
            u32 orig_len = len;
            struct ieee80211_qos_hdr *q = (struct ieee80211_qos_hdr *)payload;
            tx_send_packet_step(q, 0, cid, 7);
            q->h.fc = 0x88;                         /* QoS Data */
            len = (u16)(orig_len + IEEE80211_QOS_HDR_LEN);
            tx_api_stamp_seq_bytes((u8 *)q + IEEE80211_QOS_HDR_LEN, 0, orig_len);
            fw_log_emit3(0x27, 0x1018450, cid, channel_type, len);
            tx_fw2fw_test = 0;
        }
        tx_api = &tx_api_data;
    } else {
        fw_sysassert_fatal(0, 0x1221);
        return;
    }

    if (pkt->status == 0xfd) {
        /* кадр — буфер ошибки (пул пуст): обработчику статус 0xfd через планировщик */
        fw_log_emit1(0x27, 0x1018494, (u32)a9);
        /* аргументы задачи u_schd — u32: обработчик передаётся числом (разбор — в
         * tx_api_call_mem_pool_alloc_err_cb) */
        if (a9 != 0)
            u_schd_add(tx_api_call_mem_pool_alloc_err_cb, (u32)a9, (u32)conn, 1);
        return;
    }

    pkt->len = (u16)len;
    pkt->done = a9;
    pkt->sent_cb = 0;
    pkt->sent_info = 0;
    pkt->retry_limit = (u8)retry_limit;
    tx_api_bits_set8_s0_w6(&pkt->prio_ch, a8 & 0x3fu);
    pkt->cid = cid;
    bits_set8_s6_w2(&pkt->prio_ch, channel_type & 0x3u);
    pkt->retry_timer = 0;
    pkt->retries_left = (u8)a6;
    pkt->owner = 0;
    pkt->retry_backoff = (u8)a7;
    pkt->cat = 0;

    if (a10 != 0)
        fw_log_emit1(0x27, 0x101851c, a10);
    switch (a10) {                                  /* tx_op: [+0xc] словом (ld/st) */
    case 1: pkt->cat_w |= 1u; break;
    case 2: pkt->cat_w |= 2u | 8u; break;
    case 3: pkt->cat_w |= 4u; break;
    case 4: pkt->cat_w |= 8u; break;
    default: break;
    }

    if (fwq_tx_add_packet(tx_api, pkt, channel_type) == 0)
        fw_log_emit0(0x17, 0x1018540);
}
