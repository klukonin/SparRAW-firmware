# SPDX-License-Identifier: AGPL-3.0-or-later
"""Эталон поля Duration/ID кадров DMG (802.11-2020 9.2.4.2, 9.2.5, 9.3.1.x, 9.3.4.2, 10.3.2.x, 10.23.2.x, 10.39.x,
10.42) и выбор MCS ответных кадров DMG (10.6.7). Время — Fraction, мкс; значения поля — int.

Точка отсчёта: 9.7.3 NOTE 1 «The reference point for the Duration/ID field is the end of the PPDU carrying the MPDU»
— все «оставшиеся» времена в параметрах отсчитываются от конца PPDU самого кадра, если не сказано иное."""
from fractions import Fraction as Fr
from math import ceil

from . import timing as T
from .timing import aDMGPPMinListeningTime, aTSFResolution, ceil_to, LEN_SSW, LEN_SSW_ACK, LEN_SSW_FB, SIFS_TOL

DUR_MAX = 32767                 # табл. 9-9: «0–32 767 … Bit 15 = 0 … Duration value (in microseconds)»
# aTSFResolution, aDMGPPMinListeningTime (табл. 11-22), SIFS_TOL (10.3.2.3.3), длины SSW-кадров — timing.py

# ---- длины MPDU (октеты, с FCS) по рисункам 9.3.1.x ----
LEN = {
    'rts': 20,          # рис. 9-30: FC 2, Duration 2, RA 6, TA 6, FCS 4
    'ack': 14,          # рис. 9-32: FC 2, Duration 2, RA 6, FCS 4
    'cf_end': 20,       # рис. 9-34
    'bar': 24,          # рис. 9-35 + 9.3.1.7.2: BAR Control 2 + SSC 2 (Compressed)
    'ba': 32,           # рис. 9-41 + 9-43: BA Control 2 + SSC 2 + Bitmap 8 (Compressed)
    'ba_ext': 33,       # рис. 9-45: + RBUFCAP 1 (Extended Compressed)
    'poll': 22,         # рис. 9-49: … Response Offset 2
    'spr': 27,          # рис. 9-50: Dynamic Allocation Info 5 + BF Control 2
    'grant': 27,        # рис. 9-51
    'dmg_cts': 20,      # рис. 9-52: FC, Duration, RA, TA, FCS
    'dmg_dts': 26,      # рис. 9-53: RA, NAV-SA, NAV-DA
    'ssw': LEN_SSW,     # рис. 9-54: SSW 3 + SSW Feedback 3 (= 26, timing.py)
    'ssw_fb': LEN_SSW_FB,   # рис. 9-55: SSW Feedback 3 + BRP Request 4 + BLM 1 (= 28)
    'ssw_ack': LEN_SSW_ACK,     # рис. 9-56 (= 28)
    'grant_ack': 27,    # рис. 9-57: Reserved 5 + BF Control 2
}

# 10.6.7.1: «DMG Beacon, SSW-Feedback, SSW-Ack, RTS, DMG CTS, DMG CTS-to-self, DMG DTS, CF-End, Grant, SPR, Poll
# … shall be transmitted using the DMG Control modulation class»; SSW — тоже control (кроме RXSS с RXSSTxRate)
CONTROL_ONLY = frozenset({'dmg_beacon', 'ssw_fb', 'ssw_ack', 'rts', 'dmg_cts', 'dmg_cts_to_self', 'dmg_dts', 'cf_end',
                          'grant', 'spr', 'poll', 'ssw'})


def tx(kind):
    """TXTIME кадра управления DMG с обязательной модуляцией control (10.6.7.1), MCS 0."""
    return T.txtime_control(LEN[kind])


# ---- 9.2.4.2 / 9.2.5.1: кодирование ----
class DurationOverflow(ValueError):
    """Длительность > 32 767 мкс не кодируется (табл. 9-9); стандарт не задаёт поведение — см. field(overflow=)."""


def field(t, overflow='error'):
    """9.2.5.1: «If a calculated duration includes a fractional microsecond, … rounded up to the next higher integer.
    If a calculated duration results in a negative value, the Duration/ID field is 0.»
    overflow — стандарт молчит о t > 32 767: 'error' (по умолчанию, ошибка модели) или 'clamp' (до 32 767)."""
    t = Fr(t)
    if t < 0:
        return 0
    v = ceil(t)
    if v > DUR_MAX:
        if overflow == 'clamp':
            return DUR_MAX
        raise DurationOverflow(f'{v} мкс > {DUR_MAX}')
    return v


