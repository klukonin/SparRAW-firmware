# SPDX-License-Identifier: AGPL-3.0-or-later
"""Модель MAC во времени (machw.py): сама модель на коротких путях uc — GP-таймеры, длительность кадра в эфире,
точка ответа (H-ORIGIN) и поздняя команда."""
import pytest

from machw import MACLAT_RX_CLK, HW, ModelGap, ctrl_txtime_clk, ifs_code, CLK_PER_US, MACLAT_CLK, TX_START_CLK, TX_END_LEAD_CLK, TX_EVT_AFTER_START_CLK, MODEL_TOL_CLK

pytestmark = pytest.mark.unit


def test_gp_timer_immediate_start_ends_after_its_value(uc):
    """gp_timer_arm(0, v) — пуск сразу (0x5200000b): r54.6 через v тактов."""
    hw = HW(uc)
    uc.call('gp_timer_arm', 0, 5000, 0, 0)
    t0 = hw.gp[0].start
    uc.call('uc_spin_until_event4', 0x40)
    assert hw.gp[0].arms == [(t0, 5000)]
    assert 5000 <= hw.now - t0 <= 5000 + 20


def test_ctrl_txtime_matches_standard():
    assert ctrl_txtime_clk(26) == 2460 and ctrl_txtime_clk(28) == 3012


def test_feedback_initiator_frame_on_air(uc):
    """SSW-Feedback инициатора в DTI (без приёма перед ним): кадр 28 Б в эфире TXTIME(28) = 3012 тактов, функция
    возвращается по tx_end."""
    from test_uc_ifs_mac import lmac_mac_cfg
    hw = HW(uc)
    lmac_mac_cfg(uc)
    uc.w32(0x8005f4, 0)
    uc.call('txss_init_send_ssw_fdbk', 1, 0, 0, stub={'mac_set_rf_chain_state_with_sta_sector': 0})
    tx = [a for a in hw.air_log if a[2] == 'tx']
    assert len(tx) == 1 and tx[0][1] - tx[0][0] == 3012, hw.log_air()
    assert hw.now >= tx[0][0] + TX_EVT_AFTER_START_CLK        # возврат по tx_end_event — кадр ещё в эфире (H-TXEVT)


# ---- сквозной сценарий: ответчик SLS в DTI, пир молчит после RSS ----------------------------------------------

def _sls_responder_setup(uc, n_sectors, peer_ant, sta=0):
    from test_uc_ifs_mac import lmac_mac_cfg
    from test_uc_ifs_duration import TXSS_SS, SS_SZ, STA_TAB, STA_SZ, BF_STA, MAC_MON_SLOT_IDX
    lmac_mac_cfg(uc)
    ss = TXSS_SS + SS_SZ * sta
    uc.w32(ss, 0)
    uc.w32(ss + 4, 0)
    for i in range(64):
        uc.w8(ss + 8 + i, (63 - i) if i < n_sectors else 0xff)
    uc.w8(ss + 0x48, n_sectors)
    uc.w8(ss + 0x49, 0)
    uc.w8(STA_TAB + STA_SZ * sta + 0x4c, peer_ant)
    uc.w32(BF_STA + 20 * sta, 0)
    uc.w32(0x8014c0, 0)
    uc.w8(MAC_MON_SLOT_IDX, 0)
    uc.w32(0x8005f4, 0)
    uc.w8(0x8021e0, 0)                                       # sls_rx.flags
    uc.call('txss_sweep_timing', 0x802e64 + 8 * sta, n_sectors, peer_ant)   # txss_timing[sta] — как LMAC 0x0c
    uc.w32(0x8020c4 + 4 * sta, 0x29528)                      # rss_wait_clk[sta] — после подключения (cmd.c)


@pytest.mark.parametrize('n,ant', [(16, 1), (64, 1), (64, 4)])
def test_sls_responder_waits_feedback_after_own_rss(uc, n, ant):
    """10.42.2.2 / 10.42.6.2: ответчик после своей RSS ждёт SSW-Feedback (через MBIFS) и все его повторы
    инициатором. Модель: последний SSW ISS пира в эфире → RSS (n секторов × ant антенн пира) → пир молчит.
    GP0 ожидания должен кончиться не раньше конца RSS + MBIFS + aRxPHYStartDelay (иначе Feedback не ждётся вовсе);
    прежний uc (до 2026-10-28) взводил его до RSS сроком одного окна — при 64 секторах истекал посреди развёртки."""
    hw = HW(uc, ifs=1485)                                   # 0x886d00 = MBIFS в SLS (txss_init_flow)
    _sls_responder_setup(uc, n, ant)
    uc.w32(0x886d00, 0x1730000 | ifs_code(1485))                       # 0x886d00 = MBIFS: автомат BF перед потоком SLS (bf.c)
    uc.w16(0x8005be, ifs_code(1485))                                   # mac_ifs_shadow — та же величина
    hw.air_rx(2000, 26, 'ISS пира CDOWN 0', txss_end=True)
    uc.call('txss_resp_flow', 0, stub={'mac_set_rf_chain_state_with_sta_sector': 0}, max_steps=50_000_000)
    rss = [a for a in hw.air_log if a[2] == 'tx' and a[3].startswith('sweep')]
    assert len(rss) == n * ant, hw.log_air()[:5]
    rss_end = rss[-1][1]
    gp0_end = hw.gp[0].arms[-1][0] + hw.gp[0].arms[-1][1]
    need = 1485 + 1650                                      # MBIFS + aRxPHYStartDelay (control)
    assert gp0_end >= rss_end + need, 'GP0 ожидания Feedback кончился через %.1f мкс после конца RSS (нужно ≥ %.1f)' % (
        (gp0_end - rss_end) / CLK_PER_US, need / CLK_PER_US)
    assert not hw.late, hw.late


