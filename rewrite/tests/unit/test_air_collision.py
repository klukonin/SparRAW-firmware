# SPDX-License-Identifier: AGPL-3.0-or-later
"""Модель столкновения в эфире (machw H-COLL, H-CW; air.Air): эталон — 802.11-2020.

- 10.3.2.1/10.3.2.3.7: кадр, перекрытый другим PPDU у приёмника, не принят (захвата нет — оба потеряны); полудуплекс:
  своя передача портит принимаемый кадр, кадр во время своей передачи не принят; потеря — PHY-RXEND с ошибкой: после
  конца занятости EIFS − DIFS + AIFS = aSIFSTime + AckTxTime + AIFS, кадр без ошибки EIFS прерывает;
- передатчик о столкновении не знает: Ack/BlockAck, потерянный у него, — не ответ (тайм-аут, повтор — H-RETRY);
- 10.23.2.2: CW растит uc (ECW + 1 до ECWmax после неудачи RTS, ECWmin после успеха) командой маски CW — арбитр
  MAC берёт отсрочку из неё (H-CWMASK).
Модель MAC без микрокода (события железа по часам; uc не исполняется)."""
import pytest

import machw as MH
from air import Air
from machw import HW, SIFS_CLK, AIFS_CLK, SLOT_CLK, ctrl_txtime_clk

pytestmark = pytest.mark.unit

A_MAC, B_MAC, C_MAC = bytes.fromhex('02aa00000001'), bytes.fromhex('02bb00000002'), bytes.fromhex('02cc00000003')


def run_to(hw, t):
    """События железа до такта t включительно (uc не шагает)."""
    while True:
        n = hw._next_t()
        if n is None or n > t:
            break
        hw.advance_to_next()
    hw.now = max(hw.now, t)


def _rx(hw, t, n=20, what='кадр', log=None):
    tok = {}
    log = [] if log is None else log
    hw.air_rx(t, n, what, on_hdr=lambda h: log.append(('hdr', what)), on_end=lambda h: log.append(('end', what)),
              report={38: 0xe0000000}, tok=tok)
    return tok, log


def test_overlap_at_receiver_both_lost(uc):
    """Два PPDU перекрываются у приёмника — ни один не принят (ни rx_frame_event, ни конца приёма, ни отчёта); среда
    занята до конца второго, затем EIFS − DIFS + AIFS (10.3.2.3.7)."""
    hw = HW(uc)
    hw.collisions = []
    log = []
    t1, _ = _rx(hw, 1000, what='первый', log=log)
    t2, _ = _rx(hw, 1000 + 300, what='второй', log=log)      # до разбора заголовка первого
    end2 = 1300 + ctrl_txtime_clk(20)
    run_to(hw, end2 + 10)
    assert t1.get('lost') and t2.get('lost')
    assert log == []
    assert not hw.r42 & (1 << 12) and not hw.r42 & (1 << 16)
    assert hw.collisions and hw.collisions[0][1] == 'второй'
    assert hw.rx is None and hw.medium_busy_end == end2
    assert hw.eifs_end == end2 + SIFS_CLK + ctrl_txtime_clk(14)


def test_overlap_after_header_reports_fcs_error(uc):
    """Второй PPDU после разбора заголовка первого: rx_frame_event уже был — итог приёма с ошибкой FCS (r38 б29..31 = 0),
    кадр в fw не уходит (on_end нет)."""
    hw = HW(uc)
    hw.collisions = []
    log = []
    t1, _ = _rx(hw, 1000, n=200, what='длинный', log=log)
    _rx(hw, 1000 + MH.HDR_CLK + 100, what='помеха', log=log)
    run_to(hw, 1000 + ctrl_txtime_clk(200) + 10)
    assert t1.get('lost')
    assert log == [('hdr', 'длинный')]
    assert hw.r42 & (1 << 16) and hw.uc.ext[38] & 0xe0000000 == 0


def test_own_tx_during_rx_spoils_it(uc):
    """Полудуплекс: свой PPDU, начатый во время приёма (решение о доступе — до чужой преамбулы), портит его."""
    hw = HW(uc)
    hw.collisions = []
    log = []
    tok, _ = _rx(hw, 1000, what='чужой RTS', log=log)
    hw.tx_pending = dict(start=1023, dur=ctrl_txtime_clk(20), what='свой RTS')
    hw.at(1023, hw._tx_start, 'tx_start')
    run_to(hw, 1023 + ctrl_txtime_clk(20) + 10)
    assert tok.get('lost') == 'полудуплекс' and log == []
    assert hw.collisions == [(1023, 'чужой RTS', 'свой RTS')]


