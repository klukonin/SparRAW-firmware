# SPDX-License-Identifier: AGPL-3.0-or-later
"""Элементы и тела кадров управления DMG по 802.11-2020, бит-в-бит: encode / parse / validate и проверка порядка.

Охват:
  9.4.2.1, табл. 9-92      — заголовок элемента (Element ID, Length, Element ID Extension), таблица ID;
  10.28.6, 10.28.8         — разбор: неизвестные ID пропускаются, хвост расширяемого элемента отбрасывается;
  10.28.11, 10.28.12       — фрагментация элемента (Fragment element) и сборка;
  9.4.1.1–9.4.1.10         — поля тел: Authentication Algorithm Number, Transaction Seq, Beacon Interval,
                             Capability Information (рис. 9-86, DMG), Current AP Address, Listen Interval,
                             Reason Code, AID (DMG: 1…254), Status Code, Timestamp;
  9.4.1.46                 — DMG Parameters (рис. 9-133, табл. 9-68) внутри Capability Information;
  9.4.2.2 SSID, 9.4.2.24.1 RSNE (только общая структура), 9.4.2.25 Vendor Specific, 9.4.2.48 TIE;
  9.4.2.126 DMG BSS Parameter Change, 9.4.2.127 DMG Capabilities (DMG STA / DMG AP Or PCP Capability
  Information, Supported MCS Set, Extended SC MCS, A-MSDU), 9.4.2.128 DMG Operation,
  9.4.2.131 Extended Schedule (Allocation, Allocation Control DMG, табл. 9-257), 9.4.2.135 Next DMG ATI;
  9.3.3.1, 9.3.3.4–9.3.3.12 — тела Probe Request/Response, (Re)Association Request/Response, Authentication,
                             Deauthentication, Disassociation; порядок элементов (табл. 9-33…9-42),
                             обязательность и запреты для DMG STA.

Не моделируется: BF Control (9.5.5) в Allocation — сырое 16-битное значение (это fields.py); CDMG/CMMG-варианты
(рис. 9-565); содержимое RSNE глубже Version/шифров/AKM/PMKID (без проверки допустимых наборов); поля SAE/FILS
в Authentication (только Open System, Shared Key и FT — у них после Status Code идут лишь элементы); MME и
его проверка; RIC как набор элементов (в таблицах порядка RIC представлен только RDE); Multi-band, Relay и прочие
элементы — только как ID в таблице 9-92 и в таблицах порядка; MAC-заголовок (Address 1/2/3) — не здесь.

Представление: подполя — dict {имя: int}, зарезервированные подполя имеют имена с «_»; MAC-адрес — строка
'aa:bb:cc:dd:ee:ff' (октет 0 слева, рис. 9-1); элемент — Element(eid, ext, info), info без октета Extension.
Нарушения — список строк (пустой — нарушений нет), как в cbap.check_air_log."""
import re
from collections import namedtuple
from fractions import Fraction as Fr

from .timing import (AID_AP_PCP, AID_BROADCAST, ALLOC_CBAP, ALLOC_CBAP_1G08, ALLOC_SP, ALLOC_SP_1G08,
                     ASSOC_RESP_CONFIRM_UNIT, SC_MCS, TSF_LOW_MOD, TU)

# =====================================================================================================
# 9.2.2: числа — без знака, little-endian (октет с младшими битами передаётся первым); зарезервированные
# поля и подполя — 0 при передаче, игнорируются при приёме.
# =====================================================================================================


def pack(layout, values):
    """Упаковка подполей по рисунку: layout — [(имя, ширина бит)], от B0 вверх (9.2.2). Отсутствующие — 0."""
    v, pos = 0, 0
    unknown = set(values) - {n for n, _ in layout}
    if unknown:
        raise KeyError(f'неизвестные подполя {sorted(unknown)}')
    for name, w in layout:
        x = int(values.get(name, 0))
        if not 0 <= x < (1 << w):
            raise ValueError(f'{name}={x} не помещается в {w} бит')
        v |= x << pos
        pos += w
    return v


def unpack(layout, v):
    out, pos = {}, 0
    for name, w in layout:
        out[name] = (v >> pos) & ((1 << w) - 1)
        pos += w
    return out


def width(layout):
    return sum(w for _, w in layout)


def reserved_nonzero(layout, values, where):
    """9.2.2: «Reserved fields and subfields … are set to 0 upon transmission»."""
    return [f'{where}: зарезервированное подполе {n} = {values[n]} ≠ 0 (9.2.2)'
            for n, _ in layout if n.startswith('_') and values.get(n, 0)]


def le(v, n):
    return int(v).to_bytes(n, 'little')


def mac_bytes(a):
    """Рис. 9-1: октет 0 (с битом I/G) передаётся первым — это левый октет записи aa:bb:…"""
    if isinstance(a, (bytes, bytearray)):
        if len(a) != 6:
            raise ValueError('MAC-адрес — 6 октетов')
        return bytes(a)
    b = bytes.fromhex(a.replace(':', '').replace('-', ''))
    if len(b) != 6:
        raise ValueError('MAC-адрес — 6 октетов')
    return b


def mac_str(b):
    return ':'.join(f'{x:02x}' for x in b)


