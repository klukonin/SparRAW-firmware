# SPDX-License-Identifier: AGPL-3.0-or-later
"""Сквозная согласованность модулей эталона: одна постоянная — одно определение (timing.py), одни и те же TXTIME
SSW, формула слота A-BFT, конец BTI, кодирование полей; кадры генераторов sls/abft/brp кодируются кодеками fields,
журнал генератора одного модуля проходит судью другого. Принятые трактовки — PLAN.md «Принятые трактовки»."""
import ast
import os
from fractions import Fraction as Fr

import pytest

from . import abft as A
from . import bi as B
from . import brp as P
from . import duration as D
from . import fields as F
from . import sls as S
from . import timing as T
from .cbap import SeqRng

HERE = os.path.dirname(__file__)
# Модули, сведённые к общим постоянным timing.py (новый модуль — добавить сюда).
MODULES = ('abft', 'air_judge', 'air_pcap', 'amsdu', 'beamtrack', 'bi', 'blockack', 'brp', 'cbap', 'dms', 'duration',
           'elements', 'fields', 'linkmaint', 'mlme', 'nav', 'sls')


def _module_level_names(path):
    out = set()
    for n in ast.parse(open(path, encoding='utf-8').read()).body:
        targets = n.targets if isinstance(n, ast.Assign) else [n.target] if isinstance(n, ast.AnnAssign) else []
        for t in targets:
            out |= {x.id for x in ast.walk(t) if isinstance(x, ast.Name)}
        if isinstance(n, (ast.FunctionDef, ast.ClassDef)):
            out.add(n.name)
    return out


SHARED = _module_level_names(os.path.join(HERE, 'timing.py'))


# ---------------------------------------------------------------------------------- одно определение на постоянную
@pytest.mark.parametrize('mod', MODULES)
def test_no_redefinition_of_timing_constants(mod):
    """Ни один модуль не определяет заново то, что есть в timing.py (TU, табл. 11-22, IFS-допуски, T_SSW, …)."""
    again = _module_level_names(os.path.join(HERE, mod + '.py')) & SHARED
    assert again == set(), f'{mod}.py переопределяет {sorted(again)}'


@pytest.mark.parametrize('mod', MODULES)
def test_reexported_constants_are_timing_objects(mod):
    m = __import__(f'{__package__}.{mod}', fromlist=[mod])
    for name in SHARED:
        if hasattr(m, name) and not name.startswith('_'):
            assert getattr(m, name) is getattr(T, name), f'{mod}.{name}'


# ---------------------------------------------------------------------------------- TXTIME SSW-кадров и IFS
def test_ssw_txtimes_same_everywhere():
    """10.6.7.1 + 20.11.3: SSW/SSW-Feedback/SSW-Ack — DMG Control; длины рис. 9-54…9-56 — одинаковы в fields,
    duration и timing; TXTIME кадров генераторов sls и abft — те же."""
    for kind, ln, t in (('ssw', T.LEN_SSW, T.T_SSW), ('ssw_fb', T.LEN_SSW_FB, T.T_SSW_FB),
                        ('ssw_ack', T.LEN_SSW_ACK, T.T_SSW_ACK)):
        assert F.FRAME_LEN[kind] == D.LEN[kind] == ln
        assert D.tx(kind) == T.txtime_control(ln) == t
    assert S.BfFrame(S.SSW, 'a', 'b', 0).airtime == A.AirFrame('SSW', 0, 'a', 'b').end == T.T_SSW
    assert S.BfFrame(S.SSW_FB, 'a', 'b', 0).airtime == A.AirFrame('SSW-Feedback', 0, 'a', 'b').end == T.T_SSW_FB
    assert S.BfFrame(S.SSW_ACK, 'a', 'b', 0).airtime == A.AirFrame('SSW-Ack', 0, 'a', 'b').end == T.T_SSW_ACK
    # 10.3.2.3.11: LBIFS = TXTIME(SSW) + 2·SBIFS = ровно один шаг сетки CDOWN sls + SBIFS (PLAN.md №2)
    assert T.LBIFS == T.T_SSW + 2 * T.SBIFS == S.SLOT + T.SBIFS


