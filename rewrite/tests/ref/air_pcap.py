# SPDX-License-Identifier: AGPL-3.0-or-later
"""Захват эфира сниффером узла (регистратор пакетов MAC, PMC; rewrite/docs/CAPTURE.md) → журнал эфира модели.

    recs = read_pcap('ap.pcap', 'AP')                 # записи pcap (Rec), как записал узел
    air = merge([recs_ap, recs_sta])                  # Air: события (AirEv) по TSF точки, калибровка, счётчики
    air.events                                        # [AirEv] — тот же вид, что unit/ref_bridge2.Ev, + флаги знания

Вход — pcap wilmon (radiotap, наносекундный, linktype 127) одного или двух узлов; vendor namespace 02:53:52, версия 4
(CAPTURE.md 5.4). Каждый узел пишет свой TX (заголовки настоящие, тела данных нет — маска без txqos) и свой RX: кадры,
отданные в очередь, — байтами; Ack/BA/RTS/DMG CTS/CF-End/SSW/данные, не отданные в очередь, — синтетические (FC по
слоту парсера, RA/TA восстановлены, Duration 0, тело нулевое; CAPTURE.md 4.2).

Что известно о записи и как это использовано [стенд, t2_11/t2_12 2026-11-04, проверяется при каждом слиянии]:
  - метка RX (`a7`) и TX (`59`) — TSF узла, целые мкс; у ответов, которые MAC шлёт сам, метка TX испорчена (TSF_BAD,
    время pcap = последняя хорошая метка) — такие кадры получают время из записи пира (RX) или только границы;
  - `info0` и у TX, и у RX = длина PSDU с FCS << 6 | б5 агрегация (A-MPDU) | MCS [4:0]: у пар «TX узла — RX пира» поля
    совпадают (длина, MCS), поэтому MCS и длина TX-кадра известны; у A-MPDU TX-запись несёт заголовок первого MPDU
    (BlockAck), пир видит его как данные (слот парсера);
  - точка метки в PPDU не задана документацией. Принято (СПОРНО, см. calibrate): метка TX = момент, который MAC пишет
    в Timestamp DMG Beacon (у всех маяков Timestamp == метка TX), т. е. по 11.1.3.1 начало символа данных с первым
    битом кадра: начало PPDU + PRE[класс модуляции]. Смещение метки RX от метки TX того же PPDU и сдвиг TSF второго
    узла оцениваются по парам кадров, записанных обоими (rx_off — среднее (dt1 + dt2)/2, сдвиг — (dt1 − dt2)/2), а
    когда пар «TX станции — RX точки» почти нет (метки TX MAC испорчены) — сдвиг по ответам MAC в обе стороны
    (RTS → DMG CTS, только метки RX), см. calibrate;
    допущение «точка метки TX одна для всех PPDU класса» влияет только на промежутки между кадрами разных классов
    модуляции (control ↔ SC); промежутки внутри класса от него не зависят.

Слияние: TX узла X и синтетический RX того же PPDU у узла Y — одно событие (заголовок и Duration — из TX, MCS и время —
из того, у кого метка верна). Совпадение: тот же info0 (длина, агрегация, MCS), тот же вид (для не-A-MPDU), время в
пределах MATCH_TOL после калибровки; у TX с испорченной меткой — в границах соседних хороших меток узла X, по порядку.

Флаги события (AirEv): t_ok — время известно (иначе t = None, t_lo/t_hi — границы); dur_ok — Duration настоящий
(есть TX-запись или RX с байтами); body_ok — байты MPDU настоящие и полные; synth — байтов нет вовсе (FC по слоту,
тело нулевое, Duration неизвестен); mcs_ok — MCS известен.
"""
import os
import struct
import sys
from collections import Counter, defaultdict
from fractions import Fraction as Fr
from functools import lru_cache

if __package__ in (None, ''):
    sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
    __package__ = 'ref'

from . import elements as E          # noqa: E402
from . import fields as F            # noqa: E402
from . import timing as T            # noqa: E402
from .timing import BCAST            # noqa: E402

LINKTYPE_RADIOTAP = 127
VENDOR_OUI = b'\x02\x53\x52'
VENDOR_VER = 4
# vendor flags (CAPTURE.md 5.4)
FL_TRUNC, FL_TRAILER, FL_NOLEN, FL_TSF, FL_STATUS, FL_PHY, FL_TA, FL_TA_FIXED = (1 << i for i in range(8))
# sflags (CAPTURE.md 4.2)
SF_SYNTH, SF_RA_OWN, SF_RA_UNKNOWN, SF_TA_PEER, SF_TA_UNKNOWN, SF_BAD_FCS, SF_CDOWN0, SF_TSF_BAD = \
    (1 << i for i in range(8))
SRC_PMC = 7

# ---- Frame Control → вид (802.11-2020 табл. 9-1; Control Frame Extension — табл. 9-2); имена как в ref_bridge2 ----
CFE_NAME = {'poll': 'Poll', 'spr': 'SPR', 'grant': 'Grant', 'dmg_cts': 'DMG CTS', 'dmg_dts': 'DMG DTS',
            'grant_ack': 'Grant Ack', 'ssw': 'SSW', 'ssw_fb': 'SSW-Feedback', 'ssw_ack': 'SSW-Ack'}
CTL_NAME = {8: 'BlockAckReq', 9: 'BlockAck', 10: 'PS-Poll', 11: 'RTS', 12: 'CTS', 13: 'Ack', 14: 'CF-End'}
MGMT_NAME = {0: E.ASSOC_REQ, 1: E.ASSOC_RESP, 2: E.REASSOC_REQ, 3: E.REASSOC_RESP, 4: E.PROBE_REQ,
             5: E.PROBE_RESP, 6: 'Timing Advertisement', 8: 'Beacon', 9: 'ATIM', 10: E.DISASSOC, 11: E.AUTH,
             12: E.DEAUTH, 13: 'Action', 14: 'Action No Ack'}
