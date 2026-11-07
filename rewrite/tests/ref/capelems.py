# SPDX-License-Identifier: AGPL-3.0-or-later
"""Элементы возможностей DMG STA по 802.11-2020: допустимые наборы RSNE для DMG (9.4.2.24.2 [p. 1052–1053],
табл. 9-149, 9-150, 9.4.2.24.3 [p. 1054], табл. 9-151, 9.4.2.24.4 [p. 1058–1059], 12.5.5.1 [p. 2504] «A DMG RSNA STA
shall support GCMP-128», выбор политики 12.6.3 [p. 2517–2519] и табл. 12-5 MFPC/MFPR), поле Extended Capabilities
целиком (9.4.2.26 [p. 1061], табл. 9-153: имена всех битов, резерв, биты, зарезервированные для DMG/не-AP), элемент
Supported Operating Classes (9.4.2.53 [p. 1119–1120], рис. 9-370…9-372) и классы 60 ГГц приложения E (табл. E-4
[p. 4117–4121]: глобальный класс 180 — каналы 1–6 по 2160 МГц; 181 — каналы 2, 3, табл. E-6).

Структура RSNE (кодирование, порядок полей) — elements.encode/parse_rsne; здесь — смысл наборов для DMG.
Не моделируется: 4-way handshake и второй RSNE сообщения 3 (12.6.3 — шифр пары «из второго RSNE»), PMKID, FT/FILS,
TSN (до-RSNA STA в DMG нет), Country-зависимые классы E-1…E-3 (номера классов 34/18/59 там — локальные, принимаются
только с явной таблицей)."""
from collections import namedtuple

from . import elements as E

# ===================================================================================================== RSNE (9.4.2.24)
OUI_IEEE = bytes([0x00, 0x0F, 0xAC])                       # 00-0F-AC (табл. 9-149, 9-151)
USE_GROUP, WEP40, TKIP, CCMP128, WEP104, BIP_CMAC128, NO_GROUP_TRAFFIC, GCMP128, GCMP256, CCMP256, \
    BIP_GMAC128, BIP_GMAC256, BIP_CMAC256 = 0, 1, 2, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13
CIPHER_NAME = {USE_GROUP: 'Use group cipher suite', WEP40: 'WEP-40', TKIP: 'TKIP', CCMP128: 'CCMP-128',
               WEP104: 'WEP-104', BIP_CMAC128: 'BIP-CMAC-128', NO_GROUP_TRAFFIC: 'Group addressed traffic not allowed',
               GCMP128: 'GCMP-128', GCMP256: 'GCMP-256', CCMP256: 'CCMP-256', BIP_GMAC128: 'BIP-GMAC-128',
               BIP_GMAC256: 'BIP-GMAC-256', BIP_CMAC256: 'BIP-CMAC-256'}
# табл. 9-150 «Cipher suite usage»: GTK / PTK / IGTK-BIGTK
CIPHER_GTK = {WEP40, WEP104, TKIP, CCMP128, GCMP128, GCMP256, CCMP256}
CIPHER_PTK = {USE_GROUP, TKIP, CCMP128, GCMP128, GCMP256, CCMP256}
CIPHER_IGTK = {BIP_CMAC128, BIP_GMAC128, BIP_GMAC256, BIP_CMAC256}
# табл. 9-151: AKM 1…20 определены, 0, 18 и 21–255 — Reserved
AKM_DEFINED = set(range(1, 21)) - {18}
AKM_PSK, AKM_8021X, AKM_SAE = 2, 1, 8
DMG_DEFAULT_CIPHER = GCMP128      # 9.4.2.24.2: «In DMG RSNA, the cipher suite selector 00-0F-AC:8 (GCMP-128) is the
#                                   default group cipher suite … default pairwise cipher suite» (при отсутствии поля)
MGMT_DEFAULT_CIPHER = BIP_CMAC128  # 9.4.2.24.2: при защите кадров управления без Group Management Cipher Suite
ROBUST_MANAGEMENT_POLICY_VIOLATION = 31     # табл. 9-50
# рис. 9-289: RSN Capabilities
RSN_CAP = [('preauth', 1), ('no_pairwise', 1), ('ptksa_replay', 2), ('gtksa_replay', 2), ('mfpr', 1), ('mfpc', 1),
           ('joint_multiband', 1), ('peerkey', 1), ('spp_amsdu_capable', 1), ('spp_amsdu_required', 1), ('pbac', 1),
           ('ext_key_id', 1), ('ocvc', 1), ('_r15', 1)]
