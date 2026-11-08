# SPDX-License-Identifier: AGPL-3.0-or-later
"""Измерение линка и обнаружение пиров (этап 4, п. 3): Link Measurement с DMG Link Margin и DMG LA Ack (10.43.1,
10.43.2, 11.10.11), Information Request/Response (11.28) — часть DMG MAC ядра (примесь к mac.DmgMac). Модели —
ref/linkadapt (LinkMeasResponder, TpcPeer, кодеки), ref/discovery (InfoStation); судьи — air_judge `link_meas`,
`link_margin`, `info_req`.

Link Measurement:
  - MLME-LINKMEASURE.request (6.3.32.2) → Link Measurement Request (9.6.6.4, Action с Ack, Dialog Token ≠ 0); после
    Ack — кадр измерения: отвечающая STA меряет следующий кадр запросившей (10.43.1), без данных к ней — QoS Null;
  - отвечающая STA (dot11RMLinkMeasurementActivated = rm_link_meas): отчёт (9.6.6.5) — TPC Report (мощность отчёта,
    Link Margin кадра запроса), антенны, RCPI/RSNI кадра запроса, DMG Link Margin по кадру измерения: Activity,
    рекомендованная MCS, Link Margin, SNR, Reference Timestamp — младшие 4 октета TSF конца PPDU измерения (10.43.1,
    ref/linkadapt.LinkMeasResponder); AP с dot11RMLinkMeasurementActivated = false запрос игнорирует (11.10.11);
  - запросившая STA: MLME-LINKMEASURE.confirm; рекомендация MCS (Activity «Change MCS») — верхняя граница своей MCS к
    пиру (обратная связь о канале пира: снимает допущение взаимности адаптации MCS ядра); Activity «уменьшить/увеличить
    мощность» — ядро мощность не меняет: DMG LA Ack с Activity 0 («did not change») в отчёте с токеном 0 не позже
    2·aPPDUMaxTime после Ack на полученный отчёт (10.43.2, ref/linkadapt.TpcPeer).
Information Request/Response (11.28):
  - запрос SME (`info_request`; MLME-примитива в 6.3 нет): Subject Address — STA или broadcast (только точке), свой DMG
    Capabilities, Request с ID элементов (проверка присутствия — Request без ID);
  - ответ (ref/discovery.InfoStation): точка — только при 11.28.2 a–c, о себе/члене BSS/всех; non-AP — о себе, иначе
    «без элементов»; RCPI/RSNI — при dot11RadioMeasurementActivated; ответ — Action с Ack запросившему.

Не исполняется: быстрая адаптация (10.43.3 — требует RD, у нас выключен намеренно, PLAN №35), управление мощностью
(TPC по рекомендации), Radio Measurement Request/Report, unsolicited Information Response, robust-защита (RSNA)."""
from fractions import Fraction as Fr

from .. import discovery as DS
from .. import elements as E
from .. import linkadapt as LA
from ..medium import SENSITIVITY_DBM
from ..timing import BCAST, TSF_LOW_MOD, TU
from . import sap_mlme as ML

LM_TIMEOUT_TU = 20                          # нет отчёта за столько TU — MLME-LINKMEASURE.confirm(UNSPECIFIED_FAILURE)
POWER_ADVICE_DB = 10                        # запас Link Margin, с которого отвечающая STA советует уменьшить мощность


