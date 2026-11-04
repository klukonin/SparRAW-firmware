# SPDX-License-Identifier: AGPL-3.0-or-later
"""Тесты направленного эфира DMG (medium.py): ожидания из 802.11-2020 — табл. 20-3, 20.4.4.2.2, 20.5.4.2.2, 20.8,
20.9.1, 10.42.1, 9.5.1, табл. 20-30; правило захвата — выбор модели (докстрока medium.py)."""
from fractions import Fraction as Fr

import pytest

from . import medium as M
from .timing import SBIFS, SIFS, aAirPropagationTime, txtime


def _two(gain_ab=-60, rx_b=(0, None), **kw):
    m = M.Medium(**kw)
    m.add_station('A')
    m.add_station('B', rx_cfg=rx_b)
    m.set_gain('A', M.ANY, 'B', M.ANY, gain_ab)
    return m


def _f(src='A', dst='B', mcs=1, kind='Data', length=100):
    return M.DmgFrame(kind, src, dst, length=length, mcs=mcs)


# ---------------- табл. 20-3 и пороги CCA ----------------
def test_sensitivity_table_20_3():
    # 20.3.3.8, табл. 20-3
    assert M.sensitivity(0) == -78 and M.sensitivity(1) == -68 and M.sensitivity(4) == -64
    assert M.sensitivity(6) == -63 and M.sensitivity(12) == -53
    assert M.sensitivity('9.1') == -57 and M.sensitivity(9.1) == -57 and M.sensitivity('12.6') == -42
    assert M.sensitivity(25) == -64 and M.sensitivity(26) == -60
    with pytest.raises(KeyError):
        M.sensitivity(13)            # OFDM DMG — нет в табл. 20-3


def test_cca_constants():
    assert M.CCA_CONTROL_DBM == -68                  # 20.4.4.2.2
    assert M.CCA_SC_DBM == -68                       # 20.5.4.2.2: «MCS 1 (–68 dBm)»
    assert M.CCA_ED_DBM == -48                       # 20.5.4.2.2: «20 dB above»
    assert M.CCA_DETECT_MAX == {'control': 3, 'sc': 1}
    assert M.MAX_PROP_ONE_WAY == aAirPropagationTime / 2


@pytest.mark.parametrize('mcs', list(range(0, 13)))
def test_sensitivity_boundary_per_mcs(mcs):
    """Табл. 20-3: на уровне чувствительности — принят, на 1 дБ ниже — нет."""
    s = M.sensitivity(mcs)
    for g, ok in ((s, True), (s - 1, False)):
        m = _two(gain_ab=g)
        p = m.transmit('A', _f(mcs=mcs))
        m.run(1000)
        assert (p.receivers == ['B']) is ok, (mcs, g, p.rx['B'])
        if not ok:
            # SC ниже −68 — нет синхронизации; выше — заголовок есть, данные не декодированы
            assert p.rx['B'].reason in ('sensitivity', 'no-lock')


# ---------------- секторы и квази-омни ----------------
def test_tx_sector_selection_changes_reception():
    m = M.Medium()
    m.add_station('A', antennas={0: 8})
    m.add_station('B')
    m.set_gain('A', M.sec(5), 'B', M.qo(), -60)
    m.set_gain('A', M.sec(6), 'B', M.qo(), -90)
    p5 = m.transmit('A', _f(), t=0, tx_cfg=M.sec(5))
    p6 = m.transmit('A', _f(), t=10, tx_cfg=M.sec(6))
    m.run(100)
    assert p5.receivers == ['B'] and p6.receivers == []
    assert p6.rx['B'].reason == 'no-lock'


def test_sector_sweep_finds_best_sector():
    """10.42.1/10.42.2: TXSS — SSW через разные секторы, приёмник квази-омни; принятые — с хорошим усилением."""
    gains = {0: -90, 1: -76, 2: -62, 3: -70}
    m = M.Medium()
    m.add_station('A', antennas={0: 4})
    m.add_station('B')
    for s, g in gains.items():
        m.set_gain('A', M.sec(s), 'B', M.qo(), g)
    t, ents = Fr(0), []
    for s in range(4):
        f = M.DmgFrame('SSW', 'A', 'B', length=26, mcs=0, fields={'sector_id': s, 'cdown': 3 - s})
        ents.append(m.transmit('A', f, t=t, tx_cfg=M.sec(s)))
        t += f.airtime + SBIFS
    m.run(t + 10)
    got = {e.fields['sector_id']: e.rx['B'].power for e in ents if 'B' in e.receivers}
    assert set(got) == {1, 2, 3}                     # −90 ниже табл. 20-3 MCS 0 (−78)
    assert max(got, key=got.get) == 2


