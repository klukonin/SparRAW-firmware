# SPDX-License-Identifier: AGPL-3.0-or-later
"""Диагностика модулей RF (WMI_UNIT_TEST 0x516/0x517: rfc_probe_modules, rfc_collect_rx_crc_stats, fw/rf_sector.c)
обходит модули, делая активным каждый по очереди. После обхода набор активных модулей — прежний: тень регистра
abif_dvs_rf_ctrl у uc (abif_dvs_rf_ctrl_shadow) соответствует ему, uc перечитывает её только при LMAC 0x00, BRP и
TXSS, а запись uc по тени иначе откатила бы выбор модулей."""
import pytest

HW_STUBS = {n: None for n in ('hwd_abif_dvs_rfca_cmd_enable', 'hwd_rfc_powerdown_deep', 'hwd_abif_dvs_if_splitter_enable',
                              'hwd_abif_dvs_lo_splitter_enable', 'hwd_abif_dvs_rf_activate', 'rfc_restore_txrx_sets_fw',
                              'rfc_write_field_434_2ec33', 'hwf_rf_config', 'rfc_pulse_probe_bit')}
HW_STUBS['mdm_stt_rx_crc_ok'] = 0
OUT = 0x807e00


@pytest.mark.parametrize('fn', ['rfc_probe_modules', 'rfc_collect_rx_crc_stats'])
@pytest.mark.parametrize('conn, act, mask', [(0x3, 0x1, 0x3), (0x3, 0x2, 0x3), (0xf, 0x5, 0xa), (0x1, 0x1, 0x1)])
def test_active_modules_restored(fw, fn, conn, act, mask):
    fw.w8(fw.a('rf_connected_mask'), conn)
    fw.call('rf_obj_set_active_rf_mask', fw.a('rf_obj'), act)
    fw.call(fn, mask, OUT, stub=HW_STUBS)
    assert fw.call('rf_obj_get_rf_mask', fw.a('rf_obj')) == act
