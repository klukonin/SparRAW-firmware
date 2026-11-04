# SPDX-License-Identifier: AGPL-3.0-or-later
"""NAV DMG STA по 802.11-2020: несколько NAV (10.39.10 [p. 1902–1905]), виртуальный CS при нескольких NAV
(10.3.2.1 [p. 1643]), сброс NAV, обновлённого по RTS (10.3.2.4 [p. 1649], 10.39.10), CF-End (10.39.10), сброс
NAV_DTSCANCELABLE источником SP (10.39.6.6.5 [p. 1894]); правила единого NAV DMG (10.3.2.4 [p. 1648]) — проверка
журнала приёма узла (`check_nav_log`) поверх `cbap.Nav`. Время — Fraction, мкс, моменты «на эфире».

Состав:
  NavFrame                     — принятый кадр: вид, RA, TA, Duration, NAV-SA/NAV-DA (DMG DTS, рис. 9-53).
  MultiNav                     — NAV-таймеры (NAVSRC, NAVDST, NAV_RTSCANCELABLE, NAV_DTSCANCELABLE) и псевдокод
                                 NAV_TIMER_UPDATE буквально; CF-End; дозаполнение нулевого адреса пары; сброс по
                                 NAVTimeout; конец SP.
  single_nav_updates           — 10.3.2.4: обновляет ли кадр единый NAV (RA = свой — нет; DMG CTS с TA = свой — нет).
  check_nav_log(events, me)    — судья: собственные передачи-инициации STA при занятом NAV (10.3.2.1, 10.23.2.4).

Не моделируется: NAV_CHANNEL (CMMG), режим прослушивания SP (10.39.6.6) кроме сброса по концу SP, RID (S1G).

СПОРНО (10.39.10, текст 2020 = 2024): в поиске совпадения ветка «If (received_frame = Ack || NAVSRC(x)=R_DST)» при
NAVSRC(x) = R_DST требует ещё NAVDST(x) = R_DST, и альтернатива «(NAVDST(x)=R_SRC && NAVSRC(x)=R_DST)» (обратная пара)
следующей ветки недостижима: таймер пары (NAVSRC A, NAVDST B), заведённый кадром A→B, кадром B→A (R_DST = A,
R_SRC = B) не находится, и под B→A берётся свободный таймер. Принято: буквально (`literal=True`); `literal=False` —
первая ветка только для Ack (обратная пара совпадает)."""
from collections import namedtuple
from fractions import Fraction as Fr

from .cbap import NAV_TIMEOUT, Nav
from .timing import aMinNAVTimersNumber

NULL = None          # «NULL values for their NAVSRC and NAVDST identifiers» (начальное, 10.39.10)
ZERO = 0             # «R_SRC ← 0» у Ack (10.39.10) — нулевой адрес, отличный от NULL

NavFrame = namedtuple('NavFrame', 'kind ra ta dur nav_sa nav_da', defaults=(None, None, 0, None, None))


class _Timer:
    __slots__ = ('src', 'dst', 'end', 'rts_cancel', 'dts_cancel', 'rts_end', 'rx_after_rts')

    def __init__(self):
        self.src = self.dst = NULL
        self.end = Fr(0)
        self.rts_cancel = self.dts_cancel = False
        self.rts_end, self.rx_after_rts = None, False

    def value(self, t):
        """NAV(x) — остаток счётчика в момент t («counts down until it reaches 0»)."""
        return max(Fr(0), self.end - t)


