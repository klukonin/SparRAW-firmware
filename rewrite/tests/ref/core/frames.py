# SPDX-License-Identifier: AGPL-3.0-or-later
"""Кадры ядра: сборка MPDU (без FCS) и PSDU (с FCS, A-MPDU с разделителями), разбор принятого PSDU и вид кадра.

Поля — кодеками эталона (ref/fields, ref/elements, ref/blockack, ref/brp, ref/amsdu, ref/ampdu); здесь только то,
чего в них нет: заголовки кадров управления 9.3.1 (RTS рис. 9-26, Ack рис. 9-28, CF-End рис. 9-34, BlockAck рис. 9-41),
заголовок кадра управления 9.3.3.2 (рис. 9-23), элемент EDCA Parameter Set (9.4.2.28, рис. 9-262/9-295)."""
from collections import namedtuple

from .. import ampdu as AM
from .. import amsdu as AS
from .. import blockack as BA
from .. import elements as E
from .. import fields as F
from ..timing import BCAST

# табл. 9-1: подтипы кадров управления (Type 00)
MGMT_SUBTYPE = {E.ASSOC_REQ: 0, E.ASSOC_RESP: 1, E.REASSOC_REQ: 2, E.REASSOC_RESP: 3, E.PROBE_REQ: 4,
                E.PROBE_RESP: 5, E.DISASSOC: 10, 'Action': 13, 'Action No Ack': 14}
MGMT_NAME = {v: k for k, v in MGMT_SUBTYPE.items()}
# табл. 9-1: Type 01 (Control)
CTL_SUBTYPE = {'BlockAckReq': 8, 'BlockAck': 9, 'RTS': 11, 'Ack': 13, 'CF-End': 14}
CTL_NAME = {v: k for k, v in CTL_SUBTYPE.items()}
CFE_NAME = {'dmg_cts': 'DMG CTS', 'ssw': 'SSW', 'ssw_fb': 'SSW-Feedback', 'ssw_ack': 'SSW-Ack', 'grant': 'Grant',
            'spr': 'SPR', 'poll': 'Poll', 'dmg_dts': 'DMG DTS', 'grant_ack': 'Grant Ack'}
# Action (9.6): (Category, Action) → имя
ACTION_NAME = {(3, 0): 'ADDBA Request', (3, 1): 'ADDBA Response', (3, 2): 'DELBA', (20, 1): 'BRP',
               (5, 2): 'Link Measurement Request', (5, 3): 'Link Measurement Report',
               (16, 2): 'Information Request', (16, 3): 'Information Response'}
QOS_DATA = 8                    # табл. 9-1: Type 10, Subtype 1000 — QoS Data
QOS_NULL = 12                   # табл. 9-1: Type 10, Subtype 1100 — QoS Null (no data)
MGMT_HDR = 24                   # рис. 9-23 (без HT Control: +HTC = 0 у DMG, 9.2.4.1.10)
QOS_HDR = 26                    # рис. 9-63: 24 + QoS Control 2 (Address 4 нет)
FCS_LEN = 4
DELIM = 4                       # 9.7.1: MPDU delimiter


def le(v, n):
    return int(v).to_bytes(n, 'little')


def with_fcs(mpdu):
    """9.2.4.8: FCS — CRC-32 по всему MPDU."""
    return bytes(mpdu) + F.fcs(bytes(mpdu))


def fc_bytes(type_, subtype, to_ds=0, from_ds=0, retry=0):
    return F.encode_fc(F.FrameControl(type=type_, subtype=subtype, to_ds=to_ds, from_ds=from_ds, retry=retry))


# ---------------------------------------------------------------------------------------- 9.3.1 кадры управления
def rts(dur, ra, ta):
    """Рис. 9-26: FC, Duration, RA, TA (16 октетов без FCS)."""
    return fc_bytes(F.TYPE_CTRL, CTL_SUBTYPE['RTS']) + le(dur, 2) + F.mac_bytes(ra) + F.mac_bytes(ta)


def dmg_cts(dur, ra, ta):
    """9.3.1.13, рис. 9-52: Control Frame Extension DMG CTS."""
    return F.encode_frame(F.DmgCts(duration=int(dur), ra=ra, ta=ta), with_fcs=False)


