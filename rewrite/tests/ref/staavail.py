# SPDX-License-Identifier: AGPL-3.0-or-later
"""STA Availability по 802.11-2020: элемент 9.4.2.132 [p. 1250] (рис. 9-566: STA Info List из n ≥ 1 STA Info;
рис. 9-567: AID 8 бит, CBAP 1, PP Available 1, Reserved 6), правила 10.39.7.1 [p. 1896] («The AP or PCP shall not
transmit Poll frames to a STA whose PP Available field in the STA Availability element is 0»; «may transmit Poll
frames to a STA from which the AP or PCP has not received a STA Availability element with the PP Available field …
equal to 0»). Где: DMG Beacon (табл. 9-45, строка 34), Announce (табл. 9-487, строка 21) — точка о других STA;
non-AP STA — о себе (9.4.2.132: «used by a non-AP and non-PCP STA to inform an AP or PCP about the STA availability»),
у DMG — среди предоставленных элементов Information Request/Response (11.28).

Принято (PLAN.md №100): STA сообщает только свой AID; точка — AID связанных STA (не 0 и не 255: AID AP/PCP — 0,
широковещательный — 255, 9.4.1.8); повтор AID в списке — нарушение. CBAP = 0 означает, что STA не принимает в CBAP
(энергосбережение, 11.2.7) — в open энергосбережения нет, наша STA всегда доступна: CBAP = 0 от нашей STA —
нарушение (вердикт model).

PpAvailability — состояние точки: последнее PP Available от каждой STA; poll_allowed(mac)."""
from collections import namedtuple

from . import elements as E
from .timing import AID_AP_PCP, AID_BROADCAST

EID_STA_AVAILABILITY = E.element_key('STA Availability')[0]       # 145
STA_INFO_LEN = 2

StaInfo = namedtuple('StaInfo', 'aid cbap pp_available rsv')


def encode(infos):
    """[StaInfo | (aid, cbap, pp)] → элемент (рис. 9-566/9-567)."""
    if not infos:
        raise ValueError('STA Availability: STA Info List — «one or more (n) STA Info fields» (9.4.2.132)')
    b = b''
    for x in infos:
        aid, cbap, pp = x[0], x[1], x[2]
        rsv = x[3] if len(x) > 3 else 0
        if not 0 <= aid <= 255 or cbap not in (0, 1) or pp not in (0, 1) or not 0 <= rsv < 64:
            raise ValueError(f'STA Info {x}: поля вне рис. 9-567')
        b += (aid | cbap << 8 | pp << 9 | rsv << 10).to_bytes(2, 'little')
    return E.encode_element(EID_STA_AVAILABILITY, b)


def parse(info):
    if not info or len(info) % STA_INFO_LEN:
        raise ValueError(f'STA Availability: Length {len(info)} — не n × 2, n ≥ 1 (рис. 9-566)')
    out = []
    for i in range(0, len(info), 2):
        v = int.from_bytes(info[i:i + 2], 'little')
        out.append(StaInfo(v & 0xff, v >> 8 & 1, v >> 9 & 1, v >> 10))
    return out


def check(infos, sender_is_ap, own_aid=None, assoc_aids=None, ps=False):
    """Нарушения элемента от передатчика: резерв, AID 0/255, повторы; STA — только свой AID (PLAN.md №100); точка —
    только AID связанных STA (assoc_aids, если известны); CBAP = 0 у STA без энергосбережения (model)."""
    v = []
    seen = set()
    for x in infos:
        if x.rsv:
            v.append((f'STA Info AID {x.aid}: Reserved = {x.rsv} (рис. 9-567)', 'ours'))
        if x.aid in (AID_AP_PCP, AID_BROADCAST):
            v.append((f'STA Info с AID {x.aid} — не AID non-AP STA (9.4.1.8)', 'ours'))
        if x.aid in seen:
            v.append((f'STA Info: AID {x.aid} повторяется', 'ours'))
        seen.add(x.aid)
        if sender_is_ap and assoc_aids is not None and x.aid not in assoc_aids and x.aid not in (0, 255):
            v.append((f'STA Availability точки: AID {x.aid} не связанной STA (9.4.2.132: «other STAs availability»)',
                      'model'))
    if not sender_is_ap:
        if own_aid is not None and any(x.aid != own_aid for x in infos):
            v.append((f'STA Availability non-AP STA с чужим AID ({[x.aid for x in infos]}, свой {own_aid}) — STA '
                      f'сообщает о себе (9.4.2.132; PLAN.md №100)', 'model'))
        if not ps and any(not x.cbap for x in infos if own_aid is None or x.aid == own_aid):
            v.append(('CBAP = 0 у STA без энергосбережения — STA всегда принимает в CBAP (11.2.7 удалён в open; '
                      '9.4.2.132)', 'model'))
    return v


class PpAvailability:
    """10.39.7.1 у точки: последнее PP Available от каждой STA (по её STA Availability)."""
    def __init__(self):
        self.pp = {}

    def on_element(self, sender, sender_aid, infos):
        """Элемент от non-AP STA: учитывается STA Info с её AID (сообщение о себе)."""
        for x in infos:
            if sender_aid is None or x.aid == sender_aid:
                self.pp[sender] = x.pp_available

    def poll_allowed(self, mac):
        """«shall not transmit Poll frames to a STA whose PP Available … is 0»; без элемента — «may»."""
        return self.pp.get(mac, 1) == 1

    def as_map(self):
        return dict(self.pp)
