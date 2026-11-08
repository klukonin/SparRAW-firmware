# SPDX-License-Identifier: AGPL-3.0-or-later
"""Адаптер Sparrow (этап 3, rewrite/docs/ARCHITECTURE.md): юнит — правила модели MAC для точек разгрузки (ответ через
SIFS, Duration H-DURQ, отсрочка H-BACKOFF, NAV, Timestamp маяка) и синхронизация узлов ядра в air.Air; интеграция без
прошивки — точка и станция на ядре поверх адаптера соединяются и гоняют данные, сравнение с ядром в идеальной среде
относит все расхождения к модели MAC (ни «ядро ≠ стандарт», ни «ядро на Sparrow ≠ стандарт»). Сборка прошивки не
нужна."""
import pytest

import machw as MH
from adapter_sparrow import (CLK, SPARROW_CAPS, TSF0_US, CoreNode, MixedAir, fc_of, is_queue, response_kind,
                             snapshot)

from ref import fields as F
from ref.core import frames as FR
from ref.core import offload as O
from ref.core.ap import DmgApMac
from ref.core.sta import DmgStaMac

A, B, C3 = '02:00:00:00:00:0a', '02:00:00:00:00:0b', '02:00:00:00:00:0c'
MA = F.mac_bytes(A)


def test_response_kind():
    """Кому и чем отвечает MAC (air.Air._tx: uni): RTS → DMG CTS, A-MPDU данных → BlockAck, данные с Normal Ack и
    кадр управления → Ack; No Ack, Action No Ack, групповой и чужой RA — без ответа."""
    qd = FR.qos_data(0, A, B, B, 1, b'x' * 10, 0, 1)
    assert response_kind([FR.rts(10, A, B)], False, MA) == 'cts'
    assert response_kind([qd, qd], True, MA) == 'ba'
    assert response_kind([qd], False, MA) == 'ack'
    assert response_kind([FR.qos_data(0, A, B, B, 1, b'x', 0, 1, ackpol=1)], False, MA) is None
    assert response_kind([FR.mgmt('Action', 0, A, B, B, 0, b'\x03\x00')], False, MA) == 'ack'
    assert response_kind([FR.mgmt('Action No Ack', 0, A, B, B, 0, b'\x14\x01')], False, MA) is None
    assert response_kind([FR.qos_data(0, 'ff:ff:ff:ff:ff:ff', B, B, 1, b'x', 0, 1)], False, MA) is None
    assert response_kind([FR.rts(10, C3, B)], False, MA) is None
    assert is_queue(qd) and is_queue(FR.mgmt('Action', 0, A, B, B, 0, b'')) and not is_queue(FR.rts(1, A, B))


def _node(cls=DmgStaMac, addr=A, name='N'):
    n = CoreNode(cls, F.mac_bytes(addr), name, 4, seed=1)
    MixedAir([], [n])
    return n


def test_caps_and_time_axis():
    """Набор разгрузки Sparrow; часы узла ядра — TSF эмулятора (τ = TSF0 + такт/165, H-SYNC)."""
    n = _node()
    assert SPARROW_CAPS.offload == O.SPARROW and n.core.off == O.SPARROW
    assert isinstance(n.core.nav, O.OffloadNav)
    assert n.sim.now == TSF0_US and n.clk(TSF0_US + 2) == 2 * CLK and n.tau(165) == TSF0_US + 1


def test_nav_from_frames_not_for_me():
    """NAV MAC: кадр не себе — конец PPDU + Duration (air.Air._tx nav_us); кадр себе NAV не меняет; DMG CTS на RTS
    при занятом NAV — только держателю (10.3.2.9)."""
    n = _node()
    t0 = n.clk(n.sim.now) + 100
    rts = FR.rts(300, C3, B)
    n.rx_ppdu(t0, t0 + 2000, [rts], False, 0)
    n.run_until(t0 + 3000)
    assert n.nav_end == t0 + 2000 + 300 * CLK and n.nav_holder == B
    assert n.core.nav.busy(n.tau(t0 + 2100)) and not n.core.nav.idle_for_rts(n.tau(t0 + 2100), C3)
    assert n.core.nav.idle_for_rts(n.tau(t0 + 2100), B)
    end0 = n.nav_end
    n.rx_ppdu(t0 + 3000, t0 + 5000, [FR.rts(900, A, B)], False, 0)
    n.run_until(t0 + 6000)
    assert n.nav_end == end0                     # RTS себе: NAV не меняется


@pytest.fixture(scope='module')
def pair():
    import sparrow_scenario as SS
    from ref.core.diff_scenario import SCENARIOS
    scn = SCENARIOS['sls-1sta-both']
    r = SS.run_core(scn)
    return scn, r


def test_core_pair_on_sparrow_completes(pair):
    """Точка и станция на ядре поверх адаптера: SLS, ассоциация, ADDBA, данные в обе стороны."""
    scn, r = pair
    assert r.done and not r.notes and r.gap is None, r.notes
    assert r.sta_smes[0].rx_bytes() >= scn.dl_bytes
    assert sum(len(x.data) for x in r.ap_sme.rx) >= scn.ul_bytes


