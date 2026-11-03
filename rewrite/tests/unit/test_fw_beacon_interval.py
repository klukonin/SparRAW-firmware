# SPDX-License-Identifier: AGPL-3.0-or-later
"""Beacon Interval (802.11-2020 9.4.1.3, в TU = 1024 мкс): станция ведёт сетку BI точки, к которой подключается
(BI — из DMG Beacon точки, 9.3.4.2; LMAC 0x01 bi_len_us = BI × 1024), точка объявляет один BI в маяке и в Probe
Response (табл. 9-45, 9-39). Стенд 2026-10-31: точка BI 200 TU — у станции HW_MAC_BEACON_INTERVAL 100, Probe Response
точки — 100."""
import struct

import pytest

import fwflows as F
from test_fw_mgmt_frames import build


def rx_on_bi(fw, n0):
    """bi_len_us команд LMAC 0x01 (struct lmac_cmd_rx_on, include/lmac_cmd.h) после n0, у которых задан BI (флаг б0)."""
    return [struct.unpack_from('<I', c.body, 0x18)[0] for c in fw.lmac_cmds[n0:]
            if c.type == 0x01 and len(c.body) >= 0x1c and struct.unpack_from('<I', c.body, 0x10)[0] & 1]


@pytest.mark.parametrize('bi', [100, 200, 1000])
def test_sta_connect_uses_ap_beacon_interval(fw, bi):
    w = F.Fw(fw)
    w.rx_beacon(F.dmg_beacon(F.AP_MAC, bi=bi))             # маяк точки при скане
    n0 = len(fw.lmac_cmds)
    w.sta_connect(stop='assoc_req')
    got = rx_on_bi(fw, n0)
    assert got and all(v == bi * 1024 for v in got), got


def test_sta_connect_without_beacon_keeps_default(fw):
    """Маяк точки не принимался — прежнее значение (BI по умолчанию, 100 TU)."""
    w = F.Fw(fw)
    n0 = len(fw.lmac_cmds)
    w.sta_connect(stop='assoc_req')
    got = rx_on_bi(fw, n0)
    assert got and all(v == 100 * 1024 for v in got), got


@pytest.mark.parametrize('bi', [100, 200])
def test_ap_probe_resp_beacon_interval(fw, bi):
    w = F.Fw(fw)
    w.set_mac(F.AP_MAC)
    w.ap_start(bi=bi)
    conn = w.ap_sta_join()
    f = build(fw, 'mgmt_tx_build_probe_resp', w.mid0, conn, 0)
    assert struct.unpack_from('<H', f, 24 + 8)[0] == bi     # Probe Response: Timestamp (8), затем Beacon Interval
    bc = [x for _, x in fw.tx_frames if x[0] == 0x0c]
    assert bc and struct.unpack_from('<H', bc[-1], 0x15)[0] == bi
