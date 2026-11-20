# SPDX-License-Identifier: AGPL-3.0-or-later
"""SLS в DTI при одновременном доступе двух инициаторов (802.11-2020 10.42.2, 10.42.6.2, 10.23.2). Два узла на прошивке
(fw + uc, точка и станция) в air.Air, сценарий выгрузки test_fw_ap_uplink. После ассоциации оба ставят BF друг с
другом; отсрочку внутренней очереди (ISS) обоих узлов тест сводит в один такт (_Align) — «оба выбрали один слот»
(10.23.2.4): ISS сталкиваются (H-COLL: во время своей передачи кадр не принимается), дальше — повторы.

Эмулятор 2026-11-11 (до исправления): станция после столкновения повторяла свою ISS раньше точки, точка её не слышала
(счётчик PPDU uc отстал во время своей развёртки, rx_flow_run отбрасывает следующие кадры — ветка 0xeeee04); потом
точка начинала свою ISS, пока станция ждала RSS, станция принимала её конец (txss_end_ind) за конец RSS и слала
SSW-Feedback 9 раз без SSW-Ack; цикл повторялся, данных не было (docs/MAC-STAND.md «Столкновение ISS двух
инициаторов»).

Судьи — по кадрам в эфире (байты 16..18 SSW: б0 Direction, б1..9 CDOWN, 9.5.1):
- SSW-Feedback — только после RSS (10.42.2.1, 10.42.6.2): последний SSW пира перед ним — Direction 1, CDOWN 0, RA — мы;
- ISS пира нам без наложения своих передач — ответ RSS (Direction 1, RA — инициатор) через MBIFS после её конца
  (10.42.6.2; «A responder never begins an ISS», 10.42.2.2.1) — и когда своя ISS уже ушла и ждёт RSS: её пир не
  услышал (он сам начал SLS), ответчик — мы;
- ISS без RSS — повтор только после backoff_event своего узла, взведённого после неё (процедура отсрочки CBAP, 10.23.2.2
  b/10.23.2.4: новый случайный счётчик), и ISS начинается вскоре после события — доступ по нему, не по таймеру;
- SLS завершается (SSW-Feedback → SSW-Ack через MBIFS), затем данные станции идут (как test_fw_ap_uplink).

Что эмулятор не видит: ГПСЧ отсрочки MAC (у модели — свой генератор на узел, H-BACKOFF; затравка железа 0xc0adc0ad
одинакова у всех узлов — HW_MAC_EDCA_SEED, гипотеза), CW внутренней очереди и задержку доступа железа."""
import pytest

import fwflows as F

FC_SSW, FC_SSW_FB, FC_SSW_ACK = 0x0864, 0x0964, 0x0a64
MBIFS_US = 9.0                       # 3 × aSIFSTime (10.3.2.3.10, Table 20-30)
IFS_TOL_US = 0.49                    # допуск DMG IFS (10.3.2.3.3: +10 % × (aSlotTime − aAirPropagationTime))
SWEEP_GAP_US = 20.0                  # кадры одной развёртки — через SBIFS (1 мкс; при столкновении uc ждёт CCA между ними)
ACCESS_US = 40.0                     # backoff_event → первый SSW ISS (путь uc: L1, BF, план развёртки, CCA)
CLK = 165


def _ssw(f):
    v = int.from_bytes(f[16:19], 'little')
    return v & 1, (v >> 1) & 0x1ff


def _fc(f):
    return int.from_bytes(f[:2], 'little')


