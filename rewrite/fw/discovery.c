// SPDX-License-Identifier: AGPL-3.0-or-later
/* RX-диспетчер + BSS-отчёт: discovery__rx_pkt_handler + low_sme__send_evt2sw. .textlate. */
#include "../include/types.h"
#include "../include/rf_kill.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/rf_obj.h"
#include "../include/vring_schd.h"
#include "../include/mbox.h"
#include "../include/conn.h"
#include "../include/link_sm.h"
#include "../include/link_loss.h"
#include "../include/mid.h"
#include "../include/sched_scheme.h"
#include "../include/stream.h"
#include "../include/macq_desc.h"
#include "../include/ieee80211.h"
#include "../include/lmac_cmd.h"
#include "../include/sys_cfg.h"
#include "../include/wmi.h"


/* low_sme__send_evt2sw (0x8e5474): событие хосту через обработчик operational-mbox
 * (operational_mbox.evt_send = operational_if_evt_send, ставит operational_if_init_mbox_ptr).
 * payload — буфер host_if_send_pair (перед ним 0x10 Б под mbox/wmi-заголовки). */
__attribute__((section(".textlate"))) void low_sme_send_evt2sw(void *payload, u32 evt, u32 len, u32 mid, u32 a4, u32 a5, u32 a6)
{
    if (a4 == 0 && a5 == 0 && len + 0x10 > 0x100)
        fw_sysassert_fatal((void *)0, 0x1061);
    mbox_evt_send_fn h = operational_if_get_mbox()->evt_send;
    h((u32)payload, evt, len, mid, a4, a5, a6);   /* mbox_evt_send_fn: буфер числом */
}


/* conn__sec_mode_not_1 (0x8da5f8, 14 Б): 0 — режим безопасности записи mid соединения
 * ([mid+0x2c]) == 1, иначе 1. */
__attribute__((section(".textlate"))) u32 conn_sec_mode_not_1(struct conn *conn)
{
    return (conn->mid->sec.auth == 1) ? 0 : 1;
}

/* ut_hw_cmd_008__params (0x8e6f94, 62 Б): дескриптор кольца entry (как ADDBA-параметры,
 * флаг f) с индексом ключа key_idx в битах 24..25 слова +0x10 (bits__set32_s24_w2
 * 0x8ed460) — LMAC-команда 2 через qh__write_or_conn_alloc. */
__attribute__((section(".textlate"))) void vring_key_write_params(const struct vring_tbl_entry *entry,
                                                                  u32 flag, u32 key_idx)
{
    struct macq_qdesc buf;
    ba_sm_addba_at_10(entry, &buf, entry->sector_mode, (entry->ctl >> 1) & 1u, entry->to_res, flag);
    buf.sector.w0 = (buf.sector.w0 & ~(3u << 24)) | ((key_idx & 3u) << 24);
    qh_write_or_conn_alloc(entry->macq, 2, &buf, 0);
}

/* 0x8eacb0 (28 Б; в NAMES-EXTRA ut_hw_cmd_0x008): ключ для кольца стрима s —
 * запись таблицы колец по tbl_vr. */
__attribute__((section(".textlate"))) void vring_reinstall_key(const struct stream_ctx *s, u32 flag,
                                                               u32 key_idx)
{
    vring_key_write_params(vring_tbl_entry_addr(s->tbl_vr), flag, key_idx);
}

/* vring__reinstall_keys_for_mid (0x8ea7ac, 68 Б): для всех стримов (stream_by_vr, 10 шт.)
 * соединения conn, кроме vring 9, — переустановить ключ (индекс tk_idx). */
__attribute__((section(".textlate"))) void vring_reinstall_keys_for_conn(struct conn *conn, u32 flag)
{
    u32 i;
    for (i = 0; i < STREAM_VR_N; i++) {
        struct stream_ctx *s = stream_by_vr[i];
        if (s != 0 && s->conn == conn && s->vr != 9)
            vring_reinstall_key(s, flag, conn->tk_idx);
    }
}

/* install_key_handle (0x8f5a5c, 40 Б): событие 7 (NTF_KEY_INSTALLED) conn_main_sm и
 * переустановка ключей его колец. */
__attribute__((section(".textlate"))) void install_key_handle(struct conn *conn)
{
    conn_msm_event(&conn->msm, 7, 0, 0, 0);
    vring_reinstall_keys_for_conn(conn, conn_sec_mode_not_1(conn));
}

/* Задача после WMI_SCAN_COMPLETE (vendor 0x8ed9c4, 8 Б): low_sme__termination_check(1). */
__attribute__((section(".textlate"))) void low_sme_scan_done_task(u32 a0, u32 a1)
{
    (void)a0;
    (void)a1;
    low_sme_termination_check(1);
}

/* low_sme__check_state_1 (0x8cb0b4, 84 Б): событие не отправляется хосту (o — кольцо tx
 * ящика): у кольца с пулом буфер payload отдаётся колбэку free_cb (a4 ≠ 0) или free_cb2
 * (a5 ≠ 0; нет колбэка — ассерт 0xcd / 0xce), иначе возвращается в пул кольца
 * (буфер пула начинается на 0x10 Б раньше payload). */
__attribute__((section(".textlate"))) void low_sme_check_state_1(struct mbox_ring *o, u32 payload, u32 a4, u32 a5)
{
    void (*cb)(u32);
    if (o->pooled != 1)
        return;
    if (a4 != 0) {
        if (o->free_cb == 0)
            fw_sysassert_fatal((void *)0, 0xcd);
        cb = o->free_cb;
    } else if (a5 != 0) {
        if (o->free_cb2 == 0)
            fw_sysassert_fatal((void *)0, 0xce);
        cb = o->free_cb2;
    } else {
        fw_log_emit0(0, 0x1001b7c);
        stream_mgr_check_vring(o->pool, (void *)(payload - 0x10));   /* mem_pool__free */
        return;
    }
    cb(payload);
}

/* low_sme__send_evt2_body (0x8cb1bc, 70 Б): ветка «хост не принимает события»
 * ([0x800018] == 0): low_sme__check_state_1(&mb->tx, …) с выключенными прерываниями.
 * Пустой payload — ассерт 0xc2 (vendor продолжает). */
__attribute__((section(".textlate"))) void low_sme_send_evt2_body(struct fw_mailbox *mb, u32 payload, u32 a4, u32 a5)
{
    u32 s;
    if (payload == 0)
        fw_sysassert_fatal((void *)0, 0xc2);
    s = arc_irq_disable();
    low_sme_check_state_1(&mb->tx, payload, a4, a5);
    arc_irq_restore(s);
}

/* Обработчик событий operational-mbox (vendor 0x8e54cc, 174 Б; у vendor ставится числом
 * 0x254cc — адрес в младшем отображении ICCM, у нас — адрес этой функции). Перед отправкой:
 * событие 0x15 и WMI_CONNECT_EVENT при режиме безопасности 1 — установка ключей
 * соединения; WMI_SCAN_COMPLETE_EVENT — задача low_sme__termination_check(1).
 * При [0x800018] != 0 (fw_data, всегда 1) — wmi_evt__post в кольцо fw→host
 * ([0x804c3c] = 0x8041f0), иначе low_sme__send_evt2_body (0x8cb1bc). 9-й аргумент
 * wmi_evt__post (a6, у vendor на стеке) наш wmi_evt_post не принимает. */
__attribute__((section(".textlate"))) void operational_if_evt_send(u32 payload, u32 evt, u32 len, u32 mid, u32 a4, u32 a5, u32 a6)
{
    (void)a6;
    u8 *p = (u8 *)payload;
    u32 en = wmi_evt_ring_enabled;             /* [gp,-0x16c], читается до веток */
    if (evt == 0x15) {
        install_key_handle(conn_mgr_by_cid(p[9]));
    } else if (evt == 0x1002) {                     /* WMI_CONNECT_EVENT: cid (+0x13) */
        struct conn *conn = conn_mgr_by_cid(p[0x13]);
        if (conn_sec_mode_not_1(conn) == 0) {
            fw_log_emit1(0x2e, 0x100ba20, p[0x13]);
            install_key_handle(conn);
        }
    } else if (evt == 0x100a) {                     /* WMI_SCAN_COMPLETE_EVENT */
        u_schd_add(low_sme_scan_done_task, 0, 0, 1);
    }
    struct wmi_mbox *ring = &operational_mbox_ref->wm;
    if (en != 0)
        wmi_evt_post(ring, p, 0, evt, len, mid, a4, a5);
    else
        low_sme_send_evt2_body(&ring->mb, payload, a4, a5);
}

/* mgmt_pkt__clear (0x8cb160, 32 Б): занятую запись разбора кадра (busy == 1) очистить
 * (0xd4 Б) и освободить. Таблица tbl (rx_pkt_srvs) не используется. */
__attribute__((section(".textlate"))) void mgmt_pkt_clear(struct rx_pkt_srvs *tbl, struct rx_mgmt_ei *ei)
{
    (void)tbl;
    if (ei != 0 && ei->busy == 1) {
        memset0_words(ei, sizeof(*ei));
        ei->busy = 0;
    }
}

