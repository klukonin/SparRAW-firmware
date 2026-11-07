# SPDX-License-Identifier: AGPL-3.0-or-later
"""DMS — directed multicast service — по 802.11-2020 11.21.16.1–11.21.16.2 [p. 2291–2294]: элементы DMS Request
(9.4.2.87 [p. 1190], рис. 9-475, 9-476, табл. 9-229, 9-230) и DMS Response (9.4.2.88 [p. 1193], рис. 9-478, 9-479,
табл. 9-233, 9-234), кадры WNM DMS Request / DMS Response (9.6.13.26/9.6.13.27 [p. 1547], табл. 9-425, категория WNM
табл. 9-51), классификатор TCLAS (9.4.2.30 [p. 1078], типы 0, 1, 4 — те, что 11.21.16.2 допускает для DMS) и TCLAS
Processing (9.4.2.32 [p. 1092], табл. 9-171), бит DMS поля Extended Capabilities (9.4.2.26, бит 26), правила WNM для
битов 7–27 (11.21.1 [p. 2256]: не запрашивать у того, кто не объявил; отказывать, если не объявил сам), судьба
соглашений DMS при повторной ассоциации (11.3.5.4 [p. 2137–2138]).

Поведение:
  DmsProvider  — точка (AP/PCP): ответ на запрос (DMSID, порядок статусов, копии TCLAS/TSPEC, «тот же набор TCLAS —
                 тот же DMSID»), изменение, снятие, одностороннее прекращение (Dialog Token 0), передача группового
                 MSDU: каждой станции с DMS — индивидуально адресованный Basic A-MSDU с DA подкадра = групповой адрес
                 (9.3.2.2, 10.11), групповой кадр — пока хотя бы одна связанная станция не просила DMS.
  DmsRecipient — станция: запрос (только у точки с битом DMS, 11.21.1; в PBSS — не у PCP с PCP Forwarding = 0),
                 список принятых групп, отброс групповых кадров этих групп, отброс дублей по Last Sequence Control
                 после прекращения.
  check_request / check_response / check_exchange — проверка тел кадров и пары запрос→ответ.

GCR (11.21.16.3, 11.21.16.4) вне охвата: «DMG STAs do not use GCR» (11.21.16.1) — подэлементы GCR Request/GCR
Response и Response Type «GCR Advertise» у DMG — нарушение. FMS/TFS (11.21.8/11.21.12) не моделируются: правило «не
просить DMS и FMS для одних кадров» и порядок «сначала TFS, потом DMS» — не проверяются."""
import ipaddress
from collections import namedtuple

from . import amsdu as AM
from . import elements as E
from . import fields as F

CATEGORY_WNM = 10                   # табл. 9-51: «10 WNM», robust — Yes
ACT_DMS_REQ, ACT_DMS_RESP = 23, 24  # табл. 9-425
EID_TSPEC, EID_TCLAS, EID_TCLAS_PROC = 13, 14, 44
EID_DMS_REQ, EID_DMS_RESP = 99, 100
REQ_ADD, REQ_REMOVE, REQ_CHANGE = 0, 1, 2                       # табл. 9-229
REQ_NAME = {REQ_ADD: 'Add', REQ_REMOVE: 'Remove', REQ_CHANGE: 'Change'}
RESP_ACCEPT, RESP_DENIED, RESP_TERMINATE, RESP_GCR_ADVERTISE = 0, 1, 2, 3     # табл. 9-233
RESP_NAME = {RESP_ACCEPT: 'Accept', RESP_DENIED: 'Denied', RESP_TERMINATE: 'Terminate',
             RESP_GCR_ADVERTISE: 'GCR Advertise'}
SUBEL_GCR = 1                       # табл. 9-230: GCR Request; табл. 9-234: GCR Response
SUBEL_VENDOR = 221
DMS_LENGTH_MAX = 253                # 9.4.2.87/9.4.2.88: «The maximum value of the DMS Length field is 253»
TSPEC_INFO_LEN = 55                 # рис. 9-476: TSPEC Element «0 or 57» октетов = 2 + 55
LAST_SEQ_UNSUPPORTED = 65535        # 9.4.2.88: «When the Last Sequence Control field is not supported … 65 535»
LAST_SEQ_NOT_GROUP = 65534          # 9.4.2.88: последний кадр не был послан групповым — 65 534
EXT_CAP_DMS_BIT = 26                # табл. 9-153 (Extended Capabilities): бит 26 — DMS
TCLAS_DMS_TYPES = (0, 1, 4)         # 11.21.16.2: «the Classifier Type subfield shall be set to the value 0, 1, or 4»
PROC_ALL, PROC_ANY, PROC_NONE = 0, 1, 2                         # табл. 9-171


# ---------------------------------------------------------------------------------------------------- TCLAS
Tclas = namedtuple('Tclas', 'up ctype mask params')            # рис. 9-302/9-303: params — октеты Classifier Parameters


def encode_tclas(t):
    mask = t.mask.to_bytes(3 if t.ctype in (6, 7, 8, 9) else 1, 'little')
    return E.encode_element(EID_TCLAS, bytes([t.up, t.ctype]) + mask + bytes(t.params))


def parse_tclas(info):
    if len(info) < 3:
        raise ValueError(f'TCLAS: {len(info)} октетов < 3 (рис. 9-302)')
    ct = info[1]
    ml = 3 if ct in (6, 7, 8, 9) else 1
    if len(info) < 2 + ml:
        raise ValueError('TCLAS: нет Classifier Mask')
    return Tclas(info[0], ct, int.from_bytes(info[2:2 + ml], 'little'), bytes(info[2 + ml:]))


