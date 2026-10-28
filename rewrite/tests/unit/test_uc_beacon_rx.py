# SPDX-License-Identifier: AGPL-3.0-or-later
"""Приём DMG Beacon станцией против 802.11-2020: разбор полей маяка (9.3.4.2 рис. 9-77/9-79, 9.4.1.46 табл. 9-69) и
решение «передавать ли в A-BFT этого BI» (10.42.5.1, 10.42.5.2): Next A-BFT, A-BFT Length/FSS, Discovery Mode
(A-BFT Responder Address, BSS Type), пропуск aMaxABFTAccessPeriod A-BFT после SSW-Feedback, выбор слота.

Решение принимают два пути uc — оба проверяются одними сценариями:
  * rx_flow_handle_frame — маяк пришёл в общем пути приёма (вход в BTI с пути приёма, kind 1; станция без
    синхронизации BI, в т. ч. не ассоциированная);
  * bti_bi2_event_step — первый маяк BTI при известном расписании BI (kind 0).
Кадр маяка кладётся в rx_buf (0x804010) байтами по рис. 9-76, табл. 9-45, рис. 9-77; ожидания событий MAC — заглушки."""
import pytest

from test_uc_beacon_tx import MAC_CMD_LOG, bits, clean_shadows, stubs, zero

RX_BUF = 0x804010
BCN_RX = 0x802f14                  # bcn_rx: +1 abft_here, +2 bi_ctrl[6], +8 bss_type, +0x1f abft_go
ABFT_CFG = 0x803124                # +0 relax_cnt u16, +4 responder_mode, +8 beacon_type
UC_ROLE_AP, UC_ROLE = 0x8014c0, 0x8014c4
HW_MAC_OWN_ADDR_LO, HW_MAC_OWN_ADDR_HI = 0x886df0, 0x886df4
MAINT_STA_MASK = 0x802194
OWN = bytes.fromhex('24181d243b0b')
AP = bytes.fromhex('26181d26d47b')
OTHER = bytes.fromhex('26181d26aa01')
BCAST = b'\xff' * 6
MCAST = bytes.fromhex('01005e000001')
ROLES = {'sta': (0, 1, 1), 'ap': (1, 2, 3), 'pcp': (1, 3, 2)}     # (uc_role_ap, режим cmd 0x1b, роль табл. 9-69)

RX_STUBS = ['rx_mac_prepare', 'rx_update_nav_from_frame', 'uc_wait_event_busy', 'rx_end_switch_to_tx',
            'sta_tbl_find_by_mac', 'uc_log_emit_snapshot', 'uc_assert']
BTI_STUBS = ['uc_read_tsf_lo', 'uc_wait_event_busy', 'uc_log_emit_snapshot', 'uc_assert']
BTI_TRUE = ['uc_bi_counter_in_window', 'uc_read_bi_sync', 'bti_worker_bi2_step', 'abft_sta_arm_gp0']


def bic_encode(cc=0, discovery=0, next_beacon=0, ati_present=0, abft_len=1, fss=15, is_resp_txss=1, next_abft=0,
               frag_txss=0, txss_span=1, n_bis_abft=1, abft_count=0, n_abft_in_ant=0, pcp_assoc_ready=0, reserved=0):
    """Beacon Interval Control, рис. 9-77."""
    v = 0
    for val, lo, n in ((cc, 0, 1), (discovery, 1, 1), (next_beacon, 2, 4), (ati_present, 6, 1), (abft_len, 7, 3),
                       (fss, 10, 4), (is_resp_txss, 14, 1), (next_abft, 15, 4), (frag_txss, 19, 1), (txss_span, 20, 7),
                       (n_bis_abft, 27, 4), (abft_count, 31, 6), (n_abft_in_ant, 37, 6), (pcp_assoc_ready, 43, 1),
                       (reserved, 44, 4)):
        assert 0 <= val < (1 << n)
        v |= val << lo
    return v


def dmg_beacon(bic, bssid=AP, bss_type=3, cc_field=None, cdown=0, sector=5, duration=40):
    """DMG Beacon (9.3.4.2, рис. 9-76, табл. 9-45): FC 2, Duration 2, BSSID 6, Timestamp 8, SSW 3 (рис. 9-846), Beacon Interval 2,
    BI Control 6, DMG Parameters 1 (BSS Type — B0..B1, 9.4.1.46), Clustering Control 8 (при CC Present = 1)."""
    f = bytearray(48)
    f[0:2] = (0x0c).to_bytes(2, 'little')            # Type 3 (Extension), Subtype 0 (DMG Beacon), 9.2.4.1.3
    f[2:4] = duration.to_bytes(2, 'little')
    f[4:10] = bssid
    ssw = 0 | (cdown << 1) | (sector << 10)          # Direction 0 (инициатор)
    f[18:21] = ssw.to_bytes(3, 'little')
    f[21:23] = (100).to_bytes(2, 'little')
    f[23:29] = bic.to_bytes(6, 'little')
    f[29] = bss_type & 3
    if cc_field is not None:
        f[30:38] = bytes(cc_field) + bytes(8 - len(cc_field))   # рис. 9-79: A-BFT Responder Address + Reserved
    return bytes(f)


