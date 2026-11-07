# SPDX-License-Identifier: AGPL-3.0-or-later
"""Восстановление SP по 802.11-2020 10.39.6.7 [p. 1895], вторая часть: «An AP or PCP may reclaim the entire time
allocated in an SP between two non-AP and non-PCP STAs if the following two conditions are met: — The SP is announced
within an Extended Schedule element transmitted during the ATI. — The AP or PCP does not receive a response frame from
at least one of the source and destination non-AP and non-PCP STAs of that SP as part of the ATI exchange (10.39.3)…
Otherwise, if none of these conditions apply, no time may be reclaimed.» Обмен ATI — 10.39.3 [p. 1881]: запрос AP к
STA (индивидуальный, TA = AP), ответ STA к AP через SIFS. Первая часть 10.39.6.7 (AP-получатель после
dot11SPIdleTimeout, только Truncatable) — ref/sp.check_sp ('sp_recovery').

Принято (PLAN.md №103): «does not receive a response frame … as part of the ATI exchange» буквально — ответа нет и
тогда, когда запроса к этой STA в ATI не было; объявление «within an Extended Schedule element transmitted during the
ATI» — Extended Schedule в кадре AP (Announce), переданном в ATI, содержит SP (по ключу Source AID, Destination AID,
Allocation ID); возвращённое время — с начала SP («the entire time»), им распоряжается AP (CBAP, SP или ничего).

ati_responders(log, ap) — STA, ответившие AP в ATI; reclaimable(entries_ati, responders, mac_of) — ключи SP, которые AP
может забрать; check_dti(…, reclaimed=…) в ref/sp принимает эти ключи."""
from .timing import AID_AP_PCP, AID_BROADCAST, ALLOC_SP, ALLOC_SP_1G08, SIFS, SIFS_TOL

ALLOC_SP_TYPES = (ALLOC_SP, ALLOC_SP_1G08)      # табл. 9-257: SP, SP 1,08 ГГц (Allocation Type)


def ati_responders(log, ap, sifs_tol=SIFS_TOL, q=0):
    """log — [(t, te, src, dst, kind)] кадров ATI по времени. → множество MAC STA, ответивших AP: кадр STA → AP с
    началом через SIFS (± допуск) после конца индивидуального запроса AP к этой STA (10.39.3)."""
    out = set()
    for i, (t, te, src, dst, kind) in enumerate(log):
        if src != ap or dst is None or dst == ap or int(dst.split(':')[0], 16) & 1:
            continue
        for t2, te2, s2, d2, k2 in log[i + 1:i + 3]:
            if s2 == dst and d2 == ap and SIFS - q <= t2 - te <= SIFS + sifs_tol + q:
                out.add(dst)
                break
    return out


def reclaimable(entries_ati, responders, mac_of):
    """entries_ati — [schedule.Entry] из Extended Schedule кадров AP в ATI; mac_of — AID → MAC. → {ключ SP}: SP между
    двумя non-AP STA (Source/Destination AID ∉ {0, 255}), где хотя бы одна не ответила в ATI."""
    keys = set()
    for e in entries_ati:
        a = e.alloc
        if a.alloc_type not in ALLOC_SP_TYPES:
            continue
        if {a.src_aid, a.dst_aid} & {AID_AP_PCP, AID_BROADCAST}:
            continue
        s, d = mac_of.get(a.src_aid), mac_of.get(a.dst_aid)
        if s is None or d is None or s not in responders or d not in responders:
            keys.add(a.key())
    return keys


def may_reclaim(alloc, keys):
    """Может ли AP забрать SP alloc (bi.Allocation) целиком (10.39.6.7)."""
    return alloc is not None and alloc.key() in keys
