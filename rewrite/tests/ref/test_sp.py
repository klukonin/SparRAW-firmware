# SPDX-License-Identifier: AGPL-3.0-or-later
"""ref/sp: правила SP (10.39.6.2 [p. 1885–1886]), восстановление SP (10.39.6.7 [p. 1895]), усечение (10.39.8.1
[p. 1900]), продление (10.39.9 [p. 1901]), LP SC и Grant Ack (10.39.4 [p. 1882]), CBAP расписания (10.39.5);
позитивный BI и негативные варианты — ref/tdma_scen."""
import pytest

from . import bi as BI
from . import duration as D
from . import dynalloc as DA
from . import fields as F
from . import schedule as S
from . import sp as SPm
from . import tdma_scen as TS
from .timing import ALLOC_SP, DOT11_SP_IDLE_TIMEOUT, SIFS

AP, A, B, C = TS.AP, TS.A, TS.B, TS.C


def test_positive_bi_has_no_violations():
    v, w = TS.judge(TS.scenario())
    assert v == []
    assert [x.why for x in w] == ['продление', 'GP']


@pytest.mark.parametrize('name', sorted(TS.NEGATIVE))
def test_negative_scenarios(name):
    sc, rule = TS.negative(name)
    v, _ = TS.judge(sc)
    assert rule in {x.rule for x in v}, v


def _bi(reqs, evs, caps=None):
    ent = S.plan(0, TS.BI_TU, TS.BHI_END, reqs)
    per = BI.layout(0, TS.BI_TU, BI.BiConfig(allocations=[e.alloc for e in ent]), None)
    return ent, per


def _judge(ent, evs, caps=None):
    v, w, _ = SPm.check_dti(evs, 0, TS.BI_TU, ent, TS.AIDS, AP, caps=caps or {})
    return {x.rule for x in v}, v, w


# ---------------------------------------------------------------------------------------------- усечение
def test_truncation_cf_end_then_ap_reallocates():
    """10.39.8.1: CF-End к AP, затем CF-End пиру (пир отвечает CF-End через SIFS при Duration ≠ 0); «After the
    truncation is completed, the AP or PCP may dynamically allocate any portion of the relinquished channel time»."""
    reqs = [S.Req(S.SP, 1, 2, 3000, truncatable=1)]
    ent, (p,) = _bi(reqs, [])
    evs = SPm.sp_exchange(BI.Period(S.SP, p.start, p.start + 200), A, B, 2)
    t = evs[-1][1] + SIFS
    evs += SPm.truncation_cf_end(t, A, AP, B)
    pp, pe = DA.pp(evs[-1][1] + 20, AP, [C])
    g, w = DA.gp(pe + SIFS, AP, [C], F.Dai(0, ALLOC_SP, 3, 0, 500), mac_of=TS.MAC_OF)
    evs += pp + g
    rules, v, _ = _judge(ent, evs)
    assert rules == set(), v
    # тот же обмен в неусекаемом SP
    ent2, _ = _bi([S.Req(S.SP, 1, 2, 3000)], [])
    rules, _, _ = _judge(ent2, evs)
    assert 'sp_trunc' in rules and 'dyn_where' in rules and 'sp_foreign' in rules


def test_truncation_grant_releases_cbap_for_everyone():
    """10.39.8.1: широковещательный Grant (broadcast/broadcast, CBAP), Duration = SIFS + CF-End + SIFS + ответный
    CF-End; CBAP начинается в PHY-TXEND Grant + Duration и длится Allocation Duration — в нём передаёт любая STA
    (10.39.5)."""
    ent, (p,) = _bi([S.Req(S.SP, 1, 2, 3000, truncatable=1)], [])
    evs = SPm.sp_exchange(BI.Period(S.SP, p.start, p.start + 200), A, B, 2)
    tg = SPm.truncation_grant(evs[-1][1] + SIFS, A, B, p.end)
    g = tg[0]
    assert g[5] == D.field(2 * SIFS + 2 * SPm.T_CF_END) == 35        # ⌈2·3 + 2·14,04⌉
    evs += tg
    cb0 = g[1] + g[5]
    evs.append(SPm._ev(cb0 + 100, 'Data', C, AP, 200, 8))
    evs.append(SPm._ev(cb0 + 100 + D.T.txtime(200, 8) + SIFS, 'Ack', AP, C, 14, 1))
    rules, v, w = _judge(ent, evs)
    assert rules == set(), v
    assert any(x.everyone for x in w)
    # Duration Grant усечения неверен; Allocation Duration больше остатка
    bad = list(evs)
    i = bad.index(g)
    f = g[6]['frame']
    bad[i] = g[:5] + (g[5] + 10, dict(g[6], frame=f._replace(duration=g[5] + 10)))
    assert 'sp_trunc' in _judge(ent, bad)[0]
    bad = list(evs)
    bad[i] = g[:6] + (dict(g[6], frame=f._replace(dai=f.dai._replace(alloc_duration=f.dai.alloc_duration + 50))),)
    assert 'sp_trunc' in _judge(ent, bad)[0]


