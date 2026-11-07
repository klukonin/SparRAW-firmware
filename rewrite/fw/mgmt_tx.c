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

/* ie__push_dmg_capabilities (0x8e1fd4, 28 Б): DMG Capabilities IE (eid 0x94); flag (AID) пишется в src[6] до
 * копирования. vendor слал тело 17 октетов (формат 802.11ad-2012); по 802.11-2020 9.4.2.127 (рис. 9-549) — 22:
 * за DMG AP Or PCP Capability Information идут DMG STA Beam Tracking Time Limit (2; 0 — отслеживание луча не
 * поддерживается, 10.42.7), Extended SC MCS Capabilities (1; 0 — нет, у Sparrow SC MCS 0..12), Maximum Number Of
 * Basic / Short A-MSDU Subframes In A-MSDU (по 1; 0 — без ограничения, табл. 9-253/9-254: A-MSDU согласуется
 * отдельно, в ADDBA). Первые 17 октетов — src (mid_bss.dmg_cap), остальные 5 — нули. Возврат 0x18. */
#define DMG_CAP_BODY_LEN 22u
__attribute__((section(".textlate"))) u32 ie_push_dmg_capabilities(u8 *dst, u8 *src, u32 flag)
{
    u32 i;
    dst[0] = 0x94;
    dst[1] = DMG_CAP_BODY_LEN;
    src[6] = (u8)flag;
    memcpy_fw(dst + 2, src, sizeof(struct dmg_cap));
    for (i = 2 + sizeof(struct dmg_cap); i < 2 + DMG_CAP_BODY_LEN; i++)
        dst[i] = 0;
    return 2 + DMG_CAP_BODY_LEN;
}

/* ie__push_edca (0x8e1da8, 32 Б): 0x14 байт EDCA IE объекта BSS (obj+0x12: edca_12 ..
 * edca_ac). */
__attribute__((section(".textlate"))) u32 ie_push_edca(u8 *dst, const struct mid_bss *mid)
{
    memcpy_fw(dst, &mid->edca_12, 0x14);
    fw_log_emit1(0x2d, 0x100faf4, 0x14);
    return 0x14;
}

/* ie__push_qos_capability (0x8e1f4c, 36 Б): QoS Capability IE (eid 0x2e, len 1) — только Association Request станции
 * (табл. 9-34, порядок 9). Возврат 3.
 * Баг vendor (исправлен 2026-10-20): vendor делает ldb.a r2,[r0,2]; bset_s r2,r2,3 — ИЛИ с байтом
 * буфера, который никто не писал (вызывающие mlme/mgmt_tx его не задают): в эфир уходил остаток
 * памяти | 0x08 (стенд: маяк AP vendor — IE 46 = b8, наш с тем же кодом — 88).
 * исправлено (vendor): тело — QoS Info станции (9.4.1.17, рис. 9-101), B3 там — AC_BE U-APSD Flag: 0x08 объявлял
 * U-APSD для AC_BE, а энергосбережения нет (fw/action.c psc_req_reject) — все флаги U-APSD, Q-Ack, Max SP Length,
 * More Data Ack — 0. */
__attribute__((section(".textlate"))) u32 ie_push_qos_capability(u8 *dst)
{
    dst[0] = 0x2e;
    dst[1] = 0x01;
    dst[2] = 0x00;
    fw_log_emit1(0x2d, 0x100fb10, dst[2]);
    return 0x03;
}

/* DMG Operation Information (рис. 9-556) по расписанию, которое точка объявляет в маяке: TDDTI (B0) = 1, если DTI
 * распределён Extended Schedule (10.39.6 — доступ по расписанию: ESE TDMA точки fw/tdma.c или расписание хоста
 * WMI_SCHEDULING_SCHEME, оба — в блоке IE маяка), Pseudo-static allocations (B1) = 1, если хоть одна аллокация ESE
 * псевдостатическая (B7 Allocation Control, рис. 9-564; 10.39.6.4); при TDDTI = 0 B1 — резерв, 0. */
