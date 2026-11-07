# SPDX-License-Identifier: AGPL-3.0-or-later
"""TCLAS по 802.11-2020 9.4.2.30 [p. 1078]: все типы классификатора 0–10 (табл. 9-164) — кодек, проверки поля и
сопоставление. User Priority — табл. 9-163; Frame Classifier — рис. 9-303: Classifier Type, Classifier Mask (1 октет;
3 октета у типов 6–9; у типа 10 — нет: рис. 9-327, длины фильтра (Length − 4)/2), Classifier Parameters.

  0 Ethernet (рис. 9-304, 16 октетов поля: SA, DA, Type; маска B0–B2);
  1 TCP/UDP IP (рис. 9-305 IPv4 / 9-306 IPv6 — IPv6 «deprecated and replaced by Classifier Type 4»; маска B0 Version,
    B1 Source IP, B2 Destination IP, B3 Source Port, B4 Destination Port, B5 DSCP, B6 Protocol/Flow Label);
  2 IEEE 802.1Q (рис. 9-307: TCI, 2 октета; «Classifier Type 2 is deprecated»);
  3 Filter Offset (рис. 9-308: Filter Offset 2, Filter Value, Filter Mask по (Length − 5)/2; Classifier Mask —
    Reserved);
  4 IP и выше (рис. 9-309/9-310, табл. 9-170; «valid when the Classifier Mask Version bit is 1»; DSCP — 2 старших
    бита Reserved, Flow Label — 4 старших бита Reserved);
  5 IEEE 802.1D/Q (рис. 9-311: PCP 4 LSB, DEI 1 LSB, VID 12 LSB; остальное Reserved; маска B0 PCP, B1 DEI, B2 VID);
  6 MAC-заголовок PV0 (рис. 9-312…9-321; маска — 2-битные Classifier Mask Control табл. 9-165/9-169: LSB —
    сравнивать поле (Match Specification есть), MSB — есть Filter Mask; биты 18–23 Reserved);
  7, 8, 9 — заголовок PV1 (табл. 9-166…9-168) — PV1 только у S1G (9.8): у DMG такой кадр не бывает (вердикт model);
  10 IP extensions (рис. 9-327: Protocol Instance, Protocol Number/Next Header, Filter Value/Mask).

Где у DMG: ADDTS (DMG TSPEC; PTP TSPEC — «always included», 9.4.2.30), DMS (11.21.16.2 — только 0, 1, 4: ref/dms),
ADDBA (табл. 9-360/9-361, «TCLAS (optional)»). HT Control у DMG нет (тип 6: HT Control Match — вердикт model).

Принято (PLAN.md №106): тип 10 без Classifier Mask; Filter Offset — little-endian; PV1-типы и HT Control у DMG — model.

API: parse(info) → Tclas; encode(t) → элемент; check(t, dmg=True) → [(текст, вердикт)]; match(t, msdu=None,
mpdu=None) → bool | None (None — тип/данные не позволяют сравнить)."""
import ipaddress
from collections import namedtuple

from . import elements as E
from . import fields as F

