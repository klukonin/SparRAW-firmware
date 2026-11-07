# SPDX-License-Identifier: AGPL-3.0-or-later
"""Кадры Action / Action No Ack у DMG STA по 802.11-2020: общий формат 9.3.3.13/9.3.3.14 (табл. 9-43 [p. 856]),
поле Action 9.4.1.11 (табл. 9-51 [p. 880] — категории, robust, групповая защита), таблицы действий категорий,
допустимых у DMG (9-346 Spectrum Management, 9-347 QoS, 9-359 Block Ack, 9-363 Radio Measurement, 9-364 Public,
9-403 SA Query, 9-404 Protected Dual, 9-425 WNM, 9-434 Unprotected WNM, 9-457 DMG, 9-479 FST, 9-486 Unprotected DMG),
ответ на нераспознанный Action (10.28.4 [p. 1816]), Action No Ack в ATI (10.39.3 [p. 1881]); функции WNM и их
зависимости (9.6.13.1 [p. 1528], 11.21.1 [p. 2256]: биты 7–27 Extended Capabilities — «shall not request»,
«shall reject»).

Допустимость для DMG (поле status категории/действия):
  'open'   — применимо к DMG и в охвате open (модель есть в эталоне);
  'pro'    — применимо к DMG, охват pro (FTM, FST/multi-band; в open — не передаётся);
  'out'    — применимо к DMG по стандарту, но в open не реализуется (FT, GAS, QMF, Robust AV Streaming, …): передача
             не нарушение стандарта, судья отмечает (вердикт model — охват);
  'nondmg' — стандарт не определяет для DMG или прямо запрещает (TDLS: «A DMG STA shall not use the TDLS protocol»,
             11.20.1; FILS: «only supported in a non-DMG non-S1G infrastructure BSS», 11.45.1; HT/VHT/S1G/CDMG/CMMG —
             другие PHY; HCCA; TVWS; DSE — 3650 МГц, 11.11.1) — передача DMG STA — нарушение.
  Категории/действия с кодом Reserved — нарушение (табл. 9-51: «set to one of the nonreserved values»); категории
  128–255 (Error) — только возврат нераспознанного кадра по 10.28.4.

Action No Ack у DMG (9.3.3.14: «Unless specified as allowing the use of the Action No Ack … uses only the Action
subtype»): Link Measurement Request/Report в DMG BSS (9.6.6.4/9.6.6.5), Information Response широковещательный
(9.6.19.5 — и только так: «If this frame is sent as a broadcast, then this frame is an Action No Ack frame»),
Announce (9.6.21.2), BRP (9.6.21.3 — только Action No Ack). Индивидуальный запрос в ATI — не Action No Ack (10.39.3).

Принято: PLAN.md №105 (классы допустимости, пропуски таблиц), №107 (биты WNM 7–27, отказ).

Нарушения — [(текст, вердикт)] ('ours' | 'model')."""
from collections import namedtuple

from . import elements as E

