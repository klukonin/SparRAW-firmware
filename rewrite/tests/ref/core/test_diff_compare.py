# SPDX-License-Identifier: AGPL-3.0-or-later
"""Сравнитель по эфиру (этап 2): юнит — синтетические журналы (журнал ядра с внесённым отличием) → верный аспект и
класс; интеграция — ядро против ядра по сценариям diff_scenario (0 расхождений, в т. ч. с другим seed), отчёт (текст,
JSON) строится. Прошивка не нужна: сторона «эмулятор» имитируется флагом Side.emulator и описанием кадра модели MAC
('ответ на …', 'queue …'), как в снимке air.Air."""
import json
from fractions import Fraction as Fr

import pytest

from .. import fields as F
from . import diff_compare as DC
from . import diff_report as DR
from .diff_scenario import SCENARIOS, Scenario
from .scenario import AP_ADDR


@pytest.fixture(scope='module')
def base(RB):
    """Журнал ядра сценария sls-1sta: снимок и Air — основа синтетических журналов."""
    scn = SCENARIOS['sls-1sta']
    b = DR.run_core(scn)
    assert b.done_ok
    return scn, b.journal


def _side(scn, j, RB, label, emulator=False, edit=None):
    """Сторона из журнала ядра; edit(snap) меняет снимок (кадры — dict ref_bridge2.snapshot) до разбора."""
    snap = j.to_snapshot(AP_ADDR, scn.bi_tu)
    names = {F.mac_bytes(m): n for n, m in j.nodes.items()}
    if edit:
        edit(snap)
    air = DC.snapshot_air(snap, F.mac_bytes(AP_ADDR), names)
    if not emulator:
        # приёмники — из журнала ядра (snapshot их не несёт): кадры совпадают по времени и передатчику
        rx = {(r.t, r.node): tuple(sorted(r.receivers)) for r in j.recs}
        for e in air.events:
            e.rx_nodes = rx.get((e.t, e.tx_node), e.rx_nodes)
    return DC.Side(label, air, snap, AP_ADDR, scn.bi_tu, RB=RB, emulator=emulator)


def _frames(snap, kind):
    out = []
    for f in snap['frames']:
        _, k, first, act = DC.AP.classify(bytes(f['frame']), bool(f['mpdus']))
        if k == kind or act == kind:
            out.append(f)
    return out


def _set_dur(f, d):
    raw = bytearray(f['frame'])
    raw[2:4] = d.to_bytes(2, 'little')
    f['frame'], f['dur_us'] = bytes(raw), d
    if f['mpdus']:
        f['mpdus'][0] = bytes(raw)


def _shift(f, us):
    from ..timing import CLK_MHZ
    f['start'] += us * CLK_MHZ
    f['end'] += us * CLK_MHZ


def _diffs(scn, j, RB, edit, emulator=False, side='A'):
    A = _side(scn, j, RB, 'A', emulator=emulator, edit=edit if side == 'A' else None)
    B = _side(scn, j, RB, 'B', edit=edit if side == 'B' else None)
    return DC.compare(A, B, scn.n_sta)


def _find(diffs, aspect, sub):
    return [d for d in diffs if d.aspect == aspect and sub in d.key]


# ------------------------------------------------------------------------------------------------- синтетика
def test_identical_journals_no_diffs(base, RB):
    scn, j = base
    assert _diffs(scn, j, RB, None) == []


def test_ack_duration_fw(base, RB):
    """Duration Ack ≠ 9.2.5.7 у стороны A (кадр строит прошивка) → судьи: «прошивка ≠ стандарт»."""
    scn, j = base

    def edit(snap):
        for f in _frames(snap, 'Ack'):
            _set_dur(f, 40)
    d = _diffs(scn, j, RB, edit)
    dj = _find(d, 'судьи', 'dur_resp')
    assert dj and all(x.cls == DC.FW_STD for x in dj), [(x.key, x.cls) for x in d]
    assert all(x.cls != DC.CORE_STD for x in d)