class MultiNav:
    """Несколько NAV DMG STA (10.39.10). n — число таймеров, не меньше aMinNAVTimersNumber («shall be not less than»);
    псевдокод перебирает x < aMinNAVTimersNumber — при n > aMinNAVTimersNumber берём все n (обобщение).
    sp_source — функция t → MAC источника текущего SP (или None) для «source DMG STA MAC address for current SP»;
    update_dts — «implementation decision to update» по DMG DTS."""
    def __init__(self, addr, n=aMinNAVTimersNumber, sp_source=None, update_dts=False, literal=True):
        assert n >= aMinNAVTimersNumber, '10.39.10: «shall be not less than aMinNAVTimersNumber»'
        self.addr, self.literal = addr, literal
        self.timers = [_Timer() for _ in range(n)]
        self.sp_source = sp_source or (lambda t: None)
        self.update_dts = update_dts

    # ---- виртуальный CS (10.3.2.1) ----
    def busy(self, t):
        """10.3.2.1: «all counters are 0 → idle; when at least one of the counters is nonzero, … busy» (с учётом
        разрешённого сброса RTS-NAV, см. idle_from)."""
        return any(self._idle_from(x) > t for x in self.timers)

    def _idle_from(self, x):
        if x.rts_cancel and x.rts_end is not None and not x.rx_after_rts:
            return min(x.end, x.rts_end + NAV_TIMEOUT)
        return x.end

    def idle_from(self):
        return max((self._idle_from(x) for x in self.timers), default=Fr(0))

    # ---- поиск таймера (псевдокод 10.39.10) ----
    def _match(self, f, r_src, r_dst):
        for i, x in enumerate(self.timers):
            if f.kind == 'Ack' or (self.literal and x.src == r_dst):
                if x.dst == r_dst:
                    return i
            elif ((x.src == r_src and (x.dst == r_dst or x.dst == ZERO)) or (x.src == ZERO and x.dst == r_dst)
                  or (x.dst == r_src and x.src == r_dst)):
                return i
        return -1

    def rx(self, t_end, f):
        """NAV_TIMER_UPDATE(received_frame) по PHY-RXEND кадра f в момент t_end. Возвращает индекс обновлённого
        таймера или None («No change to NAV»)."""
        if f.kind == 'CF-End':
            return self._cf_end(t_end, f)
        self._fill_zero(f)
        upd_opt = f.kind == 'DMG DTS'                                  # «UPDATE_OPTIONAL ← true»
        if not (f.ra != self.addr or upd_opt):
            return None                                                # «No change to NAV»
        if f.kind == 'DMG DTS':
            r_dst, r_src = f.nav_da, f.nav_sa
        elif f.kind == 'Ack':
            r_dst, r_src = f.ra, ZERO
        else:
            r_dst, r_src = f.ra, f.ta
        r_dur = Fr(f.dur)
        n = self._match(f, r_src, r_dst)
        if n < 0:                                                      # «No NAV has been found that matches»
            for i, x in enumerate(self.timers):
                if (x.src is NULL and x.dst is NULL) or x.value(t_end) == 0:
                    x.src, x.dst = r_src, r_dst
                    x.rts_cancel = x.dts_cancel = False
                    x.rts_end, x.rx_after_rts = None, False
                    n = i
                    break
        if n < 0:
            return None
        x = self.timers[n]
        if not upd_opt and r_dur > x.value(t_end):
            x.end = t_end + r_dur
            x.rts_cancel = f.kind == 'RTS'
            x.rts_end, x.rx_after_rts = (t_end, False) if f.kind == 'RTS' else (None, False)
            return n
        if upd_opt and r_dur > x.value(t_end):
            if self.update_dts or (f.ra == self.addr and self.addr == self.sp_source(t_end)):
                x.dts_cancel = True
                x.end = t_end + r_dur
                return n
        return None

    def _cf_end(self, t_end, f):
        """10.39.10: CF-End с RA/TA = NAVSRC/NAVDST «in any order» → NAV = Duration CF-End; при нулевом NAVSRC или
        NAVDST — совпадение второго адреса с RA или TA. Возвращает индекс последнего изменённого таймера."""
        hit = None
        for i, x in enumerate(self.timers):
            pair = {x.src, x.dst}
            if {f.ra, f.ta} == pair and x.src not in (NULL, ZERO) and x.dst not in (NULL, ZERO):
                ok = True
            elif x.src == ZERO and x.dst not in (NULL, ZERO):
                ok = x.dst in (f.ra, f.ta)
            elif x.dst == ZERO and x.src not in (NULL, ZERO):
                ok = x.src in (f.ra, f.ta)
            else:
                ok = False
            if ok:
                x.end = t_end + Fr(f.dur)
                x.rts_cancel, x.rts_end = False, None
                hit = i
        return hit

    def _fill_zero(self, f):
        """10.39.10: «If one of NAVSRC or NAVDST of a NAV is 0 and the nonzero NAVDST or NAVSRC … match either the RA
        or the TA value of a received valid frame, the … that is 0 shall be set to the RA or TA that does not match»."""
        addrs = [a for a in (f.ra, f.ta) if a is not None]
        if len(addrs) < 2:
            return
        for x in self.timers:
            if x.src == ZERO and x.dst not in (NULL, ZERO) and x.dst in addrs:
                x.src = addrs[1] if addrs[0] == x.dst else addrs[0]
            elif x.dst == ZERO and x.src not in (NULL, ZERO) and x.src in addrs:
                x.dst = addrs[1] if addrs[0] == x.src else addrs[0]

    def rx_start(self, t):
        """PHY-RXSTART.indication: «monitor the channel to determine if a PHY-RXSTART.indication primitive is received»
        в течение NAVTimeout после обновления по RTS (10.39.10, NAVTimeout DMG — 10.3.2.4)."""
        for x in self.timers:
            if x.rts_end is not None and t <= x.rts_end + NAV_TIMEOUT:
                x.rx_after_rts = True

    def sp_end(self, t, i_am_source):
        """10.39.6.6.5: по окончании SP «the source DMG STA of that SP may reset any NAV to 0 that has …
        NAV_DTSCANCELABLE with a value of true»."""
        if not i_am_source:
            return
        for x in self.timers:
            if x.dts_cancel:
                x.end = min(x.end, Fr(t))
                x.dts_cancel = False


