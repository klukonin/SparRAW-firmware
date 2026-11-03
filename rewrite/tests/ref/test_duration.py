# SPDX-License-Identifier: AGPL-3.0-or-later
"""Эталон Duration/ID DMG: значения из формул 802.11-2020 (TXTIME — timing.py, плюс ручной расчёт по 20.11.3),
граничные случаи кодирования (табл. 9-9), цепочки NAV и нарушения, которые check_duration обязана отвергать."""
from fractions import Fraction as Fr
from math import ceil

import pytest

from . import duration as D
from . import timing as T


def ctrl_tx(length):
    """Независимый ручной TXTIME control mode (20.11.3): (50+9)·128·Tc + (88 + (L−6)·8 + NCW·168)·32·Tc."""
    ncw = 1 + ceil(Fr((length - 6) * 8, 168))
    return Fr(59 * 128 + (88 + (length - 6) * 8 + ncw * 168) * 32, 1760)


TX_CTS = ctrl_tx(20)        # DMG CTS = RTS = CF-End: 20 октетов
TX_DTS = ctrl_tx(26)
TX_SSW = ctrl_tx(26)
TX_FB = ctrl_tx(28)         # SSW-Feedback = SSW-Ack
TX_POLL = ctrl_tx(22)
TX_GRANT = ctrl_tx(27)      # Grant = SPR = Grant Ack
TX_ACK_CM = ctrl_tx(14)
TX_ACK_SC = T.txtime_sc(14, 1)


def test_frame_txtimes_match_timing():
    for kind, n in [('dmg_cts', 20), ('rts', 20), ('cf_end', 20), ('dmg_dts', 26), ('ssw', 26), ('ssw_fb', 28),
                    ('ssw_ack', 28), ('poll', 22), ('grant', 27), ('spr', 27), ('grant_ack', 27), ('ack', 14)]:
        assert D.LEN[kind] == n
        assert D.tx(kind) == ctrl_tx(n)


# ---- 9.2.5.1 / табл. 9-9 ----
@pytest.mark.parametrize('t,v', [(0, 0), (Fr(1, 1000), 1), (3, 3), (Fr(31, 10), 4), (-5, 0), (Fr(-1, 2), 0),
                                 (32767, 32767), (Fr(32766001, 1000), 32767)])
def test_field_rounding(t, v):
    assert D.field(t) == v


def test_field_overflow():
    with pytest.raises(D.DurationOverflow):
        D.field(Fr(327671, 10))
    assert D.field(40000, overflow='clamp') == 32767


@pytest.mark.parametrize('value,res', [
    (0, ('duration', 0)), (0x7FFF, ('duration', 32767)), (0x8000, ('reserved', 0x8000)),
    (0xBFFF, ('reserved', 0xBFFF)), (0xC000, ('reserved', 0xC000)), (0xC001, ('aid', 1)),
    (0xC000 | 2007, ('aid', 2007)), (0xC000 | 2008, ('reserved', 0xC000 | 2008)), (0xFFFF, ('reserved', 0xFFFF))])
def test_decode_table_9_9(value, res):
    assert D.decode(value) == res


def test_check_encoding_violations():
    assert D.check_duration('ack', 32767) is None
    assert 'бит 15' in D.check_duration('ack', 32768)
    assert 'бит 15' in D.check_duration('rts', 0xC001)
    assert D.check_duration('ack', 70000) is not None
    assert D.check_duration('ack', 1.5) is not None
    assert D.check_duration('ps_poll', 0xC005) is None
    assert D.check_duration('ps_poll', 5) is not None


# ---- 10.6.7.2: MCS ответа ----
def test_response_mcs_control_eliciting():
    assert D.response_mcs_set('ack', 0) == {0}
    assert D.response_mcs_set('ba', 0) == {0}


@pytest.mark.parametrize('elicit,exp', [(1, {1}), (2, {1, 2}), (3, {1, 2, 3}), (4, {1, 2, 3, 4}),
                                        (8, {1, 2, 3, 4}), (12, {1, 2, 3, 4})])
