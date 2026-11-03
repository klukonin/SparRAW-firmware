# SPDX-License-Identifier: AGPL-3.0-or-later
"""Block Ack, HT-immediate (DMG): установление (10.25.2, 9.4.1.13, 9.6.4), учёт получателя (10.25.6.3/10.25.6.4),
BlockAck (10.25.6.5, 9.3.1.8), буфер переупорядочения (10.25.6.6), отправитель (10.25.6.7/10.25.6.8),
номера по модулю 4096 (10.25.1, 10.3.2.14.2). Время — Fraction, мкс.

Неравенства в 10.25.6 — по 802.11-2024 (тот же пункт): в тексте 2020 знаки ≤/< потеряны при извлечении."""
from collections import deque, namedtuple
from fractions import Fraction as Fr

# ---- 10.25.1 / 10.3.2.14.2: арифметика номеров последовательности ----
SN_MOD = 4096           # 10.3.2.14.2: «each sequence number space is represented by a modulo 4096 counter»
HALF = 1 << 11          # 2^11 из 10.25.6.3 b)2)
BITMAP_LEN = 64         # 9.3.1.8.2: «received status of up to 64 entries»
TU = Fr(1024)           # 3.1: «time unit (TU): … equal to 1024 µs»

IN, AHEAD, BEHIND = 'in', 'ahead', 'behind'


def sn_add(a, n):
    """10.25.1: «All arithmetic … modulo the size of the relevant counter space (typically 4096)»."""
    return (a + n) % SN_MOD


def sn_off(sn, base):
    """Смещение sn от base по модулю 4096 (0..4095)."""
    return (sn - base) % SN_MOD


def sn_region(sn, start, end):
    """Область SN относительно окна (10.25.6.3 b, 10.25.6.6.2):
    IN — WinStart ≤ SN ≤ WinEnd; AHEAD — WinEnd < SN < WinStart + 2^11; BEHIND — WinStart + 2^11 ≤ SN < WinStart."""
    d, e = sn_off(sn, start), sn_off(end, start)
    if d <= e:
        return IN
    return AHEAD if d < HALF else BEHIND


# ---- 9.2.4.4.1 рис. 9-7 / 9.3.1.7.2 рис. 9-37: (Block Ack) Starting Sequence Control ----
def encode_ssc(ssn, fn=0):
    """Рис. 9-37: B0–B3 Fragment Number (0), B4–B15 Starting Sequence Number; little-endian."""
    if not 0 <= ssn < SN_MOD or not 0 <= fn < 16:
        raise ValueError('SSN/FN вне диапазона')
    return ((ssn << 4) | fn).to_bytes(2, 'little')


def parse_ssc(b):
    v = int.from_bytes(b[:2], 'little')
    return v >> 4, v & 0xF


# ---- 9.4.1.13 рис. 9-96: Block Ack Parameter Set ----
BAParams = namedtuple('BAParams', 'amsdu policy tid buffer_size')
BA_POLICY_IMMEDIATE = 1     # 9.4.1.13: «set to 1 for immediate or HT-immediate block ack»


def encode_ba_params(p):
    """Рис. 9-96: B0 A-MSDU Supported, B1 Block Ack Policy, B2–B5 TID, B6–B15 Buffer Size."""
    if p.amsdu not in (0, 1) or p.policy not in (0, 1) or not 0 <= p.tid < 16 or not 0 <= p.buffer_size < 1024:
        raise ValueError('поле Block Ack Parameter Set вне диапазона')
    return (p.amsdu | p.policy << 1 | p.tid << 2 | p.buffer_size << 6).to_bytes(2, 'little')


def parse_ba_params(b):
    v = int.from_bytes(b[:2], 'little')
    return BAParams(v & 1, (v >> 1) & 1, (v >> 2) & 0xF, v >> 6)


# ---- 9.4.1.16 рис. 9-99: DELBA Parameter Set ----
def encode_delba_params(initiator, tid):
    """Рис. 9-99: B0–B10 Reserved, B11 Initiator (1 — originator, 0 — recipient), B12–B15 TID."""
    if initiator not in (0, 1) or not 0 <= tid < 16:
        raise ValueError('поле DELBA Parameter Set вне диапазона')
    return (initiator << 11 | tid << 12).to_bytes(2, 'little')


def parse_delba_params(b):
    v = int.from_bytes(b[:2], 'little')
    return (v >> 11) & 1, v >> 12


