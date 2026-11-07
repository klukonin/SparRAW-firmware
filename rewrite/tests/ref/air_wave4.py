# SPDX-License-Identifier: AGPL-3.0-or-later
"""Правила судьи эфира (ref/air_judge) волны 4: кластеризация AP/PCP (10.40, 11.29.4, ref/cluster) и необязательные
возможности, которых в open нет (relay, MMS, multi-band/FST, энергосбережение — ref/optcaps).

cluster — по записям одного или нескольких узлов: маяки своей точки (Clustering Control, ECAPC Policy Enforced, биты
кластеризации DMG Capabilities, Beacon SP в Extended Schedule, ряд BTI), маяки других AP/PCP, принятые нашими узлами
(член ↔ S-AP: BI, копии полей, маяк члена в Beacon SP_n по TBTT S-AP из Timestamp; передачи нашей точки в чужих Beacon
SP; реакция на S-AP централизованного кластера), элементы ECAPC Policy / Cluster Report / Cluster Time Offset в наших
кадрах. Нет кластерных кадров — «не проверяемо» для правил кластера с причиной, проверяется согласованность
«кластеризация не используется».
opt_caps — каждый наш переданный кадр (TX-записи узлов): элементы/биты/кадры групп optcaps (вердикт ours).
Импорт air_judge — внутри функций."""
from collections import Counter, defaultdict

from . import cluster as CL
from . import elements as E
from . import optcaps as OC
from . import schedule as SC
from .timing import BCAST, aMinChannelTime

PAGE = {'10.40': 1908, '9.4.2.127': 1235}
MGMT_BODY = (E.PROBE_REQ, E.PROBE_RESP, E.ASSOC_REQ, E.ASSOC_RESP, E.REASSOC_REQ, E.REASSOC_RESP)
ACTION_KINDS = ('Action', 'Action No Ack')
CAT_UNPROT_DMG, ACT_ANNOUNCE = 20, 0
CAT_DMG, ACT_INFO_RESP = 16, 3


def _j():
    from . import air_judge as J
    return J


def _ours(c):
    return set((getattr(c.air, 'nodes', None) or {}).values()) | ({c.ap} if c.ap else set())


def _node_of(c, mac):
    return next((n for n, m in (getattr(c.air, 'nodes', None) or {}).items() if m == mac), None)


def _ap_caps(c):
    """DMG AP Or PCP Capability Information точки из её Probe/(Re)Association Response (последний) или None."""
    caps = None
    for e in c.evs:
        if e.kind in (E.PROBE_RESP, E.ASSOC_RESP, E.REASSOC_RESP) and e.src == c.ap and e.body_ok \
                and e.raw is not None and not e.synth:
            try:
                _, els = E.parse_body(e.kind, e.raw[24:])
            except (ValueError, NotImplementedError):
                continue
            for el in els:
                if el.eid == E.EID_DMG_CAPABILITIES and el.ext is None:
                    try:
                        caps = E.parse_dmg_capabilities(el.info).ap_pcp_cap
                    except ValueError:
                        pass
    return caps


def _action_elements(e):
    """(имя кадра, [Element]) для Announce / Information Response с телом или None."""
    if e.kind not in ACTION_KINDS or e.raw is None or not e.body_ok or len(e.raw) < 26:
        return None
    from . import fields as F
    if F.parse_fc(e.raw[:2]).protected:
        return None
    cat, act, body = e.raw[24], e.raw[25], e.raw[24:]
    try:
        if (cat, act) == (CAT_UNPROT_DMG, ACT_ANNOUNCE):
            return 'Announce', E.parse_elements(body[12:])        # табл. 9-487: Category, Action, Timestamp, BI
        if (cat, act) == (CAT_DMG, ACT_INFO_RESP):
            return 'Information Response', E.parse_elements(body[8:])   # табл. 9-461: … Subject Address
    except ValueError:
        return None
    return None


def _frames_with_elements(c):
    """[(событие, имя кадра, [Element])] наших TX-кадров с телом: (Re)Association Response, Announce, Information
    Response, прочие кадры управления."""
    out = []
    for e in c.evs:
        if e.synth or e.raw is None or not e.body_ok:
            continue
        if e.kind in MGMT_BODY:
            try:
                _, els = E.parse_body(e.kind, e.raw[24:])
            except (ValueError, NotImplementedError):
                continue
            out.append((e, e.kind, els))
        else:
            a = _action_elements(e)
            if a:
                out.append((e, a[0], a[1]))
    return out


