# SPDX-License-Identifier: AGPL-3.0-or-later
"""ADDBA Extension по 802.11-2020: элемент 9.4.2.139 [p. 1260] (рис. 9-579: Element ID 159, Length, ADDBA
Capabilities 1 октет; рис. 9-580: No-Fragmentation B0, Reserved B1–B7), место в ADDBA Request/Response (табл. 9-360,
9-361: «ADDBA Extension (optional)» — после GCR Group Address, Multi-band, TCLAS), правило фрагментации DMG 10.2.6
[p. 1639]: «Transmission of fragmented MPDUs by a DMG STA outside of an A-MPDU depends on setting of the
No-Fragmentation field … within the ADDBA Response frame … The MSDU shall not be fragmented if … is 1. If … is 0, the
originator may fragment an MSDU sent under the block ack agreement, with Normal Ack ack policy».

Подполя HE Fragmentation Operation и Extended Buffer Size — поправки 802.11ax/be, в 802.11-2020 их нет (B1–B7 —
Reserved); в 802.11-2024 (9.4.2.138) B1–B2 — HE Fragmentation Operation только у HE STA: DMG STA (не HE) не передаёт
ненулевые B1–B7 ни по одному изданию.

Принято (PLAN.md №101): ADDBA Extension в ответе нет — ограничения нет (No-Fragmentation по умолчанию 0: «depends on
setting of the No-Fragmentation field» — поля нет, условия запрета нет); No-Fragmentation = 1 в запросе — обещание
передатчика («originator is not fragmenting»): фрагменты от него по этому соглашению — нарушение; фрагмент по
соглашению — только вне A-MPDU и с Ack Policy Normal Ack. Общее правило 10.2.6 [p. 1638] «An MSDU transmitted under
an HT-immediate block ack agreement shall not be fragmented» (а DMG — только HT-immediate, 10.25.1) уступает частному
DMG-абзацу того же подпункта; в A-MPDU без S-MPDU и в групповых MPDU — не фрагментируется никогда (10.2.6).

Нарушения — список строк."""
from collections import namedtuple

from . import elements as E

EID_ADDBA_EXT = E.element_key('ADDBA Extension')[0]       # 159
ADDBA_EXT_LEN = 1
ADDBA_FIXED_REQ = 9          # табл. 9-360: Category, Action, Dialog Token, Parameter Set (2), Timeout (2), SSC (2)
ADDBA_FIXED_RESP = 9         # табл. 9-361: Category, Action, Dialog Token, Status (2), Parameter Set (2), Timeout (2)
# порядок необязательных элементов ADDBA (табл. 9-360/9-361)
ORDER = {E.element_key('GCR Group Address')[0]: 7, E.element_key('Multi-band')[0]: 8,
         E.element_key('TCLAS')[0]: 9, EID_ADDBA_EXT: 10}
ACK_NORMAL = 0                # табл. 9-13: Normal Ack or Implicit Block Ack Request

AddbaExt = namedtuple('AddbaExt', 'no_frag rsv')


def encode(no_frag, rsv=0):
    if no_frag not in (0, 1) or not 0 <= rsv < 128:
        raise ValueError('ADDBA Capabilities вне рис. 9-580')
    return E.encode_element(EID_ADDBA_EXT, bytes([no_frag | rsv << 1]))


def parse(info):
    if len(info) < ADDBA_EXT_LEN:
        raise ValueError('ADDBA Extension: Length 0 — нет ADDBA Capabilities (рис. 9-579)')
    return AddbaExt(info[0] & 1, info[0] >> 1)


def check(info, own=True):
    """Поле элемента передатчика: Length 1 (у 802.11-2020 других полей нет), B1–B7 = 0."""
    v = []
    if len(info) != ADDBA_EXT_LEN:
        v.append(f'ADDBA Extension: Length {len(info)} ≠ 1 (рис. 9-579; расширения 802.11-2020 не определяет)')
    if info and info[0] >> 1:
        v.append(f'ADDBA Capabilities: B1–B7 = 0x{info[0] >> 1:02x} — Reserved (рис. 9-580; HE Fragmentation '
                 f'Operation / Extended Buffer Size — не 802.11-2020, у DMG не применимы)')
    return v


def frame_elements(body, response):
    """Необязательные элементы ADDBA Request/Response → [Element]."""
    return E.parse_elements(body[ADDBA_FIXED_RESP if response else ADDBA_FIXED_REQ:])


def check_frame(body, response):
    """Элементы ADDBA: порядок табл. 9-360/9-361, ADDBA Extension не более одного и по check. → (нарушения,
    AddbaExt | None)."""
    try:
        els = frame_elements(body, response)
    except ValueError as x:
        return [f'ADDBA: хвост элементов не разбирается: {x}'], None
    v, last, ext, n = [], 0, None, 0
    for el in els:
        o = ORDER.get(el.eid)
        if o is None:
            if el.eid != E.EID_VENDOR_SPECIFIC:
                v.append(f'ADDBA {"Response" if response else "Request"}: элемент {el.eid} не предусмотрен '
                         f'(табл. {"9-361" if response else "9-360"})')
            continue
        if o < last:
            v.append(f'ADDBA: элемент {el.eid} не по порядку табл. {"9-361" if response else "9-360"}')
        last = max(last, o)
        if el.eid == EID_ADDBA_EXT:
            n += 1
            v += check(el.info)
            try:
                ext = parse(el.info)
            except ValueError:
                pass
    if n > 1:
        v.append(f'ADDBA: ADDBA Extension {n} раза (табл. 9-360/9-361 — один)')
    return v, ext


class Agreement:
    """Соглашение Block Ack DMG с точки зрения фрагментации (10.2.6)."""
    def __init__(self, req_ext=None, resp_ext=None):
        self.req_nf = bool(req_ext and req_ext.no_frag)
        self.resp_nf = bool(resp_ext and resp_ext.no_frag)

    def may_fragment(self):
        return not (self.req_nf or self.resp_nf)

    def check_fragment(self, in_ampdu, ack_policy):
        """Фрагмент MSDU (More Fragments = 1 или Fragment Number ≠ 0) с TID соглашения от его originator."""
        v = []
        if self.resp_nf:
            v.append('фрагмент MSDU по соглашению с No-Fragmentation = 1 в ADDBA Response — «The MSDU shall not be '
                     'fragmented» (10.2.6)')
        elif self.req_nf:
            v.append('фрагмент MSDU от originator, заявившего No-Fragmentation = 1 в ADDBA Request («originator is not '
                     'fragmenting», 9.4.2.139; PLAN.md №101)')
        if in_ampdu:
            v.append('фрагмент MSDU в A-MPDU — «within an A-MPDU that does not contain an S-MPDU shall not be '
                     'fragmented»; DMG — только вне A-MPDU (10.2.6)')
        if ack_policy is not None and ack_policy != ACK_NORMAL:
            v.append(f'фрагмент MSDU по соглашению с Ack Policy {ack_policy} — «with Normal Ack ack policy» (10.2.6)')
        return v
