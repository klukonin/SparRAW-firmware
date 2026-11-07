# SPDX-License-Identifier: AGPL-3.0-or-later
"""Поля адресов MAC-заголовка DMG по 802.11-2020: 9.2.4.3 (Address fields [p. 768]: Address 1 — получатель(и),
Address 2 — передатчик; индивидуальный/групповой адрес 9.2.4.3.3; BSSID 9.2.4.3.4 — в инфраструктуре адрес AP, в PBSS
адрес PCP, wildcard только где разрешено; SA — I/G = 0, 9.2.4.3.6; TA — индивидуальный, групповой TA — «bandwidth
signaling TA» только VHT/S1G, 9.2.4.3.8), адреса кадров управления (9.3.3.1 [p. 822]: a)–c)), Public Action (11.17
[p. 2244]), адреса кадров управления (control) по рисункам 9.3.1.x, формат кадров данных DMG (9.3.2.1 [p. 815]:
рис. 9-65, табл. 9-30 по To DS/From DS, BSSID a)/e), QoS Null без тела 9.3.2.1.4, DMG — только QoS Data и QoS Null
и без HT Control, 9.3.2.1.5 NOTE 1/2) и сочетания To DS/From DS (табл. 9-3 данные, табл. 9-4 управление).

Табл. 9-26 (Address Extension Mode) — Mesh Control, только MBSS — вне охвата; четыре адреса (To DS = From DS = 1) у
DMG не определены (табл. 9-3: mesh, S1G relay, GLK) — вердикт model.

check_addresses(raw, kind, ap, pbss)  — нарушения адресов одного MPDU по виду кадра;
check_data_header(raw, length, ap, pbss, agg) — заголовок данных DMG (9.3.2.1) + адреса.
Принято: PLAN.md №108 (DMG CTS-to-self, управление между STA, групповые данные non-AP STA, четыре адреса).
Нарушения — [(текст, вердикт 'ours' | 'model')]."""
from . import fields as F
from .timing import BCAST

WILDCARD = BCAST                         # 9.2.4.3.4: «set to all 1s to indicate the wildcard BSSID»
# RA только индивидуальный (рисунки 9.3.1.x: «address of the STA …»)
RA_INDIVIDUAL = ('RTS', 'DMG CTS', 'Ack', 'BlockAckReq', 'BlockAck', 'Poll', 'SPR', 'Grant Ack', 'SSW',
                 'SSW-Feedback', 'SSW-Ack', 'DMG DTS')
NO_TA = ('Ack', 'CTS', 'DMG DTS')          # 9.3.1: TA нет
CAT_PUBLIC = 4
SUBTYPE_QOS_DATA, SUBTYPE_QOS_NULL = 8, 12
DATA_HDR = 24                            # 9.3.2.1: FC, Duration, A1, A2, A3, Sequence Control
QOS_LEN, A4_LEN, FCS_LEN = 2, 6, 4


def _a(raw, i):
    return F.mac_str(raw[i:i + 6]) if len(raw) >= i + 6 else None


def _group(a):
    return a is not None and F.is_group(a)


def addresses(raw, kind):
    """(A1, A2, A3, A4) по виду кадра (None — поля нет)."""
    fc = F.parse_fc(raw[:2])
    a1 = _a(raw, 4)
    if kind == 'DMG Beacon':
        return a1, None, None, None
    if fc.type == F.TYPE_CTRL or F.fc_is_cfe(fc):
        return a1, (None if kind in NO_TA else _a(raw, 10)), None, None
    a4 = _a(raw, 24) if fc.type == F.TYPE_DATA and fc.to_ds and fc.from_ds else None
    return a1, _a(raw, 10), _a(raw, 16), a4


def check_ta(a2):
    if _group(a2):
        return [(f'TA {a2} групповой — «bandwidth signaling TA» определён только для VHT/S1G (9.2.4.3.8, 9.3.1.2, '
                 f'10.6.6.6); у DMG TA — индивидуальный адрес передатчика (9.2.4.3.1)', 'ours')]
    return []