def decode(value):
    """Табл. 9-9: ('duration', мкс) | ('aid', AID) | ('reserved', value). DMG — не S1G: AID 0 и 2008–8191 — резерв."""
    if not 0 <= value <= 0xFFFF:
        raise ValueError('Duration/ID — 16 бит')
    if not value & 0x8000:
        return ('duration', value)                  # «0–32 767 | — | 0 | Duration value»
    if not value & 0x4000:
        return ('reserved', value)                  # «0–16 383 | 0 | 1 | Reserved»
    aid = value & 0x3FFF
    if 1 <= aid <= 2007:
        return ('aid', aid)                         # «1–2007 | 1 | 1 | AID in PS-Poll frames»
    return ('reserved', value)                      # AID 0 / 2008–8191: только S1G; 8192–16 383: Reserved


# ---- 10.6.7.2: выбор MCS ответа (DMG) ----
# табл. 20-15, «Data rate (Mb/s)», базовые MCS 1..12
SC_RATE = {1: Fr(385), 2: Fr(770), 3: Fr(1925, 2), 4: Fr(1155), 5: Fr(5005, 4), 6: Fr(1540), 7: Fr(1925),
           8: Fr(2310), 9: Fr(5005, 2), 10: Fr(3080), 11: Fr(3850), 12: Fr(4620)}
# 20.6.3.2.x (за табл. 20-15): «Transmit and receive support for MCS 4 and below is mandatory»
SC_MANDATORY = (1, 2, 3, 4)


def response_mcs_set(kind, elicit_mcs, length=None):
    """10.6.7.2 — множество MCS, допустимых для ответа kind на кадр с MCS elicit_mcs (0 — control, 1..12 — SC).
    Ack/BlockAck: на control — «shall use the DMG Control modulation class»; на SC — «from the mandatory MCS set of
    the DMG SC … (a) Data Rate … does not exceed … (b) no other MCS satisfying (a) results in a shorter frame
    transmission time» (при равенстве TXTIME допустимы все — стандарт не выбирает).
    Grant Ack: «DMG Control modulation class or any MCS from the mandatory MCS set of the DMG SC».
    DMG CTS/DTS, SSW-Feedback/Ack и пр. — только MCS 0 (10.6.7.1)."""
    if kind in ('ack', 'ba', 'ba_ext'):
        if elicit_mcs == 0:
            return frozenset({0})
        if elicit_mcs not in SC_RATE:
            # low-power SC (MCS 25–31) — отдельное правило 10.6.7.2, в модели нет
            raise NotImplementedError(f'MCS {elicit_mcs}: только control и SC 1..12')
        length = LEN[kind] if length is None else length
        cand = [m for m in SC_MANDATORY if SC_RATE[m] <= SC_RATE[elicit_mcs]]
        tmin = min(T.txtime_sc(length, m) for m in cand)
        return frozenset(m for m in cand if T.txtime_sc(length, m) == tmin)
    if kind == 'grant_ack':
        return frozenset((0,) + SC_MANDATORY)
    if kind in CONTROL_ONLY:
        return frozenset({0})
    raise ValueError(f'нет правила выбора MCS ответа для {kind}')


def response_txtimes(kind, elicit_mcs, length=None):
    """Множество TXTIME ответа по всем MCS, допустимым 10.6.7.2."""
    length = LEN[kind] if length is None else length
    return frozenset(T.txtime(length, m) for m in response_mcs_set(kind, elicit_mcs, length))


def response_mcs(kind, elicit_mcs, length=None):
    """Один MCS ответа: из допустимых — наибольший (выбор среди равных TXTIME — implementation dependent)."""
    return max(response_mcs_set(kind, elicit_mcs, length))


def response_txtime(kind, elicit_mcs, length=None):
    length = LEN[kind] if length is None else length
    return T.txtime(length, response_mcs(kind, elicit_mcs, length))


# ---- 9.2.5.7 / 9.2.5.8 / 9.3.1.13 / 9.3.1.18: ответы (вычитание из Duration вызвавшего кадра) ----
def duration_response(elicit_duration, resp_txtime, gap=T.SIFS):
    """9.2.5.7/9.2.5.8: «Duration/ID field of the frame that elicited the response minus the time … between the end
    of the PPDU carrying the frame that elicited the response and the end of the PPDU carrying the …» = gap + TXTIME.
    gap — фактический промежуток (номинально SIFS)."""
    return field(Fr(elicit_duration) - gap - resp_txtime)


