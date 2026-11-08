# SPDX-License-Identifier: AGPL-3.0-or-later
"""SME по умолчанию (над MLME-SAP и MAC-SAP ядра) — сценарий соединения и обмена данными. Это не часть MAC: SME
решает, что запрашивать; MAC исполняет по стандарту. Для тестов и для этапа 2 (тот же сценарий против прошивки).

ApSme: MLME-START → на MLME-ASSOCIATE.indication — .response(SUCCESS) → на MLME-ADDBA.indication — .response(SUCCESS)
       и своё MLME-ADDBA.request (нисходящее соглашение) → нисходящие MSDU после .confirm.
StaSme: MLME-SCAN(PASSIVE) → MLME-JOIN выбранного BSS → BF: A-BFT (MLME-BF-TRAINING.indication) и/или SLS в DTI
       (MLME-BF-TRAINING.request) → MLME-SCAN(ACTIVE, Probe) → MLME-ASSOCIATE → MLME-ADDBA.request → восходящие MSDU
       после .confirm."""
from dataclasses import replace

from . import sap_mac as MS
from . import sap_mlme as ML

MSDU_LEN = 1500


def msdus(n_bytes, seed=0):
    out, i = [], 0
    while n_bytes > 0:
        n = min(MSDU_LEN, n_bytes)
        out.append(bytes(((seed + i + k) & 0xFF) for k in range(n)))
        n_bytes -= n
        i += 1
    return out


class _Sme:
    def __init__(self, mac):
        self.mac = mac
        self.log = []
        self.rx = []                      # MA-UNITDATA.indication
        self.status = []                  # MA-UNITDATA-STATUS.indication
        mac.sme = self

    def ma_unitdata_indication(self, ind):
        self.rx.append(ind)

    def ma_unitdata_status_indication(self, ind):
        self.status.append(ind)

    def rx_bytes(self):
        return sum(len(i.data) for i in self.rx)

    def ok_count(self):
        return sum(1 for s in self.status if s.transmission_status == MS.SUCCESSFUL)

    def _send(self, da, payloads):
        for d in payloads:
            self.mac.ma_unitdata_request(MS.MaUnitdataRequest(self.mac.addr, da, d))


class ApSme(_Sme):
    def __init__(self, mac, ssid=b'dmg-core', bi_tu=100, abft_slots=8, fss=8, dl_bytes=0, edca=None):
        super().__init__(mac)
        self.ssid, self.bi_tu, self.abft_slots, self.fss, self.dl_bytes, self.edca = ssid, bi_tu, abft_slots, fss, \
            dl_bytes, edca
        self.dl_sent = {}
        # своё MLME-ADDBA.request: False — в ответ на ADDBA станции (по умолчанию); True — сразу после ассоциации
        # (как драйвер прошивки: соглашение открывает сторона с данными; этап 2, diff_scenario)
        self.addba_on_assoc = False
        self.addba_req = set()
        # отказ получателя в соглашении (10.25.2: Status ≠ SUCCESS) — новый MLME-ADDBA.request через addba_retry_us,
        # не больше addba_retries раз (решение SME; получатель вправе отказать, например до готовности хоста)
        self.addba_retry_us, self.addba_retries = 5000, 3
        self._addba_tries = {}

    def start(self):
        self.mac.mlme_request(ML.MlmeStartRequest(SSID=self.ssid, BeaconPeriod=self.bi_tu, abft_slots=self.abft_slots,
                                                  fss_frames=self.fss, EDCAParameterSet=self.edca))

    def mlme_confirm(self, p):
        self.log.append(p)
        if isinstance(p, ML.MlmeAddbaConfirm) and p.ResultCode != ML.SUCCESS:
            n = self._addba_tries.get(p.PeerSTAAddress, 0)
            if n < self.addba_retries:
                self._addba_tries[p.PeerSTAAddress] = n + 1
                self.mac.sim.after(self.addba_retry_us, self.mac.mlme_request, ML.MlmeAddbaRequest(
                    PeerSTAAddress=p.PeerSTAAddress, DialogToken=0x5A + n + 1, TID=0, BufferSize=64))
            return
        if isinstance(p, ML.MlmeAddbaConfirm) and p.ResultCode == ML.SUCCESS and p.PeerSTAAddress not in self.dl_sent:
            self.dl_sent[p.PeerSTAAddress] = msdus(self.dl_bytes, seed=0x40)
            self._send(p.PeerSTAAddress, self.dl_sent[p.PeerSTAAddress])

    def mlme_indication(self, p):
        self.log.append(p)
        if isinstance(p, ML.MlmeAssociateIndication):
            self.mac.mlme_response(ML.MlmeAssociateResponse(PeerSTAAddress=p.PeerSTAAddress, ResultCode=ML.SUCCESS))
            if self.addba_on_assoc:
                self._addba(p.PeerSTAAddress)
        elif isinstance(p, ML.MlmeAddbaIndication):
            self.mac.mlme_response(ML.MlmeAddbaResponse(PeerSTAAddress=p.PeerSTAAddress, DialogToken=p.DialogToken,
                                                        TID=p.TID, ResultCode=ML.SUCCESS, BufferSize=64))
            self._addba(p.PeerSTAAddress)

    def _addba(self, peer):
        if self.dl_bytes and peer not in self.addba_req:
            self.addba_req.add(peer)
            self.mac.mlme_request(ML.MlmeAddbaRequest(PeerSTAAddress=peer, DialogToken=0x5A, TID=0, BufferSize=64))


