# SPDX-License-Identifier: AGPL-3.0-or-later
"""Захват сниффера узла → журнал эфира модели (ref/air_pcap) и судья (ref/air_judge): синтетические pcap двух узлов
с известным эфиром (время начала PPDU, точка метки, сдвиг TSF второго узла, кванты меток, испорченные метки ответов
MAC, синтетические RX-записи) и, если есть, настоящие pcap стенда (AIR_PCAP_AP / AIR_PCAP_STA).

Ожидания — из построения эфира и из стандарта (SIFS 10.3.2.3.3, Duration DMG CTS 9.3.1.13, BA Control рис. 9-42,
MCS ответа 10.6.7.2), не из кода судьи."""
import os
import struct
from fractions import Fraction as Fr
from math import ceil, floor

import pytest

from . import air_judge as J
from . import air_pcap as P
from . import timing as T

AP_MAC = bytes.fromhex('24181d243b0b')
STA_MAC = bytes.fromhex('24181d26d47b')
OFF_STA = Fr(3)                                 # t_AP = метка STA + 3 мкс
RX_OFF = {'control': Fr(-3, 2), 'sc': Fr(0)}    # метка RX − метка TX того же PPDU


# ---------------------------------------------------------------------------------------------------------------------
# построение pcap (radiotap + vendor v4, CAPTURE.md 5.4)
# ---------------------------------------------------------------------------------------------------------------------
def radiotap(tsft, vendor):
    if tsft is None:
        hdr = struct.pack('<BBHII', 0, 0, 0, (1 << 30) | (1 << 31), 0)                       # 12 октетов
        body = hdr + struct.pack('<3sBH', P.VENDOR_OUI, 1, len(vendor)) + vendor
    else:
        hdr = struct.pack('<BBHII', 0, 0, 0, 1 | (1 << 30) | (1 << 31), 0) + b'\0' * 4      # TSFT с 16
        body = hdr + struct.pack('<Q', tsft) + struct.pack('<3sBH', P.VENDOR_OUI, 1, len(vendor)) + vendor
    return body[:2] + struct.pack('<H', len(body)) + body[4:]


def vendor(dirn, mpdu_len, caplen, tsf32, info0, sflags=0, flags=0):
    v = struct.pack(P.VFMT, 4, P.SRC_PMC, dirn, flags, info0 & 31 if dirn == 0 else 0xff, 0xff, mpdu_len, caplen, 0,
                    0xff, tsf32, info0, 0, 0, 0)
    return v + b'\0' * 24 + bytes([0xff, sflags]) + b'\0\0'


class Node:
    def __init__(self, name, mac, off):
        self.name, self.mac, self.off, self.recs = name, mac, off, []

    def stamp(self, t, mcs, rx):
        m = P.mode_of(mcs)
        return floor(t + P.PRE[m] + (RX_OFF[m] if rx else 0) - self.off)

    def tx(self, t, mpdu, length, mcs, agg=False, bad=False):
        info0 = length << 6 | (agg << 5) | mcs
        tsf = None if bad else self.stamp(t, mcs, False)
        self.recs.append((t, radiotap(tsf, vendor(1, len(mpdu), len(mpdu), 6 if bad else tsf, info0,
                                                  P.SF_TSF_BAD if bad else 0)) + mpdu))

    def rx(self, t, mpdu, length, mcs, agg=False, sflags=P.SF_SYNTH | P.SF_RA_OWN | P.SF_TA_PEER, bad=False):
        info0 = length << 6 | (agg << 5) | mcs
        tsf = None if bad else self.stamp(t, mcs, True)
        sflags |= P.SF_TSF_BAD if bad else 0
        self.recs.append((t + Fr(1, 1000), radiotap(tsf, vendor(0, length - 4, len(mpdu), tsf or 6, info0, sflags,
                                                                0xa8)) + mpdu))

    def write(self, path):
        with open(path, 'wb') as f:
            f.write(struct.pack('<IHHiIII', 0xa1b23c4d, 2, 4, 0, 0, 65535, 127))
            for t, d in sorted(self.recs, key=lambda x: x[0]):
                f.write(struct.pack('<IIII', 0, 0, len(d), len(d)) + d)


