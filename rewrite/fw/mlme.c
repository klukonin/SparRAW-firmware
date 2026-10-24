// SPDX-License-Identifier: AGPL-3.0-or-later
/* MLME: автомат ассоциации соединения (описатель 0x802458, объект conn+0xf0), приём
 * MLME-кадров (rx_pkt_handler), Assoc Request / Disassoc, уведомления conn_main_sm и
 * разрыв соединения.
 *
 * Объект — struct mlme_sm (include/conn.h, conn->mlme): радио захвачено, обмен Assoc идёт
 * (busy), запрос радио, таймеры ассоциации и CTRL (split MAC), владелец conn, TX-кадр,
 * статус, сохранённый RX-кадр Assoc (для WMI_CONNECT_EVENT), кадр для хоста (split MAC).
 * Состояния: 0 UNASSOCIATE, 1 ASSOCIATE, 2 ASSOCIATED. События: 0 CONNECT, 1 DISCONNECT,
 * 2 DISASSOCIAT, 3 ASSOC_RESPONSE_START, 4 ASSOC_RESPONSE, 5 ASSOC_REJECT, 6 ASSOC_TIMEOUT,
 * 7 RM_CHANNEL_LOCKED, 8 DATA_PORT_OPEN, 9 WAITFOR_CTRL_ASSOC_RES, 10 CTRL_ASSOC_RESPONSE_RET,
 * 11 CTRL_NEW_STA, 12 WAITFOR_CTRL_DEL_STA, 13 CTRL_DEL_STA.
 *
 * Путь STA: conn_main_sm OWN_ASSOC → CONNECT (0x8f1080: радио + таймер) → радио
 * захвачено RM_CHANNEL_LOCKED (0x8c5cfc: Assoc Request, ASSOC_RESPONSE_START) → TX-колбэк
 * (0x8f1fb0: [+0xc] = 1) → Assoc Response (rx_pkt_handler) → ASSOC_RESPONSE (0x8f0f4c:
 * aid, кадр в [+0x2c], NTF_ASSOC_DONE) → conn_main_sm → mlme_sm__association_done
 * (conn.c) → WMI_CONNECT_EVENT. */
#include "../include/types.h"
#include "../include/wmi.h"
#include "../include/mid.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/vring_schd.h"
#include "../include/rf_obj.h"
#include "../include/radio_mgr.h"
#include "../include/mbox.h"
#include "../include/conn.h"
#include "../include/ieee80211.h"
#include "../include/lmac_cmd.h"
#include "../include/sys_cfg.h"
#include "../include/fwdata.h"
#include "../include/fwq_tx.h"

/* ---------------- радио ---------------- */

/* RADIO_MGR::remove_request (0x8e2798, 32 Б): radio_mgr->release(req). */
void radio_mgr_remove_request(struct rm_req *req)
{
    struct radio_mgr *rm;
    fw_log_emit1(0x28, 0x1019068, (u32)req);
    rm = radio_mgr_obj;
    rm->vt->release(rm, req);
}


/* Освобождение радио автоматом MLME (у vendor вставлено в 0x8f0eb4, 0x8f131c, 0x8f21c0,
 * 0x8f26a8 одинаковым кодом): захвачено (radio_locked) — lock_free, иначе снять запрос. */
static void mlme_release_radio(struct mlme_sm *sm)
{
    u32 req = (u32)sm->rm_req;
    if (req == 0)
        return;
    if (sm->radio_locked != 0) {
        fw_log_emit1(0x2c, 0x101159c, req);
        radio_mgr_call_method_10(sm->rm_req);
    } else {
        fw_log_emit1(0x2c, 0x10115c8, req);
        radio_mgr_remove_request(sm->rm_req);
    }
}

/* Колбэк радио-менеджера MLME (0x8e2178, 16 Б; передаётся числом 0x22178): радио
 * захвачено — RM_CHANNEL_LOCKED (7) автомату MLME arg с a0 = req. */
void mlme_rm_locked_cb(struct rm_req *req, u32 arg)
{
    mlme_sm_event((struct mlme_sm *)arg, 7, (u32)req, 0, 0);
}

/* ---------------- уведомления ---------------- */

/* (0x8de364, 30 Б): conn_mgr__ranking_remove (переход 0x8e7978) и NTF_ASSOC_DONE (5). */
static void mlme_notify_assoc_done(struct conn *conn)
{
    conn_mgr_ranking_remove(conn);
    conn_msm_event(&conn->msm, 5, 0, 0, 0);
}

/* pbss__disconnect_by_peer (0x8c9164, 84 Б): разорвать все соединения записи mid —
 * члены PBSS. Журнал vendor — байт 2 MAC пира (ldb_s [r3,0x2]) и первое слово. */
static void pbss_disconnect_by_peer(struct mid *e, u32 reason, u32 protocol)
{
    u32 it;
    struct conn *c;
    iter_init(&it, &e->conns);
    while (list_has_items(&it)) {
        c = (struct conn *)iter_next(&it);
        if (c->pbss == 0)
            continue;
        fw_log_emit2(0x2b, 0x100cc50, c->peer[2], c->peer_lo);
        conn_disconnect(c, reason, protocol);
    }
}

/* disconnect_by_peer (0x8f2584, 64 Б): у STA-записи mid — разорвать членов PBSS; затем
 * само соединение. */
void disconnect_by_peer(u32 mid, struct conn *conn, u32 reason, u32 protocol)
{
    if (mid_state_is_2_or_3(mid) == 0)
        pbss_disconnect_by_peer(mid_list_by_mid_fw(mid), reason, protocol);
    fw_log_emit3(0x2b, 0x100d658, mid, reason, protocol);
    conn_disconnect(conn, reason, protocol);
}

/* 0x80254c: таблица переходов switch vendor mlme_notify (0x8de394;
 * ldb, цель = 0x8de3dc + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(80254c) const u8 mlme_notify_jt[5] = {
    0x25, 0x0e, 0x1d, 0x21, 0x17,
};

/* mlme_notify (0x8de394, 166 Б; таблица 0x80254c): kind 1 — событие 2 автомату разрыва,
 * 2 — разрыв пиром (причина 0, протокол a2), 3 — NTF_ASSOC_START, 4 — NTF_ASSOC_DONE,
 * 5 — разрыв (причина 6). Первый и последний аргументы vendor не читает. */
u32 mlme_notify(struct mlme_sm *sm, u32 cid, u32 a2, u32 kind, u32 a4)
{
    struct conn *conn;
    struct mid *mid;
    (void)sm;
    (void)a4;
    conn = conn_mgr_by_cid(cid);
    if (conn == 0)
        fw_sysassert_fatal((void *)0, 0x1203);
    mid = conn->mid;
    if (mid == 0)
        fw_sysassert_fatal((void *)0, 0x1204);
    fw_log_emit3(0x2a, 0x1011378, cid, a2, kind);
    switch (kind) {
    case 1:
        conn_disc_event(&conn->msm.disc, 2, 0, 0, 0);          /* conn__sm_handle_event 0x8d9cc0 */
        break;
    case 2:
        disconnect_by_peer(mid->id, conn, 0, a2);
        conn_disconnect(conn, 0, a2);
        break;
    case 3:
        conn_msm_event(&conn->msm, 4, 0, 0, 0);                /* 0x8de384 */
        break;
    case 4:
        mlme_notify_assoc_done(conn);
        break;
    case 5:
        conn_disconnect(conn, 6, a2);
        break;
    default:
        break;
    }
    return 0;
}

/* ---------------- TX mgmt ---------------- */

/* tx_api__send_mgmt_with_cb (0x8e5a28, 52 Б): TX_API::send_packet с пределом повторов
 * mgmt, счётчиком/шагом повторов a5/a6, обработчиком cb и категорией cat. */
void tx_api_send_mgmt_with_cb(struct conn *conn, u32 a1, u32 a2, u32 payload, u32 len, u32 a5,
                              u32 a6, tx_done_fn cb, u32 cat)
{
    tx_api_send_packet(conn, a1, a2, payload, len, tx_api_get_mgmt_retry_limit(), a5, a6, 0,
                       cb, cat);
}

/* TX_API::post_tx_payload (0x8e0ce8, 94 Б): переданный mgmt-кадр хосту —
 * WMI_TX_MGMT_PACKET_EVENTID (0x1841): заголовок кадра (payload − 0x24), длина [+8]. */
void TX_API_post_tx_payload(u32 payload, u32 mid)
{
    u32 len;
    if (payload == 0)
        fw_sysassert_fatal((void *)0, 0x11e9);
    len = TX_PKT_OF(payload)->len;
    fw_log_emit2(0x27, 0x10183f4, payload, (u32)__builtin_return_address(0));
    low_sme_send_evt2sw((void *)payload, 0x1841, len, mid, 0, 1, 0);
}

/* frame_builder: Assoc Request — фиксированные поля (0x8f4e9c, 34 Б): Capability Info
 * (mobj+0x5c) и Listen Interval ([mobj+0x4e]). */
static u32 mgmt_tx_assoc_req_fixed_fields(u8 *dst, const struct mid_bss *mobj, struct conn *conn)
{
    u32 n;
    (void)conn;
    n = push_cap_info(dst, mobj->capinfo_b) & 0xffffu;
    *(u16 *)(dst + n) = mobj->bcon_int;
    return (n + 2) & 0xffffu;
}

/* mgmt_tx__assoc_req_ies (0x8f4ec0, 96 Б): SSID, RSN (mobj+0x180), QoS Capability,
 * DMG Capabilities (mobj+0x5e). Третий аргумент vendor не читает. */