def tclas_eth(da, sa=None, ethertype=None, up=255):
    """Тип 0 (рис. 9-304): Source Address, Destination Address, Type; маска — B0 SA, B1 DA, B2 Type."""
    mask = 2 | (1 if sa is not None else 0) | (4 if ethertype is not None else 0)
    return Tclas(up, 0, mask, F.mac_bytes(sa or '00:00:00:00:00:00') + F.mac_bytes(da)
                 + (ethertype or 0).to_bytes(2, 'big'))


def tclas_ip4(dst, src=None, dport=None, sport=None, proto=None, dscp=None, up=255, ctype=4):
    """Тип 1 (рис. 9-305) или 4 (рис. 9-309) для IPv4; маска — порядок параметров: B0 Version, B1 Source IP,
    B2 Destination IP, B3 Source Port, B4 Destination Port, B5 DSCP, B6 Protocol. Порядок байт — big-endian."""
    mask = 1 | 4 | (2 if src else 0) | (8 if sport is not None else 0) | (16 if dport is not None else 0) \
        | (32 if dscp is not None else 0) | (64 if proto is not None else 0)
    p = (bytes([4]) + ipaddress.IPv4Address(src or '0.0.0.0').packed + ipaddress.IPv4Address(dst).packed
         + (sport or 0).to_bytes(2, 'big') + (dport or 0).to_bytes(2, 'big') + bytes([dscp or 0, proto or 0, 0]))
    return Tclas(up, ctype, mask, p)


def tclas_ip6(dst, src=None, dport=None, sport=None, up=255):
    """Тип 4 для IPv6 (рис. 9-310): Version, Source IP, Destination IP, Source Port, Destination Port, DSCP,
    Next Header, Flow Label (B0…B7 маски)."""
    mask = 1 | 4 | (2 if src else 0) | (8 if sport is not None else 0) | (16 if dport is not None else 0)
    p = (bytes([6]) + ipaddress.IPv6Address(src or '::').packed + ipaddress.IPv6Address(dst).packed
         + (sport or 0).to_bytes(2, 'big') + (dport or 0).to_bytes(2, 'big') + bytes(1 + 1 + 3))
    return Tclas(up, 4, mask, p)


TclasIp = namedtuple('TclasIp', 'version src dst sport dport dscp proto')


def _ip_params(t):
    p = t.params
    if not p:
        raise ValueError(f'TCLAS тип {t.ctype}: нет Version')
    if p[0] == 4:
        if len(p) < 16:
            raise ValueError(f'TCLAS тип {t.ctype} IPv4: {len(p)} октетов < 16 (рис. 9-305/9-309)')
        return TclasIp(4, ipaddress.IPv4Address(p[1:5]), ipaddress.IPv4Address(p[5:9]),
                       int.from_bytes(p[9:11], 'big'), int.from_bytes(p[11:13], 'big'), p[13] & 63, p[14])
    if p[0] == 6:
        n = 1 + 32 + 4 + (3 if t.ctype == 1 else 5)
        if len(p) < n:
            raise ValueError(f'TCLAS тип {t.ctype} IPv6: {len(p)} октетов < {n} (рис. 9-306/9-310)')
        sp, dp = int.from_bytes(p[33:35], 'big'), int.from_bytes(p[35:37], 'big')
        return TclasIp(6, ipaddress.IPv6Address(p[1:17]), ipaddress.IPv6Address(p[17:33]), sp, dp,
                       p[37] & 63 if t.ctype == 4 else None, p[38] if t.ctype == 4 else None)
    raise ValueError(f'TCLAS тип {t.ctype}: Version {p[0]} не 4 и не 6')


def tclas_group(t):
    """Групповой адрес потока, на который указывает TCLAS (11.21.16.2: «the Destination Address or Destination IP
    Address subfield shall be set to the multicast address of the flow»): ('mac', 'xx:…') / ('ip', адрес) / None."""
    if t.ctype == 0 and len(t.params) >= 12:
        return ('mac', F.mac_str(t.params[6:12])) if t.mask & 2 else None
    if t.ctype in (1, 4):
        ip = _ip_params(t)
        return ('ip', ip.dst) if t.mask & 4 else None
    return None


def check_tclas_dms(t):
    """TCLAS в DMS Descriptor «Add» (11.21.16.2, 9.4.2.30)."""
    v = []
    if t.ctype not in TCLAS_DMS_TYPES:
        return [f'TCLAS Classifier Type {t.ctype} — для DMS только 0, 1, 4 (11.21.16.2)']
    if t.up not in range(12) and t.up != 255:
        v.append(f'TCLAS User Priority {t.up} зарезервировано (табл. 9-163)')
    if t.ctype == 0 and len(t.params) != 14:
        v.append(f'TCLAS тип 0: Frame Classifier {2 + len(t.params)} октетов ≠ 16 (рис. 9-304)')
    try:
        g = tclas_group(t)
    except ValueError as x:
        return v + [str(x)]
    if t.ctype == 4 and not t.mask & 1:
        v.append('TCLAS тип 4: бит маски Version = 0 — элемент недействителен (9.4.2.30: «valid when the Classifier '
                 'Mask Version bit is 1»)')
    if g is None:
        v.append(f'TCLAS тип {t.ctype}: адрес назначения не задан (бит маски DA/Destination IP = 0) — 11.21.16.2')
    elif g[0] == 'mac' and not F.is_group(g[1]):
        v.append(f'TCLAS: Destination Address {g[1]} не групповой (11.21.16.2: «multicast address of the flow»)')
    elif g[0] == 'ip' and not g[1].is_multicast:
        v.append(f'TCLAS: Destination IP {g[1]} не групповой (11.21.16.2)')
    return v