def ctl(fc, dur, ra, ta, tail=b''):
    return struct.pack('<HH', fc, dur) + ra + ta + tail


def synth(fc, ra, ta, length):
    """Синтетическая RX-запись (CAPTURE.md 4.2): FC слота, Duration 0, RA/TA, нули до длины PSDU − FCS."""
    return (struct.pack('<HH', fc, 0) + ra + ta).ljust(length - 4, b'\0')


FC_RTS, FC_CTS, FC_BA, FC_CFEND, FC_QOS, FC_BEACON = 0x00b4, 0x0564, 0x0094, 0x00e4, 0x0088, 0x000c


def exchange(ap, sta, t, holder, sifs=Fr(3), cts_dur_delta=0, ba_ctl=0x0004, ba_mcs=4, cts_bad=True, rts_dur=1982):
    """TXOP: RTS → DMG CTS → A-MPDU (данные: TX не записан, у получателя — синтетический RX) → BlockAck → CF-End →
    ответный CF-End. Промежутки — sifs. Возвращает конец обмена."""
    X, Y = (ap, sta) if holder == 'AP' else (sta, ap)
    t_rts = T.txtime_control(20)
    X.tx(t, ctl(FC_RTS, rts_dur, Y.mac, X.mac), 20, 0, bad=(X is ap))
    Y.rx(t, synth(FC_RTS, Y.mac, X.mac, 20), 20, 0)
    t1 = t + t_rts + sifs
    cts_dur = ceil(Fr(rts_dur) - T.SIFS - T.txtime_control(20)) + cts_dur_delta
    Y.tx(t1, ctl(FC_CTS, cts_dur, X.mac, Y.mac), 20, 0, bad=(Y is ap and cts_bad))
    X.rx(t1, synth(FC_CTS, X.mac, Y.mac, 20), 20, 0)
    t2 = t1 + T.txtime_control(20) + sifs
    L = 30000
    Y.rx(t2, synth(FC_QOS, Y.mac, X.mac, 60), L, 8, agg=True)
    t3 = t2 + T.txtime(L, 8) + sifs
    ba = ctl(FC_BA, 100, X.mac, Y.mac, struct.pack('<HH', ba_ctl, 0x10) + b'\xff' * 8)
    Y.tx(t3, ba, 32, ba_mcs, bad=False)
    X.rx(t3, synth(FC_BA, X.mac, Y.mac, 32), 32, ba_mcs)
    t4 = t3 + T.txtime(32, ba_mcs) + sifs
    X.tx(t4, ctl(FC_CFEND, 18, Y.mac, X.mac), 20, 0, bad=False)
    Y.rx(t4, synth(FC_CFEND, Y.mac, X.mac, 20), 20, 0)
    t5 = t4 + T.txtime_control(20) + sifs
    Y.tx(t5, ctl(FC_CFEND, 0, X.mac, Y.mac), 20, 0, bad=(Y is ap))
    X.rx(t5, synth(FC_CFEND, X.mac, Y.mac, 20), 20, 0)
    return t5 + T.txtime_control(20)


def beacon_bti(ap, sta, k, n=4, delay=Fr(0)):
    """BTI: n маяков через SBIFS с TBTT k·BI (+delay); Duration — остаток BTI (9.3.4.2); STA принимает последний."""
    t = Fr(k * 100 * 1024) + delay
    tb = T.txtime_control(46)
    for i in range(n):
        cd = n - 1 - i
        dur = ceil(cd * (tb + T.SBIFS))
        ts = ap.stamp(t, 0, False)
        ssw = (cd << 1) | (i << 10)                         # Direction 0, CDOWN, Sector ID
        body = (struct.pack('<Q', ts) + ssw.to_bytes(3, 'little') + struct.pack('<H', 100) +
                bytes.fromhex('80fc11200000') + bytes([0x07]) + bytes.fromhex('970a0000007b020003000004'))
        mpdu = struct.pack('<HH', FC_BEACON, dur) + AP_MAC + body
        assert len(mpdu) + 4 == 46
        ap.tx(t, mpdu, len(mpdu) + 4, 0)
        if i == n - 1:
            sta.rx(t, mpdu, len(mpdu) + 4, 0, sflags=0)
        t += tb + T.SBIFS
    return t