def check_addresses(raw, kind, ap, pbss=False, src=None):
    """Нарушения адресов MPDU raw вида kind. ap — BSSID (MAC AP/PCP); src — фактический передатчик (MAC узла,
    записавшего TX), если известен."""
    v = []
    if raw is None or len(raw) < 10:
        return v
    fc = F.parse_fc(raw[:2])
    a1, a2, a3, a4 = addresses(raw, kind)
    # 9.3.1.13: DMG CTS-to-self (RA = MAC передатчика) — TA = адрес получателя (индивидуальный или групповой)
    # следующего кадра: исключение из «Address 2 … identifies the transmitter» (правило cts_self)
    cts_self = kind == 'DMG CTS' and src is not None and a1 == src
    if not cts_self:
        v += check_ta(a2)
    if src is not None and a2 is not None and a2 != src and kind != 'DMG Beacon' and not cts_self:
        v.append((f'Address 2 {a2} ≠ адрес передатчика {src} («always identifies the transmitter», 9.2.4.3.1)',
                  'ours'))
    if kind == 'DMG Beacon':
        if _group(a1):
            v.append((f'DMG Beacon: BSS ID {a1} групповой (9.3.4.2, 9.2.4.3.4)', 'ours'))
        elif ap is not None and src == ap and a1 != ap:
            v.append((f'DMG Beacon: BSS ID {a1} ≠ MAC точки {ap} (9.2.4.3.4)', 'ours'))
        return v
    if fc.type == F.TYPE_CTRL or F.fc_is_cfe(fc):
        if kind in RA_INDIVIDUAL and _group(a1):
            v.append((f'{kind}: RA {a1} групповой — по рисунку 9.3.1 RA — адрес одной STA', 'ours'))
        if kind == 'CF-End' and _group(a1) and a1 != BCAST:
            v.append((f'CF-End DMG: RA {a1} — «the MAC address of the STA … or the broadcast address» (9.3.1.6)',
                      'ours'))
        return v
    if fc.type == F.TYPE_MGMT:
        return v + _check_mgmt(raw, fc, a1, a2, a3, ap)
    if fc.type == F.TYPE_DATA:
        return v + _check_data_addr(raw, fc, a1, a2, a3, a4, ap, pbss)
    return v


def _check_mgmt(raw, fc, a1, a2, a3, ap):
    v = []
    td = (fc.to_ds, fc.from_ds)
    if td == (1, 0):
        v.append(('кадр управления To DS = 1 — только QMF (табл. 9-4); QMF в open нет', 'model'))
    elif td != (0, 0):
        v.append((f'кадр управления To DS/From DS {td[0]}/{td[1]} — Reserved (табл. 9-4)', 'ours'))
    probe_req = fc.subtype == 4
    public = fc.subtype in (13, 14) and len(raw) > 24 and raw[24] & 0x7f == CAT_PUBLIC
    if probe_req:
        return v                         # 9.3.3.1 c) 1): wildcard или BSSID адресата
    if public:
        # 11.17: члены одной BSS — BSSID; групповой — BSSID или wildcard; чужой BSS — BSSID или wildcard
        if ap is not None and a1 == ap and a3 not in (ap, WILDCARD) and a2 != ap:
            v.append((f'Public Action к своей точке: Address 3 {a3} ≠ BSSID {ap} (11.17)', 'ours'))
        if ap is not None and a2 == ap and a3 not in (ap, WILDCARD):
            v.append((f'Public Action точки: Address 3 {a3} ≠ свой BSSID и не wildcard (11.17)', 'ours'))
        return v
    if a3 == WILDCARD:
        v.append(('Address 3 = wildcard BSSID — «not used … except where explicitly permitted» (9.2.4.3.4; разрешено '
                  'Probe Request и Public Action, 9.3.3.1 c))', 'ours'))
        return v
    if ap is None:
        return v
    if a2 == ap:
        if a3 != a2:
            v.append((f'кадр управления точки: Address 3 {a3} ≠ Address 2 {a2} (9.3.3.1 c) 4) i))', 'ours'))
    elif a1 == ap:
        if a3 != ap:
            v.append((f'кадр управления к точке: Address 3 {a3} ≠ BSSID {ap} (9.3.3.1 c) 4) ii))', 'ours'))
    elif a3 != ap:
        # между non-AP STA одной DMG BSS (SP между STA): «the Address 3 field is the BSSID» (по аналогии c) 4) iv)/vi))
        v.append((f'кадр управления между STA BSS: Address 3 {a3} ≠ BSSID {ap} (9.3.3.1 c) 4))', 'model'))
    return v


