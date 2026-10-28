# SPDX-License-Identifier: AGPL-3.0-or-later
"""STA: Disassociation от точки (9.3.3.4) в любой фазе подключения — fw не падает, хосту
ровно одно WMI_DISCONNECT_EVENT, состояние — как после загрузки, следующее подключение проходит. Стенд 2026-10-28:
Disassociation (Reason 4) во время подключения станции — FW error на станции."""
import struct

import pytest

import fwflows as F

ST_DISASSOC = 10


def _from_ap(w, stype, reason=4):
    fw = w.fw
    fw.call('rx_pkt_handler', fw.rx_pkt(fw.mgmt_frame(stype, F.OWN_MAC, F.AP_MAC, F.AP_MAC, struct.pack('<H', reason)),
                                        cid=0))
    fw.run_tasks()
    F.settle(fw)


def st_after_bf(w):
    """BF новой связи прошёл, бикон пира ещё не пойман (WAIT_FOR_BCON_RX)."""
    fw = w.fw
    fw.wmi(F.WMI_CONNECT, F.connect_cmd(bssid=F.AP_MAC))
    F.settle(fw)
    fw.lmac_evt(0x05, F.bf_done(0, F.AP_MAC))
    F.settle(fw)


def st_linkup_bf_pending(w):
    """Бикон пойман, uc запущен BF линк-апа (LMAC 0x09), его итог (BF_DONE) ещё не пришёл — придёт после Disassoc."""
    st_after_bf(w)
    fw = w.fw
    fw.call('basic_sm_handle_event', w.conn_by_cid(0) + F.C_MSM, 1, 1, 0, 0)
    fw.run_tasks()                                          # без settle: ответ uc на 0x09 ещё впереди


def st_assoc_req_tx_pending(w):
    """Assoc Request поставлен в TX, завершения (Ack) ещё нет — придёт после Disassoc."""
    st_after_bf(w)
    fw = w.fw
    fw.call('basic_sm_handle_event', w.conn_by_cid(0) + F.C_MSM, 1, 1, 0, 0)
    fw.run_tasks()
    F.settle(fw, tx=False)


def st_assoc_req_sent(w):
    w.sta_connect(stop='assoc_req')


def st_associated(w):
    w.sta_connect()
    w.sta_add_vring()


STAGES = {'after_bf': st_after_bf, 'linkup_bf_pending': st_linkup_bf_pending,
          'assoc_req_tx_pending': st_assoc_req_tx_pending, 'assoc_req_sent': st_assoc_req_sent,
          'associated': st_associated}


@pytest.mark.parametrize('stage', sorted(STAGES))
def test_sta_disassoc_from_ap_any_stage(fw, stage):
    stype = ST_DISASSOC                                     # Deauthentication rx_mgmt_srvs_distribute не передаёт (журнал)
    w = F.Fw(fw)
    boot = F.idle_state(fw)
    STAGES[stage](w)
    n0 = len(fw.wmi_evts)
    _from_ap(w, stype)
    fw.advance(4_000_000, between=F.settle)                 # таймеры ассоциации / бикона истекают
    F.settle(fw)
    disc = [e for e in fw.wmi_evts[n0:] if e.id == F.EV_DISCONNECT]
    assert len(disc) == 1, 'WMI_DISCONNECT_EVENT: %d' % len(disc)
    assert not fw.wild
    assert F.state_diff(boot, F.idle_state(fw), ('tx_api_mgmt.state', 'tx_api_2.state', 'tx_api_data.state',
                                                 'll_ctx.ka_cnt[cid]')) == []
    w.sta_connect()                                         # снова подключается
    assert w.msm(w.conn_by_cid(0)) == F.MSM_KEY_ASSOC
