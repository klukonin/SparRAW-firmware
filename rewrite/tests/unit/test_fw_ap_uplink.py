# SPDX-License-Identifier: AGPL-3.0-or-later
"""Выгрузка станция → точка с обратной связью, как у TCP (стенд 2026-11-08: наша станция → наша точка 4–36 Мбит/с под
iperf3). Два узла на прошивке (fw + uc) в air.Air: станция держит не больше WIN неподтверждённых MSDU по 1500 Б вверх,
точка на каждые два принятых отвечает коротким MSDU вниз («ACK» с номером), станция по ним досылает. Канал — идеальный
или с потерей целых PPDU (Air.drop).

Эталон — 802.11-2020: получатель соглашения BA отвечает BlockAck на каждый A-MPDU с запросом немедленного BlockAck
(10.25.3, 10.25.6.6.2) — Compressed (9.3.1.8.2), RA = передатчик A-MPDU, TA — свой адрес; MSDU выше по стеку — по
порядку SN и по одному разу (10.25.6.6.3, дубликаты — Table 10-6); потерянный BlockAck/A-MPDU восстанавливается
повтором исходящей стороны (10.25.6.4), а не потерей MSDU. Живучесть: в непрерывном потоке нет пауз доставки дольше
LIVENESS_US.

Что эмулятор не видит: BlockAck и SN собирает модель MAC (air.py), а не железо — табло BA точки, привязка RX-колец и
прерывания хоста проверяются только на стенде (длинные замеры tests/test_ap.py, test_sta.py)."""
import pytest

import fwflows as F

pytestmark = pytest.mark.xdist_group('ap_uplink')

MSDU = 1500
ACK_LEN = 66
WIN = 32
SIM_US = 8000
LIVENESS_US = 3000
RESP_US = 30                         # BlockAck через SIFS (3 мкс) + TXTIME — с запасом


def _run(fw_elf, build_dir, uc_fw, drop=None, seed=5, prep=None):
    """prep(ap, sta, air) — до подключения (сценарии доступа к среде, test_fw_sls_collision)."""
    import fw_scenario as FS
    import machw
    from air import Air
    mk_fw, mk_uc = FS._makers(fw_elf, build_dir, uc_fw)
    ap = FS._node(mk_fw, mk_uc, F.AP_MAC)
    s = FS._node(mk_fw, mk_uc, FS.sta_mac(0))
    for n in (ap, s):
        n.bssid = ap.mac
    with ap:
        F.Fw(ap.fw).set_mac(ap.mac)
        F.Fw(ap.fw).set_ssid(FS.SSID)
        F.Fw(ap.fw).ap_start(bi=100)
    with s:
        F.Fw(s.fw).set_mac(s.mac)
    ap.hw.backoff_seed, s.hw.backoff_seed = seed, 1000 + seed
    ap.live()
    s.live()
    air = Air([ap, s])
    if prep:
        prep(ap, s, air)
    s.wmi(F.WMI_CONNECT, F.connect_cmd(bssid=ap.mac, ssid=FS.SSID))
    lim = ap.hw.now + 60_000 * 165
    while ap.hw.now < lim and not (FS._connected(s) and FS._connected_ap(ap, s)):
        air.run_us(500)
    assert FS._connected(s), 'станция не подключилась'
    s.wmi(F.WMI_VRING_CFG, F.vring_cfg_cmd(0, FS._connected(s)[0].body[0x13]))
    ap.wmi(F.WMI_VRING_CFG, F.vring_cfg_cmd(0, F.Fw(ap.fw).cid_of(s.mac)))
    qmask = lambda n: n.hw._raw(machw.HW_QSET0_MASK_VECTOR + 4 * machw.QSET_DATA_MASK)
    for _ in range(40):
        air.run_us(500)
        if qmask(s) & 1 and qmask(ap) & 1:
            break
    assert FS._ba_agree(air, s, ap, 0, 500), 'нет соглашения BA станция → точка'
    assert FS._ba_agree(air, ap, s, 0, 500), 'нет соглашения BA точка → станция'
    t0 = ap.hw.now
    n0 = len(air.frames)
    if drop:
        air.drop = drop(ap, s)
    from ref.blockack import ReorderBuffer
    sent = acked = ap_seen = sta_seen = dl_sent = 0
    rb = None                                       # буфер переупорядочения получателя (10.25.6.6) — у wil6210 в драйвере
    raw = []                                        # (мкс, SN, Retry, номер MSDU) — кольцо RX хоста точки как есть
    got = []                                        # (мкс, номер MSDU) — выдано буфером переупорядочения вверх
    while ap.hw.now < t0 + SIM_US * 165:
        while sent - acked < WIN:
            s.host_tx(0, ap.mac, sent.to_bytes(4, 'little') + bytes(MSDU - 4))
            sent += 1
        s.pump()
        air.run_us(100)
        for _, f in ap.host_rx[ap_seen:]:
            sn = int.from_bytes(f[22:24], 'little') >> 4
            idx = int.from_bytes(f[-MSDU:-MSDU + 4], 'little')
            t = (ap.hw.now - t0) / 165
            raw.append((t, sn, bool(f[1] & 0x08), idx))
            if rb is None:
                rb = ReorderBuffer(WIN, sn)         # WinStartB = SSN (ADDBA Request станции: SN первого MSDU)
            n = len(rb.delivered)
            rb.on_data(sn, idx)
            got.extend((t, m) for _, m in rb.delivered[n:])
        ap_seen = len(ap.host_rx)
        while len(got) // 2 > dl_sent:
            ap.host_tx(0, s.mac, len(got).to_bytes(4, 'little') + bytes(ACK_LEN - 4))
            dl_sent += 1
        ap.pump()
        for _, f in s.host_rx[sta_seen:]:
            acked = max(acked, int.from_bytes(f[-ACK_LEN:-ACK_LEN + 4], 'little'))
        sta_seen = len(s.host_rx)
    return dict(ap=ap, sta=s, air=air, frames=air.frames[n0:], got=got, raw=raw, sent=sent, t0=t0, end=ap.hw.now)