def test_rx_during_own_tx_lost_and_tail_keeps_medium_busy(uc):
    """Кадр, начавшийся во время своей передачи, не принят; его хвост после конца своей передачи — занятая среда
    (физическая несущая), после него — EIFS."""
    hw = HW(uc)
    hw.collisions = []
    hw.tx_pending = dict(start=1000, dur=ctrl_txtime_clk(20), what='свой')
    hw.at(1000, hw._tx_start, 'tx_start')
    run_to(hw, 1100)
    tok, log = _rx(hw, 1200, n=60, what='чужой')
    end = 1200 + ctrl_txtime_clk(60)
    run_to(hw, 1000 + ctrl_txtime_clk(20) + 10)
    assert tok.get('lost') == 'полудуплекс'
    assert hw.rx is not None and hw.rx.get('energy')        # хвост чужого PPDU
    run_to(hw, end + 1)
    assert hw.rx is None and log == []
    assert hw.eifs_end == end + SIFS_CLK + ctrl_txtime_clk(14)


def test_valid_frame_ends_eifs(uc):
    """10.3.2.3.7: кадр без ошибки во время EIFS её прерывает."""
    hw = HW(uc)
    hw.collisions = []
    _rx(hw, 1000)
    _rx(hw, 1100)
    run_to(hw, 1100 + ctrl_txtime_clk(20) + 1)
    assert hw.eifs_end
    t = hw.now + 50
    tok, log = _rx(hw, t)
    run_to(hw, t + ctrl_txtime_clk(20) + 1)
    assert not tok.get('lost') and ('end', 'кадр') in log
    assert hw.eifs_end == 0


def test_backoff_waits_eifs_after_lost_frame(uc):
    """Отсрочка после потерянного кадра — не раньше EIFS − DIFS + AIFS от конца занятости (10.3.2.3.7)."""
    hw = HW(uc)
    hw.collisions = []
    hw.mac_q_model = True
    hw.mac_q_pending = 1 << 0x1a
    _rx(hw, 1000)
    _rx(hw, 1100)
    end = 1100 + ctrl_txtime_clk(20)
    run_to(hw, end + 1)
    ev = hw.backoff_ev
    assert ev is not None
    assert ev.t >= end + SIFS_CLK + ctrl_txtime_clk(14) + AIFS_CLK


@pytest.mark.parametrize('ecw', [4, 5, 7])
def test_backoff_window_from_uc_cw_mask(uc, ecw):
    """H-CWMASK (10.23.2.2): CW арбитра задаёт uc командой (9 + класс) << 24 | (2^ECW − 1) — ECWmin AC при настройке
    EDCA, ECW + 1 после неудачи RTS (tx_pick_slot_for_peer); отсрочка — U[0, CW] слотов после AIFS. Класс очереди
    управления 0x1a (маска 4) — 0."""
    hw = HW(uc)
    hw.mac_q_model = True
    hw.mac_q_pending = 1 << 0x1a
    hw._cmd((9 << 24) | ((1 << ecw) - 1))
    hw._cmd((11 << 24) | 1)                                  # другой класс — не влияет
    slots = set()
    for _ in range(400):
        hw.backoff_ev = None
        hw._backoff_kick()
        slots.add((hw.backoff_ev.t - hw.now - AIFS_CLK) // SLOT_CLK)
        hw.cancel(hw.backoff_ev)
    assert min(slots) == 0 and max(slots) == (1 << ecw) - 1


class _Node:
    """Узел эфира без fw (Air._tx: мак, часы, uc, модель MAC)."""
    def __init__(self, uc, mac):
        self.uc, self.mac, self.hw = uc, mac, HW(uc)
        self.t_prev = 0


def test_air_lost_ack_is_no_ack(uc_factory):
    """Ack у отправителя кадра перекрыт кадром третьего узла — отправитель Ack не получил: тайм-аут и повтор
    (H-RETRY, 10.23.2.12); ответ не построен на кадр, который приёмник потерял."""
    a, b, c = _Node(uc_factory(), A_MAC), _Node(uc_factory(), B_MAC), _Node(uc_factory(), C_MAC)
    air = Air([a, b, c])
    q = bytearray(30)
    q[0] = 0xd0                                               # Action
    q[4:10], q[10:16] = B_MAC, A_MAC
    a.hw.mac_q[0x1a] = [bytes(q)]
    a.hw.ack_wait = dict(qid=0x1a, ra=B_MAC, n=1)
    a.hw.ack_wait['ev'] = a.hw.at(5000, a.hw._ack_timeout, 'ack_wait')
    b.resp_ra = A_MAC
    air._tx(b, dict(start=1000, dur=ctrl_txtime_clk(14), what='ответ на Action', dur_us=0, fifo=None, ssw=0))
    air._tx(c, dict(start=1100, dur=ctrl_txtime_clk(20), what='queue чужой', dur_us=0, fifo=None, ssw=0,
                    qframe=bytes(q[:4]) + A_MAC + C_MAC + bytes(14)))
    run_to(a.hw, 6000)
    lost = {f['what']: [d.mac for d, _ in Air.lost_at(f)] for f in air.frames}
    assert A_MAC in lost['ответ на Action'] and A_MAC in lost['queue чужой']
    assert a.hw.retry_log and a.hw.retry_log[0][1] == 0x1a
    assert not hasattr(a, 'resp_kind')                       # на потерянный кадр C ответа нет
