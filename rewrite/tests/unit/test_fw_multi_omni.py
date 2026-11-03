# SPDX-License-Identifier: AGPL-3.0-or-later
"""CONNECT при нескольких directed omni (fw/wmi_cmd.c l2mgr_connect_multi_omni): подключение откладывается до окна
маяка цели. Окно — Beacon Interval цели (поле Beacon Interval маяка / Probe Response, 802.11-2020 9.4.1.3: в TU,
TU = 1024 мкс), период — n окон. BI = 0 (недопустимое значение в кадре пира) и n × BI ≥ 2^32 мкс окна не дают —
подключение сразу, как с неизвестной целью."""
import pytest

PEER = 0x807e00                     # struct scan_peer (0x14 Б) — свободная область стека в эмуляторе
CMD = 0x807f00                      # struct wmi_connect_cmd
NOW = 0x123456                      # u_schd_now, тики 16 мкс


def _run(fw, bi_tu, n, t0):
    for i in range(0x14):
        fw.w8(PEER + i, 0)
    fw.w16(PEER + 0x0a, bi_tu)
    fw.w32(PEER + 0x10, t0)
    fw.w8(fw.a('conn_multi_omni_count'), n)
    sched = []
    fw.call('l2mgr_connect_multi_omni', CMD, 0, stub={
        'scan_peer_find_by_bssid': PEER, 'u_schd_now': NOW, 'TX_API_alloc_tx_payload': 0,
        'l2mgr_connect_multi_omni_cb': None,
        'u_schd_schedule': lambda f, a: sched.append(a[4]) or 1})
    return fw.stub_calls('l2mgr_connect_multi_omni_cb'), sched


@pytest.mark.parametrize('bi_tu, n', [(0, 2), (32768, 128), (32768, 192), (65535, 255)])
def test_no_window_connects_now(fw, bi_tu, n):
    now_cb, sched = _run(fw, bi_tu, n, NOW - 100)
    assert len(now_cb) == 1 and sched == []


@pytest.mark.parametrize('bi_tu, n', [(100, 2), (1000, 3), (32767, 128)])
def test_window_from_beacon_interval(fw, bi_tu, n):
    slot = bi_tu * 1024
    period = n * slot
    el = 100 * 16                                   # маяк цели — 100 тиков назад
    now_cb, sched = _run(fw, bi_tu, n, NOW - 100)
    assert now_cb == [] and len(sched) == 1
    # до начала следующего периода (от маяка цели) без одного окна
    to_next = period - el
    want = (to_next if to_next > slot else to_next + period) - slot
    assert sched[0] == want & 0xffffffff
