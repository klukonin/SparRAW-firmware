# SPDX-License-Identifier: AGPL-3.0-or-later
"""Поддержание направленной связи (beamformed link maintenance) DMG по 802.11-2020 11.27.1 [p. 2355–2356]: согласование
dot11BeamLinkMaintenanceTime полем Beamformed Link Maintenance (9.5.6 [p. 1442], табл. 9-344/9-345; поле — в
SSW-Feedback и SSW-Ack 9.3.1.16/9.3.1.17 [p. 811], элемент BeamLink Maintenance 9.4.2.151), таймер на каждую связь:
установка, остановка (halt) в BTI/A-BFT и в чужих SP/CBAP, истечение; что обязан делать узел после истечения.
Время — Fraction, мкс, моменты «на эфире».

Состав:
  negotiate(blm_a, blm_b)          — табл. 9-345 → dot11BeamLinkMaintenanceTime (мкс) или None («undefined»).
  active_time(t0, t1, halts)       — время счёта таймера на [t0, t1] за вычетом остановок.
  expiry(t_set, dur, halts)        — момент истечения таймера, установленного в t_set.
  SET_RULES / sets_timer(...)      — какие события ставят таймер (11.27.1, по пунктам).
  LinkTimer                        — таймер одной связи: set / value / expired.
  check_blm_log(events, dur, halts)— судья: истечение таймера без восстановления (SLS) — QoS Null «to prevent
                                     expiration» не послан; поле BLM в SSW-Feedback/SSW-Ack — согласование.

Не моделируется: состояние doze (power save у нас удалён намеренно — остановка таймера по doze не нужна, но
параметр есть), выбор приёмной диаграммы (квази-омни после истечения — наблюдаемо только по приёму)."""
from collections import namedtuple
from fractions import Fraction as Fr

from . import fields as F

Violation = namedtuple('Violation', 'idx rule msg')


def negotiate(blm_a, blm_b):
    """Табл. 9-345 по полям Beamformed Link Maintenance двух STA (fields.Blm): dot11BeamLinkMaintenanceTime каждой —
    9.5.6 «BLMU × BLMV» (BLMV = 0 → undefined), результат — fields.blm_negotiate («in no particular order»)."""
    return F.blm_negotiate(blm_a.is_master, F.blm_time(blm_a), blm_b.is_master, F.blm_time(blm_b))


def active_time(t0, t1, halts=()):
    """Время, которое таймер считает на [t0, t1]: длина минус пересечение с остановками halts [(s, e)] («shall be halted
    during the following periods of time: BTI and A-BFT …; SPs and CBAPs in which the STA does not participate; …
    doze state»)."""
    t0, t1 = Fr(t0), Fr(t1)
    if t1 <= t0:
        return Fr(0)
    d = t1 - t0
    for s, e in halts:
        lo, hi = max(t0, Fr(s)), min(t1, Fr(e))
        if hi > lo:
            d -= hi - lo
    return d


def expiry(t_set, dur, halts=()):
    """Момент, когда таймер, установленный в t_set на dur, дойдёт до 0 («shall count down … stopped when it reaches the
    value zero»), с учётом остановок (halts по возрастанию, без пересечений)."""
    t, left = Fr(t_set), Fr(dur)
    for s, e in sorted((Fr(s), Fr(e)) for s, e in halts):
        if e <= t:
            continue
        if s > t:
            run = s - t
            if run >= left:
                return t + left
            left -= run
        t = max(t, e)
    return t + left


# 11.27.1: события установки таймера в dot11BeamLinkMaintenanceTime (ключ — для журнала)
SET_RULES = {
    'bf_complete': 'source и destination «successfully complete the BRP» (или SLS, если BRP пропущен)',
    'ap_rx_ati_resp': 'AP/PCP «receives a response from the non-AP and non-PCP STA during the ATI»',
    'ap_rx_spr': 'AP/PCP «receives an SPR frame as a response to a Poll frame»',
    'sta_rx_ati_req': 'non-AP STA «receives a request from the DMG AP or PCP during the ATI»',
    'sta_rx_poll_grant': 'non-AP STA «receives a Poll or a Grant frame»',
    'init_rx_resp': 'инициатор: «an immediate response or acknowledgment (Ack, BlockAck, DMG CTS, DMG DTS) has been '
                    'received from the recipient»',
    'recip_tx_resp': 'получатель: «after the transmission of the immediate response or acknowledgment (Ack, BlockAck, '
                     'DMG CTS, DMG DTS) has been completed»',
}
RESP_KINDS = ('Ack', 'BlockAck', 'DMG CTS', 'DMG DTS')


