# SPDX-License-Identifier: AGPL-3.0-or-later
"""Два узла в одном эфире (air.Air): AP и станция — каждая fw + uc в своей модели MAC. Станция после подключения
(WMI_CONNECT, ждёт маяк) принимает маяки AP, в BI с A-BFT (Next A-BFT = 0 в BI Control, который MAC пишет из 0x2a/0x2b)
шлёт пачку SSW в слоте, AP отвечает SSW-Feedback — оба uc сообщают fw «BF выполнен» (событие 0x05).
Под CPython ~10 мин, под PyPy ~2 мин (README).

Допущение H-SYNC (air.py): TSF узлов совпадает — станция входит в BTI по своему bi1_event (вход 0) и успевает
взвести GP0. На стенде станция после подключения входит с пути приёма (вход 1, abft_gp0_late_cnt растёт, A-BFT
пропускается, BF — в DTI): сетку TBTT она строит по Timestamp маяка, этого модель пока не делает.

Сроки — по 802.11-2020: A-BFT начинается через MBIFS после конца BTI (10.42.5.1), конец BTI E — конец последнего
маяка + его Duration; SSW пачки — через SBIFS (10.42.2.3.2, aSBIFSAccuracy); Feedback — в aAirPropagationTime +
aSSDuration + MBIFS от начала слота (10.42.5.2); допуск IFS — +10 % (aSlotTime − aAirPropagationTime) ≈ +0,49 мкс
(10.3.2.3.10)."""
import pytest

import fwflows as F
from air import Air
from cosim import CoSim
from machw import ctrl_txtime_clk

CLK = 165
MBIFS, SBIFS = 9, 1
IFS_TOL = 0.49
AIRPROP = 0.1
BI_TU = 100                                  # станция до ассоциации держит сетку TBTT 100 TU (короче BI AP — не видит)


def _node(make_fw, make_uc, mac):
    n = CoSim(make_fw(), make_uc(), first_tbtt_us=10_000)
    n.mac = mac
    return n


@pytest.fixture(scope='module')
def abft_run(fw_elf, build_dir, uc_fw):
    """Два узла до BI с A-BFT (прогон ~2 мин под PyPy) — общий для проверок ниже."""
    import os
    import fwemu
    import ucemu
    mk_fw = lambda: fwemu.FW(fw_elf).boot()
    mk_uc = lambda: ucemu.UC(os.path.join(build_dir, 'uc.elf'), uc_fw)
    ap = _node(mk_fw, mk_uc, F.AP_MAC)
    sta = _node(mk_fw, mk_uc, F.STA_MAC)
    with ap:
        F.Fw(ap.fw).set_mac(ap.mac)
        F.Fw(ap.fw).ap_start(bi=BI_TU)          # A-BFT — в 4-м BI (Next A-BFT 3, 2, 1, 0; N BIs A-BFT 4)
    with sta:
        F.Fw(sta.fw).set_mac(sta.mac)
        F.Fw(sta.fw).sta_connect(peer=ap.mac, stop='assoc_req')
    # только A-BFT: без доступа станции к среде в DTI (H-BACKOFF) — иначе BF проходит в DTI раньше и A-BFT не нужен
    sta.hw._qsel = lambda: None
    air = Air([ap, sta])
    ev_ap, ev_sta = [], []
    for _ in range(6):                       # по BI, пока оба не сообщат BF
        a, s = air.run_us(BI_TU * 1024)
        ev_ap += [t for t, _ in a]
        ev_sta += [t for t, _ in s]
        if 0x05 in ev_ap and 0x05 in ev_sta:
            break
    log = ap.hw.air_log
    fb = [s for s, e, k, w in log if k == 'tx' and w.startswith('direct')]
    ssw = []
    if fb:
        # пачка A-BFT — SSW станции перед Feedback AP (раньше в DTI могут быть развёртки TXSS станции, H-BACKOFF)
        ssw_all = [(s, e) for s, e, k, w in log if k == 'rx' and w.startswith('sweep') and s < fb[0]]
        ssw = [ssw_all[-1]]
        for a in reversed(ssw_all[:-1]):
            if ssw[0][0] - a[1] > 2 * CLK:               # зазор больше SBIFS — другая пачка
                break
            ssw.insert(0, a)
    return dict(ap=ap, sta=sta, ev_ap=ev_ap, ev_sta=ev_sta, fb=fb, ssw=ssw)