static u32 mgmt_tx_assoc_req_ies(u8 *dst, struct mid_bss *mobj, u32 flag)
{
    u8 ssid[0x20];
    u32 n, r;
    (void)flag;
    r = mid_copy_ssid(mobj, ssid);
    n = ie_push_ssid(dst, ssid, r & 0xffu) & 0xffffu;
    dst += n;
    r = ie_push_raw(dst, mobj->rsn_ie) & 0xffffu;
    if (r != 0) {
        dst += r;
        n = (n + r) & 0xffffu;
    }
    r = ie_push_qos_capability(dst) & 0xffffu;
    dst += r;
    n = (n + r) & 0xffffu;
    r = ie_push_dmg_capabilities(dst, (u8 *)&mobj->dmg_cap, 0) & 0xffffu;
    return (r + n) & 0xffffu;
}

/* mgmt_tx__build_assoc_req (0x8f9d5c, 298 Б): Assoc Request к пиру conn: MAC-заголовок
 * (подтип 0), фиксированные поля, IE (с внешними IE хоста — слиянием), WFA vendor IE.
 * Длина — в *out_len. mid — запись mid. */
void mgmt_tx_build_assoc_req(u32 payload, u32 *out_len, struct mid *mid, struct conn *conn)
{
    u8 tmp[0x100];
    struct app_ies blk;
    u32 dst, fixed, hdr_fixed, ext, n, w;
    struct app_ies *internal;
    struct mid_bss *mobj = &mid->bss;
    mgmt_tx_build_mac_header(mid, (struct ieee80211_hdr *)payload, 0, conn->peer);
    dst = payload + 0x18;
    fixed = mgmt_tx_assoc_req_fixed_fields((u8 *)dst, mobj, conn);
    fw_log_emit3(0x2d, 0x10139b8, fixed, 0x18, dst);
    hexdump_words((void *)payload, fixed);
    hdr_fixed = (fixed + 0x18) & 0xffffu;
    dst += fixed;
    internal = mid_get_bcon_additional_ies(mobj, 0);
    ext = (conn->vs_version == 0) ? 1u : 0u;
    if (internal != 0 && ies_block_is_empty(internal) != 0) {
        fw_log_emit0(0x2d, 0x10139f4);
        n = mgmt_tx_assoc_req_ies((u8 *)dst, mobj, ext);
    } else {
        u32 m = mgmt_tx_assoc_req_ies(tmp, mobj, ext);
        fw_log_emit1(0x2d, 0x1013a18, m);
        app_ies_set_buffer(&blk, tmp, m, 0);
        n = ies_block_merge(&dst, internal, &blk);
        fw_log_emit1(0x2d, 0x1013a38, m);
    }
    n = (n + hdr_fixed) & 0xffffu;
    w = ie_push_wfa_vendor((u8 *)(payload + n), mid->mac, 0) & 0xffffu;
    n = (n + w) & 0xffffu;
    fw_log_emit2(0x2d, 0x1013a6c, w, n);
    *out_len = n;
    hexdump_words((void *)payload, n);
    fw_log_emit2(0x2d, 0x1013aa8, conn->cid, *out_len);
}

/* frame_builder__assoc_resp_fix_fields (0x8f4f20, 128 Б): Capability Info (mobj+0x5c),
 * Status Code (mlme.status), AID = cid + 1. Длина ≠ n + 4 (только при переполнении
 * u16) — ассерт 0x11d3. */
static u32 assoc_resp_fix_fields(u8 *dst, const struct mid_bss *mobj, struct conn *conn)
{
    u16 v[2];
    u32 n, len;
    u8 *p;

    fw_log_emit0(0x2d, 0x1010120);
    n = push_cap_info(dst, mobj->capinfo_b) & 0xffffu;
    p = dst + n;
    v[0] = conn->mlme.status;
    memcpy_fw(p, &v[0], 2);
    v[1] = (u16)(conn->cid + 1);
    memcpy_fw(p + 2, &v[1], 2);
    len = (n + 4) & 0xffffu;
    if (len != (u32)(p + 4 - dst))
        fw_sysassert_fatal(__builtin_return_address(0), 0x11d3);
    return len;
}

/* mgmt_tx__assoc_resp_tlv (0x8f4fa0, 100 Б): EDCA (из mobj), DMG Capabilities (mobj+0x5e,
 * флаг aid), элемент 0x97 (mobj+0xf8). */
u32 mgmt_tx_assoc_resp_tlv(u8 *dst, struct mid_bss *mobj, u32 aid)
{
    u32 n0, n1, n2, n;

    n0 = ie_push_edca(dst, mobj) & 0xffffu;
    dst += n0;
    n1 = ie_push_dmg_capabilities(dst, (u8 *)&mobj->dmg_cap, aid & 0xffu) & 0xffffu;
    fw_log_emit3(0x2d, 0x100fffc, 0x94, n1, aid);
    n = (n1 + n0) & 0xffffu;
    n2 = ie_push_eid151_len10(dst + n1, mobj->blk_f8) & 0xffffu;
    n = (n + n2) & 0xffffu;
    fw_log_emit2(0x2d, 0x1010018, 0xdd, n2);
    return n;
}

/* mgmt_tx__build_assoc_resp (0x8f9e88, 296 Б): Assoc Response (AP/PCP) пиру conn:
 * MAC-заголовок (подтип 1), фиксированные поля, IE (с IE хоста кадра 1 — слиянием), WFA
 * vendor IE. Длина — в *out_len. В отличие от Assoc Request, блок IE хоста на 0 не
 * проверяется (для подтипа 1 mid__get_bcon_additional_ies 0 не возвращает). */
void mgmt_tx_build_assoc_resp(u32 payload, u32 *out_len, struct mid *mid, struct conn *conn)
{
    u8 tmp[0x100];
    struct app_ies blk;
    u32 dst, fixed, hdr_fixed, n, w, aid;
    struct app_ies *internal;
    struct mid_bss *mobj = &mid->bss;

    dst = payload;
    mgmt_tx_build_mac_header(mid, (struct ieee80211_hdr *)payload, 1, conn->peer);
    fw_log_emit3(0x2d, 0x1013ad8, 0x18, 0, dst);
    hexdump_words((void *)dst, 0x18);
    dst += 0x18;
    fixed = assoc_resp_fix_fields((u8 *)dst, mobj, conn);
    fw_log_emit3(0x2d, 0x1013b14, fixed, 0x18, dst);
    hexdump_words((void *)dst, fixed);
    hdr_fixed = (fixed + 0x18) & 0xffffu;
    dst += fixed;
    internal = mid_get_bcon_additional_ies(mobj, 1);
    aid = (conn->cid + 1) & 0xffu;
    if (ies_block_is_empty(internal) != 0) {
        fw_log_emit0(0x2d, 0x1013b50);
        n = mgmt_tx_assoc_resp_tlv((u8 *)dst, mobj, aid);
    } else {
        u32 m = mgmt_tx_assoc_resp_tlv(tmp, mobj, aid);
        fw_log_emit1(0x2d, 0x1013b74, m);
        app_ies_set_buffer(&blk, tmp, m, 0);
        n = ies_block_merge(&dst, internal, &blk);
    }
    n = (n + hdr_fixed) & 0xffffu;
    w = ie_push_wfa_vendor((u8 *)(payload + n), mid->mac, 0) & 0xffffu;
    n = (n + w) & 0xffffu;
    fw_log_emit2(0x2d, 0x1013a6c, w, n);
    *out_len = n;
    fw_log_emit2(0x2d, 0x1013ba0, conn->cid, n);
}

/* tx_mgmt_srvs__build_disassoc (0x8e9c9c, 44 Б): Disassociation (подтип 0xa), код
 * причины, длина 0x1a. */
static void tx_mgmt_build_disassoc(u32 payload, u32 *out_len, struct mid *mid, struct conn *conn,
                                   u32 reason)
{
    struct ieee80211_disassoc *f = (struct ieee80211_disassoc *)payload;
    mgmt_tx_build_mac_header(mid, &f->h, 0xa, conn->peer);
    f->reason = (u16)reason;
    *out_len = 0x1a;
    fw_log_emit1(0x2d, 0x1013d6c, 0x1a);
}

/* mlme_sm__send_disassoc (0x8f6bc0, 116 Б): послать Disassociation пиру (cb — обработчик
 * завершения TX). */
void mlme_sm_send_disassoc(struct mlme_sm *sm, u32 reason, tx_done_fn cb)
{
    u32 len = 0, payload;
    struct conn *conn;
    payload = TX_API_alloc_tx_payload();
    if (payload == 0)
        fw_sysassert_fatal((void *)0, 0x1201);
    conn = sm->conn;
    tx_mgmt_build_disassoc(payload, &len, conn->mid, conn,
                           reason & 0xffffu);
    if (len == 0)
        fw_sysassert_fatal((void *)0, 0x1202);
    fw_log_emit1(0x2a, 0x1011514, len);
    tx_api_send_mgmt(sm->conn, 0, 1, payload, len & 0xffffu, cb, 0);
}

/* Колбэк завершения TX Assoc Req/Resp (0x8f1fb0, 134 Б; числом 0x31fb0): STA — [+0xc] =
 * «отправлен» (status 0); AP — ASSOC_RESPONSE / ASSOC_REJECT по [+0xc] и статусу [+0x28].
 * Кадр: успех — копия хосту (WMI_TX_MGMT_PACKET), иначе освободить. Ассерт 0x11ff vendor
 * ставит на адрес автомата (conn + 0xf0 == 0), а не на conn — как есть. */
