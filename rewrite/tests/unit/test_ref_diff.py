# SPDX-License-Identifier: AGPL-3.0-or-later
"""Дифференциальные проверки прошивки по эталонной модели 802.11-2020 (tests/ref): журнал эфира эмулятора (fw + uc в
air.Air) → ref_bridge2 (разбор кадров ref/fields, ref/elements; время — Fraction мкс) → судьи модели.

Сценарии (как в test_air.py):
  abft — старт AP (маяки по 32 секторам в BTI) и станция до Assoc Request без живого fw: BI с A-BFT — пачка SSW
         станции в слоте 0 и SSW-Feedback точки;
  live — живой эфир: WMI_CONNECT → BF в DTI (ISS/RSS/SSW-Feedback/SSW-Ack) → Assoc Request/Response → BF и BRP после
         ассоциации → ADDBA Request/Response → RTS/DMG CTS → A-MPDU → BlockAck → CF-End.
Судьи: ref/bi.check_air_log (BTI, A-BFT, периоды DTI), ref/abft.check_abft_log, ref/sls.check_sls_log (SLS в DTI),
ref/fields.check_mpdu/check_fc (каждый кадр), ref/elements.check_body (тела 9.3.3), ref/duration.check_duration
(Duration каждого кадра по контексту журнала), ref/cbap.check_air_log (доступ в CBAP), ref/blockack (ADDBA).

Отклонения прошивки от стандарта — xfail(strict=True) с пунктом: исправление в fw/uc снимет xfail (strict — тест
тогда упадёт как XPASS и напомнит убрать отметку). То, что строит не прошивка, а модель MAC эмулятора (ответы через
SIFS — Ack/DMG CTS/BlockAck, Duration кадров очередей H-DURQ, отсчёт backoff), отделено: отклонения модели эмулятора
— отдельные xfail с пометкой «эмулятор:», они не о прошивке.

Под PyPy: abft ~2,5 мин, live ~20 с (README: PYTEST_DISABLE_PLUGIN_AUTOLOAD=1 pypy3 -m pytest -p no:cacheprovider)."""
import os

import pytest

import fwflows as F
from air import Air
from cosim import CoSim

BI_TU = 100
WMI_CONNECT_EVENT = 0x1002


def _node(mk_fw, mk_uc, mac):
    n = CoSim(mk_fw(), mk_uc(), first_tbtt_us=10_000)
    n.mac = mac
    return n


def _makers(fw_elf, build_dir, uc_fw):
    import fwemu
    import ucemu
    return (lambda: fwemu.FW(fw_elf).boot()), (lambda: ucemu.UC(os.path.join(build_dir, 'uc.elf'), uc_fw))


def run_abft(fw_elf, build_dir, uc_fw):
    """Старт AP (маяки по секторам) и станция до Assoc Request (fw не во времени модели): BI с A-BFT — пачка SSW
    станции в слоте, SSW-Feedback AP (как test_air.abft_run)."""
    import ref_bridge2 as RB
    mk_fw, mk_uc = _makers(fw_elf, build_dir, uc_fw)
    ap = _node(mk_fw, mk_uc, F.AP_MAC)
    sta = _node(mk_fw, mk_uc, F.STA_MAC)
    with ap:
        F.Fw(ap.fw).set_mac(ap.mac)
        F.Fw(ap.fw).ap_start(bi=BI_TU)
    with sta:
        F.Fw(sta.fw).set_mac(sta.mac)
        F.Fw(sta.fw).sta_connect(peer=ap.mac, stop='assoc_req')
    sta.hw._qsel = lambda: None              # только A-BFT (без доступа станции в DTI), как test_air.abft_run
    air = Air([ap, sta])
    ev_ap, ev_sta = [], []
    for _ in range(6):
        a, s = air.run_us(BI_TU * 1024)
        ev_ap += [t for t, _ in a]
        ev_sta += [t for t, _ in s]
        if 0x05 in ev_ap and 0x05 in ev_sta:
            break
    return dict(air=air, ap=ap, sta=sta, ev_ap=ev_ap, ev_sta=ev_sta, snap=RB.snapshot(air))


