# SPDX-License-Identifier: AGPL-3.0-or-later
"""Смена параметров DMG BSS по 802.11-2020 11.29 [p. 2361–2363]: общие правила 11.29.1, перенос TBTT 11.29.2
(рис. 11-47), смена длительности BI 11.29.3 (рис. 11-48), рекомендация параметров точке 11.29.5; элемент DMG BSS
Parameter Change (9.4.2.126, рис. 9-547/9-548 [p. 1235] — кодек в elements.py); сброс TSF при изменении (11.1.3.3.1
[p. 2052]: «shall reestablish the TBTT by resetting the TSF to 0»); dot11NbrOfChangeBeacons (MIB, DEFVAL 4) и
dot11MaxLostBeacons; кадры Information Request / Information Response (9.6.19.4, табл. 9-460; 9.6.19.5, табл. 9-461
[p. 1571–1572]) и их общие правила (11.28.1 [p. 2359]) — в объёме, нужном 11.29.5 и 11.8.2.2/11.8.8.6 (chswitch).

Поведение:
  ApBssParamChange — точка: план маяков с элементом (dot11NbrOfChangeBeacons TBTT), Beacon Interval на TBTT N+1,
                     новый TBTT на N+2 (перенос) или новый BI на N+1 (длительность), сброс TSF в момент вступления.
  check_beacon_sequence — судья последовательности BTI (Timestamp первого маяка, поле Beacon Interval, элемент):
                     неизменность элемента, TBTT Offset = младшие 4 октета намеченного TBTT, число объявлений
                     > dot11MaxLostBeacons, Beacon Interval на N+1, сдвиг ≤ Beacon Interval, сброс TSF, конец
                     объявлений.
  sta_tx_crosses_new_tbtt — запрет STA передавать за новый TBTT в BI перед ним (11.29.2).
  recommend / ap_answer — рекомендация STA (11.29.5) и ответ точки Information Response.

Не моделируется: кластеры AP/PCP (11.29.4, 10.40 — вне open); Announce в ATI — тот же элемент, судья смотрит только
DMG Beacon (Announce в захватах нет); доставка элемента STA с псевдостатичными SP и в power save (11.29.1) — SP — pro,
PS удалён; содержание ответа на Request element (поддерживаемые элементы, RCPI/RSNI, 11.28.1) — только каркас кадра.

Время — Fraction мкс; TSF — мкс; TBTT Offset — младшие 32 бита TSF; нарушения — список строк."""
from collections import namedtuple

from . import elements as E
from .timing import BCAST, DOT11_MAX_LOST_BEACONS, TSF_LOW_MOD, TU, aMaxBIDuration

# MIB (приложение C): dot11NbrOfChangeBeacons SYNTAX Unsigned32 (1..32), DEFVAL { 4 } — перенести в timing.py
DOT11_NBR_OF_CHANGE_BEACONS_DEFVAL = 4
NBR_MAX = 32
# 11.29.2/11.29.3: «The value of dot11NbrOfChangeBeacons shall be greater than dot11MaxLostBeacons».
# СПОРНО → принято (PLAN.md №38): DEFVAL 4 = dot11MaxLostBeacons 4 нарушает это требование — норма — требование,
# наименьшее допустимое — 5 (модель по умолчанию — 5).
NBR_MIN = DOT11_MAX_LOST_BEACONS + 1

Change = namedtuple('Change', 'move size tbtt_offset bi_duration')


def change_from(d):
    return Change(d['move'], d['size'], d['tbtt_offset'], d['bi_duration'])


def encode_change(ch):
    return E.encode_bss_param_change(ch.move, ch.size, ch.tbtt_offset % TSF_LOW_MOD, ch.bi_duration if ch.size else 0)