@pytest.fixture
def sta(uc):
    """Станция: не-AP STA, без ассоциаций, политика ответчика A-BFT «всегда, любой маяк» (abft_cfg 2/2)."""
    uc.cpu.regs[25] = MAC_CMD_LOG
    clean_shadows(uc)
    zero(uc, BCN_RX, 0x30)
    uc.w16(ABFT_CFG, 0)
    uc.w32(ABFT_CFG + 4, 2)
    uc.w32(ABFT_CFG + 8, 2)
    uc.w8(MAINT_STA_MASK, 0)
    set_role(uc, 'sta')
    uc.w32(HW_MAC_OWN_ADDR_LO, int.from_bytes(OWN[:4], 'little'))
    uc.w32(HW_MAC_OWN_ADDR_HI, int.from_bytes(OWN[4:], 'little'))
    uc.w32(0x8005f4, 0)                                 # txrx_state1
    uc.w32(0x8005f8, 0)                                 # txrx_state2
    return uc


def set_role(uc, role):
    ap, raw, _ = ROLES[role]
    uc.w32(UC_ROLE_AP, ap)
    uc.w32(UC_ROLE, raw)


def state(uc):
    return dict(abft_here=uc.r8(BCN_RX + 1), abft_go=uc.r8(BCN_RX + 0x1f),
                bic=int.from_bytes(uc.rbytes(BCN_RX + 2, 6), 'little'), relax=uc.r16(ABFT_CFG))


def rx_path(uc, frame, my_bss=0, tsf=0):
    uc.wbytes(RX_BUF, frame)
    uc.ext.update({42: 1 << 16, 36: 1 << 7, 38: my_bss & 1, 37: 0, 55: tsf})   # r55 — TSF (uc_read_tsf_lo)
    uc.call('rx_flow_handle_frame', 0x803e00, stub=stubs(uc, RX_STUBS))
    return state(uc)


def bti_path(uc, frame, my_bss=0, tsf=0):
    uc.wbytes(RX_BUF, frame)
    uc.ext.update({42: 1 << 12, 36: 1 << 7, 38: my_bss & 1})
    zero(uc, 0x803f00, 0x40)
    s = stubs(uc, BTI_STUBS)
    s['uc_read_tsf_lo'] = tsf
    s.update({n: 1 for n in BTI_TRUE})
    uc.call('bti_bi2_event_step', 0x803f00, stub=s)
    return state(uc)


PATHS = {'rx': rx_path, 'bti': bti_path}


@pytest.fixture(params=sorted(PATHS))
def path(request):
    return PATHS[request.param]


# ---------------- Next A-BFT, A-BFT Length, FSS ----------------

@pytest.mark.parametrize('next_abft', [0, 1, 2, 7, 15])
def test_next_abft_nonzero_means_no_abft(sta, path, next_abft):
    """9.3.4.2: Next A-BFT — число BI без A-BFT, 0 — A-BFT сразу за этим BTI; 10.42.5.1: A-BFT — только после BTI с
    маяком Next A-BFT = 0. При Next A-BFT > 0 станция в этом BI в A-BFT не передаёт."""
    s = path(sta, dmg_beacon(bic_encode(next_abft=next_abft)))
    assert s['abft_here'] == (next_abft == 0)
    assert s['abft_go'] == (next_abft == 0)


@pytest.mark.parametrize('fss', [4, 9, 15])
def test_abft_taken_for_every_length(sta, path, fss):
    """10.42.5.2: A-BFT из A-BFT Length+1 слотов, FSS ≥ aSSFramesPerSlot — станция может передавать; поля сохраняются
    для ответа (bcn_rx.bi_ctrl — байты BI Control как в кадре)."""
    for abft_len in range(8):
        zero(sta, BCN_RX, 0x30)
        bic = bic_encode(abft_len=abft_len, fss=fss)
        s = path(sta, dmg_beacon(bic))
        assert (s['abft_here'], s['abft_go']) == (1, 1), abft_len
        assert s['bic'] == bic


