# SPDX-License-Identifier: AGPL-3.0-or-later
"""Станция DMG из модулей эталона: генератор (AP/STA на medium) и судья журнала эфира. Ожидания — из текста
802.11-2020: BTI/A-BFT/ATI/DTI (10.39.2, 10.42.4, 10.42.5), SBIFS (10.3.2.3.8), CDOWN (10.42.4), Duration
(9.2.5, 9.3.4.2), порядок элементов (табл. 9-34, 9-45), классы кадров (11.3.3), потеря маяков (11.1.3.1),
реассоциация (11.3.5.4), BRP после A-BFT (10.42.5.2)."""
import ast
import os
from fractions import Fraction as Fr

import pytest

from . import dmg_sta as X
from . import elements as E
from . import fields as F
from . import timing as T

AP, S1, S2 = '02:00:00:00:00:01', '02:00:00:00:00:02', '02:00:00:00:00:03'
HERE = os.path.dirname(__file__)


def kinds(log, kind, src=None):
    return [i for i, r in enumerate(log) if r.kind == kind and (src is None or r.src == src)]


def run(n_sta=1, n_bi=5, seed=1, block=None, **kw):
    net = X.Network(seed=seed, **kw)
    ap = net.add_ap(AP)
    stas = [net.add_sta(a) for a in (S1, S2)[:n_sta]]
    if block:
        net.block(AP, S1, net.tbtt(block[0]), net.tbtt(block[1]))
    net.run_bis(n_bi)
    return net, ap, stas, net.air_log()


@pytest.fixture(scope='module')
def one():
    return run(1, 5, seed=1)


@pytest.fixture(scope='module')
def two():
    return run(2, 6, seed=2)


@pytest.fixture(scope='module')
def loss():
    return run(1, 14, seed=1, block=(3, 9))


# ------------------------------------------------------------------------------------ общие правила модулей
def test_no_redefinition_of_timing_constants():
    """PLAN.md: общие постоянные — только в timing.py (как test_consistency.MODULES)."""
    def names(p):
        out = set()
        for n in ast.parse(open(p, encoding='utf-8').read()).body:
            ts = n.targets if isinstance(n, ast.Assign) else [n.target] if isinstance(n, ast.AnnAssign) else []
            for t in ts:
                out |= {x.id for x in ast.walk(t) if isinstance(x, ast.Name)}
            if isinstance(n, (ast.FunctionDef, ast.ClassDef)):
                out.add(n.name)
        return out
    again = names(os.path.join(HERE, 'dmg_sta.py')) & names(os.path.join(HERE, 'timing.py'))
    assert again == set(), sorted(again)


# ------------------------------------------------------------------------------------ AP один
def test_ap_alone_bis_clean():
    """AP без STA: в каждом BI — DMG Beacon через все сектора (11.1.2.1), CDOWN n−1…0 (10.42.4), через SBIFS
    (10.42.2.2.2), первый — в TBTT (11.1.3.3.1); судья — без нарушений."""
    net, ap, _, log = run(0, 4)
    bea = kinds(log, 'DMG Beacon')
    assert len(bea) == 4 * 8 and len(log) == len(bea)
    for k in range(4):
        b = [log[i] for i in bea[8 * k:8 * k + 8]]
        assert b[0].t_start == net.tbtt(k)
        assert [r.fields['cdown'] for r in b] == list(range(7, -1, -1))
        assert sorted(r.fields['sector'] for r in b) == list(range(8))
        assert all(q.t_start - p.t_end == T.SBIFS for p, q in zip(b, b[1:]))
        # 9.3.4.2: Duration — остаток BTI; конец BTI = конец последнего маяка (PLAN.md №5)
        assert b[-1].dur == 0 and b[0].dur == T.ceil_to(b[-1].t_end - b[0].t_end, 1)
    assert X.judge(log) == []