void mlme_assoc_tx_done_cb(u32 payload, u32 status, u32 a2)
{
    struct conn *conn = (struct conn *)a2;
    struct mlme_sm *sm = (struct mlme_sm *)(a2 + 0xf0);
    if (sm == 0)
        fw_sysassert_fatal((void *)0, 0x11ff);
    if (sm->conn->mid->bss.mode == 1) {
        sm->busy = (status == 0) ? 1u : 0u;
    } else if (sm->busy == 1) {
        u32 st = sm->status;
        if (status == 0) {
            mlme_sm_event(sm, 4, status, 0, 0);
        } else {
            sm->busy = 0;
            if (st == 0)
                mlme_sm_event(sm, 5, status, 0, 0);
        }
    }
    if (status == 0)
        TX_API_post_tx_payload(payload, conn->mid->id);
    else
        TX_API_free_memory(payload);
    sm->tx_payload = 0;
}

/* ---------------- таймеры ---------------- */

/* mlme__assoc_timeout_cb (0x8f1054, 44 Б; числом 0x31054): ASSOC_TIMEOUT (6). */
void mlme_assoc_timeout_cb(u32 a0, u32 a1)
{
    struct mlme_sm *sm = (struct mlme_sm *)a0;
    (void)a1;
    fw_log_emit1(0x1a, 0x101132c, sm->assoc_timer);
    if (sm->assoc_timer == 0)
        return;
    sm->assoc_timer = 0;
    mlme_sm_event(sm, 6, 0, 0, 0);
}

/* Таймер после ASSOC_RESPONSE (0x8f2228, 36 Б; числом 0x32228): ASSOC_REJECT (5). */
void mlme_assoc_resp_timeout_cb(u32 a0, u32 a1)
{
    struct mlme_sm *sm = (struct mlme_sm *)a0;
    (void)a1;
    fw_log_emit0(0x1a, 0x101135c);
    sm->assoc_timer = 0;
    mlme_sm_event(sm, 5, 0, 0, 0);
}

/* mlme__ctrl_new_sta_timeout_cb (0x8f2188, 52 Б; числом 0x32188): хост не подтвердил
 * новую станцию — ASSOC_REJECT. */
void mlme_ctrl_new_sta_timeout_cb(u32 a0, u32 a1)
{
    struct mlme_sm *sm = (struct mlme_sm *)a0;
    (void)a1;
    fw_log_emit0(0x1a, 0x10113cc);
    sm->ctrl_timer = 0;
    sm->busy = 0;
    if (sm->rx_pkt != 0) {
        mem_pool_free_thunk(sm->rx_pkt);
        sm->rx_pkt = 0;
    }
    mlme_sm_event(sm, 5, 0, 0, 0);
}

/* Таймер ответа хоста на Assoc Req (0x8f207c, 60 Б; числом 0x3207c): кадр освободить,
 * разрыв (kind 5). */
void mlme_ctrl_assoc_res_timeout_cb(u32 a0, u32 a1)
{
    struct mlme_sm *sm = (struct mlme_sm *)a0;
    (void)a1;
    fw_log_emit0(0x1a, 0x10113b0);
    sm->ctrl_timer = 0;
    if (sm->host_pkt != 0) {
        mgmt_pkt_release(sm->host_pkt);
        mem_pool_free_thunk(sm->host_pkt);
        sm->host_pkt = 0;
    }
    mlme_notify(sm, sm->conn->cid, 1, 5, 0);
}

/* Таймер ответа хоста на удаление станции (0x8c7e40, 72 Б; числом 0x7e40): разрыв
 * (причина 2, протокол 3), кадр освободить. */
void mlme_ctrl_del_sta_timeout_cb(u32 a0, u32 a1)
{
    struct mlme_sm *sm = (struct mlme_sm *)a0;
    (void)a1;
    fw_log_emit0(0x1a, 0x10113e8);
    sm->del_sta_timer = 0;
    mid_disconnect_cmd(sm->conn->mid, sm->conn,
                       2, 3);
    if (sm->host_pkt != 0) {
        fw_log_emit0(0x2a, 0x1011404);
        mgmt_pkt_release(sm->host_pkt);
        mem_pool_free_thunk(sm->host_pkt);
        sm->host_pkt = 0;
    }
    sm->busy = 0;
}

/* ---------------- AP: проверка запроса ассоциации ---------------- */

/* verify_pbc (0x8ebd68, 90 Б): 0 — у кадра есть Wilocity VS (ei->vs_wil) с флагом 3 (PBC),
 * иначе 1. */
static u32 verify_pbc(const struct mid_bss *mobj, const struct rx_mgmt_ei *ei, struct mid *mid)
{
    u32 has = (ei->vs_wil.body != 0) ? 1u : 0u, f = 0;
    (void)mobj;
    if (has)
        f = parse_wilocity_vs_get_flag3((u32)&mid->bss, &ei->vs_wil) & 0xffffu;
    if (has == 0 || f == 0) {
        fw_log_emit3(0x2b, 0x100c50c, has, 0, f);
        return 1;
    }
    fw_log_emit3(0x2b, 0x100c4b8, has, 0, f);
    return 0;
}

/* verify_ssid (0x8ebe18, 72 Б): SSID запроса совпадает с SSID записи (mobj+0x26). */
static u32 verify_ssid(const struct mid_bss *mobj, const u8 *ssid, u32 len)
{
    if (len != mobj->ssid_len) {
        fw_log_emit2(0x2b, 0x100c47c, len, mobj->ssid_len);
        return 0;
    }
    if (memcmp_fw(ssid, mobj->ssid, len) == 0)
        return 1;
    fw_log_emit3(0x2b, 0x100c498, mobj->ssid[0], mobj->ssid[1], mobj->ssid[2]);
    return 0;
}

/* bss_join_verify (0x8c4e80, 68 Б). */
static u32 bss_join_verify(const struct mid_bss *mobj, const struct rx_mgmt_ei *ei, u32 sub,
                           struct mid *mid, u32 *status)
{
    u32 pbc, ok;
    (void)sub;
    (void)status;
    pbc = verify_pbc(mobj, ei, mid) & 1u;
    fw_log_emit1(0x2b, 0x100c658, pbc);
    ok = verify_ssid(mobj, ei->ssid.body, ei->ssid.len);
    fw_log_emit1(0x2b, 0x100c698, ok & pbc);
    return ok & pbc;
}

/* mlme_sm__check_assoc_capacity (0x8c4e4c, 50 Б): места нет — статус 5 (AP full). */
static u32 mlme_sm_check_assoc_capacity(struct mid *mid, const struct rx_mgmt_ei *ei, u32 sub,
                                        u32 *status)
{
    if (mid_count_active_conns(mid) >= mid->max_assoc) {
        *status = 5;
        return 0;
    }
    return bss_join_verify(&mid->bss, ei, sub, mid, status);
}

/* mlme_sm__check_field_2c (0x8c6888, 20 Б): освободить сохранённый кадр rx_pkt. */
static void mlme_sm_check_field_2c(struct mlme_sm *sm)
{
    if (sm->rx_pkt != 0) {
        mem_pool_free_thunk(sm->rx_pkt);
        sm->rx_pkt = 0;
    }
}

/* mlme__parse_wilocity_vs (0x8df860, 38 Б): TLV 4 Wilocity VS — u16 в *out, указатель на
 * данные TLV или 0. */
static const u8 *mlme_parse_wilocity_vs(u32 a0, const struct ie_ref *buf, u16 *out)
{
    const struct wil_vs_tlv *t;
    *out = 0;
    t = parse_wilocity_vs_find_tlv(a0, buf, 4);
    if (t == 0)
        return 0;
    *out = (u16)(t->len[0] | t->len[1] << 8);
    /* числом: vendor add r0,r0,4 и вызывающий проверяет результат на 0 (t = -4 не исключён);
     * t->val gcc считает ненулевым и проверку выкидывает */
    return (const u8 *)((u32)t + __builtin_offsetof(struct wil_vs_tlv, val));
}

/* parse_wilocity_vs_get_netowork_mode (0x8df824, 56 Б): TLV 2 — режим сети (0x40 нет). */
static u32 parse_wilocity_vs_get_network_mode(u32 a0, const struct ie_ref *buf)
{
    const struct wil_vs_tlv *t = parse_wilocity_vs_find_tlv(a0, buf, 2);
    if (t == 0) {
        fw_log_emit0(0x2b, 0x100c814);
        return 0x40;
    }
    fw_log_emit3(0x2b, 0x100c844, t->val[0], t->val[0], t->val[1]);
    return t->val[0];
}

/* parse_wilocity_vs_get_test_mode (0x8df888, 66 Б): TLV 1 — тестовый режим (нет TLV — 1). */
static u32 parse_wilocity_vs_get_test_mode(u32 a0, const struct ie_ref *buf)
{
    const struct wil_vs_tlv *t = parse_wilocity_vs_find_tlv(a0, buf, 1);
    if (t == 0) {
        fw_log_emit0(0x2b, 0x100c714);
        return 1;
    }
    fw_log_emit3(0x2b, 0x100c740, wil_vs_tlv_val16(t), t->val[0], t->val[1]);
    return (t->val[0] != 0) ? 1u : 0u;
}

/* lmac_if__send_sta_cfg_05_c (0x8dc3c4, 44 Б): LMAC-команда 5 (0x28 Б) — RX-сектор
 * станции; остальные поля буфера пула vendor не пишет. */
