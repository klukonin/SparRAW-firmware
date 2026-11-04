# SPDX-License-Identifier: AGPL-3.0-or-later
"""Sector Level Sweep (SLS) DMG по 802.11-2020: 10.42.1 (общие правила BF), 10.42.2 (ISS, RSS, SSW feedback, SSW ack),
10.42.4 (ISS в BTI DMG Beacon-ами), 10.42.6.2 (исполнение SLS в DTI: SP/CBAP, MBIFS, повторы SSW-Feedback, PIFS),
10.42.8 (автоматы рис. 10-91/10-92), IFS 10.3.2.3.8/10/11, поля 9.3.1.15–17, 9.5.1, 9.5.3, 9.5.5 в части SLS,
модуляция 10.6.7.1. Время — Fraction, мкс, моменты «на эфире» (10.3.2.3.8: от конца последнего символа до начала
преамбулы следующего кадра).

Состав:
  BfFrame                         — кадр BF в журнале эфира (SSW / SSW-Feedback / SSW-Ack / DMG Beacon).
  sweep_slots, plan_sweep         — раскладка TXSS/RXSS: сектора × антенны × повторы, LBIFS, CDOWN, моменты.
  Initiator, Responder            — событийные автоматы SLS в DTI (рис. 10-91 / 10-92).
  SlsLink                         — эфир «точка-точка» с моделью канала (сектор TX × конфигурация RX → SNR).
  bti_txss                        — ISS в BTI (10.42.4), в т. ч. фрагментированный по нескольким BTI.
  check_sls_log(frames, ctx)      — проверка журнала эфира одного SLS, список нарушений.
  кодеки: snr_report, rxss_length, total_sectors_field, total_sectors_in_iss_field.

Не моделируется: A-BFT (10.42.5 — модуль abft.py; здесь только признак in_abft там, где правило отличается), BRP и
MIDC (10.42.3, 10.42.6.3/4 — brp.py), получение TXOP backoff-ом (cbap.py), сопровождение луча (10.42.7), CDMG/CMMG,
MMSL-кластеры, «успешность» SLS по 10.42.1 (ответ на кадр через выбранный сектор — уровень выше SLS)."""
from fractions import Fraction as Fr
from math import floor

from .duration import duration_dmg_beacon, duration_ssw, duration_ssw_ack, duration_ssw_fb
from .fields import snr_from_raw, snr_quantize, snr_report_raw, total_sectors_raw
from .fields import total_sectors_in_iss as fields_total_sectors_in_iss
from .timing import (ANT_ID_MAX, CDOWN_MAX, DOT11_MAX_BF_TIME, LBIFS, lbifs, LBIFS_TOL, LEN_SSW, LEN_SSW_ACK,
                     LEN_SSW_FB, MAX_SECTORS_PER_ANT, MAX_SECTORS_TOTAL, MBIFS, MBIFS_TOL, PIFS, PIFS_TOL, SBIFS,
                     SBIFS_MAX, SECTOR_ID_MAX, SIFS, T_SSW, T_SSW_ACK, T_SSW_FB, txtime)

# Длины/TXTIME SSW-кадров, LBIFS, SBIFS_MAX, допуски IFS, PIFS и пределы полей — timing.py (одно определение).
RXSS_TXRATE_MCS = 1                     # 10.6.7.1 / 9.5.5: «remaining frames use MCS 1 of the DMG SC modulation class»
SLOT = T_SSW + SBIFS                    # шаг сетки CDOWN: LBIFS = TXTIME(SSW) + 2·SBIFS занимает ровно один шаг

# ---- MIB (Annex C, dot11DMGBeamformingConfigEntry) ----
# dot11MaxBFTime (T2 на рис. 10-91/10-92) — timing.DOT11_MAX_BF_TIME
dot11BFTXSSTime = Fr(100_000)   # DEFVAL 100 «milliseconds» → мкс (T1 на рис. 10-91): «Timeout until the initiator
                                # restarts ISS»
dot11MaximalSectorScan = 8      # DEFVAL 8, «beacon intervals»
dot11BFRetryLimit = 8           # DEFVAL 8

# ---- ограничения полей: MAX_SECTORS_PER_ANT / MAX_SECTORS_TOTAL (10.42.1) — timing.py ----

SSW, SSW_FB, SSW_ACK, BEACON = 'SSW', 'SSW-Feedback', 'SSW-Ack', 'DMG Beacon'
TXSS, RXSS = 'TXSS', 'RXSS'
SP, CBAP = 'SP', 'CBAP'


# ======================================================================================================== кодеки
def snr_report(snr_db):
    """9.5.3: SNR Report = 8-бит дополнительный код 4×(SNR − 19), −13 … 50,75 дБ шагом 0,25.
    СПОРНО → принято (PLAN.md «Принятые трактовки» №6): округление не задано ни в 2020, ни в 2024 — одно правило для
    всех модулей: fields.snr_quantize (к ближайшему шагу, половина — вверх), вне диапазона — насыщение."""
    return snr_report_raw(snr_quantize(snr_db))


def snr_from_report(v):
    """Обратное к snr_report: дБ (Fraction)."""
    return snr_from_raw(v)


def rxss_length(field):
    """9.5.1 / 9.5.5 / DMG Capabilities: число SSW в RXSS = (RXSS Length + 1) × 2, поле 6 бит → 2 … 128."""
    if not 0 <= field <= 63:
        raise ValueError('RXSS Length — 6 бит')
    return (field + 1) * 2


def rxss_length_field(n):
    """Обратное к rxss_length: n чётное 2 … 128."""
    if n % 2 or not 2 <= n <= 128:
        raise ValueError('RXSS: 2…128 кадров, чётное')
    return n // 2 - 1


def total_sectors_field(n_slots):
    """DMG Capabilities / BF Control (9.5.5): Total Number of Sectors — число секторов TXSS «including any LBIFS
    required for DMG antenna switching … minus 1» (поле DMG Capabilities 7 бит в BF Control рис. 9-851)."""
    if not 1 <= n_slots <= 128:
        raise ValueError('Total Number of Sectors: 1…128')
    return n_slots - 1


def total_sectors_in_iss_field(n):
    """9.5.3: Total Sectors in ISS «Possible values range from 0 to 511, representing 1 to 512 sectors» → n − 1.
    СПОРНО → принято (PLAN.md «Принятые трактовки» №3): пример 10.42.2.2.1 («… subfield is set to 24») называет
    число секторов, а кодирование задаёт 9.5.3 — 23. Модель хранит число (24), кодирует n − 1 — та же функция, что
    fields.total_sectors_raw (FieldError — подкласс ValueError)."""
    return total_sectors_raw(n)


def total_sectors_in_iss(tx_sectors, peer_rx_antennas):
    """10.42.2.2.1: «sum of all sectors employed on all antennas in the ISS multiplied by the number of the
    responder's receive DMG antennas» (LBIFS не входит — пример даёт 24 при 4 + 3 + 5 и двух антеннах).
    Формула — fields.total_sectors_in_iss (одно определение), здесь — от словаря {антенна: [сектора]}."""
    return fields_total_sectors_in_iss([len(s) for s in tx_sectors.values()], peer_rx_antennas)


def check_antennas(tx_sectors):
    """10.42.1: ≤ 64 секторов на антенну, ≤ 128 всего; 9.5.1: Sector ID ≤ 63, DMG Antenna ID ≤ 3."""
    errs = []
    for a, secs in tx_sectors.items():
        if not 0 <= a <= ANT_ID_MAX:
            errs.append(f'DMG Antenna ID {a} вне 0…3 (9.5.1)')
        if len(secs) > MAX_SECTORS_PER_ANT:
            errs.append(f'антенна {a}: {len(secs)} > 64 секторов (10.42.1)')
        if len(set(secs)) != len(secs):
            errs.append(f'антенна {a}: Sector ID не уникальны (10.42.2.2.2)')
        if any(not 0 <= s <= SECTOR_ID_MAX for s in secs):
            errs.append(f'антенна {a}: Sector ID вне 0…63 (9.5.1)')
    if sum(len(s) for s in tx_sectors.values()) > MAX_SECTORS_TOTAL:
        errs.append('всего секторов > 128 (10.42.1)')
    return errs