def test_response_mcs_ack_sc(elicit, exp):
    # Ack 14 октетов: 1 кодовое слово, 2 блока при любом MCS 1..4 → TXTIME равны, допустимы все с rate ≤ вызвавшего
    assert D.response_mcs_set('ack', elicit) == exp


def test_response_mcs_ba_shortest():
    # BA 32 октета: MCS 1 (ρ=2) — 2 CW / 3 блока, MCS 2..4 — 1 CW / 2 блока → MCS 1 исключён условием (b)
    assert T.txtime_sc(32, 1) > T.txtime_sc(32, 2) == T.txtime_sc(32, 4)
    assert D.response_mcs_set('ba', 12) == {2, 3, 4}
    assert D.response_mcs_set('ba', 2) == {2}
    assert D.response_mcs_set('ba', 1) == {1}            # rate ≤ 385 Мб/с: только MCS 1


def test_response_mcs_other():
    assert D.response_mcs_set('dmg_cts', 8) == {0}
    assert D.response_mcs_set('ssw_ack', 0) == {0}
    assert D.response_mcs_set('grant_ack', 0) == {0, 1, 2, 3, 4}
    with pytest.raises(NotImplementedError):
        D.response_mcs_set('ack', 26)                   # low-power SC
    assert D.response_txtime('ack', 0) == TX_ACK_CM
    assert D.response_txtime('ack', 9) == TX_ACK_SC


# ---- 9.3.1.13 / 9.2.5.2 a) 1): RTS / DMG CTS ----
def test_cts_response_value():
    assert D.duration_cts_response(100) == ceil(100 - 3 - TX_CTS) == 83
    assert D.duration_cts_response(10) == 0              # отрицательное → 0


def test_rts_single_protection():
    tdata = T.txtime_sc(1534, 8)
    exp = ceil(3 + TX_CTS + 3 + tdata + 3 + TX_ACK_SC)
    assert D.duration_rts(tdata, D.response_txtime('ack', 8)) == exp
    assert D.duration_rts(tdata) == ceil(3 + TX_CTS + 3 + tdata)


def test_rts_cts_data_ack_nav_chain():
    """NAV‑конец каждого ответа не раньше конца у вызвавшего и позже не более чем на 1 мкс (округление вверх)."""
    tdata = T.txtime_sc(7000, 12)
    tack = D.response_txtime('ack', 12)
    d_rts = D.duration_rts(tdata, tack)
    end_rts = Fr(0)
    nav = end_rts + d_rts
    end_cts = end_rts + 3 + TX_CTS
    d_cts = D.duration_cts_response(d_rts)
    assert nav <= end_cts + d_cts < nav + 1
    end_data = end_cts + 3 + tdata
    d_data = D.duration_data_single(tack)
    end_ack = end_data + 3 + tack
    assert end_data + d_data >= end_ack
    assert nav >= end_ack                               # RTS защищает весь обмен


def test_check_cts():
    assert D.check_duration('dmg_cts', 83, {'rts_duration': 100}) is None
    assert D.check_duration('dmg_cts', 97, {'rts_duration': 100}) is not None   # не вычли TXTIME(CTS)
    assert D.check_duration('dmg_cts', 100, {'rts_duration': 100}) is not None
    # допуск SIFS (10.3.2.3.3): 100 − 3,49 − 14,036 = 82,47 → 83 — то же значение
    assert D.check_duration('dmg_cts', 83, {'rts_duration': 100, 'gap': 3 + D.SIFS_TOL}) is None


def test_rts_in_sp_cap():
    """10.39.6.6.2: Duration RTS не больше остатка SP после RTS."""
    assert D.check_duration('rts', 500, {'alloc_remaining_seq': 400}) is not None
    assert D.check_duration('rts', 400, {'alloc_remaining_seq': 400}) is None


