# SPDX-License-Identifier: AGPL-3.0-or-later
"""Этап 4, п. 1: BRP с TRN (10.42.6.4), сопровождение луча (10.42.7), поддержание направленной связи (11.27.1) и
политика деградации в ядре — юниты, точка + станция в идеальной среде (судьи — 0 нарушений), негативные варианты."""
from fractions import Fraction as Fr

import pytest

from .. import beamtrack as BT
from .. import brp as BRP
from .. import fields as F
from . import sap_phy as P
from .bf import awv_units, cmf_snr_db, cmf_snr_raw, encode_cmf, parse_cmf_snrs
from .conftest import fmt, judge_all
from .medium_ideal import IdealMedium
from .scenario import Bss
from .sim import Sim

BLM_10MS = F.Blm(unit_index=1, value=5)         # 9.5.6: 5 × 2000 мкс


def _ev(mac, *names):
    return [(t, w, kw) for t, w, kw in mac.events if w in names]


def _violations(b, RB, allow=()):
    """Все нарушения обоих судей, кроме перечисленных (rule, verdict) — с объяснением в тесте."""
    c, rules, va, evs, found = judge_all(b, RB)
    va = [v for v in va if (v.rule, v.verdict) not in allow]
    return c, rules, va, evs, found


# ===================================================================================================== юниты
def test_trn_appended_and_txtime():
    """20.9.2.2: TRN добавлены, кроме запроса сопровождения с PPDU_TYPE TRN-R (10.42.7: TRN_LEN — запрошенные)."""
    v = P.TxVector(MCS=0, LENGTH=42, TRN_LEN=2, PPDU_TYPE=P.TRN_R)
    assert P.trn_appended(v) and P.ppdu_time(v) == BRP.brp_txtime(42, 0, 2)
    rq = P.TxVector(MCS=8, LENGTH=1000, TRN_LEN=2, PPDU_TYPE=P.TRN_R, BEAM_TRACKING_REQUEST=P.BT_REQUESTED)
    assert not P.trn_appended(rq) and P.ppdu_time(rq) == BRP.brp_txtime(1000, 8, 0)
    tt = P.TxVector(MCS=8, LENGTH=1000, TRN_LEN=2, PPDU_TYPE=P.TRN_T, BEAM_TRACKING_REQUEST=P.BT_REQUESTED)
    assert P.trn_appended(tt)


def test_medium_awv_and_trn_snr():
    """Модель: лучшее положение пары дробное — сектор SLS неточен, AWV уточняет; TRN_SNR по подполям."""
    sim = Sim()
    m = IdealMedium(sim)

    class U:
        def __getattr__(self, n):
            return lambda *a, **k: None
    m.attach('A', 'a', list(range(8)), U())
    m.attach('B', 'b', list(range(8)), U())
    m.link('A', 'B', -40, Fr(5, 2), 1, step_db=4)
    lv = [m.level('A', P.Beam(2).refined(w), 'B', P.Beam(1)) for w in (-2, -1, 0, 1, 2)]
    assert lv.index(max(lv)) == 4 and max(lv) == -40          # 2 + 2/4 = 2,5
    assert m.level('A', P.Beam(2), 'B', P.Beam(1)) == -42     # без AWV — штраф полсектора × 4 дБ


def test_cmf_codec():
    """9.4.2.136: SNR — беззнаковое, опора −8 дБ, шаг 0,25; насыщение 0 / 0xFF."""
    assert cmf_snr_raw(-8) == 0 and cmf_snr_raw(-20) == 0 and cmf_snr_raw(55.75) == 255 and cmf_snr_raw(70) == 255
    assert cmf_snr_db(cmf_snr_raw(30)) == 30
    e = encode_cmf([30, 28.5], [(3, 1)])
    assert e[0] == 154 and e[1] == 3 and parse_cmf_snrs(e, 2) == [30, Fr(57, 2)] and e[4] == 3 | (1 << 6)
    assert awv_units(range(5)) == 2 and awv_units(range(4)) == 1