# ---- 9.6.4: кадры действия Block Ack (табл. 9-51, 9-359 … 9-362) ----
CATEGORY_BLOCK_ACK = 3                                  # табл. 9-51: «3 Block Ack»
ACT_ADDBA_REQ, ACT_ADDBA_RESP, ACT_DELBA = 0, 1, 2      # табл. 9-359
STATUS_SUCCESS, STATUS_REQUEST_DECLINED, STATUS_INVALID_PARAMETERS = 0, 37, 38   # табл. 9-50
REASON_END_BA, REASON_UNKNOWN_BA, REASON_TIMEOUT = 37, 38, 39                    # табл. 9-49

AddbaReq = namedtuple('AddbaReq', 'token params timeout ssn')
AddbaResp = namedtuple('AddbaResp', 'token status params timeout')


def encode_addba_req(r):
    """Табл. 9-360: Category, Block Ack Action (0), Dialog Token, Parameter Set, Timeout, Starting Sequence Control.
    9.6.4.2: «The Dialog Token field is set to a nonzero value»; «The Fragment Number subfield is set to 0»."""
    if not 1 <= r.token <= 255:
        raise ValueError('Dialog Token должен быть ненулевым')
    return (bytes([CATEGORY_BLOCK_ACK, ACT_ADDBA_REQ, r.token]) + encode_ba_params(r.params)
            + r.timeout.to_bytes(2, 'little') + encode_ssc(r.ssn))


def parse_addba_req(b):
    if b[0] != CATEGORY_BLOCK_ACK or b[1] != ACT_ADDBA_REQ:
        raise ValueError('не ADDBA Request')
    ssn, fn = parse_ssc(b[7:9])
    if fn:
        raise ValueError('9.6.4.2: Fragment Number должен быть 0')
    return AddbaReq(b[2], parse_ba_params(b[3:5]), int.from_bytes(b[5:7], 'little'), ssn)


def encode_addba_resp(r):
    """Табл. 9-361: Category, Block Ack Action (1), Dialog Token, Status Code, Parameter Set, Timeout.
    Originator Preferred MCS — только S1G (9.6.4.3), не кодируется."""
    return (bytes([CATEGORY_BLOCK_ACK, ACT_ADDBA_RESP, r.token]) + r.status.to_bytes(2, 'little')
            + encode_ba_params(r.params) + r.timeout.to_bytes(2, 'little'))


def parse_addba_resp(b):
    if b[0] != CATEGORY_BLOCK_ACK or b[1] != ACT_ADDBA_RESP:
        raise ValueError('не ADDBA Response')
    return AddbaResp(b[2], int.from_bytes(b[3:5], 'little'), parse_ba_params(b[5:7]), int.from_bytes(b[7:9], 'little'))


def encode_delba(initiator, tid, reason):
    """Табл. 9-362: Category, Block Ack Action (2), DELBA Parameter Set, Reason Code.
    DELBA GCR Group Address — только для GCR (10.25.4), здесь опущено."""
    return bytes([CATEGORY_BLOCK_ACK, ACT_DELBA]) + encode_delba_params(initiator, tid) + reason.to_bytes(2, 'little')


def parse_delba(b):
    if b[0] != CATEGORY_BLOCK_ACK or b[1] != ACT_DELBA:
        raise ValueError('не DELBA')
    initiator, tid = parse_delba_params(b[2:4])
    return initiator, tid, int.from_bytes(b[4:6], 'little')


# ---- 10.25.2: согласование ----
def agreement_allowed(a_ht_dmg_s1g, b_ht_dmg_s1g):
    """10.25.2: «A block ack agreement shall not be set up between a non-HT non-DMG non-S1G STA and another STA»."""
    return bool(a_ht_dmg_s1g and b_ht_dmg_s1g)


def check_addba_response(req, resp):
    """Проверка ответа на запрос; ValueError при нарушении. Buffer Size ответа может быть больше запроса (10.25.2)."""
    if resp.token != req.token:
        raise ValueError('9.6.4.3: «Dialog Token field value is copied from the corresponding received ADDBA Request»')
    if resp.status != STATUS_SUCCESS:
        return False                    # 10.25.2: «If … rejects the request, … shall not use the block ack mechanism»
    if resp.params.buffer_size < 1:
        raise ValueError('9.4.1.13: при SUCCESS «the Buffer Size subfield is set to at least 1»')
    if req.params.policy == 1 and resp.params.policy != 1:
        raise ValueError('10.25.2: ответ, принимающий запрос с Block Ack Policy 1, «shall contain 1»')
    if resp.params.tid != req.params.tid:
        raise ValueError('10.25.6.2: соглашение определяется TID из ADDBA Response — должен совпадать с запросом')
    return True


