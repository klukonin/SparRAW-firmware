# SPDX-License-Identifier: AGPL-3.0-or-later
"""Правила судьи эфира schedule / sp_access / dynalloc (ref/air_sched) на журнале из AirEv без pcap: расписание из
Extended Schedule маяков (9.4.2.131 [p. 1246]), SP (10.39.6.2 [p. 1885]), динамическое распределение (10.39.7
[p. 1896]); без расписания и кадров Poll/SPR/Grant — «не проверяемо» с причиной."""
from fractions import Fraction as Fr
from types import SimpleNamespace as NS

from . import air_judge as J
from . import air_pcap as P
from . import bi as BI
from . import dynalloc as DA
from . import fields as F
from . import schedule as S
from . import sp as SPm
from . import timing as T

AP, STA = '24:18:1d:24:3b:0b', '24:18:1d:26:d4:7b'
BI_US = 100 * T.TU


class Air:
    def __init__(self, aids=None):
        self.evs, self.aids = [], aids or {}

    def add(self, kind, src, dst, t, length=20, mcs=0, dur=0, p=None, tx=None):
        t = Fr(t)
        e = P.AirEv(i=len(self.evs), t=t, te=t + P.ppdu_time(length, mcs), t_lo=t, t_hi=t + 50, src=src, dst=dst,
                    kind=kind, dur=dur, mcs=mcs, raw=None, p=p, length=length, t_ok=True, dur_ok=dur is not None,
                    body_ok=p is not None, synth=False, tx_node=tx, rx_nodes=[], action=None, mcs_ok=True, agg=False,
                    recs=[])
        self.evs.append(e)
        return e

    def ctx(self):
        air = NS(events=sorted(self.evs, key=lambda e: e.tsort), ap=AP, recs={}, nodes={'AP': AP, 'STA': STA},
                 cal=None, stats={}, aids=self.aids)
        for i, e in enumerate(air.events):
            e.i = i
        return J.Ctx(air, edca=({}, 'тест'))


def beacon(a, k, entries=None, cbap_only=1):
    bic = F.Bic(abft_length=1, fss=15, next_abft=1, n_bis_abft=1, ati_present=0, is_resp_txss=1)
    els = [] if entries is None else [(144, None, d) for d in _infos(entries)]
    p = NS(bic=bic, beacon_interval=100, ssw=NS(sector_id=0, antenna_id=0, cdown=0), elements=els,
           params=NS(bss_type=3, cbap_only=cbap_only if entries is None else 0, cbap_source=0, privacy=0, ecapc=0))
    return a.add('DMG Beacon', AP, T.BCAST, k * BI_US, length=46, p=p, tx='AP', dur=0)


def _infos(entries):
    b = S.encode(entries)
    out, i = [], 0
    while i < len(b):
        out.append(b[i + 2:i + 2 + b[i + 1]])
        i += 2 + b[i + 1]
    return out


def rules_of(c):
    return {f.__name__: f(c) for f in (*J.AS.RULES,)}


def test_registered_in_air_judge():
    names = {f.__name__ for f in J.RULES}
    assert {'r_schedule', 'r_sp_access', 'r_dynalloc'} <= names
    assert 'dyn_alloc' not in {x[0] for x in J.NOT_CHECKABLE}
    assert J.PAGE['10.39.7'] == 1896


def test_cbap_only_capture_unchecked_with_reasons():
    """Захват стенда: маяки с CBAP Only = 1 без Extended Schedule, кадров Poll/SPR/Grant нет."""
    a = Air()
    for k in range(3):
        beacon(a, k)
        a.add('Data', STA, AP, k * BI_US + 3000, length=500, mcs=8, dur=10)
    r = rules_of(a.ctx())
    assert r['r_schedule'].checked == 3 and not r['r_schedule'].viol
    assert r['r_schedule'].info['by_bi'] == {'CBAP Only = 1, ES нет': 3}
    assert any('CBAP Only' in w for w in r['r_schedule'].unchecked)
    assert r['r_sp_access'].status == 'unchecked' and any('нет SP' in w for w in r['r_sp_access'].unchecked)
    assert r['r_dynalloc'].status == 'unchecked' and any('Poll/SPR/Grant' in w for w in r['r_dynalloc'].unchecked)


