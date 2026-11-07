# SPDX-License-Identifier: AGPL-3.0-or-later
"""A-MSDU DMG по 802.11-2020: формат (9.3.2.2 [p. 819–821]: Basic и Short A-MSDU, рис. 9-68, 9-69, 9-71), биты
A-MSDU Present / A-MSDU Type поля QoS Control (9.2.4.5.9, 9.2.4.5.13 [p. 776], табл. 9-11), адреса заголовка
(9.3.2.1.2, табл. 9-30 [p. 816]), пределы (табл. 9-25 [p. 787]: MSDU 7920, A-MSDU 7935 октетов в DMG PPDU; табл.
9-253/9-254 [p. 1241–1242]: число подкадров по DMG Capabilities получателя), правила передачи 10.11 [p. 1715–1717]
(одна пара RA/TA, один TID, без фрагментации, Address 1 — индивидуальный, Short A-MSDU — только после согласования
PTP TSPEC и без пересылки, под соглашением BA — только при A-MSDU Supported = 1 в ADDBA Response, 9.4.1.13 [p. 882],
10.25.2 [p. 1788]), время жизни A-MSDU (10.11), A-MSDU в A-MPDU (10.12.1 [p. 1719]: биты 4 и 8–15 QoS Control
одинаковы; табл. 9-530: данные DMG в A-MPDU — только под соглашением HT-immediate BA; 9.7.3 NOTE 3: предел MPDU 4095
к DMG не применяется), длительность PPDU (10.13 [p. 1724]: не больше aPPDUMaxTime, табл. 20-30).

Состав:
  encode_basic / encode_short / encode(kind, msdus) — тело кадра (A-MSDU) из [Msdu].
  parse(body, kind, complete=True)  — Parsed: подкадры, нарушения формата, усечение записи.
  check_addresses(...)              — DA/SA подкадров против Address 1–4 (табл. 9-30, 10.11, DMS 11.21.16.2).
  check_mpdu(raw, ...)              — QoS Data с A-MSDU целиком (поля QoS Control, адреса, пределы, BA, TSPEC).
  check_ampdu_qos(qos_values)       — 10.12.1: биты 4 и 8–15 у всех QoS Control A-MPDU одинаковы.
  Aggregator                        — генератор: очередь MSDU → A-MSDU по правилам 10.11.
  lifetime_expired, buffer_octets, short_allowed, fits_ppdu, max_amsdu_in_ppdu — величины 10.11/9.4.1.13/10.13.

Не моделируется: Dynamic A-MSDU (9.3.2.2.4 — только S1G, 10.11: «A non-S1G STA … shall not use»), A-MSDU mesh
(рис. 9-70 — mesh не DMG), SPP/PP A-MSDU (табл. 10-12 — HT/S1G), шифрование тела (MPDU шифруется целиком — тело
защищённого кадра не разбирается), GLK/SYNRA (10.65 — не DMG)."""
from collections import namedtuple

from . import elements as E
from . import fields as F
from .timing import aPPDUMaxTime, txtime

BASIC, SHORT = 0, 1                 # 9.2.4.5.13: A-MSDU Type 0 — Basic, 1 — Short
KIND_NAME = {BASIC: 'Basic', SHORT: 'Short'}
MAX_MSDU_DMG = 7920                 # табл. 9-25, столбец DMG PPDU: MSDU size; dot11MaxMSDULength «7920 … DMG STA»
MAX_AMSDU_DMG = 7935                # табл. 9-25, столбец DMG PPDU: A-MSDU size
BASIC_HDR = 14                      # рис. 9-69: DA 6 + SA 6 + Length 2
SHORT_HDR = 2                       # рис. 9-71: Length 2
QOS_DATA_SUBTYPES = (8, 9, 10, 11)  # 9.3.2.2.2: QoS Data, +CF-Ack, +CF-Poll, +CF-Ack +CF-Poll
DMG_DATA_SUBTYPES = (8, 12)         # 9.3.2.1 NOTE 1: DMG STA передаёт только QoS Data и QoS Null
QOS_NULL = 12
AMPDU_SAME_QOS_MASK = 0xFF10        # 10.12.1: «bits 4 and 8–15 of these QoS Control fields shall be identical»

Msdu = namedtuple('Msdu', 'da sa data tid expiry', defaults=(0, None))
Subframe = namedtuple('Subframe', 'off da sa length msdu pad')
Parsed = namedtuple('Parsed', 'kind subframes violations truncated length')


