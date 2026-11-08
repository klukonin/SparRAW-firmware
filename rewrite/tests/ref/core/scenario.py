# SPDX-License-Identifier: AGPL-3.0-or-later
"""Сценарий «точка + станции на ядре в идеальной среде»: сборка, прогон до завершения, журнал.

    bss = Bss(seed=1, n_sta=1, ul_bytes=1 << 20, dl_bytes=1 << 20)
    bss.run()                      # до завершения обмена (или max_bis BI)
    bss.journal                    # журнал эфира (core/journal.Journal)
    bss.ap, bss.stas, bss.ap_sme, bss.sta_smes"""
from fractions import Fraction as Fr

from ..timing import TU
from .ap import DmgApMac
from .journal import Journal
from .medium_ideal import DEFAULT_PROP, IdealMedium
from .sim import Sim
from .sme import ApSme, StaSme
from .sta import DmgStaMac

AP_ADDR = '02:00:00:00:00:01'


def sta_addr(i):
    return f'02:00:00:00:01:{i + 1:02x}'


class Bss:
    def __init__(self, seed=1, n_sta=1, bi_tu=100, ap_sectors=8, sta_sectors=4, prop=DEFAULT_PROP, abft_slots=8,
                 fss=8, base_dbm=-40, ul_bytes=0, dl_bytes=0, bf='abft', probe=True, ap_best=None, sta_best=None,
                 sta_link_dbm=-45, mac_cls=(DmgApMac, DmgStaMac)):
        self.sim = Sim()
        self.journal = Journal()
        self.journal.bi_tu = bi_tu
        self.medium = IdealMedium(self.sim, prop, self.journal)
        self.bi_tu = bi_tu
        ap_cls, sta_cls = mac_cls
        self.ap = ap_cls(self.sim, AP_ADDR, ap_sectors, seed=seed * 7 + 1, name='AP')
        self.ap.phy = self.medium.attach('AP', AP_ADDR, self.ap.sectors, self.ap)
        self.ap_sme = ApSme(self.ap, bi_tu=bi_tu, abft_slots=abft_slots, fss=fss, dl_bytes=dl_bytes)
        self.stas, self.sta_smes = [], []
        for i in range(n_sta):
            name = f'STA{i + 1}' if n_sta > 1 else 'STA'
            s = sta_cls(self.sim, sta_addr(i), sta_sectors, seed=seed * 7 + 2 + i, name=name)
            s.phy = self.medium.attach(name, s.addr, s.sectors, s)
            s.ap_sectors = ap_sectors
            ab = (ap_best[i] if ap_best else (1 + 3 * i) % ap_sectors)
            sb = (sta_best[i] if sta_best else (2 + i) % sta_sectors)
            self.medium.link('AP', name, base_dbm, ab, sb)
            for o in self.stas:
                self.medium.link(o.name, name, sta_link_dbm, 0, 0, step_db=0, qo_loss_db=0)
            self.stas.append(s)
            self.sta_smes.append(StaSme(s, ul_bytes=ul_bytes, bf=bf, probe=probe))
        self.ul_bytes, self.dl_bytes = ul_bytes, dl_bytes
        self.started = False

    def bf(self, **kw):
        """Выбор реализации BF (bf.BfConfig) у точки и всех станций."""
        for m in [self.ap] + self.stas:
            for k, v in kw.items():
                setattr(m.bf, k, v)
        return self

    def trickle(self, batch=16, gap_us=2000, ap=True, stas=True):
        """MA-UNITDATA.request пачками (SME решает, когда отдавать данные): поток во времени, а не всё сразу."""
        from .diff_scenario import _trickle
        for sme in ([self.ap_sme] if ap else []) + (self.sta_smes if stas else []):
            _trickle(sme, self.sim, batch, gap_us)
        return self

    @property
    def sta(self):
        return self.stas[0]

    @property
    def sta_sme(self):
        return self.sta_smes[0]

    def start(self):
        if not self.started:
            self.started = True
            self.ap_sme.start()
            for i, s in enumerate(self.sta_smes):
                self.sim.at(Fr(1000 + 37 * i), s.start)

    def done(self):
        for s, sme in zip(self.stas, self.sta_smes):
            if sme.state != 'data':
                return False
            if sme.ok_count() < len(sme.ul):
                return False
            if self.ul_bytes and sum(len(i.data) for i in self.ap_sme.rx if i.source_address == s.addr) \
                    < self.ul_bytes:
                return False
            if self.dl_bytes and sme.rx_bytes() < self.dl_bytes:
                return False
        return True

    def run(self, max_bis=40, tail_us=2000):
        """До завершения обмена (+ хвост, чтобы закончились CF-End-обмены) или max_bis BI."""
        self.start()
        until = max_bis * self.bi_tu * TU
        self.sim.run_while(lambda: not self.done(), until)
        self.sim.run(self.sim.now + tail_us)
        return self.done()

    def run_bis(self, n):
        self.start()
        self.sim.run(n * self.bi_tu * TU - Fr(1, 1000))