static u32 dmg_oper_info_sched_bits(struct mid_bss *bss)
{
    const struct app_ies *blk = mid_app_ie_block(bss, 0);
    const u8 *ie = (const u8 *)blk->buf;
    u32 n = ie != 0 ? blk->len : 0u;
    for (u32 i = 0; i + 2u <= n && i + 2u + ie[i + 1] <= n; i += 2u + ie[i + 1]) {
        if (ie[i] != EID_EXT_SCHED || ie[i + 1] < sizeof(struct ese_alloc))
            continue;
        u32 bits = 1u;
        for (u32 k = 0; k + sizeof(struct ese_alloc) <= ie[i + 1]; k += sizeof(struct ese_alloc))
            if (ie[i + 2 + k] & 0x80u)
                bits |= 2u;
        return bits;
    }
    return 0;
}

/* ie__push_eid151_len10 (0x8e1fbc, 24 Б): DMG Operation (eid 0x97, len 10; 9.4.2.128) из bss->blk_f8. Возврат 0xc.
 * исправлено (vendor): TDDTI и Pseudo-static allocations (рис. 9-556) всегда 0 — и при ESE TDMA точки с
 * псевдостатическими аллокациями; теперь — по расписанию маяка (dmg_oper_info_sched_bits). */
__attribute__((section(".textlate"))) u32 ie_push_dmg_operation(u8 *dst, struct mid_bss *bss)
{
    dst[0] = 0x97;
    dst[1] = 0x0a;
    memcpy_fw(dst + 2, bss->blk_f8, 0x0a);
    dst[2] = (u8)((dst[2] & ~3u) | dmg_oper_info_sched_bits(bss));
    /* DMG BSS Parameter Configuration (рис. 9-557), октеты 2..9 тела. исправлено (vendor: все 0, кроме MaxLostBeacons):
     * MinBHIDuration — наименьший BHI этой точки (bss_min_bhi_us, fw/tdma.c); AssocRespConfirmTime (в 50 мс) — точка
     * отвечает на Association Request в ближайшем DTI, не позже одного BI: ⌈BI / 50 мс⌉ (станция может взять его в
     * dot11AssociationResponseTimeOut). PSRequestSuspensionInterval, MinPPDuration, SPIdleTimeout — 0: энергосбережения
     * и динамических выделений (PP/GP, 10.39.7) нет; BroadcastSTAInfoDuration — 0: сведения о станциях (STA
     * Availability) точка не рассылает. */
    {
        u32 bhi = bss_min_bhi_us(bss->owner);
        u32 bi_us = (u32)bss->bcon_int * 1024u;
        u32 arct = (bi_us + 49999u) / 50000u;
        dst[2 + 3] = (u8)bhi;
        dst[2 + 4] = (u8)(bhi >> 8);
        dst[2 + 6] = (u8)(arct != 0 ? (arct > 0xffu ? 0xffu : arct) : 1u);
    }
    return 0x0c;
}

/* ie__push_eid190_len4 (0x8e1fa4, 24 Б): eid 0xbe, len 4. Возврат 6. */
__attribute__((section(".textlate"))) u32 ie_push_antenna_sector_id_pattern(u8 *dst, const u8 *src)
{
    dst[0] = 0xbe;
    dst[1] = 0x04;
    memcpy_fw(dst + 2, src, 0x04);
    return 0x06;
}

/* Тело Antenna Sector ID Pattern (рис. 9-604: Type B0..B3, Tap 1 B4..B9, State 1, Tap 2, State 2) действительно:
 * Type 0 — Random Sequence Generator (1–3 Reserved), отводы генератора 1 не нулевые. */
static u32 asid_pattern_valid(const u8 *p)
{
    u32 v = (u32)p[0] | ((u32)p[1] << 8);
    return (v & 0xfu) == 0 && ((v >> 4) & 0x3fu) != 0;
}

