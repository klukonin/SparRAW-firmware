# SPDX-License-Identifier: AGPL-3.0-or-later
"""Юнит-тесты ядра: кадры, PSDU, событийное время, идеальная среда (CCA, коллизии, полудуплекс, задержка), EDCA
(слоты, заморозка счётчика), SAP-примитивы, точки разгрузки, форматы журнала."""
from fractions import Fraction as Fr

import pytest

from .. import blockack as BA
from .. import cbap as C
from .. import fields as F
from ..timing import AID_BROADCAST, MBIFS, SIFS, aSlotTime, txtime, txtime_control
from . import frames as FR
from . import offload as O
from . import sap_mac as MS
from . import sap_mlme as ML
from . import sap_phy as P
from .journal import Journal
from .mac import DmgMac, la_mcs, response_timeout
from .medium_ideal import IdealMedium
from .sim import P_END, P_MAC, P_START, Sim

A, B = '02:00:00:00:00:0a', '02:00:00:00:00:0b'


# ------------------------------------------------------------------------------------------------ кадры
def test_control_frame_lengths():
    """Рис. 9-26/9-28/9-34/9-41/9-52: длины MPDU без FCS."""
    assert len(FR.rts(10, A, B)) == 16
    assert len(FR.ack(0, A)) == 10
    assert len(FR.cf_end(0, A, B)) == 16
    assert len(FR.blockack(0, A, B, 0, 5, 1)) == 28
    assert len(FR.dmg_cts(0, A, B)) == 16
    for raw, kind in ((FR.rts(1, A, B), 'RTS'), (FR.ack(0, A), 'Ack'), (FR.cf_end(0, A, B), 'CF-End'),
                      (FR.blockack(0, A, B, 0, 0, 0), 'BlockAck'), (FR.dmg_cts(0, A, B), 'DMG CTS')):
        f = FR.classify(raw)
        assert f.kind == kind and f.ra == A
        assert F.check_fc(f.fc) == []


def test_blockack_control_compressed():
    """Табл. 9-28: DMG — Compressed (Multi-TID 0, Compressed 1, GCR 0), резерв BA Control = 0 (рис. 9-42)."""
    raw = FR.blockack(0, A, B, 0, 100, 0b101)
    ctl = int.from_bytes(raw[16:18], 'little')
    assert (ctl >> 1 & 1, ctl >> 2 & 1, ctl >> 3 & 3) == (0, 1, 0) and ctl & 0x0FE1 == 0
    assert BA.parse_ba_info(raw[18:28]) == (100, 0b101)


def test_psdu_fcs_and_ampdu_roundtrip():
    """9.2.4.8 FCS; 9.7.1 A-MPDU: разделитель, дополнение до 4 октетов, без дополнения у последнего подкадра."""
    m1 = FR.qos_data(5, A, B, A, 1, b'x' * 7, 1, 0)
    m2 = FR.qos_data(5, A, B, A, 2, b'y' * 9, 1, 0)
    ps = FR.psdu([m1, m2], True)
    assert len(ps) == FR.ampdu_len([len(m1), len(m2)])
    assert FR.split_psdu(ps, True) == [(m1, True), (m2, True)]
    bad = bytearray(ps)
    bad[10] ^= 1
    assert [ok for _, ok in FR.split_psdu(bytes(bad), True)] == [False, True]
    single = FR.psdu([m1], False)
    assert FR.split_psdu(single, False) == [(m1, True)]


def test_qos_data_fields():
    """Рис. 9-63, табл. 9-11: SN, TID 0, Ack Policy 00, Retry."""
    m = FR.qos_data(0, A, B, A, 77, b'abc', 1, 0, retry=1)
    assert FR.qos_fields(m)[:4] == (77, 0, 0, 1)
    assert FR.classify(m).kind == 'QoS Data'


def test_edca_parameter_set_roundtrip():
    """9.4.2.28: ACI/AIFSN, ECWmin/ECWmax, TXOP Limit ×32 мкс."""
    p = {0: (3, 15, 1023, 2048), 1: (7, 15, 1023, 0), 2: (2, 7, 15, 0), 3: (2, 3, 7, 0)}
    el = FR.edca_parameter_set(p)
    assert el[0] == 12 and el[1] == 18
    assert FR.parse_edca_parameter_set(el[2:]) == p