def test_ifs_tolerances_one_value():
    """10.3.2.3.3/10/11: −0 … +10 %·(aSlotTime − aAirPropagationTime) — SIFS, MBIFS, LBIFS; PIFS — так же (№8)."""
    assert T.SIFS_TOL == T.MBIFS_TOL == T.LBIFS_TOL == T.PIFS_TOL == Fr(49, 100)
    assert T.SBIFS_MAX == 1 + Fr(3, 100)


# ---------------------------------------------------------------------------------- A-BFT: FSS и слот (№1, №4)
@pytest.mark.parametrize('fss_field', range(16))
def test_abft_slot_same_in_bi_and_abft(fss_field):
    """Табл. 11-22 + 10.42.5.2: одна формула aSSSlotTime; FSS в ней — число кадров = поле + 1 (bi, abft, fields)."""
    bic_a = A.BeaconIntervalControl(abft_length=7, fss=fss_field)
    bic_b = B.BeaconIntervalControl(abft_length=7, fss=fss_field)
    bic_f = F.Bic(abft_length=7, fss=fss_field)
    n = fss_field + 1
    assert bic_a.fss_frames == bic_b.fss_frames == F.fss_frames(bic_f) == n
    L = A.AbftLayout(0, 8, n)
    assert L.slot_time == B.ss_slot_time(n) == A.ss_slot_time(n) == T.ss_slot_time(n)
    # начало и длина A-BFT в расписании bi совпадают с abft (10.42.5.1: MBIFS после BTI)
    bti_end = Fr(500)
    per = B.layout(0, 100, B.BiConfig(bic_b), bti_end)
    pa = [p for p in per if p.kind == 'A-BFT'][0]
    assert pa.start == A.abft_start(bti_end) == bti_end + T.MBIFS
    assert pa.end - pa.start == A.AbftLayout(pa.start, 8, n).end - pa.start == 8 * L.slot_time
    # SSW-Feedback: «aSSFBDuration + MBIFS before the end of the SSW slot»
    s0, s1 = B.abft_slot(pa.start, 3, n)
    assert (s0, s1) == (A.AbftLayout(pa.start, 8, n).slot_start(3), A.AbftLayout(pa.start, 8, n).slot_end(3))
    assert B.ssw_fb_start(s1) == A.AbftLayout(pa.start, 8, n).fb_start(3)


def test_fss_minimum_same_reading():
    """10.42.5.2 «no less than aSSFramesPerSlot» — число кадров ≥ 4, т.е. поле ≥ 3, в bi и abft (№1)."""
    for fld, bad in ((2, True), (3, False)):
        bic_b = B.BeaconIntervalControl(fss=fld)
        assert any(r == 'bic_fss' for r, _ in bic_b.validate()) is bad
        bic_a = A.BeaconIntervalControl(abft_length=7, fss=fld)
        assert any(v.rule == 'fss_min' for v in A.check_bic_sequence([([bic_a], None)])) is bad


def test_bic_bit_layout_same():
    """Рис. 9-77: три представления Beacon Interval Control (abft, bi, fields) — одинаковые ширины и порядок."""
    widths_a = [w for _, _, w in A.BIC_FIELDS]
    widths_f = [w for n, w in F.BIC_SPEC if n]
    widths_b = list(B.BeaconIntervalControl.WIDTH.values())
    assert widths_a == widths_f == widths_b
    lsb = 0
    for name, lo, w in A.BIC_FIELDS:
        assert lo == lsb
        lsb += w
    vals = dict(cc_present=1, discovery_mode=0, next_beacon=9, ati_present=1, abft_length=5, fss=11,
                is_responder_txss=0, next_abft=0, fragmented_txss=1, txss_span=33, n_bis_abft=2, abft_count=17,
                n_abft_in_ant=21, pcp_assoc_ready=1)
    raw_a = A.BeaconIntervalControl(**vals).to_bytes()
    fv = [vals[n] for n, _, _ in A.BIC_FIELDS]
    raw_f = F.encode_bic(F.Bic(*fv))
    assert raw_a == raw_f