def make_addba_response(req, *, accept=True, buffer_size=64, amsdu=0, timeout=None):
    """Ответ получателя. Решение принять/отклонить, размер буфера, A-MSDU, таймаут — выбор получателя (10.25.2:
    «has the option of accepting or rejecting»; «indicates … the number of buffers … and the block ack timeout»;
    NOTE 3: «free to respond with any setting of the A-MSDU supported field»). Buffer Size и Timeout запроса —
    рекомендательные («are advisory»). Политика: копия 1 по 10.25.2."""
    p = BAParams(amsdu, req.params.policy, req.params.tid, buffer_size)
    if not accept:
        return AddbaResp(req.token, STATUS_REQUEST_DECLINED, p._replace(buffer_size=0), 0)
    if buffer_size < 1:
        raise ValueError('9.4.1.13: при SUCCESS Buffer Size ≥ 1')
    return AddbaResp(req.token, STATUS_SUCCESS, p, req.timeout if timeout is None else timeout)


def recipient_win_size(resp_buffer_size):
    """10.25.6.3: WinSizeR — «the smaller of 64 and the value of the Buffer Size field of the … ADDBA Response»
    (так же WinSizeB, 10.25.6.6.1)."""
    return min(BITMAP_LEN, resp_buffer_size)


def originator_win_size(req_buffer_size, resp_buffer_size, grow=False):
    """10.25.2: при ответе < запроса WinSizeO ≤ ответа и ≤ 64 («shall change»); при ответе > запроса —
    «may change» (параметр grow, по умолчанию окно = запросу). Запрос 0 — «no information» (9.4.1.13) → по ответу.
    Ограничение 64 — также из битовой карты Compressed BlockAck (9.3.1.8.2)."""
    if resp_buffer_size < req_buffer_size:
        return min(resp_buffer_size, BITMAP_LEN)
    if req_buffer_size == 0 or (resp_buffer_size > req_buffer_size and grow):
        return min(resp_buffer_size, BITMAP_LEN)
    return min(req_buffer_size, BITMAP_LEN)


class InactivityTimer:
    """11.5.4 / 9.4.1.14: Block Ack Timeout в TU, 0 — выключен; сброс у получателя — MPDU с политикой Block Ack /
    Implicit BAR и BlockAckReq, у отправителя — BlockAck; по истечении — DELBA с Reason TIMEOUT.
    Граница (≥ или >) не определена — выбрано ≥."""

    def __init__(self, timeout_tu, now=Fr(0)):
        self.timeout = Fr(timeout_tu) * TU
        self.last = Fr(now)

    def reset(self, now):
        self.last = Fr(now)

    def expired(self, now):
        return self.timeout != 0 and Fr(now) - self.last >= self.timeout


# ---- 9.2.4.5.4 табл. 9-13: политика подтверждения ----
NORMAL_OR_IMPLICIT, NO_ACK, NO_EXPLICIT, BLOCK_ACK = (0, 0), (1, 0), (0, 1), (1, 1)   # (бит 0, бит 1)


def ack_policy_name(bits, in_ampdu):
    """Табл. 9-13: (0,0) — Normal Ack вне A-MPDU, Implicit BAR в A-MPDU («MPDU is not a non-A-MPDU frame»)."""
    if bits == NORMAL_OR_IMPLICIT:
        return 'implicit_bar' if in_ampdu else 'normal'
    return {NO_ACK: 'no_ack', NO_EXPLICIT: 'no_explicit', BLOCK_ACK: 'block_ack'}[bits]


def ampdu_response(received_policies):
    """10.25.6.5: на A-MPDU с ≥1 QoS Data с Implicit BAR — BlockAck через SIFS; 10.25.6.7: ответ ожидается,
    «if at least one Data frame is received without error». received_policies — политики безошибочно принятых MPDU."""
    return 'BlockAck' if 'implicit_bar' in received_policies else None