/* mgmt_pkt__release (0x8cb180, 28 Б): вернуть запись разбора pkt->ei mgmt-пакета.
 * Сам пакет не освобождается (это mem_pool__free_thunk 0x8cb15c). */
__attribute__((section(".textlate"))) void mgmt_pkt_release(struct rx_pkt *pkt)
{
    mgmt_pkt_clear(&rx_pkt_srvs, pkt->ei);
    pkt->ei = 0;
}

/* discovery__inject_probe_evt (0x8e11b4, 20 Б): basic_sm_handle_event(find_sm, 4, pkt,
 * режим find_mngr, 0) — влить probe-событие в автомат поиска. */
__attribute__((section(".textlate"))) void discovery_inject_probe_evt(struct find_mngr *obj, struct rx_pkt *pkt)
{
    basic_sm_handle_event(&obj->sm, 4, (u32)pkt, obj->mode, 0);
}

/* discovery__init_probe_entry (0x8e7234, 112 Б; база add3 conn,0x30 = conn+0x180):
 * копирует OUI из SA кадра в 0x800280..2, ставит features_ver соединения =
 * features_version_tracking (из Wilocity VS) или 0/0xffff по OUI-эвристике. */
__attribute__((section(".textlate"))) void discovery_init_probe_entry(struct conn *conn, struct rx_pkt *pkt,
                                                                      struct mid *bss_ctx)
{
    struct rx_mgmt_ei *meta = pkt->ei;
    conn->features_ver = 0xffff;
    memcpy_fw(disc_probe_sa_oui, &pkt->hdr->addr2, 3);
    if (meta->vs_wil.body != 0) {
        conn->features_ver =
            parse_wilocity_vs_get_features_version_tracking((u32)&bss_ctx->bss, &meta->vs_wil);
    } else if (disc_probe_sa_oui[0] == 4 && disc_probe_sa_oui[1] == 0xce && disc_probe_sa_oui[2] == 0x14) {
        conn->features_ver = 0;
    } else {
        conn->features_ver = 0xffff;
    }
    fw_log_emit1(0x2e, 0x10103fc, conn->features_ver);
}

/* set_vendor_specific_version (0x8e72a4, 88 Б): сохранить версию Wilocity VS в
 * vs_version соединения; при отсутствии VS-поля собрать "старый" блок set_old_wilocity_vs. */
__attribute__((section(".textlate"))) void set_vendor_specific_version(struct conn *conn, struct rx_pkt *pkt,
                                                                       struct mid *bss_ctx)
{
    struct rx_mgmt_ei *meta = pkt->ei;
    u32 r15 = (u32)&bss_ctx->bss;                /* add3 bss_ctx,9 */
    if (meta->vs_wil.body != 0) {
        conn->vs_version = parse_wilocity_vs_get_version(r15, &meta->vs_wil);
    } else {
        const struct wil_vs_old *old = (const struct wil_vs_old *)meta->vs_wil_old.body;
        conn->vs_version = 0;
        fw_log_emit1(0x2e, 0x10103a0, 0);
        set_old_wilocity_vs(&bss_ctx->bss, old, 0x40, 0);
    }
    fw_log_emit1(0x2e, 0x10103d0, conn->vs_version);
}

/* str__eq_n (0x8ddf30, 28 Б): найти байт c среди первых n байт, вернуть
 * указатель или 0. */
__attribute__((section(".textlate"))) const u8 *str_eq_n(const u8 *a, u8 c, u32 n)
{
    u32 i;
    for (i = 0; i < n; i++)
        if (a[i] == c)
            return &a[i];
    return 0;
}

/* discovery__ssid_matches (0x8e82e0, 48 Б): сравнить SSID до '\0' (или полной
 * длиной c) с b; вернуть результат memcmp (0 = совпали). */
__attribute__((section(".textlate"))) int discovery_ssid_matches(const u8 *a, const u8 *b, u32 c)
{
    const u8 *r = str_eq_n(a, 0, c);
    u32 len = (r == 0) ? c : (u32)(r - a) + 1;
    return memcmp_fw(a, b, len);
}

/* discovery_is_ssid_approved (0x8f2a90, 176 Б): одобрен ли SSID probe-запроса
 * (wildcard / DIRECT- / точное совпадение с настроенным SSID). */
__attribute__((section(".textlate"))) u32 discovery_is_ssid_approved(struct mid_disc *obj, struct rx_pkt *pkt)
{
    u8 ssidbuf[0x20];
    struct mid *bss_ctx = obj->mid;
    const struct rx_mgmt_ei *meta;
    u8 len;
    u8 ssidlen;
    const u8 *ssid;
    u32 r18;
    u32 ret;

    fw_log_emit0(0x2c, 0x10167a0);

    ssidlen = (u8)mid_copy_ssid(&bss_ctx->bss, ssidbuf);

    meta = pkt->ei;
    len = meta->ssid.len;             /* ldb_s → длина SSID (знаковая, но <=32) */
    ssid = meta->ssid.body;

    r18 = 1;
    if (len != 0)
        r18 = 0;
    if (bss_ctx->bss.is_go != 0 && len == 7) {
        if (discovery_ssid_matches(ssid, (const u8 *)"DIRECT-", 7) != 0)
            r18 = 1;
    }

    if (bss_ctx->bss.hidden == 0 && r18 != 0) {
        fw_log_emit0(0x2c, 0x10167c8);            /* wildcard */
        ret = 1;
    } else if (len == ssidlen) {
        if (discovery_ssid_matches(ssid, ssidbuf, len) == 0) {
            fw_log_emit0(0x2c, 0x1016858);        /* expected content */
            ret = 1;
        } else {
            fw_log_emit0(0x2c, 0x101680c);        /* bad content */
            ret = 0;
        }
    } else {
        fw_log_emit0(0x2c, 0x10168a4);            /* bad length */
        ret = 0;
    }
    return ret;
}

/* DMG Capabilities пира из кадра → conn.dmg_caps (17 Б, формат 802.11ad-2012; поля дальше fw не разбирает).
 * Ошибка vendor (исправлено): копировал тело элемента длиной из кадра (до 255 Б) в 17-байтный массив записи
 * соединения — порча следующих записей из эфира; даже элемент 802.11-2020 (22 октета, 9.4.2.127) писал 5 Б
 * за массив. Теперь: тело короче 17 Б — элемент не принимается, длиннее — берутся первые 17. */
__attribute__((section(".textlate"))) static void discovery_take_dmg_caps(struct conn *mid,
                                                                          const struct rx_mgmt_ei *meta, u32 tok)
{
    const u8 *cap = meta->dmg_cap.body;
    u32 len = meta->dmg_cap.len;

    if (cap == 0 || len < sizeof(mid->dmg_caps))
        return;
    fw_log_emit3(0x2a, tok, len, cap[1], cap[1]);
    memcpy_fw(mid->dmg_caps, cap, sizeof(mid->dmg_caps));
    conn_set_rf_params_from_caps(mid);
    hexdump_words(cap, sizeof(mid->dmg_caps));
}

/* discovery_handle_probe_req (0x8f2798, 436 Б): обработка probe request.
 * В PCP-режиме находит MID по SA, сохраняет Wilocity VS + DMG-caps и (если SSID
 * одобрен) отправляет probe resp. Иначе вливает событие в find-SM / логирует. */
__attribute__((section(".textlate"))) u32 discovery_handle_probe_req(struct mid_disc *obj, struct rx_pkt *pkt)
{
    struct mid *bss_ctx = obj->mid;
    struct scan_mngr *rx = obj->scan;
    fw_log_emit0(0x2c, 0x10168f0);

    /* PCP-режим: режим BSS ∈ {2,3} либо идёт скан с discovery. */
    u32 in_pcp = 0;
    if (bss_ctx->bss.mode == 2 || bss_ctx->bss.mode == 3) {
        in_pcp = 1;
    } else {
        u32 s = rx->scan_type;
        if ((s == 0 || s == 3) && rx->discovery_mode == 1 && rx->active == 1)
            in_pcp = 1;
    }

    if (in_pcp) {
        struct conn *mid = mid_list_find_by(bss_ctx, &pkt->hdr->addr2);  /* SA */
        if (mid != 0) {
            if ((dashboard.cfg.special_flags & (1u << 10)) != 0 &&
                (mid->msm.sm.state == 5 || mid->msm.sm.state == 7)) {
                fw_log_emit0(0x1c, 0x1016910);
                vring_schd_disconnect_notify(0, WMI_SPARRAW_DISC_PEER_RESTARTED);
            } else {
                set_vendor_specific_version(mid, pkt, bss_ctx);
                discovery_init_probe_entry(mid, pkt, bss_ctx);
                discovery_take_dmg_caps(mid, pkt->ei, 0x1016964);
                if (discovery_is_ssid_approved(obj, pkt)) {
                    u32 payload = TX_API_alloc_tx_payload();
                    fw_log_emit1(0x2c, 0x101699c, u_schd_now());
                    u32 flag = 0;
                    u32 s = rx->scan_type;
                    if ((s == 0 || s == 3) && rx->discovery_mode == 1 && rx->active == 1)
                        flag = 1;
                    tx_probe_send_probe_resp(payload, bss_ctx, mid, flag,
                                             probe_resp_ind_done_cb);
                }
            }
            mgmt_stats.probe_req_handled += 1;
        } else {
            fw_log_emit1(0x2c, 0x10169d8, u_schd_now());
            mgmt_stats.probe_req_handled += 1;
        }
    } else {
        if (obj->find.active != 0) {
            fw_log_emit0(0x2c, 0x1016a30);
            discovery_inject_probe_evt(&obj->find, pkt);
        } else {
            const struct ieee80211_hdr *frame = pkt->hdr;
            u32 lo = (u32)frame->addr2.h[0] | ((u32)frame->addr2.h[1] << 16);
            u32 hi = frame->addr2.h[2];
            fw_log_emit2(0x2c, 0x1016a68, hi, lo);
        }
    }
    return 1;
}

