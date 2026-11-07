# SPDX-License-Identifier: AGPL-3.0-or-later
"""Правила судьи эфира (ref/air_judge) волны 3: обнаружение пиров (11.28, ref/discovery), QAB (11.35, ref/qab),
передача PCP (11.27.2, ref/handover), защищённый период (10.39.6.6, ref/protperiod), DMG ADDTS/DELTS (11.4, ref/tspec),
spatial sharing (11.30, ref/spsh), RSNE DMG (9.4.2.24, 12.6.3, ref/capelems), Extended Capabilities (9.4.2.26),
Supported Operating Classes (9.4.2.53), пределы A-MPDU (9.7.1, 10.12.2, ref/ampdu), QoS Control данных (9.2.4.5,
ref/qosctl). Нет кадров — «не проверяемо» с причиной (judge дописывает общую).

Тела Action — из TX-записей с телом целиком (e.body_ok); защищённый кадр (Protected = 1) — не разбирается. Импорт
air_judge — внутри функций (air_judge импортирует этот модуль)."""
from collections import Counter, defaultdict

from . import ampdu as AMP
from . import bi as BI
from . import capelems as CE
from . import discovery as DS
from . import elements as E
from . import fields as F
from . import handover as HO
from . import protperiod as PP
from . import qab as QB
from . import qosctl as QC
from . import spsh as SS
from . import tspec as TS
from .timing import AID_AP_PCP, BCAST

PAGE = {'11.28': 2359, '11.35': 2389, '11.27.2': 2357, '10.39.6.6': 1888, '11.4': 2147, '11.30': 2364,
        '9.4.2.24': 1051, '9.4.2.26': 1061, '9.4.2.53': 1119, '10.12.2': 1719, '9.2.4.5': 771}
ACTION_KINDS = ('Action', 'Action No Ack')
MGMT_BODY = (E.PROBE_REQ, E.PROBE_RESP, E.ASSOC_REQ, E.ASSOC_RESP, E.REASSOC_REQ, E.REASSOC_RESP)


def _j():
    from . import air_judge as J
    return J


def _act(e, r=None, cats=None, acts=None):
    """(Category, Action, тело с Category) TX-кадра Action с телом целиком или None. Причина «не проверяемо» пишется в
    r, только если категория и действие записаны и входят в cats/acts (None — любые)."""
    if e.kind not in ACTION_KINDS or e.raw is None or len(e.raw) < 26:
        return None
    mine = (cats is None or e.raw[24] in cats) and (acts is None or e.raw[25] in acts)
    if not e.body_ok:
        if r is not None and mine:
            r.skip('тело Action-кадра не записано целиком')
        return None
    if F.parse_fc(e.raw[:2]).protected:
        if r is not None and mine:
            r.skip('Action-кадр защищён (robust) — тело не разобрать')
        return None
    return e.raw[24], e.raw[25], e.raw[24:]


def _role(c, mac):
    return E.ROLE_AP if mac == c.ap else E.ROLE_STA


def _beacons_by_bi(c):
    """{BI: первый маяк BTI точки с телом}."""
    J = _j()
    by, bi_tu = J._btis(c)
    return {k: bs[0] for k, bs in sorted(by.items())}, bi_tu


def _beacon_els(b, eid):
    return [el[2] for el in (getattr(b.p, 'elements', None) or ()) if el[0] == eid and el[1] is None]


def _aids(c):
    """MAC → AID по Association/Reassociation Response точки (SUCCESS); AP — AID 0 (9.4.1.8)."""
    out = {c.ap: AID_AP_PCP} if c.ap else {}
    for e in c.evs:
        if e.kind in (E.ASSOC_RESP, E.REASSOC_RESP) and e.body_ok and e.raw is not None:
            try:
                fx, _ = E.parse_body(e.kind, e.raw[24:])
            except (ValueError, NotImplementedError):
                continue
            if fx['status'] == E.SUCCESS:
                out[e.dst] = fx['aid'] & 0xFF
    return out