# ------------------------------------------------------------------------------------------------ время
def test_sim_order_end_before_start_before_mac():
    s, out = Sim(), []
    s.at(5, out.append, 'mac', prio=P_MAC)
    s.at(5, out.append, 'start', prio=P_START)
    s.at(5, out.append, 'end', prio=P_END)
    s.run(10)
    assert out == ['end', 'start', 'mac']
    with pytest.raises(ValueError):
        s.at(1, out.append, 'past')


# ------------------------------------------------------------------------------------------------ среда
class Probe:
    """PhySapUser-заглушка: записывает примитивы."""
    def __init__(self, sim):
        self.sim, self.log = sim, []

    def __getattr__(self, name):
        if name.startswith('phy_'):
            return lambda *a: self.log.append((self.sim.now, name, a))
        raise AttributeError(name)

    def kinds(self):
        return [n for _, n, _ in self.log]


def _medium(prop=Fr(1, 100)):
    s = Sim()
    m = IdealMedium(s, prop)
    pa, pb, pc = Probe(s), Probe(s), Probe(s)
    phy_a = m.attach('A', A, [0, 1, 2, 3], pa)
    phy_b = m.attach('B', B, [0, 1, 2, 3], pb)
    phy_c = m.attach('C', '02:00:00:00:00:0c', [0, 1, 2, 3], pc)
    m.link('A', 'B', -40, 1, 2)
    m.link('A', 'C', -40, 0, 0)
    m.link('B', 'C', -40, 0, 0)
    return s, m, (phy_a, phy_b, phy_c), (pa, pb, pc)


def _tx(phy, mpdu, mcs=0, beam=P.QUASI_OMNI):
    ps = FR.psdu([mpdu], False)
    phy.phy_txstart_request(P.TxVector(MCS=mcs, LENGTH=len(ps), ANT_CONFIG=beam))
    phy.phy_data_request(ps)
    phy.phy_txend_request()


def test_medium_delivery_cca_and_delay():
    """PHY-CCA BUSY в начале у приёмника (задержка распространения), PHY-RXSTART через aRxPHYStartDelay, PSDU и
    PHY-RXEND(NoError) в конце, CCA IDLE; у передатчика — PHY-TXEND.confirm через TXTIME."""
    s, m, (a, b, c), (pa, pb, pc) = _medium()
    raw = FR.rts(10, B, A)
    _tx(a, raw, beam=P.Beam(1))
    s.run(1000)
    T = txtime_control(20)
    assert [x for x in pa.kinds() if x == 'phy_txend_confirm'] and pa.log[-1][0] == T
    assert pb.kinds() == ['phy_cca_indication', 'phy_rxstart_indication', 'phy_data_indication',
                          'phy_rxend_indication', 'phy_cca_indication']
    t = [x[0] for x in pb.log]
    assert t[0] == Fr(1, 100) and t[1] == Fr(1, 100) + P.rx_start_delay(0) and t[3] == T + Fr(1, 100)
    assert FR.split_psdu(pb.log[2][2][0], False) == [(raw, True)]
    assert pb.log[3][2] == (P.NO_ERROR,)
    rxv = pb.log[1][2][0]
    assert rxv.MCS == 0 and rxv.SNR == 30            # −40 − 10 (квази-омни приёмника) + 80
    assert m.journal.recs[0].receivers == {'B', 'C'}


def test_medium_collision_spoils_both():
    """Перекрытие у приёмника — оба PPDU испорчены (FCS не сходится), CCA занята до конца обоих."""
    s, m, (a, b, c), (pa, pb, pc) = _medium()
    _tx(a, FR.rts(10, '02:00:00:00:00:0c', A))
    s.at(2, lambda: _tx(b, FR.rts(10, '02:00:00:00:00:0c', B)))
    s.run(1000)
    datas = [x[2][0] for x in pc.log if x[1] == 'phy_data_indication']
    assert all(not ok for d in datas for _, ok in FR.split_psdu(d, False))
    assert not m.journal.recs[0].receivers and not m.journal.recs[1].receivers