def build(tmp_path, n=40, **kw):
    ap, sta = Node('AP', AP_MAC, Fr(0)), Node('STA', STA_MAC, OFF_STA)
    t = beacon_bti(ap, sta, 400) + 200
    for i in range(n):
        t = exchange(ap, sta, t, 'AP' if i % 2 else 'STA', **kw)
        t += T.aifs(3) + 5 * (i % 7) + Fr(1, 10) * 0
    a, s = tmp_path / 'ap.pcap', tmp_path / 'sta.pcap'
    ap.write(a)
    sta.write(s)
    return str(a), str(s)


def air_of(tmp_path, **kw):
    a, s = build(tmp_path, **kw)
    return P.merge([P.read_pcap(a, 'AP'), P.read_pcap(s, 'STA')])


def rule(rules, rid):
    return next(r for r in rules if r.rid == rid)


# ---------------------------------------------------------------------------------------------------------------------
# чтение и слияние
# ---------------------------------------------------------------------------------------------------------------------
def test_read_vendor_fields(tmp_path):
    a, _ = build(tmp_path, n=2)
    recs = P.read_pcap(a, 'AP')
    bad = [r for r in recs if r.tx and r.fkind == 'RTS']
    assert bad and all(r.tsft is None and r.sflags & P.SF_TSF_BAD for r in bad)
    rx = [r for r in recs if not r.tx and r.agg]
    assert rx and rx[0].length == 30000 and rx[0].mcs == 8 and rx[0].synth


def test_calibration_recovers_offsets(tmp_path):
    air = air_of(tmp_path)
    c = air.cal
    # кванты меток (floor) → оценка с точностью до долей мкс
    assert abs(c.off['STA'] - OFF_STA) <= Fr(1, 2)
    assert abs(c.rx_off['control'] - RX_OFF['control']) <= Fr(1, 2)
    assert abs(c.rx_off['sc'] - RX_OFF['sc']) <= Fr(1, 2)


def test_merge_dedupes_tx_and_synthetic_rx(tmp_path):
    air = air_of(tmp_path, n=6)
    k = [e.kind for e in air.events]
    # один BTI (4 маяка) + 6 обменов по 6 PPDU, каждый — одно событие
    assert len(air.events) == 4 + 6 * 6
    cts = [e for e in air.events if e.kind == 'DMG CTS']
    assert all(e.dur_ok and e.t_ok for e in cts)
    # DMG CTS точки: метка TX испорчена — время из RX станции, Duration — из TX
    ap_cts = [e for e in cts if e.tx_node == 'AP']
    assert ap_cts and all(e.t_from == 'rx' and e.by_mac for e in ap_cts)
    data = [e for e in air.events if e.kind == 'A-MPDU']
    assert all(e.synth and not e.dur_ok and e.dur is None for e in data)
    assert k.count('CF-End') == 12 and air.stats['t_unknown'] == 0


def test_event_times_match_construction(tmp_path):
    """Время события — начало PPDU на эфире (точка метки и сдвиг TSF сняты калибровкой): ошибка < 1.5 мкс."""
    ap, sta = Node('AP', AP_MAC, Fr(0)), Node('STA', STA_MAC, OFF_STA)
    t0 = Fr(50_000_000)
    for i in range(30):
        exchange(ap, sta, t0 + i * 400, 'STA' if i % 2 else 'AP')
    a, s = tmp_path / 'a.pcap', tmp_path / 's.pcap'
    ap.write(a)
    sta.write(s)
    air = P.merge([P.read_pcap(str(a), 'AP'), P.read_pcap(str(s), 'STA')], ref='AP')
    rts = [e for e in air.events if e.kind == 'RTS']
    want = [t0 + i * 400 for i in range(30)]
    assert len(rts) == 30
    assert max(abs(e.t - w) for e, w in zip(rts, want)) < Fr(3, 2)


