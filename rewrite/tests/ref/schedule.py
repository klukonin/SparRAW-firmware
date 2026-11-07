# SPDX-License-Identifier: AGPL-3.0-or-later
"""Расписание DTI по Extended Schedule (802.11-2020): элемент и поле Allocation целиком (9.4.2.131, рис. 9-562…9-564,
табл. 9-257) вместе с BF Control в расписании (9.5.5, рис. 9-852), согласованность расписания с BI (10.39.6.1–10.39.6.5:
выделения только в DTI, без перекрытий, guard time, aMinAllocationDeliveryTime, порядок, повтор поля), правила SP- и
CBAP-распределений в расписании (10.39.6.2, 10.39.6.3: AllocationType, Beamforming Training, CBAP Only, PCP Active,
LP SC Used — 10.39.4), псевдостатичные распределения во времени (10.39.6.4: повтор, изменение/удаление, «не планировать
перекрытие с прежним»), знание расписания у STA (obsolete allocation 10.39.6.1, пропуск ES 10.39.6.4/10.39.6.7),
генератор расписания (plan) и общий вид журнала эфира для sp.py/dynalloc.py (events).

Семантика поля — bi.Allocation (её validate/blocks/recur и bi.check_schedule используются, не дублируются);
кодек — elements.encode/parse_allocation; BF Control — fields.check/encode/parse_bf_control(frame='ext_schedule').
Правила возвращаются списком (rule, msg); правило с префиксом 'should_' — рекомендация («should»), не «shall».

Не моделируется: CDMG/CMMG (рис. 9-565, AllocationType на 1,08 ГГц — для DMG STA отвергаются), Traffic Scheduling
Constraint DMG TSPEC (10.39.6.1 «should … not overlap» — нет TSPEC), spatial sharing (11.30: guard не нужен),
кластеризация, PCP power save (A-BI/D-BI)."""
from collections import namedtuple
from fractions import Fraction as Fr
from math import ceil

from . import bi as BI
from . import elements as E
from . import fields as F
from .timing import (AID_AP_PCP, AID_BROADCAST, ALLOC_CBAP, ALLOC_SP, aDMGPPMinListeningTime,
                     aMinAllocationDeliveryTime, DOT11_MAX_LOST_BEACONS, TSF_LOW_MOD, TU)

SP, CBAP = BI.SP, BI.CBAP
TYPE_OF_CODE = {ALLOC_SP: SP, ALLOC_CBAP: CBAP}      # табл. 9-257 (2,16 ГГц); 1,08 ГГц — CMMG, вне охвата DMG
CODE_OF_TYPE = {v: k for k, v in TYPE_OF_CODE.items()}
BF_NONE = F.BfControl()                              # Beamforming Training = 0, остальное — резерв (9.5.5)


class ScheduleError(ValueError):
    pass


# Пункт Extended Schedule: семантика (bi.Allocation) + BF Control (fields.BfControl)
Entry = namedtuple('Entry', 'alloc bfc')


# ====================================================================================== поле Allocation ↔ Entry
def from_field(a):
    """elements.Allocation (рис. 9-563) → Entry. AllocationType 1,08 ГГц / резерв — ScheduleError (не DMG)."""
    c = a.ctrl
    t = c['allocation_type']
    if t not in TYPE_OF_CODE:
        raise ScheduleError(f'AllocationType {t}: не DMG-распределение на 2,16 ГГц (табл. 9-257)')
    al = BI.Allocation(TYPE_OF_CODE[t], a.src_aid, a.dst_aid, a.start, a.block_duration, a.num_blocks,
                       a.block_period, alloc_id=c['allocation_id'], pseudo_static=c['pseudo_static'],
                       truncatable=c['truncatable'], extendable=c['extendable'], pcp_active=c['pcp_active'],
                       lp_sc=c['lp_sc_used'])
    bfc = F.parse_bf_control(a.bf_control.to_bytes(2, 'little'), frame='ext_schedule')
    return Entry(al, bfc)