def test_offload_points_in_air(pair):
    """Точки разгрузки видны в эфире: ответы собирает MAC через SIFS + MACLAT (H-RESPCMD), Duration RTS — остаток
    лимита TXOP (H-DURQ), Timestamp маяка — TSF начала PPDU (H-BIC), кадры очереди помечены 'queue'."""
    scn, r = pair
    fr = sorted(r.snapshot['frames'], key=lambda f: f['start'])
    resp = [(p, f) for p, f in zip(fr, fr[1:]) if f['what'].startswith('ответ на')]
    assert {fc_of(f['frame']) for _, f in resp} >= {0x00d4, 0x0094, 0x0564}
    assert all(f['start'] - p['end'] == MH.SIFS_CLK + MH.MACLAT_CLK for p, f in resp)
    assert all(fc_of(f['frame']) != 0x00d4 or f['dur_us'] == 0 for _, f in resp)      # Ack: Duration 0 (H-RESPCMD)
    lim = scn.txop_be_us
    for f in fr:
        if fc_of(f['frame']) == 0x00b4:
            assert f['dur_us'] == (lim * CLK - MH.SIFS_CLK - (f['end'] - f['start'])) // CLK
        if f['frame'][0] == 0x0c:
            assert int.from_bytes(f['frame'][0xa:0x12], 'little') == TSF0_US + f['start'] // CLK
        if is_queue(f['frame']):
            assert f['what'].startswith('queue ')


def test_backoff_slots(pair):
    """H-BACKOFF: доступ кадра очереди после чужой занятости — конец занятости + AIFS_CLK + k·SLOT_CLK (вверх до
    такта; k ≤ BACKOFF_CW), если NAV свободен."""
    scn, r = pair
    fr = sorted(r.snapshot['frames'], key=lambda f: f['start'])
    n = 0
    for p, f in zip(fr, fr[1:]):
        gap = f['start'] - p['end']
        if not f['what'].startswith('queue') or p['src'] == f['src'] or p['frame'][0] == 0x0c or \
                gap > MH.AIFS_CLK + MH.BACKOFF_CW * MH.SLOT_CLK + 1 or fc_of(p['frame']) == 0x0564:
            continue                             # продолжение своего TXOP (данные после DMG CTS) — не доступ
        k, rem = divmod(gap - MH.AIFS_CLK, MH.SLOT_CLK)
        assert 0 <= k <= MH.BACKOFF_CW and rem <= 1, (p['what'], f['what'], gap)
        n += 1
    assert n


def test_sparrow_vs_ideal_all_model(pair, RB):
    """Ядро на Sparrow против ядра в идеальной среде: расхождения — модель MAC (точки разгрузки) или неопределённые,
    ни одного «ядро ≠ стандарт» / «ядро на Sparrow ≠ стандарт»."""
    from ref.core import diff_compare as DC
    from ref.core import diff_report as DR
    scn, r = pair
    A_ = DR.sparrow_side_from(scn, r, RB, 'ядро-Sparrow', 'core')
    B_ = DR.core_side(scn, RB)
    d = DR.compare_sides(scn, A_, B_)
    bad = [(x.aspect, x.key, x.cls) for x in d if x.cls in (DC.CORE_STD, DC.SPARROW_CORE, DC.FW_STD)]
    assert not bad, bad
    assert sum(1 for x in d if x.cls == DC.MODEL) >= 10
    keys = {x.key for x in d if x.cls == DC.MODEL}
    assert any('Duration' in k for k in keys) and any('SIFS' in k for k in keys)


def test_snapshot_nodes(pair):
    scn, r = pair
    s = snapshot(r.air)
    assert set(s['nodes']) == {c.mac for c in r.core_nodes}
    for v in s['nodes'].values():
        assert v['tbtt_us'] % v['bi_us'] == 0 and v['tsf0_us'] == TSF0_US


@pytest.fixture(scope='module')
def RB():
    import ref_bridge2
    return ref_bridge2


def test_core_ap_alone_beacons():
    """Точка-ядро одна в эфире: TBTT — TSF, кратный BI (11.1.3.3.1), маяки BTI с шагом TXTIME + SBIFS."""
    ap = CoreNode(DmgApMac, F.mac_bytes(A), 'AP', 8, seed=1)
    air = MixedAir([], [ap])
    from ref.core import sap_mlme as ML
    ap.sim.at(ap.sim.now, ap.core.mlme_request, ML.MlmeStartRequest(SSID=b'x', BeaconPeriod=100, abft_slots=2,
                                                                       fss_frames=8))
    air.run_us(30_000)
    bs = [f for f in air.frames if f['frame'][0] == 0x0c]
    assert len(bs) == 8
    assert (TSF0_US + bs[0]['start'] // CLK) % (100 * 1024) == 0
    assert all(b['start'] - a['end'] in (MH.SBIFS_CLK, MH.SBIFS_CLK + 1) for a, b in zip(bs, bs[1:]))
