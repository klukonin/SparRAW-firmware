# SPDX-License-Identifier: AGPL-3.0-or-later
"""Этап 4, п. 3: Link Measurement с DMG Link Margin и DMG LA Ack (10.43.1, 10.43.2, 11.10.11, MLME-LINKMEASURE 6.3.32),
Information Request/Response (11.28) в ядре — точка + две станции в идеальной среде, судьи — 0 нарушений."""
import pytest

from .. import discovery as DS
from .. import elements as E
from .. import linkadapt as LA
from ..timing import BCAST
from . import sap_mlme as ML
from .conftest import fmt, judge_all
from .scenario import Bss


def _ev(mac, *names):
    return [(t, w, kw) for t, w, kw in mac.events if w in names]


def _run(rm=True, ap_rm=True, power=True, RB=None):
    b = Bss(seed=5, n_sta=2, bf='dti', ul_bytes=100_000, dl_bytes=100_000)
    for m in b.stas:
        m.rm_link_meas = rm
        m.radio_measurement = True
    b.ap.rm_link_meas = ap_rm
    b.ap.radio_measurement = True
    b.ap.lm_power_advice = power
    b.run(max_bis=20)
    s1, s2 = b.stas
    t = b.sim.now
    b.sim.at(t + 1000, s1.mlme_request, ML.MlmeLinkMeasureRequest(PeerMACAddress=b.ap.addr, DialogToken=7,
                                                                  TransmitPower=8, MaxTransmitPower=10))
    b.sim.at(t + 5000, b.ap.mlme_request, ML.MlmeLinkMeasureRequest(PeerMACAddress=s2.addr, DialogToken=9,
                                                                    TransmitPower=10, MaxTransmitPower=10))
    b.sim.at(t + 9000, s1.info_request, b.ap.addr, None, (LA.EID_RM_ENABLED,))
    b.sim.at(t + 11000, s1.info_request, b.ap.addr, BCAST, ())
    b.sim.at(t + 13000, s1.info_request, s2.addr, b.ap.addr, ())
    b.sim.at(t + 15000, s2.info_request, s1.addr, None, (), True)
    b.sim.run(t + 30000 + 20 * 1024)
    return b


@pytest.fixture(scope='module')
def lm_run(RB):
    b = _run()
    c, rules, va, evs, found = judge_all(b, RB)
    assert not va and not found, fmt(c, va, evs, found, RB)
    return b, {r.rid: r for r in rules}


def test_link_measurement_exchange(lm_run):
    b, st = lm_run
    s1, s2 = b.stas
    conf = [p for p in s1.sme.log if isinstance(p, ML.MlmeLinkMeasureConfirm)]
    assert conf and conf[0].ResultCode == ML.SUCCESS and conf[0].DialogToken == 7
    m = conf[0].DMGLinkMargin
    # 10.43.1: DMG Link Margin в отчёте; токен ≠ 0 — измерение на следующем кадре (QoS Null после Ack на запрос)
    assert m is not None and conf[0].TransmitPower == b.ap.tx_power_dbm
    assert _ev(s1, 'lm_measure_frame')
    rep = [r for r in b.journal.recs if r.node == 'AP' and r.kind == 'Action' and r.mpdus[0][24:26] == bytes([5, 3])]
    nxt = [r for r in b.journal.recs if r.node == 'STA1' and r.kind == 'QoS Null']
    assert rep and nxt and abs(m.ref_ts - int(nxt[0].te)) <= 1          # Reference Timestamp — конец кадра измерения
    # 10.43.2: совет «уменьшить мощность» — ядро мощность не меняет: LA Ack с Activity 0 (отчёт с токеном 0)
    assert m.activity == LA.ACTIVITY_DEC_POWER
    acks = [kw for _, _, kw in _ev(s1, 'lm_report_tx') if kw['ack']]
    assert acks and acks[0]['token'] == 0
    # рекомендация MCS точке (Activity Change MCS) — верхняя граница MCS точки к STA2
    conf2 = [p for p in b.ap.sme.log if isinstance(p, ML.MlmeLinkMeasureConfirm)]
    assert conf2 and conf2[0].DMGLinkMargin.activity == LA.ACTIVITY_MCS
    assert b.ap.peers[s2.addr].lm_mcs == int(LA.mcs_name(conf2[0].DMGLinkMargin.mcs))
    assert st['link_meas'].checked > 0 and st['link_margin'].checked > 0


