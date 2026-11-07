# SPDX-License-Identifier: AGPL-3.0-or-later
"""Необязательные возможности, которых в open нет: что наши кадры объявляют (802.11-2020; решения охвата 2026-11-07).

Не делаем (биты/элементы/кадры — 0/отсутствуют):
  relay      — DMG relay (10.45 [p. 1975], 11.34 [p. 2386]): элементы Relay Capabilities (9.4.2.147, рис. 9-591/9-592),
               Relay Transfer Parameter Set (9.4.2.148); кадры DMG Action 8–22 (табл. 9-457: Relay Search, Multi-Relay
               Channel Measurement, RLS, Relay Ack, TPA, ROC);
  mms        — несколько MAC-подуровней / MMSL (11.32 [p. 2383]): элемент Multiple MAC Sublayers (9.4.2.152;
               табл. 9-34…9-39: «present if dot11MultipleMACActivated is true»);
  fst        — multi-band / FST (11.31 [p. 2367]; pro, будущее): элементы Multi-band (9.4.2.138, «optionally present if
               dot11MultibandImplemented is true»), Switching Stream (9.4.2.144), Session Transition (9.4.2.145);
               кадры категории Fast Session Transfer (18, табл. 9-51/9-479);
  ps         — энергосбережение (11.2 [p. 2041…], 11.2.7 DMG — никогда): Capability Information DMG B9 Triggered
               Unscheduled PS (рис. 9-86); Extended Capabilities (табл. 9-153) — биты, чьё описание ссылается на 11.2
               или PSMP (10.30): 4 PSMP Capability, 6 S-PSMP Support, 11 FMS (11.2.3.14), 17 WNM Sleep Mode
               (11.2.3.16), 18 TIM Broadcast (11.2.3.15), 28 TPU Buffer STA Support (11.2.3.13), 29 TDLS Peer PSM
               Support (11.2.3.12), 45 U-APSD Coexistence (11.2.3.5.2); элементы DMG Wakeup Schedule (9.4.2.130),
               Awake Window (9.4.2.137), Wakeup Schedule, TIM, U-APSD Coexistence, FMS Descriptor/Request/Response,
               WNM Sleep Mode, TIM Broadcast Request/Response; кадры PS-Poll (9.3.1.5), ATIM (9.3.3.3), PSC Request
               (9.6.19.2) от нашей STA, PSC Response точки — только отказ (Status Code ≠ SUCCESS) без DMG Wakeup
               Schedule (решение: «AP answers PSC-REQ with Reject»), WNM FMS/Sleep/TIM Broadcast (табл. 9-425),
               Unprotected WNM TIM (табл. 9-434); Power Management = 1 в Frame Control (9.2.4.1.7: у AP — резерв,
               у STA — «will be in PS mode»).

Не относятся к этим группам (правило их не ограничивает; СПОРНО → принято PLAN.md №88): DMG STA Capability Information
Heartbeat (B54) и Heartbeat Elapsed Indication (B57–B59) — ожидание кадра в ATI и DMG Control в начале SP/TXOP
(9.4.2.127.2, 10.39.3, 10.39.6.2, 10.23.2), не PS; DMG AP Or PCP Capability Information Power Source (B11) — «battery
powered», не управление питанием; PCP Forwarding (B13) — пересылка PCP внутри PBSS, не relay; Decentralized/Centralized
AP or PCP Clustering (B12/B14) — кластеризация в охвате open (ref/cluster); Extended Capabilities TFS (бит 16, 11.21.12)
— WNM, ссылки на 11.2 нет. В DMG Capabilities 802.11-2020 битов relay/MMS/FST/PS нет."""
from . import elements as E

GROUP_NOTE = {
    'relay': 'relay — необязательно, не поддерживается (решение 2026-11-07)',
    'mms': 'MMS/MMSL — необязательно, не поддерживается (решение 2026-11-07)',
    'fst': 'multi-band/FST — pro, будущее (в open — 0)',
    'ps': 'энергосбережение — не делаем',
}