DATA_NAME = {8: 'Data', 12: 'QoS Null'}                    # табл. 9-1, тип 10: QoS Data, QoS Null
# Action (9.6): категория (табл. 9-51) и действие: Block Ack (табл. 9-376), Unprotected DMG (табл. 9-486), WNM
# (табл. 9-425: DMS Request/Response), Radio Measurement (табл. 9-363), Public (табл. 9-364: ECSA), DMG (табл.
# 9-457: Information Request/Response)
ACTION_NAME = {(3, 0): 'ADDBA Request', (3, 1): 'ADDBA Response', (3, 2): 'DELBA', (20, 1): 'BRP',
               (10, 23): 'DMS Request', (10, 24): 'DMS Response', (20, 0): 'Announce',
               (5, 2): 'Link Measurement Request', (5, 3): 'Link Measurement Report',
               (4, 4): 'Extended Channel Switch Announcement', (16, 2): 'Information Request',
               (16, 3): 'Information Response'}
# адрес TA есть (9.3.1): у всех, кроме Ack, CTS, DMG DTS; DMG Beacon — BSSID на месте A1 (9.3.4.2)
NO_TA = ('Ack', 'CTS', 'DMG DTS')

# Точка метки TX в PPDU (СПОРНО, см. докстроку модуля): начало символа данных с первым битом кадра (11.1.3.1).
# SC: T_STF + T_CE + T_header (20.11.3, рис. 20-4); control: T_STF-CM + T_CE-CM + 40 бит заголовка × 32 чипа
# (20.4.3.3: заголовок 5 октетов идёт перед кадром в первом кодовом слове, бит — 32 чипа Ga32).
PRE = {'control': T.T_STF_CM + T.T_CE_CM + 40 * 32 * T.Tc, 'sc': T.T_STF + T.T_CE + T.T_HEADER}
MATCH_TOL = Fr(3)           # мкс: пара TX↔RX после калибровки (кванты меток ±1 + разброс оценки)
CAL_WINDOW = 30             # мкс: окно поиска пар для калибровки (до калибровки)
EDGE_US = Fr(10000)         # мкс: граница кадра с испорченной меткой у края файла (нет соседней хорошей метки)


ppdu_time = lru_cache(maxsize=None)(T.txtime)     # TXTIME (20.11.3), кэш: длины A-MPDU повторяются


def mode_of(mcs):
    return 'control' if mcs == 0 else 'sc'


def mac(b):
    return ':'.join(f'{x:02x}' for x in bytes(b))


def classify(raw, agg=False):
    """Frame Control → (FrameControl, вид, имя действия). agg — PPDU с A-MPDU: вид 'A-MPDU'."""
    fc = F.parse_fc(raw[:2])
    act = None
    if F.fc_is_cfe(fc):
        k = F.CFE_KIND.get(fc.cfe)
        name = CFE_NAME.get(k, f'CFE {fc.cfe}')
    elif fc.type == F.TYPE_EXT:
        name = 'DMG Beacon' if fc.subtype == F.SUBTYPE_DMG_BEACON else f'Extension {fc.subtype}'
    elif fc.type == F.TYPE_CTRL:
        name = CTL_NAME.get(fc.subtype, f'Control {fc.subtype}')
    elif fc.type == F.TYPE_DATA:
        name = DATA_NAME.get(fc.subtype, f'Data {fc.subtype}')
    else:
        name = MGMT_NAME.get(fc.subtype, f'Mgmt {fc.subtype}')
        if name in ('Action', 'Action No Ack') and len(raw) >= 26:
            act = ACTION_NAME.get((raw[24], raw[25]), f'Action {raw[24]}/{raw[25]}')
            if act == 'BRP':
                name = 'BRP'                         # 9.6.21.3: Action No Ack, Unprotected DMG, BRP
    return fc, ('A-MPDU' if agg else name), name, act


# =====================================================================================================================
# чтение pcap
# =====================================================================================================================
class Rec:
    """Запись pcap. node — метка узла; n — номер в файле; ns — время pcap; tsft — Radiotap TSFT (None — нет / TSF_BAD);
    поля vendor v4 (CAPTURE.md 5.4); raw — MPDU без FCS как записан (у синтетических — FC/RA/TA + нули)."""
    __slots__ = ('node', 'n', 'ns', 'tsft', 'ver', 'src', 'dir', 'flags', 'mcs_rt', 'cid', 'mpdu_len', 'caplen',
                 'ta_raw', 'ta_cid', 'tsf32', 'info0', 'info1', 'status', 'trailer', 'phy', 'slot', 'sflags', 'raw',
                 'kind', 'fkind', 'fc', 'action', 't', 'lo', 'hi', 'ev', 'ra', 'ta')

    @property
    def tx(self):
        return self.dir == 1

    @property
    def synth(self):
        return bool(self.sflags & SF_SYNTH)

    @property
    def tsf_ok(self):
        return self.tsft is not None and not self.sflags & SF_TSF_BAD

    @property
    def length(self):
        """Длина PSDU с FCS (info0[..:6]); без info0 — MPDU + FCS."""
        return self.info0 >> 6 if self.info0 else self.mpdu_len + 4

    @property
    def mcs(self):
        return self.info0 & 31 if self.info0 else None

    @property
    def agg(self):
        return bool(self.info0 >> 5 & 1)

    def _ra(self):
        return mac(self.raw[4:10]) if len(self.raw) >= 10 and self.fkind != 'DMG Beacon' else BCAST

    def _ta(self):
        if self.fkind == 'DMG Beacon':
            return mac(self.raw[4:10]) if len(self.raw) >= 10 else None
        if self.fkind in NO_TA or len(self.raw) < 16:
            return None
        if self.synth and self.sflags & SF_TA_UNKNOWN:
            return None
        return mac(self.raw[10:16])

    def key(self):
        """Ключ сопоставления TX↔RX: длина PSDU, MCS, агрегация; у не-A-MPDU — ещё вид кадра."""
        return (self.length, self.mcs, self.agg, None if self.agg else self.fkind)

    def __repr__(self):
        return (f'{self.node}#{self.n} {"TX" if self.tx else "rx"} {self.kind}'
                f'{" syn" if self.synth else ""} tsf={self.tsft}')


VFMT = '<BBBBBBHHBBIIIII'


def _radiotap(d):
    """(TSFT | None, vendor bytes | None, MPDU)."""
    if len(d) < 8 or d[0] != 0:
        return None, None, d
    it_len, = struct.unpack_from('<H', d, 2)
    present, = struct.unpack_from('<I', d, 4)
    off, p = 8, present
    while p & 0x80000000 and off + 4 <= it_len:
        p, = struct.unpack_from('<I', d, off)
        off += 4
    tsft = None
    if present & 1:
        off = (off + 7) & ~7
        if off + 8 <= it_len:
            tsft, = struct.unpack_from('<Q', d, off)
    v = None
    k = d.find(VENDOR_OUI, 8, it_len)
    if k >= 0 and k + 6 + 60 <= it_len:
        v = d[k + 6:k + 6 + 60]
    return tsft, v, d[it_len:]