def test_truncation_only_by_source():
    """10.39.8.1: «Only the source DMG STA of an SP may truncate the SP» (кроме 10.39.6.7)."""
    ent, (p,) = _bi([S.Req(S.SP, 1, 2, 3000, truncatable=1)], [])
    evs = SPm.sp_exchange(BI.Period(S.SP, p.start, p.start + 200), A, B, 2)
    evs += SPm.truncation_cf_end(evs[-1][1] + SIFS, B, AP, A)
    assert 'sp_trunc' in _judge(ent, evs)[0]


# ---------------------------------------------------------------------------------------------- уступка, восстановление
def test_relinquish_grant_swaps_roles():
    """10.39.7.3: Grant источника получателю — Source AID = получатель, Destination AID = источник, SP, 32 768,
    Duration = остаток SP − TXTIME(Grant) − aSIFSTime; при BT = 0 роли меняются."""
    ent, (p,) = _bi([S.Req(S.SP, 1, 2, 3000)], [])
    evs = SPm.sp_exchange(BI.Period(S.SP, p.start, p.start + 200), A, B, 2)
    g = DA.relinquish_grant(evs[-1][1] + SIFS, A, B, 1, 2, p.end)
    assert g[6]['frame'].dai == F.Dai(0, ALLOC_SP, 2, 1, 32768)
    assert g[5] == D.field(p.end - g[0] - DA.T_GRANT - SIFS)
    evs.append(g)
    # после уступки B — источник: его повтор раньше PIFS — нарушение sp_retx (роль источника перешла)
    d1 = SPm._ev(g[1] + 20, 'Data', B, A, 300, 8)
    d2 = SPm._ev(d1[1] + SIFS, 'Data', B, A, 300, 8)
    rules, v, _ = _judge(ent, evs + [d1, d2])
    assert rules == {'sp_retx'}, v
    bad = g[:6] + (dict(g[6], frame=g[6]['frame']._replace(dai=F.Dai(0, ALLOC_SP, 1, 2, 32768))),)
    assert 'sp_relinquish' in _judge(ent, evs[:-1] + [bad])[0]


def test_sp_recovery_after_idle_timeout():
    """10.39.6.7: AP-получатель, не получивший кадров источника за dot11SPIdleTimeout (200 мкс) от начала SP, может
    усечь усекаемый SP и распределить остаток (10.39.7)."""
    ent, (p,) = _bi([S.Req(S.SP, 1, 0, 3000, truncatable=1)], [])
    pp, pe = DA.pp(p.start + DOT11_SP_IDLE_TIMEOUT + 10, AP, [C])
    assert _judge(ent, pp)[0] == set()
    pp_early, _ = DA.pp(p.start + 50, AP, [C])
    assert 'sp_recovery' in _judge(ent, pp_early)[0]
    ent2, _ = _bi([S.Req(S.SP, 1, 0, 3000)], [])
    assert 'sp_recovery' in _judge(ent2, pp)[0]


def test_first_frame_response_to_unseen_source_frame():
    """Захват без кадров данных (PMC стенда, 2026-11-10): первый кадр SP станции → AP — BlockAck AP на её A-MPDU,
    которого в журнале нет. Ответ без вызова получатель не шлёт (10.3.2.11, 10.25.3) — источник начал SP раньше:
    не sp_recovery (10.39.6.7) и не sp_first_src, а sp_unseen_trigger («не проверяемо» у вызывающих). Передача AP,
    не являющаяся ответом (данные), в том же месте — по-прежнему sp_recovery; BlockAck на MCS данных (не ответ,
    10.6.7.2) — тоже."""
    ent, (p,) = _bi([S.Req(S.SP, 1, 0, 3000)], [])
    ba = SPm._ev(p.start + 78, 'BlockAck', AP, A, 32, 4)
    rules, v, _ = _judge(ent, [ba])
    assert rules == {'sp_unseen_trigger'}, v
    data = SPm._ev(p.start + 78, 'Data', AP, A, 1500, 8)
    assert 'sp_recovery' in _judge(ent, [data])[0]
    ba8 = SPm._ev(p.start + 78, 'BlockAck', AP, A, 32, 8)
    assert 'sp_recovery' in _judge(ent, [ba8])[0]
    # SP точки → станции: BlockAck станции первым — то же
    ent2, (p2,) = _bi([S.Req(S.SP, 0, 1, 3000)], [])
    rules, v, _ = _judge(ent2, [SPm._ev(p2.start + 90, 'BlockAck', A, AP, 32, 4)])
    assert rules == {'sp_unseen_trigger'}, v


