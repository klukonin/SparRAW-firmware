# SPDX-License-Identifier: AGPL-3.0-or-later
"""Судья эталонной модели над захватом эфира сниффером узла (ref/air_pcap): каждое правило модели, проверяемое по
тому, что записано, — с числом проверенных случаев, нарушениями и примерами; что проверить нельзя — «не проверяемо» с
причиной (без молчаливого «ок»).

    python3 -m ref.air_judge ap.pcap:AP sta.pcap:STA [--examples 5] [--json out.json]

Что известно о захвате и как это ограничивает правила — ref/air_pcap (докстрока) и rewrite/docs/CAPTURE.md:
  - заголовки своих TX-кадров настоящие (Duration, поля BF, BA Control), тел данных нет; данные и QoS Null видны
    только синтетическими RX-записями пира (FC по слоту, Duration 0, тело нулевое) — Ack Policy, RDG/More PPDU, SN
    данных неизвестны; часть A-MPDU (отданные в очередь) не видна вовсе — «скрытые PPDU»;
  - метки TSF — целые мкс (у разности двух меток ошибка до ±1 мкс), у ответов MAC метка TX испорчена — время из
    записи пира; без пира — только границы (такие кадры в правилах времени не участвуют);
  - точка метки в PPDU — допущение air_pcap.PRE (СПОРНО): промежутки между кадрами одного класса модуляции от него
    не зависят; control ↔ SC — с поправкой ±PRE_UNCERT.

Вердикт нарушения: 'ours' — кадр собран нашей прошивкой/MAC узла (TX-запись), правило однозначно; 'model' —
нарушение зависит от трактовки модели (СПОРНО/PLAN.md); 'capture' — объяснимо ограничением записи."""
import json
import os
import sys
from collections import Counter, defaultdict
from fractions import Fraction as Fr

if __package__ in (None, ''):
    sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
    __package__ = 'ref'

from . import abft as A           # noqa: E402
from . import air_pcap as AP       # noqa: E402
from . import beamtrack as BT      # noqa: E402
from . import bi as BI             # noqa: E402
from . import blockack as BA       # noqa: E402
from . import duration as D        # noqa: E402
from . import elements as E        # noqa: E402
from . import fields as F          # noqa: E402
from . import linkmaint as LM      # noqa: E402
from . import mlme as M            # noqa: E402
from . import nav as NV            # noqa: E402
from . import sls as S             # noqa: E402
from . import timing as T          # noqa: E402

from .timing import SIFS, SIFS_TOL, aSlotTime as SLOT     # noqa: E402
Q = Fr(1)                          # квант метки TSF: разность двух меток — ошибка (−1, +1) мкс
CAL_UNCERT = Fr(1, 4)              # разброс калибровки (сдвиг TSF второго узла по окнам, rx_off)
PRE_UNCERT = Fr(3, 4)              # СПОРНО: точка метки control (с заголовком или без, air_pcap.PRE)
AIFSN_BE = 3                       # табл. 9-155: AC_BE (EDCA Parameter Set в захвате нет — по умолчанию)
T_MIN_PPDU = T.txtime(14, 12)      # самый короткий PPDU (скрытый кадр): Ack-размер на наибольшей SC MCS
RESP_WINDOW = Fr(12)               # «похоже на ответ»: начало ≤ 12 мкс после конца вызвавшего (классификация)

# Страницы 802.11-2020 (docs/80211-2020.txt, маркеры [Page N])
PAGE = {'9.2.2': 757, '9.2.4.1': 758, '9.2.5.1': 791, '9.2.5.2': 791, '9.2.5.7': 795, '9.3.1.6': 799,
        '9.3.1.8.1': 803, '9.3.1.13': 809, '9.3.1.15': 810, '9.3.1.16': 811, '9.3.1.17': 811, '9.3.4.2': 857,
        '9.7.3': 1615, '10.3.2.3.3': 1644, '10.3.2.3.8': 1647, '10.3.2.9': 1655, '10.3.2.11': 1660, '10.3.7': 1680,
        '10.6.7.1': 1701, '10.6.7.2': 1702, '10.23.2.4': 1741, '10.23.2.8': 1747, '10.23.2.10': 1751,
        '10.25.6': 1791, '10.29.2': 1819, '10.39.2': 1878, '10.39.5': 1882, '10.42.2': 1933, '10.42.4': 1946,
        '10.42.5': 1946, '11.1.3.1': 2050, '11.1.3.3.1': 2052, '20.11.3': 3007,
        '10.3.2.4': 1648, '10.39.3': 1879, '10.39.10': 1902, '10.42.3.1': 1941, '10.42.6.4': 1961, '10.42.7': 1964,
        '11.3.3': 2128, '11.27.1': 2355}


def cite(cl):
    p = PAGE.get(cl)
    return f'{cl} [p. {p}]' if p else cl


_CAL = {'c': None}


class Rule:
    """Итог правила: checked — проверено случаев, viol — [(индекс события, текст, вердикт)], unchecked — Counter
    причин «не проверяемо», info — наблюдения (числа, распределения); status — 'checked' | 'partial' | 'unchecked'."""
    def __init__(self, rid, clause, title):
        self.rid, self.clause, self.title = rid, clause, title
        self.checked, self.viol, self.unchecked, self.info = 0, [], Counter(), {}
        self.verdict_note = ''
        self.timing = rid in TIMING_RULES
        self.ctx_cal_ok = lambda e: _CAL['c'] is None or _cal_ok_near(_CAL['c'], e)

    def ok(self, n=1):
        self.checked += n

    def bad(self, e, msg, verdict='ours'):
        self.checked += 1
        if self.timing and verdict == 'ours' and e is not None and not self.ctx_cal_ok(e):
            verdict = 'capture'           # время из окна, где сдвиг TSF второго узла ненадёжен (до ассоциации)
        self.viol.append((e.i if e is not None else -1, msg, verdict))

    def skip(self, why, n=1):
        self.unchecked[why] += n

    @property
    def status(self):
        if not self.checked:
            return 'unchecked'
        return 'partial' if self.unchecked else 'checked'

    def as_dict(self, evs, n=5):
        by = Counter(v for _, _, v in self.viol)
        kinds = Counter(_msg_kind(m) for _, m, _ in self.viol)
        return dict(rule=self.rid, clause=cite(self.clause), title=self.title, status=self.status,
                    checked=self.checked, violations=len(self.viol), by_verdict=dict(by),
                    by_kind=dict(kinds.most_common(8)),
                    unchecked=dict(self.unchecked), info=self.info, note=self.verdict_note,
                    examples=[dict(event=evs[i].where() if 0 <= i < len(evs) else '-', msg=m, verdict=v)
                              for i, m, v in _spread(self.viol, n)])


TIMING_RULES = ('ifs_sifs', 'holder_gap', 'access', 'responder_tx', 'resp_seq', 'nav_txop', 'cbap_end', 'bti_delay',
                'sls', 'txop_limit', 'rd', 'cf_end_rules', 'nav_rx')


def _msg_kind(m):
    """Вид нарушения для сводки: текст без чисел и адресов."""
    import re
    m = re.sub(r'#?\d[\d.,:]*|[0-9a-f]{2}(:[0-9a-f]{2}){5}|0x[0-9a-f]+', '…', m.split(' (')[0])
    return m[:90]


def _spread(viol, n):
    """Примеры: по одному на каждый вид сообщения (первые слова), затем первые."""
    seen, out = set(), []
    for x in viol:
        k = x[1].split(':')[0][:40]
        if k not in seen:
            seen.add(k)
            out.append(x)
        if len(out) >= n:
            return out
    for x in viol:
        if x not in out:
            out.append(x)
        if len(out) >= n:
            break
    return out


def mode(e):
    return AP.mode_of(e.mcs) if e.mcs is not None else None


def slack(a, b):
    """Допуск сравнения промежутка между кадрами a и b с номиналом: квант меток + калибровка (+ точка метки control,
    если классы модуляции разные и кадры записаны разными направлениями)."""
    s = Q + CAL_UNCERT
    if mode(a) != mode(b):
        s += PRE_UNCERT
    return s