# ---- 9.2.5.7: Ack / BlockAck ----
def test_ack_after_final_data_is_one_not_zero():
    """Duration данных = ⌈SIFS + TXTIME(Ack)⌉ = 7; Ack = ⌈7 − 3 − 3,0909⌉ = 1 (дробь не обнуляется)."""
    d_data = D.duration_data_single(TX_ACK_SC)
    assert d_data == ceil(3 + TX_ACK_SC) == 7
    assert D.duration_ack(d_data, TX_ACK_SC) == 1
    assert D.check_duration('ack', 1, {'elicit_duration': 7, 'elicit_mcs': 8}) is None
    assert D.check_duration('ack', 0, {'elicit_duration': 7, 'elicit_mcs': 8}) is not None
    assert D.check_duration('ack', 7, {'elicit_duration': 7, 'elicit_mcs': 8}) is not None


def test_ack_control_mode():
    d_data = D.duration_data_single(D.response_txtime('ack', 0))
    assert d_data == ceil(3 + TX_ACK_CM) == 17
    assert D.check_duration('ack', 1, {'elicit_duration': 17, 'elicit_mcs': 0}) is None
    # Ack на control‑кадр в SC — не по 10.6.7.2 → значение 17 − 3 − 3,09 = 10,9 → 11 недопустимо
    assert D.check_duration('ack', 11, {'elicit_duration': 17, 'elicit_mcs': 0}) is not None


def test_ack_zero_elicit():
    assert D.duration_ack(0, TX_ACK_SC) == 0


def test_ba_response_and_unsolicited():
    tba = D.response_txtime('ba', 12)
    assert D.duration_ba_response(1000, tba) == ceil(1000 - 3 - tba)
    assert D.duration_ba_unsolicited(TX_ACK_SC) == 7
    assert D.check_duration('ba', 7, {'unsolicited': True, 'ack_txtime': TX_ACK_SC}) is None


def test_bar():
    tba = T.txtime_sc(32, 4)
    assert D.duration_bar(tba) == ceil(3 + tba) == 7
    assert D.check_duration('bar', 7, {'resp_txtime': tba}) is None
    assert D.check_duration('bar', 0, {'resp_txtime': tba}) is not None


# ---- 9.2.5.2 a) 5) / 6) ----
def test_data_single_nonfinal():
    tack, tnext = TX_ACK_SC, T.txtime_sc(1534, 12)
    assert D.duration_data_single(tack, final=False, next_txtime=tnext, next_resp_txtime=tack) == \
        ceil(3 + tack + 3 + tnext + 3 + tack)
    # No Ack / групповой: последний — 0, иначе — следующий кадр и его ответ
    assert D.duration_data_single(None) == 0
    assert D.duration_data_single(None, final=False, next_txtime=tnext) == ceil(3 + tnext)
    with pytest.raises(ValueError):
        D.duration_data_single(tack, final=False)


def test_check_data_group_final():
    assert D.check_duration('data', 0, {'resp_txtime': None, 'final': True}) is None
    assert D.check_duration('data', 5, {'resp_txtime': None, 'final': True}) is not None


# ---- 9.2.5.2 b): множественная защита ----
def test_multi_protection_cases():
    tp = Fr(1005, 10)
    assert D.duration_multi_range(tp, 0, t_single_msdu=Fr(2000)) == (ceil(2000 - tp),) * 2
    assert D.duration_multi_range(tp, 0, t_end_nav=500) == (400, 400)
    assert D.duration_multi_range(tp, 0, t_end_nav=50) == (0, 0)
    lo, hi = D.duration_multi_range(tp, 2000, t_pending=300)
    assert (lo, hi) == (300, 1900)                      # min(300, 1899,5) ≤ D ≤ 1899,5; поле — ⌈D⌉
    lo, hi = D.duration_multi_range(tp, 2000, t_pending=5000)
    assert lo == hi == 1900
    lo, hi = D.duration_multi_range(tp, 2000, t_end_nav=800, t_txop_remaining=1200)
    assert (lo, hi) == (700, 1100)
    assert D.check_duration('data', 1101, {'multi': dict(t_ppdu=tp, t_txop=2000, t_end_nav=800,
                                                         t_txop_remaining=1200)}) is not None
    assert D.check_duration('data', 900, {'multi': dict(t_ppdu=tp, t_txop=2000, t_end_nav=800,
                                                        t_txop_remaining=1200)}) is None


