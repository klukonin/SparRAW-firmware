# SPDX-License-Identifier: AGPL-3.0-or-later
"""Точка: Reassociation Request (9.3.3.7) и (Re)Association Request от уже ассоциированной станции (11.3.5.3,
11.3.5.5).

* Reassociation Request — тело: Capability, Listen Interval, Current AP Address (6 Б), затем элементы. Точка
  отвечает Reassociation Response (подтип 3, 9.3.3.8); хосту — WMI_CONNECT_EVENT с телом в форме Assoc Request
  (Capability, Listen Interval, элементы — драйвер wil6210 отрезает 4 байта, wmi.c).
* Запрос от ассоциированной станции: на каждый запрос — ответ (11.3.5.3 a). С включённой драйвером переассоциацией
  на месте (WMI_REASSOC_INPLACE_CFG 0x85b) — Status 0, тот же cid/AID, без Disassociation, хосту — один
  WMI_CONNECT_EVENT того же cid, без DISCONNECT; без неё — прежний путь драйвера (разрыв, затем новая ассоциация)."""
import struct

import pytest

import fwflows as F

CID = 0
WMI_REASSOC_INPLACE_CFG = 0x85b
EV_CONNECT = 0x1002
ST_ASSOC_REQ, ST_ASSOC_RESP, ST_REASSOC_REQ, ST_REASSOC_RESP, ST_DISASSOC = 0, 1, 2, 3, 10
EXTRA_IE = bytes([0xdd, 4, 0x00, 0x11, 0x22, 0x01])         # Vendor Specific — на решение не влияет


def _req_body(reassoc, current_ap=b'\0' * 6):
    body = struct.pack('<HH', 0x10, 1)                      # Capability, Listen Interval
    if reassoc:
        body += bytes(current_ap)                           # Current AP Address (9.3.3.7)
    return body + EXTRA_IE


def _send_req(w, reassoc, cid=CID, peer=F.STA_MAC):
    fw = w.fw
    own = w.own_mac()
    stype = ST_REASSOC_REQ if reassoc else ST_ASSOC_REQ
    fw.call('rx_pkt_handler', fw.rx_pkt(fw.mgmt_frame(stype, own, peer, own, _req_body(reassoc, own)), cid=cid))
    fw.run_tasks()
    F.settle(fw)


def _to_sta(fw, peer=F.STA_MAC):
    """Кадры управления, поставленные в TX для peer: [(подтип, кадр)]."""
    return [((f[0] >> 4) & 0xf, f) for _, f in fw.tx_frames if f[4:10] == bytes(peer) and f[0] & 0x0c == 0]


def _fresh(fw):
    w = F.Fw(fw)
    w.ap_start()
    return w


def _connect_evts(fw, n0=0):
    return [e for e in fw.wmi_evts[n0:] if e.id == EV_CONNECT]


@pytest.mark.parametrize('reassoc', [False, True])
def test_new_station_request_answered_with_matching_subtype(fw, reassoc):
    """Новая станция (SLS в A-BFT, затем запрос): ответ того же вида — Association/Reassociation Response, Status 0;
    хосту — WMI_CONNECT_EVENT с телом Assoc Request (без Current AP Address)."""
    w = _fresh(fw)
    fw.lmac_evt(0x05, F.bf_done(F.SPARRAW_PEER_UNKNOWN, F.STA_MAC, 1, 2))
    F.settle(fw)
    fw.tx_frames.clear()
    n0 = len(fw.wmi_evts)
    _send_req(w, reassoc)
    resp = [f for st, f in _to_sta(fw) if st in (ST_ASSOC_RESP, ST_REASSOC_RESP)]
    assert resp, 'нет ответа на запрос: %s' % [st for st, _ in _to_sta(fw)]
    assert (resp[-1][0] >> 4) & 0xf == (ST_REASSOC_RESP if reassoc else ST_ASSOC_RESP)
    assert struct.unpack_from('<H', resp[-1], 0x1a)[0] == 0
    ev = _connect_evts(fw, n0)
    assert len(ev) == 1
    assert ev[0].body[0x14] == CID + 1, 'AID хосту не тот, что станции (cid + 1)'
    n = ev[0].body[0x11]                                    # assoc_req_len
    assert bytes(ev[0].body[0x17:0x17 + n]) == _req_body(False)


def test_reassoc_request_from_associated_station_no_crash(fw):
    """Reassociation Request от ассоциированной станции (переассоциация по ошибке/перезапуску): fw не падает
    (vendor: ассерт 0x1200 — подтип 2 вне разбора rx_pkt_handler), станции уходит ответ."""
    w = _fresh(fw)
    w.ap_sta_join()
    fw.tx_frames.clear()
    _send_req(w, True)
    assert [st for st, _ in _to_sta(fw) if st in (ST_ASSOC_RESP, ST_REASSOC_RESP)] or \
        ST_DISASSOC in [st for st, _ in _to_sta(fw)]