def sets_timer(kind, src, dst, me, ap, in_ati=False, after=None):
    """Ставит ли кадр kind src→dst таймер связи узла me (11.27.1). ap — MAC точки; in_ati — кадр в ATI; after — вид
    кадра, на который это ответ (для SPR — Poll). Возвращает ключ SET_RULES или None. Кадр должен быть принят «using the
    beamformed link» — это решает вызывающий."""
    if me not in (src, dst):
        return None
    if kind in RESP_KINDS:
        return 'init_rx_resp' if dst == me else 'recip_tx_resp'
    if me == ap and dst == me:
        if in_ati:
            return 'ap_rx_ati_resp'
        if kind == 'SPR' and after == 'Poll':
            return 'ap_rx_spr'
    if me != ap and src == ap and dst == me:
        if in_ati:
            return 'sta_rx_ati_req'
        if kind in ('Poll', 'Grant'):
            return 'sta_rx_poll_grant'
    return None


class LinkTimer:
    """Таймер одной направленной связи (11.27.1: «one beam link maintenance timer per beamformed link»)."""
    def __init__(self, dur, halts=()):
        self.dur, self.halts = (Fr(dur) if dur is not None else None), list(halts)
        self.t_set = None

    @property
    def defined(self):
        return self.dur is not None

    def set(self, t):
        if self.defined:
            self.t_set = Fr(t)

    def value(self, t):
        if not self.defined or self.t_set is None:
            return None
        return max(Fr(0), self.dur - active_time(self.t_set, t, self.halts))

    def expired(self, t):
        v = self.value(t)
        return v is not None and v == 0

    def expires_at(self):
        return None if self.t_set is None else expiry(self.t_set, self.dur, self.halts)


# судья ---------------------------------------------------------------------------------------------------------------
LogEv = namedtuple('LogEv', 't te kind src dst', defaults=())


def check_blm_log(events, a, b, dur, halts=(), bf_kinds=('SSW-Ack',)):
    """Журнал связи a↔b по времени (LogEv); dur — согласованное dot11BeamLinkMaintenanceTime (None — не определено:
    таймера нет, нарушений нет). Таймер ставят: конец SLS/BRP (кадр из bf_kinds), немедленные ответы Ack/BlockAck/DMG
    CTS/DMG DTS между a и b (11.27.1). Нарушение 'blm_expired' — таймер истёк, а следующий кадр пары — не начало
    восстановления ISS (SSW): «To prevent expiration of the beam link maintenance timer when a DMG STA does not have
    MSDUs to send, the STA shall transmit QoS Null frames» (обмен после истечения — уже без поддержания связи).
    Возвращает (нарушения, сводка {'sets': n, 'expired': m, 'max_gap_us': …})."""
    out = []
    if dur is None:
        return out, dict(sets=0, expired=0, defined=False)
    tm = LinkTimer(dur, halts)
    sets, exp, gaps = 0, 0, []
    for i, e in enumerate(events):
        if {e.src, e.dst} != {a, b}:
            continue
        if tm.t_set is not None:
            x = tm.expires_at()
            if e.t > x and e.kind != 'SSW':
                exp += 1
                out.append(Violation(i, 'blm_expired', f'таймер связи {a}↔{b} истёк в {float(x):.1f} (установлен '
                                                       f'{float(tm.t_set):.1f}, {float(dur)} мкс), следующий кадр '
                                                       f'{e.kind} — не SSW восстановления (11.27.1)'))
            gaps.append(active_time(tm.t_set, e.t, halts))
        if e.kind in RESP_KINDS or e.kind in bf_kinds:
            tm.set(e.te)
            sets += 1
    return out, dict(sets=sets, expired=exp, defined=True,
                     max_gap_us=float(max(gaps)) if gaps else None)
