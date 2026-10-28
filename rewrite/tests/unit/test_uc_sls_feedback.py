# SPDX-License-Identifier: AGPL-3.0-or-later
"""Обратная связь SLS против 802.11-2020: SSW-Feedback (9.3.1.16) и SSW-Ack (9.3.1.17) с полями SSW Feedback (9.5.3,
рис. 9-849), BRP Request (9.5.4), Beamformed Link Maintenance (9.5.6); SSW-Feedback AP в A-BFT (10.42.5.2); разбор
принятых SSW (9.5.1) и выбор лучшего сектора — цепочкой «измерение PHY → rx_funcs_handle_ppdu_report →
txss_rank_best_sector → кадр обратной связи» (10.42.2.2–10.42.2.5).

Кадр — из FIFO direct-TX (FC, Duration, RA и хвост с поля SSW Feedback; TA вставляет MAC), Duration — команда 0x15
(«буквально», abft.h H-LIT), длина MPDU без FCS — команда 0x34; раскладка — test_uc_sls_sweep."""
import pytest

from test_uc_sls_sweep import (A, STA_TAB, STA_SZ, SLS, PEER, SPARRAW_MAX_STA, SPARRAW_PEER_UNKNOWN, MBIFS, SBIFS,
                               T_SSW, T_SSW_FB, T_SSW_ACK, TC_US, bits, ceil_us, cmds, fb_sel, fc, mac_ready, one_rf_set,
                               snr_report_db, ssw_field, tx_frames, set_best, setup_sweep, sweep)

RX_BUF = 0x804010                           # принятый кадр: FC +0, Duration +2, RA +4, TA +0xa, SSW +0x10, SSW-FB +0x13
SLS_PEER_MAC = SLS + 0x5c
SLS_MAINT = SLS + 0x68
SLS_RANK_VALID = SLS + 0x66
SLS_RX = A['sls_rx']                       # +0 flags: б0 кадр развёртки, б1 последний (CDOWN 0)
SLS_MEAS = A['sls_meas']
FWSH_SLS_RANK = 0x857c1c                   # fwsh_sls_rank[sta] — 5 × sector_rec (12 Б), лучший первым
TXRX_STATE1, TXRX_STATE2 = A['txrx_state1'], A['txrx_state2']
HW_PHY_RX_SIGNAL_GAIN_ADC_DB, HW_PHY_RX_SNR_883AEC = 0x883830, 0x883aec
SCRATCH = 0x803000                         # struct sls_peer_rec для direct_tx_step (свободная DCCM)

TX_STUBS = {n: 0 for n in ('mac_evt_enable_bit_sync_b', 'mac_set_rf_chain_state_with_sta_sector', 'uc_spin_until_event',
                           'mac_program_rx_window')}
RX_STUBS = {'uc_wait_event_busy': 0, 'rx_end_switch_to_tx': 0, 'rx_funcs_record_level_8020f8_8020fc': 0,
            'sta_set_tx_sector': 0, 'sta_tbl_find_by_mac': 0, 'ucode_pm_set_busy_flag': 0}


def brp_request(b):
    """Рис. 9-850."""
    v = int.from_bytes(b, 'little')
    return dict(l_rx=bits(v, 0, 5), tx_trn_req=bits(v, 5, 1), mid_req=bits(v, 6, 1), bc_req=bits(v, 7, 1),
                mid_grant=bits(v, 8, 1), bc_grant=bits(v, 9, 1), chan_fbck_cap=bits(v, 10, 1),
                tx_sector_id=bits(v, 11, 6), other_aid=bits(v, 17, 8), tx_antenna_id=bits(v, 25, 2), res=bits(v, 27, 5))


def decode_fb_frame(f):
    """SSW-Feedback / SSW-Ack (рис. 9-55 / 9-56) без TA: FC, Duration, RA, SSW Feedback, BRP Request, BF Link Maint."""
    b = f['fifo']
    assert len(b) == 18, b.hex()
    return dict(len=f['len'], fc=fc(int.from_bytes(b[0:2], 'little')), ra=b[4:10], fb=fb_sel(b[10:13]),
                brp=brp_request(b[13:17]), bflm=b[17])