def check_change(d):
    """Поля элемента (9.4.2.126): резерв B2–B7 = 0; BI Duration зарезервирован при Size = 0; пустое изменение;
    BI Duration ≤ aMaxBIDuration (11.1.3.3.1)."""
    v = E.reserved_nonzero(E.CHANGE_TYPE, {'_r2': d.get('_r2', 0)}, 'DMG BSS Parameter Change')
    if not d['size'] and d['bi_duration']:
        v.append(f'DMG BSS Parameter Change: BI Duration {d["bi_duration"]} при Size = 0 — зарезервирован (9.4.2.126, '
                 f'9.2.2)')
    if not d['move'] and not d['size']:
        v.append('DMG BSS Parameter Change: Move = Size = 0 — ни TBTT, ни BI не меняются (9.4.2.126)')
    if d['size'] and not 0 < d['bi_duration'] * TU <= aMaxBIDuration:
        v.append(f'DMG BSS Parameter Change: BI Duration {d["bi_duration"]} TU вне (0, aMaxBIDuration] (11.1.3.3.1)')
    return v


def low32(t):
    return int(t) % TSF_LOW_MOD


def diff32(a, b):
    """a − b по модулю 2³² в (−2³¹, 2³¹] (PLAN.md №12)."""
    d = (int(a) - int(b)) % TSF_LOW_MOD
    return d - TSF_LOW_MOD if d > TSF_LOW_MOD // 2 else d


# =====================================================================================================================
# Точка: план процедуры
# =====================================================================================================================
BeaconPlan = namedtuple('BeaconPlan', 'j at tsf bi_tu change')
# j — номер TBTT от первого объявления (1…); at — момент TBTT на непрерывной шкале (мкс); tsf — значение TSF точки в
# этот TBTT (после сброса — от 0); bi_tu — поле Beacon Interval маяков этого BI; change — элемент или None