@pytest.mark.parametrize('reassoc', [False, True])
def test_inplace_reassoc_same_cid_no_disassoc(fw, reassoc):
    """Переассоциация на месте включена драйвером: ассоциированная станция шлёт (Re)Association Request — ответ
    Status 0 того же вида, без Disassociation; cid тот же, автоматы — ассоциирована; хосту — один WMI_CONNECT_EVENT
    того же cid и ни одного DISCONNECT."""
    w = _fresh(fw)
    fw.wmi(WMI_REASSOC_INPLACE_CFG, struct.pack('<B3x', 1))
    w.ap_sta_join()
    w.sta_add_vring()
    conn = w.conn_by_cid(CID)
    fw.tx_frames.clear()
    n0 = len(fw.wmi_evts)
    _send_req(w, reassoc)
    sts = [st for st, _ in _to_sta(fw)]
    assert ST_DISASSOC not in sts, 'Disassociation в ответ на запрос: %s' % sts
    resp = [f for st, f in _to_sta(fw) if st in (ST_ASSOC_RESP, ST_REASSOC_RESP)]
    assert resp and (resp[-1][0] >> 4) & 0xf == (ST_REASSOC_RESP if reassoc else ST_ASSOC_RESP)
    assert struct.unpack_from('<H', resp[-1], 0x1a)[0] == 0
    assert struct.unpack_from('<H', resp[-1], 0x1c)[0] & 0x3fff == CID + 1, 'AID сменился (точка: AID = cid + 1)'
    assert w.cid_of(F.STA_MAC) == CID
    assert (w.msm(conn), w.mlme(conn)) == (F.MSM_KEY_ASSOC, F.MLME_ASSOCIATED)
    evs = fw.wmi_evts[n0:]
    assert F.EV_DISCONNECT not in [e.id for e in evs]
    ev = _connect_evts(fw, n0)
    assert len(ev) == 1 and ev[0].body[0x13] == CID


def test_inplace_disabled_by_default(fw):
    """Без WMI_REASSOC_INPLACE_CFG (стоковый драйвер не умеет CONNECT_EVENT занятого cid) — прежний путь: станция
    разорвана (хосту DISCONNECT), повторный вход — заново."""
    w = _fresh(fw)
    w.ap_sta_join()
    w.sta_add_vring()
    n0 = len(fw.wmi_evts)
    _send_req(w, False)
    assert F.EV_DISCONNECT in [e.id for e in fw.wmi_evts[n0:]]


WMI_ADD_CIPHER_KEY, EV_RING_EN = 0x16, 0x1865


def _add_ptk(w, peer=F.STA_MAC):
    """Хост ставит парный ключ станции (WMI_ADD_CIPHER_KEY, key_usage 0 — PAIRWISE, GCMP 16 Б) после 4-way."""
    b = bytearray(0x33)
    b[1], b[2], b[3] = 3, 0, 16                             # key_type GCMP, PAIRWISE, длина
    b[0xc:0x1c] = bytes(range(16))
    b[0x2d:0x33] = peer
    w.fw.wmi(WMI_ADD_CIPHER_KEY, bytes(b))
    F.settle(w.fw)
    w.fw.advance(200_000, between=F.settle)                  # таймер установки ключа (G_KEY_TMR_DELAY) → NTF_KEY_INSTALLED
    F.settle(w.fw)


def test_inplace_reassoc_rsna_requires_new_key(fw):
    """RSNA: после переассоциации на месте ключ станции недействителен (11.3.5.5 j), соединение снова ждёт ключ
    (conn_main_sm ASSOCIATED, mlme_sm ASSOCIATE); новый ключ хоста (4-way) — снова KEY_ASSOC и WMI_RING_EN_EVENT, как
    при первой ассоциации (драйвер по нему открывает порт)."""
    w = F.Fw(fw)
    w.ap_start(secure=True)
    fw.wmi(WMI_REASSOC_INPLACE_CFG, struct.pack('<B3x', 1))
    w.ap_sta_join()
    w.sta_add_vring()
    _add_ptk(w)
    conn = w.conn_by_cid(CID)
    assert (w.msm(conn), w.mlme(conn)) == (F.MSM_KEY_ASSOC, F.MLME_ASSOCIATED), 'первая ассоциация не дошла до ключа'
    n0 = len(fw.wmi_evts)
    _send_req(w, False)
    assert (w.msm(conn), w.mlme(conn)) == (5, 1), 'после переассоциации не ждёт ключ'
    assert len(_connect_evts(fw, n0)) == 1
    n1 = len(fw.wmi_evts)
    _add_ptk(w)
    assert (w.msm(conn), w.mlme(conn)) == (F.MSM_KEY_ASSOC, F.MLME_ASSOCIATED)
    assert EV_RING_EN in [e.id for e in fw.wmi_evts[n1:]], 'нет WMI_RING_EN_EVENT после нового ключа'
    assert F.EV_DISCONNECT not in [e.id for e in fw.wmi_evts[n0:]]
