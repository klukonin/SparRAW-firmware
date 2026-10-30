# SPDX-License-Identifier: AGPL-3.0-or-later
"""fw и uc вместе (cosim.CoSim): команды LMAC fw исполняет настоящий uc в модели MAC с прерываниями, его события
получает fw. Проверяется сам совместный прогон: загрузка и старт точки доступа проходят без ассертов обеих сторон,
ответы uc — те, что заглушка fwflows.uc_reply предполагает, и uc запускает интервал маяков (команда MAC 0x0d)."""
import fwflows as F
from cosim import CoSim


def test_ap_start_through_real_uc(fw, uc):
    cs = CoSim(fw, uc)
    assert [t for t, _ in cs.ready] == [0x00], cs.ready              # «ucode ready» после загрузки
    from machw import MACERR_VEC
    no_assert = lambda: cs.hw.sxd_errors.icr == 0 and MACERR_VEC not in [n for _, n in cs.hw.irq_log]   # noqa: E731
    assert no_assert(), 'uc_assert при загрузке (SXD_ERRORS б6 → L2 вектор 6)'
    t0 = cs.hw.now
    fw.clear()
    with cs:
        F.Fw(fw).ap_start()
    log = dict(cs.log)
    assert log.get(0x03) == [0x03] and log.get(0x01) == [0x01], cs.log  # RX off / RX on — подтверждены
    assert no_assert(), 'uc_assert при старте AP'
    assert any(v >> 24 == 0x0d for t, v in cs.hw.cmd_log if t >= t0), 'uc не запустил интервал маяков (0x0d)'
    assert not fw.wild


def test_ap_beacons_on_first_tbtt(fw, uc):
    """Совместно: fw ставит маяк в кольцо tx_api_2 (очередь MAC 30, r41 селектор 0x3 б30 — H-MACQ), uc на первом TBTT
    (bi1_event, H-BI1) разворачивает маяки по секторам — в эфире модели серия кадров развёртки сразу после TBTT."""
    cs = CoSim(fw, uc, first_tbtt_us=10_000)                # первый TBTT через 10 мс (сетка BI — от него)
    fw.clear()
    with cs:
        F.Fw(fw).ap_start()
    assert cs.hw.mac_q_pending & (1 << 30), 'маяк не в очереди MAC 30'
    t_tbtt = (cs.hw.tbtt_us - cs.hw.tsf0_us) * 165
    cs.run_us((t_tbtt - cs.hw.now) / 165 + 700)                # до TBTT и ещё 700 мкс
    tx = [a for a in cs.hw.air_log if a[2] == 'tx']
    assert len(tx) >= 16 and all(w.startswith('sweep') for _, _, _, w in tx), cs.hw.log_air()
    assert 0 < tx[0][0] - t_tbtt < 30 * 165, (tx[0][0] - t_tbtt) / 165   # первый маяк — в мкс после TBTT