# =====================================================================================================
# 9.4.2.1, табл. 9-92 — Element ID
# =====================================================================================================
# (имя, Element ID, Element ID Extension или None, флаги: [0] Extensible Y/N/S(Subelements)/V(Vendor defined),
# [1] Fragmentable Y/N). TSPEC: «In a DMG BSS: yes» — здесь Y (модель DMG).
ELEMENT_TABLE = (
    ('SSID', 0, None, 'NN'), ('Supported Rates and BSS Membership Selectors', 1, None, 'NN'),
    ('DSSS Parameter Set', 3, None, 'NN'), ('TIM', 5, None, 'NN'), ('IBSS Parameter Set', 6, None, 'NN'),
    ('Country', 7, None, 'NN'), ('Request', 10, None, 'NN'), ('BSS Load', 11, None, 'NN'),
    ('EDCA Parameter Set', 12, None, 'NN'), ('TSPEC', 13, None, 'YN'), ('TCLAS', 14, None, 'NN'),
    ('Schedule', 15, None, 'NN'), ('Challenge text', 16, None, 'NN'), ('Power Constraint', 32, None, 'NN'),
    ('Power Capability', 33, None, 'NN'), ('TPC Request', 34, None, 'NN'), ('TPC Report', 35, None, 'NN'),
    ('Supported Channels', 36, None, 'NN'), ('Channel Switch Announcement', 37, None, 'NN'),
    ('Measurement Request', 38, None, 'SN'), ('Measurement Report', 39, None, 'SN'), ('Quiet', 40, None, 'NN'),
    ('IBSS DFS', 41, None, 'NN'), ('ERP', 42, None, 'YN'), ('TS Delay', 43, None, 'NN'),
    ('TCLAS Processing', 44, None, 'NN'), ('HT Capabilities', 45, None, 'YN'), ('QoS Capability', 46, None, 'NN'),
    ('RSN', 48, None, 'YN'), ('Extended Supported Rates and BSSMembership Selectors', 50, None, 'NN'),
    ('AP Channel Report', 51, None, 'NN'), ('Neighbor Report', 52, None, 'SN'), ('RCPI', 53, None, 'YN'),
    ('Mobility Domain (MDE)', 54, None, 'NN'), ('Fast BSS Transition (FTE)', 55, None, 'NN'),
    ('Timeout Interval', 56, None, 'NN'), ('RIC Data (RDE)', 57, None, 'NN'),
    ('DSE Registered Location', 58, None, 'NN'), ('Supported Operating Classes', 59, None, 'NN'),
    ('Extended Channel Switch Announcement', 60, None, 'NN'), ('HT Operation', 61, None, 'YN'),
    ('Secondary Channel Offset', 62, None, 'NN'), ('BSS Average Access Delay', 63, None, 'YN'),
    ('Antenna', 64, None, 'YN'), ('RSNI', 65, None, 'YN'), ('Measurement Pilot Transmission', 66, None, 'SN'),
    ('BSS Available Admission Capacity', 67, None, 'YN'), ('BSS AC Access Delay', 68, None, 'YN'),
    ('Time Advertisement', 69, None, 'YN'), ('RM Enabled Capabilities', 70, None, 'YN'),
    ('Multiple BSSID', 71, None, 'SN'), ('20/40 BSS Coexistence', 72, None, 'YN'),
    ('20/40 BSS Intolerant Channel Report', 73, None, 'NN'), ('Overlapping BSS Scan Parameters', 74, None, 'NN'),
    ('RIC Descriptor', 75, None, 'NN'), ('Management MIC', 76, None, 'NN'), ('Event Request', 78, None, 'SN'),
    ('Event Report', 79, None, 'NN'), ('Diagnostic Request', 80, None, 'SN'), ('Diagnostic Report', 81, None, 'SN'),
    ('Location Parameters', 82, None, 'SN'), ('Nontransmitted BSSID Capability', 83, None, 'NN'),
    ('SSID List', 84, None, 'NN'), ('Multiple BSSID-Index', 85, None, 'NN'), ('FMS Descriptor', 86, None, 'NN'),
    ('FMS Request', 87, None, 'SN'), ('FMS Response', 88, None, 'SN'), ('QoS Traffic Capability', 89, None, 'YN'),
    ('BSS Max Idle Period', 90, None, 'YN'), ('TFS Request', 91, None, 'SN'), ('TFS Response', 92, None, 'SN'),
    ('WNM Sleep Mode', 93, None, 'YN'), ('TIM Broadcast Request', 94, None, 'YN'),
    ('TIM Broadcast Response', 95, None, 'YN'), ('Collocated Interference Report', 96, None, 'YN'),
    ('Channel Usage', 97, None, 'SN'), ('Time Zone', 98, None, 'YN'), ('DMS Request', 99, None, 'SN'),
    ('DMS Response', 100, None, 'SN'), ('Link Identifier', 101, None, 'YN'), ('Wakeup Schedule', 102, None, 'YN'),
    ('Channel Switch Timing', 104, None, 'YN'), ('PTI Control', 105, None, 'YN'),
    ('TPU Buffer Status', 106, None, 'YN'), ('Interworking', 107, None, 'NN'),
    ('Advertisement Protocol', 108, None, 'NN'), ('Expedited Bandwidth Request', 109, None, 'NN'),
    ('QoS Map', 110, None, 'YN'), ('Roaming Consortium', 111, None, 'YN'),
    ('Emergency Alert Identifier', 112, None, 'NN'), ('Mesh Configuration', 113, None, 'YN'),
    ('Mesh ID', 114, None, 'NN'), ('Mesh Link Metric Report', 115, None, 'NN'),
    ('Congestion Notification', 116, None, 'YN'), ('Mesh Peering Management', 117, None, 'YN'),
    ('Mesh Channel Switch Parameters', 118, None, 'YN'), ('Mesh Awake Window', 119, None, 'YN'),
    ('Beacon Timing', 120, None, 'NN'), ('MCCAOP Setup Request', 121, None, 'YN'),
    ('MCCAOP Setup Reply', 122, None, 'NN'), ('MCCAOP Advertisement', 123, None, 'YN'),
    ('MCCAOP Teardown', 124, None, 'YN'), ('GANN', 125, None, 'YN'), ('RANN', 126, None, 'YN'),
    ('Extended Capabilities', 127, None, 'YN'), ('PREQ', 130, None, 'YN'), ('PREP', 131, None, 'YN'),
    ('PERR', 132, None, 'YN'), ('PXU', 137, None, 'YN'), ('PXUC', 138, None, 'YN'),
    ('Authenticated Mesh Peering Exchange', 139, None, 'NN'), ('MIC', 140, None, 'NN'),
    ('Destination URI', 141, None, 'YN'), ('U-APSD Coexistence', 142, None, 'SN'),
    ('DMG Wakeup Schedule', 143, None, 'YN'), ('Extended Schedule', 144, None, 'YN'),
    ('STA Availability', 145, None, 'YN'), ('DMG TSPEC', 146, None, 'YN'), ('Next DMG ATI', 147, None, 'YN'),
    ('DMG Capabilities', 148, None, 'YN'), ('DMG Operation', 151, None, 'YN'),
    ('DMG BSS Parameter Change', 152, None, 'YN'), ('DMG Beam Refinement', 153, None, 'YN'),
    ('Channel Measurement Feedback', 154, None, 'YN'), ('Awake Window', 157, None, 'YN'),
    ('Multi-band', 158, None, 'YN'), ('ADDBA Extension', 159, None, 'YN'), ('NextPCP List', 160, None, 'YN'),
    ('PCP Handover', 161, None, 'YN'), ('DMG Link Margin', 162, None, 'YN'), ('Switching Stream', 163, None, 'YN'),
    ('Session Transition', 164, None, 'YN'), ('Cluster Report', 166, None, 'YN'),
    ('Relay Capabilities', 167, None, 'YN'), ('Relay Transfer Parameter Set', 168, None, 'YN'),
    ('BeamLink Maintenance', 169, None, 'YN'), ('Multiple MAC Sublayers', 170, None, 'YN'),
    ('U-PID', 171, None, 'YN'), ('DMG Link Adaptation Acknowledgment', 172, None, 'YN'),
    ('MCCAOP Advertisement Overview', 174, None, 'YN'), ('Quiet Period Request', 175, None, 'YN'),
    ('Quiet Period Response', 177, None, 'YN'), ('QMF Policy', 181, None, 'NN'), ('ECAPC Policy', 182, None, 'YN'),
    ('Cluster Time Offset', 183, None, 'YN'), ('Intra-Access Category Priority', 184, None, 'YN'),
    ('SCS Descriptor', 185, None, 'SN'), ('QLoad Report', 186, None, 'SN'),
    ('HCCA TXOP Update Count', 187, None, 'NN'), ('Higher Layer Stream ID', 188, None, 'YN'),
    ('GCR Group Address', 189, None, 'NN'), ('Antenna Sector ID Pattern', 190, None, 'YN'),
    ('VHT Capabilities', 191, None, 'YN'), ('VHT Operation', 192, None, 'YN'),
    ('Extended BSS Load', 193, None, 'YN'), ('Wide Bandwidth Channel Switch', 194, None, 'YN'),
    ('Transmit Power Envelope', 195, None, 'YN'), ('Channel Switch Wrapper', 196, None, 'SN'),
    ('AID', 197, None, 'NN'), ('Quiet Channel', 198, None, 'YN'), ('Operating Mode Notification', 199, None, 'YN'),
    ('UPSIM', 200, None, 'YN'), ('Reduced Neighbor Report', 201, None, 'YN'), ('TVHT Operation', 202, None, 'YN'),
    ('Device Location', 204, None, 'YN'), ('White Space Map', 205, None, 'YN'),
    ('Fine Timing Measurement Parameters', 206, None, 'YN'), ('S1G Open-Loop Link Margin Index', 207, None, 'NN'),
    ('RPS', 208, None, 'NN'), ('Page Slice', 209, None, 'NN'), ('AID Request', 210, None, 'NN'),
    ('AID Response', 211, None, 'NN'), ('S1G Sector Operation', 212, None, 'YN'),
    ('S1G Beacon Compatibility', 213, None, 'NN'), ('Short Beacon Interval', 214, None, 'NN'),
    ('Change Sequence', 215, None, 'NN'), ('TWT', 216, None, 'YN'), ('S1G Capabilities', 217, None, 'YN'),
    ('Subchannel Selective Transmission', 220, None, 'NN'), ('Vendor Specific', 221, None, 'VN'),
    ('Authentication Control', 222, None, 'YN'), ('TSF Timer Accuracy', 223, None, 'NN'),
    ('S1G Relay', 224, None, 'YN'), ('Reachable Address', 225, None, 'YN'), ('S1G Relay Discovery', 226, None, 'NN'),
    ('AID Announcement', 228, None, 'NN'), ('PV1 Probe Response Option', 229, None, 'NN'),
    ('EL Operation', 230, None, 'NN'), ('Sectorized Group ID List', 231, None, 'YN'),
    ('S1G Operation', 232, None, 'NN'), ('Header Compression', 233, None, 'YN'), ('SST Operation', 234, None, 'NN'),
    ('MAD', 235, None, 'NN'), ('S1G Relay Activation', 236, None, 'YN'), ('CAG Number', 237, None, 'NN'),
    ('AP-CSN', 239, None, 'NN'), ('FILS Indication', 240, None, 'NY'), ('DILS', 241, None, 'YN'),
    ('Fragment', 242, None, 'NN'), ('RSN Extension', 244, None, 'YN'), ('Association Delay Info', 255, 1, 'NN'),
    ('FILS Request Parameters', 255, 2, 'NN'), ('FILS Key Confirmation', 255, 3, 'NY'),
    ('FILS Session', 255, 4, 'NN'), ('FILS HLP Container', 255, 5, 'NY'),
    ('FILS IP Address Assignment', 255, 6, 'NN'), ('Key Delivery', 255, 7, 'NY'),
    ('FILS Wrapped Data', 255, 8, 'NY'), ('FTM Synchronization Information', 255, 9, 'YN'),
    ('Extended Request', 255, 10, 'NN'), ('Estimated Service Parameters Inbound', 255, 11, 'YN'),
    ('FILS Public Key', 255, 12, 'NY'), ('FILS Nonce', 255, 13, 'NN'), ('Future Channel Guidance', 255, 14, 'NN'),
    ('Service Hint', 255, 15, 'NN'), ('Service Hash', 255, 16, 'NN'), ('CDMG Capabilities', 255, 17, 'YN'),
    ('Dynamic Bandwidth Control', 255, 18, 'YN'), ('CDMG Extended Schedule', 255, 19, 'YY'),
    ('SSW Report', 255, 20, 'YY'), ('Cluster Probe', 255, 21, 'YN'), ('Extended Cluster Report', 255, 22, 'YN'),
    ('Cluster Switch Announcement', 255, 23, 'YN'), ('Enhanced Beam Tracking', 255, 24, 'YN'),
    ('SPSH Report', 255, 25, 'YY'), ('Clustering Interference Assessment', 255, 26, 'YN'),
    ('CMMG Capabilities', 255, 27, 'YN'), ('CMMG Operation', 255, 28, 'YN'),
    ('CMMG Operating Mode Notification', 255, 29, 'YN'), ('CMMG Link Margin', 255, 30, 'YN'),
    ('CMMG Link Adaptation Acknowledgment', 255, 31, 'YN'), ('Password Identifier', 255, 33, 'NN'),
    ('GLK-GCR Parameter Set', 255, 34, 'YN'), ('GAS Extension', 255, 40, 'YY'),
    ('Vendor Specific Request Element', 255, 44, 'NN'), ('Max Channel Switch Time', 255, 52, 'NN'),
    ('Estimated Service Parameters Outbound', 255, 53, 'YN'),
    ('Operating Channel Information (OCI)', 255, 54, 'YN'), ('Non-Inheritance', 255, 56, 'YN'),
    ('MSCS Descriptor', 255, 88, 'YN'), ('TCLAS Mask', 255, 89, 'YN'),
    ('Supplemental Class 2 Capabilities', 255, 90, 'NN'), ('OCT Source', 255, 91, 'YN'),
    ('Rejected Groups', 255, 92, 'NN'), ('Anti-Clogging Token Container', 255, 93, 'NN'),
)

EID_SSID = 0
EID_SUPPORTED_RATES = 1
EID_CHALLENGE_TEXT = 16
EID_CSA = 37
EID_RSN = 48
EID_EXT_SUPPORTED_RATES = 50
EID_NEIGHBOR_REPORT = 52
EID_TIMEOUT_INTERVAL = 56
EID_RDE = 57
EID_MME = 76                    # Management MIC
EID_EXTENDED_SCHEDULE = 144
EID_NEXT_DMG_ATI = 147
EID_DMG_CAPABILITIES = 148
EID_DMG_OPERATION = 151
EID_DMG_BSS_PARAMETER_CHANGE = 152
EID_ANTENNA_SECTOR_ID_PATTERN = 190
EID_VENDOR_SPECIFIC = 221
EID_FRAGMENT = 242
EID_EXTENSION = 255             # табл. 9-92: «Element ID Extension present»

ELEMENT_MAX_INFO = 255          # 9.4.2.1/10.28.11: Length — 1 октет; с Extension на информацию остаётся 254


def _norm(name):
    """Ключ имени для сопоставления названий из таблиц кадров и табл. 9-92: без скобок, слова «element»,
    регистра и не-буквенно-цифровых символов (табл. 9-34 пишет «BSSMembership», 9-92 — «BSS Membership»)."""
    s = re.sub(r'\([^)]*\)', '', name).lower()
    s = re.sub(r'\belement\b', '', s)
    return re.sub(r'[^a-z0-9]', '', s)


ELEMENTS = {}       # _norm(имя) → (eid, ext)
ELEMENT_INFO = {}   # (eid, ext) → (имя, extensible, fragmentable)
for _n, _e, _x, _f in ELEMENT_TABLE:
    ELEMENTS[_norm(_n)] = (_e, _x)
    ELEMENT_INFO[(_e, _x)] = (_n, _f[0], _f[1] == 'Y')