def test_retry_matched_to_last_attempt(tmp_path):
    """Два RTS точки с испорченными метками в одних границах, станция приняла один — это последний (повтор)."""
    ap, sta = Node('AP', AP_MAC, Fr(0)), Node('STA', STA_MAC, Fr(0))
    t = Fr(1000)
    ap.rx(t, synth(FC_CFEND, AP_MAC, STA_MAC, 20), 20, 0)                          # хорошая метка — граница
    ap.tx(t + 50, ctl(FC_RTS, 1982, STA_MAC, AP_MAC), 20, 0, bad=True)               # не принят
    ap.tx(t + 150, ctl(FC_RTS, 1500, STA_MAC, AP_MAC), 20, 0, bad=True)              # принят
    sta.rx(t + 150, synth(FC_RTS, STA_MAC, AP_MAC, 20), 20, 0)
    ap.rx(t + 300, synth(FC_CTS, AP_MAC, STA_MAC, 20), 20, 0)
    sta.tx(t + 300, ctl(FC_CTS, 1400, AP_MAC, STA_MAC), 20, 0)
    a, s = tmp_path / 'a.pcap', tmp_path / 's.pcap'
    ap.write(a)
    sta.write(s)
    air = P.merge([P.read_pcap(str(a), 'AP'), P.read_pcap(str(s), 'STA')], ref='AP',
                  cal=P.Calib('AP', rx_off=dict(RX_OFF)))
    rts = sorted((e for e in air.events if e.kind == 'RTS'), key=lambda e: e.dur)
    assert rts[0].dur == 1500 and rts[0].t_ok and rts[0].rx_nodes == ('STA',)
    assert rts[1].dur == 1982 and not rts[1].t_ok


def test_ssw_sweep_aligned_by_cdown0(tmp_path):
    """RSS точки: TX с испорченными метками, у станции — синтетические SSW без CDOWN, два кадра не приняты; кадр с
    флагом CDOWN0 и шаг TXTIME(SSW) + SBIFS (10.42.2.2.2) ставят каждый принятый кадр на свой CDOWN."""
    ap, sta = Node('AP', AP_MAC, Fr(0)), Node('STA', STA_MAC, Fr(0))
    t = Fr(5000)
    sta.tx(t - 100, ctl(FC_CFEND, 0, AP_MAC, STA_MAC), 20, 0)
    ap.rx(t - 100, synth(FC_CFEND, AP_MAC, STA_MAC, 20), 20, 0)
    for cd in range(7, -1, -1):
        ssw = (1 | cd << 1 | (7 - cd) << 10).to_bytes(3, 'little')
        ap.tx(t, ctl(0x0864, 9 + cd * 16, STA_MAC, AP_MAC, ssw + b'\0\0\0'), 26, 0, bad=True)
        if cd not in (5, 2):
            fl = P.SF_SYNTH | P.SF_RA_OWN | P.SF_TA_PEER | (P.SF_CDOWN0 if cd == 0 else 0)
            sta.rx(t, synth(0x0864, STA_MAC, AP_MAC, 26), 26, 0, sflags=fl)
        t += T.T_SSW + T.SBIFS
    sta.tx(t + 9, ctl(FC_CFEND, 0, AP_MAC, STA_MAC), 20, 0)
    ap.rx(t + 9, synth(FC_CFEND, AP_MAC, STA_MAC, 20), 20, 0)
    a, s = tmp_path / 'a.pcap', tmp_path / 's.pcap'
    ap.write(a)
    sta.write(s)
    air = P.merge([P.read_pcap(str(a), 'AP'), P.read_pcap(str(s), 'STA')], ref='AP',
                  cal=P.Calib('AP', rx_off=dict(RX_OFF)))
    ssw = [e for e in air.events if e.kind == 'SSW']
    got = {e.p.ssw.cdown for e in ssw if e.t_ok}
    assert got == {7, 6, 4, 3, 1, 0}
    t0 = min(e.t for e in ssw if e.t_ok and e.p.ssw.cdown == 7)
    for e in ssw:
        if e.t_ok:
            assert abs(e.t - t0 - (7 - e.p.ssw.cdown) * (T.T_SSW + T.SBIFS)) < 1