def duration_ack(elicit_duration, ack_txtime, gap=T.SIFS):
    """9.2.5.7: Ack — Duration вызвавшего кадра минус (промежуток + TXTIME(Ack))."""
    return duration_response(elicit_duration, ack_txtime, gap)


def duration_ba_response(elicit_duration, ba_txtime, gap=T.SIFS):
    """9.2.5.7: BlockAck в ответ на BlockAckReq или неявный запрос — так же, как Ack."""
    return duration_response(elicit_duration, ba_txtime, gap)


def duration_cts_response(rts_duration, cts_txtime=None):
    """9.3.1.13: «Duration field of the immediately previous RTS frame, minus the time … required to transmit the
    DMG CTS frame and its SIFS»; 10.3.2.9: DMG STA отвечает DMG CTS, не CTS."""
    return field(Fr(rts_duration) - T.SIFS - (tx('dmg_cts') if cts_txtime is None else cts_txtime))


def duration_grant_ack(grant_duration, grant_ack_txtime):
    """9.3.1.18: «Duration field of the immediately previous Grant frame minus the time … to transmit the Grant Ack
    frame and its SIFS»."""
    return field(Fr(grant_duration) - T.SIFS - grant_ack_txtime)


# ---- 9.2.5.2 a): одиночная защита (EDCA, QoS STA; все DMG STA — QoS) ----
def duration_rts(pending_txtime, resp_txtime=None, cts_txtime=None):
    """9.2.5.2 a) 1): «pending frame, plus one CTS frame, plus one Ack or BlockAck frame if required, … plus
    applicable IFSs»: RTS|SIFS|DMG CTS|SIFS|pending[|SIFS|resp]. resp_txtime=None — ответа нет."""
    cts = tx('dmg_cts') if cts_txtime is None else cts_txtime
    t = T.SIFS + cts + T.SIFS + pending_txtime
    if resp_txtime is not None:
        t += T.SIFS + resp_txtime
    return field(t)


def duration_data_single(resp_txtime=None, final=True, next_txtime=None, next_resp_txtime=None, gap=T.SIFS):
    """9.2.5.2 a) 5) (с Ack: resp_txtime) / a) 6) (No Ack, Block Ack, Action No Ack, групповые: resp_txtime=None).
    5) i) последний кадр TXOP: «one Ack frame (including appropriate IFSs)» = SIFS + Ack;
       ii) иначе + «the following frame and its response if required, plus applicable IFSs».
    6) i) последний: «0»; ii) иначе «the following frame and its response frame, if required».
    gap — промежуток перед следующим кадром держателя TXOP (10.23.2.8; номинально SIFS)."""
    t = Fr(0)
    if resp_txtime is not None:
        t += T.SIFS + resp_txtime
    if final:
        return field(t)
    if next_txtime is None:
        raise ValueError('не последний кадр TXOP: нужен next_txtime')
    t += gap + next_txtime
    if next_resp_txtime is not None:
        t += T.SIFS + next_resp_txtime
    return field(t)


def duration_bar(resp_txtime):
    """9.2.5.2 a) 3): «one Ack or BlockAck frame, as applicable, plus one SIFS»."""
    return field(T.SIFS + resp_txtime)


def duration_ba_unsolicited(ack_txtime):
    """9.2.5.2 a) 4): BlockAck не в ответ на BAR — «an Ack frame plus a SIFS»."""
    return field(T.SIFS + ack_txtime)


# ---- 9.2.5.2 b): множественная защита ----
def duration_multi_range(t_ppdu, t_txop, t_end_nav=0, t_single_msdu=None, t_pending=None, t_txop_remaining=None):
    """9.2.5.2 b) → (lo, hi) допустимых значений поля:
    1) TTXOP = 0, TEND-NAV = 0: D = TSINGLE-MSDU – TPPDU
    2) TTXOP = 0, TEND-NAV > 0: D = max(0, TEND-NAV – TPPDU)
    3) TEND-NAV = 0: min(TPENDING, TTXOP – TPPDU) ≤ D ≤ TTXOP – TPPDU
    4) иначе: TEND-NAV – TPPDU ≤ D ≤ TTXOP-REMAINING – TPPDU"""
    if t_txop == 0 and t_end_nav == 0:
        d = field(t_single_msdu - t_ppdu)
        return d, d
    if t_txop == 0:
        d = field(max(0, t_end_nav - t_ppdu))
        return d, d
    if t_end_nav == 0:
        # обе границы — вверх: вычисленное D ∈ [lo, hi] попадает в поле как ⌈D⌉ (9.2.5.1)
        return field(min(t_pending, t_txop - t_ppdu)), field(t_txop - t_ppdu)
    return field(t_end_nav - t_ppdu), field(t_txop_remaining - t_ppdu)


