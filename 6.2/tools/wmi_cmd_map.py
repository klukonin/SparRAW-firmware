#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Карта WMI: строка "---->> [HOST CMD] WMI_..." в диспетчере -> обработчик.

Диспетчер host_if__wmi_cmd_dispatch @0x8da54c печатает имя команды прямо
перед вызовом её обработчика, поэтому пара берётся без догадок.
"""
import bisect, json, re

# 6.2: диспетчер лежит по 0x8de394 и занимает 4208 байт. В 4.1 это было
# 0x8da54c/2360 — адрес и размер версионные, снимаются из blocks.json по
# блоку, печатающему строки "[HOST CMD]".
D = 0x8de394
SIZE = 4208
# fw_log_emit0..3 — семейство печати лога (r0 модуль+уровень, r1 строка,
# дальше переменные аргументы). Определяются механически: самые частые
# цели вызова сразу после загрузки строкового адреса 0x10xxxxx.
LOGGERS = {0x8dcba8, 0x8dcc10, 0x8dcc80, 0x8dcd00}


def main():
    d = json.load(open('src/asm/fw/blocks.json'))
    st = sorted(d['blocks'], key=lambda b: b['addr'])
    ads = [b['addr'] for b in st]
    sd = open('ref/strings-fw.bin', 'rb').read()

    def s(a):
        o = a - 0x1000000
        if 0 <= o < len(sd):
            t = sd[o:o + 80].split(b'\0')[0]
            try:
                return t.decode('ascii')
            except UnicodeDecodeError:
                return None

    def own(a):
        i = bisect.bisect_right(ads, a) - 1
        return st[i] if i >= 0 else None

    ins_txt = {}
    for l in open('../blobs/insns/INSNS-6200.txt'):
        if l.startswith('I '):
            q = l.split(None, 3)
            ins_txt[int(q[1], 16)] = q[3].rstrip()
    rows = []
    for l in open('../blobs/insns/INSNS-6200.txt'):
        if l.startswith('I '):
            p = l.split(None, 3)
            a = int(p[1], 16)
            if D <= a < D + SIZE:
                rows.append((a, p[3].rstrip()))

    MOV = re.compile(r'^_?mov(?:_s)?\s+r\d+,\s*(0x1[0-9a-f]{6})$')
    CALL = re.compile(r'^_?(?:bl|b)(?:\.d)?\s+0x0*([0-9a-f]{6})$')
    cur = None
    import sys
    names = open(sys.argv[1], 'a') if len(sys.argv) > 1 else None
    if names:
        names.write('\n# --- обработчики команд WMI: имя из строки '
                    '"[HOST CMD] WMI_*", печатаемой прямо перед вызовом '
                    '(wmi_cmd_map.py) ---\n')
    taken = set()
    print('| команда | обработчик |')
    print('|---|---|')
    for a, t in rows:
        m = MOV.match(t)
        if m:
            v = s(int(m.group(1), 16))
            if v and 'HOST CMD' in v:
                cur = v.replace('---->> [HOST CMD] ', '').strip()
            continue
        m = CALL.match(t)
        if m and cur:
            h = int(m.group(1), 16)
            b = own(h)
            # само семейство логирования пропускаем: строка печатается
            # ИМ, а обработчик команды — следующий вызов за ним
            if h in LOGGERS:
                continue
            # Цель может оказаться чистым переходником (`b <обработчик>`
            # на четырёх байтах). Имя команды должно сесть на настоящий
            # обработчик, иначе он остаётся безымянным, а переходник
            # получает имя, которого не заслуживает. Идём по переходу.
            for _ in range(3):
                tb = own(h)
                if not tb or tb['addr'] != h or tb['size'] > 8:
                    break
                body = [ins_txt.get(h + k) for k in (0,)]
                t0 = ins_txt.get(h)
                m2 = re.match(r'^b(?:\.d)?\s+0x00([0-9a-f]{6})$', t0 or '')
                if not m2:
                    break
                h = int(m2.group(1), 16)
            b = own(h)
            if b and 0x8c0000 <= h < 0x8fc564:
                print('| %s | `%s` |' % (cur, b['name']))
                if names and b['name'].startswith('sub_') and b['addr'] == h:
                    nm = cur.split(',')[0].split('(')[0].strip().lower()
                    if nm.endswith('_cmdid'):
                        nm = nm[:-6]
                    nm = re.sub(r'[^a-z0-9_]', '_', nm)
                    if nm not in taken:
                        taken.add(nm)
                        names.write('0x%08x %s # строка диспетчера: %s\n'
                                    % (h, nm, cur))
                cur = None


if __name__ == '__main__':
    main()
