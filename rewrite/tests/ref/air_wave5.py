# SPDX-License-Identifier: AGPL-3.0-or-later
"""Правила судьи эфира (ref/air_judge) волны 5 — закрытие частичных пунктов карты COVERAGE.md:

  addr          9.2.4.3   адреса по видам кадров (ref/addrs): TA индивидуальный, RA управления, Address 3 управления
                          (9.3.3.1 c), 11.17), BSSID, To DS/From DS (табл. 9-3/9-4), DMG Beacon;
  data_hdr      9.3.2.1   заголовок данных DMG (ref/addrs.check_data_header): только QoS Data/QoS Null, без HT
                          Control, QoS Null без тела (по длине PSDU — и у синтетических RX), адреса табл. 9-30;
  action_fmt    9.4.1.11  Action/Action No Ack (ref/actions): категория/действие по табл. 9-51 и таблицам 9.6,
                          допустимость для DMG, где разрешён Action No Ack (9.3.3.14), возврат нераспознанного
                          (10.28.4);
  wnm           11.21.1   функции WNM по битам 7–27 Extended Capabilities: не запрашивать неподдержанное, отказ на
                          неподдержанное (BTM), WNM STA ⇒ ECS и Radio Measurement (ref/actions);
  tpc           11.7.7    TPC Request/TPC Report (ref/tpc): токен, ответ, TPC Report в DMG Beacon/Probe Response/
                          Announce точки с Link Margin 0;
  tclas         9.4.2.30  TCLAS всех типов 0–10 в ADDTS/ADDBA/DMS наших кадров (ref/tclas);
  sta_avail     9.4.2.132 STA Availability (ref/staavail) и Poll к STA с PP Available = 0 (10.39.7.1);
  addba_ext     9.4.2.139 ADDBA Extension в ADDBA (ref/addbaext) и фрагменты по соглашению (10.2.6);
  asid_pattern  9.4.2.156 Antenna Sector ID Pattern (ref/sectorpat) и секторы маяков после него;
  timestamp     11.1.3.1  Timestamp: монотонность, разности против меток RX пира, смещение от TBTT, одна точка у
                          кадров одного класса (ref/tsf);
  sp_recovery   10.39.6.7 AP в SP между двумя non-AP STA — только по условиям ATI (ref/sprecovery, ref/sp);
  ecs           11.9      Max Channel Switch Time и OCV/SA Query после смены канала (ref/ecs);
  bf_training   11.36     обучение пары начинается с SLS (ref/bftrain).
Импорт air_judge — внутри функций (air_judge импортирует этот модуль)."""
from collections import Counter, defaultdict

from . import actions as AC
from . import addbaext as AX
from . import addrs as AD
from . import air_pcap as P
from . import bftrain as BF
from . import bi as BI
from . import capelems as CE
from . import chswitch as CS
from . import ecs as EC
from . import elements as E
from . import fields as F
from . import schedule as SC
from . import sectorpat as SPAT
from . import sprecovery as SR
from . import staavail as SA
from . import tclas as TC
from . import tpc as TP
from . import tsf as TS
from .timing import AID_AP_PCP

PAGE = {'9.2.4.3': 768, '9.3.2.1': 815, '9.4.1.11': 880, '11.21.1': 2256, '11.7.7': 2177, '9.4.2.30': 1078,
        '9.4.2.132': 1250, '9.4.2.139': 1260, '9.4.2.156': 1275, '11.1.3.1': 2050, '10.39.6.7': 1895, '11.9': 2189,
        '11.36': 2391}
CAPS_FRAMES = (E.ASSOC_REQ, E.ASSOC_RESP, E.REASSOC_REQ, E.REASSOC_RESP, E.PROBE_REQ, E.PROBE_RESP)
ACTION_KINDS = ('Action', 'Action No Ack', 'BRP')
EID_STA_AVAIL = SA.EID_STA_AVAILABILITY


def _j():
    from . import air_judge as J
    return J


def _ours(c):
    return set((getattr(c.air, 'nodes', None) or {}).values()) | ({c.ap} if c.ap else set())


def _pbss(c):
    return any(e.kind == 'DMG Beacon' and e.src == c.ap and e.p is not None
               and getattr(e.p.params, 'bss_type', None) == E.BSS_TYPE_PBSS for e in c.evs)


def _src_of(c, e):
    """Фактический передатчик TX-записи (MAC узла) или None."""
    return (getattr(c.air, 'nodes', None) or {}).get(e.tx_node) if e.tx_node else None


def _raws(e):
    """Заголовки MPDU, записанные байтами (TX/RX не синтетические)."""
    if e.synth:
        return []
    return [r for r in (e.mpdus or ([e.raw] if e.raw is not None else [])) if r is not None and len(r) >= 10]