def test_ack_duration_emulator_model(base, RB):
    """То же, но Ack собирает модель MAC эмулятора ('ответ на …') → «модель MAC эмулятора» с точкой разгрузки."""
    scn, j = base

    def edit(snap):
        for f in _frames(snap, 'Ack'):
            _set_dur(f, 40)
            f['what'] = 'ответ на queue 0x1a'
    d = _diffs(scn, j, RB, edit, emulator=True)
    dj = _find(d, 'судьи', 'dur_resp')
    assert dj and all(x.cls == DC.MODEL and x.hyp == DC.H_RESP for x in dj), [(x.key, x.cls, x.hyp) for x in dj]


def test_core_violation(base, RB):
    """Отличие внесено в журнал ядра (сторона B) → «ядро ≠ стандарт»."""
    scn, j = base

    def edit(snap):
        for f in _frames(snap, 'Ack'):
            _set_dur(f, 40)
    d = _diffs(scn, j, RB, edit, side='B')
    dj = _find(d, 'судьи', 'dur_resp')
    assert dj and all(x.cls == DC.CORE_STD for x in dj)


def test_rts_duration_queue_model(base, RB):
    """Duration RTS — остаток лимита TXOP (H-DURQ) у эмулятора: Duration первого кадра обмена — «модель MAC
    эмулятора» с H-DURQ."""
    scn, j = base

    def edit(snap):
        for f in _frames(snap, 'RTS'):
            _set_dur(f, 1982)
    d = _diffs(scn, j, RB, edit, emulator=True)
    dd = _find(d, 'Duration', 'первый кадр обмена: STA>AP RTS')
    assert dd and all(x.cls == DC.MODEL and x.hyp == DC.H_DURQ for x in dd), [(x.key, x.cls, x.hyp) for x in d]


def test_sifs_gap_fw_and_model(base, RB):
    """Ответ DMG CTS позже SIFS + допуск (10.3.2.3.3): у прошивки — «прошивка ≠ стандарт», у ответа модели MAC —
    «модель MAC эмулятора»."""
    scn, j = base

    def late(model):
        def edit(snap):
            for f in _frames(snap, 'DMG CTS'):
                _shift(f, Fr(3, 2))
                if model:
                    f['what'] = 'ответ на direct 20 B'
        return edit
    d = _diffs(scn, j, RB, late(False))
    g = _find(d, 'промежутки', 'RTS → AP>STA DMG CTS')
    assert g and g[0].cls == DC.FW_STD, [(x.aspect, x.key, x.cls) for x in d]
    d = _diffs(scn, j, RB, late(True), emulator=True)
    g = _find(d, 'промежутки', 'RTS → AP>STA DMG CTS')
    assert g and g[0].cls == DC.MODEL and g[0].hyp == DC.H_RESP


def test_cf_end_ra_other_node(base, RB):
    """RA CF-End держателя — не партнёр обмена и не широковещательный (9.3.1.6) → поле, «прошивка ≠ стандарт»."""
    scn, j = base

    def edit(snap):
        f = next(f for f in _frames(snap, 'CF-End') if int.from_bytes(f['frame'][2:4], 'little'))
        raw = bytearray(f['frame'])
        raw[4:10] = bytes.fromhex('020000000999')
        f['frame'] = bytes(raw)
    d = _diffs(scn, j, RB, edit)
    x = _find(d, 'поля', 'RA = партнёр обмена')
    assert x and x[0].cls == DC.FW_STD and x[0].clause == '9.3.1.6', [(y.key, y.cls) for y in d]


def test_bss_parameter_choice_undetermined(base, RB):
    """FSS в BI Control другой у всех маяков (выбор точки, сценарий не навязывает прошивке) → «неопределённо»
    (поле и параметр BSS), без нарушений судей — если A-BFT в журнале нет."""
    scn, j = base

    def edit(snap):
        for f in _frames(snap, 'DMG Beacon'):
            p = F.parse_dmg_beacon(bytes(f['frame']), with_fcs=False)
            bic = p.bic._replace(fss=p.bic.fss - 4)
            f['frame'] = F.encode_dmg_beacon(p._replace(bic=bic), with_fcs=False, role='ap', pcp=False,
                                             rx_antennas=1)
    d = _diffs(scn, j, RB, edit)
    assert _find(d, 'поля', 'BIC.fss') and _find(d, 'параметры BSS', 'A-BFT')
    assert all(x.cls == DC.UNDEF for x in d if x.aspect in ('поля', 'параметры BSS')), \
        [(x.aspect, x.key, x.cls) for x in d]


