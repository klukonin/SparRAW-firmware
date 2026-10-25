// SPDX-License-Identifier: AGPL-3.0-or-later
/* Action-кадры (802.11 9.6): диспетчер stream_mgr::action (0x8c1e08) по категории —
 * Block Ack (3), Public (4), DMG (0x10: PSC, Information Request/Response) — и
 * обработчики, которые он зовёт. Пакет RX (struct rx_pkt): body — кадр (заголовок
 * 0x18 Б), info.len — длина кадра, info.mid, info.cid. */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/mbox.h"
#include "../include/conn.h"
#include "../include/mid.h"
#include "../include/ieee80211.h"
#include "../include/lmac_cmd.h"
#include "../include/sys_cfg.h"
#include "../include/fwdata.h"


/* Состояние соединения «связь есть» — автомат MLME в состоянии 2 (ASSOCIATED). */
#define CONN_STATE_LINKED 2

/* ---------------- Block Ack (категория 3) ---------------- */

/* ba_sm__setup_result (0x8c42a4, 112 Б): ADDBA Request пира, когда соединение ещё не в
 * состоянии 2, — ответить ADDBA Response с отказом (статус 1, окно 0, без A-MSDU). Имя
 * справки от строки журнала «BA Setup …»; по коду это отказ. f — тело действия. */
__attribute__((section(".textlate"))) void ba_sm_setup_result(const struct ieee80211_addba *f, struct conn *conn)
{
    u32 len = 0;
    u32 pl = TX_API_alloc_tx_payload();
    u32 tid = (f->params[0] >> 2) & 0xfu;
    mgmt_tx_begin_frame(pl, &len, conn->mid, conn, 0xd);
    len += frame_build_addba_resp((struct ieee80211_addba_resp *)(pl + len), f->token, 0, tid, 0, 1, 0);
    tx_api_send_mgmt(conn, 0, 1, pl, len & 0xffffu, 0, 0);
    fw_log_emit2(0x2b, 0x10106bc, tid, f->token);
}


/* ---------------- DMG (категория 0x10) ---------------- */

/* ЭНЕРГОСБЕРЕЖЕНИЕ ВЫРЕЗАНО СОЗНАТЕЛЬНО (решение владельца, 2026-10-20): в OpenWrt PS
 * всегда выключен, а место в ICCM дорого. Ни станция, ни AP/PCP в PS не переходят и чужой PS
 * не обслуживают. Это НЕ соответствует IEEE 802.11-2020: в PICS (B.4.24.1) обязательны
 * DMG-M13.1 (PS без расписания, 11.2.7.2.2/11.2.7.2.4, ATIM 11.2.7.4 — в т. ч. буферизация
 * AP для станций в doze, Awake Window и UPSIM) и DMG-M21.3 (кадры PSC, 9.6.19.2/9.6.19.3).
 * Оставлено только: AP/PCP отвечает отказом на просьбу о расписании (PSC-REQ). */

#define DMG_ACT_PSC_RSP             1
#define WLAN_STATUS_REQUEST_DECLINED 37      /* 802.11-2020 табл. 9-80 */

static void psc_reject_tx_done(u32 pl, u32 status, u32 a2)
{
    (void)status;
    (void)a2;
    TX_API_free_memory(pl);
}

/* PSC-REQ пира cid (9.6.19.2: Category, DMG Action, Dialog Token, DMG Power Management,
 * [DMG Wakeup Schedule]). DPM = 1 — просьба о расписании/переходе в PS: PSC-RSP (9.6.19.3)
 * с Status Code REQUEST_DECLINED, без расписания («a status code indicating the reason for
 * rejecting the request», 11.2.7.2.3). DPM = 0 — переход в active: PSC-RSP не шлётся
 * («shall not send a PSC-RSP frame if the DPM field is 0», 11.2.7.2.4). Vendor (pcp_psc_sm)
 * принимал расписание и уводил станцию в PS. */
__attribute__((section(".textlate"), noinline)) void psc_req_reject(u32 cid, const u8 *f)
{
    struct conn *conn = conn_mgr_by_cid(cid);
    u32 pl, len = 0;
    u8 *d;

    if (conn == 0 || (f[3] & 1u) == 0)
        return;
    pl = TX_API_alloc_tx_payload();
    if (pl == 0)
        return;
    mgmt_tx_begin_frame(pl, &len, conn->mid, conn, 0xd);
    d = (u8 *)(pl + len);
    d[0] = 0x10;                                  /* Category: DMG */
    d[1] = DMG_ACT_PSC_RSP;
    d[2] = f[2];                                  /* Dialog Token из PSC-REQ */
    d[3] = (u8)WLAN_STATUS_REQUEST_DECLINED;      /* Status Code, LE */
    d[4] = 0;
    len += 5;
    fw_log_emit0(0x2e, 0x1002a10);              /* «PSC Request» (vendor-строка) */
    tx_api_send_mgmt(conn, 0, 1, pl, len & 0xffffu, psc_reject_tx_done, 0);
}

/* 0x802424: Subject по умолчанию для DMG Information Response — широковещательный MAC
 * (6 Б; vendor читает словом и полусловом, mov_s r1,0x802424). */
FWDATA(802424) __attribute__((aligned(4))) const u8 info_resp_dflt_subject[6] = {
    0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
};


/* ---------------- диспетчер ---------------- */


