# SPDX-License-Identifier: AGPL-3.0-or-later
"""Правила судья эфира волны C (ref/air_judge): A-BFT по BIC и кадры в A-BFT (10.42.5.2 [p. 1946–1947]), ATI
(10.39.3 [p. 1879]), состояние пары и классы кадров (11.3.3 [p. 2128], 11.3.5.1 [p. 2133]), роли BRP после SLS
(10.42.3.1 [p. 1942], 10.42.6.4.2–3 [p. 1961–1963]), NAV узла (10.3.2.4 [p. 1648]), DMG CTS-to-self (9.3.1.13
[p. 809]), поддержание связи (11.27.1 [p. 2355]). Журнал эфира строится прямо из событий (AirEv) с известным временем;
ожидания — из текста стандарта."""
from fractions import Fraction as Fr
from types import SimpleNamespace as NS

from . import air_judge as J
from . import air_pcap as P
from . import brp as B
from . import elements as E
from . import fields as F
from . import timing as T

AP, STA = '24:18:1d:24:3b:0b', '24:18:1d:26:d4:7b'
HDR = bytes(24)


class Air:
    def __init__(self):
        self.evs = []

    def add(self, kind, src, dst, t, length=20, mcs=0, dur=0, raw=None, p=None, tx=None, rx=(), synth=False,
            action=None, t_ok=True):
        t = Fr(t)
        e = P.AirEv(i=len(self.evs), t=t if t_ok else None, te=t + P.ppdu_time(length, mcs) if t_ok else None,
                    t_lo=t, t_hi=t + 50, src=src, dst=dst, kind=kind, dur=dur, mcs=mcs, raw=raw, p=p,
                    length=length, t_ok=t_ok, dur_ok=not synth, body_ok=raw is not None and not synth, synth=synth,
                    tx_node=tx, rx_nodes=list(rx), action=action, mcs_ok=True, agg=False, recs=[])
        self.evs.append(e)
        return e

    def ctx(self):
        air = NS(events=sorted(self.evs, key=lambda e: e.tsort), ap=AP, recs={}, nodes={'AP': AP, 'STA': STA},
                 cal=None, stats={})
        for i, e in enumerate(air.events):
            e.i = i
        return J.Ctx(air, edca=({}, 'тест'))


def ssw(direction, cdown, sector=0):
    return NS(ssw=NS(direction=direction, cdown=cdown, sector_id=sector, antenna_id=0, rxss_length=0),
              fb=F.SswFbIss(total_sectors=63, rx_antennas=0, poll_required=0) if direction == 0 else
              NS(sector_select=1, antenna_select=0, snr_report=0, poll_required=0))


def fb_frame(l_rx=0, blm=None):
    return NS(fb=NS(sector_select=1, antenna_select=0, snr_report=0, poll_required=0),
              brp=NS(l_rx=l_rx, tx_trn_req=0), blm=blm or F.Blm(unit_index=0, value=0, is_master=0))


def brp_raw(initiator, l_rx=0):
    return HDR + bytes([20, 1, 0]) + B.BrpRequest(l_rx=l_rx).encode() + B.BeamRefinement(initiator=initiator).encode()


def beacon(a, t, next_abft, ati=0, cdown=0, dur=0):
    bic = F.Bic(abft_length=1, fss=15, next_abft=next_abft, n_bis_abft=1, ati_present=ati, is_resp_txss=1)
    p = NS(bic=bic, beacon_interval=100, ssw=NS(sector_id=cdown, antenna_id=0, cdown=cdown),
           params=NS(bss_type=3, cbap_only=1, cbap_source=0, privacy=0, ecapc=0))
    return a.add('DMG Beacon', AP, T.BCAST, t, length=46, p=p, tx='AP', dur=dur)


def rule(c, f):
    return f(c)