# ---- ответ через SIFS на принятый кадр (Ack, BlockAck, DMG CTS) во времени модели --------------------------------

RESP_LEN = {'ack': 14, 'ba': 32, 'bar': 32, 'cts': 26}


@pytest.mark.parametrize('kind', ['ack', 'ba', 'bar', 'cts'])
def test_sifs_response_in_time(uc, kind):
    """Кадр пира (200 Б) с ответом через SIFS (10.3.2.3.3; Ack 10.3.2.11, BlockAck 10.25.6, DMG CTS 10.3.2.9): uc в
    rx_flow_run видит конец PPDU, ведёт путь ответа; команда ответа 0x37000020 не позже H-SIFSRESP от конца кадра
    (железо: assert 0x26 — стенд std9 2026-10-28 под нагрузкой). Задержка ответа в эфире — в выводе (сверка со
    стандартом без сниффера невозможна: точка отсчёта MAC не измерена)."""
    import test_uc_deadlines as d
    from test_uc_beacon_tx import clean_shadows
    uc.cpu.regs[25] = d.MAC_CMD_LOG
    clean_shadows(uc)
    d.sifs_frame(uc, kind)
    rep = {n: uc.ext.pop(n) for n in (36, 37, 38, 39)}
    for n in (42, 40, 43, 45, 47, 55):
        uc.ext.pop(n, None)
    hw = HW(uc)
    from machw import RESP_CMD_DEADLINE_CLK, RESP_CMD_DEADLINE_CTS_CLK
    dl = RESP_CMD_DEADLINE_CTS_CLK if kind == 'cts' else RESP_CMD_DEADLINE_CLK
    t0 = hw.now
    end = hw.air_rx(t0, 200, 'кадр пира (%s)' % kind, report=rep, sifs_resp=True, resp_len=RESP_LEN[kind], resp_deadline=dl)
    hw.advance_to_next()
    uc.call('rx_flow_run', stub={'uc_assert': 0}, max_steps=2_000_000)
    tx = [a for a in hw.air_log if a[2] == 'tx']
    cmd = [t for t, c in hw.cmd_log if c == 0x37000020]
    print('%s: 0x37000020 через %d тактов после конца кадра (срок %d); ответ в эфире через %.2f мкс' % (
        kind, cmd[0] - end, dl, (tx[0][0] - end) / CLK_PER_US if tx else -1))
    assert tx, 'нет ответа в эфире'
    assert not hw.late, hw.late
    assert not [c for c in uc.calls if c[0] == 'uc_assert'], uc.calls
    # H-RESPCMD / H-RESPCMD2: старт ответа — позднее из точки SIFS MAC (конец + 0x886d00 + MACLAT_RX) и «команда +
    # MACLAT» (захват PMC 2026-11-04: DMG CTS 4,93 мкс при команде ≈ 720 тактов; 2026-11-11: ~3,19 мкс при 2,70)
    assert tx[0][0] == max(end + 495 + MACLAT_RX_CLK, cmd[0] + MACLAT_CLK), (tx[0][0] - end, cmd[0] - end)


# ---- инициатор SLS: SSW-Feedback и его повторы при молчащем ответчике ---------------------------------------------

def test_sls_initiator_feedback_retries_on_air(uc):
    """10.42.6.2: SSW-Ack не принят — инициатор повторяет SSW-Feedback «PIFS following the expected end of the SSW-Ack»
    = MBIFS + TXTIME(SSW-Ack) + PIFS = 35,255 мкс после конца Feedback, до dot11BFRetryLimit раз (всего 9 попыток).
    Модель: ответчик молчит, выделение длинное (до TBTT далеко) — в эфире 9 Feedback с интервалом по стандарту."""
    from test_uc_ifs_mac import lmac_mac_cfg
    hw = HW(uc, ifs=1485)
    lmac_mac_cfg(uc)
    uc.w32(0x886d00, 0x1730000 | ifs_code(1485))
    uc.w16(0x8005be, ifs_code(1485))
    uc.w32(0x8005f4, 0)
    uc.w8(0x8021e0, 0)
    uc.call('txss_init_send_fdbk_wait_ack', 0, stub={'mac_set_rf_chain_state_with_sta_sector': 0,
                                                   'ese_dti_us_to_window_end': 0xffffffff}, max_steps=20_000_000)
    fb = [a for a in hw.air_log if a[2] == 'tx']
    gaps = [(b[0] - a[1]) / CLK_PER_US for a, b in zip(fb, fb[1:])]
    print('Feedback: %d, интервалы после конца, мкс: %s' % (len(fb), ['%.3f' % g for g in gaps]))
    assert len(fb) == 9, hw.log_air()
    std = (1485 + 3012 + 1320) / CLK_PER_US                 # 35,255; стенд 35,25–35,37
    tol = MODEL_TOL_CLK / CLK_PER_US
    assert all(std - tol <= g <= std + 0.5 for g in gaps), gaps
    assert not hw.late, hw.late


