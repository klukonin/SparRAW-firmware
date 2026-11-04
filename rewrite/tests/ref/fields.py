# SPDX-License-Identifier: AGPL-3.0-or-later
"""Поля управления и BF DMG и кадры управления DMG бит-в-бит по 802.11-2020: encode / parse / check.

Охват:
  9.2.2            — порядок бит/октетов (младший бит поля — B0, октеты little-endian), резерв = 0 при передаче.
  9.2.4.1          — Frame Control: рис. 9-3 и рис. 9-4 (Control Frame Extension), табл. 9-1, табл. 9-2.
  9.2.4.8          — FCS (CRC-32 по тексту пункта, побитно), остаток приёмника.
  9.3.1.10–9.3.1.18 — Poll, SPR, Grant, DMG CTS, DMG DTS, SSW, SSW-Feedback, SSW-Ack, Grant Ack.
  9.3.4.2          — DMG Beacon: тело (табл. 9-45), Beacon Interval Control (рис. 9-77), Clustering Control
                     (рис. 9-78/9-79), порядок элементов; 9.4.1.46 DMG Parameters (рис. 9-133, табл. 9-68/9-69).
  9.5.1 SSW field, 9.5.2 Dynamic Allocation Info, 9.5.3 SSW Feedback (рис. 9-848/9-849), 9.5.4 BRP Request,
  9.5.5 BF Control (рис. 9-851/9-852), 9.5.6 Beamformed Link Maintenance (табл. 9-344/9-345).
  Правила установки полей из 10.42.2.2.1/10.42.2.3.1 (Direction), 10.42.2.4 (резерв Sector Select при RXSS),
  10.42.4 (DMG Beacon в BTI).

Представление: значения полей — «сырые» целые как в кадре (например Total Sectors = число − 1); перевод в
смысловые величины — отдельными функциями. Адреса — строки 'aa:bb:cc:dd:ee:ff' (октет 0 — первый на эфире).

parse_*(…, strict=False) — разбирает, резерв игнорирует (9.2.2 «ignored upon reception»); strict=True — бросает
FieldError со списком нарушений (ненулевой резерв, зарезервированные значения, нарушенные правила установки):
это режим проверки кадров, переданных прошивкой. encode_* всегда строгий.

Не моделируется: S1G-форматы FC, Control Wrapper/TACK/VHT NDPA, содержимое элементов DMG Beacon (см. elements.py),
значения Duration (см. duration.py), правила выбора секторов/CDOWN во времени (sls.py/abft.py), CDMG/CMMG-
специфика сверх резервирования."""
from collections import namedtuple
from fractions import Fraction as Fr

from .duration import DUR_MAX
from .timing import (AID_AP_PCP, AID_BROADCAST, ALLOC_CBAP, ALLOC_CBAP_1G08, ALLOC_SP, ALLOC_SP_1G08, BCAST, L_RX_MAX,
                     TX_SECTOR_NOT_SWEPT)


class FieldError(ValueError):
    """Нарушения кодирования; .violations — список строк."""
    def __init__(self, violations):
        self.violations = list(violations)
        super().__init__('; '.join(self.violations))


def _raise_if(viol):
    if viol:
        raise FieldError(viol)


# ---- общая упаковка битовых полей (9.2.2) ----
# 9.2.2: «Bits within numeric fields … increasing order of significance»; «octets … sent … from the octet containing
# the lowest numbered bits». Спецификация — список (имя, ширина) от B0; имя None — Reserved.
def _check_ranges(spec, vals, where):
    viol = []
    for name, w in spec:
        if name is None:
            continue
        x = vals[name]
        if not isinstance(x, int) or not 0 <= x < (1 << w):
            viol.append(f'{where}: {name}={x!r} не помещается в {w} бит')
    return viol


def _pack(spec, vals, nbytes, where):
    _raise_if(_check_ranges(spec, vals, where))
    v, pos = 0, 0
    for name, w in spec:
        if name is not None:
            v |= vals[name] << pos
        pos += w
    assert pos == nbytes * 8, (where, pos)
    return v.to_bytes(nbytes, 'little')


def _unpack(spec, b, nbytes, where):
    """→ (dict значений, маска ненулевых зарезервированных бит)."""
    if len(b) < nbytes:
        raise FieldError([f'{where}: {len(b)} октетов < {nbytes}'])
    v = int.from_bytes(b[:nbytes], 'little')
    out, pos, rsv = {}, 0, 0
    for name, w in spec:
        x = (v >> pos) & ((1 << w) - 1)
        if name is None:
            rsv |= x << pos
        else:
            out[name] = x
        pos += w
    assert pos == nbytes * 8, (where, pos)
    return out, rsv


def _rsv_viol(rsv, where):
    return [f'{where}: ненулевые зарезервированные биты 0x{rsv:x} (9.2.2: «set to 0 upon transmission»)'] if rsv else []


# ---- адреса (9.2.2, рис. 9-1) ----
def mac_bytes(a):
    if isinstance(a, (bytes, bytearray)):
        if len(a) != 6:
            raise FieldError([f'адрес {a!r}: не 6 октетов'])
        return bytes(a)
    parts = a.replace('-', ':').split(':')
    if len(parts) != 6:
        raise FieldError([f'адрес {a!r}: не 6 октетов'])
    return bytes(int(p, 16) for p in parts)


def mac_str(b):
    return ':'.join(f'{x:02x}' for x in b[:6])


def is_group(a):
    """Рис. 9-1: бит 0 октета 0 — Individual/Group."""
    return bool(mac_bytes(a)[0] & 1)


# BCAST, AID_AP_PCP / AID_BROADCAST (9.4.1.8) — timing.py


# =====================================================================================================================
# 9.5.1 — Sector Sweep field (рис. 9-846), 3 октета
# =====================================================================================================================
SSW_SPEC = [('direction', 1), ('cdown', 9), ('sector_id', 6), ('antenna_id', 2), ('rxss_length', 6)]
Ssw = namedtuple('Ssw', 'direction cdown sector_id antenna_id rxss_length', defaults=(0,))
DIR_INITIATOR, DIR_RESPONDER = 0, 1     # 9.5.1: «set to 0 … beamforming initiator and set to 1 … responder»


def check_ssw(f, in_cbap=None, direction=None):
    """in_cbap=False → RXSS Length зарезервировано (9.5.1: «valid only when transmitted in a CBAP and is reserved
    otherwise»); direction — ожидаемое Direction (10.42.2.2.1: ISS → 0; 10.42.2.3.1: RSS → 1)."""
    viol = _check_ranges(SSW_SPEC, f._asdict(), 'SSW')
    if in_cbap is False and f.rxss_length:
        viol.append('SSW: RXSS Length зарезервировано вне CBAP (9.5.1)')
    if direction is not None and f.direction != direction:
        viol.append(f'SSW: Direction={f.direction}, ожидалось {direction} (10.42.2.2.1/10.42.2.3.1)')
    return viol


def encode_ssw(f, **ctx):
    _raise_if(check_ssw(f, **ctx))
    return _pack(SSW_SPEC, f._asdict(), 3, 'SSW')


def parse_ssw(b, strict=False, **ctx):
    d, rsv = _unpack(SSW_SPEC, b, 3, 'SSW')
    f = Ssw(**d)
    if strict:
        _raise_if(check_ssw(f, **ctx))
    return f


def rxss_sweep_length(raw):
    """9.5.1 / 9.5.5: длина приёмного свипа = (RXSS Length + 1) × 2 (кадров SSW)."""
    return (raw + 1) * 2


