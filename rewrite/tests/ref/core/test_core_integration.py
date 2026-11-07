# SPDX-License-Identifier: AGPL-3.0-or-later
"""Интеграция 1 (ARCHITECTURE.md): точка и станция на ядре в идеальной среде — маяки по секторам, A-BFT и/или SLS в
DTI, Probe, ассоциация, ADDBA в обе стороны, данные N МБ в обе стороны (RTS/DMG CTS, A-MPDU, BlockAck), CF-End.
На журнале — все правила air_judge и судьи моста эмулятора (judge_run): 0 нарушений; «не проверяемо» — с причиной."""
from collections import Counter
from fractions import Fraction as Fr

import pytest

from .. import mlme as M
from . import sap_mlme as ML
from .conftest import fmt, judge_all
from .scenario import Bss

MB = 1 << 20


@pytest.fixture(scope='module')
def main_run(RB):
    b = Bss(seed=1, ul_bytes=MB, dl_bytes=MB, bf='abft')
    done = b.run(max_bis=20)
    return b, done, judge_all(b, RB)


def test_connects_and_moves_data(main_run):
    b, done, _ = main_run
    assert done
    sta, ap = b.sta, b.ap
    assert b.sta_sme.state == 'data'
    assert ap.apmlme.state(sta.addr) == M.S4 and sta.mlme.state(ap.addr) == M.S4      # 11.3.1: State 4 без Auth
    # данные — целиком и по порядку в обе стороны (MA-UNITDATA.indication)
    up = b"".join(i.data for i in b.ap_sme.rx)
    assert up == b"".join(b.sta_sme.ul) and len(up) == MB
    down = b"".join(i.data for i in b.sta_sme.rx)
    assert down == b"".join(b.ap_sme.dl_sent[sta.addr]) and len(down) == MB
    # MA-UNITDATA-STATUS.indication(Successful) на каждую MSDU
    assert b.sta_sme.ok_count() == len(b.sta_sme.ul) and b.ap_sme.ok_count() == len(b.ap_sme.dl_sent[sta.addr])


def test_mlme_sequence(main_run):
    b, _, _ = main_run
    names = [p.NAME for p in b.sta_sme.log]
    want = ['MLME-SCAN.confirm', 'MLME-JOIN.confirm', 'MLME-BF-TRAINING.indication', 'MLME-SCAN.confirm',
            'MLME-ASSOCIATE.confirm', 'MLME-ADDBA.confirm', 'MLME-ADDBA.indication']
    it = iter(names)
    assert all(w in it for w in want), names
    ap_names = [p.NAME for p in b.ap_sme.log]
    assert ap_names[0] == 'MLME-START.confirm'
    assert {'MLME-ASSOCIATE.indication', 'MLME-ADDBA.indication', 'MLME-ADDBA.confirm'} <= set(ap_names)


def test_air_contents(main_run):
    b, _, _ = main_run
    k = b.journal.kinds()
    for kind in ('DMG Beacon', 'SSW', 'SSW-Feedback', 'BRP', 'Probe Request', 'Probe Response',
                 'Association Request', 'Association Response', 'Action', 'Ack', 'RTS', 'DMG CTS', 'A-MPDU',
                 'BlockAck', 'CF-End'):
        assert k[kind] > 0, kind
    # BTI: каждый BI — маяки по всем 8 секторам, CDOWN 7..0
    by = Counter(r.txv.ANT_CONFIG.sector for r in b.journal.recs if r.kind == 'DMG Beacon')
    assert set(by) == set(range(8)) and len(set(by.values())) == 1
    # CF-End держателя и ответный CF-End (10.23.2.10, 9.3.1.6: i = 2 и i = 1)
    cf = [r for r in b.journal.recs if r.kind == 'CF-End']
    durs = Counter(int.from_bytes(r.mpdus[0][2:4], 'little') for r in cf)
    assert durs[0] == durs[18] and durs[0] >= 2
    # ATI нет (ATI Present 0), DTI — CBAP Only
    assert not any(r.kind in ('Announce', 'Grant', 'Poll', 'SPR') for r in b.journal.recs)


def test_judges_zero_violations(main_run, RB):
    b, _, (c, rules, va, evs, found) = main_run
    assert not va and not found, fmt(c, va, evs, found, RB)


def test_judge_coverage(main_run):
    """Правила, применимые к сценарию, — проверены (checked/partial), «не проверяемо» — только с причиной."""
    b, _, (c, rules, va, evs, found) = main_run
    st = {r.rid: r for r in rules}
    for rid in ('fc', 'ctl_len', 'cfe_fields', 'beacon_fields', 'ba_control', 'mcs_control', 'mcs_response',
                'dur_cts', 'dur_resp', 'dur_cf_end', 'dur_bf', 'nav_txop', 'cf_end_rules', 'ifs_sifs', 'access',
                'responder_tx', 'resp_seq', 'ack_policy', 'bi', 'holder_gap', 'cbap_end', 'bti_delay', 'edca',
                'ampdu_dur', 'ba_window', 'mgmt_body', 'addba', 'brp', 'abft', 'ati', 'assoc_state', 'nav_rx',
                'supp_channels', 'ampdu_limits', 'timestamp'):
        assert rid in st and st[rid].checked > 0, (rid, st.get(rid) and st[rid].status)
    for r in rules:
        if r.status == 'unchecked':
            assert r.unchecked and all(why for why in r.unchecked), r.rid


@pytest.mark.parametrize('kw', [
    dict(bf='dti', seed=2),
    dict(bf='both', seed=3, ap_sectors=16, sta_sectors=8),
    dict(n_sta=2, seed=4, prop=Fr(3, 100)),
    dict(n_sta=3, seed=5, prop=0),
    dict(seed=6, bi_tu=5, nbytes=3_000_000),
], ids=['sls-dti', 'abft+sls-16sec', '2sta', '3sta', 'bi5-3MB'])
def test_variants_zero_violations(kw, RB):
    kw = dict(kw)
    n = kw.pop('nbytes', 200_000)
    b = Bss(ul_bytes=n, dl_bytes=n, **kw)
    assert b.run(max_bis=100)
    c, rules, va, evs, found = judge_all(b, RB)
    assert not va and not found, fmt(c, va, evs, found, RB)
    st = {r.rid: r for r in rules}
    if kw.get('bf') in ('dti', 'both'):
        assert st['sls'].checked > 0 and st['blm'].checked > 0
        assert any(isinstance(p, ML.MlmeBfTrainingConfirm) and p.ResultCode == ML.SUCCESS
                   for p in b.sta_sme.log)
    for s, sme in zip(b.stas, b.sta_smes):
        assert sum(len(i.data) for i in b.ap_sme.rx if i.source_address == s.addr) == n
        assert sme.rx_bytes() == n