def _msdu_ip(data):
    """MSDU (LLC/SNAP + IPv4/IPv6) → (version, src, dst, proto, sport, dport, dscp) или None."""
    if len(data) < 8 or data[:6] != b'\xaa\xaa\x03\x00\x00\x00':
        return None
    et, ip = int.from_bytes(data[6:8], 'big'), data[8:]
    if et == 0x0800 and len(ip) >= 20 and ip[0] >> 4 == 4:
        ihl = (ip[0] & 15) * 4
        proto = ip[9]
        l4 = ip[ihl:]
        sp, dp = (int.from_bytes(l4[0:2], 'big'), int.from_bytes(l4[2:4], 'big')) \
            if proto in (6, 17) and len(l4) >= 4 else (None, None)
        return 4, ipaddress.IPv4Address(ip[12:16]), ipaddress.IPv4Address(ip[16:20]), proto, sp, dp, ip[1] >> 2
    if et == 0x86dd and len(ip) >= 40 and ip[0] >> 4 == 6:
        proto = ip[6]
        l4 = ip[40:]
        sp, dp = (int.from_bytes(l4[0:2], 'big'), int.from_bytes(l4[2:4], 'big')) \
            if proto in (6, 17) and len(l4) >= 4 else (None, None)
        dscp = ((ip[0] & 15) << 4 | ip[1] >> 4) >> 2
        return 6, ipaddress.IPv6Address(ip[8:24]), ipaddress.IPv6Address(ip[24:40]), proto, sp, dp, dscp
    return None


def tclas_match(t, msdu):
    """Совпадает ли MSDU (amsdu.Msdu: da, sa, data = LLC/SNAP + …) с TCLAS (9.4.2.30: сравниваются параметры с битом
    маски 1). User Priority 0–7 — с msdu.tid; 8–11 (AC) — не сравнивается здесь (UP→AC не моделируется)."""
    if t.up <= 7 and msdu.tid != t.up:
        return False
    if t.ctype == 0:
        sa, da, et = F.mac_str(t.params[0:6]), F.mac_str(t.params[6:12]), int.from_bytes(t.params[12:14], 'big')
        m_et = int.from_bytes(msdu.data[6:8], 'big') if len(msdu.data) >= 8 else None
        return ((not t.mask & 1 or msdu.sa == sa) and (not t.mask & 2 or msdu.da == da)
                and (not t.mask & 4 or m_et == et))
    if t.ctype in (1, 4):
        ip, pk = _ip_params(t), _msdu_ip(msdu.data)
        if pk is None:
            return False
        ver, src, dst, proto, sp, dp, dscp = pk
        checks = [(1, ver == ip.version), (2, src == ip.src), (4, dst == ip.dst), (8, sp == ip.sport),
                  (16, dp == ip.dport)]
        if ip.version == 4:
            checks += [(32, dscp == ip.dscp), (64, proto == ip.proto)]
        return all(ok for bit, ok in checks if t.mask & bit)
    return False


def tclas_set_match(tclas, proc, msdu):
    """Табл. 9-171: Processing 0 — совпасть со всеми, 1 — хотя бы с одним; один TCLAS без Processing — с ним."""
    if not tclas:
        return False
    r = [tclas_match(t, msdu) for t in tclas]
    return any(r) if proc == PROC_ANY else all(r)


# ---------------------------------------------------------------------------------------------------- дескрипторы
Descriptor = namedtuple('Descriptor', 'dmsid req_type tclas proc tspec subelements', defaults=((), None, None, b''))
Status = namedtuple('Status', 'dmsid resp_type last_seq tclas proc tspec subelements',
                    defaults=(LAST_SEQ_UNSUPPORTED, (), None, None, b''))


def _tail(tclas, proc, tspec, subelements):
    b = b''.join(encode_tclas(t) for t in tclas)
    if proc is not None:
        b += E.encode_element(EID_TCLAS_PROC, bytes([proc]))
    if tspec is not None:
        if len(tspec) != TSPEC_INFO_LEN:
            raise ValueError(f'TSPEC: {len(tspec)} октетов информации ≠ {TSPEC_INFO_LEN} (рис. 9-476: 57 с заголовком)')
        b += E.encode_element(EID_TSPEC, tspec)
    return b + bytes(subelements)


def encode_descriptor(d):
    """Рис. 9-476: DMSID, DMS Length = 1 + n, Request Type, TCLAS…, TCLAS Processing?, TSPEC?, подэлементы."""
    tail = _tail(d.tclas, d.proc, d.tspec, d.subelements)
    if 1 + len(tail) > DMS_LENGTH_MAX:
        raise ValueError(f'DMS Length {1 + len(tail)} > {DMS_LENGTH_MAX} (9.4.2.87)')
    return bytes([d.dmsid, 1 + len(tail), d.req_type]) + tail


def encode_status(s):
    """Рис. 9-479: DMSID, DMS Length = 3 + n, Response Type, Last Sequence Control (2), TCLAS…, …"""
    tail = _tail(s.tclas, s.proc, s.tspec, s.subelements)
    if 3 + len(tail) > DMS_LENGTH_MAX:
        raise ValueError(f'DMS Length {3 + len(tail)} > {DMS_LENGTH_MAX} (9.4.2.88)')
    return bytes([s.dmsid, 3 + len(tail), s.resp_type]) + s.last_seq.to_bytes(2, 'little') + tail


def _parse_tail(b):
    """TCLAS (14)*, TCLAS Processing (44)?, TSPEC (13)?, затем Optional Subelements (9.4.3) — по порядку рис. 9-476."""
    tclas, proc, tspec, i = [], None, None, 0
    stage = 0
    while i + 2 <= len(b):
        eid, ln = b[i], b[i + 1]
        if i + 2 + ln > len(b):
            raise ValueError(f'элемент/подэлемент {eid}: Length {ln} за концом DMS-поля')
        info = b[i + 2:i + 2 + ln]
        if eid == EID_TCLAS and stage == 0:
            tclas.append(parse_tclas(info))
        elif eid == EID_TCLAS_PROC and stage < 1:
            if ln != 1:
                raise ValueError(f'TCLAS Processing: Length {ln} ≠ 1 (рис. 9-331)')
            proc, stage = info[0], 1
        elif eid == EID_TSPEC and stage < 2:
            tspec, stage = bytes(info), 2
        else:
            break
        i += 2 + ln
    if i < len(b) and i + 2 > len(b):
        raise ValueError('обрезанный элемент в DMS-поле')
    return tclas, proc, tspec, bytes(b[i:])


