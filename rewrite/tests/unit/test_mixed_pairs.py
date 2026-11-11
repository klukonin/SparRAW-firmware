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


def _sc_mgmt_to(r, src, dst_mac):
    """Индивидуально адресованные кадры управления узла src на SC PHY (MCS ≥ 1) к dst_mac: (индекс, кадр)."""
    out = []
    for i, f in enumerate(r.air.frames):
        b = f['frame']
        fc = int.from_bytes(b[:2], 'little')
        if f['src'] is src and (fc >> 2) & 3 == 0 and f['mcs'] >= 1 and b[4:10] == bytes(dst_mac) and \
                (fc >> 4) & 0xf != 14:                        # Action No Ack (подтип 14) Ack не требует
            out.append((i, f))
    return out


def test_ap_core_sc_mgmt_acked_first_try(ap_core):
    """Короткий кадр управления точки-ядра на SC PHY (Association Response ~4,8 мкс, Action ADDBA Response ~3,4 мкс)
    станция на нашем uc подтверждает с первой попытки: 802.11-2020 10.3.2.11 — Ack на индивидуально адресованный кадр
    через SIFS; следующий PPDU в эфире — Ack станции точке, начало — до AckTimeout (aSIFSTime + aSlotTime +
    aRxPHYStartDelay, 10.3.2.11; точное начало ответа MAC — допущение модели H-RESPCMD), повторов кадра (Retry,
    9.2.4.1.4) нет. Было: uc станции входит в rx_flow_run, когда PPDU уже кончился, и ветка рассинхронизации счётчика
    PPDU (трасса 0xeeee04) считает кадр «без события» — Ack нет, ядро добирается повтором (ref/core/README.md,
    «Этап 3»)."""
    from fractions import Fraction as Fr

    from ref.cbap import response_timeout
    scn, r = ap_core
    core, fw = r.core_nodes[0], r.fw_nodes[0]
    fr = r.air.frames
    sc = _sc_mgmt_to(r, core, fw.mac)
    assert len(sc) >= 2, 'нет кадров управления SC точки-ядра к станции'
    bad = []
    for i, f in sc:
        fc = int.from_bytes(f['frame'][:2], 'little')
        what = 'подтип %d %.2f мкс на %.1f мкс' % ((fc >> 4) & 0xf, (f['end'] - f['start']) / 165, f['start'] / 165)
        if fc & (1 << 11):
            bad.append('повтор: ' + what)
            continue
        nxt = fr[i + 1] if i + 1 < len(fr) else None
        nb = nxt['frame'] if nxt else b''
        if not nxt or nxt['src'] is not fw or int.from_bytes(nb[:2], 'little') != 0x00d4 or nb[4:10] != bytes(core.mac):
            bad.append('нет Ack: ' + what)
            continue
        gap = Fr(nxt['start'] - f['end'], 165)
        if gap > response_timeout(f['mcs']):
            bad.append('Ack через %.2f мкс: %s' % (float(gap), what))
    assert not bad, bad
    assert not r.late, r.late


def _tick_before_access(delta_clk):
    """setup run_mixed: тик L1 станции-прошивки (таймер ARC 0, период LIMIT + 1) — за delta_clk тактов до начала
    доступа точки-ядра (событие отсрочки H-BACKOFF — момент начала её кадра очереди). Фаза тика относительно кадров
    пира на железе любая; здесь — худшие, когда тик начинается перед коротким кадром."""
    import math

    def setup(core, fw):
        orig = core.offload_access_request

        def req():
            had = core.bo_ev
            orig()
            ev = core.bo_ev
            if ev is not None and ev is not had:
                t = math.ceil(core.clk(ev.t)) - delta_clk
                tm = fw.hw.timers[0]
                if t > fw.hw.now:
                    tm.t0 = t
                    tm._arm()
        core.offload_access_request = req
    return setup


@pytest.mark.parametrize('delta', [0, 120, 240])
def test_ap_core_sc_mgmt_acked_tick_before_frame(fw_elf, build_dir, uc_fw, delta):
    """То же, что test_ap_core_sc_mgmt_acked_first_try, когда тик L1 станции (таймер ARC 0, вектор 3, тот же уровень
    L1, что busy_event) начинается за delta тактов до кадра точки: было (vendor-порядок) — тик ~330 тактов целиком,
    вход rx_flow_run позже конца короткого кадра SC, ветка 0xeeee04, ни одного Ack на ADDBA Response и uc_assert
    0x26/0x6002 (так срывались ветки fix/cbap-end-nav, feat/lm-info). 802.11-2020 10.3.2.11."""
    import sparrow_scenario as SS
    from ref.core.diff_scenario import SCENARIOS
    from fractions import Fraction as Fr

    from ref.cbap import response_timeout
    r = SS.run_mixed(SCENARIOS['sls-1sta-both'], 'ap', fw_elf, build_dir, uc_fw, setup=_tick_before_access(delta),
                     **SS.PRESETS['core'])
    assert r.gap is None and not r.notes and r.done, r.notes
    core, fw = r.core_nodes[0], r.fw_nodes[0]
    fr = r.air.frames
    sc = _sc_mgmt_to(r, core, fw.mac)
    bad, near = [], 0
    for i, f in sc:
        fc = int.from_bytes(f['frame'][:2], 'little')
        ticks = [t for t, n in fw.hw.irq_log if n == 3 and t <= f['start'] + 10]
        near += bool(ticks) and f['start'] - ticks[-1] <= delta + 10
        nxt = fr[i + 1] if i + 1 < len(fr) else None
        ok = (nxt is not None and nxt['src'] is fw and nxt['frame'][:2] == b'\xd4\x00' and not fc & (1 << 11) and
              Fr(nxt['start'] - f['end'], 165) <= response_timeout(f['mcs']))
        if not ok:
            bad.append('подтип %d на %.1f мкс' % ((fc >> 4) & 0xf, f['start'] / 165))
    assert near >= 2, 'тик не встал перед кадрами точки'
    assert not bad, bad
    assert not r.late, r.late


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


def test_sta_core_defaults_ap_fw(fw_elf, build_dir, uc_fw):
    """Станция-ядро с умолчаниями ядра и точка-прошивка: соединение и данные. Прежде — xfail (точка срывалась: поздний
    ответ через SIFS, uc_assert 0x26/0x6019, ref/core/README.md «Этап 3»): модель засчитывала команду ответа 0x37000020
    через ~40 мкс после кадра поздним ответом. С допущением H-RESPEXP (machw: окно ответа MAC — не дольше 10 мкс от конца
    кадра; стенд — RTS без DMG CTS 1,6–2,4 % под iperf без FWERR) такая команда — уже не ответ: Ack нет, пир повторяет
    кадр, соединение идёт. Поздняя команда uc на этих путях остаётся (README, строка про 43 мкс после SSW-Ack)."""
    scn, r = _run('sls-1sta', 'sta', fw_elf, build_dir, uc_fw, 'core')
    assert r.gap is None and not r.notes and r.done, r.notes
