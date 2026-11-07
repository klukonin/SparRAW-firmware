# SPDX-License-Identifier: AGPL-3.0-or-later
"""Защищённый период DMG в SP по 802.11-2020 10.39.6.6 [p. 1888–1894] (10.39.6.6.1, .2, .5, .6; CMMG/CDMG — вне
охвата): когда период обязателен (ECAPC Policy Enforced + Protected Period Enforced), режим прослушивания (не меньше
aDMGPPMinListeningTime = 150 мкс, табл. 11-22), RTS источника SP только внутри SP, при нулевых NAV и с Duration не
дальше конца SP, ответ получателя через SIFS: DMG CTS (прослушивание ≥ aDMGPPMinListeningTime и все NAV = 0), иначе —
нет ответа или DMG DTS (Duration = наибольший NAV − TXTIME(DTS), NAV-SA/NAV-DA — пара этого NAV; при коротком
прослушивании — недостающее время до aDMGPPMinListeningTime, NAV-SA = NAV-DA = свой адрес), DTS без RTS — после
aRTSTimeoutTime от начала SP, целиком в SP; повторные RTS — каждые aDMGPPMinListeningTime − aRTSTimeoutTime;
использование SP после обнуления NAV; сброс NAV_DTSCANCELABLE источником по концу SP (10.39.6.6.5); отчёт о помехах —
DMG ADDTS Request с Constraint по событиям NAV a)–c) (10.39.6.6.6; кодирование — tspec).

aRTSTimeoutTime = TXTIME(RTS) + aAirPropagationTime + aRxPHYDelay + aMACProcessingDelay (табл. 11-22); aRxPHYDelay и
aMACProcessingDelay DMG не заданы числом.
СПОРНО → принято (PLAN.md №69): aRxPHYDelay + aMACProcessingDelay ∈ [0, aSIFSTime] (10.3.7: aSIFSTime = aRxPHYDelay +
aMACProcessingDelay + aRxTxTurnaroundTime) — генератор берёт верхнюю оценку (DTS не раньше), судья — нижнюю.
СПОРНО → принято (PLAN.md №70): TSCONST Period отчёта о помехах = 0 (10.39.6.6.6 «set to 0 indicating that the field is
not applicable»), хотя по табл. 9-262 значение 0/0 — Reserved («not periodic» — B15 = 1); частное правило 10.39.6.6.6
сильнее. Ссылка 10.39.6.6.6 на «DMG ADDTS Request frame variant (9.6.3.3.2)» — опечатка, 9.6.3.2.2.
Не моделируется: антенная конфигурация (та же, что у RTS/CTS — запись PMC её не несёт), CMMG-полосы."""
from collections import namedtuple

from . import duration as D
from .timing import SIFS, aAirPropagationTime, aDMGPPMinListeningTime, aSIFSTime

T_RTS = D.tx('rts')                                      # 10.6.7.1: RTS/DMG CTS/DMG DTS — DMG Control mode
T_DTS = D.tx('dmg_dts')


def rts_timeout(upper=True):
    """aRTSTimeoutTime (табл. 11-22); PLAN.md №69: верхняя оценка — + aSIFSTime, нижняя — + 0."""
    return T_RTS + aAirPropagationTime + (aSIFSTime if upper else 0)


def must_create(is_ap, ecapc_policy_enforced, protected_period_enforced):
    """10.39.6.6.1: обязателен, если в последнем DMG Beacon (своём — для AP/PCP, точки — для STA) ECAPC Policy
    Enforced = 1 и в последнем ECAPC Policy элементе Protected Period Enforced = 1."""
    return bool(ecapc_policy_enforced and protected_period_enforced)


def rts_refresh_interval(upper=True):
    """10.39.6.6.2: повторный RTS — в конце каждого (aDMGPPMinListeningTime − aRTSTimeoutTime)."""
    return aDMGPPMinListeningTime - rts_timeout(upper)


Sp = namedtuple('Sp', 'start end src dst')               # src/dst — MAC источника и получателя SP
Nav = namedtuple('Nav', 'end sa da cancelable')          # один NAV (10.39.10): конец, NAVSRC/NAVDST, DTS-сбрасываемый