AP2_ADDR = '02:00:00:00:00:02'


class ClusterNet:
    """Две точки децентрализованного кластера (10.40.2.1) и по станции у каждой: точка 1 — S-AP, точка 2 — после
    прослушивания aMinChannelTime входит членом в пустой Beacon SP; станция 2 начинает поиск после этого."""
    def __init__(self, seed=1, bi_tu=100, maxmem=4, bytes_=100_000, sta2_start_us=1_250_000, sectors=8):
        from ..timing import aMinChannelTime
        self.sim = Sim()
        self.journal = Journal()
        self.journal.bi_tu = bi_tu
        self.medium = m = IdealMedium(self.sim, DEFAULT_PROP, self.journal)
        self.bi_tu = bi_tu
        self.ap = DmgApMac(self.sim, AP_ADDR, sectors, seed=seed * 7 + 1, name='AP')
        self.ap.phy = m.attach('AP', AP_ADDR, self.ap.sectors, self.ap)
        self.ap.clustering, self.ap.cluster_maxmem = 'sap', maxmem
        self.ap2 = DmgApMac(self.sim, AP2_ADDR, sectors, seed=seed * 7 + 3, name='AP2')
        self.ap2.phy = m.attach('AP2', AP2_ADDR, self.ap2.sectors, self.ap2)
        self.ap2.clustering = 'join'
        # A-BFT точек короче (2 слота × 4 кадра): BHI члена почти целиком в его Beacon SP
        self.ap_sme = ApSme(self.ap, ssid=b'dmg-a', bi_tu=bi_tu, abft_slots=2, fss=4, dl_bytes=bytes_)
        self.ap2_sme = ApSme(self.ap2, ssid=b'dmg-b', bi_tu=bi_tu, abft_slots=2, fss=4, dl_bytes=bytes_)
        self.sta = DmgStaMac(self.sim, sta_addr(0), 4, seed=seed * 7 + 2, name='STA1')
        self.sta.phy = m.attach('STA1', self.sta.addr, self.sta.sectors, self.sta)
        self.sta2 = DmgStaMac(self.sim, sta_addr(1), 4, seed=seed * 7 + 4, name='STA2')
        self.sta2.phy = m.attach('STA2', self.sta2.addr, self.sta2.sectors, self.sta2)
        for s in (self.sta, self.sta2):
            s.ap_sectors = sectors
        m.link('AP', 'AP2', -45, 3, 7)
        m.link('AP', 'STA1', -40, 1, 2)
        m.link('AP2', 'STA2', -40, 5, 1)
        m.link('AP', 'STA2', -50, 6, 3)
        m.link('AP2', 'STA1', -50, 2, 0)
        m.link('STA1', 'STA2', -55, 0, 0, step_db=0, qo_loss_db=0)
        self.sta_sme = StaSme(self.sta, ssid=b'dmg-a', ul_bytes=bytes_, bf='dti', probe=False)
        self.sta2_sme = StaSme(self.sta2, ssid=b'dmg-b', ul_bytes=bytes_, bf='dti', probe=False)
        self.sta2_start = max(sta2_start_us, aMinChannelTime + 3 * bi_tu * TU)
        self.started = False

    def start(self):
        if not self.started:
            self.started = True
            self.ap_sme.start()
            self.ap2_sme.start()
            self.sim.at(Fr(1000), self.sta_sme.start)
            self.sim.at(Fr(self.sta2_start), self.sta2_sme.start)

    def done(self):
        return all(sme.state == 'data' and sme.ok_count() >= len(sme.ul) and sme.rx_bytes() >= ap.dl_bytes
                   for sme, ap in ((self.sta_sme, self.ap_sme), (self.sta2_sme, self.ap2_sme)))

    def run(self, max_us=3_000_000, tail_us=2000):
        self.start()
        self.sim.run_while(lambda: not self.done(), max_us)
        self.sim.run(self.sim.now + tail_us)
        return self.done()
