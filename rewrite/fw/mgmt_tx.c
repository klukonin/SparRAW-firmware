// SPDX-License-Identifier: AGPL-3.0-or-later
/* mgmt_tx: сборка probe req/resp + IE-хелперы + app_ies + tx_probe.
 * Портировано из вендора (главная прошивка fw, ARC600, база 0x8c0000):
 *   - mgmt_tx__build_probe_req       (0x8e9ebc)
 *   - mgmt_tx__build_probe_resp      (0x8e9f74)
 *   - tx_mgmt_builder_srvs__tx_mgmt_scan_probe_req (0x8ea054)
 *   - tx_probe__send_probe_req       (0x8f8cf8)
 *   - tx_probe__send_probe_resp      (0x8f8c8c)
 * плюс их листовые/средние зависимости (IE-пуши, app_ies, mid-хелперы).
 * Все функции — новые → .textlate.
 */
#include "../include/types.h"
#include "../include/conn.h"
#include "../include/mid.h"
#include "../include/ieee80211.h"
#include "../include/fwdata.h"


/* уже портированы */

/* ============================================================
 * IE-пуши (листовые, без зависимостей кроме memcpy_fw/log)
 * ============================================================ */

/* ie__push_wfa_vendor (0x8e1c94, 68 Б): WFA vendor IE (eid 0xdd, len 15),
 * OUI 50:6f:9a, type 0x17, 6 байт из src, последний байт flag. Возврат 0x11. */
__attribute__((section(".textlate"))) u32 ie_push_wfa_vendor(u8 *dst, const u8 *src, u32 flag)
{
    dst[0] = 0xdd; dst[1] = 0x0f;
    dst[2] = 0x50; dst[3] = 0x6f; dst[4] = 0x9a; dst[5] = 0x17;
    dst[6] = 0x01; dst[7] = 0x09; dst[8] = 0x00; dst[9] = 0x07;
    memcpy_fw(dst + 0xa, src, 6);
    dst[0x10] = (u8)flag;
    return 0x11;
}

/* ie__push_raw (0x8e1ff0, 56 Б): копировать TLV IE (eid@0,len@1,data). */
__attribute__((section(".textlate"))) u32 ie_push_raw(u8 *dst, const u8 *src)
{
    if (src == 0) { fw_sysassert_fatal(0, 0x11d4); return 0; }
    /* vendor 0x8e1ffe: ldb_s (беззнаковый байт) + brlt r2,1 — пропуск только при len 0;
     * (s8) отбрасывал IE длиной >= 0x80. */
    if (src[1] < 1)
        return 0;
    u32 len = (u32)src[1] + 2;
    memcpy_fw(dst, src, len);
    return len;
}

/* ie__push_ssid (0x8e2028, 32 Б): SSID IE (eid 0), len, данные. */
__attribute__((section(".textlate"))) u32 ie_push_ssid(u8 *dst, const u8 *ssid, u32 len)
{
    dst[0] = 0;
    dst[1] = (u8)len;
    if (ssid != 0 && len > 0)
        memcpy_fw(dst + 2, ssid, len);
    return len + 2;
}

/* ie__push_dmg_capabilities (0x8e1fd4, 28 Б): DMG capabilities IE (eid 0x94,
 * len 17); flag пишется в src[6] до копирования. Возврат 0x13. */
__attribute__((section(".textlate"))) u32 ie_push_dmg_capabilities(u8 *dst, u8 *src, u32 flag)
{
    dst[0] = 0x94;
    dst[1] = 0x11;
    src[6] = (u8)flag;
    memcpy_fw(dst + 2, src, 0x11);
    return 0x13;
}

/* ie__push_edca (0x8e1da8, 32 Б): 0x14 байт EDCA IE объекта BSS (obj+0x12: edca_12 ..
 * edca_ac). */
__attribute__((section(".textlate"))) u32 ie_push_edca(u8 *dst, const struct mid_bss *mid)
{
    memcpy_fw(dst, &mid->edca_12, 0x14);
    fw_log_emit1(0x2d, 0x100faf4, 0x14);
    return 0x14;
}