def test_two_nodes_abft_sls(abft_run):
    r = abft_run
    ap, sta, fb, ssw = r['ap'], r['sta'], r['fb'], r['ssw']
    assert 0x05 in r['ev_ap'] and 0x05 in r['ev_sta'], (r['ev_ap'], r['ev_sta'])
    assert not ap.hw.late and not sta.hw.late
    log = ap.hw.air_log
    last = [(s, e) for s, e, k, w in log if k == 'tx' and w.startswith('sweep') and s < ssw[0][0]][-1]
    E = last[1] + ap.hw.air_dur_log[last[0]] * CLK
    first = (ssw[0][0] - E) / CLK
    assert MBIFS <= first <= MBIFS + IFS_TOL, first
    n = len(ssw)
    ssdur = (n * ctrl_txtime_clk(26) + (n - 1) * SBIFS * CLK) / CLK
    want = AIRPROP + ssdur + MBIFS
    got = (fb[0] - (E + MBIFS * CLK)) / CLK
    assert want <= got <= want + IFS_TOL, (got, want)


@pytest.mark.xfail(reason='uc abft_ssw_burst: путь tx_end → 0x19 следующего SSW ~299 тактов при бюджете 300 (модель); '
                          'после BF в DTI зазор до 1,0303 мкс > SBIFS + aSBIFSAccuracy', strict=False)
def test_abft_ssw_sbifs_accuracy(abft_run):
    """10.3.2.3.8, 10.42.2.3.2: соседние SSW пачки — через SBIFS (1 мкс) с допуском aSBIFSAccuracy 0,03 мкс."""
    ssw = abft_run['ssw']
    gaps = [(b[0] - a[1]) / CLK for a, b in zip(ssw, ssw[1:])]
    assert all(abs(g - SBIFS) <= 0.03 for g in gaps), (len(ssw), [g for g in gaps if abs(g - SBIFS) > 0.03])


WMI_CONNECT_EVENT = 0x1002


def test_live_association(fw_factory, uc_factory):
    """Живой эфир (fw во времени модели, CoSim.live): станция с одного WMI_CONNECT — маяк → BF в DTI (TXSS, RSS,
    Feedback, Ack; uc — BF_DONE_OK) → Assoc Request (очередь MAC 0x1a, Ack MAC точки) → Assoc Response → Ack → BRP;
    fw станции сообщает хосту WMI_CONNECT_EVENT. Ошибок MAC (поздних ответов) нет. Стенд (журнал fw станции,
    2026-10-30): тот же порядок — BF DONE DTI_TXSS → ASSOC REQ → ASSOC RESP → BF TXSS_BRP → WMI_CONNECT_EVENT."""
    ap = _node(fw_factory, uc_factory, F.AP_MAC)
    sta = _node(fw_factory, uc_factory, F.STA_MAC)
    ap.bssid = sta.bssid = ap.mac
    with ap:
        F.Fw(ap.fw).set_mac(ap.mac)
        F.Fw(ap.fw).set_ssid(b'test')
        F.Fw(ap.fw).ap_start(bi=BI_TU)
    with sta:
        F.Fw(sta.fw).set_mac(sta.mac)
    ap.hw.backoff_seed, sta.hw.backoff_seed = 1, 1001  # другие seed — столкновения (не моделируются) и assert 0x26 BRP
    ap.live()
    sta.live()
    sta.wmi(F.WMI_CONNECT, F.connect_cmd(bssid=ap.mac, ssid=b'test'))
    air = Air([ap, sta])
    air.run_us(40_000)
    evts = [e[0] if isinstance(e, tuple) else e for e in sta.fw.wmi_evts]
    assert WMI_CONNECT_EVENT in evts, [hex(e) for e in evts]
    assert not ap.hw.late and not sta.hw.late
    assert [f for f in sta.hw.air_log if f[3].startswith('queue 0x1a')], 'Assoc Request не уходил из очереди MAC'