def read_pcap(path, node=None):
    """pcap (мкс или нс, radiotap) → [Rec]. Записи без vendor-поля v4 источника PMC пропускаются."""
    node = node or os.path.basename(path)
    raw = open(path, 'rb').read()
    if len(raw) < 24:
        return []
    for e in '<>':
        m, = struct.unpack_from(e + 'I', raw, 0)
        if m in (0xa1b2c3d4, 0xa1b23c4d):
            break
    else:
        raise ValueError(f'{path}: не pcap (pcapng — конвертировать editcap -F pcap)')
    ns = m == 0xa1b23c4d
    lt, = struct.unpack_from(e + 'I', raw, 20)
    if lt != LINKTYPE_RADIOTAP:
        raise ValueError(f'{path}: linktype {lt}, нужен radiotap ({LINKTYPE_RADIOTAP})')
    out, o, n = [], 24, 0
    while o + 16 <= len(raw):
        s, frac, incl, _ = struct.unpack_from(e + 'IIII', raw, o)
        d = raw[o + 16:o + 16 + incl]
        o += 16 + incl
        tsft, v, mpdu = _radiotap(d)
        n += 1
        if v is None or v[0] < VENDOR_VER or v[1] != SRC_PMC or len(mpdu) < 2:
            continue
        r = Rec()
        r.node, r.n, r.ns = node, n - 1, s * 10 ** 9 + (frac if ns else frac * 1000)
        (r.ver, r.src, r.dir, r.flags, r.mcs_rt, r.cid, r.mpdu_len, r.caplen, r.ta_raw, r.ta_cid, r.tsf32, r.info0,
         r.info1, r.status, r.trailer) = struct.unpack_from(VFMT, v, 0)
        r.phy, r.slot, r.sflags = bytes(v[32:56]), v[56], v[57]
        if r.info0 & 31 > 12:
            # DMG MCS — 0–12 (табл. 20-14/20-18): иначе info0 испорчен целиком (стенд 2026-11-14: единичные TX-записи
            # .11 с MCS 13–30 и мусорной длиной у DMG CTS/маяка/CF-End) — как записи без info0
            r.info0 = 0
        r.tsft = tsft if not r.sflags & SF_TSF_BAD else None
        r.raw = bytes(mpdu)
        r.fc, r.kind, r.fkind, r.action = classify(r.raw, r.agg)
        r.t = r.lo = r.hi = r.ev = None
        r.ra, r.ta = r._ra(), r._ta()
        out.append(r)
    return out


# =====================================================================================================================
# событие эфира
# =====================================================================================================================
class AirEv:
    """PPDU на эфире (вид unit/ref_bridge2.Ev + знание полей).
    t/te — начало/конец PPDU, мкс TSF точки (Fraction); None — время неизвестно, t_lo/t_hi — границы начала;
    src — TA (передатчик), dst — RA (DMG Beacon — BCAST); kind — вид ('A-MPDU' — агрегат, first — вид первого MPDU);
    dur — Duration (None — неизвестен); mcs/length — MCS и длина PSDU с FCS; raw — MPDU без FCS (у synth — FC/RA/TA и
    нули); p/err — разбор ref/fields (DMG Beacon, Control Frame Extension); by_mac — ответ MAC (метка TX испорчена).
    tx_node — узел, записавший кадр как свой TX; rx_nodes — узлы, принявшие (записи RX); recs — записи.
    trn — (TRN_LEN, PPDU_TYPE, запрос сопровождения луча, подполя TRN добавлены к PPDU) из TXVECTOR, если известны
    (журнал ядра: 20.9.2.2.3, 10.42.7); запись PMC заголовок PHY не несёт — None."""
    __slots__ = ('i', 't', 'te', 'src', 'dst', 'kind', 'first', 'dur', 'mcs', 'raw', 'fc', 'p', 'err', 'action',
                 'by_mac', 'what', 'mpdus', 'length', 'agg', 't_ok', 't_lo', 't_hi', 't_from', 'dur_ok', 'body_ok',
                 'synth', 'mcs_ok', 'tx_node', 'rx_nodes', 'recs', 'cal_ok', 'trn')

    def __init__(self, **kw):
        for k in self.__slots__:
            setattr(self, k, kw.get(k))

    @property
    def tsort(self):
        return self.t if self.t is not None else self.t_lo

    def flags(self):
        f = []
        if not self.t_ok:
            f.append('T?')
        if self.synth:
            f.append('SYN')
        if not self.dur_ok:
            f.append('DUR?')
        if self.raw is not None and not self.body_ok and not self.synth:
            f.append('TRUNC')
        return ','.join(f)

    def info(self):
        if self.kind in ('DMG Beacon', 'SSW') and self.p is not None:
            return dict(sector=self.p.ssw.sector_id, cdown=self.p.ssw.cdown, antenna=self.p.ssw.antenna_id)
        return {}

    def where(self):
        t = f'{float(self.t):.3f}' if self.t is not None else f'[{float(self.t_lo):.0f}..{float(self.t_hi):.0f}]'
        nodes = (f'{self.tx_node} tx' if self.tx_node else '') + ''.join(f' {n} rx' for n in self.rx_nodes)
        k = f'{self.kind}({self.first or "?"})' if self.agg else self.kind
        return f'#{self.i} @{t} {k} {self.src}->{self.dst} ' \
               f'len={self.length} mcs={self.mcs} dur={self.dur} ' \
               f'[{nodes.strip()}{" " + self.flags() if self.flags() else ""}]'

    def __repr__(self):
        return self.where()


def _parse(kind, raw):
    try:
        if kind == 'DMG Beacon':
            return F.parse_dmg_beacon(raw, with_fcs=False), None
        if kind in CFE_NAME.values():
            return F.parse_frame(raw, with_fcs=False), None
    except (F.FieldError, ValueError, NotImplementedError, IndexError, struct.error) as e:
        return None, str(e)
    return None, None