static void lmac_if_send_sta_cfg_05_c(u32 cid, u32 sector, u32 x)
{
    struct lmac_cmd_sta_cfg *b = mem_pool_alloc_locked(&lmac_mbox.mb);
    b->op = 2;
    b->cid = (u8)cid;
    b->omni_sector = (u16)sector;
    b->omni_rf = (u8)x;
    lmac_if_post_cmd(b, 5, 0x28, 0);
}

/* conn__config_txss_and_sta (0x8dc4ac, 30 Б). */
void conn_config_txss_and_sta(struct conn *conn)
{
    lmac_if_config_txss(conn->cid);
    lmac_if_send_sta_cfg_05_c(conn->cid, conn->rx_sector, *(volatile u8 *)&rf_obj.rf_idx);
}

/* ---------------- действия автомата MLME ---------------- */

/* автомат MLME mlme_sm (vendor sm_802458): описатель 0x802458, таблица 0x80246c */
/* 0x80246c: таблица переходов [событие][состояние] (14 × 3). */
FWDATA(80246c) const struct sm_trans mlme_sm_table[14][3] = {
    [MLME_EV_CONNECT][MLME_UNASSOCIATE] = { SM_ACT(mlme_sm_on_connect), MLME_UNASSOCIATE },
    [MLME_EV_CONNECT][MLME_ASSOCIATE] = { SM_ACT(mlme_sm_on_disconnect), MLME_UNASSOCIATE },
    [MLME_EV_CONNECT][MLME_ASSOCIATED] = { SM_ACT(mlme_sm_on_disconnect), MLME_UNASSOCIATE },
    [MLME_EV_DISCONNECT][MLME_UNASSOCIATE] = { SM_ACT(mlme_sm_on_disconnect), MLME_UNASSOCIATE },
    [MLME_EV_DISCONNECT][MLME_ASSOCIATE] = { SM_ACT(mlme_sm_on_disconnect), MLME_UNASSOCIATE },
    [MLME_EV_DISCONNECT][MLME_ASSOCIATED] = { SM_ACT(mlme_sm_on_disconnect), MLME_UNASSOCIATE },
    [MLME_EV_DISASSOCIAT][MLME_UNASSOCIATE] = { SM_ACT(mlme_sm_on_disconnect), MLME_UNASSOCIATE },
    [MLME_EV_DISASSOCIAT][MLME_ASSOCIATE] = { SM_ACT(mlme_sm_on_disassoc), MLME_UNASSOCIATE },
    [MLME_EV_DISASSOCIAT][MLME_ASSOCIATED] = { SM_ACT(mlme_sm_on_disassoc), MLME_UNASSOCIATE },
    [MLME_EV_ASSOC_RESPONSE_START][MLME_UNASSOCIATE] = { SM_ACT(mlme_sm_on_assoc_response_start), MLME_UNASSOCIATE },
    [MLME_EV_ASSOC_RESPONSE_START][MLME_ASSOCIATE] = { SM_ACT(basic_sm_error_handler), MLME_ASSOCIATE },
    [MLME_EV_ASSOC_RESPONSE_START][MLME_ASSOCIATED] = { SM_ACT(basic_sm_error_handler), MLME_ASSOCIATED },
    [MLME_EV_ASSOC_RESPONSE][MLME_UNASSOCIATE] = { SM_ACT(mlme_sm_on_assoc_response), MLME_ASSOCIATE },
    [MLME_EV_ASSOC_RESPONSE][MLME_ASSOCIATE] = { SM_ACT(sm_action_nop), MLME_ASSOCIATE },
    [MLME_EV_ASSOC_RESPONSE][MLME_ASSOCIATED] = { SM_ACT(sm_action_nop), MLME_ASSOCIATED },
    [MLME_EV_ASSOC_REJECT][MLME_UNASSOCIATE] = { SM_ACT(mlme_sm_on_assoc_reject), MLME_UNASSOCIATE },
    [MLME_EV_ASSOC_REJECT][MLME_ASSOCIATE] = { SM_ACT(mlme_sm_on_assoc_reject), MLME_UNASSOCIATE },
    [MLME_EV_ASSOC_REJECT][MLME_ASSOCIATED] = { SM_ACT(sm_action_nop), MLME_ASSOCIATED },
    [MLME_EV_ASSOC_TIMEOUT][MLME_UNASSOCIATE] = { SM_ACT(mlme_sm_on_assoc_timeout), MLME_UNASSOCIATE },
    [MLME_EV_ASSOC_TIMEOUT][MLME_ASSOCIATE] = { SM_ACT(mlme_sm_on_assoc_timeout), MLME_UNASSOCIATE },
    [MLME_EV_ASSOC_TIMEOUT][MLME_ASSOCIATED] = { SM_ACT(basic_sm_error_handler), MLME_UNASSOCIATE },
    [MLME_EV_RM_CHANNEL_LOCKED][MLME_UNASSOCIATE] = { SM_ACT(mlme_sm_on_rm_channel_locked), MLME_UNASSOCIATE },
    [MLME_EV_RM_CHANNEL_LOCKED][MLME_ASSOCIATE] = { SM_ACT(basic_sm_error_handler), MLME_UNASSOCIATE },
    [MLME_EV_RM_CHANNEL_LOCKED][MLME_ASSOCIATED] = { SM_ACT(basic_sm_error_handler), MLME_UNASSOCIATE },
    [MLME_EV_DATA_PORT_OPEN][MLME_UNASSOCIATE] = { SM_ACT(sm_action_nop), MLME_UNASSOCIATE },
    [MLME_EV_DATA_PORT_OPEN][MLME_ASSOCIATE] = { SM_ACT(mlme_sm_on_data_port_open), MLME_ASSOCIATED },
    [MLME_EV_DATA_PORT_OPEN][MLME_ASSOCIATED] = { SM_ACT(sm_action_nop), MLME_ASSOCIATED },
    [MLME_EV_WAITFOR_CTRL_ASSOC_RES][MLME_UNASSOCIATE] = { SM_ACT(mlme_sm_on_waitfor_ctrl_assoc_res), MLME_UNASSOCIATE },
    [MLME_EV_WAITFOR_CTRL_ASSOC_RES][MLME_ASSOCIATE] = { SM_ACT(mlme_sm_on_disconnect), MLME_UNASSOCIATE },
    [MLME_EV_WAITFOR_CTRL_ASSOC_RES][MLME_ASSOCIATED] = { SM_ACT(mlme_sm_on_disconnect), MLME_UNASSOCIATE },
    [MLME_EV_CTRL_ASSOC_RESPONSE_RET][MLME_UNASSOCIATE] = { SM_ACT(mlme_sm_on_ctrl_assoc_response_ret), MLME_UNASSOCIATE },
    [MLME_EV_CTRL_ASSOC_RESPONSE_RET][MLME_ASSOCIATE] = { SM_ACT(basic_sm_error_handler), MLME_ASSOCIATE },
    [MLME_EV_CTRL_ASSOC_RESPONSE_RET][MLME_ASSOCIATED] = { SM_ACT(basic_sm_error_handler), MLME_ASSOCIATED },
    [MLME_EV_CTRL_NEW_STA][MLME_UNASSOCIATE] = { SM_ACT(mlme_sm_on_ctrl_new_sta), MLME_UNASSOCIATE },
    [MLME_EV_CTRL_NEW_STA][MLME_ASSOCIATE] = { SM_ACT(basic_sm_error_handler), MLME_ASSOCIATE },
    [MLME_EV_CTRL_NEW_STA][MLME_ASSOCIATED] = { SM_ACT(basic_sm_error_handler), MLME_ASSOCIATED },
    [MLME_EV_WAITFOR_CTRL_DEL_STA][MLME_UNASSOCIATE] = { SM_ACT(mlme_sm_on_waitfor_ctrl_del_sta), MLME_UNASSOCIATE },
    [MLME_EV_WAITFOR_CTRL_DEL_STA][MLME_ASSOCIATE] = { SM_ACT(mlme_sm_on_waitfor_ctrl_del_sta), MLME_ASSOCIATE },
    [MLME_EV_WAITFOR_CTRL_DEL_STA][MLME_ASSOCIATED] = { SM_ACT(mlme_sm_on_waitfor_ctrl_del_sta), MLME_ASSOCIATED },
    [MLME_EV_CTRL_DEL_STA][MLME_UNASSOCIATE] = { SM_ACT(mlme_sm_on_ctrl_del_sta), MLME_UNASSOCIATE },
    [MLME_EV_CTRL_DEL_STA][MLME_ASSOCIATE] = { SM_ACT(mlme_sm_on_ctrl_del_sta), MLME_ASSOCIATE },
    [MLME_EV_CTRL_DEL_STA][MLME_ASSOCIATED] = { SM_ACT(mlme_sm_on_ctrl_del_sta), MLME_ASSOCIATED },
};

/* 0x802458: описатель (ид [0x10] пишет конструктор). */
extern const u32 mlme_sm_state_names[3];   /* определение ниже */
extern const u32 mlme_sm_event_names[14];   /* определение ниже */
FWDATA(802458) struct sm_desc mlme_sm_desc = {
    .n_events = 14, .n_states = 3, .init_state = MLME_UNASSOCIATE,
    .table = &mlme_sm_table[0][0],
    .state_names = mlme_sm_state_names, .event_names = mlme_sm_event_names,
};