EID_TCLAS = E.element_key('TCLAS')[0]          # 14
UP_RESERVED = range(12, 255)                    # табл. 9-163
CT_RESERVED_MIN = 11                            # табл. 9-164: 11–255 Reserved
DEPRECATED = {2: 'Classifier Type 2 is deprecated'}
# тип 6/7/8/9: порядок полей (бит пары маски) и длина Match Specification
MAC_FIELDS = {
    6: [('Frame Control', 0, 2), ('Duration/ID', 2, 2), ('Address 1', 4, 6), ('Address 2', 6, 6),
        ('Address 3', 8, 6), ('Sequence Control', 10, 2), ('Address 4', 12, 6), ('QoS Control', 14, 2),
        ('HT Control', 16, 4)],
    7: [('Frame Control', 0, 2), ('Address 1 (SID)', 2, 2), ('Address 2 (BSSID)', 4, 6), ('Sequence Control', 6, 2),
        ('Address 3', 8, 6), ('Address 4', 10, 6)],
    8: [('Frame Control', 0, 2), ('Address 1 (BSSID)', 2, 6), ('Address 2 (SID)', 4, 2), ('Sequence Control', 6, 2),
        ('Address 3', 8, 6), ('Address 4', 10, 6)],
    9: [('Frame Control', 0, 2), ('Address 1', 2, 6), ('Address 2', 4, 6), ('Sequence Control', 6, 2)],
}
MAC_MASK_USED = {6: 18, 7: 12, 8: 12, 9: 8}     # число используемых бит маски; старше — Reserved
SIMPLE_MASK_BITS = {0: 3, 1: 7, 2: 1, 4: 8, 5: 3}   # «MSBs that do not point to any classifier parameters are reserved»

Tclas = namedtuple('Tclas', 'up ctype mask params')     # mask — int (тип 10: None); params — dict по типу


# ------------------------------------------------------------------------------------------------------- кодек
def mask_len(ctype):
    if ctype in (6, 7, 8, 9):
        return 3
    if ctype == 10:
        return 0
    return 1


def parse(info):
    """Информация элемента TCLAS → Tclas (params — разобранные параметры)."""
    info = bytes(info)
    if len(info) < 2:
        raise ValueError(f'TCLAS: {len(info)} октетов < 2 (рис. 9-302: User Priority, Classifier Type)')
    up, ct = info[0], info[1]
    ml = mask_len(ct)
    if len(info) < 2 + ml:
        raise ValueError('TCLAS: нет Classifier Mask (рис. 9-303)')
    mask = int.from_bytes(info[2:2 + ml], 'little') if ml else None
    p = info[2 + ml:]
    return Tclas(up, ct, mask, _parse_params(ct, mask, p, len(info)))


def _need(p, n, what):
    if len(p) < n:
        raise ValueError(f'TCLAS {what}: {len(p)} октетов параметров < {n}')