# ---------------------------------------------------------------------------------------------- табл. 9-51
# код → (имя, подпункт, robust, group addressed privacy, статус DMG, причина)
CATEGORY = {
    0: ('Spectrum Management', '9.6.2', True, False, 'open', 'TPC/измерения — DMG BSS (11.7.7, 11.8.1)'),
    1: ('QoS', '9.6.3', True, False, 'open', 'ADDTS/DELTS — DMG TSPEC (11.4)'),
    3: ('Block Ack', '9.6.4', True, False, 'open', '10.25'),
    4: ('Public', '9.6.7', False, False, 'open', 'ECSA, QAB, Vendor Specific; FTM — pro'),
    5: ('Radio Measurement', '9.6.6', True, False, 'open', 'Link Measurement (10.43)'),
    6: ('Fast BSS Transition', '9.6.8', True, False, 'out', 'FT (13) — в open нет'),
    7: ('HT', '9.6.11', False, False, 'nondmg', 'HT — не DMG (9.2.4.6: HT Control у DMG нет)'),
    8: ('SA Query', '9.6.9', True, False, 'open', 'SA Query — RSNA с защитой кадров управления (11.13), OCV (11.9)'),
    9: ('Protected Dual of Public Action', '9.6.10', True, False, 'out', 'защищённые Public — в open нет'),
    10: ('WNM', '9.6.13', True, False, 'open', 'WNM (11.21): DMS — open; прочие функции — по битам Ext Cap'),
    11: ('Unprotected WNM', '9.6.14', False, False, 'out', 'TIM / Timing Measurement — в open нет'),
    12: ('TDLS', '9.6.12', None, False, 'nondmg', '11.20.1: «A DMG STA shall not use the TDLS protocol»'),
    13: ('Mesh', '9.6.16', True, True, 'out', 'MBSS — вне охвата open'),
    14: ('Multihop', '9.6.17', True, True, 'out', 'MBSS — вне охвата open'),
    15: ('Self-protected', '9.6.15', False, False, 'out', 'mesh peering / AMPE — вне охвата open'),
    16: ('DMG', '9.6.19', True, False, 'open', '9.6.19'),
    18: ('Fast Session Transfer', '9.6.20', True, False, 'pro', 'FST/multi-band (11.31) — pro, в open 0'),
    19: ('Robust AV Streaming', '9.6.18', True, False, 'out', 'SCS/MSCS/GCR membership — в open нет'),
    20: ('Unprotected DMG', '9.6.21', False, False, 'open', 'Announce, BRP'),
    21: ('VHT', '9.6.22', False, False, 'nondmg', 'VHT — не DMG'),
    22: ('Unprotected S1G', '9.6.24', False, False, 'nondmg', 'S1G — не DMG'),
    23: ('S1G', '9.6.25', True, False, 'nondmg', 'S1G — не DMG'),
    24: ('Flow control', '9.6.26', True, False, 'nondmg', 'S1G (Flow Suspension/Resumption) — не DMG'),
    25: ('Control Response MCS Negotiation', '9.6.27', True, False, 'nondmg', 'S1G — не DMG'),
    26: ('FILS', '9.6.23', True, False, 'nondmg', '11.45.1: «FILS is only supported in a non-DMG non-S1G '
                                                      'infrastructure BSS»'),
    27: ('CDMG', '9.6.28', True, False, 'nondmg', 'CDMG (45/60 ГГц Китай) — не DMG'),
    28: ('CMMG', '9.6.29', True, False, 'nondmg', 'CMMG (45 ГГц) — не DMG'),
    29: ('GLK', '9.6.30', True, True, 'out', 'GLK у DMG — только через DMG relay (relay не делаем)'),
    126: ('Vendor-specific Protected', '9.6.5', True, False, 'open', '9.6.5'),
    127: ('Vendor-specific', '9.6.5', False, False, 'open', '9.6.5'),
}
CAT_RESERVED = {2, 17} | set(range(30, 126))
CAT_ERROR_BIT = 0x80                    # табл. 9-51: 128–255 Error; 10.28.4: «MSB of the Category field is set to 1»
CAT_VENDOR = (126, 127)
CAT_SELF_PROTECTED = 15