def iss_start_after_grant(grant_end, grant_ack_supported, grant_ack_end=None):
    """10.42.2.2.2 / 10.42.2.2.3 (CBAP через Grant): «starts the initiator TXSS SIFS after transmission of the Grant
    frame or after the reception of the Grant Ack frame if the Grant Ack Supported field … is 1 or PIFS interval after
    the transmission the Grant frame otherwise».
    СПОРНО: чтение А (принято) — Grant Ack Supported = 1: SIFS после конца Grant Ack; иначе PIFS после Grant. Чтение Б
    — «SIFS после Grant» как отдельный третий случай (без Grant Ack при Supported = 1); не моделируется."""
    if grant_ack_supported:
        if grant_ack_end is None:
            raise ValueError('Grant Ack Supported = 1: нужен конец Grant Ack')
        return Fr(grant_ack_end) + SIFS
    return Fr(grant_end) + PIFS


# ======================================================================================================== кадр
class BfFrame:
    """Кадр BF на эфире. t — начало преамбулы; tx — (антенна, сектор), через которые реально передан (для проверки
    «transmitted through the sector …»); поля SSW (9.5.1): direction, cdown, sector_id, antenna_id, rxss_len (поле,
    только CBAP, иначе None — reserved); SSW Feedback (9.5.3): fb — dict: в ISS {'total', 'n_rx_ant', 'poll'}, иначе
    {'sector', 'antenna', 'snr', 'poll'} (sector/antenna None — reserved); brp — BRP Request (9.5.4) dict;
    trn — TRN_LEN TXVECTOR (10.42.2.1: 0)."""
    __slots__ = ('kind', 'ta', 'ra', 't', 'length', 'mcs', 'dur', 'direction', 'cdown', 'sector_id', 'antenna_id',
                 'rxss_len', 'fb', 'brp', 'tx', 'trn', 'fragmented', 'txss_span')

    def __init__(self, kind, ta, ra, t, *, length=None, mcs=0, dur=None, direction=None, cdown=None, sector_id=None,
                 antenna_id=None, rxss_len=None, fb=None, brp=None, tx=None, trn=0, fragmented=None, txss_span=None):
        self.kind, self.ta, self.ra, self.t, self.mcs, self.dur = kind, ta, ra, Fr(t), mcs, dur
        self.length = {SSW: LEN_SSW, SSW_FB: LEN_SSW_FB, SSW_ACK: LEN_SSW_ACK}.get(kind) if length is None else length
        self.direction, self.cdown, self.sector_id, self.antenna_id = direction, cdown, sector_id, antenna_id
        self.rxss_len, self.fb, self.brp, self.trn = rxss_len, dict(fb or {}), dict(brp or {}), trn
        self.tx = tx if tx is not None else (antenna_id, sector_id)
        self.fragmented, self.txss_span = fragmented, txss_span

    @property
    def airtime(self):
        return txtime(self.length, self.mcs)

    @property
    def end(self):
        return self.t + self.airtime

    def __repr__(self):
        s = f'{self.kind}({self.ta}->{self.ra} t={float(self.t):.3f}'
        if self.cdown is not None:
            s += f' d={self.direction} cd={self.cdown} {self.antenna_id}/{self.sector_id}'
        return s + ')'


def brp_requested(brp):
    """9.3.1.16 a): «If a BRP phase is requested through the BRP Request field» — любой запрос в поле BRP Request
    (L-RX > 0, TX-TRN-REQ, MID-REQ, BC-REQ; 9.5.4)."""
    return any(brp.get(k) for k in ('L-RX', 'TX-TRN-REQ', 'MID-REQ', 'BC-REQ'))


# ======================================================================================================== раскладка
LB = ('LBIFS',)     # маркер LBIFS в последовательности слотов


def sweep_slots(tx_sectors, rx_reps=1):
    """Последовательность слотов TXSS: для каждого повтора (приёмная антенна партнёра, 10.42.2.2.2 / 10.42.2.3.2 /
    10.42.6.2 «repeat its ISS k+1 times») — антенны по возрастанию ID (10.42.2.3.2: «in increasing order of DMG
    antenna ID»; для инициатора порядок не задан — берём тот же), внутри — сектора в заданном порядке. Между блоками
    (смена своей антенны — 10.3.2.3.11 «different DMG antennas», или повтор под другую антенну приёмника — «recipient
    STA is expected to switch DMG antennas») — LBIFS. Элементы: (антенна, сектор, повтор) или LB."""
    out = []
    for rep in range(rx_reps):
        for a in sorted(tx_sectors):
            if not tx_sectors[a]:
                continue
            if out:
                out.append(LB)
            out.extend((a, s, rep) for s in tx_sectors[a])
    return out


def rxss_slots(tx, n, rx_switch_after=()):
    """RXSS (10.42.2.2.3 / 10.42.2.3.3): n слотов через один (антенна, сектор); слоты с индексами из rx_switch_after
    — LBIFS под смену антенны приёмника (10.42.2.2.3: «sweep RXSS Length sectors, including any LBIFS if required»:
    LBIFS входит в число n)."""
    a, s = tx
    return [LB if k in rx_switch_after else (a, s, 0) for k in range(n)]


def slots_cdown(slots, lbifs_in_cdown=True):
    """CDOWN каждого кадра: «total number of transmissions remaining until the end …, including any LBIFS if
    required» (10.42.2.2.2, 10.42.2.3.2) — LBIFS считается одной передачей. Так CDOWN=k всегда стоит на сетке
    SLOT = TXTIME(SSW) + SBIFS от конца сweep-а (LBIFS = TXTIME(SSW) + 2·SBIFS — ровно пропущенный слот), и
    ожидаемый конец CDOWN=0 (10.42.2.2.2 «expected end time») вычисляется по любому принятому кадру.
    СПОРНО → принято (PLAN.md №2): LBIFS — одна передача (так же abft.sweep_positions); вариант lbifs_in_cdown=False
    оставлен как документированная альтернатива — CDOWN считает только кадры; тогда «initial value … total number of
    sectors … × number of DMG antennas at the initiator minus one» (10.42.2.3.2) сходится без LBIFS между повторами, но
    конец sweep-а по CDOWN не вычислим."""
    res, k = [], 0
    for sl in reversed(slots):
        if sl is LB:
            k += 1 if lbifs_in_cdown else 0
            continue
        res.append(k)
        k += 1
    return list(reversed(res))


def expected_sweep_end(t_end, cdown, t_frame=T_SSW):
    """10.42.2.2.2 / 10.42.2.3.2: «shall assume that the … TXSS has completed at the expected end time of this
    [CDOWN=0] frame»: t_end + CDOWN·(TXTIME + SBIFS) (сетка slots_cdown)."""
    return Fr(t_end) + cdown * (t_frame + SBIFS)


def plan_sweep(slots, t0, ta, ra, direction, *, alloc_end=None, mcs_seq=None, lbifs_in_cdown=True, fb=None,
               rxss_len=None, dur=True):
    """Кадры SSW sweep-а с моментами: соседние кадры через SBIFS, через LBIFS при маркере (10.42.2.2.2, рис. 10-70,
    10-71); сweep обрывается на конце распределения (10.42.2.2.2 «unless the allocation ends as described in
    10.42.6»; 10.42.6.2 «ISS phase shall not be fragmented across multiple allocations»). Duration — 9.3.1.15."""
    cds = slots_cdown(slots, lbifs_in_cdown)
    frames, t, i, prev_end = [], Fr(t0), 0, None
    for sl in slots:
        if sl is LB:
            # LBIFS вместо SBIFS: следующий кадр через LBIFS после конца предыдущего
            t = prev_end + LBIFS if prev_end is not None else t
            prev_end = None
            continue
        if prev_end is not None:
            t = prev_end + SBIFS
        a, s, _ = sl
        mcs = mcs_seq[i] if mcs_seq else 0
        f = BfFrame(SSW, ta, ra, t, mcs=mcs, direction=direction, cdown=cds[i], sector_id=s, antenna_id=a,
                    rxss_len=rxss_len, fb=fb)
        if alloc_end is not None and f.end > alloc_end:
            break
        if dur:
            rem = None if alloc_end is None else alloc_end - f.end
            f.dur = duration_ssw(cds[i], f.airtime, alloc_remaining=rem)
        frames.append(f)
        prev_end, i = f.end, i + 1
    return frames


