# SPDX-License-Identifier: AGPL-3.0-or-later
"""ref/linkadapt: элементы DMG Link Margin (9.4.2.142 [p. 1262], рис. 9-583, табл. 9-266), DMG Link Adaptation
Acknowledgment (9.4.2.143 [p. 1263], рис. 9-584), TPC Report (9.4.2.16, рис. 9-175); кадры Link Measurement
Request/Report (9.6.6.4/9.6.6.5 [p. 1460–1461], рис. 9-862/9-863, табл. 9-363); правила 10.43.1–10.43.3
[p. 1970–1972] и 11.10.11 [p. 2217]; правила судьи link_meas и link_margin. Ожидания — из текста стандарта."""
from fractions import Fraction as Fr

import pytest

from . import air_judge as J
from . import elements as E
from . import linkadapt as L
from . import timing as T
from .test_air_judge_c import AP, STA, Air


def lm(activity=0, mcs=1, margin=5, snr=Fr(10), ts=0x12345678):
    return L.LinkMargin(activity, mcs, margin, snr, ts)


def report(token=0, margin=None, ack=None, rx_ant=0, tx_ant=0, rcpi=100, rsni=40):
    return L.LmReport(token, 10, 3, rx_ant, tx_ant, rcpi, rsni, margin, ack, b'')


# ---------------------------------------------------------------------------------------------- элементы
def test_link_margin_element_layout():
    # рис. 9-583: ID 162, Length 8: Activity, MCS, Link Margin, SNR, Reference Timestamp (4)
    b = L.encode_link_margin(lm(L.ACTIVITY_INC_POWER, 12, -3, Fr(10), 0x01020304))
    assert b[0] == 162 and b[1] == 8
    assert b[2] == 3 and b[3] == 12 and b[4] == 0xFD           # −3 дБ в дополнительном коде
    assert b[5] == (4 * (10 - 19)) & 0xFF                     # PLAN.md №36: как SNR 9.5.3
    assert b[6:10] == bytes([4, 3, 2, 1])
    assert L.parse_link_margin(b[2:]) == lm(3, 12, -3, Fr(10), 0x01020304)


def test_link_margin_none_is_minus_128():
    # 9.4.2.142: «This field is set to –128 to indicate that no link margin is provided»
    b = L.encode_link_margin(lm(margin=None))
    assert b[4] == 0x80 and L.parse_link_margin(b[2:]).margin is None


def test_snr_range_and_extensible():
    # 9.4.2.142: «Values are from –13 dB to 50.75 dB in 0.25 dB steps»
    assert L.parse_link_margin(L.encode_link_margin(lm(snr=Fr(-13)))[2:]).snr == -13
    assert L.parse_link_margin(L.encode_link_margin(lm(snr=Fr(203, 4)))[2:]).snr == Fr(203, 4)
    assert L.snr_field(100) == L.snr_field(Fr(203, 4))         # насыщение
    # табл. 9-92: DMG Link Margin — расширяемый (10.28.8): хвост отбрасывается
    info = L.encode_link_margin(lm())[2:] + b'\x99'
    assert L.parse_link_margin(info) == lm()
    with pytest.raises(ValueError):
        L.parse_link_margin(info[:7])


def test_mcs_codes():
    # 9.4.2.142: 0–12, 25–31 — как есть; 133…138, 140 — 12.1, 9.1, 12.3, 12.4, 12.5, 12.2, 12.6
    assert [L.mcs_name(c) for c in (133, 134, 135, 136, 137, 138, 140)] == \
        ['12.1', '9.1', '12.3', '12.4', '12.5', '12.2', '12.6']
    assert L.mcs_name(25) == '25' and L.mcs_name(13) is None and L.mcs_name(139) is None
    assert L.mcs_code('9.1') == 134 and L.mcs_code(12) == 12
    with pytest.raises(ValueError):
        L.mcs_code(20)
    assert any('MCS' in m for m in L.check_link_margin(lm(mcs=20)))