O, P, X, N = 'open', 'pro', 'out', 'nondmg'
# действия: категория → {код: (имя, статус DMG, причина)}; коды вне словаря — Reserved
ACTION = {
    0: {0: ('Spectrum Measurement Request', O, '11.8.7'), 1: ('Spectrum Measurement Report', O, '11.8.7'),
        2: ('TPC Request', O, '11.7.7'), 3: ('TPC Report', O, '11.7.7'),
        4: ('Channel Switch Announcement', N, 'DMG BSS — ECSA (11.8.8.6); CSA — не DMG')},
    1: {0: ('ADDTS Request', O, '11.4'), 1: ('ADDTS Response', O, '11.4'), 2: ('DELTS', O, '11.4'),
        3: ('Schedule', N, 'HCCA/APSD-расписание — не DMG (доступ DMG — 10.39)'),
        4: ('QoS Map Configure', X, 'interworking — в open нет'),
        5: ('ADDTS Reserve Request', N, 'HCCA TXOP — не DMG'), 6: ('ADDTS Reserve Response', N, 'HCCA TXOP — не DMG')},
    3: {0: ('ADDBA Request', O, '10.25'), 1: ('ADDBA Response', O, '10.25'), 2: ('DELBA', O, '10.25'),
        128: ('NDP ADDBA Request', N, 'S1G'), 129: ('NDP ADDBA Response', N, 'S1G'), 130: ('NDP DELBA', N, 'S1G'),
        132: ('BAT ADDBA Request', N, 'S1G'), 133: ('BAT ADDBA Response', N, 'S1G'), 134: ('BAT DELBA', N, 'S1G')},
    4: {0: ('20/40 BSS Coexistence Management', N, 'HT 40 МГц'), 1: ('DSE Enablement', N, 'DSE — 3650 МГц (11.11.1)'),
        2: ('DSE Deenablement', N, 'DSE'), 3: ('DSE Registered Location Announcement', N, 'DSE'),
        4: ('Extended Channel Switch Announcement', O, '11.8.8.6, 11.9'),
        5: ('DSE Measurement Request', N, 'DSE'), 6: ('DSE Measurement Report', N, 'DSE'),
        7: ('Measurement Pilot', X, 'в open нет'), 8: ('DSE Power Constraint', N, 'DSE'),
        9: ('Vendor Specific', O, '9.6.7.11'), 10: ('GAS Initial Request', X, 'GAS/interworking — в open нет'),
        11: ('GAS Initial Response', X, 'GAS'), 12: ('GAS Comeback Request', X, 'GAS'),
        13: ('GAS Comeback Response', X, 'GAS'), 14: ('TDLS Discovery Response', N, '11.20.1: TDLS — не DMG'),
        15: ('Location Track Notification', X, 'WNM location — в open нет'), 16: ('QAB Request', O, '11.35'),
        17: ('QAB Response', O, '11.35'), 18: ('QMF Policy', X, 'QMF — в open нет'),
        19: ('QMF Policy Change', X, 'QMF'), 20: ('QLoad Request', X, 'QLoad — в open нет'),
        21: ('QLoad Report', X, 'QLoad'), 22: ('HCCA TXOP Advertisement', N, 'HCCA'),
        23: ('HCCA TXOP Response', N, 'HCCA'), 24: ('Public Key', X, 'в open нет'),
        25: ('Channel Availability Query', N, 'TVWS'), 26: ('Channel Schedule Management', N, 'TVWS'),
        27: ('Contact Verification Signal', N, 'TVWS'), 28: ('GDD Enablement Request', N, 'TVWS'),
        29: ('GDD Enablement Response', N, 'TVWS'), 30: ('Network Channel Control', N, 'TVWS'),
        31: ('White Space Map Announcement', N, 'TVWS'), 32: ('Fine Timing Measurement Request', P, 'FTM — pro'),
        33: ('Fine Timing Measurement', P, 'FTM — pro'), 34: ('FILS Discovery', N, '11.45.1: FILS — не DMG'),
        35: ('DCS Measurement Request', N, 'S1G'), 36: ('DCS Measurement Report', N, 'S1G'),
        37: ('DCS Request', N, 'S1G'), 38: ('DCS Response', N, 'S1G'),
        39: ('Extended Notification Period Request', N, 'S1G'), 40: ('Extended Notification Period Response', N, 'S1G'),
        41: ('Extended Channel Splitting Request', N, 'CMMG'), 42: ('Extended Channel Splitting Response', N, 'CMMG'),
        43: ('Group Addressed GAS Request', X, 'GAS'), 44: ('Group Addressed GAS Response', X, 'GAS'),
        45: ('On-channel Tunnel Request', P, 'multi-band/FST — pro')},
    5: {0: ('Radio Measurement Request', X, 'Radio Measurement (11.10) кроме Link Measurement — в open нет'),
        1: ('Radio Measurement Report', X, 'в open нет'), 2: ('Link Measurement Request', O, '10.43, 11.10.11'),
        3: ('Link Measurement Report', O, '10.43, 11.10.11'), 4: ('Neighbor Report Request', X, 'в open нет'),
        5: ('Neighbor Report Response', X, 'в open нет')},
    6: {1: ('FT Request', X, 'FT'), 2: ('FT Response', X, 'FT'), 3: ('FT Confirm', X, 'FT'), 4: ('FT Ack', X, 'FT')},
    8: {0: ('SA Query Request', O, '11.13'), 1: ('SA Query Response', O, '11.13')},
    9: {1: ('Protected DSE Enablement', N, 'DSE'), 2: ('Protected DSE Deenablement', N, 'DSE'),
        4: ('Protected Extended Channel Switch Announcement', X, 'в open нет'),
        5: ('Protected Measurement Request', X, ''), 6: ('Protected Measurement Report', X, ''),
        8: ('Protected DSE Power Constraint', N, 'DSE'), 9: ('Protected Vendor Specific', X, ''),
        10: ('Protected GAS Initial Request', X, 'GAS'), 11: ('Protected GAS Initial Response', X, 'GAS'),
        12: ('Protected GAS Comeback Request', X, 'GAS'), 13: ('Protected GAS Comeback Response', X, 'GAS'),
        43: ('Protected Group Addressed GAS Request', X, 'GAS'),
        44: ('Protected Group Addressed GAS Response', X, 'GAS')},
    10: {0: ('Event Request', X, '11.21.2'), 1: ('Event Report', X, '11.21.2'), 2: ('Diagnostic Request', X, '11.21.3'),
         3: ('Diagnostic Report', X, '11.21.3'), 4: ('Location Configuration Request', X, '11.21.4'),
         5: ('Location Configuration Response', X, '11.21.4'), 6: ('BSS Transition Management Query', X, '11.21.7'),
         7: ('BSS Transition Management Request', X, '11.21.7'),
         8: ('BSS Transition Management Response', X, '11.21.7'),
         9: ('FMS Request', N, 'FMS — групповые кадры по DTIM (11.2.3.16); в DMG TIM/DTIM нет'),
         10: ('FMS Response', N, 'FMS'), 11: ('Collocated Interference Request', X, '11.21.9'),
         12: ('Collocated Interference Report', X, '11.21.9'), 13: ('TFS Request', X, '11.21.12'),
         14: ('TFS Response', X, '11.21.12'), 15: ('TFS Notify', X, '11.21.12'),
         16: ('WNM Sleep Mode Request', N, 'WNM sleep — TIM/DTIM (11.2.3.18); энергосбережение не делаем'),
         17: ('WNM Sleep Mode Response', N, 'WNM sleep'),
         18: ('TIM Broadcast Request', N, 'TIM broadcast (11.2.3.17) — в DMG TIM нет'),
         19: ('TIM Broadcast Response', N, 'TIM broadcast'), 20: ('QoS Traffic Capability Update', X, '11.21.10'),
         21: ('Channel Usage Request', X, '11.21.15'), 22: ('Channel Usage Response', X, '11.21.15'),
         23: ('DMS Request', O, '11.21.16'), 24: ('DMS Response', O, '11.21.16'),
         25: ('Timing Measurement Request', X, '11.21.5'), 26: ('WNM Notification Request', X, '11.21.17'),
         27: ('WNM Notification Response', X, '11.21.17')},
    11: {0: ('TIM', N, 'TIM — в DMG нет'), 1: ('Timing Measurement', X, '11.21.5')},
    16: {0: ('Power Save Configuration Request', X, 'энергосбережение не делаем: точка отвечает отказом'),
         1: ('Power Save Configuration Response', O, 'отказ на PSC-REQ (решение open, opt_caps)'),
         2: ('Information Request', O, '11.28'), 3: ('Information Response', O, '11.28'),
         4: ('Handover Request', O, '11.27.2'), 5: ('Handover Response', O, '11.27.2'),
         8: ('Relay Search Request', X, 'relay не делаем'), 9: ('Relay Search Response', X, 'relay'),
         10: ('Multi-Relay Channel Measurement Request', X, 'relay'),
         11: ('Multi-Relay Channel Measurement Report', X, 'relay'), 12: ('RLS Request', X, 'relay'),
         13: ('RLS Response', X, 'relay'), 14: ('RLS Announcement', X, 'relay'), 15: ('RLS Teardown', X, 'relay'),
         16: ('Relay Ack Request', X, 'relay'), 17: ('Relay Ack Response', X, 'relay'),
         18: ('TPA Request', X, 'relay'), 19: ('TPA Response', X, 'relay'), 20: ('TPA Report', X, 'relay'),
         21: ('ROC Request', X, 'relay'), 22: ('ROC Response', X, 'relay')},
    18: {0: ('FST Setup Request', P, 'FST'), 1: ('FST Setup Response', P, 'FST'), 2: ('FST Teardown', P, 'FST'),
         3: ('FST Ack Request', P, 'FST'), 4: ('FST Ack Response', P, 'FST'),
         5: ('On-channel Tunnel Request', P, 'FST')},
    20: {0: ('Announce', O, '9.6.21.2'), 1: ('BRP', O, '9.6.21.3')},
}
del O, P, X, N