# =====================================================================================================================
# 9.5.2 — Dynamic Allocation Info field (рис. 9-847), 5 октетов
# =====================================================================================================================
DAI_SPEC = [('tid', 4), ('alloc_type', 3), ('src_aid', 8), ('dst_aid', 8), ('alloc_duration', 16), (None, 1)]
Dai = namedtuple('Dai', 'tid alloc_type src_aid dst_aid alloc_duration')
# 9.5.2: «The AllocationType subfield is defined in 9.4.2.131» → табл. 9-257 (бит 4 — младший бит подполя)
# ALLOC_SP/ALLOC_CBAP/… (табл. 9-257) — timing.py
ALLOC_DUR_MAX = 32767           # 9.5.2: «Possible values range from 0 to 32 767 for an SP allocation and a CBAP»
ALLOC_DUR_SPECIAL = 32768       # 9.5.2 b) «Within current TXOP» и Grant с индивидуальным RA от источника SP
# Контексты Grant (9.5.2): допустимые значения Allocation Duration
GRANT_CTX = {
    'ati_gp': range(0, ALLOC_DUR_MAX + 1),          # «within a Grant frame by an AP or PCP in an ATI or GP»
    'cbap_beyond': range(0, ALLOC_DUR_MAX + 1),     # a) «Beyond current TXOP»
    'cbap_within': range(ALLOC_DUR_SPECIAL, ALLOC_DUR_SPECIAL + 1),   # b) «set to 32 768»
    'sp_bcast': range(0, ALLOC_DUR_MAX + 1),        # «RA set to broadcast address by a source or destination STA»
    'sp_individual': range(ALLOC_DUR_SPECIAL, ALLOC_DUR_SPECIAL + 1),  # «RA … individual address by a source STA»
}


def check_dai(f, frame=None, grant_ctx=None):
    """frame: 'spr' | 'grant' | None. СПОРНО: в 9.5.2 фраза «Possible values range from 0 to 32 767» стоит после
    предложений про SPR и про Grant; читаем как относящуюся к обоим (SPR: 0…32 767), альтернатива — для SPR весь
    16-битный диапазон. Значения 32 769…65 535 нигде не определены — считаем неиспользуемыми (9.2.2)."""
    viol = _check_ranges(DAI_SPEC, f._asdict(), 'DAI')
    if f.alloc_type > ALLOC_CBAP_1G08:
        viol.append(f'DAI: AllocationType={f.alloc_type} зарезервировано (табл. 9-257)')
    d = f.alloc_duration
    if frame == 'spr' and d > ALLOC_DUR_MAX:
        viol.append(f'DAI в SPR: Allocation Duration={d} > {ALLOC_DUR_MAX} (9.5.2)')
    if frame == 'grant':
        if d > ALLOC_DUR_SPECIAL:
            viol.append(f'DAI в Grant: Allocation Duration={d} не определено (9.5.2)')
        if grant_ctx is not None and d not in GRANT_CTX[grant_ctx]:
            viol.append(f'DAI в Grant ({grant_ctx}): Allocation Duration={d} недопустимо (9.5.2)')
    return viol


def encode_dai(f, **ctx):
    _raise_if(check_dai(f, **ctx))
    return _pack(DAI_SPEC, f._asdict(), 5, 'DAI')


def parse_dai(b, strict=False, **ctx):
    d, rsv = _unpack(DAI_SPEC, b, 5, 'DAI')
    f = Dai(**d)
    if strict:
        _raise_if(_rsv_viol(rsv, 'DAI') + check_dai(f, **ctx))
    return f


# =====================================================================================================================
# 9.5.3 — SSW Feedback field: рис. 9-848 (в составе ISS) и рис. 9-849 (иначе), 3 октета
# =====================================================================================================================
FB_ISS_SPEC = [('total_sectors', 9), ('rx_antennas', 2), (None, 5), ('poll_required', 1), (None, 7)]
FB_SPEC = [('sector_select', 6), ('antenna_select', 2), ('snr_report', 8), ('poll_required', 1), (None, 7)]
SswFbIss = namedtuple('SswFbIss', 'total_sectors rx_antennas poll_required', defaults=(0, 0, 0))
SswFb = namedtuple('SswFb', 'sector_select antenna_select snr_report poll_required', defaults=(0, 0, 0, 0))


def total_sectors_in_iss(sectors_per_antenna, responder_rx_antennas):
    """10.42.2.2.1: сумма секторов по всем антеннам × число приёмных антенн ответчика (пример: (4+3+5)×2 = 24)."""
    return sum(sectors_per_antenna) * responder_rx_antennas


def total_sectors_raw(n):
    """9.5.3: «Possible values range from 0 to 511, representing 1 to 512 sectors» → поле = n − 1.
    СПОРНО → принято (PLAN.md «Принятые трактовки» №3): 10.42.2.2.1 «set the Total Sectors in ISS subfield … to the
    total number of sectors» (пример: «is set to 24») — поле = n. Принято 9.5.3 (определение кодирования поля, 2024 —
    без изменений); альтернатива — total_sectors_raw_alt."""
    if not 1 <= n <= 512:
        raise FieldError([f'Total Sectors in ISS: {n} вне 1…512 (9.5.3)'])
    return n - 1


def total_sectors_raw_alt(n):
    """Альтернативное чтение (10.42.2.2.1): поле = n (n ≤ 511)."""
    return n


def snr_report_raw(snr_db):
    """9.5.3: «encoded as 8-bit 2s complement value of 4×(SNR-19) … from –13 dB to 50.75 dB in 0.25 dB steps».
    Требует точного шага 0,25 дБ и диапазона; квантование измерения — snr_quantize."""
    q = Fr(snr_db) * 4 - 76
    if q.denominator != 1 or not -128 <= q <= 127:
        raise FieldError([f'SNR {snr_db} дБ не кодируется (9.5.3: −13…50,75 дБ шагом 0,25)'])
    return int(q) & 0xFF


def snr_from_raw(raw):
    """Обратное к snr_report_raw: Fraction дБ."""
    s = raw - 256 if raw & 0x80 else raw
    return Fr(s, 4) + 19


def snr_quantize(snr_db, mode='nearest'):
    """Перевод измеренного SNR в шаг 0,25 дБ с насыщением на −13 / 50,75 дБ.
    СПОРНО → принято (PLAN.md №6, одно правило для fields и sls.snr_report): 9.5.3 не задаёт округление (2024 —
    тоже); по умолчанию — к ближайшему (половина — вверх), mode='floor' — вниз."""
    q = Fr(snr_db) * 4
    if mode == 'floor':
        n = q.__floor__()
    else:
        n = (q + Fr(1, 2)).__floor__()
    n = max(-52, min(203, n))           # 4×(−13) … 4×50,75
    return Fr(n, 4)


def check_ssw_fb(f, poll_reserved=False, select_reserved=False):
    """poll_reserved — передаёт AP/PCP (9.5.3: Poll Required «reserved when transmitted by an AP or PCP»);
    select_reserved — после RSS c RXSS (10.42.2.4: Sector Select и DMG Antenna Select «are reserved»)."""
    iss = isinstance(f, SswFbIss)
    viol = _check_ranges(FB_ISS_SPEC if iss else FB_SPEC, f._asdict(), 'SSW Feedback')
    if poll_reserved and f.poll_required:
        viol.append('SSW Feedback: Poll Required зарезервировано у AP/PCP (9.5.3)')
    if not iss and select_reserved and (f.sector_select or f.antenna_select):
        viol.append('SSW Feedback: Sector/DMG Antenna Select зарезервированы после RXSS (10.42.2.4)')
    return viol


def encode_ssw_fb(f, **ctx):
    _raise_if(check_ssw_fb(f, **ctx))
    if isinstance(f, SswFbIss):
        return _pack(FB_ISS_SPEC, f._asdict(), 3, 'SSW Feedback (ISS)')
    return _pack(FB_SPEC, f._asdict(), 3, 'SSW Feedback')