def _mac_info(c):
    """{MAC: dict(ext_cap, capinfo, sta_cap, rsn)} — последние значения из TX-тел (Re)Association/Probe."""
    if getattr(c, '_w5_info', None) is not None:
        return c._w5_info
    out = defaultdict(lambda: dict(ext_cap=None, capinfo=None, sta_cap=None, rsn=None, ext_cap_ev=None))
    for e in c.evs:
        if e.kind not in CAPS_FRAMES or not e.body_ok or e.raw is None:
            continue
        try:
            fx, els = E.parse_body(e.kind, e.raw[24:])
        except (ValueError, NotImplementedError):
            continue
        d = out[e.src]
        if 'capability' in fx:
            d['capinfo'] = fx['capability']
        for el in els:
            try:
                if el.eid == AC.EID_EXT_CAP:
                    d['ext_cap'], d['ext_cap_ev'] = el.info, e
                elif el.eid == E.EID_DMG_CAPABILITIES and el.ext is None:
                    d['sta_cap'] = E.parse_dmg_capabilities(el.info).sta_cap
                elif el.eid == E.EID_RSN:
                    d['rsn'] = CE.rsn_effective(el.info).caps
            except ValueError:
                pass
    c._w5_info = out
    return out


def _actions_all(c):
    """[(событие, raw, Action No Ack, защищён, тело целиком)] всех записанных Action-кадров."""
    J = _j()
    out = []
    for e in c.evs:
        for raw, fc, full in J._mgmt_raws(e):
            if fc.subtype in (13, 14):
                out.append((e, raw, fc.subtype == 14, bool(fc.protected), full))
    return out


# ---------------------------------------------------------------------------------------------------- addr
def r_addr(c):
    J = _j()
    r = J.Rule('addr', '9.2.4.3', 'поля адресов (ref/addrs): Address 1 — получатель, Address 2 — передатчик (TA '
               'индивидуальный, 9.2.4.3.8), RA кадров управления по рисункам 9.3.1, Address 3/BSSID кадров управления '
               '(9.3.3.1 c), 11.17), To DS/From DS (табл. 9-3, 9-4), адреса данных (табл. 9-30)')
    ours, pbss, n_syn = _ours(c), _pbss(c), 0
    for e in c.evs:
        if e.synth:
            n_syn += 1
            continue
        if not e.tx_node and e.src not in ours:
            continue
        src = _src_of(c, e)
        for raw in _raws(e):
            kind = P.classify(raw)[2]
            ms = AD.check_addresses(raw, kind, c.ap, pbss, src if raw is e.raw else None)
            for m, v in ms:
                r.bad(e, f'{kind}: {m}', v)
            if not ms:
                r.ok()
    if n_syn:
        r.skip('синтетический RX: адреса восстановлены парсером, не записаны', n_syn)
    return r


# ---------------------------------------------------------------------------------------------------- data_hdr
def r_data_hdr(c):
    J = _j()
    r = J.Rule('data_hdr', '9.3.2.1', 'заголовок данных DMG: только QoS Data/QoS Null (9.3.2.1.5 NOTE 1), без HT '
               'Control (NOTE 2), QoS Null без тела (9.3.2.1.4), адреса табл. 9-30')
    pbss = _pbss(c)
    for e in c.evs:
        if e.kind not in ('Data', 'QoS Null', 'A-MPDU'):
            continue
        hdrs = [m for m in _raws(e) if F.parse_fc(m[:2]).type == F.TYPE_DATA]
        if not hdrs:
            if e.kind == 'QoS Null' and e.length is not None and not e.agg:
                want = AD.DATA_HDR + AD.QOS_LEN + AD.FCS_LEN
                if e.length not in (want, want + AD.A4_LEN):
                    r.bad(e, f'QoS Null (синтетический RX): PSDU {e.length} октетов — тело QoS Null пустое, PSDU = '
                             f'заголовок + FCS = {want} (9.3.2.1.4)')
                else:
                    r.ok()
                continue
            r.skip('заголовок данных не записан (синтетический RX или TX без txqos) — проверена только длина QoS Null')
            continue
        for m in hdrs:
            ms = AD.check_data_header(m, None if e.agg else e.length, c.ap, pbss, e.agg,
                                      _src_of(c, e) if m is e.raw else None)
            for msg, v in ms:
                r.bad(e, msg, v)
            if not ms:
                r.ok()
    return r


# ---------------------------------------------------------------------------------------------------- action_fmt
def _ati_bis(c):
    J = _j()
    by, bi_tu = J._btis(c)
    return {k for k, bs in by.items() if bs[0].p.bic is not None and bs[0].p.bic.ati_present}, bi_tu


