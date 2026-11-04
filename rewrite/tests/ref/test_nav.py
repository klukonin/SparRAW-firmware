# SPDX-License-Identifier: AGPL-3.0-or-later
"""NAV DMG STA (ref/nav): несколько NAV — псевдокод 10.39.10 [p. 1902–1905], виртуальный CS 10.3.2.1 [p. 1643],
единый NAV DMG 10.3.2.4 [p. 1648–1649], CF-End 10.23.2.10 [p. 1751] / 10.39.10, конец SP 10.39.6.6.5 [p. 1894].
Ожидания — из текста стандарта."""
from fractions import Fraction as Fr

import pytest

from . import nav as N
from . import timing as T
from .cbap import NAV_TIMEOUT

A, B, C, D, E, F, ME = 'a', 'b', 'c', 'd', 'e', 'f', 'me'


def test_constants():
    # табл. 11-22: aMinNAVTimersNumber 2; 10.3.2.4: NAVTimeout DMG = 2·aSIFSTime + T_DMG-CTS + aSlotTime + 2·aSlotTime
    assert T.aMinNAVTimersNumber == 2
    assert NAV_TIMEOUT == 2 * T.aSIFSTime + T.txtime_control(20) + T.aSlotTime + 2 * T.aSlotTime
    with pytest.raises(AssertionError):
        N.MultiNav(ME, n=1)                       # «shall be not less than aMinNAVTimersNumber»


def test_initial_state_null_and_idle():
    # 10.39.10: «all NAVs shall have NULL values for their NAVSRC and NAVDST …, NAV_RTSCANCELABLE … false, … value 0»
    m = N.MultiNav(ME)
    assert all(x.src is N.NULL and x.dst is N.NULL and not x.rts_cancel and not x.dts_cancel for x in m.timers)
    assert not m.busy(0)


def test_ra_own_no_change():
    # «If (received_frame(RA) ≠ This STA MAC address || UPDATE_OPTIONAL = true) {…} else { No change to NAV }»
    m = N.MultiNav(ME)
    assert m.rx(10, N.NavFrame('RTS', ME, A, 100)) is None
    assert not m.busy(20)


def test_rts_sets_rtscancelable_and_reset_after_navtimeout():
    m = N.MultiNav(ME)
    assert m.rx(10, N.NavFrame('RTS', B, A, 100)) == 0
    x = m.timers[0]
    assert (x.src, x.dst, x.end, x.rts_cancel) == (A, B, 110, True)
    # 10.39.10: без PHY-RXSTART в течение NAVTimeout «may reset to 0 any NAV whose NAV_RTSCANCELABLE value is true»
    assert m.busy(10 + NAV_TIMEOUT - Fr(1, 10)) and not m.busy(10 + NAV_TIMEOUT)
    m2 = N.MultiNav(ME)
    m2.rx(10, N.NavFrame('RTS', B, A, 100))
    m2.rx_start(10 + NAV_TIMEOUT)                 # DMG CTS начался в пределах NAVTimeout
    assert m2.busy(109) and not m2.busy(110)


def test_update_only_if_greater_and_rtscancelable_cleared():
    # «If (UPDATE_OPTIONAL = false && R_DUR > NAV(N_TIMER)) { NAV ← R_DUR; RTS → true, иначе false }»
    m = N.MultiNav(ME)
    m.rx(10, N.NavFrame('RTS', B, A, 100))
    assert m.rx(20, N.NavFrame('Data', B, A, 50)) is None          # 50 < остатка 90 — без изменений
    assert m.timers[0].end == 110 and m.timers[0].rts_cancel
    assert m.rx(20, N.NavFrame('Data', B, A, 200)) == 0
    assert m.timers[0].end == 220 and not m.timers[0].rts_cancel