def _mgmt_elements(c):
    """[(событие, кадр, [Element])] TX кадров управления с телом и DMG Beacon (элементы маяка — тоже)."""
    out = []
    for e in c.evs:
        if e.kind in MGMT_BODY and e.body_ok and e.raw is not None and not e.synth:
            try:
                _, els = E.parse_body(e.kind, e.raw[24:])
            except (ValueError, NotImplementedError):
                continue
            out.append((e, e.kind, els))
        elif e.kind == 'DMG Beacon' and e.p is not None and getattr(e.p, 'elements', None) is not None:
            out.append((e, 'DMG Beacon', [E.Element(x[0], x[1], bytes(x[2])) for x in e.p.elements]))
    return out


# ---------------------------------------------------------------------------------------------------- 11.28
def r_info_req(c):
    J = _j()
    r = J.Rule('info_req', '11.28', 'Information Request/Response (ref/discovery): формат табл. 9-460/9-461, Request '
               '(9.4.2.9: по возрастанию, без повторов и без DMG Capabilities), Subject Address (broadcast — только к '
               'AP/PCP), DMG Capabilities чужой STA в запросе non-AP, ответ: ≥ 1 DMG Capabilities, Subject = запроса, '
               '«пустой» ответ точки о не-члене / non-AP не о себе, broadcast — Action No Ack, точка отвечает лишь на '
               'свой/wildcard BSSID (11.28.2)')
    aids = _aids(c)
    reqs = {}
    for e in c.evs:
        a = _act(e, r, (DS.CATEGORY_DMG,), (DS.ACT_INFO_REQ, DS.ACT_INFO_RESP))
        if a is None or a[0] != DS.CATEGORY_DMG or a[1] not in (DS.ACT_INFO_REQ, DS.ACT_INFO_RESP):
            continue
        cat, act, body = a
        if act == DS.ACT_INFO_REQ:
            ms = DS.check_request(body, e.src, e.dst, dst_is_ap=e.dst == c.ap, src_is_ap=e.src == c.ap)
            try:
                reqs[(e.src, e.dst)] = (DS.parse(body)[0], bytes(e.raw[16:22]))
            except (ValueError, F.FieldError):
                pass
        else:
            pend = reqs.pop((e.dst, e.src), None)
            req = pend[0] if pend else None
            ms = DS.check_response(body, e.src, e.dst, req=req, src_is_ap=e.src == c.ap,
                                   members=set(aids) - {c.ap} if e.src == c.ap else None, frame_kind=e.kind)
            if pend is None and e.dst != BCAST:
                r.skip('Information Response без записанного запроса (возможно, unsolicited)')
            if pend is not None and e.src == c.ap:
                a3 = F.mac_str(pend[1])
                if a3 not in (BCAST, c.ap):
                    ms.append(f'точка ответила на запрос с BSSID {a3} — не свой и не wildcard (11.28.2 b))')
        for m in ms:
            r.bad(e, f'{e.action or e.kind}: {m}')
        if not ms:
            r.ok()
    return r


# ---------------------------------------------------------------------------------------------------- 11.35
def _ext_caps(c):
    out = {}
    for e, frame, els in _mgmt_elements(c):
        for el in els:
            if el.eid == 127 and el.ext is None:
                out[e.src] = CE.parse_ext_cap(el.info)
    return out


