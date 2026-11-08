# SPDX-License-Identifier: AGPL-3.0-or-later
"""Децентрализованная кластеризация AP (этап 4, п. 4; 10.40.1, 10.40.2.1, 10.40.3.2) — часть точки ядра (примесь к
ap.DmgApMac). Модель — ref/cluster.DecentralizedAp (Beacon SP, вход члена, расписание Beacon SP); судья — air_wave4
`cluster`.

  S-AP: Clustering Control в каждом DMG Beacon (Beacon SP Duration = dot11BeaconSPDuration, Cluster ID = свой MAC, роль
        S-AP, ClusterMaxMem: BI / ClusterMaxMem — целое число мкс), CC Present = 1, ECAPC Policy Enforced = 0; DMG
        Capabilities: Decentralized AP or PCP Clustering = 1;
  член: MLME-START → прослушивание канала aMinChannelTime (маяков не передаёт): принятые DMG Beacon по Beacon SP;
        есть S-AP децентрализованного кластера и пустой Beacon SP — вход членом (10.40.2.1): BI = BI S-AP, Beacon SP
        Duration и ClusterMaxMem — копии S-AP, роль член, Cluster ID = MAC S-AP; свой TBTT — TBTT S-AP +
        ClusterTimeOffset_{n−1} (11.1.3.3.1: TSF 0 — TBTT, поэтому свой TSF сдвинут на ClusterTimeOffset); пустого нет —
        S-AP нового кластера («may», PLAN №90);
  оба:  Extended Schedule — Beacon SP других AP кластера (SP Source/Destination AID 255, PLAN №83) и CBAP broadcast в
        промежутках с guard time; в чужих Beacon SP не передают («should not transmit», 10.40.2.1); S-AP теряется
        4×aMinBTIPeriod BI — член ведёт периоды мониторинга (DecentralizedAp.end_bi) и становится S-AP по 10.40.3.2.

Не исполняется: централизованная кластеризация (10.40.2.2, ECAPC, CCSR), Cluster Report станций (10.40.4), Cluster
Request (10.40.5), смена параметров BSS в кластере (11.29.4), CDMG-кластеризация (10.41)."""
from fractions import Fraction as Fr

from .. import bi as B
from .. import cluster as CL
from .. import fields as F
from .. import schedule as S
from ..timing import AID_BROADCAST, TSF_LOW_MOD, TU, aMinChannelTime