SIFS_US = 3.0
SIFS_TOL_US = 0.49                                         # 10.3.2.3.3: DMG −0 %/+10 %×(aSlotTime − aAirPropagationTime)
MACLAT_US = 0.55                                           # machw H-ORIGIN: старт передачи MAC — IFS + 0,55 мкс (стенд)


@pytest.fixture(scope='module')
def live_data(fw_elf, build_dir, uc_fw):
    """Ассоциация в живом эфире, затем кольцо TX хоста станции (WMI_VRING_CFG) и 5 кадров данных станция → AP."""
    import os
    import fwemu
    import machw
    import ucemu
    fw_factory = lambda: fwemu.FW(fw_elf).boot()
    uc_factory = lambda: ucemu.UC(os.path.join(build_dir, 'uc.elf'), uc_fw)
    ap = _node(fw_factory, uc_factory, F.AP_MAC)
    sta = _node(fw_factory, uc_factory, F.STA_MAC)
    ap.bssid = sta.bssid = ap.mac
    with ap:
        F.Fw(ap.fw).set_mac(ap.mac)
        F.Fw(ap.fw).set_ssid(b'test')
        F.Fw(ap.fw).ap_start(bi=BI_TU)
    with sta:
        F.Fw(sta.fw).set_mac(sta.mac)
    ap.hw.backoff_seed, sta.hw.backoff_seed = 1, 1001
    ap.live()
    sta.live()
    sta.wmi(F.WMI_CONNECT, F.connect_cmd(bssid=ap.mac, ssid=b'test'))
    air = Air([ap, sta])
    for _ in range(80):
        air.run_us(500)
        if any(e.id == WMI_CONNECT_EVENT for e in sta.fw.wmi_evts):
            break
    ce = [e for e in sta.fw.wmi_evts if e.id == WMI_CONNECT_EVENT]
    assert ce, 'нет WMI_CONNECT_EVENT'
    n_ev = len(sta.fw.wmi_evts)
    sta.wmi(F.WMI_VRING_CFG, F.vring_cfg_cmd(0, ce[0].body[0x13]))
    done = [e for e in sta.fw.wmi_evts[n_ev:] if e.id == F.WMI_VRING_CFG_DONE]
    mask = lambda: sta.hw._raw(machw.HW_QSET0_MASK_VECTOR + 4 * machw.QSET_DATA_MASK)
    for _ in range(20):                                    # uc берёт команду, когда закончит BF после ассоциации
        air.run_us(500)
        if mask() & 1:
            break
    q6 = mask()
    # Данные — после серии BF станции после ассоциации (своя TXSS — SSW через SBIFS, SSW-Feedback, BRP; повтор через
    # ~1,8 мс, 3–4 раза — число зависит от того, как она ложится относительно маяков точки). Кадр, вставший в очередь во
    # время серии, в эмуляции уходит через ~1 BI; на стенде первый ping после переассоциации (wpa_cli reconnect) —
    # 18–20 мс, дальше 0,7 мс (2026-10-31) — модель расходится с железом (busy2 и кольца TX во время своей TXSS не
    # сняты) — пробел модели «данные во время своей TXSS».
    for _ in range(80):
        last = max((st for st, en, k, w in sta.hw.air_log if k == 'tx' and w.startswith('sweep')), default=0)
        if sta.hw.now - last > 3000 * 165:              # серия BF после ассоциации — через ~1,8 мс; тишина 3 мс — конец
            break
        air.run_us(500)
    t0 = sta.hw.now
    payloads = [bytes([i]) * (1000 + 100 * i) for i in range(5)]     # как MSDU iperf (короткие кадры — см. notes)
    for p in payloads:
        sta.host_tx(0, ap.mac, p)
    sta.pump()
    for _ in range(10):
        air.run_us(500)
        if len(sta.host_done) == len(payloads):
            break
    log = sorted((s, e, w) for s, e, k, w in sta.hw.air_log if s >= t0)
    data = [i for i, (s, e, w) in enumerate(log) if w.startswith('queue 0x0 ')]
    # AP → станция: драйвер AP настраивает кольцо для cid станции (по WMI_CONNECT_EVENT AP)
    ace = [e for e in ap.fw.wmi_evts if e.id == WMI_CONNECT_EVENT]
    n_ev = len(ap.fw.wmi_evts)
    ap.wmi(F.WMI_VRING_CFG, F.vring_cfg_cmd(0, ace[0].body[0x13] if ace else 0))
    ap_done = [e for e in ap.fw.wmi_evts[n_ev:] if e.id == F.WMI_VRING_CFG_DONE]
    for _ in range(20):
        air.run_us(500)
        if ap.hw._raw(machw.HW_QSET0_MASK_VECTOR + 4 * machw.QSET_DATA_MASK) & 1:
            break
    t1 = ap.hw.now
    for p in payloads:
        ap.host_tx(0, sta.mac, p)
    ap.pump()
    for _ in range(10):
        air.run_us(500)
        if len(ap.host_done) == len(payloads):
            break
    return dict(air=air, ap=ap, sta=sta, done=done, q6=q6, t0=t0, payloads=payloads, log=log, data=data, ace=ace,
                ap_done=ap_done, t1=t1)