def r_qab(c):
    J = _j()
    r = J.Rule('qab', '11.35', 'QAB Request/Response (ref/qab): Dialog/Request Token ≠ 0, адреса, Target BSSID, обе '
               'точки с QAB Capability, ответ — копии токенов и BSSID, только от AP; точка-ответчик не передаёт в '
               'принятых тихих интервалах (11.35.3)')
    caps = _ext_caps(c)
    reqs, quiet = {}, []
    for e in c.evs:
        a = _act(e, r, (QB.CATEGORY_PUBLIC, QB.CATEGORY_PROTECTED_DUAL), (QB.ACT_QAB_REQ, QB.ACT_QAB_RESP))
        if a is None or not QB.is_qab(a[2]):
            continue
        try:
            f = QB.parse_frame(a[2])
        except (ValueError, F.FieldError) as x:
            r.bad(e, f'разбор QAB: {x}')
            continue
        ms = []
        if c.ap is not None and e.src != c.ap and e.tx_node is not None:
            ms.append('QAB-кадр от non-AP STA (9.6.7.34/35: «transmitted by an AP to another AP»)')
        q = lambda m: caps[m]['QAB Capability'] if m in caps else None    # noqa: E731
        if f.action == QB.ACT_QAB_REQ:
            ms += QB.check_request(f, e.src, q(e.src) if q(e.src) is not None else None,
                                   q(f.responder) if f.responder != BCAST else None)
            reqs[(f.requester, f.token)] = (f, e)
        else:
            pend = reqs.get((f.requester, f.token))
            ms += QB.check_response(f, e.src, req=pend[0] if pend else None)
            if pend is None:
                r.skip('QAB Response без записанного запроса')
            elif pend[1].t_ok:
                for qp in pend[0].elements:
                    if qp.target == e.src and any(x.token == qp.token and x.status == QB.SUCCESS for x in f.elements):
                        quiet += [(e.src, a0, b0) for a0, b0 in QB.quiet_intervals(pend[1].t, qp)]
        for m in ms:
            r.bad(e, f'{e.action or e.kind}: {m}')
        if not ms:
            r.ok()
    for src, a0, b0 in quiet:                       # 11.35.3 b) 1): «the AP shall not transmit during the SP»
        bad = [e for e in c.k if e.src == src and e.tx_node is not None and e.t < b0 and a0 < e.te]
        for e in bad:
            r.bad(e, f'{e.kind} точки в принятом тихом интервале [{float(a0):.0f}, {float(b0):.0f}) (11.35.3)')
        if not bad:
            r.ok()
    return r


# ---------------------------------------------------------------------------------------------------- 11.27.2
def r_pcp_handover(c):
    J = _j()
    r = J.Rule('pcp_handover', '11.27.2', 'передача PCP (ref/handover): Handover Request/Response (причины, Result, '
               'способность PCP Handover в DMG Capabilities), PCP Handover в DMG Beacon (только PBSS, Old BSSID = '
               'BSSID, New PCP постоянен, Remaining BIs −1 по TBTT, dot11NbrOfChangeBeacons BI подряд), Next PCP List '
               '(Length 0 или Token + AID, Token +1 при изменении)')
    dmg, _ = J._caps(c)
    capable = {m: HO.capable(x) for m, x in dmg.items()}
    aid_cap = {}
    for m, aid in _aids(c).items():
        if m in capable:
            aid_cap[aid] = capable[m]
    by, _ = _beacons_by_bi(c)
    pbss = None
    for b in by.values():
        pbss = getattr(b.p.params, 'bss_type', None) == E.BSS_TYPE_PBSS
        break
    for e in c.evs:
        a = _act(e, r, (HO.CATEGORY_DMG,), (HO.ACT_HANDOVER_REQ, HO.ACT_HANDOVER_RESP))
        if a is None or a[0] != HO.CATEGORY_DMG or a[1] not in (HO.ACT_HANDOVER_REQ, HO.ACT_HANDOVER_RESP):
            continue
        try:
            f, act = HO.parse_frame(a[2])
        except ValueError as x:
            r.bad(e, f'разбор: {x}')
            continue
        if act == HO.ACT_HANDOVER_REQ:
            ms = HO.check_request(f, e.src == c.ap, capable.get(e.src), capable.get(e.dst), pbss is not False)
        else:
            ms = HO.check_response(f)
        for m in ms:
            r.bad(e, f'{e.action or e.kind}: {m}')
        if not ms:
            r.ok()
    seq, npl = [], []
    for k, b in by.items():
        hs = _beacon_els(b, HO.EID_PCP_HANDOVER)
        ns = _beacon_els(b, HO.EID_NEXT_PCP_LIST)
        if (hs or ns) and pbss is False:
            r.bad(b, 'PCP Handover / Next PCP List в маяке не PBSS (11.27.2: передача роли PCP)')
            continue
        h = None
        if hs:
            try:
                h = HO.parse_pcp_handover(hs[0])
            except ValueError as x:
                r.bad(b, f'PCP Handover: {x}')
        seq.append((k, h))
        if ns:
            n = HO.parse_next_pcp_list(ns[0])
            ms = HO.check_next_pcp_list(n, aid_cap or None)
            for m in ms:
                r.bad(b, m)
            if not ms:
                r.ok()
            npl.append((b, n))
    if any(h is not None for _, h in seq):
        b0 = next(iter(by.values()))
        ms = HO.check_handover_beacons(seq, getattr(b0.p, 'bssid', c.ap))
        for m in ms:
            r.bad(b0, m, 'model')
        if not ms:
            r.ok()
    if len(npl) >= 2:
        ms = HO.check_next_pcp_tokens([n for _, n in npl])
        for m in ms:
            r.bad(npl[0][0], m)
        if not ms:
            r.ok()
    return r