def _feedback_retries(uc, peer_hdr_at=None, probe=None):
    """Инициатор повторяет SSW-Feedback (ответчик молчит, как в test_sls_initiator_feedback_retries_on_air); чужой
    SSW в эфире с заголовком (rx_frame_event) в такт peer_hdr_at; probe — список: такты входов в mac_switch_rx_to_tx."""
    from test_uc_ifs_mac import lmac_mac_cfg
    from machw import HDR_CLK
    hw = HW(uc, ifs=1485)
    hw.collisions = []
    lmac_mac_cfg(uc)
    uc.w32(0x886d00, 0x1730000 | ifs_code(1485))
    uc.w16(0x8005be, ifs_code(1485))
    uc.w32(0x8005f4, 0)
    uc.w8(0x8021e0, 0)
    if probe is not None:
        cpu, step, entry = uc.cpu, uc.cpu.step, uc.sym['mac_switch_rx_to_tx'] & 0x1ffff

        def traced():
            if (cpu.pc & 0x1ffff) == entry:
                probe.append(hw.now)
            step()
        cpu.step = traced
    if peer_hdr_at is not None:
        hw.air_rx(peer_hdr_at - HDR_CLK, 26, 'чужой SSW CDOWN 5')
    uc.call('txss_init_send_fdbk_wait_ack', 0, stub={'mac_set_rf_chain_state_with_sta_sector': 0,
                                                   'ese_dti_us_to_window_end': 0xffffffff, 'uc_assert': 0},
            max_steps=20_000_000)
    return hw


UC_STATS_RX_TO_TX_REWAIT = 0x8022c8 + 0x24


def test_rx_to_tx_header_in_switch_window(build_dir, uc_fw):
    """H-PHYRX (стенд): phy_rx_frame и снятие cca_ppdu_comp — только с разбором заголовка, ≈ 9 мкс от начала кадра.
    Заголовок чужого кадра, разобранный между ожиданиями mac_switch_rx_to_tx и проверкой после них (окно ≈ 24 такта,
    повтор SSW-Feedback инициатора), у vendor — uc_assert 0x93/0x94 (эмулятор, 2026-10-30: заголовок через 44–64 такта
    после входа). Исправлено: переход заново — ожидания дожидаются конца кадра, как при заголовке на такт раньше; все
    9 Feedback уходят, assert нет, случай учтён в uc_stats.rx_to_tx_rewait."""
    import os
    import ucemu
    mk = lambda: ucemu.UC(os.path.join(build_dir, 'uc.elf'), uc_fw)
    entries = []
    _feedback_retries(mk(), probe=entries)
    t = entries[1]                                          # переход RX→TX первого повтора Feedback
    hit = 0
    for d in (44, 52, 60, 64):
        uc = mk()
        hw = _feedback_retries(uc, peer_hdr_at=t + d)
        asserts = [c[1][1] for c in uc.calls if c[0] == 'uc_assert']
        assert not asserts, 'заголовок через %d тактов после входа: uc_assert %s' % (d, [hex(a) for a in asserts])
        assert len([a for a in hw.air_log if a[2] == 'tx']) == 9, hw.log_air()
        hit += uc.r32(UC_STATS_RX_TO_TX_REWAIT)
    assert hit, 'ни один заголовок не попал в окно — окно сместилось, пересчитать задержки'


# 802.11-2020 Table 20-30: aSIFSTime 3 мкс, aSlotTime 5 мкс, aAirPropagationTime 0,1 мкс; MBIFS = 3·aSIFSTime
# (10.3.2.3.10); допуск IFS DMG — −0 / +10 %·(aSlotTime − aAirPropagationTime) = +0,49 мкс (10.3.2.3.3).
STD_MBIFS_CLK = 3 * 3 * CLK_PER_US
STD_IFS_TOL_CLK = int(0.1 * (5 - 0.1) * CLK_PER_US)            # 80 тактов (0,485 мкс), вниз


def test_rss_frames_sbifs_apart(uc):
    """10.3.2.3.8: SSW одной развёртки разделены SBIFS. Первый SSW RSS — через MBIFS после конца ISS (10.42.2.2) с
    допуском −0/+0,49 мкс без поправки модели: прямая передача от конца приёма — IFS + H-ORIGIN-RX (стенд E1: SSW-Ack
    через 9,05 мкс), а не + 0,55 мкс H-ORIGIN от события GP (прежде модель давала 9,55)."""
    from machw import MACLAT_RX_CLK
    hw = HW(uc, ifs=STD_MBIFS_CLK)
    _sls_responder_setup(uc, 16, 1)
    uc.w32(0x886d00, 0x1730000 | ifs_code(STD_MBIFS_CLK))
    uc.w16(0x8005be, ifs_code(STD_MBIFS_CLK))
    hw.air_rx(2000, 26, 'ISS пира CDOWN 0', txss_end=True)
    uc.call('txss_resp_flow', 0, stub={'mac_set_rf_chain_state_with_sta_sector': 0}, max_steps=50_000_000)
    rss = [a for a in hw.air_log if a[2] == 'tx']
    iss_end = [a for a in hw.air_log if a[2] == 'rx'][0][1]
    tol = MODEL_TOL_CLK
    assert rss[0][0] - iss_end == STD_MBIFS_CLK + MACLAT_RX_CLK
    assert STD_MBIFS_CLK <= rss[0][0] - iss_end <= STD_MBIFS_CLK + STD_IFS_TOL_CLK   # MBIFS −0/+0,49 мкс
    gaps = [b[0] - a[1] for a, b in zip(rss, rss[1:])]
    assert all(165 - tol <= g <= 165 + tol for g in gaps), ['%.2f мкс' % (g / CLK_PER_US) for g in gaps[:4]]