class ApBssParamChange:
    def __init__(self, bi_tu, nbr=NBR_MIN):
        if not DOT11_MAX_LOST_BEACONS < nbr <= NBR_MAX:
            raise ValueError(f'dot11NbrOfChangeBeacons {nbr}: нужно > dot11MaxLostBeacons {DOT11_MAX_LOST_BEACONS} и '
                             f'≤ {NBR_MAX} (11.29.2, MIB)')
        self.bi_tu, self.nbr = bi_tu, nbr

    def plan(self, t1, move_to=None, new_bi_tu=None, after=2, at1=None):
        """t1 — TSF TBTT первого объявления; move_to — намеченный новый TBTT (TSF старой шкалы, 11.29.2); new_bi_tu —
        новый BI (11.29.3). Возвращает [BeaconPlan] до after BI после вступления изменения."""
        bi, n = self.bi_tu * TU, self.nbr
        at1 = t1 if at1 is None else at1
        if move_to is None and new_bi_tu is None:
            raise ValueError('нечего менять')
        out = []
        if move_to is None:
            # 11.29.3: TBTT Offset — TBTT позиции N+1; там BI = BI Duration и сброс TSF
            ch = Change(0, 1, low32(t1 + n * bi), new_bi_tu)
            for j in range(1, n + 1):
                out.append(BeaconPlan(j, at1 + (j - 1) * bi, t1 + (j - 1) * bi, self.bi_tu, ch))
            at, nb = at1 + n * bi, new_bi_tu
            for j in range(n + 1, n + 2 + after):
                out.append(BeaconPlan(j, at, (j - n - 1) * nb * TU, nb, None))
                at += nb * TU
            return out
        tn1 = t1 + n * bi                               # TBTT N+1 (старая шкала)
        d = move_to - tn1
        if not 0 < d <= 2 * bi or d % TU:
            raise ValueError(f'новый TBTT через {d} мкс после TBTT N+1: нужно (0, 2·BI] и кратно TU (11.29.2: Beacon '
                             f'Interval на N+1 = разность)')
        if abs(d - bi) > bi:
            raise ValueError('сдвиг TBTT больше Beacon Interval (11.29.2)')
        nb = new_bi_tu if new_bi_tu is not None else self.bi_tu
        ch = Change(1, int(new_bi_tu is not None), low32(move_to), new_bi_tu or 0)
        for j in range(1, n + 1):
            out.append(BeaconPlan(j, at1 + (j - 1) * bi, t1 + (j - 1) * bi, self.bi_tu, ch))
        # СПОРНО → принято (PLAN.md №39): элемент в маяках TBTT N+1 есть («every … after … first included, stopping
        # … immediately after the … change takes effect» — вступает на новом TBTT); судья допускает и без него
        out.append(BeaconPlan(n + 1, at1 + n * bi, tn1, int(d // TU), ch))
        at = at1 + n * bi + d
        for k in range(after + 1):
            out.append(BeaconPlan(n + 2 + k, at, k * nb * TU, nb, None))   # 11.1.3.3.1: TSF = 0 на новом TBTT
            at += nb * TU
        return out


def new_tbtt_of(plan):
    """Момент (непрерывная шкала) вступления: первый BeaconPlan после объявлений с TSF = 0."""
    for p in plan:
        if p.change is None and p.tsf == 0:
            return p.at
    return None


def sta_tx_crosses_new_tbtt(t, te, t_new):
    """11.29.2: STA «shall not transmit during the beacon interval that precedes a new TBTT if the transmission time
    ends at the TBTT or later»."""
    return t < t_new <= te


def check_schedule_fits(allocs, tbtt_tsf, bi_tu):
    """11.29.3: при укорочении BI точка не планирует SP/CBAP дольше нового BI — блоки Allocation (младшие 32 бита TSF)
    от TBTT должны кончаться не позже TBTT + BI Duration."""
    v = []
    for a in allocs:
        for k, (s, e) in enumerate(E.allocation_blocks(a)):
            end = (e - int(tbtt_tsf)) % TSF_LOW_MOD
            if end > bi_tu * TU:
                v.append(f'Allocation {a.ctrl["allocation_id"]} блок {k}: конец через {end} мкс после TBTT > BI '
                         f'{bi_tu} TU (11.29.3)')
    return v


# =====================================================================================================================
# Судья последовательности BTI
# =====================================================================================================================
Bti = namedtuple('Bti', 'ts bi_tu change ref')
# ts — Timestamp первого маяка BTI (TSF точки); bi_tu — поле Beacon Interval; change — dict parse_bss_param_change или
# None; ref — что вернуть в нарушении (событие)
BTI_SLACK = TU                      # TBTT по Timestamp: маяк BTI начинается не позже 1 TU после TBTT (bti_delay)


def tbtt_of(ts, bi_tu):
    """TBTT BI по Timestamp первого маяка: 11.1.3.3.1 «Time value zero of the TSF is defined to be a TBTT» — TBTT
    кратны BI на шкале TSF."""
    return ts - ts % (bi_tu * TU)


def check_beacon_sequence(btis, nbr_min=NBR_MIN):
    """btis — [Bti] подряд по захвату. Возвращает (нарушения [(ref, текст)], пропуски [причина], сводка [dict])."""
    viol, skip, runs = [], [], []
    i = 0
    while i < len(btis):
        if btis[i].change is None:
            i += 1
            continue
        s = i
        while i < len(btis) and btis[i].change is not None:
            i += 1
        run, nxt = btis[s:i], btis[i:]
        _check_run(run, nxt, nbr_min, viol, skip, runs, at_start=s == 0)
    return viol, skip, runs


def _check_run(run, nxt, nbr_min, viol, skip, runs, at_start):
    first = run[0]
    ch = first.change
    for b in run[1:]:
        if b.change != ch:
            viol.append((b.ref, f'DMG BSS Parameter Change изменился во время объявления: {ch} → {b.change} (11.29.2/'
                                f'11.29.3: «At each transmission … the TBTT Offset field shall be set to … the '
                                f'intended TBTT»)'))
            return
    for m in check_change(ch):
        viol.append((first.ref, m))
    bi_old = first.bi_tu
    bi = bi_old * TU
    tb = [tbtt_of(b.ts, bi_old) for b in run]
    for m in range(1, len(run)):
        if tb[m] - tb[m - 1] != bi:
            if run[m].ts < BTI_SLACK:
                # TSF сброшен (изменение вступило), а элемент ещё в маяках — объявление не остановлено (11.29.1)
                for q in run[m:]:
                    viol.append((q.ref, 'DMG BSS Parameter Change после вступления изменения (TSF сброшен) (11.29.1: '
                                        '«stopping in the DMG Beacon … immediately after the DMG BSS parameter change '
                                        'takes effect»)'))
                nxt = list(run[m:]) + list(nxt)
                run, tb = run[:m], tb[:m]
                break
            skip.append('между маяками объявления пропущены BTI (запись) или сменился TSF — шаг TBTT ≠ BI')
            return
    info = dict(move=ch['move'], size=ch['size'], announced=len(run), bi_old=bi_old)
    runs.append(info)
    if at_start:
        skip.append('объявление DMG BSS Parameter Change началось до начала захвата — число объявлений не проверено')
    if not nxt:
        skip.append('захват кончился во время объявления DMG BSS Parameter Change')
        return
    off = ch['tbtt_offset']
    if ch['move']:
        # позиция N+1 — BTI, где поле Beacon Interval = разность нового TBTT и TBTT этого BTI (11.29.2)
        cands = list(run) + [nxt[0]]
        tbs = tb + [tb[-1] + bi]
        p = None
        for j, (b, t) in enumerate(zip(cands, tbs)):
            d = diff32(off, t)
            if b.bi_tu != bi_old and 0 < d and abs(b.bi_tu * TU - d) < TU:
                p = j
                break
        if p is None:
            viol.append((nxt[0].ref, f'перенос TBTT: нет BTI с Beacon Interval = новый TBTT − TBTT этого BTI (11.29.2: '
                                     f'«shall be set to the difference of the intended new TBTT and the TBTT where … '
                                     f'sent»)'))
            return
        n = p                               # позиции 1…N — объявления до N+1
        d = diff32(off, tbs[p])
        info.update(nbr=n, p_ref=cands[p].ref, d=d)
        if abs(d - bi) > bi:
            viol.append((cands[p].ref, f'перенос TBTT на {d - bi} мкс — больше Beacon Interval {bi_old} TU (11.29.2)'))
        if not at_start and n < nbr_min:
            viol.append((cands[p].ref, f'перенос TBTT после {n} объявлений: dot11NbrOfChangeBeacons должен быть > '
                                       f'dot11MaxLostBeacons {DOT11_MAX_LOST_BEACONS} (11.29.2)'))
        seq = list(run) + list(nxt)
        for q in seq[p + 1:len(run)]:
            viol.append((q.ref, 'DMG BSS Parameter Change после TBTT N+1 (11.29.1: «stopping in the DMG Beacon … '
                                'immediately after the DMG BSS parameter change takes effect»)'))
        if len(seq) <= p + 1:
            skip.append('захват кончился до нового TBTT')
            return
        new = seq[p + 1]
        nb = ch['bi_duration'] if ch['size'] else bi_old
        _check_reset(new, nb, viol, '11.29.2')
        info['new_bi'] = nb
        return
    # только Size (11.29.3): TBTT Offset — TBTT позиции N+1, N — число объявлений
    n = len(run)
    info['nbr'] = n
    want = low32(tb[-1] + bi)
    if off != want:
        k = diff32(off, tb[0]) / bi if bi else 0
        viol.append((first.ref, f'смена BI: TBTT Offset {off} ≠ TBTT позиции N+1 {want} (по {n} объявлениям; Offset '
                                f'указывает позицию {float(k) + 1:.2f}) (11.29.3)'))
    if not at_start and n < nbr_min:
        viol.append((first.ref, f'смена BI после {n} объявлений: dot11NbrOfChangeBeacons должен быть > '
                                f'dot11MaxLostBeacons {DOT11_MAX_LOST_BEACONS} (11.29.3)'))
    _check_reset(nxt[0], ch['bi_duration'], viol, '11.29.3')
    info['new_bi'] = ch['bi_duration']


def _check_reset(b, bi_tu, viol, cl):
    if b.bi_tu != bi_tu:
        viol.append((b.ref, f'после изменения Beacon Interval {b.bi_tu} TU ≠ {bi_tu} ({cl})'))
    # 11.1.3.3.1: «resetting the TSF to 0 at the time the BSS parameter change takes effect»
    if b.ts >= BTI_SLACK:
        viol.append((b.ref, f'после изменения TSF не сброшен: Timestamp {b.ts} мкс ≥ 1 TU от нового TBTT (11.1.3.3.1, '
                            f'{cl})'))


# =====================================================================================================================
# Information Request / Response (9.6.19.4/9.6.19.5, 11.28.1) — каркас
# =====================================================================================================================
CAT_DMG = 16                        # табл. 9-51: «16 DMG», robust — Yes
ACT_INFO_REQ, ACT_INFO_RESP = 2, 3  # 9.6.19.1 (табл. 9-457)
EID_REQUEST = E.element_key('Request')[0]                 # 10
InfoFrame = namedtuple('InfoFrame', 'action subject elements')


def encode_info(action, subject, elements=()):
    return bytes([CAT_DMG, action]) + E.mac_bytes(subject) + E.encode_elements(elements)


def parse_info(body):
    if len(body) < 8 or body[0] != CAT_DMG or body[1] not in (ACT_INFO_REQ, ACT_INFO_RESP):
        raise ValueError('не Information Request/Response (9.6.19.1)')
    return InfoFrame(body[1], E.mac_str(body[2:8]), E.parse_elements(body[8:]))


def check_info(f, ra=None, noack=None):
    """Табл. 9-460: Request element обязателен (4-й по порядку, первым элементом); табл. 9-461: «One or more DMG
    Capabilities elements» первыми; 9.6.19.5: широковещательный Response — Action No Ack."""
    v = []
    eids = [e.eid for e in f.elements]
    if f.action == ACT_INFO_REQ:
        if not eids or eids[0] != EID_REQUEST:
            v.append('Information Request: первым элементом должен быть Request element (табл. 9-460)')
    else:
        if not eids or eids[0] != E.EID_DMG_CAPABILITIES:
            v.append('Information Response: нет DMG Capabilities первым элементом (табл. 9-461: «One or more»)')
        if ra == BCAST and noack is False:
            v.append('Information Response широковещательный — не Action No Ack (9.6.19.5)')
    return v


def find(elements, eid):
    return [e for e in elements if e.eid == eid]


# =====================================================================================================================
# 11.29.5 — рекомендация
# =====================================================================================================================
def recommend(sta_tsf_at_tbtt=None, bi_tu=None):
    """Элемент рекомендации STA: Move — TBTT Offset = младшие 4 октета TSF STA в рекомендуемом первом изменённом TBTT;
    Size — BI Duration в TU."""
    return Change(int(sta_tsf_at_tbtt is not None), int(bi_tu is not None),
                  low32(sta_tsf_at_tbtt or 0), bi_tu or 0)


def ap_answer(rec, accept, ap, now_tsf):
    """Ответ точки на Information Request с элементом (11.29.5) в момент now_tsf (TSF точки): принимает — элемент в
    Information Response и план 11.29.2/11.29.3; нет (или не успевает: до первого объявления меньше BI) — без элемента
    («If the AP or PCP decides not to change the BSS parameters, it shall not include …»). Возвращает (элементы ответа,
    план или None)."""
    if not accept:
        return [], None
    bi = ap.bi_tu * TU
    new_bi = rec.bi_duration if rec.size else None
    if rec.move:
        want = now_tsf + diff32(rec.tbtt_offset, now_tsf)       # TSF STA ≈ TSF точки (11.1.3.7)
        tn1 = tbtt_of(want - 1, ap.bi_tu)                       # последний TBTT строго раньше нового
        d = max(TU, (want - tn1) // TU * TU)                    # Beacon Interval на N+1 — целые TU (PLAN.md №40)
        t1 = tn1 - ap.nbr * bi
        if t1 <= now_tsf:
            return [], None
        plan = ap.plan(t1, move_to=tn1 + d, new_bi_tu=new_bi)
    else:
        plan = ap.plan(tbtt_of(now_tsf, ap.bi_tu) + bi, new_bi_tu=new_bi)
    return [E.Element(E.EID_DMG_BSS_PARAMETER_CHANGE, None, encode_change(plan[0].change)[2:])], plan


def check_recommendation_answer(resp_change, later_changes):
    """11.29.5: точка, включившая элемент в Information Response, «shall use the procedure defined in 11.29.2 and
    11.29.3» — дальше маяки объявляют то же изменение. later_changes — элементы маяков после ответа (dict)."""
    if resp_change is None:
        return []
    if not later_changes:
        return ['Information Response с DMG BSS Parameter Change, а маяки изменение не объявляют (11.29.5)']
    if any(change_from(c) != change_from(resp_change) for c in later_changes[:1]):
        return [f'маяки объявляют {change_from(later_changes[0])}, а Information Response — '
                f'{change_from(resp_change)} (11.29.5: «reflecting the BSS parameter changes»)']
    return []