/* 0x80242c: таблица переходов switch vendor stream_mgr__action (0x8c1e08;
 * ldb, цель = 0x8c1e4c + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(80242c) const u8 stream_mgr_action_jt_80242c[12] = {
    0xc6, 0xc6, 0xc6, 0x1e, 0x68, 0xc6, 0xc6, 0xc6, 0xc6, 0xc6, 0xc6, 0xc6,
};
/* 0x802438: таблица переходов switch vendor stream_mgr__action (0x8c1e08;
 * ldb, цель = 0x8c1e6c + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(802438) const u8 stream_mgr_action_jt_802438[5] = {
    0xb6, 0xb6, 0xb6, 0x00, 0xb6,
};
/* 0x802440: таблица переходов switch vendor stream_mgr__action (0x8c1e08;
 * ldb, цель = 0x8c1f6e + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(802440) const u8 stream_mgr_action_jt_802440[8] = {
    0x1d, 0x26, 0x02, 0x08, 0x00, 0x00, 0x00, 0x00,
};

/* stream_mgr::action (0x8c1e08, хвост до 0x8c2016): action-кадр пира по категории
 * (таблицы переходов 0x80242c для 0..0xb, 0x802438 для 0xd..0x11, 0x802440 для действий
 * DMG). Обработанный кадр освобождается (0x8cb15c); прочие — журнал категории и хосту
 * WMI_RX_MGMT_PACKET_EVENTID (0x1840) целиком (pkt+0x28, длина кадра + 0x10, mid).
 *  - 3 (Block Ack): соединение cid в состоянии 2 — ADDBA Request / Response / DELBA
 *    (иное действие — ассерт 0x1298); иначе на ADDBA Request — дамп и отказ пиру (если
 *    соединение есть); кадр освобождается в любом случае;
 *  - 4 (Public): журнал, хосту (FTM в открытой версии нет — SparRAW-pro);
 *  - 0x10 (DMG): без OOB-режима [0x803c0c] — только PSC Request (0) / Response (1),
 *    иное — хосту; в OOB-режиме ещё Information Request (2) / Response (3, при
 *    соединении в состоянии 2), действия 4..7 — хосту, ≥ 8 — дамп, ассерт 0x1506, хосту;
 *  - остальные категории — дамп и хосту.
 * len — длина тела действия (кадр − 0x18). */
__attribute__((section(".textlate"))) void stream_mgr_action(struct rx_pkt *pkt)
{
    u32 cid = pkt->info.cid;
    const u8 *f = pkt->body + IEEE80211_HDR_LEN;
    u32 cat, act;

    u32 done = 0;

    /* Ошибки vendor (исправлено): длина тела не проверялась (Category/Action и поля ADDBA/DELBA читались за
     * концом короткого кадра); Block Ack Action 3..127 (резерв, табл. 9-359) — фатальный ассерт 0x1298 из эфира;
     * кадр Block Ack обрабатывался по cid без сверки TA с адресом пира соединения. Теперь: короче Category+Action
     * или минимального тела ADDBA Request/Response (9 октетов, 9.6.4.2–3) / DELBA (6, 9.6.4.4) — отбросить;
     * неизвестное действие — хосту; TA ≠ пир соединения — как кадр без соединения. */
    if (pkt->info.len < IEEE80211_HDR_LEN + 2u) {
        mem_pool_free_thunk(pkt);
        return;
    }
    cat = f[0];
    act = f[1];

    switch (cat) {
    case 3: {
        struct conn *conn = conn_mgr_by_cid(cid);
        if (conn != 0 && memcmp_fw(conn->peer, pkt->hdr->addr2.b, 6) != 0)
            conn = 0;
        if (act <= 2 && pkt->info.len < IEEE80211_HDR_LEN + (act == 2 ? 6u : 9u)) {
            fw_log_emit2(0x2b, 0x101079c, act, pkt->info.len);
            done = 1;
        } else if (conn != 0 && conn->mlme.sm.state == CONN_STATE_LINKED) {
            if (act == 0)
                stream_mgr_addba_req_handler((const struct ieee80211_addba *)f, cid);
            else if (act == 1)
                stream_mgr_addba_rsp_handler((const struct ieee80211_addba_resp *)f, cid);
            else if (act == 2)
                stream_mgr_delba_handler((const struct ieee80211_delba *)f, cid);
            else
                break;                                  /* резерв / NDP ADDBA — хосту */
        } else if (act == 0) {
            fw_log_emit0(0x2b, 0x101079c);
            hexdump_words(pkt->body, pkt->info.len);
            if (conn != 0)
                ba_sm_setup_result((const struct ieee80211_addba *)f, conn);
            else
                fw_log_emit0(0x2b, 0x10107cc);
        }
        done = 1;
        break;
    }
    case 4:
        fw_log_emit0(0x2b, 0x1010800);
        break;
    case 0x10:
        /* OOB R1 (PSC + Information Request/Response + список станций PBSS в fw) — только
         * SparRAW-pro; здесь как без OOB у vendor. */
        if (act == 0) {
            psc_req_reject(cid, f);                   /* PS вырезан — см. psc_req_reject */
            done = 1;
        } else if (act == 1) {
            done = 1;                                 /* PSC-RSP: мы PSC-REQ не шлём */
        }
        break;
    default:
        hexdump_words(pkt->body, pkt->info.len);
        break;
    }

    if (done) {
        mem_pool_free_thunk(pkt);
        return;
    }
    fw_log_emit1(0x2b, 0x1010834, cat);
    low_sme_send_evt2sw(&pkt->info, 0x1840, (pkt->info.len + sizeof(pkt->info)) & 0xffffu,
                        pkt->info.mid, 1, 0, 0);
}