# ---- 9.3.1.13: DMG CTS-to-self ----
def duration_cts_to_self(remaining):
    """9.3.1.13: «For DMG CTS-to-self frames, the Duration field is set to the remaining duration of the TXOP or SP»
    (remaining — от конца PPDU, 9.7.3 NOTE 1)."""
    return field(remaining)


# ---- 9.3.1.14 / 10.39.6.6.2: DMG DTS ----
def duration_dts(nav_at_start, sp_remaining_at_end, dts_txtime=None, variant='9.3.1.14'):
    """Неоднозначность стандарта:
    9.3.1.14: «NAV – (TXTIME(DMG DTS) + SIFS) or the remaining time in the SP at the end of the DMG DTS frame
    transmission, whichever is smaller»;
    10.39.6.6.2: «subtracting the DMG DTS frame transmission time from the NAV» (без SIFS; точка конца NAV
    сохраняется). variant='10.39.6.6.2' — без SIFS; ограничение остатком SP (9.3.1.14) применяется в обоих."""
    dts = tx('dmg_dts') if dts_txtime is None else dts_txtime
    sub = dts + (T.SIFS if variant == '9.3.1.14' else 0)
    if variant not in ('9.3.1.14', '10.39.6.6.2'):
        raise ValueError(variant)
    return field(min(Fr(nav_at_start) - sub, Fr(sp_remaining_at_end)))


def duration_dts_listening_min(listening_elapsed):
    """10.39.6.6.2: DTS из‑за неполного прослушивания — Duration «shall include the difference of
    aDMGPPMinListeningTime and the elapsed time» → нижняя граница поля."""
    return field(aDMGPPMinListeningTime - listening_elapsed)


# ---- 9.3.1.6 / 10.23.2.10: CF-End (DMG) ----
def duration_cf_end(i, cf_end_txtime=None):
    """9.3.1.6: «Duration = (i – 1) × (TXTIME(CF-End) + SIFS), where i is in the range 1 to 3 … i=1 corresponds to
    the last CF-End frame in the sequence»."""
    if i not in (1, 2, 3):
        raise ValueError('i ∈ 1..3')
    return field((i - 1) * ((tx('cf_end') if cf_end_txtime is None else cf_end_txtime) + T.SIFS))


def cf_end_nonzero_allowed(remaining, cf_end_txtime=None):
    """10.23.2.10: «shall not send a CF-End frame with a nonzero value … if the remaining duration is shorter than
    2×TCF-End + 2×SIFS»."""
    t = tx('cf_end') if cf_end_txtime is None else cf_end_txtime
    return Fr(remaining) >= 2 * t + 2 * T.SIFS


# ---- 9.3.1.10 / 9.3.1.11 / 10.39.7.2: Poll и SPR ----
# ceil_to (1.5 «Ceil (x, y)») — timing.py


def pp_schedule(poll_txtimes, spr_txtimes, ant_switch=None, oj_spr='j'):
    """10.39.7.2, ур. (10-18): для n Poll → [(Duration_i, ResponseOffset_i)], i = 1..n (SPR j = i, m = n).
    D_i = D_i,n + O_m + Ceil(TXTIME(SPR_m), TTR); D_i,n = Ceil(Σ_{k=i+1..n} TXTIME(Poll_k) + SBIFS + A_k + S, TTR);
    O_1 = SIFS; O_j = O_{j–1} + Ceil(TXTIME(SPR_j) + SIFS, TTR); Response Offset_i = D_i,n + O_j.
    oj_spr='j' — как в тексте (SPR_j); 'j-1' — по смыслу (длина предыдущего SPR); при равных SPR совпадают."""
    n = len(poll_txtimes)
    if len(spr_txtimes) != n:
        raise ValueError('m = n: по SPR на каждый Poll')
    a = list(ant_switch) if ant_switch is not None else [0] * n
    S = T.aSBIFSAccuracy
    o = [None, T.SIFS]                              # O_j, 1‑индексация
    for j in range(2, n + 1):
        spr = spr_txtimes[j - 1] if oj_spr == 'j' else spr_txtimes[j - 2]
        o.append(o[j - 1] + ceil_to(spr + T.SIFS, aTSFResolution))
    out = []
    for i in range(1, n + 1):
        din = ceil_to(sum((poll_txtimes[k - 1] + T.SBIFS + a[k - 1] + S for k in range(i + 1, n + 1)), Fr(0)),
                      aTSFResolution)
        d = din + o[n] + ceil_to(spr_txtimes[n - 1], aTSFResolution)
        out.append((field(d), field(din + o[i])))
    return out