def pad_len(n):
    """Октетов паддинга до кратного 4 (9.3.2.2.2/9.3.2.2.3: «0 to 3 octets of padding»)."""
    return -n % 4


# ---------------------------------------------------------------------------------------------------- кодирование
def _subframe_basic(m, last):
    if len(m.data) > MAX_MSDU_DMG:
        raise F.FieldError([f'MSDU {len(m.data)} > {MAX_MSDU_DMG} октетов (табл. 9-25, DMG)'])
    # 9.3.2.2.2: «The order of these fields and the bits within these fields are the same as the IEEE 802.3 frame
    # format» — Length по порядку IEEE 802.3 (старший октет первым)
    sf = F.mac_bytes(m.da) + F.mac_bytes(m.sa) + len(m.data).to_bytes(2, 'big') + bytes(m.data)
    # «each A-MSDU subframe (except the last) is padded so that its length is a multiple of 4 octets»
    return sf if last else sf + bytes(pad_len(len(sf)))


def _subframe_short(m, last):
    if len(m.data) > MAX_MSDU_DMG:
        raise F.FieldError([f'MSDU {len(m.data)} > {MAX_MSDU_DMG} октетов (рис. 9-71: 0–7920)'])
    # СПОРНО → принято (PLAN.md №26): у Short порядок IEEE 802.3 не оговорён — Length по 9.2.2 (младший октет первым)
    sf = len(m.data).to_bytes(2, 'little') + bytes(m.data)
    # 9.3.2.2.3: паддинг — до кратного 4 длины «excluding the A-MSDU subframe header»
    return sf if last else sf + bytes(pad_len(len(m.data)))


def encode(kind, msdus):
    """[Msdu] → тело QoS Data (A-MSDU). Проверяет предел A-MSDU табл. 9-25 (7935 октетов)."""
    msdus = list(msdus)
    if not msdus:
        raise F.FieldError(['A-MSDU без подкадров (рис. 9-68: A-MSDU subframe 1 … n)'])
    f = _subframe_basic if kind == BASIC else _subframe_short
    body = b''.join(f(m, i == len(msdus) - 1) for i, m in enumerate(msdus))
    if len(body) > MAX_AMSDU_DMG:
        raise F.FieldError([f'A-MSDU {len(body)} > {MAX_AMSDU_DMG} октетов (табл. 9-25, DMG)'])
    return body


def encode_basic(msdus):
    return encode(BASIC, msdus)


def encode_short(msdus):
    return encode(SHORT, msdus)


# ---------------------------------------------------------------------------------------------------- разбор
def parse(body, kind=BASIC, complete=True):
    """Тело (A-MSDU) → Parsed. complete=False — тело может быть усечено записью: неполный хвост не нарушение,
    а truncated=True (проверки «последний без паддинга» и полной длины тогда не делаются)."""
    body = bytes(body)
    hdr = BASIC_HDR if kind == BASIC else SHORT_HDR
    subs, v, i, truncated = [], [], 0, False
    while True:
        if i + hdr > len(body):
            if complete:
                v.append(f'обрезанный заголовок подкадра на смещении {i} (рис. 9-{69 if kind == BASIC else 71})')
            else:
                truncated = True
            break
        if kind == BASIC:
            da, sa = F.mac_str(body[i:i + 6]), F.mac_str(body[i + 6:i + 12])
            ln = int.from_bytes(body[i + 12:i + 14], 'big')
        else:
            da = sa = None
            ln = int.from_bytes(body[i:i + 2], 'little')       # PLAN.md №26
        if ln > MAX_MSDU_DMG:
            v.append(f'подкадр {len(subs) + 1}: Length {ln} > {MAX_MSDU_DMG} (табл. 9-25, DMG)')
        end = i + hdr + ln
        if end > len(body):
            if complete:
                v.append(f'подкадр {len(subs) + 1}: Length {ln} выходит за конец тела ({len(body) - i - hdr} октетов)')
            else:
                truncated = True
            break
        rem = len(body) - end
        p = pad_len(end - i if kind == BASIC else ln)
        if rem == 0:
            subs.append(Subframe(i, da, sa, ln, body[i + hdr:end], 0))   # последний: «has no padding»
            break
        if rem < p + hdr:
            if complete:
                v.append(f'подкадр {len(subs) + 1}: за ним {rem} октетов — не подкадр; '
                         + ('у последнего подкадра паддинг запрещён (9.3.2.2.2/9.3.2.2.3: «The last A-MSDU subframe '
                            'has no padding»)' if rem <= 3 else 'обрезанный следующий подкадр'))
                subs.append(Subframe(i, da, sa, ln, body[i + hdr:end], rem if rem <= 3 else 0))
            else:
                subs.append(Subframe(i, da, sa, ln, body[i + hdr:end], p))
                truncated = True
            break
        subs.append(Subframe(i, da, sa, ln, body[i + hdr:end], p))
        i = end + p
    if not subs and not truncated:
        v.append('A-MSDU без подкадров (рис. 9-68)')
    if len(body) > MAX_AMSDU_DMG:
        v.append(f'A-MSDU {len(body)}{"+" if truncated else ""} > {MAX_AMSDU_DMG} октетов (табл. 9-25, DMG)')
    return Parsed(kind, subs, v, truncated, None if truncated else len(body))