def parse_subelements(b):
    """9.4.3: ID (1), Length (1), данные → [(id, данные)]."""
    out, i = [], 0
    while i < len(b):
        if i + 2 > len(b) or i + 2 + b[i + 1] > len(b):
            raise ValueError(f'обрезанный подэлемент на смещении {i} (9.4.3)')
        out.append((b[i], bytes(b[i + 2:i + 2 + b[i + 1]])))
        i += 2 + b[i + 1]
    return out


def parse_descriptors(lst):
    """DMS Descriptor List (информация одного элемента) → [Descriptor]."""
    out, i = [], 0
    while i < len(lst):
        if i + 3 > len(lst):
            raise ValueError(f'обрезанный DMS Descriptor на смещении {i}')
        dmsid, dl, rt = lst[i], lst[i + 1], lst[i + 2]
        if dl < 1 or i + 2 + dl > len(lst):
            raise ValueError(f'DMS Descriptor {len(out) + 1}: DMS Length {dl} не согласуется с элементом')
        tclas, proc, tspec, sub = _parse_tail(lst[i + 3:i + 2 + dl])
        out.append(Descriptor(dmsid, rt, tuple(tclas), proc, tspec, sub))
        i += 2 + dl
    return out


def parse_statuses(lst):
    out, i = [], 0
    while i < len(lst):
        if i + 5 > len(lst):
            raise ValueError(f'обрезанный DMS Status на смещении {i}')
        dmsid, dl, rt = lst[i], lst[i + 1], lst[i + 2]
        if dl < 3 or i + 2 + dl > len(lst):
            raise ValueError(f'DMS Status {len(out) + 1}: DMS Length {dl} не согласуется с элементом')
        last = int.from_bytes(lst[i + 3:i + 5], 'little')
        tclas, proc, tspec, sub = _parse_tail(lst[i + 5:i + 2 + dl])
        out.append(Status(dmsid, rt, last, tuple(tclas), proc, tspec, sub))
        i += 2 + dl
    return out


def _pack_elements(eid, fields):
    """11.21.16.2: «If the length of the DMS Descriptors exceeds 255 octets, then multiple DMS Request elements shall be
    included, each containing only those DMS Descriptors that are completely contained within 255 octets» (так же
    DMS Status). Жадная упаковка по порядку."""
    out, cur = [], b''
    for f in fields:
        if cur and len(cur) + len(f) > E.ELEMENT_MAX_INFO:
            out.append(E.encode_element(eid, cur))
            cur = b''
        cur += f
    if cur:
        out.append(E.encode_element(eid, cur))
    return b''.join(out)


def encode_request_elements(descriptors):
    return _pack_elements(EID_DMS_REQ, [encode_descriptor(d) for d in descriptors])


def encode_response_elements(statuses):
    return _pack_elements(EID_DMS_RESP, [encode_status(s) for s in statuses])


# ---------------------------------------------------------------------------------------------------- кадры WNM
DmsFrame = namedtuple('DmsFrame', 'action token items elements')   # items — Descriptor или Status по порядку


def encode_request_frame(token, descriptors):
    """Рис. 9-947: Category (WNM), WNM Action (23), Dialog Token (ненулевой), DMS Request Elements."""
    if not 1 <= token <= 255:
        raise ValueError('9.6.13.26: Dialog Token — «a nonzero value»')
    return bytes([CATEGORY_WNM, ACT_DMS_REQ, token]) + encode_request_elements(descriptors)


def encode_response_frame(token, statuses):
    """Рис. 9-948: Category, WNM Action (24), Dialog Token (из запроса; 0 — без запроса), DMS Response Elements."""
    return bytes([CATEGORY_WNM, ACT_DMS_RESP, token]) + encode_response_elements(statuses)


def items_from_elements(els, eid):
    """DMS Descriptor/Status из всех DMS-элементов (порядок элементов и полей сохраняется)."""
    out = []
    for e in els:
        if e.eid == eid:
            out += parse_descriptors(e.info) if eid == EID_DMS_REQ else parse_statuses(e.info)
    return out


def parse_frame(body):
    """Тело Action (с категории) → DmsFrame. ValueError — не DMS-кадр или разбор."""
    if len(body) < 3 or body[0] != CATEGORY_WNM or body[1] not in (ACT_DMS_REQ, ACT_DMS_RESP):
        raise ValueError('не DMS Request/Response (табл. 9-51, 9-425)')
    els = E.parse_elements(body[3:], defragment=False)
    eid = EID_DMS_REQ if body[1] == ACT_DMS_REQ else EID_DMS_RESP
    return DmsFrame(body[1], body[2], items_from_elements(els, eid), els)


# ---------------------------------------------------------------------------------------------------- проверки
def _proc_rules(n_tclas, proc, where, required):
    v = []
    if proc is not None and proc not in (PROC_ALL, PROC_ANY, PROC_NONE):
        v.append(f'{where}: TCLAS Processing {proc} зарезервировано (табл. 9-171)')
    if proc == PROC_NONE and n_tclas:
        v.append(f'{where}: TCLAS Processing 2 («no associated TCLAS elements») при {n_tclas} TCLAS (табл. 9-171)')
    if n_tclas >= 2 and required and proc is None:
        v.append(f'{where}: {n_tclas} TCLAS без TCLAS Processing (9.4.2.87: «contains one TCLAS Processing element»)')
    if n_tclas < 2 and proc is not None:
        v.append(f'{where}: TCLAS Processing при {n_tclas} TCLAS (9.4.2.87/9.4.2.88, 11.21.16.2)')
    return v