def test_bs_fbck_beam_tracking_exception():
    """brp.check_brp_log: BS-FBCK ≠ 0 после PPDU пира с запросом TRN-T сопровождения (10.42.7) — не нарушение
    9.4.2.129; без запроса — нарушение (PLAN.md №111)."""
    fb = BRP.BrpFrame(bre=BRP.BeamRefinement(initiator=1, tx_train_resp=1, tx_trn_ok=1, bs_fbck=3))
    rsp = BRP.BrpFrame()
    data = BRP.Ppdu(0, 'I', 'R', 'Data', None, 8, length=4000, trn_len=1, ppdu_type=BRP.TRN_T, bt=True)
    cfe = BRP.Ppdu(20, 'I', 'R', 'CF-End', None, 0, length=20)
    for evs, bad in (([data, cfe], False),
                     ([BRP.Ppdu(0, 'I', 'R', 'Data', None, 8, length=4000), cfe], True)):
        e1 = BRP.Ppdu(200, 'R', 'I', 'BRP', fb, 0)
        e2 = BRP.Ppdu(e1.end + 3, 'I', 'R', 'BRP', rsp, 0)
        vv = [v for v in BRP.check_brp_log(evs + [e1, e2]) if 'BS-FBCK' in v.msg]
        assert bool(vv) == bad, vv


# ===================================================================================================== SLS + BRP
@pytest.fixture(scope='module')
def brp_run(RB):
    b = Bss(seed=2, bf='dti', ul_bytes=200_000, dl_bytes=200_000)
    b.sta_sme.request_brp = True                # MLME-BF-TRAINING.request(RequestBRP = true)
    b.ap.bf.brp_on_sls = True                   # ответчик SLS просит BRP в SSW-Ack (10.42.2.5)
    b.medium.link('AP', 'STA', -40, Fr(5, 4), Fr(9, 4))     # SLS находит секторы 1/2, лучшее — +¼ сектора
    assert b.run(max_bis=20)
    return b, _violations(b, RB)


def test_brp_after_sls_executes(brp_run):
    b, _ = brp_run
    brps = [r for r in b.journal.recs if r.kind == 'BRP']
    # 10.42.6.4.3: L-RX в SSW-Ack → первый BRP инициатора — BRP-RX с L-RX единицами TRN-R; потом TRN-T обеих сторон
    ack = next(r for r in b.journal.recs if r.kind == 'SSW-Ack')
    l_rx = F.parse_frame(ack.mpdus[0], with_fcs=False).brp.l_rx
    assert l_rx == awv_units(b.ap.bf.rx_awvs) and brps[0].node == 'STA'
    assert brps[0].txv.PPDU_TYPE == P.TRN_R and brps[0].txv.TRN_LEN == l_rx
    assert {(r.node, r.txv.PPDU_TYPE) for r in brps} >= {('STA', P.TRN_T), ('AP', P.TRN_T), ('AP', P.TRN_R)}
    # промежутки: первый BRP — MBIFS после SSW-Ack (9.3.1.16 a)), дальше SIFS (10.42.3.1)
    assert brps[0].t - ack.te == Fr(9) + Fr(1, 100)
    assert all(b2.t - b1.te == Fr(3) + Fr(1, 100) for b1, b2 in zip(brps, brps[1:]))
    # итог: AWV +1 (¼ сектора) — передача и приём обеих сторон
    for mac, peer in ((b.sta, b.ap.addr), (b.ap, b.sta.addr)):
        p = mac.peers[peer]
        assert p.tx_beam.awv == 1 and p.rx_beam.awv == 1, (mac.name, p.tx_beam, p.rx_beam)
    assert _ev(b.sta, 'brp_txn_done') and _ev(b.ap, 'bf_complete')


def test_brp_judges_zero(brp_run, RB):
    b, (c, rules, va, evs, found) = brp_run
    assert not va and not found, fmt(c, va, evs, found, RB)
    st = {r.rid: r for r in rules}
    assert st['brp'].checked > 0 and st['brp'].info['trn_known'] and st['brp_role'].checked > 0