# названия строк таблиц кадров, отличающиеся от табл. 9-92
ELEMENTS.update({
    'oci': (255, 54),                               # «OCI» = Operating Channel Information (OCI) element
    'resourceinformationcontainer': (EID_RDE, None),  # RIC начинается с RDE (9.4.2.49, 11.11.3) — см. докстроку
    'ric': (EID_RDE, None),
    'dseregisteredlocation': (58, None),
})


def element_key(name):
    """Имя элемента (как в таблицах) → (eid, ext)."""
    return ELEMENTS[_norm(name)]


Element = namedtuple('Element', 'eid ext info')


def encode_element(eid, info, ext=None):
    """Рис. 9-145: Element ID (1), Length (1), Element ID Extension (0/1), Information. Length — число октетов
    после поля Length, т. е. с октетом Extension (9.4.2.1)."""
    info = bytes(info)
    if (eid == EID_EXTENSION) != (ext is not None):
        raise ValueError('Element ID Extension присутствует тогда и только тогда, когда Element ID = 255')
    body = (bytes([ext]) if ext is not None else b'') + info
    if len(body) > ELEMENT_MAX_INFO:
        raise ValueError(f'элемент {eid}/{ext}: {len(body)} > 255 октетов — нужна фрагментация (10.28.11)')
    return bytes([eid, len(body)]) + body


def encode_fragmented(eid, info, ext=None):
    """10.28.11: ведущий элемент — 255 октетов информации (254 с Extension), затем Fragment-элементы по 255,
    последний — остаток. Помещающаяся информация не фрагментируется («shall not be fragmented»)."""
    info = bytes(info)
    first = ELEMENT_MAX_INFO - (ext is not None)
    if len(info) <= first:
        return encode_element(eid, info, ext)
    out = encode_element(eid, info[:first], ext)
    rest = info[first:]
    while rest:
        out += encode_element(EID_FRAGMENT, rest[:ELEMENT_MAX_INFO])
        rest = rest[ELEMENT_MAX_INFO:]
    return out


def parse_elements(buf, defragment=True):
    """Последовательность элементов → [Element]. Обрезанный элемент — ValueError. При defragment ведущий элемент
    с полной длиной (255) склеивается с идущими следом Fragment-элементами (10.28.12)."""
    buf = bytes(buf)
    out, i = [], 0
    while i < len(buf):
        if i + 2 > len(buf):
            raise ValueError(f'обрезанный заголовок элемента на смещении {i}')
        eid, ln = buf[i], buf[i + 1]
        if i + 2 + ln > len(buf):
            raise ValueError(f'элемент {eid} на смещении {i}: Length {ln} выходит за конец тела')
        body = buf[i + 2:i + 2 + ln]
        i += 2 + ln
        ext = None
        if eid == EID_EXTENSION:
            if ln < 1:
                raise ValueError('элемент 255 без октета Element ID Extension')
            ext, body = body[0], body[1:]
        if defragment and eid == EID_FRAGMENT and out and out[-1][3]:
            prev = out[-1]
            full = ln == ELEMENT_MAX_INFO
            out[-1] = [prev[0], prev[1], prev[2] + body, full]
            continue
        # 10.28.11 NOTE: Fragment следует только за элементом с полной длиной
        full = ln == ELEMENT_MAX_INFO and eid != EID_FRAGMENT
        out.append([eid, ext, body, full])
    return [Element(e, x, bytes(b)) for e, x, b, _ in out]


def encode_elements(elements):
    """[Element | bytes] → bytes; Element с длинной информацией фрагментируется (10.28.11)."""
    out = b''
    for el in elements:
        out += bytes(el) if isinstance(el, (bytes, bytearray)) else encode_fragmented(el.eid, el.info, el.ext)
    return out


def known_info(info, n, name):
    """10.28.8: у расширяемого элемента длина больше известной — лишнее отбрасывается; меньше — ошибка."""
    if len(info) < n:
        raise ValueError(f'{name}: {len(info)} октетов < {n}')
    return info[:n]


# =====================================================================================================
# Поля фиксированной части тел (9.4.1)
# =====================================================================================================
# 9.4.1.1
AUTH_OPEN_SYSTEM, AUTH_SHARED_KEY, AUTH_FT, AUTH_SAE = 0, 1, 2, 3
AUTH_FILS_SK, AUTH_FILS_SK_PFS, AUTH_FILS_PK, AUTH_VENDOR = 4, 5, 6, 65535

# 9.4.1.9, табл. 9-50 (используемые здесь)
SUCCESS = 0
REFUSED = 1
REFUSED_CAPABILITIES_MISMATCH = 10
DENIED_NO_ASSOCIATION_EXISTS = 11
UNSUPPORTED_AUTH_ALGORITHM = 13
TRANSACTION_SEQUENCE_ERROR = 14
DENIED_NO_MORE_STAS = 17
REFUSED_TEMPORARILY = 30
REJECTED_WITH_SUGGESTED_BSS_TRANSITION = 82

# 9.4.1.7, табл. 9-49 (используемые здесь); 0 — Reserved
REASON_RESERVED = 0
UNSPECIFIED_REASON = 1
INVALID_AUTHENTICATION = 2
LEAVING_NETWORK_DEAUTH = 3
REASON_INACTIVITY = 4
NO_MORE_STAS = 5
INVALID_CLASS2_FRAME = 6
INVALID_CLASS3_FRAME = 7
LEAVING_NETWORK_DISASSOC = 8

# 9.4.1.8: DMG AID 1…254; 255 — широковещательный AID; 0 — AP или PCP (AID_AP_PCP/AID_BROADCAST — timing.py);
# 8 старших бит зарезервированы
AID_DMG_MIN, AID_DMG_MAX = 1, 254

# 9.4.1.46, рис. 9-133 — DMG Parameters
DMG_PARAMS = [('bss_type', 2), ('cbap_only', 1), ('cbap_source', 1), ('dmg_privacy', 1),
              ('ecapc_policy_enforced', 1), ('_r6', 2)]
# табл. 9-68 (Discovery Mode = 0)
BSS_TYPE_INFRA, BSS_TYPE_PBSS, BSS_TYPE_IBSS, BSS_TYPE_RESERVED = 3, 2, 1, 0

# 9.4.1.4, рис. 9-86 — Capability Information (DMG STA)
CAPINFO_DMG = [('dmg_params', 8), ('spectrum_mgmt', 1), ('triggered_unscheduled_ps', 1), ('_r10', 2),
               ('radio_measurement', 1), ('epd', 1), ('_r14', 2)]


def encode_capinfo_dmg(ci):
    """Capability Information DMG STA → 2 октета; ci['dmg_params'] — int или dict по рис. 9-133."""
    ci = dict(ci)
    if isinstance(ci.get('dmg_params'), dict):
        ci['dmg_params'] = pack(DMG_PARAMS, ci['dmg_params'])
    return le(pack(CAPINFO_DMG, ci), 2)


def parse_capinfo_dmg(b):
    ci = unpack(CAPINFO_DMG, int.from_bytes(b[:2], 'little'))
    ci['dmg_params'] = unpack(DMG_PARAMS, ci['dmg_params'])
    return ci


# Роли передающей STA
ROLE_AP, ROLE_PCP, ROLE_STA, ROLE_IBSS = 'ap', 'pcp', 'sta', 'ibss'
# 9.4.1.46: «An AP sets the BSS Type subfield to 3 …», «A PCP … to 2», «An IBSS STA or a STA that is not
# a member of a BSS … to 1» (последнее — только DMG Beacon и Probe Response)
_BSS_TYPE_BY_ROLE = {ROLE_AP: BSS_TYPE_INFRA, ROLE_PCP: BSS_TYPE_PBSS, ROLE_IBSS: BSS_TYPE_IBSS,
                     ROLE_STA: BSS_TYPE_IBSS}


def validate_capinfo_dmg(ci, frame, role, rd=None):
    """Проверка Capability Information DMG в кадре frame от STA с ролью role. rd — Reverse Direction из
    DMG STA Capability Information того же кадра (для Triggered Unscheduled PS), None — не проверять."""
    ci = dict(ci)
    dp = ci['dmg_params'] = unpack(DMG_PARAMS, pack(DMG_PARAMS, ci.get('dmg_params', {}))
                                   if isinstance(ci.get('dmg_params', {}), dict) else ci['dmg_params'])
    ci = unpack(CAPINFO_DMG, pack(CAPINFO_DMG, {**ci, 'dmg_params': 0}))
    v = reserved_nonzero(CAPINFO_DMG, ci, 'Capability Information')
    v += reserved_nonzero(DMG_PARAMS, dp, 'DMG Parameters')
    bt = dp['bss_type']
    # 9.4.1.46: AP/PCP — в Probe Response и (Re)Association Response; IBSS / вне BSS — в Probe Response;
    # «The BSS Type subfield is reserved for all other types of frame»
    if frame in (PROBE_RESP, ASSOC_RESP, REASSOC_RESP) and role in (ROLE_AP, ROLE_PCP):
        want = _BSS_TYPE_BY_ROLE[role]
    elif frame == PROBE_RESP:
        want = BSS_TYPE_IBSS
    else:
        want = 0
    if bt != want:
        v.append(f'DMG Parameters: BSS Type = {bt}, ожидалось {want} для {frame} от {role} (9.4.1.46, табл. 9-68)')
    # 9.4.1.4: TUPS = 1 только в поле, где Reverse Direction = 1
    if rd is not None and ci['triggered_unscheduled_ps'] and not rd:
        v.append('Triggered Unscheduled PS = 1 при Reverse Direction = 0 (9.4.1.4)')
    return v


# =====================================================================================================
# 9.4.2.2 SSID
# =====================================================================================================
SSID_MAX = 32


def encode_ssid(ssid):
    """Рис. 9-146: SSID 0…32 октета; длина 0 — wildcard SSID (в Probe Request)."""
    b = ssid.encode() if isinstance(ssid, str) else bytes(ssid)
    if len(b) > SSID_MAX:
        raise ValueError('SSID длиннее 32 октетов (9.4.2.2)')
    return encode_element(EID_SSID, b)


def parse_ssid(info):
    if len(info) > SSID_MAX:
        raise ValueError('SSID длиннее 32 октетов (9.4.2.2)')
    return bytes(info)


