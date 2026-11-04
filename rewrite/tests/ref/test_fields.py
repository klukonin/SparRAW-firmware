# SPDX-License-Identifier: AGPL-3.0-or-later
"""Эталон полей BF/управления DMG и кадров управления DMG: ожидания — из рисунков и текста 802.11-2020
(9.2.4.1, 9.2.4.8, 9.3.1.10–9.3.1.18, 9.3.4.2, 9.4.1.46, 9.5.1–9.5.6, 10.42.2). Позиции подполей ниже переписаны
с меток Bn рисунков (младший и старший бит), а не из спецификаций модуля."""
import random
import zlib
from fractions import Fraction as Fr

import pytest

from . import duration as D
from . import fields as F
from . import timing as T


def _walk(encode, make, nbytes, positions):
    """Для каждого подполя: все единицы в нём, остальное 0 → маска ровно на битах [lo, hi] рисунка."""
    for name, (lo, hi) in positions.items():
        val = (1 << (hi - lo + 1)) - 1
        b = encode(make(name, val))
        assert len(b) == nbytes
        assert int.from_bytes(b, 'little') == val << lo, name


def _total_bits(positions, reserved=()):
    bits = set()
    for lo, hi in list(positions.values()) + list(reserved):
        r = set(range(lo, hi + 1))
        assert not bits & r
        bits |= r
    return bits


# ---- 9.5.1 рис. 9-846 ----
SSW_POS = {'direction': (0, 0), 'cdown': (1, 9), 'sector_id': (10, 15), 'antenna_id': (16, 17),
           'rxss_length': (18, 23)}


def test_ssw_field_bit_positions_fig_9_846():
    assert _total_bits(SSW_POS) == set(range(24))
    _walk(F.encode_ssw, lambda n, v: F.Ssw(**{**dict(direction=0, cdown=0, sector_id=0, antenna_id=0), n: v}), 3,
          SSW_POS)


def test_ssw_field_values():
    # CDOWN «Possible values range from 0 to 511»
    assert F.encode_ssw(F.Ssw(1, 511, 0, 0)) == bytes([0xFF, 0x03, 0x00])
    with pytest.raises(F.FieldError):
        F.encode_ssw(F.Ssw(0, 512, 0, 0))
    # RXSS Length: (RXSS Length + 1) × 2
    assert F.rxss_sweep_length(0) == 2 and F.rxss_sweep_length(63) == 128
    # RXSS Length вне CBAP — резерв
    assert F.check_ssw(F.Ssw(0, 5, 3, 0, 7), in_cbap=False)
    assert not F.check_ssw(F.Ssw(0, 5, 3, 0, 7), in_cbap=True)


# ---- 9.5.2 рис. 9-847 ----
DAI_POS = {'tid': (0, 3), 'alloc_type': (4, 6), 'src_aid': (7, 14), 'dst_aid': (15, 22),
           'alloc_duration': (23, 38)}


def test_dai_bit_positions_fig_9_847():
    assert _total_bits(DAI_POS, [(39, 39)]) == set(range(40))
    zero = dict(tid=0, alloc_type=0, src_aid=0, dst_aid=0, alloc_duration=0)
    positions = dict(DAI_POS)
    del positions['alloc_type']            # все единицы (7) — резерв табл. 9-257, проверяем отдельно
    _walk(F.encode_dai, lambda n, v: F.Dai(**{**zero, n: v}), 5, positions)
    assert int.from_bytes(F.encode_dai(F.Dai(**{**zero, 'alloc_type': F.ALLOC_CBAP})), 'little') == 1 << 4


def test_dai_allocation_type_table_9_257():
    # табл. 9-257: бит 4 = 1 — CBAP; (0,1,0) — SP на 1.08 ГГц; прочие — резерв
    assert F.ALLOC_SP == 0 and F.ALLOC_CBAP == 0b001 and F.ALLOC_SP_1G08 == 0b010 and F.ALLOC_CBAP_1G08 == 0b011
    for t in range(4, 8):
        assert F.check_dai(F.Dai(0, t, 1, 2, 100))