assert E.width(RSN_CAP) == 16

Suite = namedtuple('Suite', 'oui type')
Rsn = namedtuple('Rsn', 'version group pairwise akm caps pmkids group_mgmt present')


def suite(b):
    b = bytes(b)
    return Suite(b[:3], b[3])


def sel(t, oui=OUI_IEEE):
    return bytes(oui) + bytes([t])


def _ieee(s):
    return s is not None and s.oui == OUI_IEEE


def rsn_effective(info, dmg=True):
    """Информация RSNE → Rsn с умолчаниями 9.4.2.24.2/9.4.2.24.4: отсутствующие Group Data / Pairwise — GCMP-128 у DMG
    (CCMP-128 у не-DMG), AKM — 00-0F-AC:1 (9.4.2.24.3: «default AKM … when the AKM Suite List field is not included»),
    9.4.2.24.4: RSN Capabilities — 0. present — какие поля были в элементе."""
    r = E.parse_rsne(info)
    d = DMG_DEFAULT_CIPHER if dmg else CCMP128
    present = frozenset(k for k in r if k != 'version')
    return Rsn(r['version'], suite(r['group_data']) if 'group_data' in r else Suite(OUI_IEEE, d),
               [suite(x) for x in r['pairwise']] if 'pairwise' in r else [Suite(OUI_IEEE, d)],
               [suite(x) for x in r['akm']] if 'akm' in r else [Suite(OUI_IEEE, AKM_8021X)],
               E.unpack(RSN_CAP, r.get('capabilities', 0)), r.get('pmkids', []),
               suite(r['group_mgmt']) if 'group_mgmt' in r else None, present)