# Extended Capabilities (табл. 9-153): бит → (группа, ссылка описания)
EXT_CAP_OFF = {4: ('ps', '10.30 PSMP'), 6: ('ps', '10.30 S-PSMP'), 11: ('ps', '11.2.3.14'), 17: ('ps', '11.2.3.16'),
               18: ('ps', '11.2.3.15'), 28: ('ps', '11.2.3.13'), 29: ('ps', '11.2.3.12'), 45: ('ps', '11.2.3.5.2')}
# Capability Information DMG (рис. 9-86)
CAPINFO_OFF = {'triggered_unscheduled_ps': ('ps', '9.4.1.4: BU как RD responder при Power Management = 1')}
# DMG Capabilities (рис. 9-550/9-553): поля, которые НЕ относятся к группам (документировано, правило не трогает)
DMG_CAP_NOT_OFF = {'heartbeat': 'ATI/SP/TXOP (9.4.2.127.2)', 'heartbeat_elapsed': 'то же',
                   'power_source': 'питание от батареи (9.4.2.127.3)', 'pcp_forwarding': 'PBSS, не relay',
                   'decentralized_clustering': 'ref/cluster', 'centralized_clustering': 'ref/cluster'}

# элементы: (Element ID, Ext) → группа
ELEMENT_OFF = {}
for _name, _grp in (('Relay Capabilities', 'relay'), ('Relay Transfer Parameter Set', 'relay'),
                    ('Multiple MAC Sublayers', 'mms'),
                    ('Multi-band', 'fst'), ('Switching Stream', 'fst'), ('Session Transition', 'fst'),
                    ('DMG Wakeup Schedule', 'ps'), ('Awake Window', 'ps'), ('Wakeup Schedule', 'ps'), ('TIM', 'ps'),
                    ('U-APSD Coexistence', 'ps'), ('FMS Descriptor', 'ps'), ('FMS Request', 'ps'),
                    ('FMS Response', 'ps'), ('WNM Sleep Mode', 'ps'), ('TIM Broadcast Request', 'ps'),
                    ('TIM Broadcast Response', 'ps')):
    ELEMENT_OFF[E.element_key(_name)] = (_name, _grp)

# рис. 9-592 — Relay Capability Information
RELAY_CAP = [('relay_supporter', 1), ('relay_client', 1), ('relay_permission', 1), ('ac_power', 1),
             ('relay_preference', 1), ('duplex', 2), ('cooperation', 1), ('_r8', 8)]

# Action: (категория, действие или None — любое) → (имя, группа); табл. 9-51, 9-457, 9-479, 9-425, 9-434
CAT_WNM, CAT_UNPROT_WNM, CAT_DMG, CAT_FST = 10, 11, 16, 18
ACT_PSC_REQ, ACT_PSC_RSP = 0, 1
ACTION_OFF = {(CAT_FST, None): ('Fast Session Transfer', 'fst'),
              (CAT_WNM, 9): ('FMS Request', 'ps'), (CAT_WNM, 10): ('FMS Response', 'ps'),
              (CAT_WNM, 16): ('WNM Sleep Mode Request', 'ps'), (CAT_WNM, 17): ('WNM Sleep Mode Response', 'ps'),
              (CAT_WNM, 18): ('TIM Broadcast Request', 'ps'), (CAT_WNM, 19): ('TIM Broadcast Response', 'ps'),
              (CAT_UNPROT_WNM, 0): ('TIM', 'ps')}
for _a, _n in zip(range(8, 23), ('Relay Search Request', 'Relay Search Response',
                                 'Multi-Relay Channel Measurement Request', 'Multi-Relay Channel Measurement Report',
                                 'RLS Request', 'RLS Response', 'RLS Announcement', 'RLS Teardown', 'Relay Ack Request',
                                 'Relay Ack Response', 'TPA Request', 'TPA Response', 'TPA Report', 'ROC Request',
                                 'ROC Response')):
    ACTION_OFF[(CAT_DMG, _a)] = (_n, 'relay')
