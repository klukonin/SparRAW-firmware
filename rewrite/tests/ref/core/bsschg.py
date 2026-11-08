# SPDX-License-Identifier: AGPL-3.0-or-later
"""Смена канала (ECSA, 11.8.8.6) и параметров DMG BSS (11.29) — этап 4, п. 5 — часть DMG MAC ядра (примесь к
mac.DmgMac; роль — по ROLE). Модели — ref/chswitch (ApChannelSwitch, StaChannelSwitch), ref/bssparams
(ApBssParamChange); судьи — air_judge `ecsa`, `bss_params`.

Смена канала:
  - MLME-EXTCHANNELSWITCH.request (6.3.35.2) точке: решение о смене — только у AP/PCP (11.8.8.6); элемент Extended
    Channel Switch Announcement (9.4.2.52) — в каждом DMG Beacon до момента смены (Channel Switch Count — число TBTT
    до смены, одинаков во всех маяках BI, −1 на каждый TBTT); смена канала — непосредственно перед TBTT (PHY-CONFIG
    OPERATING_CHANNEL), MLME-EXTCHANNELSWITCH.confirm; Extended Capabilities с битом Extended Channel Switching (11.9.1)
    — в Association Response и Probe Response при ecs_activated;
  - станция: ECSA своей точки → смена канала к тому же TBTT (StaChannelSwitch), MLME-EXTCHANNELSWITCH.indication;
    сама ECSA не передаёт (11.8.8.6); Channel Switch Mode 1 в DMG станция может игнорировать.
Смена параметров BSS (11.29.2, 11.29.3):
  - точка (`request_bss_change`: метод SME — MLME-примитива нет): план ref/bssparams.ApBssParamChange —
    dot11NbrOfChangeBeacons (> dot11MaxLostBeacons, PLAN №38) TBTT с элементом DMG BSS Parameter Change, на TBTT
    вступления — новый BI, сброс TSF в 0 (11.1.3.3.1); перенос TBTT — Beacon Interval на TBTT N+1 = разность;
  - станция: длительность BI — по полю Beacon Interval маяка этого BI (11.29.3); TSF — по Timestamp каждого маяка (сброс
    TSF точки отслеживается); BI маяка после сброса TSF — по счёту маяков (индексы BI сбрасываются вместе с TSF).

Не исполняется: кадр ECSA (Public Action) и ECSA в Announce/Information Response, Max Channel Switch Time, перенос
TBTT по рекомендации STA (11.29.5), смена параметров в кластере (11.29.4)."""
from fractions import Fraction as Fr

from .. import bssparams as BP
from .. import chswitch as CS
from .. import elements as E
from ..timing import TU
from . import sap_mlme as ML
from . import sap_phy as P

EXT_CAP_ECS = 1 << CS.EXT_CAP_ECS_BIT        # табл. 9-153: бит 2 — Extended Channel Switching