def sweep_length(slots, t_frame=T_SSW):
    """Время sweep-а от начала первого до конца последнего кадра (все кадры одной длины)."""
    n = len(slots)
    return n * t_frame + (n - 1) * SBIFS if n else Fr(0)


# ======================================================================================================== BTI
def bti_txss(sectors, per_bti, t0s, beacon_len, *, bti_ends=None):
    """10.42.4: ISS в BTI — только DMG Beacon (не SSW), Direction 0, CDOWN — оставшиеся передачи до конца всего TXSS
    (во фрагментированном — по всем BTI), Fragmented TXSS = 1, если в BTI не все сектора; TXSS Span — число BI на
    весь TXSS (< dot11MaximalSectorScan); Duration — до конца текущего BTI; «shall not change DMG antennas within a
    BTI». sectors — [(антенна, сектор)] всего TXSS; per_bti — число Beacon в каждом BTI; t0s — начало каждого BTI;
    beacon_len — длина DMG Beacon, октеты (10.6.7.1: DMG Control); bti_ends — конец BTI (по умолчанию — конец
    последнего Beacon). Между Beacon — SBIFS (10.42.2.2.2 «Each transmitted BF frame shall be separated by … SBIFS»).
    Возвращает [[BfFrame…] на каждый BTI]; ValueError при нарушении 10.42.4."""
    if sum(per_bti) != len(sectors):
        raise ValueError('per_bti должен покрыть все сектора')
    span = len(per_bti)
    if span >= dot11MaximalSectorScan:
        raise ValueError('10.42.4: TXSS Span shall be lower than dot11MaximalSectorScan')
    frag = 1 if span > 1 else 0         # 10.42.4: «In a BTI with a fragmented initiator TXSS … set to 1»
    out, k, n = [], 0, len(sectors)
    for b, cnt in enumerate(per_bti):
        chunk = sectors[k:k + cnt]
        if len({a for a, _ in chunk}) > 1:
            raise ValueError('10.42.4: AP or PCP shall not change DMG antennas within a BTI')
        t, fr = Fr(t0s[b]), []
        for j, (a, s) in enumerate(chunk):
            f = BfFrame(BEACON, 'ap', 'bcast', t, length=beacon_len, direction=0, cdown=n - 1 - (k + j),
                        sector_id=s, antenna_id=a, fragmented=frag, txss_span=span)
            fr.append(f)
            t = f.end + SBIFS
        end = Fr(bti_ends[b]) if bti_ends else fr[-1].end
        for f in fr:
            # 10.42.4 / 9.3.4.2: до конца BTI; 9.2.5.1: вверх — та же функция, что в bi.bti_beacons (PLAN.md №5:
            # конец BTI = конец последнего маяка + его Duration)
            f.dur = duration_dmg_beacon(end - f.end)
        out.append(fr)
        k += cnt
    return out


# ======================================================================================================== автоматы
class _Machine:
    """Общее: план передач (BfFrame с моментами), именованные таймеры, журнал состояний.
    Записи приёма sweep-а: (snr, порядок, ID антенны кадра, Sector ID кадра, своя RX-антенна, свой RX-сектор)."""
    def __init__(self, addr, peer, tx_sectors, rx_antennas, alloc_end, bi, lbifs_in_cdown):
        errs = check_antennas(tx_sectors)
        if errs:
            raise ValueError('; '.join(errs))
        self.addr, self.peer, self.tx_sectors = addr, peer, {a: list(s) for a, s in tx_sectors.items()}
        self.rx_antennas, self.bi = rx_antennas, bi
        self.alloc_end = None if alloc_end is None else Fr(alloc_end)
        self.lbifs_in_cdown = lbifs_in_cdown
        self.plan, self.timers, self.state, self.trace = [], {}, 'IDLE', []
        self.t_start = None
        self.result = None

    def _set_state(self, st, t):
        if st != self.state:
            self.state = st
            self.trace.append((t, st))

    def next_event(self):
        c = [f.t for f in self.plan] + list(self.timers.values())
        return min(c) if c else None

    def take_tx(self, t):
        out = [f for f in self.plan if f.t == t]
        self.plan = [f for f in self.plan if f.t != t]
        return out

    def fire_timers(self, t):
        for name in sorted([n for n, tt in self.timers.items() if tt <= t], key=lambda n: self.timers[n]):
            if name in self.timers:
                del self.timers[name]
                self._on_timer(name, t)

    def _arm_t2(self, t):
        # рис. 10-91/10-92: T2 = dot11MaxBFTime; 10.42.1: «shall abort an SLS if … not completed within
        # dot11MaxBFTime beacon intervals from the start of the SLS»
        if self.bi is not None:
            self.timers['T2'] = Fr(t) + DOT11_MAX_BF_TIME * Fr(self.bi)

    def _abort(self, why, t):
        self.plan = []
        self.timers.clear()
        self._set_state('IDLE', t)
        self.result = why

    def _fits(self, t_end):
        return self.alloc_end is None or t_end <= self.alloc_end

    def new_allocation(self, t_start, t_end):
        """Следующее распределение между этими STA (10.42.6.2: SSW feedback «in the following allocation»)."""
        self.alloc_end = Fr(t_end)
        self._on_new_alloc(Fr(t_start))

    def _on_new_alloc(self, t):
        pass

    @staticmethod
    def _best(rx):
        """Лучший приём: «implementation dependent» (10.42.2.3.2) — модель берёт наибольший SNR, при равенстве —
        первый принятый."""
        return max(rx, key=lambda r: (r[0], -r[1])) if rx else None

    def _sweep_end(self, f, mcs_rest):
        """Ожидаемый конец sweep-а (кадр CDOWN=0) по принятому кадру f; остальные кадры — на mcs_rest."""
        return expected_sweep_end(f.end, f.cdown, txtime(LEN_SSW, mcs_rest))


def _rxss_mcs(n, txrate):
    """10.6.7.1: RXSS с RXSSTxRate = 1 (и Supported = 1) — первый SSW DMG Control, остальные MCS 1 SC."""
    return [0] + [RXSS_TXRATE_MCS] * (n - 1) if txrate and n else None


