# SPDX-License-Identifier: AGPL-3.0-or-later
"""Поля команд и событий WMI против драйвера wil6210 (wmi.h): ширина и знак полей, 64-битный TSF.

  * WMI_CFG_RX_CHAIN: wb_thrsh, host_thrsh, max_rx_pl_per_desc — __le16 (без знака): 0x8001 — не степень двойки,
    отказ (со знаком — «отрицательное», проходило как «< 3»);
  * WMI_NOTIFY_REQ_DONE: tsf — 64 бита из двух регистров TSF MAC; перенос младшего слова между чтениями не даёт
    значения на 2^32 мкс меньше (чтение старшее–младшее–старшее с повтором).
"""
import struct

import fwemu
import fwflows as F

WMI_CFG_RX_CHAIN, WMI_CFG_RX_CHAIN_DONE = 0x820, 0x1820
WMI_NOTIFY_REQ, WMI_NOTIFY_REQ_DONE = 0x863, 0x1863
HW_MAC_TSF_LO, HW_MAC_TSF_HI = F.HW_MAC_TSF_LO, F.HW_MAC_TSF_HI


def test_rx_chain_max_pl_is_unsigned(fw_elf):
    fw = fwemu.FW(fw_elf).boot(driver_up=False)               # CFG_RX_CHAIN ещё не было
    b = bytearray(fwemu.FW.rx_chain_cmd())
    struct.pack_into('<H', b, 0x34, 0x8001)
    ev = fw.wmi(WMI_CFG_RX_CHAIN, bytes(b))
    assert [e.body[4] for e in ev if e.id == WMI_CFG_RX_CHAIN_DONE] == [0]     # status — не SUCCESS
    assert any(r[0] == WMI_CFG_RX_CHAIN and r[1] == 0x8001 for r in fw.rejects), fw.rejects


def test_notify_req_done_tsf_carry(fw):
    """TSF идёт на 1 мкс за каждое чтение регистра и переносится в старшее слово между первым чтением старшего и
    чтением младшего: значение в событии — не меньше TSF до чтения и не больше TSF после."""
    w = F.Fw(fw)
    w.sta_connect()
    t = [0x5_ffff_ffff]

    def rd(lo):
        def h(fw, a):
            v = t[0]
            t[0] += 1
            return v & 0xffffffff if lo else v >> 32
        return h
    fw.mmio_read_hook[HW_MAC_TSF_LO] = rd(True)
    fw.mmio_read_hook[HW_MAC_TSF_HI] = rd(False)
    t0 = t[0]
    ev = fw.wmi(WMI_NOTIFY_REQ, struct.pack('<BBBBI', 0, 0, 0, 0, 0) + bytes(4))
    del fw.mmio_read_hook[HW_MAC_TSF_LO], fw.mmio_read_hook[HW_MAC_TSF_HI]
    body = [e.body for e in ev if e.id == WMI_NOTIFY_REQ_DONE][-1]
    lo, hi = struct.unpack_from('<II', body, 4)
    tsf = hi << 32 | lo
    assert t0 <= tsf <= t[0], (hex(t0), hex(tsf), hex(t[0]))