# =====================================================================================================================
# калибровка времени
# =====================================================================================================================
class Calib:
    """t_эфир (начало PPDU, TSF точки) = метка + off[узел] − PRE[класс] − (rx_off[класс], если RX).
    off[опорный] = 0; rx_off — метка RX минус метка TX одного PPDU (в TSF одного узла); оценки — средние по парам."""
    def __init__(self, ref, off=None, rx_off=None, pre=None, stats=None):
        self.ref, self.other, self.bins, self.bin_us = ref, None, {}, 100_000
        self.bins_n, self.med = {}, Fr(0)
        self.seg, self.main_seg = {}, None           # окно → участок TSF (calibrate), основной участок
        self._keys = None
        self.off = dict(off or {ref: Fr(0)})
        self.rx_off = dict(rx_off or {'control': Fr(0), 'sc': Fr(0)})
        self.pre = dict(pre or PRE)
        self.stats = stats or {}

    def t(self, r):
        if r.tsft is None or r.mcs is None:
            return None
        m = mode_of(r.mcs)
        return Fr(r.tsft) + self.node_off(r.node, r.tsft) - self.pre[m] - (0 if r.tx else self.rx_off[m])

    def _near(self, w):
        """Соседние окна с отсчётами: [предыдущее, следующее] (у края — одно)."""
        if self._keys is None:
            self._keys = sorted(self.bins)
        import bisect
        i = bisect.bisect_left(self._keys, w)
        return [self._keys[j] for j in (i - 1, i) if 0 <= j < len(self._keys)]

    def ok(self, node, tsft):
        """Сдвиг TSF для метки узла надёжен: опорный узел, или окно основного участка TSF с ≥ CAL_MIN_PAIRS
        отсчётами в участке и сдвигом в пределах 1 мкс от основного (до ассоциации TSF станции свой — такие окна
        выпадают); окно без отсчётов — если соседние окна с обеих сторон из основного участка."""
        if node != self.other or not self.bins:
            return True
        w = tsft // self.bin_us
        ws = [w] if w in self.bins else self._near(w)
        if len(ws) < 2 and w not in self.bins:
            return False                   # до первого / после последнего окна с отсчётами — участок неизвестен
        if not self.seg:
            return all(self.bins_n.get(k, 0) >= CAL_MIN_PAIRS and abs(self.bins[k] - self.med) <= 1 for k in ws)
        return all(self.seg.get(k) == self.main_seg and self.bins_n.get(k, 0) >= CAL_MIN_PAIRS
                   and abs(self.bins[k] - self.med) <= 1 for k in ws)

    def node_off(self, node, tsft):
        if node != self.other or not self.bins:
            return self.off.get(node, Fr(0))
        w = tsft // self.bin_us
        o = self.bins.get(w)
        if o is None:
            o = self.bins[min(self._near(w), key=lambda k: abs(k - w))]
        return o

    def __repr__(self):
        return (f'Calib(ref={self.ref}, off={ {k: float(v) for k, v in self.off.items()} }, '
                f'rx_off={ {k: round(float(v), 3) for k, v in self.rx_off.items()} })')


def _q(x, den=100):
    return Fr(round(x * den), den)


def _pairs(tx_recs, rx_recs, window):
    """Пары (tx, rx) по ключу и ближайшей метке в ±window мкс (оба с верной меткой); однозначные — ровно один
    кандидат."""
    idx = defaultdict(list)
    for r in rx_recs:
        if r.tsf_ok and not r.tx:
            idx[r.key()].append(r)
    for v in idx.values():
        v.sort(key=lambda r: r.tsft)
    tss = {k: [q.tsft for q in v] for k, v in idx.items()}
    import bisect
    out = []
    for r in tx_recs:
        if not (r.tx and r.tsf_ok and r.mcs is not None):
            continue
        lst = idx.get(r.key())
        if not lst:
            continue
        ts = tss[r.key()]
        a = bisect.bisect_left(ts, r.tsft - window)
        b = bisect.bisect_right(ts, r.tsft + window)
        c = [q for q in lst[a:b] if q.synth or same_frame(r, q)]
        if len(c) == 1:
            out.append((r, c[0]))
    return out


CAL_BIN = 100_000            # мкс: окно оценки сдвига TSF второго узла (до ассоциации TSF станции свой — меняется)
CAL_MIN_PAIRS = 3
CAL_MIN_TWOWAY = 100         # пар control в обе стороны по меткам TX, чтобы сдвиг брать по ним (иначе — по ответам)
CAL_JUMP = 1                 # мкс: скачок средней окна больше этого — новый участок TSF (синхронизация станции)
RESP = ('RTS', 'DMG CTS')    # запрос и ответ MAC через SIFS для оценки по ответам (оба кадра control, длина 20)


def _resp_pairs(req_recs, resp_recs, window):
    """Обмен «запрос → ответ», у которого обе метки — RX: запрос (RTS), принятый узлом X, и ответ на него (DMG CTS
    от X), принятый пиром Y. → [(запрос rx X, ответ rx Y)], однозначные в обе стороны: ответ в
    [метка запроса, метка запроса + TXTIME(запрос) + window] (сдвиг TSF пира неизвестен), и этот ответ — ближайший
    только к этому запросу."""
    import bisect
    req = sorted((r for r in req_recs if not r.tx and r.tsf_ok and r.fkind == RESP[0] and r.mcs is not None),
                 key=lambda r: r.tsft)
    rsp = sorted((r for r in resp_recs if not r.tx and r.tsf_ok and r.fkind == RESP[1]), key=lambda r: r.tsft)
    ts = [r.tsft for r in rsp]
    cand = {}
    for q in req:
        a = bisect.bisect_left(ts, q.tsft)
        b = bisect.bisect_right(ts, q.tsft + ppdu_time(q.length, q.mcs) + window)
        c = [x for x in rsp[a:b] if q.ta is None or x.ra is None or x.ra == q.ta]
        if len(c) == 1:
            cand.setdefault(id(c[0]), []).append((q, c[0]))
    return [v[0] for v in cand.values() if len(v) == 1]