def parse_ssw_fb(b, iss, strict=False, **ctx):
    """iss — поле передано «as part of an ISS» (9.5.3): рис. 9-848, иначе рис. 9-849."""
    if iss:
        d, rsv = _unpack(FB_ISS_SPEC, b, 3, 'SSW Feedback (ISS)')
        f = SswFbIss(**d)
    else:
        d, rsv = _unpack(FB_SPEC, b, 3, 'SSW Feedback')
        f = SswFb(**d)
    if strict:
        _raise_if(_rsv_viol(rsv, 'SSW Feedback') + check_ssw_fb(f, **ctx))
    return f


# =====================================================================================================================
# 9.5.4 — BRP Request field (рис. 9-850), 4 октета
# =====================================================================================================================
BRP_SPEC = [('l_rx', 5), ('tx_trn_req', 1), ('mid_req', 1), ('bc_req', 1), ('mid_grant', 1), ('bc_grant', 1),
            ('chan_fbck_cap', 1), ('tx_sector_id', 6), ('other_aid', 8), ('tx_antenna_id', 2), (None, 5)]
BrpReq = namedtuple('BrpReq', 'l_rx tx_trn_req mid_req bc_req mid_grant bc_grant chan_fbck_cap tx_sector_id '
                              'other_aid tx_antenna_id', defaults=(0,) * 10)
# L_RX_MAX (9.5.4, при MID-REQ = 0) и TX_SECTOR_NOT_SWEPT («set to 0x63» → 63, PLAN.md «Принятые трактовки») —
# timing.py.


def trn_r_count(l_rx):
    """9.5.4: «The number of requested TRN-R subfields is equal to the value of the L-RX subfield multiplied by 4»."""
    return 4 * l_rx


def check_brp_req(f):
    viol = _check_ranges(BRP_SPEC, f._asdict(), 'BRP Request')
    if not f.mid_req and f.l_rx > L_RX_MAX:
        viol.append(f'BRP Request: L-RX={f.l_rx} > {L_RX_MAX} зарезервировано при MID-REQ=0 (9.5.4)')
    return viol


def encode_brp_req(f):
    _raise_if(check_brp_req(f))
    return _pack(BRP_SPEC, f._asdict(), 4, 'BRP Request')


def parse_brp_req(b, strict=False):
    d, rsv = _unpack(BRP_SPEC, b, 4, 'BRP Request')
    f = BrpReq(**d)
    if strict:
        _raise_if(_rsv_viol(rsv, 'BRP Request') + check_brp_req(f))
    return f


# =====================================================================================================================
# 9.5.5 — Beamforming Control field: рис. 9-851 и рис. 9-852, 2 октета
# =====================================================================================================================
BFC_TXSS_SPEC = [('bt', 1), ('is_init_txss', 1), ('is_resp_txss', 1), ('total_sectors', 7), ('rx_antennas', 2),
                 (None, 4)]
BFC_SPEC = [('bt', 1), ('is_init_txss', 1), ('is_resp_txss', 1), ('rxss_length', 6), ('rxss_tx_rate', 1), (None, 6)]
BfControl = namedtuple('BfControl', 'bt is_init_txss is_resp_txss rxss_length rxss_tx_rate total_sectors '
                                    'rx_antennas', defaults=(0,) * 7)
BFC_FRAMES = ('grant', 'grant_ack', 'spr', 'ext_schedule', None)


def bfc_is_txss_format(f, frame):
    """9.5.5: рис. 9-851 — «when both the IsInitiatorTXSS and IsResponderTXSS subfields are equal to 1, and … in
    either a Grant or Grant Ack frames»; иначе рис. 9-852."""
    return bool(f.is_init_txss and f.is_resp_txss and frame in ('grant', 'grant_ack'))


def check_bf_control(f, frame=None, grant_bt=None):
    """frame: 'grant' | 'grant_ack' | 'spr' | 'ext_schedule' | None; grant_bt — BT вызвавшего Grant (для Grant Ack)."""
    assert frame in BFC_FRAMES
    viol = []
    for name, w in [('bt', 1), ('is_init_txss', 1), ('is_resp_txss', 1), ('rxss_length', 6), ('rxss_tx_rate', 1),
                    ('total_sectors', 7), ('rx_antennas', 2)]:
        x = getattr(f, name)
        if not isinstance(x, int) or not 0 <= x < (1 << w):
            viol.append(f'BF Control: {name}={x!r} не помещается в {w} бит')
    if viol:
        return viol
    txss = bfc_is_txss_format(f, frame)
    if txss and (f.rxss_length or f.rxss_tx_rate):
        viol.append('BF Control: в формате рис. 9-851 нет RXSS Length/RXSSTxRate')
    if not txss and (f.total_sectors or f.rx_antennas):
        viol.append('BF Control: в формате рис. 9-852 нет Total Number of Sectors/Number of RX DMG Antennas')
    # 9.5.5: «If the Beamforming Training subfield is set to 0, all other subfields … are reserved.»
    if not f.bt and any(f[1:]):
        viol.append('BF Control: при Beamforming Training=0 остальные подполя зарезервированы (9.5.5)')
    # 9.5.5: Grant Ack в ответ на Grant с BT=0 — IsInitiatorTXSS, IsResponderTXSS, Total Number of Sectors,
    # Number of RX DMG Antennas зарезервированы
    if frame == 'grant_ack' and grant_bt == 0 and (f.is_init_txss or f.is_resp_txss or f.total_sectors
                                                     or f.rx_antennas):
        viol.append('BF Control в Grant Ack на Grant с BT=0: поля TXSS/секторов/антенн зарезервированы (9.5.5)')
    # 9.5.5: «When the Beamforming Control field is transmitted within an Extended Schedule element, either the
    # IsInitiatorTXSS subfield or the IsResponderTXSS subfield is set to 0, but not both.»
    # СПОРНО: буквально — ровно одно из двух равно 0 (запрещены 0/0 и 1/1); альтернатива — «не оба 1» (0/0
    # допустимо). Принято буквальное; проверяется только при BT=1 (при BT=0 оба — резерв = 0).
    if frame == 'ext_schedule' and f.bt and f.is_init_txss == f.is_resp_txss:
        viol.append('BF Control в Extended Schedule: ровно одно из IsInitiatorTXSS/IsResponderTXSS = 0 (9.5.5)')
    if not txss and f.bt:
        # 9.5.5: RXSS Length «valid only if at least one of IsInitiatorTXSS … or IsResponderTXSS … is equal to 0 and
        # is reserved otherwise»; RXSSTxRate — «valid only if the RXSS Length subfield is valid and … greater than 0»
        rxss_valid = not (f.is_init_txss and f.is_resp_txss)
        if not rxss_valid and f.rxss_length:
            viol.append('BF Control: RXSS Length зарезервировано при IsInitiatorTXSS=IsResponderTXSS=1 (9.5.5)')
        if f.rxss_tx_rate and not (rxss_valid and f.rxss_length > 0):
            viol.append('BF Control: RXSSTxRate зарезервировано (RXSS Length недействительно или 0) (9.5.5)')
    return viol


def encode_bf_control(f, frame=None, **ctx):
    _raise_if(check_bf_control(f, frame, **ctx))
    d = f._asdict()
    if bfc_is_txss_format(f, frame):
        return _pack(BFC_TXSS_SPEC, d, 2, 'BF Control (рис. 9-851)')
    return _pack(BFC_SPEC, d, 2, 'BF Control (рис. 9-852)')