def test_live_data(live_data):
    """Данные хоста в живом эфире: после ассоциации драйвер станции настраивает кольцо TX (WMI_VRING_CFG, как
    wil_vring_init_tx) — fw отвечает WMI_VRING_CFG_DONE (статус 0, хвост кольца — регистр очереди MAC), uc включает
    очередь кольца в наборе qset 6 (LMAC 0x08). Хост кладёт 5 кадров 802.3 → DMA (fw привязывает кольцо к pring,
    TXQ_RING_ENABLE) → очередь MAC → TXOP станции → кольцо RX хоста AP. Все кадры подтверждены Ack через SIFS
    (10.3.2.3.3), MAC без ошибок (поздних ответов нет), столкновений на данных нет; при пустой
    очереди TXOP закрывает CF-End (10.39.8). Срок SIFS ответа и продолжения TXOP — отдельный тест (xfail)."""
    import machw
    r = live_data
    ap, sta, payloads, log, data = r['ap'], r['sta'], r['payloads'], r['log'], r['data']
    done = r['done']
    # struct wmi_vring_cfg_done_event: ringid, status, резерв[2], tx_vring_tail_ptr — регистр хвоста очереди MAC кольца 0
    assert done and done[0].body[0] == 0 and done[0].body[1] == 0, done
    assert int.from_bytes(done[0].body[4:8], 'little') == 0x440c100 >> 3, done[0].body.hex()
    assert r['q6'] & 1, 'кольцо 0 не включено в qset 6'
    assert [st for _, vr, st in sta.host_done] == [0] * len(payloads), sta.host_done
    got = [f for _, f in ap.host_rx]
    assert [f[-len(p):] for f, p in zip(got, payloads)] == payloads
    assert all(f[0:2] == b'\x88\x01' and f[4:10] == ap.mac and f[10:16] == sta.mac for f in got)   # QoS Data, To DS
    assert not ap.hw.late and not sta.hw.late
    assert not [c for c in sta.hw.collisions + ap.hw.collisions if c[0] >= r['t0']], (sta.hw.collisions, ap.hw.collisions)
    # H-RETRY: неподтверждённый кадр MAC повторяет (802.11-2020 10.23.2.12); хост получает каждый кадр один раз
    assert len(data) == len(payloads) + len(sta.hw.retry_log), (log, sta.hw.retry_log)
    assert len(got) == len(payloads)
    acked = 0
    for i in data:
        s, e, w = log[i]
        assert w.endswith('MCS %d' % sta.hw.data_mcs)
        a = log[i + 1] if i + 1 < len(log) else None
        if a is None or not a[2].startswith('ответ на queue 0x0'):
            continue                                        # кадр без Ack — повторён
        acked += 1
    assert acked == len(payloads)
    assert log[-1][2] == 'direct 20 B', log[-1]                # CF-End в конце последнего TXOP
    # H-PKTMODE (стенд): очередь данных — packet_mode 1, каждый TXOP открывают RTS → DMG CTS (10.3.2.9)
    starts = [i for i in data if i < 2 or not log[i - 1][2].startswith('ответ на queue')]
    assert starts and all(log[i - 2][2] == 'direct 20 B' and log[i - 1][2] == 'ответ на direct 20 B' for i in starts), log