def test_medium_half_duplex_and_sensitivity():
    """Уровень ниже чувствительности MCS (но выше порога синхронизации SC) — PHY-RXEND(FormatViolation) без данных;
    узел, начавший передачу во время прихода PPDU, его не принимает (полудуплекс)."""
    s, m, (a, b, c), (pa, pb, pc) = _medium()
    m.link('A', 'B', -55, 1, 2)                       # квази-омни приёмника: −65 дБм ≥ −68 (синхр.), < −53 (MCS 12)
    _tx(a, FR.qos_data(0, B, A, B, 0, b'z' * 100, 0, 1), mcs=12, beam=P.Beam(1))
    s.run(1000)
    assert ('phy_rxend_indication', (P.FORMAT_VIOLATION,)) in [(n, a) for _, n, a in pb.log]
    assert 'phy_data_indication' not in pb.kinds()
    s, m, (a, b, c), (pa, pb, pc) = _medium()
    m.links.pop(('A', 'B')), m.links.pop(('B', 'A'))
    _tx(a, FR.rts(10, '02:00:00:00:00:0c', A))
    s.at(12, lambda: _tx(c, FR.rts(10, B, '02:00:00:00:00:0c')))
    s.run(1000)
    assert 'C' not in m.journal.recs[0].receivers and 'phy_data_indication' not in pc.kinds()


def test_beam_quality_function():
    """Качество луча: лучший сектор — без штрафа, соседние — по step_db, квази-омни — qo_loss_db."""
    s, m, *_ = _medium()
    best = m.level('A', P.Beam(1), 'B', P.Beam(2))
    assert best == -40
    assert m.level('A', P.Beam(2), 'B', P.Beam(2)) == -43
    assert m.level('A', P.QUASI_OMNI, 'B', P.Beam(2)) == -50


# ------------------------------------------------------------------------------------------------ EDCA
def _mac_on_medium():
    s, m, (a, b, c), (pa, pb, pc) = _medium()
    mac = DmgMac(s, A, 4, seed=1)
    mac.phy = a
    a.mac = mac
    mac.set_cbap(0, 10 ** 6)
    return s, m, mac


def test_edca_slot_boundary_and_freeze():
    """10.23.2.4: доступ — опорная + AIFS + k·aSlotTime; занятость замораживает счётчик, уменьшения засчитываются
    за прошедшие границы слотов."""
    s, m, mac = _mac_on_medium()
    ed = mac.acs[C.AC_BE].ed
    s.run(1)
    mac._idle_ref = Fr(0)
    ed.backoff = 5
    mac._freeze(C.aifs(3) + 2 * aSlotTime + Fr(1, 2))  # прошли границы AIFS, +1, +2 → три уменьшения
    assert ed.backoff == 2
    ed.backoff = 5
    mac._freeze(C.aifs(3) - 1)
    assert ed.backoff == 5


def test_edca_access_time_and_internal_priority():
    """Кадр управления (AC_VO, AIFSN 2) при счётчике 0 — на границе AIFS[AC_VO] после свободной среды."""
    s, m, mac = _mac_on_medium()
    s.run(100)
    t0 = []
    mac._phy_tx = lambda *a, **k: (t0.append(s.now), None)[1]
    mac.send_mgmt('Action', B, lambda t: bytes(9))
    s.run(200)
    assert t0 and (t0[0] - C.aifs(2)) % aSlotTime == 0 and t0[0] >= 100


def test_response_timeout_and_la():
    """10.3.2.11: AckTimeout = SIFS + aSlotTime + aRxPHYStartDelay; адаптация MCS монотонна по SNR."""
    assert response_timeout(0) == SIFS + aSlotTime + 10
    assert response_timeout(0, MBIFS) == MBIFS + aSlotTime + 10
    assert la_mcs(40) == 12 and la_mcs(0) == 1 and la_mcs(20) <= la_mcs(30)


