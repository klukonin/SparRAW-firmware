# SPDX-License-Identifier: AGPL-3.0-or-later
"""Обнаружение пиров и сервисов DMG BSS по 802.11-2020 11.28 [p. 2359–2360]: кадры Information Request / Information
Response (категория DMG 16, табл. 9-51; DMG Action 2/3, табл. 9-457; 9.6.19.4/9.6.19.5 [p. 1571–1572], табл. 9-460,
9-461), элементы Request (9.4.2.9 [p. 962]: ID по возрастанию, без повторов, без ID с Extension и без элементов,
которые ответ несёт и так), Extended Request (9.4.2.10), Vendor Specific Request (9.4.2.218 — как октеты).

Поведение (InfoStation):
  - запрос о всех STA — Subject Address = broadcast и только точке (AP/PCP) (11.28.1);
  - проверка присутствия — Request с Length 0 и без Extended Request любой STA BSS;
  - non-AP/non-PCP STA не кладёт в запрос DMG Capabilities другой STA (11.28.1);
  - ответ: каждый запрошенный и поддерживаемый элемент — есть, неподдерживаемый — нет; RCPI/RSNI — при
    dot11RadioMeasurementActivated, «нет измерения» — 255/255 (табл. 9-176, 9.4.2.40); ответ «без элементов» — когда
    точка спрошена о не-члене BSS или non-AP STA спрошена не о себе (11.28.1);
  - точка отвечает, только если SSID (если указан) — wildcard/свой, BSSID (Address 3) — wildcard/свой, DA — свой адрес
    (11.28.2 a–c); ответ — на адрес запросившего; broadcast-ответ — Action No Ack (9.6.19.5).

СПОРНО → принято (PLAN.md №60): «ответ без requested or provided elements» несёт только DMG Capabilities самого
отвечающего (табл. 9-461 требует «One or more DMG Capabilities elements»).
СПОРНО → принято (PLAN.md №61): SSID для 11.28.2 a) — элемент SSID среди provided elements запроса; нет элемента — как
wildcard (у кадра Information Request поля SSID нет).
Опечатки 2020 (2024 — проверено в отчёте ветки): 11.28.1 «Information Response frame (9.6.19.4)» — 9.6.19.5; «STA
Capability element» — DMG Capabilities; «RCPI of the Probe Request frame» — Information Request.
Не моделируется: robust-защита (категория DMG robust — защищается при MFP, 12.6.3), Supported Channels
(11.8.2.2 — смена канала, ветка ref/linkadapt), SSW Report (EDMG/CDMG, 9.4.2.222)."""
from collections import namedtuple

from . import elements as E
from . import fields as F
from .timing import BCAST

CATEGORY_DMG = 16                          # табл. 9-51
ACT_INFO_REQ, ACT_INFO_RESP = 2, 3         # табл. 9-457
EID_REQUEST = 10                           # 9.4.2.9
EXT_EXTENDED_REQUEST = 10                  # 9.4.2.10 (255/10)
EXT_VENDOR_REQUEST = 44                    # 9.4.2.218 (255/44)
EID_RCPI, EID_RSNI, EID_SSID = 53, 65, 0
RCPI_NA = 255                              # табл. 9-176: «Measurement not available»
RSNI_NA = 255                              # 9.4.2.40: «RSNI not available»
# В ответе есть всегда (табл. 9-461) — в Request их не просят (9.4.2.9)
ALWAYS_IN_RESPONSE = {(E.EID_DMG_CAPABILITIES, None)}

InfoFrame = namedtuple('InfoFrame', 'action subject request ext_request vendor_request dmg_caps provided')


def encode_request_el(eids):
    return E.encode_element(EID_REQUEST, bytes(eids))


def encode_ext_request_el(eid, exts):
    return E.encode_element(E.EID_EXTENSION, bytes([eid]) + bytes(exts), ext=EXT_EXTENDED_REQUEST)