/* vring_schd__disconnect_notify (0x8c91b8, 328 Б): для каждого vring (1 итерация)
 * mid_list_by_mid_fw → лог + mid_list_disconnect_all(ret, flag+1, 3).
 * НЕ vendor: detail (у vendor второй аргумент не читается) — уточнение причины для хоста (enum
 * wmi_sparraw_disc_reason): иначе сбой PCIe и rf-kill уходили как DISCONNECT_CMD — как команда хоста. */
__attribute__((section(".textlate"))) void vring_schd_disconnect_notify(u32 mid, u32 detail)
{
    u32 flag = (mid != 0) ? 1u : 0u;
    for (u32 i = 0; i < 1; i++) {
        struct mid *r = mid_list_by_mid_fw(i);
        if (r != 0) {
            fw_log_emit3(0x2b, 0x100d600, i, flag + 1, 3);
            conn_disc_detail_set_mid(r, detail);
            mid_list_disconnect_all(r, flag + 1, 3);
        }
    }
}

/* --- vring_schd__disconnect_notify: хелперы (0x8c9110/0x8c9360/0x8c9200) --- */

/* mid__disconnect_cmd (0x8c9360, 64 Б): разорвать одно MID-соединение
 * (MLME в состоянии 2 или идёт обмен Assoc).
 * Исправлено: прежде второй проверкой читалось [e+0xc] (RX-сектор и 2 Б за ним) вместо
 * mlme.busy [e+0xfc]: vendor 0x8c936a ldb.a r0,[r1,0xf0] — запись адреса r1 = e+0xf0,
 * затем ld_s r0,[r1,0xc] = [e+0xfc]. Соединение в обмене Assoc (не в состоянии 2) с
 * выбранным RX-сектором 0 не разрывалось, а без обмена (сектор 0xffff) — разрывалось. */
__attribute__((section(".textlate"))) u32 mid_disconnect_cmd(struct mid *obj, struct conn *e, u32 reason,
                                                             u32 protocol)
{
    u32 state = e->mlme.sm.state;
    /* исправлено (vendor): STA до ассоциации (захват линка: WAIT_FOR_BCON_RX / WAIT_FOR_LINKUP) не разрывалась —
     * WMI_DISCONNECT терялся, событие хосту не уходило (wmi_call timeout 2 с, «is DISCONNECTING» до перезагрузки),
     * ассоциация затем завершалась вопреки отмене. Автомат соединения OWN_DISC в этих состояниях обрабатывает. */
    /* исправлено (vendor): и AP-соединение после SLS без ассоциации (READY_FOR_ASSOC) — WMI_DISCONNECT_STA его снимает */
    if (state != 2 && e->mlme.busy == 0 &&
        (obj->bss.mode != 1 || e->msm.sm.state == CONN_MSM_UNRESOURCED ||
         e->msm.sm.state > CONN_MSM_WAIT_FOR_LINKUP) &&
        !(obj->bss.mode != 1 && e->msm.sm.state == CONN_MSM_READY_FOR_ASSOC))
        return 0;
    fw_log_emit3(0x2b, 0x100cc1c, obj->id, e->cid, protocol);
    conn_disconnect(e, reason, protocol);
    return 1;
}

/* mid_list__disconnect_all (0x8c9110, 84 Б): обойти MID-список и разорвать все;
 * если ничего не разорвано — запланировать termination-check. */
__attribute__((section(".textlate"))) void mid_list_disconnect_all(struct mid *obj, u32 reason,
                                                                   u32 protocol)
{
    u32 it;
    u32 result = 0;
    iter_init(&it, &obj->conns);
    while (list_has_items(&it)) {
        struct conn *e = (struct conn *)iter_next(&it);
        result = mid_disconnect_cmd(obj, e, reason, protocol);
    }
    if (result == 0)
        u_schd_add(low_sme_termination_check_thunk, 0, 0, 1);
}

/* low_sme__termination_check (0x8e9110, 80 Б): снять бит termination-маски; при
 * её обнулении — basic_sm_handle_event(0x804c34, 2, 0, 0, 0). */
__attribute__((section(".textlate"))) void low_sme_termination_check(u32 evt)
{
    fw_log_emit1(0x20, 0x100b3e4, evt);
    u32 m = rf_kill_stop_stages;
    if (m & (1u << evt)) {
        m &= ~(1u << evt);
        rf_kill_stop_stages = m;
        fw_log_emit1(0x20, 0x100b414, evt);
        if (rf_kill_stop_stages == 0)
            basic_sm_handle_event(&rf_mgmt_sm, 2, 0, 0, 0);
    }
}

/* Thunk 0x8f6c44: low_sme_termination_check(0) — колбэк шедулера. */
__attribute__((section(".textlate"))) void low_sme_termination_check_thunk(u32 a0, u32 a1)
{
    (void)a0;
    (void)a1;
    low_sme_termination_check(0);
}

/* vring_hw__unmask_irq (0x8d05f0, 48 Б): бит a в 0x881c58 с маскировкой IRQ. */
__attribute__((section(".textlate"))) void vring_hw_unmask_irq(u32 a, u32 flag)
{
    u32 s = arc_lr(ARC_STATUS32);
    arc_flag(s & ~(1u << 1));
    MMIO32(HW_DMA_FW_ICR_C40_IMC) = a;
    if (flag != 0)
        arc_sync();
    u32 cur = arc_lr(ARC_STATUS32);
    arc_flag((s & 0x2) | cur);
}

/* vring__ack_and_unmask_irq (0x8d85d4, 48 Б): состояние → 1 (ждёт DMA); разрешённому
 * vring — квитировать и размаскировать прерывание DMA. */
__attribute__((section(".textlate"))) void vring_ack_and_unmask_irq(struct vring_rec *entry)
{
    u32 state = entry->enabled;
    entry->state = 1;
    if (state == 1) {
        u32 bit = 1u << entry->vr;
        hwd_dma_ack_881c44(bit, 1);
        vring_hw_unmask_irq(bit, 1);
    }
}

/* vring_schd__reconnect_next (0x8c9200, 256 Б): pring id остановлен — отвязать запись
 * и привязать к нему первый незапрещённый vring из списков готовых (1 → 0). Регистрируется
 * как done-handler пула (pring__init_pool 0x8d8cb0 → pring__set_done_handler). */
__attribute__((section(".textlate"))) void vring_schd_reconnect_next(u32 id, u32 arg)
{
    (void)arg;                                     /* pring_done_fn: аргумент не читается */
    struct pring *p = sm_pring_by_index(id);   /* указатель в регистре — см. vectors.c */
    struct vring_rec *old = p->bound;
    struct vring_rec *next = 0;

    if (old == 0)
        fw_sysassert_fatal((void *)0, 0x12af);   /* vendor: далее с old = 0 */

    sm_pring_notify_step(old, 0);
    p->bound = 0;

    if (id != 1) {
        /* списки готовых: vendor идёт 1 → 0 (в asm: r3 = 2; r3--; тело для r3 = 1, 0);
         * next — голова последнего просмотренного списка. */
        u32 k;
        for (k = 1; k != (u32)-1; k--) {
            struct llist *l = &vring_schd.ready[k];
            next = (struct vring_rec *)l->head;
            if (next == 0)
                continue;
            if (vring_schd_is_vring_ready(&vring_schd, next->pring) != 0)
                continue;                       /* pring-id запрещён — ищем ниже */
            llist_pop_front((u32 *)l);
            vring_schd_bind_if_free(&vring_schd, next, p);
            break;
        }

        /* vendor (8c922e): для pring 1 сразу к постановке задачи — запись old не
         * возвращается ни в готовые, ни в ожидание. */
        if (old->enabled == 1 &&
            hwd_dma_get_881c80(old->vr) == 1) {
            if (next == 0 &&
                vring_schd_is_vring_ready(&vring_schd, old->pring) == 0) {
                fw_log_emit1(0x27, 0x100bc3c, old->vr);
                vring_schd_bind_if_free(&vring_schd, old, p);
            } else {
                list_find_entry_d((u32 *)&vring_schd.ready[old->prio], (u32 *)old);
                old->state = 2;
            }
        } else {
            list_find_entry_d((u32 *)&vring_schd.waiting, (u32 *)old);
            vring_ack_and_unmask_irq(old);
        }
    }

    u_schd_add(stream_mgr_ready_for_modify,
               old->vr, 0, 1);
    if (p->bound == 0)
        macq_hw_disable_queue_fw(id);
}