def parse_bf_control(b, frame=None, strict=False, **ctx):
    """Формат выбирается по B1, B2 и виду кадра (9.5.5)."""
    v = b[0]
    if (v >> 1) & 1 and (v >> 2) & 1 and frame in ('grant', 'grant_ack'):
        d, rsv = _unpack(BFC_TXSS_SPEC, b, 2, 'BF Control')
    else:
        d, rsv = _unpack(BFC_SPEC, b, 2, 'BF Control')
    f = BfControl(**d)
    if strict:
        _raise_if(_rsv_viol(rsv, 'BF Control') + check_bf_control(f, frame, **ctx))
    return f


# =====================================================================================================================
# 9.5.6 — Beamformed Link Maintenance field (рис. 9-853), 1 октет; табл. 9-344, 9-345
# =====================================================================================================================
BLM_SPEC = [('unit_index', 1), ('value', 6), ('is_master', 1)]
Blm = namedtuple('Blm', 'unit_index value is_master', defaults=(0, 0, 0))
BLM_UNIT_US = {0: Fr(32), 1: Fr(2000)}      # табл. 9-344


def blm_time(f):
    """9.5.6: dot11BeamLinkMaintenanceTime = BLMU × BLMV при BLMV > 0; при 0 — не определено (None)."""
    return BLM_UNIT_US[f.unit_index] * f.value if f.value > 0 else None


def blm_negotiate(master_a, time_a, master_b, time_b):
    """Табл. 9-345 (STA-A/STA-B — «in no particular order»): результат согласования dot11BeamLinkMaintenanceTime.
    None — не определено (любая сторона не определена, либо комбинация, которой нет в таблице: оба isMaster=1 с
    разными временами — таблица задаёт результат только для «=»)."""
    if time_a is None or time_b is None:
        return None
    if master_a and not master_b:
        return time_a
    if master_b and not master_a:
        return time_b
    if not master_a and not master_b:
        return max(time_a, time_b)          # строка «0 | 0 | ≥ | (STA-A)» — берётся большее
    return time_a if time_a == time_b else None


def encode_blm(f):
    return _pack(BLM_SPEC, f._asdict(), 1, 'BLM')


def parse_blm(b, strict=False):
    d, rsv = _unpack(BLM_SPEC, b, 1, 'BLM')
    return Blm(**d)


# =====================================================================================================================
# 9.2.4.1 — Frame Control (рис. 9-3, рис. 9-4, табл. 9-1, табл. 9-2)
# =====================================================================================================================
TYPE_MGMT, TYPE_CTRL, TYPE_DATA, TYPE_EXT = 0, 1, 2, 3      # табл. 9-1 (B3 B2)
SUBTYPE_CFE = 0b0110                                         # табл. 9-1: «01 Control 0110 Control Frame Extension»
SUBTYPE_DMG_BEACON = 0b0000                                  # табл. 9-1: «11 Extension 0000 DMG Beacon»
CFE = {                                                      # табл. 9-2 (B11 B10 B9 B8)
    'poll': 0b0010, 'spr': 0b0011, 'grant': 0b0100, 'dmg_cts': 0b0101, 'dmg_dts': 0b0110, 'grant_ack': 0b0111,
    'ssw': 0b1000, 'ssw_fb': 0b1001, 'ssw_ack': 0b1010,
}
CFE_KIND = {v: k for k, v in CFE.items()}

FC_SPEC = [('protocol', 2), ('type', 2), ('subtype', 4), ('to_ds', 1), ('from_ds', 1), ('more_frag', 1),
           ('retry', 1), ('pm', 1), ('more_data', 1), ('protected', 1), ('htc', 1)]
FC_CFE_SPEC = [('protocol', 2), ('type', 2), ('subtype', 4), ('cfe', 4), ('pm', 1), ('more_data', 1),
               ('protected', 1), ('htc', 1)]
FrameControl = namedtuple('FrameControl', 'protocol type subtype cfe to_ds from_ds more_frag retry pm more_data '
                                          'protected htc', defaults=(0,) * 12)


def fc_is_cfe(fc):
    """9.2.4.1.1: рис. 9-4 — «when the Type subfield is 1 and the Subtype subfield is 6»."""
    return fc.type == TYPE_CTRL and fc.subtype == SUBTYPE_CFE


def check_fc(fc):
    viol = _check_ranges(FC_CFE_SPEC if fc_is_cfe(fc) else FC_SPEC, fc._asdict(), 'Frame Control')
    if fc_is_cfe(fc) and (fc.to_ds or fc.from_ds or fc.more_frag or fc.retry):
        viol.append('Frame Control: в рис. 9-4 нет To DS/From DS/More Fragments/Retry')
    if not fc_is_cfe(fc) and fc.cfe:
        viol.append('Frame Control: Control Frame Extension есть только при Type=1, Subtype=6 (9.2.4.1.1)')
    if fc.protocol != 0:
        viol.append(f'Frame Control: Protocol Version={fc.protocol} (PV0 — 0, 9.2.4.1.2)')
    if fc_is_cfe(fc):
        if fc.cfe not in CFE_KIND:
            viol.append(f'Frame Control: Control Frame Extension={fc.cfe:04b} зарезервировано (табл. 9-2)')
        if fc.protected:
            viol.append('Frame Control: Protected Frame зарезервировано в Control Frame Extension (9.2.4.1.9)')
    # 9.2.4.1.10 NOTE: «The +HTC subfield is always set to 0 for frames transmitted by a DMG STA.»
    if fc.htc:
        viol.append('Frame Control: +HTC=1 у DMG STA (9.2.4.1.10 NOTE)')
    if fc.type == TYPE_CTRL and not fc_is_cfe(fc) and (fc.to_ds or fc.from_ds or fc.more_frag or fc.retry
                                                         or fc.protected):
        viol.append('Frame Control кадра управления: To DS/From DS/More Frag/Retry/Protected = 0 (рис. 9-26)')
    return viol


def encode_fc(fc):
    _raise_if(check_fc(fc))
    return _pack(FC_CFE_SPEC if fc_is_cfe(fc) else FC_SPEC, fc._asdict(), 2, 'Frame Control')


def parse_fc(b, strict=False):
    v = int.from_bytes(b[:2], 'little')
    t, st = (v >> 2) & 3, (v >> 4) & 0xF
    spec = FC_CFE_SPEC if (t == TYPE_CTRL and st == SUBTYPE_CFE) else FC_SPEC
    d, _ = _unpack(spec, b, 2, 'Frame Control')
    fc = FrameControl(**d)
    if strict:
        _raise_if(check_fc(fc))
    return fc


def fc_for(kind, pm=0, more_data=0):
    if kind == 'dmg_beacon':
        return FrameControl(type=TYPE_EXT, subtype=SUBTYPE_DMG_BEACON, pm=pm, more_data=more_data)
    return FrameControl(type=TYPE_CTRL, subtype=SUBTYPE_CFE, cfe=CFE[kind], pm=pm, more_data=more_data)


def frame_kind(fc):
    if fc_is_cfe(fc):
        return CFE_KIND.get(fc.cfe)
    if fc.type == TYPE_EXT and fc.subtype == SUBTYPE_DMG_BEACON:
        return 'dmg_beacon'
    return None


# =====================================================================================================================
# 9.2.4.8 — FCS
# =====================================================================================================================
CRC_G = 0x04C11DB7      # G(x) = x^32 + x^26 + x^23 + x^22 + x^16 + x^12 + x^11 + x^10 + x^8 + x^7 + x^5 + x^4 + …