/* mlme_sm_802458__action_8f1080 (0x8f1080, 524 Б; CONNECT в UNASSOCIATE). AP/PCP — разбор
 * Assoc Request pkt: нет места / не тот SSID — сразу Assoc Response с отказом (статус в
 * [sp+4]) и разрыв; иначе Wilocity VS (старый формат ei+0x9c или TLV), TXSS и STA-конфиг
 * uc, кадр в [+0x2c]. Затем (и для STA сразу) — запрос радио (колбэк 0x8e2178) и таймер
 * ассоциации [0x8002e4] мс. */
void mlme_sm_on_connect(struct mlme_sm *sm, struct rx_pkt *pkt)
{
    u32 delay = mlme_assoc_timeout_ms * 1000u;
    struct conn *conn = sm->conn;
    u32 st = conn->mid->bss.mode;
    if (st == 2 || st == 3) {
        u32 status = 0xd, len = 0;
        const struct rx_mgmt_ei *ei;
        const struct wil_vs_old *vs;
        struct mid *mid;
        if (pkt == 0)
            fw_sysassert_fatal((void *)0, 0x11f7);
        mid = sm->conn->mid;
        if (mid == 0)
            fw_sysassert_fatal((void *)0, 0x11f8);
        mlme_sm_check_field_2c(sm);
        if (mlme_sm_check_assoc_capacity(mid, pkt->ei, FC_STYPE(pkt->hdr->fc), &status) == 0 &&
            sm->busy == 0) {
            sm->status = 0x25;
            fw_log_emit1(0x1a, 0x101141c, pkt->info.cid);
            sm->tx_payload = TX_API_alloc_tx_payload();
            if (sm->tx_payload == 0)
                fw_sysassert_fatal((void *)0, 0x11f9);
            mgmt_tx_build_assoc_resp(sm->tx_payload, &len,
                                     sm->conn->mid,
                                     sm->conn);
            tx_api_send_mgmt_with_cb(sm->conn, 0, 1, sm->tx_payload, len & 0xffffu,
                                     7, 80, mlme_assoc_tx_done_cb, 0);
            mlme_notify(sm, sm->conn->cid, status, 5, 0);
            mgmt_pkt_release(pkt);
            mem_pool_free_thunk(pkt);
            return;
        }
        ei = pkt->ei;
        vs = (const struct wil_vs_old *)ei->vs_wil_old.body;
        if (vs != 0) {
            struct mid *m = sm->conn->mid;
            u32 v = vs->net_type[0] | (u32)vs->net_type[1] << 8;
            set_old_wilocity_vs(&m->bss, 0, m->network_type, v);
            sm->conn->wvs_mode = v;
            fw_log_emit3(0x2a, 0x1011440, vs->cap[0] | (u32)vs->cap[1] << 8, v,
                         vs->board[0]);
        } else if (ei->vs_wil.body != 0) {
            u32 m0 = (u32)&mid->bss, test, nm, f3, f;
            const struct ie_ref *buf = &ei->vs_wil;
            test = parse_wilocity_vs_get_test_mode(m0, buf);
            nm = parse_wilocity_vs_get_network_mode(m0, buf);
            f3 = parse_wilocity_vs_get_flag3(m0, buf);
            f = (f3 != 0) ? 3u : ((test != 0) ? 1u : 0u);
            fw_log_emit3(0x2a, 0x1011484, nm, test, f3);
            vendor_ie_build_wilocity(&(sm->conn->mid)->bss,
                                     nm, f);
            sm->conn->wvs_mode = test;
        }
        conn_config_txss_and_sta(sm->conn);
        sm->rx_pkt = pkt;
        mgmt_pkt_release(pkt);
        sm->status = 0;
    }
    fw_log_emit1(0x2a, 0x10114c0, sm->sm.state);
    if (sm->rm_req == 0)
        sm->rm_req = l2mgr_connect_args(mlme_rm_locked_cb, (u32)sm,
                                        sm->conn->mid->id);
    if (sm->assoc_timer == 0)
        sm->assoc_timer = u_schd_schedule(mlme_assoc_timeout_cb, (u32)sm, 0, 1, delay, 0, 0);
}

/* mlme_sm_802458__action_8c5cfc (0x8c5cfc, 334 Б; RM_CHANNEL_LOCKED в UNASSOCIATE): радио
 * захвачено (req). STA — Assoc Request и ASSOC_RESPONSE_START себе; AP (без
 * [0x803c28]) — Assoc Response. Кадр — в TX (колбэк 0x8f1fb0, категория 0 / 4), [+0xc] = 1,
 * таймер ассоциации, если ещё нет. */
void mlme_sm_on_rm_channel_locked(struct mlme_sm *sm, u32 req)
{
    u32 delay = mlme_assoc_timeout_ms * 1000u;
    u32 len = 0, cat = 0, sta;
    struct mid *mid;
    struct conn *conn;
    sm->rm_req = (struct rm_req *)req;
    sm->radio_locked = 1;
    if (sm->assoc_timer != 0) {
        u_schd_cancel(sm->assoc_timer);
        sm->assoc_timer = 0;
    }
    sta = (sm->conn->mid->bss.mode == 1) ? 1u : 0u;
    if (sta || dashboard.cfg.ap_sme_offload_mode == 0) {
        sm->tx_payload = TX_API_alloc_tx_payload();
        if (sm->tx_payload == 0)
            fw_sysassert_fatal((void *)0, 0x11fa);
    }
    conn = sm->conn;
    mid = conn->mid;
    if (mid->bss.mode == 1) {
        mgmt_tx_build_assoc_req(sm->tx_payload, &len, mid, conn);
        fw_log_emit1(0x2a, 0x10114e4, len);
    } else if (dashboard.cfg.ap_sme_offload_mode == 0) {
        mgmt_tx_build_assoc_resp(sm->tx_payload, &len, mid, conn);
        fw_log_emit1(0x2a, 0x10114fc, len);
        cat = 4;
    }
    if (sm->conn->mid->bss.mode == 1)
        mlme_sm_defer(sm, 3, 0, 0, 0);
    if (sm->conn->mid->bss.mode != 1 &&
        dashboard.cfg.ap_sme_offload_mode != 0)
        return;
    if (len == 0)
        fw_sysassert_fatal((void *)0, 0x11fb);
    tx_api_send_mgmt_with_cb(sm->conn, 0, 1, sm->tx_payload, len & 0xffffu, 7, 80,
                             mlme_assoc_tx_done_cb, cat);
    sm->busy = 1;
    if (sm->assoc_timer == 0)
        sm->assoc_timer = u_schd_schedule(mlme_assoc_timeout_cb, (u32)sm, 0, 1, delay, 0, 0);
}

/* mlme_sm_802458__action_8f102c (0x8f102c, 38 Б; ASSOC_RESPONSE_START в UNASSOCIATE):
 * NTF_ASSOC_START автомату соединения. */
void mlme_sm_on_assoc_response_start(struct mlme_sm *sm)
{
    fw_log_emit0(0x2a, 0x10115f0);
    mlme_notify(sm, sm->conn->cid, 1, 3, 0);
}

/* mlme_sm_802458__action_8f0f4c (0x8f0f4c, 220 Б; ASSOC_RESPONSE в UNASSOCIATE): STA (не
 * PBSS) — Wilocity VS (TLV 4) из ответа, кадр в [+0x2c] для WMI_CONNECT_EVENT, aid записи
 * mid = AID ответа (ei+0xca), aid соединения 0. Таймер [0x800088] мс (затем
 * ASSOC_REJECT) и NTF_ASSOC_DONE. */
void mlme_sm_on_assoc_response(struct mlme_sm *sm, struct rx_pkt *pkt)
{
    u32 delay = mlme_assoc_resp_timeout_ms * 1000u;
    struct conn *conn;
    fw_log_emit0(0x2a, 0x1011608);
    if (sm->assoc_timer != 0) {
        u_schd_cancel(sm->assoc_timer);
        sm->assoc_timer = 0;
    }
    conn = sm->conn;
    if (conn->mid->bss.mode == 1 && conn->pbss == 0) {
        u16 v = 0;
        u32 mobj = (u32)&sm->conn->mid->bss;
        if (pkt == 0)
            fw_sysassert_fatal((void *)0, 0x11fc);
        if (pkt->ei->vs_wil.body != 0) {
            const u8 *r = mlme_parse_wilocity_vs(mobj, &pkt->ei->vs_wil, &v);
            if (v != 0 && r != 0)
                fw_log_emit0(0x2a, 0x101161c);
        } else {
            fw_log_emit0(0x2a, 0x1011658);
        }
        sm->rx_pkt = pkt;
        sm->conn->mid->aid = (u8)pkt->ei->aid;
        sm->conn->aid = 0;
        mgmt_pkt_release(pkt);
    }
    sm->assoc_timer = u_schd_schedule(mlme_assoc_resp_timeout_cb, (u32)sm, 0, 1, delay, 0, 0);
    mlme_notify(sm, sm->conn->cid, 1, 4, 0);
}

/* mlme_sm__assoc_reject_ev_handle (0x8f0eb4, 150 Б; ASSOC_REJECT в UNASSOCIATE /
 * ASSOCIATE): таймер и радио освободить; STA — кадр отказа в [+0x2c]; разрыв (kind 5). */
void mlme_sm_on_assoc_reject(struct mlme_sm *sm, struct rx_pkt *pkt)
{
    fw_log_emit0(0x2a, 0x101168c);
    if (sm->assoc_timer != 0) {
        u_schd_cancel(sm->assoc_timer);
        sm->assoc_timer = 0;
    }
    fw_log_emit2(0x20, 0x10116a0, (u32)sm->rm_req, sm->radio_locked);
    mlme_release_radio(sm);
    sm->rm_req = 0;
    sm->radio_locked = 0;
    if (sm->conn->mid->bss.mode == 1 && pkt != 0) {
        sm->rx_pkt = pkt;
        mgmt_pkt_release(pkt);
    }
    mlme_notify(sm, sm->conn->cid, 1, 5, 0);
}

