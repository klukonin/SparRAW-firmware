# SPDX-License-Identifier: AGPL-3.0-or-later
"""Журнал эфира ядра — тот же вид, что судьи уже принимают от эмулятора и сниффера, чтобы этап 2 (прошивка в
эмуляторе против ядра) сравнивал журналы напрямую:

  to_snapshot(ap) — снимок, как unit/ref_bridge2.snapshot(air) из air.Air эмулятора: frames (start/end в тактах
                    165 МГц, src — MAC передатчика, frame — первый MPDU без FCS, mpdus — MPDU A-MPDU, dur_us, mcs,
                    what) и nodes (TSF0/TBTT/BI точки). Вход ref_bridge2.events → judge_all;
  to_air(ap)      — air_pcap.Air с событиями AirEv (как merge() записей PMC двух узлов): время, поля, Duration и
                    MCS известны всегда (t_ok, dur_ok, body_ok, mcs_ok), tx_node/rx_nodes — имена узлов.
                    Вход air_judge.judge.

Время журнала — модельное (мкс, Fraction) = TSF точки (TSF точки = модельное время: TBTT k = k·BI, 11.1.3.3.1).
Моменты — начало и конец PPDU на антенне передатчика (как air.Air: журнал передатчика)."""
from fractions import Fraction as Fr

from .. import air_pcap as AP
from .. import fields as F
from ..timing import BCAST, CLK_MHZ, TU
from . import frames as FR
from . import sap_phy as P


class PpduRec:
    __slots__ = ('i', 't', 'te', 'node', 'addr', 'txv', 'psdu', 'mpdus', 'receivers', 'heard', 'rx_err', 'sensed',
                 'what')

    def __init__(self, i, t, te, node, addr, txv, psdu):
        self.i, self.t, self.te, self.node, self.addr, self.txv, self.psdu = i, t, te, node, addr, txv, psdu
        agg = txv.AGGREGATION == P.AGGREGATED
        self.mpdus = [m for m, _ in FR.split_psdu(psdu, agg)]
        self.receivers, self.heard, self.rx_err, self.sensed = set(), set(), set(), set()
        self.what = ''

    @property
    def agg(self):
        return self.txv.AGGREGATION == P.AGGREGATED

    @property
    def kind(self):
        k = FR.classify(self.mpdus[0])
        return ('A-MPDU' if self.agg else (k.action if k.action == 'BRP' else k.kind))

    def __repr__(self):
        f = FR.classify(self.mpdus[0])
        return (f'#{self.i} @{float(self.t):.3f}-{float(self.te):.3f} {self.node} {self.kind} '
                f'{f.ta}->{f.ra} dur={f.dur} mcs={self.txv.MCS} beam={self.txv.ANT_CONFIG} rx={sorted(self.receivers)}')


class Journal:
    def __init__(self):
        self.recs = []
        self.nodes = {}                     # имя → MAC
        self.bi_tu = None

    def add(self, t, te, node, addr, txv, psdu):
        r = PpduRec(len(self.recs), t, te, node, addr, txv, psdu)
        self.recs.append(r)
        return r

    # ------------------------------------------------------------------ → unit/ref_bridge2
    def to_snapshot(self, ap_addr, bi_tu=None):
        bi = (bi_tu or self.bi_tu) * TU
        frames = [dict(start=r.t * CLK_MHZ, end=r.te * CLK_MHZ, src=F.mac_bytes(r.addr), frame=r.mpdus[0],
                       mpdus=list(r.mpdus) if r.agg else None, dur_us=int.from_bytes(r.mpdus[0][2:4], 'little'),
                       mcs=r.txv.MCS, what=f'ядро {r.node}: {r.kind}',
                       rx_err=sorted(F.mac_bytes(self.nodes[n]) for n in r.rx_err),
                       sensed=sorted(F.mac_bytes(self.nodes[n]) for n in r.sensed)) for r in self.recs]
        nodes = {F.mac_bytes(a): dict(tsf0_us=0, tbtt_us=0, bi_us=bi) for a in self.nodes.values()}
        return dict(frames=frames, nodes=nodes)

    # ------------------------------------------------------------------ → ref/air_judge
    def to_air(self, ap_addr):
        evs = []
        for r in self.recs:
            raw = r.mpdus[0]
            fc, kind, first, act = AP.classify(raw, r.agg)
            dst = BCAST if first == 'DMG Beacon' else F.mac_str(raw[4:10])
            p, err = AP._parse(first, raw) if not r.agg else (None, None)
            evs.append(AP.AirEv(
                i=len(evs), t=r.t, te=r.te, src=r.addr, dst=dst, kind=kind, first=first,
                dur=int.from_bytes(raw[2:4], 'little'), mcs=r.txv.MCS, raw=raw, fc=fc, p=p, err=err, action=act,
                by_mac=False, what=f'ядро {r.node}', mpdus=list(r.mpdus), length=r.txv.LENGTH, agg=r.agg,
                t_ok=True, t_lo=r.t, t_hi=r.t, t_from='tx', dur_ok=True, body_ok=True, synth=False, mcs_ok=True,
                tx_node=r.node, rx_nodes=tuple(sorted(r.receivers)), recs=[], cal_ok=True,
                trn=(r.txv.TRN_LEN, r.txv.PPDU_TYPE, r.txv.BEAM_TRACKING_REQUEST == P.BT_REQUESTED,
                     P.trn_appended(r.txv))))
        return AP.Air(evs, dict(self.nodes), ap_addr, None, {'events': len(evs)}, {})

    def view(self, keep=None, foreign_beacons=(), shift=0, t_from=None, t_to=None, bi_tu=None):
        """Журнал одного BSS для судей (рассчитаны на одну точку): PPDU узлов keep и DMG Beacon узлов foreign_beacons
        как чужие (их узлы — не «свои»: правила кластеризации видят их маяки как маяки другой AP); shift — время
        журнала в TSF точки этого BSS (TSF точки = время журнала + shift; у члена кластера TSF сдвинут); t_from/t_to —
        участок (до/после сброса TSF при смене BI, 11.29.3), bi_tu — BI участка."""
        keep = set(self.nodes) if keep is None else keep
        j = Journal()
        j.bi_tu = bi_tu or self.bi_tu
        j.nodes = {n: a for n, a in self.nodes.items() if n in keep}
        for r in self.recs:
            if (t_from is not None and r.t < t_from) or (t_to is not None and r.t >= t_to):
                continue                      # участок журнала (напр. до и после смены BI, 11.29)
            if r.node in keep or (r.node in foreign_beacons and r.kind == 'DMG Beacon'):
                if r.t + shift < 0:
                    continue
                x = PpduRec(len(j.recs), r.t + shift, r.te + shift, r.node, r.addr, r.txv, r.psdu)
                x.receivers = {n for n in r.receivers if n in keep}
                x.heard = {n for n in r.heard if n in keep}
                x.rx_err = {n for n in r.rx_err if n in keep}
                x.sensed = {n for n in r.sensed if n in keep}
                j.recs.append(x)
        return j

    def __len__(self):
        return len(self.recs)

    def kinds(self):
        from collections import Counter
        return Counter(r.kind for r in self.recs)

    def dump(self, n=None, t0=None):
        rs = [r for r in self.recs if t0 is None or r.t >= t0]
        return '\n'.join(map(repr, rs[:n]))


def us_to_bi(t, bi_tu):
    return int(Fr(t) // (bi_tu * TU))
