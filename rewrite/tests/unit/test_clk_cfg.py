# SPDX-License-Identifier: AGPL-3.0-or-later
"""Такт ядра — из множителя PLL (include/clk.h); константы uc, зависящие от такта, — непосредственные значения в коде,
которые fw вписывает перед пуском uc (uc/clkk.h: CLKK, таблица .clkpatch; fw/lmac.c clkk_patch_uc).

Проверки: эталон здесь (интервалы 802.11-2020 в мкс × такт, TXTIME в тактах — 3/32 такта на чип при любом множителе) при
такте сброса PLL (165 МГц) равен прежним константам uc; в коде uc у каждой записи таблицы стоит значение при 165 МГц;
формулы fw (clkk_value, uc/clkk.h — собраны хостовым gcc) при других тактах совпадают с эталоном; правило обратных чисел
ответа на CF-End точно при всех Duration и множителях PLL сетки."""
import os
import re
import struct
import subprocess
import tempfile
import pytest

R = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
REF_MHZ, N_RESET = 40, 132
TABLE_PTR, MAGIC = 0xf8, 0x4b4b4c43

CF_END_LEN, GRANT_ACK_LEN, RTS_LEN, SSW_LEN, SSW_ACK_LEN, SSW_FB_LEN, ESE_BA_LEN = 20, 27, 20, 26, 28, 28, 32
SIFS_US, SBIFS_US, SLOT_US, PIFS_US, BRPIFS_US, PPDU_MAX_US, RXPHY_US = 3, 1, 5, 8, 44, 2000, 10
MBIFS_US = 3 * SIFS_US
CF_END_PATH_US, KA_RTS_DUR_US, ESE_BRP_FRAME_US, BF_RETRY, MACLAT_CLK = 4, 40, 100, 8, 91
SSWFB_RETRY_PATH_CLK, SSWFB_RETRY_PATH_MIN_CLK = 744, 725
TIMER1_US, TIMER0_US = 2000000, 10
SIFS_CNT_NS = dict(SIFS_CNT_ABFT_SSW_LATE=1600, SIFS_CNT_ABFT_FB_LATE=6810, SIFS_CNT_RX_ENTRY_LATE=1194,
                   SIFS_CNT_RX_LATE_END_SC=1546, SIFS_CNT_RESP_LATE=5000)


def ctrl_txtime_clk(L):
    """20.11.3, control PHY: Tc = 1/1760 МГц, 3/32 такта на чип, вверх."""
    ncw = 1 + ((L - 6) * 8 + 167) // 168
    tc = 6400 + 1152 + (88 + (L - 6) * 8 + ncw * 168) * 32
    return (tc * 3 + 31) // 32