/* mgmt_tx__copy_ie_max96 (0x8e2048, 148 Б, тело 28 Б): копия до 0x60 байт. */
__attribute__((section(".textlate"))) u32 mgmt_tx_copy_ie_bounded(u8 *dst, const u8 *src, u32 len)
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

/* Capability Information Probe Response / (Re)Association Response точки (9.4.1.4, рис. 9-86): B0..B7 — DMG Parameters
 * (9.4.1.46). исправлено (vendor): CBAP Only (B2) всегда 1 (bss_set_mode_capinfo) — и при DTI, распределённом ESE, когда
 * маяк несёт 0; по 9.4.1.46 поле в этих кадрах — то же «весь DTI — CBAP», что в DMG Parameters маяка (dmg_cbap_only). */
__attribute__((section(".textlate"))) u32 push_cap_info_resp(u8 *dst, const struct mid_bss *bss)
{
    u32 n = push_cap_info(dst, bss->capinfo_b);
    dst[0] = (u8)((dst[0] & ~(1u << 2)) | (dmg_cbap_only(bss->owner) << 2));
    return n;
}

/* Capability Information (Re)Association Request станции (рис. 9-86): по 9.4.1.46 BSS Type (B0..B1) — резерв вне DMG
 * Beacon / Probe Response / (Re)Association Response, CBAP Only, CBAP Source, ECAPC Policy Enforced (B2, B3, B5) —
 * только в них же; резерв передаётся нулём. исправлено (vendor: BSS Type 1 и CBAP Only 1 из bss_set_mode_capinfo). */