def to_field(e):
    """Entry → elements.Allocation (BF Control — рис. 9-852: в Extended Schedule формат 9-851 не применяется)."""
    al = e.alloc
    ctrl = dict(allocation_id=al.alloc_id, allocation_type=CODE_OF_TYPE[al.alloc_type],
                pseudo_static=al.pseudo_static, truncatable=al.truncatable, extendable=al.extendable,
                pcp_active=al.pcp_active, lp_sc_used=al.lp_sc, _r12=0)
    # без проверки (check сообщает нарушения BF Control сам): рис. 9-852 побитно
    bfc = int.from_bytes(F._pack(F.BFC_SPEC, (e.bfc or BF_NONE)._asdict(), 2, 'BF Control'), 'little')
    return E.Allocation(ctrl, bfc, al.src_aid, al.dst_aid, al.start % TSF_LOW_MOD, al.block_dur, al.n_blocks,
                        al.block_period)


def encode(entries):
    """[Entry] → байты одного или нескольких элементов Extended Schedule (9.4.2.131: деление по 17 полей)."""
    return E.encode_extended_schedule([to_field(e) for e in entries])


def decode(infos):
    """Информация элементов (bytes или список) → [Entry] — «a single schedule for the beacon interval»."""
    return [from_field(a) for a in E.parse_extended_schedule(infos)]


def from_elements(elements):
    """Элементы кадра (кортежи (eid, ext, data) — fields.parse_elements / DmgBeacon.elements) → [Entry] или None
    (Extended Schedule в кадре нет)."""
    infos = [d for eid, ext, d in elements if eid == E.EID_EXTENDED_SCHEDULE and ext is None]
    return decode(infos) if infos else None


def sp(src, dst, start, dur, **kw):
    """Короткая запись SP-распределения (AllocationType 0, 10.39.6.2)."""
    bfc = kw.pop('bfc', BF_NONE)
    return Entry(BI.Allocation(SP, src, dst, start, dur, **kw), bfc)


def cbap(start, dur, src=AID_BROADCAST, dst=AID_BROADCAST, **kw):
    """CBAP-распределение (AllocationType 1, 10.39.6.3); broadcast/broadcast — Allocation ID 0 (9.4.2.131)."""
    kw.setdefault('alloc_id', 0 if src == dst == AID_BROADCAST else 1)
    bfc = kw.pop('bfc', BF_NONE)
    return Entry(BI.Allocation(CBAP, src, dst, start, dur, **kw), bfc)


# ====================================================================================== проверка расписания BI
def _shares_sta(a, b):
    """Общая STA у двух распределений (индивидуальные AID источника/получателя, 10.39.6.2 «participate in both»)."""
    x = {a.src_aid, a.dst_aid} - {AID_BROADCAST}
    y = {b.src_aid, b.dst_aid} - {AID_BROADCAST}
    return bool(x & y)