def sta_mac(i):
    return bytes([0x24, 0x18, 0x1d, 0x24, 0x3b, i])


def init_world(uc):
    mac_ready(uc)
    uc.w8(SLS_MAINT, 0)
    for i in range(SPARRAW_MAX_STA + 1):              # SPARRAW_STA_SLOTS записей
        uc.wbytes(STA_TAB + STA_SZ * i + 0x30, sta_mac(i))


# ---------------------------------------------------------------- SSW-Feedback инициатора (DTI)

def send_feedback(uc, sta):
    uc.call('txss_init_send_ssw_fdbk', 1, sta, 0, stub=TX_STUBS)
    fr = tx_frames(uc)
    assert len(fr) == 1
    return decode_fb_frame(fr[0]), cmds(uc, 0x15)


@pytest.mark.parametrize('sta', [0, SPARRAW_MAX_STA - 1])
@pytest.mark.parametrize('maint', [False, True])
def test_ssw_feedback_frame(uc, sta, maint):
    """9.3.1.16: Control Frame Extension 1001 (Table 9-2), длина без FCS 24 (рис. 9-55), RA — ответчик; SSW Feedback
    рис. 9-849 — лучший сектор RSS; Poll Required и резерв 0. BRP Request: L-RX 16 — запрос BRP-RX (9.5.4, 0..16),
    остальное 0. Duration в DTI (9.3.1.16 a/b): TXTIME(SSW-Ack) + MBIFS, при запросе BRP — + 2×MBIFS, мкс вверх."""
    init_world(uc)
    uc.w8(SLS_MAINT, (1 << sta) if maint else 0)
    set_best(uc, 37, 1, 30)
    f, dur = send_feedback(uc, sta)
    assert f['len'] == 24
    assert f['fc'] == dict(type=1, subtype=6, ext=9)
    assert f['ra'] == sta_mac(sta)
    assert (f['fb']['sector'], f['fb']['antenna'], f['fb']['poll'], f['fb']['res']) == (37, 1, 0, 0)
    assert snr_report_db(f['fb']['snr_q']) == 30
    assert f['brp'] == dict(l_rx=16 if maint else 0, tx_trn_req=0, mid_req=0, bc_req=0, mid_grant=0, bc_grant=0,
                            chan_fbck_cap=0, tx_sector_id=0, other_aid=0, tx_antenna_id=0, res=0)
    assert f['bflm'] == 0
    want = ceil_us(T_SSW_ACK + (2 if maint else 1) * MBIFS)
    assert dur == [want]


@pytest.mark.parametrize('sector,antenna', [(0, 0), (63, 3), (32, 2)])
def test_ssw_feedback_sector_select_range(uc, sector, antenna):
    """9.5.3: Sector Select 0..63 (6 бит), DMG Antenna Select 2 бита — не задевают SNR Report."""
    init_world(uc)
    set_best(uc, sector, antenna, 19)
    f, _ = send_feedback(uc, 1)
    assert (f['fb']['sector'], f['fb']['antenna'], f['fb']['snr_q']) == (sector, antenna, 0)


# ---------------------------------------------------------------- SSW-Ack ответчика

def send_ack(uc, sta, flag, fb_duration=28):
    uc.w32(A['rxf'], sta)
    uc.w16(RX_BUF + 2, fb_duration)
    uc.call('sls_send_ssw_ack', sta, flag, stub=TX_STUBS)
    fr = tx_frames(uc)
    assert len(fr) == 1
    return decode_fb_frame(fr[0]), cmds(uc, 0x15)