__attribute__((section(".textlate"))) u32 push_cap_info_req(u8 *dst, const struct mid_bss *bss)
{
    u32 n = push_cap_info(dst, bss->capinfo_b);
    dst[0] &= (u8)~0x2fu;
    return n;
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
__attribute__((section(".textlate"))) struct app_ies *mid_get_app_ies_by_subtype(struct mid_bss *mid, u32 frame_type)
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
/* Ключ порядка элементов при слиянии: vendor — сам Element ID (списки отсортированы по eid). */
static u32 ie_rank_eid(u32 eid)
{
    return eid;
}

/* Порядковый номер элемента в теле Probe Response (табл. 9-39) — те, что могут прийти от fw или хоста в DMG BSS;
 * неизвестный — перед Vendor Specific (Last−1). Порядок 9-39 не совпадает с порядком eid: RSN (16, eid 48) идёт до
 * EDCA (18, eid 12), Multi-band (53, eid 158) — до DMG Capabilities (54, eid 148). */
static u32 ie_rank_probe_resp(u32 eid)
{
    switch (eid) {
    case 0:   return 4;                 /* SSID */
    case 7:   return 8;                 /* Country */
    case 32:  return 9;                 /* Power Constraint */
    case 40:  return 11;                /* Quiet */
    case 35:  return 13;                /* TPC Report */
    case 48:  return 16;                /* RSN */
    case 11:  return 17;                /* BSS Load */
    case 12:  return 18;                /* EDCA Parameter Set */
    case 70:  return 21;                /* RM Enabled Capabilities */
    case 54:  return 27;                /* Mobility Domain */
    case 60:  return 29;                /* Extended Channel Switch Announcement */
    case 59:  return 30;                /* Supported Operating Classes */
    case 127: return 35;                /* Extended Capabilities */
    case 107: return 40;                /* Interworking */
    case 108: return 41;                /* Advertisement Protocol */
    case 111: return 42;                /* Roaming Consortium */
    case 158: return 53;                /* Multi-band */
    case 148: return 54;                /* DMG Capabilities */
    case 151: return 55;                /* DMG Operation */
    case 170: return 56;                /* Multiple MAC Sublayers */
    case 190: return 57;                /* Antenna Sector ID Pattern */
    case 167: return 68;                /* Relay Capabilities */
    case 244: return 92;                /* RSN Extension */
    case 221: return 0x101;             /* Vendor Specific — после всех */
    default:  return 0x100;
    }
}

/* Порядковый номер элемента в теле Association Request (табл. 9-34) — элементы, что приходят от fw (SSID, RSN, QoS
 * Capability, DMG Capabilities) или от хоста (wpa_supplicant через драйвер: Extended Capabilities, Supported Operating
 * Classes, Multi-band, Vendor Specific …); неизвестный — перед Vendor Specific. */
static u32 ie_rank_assoc_req(u32 eid)
{
    switch (eid) {
    case 0:   return 3;                 /* SSID */
    case 1:   return 4;                 /* Supported Rates and BSS Membership Selectors */
    case 50:  return 5;                 /* Extended Supported Rates and BSS Membership Selectors */
    case 33:  return 6;                 /* Power Capability */
    case 36:  return 7;                 /* Supported Channels */
    case 48:  return 8;                 /* RSN */
    case 46:  return 9;                 /* QoS Capability */
    case 70:  return 10;                /* RM Enabled Capabilities */
    case 54:  return 11;                /* Mobility Domain */
    case 59:  return 12;                /* Supported Operating Classes */
    case 45:  return 13;                /* HT Capabilities */
    case 72:  return 14;                /* 20/40 BSS Coexistence */
    case 127: return 15;                /* Extended Capabilities */
    case 89:  return 16;                /* QoS Traffic Capability */
    case 94:  return 17;                /* TIM Broadcast Request */
    case 107: return 18;                /* Interworking */
    case 158: return 19;                /* Multi-band */
    case 148: return 20;                /* DMG Capabilities */
    case 170: return 21;                /* Multiple MAC Sublayers */
    case 191: return 22;                /* VHT Capabilities */
    case 199: return 23;                /* Operating Mode Notification */
    case 55:  return 42;                /* Fast BSS Transition */
    case 244: return 43;                /* RSN Extension */
    case 221: return 0x101;             /* Vendor Specific — после всех */
    default:  return 0x100;
    }
}

static u32 ies_block_merge_ranked(u32 *dest_block, struct app_ies *internal_block, struct app_ies *external_block,
                                  u32 (*rank)(u32 eid));

__attribute__((section(".textlate"))) u32 ies_block_merge(u32 *dest_block, struct app_ies *internal_block,
                                                          struct app_ies *external_block)
{
    return ies_block_merge_ranked(dest_block, internal_block, external_block, ie_rank_eid);
}

/* Ключ элемента для сортирующего слияния: порядковый номер таблицы, затем список (хост — 0, fw — 1), затем смещение
 * в списке — порядок вывода строго по возрастанию ключа. */
static u32 ie_sort_key(u32 (*rank)(u32 eid), const u8 *ie, u32 src, u32 off)
{
    return (rank(ie[0]) << 17) | (src << 16) | (off & 0xffffu);
}

/* Есть ли в списке b элемент с тем же Element ID (Vendor Specific — с тем же OUI). */
static u32 ies_block_has_eid(struct app_ies *b, const u8 *ie)
{
    struct ie_iter it;
    u8 *x;
    ie_iter_init(&it, b);
    while ((x = app_ie_walk_list(&it)) != 0) {
        if (x[0] != ie[0])
            continue;
        if (ie[0] != 0xdd || (x[2] == ie[2] && x[3] == ie[3] && x[4] == ie[4]))
            return 1;
    }
    return 0;
}

/* Слияние с сортировкой по таблице порядка элементов кадра (rank): списки хоста и fw не обязаны быть упорядочены
 * (wpa_supplicant кладёт Extended Capabilities раньше Supported Operating Classes, а в табл. 9-34 — наоборот: 15
 * после 12; слияние двух «отсортированных» списков по Element ID выпускало их как есть, захват 2026-11-04). Равный
 * номер — элемент хоста, затем свой; одинаковый Element ID в обоих списках — один, хоста (как ies_block_merge);
 * одинаковый Vendor Specific OUI в обоих — ассерт 0x11b9 (как vendor). P2P IE при frame_type 1 — пропуск. */
static u32 ies_block_merge_sorted(u32 *dest_block, struct app_ies *internal_block, struct app_ies *external_block,
                                  u32 (*rank)(u32 eid))
{
    u8 *dest = *(u8 **)dest_block;
    u32 total = 0, last = 0, have_last = 0;
    for (;;) {
        u8 *best = 0;
        u32 best_key = 0;
        for (u32 src = 0; src < 2; src++) {
            struct app_ies *b = src ? external_block : internal_block;
            struct ie_iter it;
            u8 *x;
            ie_iter_init(&it, b);
            while ((x = app_ie_walk_list(&it)) != 0) {
                u32 k = ie_sort_key(rank, x, src, (u32)(x - (u8 *)b->buf));
                if ((have_last && k <= last) || (best != 0 && k >= best_key))
                    continue;
                best = x;
                best_key = k;
            }
        }
        if (best == 0)
            break;
        last = best_key;
        have_last = 1;
        if ((best_key >> 16) & 1u) {                       /* свой элемент */
            if (ies_block_has_eid(internal_block, best)) {
                if (best[0] == 0xdd) {
                    fw_sysassert_fatal(0, 0x11b9);         /* дубль vendor IE */
                    return 0;
                }
                continue;                                  /* тот же элемент у хоста — уже выведен */
            }
        }
        if (best[2] == 0x50 && best[3] == 0x6f && best[4] == 0x9a && best[5] == 0x09
            && external_block->frame_type == 1u) {
            fw_log_emit3(0x2d, 0x1010e9c, best[0], best[1], best[2]);
            continue;
        }
        u32 n = (u32)best[1] + 2;
        memcpy_fw(dest, best, n);
        dest += n;
        total += n;
    }
    *(u8 **)dest_block = dest;
    return total;
}

/* Слияние IE хоста со своими для Association Request — по порядку табл. 9-34 (9.3.3.5). */
__attribute__((section(".textlate"))) u32 ies_block_merge_assoc_req(u32 *dest_block, struct app_ies *internal_block,
                                                                    struct app_ies *external_block)
{
    return ies_block_merge_sorted(dest_block, internal_block, external_block, ie_rank_assoc_req);
}

/* Слияние по ключу rank: меньший ключ — раньше; равный ключ при разных eid (неизвестные элементы) — элемент хоста
 * (internal_block), затем свой, без дедупликации. */
static u32 ies_block_merge_ranked(u32 *dest_block, struct app_ies *internal_block, struct app_ies *external_block,
                                  u32 (*rank)(u32 eid))
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
            u32 r1 = rank(ie1[0]);    /* vendor: ldb_s (без знака) + brlt по 0..255 — rank = eid */
            u32 r2 = rank(ie2[0]);
            if (r1 < r2 || (r1 == r2 && ie1[0] != ie2[0])) {
                cur = ie1;
                ie1 = app_ie_walk_list(&it1);
            } else if (r1 > r2) {
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
 * (timestamp 8 Б = 0 — TSF при передаче вставляет MAC, бит ts_insert в tx_ring_post_frame; beacon interval,
 * Capability Info). Возврат длины. Beacon interval —
 * полуслово (ldh [r13,78] / stw_s [r14,8]); прежде — слово из невыровненного mid+0x4e. */
__attribute__((section(".textlate"))) u32 mgmt_tx_copy_ie_hdr(u8 *dst, const struct mid_bss *mid)
{
    memset0_words(dst, 8);
    ((struct ieee80211_probe_resp_fixed *)dst)->bcn_int = mid->bcon_int;
    return push_cap_info_resp(dst + 0xa, mid) + 0xa;
}

/* mgmt_tx__probe_resp_ies (0x8d7f78, 92 Б): набор IE для probe REQ/scan
 * (SSID + DMG capabilities + vendor-специфика; табл. 9-38). Возврат длины. */
__attribute__((section(".textlate"))) u32 mgmt_tx_build_probe_req_ies(u8 *dst, struct mid_bss *mid, const u8 *ssid,
                                                                u32 ssid_len)
{
    u32 total = 0, n;

    n = ie_push_ssid(dst, ssid, ssid_len);            dst += n; total += n;
    /* исправлено (vendor): RSN (mid->rsn_ie) в Probe Request не входит — табл. 9-38 его не содержит */
    n = ie_push_dmg_capabilities(dst, (u8 *)&mid->dmg_cap, 0); dst += n; total += n;
    n = mgmt_tx_copy_ie_bounded(dst, mid->vs_ie, mid->vs_ie_len); dst += n; total += n;

    return total;
}

/* mgmt_tx__append_probe_resp_ies (0x8d8000, 244 Б): свои элементы Probe Response в порядке табл. 9-39: SSID (4),
 * RSN (16), EDCA Parameter Set (18), DMG Capabilities (54), DMG Operation (55), Antenna Sector ID Pattern (57), Vendor
 * Specific Wilocity (последние). Третий аргумент в этой сборке не используется. Возврат длины.
 * исправлено (vendor): порядок SSID, RSN, DMG Capabilities, Vendor Specific, DMG Operation, Antenna Sector ID, EDCA,
 * QoS Capability — Vendor Specific в середине, EDCA после DMG; QoS Capability в Probe Response не входит (табл. 9-39). */
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

    n = ie_push_edca(dst, mid);   dst += n; total += n;

    n = ie_push_dmg_capabilities(dst, (u8 *)&mid->dmg_cap, 0); dst += n; total += n;
    fw_log_emit2(0x2d, 0x100fb98, n, total);                    /* dband cap */

    n = ie_push_dmg_operation(dst, mid); dst += n; total += n;
    fw_log_emit2(0x2d, 0x100fc00, n, total);                    /* dband oper */

    /* Antenna Sector ID Pattern (9.4.2.156) — только действительный: Type 0 (Random Sequence Generator), Tap 1 ≠ 0.
     * Нужен лишь станциям в энергосбережении (11.2.7.1); в open его не заполняет никто (asid_pattern обнулён в
     * mid.c), маяки идут секторами подряд. исправлено (vendor): элемент из нулей шёл всегда (Tap 1 = 0 — генератор
     * не меняет состояние, секторы маяков ему не соответствуют; судья волны 5, MAC-STAND.md). */
    if (asid_pattern_valid(mid->asid_pattern)) {
        n = ie_push_antenna_sector_id_pattern(dst, mid->asid_pattern); dst += n; total += n;
        fw_log_emit2(0x2d, 0x100fc34, n, total);                /* dband ANT */
    }

    n = mgmt_tx_copy_ie_bounded(dst, mid->vs_ie, mid->vs_ie_len); total += n;
    fw_log_emit2(0x2d, 0x100fbc8, n, total);                    /* vendor specific */

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
    struct app_ies *internal = mid_get_app_ies_by_subtype(mid, 4);
    u32 ies_len;

    if (ies_block_is_empty(internal) != 0) {
        fw_log_emit0(0x2d, 0x1013bd0);   /* PROBE REQ internal IEs are built */
        ies_len = mgmt_tx_build_probe_req_ies(dest, mid, ssid_buf, ssid_len);
        dest += ies_len;
    } else {
        u8 iesbuf[0x120];
        struct app_ies app_block;
        fw_log_emit0(0x2d, 0x1013bf4);   /* PROBE REQ internal & external IEs are built */
        u32 n = mgmt_tx_build_probe_req_ies(iesbuf, mid, ssid_buf, ssid_len);
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

    struct app_ies *internal = mid_get_app_ies_by_subtype(mid, 5);
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
        /* исправлено (vendor): слияние по порядку табл. 9-39, а не по eid (RSN — до EDCA, Multi-band — до DMG) */
        ies_len = ies_block_merge_sorted(dest_block, internal, &app_block, ie_rank_probe_resp);
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