def _subel_rules(sub, where, gcr_name):
    v = []
    try:
        for sid, _ in parse_subelements(sub):
            if sid == SUBEL_GCR:
                v.append(f'{where}: подэлемент {gcr_name} — GCR у DMG нет (11.21.16.1: «DMG STAs do not use GCR»)')
            elif sid != SUBEL_VENDOR:
                v.append(f'{where}: подэлемент {sid} зарезервирован (табл. 9-{230 if "Request" in gcr_name else 234})')
    except ValueError as x:
        v.append(f'{where}: {x}')
    return v


def check_descriptor(d, k=1):
    """Правила 9.4.2.87 и 11.21.16.2 для одного DMS Descriptor."""
    w = f'DMS Descriptor {k} ({REQ_NAME.get(d.req_type, d.req_type)})'
    v = []
    if d.req_type not in REQ_NAME:
        return [f'{w}: Request Type {d.req_type} зарезервирован (табл. 9-229)']
    if d.req_type == REQ_ADD:
        if d.dmsid != 0:
            v.append(f'{w}: DMSID {d.dmsid} ≠ 0 при «Add» (9.4.2.87)')
        if not d.tclas:
            v.append(f'{w}: нет TCLAS (9.4.2.87: «one or more TCLAS elements»)')
        for t in d.tclas:
            v += [f'{w}: {m}' for m in check_tclas_dms(t)]
        v += _proc_rules(len(d.tclas), d.proc, w, required=True)
    else:
        if d.dmsid == 0:
            v.append(f'{w}: DMSID = 0 (9.4.2.87: иначе — «the nonzero value assigned by the AP»)')
        if d.tclas or d.proc is not None:
            v.append(f'{w}: TCLAS/TCLAS Processing при Request Type ≠ «Add» (9.4.2.87: «zero TCLAS elements»)')
    if d.req_type == REQ_REMOVE and (d.tspec is not None or d.subelements):
        # 11.21.16.2: «The DMS Length field shall be set to 1. The TCLAS Elements, TCLAS Processing Element TSPEC
        # Element and Optional Subelements fields shall not be included»
        v.append(f'{w}: при «Remove» DMS Length = 1 — без TSPEC и подэлементов (11.21.16.2)')
    if d.tspec is not None and len(d.tspec) != TSPEC_INFO_LEN:
        v.append(f'{w}: TSPEC {len(d.tspec)} октетов ≠ {TSPEC_INFO_LEN} (рис. 9-476)')
    v += _subel_rules(d.subelements, w, 'GCR Request')
    return v


def check_status(s, k=1):
    """Правила 9.4.2.88 для одного DMS Status (без сверки с запросом)."""
    w = f'DMS Status {k} ({RESP_NAME.get(s.resp_type, s.resp_type)})'
    v = []
    if s.resp_type not in RESP_NAME:
        return [f'{w}: Response Type {s.resp_type} зарезервирован (табл. 9-233)']
    if s.resp_type == RESP_GCR_ADVERTISE:
        v.append(f'{w}: «GCR Advertise» — GCR у DMG нет (11.21.16.1)')
    if s.resp_type == RESP_TERMINATE:
        if s.tclas or s.proc is not None or s.tspec is not None or s.subelements:
            # 9.4.2.88: «When the Response Type field is equal to "Terminate," the DMS Length field is set to 3»
            v.append(f'{w}: при «Terminate» DMS Length = 3 — без TCLAS/TSPEC/подэлементов (9.4.2.88, 11.21.16.2)')
        if s.last_seq not in (LAST_SEQ_UNSUPPORTED, LAST_SEQ_NOT_GROUP) and s.last_seq & 15:
            v.append(f'{w}: Last Sequence Control {s.last_seq:#06x}: B0–B3 ≠ 0 (9.4.2.88)')
        if s.dmsid == 0:
            v.append(f'{w}: DMSID = 0 у «Terminate» (снимается принятый поток с ненулевым DMSID)')
    else:
        # 9.4.2.88: Last Sequence Control вне «Terminate»/«GCR Advertise» — 65 535 (не поддержан) или Reserved (= 0,
        # 9.2.2)
        if s.last_seq not in (0, LAST_SEQ_UNSUPPORTED):
            v.append(f'{w}: Last Sequence Control {s.last_seq:#06x} — вне «Terminate» 0 (Reserved) или 65 535 '
                     f'(9.4.2.88)')
        if s.resp_type == RESP_ACCEPT and s.dmsid == 0:
            v.append(f'{w}: DMSID = 0 при «Accept» (11.21.16.2: «a nonzero DMSID shall be assigned»)')
        if s.resp_type == RESP_ACCEPT and not s.tclas:
            # 9.4.2.88: «When the Response Type field contains "Accept" or "Denied" and a GCR Response subelement is not
            # included …, the TCLAS Elements field contains one or more TCLAS elements» (Denied — PLAN.md №30)
            v.append(f'{w}: нет TCLAS (9.4.2.88: «one or more TCLAS elements»)')
        for t in s.tclas:
            if t.ctype not in range(11):
                v.append(f'{w}: TCLAS Classifier Type {t.ctype} зарезервирован (табл. 9-164)')
        v += _proc_rules(len(s.tclas), s.proc, w, required=False)
    if s.tspec is not None and len(s.tspec) != TSPEC_INFO_LEN:
        v.append(f'{w}: TSPEC {len(s.tspec)} октетов ≠ {TSPEC_INFO_LEN} (рис. 9-479)')
    v += _subel_rules(s.subelements, w, 'GCR Response')
    return v