# кадры по виду (air_pcap): PS-Poll (9.3.1.5), ATIM (9.3.3.3)
FRAME_OFF = {'PS-Poll': 'ps', 'ATIM': 'ps'}


def _m(group, what):
    return f'{what} — {GROUP_NOTE[group]}'


def check_ext_cap(info):
    """[(группа, сообщение)]: биты PS Extended Capabilities = 1."""
    v = int.from_bytes(bytes(info), 'little')
    return [(g, _m(g, f'Extended Capabilities бит {b} = 1 (табл. 9-153, {ref})')) for b, (g, ref) in
            sorted(EXT_CAP_OFF.items()) if v >> b & 1]


def check_capinfo(ci):
    """ci — dict Capability Information DMG (elements.parse_capinfo_dmg)."""
    return [(g, _m(g, f'Capability Information {k} = 1 ({ref})')) for k, (g, ref) in CAPINFO_OFF.items() if ci.get(k)]


def check_relay_cap(info):
    """Relay Capability Information: ненулевые биты (элемент уже нарушение; биты — для отчёта)."""
    b = bytes(info)
    if len(b) < 2:
        return []
    d = E.unpack(RELAY_CAP, int.from_bytes(b[:2], 'little'))
    return [('relay', _m('relay', f'Relay Capability Information {k} = {x} (рис. 9-592)')) for k, x in d.items()
            if x and not k.startswith('_')]


def check_elements(elements, frame):
    """[(группа, сообщение)] по элементам переданного кадра frame: запрещённые элементы, биты Extended Capabilities
    и Relay Capabilities. elements — [Element]."""
    out = []
    for el in elements:
        key = (el.eid, el.ext)
        if key in ELEMENT_OFF:
            name, g = ELEMENT_OFF[key]
            ext = f'/{el.ext}' if el.ext is not None else ''
            out.append((g, _m(g, f'{frame}: элемент {name} ({el.eid}{ext})')))
            if name == 'Relay Capabilities':
                out += check_relay_cap(el.info)
        if el.eid == 127 and el.ext is None:
            out += [(g, f'{frame}: {m}') for g, m in check_ext_cap(el.info)]
    return out


def check_action(body, src_is_ap):
    """[(группа, сообщение)] для тела Action (с октета Category). PSC Request — только от точки (наша STA его не шлёт);
    PSC Response точки — отказ без DMG Wakeup Schedule."""
    b = bytes(body)
    if len(b) < 2:
        return []
    cat, act = b[0], b[1]
    hit = ACTION_OFF.get((cat, act)) or ACTION_OFF.get((cat, None))
    if hit:
        return [(hit[1], _m(hit[1], f'кадр {hit[0]} (категория {cat}, действие {act})'))]
    if cat == CAT_DMG and act == ACT_PSC_REQ:
        return [('ps', _m('ps', 'кадр Power Save Configuration Request (9.6.19.2)'))]
    if cat == CAT_DMG and act == ACT_PSC_RSP:
        if not src_is_ap:
            return [('ps', _m('ps', 'PSC Response от non-AP STA (9.6.19.3)'))]
        out = []
        if len(b) >= 5 and int.from_bytes(b[3:5], 'little') == E.SUCCESS:
            out.append(('ps', _m('ps', 'PSC Response со Status Code SUCCESS — точка принимает только отказ')))
        try:
            els = E.parse_elements(b[5:])
        except ValueError:
            els = []
        if any(el.eid == E.element_key('DMG Wakeup Schedule')[0] for el in els):
            out.append(('ps', _m('ps', 'PSC Response с DMG Wakeup Schedule')))
        return out
    return []


def check_fc_pm(fc, kind):
    """Power Management = 1 (9.2.4.1.7): у точки — резерв, у STA — PS mode."""
    if getattr(fc, 'pm', 0):
        return [('ps', _m('ps', f'{kind}: Power Management = 1 в Frame Control (9.2.4.1.7)'))]
    return []


def check_frame_kind(kind):
    g = FRAME_OFF.get(kind)
    return [(g, _m(g, f'кадр {kind}'))] if g else []