# 9.3.3.14: где Action No Ack разрешён DMG STA; значение — условие
NOACK_DMG_BSS, NOACK_GROUP_ONLY, NOACK_ANY, NOACK_ONLY = 'dmg_bss', 'group', 'any', 'only'
# 9.6.6.4/9.6.6.5: «in a DMG BSS … Action or an Action No Ack frame»
NO_ACK = {(5, 2): NOACK_DMG_BSS, (5, 3): NOACK_DMG_BSS,
          (16, 3): NOACK_GROUP_ONLY,                          # 9.6.19.5: broadcast ⇒ Action No Ack
          (20, 0): NOACK_ANY,                                  # 9.6.21.2: «Action or an Action No Ack frame»
          (20, 1): NOACK_ONLY}                                 # 9.6.21.3: «The BRP frame is an Action No Ack frame»
# запросы (10.39.3: «Individually addressed request frames transmitted during the ATI shall not be sent using Action
# No Ack») — из допускающих No Ack запрос: Announce (ATI-запрос точки, 10.39.3 «such as an Announce frame»),
# Link Measurement Request
ATI_REQUESTS = {(20, 0), (5, 2)}

Act = namedtuple('Act', 'cat act cat_name act_name status why error robust')


def classify(body):
    """Тело Action (с октета Category) → Act. Категория ≥ 128 — error=True, разбирается по коду без старшего бита."""
    if len(body) < 1:
        raise ValueError('Action: нет поля Category (рис. 9-94)')
    raw = body[0]
    err = bool(raw & CAT_ERROR_BIT)
    cat = raw & 0x7f
    c = CATEGORY.get(cat)
    if c is None:
        return Act(cat, body[1] if len(body) > 1 else None, 'Reserved', None, 'reserved',
                   f'категория {cat} — Reserved (табл. 9-51)', err, None)
    act = body[1] if len(body) > 1 and cat not in CAT_VENDOR else None
    if cat in CAT_VENDOR:
        return Act(cat, None, c[0], 'Vendor Specific', c[4], c[5], err, c[2])
    tab = ACTION.get(cat)
    if tab is None:
        return Act(cat, act, c[0], None, c[4], c[5], err, c[2])
    if act is None:
        return Act(cat, None, c[0], None, 'reserved', f'{c[0]}: нет поля действия (9.4.1.11)', err, c[2])
    a = tab.get(act)
    if a is None:
        return Act(cat, act, c[0], None, 'reserved', f'{c[0]} Action {act} — Reserved (табл. действий {c[1]})',
                   err, c[2])
    return Act(cat, act, c[0], a[0], a[1], a[2], err, c[2])