def test_ap_beacon_bytes_and_schedule():
    """Байты маяка — кодеки fields/elements: BIC (A-BFT 8 слотов, FSS 4 кадра — поле 3, PLAN.md №1), DMG Parameters
    (BSS Type 3), Extended Schedule — широковещательный CBAP после ATI до следующего TBTT (9.4.2.131, 10.39.6.1),
    Next DMG ATI — не раньше MBIFS после A-BFT (10.39.3); fields.check_mpdu — без нарушений."""
    net, ap, _, log = run(0, 1)
    raw = log[0].raw
    assert F.check_mpdu(raw, role='ap', pcp=False, rx_antennas=1) == []
    cfg, bcn = X.beacon_config(raw)
    assert (bcn.bic.abft_length, bcn.bic.fss, bcn.params.bss_type) == (7, 3, 3)
    assert [e[0] for e in bcn.elements] == [E.EID_DMG_CAPABILITIES, E.EID_EXTENDED_SCHEDULE, E.EID_DMG_OPERATION,
                                            E.EID_NEXT_DMG_ATI, E.EID_SSID]
    plan = ap.plan
    a = cfg.allocations[0]
    assert (a.alloc_type, a.src_aid, a.dst_aid, a.alloc_id) == ('CBAP', 255, 255, 0)
    assert cfg.ati_start == plan.ati_win[0] >= plan.layout.end + T.MBIFS
    assert a.start == cfg.ati_start + cfg.ati_duration and a.start + a.block_dur <= net.tbtt(1)
    assert plan.layout.start == plan.bti_end + T.MBIFS


# ------------------------------------------------------------------------------------ AP + 1 STA
def test_one_sta_full_join_to_data(one):
    """BTI → A-BFT (RSS, SSW-Feedback) → ATI (Announce/Ack) → BRP setup → ассоциация → ADDBA → A-MPDU/BlockAck."""
    net, ap, (sta,), log = one
    ev = [e for _, e in sta.events]
    assert ev[:4] == ['join', 'bf', 'associated', 'ba']
    assert sta.state == 'associated' and sta.mlme.state(AP) == 4 and ap.mlme.state(S1) == 4
    assert ap.mlme.aid[S1] == sta.aid == 1
    # 10.42.5.2: RSS в A-BFT — 4 SSW (все сектора STA) в одном слоте, SSW-Feedback — через лучший сектор AP
    ssw = [log[i] for i in kinds(log, 'SSW', S1)]
    assert [r.fields['cdown'] for r in ssw[:4]] == [3, 2, 1, 0]
    fb = log[kinds(log, 'SSW-Feedback')[0]]
    assert fb.tx_cfg == (0, ssw[0].fields['sector_select']) and fb.dst == S1
    assert sta.tx_cfg[AP] == (0, fb.fields['sector_select'])
    # 10.42.5.2: BRP с Capability Request = 1 на MCS 0 через Sector Select ответчика; setup — три кадра (10.42.3.2)
    brp = [log[i] for i in kinds(log, 'BRP') if S1 in log[i].receivers or AP in log[i].receivers]
    assert [r.fields['brp'].bre.cap_req for r in brp[-3:]] == [1, 0, 0] and brp[-3].mcs == 0
    assert brp[-3].tx_cfg == fb.tx_cfg
    # 10.25: данные дошли через Block Ack
    assert ap.rx_msdus[S1] >= 8 * 4 and sta.rx_msdus >= 1
    assert sta.orig is not None and not [s for s, v in sta.orig.state.items() if v != 'acked']
    assert X.judge(log) == []


def test_sta_bti_end_estimate_matches_ap(one):
    """10.42.5.1 (PLAN.md №5): конец BTI у STA по любому маяку (CDOWN + Duration) = конец BTI у AP."""
    net, ap, (sta,), log = one
    k = max(sta.bti)
    assert sta.bti[k]['end'] == ap.plan.bti_end and sta.bti[k]['layout'].start == ap.plan.layout.start


def test_deterministic_seed():
    a = [(r.t_start, r.src, r.kind, r.dur) for r in run(2, 3, seed=7)[3]]
    b = [(r.t_start, r.src, r.kind, r.dur) for r in run(2, 3, seed=7)[3]]
    assert a == b


# ------------------------------------------------------------------------------------ AP + 2 STA
def test_two_stas_contend_abft_and_cbap(two):
    """Две STA выбирают слот A-BFT случайно (10.42.5.2): совпадение слота — коллизия, без SSW-Feedback, повтор;
    в CBAP — EDCA (10.23.2); обе ассоциированы, данные идут, судья — без нарушений."""
    net, ap, stas, log = two
    s1 = {log[i].t_start for i in kinds(log, 'SSW', S1)}
    s2 = {log[i].t_start for i in kinds(log, 'SSW', S2)}
    assert s1 & s2                                           # общий слот A-BFT
    assert all(s.state == 'associated' for s in stas)
    assert set(ap.associated()) == {S1, S2} and {ap.mlme.aid[S1], ap.mlme.aid[S2]} == {1, 2}
    assert ap.rx_msdus[S1] > 0 and ap.rx_msdus[S2] > 0
    assert X.judge(log) == []