/* ie__push_qos_capability (0x8e1f4c, 36 Б): QoS Capability IE (eid 0x2e, len 1),
 * бит 3 = QoS. Возврат 3.
 * Баг vendor (исправлен 2026-10-20): vendor делает ldb.a r2,[r0,2]; bset_s r2,r2,3 — ИЛИ с байтом
 * буфера, который никто не писал (вызывающие mlme/mgmt_tx его не задают): в эфир уходит остаток
 * памяти | 0x08 (стенд: маяк AP vendor — IE 46 = b8, наш с тем же кодом — 88). Пишем ровно 0x08. */
__attribute__((section(".textlate"))) u32 ie_push_qos_capability(u8 *dst)
{
    dst[0] = 0x2e;
    dst[1] = 0x01;
    dst[2] = 0x08;
    fw_log_emit1(0x2d, 0x100fb10, dst[2]);
    return 0x03;
}

/* ie__push_eid151_len10 (0x8e1fbc, 24 Б): eid 0x97, len 10. Возврат 0xc. */
__attribute__((section(".textlate"))) u32 ie_push_eid151_len10(u8 *dst, const u8 *src)
{
    dst[0] = 0x97;
    dst[1] = 0x0a;
    memcpy_fw(dst + 2, src, 0x0a);
    return 0x0c;
}

/* ie__push_eid190_len4 (0x8e1fa4, 24 Б): eid 0xbe, len 4. Возврат 6. */
__attribute__((section(".textlate"))) u32 ie_push_eid190_len4(u8 *dst, const u8 *src)
{
    dst[0] = 0xbe;
    dst[1] = 0x04;
    memcpy_fw(dst + 2, src, 0x04);
    return 0x06;
}

/* mgmt_tx__copy_ie_max96 (0x8e2048, 148 Б, тело 28 Б): копия до 0x60 байт. */
__attribute__((section(".textlate"))) u32 mgmt_tx_copy_ie_max96(u8 *dst, const u8 *src, u32 len)
{
    if (len > 0x60)
        fw_sysassert_fatal(0, 0x11d5);
    memcpy_fw(dst, src, len);
    return len;
}

/* push_cap_info (0x8e1d78, 48 Б): Capability Info (2 байта) из src. */
__attribute__((section(".textlate"))) u32 push_cap_info(u8 *dst, const u8 *src)
{
    u8 b = src[0];
    u32 privacy = b & 0x1u;
    u32 bss_type = (b >> 4) & 0x1u;
    fw_log_emit2(0x2d, 0x100faac, privacy, bss_type);
    memcpy_fw(dst, src, 2);
    return 2;
}

/* 0x8023c8: таблица переходов switch vendor mid__get_bcon_additional_ies (0x8cb844;
 * ldb, цель = 0x8cb860 + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(8023c8) const u8 mid_get_bcon_additional_ies_jt[9] = {
    0x00, 0x03, 0x17, 0x17, 0x07, 0x0a, 0x17, 0x17, 0x0e,
};

/* mid__get_bcon_additional_ies (0x8cb844, 96 Б): блок дополнительных IE хоста
 * (WMI_SET_APPIE) по подтипу кадра — таблица переходов 0x8023c8: 0 (assoc req) → +0x1b0,
 * 1 (assoc resp) → +0x1bc, 4 (probe req) → +0x1c8, 5 (probe resp) → +0x1d4, 8 (бикон) →
 * журнал + 0x1e0; 2, 3, 6, 7 и ≥ 9 — ассерт 0x1217, 0. Прежде 2/3 давали блоки probe
 * req/resp, а 4..8 — блок бикона: в probe req не попадали IE хоста (ExtCap, DMG, WFA). */
__attribute__((section(".textlate"))) struct app_ies *mid_get_bcon_additional_ies(struct mid_bss *mid, u32 frame_type)
{
    switch (frame_type) {
    case 0: return &mid->ie_assoc_req;
    case 1: return &mid->ie_assoc_resp;
    case 4: return &mid->ie_probe_req;
    case 5: return &mid->ie_probe_resp;
    case 8:
        fw_log_emit0(0x2b, 0x100c904);
        return &mid->ie_beacon;
    default:
        fw_sysassert_fatal(__builtin_return_address(0), 0x1217);
        return 0;
    }
}