# ------------------------------------------------------------------------------------------------ SAP, разгрузка
def test_sap_primitive_names():
    """Имена примитивов — по стандарту (6.3.x); MAC-SAP — 5.2; PHY-SAP — 8.3.5."""
    for name in ('MLME-START.request', 'MLME-SCAN.confirm', 'MLME-JOIN.request', 'MLME-ASSOCIATE.indication',
                 'MLME-ASSOCIATE.response', 'MLME-ADDBA.request', 'MLME-ADDBA.confirm', 'MLME-BF-TRAINING.request',
                 'MLME-BF-TRAINING.indication'):
        assert name in ML.PRIMITIVES
    assert ML.MlmeAddbaRequest.CLAUSE == '6.3.27.2' and ML.MlmeBfTrainingRequest().RequestBRP is False
    r = MS.MaUnitdataRequest(A, B, b'1')
    assert r.service_class == MS.QOS_ACK and r.priority == 0
    for meth in ('phy_txstart_request', 'phy_data_request', 'phy_txend_request', 'phy_ccareset_request',
                 'phy_config_request'):
        assert hasattr(P.PhySap, meth)
    for meth in ('phy_txstart_confirm', 'phy_data_confirm', 'phy_txend_confirm', 'phy_cca_indication',
                 'phy_rxstart_indication', 'phy_data_indication', 'phy_rxend_indication'):
        assert hasattr(P.PhySapUser, meth)
    assert P.data_symbol_offset(1) < P.data_symbol_offset(0)


def test_offload_sets():
    """Этап 3: пустой набор — идеальная среда; набор Sparrow принят; SSW_SWEEP — этап 4; SIFS_RESPONSE без
    BA_SCOREBOARD (и наоборот) — отказ: BlockAck — ответ через SIFS."""
    assert O.require_supported(O.AdapterCaps()).offload == O.IDEAL
    assert set(O.TABLE) == {f for f in O.Offload if f is not O.Offload.NONE}
    assert O.require_supported(O.AdapterCaps('sparrow', O.SPARROW)).offload == O.SPARROW
    for bad in (O.Offload.SSW_SWEEP, O.Offload.SIFS_RESPONSE, O.Offload.BA_SCOREBOARD):
        with pytest.raises(NotImplementedError):
            DmgMac(Sim(), A, caps=O.AdapterCaps('sparrow', bad))


class _OffPhy:
    """PHY адаптера-заглушки: PhySap + OffloadSap, без эфира; записывает вызовы ядра."""
    def __init__(self, sim, nav_end=0):
        self.sim, self.calls, self.nav_end, self.tx = sim, [], Fr(nav_end), []
        self.dur = None

    def phy_config_request(self, v):
        pass

    def phy_txstart_request(self, txv):
        self.txv = txv
        self.mac.phy_txstart_confirm(P.TxStatus())

    def phy_data_request(self, d):
        self.tx.append((self.sim.now, self.txv, bytes(d)))
        self.mac.phy_data_confirm()

    def phy_txend_request(self):
        if self.dur is not None:
            self.mac.offload_duration(self.dur)
        self.sim.after(P.ppdu_time(self.txv), self.mac.phy_txend_confirm)

    def offload_access_request(self):
        self.calls.append(('access', self.sim.now))

    def offload_nav_busy(self, t):
        return self.nav_end > t

    def offload_nav_idle_from(self):
        return self.nav_end

    def offload_nav_idle_for_rts(self, t, ta):
        return not self.offload_nav_busy(t)


def _off_mac(nav_end=0):
    sim = Sim()
    mac = DmgMac(sim, A, caps=O.AdapterCaps('sparrow', O.SPARROW))
    phy = _OffPhy(sim, nav_end)
    phy.mac = mac
    mac.phy = phy
    mac.set_cbap(0, 10 ** 6)
    return sim, mac, phy


def _rx(mac, mpdu, mcs=1):
    psdu = FR.psdu([mpdu], False)
    mac.phy_rxstart_indication(P.RxVector(MCS=mcs, LENGTH=len(psdu), SNR=20.0))
    mac.phy_data_indication(psdu)
    mac.phy_rxend_indication(P.NO_ERROR)