def check_rsne(info, role=E.ROLE_AP, frame=None, dmg=True):
    """Нарушения одного RSNE передатчика. role — ROLE_AP/ROLE_PCP (объявляет политику) или ROLE_STA (в (Re)Association
    Request выбирает, 12.6.3); frame — имя кадра (elements)."""
    v = []
    try:
        raw = E.parse_rsne(info)
        r = rsn_effective(info, dmg)
    except ValueError as x:
        return [f'RSNE: {x}']
    if r.version != 1:
        v.append(f'RSNE Version = {r.version} (9.4.2.24.1: «Version 1 is defined … Other values are reserved»)')
    if 'pairwise' in raw and not raw['pairwise']:
        v.append('Pairwise Cipher Suite Count = 0 — зарезервировано (9.4.2.24.2)')
    if 'akm' in raw and not raw['akm']:
        v.append('AKM Suite Count = 0 — зарезервировано (9.4.2.24.3)')
    g = r.group
    if _ieee(g):
        if g.type not in CIPHER_NAME or g.type in (3,) or g.type >= 14:
            v.append(f'Group Data Cipher 00-0F-AC:{g.type} — Reserved (табл. 9-149)')
        elif g.type == USE_GROUP:
            v.append('Group Data Cipher «Use group cipher suite» — «valid only as the pairwise cipher suite» '
                     '(9.4.2.24.2)')
        elif g.type in CIPHER_IGTK:
            v.append(f'Group Data Cipher {CIPHER_NAME[g.type]} — BIP не шифр данных (9.4.2.24.2, табл. 9-150)')
        elif g.type in (WEP40, WEP104) and dmg:
            # СПОРНО → принято (PLAN.md №67): WEP — только групповой шифр TSN «to allow pre-RSNA STAs to join»;
            # DMG STA с RSNA — RSNA STA (DMG Privacy = dot11RSNAActivated, 9.4.1.46), до-RSNA DMG STA стандарт не
            # описывает — TSN в DMG BSS не бывает.
            v.append(f'Group Data Cipher {CIPHER_NAME[g.type]} в DMG BSS — WEP только для TSN с до-RSNA STA '
                     f'(9.4.2.24.2; PLAN.md №67)')
    pw = [s for s in r.pairwise if _ieee(s)]
    for s in pw:
        if s.type not in CIPHER_PTK and s.type in CIPHER_NAME:
            v.append(f'Pairwise Cipher {CIPHER_NAME[s.type]} — не шифр PTK (табл. 9-150)')
        elif s.type not in CIPHER_NAME or s.type == 3 or s.type >= 14:
            v.append(f'Pairwise Cipher 00-0F-AC:{s.type} — Reserved (табл. 9-149)')
    if any(s.type == USE_GROUP for s in pw):
        if len(r.pairwise) > 1:
            v.append('«Use group cipher suite» вместе с другими парными — «this is the only pairwise cipher selection» '
                     '(9.4.2.24.2)')
        if _ieee(g) and g.type not in (TKIP, WEP40, WEP104):
            v.append(f'«Use group cipher suite» при групповом {CIPHER_NAME.get(g.type, g.type)} — «not a valid '
                     f'option» (9.4.2.24.2)')
        if role == E.ROLE_STA:
            v.append('«Use group cipher suite» в RSNE non-AP STA — его указывает только AP (9.4.2.24.2)')
    if _ieee(g) and g.type not in (TKIP, WEP40, WEP104) and any(s.type == TKIP for s in pw) and len(pw) == 1:
        v.append(f'парный TKIP при групповом {CIPHER_NAME.get(g.type, g.type)} — «not supported» (9.4.2.24.2)')
    for s in r.akm:
        if _ieee(s) and s.type not in AKM_DEFINED:
            v.append(f'AKM 00-0F-AC:{s.type} — Reserved (табл. 9-151)')
    if r.group_mgmt is not None and _ieee(r.group_mgmt) and r.group_mgmt.type not in CIPHER_IGTK:
        v.append(f'Group Management Cipher 00-0F-AC:{r.group_mgmt.type} — не BIP (табл. 9-150, IGTK)')
    c = r.caps
    if c['_r15']:
        v.append('RSN Capabilities B15 Reserved = 1 (рис. 9-289)')
    if role == E.ROLE_STA and c['preauth']:
        v.append('Preauthentication = 1 у non-AP STA (9.4.2.24.4: «A non-AP STA sets the Preauthentication subfield '
                 'to 0»)')
    if role in (E.ROLE_AP, E.ROLE_PCP) and c['no_pairwise']:
        v.append('No Pairwise = 1 у AP/PCP (9.4.2.24.4: «IBSS STAs and APs set the No Pairwise subfield to 0»)')
    if c['no_pairwise'] and not (len(pw) == 1 and pw[0].type == TKIP):
        v.append('No Pairwise = 1 без парного TKIP (9.4.2.24.4: «set to 1 only in a TSN and when the pairwise cipher '
                 'suite selected by the STA is TKIP»)')
    if c['mfpr'] and not c['mfpc']:
        v.append('MFPR = 1 при MFPC = 0 — «invalid setting» (табл. 12-5)')
    if role == E.ROLE_STA and frame in (E.ASSOC_REQ, E.REASSOC_REQ):
        if len(r.pairwise) != 1:
            v.append(f'(Re)Association Request: парных шифров {len(r.pairwise)} — «shall include one … pairwise cipher '
                     f'suite» (12.6.3)')
        if len(r.akm) != 1:
            v.append(f'(Re)Association Request: AKM {len(r.akm)} — «shall include one authentication … suite» '
                     f'(12.6.3)')
    return v


