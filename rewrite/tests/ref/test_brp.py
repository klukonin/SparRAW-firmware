# SPDX-License-Identifier: AGPL-3.0-or-later
"""Эталон BRP: ожидания — из текста 802.11-2020 (9.5.4 рис. 9-850, 9.4.2.129 рис. 9-558..9-560, 9.4.2.136
табл. 9-263, 9.6.21.3 табл. 9-488, 10.3.2.3.9, 10.42.3, 10.42.6.3, 10.42.6.4, рис. 10-72/10-80/10-83/10-85..10-87,
20.9.2.2, табл. 20-22, табл. 20-30, 20.11.3)."""
from fractions import Fraction as Fr

import pytest

from . import brp as B
from . import timing as T

TC = Fr(1, 1760)                                            # табл. 20-4: Fc = 1760 МГц


def rules(log, **kw):
    return sorted({v.rule for v in B.check_brp_log(log, B.BrpParams(**kw))})


def brp(t, src, dst, n=0, ptype=None, mcs=1, **kw):
    req = B.BrpRequest(**{k: kw.pop(k) for k in list(kw) if k in B.BrpRequest.__slots__})
    bre = B.BeamRefinement(**{k: kw.pop(k) for k in list(kw) if k in B.BeamRefinement.__slots__})
    return B.Ppdu(t, src, dst, 'BRP', B.BrpFrame(req, bre), mcs, trn_len=n, ppdu_type=ptype, **kw)


def after(p, gap=T.SIFS):
    return p.end + gap


# ---------------- постоянные и длительности ----------------
def test_brpifs_bounds():
    """10.3.2.3.9: максимум aBRPIFS + 10 % = 44 мкс (табл. 20-30: aBRPIFS 40 мкс), минимум — SIFS = 3 мкс;
    10.42.3.1 b): тайм-аут транзакции BRPIFS + aSlotTime = 44 + 5."""
    assert B.BRPIFS == 44 and B.BRPIFS_MIN == 3 and B.BRP_TXN_TIMEOUT == 49


def test_trn_unit_composition():
    """20.9.2.2.5/20.9.2.2.6: на единицу TRN — 4 AGC-подполя по 5×64 чипа, CE (20.3.6.3, 9×128) и 4 TRN-подполя
    по 5×128 = aBRPTRNBlock 4992 (табл. 20-30); T_TRN-Unit = aBRPTRNBlock·T_C (20.11.3)."""
    assert 4 * 5 * 64 + 9 * 128 + 4 * 5 * 128 == 4992
    assert B.T_TRN_UNIT == 4992 * TC