@pytest.mark.parametrize('maint', [False, True])
def test_ssw_ack_frame(uc, maint):
    """9.3.1.17: Control Frame Extension 1010, длина без FCS 24 (рис. 9-56), RA — инициатор, SSW Feedback — лучший
    сектор ISS (рис. 9-849), MID-Grant/BC-Grant 0 (пир их не просил), BF Link Maintenance 0."""
    init_world(uc)
    sta = 3
    uc.w8(SLS_MAINT, (1 << sta) if maint else 0)
    set_best(uc, 12, 0, 22)
    f, _ = send_ack(uc, sta, 0)
    assert f['len'] == 24
    assert f['fc'] == dict(type=1, subtype=6, ext=10)
    assert f['ra'] == sta_mac(sta)
    assert (f['fb']['sector'], f['fb']['antenna'], f['fb']['poll'], f['fb']['res']) == (12, 0, 0, 0)
    assert snr_report_db(f['fb']['snr_q']) == 22
    assert f['brp']['l_rx'] == (16 if maint else 0)
    assert (f['brp']['mid_grant'], f['brp']['bc_grant'], f['brp']['mid_req'], f['brp']['bc_req'],
            f['brp']['tx_trn_req'], f['brp']['res']) == (0,) * 6
    assert f['bflm'] == 0


@pytest.mark.parametrize('fb_dur', [28, 37, 100, 32767])
def test_ssw_ack_duration(uc, fb_dur):
    """9.3.1.17: Duration = Duration принятого SSW-Feedback − MBIFS − TXTIME(SSW-Ack); 9.2.5.1 — мкс вверх."""
    init_world(uc)
    set_best(uc, 1, 0, 19)
    _, dur = send_ack(uc, 2, 0, fb_duration=fb_dur)
    assert dur == [ceil_us(fb_dur * TC_US - MBIFS - T_SSW_ACK)]


def test_ssw_ack_duration_never_negative(uc):
    """SSW-Feedback с Duration меньше MBIFS + TXTIME(SSW-Ack) (чужой/A-BFT, 0): Duration SSW-Ack не уходит в
    отрицательные (переполнение поля) — 0."""
    init_world(uc)
    set_best(uc, 1, 0, 19)
    _, dur = send_ack(uc, 2, 0, fb_duration=0)
    assert dur == [0]


def test_feedback_and_ack_to_unknown_peer(uc):
    """Пир без записи (SPARRAW_PEER_UNKNOWN, ответчик/инициатор до ассоциации): RA — запись SPARRAW_PEER_UNKNOWN
    таблицы станций (SPARRAW_STA_SLOTS записей), BRP не запрашивается (станция не «на поддержании»)."""
    init_world(uc)
    uc.w8(SLS_MAINT, 0xff)
    set_best(uc, 8, 0, 19)
    for f, _ in (send_feedback(uc, SPARRAW_PEER_UNKNOWN), send_ack(uc, SPARRAW_PEER_UNKNOWN, 0)):
        assert f['ra'] == sta_mac(SPARRAW_PEER_UNKNOWN)
        assert f['fb']['sector'] == 8
        assert f['brp']['l_rx'] == 0


@pytest.mark.parametrize('kind', ['ssw_feedback', 'ssw_ack'])
@pytest.mark.parametrize('snr_db', [63, -20])
def test_feedback_snr_report_saturates(uc, kind, snr_db):
    """9.5.3: «encoded as 8-bit 2s complement value of 4×(SNR−19) … covers from –13 dB to 50.75 dB» — вне диапазона
    ближайшее представимое значение, а не перенос по модулю 256 (SNR 63 дБ → «−4 дБ», −20 дБ → «44 дБ»)."""
    init_world(uc)
    set_best(uc, 8, 0, snr_db)
    f, _ = send_feedback(uc, 1) if kind == 'ssw_feedback' else send_ack(uc, 1, 0)
    assert snr_report_db(f['fb']['snr_q']) == (50.75 if snr_db > 50 else -13)


# ---------------------------------------------------------------- SSW-Feedback AP в A-BFT

