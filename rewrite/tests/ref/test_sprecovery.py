# SPDX-License-Identifier: AGPL-3.0-or-later
"""ref/sprecovery + ref/sp.check_dti(reclaimed): 10.39.6.7 [p. 1895] — AP забирает SP между non-AP STA целиком по
итогам ATI (10.39.3)."""
from fractions import Fraction as Fr

from . import bi as BI
from . import schedule as S
from . import sp as SPm
from . import sprecovery as R
from . import tdma_scen as TS
from .timing import ALLOC_CBAP, ALLOC_SP, SIFS

AP, A, B = TS.AP, TS.A, TS.B


def sp_entry(src=1, dst=2, alloc_id=1, ctype=ALLOC_SP):
    return S.Entry(BI.Allocation(ctype, src, dst, 40000, 8000, alloc_id=alloc_id), None)


def ati_log(answered):
    """Announce AP → A и → B; ответ через SIFS — от answered."""
    log, t = [], Fr(1000)
    for sta in (A, B):
        log.append((t, t + 20, AP, sta, 'Action'))
        if sta in answered:
            log.append((t + 20 + SIFS, t + 30 + SIFS, sta, AP, 'Ack'))
        t += 100
    return log


def test_responders_10_39_3():
    assert R.ati_responders(ati_log({A, B}), AP) == {A, B}
    assert R.ati_responders(ati_log({A}), AP) == {A}
    late = [(Fr(0), Fr(20), AP, A, 'Action'), (Fr(40), Fr(50), A, AP, 'Ack')]      # не через SIFS
    assert R.ati_responders(late, AP) == set()


def test_reclaimable_conditions():
    e = [sp_entry()]
    assert R.reclaimable(e, {A, B}, TS.MAC_OF) == set()                             # обе ответили — нельзя
    assert R.reclaimable(e, {A}, TS.MAC_OF) == {(1, 2, 1)}                          # B не ответила
    assert R.reclaimable(e, set(), TS.MAC_OF) == {(1, 2, 1)}                        # PLAN №103: запроса не было
    assert R.reclaimable([sp_entry(src=0)], set(), TS.MAC_OF) == set()              # SP с AP — не «between two non-AP»
    assert R.reclaimable([sp_entry(ctype=ALLOC_CBAP)], set(), TS.MAC_OF) == set()
    assert R.may_reclaim(sp_entry().alloc, {(1, 2, 1)}) and not R.may_reclaim(sp_entry().alloc, set())


def test_ap_in_sp_between_stas_needs_10_39_6_7():
    ent = S.plan(0, TS.BI_TU, TS.BHI_END, [S.Req(S.SP, 1, 2, 3000)])
    p = BI.layout(0, TS.BI_TU, BI.BiConfig(allocations=[e.alloc for e in ent]), None)[0]
    evs = SPm.sp_exchange(BI.Period(S.SP, p.start, p.start + 400), AP, TS.C, 1)      # AP передаёт в SP A → B
    v, _, _ = SPm.check_dti(evs, 0, TS.BI_TU, ent, TS.AIDS, AP)
    assert any(x.rule == 'sp_foreign' and '10.39.6.7' in x.msg for x in v), v
    key = ent[0].alloc.key()
    v2, _, _ = SPm.check_dti(evs, 0, TS.BI_TU, ent, TS.AIDS, AP, reclaimed={key})
    assert not any(x.rule == 'sp_foreign' and x.msg.split(' от ')[1].startswith(AP) for x in v2), v2
