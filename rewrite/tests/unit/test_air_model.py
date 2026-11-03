# SPDX-License-Identifier: AGPL-3.0-or-later
"""Модель эфира (air.py) против 802.11-2020 — без эмулятора: кадр BlockAck, который «собирает MAC» в ответ на
A-MPDU (9.3.1.8, рис. 9-41/9-42/9-43, Table 9-28), и обнаружение дубликатов у приёмника перед fw/хостом
(10.3.2.14.3, Table 10-6). Поля разбираются из байт кадра по рисункам стандарта.

uc кадр BlockAck не разбирает (приём BlockAck — бит back r36 б9 отчёта MAC, uc/mac_regs.h MAC_RX_REP1_BACK), поэтому
раскладка проверяется на модели: от неё зависят разборы эфира в тестах и дальнейшие модели приёма BlockAck."""
import types

import pytest

import air
from air import Air

A_AP = bytes.fromhex('04d4c4112233')
A_STA = bytes.fromhex('04d4c4556677')


def bits(v, lo, n):
    return (v >> lo) & ((1 << n) - 1)


def parse_blockack(f):
    """Рис. 9-41: FC 2, Duration 2, RA 6, TA 6, BA Control 2, BA Information; рис. 9-42 / 9-43 / 9-37."""
    fc = int.from_bytes(f[0:2], 'little')
    ctl = int.from_bytes(f[16:18], 'little')
    ssc = int.from_bytes(f[18:20], 'little')
    return dict(type=bits(fc, 2, 2), subtype=bits(fc, 4, 4), ra=f[4:10], ta=f[10:16],
                multi_tid=bits(ctl, 1, 1), compressed=bits(ctl, 2, 1), gcr=bits(ctl, 3, 2), res=bits(ctl, 5, 7),
                tid=bits(ctl, 12, 4), fn=bits(ssc, 0, 4), ssn=bits(ssc, 4, 12),
                bitmap=int.from_bytes(f[20:28], 'little'), length=len(f))


def qos_data(ta, ra, sn, tid=0, fn=0, retry=False, null=False):
    """QoS Data / QoS Null (9.3.2.1, Table 9-1: тип 2, подтип 8 / 12), Sequence Control (9.2.4.4: FN B0..B3,
    SN B4..B15), QoS Control (TID B0..B3)."""
    fc = (2 << 2) | ((12 if null else 8) << 4) | (0x0800 if retry else 0)
    return (fc.to_bytes(2, 'little') + bytes(2) + ra + ta + ra + ((sn << 4) | fn).to_bytes(2, 'little') +
            bytes([tid, 0]) + (b'' if null else b'payload'))


def mgmt(ta, ra, sn, fn=0, retry=False, subtype=0xd):
    fc = (0 << 2) | (subtype << 4) | (0x0800 if retry else 0)
    return fc.to_bytes(2, 'little') + bytes(2) + ra + ta + ra + ((sn << 4) | fn).to_bytes(2, 'little') + b'\x03\x00'


# ---------------- BlockAck ----------------

@pytest.mark.parametrize('tid', [0, 5, 7])
def test_blockack_is_compressed_variant(tid):
    """9.3.1.8.1 Table 9-28: Multi-TID 0, Compressed Bitmap 1, GCR Mode 00 — Compressed BlockAck (BA Control
    0x0004 | TID << 12); 9.3.1.8.2: TID_INFO — TID подтверждаемых MSDU, Fragment Number SSC = 0, Block Ack Bitmap —
    8 октетов (28 октетов без FCS)."""
    f = air.blockack_frame(A_STA, A_AP, tid, 100, [100, 101, 102])
    b = parse_blockack(f)
    assert (b['type'], b['subtype']) == (1, 9)                       # Control, BlockAck (Table 9-1)
    assert (b['multi_tid'], b['compressed'], b['gcr'], b['res']) == (0, 1, 0, 0)
    assert int.from_bytes(f[16:18], 'little') == 0x0004 | tid << 12
    assert b['tid'] == tid and b['fn'] == 0
    assert (b['ra'], b['ta']) == (A_STA, A_AP)
    assert b['length'] == 28 and air.BA_LEN == 28 + 4                # + FCS; BA_LEN — длина ответа в machw


@pytest.mark.parametrize('ssn,sns', [(0, [0, 1, 2, 3]), (4094, [4094, 4095, 0, 1]), (10, [10, 12, 73]),
                                     (7, [7 + i for i in range(64)])])