def r_action_fmt(c):
    J = _j()
    r = J.Rule('action_fmt', '9.4.1.11', 'Action/Action No Ack (ref/actions): категория и действие по табл. 9-51 и '
               'таблицам 9.6, допустимость для DMG, Action No Ack только где разрешён (9.3.3.14, 9.6.6.4/5, 9.6.19.5, '
               '9.6.21), индивидуальный запрос ATI не No Ack (10.39.3), возврат нераспознанного (10.28.4)')
    ours = _ours(c)
    ati, bi_tu = _ati_bis(c)
    st = Counter()
    rx_unknown = []
    tx_by = defaultdict(list)
    for e, raw, noack, prot, full in _actions_all(c):
        if len(raw) < 25:
            continue
        a1 = F.mac_str(raw[4:10])
        group = F.is_group(a1)
        body = raw[24:]
        if prot:
            r.skip('защищённый Action: категория зашифрована — не проверяемо')
            continue
        if e.tx_node or e.src in ours:
            tx_by[(e.src, a1)].append((e, body))
            in_ati = (e.src == c.ap and e.t_ok and bi_tu is not None and BI.bi_index(e.t, bi_tu) in ati)
            a = AC.classify(body)
            st[a.status] += 1
            echo = body[0] & AC.CAT_ERROR_BIT and any(AC.check_echo(b, body) == [] for _, b in rx_unknown)
            for m, v in AC.check_action(body, noack, group, in_ati=in_ati, echo_of=b'' if echo else None):
                r.bad(e, m, v)
            r.ok()
        elif e.rx_nodes and not group and a1 in ours and AC.must_echo(body, group):
            rx_unknown.append((e, body))
    # 10.28.4: принятый нашим узлом индивидуальный Action с категорией Reserved — вернуть с MSB = 1
    for e, body in rx_unknown:
        back = [b for x, b in tx_by.get((F.mac_str(e.raw[4:10]), e.src), ()) if x.t_ok and e.t_ok and x.t > e.t]
        if any(AC.check_echo(body, b) == [] for b in back):
            r.ok()
        else:
            r.bad(e, f'Action категории {body[0]} (Reserved) принят нашим узлом — не возвращён с MSB = 1 (10.28.4)')
    r.info['by_status'] = dict(st)
    return r


# ---------------------------------------------------------------------------------------------------- wnm
def r_wnm(c):
    J = _j()
    r = J.Rule('wnm', '11.21.1', 'функции WNM (9.6.13.1, табл. 9-425/9-434) по битам 7–27 Extended Capabilities: '
               'не запрашивать функцию с битом 0 у получателя, отказ на запрос неподдержанной (BTM Status), WNM STA ⇒ '
               'Extended Channel Switching и Radio Measurement, Ext Cap в кадрах ассоциации/Probe')
    info, ours = _mac_info(c), _ours(c)
    for mac, d in info.items():
        if mac not in ours or d['ext_cap'] is None:
            continue
        rm = d['capinfo'].get('radio_measurement') if d['capinfo'] else None
        for m, v in AC.check_wnm_caps(d['ext_cap'], rm):
            r.bad(d['ext_cap_ev'], m, v)
        r.ok()
        bits = AC.wnm_bits(d['ext_cap'])
        if any(bits[b] for b in AC.WNM_BITS):
            for e in c.evs:
                if e.src == mac and e.kind in CAPS_FRAMES and e.body_ok and e.raw is not None:
                    try:
                        _, els = E.parse_body(e.kind, e.raw[24:])
                    except (ValueError, NotImplementedError):
                        continue
                    if not any(el.eid == AC.EID_EXT_CAP for el in els):
                        r.bad(e, f'{e.kind} без Extended Capabilities при битах WNM = 1 — «shall be included» '
                                 f'(11.21.1)')
    n = 0
    for e, raw, noack, prot, full in _actions_all(c):
        if prot or len(raw) < 26 or raw[24] not in (10, 11) or e.src not in ours:
            continue
        cat, act = raw[24], raw[25]
        dst = F.mac_str(raw[4:10])
        peer = info.get(dst)
        n += 1
        pb = AC.wnm_bits(peer['ext_cap']) if peer and peer['ext_cap'] is not None else None
        for m in AC.check_wnm_request(cat, act, pb):
            r.bad(e, m)
        own = info.get(e.src)
        ob = AC.wnm_bits(own['ext_cap']) if own and own['ext_cap'] is not None else None
        try:
            ms, known = AC.check_wnm_response(cat, act, raw[24:], ob)
        except ValueError as x:
            ms, known = [str(x)], True
        for m in ms:
            r.bad(e, m)
        if known is None:
            r.skip('ответ WNM: статус отказа не разбирается (кроме BTM; DMS — правило dms)')
        r.ok()
    if not n:
        r.skip('WNM Action наших узлов в захвате нет')
    return r


# ---------------------------------------------------------------------------------------------------- tpc
def _ap_flags(c):
    d = _mac_info(c).get(c.ap)
    ci = d['capinfo'] if d else None
    sc = d['sta_cap'] if d else None
    return (ci.get('spectrum_mgmt') if ci else None, ci.get('radio_measurement') if ci else None,
            sc.get('tpc') if sc else None)


def _tpc_of(els):
    return next((x[2] for x in els if x[0] == TP.EID_TPC_REPORT and x[1] is None), None)