def test_activity_reserved():
    # табл. 9-266: 7–255 Reserved
    assert L.check_link_margin(lm(activity=6)) == []
    assert any('Activity 7' in m for m in L.check_link_margin(lm(activity=7)))
    assert L.check_la_ack(L.LaAck(200, 0))


def test_la_ack_layout():
    # рис. 9-584: ID 172, Length 5: Activity, Reference Timestamp
    b = L.encode_la_ack(L.LaAck(2, 0xAABBCCDD))
    assert b == bytes([172, 5, 2, 0xDD, 0xCC, 0xBB, 0xAA])
    assert L.parse_la_ack(b[2:]) == L.LaAck(2, 0xAABBCCDD)


def test_rcpi_table_9_176():
    assert L.rcpi(-60) == 100                                  # ⌊2 × (P + 110)⌋
    assert L.rcpi(-110) == 0 and L.rcpi(0) == 220 and L.rcpi(None) == 255
    assert L.rcpi(Fr(-1095, 10)) == 1


# ---------------------------------------------------------------------------------------------- кадры
def test_lm_request_layout_and_power():
    # рис. 9-862: Category 5, Radio Measurement Action 2, Dialog Token, Transmit Power Used, Max Transmit Power
    b = L.encode_lm_request(L.LmRequest(7, -5, 10))
    assert b == bytes([5, 2, 7, 0xFB, 10])
    req, extra = L.parse_lm_request(b)
    assert req == L.LmRequest(7, -5, 10) and extra == b''
    assert L.check_lm_request(req) == []
    # 9.4.1.20: Transmit Power Used ≤ Max Transmit Power
    assert any('9.4.1.20' in m for m in L.check_lm_request(L.LmRequest(1, 12, 10)))
    # 10.43.3: запрос быстрой адаптации — Dialog Token 0
    assert any('Dialog Token' in m for m in L.check_lm_request(L.LmRequest(1, 0, 10), fla=True))


def test_lm_report_layout():
    # рис. 9-863: Category, Action 3, Dialog Token, TPC Report (4), Receive/Transmit Antenna ID, RCPI, RSNI, DMG Link
    # Margin, DMG LA Ack
    r = report(token=7, margin=lm(), ack=L.LaAck(0, 1))
    b = L.encode_lm_report(r)
    assert b[:3] == bytes([5, 3, 7]) and b[3:7] == bytes([35, 2, 10, 3]) and b[7:11] == bytes([0, 0, 100, 40])
    assert b[11] == 162 and b[21] == 172
    assert L.parse_lm_report(b) == r
    bad = bytearray(b)
    bad[3] = 36
    with pytest.raises(ValueError):
        L.parse_lm_report(bytes(bad))


def test_lm_report_field_rules():
    assert L.check_lm_report(report(margin=lm())) == []
    # 9.4.2.39: «A specific DMG antenna has a DMG antenna ID between 0 and 3»
    assert any('Antenna' in m for m in L.check_lm_report(report(rx_ant=4)))
    # табл. 9-176: RCPI 221–254 Reserved
    assert any('RCPI' in m for m in L.check_lm_report(report(rcpi=230)))
    # порядок рис. 9-863: LA Ack после DMG Link Margin
    b = L.encode_lm_report(report())[:11] + L.encode_la_ack(L.LaAck(0, 0)) + L.encode_link_margin(lm())
    assert any('9-863' in m for m in L.check_lm_report(L.parse_lm_report(b)))


def test_report_reply_rules():
    req = L.LmRequest(9, 0, 10)
    assert L.check_report_reply(report(9, lm()), req, STA, STA) == []
    # 10.43.1: RA отчёта = TA запроса; DMG — DMG Link Margin обязателен; 9.6.6.5: токен запроса
    assert any('RA' in m for m in L.check_report_reply(report(9, lm()), req, STA, AP))
    assert any('DMG Link Margin' in m for m in L.check_report_reply(report(9), req, STA, STA))
    assert any('Dialog Token' in m for m in L.check_report_reply(report(3, lm()), req, STA, STA))