# ---------------------------------------------------------------------------------------------------- 10.39.6.6
def _sps(c):
    """[Sp] из Extended Schedule маяков точки (абсолютное время TSF точки, MAC по AID)."""
    by, _ = _beacons_by_bi(c)
    aid2mac = {v: k for k, v in _aids(c).items()}
    out = []
    for k, b in by.items():
        infos = _beacon_els(b, E.EID_EXTENDED_SCHEDULE)
        if not infos:
            continue
        try:
            allocs = E.parse_extended_schedule(infos)
        except ValueError:
            continue
        for a in allocs:
            if not E.ALLOC_IS_SP.get(a.ctrl['allocation_type'], False):
                continue
            for lo, hi in E.allocation_blocks(a):
                t0 = BI.full_tsf(lo, b.t)
                out.append(PP.Sp(t0, t0 + a.block_duration, aid2mac.get(a.src_aid), aid2mac.get(a.dst_aid)))
    return out


def r_prot_period(c):
    J = _j()
    r = J.Rule('prot_period', '10.39.6.6', 'защищённый период DMG в SP (ref/protperiod): RTS источника внутри SP, '
               'Duration не дальше конца SP; DMG DTS получателя — в SP, через SIFS после RTS или не раньше '
               'aRTSTimeoutTime от начала SP; DMG CTS — через SIFS')
    sps = _sps(c)
    tol = J.Q + J.CAL_UNCERT + J.PRE_UNCERT
    nodes = getattr(c.air, 'nodes', {}) or {}
    if not sps:
        if any(e.kind in ('RTS', 'DMG DTS') for e in c.evs):
            r.skip('в расписании маяков нет SP (CBAP Only / нет Extended Schedule) — защищённого периода нет')
        dts = [e for e in c.evs if e.kind == 'DMG DTS' and e.tx_node is not None]
        for e in dts:
            r.bad(e, 'DMG DTS без SP в расписании — DTS определён для защищённого периода SP (10.39.6.6.2)', 'model')
        return r
    for e in c.k:
        if e.kind not in ('RTS', 'DMG DTS', 'DMG CTS'):
            continue
        sp = next((s for s in sps if s.start - tol <= e.t < s.end + tol), None)
        if sp is None:
            if e.kind == 'DMG DTS' and e.tx_node is not None:
                r.bad(e, 'DMG DTS вне SP (10.39.6.6.2)', 'model')
            continue
        p = c.prev.get(e.i)
        if e.kind == 'RTS':
            ms = PP.check_rts(e.t, e.dur if e.dur_ok else None, e.src, sp, tol=tol)
        elif e.kind == 'DMG DTS':
            ta = nodes.get(e.tx_node)
            rts_end = p.te if p is not None and p.kind == 'RTS' and p.src == sp.src else None
            ms = PP.check_dts(e.t, e.dur, ta if ta is not None else sp.dst, sp, rts_end=rts_end, tol=tol)
        else:
            if p is None or p.kind != 'RTS' or p.src != sp.src:
                continue
            ms = PP.check_cts_answer(p.te, e.t, tol=tol)
        for m in ms:
            r.bad(e, m)
        if not ms:
            r.ok()
    return r