def _every(n, pick):
    """Потеря каждого n-го PPDU, отобранного pick(ap, sta, src, кадр, rec)."""
    def mk(ap, s):
        cnt = [0]

        def drop(src, frame, rec):
            if not pick(ap, s, src, frame, rec):
                return False
            cnt[0] += 1
            return cnt[0] % n == 0
        return drop
    return mk


def _ampdu(rec):
    return isinstance(rec.get('qframe'), list)


CASES = {
    'ideal': None,
    'ba-lost': _every(4, lambda ap, s, src, f, rec: src is ap and f[:2] == b'\x94\x00'),
    'ampdu-lost': _every(5, lambda ap, s, src, f, rec: src is s and _ampdu(rec)),
    'dl-ampdu-lost': _every(3, lambda ap, s, src, f, rec: src is ap and _ampdu(rec)),
}


@pytest.fixture(scope='module')
def runs(fw_elf, build_dir, uc_fw):
    return {}


def _get(runs, name, fw_elf, build_dir, uc_fw):
    if name not in runs:
        runs[name] = _run(fw_elf, build_dir, uc_fw, CASES[name])
    return runs[name]


@pytest.mark.parametrize('name', list(CASES))
def test_uplink_delivery_in_order_once(runs, fw_elf, build_dir, uc_fw, name):
    """10.25.6.6: после буфера переупорядочения получателя (WinSizeB = окно соглашения; в wil6210 буфер — в драйвере,
    MAC отдаёт в кольцо RX и повторы) MSDU станции идут по порядку, по одному разу, без пропусков; поток идёт
    (доставлено больше двух окон), паузы доставки не дольше LIVENESS_US."""
    r = _get(runs, name, fw_elf, build_dir, uc_fw)
    ids = [i for _, i in r['got']]
    assert len(ids) > 2 * WIN, 'доставлено %d MSDU за %d мкс' % (len(ids), SIM_US)
    assert len(set(ids)) == len(ids), 'дубликаты: %s' % sorted({i for i in ids if ids.count(i) > 1})[:10]
    assert ids == sorted(ids), 'не по порядку: %s' % [(a, b) for a, b in zip(ids, ids[1:]) if b < a][:10]
    assert ids == list(range(len(ids))), 'пропуски: %s' % sorted(set(range(max(ids) + 1)) - set(ids))[:10]
    ts = [0.0] + [t for t, _ in r['got']]
    gaps = [(a, b) for a, b in zip(ts, ts[1:]) if b - a > LIVENESS_US]
    assert not gaps, 'паузы доставки > %d мкс: %s' % (LIVENESS_US, gaps[:5])


@pytest.mark.parametrize('name', list(CASES))
def test_ap_blockack_per_ampdu(runs, fw_elf, build_dir, uc_fw, name):
    """10.25.3, 9.3.1.8.2: на каждый принятый точкой A-MPDU станции — BlockAck точки (Compressed, BA Control 0x0004:
    B1..B4 = 2 — Compressed BlockAck, TID 0), RA = станция, TA = точка, SSN не выше первого SN A-MPDU."""
    r = _get(runs, name, fw_elf, build_dir, uc_fw)
    ap, s = r['ap'], r['sta']
    fr = r['frames']
    for i, f in enumerate(fr):
        if f['src'] is not s or not f['mpdus'] or f.get('dropped') or f['end'] + RESP_US * 165 > r['end']:
            continue                                # потерянный в эфире или кончился у конца прогона — ответа ещё нет
        resp = next((g for g in fr[i + 1:i + 3] if g['src'] is ap and g['frame'][:2] == b'\x94\x00'), None)
        assert resp is not None, 'нет BlockAck точки на A-MPDU @%.1f мкс' % ((f['start'] - r['t0']) / 165)
        b = resp['frame']
        assert b[4:10] == bytes(s.mac) and b[10:16] == bytes(ap.mac), b[:16].hex()
        ctl = int.from_bytes(b[16:18], 'little')
        assert (ctl >> 1) & 0xf == 2 and ctl >> 12 == 0, 'BA Control %#06x' % ctl
        first = int.from_bytes(f['mpdus'][0][22:24], 'little') >> 4
        ssn = int.from_bytes(b[18:20], 'little') >> 4
        assert (first - ssn) & 0xfff < 0x800, 'SSN %d выше первого SN %d' % (ssn, first)