# ---- 9.3.1.7 / 9.3.1.8: BAR Control, BA Control, BA Information ----
def encode_ba_control(multi_tid, compressed, gcr_mode, tid):
    """Рис. 9-42 (и рис. 9-36 для BAR Control): B0 Reserved, B1 Multi-TID, B2 Compressed Bitmap, B3–B4 GCR Mode,
    B5–B11 Reserved, B12–B15 TID_INFO."""
    if multi_tid not in (0, 1) or compressed not in (0, 1) or not 0 <= gcr_mode < 4 or not 0 <= tid < 16:
        raise ValueError('поле BA Control вне диапазона')
    return (multi_tid << 1 | compressed << 2 | gcr_mode << 3 | tid << 12).to_bytes(2, 'little')


def parse_ba_control(b):
    v = int.from_bytes(b[:2], 'little')
    return (v >> 1) & 1, (v >> 2) & 1, (v >> 3) & 3, v >> 12


encode_bar_control, parse_bar_control = encode_ba_control, parse_ba_control

# Табл. 9-28 (и 9-27): (Multi-TID, Compressed Bitmap, GCR Mode) → вариант. Столбец «subfield value (B3 B4)»
# читается как биты слева направо: «01» — B3 = 0, B4 = 1 (толкование; порядок цифр в таблице не пояснён).
# Ключи — (Multi-TID, Compressed, (B3, B4)).
_VARIANTS = {
    (0, 1, (0, 0)): 'compressed', (0, 1, (0, 1)): 'glk_gcr', (0, 1, (1, 0)): 'gcr',
    (1, 0, (0, 0)): 'extended_compressed', (1, 1, (0, 0)): 'multi_tid',
}


def ba_variant(multi_tid, compressed, gcr_mode):
    """Табл. 9-28: вариант BlockAck; остальные сочетания — Reserved (ValueError)."""
    key = (multi_tid, compressed, (gcr_mode & 1, gcr_mode >> 1))
    if key not in _VARIANTS:
        raise ValueError('табл. 9-28: Reserved')
    return _VARIANTS[key]


def dmg_ba_variant(bar_compressed_bit):
    """10.25.5 (DMG BSS): Compressed Bitmap BAR = 1 → далее Compressed = 1, Multi-TID = 0 (Compressed);
    = 0 → Compressed = 0, Multi-TID = 1 (Extended Compressed). 9.3.1.7.1: «DMG STAs use only the Compressed …
    and the Extended Compressed» варианты. Возврат (multi_tid, compressed)."""
    return (0, 1) if bar_compressed_bit else (1, 0)


def encode_ba_info(ssn, bitmap, rbufcap=None):
    """Рис. 9-43 (Compressed): SSC (2) + Bitmap (8); рис. 9-45 (Extended Compressed): + RBUFCAP (1).
    Бит i карты — SN = SSN + i; бит 0 = B0 первого октета (little-endian)."""
    if not 0 <= bitmap < 1 << BITMAP_LEN:
        raise ValueError('битовая карта > 64 бит')
    out = encode_ssc(ssn) + bitmap.to_bytes(8, 'little')
    if rbufcap is not None:
        out += bytes([rbufcap])
    return out


def parse_ba_info(b, extended=False):
    ssn, fn = parse_ssc(b[:2])
    if fn:
        raise ValueError('9.3.1.8.2: Fragment Number должен быть 0')
    bitmap = int.from_bytes(b[2:10], 'little')
    return (ssn, bitmap, b[10]) if extended else (ssn, bitmap)


def bitmap_sns(ssn, bitmap):
    """SN, отмеченные 1 в карте (9.3.1.8.2: первый бит — SN = SSN)."""
    return [sn_add(ssn, i) for i in range(BITMAP_LEN) if bitmap >> i & 1]