# ---------------------------------------------------------------------------------- конец BTI по Duration (№5)
def test_bti_end_by_duration_same():
    """10.42.5.1: конец BTI — конец последнего DMG Beacon + его Duration; bi.bti_beacons, sls.bti_txss и
    abft.sta_bti_end дают один и тот же конец и одинаковые Duration (9.3.4.2, 9.2.5.1)."""
    beacon_len = 80
    tb = T.txtime_control(beacon_len)
    for extra in (0, Fr(37, 3)):
        bea, end = B.bti_beacons(0, [(s, 3 - i) for i, s in enumerate(range(4))], tb, bti_extra=extra)
        fr = S.bti_txss([(0, s) for s in range(4)], [4], [0], beacon_len, bti_ends=[end])[0]
        assert [b[4] for b in bea] == [f.dur for f in fr]
        assert [(b[0], b[1]) for b in bea] == [(f.t, f.end) for f in fr]
        assert [b[3] for b in bea] == [f.cdown for f in fr]
        # STA: конец BTI по Duration последнего маяка (Duration округлено вверх до мкс, 9.2.5.1)
        assert A.sta_bti_end(bea[-1][1], bea[-1][4]) - end < 1
        assert A.sta_bti_end(bea[-1][1], bea[-1][4]) >= end


# ---------------------------------------------------------------------------------- CDOWN и LBIFS (№2)
@pytest.mark.parametrize('plan', [{0: [0, 1, 2]}, {0: [0, 1, 2], 1: [4, 5]}, {0: [1], 1: [2], 3: [7, 8, 9]}])
def test_cdown_with_lbifs_same_in_sls_and_abft(plan):
    """10.42.2.3.2 «including any LBIFS if required»: LBIFS — одна передача в sls (ISS/RSS в DTI) и abft (RSS)."""
    slots = S.sweep_slots(plan)
    cd_s = S.slots_cdown(slots)
    pos = A.sweep_positions([(a, s) for a in sorted(plan) for s in plan[a]])
    cd_a = [len(pos) - 1 - i for i, x in enumerate(pos) if x is not None]
    assert cd_s == cd_a
    assert len(pos) == len(slots)


# ---------------------------------------------------------------------------------- поля: SNR, Total Sectors (№3, №6)
@pytest.mark.parametrize('snr', [-40, -13, Fr(-1250, 100), 0, 19, Fr(19125, 1000), Fr(1913, 100), 25, Fr(5075, 100),
                                 80])
def test_snr_report_same(snr):
    assert S.snr_report(snr) == F.snr_report_raw(F.snr_quantize(snr))
    assert S.snr_from_report(S.snr_report(snr)) == F.snr_from_raw(S.snr_report(snr))


def test_total_sectors_same():
    """10.42.2.2.1 (пример 24) и 9.5.3 (поле = n − 1) — одинаково в sls и fields."""
    assert S.total_sectors_in_iss({0: [0] * 4, 1: [0] * 3, 2: [0] * 5}, 2) == F.total_sectors_in_iss([4, 3, 5], 2) == 24
    for n in (1, 24, 512):
        assert S.total_sectors_in_iss_field(n) == F.total_sectors_raw(n) == n - 1
    with pytest.raises(ValueError):
        S.total_sectors_in_iss_field(513)


def test_brp_request_layout_same():
    """9.5.4 (рис. 9-850): brp.BrpRequest и fields.encode_brp_req — одно и то же поле."""
    vals = dict(l_rx=9, tx_trn_req=1, mid_req=0, bc_req=1, mid_grant=0, bc_grant=1, chan_fbck_cap=1,
                tx_sector_id=T.TX_SECTOR_NOT_SWEPT, other_aid=200, tx_antenna_id=2)
    assert P.BrpRequest(**vals).encode() == F.encode_brp_req(F.BrpReq(**vals))
    assert P.BrpRequest.parse(F.encode_brp_req(F.BrpReq(**vals))) == P.BrpRequest(**vals)


def test_cbap_source_rule_same():
    """9.4.1.46: CBAP Source = 1 при CBAP Only = 0 — нарушение и в bi, и в fields (№9)."""
    bad_b = B.check_schedule(0, 100, B.BiConfig(params=B.DmgParameters(cbap_only=0, cbap_source=1)), bti_end=100)
    ok_b = B.check_schedule(0, 100, B.BiConfig(params=B.DmgParameters(cbap_only=1, cbap_source=1)), bti_end=100)
    assert 'cbap_source' in [r for r, _ in bad_b] and 'cbap_source' not in [r for r, _ in ok_b]
    assert F.check_dmg_params(F.DmgParams(3, 0, 1))
    assert not F.check_dmg_params(F.DmgParams(3, 1, 1))