def test_brp_min_data_matches_ncwmin_table():
    """20.9.2.2.4 / табл. 20-22: N_CWmin даёт ровно aBRPminSCblocks = 18 SC-блоков (N_BLKS = ⌈N_CW·L_CW/N_CBPB⌉,
    L_CW = 672, N_CBPB по табл. 20-19); (α·β + γ)·T_C = (18·512 + 64)·T_C (20.11.3)."""
    ncwmin = {1: 12, 2: 12, 3: 12, 4: 12, 5: 12, 6: 23, 7: 23, 8: 23, 9: 23, 10: 46, 11: 46, 12: 46}
    ncbpb = {1: 448, 2: 896, 4: 1792}
    ncbps = {m: (1 if m <= 5 else 2 if m <= 9 else 4) for m in range(1, 13)}
    for m, n in ncwmin.items():
        assert -(-n * 672 // ncbpb[ncbps[m]]) == 18
    assert B.NCW_MIN == ncwmin
    assert B.T_BRP_DATA_MIN_SC == (18 * 512 + 64) * TC


def test_brp_txtime_sc_short_frame_padded():
    """20.11.3 SC, N_TRN > 0: Length 42, MCS 1: N_CW = ⌈336/168⌉ = 2, N_BLKS = 3 < 18 → Data = 18 блоков;
    T = (17·128 + 9·128 + 2·512 + 18·512 + 64 + N·4992)·T_C."""
    base = 17 * 128 + 9 * 128 + 2 * 512 + 18 * 512 + 64
    assert B.brp_txtime(42, 1, 4) == (base + 4 * 4992) * TC
    assert B.brp_txtime(42, 1, 4) == Fr(210, 11)
    assert B.brp_txtime(42, 1, 0) == T.txtime_sc(42, 1)        # N_TRN = 0 — обычный TXTIME
    assert B.brp_txtime(42, 1, 0) < B.brp_txtime(42, 1, 1) - B.T_TRN_UNIT


def test_brp_txtime_sc_long_frame_not_padded():
    """20.11.3: max{T_Data, …}: Length 2000, MCS 1 → N_BLKS = ⌈96·672/448⌉ = 144 > 18 — без дополнения."""
    assert B.brp_txtime(2000, 1, 2) == T.txtime_sc(2000, 1) + 2 * 4992 * TC
    assert T.txtime_sc(2000, 1) == (17 * 128 + 9 * 128 + 1024 + 144 * 512 + 64) * TC


def test_brp_txtime_control():
    """20.11.3 control mode: обычный TXTIME + N_TRN·T_TRN-Unit (без минимума блоков)."""
    assert B.brp_txtime(42, 0, 3) == T.txtime_control(42) + 3 * 4992 * TC


# ---------------- поля ----------------
def test_brp_request_bit_positions():
    """Рис. 9-850: B0–B4 L-RX, B5 TX-TRN-REQ, B6 MID-REQ, B7 BC-REQ, B8 MID-Grant, B9 BC-Grant, B10 Chan-FBCK-CAP,
    B11–B16 TX Sector ID, B17–B24 Other_AID, B25–B26 TX DMG Antenna ID; 4 октета."""
    cases = [(dict(l_rx=16), 16), (dict(tx_trn_req=1), 1 << 5), (dict(mid_req=1), 1 << 6), (dict(bc_req=1), 1 << 7),
             (dict(mid_grant=1), 1 << 8), (dict(bc_grant=1), 1 << 9), (dict(chan_fbck_cap=1), 1 << 10),
             (dict(tx_sector_id=63), 63 << 11), (dict(other_aid=0xAB), 0xAB << 17), (dict(tx_antenna_id=3), 3 << 25)]
    for kw, v in cases:
        r = B.BrpRequest(**kw)
        assert r.encode() == v.to_bytes(4, 'little')
        assert B.BrpRequest.parse(r.encode()) == r
    assert B.BrpRequest(tx_antenna_id=3, other_aid=255, tx_sector_id=63, l_rx=31).encode()[3] & 0xF8 == 0  # B27+ резерв


def test_brp_request_l_rx_range_and_units():
    """9.5.4: L-RX 0..16, иначе резерв; TRN-R = L-RX × 4."""
    assert B.BrpRequest(l_rx=16).validate() == []
    assert B.BrpRequest(l_rx=17).validate()
    assert B.BrpRequest(l_rx=5).trn_r_subfields() == 20


def test_beam_refinement_element_layout():
    """Рис. 9-558: Element ID 153 (табл. 9-92), Length 5; Initiator — B16 (бит 0 тела), Capability Request — B53,
    MID Extension — B52, BS-FBCK — B21–B26, FBCK-REQ — B29–B33, FBCK-TYPE — B34–B51."""
    def body(**kw):
        b = B.BeamRefinement(**kw).encode()
        assert b[:2] == bytes([153, 5]) and len(b) == 7
        return int.from_bytes(b[2:], 'little')
    assert body(initiator=1) == 1
    assert body(tx_train_resp=1) == 1 << 1 and body(rx_train_resp=1) == 1 << 2
    assert body(tx_trn_ok=1) == 1 << 3 and body(txss_fbck_req=1) == 1 << 4
    assert body(bs_fbck=63) == 63 << 5 and body(bs_fbck_ant=3) == 3 << 11
    assert body(fbck_req=B.FbckReq(sido=1)) == 1 << (13 + 4)
    assert body(fbck_type=B.FbckType(nmeas=127)) == 127 << (18 + 5)
    assert body(fbck_type=B.FbckType(nbeams=7)) == 7 << (18 + 15)
    assert body(mid_ext=1) == 1 << 36 and body(cap_req=1) == 1 << 37
    e = B.BeamRefinement(initiator=1, bs_fbck=12, fbck_type=B.FbckType(snr=1, nmeas=12, ntaps=2), cap_req=1)
    p = B.BeamRefinement.parse(e.encode())
    assert p.encode() == e.encode() and p.fbck_type.nmeas == 12 and p.fbck_type.ntaps == 2


def test_bs_fbck_width_vs_trn_len():
    """СПОРНО: BS-FBCK 6 бит (рис. 9-558), TRN_LEN ≤ 16 (табл. 20-1) → до 64 TRN-T; индекс 64 не помещается."""
    assert B.TRN_LEN_MAX * B.SUBFIELDS_PER_UNIT == 64
    B.BeamRefinement(bs_fbck=63).encode()
    with pytest.raises(AssertionError):
        B.BeamRefinement(bs_fbck=64).encode()


def test_brp_frame_body_and_min_length():
    """Табл. 9-488 + 9.6.21.1: Category 20 (Unprotected DMG), действие 1 (BRP), Dialog Token, BRP Request 4,
    DMG Beam Refinement 7 → тело 14; + заголовок управления 24 + FCS 4 = 42."""
    f = B.BrpFrame(token=7)
    assert f.body()[:3] == bytes([20, 1, 7]) and len(f.body()) == 14
    assert f.length == 42 == B.BRP_MIN_LEN


def test_cmf_sizes():
    """Табл. 9-263/9-264: SNR — 1 октет на измерение; канал — N_taps·2 октета на измерение; Sector ID Order — 1
    октет (6 + 2 бита); нет CMF при N_meas = N_beam = 0 (9.4.2.129); >255 — несколько элементов, не последний —
    257 октетов (9.6.21.3)."""
    assert B.cmf_payload(B.FbckType()) == 0
    assert B.cmf_payload(B.FbckType(snr=1, sido=1, nmeas=7)) == 14
    assert B.BrpFrame(bre=B.BeamRefinement(fbck_type=B.FbckType(snr=1, nmeas=12))).length == 42 + 12 + 2
    big = B.FbckType(snr=1, chan=1, ntaps=3, nmeas=4)                # 4 + 4·63·2 = 508
    assert B.cmf_payload(big) == 508
    assert B.cmf_octets(508) == 257 + (508 - 255 + 2)
    assert B.cmf_payload(B.FbckType(sido=1, nbeams=3)) == 3
    assert B.NTAPS == {0: 1, 1: 5, 2: 15, 3: 63}


# ---------------- генератор: примеры рисунков ----------------
def test_fig_10_86_receive_training():
    """Рис. 10-86: запрос L-RX ≠ 0 → ответ RX-train-response = 1 с TRN-R (Training Length = L-RX, 20.9.2.2.3)."""
    log = B.run_transaction(B.Participant('I', rx_units=3), B.Participant('R'))
    assert len(log) == 2
    a, b = log
    assert a.frame.bre.initiator == 1 and a.frame.req.l_rx == 3 and a.trn_len == 0
    assert b.frame.bre.initiator == 0 and b.frame.bre.rx_train_resp == 1 and b.is_brp_rx() and b.trn_len == 3
    assert b.t - a.end == T.SIFS
    assert rules(log) == []


def test_fig_10_87_transmit_training_without_trn_t():
    """Рис. 10-87 / 10.42.6.4.1: TX-TRN-REQ без TRN-T → TX-TRN-OK = 1 (TX-train-response 0, L-RX 0) → TX-TRN-REQ с
    TRN-T → TX-train-response = 1 и BS-FBCK."""
    log = B.run_transaction(B.Participant('I', tx_units=2, trn_with_request=False, fbck_req=B.FbckReq(snr=1)),
                            B.Participant('R', best_trn=lambda n: n))
    f = [e.frame for e in log]
    assert len(log) == 4
    assert f[0].req.tx_trn_req == 1 and log[0].trn_len == 0
    assert f[1].bre.tx_trn_ok == 1 and f[1].bre.tx_train_resp == 0 and f[1].req.l_rx == 0
    assert f[2].req.tx_trn_req == 1 and log[2].is_brp_tx() and log[2].trn_len == 2
    assert f[3].bre.tx_train_resp == 1 and f[3].bre.tx_trn_ok == 1 and f[3].bre.bs_fbck == 8
    assert f[3].bre.fbck_type.snr == 1 and f[3].bre.fbck_type.nmeas == 8          # табл. 9-256: N_meas = числу TRN-T
    assert not f[3].has_requests()               # 10.42.3.1 a): инициатор завершает
    assert rules(log) == []


def test_fig_10_72_combined():
    """Рис. 10-72: (1) TX-TRN-REQ = 1, L-RX > 0, TRN-T; (2) L-RX > 0, TX-train-response = 1, RX-train-response = 1,
    TRN-R; (3) RX-train-response = 1, TRN-R, без запросов. СПОРНО: по 10.42.6.4.2 ответчик отвечает и на (3)."""
    log = B.run_transaction(B.Participant('I', rx_units=2, tx_units=1, fbck_req=B.FbckReq(snr=1)),
                            B.Participant('R', rx_units=5))
    f = [e.frame for e in log]
    assert log[0].is_brp_tx() and f[0].req.tx_trn_req and f[0].req.l_rx == 2
    assert log[1].is_brp_rx() and log[1].trn_len == 2 and f[1].req.l_rx == 5
    assert f[1].bre.tx_train_resp == 1 and f[1].bre.rx_train_resp == 1 and 1 <= f[1].bre.bs_fbck <= 4
    assert log[2].is_brp_rx() and log[2].trn_len == 5 and f[2].bre.rx_train_resp and not f[2].has_requests()
    assert len(log) == 4 and not f[3].has_requests() and f[3].bre.initiator == 0
    assert rules(log) == []
    # нестрогое прочтение: последний кадр ответчика не требуется
    assert rules(log[:3], strict_final_response=False) == []
    assert rules(log[:3]) == ['no-response']


def test_txss_sector_list_feedback():
    """10.42.6.4.1: TXSS-FBCK-REQ = 1, SNR Requested = 1, прочие FBCK-REQ = 0 → SNR Present = Sector ID Order
    Present = 1, N_meas = число принятых секторов."""
    log = B.run_transaction(B.Participant('I', txss_fbck=True),
                            B.Participant('R', sls_sectors=[(s, 40) for s in range(7)]))
    q, a = log[0].frame, log[1].frame
    assert q.bre.txss_fbck_req == 1 and q.bre.fbck_req.value() == 1
    assert a.bre.fbck_type.snr == a.bre.fbck_type.sido == 1 and a.bre.fbck_type.nmeas == 7
    assert a.length == 42 + 2 + 7 + 7
    assert rules(log) == []


@pytest.mark.parametrize('ir', [0, 1, 16])
@pytest.mark.parametrize('it', [0, 2])
@pytest.mark.parametrize('rr', [0, 4])
@pytest.mark.parametrize('rt', [0, 3])
@pytest.mark.parametrize('w', [True, False])
def test_generator_always_passes_checker(ir, it, rr, rt, w):
    if not (ir or it):
        return
    i = B.Participant('I', rx_units=ir, tx_units=it, trn_with_request=w, fbck_req=B.FbckReq(snr=1, chan=1, ntaps=1))
    r = B.Participant('R', rx_units=rr, tx_units=rt, trn_with_request=w, ntaps_cap=0, chan_cap=1)
    log = B.run_transaction(i, r, alloc_end=10_000)
    assert rules(log, alloc_end=10_000) == []
    assert not i.pending() and not r.pending()
    assert not log[-1].frame.has_requests() and log[-1].src == 'R'      # 10.42.3.1 a)


# ---------------- судья: время ----------------
def test_gap_brpifs_limits():
    """10.42.3.1: ответ ≥ SIFS и ≤ BRPIFS после запроса (от конца поля TRN, 10.3.2.3.9)."""
    def pair(gap):
        a = brp(0, 'I', 'R', initiator=1, l_rx=1)
        b = brp(a.end + gap, 'R', 'I', 1, B.TRN_R, rx_train_resp=1)
        return [a, b]
    assert rules(pair(T.SIFS)) == [] and rules(pair(44)) == []
    assert rules(pair(Fr(441, 10))) == ['no-response']
    assert rules(pair(2)) == ['gap']


def test_gap_measured_after_training_field():
    """10.3.2.3.9: «end of the last symbol of the previous PPDU, or training field if present»."""
    a = brp(0, 'I', 'R', 16, B.TRN_T, initiator=1, tx_trn_req=1)
    t_no_trn = a.t + B.brp_txtime(a.length, 1, 0) + T.SIFS
    b = brp(t_no_trn, 'R', 'I', tx_trn_ok=1, tx_train_resp=1, bs_fbck=1)
    assert 'gap' in rules([a, b])


def test_retransmit_after_brpifs_and_timeout():
    """10.42.6.4.1: инициатор без ответа может повторить через BRPIFS; 10.42.3.1 b): через BRPIFS + aSlotTime
    транзакция завершена."""
    log = B.run_transaction(B.Participant('I', rx_units=2), B.Participant('R'), lose={0})
    assert log[0].lost and log[1].src == 'I' and log[1].t - log[0].end == 44
    assert rules(log) == []
    a = brp(0, 'I', 'R', initiator=1, l_rx=2, lost=True)
    b = brp(a.end + 30, 'I', 'R', initiator=1, l_rx=2)
    c = brp(b.end + 3, 'R', 'I', 2, B.TRN_R, rx_train_resp=1)
    assert rules([a, b, c]) == ['retransmit']
    # потерян ответ: повтор инициатора не раньше BRPIFS после своего кадра
    log = B.run_transaction(B.Participant('I', rx_units=1), B.Participant('R'), lose={1})
    assert log[2].src == 'I' and log[2].t - log[0].end >= 44 and rules(log) == []


def test_unanswered_frame_violation_and_new_transaction():
    """10.42.6.4.2 «shall respond»; после тайм-аута 10.42.3.1 b) новый кадр с Initiator = 1 — новая транзакция."""
    a = brp(0, 'I', 'R', initiator=1, l_rx=2)
    b = brp(a.end + 100, 'I', 'R', initiator=1, l_rx=2)
    c = brp(b.end + 3, 'R', 'I', 2, B.TRN_R, rx_train_resp=1)
    assert rules([a, b, c]) == ['no-response']


def test_responder_double_frame():
    a = brp(0, 'I', 'R', initiator=1, l_rx=1)
    b = brp(a.end + 3, 'R', 'I', 1, B.TRN_R, rx_train_resp=1)
    c = brp(b.end + 3, 'R', 'I', 1, B.TRN_R, rx_train_resp=1)
    assert 'retransmit' in rules([a, b, c])


def test_allocation_end_exempts_response():
    """10.42.3.1: ответ — «provided sufficient time is available … within the SP allocation or TXOP»."""
    a = brp(0, 'I', 'R', initiator=1, l_rx=1)
    assert rules([a], alloc_end=a.end + 5) == []
    assert rules([a], alloc_end=a.end + 500) == ['no-response']
    late = brp(0, 'I', 'R', initiator=1, l_rx=1)
    assert 'alloc' in rules([late], alloc_end=late.end - 1)


def test_filler_ppdu_before_response():
    """10.42.3.1: ответчик может держать IFS ≤ SIFS, передавая PPDU до BRP-ответа (СПОРНО — см. check_brp_log)."""
    a = brp(0, 'I', 'R', initiator=1, l_rx=1)
    fill = B.Ppdu(a.end + 3, 'R', 'I', 'Data', mcs=1, length=200)
    b = brp(fill.end + 3, 'R', 'I', 1, B.TRN_R, rx_train_resp=1)
    assert rules([a, fill, b]) == []
    assert rules([a, fill]) == ['no-response']


# ---------------- судья: содержимое ----------------
def test_initiator_bit():
    """10.42.6.4.1: Initiator = 1, если предыдущий принятый кадр не BRP или свой последний BRP был с Initiator = 1."""
    a = brp(0, 'I', 'R', initiator=0, l_rx=1)
    b = brp(a.end + 3, 'R', 'I', 1, B.TRN_R, rx_train_resp=1)
    assert rules([a, b]) == ['initiator']
    ack = B.Ppdu(0, 'R', 'I', 'SSW-Ack', mcs=0, length=28)
    a = brp(ack.end + 3, 'I', 'R', initiator=1, l_rx=1)
    b = brp(a.end + 3, 'R', 'I', 1, B.TRN_R, initiator=1, rx_train_resp=1)
    assert 'initiator' in rules([ack, a, b])


def test_rx_training_response_content():
    """10.42.6.4.1: TRN-R по L-RX и RX-train-response = 1."""
    a = brp(0, 'I', 'R', initiator=1, l_rx=3)
    assert rules([a, brp(a.end + 3, 'R', 'I', 2, B.TRN_R, rx_train_resp=1)]) == ['rx-trn']
    assert rules([a, brp(a.end + 3, 'R', 'I', 3, B.TRN_R)]) == ['rx-trn']
    assert rules([a, brp(a.end + 3, 'R', 'I', 3, B.TRN_T, rx_train_resp=1)]) == ['rx-trn']


def test_tx_training_response_content():
    """10.42.6.4.1 / 9.4.2.129: BS-FBCK — 1..число TRN-T; отводов не больше запрошенного; без SNR/канала — без CMF;
    N_meas = число TRN-T (табл. 9-256)."""
    a = brp(0, 'I', 'R', 3, B.TRN_T, initiator=1, tx_trn_req=1, fbck_req=B.FbckReq(snr=1, ntaps=1))
    ok = dict(tx_trn_ok=1, tx_train_resp=1)
    assert rules([a, brp(a.end + 3, 'R', 'I', bs_fbck=12, fbck_type=B.FbckType(snr=1, nmeas=12), **ok)]) == []
    assert rules([a, brp(a.end + 3, 'R', 'I', bs_fbck=13, fbck_type=B.FbckType(snr=1, nmeas=12), **ok)]) == \
        ['bs-fbck']
    assert rules([a, brp(a.end + 3, 'R', 'I', bs_fbck=1, fbck_type=B.FbckType(snr=1, ntaps=2, nmeas=12), **ok)]) == \
        ['fbck-taps']
    assert rules([a, brp(a.end + 3, 'R', 'I', bs_fbck=1, fbck_type=B.FbckType(snr=1, nmeas=4), **ok)]) == ['nmeas']
    bad = brp(a.end + 3, 'R', 'I', bs_fbck=1, **ok)
    bad.frame.cmf = 10
    assert rules([a, bad]) == ['cmf']
    assert rules([a, brp(a.end + 3, 'R', 'I', bs_fbck=1, tx_trn_ok=1)]) == ['tx-trn']


def test_tx_trn_ok_then_trn_t_owed():
    """10.42.6.4.1: после TX-TRN-OK без TX-train-response (L-RX = 0) запросившая STA передаёт BRP PPDU с TRN-T."""
    a = brp(0, 'I', 'R', initiator=1, tx_trn_req=1)
    b = brp(a.end + 3, 'R', 'I', tx_trn_ok=1)
    c = brp(b.end + 3, 'I', 'R', initiator=1, tx_trn_req=1)
    assert 'owe-trn-t' in rules([a, b, c])
    b2 = brp(a.end + 3, 'R', 'I', tx_trn_ok=1, l_rx=2)
    assert 'tx-trn' in rules([a, b2])


def test_frame_field_rules():
    """10.42.6.4.1: TXSS-FBCK-REQ и TX-TRN-REQ не вместе; Sector ID Order Requested = 0 при TX-TRN-REQ;
    9.4.2.129: BS-FBCK = 0, если последний принятый PPDU не BRP-TX."""
    assert 'frame' in rules([brp(0, 'I', 'R', initiator=1, tx_trn_req=1, txss_fbck_req=1)])
    assert 'frame' in rules([brp(0, 'I', 'R', initiator=1, tx_trn_req=1, fbck_req=B.FbckReq(sido=1))])
    assert 'frame' in rules([brp(0, 'I', 'R', initiator=1, bs_fbck=3)])
    assert 'frame' in rules([brp(0, 'I', 'R', initiator=1, l_rx=17)])


def test_aggregation_and_no_ack():
    """10.42.6.4.1: два BRP не в одном A-MPDU; BRP — только с одним Ack, BA или QoS Null. 9.6.21.3: Action No Ack."""
    def one(**kw):
        a = brp(0, 'I', 'R', initiator=1, **kw)
        return [a, brp(a.end + 3, 'R', 'I')]
    assert rules(one(ampdu=('BRP',))) == ['ampdu']
    assert rules(one(ampdu=('Data',))) == ['ampdu']
    assert rules(one(ampdu=('Ack', 'QoS Null'))) == ['ampdu']
    assert rules(one(ampdu=('QoS Null',))) == []
    a = brp(0, 'I', 'R', initiator=1)
    assert 'ack' in rules([a, B.Ppdu(a.end + 3, 'R', 'I', 'Ack', mcs=0, length=14), brp(a.end + 40, 'R', 'I')])


def test_duration_field():
    """10.42.6.4.1: Duration — время до конца SP/TXOP."""
    log = B.run_transaction(B.Participant('I', rx_units=2), B.Participant('R'), alloc_end=1000)
    assert [e.dur for e in log] == [B.brp_duration(e.end, 1000) for e in log]
    assert rules(log, alloc_end=1000) == []
    log[1].dur += 1
    assert rules(log, alloc_end=1000) == ['duration']
    assert B.brp_duration(Fr(9995, 10), 1000) == 1


def test_trn_r_awv():
    """10.42.6.4.4 / 20.9.2.2.6: TRN-R тем же AWV, что преамбула; Other_AID ≠ 0 у обеих — лучший к AID."""
    a = brp(0, 'I', 'R', initiator=1, l_rx=1)
    b = brp(a.end + 3, 'R', 'I', 1, B.TRN_R, rx_train_resp=1, tx_awv=5, trn_awv=5)
    assert rules([a, b]) == []
    b.trn_awv = 6
    assert rules([a, b]) == ['trn-awv']
    b.frame.req.other_aid = 9
    assert rules([a, b], other_aid_both=True, best_awv_for=lambda aid: 6) == []


# ---------------- 10.42.6.4.3 / 10.42.6.4.4 / 10.42.1 ----------------
def test_first_brp_after_sls():
    """10.42.6.4.3: L-RX > 0 в SSW-Ack → первый BRP — BRP-RX; L-RX = 0 и TX-TRN-REQ = 1 → TX-TRN-OK = 1 или L-RX > 0."""
    ack = B.BrpRequest(l_rx=4)
    assert B.first_brp_after_sls_ok(ack, False, brp(0, 'I', 'R', 4, B.TRN_R)) == []
    assert B.first_brp_after_sls_ok(ack, False, brp(0, 'I', 'R', 2, B.TRN_R))
    assert B.first_brp_after_sls_ok(ack, True, brp(0, 'I', 'R')) == []          # MID/BC выдан — правило не действует
    tx = B.BrpRequest(tx_trn_req=1)
    assert B.first_brp_after_sls_ok(tx, False, brp(0, 'I', 'R', tx_trn_ok=1)) == []
    assert B.first_brp_after_sls_ok(tx, False, brp(0, 'I', 'R', l_rx=1)) == []
    assert B.first_brp_after_sls_ok(tx, False, brp(0, 'I', 'R'))


def test_antenna_configuration():
    """10.42.6.4.4."""
    assert B.rx_config_rx_requester(True, False, False, False) == 'sweep'
    assert B.rx_config_rx_requester(False, True, True, False) == 'best'
    assert B.rx_config_rx_requester(False, False, False, True) == 'best'          # RXSS в SLS
    assert B.rx_config_rx_requester(False, False, False, False) == 'quasi-omni'
    assert B.rx_config_tx_responder(True, 7, True, True, False) == ('best-for-aid', 7)
    assert B.rx_config_tx_responder(False, 7, True, True, False) == ('best', None)
    assert B.rx_config_tx_responder(True, 0, False, False, False) == ('quasi-omni', None)
    assert B.trn_r_tx_awv(3, True, 0) == 3 and B.trn_r_tx_awv(3, False, 5) == 3
    assert B.trn_r_tx_awv(3, True, 5, lambda aid: aid * 10) == 50
    assert B.reciprocity_awv(True, 11, 2) == 11 and B.reciprocity_awv(False, 11, 2) == 2


def test_max_bf_time():
    """10.42.1 + MIB dot11MaxBFTime DEFVAL 4: BRP прерывается, если не завершён за 4 BI."""
    assert B.DOT11_MAX_BF_TIME == 4
    assert not B.bf_brp_expired(0, 4 * 102400, 102400)
    assert B.bf_brp_expired(0, 4 * 102400 + 1, 102400)


# ---------------- BRP setup и MIDC ----------------
def test_setup_required():
    """10.42.3.2: три случая обязательного setup."""
    assert B.setup_required(rss_in_abft=True)
    assert B.setup_required(ssw_fb_req=B.BrpRequest(mid_req=1))
    assert B.setup_required(ssw_ack_req=B.BrpRequest(bc_req=1))
    assert B.setup_required(intends_midc=True)
    assert not B.setup_required(ssw_fb_req=B.BrpRequest(l_rx=4, tx_trn_req=1))        # рис. 10-74: пропуск


def test_midc_subphases():
    """10.42.3.2 / 10.42.6.3.2 a): MID+BC — только при обоих Grant; порядок R-MID, I-MID, R-BC, I-BC;
    10.42.6.3.3: MID only; 10.42.6.3.4: BC only."""
    both, g = B.BrpRequest(mid_req=1, bc_req=1), B.BrpRequest(mid_grant=1, bc_grant=1)
    assert B.midc_subphases(both, g, both, g) == ['R-MID', 'I-MID', 'R-BC', 'I-BC']
    assert B.midc_subphases(both, B.BrpRequest(mid_grant=1)) == []
    assert B.midc_subphases(B.BrpRequest(mid_req=1), B.BrpRequest(mid_grant=1)) == ['R-MID']
    assert B.midc_subphases(None, None, B.BrpRequest(bc_req=1), B.BrpRequest(bc_grant=1)) == ['I-BC']
    assert B.midc_subphases(B.BrpRequest(mid_req=1), B.BrpRequest()) == []


def test_mid_only_grant_and_sector_list():
    """10.42.3.2: кадр Grant MID only — Capability Request, TX-TRN-REQ, L-RX, MID-REQ, BC-REQ = 0; затем запросившая
    STA шлёт SNR Present = Sector ID Order Present = 1, N_meas — из SLS (рис. 10-85: N_meas = 7), Cap. Request = 0."""
    req = B.BrpRequest(mid_req=1, l_rx=2)
    assert B.check_grant_frame(req, B.BrpFrame(B.BrpRequest(mid_grant=1))) == []
    assert B.check_grant_frame(req, B.BrpFrame(B.BrpRequest(mid_grant=1, l_rx=1)))
    assert B.check_grant_frame(req, B.BrpFrame(B.BrpRequest(mid_grant=1), B.BeamRefinement(cap_req=1)))
    sl = B.BrpFrame(B.BrpRequest(l_rx=2), B.BeamRefinement(fbck_type=B.FbckType(snr=1, sido=1, nmeas=7)))
    assert B.check_mid_sector_list(sl, 7) == []
    assert B.check_mid_sector_list(sl, 6)
    assert B.transactions_follow([B.BrpFrame(B.BrpRequest(l_rx=1))])
    assert not B.transactions_follow([B.BrpFrame(), B.BrpFrame()])


def test_setup_fig_10_80():
    """Рис. 10-80 (BRP setup в DTI): I: Cap. Request = 1 → R: Cap. Request = 0 → I: Cap. Request = 0; промежутки
    ≥ SIFS ≤ BRPIFS."""
    a = brp(0, 'I', 'R', initiator=1, cap_req=1, fbck_type=B.FbckType(snr=1, sido=1, nmeas=5), phase='setup')
    b = brp(a.end + 3, 'R', 'I', cap_req=0, phase='setup')
    c = brp(b.end + 3, 'I', 'R', initiator=1, cap_req=0, phase='setup')
    out, end = B.check_setup([a, b, c], 'I')
    assert out == [] and end == 2
    c2 = brp(b.end + 3, 'I', 'R', initiator=1, cap_req=1, phase='setup')
    out, end = B.check_setup([a, b, c2], 'I')
    assert end is None and [v.rule for v in out] == ['setup-end']
    c3 = brp(b.end + 50, 'I', 'R', initiator=1, cap_req=0, phase='setup')
    assert [v.rule for v in B.check_setup([a, b, c3], 'I')[0]] == ['brpifs']
    assert B.check_setup([b], 'I')[0][0].rule == 'setup-start'


def _fb(seq, src, dst, **kw):
    return brp(seq[-1].end + 3, src, dst, phase=seq[-1].phase, **kw)


def _r_mid(n=3, l_rx=2, gap=T.SIFS, ext=None, t0=0, sectors=None):
    """Рис. 10-85: ответчик — MID BRP N_Tx(1)..N_Tx(N_beam), MID Extension 1,…,1,0, через SIFS."""
    ext = ext or [1] * (n - 1) + [0]
    sectors = sectors or [10 + k for k in range(n)]
    out, t = [], Fr(t0)
    for k in range(n):
        p = brp(t, 'R', 'I', l_rx, B.TRN_R, mid_ext=ext[k], tx_sector_id=sectors[k], phase='MID')
        out.append(p)
        t = p.end + gap
    return out


def test_mid_only_fig_10_85():
    """10.42.6.3.3 b), рис. 10-85: BRP-RX с L-RX единиц TRN-R, Sector ID, MID Extension; обратная связь инициатора —
    BS-FBCK из переданных секторов через ≥ SIFS ≤ BRPIFS."""
    def run(seq, **kw):
        fb = _fb(seq, 'I', 'R', bs_fbck=11, fbck_type=B.FbckType(sido=1, snr=1, nmeas=3))
        return {v.rule for v in B.check_mid(seq + [fb], 'R', 2, **kw)}
    mids = _r_mid()
    fb = _fb(mids, 'I', 'R', bs_fbck=11, fbck_type=B.FbckType(sido=1, snr=1, nmeas=3))
    assert B.check_mid(mids + [fb], 'R', 2, prev_end=-10) == []
    assert run(_r_mid(gap=T.aSBIFSTime)) == set()                       # СПОРНО: SBIFS тоже принят
    assert run(_r_mid(ext=[1, 1, 1])) == {'mid-ext'}
    assert run(_r_mid(l_rx=1)) == {'mid-trn'}
    assert run(_r_mid(gap=10)) == {'mid-gap'}
    assert run(_r_mid(sectors=[1, 1, 2])) == {'mid-sector', 'mid-fbck'}
    fb.frame.bre.bs_fbck = 40
    assert {v.rule for v in B.check_mid(mids + [fb], 'R', 2)} == {'mid-fbck'}
    assert {v.rule for v in B.check_mid(mids + [fb], 'R', 2, prev_end=-50)} == {'brpifs', 'mid-fbck'}
    assert {v.rule for v in B.check_mid(mids, 'R', 2)} == {'mid-fbck'}


def test_mid_with_bc_feedback_number_of_beams():
    """10.42.6.3.2 b): после R-MID обратная связь — Number of Beams (число RX AWV для R-BC)."""
    mids = _r_mid(n=2)
    fb = _fb(mids, 'I', 'R', fbck_type=B.FbckType(nbeams=3))
    assert B.check_mid(mids + [fb], 'R', 2, with_bc=True) == []
    fb.frame.bre.fbck_type.nbeams = 0
    assert [v.rule for v in B.check_mid(mids + [fb], 'R', 2, with_bc=True)] == ['mid-fbck']


def _bc(nbeam_tx=3, units=1, gap=T.aSBIFSTime):
    out, t = [], Fr(0)
    for k in range(nbeam_tx):
        p = brp(t, 'I', 'R', units, B.TRN_R, tx_sector_id=20 + k, phase='BC')
        out.append(p)
        t = p.end + gap
    return out


def test_bc_fig_10_83():
    """10.42.6.3.2 c), рис. 10-83: N_beam(I,TX) BRP-RX через SBIFS, в каждом N_beam(I,RX) TRN-R; ответ ≥ SIFS ≤ BRPIFS
    с BS-FBCK = сектор лучшего BRP-RX и Sector ID Order."""
    bc = _bc()
    fb = _fb(bc, 'R', 'I', bs_fbck=21, fbck_type=B.FbckType(sido=1, nbeams=3))
    assert B.check_bc(bc + [fb], 'I', 3, 4) == []
    assert {v.rule for v in B.check_bc(bc + [fb], 'I', 3, 5)} == {'bc-trn'}       # 5 > 4 TRN-R одной единицы
    assert {v.rule for v in B.check_bc(bc + [fb], 'I', 4, 4)} == {'bc-count'}
    s2 = _bc(gap=T.SIFS)
    assert {v.rule for v in B.check_bc(s2 + [_fb(s2, 'R', 'I', bs_fbck=21, fbck_type=B.FbckType(sido=1))],
                                       'I', 3, 4)} == {'bc-gap'}
    late = brp(bc[-1].end + 45, 'R', 'I', bs_fbck=21, fbck_type=B.FbckType(sido=1), phase='BC')
    assert {v.rule for v in B.check_bc(bc + [late], 'I', 3, 4)} == {'brpifs'}
    fb.frame.bre.bs_fbck = 5
    assert {v.rule for v in B.check_bc(bc + [fb], 'I', 3, 4)} == {'bc-fbck'}


def test_midc_phase_events_skipped_by_transaction_checker():
    """События MID/BC — у check_mid/check_bc; судья транзакций их пропускает (поля проверяет)."""
    assert rules(_r_mid()) == []
    assert rules(_bc()) == []