@pytest.mark.parametrize('seed', [3, 4, 5, 11])
def test_two_stas_other_seeds_clean(seed):
    net, ap, stas, log = run(2, 4, seed=seed)
    assert all(s.state == 'associated' for s in stas)
    assert X.judge(log) == []


# ------------------------------------------------------------------------------------ потеря связи
def test_beacon_loss_link_loss_reassociation(loss):
    """11.1.3.1: нет DMG Beacon dot11BeaconPeriod × dot11MaxLostBeacons → связь потеряна; после возврата маяков —
    A-BFT и Reassociation Request к тому же AP (11.3.5.4), AID сохраняется, новое соглашение BA, данные идут."""
    net, ap, (sta,), log = loss
    ev = sta.events
    lost = [t for t, e in ev if e == 'lost'][0]
    last_bcn = max(log[i].t_start for i in kinds(log, 'DMG Beacon') if S1 in log[i].receivers
                   and log[i].t_start < net.tbtt(3))
    assert lost > last_bcn + net.bi_tu * T.DOT11_MAX_LOST_BEACONS * T.TU
    assert lost < net.tbtt(9)
    names = [e for _, e in ev]
    assert names[names.index('lost'):] == ['lost', 'beacon_back', 'bf', 'associated', 'ba']
    rq = [log[i] for i in kinds(log, E.REASSOC_REQ, S1)]
    assert rq and rq[-1].t_start > net.tbtt(9)
    fx, _ = E.parse_body(E.REASSOC_REQ, rq[-1].fields['body'])
    assert fx['current_ap'] == AP
    assert sta.state == 'associated' and sta.aid == 1 and ap.mlme.state(S1) == 4
    before = ap.rx_base[S1]
    assert before > 0 and ap.rx_msdus[S1] > before
    # во время затенения STA не передаёт (нет маяков — нет CBAP, 10.39.6.4)
    assert not [r for r in log if r.src == S1 and net.tbtt(3) <= r.t_start < net.tbtt(9)]
    assert X.judge(log) == []


# ------------------------------------------------------------------------------------ судья: внесённые ошибки
def _bti(log, k_first=1):
    return [i for i in kinds(log, 'DMG Beacon') if log[i].t_start >= k_first * 20 * T.TU][:8]


def test_fault_wrong_cdown(one):
    log = list(one[3])
    i = _bti(log)[2]
    log[i] = log[i]._replace(fields=dict(log[i].fields, cdown=log[i].fields['cdown'] + 1))
    assert ('bi', 'beacon_cdown') in X.rules(X.judge(log))
    # CDOWN SSW в A-BFT (10.42.2.3.2)
    log = list(one[3])
    j = kinds(log, 'SSW', S1)[1]
    log[j] = log[j]._replace(fields=dict(log[j].fields, cdown=0))
    v = X.judge(log)
    assert ('abft', 'cdown') in X.rules(v)
    assert all(x.clause for x in v)


def test_fault_ssw_outside_abft_slot(one):
    """10.42.5.2: RSS — только с начала слота; сдвиг первого SSW на 3 мкс."""
    log = list(one[3])
    j = kinds(log, 'SSW', S1)[0]
    d = Fr(3)
    log[j] = log[j]._replace(t_start=log[j].t_start + d, t_end=log[j].t_end + d)
    r = X.rules(X.judge(log))
    assert ('abft', 'ssw_start') in r and ('bi', 'abft_slot_start') in r


def test_fault_missing_sbifs(one):
    """10.3.2.3.8: маяки BTI через SBIFS — без промежутка нарушение."""
    log = list(one[3])
    b = _bti(log)
    i = b[3]
    d = log[i].t_start - log[b[2]].t_end
    log[i] = log[i]._replace(t_start=log[i].t_start - d, t_end=log[i].t_end - d)
    v = X.judge(log)
    assert ('bi', 'beacon_gap') in X.rules(v)
    assert [x.clause for x in v if x.rule == 'beacon_gap'][0].startswith('10.42.2.2.2')