/* regulatory_domain__set_country_code (0x8e63e0, 20 Б): country code (BE u16)
 * в 0x800214 + лог. */
__attribute__((section(".textlate"))) void regulatory_domain_set_country_code(u32 v)
{
    regd_country_code = (u16)v;
    fw_log_emit1(0x20, 0x1010dd0, v);
}

/* discovery_handle_probe_resp (0x8f294c, 324 Б): обработка probe response. */
__attribute__((section(".textlate"))) u32 discovery_handle_probe_resp(struct mid_disc *obj, struct rx_pkt *pkt)
{
    struct mid *bss_ctx = obj->mid;
    struct scan_mngr *rx = obj->scan;
    const struct ieee80211_hdr *frame = pkt->hdr;
    const struct rx_mgmt_ei *meta = pkt->ei;
    fw_log_emit0(0x2c, 0x1016ac0);

    struct conn *mid = mid_list_find_by(bss_ctx, &frame->addr2);   /* SA */
    if (mid == 0)
        return 0;

    fw_log_emit3(0x2c, 0x1016ae0, pkt->info.len, pkt->info.channel, u_schd_now());

    int rssi = hwd_phy_get_883b80();
    disc_probe_resp_rssi = (u32)rssi;
    /* volatile: записи в заголовок — до двух чтений disc_probe_resp_rssi для журнала, как
     * у vendor (иначе gcc поднимает volatile-чтения выше записей в пакет) */
    volatile struct rx_mgmt_info *vi = &pkt->info;
    vi->stype = 5;                             /* stw: только 2 Б */
    vi->range = 0;
    s8 snr = (s8)((rssi >> 4) - 0x48);
    vi->snr = snr;
    vi->sqi = mid->bf_avg;
    fw_log_emit3(0x2c, 0x1016b1c, disc_probe_resp_rssi, disc_probe_resp_rssi, (u32)(s32)snr);

    u32 ret;
    if (rx->active != 0) {
        u32 chan = pkt->info.channel;
        u32 rssi2 = *(u16 *)meta->bcn_int;
        ret = probe_resp_ind(rx, &frame->addr1, &frame->addr3, chan, rssi2, (u32)(s32)snr);
        if (ret != 0 && meta->vs_wil.body != 0) {
            fw_log_emit1(0x2c, 0x1016b44,
                         parse_wilocity_vs_get_flag3((u32)&bss_ctx->bss, &meta->vs_wil));
            set_vendor_specific_version(mid, pkt, bss_ctx);
            discovery_init_probe_entry(mid, pkt, bss_ctx);
            discovery_take_dmg_caps(mid, meta, 0x1016ba4);
        }
    } else {
        ret = (obj->find.active != 0) ? 1u : 0u;
    }

    const u8 *country = meta->country.body;
    if (country != 0 && meta->country.len >= 3)     /* Country String — 3 октета (9.4.2.8); vendor читал без длины */
        regulatory_domain_set_country_code((u32)country[1] | ((u32)country[0] << 8));

    return ret;
}

/* probe_resp_ind (0x8f7ae4, 512 Б): обработка probe-ответа активного скана —
 * find_main_sm_bcon_step → l2_mgr_connect_next → обновление peer_info →
 * scan_mngr__prob_done. Включает колбэк 0x8f7cac (probe_resp_ind_done_cb). */

__attribute__((section(".textlate"))) u32 probe_resp_ind(struct scan_mngr *scan, const void *bssid, const void *sa,
                                                         u32 channel, u32 rssi, u32 snr)
{
    (void)bssid;                       /* vendor работает по SA, не по BSSID */
    const u8 *r15 = sa;
    const union mac_addr *sa_mac = sa;
    u32 r16 = channel;
    u16 r18 = (u16)rssi;
    s32 r20 = (s32)snr;                /* snr приходит знаково-расширенным */

    fw_log_emit1(0x29, 0x1015fac, scan->active_probs);

    if (scan->cs->hdr.state != CS_ST_DWELLING)
        return 0;
    if (scan->active_probs == 0)
        return 0;

    struct dband_info *r13 = find_main_sm_bcon_step(&scan->pend, r15);
    if (r13 == 0)
        return 0;

    u8 omni = r13->rx_omni;            /* directed omni */
    s8 r23 = 0;                        /* tx_sector_snr (знаковый) */

    if (r13->conn != 0) {
        struct conn *conn = r13->conn;
        r23 = (s8)(conn->bf_byte);
        fw_log_emit3(0x29, 0x1015fdc, omni, (u32)r20, (u32)(s32)r23);
        fw_log_emit1(0x29, 0x1016018, conn->bcon_time);

        struct scan_peer *r14 = l2_mgr_connect_next(scan, (const u8 *)r15, r16);
        if (r14 == 0) {
            /* добавить новую запись peer_info_array */
            u32 count = scan->peer_cnt[r16];
            if (count >= 4) {
                fw_log_emit1(0x19, 0x10160a0, r16);   /* peer_info_array full */
            } else {
                fw_log_emit2(0x29, 0x101605c, sa_mac->h[2], mac_lo32(sa_mac));
                struct scan_peer *row = scan->peers[r16];
                struct scan_peer *peer = &row[count];
                u32 bcon = conn->bcon_time;
                peer->rx_omni = omni;
                peer->rx_snr = (s8)r20;
                peer->bcon_time = bcon;
                peer->rssi = r18;
                peer->tx_snr = r23;
                peer->tx_omni = omni;
                peer->tx_bcon_time = bcon;
                peer->bssid_lo = r13->bssid_lo;
                peer->bssid_hi = r13->bssid_hi;
                scan->peer_cnt[r16] = (u8)(count + 1);
            }
        } else {
            u32 bcon = conn->bcon_time;
            if (omni != r14->tx_omni) {
                fw_log_emit3(0x29, 0x10160d4, (u32)(s32)r23, omni, bcon);
                r14->tx_snr = r23;
                r14->tx_omni = omni;
                r14->tx_bcon_time = bcon;
            } else {
                if ((s32)r23 >= (s32)r14->tx_snr) {
                    fw_log_emit3(0x29, 0x1016120, (u32)(s32)r23, omni, bcon);
                    r14->tx_snr = r23;
                    r14->tx_bcon_time = bcon;
                    if (omni == r14->rx_omni)
                        r14->bcon_time = bcon;
                }
            }
            if (r20 >= (s32)r14->rx_snr) {
                if (omni != r14->rx_omni) {
                    fw_log_emit2(0x29, 0x101616c, sa_mac->h[2], mac_lo32(sa_mac));
                    r14->rx_omni = r14->tx_omni;
                }
                u32 bcon2 = r14->tx_bcon_time;
                r14->rx_snr = (s8)r20;
                r14->bcon_time = bcon2;
            }
        }
    }

    /* хвост: декремент активных проб + prob_done */
    {
        u8 probs = scan->active_probs;
        u8 r4 = (u8)(probs - 1);
        scan->active_probs = r4;
        fw_log_emit3(0x29, 0x10161a8, sa_mac->h[2], mac_lo32(sa_mac), r4);
    }
    scan_mngr_prob_done(scan, 0, r13);
    return 1;
}

/* probe_resp_ind__done (0x8f7cac, 56 Б): колбэк завершения отправки probe-resp —
 * если status и conn ненулевые — инкремент mgmt_stats.probe_resp_tx_ok; затем TX_API_free_memory. */
__attribute__((section(".textlate"))) void probe_resp_ind_done_cb(u32 payload, u32 status, u32 conn)
{
    fw_log_emit1(0x2d, 0x1016f50, status);
    if (status != 0 && conn != 0)
        mgmt_stats.probe_resp_tx_ok += 1;
    TX_API_free_memory(payload);
}

/* l2_mgr__connect_next (0x8e4c24, 104 Б): запись peer_info_array канала band с BSSID key
 * или 0 (vendor: база записей scan + 0x84 — add2 r0,r4,0x21). */
__attribute__((section(".textlate"))) struct scan_peer *l2_mgr_connect_next(struct scan_mngr *obj,
                                                                          const u8 *key, u32 band)
{
    u32 i;
    u32 count = obj->peer_cnt[band];
    struct scan_peer *row = obj->peers[band];
    for (i = 0; i < count; i++) {
        struct scan_peer *e = &row[i];
        u32 j, ok = 1;
        for (j = 0; j < 6; j++)
            if (key[j] != e->bssid[j]) { ok = 0; break; }
        if (ok)
            return e;
    }
    return 0;
}