def check_elements_packing(els, eid):
    """11.21.16.2: несколько элементов — только когда поля не помещаются в 255 октетов; каждое поле — целиком в одном
    элементе (это гарантирует разбор). Проверка: элемент (кроме последнего) не мог бы вместить первое поле
    следующего — «each containing only those … completely contained within 255 octets» (PLAN.md №29)."""
    v, lst = [], [e for e in els if e.eid == eid]
    for a, b in zip(lst, lst[1:]):
        first = 2 + b.info[1] if len(b.info) >= 2 else 0
        if len(a.info) + first <= E.ELEMENT_MAX_INFO:
            v.append(f'элемент {E.element_name(eid)}: {len(a.info)} октетов, а следующее поле ({first}) поместилось бы '
                     f'(11.21.16.2: несколько элементов — при превышении 255 октетов)')
    return v


def check_request(frame):
    """DmsFrame запроса → нарушения (9.6.13.26, 9.4.2.87)."""
    v = []
    if frame.token == 0:
        v.append('DMS Request: Dialog Token = 0 (9.6.13.26: «a nonzero value»)')
    if not frame.items:
        v.append('DMS Request без DMS Descriptor (9.6.13.26: «one or more DMS Request elements»)')
    for k, d in enumerate(frame.items, 1):
        v += check_descriptor(d, k)
    return v + check_elements_packing(frame.elements, EID_DMS_REQ)


def check_response(frame):
    """DmsFrame ответа → нарушения (9.6.13.27, 9.4.2.88) без сверки с запросом. Без запроса (Dialog Token 0) — только
    «Terminate» (9.6.13.27: «autonomously to terminate a requested DMS stream»; «GCR Advertise» у DMG нет)."""
    v = []
    if not frame.items:
        v.append('DMS Response без DMS Status (9.6.13.27)')
    for k, s in enumerate(frame.items, 1):
        v += check_status(s, k)
        if frame.token == 0 and s.resp_type != RESP_TERMINATE:
            v.append(f'DMS Status {k}: «{RESP_NAME.get(s.resp_type, s.resp_type)}» в ответе без запроса (Dialog Token '
                     f'0) — 11.21.16.2 допускает только «Terminate»')
    return v + check_elements_packing(frame.elements, EID_DMS_RESP)


def _tclas_key(tclas, proc):
    """Набор TCLAS без учёта порядка (11.21.16.2: «identical irrespective of ordering») + Processing."""
    return (tuple(sorted((t.up, t.ctype, t.mask, t.params) for t in tclas)), proc)


def check_exchange(req_items, resp_items, req_token=None, resp_token=None, provider_dms=None, accepted=None):
    """Пара запрос→ответ (11.21.16.2): статус на каждый дескриптор в том же порядке, тот же DMSID; Add → Accept с
    ненулевым DMSID или Denied с 0; Change → DMSID дескриптора; Remove → Terminate; копии TCLAS/Processing/TSPEC/
    подэлементов (Accept — точные; Denied — копия или предложение, PLAN.md №30); provider_dms — бит DMS точки (11.21.1:
    не объявивший обязан отказать); accepted — {DMSID: ключ TCLAS} действующих потоков точки (тот же набор — тот же
    DMSID)."""
    v = []
    if req_token is not None and resp_token is not None and req_token != resp_token:
        v.append(f'Dialog Token ответа {resp_token} ≠ запроса {req_token} (9.6.13.27)')
    if len(resp_items) != len(req_items):
        v.append(f'{len(resp_items)} DMS Status на {len(req_items)} DMS Descriptor (11.21.16.2: «a matching … DMS '
                 f'Status field for each received DMS Descriptor field»)')
    for k, (d, s) in enumerate(zip(req_items, resp_items), 1):
        w = f'DMS Status {k} на {REQ_NAME.get(d.req_type, d.req_type)}'
        if d.req_type == REQ_REMOVE:
            if s.resp_type != RESP_TERMINATE or s.dmsid != d.dmsid:
                v.append(f'{w}: {RESP_NAME.get(s.resp_type, s.resp_type)} DMSID {s.dmsid} — нужен «Terminate» с DMSID '
                         f'{d.dmsid} (11.21.16.2)')
            continue
        if s.resp_type not in (RESP_ACCEPT, RESP_DENIED):
            v.append(f'{w}: Response Type {RESP_NAME.get(s.resp_type, s.resp_type)} — нужен Accept или Denied '
                     f'(11.21.16.2)')
            continue
        if provider_dms is False and s.resp_type == RESP_ACCEPT:
            v.append(f'{w}: Accept от точки без бита DMS (11.21.1: «shall reject the request if … has not advertised»)')
        if d.req_type == REQ_ADD:
            if s.resp_type == RESP_DENIED and s.dmsid != 0:
                v.append(f'{w}: Denied с DMSID {s.dmsid} ≠ 0 (11.21.16.2)')
            if s.resp_type == RESP_ACCEPT and accepted:
                key = _tclas_key(d.tclas, d.proc)
                same = [i for i, kk in accepted.items() if kk == key]
                if same and s.dmsid not in same:
                    v.append(f'{w}: DMSID {s.dmsid} при действующем потоке с тем же набором TCLAS (DMSID {same[0]}) — '
                             f'11.21.16.2: «shall assign the same DMSID»')
        elif d.req_type == REQ_CHANGE and s.dmsid != d.dmsid:
            v.append(f'{w}: DMSID {s.dmsid} ≠ {d.dmsid} дескриптора (11.21.16.2)')
        # копия «respective … fields of the corresponding DMS request»; у «Change» в запросе TCLAS нет, а 9.4.2.88
        # требует их в Accept/Denied — ответ несёт TCLAS потока, сверяются TSPEC и подэлементы (PLAN.md №30)
        same_copy = ((d.req_type == REQ_CHANGE or (tuple(s.tclas) == tuple(d.tclas) and s.proc == d.proc))
                     and s.tspec == d.tspec and s.subelements == d.subelements)
        if s.resp_type == RESP_ACCEPT and not same_copy:
            v.append(f'{w}: TCLAS/TCLAS Processing/TSPEC/подэлементы не копия запроса (11.21.16.2: «shall be copied»)')
        if s.resp_type == RESP_DENIED and not same_copy and len(s.tclas) == 1 and s.proc is not None:
            v.append(f'{w}: предложение с одним TCLAS и TCLAS Processing (11.21.16.2: «shall not include a TCLAS '
                     f'Processing element»)')
    return v