class StaSme(_Sme):
    """bf: 'abft' — BF в A-BFT; 'dti' — без A-BFT, SLS в DTI; 'both' — A-BFT, затем SLS в DTI после ассоциации."""
    def __init__(self, mac, ssid=b'dmg-core', ul_bytes=0, bf='abft', probe=True, bssid=None):
        super().__init__(mac)
        self.ssid, self.ul_bytes, self.bf, self.probe = ssid, ul_bytes, bf, probe
        # BSSID, заданный SME (как драйвер прошивки в WMI_CONNECT): BSS выбирается и по нему — DMG Beacon может не
        # нести SSID (табл. 9-45: элемент SSID в DMG Beacon необязателен); SSID для ассоциации — свой
        self.bssid_hint = bssid
        # пауза SME (мкс) перед MLME-ASSOCIATE (после BF) и перед MLME-ADDBA (после ассоциации): когда просить —
        # решение SME, не MAC; 0 — сразу
        self.pause_us = 0
        self.state = 'init'
        self.bss = None
        self.ul = []
        # MLME-ADDBA.request станции: 'always' — после ассоциации всегда (по умолчанию); 'ul' — только при данных вверх
        self.addba = 'always'
        if bf == 'dti':
            mac.need_bf = False            # модель: станция не участвует в A-BFT (BF — только SLS в DTI)

    def start(self):
        self.state = 'scan'
        self.mac.mlme_request(ML.MlmeScanRequest(ScanType=ML.PASSIVE, SSID=self.ssid, MinChannelTime=100,
                                                 MaxChannelTime=self.mac_bi_tu()))

    def mac_bi_tu(self):
        return 120

    def mlme_confirm(self, p):
        self.log.append(p)
        if isinstance(p, ML.MlmeScanConfirm) and self.state == 'scan':
            cands = [d for d in p.BSSDescriptionSet if d.SSID == self.ssid or
                     (self.bssid_hint is not None and d.BSSID == self.bssid_hint and not d.SSID)]
            if not cands:
                self.state = 'failed'
                return
            self.bss = max(cands, key=lambda d: d.best_sector[2])
            if not self.bss.SSID:
                self.bss = replace(self.bss, SSID=self.ssid)
            self.state = 'join'
            self.mac.mlme_request(ML.MlmeJoinRequest(SelectedBSS=self.bss, JoinFailureTimeout=4))
        elif isinstance(p, ML.MlmeJoinConfirm):
            if p.ResultCode != ML.SUCCESS:
                self.state = 'failed'
                return
            if self.bf == 'dti':
                self.state = 'bf'
                self.mac.mlme_request(ML.MlmeBfTrainingRequest(PeerSTAAddress=self.bss.BSSID))
            else:
                self.state = 'bf'          # ждём MLME-BF-TRAINING.indication (A-BFT)
        elif isinstance(p, ML.MlmeBfTrainingConfirm):
            if p.ResultCode != ML.SUCCESS:
                if self.state == 'bf':
                    self.mac.mlme_request(ML.MlmeBfTrainingRequest(PeerSTAAddress=self.bss.BSSID))
                return
            if self.state == 'bf':
                self._after_bf()
        elif isinstance(p, ML.MlmeScanConfirm) and self.state == 'probe':
            self._associate()
        elif isinstance(p, ML.MlmeAssociateConfirm):
            if p.ResultCode != ML.SUCCESS:
                self.state = 'failed'
                return
            self.state = 'associated'
            if self.addba == 'ul' and not self.ul_bytes:
                self._data()
                return
            self._request(ML.MlmeAddbaRequest(PeerSTAAddress=self.bss.BSSID, DialogToken=0x21, TID=0, BufferSize=64))
        elif isinstance(p, ML.MlmeAddbaConfirm) and p.ResultCode == ML.SUCCESS:
            self._data()

    def _data(self):
        self.state = 'data'
        if self.bf == 'both':
            self.mac.mlme_request(ML.MlmeBfTrainingRequest(PeerSTAAddress=self.bss.BSSID))
        self.ul = msdus(self.ul_bytes, seed=0x10)
        self._send(self.bss.BSSID, self.ul)

    def mlme_indication(self, p):
        self.log.append(p)
        if isinstance(p, ML.MlmeBfTrainingIndication) and self.state == 'bf' and p.ResultCode == ML.SUCCESS:
            self._after_bf()
        elif isinstance(p, ML.MlmeAddbaIndication):
            self.mac.mlme_response(ML.MlmeAddbaResponse(PeerSTAAddress=p.PeerSTAAddress, DialogToken=p.DialogToken,
                                                        TID=p.TID, ResultCode=ML.SUCCESS, BufferSize=64))

    def _after_bf(self):
        if self.probe:
            self.state = 'probe'
            self.mac.mlme_request(ML.MlmeScanRequest(ScanType=ML.ACTIVE, BSSID=self.bss.BSSID, SSID=self.ssid,
                                                     MaxChannelTime=40))
        else:
            self._associate()

    def _associate(self):
        self.state = 'assoc'
        self._request(ML.MlmeAssociateRequest(PeerSTAAddress=self.bss.BSSID))

    def _request(self, req):
        if self.pause_us:
            self.mac.sim.after(self.pause_us, self.mac.mlme_request, req)
        else:
            self.mac.mlme_request(req)