def calibrate(recs_by_node, ref):
    """Оценка Calib по кадрам, записанным двумя узлами. A — опорный узел (ref), B — второй, off — сдвиг TSF B
    (t_A = метка B + off), rx_off[класс] — метка RX минус метка TX одного PPDU (одинакова у узлов — одно железо).

    Пары «TX одного — RX другого» (обе метки верны) дают по каждому классу модуляции
        d1 = rxA − txB = rx_off + off,         d2 = rxB − txA = rx_off − off.
    Одно направление не разделяет rx_off и off. У MAC обоих узлов почти все свои TX-метки испорчены (TSF_BAD: RTS,
    DMG CTS, BlockAck, CF-End, SSW); верны метки маяков и CF-End точки (d2 — сотни пар в каждой записи), а d1 есть
    лишь тогда, когда у STA случайно верна метка TX (0–7 CF-End на запись) — по ним оценка зависит от случая: ноль пар
    давал off = rx_off = 0 (ошибка 4.5 мкс у всех событий со временем по RX станции), несколько пар — сдвиг ± 0.5 мкс
    скачками по окнам. Поэтому сдвиг off берётся
      1) по меткам TX в обе стороны, если пар control ≥ CAL_MIN_TWOWAY в обоих направлениях: off = (d1 − d2)/2;
      2) иначе по ответам MAC в обе стороны (только метки RX, rx_off сокращается): RTS узла X, принятый Y, и DMG
         CTS Y, принятый X — G_Y = rxX(CTS) − rxY(RTS) = TXTIME(RTS) + SIFS_Y ± off; off = (G_B − G_A)/2 при равном
         времени ответа DMG CTS у обоих узлов (одно железо MAC; на стенде ajc4 с парами в обе стороны оба способа
         дают 2.92 мкс). Это допущение: «кто из узлов отвечает позже» по DMG CTS при нём не различается —
         air_judge сообщает сумму SIFS_A + SIFS_B (calibration_free_sum), она от калибровки не зависит.
    Затем rx_off[класс] = d2 + off и/или d1 − off (по окнам, где есть и то и другое; сдвиг TSF сокращается, если он
    меняется между окнами). Сдвиг TSF по окнам CAL_BIN: отсчёты d1 − rx_off и rx_off − d2 (control), окна —
    средние; соседние окна, средние которых отличаются не больше CAL_JUMP, — один участок (TSF станции после
    синхронизации ведёт себя как один отсчёт: на стенде d2 не зависит от времени от маяка в пределах 0.15 мкс за
    BI), сдвиг окна = среднее его участка (медиана целых меток давала скачки на 1 мкс между окнами). Один узел —
    rx_off = 0."""
    nodes = list(recs_by_node)
    cal = Calib(ref)
    if len(nodes) < 2:
        cal.stats['note'] = 'один узел: rx_off не оценено (0), сдвиг TSF не нужен'
        return cal
    other = [n for n in nodes if n != ref][0]
    A, B = recs_by_node[ref], recs_by_node[other]
    # окна — по метке второго узла: в ней Calib.node_off ищет сдвиг
    d1 = defaultdict(lambda: defaultdict(list))       # класс → окно → [rxA − txB]
    d2 = defaultdict(lambda: defaultdict(list))       # класс → окно → [rxB − txA]
    for tx, rx in _pairs(B, A, CAL_WINDOW):
        d1[mode_of(tx.mcs)][tx.tsft // CAL_BIN].append(rx.tsft - tx.tsft)
    for tx, rx in _pairs(A, B, CAL_WINDOW):
        d2[mode_of(tx.mcs)][rx.tsft // CAL_BIN].append(rx.tsft - tx.tsft)
    g_a = defaultdict(list)       # отвечает A: rxB(CTS A) − rxA(RTS B) = TXTIME + SIFS_A − off
    g_b = defaultdict(list)       # отвечает B: rxA(CTS B) − rxB(RTS A) = TXTIME + SIFS_B + off
    for q, x in _resp_pairs(A, B, CAL_WINDOW):
        g_a[x.tsft // CAL_BIN].append(x.tsft - q.tsft)
    for q, x in _resp_pairs(B, A, CAL_WINDOW):
        g_b[q.tsft // CAL_BIN].append(x.tsft - q.tsft)
    st = {}

    def mean(v):
        return sum(v) / len(v)

    def nsum(d):
        return sum(len(v) for v in d.values())

    # 1. rx_off[control] (и сдвиг по окнам, где он оценивается без rx_off)
    c1, c2 = d1['control'], d2['control']
    off_w = {}                                         # окно → (сдвиг, вес) без rx_off
    if nsum(c1) >= CAL_MIN_TWOWAY and nsum(c2) >= CAL_MIN_TWOWAY:
        method = 'метки TX в обе стороны'
        for w in c1:
            if w in c2:
                off_w[w] = ((mean(c1[w]) - mean(c2[w])) / 2, min(len(c1[w]), len(c2[w])))
    elif g_a and g_b:
        method = f'ответы MAC в обе стороны ({RESP[0]} → {RESP[1]}, равное время ответа узлов)'
        for w in g_a:
            if w in g_b:
                off_w[w] = ((mean(g_b[w]) - mean(g_a[w])) / 2, min(len(g_a[w]), len(g_b[w])))
    else:
        method = 'метки TX в обе стороны (мало пар)'
        for w in c1:
            if w in c2:
                off_w[w] = ((mean(c1[w]) - mean(c2[w])) / 2, min(len(c1[w]), len(c2[w])))

    def rx_off_of(m, offs):
        """rx_off класса m по окнам с известным сдвигом: d2 + off, d1 − off; → (оценка | None, число отсчётов)."""
        acc, n = 0.0, 0
        for w, (o, _) in offs.items():
            for x in d1[m].get(w, ()):
                acc, n = acc + x - o, n + 1
            for x in d2[m].get(w, ()):
                acc, n = acc + x + o, n + 1
        return (acc / n if n else None), n
    rc, _ = rx_off_of('control', off_w)
    if rc is not None:
        cal.rx_off['control'] = _q(rc)

    # 2. сдвиг TSF по окнам: отсчёты control с известным rx_off; окна → участки
    samples = defaultdict(list)
    r0 = float(cal.rx_off['control'])
    for w, v in c1.items():
        samples[w].extend(x - r0 for x in v)
    for w, v in c2.items():
        samples[w].extend(r0 - x for x in v)
    win = {w: mean(v) for w, v in samples.items()}
    segs = []                                          # [[окна], [отсчёты]]
    for w in sorted(win):
        if segs and abs(win[w] - mean(segs[-1][1])) <= CAL_JUMP:
            segs[-1][0].append(w)
            segs[-1][1].extend(samples[w])
        elif segs and len(samples[w]) < CAL_MIN_PAIRS:
            segs[-1][0].append(w)            # 1–2 отсчёта в стороне (ошибка сопоставления) — не скачок TSF
        else:
            segs.append([[w], list(samples[w])])
    main = max(segs, key=lambda s: len(s[1])) if segs else None
    cal.bins, cal.bins_n, cal.seg = {}, {}, {}
    for i, (ws, v) in enumerate(segs):
        o = _q(mean(v))
        for w in ws:
            cal.bins[w], cal.bins_n[w], cal.seg[w] = o, len(v), i
    cal.main_seg = segs.index(main) if main else None
    cal.med = _q(mean(main[1])) if main else Fr(0)
    cal.bin_us = CAL_BIN
    cal.other = other
    cal.off[other] = cal.med
    if not cal.bins:
        cal.bins, cal.bins_n, cal.seg, cal.main_seg = {0: Fr(0)}, {0: 0}, {0: 0}, 0
        st['note'] = 'нет пар: сдвиг TSF второго узла не оценён (0)'

    # 3. rx_off прочих классов (sc): в обе стороны — без сдвига, иначе с найденным сдвигом окна
    for m in ('control', 'sc'):
        n1, n2 = nsum(d1[m]), nsum(d2[m])
        if m != 'control':
            if n1 >= CAL_MIN_TWOWAY and n2 >= CAL_MIN_TWOWAY:
                acc, k = 0.0, 0
                for w in d1[m]:
                    if w in d2[m]:
                        j = min(len(d1[m][w]), len(d2[m][w]))
                        acc, k = acc + j * (mean(d1[m][w]) + mean(d2[m][w])) / 2, k + j
                r = acc / k if k else None
            else:
                r, _ = rx_off_of(m, {w: (float(cal.node_off(other, w * CAL_BIN)), 0)
                                     for w in set(d1[m]) | set(d2[m])})
            if r is not None:
                cal.rx_off[m] = _q(r)
        else:
            r = rc
        st[m] = dict(pairs_b_to_a=n1, pairs_a_to_b=n2, rx_off=round(r, 3) if r is not None else 'не оценено')
    ga, gb = [x for v in g_a.values() for x in v], [x for v in g_b.values() for x in v]
    st['tsf_method'] = method
    st['resp_pairs'] = dict(ref_answers=len(ga), other_answers=len(gb),
                            sifs_sum_rx_only=(round(mean(ga) + mean(gb) - 2 * float(T.txtime_control(20)), 3)
                                              if ga and gb else None))
    wm = list(win.values()) or [0.0]
    st['tsf_off'] = dict(median=round(float(cal.med), 3), bins=len(win), segments=len(segs),
                         unreliable_bins=sum(1 for w in cal.bins if not cal.ok(other, w * CAL_BIN)),
                         min=round(float(min(cal.bins.values())), 3), max=round(float(max(cal.bins.values())), 3),
                         win_min=round(min(wm), 3), win_max=round(max(wm), 3))
    cal.stats = st
    return cal


# =====================================================================================================================
# слияние
# =====================================================================================================================
class Air:
    """Результат слияния: events — [AirEv] по времени; nodes — {узел: свой MAC}; ap — MAC AP (передатчик DMG Beacon);
    cal — Calib; stats — счётчики (сопоставлено, без пары, MCS TX≠RX, …); recs — {узел: [Rec]}."""
    def __init__(self, events, nodes, ap, cal, stats, recs):
        self.events, self.nodes, self.ap, self.cal, self.stats, self.recs = events, nodes, ap, cal, stats, recs


def own_addr(recs):
    """Свой MAC узла — самый частый TA его TX-кадров (у DMG Beacon — BSSID)."""
    c = Counter(r.ta for r in recs if r.tx and r.ta is not None)
    return c.most_common(1)[0][0] if c else None


def _bounds(recs, cal):
    """Время записей: верная метка → t; испорченная → границы [t предыдущей верной, t следующей верной] в порядке
    файла (порядок записей = порядок меток, CAPTURE.md 4.1)."""
    prev = None
    for r in recs:
        r.t = cal.t(r)
        if r.t is not None:
            prev = r.t
        else:
            r.lo = prev
    nxt = None
    for r in reversed(recs):
        if r.t is not None:
            nxt = r.t
        else:
            r.hi = nxt
    for r in recs:
        if r.t is None:
            # у края файла одной из границ нет — окно EDGE_US в другую сторону
            if r.lo is None:
                r.lo = r.hi - EDGE_US if r.hi is not None else Fr(0)
            if r.hi is None:
                r.hi = r.lo + EDGE_US
            if r.lo > r.hi:
                r.lo, r.hi = r.hi, r.lo


# Байты RX-записи с байтами (не синтетической) того же PPDU отличаются от TX-записи передатчика не только последним
# байтом TA (CAPTURE.md 4): у DMG Beacon — октет 25 (BIC б16..23) и последний октет [стенд t2_12: все 274 маяка] —
# поэтому тождество кадра — по полям, которые одинаковы у TX и RX: FC, адреса (TA без последнего байта), у DMG
# Beacon — Timestamp и поле SSW (CDOWN, сектор), у прочих — заголовок 24 октета (последовательность, адреса).
ID_BYTES = {'DMG Beacon': ((0, 9), (10, 21))}


def same_frame(tx, rx):
    n = min(len(tx.raw), len(rx.raw))
    spans = ID_BYTES.get(tx.fkind, ((0, 2), (4, min(15, n)), (16, min(24, n))))
    return all(tx.raw[a:b] == rx.raw[a:b] for a, b in spans)


def _addr_ok(tx, rx, own_rx):
    """Синтетический RX не противоречит TX: RA_OWN — RA TX = свой адрес приёмника; TA_PEER — TA равны. RX с байтами —
    same_frame."""
    if rx.synth:
        if rx.sflags & SF_RA_OWN and tx.ra not in (own_rx, BCAST) and not tx.agg:
            return False
        if rx.sflags & SF_TA_PEER and tx.ta is not None and rx.ta is not None and tx.ta != rx.ta:
            return False
        return True
    if tx.agg:
        # A-MPDU: TX-запись — первый MPDU (BlockAck при RD), RX-запись с байтами — MPDU данных, отданный в очередь;
        # общее у них — адреса (RA, TA без последнего байта); PPDU уже совпал по длине, MCS и агрегации
        return tx.raw[4:15] == rx.raw[4:15]
    return same_frame(tx, rx)


def _match(tx_recs, rx_recs, own_rx, stats):
    """TX узла X ↔ RX узла Y. С верной меткой — ближайший по времени в ±MATCH_TOL. С испорченной — группами: подряд
    идущие TX одного ключа с одинаковыми границами [lo, hi] (повторы одного кадра, например RTS без ответа) и RX этого
    ключа в границах ±MATCH_TOL после последнего сопоставленного; RX меньше, чем TX, — сопоставляются последним TX
    группы (повтор, на который ответили, — последний; первые попытки не приняты)."""
    import bisect
    by = defaultdict(list)
    for r in rx_recs:
        if not r.tx and r.t is not None:
            by[r.key()].append(r)
    for v in by.values():
        v.sort(key=lambda r: r.t)
    ts = {k: [r.t for r in v] for k, v in by.items()}
    used = set()
    pairs = []

    def take(r, q):
        used.add(id(q))
        pairs.append((r, q))
        stats['matched'] += 1
        if not r.tsf_ok:
            stats['matched_tsf_bad'] += 1
    groups = []
    for r in tx_recs:
        if not r.tx or r.mcs is None:
            continue
        k = r.key()
        lst = by.get(k)
        if not lst:
            continue
        if r.t is not None:
            a = bisect.bisect_left(ts[k], r.t - MATCH_TOL)
            best = None
            for q in lst[a:]:
                if q.t > r.t + MATCH_TOL:
                    break
                if id(q) in used or not _addr_ok(r, q, own_rx):
                    continue
                if best is None or abs(q.t - r.t) < abs(best.t - r.t):
                    best = q
            if best is not None:
                take(r, best)
        elif groups and groups[-1][0] == (k, r.lo, r.hi):
            groups[-1][1].append(r)
        else:
            groups.append(((k, r.lo, r.hi), [r]))
    last = defaultdict(lambda: Fr(-10 ** 18))
    for (k, lo, hi), grp in groups:
        lo2 = max(lo - MATCH_TOL, last[k])
        a = bisect.bisect_left(ts[k], lo2)
        cands = []
        for q in by[k][a:]:
            if q.t > hi + MATCH_TOL:
                break
            if id(q) in used or q.t < lo2 or not _addr_ok(grp[0], q, own_rx):
                continue
            cands.append(q)
            if len(cands) >= len(grp):
                break
        if not cands:
            continue
        sw = _ssw_align(grp, cands)
        if sw is not None:
            for r, q in sw:
                take(r, q)
        else:
            sel = grp[-len(cands):] if len(cands) < len(grp) else grp
            for r, q in zip(sel, cands):
                take(r, q)
        last[k] = cands[-1].t
    return pairs


def _ssw_align(grp, cands):
    """Свип SSW (TX с испорченной меткой, RX пира синтетический — CDOWN не записан): RX с флагом CDOWN0 — кадр с
    CDOWN 0, остальные — по времени: CDOWN = round((t(CDOWN0) − t) / (TXTIME(SSW) + SBIFS)) (10.42.2.2.2: кадры свипа
    через SBIFS). Без CDOWN0 или при неоднозначности — None (обычное сопоставление по порядку)."""
    if grp[0].fkind != 'SSW' or len(grp[0].raw) < 19:
        return None
    a = next((q for q in reversed(cands) if q.sflags & SF_CDOWN0), None)
    if a is None:
        return None
    by_cd = {}
    for r in grp:
        cd = (r.raw[16] >> 1) | ((r.raw[17] & 3) << 7)       # 9.5.1: Direction 1 бит, CDOWN 9 бит (SSW с октета 16)
        by_cd.setdefault(cd, r)
    step = T.txtime_control(grp[0].length) + T.SBIFS
    out, seen = [], set()
    for q in cands:
        x = (a.t - q.t) / step
        cd = round(x)
        if q.t > a.t or abs(x - cd) > Fr(1, 3) or cd not in by_cd or cd in seen:
            continue
        seen.add(cd)
        out.append((by_cd[cd], q))
    return out or None


def _ev_from(recs, nodes_mac, cal=None):
    """Событие по записям одного PPDU (TX — не больше одной)."""
    tx = next((r for r in recs if r.tx), None)
    rxs = [r for r in recs if not r.tx]
    hdr = tx if tx is not None else next((r for r in rxs if not r.synth), rxs[0])
    tr = tx if tx is not None and tx.t is not None else next((r for r in rxs if r.t is not None), None)
    raw = hdr.raw
    full = (not hdr.synth) and not hdr.flags & FL_TRUNC and hdr.caplen >= hdr.mpdu_len
    mcs = next((r.mcs for r in recs if r.mcs is not None), None)
    length = hdr.length
    # вид первого MPDU: из TX-записи или RX с байтами; у синтетического A-MPDU — неизвестен (слот парсера — данные)
    first = hdr.fkind if (tx is not None or not hdr.synth or not hdr.agg) else None
    cal_ok = True
    if tr is not None:
        t = tr.t
        lo = hi = t
        cal_ok = cal is None or cal.ok(tr.node, tr.tsft)
    else:
        b = tx if tx is not None else rxs[0]       # RX с испорченной меткой тоже бывает (CAPTURE.md 4.1)
        t, lo, hi = None, b.lo, b.hi
    te = t + ppdu_time(length, mcs) if t is not None and mcs is not None else None
    src = hdr.ta
    if tx is not None:
        src = nodes_mac.get(tx.node) or hdr.ta
    dst = hdr.ra
    kind = hdr.kind                      # 'A-MPDU' при агрегации (classify)
    p, err = (None, None)
    if full and not hdr.agg:
        p, err = _parse(hdr.fkind, raw)
    # заголовки MPDU этого PPDU, записанные байтами (TX — первый MPDU, RX — MPDU, отданный в очередь): у A-MPDU
    # их может быть два разных (BlockAck впереди у передатчика, данные у приёмника)
    mpdus = []
    for r in ([tx] if tx is not None else []) + rxs:
        if not r.synth and len(r.raw) >= 4 and all(r.raw[:24] != m[:24] for m in mpdus):
            mpdus.append(r.raw)
    return AirEv(t=t, te=te, src=src, dst=dst, kind=kind, first=first, dur=(int.from_bytes(raw[2:4], 'little')
                 if not hdr.synth and len(raw) >= 4 else None), mcs=mcs, raw=raw, fc=hdr.fc, p=p, err=err,
                 action=hdr.action, by_mac=bool(tx is not None and not tx.tsf_ok), what=None, mpdus=mpdus,
                 length=length, agg=hdr.agg, t_ok=t is not None, t_lo=lo, t_hi=hi,
                 t_from=(None if tr is None else ('tx' if tr.tx else 'rx')), dur_ok=not hdr.synth and len(raw) >= 4,
                 body_ok=full, synth=hdr.synth, mcs_ok=mcs is not None, tx_node=tx.node if tx is not None else None,
                 rx_nodes=tuple(r.node for r in rxs), recs=[(r.node, r.n) for r in recs], cal_ok=cal_ok)


def merge(rec_lists, ref=None, cal=None):
    """[[Rec] узла, …] (1 или 2 узла) → Air. ref — опорный узел (TSF точки): по умолчанию передающий DMG Beacon."""
    by_node = {}
    for lst in rec_lists:
        if lst:
            by_node.setdefault(lst[0].node, []).extend(lst)
    nodes_mac = {n: own_addr(v) for n, v in by_node.items()}
    if ref is None:
        bc = {n: sum(1 for r in v if r.tx and r.fkind == 'DMG Beacon') for n, v in by_node.items()}
        ref = max(bc, key=lambda n: bc[n]) if bc else None
    ap = nodes_mac.get(ref) if ref is not None and any(r.tx and r.fkind == 'DMG Beacon' for r in by_node[ref]) \
        else None
    if ap is None:
        c = Counter(r.ta for v in by_node.values() for r in v if r.fkind == 'DMG Beacon' and r.ta)
        ap = c.most_common(1)[0][0] if c else None
    if cal is None:
        cal = calibrate(by_node, ref)
    for v in by_node.values():
        _bounds(v, cal)
    stats = Counter()
    groups = []
    taken = set()
    names = list(by_node)
    if len(names) == 2:
        for x, y in ((names[0], names[1]), (names[1], names[0])):
            for tx, rx in _match(by_node[x], by_node[y], nodes_mac.get(y), stats):
                groups.append([tx, rx])
                taken.add(id(tx))
                taken.add(id(rx))
        # MCS из info0 у TX и у RX пира — одно и то же поле PHY (проверка допущения о TX info0)
        for g in groups:
            if g[0].mcs != g[1].mcs:
                stats['mcs_tx_ne_rx'] += 1
    for n, v in by_node.items():
        for r in v:
            if id(r) not in taken:
                groups.append([r])
                stats[f'{n} {"tx" if r.tx else "rx"} без пары'] += 1
    evs = [_ev_from(g, nodes_mac, cal) for g in groups]
    evs.sort(key=lambda e: (e.tsort, e.recs[0]))
    for i, e in enumerate(evs):
        e.i = i
    stats['events'] = len(evs)
    stats['t_unknown'] = sum(1 for e in evs if not e.t_ok)
    stats['t_cal_unreliable'] = sum(1 for e in evs if e.t_ok and not e.cal_ok)
    return Air(evs, nodes_mac, ap, cal, stats, by_node)


def load(paths, ref=None):
    """['ap.pcap[:AP]', 'sta.pcap[:STA]'] → Air."""
    lists = []
    for p in paths:
        path, _, node = p.partition(':') if ':' in p and not os.path.exists(p) else (p, '', '')
        lists.append(read_pcap(path, node or None))
    return merge(lists, ref=ref)


# =====================================================================================================================
# журналы для судей модели
# =====================================================================================================================
def to_cbap_log(evs, cbap_end=None):
    """События с известным временем → кортежи cbap.check_air_log (t, te, src, dst, kind, Duration, конец CBAP).
    Неизвестный Duration → 0 (NAV по такому кадру не ставится — нарушения 'nav' могут быть пропущены, ложных нет);
    A-MPDU → 'A-MPDU'; QoS Null → 'Data'. Возвращает (log, индексы событий)."""
    log, idx = [], []
    for e in evs:
        if not e.t_ok:
            continue
        kind = {'QoS Null': 'Data'}.get(e.kind, e.kind)
        log.append((e.t, e.te, e.src, e.dst or BCAST, kind, e.dur or 0, cbap_end(e) if cbap_end else None))
        idx.append(e.i)
    return log, idx


def to_bi_log(evs):
    """События с известным временем → кортежи bi.check_air_log (t, te, src, dst, kind, Duration, info)."""
    log, idx = [], []
    for e in evs:
        if not e.t_ok:
            continue
        log.append((e.t, e.te, e.src, e.dst or BCAST, e.kind, e.dur if e.dur_ok else None, e.info()))
        idx.append(e.i)
    return log, idx


def summary(air):
    lines = [f'узлы: {air.nodes}; AP {air.ap}; {air.cal}']
    for k, v in air.cal.stats.items():
        lines.append(f'  калибровка {k}: {v}')
    lines.append('  ' + ', '.join(f'{k}={v}' for k, v in sorted(air.stats.items())))
    c = Counter((e.kind, e.tx_node or '-', ','.join(e.rx_nodes) or '-') for e in air.events)
    for (k, tx, rx), n in sorted(c.items(), key=lambda x: -x[1]):
        lines.append(f'  {k:14s} tx={tx:4s} rx={rx:8s} {n}')
    return '\n'.join(lines)


def main(argv=None):
    import argparse
    ap = argparse.ArgumentParser(description='pcap сниффера узла → журнал эфира модели (сводка и первые события)')
    ap.add_argument('pcap', nargs='+', help='файл[:метка], 1 или 2 узла')
    ap.add_argument('--ref', help='опорный узел (метка), по умолчанию — передающий DMG Beacon')
    ap.add_argument('--dump', type=int, default=0, metavar='N', help='вывести N событий')
    ap.add_argument('--from-us', type=float, default=None, help='--dump: с момента TSF, мкс')
    ap.add_argument('--drift', action='store_true', help='сдвиг TSF второго узла по секундам')
    a = ap.parse_args(argv)
    air = load(a.pcap, a.ref)
    print(summary(air))
    if a.drift:
        print('сдвиг TSF по окнам:', {k: float(v) for k, v in sorted(air.cal.bins.items())})
    evs = air.events
    if a.from_us is not None:
        evs = [e for e in evs if e.tsort >= a.from_us]
    for e in evs[:a.dump]:
        print(e.where())
    return 0


if __name__ == '__main__':
    sys.exit(main())
