# SPDX-License-Identifier: AGPL-3.0-or-later
"""Beacon Interval Control маяка fw (fw/stubs.c add_bcon, add_discovery_bcon, bcon_tx_build_step): тело DMG Beacon
(+0x17, 6 октетов) и параметры BI для uc (LMAC 0x0b, fw/pcp_ext.c bcn_tx_init_bi_cfg) — по 802.11-2020 9.3.4.2,
рис. 9-77 (B0 — младший бит первого октета). Ожидания: AP/PCP — A-BFT каждые ABFT_N_BI_ABFT (4) BI, FSS 15, TXSS
ответчика, TXSS Span 1; PCP Association Ready — только у PCP (у AP подполе зарезервировано); Discovery Mode (11.1.3.4)
— Discovery Mode = 1, A-BFT каждый BI; scan_type 3 — с Clustering Control (CC Present) и A-BFT Length 3."""
import struct

import pytest

import fwflows as F

FIELDS = {'cc': (0, 1), 'disc': (1, 1), 'next_bcn': (2, 4), 'ati': (6, 1), 'abft_len': (7, 3), 'fss': (10, 4),
          'resp_txss': (14, 1), 'next_abft': (15, 4), 'frag': (19, 1), 'txss_span': (20, 7), 'n_bis_abft': (27, 4),
          'abft_cnt': (31, 6), 'n_abft_ant': (37, 6), 'pcp_ready': (43, 1), 'rsv': (44, 4)}
BUF = 0x807e00


def bic(b):
    v = int.from_bytes(b, 'little')
    return {k: (v >> s) & ((1 << w) - 1) for k, (s, w) in FIELDS.items()}


def _capture(fw, fn, *args):
    got = []

    def snd(f, a):
        payload, info = a[0], a[4]
        got.append((fw.rbytes(payload + 0x17, 6), struct.unpack('<II', fw.rbytes(info + 4, 8))))
        return 1
    fw.call(fn, *args, stub={'tx_api_send_dband_bcon': snd})
    assert len(got) == 1
    body, (w0, w1) = got[0]
    for i in range(0x70):
        fw.w8(BUF + i, 0)
    fw.call('bcn_tx_init_bi_cfg', BUF, w0, w1)
    p = fw.rbytes(BUF + 0x50, 0x20)
    uc = {'n_bis_abft': p[4], 'n_abft_ant': p[5], 'fss': p[7], 'txss_span': p[9], 'abft_len': p[0xa],
          'cc': p[0x14] & 1, 'disc': (p[0x14] >> 1) & 1, 'pcp_ready': (p[0x14] >> 3) & 1}
    return bic(body), bic(struct.pack('<IH', w0, w1 & 0xffff)), uc


def _bss(fw, net_type):
    b = bytearray(0x10)
    struct.pack_into('<H', b, 0, 100)
    b[2], b[0xc], b[0xd], b[0xf] = 8, net_type, 2, 1
    fw.wmi(F.WMI_PCP_START, bytes(b))
    F.settle(fw)
    fw.advance(0x7530)
    F.settle(fw)
    return fw.call('mid_list_by_mid_fw', 0)


BSS = dict(cc=0, disc=0, next_bcn=0, ati=0, abft_len=1, fss=15, resp_txss=1, next_abft=0, frag=0, txss_span=1,
           n_bis_abft=4, abft_cnt=0, n_abft_ant=0, rsv=0)


@pytest.mark.parametrize('net_type, pcp_ready', [(0x10, 0), (0x20, 1)], ids=['ap', 'pcp'])
def test_bss_beacon_bic(fw, net_type, pcp_ready):
    mid = _bss(fw, net_type)
    body, tmpl, uc = _capture(fw, 'add_bcon', mid)
    want = dict(BSS, pcp_ready=pcp_ready)
    assert body == want
    assert {k: uc[k] for k in uc} == {k: want[k] for k in uc}
    assert tmpl['pcp_ready'] == pcp_ready


@pytest.mark.parametrize('scan_type, cc, abft_len', [(1, 0, 1), (3, 1, 3)])
def test_discovery_beacon_bic(fw, scan_type, cc, abft_len):
    mid = fw.call('mid_list_by_mid_fw', 0)
    body, tmpl, uc = _capture(fw, 'add_discovery_bcon', mid, scan_type)
    want = dict(BSS, disc=1, cc=cc, abft_len=abft_len, n_bis_abft=1, pcp_ready=0)
    assert tmpl == want and body == want
    assert {k: uc[k] for k in uc} == {k: want[k] for k in uc}