def test_blockack_bitmap_by_sequence_number(ssn, sns):
    """9.3.1.8.2: бит k Block Ack Bitmap — MSDU с SN = SSN + k (по модулю 4096, 9.2.4.4.2); SSN — номер первого
    MSDU, для которого послан BlockAck (10.25.6.5). SN вне окна 64 не отмечается."""
    b = parse_blockack(air.blockack_frame(A_STA, A_AP, 0, ssn, sns))
    assert b['ssn'] == ssn
    want = 0
    for sn in sns:
        k = (sn - ssn) % 4096
        if k < 64:
            want |= 1 << k
    assert b['bitmap'] == want


def test_air_blockack_reply_carries_tid_and_ssn_of_ampdu():
    """Ответ эфира на A-MPDU: BlockAck с TID и SSN принятого A-MPDU (resp_ba, Air._tx), RA — его передатчик."""
    src = types.SimpleNamespace(mac=A_AP, resp_ra=A_STA, resp_ba=(6, 300, [300, 301, 302]))
    f, rep = Air([])._frame(src, dict(what='ответ на queue 0x2 A-MPDU 3 MPDU', fifo=None, ssw=0, mcs=1))
    b = parse_blockack(f)
    assert (b['ra'], b['ta'], b['tid'], b['ssn'], b['bitmap']) == (A_STA, A_AP, 6, 300, 0b111)
    assert b['compressed'] == 1 and b['multi_tid'] == 0


# ---------------- обнаружение дубликатов ----------------

def test_dup_qos_data_cache_per_tid():
    """Table 10-6 RC2: кэш QoS Data индексирован <Address 2, TID>: повтор с тем же SN в другом TID — не дубликат
    (каждый TID — своё пространство номеров, Table 10-5 SNS2)."""
    c = {}
    assert not air.rx_is_duplicate(c, qos_data(A_STA, A_AP, 5, tid=0))
    assert not air.rx_is_duplicate(c, qos_data(A_STA, A_AP, 5, tid=1, retry=True))
    assert air.rx_is_duplicate(c, qos_data(A_STA, A_AP, 5, tid=1, retry=True))
    assert air.rx_is_duplicate(c, qos_data(A_STA, A_AP, 5, tid=0, retry=True))


def test_dup_needs_retry_bit():
    """10.3.2.14.3: кэш ищется только при Retry = 1 — тот же SN без Retry (новый MSDU после заворота счётчика) — не
    дубликат."""
    c = {}
    assert not air.rx_is_duplicate(c, qos_data(A_STA, A_AP, 9))
    assert not air.rx_is_duplicate(c, qos_data(A_STA, A_AP, 9))


def test_dup_fragment_number_is_part_of_record():
    """Table 10-6: запись кэша — <sequence number, fragment number>: следующий фрагмент того же MSDU (даже с
    Retry = 1) — не дубликат предыдущего; повтор того же фрагмента — дубликат."""
    c = {}
    assert not air.rx_is_duplicate(c, mgmt(A_STA, A_AP, 7, fn=0))
    assert not air.rx_is_duplicate(c, mgmt(A_STA, A_AP, 7, fn=1, retry=True))
    assert air.rx_is_duplicate(c, mgmt(A_STA, A_AP, 7, fn=1, retry=True))


def test_dup_cache_per_transmitter_and_class():
    """Table 10-6: кэши по Address 2 — тот же SN от другого передатчика не дубликат; Management (RC4) и QoS Data
    (RC2) — разные кэши; QoS Null (RC3) кэша не имеет."""
    other = bytes.fromhex('04d4c4aabbcc')
    c = {}
    assert not air.rx_is_duplicate(c, mgmt(A_STA, A_AP, 3))
    assert not air.rx_is_duplicate(c, mgmt(other, A_AP, 3, retry=True))
    assert not air.rx_is_duplicate(c, qos_data(A_STA, A_AP, 3, retry=True))
    assert not air.rx_is_duplicate(c, qos_data(A_STA, A_AP, 4, null=True))
    assert not air.rx_is_duplicate(c, qos_data(A_STA, A_AP, 4, null=True, retry=True))


def test_air_to_fw_drops_only_real_duplicates():
    """Air._to_fw: хосту доставлены оба QoS Data с одним SN в разных TID, повтор того же (TA, TID, SN) — нет."""
    dst = types.SimpleNamespace(mac=A_AP, fw_tick0=0, host_rx=[], hw=types.SimpleNamespace(now=0), peer_idx={})
    a = Air([])
    for f in (qos_data(A_STA, A_AP, 20, tid=0), qos_data(A_STA, A_AP, 20, tid=3, retry=True),
              qos_data(A_STA, A_AP, 20, tid=3, retry=True)):
        a._to_fw(dst, types.SimpleNamespace(mac=A_STA), f)
    got = [(f[24] & 0xf, int.from_bytes(f[22:24], 'little') >> 4) for _, f in dst.host_rx]
    assert got == [(0, 20), (3, 20)]