def test_dai_allocation_duration_rules():
    g = lambda d: F.Dai(0, F.ALLOC_SP, 1, 2, d)
    assert not F.check_dai(g(32767), frame='grant', grant_ctx='ati_gp')
    assert F.check_dai(g(32768), frame='grant', grant_ctx='ati_gp')
    assert not F.check_dai(g(32768), frame='grant', grant_ctx='cbap_within')     # b) «set to 32 768»
    assert F.check_dai(g(100), frame='grant', grant_ctx='cbap_within')
    assert not F.check_dai(g(32768), frame='grant', grant_ctx='sp_individual')
    assert not F.check_dai(g(0), frame='grant', grant_ctx='sp_bcast')
    assert F.check_dai(g(32769), frame='grant')
    assert F.check_dai(g(32768), frame='spr')
    assert not F.check_dai(g(32767), frame='spr')


def test_dai_reserved_bit_strict():
    b = bytearray(F.encode_dai(F.Dai(1, 0, 2, 3, 4)))
    b[4] |= 0x80                                    # B39 — Reserved
    assert F.parse_dai(bytes(b)) == F.Dai(1, 0, 2, 3, 4)       # 9.2.2: «ignored upon reception»
    with pytest.raises(F.FieldError):
        F.parse_dai(bytes(b), strict=True)


# ---- 9.5.3 рис. 9-848 / 9-849 ----
FB_ISS_POS = {'total_sectors': (0, 8), 'rx_antennas': (9, 10), 'poll_required': (16, 16)}
FB_POS = {'sector_select': (0, 5), 'antenna_select': (6, 7), 'snr_report': (8, 15), 'poll_required': (16, 16)}


def test_ssw_fb_bit_positions_fig_9_848_849():
    assert _total_bits(FB_ISS_POS, [(11, 15), (17, 23)]) == set(range(24))
    assert _total_bits(FB_POS, [(17, 23)]) == set(range(24))
    _walk(F.encode_ssw_fb, lambda n, v: F.SswFbIss(**{**dict(total_sectors=0), n: v}), 3, FB_ISS_POS)
    _walk(F.encode_ssw_fb, lambda n, v: F.SswFb(**{**dict(sector_select=0), n: v}), 3, FB_POS)


def test_total_sectors_in_iss_example_10_42_2_2_1():
    # «4 sectors … antenna 0, 3 … antenna 1, 5 … antenna 2, and the responder has two receive DMG antennas … 24»
    assert F.total_sectors_in_iss([4, 3, 5], 2) == 24
    # 9.5.3: «0 to 511, representing 1 to 512 sectors»
    assert F.total_sectors_raw(1) == 0 and F.total_sectors_raw(512) == 511
    assert F.total_sectors_raw(24) == 23
    assert F.total_sectors_raw_alt(24) == 24        # СПОРНО: чтение 10.42.2.2.1
    with pytest.raises(F.FieldError):
        F.total_sectors_raw(513)


@pytest.mark.parametrize('snr,raw', [
    (Fr(-13), 0x80),                # «covers from –13 dB»: 4×(−13−19) = −128
    (Fr(5075, 100), 0x7F),          # «to 50.75 dB»: 4×31,75 = 127
    (Fr(19), 0x00),
    (Fr(1925, 100), 0x01),          # шаг 0,25 дБ
    (Fr(1875, 100), 0xFF),
])
def test_snr_report_encoding(snr, raw):
    assert F.snr_report_raw(snr) == raw
    assert F.snr_from_raw(raw) == snr


def test_snr_report_out_of_range():
    for s in (Fr(-1325, 100), Fr(51), Fr(191, 10)):
        with pytest.raises(F.FieldError):
            F.snr_report_raw(s)
    assert F.snr_quantize(Fr(-20)) == -13 and F.snr_quantize(60) == Fr(203, 4)
    assert F.snr_quantize(Fr(1913, 100)) == Fr(77, 4) and F.snr_quantize(Fr(1913, 100), 'floor') == 19


def test_ssw_fb_poll_and_select_reserved():
    assert F.check_ssw_fb(F.SswFb(0, 0, 0, 1), poll_reserved=True)         # 9.5.3: у AP/PCP — резерв
    assert F.check_ssw_fb(F.SswFb(5, 1, 0, 0), select_reserved=True)       # 10.42.2.4: после RXSS — резерв
    assert not F.check_ssw_fb(F.SswFb(0, 0, 0x30, 0), select_reserved=True)


