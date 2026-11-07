# SPDX-License-Identifier: AGPL-3.0-or-later
"""Точка доступа DMG (инфраструктура, BSS Type 3) ядра: BI = BTI + A-BFT + DTI (CBAP Only), ATI нет.

  MLME-START.request → TBTT каждые BeaconPeriod TU, TSF 0 — TBTT (11.1.3.3.1); TSF точки = модельное время.
  BTI: DMG Beacon по всем секторам через SBIFS, CDOWN до 0, Duration — остаток BTI (10.42.4, 9.3.4.2;
       bi.txss_plan/bti_beacons), Timestamp — TSF начала символа данных (11.1.3.1, sap_phy.data_symbol_offset).
       BIC (рис. 9-77): ATI Present 0, Next A-BFT 0 (A-BFT в каждом BI), A-BFT Length/FSS, IsResponderTXSS 1;
       DMG Parameters: BSS Type 3, CBAP Only 1, CBAP Source 0 (9.4.1.46). Элементы (табл. 9-45): DMG Capabilities,
       DMG Operation, SSID.
  A-BFT: через MBIFS после BTI (10.42.5.1); приём SSW квази-омни, SSW-Feedback в слоте одному ответчику
       (abft.ApAbft, 10.42.5.2) через его Sector Select; затем обязанность — BRP с Capability Request = 1 в
       aMinBTIPeriod BI (10.42.5.2) — BRP setup в CBAP.
  DTI: один CBAP после guard (10.39.6.3, bi.guard_between) до следующего TBTT; EDCA (mac.py).
  Probe Request → Probe Response (11.1.4.3.4); Association Request → MLME-ASSOCIATE.indication → .response →
  Association Response (EDCA Parameter Set, DMG Capabilities, DMG Operation), State 4 по Ack (11.3.5.3 n)).
  Данные — From DS = 1 (табл. 9-4), только STA в State 4 (класс 3, 11.3.3)."""
from fractions import Fraction as Fr
from math import ceil

from .. import abft as A
from .. import bi as B
from .. import cbap as C
from .. import elements as E
from .. import fields as F
from .. import mlme as M
from ..timing import DOT11_MAX_LOST_BEACONS, TU, aMinBTIPeriod, txtime_control
from . import frames as FR
from . import sap_mlme as ML
from . import sap_phy as P
from .mac import MAX_AMPDU_EXP, DmgMac, ampdu_limit