/* scan_mngr__prob_done (0x8f74c4, 428 Б): финализировать активную пробу —
 * снять pending-таймер, перенести запись в scanned-список (или освободить),
 * и по reason обработать соединение (abort / link-down / activate). */

__attribute__((section(".textlate"))) void scan_mngr_prob_done(struct scan_mngr *scan, u32 reason,
                                                               struct dband_info *entry)
{
    fw_log_emit0(0x29, 0x1015c14);            /* "scan_mngr::prob_done()" */
    if (entry == 0)
        return;

    fw_log_emit0(0x29, 0x1015c2c);            /* "BSSID in the pending list" */
    entry->status = DBAND_ST_DONE;

    if (entry->probe_tmr != 0) {
        fw_log_emit2(0x29, 0x1015c60, entry->bssid_hi, entry->bssid_lo);
        fw_log_emit1(0x29, 0x1015ca0, entry->probe_tmr);
        u_schd_cancel(entry->probe_tmr);
        entry->probe_tmr = 0;
    }

    struct conn *conn = entry->conn;

    if (reason == 0) {
        fw_log_emit2(0x29, 0x1015cf0, entry->bssid_hi, entry->bssid_lo);
        tx_list_remove(&scan->pend, entry);
        if (conn_multi_omni_count < 2)          /* [gp,0xad] */
            list_find_entry_d(&scan->scanned, entry);
        else
            free_dband_info(entry);
    } else {
        fw_log_emit1(0x29, 0x1015d44, reason);
        if (reason != 3 || entry->retries != 0) {
            tx_list_remove(&scan->pend, entry);
            free_dband_info(entry);
            entry = 0;
        }
    }

    if (conn == 0)
        goto tail;
    if (conn->mlme.sm.state == 2)
        goto tail;

    if (reason == 1) {
        fw_log_emit3(0x19, 0x1015d90, conn->cid, 1, (u32)conn);
        goto tail;
    }
    if (reason == 2) {
        fw_log_emit3(0x29, 0x1015de4, conn->cid, 2, (u32)conn);
        conn_mgr_link_down_evt(conn);
        goto tail;
    }
    if (reason == 3 && entry != 0) {
        fw_log_emit1(0x29, 0x1015e38, entry->retries);
        fw_log_emit3(0x29, 0x1015e64, conn->cid, 3, (u32)conn);
        /* 0x8f75ea..0x8f75f0: три stb_s [r14,2] / [r14] / [r14,1] по порядку; volatile —
         * иначе gcc сливает bf_kind и status в одну sth */
        volatile struct dband_info *ve = entry;
        ve->retries = (u8)(entry->retries + 1);
        ve->bf_kind = 3;
        ve->status = DBAND_ST_NEW;
        conn_abort(conn, 1);
        connection_init(conn, conn->peer, conn->mid);
        conn->skip_bf = 0;
        conn_mgr_activate_conn(conn, 0);
        goto tail;
    }

    /* default: reason==0 либо reason==3 с уже освобождённой entry */
    if (conn->mid->bss.mode == 1) {
        fw_log_emit3(0x29, 0x1015f08, conn->cid, reason, (u32)conn);
        conn_mgr_link_down_evt(conn);
    }

tail:
    if (scan->scan_type == 3) {
        fw_log_emit0(0x29, 0x1015f5c);
        channels_switch_sm_abort_dwelling(scan->cs);
    }
}

/* --- sub-хелперы scan_mngr__prob_done --- */
/* conn__abort (0x8f0444, 103 Б): снять биты cid в bitmap + teardown + link-loss-off. */
__attribute__((section(".textlate"))) void conn_abort(struct conn *conn, u32 flag)
{
    fw_log_emit1(0x2b, 0x1010330, conn->cid);
    u32 cid = conn->cid;
    ll_ctx.fsched_flush_over &= ~(1u << cid);                /* 0x85724c */
    ll_ctx.fsched_flush_mask &= ~(1u << cid);                 /* 0x857248 */
    fwsh_sets.fsched_airtime[cid] = 0;
    if (flag == 0) {
        conn_teardown_mac_rules(conn);
        conn_msm_event(&conn->msm, 0xa, 0, 0, 0);
        lm_if_disable_link_loss_monitoring(&conn->lm);
    } else {
        conn_msm_event(&conn->msm, 0xa, 0, 0, 0);
    }
}
/* conn__teardown_mac_rules (0x8f9400, 45 Б): снести MAC-правила соединения. */
__attribute__((section(".textlate"))) void conn_teardown_mac_rules(struct conn *conn)
{
    lmac_if_send_sta_cfg_05(conn, 1);
    mac_parser_build_wildcard_rule(conn->cid);
    stream_mgr_prepare_1f(conn->cid, 7);
    conn_check_field_50(conn);
    mid_list_remove_entry(conn->mid, conn);
}
/* lmac_if__send_sta_cfg_05 (0x8e7604, 140 Б): собрать STA-config команду
 * (0x28 Б) в пуле lmac-команд и отправить через lmac_if__post_cmd. */
__attribute__((section(".textlate"))) void lmac_if_send_sta_cfg_05(struct conn *a, u32 b)
{
    struct lmac_cmd_sta_cfg *cmd = lmac_cmd_pool_alloc();
    u32 state = a->mid->bss.mode;

    cmd->op = b;
    cmd->cid = a->cid;
    cmd->tx_sector = a->lm.snap.sector[1];           /* add3 a,0xe → a+0x70; +0x12 */
    /* vendor перечитывает rf_idx перед каждой из трёх записей — чтения volatile */
    cmd->tx_rf = *(volatile u8 *)&rf_obj.rf_idx;
    /* RX-сектор — из снимка BF; пока успешного BF нет (snap.status != 1: снимок обнулён при открытии соединения),
     * 0xff — «не обучен», uc ставит направленный омни 0x60 + cid. Исправлено (vendor 6.2 слал 0 из пустого снимка —
     * станция слушала узкий сектор 0: первый BRP-инициатор не слышал TRN точки, бит bf_sta_mask не снимался,
     * BRP не шёл никогда, «сигнал» в отчёте −72, штормы CTS; стенд 2026-10-24: с 0xff BRP 3/3). */
    cmd->rx_sector = (a->lm.snap.status == 1) ? a->lm.snap.sector[0] : 0xff;
    cmd->rx_rf = *(volatile u8 *)&rf_obj.rf_idx;
    if (state == 2 || state == 3)
        cmd->omni_sector = 0xffff;
    else
        cmd->omni_sector = a->rx_sector;
    cmd->omni_rf = *(volatile u8 *)&rf_obj.rf_idx;
    cmd->cfg_10 = 0;
    cmd->fixed_link = 0;                 /* OOB R1 (фиксированный линк) — только SparRAW-pro */
    cmd->peer_lo = a->peer_lo;
    cmd->peer_hi = a->peer_hi;
    lmac_if_post_cmd(cmd, 5, 0x28, 0);
}
/* stream_mgr__prepare_1f (0x8dfafc, 67 Б): построить фильтр 0x1f + write_one. */
__attribute__((section(".textlate"))) void stream_mgr_prepare_1f(u32 cid, u32 mask)
{
    u32 w = 0;
    bits_set_s8_w5(&w, 0x1f);
    bits_set32_s0_w4(&w, 0);
    w &= ~(1u << 4);
    if (mask >= 8)
        fw_sysassert_fatal((void *)0, 0x1014);
    mac_filter_write_one(&w, cid, mask);
}
/* mid_list__remove_entry (0x8daa8c, 81 Б): снять запись из mid-списка. */
__attribute__((section(".textlate"))) void mid_list_remove_entry(struct mid *obj, struct conn *entry)
{
    if ((u32)&obj->conns == entry->owner) {
        /* r0 = obj + 0x18 (add_s до cmp) уходит в tx_list__remove: голова списка — obj+0x18
         * (прежде передавался obj → ассерт 0xdb при снятии соединения). */
        tx_list_remove(&obj->conns, entry);
        obj->cid_mask &= ~(1u << entry->cid);
    }
    /* 0x8daac4..0x8daade: cmp_s r1,0x2 / cmp.ne r1,0x3 / mov.eq r0,0x1 / extb.f /
     * bne_s 0x8daae2 — при режиме PCP/AP (2/3) сброс ПРОПУСКАЕТСЯ; state=1 ставится
     * для STA (mode 1).  Прежде условие было инвертировано: у STA после disconnect
     * bss.state оставался 2 → mid_list__any_in_state2 = 1 → START_SCAN шёл по
     * «scan while connected» (is_connected: 0x1), хост не переподключался. */
    if (mid_list_find_by_kind(obj, 1) == 0) {
        u32 mode = entry->mid->bss.mode;
        if (mode != 2 && mode != 3) {
            obj_set_field4_one(&obj->bss);   /* add3 r0,r14,0x9 → obj+0x48 */
            /* исправлено (vendor): AID прошлой ассоциации и таблица SP из ESE (общая с uc) жили после разрыва —
             * новая ассоциация с другим AID по тому же маяку (отпечаток ESE совпал) таблицу не пересобирала, и STA
             * инициировала в SP прежнего AID, т. е. чужой станции (10.36.6). */
            obj->aid = 0;
            if (obj->sched != 0) {
                sched_builder_reset_alloc_list(obj->sched->ese);
                obj->sched->ese_n = 0;
                obj->sched->ese_hash[0] = obj->sched->ese_hash[1] = obj->sched->ese_hash[2] = 0;
            }
        }
    }
}
/* obj__set_field4_one (0x8c4ee4): состояние BSS = 1. */
__attribute__((section(".textlate"))) void obj_set_field4_one(struct mid_bss *obj)
{
    obj->state = MID_BSS_IDLE;
}
/* connection__init (0x8f54a4, 107 Б): инициализировать соединение (MAC пира mac, запись
 * mid). */