# ---- 9.5.4 рис. 9-850 ----
BRP_POS = {'l_rx': (0, 4), 'tx_trn_req': (5, 5), 'mid_req': (6, 6), 'bc_req': (7, 7), 'mid_grant': (8, 8),
           'bc_grant': (9, 9), 'chan_fbck_cap': (10, 10), 'tx_sector_id': (11, 16), 'other_aid': (17, 24),
           'tx_antenna_id': (25, 26)}


def test_brp_request_bit_positions_fig_9_850():
    assert _total_bits(BRP_POS, [(27, 31)]) == set(range(32))
    # L-RX = 31 при MID-REQ = 0 — резерв; позицию проверяем с MID-REQ = 1 отдельно
    pos = {k: v for k, v in BRP_POS.items() if k != 'l_rx'}
    _walk(F.encode_brp_req, lambda n, v: F.BrpReq(**{n: v}), 4, pos)
    b = F.encode_brp_req(F.BrpReq(l_rx=31, mid_req=1))
    assert int.from_bytes(b, 'little') == 0b11111 | 1 << 6


def test_brp_request_l_rx_range():
    assert not F.check_brp_req(F.BrpReq(l_rx=16))
    assert F.check_brp_req(F.BrpReq(l_rx=17))               # «between 0 and 16. Values outside … reserved»
    assert not F.check_brp_req(F.BrpReq(l_rx=17, mid_req=1))
    assert F.trn_r_count(16) == 64                           # «multiplied by 4»
    assert F.TX_SECTOR_NOT_SWEPT == 63                       # СПОРНО: «0x63» в 6-битном поле


# ---- 9.5.5 рис. 9-851 / 9-852 ----
BFC_TXSS_POS = {'total_sectors': (3, 9), 'rx_antennas': (10, 11)}
BFC_POS = {'rxss_length': (3, 8), 'rxss_tx_rate': (9, 9)}


def test_bf_control_fig_9_851():
    assert _total_bits({'bt': (0, 0), 'ii': (1, 1), 'ir': (2, 2), **BFC_TXSS_POS}, [(12, 15)]) == set(range(16))
    base = dict(bt=1, is_init_txss=1, is_resp_txss=1)
    for n, (lo, hi) in BFC_TXSS_POS.items():
        v = (1 << (hi - lo + 1)) - 1
        b = F.encode_bf_control(F.BfControl(**{**base, n: v}), frame='grant')
        assert int.from_bytes(b, 'little') == 0b111 | v << lo
    # Total Number of Sectors = число − 1: 128 секторов → 127
    f = F.parse_bf_control(F.encode_bf_control(F.BfControl(1, 1, 1, total_sectors=127, rx_antennas=3),
                                               frame='grant_ack'), frame='grant_ack')
    assert f.total_sectors == 127 and f.rx_antennas == 3


def test_bf_control_fig_9_852():
    assert _total_bits({'bt': (0, 0), 'ii': (1, 1), 'ir': (2, 2), **BFC_POS}, [(10, 15)]) == set(range(16))
    b = F.encode_bf_control(F.BfControl(1, 0, 1, rxss_length=63), frame='grant')
    assert int.from_bytes(b, 'little') == 1 | 1 << 2 | 63 << 3
    b = F.encode_bf_control(F.BfControl(1, 0, 0, rxss_length=1, rxss_tx_rate=1), frame='spr')
    assert int.from_bytes(b, 'little') == 1 | 1 << 3 | 1 << 9
    # те же биты 1/1 в SPR — формат рис. 9-852 (рис. 9-851 только Grant/Grant Ack), RXSS Length — резерв
    f = F.BfControl(1, 1, 1)
    assert int.from_bytes(F.encode_bf_control(f, frame='spr'), 'little') == 0b111
    assert F.check_bf_control(F.BfControl(1, 1, 1, rxss_length=5), frame='spr')