def ext_cap_dms(info):
    """Бит DMS (26) поля Extended Capabilities (9.4.2.26, табл. 9-153). Поле короче — бит 0 (9.4.2.26: «If fewer bits
    are received … the rest of the Extended Capabilities field bits are assumed to be zero»)."""
    o, b = divmod(EXT_CAP_DMS_BIT, 8)
    return len(info) > o and bool(info[o] >> b & 1)


def encode_ext_cap(dms=True, n=8):
    b = bytearray(n)
    if dms:
        b[EXT_CAP_DMS_BIT // 8] |= 1 << EXT_CAP_DMS_BIT % 8
    return E.encode_element(127, bytes(b))


# ---------------------------------------------------------------------------------------------------- поведение
Tx = namedtuple('Tx', 'ra kind body')       # kind 'group' (MSDU) | 'amsdu' (индивидуальный A-MSDU, тело)


class DmsProvider:
    """Точка (AP/PCP) с dot11DMSActivated (бит DMS = 1 в Extended Capabilities — 11.21.16.2). accept(sta, d) —
    политика приёма (по умолчанию — всё допустимое); «may reject … or terminate … at any time»."""

    def __init__(self, addr, activated=True, accept=None, last_seq_supported=True):
        self.addr, self.activated = addr, activated
        self.policy = accept or (lambda sta, d: True)
        self.last_seq_supported = last_seq_supported
        self._ls0 = 0 if last_seq_supported else LAST_SEQ_UNSUPPORTED     # 9.4.2.88: вне «Terminate» — 0 / 65 535
        self.assoc = {}             # sta → бит DMS станции
        self.flows = {}             # DMSID → dict(key, tclas, proc, tspec, sub, members:set)
        self.last_sn = {}           # (sta, DMSID) → SN последнего группового кадра, доставленного и групповым
        self._next = 1

    # ---- ассоциация (11.3.5.4) ----
    def associate(self, sta, sta_dms):
        self.assoc[sta] = bool(sta_dms)

    def disassociate(self, sta):
        """СПОРНО → принято (PLAN.md №31): соглашение DMS живёт в ассоциации — при её потере снимается."""
        self.assoc.pop(sta, None)
        for f in self.flows.values():
            f['members'].discard(sta)
        self._gc()

    def reassociate(self, sta, sta_dms, same_ap=True):
        """11.3.5.4 c): к той же точке «DMS agreements» не затрагиваются; к другой — удаляются."""
        if not same_ap:
            self.disassociate(sta)
        self.assoc[sta] = bool(sta_dms)

    def _gc(self):
        for i in [i for i, f in self.flows.items() if not f['members']]:
            del self.flows[i]

    def _alloc(self, key):
        for i, f in self.flows.items():
            if f['key'] == key:
                return i                    # «shall assign the same DMSID as was assigned to the previous DMS request»
        while self._next in self.flows or self._next == 0:
            self._next = self._next % 255 + 1
        i = self._next
        self._next = self._next % 255 + 1
        return i

    def on_request(self, sta, items, token):
        """DMS Request (или DMS Request в Reassociation Request) → [Status] в порядке дескрипторов + токен ответа."""
        out = []
        for d in items:
            if d.req_type == REQ_REMOVE:
                f = self.flows.get(d.dmsid)
                if f is not None:
                    f['members'].discard(sta)
                    self._gc()
                out.append(Status(d.dmsid, RESP_TERMINATE, self._last(sta, d.dmsid)))
                continue
            ok = (self.activated and self.assoc.get(sta) and not check_descriptor(d) and self.policy(sta, d))
            if d.req_type == REQ_CHANGE:
                f = self.flows.get(d.dmsid)
                ok = ok and f is not None and sta in f['members']
                if ok:
                    f.update(tspec=d.tspec, sub=d.subelements)
                st = RESP_ACCEPT if ok else RESP_DENIED
                cur = f if f is not None else dict(tclas=(), proc=None)
                out.append(Status(d.dmsid, st, self._ls0, tuple(cur['tclas']), cur['proc'], d.tspec,
                                  d.subelements))
                continue
            if not ok:
                out.append(Status(0, RESP_DENIED, self._ls0, d.tclas, d.proc, d.tspec, d.subelements))
                continue
            key = _tclas_key(d.tclas, d.proc)
            i = self._alloc(key)
            f = self.flows.setdefault(i, dict(key=key, tclas=tuple(d.tclas), proc=d.proc, tspec=d.tspec,
                                              sub=d.subelements, members=set()))
            f['members'].add(sta)
            out.append(Status(i, RESP_ACCEPT, self._ls0, d.tclas, d.proc, d.tspec, d.subelements))
        return token, out

    def _last(self, sta, dmsid):
        if not self.last_seq_supported:
            return LAST_SEQ_UNSUPPORTED
        sn = self.last_sn.get((sta, dmsid))
        return LAST_SEQ_NOT_GROUP if sn is None else sn << 4

    def terminate(self, dmsid, sta):
        """Одностороннее прекращение: DMS Response с Dialog Token 0 и «Terminate» (11.21.16.2)."""
        f = self.flows.get(dmsid)
        if f is not None:
            f['members'].discard(sta)
            self._gc()
        return 0, [Status(dmsid, RESP_TERMINATE, self._last(sta, dmsid))]

    def members(self, msdu):
        """Станции с DMS-потоком, классификатор которого совпал с MSDU."""
        out = set()
        for f in self.flows.values():
            if tclas_set_match(f['tclas'], f['proc'], msdu):
                out |= f['members'] & set(self.assoc)
        return out

    def transmit_group(self, msdu, sn=None):
        """Групповой MSDU (DA — групповой) → [Tx]. 11.21.16.2: станциям с DMS — «as A-MSDU subframes within an
        individually addressed A-MSDU frame», DA подкадра — групповой адрес; групповой кадр — «if at least one
        associated STA has not requested DMS for these frames» (PLAN.md №32: нет связанных станций без DMS — группового
        кадра нет). sn — номер группового кадра (для Last Sequence Control)."""
        if not F.is_group(msdu.da):
            raise ValueError('transmit_group: DA не групповой')
        hit = {i: f['members'] & set(self.assoc) for i, f in self.flows.items()
               if tclas_set_match(f['tclas'], f['proc'], msdu)}
        dms = set().union(*hit.values()) if hit else set()
        out = [Tx(sta, 'amsdu', AM.encode_basic([AM.Msdu(msdu.da, msdu.sa, msdu.data, msdu.tid)]))
               for sta in sorted(dms)]
        group = bool(set(self.assoc) - dms)
        if group:
            out.append(Tx(msdu.da, 'group', msdu))
        for i, stas in hit.items():
            for sta in stas:            # 9.4.2.88: SN последнего кадра, посланного и групповым; иначе — 65 534
                self.last_sn[(sta, i)] = sn if group else None
        return out


class DmsRecipient:
    """Станция (non-AP) — DMS recipient (11.21.16.2)."""

    def __init__(self, addr, activated=True):
        self.addr, self.activated = addr, activated
        self.pending = {}           # token → [Descriptor]
        self.accepted = {}          # DMSID → набор групп ('mac'|'ip', адрес)
        self.dup_until = {}         # группа ('mac', da) → последний SN, после которого групповые не дубли
        self._token = 0

    @staticmethod
    def may_request(provider_dms, provider_is_pcp=False, pcp_forwarding=True):
        """11.21.1: не запрашивать функцию WNM, бит которой у партнёра 0; 11.21.16.2: в PBSS при PCP Forwarding = 0
        не использовать PCP как DMS provider."""
        return bool(provider_dms) and not (provider_is_pcp and not pcp_forwarding)

    def request(self, descriptors, provider_dms=True, provider_is_pcp=False, pcp_forwarding=True):
        if not self.activated or not self.may_request(provider_dms, provider_is_pcp, pcp_forwarding):
            return None
        self._token = self._token % 255 + 1
        self.pending[self._token] = list(descriptors)
        return self._token, list(descriptors)

    def on_response(self, token, statuses, now_sn=None):
        req = self.pending.pop(token, None) if token else None
        for k, s in enumerate(statuses):
            if s.resp_type == RESP_ACCEPT and req is not None and k < len(req) and req[k].req_type == REQ_ADD:
                self.accepted[s.dmsid] = {g for g in (tclas_group(t) for t in req[k].tclas) if g}
            elif s.resp_type == RESP_TERMINATE:
                groups = self.accepted.pop(s.dmsid, set())
                if s.last_seq not in (LAST_SEQ_UNSUPPORTED, LAST_SEQ_NOT_GROUP):
                    for g in groups:
                        self.dup_until[g] = s.last_seq >> 4

    def groups(self):
        return set().union(*self.accepted.values()) if self.accepted else set()

    def rx_group(self, da, sn=None, msdu=None):
        """Групповой кадр (DA da) → доставить (True) / отбросить (False). 11.21.16.2: «shall discard group addressed
        frames that match a group address in this list until the DMS has been terminated»; после прекращения — дубли
        по Last Sequence Control (PLAN.md №33: SN не новее последнего — в окне 2048 назад по модулю 4096)."""
        g = ('mac', da)
        if g in self.groups():
            return False
        if msdu is not None:
            pk = _msdu_ip(msdu.data)
            if pk is not None and ('ip', pk[2]) in self.groups():
                return False
        last = self.dup_until.get(g)
        if last is not None and sn is not None and (last - sn) % 4096 < 2048:
            return False
        if last is not None and sn is not None:
            del self.dup_until[g]           # первый кадр новее — дальше дублей нет
        return True

    def rx_amsdu(self, body):
        """Индивидуально адресованный A-MSDU → MSDU (da, sa, data) к доставке (DA подкадра — групповой у DMS)."""
        p = AM.parse(body, AM.BASIC)
        return [(s.da, s.sa, s.msdu) for s in p.subframes]


def group_mac(g):
    """Группа ('mac', a) | ('ip', адрес) → групповой MAC (DA MSDU): IPv4 — 01:00:5e + младшие 23 бита (IETF RFC 1112),
    IPv6 — 33:33 + младшие 32 бита (IETF RFC 2464). Отображение — не из 802.11 (нужно, чтобы сравнить TCLAS по IP с DA
    подкадра)."""
    if g[0] == 'mac':
        return g[1]
    a = g[1].packed
    if g[1].version == 4:
        return F.mac_str(bytes([1, 0, 0x5e, a[1] & 0x7f, a[2], a[3]]))
    return F.mac_str(b'\x33\x33' + a[12:16])
