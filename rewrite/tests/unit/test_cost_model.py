# SPDX-License-Identifier: AGPL-3.0-or-later
"""Модель стоимости (costmodel.py) против железа на одном и том же коде: микротесты uc/bench.c.

Сборка uc с -DUC_BENCH, каждый тест — uc_bench_one(номер, n) в эмуляторе с моделью MAC (machw.HW) при n = 2 и 6, цена
группы операций = (ΔT − ΔT_nop) / 64 + 1, как в tools/hwdbg/bench.py на снимках стенда. STAND — медианы стенда
(2026-10-29, образ + uc/bench.c, ltmeas: загрузка + linktest, по 102–125 замеров на тест,
разброс медиан между прогонами ≤ 0,06 такта). Тесты не зависят от раскладки кода (uc/bench.c: выравнивание тел).
Цены и особенности каждого класса — docs/UC-TIMING.md.

Правка модели, расходящаяся с железом, или правка теста в uc/bench.c без нового замера падает здесь. Новый тест в
uc/bench.c — сначала стенд (UC_DBG="-DUC_BENCH -DUC_STAMP_MASK=0x20000", tools/hwdbg/bench.py --json), затем строка
в STAND."""
import os
import subprocess
import sys

import pytest

R = os.path.normpath(os.path.join(os.path.dirname(__file__), '..', '..'))
sys.path.insert(0, os.path.join(R, 'tools', 'hwdbg'))
from bench import NAMES, SETS, bench_set                     # noqa: E402

TOL = 0.3                                                    # такта на группу операций

STAND = {
    'NOP': 1.0, 'LD_DCCM': 1.94, 'LDUSE_DCCM': 3.0, 'ST_DCCM': 1.0, 'LD_FW': 3.94, 'LDUSE_FW': 5.0, 'ST_FW': 1.0,
    'LD_MAC': 11.94, 'LD_RGF': 8.94, 'ST_MAC': 5.94, 'ST_RGF': 4.94, 'STSYNC_MAC': 12.0, 'SYNC': 1.0, 'LR_AUX': 1.0,
    'CORE_RD': 1.0, 'LIMM': 2.0, 'BR': 2.0, 'BR_D': 2.0, 'LD_PHY': 8.94, 'ST_MAC_N1': 5.94, 'ST_MAC_N3': 5.94,
    'ST_MAC_N7': 8.0, 'ST_MAC_N11': 12.0, 'ST_MAC_N7_SYNC': 12.0, 'ST_MAC_LD_MAC': 14.94, 'ST_MAC_LD_FW': 5.92,
    'ST_MAC_LD_DCCM': 5.94, 'LD_MAC_N3': 11.94, 'LD_MAC_N7': 11.94, 'LD_MAC_N11': 12.0, 'LD_FW_N3': 6.0,
    'LIMM_NOPS2': 4.0, 'LIMM_NOP': 3.0, 'NOP_S': 1.0, 'LD_DCCM_NOP': 2.0, 'LD_DCCM_ST': 2.0, 'LD_FW_NOP': 4.0,
    'CALLRET': 7.0, 'CALLRET_D': 7.0, 'BRNE': 5.0, 'STSYNC_RGF': 10.0, 'PUSHPOP': 2.94, 'BREQ_NT': 2.19,
    'BRNE_D': 5.0, 'CMP_BNE': 5.0, 'CMP_BEQ_NT': 5.0, 'CMP_N1_BNE': 5.0, 'CMP_N2_BNE': 5.0, 'CMP_MOVNE': 2.0,
    'BR_MIS': 5.0, 'MUL': 1.0, 'MUL_USE': 2.0, 'MUL_N1_USE': 3.0, 'MUL_N3_USE': 5.0, 'MUL_USE_BIG': 2.0, 'FLAG': 1.0,
    'JL': 10.0, 'ASL_REG': 1.0, 'LD_LIMM': 2.0, 'LOOP2_NOP': 4.25, 'LOOP2_LP': 4.25,
    # набор 2 (UC_BENCH_SET=2): стенд 2026-10-29, bench14 (под нагрузкой, ~250 замеров), bench15 и bench16 (загрузка,
    # 32–35)
    'MOVF_BEQ_NT': 5.0, 'ANDF_BNE': 5.0, 'TST_BNE': 5.0, 'CMP_BNES': 5.0, 'CMP_BEQS_NT': 5.0, 'CMP_BEQD_NT': 6.0,
    'CMP_JEQS_NT': 4.06, 'CMP_N3_BLEQ_NT': 6.0, 'LD_LIMM_USE': 3.0, 'LDOFF_LIMM_USE': 3.0, 'LD_BRNE_NT': 4.19,
    'LD_MAC_LIMM': 11.94, 'LDUSE_MAC': 13.0, 'LD_MAC_LD_LIMM': 15.94, 'BREQS_NT': 2.19, 'BRNES': 5.0,
    'BREQ_NT_N3': 5.0, 'CMP_N1_JEQS_NT': 4.06, 'CMP_JEQ_NT': 4.06, 'LD_TSFLO': 11.94, 'LD_MAC_LD_MAC2': 15.94,
    'LD_MAC_LD_RGF': 12.94, 'LD_RGF_LD_MAC': 12.94, 'LD_TSF2_USE': 20.0, 'LD_TSF3': 27.94, 'LD_RGF_LD_RGF2': 9.94,
    'LD_TSF2_USE1': 15.94, 'LD_TSF_NOP_LD': 15.94, 'LD_TSF_N4_LD': 15.94, 'LD_TSF2_USE_N4': 24.0,
    'LD_RGF_LD_MAC_USE': 17.0, 'LDB_USE_DCCM': 3.0, 'LDW_USE_DCCM': 3.0, 'LDB_USE_FW': 5.0, 'ST_ST2': 2.0,
    'ST_LIMM': 2.0, 'STW_LIMM': 2.0, 'BL_PUSH': 11.0, 'LP3_1': 7.25, 'LP3_2': 9.25, 'LP3_4': 15.25, 'LP1_2': 5.25,
    'BL_NOP_PUSH': 12.0, 'BL_POP_NOP_J': 11.0, 'LP1_1': 4.25, 'LP5_1': 9.25, 'PUSHPOP_BLINK': 2.94, 'PUSH_BLINK': 2.0,
    'LD_BLINK': 1.94, 'LD_R13_SP': 1.94, 'BL_MOVJ': 10.0,
    'BREQ_NT_BACK': 2.25, 'BREQS_NT_BACK': 2.25, 'MUL_MOV_LD': 4.0, 'BTST_MOVEQ': 2.0,
    # набор 3 (UC_BENCH_SET=3): стенд 2026-10-29, bench20–22 (загрузка, 92–119 замеров)
    'BREQ_NT_BK8': 8.0, 'BREQS_NT_BK4': 8.0, 'CMP_BNE_NT_BK': 6.0, 'BREQ_NT_FW8': 4.06, 'BRCC_LOOP2': 10.0,
    'BRCC_LOOP3': 13.0, 'BREQ_NT_BK16': 9.0, 'BREQ_NT_BK32': 13.0, 'BRCC_LOOP2_N2': 15.0, 'BRCC_LOOP2_N6': 23.0,
    'BRCC_LOOP3_N2': 20.0, 'BRCC_LOOP3_N6': 32.0, 'BRCC_LOOP3_N12': 50.0, 'LIMM_S': 3.0, 'LIMM_S2': 4.0,
    'MAC_CMD': 1.0, 'MAC_CMD_N3': 4.0, 'MAC_CMD_R40': 2.0, 'MAC_CMD_LD_MAC': 11.94,
}