# ---------------------------------------------------------------------------------------------------------------------
# судья
# ---------------------------------------------------------------------------------------------------------------------
def test_judge_clean_exchange(tmp_path):
    """Эфир по стандарту: SIFS 3 мкс, Duration DMG CTS по 9.3.1.13, BA Control Compressed без резерва, BA на MCS 4."""
    air = air_of(tmp_path)
    c, rules = J.judge(air)
    for rid in ('ifs_sifs', 'dur_cts', 'ba_control', 'mcs_response', 'mcs_control', 'ctl_len', 'cf_end_rules',
                'dur_cf_end', 'bi', 'nav_txop'):
        r = rule(rules, rid)
        assert r.checked > 0, rid
        assert not r.viol, (rid, r.viol[:3])
    s = rule(rules, 'ifs_sifs').info['calibration_free_sum']
    assert all(abs(v['sifs_sum'] - 6) < 1 for v in s.values()), s


def test_judge_finds_deviations(tmp_path):
    """SIFS 5 мкс, Duration DMG CTS на 1 меньше, B0 BA Control = 1, одиночный BA на MCS 8 — каждое правило ловит
    своё."""
    air = air_of(tmp_path, sifs=Fr(5), cts_dur_delta=-1, ba_ctl=0x0005, ba_mcs=8)
    c, rules = J.judge(air)
    assert rule(rules, 'ifs_sifs').viol
    s = rule(rules, 'ifs_sifs').info['calibration_free_sum']
    assert all(abs(v['sifs_sum'] - 10) < 1 for v in s.values()), s
    assert len(rule(rules, 'dur_cts').viol) == rule(rules, 'dur_cts').checked
    assert all('резервные биты 0x0001' in m for _, m, _ in rule(rules, 'ba_control').viol)
    assert any('MCS 8' in m for _, m, _ in rule(rules, 'mcs_response').viol)


def test_unavailable_information_is_reported(tmp_path):
    """То, чего нет в записи, — «не проверяемо» с причиной, а не «ок»."""
    air = air_of(tmp_path, n=4)
    c, rules = J.judge(air)
    ap_ = rule(rules, 'ack_policy')
    assert ap_.status == 'unchecked' and ap_.unchecked
    dr = rule(rules, 'dur_resp')
    assert dr.unchecked and not dr.viol            # Duration данных не записан → BA не с чем сравнить
    assert rule(rules, 'fc').unchecked              # синтетический FC
    text = J.report(air, rules, c)
    assert 'Не проверяемо по этому захвату' in text and 'txop_limit' in text


def test_bti_delay_with_idle_medium(tmp_path):
    """Маяки BTI начаты через 20 мкс после TBTT при свободной среде — 11.1.3.3.1."""
    ap, sta = Node('AP', AP_MAC, Fr(0)), Node('STA', STA_MAC, OFF_STA)
    t = beacon_bti(ap, sta, 400) + 200
    t = exchange(ap, sta, t, 'STA')
    beacon_bti(ap, sta, 401, delay=Fr(20))
    t = beacon_bti(ap, sta, 402) + 200
    exchange(ap, sta, t, 'AP')
    a, s = tmp_path / 'a.pcap', tmp_path / 's.pcap'
    ap.write(a)
    sta.write(s)
    air = P.merge([P.read_pcap(str(a), 'AP'), P.read_pcap(str(s), 'STA')])
    c, rules = J.judge(air)
    r = rule(rules, 'bti_delay')
    assert len(r.viol) == 1 and 'BI 401' in r.viol[0][1]