# =====================================================================================================
# 9.4.2.24.1 RSNE — общая структура (рис. 9-287); поля после Version необязательны, но «If any nonzero-length
# field is absent, then none of the subsequent fields are included».
# =====================================================================================================
RSN_VERSION = 1
_RSN_ORDER = ('group_data', 'pairwise', 'akm', 'capabilities', 'pmkids', 'group_mgmt')


def encode_rsne(version=RSN_VERSION, group_data=None, pairwise=None, akm=None, capabilities=None, pmkids=None,
                group_mgmt=None):
    """Шифры/AKM — 4-октетные селекторы (OUI + тип, OUI первым — 9.2.2); pairwise/akm/pmkids — списки."""
    vals = dict(group_data=group_data, pairwise=pairwise, akm=akm, capabilities=capabilities, pmkids=pmkids,
                group_mgmt=group_mgmt)
    out = le(version, 2)
    gap = None
    for k in _RSN_ORDER:
        x = vals[k]
        if x is None:
            gap = k
            continue
        if gap:
            raise ValueError(f'RSNE: {k} без {gap} (9.4.2.24.1)')
        if k in ('group_data', 'group_mgmt'):
            out += _sel(x)
        elif k in ('pairwise', 'akm'):
            out += le(len(x), 2) + b''.join(_sel(s) for s in x)
        elif k == 'capabilities':
            out += le(x, 2)
        else:
            out += le(len(x), 2) + b''.join(bytes(p) for p in x)
            if any(len(p) != 16 for p in x):
                raise ValueError('PMKID — 16 октетов')
    return encode_element(EID_RSN, out)


def _sel(s):
    s = bytes(s)
    if len(s) != 4:
        raise ValueError('селектор набора — 4 октета')
    return s


def parse_rsne(info):
    info = bytes(info)
    if len(info) < 2:
        raise ValueError('RSNE без поля Version')
    r = {'version': int.from_bytes(info[:2], 'little')}
    i = 2

    def take(n):
        nonlocal i
        if i + n > len(info):
            raise ValueError('RSNE обрезан')
        b = info[i:i + n]
        i += n
        return b
    for k in _RSN_ORDER:
        if i == len(info):
            break
        if k in ('group_data', 'group_mgmt'):
            r[k] = take(4)
        elif k in ('pairwise', 'akm'):
            n = int.from_bytes(take(2), 'little')
            r[k] = [take(4) for _ in range(n)]
        elif k == 'capabilities':
            r[k] = int.from_bytes(take(2), 'little')
        else:
            n = int.from_bytes(take(2), 'little')
            r[k] = [take(16) for _ in range(n)]
    # RSN extensible (табл. 9-92) — хвост после известных полей отбрасывается (10.28.8)
    return r


# =====================================================================================================
# 9.4.2.25 Vendor Specific, 9.4.2.48 TIE
# =====================================================================================================
def encode_vendor(oi, content=b''):
    """Рис. 9-290: Organization Identifier (j = 3 для OUI/CID, 5 для OUI-36, 9.4.1.31) + содержимое."""
    oi = bytes(oi)
    if len(oi) not in (3, 5):
        raise ValueError('Organization Identifier — 3 или 5 октетов (9.4.1.31)')
    return encode_element(EID_VENDOR_SPECIFIC, oi + bytes(content))


# табл. 9-182
TIE_REASSOC_DEADLINE, TIE_KEY_LIFETIME, TIE_ASSOC_COMEBACK, TIE_TIME_TO_START = 1, 2, 3, 4


def encode_tie(kind, value):
    """Рис. 9-364: Timeout Interval Type (1), Timeout Interval Value (4, без знака)."""
    if kind not in (1, 2, 3, 4):
        raise ValueError(f'Timeout Interval Type {kind} зарезервирован (табл. 9-182)')
    return encode_element(EID_TIMEOUT_INTERVAL, bytes([kind]) + le(value, 4))


def parse_tie(info):
    if len(info) != 5:
        raise ValueError('TIE: Information — 5 октетов (рис. 9-364)')
    return info[0], int.from_bytes(info[1:5], 'little')


def tie_value_us(kind, value):
    """Табл. 9-182: типы 1, 3, 4 — TU (1024 мкс, 3.1), 2 — секунды. Результат — мкс (Fraction)."""
    if kind == TIE_KEY_LIFETIME:
        return Fr(value) * 1000000
    return Fr(value) * TU




# =====================================================================================================
# 9.4.2.126 DMG BSS Parameter Change (рис. 9-547, 9-548)
# =====================================================================================================
CHANGE_TYPE = [('move', 1), ('size', 1), ('_r2', 6)]


def encode_bss_param_change(move, size, tbtt_offset, bi_duration=0):
    """TBTT Offset — младшие 4 октета TSF первого изменённого TBTT (мкс); BI Duration — TU,
    зарезервирован (0) при Size = 0."""
    if not size and bi_duration:
        raise ValueError('BI Duration зарезервирован при Size = 0 (9.4.2.126)')
    info = bytes([pack(CHANGE_TYPE, {'move': move, 'size': size})]) + le(tbtt_offset, 4) + le(bi_duration, 2)
    return encode_element(EID_DMG_BSS_PARAMETER_CHANGE, info)


def parse_bss_param_change(info):
    info = known_info(info, 7, 'DMG BSS Parameter Change')
    ct = unpack(CHANGE_TYPE, info[0])
    return {'move': ct['move'], 'size': ct['size'], '_r2': ct['_r2'],
            'tbtt_offset': int.from_bytes(info[1:5], 'little'), 'bi_duration': int.from_bytes(info[5:7], 'little')}


# =====================================================================================================
# 9.4.2.127 DMG Capabilities
# =====================================================================================================
# рис. 9-551 — A-MPDU Parameters; рис. 9-552 — Supported MCS Set; вместе с прочими — рис. 9-550 (64 бита)
DMG_STA_CAP = [
    ('reverse_direction', 1), ('higher_layer_timer_sync', 1), ('tpc', 1), ('spsh_interference_mitigation', 1),
    ('num_rx_dmg_antennas', 2), ('fast_link_adaptation', 1), ('total_num_sectors', 7),         # B0–B13
    ('rxss_length', 6), ('dmg_antenna_reciprocity', 1),                                         # B14–B20
    ('max_ampdu_len_exp', 3), ('min_mpdu_start_spacing', 3),                                    # B21–B26
    ('ba_flow_control', 1),                                                                     # B27
    ('max_sc_rx_mcs', 5), ('_r_mcs5', 5), ('max_sc_tx_mcs', 5), ('_r_mcs15', 5),                # B28–B47
    ('low_power_sc', 1), ('code_rate_13_16', 1), ('pi2_8psk', 1), ('_r_mcs23', 1),              # B48–B51
    ('_r52', 1), ('appdu', 1), ('heartbeat', 1), ('supports_other_aid', 1),                     # B52–B55
    ('antenna_pattern_reciprocity', 1), ('heartbeat_elapsed', 3), ('grant_ack', 1),             # B56–B60
    ('rxss_tx_rate', 1), ('epd', 1), ('_r63', 1),                                               # B61–B63
]
# рис. 9-553
DMG_AP_PCP_CAP = [('tddti', 1), ('pseudo_static', 1), ('pcp_handover', 1), ('max_associated_sta', 8),
                  ('power_source', 1), ('decentralized_clustering', 1), ('pcp_forwarding', 1),
                  ('centralized_clustering', 1), ('_r15', 1)]
# рис. 9-554
EXT_SC_MCS = [('max_ext_sc_tx_mcs', 3), ('code_rate_7_8_tx', 1), ('max_ext_sc_rx_mcs', 3), ('code_rate_7_8_rx', 1)]
# табл. 9-252: значение подполя → имя MCS
EXT_SC_MCS_NAMES = {1: '9.1', 2: '12.1', 3: '12.2', 4: '12.3', 5: '12.4', 6: '12.5', 7: '12.6'}
# табл. 9-253 / 9-254: значение → максимум подкадров (0 — без ограничения)
MAX_BASIC_AMSDU = {0: None, 1: 4, 2: 8, 3: 16, 4: 32, 5: 64, 6: 128, 7: 256}
MAX_SHORT_AMSDU = {0: None, 1: 32, 2: 64, 3: 128, 4: 256, 5: 512, 6: 1024}
# табл. 9-251: Minimum MPDU Start Spacing → нс
MIN_MPDU_SPACING_NS = {0: 0, 1: 16, 2: 32, 3: 64, 4: 128, 5: 256, 6: 512, 7: 1024}
# табл. 20-15: MCS с кодовой скоростью 13/16 (базовые — из timing.SC_MCS, расширенные 12.1 и 12.5)
MCS_13_16 = {str(m) for m, (_, _, r) in SC_MCS.items() if r == Fr(13, 16)} | {'12.1', '12.5'}
DMG_CAP_LEN = 6 + 1 + 8 + 2 + 2 + 1 + 1 + 1   # рис. 9-549: 22 октета Information

DmgCapabilities = namedtuple('DmgCapabilities', 'sta_address aid sta_cap ap_pcp_cap beam_tracking_time_limit '
                                                'ext_sc_mcs max_basic_amsdu max_short_amsdu')
assert width(DMG_STA_CAP) == 64 and width(DMG_AP_PCP_CAP) == 16 and width(EXT_SC_MCS) == 8


def encode_dmg_capabilities(c):
    info = (mac_bytes(c.sta_address) + bytes([c.aid]) + le(pack(DMG_STA_CAP, c.sta_cap), 8)
            + le(pack(DMG_AP_PCP_CAP, c.ap_pcp_cap), 2) + le(c.beam_tracking_time_limit, 2)
            + bytes([pack(EXT_SC_MCS, c.ext_sc_mcs), c.max_basic_amsdu, c.max_short_amsdu]))
    assert len(info) == DMG_CAP_LEN
    return encode_element(EID_DMG_CAPABILITIES, info)


def parse_dmg_capabilities(info):
    b = known_info(info, DMG_CAP_LEN, 'DMG Capabilities')      # extensible: 10.28.8
    return DmgCapabilities(mac_str(b[0:6]), b[6], unpack(DMG_STA_CAP, int.from_bytes(b[7:15], 'little')),
                           unpack(DMG_AP_PCP_CAP, int.from_bytes(b[15:17], 'little')),
                           int.from_bytes(b[17:19], 'little'), unpack(EXT_SC_MCS, b[19]), b[20], b[21])


# ---- производные величины (9.4.2.127.2) ----
def rx_dmg_antennas(sc):
    """«total number of receive DMG antennas of the STA minus 1»."""
    return sc['num_rx_dmg_antennas'] + 1


def total_sectors(sc):
    """«total number of transmit sectors … minus 1»."""
    return sc['total_num_sectors'] + 1