# ---------------------------------------------------------------------------------------------- обмен 10.43.1
def rx(t_end, snr=Fr(12), margin=6, p=-50):
    return L.Rx(t_end, STA, snr, margin, p, 60, 0)


def test_responder_token_nonzero_measures_next_frame():
    s = L.LinkMeasResponder(AP, policy=lambda r: (L.ACTIVITY_MCS, '9.1'))
    assert s.on_request(STA, L.LmRequest(5, 0, 10), rx(1000, snr=Fr(3), p=-70)) is None
    ra, rep = s.on_rx(STA, rx(1500, snr=Fr(20)))
    assert ra == STA and rep.token == 5
    # 10.43.1: MCS/SNR/Link Margin — по следующему кадру; Reference Timestamp — конец его PPDU
    assert rep.margin.snr == 20 and rep.margin.ref_ts == 1500 and rep.margin.mcs == 134
    # 9.6.6.5: RCPI — «of the corresponding Link Measurement Request frame»
    assert rep.rcpi == L.rcpi(-70)
    assert L.check_report_reply(rep, L.LmRequest(5, 0, 10), STA, ra) == []


def test_responder_token_zero_and_ap_not_activated():
    s = L.LinkMeasResponder(AP)
    ra, rep = s.on_request(STA, L.LmRequest(0, 0, 10), rx(1000))
    assert rep.token == 0 and rep.margin.ref_ts == 1000
    # 11.10.11: AP с dot11RMLinkMeasurementActivated = false игнорирует запрос
    ap = L.LinkMeasResponder(AP, activated=False, is_ap=True)
    assert ap.on_request(STA, L.LmRequest(3, 0, 10), rx(1000)) is None and ap.on_rx(STA, rx(1200)) is None
    _, u = s.unsolicited(STA, act=L.ACTIVITY_SLS)
    assert u.token == 0 and u.margin.activity == L.ACTIVITY_SLS


# ---------------------------------------------------------------------------------------------- 10.43.2 TPC
def test_tpc_peer_ack_rules():
    got = report(margin=lm(L.ACTIVITY_DEC_POWER, ts=777))
    tpl = report()
    dl, rep = L.TpcPeer(STA).on_report(got, Fr(5000), tpl)
    # выполнил — Activity LA Ack = полученному; срок — 2·aPPDUMaxTime (aPPDUMaxTime = 2 мс, табл. 9-25/20-30)
    assert rep.ack.activity == L.ACTIVITY_DEC_POWER and dl == 5000 + 2 * T.aPPDUMaxTime == 9000
    assert rep.ack.ref_ts == 777
    _, rep0 = L.TpcPeer(STA, implements=False).on_report(got, Fr(0), tpl)
    assert rep0.ack.activity == 0                              # «shall be set to 0»
    assert L.TpcPeer(STA, implements=False, ack_when_not=False).on_report(got, 0, tpl) is None
    # LA Ack — только на Activity 2/3
    assert L.TpcPeer(STA).on_report(report(margin=lm(L.ACTIVITY_MCS)), 0, tpl) is None
    assert L.check_la_ack_reply(rep, got) == [] and L.check_la_ack_reply(rep0, got) == []


def test_la_ack_reply_violations():
    with_ack = report(ack=L.LaAck(L.ACTIVITY_INC_POWER, 0))
    assert L.check_la_ack_reply(with_ack, None)
    assert L.check_la_ack_reply(with_ack, report(margin=lm(L.ACTIVITY_MCS)))
    # Activity — полученный или 0
    assert L.check_la_ack_reply(with_ack, report(margin=lm(L.ACTIVITY_DEC_POWER)))
    assert L.check_la_ack_reply(with_ack, report(margin=lm(L.ACTIVITY_INC_POWER))) == []