def _crc_bits(data, reg=0xFFFFFFFF):
    """Деление по G(x) побитно; биты — в порядке передачи (9.2.2: октет за октетом, младший бит первым).
    Регистр: бит 31 — коэффициент при x^31. Предустановка единицами ≡ слагаемое a) пункта 9.2.4.8."""
    for byte in data:
        for i in range(8):
            fb = ((reg >> 31) & 1) ^ ((byte >> i) & 1)
            reg = (reg << 1) & 0xFFFFFFFF
            if fb:
                reg ^= CRC_G
    return reg


def fcs(data):
    """9.2.4.8: дополнение остатка до единиц, «transmitted commencing with the coefficient of the highest-order term»:
    первый бит на эфире (бит 0 октета 0) — коэффициент при x^31."""
    r = _crc_bits(data) ^ 0xFFFFFFFF
    out = 0
    for i in range(32):                 # бит i потока ← коэффициент x^(31−i)
        out |= ((r >> (31 - i)) & 1) << i
    return out.to_bytes(4, 'little')


def fcs_residue(mpdu):
    """Остаток приёмника по всем битам, включая FCS (9.2.4.8: «results … in a unique nonzero remainder value»)."""
    return _crc_bits(mpdu)


# =====================================================================================================================
# 9.3.1.10 – 9.3.1.18 — кадры управления DMG (Control Frame Extension)
# =====================================================================================================================
Poll = namedtuple('Poll', 'duration ra ta response_offset pm more_data', defaults=(0, 0))
Spr = namedtuple('Spr', 'duration ra ta dai bfc pm more_data', defaults=(0, 0))
Grant = namedtuple('Grant', 'duration ra ta dai bfc pm more_data', defaults=(0, 0))
DmgCts = namedtuple('DmgCts', 'duration ra ta pm more_data', defaults=(0, 0))
DmgDts = namedtuple('DmgDts', 'duration ra nav_sa nav_da pm more_data', defaults=(0, 0))
SswFrame = namedtuple('SswFrame', 'duration ra ta ssw fb pm more_data', defaults=(0, 0))
SswFbFrame = namedtuple('SswFbFrame', 'duration ra ta fb brp blm pm more_data', defaults=(0, 0))
SswAck = namedtuple('SswAck', 'duration ra ta fb brp blm pm more_data', defaults=(0, 0))
GrantAck = namedtuple('GrantAck', 'duration ra ta bfc pm more_data', defaults=(0, 0))

KIND_OF = {Poll: 'poll', Spr: 'spr', Grant: 'grant', DmgCts: 'dmg_cts', DmgDts: 'dmg_dts', SswFrame: 'ssw',
           SswFbFrame: 'ssw_fb', SswAck: 'ssw_ack', GrantAck: 'grant_ack'}
CLASS_OF = {v: k for k, v in KIND_OF.items()}

# Длины MPDU с FCS по рисункам (октеты): FC 2 + Duration 2 + адреса + тело + FCS 4
FRAME_LEN = {
    'poll': 2 + 2 + 6 + 6 + 2 + 4,          # рис. 9-49
    'spr': 2 + 2 + 6 + 6 + 5 + 2 + 4,       # рис. 9-50
    'grant': 2 + 2 + 6 + 6 + 5 + 2 + 4,     # рис. 9-51
    'dmg_cts': 2 + 2 + 6 + 6 + 4,           # рис. 9-52
    'dmg_dts': 2 + 2 + 6 + 6 + 6 + 4,       # рис. 9-53
    'ssw': 2 + 2 + 6 + 6 + 3 + 3 + 4,       # рис. 9-54
    'ssw_fb': 2 + 2 + 6 + 6 + 3 + 4 + 1 + 4,    # рис. 9-55
    'ssw_ack': 2 + 2 + 6 + 6 + 3 + 4 + 1 + 4,   # рис. 9-56
    'grant_ack': 2 + 2 + 6 + 6 + 5 + 2 + 4,     # рис. 9-57: Reserved 5
}


def _dur_viol(d):
    # табл. 9-9: значения 0…32 767 (бит 15 = 0) — длительность в мкс; кадры 9.3.1.10–18 несут только длительность
    if not isinstance(d, int) or not 0 <= d <= DUR_MAX:
        return [f'Duration={d!r} вне 0…{DUR_MAX} (табл. 9-9, 9.2.5.1)']
    return []


def check_frame(f, **ctx):
    """Нарушения в кадре (namedtuple). ctx: abft=…, in_cbap=…, sender_ap_pcp=…, rss_rxss=…, grant_ctx=…,
    grant_bt=…, transmitter=… (для DMG CTS-to-self)."""
    kind = KIND_OF[type(f)]
    viol = _dur_viol(f.duration)
    viol += check_fc(fc_for(kind, f.pm, f.more_data))
    for a in [x for x in ('ra', 'ta', 'nav_sa', 'nav_da') if x in f._fields]:
        try:
            mac_bytes(getattr(f, a))
        except (FieldError, ValueError):
            viol.append(f'{kind}: {a} — не MAC-адрес')
    if kind in ('spr', 'grant'):
        viol += check_dai(f.dai, frame=kind, grant_ctx=ctx.get('grant_ctx'))
        viol += check_bf_control(f.bfc, frame=kind)
    if kind == 'grant_ack':
        viol += check_bf_control(f.bfc, frame='grant_ack', grant_bt=ctx.get('grant_bt'))
    if kind == 'poll' and not 0 <= f.response_offset <= 0xFFFF:
        viol.append('Poll: Response Offset — 16 бит (рис. 9-49)')
    if kind == 'ssw':
        viol += check_ssw(f.ssw, in_cbap=ctx.get('in_cbap'))
        # 9.5.3: формат SSW Feedback — рис. 9-848 «as part of an ISS»: в ISS Direction = 0 (10.42.2.2.1)
        iss = f.ssw.direction == DIR_INITIATOR
        if iss != isinstance(f.fb, SswFbIss):
            viol.append('SSW: формат SSW Feedback не соответствует Direction (ISS ↔ рис. 9-848, 9.5.3)')
        else:
            viol += check_ssw_fb(f.fb, poll_reserved=ctx.get('sender_ap_pcp', False))
    if kind in ('ssw_fb', 'ssw_ack'):
        if isinstance(f.fb, SswFbIss):
            viol.append(f'{kind}: SSW Feedback вне ISS — формат рис. 9-849 (9.5.3)')
        else:
            viol += check_ssw_fb(f.fb, poll_reserved=ctx.get('sender_ap_pcp', False),
                                 select_reserved=(kind == 'ssw_fb' and ctx.get('rss_rxss', False)))
        viol += check_brp_req(f.brp)
        if kind == 'ssw_fb' and ctx.get('abft') and f.duration != 0:
            viol.append('SSW-Feedback в A-BFT: Duration = 0 (9.3.1.16)')
    if kind == 'dmg_dts' and ctx.get('rts_ta') is not None and mac_bytes(f.ra) != mac_bytes(ctx['rts_ta']):
        viol.append('DMG DTS: RA ≠ TA вызвавшего RTS (9.3.1.14)')
    if kind == 'grant_ack' and ctx.get('grant_ta') is not None and mac_bytes(f.ra) != mac_bytes(ctx['grant_ta']):
        viol.append('Grant Ack: RA ≠ Address 2 вызвавшего Grant (9.3.1.18)')
    if kind == 'dmg_cts' and ctx.get('rts_ta') is not None and mac_bytes(f.ra) != mac_bytes(ctx['rts_ta']):
        viol.append('DMG CTS: RA ≠ TA вызвавшего RTS (9.3.1.13)')
    return viol


def is_cts_to_self(f, transmitter):
    """9.3.1.13: «A DMG CTS-to-self frame is a DMG CTS frame in which the RA field is equal to the transmitter's MAC
    address» (TA — адрес получателя следующего кадра)."""
    return mac_bytes(f.ra) == mac_bytes(transmitter)


