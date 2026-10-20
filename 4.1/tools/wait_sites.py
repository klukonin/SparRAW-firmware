#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Перепись всех мест ожидания событий в ucode.

Прежняя перепись знала три примитива и один регистр (r42). Ревизия
2026-09-24 нашла ещё два: uc_spin_until_event4 смотрит r54, а
uc_wait_event1_or_event4 ждёт оба регистра сразу. Вывод о бите tsf_event
надо перепроверять по всем пяти, иначе он ничего не стоит.

Маска собирается разбором нескольких инструкций перед вызовом: mov,
bset, asl, or, bmsk. Всё, что не разобралось, печатается как ?, чтобы
не выдавать догадку за факт.
"""
import argparse, bisect, json, re, subprocess, sys

TC = '../toolchain/arc_gnu_2021.03_prebuilt_elf32_le_linux_install/bin/arc-elf32-objdump'

PRIMS = {
    'uc_sleep_until_event':      ('r42', 'r0'),
    'uc_wait_event_busy':        ('r42', 'r0'),
    'uc_spin_until_event':       ('r42', 'r0'),
    'uc_spin_until_event4':      ('r54', 'r0'),
    'uc_wait_event1_or_event4':  ('r42+r54', 'r0,r1'),
    # Шестой и седьмой. Их прежний список PRIMS не знал, потому что список
    # был написан руками: оба программируют ДВИЖОК СОБЫТИЙ командой MAC 0x27
    # из НОМЕРОВ битов, переданных в регистрах, и маску собрать разбором
    # вызова нельзя. Десять площадок tail_uc_wait_two_events передают
    # литерал 6. Что именно индексирует этот номер — поле команды 0x27 не
    # расшифровано, — поэтому вывод «бит 6 не ждут нигде» на них НЕ
    # распространяется.
    'tail_uc_wait_two_events':   ('движок событий (MAC 0x27)', 'r0'),
    'uc_wait_two_events':        ('движок событий (MAC 0x27)', 'r0,r1'),
}

E1 = ['sifs', 'slot', 'start_sifs_rifs_bifs', 'cfg', 'bi1', 'bi2', 'tsf', 'txop',
      'slot2', 'gp_timers', 'plcp_valid', 'sfd_sync', 'rx_frame', 'cca', 'busy2',
      'tx_end', 'ppdu_report', 'queue_set', 'backoff', 'busy', 'comb1', 'comb2',
      'comb3', 'comb4']
E4 = ['txss_end', 'rxss_bf_metric', 'rxss_measurement', 'rxss_timeout',
      'service_period_0', 'rxss_last_cycle', 'gp0_end', 'gp1_end', 'gp2_end',
      'nav', 'backdoor_toggle', 'backdoor_lock', 'service_period_1',
      'service_period_2', 'service_period_3', 'ext_gp_0_1_2_end',
      'ext_gp_3_4_5_end', 'ext_gp_6_7_8_9_end', 'brp_tx']


def bits(mask, names):
    if mask is None:
        return '?'
    out = [names[i] if i < len(names) else 'бит%d' % i
           for i in range(32) if mask >> i & 1]
    return ','.join(out) if out else '—'


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--seg', default='uc')
    ap.add_argument('--inline', action='store_true')
    a = ap.parse_args()
    m = json.load(open('src/asm/%s/blocks.json' % a.seg))
    starts = sorted(b['addr'] for b in m['blocks'])
    nm = {b['addr']: b['name'] for b in m['blocks']}
    addr_of = {b['name']: b['addr'] for b in m['blocks']}

    def owner(x):
        i = bisect.bisect_right(starts, x) - 1
        return nm[starts[i]] if i >= 0 else hex(x)

    out = subprocess.run([TC, '-d', '--start-address=0x%x' % m['base'],
                          '--stop-address=0x%x' % m['end'],
                          'build/%s.elf' % a.seg], capture_output=True, text=True).stdout
    seq = []
    for l in out.splitlines():
        mm = re.match(r'^\s+([0-9a-f]+):\s+((?:[0-9a-f]{4} )+)\s*(.*)$', l)
        if mm:
            t = re.sub(r'\s*<[^>]*>', '', mm.group(3))
            seq.append((int(mm.group(1), 16), re.sub(r'\s+', ' ', t).strip()))
    idx = {p[0]: i for i, p in enumerate(seq)}

    def value_of(i, reg, delay=None, depth=14):
        """Чему равен reg к моменту входа в примитив.

        Слот задержки исполняется ПОСЛЕ перехода, поэтому начинается разбор
        с него: маску там дописывают через bset, и без этого шага половина
        мест ожидания выглядит как «маска 0».
        """
        v = None
        shift = 0
        if delay is not None:
            mm = re.match(r'^bset(_s)?\s+%s,%s,(0x[0-9a-f]+|\d+)$' % (reg, reg), delay)
            if mm:
                v = 1 << int(mm.group(2), 0)
            else:
                mm = re.match(r'^mov(_s)?\s+%s,(0x[0-9a-f]+|-?\d+)$' % reg, delay)
                if mm:
                    return int(mm.group(2), 0)
                if re.match(r'^\w+[\w.]*\s+%s,' % reg, delay):
                    return None
        for j in range(i - 1, max(-1, i - depth), -1):
            t = seq[j][1]
            mm = re.match(r'^mov(_s)?\s+%s,(0x[0-9a-f]+|-?\d+)$' % reg, t)
            if mm:
                return (int(mm.group(2), 0) << shift) if v is None else v
            mm = re.match(r'^bset(_s)?\s+%s,%s,(0x[0-9a-f]+|\d+)$' % (reg, reg), t)
            if mm:
                v = (v or 0) | 1 << int(mm.group(2), 0); continue
            mm = re.match(r'^asl(_s)?\s+%s,%s,(0x[0-9a-f]+|\d+)$' % (reg, reg), t)
            if mm:
                # сдвиг стоит ПОСЛЕ mov в порядке исполнения, а разбор идёт
                # назад: копим его и применяем к найденному дальше значению
                shift += int(mm.group(2), 0)
                if v is not None:
                    v <<= int(mm.group(2), 0)
                continue
            mm = re.match(r'^or(_s)?\s+%s,%s,(0x[0-9a-f]+|\d+)$' % (reg, reg), t)
            if mm:
                v = (v or 0) | int(mm.group(2), 0); continue
            if re.match(r'^\w+[\w.]*\s+%s,' % reg, t):
                return None          # регистр пришёл откуда-то ещё
        return None

    rows = []
    for name, (regs, args) in PRIMS.items():
        tgt = addr_of.get(name)
        if tgt is None:
            print('# нет такого блока: %s' % name); continue
        for i, (ad, t) in enumerate(seq):
            mm = re.match(r'^(bl|b)[\w.]*\s+-?\d+\s+(0x)?([0-9a-f]{6})$', t.replace(';', ' '))
            mm = mm or re.search(r';\s*([0-9a-f]{6})$', t)
            if not mm:
                continue
            dest = int(mm.group(mm.lastindex), 16)
            if dest != tgt or not t.startswith(('bl', 'b')):
                continue
            dly = seq[i + 1][1] if t.split()[0].endswith('.d') and i + 1 < len(seq) else None
            m1 = value_of(i, 'r0', dly)
            m2 = value_of(i, 'r1', dly) if ',' in args else None
            rows.append((owner(ad), hex(ad), name, m1, m2))

    print('Всего мест ожидания: %d\n' % len(rows))
    print('%-40s %-10s %-26s %s' % ('вызывающий', 'адрес', 'примитив', 'биты'))
    tsf = []
    for who, ad, prim, m1, m2 in sorted(rows):
        names = E4 if prim == 'uc_spin_until_event4' else E1
        s = bits(m1, names)
        if m2 is not None:
            s += '   | r54: ' + bits(m2, E4)
        print('%-40s %-10s %-26s %s' % (who, ad, prim, s))
        if m1 is not None and prim != 'uc_spin_until_event4' and m1 >> 6 & 1:
            tsf.append((who, ad))
    print()
    print('мест, где ждут бит 6 r42 (tsf_event): %d' % len(tsf))
    for r in tsf:
        print('   ', r)


if __name__ == '__main__' and '--inline' not in sys.argv:
    main()


# ---------------------------------------------------------------------------
# Вторая популяция ожиданий, найденная ревизией 2026-09-24: встроенные
# самоциклы вида `mov rX,rNN ; bbit0/bbit1 rX,бит,сюда_же`. Они не проходят
# ни через один из пяти примитивов, поэтому перепись по вызовам их не видела,
# а их втрое больше. Запускать: python3 tools/wait_sites.py --inline
# ---------------------------------------------------------------------------
RGF = {
    40: ('BACKOFF_IFS_STATUS', {3: 'nav_active'}),
    42: ('EVENT1_STATUS', {i: n for i, n in enumerate(E1)}),
    43: ('MTP_QUERY_RESPONSE_1', {31: 'valid'}),
    45: ('MTP_TX_PERMISSION_RESP', {31: 'valid'}),
    47: ('DIRECT_TX_CMD_STATUS', {0: 'cmd_ready', 17: 'счётчик занят'}),
    49: ('EVENT_ENGINE2_STATUS', {5: 'phy_rx_brp_done', 2: 'phy_rx_rf_awv_toggle_go'}),
    53: ('BAP_IF_0', {0: 'bap_tx_update_ind', 2: 'bap_rel_done_ind'}),
    54: ('EVENT4_STATUS', {i: n for i, n in enumerate(E4)}),
}


def inline(seg):
    import bisect
    m = json.load(open('src/asm/%s/blocks.json' % seg))
    starts = sorted(b['addr'] for b in m['blocks'])
    nm = {b['addr']: b['name'] for b in m['blocks']}
    out = subprocess.run([TC, '-d', '--start-address=0x%x' % m['base'],
                          '--stop-address=0x%x' % m['end'],
                          'build/%s.elf' % seg], capture_output=True, text=True).stdout
    rows, prev = [], None
    for l in out.splitlines():
        mm = re.match(r'^\s+([0-9a-f]+):\s+(?:[0-9a-f]{4} )+\s*(.*)$', l)
        if not mm:
            continue
        ad = int(mm.group(1), 16)
        t = re.sub(r'\s*<[^>]*>', '', mm.group(2)).strip()
        b2 = re.match(r'^(bbit0|bbit1)\s+\w+,(0x[0-9a-f]+|\d+),\s*-?\d+\s*;([0-9a-f]{6})', t)
        if b2 and prev:
            dest = int(b2.group(3), 16)
            src = re.match(r'^(mov|mov_s|bmsk)\s+\w+,r(\d+)', prev)
            if 0 <= ad - dest <= 10 and src:
                reg = int(src.group(2))
                if 40 <= reg <= 56:
                    i = bisect.bisect_right(starts, ad) - 1
                    rows.append((nm[starts[i]], ad, reg, int(b2.group(2), 0), b2.group(1)))
        prev = t
    return rows


if __name__ == '__main__' and '--inline' in sys.argv:
    tot, tsf = 0, []
    for sg in ('uc', 'fw'):
        rows = inline(sg)
        if not rows:
            continue
        print('== %s: встроенных самоциклов ожидания: %d' % (sg, len(rows)))
        for who, ad, reg, bit, kind in rows:
            rn, bits_ = RGF.get(reg, ('r%d' % reg, {}))
            print('   %-44s 0x%06x  r%-2d %-22s бит %-2d %-24s %s'
                  % (who, ad, reg, rn, bit, bits_.get(bit, ''),
                     'ждёт 1' if kind == 'bbit0' else 'ждёт 0'))
            if reg == 42 and bit == 6:
                tsf.append((sg, who, ad))
        tot += len(rows)
    print()
    print('всего встроенных ожиданий: %d' % tot)
    print('из них по r42 бит 6 (tsf_event): %d' % len(tsf))
    for r in tsf:
        print('   ', r)