def _parse_params(ct, mask, p, length):
    if ct == 0:
        if len(p) != 14:
            raise ValueError(f'TCLAS тип 0: Frame Classifier {2 + len(p)} октетов ≠ 16 (рис. 9-304)')
        return dict(sa=F.mac_str(p[0:6]), da=F.mac_str(p[6:12]), type=int.from_bytes(p[12:14], 'big'))
    if ct in (1, 4):
        _need(p, 1, f'тип {ct}')
        ver = p[0]
        if ver == 4:
            n = 16                       # рис. 9-305/9-309: Version … Protocol, Reserved
            if len(p) != n:
                raise ValueError(f'TCLAS тип {ct} IPv4: {2 + len(p)} октетов поля ≠ {2 + n} (рис. '
                                 f'{"9-305" if ct == 1 else "9-309"})')
            return dict(version=4, src=ipaddress.IPv4Address(p[1:5]), dst=ipaddress.IPv4Address(p[5:9]),
                        sport=int.from_bytes(p[9:11], 'big'), dport=int.from_bytes(p[11:13], 'big'), dscp=p[13],
                        proto=p[14], rsv=p[15])
        if ver == 6:
            n = 40 if ct == 1 else 42
            if len(p) != n:
                raise ValueError(f'TCLAS тип {ct} IPv6: {2 + len(p)} октетов поля ≠ {2 + n} (рис. '
                                 f'{"9-306" if ct == 1 else "9-310"})')
            d = dict(version=6, src=ipaddress.IPv6Address(p[1:17]), dst=ipaddress.IPv6Address(p[17:33]),
                     sport=int.from_bytes(p[33:35], 'big'), dport=int.from_bytes(p[35:37], 'big'))
            if ct == 1:
                d['flow'] = int.from_bytes(p[37:40], 'big')
            else:
                d.update(dscp=p[37], next_header=p[38], flow=int.from_bytes(p[39:42], 'big'))
            return d
        return dict(version=ver, raw=bytes(p[1:]))
    if ct == 2:
        if len(p) != 2:
            raise ValueError(f'TCLAS тип 2: Frame Classifier {2 + len(p)} октетов ≠ 4 (рис. 9-307)')
        return dict(tci=int.from_bytes(p, 'big'))
    if ct == 3:
        _need(p, 2, 'тип 3 (Filter Offset)')
        rest = p[2:]
        if (length - 5) < 0 or len(rest) % 2 or len(rest) != length - 5:
            raise ValueError(f'TCLAS тип 3: Filter Value и Filter Mask {len(rest)} октетов — не 2 × (Length − 5)/2 '
                             f'(9.4.2.30)')
        n = len(rest) // 2
        return dict(offset=int.from_bytes(p[0:2], 'little'), value=bytes(rest[:n]), fmask=bytes(rest[n:]))
    if ct == 5:
        if len(p) != 4:
            raise ValueError(f'TCLAS тип 5: Frame Classifier {2 + len(p)} октетов ≠ 6 (рис. 9-311)')
        return dict(pcp=p[0], dei=p[1], vid=int.from_bytes(p[2:4], 'big'))
    if ct in MAC_FIELDS:
        out, i = {}, 0
        for name, bit, n in MAC_FIELDS[ct]:
            ctl = mask >> bit & 3
            if not ctl & 1:
                if ctl & 2:
                    raise ValueError(f'TCLAS тип {ct}: {name} — Filter Mask без сравнения поля (Classifier Mask '
                                     f'Control {ctl:02b})')
                continue
            m = p[i:i + n]
            i += n
            fm = None
            if ctl & 2:
                fm = p[i:i + n]
                i += n
            if len(m) != n or (fm is not None and len(fm) != n):
                raise ValueError(f'TCLAS тип {ct}: {name} — Match Specification обрезана (рис. 9-312…9-326)')
            out[name] = (bytes(m), bytes(fm) if fm is not None else None)
        if i != len(p):
            raise ValueError(f'TCLAS тип {ct}: {len(p) - i} лишних октетов после Match Specification')
        return out
    if ct == 10:
        _need(p, 2, 'тип 10')
        rest = p[2:]
        if len(rest) % 2 or len(rest) != length - 4:
            raise ValueError(f'TCLAS тип 10: Filter Value и Filter Mask {len(rest)} октетов — не 2 × (Length − 4)/2 '
                             f'(9.4.2.30)')
        n = len(rest) // 2
        return dict(instance=p[0], proto=p[1], value=bytes(rest[:n]), fmask=bytes(rest[n:]))
    return dict(raw=bytes(p))


def encode(up, ctype, mask=0, params=b''):
    """Элемент TCLAS из полей (params — октеты Classifier Parameters как в рисунке)."""
    ml = mask_len(ctype)
    return E.encode_element(EID_TCLAS, bytes([up, ctype]) + (mask.to_bytes(ml, 'little') if ml else b'')
                            + bytes(params))


def eth(da, sa=None, ethertype=None, up=255):
    mask = 2 | (1 if sa is not None else 0) | (4 if ethertype is not None else 0)
    return encode(up, 0, mask, F.mac_bytes(sa or '00:00:00:00:00:00') + F.mac_bytes(da)
                  + (ethertype or 0).to_bytes(2, 'big'))


def ip4(ctype, dst, src='0.0.0.0', sport=0, dport=0, dscp=0, proto=0, mask=0x7f, up=255):
    p = (bytes([4]) + ipaddress.IPv4Address(src).packed + ipaddress.IPv4Address(dst).packed
         + sport.to_bytes(2, 'big') + dport.to_bytes(2, 'big') + bytes([dscp, proto, 0]))
    return encode(up, ctype, mask, p)