def test_bf_control_reserved_rules():
    assert F.check_bf_control(F.BfControl(0, 1, 0), frame='grant')                 # BT=0 → всё резерв
    assert not F.check_bf_control(F.BfControl(0), frame='grant')
    assert F.check_bf_control(F.BfControl(1, 0, 1, rxss_length=0, rxss_tx_rate=1), frame='grant')
    assert not F.check_bf_control(F.BfControl(1, 0, 1, rxss_length=1, rxss_tx_rate=1), frame='grant')
    # Extended Schedule: «either … set to 0, but not both» (СПОРНО — буквально ровно одно)
    assert F.check_bf_control(F.BfControl(1, 1, 1), frame='ext_schedule')
    assert F.check_bf_control(F.BfControl(1, 0, 0), frame='ext_schedule')
    assert not F.check_bf_control(F.BfControl(1, 1, 0), frame='ext_schedule')
    # Grant Ack на Grant с BT=0
    assert F.check_bf_control(F.BfControl(1, 1, 0), frame='grant_ack', grant_bt=0)
    assert not F.check_bf_control(F.BfControl(1, 0, 0, rxss_length=3), frame='grant_ack', grant_bt=0)


# ---- 9.5.6 рис. 9-853, табл. 9-344/9-345 ----
def test_blm_bits_and_time():
    assert F.encode_blm(F.Blm(1, 0, 0)) == b'\x01'
    assert F.encode_blm(F.Blm(0, 63, 0)) == bytes([63 << 1])
    assert F.encode_blm(F.Blm(0, 0, 1)) == b'\x80'
    assert F.blm_time(F.Blm(0, 10)) == 320                  # 32 µs × 10
    assert F.blm_time(F.Blm(1, 63)) == 126000               # 2000 µs × 63
    assert F.blm_time(F.Blm(1, 0)) is None                  # «left undefined»


def test_blm_negotiation_table_9_345():
    assert F.blm_negotiate(0, 640, 0, 320) == 640           # 0 0 ≥ → STA-A
    assert F.blm_negotiate(0, 320, 0, 640) == 640           # симметрично (STA-A/B «in no particular order»)
    assert F.blm_negotiate(1, 320, 0, 640) == 320           # 1 0 >,<,= → STA-A
    assert F.blm_negotiate(0, 320, 1, 640) == 640
    assert F.blm_negotiate(1, 320, 1, 320) == 320           # 1 1 = → STA-A
    assert F.blm_negotiate(1, 320, 1, 640) is None
    assert F.blm_negotiate(1, None, 0, 640) is None         # «If either … is undefined → Undefined»


# ---- 9.2.4.1 рис. 9-4, табл. 9-1, табл. 9-2 ----
@pytest.mark.parametrize('kind,cfe', [('poll', 0b0010), ('spr', 0b0011), ('grant', 0b0100), ('dmg_cts', 0b0101),
                                      ('dmg_dts', 0b0110), ('grant_ack', 0b0111), ('ssw', 0b1000),
                                      ('ssw_fb', 0b1001), ('ssw_ack', 0b1010)])
def test_frame_control_cfe_table_9_2(kind, cfe):
    # Type 01 (B2 = 1, B3 = 0), Subtype 0110 (B4..B7 = 0,1,1,0), CFE в B8–B11
    b = F.encode_fc(F.fc_for(kind))
    assert b == bytes([0b0110_01_00, cfe])
    assert F.frame_kind(F.parse_fc(b)) == kind


def test_frame_control_reserved_cfe_and_bits():
    for cfe in (0, 1, 0b1011, 0b1111):
        assert F.check_fc(F.FrameControl(type=1, subtype=6, cfe=cfe))
    assert F.check_fc(F.FrameControl(type=1, subtype=6, cfe=8, protected=1))       # 9.2.4.1.9
    assert F.check_fc(F.FrameControl(type=1, subtype=6, cfe=8, htc=1))             # 9.2.4.1.10 NOTE
    # рис. 9-4: PM — B12, More Data — B13
    b = F.encode_fc(F.FrameControl(type=1, subtype=6, cfe=8, pm=1, more_data=1))
    assert b == bytes([0x64, 0x08 | 0x10 | 0x20])


def test_frame_control_dmg_beacon_table_9_1():
    assert F.encode_fc(F.fc_for('dmg_beacon')) == bytes([0b0000_11_00, 0])


# ---- 9.2.4.8: FCS ----
def _poly(exps):
    return sum(1 << e for e in exps)


