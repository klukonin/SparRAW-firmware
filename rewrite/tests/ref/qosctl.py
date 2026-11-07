# SPDX-License-Identifier: AGPL-3.0-or-later
"""Генератор и проверка поля QoS Control данных DMG по 802.11-2020 9.2.4.5 [p. 771–777]: табл. 9-11 (DMG: TID, EOSP,
Ack Policy, A-MSDU Present, A-MSDU Type, RDG/More PPDU, Buffered AC, B14 Reserved, AC Constraint), TID по политике
доступа (9.2.4.5.2, табл. 9-12: EDCA — UP 0–7; SPCA/SEMM — TSID 8–15), EOSP DMG (9.2.4.5.3: 1 — только в последнем
кадре SP или CBAP с индивидуальным Destination AID), Ack Policy (9.2.4.5.4, табл. 9-13: групповые — No Ack без
соглашения BA; No Ack не для QoS Data с TID под BA; Implicit BAR — только в A-MPDU), A-MSDU Type (9.2.4.5.13: резерв
при A-MSDU Present = 0), RDG/More PPDU и AC Constraint (9.2.4.5.14/15, табл. 9-14/9-15 — reverse direction; у нас RD
выключен намеренно, 10.29 — генератор ставит 0), Buffered AC (9.2.4.5.16, рис. 9-10: VO, VI, BE, BK).

Разбор полей — amsdu.parse_qos (тот же порядок бит). Не моделируется: PSMP Ack (вне DMG), TXOP Limit/Queue Size
(подтипы +CF-Poll — вне DMG), Mesh-поля."""
from . import amsdu as AM

ACK_NORMAL, ACK_NOACK, ACK_NOEXPLICIT, ACK_BLOCK = 0, 1, 2, 3     # биты 5–6 как число (B5 младший), табл. 9-13
EDCA, SPCA, SEMM = 'EDCA', 'SPCA', 'SEMM'
TID_RANGE = {EDCA: range(0, 8), SPCA: range(8, 16), SEMM: range(8, 16)}   # табл. 9-12 (HCCA/HEMM — не DMG)
AC_BIT = {'AC_VO': 0, 'AC_VI': 1, 'AC_BE': 2, 'AC_BK': 3}                  # рис. 9-10


def buffered_ac(acs):
    """Множество AC с буферизованными BU → значение Buffered AC (рис. 9-10)."""
    return sum(1 << AC_BIT[a] for a in acs)


def generate(tid, access=EDCA, group=False, ba=False, in_ampdu=False, no_ack=False, block_ack=False, amsdu=None,
             last_in_alloc=False, alloc_dst_individual=False, buffered=(), null=False):
    """QoS Control (2 октета) кадра данных DMG по правилам 9.2.4.5. amsdu — None или amsdu.BASIC/SHORT;
    last_in_alloc — последний кадр (и его повторы) в SP или CBAP с индивидуальным Destination AID (EOSP = 1 лишь тогда,
    9.2.4.5.3); no_ack — отправитель не требует немедленного подтверждения; block_ack — отложенный ответ (Block Ack,
    BAR потом)."""
    if tid not in TID_RANGE[access]:
        raise ValueError(f'TID {tid} при политике {access}: допустимо {TID_RANGE[access].start}–'
                         f'{TID_RANGE[access].stop - 1} (табл. 9-12)')
    if null and amsdu is not None:
        raise ValueError('QoS Null без тела — A-MSDU Present = 0 (табл. 9-11)')
    if group and not ba:
        ap = ACK_NOACK                    # табл. 9-13: «used in all group addressed frames … except QoS Data with a
    #                                     TID for which a block ack agreement exists»
    elif no_ack:
        if ba and not null:
            raise ValueError('No Ack не используется для QoS Data с TID под соглашением BA (табл. 9-13)')
        ap = ACK_NOACK
    elif block_ack:
        if not ba:
            raise ValueError('Block Ack без соглашения BA (табл. 9-13, 10.25)')
        ap = ACK_BLOCK
    else:
        if in_ampdu and not ba:
            raise ValueError('Implicit BAR — A-MPDU под соглашением BA (табл. 9-13, табл. 9-530)')
        ap = ACK_NORMAL                   # Normal Ack (не A-MPDU) / Implicit BAR (A-MPDU)
    eosp = 1 if (last_in_alloc and alloc_dst_individual) else 0
    return AM.encode_qos(tid, ackpol=ap, amsdu=1 if amsdu is not None else 0,
                         amsdu_type=amsdu if amsdu is not None else 0, eosp=eosp, rdg=0,
                         buffered_ac=buffered_ac(buffered), acc=0)


def check(qos, group=False, ba=None, in_ampdu=None, ts_tids=None, dst_broadcast_alloc=None, null=False, rd=False):
    """Нарушения QoS Control переданного кадра данных DMG. qos — int или 2 октета. ba — есть ли соглашение BA для
    (TA, RA, TID) (None — неизвестно); ts_tids — TSID, допущенные ADDTS для пары (None — неизвестно);
    dst_broadcast_alloc
    — кадр в CBAP с широковещательным Destination AID (CBAP Only); rd — RD разрешён (у нас нет)."""
    q = AM.parse_qos(int.from_bytes(qos, 'little') if isinstance(qos, (bytes, bytearray)) else qos)
    v = []
    if q.rsv14:
        v.append('B14 Reserved = 1 (табл. 9-11)')
    if null and (q.amsdu or q.amsdu_type):
        v.append('QoS Null с A-MSDU Present/Type ≠ 0 (табл. 9-11)')
    if q.amsdu_type and not q.amsdu:
        v.append('A-MSDU Type = 1 при A-MSDU Present = 0 — «reserved» (9.2.4.5.13)')
    if q.tid >= 8 and ts_tids is not None and q.tid not in ts_tids:
        v.append(f'TID {q.tid} (TSID, табл. 9-12) без допущенного TS для пары')
    if dst_broadcast_alloc and q.eosp:
        v.append('EOSP = 1 в CBAP с широковещательным Destination AID (9.2.4.5.3: EOSP — конец SP или CBAP «with a '
                 'destination AID that is not the broadcast AID»)')
    if group and ba is False and q.ackpol != ACK_NOACK:
        v.append(f'групповой кадр с Ack Policy {q.ackpol} ≠ No Ack без соглашения BA (табл. 9-13)')
    if ba and q.ackpol == ACK_NOACK and not null:
        v.append('No Ack у QoS Data с TID под соглашением BA (табл. 9-13)')
    if ba is False and q.ackpol == ACK_BLOCK:
        v.append('Ack Policy Block Ack без соглашения BA (табл. 9-13, 10.25)')
    if q.ackpol == ACK_NOEXPLICIT:
        v.append('Ack Policy No Explicit/PSMP Ack — не для данных DMG (табл. 9-13: QoS CF-Poll / PSMP)')
    if not rd and q.rdg:
        v.append('RDG/More PPDU = 1 при выключенном reverse direction (9.2.4.5.14, 10.29)')
    return v