def r_tpc(c):
    J = _j()
    from . import air_wave4 as W4
    r = J.Rule('tpc', '11.7.7', 'TPC (ref/tpc): TPC Request — токен ≠ 0, ответ TPC Report с токеном запроса (9.6.2.4/'
               '9.6.2.5, 11.7.7 «shall respond»); TPC Report в DMG Beacon/Probe Response/Announce точки при Spectrum '
               'Management/Radio Measurement, Link Margin 0')
    sm, rm, tpc_cap = _ap_flags(c)
    ours = _ours(c)
    if sm is None:
        r.skip('Capability Information точки не записана (нет Probe/Association Response) — обязательность TPC Report '
               'не определить')
    else:
        for e in c.evs:
            if e.src != c.ap or e.synth:
                continue
            kind, els = None, None
            if e.kind == 'DMG Beacon' and e.p is not None and e.tx_node:
                kind, els = 'DMG Beacon', [(a, b, d) for a, b, d in e.p.elements]
            elif e.kind == E.PROBE_RESP and e.body_ok and e.raw is not None:
                try:
                    _, xs = E.parse_body(e.kind, e.raw[24:])
                    kind, els = E.PROBE_RESP, [(x.eid, x.ext, x.info) for x in xs]
                except (ValueError, NotImplementedError):
                    pass
            else:
                a = W4._action_elements(e)
                if a and a[0] == 'Announce':
                    kind, els = 'Announce', [(x.eid, x.ext, x.info) for x in a[1]]
            if kind is None:
                continue
            ms = TP.check_frame_element(kind, _tpc_of(els), sm, rm)
            for m in ms:
                r.bad(e, m)
            if not ms:
                r.ok()
    reqs = []
    for e, raw, noack, prot, full in _actions_all(c):
        if prot or len(raw) < 27 or raw[24] != TP.CAT_SPECTRUM or raw[25] not in (TP.ACT_TPC_REQUEST,
                                                                                    TP.ACT_TPC_REPORT):
            continue
        try:
            f = TP.parse_tpc_frame(raw[24:])
        except ValueError as x:
            if e.src in ours:
                r.bad(e, str(x))
            continue
        a1 = F.mac_str(raw[4:10])
        if f.kind == 'request':
            if e.src in ours:
                for m in TP.check_request(f):
                    r.bad(e, m)
                r.ok()
            if a1 in ours:
                reqs.append((e, f, a1))
        else:
            q = next((x for x in reqs if x[2] == e.src and x[0].src == a1), None)
            if q is not None and e.src in ours:
                for m in TP.check_report(q[1], f):
                    r.bad(e, m)
                reqs.remove(q)
                r.ok()
    for e, f, me in reqs:
        d = _mac_info(c).get(me) or {}
        smx = (d.get('capinfo') or {}).get('spectrum_mgmt')
        tcx = (d.get('sta_cap') or {}).get('tpc')
        must = TP.must_respond(smx, tcx)
        if must is False:
            continue
        r.bad(e, f'TPC Request к {me} без TPC Report в ответ — «shall respond with a TPC Report frame» (11.7.7)',
              'ours' if must else 'model')
    if not r.checked:
        r.skip('TPC-кадров и обязательных TPC Report в захвате нет')
    r.info['ap_spectrum_mgmt_rm_tpc'] = (sm, rm, tpc_cap)
    return r


# ---------------------------------------------------------------------------------------------------- tclas
TCLAS_FRAMES = {(1, 0): ('addts', 3), (1, 1): ('addts', 5), (3, 0): ('addba', AX.ADDBA_FIXED_REQ),
                (3, 1): ('addba', AX.ADDBA_FIXED_RESP)}


def _tclas_list(body):
    """[(вид кадра, информация TCLAS)] в теле ADDTS/ADDBA/DMS."""
    key = (body[0], body[1])
    if key in TCLAS_FRAMES:
        where, off = TCLAS_FRAMES[key]
        return [(where, el.info) for el in E.parse_elements(body[off:]) if el.eid == TC.EID_TCLAS]
    if key in ((10, 23), (10, 24)):
        from . import dms as DM
        f = DM.parse_frame(body)
        out = []
        for item in f.items:
            for t in item.tclas:
                out.append(('dms', DM.encode_tclas(t)[2:]))
        return out
    return []


def r_tclas(c):
    J = _j()
    r = J.Rule('tclas', '9.4.2.30', 'TCLAS всех типов 0–10 (ref/tclas): User Priority (табл. 9-163), Classifier Type '
               '(табл. 9-164), длины по рисункам 9-304…9-327, резервные биты маски/полей, тип 4 — бит Version, '
               'PV1-типы 7–9 у DMG, DMS — только 0, 1, 4; в ADDTS/ADDBA/DMS наших кадров')
    ours, by = _ours(c), Counter()
    for e, raw, noack, prot, full in _actions_all(c):
        if prot or e.src not in ours or len(raw) < 27 or not full:
            continue
        try:
            items = _tclas_list(raw[24:])
        except (ValueError, AttributeError, KeyError) as x:
            r.skip(f'тело ADDTS/ADDBA/DMS не разобрано ({type(x).__name__})')
            continue
        for where, info in items:
            try:
                t = TC.parse(info)
            except ValueError as x:
                r.bad(e, f'TCLAS ({where}): {x}')
                continue
            by[(where, t.ctype)] += 1
            ms = TC.check(t) + TC.check_in_frame(t, where)
            for m, v in ms:
                r.bad(e, f'TCLAS ({where}): {m}', v)
            if not ms:
                r.ok()
    r.info['by_frame_type'] = {f'{w}/{t}': n for (w, t), n in by.items()}
    if not r.checked:
        r.skip('TCLAS в ADDTS/ADDBA/DMS наших кадров нет')
    return r