def sc1_txtime_clk(L):
    nblks = (((L + 20) // 21) * 672 + 447) // 448
    return ((2176 + 1152 + 1024 + nblks * 512 + 64) * 3 + 31) // 32

# поправки отметок времени MAC в тактах (uc/ifs.h UC_*_CLK: тракт PHY в чипах ∝ такту)
STAMP_CLK = dict(TSF_RX_ADJ=281, TX_STAMP_CTRL=1027, TX_STAMP_SC=341)

def cdiv(a, b):
    return -(-a // b)


def ref(f):
    """Величины CLKK при такте f МГц (имена — uc/clkk.h CLKK_LIST)."""
    t_cfe, t_ssw, t_ack, t_fb = (ctrl_txtime_clk(L) for L in (CF_END_LEN, SSW_LEN, SSW_ACK_LEN, SSW_FB_LEN))
    x = t_cfe + SIFS_US * f
    holder = cdiv(x, f)
    gp1 = MBIFS_US * f + t_ack + PIFS_US * f - SSWFB_RETRY_PATH_MIN_CLK
    need = gp1 + SSWFB_RETRY_PATH_CLK + t_fb + MBIFS_US * f + t_ack
    airprop = cdiv(f, 10)
    d = dict(
        MHZ=f, SIFS=SIFS_US * f, SBIFS=SBIFS_US * f, SLOT=SLOT_US * f, PIFS=PIFS_US * f, MBIFS=MBIFS_US * f,
        LBIFS=t_ssw + 2 * SBIFS_US * f, PPDU_MAX=PPDU_MAX_US * f, RX_PHY_START_CTRL=RXPHY_US * f,
        RESP_TIMEOUT=(SIFS_US + SLOT_US + RXPHY_US) * f, BRPIFS=BRPIFS_US * f,
        BRP_RESP_TIMEOUT=(BRPIFS_US + SLOT_US + RXPHY_US) * f,
        RESP_FDBK_WAIT=(1 + BF_RETRY) * (t_fb + MBIFS_US * f + t_ack + PIFS_US * f),
        TIMER1_LIMIT=TIMER1_US * f, TIMER0_TICK=TIMER0_US * f,
        CF_END_X=x, CF_END_MX=cdiv(1 << 36, x), CF_END_MF=cdiv(1 << 36, f),
        GRANT_ACK_SUB_US=(ctrl_txtime_clk(GRANT_ACK_LEN) + SIFS_US * f) // f,
        CF_END_CMD_CTRL=holder + cdiv(t_cfe, f), CF_END_CMD_SC1=holder + cdiv(sc1_txtime_clk(CF_END_LEN), f),
        CF_END_MIN_REM_US=cdiv(t_cfe, f) + CF_END_PATH_US,
        CF_END_NZ_REM_US=cdiv(3 * t_cfe + 2 * SIFS_US * f, f) + CF_END_PATH_US,
        CF_END_CLOSE=(cdiv(t_cfe, f) + CF_END_PATH_US) * f + SLOT_US * f,
        KA_RTS_CMD=KA_RTS_DUR_US + cdiv(ctrl_txtime_clk(RTS_LEN), f),
        ESE_TXOP_TAIL_US=cdiv(2 * SLOT_US * f + SIFS_US * f + ctrl_txtime_clk(ESE_BA_LEN), f),
        ESE_SLS_TAIL_US=cdiv(3 * MBIFS_US * f + t_fb + t_ack + 2 * BRPIFS_US * f, f) + 2 * ESE_BRP_FRAME_US,
        ABFT_AIRPROP=airprop, ABFT_SLOT_TAIL=airprop + 2 * MBIFS_US * f + t_fb,
        ABFT_STA_STD_GP1=MBIFS_US * f - SIFS_US * f - MACLAT_CLK, ABFT_AP_TRIG03=SIFS_US * f + 7,
        ABFT_CLK2FX_MUL=(1048576 + f // 2) // f, ABFT_SSW_TXTIME_FX=(t_ssw * 1024 + f // 2) // f,
        ABFT_SSW_STEP_FX=((t_ssw + SBIFS_US * f) * 1024 + f // 2) // f,
        SLS_DUR_MUL=cdiv(1 << 24, f), US_MUL22=cdiv(1 << 22, f),
        SSWFB_DUR_US=cdiv(t_ack + MBIFS_US * f, f), SSWFB_DUR_BRP_US=cdiv(t_ack + 2 * MBIFS_US * f, f),
        SSWACK_DUR_SUB=(MBIFS_US * f + t_ack) // f,
        SSWFB_GP1=gp1, SSWFB_RETRY_NEED_US=cdiv(need, f), SSWFB_FRAME_US=cdiv(t_fb, f) + 2,
        SSW_FRAME_US=cdiv(t_ssw, f) + 2, BAP_RX_WAIT_PASSES=(PPDU_MAX_US * f + SIFS_US * f) // 4 + 2)
    for k, ns in SIFS_CNT_NS.items():
        d[k] = ((ns // 1000) << 8) | (ns % 1000) * f // 1000
    for k, c in STAMP_CLK.items():
        d[k] = ((c // f) << 16) | c % f
    return d


# прежние константы uc при 165 МГц (ifs.h/abft.h/tail.c/txss.c/ese_dti.c/rx.c/boot.c до перевода на такт)
OLD_165 = dict(MHZ=165, SIFS=495, SBIFS=165, SLOT=825, PIFS=1320, MBIFS=1485, LBIFS=2790, PPDU_MAX=330000,
               RX_PHY_START_CTRL=1650, RESP_TIMEOUT=2970, BRPIFS=7260, BRP_RESP_TIMEOUT=9735, RESP_FDBK_WAIT=79461,
               TIMER1_LIMIT=0x13ab6680, TIMER0_TICK=0x672,
               CF_END_X=2811, CF_END_MX=24446630, CF_END_MF=416481678, GRANT_ACK_SUB_US=18, CF_END_CMD_CTRL=33, CF_END_CMD_SC1=22,
               CF_END_MIN_REM_US=19, CF_END_NZ_REM_US=53, CF_END_CLOSE=19 * 165 + 825, KA_RTS_CMD=55, ESE_TXOP_TAIL_US=32, ESE_SLS_TAIL_US=352,
               ABFT_AIRPROP=17, ABFT_SLOT_TAIL=5999, ABFT_STA_STD_GP1=899, ABFT_AP_TRIG03=502, ABFT_CLK2FX_MUL=6355,
               ABFT_SSW_TXTIME_FX=15267, ABFT_SSW_STEP_FX=16291, SLS_DUR_MUL=101681, US_MUL22=25421, SSWFB_DUR_US=28,
               SSWFB_DUR_BRP_US=37, SSWACK_DUR_SUB=27, SSWFB_GP1=5092, SSWFB_RETRY_NEED_US=81, SSWFB_FRAME_US=21,
               SSW_FRAME_US=17, BAP_RX_WAIT_PASSES=(2000 * 165 + 495) // 4 + 2,
               SIFS_CNT_ABFT_SSW_LATE=0x163, SIFS_CNT_ABFT_FB_LATE=0x685, SIFS_CNT_RX_ENTRY_LATE=0x120,
               SIFS_CNT_RX_LATE_END_SC=0x15a, SIFS_CNT_RESP_LATE=0x500,
               TSF_RX_ADJ=0x10074, TX_STAMP_CTRL=0x60025, TX_STAMP_SC=0x2000b)


def clkk_names():
    s = open(os.path.join(R, 'uc', 'clkk.h')).read()
    body = s[s.index('#define CLKK_LIST(X)'):s.index('#define CLKK_ENUM_')]
    return re.findall(r'X\((\w+),', body)


def test_reference_at_165_equals_old_constants():
    r = ref(REF_MHZ * N_RESET // 32)
    assert set(OLD_165) == set(clkk_names()), 'список величин uc/clkk.h и эталон теста разошлись'
    for k, v in OLD_165.items():
        assert r[k] == v, k


@pytest.fixture(scope='module')
def uc_code(build_dir, toolchain):
    """Образ кода uc с 0 (как в окне fw 0x920000): .vectors, .text, .clkpatch."""
    with tempfile.NamedTemporaryFile(suffix='.bin') as t:
        subprocess.run([os.path.join(toolchain, 'bin', 'arc-elf32-objcopy'), '-O', 'binary', '--only-section=.vectors',
                        '--only-section=.text', '--only-section=.clkpatch', os.path.join(build_dir, 'uc.elf'), t.name],
                       check=True)
        return open(t.name, 'rb').read()


def table(code):
    ta = struct.unpack_from('<I', code, TABLE_PTR)[0]
    magic, n = struct.unpack_from('<2I', code, ta)
    assert magic == MAGIC
    es = struct.unpack_from('<%dI' % n, code, ta + 8)
    return ta, [(e & 0xffffff, e >> 24) for e in es]


def limm(code, a):
    hi, lo = struct.unpack_from('<2H', code, a)       # ARC600: полусловами, старшее вперёд
    return (hi << 16) | lo


def test_code_carries_reset_clock_values(uc_code):
    names, r = clkk_names(), ref(REF_MHZ * N_RESET // 32)
    ta, t = table(uc_code)
    assert len(t) > 50
    for a, i in t:
        assert 0x100 <= a < ta and a % 2 == 0, hex(a)
        assert limm(uc_code, a) == r[names[i]], (hex(a), names[i])
    used = {names[i] for _, i in t}
    assert {'MHZ', 'SIFS', 'MBIFS', 'SIFS_CNT_RX_ENTRY_LATE', 'ABFT_SSW_STEP_FX', 'CF_END_MX'} <= used


@pytest.fixture(scope='module')
def host_clkk(tmp_path_factory):
    """clkk_value (uc/clkk.h, формулы uc/ifs.h) хостовым gcc: значения всех величин при тактах 140…170."""
    d = tmp_path_factory.mktemp('clkk')
    src = d / 'clkk_host.c'
    src.write_text('#include <stdio.h>\n#define CLK_MHZ 165u\n#include "uc/ifs.h"\n'
                   'int main(void) { for (unsigned f = 140; f <= 170; f += 5) for (unsigned i = 0; i < CLKK_N; i++)'
                   ' printf("%u %u %u\\n", f, i, clkk_value(i, f)); return 0; }\n')
    exe = d / 'clkk_host'
    subprocess.run(['gcc', '-std=c11', '-O1', '-I', R, '-I', os.path.join(R, 'include'), '-o', str(exe), str(src)],
                   check=True, cwd=R)
    out = {}
    for line in subprocess.run([str(exe)], capture_output=True, text=True, check=True).stdout.split('\n'):
        if line:
            f, i, v = map(int, line.split())
            out[(f, i)] = v
    return out


@pytest.mark.parametrize('f', [140, 145, 150, 155, 160, 165, 170])
def test_fw_formulas_match_reference(host_clkk, f):
    names, r = clkk_names(), ref(f)
    for i, n in enumerate(names):
        assert host_clkk[(f, i)] == r[n], (f, n)


def test_cf_end_reciprocals_exact_over_pll_grid():
    """dmg_cf_end_resp_dur_us_with (uc/ifs.h): k = ⌊(d·f + x/2)·mx / 2^36⌋, ответ ⌊((k−1)·x + f − 1)·mf / 2^36⌋ при
    mx = ⌈2^36/x⌉, mf = ⌈2^36/f⌉ — совпадает с точным делением при всех d = 0…32767 и множителях PLL 108…140."""
    t = ctrl_txtime_clk(CF_END_LEN)
    for n in range(108, 141):
        f = REF_MHZ * n // 32
        x = t + SIFS_US * f
        mx, mf = cdiv(1 << 36, x), cdiv(1 << 36, f)
        for d in range(0, 32768, 1 if n % 4 == 0 else 7):
            k = ((d * f + x // 2) * mx) >> 36
            r = 0 if k < 2 else (((k - 1) * x + f - 1) * mf) >> 36
            ke = (d * f + x // 2) // x
            assert r == (0 if ke < 2 else ((ke - 1) * x + f - 1) // f), (n, d)


def test_ssw_burst_spin_alignment(build_dir, toolchain):
    """ХРУПКО (uc/bti.c abft_ssw_burst): спины MTP r43/r45 пачки SSW — по адресу ≡ 2 mod 4 (якорь .balign 4 перед циклом);
    при ≡ 0 зазор между SSW в модели стоимости 1,030–1,036 мкс (> SBIFS + aSBIFSAccuracy)."""
    out = subprocess.run([os.path.join(toolchain, 'bin', 'arc-elf32-objdump'), '-d', '--no-show-raw-insn',
                          os.path.join(build_dir, 'uc.elf')], capture_output=True, text=True, check=True).stdout
    body = out[out.index('<abft_responder_fast>:'):]
    body = body[:body.index('\n\n')]
    spins = [int(m.group(1), 16) for m in re.finditer(r'^\s*([0-9a-f]+):\s+mov\s+r0,r4[35]\s*$', body, re.M)]
    assert len(spins) == 2, spins
    assert all(a % 4 == 2 for a in spins), [hex(a) for a in spins]