def noack_allowed(cat, act, group, dmg_bss=True):
    """9.3.3.14 + подпункты кадров: можно ли этот кадр послать как Action No Ack."""
    cond = NO_ACK.get((cat, act))
    if cond is None:
        return False
    if cond == NOACK_DMG_BSS:
        return dmg_bss
    if cond == NOACK_GROUP_ONLY:
        return group
    return True


def check_action(body, no_ack, group, in_ati=False, dmg_bss=True, echo_of=None):
    """Нарушения одного переданного Action/Action No Ack DMG STA. echo_of — тело принятого кадра, если этот кадр —
    возврат по 10.28.4 (тогда допустим код Error)."""
    a = classify(body)
    v = []
    what = f'{a.cat_name}{" / " + a.act_name if a.act_name else ""}'
    if a.error:
        if echo_of is None:
            v.append((f'Category {body[0]} (Error, 128–255) — только возврат нераспознанного кадра (10.28.4)', 'ours'))
        return v
    if a.status == 'reserved':
        v.append((f'{a.why} — «set to one of the nonreserved values» (9.4.1.11)', 'ours'))
        return v
    if a.status == 'nondmg':
        v.append((f'{what} у DMG STA: {a.why}', 'ours'))
    elif a.status in ('out', 'pro'):
        v.append((f'{what}: {a.why} (охват {"pro" if a.status == "pro" else "не open"})', 'model'))
    cond = NO_ACK.get((a.cat, a.act))
    if no_ack and not noack_allowed(a.cat, a.act, group, dmg_bss):
        v.append((f'{what} как Action No Ack — не разрешено (9.3.3.14: «Unless specified as allowing the use of the '
                  f'Action No Ack … uses only the Action subtype»'
                  + ('; Information Response No Ack — только широковещательный, 9.6.19.5)' if cond == NOACK_GROUP_ONLY
                     else ')'), 'ours'))
    if not no_ack and cond == NOACK_ONLY:
        v.append((f'{what} как Action — «is an Action No Ack frame» (9.6.21.3)', 'ours'))
    if not no_ack and cond == NOACK_GROUP_ONLY and group:
        v.append((f'{what} широковещательный как Action — «If this frame is sent as a broadcast, then this frame is an '
                  f'Action No Ack frame» (9.6.19.5)', 'ours'))
    if no_ack and in_ati and not group and (a.cat, a.act) in ATI_REQUESTS:
        v.append((f'{what}: индивидуальный запрос в ATI как Action No Ack (10.39.3)', 'model'))
    return v