def test_unrelated_and_reserved_bits_ignored(sta, path):
    """9.3.4.2 рис. 9-77: B44..B47 Reserved (на приёме не учитываются, 9.2.2), PCP Association Ready, TXSS Span, N BIs
    A-BFT, A-BFT Count, N A-BFT in Ant, Fragmented TXSS, ATI Present, Next Beacon на решение об A-BFT не влияют —
    решают Next A-BFT, A-BFT Length/FSS, Discovery Mode/CC Present."""
    base = bic_encode(abft_len=3, fss=7)
    noisy = base | bic_encode(abft_len=0, fss=0, is_resp_txss=0, txss_span=0, n_bis_abft=0, next_beacon=15,
                              ati_present=1, frag_txss=1) | (0x1fffffff << 19 & ~(0xf << 15)) | (0xf << 44)
    assert bits(noisy, 15, 4) == 0 and bits(noisy, 7, 3) == 3 and bits(noisy, 10, 4) == 7
    s0 = path(sta, dmg_beacon(base))
    zero(sta, BCN_RX, 0x30)
    s1 = path(sta, dmg_beacon(noisy))
    assert (s1['abft_here'], s1['abft_go']) == (s0['abft_here'], s0['abft_go']) == (1, 1)
    for k in range(4):                            # слот — из A-BFT Length+1 = 4 слотов при любых прочих битах
        sta.ext[47] = (k << 30) | 0x3fffffff
        assert sta.call('abft_sta_pick_slot', stub=stubs(sta, [])) == k


# ---------------- выбор слота ----------------