def gcmp_supported_info(r):
    """12.5.5.1: «A DMG RSNA STA shall support GCMP-128» — поддержка не равна объявлению; судья пишет в info, если
    объявленные парные шифры без GCMP-128 (нарушением не считается)."""
    return any(_ieee(s) and s.type == GCMP128 for s in r.pairwise)


def check_selection(ap_info, sta_info, dmg=True):
    """12.6.3: RSNE (Re)Association Request STA против RSNE точки (Beacon/DMG Beacon/Probe Response): один парный шифр
    и один AKM из объявленных точкой, групповой — точки; табл. 12-5 — «The STA shall not associate» при несовместимых
    MFPC/MFPR. → [нарушения STA]."""
    a, s = rsn_effective(ap_info, dmg), rsn_effective(sta_info, dmg)
    v = []
    if s.group != a.group:
        v.append(f'групповой шифр STA {s.group.type} ≠ точки {a.group.type} (12.6.3: «shall also specify the group '
                 f'cipher suite specified by the targeted AP»)')
    if s.pairwise and s.pairwise[0] not in a.pairwise:
        v.append(f'парный шифр STA {s.pairwise[0].type} не из объявленных точкой {[x.type for x in a.pairwise]} '
                 f'(12.6.3)')
    if s.akm and s.akm[0] not in a.akm:
        v.append(f'AKM STA {s.akm[0].type} не из объявленных точкой {[x.type for x in a.akm]} (12.6.3)')
    act = mfp_actions(a.caps['mfpc'], a.caps['mfpr'], s.caps['mfpc'], s.caps['mfpr'])
    if act[1] == 'not':
        v.append(f'MFPC/MFPR точки {a.caps["mfpc"]}/{a.caps["mfpr"]}, STA {s.caps["mfpc"]}/{s.caps["mfpr"]}: «The STA '
                 f'shall not associate» (табл. 12-5)')
    return v


def mfp_actions(ap_c, ap_r, sta_c, sta_r):
    """Табл. 12-5 → (действие AP, действие STA): 'may' | 'reject' | 'none' (AP), 'may' | 'not' (STA)."""
    if sta_r and not sta_c:                                  # STA объявила недопустимое
        return ('reject' if ap_c else 'none', 'not')
    if ap_r and not ap_c:                                    # AP объявила недопустимое
        return ('none', 'not')
    if ap_c and ap_r and not sta_c:
        return ('reject', 'not')
    if not ap_c and sta_c and sta_r:
        return ('none', 'not')
    return ('may', 'may')


def check_assoc_status(ap_info, sta_info, status, dmg=True):
    """Точка: по табл. 12-5 «The AP shall reject associations from the STA with the StatusCode
    ROBUST_MANAGEMENT_POLICY_VIOLATION»; принятая (SUCCESS) ассоциация при таком сочетании — нарушение точки."""
    a, s = rsn_effective(ap_info, dmg), rsn_effective(sta_info, dmg)
    ap_act, _ = mfp_actions(a.caps['mfpc'], a.caps['mfpr'], s.caps['mfpc'], s.caps['mfpr'])
    if ap_act == 'reject' and status != ROBUST_MANAGEMENT_POLICY_VIOLATION:
        return [f'MFPC/MFPR точки {a.caps["mfpc"]}/{a.caps["mfpr"]}, STA {s.caps["mfpc"]}/{s.caps["mfpr"]}: статус '
                f'{status}, а «shall reject … ROBUST_MANAGEMENT_POLICY_VIOLATION» (31, табл. 12-5)']
    return []