# ---------------------------------------------------------------------------------------------------- адреса
def check_addresses(fc, a1, a2, a3, a4, subframes, kind, bssid=None, ra_is_pcp_fwd=False, ta_is_pcp_fwd=False):
    """Табл. 9-30 и 10.11 для MPDU с A-MSDU. Возвращает (нарушения, [Subframe с групповым DA]): групповой DA в
    индивидуально адресованном A-MSDU к получателю (To DS/From DS 0/1 или 0/0) — только DMS (11.21.16.2: «A-MSDU
    subframe headers' DA set to the multicast address»), это проверяет судья dms. bssid — если известен. Пересылка через
    PCP (10.11, PBSS, PCP Forwarding = 1; PLAN.md №28): ra_is_pcp_fwd — RA = такой PCP (DA подкадров — любые, «the
    destination's individual or group address»), ta_is_pcp_fwd — TA = такой PCP (SA подкадров — исходные)."""
    v, groups = [], []
    if F.is_group(a1):
        # 10.11: «In non-GLK transmissions, the Address 1 field … shall be set to an individual address or to the GCR
        # concealment address»; GCR у DMG нет (11.21.16.1), GLK — не DMG
        v.append(f'Address 1 {a1} групповой у MPDU с A-MSDU (10.11)')
    td = (fc.to_ds, fc.from_ds)
    if kind == SHORT:
        # 10.11: Short — «only MSDUs whose SA and DA parameter values are the same», «only between a pair of STAs that
        # communicate directly», «cannot be used for frame forwarding» (PLAN.md №27): DA/SA — из заголовка как у MSDU
        # (табл. 9-30, столбец «MSDU and Short A-MSDU»), и они должны быть RA/TA
        fwd = td == (1, 1) or (td == (0, 1) and a3 != a2) or (td == (1, 0) and a3 != a1)
        if fwd:
            v.append(f'Short A-MSDU с пересылкой (To DS/From DS {td[0]}/{td[1]}, Address 3 {a3}) — 10.11: «cannot be '
                     f'used for frame forwarding»')
        return v, groups
    # Basic: Address 3 (и 4 при 1/1) — BSSID (табл. 9-30, столбцы «Basic A-MSDU»)
    want_bssid = {(0, 0): bssid, (0, 1): a2, (1, 0): a1, (1, 1): bssid}[td]
    if want_bssid is not None and a3 != want_bssid:
        v.append(f'Address 3 {a3} ≠ BSSID {want_bssid} (табл. 9-30, Basic A-MSDU)')
    if td == (1, 1) and a4 is not None and a3 is not None and a4 != a3:
        v.append(f'Address 4 {a4} ≠ BSSID {a3} (табл. 9-30, Basic A-MSDU)')
    for k, s in enumerate(subframes, 1):
        if td in ((0, 0), (0, 1)) and not ra_is_pcp_fwd:
            if F.is_group(s.da):
                groups.append(s)
            elif s.da != a1:
                # 9.3.2.2.2: DA подкадров «map to the same receiver address (RA)»; при 0/0 и 0/1 RA = DA (табл. 9-30,
                # NOTE 1 — исключение только DMS и S1G relay)
                v.append(f'подкадр {k}: DA {s.da} ≠ RA {a1} (табл. 9-30: RA = DA)')
        if td in ((0, 0), (1, 0)) and s.sa != a2 and not ta_is_pcp_fwd:
            # 9.3.2.2.2: SA — «map to the same … transmitter address (TA)»; при 0/0 и 1/0 TA = SA (табл. 9-30, NOTE 2 —
            # исключение только S1G relay)
            v.append(f'подкадр {k}: SA {s.sa} ≠ TA {a2} (табл. 9-30: TA = SA)')
    return v, groups