def _check_data_addr(raw, fc, a1, a2, a3, a4, ap, pbss):
    v = []
    td = (fc.to_ds, fc.from_ds)
    amsdu = _amsdu_present(raw, fc)
    if td == (1, 1):
        return [('данные To DS = From DS = 1 (четыре адреса) — у DMG не определено (табл. 9-3: mesh, S1G relay, GLK)',
                 'model')]
    if pbss:
        if td != (0, 0):
            v.append((f'данные в PBSS To DS/From DS {td[0]}/{td[1]} — «the only valid combination … PBSS STA» 0/0 '
                      f'(табл. 9-3)', 'ours'))
        if ap is not None and a3 != ap:
            v.append((f'данные в PBSS: Address 3 (BSSID) {a3} ≠ адрес PCP {ap} (9.3.2.1.2 e))', 'ours'))
        return v
    src_ap = ap is not None and a2 == ap
    if src_ap:
        if td != (0, 1):
            v.append((f'данные точки To DS/From DS {td[0]}/{td[1]} — у не-GLK AP допустимо только 0/1 (табл. 9-3)',
                      'ours'))
        elif not amsdu and _group(a3):
            v.append((f'данные точки: Address 3 (SA) {a3} групповой (9.2.4.3.6: I/G SA = 0)', 'ours'))
        return v
    if td == (0, 1):
        v.append(('данные non-AP STA с From DS = 1 — только AP (табл. 9-3)', 'ours'))
    elif td == (1, 0):
        if ap is not None and a1 != ap:
            v.append((f'данные к DS: Address 1 {a1} ≠ BSSID {ap} (табл. 9-30: RA = BSSID)', 'ours'))
    elif td == (0, 0):
        if _group(a1):
            v.append((f'данные non-AP STA напрямую: Address 1 {a1} групповой — групповые кадры non-AP STA идут через '
                      f'AP (To DS = 1, табл. 9-3, 9-30)', 'model'))
        if ap is not None and a3 != ap:
            v.append((f'данные между STA BSS: Address 3 (BSSID) {a3} ≠ {ap} (табл. 9-30, 9.3.2.1.2 a))', 'ours'))
    return v


def _amsdu_present(raw, fc):
    off = DATA_HDR + (A4_LEN if fc.to_ds and fc.from_ds else 0)
    if fc.subtype & 8 and len(raw) >= off + 1:
        return bool(raw[off] >> 7 & 1)
    return False


def header_len(fc):
    """Длина заголовка данных (рис. 9-65): 24 + A4 + QoS Control (+ HT Control при Order у QoS)."""
    n = DATA_HDR + (A4_LEN if fc.to_ds and fc.from_ds else 0) + (QOS_LEN if fc.subtype & 8 else 0)
    if fc.htc and fc.subtype & 8:
        n += 4
    return n


def check_data_header(raw, length, ap, pbss=False, agg=False, src=None):
    """9.3.2.1 для DMG: подтип — только QoS Data/QoS Null (NOTE 1), HT Control нет (NOTE 2: +HTC/Order = 0),
    QoS Null — тело пустое (9.3.2.1.4; длина PSDU = заголовок + FCS, если PPDU не A-MPDU), адреса (табл. 9-30)."""
    fc = F.parse_fc(raw[:2])
    v = []
    if fc.type != F.TYPE_DATA:
        return v
    if fc.subtype not in (SUBTYPE_QOS_DATA, SUBTYPE_QOS_NULL):
        v.append((f'подтип данных {fc.subtype} — DMG STA передаёт только QoS Data и QoS Null (9.3.2.1.5 NOTE 1)',
                  'ours'))
    if fc.htc:
        v.append(('+HTC/Order = 1 в кадре данных DMG — HT Control у DMG нет (9.3.2.1.5 NOTE 2, 9.2.4.1.10)', 'ours'))
    if fc.subtype == SUBTYPE_QOS_NULL and length is not None and not agg:
        want = header_len(fc) + FCS_LEN
        if length != want:
            v.append((f'QoS Null: PSDU {length} октетов ≠ заголовок + FCS = {want} — тело QoS Null пустое (9.3.2.1.4)',
                      'ours'))
    return v + check_addresses(raw, 'QoS Null' if fc.subtype == SUBTYPE_QOS_NULL else 'Data', ap, pbss, src)