def test_rx_only_record_with_bad_stamp(tmp_path):
    """Регрессия (assoc_11/12): запись RX с испорченной меткой без TX-пары — событие без времени с границами, не
    падение (_ev_from брал границы только у TX)."""
    ap, sta = Node('AP', AP_MAC, Fr(0)), Node('STA', STA_MAC, Fr(0))
    t = beacon_bti(ap, sta, 400) + 200
    exchange(ap, sta, t, 'STA')
    sta.rx(t + 1000, ctl(FC_BEACON, 0, AP_MAC, b''), 46, 0, sflags=0, bad=True)
    sta.tx(t + 2000, ctl(FC_CFEND, 0, AP_MAC, STA_MAC), 20, 0)
    a, s_ = tmp_path / 'a.pcap', tmp_path / 's.pcap'
    ap.write(a)
    sta.write(s_)
    air = P.merge([P.read_pcap(str(a), 'AP'), P.read_pcap(str(s_), 'STA')])
    e = [x for x in air.events if not x.t_ok]
    assert len(e) == 1 and e[0].rx_nodes == ('STA',) and e[0].t_lo <= e[0].t_hi
    J.judge(air)


# ---------------------------------------------------------------------------------------------------------------------
# записи данных (mask rxqos,txqos): QoS Control, RD, Ack Policy, окно BlockAck, Duration A-MPDU, EDCA
# ---------------------------------------------------------------------------------------------------------------------
def qos_data(ra, ta, from_ds, dur, sn, ackpol=0, rdg=0, acc=0, tid=0, null=False):
    fc = (0x00c8 if null else 0x0088) | (0x0200 if from_ds else 0x0100)
    q = tid | ackpol << 5 | rdg << 9 | acc << 15
    a3 = AP_MAC
    return struct.pack('<HH', fc, dur) + ra + ta + a3 + struct.pack('<HH', sn << 4, q) + b'\xaa\xaa\x03\0\0\0\x08\0'


def ba_frame(ra, ta, dur, ssn, bitmap):
    return ctl(FC_BA, dur, ra, ta, struct.pack('<HH', 0x0004, ssn << 4) + bitmap.to_bytes(8, 'little'))


def rd_txop(ap, sta, t, acc=0, rdg=1, sta_dur=None, sta_rdg=0, amp_dur2=None, sn=100, ssn=100):
    """TXOP точки: RTS → DMG CTS → A-MPDU данных точки (RDG) → RD-ответ станции (BlockAck + данные) → BlockAck
    точки → CF-End. Данные записаны байтами: TX точки — заголовок данных, RX — у получателя."""
    rts = ctl(FC_RTS, 1982, STA_MAC, AP_MAC)
    ap.tx(t, rts, 20, 0)
    sta.rx(t, synth(FC_RTS, STA_MAC, AP_MAC, 20), 20, 0)
    t += T.txtime_control(20) + 3
    sta.tx(t, ctl(FC_CTS, 1965, AP_MAC, STA_MAC), 20, 0)
    ap.rx(t, synth(FC_CTS, AP_MAC, STA_MAC, 20), 20, 0)
    t += T.txtime_control(20) + 3
    L = 3000
    d = qos_data(STA_MAC, AP_MAC, True, 1900, sn, rdg=rdg, acc=acc)
    ap.tx(t, d, L, 8, agg=True)
    sta.rx(t, qos_data(STA_MAC, AP_MAC, True, amp_dur2 or 1900, sn + 1, rdg=rdg, acc=acc), L, 8, agg=True, sflags=0)
    t += T.txtime(L, 8) + 3
    L2 = 400
    sta.tx(t, ba_frame(AP_MAC, STA_MAC, sta_dur or 1800, ssn, 0xffff), L2, 8, agg=True)
    ap.rx(t, qos_data(AP_MAC, STA_MAC, False, sta_dur or 1800, 7, rdg=sta_rdg), L2, 8, agg=True, sflags=0)
    t += T.txtime(L2, 8) + 3
    ap.tx(t, ba_frame(STA_MAC, AP_MAC, 1700, 7, 1), 32, 4)
    sta.rx(t, synth(FC_BA, STA_MAC, AP_MAC, 32), 32, 4)
    t += T.txtime(32, 4) + 3
    ap.tx(t, ctl(FC_CFEND, 18, STA_MAC, AP_MAC), 20, 0)
    sta.rx(t, synth(FC_CFEND, STA_MAC, AP_MAC, 20), 20, 0)
    t += T.txtime_control(20) + 3
    sta.tx(t, ctl(FC_CFEND, 0, AP_MAC, STA_MAC), 20, 0)
    ap.rx(t, synth(FC_CFEND, AP_MAC, STA_MAC, 20), 20, 0)
    return t + T.txtime_control(20)