# ---------------------------------------------------------------------------------------------------- 11.4
def r_addts(c):
    J = _j()
    r = J.Rule('addts', '11.4', 'DMG ADDTS Request/Response и DELTS (ref/tspec): DMG TSPEC (резерв, Allocation ID ≠ 0 '
               'в '
               'запросе и при успехе, 0 при отказе, формат и период), TS Delay ⇔ REJECTED_FOR_DELAY_PERIOD, TCLAS/'
               'TCLAS Processing/U-PID, пара (токен, AID), после SUCCESS — распределение в Extended Schedule, DELTS — '
               'DMG Allocation Info')
    reqs, admitted = {}, []
    for e in c.evs:
        a = _act(e, r, (TS.CATEGORY_QOS,), (TS.ACT_ADDTS_REQ, TS.ACT_ADDTS_RESP, TS.ACT_DELTS))
        if a is None or a[0] != TS.CATEGORY_QOS:
            continue
        if a[1] == TS.ACT_DELTS:
            try:
                d = TS.parse_delts(a[2])
            except ValueError as x:
                r.bad(e, f'DELTS: {x}')
                continue
            ms = TS.check_delts(d, deleting_alloc=d.ts_info == 0)
        elif a[1] in (TS.ACT_ADDTS_REQ, TS.ACT_ADDTS_RESP):
            try:
                f = TS.parse_addts(a[2])
            except (ValueError, F.FieldError) as x:
                r.bad(e, f'ADDTS: {x}')
                continue
            ms = TS.check_addts(f, src_is_ap=(e.src == c.ap) if c.ap else None)
            if f.action == TS.ACT_ADDTS_REQ:
                reqs[(e.src, e.dst, f.token)] = f
            else:
                q = reqs.pop((e.dst, e.src, f.token), None)
                if q is None:
                    r.skip('ADDTS Response без записанного запроса')
                else:
                    ms += TS.check_addts_pair(q, f)
                if f.variant == 'dmg' and f.status in TS.SUCCESS_CODES and e.t_ok:
                    admitted.append((e, f.dmg_tspec.info))
        else:
            continue
        for m in ms:
            r.bad(e, f'{e.action or e.kind}: {m}')
        if not ms:
            r.ok()
    by, bi_tu = _beacons_by_bi(c)
    for e, info in admitted:
        later = [b for k, b in by.items() if b.t > e.t]
        if not later:
            r.skip('после успешного DMG ADDTS нет маяков с телом — Extended Schedule не проверить')
            continue
        allocs = []
        for b in later[:4]:                     # СПОРНО: «delivering the Extended Schedule» — в ближайших BI
            infos = _beacon_els(b, E.EID_EXTENDED_SCHEDULE)
            try:
                allocs += E.parse_extended_schedule(infos) if infos else []
            except ValueError:
                pass
        ms = TS.check_schedule_has(info, allocs)
        for m in ms:
            r.bad(e, m, 'model')
        if not ms:
            r.ok()
    return r