# ---- DMG CTS-to-self / DTS ----
def test_cts_to_self():
    assert D.duration_cts_to_self(Fr(24691, 2)) == 12346
    assert D.check_duration('dmg_cts_to_self', 12346, {'remaining': Fr(24691, 2)}) is None
    with pytest.raises(D.DurationOverflow):
        D.duration_cts_to_self(40000)                   # остаток SP > 32 767 — не кодируется


def test_dts_variants():
    nav, sp = 1000, 5000
    a = D.duration_dts(nav, sp)
    b = D.duration_dts(nav, sp, variant='10.39.6.6.2')
    assert a == ceil(1000 - TX_DTS - 3) == 983
    assert b == ceil(1000 - TX_DTS) == 986
    assert D.duration_dts(nav, 100) == 100              # «whichever is smaller»
    ctx = {'nav_at_start': nav, 'sp_remaining_at_end': sp}
    assert D.check_duration('dmg_dts', 983, ctx) is None
    assert D.check_duration('dmg_dts', 986, ctx) is None
    assert D.check_duration('dmg_dts', 986, dict(ctx, variant='9.3.1.14')) is not None
    assert D.check_duration('dmg_dts', 1000, ctx) is not None


def test_dts_listening():
    assert D.duration_dts_listening_min(40) == 110
    assert D.check_duration('dmg_dts', 109, {'listening_elapsed': 40}) is not None
    assert D.check_duration('dmg_dts', 110, {'listening_elapsed': 40}) is None


# ---- CF-End (DMG) ----
def test_cf_end():
    assert D.duration_cf_end(1) == 0
    assert D.duration_cf_end(2) == ceil(TX_CTS + 3) == 18
    assert D.duration_cf_end(3) == ceil(2 * (TX_CTS + 3)) == 35
    for bad in (0, 4):
        with pytest.raises(ValueError):
            D.duration_cf_end(bad)


def test_cf_end_nonzero_threshold():
    thr = 2 * TX_CTS + 6                                # 34,07…
    assert not D.cf_end_nonzero_allowed(34)
    assert D.cf_end_nonzero_allowed(35)
    assert D.cf_end_nonzero_allowed(thr)
    assert D.cf_end_check(18, 2, 34) is not None
    assert D.cf_end_check(18, 2, 100) is None
    assert D.cf_end_check(0, 1, 10) is None
    assert D.cf_end_check(17, 2, 100) is not None


# ---- Poll / SPR (10.39.7.2, ур. 10-18) ----
def test_pp_schedule_two_polls():
    s = D.pp_schedule([TX_POLL] * 2, [TX_GRANT] * 2)
    d12 = ceil(TX_POLL + 1 + Fr(3, 100))                # 16
    o2 = 3 + ceil(TX_GRANT + 3)                         # 3 + 19
    tspr = ceil(TX_GRANT)                               # 16
    assert (d12, o2, tspr) == (16, 22, 16)
    assert s == [(d12 + o2 + tspr, d12 + 3), (o2 + tspr, o2)] == [(54, 19), (38, 22)]
    assert D.pp_schedule([TX_POLL] * 2, [TX_GRANT] * 2, oj_spr='j-1') == s
    assert D.check_duration('poll', 54, {'i': 1, 'poll_txtimes': [TX_POLL] * 2, 'spr_txtimes': [TX_GRANT] * 2}) is None
    assert D.check_duration('poll', 53, {'i': 1, 'poll_txtimes': [TX_POLL] * 2, 'spr_txtimes': [TX_GRANT] * 2}) \
        is not None