def test_information_request_response(lm_run):
    b, st = lm_run
    s1, s2 = b.stas
    got = [DS.parse(body)[0] for ta, body in s1.info_rx]
    by = [(f.subject, len(f.dmg_caps)) for f in got]
    # о точке: DMG Capabilities точки + запрошенный RM Enabled Capabilities (поддержан)
    assert by[0] == (b.ap.addr, 1) and any(e.eid == LA.EID_RM_ENABLED for e in got[0].provided)
    # обо всех STA — точка: свой + обеих станций (11.28.1)
    assert by[1][0] == BCAST and by[1][1] == 3
    # non-AP STA2 спрошена не о себе — ответ «без элементов»: только свой DMG Capabilities (PLAN №60)
    assert by[2] == (b.ap.addr, 1) and not got[2].provided
    # проверка присутствия: Request без ID — ответ есть
    assert _ev(s1, 'info_response_tx') and _ev(s2, 'info_response_rx')
    assert st['info_req'].checked > 0


def test_ap_ignores_without_rm(RB):
    """11.10.11: точка с dot11RMLinkMeasurementActivated = false запрос игнорирует; MLME-LINKMEASURE.confirm — отказ по
    тайм-ауту; судья — не нарушение (Link Measurement Capability Enabled = 0 объявлен)."""
    b = _run(ap_rm=False, power=False)
    s1 = b.stas[0]
    assert _ev(b.ap, 'lm_ignored')
    conf = [p for p in s1.sme.log if isinstance(p, ML.MlmeLinkMeasureConfirm)]
    assert conf and conf[0].ResultCode == ML.UNSPECIFIED_FAILURE
    c, rules, va, evs, found = judge_all(b, RB)
    assert not va and not found, fmt(c, va, evs, found, RB)


def test_neg_report_without_link_margin(RB, monkeypatch):
    """Отчёт на запрос без DMG Link Margin — судья link_meas (10.43.1 «shall contain the DMG Link Margin element»)."""
    orig = LA.encode_lm_report
    monkeypatch.setattr(LA, 'encode_lm_report', lambda r: orig(r._replace(margin=None)))
    b = _run(power=False)
    c, rules, va, evs, found = judge_all(b, RB)
    assert any(v.rule == 'link_meas' and 'DMG Link Margin' in v.msg for v in va), fmt(c, va, evs, found, RB)


def test_neg_la_ack_without_power_advice(RB, monkeypatch):
    """LA Ack без принятого совета мощности — судья link_margin (10.43.2)."""
    orig = LA.encode_lm_report

    def with_ack(r):
        return orig(r._replace(ack=LA.LaAck(0, 1)))
    monkeypatch.setattr(LA, 'encode_lm_report', with_ack)
    b = _run(power=False)
    c, rules, va, evs, found = judge_all(b, RB)
    assert any(v.rule == 'link_margin' and 'LA Ack' in v.msg for v in va), fmt(c, va, evs, found, RB)


def test_rm_enabled_in_association(lm_run):
    """RM Enabled Capabilities (бит Link Measurement) — в Association Request/Response (табл. 9-34/9-35)."""
    b, st = lm_run
    for kind in (E.ASSOC_REQ, E.ASSOC_RESP):
        r = next(r for r in b.journal.recs if r.kind == kind)
        _, els = E.parse_body(kind, r.mpdus[0][24:])
        assert any(e.eid == LA.EID_RM_ENABLED and e.info[0] & 1 for e in els)
    assert st['mgmt_body'].checked > 0