# ---------------------------------------------------------------------------------------------- продление
def test_extension_needs_following_broadcast_sp():
    """10.39.9: «may grant the request … only if the following SP has the broadcast AID as both source and destination
    AID, and the duration of the following SP is larger than the value of the Allocation Duration field»."""
    ent, (p, q) = _bi([S.Req(S.SP, 1, 0, 3000, extendable=1), S.Req(S.SP, 3, 0, 3000)], [])
    evs = SPm.sp_exchange(BI.Period(S.SP, p.start, p.start + 200), A, AP, 2)
    evs += SPm.extension(evs[-1][1] + SIFS, A, AP, AP, p.end, 300, 200)
    assert 'sp_ext_grant' in _judge(ent, evs)[0]
    ent2, _ = _bi([S.Req(S.SP, 1, 0, 3000, extendable=1), S.Req(S.SP, 255, 255, 3000, truncatable=1)], [])
    assert _judge(ent2, evs)[0] == set()
    # отказ (Allocation Duration = 0) — допустим всегда
    evs0 = SPm.sp_exchange(BI.Period(S.SP, p.start, p.start + 200), A, AP, 2)
    evs0 += SPm.extension(evs0[-1][1] + SIFS, A, AP, AP, p.end, 300, 0)
    assert _judge(ent, evs0)[0] == set()


def test_extension_forward_to_partner():
    """10.39.9: SIFS после Grant AP с ненулевым Allocation Duration STA пересылает Grant партнёру: Duration = Grant AP −
    TXTIME − SIFS, Allocation Duration — тот же."""
    ent, (p, q) = _bi([S.Req(S.SP, 1, 2, 3000, extendable=1), S.Req(S.SP, 255, 255, 3000, truncatable=1)], [])
    evs = SPm.sp_exchange(BI.Period(S.SP, p.start, p.start + 200), A, B, 2)
    ext = SPm.extension(evs[-1][1] + SIFS, A, AP, B, p.end, 300, 200)
    assert len(ext) == 3 and ext[2][3] == B
    spr, g, h = ext
    assert g[5] == D.field(spr[5] - SIFS - DA.T_GRANT) and h[5] == D.field(g[5] - DA.T_GRANT - SIFS)
    assert _judge(ent, evs + ext)[0] == set()
    assert 'sp_ext_grant' in _judge(ent, evs + ext[:2])[0]
    # данные пары в продлённом времени (после исходного конца SP) — допустимы
    d = SPm._ev(p.end + 50, 'Data', A, B, 300, 8)
    a = SPm._ev(d[1] + SIFS, 'Ack', B, A, 14, 1)
    assert _judge(ent, evs + ext + [d, a])[0] == set()


def test_ap_source_extension():
    """10.39.9: AP-источник продлевает свой SP Grant-ом получателю: Duration = остаток SP, Allocation Duration —
    добавка после конца SP."""
    ent, (p, q) = _bi([S.Req(S.SP, 0, 1, 3000), S.Req(S.SP, 255, 255, 3000, truncatable=1)], [])
    evs = SPm.sp_exchange(BI.Period(S.SP, p.start, p.start + 200), AP, A, 2)
    t = evs[-1][1] + SIFS
    te = t + DA.T_GRANT
    g = F.Grant(D.field(p.end - te), A, AP, F.Dai(0, ALLOC_SP, 0, 1, 400), F.BfControl())
    ge = (t, te, AP, A, 'Grant', g.duration, dict(mcs=0, frame=g))
    d = SPm._ev(p.end + 100, 'Data', AP, A, 300, 8)
    assert _judge(ent, evs + [ge, d])[0] == set()
    bad = (t, te, AP, A, 'Grant', g.duration - 5, dict(mcs=0, frame=g._replace(duration=g.duration - 5)))
    assert 'sp_ap_ext' in _judge(ent, evs + [bad, d])[0]


# ---------------------------------------------------------------------------------------------- Heartbeat, CBAP
def test_heartbeat_destination_first_frame():
    """10.39.6.2: «The first frame transmitted by a destination DMG STA to the source DMG STA in an SP shall use the
    DMG Control modulation class if the Heartbeat field in the source DMG STA's DMG Capabilities element is 1»."""
    ent, (p,) = _bi([S.Req(S.SP, 1, 2, 3000)], [])
    evs = SPm.sp_exchange(p, A, B, 2)                      # Ack получателя — SC MCS 1
    assert _judge(ent, evs)[0] == set()
    assert 'sp_heartbeat' in _judge(ent, evs, caps={A: {'heartbeat': 1}})[0]


def test_cbap_allocation_access_and_end():
    """10.39.5: в CBAP с Source AID = A обмен начинают только A (источник) и получатель B; кадр — не дальше конца
    CBAP."""
    ent, (p,) = _bi([S.Req(S.CBAP, 1, 2, 2000)], [])
    ok = SPm.sp_exchange(p, A, B, 2) + SPm.sp_exchange(BI.Period(S.CBAP, p.start + 500, p.end), B, A, 1)
    assert _judge(ent, ok)[0] == set()
    assert 'cbap_member' in _judge(ent, ok + [SPm._ev(p.start + 1000, 'Data', C, A, 200, 8)])[0]
    assert 'cbap_end' in _judge(ent, ok + [SPm._ev(p.end - 2, 'Data', A, B, 3000, 8)])[0]
    # CBAP broadcast — любая STA
    ent2, (p2,) = _bi([S.Req(S.CBAP, 255, 255, 2000)], [])
    assert _judge(ent2, [SPm._ev(p2.start + 1000, 'Data', C, A, 200, 8)])[0] == set()