# ---------------------------------------------------------------------------------- генератор одного — судья другого
MAC_I, MAC_R = '02:00:00:00:00:01', '02:00:00:00:00:02'


def _sls_to_fields(f):
    """BfFrame sls → кадр fields (рис. 9-54…9-56)."""
    if f.kind == S.SSW:
        ssw = F.Ssw(f.direction, f.cdown, f.sector_id, f.antenna_id, f.rxss_len or 0)
        if 'total' in f.fb:
            fb = F.SswFbIss(F.total_sectors_raw(f.fb['total']), f.fb['n_rx_ant'], f.fb['poll'])
        else:
            fb = F.SswFb(f.fb['sector'] or 0, f.fb['antenna'] or 0, f.fb['snr'], f.fb['poll'])
        return F.SswFrame(f.dur, f.ra, f.ta, ssw, fb)
    fb = F.SswFb(f.fb['sector'] or 0, f.fb['antenna'] or 0, f.fb['snr'], f.fb['poll'])
    cls = F.SswFbFrame if f.kind == S.SSW_FB else F.SswAck
    return cls(f.dur, f.ra, f.ta, fb, F.BrpReq(), F.Blm())


def test_sls_frames_encode_and_parse_with_fields():
    """SLS TXSS/TXSS с двумя антеннами инициатора (LBIFS в ISS): каждый кадр генератора sls кодируется fields
    (диапазоны полей 9.5.1/9.5.3, Duration табл. 9-9), разбор возвращает те же CDOWN/сектор/антенну."""
    ch = lambda ta, a, s, ra, rxa, rxs: {(MAC_I, 1, 2): 30, (MAC_R, 0, 6): 25}.get((ta, a, s), 10)
    ini = S.Initiator(MAC_I, MAC_R, {0: [0, 1, 2, 3], 1: [0, 1, 2]})
    rsp = S.Responder(MAC_R, MAC_I, {0: [5, 6, 7]})
    ini.start(0)
    log = S.SlsLink(ini, rsp, ch).run(10 ** 7)
    assert [f.kind for f in log].count(S.SSW) == 7 + 3 and log[-1].kind == S.SSW_ACK
    for f in log:
        b = F.encode_frame(_sls_to_fields(f))
        assert len(b) == f.length
        g = F.parse_frame(b, strict=True)
        assert g.duration == f.dur
        if f.kind == S.SSW:
            assert (g.ssw.cdown, g.ssw.sector_id, g.ssw.antenna_id) == (f.cdown, f.sector_id, f.antenna_id)
    # ISS: Total Sectors = 7 (LBIFS не входит, 10.42.2.2.1), поле = 6 (9.5.3)
    assert F.parse_frame(F.encode_frame(_sls_to_fields(log[0]))).fb.total_sectors == 6
    assert S.check_sls_log(log) == []


def _abft_run(n_stas=2, fss=8, slots=8):
    bic = B.BeaconIntervalControl(abft_length=slots - 1, fss=fss - 1)
    cfg = B.BiConfig(bic)
    tb = T.txtime_control(80)
    bea, end = B.bti_beacons(0, [(s, 3 - s) for s in range(4)], tb)
    per = B.layout(0, 100, cfg, end)
    pa = [p for p in per if p.kind == 'A-BFT'][0]
    bic_a = A.BeaconIntervalControl.decode(A.BeaconIntervalControl(abft_length=slots - 1, fss=fss - 1,
                                                                   is_responder_txss=1).encode())
    L = A.AbftLayout.from_bic(bic_a, end)
    assert L.start == pa.start and L.end == pa.end
    stas = [A.Responder(f'02:00:00:00:01:0{i}', plan=[(0, k) for k in range(6)] + [(1, k) for k in range(3)],
                        rng=SeqRng([2 * i + 1, 0, 0, 0])) for i in range(n_stas)]
    ap = A.ApAbft('02:00:00:00:00:aa', L)
    bcn = A.BeaconRx(bic_a, ap.addr, best=(5, 0, 40))
    log = A.simulate_abft(ap, stas, {s.addr: bcn for s in stas})
    return bea, end, cfg, ap, L, log