def duration_spr_response(poll_duration, response_offset, spr_txtime=None, variant='10.39.7.2'):
    """Неоднозначность (начало отсчёта Response Offset):
    10.39.7.2: «Duration field contained in the received Poll frame, minus the value of the Response Offset field …
    minus the time taken to transmit the SPR frame» (RO — от конца Poll, O_1 = SIFS);
    9.3.1.11: то же «… minus SIFS, minus …» (9.3.1.10: RO «beginning SIFS after the end of the Poll frame»)."""
    spr = tx('spr') if spr_txtime is None else spr_txtime
    if variant not in ('10.39.7.2', '9.3.1.11'):
        raise ValueError(variant)
    sub = Fr(response_offset) + spr + (T.SIFS if variant == '9.3.1.11' else 0)
    return field(Fr(poll_duration) - sub)


def duration_spr_unsolicited(alloc_remaining=None):
    """9.3.1.11: не в ответ на Poll, в SP или TXOP — «the time left in the allocation excluding the SPR transmission
    time» (alloc_remaining — от конца SPR); «In all other cases, the Duration field is set to 0» (None)."""
    return 0 if alloc_remaining is None else field(alloc_remaining)


# ---- 9.3.1.12 / 10.39.7.3 / 10.39.8.1 / 10.39.9: Grant ----
def duration_grant_gp(remaining):
    """10.39.7.3: «covers the duration of all remaining Grant frame and Grant Ack frame transmissions, if any, plus all
    appropriate IFSs». remaining — [(ifs перед кадром, TXTIME кадра), …] после этого Grant; IFS — по 10.3.2.3
    (Grant Ack — SIFS); хвостовой IFS до начала выделения — implementation dependent: передать (ifs, 0)."""
    return field(sum((Fr(g) + Fr(t) for g, t in remaining), Fr(0)))


def duration_grant_cbap(prev_duration, grant_txtime=None):
    """9.3.1.12: в CBAP (не для получения TXOP) — «Duration field of the immediately preceding frame minus
    TXTIME(Grant frame) minus aSIFSTime»."""
    return field(Fr(prev_duration) - (tx('grant') if grant_txtime is None else grant_txtime) - T.aSIFSTime)


def duration_grant_relinquish(remaining_at_start, grant_txtime=None):
    """10.39.7.3: уступка остатка SP/TXOP — «the time remaining in the SP [TXOP] minus TXTIME (Grant frame) minus
    aSIFSTime» (remaining_at_start — от начала передачи Grant)."""
    return field(Fr(remaining_at_start) - (tx('grant') if grant_txtime is None else grant_txtime) - T.aSIFSTime)


def duration_grant_ext_reply(spr_duration, grant_txtime=None):
    """10.39.9: ответ AP/PCP на SPR-запрос продления (грант или отказ) — «Duration field received in the SPR frame minus
    SIFS and minus the duration of this Grant frame transmission»."""
    return field(Fr(spr_duration) - T.SIFS - (tx('grant') if grant_txtime is None else grant_txtime))


def duration_grant_ext_forward(ap_grant_duration, grant_txtime=None):
    """10.39.9: STA пересылает партнёру — «Duration field of the Grant frame received from the AP or PCP minus the
    duration of this Grant frame transmission minus SIFS»."""
    return field(Fr(ap_grant_duration) - (tx('grant') if grant_txtime is None else grant_txtime) - T.SIFS)


def duration_grant_group(to_alloc_start):
    """9.3.1.12: групповой Grant — «time between PHY-TXEND.indication primitive of the Grant frame and the start of the
    allocation»."""
    return field(to_alloc_start)