def test_pairs_use_separate_timers_and_full_table_drops():
    m = N.MultiNav(ME)
    assert m.rx(0, N.NavFrame('Data', B, A, 100)) == 0
    assert m.rx(0, N.NavFrame('Data', D, C, 50)) == 1
    # нет совпадения и нет свободного (NULL или NAV = 0) таймера — «If (N_TIMER ≥ 0)» не выполняется
    assert m.rx(1, N.NavFrame('Data', F, E, 500)) is None
    assert m.timers[0].end == 100 and m.timers[1].end == 50
    # таймер с NAV = 0 переиспользуется («|| NAV(x) = 0»)
    assert m.rx(60, N.NavFrame('Data', F, E, 500)) == 1
    assert (m.timers[1].src, m.timers[1].dst) == (E, F)


def test_virtual_cs_any_nonzero():
    # 10.3.2.1: «when at least one of the counters is nonzero, the indication is busy»
    m = N.MultiNav(ME)
    m.rx(0, N.NavFrame('Data', B, A, 100))
    m.rx(0, N.NavFrame('Data', D, C, 300))
    assert m.busy(150) and not m.busy(300)


def test_ack_matches_by_destination_only():
    # «else if (received_frame = Ack) { R_DST ← RA; R_SRC ← 0 }»; поиск: «If (received_frame = Ack || …) If
    # (NAVDST(x) = R_DST)»
    m = N.MultiNav(ME)
    m.rx(0, N.NavFrame('Data', B, A, 100))        # таймер 0: (A, B)
    assert m.rx(5, N.NavFrame('Ack', B, None, 200)) == 0           # NAVDST = B = RA Ack
    assert m.timers[0].end == 205
    assert m.rx(6, N.NavFrame('Ack', C, None, 50)) == 1            # новый: (0, C)
    assert (m.timers[1].src, m.timers[1].dst) == (N.ZERO, C)


def test_zero_address_filled_from_next_frame():
    # «If one of NAVSRC or NAVDST of a NAV is 0 and the nonzero … match either the RA or the TA …, the NAVSRC or
    # NAVDST that is 0 shall be set to the RA or TA that does not match»
    m = N.MultiNav(ME)
    m.rx(0, N.NavFrame('Ack', C, None, 50))       # (0, C)
    m.rx(10, N.NavFrame('Data', C, D, 10))        # RA C совпал с NAVDST → NAVSRC ← D
    assert (m.timers[0].src, m.timers[0].dst) == (D, C)


def test_reverse_pair_literal_vs_alt():
    # СПОРНО (докстрока nav): буквально обратная пара занимает новый таймер; альтернатива — тот же
    lit, alt = N.MultiNav(ME), N.MultiNav(ME, literal=False)
    for m in (lit, alt):
        m.rx(0, N.NavFrame('RTS', B, A, 100))
        m.rx(20, N.NavFrame('DMG CTS', A, B, 200))
    assert lit.timers[1].src == B and lit.timers[1].dst == A
    assert alt.timers[0].end == 220 and alt.timers[1].src is N.NULL


def test_dts_update_optional_and_sp_end_reset():
    # DMG DTS: «UPDATE_OPTIONAL ← true», пара — NAV-SA/NAV-DA; обновление — по решению реализации или «RA = This STA
    # MAC address && This STA MAC address = source DMG STA MAC address for current SP»; NAV_DTSCANCELABLE ← true
    m = N.MultiNav(ME)
    assert m.rx(0, N.NavFrame('DMG DTS', A, None, 100, nav_sa=C, nav_da=D)) is None     # реализация не обновляет
    m2 = N.MultiNav(ME, sp_source=lambda t: ME)
    assert m2.rx(0, N.NavFrame('DMG DTS', ME, None, 100, nav_sa=C, nav_da=D)) == 0
    x = m2.timers[0]
    assert (x.src, x.dst, x.dts_cancel, x.end) == (C, D, True, 100)
    # 10.39.6.6.5: источник SP по окончании SP «may reset any NAV to 0 that has … NAV_DTSCANCELABLE … true»
    m2.sp_end(40, i_am_source=True)
    assert not m2.busy(40)
    m3 = N.MultiNav(ME, update_dts=True)
    assert m3.rx(0, N.NavFrame('DMG DTS', A, None, 100, nav_sa=C, nav_da=D)) == 0
    m3.sp_end(40, i_am_source=False)
    assert m3.busy(50)