def rxss_sectors(sc):
    """«(RXSS Length+1)×2, which ranges from 2 to 128»."""
    return (sc['rxss_length'] + 1) * 2


def max_ampdu_length(sc):
    """Табл. 9-251: 2^(13 + exp) − 1 октетов, exp 0…5."""
    return 2 ** (13 + sc['max_ampdu_len_exp']) - 1


def heartbeat_elapsed_ms(f_he):
    """9.4.2.127.2: T_HE = 0 при F_HE = 0, иначе 2^F_HE / 4 мс."""
    return Fr(0) if f_he == 0 else Fr(2 ** f_he, 4)


def supported_sc_mcs(sc, ext, direction):
    """Множество SC MCS (Clause 20) из Supported MCS Set + Extended SC MCS (9.4.2.127.2, 9.4.2.127.5).
    direction 'rx' / 'tx'. Базовые: 1…Maximum SC MCS (подполе — максимальный индекс), без MCS с кодовой скоростью
    13/16, если Code Rate 13/16 = 0. Расширенные: значения табл. 9-252 ≤ k; 9.1 и 12.2 — только при Code Rate 7/8."""
    mx = sc['max_sc_rx_mcs' if direction == 'rx' else 'max_sc_tx_mcs']
    s = {str(m) for m in range(1, min(mx, 12) + 1)}
    k = ext['max_ext_sc_rx_mcs' if direction == 'rx' else 'max_ext_sc_tx_mcs']
    s |= {EXT_SC_MCS_NAMES[v] for v in range(1, k + 1)}
    if not sc['code_rate_13_16']:
        # «MCS with 13/16 code rate specified in Table 20-15 is not supported regardless of the value in Maximum
        # SC Tx/Rx MCS subfields». СПОРНО: относится ли запрет к расширенным 12.1 и 12.5 (в табл. 20-15 они тоже
        # 13/16, но их поддержку задаёт Extended SC MCS Capabilities). Принято буквально: исключаются все MCS
        # табл. 20-15 со скоростью 13/16. Другое прочтение: только базовые 5 и 9.
        s -= MCS_13_16
    if not ext['code_rate_7_8_rx' if direction == 'rx' else 'code_rate_7_8_tx']:
        # 9.4.2.127.5 называет только 9.1 и 12.2. СПОРНО: 12.6 тоже имеет скорость 7/8 (табл. 20-15), но текст его
        # не исключает; принято буквально (12.6 остаётся). Другое прочтение: исключить и 12.6.
        s -= {'9.1', '12.2'}
    return s


def validate_dmg_capabilities(c, frame=None, role=None):
    v = []
    sc, ap, ext = (unpack(L, pack(L, d)) for L, d in ((DMG_STA_CAP, c.sta_cap), (DMG_AP_PCP_CAP, c.ap_pcp_cap),
                                                      (EXT_SC_MCS, c.ext_sc_mcs)))
    v += reserved_nonzero(DMG_STA_CAP, sc, 'DMG STA Capability Information')
    v += reserved_nonzero(EXT_SC_MCS, ext, 'Extended SC MCS Capabilities')
    # 9.4.2.127.1: «The AID field is reserved in Association Request, Reassociation Request and Probe Request
    # frames and when used in an IBSS»
    if (frame in (ASSOC_REQ, REASSOC_REQ, PROBE_REQ) or role == ROLE_IBSS) and c.aid:
        v.append(f'DMG Capabilities: AID = {c.aid} в {frame or role}, где поле зарезервировано (9.4.2.127.1)')
    for d in ('rx', 'tx'):
        m = sc[f'max_sc_{d}_mcs']
        # «Values 0-3 of this subfield are reserved. Possible values … are shown in Table 20-15» (MCS 1…12)
        if m <= 3 or m > 12:
            v.append(f'Maximum SC {d.upper()} MCS = {m}: допустимо 4…12 (9.4.2.127.2, табл. 20-15)')
        # 9.4.2.127.5: поддержка расширенных MCS выше 9.1 → Maximum SC MCS = 12
        if ext[f'max_ext_sc_{d}_mcs'] >= 2 and m != 12:
            v.append(f'Maximum Extended SC {d.upper()} MCS > 9.1 при Maximum SC {d.upper()} MCS = {m} ≠ 12 '
                     '(9.4.2.127.5)')
    if sc['max_ampdu_len_exp'] > 5:
        v.append('Maximum A-MPDU Length Exponent > 5 (табл. 9-251)')
    if c.max_basic_amsdu not in MAX_BASIC_AMSDU:
        v.append(f'Maximum Number Of Basic A-MSDU Subframes = {c.max_basic_amsdu} зарезервировано (табл. 9-253)')
    if c.max_short_amsdu not in MAX_SHORT_AMSDU:
        v.append(f'Maximum Number Of Short A-MSDU Subframes = {c.max_short_amsdu} зарезервировано (табл. 9-254)')
    # 9.4.2.127.3: Pseudo-static = 1 только при TDDTI = 1; при TDDTI = 0 — зарезервировано (= 0, 9.2.2)
    if ap['pseudo_static'] and not ap['tddti']:
        v.append('DMG AP Or PCP Capability: Pseudo-static Allocations = 1 при TDDTI = 0 (9.4.2.127.3)')
    v += reserved_nonzero(DMG_AP_PCP_CAP, ap, 'DMG AP Or PCP Capability Information')
    return v


# =====================================================================================================
# 9.4.2.128 DMG Operation (рис. 9-555…9-557)
# =====================================================================================================
DMG_OP_INFO = [('tddti', 1), ('pseudo_static', 1), ('pcp_handover', 1), ('_r3', 13)]
# рис. 9-557: (имя, октеты); единицы: интервалы маяка / мкс / 50 мс / мкс / мкс / число
DMG_BSS_PARAM_CFG = [('ps_request_suspension_interval', 1), ('min_bhi_duration', 2),
                     ('broadcast_sta_info_duration', 1), ('assoc_resp_confirm_time', 1), ('min_pp_duration', 1),
                     ('sp_idle_timeout', 1), ('max_lost_beacons', 1)]
DMG_OP_LEN = 2 + 8
# AssocRespConfirmTime «in units of 50 milliseconds» (9.4.2.128) — timing.ASSOC_RESP_CONFIRM_UNIT


def encode_dmg_operation(info, cfg):
    b = le(pack(DMG_OP_INFO, info), 2)
    unknown = set(cfg) - {n for n, _ in DMG_BSS_PARAM_CFG}
    if unknown:
        raise KeyError(f'неизвестные поля {sorted(unknown)}')
    for n, w in DMG_BSS_PARAM_CFG:
        b += le(cfg.get(n, 0), w)
    return encode_element(EID_DMG_OPERATION, b)


def parse_dmg_operation(info):
    b = known_info(info, DMG_OP_LEN, 'DMG Operation')
    op = unpack(DMG_OP_INFO, int.from_bytes(b[:2], 'little'))
    cfg, i = {}, 2
    for n, w in DMG_BSS_PARAM_CFG:
        cfg[n] = int.from_bytes(b[i:i + w], 'little')
        i += w
    return op, cfg


def assoc_resp_confirm_time_us(cfg):
    return cfg['assoc_resp_confirm_time'] * ASSOC_RESP_CONFIRM_UNIT


def validate_dmg_operation(op, cfg):
    op = unpack(DMG_OP_INFO, pack(DMG_OP_INFO, op))
    v = reserved_nonzero(DMG_OP_INFO, op, 'DMG Operation Information')
    # 9.4.2.128: «set to 1 only if the TDDTI subfield … is 1»
    if op['pseudo_static'] and not op['tddti']:
        v.append('DMG Operation: Pseudo-static allocations = 1 при TDDTI = 0 (9.4.2.128)')
    return v


# =====================================================================================================
# 9.4.2.131 Extended Schedule (рис. 9-562…9-564, табл. 9-257)
# =====================================================================================================
ALLOC_CTRL = [('allocation_id', 4), ('allocation_type', 3), ('pseudo_static', 1), ('truncatable', 1),
              ('extendable', 1), ('pcp_active', 1), ('lp_sc_used', 1), ('_r12', 4)]
# табл. 9-257: биты 4–6 как число (B4 — младший): ALLOC_SP/ALLOC_CBAP/… — timing.py
ALLOC_IS_SP = {ALLOC_SP: True, ALLOC_SP_1G08: True, ALLOC_CBAP: False, ALLOC_CBAP_1G08: False}
ALLOCATION_LEN = 15                                  # рис. 9-563
ALLOCS_PER_ELEMENT = ELEMENT_MAX_INFO // ALLOCATION_LEN   # 255 // 15 = 17
SP_BLOCK_MAX, CBAP_BLOCK_MAX = 32767, 65535          # 9.4.2.131: Allocation Block Duration
# TSF_LOW_MOD (9.4.2.131: Allocation Start — младшие 4 октета TSF) — timing.py

Allocation = namedtuple('Allocation', 'ctrl bf_control src_aid dst_aid start block_duration num_blocks '
                                      'block_period')
assert width(ALLOC_CTRL) == 16


def encode_allocation(a):
    """Рис. 9-563: Allocation Control 2, BF Control 2, Source AID 1, Destination AID 1, Allocation Start 4,
    Allocation Block Duration 2, Number of Blocks 1, Allocation Block Period 2 = 15 октетов."""
    return (le(pack(ALLOC_CTRL, a.ctrl), 2) + le(a.bf_control, 2) + bytes([a.src_aid, a.dst_aid])
            + le(a.start, 4) + le(a.block_duration, 2) + bytes([a.num_blocks]) + le(a.block_period, 2))


def parse_allocation(b):
    if len(b) != ALLOCATION_LEN:
        raise ValueError('Allocation — 15 октетов (рис. 9-563)')
    return Allocation(unpack(ALLOC_CTRL, int.from_bytes(b[0:2], 'little')), int.from_bytes(b[2:4], 'little'),
                      b[4], b[5], int.from_bytes(b[6:10], 'little'), int.from_bytes(b[10:12], 'little'), b[12],
                      int.from_bytes(b[13:15], 'little'))


def encode_extended_schedule(allocs):
    """Список Allocation → один или несколько элементов Extended Schedule подряд (9.4.2.131: «can split the
    Allocation fields into more than one Extended Schedule element»): не более 17 полей по 15 октетов."""
    allocs = list(allocs)
    if not allocs:
        raise ValueError('Allocation List — «one or more (n) Allocation fields» (9.4.2.131)')
    out = b''
    for i in range(0, len(allocs), ALLOCS_PER_ELEMENT):
        out += encode_element(EID_EXTENDED_SCHEDULE,
                              b''.join(encode_allocation(a) for a in allocs[i:i + ALLOCS_PER_ELEMENT]))
    return out