class Initiator(_Machine):
    """Инициатор SLS в DTI (10.42.2, 10.42.6.2, рис. 10-91).

    tx_sectors        — {антенна: [Sector ID…]} для TXSS (их число — last negotiated Total Number of Sectors).
    iss               — TXSS | RXSS (SP: по IsInitiatorTXSS; 10.42.6.2).
    rss               — SP: TXSS | RXSS по IsResponderTXSS; в CBAP определяется rxss_request.
    access            — SP | CBAP.
    peer_rx_antennas  — число приёмных антенн ответчика (Number of RX DMG Antennas + 1) → повторы ISS (10.42.6.2).
    rx_antennas       — свои приёмные антенны в RSS → поле Number of RX DMG Antennas в ISS (9.5.3).
    peer_rxss_len     — RXSS Length ответчика (число кадров) для initiator RXSS (10.42.2.2.3).
    best_tx           — (антенна, сектор), выбранные в предшествующем TXSS (обязателен для RXSS при > 1 секторе).
    rxss_request      — CBAP: поле RXSS Length в SSW (9.5.1): 0 → ответчик делает TXSS, иначе RXSS.
    rx_sweep          — свои приёмные (антенна, сектор) по слотам responder RXSS.
    peer_tx_slots     — Total Number of Sectors ответчика (со LBIFS) — время квази-омни на антенну (10.42.2.3.2).
    rxss_txrate       — RXSSTxRate для initiator RXSS (10.6.7.1); peer_rxss_txrate — для responder RXSS.
    brp               — BRP Request в SSW-Feedback (9.5.4).
    bi                — длина BI, мкс (для T2), None — без T2.
    txop_by_iss       — CBAP: TXOP получен самим ISS (не Grant/существующий TXOP)."""

    def __init__(self, addr, peer, tx_sectors, *, iss=TXSS, rss=TXSS, access=SP, peer_rx_antennas=1,
                 rx_antennas=1, peer_rxss_len=None, best_tx=None, rxss_request=0, rx_sweep=None,
                 peer_tx_slots=None, rxss_txrate=False, peer_rxss_txrate=False, brp=None, alloc_end=None, bi=None,
                 retry_limit=dot11BFRetryLimit, lbifs_in_cdown=True, txop_by_iss=True, poll_required=0):
        super().__init__(addr, peer, tx_sectors, rx_antennas, alloc_end, bi, lbifs_in_cdown)
        n_sec = sum(len(s) for s in tx_sectors.values())
        if iss == RXSS:
            # 10.42.2.2.3: RXSS — только зная RXSS Length ответчика; при > 1 секторе/антенне — после TXSS
            if peer_rxss_len is None:
                raise ValueError('10.42.2.2.3: initiator RXSS требует RXSS Length ответчика')
            if best_tx is None and n_sec > 1:
                raise ValueError('10.42.2.2.3: initiator RXSS — после TXSS (нужен best_tx)')
            if access == CBAP and txop_by_iss:
                raise ValueError('10.42.2.2.3: «During a CBAP, an initiator shall not obtain a TXOP with an '
                                 'initiator RXSS»')
        self.iss, self.access, self.peer_rx_antennas = iss, access, peer_rx_antennas
        # 10.42.6.2: RSS — TXSS, кроме SP с IsResponderTXSS = 0 или CBAP с ненулевым RXSS Length в SSW ISS
        self.rss_type = (RXSS if rxss_request else TXSS) if access == CBAP else rss
        self.peer_rxss_len, self.rxss_request, self.rxss_txrate = peer_rxss_len, rxss_request, rxss_txrate
        self.peer_rxss_txrate = peer_rxss_txrate
        self.best_tx = best_tx or next((a, s[0]) for a, s in sorted(tx_sectors.items()) if s)
        self.rx_sweep, self.peer_tx_slots = rx_sweep, peer_tx_slots
        self.brp, self.retry_limit, self.poll_required = dict(brp or {}), retry_limit, poll_required
        self.iss_attempts, self.fb_count = 0, 0
        self.rss_rx, self.my_sel = [], None
        self.iss_end = self.rss_start = self.rss_end = None

    # --- ISS ---
    def start(self, t):
        """Начало SP/TXOP (10.42.6.2: «shall begin an ISS … at the start of an SP allocation or TXOP»); повторный
        вызов — новый ISS (рис. 10-91: из Idle при «dot11BFRetryLimit not exceeded»)."""
        t = Fr(t)
        if self.iss_attempts > self.retry_limit:
            raise RuntimeError('рис. 10-91: dot11BFRetryLimit exceeded')
        self.iss_attempts += 1
        if self.t_start is None:
            self.t_start = t
            self._arm_t2(t)
        self._set_state('ISS', t)
        self.rss_rx, self.my_sel, self.fb_count, self.result = [], None, 0, None
        if self.iss == TXSS:
            slots, mcs = sweep_slots(self.tx_sectors, self.peer_rx_antennas), None
            n_iss = total_sectors_in_iss(self.tx_sectors, self.peer_rx_antennas)
        else:
            slots = rxss_slots(self.best_tx, self.peer_rxss_len)
            mcs = _rxss_mcs(len(slots), self.rxss_txrate)
            n_iss = len(slots)
        fb = {'total': n_iss, 'n_rx_ant': self.rx_antennas - 1, 'poll': self.poll_required}   # рис. 9-848
        # 9.5.1: RXSS Length «valid only when transmitted in a CBAP and is reserved otherwise»
        rl = self.rxss_request if self.access == CBAP else None
        # 10.42.2.2.1: Direction = 0 в ISS
        self.plan = plan_sweep(slots, t, self.addr, self.peer, 0, alloc_end=self.alloc_end, mcs_seq=mcs,
                               lbifs_in_cdown=self.lbifs_in_cdown, fb=fb, rxss_len=rl)
        # конец ISS — ожидаемый конец кадра CDOWN=0 (10.42.2.2.2), даже если sweep оборван концом распределения
        self.iss_end = self._sweep_end(self.plan[0], mcs[-1] if mcs else 0) if self.plan else t
        self.rss_start = self.iss_end + MBIFS
        self.timers['iss_end'] = self.iss_end
        return list(self.plan)

    def rx_config(self, t):
        """Приёмная конфигурация (антенна, сектор | None — квази-омни) в момент t."""
        if self.state in ('ACK_WAIT', 'FB_PENDING', 'COMPLETE') and self.rss_rx:
            # 10.42.2.5: квази-омни в антенне лучшего приёма RSS или лучший приёмный сектор после RXSS
            b = self._best(self.rss_rx)
            return (b[4], b[5]) if self.rss_type == RXSS else (b[4], None)
        if self.rss_start is not None and t >= self.rss_start:
            if self.rss_type == RXSS and self.rx_sweep:
                # 10.42.2.3.3: «configured to sweep over RXSS Length sectors»
                k = 0 if t < self.rss_start + SLOT else 1 + floor(
                    (t - self.rss_start - SLOT) / (txtime(LEN_SSW, RXSS_TXRATE_MCS if self.peer_rxss_txrate else 0)
                                                   + SBIFS))
                return self.rx_sweep[min(k, len(self.rx_sweep) - 1)]
            if self.rss_type == TXSS and self.peer_tx_slots and self.rx_antennas > 1:
                # 10.42.2.3.2: квази-омни в одной антенне на Total Number of Sectors × TXTIME(SSW) + IFS, потом —
                # другая; повтор отделён LBIFS (= один шаг сетки CDOWN)
                rep = floor((t - self.rss_start) / ((self.peer_tx_slots + 1) * SLOT))
                return (min(rep, self.rx_antennas - 1), None)
        return (0, None)

    def on_tx_end(self, f, t):
        if f.kind == SSW and not any(p.kind == SSW for p in self.plan) and self.state == 'ISS':
            self._set_state('SECTOR_SELECTOR', t)

    def on_rx(self, f, snr, rx_cfg):
        if f.ta != self.peer:
            return
        t = f.end
        if f.kind == SSW and f.direction == 1 and self.state in ('ISS', 'SECTOR_SELECTOR'):
            self._set_state('SECTOR_SELECTOR', t)       # рис. 10-91: «SSW frame received»
            self.rss_rx.append((snr, len(self.rss_rx), f.antenna_id, f.sector_id) + tuple(rx_cfg))
            self.my_sel = (f.fb.get('antenna'), f.fb.get('sector'))
            self.rss_end = self._sweep_end(f, RXSS_TXRATE_MCS if self.rss_type == RXSS and self.peer_rxss_txrate
                                           else 0)
            self.timers['rss_end'] = self.rss_end
            self.timers.pop('T1', None)
        elif f.kind == SSW_ACK and self.state == 'ACK_WAIT':
            self.timers.pop('ack', None)
            self._set_state('COMPLETE', t)              # рис. 10-91: «SSW-Ack frame received» → TXSS Phase Complete
            b = self._best(self.rss_rx)
            self.result = {'tx': self.my_sel, 'peer_tx': (b[2], b[3]) if self.rss_type == TXSS else None,
                           'rx': (b[4], b[5]) if self.rss_type == RXSS else None}

    def _on_timer(self, name, t):
        if name == 'iss_end':
            if not self.rss_rx:
                # рис. 10-91: «Timeout (T1 or T2) and DTI» → Idle; T1 = dot11BFTXSSTime.
                # СПОРНО: точка отсчёта T1 не задана (MIB: «Timeout until the initiator restarts ISS») — от конца ISS
                self.timers['T1'] = t + dot11BFTXSSTime
        elif name == 'rss_end':
            self._try_fb(t + MBIFS)
        elif name == 'ack':
            # 10.42.6.2: «may restart the SSW feedback procedure up to dot11BFRetryLimit times»
            if self.fb_count - 1 >= self.retry_limit:
                self._abort('retry_limit', t)           # рис. 10-91: «dot11BFRetryLimit exceeded» → Idle
                return
            self._try_fb(t + PIFS)  # 10.42.6.2: «PIFS following the expected end of the SSW-Ack frame»
        elif name in ('T1', 'T2'):
            self._abort(name, t)

    def _try_fb(self, t0):
        """10.42.6.2: SSW feedback MBIFS после конца RSS (повтор — PIFS после ожидаемого конца SSW-Ack), если хватает
        времени на SSW-Feedback + MBIFS + SSW-Ack; иначе — в следующем распределении."""
        if not self._fits(t0 + T_SSW_FB + MBIFS + T_SSW_ACK):
            self._set_state('FB_PENDING', t0)
            return
        self._plan_fb(t0)

    def _on_new_alloc(self, t):
        if self.state == 'FB_PENDING':
            self._try_fb(t)     # СПОРНО: момент в следующем распределении не задан — берём его начало

    def _plan_fb(self, t0):
        b = self._best(self.rss_rx)
        if self.rss_type == TXSS:
            # 10.42.2.4: Sector/DMG Antenna Select — лучший кадр responder TXSS, SNR Report — его SNR
            fb = {'sector': b[3], 'antenna': b[2], 'snr': snr_report(b[0]), 'poll': self.poll_required}
        else:
            # 10.42.2.4: после responder RXSS Sector/Antenna Select — reserved; SNR — на выбранном приёмном секторе
            fb = {'sector': None, 'antenna': None, 'snr': snr_report(b[0]), 'poll': self.poll_required}
        # 10.42.2.4: SSW-Feedback — через сектор из Sector Select / DMG Antenna Select ответчика в RSS
        f = BfFrame(SSW_FB, self.addr, self.peer, t0, fb=fb, brp=self.brp, tx=self.my_sel)
        rem = None if self.alloc_end is None else self.alloc_end - f.end
        f.dur = duration_ssw_fb(False, brp_requested(self.brp), T_SSW_ACK, alloc_remaining=rem)   # 9.3.1.16
        self.plan.append(f)
        self.fb_count += 1
        self._set_state('ACK_WAIT', t0)
        # 10.42.6.2: SSW-Ack ожидается через MBIFS; срок — ожидаемый конец SSW-Ack
        self.timers['ack'] = f.end + MBIFS + T_SSW_ACK