def test_fcs_residue_9_2_4_8():
    # «unique remainder value is the polynomial: x^31 + x^30 + x^26 + x^25 + x^24 + x^18 + x^15 + x^14 + x^12 + x^11
    # + x^10 + x^8 + x^6 + x^5 + x^4 + x^3 + x + 1»
    residue = _poly([31, 30, 26, 25, 24, 18, 15, 14, 12, 11, 10, 8, 6, 5, 4, 3, 1, 0])
    rnd = random.Random(1)
    for n in (0, 1, 20, 26, 100):
        data = bytes(rnd.randrange(256) for _ in range(n))
        assert F.fcs_residue(data + F.fcs(data)) == residue


def test_fcs_generator_and_crc32_crosscheck():
    # G(x) из 9.2.4.8 (без x^32)
    assert F.CRC_G == _poly([26, 23, 22, 16, 12, 11, 10, 8, 7, 5, 4, 2, 1, 0])
    for data in (b'', b'123456789', bytes(range(40))):
        assert F.fcs(data) == zlib.crc32(data).to_bytes(4, 'little')


# ---- 9.3.1.10–9.3.1.18 ----
A, B, C = '02:00:00:00:00:0a', '02:00:00:00:00:0b', '02:00:00:00:00:0c'


def _frames():
    dai = F.Dai(5, F.ALLOC_SP, 1, 2, 1000)
    return [
        F.Poll(100, A, B, 37),
        F.Spr(50, B, A, dai, F.BfControl(1, 1, 0, rxss_length=3)),
        F.Grant(60, A, B, dai, F.BfControl(1, 1, 1, total_sectors=31, rx_antennas=1)),
        F.DmgCts(40, A, B),
        F.DmgDts(30, A, B, C),
        F.SswFrame(200, A, B, F.Ssw(0, 31, 31, 0), F.SswFbIss(31, 0)),
        F.SswFrame(200, A, B, F.Ssw(1, 7, 3, 1), F.SswFb(12, 0, F.snr_report_raw(25), 1)),
        F.SswFbFrame(0, A, B, F.SswFb(3, 0, 0x10), F.BrpReq(l_rx=4, tx_trn_req=1), F.Blm(0, 10, 1)),
        F.SswAck(10, B, A, F.SswFb(4, 1, 0x20), F.BrpReq(mid_grant=1), F.Blm(1, 2, 0)),
        F.GrantAck(20, B, A, F.BfControl(1, 1, 1, total_sectors=15)),
    ]


def test_frame_lengths_figures():
    # рис. 9-49 … 9-57 (сумма октетов), согласованы с duration.LEN; SSW 26 — как в LBIFS (10.3.2.3.11)
    exp = {'poll': 22, 'spr': 27, 'grant': 27, 'dmg_cts': 20, 'dmg_dts': 26, 'ssw': 26, 'ssw_fb': 28,
           'ssw_ack': 28, 'grant_ack': 27}
    assert F.FRAME_LEN == exp
    for k, n in exp.items():
        assert D.LEN[k] == n
    assert T.lbifs() == T.lbifs(F.FRAME_LEN['ssw'])
    for f in _frames():
        assert len(F.encode_frame(f)) == exp[F.KIND_OF[type(f)]]


@pytest.mark.parametrize('f', _frames(), ids=lambda f: type(f).__name__)
def test_frame_round_trip(f):
    b = F.encode_frame(f)
    assert F.parse_frame(b, strict=True) == f
    assert F.check_mpdu(b) == []


def test_ssw_frame_layout_fig_9_54():
    f = F.SswFrame(0x1234, A, B, F.Ssw(1, 0, 0, 0), F.SswFb(0, 0, 0, 1))
    b = F.encode_frame(f)
    assert b[0:2] == bytes([0x64, 0x08])
    assert b[2:4] == bytes([0x34, 0x12])
    assert b[4:10] == bytes.fromhex('02000000000a') and b[10:16] == bytes.fromhex('02000000000b')
    assert b[16:19] == bytes([1, 0, 0])                 # Direction = B0
    assert b[19:22] == bytes([0, 0, 1])                 # Poll Required = B16 SSW Feedback
    assert b[22:26] == F.fcs(b[:22])


def test_dmg_dts_layout_fig_9_53():
    b = F.encode_frame(F.DmgDts(5, A, B, C))
    assert b[10:16] == bytes.fromhex('02000000000b') and b[16:22] == bytes.fromhex('02000000000c')