__attribute__((section(".textlate"))) void connection_init(struct conn *conn, const u8 *mac, struct mid *mid)
{
    if (conn->msm.sm.state != 0)
        fw_sysassert_fatal((void *)0, 0x11bd);
    conn->n_vrings = 0;
    conn->mid = mid;
    memcpy_fw(conn->peer, mac, 6);
    conn->initiator = 0;
    conn_disc_detail_take(conn->cid);                   /* НЕ vendor: уточнение причины прошлого соединения */
    conn->wvs_mode = 0;
    conn->pbss = 0;
    conn->vs_version = 1;
    conn->sw_tx_busy = 0;
    conn->skip_bf = 0;
    conn->sw_tx_sent = 0;
    connection_store_ptr(&conn->lm, conn);
    obj_vt802458_ctor(&conn->mlme, conn);
    obj_vt802744_ctor(&conn->msm, conn);
    connection_init_fields(conn);
    conn->rx_sector = 0xffff;
}
/* connection__store_ptr (0x8d9264, 43 Б): lm_if — владелец conn, остальное обнулить. */
__attribute__((section(".textlate"))) void connection_store_ptr(struct lm_if *a, struct conn *conn)
{
    a->conn = conn;
    a->lm_sm = 0;
    a->detectors = 0;
    a->snap_time = 0;
    memset0_words(&a->snap, 0x44);
    memset0_words(a->mcs_total, 0x1f);
}
/* obj_vt802458__ctor (0x8f5688, 53 Б): автомат MLME — поля + описатель 0x802458. */
__attribute__((section(".textlate"))) void obj_vt802458_ctor(struct mlme_sm *a, struct conn *conn)
{
    /* записи — в порядке и ширине vendor (две stw_s +0x28/+0x2a, conn последним): через
     * volatile, иначе gcc сливает полуслова в одно слово и переставляет */
    volatile struct mlme_sm *v = a;
    v->busy = 0;
    v->radio_locked = 0;
    v->rm_req = 0;
    v->assoc_timer = 0;
    v->ctrl_timer = 0;
    v->del_sta_timer = 0;
    v->status = 0;
    v->host_reason = 1;
    v->rx_pkt = 0;
    v->host_pkt = 0;
    v->conn = conn;
    if (mlme_sm_created == 0)
        mlme_sm_created = 1;
    basic_sm_bind_descriptor(a, &mlme_sm_desc);
}
/* obj_vt802744__ctor (0x8d8d30, 45 Б): conn_main_sm — поля + описатель 0x802744 +
 * автомат разрыва (disc_flush_sm_init). */
__attribute__((section(".textlate"))) void obj_vt802744_ctor(struct conn_msm *a, struct conn *conn)
{
    a->conn = conn;
    a->bcon_timer = 0;
    a->assoc_wait_timer = 0;
    basic_sm_bind_descriptor(a, &conn_msm_desc);
    a->sm.trace = 1;
    disc_flush_sm_init(&a->disc, a);
}
/* disc_flush_sm__init (0x8f5310, 33 Б): владелец msm + описатель 0x8027a0 + журнал. */
__attribute__((section(".textlate"))) void disc_flush_sm_init(struct conn_disc_sm *a, struct conn_msm *msm)
{
    a->msm = msm;
    basic_sm_bind_descriptor(a, &conn_disc_sm_desc);
    a->sm.trace = 1;
}
/* connection__init_fields (0x8e7574, 45 Б): инициализация полей соединения. */
__attribute__((section(".textlate"))) void connection_init_fields(struct conn *conn)
{
    conn->retry_cnt = 0;
    conn->retry_timer = 0;
    memset0_words(conn->bf_win, 0x10);
    conn->bf_win_pos = 0;
    conn->bf_win_sum = 0;
    conn->bf_win_fill = 0;
    bf_id_update_count = 0;
    conn->bf_avg = 0;
}
/* conn_mgr__activate_conn (0x8c2460, 71 Б): получить/взять cid + add_to_rinking + find_sm.
 * Возвращает cid (mid__link_acquisition_action ставит его бит в [mid+0x24]; прежний
 * порт ничего не возвращал). */
__attribute__((section(".textlate"))) u32 conn_mgr_activate_conn(struct conn *conn, u32 flag)
{
    u32 cid;
    if (flag == 1) {
        if (conn_mgr_allocate_cid_db_element(conn, &cid) == 0)
            fw_sysassert_fatal((void *)0, 0x11cb);
    } else {
        cid = conn->cid;
    }
    fw_log_emit1(0x2b, 0x100be30, cid);
    conn_mgr_add_to_rinking_list(conn);
    find_sm_start_listen(conn, cid);
    return cid;
}

/* conn_mgr__allocate_cid_db_element (0x8c36c0): найти свободный cid-слот в cid_db. */
__attribute__((section(".textlate"))) u32 conn_mgr_allocate_cid_db_element(struct conn *conn, u32 *out)
{
    for (u32 r13 = 0; r13 < SPARRAW_MAX_STA; r13++) {
        *out = r13;
        struct conn_cid_slot *r14 = &conn_mgr.cid_db[r13];
        if (r14->used == 0) {
            r14->conn = conn;
            r14->used = 1;
            /* журнал: cid, conn, состояние слота (8c36ee..8c3702); прежде (1, conn, 0) */
            fw_log_emit3(0x2b, 0x100bd90, r13, (u32)r14->conn, r14->used);
            return 1;
        }
    }
    fw_log_emit0(0x1b, 0x100bdd0);
    return 0;
}
/* conn_mgr__add_to_rinking_list (0x8c2d78, 64 Б): добавить соединение в ranking-список. */
__attribute__((section(".textlate"))) void conn_mgr_add_to_rinking_list(struct conn *conn)
{
    if (conn_mgr_find_in_ranking_list_fw(conn) != 0)
        return;
    struct conn_rank *r14 = mem_pool_allocate(&conn_mgr.rank_pool);   /* add2 0x854000,0x1b → +0x6c */
    if (r14 == 0)
        fw_sysassert_fatal((void *)0, 0x11cc);
    r14->conn = conn;
    list_find_entry_d((u32 *)&conn_mgr.rank_list, (u32 *)r14);
    fw_log_emit1(0x2b, 0x100bdec, conn->cid);
}
/* conn_mgr__find_in_ranking_list_fw (0x8da308, 61 Б): поиск conn в списке ранжирования. */
__attribute__((section(".textlate"))) u32 conn_mgr_find_in_ranking_list_fw(struct conn *conn)
{
    u32 it;
    iter_init(&it, &conn_mgr.rank_list);
    while (list_has_items(&it)) {
        struct conn_rank *e = (struct conn_rank *)iter_next(&it);
        if (e->conn == conn)
            return 1;
    }
    return 0;
}
/* find_sm__start_listen (0x8f9670, 56 Б): set_cid + OWN_START_LINK (0) conn_main_sm. */
__attribute__((section(".textlate"))) void find_sm_start_listen(struct conn *conn, u32 cid)
{
    lm_if_set_cid(&conn->lm, (u8)cid);              /* vendor 0x8f9680: extb_s — беззнаково */
    u32 r3 = (conn->initiator == 1 && conn->pbss == 0) ? 1u : 0u;
    conn_msm_event(&conn->msm, 0, cid, r3, 0);
}
/* lm_if__set_cid (0x8e63a4, 49 Б): запись lm_sm и детекторы по cid + ctor + лог. */
/* cid беззнаковый: vendor 0x8e63ae mul64 r1,0xa4 по нерасширенному байту (было s8 — индекс < 0). */
__attribute__((section(".textlate"))) void lm_if_set_cid(struct lm_if *obj, u8 cid)
{
    obj->lm_sm = &lm_sm_recs[cid];
    obj_vt802da0_ctor(&lm_sm_recs[cid], obj);
    obj->detectors = &ll_detectors[cid];
    fw_log_emit2(0x2b, 0x101428c, (u32)cid, (u32)&ll_detectors[cid]);   /* r3 после st_s [r13,0x7c] */
}
/* obj_vt802da0__ctor (0x8d8b30, 49 Б): автомат lm_sm — описатель 0x802da0 + поля. */
__attribute__((section(".textlate"))) void obj_vt802da0_ctor(struct lm_sm *a, struct lm_if *lm)
{
    basic_sm_bind_descriptor(a, &lm_sm_desc);
    a->lm = lm;
    obj_vt802cc4_ctor(&a->msm, a);
    a->stop_pending = 0;
    a->lm_mode = 0;
    /* два stb, как vendor: volatile, иначе gcc сливает в одно полуслово */
    ((volatile struct lm_sm *)a)->rsv_a0 = -2;
    ((volatile struct lm_sm *)a)->rsv_a1 = -5;
}
/* obj_vt802cc4__ctor (0x8f52bc, 72 Б): автомат maintain_sm — описатель 0x802cc4 + поля +
 * таймаут TXSS. */