def test_exchange_signature_missing_ack(base, RB):
    """Нет Ack на Association Request у стороны A → обмены: сигнатура «Association Request» различается."""
    scn, j = base

    def edit(snap):
        fr = snap['frames']
        i = next(k for k, f in enumerate(fr) if DC.AP.classify(bytes(f['frame']))[1] == 'Association Request')
        del fr[i + 1]
    d = _diffs(scn, j, RB, edit)
    assert _find(d, 'обмены', '«Association Request»'), [(x.aspect, x.key) for x in d]


def test_classify_order():
    assert DC.classify(True, True, 'h', 'i') == DC.CORE_STD
    assert DC.classify(True, False, 'h', 'i') == DC.MODEL
    assert DC.classify(True, False, '', 'i') == DC.INTERP
    assert DC.classify(True, False, '', '') == DC.FW_STD
    assert DC.classify(False, False, '', '') == DC.UNDEF


def test_signature_folding():
    toks = ['S>A RTS', 'A>S DMG CTS', 'S>A A-MPDU', 'A>S BlockAck', 'S>A A-MPDU', 'A>S BlockAck', 'S>A CF-End',
            'A>S CF-End']
    assert DC.signature(toks) == 'S>A RTS → A>S DMG CTS → (S>A A-MPDU → A>S BlockAck)+ → S>A CF-End → A>S CF-End'
    assert DC.signature(['S>A SSW-ISS'] * 4 + ['A>S SSW-RSS'] * 4) == 'S>A SSW-ISS+ → A>S SSW-RSS+'


# ------------------------------------------------------------------------------------------------- интеграция
@pytest.mark.parametrize('name', ['abft-1sta', 'sls-1sta', 'sls-1sta-dl', 'sls-1sta-both', 'sls-1sta-burst',
                                  'sls-1sta-bi10'])
def test_core_vs_core_zero(name, RB):
    """Ядро против ядра — 0 расхождений; с другим seed (иная отсрочка) — тоже (сравнение по смыслу)."""
    scn = SCENARIOS[name]
    for seed in (None, scn.seed + 10):
        A, B, d = DR.core_vs_core(scn, RB, seed=seed)
        assert A.meta['done'] and B.meta['done']
        assert d == [], DR.to_text(scn, A, B, d)


def test_core_vs_core_two_sta_only_hidden_station(RB):
    """2 станции: единственное — «начат во время чужого кадра» у обеих сторон, и только там, где передатчик чужой
    развёртки не слышал (направленная скрытая станция): класс «трактовка» (судья моста считает, что слышат все)."""
    scn = SCENARIOS['sls-2sta']
    A, B, d = DR.core_vs_core(scn, RB)
    assert all(x.cls == DC.INTERP and 'busy' in x.key for x in d), DR.to_text(scn, A, B, d)


def test_report_text_json(RB):
    scn = SCENARIOS['sls-1sta']
    A, B, d = DR.core_vs_core(scn, RB)
    txt = DR.to_text(scn, A, B, d)
    assert txt.startswith('=== Сценарий sls-1sta') and 'сводка:' in txt
    js = json.loads(json.dumps(DR.to_json(scn, A, B, d), ensure_ascii=False))
    assert js['summary'] == {c: 0 for c in DC.CLASSES} and js['scenario']['name'] == 'sls-1sta'


def test_scenarios_cover_task():
    """Набор: A-BFT, SLS в DTI, 2 станции, трафик вниз/вверх/оба, короткий BI; лимит TXOP AC_BE 2048."""
    s = list(SCENARIOS.values())
    assert any(x.bf == 'abft' for x in s) and any(x.bf == 'dti' for x in s)
    assert any(x.n_sta == 2 for x in s)
    assert any(x.ul_bytes and not x.dl_bytes for x in s) and any(x.dl_bytes and not x.ul_bytes for x in s)
    assert any(x.ul_bytes and x.dl_bytes for x in s)
    assert any(x.bi_tu <= 10 for x in s)
    assert all(x.txop_be_us == 2048 for x in s)
    assert isinstance(s[0], Scenario) and s[0].limits()