def test_grant_ack_reserved_octets_fig_9_57():
    b = bytearray(F.encode_frame(F.GrantAck(20, B, A, F.BfControl(0)), with_fcs=False))
    assert b[16:21] == bytes(5)
    b[17] = 1
    assert F.parse_frame(bytes(b), with_fcs=False) == F.GrantAck(20, B, A, F.BfControl(0))
    with pytest.raises(F.FieldError):
        F.parse_frame(bytes(b), with_fcs=False, strict=True)


def test_frame_bad_fcs_and_length():
    b = bytearray(F.encode_frame(F.DmgCts(40, A, B)))
    b[5] ^= 1
    with pytest.raises(F.FieldError):
        F.parse_frame(bytes(b))
    with pytest.raises(F.FieldError):
        F.parse_frame(F.encode_frame(F.DmgCts(40, A, B), with_fcs=False) + b'\x00', with_fcs=False)


def test_frame_rules():
    # Duration: бит 15 = 0 (табл. 9-9)
    with pytest.raises(F.FieldError):
        F.encode_frame(F.DmgCts(32768, A, B))
    # SSW-Feedback в A-BFT: Duration = 0 (9.3.1.16)
    fb = F.SswFbFrame(5, A, B, F.SswFb(), F.BrpReq(), F.Blm())
    assert F.check_frame(fb, abft=True) and not F.check_frame(fb)
    # SSW: формат SSW Feedback по Direction (ISS → рис. 9-848)
    assert F.check_frame(F.SswFrame(0, A, B, F.Ssw(0, 0, 0, 0), F.SswFb()))
    assert F.check_frame(F.SswFrame(0, A, B, F.Ssw(1, 0, 0, 0), F.SswFbIss(0)))
    # SSW-Ack/SSW-Feedback — только рис. 9-849
    assert F.check_frame(F.SswAck(0, A, B, F.SswFbIss(0), F.BrpReq(), F.Blm()))
    # DMG DTS/CTS: RA = TA вызвавшего RTS; Grant Ack: RA = Address 2 Grant
    assert F.check_frame(F.DmgDts(5, A, B, C), rts_ta=B) and not F.check_frame(F.DmgDts(5, A, B, C), rts_ta=A)
    assert F.check_frame(F.GrantAck(5, A, B, F.BfControl(0)), grant_ta=C)
    assert F.is_cts_to_self(F.DmgCts(10, A, C), transmitter=A)
    # Poll Required от AP/PCP — резерв
    assert F.check_frame(F.SswFbFrame(0, A, B, F.SswFb(poll_required=1), F.BrpReq(), F.Blm()), sender_ap_pcp=True)


def test_strict_parse_catches_reserved_bits():
    b = bytearray(F.encode_frame(F.SswFbFrame(0, A, B, F.SswFb(), F.BrpReq(), F.Blm()), with_fcs=False))
    b[18] |= 0x80                                       # SSW Feedback B23 — Reserved
    assert F.parse_frame(bytes(b), with_fcs=False).fb == F.SswFb()
    with pytest.raises(F.FieldError):
        F.parse_frame(bytes(b), with_fcs=False, strict=True)
    assert F.check_mpdu(bytes(b) + F.fcs(bytes(b)))


def test_random_round_trip():
    rnd = random.Random(7)
    for _ in range(300):
        s = F.Ssw(rnd.randrange(2), rnd.randrange(512), rnd.randrange(64), rnd.randrange(4), rnd.randrange(64))
        assert F.parse_ssw(F.encode_ssw(s)) == s
        d = F.Dai(rnd.randrange(16), rnd.randrange(4), rnd.randrange(256), rnd.randrange(256), rnd.randrange(32768))
        assert F.parse_dai(F.encode_dai(d)) == d
        r = F.BrpReq(rnd.randrange(17), *(rnd.randrange(2) for _ in range(6)), rnd.randrange(64), rnd.randrange(256),
                     rnd.randrange(4))
        assert F.parse_brp_req(F.encode_brp_req(r)) == r
        bic = F.Bic(*(rnd.randrange(1 << w) for _, w in F.BIC_SPEC if _))._replace(txss_span=1 + rnd.randrange(127))
        assert F.parse_bic(F.encode_bic(bic)) == bic