/* ============================================================
 * app_ies / ies_block (списки TLV IE)
 * блок — struct app_ies (include/mid.h), итератор — struct ie_iter
 * ============================================================ */

/* ie_iter__init (0x8e5de8, 12 Б): итератор по списку IE. */
__attribute__((section(".textlate"))) void ie_iter_init(struct ie_iter *it, struct app_ies *list)
{
    it->blk = list;
    it->cur = (u8 *)list->buf;
    it->off = 0;
}

/* app_ie__walk_list (0x8df404, 52 Б): вернуть текущий IE и продвинуть
 * итератор; 0 = конец списка. */
__attribute__((section(".textlate"))) u8 *app_ie_walk_list(struct ie_iter *it)
{
    u8 *cur = it->cur;
    if (cur == 0)
        return 0;
    u32 total = it->blk->len_w;
    if (total == 0)
        return 0;
    /* vendor: заголовок и тело IE не сверялись с длиной блока (IE от хоста или длина, ушедшая за блок) — чтение и
     * копирование за блоком. IE, не помещающийся в блок, — конец списка. */
    if (it->off + 2 > total || it->off + 2 + cur[1] > total) {
        it->cur = 0;
        return 0;
    }
    u32 len = cur[1];
    u32 off = it->off + len + 2;
    it->off = off;
    it->cur = (total <= off) ? 0 : (cur + len + 2);
    return cur;
}

/* ies_block__is_empty (0x8da1c0, 12 Б): 1 если блок пуст (len==0). */
/* noinline — отдельная функция у vendor (иначе gcc встраивает её в сборщики probe req/resp) */
__attribute__((section(".textlate"), noinline)) u32 ies_block_is_empty(const struct app_ies *block)
{
    return (block->len_w == 0) ? 1u : 0u;
}

/* app_ies__set_buffer (0x8e693c, 48 Б): записать {buf,len,frame_type}. */
__attribute__((section(".textlate"), noinline)) void app_ies_set_buffer(struct app_ies *block, const void *buf, u32 len, u32 frame_type)
{
    if (len != 0 && buf == 0)
        fw_sysassert_fatal(0, 0x121b);
    block->buf = (u32)buf;
    block->len_w = len;
    block->frame_type = frame_type;
}

/* ies_block__merge (0x8ddfd0, 300 Б): слияние двух сортированных списков IE
 * в dest_block[0] (курсор), дедупликация по eid (vendor по OUI), исключение
 * P2P IE (OUI 50:6f:9a type 0x09) при frame_type==1. Возврат суммарной длины. */
__attribute__((section(".textlate"))) u32 ies_block_merge(u32 *dest_block, struct app_ies *internal_block,
                                                          struct app_ies *external_block)
{
    struct ie_iter it1, it2;
    u8 *dest = *(u8 **)dest_block;
    u32 total = 0;

    ie_iter_init(&it1, internal_block);
    ie_iter_init(&it2, external_block);
    u8 *ie1 = app_ie_walk_list(&it1);
    u8 *ie2 = app_ie_walk_list(&it2);