/* mlme_sm__association_timeout_ev_handle (0x8f131c, 152 Б; ASSOC_TIMEOUT в UNASSOCIATE /
 * ASSOCIATE): STA — Disassociation (причина 1) и разрыв (kind 5); сохранённый кадр и
 * радио освободить. */
void mlme_sm_on_assoc_timeout(struct mlme_sm *sm, u32 a0, u32 a1, u32 cb)
{
    (void)a0;
    (void)a1;
    fw_log_emit0(0x2a, 0x1011534);
    sm->assoc_timer = 0;
    if (sm->conn->mid->bss.mode == 1) {
        mlme_sm_send_disassoc(sm, 1, (tx_done_fn)cb);   /* аргумент автомата — числом */
        mlme_notify(sm, sm->conn->cid, 1, 5, 0);
    }
    sm->busy = 0;
    if (sm->rx_pkt != 0) {
        mem_pool_free_thunk(sm->rx_pkt);
        sm->rx_pkt = 0;
    }
    fw_log_emit2(0x20, 0x1011550, (u32)sm->rm_req, sm->radio_locked);
    mlme_release_radio(sm);
    sm->rm_req = 0;
    sm->radio_locked = 0;
}

/* mlme_sm__data_port_open_ev_handle (0x8f21c0, 102 Б; DATA_PORT_OPEN в ASSOCIATE): таймер
 * и радио освободить. */
void mlme_sm_on_data_port_open(struct mlme_sm *sm)
{
    fw_log_emit0(0x2a, 0x10117dc);
    if (sm->assoc_timer != 0) {
        u_schd_cancel(sm->assoc_timer);
        sm->assoc_timer = 0;
    }
    fw_log_emit2(0x20, 0x10117f4, (u32)sm->rm_req, sm->radio_locked);
    mlme_release_radio(sm);
    sm->rm_req = 0;
    sm->radio_locked = 0;
}

/* mlme_sm_802458__action_8f2444 (0x8f2444, 124 Б; DISASSOCIAT в ASSOCIATE / ASSOCIATED):
 * Disassociation от пира — разрыв пиром (kind 2, код причины ei->status), кадры освободить. */
void mlme_sm_on_disassoc(struct mlme_sm *sm, struct rx_pkt *pkt)
{
    if (pkt == 0)
        fw_sysassert_fatal((void *)0, 0x11fe);
    fw_log_emit2(0x2a, 0x10116e8, sm->sm.state, pkt->ei->status);
    sm->busy = 0;
    mlme_notify(sm, sm->conn->cid, pkt->ei->status, 2, 0);
    fw_log_emit0(0x2a, 0x1011404);
    mgmt_pkt_release(pkt);
    mem_pool_free_thunk(pkt);
    if (sm->rx_pkt != 0) {
        fw_log_emit0(0x2a, 0x1011714);
        mem_pool_free_thunk(sm->rx_pkt);
        sm->rx_pkt = 0;
    }
}

/* mlme_sm__disconnect_ev_handle (0x8f26a8, 228 Б; CONNECT в ASSOCIATE / ASSOCIATED,
 * DISCONNECT в UNASSOCIATE): кадр освободить; шёл обмен Assoc ([+0xc] == 1) и нет
 * [0x803c28] (или он 1 без операции 5) — Disassociation (reason, cb; [conn+0x148] = 1 при
 * cb); радио, таймер, сохранённый кадр освободить; разрыв (kind 1, a2 = 3). */
void mlme_sm_on_disconnect(struct mlme_sm *sm, struct rx_pkt *pkt, u32 reason, u32 cb)
{
    if (pkt != 0) {
        fw_log_emit0(0x2a, 0x1011734);
        mgmt_pkt_release(pkt);
        mem_pool_free_thunk(pkt);
    }
    fw_log_emit2(0x2a, 0x1011750, sm->sm.state, reason);
    if (sm->busy == 1) {
        u32 b = dashboard.cfg.ap_sme_offload_mode;
        if (b == 0 || (b == 1 && l2mgr_is_busy_flag_set(5) == 0)) {
            fw_log_emit0(0x2a, 0x1011778);
            if (cb != 0)
                sm->conn->msm.disc.wait = 1;
            mlme_sm_send_disassoc(sm, reason, (tx_done_fn)cb);   /* аргумент автомата — числом */
        }
    }
    sm->busy = 0;
    fw_log_emit2(0x20, 0x1011798, (u32)sm->rm_req, sm->radio_locked);
    mlme_release_radio(sm);
    sm->rm_req = 0;
    sm->radio_locked = 0;
    if (sm->assoc_timer != 0) {
        u_schd_cancel(sm->assoc_timer);
        sm->assoc_timer = 0;
    }
    mlme_notify(sm, sm->conn->cid, 3, 1, 0);
    if (sm->rx_pkt != 0) {
        mem_pool_free_thunk(sm->rx_pkt);
        sm->rx_pkt = 0;
    }
}

/* mlme_sm_802458__action_8fb430 (0x8fb430, 76 Б; WAITFOR_CTRL_ASSOC_RES в UNASSOCIATE):
 * split MAC — ждать решения хоста ([+0xc] = 1, таймер [0x8002ec] мс). */
void mlme_sm_on_waitfor_ctrl_assoc_res(struct mlme_sm *sm)
{
    u32 delay;
    fw_log_emit1(0x2a, 0x101183c, sm->sm.state);
    sm->busy = 1;
    delay = mlme_host_ctrl_timeout_ms * 1000u;
    if (sm->ctrl_timer != 0)
        return;
    fw_log_emit0(0x2a, 0x101186c);
    sm->ctrl_timer = u_schd_schedule(mlme_ctrl_assoc_res_timeout_cb, (u32)sm, 0, 1, delay, 0, 0);
}

/* mlme_sm_802458__action_8f20bc (0x8f20bc, 202 Б; CTRL_ASSOC_RESPONSE_RET в UNASSOCIATE):
 * ответ хоста (cmd — кадр Assoc Response: статус, aid). Принят — CONNECT с кадром [+0x30]
 * и таймер подтверждения новой станции; иначе кадр освободить и разрыв (kind 5). */
void mlme_sm_on_ctrl_assoc_response_ret(struct mlme_sm *sm, const struct ieee80211_assoc_resp *cmd)
{
    u32 delay, status;
    struct rx_pkt *pkt;
    fw_log_emit1(0x2a, 0x10118ac, sm->sm.state);
    delay = mlme_host_ctrl_timeout_ms * 1000u;
    if (sm->ctrl_timer != 0) {
        u_schd_cancel(sm->ctrl_timer);
        sm->ctrl_timer = 0;
    }
    status = cmd->status;
    sm->conn->aid = (u8)cmd->aid;
    fw_log_emit2(0x2a, 0x10118d8, sm->conn->cid, sm->conn->aid);
    pkt = sm->host_pkt;
    sm->host_pkt = 0;
    fw_log_emit1(0x2a, 0x1011914, status);
    if (status == 0) {
        fw_log_emit0(0x2a, 0x1011928);
        mlme_sm_event(sm, 0, (u32)pkt, 0, 0);
        sm->ctrl_timer = u_schd_schedule(mlme_ctrl_new_sta_timeout_cb, (u32)sm, 0, 1, delay, 0, 0);
        return;
    }
    fw_log_emit0(0x2a, 0x1011940);
    mgmt_pkt_release(pkt);
    mem_pool_free_thunk(pkt);
    sm->busy = 0;
    mlme_notify(sm, sm->conn->cid, 1, 5, 0);
}

/* mlme_sm_802458__action_8c7e88 (0x8c7e88, 80 Б; CTRL_NEW_STA в UNASSOCIATE): хост
 * подтвердил станцию — ASSOC_RESPONSE; без ожидания — DISCONNECT_EVENT (1, 6). */
void mlme_sm_on_ctrl_new_sta(struct mlme_sm *sm, u32 mac)
{
    fw_log_emit0(0x2a, 0x1011954);
    if (sm->ctrl_timer != 0) {
        u_schd_cancel(sm->ctrl_timer);
        sm->ctrl_timer = 0;
        fw_log_emit0(0x2a, 0x101196c);
        mlme_sm_event(sm, 4, 0, 0, 0);
        return;
    }
    l2mgr_send_disconnect_evt((const u8 *)mac, 1, 6,
                              sm->conn->mid->id);
}

/* mlme_sm_802458__action_8ec00c (0x8ec00c, 76 Б; WAITFOR_CTRL_DEL_STA): ждать удаления
 * станции хостом (таймер [0x8002ec] мс). */
void mlme_sm_on_waitfor_ctrl_del_sta(struct mlme_sm *sm)
{
    u32 delay;
    fw_log_emit1(0x2a, 0x101198c, sm->sm.state);
    delay = mlme_host_ctrl_timeout_ms * 1000u;
    sm->busy = 0;
    if (sm->del_sta_timer != 0)
        return;
    fw_log_emit0(0x2a, 0x10119b8);
    sm->del_sta_timer = u_schd_schedule(mlme_ctrl_del_sta_timeout_cb, (u32)sm, 0, 1, delay, 0, 0);
}