def test_quasi_omni_vs_rx_sector():
    m = M.Medium()
    m.add_station('A')
    m.add_station('B', antennas={0: 8})
    m.set_gain('A', M.ANY, 'B', M.qo(), -75)
    m.set_gain('A', M.ANY, 'B', M.sec(3), -60)
    # квази-омни: control (MCS 0, −78) принят, SC MCS 4 (−64) — нет
    c = m.transmit('A', _f(mcs=0, kind='RTS', length=20), t=0)
    d = m.transmit('A', _f(mcs=4), t=20)
    m.run(40)
    assert c.receivers == ['B'] and d.receivers == []
    # приёмный сектор к A — MCS 4 принят
    m.set_rx('B', M.sec(3))
    d2 = m.transmit('A', _f(mcs=4), t=50)
    m.run(100)
    assert d2.receivers == ['B'] and d2.rx['B'].rx_cfgs == [(0, 3)]


def test_rx_sector_pointing_elsewhere_misses():
    """10.3.4.2: приёмник, направленный на другую STA, кадр не слышит."""
    m = M.Medium()
    for a in 'ABC':
        m.add_station(a, antennas={0: 8})
    m.set_gain('A', M.ANY, 'C', M.sec(1), -55)
    m.set_gain('B', M.ANY, 'C', M.sec(2), -55)
    m.set_rx('C', M.sec(2))
    pa = m.transmit('A', _f(dst='C'), t=0)
    pb = m.transmit('B', _f(dst='C'), t=10)
    m.run(50)
    assert pa.receivers == [] and pb.receivers == ['C']


def test_rx_cfg_change_mid_ppdu_loses_frame():
    m = M.Medium()
    m.add_station('A')
    m.add_station('B', antennas={0: 8})
    m.set_gain('A', M.ANY, 'B', M.qo(), -60)
    m.set_gain('A', M.ANY, 'B', M.sec(7), -95)
    p = m.transmit('A', _f(), t=0)
    m.set_rx('B', M.sec(7), t=1)
    m.run(50)
    assert p.receivers == [] and p.rx['B'].reason == 'sensitivity'


def test_receiver_off():
    m = _two()
    m.set_rx('B', None)
    p = m.transmit('A', _f())
    m.run(50)
    assert p.rx['B'].reason in ('off', 'no-lock') and not p.rx['B'].decoded


def test_quasi_omni_15db_rule():
    """20.9.1: квази-омни не более чем на 15 дБ ниже направленного."""
    m = M.Medium()
    m.add_station('A', antennas={0: 4})
    m.add_station('B')
    m.set_gain('A', M.sec(0), 'B', M.qo(), -50)
    m.set_gain('A', M.qo(), 'B', M.qo(), -64)
    assert M.check_quasi_omni(m) == []
    m.set_gain('A', M.qo(), 'B', M.qo(), -66)
    assert M.check_quasi_omni(m) == [('A', (0, None), 'B', (0, None), -66, -50)]


def test_reciprocal_and_wildcards():
    m = M.Medium()
    m.add_station('A', antennas={0: 4})
    m.add_station('B', antennas={0: 4})
    m.set_gain('A', M.sec(1), 'B', M.sec(2), -50, reciprocal=True)
    m.set_gain('A', M.ANY, 'B', M.ANY, -80)
    assert m.link_gain('B', (0, 2), 'A', (0, 1)) == -50
    assert m.link_gain('A', (0, 1), 'B', (0, 2)) == -50
    assert m.link_gain('A', (0, 3), 'B', (0, 2)) == -80
    assert m.link_gain('B', (0, 3), 'A', (0, 1)) == M.NEG_INF


# ---------------- ограничения антенн (10.42.1, 9.5.1) ----------------
def test_antenna_limits():
    m = M.Medium()
    with pytest.raises(ValueError):
        m.add_station('X', antennas={0: 65})                 # > 64 на антенну
    with pytest.raises(ValueError):
        m.add_station('Y', antennas={0: 64, 1: 64, 2: 1})    # > 128 всего
    with pytest.raises(ValueError):
        m.add_station('Z', antennas={4: 1})                  # DMG Antenna ID 2 бита
    m.add_station('W', antennas={0: 64, 1: 64})
    m.add_station('V', antennas={0: 4})
    with pytest.raises(ValueError):
        m.set_gain('V', M.sec(5), 'W', M.qo(), -50)          # нет сектора 5
    with pytest.raises(ValueError):
        m.set_rx('V', (1, None))                             # нет антенны 1