def duration_grant_truncation(following):
    """10.39.8.1: широковещательный Grant при усечении SP — «time needed to transmit the Grant frame(s) (… does not
    include duration of that frame) plus SIFS and plus … the following CF-End frame and the response CF-End frame, if
    required and appropriate IFS». following — [(ifs, TXTIME), …] как в duration_grant_gp."""
    return duration_grant_gp(following)


# ---- 9.3.1.15–9.3.1.17 / 10.42: SSW, SSW-Feedback, SSW-Ack ----
def duration_ssw(cdown, ssw_txtime=None, alloc_remaining=None, abft_slot_remaining=None):
    """9.3.1.15: в A-BFT — «time until the end of the current SSW slot» (abft_slot_remaining); иначе — «time until the
    end of the SSW frame transmission that has the CDOWN subfield … equal to 0, plus MBIFS, or until the end of the
    current allocation …, whichever comes first». До CDOWN=0: cdown·(SBIFS + TXTIME(SSW)) (10.42.2.2.2: кадры через
    SBIFS; CDOWN считает и LBIFS = TXTIME(SSW) + 2×SBIFS ровно как одну передачу)."""
    if abft_slot_remaining is not None:
        return field(abft_slot_remaining)
    t = tx('ssw') if ssw_txtime is None else ssw_txtime
    d = cdown * (T.SBIFS + t) + T.MBIFS
    if alloc_remaining is not None:
        d = min(d, Fr(alloc_remaining))
    return field(d)


def duration_ssw_fb(in_abft, brp_requested=False, ssw_ack_txtime=None, alloc_remaining=None):
    """9.3.1.16: A-BFT — 0; DTI: a) BRP запрошен — «SSW-Ack frame plus 2×MBIFS»; b) иначе «SSW-Ack frame, plus MBIFS
    … or the time until the end of the current allocation, whichever comes earlier»."""
    if in_abft:
        return 0
    ack = tx('ssw_ack') if ssw_ack_txtime is None else ssw_ack_txtime
    if brp_requested:
        return field(ack + 2 * T.MBIFS)
    d = ack + T.MBIFS
    if alloc_remaining is not None:
        d = min(d, Fr(alloc_remaining))
    return field(d)


def duration_ssw_ack(fb_duration, ssw_ack_txtime=None):
    """9.3.1.17: «Duration field of the immediately preceding SSW-Feedback frame, minus MBIFS, minus the time required
    to transmit the SSW-Ack frame»."""
    return field(Fr(fb_duration) - T.MBIFS - (tx('ssw_ack') if ssw_ack_txtime is None else ssw_ack_txtime))


# ---- 9.3.4.2: DMG Beacon ----
def duration_dmg_beacon(bti_remaining):
    """9.3.4.2: «The Duration field is set to the time remaining until the end of the beacon transmission interval»."""
    return field(bti_remaining)


def bti_beacon_durations(beacon_txtimes, gap=T.SBIFS):
    """Duration каждого DMG Beacon BTI при допущении, что BTI кончается с концом последнего Beacon (10.3.2.3.10:
    за BTI через MBIFS следует A-BFT); gap — промежуток между Beacon (SBIFS/LBIFS, 10.42.4)."""
    out = []
    for k in range(len(beacon_txtimes)):
        out.append(field(sum((gap + t for t in beacon_txtimes[k + 1:]), Fr(0))))
    return out


# ---- 10.39.3: ATI ----
def duration_ati_request(ati_remaining):
    """10.39.3: «request frame … shall be set to cover the remaining duration of the ATI at the end of the request
    frame transmission»."""
    return field(ati_remaining)


def duration_ati_response(request_duration, resp_txtime):
    """10.39.3: «value of the Duration field within the previously received request frame minus SIFS and minus the
    duration of the response frame transmission»."""
    return field(Fr(request_duration) - T.SIFS - resp_txtime)


# ---- проверка ----
def _resp_values(ctx, kind, elicit_key):
    """Допустимые значения ответа: по всем допустимым TXTIME (10.6.7.2) и промежутку SIFS … SIFS + SIFS_TOL
    (10.3.2.3.3), если контекст их не задаёт."""
    d = ctx[elicit_key]
    if 'txtime' in ctx:
        txs = {Fr(ctx['txtime'])}
    elif 'mcs' in ctx:
        txs = {T.txtime(ctx.get('length', LEN.get(kind, 0)), ctx['mcs'])}
    else:
        txs = response_txtimes(kind, ctx.get('elicit_mcs', 0), ctx.get('length'))
    gaps = [Fr(ctx['gap'])] if 'gap' in ctx else [T.SIFS, T.SIFS + SIFS_TOL]
    vals = [field(Fr(d) - g - t) for t in txs for g in gaps]
    return set(range(min(vals), max(vals) + 1))