def _change(e):
    """DMG BSS Parameter Change маяка (dict elements.parse_bss_param_change) или None."""
    for eid, ext, data in getattr(e.p, 'elements', None) or ():
        if eid == E.EID_DMG_BSS_PARAMETER_CHANGE and ext is None:
            try:
                return E.parse_bss_param_change(data)
            except ValueError:
                return None
    return None


def _beacon(e):
    p = e.p
    return dict(src=e.src, t=e.t, te=e.te, timestamp=p.timestamp, bi_tu=p.beacon_interval, cc=p.cc,
                ecapc=p.params.ecapc)


# ---------------------------------------------------------------------------------------------------- cluster
def r_cluster(c):
    J = _j()
    r = J.Rule('cluster', '10.40', 'кластеризация AP/PCP (ref/cluster): Clustering Control и ECAPC Policy Enforced '
               'маяков точки против DMG Capabilities, роль/Cluster ID, Beacon SP в Extended Schedule, CC в каждом '
               'маяке члена, S-AP — не реже aMinBTIPeriod BI; член ↔ S-AP (BI, копии, Beacon SP_n по Timestamp S-AP); '
               'передачи в чужих Beacon SP; реакция на S-AP с ECAPC = 1; ECAPC Policy / Cluster Report / Cluster Time '
               'Offset в наших кадрах (10.40.2–10.40.5)')
    caps = _ap_caps(c)
    beacons = [e for e in c.evs if e.kind == 'DMG Beacon' and e.p is not None and e.t is not None]
    own = [e for e in beacons if e.src == c.ap and e.tx_node]
    foreign = [e for e in beacons if e.src not in _ours(c)]
    if not own:
        r.skip('нет DMG Beacon точки с телом и временем')
    used = False
    last_role, last_ecapc = None, 0
    by_bi = {}
    for e in own:
        p = e.p
        cc = p.cc if not p.bic.discovery else None
        role = getattr(cc, 'member_role', None)
        used = used or role in (CL.ROLE_SAP, CL.ROLE_MEMBER) or bool(p.params.ecapc)
        ms = CL.check_own_beacon(c.ap, cc, p.params.ecapc, p.params.cbap_only, p.bic.discovery, caps)
        k = int(p.timestamp // int(CL.bi_us(p.beacon_interval))) if p.beacon_interval else None
        if k is not None and k not in by_bi:
            by_bi[k] = (cc, p.params.ecapc)
        if role in (CL.ROLE_SAP, CL.ROLE_MEMBER) and p.beacon_interval:
            ms += [(f'Clustering Control: {m}', 'ours') for m in
                   CL.check_cluster_params(p.beacon_interval, cc.cluster_max_mem, cc.beacon_sp_duration,
                                           p.params.ecapc, sap=role == CL.ROLE_SAP)]
            if role == CL.ROLE_SAP and CL.maxmem_ok(p.beacon_interval, cc.cluster_max_mem):
                try:
                    ents = SC.from_elements(p.elements) or []
                except (ValueError, SC.ScheduleError):
                    ents = []
                tbtt = p.timestamp - p.timestamp % int(CL.bi_us(p.beacon_interval))
                if not p.params.ecapc:          # централизованный: занятые смещения — из ECAPC Policy (кадры ниже)
                    ms += CL.check_beacon_sps_scheduled(ents, tbtt, 1, p.beacon_interval, cc.cluster_max_mem,
                                                        cc.beacon_sp_duration)
        last_role, last_ecapc = role, p.params.ecapc
        for m, v in ms:
            r.bad(e, f'DMG Beacon: {m}', v)
        if not ms:
            r.ok()
    for k, m, v in CL.check_beacon_series(sorted((k, cc, ec) for k, (cc, ec) in by_bi.items())):
        r.bad(None, f'BI {k}: {m}', v)
    chg = [(int(e.p.timestamp // int(CL.bi_us(e.p.beacon_interval))) if e.p.beacon_interval else 0,
            e.p.cc if not e.p.bic.discovery else None, _change(e)) for e in own]
    for k, m in CL.check_change_beacons(chg):
        r.bad(None, f'BI {k}: {m}')
    if own and not used:
        r.info['кластеризация точки'] = 'не используется (CC Present = 0 / роль 0, ECAPC Policy Enforced = 0)'
    if caps is not None:
        r.info['DMG Capabilities точки'] = dict(decentralized=caps.get('decentralized_clustering'),
                                                centralized=caps.get('centralized_clustering'))

    # ---- маяки других AP/PCP
    fcc = [e for e in foreign if e.p.cc is not None and not e.p.bic.discovery]
    if not fcc:
        r.skip('нет принятых маяков других AP/PCP с Clustering Control (член ↔ S-AP, чужие Beacon SP, S-AP с ECAPC = 1 '
               '— не проверяемы)')
    else:
        r.info['маяки других AP/PCP с CC'] = dict(Counter(f'{e.src} роль {e.p.cc.member_role} ECAPC '
                                                          f'{e.p.params.ecapc}' for e in fcc))
    saps = defaultdict(list)
    for e in fcc:
        if e.p.cc.member_role == CL.ROLE_SAP:
            saps[e.src].append(e)
    # наша точка — член: её маяки против маяка S-AP (ближайшего по времени)
    for e in own:
        cc = e.p.cc
        if getattr(cc, 'member_role', None) != CL.ROLE_MEMBER:
            continue
        sl = saps.get(cc.cluster_id)
        if not sl:
            r.skip('член кластера: маяк S-AP (Cluster ID) не записан')
            continue
        s = min(sl, key=lambda x: abs(x.t - e.t))
        ms = CL.check_member_vs_sap(_beacon(e), _beacon(s))
        if not ms and not e.p.params.ecapc:
            # децентрализованный член: Beacon SP других — в своём Extended Schedule (TSF члена: TBTT ≡ 0 mod BI)
            bi = e.p.beacon_interval
            n = CL.beacon_sp_of(e.t, e.te, CL.tbtt_from_beacon(s.t, s.p.timestamp, bi), bi, cc.cluster_max_mem,
                                cc.beacon_sp_duration)
            try:
                ents = SC.from_elements(e.p.elements) or []
            except (ValueError, SC.ScheduleError):
                ents = []
            tbtt = e.p.timestamp - e.p.timestamp % int(CL.bi_us(bi))
            ms += CL.check_beacon_sps_scheduled(ents, tbtt, n, bi, cc.cluster_max_mem, cc.beacon_sp_duration)
        for m, v in ms:
            r.bad(e, f'член ↔ S-AP {s.src}: {m}', v)
        if not ms:
            r.ok()
    # наша точка — S-AP: передачи наших узлов в Beacon SP других (децентрализованный — should, централизованный — shall)
    for e in own[:1]:
        cc = e.p.cc
        if getattr(cc, 'member_role', None) != CL.ROLE_SAP or not CL.maxmem_ok(e.p.beacon_interval, cc.cluster_max_mem):
            break
        members = [f for f in fcc if f.p.cc.member_role == CL.ROLE_MEMBER and f.p.cc.cluster_id == c.ap]
        if not members:
            r.skip('S-AP: маяки членов не записаны — чужие Beacon SP не проверяются')
            break
        tb = CL.tbtt_from_beacon(e.t, e.p.timestamp, e.p.beacon_interval)
        for x in c.k:
            if x.src not in _ours(c) or x.kind == 'DMG Beacon' or x.te is None:
                continue
            hit = CL.overlaps_beacon_sps(x.t, x.te, tb, e.p.beacon_interval, cc.cluster_max_mem,
                                         cc.beacon_sp_duration, skip={1})
            if hit:
                r.bad(x, f'передача в Beacon SP {sorted(hit)} другого члена (10.40.2.1 «should not transmit» / '
                         '10.40.2.2 «shall not transmit»)', 'ours' if e.p.params.ecapc else 'model')
            else:
                r.ok()
    # S-AP централизованного кластера, принятый нашей точкой: «shall either join … or cease its activity on this
    # channel»
    ec_saps = [f for f in fcc if f.p.params.ecapc and f.p.cc.member_role == CL.ROLE_SAP and 'AP' in (f.rx_nodes or ())]
    if ec_saps and own and last_role != CL.ROLE_MEMBER:
        t0 = ec_saps[0].t
        late = [e for e in own if e.t > t0 + aMinChannelTime
                and getattr(e.p.cc, 'member_role', None) != CL.ROLE_MEMBER]
        if late:
            r.bad(late[0], f'S-AP {ec_saps[0].src} с ECAPC Policy Enforced = 1 принят точкой, а она через '
                           f'aMinChannelTime продолжает BSS на канале вне его кластера (10.40.2.2: join или cease); '
                           'слепота (маяки S-AP на всех каналах) записью одного канала не проверяется', 'capture')
        else:
            r.ok()

    # наша точка — член: изменение параметров S-AP (11.29.4 «shall immediately insert the appropriate DMG BSS
    # Parameter Change element into its DMG Beacons»)
    for sb in [f for f in fcc if f.p.cc.member_role == CL.ROLE_SAP and CL.change_moves_beacon_sps(_change(f))]:
        mine = [e for e in own if e.t > sb.t and getattr(e.p.cc, 'member_role', None) == CL.ROLE_MEMBER
                and e.p.cc.cluster_id == sb.src]
        if mine:
            if _change(mine[0]) is None:
                r.bad(mine[0], f'член: S-AP {sb.src} объявил DMG BSS Parameter Change, а следующий маяк точки без него '
                               '(11.29.4)')
            else:
                r.ok()
    # Announce с широковещательным TA (10.40.5) — MCS 0
    for e in c.evs:
        if e.tx_node and e.src == BCAST and e.action == 'Announce' and e.mcs is not None:
            ms = CL.check_broadcast_announce(e.mcs)
            for m in ms:
                r.bad(e, m)
            if not ms:
                r.ok()

    # ---- элементы кластера в наших кадрах
    heard_by_sta = defaultdict(dict)        # STA MAC → {BSSID: последний маяк}
    sta_nodes = {m for n, m in (getattr(c.air, 'nodes', None) or {}).items() if m != c.ap}
    seen_any = False
    events = sorted([(e.tsort, 0, e) for e in foreign] + [(e.tsort, 1, x) for x in _frames_with_elements(c)
                                                          for e in [x[0]]], key=lambda y: (y[0], y[1]))
    for _, kind, x in events:
        if kind == 0:
            for n in x.rx_nodes or ():
                m = (getattr(c.air, 'nodes', None) or {}).get(n)
                if m in sta_nodes:
                    heard_by_sta[m][x.src] = dict(cc=x.p.cc if not x.p.bic.discovery else None, ecapc=x.p.params.ecapc,
                                                  schedules=[d for eid, ext, d in x.p.elements
                                                             if eid == E.EID_EXTENDED_SCHEDULE and ext is None],
                                                  gap=None)
            continue
        e, frame, els = x
        if e.src not in _ours(c):
            continue
        from_ap = e.src == c.ap
        has_policy = False
        for el in els:
            if el.ext is not None or el.eid not in (CL.EID_ECAPC_POLICY, CL.EID_CLUSTER_REPORT,
                                                    CL.EID_CLUSTER_TIME_OFFSET):
                continue
            seen_any = True
            ms = []
            try:
                if el.eid == CL.EID_ECAPC_POLICY:
                    has_policy = True
                    p, rsv = CL.parse_ecapc_policy(el.info)
                    role = last_role if from_ap else None
                    ms += [(m, 'ours') for m in CL.check_ecapc_policy(p, rsv, sender_role=role or CL.ROLE_SAP)]
                    if not from_ap:
                        ms.append(('ECAPC Policy от non-AP STA (10.40.2.2: включает S-AP/член)', 'model'))
                    elif not last_ecapc:
                        ms.append(('ECAPC Policy при ECAPC Policy Enforced = 0 в маяках точки (10.40.3.3 c), PLAN.md '
                                   '№87)', 'model'))
                elif el.eid == CL.EID_CLUSTER_TIME_OFFSET:
                    idx = CL.parse_cto(el.info)
                    ms += [(m, 'ours') for m in CL.check_cto(idx)]
                    if from_ap or frame != 'Information Response':
                        ms.append((f'Cluster Time Offset в {frame} от {"точки" if from_ap else "STA"}: шлёт вторая '
                                   'non-AP STA члена в Information Response (10.40.2.2)', 'model'))
                else:
                    rep, ctrl = CL.parse_cluster_report(el.info)
                    ms += [(m, 'ours') for m in CL.check_cluster_report(rep, ctrl)]
                    if from_ap:
                        ms.append(('Cluster Report от точки: шлёт non-AP STA своей точке (10.40.4, 10.40.5)', 'model'))
                    else:
                        node = _node_of(c, e.src)
                        heard = heard_by_sta.get(e.src) if node and any(node in (f.rx_nodes or ()) for f in foreign) \
                            else None
                        ms += CL.check_sta_report(rep, frame, e.dst, c.ap, heard, last_ecapc,
                                                   own[0].p.beacon_interval if own else None)
            except (ValueError, CL.ClusterError) as x2:
                ms.append((f'{E.element_name(el.eid)}: {x2}', 'ours'))
            for m, v in ms:
                r.bad(e, f'{frame}: {m}', v)
            if not ms:
                r.ok()
        if from_ap and last_ecapc and frame in (E.ASSOC_RESP, E.REASSOC_RESP, 'Announce', 'Information Response') \
                and not has_policy:
            r.bad(e, f'{frame} точки с ECAPC Policy Enforced = 1 без ECAPC Policy (10.40.2.2: «shall include»)')
    if not seen_any:
        r.skip('ECAPC Policy / Cluster Report / Cluster Time Offset в наших кадрах нет')
    return r


# ---------------------------------------------------------------------------------------------------- opt_caps
def r_opt_caps(c):
    J = _j()
    r = J.Rule('opt_caps', '9.4.2.127', 'необязательные возможности, которых в open нет (ref/optcaps): relay (Relay '
               'Capabilities/Transfer Parameter Set, DMG Action 8–22), MMS, multi-band/FST (Multi-band, Switching '
               'Stream, Session Transition, категория FST), энергосбережение (Triggered Unscheduled PS, биты PS '
               'Extended Capabilities, PS-элементы, PS-Poll/ATIM/PSC/WNM Sleep/TIM, Power Management = 1) — '
               '0/отсутствуют')
    ours = _ours(c)
    groups = Counter()
    for e in c.evs:
        if e.src not in ours or e.synth or not e.tx_node:
            continue
        ms = OC.check_frame_kind(e.kind)
        if e.fc is not None:
            ms += OC.check_fc_pm(e.fc, e.kind)
        if e.raw is not None and e.body_ok:
            if e.kind in MGMT_BODY:
                try:
                    fx, els = E.parse_body(e.kind, e.raw[24:])
                    ms += OC.check_capinfo(fx.get('capability') or {})
                    ms += OC.check_elements(els, e.kind)
                except (ValueError, NotImplementedError):
                    pass
            elif e.kind in ACTION_KINDS and len(e.raw) >= 26:
                from . import fields as F
                if not F.parse_fc(e.raw[:2]).protected:
                    ms += OC.check_action(e.raw[24:], e.src == c.ap)
                    a = _action_elements(e)
                    if a:
                        ms += OC.check_elements(a[1], a[0])
        if e.kind == 'DMG Beacon' and e.p is not None and getattr(e.p, 'elements', None) is not None:
            ms += OC.check_elements([E.Element(x[0], x[1], bytes(x[2])) for x in e.p.elements], 'DMG Beacon')
        for g, m in ms:
            groups[g] += 1
            r.bad(e, m)
        if not ms and (e.raw is not None or e.p is not None):
            r.ok()
    if groups:
        r.info['нарушения по группам'] = dict(groups)
    return r


RULES = (r_cluster, r_opt_caps)

NOT_CHECKABLE = [
    ('cluster_monitor', '10.40.2.1', 'прослушивание Beacon SP ≥ aMinChannelTime и выбор пустого — внутреннее '
     'состояние; по записи видно только итог (маяк члена в Beacon SP_n) (модель — ref/cluster.empty_beacon_sps, '
     'DecentralizedAp)'),
    ('cluster_ccsr', '10.40.2.2', 'конфигурация S-AP от CCSR и проверка CCSS — «not defined in this standard»; судья '
     'видит только ECAPC = 1 и ECAPC Policy (модель — ref/cluster.check_ccsr_config, verification_ok)'),
    ('cluster_blind', '10.40.2.2', 'слепота AP/PCP (маяки S-AP на всех каналах класса за aMinChannelTime) — запись '
     'одного канала её не показывает (модель — ref/cluster.ecapc_blind)'),
    ('cluster_handover', '10.40.3.2', 'передача роли S-AP — нужна потеря S-AP на 4 × aMinBTIPeriod BI и несколько '
     'членов; на стенде одна точка (модель — ref/cluster.DecentralizedAp.end_bi)'),
    ('cluster_txss_cbap', '10.40.3.4', 'TXSS в DTI внутри окон TXSS CBAP и BHI до TBTT + 8 × Beacon SP Duration — при '
     'ECAPC Policy с BHI/TXSS CBAP Enforced; в захватах их нет (модель — ref/cluster.txss_cbap_windows, bhi_deadline)'),
]