# ---------------- коллизии и захват (выбор модели) ----------------
def _three(ga=-55, gc=-55, **kw):
    m = M.Medium(**kw)
    for a in 'ABC':
        m.add_station(a)
    m.set_gain('A', M.ANY, 'B', M.ANY, ga)
    m.set_gain('C', M.ANY, 'B', M.ANY, gc)
    return m


def test_collision_equal_power_both_lost():
    m = _three()
    pa = m.transmit('A', _f(), t=0)
    pc = m.transmit('C', _f(src='C'), t=1)
    m.run(50)
    assert pa.receivers == [] and pc.receivers == []
    assert pa.rx['B'].reason == pc.rx['B'].reason == 'collision'


def test_capture_stronger_survives():
    m = _three(ga=-50, gc=-60)
    pa = m.transmit('A', _f(), t=1)
    pc = m.transmit('C', _f(src='C'), t=0)          # слабый пришёл раньше — порядок не важен
    m.run(50)
    assert pa.receivers == ['B'] and pc.receivers == []


def test_capture_margin_param():
    m = _three(ga=-50, gc=-60, capture_db=10)
    pa = m.transmit('A', _f(), t=0)
    m.transmit('C', _f(src='C'), t=0)
    m.run(50)
    assert pa.receivers == []                        # 10 дБ — не строго больше порога захвата


def test_no_overlap_back_to_back():
    m = _three()
    pa = m.transmit('A', _f(), t=0)
    pc = m.transmit('C', _f(src='C'), t=_f().airtime)   # [s, e) — касание не перекрытие
    m.run(50)
    assert pa.receivers == ['B'] and pc.receivers == ['B']


def test_directional_spatial_reuse():
    """Рис. 10-19 / 10.3.4.2: направленные пары без взаимного усиления работают одновременно."""
    m = M.Medium()
    for a in 'ABCD':
        m.add_station(a)
    m.set_gain('A', M.ANY, 'B', M.ANY, -55)
    m.set_gain('C', M.ANY, 'D', M.ANY, -55)
    p1 = m.transmit('A', _f(), t=0)
    p2 = m.transmit('C', _f(src='C', dst='D'), t=0)
    m.run(50)
    assert p1.receivers == ['B'] and p2.receivers == ['D']
    assert m.cca_info('B', 1)[1] == ['locked:#1'] and m.cca_info('D', 1)[1] == ['locked:#2']


# ---------------- полудуплекс ----------------
def test_half_duplex_transmitter_cannot_receive():
    m = M.Medium()
    m.add_station('A')
    m.add_station('B')
    m.set_gain('A', M.ANY, 'B', M.ANY, -50, reciprocal=True)
    pa = m.transmit('A', _f(), t=0)
    pb = m.transmit('B', _f(src='B', dst='A'), t=2)     # B начал передачу посреди приёма
    m.run(50)
    assert pa.rx['B'].reason == 'half-duplex' and pb.rx['A'].reason == 'half-duplex'
    assert pa.receivers == [] and pb.receivers == []


def test_own_ppdu_overlap_rejected():
    m = _two()
    m.transmit('A', _f(), t=0)
    m.transmit('A', _f(), t=1)
    with pytest.raises(RuntimeError):
        m.run(50)


# ---------------- CCA ----------------
@pytest.mark.parametrize('mcs,level,busy', [
    (1, -67, True),      # 20.5.4.2.2: > −68 дБм — обязательно занято
    (4, -67, True),      # SC любой MCS: заголовок обнаружен (данные MCS 4 не декодируются)
    (1, -69, False),
    (0, -67, True),      # 20.4.4.2.2: > −68 дБм — обязательно занято
    (0, -77, True),      # выбор модели: control декодируем с −78 (табл. 20-3) ⇒ занят
    (0, -79, False),
])
def test_cca_threshold(mcs, level, busy):
    m = _two(gain_ab=level)
    m.transmit('A', _f(mcs=mcs, length=40))
    m.run(Fr(1, 2))
    assert m.cca('B') is busy
    m.run(100)
    assert m.cca('B') is False