def test_live_data_ap_to_sta(live_data):
    """То же в обратную сторону: AP по WMI_CONNECT_EVENT (cid станции) настраивает кольцо TX, 5 кадров AP → станция —
    QoS Data From DS (A1 — станция, A2 — BSSID), все подтверждены Ack, без поздних ответов и столкновений."""
    r = live_data
    ap, sta, payloads = r['ap'], r['sta'], r['payloads']
    assert r['ace'], 'нет WMI_CONNECT_EVENT у AP'
    d = r['ap_done']
    assert d and d[0].body[1] == 0, d
    assert [st for _, vr, st in ap.host_done] == [0] * len(payloads), ap.host_done
    got = [f for t, f in sta.host_rx if t >= r['t1']]
    assert [f[-len(p):] for f, p in zip(got, payloads)] == payloads
    assert all(f[0:2] == b'\x88\x02' and f[4:10] == sta.mac and f[10:16] == ap.mac for f in got)   # QoS Data, From DS
    assert not ap.hw.late and not sta.hw.late
    assert not [c for c in sta.hw.collisions + ap.hw.collisions if c[0] >= r['t1']], (sta.hw.collisions, ap.hw.collisions)


@pytest.mark.xfail(reason='ответ uc на кадр SC и продолжение TXOP в модели позже SIFS (Ack ~6,5 мкс, продолжение ~5,6 мкс). '
                          'Стенд 2026-10-30 (docs/MAC-STAND.md): команда BlockAck при SIFS_CNT до 1074, продолжение TXOP '
                          'после BlockAck — 840–990 тактов, без ошибок; где ноль SIFS_CNT относительно конца PPDU — не '
                          'установлено (нужен снифер)', strict=False)
def test_live_data_sifs(live_data):
    """802.11-2020 10.3.2.3.3, 10.3.2.11, 10.23.2.8: Ack — через SIFS после кадра данных, следующий кадр TXOP — через
    SIFS после Ack (допуск DMG +0,49 мкс; старт MAC — +0,55 мкс, H-ORIGIN)."""
    log = live_data['log']
    gaps = []
    for i in live_data['data']:
        e = log[i][1]
        a = log[i + 1] if i + 1 < len(log) else None
        if a is None or not a[2].startswith('ответ на queue 0x0'):
            continue
        gaps.append(('Ack', (a[0] - e) / CLK))
        nxt = log[i + 2] if i + 2 < len(log) else None
        if nxt and nxt[2].startswith('queue 0x0 ') and nxt[0] - a[1] < 10 * CLK:
            gaps.append(('TXOP', (nxt[0] - a[1]) / CLK))
    assert gaps, log
    assert all(SIFS_US <= g <= SIFS_US + SIFS_TOL_US + MACLAT_US for _, g in gaps), gaps