def data_air(tmp_path, n=8, **kw):
    ap, sta = Node('AP', AP_MAC, Fr(0)), Node('STA', STA_MAC, OFF_STA)
    t = beacon_bti(ap, sta, 400) + 200
    for i in range(n):
        t = rd_txop(ap, sta, t, **kw) + 50
    a, s_ = tmp_path / 'a.pcap', tmp_path / 's.pcap'
    ap.write(a)
    sta.write(s_)
    return P.merge([P.read_pcap(str(a), 'AP'), P.read_pcap(str(s_), 'STA')])


def test_data_records_merge_and_qos(tmp_path):
    """A-MPDU: TX-запись — первый MPDU, RX пира — MPDU данных; одно событие с двумя заголовками; QoS Control
    читается."""
    air = data_air(tmp_path, n=2)
    amp = [e for e in air.events if e.kind == 'A-MPDU']
    assert len(amp) == 4 and all(len(e.mpdus) == 2 for e in amp)
    q = J.data_hdr(amp[0])
    assert q['rdg'] == 1 and q['acc'] == 0 and q['ackpol'] == 0 and q['sn'] in (100, 101)
    rd = [e for e in amp if e.first == 'BlockAck']
    assert len(rd) == 2 and J.data_hdr(rd[0])['rdg'] == 0


def test_rd_rules(tmp_path):
    """10.29.3: RDG в TXOP EDCA — AC Constraint = 1; 10.29.4: RD-ответ — только на RDG."""
    c, rules = J.judge(data_air(tmp_path, acc=1))
    r = rule(rules, 'rd')
    assert r.checked and not r.viol, r.viol[:2]
    c, rules = J.judge(data_air(tmp_path, acc=0))
    assert any('AC Constraint' in m for _, m, _ in rule(rules, 'rd').viol)
    c, rules = J.judge(data_air(tmp_path, rdg=0))
    assert any('RD-ответ' in m and 'без RDG' in m for _, m, _ in rule(rules, 'rd').viol)


def test_ampdu_same_duration_and_ba_window(tmp_path):
    c, rules = J.judge(data_air(tmp_path, acc=1))
    assert rule(rules, 'ampdu_dur').checked and not rule(rules, 'ampdu_dur').viol
    assert rule(rules, 'ba_window').checked and not rule(rules, 'ba_window').viol
    assert rule(rules, 'ack_policy').checked and not rule(rules, 'ack_policy').viol
    c, rules = J.judge(data_air(tmp_path, acc=1, amp_dur2=1890, ssn=500))
    assert rule(rules, 'ampdu_dur').viol                       # 9.7.3: разные Duration в одном A-MPDU
    assert any('вне окна' in m for _, m, _ in rule(rules, 'ba_window').viol)