class _Align:
    """Отсрочка внутренней очереди (0x1f, набор 8 — ISS, H-QSEL) обоих узлов: в k-й раз, когда она взведена у обоих
    сразу, оба события — в такт позднего; plan[k] — сдвиг точки, мкс (> 0 — точка позже, < 0 — станция позже, 0 —
    один такт). Включается после записи пира в таблицы fw обоих узлов (до этого — BF подключения станции)."""

    def __init__(self, ap, sta, plan):
        self.ap, self.sta, self.plan = ap, sta, list(plan)
        self.k = 0
        self.armed = False
        self.pend = {}
        self.ours = set()
        self.log = []
        for n in (ap, sta):
            n.hw._backoff_kick = self._wrap(n, n.hw._backoff_kick)

    def _wrap(self, n, orig):
        def kick():
            orig()
            ev = n.hw.backoff_ev
            if self.k >= len(self.plan) or ev is None or n.hw._qsel() != (0x1f, 8):
                return
            if not self.armed:
                if F.Fw(self.ap.fw).cid_of(self.sta.mac) is None or F.Fw(self.sta.fw).cid_of(self.ap.mac) is None:
                    return
                self.armed = True
            self.pend[id(n)] = (n, ev)
            ps = [(m, e) for m, e in self.pend.values() if not e.dead and m.hw.backoff_ev is e and id(e) not in self.ours]
            if len(ps) < 2:
                return
            d = self.plan[self.k]
            self.k += 1
            self.pend = {}
            t = max(e.t for _, e in ps)
            for m, e in ps:
                m.hw.cancel(e)
                late = (m is self.ap and d > 0) or (m is self.sta and d < 0)
                m.hw.backoff_ev = m.hw.at(t + (int(abs(d) * CLK) if late else 0), m.hw._backoff_fire, 'backoff')
                self.ours.add(id(m.hw.backoff_ev))
            self.log.append((t, d))
        return kick


class _DropSweep:
    """Air.drop: первые n кадров SSW станции с Direction 0 после включения _Align не принимает никто (её ISS до точки
    не дошла — потеря в эфире, точка ничего не слышит)."""

    def __init__(self, al, sta, n):
        self.al, self.sta, self.n = al, sta, n

    def __call__(self, src, frame, rec):
        if src is self.sta and self.al.armed and self.n > 0 and _fc(frame) == FC_SSW and not frame[16] & 1:
            self.n -= 1
            return True
        return False


def _sweeps(frames):
    """Развёртки SSW: подряд идущие SSW одного узла с одним Direction, CDOWN убывает, промежуток ≤ SWEEP_GAP_US;
    lost — в ней есть кадр, потерянный в эфире (Air.drop)."""
    out = []
    for f in frames:
        if _fc(f['frame']) != FC_SSW:
            continue
        d, cd = _ssw(f['frame'])
        last = next((x for x in reversed(out) if x['src'] is f['src']), None)      # у столкновения кадры вперемешку
        if last is not None and last['dir'] != d:
            last = None
        if last and cd < last['cdown'][-1] and f['start'] - last['end'] <= SWEEP_GAP_US * CLK:
            last['frames'].append(f)
            last['cdown'].append(cd)
            last['end'] = f['end']
            last['lost'] |= bool(f.get('dropped'))
            continue
        out.append(dict(src=f['src'], dir=d, ra=bytes(f['frame'][4:10]), start=f['start'], end=f['end'], frames=[f],
                        cdown=[cd], lost=bool(f.get('dropped'))))
    return out


def _overlaps(frames, node, t0, t1):
    return [f for f in frames if f['src'] is node and f['start'] < t1 and f['end'] > t0]


SCENARIOS = {
    # начала ISS обоих в одном такте (сдвиг событий отсрочки — на разницу путей доступа, _access); повторы — как
    # выпадет отсрочка модели
    'collide': dict(plan=[0], iss=True),
    # начала ISS обоих в одном такте; повтор станции раньше точки на 40 мкс (точка — ответчик после своей неудачной ISS)
    'collide-sta-first': dict(plan=[0, 40], iss=True),
    # начала ISS обоих в одном такте; повтор точки раньше станции на 40 мкс (станция — ответчик после своей неудачной ISS)
    'collide-ap-first': dict(plan=[0, -40], iss=True),
    # ISS станции не дошла до точки; ISS точки — через 600 мкс, пока станция ждёт RSS: станция уступает, она ответчик
    'peer-iss-in-rss-wait': dict(plan=[600], drop=32),
}