    for (;;) {
        u8 *cur;
        if (ie2 == 0) {
            if (ie1 == 0)
                break;
            cur = ie1;
            ie1 = app_ie_walk_list(&it1);
        } else if (ie1 == 0) {
            /* в оригинале здесь читается [0] (инвариант: оба списка непусты
             * в начале слияния); безопасно выводим оставшийся external */
            cur = ie2;
            ie2 = app_ie_walk_list(&it2);
        } else {
            u8 e1 = ie1[0];           /* vendor: ldb_s (без знака) + brlt по 0..255 */
            u8 e2 = ie2[0];
            if (e1 < e2) {
                cur = ie1;
                ie1 = app_ie_walk_list(&it1);
            } else if (e1 > e2) {
                cur = ie2;
                ie2 = app_ie_walk_list(&it2);
            } else if (ie1[0] == 0xdd) {
                /* vendor IE: сравнить OUI (3 байта) */
                if (ie1[2] == ie2[2] && ie1[3] == ie2[3] && ie1[4] == ie2[4]) {
                    fw_sysassert_fatal(0, 0x11b9);   /* дубль vendor IE */
                    return 0;
                }
                cur = ie1;
                ie1 = app_ie_walk_list(&it1);
            } else {
                /* одинаковые eid (не vendor): дедуп — вывести один */
                cur = ie1;
                ie1 = app_ie_walk_list(&it1);
                ie2 = app_ie_walk_list(&it2);
            }
        }

        if (cur == 0)
            fw_sysassert_fatal(0, 0x11ba);

        /* исключить P2P IE при frame_type==1 */
        if (cur[2] == 0x50 && cur[3] == 0x6f && cur[4] == 0x9a && cur[5] == 0x09
            && external_block->frame_type == 1u) {
            fw_log_emit3(0x2d, 0x1010e9c, cur[0], cur[1], cur[2]);
            continue;
        }

        u32 n = (u32)cur[1] + 2;
        memcpy_fw(dest, cur, n);
        dest += n;
        total += n;
    }

    *(u8 **)dest_block = dest;
    return total;
}

/* ============================================================
 * mgmt_tx: сборщики тел probe req/resp
 * ============================================================ */

/* mgmt_tx__copy_ie_hdr (0x8d7fd4, 44 Б): фиксированная часть probe resp
 * (timestamp 8 Б = 0, beacon interval, Capability Info). Возврат длины. Beacon interval —
 * полуслово (ldh [r13,78] / stw_s [r14,8]); прежде — слово из невыровненного mid+0x4e. */
__attribute__((section(".textlate"))) u32 mgmt_tx_copy_ie_hdr(u8 *dst, const struct mid_bss *mid)
{
    memset0_words(dst, 8);
    ((struct ieee80211_probe_resp_fixed *)dst)->bcn_int = mid->bcon_int;
    return push_cap_info(dst + 0xa, mid->capinfo_b) + 0xa;
}

/* mgmt_tx__probe_resp_ies (0x8d7f78, 92 Б): набор IE для probe REQ/scan
 * (SSID + RSN + DMG capabilities + vendor-специфика). Возврат длины. */
__attribute__((section(".textlate"))) u32 mgmt_tx_probe_resp_ies(u8 *dst, struct mid_bss *mid, const u8 *ssid,
                                                                u32 ssid_len)
{
    u32 total = 0, n;

    n = ie_push_ssid(dst, ssid, ssid_len);            dst += n; total += n;
    n = ie_push_raw(dst, mid->rsn_ie);                dst += n; total += n;  /* RSN */
    n = ie_push_dmg_capabilities(dst, (u8 *)&mid->dmg_cap, 0); dst += n; total += n;
    n = mgmt_tx_copy_ie_max96(dst, mid->vs_ie, mid->vs_ie_len); dst += n; total += n;

    return total;
}

/* mgmt_tx__append_probe_resp_ies (0x8d8000, 244 Б): полный набор IE для probe
 * resp (SSID + RSN + DMG cap + vendor + dband oper + dband ANT + EDCA + QoS).
 * Третий аргумент в этой сборке не используется. Возврат длины. */
__attribute__((section(".textlate"))) u32 mgmt_tx_append_probe_resp_ies(u8 *dst, struct mid_bss *mid,
                                                                       u32 flag)
{
    u8 ssidbuf[0x20];
    u32 total = 0, n;
    (void)flag;

    u32 ssidlen = mid_copy_ssid(mid, ssidbuf);
    n = ie_push_ssid(dst, ssidbuf, ssidlen);   dst += n; total += n;
    fw_log_emit2(0x2d, 0x100fb38, n, total);                    /* ssid */

    n = ie_push_raw(dst, mid->rsn_ie); dst += n; total += n;
    fw_log_emit2(0x2d, 0x100fb68, n, total);                    /* RSN */

    n = ie_push_dmg_capabilities(dst, (u8 *)&mid->dmg_cap, 0); dst += n; total += n;
    fw_log_emit2(0x2d, 0x100fb98, n, total);                    /* dband cap */

    n = mgmt_tx_copy_ie_max96(dst, mid->vs_ie, mid->vs_ie_len); dst += n; total += n;
    fw_log_emit2(0x2d, 0x100fbc8, n, total);                    /* vendor specific */

    n = ie_push_eid151_len10(dst, mid->blk_f8); dst += n; total += n;
    fw_log_emit2(0x2d, 0x100fc00, n, total);                    /* dband oper */

    n = ie_push_eid190_len4(dst, mid->blk_103); dst += n; total += n;
    fw_log_emit2(0x2d, 0x100fc34, n, total);                    /* dband ANT */

    n = ie_push_edca(dst, mid);   dst += n; total += n;
    n = ie_push_qos_capability(dst); total += n;

    return total;
}