def must_echo(body, group):
    """10.28.4: индивидуальный Action с нераспознанной категорией и MSB = 0 → вернуть отправителю с MSB = 1.
    → True (категория Reserved — нераспознана у любой реализации 2020), None (не-DMG/вне охвата — зависит от
    реализации), False (возвращать не нужно)."""
    if group or not body or body[0] & CAT_ERROR_BIT:
        return False
    a = classify(body)
    if a.cat_name == 'Reserved':
        return True
    if a.status in ('nondmg', 'out', 'pro'):
        return None
    return False


def check_echo(rx_body, tx_body):
    """10.28.4: «return the Action … frame to the source without change except that the MSB of the Category field is
    set to 1»."""
    if not tx_body or tx_body[0] != (rx_body[0] | CAT_ERROR_BIT) or bytes(tx_body[1:]) != bytes(rx_body[1:]):
        return ['возврат нераспознанного Action изменён не только старшим битом Category (10.28.4)']
    return []


def table_dmg(status=None):
    """Полная таблица допустимости для DMG: [(категория, действие, имя категории, имя действия, статус, причина)];
    status — фильтр."""
    out = []
    for cat, c in sorted(CATEGORY.items()):
        tab = ACTION.get(cat)
        if not tab:
            row = (cat, None, c[0], None, c[4], c[5])
            if status is None or row[4] == status:
                out.append(row)
            continue
        for act, a in sorted(tab.items()):
            row = (cat, act, c[0], a[0], a[1], a[2])
            if status is None or row[4] == status:
                out.append(row)
    return out


# ================================================================================ WNM (9.6.13.1, 11.21.1)
# действие WNM / Unprotected WNM → бит Extended Capabilities (табл. 9-153) функции
WNM_FEATURE_BIT = {
    (10, 0): 7, (10, 1): 7, (10, 2): 8, (10, 3): 8, (10, 4): 10, (10, 5): 10, (10, 6): 19, (10, 7): 19, (10, 8): 19,
    (10, 9): 11, (10, 10): 11, (10, 11): 13, (10, 12): 13, (10, 13): 16, (10, 14): 16, (10, 15): 16, (10, 16): 17,
    (10, 17): 17, (10, 18): 18, (10, 19): 18, (10, 20): 20, (10, 21): 24, (10, 22): 24, (10, 23): 26, (10, 24): 26,
    (10, 25): 23, (10, 26): 46, (10, 27): 46, (11, 0): 18, (11, 1): 23}
# «request the corresponding feature» (11.21.1) — запросы и кадры, требующие функции у получателя
WNM_REQUESTS = {(10, 0), (10, 2), (10, 4), (10, 6), (10, 7), (10, 9), (10, 11), (10, 13), (10, 16), (10, 18),
                (10, 20), (10, 21), (10, 23), (10, 25), (10, 26), (11, 0)}
WNM_RESPONSE_OF = {(10, 1): (10, 0), (10, 3): (10, 2), (10, 5): (10, 4), (10, 8): (10, 7), (10, 10): (10, 9),
                   (10, 12): (10, 11), (10, 14): (10, 13), (10, 17): (10, 16), (10, 19): (10, 18),
                   (10, 22): (10, 21), (10, 24): (10, 23), (10, 27): (10, 26), (11, 1): (10, 25)}