class Responder(_Machine):
    """Ответчик SLS в DTI (10.42.2.3, 10.42.2.5, 10.42.6.2, рис. 10-92).

    iss               — ожидаемый ISS: TXSS | RXSS (SP: IsInitiatorTXSS).
    rss               — SP: TXSS | RXSS по IsResponderTXSS; CBAP — по RXSS Length в принятом SSW.
    peer_rxss_len     — RSS RXSS в SP: RXSS Length инициатора (число кадров, 10.42.2.3.3).
    best_tx           — (антенна, сектор) из предшествующего TXSS (RXSS идёт через него).
    reciprocity       — DMG Antenna Reciprocity = 1 (10.42.2.3.2).
    rx_sweep          — свои приёмные (антенна, сектор) по слотам initiator RXSS.
    peer_tx_slots     — Total Number of Sectors инициатора (со LBIFS) — смена квази-омни антенны в ISS.
    iss_start         — известное начало ISS (начало SP) для расписания приёма; None — антенна 0, квази-омни.
    start_if_insufficient — 10.42.6.2 NOTE: «can begin an RSS if there is not sufficient time» (RSS оборвётся)."""

    def __init__(self, addr, peer, tx_sectors, *, iss=TXSS, rss=TXSS, access=SP, rx_antennas=1,
                 peer_rxss_len=None, best_tx=None, reciprocity=False, rx_sweep=None, peer_tx_slots=None,
                 iss_start=None, rxss_txrate=False, peer_rxss_txrate=False, brp=None, alloc_end=None, bi=None,
                 start_if_insufficient=False, lbifs_in_cdown=True, poll_required=0):
        super().__init__(addr, peer, tx_sectors, rx_antennas, alloc_end, bi, lbifs_in_cdown)
        n_sec = sum(len(s) for s in tx_sectors.values())
        if rss == RXSS and access == SP and best_tx is None and n_sec > 1:
            raise ValueError('10.42.2.3.3: responder RXSS — после TXSS (нужен best_tx)')
        self.iss_type, self.rss, self.access, self.peer_rxss_len = iss, rss, access, peer_rxss_len
        self.reciprocity = reciprocity
        self.best_tx = best_tx or next((a, s[0]) for a, s in sorted(tx_sectors.items()) if s)
        self.rx_sweep, self.peer_tx_slots = rx_sweep, peer_tx_slots
        self.iss_start = None if iss_start is None else Fr(iss_start)
        self.rxss_txrate, self.peer_rxss_txrate = rxss_txrate, peer_rxss_txrate
        self.brp, self.start_if_insufficient, self.poll_required = dict(brp or {}), start_if_insufficient, \
            poll_required
        self.iss_rx, self.peer_n_rx_ant, self.cbap_rxss = [], 1, 0
        self.iss_end, self.ack_tx, self._sel = None, None, None

    def rx_config(self, t):
        if self.state not in ('IDLE', 'SECTOR_SELECTOR') and self.iss_rx:
            # 10.42.2.4: квази-омни в антенне лучшего приёма ISS или лучший приёмный сектор, если ISS — RXSS
            b = self._best(self.iss_rx)
            return (b[4], b[5]) if self.iss_type == RXSS else (b[4], None)
        if self.iss_start is not None and t >= self.iss_start:
            if self.iss_type == RXSS and self.rx_sweep:
                # 10.42.2.2.3: «configured to sweep RXSS Length sectors»
                k = 0 if t < self.iss_start + SLOT else 1 + floor(
                    (t - self.iss_start - SLOT) / (txtime(LEN_SSW, RXSS_TXRATE_MCS if self.peer_rxss_txrate else 0)
                                                   + SBIFS))
                return self.rx_sweep[min(k, len(self.rx_sweep) - 1)]
            if self.iss_type == TXSS and self.peer_tx_slots and self.rx_antennas > 1:
                # 10.42.2.2.2: первая антенна квази-омни на Total Number of Sectors × TXTIME(SSW) + IFS, далее —
                # следующая (повторы ISS разделены LBIFS = один шаг сетки)
                rep = floor((t - self.iss_start) / ((self.peer_tx_slots + 1) * SLOT))
                return (min(rep, self.rx_antennas - 1), None)
        return (0, None)

    def on_tx_end(self, f, t):
        if f.kind == SSW and not any(p.kind == SSW for p in self.plan):
            self._set_state('SSW_FEEDBACK', t)
        elif f.kind == SSW_ACK:
            self._set_state('PRE_COMPLETE', t)          # рис. 10-92: TXSS Phase Pre-Complete

    def on_rx(self, f, snr, rx_cfg):
        if f.ta != self.peer:
            return
        t = f.end
        if f.kind == SSW and f.direction == 0 and self.state in ('IDLE', 'SECTOR_SELECTOR'):
            if self.state == 'IDLE':
                self._set_state('SECTOR_SELECTOR', t)   # рис. 10-92: «BF frame received»
                if self.t_start is None:
                    self.t_start = f.t
                    self._arm_t2(f.t)
            self.iss_rx.append((snr, len(self.iss_rx), f.antenna_id, f.sector_id) + tuple(rx_cfg))
            self.peer_n_rx_ant = f.fb.get('n_rx_ant', 0) + 1     # 9.5.3: поле = число антенн − 1
            if self.access == CBAP:
                self.cbap_rxss = f.rxss_len or 0
            # 10.42.2.2.2: если CDOWN=0 не принят — ISS кончается в ожидаемый момент конца этого кадра
            self.iss_end = self._sweep_end(f, RXSS_TXRATE_MCS if self.iss_type == RXSS and self.peer_rxss_txrate
                                           else 0)
            self.timers['iss_end'] = self.iss_end
        elif f.kind == SSW_FB and self.state in ('SSW_FEEDBACK', 'PRE_COMPLETE'):
            # 10.42.6.2: SSW-Ack MBIFS после приёма SSW-Feedback; рис. 10-92: повторный SSW-Feedback в
            # Pre-Complete → снова SSW acknowledgment
            self._plan_ack(f)
        elif self.state == 'PRE_COMPLETE' and f.kind not in (SSW, SSW_FB):
            self._set_state('COMPLETE', t)  # рис. 10-92: «Non SSW-Feedback and non SSW frame received»
            self.result = {'tx': self.ack_tx}

    def _rss_kind(self):
        """10.42.6.2: RSS — TXSS, кроме SP с IsResponderTXSS = 0 или CBAP с ненулевым RXSS Length в SSW ISS."""
        if self.access == CBAP:
            return RXSS if self.cbap_rxss else TXSS
        return self.rss

    def _on_timer(self, name, t):
        if name == 'iss_end':
            if self.iss_rx:
                self._plan_rss(t + MBIFS)   # 10.42.6.2: «begin an RSS … MBIFS following the completion of an ISS»
        elif name == 'T2':
            self._abort('T2', t)

    def _plan_rss(self, t0):
        kind = self._rss_kind()
        b = self._best(self.iss_rx)
        # 10.42.2.3.2 / 10.42.2.3.3: Sector Select / DMG Antenna Select — ID лучшего кадра ISS, SNR Report — его SNR
        self._sel = (b[2], b[3])
        fb = {'sector': b[3], 'antenna': b[2], 'snr': snr_report(b[0]), 'poll': self.poll_required}
        mcs, silent = None, set()
        if kind == TXSS:
            # 10.42.2.3.2: «repeats its responder sector sweep for the number of DMG antennas indicated by the
            # initiator in the last negotiated Number of RX DMG Antennas»
            slots = sweep_slots(self.tx_sectors, self.peer_n_rx_ant)
            if self.reciprocity and len(self.tx_sectors) > 1:
                # 10.42.2.3.2: Reciprocity = 1 — передаёт через антенну лучшего приёма в ISS; «The length of the
                # sector sweep … is not dependent on the value of the DMG Antenna Reciprocity field».
                # СПОРНО: модель сохраняет длину и сетку CDOWN полной раскладки, слоты других антенн молчат
                # (альтернатива — заполнить все слоты секторами лучшей антенны).
                frames_only = [s for s in slots if s is not LB]
                silent = {i for i, s in enumerate(frames_only) if s[0] != b[4]}
        else:
            n = rxss_length(self.cbap_rxss) if self.access == CBAP else self.peer_rxss_len
            if n is None:
                raise ValueError('10.42.2.3.3: RXSS — число кадров из RXSS Length инициатора')
            slots = rxss_slots(self.best_tx, n)
            mcs = _rxss_mcs(n, self.rxss_txrate)
        rl = 0 if self.access == CBAP else None
        full = plan_sweep(slots, t0, self.addr, self.peer, 1, mcs_seq=mcs, lbifs_in_cdown=self.lbifs_in_cdown,
                          fb=fb, rxss_len=rl, dur=False)
        # 10.42.6.2: RSS — «provided … there is sufficient time in the allocation … to complete the RSS phase»;
        # NOTE: может начать и без запаса — RSS обрывается и не продолжается в другом распределении
        if full and not self._fits(full[-1].end) and not self.start_if_insufficient:
            return
        frames = plan_sweep(slots, t0, self.addr, self.peer, 1, alloc_end=self.alloc_end, mcs_seq=mcs,
                            lbifs_in_cdown=self.lbifs_in_cdown, fb=fb, rxss_len=rl)
        self.plan += [f for i, f in enumerate(frames) if i not in silent]
        self._set_state('RSS', t0)

    def _plan_ack(self, fb_frame):
        t0 = fb_frame.end + MBIFS
        if self._rss_kind() == TXSS:
            # 10.42.2.5: SSW-Ack — через сектор из Sector Select / DMG Antenna Select последнего SSW-Feedback
            tx = (fb_frame.fb.get('antenna'), fb_frame.fb.get('sector'))
        else:
            # 10.42.2.5: после RXSS — «should be sent using the DMG antenna indicated in the DMG Antenna Select field
            # in the last SSW-Feedback frame». СПОРНО: по 10.42.2.4 это поле после RXSS — reserved; модель передаёт
            # через сектор/антенну RXSS (best_tx).
            tx = self.best_tx
        self.ack_tx = tx
        # СПОРНО: содержимое SSW Feedback в SSW-Ack 10.42.2.5 не задаёт; по 9.5.3 («immediately preceding sector
        # sweep» для ответчика — ISS) — лучший кадр ISS
        b = self._best(self.iss_rx)
        f = BfFrame(SSW_ACK, self.addr, self.peer, t0, tx=tx, brp=self.brp,
                    fb={'sector': self._sel[1], 'antenna': self._sel[0], 'snr': snr_report(b[0]),
                        'poll': self.poll_required})
        f.dur = duration_ssw_ack(fb_frame.dur, T_SSW_ACK) if fb_frame.dur is not None else None   # 9.3.1.17
        self.plan.append(f)
        self._set_state('SSW_ACK', t0)