# ===================================================================================== Extended Capabilities (9.4.2.26)
# табл. 9-153: бит → имя (поля из нескольких битов — первый бит и ширина)
EXT_CAP_FIELDS = [
    (0, 1, '20/40 BSS Coexistence Management Support'), (1, 1, 'GLK'), (2, 1, 'Extended Channel Switching'),
    (3, 1, 'GLK-GCR'), (4, 1, 'PSMP Capability'), (5, 1, '_r5'), (6, 1, 'S-PSMP Support'), (7, 1, 'Event'),
    (8, 1, 'Diagnostics'), (9, 1, 'Multicast Diagnostics'), (10, 1, 'Location Tracking'), (11, 1, 'FMS'),
    (12, 1, 'Proxy ARP Service'), (13, 1, 'Collocated Interference Reporting'), (14, 1, 'Civic Location'),
    (15, 1, 'Geospatial Location'), (16, 1, 'TFS'), (17, 1, 'WNM Sleep Mode'), (18, 1, 'TIM Broadcast'),
    (19, 1, 'BSS Transition'), (20, 1, 'QoS Traffic Capability'), (21, 1, 'AC Station Count'),
    (22, 1, 'Multiple BSSID'), (23, 1, 'Timing Measurement'), (24, 1, 'Channel Usage'), (25, 1, 'SSID List'),
    (26, 1, 'DMS'), (27, 1, 'UTC TSF Offset'), (28, 1, 'TPU Buffer STA Support'), (29, 1, 'TDLS Peer PSM Support'),
    (30, 1, 'TDLS channel switching'), (31, 1, 'Interworking'), (32, 1, 'QoS Map'), (33, 1, 'EBR'),
    (34, 1, 'SSPN Interface'), (35, 1, '_r35'), (36, 1, 'MSGCF Capability'), (37, 1, 'TDLS Support'),
    (38, 1, 'TDLS Prohibited'), (39, 1, 'TDLS Channel Switching Prohibited'), (40, 1, 'Reject Unadmitted Frame'),
    (41, 3, 'Service Interval Granularity'), (44, 1, 'Identifier Location'), (45, 1, 'U-APSD Coexistence'),
    (46, 1, 'WNM Notification'), (47, 1, 'QAB Capability'), (48, 1, 'UTF-8 SSID'), (49, 1, 'QMFActivated'),
    (50, 1, 'QMFReconfigurationActivated'), (51, 1, 'Robust AV Streaming'), (52, 1, 'Advanced GCR'),
    (53, 1, 'Mesh GCR'), (54, 1, 'SCS'), (55, 1, 'QLoad Report'), (56, 1, 'Alternate EDCA'),
    (57, 1, 'Unprotected TXOP Negotiation'), (58, 1, 'Protected TXOP Negotiation'), (59, 1, '_r59'),
    (60, 1, 'Protected QLoad Report'), (61, 1, 'TDLS Wider Bandwidth'), (62, 1, 'Operating Mode Notification'),
    (63, 2, 'Max Number Of MSDUs In A-MSDU'), (65, 1, 'Channel Schedule Management'),
    (66, 1, 'Geodatabase Inband Enabling Signal'), (67, 1, 'Network Channel Control'), (68, 1, 'White Space Map'),
    (69, 1, 'Channel Availability Query'), (70, 1, 'Fine Timing Measurement Responder'),
    (71, 1, 'Fine Timing Measurement Initiator'), (72, 1, 'FILS Capability'),
    (73, 1, 'Extended Spectrum Management Capable'), (74, 1, 'Future Channel Guidance'), (75, 1, 'PAD'),
    (76, 4, '_r76'), (80, 1, 'Complete List of NonTxBSSID Profiles'), (81, 1, 'SAE Password Identifiers In Use'),
    (82, 1, 'SAE Password Identifiers Used Exclusively'), (83, 1, '_r83'), (84, 1, 'Beacon Protection Enabled'),
    (85, 1, 'Mirrored SCS'), (86, 1, '_r86'), (87, 1, 'Local MAC Address Policy'),
]
EXT_CAP_KNOWN_BITS = 88                                  # 88–n Reserved
EXT_CAP_BIT = {n: b for b, w, n in EXT_CAP_FIELDS}
# Бит → только AP (для non-AP STA — Reserved): 80 «reserved for a non-AP STA», 84 «reserved for a non-AP STA»;
# 81/82 «The AP sets…» — для non-AP значение не определено (не проверяется).
EXT_CAP_AP_ONLY = (80, 84)