def test_pp_antenna_switch():
    s = D.pp_schedule([TX_POLL] * 2, [TX_GRANT] * 2, ant_switch=[0, 5])
    assert s[0][1] == ceil(TX_POLL + 1 + 5 + Fr(3, 100)) + 3


def test_spr_response():
    assert D.duration_spr_response(54, 19) == ceil(54 - 19 - TX_GRANT) == 20
    assert D.duration_spr_response(38, 22) == 1         # ⌈0,945⌉
    assert D.duration_spr_response(54, 19, variant='9.3.1.11') == 17
    assert D.duration_spr_response(38, 22, variant='9.3.1.11') == 0
    ctx = {'poll_duration': 54, 'response_offset': 19}
    assert D.check_duration('spr', 20, ctx) is None
    assert D.check_duration('spr', 17, ctx) is None
    assert D.check_duration('spr', 17, dict(ctx, variant='10.39.7.2')) is not None


def test_spr_nav_endpoint_consistent():
    """SPR на Poll 1 указывает тот же конец NAV, что и Poll 1 (с точностью до округления вверх)."""
    (d1, ro1), _ = D.pp_schedule([TX_POLL] * 2, [TX_GRANT] * 2)
    end_spr = ro1 + TX_GRANT                            # от конца Poll 1
    d_spr = D.duration_spr_response(d1, ro1)
    assert d1 <= end_spr + d_spr < d1 + 1


def test_spr_unsolicited():
    assert D.duration_spr_unsolicited(Fr(9001, 10)) == 901
    assert D.duration_spr_unsolicited() == 0
    assert D.check_duration('spr', 0) is None
    assert D.check_duration('spr', 5) is not None


# ---- Grant / Grant Ack ----
def test_grant_gp_with_grant_ack():
    seq = [(3, TX_GRANT), (3, TX_GRANT), (3, TX_GRANT)]  # Grant Ack 1, Grant 2, Grant Ack 2 (SIFS)
    d1 = D.duration_grant_gp(seq)
    assert d1 == ceil(9 + 3 * TX_GRANT) == 55
    d2 = D.duration_grant_gp(seq[2:])
    assert d2 == ceil(3 + TX_GRANT) == 19
    assert D.duration_grant_ack(d2, TX_GRANT) == 1
    assert D.duration_grant_gp([]) == 0
    assert D.check_duration('grant', 55, {'mode': 'gp', 'remaining': seq}) is None


def test_grant_ack_mcs_choice():
    # Grant Ack — control или SC 1..4 (10.6.7.2): допустимы оба значения
    d = 100
    ok_cm = ceil(d - 3 - TX_GRANT)
    ok_sc = ceil(d - 3 - T.txtime_sc(27, 2))
    assert D.check_duration('grant_ack', ok_cm, {'grant_duration': d}) is None
    assert D.check_duration('grant_ack', ok_sc, {'grant_duration': d}) is None
    assert D.check_duration('grant_ack', d, {'grant_duration': d}) is not None


def test_grant_modes():
    assert D.duration_grant_cbap(500) == ceil(500 - TX_GRANT - 3)
    assert D.duration_grant_relinquish(Fr(8000)) == ceil(8000 - TX_GRANT - 3)
    assert D.duration_grant_ext_reply(300) == ceil(300 - 3 - TX_GRANT)
    assert D.duration_grant_ext_forward(282) == ceil(282 - TX_GRANT - 3)
    assert D.duration_grant_group(Fr(51, 2)) == 26
    assert D.duration_grant_truncation([(3, TX_GRANT), (3, TX_CTS), (3, TX_CTS)]) == ceil(9 + TX_GRANT + 2 * TX_CTS)
    lim = 2000
    assert D.check_duration('grant', 1985, {'mode': 'txop', 'txop_limit': lim}) is None
    assert D.check_duration('grant', 1986, {'mode': 'txop', 'txop_limit': lim}) is not None
    assert D.check_duration('grant', 30000, {'mode': 'txop', 'txop_limit': 0}) is None
    assert D.check_duration('grant', 1, {'mode': 'ap_extend', 'sp_remaining': Fr(1, 2)}) is None