def test_abft_ssw_feedback_frame(uc):
    """10.42.5.2 / 9.3.1.16: SSW-Feedback в A-BFT — Duration = 0; RA — ответчик (TA его SSW); Sector Select /
    DMG Antenna Select — лучший SSW ответчика в слоте (Sector ID / DMG Antenna ID его поля SSW); BRP в A-BFT не
    выполняется — BRP Request без запросов (L-RX 0, TX-TRN-REQ 0, MID/BC 0); BF Link Maintenance 0."""
    init_world(uc)
    rec = SCRATCH
    uc.wbytes(rec, bytes(0x18))
    uc.w32(rec + 0x04, 40)                         # rx_metric (SNR Report — сырой отсчёт, единицы не установлены)
    uc.w8(rec + 0x08, 2)                           # rx_antenna
    uc.w8(rec + 0x09, 61)                          # rx_sector
    uc.w8(rec + 0x0b, 5)                           # fb_sector — сектор окна приёма
    uc.wbytes(rec + 0x12, PEER)
    uc.call('direct_tx_step', rec, stub=TX_STUBS)
    fr = tx_frames(uc)
    assert len(fr) == 1
    f = decode_fb_frame(fr[0])
    assert f['len'] == 24
    assert f['fc'] == dict(type=1, subtype=6, ext=9)
    assert f['ra'] == PEER
    assert (f['fb']['sector'], f['fb']['antenna'], f['fb']['poll'], f['fb']['res']) == (61, 2, 0, 0)
    assert (f['brp']['l_rx'], f['brp']['tx_trn_req'], f['brp']['mid_req'], f['brp']['bc_req']) == (0, 0, 0, 0)
    assert f['bflm'] == 0
    assert cmds(uc, 0x15) == [0]


# ---------------------------------------------------------------- приём развёртки → лучший сектор → обратная связь

def ssw_bytes(direction, cdown, sector, antenna=0, rxss_len=0):
    v = direction | cdown << 1 | sector << 10 | antenna << 16 | rxss_len << 18
    return v.to_bytes(3, 'little')


def receive_sweep(uc, sta, frames, initiator):
    """frames: [(sector, antenna, adc_db, snr_db, fb_sector, fb_antenna)] в порядке приёма, CDOWN n−1 … 0.
    Инициатор принимает RSS (txrx_state1 б5, Direction 1), ответчик — ISS (б6, Direction 0); фаза — 0x200000.
    На кадр: измерение PHY (rx_flow_measure_snr_select_best: усиление ADC → snr_lin, 883aec → SNR дБ), разбор
    (rx_funcs_handle_ppdu_report), по флагу кадра — txss_rank_best_sector (как txss_init_wait_rss /
    txss_resp_wait_iss_end). Возврат — вызовы sta_set_tx_sector (сектор, выбранный пиром для нас)."""
    uc.call('g_80212c_reset')
    uc.wbytes(SLS_PEER_MAC, PEER)
    uc.w8(A['bf_ctrl'], 8)                        # bf_ctrl.snr_samples
    uc.w32(TXRX_STATE1, 0x20 if initiator else 0x40)
    uc.w32(SLS_RX, 0)
    uc.w8(A['rx_buf_toggle_dis'], 0)
    applied = []
    n = len(frames)
    for k, (sec, ant, adc, snr, fbs, fba) in enumerate(frames):
        cd = n - 1 - k
        uc.w32(TXRX_STATE2, 0x200000)
        uc.wbytes(RX_BUF + 0x0a, PEER)
        uc.wbytes(RX_BUF + 0x10, ssw_bytes(1 if initiator else 0, cd, sec, ant, rxss_len=0x3f))
        uc.wbytes(RX_BUF + 0x13, bytes([fbs | fba << 6, 0, 0]))
        uc.w32(HW_PHY_RX_SIGNAL_GAIN_ADC_DB, adc)
        uc.w32(HW_PHY_RX_SNR_883AEC, ((4 * snr) & 0x1ff) << 9)
        uc.ext.update({42: 0, 49: 0, 36: 1 << 6, 37: 1 << 24, 38: (1 << 11) | (sta << 8),
                       39: (1 << 15) if cd == 0 else 0})
        uc.call('rx_flow_measure_snr_select_best')
        uc.calls.clear()
        uc.call('rx_funcs_handle_ppdu_report', stub=RX_STUBS)
        applied += [c[1][:3] for c in uc.calls if c[0] == 'sta_set_tx_sector']
        fl = uc.r32(SLS_RX)
        if fl & 1:
            uc.w32(SLS_RX, fl & ~1)
            uc.call('txss_rank_best_sector')
    mac_ready(uc)
    return applied