def encode_frame(f, with_fcs=True, **ctx):
    """MPDU кадра управления DMG; с FCS по умолчанию."""
    _raise_if(check_frame(f, **ctx))
    kind = KIND_OF[type(f)]
    out = encode_fc(fc_for(kind, f.pm, f.more_data)) + f.duration.to_bytes(2, 'little') + mac_bytes(f.ra)
    if kind == 'dmg_dts':
        out += mac_bytes(f.nav_sa) + mac_bytes(f.nav_da)
    else:
        out += mac_bytes(f.ta)
    if kind == 'poll':
        out += f.response_offset.to_bytes(2, 'little')
    elif kind in ('spr', 'grant'):
        out += encode_dai(f.dai, frame=kind) + encode_bf_control(f.bfc, frame=kind)
    elif kind == 'grant_ack':
        out += bytes(5) + encode_bf_control(f.bfc, frame='grant_ack', grant_bt=ctx.get('grant_bt'))
    elif kind == 'ssw':
        out += encode_ssw(f.ssw) + encode_ssw_fb(f.fb)
    elif kind in ('ssw_fb', 'ssw_ack'):
        out += encode_ssw_fb(f.fb) + encode_brp_req(f.brp) + encode_blm(f.blm)
    if with_fcs:
        out += fcs(out)
    assert len(out) == FRAME_LEN[kind] - (0 if with_fcs else 4)
    return out


def parse_frame(b, with_fcs=True, strict=False, **ctx):
    """MPDU → namedtuple кадра. Проверяет FCS (with_fcs), тип/расширение, длину; strict — ещё резерв и правила."""
    b = bytes(b)
    viol = []
    if with_fcs:
        if len(b) < 4 + 2 or fcs(b[:-4]) != b[-4:]:
            raise FieldError(['FCS не сходится (9.2.4.8)'])
        b = b[:-4]
    fc = parse_fc(b)
    kind = frame_kind(fc)
    if kind is None or kind == 'dmg_beacon':
        raise FieldError([f'не кадр Control Frame Extension DMG: type={fc.type} subtype={fc.subtype} cfe={fc.cfe}'])
    if len(b) != FRAME_LEN[kind] - 4:
        raise FieldError([f'{kind}: длина {len(b) + 4} ≠ {FRAME_LEN[kind]} (рис. 9-49…9-57)'])
    if strict:
        viol += check_fc(fc)
    dur = int.from_bytes(b[2:4], 'little')
    ra = mac_str(b[4:10])
    common = dict(duration=dur, ra=ra, pm=fc.pm, more_data=fc.more_data)
    body = b[16:]
    if kind == 'dmg_dts':
        f = DmgDts(nav_sa=mac_str(b[10:16]), nav_da=mac_str(b[16:22]), **common)
    else:
        ta = mac_str(b[10:16])
        if kind == 'poll':
            f = Poll(ta=ta, response_offset=int.from_bytes(body[0:2], 'little'), **common)
        elif kind == 'dmg_cts':
            f = DmgCts(ta=ta, **common)
        elif kind in ('spr', 'grant'):
            f = CLASS_OF[kind](ta=ta, dai=parse_dai(body[0:5], strict=strict, frame=kind),
                               bfc=parse_bf_control(body[5:7], frame=kind, strict=strict), **common)
        elif kind == 'grant_ack':
            if strict and any(body[0:5]):
                viol.append('Grant Ack: поле Reserved (5 октетов) не нулевое (рис. 9-57)')
            f = GrantAck(ta=ta, bfc=parse_bf_control(body[5:7], frame='grant_ack', strict=strict), **common)
        elif kind == 'ssw':
            s = parse_ssw(body[0:3], strict=strict)
            f = SswFrame(ta=ta, ssw=s, fb=parse_ssw_fb(body[3:6], iss=s.direction == DIR_INITIATOR, strict=strict),
                         **common)
        else:
            f = CLASS_OF[kind](ta=ta, fb=parse_ssw_fb(body[0:3], iss=False, strict=strict),
                               brp=parse_brp_req(body[3:7], strict=strict), blm=parse_blm(body[7:8]), **common)
    if strict:
        _raise_if(viol + check_frame(f, **ctx))
    return f


# =====================================================================================================================
# 9.4.1.46 — DMG Parameters (рис. 9-133), 1 октет
# =====================================================================================================================
DMGP_SPEC = [('bss_type', 2), ('cbap_only', 1), ('cbap_source', 1), ('privacy', 1), ('ecapc', 1), (None, 2)]
DmgParams = namedtuple('DmgParams', 'bss_type cbap_only cbap_source privacy ecapc', defaults=(0, 0, 0, 0))
# табл. 9-68 (Discovery Mode = 0): роль → значение BSS Type
BSS_TYPE_BY_ROLE = {'ap': 3, 'pcp': 2, 'ibss': 1, 'none': 1}


def check_dmg_params(f, discovery=0, role=None, rsna=None, cbap_source_strict=True):
    """role: 'ap' | 'pcp' | 'ibss' | 'none' (не член BSS) — табл. 9-68; rsna — dot11RSNAActivated (DMG Privacy).
    СПОРНО → принято (PLAN.md «Принятые трактовки» №9, как bi.check_schedule): CBAP Source «valid only if the CBAP Only
    subfield is 1. … set to 1 to indicate that the AP or PCP has higher priority … set to 0 otherwise» (9.4.1.46; 2024 —
    тот же текст) — при CBAP Only = 0 приоритета нет → «otherwise» → 0. cbap_source_strict=False — прежнее мягкое чтение
    («недействительно», значение не проверяется)."""
    viol = _check_ranges(DMGP_SPEC, f._asdict(), 'DMG Parameters')
    if cbap_source_strict and not f.cbap_only and f.cbap_source:
        viol.append('DMG Parameters: CBAP Source = 1 при CBAP Only = 0 (9.4.1.46: «set to 0 otherwise»)')
    if discovery == 0 and f.bss_type == 0:
        viol.append('DMG Parameters: BSS Type=0 зарезервировано при Discovery Mode=0 (табл. 9-68)')
    if discovery == 0 and role is not None and f.bss_type != BSS_TYPE_BY_ROLE[role]:
        viol.append(f'DMG Parameters: BSS Type={f.bss_type} для роли {role} (9.4.1.46, табл. 9-68)')
    if rsna is not None and f.privacy != int(bool(rsna)):
        viol.append('DMG Parameters: DMG Privacy ≠ dot11RSNAActivated (9.4.1.46)')
    return viol


def encode_dmg_params(f, **ctx):
    _raise_if(check_dmg_params(f, **ctx))
    return _pack(DMGP_SPEC, f._asdict(), 1, 'DMG Parameters')


def parse_dmg_params(b, strict=False, **ctx):
    d, rsv = _unpack(DMGP_SPEC, b, 1, 'DMG Parameters')
    f = DmgParams(**d)
    if strict:
        _raise_if(_rsv_viol(rsv, 'DMG Parameters') + check_dmg_params(f, **ctx))
    return f


# =====================================================================================================================
# 9.3.4.2 — Beacon Interval Control (рис. 9-77), 6 октетов
# =====================================================================================================================
BIC_SPEC = [('cc_present', 1), ('discovery', 1), ('next_beacon', 4), ('ati_present', 1), ('abft_length', 3),
            ('fss', 4), ('is_resp_txss', 1), ('next_abft', 4), ('fragmented_txss', 1), ('txss_span', 7),
            ('n_bis_abft', 4), ('abft_count', 6), ('n_abft_in_ant', 6), ('pcp_assoc_ready', 1), (None, 4)]
