# SPDX-License-Identifier: AGPL-3.0-or-later
"""Неверные команды хоста не роняют fw: отказ с записью в журнале, связь и данные остаются."""
import struct
import pytest

pytestmark = [pytest.mark.stand, pytest.mark.sta]

Z = b'\0' * 32
# (команда, тело, что ждать в журнале fw) — значения вне допустимых (vendor на них падал фатальным ассертом)
BAD = [
    (0x824, b'\x0c\0\0\0' + Z, 'invalid value 0xc'),               # VRING_BA_DIS ringid 12
    (0x829, b'\x07\0\0\0' + Z, 'invalid value 0x7'),               # SET_PCP_CHANNEL 7
    (0x83a, b'\x05\0\0\0' + b'\0' * 12 + Z, 'invalid value 0x5'),  # BF_TRIG тип 5
    (0x853, b'\x09\0\0\0' + Z, 'invalid value 0x9'),               # RF_MGMT тип 9
    (0x824, b'\x05\0\0\0' + Z, 'without a stream'),                # VRING_BA_DIS ringid 5 без стрима
]


@pytest.mark.parametrize('cmd,body,expect', BAD, ids=['ba_dis_ring12', 'pcp_channel7', 'bf_trig5', 'rf_mgmt9',
                                                      'ba_dis_nostream'])
def test_bad_wmi_rejected(sta, fw_path, cmd, body, expect):
    sta.dut.wmi_send(cmd, body)
    import time; time.sleep(0.5)
    log = sta.dut.fw_log(fw_path)
    assert any(expect in l for l in log[-60:]), 'нет записи «%s» в журнале fw' % expect
    assert sta.dut.fw_errors() == 0


def test_silent_rssi_table0_does_not_crash(sta):
    """WMI_SET_ACTIVE_SILENT_RSSI_TABLE(0): у vendor — фатальный ассерт 0x1588."""
    sta.dut.wmi_send(0x85c, b'\0\0\0\0' + Z)
    import time; time.sleep(1)
    assert sta.dut.fw_errors() == 0


def test_ut_calib_bad_engine(sta, fw_path):
    """UT calib_mgr_ut с индексом движка 9 (движков 6) — отказ, не чтение за массивом."""
    sta.dut.wmi_send(0x900, struct.pack('<HHI', 7, 1, 9) + b'\0' * 28)
    import time; time.sleep(0.5)
    log = sta.dut.fw_log(fw_path)
    assert any('engine index 0x9 out of range' in l for l in log[-40:])


def test_link_alive_after_bad_commands(sta):
    assert sta.dut.fw_errors() == 0
    assert sta.ping(10) >= 9