@pytest.mark.parametrize('level,busy', [(-49, False), (-48, True)])
def test_cca_missed_preamble_energy_threshold(level, busy):
    """Пропущенная преамбула (STA передавала в начале чужого PPDU): только −48 дБм (20.5.4.2.2)."""
    m = M.Medium()
    m.add_station('A')
    m.add_station('B')
    m.set_gain('A', M.ANY, 'B', M.ANY, level)
    short = M.DmgFrame('RTS', 'B', 'A', length=20, mcs=0)
    m.transmit('B', short, t=0)
    m.transmit('A', _f(length=4000), t=1)
    m.run(short.airtime + 1)
    assert m.cca_info('B')[1] == ([f'ed:#2'] if busy else [])


def test_cca_locked_holds_until_end_after_rx_change():
    """20.8: после верного заголовка CCA не IDLE до ожидаемого конца PPDU."""
    m = M.Medium()
    m.add_station('A')
    m.add_station('B', antennas={0: 4})
    m.set_gain('A', M.ANY, 'B', M.qo(), -60)
    p = m.transmit('A', _f(length=2000), t=0)
    m.set_rx('B', M.sec(1), t=1)                   # к A усиления нет
    m.run(2)
    assert m.cca_info('B') == (True, ['locked:#1'])
    m.run(p.t_end + 1)
    assert m.cca('B') is False and p.receivers == []


def test_cca_transmitter_busy():
    m = _two()
    p = m.transmit('A', _f())
    m.run(1)
    assert m.cca_info('A') == (True, ['tx'])
    m.run(p.t_end)
    assert m.cca('A') is False


# ---------------- задержка распространения (табл. 20-30) ----------------
def test_propagation_delay():
    m = _two()
    d = aAirPropagationTime / 2
    m.set_delay('A', 'B', d)
    p = m.transmit('A', _f(), t=0)
    m.run(100)
    assert p.rx['B'].arr == (d, p.t_end + d) and p.receivers == ['B']
    with pytest.raises(ValueError):
        m.set_delay('A', 'B', aAirPropagationTime)
    with pytest.raises(ValueError):
        M.Medium(prop=aAirPropagationTime)


# ---------------- агенты и журнал ----------------
class _Responder:
    """Отвечает Ack через SIFS на декодированный кадр (обмен Data/Ack, 10.3.2.3.3)."""
    def __init__(self, m, addr):
        self.m, self.addr, self.ev = m, addr, []

    def on_rx_start(self, t, e, p):
        self.ev.append(('rx_start', t, e.n))

    def on_rx_end(self, t, e, f, res):
        self.ev.append(('rx_end', t, e.n, f is not None))
        if f is not None and f.kind == 'Data':
            self.m.transmit(self.addr, M.DmgFrame('Ack', self.addr, e.src, length=14, mcs=0), t=t + SIFS)

    def on_tx_end(self, t, e):
        self.ev.append(('tx_end', t, e.n))

    def on_cca(self, t, busy):
        self.ev.append(('cca', t, busy))


def test_agent_exchange_and_log():
    m = M.Medium()
    a = _Responder(m, 'A')
    b = _Responder(m, 'B')
    m.add_station('A', agent=a)
    m.add_station('B', agent=b)
    m.set_gain('A', M.ANY, 'B', M.ANY, -55, reciprocal=True)
    f = _f(mcs=4, length=500)
    p = m.transmit('A', f, t=0)
    log = m.run(100)
    assert [e.kind for e in log] == ['Data', 'Ack']
    ack = log[1]
    assert ack.t_start == p.t_end + SIFS and ack.receivers == ['A']
    assert ack.t_end == ack.t_start + txtime(14, 0)
    assert b.ev == [('rx_start', 0, 1), ('cca', 0, True), ('rx_end', p.t_end, 1, True), ('cca', p.t_end, False),
                    ('cca', ack.t_start, True), ('tx_end', ack.t_end, 2), ('cca', ack.t_end, False)]
    assert m.air_log() == [(0, p.t_end, 'A', 'B', 'Data', 0, None),
                           (ack.t_start, ack.t_end, 'B', 'A', 'Ack', 0, None)]
    assert p.tx_cfg == (0, None) and p.fields == {}


def test_timer_and_set_tx():
    m = M.Medium()
    m.add_station('A', antennas={0: 4})
    m.add_station('B')
    m.set_gain('A', M.sec(2), 'B', M.ANY, -55)
    m.set_tx('A', M.sec(2), t=5)
    out = []
    m.at(5, lambda t: out.append(m.transmit('A', _f(), t=t)))
    m.run(50)
    assert out[0].tx_cfg == (0, 2) and out[0].receivers == ['B'] and out[0].t_start == 5