# по умолчанию TXSS Span = 1 (≥ 1, 9.3.4.2) и N BIs A-BFT = 1 («set to 1 if every beacon interval contains an A-BFT»)
Bic = namedtuple('Bic', [n for n, _ in BIC_SPEC if n], defaults=(0,) * 9 + (1, 1, 0, 0, 0))


def abft_slots(f):
    """9.3.4.2: A-BFT Length — «number of sector sweep slots … minus 1»."""
    return f.abft_length + 1


def fss_frames(f):
    """9.3.4.2: FSS — «number of SSW frames allowed minus one»."""
    return f.fss + 1


def check_bic(f, rx_antennas=None, pcp=None):
    """rx_antennas — число приёмных DMG-антенн передающей STA (из DMG Capabilities): при 1 A-BFT Count и N A-BFT in
    Ant зарезервированы; pcp — передатчик PCP (иначе PCP Association Ready зарезервировано)."""
    viol = _check_ranges(BIC_SPEC, f._asdict(), 'Beacon Interval Control')
    if f.txss_span < 1:
        viol.append('BIC: TXSS Span ≥ 1 (9.3.4.2: «always greater than or equal to 1»)')
    if rx_antennas == 1 and (f.abft_count or f.n_abft_in_ant):
        viol.append('BIC: A-BFT Count/N A-BFT in Ant зарезервированы при одной RX DMG-антенне (9.3.4.2)')
    if pcp is False and f.pcp_assoc_ready:
        viol.append('BIC: PCP Association Ready зарезервировано у не-PCP (9.3.4.2)')
    return viol


def encode_bic(f, **ctx):
    _raise_if(check_bic(f, **ctx))
    return _pack(BIC_SPEC, f._asdict(), 6, 'Beacon Interval Control')


def parse_bic(b, strict=False, **ctx):
    d, rsv = _unpack(BIC_SPEC, b, 6, 'Beacon Interval Control')
    f = Bic(**d)
    if strict:
        _raise_if(_rsv_viol(rsv, 'BIC') + check_bic(f, **ctx))
    return f


# =====================================================================================================================
# 9.3.4.2 — Clustering Control (рис. 9-78 при Discovery Mode = 0, рис. 9-79 при 1), 8 октетов
# =====================================================================================================================
CC_SPEC = [('beacon_sp_duration', 8), ('cluster_id', 48), ('member_role', 2), ('cluster_max_mem', 5), ('spsh', 1)]
CC_DISC_SPEC = [('abft_responder', 48), (None, 16)]
ClusteringControl = namedtuple('ClusteringControl', 'beacon_sp_duration cluster_id member_role cluster_max_mem spsh',
                               defaults=(0,))
ClusteringControlDisc = namedtuple('ClusteringControlDisc', 'abft_responder')
BEACON_SP_UNIT = Fr(8)      # 9.3.4.2: Beacon SP Duration «in units of 8 µs»
ROLE_NONE, ROLE_SYNC, ROLE_MEMBER = 0, 1, 2     # 9.3.4.2: Cluster Member Role 0/1/2, 3 — резерв


def _mac_int(a):
    # адрес в битовом поле: бит 0 адреса (I/G) — младший бит подполя (9.2.2, рис. 9-1)
    return int.from_bytes(mac_bytes(a), 'little')


def check_cc(f, ecapc=None, cdmg=None):
    viol = []
    if isinstance(f, ClusteringControlDisc):
        return viol
    if not 0 <= f.beacon_sp_duration < 256 or f.member_role not in range(4) or not 0 <= f.cluster_max_mem < 32 \
            or f.spsh not in (0, 1):
        viol.append('Clustering Control: подполе не помещается в разрядность (рис. 9-78)')
    if f.member_role == 3:
        viol.append('Clustering Control: Cluster Member Role=3 зарезервировано (9.3.4.2)')
    if f.cluster_max_mem == 0:
        viol.append('Clustering Control: ClusterMaxMem=0 зарезервировано (9.3.4.2)')
    if ecapc == 0 and f.cluster_max_mem >= 8:
        viol.append('Clustering Control: ClusterMaxMem ≥ 8 зарезервировано при ECAPC Policy Enforced=0 (9.3.4.2)')
    if cdmg is False and f.spsh:
        viol.append('Clustering Control: SPSH Measurement Enabled зарезервировано у не-CDMG (9.3.4.2)')
    return viol


def encode_cc(f, **ctx):
    _raise_if(check_cc(f, **ctx))
    if isinstance(f, ClusteringControlDisc):
        return _pack(CC_DISC_SPEC, {'abft_responder': _mac_int(f.abft_responder)}, 8, 'Clustering Control')
    d = f._asdict()
    d['cluster_id'] = _mac_int(f.cluster_id)
    return _pack(CC_SPEC, d, 8, 'Clustering Control')


def parse_cc(b, discovery, strict=False, **ctx):
    if discovery:
        d, rsv = _unpack(CC_DISC_SPEC, b, 8, 'Clustering Control')
        f = ClusteringControlDisc(mac_str(d['abft_responder'].to_bytes(6, 'little')))
    else:
        d, rsv = _unpack(CC_SPEC, b, 8, 'Clustering Control')
        d['cluster_id'] = mac_str(d['cluster_id'].to_bytes(6, 'little'))
        f = ClusteringControl(**d)
    if strict:
        _raise_if(_rsv_viol(rsv, 'Clustering Control') + check_cc(f, **ctx))
    return f


# =====================================================================================================================
# 9.3.4.2 — DMG Beacon (рис. 9-76, табл. 9-45)
# =====================================================================================================================
DmgBeacon = namedtuple('DmgBeacon', 'duration bssid timestamp ssw beacon_interval bic params cc elements pm more_data',
                       defaults=(None, (), 0, 0))
# Элемент — (Element ID, Element ID Extension или None, данные) (9.4.2.1)

# Табл. 9-45: порядок → элемент (ID по табл. 9-92). Несколько номеров — элемент повторён в таблице.
# СПОРНО: табл. 9-45 дважды перечисляет BSS Load (21, 51), Power Constraint (23, 49), Extended Cluster Report
# (41, 43), Cluster Switch Announcement (42, 44); принято — элемент допустим в любой из своих позиций (один раз).
BEACON_ORDER = {
    (148, None): (7,), (144, None): (8,), (48, None): (9,), (71, None): (10,), (151, None): (11,),
    (147, None): (12,), (152, None): (13,), (158, None): (14,), (157, None): (15,), (143, None): (16,),
    (200, None): (17,), (0, None): (18,), (6, None): (19,), (7, None): (20,), (11, None): (21, 51),
    (12, None): (22,), (32, None): (23, 49), (52, None): (24,), (40, None): (25,), (46, None): (26,),
    (60, None): (27,), (63, None): (28,), (70, None): (29,), (83, None): (30,), (107, None): (31,),
    (108, None): (32,), (111, None): (33,), (145, None): (34,), (160, None): (35,), (161, None): (36,),
    (190, None): (37,), (255, 17): (38,), (255, 18): (39,), (255, 21): (40,), (255, 22): (41, 43),
    (255, 23): (42, 44), (255, 25): (45,), (255, 26): (46,), (255, 27): (47,), (255, 28): (48,),
    (35, None): (50,), (255, 19): (52,), (255, 15): (53,), (255, 16): (54,), (221, None): (1000,),
}
# табл. 9-45: «One or more Multiple BSSID», «Zero or more Multi-band», «One or more Vendor Specific»
BEACON_MULTI = {(71, None), (158, None), (221, None)}
EID_IBSS_PARAMS = 6