@pytest.fixture(scope='module')
def runs():
    return {}


def _access(runs, fw_elf, build_dir, uc_fw):
    """Пути доступа «backoff_event ISS → первый SSW ISS» точки и станции, мкс: пробные прогоны, в которых пир узла
    отложен на 300 мкс (узел начинает ISS один). Пути разные (план развёртки, повторный взвод отсрочки у точки —
    bf_pause_sta_tx, MAC-STAND «Столкновение ISS двух инициаторов») и меняются с кодом пути — сводить в один такт
    нужно начала ISS, а не события отсрочки."""
    if 'access' not in runs:
        from test_fw_ap_uplink import _run
        out = {}
        for who, d in (('ap', -300), ('sta', 300)):
            st = {}

            def prep(ap, s, air, d=d, st=st):
                st['al'] = _Align(ap, s, [d])
            r = _run(fw_elf, build_dir, uc_fw, prep=prep)
            t = st['al'].log[0][0]
            node = r['ap'] if who == 'ap' else r['sta']
            x = next(x for x in _sweeps(r['air'].frames) if x['src'] is node and x['dir'] == 0 and x['start'] >= t)
            out[who] = (x['start'] - t) / CLK
        runs['access'] = out
    return runs['access']


def _get(runs, name, fw_elf, build_dir, uc_fw):
    if name not in runs:
        from test_fw_ap_uplink import _run
        sc = dict(SCENARIOS[name])
        if sc.get('iss'):
            acc = _access(runs, fw_elf, build_dir, uc_fw)
            sc['plan'] = [p - (acc['ap'] - acc['sta']) for p in sc['plan']]
        st = {}

        def prep(ap, s, air):
            st['al'] = _Align(ap, s, sc['plan'])
            for n in (ap, s):
                n.hw.backoff_log = []
            if sc.get('drop'):
                air.drop = _DropSweep(st['al'], s, sc['drop'])
        r = _run(fw_elf, build_dir, uc_fw, prep=prep)
        r['align'] = st['al']
        runs[name] = r
    return runs[name]