def test_edca_from_assoc_response_and_txop_limit(tmp_path):
    """EDCA Parameter Set (9.4.2.28) из Association Response точки → AIFSN и лимит TXOP для правил доступа."""
    from . import elements as E
    edca = bytes([0x00, 0x00, 0x03, 0xa4, 0x10, 0x00, 0x27, 0xa4, 0, 0, 0x42, 0x43, 0x10, 0x00, 0x62, 0x32, 0x10, 0])
    body = struct.pack('<HHH', 0, 0, 1) + bytes([12, len(edca)]) + edca
    ap, sta = Node('AP', AP_MAC, Fr(0)), Node('STA', STA_MAC, Fr(0))
    mp = struct.pack('<HH', 0x0010, 100) + STA_MAC + AP_MAC + AP_MAC + b'\0\0' + body
    ap.tx(Fr(1000), mp, len(mp) + 4, 0)
    sta.tx(Fr(1200), ctl(FC_CFEND, 0, AP_MAC, STA_MAC), 20, 0)
    a, s_ = tmp_path / 'a.pcap', tmp_path / 's.pcap'
    ap.write(a)
    sta.write(s_)
    air = P.merge([P.read_pcap(str(a), 'AP'), P.read_pcap(str(s_), 'STA')], ref='AP')
    p, src = J.edca_from(air.events, P.mac(AP_MAC))     # маяков нет — AP задан явно
    assert src.startswith(E.ASSOC_RESP)
    assert p['AC_BE'] == dict(aifsn=3, acm=0, ecwmin=4, ecwmax=10, txop_us=512)
    # лимит 512 мкс: RTS с Duration 1982 — нарушение 9.2.5.2 b) / 10.23.2.9
    air2 = air_of(tmp_path, n=2)
    c, rules = J.judge(air2, edca=(p, 'тест'))
    assert any('RTS Duration' in m for _, m, _ in rule(rules, 'txop_limit').viol)
    assert rule(rules, 'access').info['aifsn'].startswith('3')


# ---------------------------------------------------------------------------------------------------------------------
# настоящие pcap стенда
# ---------------------------------------------------------------------------------------------------------------------
REAL = (os.environ.get('AIR_PCAP_AP'), os.environ.get('AIR_PCAP_STA'))
REAL_ASSOC = (os.environ.get('AIR_PCAP_ASSOC_AP'), os.environ.get('AIR_PCAP_ASSOC_STA'))


@pytest.mark.slow
@pytest.mark.skipif(not all(p and os.path.exists(p) for p in REAL),
                    reason='нет AIR_PCAP_AP / AIR_PCAP_STA (pcap wilmon двух узлов)')
def test_real_capture():
    """Захват стенда: инварианты слияния и полнота отчёта (каждое правило — проверено или «не проверяемо» с
    причиной)."""
    air = P.merge([P.read_pcap(REAL[0], 'AP'), P.read_pcap(REAL[1], 'STA')])
    st = air.cal.stats
    assert air.ap == P.own_addr(air.recs['AP'])
    assert air.stats['mcs_tx_ne_rx'] == 0                       # info0 TX и RX пира — одно поле PHY
    assert st['tsf_off']['unreliable_bins'] == 0                # сдвиг TSF STA устойчив (окна по 100 мс)
    assert st['tsf_off']['max'] - st['tsf_off']['min'] < 1.5
    assert air.stats['t_unknown'] < 0.02 * air.stats['events']
    ts = [e.tsort for e in air.events]
    assert ts == sorted(ts)
    c, rules = J.judge(air)
    for r in rules:
        assert r.checked or r.unchecked, r.rid
        d = r.as_dict(c.evs)
        assert d['violations'] == len(r.viol) and all(x['verdict'] in ('ours', 'model', 'capture')
                                                      for x in d['examples'])
    print(J.report(air, rules, c, 3))


@pytest.mark.slow
@pytest.mark.skipif(not all(p and os.path.exists(p) for p in REAL_ASSOC),
                    reason='нет AIR_PCAP_ASSOC_AP / AIR_PCAP_ASSOC_STA (захват с ассоциацией)')
def test_real_association_capture():
    """Захват с ассоциацией: слияние не падает на RX без TX и с испорченной меткой (регрессия), EDCA Parameter Set
    найден в Association Response, тела кадров управления и ADDBA проверены."""
    air = P.merge([P.read_pcap(REAL_ASSOC[0], 'AP'), P.read_pcap(REAL_ASSOC[1], 'STA')])
    c, rules = J.judge(air)
    assert c.edca is not None and 'AC_BE' in c.edca
    for rid in ('mgmt_body', 'addba', 'edca', 'txop_limit', 'sls'):
        assert rule(rules, rid).checked, rid