class PpStation:
    """DMG STA — источник или получатель SP с защищённым периодом. listen_from — момент перехода в прослушивание
    (None — не слушает); navs — [Nav]."""

    def __init__(self, mac):
        self.mac = mac
        self.listen_from = None
        self.navs = []
        self.rts_seen = False

    def listen(self, t):
        if self.listen_from is None:
            self.listen_from = t

    def stop_listen(self):
        self.listen_from = None

    def listened(self, t):
        return 0 if self.listen_from is None else t - self.listen_from

    def nav_max(self, t):
        live = [n for n in self.navs if n.end > t]
        return max(live, key=lambda n: n.end) if live else None

    def navs_zero(self, t):
        return self.nav_max(t) is None

    # ---- источник
    def may_send_rts(self, t, sp):
        """10.39.6.6.2: прослушивание ≥ aDMGPPMinListeningTime до попытки, все NAV = 0, RTS целиком в SP."""
        if self.mac != sp.src:
            return False, 'RTS защищённого периода шлёт источник SP'
        if not sp.start <= t or t + T_RTS > sp.end:
            return False, 'RTS вне SP (10.39.6.6.2: «shall not transmit the RTS frame outside of the SP»)'
        if self.listened(t) < aDMGPPMinListeningTime:
            return False, (f'прослушивание {self.listened(t)} < aDMGPPMinListeningTime (10.39.6.6.2)')
        if not self.navs_zero(t):
            return False, 'NAV ≠ 0 (10.39.6.6.2: «shall not issue an RTS frame … if any of its NAVs is not equal to 0»)'
        return True, ''

    def rts_duration(self, t, sp):
        """Duration RTS — не дальше конца SP: остаток SP после конца RTS (10.39.6.6.2), целые мкс вниз — не больше
        остатка."""
        return int(sp.end - (t + T_RTS))

    def sp_use_from(self, sp):
        """10.39.6.6.1: NAV = 0 в начале SP — с начала; иначе — с момента, когда все NAV обнулились (если внутри SP)."""
        n = self.nav_max(sp.start)
        if n is None:
            return sp.start
        return n.end if n.end < sp.end else None

    # ---- получатель
    def on_rts(self, t_rx_start, t_rx_end, ta, sp):
        """Ответ получателя SP на RTS источника → (вид, Duration, NAV-SA, NAV-DA, момент TX) или None."""
        if self.mac != sp.dst or ta != sp.src or not sp.start <= t_rx_start < sp.end:
            return None
        self.rts_seen = True
        t_tx = t_rx_end + SIFS                                      # «a SIFS after the end of the received RTS»
        lst = self.listened(t_rx_start)
        n = self.nav_max(t_rx_start)
        if lst >= aDMGPPMinListeningTime and n is None:
            return 'DMG CTS', None, None, None, t_tx
        if n is not None:
            # «may respond with a DMG DTS» — Duration = наибольший NAV − TXTIME(DTS) на начало передачи DTS
            # (duration.duration_dts, вариант 10.39.6.6.2; не дальше остатка SP — 9.3.1.14)
            if t_tx + T_DTS > sp.end or n.end - t_tx < T_DTS:
                return None
            dur = D.duration_dts(n.end - t_tx, sp.end - t_tx - T_DTS, variant='10.39.6.6.2')
            return 'DMG DTS', dur, n.sa, n.da, t_tx
        # прослушивание короче: «shall include the difference of aDMGPPMinListeningTime and the elapsed time»
        if t_tx + T_DTS > sp.end:
            return None
        return 'DMG DTS', D.duration_dts_listening_min(self.listened(t_tx)), self.mac, self.mac, t_tx

    def may_send_dts(self, t, sp, upper=True):
        """10.39.6.6.2: DTS без RTS — после aRTSTimeoutTime от начала SP, NAV ≠ 0, RTS от источника не было,
        прослушивание ≥ aDMGPPMinListeningTime непосредственно до DTS, DTS целиком в SP."""
        if self.mac != sp.dst:
            return False, 'DTS шлёт получатель SP'
        if t < sp.start + rts_timeout(upper):
            return False, 'DTS раньше aRTSTimeoutTime от начала SP (10.39.6.6.2)'
        if self.rts_seen:
            return False, 'RTS источника уже был (10.39.6.6.2: «no RTS has been received»)'
        if self.navs_zero(t):
            return False, 'все NAV = 0 (10.39.6.6.2: «if any of its NAVs has a nonzero value»)'
        if self.listened(t) < aDMGPPMinListeningTime:
            return False, 'прослушивание < aDMGPPMinListeningTime перед DTS (10.39.6.6.2)'
        if t + T_DTS > sp.end:
            return False, 'DTS выходит за конец SP (10.39.6.6.2)'
        return True, ''

    def dts_fields(self, t):
        """Duration и NAV-SA/NAV-DA DTS по наибольшему NAV на начало передачи (10.39.6.6.2)."""
        n = self.nav_max(t)
        return D.duration_dts(n.end - t, 10 ** 9, variant='10.39.6.6.2'), n.sa, n.da

    def sp_end(self, sp):
        """10.39.6.6.5: источник по концу SP может сбросить NAV с NAV_DTSCANCELABLE = true."""
        if self.mac == sp.src:
            self.navs = [n for n in self.navs if not n.cancelable]