# ---------------------------------------------------------------------------------------------------- MPDU целиком
QosFields = namedtuple('QosFields', 'tid eosp ackpol amsdu amsdu_type rdg buffered_ac rsv14 acc raw')


def parse_qos(q):
    """Табл. 9-11 (DMG): B0–B3 TID, B4 EOSP, B5–B6 Ack Policy, B7 A-MSDU Present, B8 A-MSDU Type, B9 RDG/More PPDU,
    B10–B13 Buffered AC, B14 Reserved, B15 AC Constraint."""
    return QosFields(q & 15, q >> 4 & 1, q >> 5 & 3, q >> 7 & 1, q >> 8 & 1, q >> 9 & 1, q >> 10 & 15, q >> 14 & 1,
                     q >> 15 & 1, q)


def encode_qos(tid, ackpol=0, amsdu=0, amsdu_type=BASIC, eosp=0, rdg=0, buffered_ac=0, acc=0):
    if amsdu_type and not amsdu:
        raise F.FieldError(['A-MSDU Type при A-MSDU Present = 0 зарезервировано (9.2.4.5.13)'])
    return (tid | eosp << 4 | ackpol << 5 | amsdu << 7 | amsdu_type << 8 | rdg << 9 | buffered_ac << 10
            | acc << 15).to_bytes(2, 'little')


def encode_mpdu(a1, a2, a3, body, tid=0, kind=BASIC, ackpol=0, to_ds=0, from_ds=0, sn=0, dur=0, a4=None, amsdu=1,
                subtype=8, fn=0, more_frag=0, protected=0):
    """Заголовок QoS Data (рис. 9-63) + тело без FCS. Для генераторов и тестов."""
    fc = F.FrameControl(type=F.TYPE_DATA, subtype=subtype, to_ds=to_ds, from_ds=from_ds, more_frag=more_frag,
                        protected=protected)
    hdr = (F.encode_fc(fc) + dur.to_bytes(2, 'little') + F.mac_bytes(a1) + F.mac_bytes(a2) + F.mac_bytes(a3)
           + ((sn << 4) | fn).to_bytes(2, 'little') + (F.mac_bytes(a4) if to_ds and from_ds else b'')
           + encode_qos(tid, ackpol, amsdu, kind if amsdu else 0))
    return hdr + bytes(body)


Mpdu = namedtuple('Mpdu', 'fc a1 a2 a3 a4 sn fn qos body hdr_len')


def split_mpdu(raw):
    """MPDU данных (без FCS) → Mpdu; None — не QoS Data/QoS Null или заголовок не записан."""
    if raw is None or len(raw) < 26:
        return None
    fc = F.parse_fc(raw[:2])
    if fc.type != F.TYPE_DATA or not fc.subtype & 8:
        return None
    four = fc.to_ds and fc.from_ds
    off = 30 if four else 24
    if len(raw) < off + 2:
        return None
    return Mpdu(fc, F.mac_str(raw[4:10]), F.mac_str(raw[10:16]), F.mac_str(raw[16:22]),
                F.mac_str(raw[24:30]) if four else None, int.from_bytes(raw[22:24], 'little') >> 4, raw[22] & 15,
                parse_qos(int.from_bytes(raw[off:off + 2], 'little')), raw[off + 2:], off + 2)


Check = namedtuple('Check', 'mpdu parsed violations unchecked groups')