def check(entries, k, bi_tu, bti_end=None, role=E.ROLE_AP, bic=None, params=None, es_tx_tsf=None,
          has_es_in_beacon=None, ati_start=None, ati_duration=0, max_lost=DOT11_MAX_LOST_BEACONS, guard_d=None,
          strict_cbap_only=False):
    """Расписание одного BI: поле (elements.validate_extended_schedule — резерв, кортеж, PCP Active, порядок), BF
    Control в расписании (9.5.5), семантика и согласованность с BI (bi.check_schedule — DTI, перекрытие, guard,
    aMinAllocationDeliveryTime, CBAP Only), плюс правила ниже. Возвращает [(rule, msg)].

    rule (сверх bi.check_schedule):
      'es_field'   — нарушение формата поля Allocation (9.4.2.131, 9.2.2);
      'es_bfc'     — BF Control в расписании (9.5.5);
      'es_bf_bcast' — Beamforming Training = 1 при broadcast Source/Destination AID. СПОРНО: 9.5.5 — «source DMG STA
                     intends to initiate beamforming training with the destination DMG STA»; у broadcast нет одной
                     пары — принято: нарушение;
      'should_sp_listen' — соседние SP с общей STA ближе aDMGPPMinListeningTime (10.39.6.2, «should»)."""
    out = []
    by_ap = role == E.ROLE_AP
    out += [('es_field', m) for m in E.validate_extended_schedule([to_field(e) for e in entries], role=role)]
    for e in entries:
        a, b = e.alloc, e.bfc or BF_NONE
        out += [('es_bfc', f'{a}: {m}') for m in F.check_bf_control(b, frame='ext_schedule')]
        if b.bt and AID_BROADCAST in (a.src_aid, a.dst_aid):
            out.append(('es_bf_bcast', f'{a}: Beamforming Training = 1 при broadcast AID (9.5.5)'))
    cfg = BI.BiConfig(bic=bic, params=params, allocations=[e.alloc for e in entries], ati_start=ati_start,
                      ati_duration=ati_duration, es_tx_tsf=es_tx_tsf, has_es_in_beacon=has_es_in_beacon)
    out += BI.check_schedule(k, bi_tu, cfg, bti_end, by_ap=by_ap, max_lost=max_lost, guard_d=guard_d,
                             strict_cbap_only=strict_cbap_only)
    per = [p for p in BI.layout(k, bi_tu, cfg, bti_end) if p.kind == SP and p.alloc is not None]
    for x, y in zip(per, per[1:]):
        if _shares_sta(x.alloc, y.alloc) and y.start - x.end < aDMGPPMinListeningTime:
            out.append(('should_sp_listen', f'{x}→{y}: {float(y.start - x.end)} мкс < aDMGPPMinListeningTime '
                                            f'{float(aDMGPPMinListeningTime)} при общей STA (10.39.6.2)'))
    return out


def check_repeats(transmissions, pcp_multi_antenna=False):
    """10.39.6.1: «The content of the Extended Schedule element communicated in a beacon interval shall not change if
    transmitted more than once in the beacon interval», кроме PCP Active CBAP у PCP с несколькими DMG-антеннами.
    transmissions — [[Entry], …] в порядке передачи внутри одного BI. → [(rule, msg)]."""
    def norm(entries):
        out = []
        for e in entries:
            f = list(e.alloc.fields())
            if pcp_multi_antenna and e.alloc.alloc_type == CBAP:
                f[e.alloc.__slots__.index('pcp_active')] = None
            out.append((tuple(f), e.bfc))
        return out
    if not transmissions:
        return []
    ref = norm(transmissions[0])
    return [('es_repeat_changed', f'передача {i}: содержимое Extended Schedule изменилось внутри BI (10.39.6.1)')
            for i, t in enumerate(transmissions[1:], 1) if norm(t) != ref]


def _non_ap_participant(a):
    return any(x not in (AID_AP_PCP, AID_BROADCAST) for x in (a.src_aid, a.dst_aid))


def _overlap(xs, ys):
    return any(s < e2 and s2 < e for s, e in xs for s2, e2 in ys)