__attribute__((section(".textlate"))) void obj_vt802cc4_ctor(struct maintain_sm *a, struct lm_sm *l)
{
    basic_sm_bind_descriptor(a, &maintain_sm_desc);
    obj_vt802f58_ctor(&a->stats, a);
    a->rs_mode = 2;
    a->lt_timer = 0;
    a->win_timer = 0;
    a->radio_req = 0;
    a->radio_locked = 0;
    a->lm_sm = l;
    a->txss_timeout = (dashboard.cfg.special_flags & (1u << 6)) ? 0x2710u : maint_initial_txss_timeout;   /* ld_s [gp,744]: байтовое смещение (прежде ×4 = 0x800d24) */
    a->mcs = 0;
    obj_vt802cc4_noop_vmethod(a);
}
/* obj_vt802f58__ctor (0x8d8dc0, 37 Б): автомат статистики линка — описатель 0x802f58 + поля. */
__attribute__((section(".textlate"))) void obj_vt802f58_ctor(struct link_stats_sm *a, struct maintain_sm *m)
{
    basic_sm_bind_descriptor(a, &link_stats_sm_desc);
    a->latency_timer = 0;
    a->report_timer = 0;
    a->msm = m;
    a->high_per_cnt = 0;
}
__attribute__((section(".textlate"))) void obj_vt802cc4_noop_vmethod(struct maintain_sm *a) { (void)a; }

/* conn_mgr__link_down_evt (0x8daae8): лог + conn_abort + free_cid_db_element. Запись соединения освобождается —
 * её элемент списка ранжирования тоже (исправлено, vendor: после тайм-аута/отказа ассоциации и разрыва во время неё
 * список держал указатель на свободную запись; соединение на той же записи потом в список не вставало). */
__attribute__((section(".textlate"))) void conn_mgr_link_down_evt(struct conn *conn)
{
    fw_log_emit0(0x2b, 0x100bd2c);
    conn_mgr_ranking_remove(conn);
    if (conn->msm.assoc_wait_timer != 0) {          /* AP: ожидание Assoc Request (conn.c) */
        u_schd_cancel(conn->msm.assoc_wait_timer);
        conn->msm.assoc_wait_timer = 0;
    }
    conn_abort(conn, 0);
    conn_mgr_free_cid_db_element(conn->cid);
}
/* conn_mgr__free_cid_db_element (0x8caf54, 81 Б): освободить cid-запись. */
__attribute__((section(".textlate"))) void conn_mgr_free_cid_db_element(u32 cid)
{
    struct conn_cid_slot *r13 = &conn_mgr.cid_db[cid];
    fw_log_emit3(0x2b, 0x100bcf0, cid, (u32)r13->conn, r13->used);
    if (r13->used == 0)
        fw_sysassert_fatal((void *)0, 0x11cf);
    /* 8caf80: пустой слот — ассерт 0x11d0, затем освобождение как обычно */
    if (r13->conn == 0)
        fw_sysassert_fatal((void *)0, 0x11d0);
    stream_mgr_check_vring(&conn_mgr.conn_pool, r13->conn);
    r13->conn = 0;
    r13->used = 0;
}

/* free_dband_info (0x8f31a0): лог + stream_mgr_check_vring (pool.c). */
__attribute__((section(".textlate"))) void free_dband_info(struct dband_info *entry)
{
    fw_log_emit0(0x2d, 0x1016f84);
    stream_mgr_check_vring(&dband_info_pool, entry);
}
/* channels_switch_sm__action_abort_dwelling (0x8c203c, 44 Б; STOP_SCAN в DWELLING): снять
 * таймер пребывания (поле vendor не обнуляет) и STOP_DWELL. */
void channels_switch_sm_abort_dwelling(struct channels_switch_sm *cs)
{
    fw_log_emit0(0x29, 0x1017560);
    if (cs->dwell_tmr != 0)
        u_schd_cancel(cs->dwell_tmr);
    basic_sm_handle_event(cs, 4, 0, 0, 0);
}

/* conn__disconnect (0x8f2540): лог + lm_if_disable_link_loss_monitoring +
 * basic_sm_handle_event + conn_check_field_50. */
__attribute__((section(".textlate"))) void conn_disconnect(struct conn *conn, u32 reason, u32 protocol)
{
    fw_log_emit2(0x2d, 0x101030c, reason, conn->cid);
    lm_if_disable_link_loss_monitoring(&conn->lm);
    conn_msm_event(&conn->msm, 8, reason, protocol, 0);
    conn_check_field_50(conn);
}
/* lm_if__disable_link_loss_monitoring (0x8c8f90, 48 Б): лог cid/is_enabled,
 * остановить мониторинг потери линка и сбросить ссылку на детекторы. */
__attribute__((section(".textlate"))) void lm_if_disable_link_loss_monitoring(struct lm_if *obj)
{
    u32 cid = obj->conn->cid;           /* conn__get_cid (0x8cbed0) */
    u32 en  = (obj->detectors != 0) ? 1u : 0u;
    fw_log_emit2(0x2b, 0x10142fc, cid, en);     /* "disable_link_loss_monitoring: cid=%d, is_enabled=%d" */
    lm_if_stop_link_loss_monitoring(obj);
    obj->detectors = 0;
}
/* lm_if__stop_link_loss_monitoring (0x8e7fbc, 63 Б): лог + 3 stop-подсистемы. */
__attribute__((section(".textlate"))) void lm_if_stop_link_loss_monitoring(struct lm_if *obj)
{
    u32 en = (obj->detectors != 0) ? 1u : 0u;
    /* журнал: cid соединения (0x8cbed0), не сам obj; второй детектор — m + 0x54
     * (add2 m,0x15), прежде m + 0x2a */
    fw_log_emit2(0x2b, 0x10142c4, obj->conn->cid, en);
    struct ll_detectors *m = obj->detectors;
    if (m != 0) {
        lm_if_stop_link_b(&m->ageing);
        lm_if_stop_link_a(&m->ka);
        bad_beacons_detector_stop_monitoring(&m->bcn);
    }
}
/* lm_if__stop_link_b (0x8e8088, 34 Б): при is_armed → detector_arm_timer + peer_check_flag_30. */
__attribute__((section(".textlate"))) void lm_if_stop_link_b(struct ll_ageing_det *a)
{
    if (ll_detector_is_armed_b(a) != 0) {
        detector_arm_timer(&a->svc);
        peer_check_flag_30(a);
    }
}
/* lm_if__stop_link_a (0x8e806c, 34 Б): при is_armed → detector_arm_timer + ka_check_peer_state. */
__attribute__((section(".textlate"))) void lm_if_stop_link_a(struct ll_ka_det *a)
{
    if (ll_detector_is_armed(a) != 0) {
        detector_arm_timer(&a->svc);
        ka_check_peer_state(a);
    }
}
/* bad_beacons_detector__stop_monitoring (0x8e8050, 35 Б): лог + armed = 0. */
__attribute__((section(".textlate"))) void bad_beacons_detector_stop_monitoring(struct ll_bcn_det *a)
{
    fw_log_emit0(0x2b, 0x1014dac);
    a->armed = 0;
}
/* ll_detector__is_armed_b (0x8da378, 39 Б): cid != 0xff && ctx != 0. */
__attribute__((section(".textlate"))) u32 ll_detector_is_armed_b(struct ll_ageing_det *a)
{
    return (a->cid != 0xff && a->ctx != 0) ? 1u : 0u;
}
/* detector__arm_timer (0x8e7e8c, 31 Б): u_schd_now + cancel + stopped = 1 (vt->stop). */
__attribute__((section(".textlate"))) void detector_arm_timer(struct psvc *obj)
{
    u_schd_now();
    timer_task_cancel(obj);
    obj->stopped = 1;
}
/* timer_task__cancel (0x8c8e74, 36 Б): u_schd_now + снять задачу-таймер. */
__attribute__((section(".textlate"))) void timer_task_cancel(struct psvc *obj)
{
    u_schd_now();
    if (obj->timer != 0) {
        u_schd_cancel(obj->timer);
        obj->timer = 0;
    }
}
/* peer__check_flag_30 (0x8c6844, 66 Б): не привязан — обнулить снимки; иначе сбросить
 * простой cid (ctx->idle). */