class LmMixin:
    """Link Measurement и Information Request/Response — для mac.DmgMac."""

    def _lm_init(self):
        self.rm_link_meas = False            # dot11RMLinkMeasurementActivated (11.10.11)
        self.radio_measurement = False       # dot11RadioMeasurementActivated (RCPI/RSNI в Information Response)
        self.lm_power_advice = False         # отвечающая STA советует мощность (Activity 2/3, 10.43.2)
        self.tx_power_dbm = 10               # мощность передачи (TPC Report, 9.4.2.16; модель — постоянная)
        self.max_tx_power_dbm = 10
        self._lm_resp = None
        self._lm_wait = {}                   # PeerMACAddress → (DialogToken, событие тайм-аута)
        self._lm_token = 0
        self.info_rx = []                    # принятые Information Response (тела)

    # ------------------------------------------------------------------ элементы возможностей
    def rm_enabled_el(self):
        """RM Enabled Capabilities (9.4.2.45): бит 0 — Link Measurement Capability Enabled (табл. 9-179)."""
        return E.encode_element(LA.EID_RM_ENABLED, bytes([1 if self.rm_link_meas else 0, 0, 0, 0, 0]))

    # ------------------------------------------------------------------ MLME-LINKMEASURE (6.3.32)
    def _req_MlmeLinkMeasureRequest(self, prim):
        peer = prim.PeerMACAddress
        tok = prim.DialogToken
        req = LA.LmRequest(tok, prim.TransmitPower, prim.MaxTransmitPower)
        body = LA.encode_lm_request(req)

        def done(ok):
            if not ok:
                self._lm_finish(peer, ML.UNSPECIFIED_FAILURE, tok)
                return
            # 10.43.1: токен ≠ 0 — измерение на следующем кадре; без данных к пиру — QoS Null (кадр измерения)
            if tok and not self._has_data_for(peer):
                self._send_qos_null(peer, why='lm_measure_frame')
        ev = self.sim.after(LM_TIMEOUT_TU * TU, self._lm_finish, peer, ML.UNSPECIFIED_FAILURE, tok)
        self._lm_wait[peer] = (tok, ev)
        self.send_mgmt('Action', peer, lambda t: body, done=done, name='Link Measurement Request')

    def _lm_finish(self, peer, result, tok, rep=None):
        w = self._lm_wait.pop(peer, None)
        if w is None:
            return
        w[1].cancel()
        m = rep.margin if rep is not None else None
        self._confirm(ML.MlmeLinkMeasureConfirm(
            ResultCode=result, DialogToken=tok, PeerMACAddress=peer,
            TransmitPower=rep.tpc_tx_power if rep else None, LinkMargin=rep.tpc_link_margin if rep else None,
            RCPI=rep.rcpi if rep else None, RSNI=rep.rsni if rep else None,
            ReceiveAntennaID=rep.rx_antenna if rep else None, TransmitAntennaID=rep.tx_antenna if rep else None,
            DMGLinkMargin=m))

    # ------------------------------------------------------------------ приём
    def _lm_rx_measure(self, f, rxv):
        """Каждый принятый кадр от пира: измерение для ожидающего отчёта (10.43.1: «the next frame received from the
        requesting STA»)."""
        if self._lm_resp is None or f.ta is None:
            return
        out = self._lm_resp.on_rx(f.ta, self._lm_rxmeas(f, rxv))
        if out is not None:
            self._lm_send_report(*out)

    def _lm_rxmeas(self, f, rxv):
        snr = Fr(rxv.SNR).limit_denominator(1000) if rxv.SNR is not None else Fr(0)
        need = SENSITIVITY_DBM[str(rxv.MCS)] - SENSITIVITY_DBM['0'] + 2       # SNR на чувствительности MCS (модель)
        margin = int((snr - need).__floor__())
        return LA.Rx(int(self.tsf()) % TSF_LOW_MOD, f.ta, snr, max(-127, min(127, margin)),
                     Fr(rxv.RCPI).limit_denominator(100) if rxv.RCPI is not None else None, None, 0)

    def _lm_policy(self, rx):
        """Activity и MCS DMG Link Margin («implementation specific», 9.4.2.142): MCS — адаптация ядра по SNR кадра
        измерения; Activity 1 (Change MCS), если она отличается от MCS кадра; при большом запасе и lm_power_advice —
        уменьшить мощность (2)."""
        mcs = self._la_snr(rx.snr)
        if self.lm_power_advice and rx.margin is not None and rx.margin >= POWER_ADVICE_DB:
            return LA.ACTIVITY_DEC_POWER, str(mcs)
        return (LA.ACTIVITY_MCS if mcs != getattr(self, '_lm_meas_mcs', mcs) else LA.ACTIVITY_NO_CHANGE), str(mcs)

    def _rx_lm(self, f, rxv):
        body = f.raw[24:]
        if f.action == 'Link Measurement Request':
            req, _ = LA.parse_lm_request(body)
            if self._lm_resp is None:
                self._lm_resp = LA.LinkMeasResponder(self, activated=self.rm_link_meas, is_ap=self.ROLE == 'AP',
                                                     policy=self._lm_policy, tx_power=self.tx_power_dbm)
            self._lm_resp.activated = self.rm_link_meas
            if not self.rm_link_meas:
                # 11.10.11: AP с dot11RMLinkMeasurementActivated = false — игнорирует; non-AP — тоже не отвечает
                self.log('lm_ignored', peer=f.ta)
                return
            self._lm_meas_mcs = rxv.MCS
            out = self._lm_resp.on_request(f.ta, req, self._lm_rxmeas(f, rxv))
            if out is not None:
                self._lm_send_report(*out)
            return
        rep = LA.parse_lm_report(body)
        if rep.token and f.ta in self._lm_wait and self._lm_wait[f.ta][0] == rep.token:
            m = rep.margin
            if m is not None and m.activity == LA.ACTIVITY_MCS:
                name = LA.mcs_name(m.mcs)
                if name is not None and name.isdigit():
                    self.peer(f.ta).lm_mcs = int(name)      # рекомендация пира — верхняя граница своей MCS к нему
            self.log('lm_report', peer=f.ta, activity=m.activity if m else None, mcs=m.mcs if m else None)
            self._lm_finish(f.ta, ML.SUCCESS, rep.token, rep)
        if rep.margin is not None and rep.margin.activity in LA.ACTIVITY_POWER:
            # 10.43.2: рекомендацию мощности ядро не выполняет — может послать LA Ack с Activity 0
            tp = LA.TpcPeer(self, implements=False, ack_when_not=True)
            tmpl = LA.LmReport(0, self.tx_power_dbm, 0, 0, 0, LA.rcpi(rxv.RCPI), LA.RSNI_NA, None, None, b'')
            res = tp.on_report(rep, self.sim.now, tmpl)
            if res is not None:
                deadline, ack_rep = res
                # Ack на отчёт — через SIFS после него: срок — от конца Ack (PLAN №37)
                self._lm_send_report(f.ta, ack_rep, deadline=deadline + 20)

    def _lm_send_report(self, ra, rep, deadline=None):
        body = LA.encode_lm_report(rep)
        job = self.send_mgmt('Action', ra, lambda t: body, name='Link Measurement Report')
        if deadline is not None:
            # 10.43.2: не позже 2·aPPDUMaxTime после подтверждения — иначе не передавать
            g = job.gen

            def gen(mac, t, g=g):
                if mac.sim.now > deadline:
                    mac.log('la_ack_late', peer=ra)
                    return None
                return (yield from g(mac, t))
            job.gen = gen
        self.log('lm_report_tx', peer=ra, token=rep.token, ack=rep.ack is not None)

    def _la_snr(self, snr):
        from .mac import la_mcs
        return la_mcs(snr)

    # ------------------------------------------------------------------ Information Request/Response (11.28)
    def info_request(self, peer, subject=None, requested=(), presence=False):
        """Information Request (9.6.19.4) к peer: о subject (по умолчанию — о peer), broadcast — только точке (11.28.1);
        presence — проверка присутствия (Request без ID). Свой DMG Capabilities — в запросе (11.28.1 «may»)."""
        subject = subject or peer
        st = self._info_station()
        body = st.presence_probe(subject) if presence else st.request(subject, requested,
                                                                      dst_is_ap=peer == self.bssid)
        self.send_mgmt('Action', peer, lambda t: body, name='Information Request')

    def _info_station(self):
        members = {}
        if self.ROLE == 'AP':
            for s in self.associated():
                caps = getattr(self.peers.get(s), 'caps', None)
                if caps is not None:
                    members[s] = E.encode_dmg_capabilities(caps)
        sup = {(LA.EID_RM_ENABLED, None): self.rm_enabled_el()}
        if self.ROLE == 'AP':
            sup[(E.EID_DMG_OPERATION, None)] = self.dmg_operation()
        return DS.InfoStation(self.addr, self.dmg_capabilities(), is_ap=self.ROLE == 'AP',
                              bssid=self.bssid or self.addr, ssid=self.ssid, members=members, supported=sup,
                              radio_measurement=self.radio_measurement)

    def _rx_info(self, f, rxv):
        body = f.raw[24:]
        if f.action == 'Information Request':
            from .. import fields as F
            a3 = F.mac_str(f.raw[16:22])
            out = self._info_station().on_request(body, f.ta, bssid_field=a3, da=f.ra, rcpi=LA.rcpi(rxv.RCPI))
            if out is None:
                self.log('info_ignored', peer=f.ta)
                return
            ra, resp = out
            self.send_mgmt('Action', ra, lambda t: resp, name='Information Response')
            self.log('info_response_tx', peer=ra)
            return
        self.info_rx.append((f.ta, body))
        self.log('info_response_rx', peer=f.ta)


__all__ = ['LmMixin', 'BCAST']