def encode_elements(elements):
    """9.4.2.1: Element ID 1, Length 1, (Element ID Extension 1 при ID 255, входит в Length), данные."""
    out = b''
    for eid, ext, data in elements:
        body = (bytes([ext]) if eid == 255 else b'') + bytes(data)
        if len(body) > 255:
            raise FieldError([f'элемент {eid}/{ext}: длина {len(body)} > 255'])
        out += bytes([eid, len(body)]) + body
    return out


def parse_elements(b):
    out, i = [], 0
    while i < len(b):
        if i + 2 > len(b) or i + 2 + b[i + 1] > len(b):
            raise FieldError([f'элементы: обрыв на смещении {i}'])
        eid, n = b[i], b[i + 1]
        body = b[i + 2:i + 2 + n]
        if eid == 255:
            if n < 1:
                raise FieldError(['элемент 255 без Element ID Extension'])
            out.append((255, body[0], bytes(body[1:])))
        else:
            out.append((eid, None, bytes(body)))
        i += 2 + n
    return out


def check_beacon_elements(elements, ibss=None):
    """Порядок элементов по табл. 9-45 (Vendor Specific — последними), повторы, IBSS Parameter Set только от IBSS."""
    viol, last_o, last_k, seen = [], 0, None, set()
    for eid, ext, _ in elements:
        k = (eid, ext if eid == 255 else None)
        if k not in BEACON_ORDER:
            viol.append(f'DMG Beacon: элемент {k} не из табл. 9-45')
            continue
        if k in seen and k not in BEACON_MULTI and k != last_k:
            viol.append(f'DMG Beacon: элемент {k} повторён (табл. 9-45)')
        if k == last_k:
            if k not in BEACON_MULTI:
                viol.append(f'DMG Beacon: элемент {k} повторён (табл. 9-45)')
            continue
        cand = [o for o in BEACON_ORDER[k] if o > last_o]
        if not cand:
            viol.append(f'DMG Beacon: элемент {k} не на своём месте (табл. 9-45)')
            continue
        last_o, last_k = min(cand), k
        seen.add(k)
    if ibss is False and any(e == EID_IBSS_PARAMS for e, _, _ in elements):
        viol.append('DMG Beacon: IBSS Parameter Set только от IBSS STA (табл. 9-45)')
    return viol


def check_dmg_beacon(f, pcp=None, rx_antennas=None, role=None, rsna=None, cdmg=None):
    viol = _dur_viol(f.duration)
    viol += check_fc(fc_for('dmg_beacon', f.pm, f.more_data))
    # 10.42.2.2.1: «set the Direction subfield … to 0 within each DMG Beacon»; 9.5.1: RXSS Length — резерв вне CBAP
    # (DMG Beacon передаётся в BTI)
    viol += check_ssw(f.ssw, in_cbap=False, direction=DIR_INITIATOR)
    if not 0 <= f.timestamp < (1 << 64) or not 0 <= f.beacon_interval < (1 << 16):
        viol.append('DMG Beacon: Timestamp — 8 октетов, Beacon Interval — 2 октета (9.4.1.10, 9.4.1.3)')
    viol += check_bic(f.bic, rx_antennas=rx_antennas, pcp=pcp)
    viol += check_dmg_params(f.params, discovery=f.bic.discovery, role=role, rsna=rsna)
    # 9.3.4.2: «The CC Present subfield is set to 1 to indicate that the Clustering Control field is present»
    if bool(f.bic.cc_present) != (f.cc is not None):
        viol.append('DMG Beacon: CC Present не соответствует наличию Clustering Control (9.3.4.2)')
    if f.cc is not None:
        if isinstance(f.cc, ClusteringControlDisc) != bool(f.bic.discovery):
            viol.append('DMG Beacon: формат Clustering Control не по Discovery Mode (рис. 9-78/9-79)')
        else:
            viol += check_cc(f.cc, ecapc=f.params.ecapc, cdmg=cdmg)
    viol += check_beacon_elements(f.elements, ibss=None if role is None else role == 'ibss')
    return viol


def encode_dmg_beacon(f, with_fcs=True, **ctx):
    _raise_if(check_dmg_beacon(f, **ctx))
    out = (encode_fc(fc_for('dmg_beacon', f.pm, f.more_data)) + f.duration.to_bytes(2, 'little') + mac_bytes(f.bssid)
           + f.timestamp.to_bytes(8, 'little') + encode_ssw(f.ssw) + f.beacon_interval.to_bytes(2, 'little')
           + encode_bic(f.bic) + encode_dmg_params(f.params, discovery=f.bic.discovery))
    if f.cc is not None:
        out += encode_cc(f.cc)
    out += encode_elements(f.elements)
    if with_fcs:
        out += fcs(out)
    return out


BEACON_FIXED_LEN = 2 + 2 + 6 + 8 + 3 + 2 + 6 + 1       # рис. 9-76 + табл. 9-45 порядок 1–5 (= 30)


def parse_dmg_beacon(b, with_fcs=True, strict=False, **ctx):
    b = bytes(b)
    if with_fcs:
        if len(b) < 4 or fcs(b[:-4]) != b[-4:]:
            raise FieldError(['FCS не сходится (9.2.4.8)'])
        b = b[:-4]
    if len(b) < BEACON_FIXED_LEN:
        raise FieldError([f'DMG Beacon: {len(b)} октетов < {BEACON_FIXED_LEN}'])
    fc = parse_fc(b)
    if frame_kind(fc) != 'dmg_beacon':
        raise FieldError([f'не DMG Beacon: type={fc.type} subtype={fc.subtype}'])
    viol = check_fc(fc) if strict else []
    rsv = []
    # смещения: FC 0, Duration 2, BSSID 4, Timestamp 10, SSW 18, Beacon Interval 21, BIC 23, DMG Parameters 29
    bic = parse_bic(b[23:29])
    if strict:
        rsv += _rsv_viol(_unpack(BIC_SPEC, b[23:29], 6, 'BIC')[1], 'BIC')
        rsv += _rsv_viol(_unpack(DMGP_SPEC, b[29:30], 1, 'DMGP')[1], 'DMG Parameters')
    i = BEACON_FIXED_LEN
    cc = None
    if bic.cc_present:
        if len(b) < i + 8:
            raise FieldError(['DMG Beacon: нет Clustering Control при CC Present=1'])
        cc = parse_cc(b[i:i + 8], bic.discovery)
        if strict:
            rsv += _rsv_viol(_unpack(CC_DISC_SPEC if bic.discovery else CC_SPEC, b[i:i + 8], 8, 'CC')[1],
                             'Clustering Control')
        i += 8
    f = DmgBeacon(duration=int.from_bytes(b[2:4], 'little'), bssid=mac_str(b[4:10]),
                  timestamp=int.from_bytes(b[10:18], 'little'), ssw=parse_ssw(b[18:21]),
                  beacon_interval=int.from_bytes(b[21:23], 'little'), bic=bic, params=parse_dmg_params(b[29:30]),
                  cc=cc, elements=tuple(parse_elements(b[i:])),
                  pm=fc.pm, more_data=fc.more_data)
    if strict:
        _raise_if(viol + rsv + check_dmg_beacon(f, **ctx))
    return f


# ---- общая проверка байтов (для дифференциальных тестов прошивки) ----
def check_mpdu(b, with_fcs=True, **ctx):
    """Список нарушений в MPDU кадра управления DMG или DMG Beacon (пустой — кадр корректен)."""
    try:
        fc = parse_fc(bytes(b[:2]))
        if frame_kind(fc) == 'dmg_beacon':
            parse_dmg_beacon(b, with_fcs=with_fcs, strict=True, **ctx)
        else:
            parse_frame(b, with_fcs=with_fcs, strict=True, **ctx)
    except FieldError as e:
        return e.violations
    return []