def best_of(frames):
    return max(frames, key=lambda f: f[2])


SWEEPS = {
    'best_middle': [(s, 0, a, d, 9, 1) for s, a, d in [(10, 20, 5), (11, 40, 30), (12, 30, 21), (13, 10, 2)]],
    'best_last': [(s, 0, 10 + s, s, 9, 1) for s in range(16)],
    'best_first_64': [(63 - s, 0, 62 - s // 2 if s else 63, 40 - s // 2, 9, 1) for s in range(64)],
    'one_frame': [(42, 0, 20, 25, 9, 1)],
}


@pytest.mark.parametrize('name', list(SWEEPS))
def test_initiator_rss_to_ssw_feedback(uc, name):
    """10.42.2.2/9.5.3: SSW-Feedback инициатора после RSS — Sector Select / DMG Antenna Select = Sector ID / DMG
    Antenna ID кадра RSS с лучшим качеством (здесь — наибольшее усиление-отсчёт PHY, «implementation dependent»),
    SNR Report — SNR этого же кадра. CDOWN, RXSS Length принятого кадра в сектор не попадают. Сектор, выбранный
    ответчиком для нашей передачи (Sector Select его кадров), применяется к станции."""
    init_world(uc)
    sta = 2
    frames = SWEEPS[name]
    applied = receive_sweep(uc, sta, frames, initiator=True)
    assert applied and all(a == (sta, 9, 1) for a in applied)
    sec, ant, _, snr, _, _ = best_of(frames)
    f, _ = send_feedback(uc, sta)
    assert (f['fb']['sector'], f['fb']['antenna']) == (sec, ant)
    assert snr_report_db(f['fb']['snr_q']) == snr


@pytest.mark.parametrize('name', ['best_middle', 'best_last', 'best_first_64'])
def test_responder_iss_to_rss_and_ssw_ack(uc, name):
    """10.42.2.3/10.42.2.5: ответчик после ISS — в каждом SSW RSS и затем в SSW-Ack Sector Select = лучший кадр ISS
    (рис. 9-849), SNR Report — его SNR. SSW-Ack — и из рейтинга, сохранённого после SLS (txss_store_sector_ranking →
    sls_send_ssw_ack(…, 1), повторный SSW-Feedback инициатора)."""
    init_world(uc)
    sta = 1
    frames = SWEEPS[name]
    receive_sweep(uc, sta, frames, initiator=False)
    sec, ant, _, snr, _, _ = best_of(frames)
    setup_sweep(uc, sta, [0, 1, 2], mac=sta_mac(sta))
    one_rf_set(uc)
    fr, ssw, _ = sweep(uc, sta, responder=True)
    for x in fr:
        fb = fb_sel(x['fifo'][10:13])
        assert (fb['sector'], fb['antenna'], snr_report_db(fb['snr_q'])) == (sec, ant, snr)
    a, _ = send_ack(uc, sta, 0)
    assert (a['fb']['sector'], a['fb']['antenna'], snr_report_db(a['fb']['snr_q'])) == (sec, ant, snr)
    uc.call('txss_store_sector_ranking', sta, 0)
    assert uc.r8(SLS_RANK_VALID) & (1 << sta)
    a, _ = send_ack(uc, sta, 1)
    assert (a['fb']['sector'], a['fb']['antenna'], snr_report_db(a['fb']['snr_q'])) == (sec, ant, snr)


@pytest.mark.parametrize('initiator', [True, False], ids=['initiator', 'responder'])
def test_wrong_direction_frames_ignored(uc, initiator):
    """9.5.1 Direction: инициатор принимает в RSS только Direction = 1, ответчик в ISS — только 0; кадр с другим
    Direction (свой же поток/чужой SLS) не становится кандидатом в лучший сектор."""
    init_world(uc)
    good = [(20, 0, 30, 25, 9, 1)]
    receive_sweep(uc, 0, good, initiator=initiator)
    best_before = uc.rbytes(SLS, 12)
    # тот же пир, обратный Direction, заметно лучший сигнал
    uc.w32(TXRX_STATE2, 0x200000)
    uc.wbytes(RX_BUF + 0x10, ssw_bytes(0 if initiator else 1, 0, 50))
    uc.w32(HW_PHY_RX_SIGNAL_GAIN_ADC_DB, 60)
    uc.w32(HW_PHY_RX_SNR_883AEC, (4 * 45) << 9)
    uc.call('rx_flow_measure_snr_select_best')
    uc.call('rx_funcs_handle_ppdu_report', stub=RX_STUBS)
    assert not (uc.r32(SLS_RX) & 1)
    assert uc.rbytes(SLS, 12) == best_before
    assert uc.r8(SLS) == 20


@pytest.mark.parametrize('sector', [0, 1, 62, 63])
@pytest.mark.parametrize('cdown', [0, 1, 255, 511])
def test_ssw_field_parse(uc, sector, cdown):
    """9.5.1 рис. 9-846: Sector ID — б10..15, DMG Antenna ID — б16..17; соседние CDOWN (до 511), Direction, RXSS
    Length в сектор/антенну не попадают."""
    init_world(uc)
    receive_sweep(uc, 0, [], initiator=True)
    uc.w32(TXRX_STATE2, 0x200000)
    uc.wbytes(RX_BUF + 0x0a, PEER)
    uc.wbytes(RX_BUF + 0x10, ssw_bytes(1, cdown, sector, 3, rxss_len=0x3f))
    uc.w32(HW_PHY_RX_SIGNAL_GAIN_ADC_DB, 30)
    uc.w32(HW_PHY_RX_SNR_883AEC, (4 * 20) << 9)
    uc.ext.update({42: 0, 49: 0, 36: 1 << 6, 37: 1 << 24, 38: (1 << 11), 39: (1 << 15) if cdown == 0 else 0})
    uc.call('rx_flow_measure_snr_select_best')
    uc.call('rx_funcs_handle_ppdu_report', stub=RX_STUBS)
    assert uc.r32(SLS_RX) & 1
    assert (uc.r8(SLS_MEAS), uc.r8(SLS_MEAS + 1)) == (sector, 3)
    assert (uc.r8(SLS), uc.r8(SLS + 1)) == (sector, 3)


# ---------------------------------------------------------------- A-BFT: SSW станции-ответчика в своём слоте

BCN_RX = A['bcn_rx']                      # struct bcn_rx_s: +2 bi_ctrl[6], +0xc sector, +0xd antenna, +0x10 metric,
                                          # +0x14 bssid
AIRPROP = TC_US // 10                     # aAirPropagationTime 100 нс (Table 20-30)


def abft_respond(uc, fss_field, bcn_sector=17, bcn_antenna=1, rf_chain=0, abft_len_field=0):
    """abft_responder_fast(r, pre = 1, slot = 0): слот выбран (счётчик отсрочки 0), событие слота уже было; SSW-Feedback
    AP не пришёл, конец A-BFT (r54 б8) — после пачки."""
    init_world(uc)
    bic = (abft_len_field << 7) | (fss_field << 10)
    uc.wbytes(BCN_RX + 2, bic.to_bytes(2, 'little') + bytes(4))
    uc.w8(BCN_RX + 0xc, bcn_sector)
    uc.w8(BCN_RX + 0xd, bcn_antenna)
    uc.w32(BCN_RX + 0x10, 5)
    uc.wbytes(BCN_RX + 0x14, PEER)
    uc.w8(A['abft_gp0_armed'], 0)
    uc.w32(A['rf_chain_cfg'], rf_chain)
    uc.wbytes(SCRATCH, bytes(0x18))
    uc.ext[55] = 1                                # SIFS_CNT: событие слота только что (сторож не сработал)
    uc.ext[54] = lambda n, k: 0x180 if uc._ext_reads.get(43, 0) else 0
    stubs = dict(TX_STUBS, uc_spin_until_event4=0, uc_wait_event1_or_event4=0, abft_arm_response_window=0,
                 tx_ctx_alloc_next=0, tx_program_vector_rf=0, mac_evt_enable_bit_sync=0, l1_task_dispatch=0,
                 mac_switch_rx_to_tx=0, uc_evt_build_and_post_report=0)
    uc.call('abft_responder_fast', SCRATCH, 1, 0, stub=stubs)
    fr = tx_frames(uc)
    ssw = [ssw_field(c) for c in cmds(uc, 0x2d)]
    dur = cmds(uc, 0x15)
    assert len(fr) == len(ssw) == len(dur)
    return fr, ssw, dur


@pytest.mark.parametrize('fss_field', [4, 7, 15])
def test_abft_responder_ssw_burst(uc, fss_field):
    """10.42.5.2: ответчик в слоте передаёт не больше SSW, чем объявлено FSS (поле = число − 1, 9.3.4.2); RSS — TXSS
    ответчика (Direction 1), CDOWN до 0 в последнем кадре; Sector ID различны (0..63); RXSS Length вне CBAP —
    резерв 0. Кадр SSW (9.3.1.15): RA — BSSID AP (TA маяка), SSW Feedback (рис. 9-849) — лучший маяк BTI
    (Sector ID / DMG Antenna ID его поля SSW), Poll Required 0."""
    fr, ssw, _ = abft_respond(uc, fss_field)
    n = fss_field + 1
    assert len(ssw) == n
    assert [s['cdown'] for s in ssw] == list(range(n - 1, -1, -1))
    assert all(s['direction'] == 1 and s['rxss_len'] == 0 for s in ssw)
    secs = [s['sector'] for s in ssw]
    assert len(set(secs)) == n and all(0 <= s <= 63 for s in secs)
    for f in fr:
        assert f['len'] == 22
        assert fc(int.from_bytes(f['fifo'][0:2], 'little')) == dict(type=1, subtype=6, ext=8)
        assert f['fifo'][4:10] == PEER
        fb = fb_sel(f['fifo'][10:13])
        assert (fb['sector'], fb['antenna'], fb['poll'], fb['res']) == (17, 1, 0, 0)


@pytest.mark.parametrize('fss_field', [4, 7, 15])
def test_abft_responder_ssw_duration(uc, fss_field):
    """9.3.1.15: Duration SSW в A-BFT — до конца текущего SSW-слота; слот (10.42.5.2) = aAirPropagationTime +
    aSSDuration + MBIFS + aSSFBDuration + MBIFS, aSSDuration = (FSS − 1)×SBIFS + FSS×TXTIME(SSW), aSSFBDuration =
    TXTIME(SSW-Feedback) (Table 11-22); SSW k кончается через k×(TXTIME + SBIFS) + TXTIME от начала слота;
    9.2.5.1 — мкс вверх."""
    _, _, dur = abft_respond(uc, fss_field)
    n = fss_field + 1
    slot = AIRPROP + (n - 1) * SBIFS + n * T_SSW + MBIFS + T_SSW_FB + MBIFS
    assert dur == [ceil_us(slot - (k * (T_SSW + SBIFS) + T_SSW)) for k in range(n)]


@pytest.mark.parametrize('rf_chain', [0, 1, 3])
def test_abft_responder_antenna_id(uc, rf_chain):
    """9.5.1: DMG Antenna ID — антенна передачи (RF-цепь), 2 бита; RXSS Length (б18..23) вне CBAP — резерв = 0."""
    _, ssw, _ = abft_respond(uc, 4, rf_chain=rf_chain)
    assert all(s['antenna'] == rf_chain & 3 and s['rxss_len'] == 0 for s in ssw)


@pytest.mark.parametrize('rf_chain', [4, 7])
def test_abft_responder_rxss_length_reserved(uc, rf_chain):
    """9.5.1: «The RXSS Length subfield is valid only when transmitted in a CBAP and is reserved otherwise»; 9.2.2:
    резерв — 0 при передаче. Номер RF-модуля (rf_obj.rf_idx → rf_chain_cfg, до 8 модулей) не должен выходить
    за 2 бита DMG Antenna ID."""
    _, ssw, _ = abft_respond(uc, 4, rf_chain=rf_chain)
    assert all(s['rxss_len'] == 0 for s in ssw)