# ---------------------------------------------------------------------------------------------------- 11.30
def r_spsh(c):
    J = _j()
    r = J.Rule('spsh', '11.30', 'spatial sharing (ref/spsh): Directional Channel Quality request/report (Method '
               'ANIPI/RSNI, резерв, Number of Time Blocks, подэлементы, класс/канал), отчёт по формату запроса, '
               'токены; совмещение SP по времени — после отчётов DCQ (should)')
    reqs, reporters = {}, set()
    aids = _aids(c)
    for e in c.evs:
        a = _act(e, r, (SS.CATEGORY_RM,), (SS.ACT_RM_REQ, SS.ACT_RM_REP))
        if a is None or not SS.is_rm(a[2]):
            continue
        try:
            act, tok, _, ms_ = SS.parse_rm(a[2])
        except (ValueError, F.FieldError) as x:
            r.bad(e, f'Radio Measurement: {x}')
            continue
        dcq = [m for m in ms_ if m.type == SS.TYPE_DCQ]
        if not dcq:
            continue
        ms = []
        if act == SS.ACT_RM_REQ:
            for k, m in enumerate(dcq, 1):
                ms += SS.check_dcq_req(m, k)
            reqs[(e.src, e.dst, tok)] = (a[2], e)
        else:
            q = reqs.pop((e.dst, e.src, tok), None)
            if q:
                ms = SS.check_rm_pair(q[0], a[2])
            else:
                ms = [x for k, m in enumerate(dcq, 1) for x in SS.check_dcq_rep(m, None, k)]
            if q is None:
                r.skip('DCQ report без записанного запроса')
            if e.src in aids:
                reporters.add((aids[e.src], e.t))
        for m in ms:
            r.bad(e, m)
        if not ms:
            r.ok()
    by, _ = _beacons_by_bi(c)
    seen_pairs = {}
    for k, b in by.items():
        infos = _beacon_els(b, E.EID_EXTENDED_SCHEDULE)
        if not infos:
            continue
        try:
            allocs = [a for a in E.parse_extended_schedule(infos) if E.ALLOC_IS_SP.get(a.ctrl['allocation_type'])]
        except ValueError:
            continue
        for x in range(len(allocs)):
            for y in range(x + 1, len(allocs)):
                A, B = allocs[x], allocs[y]
                if {A.src_aid, A.dst_aid} == {B.src_aid, B.dst_aid}:
                    continue
                if any(SS.overlaps(p, q) for p in E.allocation_blocks(A) for q in E.allocation_blocks(B)):
                    cand, exist = SS.SpPair(B.src_aid, B.dst_aid), SS.SpPair(A.src_aid, A.dst_aid)
                    before = {aid for aid, t in reporters if t < b.t}
                    ms = SS.check_overlap_allowed(cand, exist, before, seen_pairs.get(cand, False))
                    for m in ms:
                        r.bad(b, m, 'model')
                    if not ms:
                        r.ok()
        for A in allocs:
            seen_pairs[SS.SpPair(A.src_aid, A.dst_aid)] = True
    return r


# ---------------------------------------------------------------------------------------------------- RSNE / Ext / SOC
def r_rsne(c):
    J = _j()
    r = J.Rule('rsne', '9.4.2.24', 'RSNE DMG (ref/capelems): Version, допустимые шифры/AKM (табл. 9-149…9-151; '
               'умолчание DMG — GCMP-128), «Use group» и TKIP-ограничения, RSN Capabilities по роли, (Re)Association '
               'Request — один шифр и AKM из объявленных точкой, групповой — точки, MFPC/MFPR по табл. 12-5')
    ap_rsn, sta_rsn, gcmp = None, {}, Counter()
    for e, frame, els in _mgmt_elements(c):
        for el in els:
            if el.eid != E.EID_RSN or el.ext is not None:
                continue
            role = _role(c, e.src)
            ms = CE.check_rsne(el.info, role, frame)
            try:
                gcmp[CE.gcmp_supported_info(CE.rsn_effective(el.info))] += 1
            except ValueError:
                pass
            if role == E.ROLE_AP and frame in ('DMG Beacon', E.PROBE_RESP):
                ap_rsn = el.info
            if frame in (E.ASSOC_REQ, E.REASSOC_REQ) and role == E.ROLE_STA:
                sta_rsn[e.src] = el.info
                if ap_rsn is not None:
                    ms += CE.check_selection(ap_rsn, el.info)
                else:
                    r.skip('RSNE точки (DMG Beacon/Probe Response) не записан — выбор STA (12.6.3) не проверить')
            for m in ms:
                r.bad(e, f'{frame}: {m}')
            if not ms:
                r.ok()
        if frame in (E.ASSOC_RESP, E.REASSOC_RESP) and e.dst in sta_rsn and ap_rsn is not None:
            try:
                fx, _ = E.parse_body(frame, e.raw[24:])
            except (ValueError, NotImplementedError):
                continue
            ms = CE.check_assoc_status(ap_rsn, sta_rsn[e.dst], fx['status'])
            for m in ms:
                r.bad(e, m)
            if not ms:
                r.ok()
    if gcmp:
        r.info['парные шифры с GCMP-128 (12.5.5.1: DMG RSNA STA поддерживает GCMP-128)'] = dict(gcmp)
    return r