def single_nav_updates(f, me):
    """10.3.2.4 [p. 1648] для DMG STA с одним NAV: «When the received frame's RA is equal to the STA's own MAC
    address, the STA shall not update its NAV. Further, when the received frame is a DMG CTS frame and its TA is
    equal to the STA's own MAC address, the STA shall not update its NAV.» Остальные — обновляют (если больше)."""
    if f.ra == me:
        return False
    if f.kind == 'DMG CTS' and f.ta == me:
        return False
    return True


# =====================================================================================================================
# судья: передачи STA при занятом NAV
# =====================================================================================================================
LogEv = namedtuple('LogEv', 't te kind ra ta dur tx response', defaults=(False, False))
Violation = namedtuple('Violation', 'idx rule msg')

# Ответы, которые STA передаёт без проверки NAV: Ack/BlockAck (10.3.2.11, 10.25.6: немедленный ответ), DMG CTS на RTS
# от держателя TXOP (10.3.2.9 — «NAV indicates idle» с исключением TXOP holder, проверяется в cbap), ответный CF-End
# (10.23.2.10), SSW-Feedback/SSW-Ack и RSS (ответы SLS, 10.42.2), DMG Beacon в BTI (11.1.3.3.1: TBTT).
RESPONSE_KINDS = ('Ack', 'BlockAck', 'DMG CTS', 'SSW-Ack', 'SSW-Feedback')


def check_nav_log(events, me, multi=False, rts_reset=True):
    """events — журнал эфира узла me по времени: LogEv(t, te, вид, RA, TA, Duration, tx, response). tx=False — кадр
    принят узлом (PHY-RXEND в te), tx=True — передан узлом; response=True — немедленный ответ/продолжение своего TXOP
    (вызывающий решает по последовательности). Нарушение 'nav_busy' — передача-инициация (не ответ) в момент t, когда
    NAV узла занят (10.3.2.1: «when the counter is nonzero, the indication is busy»; 10.23.2.4: EDCAF начинает
    передачу только при свободной среде). multi=True — NAV по 10.39.10 (MultiNav), иначе единый (cbap.Nav)."""
    nav = MultiNav(me) if multi else Nav(me, rts_reset=rts_reset)
    out = []
    for i, e in enumerate(events):
        if e.tx:
            if not e.response and nav.busy(e.t):
                out.append(Violation(i, 'nav_busy', f'{e.kind} {me}→{e.ra} начат при занятом NAV (до '
                                                    f'{float(nav.idle_from()):.1f}, 10.3.2.1, 10.3.2.4)'))
            continue
        nav.rx_start(e.t)
        if multi:
            nav.rx(e.te, NavFrame(e.kind, e.ra, e.ta, e.dur or 0))
        else:
            nav.rx(e.te, _CbapFrame(e.kind, e.ta, e.ra, e.dur or 0))
    return out


class _CbapFrame:
    """Минимальный кадр для cbap.Nav.rx (вид, src = TA, dst = RA, dur)."""
    __slots__ = ('kind', 'src', 'dst', 'dur')

    def __init__(self, kind, src, dst, dur):
        self.kind, self.src, self.dst, self.dur = kind, src, dst, dur