class ClusterMixin:
    """Кластеризация AP (только для ap.DmgApMac)."""

    def _cluster_init(self):
        self.clustering = None               # None | 'sap' (стать S-AP) | 'join' (искать кластер, войти членом)
        self.cluster_maxmem = 4
        self.cl = None                       # cluster.DecentralizedAp
        self._cl_heard = []                  # (t0, t1, src, cc) DMG Beacon при прослушивании
        self._cl_listen_end = None
        self.cluster_sp_keys = set()

    # ------------------------------------------------------------------ запуск
    def _cluster_start(self, prim):
        """MLME-START с кластеризацией: S-AP сразу; член — сначала прослушивание aMinChannelTime (10.40.2.1)."""
        self.cl = CL.DecentralizedAp(self.addr, self.bi_tu, maxmem=self.cluster_maxmem)
        if self.clustering == 'sap':
            self.cl.start_sap(tbtt=0)
            return False                     # обычный запуск BI
        self._cl_listen_end = self.sim.now + aMinChannelTime
        self.set_rx_beam(self.rx_beam)
        self.sim.at(self._cl_listen_end, self._cluster_decide)
        self.log('cluster_listen', until=self._cl_listen_end)
        return True                          # BI начнётся после решения

    def _cluster_rx_beacon(self, f, rxv, t0):
        """DMG Beacon другой точки: при прослушивании — запись; в кластере — сопровождение S-AP (10.40.3.2)."""
        b = F.parse_dmg_beacon(f.raw, with_fcs=False)
        if b.bssid == self.addr:
            return
        cc = b.cc if not b.bic.discovery else None
        if self._cl_listen_end is not None:
            self._cl_heard.append((t0, self.sim.now, b.bssid, cc, b.timestamp, b.beacon_interval, b.params.ecapc,
                                   rxv.MCS))
            return
        if self.cl is not None and self.cl.role != CL.ROLE_NONE:
            act = self.cl.on_beacon(b.bssid, cc, b.params.ecapc)
            if act:
                self.log('cluster_' + act, src=b.bssid)

    def _cluster_decide(self):
        """Конец прослушивания: вход членом в пустой Beacon SP или S-AP (10.40.2.1)."""
        self._cl_listen_end = None
        saps = [h for h in self._cl_heard if isinstance(h[3], F.ClusteringControl) and
                h[3].member_role == CL.ROLE_SAP and not h[6]]
        if saps:
            t0, t1, src, cc, ts, bi_tu, ecapc, mcs = saps[-1]
            # TBTT S-AP во времени модели: Timestamp — TSF S-AP в начале символа данных (11.1.3.1)
            from . import sap_phy as P
            sap_tsf_at_t0 = Fr(ts) - P.data_symbol_offset(mcs)
            bi = bi_tu * TU
            sap_tbtt = t0 - (sap_tsf_at_t0 % bi)
            heard = [(h[0], h[1]) for h in self._cl_heard]
            empty = CL.empty_beacon_sps(heard, sap_tbtt, bi_tu, cc.cluster_max_mem, cc.beacon_sp_duration,
                                        aMinChannelTime)
            if self.cl.join(src, cc, bi_tu, sap_tbtt, empty):
                self.bi_tu = bi_tu
                off = CL.cluster_time_offset(self.cl.n - 1, bi_tu, cc.cluster_max_mem)
                # свой TSF: 0 в TBTT (11.1.3.3.1) — сдвиг на TBTT S-AP + ClusterTimeOffset
                self.tsf_off = -(sap_tbtt % bi + off)
                self.log('cluster_join', sap=src, n=self.cl.n, offset=off)
                self._cluster_begin_bi()
                return
        self.cl.start_sap(tbtt=0)
        self.tsf_off = -self.sim.now
        self.log('cluster_sap')
        self._cluster_begin_bi()

    def _cluster_begin_bi(self):
        bi = self.bi_tu * TU
        k = int((self.tsf() // bi) + 1)
        self.sim.at(self.t_of_tsf(k * bi), self._tbtt, k)

    # ------------------------------------------------------------------ поля маяка
    def _cluster_cc(self):
        if self.cl is None or self.cl.role == CL.ROLE_NONE:
            return None
        return self.cl.cc()

    def cluster_caps(self):
        return dict(decentralized_clustering=1) if self.clustering else {}

    # ------------------------------------------------------------------ расписание BI (10.40.2.1)
    def _cluster_entries(self, k, bhi_end):
        """Extended Schedule BI k (TSF своего BI): Beacon SP других AP кластера (SP 255→255) и CBAP broadcast в
        промежутках с guard time (10.39.6.5). None — кластеризации нет."""
        if self.cl is None or self.cl.role == CL.ROLE_NONE:
            return None
        bi = self.bi_tu * TU
        t_k = k * bi
        sps = CL.beacon_sp_entries(t_k, self.cl.n, self.bi_tu, self.cl.maxmem, self.cl.sp_field)
        self.cluster_sp_keys = {e.alloc.key() for e in sps}
        g = B.guard_between(False, False, bi) + 1
        out, t = [], Fr(bhi_end).__ceil__() + g
        busy = sorted((B.full_tsf(e.alloc.start, t_k), B.full_tsf(e.alloc.start, t_k) + e.alloc.block_dur, e)
                      for e in sps)
        for s0, e0, ent in busy:
            if s0 < t_k + (bhi_end - t_k):
                continue
            if s0 - g - t >= 50:
                d = int(s0 - g - t)
                while d > 0:
                    dd = min(d, 65535)
                    out.append(S.cbap(int(t) % TSF_LOW_MOD, dd))
                    t += dd + g
                    d = int(s0 - g - t)
            out.append(ent)
            t = Fr(e0).__ceil__() + g
        end = t_k + bi
        while end - g - t >= 50:
            dd = int(min(end - g - t - 1, 65535))
            out.append(S.cbap(int(t) % TSF_LOW_MOD, dd))
            t += dd + g
        return out

    def _cluster_end_bi(self):
        if self.cl is None:
            return
        act = self.cl.end_bi()
        if act:
            self.log('cluster_' + act)
