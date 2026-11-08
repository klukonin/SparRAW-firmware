# SPDX-License-Identifier: AGPL-3.0-or-later
"""Интеграция 3 (rewrite/docs/ARCHITECTURE.md, этап 3): смешанные пары в одном эмулированном эфире — ядро DMG MAC на
адаптере Sparrow (adapter_sparrow) и прошивка (CoSim fw + uc): точка-ядро + станция-прошивка и точка-прошивка +
станция-ядро. Соединение (SLS в DTI, ассоциация, BRP, ADDBA), данные в обе стороны, судьи на журнале эфира, отчёт
расхождений. Нужна сборка прошивки (SPARRAW_UNIT_BUILD или conftest.build_dir).

Найденное (ref/core/README.md, «Этап 3»): станция-ядро с умолчаниями ядра (preset 'core') точку-прошивку срывает —
uc точки опаздывает с ответом через SIFS на кадр, пришедший вскоре после SLS/ассоциации, и не подтверждает короткий
кадр управления на MCS 1 от ассоциированной станции; с выбором реализации ближе к узлам прошивки (preset 'compat')
пара проходит целиком. Тест «как ядро» для этой пары — xfail (strict): когда прошивка исправится, он станет XPASS."""
import pytest

pytestmark = pytest.mark.xdist_group('mixed_pairs')


def _run(scn_name, role, fw_elf, build_dir, uc_fw, preset):
    import sparrow_scenario as SS
    from ref.core.diff_scenario import SCENARIOS
    scn = SCENARIOS[scn_name]
    return scn, SS.run_mixed(scn, role, fw_elf, build_dir, uc_fw, **SS.PRESETS[preset])


def _side(scn, r):
    import ref_bridge2 as RB
    from ref.core import diff_report as DR
    role = r.kind.split('-')[1]
    return DR.sparrow_side_from(scn, r, RB, 'пара', 'mixed', core_nodes=('AP',) if role == 'ap' else ('STA',))


@pytest.fixture(scope='module')
def ap_core(fw_elf, build_dir, uc_fw):
    """Точка-ядро (умолчания ядра) + станция-прошивка, данные в обе стороны."""
    return _run('sls-1sta-both', 'ap', fw_elf, build_dir, uc_fw, 'core')


@pytest.fixture(scope='module')
def sta_core_compat(fw_elf, build_dir, uc_fw):
    """Точка-прошивка + станция-ядро (preset compat), данные в обе стороны."""
    return _run('sls-1sta-both', 'sta', fw_elf, build_dir, uc_fw, 'compat')


def _assert_complete(scn, r):
    assert r.gap is None and not r.notes, r.notes
    assert r.done
    assert r.delivered['ul'][0] == r.delivered['ul'][1] > 0 and r.delivered['dl'][0] == r.delivered['dl'][1] > 0, \
        r.delivered


def test_ap_core_sta_fw_connects_and_data(ap_core):
    scn, r = ap_core
    _assert_complete(scn, r)
    # станция-прошивка подключилась (WMI_CONNECT_EVENT), точка-ядро — State 4
    core = r.core_nodes[0]
    assert core.core.associated()


def test_sta_core_ap_fw_connects_and_data(sta_core_compat):
    scn, r = sta_core_compat
    _assert_complete(scn, r)
    assert r.core_sme.state == 'data'


@pytest.mark.parametrize('pair', ['ap_core', 'sta_core_compat'])
def test_mixed_phases_and_judges(pair, request):
    """Обе пары проходят одни фазы (SLS, ассоциация, ADDBA, TXOP данных, BRP); судьи по журналу эфира работают,
    нарушения разнесены по передатчику (ядро/прошивка); кадры ответов узла ядра — модель MAC ('ответ на')."""
    scn, r = request.getfixturevalue(pair)
    S = _side(scn, r)
    kinds = {x.kind for x in S.exchanges}
    assert {'SLS', 'Association Request', 'Association Response', 'ADDBA Request', 'TXOP данных'} <= kinds, kinds
    assert 'нарушения судей по передатчику' in S.meta
    core_name = S.core_nodes[0]
    assert any(e.by_mac and e.tx_node == core_name for e in S.evs)


def test_mixed_report_builds(ap_core):
    """Отчёт «смешанная пара против ядра в идеальной среде» строится; расхождения, подтверждённые судьёй на кадрах
    узла ядра без допущения модели, — класс «ядро на Sparrow ≠ стандарт»."""
    import json

    import ref_bridge2 as RB
    from ref.core import diff_compare as DC
    from ref.core import diff_report as DR
    scn, r = ap_core
    A = _side(scn, r)
    B = DR.core_side(scn, RB)
    diffs = DR.compare_sides(scn, A, B)
    txt = DR.to_text(scn, A, B, diffs)
    js = json.loads(json.dumps(DR.to_json(scn, A, B, diffs), ensure_ascii=False))
    assert 'сводка:' in txt and set(js['summary']) == set(DC.CLASSES)
    assert not [d for d in diffs if d.cls == DC.CORE_STD]


@pytest.mark.xfail(strict=True, reason='прошивка: точка срывается на станции-ядре с умолчаниями ядра — поздний ответ '
                   'через SIFS (uc_assert 0x26/0x6019) на кадр вскоре после SLS/ассоциации и нет Ack на короткий '
                   'кадр управления MCS 1 (ref/core/README.md, «Этап 3»)')
def test_sta_core_defaults_ap_fw(fw_elf, build_dir, uc_fw):
    scn, r = _run('sls-1sta', 'sta', fw_elf, build_dir, uc_fw, 'core')
    assert r.gap is None and not r.notes and r.done, r.notes