# ---- 9.4.1.46 рис. 9-133, табл. 9-68 ----
def test_dmg_params_fig_9_133():
    b = F.encode_dmg_params(F.DmgParams(3, 1, 1, 1, 1))
    assert b == bytes([0b0011_1111])
    assert F.encode_dmg_params(F.DmgParams(2, 0, 0, 0, 1)) == bytes([0b0010_0010])
    assert F.check_dmg_params(F.DmgParams(0), discovery=0)                         # табл. 9-68: 0 — резерв
    assert not F.check_dmg_params(F.DmgParams(0), discovery=1)                     # табл. 9-69: 0 — «Any»
    assert not F.check_dmg_params(F.DmgParams(3), role='ap')
    assert F.check_dmg_params(F.DmgParams(2), role='ap')
    assert not F.check_dmg_params(F.DmgParams(1), role='ibss')
    assert F.check_dmg_params(F.DmgParams(3, privacy=0), rsna=True)
    with pytest.raises(F.FieldError):
        F.parse_dmg_params(bytes([0x43]), strict=True)                             # B6 — Reserved


# ---- 9.3.4.2 рис. 9-77 ----
BIC_POS = {'cc_present': (0, 0), 'discovery': (1, 1), 'next_beacon': (2, 5), 'ati_present': (6, 6),
           'abft_length': (7, 9), 'fss': (10, 13), 'is_resp_txss': (14, 14), 'next_abft': (15, 18),
           'fragmented_txss': (19, 19), 'txss_span': (20, 26), 'n_bis_abft': (27, 30), 'abft_count': (31, 36),
           'n_abft_in_ant': (37, 42), 'pcp_assoc_ready': (43, 43)}


def test_bic_bit_positions_fig_9_77():
    assert _total_bits(BIC_POS, [(44, 47)]) == set(range(48))
    zero = {n: 0 for n in BIC_POS}
    for n, (lo, hi) in BIC_POS.items():
        v = (1 << (hi - lo + 1)) - 1
        f = F.Bic(**{**zero, 'txss_span': 1, n: v})
        x = int.from_bytes(F.encode_bic(f), 'little')
        expect = v << lo | (0 if n == 'txss_span' else 1 << 20)
        assert x == expect, n


def test_bic_semantics():
    f = F.Bic(abft_length=7, fss=15)
    assert F.abft_slots(f) == 8 and F.fss_frames(f) == 16
    assert F.check_bic(F.Bic(txss_span=0))
    assert F.check_bic(F.Bic(abft_count=1), rx_antennas=1)
    assert not F.check_bic(F.Bic(abft_count=1), rx_antennas=2)
    assert F.check_bic(F.Bic(pcp_assoc_ready=1), pcp=False)


# ---- 9.3.4.2 рис. 9-78 / 9-79 ----
def test_clustering_control_fig_9_78():
    f = F.ClusteringControl(beacon_sp_duration=0xAB, cluster_id='01:02:03:04:05:06', member_role=2,
                            cluster_max_mem=7, spsh=1)
    b = F.encode_cc(f, ecapc=0)
    assert b[0] == 0xAB                                         # B0–B7
    assert b[1:7] == bytes([1, 2, 3, 4, 5, 6])                  # B8–B55, октеты адреса по порядку
    assert b[7] == 2 | 7 << 2 | 1 << 7                          # B56–B57, B58–B62, B63
    assert F.parse_cc(b, discovery=0) == f
    assert F.BEACON_SP_UNIT * 0xAB == 1368                      # «in units of 8 µs»
    assert F.check_cc(f._replace(member_role=3))
    assert F.check_cc(f._replace(cluster_max_mem=0))
    assert F.check_cc(f._replace(cluster_max_mem=8), ecapc=0) and not F.check_cc(f._replace(cluster_max_mem=8), ecapc=1)
    assert F.check_cc(f, cdmg=False)


def test_clustering_control_fig_9_79():
    f = F.ClusteringControlDisc('0a:0b:0c:0d:0e:0f')
    b = F.encode_cc(f)
    assert b == bytes([0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0, 0])
    assert F.parse_cc(b, discovery=1) == f
    with pytest.raises(F.FieldError):
        F.parse_cc(b[:6] + b'\x00\x01', discovery=1, strict=True)