def encode_request(subject, requested=(), ext_requested=(), dmg_caps=(), provided=()):
    """Тело Action Information Request (табл. 9-460). requested — Element ID; ext_requested — [(ID, [ext…])];
    dmg_caps/provided — готовые элементы (bytes)."""
    b = bytes([CATEGORY_DMG, ACT_INFO_REQ]) + F.mac_bytes(subject) + encode_request_el(sorted(requested))
    b += b''.join(bytes(x) for x in dmg_caps) + b''.join(bytes(x) for x in provided)
    for eid, exts in ext_requested:
        b += encode_ext_request_el(eid, sorted(exts))
    return b


def encode_response(subject, dmg_caps, elements=()):
    """Тело Action Information Response (табл. 9-461): DMG Capabilities (≥ 1), затем запрошенные и предоставленные."""
    return bytes([CATEGORY_DMG, ACT_INFO_RESP]) + F.mac_bytes(subject) + b''.join(bytes(x) for x in dmg_caps) \
        + b''.join(bytes(x) for x in elements)


def parse(body):
    """Тело Action (с октета Category) → InfoFrame. request — [ID] или None (нет элемента); ext_request —
    [(ID, [ext])]; dmg_caps — [DmgCapabilities]; provided — прочие [Element] в порядке кадра."""
    b = bytes(body)
    if len(b) < 8 or b[0] != CATEGORY_DMG or b[1] not in (ACT_INFO_REQ, ACT_INFO_RESP):
        raise ValueError('не Information Request/Response (табл. 9-457, 9-460, 9-461)')
    subject = F.mac_str(b[2:8])
    els = E.parse_elements(b[8:])
    req, ext_req, vreq, caps, prov = None, [], [], [], []
    for el in els:
        if el.eid == EID_REQUEST and el.ext is None and b[1] == ACT_INFO_REQ:
            if req is not None:
                raise ValueError('Information Request: два элемента Request (табл. 9-460: «Request element»)')
            req = list(el.info)
        elif el.eid == E.EID_EXTENSION and el.ext == EXT_EXTENDED_REQUEST and b[1] == ACT_INFO_REQ:
            if not el.info:
                raise ValueError('Extended Request без Requested Element ID (рис. 9-168)')
            ext_req.append((el.info[0], list(el.info[1:])))
        elif el.eid == E.EID_EXTENSION and el.ext == EXT_VENDOR_REQUEST and b[1] == ACT_INFO_REQ:
            vreq.append(el.info)
        elif el.eid == E.EID_DMG_CAPABILITIES:
            caps.append(E.parse_dmg_capabilities(el.info))
        else:
            prov.append(el)
    return InfoFrame(b[1], subject, req, ext_req, vreq, caps, prov), els


def _order_viol(els, action):
    """Табл. 9-460/9-461: порядок групп элементов."""
    if action == ACT_INFO_REQ:
        def rank(el):
            if el.eid == EID_REQUEST and el.ext is None:
                return 0
            if el.eid == E.EID_DMG_CAPABILITIES:
                return 1
            if el.eid == E.EID_EXTENSION and el.ext == EXT_EXTENDED_REQUEST:
                return 3
            if el.eid == E.EID_EXTENSION and el.ext == EXT_VENDOR_REQUEST:
                return 4
            return 2
        names = ('Request', 'DMG Capabilities', 'provided', 'Extended Request', 'Vendor Specific Request')
    else:
        def rank(el):
            return 0 if el.eid == E.EID_DMG_CAPABILITIES else 1
        names = ('DMG Capabilities', 'requested/provided')
    v, cur = [], -1
    for el in els:
        k = rank(el)
        if k < cur:
            v.append(f'{E.element_name(el.eid, el.ext)} после группы «{names[cur]}» (табл. '
                     f'{"9-460" if action == ACT_INFO_REQ else "9-461"}: порядок)')
        cur = max(cur, k)
    return v