def ip6(dst, src='::', sport=0, dport=0, dscp=0, next_header=0, flow=0, mask=0xff, up=255):
    p = (bytes([6]) + ipaddress.IPv6Address(src).packed + ipaddress.IPv6Address(dst).packed
         + sport.to_bytes(2, 'big') + dport.to_bytes(2, 'big') + bytes([dscp, next_header]) + flow.to_bytes(3, 'big'))
    return encode(up, 4, mask, p)


def vlan(pcp, dei=0, vid=0, mask=7, up=255):
    return encode(up, 5, mask, bytes([pcp, dei]) + vid.to_bytes(2, 'big'))


def offset_filter(offset, value, fmask, up=255):
    if len(value) != len(fmask):
        raise ValueError('тип 3: Filter Value и Filter Mask разной длины (9.4.2.30)')
    return encode(up, 3, 0, offset.to_bytes(2, 'little') + bytes(value) + bytes(fmask))


def ip_ext(proto, value, fmask, instance=0, up=255):
    if len(value) != len(fmask):
        raise ValueError('тип 10: Filter Value и Filter Mask разной длины (9.4.2.30)')
    return encode(up, 10, 0, bytes([instance, proto]) + bytes(value) + bytes(fmask))


def mac_header(fields, up=255, ctype=6):
    """Тип 6 (7–9): fields — {имя поля: (match, filter_mask | None)}."""
    mask, p = 0, b''
    for name, bit, n in MAC_FIELDS[ctype]:
        if name not in fields:
            continue
        m, fm = fields[name]
        if len(m) != n or (fm is not None and len(fm) != n):
            raise ValueError(f'тип {ctype}: {name} — {n} октетов')
        mask |= (1 | (2 if fm is not None else 0)) << bit
        p += bytes(m) + (bytes(fm) if fm is not None else b'')
    return encode(up, ctype, mask, p)


# ---------------------------------------------------------------------------------------------------- проверки
def check(t, dmg=True):
    """Нарушения поля TCLAS передатчика (резерв = 0, 9.2.2; применимость к DMG)."""
    v = []
    if t.up in UP_RESERVED:
        v.append((f'User Priority {t.up} — Reserved (табл. 9-163)', 'ours'))
    if t.ctype >= CT_RESERVED_MIN:
        return v + [(f'Classifier Type {t.ctype} — Reserved (табл. 9-164)', 'ours')]
    if t.ctype in DEPRECATED:
        v.append((f'Classifier Type {t.ctype}: «{DEPRECATED[t.ctype]}» (9.4.2.30)', 'model'))
    if t.ctype in SIMPLE_MASK_BITS:
        n = SIMPLE_MASK_BITS[t.ctype]
        if t.ctype in (1, 4):
            n = {(1, 4): 7, (1, 6): 6, (4, 4): 7, (4, 6): 8}.get((t.ctype, t.params.get('version')), n)
        if t.mask >> n:
            v.append((f'Classifier Mask 0x{t.mask:02x}: биты ≥ {n} без параметров — Reserved (9.4.2.30)', 'ours'))
    p = t.params
    if t.ctype in (1, 4):
        if p.get('version') not in (4, 6):
            v.append((f'тип {t.ctype}: Version {p.get("version")} — не 4 и не 6 (RFC 791 / RFC 8200)', 'ours'))
        if t.ctype == 1 and p.get('version') == 6:
            v.append(('тип 1 для IPv6 — «deprecated and replaced by Classifier Type 4» (9.4.2.30)', 'model'))
        if p.get('dscp', 0) >> 6:
            v.append((f'тип {t.ctype}: DSCP 0x{p["dscp"]:02x} — 2 старших бита ≠ 0 (9.4.2.30)', 'ours'))
        if p.get('version') == 4 and p.get('rsv'):
            v.append((f'тип {t.ctype} IPv4: последний октет (Reserved, рис. 9-305/9-309) = {p["rsv"]}', 'ours'))
        if 'flow' in p and p['flow'] >> 20:
            v.append((f'тип {t.ctype}: Flow Label 0x{p["flow"]:06x} — 4 старших бита Reserved (9.4.2.30)', 'ours'))
        if t.ctype == 4 and not t.mask & 1:
            v.append(('тип 4: бит маски Version = 0 — элемент недействителен («valid when the Classifier Mask Version '
                      'bit is 1»)', 'ours'))
    if t.ctype == 3 and t.mask:
        v.append((f'тип 3: Classifier Mask 0x{t.mask:02x} — Reserved (9.4.2.30)', 'ours'))
    if t.ctype == 5:
        if p['pcp'] >> 4 or p['dei'] >> 1 or p['vid'] >> 12:
            v.append(('тип 5: старшие биты PCP (4), DEI (7) или VID (4) ≠ 0 — Reserved (рис. 9-311)', 'ours'))
    if t.ctype in MAC_FIELDS:
        used = MAC_MASK_USED[t.ctype]
        if t.mask >> used:
            v.append((f'тип {t.ctype}: биты маски ≥ {used} — Reserved (табл. 9-169/9-166…9-168)', 'ours'))
        if t.ctype in (7, 8, 9) and dmg:
            v.append((f'тип {t.ctype} — заголовок PV1 (табл. 9-164); PV1 только у S1G (9.8), у DMG таких MPDU нет',
                      'model'))
        if t.ctype == 6 and dmg and 'HT Control' in p:
            v.append(('тип 6: сравнение HT Control — у DMG HT Control нет (9.2.4.1.10 NOTE)', 'model'))
    return v