def test_cf_end_sets_duration_for_matching_pair_any_order():
    # 10.39.10: CF-End «with RA and TA values that match the NAVSRC and NAVDST values, in any order» → NAV = Duration
    m = N.MultiNav(ME)
    m.rx(0, N.NavFrame('RTS', B, A, 1000))
    m.rx(0, N.NavFrame('Data', D, C, 1000))
    assert m.rx(100, N.NavFrame('CF-End', A, B, 18)) == 0           # (B→A) — в обратном порядке
    assert m.timers[0].end == 118 and m.timers[1].end == 1000
    # нулевой NAVSRC: совпадение NAVDST с RA или TA CF-End
    m2 = N.MultiNav(ME)
    m2.rx(0, N.NavFrame('Ack', C, None, 500))
    assert m2.rx(10, N.NavFrame('CF-End', E, C, 0)) == 0
    assert not m2.busy(10)


def test_single_nav_rules_10_3_2_4():
    # «RA is equal to the STA's own MAC address … shall not update»; «DMG CTS frame and its TA is equal to the STA's
    # own MAC address … shall not update»
    assert not N.single_nav_updates(N.NavFrame('RTS', ME, A, 10), ME)
    assert not N.single_nav_updates(N.NavFrame('DMG CTS', A, ME, 10), ME)          # CTS-to-self с TA = мне
    assert N.single_nav_updates(N.NavFrame('DMG CTS', A, B, 10), ME)
    assert N.single_nav_updates(N.NavFrame('DMG Beacon', T.BCAST, A, 10), ME)


@pytest.mark.parametrize('multi', [False, True])
def test_check_nav_log_cts_to_self(multi):
    # DMG CTS-to-self точки (9.3.1.13: RA = адрес передатчика, TA = получатель следующего кадра) с TA = нам: NAV не
    # обновляется (10.3.2.4), наш RTS в пределах её Duration — не нарушение; с чужим TA — NAV занят, RTS — нарушение
    # Псевдокод 10.39.10 (несколько NAV) исключения «TA = свой» не содержит: пара (свой, точка) получает таймер, и NAV
    # занят — исключение 10.3.2.4 только для «DMG STAs that support a single NAV».
    ap = 'ap'
    ev = [N.LogEv(0, 14, 'DMG CTS', ap, ME, 77), N.LogEv(30, 44, 'RTS', ap, ME, 1000, tx=True)]
    assert len(N.check_nav_log(ev, ME, multi=multi)) == (1 if multi else 0)
    ev = [N.LogEv(0, 14, 'DMG CTS', ap, '06:00:00:00:00:00', 77), N.LogEv(30, 44, 'RTS', ap, ME, 1000, tx=True)]
    v = N.check_nav_log(ev, ME, multi=multi)
    assert [x.rule for x in v] == ['nav_busy'] and v[0].idx == 1
    # ответ (DMG CTS на RTS, Ack) — не инициация
    ev = [N.LogEv(0, 14, 'DMG CTS', ap, 'x', 77), N.LogEv(30, 44, 'Ack', ap, None, 0, tx=True, response=True)]
    assert N.check_nav_log(ev, ME, multi=multi) == []


def test_check_nav_log_beacon_and_cf_end():
    ap = 'ap'
    # Duration DMG Beacon (RA широковещательный) занимает NAV до конца BTI; CF-End с Duration 0 — сброс в его конце
    ev = [N.LogEv(0, 10, 'DMG Beacon', T.BCAST, ap, 300), N.LogEv(200, 214, 'RTS', ap, ME, 100, tx=True)]
    assert len(N.check_nav_log(ev, ME)) == 1
    ev = [N.LogEv(0, 10, 'DMG Beacon', T.BCAST, ap, 300), N.LogEv(100, 110, 'CF-End', T.BCAST, ap, 0),
          N.LogEv(200, 214, 'RTS', ap, ME, 100, tx=True)]
    assert N.check_nav_log(ev, ME) == []