def _allowed(kind, c):
    """→ (множество допустимых значений | (lo, hi), пункт)."""
    if kind == 'rts':
        if 'multi' in c:
            return duration_multi_range(**c['multi']), '9.2.5.2 b)'
        return {duration_rts(c['pending_txtime'], c.get('resp_txtime'), c.get('cts_txtime'))}, '9.2.5.2 a) 1)'
    if kind == 'dmg_cts':
        return _resp_values(c, 'dmg_cts', 'rts_duration'), '9.3.1.13'
    if kind == 'dmg_cts_to_self':
        return {duration_cts_to_self(c['remaining'])}, '9.3.1.13'
    if kind == 'dmg_dts':
        if 'listening_elapsed' in c:
            return (duration_dts_listening_min(c['listening_elapsed']), DUR_MAX), '10.39.6.6.2'
        vs = [c['variant']] if 'variant' in c else ['9.3.1.14', '10.39.6.6.2']
        return ({duration_dts(c['nav_at_start'], c['sp_remaining_at_end'], c.get('dts_txtime'), v) for v in vs},
                '9.3.1.14 / 10.39.6.6.2')
    if kind in ('ack', 'ba', 'ba_ext'):
        if kind != 'ack' and c.get('unsolicited'):
            return {duration_ba_unsolicited(c['ack_txtime'])}, '9.2.5.2 a) 4)'
        return _resp_values(c, kind, 'elicit_duration'), '9.2.5.7'
    if kind == 'bar':
        return {duration_bar(c['resp_txtime'])}, '9.2.5.2 a) 3)'
    if kind in ('data', 'mgmt'):
        if 'multi' in c:
            return duration_multi_range(**c['multi']), '9.2.5.2 b)'
        return ({duration_data_single(c.get('resp_txtime'), c.get('final', True), c.get('next_txtime'),
                                      c.get('next_resp_txtime'), c.get('gap', T.SIFS))}, '9.2.5.2 a) 5)/6)')
    if kind == 'response':
        return _resp_values(c, 'response', 'elicit_duration'), '9.2.5.8'
    if kind == 'cf_end':
        return {duration_cf_end(c['i'], c.get('cf_end_txtime'))}, '9.3.1.6'
    if kind == 'poll':
        sched = pp_schedule(c['poll_txtimes'], c['spr_txtimes'], c.get('ant_switch'))
        return {sched[c['i'] - 1][0]}, '10.39.7.2 (10-18)'
    if kind == 'spr':
        if 'poll_duration' in c:
            vs = [c['variant']] if 'variant' in c else ['10.39.7.2', '9.3.1.11']
            return ({duration_spr_response(c['poll_duration'], c['response_offset'], c.get('spr_txtime'), v)
                     for v in vs}, '9.3.1.11 / 10.39.7.2')
        return {duration_spr_unsolicited(c.get('alloc_remaining'))}, '9.3.1.11'
    if kind == 'grant':
        m = c['mode']
        g = c.get('grant_txtime')
        if m == 'gp':
            return {duration_grant_gp(c['remaining'])}, '10.39.7.3'
        if m == 'cbap':
            return {duration_grant_cbap(c['prev_duration'], g)}, '9.3.1.12'
        if m == 'txop':
            # 9.3.1.12: «subject to the TXOP limit as described in 10.23.2.9»: TXTIME(Grant) + D ≤ TXOP limit (⌈⌉ 9.2.5.1)
            lim = c['txop_limit']
            return (0, DUR_MAX if lim == 0 else field(Fr(lim) - (tx('grant') if g is None else g))), \
                '9.3.1.12 / 10.23.2.9'
        if m == 'relinquish':
            return {duration_grant_relinquish(c['remaining_at_start'], g)}, '10.39.7.3'
        if m == 'ext_reply':
            return {duration_grant_ext_reply(c['spr_duration'], g)}, '10.39.9'
        if m == 'ext_forward':
            return {duration_grant_ext_forward(c['ap_grant_duration'], g)}, '10.39.9'
        if m == 'ap_extend':
            return {field(c['sp_remaining'])}, '10.39.9'
        if m == 'group':
            return {duration_grant_group(c['to_alloc_start'])}, '9.3.1.12'
        if m == 'truncation':
            return {duration_grant_truncation(c['following'])}, '10.39.8.1'
        raise ValueError(m)
    if kind == 'grant_ack':
        if 'txtime' in c:
            txs = {Fr(c['txtime'])}
        else:
            txs = response_txtimes('grant_ack', 0)
        return {duration_grant_ack(c['grant_duration'], t) for t in txs}, '9.3.1.18'
    if kind == 'ssw':
        return ({duration_ssw(c.get('cdown', 0), c.get('ssw_txtime'), c.get('alloc_remaining'),
                              c.get('abft_slot_remaining'))}, '9.3.1.15')
    if kind == 'ssw_fb':
        return ({duration_ssw_fb(c['in_abft'], c.get('brp_requested', False), c.get('ssw_ack_txtime'),
                                 c.get('alloc_remaining'))}, '9.3.1.16')
    if kind == 'ssw_ack':
        return {duration_ssw_ack(c['fb_duration'], c.get('ssw_ack_txtime'))}, '9.3.1.17'
    if kind == 'dmg_beacon':
        return {duration_dmg_beacon(c['bti_remaining'])}, '9.3.4.2'
    if kind == 'ati_request':
        return {duration_ati_request(c['ati_remaining'])}, '10.39.3'
    if kind == 'ati_response':
        return {duration_ati_response(c['request_duration'], c['resp_txtime'])}, '10.39.3'
    raise ValueError(f'неизвестный вид кадра {kind}')