/* mgmt_tx__build_probe_req (0x8e9ebc, 184 Б): тело probe req.
 * MAC-заголовок (subtype 4) + SSID/RSN/DMG/vendor IEs + WFA vendor IE.
 * Пишет полную длину в *out_len. mid — запись mid, conn — соединение пира (Addr1).
 * Порядок IE = vendor: слияние (ies_block_merge) списка хоста {7f ExtCap, 72, dd07 WFA 0x16}
 * со своим {00 SSID, [30 RSN], 94 DMG cap, dd27 Wilocity}; при равных eid 0xdd первым идёт
 * IE хоста. Журнал vendor «Sending probe req len 0x7f» (стенд 2026-10-18): 00 7f 72 94 dd07
 * dd27 dd0f — так же даёт и порт после беззнакового сравнения eid (0716c922); прежний
 * «обмен dd07/dd27» был снят до этого исправления (знаковое сравнение: 00 94 dd27 7f 72 dd07). */
__attribute__((section(".textlate"))) void mgmt_tx_build_probe_req(u32 payload, u32 *out_len,
                                                                   struct mid *mid_e, struct conn *conn,
                                                                   const u8 *ssid_buf, u32 ssid_len)
{
    u8 *hdr = (u8 *)payload;
    mgmt_tx_build_mac_header(mid_e, (struct ieee80211_hdr *)payload, 4, conn->peer);

    u8 *dest = hdr + 0x18;
    struct mid_bss *mid = &mid_e->bss;
    struct app_ies *internal = mid_get_bcon_additional_ies(mid, 4);
    u32 ies_len;

    if (ies_block_is_empty(internal) != 0) {
        fw_log_emit0(0x2d, 0x1013bd0);   /* PROBE REQ internal IEs are built */
        ies_len = mgmt_tx_probe_resp_ies(dest, mid, ssid_buf, ssid_len);
        dest += ies_len;
    } else {
        u8 iesbuf[0x120];
        struct app_ies app_block;
        fw_log_emit0(0x2d, 0x1013bf4);   /* PROBE REQ internal & external IEs are built */
        u32 n = mgmt_tx_probe_resp_ies(iesbuf, mid, ssid_buf, ssid_len);
        app_ies_set_buffer(&app_block, iesbuf, n, 0);
        u32 dest_block[1];
        dest_block[0] = (u32)dest;
        ies_len = ies_block_merge(dest_block, internal, &app_block);
        dest = (u8 *)dest_block[0];
    }

    u32 total = 0x18 + ies_len;
    total += ie_push_wfa_vendor(dest, mid_e->mac, 0);
    *out_len = total;
}

/* mgmt_tx__build_probe_resp (0x8e9f74, 224 Б): тело probe resp.
 * MAC-заголовок (subtype 5) + фикс. поля + IE + WFA vendor IE. mid_e — запись mid,
 * conn — соединение пира (Addr1, версия VS). */