# ---------------------------------------------------------------------------------------------------- проверки
def check_rts(t, dur, ta, sp, listened=None, navs_zero=None, tol=0):
    """Нарушения RTS для защищённого периода (по записи эфира). listened/navs_zero — если известны."""
    v = []
    if ta != sp.src:
        return v                               # RTS не источника SP — не защищённый период этого SP
    if t < sp.start - tol or t + T_RTS > sp.end + tol:
        v.append('RTS защищённого периода вне SP (10.39.6.6.2)')
    elif dur is not None and t + T_RTS + dur > sp.end + tol + 1:
        v.append(f'Duration RTS {dur} мкс за концом SP на {float(t + T_RTS + dur - sp.end):.1f} мкс (10.39.6.6.2: '
                 f'«shall not exceed the duration of the portion of the SP that remains»)')
    if listened is not None and listened < aDMGPPMinListeningTime:
        v.append('RTS без прослушивания aDMGPPMinListeningTime (10.39.6.6.2)')
    if navs_zero is False:
        v.append('RTS при ненулевом NAV (10.39.6.6.2)')
    return v


def check_dts(t, dur, ta, sp, rts_end=None, nav_end=None, nav_pair=None, nav_sa=None, nav_da=None, tol=0):
    """Нарушения DMG DTS получателя SP. rts_end — конец RTS, на который это ответ (None — DTS без RTS); nav_end —
    конец наибольшего NAV получателя (если известен)."""
    v = []
    if ta != sp.dst:
        v.append('DMG DTS не от получателя SP (10.39.6.6.2)')
    if t < sp.start or t + T_DTS > sp.end + tol:
        v.append('DMG DTS (частично) вне SP (10.39.6.6.2: «shall not transmit a DMG DTS frame if any portion … '
                 'outside of the SP»)')
    if rts_end is None and t < sp.start + rts_timeout(upper=False) - tol:
        v.append('DMG DTS без RTS раньше aRTSTimeoutTime от начала SP (10.39.6.6.2)')
    if rts_end is not None and abs(t - (rts_end + SIFS)) > tol + 1:
        v.append(f'DMG DTS на RTS не через SIFS: {float(t - rts_end):.2f} мкс (10.39.6.6.2)')
    if nav_end is not None and dur is not None and abs(dur - (nav_end - t - T_DTS)) > tol + 1:
        v.append(f'Duration DTS {dur} ≠ NAV − TXTIME(DTS) = {float(nav_end - t - T_DTS):.1f} (10.39.6.6.2)')
    if nav_pair is not None and (nav_sa, nav_da) != nav_pair:
        v.append(f'NAV-SA/NAV-DA {nav_sa}/{nav_da} ≠ пары NAV {nav_pair} (10.39.6.6.2)')
    return v


def check_cts_answer(rts_end, cts_t, tol=0):
    """Ответ DMG CTS на RTS защищённого периода — через SIFS (10.39.6.6.2)."""
    if abs(cts_t - (rts_end + SIFS)) > tol + 1:
        return [f'DMG CTS на RTS не через SIFS: {float(cts_t - rts_end):.2f} мкс (10.39.6.6.2)']
    return []


# ---------------------------------------------------------------------------------------------------- отчёт о помехах
NavEvent = namedtuple('NavEvent', 'kind t value navdst')   # kind 'start' | 'extend' | 'truncate'; value — NAV, мкс


def interference_constraints(sp_start, events):
    """10.39.6.6.6: Constraint (start, duration, period, interferer) на каждое событие NAV, пересекающееся с SP:
    a) ненулевой NAV в начале SP — Start = начало SP; b) продление/рост с нуля — момент обновления, Duration = NAV;
    c) обрезка — момент сброса, Duration 0. Period = 0 (PLAN.md №70), Interferer = NAVDST этого NAV."""
    out = []
    for e in events:
        if e.kind == 'start':
            out.append((int(sp_start) % (1 << 32), int(e.value), 0, e.navdst))
        elif e.kind == 'extend':
            out.append((int(e.t) % (1 << 32), int(e.value), 0, e.navdst))
        elif e.kind == 'truncate':
            out.append((int(e.t) % (1 << 32), 0, 0, e.navdst))
        else:
            raise ValueError(f'событие NAV {e.kind}')
    return out