def check_request(body, src, dst, dst_is_ap, src_is_ap=False):
    """Нарушения Information Request от src к dst."""
    try:
        f, els = parse(body)
    except (ValueError, F.FieldError) as x:
        return [f'разбор: {x}']
    v = _order_viol(els, ACT_INFO_REQ)
    if f.request is None:
        v.append('нет элемента Request (табл. 9-460, поле 4 — обязательное)')
    else:
        if f.request != sorted(f.request):
            v.append(f'Requested Element IDs не по возрастанию {f.request} (9.4.2.9)')
        if len(set(f.request)) != len(f.request):
            v.append(f'Requested Element IDs с повтором {f.request} (9.4.2.9: «at most once»)')
        if E.EID_EXTENSION in f.request:
            v.append('Request с ID 255 — «does not support elements that contain an Element ID Extension» (9.4.2.9)')
        for eid in f.request:
            if (eid, None) in ALWAYS_IN_RESPONSE:
                v.append(f'Request просит {E.element_name(eid)} — ответ несёт его и так (9.4.2.9, табл. 9-461)')
    for eid, exts in f.ext_request:
        if exts != sorted(exts) or len(set(exts)) != len(exts):
            v.append(f'Extended Request {eid}: расширения не по возрастанию/с повтором {exts} (9.4.2.10)')
    if f.subject == BCAST and not dst_is_ap:
        v.append('Subject Address = broadcast в запросе не к AP/PCP (11.28.1: «shall transmit … to the AP and PCP»)')
    if not src_is_ap:
        for c in f.dmg_caps:
            if c.sta_address != src:
                v.append(f'non-AP STA кладёт DMG Capabilities другой STA {c.sta_address} (11.28.1: «shall not '
                         f'include … the capability information corresponding to another STA»)')
    return v


def is_presence_probe(f):
    """11.28.1: запрос «ещё здесь и в зоне?» — Request с Length 0 и без Extended Request."""
    return f.request == [] and not f.ext_request


def check_response(body, src, dst, req=None, src_is_ap=False, members=None, frame_kind='Action', bssid=None):
    """Нарушения Information Response от src к dst. req — InfoFrame запроса (если записан), members — MAC членов BSS у
    точки (None — неизвестно), frame_kind — 'Action' | 'Action No Ack'."""
    try:
        f, els = parse(body)
    except (ValueError, F.FieldError) as x:
        return [f'разбор: {x}']
    v = _order_viol(els, ACT_INFO_RESP)
    if not f.dmg_caps:
        v.append('нет DMG Capabilities (табл. 9-461: «One or more DMG Capabilities elements»)')
    if dst == BCAST and frame_kind != 'Action No Ack':
        v.append('широковещательный Information Response не Action No Ack (9.6.19.5)')
    if req is not None:
        if f.subject != req.subject:
            v.append(f'Subject Address ответа {f.subject} ≠ запроса {req.subject} (11.28.1)')
        empty = _must_be_empty(req, src, src_is_ap, members)
        if empty and f.provided:
            v.append(f'ответ должен быть без requested/provided элементов ({empty}), а несёт '
                     f'{[E.element_name(e.eid, e.ext) for e in f.provided]} (11.28.1)')
        if empty and any(c.sta_address != src for c in f.dmg_caps):
            v.append('ответ «без элементов» с DMG Capabilities не отвечающего (PLAN.md №60)')
    elif f.subject == BCAST and not src_is_ap:
        v.append('Subject Address = broadcast в ответе non-AP STA — сведения обо всех STA даёт точка (11.28.1, '
                 '9.6.19.5)')
    return v


def _must_be_empty(req, responder, responder_is_ap, members):
    if req.subject == BCAST:
        return None
    if responder_is_ap and members is not None and req.subject not in members and req.subject != responder:
        return 'точка спрошена о не-члене BSS'
    if not responder_is_ap and req.subject != responder:
        return 'non-AP STA спрошена не о себе'
    return None