def check_mpdu(raw, complete=True, rx_caps=None, ba=None, in_ampdu=False, short_ok=False, bssid=None,
               ra_is_pcp_fwd=False, ta_is_pcp_fwd=False):
    """MPDU QoS Data без FCS → Check(mpdu, parsed, нарушения, причина «не проверяемо» | None, групповые подкадры).
    rx_caps — DmgCapabilities получателя (ref.elements) или None; ba — None (соглашения BA по TID нет / неизвестно)
    или A-MSDU Supported из ADDBA Response получателя; in_ampdu — MPDU в A-MPDU; short_ok — согласован PTP TSPEC с
    A-MSDU Subframe = 1 в запросе и ответе (short_allowed)."""
    m = split_mpdu(raw)
    if m is None:
        return Check(None, None, [], 'не QoS Data / заголовок не записан', [])
    q, v = m.qos, []
    if not q.amsdu:
        if q.amsdu_type:
            v.append('A-MSDU Type = 1 при A-MSDU Present = 0 — зарезервировано (9.2.4.5.13)')
        return Check(m, None, v, None, [])
    if m.fc.subtype == QOS_NULL:
        return Check(m, None, ['A-MSDU Present = 1 у QoS Null (табл. 9-11: B7 у QoS Null Reserved; 9.3.2.2.2 — только '
                               'QoS Data)'], None, [])
    if m.fc.subtype not in DMG_DATA_SUBTYPES:
        v.append(f'подтип данных {m.fc.subtype} у DMG STA (9.3.2.1 NOTE 1: только QoS Data и QoS Null)')
    if m.fn or m.fc.more_frag:
        # 10.11: «An A-MSDU shall be carried, without fragmentation, within a single QoS Data frame»
        v.append(f'A-MSDU фрагментирован (Fragment Number {m.fn}, More Fragments {m.fc.more_frag}) — 10.11')
    if q.amsdu_type == SHORT and not short_ok:
        # 10.11: «Prior to PTP TSPEC negotiation, a STA shall use the Basic A-MSDU subframe format»
        v.append('Short A-MSDU без согласованного PTP TSPEC с A-MSDU Subframe = 1 (10.11)')
    if ba is not None and not ba:
        # 10.11: «shall not transmit an A-MSDU within a QoS Data frame under a block ack agreement unless the recipient
        # indicates support for A-MSDU by setting the A-MSDU Supported field to 1 … of the ADDBA Response frame»
        v.append(f'A-MSDU под соглашением BA (TID {q.tid}) при A-MSDU Supported = 0 в ADDBA Response (10.11)')
    if in_ampdu and ba is None:
        # 10.12.1 + табл. 9-530: DMG A-MPDU — только Data Enabled Immediate Response, данные — под HT-immediate BA
        v.append(f'A-MSDU в A-MPDU без соглашения BA по TID {q.tid} (10.12.1, табл. 9-530)')
    if m.fc.protected:
        return Check(m, None, v, 'тело зашифровано (9.3.2.2.2: «encrypted as a single unit»)', [])
    p = parse(m.body, q.amsdu_type, complete)
    v += p.violations
    av, groups = check_addresses(m.fc, m.a1, m.a2, m.a3, m.a4, p.subframes, q.amsdu_type, bssid,
                                 ra_is_pcp_fwd, ta_is_pcp_fwd)
    v += av
    if rx_caps is not None:
        lim = (E.MAX_BASIC_AMSDU if q.amsdu_type == BASIC else E.MAX_SHORT_AMSDU).get(
            rx_caps.max_basic_amsdu if q.amsdu_type == BASIC else rx_caps.max_short_amsdu)
        if lim is not None and len(p.subframes) > lim:
            # 10.11: «shall not transmit an A-MSDU that includes a number of Basic (Short) A-MSDU subframes greater
            # than the value indicated … in any DMG Capabilities element sent by the recipient STA»
            v.append(f'{len(p.subframes)}{"+" if p.truncated else ""} подкадров {KIND_NAME[q.amsdu_type]} > {lim} '
                     f'по DMG Capabilities получателя (10.11, табл. 9-{253 if q.amsdu_type == BASIC else 254})')
    return Check(m, p, v, None, groups)


def check_ampdu_qos(qos_values):
    """10.12.1: у всех QoS Control одного A-MPDU биты 4 и 8–15 одинаковы (в DMG: EOSP, A-MSDU Type, RDG/More PPDU,
    Buffered AC, B14, AC Constraint). A-MSDU Present (B7) может различаться."""
    vals = {q & AMPDU_SAME_QOS_MASK for q in qos_values}
    if len(vals) > 1:
        return [f'QoS Control в A-MPDU различаются в битах 4, 8–15: {sorted(hex(x) for x in vals)} (10.12.1)']
    return []


# ---------------------------------------------------------------------------------------------------- величины
def lifetime_expired(now, expiries):
    """10.11: «The expiration of the A-MSDU lifetime timer occurs only when the lifetime timer of all of the constituent
    MSDUs of the A-MSDU have expired». expiry None — без срока."""
    return all(x is not None and now >= x for x in expiries)


def buffer_octets(buffer_size, amsdu_supported):
    """9.4.1.13: буфер — «the maximum size of an MSDU» при A-MSDU Supported = 0, «the maximum size of an A-MSDU
    that is supported by the STA» при 1 (DMG: табл. 9-25)."""
    return buffer_size * (MAX_AMSDU_DMG if amsdu_supported else MAX_MSDU_DMG)


