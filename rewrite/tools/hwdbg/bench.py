#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Микротесты цены операций uc (uc/bench.c, метка STAMP_BENCH 17) из снимков blob_uc_data.

usage: bench.py <каталог или .bin>… [--json | --gpt | --e27]
Для каждого теста — цена одной группы операций тела (uc/bench.c) в тактах 165 МГц (nop = 1): медиана, мин, макс
по всем парам замеров T(n1), T(n2) одного запуска. --json — словарь {тест: медиана} (для
tests/unit/test_cost_model.py). --gpt — набор 5 (UC_BENCH_SET=5): такты от взвода GP-таймера 0x23010000 | N до
r42 б9 по каждому N и наклон (тактов на единицу срока). --e27 — набор 6: маска 0x27 одного состояния s
idle-detect, такты до r42 б14 (≤ 20 — сразу) или «нет» за 100 мкс."""
import glob
import json
import os
import statistics
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from stamps import stamps                                   # noqa: E402

STAMP_BENCH = 17
E27_ID = 0xe0                                               # набор 6: a0 = 0xe0 | s << 8 | TSF << 16
GPT_ID = 0xf0                                               # uc/bench.c, набор 5: a0 = 0xf0 | N << 8 | TSF << 16
NAMES = ('NOP LD_DCCM LDUSE_DCCM ST_DCCM LD_FW LDUSE_FW ST_FW LD_MAC LD_RGF ST_MAC ST_RGF STSYNC_MAC SYNC LR_AUX '
         'CORE_RD LIMM BR BR_D LD_PHY ST_MAC_N1 ST_MAC_N3 ST_MAC_N7 ST_MAC_N11 ST_MAC_N7_SYNC ST_MAC_LD_MAC '
         'ST_MAC_LD_FW ST_MAC_LD_DCCM LD_MAC_N3 LD_MAC_N7 LD_MAC_N11 LD_FW_N3 LIMM_NOPS2 LIMM_NOP NOP_S '
         'LD_DCCM_NOP LD_DCCM_ST LD_FW_NOP CALLRET CALLRET_D BRNE STSYNC_RGF PUSHPOP BREQ_NT BRNE_D CMP_BNE '
         'CMP_BEQ_NT CMP_N1_BNE CMP_N2_BNE CMP_MOVNE BR_MIS MUL MUL_USE MUL_N1_USE MUL_N3_USE MUL_USE_BIG FLAG JL '
         'ASL_REG LD_LIMM LOOP2_NOP LOOP2_LP MOVF_BEQ_NT ANDF_BNE TST_BNE CMP_BNES CMP_BEQS_NT CMP_BEQD_NT CMP_JEQS_NT '
         'CMP_N3_BLEQ_NT LD_LIMM_USE LDOFF_LIMM_USE LD_BRNE_NT LD_MAC_LIMM LDUSE_MAC LD_MAC_LD_LIMM BREQS_NT BRNES '
         'BREQ_NT_N3 CMP_N1_JEQS_NT CMP_JEQ_NT LD_TSFLO LD_MAC_LD_MAC2 LD_MAC_LD_RGF LD_RGF_LD_MAC LD_TSF2_USE LD_TSF3 '
         'LD_RGF_LD_RGF2 LD_TSF2_USE1 LD_TSF_NOP_LD LD_TSF_N4_LD LD_TSF2_USE_N4 LD_RGF_LD_MAC_USE '
         'LDB_USE_DCCM LDW_USE_DCCM LDB_USE_FW ST_ST2 ST_LIMM STW_LIMM BL_PUSH '
         'LP3_1 LP3_2 LP3_4 LP1_2 BL_NOP_PUSH BL_POP_NOP_J '
         'LP1_1 LP5_1 PUSHPOP_BLINK PUSH_BLINK LD_BLINK LD_R13_SP BL_MOVJ '
         'BREQ_NT_BACK BREQS_NT_BACK MUL_MOV_LD BTST_MOVEQ '
         'BREQ_NT_BK8 BREQS_NT_BK4 CMP_BNE_NT_BK BREQ_NT_FW8 BRCC_LOOP2 BRCC_LOOP3 BREQ_NT_BK16 '
         'BREQ_NT_BK32 BRCC_LOOP2_N2 BRCC_LOOP2_N6 BRCC_LOOP3_N2 BRCC_LOOP3_N6 '
         'BRCC_LOOP3_N12 LIMM_S LIMM_S2 MAC_CMD MAC_CMD_N3 MAC_CMD_R40 MAC_CMD_LD_MAC').split()
OPS = 16
SET2_FIRST = NAMES.index('MOVF_BEQ_NT')                    # uc/bench.c: B_SET2_FIRST, набор UC_BENCH_SET=2
SET3_FIRST = NAMES.index('BREQ_NT_BK8')                    # B_SET3_FIRST, набор 3
SET4 = ('ST_MAC_N11', 'LD_MAC_N11', 'CMP_N3_BLEQ_NT', 'LD_TSF_N4_LD', 'LD_TSF2_USE_N4', 'ST_MAC_N7', 'ST_MAC_N7_SYNC',
        'LP3_4', 'BREQ_NT_N3', 'BL_NOP_PUSH', 'BL_POP_NOP_J')   # uc/bench.c SET4: не помещались
SETS = (1, 2, 3, 4)


def bench_set(i):
    """Набор (UC_BENCH_SET) теста с номером i; NOP (0) — во всех."""
    if i and NAMES[i] in SET4:
        return 4
    return 1 if i < SET2_FIRST else 2 if i < SET3_FIRST else 3


def runs(paths):
    """{номер теста: [(n1, T1, n2, T2)]} без повторов (одна запись журнала видна в нескольких снимках)."""
    seen, out = set(), {}
    for p in paths:
        b = open(p, 'rb').read()
        if len(b) < 0x4000:                                 # снимок до готовности fw — пустой
            continue
        st = [s for s in stamps(b) if s[0] == STAMP_BENCH]
        for x, y in zip(st, st[1:]):
            n1, n2 = (x[2] >> 8) & 0xff, (y[2] >> 8) & 0xff
            if (x[2] & 0xff) in (GPT_ID, E27_ID) or (x[2] & 0xff) != (y[2] & 0xff) or n1 >= n2 or (x[1], x[2]) in seen:
                continue
            if max(x[3], y[3]) > 1000000:                   # COUNT1 сброшен посреди замера
                continue
            seen.add((x[1], x[2]))
            out.setdefault(x[2] & 0xff, []).append((n1, x[3], n2, y[3]))
    return out


def costs(r):
    """{номер: [цена операции]}: (ΔT − ΔT_nop) / (16 Δn) + 1, ΔT_nop — медиана теста NOP."""
    d = {k: [(t2 - t1) / (n2 - n1) for n1, t1, n2, t2 in v] for k, v in r.items()}
    if 0 not in d:
        raise SystemExit('нет замеров NOP')
    d0 = statistics.median(d[0])
    return {k: [(x - d0) / OPS + 1 for x in v] for k, v in d.items()}


def gpt(paths, tag=GPT_ID):
    """{N: [такты]} меток набора 5 (tag = E27_ID — набора 6, {s: [такты]}) без повторов; 0 / ~0 — не дождались."""
    seen, out = set(), {}
    for p in paths:
        b = open(p, 'rb').read()
        if len(b) < 0x4000:
            continue
        for s in stamps(b):
            if s[0] == STAMP_BENCH and (s[2] & 0xff) == tag and s[1:3] not in seen:
                seen.add(s[1:3])
                out.setdefault((s[2] >> 8) & 0xff, []).append(s[3])
    return out


def main():
    a = [x for x in sys.argv[1:] if not x.startswith('--')]
    if not a:
        print(__doc__)
        return 2
    paths = []
    for x in a:
        paths += sorted(glob.glob(os.path.join(x, '**', '*.bin'), recursive=True)) if os.path.isdir(x) else [x]
    if '--e27' in sys.argv:
        for st, v in sorted(gpt(paths, E27_ID).items()):
            w = sorted(t for t in v if t != 0xffffffff)
            print('s=%d n=%3d  сразу %3d  нет %3d  медиана %s' % (st, len(v), sum(t <= 20 for t in w), len(v) - len(w),
                                                              statistics.median(w) if w else '-'))
        return 0
    if '--gpt' in sys.argv:
        g = {n: statistics.median([t for t in v if t]) for n, v in sorted(gpt(paths).items()) if any(v)}
        for n, v in sorted(gpt(paths).items()):
            print('N=%-3d n=%3d  предел %d  медиана %s  мин %s  макс %s' % (n, len(v), v.count(0), g.get(n, '-'),
                                                                        min(v), max(v)))
        k = sorted(g)
        if len(k) >= 2:
            print('тактов на единицу срока: %.2f' % ((g[k[-1]] - g[k[0]]) / (k[-1] - k[0])))
        return 0
    c = costs(runs(paths))
    if '--json' in sys.argv:
        print(json.dumps({NAMES[k]: round(statistics.median(v), 2) for k, v in sorted(c.items())}, ensure_ascii=False))
        return 0
    for k, v in sorted(c.items()):
        print('%-11s n=%3d  медиана %6.2f  мин %6.2f  макс %6.2f' % (NAMES[k] if k < len(NAMES) else k, len(v),
                                                                    statistics.median(v), min(v), max(v)))
    return 0


if __name__ == '__main__':
    sys.exit(main())