def stat(v):
    if not v:
        return {}
    v = sorted(float(x) for x in v)
    n = len(v)
    return dict(n=n, mean=round(sum(v) / n, 3), min=round(v[0], 3), p5=round(v[n // 20], 3),
                median=round(v[n // 2], 3), p95=round(v[min(n - 1, n * 19 // 20)], 3), max=round(v[-1], 3))


# =====================================================================================================================
class Ctx:
    """Общие для правил данные: события, MAC узлов, AP, EDCA Parameter Set (из захвата или edca=(params, источник))."""
    def __init__(self, air, edca=None):
        self.air, self.evs, self.ap = air, air.events, air.ap
        self.edca, self.edca_src = edca if edca else edca_from(self.evs, self.ap)
        self.k = [e for e in self.evs if e.t_ok]                  # с известным временем
        self.pos = {e.i: j for j, e in enumerate(self.k)}
        self.unk = [e for e in self.evs if not e.t_ok]
        self.prev = {}                                            # i → предыдущий (по концу) с известным временем
        last = None
        for e in self.k:
            self.prev[e.i] = last
            if last is None or e.te > last.te:
                last = e
        self.nxt = {}
        for a, b in zip(self.k, self.k[1:]):
            self.nxt[a.i] = b
        import bisect
        self._unk_lo = sorted((e.t_lo, e.t_hi, e.i) for e in self.unk)
        self._bis = bisect
        self.recs = {n: {r.n: r for r in v} for n, v in air.recs.items()}

    def hidden_possible(self, a, b):
        """Мог ли между концом a и началом b пройти невидимый PPDU (данные без записи, кадр без времени): места
        хватает на SIFS + самый короткий PPDU + SIFS, или кадр без времени попадает в промежуток."""
        gap = b.t - a.te
        if gap >= 2 * SIFS + T_MIN_PPDU - Q - CAL_UNCERT:
            return True
        i = self._bis.bisect_left(self._unk_lo, (a.t - 200,))
        for lo, hi, j in self._unk_lo[i:]:
            if lo > b.t:
                break
            if hi >= a.t:
                return True
        return False


ELICIT = {'DMG CTS': ('RTS',), 'BlockAck': ('A-MPDU', 'Data', 'BlockAckReq'),
          'Ack': ('Data', 'QoS Null', 'A-MPDU') + tuple(v for v in AP.MGMT_NAME.values() if v != 'Action No Ack'),
          'CF-End': ('CF-End',)}


def is_response_pair(p, e):
    """e — ответ на p по виду и адресам (без времени)."""
    if p is None or e.dst != p.src or (e.src is not None and p.dst != e.src):
        return False                  # у Ack/CTS TA нет (9.3.1) — передатчик ответа не записан
    if e.kind == 'A-MPDU' and e.first == 'BlockAck':              # RD-ответ: A-MPDU с BlockAck впереди (табл. 9-530)
        return p.kind in ('A-MPDU', 'Data')
    if e.kind == 'CF-End':
        return p.kind == 'CF-End' and p.dur_ok and p.dur != 0
    return p.kind in ELICIT.get(e.kind, ())


# =====================================================================================================================
# правила
# =====================================================================================================================
def r_fc(c):
    r = Rule('fc', '9.2.4.1', 'Frame Control (поля, резерв, +HTC = 0 у DMG)')
    for e in c.evs:
        if e.synth:
            r.skip('синтетический RX: FC восстановлен по слоту парсера, не записан')
            continue
        ms = F.check_fc(e.fc)
        for m in ms:
            r.bad(e, m)
        if not ms:
            r.ok()
    return r


CTL_LEN = {'RTS': 20, 'DMG CTS': 20, 'CF-End': 20, 'Ack': 14, 'BlockAck': 32, 'BlockAckReq': 24, 'SSW': 26,
           'SSW-Feedback': 28, 'SSW-Ack': 28}
CTL_FIG = {'RTS': 'рис. 9-26', 'DMG CTS': 'рис. 9-52', 'CF-End': 'рис. 9-34', 'Ack': 'рис. 9-28',
           'BlockAck': 'рис. 9-41 Compressed', 'BlockAckReq': 'рис. 9-35', 'SSW': 'рис. 9-54',
           'SSW-Feedback': 'рис. 9-55', 'SSW-Ack': 'рис. 9-56'}


def r_ctl_len(c):
    r = Rule('ctl_len', '9.3.1.2', 'длина PSDU кадров управления (рисунки 9.3.1.x; длина — из PHY, есть и у '
             'синтетических)')
    for e in c.evs:
        n = CTL_LEN.get(e.kind)
        if n is None:
            continue
        if e.length == n:
            r.ok()
        else:
            r.bad(e, f'{e.kind}: PSDU {e.length} октетов ≠ {n} ({CTL_FIG[e.kind]})')
    return r


def r_cfe_fields(c):
    r = Rule('cfe_fields', '9.3.1.13', 'поля кадров Control Frame Extension бит-в-бит (DMG CTS, SSW, SSW-Feedback, '
             'SSW-Ack; 9.3.1.13–9.3.1.17, 9.5)')
    for e in c.evs:
        if e.kind not in AP.CFE_NAME.values():
            continue
        if not e.body_ok:
            r.skip('синтетический RX: тело нулевое (поля SSW/Feedback не записаны)')
            continue
        ctx = dict(sender_ap_pcp=(e.src == c.ap))
        if e.kind == 'SSW':
            ctx['in_cbap'] = True       # DTI — один CBAP (CBAP Only = 1 в DMG Parameters маяков захвата)
        if e.kind == 'SSW-Feedback':
            ctx['abft'] = False
        ms = F.check_mpdu(e.raw, with_fcs=False, **ctx)
        for m in ms:
            r.bad(e, m)
        if not ms:
            r.ok()
    return r


def r_beacon_fields(c):
    r = Rule('beacon_fields', '9.3.4.2', 'DMG Beacon: поля (SSW, BI, BIC, DMG Parameters, порядок элементов табл. '
             '9-45) и Timestamp = метка TX')
    ts_eq = ts_ne = 0
    diff = Counter()
    for e in c.evs:
        if e.kind != 'DMG Beacon':
            continue
        if not e.body_ok:
            r.skip('маяк записан не целиком (TRUNC) или синтетический')
            continue
        if not e.tx_node:
            r.skip('маяк есть только в RX-записи: её байты отличаются от переданных (октет 25, последний) — поля по '
                   'ней не проверяются')
            continue
        ms = F.check_mpdu(e.raw, with_fcs=False, role='ap', pcp=False)
        for m in ms:
            r.bad(e, m)
        if not ms:
            r.ok()
        if e.tx_node and e.p is not None:
            tx = next((c.recs[n][k] for n, k in e.recs if n == e.tx_node), None)
            if tx is not None and tx.tsft is not None:
                if e.p.timestamp == tx.tsft:
                    ts_eq += 1
                else:
                    ts_ne += 1
        for n, k in e.recs:
            q = c.recs[n][k]
            if not q.tx and not q.synth and e.tx_node:
                d = [j for j in range(min(len(q.raw), len(e.raw))) if q.raw[j] != e.raw[j]]
                diff[tuple(d)] += 1
    r.info['timestamp_eq_tx_stamp'] = ts_eq
    r.info['timestamp_ne_tx_stamp'] = ts_ne
    r.info['rx_vs_tx_bytes_differ_at'] = {str(k): v for k, v in diff.items()}
    r.verdict_note = ('Timestamp == метка TX у всех маяков: точка метки TX = точка Timestamp (11.1.3.1: начало символа '
                      'данных с первым битом кадра) — основа допущения air_pcap.PRE; соответствие самой точки 11.1.3.1 '
                      'не проверяемо без внешнего эталона времени. Байты RX-записи маяка у STA отличаются от '
                      'TX-записи AP (октет 25 и последний) — особенность записи RX (как последний байт TA), поля '
                      'берутся из TX.')
    return r


def r_ba_control(c):
    r = Rule('ba_control', '9.3.1.8.1', 'BlockAck: BA Control — вариант Compressed (табл. 9-28), резервные биты = 0 '
             '(рис. 9-42, 9.2.2), TID')
    tids = Counter()
    for e in c.evs:
        if e.kind != 'BlockAck' and not (e.kind == 'A-MPDU' and e.first == 'BlockAck'):
            continue
        if e.synth or e.raw is None or len(e.raw) < 18:
            r.skip('синтетический RX: BA Control не записан')
            continue
        ctl = int.from_bytes(e.raw[16:18], 'little')
        multi, comp, gcr = ctl >> 1 & 1, ctl >> 2 & 1, ctl >> 3 & 3
        tids[ctl >> 12] += 1
        msgs = []
        if (multi, comp, gcr) != (0, 1, 0):
            msgs.append(f'BA Control {ctl:#06x}: вариант Multi-TID={multi} Compressed={comp} GCR={gcr} — не '
                        f'Compressed BlockAck (табл. 9-28; DMG — HT-immediate, 10.25.6.1)')
        rsv = ctl & 0x0FE1
        if rsv:
            msgs.append(f'BA Control {ctl:#06x}: резервные биты {rsv:#06x} ≠ 0 (рис. 9-42: B0 и B5–B11 Reserved; '
                        f'9.2.2 «Reserved fields and subfields … are set to 0 upon transmission»)')
        for m in msgs:
            r.bad(e, m)
        if not msgs:
            r.ok()
    r.info['tid'] = dict(tids)
    r.verdict_note = ('B0 = 1 — бывшее «BA Ack Policy» (802.11-2012/2016: 1 — No Acknowledgment); в 2020 и 2024 B0 '
                      'Reserved. Ставит MAC/прошивка узла — наше; трактовка однозначна (2020 = 2024).')
    return r


CONTROL_ONLY = ('RTS', 'DMG CTS', 'CF-End', 'DMG Beacon', 'SSW-Feedback', 'SSW-Ack', 'SSW', 'Grant', 'SPR', 'Poll',
                'DMG DTS')


def r_mcs_control(c):
    r = Rule('mcs_control', '10.6.7.1', 'DMG Control (MCS 0) для DMG Beacon, RTS, DMG CTS, CF-End, SSW, SSW-Feedback, '
             'SSW-Ack')
    for e in c.evs:
        if e.kind not in CONTROL_ONLY or e.agg:
            continue
        if e.mcs is None:
            r.skip('MCS неизвестен')
        elif e.mcs == 0:
            r.ok()
        else:
            r.bad(e, f'{e.kind} на MCS {e.mcs} (10.6.7.1: «shall be transmitted using the DMG Control modulation '
                     f'class»)')
    return r


def r_mcs_response(c):
    r = Rule('mcs_response', '10.6.7.2', 'MCS BlockAck/Ack: из обязательного набора (control MCS 0, SC MCS 1–4), у '
             'ответа — наибольшая скорость ≤ скорости вызвавшего с кратчайшим TXTIME')
    by = Counter()
    for e in c.evs:
        if e.kind not in ('BlockAck', 'Ack') or e.agg:
            continue
        if e.mcs is None:
            r.skip('MCS неизвестен')
            continue
        by[(e.src, e.mcs)] += 1
        if e.mcs not in (0, 1, 2, 3, 4):
            # 10.6.7.2, абзац 2: и не-ответ — «from the mandatory MCS set of the DMG SC … or DMG Control»;
            # ответ — «from the mandatory MCS set of the DMG SC modulation class» (20.5.3.1.2: MCS 1–4)
            p = c.prev.get(e.i) if e.t_ok else None
            ctxs = ''
            if p is not None and is_response_pair(p, e):
                ctxs = f'; ответ на {p.kind} MCS {p.mcs} через {float(e.t - p.te):.1f} мкс'
            r.bad(e, f'{e.kind} одиночным PPDU на MCS {e.mcs} — вне обязательного набора (MCS 0–4){ctxs}')
            continue
        p = c.prev.get(e.i) if e.t_ok else None
        if p is None or not is_response_pair(p, e) or e.t - p.te > RESP_WINDOW or p.mcs is None:
            r.ok()                       # обязательный набор соблюдён; правило «кратчайшего» — только у ответа
            r.skip('вызвавший кадр не виден (данные не записаны) — проверен только обязательный набор')
            continue
        try:
            allowed = D.response_mcs_set('ba' if e.kind == 'BlockAck' else 'ack', p.mcs, e.length)
        except (NotImplementedError, ValueError) as x:
            r.skip(str(x))
            continue
        if e.mcs in allowed:
            r.ok()
        else:
            r.bad(e, f'{e.kind} на MCS {e.mcs} в ответ на {p.kind} MCS {p.mcs}: допустимо {sorted(allowed)}')
    r.info['by_src_mcs'] = {f'{k[0]} MCS{k[1]}': v for k, v in sorted(by.items(), key=str)}
    r.verdict_note = ('BA на MCS 8 — одиночный BA, поставленный в очередь прошивкой (метка TX верна, не ответ MAC): '
                      'конечный PPDU инициатора RD (10.29.2 c) или BA вне ответа; в обоих случаях 10.6.7.2 требует '
                      'обязательный набор. Наше.')
    return r


def _pairs_by_adjacency(c, kind_resp, kind_elicit):
    """(вызвавший, ответ): ответ — следующее событие с известным временем после вызвавшего, по виду и адресам."""
    out = []
    k = c.k
    for j, e in enumerate(k):
        if e.kind != kind_resp or not j:
            continue
        p = k[j - 1]
        if p.kind in kind_elicit and is_response_pair(p, e):
            out.append((p, e))
    return out


def r_dur_cts(c):
    r = Rule('dur_cts', '9.3.1.13', 'Duration DMG CTS = Duration RTS − (TXTIME(DMG CTS) + SIFS), дробное — вверх')
    alt = Counter()
    for p, e in _pairs_by_adjacency(c, 'DMG CTS', ('RTS',)):
        if not (p.dur_ok and e.dur_ok):
            r.skip('Duration RTS или DMG CTS неизвестен (синтетическая запись без TX-записи)')
            continue
        m = D.check_duration('dmg_cts', e.dur, {'rts_duration': p.dur, 'elicit_mcs': 0})
        want = D.field(Fr(p.dur) - T.txtime_control(20) - SIFS)
        if m is None:
            r.ok()
        else:
            r.bad(e, f'DMG CTS Duration {e.dur} ≠ {want} = ⌈{p.dur} − {float(T.txtime_control(20)):.3f} − 3⌉ '
                     f'(разность {e.dur - want:+d} мкс; RTS {p.src})')
        if p.t_ok and e.t_ok:
            alt[e.dur - D.field(Fr(p.dur) - (e.te - p.te))] += 1
    r.info['vs_9.2.5.7_measured_gap'] = {f'{k:+d}': v for k, v in sorted(alt.items())}
    r.verdict_note = ('9.3.1.13 (DMG) — номинальный SIFS, округление вверх; 9.2.5.7 — измеренное время «end of '
                      'RTS PPDU '
                      '→ end of CTS PPDU»: info показывает разность с ним. Разность −1 при 9.3.1.13 — округление вниз '
                      '(или вычитание ⌈SIFS + TXTIME⌉ = 18) в MAC/uc — наше.')
    return r


def r_dur_resp(c):
    r = Rule('dur_resp', '9.2.5.7', 'Duration BlockAck/Ack-ответа = Duration вызвавшего − (SIFS + TXTIME ответа)')
    for e in c.evs:
        if e.kind not in ('BlockAck', 'Ack') or e.agg:
            continue
        p = c.prev.get(e.i) if e.t_ok else None
        if p is None or not is_response_pair(p, e):
            r.skip('вызвавший кадр не виден (данные не записаны) или время ответа неизвестно')
            continue
        if not (p.dur_ok and e.dur_ok):
            r.skip('Duration вызвавшего неизвестен (синтетический RX данных, тело и Duration не записаны)')
            continue
        m = D.check_duration('ba' if e.kind == 'BlockAck' else 'ack', e.dur,
                             {'elicit_duration': p.dur, 'mcs': e.mcs, 'length': e.length})
        exp = sorted({D.field(Fr(p.dur) - g - AP.ppdu_time(e.length, e.mcs)) for g in (SIFS, SIFS + SIFS_TOL)})
        meas = D.field(Fr(p.dur) - (e.te - p.te))
        if m is None:
            r.ok()
        else:
            r.bad(e, f'{e.kind} Duration {e.dur} ≠ {exp} (от {p.kind} Duration {p.dur}; по измеренному промежутку '
                     f'{float(e.t - p.te):.1f} мкс — {meas})')
    return r


def r_dur_cf_end(c):
    r = Rule('dur_cf_end', '9.3.1.6', 'Duration CF-End = (i − 1)·(TXTIME(CF-End) + SIFS), i — номер с конца '
             'последовательности усечения (DMG)')
    want2 = D.duration_cf_end(2)
    for e in c.evs:
        if e.kind != 'CF-End':
            continue
        if not e.dur_ok:
            r.skip('Duration неизвестен (синтетический RX без TX-записи)')
            continue
        p = c.prev.get(e.i) if e.t_ok else None
        resp = p is not None and is_response_pair(p, e) and e.t - p.te <= RESP_WINDOW
        if resp:
            if e.dur == D.duration_cf_end(1):
                r.ok()
            else:
                r.bad(e, f'ответный CF-End (i = 1): Duration {e.dur} ≠ 0')
        elif e.dur in (0, want2):
            r.ok()
        else:
            r.bad(e, f'CF-End держателя TXOP: Duration {e.dur} ∉ {{0, {want2}}} (i = 1 или 2)')
    return r


def r_dur_bf(c):
    r = Rule('dur_bf', '9.3.1.15', 'Duration SSW (DTI: CDOWN·(SBIFS + TXTIME(SSW)) + MBIFS), SSW-Feedback (9.3.1.16), '
             'SSW-Ack (9.3.1.17)')
    fb_of = {}
    for e in c.evs:
        if e.kind not in ('SSW', 'SSW-Feedback', 'SSW-Ack'):
            continue
        if not e.body_ok or e.p is None:
            r.skip('синтетический RX: CDOWN/поля не записаны')
            continue
        if e.kind == 'SSW':
            m = D.check_duration('ssw', e.dur, {'cdown': e.p.ssw.cdown})
        elif e.kind == 'SSW-Feedback':
            b = e.p.brp
            m = D.check_duration('ssw_fb', e.dur, {'in_abft': False,
                                                   'brp_requested': S.brp_requested({'L-RX': b.l_rx,
                                                                                     'TX-TRN-REQ': b.tx_trn_req,
                                                                                     'MID-REQ': b.mid_req,
                                                                                     'BC-REQ': b.bc_req})})
            fb_of[e.src] = e
        else:
            fb = fb_of.get(e.dst)
            if fb is None:
                r.skip('SSW-Ack без видимого SSW-Feedback')
                continue
            m = D.check_duration('ssw_ack', e.dur, {'fb_duration': fb.dur})
        if m is None:
            r.ok()
        else:
            r.bad(e, m)
    r.verdict_note = 'SSW в DTI: конец распределения (CBAP до TBTT) дальше конца свипа — берётся CDOWN-формула.'
    return r


def _txops(c):
    """TXOP по событиям с известным временем. Новый TXOP — кадр, который не ответ на предыдущий и начат не раньше
    DIFS после конца занятости (внутри TXOP промежутки — SIFS/MBIFS/SBIFS, 10.23.2.8, 10.42.2), или RTS / DMG
    CTS-to-self. Держатель — передатчик первого кадра. Возвращает [(держатель, [события])]."""
    out, cur = [], None
    for e in c.k:
        if e.kind == 'DMG Beacon':
            cur = None
            continue
        p = c.prev.get(e.i)
        resp = p is not None and is_response_pair(p, e) and e.t - p.te <= RESP_WINDOW
        gap = e.t - p.te if p is not None else None
        # ответные виды (BlockAck/Ack/DMG CTS к пиру) TXOP не начинают: их вызвавший PPDU мог быть невидим
        answer = e.kind in ('BlockAck', 'Ack') or (e.kind == 'DMG CTS' and e.dst != e.src) or \
            (e.agg and e.first == 'BlockAck')          # RD-ответ / A-MPDU с немедленным BlockAck впереди
        new = cur is None or (not resp and not answer and (e.kind == 'RTS' or (e.kind == 'DMG CTS' and e.dst == e.src)
                                                           or gap is None or gap >= T.DIFS - Q - CAL_UNCERT))
        if new:
            cur = (e.src, [e])
            out.append(cur)
        else:
            cur[1].append(e)
    return out


def r_nav_txop(c):
    r = Rule('nav_txop', '10.23.2.8', 'обмен TXOP укладывается в NAV, объявленный держателем (RTS и Duration кадров '
             'обмена); CF-End с Duration ≠ 0 — только при остатке ≥ 2×TCF-End + 2×SIFS (10.23.2.10)')
    ext = []
    t_cf = T.txtime_control(20)
    for holder, seq in _txops(c):
        rts = seq[0]
        if rts.kind != 'RTS':
            continue                      # SLS / CTS-to-self — свои правила (sls, dur_bf)
        if not (rts.t_ok and rts.dur_ok):
            r.skip('время или Duration RTS неизвестны')
            continue
        nav = rts.te + rts.dur
        nav0 = nav
        for e in seq[1:]:
            if e.kind == 'CF-End' and e.src == holder:
                if e.t_ok and e.dur_ok and e.dur != 0:
                    rem = nav - e.t
                    if rem < 2 * t_cf + 2 * SIFS - slack(e, e):
                        r.bad(e, f'CF-End Duration {e.dur} ≠ 0 при остатке NAV {float(rem):.1f} < 2×TCF-End + 2×SIFS '
                                 f'= {float(2 * t_cf + 2 * SIFS):.1f} (10.23.2.10)')
                    else:
                        r.ok()
                break
            if not e.t_ok:
                r.skip('кадр обмена без времени')
                continue
            if e.te > nav + slack(rts, e):
                r.bad(e, f'{e.kind} {e.src} кончается через {float(e.te - nav):.1f} мкс после NAV держателя '
                         f'(RTS {float(rts.t):.1f} + Duration)', 'ours')
            else:
                r.ok()
            if e.dur_ok:
                if e.src != holder:
                    ext.append(float(e.te + e.dur - nav0))
                nav = max(nav, e.te + e.dur)
    r.info['responder_nav_end_minus_rts_nav_end_us'] = stat(ext)
    r.verdict_note = ('NAV TXOP — максимум концов NAV из Duration видимых кадров (Duration данных держателя не '
                      'записан: '
                      'его вклад виден через Duration ответов, 9.2.5.7). Лимит TXOP неизвестен (EDCA Parameter Set '
                      'ассоциации не в захвате) — 10.23.2.9 не проверяется.')
    r.skip('лимит TXOP (10.23.2.9): EDCA Parameter Set не в захвате', 0)
    return r


def r_cf_end_rules(c):
    r = Rule('cf_end_rules', '10.23.2.10', 'CF-End: non-AP — только держатель TXOP или ответ на CF-End с RA = себе и '
             'Duration ≠ 0 (DMG); после своего CF-End держатель не начинает обмен в том же TXOP')
    for holder, seq in _txops(c):
        closed = False
        for e in seq[1:]:
            if e.kind == 'CF-End':
                p = c.prev.get(e.i)
                if p is not None and is_response_pair(p, e) and e.t - p.te <= RESP_WINDOW:
                    r.ok()
                elif p is not None and p.kind == 'CF-End' and p.dst == e.src and p.dur_ok and p.dur == 0:
                    r.bad(e, f'CF-End {e.src} в ответ на CF-End с Duration 0 (10.23.2.10: ответ — только при '
                             f'Duration ≠ 0)')
                elif e.src != holder and e.src != c.ap:
                    r.bad(e, f'CF-End от non-AP {e.src}, не держателя TXOP ({holder}) и не ответ')
                else:
                    r.ok()
                if e.src == holder:
                    closed = True
                continue
            if closed and e.src == holder:
                p = c.prev.get(e.i)
                if p is not None and e.t - p.te >= T.aifs(AIFSN_BE) - slack(p, e):
                    r.ok()                # новый доступ (AIFS и больше) — правило access
                else:
                    r.bad(e, f'{e.kind} держателя через {float(e.t - p.te) if p else 0:.1f} мкс после CF-End-обмена — '
                             f'без нового доступа (10.23.2.10: «shall not initiate any further frame exchange '
                             f'sequences '
                             f'within the current TXOP»)')
    return r


def r_cf_end_lost(c):
    r = Rule('cf_end_unanswered', '10.23.2.10', 'CF-End держателя с Duration ≠ 0 без ответного CF-End: что было до и '
             'после (наблюдение; нарушение — если ответчик передал иное вместо ответа)')
    ctxs = Counter()
    for j, e in enumerate(c.k):
        if e.kind != 'CF-End' or not e.dur_ok or e.dur == 0:
            continue
        n = c.k[j + 1] if j + 1 < len(c.k) else None
        if n is not None and is_response_pair(e, n) and n.t - e.te <= RESP_WINDOW:
            r.ok()
            continue
        p = c.prev.get(e.i)
        pk = (p.kind + (f'({p.first})' if p.agg else '') + f' MCS{p.mcs} {_who(c, p.src)}') if p else '-'
        ctxs[(f'держатель {_who(c, e.src)}', f'принят пиром: {bool(e.rx_nodes)}', f'до: {pk}',
              f'после: {n.kind if n else None} {_who(c, n.src) if n else ""}')] += 1
        if e.rx_nodes and n is not None and n.src == e.dst and n.t - e.te < RESP_WINDOW:
            r.bad(n, f'ответчик передал {n.kind} вместо ответного CF-End через {float(n.t - e.te):.1f} мкс')
        else:
            r.ok()
    unk = Counter(_who(c, e.src) for e in c.unk if e.kind == 'CF-End')
    r.info['unanswered_context'] = {' | '.join(k): v for k, v in ctxs.most_common(8)}
    r.info['cf_end_time_unknown(tx, not received)'] = dict(unk)
    return r


def r_ifs_sifs(c):
    r = Rule('ifs_sifs', '10.3.2.3.3', 'SIFS ответов на эфире: [aSIFSTime, aSIFSTime + 10 %·(aSlotTime − '
             'aAirPropagationTime)] = [3, 3.49] мкс (10.3.7), с допуском метки ±1 мкс и калибровки')
    gaps = defaultdict(list)
    for e in c.k:
        p = c.prev.get(e.i)
        if p is None or not is_response_pair(p, e):
            continue
        g = e.t - p.te
        if g > RESP_WINDOW:
            continue                    # не ответ через SIFS (другое правило)
        key = f'{p.kind}→{e.kind}{"(" + (e.first or "?") + ")" if e.agg else ""} отвечает {_who(c, e.src)}'
        gaps[key].append(g)
        s = slack(p, e)
        if g < SIFS - s:
            r.bad(e, f'{key}: промежуток {float(g):.2f} мкс < SIFS')
        elif g > SIFS + SIFS_TOL + s:
            r.bad(e, f'{key}: промежуток {float(g):.2f} мкс > SIFS + допуск {float(SIFS + SIFS_TOL):.2f} '
                     f'(с допуском записи {float(SIFS + SIFS_TOL + s):.2f})')
        else:
            r.ok()
    r.info['gaps_us'] = {k: stat(v) for k, v in sorted(gaps.items())}
    r.info['calibration_free_sum'] = sifs_sum(c)
    r.verdict_note = ('Разбивка «кто опаздывает» (AP/STA) зависит от калибровки (сдвиг TSF второго узла при равных '
                      'задержках записи RX у обоих узлов); сумма SIFS_AP + SIFS_STA (calibration_free_sum) от неё не '
                      'зависит: (STA tx запрос → STA rx ответ AP) + (STA rx запрос AP → STA tx ответ) − 2·TXTIME = '
                      'SIFS_AP + SIFS_STA. Норма суммы ≤ 2·3.49 = 6.98 мкс.')
    return r


def _who(c, mac):
    for n, m in c.air.nodes.items():
        if m == mac:
            return n
    return mac


def sifs_sum(c):
    """Оценка SIFS_A + SIFS_B без калибровки (метки одного узла): для пары видов (запрос→ответ) на узле N:
    X1 = rx_N(ответ) − tx_N(запрос) − TXTIME(запрос), X2 = tx_N(ответ) − rx_N(запрос) − TXTIME(запрос);
    X1 + X2 = SIFS_пира + SIFS_N (смещения точек меток сокращаются, если запросы одного класса модуляции)."""
    out = {}
    nodes = list(c.air.recs)
    if len(nodes) < 2:
        return 'один узел'
    acc = defaultdict(lambda: defaultdict(list))
    for e in c.k:
        p = c.prev.get(e.i)
        if p is None or not is_response_pair(p, e) or e.t - p.te > RESP_WINDOW:
            continue
        for n in nodes:
            pr = next((c.recs[a][b] for a, b in p.recs if a == n), None)
            er = next((c.recs[a][b] for a, b in e.recs if a == n), None)
            if pr is None or er is None or pr.tsft is None or er.tsft is None:
                continue
            if pr.tx and not er.tx:
                side = 'X1'
            elif er.tx and not pr.tx:
                side = 'X2'
            else:
                continue
            if mode(p) != mode(e):
                continue
            key = (n, f'{p.kind}→{e.kind}')
            acc[key][side].append(Fr(er.tsft - pr.tsft) - AP.ppdu_time(p.length, p.mcs))
    for (n, k), d in sorted(acc.items()):
        if d['X1'] and d['X2']:
            x1, x2 = sum(d['X1']) / len(d['X1']), sum(d['X2']) / len(d['X2'])
            out[f'{n}: {k}'] = dict(n1=len(d['X1']), n2=len(d['X2']), X1=round(float(x1), 3), X2=round(float(x2), 3),
                                    sifs_sum=round(float(x1 + x2), 3),
                                    over_limit=round(float(x1 + x2 - 2 * (SIFS + SIFS_TOL)), 3))
    return out


def r_access(c):
    r = Rule('access', '10.23.2.4', 'новый доступ (RTS после завершённого TXOP): не раньше AIFS от конца занятости (и '
             'конца интервала Duration CF-End, 10.23.2.10 DMG; кадр не принят — EIFS, 10.3.2.3.7), начало — на границе '
             'слота AIFS + k·aSlotTime')
    from .cbap import EIFS
    aifsn = c.edca['AC_BE']['aifsn'] if c.edca and 'AC_BE' in c.edca else AIFSN_BE
    a = T.aifs(aifsn)
    r.info['aifsn'] = f'{aifsn} ({"EDCA Parameter Set: " + c.edca_src if c.edca else "по умолчанию, табл. 9-155"})'
    groups = defaultdict(list)
    resid = defaultdict(Counter)
    slack_s = Q + CAL_UNCERT
    for e in c.k:
        if e.kind != 'RTS':
            continue
        p = c.prev.get(e.i)
        if p is None:
            continue
        if p.kind != 'CF-End':
            r.skip('предыдущий видимый кадр — не CF-End: между ними могли быть невидимые PPDU')
            continue
        if p.te > e.t:
            r.bad(e, f'RTS начат во время {p.kind} {_who(c, p.src)} (среда занята, 10.3.2.1)')
            continue
        own = e.src == p.src
        heard = own or _who(c, e.src) in p.rx_nodes
        pp = c.prev.get(p.i)
        refs = [p.te]
        for q in (pp, p):
            if q is not None and q.kind == 'CF-End' and q.dur_ok and q.dur and q.te + q.dur > p.te:
                refs.append(q.te + q.dur)            # NAV-интервал Duration CF-End (10.23.2.10, DMG)
        ctx = ('конец TXOP: ответный CF-End' if pp is not None and is_response_pair(pp, p) else
               'конец TXOP: CF-End без ответа')
        ctx += ', последний кадр — свой' if own else ', последний кадр — пира'
        if not heard:
            refs.append(p.te + EIFS - T.DIFS)
            ctx += ' (не принят: EIFS)'
        ctx += f', начинает {_who(c, e.src)}'
        idle = e.t - p.te
        groups[ctx].append(idle)
        s = slack(p, e) + T.SIFS_TOL          # квант меток + допуск выравнивания модели (cbap.LogParams.slot_tol)
        slack_s = s
        if all(e.t - x < a - s for x in refs):
            r.bad(e, f'RTS через {float(idle):.2f} мкс свободной среды < AIFS {float(a)} ({ctx})')
            continue
        best = None
        for x in refs:
            d = e.t - x - a
            if d < -s:
                continue
            m = d % SLOT
            m = min(m, SLOT - m)
            best = m if best is None else min(best, m)
        resid[ctx][round(float(best), 1)] += 1
        if best <= s:
            r.ok()
        else:
            r.bad(e, f'RTS: {float(best):.2f} мкс от ближайшей границы слота AIFS + k·aSlotTime ({ctx})', 'model')
    r.info['idle_after_last_frame_us'] = {k: stat(v) for k, v in groups.items()}
    r.info['slot_offset_us_by_context'] = {k: dict(v.most_common(6)) for k, v in resid.items()}
    own = [x for k, v in groups.items() if 'свой' in k and 'EIFS' not in k for x in v]
    if own:
        lo = sorted(own)[len(own) // 200]
        r.info['effective_aifs_us(0.5% квантиль, свой последний кадр)'] = round(float(lo), 2)
        r.info['aifsn_if_sifs_nominal'] = round(float((lo - SIFS) / SLOT), 2)
        # 10.23.2.4 + 10.23.2.2: после AIFS[AC] — backoff, равномерный в [0, CW], CW = CWmin после успешного TXOP. Если
        # ни один из n доступов не начат в первые k слотов, а вероятность этого при равномерном backoff ничтожна, —
        # фактический AIFS больше объявленного
        allv = [x for v in groups.values() for x in v]
        kmin = int((min(allv) - a + slack_s) // SLOT) if allv else 0
        cw = (2 ** c.edca['AC_BE']['ecwmin'] - 1) if c.edca and 'AC_BE' in c.edca else T.aCWmin
        if kmin >= 1:
            pr = (Fr(cw + 1 - min(kmin, cw + 1), cw + 1)) ** len(allv)
            r.info['min_backoff_slots_seen'] = kmin
            if pr < Fr(1, 10 ** 6):
                m = min(allv)
                r.bad(None, f'ни один из {len(allv)} доступов не начат раньше AIFS + {kmin}·aSlotTime (минимум idle '
                            f'{float(m):.1f} мкс при AIFS[AC_BE] = {float(a)}, CWmin {cw}): при backoff в [0, CW] '
                            f'вероятность < 1e-6 — фактический AIFS ≈ {float(m):.1f} мкс, AIFSN ≈ '
                            f'{float((m - SIFS) / SLOT):.1f} вместо {aifsn} (10.23.2.4, 10.3.7)')
    r.verdict_note = ('AIFSN — из EDCA Parameter Set (Association Response, в этом захвате или --edca-from), без него '
                      '— 3 '
                      '(табл. 9-155, AC_BE); фактический AIFS — в info (решётка idle ≈ AIFS + '
                      'k·5). Граница слота: стандарт не задаёт допуск; модель — SIFS_TOL; здесь + квант меток. '
                      'Нарушения '
                      'выравнивания — model (зависят от допуска).')
    return r


def r_responder(c):
    r = Rule('responder_tx', '10.23.2.8', 'в TXOP держателя ответчик передаёт только немедленные ответы (DMG CTS, '
             'BlockAck/Ack, ответный CF-End) и RD-ответ (A-MPDU с BlockAck впереди, 10.29.2)')
    for holder, seq in _txops(c):
        for e in seq[1:]:
            if e.src == holder:
                continue
            if e.kind in ('SSW', 'SSW-Feedback', 'SSW-Ack'):
                continue                  # SLS — правило sls
            p = c.prev.get(e.i)
            if p is None:
                continue
            if p.src == holder and is_response_pair(p, e) and e.t - p.te <= RESP_WINDOW:
                r.ok()
                continue
            if c.hidden_possible(p, e):
                r.skip('промежуток вмещает невидимый PPDU держателя (данные не записаны)')
                continue
            r.bad(e, f'{e.kind} ответчика через {float(e.t - p.te):.1f} мкс после {p.kind} {_who(c, p.src)} — не '
                     f'ответ, места для невидимого кадра держателя нет')
    return r


def r_resp_seq(c):
    r = Rule('resp_seq', '10.3.2.9', 'последовательности: RTS → DMG CTS от RA; DMG CTS — только ответ на RTS к нему '
             '(или CTS-to-self); BlockAck — после вызвавшего PPDU (видимого или невидимого)')
    no_cts = Counter()
    for e in c.k:
        if e.kind == 'RTS':
            n = c.nxt.get(e.i)
            if n is not None and n.kind == 'DMG CTS' and is_response_pair(e, n):
                r.ok()
            else:
                no_cts[(bool(e.rx_nodes), n.kind if n else None, 'peer' if n is not None and n.src == e.dst
                        else 'self')] += 1
                r.ok()          # отсутствие ответа — потеря, не нарушение
        elif e.kind == 'DMG CTS' and e.dst != e.src:
            p = c.prev.get(e.i)
            if p is not None and p.kind == 'RTS' and is_response_pair(p, e):
                r.ok()
            elif p is not None and c.hidden_possible(p, e):
                r.skip('DMG CTS без видимого RTS — RTS мог не записаться')
            else:
                r.bad(e, f'DMG CTS к {e.dst} без RTS от него (предыдущий — {p.kind if p else None})')
        elif e.kind == 'BlockAck' and not e.agg:
            p = c.prev.get(e.i)
            if p is None:
                continue
            if is_response_pair(p, e):
                r.ok()
            elif c.hidden_possible(p, e):
                r.skip('вызвавший PPDU невидим (данные не записаны)')
            else:
                r.bad(e, f'BlockAck {e.src} через {float(e.t - p.te):.1f} мкс после {p.kind} {p.src} — вызвавшего '
                         f'PPDU нет и места для невидимого нет')
    r.info['rts_without_cts(heard, next_kind, next_src)'] = {str(k): v for k, v in no_cts.most_common()}
    return r


def r_ack_policy(c):
    r = Rule('ack_policy', '9.2.4.5.4', 'Ack Policy данных (табл. 9-13): Normal Ack — Ack через SIFS; Implicit BAR '
             '(A-MPDU) — BlockAck через SIFS (или RD-ответ с BlockAck впереди); No Ack / Block Ack — без ответа; '
             'No Ack '
             'не используется для QoS Data с TID под соглашением BA; поля QoS Control (табл. 9-11)')
    stats = Counter()
    ba_tids = {(e.dst, e.src, int.from_bytes(e.raw[16:18], 'little') >> 12) for e in c.evs
               if e.kind == 'BlockAck' and e.raw is not None and not e.synth and len(e.raw) >= 18}
    for e in c.evs:
        if e.kind not in ('A-MPDU', 'Data', 'QoS Null'):
            continue
        q = data_hdr(e)
        if q is None:
            r.skip('заголовок данных не записан (синтетический RX или TX без txqos)')
            continue
        # поля QoS Control (табл. 9-11): B14 Reserved; у QoS Null B7, B8 Reserved
        if q['rsv14'] or (q['null'] and (q['amsdu'] or q['amsdu_type'])):
            r.bad(e, f'QoS Control {q["qos"]:#06x}: резервные биты ≠ 0 (табл. 9-11)')
        if q['ackpol'] == 1 and not q['null'] and (e.src, e.dst, q['tid']) in ba_tids:
            r.bad(e, f'QoS Data TID {q["tid"]} с No Ack при соглашении BA (табл. 9-13: «not used for QoS Data frames '
                     f'with a TID for which a block ack agreement exists»)')
        if not e.t_ok:
            r.skip('время PPDU неизвестно — ответ не сопоставить')
            continue
        n = c.nxt.get(e.i)
        got = n is not None and n.src in (e.dst, None) and n.dst in (e.src, None) and n.t - e.te <= RESP_WINDOW
        kind = (n.kind + (f'({n.first})' if n.agg else '')) if got else 'нет ответа'
        stats[(e.kind, ACK_POLICY[q['ackpol']], 'RDG' if q['rdg'] else '-', kind)] += 1
        heard = bool(e.rx_nodes) or e.tx_node is None
        if q['ackpol'] == 0:
            want = ('BlockAck',) if e.agg else ('Ack', 'BlockAck')
            ok = got and (n.kind in want or (n.kind == 'A-MPDU' and n.first == 'BlockAck'))
            if ok:
                r.ok()
            elif not heard:
                r.skip('адресат PPDU не записал — ответа могло не быть (потеря)')
            elif got:
                r.bad(n, f'на {e.kind} с {ACK_POLICY[0]} ответ {kind}, нужен {"/".join(want)}')
            else:
                r.skip('ответа нет (адресат принял PPDU, но мог отбросить по FCS)')
        elif q['ackpol'] in (1, 3):
            if got and n.kind in ('Ack', 'BlockAck'):
                r.bad(n, f'{kind} на {e.kind} с Ack Policy {ACK_POLICY[q["ackpol"]]} (табл. 9-13: без немедленного '
                         f'ответа)')
            else:
                r.ok()
        else:
            r.bad(e, f'{e.kind}: Ack Policy {ACK_POLICY[2]} вне PSMP')
    r.info['data(kind, ack_policy, rdg, response)'] = {' | '.join(k): v for k, v in stats.most_common(12)}
    return r


def r_bi(c):
    r = Rule('bi', '10.39.2', 'структура BI по модели ref/bi (TBTT = k·BI, периоды bi.layout): цепочка маяков BTI '
             '(CDOWN −1, сектор один раз, SBIFS, Duration = остаток BTI), кто передаёт в BTI/A-BFT, покрытие секторов')
    beacons = [e for e in c.k if e.kind == 'DMG Beacon' and e.src == c.ap and e.p is not None and e.tx_node]
    if not beacons:
        r.skip('нет DMG Beacon AP с телом и временем')
        return r
    bi_tu = beacons[0].p.beacon_interval
    by = defaultdict(list)
    for b in beacons:
        by[BI.bi_index(b.t, bi_tu)].append(b)
    ks = sorted(by)
    allsec = {b.p.ssw.sector_id for b in beacons}
    mean_gaps, sec_n, miss = [], [], Counter()
    rules = Counter()
    frames_by_bi = defaultdict(list)
    for e in c.k:
        if e.kind != 'DMG Beacon':
            frames_by_bi[BI.bi_index(e.t, bi_tu)].append(e)

    def bad(e, rule, msg, verdict='ours'):
        rules[rule] += 1
        r.bad(e, f'{rule}: {msg}', verdict)
    for k in ks:
        bs = by[k]
        full = bs[0].p.ssw.cdown == len(bs) - 1 + bs[-1].p.ssw.cdown and bs[-1].p.ssw.cdown == 0
        edge = k in (ks[0], ks[-1])
        if edge and not full:
            r.skip('BTI на краю захвата записан не целиком (CDOWN первого маяка ≠ число маяков − 1)')
            continue
        # CDOWN и сектор (10.42.4, 11.1.3.3.1)
        for a, b in zip(bs, bs[1:]):
            if b.p.ssw.cdown != a.p.ssw.cdown - 1:
                bad(b, 'beacon_cdown', f'CDOWN {a.p.ssw.cdown} → {b.p.ssw.cdown} (10.42.4)')
            else:
                r.ok()
        secs = [b.p.ssw.sector_id for b in bs]
        for s_ in set(secs):
            if secs.count(s_) > 1:
                bad(bs[secs.index(s_)], 'beacon_sector_dup', f'сектор {s_} {secs.count(s_)} раза в BTI (11.1.3.3.1)')
        sec_n.append(len(set(secs)))
        for x in allsec - set(secs):
            miss[x] += 1
        # SBIFS (10.3.2.3.8): TX→TX одного узла, кванты меток ±1 мкс на промежуток, среднее по BTI — точнее
        n = len(bs)
        if n > 1:
            gaps = [b.t - a.te for a, b in zip(bs, bs[1:])]
            mg = sum(gaps) / len(gaps)
            mean_gaps.append(mg)
            tol_m = 2 * Q / len(gaps)
            for a, b, g in zip(bs, bs[1:], gaps):
                if not T.SBIFS - Q <= g <= T.SBIFS_MAX + Q:
                    bad(b, 'beacon_gap', f'промежуток {float(g):.2f} мкс ≠ SBIFS (±1 мкс квант метки) (10.3.2.3.8, '
                                         f'10.42.2.2.2)')
            if not T.SBIFS - tol_m <= mg <= T.SBIFS_MAX + tol_m:
                bad(bs[0], 'beacon_gap_mean', f'средний промежуток BTI {float(mg):.3f} мкс вне [SBIFS, SBIFS + '
                                              f'aSBIFSAccuracy] ± {float(tol_m):.3f}')
            else:
                r.ok()
        # Duration (9.3.4.2, 11.1.3.3.1; PLAN №5): остаток BTI по номиналу SBIFS и TXTIME следующих маяков
        last = bs[-1]
        for j, b in enumerate(bs):
            rem = sum((T.SBIFS + AP.ppdu_time(q.length, 0) for q in bs[j + 1:]), Fr(0)) + (last.dur or 0) * (j < n - 1)
            want = D.duration_dmg_beacon(rem)
            if b.dur == want:
                r.ok()
            else:
                bad(b, 'beacon_dur', f'Duration {b.dur} ≠ {want} = ⌈{float(rem):.2f}⌉ (остаток BTI по SBIFS)')
        # периоды по модели и передачи в BTI / A-BFT
        p0 = bs[0].p
        cfg = BI.BiConfig(bic=_bic(p0.bic), params=BI.DmgParameters(
            p0.params.bss_type, p0.params.cbap_only, p0.params.cbap_source, p0.params.privacy, p0.params.ecapc))
        bti_end = last.te + (last.dur or 0)
        per = BI.layout(k, bi_tu, cfg, bti_end)
        for e in frames_by_bi[k]:
            pk = BI.period_at(per, e.t)
            if pk is None:
                continue
            if pk.kind == 'BTI' and e.t >= bs[0].t:
                bad(e, 'bti_sta' if e.src != c.ap else 'bti_kind', f'{e.kind} {_who(c, e.src)} в BTI (10.39.2)')
            elif pk.kind == 'A-BFT':
                if (e.kind == 'SSW' and e.src != c.ap) or (e.kind == 'SSW-Feedback' and e.src == c.ap):
                    r.ok()
                else:
                    bad(e, 'abft_kind', f'{e.kind} {_who(c, e.src)} в A-BFT [{float(pk.start):.0f}, '
                           '{float(pk.end):.0f})'
                                        f' (10.42.5.2: только SSW ответчиков и SSW-Feedback точки)')
    r.info['beacon_interval_tu'] = bi_tu
    r.info['mean_sbifs_per_bti_us'] = stat(mean_gaps)
    r.info['sectors_per_bti'] = stat(sec_n)
    r.info['sector_missing_count'] = dict(miss)
    r.info['rules'] = dict(rules)
    r.verdict_note = ('Маяки — TX→TX одного узла (AP): SBIFS и Duration от калибровки не зависят; промежуток '
                      'каждой пары '
                      '— с квантом ±1 мкс, среднее по BTI — с ±2/(n−1).')
    return r


def r_holder_gap(c):
    r = Rule('holder_gap', '10.23.2.8', 'продолжение TXOP держателем: следующий кадр — через SIFS после конца '
             'предыдущего обмена (после сбоя — PIFS); не раньше SIFS')
    gaps = defaultdict(list)
    for holder, seq in _txops(c):
        for a, b in zip(seq, seq[1:]):
            if b.src != holder or b.kind == 'RTS' or b.kind in BF_KINDS or a.kind in BF_KINDS:
                continue                  # SLS/BRP — правила sls, brp
            p = c.prev.get(b.i)
            if p is None or p is not a and p.t > a.t:
                continue
            if a.src == holder and a.kind in ('RTS',):
                continue                  # после RTS — ответ ответчика (resp_seq)
            if a.src == holder and _elicits(a):
                if c.hidden_possible(a, b):
                    r.skip('после кадра держателя с ожидаемым ответом — промежуток вмещает невидимый ответ')
                    continue
            g = b.t - a.te
            if g > 1000:
                continue
            ak = f'{a.kind}({a.first or "?"})' if a.agg else a.kind
            key = f'{ak} {_who(c, a.src)} → {b.kind} {_who(c, holder)}'
            gaps[key].append(g)
            s = slack(a, b)
            if g < SIFS - s:
                r.bad(b, f'{key}: {float(g):.2f} мкс < SIFS')
            elif g <= SIFS + SIFS_TOL + s:
                r.ok()
            elif c.hidden_possible(a, b):
                r.skip('промежуток вмещает невидимый PPDU (данные держателя не записаны)')
            elif g >= T.PIFS - s:
                r.bad(b, f'{key}: {float(g):.2f} мкс — не SIFS (продолжение TXOP), ≥ PIFS допустим только после сбоя '
                         f'передачи (10.23.2.8); предыдущий обмен успешен', 'model' if b.kind == 'CF-End' else 'ours')
            else:
                r.bad(b, f'{key}: {float(g):.2f} мкс — между SIFS + допуск и PIFS')
    r.info['gaps_us'] = {k: stat(v) for k, v in sorted(gaps.items(), key=lambda x: -len(x[1]))[:10]}
    r.verdict_note = ('Промежуток «свой BA (MCS 8, RD) → CF-End» ≈ 10.6 мкс: ни SIFS, ни PIFS-восстановление '
                      '(сбоя нет). '
                      'Вердикт model: 10.23.2.10 не задаёт промежуток перед CF-End явно, правило SIFS — из 10.23.2.8 '
                      '(«may commence transmission … a SIFS after the completion of the immediately preceding frame '
                      'exchange sequence»).')
    return r


BF_KINDS = ('SSW', 'SSW-Feedback', 'SSW-Ack', 'BRP')


def _elicits(e):
    return e.kind in ('A-MPDU', 'Data', 'BlockAckReq', 'RTS') or (e.kind == 'CF-End' and e.dur_ok and e.dur)


def r_cbap_end(c):
    r = Rule('cbap_end', '10.39.5', 'обмен, начатый в CBAP, кончается до конца CBAP (CBAP Only: DTI до следующего '
             'TBTT): кадры и NAV RTS не пересекают TBTT')
    bi_tu = _bi_tu(c)
    if bi_tu is None:
        r.skip('BI неизвестен (нет DMG Beacon с телом)')
        return r
    over = []
    for e in c.k:
        if e.kind == 'DMG Beacon':
            continue
        k = BI.bi_index(e.t, bi_tu)
        tb = BI.tbtt(k + 1, bi_tu)
        if e.te > tb:
            r.bad(e, f'{e.kind} {_who(c, e.src)} кончается через {float(e.te - tb):.1f} мкс после TBTT {float(tb):.0f}')
            continue
        if e.kind == 'RTS' and e.dur_ok and e.te + e.dur > tb:
            over.append(e.te + e.dur - tb)
            r.bad(e, f'RTS {_who(c, e.src)}: NAV (Duration {e.dur}) кончается через {float(e.te + e.dur - tb):.1f} мкс '
                     f'после TBTT — обмен запланирован за конец CBAP («shall check that the frame exchange sequence … '
                     f'completes before the end of the CBAP»)')
            continue
        r.ok()
    r.info['rts_nav_over_tbtt_us'] = stat(over)
    return r


def _bi_tu(c):
    b = next((e for e in c.evs if e.kind == 'DMG Beacon' and e.p is not None), None)
    return b.p.beacon_interval if b is not None else None
def r_bti_delay(c):
    r = Rule('bti_delay', '11.1.3.3.1', 'BTI начинается в TBTT; задержка маяка допустима, только если среда занята '
             '(CCA) — «may delay the DMG Beacon frame transmission if the medium is determined … to be busy»')
    bi_tu = _bi_tu(c)
    if bi_tu is None:
        r.skip('нет DMG Beacon с телом')
        return r
    firsts = {}
    for e in c.k:
        if e.kind == 'DMG Beacon' and e.src == c.ap and e.p is not None and e.tx_node:
            k = BI.bi_index(e.t, bi_tu)
            if k not in firsts:
                firsts[k] = e
    ks = sorted(firsts)
    idle_d, busy_d, after_busy = [], [], []
    period = []
    for k in ks:
        b = firsts[k]
        tb = BI.tbtt(k, bi_tu)
        d = b.t - tb
        if k - 1 in firsts:
            period.append(b.t - firsts[k - 1].t)
        if k == ks[0] and d > 4 * AP.ppdu_time(b.length, 0):
            r.skip('первый BTI захвата (запись началась внутри BTI)')
            continue
        pr = c.prev.get(b.i)
        busy_until = None
        if pr is not None and pr.te > tb - SIFS:
            busy_until = pr.te
        # NAV RTS, пересекающий TBTT, — тоже занятость для AP (виртуальный CS) — учитываем как busy
        for q in c.k[max(0, c.pos[b.i] - 12):c.pos[b.i]]:
            if q.kind == 'RTS' and q.dur_ok and q.te + q.dur > tb:
                busy_until = max(busy_until or tb, min(q.te + q.dur, b.t))
        if busy_until is not None:
            busy_d.append(d)
            after_busy.append(b.t - busy_until)
            r.ok()
            continue
        idle_d.append(d)
        if d > 2 * Q + PRE_UNCERT:
            r.bad(b, f'BTI BI {k} начат через {float(d):.2f} мкс после TBTT при свободной среде (предыдущий кадр '
                     f'кончился за {float(tb - pr.te) if pr else "-"} мкс до TBTT)')
        else:
            r.ok()
    r.info['delay_idle_medium_us'] = stat(idle_d)
    r.info['delay_busy_medium_us'] = stat(busy_d)
    r.info['beacon_start_after_busy_end_us'] = stat(after_busy)
    r.info['bti_start_period_us'] = stat(period)
    r.verdict_note = ('Время маяка — метка TX AP минус air_pcap.PRE (control, 5.0 мкс). Timestamp каждого маяка '
                      '== метке '
                      'TX, поэтому: либо метка — верная точка 11.1.3.1, и BTI начинается позже TBTT на величину '
                      'из info '
                      '(нарушение 11.1.3.3.1), либо Timestamp не равен TSF начала символа данных (нарушение 11.1.3.1). '
                      'Оба варианта — наше; какое именно — нужна внешняя опора времени (сниффер LHG).')
    return r


# ---------------------------------------------------------------------------------------------------------------------
# данные: QoS Control (табл. 9-11), EDCA Parameter Set (9.4.2.28)
# ---------------------------------------------------------------------------------------------------------------------
def qos_of(raw):
    """Заголовок QoS Data / QoS Null → dict полей табл. 9-11 (DMG) или None."""
    if raw is None or len(raw) < 26:
        return None
    fc = F.parse_fc(raw[:2])
    if fc.type != F.TYPE_DATA or not fc.subtype & 8:
        return None
    off = 30 if (fc.to_ds and fc.from_ds) else 24
    if len(raw) < off + 2:
        return None
    q = int.from_bytes(raw[off:off + 2], 'little')
    return dict(subtype=fc.subtype, dur=int.from_bytes(raw[2:4], 'little'),
                sn=int.from_bytes(raw[22:24], 'little') >> 4, fn=raw[22] & 15, tid=q & 15, eosp=q >> 4 & 1,
                ackpol=q >> 5 & 3, amsdu=q >> 7 & 1, amsdu_type=q >> 8 & 1,
                rdg=q >> 9 & 1, buffered_ac=q >> 10 & 15, rsv14=q >> 14 & 1, acc=q >> 15 & 1, qos=q,
                null=fc.subtype == 12, retry=fc.retry)


def data_hdr(e):
    """Первый записанный байтами MPDU данных PPDU (QoS Control) или None."""
    for m in e.mpdus or ():
        q = qos_of(m)
        if q is not None:
            return q
    return None


ACK_POLICY = {0: 'Normal Ack/Implicit BAR', 1: 'No Ack', 2: 'No Explicit/PSMP Ack', 3: 'Block Ack'}
EDCA_ACI = {0: 'AC_BE', 1: 'AC_BK', 2: 'AC_VI', 3: 'AC_VO'}


def edca_from(evs, ap):
    """EDCA Parameter Set (9.4.2.28, рис. 9-262/9-263) из Association/Reassociation Response точки (иначе Probe
    Response): {AC: dict(aifsn, acm, ecwmin, ecwmax, txop_us)}, источник. TXOP Limit — в единицах 32 мкс."""
    best = None
    for e in evs:
        if e.src != ap or not e.body_ok or e.kind not in (E.ASSOC_RESP, E.REASSOC_RESP, E.PROBE_RESP):
            continue
        try:
            _, els = E.parse_body(e.kind, e.raw[24:])
        except (ValueError, NotImplementedError):
            continue
        for el in els:
            if el.eid == 12 and len(el.info) >= 18:
                acs = {}
                for k in range(4):
                    r = el.info[2 + 4 * k:6 + 4 * k]
                    acs[EDCA_ACI[r[0] >> 5 & 3]] = dict(aifsn=r[0] & 15, acm=r[0] >> 4 & 1, ecwmin=r[1] & 15,
                                                        ecwmax=r[1] >> 4, txop_us=int.from_bytes(r[2:4], 'little') * 32)
                cand = (e.kind != E.PROBE_RESP, e.i, acs, f'{e.kind} #{e.i}')
                if best is None or cand[:2] > best[:2]:
                    best = cand
    return (best[2], best[3]) if best else (None, None)


def r_edca(c):
    r = Rule('edca', '9.4.2.28', 'EDCA Parameter Set точки (Association/Probe Response): AIFSN ≥ 2 для non-AP '
             '(10.23.2.4), ECWmin ≤ ECWmax, четыре разных ACI; значения — в правила access и txop_limit')
    if c.edca is None:
        r.skip('нет Association/Probe Response точки с телом в захвате (и не задан --edca-from)')
        return r
    r.info['source'] = c.edca_src
    r.info['params'] = c.edca
    for ac, p in c.edca.items():
        ok = True
        if p['aifsn'] < 2:
            r.bad(None, f'{ac}: AIFSN {p["aifsn"]} < 2 (10.23.2.4: «AIFSN[AC] … greater than or equal to 2 for non-AP '
                        f'STAs»)')
            ok = False
        if p['ecwmin'] > p['ecwmax']:
            r.bad(None, f'{ac}: ECWmin {p["ecwmin"]} > ECWmax {p["ecwmax"]} (9.4.2.28)')
            ok = False
        if ok:
            r.ok()
    if len(c.edca) != 4:
        r.bad(None, f'ACI в EDCA Parameter Set: {sorted(c.edca)} — не четыре разных AC (9.4.2.28)')
    return r


def r_txop_limit(c):
    r = Rule('txop_limit', '10.23.2.9', 'лимит TXOP AC_BE (EDCA Parameter Set): Duration RTS ≤ лимит − TXTIME(RTS) '
             '(9.2.5.2 b), обмен держателя и NAV кадров TXOP — в пределах лимита от начала TXOP')
    if c.edca is None or 'AC_BE' not in c.edca:
        r.skip('лимит TXOP неизвестен: нет EDCA Parameter Set (--edca-from pcap с ассоциацией)')
        return r
    lim = Fr(c.edca['AC_BE']['txop_us'])
    r.info['txop_limit_us'] = int(lim)
    if lim == 0:
        r.skip('лимит 0 — «одна MSDU/MMPDU и защита» (10.23.2.9): не моделируется по захвату')
        return r
    over = []
    for holder, seq in _txops(c):
        t0 = seq[0].t
        if seq[0].kind == 'RTS' and seq[0].dur_ok:
            if seq[0].dur > lim - T.txtime_control(20):
                r.bad(seq[0], f'RTS Duration {seq[0].dur} > лимит {int(lim)} − TXTIME(RTS)')
            else:
                r.ok()
        for e in seq[1:]:
            if e.kind == 'CF-End':
                break
            end = e.te + (e.dur if e.dur_ok and e.src == holder else 0)
            if end > t0 + lim + slack(seq[0], e):
                over.append(end - t0 - lim)
                r.bad(e, f'{e.kind} {_who(c, e.src)}: {"NAV" if e.dur_ok and e.src == holder else "конец"} через '
                         f'{float(end - t0):.1f} мкс от начала TXOP > лимит {int(lim)}')
            else:
                r.ok()
    r.info['over_us'] = stat(over)
    return r


def r_rd(c):
    r = Rule('rd', '10.29.3', 'reverse direction: RDG ставит только держатель TXOP, с AC Constraint = 1 в TXOP EDCA '
             '(10.29.3); RD-ответ — только после PPDU с RDG = 1, через SIFS, в пределах Duration RDG-PPDU (10.29.4); '
             'More PPDU = 1 — за ним ещё PPDU ответчика')
    stats = Counter()
    for holder, seq in _txops(c):
        rdg_frame = None
        for k, e in enumerate(seq):
            q = data_hdr(e)
            if e.src == holder:
                if q is not None and q['rdg']:
                    rdg_frame = e
                    stats['RDG у держателя'] += 1
                    if not q['acc']:
                        r.bad(e, f'{e.kind} держателя с RDG = 1 и AC Constraint = 0 в TXOP EDCA (10.29.3: «shall set '
                                 f'the '
                                 f'AC Constraint subfield to 1 … if the TXOP was gained through the EDCA»)')
                    else:
                        r.ok()
                elif q is not None:
                    rdg_frame = None
                continue
            # ответчик
            rd_resp = e.kind == 'A-MPDU' or (e.kind in ('Data', 'QoS Null'))
            if not rd_resp:
                continue
            p = c.prev.get(e.i)
            pq = data_hdr(p) if p is not None else None
            if p is None or p.src != holder:
                prev_resp = p is not None and p.src == e.src
                if prev_resp:
                    pq2 = data_hdr(p)
                    if pq2 is not None and not pq2['rdg']:
                        r.bad(e, f'RD-ответ после своего PPDU с More PPDU = 0 (табл. 9-15: тот был последним)')
                    else:
                        r.ok()
                continue
            stats['RD-ответ'] += 1
            if pq is None:
                r.skip('RD-ответ: заголовок данных PPDU держателя не записан — RDG не проверить')
                continue
            if not pq['rdg']:
                r.bad(e, f'RD-ответ {_who(c, e.src)} на PPDU без RDG (10.29.2 b, 10.29.4)')
                continue
            r.ok()
            if p.dur_ok and e.te > p.te + p.dur + slack(p, e):
                r.bad(e, f'RD-ответ кончается через {float(e.te - p.te - p.dur):.1f} мкс после Duration RDG-PPDU '
                         f'(10.29.4: «shall ensure that its PPDU transmission(s) … fit entirely within»)')
            q = data_hdr(e)
            if q is not None:
                n = c.nxt.get(e.i)
                if q['rdg'] and n is not None and n.src != e.src and n.t - e.te <= RESP_WINDOW and \
                        not is_response_pair(e, n):
                    r.bad(n, f'после PPDU ответчика с More PPDU = 1 передаёт {_who(c, n.src)} (табл. 9-15)')
    r.info['counts'] = dict(stats)
    return r


def r_ampdu_dur(c):
    r = Rule('ampdu_dur', '9.7.3', 'одинаковый Duration у всех MPDU A-MPDU (записаны два MPDU одного PPDU: первый — в '
             'TX, отданный в очередь — в RX пира)')
    for e in c.evs:
        if not e.agg:
            continue
        ms = e.mpdus or []
        if len(ms) < 2:
            r.skip('записан один MPDU PPDU')
            continue
        ds = {int.from_bytes(m[2:4], 'little') for m in ms}
        if len(ds) > 1:
            r.bad(e, f'Duration MPDU A-MPDU: {sorted(ds)} (9.7.3: «carry the same value»)')
        else:
            r.ok()
    return r


def r_ba_window(c):
    r = Rule('ba_window', '10.25.6', 'BlockAck на A-MPDU: SN записанного MPDU данных — в окне [SSN, SSN + 63] и '
             'отмечен в битовой карте (10.25.6.3/10.25.6.4: после приёма MPDU WinStartR ≤ SN ≤ WinEndR)')
    for e in c.k:
        if e.kind != 'A-MPDU':
            continue
        q = data_hdr(e)
        n = c.nxt.get(e.i)
        if q is None or q['null'] or n is None:
            continue
        if not (is_response_pair(e, n) and n.t - e.te <= RESP_WINDOW):
            continue
        b = n.mpdus[0] if n.mpdus else None
        if b is None or len(b) < 28 or F.parse_fc(b[:2]).subtype != 9:
            r.skip('BlockAck-ответ записан синтетически (битовая карта не записана)')
            continue
        ssn = int.from_bytes(b[18:20], 'little') >> 4
        bm = int.from_bytes(b[20:28], 'little')
        off = (q['sn'] - ssn) % 4096
        if off >= 64:
            r.bad(n, f'SN {q["sn"]} первого записанного MPDU вне окна BlockAck [SSN {ssn}, +63]')
        elif not bm >> off & 1:
            r.bad(n, f'SN {q["sn"]} (смещение {off}) не отмечен в битовой карте {bm:#018x} — MPDU мог быть с ошибкой '
                     f'FCS', 'model')
        else:
            r.ok()
    return r


def r_mgmt_body(c):
    r = Rule('mgmt_body', '9.3.3', 'тела кадров управления (ref/elements.check_body: порядок элементов табл. '
             '9-33…9-42, '
             'обязательные для DMG, DMG Capabilities/Operation, Capability Information)')
    for e in c.evs:
        if e.kind not in BODY_FRAMES:
            continue
        if e.synth:
            r.skip('синтетический RX: тела нет')
            continue
        if not e.body_ok:
            r.skip('тело усечено записью (snap)')
            continue
        role = E.ROLE_AP if e.src == c.ap else E.ROLE_STA
        try:
            ms = E.check_body(e.kind, e.raw[24:], role)
        except (ValueError, NotImplementedError, F.FieldError) as x:
            ms = [f'разбор: {x}']
        for m in ms:
            r.bad(e, f'{e.kind}: {m}')
        if not ms:
            r.ok()
    return r


BODY_FRAMES = (E.PROBE_REQ, E.PROBE_RESP, E.ASSOC_REQ, E.ASSOC_RESP, E.REASSOC_REQ, E.REASSOC_RESP, E.AUTH, E.DEAUTH,
               E.DISASSOC)


def r_addba(c):
    r = Rule('addba', '9.6.4', 'ADDBA Request/Response (ref/blockack): Dialog Token ≠ 0, Fragment Number 0, ответ на '
             'запрос (токен, политика, TID), DMG — HT-immediate (Block Ack Policy 1, 10.25.1)')
    reqs = {}
    for e in c.evs:
        if e.action not in ('ADDBA Request', 'ADDBA Response') or not e.body_ok:
            continue
        try:
            if e.action == 'ADDBA Request':
                q = BA.parse_addba_req(e.raw[24:])
                ms = []
                if q.token == 0:
                    ms.append('Dialog Token = 0 (9.6.4.2)')
                if q.params.policy != 1:
                    ms.append(f'Block Ack Policy {q.params.policy} — DMG только HT-immediate (10.25.1)')
                reqs[(e.src, e.dst)] = q
            else:
                p = BA.parse_addba_resp(e.raw[24:])
                q = reqs.get((e.dst, e.src))
                ms = [] if q is not None else ['ADDBA Response без запроса (10.25.2)']
                if q is not None:
                    BA.check_addba_response(q, p)
        except ValueError as x:
            ms = [str(x)]
        for m in ms:
            r.bad(e, f'{e.action}: {m}')
        if not ms:
            r.ok()
    return r


TRN_RULES = ('rx-trn', 'tx-trn', 'bs-fbck', 'fbck-taps', 'nmeas', 'owe-trn-t', 'trn-awv', 'cmf', 'txss-fbck')


def r_brp(c):
    r = Rule('brp', '10.42.6.4', 'кадры BRP (Action No Ack, 9.6.21.3) и транзакции (ref/brp.check_brp_log): поля BRP '
             'Request/DMG Beam Refinement, бит Initiator, промежутки SIFS…BRPIFS, ответы на запросы')
    frames = [e for e in c.evs if e.kind == 'BRP']
    if not frames:
        r.skip('BRP в захвате нет')
        return r
    from . import brp as B
    pp, idx = [], []
    for e in frames:
        if not e.body_ok:
            r.skip('тело BRP усечено')
            continue
        b = e.raw[24:]
        try:
            f = B.BrpFrame(req=B.BrpRequest.parse(b[3:7]), bre=B.BeamRefinement.parse(b[7:14]), token=b[2])
        except (AssertionError, IndexError, ValueError) as x:
            r.bad(e, f'разбор BRP: {x}')
            continue
        for m in f.req.validate():
            r.bad(e, m)
        if not e.t_ok:
            r.skip('время BRP неизвестно (метка TX испорчена, пир не принял)')
            continue
        pp.append(B.Ppdu(e.t, e.src, e.dst, frame=f, mcs=e.mcs or 0, length=e.length, dur=e.dur))
        idx.append(e.i)
    if pp:
        trn = Counter()
        for v in B.check_brp_log(pp):
            if v.rule in TRN_RULES:
                trn[v.rule] += 1
                continue
            e = c.evs[idx[v.idx]]
            # приём BRP пиром не записан (RX кадров управления в записи нет), кадры пира без времени могли быть ответом
            verdict = 'capture' if v.rule in ('no-response', 'retransmit') else 'ours'
            r.bad(e, f'{v.rule}: {v.msg}', verdict)
        r.ok(len(pp))
        if trn:
            r.skip(f'TRN-поля PPDU (Training Length, PPDU Type) запись не несёт — правила {sorted(trn)}',
                   sum(trn.values()))
    r.info['brp_frames'] = len(frames)
    r.info['with_time'] = len(pp)
    return r
def _bic(b):
    return BI.BeaconIntervalControl(
        cc_present=b.cc_present, discovery_mode=b.discovery, next_beacon=b.next_beacon, ati_present=b.ati_present,
        abft_length=b.abft_length, fss=b.fss, is_responder_txss=b.is_resp_txss, next_abft=b.next_abft,
        fragmented_txss=b.fragmented_txss, txss_span=b.txss_span, n_bis_abft=b.n_bis_abft, abft_count=b.abft_count,
        n_abft_in_ant=b.n_abft_in_ant, pcp_association_ready=b.pcp_assoc_ready)


def _bf(e):
    p = e.p
    kw = dict(length=e.length, mcs=e.mcs or 0, dur=e.dur)
    if e.kind == 'SSW':
        kw.update(direction=p.ssw.direction, cdown=p.ssw.cdown, sector_id=p.ssw.sector_id,
                  antenna_id=p.ssw.antenna_id, rxss_len=p.ssw.rxss_length or None)
        if isinstance(p.fb, F.SswFbIss):
            kw['fb'] = {'total': p.fb.total_sectors + 1, 'n_rx_ant': p.fb.rx_antennas, 'poll': p.fb.poll_required}
        else:
            kw['fb'] = {'sector': p.fb.sector_select, 'antenna': p.fb.antenna_select, 'snr': p.fb.snr_report,
                        'poll': p.fb.poll_required}
    else:
        kw['fb'] = {'sector': p.fb.sector_select, 'antenna': p.fb.antenna_select, 'snr': p.fb.snr_report,
                    'poll': p.fb.poll_required}
        kw['brp'] = {'L-RX': p.brp.l_rx, 'TX-TRN-REQ': p.brp.tx_trn_req, 'MID-REQ': p.brp.mid_req,
                     'BC-REQ': p.brp.bc_req}
    kw['tx'] = (None, None)
    return S.BfFrame(e.kind, e.src, e.dst, e.t, **kw)


def r_sls(c):
    r = Rule('sls', '10.42.2', 'SLS в DTI (ref/sls.check_sls_log + 10.42.6.2): ISS → RSS через MBIFS, SSW через SBIFS, '
             'SSW-Feedback через MBIFS после конца RSS (по CDOWN), SSW-Ack через MBIFS, выбор сектора, Duration')
    bf = [e for e in c.evs if e.kind in ('SSW', 'SSW-Feedback', 'SSW-Ack')]
    if not bf:
        r.skip('SLS в захвате нет')
        return r
    lost = [e for e in bf if not e.t_ok]
    if lost:
        r.skip('кадры SLS без времени (метка TX AP испорчена, пир кадр не принял)', len(lost))
        r.info['frames_without_time'] = [f'{e.kind} {_who(c, e.src)} CDOWN {e.p.ssw.cdown}'
                                         if e.p is not None and e.kind == 'SSW' else e.kind for e in lost]
    known = sorted((e for e in bf if e.t_ok and e.p is not None), key=lambda e: e.t)
    runs, cur = [], None
    for e in known:
        if e.kind == 'SSW' and e.p.ssw.direction == 0 and (cur is None or cur[-1].kind != 'SSW' or
                                                           cur[-1].p.ssw.direction != 0 or cur[-1].src != e.src):
            cur = [e]
            runs.append(cur)
        elif cur is not None:
            cur.append(e)
    gaps = defaultdict(list)
    t_ssw = T.T_SSW
    for run in runs:
        iss = [e for e in run if e.kind == 'SSW' and e.p.ssw.direction == 0]
        rss = [e for e in run if e.kind == 'SSW' and e.p.ssw.direction == 1]
        fb = [e for e in run if e.kind == 'SSW-Feedback']
        ack = [e for e in run if e.kind == 'SSW-Ack']
        for seq, who in ((iss, 'ISS'), (rss, 'RSS')):
            for a, b in zip(seq, seq[1:]):
                steps = a.p.ssw.cdown - b.p.ssw.cdown
                g = (b.t - a.te - (steps - 1) * (t_ssw + T.SBIFS)) if steps >= 1 else b.t - a.te
                gaps[f'{who} SBIFS'].append(g)
                if not T.SBIFS - Q <= g <= T.SBIFS_MAX + Q:
                    r.bad(b, f'{who}: промежуток SSW {float(g):.2f} мкс ≠ SBIFS (10.42.2.2.2)')
                else:
                    r.ok()
        if iss and rss and iss[-1].p.ssw.cdown == 0:
            # первый кадр RSS мог не дойти до инициатора: начало RSS — по CDOWN первого переданного кадра (с учётом
            # кадров без времени, у которых границы попадают между ISS и первым принятым кадром RSS)
            c0 = max([rss[0].p.ssw.cdown] + [e.p.ssw.cdown for e in lost if e.p is not None and e.kind == 'SSW' and
                                             e.src == rss[0].src and e.p.ssw.direction == 1 and
                                             e.t_hi >= iss[-1].t and e.t_lo <= rss[0].t])
            g = rss[0].t - (c0 - rss[0].p.ssw.cdown) * (t_ssw + T.SBIFS) - iss[-1].te
            gaps['ISS→RSS MBIFS'].append(g)
            s = slack(iss[-1], rss[0])
            if not T.MBIFS - s <= g <= T.MBIFS + T.MBIFS_TOL + s:
                r.bad(rss[0], f'RSS начат через {float(g):.2f} мкс после ISS ≠ MBIFS (10.42.6.2)')
            else:
                r.ok()
        if rss and fb:
            last = rss[-1]
            end = last.te + last.p.ssw.cdown * (t_ssw + T.SBIFS)       # ожидаемый конец RSS по CDOWN (10.42.2.2.2)
            g = fb[0].t - end
            gaps['RSS(конец по CDOWN)→SSW-Feedback'].append(g)
            s = slack(last, fb[0])
            if g < T.MBIFS - s:
                r.bad(fb[0], f'SSW-Feedback {_who(c, fb[0].src)} через {float(fb[0].t - last.te):.2f} мкс после '
                             f'SSW RSS с '
                             f'CDOWN {last.p.ssw.cdown}: до ожидаемого конца RSS ещё {float(end - fb[0].t):.1f} мкс '
                             f'(10.42.6.2: «MBIFS following the completion of an RSS»); RSS-кадры CDOWN '
                             f'{last.p.ssw.cdown - 1}..0 точки пиром не приняты',
                      'ours')
            elif g > T.MBIFS + T.MBIFS_TOL + s:
                r.bad(fb[0], f'SSW-Feedback через {float(g):.2f} мкс после конца RSS ≠ MBIFS')
            else:
                r.ok()
        if fb and ack:
            g = ack[0].t - fb[0].te
            gaps['SSW-Feedback→SSW-Ack MBIFS'].append(g)
            s = slack(fb[0], ack[0])
            if not T.MBIFS - s <= g <= T.MBIFS + T.MBIFS_TOL + s:
                r.bad(ack[0], f'SSW-Ack через {float(g):.2f} мкс после SSW-Feedback ≠ MBIFS (10.42.6.2)')
            else:
                r.ok()
        # остальные правила модели (выбор сектора, поля, Duration по журналу)
        msgs = S.check_sls_log([_bf(e) for e in run], {'access': S.CBAP})
        for m in msgs:
            if 'передан через' in m or 'промежуток' in m or 'MBIFS' in m or 'SBIFS' in m:
                continue      # сектор передачи не записан; промежутки — выше, с квантом меток
            r.bad(run[0], f'SLS @{float(run[0].t):.1f}: {m}', 'capture' if lost else 'ours')
        r.ok(len(run))
    r.info['runs'] = len(runs)
    r.info['gaps_us'] = {k: stat(v) for k, v in gaps.items()}
    r.verdict_note = ('Кадры RSS точки (TX AP, метка испорчена, CDOWN пиром не записан) получают время из RX STA: '
                      'кадр с флагом CDOWN0 — CDOWN 0, остальные — по шагу TXTIME(SSW) + SBIFS (air_pcap._ssw_align). '
                      'Не принятые STA кадры RSS — без времени (partial).')
    return r


# =====================================================================================================================
# волна C: A-BFT по BIC, ATI, состояние пары (11.3), роли BRP, NAV узла, DMG CTS-to-self, поддержание связи,
# сопровождение луча
# =====================================================================================================================
def _abft_bic(b):
    """fields.Bic → abft.BeaconIntervalControl (имена подполей рис. 9-77)."""
    return A.BeaconIntervalControl(
        cc_present=b.cc_present, discovery_mode=b.discovery, next_beacon=b.next_beacon, ati_present=b.ati_present,
        abft_length=b.abft_length, fss=b.fss, is_responder_txss=b.is_resp_txss, next_abft=b.next_abft,
        fragmented_txss=b.fragmented_txss, txss_span=b.txss_span, n_bis_abft=b.n_bis_abft, abft_count=b.abft_count,
        n_abft_in_ant=b.n_abft_in_ant, pcp_assoc_ready=b.pcp_assoc_ready)


def _btis(c):
    """BTI точки по BI: {k: [маяки]} (TX-записи AP с телом и временем) и BI в TU."""
    beacons = [e for e in c.k if e.kind == 'DMG Beacon' and e.src == c.ap and e.p is not None and e.tx_node]
    if not beacons:
        return {}, None
    bi_tu = beacons[0].p.beacon_interval
    by = defaultdict(list)
    for b in beacons:
        by[BI.bi_index(b.t, bi_tu)].append(b)
    return by, bi_tu


def _abft_window(bs):
    """[начало, конец) A-BFT после BTI bs (10.42.5.1: MBIFS после конца BTI; aSSSlotTime × слоты, 10.42.5.2) или
    None, если в этом BI A-BFT нет (Next A-BFT ≠ 0)."""
    last = bs[-1]
    b = last.p.bic
    if b.next_abft != 0:
        return None
    start = A.abft_start(last.te + (last.dur or 0))
    return start, start + (b.abft_length + 1) * T.ss_slot_time(b.fss + 1)


def r_abft(c):
    r = Rule('abft', '10.42.5', 'A-BFT: расписание по Beacon Interval Control маяков (ref/abft.check_bic_sequence: '
             'BIC одинаков в BTI, Next A-BFT −1 по BI, интервал N BIs A-BFT, FSS ≥ aSSFramesPerSlot, TXSS не реже '
             'dot11ABFTRTXSSSwitch) и кадры в объявленной A-BFT (SSW ответчиков, SSW-Feedback точки)')
    by, bi_tu = _btis(c)
    if not by:
        r.skip('нет DMG Beacon AP с телом и временем')
        return r
    ks = sorted(by)
    seq = [((([_abft_bic(b.p.bic) for b in by[k]]), by[k][0].p.ssw.antenna_id) if k in by else None)
           for k in range(ks[0], ks[-1] + 1)]
    for v in A.check_bic_sequence(seq):
        r.bad(by[ks[0] + v.idx][0], f'{v.rule}: {v.msg}')
    r.ok(len(ks))
    vals = Counter((b.p.bic.next_abft, b.p.bic.abft_length + 1, b.p.bic.fss + 1, b.p.bic.n_bis_abft,
                    b.p.bic.is_resp_txss) for k in ks for b in by[k][:1])
    r.info['bic(next_abft, slots, fss_frames, n_bis_abft, resp_txss)'] = {str(k): n for k, n in vals.items()}
    n_win = n_abft = 0
    rules = Counter()
    for k in ks:
        w = _abft_window(by[k])
        if w is None:
            continue
        n_win += 1
        bic = by[k][-1].p.bic
        L = A.AbftLayout(w[0], bic.abft_length + 1, bic.fss + 1)
        evs = [e for e in c.k if e.kind != 'DMG Beacon' and w[0] - Q <= e.t < w[1]]
        lost = [e for e in c.unk if e.kind != 'DMG Beacon' and e.t_lo is not None and e.t_hi is not None and
                e.t_lo >= w[0] and e.t_hi < w[1]]
        if lost:
            r.skip('кадры без времени внутри A-BFT (метка TX испорчена, пир не принял)', len(lost))
        if not evs:
            continue
        n_abft += len(evs)
        frames = []
        for e in evs:
            kw = dict(length=e.length, mcs=e.mcs or 0, duration=e.dur)
            if e.kind == 'SSW' and e.p is not None:
                kw.update(direction=e.p.ssw.direction, cdown=e.p.ssw.cdown, sector_id=e.p.ssw.sector_id,
                          ant_id=e.p.ssw.antenna_id)
                if not isinstance(e.p.fb, F.SswFbIss):
                    kw.update(sector_select=e.p.fb.sector_select, ant_select=e.p.fb.antenna_select,
                              snr=e.p.fb.snr_report, poll=e.p.fb.poll_required)
            elif e.kind == 'SSW-Feedback' and e.p is not None:
                kw.update(sector_select=e.p.fb.sector_select, ant_select=e.p.fb.antenna_select,
                          snr=e.p.fb.snr_report)
            frames.append(A.AirFrame(e.kind, e.t, e.src, e.dst, **kw))
        seen = set()
        for v in A.check_abft_log(frames, L, c.ap):
            e = evs[v.idx]
            rules[v.rule] += 1
            if (v.rule, e.src) in seen:
                continue                  # одно нарушение на правило и передатчик в A-BFT (число кадров — в info)
            seen.add((v.rule, e.src))
            r.bad(e, f'{v.rule}: {v.msg} — A-BFT BI {k} [{float(w[0]):.1f}, {float(w[1]):.1f}), '
                     f'{bic.abft_length + 1} слота × FSS {bic.fss + 1} (10.42.5.2)')
        r.ok(len(evs))
    r.info['abft_announced'] = n_win
    r.info['frames_in_abft'] = n_abft
    r.info['frames_by_rule'] = dict(rules)
    if not n_abft:
        r.skip('кадров в A-BFT нет (STA вошла через SLS в DTI): слоты, FSS ответчика, backoff — не проверяемы по '
               'этому захвату; чужие передачи в A-BFT — правило bi (abft_kind)')
    return r


def r_ati(c):
    r = Rule('ati', '10.39.3', 'ATI: присутствие — по ATI Present маяка (10.39.3, 9.3.4.2); ATI Present = 0 — в BI нет '
             'Announce/кадров ATI; = 1 — ATI после A-BFT (запрос точки — ответ STA)')
    by, bi_tu = _btis(c)
    if not by:
        r.skip('нет DMG Beacon AP с телом и временем')
        return r
    ann = [e for e in c.evs if e.action == 'Announce' or (e.kind == 'Action No Ack' and e.action == 'Announce')]
    pres = Counter()
    for k, bs in by.items():
        p = bs[0].p.bic.ati_present
        pres[p] += 1
        in_bi = [e for e in ann if e.t_ok and BI.bi_index(e.t, bi_tu) == k]
        if not p and in_bi:
            r.bad(in_bi[0], f'Announce в BI {k} при ATI Present = 0 (10.39.3)')
        elif p and not in_bi:
            r.skip('ATI Present = 1, кадров ATI не видно (RX управления в записи нет)')
        else:
            r.ok()
    r.info['ati_present'] = dict(pres)
    r.info['announce_frames'] = len(ann)
    return r


_CLASS_KIND = {'QoS Null': 'Data', 'Data': 'Data'}


def _mlme_kind(e):
    """Вид кадра для mlme.frame_class (11.3.3) или None — класс по записи не определить."""
    if e.kind in _CLASS_KIND:
        return 'Data'
    if e.kind == 'A-MPDU':
        return 'Data'                     # A-MPDU несёт данные (RD-ответ — BlockAck + данные): класс 3
    if e.kind == 'BRP':
        return 'BRP'
    if e.kind in ('Action', 'Action No Ack'):
        if e.synth or not e.body_ok:
            return None                   # категория не записана (BRP — класс 1, прочие Action — класс 3)
        if e.action in M._ACTION:
            return e.action
        # табл. 9-51: 4 Public, 15 Self-protected, 20 Unprotected DMG — класс 1 (11.3.3 a) 2) vi, vii, ix)
        return {4: 'Public Action', 15: 'Self-protected Action', 20: 'Unprotected DMG Action'}.get(e.raw[24], e.kind)
    if e.kind in ('DMG Beacon',):
        return None
    try:
        M.frame_class(e.kind)
    except ValueError:
        return None
    return e.kind


STATE_FRAMES = (E.ASSOC_REQ, E.ASSOC_RESP, E.REASSOC_REQ, E.REASSOC_RESP, E.DISASSOC, E.DEAUTH)


def r_assoc_state(c):
    r = Rule('assoc_state', '11.3.3', 'состояние пары и классы кадров (ref/mlme.check_assoc_log): DMG STA без '
             'аутентификации 802.11 — State 2 до ассоциации (11.3.1); класс 3 (данные, BlockAck, Action кроме '
             'Unprotected DMG/Public) — только в State 3/4 (11.3.3); AP не инициирует ассоциацию; AID 1…254; DMG AP, '
             'получив класс 3 от STA в State 2, — Disassociation (11.3.5.1)')
    ap = c.ap
    start = next((j for j, e in enumerate(c.evs) if e.kind in STATE_FRAMES and ap in (e.src, e.dst)), None)
    if start is None:
        r.skip('кадров (ре)ассоциации/дизассоциации нет: состояние пары до захвата неизвестно', 1)
        return r
    rsna = any(e.kind in (E.PROBE_RESP, E.ASSOC_RESP) and e.src == ap and e.body_ok and
               any(x.eid == 48 for x in E.parse_body(e.kind, e.raw[24:])[1]) for e in c.evs)
    log, idx, synth_kind = [], [], set()
    for j in range(start, len(c.evs)):
        e = c.evs[j]
        if e.src is None or e.dst is None or F.is_group(e.dst):
            continue
        k = _mlme_kind(e)
        if k is None:
            if e.kind in ('Action', 'Action No Ack'):
                r.skip('Action без записанной категории (синтетический RX): класс неизвестен')
            continue
        info = {}
        if e.kind in (E.ASSOC_RESP, E.REASSOC_RESP) and e.body_ok:
            fx, _ = E.parse_body(e.kind, e.raw[24:])
            info = dict(status=fx['status'], aid=fx['aid'] & 0x3fff)
            nx = next((x for x in c.evs[j + 1:j + 6] if x.kind == 'Ack' and x.dst == ap), None)
            info['acked'] = nx is not None
        if e.kind in (E.DISASSOC, E.DEAUTH) and e.body_ok:
            info = dict(reason=E.parse_body(e.kind, e.raw[24:])[0]['reason'])
        log.append(M.LogEvent(e.tsort, k, e.src, e.dst, info))
        idx.append(j)
        if e.synth:
            synth_kind.add(j)
    for v in M.check_assoc_log(log, ap, rsna=rsna):
        e = c.evs[idx[v.idx]]
        verdict = 'ours'
        note = ''
        if v.rule == 'missing_reply':
            got = e.rx_nodes and any(c.air.nodes.get(n) == ap for n in e.rx_nodes)
            verdict = 'ours' if got else 'capture'
            note = '' if got else ' (приём точкой не записан)'
        if idx[v.idx] in synth_kind:
            note += ' [вид — по слоту парсера RX-записи пира: тип Data, длина {}]'.format(e.length)
        r.bad(e, f'{v.rule}: {v.msg}{note}', verdict)
    r.ok(len(log) - len(r.viol))
    r.info['rsna'] = rsna
    r.info['from_event'] = c.evs[start].where()
    r.verdict_note = ('Класс кадра — по 11.3.3; синтетические RX-записи данных (QoS Null) — тип Data по слоту '
                      'парсера и длине (30 октетов = QoS Null), это класс 3 в инфраструктуре независимо от подтипа.')
    return r


def _sls_runs(c):
    """SLS по порядку событий: [(инициатор, ответчик, j первого кадра, j последнего, SSW-Ack | None)]; инициатор — TA
    SSW ISS (Direction = 0, 10.42.2.2.1); новый SLS — SSW ISS после RSS/Feedback/Ack предыдущего или от другой STA."""
    out, cur = [], None
    for j, e in enumerate(c.evs):
        if e.kind == 'SSW' and e.p is not None and e.p.ssw.direction == 0:
            if cur is None or cur['ini'] != e.src or cur['late']:
                cur = dict(ini=e.src, resp=e.dst, j0=j, j=j, ack=None, late=False)
                out.append(cur)
            cur['j'] = j
        elif cur is not None and cur['ack'] is None and e.kind in ('SSW', 'SSW-Feedback', 'SSW-Ack') and \
                {e.src, e.dst} == {cur['ini'], cur['resp']}:
            cur['j'], cur['late'] = j, True
            if e.kind == 'SSW-Ack' and e.p is not None:
                cur['ack'] = e
    return [(x['ini'], x['resp'], x['j0'], x['j'], x['ack']) for x in out]


def _brp_fields(e):
    from . import brp as B
    b = e.raw[24:]
    return B.BrpRequest.parse(b[3:7]), B.BeamRefinement.parse(b[7:14])


def r_brp_role(c):
    r = Rule('brp_role', '10.42.3.1', 'роли BRP после SLS: в том же распределении инициатор уточнения — инициатор SLS '
             '(10.42.3.1), транзакцию начинает он кадром с Initiator = 1 (10.42.6.4.2), ответчик SLS свою не '
             'начинает; при L-RX > 0 или TX-TRN-REQ = 1 в SSW-Ack инициатор обязан послать BRP (10.42.6.4.3)')
    runs = _sls_runs(c)
    if not runs:
        r.skip('SLS в захвате нет')
        return r
    bti_starts = sorted(e.tsort for e in c.evs if e.kind == 'DMG Beacon' and e.src == c.ap)
    import bisect
    seen = Counter()
    for n, (ini, resp, j0, j_end, ack) in enumerate(runs):
        j_next = runs[n + 1][2] if n + 1 < len(runs) else len(c.evs)
        t_end = c.evs[j_end].tsort
        # «same allocation»: CBAP-only DTI — до следующего BTI
        b = bisect.bisect_right(bti_starts, t_end)
        t_alloc_end = bti_starts[b] if b < len(bti_starts) else None
        # кадры BRP пары после начала SLS и до следующего SLS (время BRP точки — лишь границы, поэтому в порядке
        # событий они могут стоять среди кадров SLS)
        brps = [e for e in c.evs[j0 + 1:j_next] if e.kind == 'BRP' and {e.src, e.dst} == {ini, resp} and
                e.body_ok and (t_alloc_end is None or e.tsort < t_alloc_end)]
        sent_by_ini = False
        for e in brps:
            try:
                req, bre = _brp_fields(e)
            except (AssertionError, IndexError, ValueError):
                continue
            if e.src == resp and bre.initiator:
                seen['resp_initiator'] += 1
                r.bad(e, f'ответчик SLS {_who(c, resp)} шлёт BRP с Initiator = 1 в распределении SLS, где инициатор — '
                         f'{_who(c, ini)} (10.42.3.1: «the SLS initiator is the beam refinement initiator»; '
                         f'10.42.6.4.2)')
            elif e.src == ini and not bre.initiator and not sent_by_ini:
                seen['ini_first_not_initiator'] += 1
                r.bad(e, f'первый BRP инициатора SLS {_who(c, ini)} с Initiator = 0 (10.42.6.4.2: транзакцию '
                         f'начинает инициатор кадром с Initiator = 1)')
            else:
                r.ok()
            if e.src == ini:
                sent_by_ini = True
        if ack is not None and (ack.p.brp.l_rx > 0 or ack.p.brp.tx_trn_req):
            if not sent_by_ini:
                if t_alloc_end is None and j_next == len(c.evs):
                    r.skip('конец захвата: BRP инициатора после SLS не дождались')
                else:
                    r.bad(ack, f'SSW-Ack {_who(c, resp)}: L-RX {ack.p.brp.l_rx}, TX-TRN-REQ {ack.p.brp.tx_trn_req} — '
                               f'инициатор {_who(c, ini)} не послал BRP в том же распределении (10.42.6.4.3)')
            else:
                r.ok()
        seen['sls'] += 1
    r.info['counts'] = dict(seen)
    r.verdict_note = ('Время BRP точки не записано (метка TX испорчена), правило от времени не зависит: роли — по '
                      'полю Initiator (9.4.2.129) TX-записей и по инициатору SLS (Direction первого SSW ISS); '
                      '«распределение» в CBAP-only DTI — до следующего BTI.')
    return r


INIT_GAP = SIFS + SLOT          # PIFS: начало после такой паузы среды — новый доступ, не ответ/продолжение TXOP


def r_nav_rx(c):
    r = Rule('nav_rx', '10.3.2.4', 'NAV узла (единый NAV DMG, ref/nav поверх cbap.Nav): по принятым узлом кадрам с RA '
             '≠ свой (DMG CTS с TA = свой — без обновления, 10.3.2.4; CF-End — 10.23.2.10); новый доступ узла '
             '(после паузы ≥ PIFS) при занятом NAV — нарушение (10.3.2.1, 10.23.2.4)')
    macs = {n: m for n, m in c.air.nodes.items() if m}
    if len(macs) < 2:
        r.skip('нужны записи обоих узлов (приём пира)')
        return r
    cnt = Counter()
    for node, me in macs.items():
        nav = NV.Nav(me)
        last_end = None
        for e in c.k:
            gap = e.t - last_end if last_end is not None else None
            if e.tx_node == node:
                if gap is not None and gap >= INIT_GAP and e.kind != 'DMG Beacon':
                    if nav.busy(e.t):
                        cnt['busy'] += 1
                        r.bad(e, f'{node}: {e.kind} начат при занятом NAV (до {float(nav.idle_from()):.1f}; '
                                 f'10.3.2.1, 10.3.2.4)')
                    else:
                        r.ok()
            elif node in e.rx_nodes and e.dur_ok and e.dur is not None:
                ta = e.src
                if e.kind == 'DMG CTS' and e.p is not None:
                    ta = e.p.ta
                nav.rx_start(e.t)
                nav.rx(e.te, NV._CbapFrame(e.kind, ta, e.dst, e.dur))
                if NV.single_nav_updates(NV.NavFrame(e.kind, e.dst, ta, e.dur), me):
                    cnt[f'nav_from_{e.kind}'] += 1
            if last_end is None or e.te > last_end:
                last_end = e.te
    r.info['nav_updates'] = dict(cnt)
    r.skip('кадры, принятые узлом без RX-записи (маяки, кадры управления), NAV не обновляют — их NAV не виден')
    return r


def r_cts_self(c):
    r = Rule('cts_self', '9.3.1.13', 'DMG CTS-to-self (RA = свой адрес): TA — индивидуальный адрес получателя или '
             'групповой адрес получателей следующего кадра (9.3.1.13); Duration — остаток TXOP: следующие кадры '
             'держателя кончаются в его пределах')
    nodes = set(m for m in c.air.nodes.values() if m)
    for j, e in enumerate(c.evs):
        if e.kind != 'DMG CTS' or e.p is None or e.p.ra != e.src or not e.tx_node:
            continue
        ta = e.p.ta
        nxt = None
        for x in c.evs[j + 1:j + 8]:
            if x.src == e.src and x.kind not in ('DMG CTS',):
                nxt = x
                break
            if x.kind == 'DMG CTS' and x.src == e.src:
                break
        if nxt is not None and e.t_ok and nxt.t_ok and nxt.t - e.te > T.PIFS + slack(e, nxt):
            nxt = None                            # не через SIFS (PIFS — восстановление) — не следующий кадр TXOP
        if nxt is not None:
            if nxt.dst != ta:
                r.bad(e, f'TA {ta} ≠ RA следующего кадра {nxt.kind} {nxt.dst} (9.3.1.13)')
            else:
                r.ok()
            if e.t_ok and nxt.t_ok and nxt.te > e.te + (e.dur or 0) + Q:
                r.bad(nxt, f'{nxt.kind} кончается через {float(nxt.te - e.te):.1f} мкс после DMG CTS-to-self, '
                           f'Duration {e.dur} (9.3.1.13: остаток TXOP)')
        elif not F.is_group(ta) and ta not in nodes:
            r.bad(e, f'TA {ta} — индивидуальный адрес не из BSS (9.3.1.13: адрес получателя следующего кадра); '
                     f'следующий кадр не записан')
        else:
            r.skip('следующий кадр держателя не записан (данные без записи)')
    return r


def r_blm(c):
    r = Rule('blm', '11.27.1', 'поддержание направленной связи: dot11BeamLinkMaintenanceTime по полям BLM SSW-Feedback '
             'и SSW-Ack (9.5.6, табл. 9-345); если определено — таймер связи (ref/linkmaint) не истекает без '
             'восстановления (QoS Null «to prevent expiration»)')
    pairs = []
    fb = None
    for e in c.evs:
        if e.kind == 'SSW-Feedback' and e.p is not None:
            fb = e
        elif e.kind == 'SSW-Ack' and e.p is not None and fb is not None and fb.src == e.dst:
            pairs.append((fb, e))
            fb = None
    if not pairs:
        r.skip('SLS со SSW-Feedback и SSW-Ack нет')
        return r
    res = Counter()
    by, bi_tu = _btis(c)
    halts = []
    for k, bs in by.items():
        w = _abft_window(bs)
        halts.append((bs[0].t, w[1] if w else bs[-1].te + (bs[-1].dur or 0)))
    for fbe, ack in pairs:
        dur = LM.negotiate(fbe.p.blm, ack.p.blm)
        res[(F.blm_time(fbe.p.blm), F.blm_time(ack.p.blm), dur)] += 1
        r.ok()
        if dur is None:
            continue
        a, b = fbe.src, ack.src
        evs = [LM.LogEv(e.t, e.te, e.kind, e.src, e.dst) for e in c.k if e.t >= ack.te and {e.src, e.dst} == {a, b}]
        evs.insert(0, LM.LogEv(ack.t, ack.te, 'SSW-Ack', ack.src, ack.dst))
        vs, s = LM.check_blm_log(evs, a, b, dur, halts)
        for v in vs:
            r.bad(None, v.msg)
    r.info['blm(fb_us, ack_us, negotiated)'] = {str(k): n for k, n in res.items()}
    if all(k[2] is None for k in res):
        r.verdict_note = ('BeamLink Maintenance Value = 0 у обеих сторон: dot11BeamLinkMaintenanceTime не определён '
                          '(9.5.6 «does not participate in beamformed link maintenance») — таймер не ведётся, '
                          'правила 11.27.1 о таймере неприменимы.')
    return r


def r_beam_track(c):
    r = Rule('beam_track', '10.42.7', 'сопровождение луча: DMG STA Beam Tracking Time Limit (9.4.2.127.4) в DMG '
             'Capabilities и итог табл. 10-31; одинаковое значение во всех кадрах STA')
    vals = defaultdict(Counter)
    for e in c.evs:
        if e.kind not in (E.PROBE_REQ, E.PROBE_RESP, E.ASSOC_REQ, E.ASSOC_RESP, E.REASSOC_REQ, E.REASSOC_RESP) or \
                not e.body_ok or e.synth:
            continue
        try:
            _, els = E.parse_body(e.kind, e.raw[24:])
        except (ValueError, NotImplementedError):
            continue
        for x in els:
            if x.eid == E.EID_DMG_CAPABILITIES:
                v = int.from_bytes(bytes(x.info[17:19]), 'little') if len(x.info) >= 19 else None
                vals[e.src][v] += 1
    if not vals:
        r.skip('DMG Capabilities в записанных кадрах управления нет')
        return r
    for sta, cnt in vals.items():
        if len(cnt) > 1:
            r.bad(None, f'{_who(c, sta)}: разные Beam Tracking Time Limit {dict(cnt)}')
        else:
            r.ok()
    info = {}
    stas = list(vals)
    for a in stas:
        fa = next(iter(vals[a]))
        for b in stas:
            if a == b:
                continue
            fb = next(iter(vals[b]))
            lim = BT.bt_time_limit(fb, fa if fa not in (None, 0) else T.DOT11_BEAM_TRACKING_TIME_LIMIT)
            info[f'{_who(c, a)}→{_who(c, b)}'] = ('TX beam tracking не поддержан' if lim is None else float(lim))
    r.info['field'] = {_who(c, s): dict(v) for s, v in vals.items()}
    r.info['table_10_31'] = info
    r.skip('запросы в PPDU (BEAM_TRACKING_REQUEST, PPDU_TYPE, TRN_LEN — заголовок PHY) запись PMC не несёт: '
           'ref/beamtrack.check_bt_log по эфиру не применить', 1)
    if any(0 in v for v in vals.values()):
        r.verdict_note = ('Поле = 0 — «Transmit beam tracking is not supported» (табл. 10-31); такая сигнализация '
                          'устарела (10.42.7 NOTE 2), но допустима.')
    return r


RULES = (r_fc, r_ctl_len, r_cfe_fields, r_beacon_fields, r_mgmt_body, r_addba, r_ba_control, r_mcs_control,
         r_mcs_response, r_dur_cts, r_dur_resp, r_dur_cf_end, r_dur_bf, r_nav_txop, r_edca, r_txop_limit,
         r_cf_end_rules,
         r_cf_end_lost, r_ifs_sifs, r_holder_gap, r_access, r_responder, r_resp_seq, r_cbap_end, r_ack_policy, r_rd,
         r_ampdu_dur, r_ba_window, r_bi, r_bti_delay, r_sls, r_abft, r_brp, r_ati, r_assoc_state, r_brp_role,
         r_nav_rx, r_cts_self, r_blm, r_beam_track)

NOT_CHECKABLE = [
    ('ba_scoreboard', '10.25.6.3–10.25.6.5', 'битмап BlockAck целиком против принятых MPDU — записан один MPDU данных '
     'на PPDU (проверяется только он, правило ba_window)'),
    ('nav_third_party', '10.3.2.4', 'NAV сторонних STA — в BSS два узла, все кадры адресованы пиру (RA = свой)'),
    ('timestamp_point', '11.1.3.1', 'Timestamp = TSF в начале символа данных — нужна внешняя опора времени'),
    ('brp_trn', '10.42.6.4, 20.9.2.2', 'поля TRN (Training Length, PPDU Type) — запись PMC их не несёт'),
    ('mgmt_rx', '11.3', 'приём кадров управления пиром — RX управления в запись не попадает, видны только TX'),
    ('beam_tracking_ppdu', '10.42.7', 'запрос сопровождения луча (TXVECTOR BEAM_TRACKING_REQUEST, PPDU_TYPE, TRN_LEN) '
     'и TRN-подполя ответа — заголовок PHY запись не несёт (модель — ref/beamtrack)'),
    ('nav_multi', '10.39.10', 'поддерживает ли узел несколько NAV, не видно; судья nav_rx ведёт единый NAV (10.3.2.4), '
     'модель нескольких NAV — ref/nav.MultiNav'),
    ('abft_responder', '10.42.5.2', 'выбор слота, FSS ответчика, FailedRSSAttempts/backoff — STA входит через SLS в '
     'DTI, кадров в A-BFT нет (модель — ref/abft)'),
    ('dyn_alloc', '10.39.7', 'Poll/SPR/Grant, PP/GP — open их не использует (строгий TDMA — pro); в захватах таких '
     'кадров нет'),
]


def judge(air, examples=5, edca=None):
    c = Ctx(air, edca)
    _CAL['c'] = c
    rules = []
    for f in RULES:
        r = f(c)
        if not r.checked and not r.unchecked and not r.viol:
            r.skip('в захвате нет кадров, к которым применимо правило')
        rules.append(r)
    _CAL['c'] = None
    return c, rules


def _cal_ok_near(c, e):
    """Событие и его предшественник по времени — с надёжной калибровкой (правила времени сравнивают пары)."""
    p = c.prev.get(e.i) if e.t_ok else None
    return e.cal_ok is not False and (p is None or p.cal_ok is not False)


def report(air, rules, c, examples=5):
    L = []
    s = air.stats
    L.append('=== Захват → журнал эфира ===')
    L.append(AP.summary(air).split('\n')[0])
    for k, v in air.cal.stats.items():
        L.append(f'  калибровка {k}: {v}')
    L.append(f'  событий {s["events"]}, без времени {s["t_unknown"]}, время с ненадёжным сдвигом TSF '
             f'{s.get("t_cal_unreliable", 0)} (вердикт capture), TX↔RX сопоставлено {s["matched"]} (из них TX с '
             f'испорченной меткой {s["matched_tsf_bad"]}), MCS TX≠RX в парах: {s.get("mcs_tx_ne_rx", 0)}')
    L.append('')
    L.append('=== Правила ===')
    for r in rules:
        d = r.as_dict(c.evs, examples)
        L.append(f'[{d["status"]}] {r.rid} — {d["clause"]}: {r.title}')
        L.append(f'    проверено {d["checked"]}, нарушений {d["violations"]} {d["by_verdict"] or ""}')
        if len(d['by_kind']) > 1:
            for k, n in d['by_kind'].items():
                L.append(f'    — {n}: {k}')
        for why, n in d['unchecked'].items():
            L.append(f'    не проверяемо ({n}): {why}')
        for k, v in d['info'].items():
            L.append(f'    {k}: {v}')
        if d['note']:
            L.append(f'    примечание: {d["note"]}')
        for x in d['examples']:
            L.append(f'      пример [{x["verdict"]}] {x["event"]}')
            L.append(f'               {x["msg"]}')
    L.append('')
    L.append('=== Не проверяемо по этому захвату ===')
    for rid, cl, why in NOT_CHECKABLE:
        L.append(f'  {rid} ({cl}): {why}')
    return '\n'.join(L)


def main(argv=None):
    import argparse
    ap = argparse.ArgumentParser(description='судья эталонной модели над pcap сниффера узлов')
    ap.add_argument('pcap', nargs='+', help='файл[:метка], 1 или 2 узла')
    ap.add_argument('--ref', help='опорный узел (метка)')
    ap.add_argument('--examples', type=int, default=5)
    ap.add_argument('--json', help='записать итог в JSON')
    ap.add_argument('--edca-from', metavar='PCAP', help='EDCA Parameter Set (AIFSN, лимит TXOP) из Association/Probe '
                    'Response точки в другом захвате того же образа (если в этом ассоциации нет)')
    a = ap.parse_args(argv)
    air = AP.load(a.pcap, a.ref)
    edca = None
    if a.edca_from:
        other = AP.load([a.edca_from])
        p, src = edca_from(other.events, air.ap or other.ap)
        edca = (p, f'{src} в {os.path.basename(a.edca_from)}') if p else None
    c, rules = judge(air, edca=edca)
    print(report(air, rules, c, a.examples))
    if a.json:
        with open(a.json, 'w') as f:
            json.dump(dict(stats=dict(air.stats), calib=air.cal.stats, rules=[r.as_dict(c.evs, a.examples)
                                                                              for r in rules],
                           not_checkable=NOT_CHECKABLE), f, ensure_ascii=False, indent=1, default=str)
    return 0


if __name__ == '__main__':
    sys.exit(main())