def ack(dur, ra):
    """Рис. 9-28: FC, Duration, RA (10 октетов без FCS)."""
    return fc_bytes(F.TYPE_CTRL, CTL_SUBTYPE['Ack']) + le(dur, 2) + F.mac_bytes(ra)


def cf_end(dur, ra, ta):
    """Рис. 9-34; 9.3.1.6 (DMG): RA — адрес адресата (или широковещательный), TA — передатчик."""
    return fc_bytes(F.TYPE_CTRL, CTL_SUBTYPE['CF-End']) + le(dur, 2) + F.mac_bytes(ra) + F.mac_bytes(ta)


def blockack(dur, ra, ta, tid, ssn, bitmap):
    """Рис. 9-41, Compressed BlockAck (табл. 9-28: Multi-TID 0, Compressed 1, GCR 0 — DMG, 10.25.5): BA Control +
    BA Information (SSC + 8-октетная карта)."""
    return (fc_bytes(F.TYPE_CTRL, CTL_SUBTYPE['BlockAck']) + le(dur, 2) + F.mac_bytes(ra) + F.mac_bytes(ta)
            + BA.encode_ba_control(0, 1, 0, tid) + BA.encode_ba_info(ssn, bitmap))


# ---------------------------------------------------------------------------------------- 9.3.3 кадры управления
def mgmt(kind, dur, a1, a2, a3, sn, body):
    """Рис. 9-23: FC, Duration, A1 (DA), A2 (SA), A3 (BSSID), Sequence Control, тело."""
    return (fc_bytes(F.TYPE_MGMT, MGMT_SUBTYPE[kind]) + le(dur, 2) + F.mac_bytes(a1) + F.mac_bytes(a2)
            + F.mac_bytes(a3) + le(sn << 4, 2) + bytes(body))