def check_duration(frame_kind, value, context=None):
    """None — значение допустимо; иначе текст нарушения с пунктом. Неоднозначные места стандарта (DTS, SPR, MCS ответа,
    допуск SIFS) принимаются в любом из толкований, если контекст не фиксирует его ('variant', 'mcs', 'gap').
    Общие для DTI ограничения: context['alloc_remaining_seq'] — сколько осталось до конца CBAP/SP от конца PPDU
    (10.39.4/10.39.5: обмен «completes before the end of the CBAP or SP»; 10.39.6.6.2 для RTS в SP)."""
    c = dict(context or {})
    if not isinstance(value, int) or not 0 <= value <= 0xFFFF:
        return f'Duration/ID {value!r}: не 16‑битное целое (9.2.4.2)'
    kind, v = decode(value)
    if frame_kind == 'ps_poll':
        return None if kind == 'aid' else f'PS-Poll: Duration/ID {value:#06x} — не AID (9.3.1.5.2, табл. 9-9)'
    if kind != 'duration':
        return f'Duration/ID {value:#06x}: бит 15 = 1 — {kind} (табл. 9-9), длительность > {DUR_MAX} не кодируется'
    if 'alloc_remaining_seq' in c and value > c['alloc_remaining_seq']:
        clause = '10.39.6.6.2' if frame_kind == 'rts' else '10.39.4/10.39.5'
        return f'{frame_kind}: Duration {value} выходит за конец выделения ({c["alloc_remaining_seq"]} мкс, {clause})'
    c.pop('alloc_remaining_seq', None)
    if not c and frame_kind not in ('spr',):
        return None                                 # только кодирование
    allowed, clause = _allowed(frame_kind, c)
    if isinstance(allowed, tuple):
        lo, hi = allowed
        if lo <= value <= hi:
            return None
        return f'{frame_kind}: Duration {value} вне [{lo}, {hi}] ({clause})'
    if value in allowed:
        return None
    return f'{frame_kind}: Duration {value} ≠ {sorted(allowed)} ({clause})'


def check_ampdu_same_duration(values):
    """9.7.3: «The Duration/ID fields in the MAC headers of all MPDUs in an A-MPDU carry the same value»."""
    if len(set(values)) > 1:
        return f'A-MPDU: разные Duration/ID {sorted(set(values))} (9.7.3)'
    return None


def cf_end_check(value, i, remaining, cf_end_txtime=None):
    """9.3.1.6 + 10.23.2.10: значение по номеру i и запрет ненулевого при остатке < 2×TCF-End + 2×SIFS."""
    if value != 0 and not cf_end_nonzero_allowed(remaining, cf_end_txtime):
        return f'CF-End: Duration {value} ≠ 0 при остатке {remaining} < 2×TCF-End + 2×SIFS (10.23.2.10)'
    return check_duration('cf_end', value, {'i': i, 'cf_end_txtime': cf_end_txtime} if cf_end_txtime else {'i': i})