# ---------------------------------------------------------------------------------------------- 10.43.3 FLA
def test_fla_caps_and_initiation():
    assert L.check_fla_caps({'fast_link_adaptation': 1, 'reverse_direction': 1}) == []
    assert L.check_fla_caps({'fast_link_adaptation': 1, 'reverse_direction': 0})
    assert L.check_fla_caps({'fast_link_adaptation': 0, 'reverse_direction': 0}) == []
    assert L.fla_may_initiate({'fast_link_adaptation': 1}, {'fast_link_adaptation': 1})
    assert not L.fla_may_initiate({'fast_link_adaptation': 1}, {'fast_link_adaptation': 0})
    assert L.aMinPPDUDurationForDMGMeasurement == Fr(527, 100)


def fla_req(t=Fr(0), dur=Fr(8), agg=True):
    return L.Ppdu(t, t + dur, STA, AP, 4, agg, (L.Frame('LM Request', True, 0, False),), True)


def fla_rep(t, dur=Fr(8), mcs=1):
    return L.Ppdu(t, t + dur, AP, STA, mcs, True, (L.Frame('LM Report', True, 0, False),), True)


def test_fla_exchange_by_figure_10_95():
    req = fla_req()
    seq = [req] + [p._replace(src=AP, dst=STA) for p in L.fla_respond(req.te, fla_rep, Fr(20))]
    v, notes = L.check_fla_exchange(seq, {STA: {'fast_link_adaptation': 1, 'reverse_direction': 1},
                                          AP: {'fast_link_adaptation': 1, 'reverse_direction': 1}})
    assert v == [] and notes == []
    # промежутки ответчика — SIFS, отчёт — не позже BRPIFS
    assert all(b.t - a.te == T.SIFS for a, b in zip(seq[1:], seq[2:]))
    assert seq[-1].t - req.te <= T.BRPIFS
    with pytest.raises(ValueError):
        L.fla_respond(req.te, fla_rep, T.BRPIFS + 1)


def test_fla_exchange_fallback_and_violations():
    req = fla_req()
    # отчёт на MCS 2 и без заполнения: разрешённый откат на 10.43.1 — заметка, не нарушение
    v, notes = L.check_fla_exchange([req, fla_rep(req.te + 30, mcs=2)])
    assert v == [] and notes and notes[0].startswith('откат на 10.43.1') and 'MCS 2' in notes[0]
    # пир без Fast Link Adaptation — нельзя начинать (10.43.3)
    v, _ = L.check_fla_exchange([req, fla_rep(req.te + T.SIFS)], {STA: {'fast_link_adaptation': 1,
                                                                        'reverse_direction': 1},
                                                                  AP: {'fast_link_adaptation': 0}})
    assert any('shall not initiate' in m for m in v)
    # PPDU запроса короче aMinPPDUDurationForDMGMeasurement, вне RD
    v, _ = L.check_fla_exchange([fla_req(dur=Fr(5))._replace(rd=False), fla_rep(Fr(10))])
    assert any('5,27' in m for m in v) and any('RD' in m for m in v)


# ---------------------------------------------------------------------------------------------- судья
def hdr(subtype, a1, a2, a3=AP):
    return bytes([subtype << 4, 0, 0, 0]) + E.mac_bytes(a1) + E.mac_bytes(a2) + E.mac_bytes(a3) + bytes(2)


def act(a, src, dst, t, body, noack=False, tx=None, agg=False, length=None):
    raw = hdr(14 if noack else 13, dst, src) + body
    e = a.add('Action No Ack' if noack else 'Action', src, dst, t, length=length or len(raw) + 4, raw=raw,
              tx=tx or ('AP' if src == AP else 'STA'))
    e.agg = agg
    return e


def caps_frame(a, src, t, **sc):
    cap = E.DmgCapabilities(src, 0, sc, {}, 0, {}, 0, 0)
    raw = hdr(0, AP, src) + E.encode_body(E.ASSOC_REQ, {'capability': 0, 'listen_interval': 0},
                                          [E.encode_element(0, b'x'), E.encode_dmg_capabilities(cap)])
    return a.add(E.ASSOC_REQ, src, AP, t, length=len(raw) + 4, raw=raw, tx='STA')