class BssChangeMixin:
    def _bsschg_init(self):
        self.channel = 2                     # рабочий канал (20.3.1: канал 2 — обязательный)
        self.ecs_activated = False           # dot11ExtendedChannelSwitchActivated (11.9.1)
        self.cs_ap = None                    # chswitch.ApChannelSwitch
        self.cs_sta = None                   # chswitch.StaChannelSwitch
        self.bpc_plan = None                 # [bssparams.BeaconPlan] — текущая смена параметров BSS (точка)
        self._bpc_j = None

    # ------------------------------------------------------------------ элементы
    def ext_cap_el(self):
        """Extended Capabilities (9.4.2.26): бит Extended Channel Switching (табл. 9-153)."""
        return E.encode_element(CS.EID_EXT_CAP, bytes([EXT_CAP_ECS if self.ecs_activated else 0]))

    def _set_channel(self, ch):
        """PHY-CONFIG.request: OPERATING_CHANNEL (20.2.3: канал = ½·(OPERATING_CHANNEL + 1))."""
        self.channel = ch
        self.phy.phy_config_request(P.PhyConfigVector(OPERATING_CHANNEL=2 * ch - 1, RX_ANT_CONFIG=self.rx_beam,
                                                      RX_TRN_AWVS=getattr(self, '_rx_trn', ())))
        self.log('channel', ch=ch)

    # ------------------------------------------------------------------ точка: ECSA
    def _req_MlmeExtChannelSwitchRequest(self, prim):
        """6.3.35.2: объявить смену канала (ECSA в маяках с ближайшего TBTT)."""
        if self.ROLE != 'AP' or not self.ecs_activated:
            self._confirm(ML.MlmeExtChannelSwitchConfirm(ResultCode=ML.INVALID_PARAMETERS))
            return
        if self.cs_ap is None:
            self.cs_ap = CS.ApChannelSwitch(channel=self.channel)
        self.cs_ap.announce((self.k or 0) + 1, prim.NewChannelNumber, prim.ChannelSwitchCount,
                            mode=prim.ChannelSwitchMode, opclass=prim.NewOperatingClass)
        self.log('ecsa_announce', ch=prim.NewChannelNumber, count=prim.ChannelSwitchCount)

    def _ecsa_element(self, k):
        if self.cs_ap is None:
            return None
        x = self.cs_ap.element_for(k)
        return CS.encode_ecsa(x) if x is not None else None

    def _ap_tbtt_channel(self, k):
        """Начало BI k точки: при наступлении — смена канала (перед TBTT, 11.8.8.6)."""
        if self.cs_ap is not None and self.cs_ap.tick(k):
            self._set_channel(self.cs_ap.channel)
            self._confirm(ML.MlmeExtChannelSwitchConfirm(ResultCode=ML.SUCCESS))

    # ------------------------------------------------------------------ станция: ECSA
    def _sta_rx_ecsa(self, k, elements):
        x = None
        for eid, ext, data in elements:
            if eid == CS.EID_ECSA:
                x = CS.parse_ecsa(data)
        if x is None:
            return
        if self.cs_sta is None or self.cs_sta.at is None:
            self.cs_sta = CS.StaChannelSwitch(self.channel)
            self.cs_sta.on_ecsa(k, x)
            bi = self.bi_tu * TU
            self.sim.at(max(self.sim.now, self.t_of_tsf(self.cs_sta.at * bi) - 1), self._sta_switch_channel,
                        self.cs_sta.at)
            self.log('ecsa_rx', ch=x.channel, count=x.count, at=self.cs_sta.at)

    def _sta_switch_channel(self, k):
        if self.cs_sta is not None and self.cs_sta.tick(k):
            self._set_channel(self.cs_sta.channel)
            self._indicate(ML.MlmeExtChannelSwitchIndication(NewChannelNumber=self.channel))

    # ------------------------------------------------------------------ точка: смена параметров BSS (11.29)
    def request_bss_change(self, new_bi_tu=None, move_to_us=None):
        """Смена длительности BI (11.29.3) или перенос TBTT (11.29.2) с ближайшего TBTT."""
        k = (self.k or 0) + 1
        bi = self.bi_tu * TU
        t1 = k * bi                          # TSF ближайшего TBTT (точка: TSF 0 — TBTT, TBTT k — k·BI)
        move = None if move_to_us is None else t1 + move_to_us
        self.bpc_plan = BP.ApBssParamChange(self.bi_tu).plan(t1, move_to=move, new_bi_tu=new_bi_tu,
                                                              at1=self.t_of_tsf(t1))
        self._bpc_k0 = k
        self.log('bss_change_plan', new_bi=new_bi_tu, move=move_to_us)

    def _bpc_beacon_k(self, k):
        return self._bpc_beacon(k)

    def _bpc_beacon(self, k):
        """(поле Beacon Interval, элемент DMG BSS Parameter Change или None, момент следующего TBTT или None) BI k."""
        if self.bpc_plan is None:
            return None
        j = k - self._bpc_k0
        if not 0 <= j < len(self.bpc_plan):
            return None
        p = self.bpc_plan[j]
        nxt = self.bpc_plan[j + 1].at if j + 1 < len(self.bpc_plan) else None
        return p.bi_tu, (BP.encode_change(p.change) if p.change is not None else None), nxt, p


__all__ = ['BssChangeMixin', 'Fr']