# ---- SSW / SSW-Feedback / SSW-Ack ----
def test_ssw_cdown():
    assert D.duration_ssw(0) == 9                       # конец этого же кадра + MBIFS
    assert D.duration_ssw(3) == ceil(3 * (1 + TX_SSW) + 9) == 57
    assert D.duration_ssw(3, alloc_remaining=20) == 20
    assert D.duration_ssw(3, abft_slot_remaining=Fr(1501, 10)) == 151
    assert D.check_duration('ssw', 57, {'cdown': 3}) is None
    assert D.check_duration('ssw', 56, {'cdown': 3}) is not None


def test_ssw_lbifs_counted_in_cdown():
    """10.42.2.2.2: CDOWN включает LBIFS. Свип 4 + LBIFS + 3 SSW: CDOWN первого = 4+1+3−1 = 7; реальный конец
    последнего SSW совпадает с формулой cdown·(SBIFS + TXTIME(SSW))."""
    t, sb = TX_SSW, T.SBIFS
    gaps = [sb, sb, sb, T.lbifs(), sb, sb]              # 7 кадров, LBIFS между 4‑м и 5‑м
    real = sum(g + t for g in gaps)
    assert real == 7 * (sb + t)
    assert D.duration_ssw(7) == ceil(real + T.MBIFS)


def test_ssw_feedback_and_ack():
    assert D.duration_ssw_fb(True) == 0
    assert D.duration_ssw_fb(False, brp_requested=True) == ceil(TX_FB + 18) == 37
    assert D.duration_ssw_fb(False) == ceil(TX_FB + 9) == 28
    assert D.duration_ssw_fb(False, alloc_remaining=10) == 10
    assert D.duration_ssw_ack(37) == ceil(37 - 9 - TX_FB) == 10    # ≈ MBIFS до BRP
    assert D.duration_ssw_ack(28) == 1                               # ⌈0,745⌉
    assert D.duration_ssw_ack(0) == 0
    assert D.check_duration('ssw_fb', 0, {'in_abft': True}) is None
    assert D.check_duration('ssw_fb', 28, {'in_abft': True}) is not None


# ---- DMG Beacon / ATI ----
def test_dmg_beacon():
    tb = T.txtime_control(100)
    ds = D.bti_beacon_durations([tb] * 3)
    assert ds == [ceil(2 * (1 + tb)), ceil(1 + tb), 0]
    assert D.duration_dmg_beacon(Fr(3, 2)) == 2
    assert D.check_duration('dmg_beacon', 0, {'bti_remaining': 0}) is None
    assert D.check_duration('dmg_beacon', 5, {'bti_remaining': 0}) is not None


def test_ati():
    assert D.duration_ati_request(Fr(4999, 10)) == 500
    tr = T.txtime_sc(60, 1)
    assert D.duration_ati_response(500, tr) == ceil(497 - tr)
    assert D.check_duration('ati_response', ceil(497 - tr), {'request_duration': 500, 'resp_txtime': tr}) is None


# ---- прочее ----
def test_other_response_9258():
    tr = T.txtime_sc(200, 4)
    assert D.check_duration('response', ceil(300 - 3 - tr), {'elicit_duration': 300, 'txtime': tr}) is None


def test_alloc_end_violation():
    assert D.check_duration('data', 50, {'alloc_remaining_seq': 40}) is not None


def test_ampdu_same_duration():
    assert D.check_ampdu_same_duration([100, 100, 100]) is None
    assert D.check_ampdu_same_duration([100, 99]) is not None


def test_unknown_kind():
    with pytest.raises(ValueError):
        D.check_duration('foo', 0, {'x': 1})