def check_history(sched, bi_tu, max_lost=DOT11_MAX_LOST_BEACONS, es_tx=None):
    """Псевдостатичные распределения по BI (10.39.6.4, 10.39.6.1). sched — {k: [Entry]} — Extended Schedule,
    переданный AP в BI k (нет ключа — не передан); es_tx — {k: TSF последней передачи ES в BI k} (для
    aMinAllocationDeliveryTime). → [(rule, msg)]:
      'alloc_delivery_ps' — изменено время начала существующего псевдостатичного распределения с non-AP участником
                            ближе aMinAllocationDeliveryTime к передаче ES (10.39.6.1; новое псевдостатичное —
                            исключение по NOTE);
      'should_ps_overlap' — в течение dot11MaxLostBeacons BI после изменения/удаления псевдостатичного распределения
                            запланировано новое, перекрывающее прежнее, не CBAP/CBAP и не того же источника
                            (10.39.6.4, «should not»).
    СПОРНО → принято (PLAN.md №53): «previous pseudo-static allocation» — её повтор с прежним смещением от TBTT
    (bi.Allocation.recur) в BI изменения и следующих, всего dot11MaxLostBeacons BI."""
    out = []
    bi_us = bi_tu * TU
    ks = sorted(sched)
    for kp, kn in zip(ks, ks[1:]):
        prev = {e.alloc.key(): e.alloc for e in sched[kp] if e.alloc.pseudo_static}
        new = {e.alloc.key(): e.alloc for e in sched[kn]}
        for key, a in prev.items():
            b = new.get(key)
            moved = b is not None and (b.start != a.recur(kp, kn, bi_us).start or b.block_dur != a.block_dur
                                       or b.n_blocks != a.n_blocks or b.block_period != a.block_period)
            if b is not None and b.pseudo_static and b.start != a.recur(kp, kn, bi_us).start and \
                    _non_ap_participant(b) and es_tx is not None and kn in es_tx:
                t0 = BI.tbtt(kn, bi_tu)
                if BI.full_tsf(b.start, t0) < Fr(es_tx[kn]) + aMinAllocationDeliveryTime:
                    out.append(('alloc_delivery_ps', f'BI {kn}: {b} — новое начало < ES + '
                                                     f'aMinAllocationDeliveryTime (10.39.6.1)'))
            if b is not None and not moved:
                continue
            # изменено или удалено: прежнее распределение «живёт» у STA ещё до dot11MaxLostBeacons BI
            for j in range(kn, kn + max_lost):
                if j not in sched:
                    continue
                old = a.recur(kp, j, bi_us).blocks(BI.tbtt(j, bi_tu))
                for e in sched[j]:
                    c = e.alloc
                    if c.key() == key or c.key() in prev:
                        continue                      # само изменённое распределение или существовавшее — не новое
                    if c.alloc_type == CBAP and a.alloc_type == CBAP:
                        continue
                    if c.src_aid == a.src_aid:
                        continue
                    if _overlap(c.blocks(BI.tbtt(j, bi_tu)), old):
                        out.append(('should_ps_overlap', f'BI {j}: {c} перекрывает прежнее псевдостатичное {a} '
                                                         f'(изменено/удалено в BI {kn}; 10.39.6.4)'))
    return out


# ====================================================================================== знание расписания у STA
class StaView:
    """Расписание глазами non-AP STA (10.39.6.1, 10.39.6.4, 10.39.6.7): что STA вправе считать своим в BI k.
      receive(k, entries, rx_tsf) — принят Extended Schedule в BI k (TSF приёма — для obsolete allocation);
      receive_cbap_only(k)        — принят DMG Beacon с CBAP Only = 1;
      allocations(k)              — действующие распределения BI k: из ES этого BI (без obsolete новых
                                    псевдостатичных, где STA участвует), иначе — псевдостатичные из последнего
                                    принятого ES, повторённые с тем же смещением, пока pseudo_static_valid (view='sta':
                                    после dot11MaxLostBeacons подряд потерь — «shall cease transmission»);
                                    непсевдостатичные пропущенного BI STA не знает (10.39.6.7).
      cbap_only(k)                — действует ли CBAP Only (тот же предел)."""
    def __init__(self, aid, bi_tu, max_lost=DOT11_MAX_LOST_BEACONS):
        self.aid, self.bi_tu, self.max_lost = aid, bi_tu, max_lost
        self.rx, self.co = {}, set()
        self.known = set()

    def receive(self, k, entries, rx_tsf=None):
        keep = []
        for e in entries:
            a = e.alloc
            part = self.aid in (a.src_aid, a.dst_aid)
            if a.pseudo_static and part and a.key() not in self.known and rx_tsf is not None and \
                    BI.obsolete(a, rx_tsf):
                continue                     # 10.39.6.1: «ignores the allocation … called an obsolete allocation»
            keep.append(e)
        self.rx[k] = keep
        self.known |= {e.alloc.key() for e in keep}

    def receive_cbap_only(self, k):
        self.co.add(k)

    def allocations(self, k):
        if k in self.rx:
            return list(self.rx[k])
        prior = [j for j in self.rx if j < k]
        if not prior:
            return []
        kr = max(prior)
        if not BI.pseudo_static_valid(kr, k, self.max_lost, view='sta'):
            return []
        bi_us = self.bi_tu * TU
        return [Entry(e.alloc.recur(kr, k, bi_us), e.bfc) for e in self.rx[kr] if e.alloc.pseudo_static]

    def cbap_only(self, k):
        prior = [j for j in self.co if j <= k]
        if not prior:
            return False
        kr = max(prior)
        later_es = [j for j in self.rx if kr < j <= k]
        return not later_es and BI.pseudo_static_valid(kr, k, self.max_lost, view='sta')