# ---------------------------------------------------------------------------------------------------- sta_avail
def _frame_elements(c, e):
    """(вид, [(eid, ext, info)]) элементов кадра: DMG Beacon, Announce, Information Request/Response, кадры
    CAPS_FRAMES — или None."""
    from . import air_wave4 as W4
    if e.kind == 'DMG Beacon' and e.p is not None and e.tx_node:
        return 'DMG Beacon', [(a, b, d) for a, b, d in e.p.elements]
    if e.kind in CAPS_FRAMES and e.body_ok and e.raw is not None:
        try:
            _, xs = E.parse_body(e.kind, e.raw[24:])
            return e.kind, [(x.eid, x.ext, x.info) for x in xs]
        except (ValueError, NotImplementedError):
            return None
    a = W4._action_elements(e)
    if a:
        return a[0], [(x.eid, x.ext, x.info) for x in a[1]]
    if e.kind in ('Action', 'Action No Ack') and e.raw is not None and e.body_ok and len(e.raw) > 26 \
            and (e.raw[24], e.raw[25]) == (16, 2):
        from . import bssparams as BP
        try:
            return 'Information Request', [(x.eid, x.ext, x.info) for x in BP.parse_info(e.raw[24:]).elements]
        except (ValueError, F.FieldError):
            return None
    return None


def r_sta_avail(c):
    J = _j()
    from . import air_sched as AS
    r = J.Rule('sta_avail', '9.4.2.132', 'STA Availability (ref/staavail): Length n × 2, резерв, AID ≠ 0/255, без '
               'повторов, STA — о себе, CBAP = 0 без энергосбережения; Poll к STA с PP Available = 0 (10.39.7.1)')
    aids = AS._aids(c)
    assoc = {a for m, a in aids.items() if m != c.ap}
    pp = SA.PpAvailability()
    ours, n = _ours(c), 0
    for e in sorted((x for x in c.evs if x.t_ok), key=lambda x: x.t):
        if e.kind == 'Poll' and e.src == c.ap:
            if not pp.poll_allowed(e.dst):
                r.bad(e, f'Poll к {e.dst} после STA Availability с PP Available = 0 — «shall not transmit Poll '
                         f'frames» (10.39.7.1)')
            else:
                r.ok()
            continue
        if e.synth:
            continue
        fe = _frame_elements(c, e)
        if fe is None:
            continue
        kind, els = fe
        for eid, ext, info in els:
            if eid != EID_STA_AVAIL or ext is not None:
                continue
            n += 1
            try:
                infos = SA.parse(info)
            except ValueError as x:
                if e.src in ours:
                    r.bad(e, f'{kind}: {x}')
                continue
            if e.src != c.ap:
                pp.on_element(e.src, aids.get(e.src), infos)
            if e.src not in ours:
                continue
            ms = SA.check(infos, e.src == c.ap, aids.get(e.src), assoc if assoc else None)
            for m, v in ms:
                r.bad(e, f'{kind}: {m}', v)
            if not ms:
                r.ok()
    r.info['pp_available'] = pp.as_map()
    if not n:
        r.skip('STA Availability в захвате нет (динамическое распределение/энергосбережение не используются)')
    return r


# ---------------------------------------------------------------------------------------------------- addba_ext
def r_addba_ext(c):
    J = _j()
    from . import blockack as BA
    r = J.Rule('addba_ext', '9.4.2.139', 'ADDBA Extension (ref/addbaext): Length 1, B1–B7 = 0, порядок необязательных '
               'элементов ADDBA (табл. 9-360/9-361); фрагменты по соглашению — только при No-Fragmentation = 0, вне '
               'A-MPDU, Normal Ack (10.2.6)')
    ours = _ours(c)
    reqs, agr = {}, {}
    for e, raw, noack, prot, full in _actions_all(c):
        if prot or len(raw) < 26 or raw[24] != 3 or raw[25] not in (0, 1) or not full:
            continue
        resp = raw[25] == 1
        ms, ext = AX.check_frame(raw[24:], resp)
        if e.src in ours:
            for m in ms:
                r.bad(e, m)
            r.ok()
        try:
            if not resp:
                q = BA.parse_addba_req(raw[24:])
                reqs[(e.src, F.mac_str(raw[4:10]), q.token)] = (q, ext)
            else:
                p = BA.parse_addba_resp(raw[24:])
                k = (F.mac_str(raw[4:10]), e.src, p.token)
                if k in reqs and p.status == 0:
                    q, qext = reqs[k]
                    agr[(k[0], k[1], q.params.tid)] = AX.Agreement(qext, ext)
        except (ValueError, AttributeError):
            continue
    nf = 0
    for e in c.evs:
        for m in _raws(e):
            fc = F.parse_fc(m[:2])
            if fc.type != F.TYPE_DATA or not fc.subtype & 8 or len(m) < 26:
                continue
            q = J.qos_of(m)
            if q is None or not (fc.more_frag or q['fn']):
                continue
            a = agr.get((F.mac_str(m[10:16]), F.mac_str(m[4:10]), q['tid']))
            if a is None:
                continue
            nf += 1
            for msg in a.check_fragment(e.agg, q['ackpol']):
                r.bad(e, msg)
            r.ok()
    r.info['agreements'] = len(agr)
    r.info['fragments_under_ba'] = nf
    if not nf:
        r.skip('фрагментов данных по соглашению Block Ack в записи нет (заголовки данных — только с rxqos/txqos)')
    return r


