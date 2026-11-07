# SPDX-License-Identifier: AGPL-3.0-or-later
"""Интеграция 2 (rewrite/docs/ARCHITECTURE.md, этап 2): прошивка в эмуляторе (fw_scenario) против ядра DMG MAC в
идеальной среде (ref/core) на одном сценарии — отчёт расхождений строится, прогон доходит до данных, точки разгрузки
модели MAC классифицируются как «модель MAC эмулятора». Все сценарии и отчёт —
`python3 -m ref.core.diff_report --scenario all --build <dir>` (ref/core/README.md, «Этап 2»)."""
import json

import pytest

pytestmark = pytest.mark.xdist_group('fw_diff')


@pytest.fixture(scope='module')
def fw_vs_core(fw_elf, build_dir, uc_fw):
    import fw_scenario as FS
    import ref_bridge2 as RB
    from ref.core import diff_report as DR
    from ref.core.diff_scenario import SCENARIOS
    scn = SCENARIOS['sls-1sta']
    r = FS.run(scn, fw_elf, build_dir, uc_fw)
    A = DR.fw_side_from(scn, r.snapshot, RB, FS, meta=dict(notes=list(r.notes)))
    B = DR.core_side(scn, RB)
    return dict(scn=scn, run=r, A=A, B=B, diffs=DR.compare_sides(scn, A, B), DR=DR)


def test_fw_run_reaches_data(fw_vs_core):
    """Прошивка прошла сценарий: станция подключилась, данные доставлены, эмуляция без срыва."""
    r = fw_vs_core['run']
    assert r.gap is None and not r.notes, r.notes
    assert fw_vs_core['B'].meta['done']


def test_report_builds(fw_vs_core):
    from ref.core import diff_compare as DC
    x = fw_vs_core
    txt = x['DR'].to_text(x['scn'], x['A'], x['B'], x['diffs'])
    js = json.loads(json.dumps(x['DR'].to_json(x['scn'], x['A'], x['B'], x['diffs']), ensure_ascii=False))
    assert 'сводка:' in txt
    assert set(js['summary']) == set(DC.CLASSES) and sum(js['summary'].values()) == len(x['diffs'])
    assert all(d.cls in DC.CLASSES and d.aspect in DC.ASPECTS for d in x['diffs'])


def test_both_sides_same_phases(fw_vs_core):
    """Обе стороны прошли одни фазы: SLS в DTI, ассоциация, ADDBA, TXOP данных."""
    for S in (fw_vs_core['A'], fw_vs_core['B']):
        kinds = {x.kind for x in S.exchanges}
        assert {'SLS', 'Association Request', 'Association Response', 'ADDBA Request', 'TXOP данных'} <= kinds, \
            (S.label, kinds)


def test_offload_points_are_model(fw_vs_core):
    """Точки разгрузки Sparrow (ARCHITECTURE.md §2) — «модель MAC эмулятора», не «прошивка ≠ стандарт»: Duration RTS
    (H-DURQ) и сроки ответов через SIFS (ответы собирает модель MAC)."""
    from ref.core import diff_compare as DC
    d = fw_vs_core['diffs']
    rts = [x for x in d if x.aspect == 'Duration' and 'первый кадр обмена' in x.key and 'RTS' in x.key]
    assert rts and all(x.cls == DC.MODEL and x.hyp == DC.H_DURQ for x in rts)
    sifs = [x for x in d if x.aspect == 'промежутки' and 'SIFS (ответ)' in x.key]
    assert sifs and all(x.cls == DC.MODEL for x in sifs), [(x.key, x.cls) for x in sifs]
    assert not [x for x in d if x.cls == DC.FW_STD and x.hyp]
