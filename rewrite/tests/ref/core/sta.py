# SPDX-License-Identifier: AGPL-3.0-or-later
"""Станция DMG (non-AP STA) ядра.

  MLME-SCAN (PASSIVE): приём DMG Beacon квази-омни (11.1.4.2), BSSDescription с лучшим сектором точки по SNR;
                 (ACTIVE, после BF): Probe Request индивидуально, Probe Response (11.1.4.3).
  MLME-JOIN: по DMG Beacon выбранного BSS — принять TSF (Timestamp + время от начала символа данных, 11.1.3.1) и
             BeaconPeriod (11.1.4.5, mlme.Join); дальше TSF подстраивается по каждому маяку своей точки (11.1.3.7).
  BI по маякам: конец BTI — конец последнего принятого маяка + его Duration (10.42.5.1, PLAN.md №5; уточнение по
             CDOWN), A-BFT — abft.AbftLayout по BIC; CBAP Only — после guard (10.39.6.3) до следующего TBTT по своему
             TSF (минус aTSFResolution — см. README, трактовка «граница CBAP по TSF STA»).
  A-BFT: ответчик RSS (abft.Responder, 10.42.5.2): backoff по слотам, SSW через свои сектора, SSW Feedback —
         лучший сектор BTI; SSW-Feedback точки → луч передачи к точке; MLME-BF-TRAINING.indication(SUCCESS).
  SLS в DTI: MLME-BF-TRAINING.request → mac.start_sls (инициатор), .confirm.
  MLME-ASSOCIATE: DMG без аутентификации 802.11 — State 2 → 4 (11.3.1, mlme.StaMlme), Association Request через
             EDCA AC_VO, Response → EDCA Parameter Set точки (10.2.3.2), confirm.
  Данные — To DS = 1 (табл. 9-4) через точку."""
from fractions import Fraction as Fr
from math import floor

from .. import abft as A
from .. import bi as B
from .. import cbap as C
from .. import duration as D
from .. import elements as E
from .. import fields as F
from .. import mlme as M
from ..timing import aTSFResolution, SBIFS, TU
from . import frames as FR
from . import sap_mlme as ML
from . import sap_phy as P
from .ap import apply_edca
from .mac import MAX_AMPDU_EXP, DmgMac, ampdu_limit
from .. import chswitch as CS


SUPPORTED_CHANNELS = [(2, 1)]


def _caps_of(els):
    return next((E.parse_dmg_capabilities(e.info) for e in els if e.eid == E.EID_DMG_CAPABILITIES), None)