def parse_extended_schedule(infos):
    """Информация одного или нескольких элементов (bytes или список) → единый список Allocation
    («considered to be a single schedule for the beacon interval»)."""
    if isinstance(infos, (bytes, bytearray)):
        infos = [infos]
    out = []
    for info in infos:
        # СПОРНО: элемент Extensible (табл. 9-92), но длина — n × 15; остаток < 15 октетов трактуем как
        # расширение (10.28.8: отбросить), а не как ошибку. Другое прочтение: ошибка формата.
        n = len(info) // ALLOCATION_LEN
        if n == 0:
            raise ValueError('Extended Schedule без Allocation')
        out += [parse_allocation(info[i * 15:(i + 1) * 15]) for i in range(n)]
    return out


def validate_extended_schedule(allocs, role=ROLE_AP):
    """Проверка расписания одного BI. role — роль передающей STA (AP или PCP)."""
    v = []
    seen = {}
    prev = None
    for k, a in enumerate(allocs):
        c = unpack(ALLOC_CTRL, pack(ALLOC_CTRL, a.ctrl))
        w = f'Allocation[{k}]'
        v += reserved_nonzero(ALLOC_CTRL, c, w)
        t = c['allocation_type']
        if t not in ALLOC_IS_SP:
            v.append(f'{w}: AllocationType = {t} зарезервирован (табл. 9-257)')
            continue
        sp = ALLOC_IS_SP[t]
        bcast_cbap = not sp and a.src_aid == AID_BROADCAST and a.dst_aid == AID_BROADCAST
        # 9.4.2.131: CBAP с широковещательными Source и Destination AID — Allocation ID = 0
        if bcast_cbap and c['allocation_id'] != 0:
            v.append(f'{w}: широковещательный CBAP с Allocation ID = {c["allocation_id"]} ≠ 0 (9.4.2.131)')
        if not bcast_cbap:
            key = (a.src_aid, a.dst_aid, c['allocation_id'])
            # «the tuple (Source AID, Destination AID, Allocation ID) uniquely identifies the allocation»
            if key in seen:
                v.append(f'{w}: кортеж (Source AID, Destination AID, Allocation ID) = {key} повторяет '
                         f'Allocation[{seen[key]}] (9.4.2.131)')
            seen.setdefault(key, k)
        # Source AID = broadcast допускается для CBAP; для SP — только вместе с broadcast Destination AID
        # («If both Source AID and Destination AID subfields for an SP allocation are set to the broadcast AID»)
        if sp and a.src_aid == AID_BROADCAST and a.dst_aid != AID_BROADCAST:
            v.append(f'{w}: SP с широковещательным Source AID и индивидуальным Destination AID (9.4.2.131)')
        mx = SP_BLOCK_MAX if sp else CBAP_BLOCK_MAX
        if not 1 <= a.block_duration <= mx:
            v.append(f'{w}: Allocation Block Duration = {a.block_duration} вне 1…{mx} (9.4.2.131)')
        if not sp and (c['truncatable'] or c['extendable']):
            v.append(f'{w}: Truncatable/Extendable зарезервированы для CBAP (9.4.2.131, 9.2.2)')
        if a.num_blocks == 1 and a.block_period:
            v.append(f'{w}: Allocation Block Period зарезервирован при Number of Blocks = 1 (9.4.2.131, 9.2.2)')
        # PCP Active: «set to 1 at least» — источник/получатель (AID 0 = AP/PCP, 9.4.1.8), Truncatable или
        # Extendable = 1, передаёт AP
        need = []
        if role == ROLE_AP:
            need.append('передаёт AP')
        if role in (ROLE_AP, ROLE_PCP):
            if AID_AP_PCP in (a.src_aid, a.dst_aid):
                need.append('PCP — источник или получатель')
            if c['truncatable'] or c['extendable']:
                need.append('Truncatable или Extendable = 1')
        if need and not c['pcp_active']:
            v.append(f'{w}: PCP Active = 0, хотя {", ".join(need)} (9.4.2.131)')
        # «ordered by increasing allocation start time».
        # СПОРНО: Allocation Start — младшие 4 октета TSF и может перейти через 2^32 внутри BI; сравниваем по
        # модулю 2^32 (разность < 2^31 — «не раньше»). Другое прочтение: простое сравнение чисел.
        if prev is not None and (a.start - prev) % TSF_LOW_MOD >= TSF_LOW_MOD // 2:
            v.append(f'{w}: Allocation Start {a.start} раньше предыдущего {prev} (9.4.2.131)')
        prev = a.start
    return v


def allocation_blocks(a):
    """Моменты (младшие 32 бита TSF, мкс) начала и конца каждого блока: start + i·period … + duration."""
    return [((a.start + i * a.block_period) % TSF_LOW_MOD,
             (a.start + i * a.block_period + a.block_duration) % TSF_LOW_MOD) for i in range(a.num_blocks)]


# =====================================================================================================
# 9.4.2.135 Next DMG ATI (рис. 9-574)
# =====================================================================================================
def encode_next_dmg_ati(start_time, ati_duration):
    """Start Time — младшие 4 октета TSF самого раннего начала следующего ATI; ATI Duration — мкс."""
    return encode_element(EID_NEXT_DMG_ATI, le(start_time, 4) + le(ati_duration, 2))


def parse_next_dmg_ati(info):
    b = known_info(info, 6, 'Next DMG ATI')
    return int.from_bytes(b[:4], 'little'), int.from_bytes(b[4:6], 'little')


# =====================================================================================================
# 9.3.3 Тела кадров управления
# =====================================================================================================
PROBE_REQ, PROBE_RESP = 'Probe Request', 'Probe Response'
ASSOC_REQ, ASSOC_RESP = 'Association Request', 'Association Response'
REASSOC_REQ, REASSOC_RESP = 'Reassociation Request', 'Reassociation Response'
AUTH, DEAUTH, DISASSOC = 'Authentication', 'Deauthentication', 'Disassociation'

# Поля фиксированной части (до первого элемента), октеты
FIXED = {
    PROBE_REQ: [],                                                                   # табл. 9-38
    PROBE_RESP: [('timestamp', 8), ('beacon_interval', 2), ('capability', 2)],       # табл. 9-39, 1–3
    ASSOC_REQ: [('capability', 2), ('listen_interval', 2)],                          # табл. 9-34, 1–2
    ASSOC_RESP: [('capability', 2), ('status', 2), ('aid', 2)],                      # табл. 9-35, 1–3
    REASSOC_REQ: [('capability', 2), ('listen_interval', 2), ('current_ap', 6)],     # табл. 9-36, 1–3
    REASSOC_RESP: [('capability', 2), ('status', 2), ('aid', 2)],                    # табл. 9-37, 1–3
    # табл. 9-40, 1–3: Status code присутствует всегда, в части кадров зарезервирован (табл. 9-41)
    AUTH: [('algorithm', 2), ('seq', 2), ('status', 2)],
    DEAUTH: [('reason', 2)],                                                         # табл. 9-42
    DISASSOC: [('reason', 2)],                                                       # табл. 9-33
}
LAST = 1000         # «Last»; «Last – 1» = LAST − 1


def _seq(start, names):
    return [(start + i, n) for i, n in enumerate(names)]