# ===================================================================================================== сопровождение
@pytest.fixture(scope='module')
def bt_run(RB):
    # данные очередью целиком (насыщение): судья access считает отсрочку только при занятой очереди
    b = Bss(seed=2, bf='dti', ul_bytes=6_000_000, dl_bytes=6_000_000)
    b.bf(bt_time_limit=10000, blm=BLM_10MS, degrade_db=2, resls_db=8)
    b.medium.link('AP', 'STA', -40, 1, 2, step_db=6)                 # 6 дБ на сектор: уход на ½ — 3 дБ
    L = b.medium.links[('AP', 'STA')]
    b.medium.move('AP', 'STA', 209_000, best_a=Fr(L[1]) + Fr(1, 2), best_b=Fr(L[2]) + Fr(1, 2))
    b.run_bis(3)
    # BRP по политике MAC (не MLME-BF-TRAINING) после ассоциации судья bf_training по эфиру отличить не может —
    # вердикт model (README ядра, «Этап 4»)
    return b, _violations(b, RB, allow={('bf_training', 'model')})


def test_beam_tracking_refines_tx(bt_run):
    b, _ = bt_run
    req = [r for r in b.journal.recs if r.txv.BEAM_TRACKING_REQUEST == P.BT_REQUESTED]
    assert req and all(r.txv.PPDU_TYPE == P.TRN_T and r.kind == 'A-MPDU' and r.txv.MCS > 0 for r in req)
    for mac in (b.ap, b.sta):
        assert _ev(mac, 'degrade') and _ev(mac, 'bt_feedback_ok'), mac.name
        assert mac.peers[(b.sta if mac is b.ap else b.ap).addr].tx_beam.awv == 2     # +½ сектора
    # обратная связь — BRP с Initiator = 1 через EDCA, BS-FBCK, FBCK-TYPE 0 (10.42.7)
    fb = [e for e in b.ap.events + b.sta.events if e[1] == 'bt_feedback']
    assert fb and all(kw['initiator'] == 1 for _, _, kw in fb)


def test_beam_tracking_judges_zero(bt_run, RB):
    b, (c, rules, va, evs, found) = bt_run
    assert not va and not found, fmt(c, va, evs, found, RB)
    st = {r.rid: r for r in rules}
    assert st['beam_track'].info['bt_requests'] >= 2 and st['brp_role'].info['counts'].get('bt_feedback')


def test_bt_initiator_rules():
    """10.42.7: запрос TRN-T к STA с пределом 0 — нельзя; повтор без обратной связи — после предела + BRPIFS."""
    ini = BT.Initiator(0)
    assert not ini.may_request_tx(0)
    ini = BT.Initiator(10000)
    assert ini.may_request_tx(0)
    ini.sent_tx_request(100)
    assert not ini.may_request_tx(5000) and ini.may_request_tx(100 + 10000 + 45)


# ===================================================================================================== повторное BF
@pytest.mark.parametrize('dti', [False, True], ids=['abft', 'dti'])
def test_large_degradation_rebf(dti, RB):
    """Уход луча на 2 сектора: уточнения мало — повторное BF; станция — RSS в A-BFT («should», 11.27.1) или SLS."""
    b = Bss(seed=2, bf='dti', ul_bytes=6_000_000, dl_bytes=6_000_000)
    b.bf(bt_time_limit=10000, degrade_db=2, resls_db=8)
    b.sta.rebf_dti = dti
    b.medium.link('AP', 'STA', -40, 1, 2, step_db=6)
    L = b.medium.links[('AP', 'STA')]
    b.medium.move('AP', 'STA', 209_000, best_a=Fr(L[1]) + 2, best_b=Fr(L[2]) + 2)
    b.run_bis(4)
    assert _ev(b.sta, 'degrade') and any(kw.get('action') == 'rebf' for _, _, kw in _ev(b.sta, 'degrade'))
    if dti:
        assert any(kw['ok'] for _, _, kw in _ev(b.sta, 'rebf_done'))
    else:
        assert _ev(b.sta, 'rebf_abft') and _ev(b.sta, 'bf_abft')[-1][0] > 209_000
    # после повторного BF — опять верные секторы (1 + 2, 2 + 2 по модулю числа секторов)
    assert b.sta.peers[b.ap.addr].tx_beam.sector == (L[2] + 2) % 4
    assert b.ap.peers[b.sta.addr].tx_beam.sector == (L[1] + 2) % 8
    c, rules, va, evs, found = _violations(b, RB, allow={('bf_training', 'model')})
    assert not va and not found, fmt(c, va, evs, found, RB)