def run_live(fw_elf, build_dir, uc_fw):
    """Живой эфир (fw во времени модели): WMI_CONNECT станции → маяк → BF в DTI → Assoc Request/Response → BRP →
    кольцо TX → ADDBA Request/Response → A-MPDU станция → AP через RTS/DMG CTS → BlockAck → CF-End (как
    test_air.live_ampdu)."""
    import machw
    import ref_bridge2 as RB
    mk_fw, mk_uc = _makers(fw_elf, build_dir, uc_fw)
    ap = _node(mk_fw, mk_uc, F.AP_MAC)
    sta = _node(mk_fw, mk_uc, F.STA_MAC)
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
    marks = dict(connected=sta.hw.now)
    st, req = [], []
    if ce:
        sta.wmi(F.WMI_VRING_CFG, F.vring_cfg_cmd(0, ce[0].body[0x13]))
        for _ in range(20):
            air.run_us(500)
            if sta.hw._raw(machw.HW_QSET0_MASK_VECTOR + 4 * machw.QSET_DATA_MASK) & 1:
                break
        n_sta, n_ap = len(sta.fw.wmi_evts), len(ap.fw.wmi_evts)
        sta.wmi(F.WMI_RING_BA_EN, F.ring_ba_en_cmd(0))
        for _ in range(20):
            air.run_us(500)
            req = [e for e in ap.fw.wmi_evts[n_ap:] if e.id == F.WMI_RCP_ADDBA_REQ_EVENT]
            if req:
                break
        if req:
            ap.wmi(F.WMI_RCP_ADDBA_RESP, F.rcp_addba_resp_cmd(req[0].body))
        for _ in range(20):
            air.run_us(500)
            st = [e for e in sta.fw.wmi_evts[n_sta:] if e.id == F.WMI_BA_STATUS_EVENT]
            if st:
                break
        marks['data'] = sta.hw.now
        payloads = [bytes([0x40 + i]) * 1400 for i in range(8)]
        for p in payloads:
            sta.host_tx(0, ap.mac, p)
        sta.pump()
        for _ in range(12):
            air.run_us(500)
            if len(sta.host_done) == len(payloads):
                break
    return dict(air=air, ap=ap, sta=sta, connected=bool(ce), ba=bool(st), req=req, marks=marks,
                snap=RB.snapshot(air))


# =====================================================================================================================
# фикстуры: один прогон сценария на модуль, события и находки всех судей
# =====================================================================================================================
AP = F.AP_MAC
AP_S = ':'.join('%02x' % b for b in AP)


def _judge(run):
    import ref_bridge2 as RB
    evs = RB.events(run['snap'], AP)
    sched = RB.Schedule(evs, AP_S, BI_TU)
    lim = RB.edca_txop_limit(evs, AP_S)
    return dict(run, evs=evs, sched=sched, lim=lim, RB=RB)


@pytest.fixture(scope='module')
def abft(fw_elf, build_dir, uc_fw):
    return _judge(run_abft(fw_elf, build_dir, uc_fw))


@pytest.fixture(scope='module')
def live(fw_elf, build_dir, uc_fw):
    return _judge(run_live(fw_elf, build_dir, uc_fw))


def _rep(r, found):
    return '\n' + r['RB'].report(r['evs'], found, 25)


def _no(r, found):
    assert not found, _rep(r, found)


def _by(found, *rules, judge=None):
    return [f for f in found if (not rules or f.rule in rules) and (judge is None or f.judge == judge)]


# =====================================================================================================================
# сценарий abft: BTI + A-BFT
# =====================================================================================================================
def test_abft_scenario(abft):
    """Сценарий состоялся: оба uc сообщили «BF выполнен» (0x05), в журнале — маяки точки и SSW-Feedback."""
    assert 0x05 in abft['ev_ap'] and 0x05 in abft['ev_sta'], (abft['ev_ap'], abft['ev_sta'])
    kinds = {e.kind for e in abft['evs']}
    assert {'DMG Beacon', 'SSW', 'SSW-Feedback'} <= kinds, kinds
    assert abft['sched'].bti, 'нет BTI'