# Порядок элементов: (номер Order из таблицы, название строки). Начинается с первой строки-элемента.
ORDER = {
    ASSOC_REQ: _seq(3, [   # табл. 9-34
        'SSID', 'Supported Rates and BSSMembership Selectors',
        'Extended Supported Rates and BSS Membership Selectors', 'Power Capability', 'Supported Channels', 'RSN',
        'QoS Capability', 'RM Enabled Capabilities', 'Mobility Domain', 'Supported Operating Classes',
        'HT Capabilities', '20/40 BSS Coexistence', 'Extended Capabilities', 'QoS Traffic Capability',
        'TIM Broadcast Request', 'Interworking', 'Multi-band', 'DMG Capabilities', 'Multiple MAC Sublayers',
        'VHT Capabilities', 'Operating Mode Notification', 'FILS Session', 'FILS Public Key',
        'FILS Key Confirmation', 'FILS HLP Container', 'FILS IP Address Assignment', 'TWT', 'AID Request',
        'S1G Capabilities', 'EL Operation', 'S1G Relay', 'BSS Max Idle Period', 'Header Compression', 'MAD',
        'Reachable Address', 'S1G Relay Activation', 'CDMG Capabilities', 'CMMG Capabilities',
        'GLK-GCR Parameter Set', 'Fast BSS Transition', 'RSN Extension', 'Supplemental Class 2 Capabilities',
        'MSCS Descriptor']) + [(LAST, 'Vendor Specific')],
    ASSOC_RESP: _seq(4, [  # табл. 9-35
        'Supported Rates and BSSMembership Selectors', 'Extended Supported Rates and BSS Membership Selectors',
        'EDCA Parameter Set', 'RCPI', 'RSNI', 'RM Enabled Capabilities', 'RSN', 'Mobility Domain',
        'Fast BSS Transition', 'DSE registered location', 'Timeout Interval (Association Comeback time)',
        'HT Capabilities', 'HT Operation', '20/40 BSS Coexistence', 'Overlapping BSS Scan Parameters',
        'Extended Capabilities', 'BSS Max Idle Period', 'TIM Broadcast Response', 'QoS Map', 'QMF Policy',
        'Multi-band', 'DMG Capabilities', 'DMG Operation', 'Multiple MAC Sublayers', 'Neighbor Report',
        'VHT Capabilities', 'VHT Operation', 'Operating Mode Notification', 'Future Channel Guidance',
        'FILS Session', 'FILS Public Key', 'FILS Key Confirmation', 'FILS HLP Container',
        'FILS IP Address Assignment', 'Key Delivery', 'S1G Sector Operation', 'TWT', 'TSF Timer Accuracy',
        'S1G Capabilities', 'S1G Operation', 'AID Response', 'Sectorized Group ID List', 'S1G Relay',
        'Header Compression', 'SST Operation', 'MAD', 'S1G Relay Activation', 'CDMG Capabilities',
        'CMMG Capabilities', 'CMMG Operation', 'GLK-GCR Parameter Set', 'RSN Extension', 'MSCS Descriptor'])
        + [(LAST, 'Vendor Specific')],
    REASSOC_REQ: _seq(4, [  # табл. 9-36
        'SSID', 'Supported Rates and BSSMembership Selectors',
        'Extended Supported Rates and BSS Membership Selectors', 'Power Capability', 'Supported Channels', 'RSN',
        'QoS Capability', 'RM Enabled Capabilities', 'Mobility Domain', 'Fast BSS Transition',
        'Resource information container (RIC)', 'Supported Operating Classes', 'HT Capabilities',
        '20/40 BSS Coexistence', 'Extended Capabilities', 'QoS Traffic Capability', 'TIM Broadcast Request',
        'FMS Request', 'DMS Request', 'Interworking', 'Multi-band', 'DMG Capabilities', 'Multiple MAC Sublayers',
        'VHT Capabilities', 'Operating Mode Notification', 'FILS Session', 'FILS Public Key',
        'FILS Key Confirmation', 'FILS HLP Container', 'FILS IP Address Assignment', 'TWT', 'AID Request',
        'S1G Capabilities', 'EL Operation', 'BSS Max Idle Period', 'S1G Relay', 'Header Compression', 'MAD',
        'Reachable Address', 'S1G Relay Activation element', 'CDMG Capabilities', 'CMMG Capabilities', 'OCI',
        'GLK-GCR Parameter Set', 'RSN Extension', 'Supplemental Class 2 Capabilities', 'MSCS Descriptor'])
        + [(LAST, 'Vendor Specific')],
    REASSOC_RESP: _seq(4, [  # табл. 9-37
        'Supported Rates and BSSMembership Selectors', 'Extended Supported Rates and BSS Membership Selectors',
        'EDCA Parameter Set', 'RCPI', 'RSNI', 'RM Enabled Capabilities', 'RSN', 'Mobility Domain',
        'Fast BSS Transition', 'RIC', 'DSE registered location', 'Timeout Interval (Association Comeback time)',
        'HT Capabilities', 'HT Operation', '20/40 BSS Coexistence', 'Overlapping BSS Scan Parameters',
        'Extended Capabilities', 'BSS Max Idle Period', 'TIM Broadcast Response', 'FMS Response', 'DMS Response',
        'QoS Map', 'QMF Policy', 'Multi-band', 'DMG Capabilities', 'DMG Operation', 'Multiple MAC Sublayers',
        'Neighbor Report', 'VHT Capabilities', 'VHT Operation', 'Operating Mode Notification',
        'Future Channel Guidance', 'FILS Session', 'FILS Public Key', 'FILS Key Confirmation',
        'FILS HLP Container', 'FILS IP Address Assignment', 'Key Delivery', 'S1G Sector Operation', 'TWT',
        'TSF Timer Accuracy', 'S1G Capabilities', 'S1G Operation', 'AID Response', 'Sectorized Group ID List',
        'S1G Relay', 'Header Compression', 'SST Operation', 'MAD', 'S1G Relay Activation', 'CDMG Capabilities',
        'CMMG Capabilities', 'CMMG Operation', 'OCI', 'GLK-GCR Parameter Set', 'RSN Extension',
        'MSCS Descriptor']) + [(LAST, 'Vendor Specific')],
    PROBE_REQ: _seq(1, [  # табл. 9-38
        'SSID', 'Supported Rates and BSSMembership Selectors', 'Request',
        'Extended Supported Rates and BSS Membership Selectors', 'DSSS Parameter Set',
        'Supported Operating Classes', 'HT Capabilities', '20/40 BSS Coexistence', 'Extended Capabilities',
        'SSID List', 'Channel Usage', 'Interworking', 'Mesh ID', 'Multi-band', 'DMG Capabilities',
        'Multiple MAC Sublayers', 'VHT Capabilities', 'Estimated Service Parameters Inbound', 'Extended Request',
        'FILS Request Parameters', 'AP-CSN', 'Change Sequence', 'S1G Relay Discovery',
        'PV1 Probe Response Option', 'S1G Capabilities', 'EL Operation', 'MAD', 'Vendor Specific Request',
        'CDMG Capabilities', 'Cluster Probe', 'CMMG Capabilities', 'Estimated Service Parameters Outbound',
        'Supplemental Class 2 Capabilities']) + [(LAST, 'Vendor Specific')],
    PROBE_RESP: _seq(4, [  # табл. 9-39
        'SSID', 'Supported Rates and BSSMembership Selectors', 'DSSS Parameter Set', 'IBSS Parameter Set',
        'Country', 'Power Constraint', 'Channel Switch Announcement', 'Quiet', 'IBSS DFS', 'TPC Report', 'ERP',
        'Extended Supported Rates and BSS Membership Selectors', 'RSN', 'BSS Load', 'EDCA Parameter Set',
        'Measurement Pilot Transmission', 'Multiple BSSID', 'RM Enabled Capabilities', 'AP Channel Report',
        'BSS Average Access Delay', 'Antenna', 'BSS Available AdmissionCapacity', 'BSS AC Access Delay',
        'Mobility Domain', 'DSE registered location', 'Extended Channel Switch Announcement',
        'Supported Operating Classes', 'HT Capabilities', 'HT Operation', '20/40 BSS Coexistence',
        'Overlapping BSS Scan Parameters', 'Extended Capabilities', 'QoS Traffic Capability', 'Channel Usage',
        'Time Advertisement', 'Time Zone', 'Interworking', 'Advertisement Protocol', 'Roaming Consortium',
        'Emergency Alert Identifier', 'Mesh ID', 'Mesh Configuration', 'Mesh Awake Window', 'Beacon Timing',
        'MCCAOP Advertisement Overview', 'MCCAOP Advertisement', 'Mesh Channel Switch Parameters', 'QMF Policy',
        'QLoad Report', 'Multi-band', 'DMG Capabilities', 'DMG Operation', 'Multiple MAC Sublayers',
        'Antenna Sector ID Pattern', 'VHT Capabilities', 'VHT Operation', 'Transmit Power Envelope element',
        'Channel Switch Wrapper element', 'Extended BSS Load element', 'Quiet Channel',
        'Operating Mode Notification', 'Reduced Neighbor Report', 'TVHT Operation',
        'Estimated Service Parameters Inbound', 'Relay Capabilities', 'CAG Number', 'FILS Indication', 'AP-CSN',
        'DILS', 'RPS', 'Page Slice', 'Change Sequence', 'TSF Timer Accuracy', 'S1G Relay Discovery',
        'S1G Capabilities', 'S1G Operation', 'MAD', 'Short Beacon Interval', 'S1G Open-Loop Link Margin Index',
        'S1G Relay', 'Max Channel Switch Time', 'CDMG Capabilities', 'Extended Cluster Report',
        'CMMG Capabilities', 'CMMG Operation', 'Estimated Service Parameters Outbound', 'Service Hint',
        'Service Hash'])
        # СПОРНО → принято по 2024: в табл. 9-39 (2020) у Service Hash и RSN Extension один номер 91 — опечатка;
        # 802.11-2024 табл. 9-69 исправляет: 91 Service Hash, 92 RSN Extension (уточнение 2024 имеет приоритет).
        + [(92, 'RSN Extension'), (LAST - 1, 'Vendor Specific')],
    AUTH: _seq(10, [  # табл. 9-40, строки-элементы (4–9 — поля SAE, не элементы)
        'Challenge text', 'RSN', 'Mobility Domain', 'Fast BSS Transition',
        'Timeout Interval (reassociation deadline)', 'RIC', 'Multi-band', 'Neighbor Report', 'FILS Nonce',
        'FILS Session', 'FILS Wrapped Data', 'Association Delay Info', 'Password Identifier', 'Rejected Groups',
        'Anti-Clogging Token Container']) + [(LAST, 'Vendor Specific')],
    DEAUTH: [(LAST - 1, 'Vendor Specific'), (LAST, 'Management MIC')],       # табл. 9-42
    DISASSOC: [(LAST - 1, 'Vendor Specific'), (LAST, 'Management MIC')],     # табл. 9-33
}
# (eid, ext) → номер Order, по кадрам
ORDER_RANK = {f: {element_key(n): o for o, n in rows} for f, rows in ORDER.items()}
# Строки, допускающие несколько экземпляров: «One or more …» в примечаниях таблиц
MULTI = {element_key('Vendor Specific'), element_key('Neighbor Report'), element_key('FILS HLP Container'),
         element_key('RIC')}

# DMG STA (dot11DMGOptionImplemented = true)
# «This element is not present if dot11DMGOptionImplemented is true» (табл. 9-34…9-39);
# CSA в Probe Response — «optionally present for non-DMG STAs» (табл. 9-39, 10)
DMG_FORBIDDEN = {f: {(EID_SUPPORTED_RATES, None), (EID_EXT_SUPPORTED_RATES, None)}
                 for f in (ASSOC_REQ, ASSOC_RESP, REASSOC_REQ, REASSOC_RESP, PROBE_REQ, PROBE_RESP)}
DMG_FORBIDDEN[PROBE_RESP] = DMG_FORBIDDEN[PROBE_RESP] | {(EID_CSA, None)}
# «All fields and elements are mandatory unless stated otherwise» (9.3.3.1): SSID без условий;
# DMG Capabilities / DMG Operation — «present if dot11DMGOptionImplemented is true»
DMG_MANDATORY = {
    PROBE_REQ: [EID_SSID, EID_DMG_CAPABILITIES],
    PROBE_RESP: [EID_SSID, EID_DMG_CAPABILITIES, EID_DMG_OPERATION],
    ASSOC_REQ: [EID_SSID, EID_DMG_CAPABILITIES],
    REASSOC_REQ: [EID_SSID, EID_DMG_CAPABILITIES],
    ASSOC_RESP: [EID_DMG_CAPABILITIES, EID_DMG_OPERATION],
    REASSOC_RESP: [EID_DMG_CAPABILITIES, EID_DMG_OPERATION],
}


def encode_body(frame, fixed, elements=()):
    """Тело кадра: фиксированные поля (dict, int или bytes; capability — int, dict рис. 9-86 или bytes;
    current_ap — MAC) по порядку FIXED, затем элементы как есть (порядок не переставляется — проверяет
    check_body)."""
    out = b''
    unknown = set(fixed) - {n for n, _ in FIXED[frame]}
    if unknown:
        raise KeyError(f'{frame}: нет полей {sorted(unknown)}')
    for name, n in FIXED[frame]:
        x = fixed.get(name, 0)
        if name == 'capability' and isinstance(x, dict):
            out += encode_capinfo_dmg(x)
        elif name == 'current_ap':
            out += mac_bytes(x)
        elif isinstance(x, (bytes, bytearray)):
            if len(x) != n:
                raise ValueError(f'{name}: {len(x)} октетов вместо {n}')
            out += bytes(x)
        else:
            out += le(x, n)
    if frame == AUTH and fixed.get('algorithm', 0) not in (AUTH_OPEN_SYSTEM, AUTH_SHARED_KEY, AUTH_FT):
        raise NotImplementedError('Authentication SAE/FILS: поля после Status Code не моделируются')
    return out + encode_elements(elements)