# ---------------------------------------------------------------------------------------------------- asid_pattern
def r_asid_pattern(c):
    J = _j()
    r = J.Rule('asid_pattern', '9.4.2.156', 'Antenna Sector ID Pattern (ref/sectorpat): Type 0, Length 4, отводы '
               'максимальной длины, только Probe Response/PSC-RSP; секторы DMG Beacon точки после элемента — по '
               'генераторам рис. 9-605/9-606')
    beacons = sorted((e for e in c.k if e.kind == 'DMG Beacon' and e.src == c.ap and e.p is not None and e.tx_node),
                     key=lambda e: e.t)
    n = 0
    for e in c.evs:
        if e.src != c.ap or e.synth:
            continue
        fe = _frame_elements(c, e)
        if fe is None:
            continue
        kind, els = fe
        for eid, ext, info in els:
            if eid != SPAT.EID_ASID_PATTERN or ext is not None:
                continue
            n += 1
            try:
                p = SPAT.parse(info)
            except ValueError as x:
                r.bad(e, f'{kind}: {x}')
                continue
            bad = SPAT.check(p, kind)
            for m in bad:
                r.bad(e, f'{kind}: {m}')
            after = [b for b in beacons if e.t_ok and b.t > e.t]
            if after and not bad:
                # маяки до следующего такого элемента; одно нарушение на элемент (число расхождений — в тексте)
                nxt = next((x.t for x in c.evs if x is not e and x.src == c.ap and x.kind == e.kind and x.t_ok
                            and x.t > e.t), None)
                after = [b for b in after if nxt is None or b.t < nxt]
                nsec = after[0].p.ssw.cdown + 1
                mm = SPAT.check_beacons(p, nsec, [b.p.ssw.sector_id for b in after])
                if mm:
                    r.bad(after[mm[0][0]], f'{mm[0][1]}; расхождений {len(mm)} из {len(after)}')
            elif bad:
                r.skip('элемент недействителен — секторы маяков по нему не сверяются')
            r.ok()
    if not n:
        r.skip('Antenna Sector ID Pattern точка не передаёт (энергосбережения в open нет — элемент не нужен)')
    return r


# ---------------------------------------------------------------------------------------------------- timestamp
def _rx_stamp(c, e, node):
    for n, k in e.recs or ():
        q = c.recs.get(n, {}).get(k)
        if n == node and q is not None and not q.tx and q.tsft is not None:
            return q.tsft
    return None


def _tx_stamp(c, e):
    for n, k in e.recs or ():
        q = c.recs.get(n, {}).get(k)
        if q is not None and q.tx and q.tsft is not None:
            return q.tsft
    return None