def check_in_frame(t, frame):
    """Где TCLAS допустим у DMG: frame ∈ {'addts', 'dms', 'addba'}; DMS — только 0, 1, 4 (11.21.16.2)."""
    if frame == 'dms' and t.ctype not in (0, 1, 4):
        return [(f'TCLAS Classifier Type {t.ctype} в DMS — только 0, 1, 4 (11.21.16.2)', 'ours')]
    return []


# ------------------------------------------------------------------------------------------------ сопоставление
def _masked_eq(data, value, fmask):
    return all((d & m) == (v & m) for d, v, m in zip(data, value, fmask))


def _snap(msdu):
    d = msdu.data
    if len(d) >= 8 and d[:6] == b'\xaa\xaa\x03\x00\x00\x00':
        return int.from_bytes(d[6:8], 'big'), d[8:]
    return None, None


def _vlan_tci(msdu):
    et, rest = _snap(msdu)
    if et == 0x8100 and len(rest) >= 2:
        return int.from_bytes(rest[0:2], 'big')
    return None


def _ip_layers(payload, et):
    """[(протокол, смещение начала его заголовка в payload)] по цепочке IPv4/IPv6 (+ расширения IPv6, IPv6 в IPv4)."""
    out = []
    if et == 0x0800 and len(payload) >= 20 and payload[0] >> 4 == 4:
        ihl = (payload[0] & 15) * 4
        out.append((payload[9], ihl))
        if payload[9] == 41:            # IPv6 в IPv4
            out += [(p, ihl + o) for p, o in _ip_layers(payload[ihl:], 0x86dd)]
        return out
    if et == 0x86dd and len(payload) >= 40 and payload[0] >> 4 == 6:
        nh, off = payload[6], 40
        ext = {0, 43, 44, 51, 60, 135, 139, 140, 253, 254}
        while True:
            out.append((nh, off))
            if nh not in ext or len(payload) < off + 2:
                break
            nxt = payload[off]
            ln = 8 if nh == 44 else (payload[off + 1] + 2) * 4 if nh == 51 else (payload[off + 1] + 1) * 8
            nh, off = nxt, off + ln
    return out