# ---- 10.25.6.3 / 10.25.6.4: учёт получателя (scoreboard) ----
class Scoreboard:
    """Запись подтверждений: WinStartR, WinEndR, WinSizeR, битовая карта (множество SN с битом 1 в окне).
    partial=True — частичное состояние (10.25.6.4): записи нет до первого кадра, drop() — вытеснение из кэша."""

    def __init__(self, win_size, ssn, partial=False):
        self.size = win_size
        self.partial = partial
        self.bits = set()
        self.start = self.end = None
        if not partial:                          # 10.25.6.3 a)
            self._set(ssn)

    def _set(self, start):
        self.start = start
        self.end = sn_add(start, self.size - 1)  # «WinEndR = WinStartR + WinSizeR – 1»

    def _clear(self, first, n):
        """Обнулить n бит, начиная с SN = first."""
        for i in range(n):
            self.bits.discard(sn_add(first, i))

    @property
    def has_record(self):
        return self.start is not None

    def drop(self):
        """10.25.6.4: «the temporary record may be discarded if the resources … are needed»."""
        assert self.partial
        self.start = self.end = None
        self.bits.clear()

    def on_data(self, sn):
        if not self.has_record:                  # 10.25.6.4 b)
            self.end = sn
            self.start = sn_add(sn, 1 - self.size)
            self.bits = {sn}
            return
        r = sn_region(sn, self.start, self.end)  # 10.25.6.3 b) (FN — только S1G, здесь 0)
        if r == IN:                              # b)1) «set to 1 the bit in position SN»
            self.bits.add(sn)
        elif r == AHEAD:                         # b)2)
            self._clear(sn_add(self.end, 1), sn_off(sn, self.end) - 1)   # «from WinEndR+1 to SN – 1»
            self.start = sn_add(sn, 1 - self.size)
            self.end = sn
            self.bits.add(sn)
        # b)3) BEHIND: «make no changes to the record»

    def on_bar(self, ssn):
        if not self.has_record:                  # 10.25.6.4 d)
            self._set(ssn)
            self.bits = set()
            return
        r = sn_region(ssn, self.start, self.end)
        if r == IN:                              # c)1) WinStartR < SSN ≤ WinEndR (при SSN = WinStartR — без изменений)
            old_end = self.end
            self._set(ssn)
            self._clear(sn_add(old_end, 1), sn_off(self.end, old_end))   # «from WinEndR + 1 to WinStartR + WinSizeR – 1»
        elif r == AHEAD:                         # c)2)
            self._set(ssn)
            self._clear(self.start, self.size)
        # c)3) BEHIND: «make no changes to the record»

    def bitmap(self, ssn=None, below_start=0):
        """10.25.6.5: SSN ∈ [WinEndR − 63, WinStartR] (выбор реализации, по умолчанию WinStartR); биты от WinStartR
        до WinEndR — из записи; ниже WinStartR — «may be set to any value» (below_start: 0 или 1); выше WinEndR — 0."""
        if ssn is None:
            ssn = self.start
        if sn_off(self.start, ssn) > BITMAP_LEN - self.size:
            raise ValueError('10.25.6.5: SSN вне (WinEndR – 63) … WinStartR')
        bm = 0
        for i in range(BITMAP_LEN):
            sn = sn_add(ssn, i)
            if sn_off(sn, self.start) >= HALF:            # ниже WinStartR
                bit = below_start
            else:
                bit = int(sn_region(sn, self.start, self.end) == IN and sn in self.bits)
            bm |= bit << i
        return ssn, bm


# ---- 10.25.6.6: буфер переупорядочения ----
STORED, DUPLICATE, OLD = 'stored', 'duplicate', 'old'