def short_allowed(ptp_tspec):
    """10.11: Short A-MSDU для TID — только по PTP TSPEC с A-MSDU Subframe = 1 и в ADDTS Request, и в ADDTS Response
    («shall not be used … if the A-MSDU subframe field … is 0 either in the ADDTS Request frame or in the ADDTS
    Response»); до согласования — Basic. ptp_tspec — None или (бит запроса, бит ответа)."""
    return ptp_tspec is not None and bool(ptp_tspec[0]) and bool(ptp_tspec[1])


def fits_ppdu(psdu_len, mcs):
    """10.13: «shall not transmit a DMG PPDU that has a duration … greater than aPPDUMaxTime» (табл. 20-30)."""
    return txtime(psdu_len, mcs) <= aPPDUMaxTime


def max_amsdu_in_ppdu(mcs, overhead=26 + 4):
    """Наибольшее A-MSDU (октетов, ≤ 7935), MPDU с которым (заголовок QoS Data + FCS = overhead) один занимает PPDU не
    дольше aPPDUMaxTime (10.13). 0 — не помещается ничего."""
    lo, hi = 0, MAX_AMSDU_DMG
    if not fits_ppdu(overhead, mcs):
        return 0
    while lo < hi:
        mid = (lo + hi + 1) // 2
        if fits_ppdu(overhead + mid, mcs):
            lo = mid
        else:
            hi = mid - 1
    return lo


# ---------------------------------------------------------------------------------------------------- генератор
class Aggregator:
    """Сборка A-MSDU передатчиком по 10.11. Очередь — MSDU одной пары RA/TA (адресация — забота вызывающего:
    «The rules for determining RA and TA are independent of whether the frame body carries an A-MSDU»).
    rx_caps — DmgCapabilities получателя; ba_amsdu — {TID: A-MSDU Supported ответа}; short_tids — TID с
    согласованным Short (short_allowed). Basic по умолчанию (10.11 «Prior to PTP TSPEC negotiation … Basic»)."""

    def __init__(self, rx_caps=None, ba_amsdu=None, short_tids=(), max_len=MAX_AMSDU_DMG):
        self.rx_caps, self.ba_amsdu, self.short_tids = rx_caps, dict(ba_amsdu or {}), set(short_tids)
        self.max_len = min(max_len, MAX_AMSDU_DMG)

    def allowed(self, tid):
        """A-MSDU для TID разрешено: под BA — только при A-MSDU Supported = 1 (10.11)."""
        return self.ba_amsdu.get(tid, 1) == 1

    def limit(self, kind):
        if self.rx_caps is None:
            return None
        return (E.MAX_BASIC_AMSDU.get(self.rx_caps.max_basic_amsdu) if kind == BASIC
                else E.MAX_SHORT_AMSDU.get(self.rx_caps.max_short_amsdu))

    def build(self, queue, now=0):
        """queue — [Msdu] в порядке поступления. → [(kind, [Msdu])]: A-MSDU (kind BASIC/SHORT) или одиночный MSDU
        (kind None). MSDU с истёкшим сроком отбрасываются; A-MSDU — только MSDU одного TID («shall all have the same
        priority parameter value»), не больше предела подкадров получателя и 7935 октетов; порядок MSDU одного TID
        сохраняется."""
        out, cur, cur_tid, cur_len = [], [], None, 0
        hdr = {BASIC: BASIC_HDR, SHORT: SHORT_HDR}

        def flush():
            if cur:
                k = (SHORT if cur_tid in self.short_tids else BASIC) if len(cur) > 1 else None
                out.append((k, list(cur)))
                cur.clear()

        for m in queue:
            if m.expiry is not None and now >= m.expiry:
                continue
            kind = SHORT if m.tid in self.short_tids else BASIC
            add = hdr[kind] + len(m.data)
            lim = self.limit(kind)
            fits = (cur and m.tid == cur_tid and self.allowed(m.tid)
                    and cur_len + pad_len(cur_len if kind == BASIC else len(cur[-1].data)) + add <= self.max_len
                    and (lim is None or len(cur) < lim))
            if not fits:
                flush()
                cur_tid, cur_len = m.tid, 0
            elif kind == BASIC:
                cur_len += pad_len(cur_len)
            else:
                cur_len += pad_len(len(cur[-1].data))
            cur.append(m)
            cur_len += add
        flush()
        return out