WNM_BITS = range(7, 28)                 # 11.21.1: «bit 7 to bit 27»
# функции WNM 7–27: применимость к DMG ('dmg' — применима, в open не реализована, кроме DMS; 'nondmg' — на TIM/DTIM)
WNM_DMG = {7: 'dmg', 8: 'dmg', 9: 'dmg', 10: 'dmg', 11: 'nondmg', 12: 'dmg', 13: 'dmg', 14: 'dmg', 15: 'dmg',
           16: 'dmg', 17: 'nondmg', 18: 'nondmg', 19: 'dmg', 20: 'dmg', 21: 'dmg', 22: 'dmg', 23: 'dmg', 24: 'dmg',
           25: 'dmg', 26: 'open', 27: 'dmg'}
BTM_STATUS_ACCEPT = 0                   # табл. 9-428: 0 — Accept


def wnm_bits(ext_cap_info):
    """Extended Capabilities → {бит: 0/1} для 7–27 и 46 (недостающие — 0, 9.4.2.26)."""
    v = int.from_bytes(bytes(ext_cap_info or b''), 'little')
    return {b: v >> b & 1 for b in list(WNM_BITS) + [46]}


def check_wnm_request(cat, act, peer_bits):
    """11.21.1: «for each bit 7 to bit 27 in the received Extended Capabilities element that is 0, a STA shall not
    request the corresponding feature». peer_bits — {бит: 0/1} последнего Ext Cap получателя или None (неизвестно)."""
    if (cat, act) not in WNM_REQUESTS:
        return []
    b = WNM_FEATURE_BIT[(cat, act)]
    if peer_bits is None:
        return []
    if not peer_bits.get(b):
        name = ACTION[cat][act][0]
        rule = '11.21.1' if b in WNM_BITS else f'бит {b} табл. 9-153'
        return [f'{name} к STA с битом {b} Extended Capabilities = 0 — «shall not request the corresponding feature» '
                f'({rule})']
    return []


def wnm_rejects(cat, act, body):
    """Ответ — отказ? True / False / None (статус не разбирается). BSS Transition Management Response — Status Code
    (рис. 9-927, табл. 9-428)."""
    if (cat, act) == (10, 8):
        if len(body) < 4:
            raise ValueError('BSS Transition Management Response: нет BTM Status Code (рис. 9-927)')
        return body[3] != BTM_STATUS_ACCEPT
    return None


def check_wnm_response(cat, act, body, own_bits):
    """11.21.1: «shall reject the request if the receiving WNM STA has not advertised support»."""
    if (cat, act) not in WNM_RESPONSE_OF:
        return [], None
    b = WNM_FEATURE_BIT[(cat, act)]
    if own_bits is None or own_bits.get(b):
        return [], True
    rej = wnm_rejects(cat, act, body)
    if rej is None:
        return [], None
    if not rej:
        return [f'{ACTION[cat][act][0]}: принят запрос функции с битом {b} = 0 в своём Extended Capabilities — '
                f'«shall reject the request» (11.21.1)'], True
    return [], True


def check_wnm_caps(ext_cap_info, capinfo_rm=None, frames_with_ext_cap=None):
    """11.21.1: WNM STA (хотя бы один бит 7–27 = 1) — dot11ExtendedChannelSwitchActivated и
    dot11RadioMeasurementActivated true: бит 2 Extended Capabilities = 1 (11.9.1), Radio Measurement в Capability
    Information = 1 (9.4.1.4); биты функций, на TIM/DTIM, у DMG — 0 (model)."""
    bits = wnm_bits(ext_cap_info)
    v = []
    if not any(bits[b] for b in WNM_BITS):
        return v
    on = [b for b in WNM_BITS if bits[b]]
    v_ecs = int.from_bytes(bytes(ext_cap_info), 'little') >> 2 & 1
    if not v_ecs:
        v.append((f'биты WNM {on} = 1, а Extended Channel Switching (бит 2) = 0 — WNM STA: '
                  f'«dot11ExtendedChannelSwitchActivated … shall be true» (11.21.1, 11.9.1)', 'ours'))
    if capinfo_rm == 0:
        v.append((f'биты WNM {on} = 1, а Radio Measurement в Capability Information = 0 — '
                  f'«dot11RadioMeasurementActivated shall be true» (11.21.1, 9.4.1.4)', 'ours'))
    for b in on:
        if WNM_DMG[b] == 'nondmg':
            v.append((f'бит {b} WNM (TIM/DTIM-функция) = 1 у DMG STA — в DMG TIM/DTIM нет', 'model'))
    return v


EID_EXT_CAP = E.element_key('Extended Capabilities')[0]