# EDCA Parameter Set точки (9.4.2.28): {ACI: (AIFSN, CWmin, CWmax, TXOP мкс)}. AIFSN/CW — табл. 9-155;
# TXOP Limit AC_BE — 2048 мкс (выбор точки, 10.2.3.2: «AP … may use a different set»): RTS/DMG CTS + A-MPDU + BlockAck
# + обмен CF-End в одном TXOP (10.23.2.9; лимит 0 допускает лишь одну MSDU/A-MPDU без CF-End-запаса).
TXOP_BE_US = 2048
EDCA_ADVERTISED = {0: (3, C.aCWmin, C.aCWmax, TXOP_BE_US), 1: (7, C.aCWmin, C.aCWmax, 0),
                   2: (2, (C.aCWmin + 1) // 2 - 1, C.aCWmin, 0), 3: (2, (C.aCWmin + 1) // 4 - 1,
                                                                    (C.aCWmin + 1) // 2 - 1, 0)}
ACI_AC = {0: C.AC_BE, 1: C.AC_BK, 2: C.AC_VI, 3: C.AC_VO}


def bss_cfg():
    """9.4.2.128, рис. 9-557: DMG BSS Parameter Configuration — MIB DEFVAL (как dmg_sta.Network)."""
    return dict(ps_request_suspension_interval=M.DOT11_PS_REQUEST_SUSPENSION_INTERVAL,
                min_bhi_duration=int(M.DOT11_MIN_BHI_DURATION),
                broadcast_sta_info_duration=M.DOT11_BROADCAST_STA_INFO_DURATION, assoc_resp_confirm_time=10,
                min_pp_duration=M.DOT11_MIN_PP_DURATION, sp_idle_timeout=M.DOT11_SP_IDLE_TIMEOUT,
                max_lost_beacons=DOT11_MAX_LOST_BEACONS)


def apply_edca(mac, params):
    """EDCA Parameter Set → EDCAF AC_VO/AC_BE (10.2.3.2: STA использует параметры точки)."""
    for aci, (aifsn, cwmin, cwmax, txop) in params.items():
        ac = ACI_AC[aci]
        if ac in mac.acs:
            ed = mac.acs[ac].ed
            ed.p = C.EdcaParams(cwmin, cwmax, aifsn, txop)
            ed.cw = min(max(ed.cw, cwmin), cwmax)
            mac.txop_limit[ac] = Fr(txop)


class DmgApMac(DmgMac):
    ROLE = 'AP'

    def __init__(self, sim, addr, sectors=8, seed=0, max_sta=8, **kw):
        super().__init__(sim, addr, sectors, seed, **kw)
        self.bssid = addr
        self.apmlme = M.ApMlme(addr, max_sta=max_sta)
        self.max_sta = max_sta
        self.k = None
        self.plan = None
        self.apabft = None
        self.ssw_rx = {}
        self.assoc_req = {}
        self.brp_pending = set()
        self.edca_params = dict(EDCA_ADVERTISED)

    # ------------------------------------------------------------------ MLME-START (6.3.11, 11.1.4.4)
    def _req_MlmeStartRequest(self, prim):
        self.ssid, self.bi_tu = prim.SSID, prim.BeaconPeriod
        self.abft_slots, self.fss = prim.abft_slots, prim.fss_frames
        if prim.EDCAParameterSet:
            self.edca_params = dict(prim.EDCAParameterSet)
        apply_edca(self, self.edca_params)
        bi = self.bi_tu * TU
        k = ceil(self.sim.now / bi)
        self.sim.at(k * bi, self._tbtt, k)
        self._confirm(ML.MlmeStartConfirm(ResultCode=ML.SUCCESS))

    def dmg_capabilities(self):
        """9.4.2.127: одна RX DMG-антенна, Total Number of Sectors = число − 1, SC MCS до 12."""
        sc = dict(num_rx_dmg_antennas=0, total_num_sectors=len(self.sectors) - 1, max_sc_rx_mcs=12, max_sc_tx_mcs=12,
                  code_rate_13_16=1, max_ampdu_len_exp=MAX_AMPDU_EXP)
        return E.encode_dmg_capabilities(E.DmgCapabilities(self.addr, 0, sc, dict(max_associated_sta=self.max_sta),
                                                           0, {}, 0, 0))

    def dmg_operation(self):
        return E.encode_dmg_operation(dict(tddti=0, pseudo_static=0, pcp_handover=0), bss_cfg())

    def _beacon_elements(self):
        els = [self.dmg_capabilities(), self.dmg_operation(), E.encode_ssid(self.ssid)]
        return tuple((e.eid, e.ext, e.info) for e in E.parse_elements(b''.join(els)))

    def _bic(self):
        return F.Bic(ati_present=0, abft_length=self.abft_slots - 1, fss=self.fss - 1, is_resp_txss=1, next_abft=0,
                     txss_span=1, n_bis_abft=1)

    def _beacon(self, ts_tsf, sector, cdown, dur):
        f = F.DmgBeacon(duration=int(dur), bssid=self.addr, timestamp=int(ts_tsf),
                        ssw=F.Ssw(direction=F.DIR_INITIATOR, cdown=cdown, sector_id=sector, antenna_id=0),
                        beacon_interval=self.bi_tu, bic=self._bic(),
                        params=F.DmgParams(bss_type=3, cbap_only=1, cbap_source=0), cc=None,
                        elements=self._beacon_elements())
        return F.encode_dmg_beacon(f, with_fcs=False, role='ap', pcp=False, rx_antennas=1)

    # ------------------------------------------------------------------ BI
    def _tbtt(self, k):
        self.k = k
        bi = self.bi_tu * TU
        t0, t1 = B.tbtt(k, self.bi_tu), B.tbtt(k + 1, self.bi_tu)
        n_len = len(self._beacon(0, 0, 0, 0)) + 4
        t_b = txtime_control(n_len)
        _, _, btis = B.txss_plan(self.sectors)
        beacons, bti_end = B.bti_beacons(t0, btis[0], t_b)
        for ts, te, sec, cd, dur in beacons:
            self.sim.at(ts, self._tx_beacon, sec, cd, dur)
        L = A.AbftLayout(A.abft_start(bti_end), self.abft_slots, self.fss, True)
        self.plan = dict(k=k, bti_end=bti_end, layout=L)
        self.apabft = A.ApAbft(self.addr, L, bi=k)
        self.ssw_rx = {}
        for s in range(L.n_slots):
            self.sim.at(L.fb_start(s), self._abft_fb, s)
        # 10.39.6.3: CBAP Only — DTI = один CBAP после guard (bi.guard_between(False, True, BI)) до TBTT
        cs = L.end + B.guard_between(False, True, bi)
        self.set_cbap(cs, t1)
        self.sim.at(t1, self._tbtt, k + 1)

    def _tx_beacon(self, sector, cdown, dur):
        if self.tx_on:
            return
        ts = self.tsf() + P.data_symbol_offset(0)         # 11.1.3.1
        self._phy_tx([self._beacon(int(ts), sector, cdown, dur)], 0, P.Beam(sector))   # TSF — целые мкс

    # ------------------------------------------------------------------ A-BFT (10.42.5.2)
    def _rx_bf(self, f, rxv, t0):
        L = self.plan['layout'] if self.plan else None
        if f.kind == 'SSW' and L is not None and L.slot_of(t0) is not None:
            p = F.parse_frame(f.raw, with_fcs=False)
            s = L.slot_of(t0)
            fb = p.fb
            self.ssw_rx.setdefault(s, []).append(A.AirFrame(
                'SSW', t0, f.ta, f.ra, direction=p.ssw.direction, cdown=p.ssw.cdown, sector_id=p.ssw.sector_id,
                ant_id=p.ssw.antenna_id, sector_select=fb.sector_select, ant_select=fb.antenna_select,
                snr=F.snr_from_raw(fb.snr_report), poll=fb.poll_required,
                rx_snr=F.snr_quantize(Fr(rxv.SNR).limit_denominator(1000))))
            return
        super()._rx_bf(f, rxv, t0)

    def _abft_fb(self, s):
        rx = self.ssw_rx.pop(s, [])
        fb = self.apabft.slot_feedback(s, rx)
        if fb is None or self.tx_on:
            return
        sta = fb.dst
        raw = F.encode_frame(F.SswFbFrame(duration=0, ra=sta, ta=self.addr,
                                          fb=F.SswFb(sector_select=fb.sector_select, antenna_select=fb.ant_select,
                                                     snr_report=F.snr_report_raw(fb.snr)),
                                          brp=F.BrpReq(), blm=F.Blm()), with_fcs=False, abft=True,
                             sender_ap_pcp=True)
        ant, sec = fb.tx_sector
        beam = P.Beam(sec, ant)
        self.peer(sta).tx_beam = beam             # 10.42.5.2: связь с ответчиком — через его Sector Select
        self._phy_tx([raw], 0, beam)
        self.log('abft_feedback', sta=sta, slot=s, sector=sec)
        if sta not in self.brp_pending:
            # 10.42.5.2: BRP с Capability Request = 1 в одном из aMinBTIPeriod BI, начиная с этого
            self.brp_pending.add(sta)
            self._brp_setup(sta, self.k + aMinBTIPeriod - 1)

    def _brp_setup(self, sta, last_bi):
        def done(ok):
            if ok is True or self.k > last_bi:
                self.brp_pending.discard(sta)
            else:
                self._brp_setup(sta, last_bi)     # ответа нет (потеря) — снова, пока не вышли aMinBTIPeriod BI
        self.start_brp_setup(sta, done=done)

    # ------------------------------------------------------------------ кадры управления
    def _rx_mgmt_role(self, f, rxv):
        if f.kind == E.PROBE_REQ:
            self._probe_resp(f.ta)
        elif f.kind == E.ASSOC_REQ:
            self._on_assoc_req(f, rxv)

    def _probe_resp(self, sta):
        """11.1.4.3.4: Probe Response индивидуально, Timestamp — TSF начала символа данных (11.1.3.1)."""
        def body(t_sym):
            return E.encode_body(E.PROBE_RESP, {'timestamp': int(self.tsf(t_sym)),
                                                'beacon_interval': self.bi_tu,
                                                'capability': {'dmg_params': {'bss_type': 3, 'cbap_only': 1}}},
                                 [E.encode_ssid(self.ssid), FR.edca_parameter_set(self.edca_params),
                                  self.dmg_capabilities(), self.dmg_operation()])
        self.send_mgmt(E.PROBE_RESP, sta, body)

    def _on_assoc_req(self, f, rxv):
        sta = f.ta
        if sta in self.apmlme.pending_resp or sta in self.assoc_req:
            return                                # ответ уже готовится (повтор запроса)
        fx, els = E.parse_body(E.ASSOC_REQ, f.raw[24:])
        ssid = next((e.info for e in els if e.eid == E.EID_SSID), b'')
        caps = next((E.parse_dmg_capabilities(e.info) for e in els if e.eid == E.EID_DMG_CAPABILITIES), None)
        self.assoc_req[sta] = caps
        self._indicate(ML.MlmeAssociateIndication(PeerSTAAddress=sta, SSID=ssid, DMGCapabilities=caps))

    def _req_MlmeAssociateResponse(self, prim):
        sta = prim.PeerSTAAddress
        caps = self.assoc_req.pop(sta, None)
        result = E.SUCCESS if prim.ResultCode == ML.SUCCESS else 1
        status, aid, _ = self.apmlme.on_assoc_req(sta, self.sim.now, result=result)
        p = self.peer(sta)
        p.aid = aid
        if caps is not None:
            p.max_mcs = min(12, caps.sta_cap.get('max_sc_rx_mcs', 12))
            p.max_ampdu = ampdu_limit(caps)
        body = E.encode_body(E.ASSOC_RESP, {'capability': {'dmg_params': {'bss_type': 3, 'cbap_only': 1}},
                                            'status': status, 'aid': aid or 0},
                             [FR.edca_parameter_set(self.edca_params), self.dmg_capabilities(),
                              self.dmg_operation()])

        def done(ok):
            if status != E.SUCCESS:
                return
            if ok:
                st = self.apmlme.on_resp_acked(sta, self.k)  # 11.3.5.3 n): State 4 по Ack
                self.log('associated', sta=sta, state=st, aid=aid)
            else:
                self.apmlme.on_resp_abandoned(sta)
            self._medium_changed()
        self.send_mgmt(E.ASSOC_RESP, sta, lambda t: body, done=done)

    # ------------------------------------------------------------------ данные (табл. 9-4)
    def _ra_for(self, da):
        return da if self.apmlme.state(da) == M.S4 else None

    def _may_send_data(self, ra):
        return self.apmlme.state(ra) == M.S4

    def _may_rx_data(self, ta):
        # 11.3.3: класс 3 — только от STA в State 3/4
        return self.apmlme.state(ta) in (M.S3, M.S4)

    def _ds_bits(self):
        return (0, 1)

    def _addr3(self, sa, da):
        return sa

    def associated(self):
        return sorted(s for s in self.apmlme.peers if self.apmlme.state(s) == M.S4)
