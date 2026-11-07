# SPDX-License-Identifier: AGPL-3.0-or-later
"""Дискретно-событийное модельное время ядра: мкс точными дробями (Fraction).

Порядок событий в один момент — по приоритету, затем по порядку постановки:
  P_END  — окончания (конец PPDU у передатчика и у приёмников: PHY-TXEND.confirm, PHY-RXEND.indication, PHY-CCA IDLE);
  P_START — начала (начало PPDU на эфире и у приёмников: PHY-CCA BUSY);
  P_MAC  — таймеры MAC (границы слотов, SIFS-ответы, TBTT).
Так в один момент MAC сначала узнаёт о конце и начале занятости среды, а потом принимает решение (10.3.7: решение о
передаче на границе слота принимается по состоянию CCA на эту границу)."""
import heapq
from fractions import Fraction as Fr

P_END, P_START, P_MAC = 0, 1, 2


class Event:
    __slots__ = ('t', 'prio', 'n', 'fn', 'args', 'live')

    def __init__(self, t, prio, n, fn, args):
        self.t, self.prio, self.n, self.fn, self.args, self.live = t, prio, n, fn, args, True

    def __lt__(self, o):
        return (self.t, self.prio, self.n) < (o.t, o.prio, o.n)

    def cancel(self):
        self.live = False


class Sim:
    def __init__(self):
        self.now = Fr(0)
        self._q = []
        self._n = 0

    def at(self, t, fn, *args, prio=P_MAC):
        t = Fr(t)
        if t < self.now:
            raise ValueError(f'событие в прошлом: {float(t)} < {float(self.now)} ({fn})')
        self._n += 1
        ev = Event(t, prio, self._n, fn, args)
        heapq.heappush(self._q, ev)
        return ev

    def after(self, dt, fn, *args, prio=P_MAC):
        return self.at(self.now + Fr(dt), fn, *args, prio=prio)

    def run(self, until):
        """Выполнить события с t ≤ until; модельное время останавливается на until."""
        until = Fr(until)
        while self._q and self._q[0].t <= until:
            ev = heapq.heappop(self._q)
            if not ev.live:
                continue
            self.now = ev.t
            ev.fn(*ev.args)
        self.now = max(self.now, until)

    def run_while(self, cond, until):
        """Выполнять, пока cond() истинно и t ≤ until; → True, если условие перестало выполняться."""
        until = Fr(until)
        while self._q and self._q[0].t <= until:
            if not cond():
                return True
            ev = heapq.heappop(self._q)
            if not ev.live:
                continue
            self.now = ev.t
            ev.fn(*ev.args)
        return not cond()