@pytest.mark.parametrize('n', [1, 16, 32])
def test_rss_ssw_duration_on_air(uc, n):
    """9.3.1.15: Duration SSW в эфире (вне A-BFT) — до конца SSW с CDOWN 0 плюс MBIFS, мкс вверх (9.2.5.1):
    ⌈CDOWN·(TXTIME(SSW) + SBIFS) + MBIFS⌉; у SSW с CDOWN 0 — MBIFS 9. Модель MAC (H-LITSSW) несёт 0x15 SSW как есть —
    стенд dur3: CDOWN 1/0 = 25/9."""
    hw = HW(uc, ifs=1485)
    _sls_responder_setup(uc, n, 1)
    uc.w32(0x886d00, 0x1730000 | ifs_code(1485))
    uc.w16(0x8005be, ifs_code(1485))
    seen = []
    hw.on_tx = lambda r: seen.append(r)
    hw.air_rx(2000, 26, 'ISS пира CDOWN 0', txss_end=True)
    uc.call('txss_resp_flow', 0, stub={'mac_set_rf_chain_state_with_sta_sector': 0}, max_steps=50_000_000)
    ssw = [r for r in seen if r['what'].startswith('sweep')]
    assert len(ssw) == n, [r['what'] for r in seen]
    step = ctrl_txtime_clk(26) + 165                         # TXTIME(SSW) + SBIFS, такты
    for r in ssw:
        cd = int(r['what'].split()[2])
        assert r['dur_us'] == -(-(cd * step + 1485) // CLK_PER_US), (r['what'], r['dur_us'])
    assert int(ssw[-1]['what'].split()[2]) == 0 and ssw[-1]['dur_us'] == 9


# ---- развёртка маяков BTI (AP) -----------------------------------------------------------------------------

def test_beacon_sweep_sbifs_on_air(uc):
    """10.3.2.3.8: маяки развёртки BTI разделены SBIFS (1 мкс). Шаблон маяка (34 Б) без FIFO, пуск каждого — по полю
    SSW (0x2d) и разрешению. Стенд E4: зазор 1,000 мкс — им же откалиброван H-TXEND."""
    import test_uc_beacon_tx as btx
    uc.cpu.regs[25] = 0x800000
    btx.lmac_0x0b(uc, n_frames=16, order=btx.perm(16), abft_len=1, fss=15, n_bi_abft=1)
    btx.program_bic(uc)
    hw = HW(uc)
    btx.zero(uc, btx.FWSH0, btx.FWSH1 - btx.FWSH0)
    uc.w8(btx.FWSH_N_SETS, 1)
    uc.w32(btx.FWSH_SET_RANGES, btx.RANGES)
    uc.wbytes(btx.RANGES, [0, 63])
    uc.w32(btx.FWSH_BCN_PSDU_LEN, 34)
    uc.w32(btx.HW_MAC_IFS_RIFS_SBIFS, 1 << 24)
    uc.w32(0x800714, 0)
    uc.w8(0x800431, 0)
    uc.w8(btx.MAINT_STA_MASK, 0)
    uc.w32(0x8005f4, 0)
    btx.clean_shadows(uc)
    btx.zero(uc, btx.BI_CTX, 0x40)
    for n in (42, 43, 47):
        uc.ext.pop(n, None)
    hw.sweep_len = 34
    uc.call('bti_ap_beacon_sweep_tx', btx.BI_CTX, stub={'tx_ctx_alloc_next': btx.TX_CTX}, max_steps=5_000_000)
    bc = [a for a in hw.air_log if a[2] == 'tx']
    assert len(bc) == 16, hw.log_air()
    gaps = [b[0] - a[1] for a, b in zip(bc, bc[1:])]
    print('зазоры маяков, такты:', gaps[:5])
    assert all(165 - MODEL_TOL_CLK <= g <= 165 + MODEL_TOL_CLK for g in gaps), gaps
    assert not [c for c in uc.calls if c[0] == 'uc_assert'], uc.calls


# ---- A-BFT точки: SSW станции в слоте 0 и SSW-Feedback точки --------------------------------------------------

def _ap_bti(uc, n_beacons=4, fss=15):
    """BTI точки: развёртка маяков (34 Б) и сетка A-BFT (GP0/GP2 по txop_event, GP1 по концу GP2)."""
    import test_uc_beacon_tx as btx
    from test_uc_ifs_mac import lmac_mac_cfg
    uc.cpu.regs[25] = 0x800000
    lmac_mac_cfg(uc)
    btx.lmac_0x0b(uc, n_frames=n_beacons, order=btx.perm(n_beacons), abft_len=1, fss=fss, n_bi_abft=1)
    btx.program_bic(uc)
    hw = HW(uc)
    btx.zero(uc, btx.FWSH0, btx.FWSH1 - btx.FWSH0)
    uc.w8(btx.FWSH_N_SETS, 1)
    uc.w32(btx.FWSH_SET_RANGES, btx.RANGES)
    uc.wbytes(btx.RANGES, [0, 63])
    uc.w32(btx.FWSH_BCN_PSDU_LEN, 34)
    uc.w32(btx.HW_MAC_IFS_RIFS_SBIFS, 1 << 24)
    uc.w32(0x800714, 0)
    uc.w8(0x800431, 0)
    uc.w8(btx.MAINT_STA_MASK, 0)
    uc.w32(0x8005f4, 0)
    btx.clean_shadows(uc)
    btx.zero(uc, btx.BI_CTX, 0x40)
    for n in (42, 43, 47):
        uc.ext.pop(n, None)
    hw.sweep_len = 34
    uc.call('bti_ap_beacon_sweep_tx', btx.BI_CTX, stub={'tx_ctx_alloc_next': btx.TX_CTX}, max_steps=5_000_000)
    return hw


def _station_ssw_in_slot(uc, hw, n_ssw, sta=3):
    """По первой границе слота (конец GP2) станция шлёт n_ssw SSW (26 Б) через aAirPropagationTime, с SBIFS."""
    from test_uc_beacon_rx import RX_BUF
    slot = {}
    orig = hw._gp_end

    def gpend(i):
        if i == 2 and 'start' not in slot:
            slot['start'] = hw.now
            t = hw.now + 17
            for k in range(n_ssw):
                cd = n_ssw - 1 - k

                def hdr(h, cd=cd, k=k):
                    ssw = bytearray(32)
                    ssw[0:2] = (0x0864).to_bytes(2, 'little')
                    ssw[10:16] = bytes.fromhex('24181d243b0b')
                    ssw[16:19] = (1 | (cd << 1) | (k << 10)).to_bytes(3, 'little')
                    ssw[19:22] = (5 | (20 << 8)).to_bytes(3, 'little')
                    uc.wbytes(RX_BUF, bytes(ssw))
                    uc.ext.update({36: 1 << 6, 37: 1 << 24, 38: 0x800 | (sta << 8), 39: (1 << 15) if cd == 0 else 0})
                hw.air_rx(t, 26, 'SSW станции CDOWN %d' % cd, on_hdr=hdr)
                t += ctrl_txtime_clk(26) + 165
        orig(i)
    hw._gp_end = gpend
    return slot


@pytest.mark.parametrize('fss', [3, 15])
def test_abft_ap_feedback_on_air(uc, fss):
    """10.42.5.2: в слоте A-BFT станция шлёт FSS SSW; точка отвечает SSW-Feedback через aAirPropagationTime +
    aSSDuration + MBIFS от начала слота, aSSDuration = (FSS − 1)·SBIFS + FSS·TXTIME(SSW). Сетка — GP2 по txop_event
    (H-GP3), GP1 по концу GP2 (H-GP9), Feedback — GP1 + MBIFS + задержка MAC (H-ORIGIN)."""
    hw = _ap_bti(uc, fss=fss)
    n = fss + 1
    slot = _station_ssw_in_slot(uc, hw, n)
    rec = 0x807e80
    for i in range(0, 0x18, 4):
        uc.w32(rec + i, 0)
    uc.call('abft_initiator_feedback_loop', rec, stub={'uc_evt_build_and_post_report': 0}, max_steps=5_000_000)
    fb = [a for a in hw.air_log if a[2] == 'tx' and a[3].startswith('direct')]
    assert len(fb) == 1, hw.log_air()[-4:]
    std = slot['start'] + 17 + (n - 1) * 165 + n * ctrl_txtime_clk(26) + 1485
    print('FSS %d: Feedback от стандартной точки %+d тактов' % (n, fb[0][0] - std))
    assert std - MODEL_TOL_CLK <= fb[0][0] <= std + 81 + MODEL_TOL_CLK      # MBIFS −0/+0,49 мкс
    assert not hw.late, hw.late
    assert not [c for c in uc.calls if c[0] == 'uc_assert'], uc.calls


# ---- A-BFT станции: пачка SSW в своём слоте ----------------------------------------------------------------------

def _sta_abft_burst(uc, fss):
    """Станция в слоте 0 A-BFT (маяк разобран, FSS из BIC): граница слота — конец GP1 через ~18 мкс после входа, GP2
    отсчитывает слот. Возвращает (такт границы слота, кадры SSW в эфире)."""
    import test_uc_deadlines as d
    from test_uc_beacon_tx import clean_shadows
    from test_uc_ifs_mac import lmac_mac_cfg
    uc.cpu.regs[25] = d.MAC_CMD_LOG
    lmac_mac_cfg(uc)
    clean_shadows(uc)
    hw = HW(uc)
    for i in range(0, 0x18, 4):
        uc.w32(d.REC + i, 0)
    uc.w8(d.REC + 0xd, 8)
    uc.w8(0x800439, 0)
    uc.w32(0x8005f4, 0)
    uc.wbytes(d.BCN_RX + 2, (fss << 10).to_bytes(6, 'little'))
    uc.wbytes(d.BCN_RX + 0x14, d.AP)
    for n in (42, 43, 45, 47, 54, 55):
        uc.ext.pop(n, None)
    uc.call('gp_timer_arm', 2, 200000, 0, 0)
    uc.call('gp_timer_arm', 1, 3000, 0, 0)
    g = hw.gp[1]
    g.trig = 9                                            # граница слота — событие GP с аппаратным пуском
    boundary = g.end
    uc.call('abft_responder_fast', d.REC, 1, 0,
            stub={'tx_ctx_alloc_next': 0x807f80, 'l1_task_dispatch': 0, 'abft_resp_parse_fdbk': 1,
                  'uc_evt_build_and_post_report': 0}, max_steps=3_000_000)
    assert not [c for c in uc.calls if c[0] == 'uc_assert'], uc.calls
    return hw, boundary, [a for a in hw.air_log if a[2] == 'tx']


@pytest.mark.parametrize('fss', [4, 15])
def test_abft_sta_burst_on_air(uc, fss):
    """Вся пачка FSS SSW уходит в эфир, без поздних команд; первый SSW — не позже стендовой границы 4,34 мкс после
    события слота (uc/ifs.h SIFS_CNT_ABFT_SSW_LATE: с 4,45 мкс AP теряет первый SSW)."""
    hw, b, tx = _sta_abft_burst(uc, fss)
    gaps = [q[0] - p[1] for p, q in zip(tx, tx[1:])]
    print('FSS %d: первый SSW через %.2f мкс после границы слота, зазоры %s тактов'
          % (fss + 1, (tx[0][0] - b) / CLK_PER_US, sorted(set(gaps))))
    assert len(tx) == fss + 1
    assert all(a[1] - a[0] == ctrl_txtime_clk(26) for a in tx)
    assert tx[0][0] - b <= 716
    assert not hw.late, hw.late


@pytest.mark.parametrize('fss', [4, 15])
def test_abft_sta_burst_sbifs_apart(uc, fss):
    """10.3.2.3.8, 10.42.5.2: SSW станции в слоте — через SBIFS (допуск модели). Стенд: период 0x19 соседних SSW =
    TXTIME + SBIFS (IFS-MEASURED), SBIFS в пачке 1,01 мкс; модель — H-TXEVT (tx_end_event у начала кадра, следующий
    кадр готовится во время текущего), «передатчик свободен» за 135 тактов до конца (метки маяков, H-TXEND), limm 0."""
    hw, b, tx = _sta_abft_burst(uc, fss)
    sb = hw.sbifs_clk()
    gaps = [q[0] - p[1] for p, q in zip(tx, tx[1:])]
    assert all(sb <= g <= sb + MODEL_TOL_CLK for g in gaps), gaps


def test_dur18_fifo_frame_duration(uc):
    """H-DUR18 (стенд 2026-11-04, PMC обоих узлов): кадр FIFO после 0x15 + 0x14000007, пущенный 0x18 без б12, несёт в
    эфире 0x15 − ⌈TXTIME своего PPDU⌉ (CF-End держателя: 34 → 19, 18 → 3; ATIM 38 → 19); пущенный 0x18001000 (SLS в
    DTI: SSW-Feedback 37, SSW-Ack 10) — 0x15 буквально; без 0x18 (ответ uc через SIFS) — буквально (не снято)."""
    hw = HW(uc)
    cf_end = dict(what='direct 20 B', dur=ctrl_txtime_clk(20), fifo=b'\xe4\x00' + bytes(8), start=hw.now)
    atim = dict(what='direct 28 B', dur=ctrl_txtime_clk(28), fifo=b'\x90\x00' + bytes(10), start=hw.now)
    for frame, d15, go, want in ((cf_end, 34, 0x18000000, 19), (cf_end, 18, 0x18000000, 3), (cf_end, 33, 0x18000000, 18),
                                 (atim, 38, 0x18000000, 19), (cf_end, 37, 0x18001000, 37), (cf_end, 10, 0x18001000, 10),
                                 (cf_end, 5, 0x18000000, 0)):
        hw._cmd(0x15000000 | d15)
        hw._cmd(0x14000007)
        hw._cmd(0x33000001)
        hw._cmd(go)
        assert hw._dur_field(dict(frame)) == want, (frame['what'], d15, hex(go))
    hw._cmd(0x15000000 | 33)
    hw._cmd(0x33000001)
    assert hw._dur_field(dict(cf_end)) == 33


def test_durg_group_queue_frame_duration(uc):
    """H-DURG (RX-запись станции): Duration группового кадра очереди — остаток TXOP MAC на начало кадра. По лимиту —
    лимит TXOP − SIFS: 1997 у кадров 118 и 194 Б (стенд 2026-11-07, bcbnc2/bcm9). После DMG CTS-to-self с 0x15 = 48/71
    (прежний путь, bcm7/bcm2u) — 30/53: 0x15 − ⌈TXTIME(CTS)⌉ − SIFS, от длины кадра не зависит. 0x15 = 0 перед самим
    групповым кадром не действует — 1997 (стенд bdur0). H-DURLIM0 (не снято): лимит TXOP 0 — 0.
    Одноадресный кадр очереди — по H-DURQ (до конца кадра)."""
    import machw
    from machw import SIFS_CLK, sc_txtime_clk
    hw = HW(uc)
    uc.w32(machw.HW_MAC_TXOP_LIMIT_0, 2000 << 16 | 2000)
    grp = lambda n: bytes.fromhex('8801') + bytes(2) + b'\xff' * 6 + bytes(n - 10)
    t = hw.now
    for n in (118, 194):
        t += 10_000 * CLK_PER_US
        q = dict(what='queue', dur=sc_txtime_clk(n, 1), qframe=grp(n - 4), start=t)
        assert hw._dur_field(q) == 1997, n
    cts = ctrl_txtime_clk(20)
    for d15, want, n in ((48, 30, 118), (71, 53, 194)):
        t += 10_000 * CLK_PER_US
        hw._cmd(0x15000000 | d15)
        hw._cmd(0x14000007)
        hw._cmd(0x33000001)
        hw._cmd(0x18001000)
        hw._dur_field(dict(what='direct 20 B', dur=cts, fifo=b'\x64\x05' + bytes(8), start=t))
        hw._cmd(0x14000000)
        g = dict(what='queue', dur=sc_txtime_clk(n, 1), qframe=grp(n - 4), start=t + cts + 640)   # SIFS_CNT 635–667
        assert hw._dur_field(g) == want, (d15, n)
    t += 10_000 * CLK_PER_US
    hw._cmd(0x14000000)
    hw._cmd(0x15000000)
    assert hw._dur_field(dict(what='queue', dur=sc_txtime_clk(118, 1), qframe=grp(114), start=t)) == 1997
    t += 10_000 * CLK_PER_US
    uc.w32(machw.HW_MAC_TXOP_LIMIT_0, 0)
    assert hw._dur_field(dict(what='queue', dur=sc_txtime_clk(118, 1), qframe=grp(114), start=t)) == 0
    uc.w32(machw.HW_MAC_TXOP_LIMIT_0, 2000 << 16 | 2000)
    t += 10_000 * CLK_PER_US
    uni = bytes.fromhex('8801') + bytes(2) + bytes.fromhex('24181d26d47b') + bytes(104)
    d = sc_txtime_clk(118, 1)
    assert hw._dur_field(dict(what='queue', dur=d, qframe=uni, start=t)) == (2000 * CLK_PER_US - SIFS_CLK - d) // CLK_PER_US


def test_sifs_response_not_from_stale_fifo(uc):
    """H-MTPRESP / H-FIFO1: RTS остался закрытым в FIFO прямой передачи (проба CCA в txop_await_cts_ppdu провалилась,
    0x29000002 — среду занял пир). На RTS пира uc запрашивает ответ (mtp_service_dispatch, вид 5: 0x161f0522) —
    в эфир уходит DMG CTS, который собирает MAC, а не RTS из FIFO; 0x19 ответа кадр FIFO не пускает; следующий кадр FIFO
    (0x33000001) заменяет старый. Стенд: захваты PMC обоих узлов — RTS в ответ на кадр пира нет ни разу."""
    from machw import RESP_CMD_DEADLINE_CTS_CLK
    hw = HW(uc)
    stale = dict(what='direct 20 B', dur=ctrl_txtime_clk(20), fifo=b'\xb4\x00' + bytes(14), mpdu_len=16)
    hw.frame_ready = dict(stale)
    end = hw.air_rx(hw.now + 100, 20, 'RTS пира', sifs_resp=True, resp_len=20, resp_deadline=RESP_CMD_DEADLINE_CTS_CLK)
    while hw.now < end:
        assert hw.advance_to_next()
    for c in (0x1b001111, 0x161f0522, 0x17000000, 0x3e000000, 0x37000020):
        hw._cmd(c)
    hw._cmd(0x19000001)
    for _ in range(50):
        if any(k == 'tx' for _, _, k, _ in hw.air_log):
            break
        hw.advance_to_next()
    tx = [w for _, _, k, w in hw.air_log if k == 'tx']
    assert tx and tx[0].startswith('ответ на RTS пира'), (tx, hw.air_log)
    assert not [w for w in tx if w.startswith('direct')], tx
    assert hw.frame_ready is not None and hw.frame_ready['what'] == 'direct 20 B'   # сам кадр FIFO — не установлено
    hw._cmd(0x33000001)
    assert hw.frame_ready is None


# ---- H-MTPLIM2: план TXOP — повтор и продолжение только с обменом до конца плана -------------------------------

def _mtplim_hw(uc, n_mpdu=8):
    """Модель с очередью данных 0 (A-MPDU из n_mpdu кадров 1200 Б, окно BA n_mpdu) в начатом TXOP (после RTS уже был
    кадр очереди — H-MTPLIM): длительность обмена «A-MPDU + SIFS + BlockAck (MCS 1)»."""
    from machw import BA_LEN, SIFS_CLK, ampdu_psdu_len, sc_txtime_clk
    hw = HW(uc)
    hw.mac_q_model = True
    f = bytes([0x88, 0x02]) + bytes(22) + bytes([0x00, 0x00]) + bytes(1200)       # QoS Data, TID 0
    hw.mac_q[0] = [f] * n_mpdu
    hw.q_agg[0] = n_mpdu
    hw.mtp_qid = 0
    hw.txopq_frames = 1
    hw.xchg = lambda n: sc_txtime_clk(ampdu_psdu_len([f] * n), hw.data_mcs) + SIFS_CLK + sc_txtime_clk(BA_LEN, 1)
    return hw, hw.xchg(n_mpdu)


def _perm_empty(hw):
    hw.perm_req_at = hw.now - 1000
    return bool(hw._read_port(45) & 2)


def test_mtplim2_retry_fits_without_room_for_cf_end(uc):
    """(1) 802.11-2020 10.23.2.9, 10.39.5: повтор (тот же A-MPDU с битом Retry), чей обмен с BlockAck кончается до конца
    плана TXOP, MAC выпускает — даже если после него на CF-End (10.23.2.10 — необязателен) места нет."""
    from machw import TX_START_CLK
    hw, xchg = _mtplim_hw(uc)
    hw.mac_q[0] = [bytes([f[0], f[1] | 0x08]) + f[2:] for f in hw.mac_q[0]]      # H-RETRY: бит Retry
    hw.txopq_end = hw.now + TX_START_CLK + xchg + 1                                 # ровно обмен, CF-End (14 мкс) — нет
    assert not _perm_empty(hw)
    hw._go()
    assert hw.tx_pending is not None and 'A-MPDU 8 MPDU' in hw.tx_pending['what'] and not hw.mtplim_held


@pytest.mark.parametrize('case', ['short', 'retry_short', 'retry_expired'])
def test_mtplim2_no_fit_no_tx_frame_waits(uc, case):
    """(3) Обмен не вмещается в остаток плана TXOP — продолжение, повтор после тайм-аута ответа (в т. ч. когда план уже
    истёк): MTP — «очередь пуста», MAC кадр не выпускает, кадр остаётся в очереди до следующего доступа. Повтор
    открывается тем же 0x19000b00, что и новый доступ (tx_mtp_queue_gate), — план при этом остаётся. Прежде
    повтор шёл за конец плана, а продолжение после конца открывало новый план (Duration — полный лимит)."""
    from machw import MTP_PERM_LAT_CLK
    hw, xchg = _mtplim_hw(uc)
    # не вмещается даже A-MPDU из одного MPDU (длину A-MPDU MAC выбирает по остатку плана — test_mtplim2_ampdu_trimmed)
    hw.txopq_end = hw.now + MTP_PERM_LAT_CLK + hw.xchg(1) - 1 if case != 'retry_expired' else hw.now - 13 * CLK_PER_US
    if case != 'short':
        hw.txopq_retry = True                                                       # тайм-аут BlockAck в этом TXOP
        end = hw.txopq_end
        hw._cmd(0x19000b00)                                                         # повтор: tx_mtp_queue_gate
        assert hw.txopq_end == end
    assert _perm_empty(hw)
    hw._go()
    assert hw.tx_pending is None and hw.frame_ready is None and hw.mtplim_held == [(hw.now, 0)]
    assert len(hw._q_avail(0)) == 8                                                 # кадры ждут
    # закрытие держателем (запрос итога) и следующий доступ (txop_initiator_open_txop_flow: 0x19000b00) — новый план
    hw._cmd(0x16000010)
    hw._cmd(0x18008000)
    hw._cmd(0x19000b00)
    assert hw.txopq_end is None and not _perm_empty(hw)
    hw._go()
    assert hw.tx_pending is not None and 'A-MPDU' in hw.tx_pending['what']


@pytest.mark.parametrize('left_us,qnull', [(2, False), (40, True)])
def test_mtplim2_result_request_qnull_only_within_plan(uc, left_us, qnull):
    """(2) Закрытие после повтора / опустевшей очереди: запрос итога (H-QNULL — QoS Null от имени пустой очереди,
    Duration — остаток TXOP) — кадр этого TXOP: только если кончается до конца плана; иначе MAC ничего не выпускает.
    CF-End держателя — только при достаточном остатке (uc: test_uc_ifs_duration::
    test_cf_end_holder_nonzero_needs_room_for_response)."""
    hw = HW(uc)
    hw.mac_q_model = True
    hdr = bytes([0x88, 0x02]) + bytes(22)
    hw.mac_q[0] = []
    hw.q_last_hdr[0] = hdr
    hw.txopq_frames = 1
    hw.txopq_end = hw.now + left_us * CLK_PER_US
    hw._cmd(0x16000010)                                                             # запрос MTP с б4 к очереди 0
    hw._cmd(0x18008000)                                                             # пуск запроса итога
    assert (hw.tx_pending is not None and 'QoS Null' in hw.tx_pending['what']) == qnull


def test_mtplim2_stale_plan_is_new_access(uc):
    """План кончился давно (> MTPLIM_LIVE_CLK), повтора нет, держатель не закрывал TXOP (своё SP — без CF-End): запрос
    MTP — уже новый доступ, кадр предлагается (иначе новый TXOP не открылся бы — запрос до 0x19000b00)."""
    from machw import MTPLIM_LIVE_CLK
    hw, xchg = _mtplim_hw(uc)
    hw.txopq_end = hw.now - MTPLIM_LIVE_CLK - 1
    assert not _perm_empty(hw)


def test_mtplim2_ampdu_trimmed_to_plan(uc):
    """Длину A-MPDU выбирает MAC/MTP по остатку плана TXOP (H-MTPLIM): в остаток, где помещается обмен с 3 MPDU из 8,
    уходит A-MPDU из 3 MPDU (BlockAck — на них); остальные ждут. Прежде модель слала окно целиком — первый A-MPDU после
    RTS с Duration 135 шёл 692 мкс, за конец CBAP (эмулятор, строгий TDMA с потерями)."""
    from machw import TX_START_CLK
    hw, xchg = _mtplim_hw(uc)
    hw.txopq_frames = 0                                                             # первый кадр после RTS
    hw.txopq_end = hw.now + TX_START_CLK + hw.xchg(3) + 1
    hw._go()
    assert hw.tx_pending is not None and 'A-MPDU 3 MPDU' in hw.tx_pending['what'], hw.tx_pending
    assert len(hw._q_avail(0)) == 5


def test_mtplim2_remaining_time_is_plan(uc):
    """(2) REMAINING_TIME_RD (r40, селектор 3) в действующем плане TXOP — его остаток (H-DURQ): по нему uc шлёт CF-End
    держателя только при достаточном остатке (10.23.2.10; пороги — test_uc_ifs_duration::
    test_cf_end_holder_nonzero_needs_room_for_response); после повтора, съевшего план, — 0, CF-End нет. Без плана —
    максимум (новый доступ)."""
    from machw import MTPLIM_LIVE_CLK
    hw, xchg = _mtplim_hw(uc)
    hw.sel40 = 0x3000
    hw.txopq_end = hw.now + 10 * CLK_PER_US
    assert hw._r40() == 10
    hw.txopq_end = hw.now - CLK_PER_US                                              # план только что кончился
    assert hw._r40() == 0
    hw.txopq_end = hw.now - MTPLIM_LIVE_CLK - 1                                     # давно, повтора нет — без сессии
    assert hw._r40() == 0xffff