def r_ext_caps(c):
    J = _j()
    r = J.Rule('ext_caps', '9.4.2.26', 'Extended Capabilities (ref/capelems, табл. 9-153): резерв = 0, биты 80/84/QAB '
               '— только AP, Service Interval Granularity — при S-PSMP, Max Number Of MSDUs In A-MSDU — резерв у DMG')
    bits = Counter()
    for e, frame, els in _mgmt_elements(c):
        for el in els:
            if el.eid != 127 or el.ext is not None:
                continue
            ms = CE.check_ext_cap(el.info, _role(c, e.src))
            f = CE.parse_ext_cap(el.info)
            for name, v in f.items():
                if v and not name.startswith('_r') and name != 'rsv_high':
                    bits[name] += 1
            for m in ms:
                r.bad(e, f'{frame}: {m}')
            if not ms:
                r.ok()
    if bits:
        r.info['объявленные биты'] = dict(bits.most_common(12))
    return r


def r_op_classes(c):
    J = _j()
    r = J.Rule('op_classes', '9.4.2.53', 'Supported Operating Classes (ref/capelems): разбор (разделители 130/0, Duple '
               'List по возрастанию), класс в работе — DMG 60 ГГц (табл. E-4: 180/181) и среди Operating Classes')
    for e, frame, els in _mgmt_elements(c):
        for el in els:
            if el.eid != 59 or el.ext is not None:
                continue
            ms = CE.check_soc(el.info)
            for m in ms:
                r.bad(e, f'{frame}: {m}', 'model' if 'PLAN.md №68' in m else 'ours')
            if not ms:
                r.ok()
    return r