@pytest.fixture(scope='module')
def live_ampdu(fw_elf, build_dir, uc_fw):
    """Ассоциация, кольцо TX станции, соглашение BA (WMI_RING_BA_EN → ADDBA Request/Response → WMI_BA_STATUS_EVENT),
    затем 8 кадров по 1400 Б станция → AP — TXOP через RTS/CTS: очередь данных — packet_mode 1 (H-PKTMODE, стенд);
    qid_agg_mask (команда 8 тип 3 при остановке pring) на стенде всегда 0 и здесь не нужен."""
    import os
    import fwemu
    import machw
    import ucemu
    ap = _node(lambda: fwemu.FW(fw_elf).boot(), lambda: ucemu.UC(os.path.join(build_dir, 'uc.elf'), uc_fw), F.AP_MAC)
    sta = _node(lambda: fwemu.FW(fw_elf).boot(), lambda: ucemu.UC(os.path.join(build_dir, 'uc.elf'), uc_fw), F.STA_MAC)
    ap.bssid = sta.bssid = ap.mac
    with ap:
        F.Fw(ap.fw).set_mac(ap.mac)
        F.Fw(ap.fw).set_ssid(b'test')
        F.Fw(ap.fw).ap_start(bi=BI_TU)
    with sta:
        F.Fw(sta.fw).set_mac(sta.mac)
    ap.hw.backoff_seed, sta.hw.backoff_seed = 1, 1001
    ap.live()
    sta.live()
    sta.wmi(F.WMI_CONNECT, F.connect_cmd(bssid=ap.mac, ssid=b'test'))
    air = Air([ap, sta])
    for _ in range(80):
        air.run_us(500)
        if any(e.id == WMI_CONNECT_EVENT for e in sta.fw.wmi_evts):
            break
    ce = [e for e in sta.fw.wmi_evts if e.id == WMI_CONNECT_EVENT]
    assert ce, 'нет WMI_CONNECT_EVENT'
    sta.wmi(F.WMI_VRING_CFG, F.vring_cfg_cmd(0, ce[0].body[0x13]))
    for _ in range(20):
        air.run_us(500)
        if sta.hw._raw(machw.HW_QSET0_MASK_VECTOR + 4 * machw.QSET_DATA_MASK) & 1:
            break
    n_sta, n_ap = len(sta.fw.wmi_evts), len(ap.fw.wmi_evts)
    sta.wmi(F.WMI_RING_BA_EN, F.ring_ba_en_cmd(0))
    req = []
    for _ in range(20):
        air.run_us(500)
        req = [e for e in ap.fw.wmi_evts[n_ap:] if e.id == F.WMI_RCP_ADDBA_REQ_EVENT]
        if req:
            break
    if req:
        ap.wmi(F.WMI_RCP_ADDBA_RESP, F.rcp_addba_resp_cmd(req[0].body))
    st = []
    for _ in range(20):
        air.run_us(500)
        st = [e for e in sta.fw.wmi_evts[n_sta:] if e.id == F.WMI_BA_STATUS_EVENT]
        if st:
            break
    t0 = sta.hw.now
    payloads = [bytes([0x40 + i]) * 1400 for i in range(8)]
    for p in payloads:
        sta.host_tx(0, ap.mac, p)
    sta.pump()
    for _ in range(12):
        air.run_us(500)
        if len(sta.host_done) == len(payloads):
            break
    log = sorted((s, e, w) for s, e, k, w in sta.hw.air_log if s >= t0)
    return dict(ap=ap, sta=sta, req=req, st=st, t0=t0, payloads=payloads, log=log)


