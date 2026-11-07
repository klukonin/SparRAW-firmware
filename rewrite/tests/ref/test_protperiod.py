# SPDX-License-Identifier: AGPL-3.0-or-later
"""Защищённый период DMG (10.39.6.6.1–10.39.6.6.6 [p. 1888–1894]); aDMGPPMinListeningTime, aRTSTimeoutTime —
табл. 11-22."""
from fractions import Fraction as Fr

from . import duration as D
from . import protperiod as P
from .timing import SIFS, aAirPropagationTime, aDMGPPMinListeningTime

SRC, DST, OTHER = '02:00:00:00:00:01', '02:00:00:00:00:02', '02:00:00:00:00:03'
SP = P.Sp(1000, 3000, SRC, DST)


def test_constants_and_timeouts():
    assert aDMGPPMinListeningTime == 150
    assert P.T_RTS == D.tx('rts') and P.T_DTS == D.tx('dmg_dts')
    # aRTSTimeoutTime = TXTIME(RTS) + aAirPropagationTime + aRxPHYDelay + aMACProcessingDelay (PLAN.md №69)
    assert P.rts_timeout(upper=False) == P.T_RTS + aAirPropagationTime
    assert P.rts_timeout() == P.T_RTS + aAirPropagationTime + 3
    assert P.rts_refresh_interval() == 150 - P.rts_timeout()
    assert P.must_create(False, 1, 1) and not P.must_create(True, 1, 0) and not P.must_create(False, 0, 1)


def test_source_rts_rules():
    s = P.PpStation(SRC)
    ok, why = s.may_send_rts(1000, SP)
    assert not ok and 'прослушивание' in why
    s.listen(1000 - 150)
    assert s.may_send_rts(1000, SP)[0]
    assert not s.may_send_rts(990, SP)[0]                               # вне SP
    assert not s.may_send_rts(SP.end - 1, SP)[0]                        # RTS не помещается в SP
    s.navs.append(P.Nav(1200, OTHER, '02:00:00:00:00:04', False))
    ok, why = s.may_send_rts(1000, SP)
    assert not ok and 'NAV' in why
    assert s.sp_use_from(SP) == 1200                                     # 10.39.6.6.1: после обнуления NAV
    assert not P.PpStation(DST).may_send_rts(1000, SP)[0]
    d = s.rts_duration(1100, SP)
    assert 1100 + P.T_RTS + d <= SP.end


def test_destination_cts_or_dts():
    r = P.PpStation(DST)
    r.listen(800)
    t0, t1 = 1000, 1000 + P.T_RTS
    assert r.on_rts(t0, t1, SRC, SP) == ('DMG CTS', None, None, None, t1 + SIFS)
    assert r.on_rts(t0, t1, OTHER, SP) is None                           # TA ≠ источник SP
    r.navs.append(P.Nav(2000, OTHER, '02:00:00:00:00:04', True))
    kind, dur, sa, da, t = r.on_rts(t0, t1, SRC, SP)
    assert kind == 'DMG DTS' and (sa, da) == (OTHER, '02:00:00:00:00:04')
    assert dur == D.field(2000 - t - P.T_DTS)                            # NAV − TXTIME(DTS)
    # прослушивание короче aDMGPPMinListeningTime: DTS c NAV-SA = NAV-DA = свой адрес и недостающим временем
    q = P.PpStation(DST)
    q.listen(1000)
    kind, dur, sa, da, t = q.on_rts(1000, t1, SRC, SP)
    assert kind == 'DMG DTS' and sa == da == DST and dur >= 150 - (t - 1000)


def test_unsolicited_dts_and_sp_end():
    r = P.PpStation(DST)
    r.listen(500)
    r.navs.append(P.Nav(2500, OTHER, SRC, True))
    assert not r.may_send_dts(1000 + P.rts_timeout() - 1, SP)[0]
    assert r.may_send_dts(1000 + P.rts_timeout(), SP)[0]
    assert not r.may_send_dts(SP.end - 1, SP)[0]                        # не помещается в SP
    r.rts_seen = True
    assert not r.may_send_dts(1100, SP)[0]
    s = P.PpStation(SRC)
    s.navs = [P.Nav(5000, OTHER, SRC, True), P.Nav(5000, OTHER, DST, False)]
    s.sp_end(SP)
    assert s.navs == [P.Nav(5000, OTHER, DST, False)]                  # 10.39.6.6.5


def test_air_checks():
    assert P.check_rts(1100, 1000, SRC, SP) == []
    assert any('за концом SP' in m for m in P.check_rts(1100, 3000, SRC, SP))
    assert any('вне SP' in m for m in P.check_rts(900, 10, SRC, SP))
    assert P.check_rts(900, 10, OTHER, SP) == []
    rts_end = 1100 + P.T_RTS
    assert P.check_dts(rts_end + SIFS, 0, DST, SP, rts_end=rts_end) == []
    assert any('через SIFS' in m for m in P.check_dts(rts_end + 10, 0, DST, SP, rts_end=rts_end))
    assert any('aRTSTimeoutTime' in m for m in P.check_dts(1001, 0, DST, SP))
    assert any('вне SP' in m for m in P.check_dts(SP.end - 2, 0, DST, SP))
    assert any('Duration DTS' in m for m in P.check_dts(1500, 10, DST, SP, nav_end=2000))
    assert P.check_cts_answer(rts_end, rts_end + SIFS) == [] and P.check_cts_answer(rts_end, rts_end + 9)


def test_interference_report_constraints():
    """10.39.6.6.6: a) NAV в начале SP — Start = начало SP; b) — момент обновления, Duration = NAV; c) — момент
    сброса, Duration 0; Period 0 (PLAN.md №70), Interferer — NAVDST."""
    ev = [P.NavEvent('start', 1000, 300, OTHER), P.NavEvent('extend', Fr(1500), 200, OTHER),
          P.NavEvent('truncate', 1600, 0, OTHER)]
    assert P.interference_constraints(1000, ev) == [(1000, 300, 0, OTHER), (1500, 200, 0, OTHER), (1600, 0, 0, OTHER)]