def test_abft_fields(abft):
    """Поля DMG Beacon (рис. 9-76, BIC рис. 9-77, DMG Parameters 9.4.1.46, порядок элементов табл. 9-45), SSW,
    SSW-Feedback (9.3.1.15/16, 9.5.1, 9.5.3, 9.5.4) — бит-в-бит."""
    r = abft
    _no(r, r['RB'].judge_fields(r['evs'], AP_S, r['sched']))


def test_abft_bti(abft):
    """BTI (ref/bi): цепочка маяков через SBIFS, CDOWN −1, сектор один раз, Duration = остаток BTI (9.3.4.2), покрытие
    секторов за dot11MaxLostBeacons BI (11.1.2.1); вне A-BFT нарушений периодов нет."""
    r = abft
    f = r['RB'].judge_bi(r['evs'], AP_S, r['sched'])
    _no(r, [x for x in f if not x.rule.startswith('abft_')])


def test_abft_beacon_duration(abft):
    """Duration каждого DMG Beacon BTI — остаток BTI (9.3.4.2, ref/duration)."""
    r = abft
    f = r['RB'].judge_duration(r['evs'], AP_S, r['sched'], r['lim'])
    _no(r, [x for x in f if x.rule == 'DMG Beacon'])


def test_abft_feedback(abft):
    """A-BFT (ref/abft, ref/bi): только SSW станции и SSW-Feedback точки, Direction 1, SBIFS между SSW, не больше FSS,
    SSW-Feedback в момент «aSSFBDuration + MBIFS до конца слота» с Duration 0, Sector Select — из принятых SSW."""
    r = abft
    f = r['RB'].judge_abft(r['evs'], AP_S, r['sched']) + r['RB'].judge_bi(r['evs'], AP_S, r['sched'])
    _no(r, [x for x in f if x.rule not in ('ssw_dur', 'ssw_start', 'abft_slot_start', 'abft_ss_end')])


@pytest.mark.xfail(strict=True, reason='10.42.5.2 рис. 10-76: первая SSW станции в слоте 0 A-BFT на 0,31 мкс позже '
                                       'начала слота (конец BTI + MBIFS), допуск — aAirPropagationTime 0,1 мкс '
                                       '(PLAN.md №4); последняя SSW пачки — за aSSDuration. СПОРНО: допуск MBIFS '
                                       '+10 % (10.3.2.3.10, 0,49 мкс) модель к началу A-BFT не применяет')
def test_abft_slot_start(abft):
    r = abft
    f = r['RB'].judge_abft(r['evs'], AP_S, r['sched']) + r['RB'].judge_bi(r['evs'], AP_S, r['sched'])
    _no(r, _by(f, 'ssw_start', 'abft_slot_start', 'abft_ss_end'))


@pytest.mark.xfail(strict=True, reason='9.3.1.15: Duration SSW станции в A-BFT на 1 мкс больше ⌈времени до конца '
                                       'слота⌉ у части кадров (259 → 260, последняя 37 вместо 36): uc считает от '
                                       'номинального начала слота, а пачка в эмуляции идёт на ~0,31–0,35 мкс позже '
                                       '(то же, что test_abft_slot_start; стенд std4/5: −0,03…+0,04)')
def test_abft_ssw_duration(abft):
    r = abft
    _no(r, _by(r['RB'].judge_duration(r['evs'], AP_S, r['sched'], r['lim']), 'SSW'))


# =====================================================================================================================
# сценарий live: SLS в DTI, ассоциация, BA, данные
# =====================================================================================================================
def test_live_scenario(live):
    """Станция подключилась (WMI_CONNECT_EVENT), соглашение BA есть, в журнале — все фазы обмена."""
    assert live['connected'] and live['ba'], (live['connected'], live['ba'])
    kinds = {e.kind for e in live['evs']}
    want = {'DMG Beacon', 'SSW', 'SSW-Feedback', 'SSW-Ack', 'Association Request', 'Association Response', 'BRP',
            'RTS', 'DMG CTS', 'A-MPDU', 'BlockAck', 'CF-End', 'Ack'}
    assert want <= kinds, want - kinds
    assert live['lim'] == 2048, live['lim']               # EDCA Parameter Set AC_BE: 0x40 × 32 мкс (9.4.2.28)