def test_offload_sifs_response_not_sent_by_core():
    """SIFS_RESPONSE: на кадр управления и RTS себе ядро не передаёт Ack/DMG CTS — их передаёт адаптер; NAV — адаптера
    (OffloadNav), обновлений по кадрам у ядра нет."""
    sim, mac, phy = _off_mac()
    assert isinstance(mac.nav, O.OffloadNav)
    sim.run(10)
    _rx(mac, FR.mgmt('Action', 7, A, B, B, 0, bytes([3, 0, 1, 2, 0x10, 0, 0, 0, 0])))
    _rx(mac, FR.rts(100, A, B), 0)
    sim.run(100)
    assert phy.tx == [] and mac._resp_ev is None
    # кадр не себе — NAV ведёт адаптер: у ядра конец NAV — адаптера
    _rx(mac, FR.rts(500, B, '02:00:00:00:00:0c'), 0)
    assert mac.nav.idle_from() == 0
    # ответ адаптера: ядро занято со «ответ назначен» до конца ответа
    mac.offload_response_pending()
    assert not mac._own_idle()
    mac.offload_tx_start('Ack')
    assert mac.tx_on
    mac.offload_tx_end()
    assert not mac.tx_on and mac._own_idle()


def test_offload_edca_arbiter_and_duration():
    """EDCA_BACKOFF: работа очереди (кадр управления с Ack) — запрос доступа адаптеру, передача только по
    offload_access_granted; DURATION: Duration, поставленное адаптером, — основа TXNAV."""
    sim, mac, phy = _off_mac()
    sim.run(50)
    job = mac.send_mgmt('Action', B, lambda t: bytes([3, 0, 1, 2, 0x10, 0, 0, 0, 0]))
    assert job.queue
    sim.run(200)
    assert phy.tx == [] and phy.calls and phy.calls[0][0] == 'access'
    phy.dur = 1900
    mac.offload_access_granted()
    assert len(phy.tx) == 1 and phy.tx[0][1].MCS == mac.mgmt_mcs
    assert mac._last_tx_dur == 1900
    # SLS — не работа очереди: доступ EDCA ядра, без арбитра адаптера
    sls = mac.start_sls(B)
    assert not sls.queue and not mac._arbiter_job(sls)


def test_offload_ideal_unchanged():
    """Идеальная среда: работа очереди — EDCAF ядра (арбитра нет), NAV — свой."""
    mac = DmgMac(Sim(), A)
    assert isinstance(mac.nav, C.Nav) and not mac.off
    j = mac.send_mgmt('Action', B, lambda t: b'')
    assert j.queue and not mac._arbiter_job(j)


def test_brp_txtime_with_trn():
    """BRP-RX PPDU (20.9.2.2, 20.11.3): TXTIME с полями TRN — ppdu_time по TRN_LEN."""
    from .. import brp as BRP
    txv = P.TxVector(MCS=0, LENGTH=42, TRN_LEN=4, PPDU_TYPE=BRP.TRN_R)
    assert P.ppdu_time(txv) == txtime_control(42) + 4 * BRP.T_TRN_UNIT


# ------------------------------------------------------------------------------------------------ журнал
def test_journal_formats():
    """Журнал → снимок ref_bridge2 (такты 165 МГц, первый MPDU, mpdus A-MPDU) и Air для air_judge."""
    j = Journal()
    j.nodes = {'A': A, 'B': B}
    j.bi_tu = 100
    m1 = FR.qos_data(5, B, A, B, 1, b'q' * 10, 0, 1)
    ps = FR.psdu([m1, m1], True)
    txv = P.TxVector(MCS=4, LENGTH=len(ps), AGGREGATION=P.AGGREGATED)
    r = j.add(Fr(10), Fr(10) + txtime(len(ps), 4), 'A', A, txv, ps)
    r.receivers.add('B')
    snap = j.to_snapshot(A)
    f = snap['frames'][0]
    assert f['start'] == 1650 and f['frame'] == m1 and f['mpdus'] == [m1, m1] and f['mcs'] == 4
    air = j.to_air(A)
    e = air.events[0]
    assert e.kind == 'A-MPDU' and e.first == 'Data' and e.agg and e.rx_nodes == ('B',) and e.tx_node == 'A'
    assert e.length == len(ps) and e.t_ok and e.dur == 5
    assert AID_BROADCAST == 255