def edca_parameter_set(params, qos_info=0):
    """9.4.2.28 (рис. 9-262): QoS Info, Update EDCA Info (резерв, 0), четыре AC Parameter Record (рис. 9-295):
    ACI/AIFSN (AIFSN B0–B3, ACM B4, ACI B5–B6), ECWmin/ECWmax (B0–B3 / B4–B7), TXOP Limit (единицы 32 мкс).
    params — {ACI: (aifsn, cwmin, cwmax, txop_us)}, ACI по табл. 9-153 (0 BE, 1 BK, 2 VI, 3 VO)."""
    info = bytes([qos_info, 0])
    for aci in (0, 1, 2, 3):
        aifsn, cwmin, cwmax, txop = params[aci]
        ecw = lambda cw: (cw + 1).bit_length() - 1                  # noqa: E731  CW = 2^ECW − 1
        assert (1 << ecw(cwmin)) - 1 == cwmin and (1 << ecw(cwmax)) - 1 == cwmax and txop % 32 == 0
        info += bytes([aifsn | aci << 5, ecw(cwmin) | ecw(cwmax) << 4]) + le(txop // 32, 2)
    return E.encode_element(12, info)


def parse_edca_parameter_set(info):
    """→ {ACI: (aifsn, cwmin, cwmax, txop_us)}."""
    out = {}
    for k in range(4):
        r = info[2 + 4 * k:6 + 4 * k]
        out[r[0] >> 5 & 3] = (r[0] & 15, (1 << (r[1] & 15)) - 1, (1 << (r[1] >> 4)) - 1,
                              int.from_bytes(r[2:4], 'little') * 32)
    return out


# ---------------------------------------------------------------------------------------- данные (9.3.2)
def qos_data(dur, a1, a2, a3, sn, payload, to_ds, from_ds, tid=0, ackpol=0, retry=0):
    """Рис. 9-63, QoS Data (Address 4 нет); QoS Control (табл. 9-11): TID, Ack Policy (00 — Normal Ack или Implicit
    BAR в A-MPDU, табл. 9-13), A-MSDU Present 0."""
    m = AS.encode_mpdu(a1, a2, a3, payload, tid=tid, ackpol=ackpol, to_ds=to_ds, from_ds=from_ds, sn=sn, dur=int(dur),
                       amsdu=0)
    if retry:
        m = fc_bytes(F.TYPE_DATA, QOS_DATA, to_ds, from_ds, retry=1) + m[2:]
    return m


def qos_null(dur, a1, a2, a3, sn, to_ds, from_ds, tid=0, retry=0):
    """QoS Null (9.3.2.1, табл. 9-1): заголовок QoS без тела (табл. 9-30: у DMG — только QoS Data/QoS Null);
    Ack Policy Normal Ack (табл. 9-13)."""
    m = qos_data(dur, a1, a2, a3, sn, b'', to_ds, from_ds, tid=tid, retry=retry)
    return fc_bytes(F.TYPE_DATA, QOS_NULL, to_ds, from_ds, retry=retry) + m[2:]


def ampdu_psdu(mpdus):
    """9.7.1: A-MPDU — подкадры «разделитель + MPDU (с FCS) + дополнение до 4 октетов»; у последнего подкадра
    дополнения нет (9.7.1: «except the last»)."""
    out = b''
    for i, m in enumerate(mpdus):
        x = with_fcs(m)
        sub = AM.encode_delim(len(x)) + x
        if i < len(mpdus) - 1:
            sub += bytes(-len(sub) % 4)
        out += sub
    return out


def ampdu_len(mpdu_lens):
    n = 0
    for i, ln in enumerate(mpdu_lens):
        sub = DELIM + ln + FCS_LEN
        n += sub + (-sub % 4 if i < len(mpdu_lens) - 1 else 0)
    return n


def psdu(mpdus, aggregated):
    return ampdu_psdu(mpdus) if aggregated else with_fcs(mpdus[0])


def split_psdu(data, aggregated):
    """Принятый PSDU → [(MPDU без FCS, FCS верна)]; у A-MPDU — по разделителям (9.7.2: подкадр с неверной CRC
    разделителя — поиск следующего по сигнатуре; здесь — прекращение разбора)."""
    data = bytes(data)
    if not aggregated:
        return [(data[:-4], len(data) >= 6 and F.fcs(data[:-4]) == data[-4:])]
    out, i = [], 0
    while i + DELIM <= len(data):
        d = AM.parse_delim(data[i:i + DELIM])
        if AM.check_delim(d):
            break
        x = data[i + DELIM:i + DELIM + d.length]
        out.append((x[:-4], len(x) == d.length and F.fcs(x[:-4]) == x[-4:]))
        i += DELIM + d.length
        i += -i % 4
    return out


# ---------------------------------------------------------------------------------------- вид кадра
Frame = namedtuple('Frame', 'kind raw fc dur ra ta action')


def classify(raw):
    """MPDU (без FCS) → Frame: вид по Frame Control (табл. 9-1, 9-2), Duration, RA (A1), TA (A2, если есть),
    действие кадра Action."""
    fc = F.parse_fc(raw[:2])
    dur = int.from_bytes(raw[2:4], 'little')
    ra = F.mac_str(raw[4:10]) if len(raw) >= 10 else None
    ta = F.mac_str(raw[10:16]) if len(raw) >= 16 else None
    act = None
    if F.fc_is_cfe(fc):
        kind = CFE_NAME.get(F.CFE_KIND.get(fc.cfe), f'CFE {fc.cfe}')
    elif fc.type == F.TYPE_EXT:
        kind = 'DMG Beacon' if fc.subtype == F.SUBTYPE_DMG_BEACON else f'Extension {fc.subtype}'
        ra = BCAST                                  # 9.3.4.2: DMG Beacon — широковещательный
        ta = F.mac_str(raw[4:10])
    elif fc.type == F.TYPE_CTRL:
        kind = CTL_NAME.get(fc.subtype, f'Control {fc.subtype}')
        if kind == 'Ack':
            ta = None
    elif fc.type == F.TYPE_DATA:
        kind = {QOS_DATA: 'QoS Data', QOS_NULL: 'QoS Null'}.get(fc.subtype, f'Data {fc.subtype}')
    else:
        kind = MGMT_NAME.get(fc.subtype, f'Mgmt {fc.subtype}')
        if kind in ('Action', 'Action No Ack') and len(raw) >= 26:
            act = ACTION_NAME.get((raw[24], raw[25]), f'Action {raw[24]}/{raw[25]}')
    return Frame(kind, bytes(raw), fc, dur, ra, ta, act)


def qos_fields(raw):
    """(SN, TID, Ack Policy, Retry) QoS Data."""
    m = AS.split_mpdu(raw)
    return m.sn, m.qos.tid, m.qos.ackpol, m.fc.retry, m.body