def test_abft_generator_passes_bi_judge():
    """Журнал A-BFT генератора abft (слоты, FSS, SBIFS/LBIFS, SSW-Feedback, Duration) + маяки bi.bti_beacons —
    судья bi.check_air_log не находит нарушений: одна сетка слотов и одни допуски (№1, №4, №5)."""
    bea, end, cfg, ap, L, log = _abft_run()
    assert any(f.kind == 'SSW-Feedback' for f in log)
    ev = [(a, b, ap.addr, T.BCAST, 'DMG Beacon', d, dict(sector=s, cdown=c)) for a, b, s, c, d in bea]
    ev += [(f.t, f.end, f.src, f.dst, f.kind, f.duration, dict(antenna=f.ant_id)) for f in log]
    # STA меняет DMG-антенну внутри RSS → LBIFS (10.3.2.3.11) — судья bi принимает только при смене антенны
    assert any(b.t - a.end == T.LBIFS for a, b in zip(log, log[1:]) if a.src == b.src and a.kind == b.kind == 'SSW')
    aids = {ap.addr: 0, **{f.src: i + 1 for i, f in enumerate(x for x in log if x.kind == 'SSW')}}
    bss = B.Bss(ap.addr, aids, 100, {0: cfg}, sectors={0, 1, 2, 3})
    assert B.check_air_log(ev, bss) == []
    assert A.check_abft_log(log, L, ap.addr) == []
    # та же пауза LBIFS без смены антенны — нарушение у обоих судей
    same = [e if e[4] != 'SSW' else e[:6] + (dict(antenna=0),) for e in ev]
    assert 'abft_sbifs' in {v.rule for v in B.check_air_log(same, bss)}


def test_bi_generator_passes_abft_judge():
    """Обратное: A-BFT из bi.generate_bi проходит abft.check_abft_log (поля SSW генератор bi не задаёт — только
    моменты, отправитель/получатель и FSS)."""
    bic = B.BeaconIntervalControl(abft_length=7, fss=7)
    bss = B.Bss('ap', {'ap': 0, 's1': 1, 's2': 2}, 100, {0: B.BiConfig(bic)})
    log, per = B.generate_bi(0, bss, [(0, 1), (1, 0)], T.txtime_control(80), abft_ssw=[(1, 's1', 8), (4, 's2', 3)])
    pa = [p for p in per if p.kind == 'A-BFT'][0]
    L = A.AbftLayout(pa.start, 8, 8)
    frames = [A.AirFrame(e[4], e[0], e[2], e[3], direction=1 if e[4] == 'SSW' else None) for e in log
              if e[4] in ('SSW', 'SSW-Feedback')]
    assert A.check_abft_log(frames, L, 'ap') == []
    assert B.check_air_log(log, bss) == []


def test_abft_ssw_fields_encode_with_fields():
    """Кадры SSW/SSW-Feedback генератора abft кодируются fields: CDOWN ≤ 511, Sector ID ≤ 63, Antenna ID ≤ 3,
    Direction = 1 (RSS), SNR — по общему правилу №6."""
    _, _, _, ap, L, log = _abft_run(n_stas=1)
    for f in log:
        if f.kind == 'SSW':
            fr = F.SswFrame(f.duration, f.dst, f.src, F.Ssw(f.direction, f.cdown, f.sector_id, f.ant_id),
                            F.SswFb(f.sector_select, f.ant_select, S.snr_report(f.snr), f.poll))
        else:
            fr = F.SswFbFrame(f.duration, f.dst, f.src,
                              F.SswFb(f.sector_select or 0, f.ant_select or 0, S.snr_report(f.snr or 0)),
                              F.BrpReq(), F.Blm())
        assert len(F.encode_frame(fr)) == f.length


def test_max_bf_time_same():
    """10.42.1 «within dot11MaxBFTime beacon intervals»: SLS (T2) и BRP — одно чтение N·BI от начала (№11)."""
    bi_us = 100 * T.TU
    assert P.bf_brp_expired(0, T.DOT11_MAX_BF_TIME * bi_us + 1, bi_us)
    assert not P.bf_brp_expired(0, T.DOT11_MAX_BF_TIME * bi_us, bi_us)