/* mlme_sm_802458__action_8c7de0 (0x8c7de0, 92 Б; CTRL_DEL_STA): хост удалил станцию —
 * ожидавшийся Disassoc (код 8 в [+0x2a]) — DISASSOCIAT с кадром [+0x30]; иначе разрыв
 * (причина 2, протокол из cmd +6); нет такой — DISCONNECT_EVENT (1, 2). */
void mlme_sm_on_ctrl_del_sta(struct mlme_sm *sm, const struct wmi_disconnect_sta_cmd *cmd)
{
    fw_log_emit0(0x2a, 0x10119f0);
    if (sm->del_sta_timer != 0) {
        u_schd_cancel(sm->del_sta_timer);
        sm->del_sta_timer = 0;
        if (sm->host_reason == 8) {
            struct rx_pkt *pkt = sm->host_pkt;
            sm->host_pkt = 0;
            sm->host_reason = 1;
            mlme_sm_event(sm, 2, (u32)pkt, 0, 0);
            return;
        }
        if (mid_disconnect_cmd(sm->conn->mid,
                               sm->conn, 2,
                               cmd->disconnect_reason) != 0)
            return;
    }
    l2mgr_send_disconnect_evt((const u8 *)cmd, 1, 2,
                              sm->conn->mid->id);
}

/* ---------------- разрыв соединения ---------------- */


/* link_lost_diag_part2 (0x8f2250, 250 Б): диагностический журнал при потере линка
 * («LLD Part 2»): статистика приёма PHY, температура BB (MARLON-M: < 90 °C — норма,
 * < 100 °C — HIGH, иначе VERY HIGH) и каждого подключённого RF (MARLON-R, маска RF
 * объекта 0x8042c8: < 70 °C — норма; иначе HIGH / VERY HIGH по порогу 80 °C).
 * Баг vendor: порог 80 °C для RF сравнивается с температурой BB (r15), не RF (r13)
 * (0x8f231c: brge r15,0x13880) — как есть; печатается температура RF. */
void link_lost_diag_part2(void)
{
    s32 bb, t;
    u32 i, tok;
    fw_log_emit0(0x20, 0x1000cbc);
    fw_log_emit0(0x20, 0x1000e18);
    fw_log_emit0(0x20, 0x1000cbc);
    link_lost_diag_rx_status();
    bb = basic_calib_get_bb_temperature(0);
    if (bb == -1) {
        fw_log_emit0(0x20, 0x1000e60);
    } else {
        if (bb < 90000)
            tok = 0x1000e88;
        else if (bb < 100000)
            tok = 0x1000ea8;
        else
            tok = 0x1000ecc;
        fw_log_emit1(0x20, tok, (u32)fw_divmod_signed(bb, 1000));
    }
    for (i = 0; i < 8; i++) {
        if (!(rf_get_connected_mask(&rf_obj) & (1u << i)))
            continue;
        t = (s32)temp_get_rf_by_index(i, 0);
        if (t == -1) {
            fw_log_emit0(0x20, 0x1000ef4);
            continue;
        }
        if (t < 70000)
            tok = 0x1000f24;
        else if (bb < 80000)                       /* баг vendor: bb, не t */
            tok = 0x1000f4c;
        else
            tok = 0x1000f78;
        fw_log_emit1(0x20, tok, (u32)fw_divmod_signed(t, 1000));
    }
    fw_log_emit0(0x20, 0x1000fac);
}

/* mac__program_886c00_entry (0x8ea360, 56 Б): запись таблицы 0x886c00 (3 слова) и
 * запуск записи через 0x886bf8/0x886bfc; ожидание сброса бита 29. */
void mac_program_886c00_entry(u32 a, u32 b, u32 c)
{
    MMIO32(HW_MAC_IND_WR_DATA0) = a;
    MMIO32(HW_MAC_IND_WR_DATA1) = b;
    MMIO32(HW_MAC_IND_WR_DATA2) = c;
    MMIO32(HW_MAC_TBL_886C00_CMD) = 0x80000000u;
    MMIO32(HW_MAC_TBL_886C00_CTRL) = 0x40000000u;
    arc_sync();
    while (MMIO32(HW_MAC_TBL_886C00_CTRL) & (1u << 29))
        ;
}

/* l2mgr__send_pbss_leave_evt (0x8f89ec, 78 Б): событие 0x16 (0xa Б) {MAC пира, тип сети,
 * cid}. */
static void l2mgr_send_pbss_leave_evt(struct conn *conn)
{
    u8 *p = (u8 *)host_if_send_pair();
    u32 cid;
    p[6] = (u8)conn->mid->network_type;
    cid = conn->cid;
    p[7] = (u8)cid;
    memcpy_fw(p, conn->peer, 6);
    fw_log_emit1(0x2b, 0x100d268, cid);
    low_sme_send_evt2sw(p, 0x16, 0xa, conn->mid->id, 0, 0, 0);
}

/* cnt_handler__clear_all (0x8f6424) — hw_init.c (сверено с vendor: повтор фазы 1 с
 * [0x8003d8]++, счёт опросов lp N+1 при счётчике N — особенность vendor описана там). */

/* dashboard__on_disconnect (0x8eab88, 64 Б): счётчик соединений − 1, бит cid снять. */
static void dashboard_on_disconnect(u32 cid)
{
    u32 w;
    if ((s32)cid >= (s32)SPARRAW_MAX_STA)
        fw_sysassert_fatal((void *)0, 0x111b);
    w = VOL(fw_stats_dash.state);
    VOL(fw_stats_dash.state) = (w & 0x1fffffffu) | ((((w >> 29) - 1) & 7u) << 29);
    VOL(fw_stats_dash.conn_mask) = (u8)(VOL(fw_stats_dash.conn_mask) & ~(1u << cid));
}

/* l2_mgr__chk_sys_idle — l2mgr.c (там static; у vendor результат здесь не используется,
 * остаётся только ассерт при пустой записи mid). */
static void conn_chk_sys_idle(void)
{
    u32 it = mids_get_count();
    while (bit_iter_has_more(&it)) {
        if (mid_list_by_mid_fw(bitmap_alloc_bit(&it)) == 0)
            fw_sysassert_fatal((void *)0, 0x16c5);
    }
}

/* mlme_sm__disconnect_ev_handle (0x8f25c8, 222 Б; задача conn_main_sm 0x8c9050, числом
 * 0x325c8): соединение разорвано. code: байт 0 — причина (1 — потеря линка: диагностика),
 * биты 16.. — protocol_reason. Очереди cid (метод [8] vring_schd), MAC-таблица, LMAC 0x1b
 * для mid 0 (если у записи не осталось STA), событие хосту (PBSS leave или
 * WMI_DISCONNECT_EVENT), счётчики, conn_mgr link down, состояние fw 4, снятие основного
 * канала (STA), termination check, дашборд, системное состояние 8.
 * Vendor передаёт mid__state_is_2_or_3 (0x8da488) указатель записи mid вместо номера —
 * mid_list__by_mid_fw сравнивает номер целиком (не байт) и не находит записи, состояние
 * читается из [0x50] (адрес 0x50, не запись). Здесь — состояние самой записи [e+0x50]. */
void mlme_sm_disconnect_ev_handle(u32 a0, u32 code)
{
    struct conn *conn = (struct conn *)a0;
    u32 cid = conn->cid, reason = code & 0xffu, st;
    struct mid *e;
    struct vring_schd_if *tbl;
    e = mid_list_by_mid_fw(conn->mid->id);
    if (e == 0)
        fw_sysassert_fatal((void *)0, 0x16c1);
    fw_log_emit2(0x2b, 0x100d304, conn->cid, reason);
    if (reason == 1)
        link_lost_diag_part2();
    tbl = vring_active_ring_table();
    tbl->vt->allow(tbl, (u8)(1u << conn->cid));
    fw_log_emit1(0x2b, 0x100d334, conn->cid);
    mac_program_886c00_entry(conn->cid, 0, 0);
    if (mid_list_find_by_kind(conn->mid, 1) == 0)
        conn_alloc_and_link(0, 1, 0);                    /* conn__alloc_and_link__thunk_0_1_0 */
    if (conn->pbss != 0)
        l2mgr_send_pbss_leave_evt(conn);
    else
        l2mgr_send_disconnect_evt(conn->peer, code >> 16, reason,
                                  conn->mid->id);
    cnt_handler_clear_all();
    conn_mgr_link_down_evt(conn);
    fw_status_set_state(4);
    st = e->bss.mode;
    if (st != 2 && st != 3 && conn->pbss == 0)
        radio_mgr_unset_primary_channel();
    low_sme_termination_check(0);
    dashboard_on_disconnect(cid);
    tdma_ap_update(e, conn);                    /* простой TDMA точки (fw/tdma.c) */
    conn_chk_sys_idle();
    if (conn->pbss == 0)
        sys_state_broadcast(8, cid);
}

/* ---------------- SW TX mgmt (split MAC: кадр от хоста) ---------------- */

/* 0x8000c4 / 0x800184: кадр SW TX (заголовок перед payload) и колбэк его владельца. */
FWDATA(8000c4) struct sw_tx_hdr *volatile sw_tx_mgmt_ctx = 0;
FWDATA(800184) volatile sw_tx_done_fn sw_tx_mgmt_cb = 0;

/* sw_tx_mgmt__clear_link_ctx (0x8e2930, 10 Б). */
void sw_tx_mgmt_clear_link_ctx(void)
{
    sw_tx_mgmt_ctx = 0;
    sw_tx_mgmt_cb = 0;
}

/* SW_TX_MGMT_API::packet_release (0x8df624, 52 Б): уведомить владельца (cb(status ? 2 : 0,
 * mid)) и освободить кадр. */