class ReorderBuffer:
    """WinStartB, WinEndB, WinSizeB, буфер; delivered — MSDU, выданные вверх (SN, msdu), по порядку SN."""

    def __init__(self, win_size, ssn):
        self.size = win_size                      # 10.25.6.6.1: min(64, Buffer Size ответа) — делает вызывающий
        self.start = ssn                          # «WinStartB is initialized to the Starting Sequence Number …»
        self.end = sn_add(ssn, win_size - 1)
        self.buf = {}
        self.delivered = []

    def _pass(self, sn):
        self.delivered.append((sn, self.buf.pop(sn)))

    def _pass_below(self, new_start, base):
        """«Pass any complete MSDUs … lower than the new value of WinStartB … Gaps may exist»."""
        for sn in sorted((s for s in self.buf if sn_off(s, base) < sn_off(new_start, base)),
                         key=lambda s: sn_off(s, base)):
            self._pass(sn)

    def _pass_seq(self):
        """Последовательная выдача от WinStartB, WinStartB = последний + 1, WinEndB = WinStartB + WinSizeB – 1."""
        while self.start in self.buf:
            self._pass(self.start)
            self.start = sn_add(self.start, 1)
        self.end = sn_add(self.start, self.size - 1)

    def on_data(self, sn, msdu=None, dmg_hint=False):
        """10.25.6.6.2. dmg_hint — выполнено одно из условий a)2) i)–v) для DMG STA (проверка разделителей
        A-MPDU и SIFS/RIFS — забота вызывающего); тогда при SN > WinStartB выдача начинается с SN."""
        r = sn_region(sn, self.start, self.end)
        if r == BEHIND:                           # c) «discard the MPDU»
            return OLD
        if sn in self.buf:                        # a)1)/b)1) «otherwise discard the MPDU»
            return DUPLICATE
        self.buf[sn] = msdu
        if r == IN:                               # a)
            if dmg_hint and sn != self.start:
                base = self.start
                self._pass_below(sn, base)
                self.start = sn
            self._pass_seq()
        else:                                     # b) AHEAD
            base = self.start
            self.end = sn
            self.start = sn_add(sn, 1 - self.size)
            self._pass_below(self.start, base)
            self._pass_seq()                      # для DMG — правила a)2): без подсказки совпадает с non-DMG
        return STORED

    def on_bar(self, ssn):
        """10.25.6.6.3 a): WinStartB < SSN < WinStartB + 2^11 → сдвиг и выдача; b) иначе без изменений."""
        d = sn_off(ssn, self.start)
        if 0 < d < HALF:
            base = self.start
            self.start = ssn
            self._pass_below(ssn, base)
            self._pass_seq()

    def flush(self):
        """Выдача по таймауту — выбор реализации (в 10.25.6.6 таймаута нет): всё буферизованное по порядку SN,
        WinStartB = последний + 1 — как BlockAckReq с SSN = последний + 1."""
        if self.buf:
            last = max(self.buf, key=lambda s: sn_off(s, self.start))
            self.on_bar(sn_add(last, 1))


# ---- получатель целиком ----
ACCEPT = 'accept'


class Recipient:
    """Получатель соглашения: scoreboard + буфер переупорядочения + кэш дубликатов RC2 (табл. 10-6).
    win_size — Buffer Size из ADDBA Response (WinSizeR = WinSizeB = min(64, …)); ssn — SSN из ADDBA Request."""

    def __init__(self, win_size, ssn, *, partial=False, dup_cache=1, below_start=0, null_ba_without_state=False):
        self.size = recipient_win_size(win_size)
        self.sb = Scoreboard(self.size, ssn, partial)
        self.rb = ReorderBuffer(self.size, ssn)
        # Табл. 10-6 RC2 (QoS Data, <Address 2, TID, SN, FN>, «at least the most recent cache entry»); RR4:
        # исключение для кадров под BA — только «in a non-DMG BSS», в DMG кэш действует. Размер — dup_cache.
        self.cache = deque(maxlen=dup_cache)
        self.below_start = below_start
        # 10.25.6.5: «no matching partial state is available» → null BlockAck. Когда запись нельзя создать
        # (нет ресурсов) — выбор реализации: null_ba_without_state=True — не создавать запись по BAR.
        self.null_ba_without_state = null_ba_without_state

    @property
    def delivered(self):
        return self.rb.delivered

    def on_mpdu(self, sn, retry=False, msdu=None, dmg_hint=False):
        """Принятый без ошибки QoS Data. Возврат: ACCEPT, DUPLICATE (кэш RR5 или уже в буфере), OLD (вне окна
        снизу, 10.25.6.6.2 c). Scoreboard обновляется всегда (10.25.6.2: «Each received MPDU is analyzed by the
        scoreboard … as well as by the receive reordering buffer»; 10.3.2.14.3 NOTE: подтверждение и для дубликатов)."""
        self.sb.on_data(sn)
        dup = retry and sn in self.cache         # RR5: «discard the frame if the Retry subfield … is 1 and it matches»
        self.cache.append(sn)                     # «a record of that frame is inserted in an appropriate cache»
        if dup:
            return DUPLICATE
        r = self.rb.on_data(sn, msdu, dmg_hint)
        return ACCEPT if r == STORED else r

    def build_blockack(self, ssn=None):
        """10.25.6.5 → (SSN, bitmap)."""
        if not self.sb.has_record:
            raise ValueError('нет записи частичного состояния')
        return self.sb.bitmap(ssn, self.below_start)

    def on_ampdu(self, mpdus):
        """mpdus — безошибочно принятые MPDU: (sn, retry, ack_policy_bits). Возврат (SSN, bitmap) или None.
        10.25.6.5: корректировка WinStartR — до формирования BlockAck."""
        pols = []
        for sn, retry, bits in mpdus:
            self.on_mpdu(sn, retry)
            pols.append(ack_policy_name(bits, True))
        return self.build_blockack() if ampdu_response(pols) else None

    def on_bar(self, ssn):
        """BlockAckReq (не защищённое соглашение): 10.25.6.3 c) / 10.25.6.4 d,e), 10.25.6.6.3, ответ BlockAck."""
        if self.sb.partial and not self.sb.has_record and self.null_ba_without_state:
            self.rb.on_bar(ssn)
            return ssn, 0                         # «a null BlockAck frame in which the bitmap is set to all 0s»
        self.sb.on_bar(ssn)
        self.rb.on_bar(ssn)
        return self.build_blockack()