def parse_body(frame, body):
    """Тело кадра → (dict фиксированных полей, [Element]). capability — dict рис. 9-86 (DMG STA)."""
    body = bytes(body)
    n = sum(w for _, w in FIXED[frame])
    if len(body) < n:
        raise ValueError(f'{frame}: тело {len(body)} октетов короче фиксированной части {n}')
    fx, i = {}, 0
    for name, w in FIXED[frame]:
        b = body[i:i + w]
        i += w
        if name == 'capability':
            fx[name] = parse_capinfo_dmg(b)
        elif name == 'current_ap':
            fx[name] = mac_str(b)
        else:
            fx[name] = int.from_bytes(b, 'little')
    if frame == AUTH and fx['algorithm'] not in (AUTH_OPEN_SYSTEM, AUTH_SHARED_KEY, AUTH_FT):
        raise NotImplementedError('Authentication SAE/FILS: поля после Status Code не моделируются')
    return fx, parse_elements(body[i:])


def element_name(eid, ext=None):
    return ELEMENT_INFO.get((eid, ext), (f'reserved {eid}/{ext}',))[0]


def check_order(frame, elements, requested=None):
    """Порядок элементов по таблице кадра (9.3.3.1: «Fields and elements appear in the specified, relative order,
    skipping fields or elements that are not present»), допустимость, повторы. Только для передаваемых кадров:
    приёмник неизвестные элементы игнорирует (10.28.6).
    requested — для Probe Response: множество (eid, ext), запрошенных Request/Extended Request (табл. 9-39,
    «Last: Requested elements»); None — запрос неизвестен: хвост начинается с первого элемента, которого нет
    в табл. 9-39 (элементы из таблицы на своих местах проверяются как обычно)."""
    v = []
    rank = ORDER_RANK[frame]
    cur, cur_name = -1, None
    count = {}
    tail = False        # зона «Requested elements» Probe Response
    for k, el in enumerate(elements):
        key = (el.eid, el.ext)
        name = element_name(*key)
        r = rank.get(key)
        if frame == PROBE_RESP and not tail and \
                (r is None if requested is None else (key in requested and (r is None or r < cur))):
            tail = True     # «Last»: запрошенные элементы идут после всех прочих, включая Vendor Specific
        if tail:
            if requested is not None and key not in requested:
                v.append(f'{frame}: [{k}] {name} после Requested elements — не запрошен (табл. 9-39)')
            continue
        if r is None:
            v.append(f'{frame}: [{k}] {name} не предусмотрен таблицей тела кадра (9.3.3)')
            continue
        if r < cur:
            v.append(f'{frame}: [{k}] {name} (Order {r}) после {cur_name} (Order {cur}) — нарушен порядок (9.3.3.1)')
        else:
            cur, cur_name = r, name
        count[key] = count.get(key, 0) + 1
        # СПОРНО: таблицы не запрещают повтор явно, но называют элемент в единственном числе, а «One or more» —
        # только у отдельных строк (MULTI). Повтор прочих считаем нарушением.
        if count[key] == 2 and key not in MULTI:
            v.append(f'{frame}: {name} повторяется (табл. 9.3.3: один экземпляр)')
    return v


def check_body(frame, body, role, dmg=True, requested=None, pmf=False, rsna=None):
    """Полная проверка тела передаваемого кадра DMG STA. role — роль передающей STA (ROLE_*).
    pmf/rsna — dot11RSNAProtectedManagementFramesActivated / dot11RSNAActivated (для TIE и DMG Privacy;
    rsna=None — не проверять). Возвращает список нарушений."""
    fx, els = parse_body(frame, body) if isinstance(body, (bytes, bytearray)) else body
    v = check_order(frame, els, requested)
    keys = [(e.eid, e.ext) for e in els]
    dmgcap = None
    for e in els:
        try:
            if e.eid == EID_DMG_CAPABILITIES:
                dmgcap = parse_dmg_capabilities(e.info)
                v += validate_dmg_capabilities(dmgcap, frame, role)
            elif e.eid == EID_DMG_OPERATION:
                v += validate_dmg_operation(*parse_dmg_operation(e.info))
            elif e.eid == EID_SSID:
                parse_ssid(e.info)
            elif e.eid == EID_TIMEOUT_INTERVAL:
                parse_tie(e.info)
            elif e.eid == EID_RSN:
                parse_rsne(e.info)
        except ValueError as ex:
            v.append(f'{frame}: {element_name(e.eid, e.ext)}: {ex}')
    if dmg and frame in DMG_FORBIDDEN:
        for key in DMG_FORBIDDEN[frame] & set(keys):
            v.append(f'{frame}: {element_name(*key)} не передаётся DMG STA (табл. 9.3.3, «not present if '
                     'dot11DMGOptionImplemented is true»)')
    if dmg and frame in DMG_MANDATORY:
        for eid in DMG_MANDATORY[frame]:
            if (eid, None) not in keys:
                v.append(f'{frame}: нет обязательного элемента {element_name(eid)} (9.3.3)')
    if 'capability' in fx and dmg:
        rd = dmgcap.sta_cap['reverse_direction'] if dmgcap else None
        v += validate_capinfo_dmg(fx['capability'], frame, role, rd)
        # 9.4.1.46: «The DMG Privacy subfield is set to 1 if dot11RSNAActivated is true»
        if rsna is not None and fx['capability']['dmg_params']['dmg_privacy'] != int(bool(rsna)):
            v.append(f'{frame}: DMG Privacy ≠ dot11RSNAActivated (9.4.1.46)')
        # табл. 9-34/9-36: «The RSNE is present if dot11RSNAActivated is true»
        if rsna is not None and frame in (ASSOC_REQ, REASSOC_REQ) and ((EID_RSN, None) in keys) != bool(rsna):
            v.append(f'{frame}: наличие RSNE ≠ dot11RSNAActivated (табл. 9-34/9-36)')
    if frame in (ASSOC_RESP, REASSOC_RESP):
        v += _check_assoc_resp(frame, fx, keys, els, dmg, rsna, pmf)
    if frame == AUTH:
        v += _check_auth(fx, keys)
    if frame in (DEAUTH, DISASSOC) and fx['reason'] == REASON_RESERVED:
        v.append(f'{frame}: Reason Code 0 зарезервирован (табл. 9-49)')
    return v


def _check_assoc_resp(frame, fx, keys, els, dmg, rsna, pmf):
    v = []
    st = fx['status']
    # 9.4.1.8: DMG AID 1…254, 8 старших бит зарезервированы. СПОРНО: при отказе AID не назначается и поле
    # не проверяется (текст о значении AID при Status ≠ SUCCESS молчит).
    if dmg and st == SUCCESS and not AID_DMG_MIN <= fx['aid'] <= AID_DMG_MAX:
        v.append(f'{frame}: AID = {fx["aid"]} вне 1…254 для DMG STA (9.4.1.8)')
    # табл. 9-35 (14) / 9-37 (15): TIE с Association Comeback time — при RSNA, PMF и REFUSED_TEMPORARILY
    # (вариант «status 0 … dot11S1GOptionImplemented» к DMG не относится)
    tie = [e for e in els if e.eid == EID_TIMEOUT_INTERVAL]
    need_tie = bool(rsna) and pmf and st == REFUSED_TEMPORARILY
    if need_tie and not tie:
        v.append(f'{frame}: нет TIE (Association Comeback time) при REFUSED_TEMPORARILY и PMF (табл. 9-35/9-37)')
    for e in tie:
        try:
            if parse_tie(e.info)[0] != TIE_ASSOC_COMEBACK:
                v.append(f'{frame}: TIE не типа Association Comeback time (табл. 9-35/9-37, табл. 9-182)')
        except ValueError:
            pass
    if (EID_NEIGHBOR_REPORT, None) in keys and st != REJECTED_WITH_SUGGESTED_BSS_TRANSITION:
        # «present if the StatusCode field is REJECTED_WITH_SUGGESTED_BSS_TRANSITION»
        v.append(f'{frame}: Neighbor Report при Status ≠ REJECTED_WITH_SUGGESTED_BSS_TRANSITION (табл. 9-35/9-37)')
    return v


def _check_auth(fx, keys):
    """Табл. 9-41 для Open System; Shared Key — Challenge Text в кадрах 2 и 3."""
    v = []
    alg, seq, st = fx['algorithm'], fx['seq'], fx['status']
    if alg == AUTH_OPEN_SYSTEM:
        if seq not in (1, 2):
            v.append(f'Authentication Open System: Transaction Sequence {seq} ∉ {{1, 2}} (табл. 9-41)')
        if seq == 1 and st:
            v.append('Authentication Open System 1: Status Code зарезервирован (= 0) (табл. 9-41, 9.2.2)')
        allowed = set()
        if seq == 2 and st == REJECTED_WITH_SUGGESTED_BSS_TRANSITION:
            allowed.add((EID_NEIGHBOR_REPORT, None))
            if (EID_NEIGHBOR_REPORT, None) not in keys:
                v.append('Authentication Open System 2: нет Neighbor Report при '
                         'REJECTED_WITH_SUGGESTED_BSS_TRANSITION (табл. 9-41)')
        # СПОРНО: табл. 9-41 — «Presence of fields and elements from order 4 onward: Not present», а табл. 9-40
        # разрешает Vendor Specific (Last) и Multi-band (16, «optionally present if dot11MultibandImplemented»)
        # в любом Authentication. Принято: Vendor Specific допустим (строка Last общая для всех кадров),
        # Multi-band — нет (табл. 9-41 конкретнее). Другое прочтение: допустимы оба / ни один.
        allowed.add((EID_VENDOR_SPECIFIC, None))
        for key in set(keys) - allowed:
            v.append(f'Authentication Open System {seq}: элемент {element_name(*key)} не допускается (табл. 9-41)')
    elif alg == AUTH_SHARED_KEY:
        has = (EID_CHALLENGE_TEXT, None) in keys
        if seq in (2, 3) and not has:
            v.append(f'Authentication Shared Key {seq}: нет Challenge Text (табл. 9-41)')
        if seq in (1, 4) and has:
            v.append(f'Authentication Shared Key {seq}: Challenge Text не допускается (табл. 9-41)')
        if seq in (1, 3) and st:
            v.append(f'Authentication Shared Key {seq}: Status Code зарезервирован (= 0) (табл. 9-41, 9.2.2)')
    return v