void sw_tx_mgmt_packet_release(u32 payload, u32 status, u32 mid, sw_tx_done_fn cb)
{
    fw_log_emit1(0x27, 0x1018834, (u32)cb);
    if (cb != 0)
        cb((status != 0) ? 2u : 0u, mid);
    TX_API_free_memory(payload);
}

/* sw_tx_mgmt__tx_complete_cb (0x8e9b1c, 132 Б; числом 0x29b1c): кадр хоста передан. */
void sw_tx_mgmt_tx_complete_cb(u32 payload, u32 status, u32 a2)
{
    struct conn *conn = (struct conn *)a2;
    u32 hdr;
    if (payload == 0)
        fw_sysassert_fatal((void *)0, 0x11e9);
    hdr = payload - 0x24;
    fw_log_emit3(0x27, 0x10189d8, (u32)sw_tx_mgmt_ctx, hdr, (u32)conn);
    if (hdr != (u32)sw_tx_mgmt_ctx)
        fw_sysassert_fatal((void *)0, 0x121a);
    sw_tx_mgmt_packet_release(payload, status,
                              conn->mid->id, sw_tx_mgmt_cb);
    conn->sw_tx_sent = 0;
    sw_tx_mgmt_clear_link_ctx();
    conn->sw_tx_busy = 0;
}

/* SW_TX_MGMT_API::link_up_evt (0x8dabfc, 232 Б): кадр хоста ([0x8000c4]) к cid
 * [0x80024f] ждёт линка: линк есть (v == 0) — отправить (один раз, [conn+0x4c]); нет —
 * вернуть кадр хосту со статусом 2 и разрыв. */
void sw_tx_mgmt_link_up_evt(struct conn *conn, u32 v)
{
    struct sw_tx_hdr *ctx;
    u32 f;
    struct mid_disc *o;
    fw_log_emit0(0x27, 0x10188c0);
    ctx = sw_tx_mgmt_ctx;
    if (ctx == 0 || conn->cid != wmi_sw_tx_cid)
        return;
    if (v == 1) {
        if (conn->sw_tx_sent != 0)
            return;
        fw_log_emit0(0x27, 0x10188e4);
        sw_tx_mgmt_packet_release((u32)ctx->payload, 2, conn->mid->id,
                                  sw_tx_mgmt_cb);
        fw_log_emit0(0x27, 0x1018908);
        conn_mgr_link_up_evt(conn, v);
        sw_tx_mgmt_clear_link_ctx();
        return;
    }
    fw_log_emit0(0x27, 0x1018940);
    conn->sw_tx_busy = 1;
    o = &(conn->mid)->disc;
    f = (o->scan->active != 0 || o->find.active != 0) ? 1u : 0u;
    if (conn->sw_tx_sent != 0) {
        fw_log_emit1(0x27, 0x101898c, conn->sw_tx_sent);
        return;
    }
    fw_log_emit2(0x27, 0x101895c, 0, (u32)conn);
    tx_api_send_mgmt(conn, f, 1, (u32)ctx->payload, sw_tx_mgmt_ctx->len,
                     sw_tx_mgmt_tx_complete_cb, 0);
    conn->sw_tx_sent = 1;
}

/* ---------------- приём MLME-кадров ---------------- */

/* 0x802540: таблица переходов switch vendor rx_pkt_handler (0x8e3d08;
 * ldb, цель = 0x8e3d60 + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(802540) const u8 rx_pkt_handler_jt[11] = {
    0x00, 0x67, 0xc6, 0xc6, 0xc6, 0xc6, 0xc6, 0xc6, 0xc6, 0xc6, 0x79,
};

/* rx_pkt_handler (0x8e3d08, 514 Б; таблица 0x802540): mgmt-кадры соединения cid
 * info.cid. Assoc Request (0) — AP/PCP: CONNECT (или split MAC: кадр хосту и
 * WAITFOR_CTRL_ASSOC_RES); повтор ([+0xc] и бит Retry) или соединение в разрыве — кадр
 * освободить. Assoc Response (1) — только при идущем обмене ([+0xc]) и не в ASSOCIATED:
 * статус ≠ 0 — ASSOC_REJECT, иначе (не в ASSOCIATE) ASSOC_RESPONSE. Disassoc (10) —
 * DISASSOCIAT (split MAC при обмене — кадр хосту и WAITFOR_CTRL_DEL_STA с кодом 8).
 * Прочие подтипы — ассерт 0x1200 (кадр не освобождается, как у vendor). */
void rx_pkt_handler(struct rx_pkt *pkt)
{
    u32 sub;
    struct conn *conn;
    struct mlme_sm *sm;
    (void)mid_list_by_mid_fw(pkt->info.mid);
    conn = conn_mgr_by_cid(pkt->info.cid);
    rx_mgmt_prepare(pkt);
    sub = FC_STYPE(pkt->hdr->fc);
    if (conn == 0) {
        fw_log_emit2(0x1a, 0x10110f4, sub, pkt->info.len);
        goto drop;
    }
    sm = &conn->mlme;
    switch (sub) {
    case 0: {                                             /* Assoc Request */
        u32 disc = 0, retry = 0, st;
        fw_log_emit2(0x2a, 0x1011130, conn->cid, dashboard.cfg.ap_sme_offload_mode);
        if (conn->msm.sm.state == 8) {
            disc = 1;
            fw_log_emit0(0x1a, 0x1011164);
        }
        if (sm->busy != 0 && (pkt->hdr->fc_b[1] & 8u)) {
            fw_log_emit0(0x1a, 0x10111a8);
            retry = 1;
        }
        st = conn->mid->bss.mode;
        if ((st != 2 && st != 3) || retry != 0 || disc != 0)
            goto drop;
        if (dashboard.cfg.ap_sme_offload_mode == 1) {
            fw_log_emit0(0x2a, 0x10111f4);
            low_sme_send_evt2sw(&pkt->info, 0x1840, (u16)(pkt->info.len + sizeof(pkt->info)),
                                pkt->info.mid, 1, 0, 1);
            sm->host_pkt = pkt;
            mlme_sm_event(sm, 9, 0, 0, 0);
        } else {
            mlme_sm_event(sm, 0, (u32)pkt, 0, 0);
        }
        return;
    }
    case 1: {                                             /* Assoc Response */
        u32 st = sm->sm.state;
        if (sm->busy == 0 || st == 2)
            goto drop;
        if (pkt->ei->status != 0) {
            mlme_sm_event(sm, 5, (u32)pkt, 0, 0);
        } else {
            if (st == 1)
                goto drop;
            mlme_sm_event(sm, 4, (u32)pkt, 0, 0);
        }
        return;
    }
    case 10:                                              /* Disassociation */
        if (conn->msm.sm.state == 8 || (sm->sm.state == 0 && sm->busy == 0)) {
            fw_log_emit0(0x1a, 0x10112b8);
            goto drop;
        }
        if (dashboard.cfg.ap_sme_offload_mode == 1) {
            fw_log_emit0(0x2a, 0x1011244);
            low_sme_send_evt2sw(&pkt->info, 0x1840, (u16)(pkt->info.len + sizeof(pkt->info)),
                                pkt->info.mid, 1, 0, 1);
            fw_log_emit1(0x2a, 0x1011290, sm->busy);
            if (sm->busy != 0) {
                fw_log_emit0(0x2a, 0x10112a4);
                sm->host_pkt = pkt;
                sm->host_reason = 8;
                mlme_sm_event(sm, 0xc, 0, 0, 0);
                return;
            }
        }
        mlme_sm_event(sm, 2, (u32)pkt, 0, 0);
        return;
    default:
        fw_log_emit3(0x1a, 0x10112fc, conn->cid, sub, pkt->info.len);
        fw_sysassert_fatal((void *)0, 0x1200);
        return;
    }
drop:
    mgmt_pkt_release(pkt);
    mem_pool_free_thunk(pkt);
}

/* ======================= имена состояний и событий автоматов (fw_data) ======================= */

/* 0x801078: имена состояний автомата MLME (описатель 0x802458). */
FWDATA(801078) const u32 mlme_sm_state_names[3] = {
    0x0101fc7c,   /* UNASSOCIATE */
    0x0101fc88,   /* ASSOCIATE */
    0x0101fc92,   /* ASSOCIATED */
};

/* 0x801084: имена событий автомата MLME (описатель 0x802458). */
FWDATA(801084) const u32 mlme_sm_event_names[14] = {
    0x0101fc9d,   /* EVT_CONNECT */
    0x0101fca9,   /* EVT_DISCONNECT */
    0x0101fcb8,   /* EVT_DISASSOCIAT */
    0x0101fcc8,   /* EVT_ASSOC_RESPONSE_START */
    0x0101fce1,   /* EVT_ASSOC_RESPONSE */
    0x0101fcf4,   /* EVT_ASSOC_REJECT */
    0x0101fd05,   /* EVT_ASSOC_TIMEOUT */
    0x0101fd17,   /* EVT_RM_CHANNEL_LOCKED */
    0x0101fd2d,   /* EVT_DATA_PORT_OPEN */
    0x0101fd40,   /* EVT_WAITFOR_CTRL_ASSOC_RES */
    0x0101fd5b,   /* EVT_CTRL_ASSOC_RESPONSE_RET */
    0x0101fd77,   /* EVT_CTRL_NEW_STA */
    0x0101fd88,   /* EVT_WAITFOR_CTRL_DEL_STA */
    0x0101fda1,   /* EVT_CTRL_DEL_STA */
};