# ---- 10.25.6.7 / 10.25.6.8: отправитель ----
NEW, SENT, RETRY, ACKED, DROPPED = 'new', 'sent', 'retry', 'acked', 'dropped'


class Originator:
    """Буфер передачи: WinStartO, WinSizeO, состояние каждого SN. ssn — Starting Sequence Number ADDBA Request
    (10.25.2: «set the sequence number of the first frame … to the value of the … Starting Sequence Control»)."""

    def __init__(self, win_size, ssn=0):
        self.size = win_size
        self.start = ssn
        self.next_sn = ssn
        self.state = {}

    @property
    def end(self):
        return sn_add(self.start, self.size - 1)

    def in_window(self, sn):
        return sn_off(sn, self.start) < self.size

    def enqueue(self, n=1):
        """Новые MSDU: номера подряд по модулю 4096 (10.3.2.14.2: «incrementing by 1, for each MSDU»)."""
        out = []
        for _ in range(n):
            self.state[self.next_sn] = NEW
            out.append(self.next_sn)
            self.next_sn = sn_add(self.next_sn, 1)
        return out

    def build_ampdu(self, max_mpdus=BITMAP_LEN):
        """10.25.6.7 (DMG): сначала повторы по порядку SN от старейшего, затем впервые передаваемые по порядку SN;
        все — в окне («provided that their sequence numbers lie within the current transmission window»)."""
        def ordered(st):
            return sorted((s for s, v in self.state.items() if v == st and self.in_window(s)),
                          key=lambda s: sn_off(s, self.start))
        sel = (ordered(RETRY) + ordered(NEW))[:max_mpdus]
        for s in sel:
            self.state[s] = SENT
        return sel

    def on_blockack(self, ssn, bitmap):
        """10.25.6.8: SN от WinStartO до SSN − 1 не обновлять; SN от SSN до WinStartO + WinSizeO − 1 с битом 1 —
        «change its status to acknowledged» (NOTE 2: подтверждённый не возвращается в неподтверждённые).
        Переданные с битом 0 в покрытой картой части — к повтору. Возврат (подтверждённые, к повтору); затем окно
        сдвигается к старейшему неподтверждённому (освобождение буферов, 10.25.6.2)."""
        acked, retry = [], []
        for i in range(BITMAP_LEN):
            sn = sn_add(ssn, i)
            if not self.in_window(sn) or self.state.get(sn) not in (SENT, RETRY):
                continue
            if bitmap >> i & 1:
                self.state[sn] = ACKED
                acked.append(sn)
            else:
                self.state[sn] = RETRY
                retry.append(sn)
        self._advance()
        return acked, retry

    def on_blockack_lost(self):
        """10.25.6.7: «If the BlockAck frame is lost, … may transmit a BlockAckReq … or … retransmit» — здесь
        к повтору (BlockAckReq — bar_ssn())."""
        for s, v in self.state.items():
            if v == SENT:
                self.state[s] = RETRY

    def discard(self, sn):
        """10.25.6.7: истёк срок жизни MSDU («shall not retransmit an MPDU after … lifetime limit») → можно послать
        BlockAckReq, чтобы сдвинуть WinStartB за дыру. Возврат SSN для BlockAckReq."""
        self.state[sn] = DROPPED
        self._advance()
        return self.bar_ssn()

    def bar_ssn(self):
        """9.3.1.7.2: SSN BlockAckReq — «the first MSDU … for which this BlockAckReq frame is sent» = WinStartO."""
        return self.start

    def _advance(self):
        while self.state.get(self.start) in (ACKED, DROPPED):
            del self.state[self.start]
            self.start = sn_add(self.start, 1)