# ---------------------------------------------------------------------------------------------------- A-MPDU, QoS
def r_ampdu_limits(c):
    J = _j()
    r = J.Rule('ampdu_limits', '10.12.2', 'длина A-MPDU DMG (ref/ampdu): ≤ 262 143 (9.7.1) и ≤ Maximum A-MPDU Length '
               'Exponent DMG Capabilities получателя (табл. 9-251); групповой RA — минимум по связанным (10.12.4)')
    caps, _ = J._caps(c)
    stas = [x for m, x in caps.items() if m != c.ap]
    sizes = Counter()
    for e in c.evs:
        if not e.agg or e.length is None:
            continue
        group = e.dst is not None and F.is_group(e.dst)
        rx = None if group else caps.get(e.dst)
        if not group and rx is None:
            if e.length > AMP.DMG_AMPDU_MAX:
                r.bad(e, f'A-MPDU {e.length} октетов > 262 143 (9.7.1)')
            else:
                r.skip('DMG Capabilities получателя не записан — предел 10.12.2 неизвестен')
            continue
        lim = AMP.length_limit(rx, group, stas)
        sizes[e.length // 8192 * 8192] += 1
        if e.length > lim:
            r.bad(e, f'A-MPDU {e.length} октетов > предела {lim} (10.12.2{", 10.12.4" if group else ""})')
        else:
            r.ok()
    if sizes:
        r.info['длины A-MPDU (корзины по 8 КиБ)'] = dict(sorted(sizes.items()))
    return r


def r_qos_ctl(c):
    J = _j()
    r = J.Rule('qos_ctl', '9.2.4.5', 'QoS Control данных DMG (ref/qosctl): TID 8–15 — только с допущенным TS (табл. '
               '9-12), EOSP = 0 в CBAP с широковещательным Destination AID (9.2.4.5.3), групповые — No Ack без BA, '
               'Block '
               'Ack — только под BA, A-MSDU Type — резерв без A-MSDU Present')
    ba, ba_seen, ts = set(), set(), defaultdict(set)
    by, _ = _beacons_by_bi(c)
    cbap_only = any(getattr(b.p.params, 'cbap_only', 0) for b in by.values())
    any_addts = False
    for e in c.evs:
        if e.action == 'ADDBA Response' and e.body_ok and e.raw is not None:
            from . import blockack as BA
            try:
                p = BA.parse_addba_resp(e.raw[24:])
            except ValueError:
                continue
            ba_seen.add((e.dst, e.src, p.params.tid))
            if p.status == BA.STATUS_SUCCESS:
                ba.add((e.dst, e.src, p.params.tid))
            continue
        a = _act(e, None)
        if a is not None and TS.is_addts(a[2]) and a[1] == TS.ACT_ADDTS_RESP:
            any_addts = True
            try:
                f = TS.parse_addts(a[2])
            except (ValueError, F.FieldError):
                continue
            if f.status in TS.SUCCESS_CODES and f.tspec is not None and len(f.tspec.info) >= 3:
                tsid = f.tspec.info[0] >> 1 & 15             # рис. 9-299: TS Info B1–B4 TSID
                ts[frozenset((e.src, e.dst))].add(tsid)
            continue
        if e.kind not in ('A-MPDU', 'Data', 'QoS Null'):
            continue
        for raw in e.mpdus or ():
            q = J.qos_of(raw)
            if q is None:
                continue
            ta, ra = F.mac_str(raw[10:16]), F.mac_str(raw[4:10])
            key = (ta, ra, q['tid'])
            group = F.is_group(ra)
            # соглашение BA — индивидуальное (ADDBA к RA); у группового RA без GCR (DMG его не использует) его нет
            known = False if group else (key in ba) if key in ba_seen else None
            ms = QC.check(q['qos'], group=group, ba=known,
                          ts_tids=ts.get(frozenset((ta, ra)), set()) if any_addts else None,
                          dst_broadcast_alloc=cbap_only or None, null=q['null'], rd=True)
            verdicts = ['ours'] * len(ms)
            if q['tid'] >= 8 and not any_addts:
                ms.append(f'TID {q["tid"]} (TSID, табл. 9-12) — ADDTS в захвате нет')
                verdicts.append('capture')
            for m, v in zip(ms, verdicts):
                r.bad(e, m, v)
            if not ms:
                r.ok()
    return r


RULES = (r_info_req, r_qab, r_pcp_handover, r_prot_period, r_addts, r_spsh, r_rsne, r_ext_caps, r_op_classes,
         r_ampdu_limits, r_qos_ctl)

NOT_CHECKABLE = [
    ('info_resp_supported', '11.28.1', 'какие элементы отвечающий поддерживает (supported) — в записи не видно; судья '
     'проверяет только «пустой» ответ и формат (модель — ref/discovery.check_answer_content)'),
    ('pp_listening', '10.39.6.6.2', 'режим прослушивания, время в нём и NAV узла в SP запись не несёт; RTS при NAV ≠ 0 '
     'и '
     'ответ CTS/DTS по NAV не проверить (модель — ref/protperiod.PpStation)'),
    ('handover_implicit', '11.27.2.3', 'неявная передача — нужна потеря маяков PCP и кандидат в Next PCP List; open-'
     'точка — AP инфраструктуры, PBSS-кандидатов нет (модель — ref/handover.ImplicitCandidate)'),
    ('qab_peer', '11.35', 'QAB — между двумя AP; на стенде одна точка, ответчик/запросчик-сосед не записан (модель — '
     'ref/qab)'),
    ('spsh_measure', '11.30.2', 'значения ANIPI/RSNI и антенная конфигурация измерения — PHY, в записи нет (модель — '
     'ref/spsh.measurement_antenna)'),
    ('ampdu_spacing', '10.12.3', 'разделители A-MPDU и смещения MPDU запись не несёт (одна запись на MPDU) — Minimum '
     'MPDU Start Spacing и паддинг не проверить (модель — ref/ampdu.check)'),
    ('tspec_admission', '11.4.13', 'допуск SME и размещение по Minimum Allocation/Duration — should; проверяется лишь '
     'наличие распределения в Extended Schedule (модель — ref/tspec.check_isochronous)'),
]