def test_fault_wrong_duration(one):
    """9.2.5.7: Duration Ack = Duration вызвавшего − SIFS − TXTIME(Ack); 9.3.4.2: маяк — остаток BTI."""
    log = list(one[3])
    j = [i for i in kinds(log, 'Ack') if log[i - 1].kind == 'Data'][0]          # Ack на Data в CBAP
    log[j] = log[j]._replace(dur=log[j].dur + 5)
    v = X.judge(log)
    assert ('duration', 'ack') in X.rules(v) and [x.clause for x in v if x.rule == 'ack'][0] == '9.2.5.7'
    log = list(one[3])
    i = _bti(log)[0]
    log[i] = log[i]._replace(dur=log[i].dur + 1)
    r = X.rules(X.judge(log))
    assert ('bi', 'beacon_dur') in r and ('duration', 'dmg_beacon') in r


def test_fault_wrong_element_order(one):
    """9.3.3.1/табл. 9-34: SSID (3) раньше DMG Capabilities; табл. 9-45: порядок элементов DMG Beacon."""
    log = list(one[3])
    j = kinds(log, E.ASSOC_REQ, S1)[-1]
    fx, els = E.parse_body(E.ASSOC_REQ, log[j].fields['body'])
    body = E.encode_body(E.ASSOC_REQ, {'capability': {'dmg_params': {}}, 'listen_interval': 0}, els[::-1])
    log[j] = log[j]._replace(fields=dict(log[j].fields, body=body))
    v = X.judge(log)
    assert ('elements', E.ASSOC_REQ) in X.rules(v)
    assert any('9.3.3.1' in x.clause for x in v if x.module == 'elements')
    # маяк: элементы в обратном порядке, FCS пересчитана
    log = list(one[3])
    i = _bti(log)[0]
    raw = log[i].raw
    bcn = F.parse_dmg_beacon(raw)
    body = raw[:F.BEACON_FIXED_LEN] + F.encode_elements(list(bcn.elements)[::-1])
    log[i] = log[i]._replace(raw=body + F.fcs(body))
    assert ('fields', 'beacon') in X.rules(X.judge(log))


def test_fault_data_in_bti(one):
    """10.39.2: в BTI передаются только DMG Beacon AP; Data от STA — нарушение."""
    log = list(one[3])
    b = _bti(log)
    t = log[b[2]].t_end + Fr(1, 2)
    log.append(X.AirRec(t, t + T.txtime(200, 4), S1, AP, 'Data', 7, 4, {}, None, (0, 0), (), ()))
    v = X.judge(log)
    assert ('bi', 'bti_sta') in X.rules(v)
    assert [x for x in v if x.rule == 'bti_sta'][0].idx == len(log) - 1


def test_fault_missing_brp_after_abft(one):
    """10.42.5.2: после SSW-Feedback AP обязан послать BRP с Capability Request = 1 в aMinBTIPeriod BI."""
    log = [r for r in one[3] if not (r.kind == 'BRP' and r.src == AP)]
    assert ('abft', 'brp_cap') in X.rules(X.judge(log))


def test_fault_class3_before_association(one):
    """11.3.3: Data (класс 3) от STA в State 2 — нарушение; AP обязан ответить Disassociation (11.3.5.1)."""
    log = list(one[3])
    j = kinds(log, E.ASSOC_REQ, S1)[-1]
    t = log[j].t_start - 400
    log.append(X.AirRec(t, t + T.txtime(200, 4), S1, AP, 'Data', 7, 4, {}, None, (0, 0), (AP,), (AP,)))
    r = X.rules(X.judge(log))
    assert ('mlme', 'class_tx') in r and ('mlme', 'missing_reply') in r


def test_fault_sls_in_dti(one):
    """10.42.2.1: SLS начинается с ISS — одиночный SSW-Feedback в DTI без ISS — нарушение (sls.check_sls_log)."""
    log = list(one[3])
    t = Fr(3 * 20 * T.TU + 15000)
    log.append(X.AirRec(t, t + T.T_SSW_FB, AP, S1, 'SSW-Feedback', 0, 0,
                        dict(sector_select=1, ant_select=0, snr=Fr(10)), None, (0, 2), (S1,), (S1,)))
    assert ('sls', 'sls') in X.rules(X.judge(log))


def test_judge_without_heard_info():
    """Журнал без сведений о приёме (heard/receivers = None) — судья работает в модели «все слышат всех»."""
    log = [r._replace(receivers=None, heard=None) for r in run(0, 2)[3]]
    assert X.judge(log) == []