def parse_ext_cap(info):
    """Поле Extended Capabilities → dict имя → значение (по табл. 9-153; недостающие биты — 0, 9.4.2.26) и
    rsv_high — ненулевые биты ≥ 88 (Reserved)."""
    v = int.from_bytes(bytes(info), 'little')
    out = {n: v >> b & ((1 << w) - 1) for b, w, n in EXT_CAP_FIELDS}
    out['rsv_high'] = v >> EXT_CAP_KNOWN_BITS
    return out


def encode_ext_cap(bits=(), n=None, fields=None):
    """bits — номера битов = 1 (или имена); fields — {имя: значение} для многобитовых; n — длина поля в октетах
    (по умолчанию — до последнего ненулевого)."""
    v = 0
    for b in bits:
        v |= 1 << (EXT_CAP_BIT[b] if isinstance(b, str) else b)
    for name, x in (fields or {}).items():
        b = EXT_CAP_BIT[name]
        w = next(w for bb, w, nn in EXT_CAP_FIELDS if nn == name)
        if x >> w:
            raise ValueError(f'{name}: {x} не помещается в {w} бит')
        v |= x << b
    n = n if n is not None else max(1, (v.bit_length() + 7) // 8)
    return E.encode_element(127, v.to_bytes(n, 'little'))


def check_ext_cap(info, role=E.ROLE_STA, dmg=True):
    """Нарушения поля Extended Capabilities передатчика (резерв = 0 при передаче, 9.2.2)."""
    f = parse_ext_cap(info)
    v = []
    for b, w, n in EXT_CAP_FIELDS:
        if n.startswith('_r') and f[n]:
            v.append(f'бит {b}{"–" + str(b + w - 1) if w > 1 else ""} Reserved = {f[n]} (табл. 9-153)')
    if f['rsv_high']:
        hi = [EXT_CAP_KNOWN_BITS + i for i in range(f['rsv_high'].bit_length()) if f['rsv_high'] >> i & 1]
        v.append(f'биты {hi} (88–n) Reserved ≠ 0 (табл. 9-153)')
    if f['Service Interval Granularity'] and not f['S-PSMP Support']:
        v.append('Service Interval Granularity ≠ 0 при S-PSMP Support = 0 — «otherwise, it is reserved» (табл. 9-153)')
    if dmg and f['Max Number Of MSDUs In A-MSDU']:
        # «Reserved if A-MSDU is not supported or if the STA is not an HT STA» — DMG STA не HT STA
        v.append('Max Number Of MSDUs In A-MSDU ≠ 0 у DMG STA — «reserved … if the STA is not an HT STA» '
                 '(табл. 9-153)')
    if role not in (E.ROLE_AP, E.ROLE_PCP):
        for b in EXT_CAP_AP_ONLY:
            n = next(n for bb, w, n in EXT_CAP_FIELDS if bb == b)
            if f[n]:
                v.append(f'бит {b} {n} = 1 у non-AP STA — «reserved for a non-AP STA» (табл. 9-153)')
        if f['QAB Capability']:
            v.append('QAB Capability = 1 у non-AP STA — «Set to 1 if AP supports QAB» (табл. 9-153, 11.35.1)')
    return v


# =========================================================================== Supported Operating Classes (9.4.2.53)
OC_DELIM_130, OC_DELIM_0 = 130, 0
# Табл. E-4 (глобальные классы): 60 ГГц DMG — 180 (56,16 ГГц, 2160 МГц, каналы 1–6), 181 (каналы 2, 3);
# 182–186 — 45 ГГц (CMMG), не DMG.
DMG_GLOBAL_CLASSES = {180: (1, 2, 3, 4, 5, 6), 181: (2, 3)}
OC_RESERVED = set(range(131, 180)) | set(range(187, 192)) | {255}

Soc = namedtuple('Soc', 'current classes current_ext duples')


def encode_soc(current, classes, current_ext=(), duples=()):
    """Рис. 9-370: Current Operating Class, Operating Classes, [130 + Current Operating Class Extension]…,
    [0 + Operating Class Duple List]."""
    b = bytes([current]) + bytes(classes)
    for ext in current_ext:
        b += bytes([OC_DELIM_130]) + bytes(ext)
    if duples:
        b += bytes([OC_DELIM_0]) + b''.join(bytes(d) for d in duples)
    return E.encode_element(59, b)


def parse_soc(info):
    """Информация элемента → Soc. Operating Classes — до разделителя 130, 0 или конца (9.4.2.53); Current Operating
    Class Extension — между 130 и следующим разделителем; Duple List — пары октетов после 0 до следующего 0/конца."""
    b = bytes(info)
    if not b:
        raise ValueError('Supported Operating Classes без Current Operating Class (рис. 9-370)')
    i, n = 1, len(b)
    classes = []
    while i < n and b[i] not in (OC_DELIM_130, OC_DELIM_0):
        classes.append(b[i])
        i += 1
    exts = []
    while i < n and b[i] == OC_DELIM_130:
        j = i + 1
        while j < n and b[j] not in (OC_DELIM_130, OC_DELIM_0):
            j += 1
        exts.append(tuple(b[i + 1:j]))
        i = j
    duples = []
    if i < n and b[i] == OC_DELIM_0:
        j = i + 1
        while j < n and b[j] != OC_DELIM_0:
            j += 1
        body = b[i + 1:j]
        if len(body) % 2:
            raise ValueError('Operating Class Duple List: нечётное число октетов (рис. 9-372: 2n)')
        duples = [tuple(body[k:k + 2]) for k in range(0, len(body), 2)]
        i = j
    if i < n:
        raise ValueError(f'Supported Operating Classes: лишние октеты после смещения {i}')
    return Soc(b[0], classes, exts, duples)


def check_soc(info, dmg=True, current_class=None):
    """Нарушения Supported Operating Classes DMG STA. current_class — класс, на котором BSS работает (если известен)."""
    try:
        s = parse_soc(info)
    except ValueError as x:
        return [str(x)]
    v = []
    for c in [s.current] + s.classes:
        if c in OC_RESERVED:
            v.append(f'класс {c} — Reserved (табл. E-4)')
    if len(set(s.classes)) != len(s.classes):
        v.append(f'Operating Classes с повтором {s.classes} (9.4.2.53: «lists … all … operating classes»)')
    for ext in s.current_ext:
        if not ext:
            v.append('Current Operating Class Extension пуст (рис. 9-371: «N (N ≥ 0) … followed by one Operating '
                     'Class octet»)')
    if s.duples != sorted(s.duples):
        v.append(f'Operating Class Duple List не по возрастанию {s.duples} (9.4.2.53: «transmitted in ascending '
                 f'order»)')
    if dmg and not s.current_ext and s.current not in DMG_GLOBAL_CLASSES:
        # СПОРНО → принято (PLAN.md №68): у DMG STA текущий класс — глобальный DMG (табл. E-4); локальные классы
        # таблиц E-1…E-3 (34, 18, 59) без Country не опознаются.
        v.append(f'Current Operating Class {s.current} — не класс 60 ГГц DMG (табл. E-4: 180, 181; PLAN.md №68)')
    if s.current not in s.classes and not s.current_ext:
        # 11.9.2: «The Operating Classes field shall list all operating classes with which the STA is capable of
        # operating» — класс в работе в их числе.
        v.append(f'Current Operating Class {s.current} нет в Operating Classes {s.classes} (11.9.2)')
    if current_class is not None and s.current != current_class:
        v.append(f'Current Operating Class {s.current} ≠ класс BSS {current_class} (9.4.2.53: «operating class in '
                 f'use»)')
    return v


def channel_in_class(op_class, ch):
    """Канал допустим в глобальном классе DMG (табл. E-4) — для Directional Channel Quality и Multi-band."""
    return ch in DMG_GLOBAL_CLASSES.get(op_class, ())