class DmgStaMac(DmgMac):
    ROLE = 'STA'

    def __init__(self, sim, addr, sectors=4, seed=0, assoc_timeout_tu=200, tsf_off=None, **kw):
        super().__init__(sim, addr, sectors, seed, **kw)
        # TSF до JOIN — свой, произвольный (11.1.3.1): модель — случайный сдвиг
        self.tsf_off = Fr(self.rng.randrange(1, 10 ** 9)) if tsf_off is None else Fr(tsf_off)
        self.mlme = M.StaMlme(addr, assoc_timeout_tu)
        self.scan = None
        self.join = None
        self.joined = False
        self.bti = {}
        self.need_bf = True
        self.resp = A.Responder(addr, [(0, s) for s in self.sectors], rng=C.Rng(self.rng.randrange(1 << 30)))
        self.cur_abft = None
        self.fb_slot = {}
        self.aid = None
        self.probe = None
        self.sls_job = None

    # ------------------------------------------------------------------ MLME-SCAN (6.3.3, 11.1.4)
    def _req_MlmeScanRequest(self, prim):
        if prim.ScanType == ML.PASSIVE:
            self.set_rx_beam(P.QUASI_OMNI)
            self.scan = dict(req=prim, found={})
            self.sim.after(prim.MaxChannelTime * TU, self._scan_end)
            return
        # активный (DMG, 11.1.4.3.1: Probe Request — после BF с точкой)
        if not self.joined or self.need_bf:
            self._confirm(ML.MlmeScanConfirm(ResultCode=ML.INVALID_PARAMETERS))
            return
        caps = self.dmg_capabilities()
        body = E.encode_body(E.PROBE_REQ, {}, [E.encode_ssid(prim.SSID or self.ssid), caps])
        self.probe = dict(req=prim, resp=None)
        self.send_mgmt(E.PROBE_REQ, prim.BSSID, lambda t: body, name='Probe Request')
        self.sim.after(prim.MaxChannelTime * TU, self._probe_end)

    def _scan_end(self):
        s, self.scan = self.scan, None
        self._confirm(ML.MlmeScanConfirm(BSSDescriptionSet=list(s['found'].values()), ResultCode=ML.SUCCESS))

    def _probe_end(self):
        pr, self.probe = self.probe, None
        if pr is None:
            return
        self._confirm(ML.MlmeScanConfirm(BSSDescriptionSet=[pr['resp']] if pr['resp'] else [],
                                         ResultCode=ML.SUCCESS))

    def dmg_capabilities(self):
        sc = dict(num_rx_dmg_antennas=0, total_num_sectors=len(self.sectors) - 1, max_sc_rx_mcs=12, max_sc_tx_mcs=12,
                  code_rate_13_16=1, max_ampdu_len_exp=MAX_AMPDU_EXP, grant_ack=self.grant_ack_supported)
        return E.encode_dmg_capabilities(E.DmgCapabilities(self.addr, self.aid or 0, sc, {}, self.bf.bt_time_limit,
                                                           {}, 0, 0))

    # ------------------------------------------------------------------ MLME-JOIN (6.3.4, 11.1.4.5)
    def _req_MlmeJoinRequest(self, prim):
        bss = prim.SelectedBSS
        self.join = M.Join(bss.BSSID, bss.BeaconPeriod, prim.JoinFailureTimeout, t0=self.sim.now)
        self.bssid, self.ssid = bss.BSSID, bss.SSID
        self.sim.after(prim.JoinFailureTimeout * bss.BeaconPeriod * TU + 1, self._join_check)

    def _join_check(self):
        if self.join is not None and not self.joined and self.join.tick(self.sim.now) == 'FAILURE':
            self.join = None
            self._confirm(ML.MlmeJoinConfirm(ResultCode='FAILURE'))

    # ------------------------------------------------------------------ DMG Beacon
    def _rx_beacon(self, f, rxv, t0):
        b = F.parse_dmg_beacon(f.raw, with_fcs=False)
        if self.scan is not None:
            d = self.scan['found'].get(b.bssid)
            ssid = next((e[2] for e in b.elements if e[0] == E.EID_SSID), b'')
            if d is None or rxv.SNR > d.best_sector[2]:
                self.scan['found'][b.bssid] = ML.BSSDescription(
                    BSSID=b.bssid, SSID=ssid, BeaconPeriod=b.beacon_interval, Timestamp=b.timestamp,
                    LocalTime=int(self.tsf(t0)), best_sector=(b.ssw.sector_id, b.ssw.antenna_id, rxv.SNR))
        if self.bssid is None or b.bssid != self.bssid:
            return                                         # 11.1.3.7: только свой BSSID
        if self.joined and b.beacon_interval != self.bi_tu:
            # 11.29.3: новый BI — по полю Beacon Interval маяка (TSF точки сброшен в 0 — индексы BI с нуля)
            self.log('bss_bi_change', bi=b.beacon_interval)
            self.bi_tu = b.beacon_interval
            self.bti = {}
        # 11.1.3.1: Timestamp = TSF точки в начале символа данных с первым битом кадра → свой TSF к нему
        t_sym = t0 + P.data_symbol_offset(rxv.MCS)
        if self.join is not None and not self.joined:
            if self.join.on_beacon(self.sim.now, b.bssid, b.timestamp, b.beacon_interval) == 'SUCCESS':
                self.joined = True
                self.bi_tu = b.beacon_interval
                self.tsf_off = b.timestamp - t_sym
                self.monitor = M.LinkMonitor(b.bssid, self.bi_tu, t0=self.sim.now)
                self.log('join', bssid=b.bssid)
                self._confirm(ML.MlmeJoinConfirm(ResultCode=ML.SUCCESS))
        if not self.joined:
            return
        self.tsf_off = b.timestamp - t_sym
        self.monitor.on_rx(self.sim.now, 'DMG Beacon', b.bssid)
        bi = self.bi_tu * TU
        # BI маяка — ближайший TBTT по своему TSF (свой TSF отстаёт от точки на долю мкс: Timestamp — целые мкс)
        k = floor(self.tsf(t0) / bi + Fr(1, 2))
        info = self.bti.get(k)
        if info is None:
            info = self.bti[k] = self._bti_info(k, b, t0)
            for kk in [x for x in self.bti if x < k - 2]:
                del self.bti[kk]
        if rxv.SNR > info['best'][2]:
            info['best'] = (b.ssw.sector_id, b.ssw.antenna_id, rxv.SNR)
        self._sta_rx_ecsa(k, b.elements)               # смена канала (bsschg.py, 11.8.8.6)

    def _bti_info(self, k, b, t0):
        """Первый принятый маяк BTI k: конец BTI, A-BFT, CBAP."""
        te = self.sim.now
        # 10.42.5.1: конец BTI — истечение Duration последнего маяка; Duration округлён вверх (9.2.5.1), уточнение по
        # CDOWN (10.42.2.2.2, маяки одной длины): te + CDOWN·(TXTIME + SBIFS), если согласуется с Duration
        est = te + b.ssw.cdown * (te - t0 + SBIFS)
        end = est if D.field(est - te) == b.duration else te + b.duration
        bic = A.BeaconIntervalControl.decode(F.encode_bic(b.bic))
        info = dict(best=(0, 0, -100.0), bic=bic, end=end, layout=None)
        bi = self.bi_tu * TU
        cs = end
        if b.bic.next_abft == 0:
            L = info['layout'] = A.AbftLayout.from_bic(bic, end)
            cs = L.end
            self.sim.at(L.start, self._abft_begin, k)
        # 11.27.1: таймеры связи останавливаются в BTI и A-BFT (BTI — с TBTT по своему TSF)
        self.add_halt(self.t_of_tsf(k * bi), cs)
        if b.params.cbap_only:
            # 10.39.6.3: CBAP Only — после guard до следующего TBTT по своему TSF; обмен должен укладываться с запасом
            # aTSFResolution (TSF и Timestamp — целые мкс, 11.1.3.1: свой TSF отстаёт от точки до 1 мкс + распространение)
            self.set_cbap(cs + B.guard_between(False, True, bi), self.t_of_tsf((k + 1) * bi), margin=aTSFResolution)
        else:
            self._sta_schedule(k, b, t0, end, cs)  # Extended Schedule (10.39.6.1, dti.py)
        return info

    # ------------------------------------------------------------------ A-BFT (10.42.5.2)
    def _abft_begin(self, k):
        b = self.bti.get(k)
        if b is None or not self.need_bf or b['layout'] is None:
            return
        sec, ant, snr = b['best']
        beacon = A.BeaconRx(b['bic'], self.bssid, received=True, bss_type=3,
                            best=(sec, ant, F.snr_quantize(Fr(snr).limit_denominator(1000))))
        L = b['layout']
        if not self.resp.begin_abft(beacon, L):
            return
        self.set_rx_beam(P.QUASI_OMNI)
        self.cur_abft = (k, L)
        self.fb_slot = {}
        self._abft_slot(0)

    def _abft_slot(self, s):
        k, L = self.cur_abft
        for f in self.resp.slot_tx(s):
            fb = F.SswFb(sector_select=f.sector_select, antenna_select=f.ant_select,
                         snr_report=F.snr_report_raw(f.snr), poll_required=f.poll)
            raw = F.encode_frame(F.SswFrame(duration=f.duration, ra=f.dst, ta=self.addr,
                                            ssw=F.Ssw(direction=f.direction, cdown=f.cdown, sector_id=f.sector_id,
                                                      antenna_id=f.ant_id), fb=fb), with_fcs=False, in_cbap=False)
            self.sim.at(f.t, self._abft_tx, raw, P.Beam(f.sector_id, f.ant_id))
        self.sim.at(L.slot_end(s), self._abft_slot_end, s)

    def _abft_tx(self, raw, beam):
        if not self.tx_on:
            self._phy_tx([raw], 0, beam)

    def _rx_bf(self, f, rxv, t0):
        if f.kind == 'SSW-Feedback' and self.cur_abft is not None and f.ta == self.bssid:
            k, L = self.cur_abft
            s = L.slot_of(t0)
            if s is not None:
                p = F.parse_frame(f.raw, with_fcs=False)
                self.fb_slot[s] = A.AirFrame('SSW-Feedback', t0, f.ta, f.ra, sector_select=p.fb.sector_select,
                                             ant_select=p.fb.antenna_select, snr=F.snr_from_raw(p.fb.snr_report))
            return
        super()._rx_bf(f, rxv, t0)

    def _abft_slot_end(self, s):
        if self.cur_abft is None:
            return
        k, L = self.cur_abft
        fb = self.fb_slot.pop(s, None)
        self.resp.slot_end(s, fb)
        if fb is not None and fb.dst == self.addr and self.resp.fb is fb:
            # 10.42.2.4: Sector Select / DMG Antenna Select — лучший сектор передачи к точке
            self.peer(self.bssid).tx_beam = P.Beam(fb.sector_select, fb.ant_select)
            self.peer(self.bssid).rx_beam = None
            self.need_bf = False
            self.log('bf_abft', sector=fb.sector_select)
            self._bf_snr_reset(self.bssid)
            self._indicate(ML.MlmeBfTrainingIndication(PeerSTAAddress=self.bssid, ResultCode=ML.SUCCESS))
        if s + 1 < L.n_slots and self.resp.state in ('backoff', 'tx'):
            self._abft_slot(s + 1)
        else:
            self.resp.end_abft()
            self.cur_abft = None

    # ------------------------------------------------------------------ MLME-BF-TRAINING (6.3.91, 10.42.6.2)
    def _bf_training_done(self, peer, ok):
        """MLME-BF-TRAINING.request (SLS / SLS + BRP — mac.py) завершён."""
        if ok:
            self.need_bf = False

    def _rebf(self, peer, why):
        """Повторное BF с точкой (политика деградации/истечения таймера связи, bf.py): 11.27.1 — станция, которая ещё
        принимает DMG Beacon с Next A-BFT = 0, «should improve the link quality by performing RSS during the A-BFT»;
        иначе — SLS в DTI."""
        if peer == self.bssid and not getattr(self, 'rebf_dti', False) and self._abft_announced():
            if not self.need_bf:
                self.need_bf = True
                self.log('rebf_abft', peer=peer, why=why)
            return
        super()._rebf(peer, why)

    def _abft_announced(self):
        k = max(self.bti) if self.bti else None
        return k is not None and self.bti[k]['layout'] is not None

    # ------------------------------------------------------------------ MLME-ASSOCIATE (6.3.7, 11.3.5.2)
    def _req_MlmeAssociateRequest(self, prim):
        ap = prim.PeerSTAAddress
        try:
            self.mlme.associate(ap, self.sim.now, ssid=self.ssid)
        except M.Refused:
            self._confirm(ML.MlmeAssociateConfirm(ResultCode=ML.REFUSED, PeerSTAAddress=ap))
            return
        # 11.8.2.2: «When it (re)associates, the STA shall provide to the AP … a list of channels» — Supported
        # Channels (9.4.2.17): канал 2 (20.3.1: «shall support channel number 2»; PHYCONFIG OPERATING_CHANNEL 3)
        body = E.encode_body(E.ASSOC_REQ, {'capability': {'dmg_params': {}}, 'listen_interval': prim.ListenInterval},
                             [E.encode_ssid(self.ssid), CS.encode_supported_channels(SUPPORTED_CHANNELS)] +
                             ([self.rm_enabled_el()] if self.rm_link_meas else []) +    # табл. 9-34: RM — 10-й
                             [self.dmg_capabilities()])
        self.send_mgmt(E.ASSOC_REQ, ap, lambda t: body, name='Association Request')
        self.sim.after(self.mlme.assoc_timeout_tu * TU + 1, self._assoc_tick)

    def _assoc_tick(self):
        if self.mlme.tick(self.sim.now):
            self._confirm(ML.MlmeAssociateConfirm(ResultCode=ML.TIMEOUT, PeerSTAAddress=self.bssid))

    def _rx_mgmt_role(self, f, rxv):
        if f.ta != self.bssid:
            return
        if f.kind == E.ASSOC_RESP:
            fx, els = E.parse_body(E.ASSOC_RESP, f.raw[24:])
            cfg, edca = None, None
            for e in els:
                if e.eid == E.EID_DMG_OPERATION:
                    cfg = E.parse_dmg_operation(e.info)[1]
                elif e.eid == 12:
                    edca = FR.parse_edca_parameter_set(e.info)
            caps = _caps_of(els)
            if caps is not None:
                self.peer(f.ta).max_ampdu = ampdu_limit(caps)
                self.peer(f.ta).caps = caps
            if cfg:
                # 11.3.5.2 d): MIB ← DMG BSS Parameter Configuration; значение вне SYNTAX MIB установить нельзя —
                # поле не принимается (MIB прежний), ответ точки — не повод рвать ассоциацию
                bad = {k: v for k, v in cfg.items() if k in M.BSS_PARAM_TO_MIB and
                       not M.BSS_PARAM_TO_MIB[k][1] <= v <= M.BSS_PARAM_TO_MIB[k][2]}
                if bad:
                    self.log('dmg_bss_param_invalid', fields=bad)
                    cfg = {k: v for k, v in cfg.items() if k not in bad}
            st = self.mlme.on_assoc_resp(f.ta, self.sim.now, fx['status'], dmg_op_cfg=cfg)
            if st is None:
                return
            ok = fx['status'] == E.SUCCESS and st in (M.S3, M.S4)
            if ok:
                self.aid = fx['aid'] & 0xFF
                if edca:
                    apply_edca(self, edca)
                self.log('associated', aid=self.aid, state=st)
            self._confirm(ML.MlmeAssociateConfirm(ResultCode=ML.SUCCESS if ok else ML.REFUSED,
                                                  AssociationID=self.aid or 0, EDCAParameterSet=edca,
                                                  PeerSTAAddress=f.ta))
            self._medium_changed()
        elif f.kind == E.PROBE_RESP and self.probe is not None:
            fx, els = E.parse_body(E.PROBE_RESP, f.raw[24:])
            caps = _caps_of(els)
            if caps is not None:
                self.peer(f.ta).max_ampdu = ampdu_limit(caps)
                self.peer(f.ta).caps = caps
            ssid = next((e.info for e in els if e.eid == E.EID_SSID), b'')
            self.probe['resp'] = ML.BSSDescription(BSSID=f.ta, SSID=ssid, BeaconPeriod=fx['beacon_interval'],
                                                   Timestamp=fx['timestamp'], LocalTime=int(self.tsf()))
            pr, self.probe = self.probe, None
            self._confirm(ML.MlmeScanConfirm(BSSDescriptionSet=[pr['resp']], ResultCode=ML.SUCCESS))

    # ------------------------------------------------------------------ данные
    def _associated(self):
        return self.bssid is not None and self.mlme.state(self.bssid) == M.S4

    def _ra_for(self, da):
        return self.bssid if self._associated() else None

    def _may_send_data(self, ra):
        return ra == self.bssid and self._associated()

    def _may_rx_data(self, ta):
        return ta == self.bssid and self._associated()