@pytest.mark.parametrize('abft_len', range(8))
def test_backoff_slot_uniform_over_abft_length(sta, abft_len):
    """10.42.5.2: backoff — случайное целое из равномерного [0, A-BFT Length), где A-BFT Length — число слотов A-BFT
    (поле + 1, 9.3.4.2: «number of SSW slots … minus 1»). Случайное — r47 (32 бита): каждый слот получает долю
    2^32/n значений r47 (±1), крайние значения — слоты 0 и n − 1."""
    n = abft_len + 1
    sta.wbytes(BCN_RX + 2, bic_encode(abft_len=abft_len).to_bytes(6, 'little'))
    got = {}
    for r in sorted({0, (1 << 32) - 1} | {(k << 32) // n + d for k in range(n) for d in (0, 1)}
                    | {((k + 1) << 32) // n - 1 for k in range(n)}):
        sta.ext[47] = r
        got[r] = sta.call('abft_sta_pick_slot', stub=stubs(sta, []))
    assert set(got.values()) == set(range(n))
    assert got[0] == 0 and got[(1 << 32) - 1] == n - 1
    edges = sorted(r for r in got if r and got[r] != got[max(x for x in got if x < r)])
    assert len(edges) == n - 1
    for k, e in enumerate(edges, 1):
        assert abs(e - (k << 32) / n) <= 1


# ---------------- Discovery Mode ----------------

def ref_discovery_ok(cc, disc, bss_type, ra, role):
    """10.42.5.2: при Discovery Mode = 1 — одно из условий; группа, кроме широковещательной, — членство не известно
    (консервативно — не передавать; широковещательная — все станции). Табл. 9-69: 0 — любая роль."""
    if not disc or not cc:
        return 1
    if not ra[0] & 1:
        return int(ra == OWN)
    if ra != BCAST:
        return 0
    return int(bss_type == 0 or bss_type == role)


def test_discovery_conditions_all_vectors(sta):
    """Порт tools/test_abft_discovery.py в эмулятор: abft_discovery_ok / abft_bcn_addressed_to_us (uc/abft.h) на всех
    сочетаниях CC Present, Discovery Mode, BSS Type, A-BFT Responder Address и роли станции."""
    bad = []
    for cc in (0, 1):
        for disc in (0, 1):
            for bt in range(4):
                for ra in (OWN, OTHER, BCAST, MCAST):
                    for role in ROLES:
                        set_role(sta, role)
                        sta.wbytes(RX_BUF, dmg_beacon(bic_encode(cc=cc, discovery=disc), bss_type=bt, cc_field=ra))
                        sta.w8(BCN_RX + 2, cc | disc << 1)
                        sta.w32(BCN_RX + 8, bt)
                        ok = sta.call('abft_discovery_ok_call')
                        addr = sta.call('abft_discovery_addressed_call')
                        want = (ref_discovery_ok(cc, disc, bt, ra, ROLES[role][2]), int(cc and disc and ra == OWN))
                        if (ok, addr) != want:
                            bad.append((cc, disc, bt, ra.hex(), role, (ok, addr), want))
    assert not bad, bad


@pytest.mark.parametrize('cc,ra,bss_type,want', [
    (0, None, 3, 1),          # CC Present = 0 — условий нет
    (1, OWN, 3, 1),           # A-BFT Responder Address = наш MAC
    (1, OTHER, 0, 0),         # чужой индивидуальный адрес
    (1, BCAST, 1, 1),         # группа (все) и роль не-AP STA = BSS Type 1
    (1, BCAST, 0, 1),         # BSS Type 0 — любая роль
    (1, BCAST, 3, 0),         # роль AP — не наша
    (1, MCAST, 0, 0),         # группа без известного членства
], ids=['cc0', 'own', 'other', 'bcast-sta', 'bcast-any', 'bcast-ap', 'mcast'])
def test_discovery_beacon_decision(sta, path, cc, ra, bss_type, want):
    """10.42.5.2 (сценарий приёма маяка с Discovery Mode = 1): «If none of these conditions is met … the STA shall not
    transmit in the A-BFT»."""
    s = path(sta, dmg_beacon(bic_encode(cc=cc, discovery=1), bss_type=bss_type, cc_field=ra))
    assert s['abft_here'] == 1
    assert s['abft_go'] == want


# ---------------- aMaxABFTAccessPeriod ----------------

def run_btis(uc, path, n_btis, beacons_per_bti, bic, my_bss=0, **kw):
    """BTI подряд; в каждом маяки CDOWN k−1..0. Возврат — передаёт ли станция в A-BFT каждого BI. Как только решено
    передавать, остаток BTI ведёт путь BTI (bti_bi2_track_best_metric), решение не пересматривается."""
    out = []
    for bi in range(n_btis):
        go = 0
        for cd in range(beacons_per_bti - 1, -1, -1):
            zero(uc, BCN_RX + 0x1e, 2)
            # время: BI 102,4 мс, маяки через ~16 мкс (TXTIME + SBIFS); Duration маяка — до конца BTI (9.3.4.2)
            tsf = 1_000_000 + bi * 102_400 + (beacons_per_bti - 1 - cd) * 16
            go = path(uc, dmg_beacon(bic, cdown=cd, duration=cd * 16 + 15, **kw), my_bss, tsf=tsf)['abft_go']
            if go or path is bti_path:          # путь BTI решает по первому маяку BTI
                break
        out.append(go)
    return out


def test_relax_after_discovery_feedback_bti_path(sta):
    """10.42.5.2: ответчик, получивший SSW-Feedback в A-BFT маяка с Discovery Mode = 1, не обращается к следующим
    aMaxABFTAccessPeriod (= 2, Table 11-22) A-BFT. relax_cnt = 2 — состояние после такого Feedback (bti.c)."""
    sta.w16(ABFT_CFG, 2)
    assert run_btis(sta, bti_path, 3, 16, bic_encode(discovery=1)) == [0, 0, 1]


def test_relax_after_discovery_feedback_rx_path(sta):
    """То же для пути приёма (станция без синхронизации BI, my_bss = 0): развёртка из 16 маяков в BTI. «should not
    attempt to access the following aMaxABFTAccessPeriod A-BFT allocations» — пропускаются A-BFT (по одному на BI),
    сколько бы маяков ни было принято в BTI."""
    sta.w16(ABFT_CFG, 2)
    assert run_btis(sta, rx_path, 3, 16, bic_encode(discovery=1)) == [0, 0, 1]


def test_relax_bypassed_when_addressed(sta, path):
    """10.42.5.2: пропуск не действует, если в BTI перед A-BFT принят маяк с Discovery Mode = 1, CC Present = 1 и A-BFT
    Responder Address = MAC ответчика."""
    sta.w16(ABFT_CFG, 2)
    s = path(sta, dmg_beacon(bic_encode(cc=1, discovery=1), cc_field=OWN))
    assert s['abft_go'] == 1


@pytest.mark.parametrize('resp_txss', [1, 0])
def test_beacon_bssid_recorded_whatever_abft(sta, path, resp_txss):
    """Решение не участвовать в A-BFT (IsResponderTXSS = 0, 10.42.2.3.3) не отменяет учёт самого маяка: BSSID
    (9.3.4.2) записывается так же — по нему fw узнаёт маяк пира после ассоциации (иначе «link up: no beacon»)."""
    s = path(sta, dmg_beacon(bic_encode(fss=8, is_resp_txss=resp_txss), bssid=AP))
    assert s['abft_go'] == resp_txss
    assert sta.rbytes(BCN_RX + 0x14, 6) == AP