# ---- 9.3.4.2 рис. 9-76, табл. 9-45 ----
def _beacon(**kw):
    base = dict(duration=500, bssid=A, timestamp=0x0102030405060708, ssw=F.Ssw(0, 31, 0, 0), beacon_interval=100,
                bic=F.Bic(abft_length=7, fss=15, is_resp_txss=1), params=F.DmgParams(3, cbap_only=1),
                elements=((148, None, bytes(17)), (151, None, bytes(10)), (0, None, b'ssid'),
                          (221, None, b'\x00\x01\x02')))
    base.update(kw)
    return F.DmgBeacon(**base)


def test_dmg_beacon_layout_table_9_45():
    f = _beacon()
    b = F.encode_dmg_beacon(f, role='ap')
    assert b[0:2] == bytes([0x0C, 0x00])
    assert b[4:10] == F.mac_bytes(A)
    assert b[10:18] == bytes([8, 7, 6, 5, 4, 3, 2, 1])          # Timestamp (порядок 1)
    assert b[18:21] == F.encode_ssw(f.ssw)                      # Sector Sweep (2)
    assert b[21:23] == (100).to_bytes(2, 'little')              # Beacon Interval (3)
    assert b[23:29] == F.encode_bic(f.bic)                      # Beacon Interval Control (4)
    assert b[29] == 0b0000_0111                                 # DMG Parameters (5): BSS Type 3, CBAP Only
    assert b[30] == 148 and b[31] == 17                         # DMG Capabilities (7)
    assert F.parse_dmg_beacon(b, strict=True, role='ap') == f
    assert F.check_mpdu(b) == []


def test_dmg_beacon_with_clustering_control():
    cc = F.ClusteringControl(10, B, 1, 1)
    f = _beacon(bic=F.Bic(cc_present=1), cc=cc)
    b = F.encode_dmg_beacon(f)
    assert b[30:38] == F.encode_cc(cc)
    assert F.parse_dmg_beacon(b, strict=True) == f
    assert F.check_dmg_beacon(_beacon(bic=F.Bic(cc_present=1)))             # CC Present без поля
    assert F.check_dmg_beacon(_beacon(cc=cc))                               # поле без CC Present
    fd = _beacon(bic=F.Bic(cc_present=1, discovery=1), params=F.DmgParams(0), cc=F.ClusteringControlDisc(C))
    assert F.parse_dmg_beacon(F.encode_dmg_beacon(fd), strict=True) == fd


def test_dmg_beacon_rules():
    assert F.check_dmg_beacon(_beacon(ssw=F.Ssw(1, 0, 0, 0)))               # 10.42.2.2.1: Direction = 0
    assert F.check_dmg_beacon(_beacon(ssw=F.Ssw(0, 0, 0, 0, 5)))            # RXSS Length вне CBAP — резерв
    assert F.check_dmg_beacon(_beacon(), role='pcp')                        # BSS Type 3 у PCP
    # порядок элементов (табл. 9-45)
    assert F.check_dmg_beacon(_beacon(elements=((0, None, b''), (148, None, b''))))
    assert F.check_dmg_beacon(_beacon(elements=((221, None, b''), (0, None, b''))))         # Vendor — последним
    assert not F.check_dmg_beacon(_beacon(elements=((158, None, b''), (158, None, b''), (221, None, b''),
                                                    (221, None, b''))))                     # Multi-band, Vendor ×n
    assert F.check_dmg_beacon(_beacon(elements=((0, None, b''), (0, None, b''))))           # SSID дважды
    # BSS Load на позиции 21 или 51 (СПОРНО: повтор в таблице)
    assert not F.check_dmg_beacon(_beacon(elements=((255, 28, b''), (11, None, b''))))
    assert not F.check_dmg_beacon(_beacon(elements=((11, None, b''), (12, None, b''))))
    assert F.check_dmg_beacon(_beacon(elements=((50, None, b''),)))         # не из табл. 9-45
    assert F.check_dmg_beacon(_beacon(elements=((6, None, b'\x00\x00'),)), role='ap')       # IBSS Parameter Set


def test_elements_ext_id():
    els = [(255, 17, b'\x01\x02'), (0, None, b'')]
    b = F.encode_elements(els)
    assert b == bytes([255, 3, 17, 1, 2, 0, 0])          # 9.4.2.1: Ext ID входит в Length
    assert F.parse_elements(b) == els


def test_dmg_beacon_bad_fcs():
    b = bytearray(F.encode_dmg_beacon(_beacon()))
    b[12] ^= 0xFF
    assert F.check_mpdu(bytes(b))