EVT_RING_CTL = 0x840130                                      # ctl кольца событий (как у fw: uc_mbox.evt.ctl)
UC_MBOX = 0x802470


def build_bench(toolchain, out, bset):
    env = dict(os.environ, PATH=os.path.join(toolchain, 'bin') + os.pathsep + os.environ['PATH'])
    r = subprocess.run(['make', '-C', R, 'ARC_DIR=' + toolchain, 'BUILD=' + str(out), '-j8',
                        'UC_DBG=-DUC_BENCH -DUC_STAMP_MASK=0x20000 -DUC_BENCH_SET=%d' % bset, str(out / 'uc.elf')],
                       capture_output=True, text=True, env=env)
    assert r.returncode == 0, r.stdout[-2000:] + r.stderr[-2000:]
    import ucemu
    from machw import HW
    u = ucemu.UC(str(out / 'uc.elf'))
    HW(u)
    u.w32(UC_MBOX + 4 + 0xc, EVT_RING_CTL)                   # uc_mbox.evt.ctl → tail/head в памяти fw
    return u


@pytest.fixture(scope='module')
def bench_uc(toolchain, tmp_path_factory):
    """{набор: эмулятор uc со сборкой этого набора} — все тесты в память кода uc не помещаются (uc/bench.c)."""
    return {s: build_bench(toolchain, tmp_path_factory.mktemp('benchbuild%d' % s), s) for s in SETS}


def model_costs(us):
    m = {}
    for s, u in us.items():
        d = {}
        for i, name in enumerate(NAMES):
            if i and bench_set(i) != s:
                continue
            t = []
            for n in (2, 6):
                u.call('uc_bench_one', i, n)
                t.append(u.cpu.regs[0])
            d[name] = t[1] - t[0]
        m.update({k: (v - d['NOP']) / 64 + 1 for k, v in d.items()})
    return m


def test_stand_table_covers_all_benches():
    assert sorted(STAND) == sorted(NAMES)


def test_cost_model_matches_stand_microbenchmarks(bench_uc):
    m = model_costs(bench_uc)
    bad = ['%s: модель %.2f, стенд %.2f' % (k, m[k], STAND[k]) for k in NAMES if abs(m[k] - STAND[k]) > TOL]
    assert not bad, '\n'.join(bad)