def ap_should_respond(req_body, bssid_field, da, own_mac, own_bssid, own_ssid):
    """11.28.2 a–c: точка отвечает на Information Request только при всех трёх условиях."""
    f, _ = parse(req_body)
    ssids = [e.info for e in f.provided if e.eid == EID_SSID and e.ext is None]
    ssid_ok = not ssids or ssids[0] in (b'', bytes(own_ssid))           # PLAN.md №61
    return ssid_ok and bssid_field in (BCAST, own_bssid) and da == own_mac


class InfoStation:
    """STA DMG BSS, отвечающая на Information Request (11.28). caps — свой DmgCapabilities (encode); members —
    {MAC: элемент DMG Capabilities (bytes)} ассоциированных (у точки); supported — {(eid, ext): bytes элемента};
    radio_measurement — dot11RadioMeasurementActivated."""

    def __init__(self, mac, caps_el, is_ap=False, bssid=None, ssid=b'', members=None, supported=None,
                 radio_measurement=False):
        self.mac, self.caps_el, self.is_ap = mac, bytes(caps_el), is_ap
        self.bssid, self.ssid = bssid or mac, ssid
        self.members = dict(members or {})
        self.supported = dict(supported or {})
        self.rm = radio_measurement

    def request(self, subject, requested=(), dst_is_ap=True, provided=()):
        """Запрос (тело). Broadcast-Subject — только точке (11.28.1)."""
        if subject == BCAST and not dst_is_ap:
            raise ValueError('запрос обо всех STA — только к AP/PCP (11.28.1)')
        return encode_request(subject, requested, dmg_caps=[self.caps_el], provided=provided)

    def presence_probe(self, subject):
        return encode_request(subject, ())

    def on_request(self, body, src, bssid_field=BCAST, da=None, rcpi=None, rsni=None):
        """→ (RA, тело ответа) или None (точка не отвечает по 11.28.2)."""
        da = da or self.mac
        if self.is_ap and not ap_should_respond(body, bssid_field, da, self.mac, self.bssid, self.ssid):
            return None
        f, _ = parse(body)
        req = Requested(f)
        caps = [self.caps_el]
        out = []
        empty = _must_be_empty(f, self.mac, self.is_ap, set(self.members))
        if not empty:
            if f.subject == BCAST and self.is_ap:
                caps += list(self.members.values())
            elif self.is_ap and f.subject in self.members:
                caps.append(self.members[f.subject])
            for key in req.keys():
                if key == (EID_RCPI, None) and self.rm:
                    out.append(E.encode_element(EID_RCPI, bytes([RCPI_NA if rcpi is None else rcpi])))
                elif key == (EID_RSNI, None) and self.rm:
                    out.append(E.encode_element(EID_RSNI, bytes([RSNI_NA if rsni is None else rsni])))
                elif key in self.supported:
                    out.append(self.supported[key])
        return src, encode_response(f.subject, caps, out)


class Requested:
    """Множество (eid, ext), запрошенных Request и Extended Request."""

    def __init__(self, f):
        self.f = f

    def keys(self):
        out = [(e, None) for e in (self.f.request or [])]
        for eid, exts in self.f.ext_request:
            out += [(eid, x) for x in exts]
        return out


def check_answer_content(req_body, resp_body, supported=None):
    """11.28.1: в ответе — запрошенные элементы, если поддержаны (supported — множество (eid, ext) отвечающего или None:
    неизвестно); незапрошенные — «provided» (допустимы). → (нарушения, сведения)."""
    f, _ = parse(req_body)
    g, _ = parse(resp_body)
    want = set(Requested(f).keys())
    got = {(e.eid, e.ext) for e in g.provided}
    v = []
    if supported is not None:
        for k in want & set(supported):
            if k not in got:
                v.append(f'запрошен и поддержан {E.element_name(*k)}, но нет в ответе (11.28.1: «shall be included»)')
        for k in (want - set(supported)) & got:
            v.append(f'запрошен и не поддержан {E.element_name(*k)}, но есть в ответе (11.28.1: «shall not be '
                     f'included»)')
    return v, dict(requested=sorted(want, key=str), answered=sorted(want & got, key=str))