def test_live_fields(live):
    """Frame Control каждого кадра (9.2.4.1), кадры Control Frame Extension и DMG Beacon бит-в-бит (ref/fields),
    длины Ack/RTS/CF-End/BlockAck (рис. 9.3.1), BlockAck — Compressed (табл. 9-28)."""
    r = live
    _no(r, r['RB'].judge_fields(r['evs'], AP_S, r['sched']))


def test_live_elements(live):
    """Тела Association Request/Response: порядок элементов (табл. 9-34/9-35), DMG Capabilities/Operation
    обязательны, Supported Rates у DMG нет, Capability Information DMG, AID 1…254 (ref/elements.check_body)."""
    r = live
    assert any(e.kind in r['RB'].BODY_FRAMES for e in r['evs'])
    _no(r, r['RB'].judge_elements(r['evs'], AP_S))


def test_live_addba(live):
    """ADDBA Request/Response (табл. 9-360/9-361, 9.6.4.2/9.6.4.3, 10.25.2) — ref/blockack."""
    r = live
    _no(r, r['RB'].judge_addba(r['evs'], AP_S))


def test_live_bi(live):
    """Журнал целиком — инварианты BI (ref/bi): BTI, периоды (CBAP Only после guard 10.39.6.3), передачи только в
    периодах доступа."""
    r = live
    _no(r, r['RB'].judge_bi(r['evs'], AP_S, r['sched']))


SLS_TIMING = ('≠ MBIFS',)
SLS_DUR = ('(9.3.1.15)',)


def _sls(r):
    return r['RB'].judge_sls(r['evs'], AP_S, r['sched'])


def test_live_sls(live):
    """SLS в DTI (ref/sls): фазы ISS → RSS → SSW-Feedback → SSW-Ack, Direction, CDOWN, SBIFS в развёртке, Total
    Sectors in ISS, Sector Select из кадров развёртки, Duration SSW-Feedback/SSW-Ack; моменты MBIFS и Duration SSW —
    отдельные xfail ниже."""
    r = live
    f = _sls(r)
    assert len(r['RB'].sls_runs(r['evs'], r['sched'])) >= 2
    _no(r, [x for x in f if not any(s in x.msg for s in SLS_TIMING + SLS_DUR)])


def test_live_sls_mbifs(live):
    """10.42.2.2, 10.42.6.2, 10.3.2.3.10: RSS, SSW-Feedback и SSW-Ack в DTI — через MBIFS (9 мкс, −0/+0,49) после
    предыдущей фазы. Старт прямой передачи от конца приёма — IFS(0x886d00) + H-ORIGIN-RX (machw, стенд E1: 9,05 мкс);
    прежде модель прибавляла 0,55 мкс H-ORIGIN (замер от события GP сетки A-BFT) и давала 9,55–9,57 мкс."""
    r = live
    _no(r, [x for x in _sls(r) if any(s in x.msg for s in SLS_TIMING)])


def test_live_ssw_duration(live):
    """9.3.1.15: Duration SSW в DTI (ISS станции и точки, RSS) — ⌈CDOWN·(TXTIME(SSW) + SBIFS) + MBIFS⌉, у CDOWN 0 —
    MBIFS 9 (стенд dur3: 25/9 у CDOWN 1/0)."""
    r = live
    _no(r, _by(r['RB'].judge_duration(r['evs'], AP_S, r['sched'], r['lim']), 'SSW'))


def _dur(r):
    return r['RB'].judge_duration(r['evs'], AP_S, r['sched'], r['lim'])


def test_live_duration(live):
    """Duration кадров, которые собирает прошивка или MAC по её настройке: DMG Beacon (остаток BTI), SSW-Feedback и
    SSW-Ack в DTI (9.3.1.16/17), Assoc Request/Response, Action, RTS, A-MPDU в TXOP с лимитом 2048 мкс (9.2.5.2 b)."""
    r = live
    _no(r, [x for x in _dur(r) if x.rule not in ('SSW', 'CF-End', 'Ack', 'BlockAck', 'DMG CTS')])