# ===================================================================================================== BLM
@pytest.mark.parametrize('dti', [False, True], ids=['abft', 'dti'])
def test_blm_keepalive_expiry_restore(dti, RB):
    """11.27.1: таймер 10 мс; без данных — QoS Null (Ack ставит таймер); затенение 22 мс — истечение после
    неподтверждённых QoS Null; инициатор связи (станция) восстанавливает: RSS в A-BFT или ISS в DTI."""
    b = Bss(seed=3, bf='dti', ul_bytes=300_000, dl_bytes=300_000).bf(blm=BLM_10MS)
    b.sta.rebf_dti = dti
    b.medium.block('AP', 'STA', 240_000, 262_000)
    b.run_bis(4)
    assert b.done()
    ka = _ev(b.sta, 'keepalive')
    assert len(ka) >= 3 and not _ev(b.ap, 'keepalive') or len(_ev(b.ap, 'keepalive')) < len(ka)
    nulls = [r for r in b.journal.recs if r.kind == 'QoS Null']
    assert nulls and all(r.txv.MCS == 1 for r in nulls)
    assert _ev(b.sta, 'blm_expired') and _ev(b.sta, 'blm_restore')
    if dti:
        assert any(kw['ok'] for _, _, kw in _ev(b.sta, 'rebf_done'))
    else:
        assert _ev(b.sta, 'bf_abft')
    c, rules, va, evs, found = _violations(b, RB)
    assert not va and not found, fmt(c, va, evs, found, RB)
    st = {r.rid: r for r in rules}
    assert st['blm'].checked > 0 and 'истечение после неподтверждённых передач' in st['blm'].info[
        'blm(fb_us, ack_us, negotiated)']


# ===================================================================================================== негативные
def test_neg_no_keepalive_caught(RB, monkeypatch):
    """Без QoS Null таймер истекает без передач — судья blm (11.27.1 «shall transmit QoS Null»)."""
    b = Bss(seed=3, bf='dti', ul_bytes=100_000, dl_bytes=100_000).bf(blm=BLM_10MS)
    for m in (b.ap, b.sta):
        monkeypatch.setattr(m, '_send_qos_null', lambda peer: None)
        m.bf.blm_restore = False
    # MSDU через 70 мс тишины — первый кадр пары после истечения без передач
    b.sim.at(280_000, lambda: b.sta_sme._send(b.ap.addr, [bytes(100)]))
    b.run_bis(3)
    c, rules, va, evs, found = judge_all(b, RB)
    assert any(v.rule == 'blm' and 'без передач' in v.msg for v in va), fmt(c, va, evs, found, RB)


def test_neg_brp_wrong_trn_caught(RB, monkeypatch):
    """Ответ на L-RX без TRN-R нужной длины — судья brp (10.42.6.4.1) ловит по полям TRN журнала."""
    b = Bss(seed=2, bf='dti', ul_bytes=50_000)
    b.sta_sme.request_brp = True
    b.ap.bf.brp_on_sls = True
    orig = b.ap._respond

    def bad(m, mcs, beam, kind=None, trn=0, ptype=None, trn_awvs=()):
        return orig(m, mcs, beam, kind, trn=1 if ptype == P.TRN_R and trn else trn, ptype=ptype, trn_awvs=trn_awvs)
    monkeypatch.setattr(b.ap, '_respond', bad)
    b.run(max_bis=20)
    c, rules, va, evs, found = judge_all(b, RB)
    assert any(v.rule == 'brp' and 'rx-trn' in v.msg for v in va), fmt(c, va, evs, found, RB)