def test_schedule_and_sp_from_beacon_extended_schedule():
    """ES в маяке: SP STA → AP и SP broadcast/broadcast; кадр STA за концом SP — sp_access (sp_end); поле с
    перекрытием — schedule (overlap)."""
    ent = S.plan(0, 100, 2000, [S.Req(S.SP, 1, 0, 3000, truncatable=1), S.Req(S.SP, 255, 255, 5000, truncatable=1)])
    a = Air(aids={STA: 1})
    beacon(a, 0, ent)
    per = BI.layout(0, 100, BI.BiConfig(allocations=[e.alloc for e in ent]), None)
    for e in SPm.sp_exchange(per[0], STA, AP, 2):
        a.add(e[4], e[2], e[3], e[0], length=1500 if e[4] == 'Data' else 14, mcs=e[6]['mcs'], dur=10)
    r = rules_of(a.ctx())
    assert r['r_schedule'].checked == 1 and not r['r_schedule'].viol, r['r_schedule'].viol
    assert r['r_sp_access'].checked and not r['r_sp_access'].viol, r['r_sp_access'].viol
    a.add('Data', STA, AP, per[0].end - 5, length=3000, mcs=8, dur=10)
    r = rules_of(a.ctx())
    assert any('sp_end' in m for _, m, _ in r['r_sp_access'].viol)
    # перекрытие распределений в ES
    bad = [ent[0], S.sp(255, 255, ent[0].alloc.start + 1000, 5000, truncatable=1)]
    b = Air(aids={STA: 1})
    beacon(b, 0, bad)
    r = rules_of(b.ctx())
    assert any(m.startswith('overlap') for _, m, _ in r['r_schedule'].viol)


def test_dynalloc_frames_in_capture():
    """Poll с неверным Duration в SP broadcast/broadcast — dynalloc (dyn_poll_dur, вердикт ours); чтения 9.3.1.10 —
    вердикт model."""
    ent = S.plan(0, 100, 2000, [S.Req(S.SP, 255, 255, 8000, truncatable=1)])
    per = BI.layout(0, 100, BI.BiConfig(allocations=[e.alloc for e in ent]), None)
    pp, _ = DA.pp(per[0].start + 100, AP, [STA])
    a = Air(aids={STA: 1})
    beacon(a, 0, ent)
    for e in pp:
        a.add(e[4], e[2], e[3], e[0], length=F.FRAME_LEN[{'Poll': 'poll', 'SPR': 'spr'}[e[4]]], dur=e[5],
              p=e[6]['frame'])
    r = rules_of(a.ctx())
    assert r['r_dynalloc'].checked and not r['r_dynalloc'].viol, r['r_dynalloc'].viol
    poll = next(e for e in a.evs if e.kind == 'Poll')
    poll.dur += 3
    poll.p = poll.p._replace(duration=poll.dur)
    spr = next(e for e in a.evs if e.kind == 'SPR')
    spr.t += T.SIFS
    spr.te += T.SIFS
    r = rules_of(a.ctx())
    got = {(m.split(':')[0], v) for _, m, v in r['r_dynalloc'].viol}
    assert ('dyn_poll_dur', 'ours') in got and ('dyn_spr_time_9.3.1.10', 'model') in got, got


def test_sta_aid_inferred_from_sp_pair():
    """Захват начат после ассоциации (Association Response нет): AID STA выводится по SP пары «AP — STA» в Extended
    Schedule (10.39.6.2: в SP передают только источник и получатель). Стенд 2026-11-10 (строгий TDMA): без вывода
    BlockAck получателя и QoS Null источника считались «посторонними» (sp_foreign, AID None), а BlockAck точки в SP
    станции — восстановлением SP точкой (sp_recovery)."""
    ent = S.plan(0, 100, 2000, [S.Req(S.SP, 0, 1, 3000), S.Req(S.SP, 1, 0, 3000)])
    per = BI.layout(0, 100, BI.BiConfig(allocations=[e.alloc for e in ent]), None)
    sps = [p for p in per if p.kind == BI.SP]
    a = Air()
    beacon(a, 0, ent)
    for p, (src, dst) in zip(sps, ((AP, STA), (STA, AP))):
        for e in SPm.sp_exchange(p, src, dst, 3):
            a.add(e[4], e[2], e[3], e[0], length=1500 if e[4] == 'Data' else 14, mcs=e[6]['mcs'], dur=10)
    r = rules_of(a.ctx())
    assert r['r_sp_access'].checked and not r['r_sp_access'].viol, r['r_sp_access'].viol
    assert r['r_sp_access'].info['aid_inferred'] == {STA: 1}
    # кадров в SP пары нет — AID не выводится (правило его не знает)
    b = Air()
    beacon(b, 0, ent)
    c = b.ctx()
    rules_of(c)
    assert not c.aids_inferred


def test_sta_aid_not_inferred_when_ambiguous():
    """Два MAC поровну обмениваются с AP в SP пары — доля одного MAC ниже порога: AID не выводится."""
    other = '24:18:1d:00:00:01'
    ent = S.plan(0, 100, 2000, [S.Req(S.SP, 1, 0, 3000)])
    per = BI.layout(0, 100, BI.BiConfig(allocations=[e.alloc for e in ent]), None)
    p = next(p for p in per if p.kind == BI.SP)
    a = Air()
    beacon(a, 0, ent)
    for i, src in enumerate((STA, other) * 3):
        a.add('Data', src, AP, p.start + 100 + 300 * i, length=1500, mcs=8, dur=10)
    c = a.ctx()
    rules_of(c)
    assert not c.aids_inferred