__attribute__((section(".textlate"))) void mgmt_tx_build_probe_resp(u32 payload, u32 *out_len,
                                                                    struct mid *mid_e, struct conn *conn,
                                                                    u32 frame_type)
{
    u8 *hdr = (u8 *)payload;
    mgmt_tx_build_mac_header(mid_e, (struct ieee80211_hdr *)payload, 5, conn->peer);

    u8 *dest = hdr + 0x18;
    struct mid_bss *mid = &mid_e->bss;
    u32 n_fixed = mgmt_tx_copy_ie_hdr(dest, mid);
    dest += n_fixed;
    u32 fixed = n_fixed + 0x18;

    struct app_ies *internal = mid_get_bcon_additional_ies(mid, 5);
    u32 has_ext = (conn->vs_version == 0) ? 1u : 0u;
    u32 ies_len;

    if (ies_block_is_empty(internal) != 0) {
        fw_log_emit0(0x2d, 0x1013c50);   /* no external APP IEs — internal only */
        ies_len = mgmt_tx_append_probe_resp_ies(dest, mid, has_ext);
        dest += ies_len;
    } else {
        u8 iesbuf[0x120];
        struct app_ies app_block;
        fw_log_emit0(0x2d, 0x1013c94);   /* internal + external APP IEs */
        u32 n = mgmt_tx_append_probe_resp_ies(iesbuf, mid, has_ext);
        app_ies_set_buffer(&app_block, iesbuf, n, frame_type);
        u32 dest_block[1];
        dest_block[0] = (u32)dest;
        ies_len = ies_block_merge(dest_block, internal, &app_block);
        dest = (u8 *)dest_block[0];
    }

    u32 total = fixed + ies_len;
    total += ie_push_wfa_vendor(dest, mid_e->mac, 0);
    *out_len = total;
    fw_log_emit1(0x2d, 0x1013cc8, total);
}

/* ============================================================
 * tx_probe: отправка probe req/resp
 * ============================================================ */

/* tx_mgmt_builder_srvs__tx_mgmt_scan_probe_req (0x8ea054, 76 Б): собрать scan
 * probe req: BSSID из param[0] → payload+4, тело через build_probe_req,
 * 6 байт 0xff в payload+0x10..0x15. */
__attribute__((section(".textlate"))) void tx_mgmt_scan_probe_req(u32 payload, u32 *out_len,
                                                                  struct mid *mid_e, struct conn *conn,
                                                                  const struct tx_probe_param *param)
{
    struct ieee80211_hdr *h = (struct ieee80211_hdr *)payload;
    fw_log_emit0(0x2d, 0x1013c20);
    mgmt_tx_build_probe_req(payload, out_len, mid_e, conn, param->ssid, param->ssid_len);
    memcpy_fw(h->addr1.b, param->ra, 6);
    {   /* побайтно (stb ×6, как vendor) — volatile, иначе gcc сливает в stw */
        volatile u8 *a3 = h->addr3.b;
        a3[5] = 0xff; a3[4] = 0xff; a3[3] = 0xff; a3[2] = 0xff; a3[1] = 0xff; a3[0] = 0xff;
    }
}

/* tx_probe__send_probe_req (0x8f8cf8, 124 Б): собрать и отправить probe req
 * (активный скан). */
__attribute__((section(".textlate"))) void tx_probe_send_probe_req(u32 payload, struct mid *mid_e,
                                                                   struct conn *conn,
                                                                   const struct tx_probe_param *param, tx_done_fn cb)
{
    u32 len = 0;
    tx_mgmt_scan_probe_req(payload, &len, mid_e, conn, param);
    if (len == 0)
        fw_sysassert_fatal(0, 0x1251);
    fw_log_emit1(0x2d, 0x1017690, len);
    hexdump_words((void *)payload, len);
    tx_api_send_mgmt(conn, param->channel, 1, payload, len, cb, 0);
    mgmt_stats.probe_req_tx += 1u;
}

/* tx_probe__send_probe_resp (0x8f8c8c, 108 Б): собрать и отправить probe resp. */
__attribute__((section(".textlate"))) void tx_probe_send_probe_resp(u32 payload, struct mid *bss_ctx,
                                                                    struct conn *conn, u32 flag, tx_done_fn cb)
{
    u32 len = 0;
    mgmt_tx_build_probe_resp(payload, &len, bss_ctx, conn, 0);
    if (len == 0)
        fw_sysassert_fatal(0, 0x1252);
    fw_log_emit3(0x2d, 0x10176ac, len, payload, payload);
    tx_api_send_mgmt(conn, flag, 1, payload, len, cb, 2);
}