def test_live_ampdu(live_ampdu):
    import machw
    """Соглашение BA (802.11-2020 11.5): ADDBA Request станции (fw, очередь 0x1a) → WMI_RCP_ADDBA_REQ_EVENT у AP (окно
    32) → ответ хоста → WMI_BA_STATUS_EVENT «согласовано» у станции. Данные: TXOP через RTS → DMG CTS (10.3.2.9),
    A-MPDU (окно BA; 10.12) → BlockAck (10.25.3), при пустой очереди — CF-End. Все MPDU доставлены хосту AP один раз,
    у хоста станции — статус 0; поздних ответов и столкновений нет. Форма обмена — как на стенде (docs/MAC-STAND.md)."""
    r = live_ampdu
    ap, sta, log = r['ap'], r['sta'], r['log']
    assert r['req'] and ((int.from_bytes(r['req'][0].body[2:4], 'little') >> 6) & 0x3ff) == 32, r['req']
    # Block Ack Parameter Set (802.11-2020 9.4.1.13, рис. 9-96): B1 Block Ack Policy = 1 — immediate block ack
    assert (int.from_bytes(r['req'][0].body[2:4], 'little') >> 1) & 1 == 1, r['req'][0].body[2:4].hex()
    assert r['st'] and r['st'][0].body[0] == 0 and r['st'][0].body[5] == 32, r['st']
    assert [st for _, vr, st in sta.host_done] == [0] * len(r['payloads']), (sta.host_done, sta.hw.retry_log)
    got = [f for t, f in ap.host_rx if t >= r['t0']]
    assert [f[-1400:] for f in got] == r['payloads']
    kinds = [w for s, e, w in log]
    assert kinds[0] == 'direct 20 B' and kinds[1].startswith('ответ на direct 20 B'), kinds[:4]   # RTS → CTS
    amp = [i for i, w in enumerate(kinds) if 'A-MPDU' in w and w.startswith('queue')]
    assert amp and all(kinds[i + 1].startswith('ответ на queue 0x0 A-MPDU') for i in amp), kinds
    assert sum(int(kinds[i].split('A-MPDU ')[1].split()[0]) for i in amp) == len(r['payloads'])
    assert not ap.hw.late and not sta.hw.late
    assert not [c for c in sta.hw.collisions + ap.hw.collisions if c[0] >= r['t0']]
    # BlockAck на A-MPDU MCS 8 — MCS 4 (10.6.7.2: обязательный SC не быстрее запроса, кратчайший): явный MCS в 0x17
    rates = {(v >> 8) & 0x1f for t, v in ap.hw.cmd_log if t >= r['t0'] and v >> 24 == 0x17 and v & 3 == 3 and v & 0xff00}
    assert rates == {machw.resp_mcs(8)}, rates


def _ref_report(ev, v):
    return '\n'.join('%s %s @%.2f мкс: %s' % (x.rule, ev[x.idx][4], float(ev[x.idx][0]), x.msg) for x in v[:20])


def test_live_data_reference_access_rules(live_data):
    """Журнал эфира живых данных (станция → AP и AP → станция) — правила доступа к среде эталона (tests/ref/cbap.py):
    AIFS/backoff (10.23.2.4), NAV (10.3.2.4), TXNAV (10.23.2.8), лимит TXOP — объявленный AP в EDCA Parameter Set
    (AC_BE 0x40 × 32 мкс = 2048 мкс, 9.4.2.28), конец CBAP (10.39.4/10.39.5), CF-End (10.23.2.10). Допуск SIFS здесь
    широкий (5 мкс) — срок ответа проверяет test_live_data_reference_sifs."""
    import ref_bridge
    from fractions import Fraction as Fr
    ev, v = ref_bridge.check(live_data['air'], live_data['t0'], txop_limit=2048, sifs_tol=Fr(5), slot_tol=Fr(5))
    assert not v, _ref_report(ev, v)


@pytest.mark.xfail(strict=True, reason='ответ через SIFS и продолжение TXOP в эмуляции на 2,6–4,9 мкс позже SIFS '
                                       '(10.3.2.3.3: +0,49 мкс) — тот же срок, что xfail test_live_data_sifs; на железе зазор '
                                       'в эфире без сниффера не измерен')
def test_live_data_reference_sifs(live_data):
    """То же, со строгим допуском SIFS (10.3.2.3.3: −0 / +10 %·(aSlotTime − aAirPropagationTime))."""
    import ref_bridge
    ev, v = ref_bridge.check(live_data['air'], live_data['t0'], txop_limit=2048)
    assert not v, _ref_report(ev, v)