def test_judge_link_meas_pair_ok():
    a = Air()
    q = act(a, STA, AP, 1000, L.encode_lm_request(L.LmRequest(4, 0, 10)))
    n = a.add('Data', STA, AP, 1100, length=200, mcs=4, tx='STA')       # следующий кадр запросившего
    rep = report(4, lm(ts=int(n.te)))
    act(a, AP, STA, 1500, L.encode_lm_report(rep))
    r = J.r_link_meas(a.ctx())
    assert r.viol == [] and r.checked >= 3, (r.viol, r.unchecked)
    assert q.i >= 0


def test_judge_link_meas_violations():
    a = Air()
    act(a, STA, AP, 1000, L.encode_lm_request(L.LmRequest(4, 12, 10)))      # Transmit Power Used > Max
    a.add('Data', STA, AP, 1100, length=200, mcs=4, tx='STA')
    act(a, AP, STA, 1500, L.encode_lm_report(report(4)))                     # без DMG Link Margin
    r = J.r_link_meas(a.ctx())
    msgs = [m for _, m, _ in r.viol]
    assert any('9.4.1.20' in m for m in msgs) and any('DMG Link Margin' in m for m in msgs)
    # Reference Timestamp не у следующего кадра запросившего — вердикт model (PLAN.md №37)
    a = Air()
    act(a, STA, AP, 1000, L.encode_lm_request(L.LmRequest(4, 0, 10)))
    a.add('Data', STA, AP, 1100, length=200, mcs=4, tx='STA')
    act(a, AP, STA, 1500, L.encode_lm_report(report(4, lm(ts=50))))
    assert [v for _, m, v in J.r_link_meas(a.ctx()).viol if 'Reference Timestamp' in m] == ['model']


def test_judge_fla_capability_needs_rd():
    a = Air()
    caps_frame(a, STA, 1000, fast_link_adaptation=1, reverse_direction=0)
    r = J.r_link_meas(a.ctx())
    assert any('reverse direction' in m for _, m, _ in r.viol)
    a = Air()
    caps_frame(a, STA, 1000, fast_link_adaptation=0, reverse_direction=1)
    r = J.r_link_meas(a.ctx())
    assert r.viol == [] and r.checked == 1


def test_judge_link_margin_la_ack():
    a = Air()
    pr = act(a, AP, STA, 1000, L.encode_lm_report(report(0, lm(L.ACTIVITY_DEC_POWER, ts=900))))
    a.add('Ack', STA, AP, pr.te + T.SIFS, length=14, tx='STA')
    act(a, STA, AP, 3000, L.encode_lm_report(report(0, lm(), L.LaAck(L.ACTIVITY_DEC_POWER, 900))))
    r = J.r_link_margin(a.ctx())
    assert r.viol == [] and r.checked == 2
    # поздно: > 2·aPPDUMaxTime после Ack
    a = Air()
    pr = act(a, AP, STA, 1000, L.encode_lm_report(report(0, lm(L.ACTIVITY_DEC_POWER, ts=900))))
    act(a, STA, AP, 1000 + 4200, L.encode_lm_report(report(0, lm(), L.LaAck(L.ACTIVITY_DEC_POWER, 900))))
    assert any('2·aPPDUMaxTime' in m for _, m, _ in J.r_link_margin(a.ctx()).viol)
    # LA Ack без отчёта с Activity 2/3
    a = Air()
    act(a, AP, STA, 1000, L.encode_lm_report(report(0, lm(L.ACTIVITY_MCS))))
    act(a, STA, AP, 2000, L.encode_lm_report(report(0, lm(), L.LaAck(0, 0))))
    assert any('Activity 2/3' in m for _, m, _ in J.r_link_margin(a.ctx()).viol)


def test_judge_rules_registered():
    assert {J.r_link_meas, J.r_link_margin} <= set(J.RULES)
    assert {'tpc_applied', 'lm_measure', 'fla_immediate'} <= {x[0] for x in J.NOT_CHECKABLE}