# ======================================================================================================== эфир
class SlsLink:
    """Эфир для пары Initiator/Responder. channel(ta, tx_ant, tx_sector, ra, rx_ant, rx_sector) → SNR дБ | None
    (не принят); drop(frame) → True — кадр потерян (помехи). Журнал — список BfFrame в порядке начала."""
    def __init__(self, ini, rsp, channel, drop=None):
        self.ini, self.rsp, self.channel, self.drop = ini, rsp, channel, drop or (lambda f: False)
        self.log, self.inflight = [], []
        self.st = {ini.addr: ini, rsp.addr: rsp}

    def run(self, until):
        until = Fr(until)
        while True:
            c = [x for x in (self.ini.next_event(), self.rsp.next_event()) if x is not None]
            c += [f.end for f in self.inflight]
            if not c:
                break
            t = min(c)
            if t > until:
                break
            # 1) концы PPDU
            for f in sorted([f for f in self.inflight if f.end == t], key=lambda f: f.t):
                self.inflight.remove(f)
                src, dst = self.st[f.ta], self.st.get(f.ra)
                src.on_tx_end(f, t)
                if dst is None or self.drop(f):
                    continue
                rx_cfg = dst.rx_config(f.t)
                snr = self.channel(f.ta, f.tx[0], f.tx[1], f.ra, rx_cfg[0], rx_cfg[1])
                if snr is not None:
                    dst.on_rx(f, snr, rx_cfg)
            # 2) таймеры
            for m in (self.ini, self.rsp):
                m.fire_timers(t)
            # 3) начала передач
            for m in (self.ini, self.rsp):
                for f in m.take_tx(t):
                    self.log.append(f)
                    self.inflight.append(f)
        return self.log