def test_live_cf_end_duration(live):
    r = live
    _no(r, _by(_dur(r), 'CF-End'))


@pytest.mark.xfail(strict=True, reason='эмулятор: Duration ответов собирает модель MAC (air.py) — Ack 0 вместо '
                                       'Duration вызвавшего кадра − SIFS − TXTIME(Ack) (9.2.5.7); DMG CTS и BlockAck '
                                       'на 1 мкс меньше (TXTIME округляется вверх до вычитания, 9.2.5.1 — округлять '
                                       'результат). Не о прошивке: значение железа не снято')
def test_live_response_duration_emulator(live):
    r = live
    _no(r, [x for x in _dur(r) if x.rule in ('Ack', 'BlockAck', 'DMG CTS')])


MGMT_KINDS = ('Association Request', 'Association Response', 'Reassociation Request', 'Reassociation Response',
              'Probe Request', 'Probe Response', 'Disassociation', 'Action')


def _cf_end_after_mgmt(r, found):
    """Нарушения CF-End держателя, закрывающего TXOP после Ack на свой кадр управления (очередь 0x1a): uc не продолжает
    TXOP на пустой очереди управления (иначе MAC выпускает QoS Null класса 3, H-QNULL) и шлёт CF-End через
    tx_cca_check_and_send — после ожидания слота, ~16 мкс от конца Ack, а не через SIFS."""
    evs = r['evs']
    return [f for f in found if f.rule in ('aifs', 'cf_end', 'cf_end_dur') and evs[f.idx].kind == 'CF-End' and
            f.idx >= 2 and evs[f.idx - 1].kind == 'Ack' and evs[f.idx - 2].kind in MGMT_KINDS]


def test_live_cbap_access(live):
    """Доступ в CBAP (ref/cbap): NAV, AIFS, TXNAV, лимит TXOP (2048 мкс из EDCA Parameter Set), конец CBAP, CF-End
    только держателем TXOP. Допуски SIFS и границы слота широкие (7 и 5 мкс): срок SIFS — test_live_cbap_sifs,
    отсчёт слотов backoff — модель MAC эмулятора (H-BACKOFF), не прошивка. CF-End после кадра управления — отдельно
    (test_live_cf_end_after_mgmt_sifs)."""
    r = live
    found = r['RB'].judge_cbap(r['evs'], AP_S, r['sched'], r['lim'], sifs_tol=7, slot_tol=5)
    skip = _cf_end_after_mgmt(r, found)
    _no(r, [f for f in found if f not in skip])


@pytest.mark.xfail(strict=True, reason='10.23.2.8 / 10.23.2.10: CF-End держателя после Ack на его последний кадр '
                                       'управления — через ожидание слота tx_cca_check_and_send (~16 мкс), а не SIFS: '
                                       'TXOP на пустой очереди управления не продолжается (без QoS Null MAC класса 3, '
                                       'MAC-STAND H-QNULL), а закрытие TXOP идёт путём доступа к среде')
def test_live_cf_end_after_mgmt_sifs(live):
    r = live
    _no(r, _cf_end_after_mgmt(r, r['RB'].judge_cbap(r['evs'], AP_S, r['sched'], r['lim'], sifs_tol=7, slot_tol=5)))


@pytest.mark.xfail(strict=True, reason='10.3.2.3.3: ответы через SIFS в эмуляции позже SIFS + 0,49 мкс — Ack 5,5, '
                                       'DMG CTS 5,7, BlockAck 5,4, ответный CF-End 6,4, A-MPDU после DMG CTS 7,9 мкс '
                                       '(тот же срок, что xfail test_air.test_live_data_sifs; на железе без сниффера не '
                                       'измерен)')
def test_live_cbap_sifs(live):
    r = live
    _no(r, r['RB'].judge_cbap(r['evs'], AP_S, r['sched'], r['lim'], slot_tol=5))