def r_timestamp(c):
    J = _j()
    r = J.Rule('timestamp', '11.1.3.1', 'Timestamp (ref/tsf): монотонен с временем эфира, разности равны разностям '
               'меток RX пира (± квант и 2·aDMGTSFAccuracy), первый маяк BI — не раньше TBTT + преамбула control, '
               'одна точка (Timestamp − метка TX) у кадров одного класса')
    bs = sorted((e for e in c.k if e.kind == 'DMG Beacon' and e.src == c.ap and e.p is not None and e.tx_node),
                key=lambda e: e.t)
    if not bs:
        r.skip('нет DMG Beacon точки с телом и временем')
        return r
    for i, m in TS.check_monotonic([(b.t, b.p.timestamp) for b in bs]):
        r.bad(bs[i], m)
    r.ok(len(bs))
    bi_tu = bs[0].p.beacon_interval
    seen = set()
    for b in bs:
        k = int(b.p.timestamp // int(bi_tu * 1024)) if bi_tu else None
        if k is None or k in seen:
            continue
        seen.add(k)
        m = TS.check_tbtt_offset(b.p.timestamp, bi_tu, P.PRE['control'])
        if m:
            r.bad(b, m)
        else:
            r.ok()
    nodes = {n for n, mac in (getattr(c.air, 'nodes', None) or {}).items() if mac != c.ap}
    for node in nodes:
        seq = [(_rx_stamp(c, b, node), b.p.timestamp, b) for b in bs]
        seq = [x for x in seq if x[0] is not None]
        if len(seq) < 2:
            r.skip(f'маяков, принятых {node} с меткой RX, < 2')
            continue
        for i, m in TS.check_deltas([(a, s) for a, s, _ in seq]):
            r.bad(seq[i][2], f'{node}: {m}')
        r.ok(len(seq) - 1)
    pts = [(b.p.timestamp, _tx_stamp(c, b)) for b in bs]
    pts = [x for x in pts if x[1] is not None]
    for i, m in TS.check_same_point(pts):
        r.bad(bs[i], f'DMG Beacon: {m}')
    # кадры SC с Timestamp (Probe Response, Announce) точки: время событий — TSF точки (опорный узел), значит
    # Timestamp ≈ начало PPDU + преамбула и заголовок SC (точка 11.1.3.1, допущение air_pcap.PRE)
    n_sc = 0
    for e in c.k:
        if e.src != c.ap or not e.tx_node or not e.body_ok or e.raw is None or len(e.raw) < 34:
            continue
        if e.kind == E.PROBE_RESP:
            ts, what = int.from_bytes(e.raw[24:32], 'little'), 'Probe Response'
        elif e.action == 'Announce':
            ts, what = int.from_bytes(e.raw[26:34], 'little'), 'Announce'
        else:
            continue
        n_sc += 1
        m = TS.check_anchor(ts, e.t, P.PRE[P.mode_of(e.mcs or 0)], J.PRE_UNCERT + J.CAL_UNCERT)
        if m:
            r.bad(e, f'{what}: {m}')
        else:
            r.ok()
    r.info['sc_frames_with_timestamp'] = n_sc
    r.verdict_note = 'точка Timestamp относительно антенны (11.1.3.1) — NOT_CHECKABLE timestamp_point; здесь — то, ' \
                     'что от неё не зависит'
    return r


# ---------------------------------------------------------------------------------------------------- sp_recovery
def reclaimed_keys(c, k, bi_tu, aids):
    """Ключи SP BI k, которые AP может забрать (10.39.6.7): Extended Schedule в Announce AP в ATI этого BI и ответы
    STA в ATI. Кэш в контексте."""
    cache = getattr(c, '_w5_reclaim', None)
    if cache is None:
        cache = c._w5_reclaim = {}
    if k in cache:
        return cache[k]
    from . import air_wave4 as W4
    J = _j()
    t0, t1 = BI.tbtt(k, bi_tu), BI.tbtt(k + 1, bi_tu)
    ann = [e for e in c.k if t0 <= e.t < t1 and e.src == c.ap and e.action == 'Announce']
    ents = []
    for e in ann:
        a = W4._action_elements(e)
        if a and a[0] == 'Announce':
            try:
                ents += SC.from_elements([(x.eid, x.ext, x.info) for x in a[1]]) or []
            except (ValueError, SC.ScheduleError):
                pass
    keys = set()
    if ents:
        lo, hi = ann[0].t, ann[-1].te + 2 * J.SIFS + 200
        log = [(e.t, e.te, e.src, e.dst, e.kind) for e in c.k if lo <= e.t <= hi]
        resp = SR.ati_responders(log, c.ap, q=J.Q + J.CAL_UNCERT + J.PRE_UNCERT)
        mac_of = {a: m for m, a in aids.items()}
        mac_of.setdefault(AID_AP_PCP, c.ap)
        keys = SR.reclaimable(ents, resp, mac_of)
    cache[k] = keys
    return keys


def r_sp_recovery(c):
    J = _j()
    from . import air_sched as AS
    r = J.Rule('sp_recovery', '10.39.6.7', 'восстановление SP: AP передаёт в SP между двумя non-AP STA только если SP '
               'объявлен в Extended Schedule в ATI и хотя бы одна из пары не ответила в ATI (ref/sprecovery), или '
               'после возврата времени; AP-получатель — после dot11SPIdleTimeout в Truncatable (sp_recovery в '
               'sp_access)')
    if not AS._has_sp(c):
        r.skip('в расписании нет SP — 10.39.6.7 не применим')
        return r
    n_rec = 0
    for k, (v, idx, err, per) in AS._dti(c).items():
        if err is not None:
            r.skip(f'BI {k}: журнал не разобран ({err})')
            continue
        ev = {i: e for i, e in enumerate(idx)}
        bad = [x for x in v if x.rule == 'sp_foreign' and '10.39.6.7' in x.msg]
        for x in bad:
            r.bad(ev.get(x.idx), x.msg)
        sps = [p for p in per if p.kind == SC.SP and p.alloc is not None
               and AID_AP_PCP not in (p.src_aid, p.dst_aid) and p.src_aid != 255 and p.dst_aid != 255]
        r.ok(max(0, len(sps) - len(bad)))
        n_rec += len(getattr(c, '_w5_reclaim', {}).get(k, ()))
    r.info['reclaimable_sp'] = n_rec
    return r


# ---------------------------------------------------------------------------------------------------- ecs
def r_ecs(c):
    J = _j()
    r = J.Rule('ecs', '11.9', 'ECS сверх ecsa (ref/ecs): Max Channel Switch Time — только с ECSA, не при Count 0, в '
               'DMG Beacon не предусмотрен; первый маяк после смены — не позже Switch Time; OCV: SA Query STA после '
               'смены при OCVC у AP и STA (11.9.3.2)')
    info = _mac_info(c)
    mcst_tu, n = None, 0
    for e in c.evs:
        if e.src != c.ap or e.synth:
            continue
        fe = _frame_elements(c, e)
        if fe is None or fe[0] not in ('DMG Beacon', E.PROBE_RESP):
            continue
        kind, els = fe
        m_info = next((x[2] for x in els if (x[0], x[1]) == EC.EID_MCST), None)
        ecsa = None
        for eid, ext, data in els:
            if eid == CS.EID_ECSA:
                try:
                    ecsa = CS.parse_ecsa(data)
                except ValueError:
                    pass
        if m_info is None:
            continue
        n += 1
        for m, v in EC.check_mcst_in_frame(kind, m_info, ecsa):
            r.bad(e, m, v)
        try:
            mcst_tu = EC.parse_mcst(m_info).switch_time_tu
        except ValueError:
            pass
        r.ok()
    # момент смены по ряду ECSA в маяках точки
    bs = sorted((e for e in c.k if e.kind == 'DMG Beacon' and e.src == c.ap and e.p is not None and e.tx_node),
                key=lambda e: e.t)
    t_switch = None
    if bs:
        bi_tu = bs[0].p.beacon_interval
        for b in bs:
            for eid, ext, data in b.p.elements:
                if eid == CS.EID_ECSA:
                    try:
                        x = CS.parse_ecsa(data)
                    except ValueError:
                        continue
                    t_switch = BI.tbtt(BI.bi_index(b.t, bi_tu) + x.count, bi_tu) if x.count else b.te
                    break
            if t_switch is not None:
                break
    if t_switch is not None:
        if mcst_tu is not None:
            old = [b for b in bs if b.t < t_switch]
            new = [b for b in bs if b.t >= t_switch]
            if old and new:
                for m, v in EC.check_switch_gap(old[-1].t, new[0].t, mcst_tu):
                    r.bad(new[0], m, v)
                r.ok()
        apr = (info.get(c.ap) or {}).get('rsn')
        for mac, d in info.items():
            if mac == c.ap or d.get('rsn') is None or apr is None:
                continue
            req = EC.ocv_required(apr.get('ocvc'), d['rsn'].get('ocvc'))
            frames = []
            for e, raw, noack, prot, full in _actions_all(c):
                if e.src == mac and e.t_ok:
                    ca = (raw[24], raw[25]) if not prot and len(raw) >= 26 else None
                    frames.append((e.t, 'Action No Ack' if noack else 'Action', ca, prot))
            frames += [(e.t, e.kind, None, False) for e in c.k if e.src == mac and e.kind in ('Data', 'QoS Null',
                                                                                             'A-MPDU')]
            for m, v in EC.check_after_switch(t_switch, sorted(frames, key=lambda f: f[0]), req):
                r.bad(None, f'{mac}: {m}', v)
            r.ok()
    else:
        r.skip('смены канала (ECSA в маяках) в захвате нет — Switch Time и OCV после смены не проверяемы')
    if not n:
        r.skip('Max Channel Switch Time точка не передаёт')
    return r


# ---------------------------------------------------------------------------------------------------- bf_training
def r_bf_training(c):
    J = _j()
    r = J.Rule('bf_training', '11.36', 'обучение луча пары по MLME-BF-TRAINING (ref/bftrain): начинается с SLS; BRP '
               'без SLS пары с начала записи/ассоциации — model; RequestBRP по эфиру не виден')
    ours = _ours(c)
    pairs = defaultdict(list)
    for e in c.k:
        if e.kind in BF.SLS_KINDS + BF.BRP_KINDS and e.src in ours and e.dst in ours:
            pairs[frozenset((e.src, e.dst))].append(e)
    if not pairs:
        r.skip('BF-кадров между нашими узлами с временем нет')
        return r
    assoc = defaultdict(list)
    for e in c.k:
        if e.kind in (E.ASSOC_RESP, E.REASSOC_RESP):
            assoc[frozenset((e.src, e.dst))].append(e.t)
    for pair, evs in pairs.items():
        frames = [(e.t, e.kind, e.src, e.dst) for e in evs]
        vv = BF.check_air(frames, assoc.get(pair, ()))
        for i, m, v in vv:
            r.bad(evs[i], m, v)
        r.ok(max(0, len(evs) - len(vv)))
    return r


RULES = (r_addr, r_data_hdr, r_action_fmt, r_wnm, r_tpc, r_tclas, r_sta_avail, r_addba_ext, r_asid_pattern,
         r_timestamp, r_sp_recovery, r_ecs, r_bf_training)

NOT_CHECKABLE = [
    ('addr_rx_filter', '9.3.3.1', 'фильтрация приёма по Address 1/Address 3 (групповые кадры чужой BSS) — решение '
     'приёмника по эфиру не видно'),
    ('tclas_classification', '9.4.2.30', 'классификация MSDU по TCLAS на передатчике — тела данных не записаны '
     '(rxqos/txqos, dsnap); модель — ref/tclas.match'),
    ('tpc_power_accuracy', '9.4.2.16', 'Transmit Power TPC Report ± 5 дБ к EIRP — нужен внешний измеритель мощности'),
    ('ocv_validation', '12.2.9', 'проверка OCI получателем и отбрасывание кадров с другого канала — внутреннее '
     'решение STA'),
    ('bf_request_brp', '11.36', 'RequestBRP и примитивы MLME-BF-TRAINING.confirm/.indication — уровень SME, по эфиру '
     'не видны (модель — ref/bftrain.BfTrainingSme)'),
    ('wnm_reject_status', '11.21.1', 'отказ на запрос неподдержанной функции WNM — статус разбирается только у BSS '
     'Transition Management Response и DMS (правило dms)'),
]