# ======================================================================================================== проверка
def _gap_ok(gap, nominal, tol):
    return nominal <= gap <= nominal + tol


def check_sls_log(frames, ctx=None):
    """Проверка журнала эфира одного SLS в DTI (10.42.2, 10.42.6.2). frames — BfFrame (можно с чужими кадрами).
    ctx (все ключи необязательны):
      initiator, responder — адреса (иначе — TA/RA первого SSW с Direction 0);
      access — SP | CBAP; alloc_end — конец распределения;
      is_responder_txss — SP: IsResponderTXSS (иначе по RXSS Length в CBAP; по умолчанию TXSS);
      peer_rxss_len — число кадров RSS RXSS в SP; iss_rxss_len — число кадров initiator RXSS;
      responder_rx_antennas — для числа повторов ISS; rss_snr / iss_snr — {индекс кадра RSS/ISS в журнале: SNR}
      (кто как принял) — для проверки «лучшего» выбора; rxss_txrate — {'iss': bool, 'rss': bool};
      retry_limit — dot11BFRetryLimit.
    Возвращает список строк-нарушений (пусто — ок)."""
    ctx = dict(ctx or {})
    errs = []
    E = errs.append
    ssw0 = next((f for f in frames if f.kind == SSW and f.direction == 0), None)
    if ssw0 is None:
        return ['нет ISS (10.42.2.1: «An initiator shall begin the SLS phase by transmitting the frames of the ISS»)']
    I = ctx.get('initiator', ssw0.ta)
    R = ctx.get('responder', ssw0.ra)
    access = ctx.get('access', SP)
    alloc_end = ctx.get('alloc_end')
    limit = ctx.get('retry_limit', dot11BFRetryLimit)
    pair = [f for f in frames if {f.ta, f.ra} == {I, R}]
    if pair[0] is not ssw0:
        E(f'первый кадр пары {pair[0]} — не SSW ISS (10.42.2.1, 10.42.6.2)')

    # --- разбиение на фазы ---
    iss = [f for f in pair if f.kind == SSW and f.ta == I]
    rss = [f for f in pair if f.kind == SSW and f.ta == R]
    fbs = [f for f in pair if f.kind == SSW_FB]
    acks = [f for f in pair if f.kind == SSW_ACK]
    last_sls = max(k for k, f in enumerate(pair) if f.kind in (SSW, SSW_FB, SSW_ACK))
    for k, f in enumerate(pair):
        if f.kind == BEACON:
            E(f'{f}: DMG Beacon в DTI — 10.42.6.2: «both … shall use the SSW frame for the ISS and RSS»')
        elif f.kind not in (SSW, SSW_FB, SSW_ACK) and k < last_sls:
            E(f'{f}: обмен до завершения SLS (10.42.6.2: «complete the SLS phase before any additional frame '
              f'exchange takes place»)')
        if f.kind == SSW_FB and f.ta != I or f.kind == SSW_ACK and f.ta != R:
            E(f'{f}: кадр не той роли (10.42.2.1: инициатор — SSW/SSW-Feedback, ответчик — SSW/SSW-Ack)')
        if f.trn:
            E(f'{f}: TRN_LEN ≠ 0 (10.42.2.1)')
        if f.kind in (SSW_FB, SSW_ACK) and f.mcs != 0:
            E(f'{f}: не DMG Control (10.6.7.1)')
        if f.kind == SSW and (f.cdown is None or not 0 <= f.cdown <= CDOWN_MAX):
            E(f'{f}: CDOWN вне 0…511 (9.5.1)')
    if any(f.direction != 0 for f in iss):
        E('ISS: Direction ≠ 0 (10.42.2.2.1)')
    if any(f.direction != 1 for f in rss):
        E('RSS: Direction ≠ 1 (10.42.2.3.1)')
    order = [f.kind if f.kind != SSW else ('ISS' if f.ta == I else 'RSS') for f in pair
             if f.kind in (SSW, SSW_FB, SSW_ACK)]
    rank = {'ISS': 0, 'RSS': 1, SSW_FB: 2, SSW_ACK: 2}
    if any(rank[a] > rank[b] for a, b in zip(order, order[1:])):
        E(f'порядок фаз нарушен: {order} (10.42.2.1: ISS → RSS → SSW feedback → SSW ack)')
    for a, b in zip(order, order[1:]):
        if a == SSW_ACK and b == SSW_ACK:
            E('два SSW-Ack без SSW-Feedback между ними (10.42.6.2)')

    def sweep(name, fr, txrate):
        """Общие правила sweep: CDOWN по убыванию, промежутки SBIFS/LBIFS на сетке CDOWN, MCS, Duration."""
        if not fr:
            return None
        for k, (a, b) in enumerate(zip(fr, fr[1:])):
            gap, step = b.t - a.end, a.cdown - b.cdown
            if step == 1:
                if not SBIFS <= gap <= SBIFS_MAX:
                    E(f'{name}: {a}→{b}: промежуток {float(gap):.4f} ≠ SBIFS (10.3.2.3.8, рис. 10-70/10-71)')
                if a.antenna_id != b.antenna_id:
                    E(f'{name}: {a}→{b}: смена антенны без LBIFS (10.3.2.3.11)')
            elif step == 2:
                if not _gap_ok(gap, LBIFS, LBIFS_TOL):
                    E(f'{name}: {a}→{b}: промежуток {float(gap):.4f} ≠ LBIFS (10.3.2.3.11)')
            else:
                E(f'{name}: CDOWN {a.cdown}→{b.cdown} (10.42.2.2.2: оставшиеся передачи, LBIFS — одна)')
        last = fr[-1]
        if last.cdown != 0:
            nxt = last.end + SBIFS + last.airtime
            if alloc_end is None or nxt <= alloc_end:
                E(f'{name}: оборван на CDOWN={last.cdown} без конца распределения (10.42.2.2.2)')
        for k, f in enumerate(fr):
            want = 0 if k == 0 or not txrate else RXSS_TXRATE_MCS
            if f.mcs != want:
                E(f'{name}: {f}: MCS {f.mcs}, ожидалась {want} (10.6.7.1)')
            if f.dur is not None:
                rem = None if alloc_end is None else alloc_end - f.end
                d = duration_ssw(f.cdown, f.airtime, alloc_remaining=rem)
                if f.dur != d:
                    E(f'{name}: {f}: Duration {f.dur} ≠ {d} (9.3.1.15)')
            if alloc_end is not None and f.end > alloc_end:
                E(f'{name}: {f} за концом распределения (10.42.2.2.2, 10.42.6.2)')
        return expected_sweep_end(last.end, last.cdown, last.airtime)

    def is_rxss(fr):
        return len({(f.antenna_id, f.sector_id) for f in fr}) == 1 and len(fr) > 1

    def txss_ids(name, fr, increasing):
        """10.42.2.2.2 / 10.42.2.3.2: Sector ID + DMG Antenna ID однозначны в пределах повтора; новый повтор — после
        LBIFS; ответчик — антенны по возрастанию."""
        seen, prev_ant, reps = set(), None, 1
        for a, b in zip([None] + fr, fr):
            key = (b.antenna_id, b.sector_id)
            lb = a is not None and a.cdown - b.cdown == 2
            if key in seen:
                if not lb:
                    E(f'{name}: {b}: повтор Sector ID/DMG Antenna ID без LBIFS (10.42.2.2.2)')
                seen, reps, prev_ant = set(), reps + 1, None
            elif increasing and prev_ant is not None and b.antenna_id < prev_ant:
                E(f'{name}: {b}: антенны не по возрастанию ID (10.42.2.3.2)')
            seen.add(key)
            prev_ant = b.antenna_id
        return reps

    # --- ISS ---
    tr = ctx.get('rxss_txrate', {})
    iss_rx = is_rxss(iss) if ctx.get('iss_rxss_len') is None else True
    iss_end = sweep('ISS', iss, iss_rx and tr.get('iss'))
    if iss_rx:
        n = ctx.get('iss_rxss_len')
        if n is not None and len(iss) != n and iss[-1].cdown == 0:
            E(f'initiator RXSS: {len(iss)} кадров ≠ RXSS Length ответчика {n} (10.42.2.2.3)')
        if access == CBAP and ctx.get('txop_by_iss', True):
            E('CBAP: TXOP получен initiator RXSS (10.42.2.2.3: «shall not obtain a TXOP with an initiator RXSS»)')
    else:
        reps = txss_ids('ISS', iss, False)
        nr = ctx.get('responder_rx_antennas')
        if nr is not None and iss[-1].cdown == 0 and reps != nr:
            E(f'ISS: {reps} повторов ≠ число приёмных антенн ответчика {nr} (10.42.6.2: k+1)')
    tot = {f.fb.get('total') for f in iss}
    if len(tot) > 1:
        E('ISS: Total Sectors in ISS меняется (9.5.3)')
    elif iss[-1].cdown == 0 and not iss_rx and tot != {len(iss)}:
        E(f'ISS: Total Sectors in ISS {tot} ≠ {len(iss)} кадров (10.42.2.2.1)')
    nrx = {f.fb.get('n_rx_ant') for f in iss}
    if len(nrx) > 1:
        E('ISS: Number of RX DMG Antennas меняется (9.5.3)')
    if access == SP and any(f.rxss_len is not None for f in iss + rss):
        E('SP: RXSS Length в SSW не reserved (9.5.1: «valid only when transmitted in a CBAP»)')

    # --- RSS ---
    if access == CBAP:
        rl = iss[0].rxss_len or 0
        want_rss = RXSS if rl else TXSS          # 10.42.2.3.2 / 10.42.2.3.3 / 10.42.6.2
        n_rss = rxss_length(rl) if rl else None
    else:
        want_rss = TXSS if ctx.get('is_responder_txss', True) else RXSS
        n_rss = ctx.get('peer_rxss_len')
    rss_end = None
    if rss:
        if iss_end is not None and not _gap_ok(rss[0].t - iss_end, MBIFS, MBIFS_TOL):
            E(f'RSS начат через {float(rss[0].t - iss_end):.4f} после конца ISS ≠ MBIFS (10.42.6.2, 10.3.2.3.10)')
        rss_end = sweep('RSS', rss, want_rss == RXSS and tr.get('rss'))
        if want_rss == RXSS:
            if len({(f.antenna_id, f.sector_id) for f in rss}) != 1:
                E('responder RXSS: кадры через разные сектора (10.42.2.3.3)')
            if n_rss is not None and len(rss) != n_rss and rss[-1].cdown == 0:
                E(f'responder RXSS: {len(rss)} кадров ≠ {n_rss} (10.42.2.3.3)')
        else:
            reps = txss_ids('RSS', rss, True)
            want_reps = (iss[0].fb.get('n_rx_ant') or 0) + 1
            if rss[-1].cdown == 0 and reps != want_reps:
                E(f'RSS: {reps} повторов ≠ Number of RX DMG Antennas инициатора + 1 = {want_reps} (10.42.2.3.2)')
        sels = {(f.fb.get('antenna'), f.fb.get('sector')) for f in rss}
        if len(sels) != 1:
            E('RSS: Sector Select/DMG Antenna Select меняется (10.42.2.3.2)')
        sel = next(iter(sels))
        iss_ids = {(f.antenna_id, f.sector_id) for f in iss}
        if sel not in iss_ids:
            E(f'RSS: Sector Select {sel} не из кадров ISS (10.42.2.3.2)')
        isnr = ctx.get('iss_snr')
        if isnr and not iss_rx:
            best = max(isnr.items(), key=lambda kv: (kv[1], -kv[0]))[0]
            b = iss[best]
            if sel != (b.antenna_id, b.sector_id):
                E(f'RSS: Sector Select {sel} ≠ лучший кадр ISS {(b.antenna_id, b.sector_id)} (10.42.2.3.2)')
    elif fbs:
        E('SSW-Feedback без RSS в DTI (10.42.2.1)')

    # --- SSW feedback / ack ---
    if fbs:
        if rss_end is not None:
            g = fbs[0].t - rss_end
            fits = alloc_end is None or rss_end + MBIFS + T_SSW_FB + MBIFS + T_SSW_ACK <= alloc_end
            if fits and not _gap_ok(g, MBIFS, MBIFS_TOL):
                E(f'SSW-Feedback через {float(g):.4f} после конца RSS ≠ MBIFS (10.42.6.2)')
            if not fits and alloc_end is not None and fbs[0].t < alloc_end:
                E('SSW-Feedback в распределении без времени на SSW-Feedback + MBIFS + SSW-Ack (10.42.6.2)')
        if len(fbs) - 1 > limit:
            E(f'повторов SSW-Feedback {len(fbs) - 1} > dot11BFRetryLimit {limit} (10.42.6.2)')
        rss_sel = (rss[0].fb.get('antenna'), rss[0].fb.get('sector')) if rss else None
        rsnr = ctx.get('rss_snr')
        for k, fb in enumerate(fbs):
            if rss_sel is not None and fb.tx != rss_sel:
                E(f'{fb}: передан через {fb.tx}, а не через Sector Select RSS {rss_sel} (10.42.2.4)')
            if want_rss == TXSS:
                s = (fb.fb.get('antenna'), fb.fb.get('sector'))
                if s not in {(f.antenna_id, f.sector_id) for f in rss}:
                    E(f'{fb}: Sector Select {s} не из кадров RSS (10.42.2.4)')
                if rsnr:
                    best = rss[max(rsnr.items(), key=lambda kv: (kv[1], -kv[0]))[0]]
                    if s != (best.antenna_id, best.sector_id):
                        E(f'{fb}: Sector Select {s} ≠ лучший кадр RSS (10.42.2.4)')
            elif fb.fb.get('sector') is not None or fb.fb.get('antenna') is not None:
                E(f'{fb}: после responder RXSS Sector/DMG Antenna Select — reserved (10.42.2.4)')
            if fb.dur is not None:
                rem = None if alloc_end is None else alloc_end - fb.end
                d = duration_ssw_fb(False, brp_requested(fb.brp), T_SSW_ACK, alloc_remaining=rem)
                if fb.dur != d:
                    E(f'{fb}: Duration {fb.dur} ≠ {d} (9.3.1.16)')
            ack = next((a for a in acks if fb.end < a.t and (k + 1 == len(fbs) or a.t < fbs[k + 1].t)), None)
            if ack is not None:
                if not _gap_ok(ack.t - fb.end, MBIFS, MBIFS_TOL):
                    E(f'{ack}: через {float(ack.t - fb.end):.4f} после SSW-Feedback ≠ MBIFS (10.42.6.2)')
                if want_rss == TXSS and ack.tx != (fb.fb.get('antenna'), fb.fb.get('sector')):
                    E(f'{ack}: передан через {ack.tx}, а не через Sector Select SSW-Feedback (10.42.2.5)')
                if ack.dur is not None and fb.dur is not None and ack.dur != duration_ssw_ack(fb.dur, ack.airtime):
                    E(f'{ack}: Duration {ack.dur} ≠ {duration_ssw_ack(fb.dur, ack.airtime)} (9.3.1.17)')
            elif k + 1 < len(fbs):
                nxt = fbs[k + 1]
                exp = fb.end + MBIFS + T_SSW_ACK
                same_alloc = alloc_end is None or nxt.t < alloc_end
                if same_alloc and not _gap_ok(nxt.t - exp, PIFS, PIFS_TOL):
                    E(f'{nxt}: повтор через {float(nxt.t - exp):.4f} после ожидаемого конца SSW-Ack ≠ PIFS '
                      f'(10.42.6.2)')
    if acks and not fbs:
        E('SSW-Ack без SSW-Feedback (10.42.2.5)')
    return errs