def match(t, msdu=None, mpdu=None):
    """Совпадение MSDU (amsdu.Msdu: da, sa, data — LLC/SNAP + …, tid) или MPDU (байты заголовка) с TCLAS: True/False;
    None — тип/данные не позволяют (типы 7–9 у DMG, UP 8–11 без AC)."""
    if msdu is not None and t.up <= 7 and getattr(msdu, 'tid', None) is not None and msdu.tid != t.up:
        return False
    p = t.params
    if t.ctype == 0 and msdu is not None:
        et, _ = _snap(msdu)
        return ((not t.mask & 1 or msdu.sa == p['sa']) and (not t.mask & 2 or msdu.da == p['da'])
                and (not t.mask & 4 or et == p['type']))
    if t.ctype in (1, 4) and msdu is not None:
        from . import dms as DM
        pk = DM._msdu_ip(msdu.data)
        if pk is None:
            return False
        ver, src, dst, proto, sp, dp, dscp = pk
        if t.ctype == 4 and not t.mask & 1:
            return False
        checks = [(1, ver == p.get('version')), (2, src == p.get('src')), (4, dst == p.get('dst')),
                  (8, sp == p.get('sport')), (16, dp == p.get('dport'))]
        if p.get('version') == 4:
            checks += [(32, dscp == p.get('dscp', 0) & 63), (64, proto == p.get('proto'))]
        elif t.ctype == 4:
            checks += [(32, dscp == p.get('dscp', 0) & 63), (64, proto == p.get('next_header'))]
        return all(ok for bit, ok in checks if t.mask & bit)
    if t.ctype == 2 and msdu is not None:
        tci = _vlan_tci(msdu)
        return tci is not None and (not t.mask & 1 or tci == p['tci'])
    if t.ctype == 5 and msdu is not None:
        tci = _vlan_tci(msdu)
        if tci is None:
            return False
        ok = [(1, tci >> 13 == p['pcp'] & 15), (2, tci >> 12 & 1 == p['dei'] & 1), (4, tci & 0xfff == p['vid'] & 0xfff)]
        return all(o for bit, o in ok if t.mask & bit)
    if t.ctype == 3 and msdu is not None:
        d = msdu.data[p['offset']:p['offset'] + len(p['value'])]
        return len(d) == len(p['value']) and _masked_eq(d, p['value'], p['fmask'])
    if t.ctype == 10 and msdu is not None:
        et, payload = _snap(msdu)
        if payload is None:
            return False
        hits = [off for proto, off in _ip_layers(payload, et) if proto == p['proto']]
        if len(hits) <= p['instance']:
            return False
        d = payload[hits[p['instance']]:hits[p['instance']] + len(p['value'])]
        return len(d) == len(p['value']) and _masked_eq(d, p['value'], p['fmask'])
    if t.ctype == 6 and mpdu is not None:
        return _match_mac(p, mpdu)
    return None


def _mac_field(mpdu, name):
    fc = F.parse_fc(mpdu[:2])
    a4 = fc.type == F.TYPE_DATA and fc.to_ds and fc.from_ds
    off = {'Frame Control': 0, 'Duration/ID': 2, 'Address 1': 4, 'Address 2': 10, 'Address 3': 16,
           'Sequence Control': 22}
    if name in off:
        n = 6 if name.startswith('Address') else 2
        return mpdu[off[name]:off[name] + n]
    if name == 'Address 4':
        return mpdu[24:30] if a4 else None
    if name == 'QoS Control':
        o = 30 if a4 else 24
        return mpdu[o:o + 2] if fc.type == F.TYPE_DATA and fc.subtype & 8 else None
    if name == 'HT Control':
        return None                          # у DMG нет (9.2.4.1.10)
    return None


def _match_mac(p, mpdu):
    for name, (m, fm) in p.items():
        d = _mac_field(mpdu, name)
        if d is None or len(d) != len(m):
            return False                     # «an MPDU that does not include the optional field is not a matching MPDU»
        if not _masked_eq(d, m, fm if fm is not None else b'\xff' * len(m)):
            return False
    return True