# ---------------------------------------------------------------------------------------------------- A-BFT, ATI
def test_abft_iss_in_abft_and_bic_sequence():
    a = Air()
    b = beacon(a, 1000, next_abft=0)
    bti_end = b.te
    start = bti_end + T.MBIFS                                  # 10.42.5.1: A-BFT — MBIFS после BTI
    # ISS STA (Direction = 0) в A-BFT: в A-BFT STA — ответчик RSS (10.42.5.2, 10.42.2.3.1: Direction = 1)
    a.add('SSW', STA, AP, start + 20, length=26, p=ssw(0, 63), tx='STA', dur=1012)
    r = rule(a.ctx(), J.r_abft)
    assert any('direction' in m for _, m, _ in r.viol), r.viol
    # RSS по правилам: первый SSW — в начале слота, Direction 1, Duration — до конца слота
    a2 = Air()
    b = beacon(a2, 1000, next_abft=0)
    start = b.te + T.MBIFS
    L = J.A.AbftLayout(start, 2, 16)
    t = start
    for cd in (3, 2, 1, 0):
        e = a2.add('SSW', STA, AP, t, length=26, p=ssw(1, cd), tx='STA')
        e.dur = int(-(-(L.slot_end(0) - e.te) // 1))
        t = e.te + T.SBIFS
    r = rule(a2.ctx(), J.r_abft)
    assert not [m for _, m, _ in r.viol if 'direction' in m or 'ssw_start' in m], r.viol


def test_abft_next_abft_sequence():
    # 10.42.5.1: Next A-BFT уменьшается на 1 по BI
    a = Air()
    bi = 100 * T.TU
    for k, nxt in enumerate((3, 2, 0, 3)):                    # 2 → 0: пропуск значения 1
        beacon(a, 1000 + k * bi, next_abft=nxt)
    r = rule(a.ctx(), J.r_abft)
    assert any(m.startswith('next_abft') for _, m, _ in r.viol)


def test_ati_present_zero_no_announce():
    a = Air()
    beacon(a, 1000, next_abft=1, ati=0)
    a.add('Action No Ack', AP, STA, 1500, length=40, raw=HDR + bytes([20, 0]), tx='AP', action='Announce')
    r = rule(a.ctx(), J.r_ati)
    assert len(r.viol) == 1
    a = Air()
    beacon(a, 1000, next_abft=1, ati=0)
    assert not rule(a.ctx(), J.r_ati).viol


# ---------------------------------------------------------------------------------------------- состояние пары (11.3)
def mgmt(frame, fixed):
    return HDR + E.encode_body(frame, fixed)


def test_assoc_state_class3_before_association():
    a = Air()
    a.add(E.DISASSOC, STA, AP, 100, length=30, raw=mgmt(E.DISASSOC, {'reason': 8}), tx='STA')
    # QoS Null (данные — класс 3) от STA в State 2 (11.3.3), точка приняла — должна ответить Disassociation (11.3.5.1)
    a.add('QoS Null', STA, AP, 200, length=30, mcs=1, synth=True, rx=('AP',))
    a.add(E.ASSOC_REQ, STA, AP, 1000, length=60, raw=mgmt(E.ASSOC_REQ, {'capability': 0, 'listen_interval': 0}),
          tx='STA')
    a.add(E.ASSOC_RESP, AP, STA, 1100, length=60, raw=mgmt(E.ASSOC_RESP, {'capability': 0, 'status': 0, 'aid': 1}),
          tx='AP')
    a.add('Ack', None, AP, 1200, length=14, mcs=1, rx=('AP',), synth=True)
    a.add('QoS Null', STA, AP, 1300, length=30, mcs=1, synth=True, rx=('AP',))          # после ассоциации — можно
    r = rule(a.ctx(), J.r_assoc_state)
    kinds = sorted(m.split(':')[0] for _, m, _ in r.viol)
    assert kinds == ['class_tx', 'missing_reply'], r.viol
    assert all(v == 'ours' for _, _, v in r.viol)


def test_assoc_state_unknown_without_mgmt():
    a = Air()
    a.add('QoS Null', STA, AP, 200, length=30, mcs=1, synth=True, rx=('AP',))
    r = rule(a.ctx(), J.r_assoc_state)
    assert not r.viol and r.unchecked


# ------------------------------------------------------------------------------------------------- роли BRP после SLS
def sls(a, ini, resp, t, l_rx=16):
    tx_i, tx_r = ('AP', 'STA') if ini == AP else ('STA', 'AP')
    a.add('SSW', ini, resp, t, length=26, p=ssw(0, 0), tx=tx_i)
    a.add('SSW', resp, ini, t + 30, length=26, p=ssw(1, 0), tx=tx_r)
    a.add('SSW-Feedback', ini, resp, t + 60, length=28, p=fb_frame(l_rx), tx=tx_i)
    return a.add('SSW-Ack', resp, ini, t + 90, length=28, p=fb_frame(l_rx), tx=tx_r)


def test_brp_role_sls_initiator_is_brp_initiator():
    a = Air()
    sls(a, AP, STA, 1000)
    a.add('BRP', AP, STA, 1140, length=42, raw=brp_raw(1, 16), tx='AP')
    a.add('BRP', STA, AP, 1200, length=42, raw=brp_raw(0), tx='STA')
    r = rule(a.ctx(), J.r_brp_role)
    assert not r.viol and r.checked
    # ответчик SLS начинает свою транзакцию (Initiator = 1) — нарушение 10.42.3.1 / 10.42.6.4.2
    a = Air()
    sls(a, AP, STA, 1000)
    a.add('BRP', STA, AP, 1140, length=42, raw=brp_raw(1, 16), tx='STA')
    a.add('BRP', AP, STA, 1240, length=42, raw=brp_raw(1, 16), tx='AP')
    r = rule(a.ctx(), J.r_brp_role)
    assert len(r.viol) == 1 and 'ответчик SLS STA' in r.viol[0][1]


def test_brp_role_initiator_must_send_brp_after_lrx():
    # 10.42.6.4.3: L-RX > 0 в SSW-Ack → инициатор «shall initiate the beam refinement transaction»
    a = Air()
    sls(a, STA, AP, 1000)
    a.add('RTS', STA, AP, 2000, tx='STA')
    sls(a, STA, AP, 3000, l_rx=0)
    r = rule(a.ctx(), J.r_brp_role)
    assert len(r.viol) == 1 and '10.42.6.4.3' in r.viol[0][1]


# ------------------------------------------------------------------------------------------- NAV и DMG CTS-to-self
def cts_self(a, t, ta, dur=77):
    return a.add('DMG CTS', AP, AP, t, p=NS(ra=AP, ta=ta), tx='AP', rx=('STA',), dur=dur)


def test_cts_to_self_ta_must_be_recipient():
    a = Air()
    c = cts_self(a, 1000, STA)
    a.add('Data', AP, '01:00:5e:7f:ff:fa', c.te + T.SIFS, length=222, mcs=1, rx=('STA',), dur=59)
    r = rule(a.ctx(), J.r_cts_self)
    assert len(r.viol) == 1 and '≠ RA следующего кадра' in r.viol[0][1]
    a = Air()
    c = cts_self(a, 1000, '01:00:5e:7f:ff:fa')
    a.add('Data', AP, '01:00:5e:7f:ff:fa', c.te + T.SIFS, length=222, mcs=1, rx=('STA',), dur=59)
    assert not rule(a.ctx(), J.r_cts_self).viol
    a = Air()
    cts_self(a, 1000, '06:00:00:00:00:00')
    r = rule(a.ctx(), J.r_cts_self)
    assert len(r.viol) == 1 and 'не из BSS' in r.viol[0][1]


def test_nav_rx_cts_to_self_ta_rule():
    # 10.3.2.4: DMG CTS с TA = свой — NAV не обновляется; с чужим TA — обновляется, и новый доступ в его пределах —
    # нарушение (10.3.2.1)
    a = Air()
    c = cts_self(a, 1000, '06:00:00:00:00:00')
    a.add('RTS', STA, AP, c.te + 20, tx='STA', dur=500)
    r = rule(a.ctx(), J.r_nav_rx)
    assert len(r.viol) == 1
    a = Air()
    c = cts_self(a, 1000, STA)
    a.add('RTS', STA, AP, c.te + 20, tx='STA', dur=500)
    assert not rule(a.ctx(), J.r_nav_rx).viol


# ------------------------------------------------------------------------------------------- поддержание связи
def test_blm_undefined_and_expiry():
    a = Air()
    sls(a, STA, AP, 1000, l_rx=0)
    r = rule(a.ctx(), J.r_blm)
    assert r.checked == 1 and not r.viol and 'не определён' in r.verdict_note
    # BLM 32 мкс × 10 = 320 мкс у обеих (не мастер) → таймер 320; следующий кадр пары через 1000 мкс — истёк
    a = Air()
    blm = F.Blm(unit_index=0, value=10, is_master=0)
    a.add('SSW', STA, AP, 1000, length=26, p=ssw(0, 0), tx='STA')
    a.add('SSW-Feedback', STA, AP, 1060, length=28, p=fb_frame(0, blm), tx='STA')
    ack = a.add('SSW-Ack', AP, STA, 1090, length=28, p=fb_frame(0, blm), tx='AP')
    a.add('RTS', STA, AP, ack.te + 1000, tx='STA')
    r = rule(a.ctx(), J.r_blm)
    assert len(r.viol) == 1 and '11.27.1' in r.viol[0][1]