# ====================================================================================== генератор расписания
Req = namedtuple('Req', 'kind src dst dur pseudo_static truncatable extendable lp_sc bfc alloc_id n_blocks period',
                 defaults=(0, 0, 0, 0, None, None, 1, 0))


def plan(k, bi_tu, bhi_end, requests, max_lost=DOT11_MAX_LOST_BEACONS, listen=True, start=None):
    """Генератор расписания DTI BI k по стандарту: распределения подряд от конца BHI (start — иначе), между соседними
    — guard time (10.39.6.5: bi.guard_between; непсевдостатичное — D = BI), между SP с общей STA — не меньше
    aDMGPPMinListeningTime (10.39.6.2, если listen); Allocation Start — младшие 32 бита TSF (целые мкс, вверх).
    Allocation ID — по паре (источник, получатель) с 1; broadcast CBAP — 0 (9.4.2.131). requests — [Req].
    Распределение, не умещающееся до следующего TBTT, — ScheduleError («cannot cross beacon interval boundaries»)."""
    bi_us = bi_tu * TU
    t_next = BI.tbtt(k + 1, bi_tu)
    t = Fr(ceil(Fr(bhi_end if start is None else start)))
    out, ids, prev = [], {}, None
    for r in requests:
        if prev is not None:
            g = BI.guard_between(bool(prev.pseudo_static), bool(r.pseudo_static), bi_us, max_lost=max_lost)
            if listen and prev.alloc_type == SP and r.kind == SP and \
                    _shares_sta(prev, BI.Allocation(SP, r.src, r.dst, 0, 1)):
                g = max(g, aDMGPPMinListeningTime)
            t = Fr(ceil(prev_end + g))
        bc = r.kind == CBAP and r.src == r.dst == AID_BROADCAST
        aid = r.alloc_id
        if aid is None:
            aid = 0 if bc else ids.get((r.src, r.dst), 0) + 1
        ids[(r.src, r.dst)] = max(ids.get((r.src, r.dst), 0), aid)
        a = BI.Allocation(r.kind, r.src, r.dst, int(t) % TSF_LOW_MOD, r.dur, r.n_blocks,
                          r.period if r.n_blocks > 1 else 0, alloc_id=aid, pseudo_static=r.pseudo_static,
                          truncatable=r.truncatable, extendable=r.extendable, pcp_active=1, lp_sc=r.lp_sc)
        blocks = a.blocks(BI.tbtt(k, bi_tu))
        prev_end = blocks[-1][1]
        if prev_end > t_next:
            raise ScheduleError(f'{a} не умещается до TBTT {float(t_next)} (9.4.2.131)')
        out.append(Entry(a, r.bfc or BF_NONE))
        prev = a
    return out


# ====================================================================================== журнал эфира (общий вид)
def events(evs):
    """Кортежи журнала (как bi.check_air_log): (t_start, t_end, src, dst, kind[, duration_field[, info]]) → [dict] по
    времени. info — dict: mcs, frame (fields.Poll/Spr/Grant/GrantAck — разобранные поля), direction/sector (SSW),
    noack (кадр без ответа). Ключ 'i' — индекс в исходном списке."""
    out = []
    for i, e in enumerate(evs):
        e = tuple(e)
        info = (e[6] if len(e) > 6 and e[6] else {}) or {}
        out.append(dict(i=i, ts=Fr(e[0]), te=Fr(e[1]), src=e[2], dst=e[3], kind=e[4],
                        dur=e[5] if len(e) > 5 else None, mcs=info.get('mcs'), frame=info.get('frame'),
                        direction=info.get('direction'), sector=info.get('sector'), noack=info.get('noack', False)))
    out.sort(key=lambda r: (r['ts'], r['te']))
    return out