@pytest.mark.parametrize('name', list(SCENARIOS))
def test_sls_collision(runs, fw_elf, build_dir, uc_fw, name):
    r = _get(runs, name, fw_elf, build_dir, uc_fw)
    ap, s, air, al = r['ap'], r['sta'], r['air'], r['align']
    fr = air.frames
    peer = {id(ap): s, id(s): ap}
    who = lambda n: 'точка' if n is ap else 'станция'
    us = lambda t: '%.1f мкс' % (t / CLK)
    assert al.k == len(al.plan), 'сценарий доступа применён %d из %d раз' % (al.k, len(al.plan))
    sw = _sweeps(fr)
    t_al = al.log[0][0]
    iss = [x for x in sw if x['dir'] == 0 and x['start'] >= t_al]
    assert iss, 'ISS после сведения отсрочек нет'
    if name.startswith('collide'):
        a, b = iss[0], next((x for x in iss[1:] if x['src'] is not iss[0]['src']), None)
        assert b is not None and b['start'] < a['end'], 'столкновения ISS нет: %s' % [(who(x['src']), us(x['start']))
                                                                                     for x in iss[:3]]

    # 1) SSW-Feedback — только после RSS пира нам
    for i, f in enumerate(fr):
        if _fc(f['frame']) != FC_SSW_FB:
            continue
        p = peer[id(f['src'])]
        prev = [g for g in fr[:i] if g['src'] is p and _fc(g['frame']) == FC_SSW]
        assert prev, 'SSW-Feedback %s @%s без SSW пира' % (who(f['src']), us(f['start']))
        g = prev[-1]
        d, cd = _ssw(g['frame'])
        assert d == 1 and cd == 0 and bytes(g['frame'][4:10]) == bytes(f['src'].mac), \
            'SSW-Feedback %s @%s после SSW пира Direction %d CDOWN %d RA %s (не RSS нам, 10.42.6.2)' % (
                who(f['src']), us(f['start']), d, cd, g['frame'][4:10].hex())

    # 2) ISS пира нам без наложения своих передач — RSS через MBIFS
    for x in iss:
        y = peer[id(x['src'])]
        if x['ra'] != bytes(y.mac) or x['cdown'][-1] != 0 or x['lost'] or _overlaps(fr, y, x['start'], x['end']):
            continue                                        # пир её не принял (своя передача, потеря в эфире)
        if x['end'] + 600 * CLK > r['end']:
            continue                                        # кончилась у конца прогона
        rss = next((z for z in sw if z['src'] is y and z['start'] >= x['end']), None)
        assert rss is not None and rss['dir'] == 1 and rss['ra'] == bytes(x['src'].mac), \
            'на ISS %s @%s (%d SSW) нет RSS %s: следующая развёртка %s' % (
                who(x['src']), us(x['start']), len(x['frames']), who(y),
                None if rss is None else 'Direction %d @%s' % (rss['dir'], us(rss['start'])))
        gap = (rss['start'] - x['end']) / CLK
        assert MBIFS_US <= gap <= MBIFS_US + IFS_TOL_US, 'RSS %s через %.2f мкс после ISS (MBIFS %.0f)' % (
            who(y), gap, MBIFS_US)
        assert rss['cdown'][-1] == 0, 'RSS %s оборвалась на CDOWN %d' % (who(y), rss['cdown'][-1])

    # 3) ISS без RSS — повтор через отсрочку своего узла после неё
    for i, x in enumerate(iss):
        y = peer[id(x['src'])]
        ans = next((z for z in sw if z['src'] is y and z['dir'] == 1 and z['start'] >= x['end'] and
                    z['start'] <= x['end'] + (MBIFS_US + 1) * CLK), None)
        if ans is not None:
            continue
        nxt = next((z for z in iss[i + 1:] if z['src'] is x['src']), None)
        if nxt is None:
            continue
        bo = [t for t, q in x['src'].hw.backoff_log if q == (0x1f, 8) and x['end'] <= t <= nxt['start']]
        assert bo, 'повтор ISS %s @%s без backoff_event после неудачной @%s (10.23.2.2)' % (
            who(x['src']), us(nxt['start']), us(x['start']))
        assert (nxt['start'] - bo[-1]) / CLK <= ACCESS_US, \
            'повтор ISS %s @%s через %.1f мкс после backoff_event — не по нему' % (
                who(x['src']), us(nxt['start']), (nxt['start'] - bo[-1]) / CLK)

    # 4) SLS завершён: SSW-Feedback → SSW-Ack через MBIFS; данные идут
    done = []
    for i, f in enumerate(fr):
        if _fc(f['frame']) != FC_SSW_FB or f['start'] < t_al:
            continue
        a = fr[i + 1] if i + 1 < len(fr) else None
        if a is not None and a['src'] is peer[id(f['src'])] and _fc(a['frame']) == FC_SSW_ACK:
            gap = (a['start'] - f['end']) / CLK
            assert MBIFS_US <= gap <= MBIFS_US + IFS_TOL_US, 'SSW-Ack через %.2f мкс' % gap
            done.append(f)
    assert done, 'SLS после столкновения не завершён (SSW-Feedback → SSW-Ack нет)'
    nfb = sum(1 for f in fr if _fc(f['frame']) == FC_SSW_FB and f['start'] >= t_al)
    assert nfb <= 2 * len(done), 'SSW-Feedback %d на %d завершённых SLS' % (nfb, len(done))
    ids = [m for _, m in r['got']]
    assert len(ids) > 64, 'доставлено %d MSDU станции' % len(ids)
    assert ids == list(range(len(ids))), 'MSDU не по порядку или с пропусками'