__attribute__((section(".textlate"))) void peer_check_flag_30(struct ll_ageing_det *obj)
{
    if (ll_detector_is_armed_b(obj) == 0) {
        obj->last_traffic = 0;
        obj->last_pring_time = 0;
        obj->last_act = 0;
        obj->last_scan_step = 0;
        obj->last_hook = 0;
        return;
    }
    u32 idx = obj->cid;
    if (idx >= SPARRAW_MAX_STA)
        fw_sysassert_fatal((void *)0, 0x1503);
    obj->ctx->idle[idx] = 0;
}
/* ll_detector__is_armed (0x8da35c, 39 Б): cid != 0xff && ctx != 0. */
__attribute__((section(".textlate"))) u32 ll_detector_is_armed(struct ll_ka_det *a)
{
    return (a->cid != 0xff && a->ctx != 0) ? 1u : 0u;
}
/* ka__check_peer_state (0x8c67f0, 78 Б): период keep-alive cid — по умолчанию, накопленное
 * время — 0. */
__attribute__((section(".textlate"))) void ka_check_peer_state(struct ll_ka_det *obj)
{
    if (ll_detector_is_armed(obj) == 0) {
        obj->last_traffic = 0;
        return;
    }
    u32 idx = obj->cid;
    if (idx >= SPARRAW_MAX_STA)
        fw_sysassert_fatal((void *)0, 0x1548);
    struct ll_ctx *base = obj->ctx;
    base->ka_period[idx] = base->cfg[idx].ka_period_hi;
    base->ka_acc[idx] = 0;
}
/* conn__check_field_50 (0x8c68d4): снять таймер повтора соединения. */
__attribute__((section(".textlate"))) void conn_check_field_50(struct conn *conn)
{
    if (conn->retry_timer != 0) {
        u_schd_cancel(conn->retry_timer);
        conn->retry_timer = 0;
    }
}

/* stream_mgr__ready_for_modify (0x8e23a4, 164 Б): готовность стрима к
 * модификации. Стрим vring idx (stream_by_vr); если удалён — лог, если vr == 9 —
 * выход; иначе для не-bcast — stream_mgr_ready_step (соединение — conn_by_cid(pring-id)),
 * затем метод ready (vt[4]) контекста. */
__attribute__((section(".textlate"))) void stream_mgr_ready_for_modify(u32 idx, u32 a1)
{
    struct stream_ctx *s = stream_by_vr[idx];
    (void)a1;

    if (s == 0) {
        fw_log_emit0(0x1b, 0x1010a00);           /* "stream was already removed" */
        return;
    }
    if (s->vr == 9)
        return;

    if (s->bcast == 0) {
        /* vring__get_pring_id: не bcast → cid соединения */
        struct conn *r14 = conn_mgr_by_cid(s->conn->cid);
        if (r14 == 0)
            fw_sysassert_fatal((void *)0, 0x128e);   /* vendor: далее с r14=0 */
        stream_mgr_ready_step();
    }

    s->vt->ready(s);
}

/* stream_mgr__ready_step (0x8e8310): обойти все mid-записи и scan_resume активные. */
__attribute__((section(".textlate"))) void stream_mgr_ready_step(void)
{
    u32 it;
    field_set_0x00_8e5dfc(&it, mids_get_count());
    while (bit_iter_has_more(&it)) {
        u32 bit = bitmap_alloc_bit(&it);
        struct mid *mid = mid_list_by_mid_fw(bit);
        if (mid_list_count_active(mid) != 0)
            scan_resume(&mid->disc);
    }
}
/* mid_list__count_active (0x8cb7a0, 74 Б): идёт ли у какой-нибудь записи mid скан
 * (disc.scan->active != 0) или поиск (disc.find.active). Аргумент vendor не читает. */
__attribute__((section(".textlate"))) u32 mid_list_count_active(struct mid *mid)
{
    (void)mid;
    u32 it;
    iter_init(&it, &mid_list);
    for (;;) {
        if (!list_has_items(&it))
            return 0;
        struct mid_disc *e = &((struct mid *)iter_next(&it))->disc;
        if (e->scan->active != 0 || e->find.active != 0)
            return 1;
    }
}

/* scan_resume (0x8f8304, 53 Б): лог + при state активен scan_mngr_resume_scan. */
__attribute__((section(".textlate"))) void scan_resume(struct mid_disc *obj)
{
    fw_log_emit0(0x2c, 0x1016e08);
    if (obj->scan->active == 0)
        return;
    fw_log_emit1(0x2c, 0x1016e18, obj->mid->id);
    scan_mngr_resume_scan(obj->scan);
}
/* scan_mngr__resume_scan (0x8f8028, 56 Б): сбросить флаги + kick scan-SM. */
__attribute__((section(".textlate"))) void scan_mngr_resume_scan(struct scan_mngr *obj)
{
    fw_log_emit0(0x29, 0x1015364);
    if (obj->postponed == 0) {
        fw_log_emit0(0x29, 0x1015380);
        return;
    }
    obj->postponed = 0;
    obj->aborted = 0;
    scan_mngr_kick_scan_state_machine(obj);
}
/* scan_mngr__kick_scan_state_machine (0x8f5d1c, 64 Б): START_SCAN автомату каналов или
 * SCAN_START автомату скана при соединении (аргумент — scan_mngr). */
__attribute__((section(".textlate"))) void scan_mngr_kick_scan_state_machine(struct scan_mngr *obj)
{
    if (obj->is_connected == 0) {
        fw_log_emit0(0x29, 0x10150fc);
        basic_sm_handle_event(obj->cs, 0, 0, 0, 0);
    } else {
        fw_log_emit0(0x29, 0x1015180);
        basic_sm_handle_event(&obj->swc, 0, (u32)obj, 0, 0);
    }
}


/* Кадр хосту: WMI_RX_MGMT_PACKET_EVENTID (0x1840: pkt->info, длина кадра + 0x10, mid
 * info.mid, внешний буфер) — общий хвост ветвей discovery__rx_pkt_handler. */
static void discovery_send_rx_mgmt(struct rx_pkt *pkt)
{
    low_sme_send_evt2sw(&pkt->info, 0x1840, (u16)(pkt->info.len + sizeof(pkt->info)),
                        pkt->info.mid, 1, 0, 0);
}


/* discovery__rx_pkt_handler (0x8e3f0c, 332 Б; метод [1] объекта e+0x234 записи mid):
 * DMG-бикон (подтип 0 extension-кадра), probe req (4) / resp (5). Принятый (обработчик
 * вернул ≠ 0) кадр — хосту WMI_RX_MGMT_PACKET_EVENTID (0x1840: pkt->info, длина кадра +
 * 0x10, mid info.mid, внешний буфер); отвергнутый — освободить. probe req уходит
 * хосту всегда. Счётчики — struct mgmt_stats (0x843158). Прежний порт: бикон хосту без проверки и без
 * освобождения, probe req/resp хосту не передавались, счётчиков не было; vtable-указатель
 * 0x800710 (fw_ptrmap — по комментарию) попадал в discovery_send_rx_mgmt(obj, pkt). */
void discovery_rx_pkt_handler(struct mid_disc *obj, struct rx_pkt *pkt)
{
    volatile struct mgmt_stats *cnt = &mgmt_stats;
    u32 type = FC_STYPE(pkt->hdr->fc);
    u32 ok;
    if (rx_mgmt_prepare(pkt) == 0) {                  /* усечённый кадр — отбросить (у vendor разбирался) */
        mgmt_pkt_release(pkt);
        mem_pool_free_thunk(pkt);
        return;
    }
    switch (type) {
    case 0:                                                 /* DMG-бикон */
        ok = dmg_bcon_rx_handler(obj, pkt);
        cnt->bcon_rx += 1;
        mgmt_pkt_release(pkt);
        if (ok == 0) {
            mem_pool_free_thunk(pkt);
            break;
        }
        fw_log_emit0(0x2c, 0x1016bdc);
        discovery_send_rx_mgmt(pkt);
        cnt->bcon_to_host += 1;
        break;
    case 4:                                                 /* probe request */
        cnt->probe_req_rx += 1;
        fw_log_emit1(0x2c, 0x1016c20, cnt->probe_req_rx);
        discovery_handle_probe_req(obj, pkt);
        mgmt_pkt_release(pkt);
        fw_log_emit1(0x2c, 0x1016c58, cnt->probe_req_rx);
        discovery_send_rx_mgmt(pkt);
        break;
    case 5:                                                 /* probe response */
        fw_log_emit1(0x2c, 0x1016ca8, cnt->probe_resp_rx);
        cnt->probe_resp_rx += 1;
        ok = discovery_handle_probe_resp(obj, pkt);
        mgmt_pkt_release(pkt);
        if (ok == 0) {
            mem_pool_free_thunk(pkt);
            break;
        }
        fw_log_emit0(0x2c, 0x1016ce4);
        discovery_send_rx_mgmt(pkt);
        cnt->probe_resp_to_host += 1;
        break;
    default:
        fw_sysassert_fatal(0, 0x1231);
        break;
    }
}
