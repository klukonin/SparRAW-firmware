#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Показать для функции uc: расхождение eqcheck, C-исходник и vendor-дизассемблирование.

  show.py fn [--no-asm]
"""
import json, os, re, subprocess, sys, importlib.util

HERE = os.path.dirname(os.path.abspath(__file__))
TOOLS = os.path.dirname(HERE)
REW = os.path.dirname(TOOLS)
spec = importlib.util.spec_from_file_location('uh', os.path.join(TOOLS, 'uc_hybrid.py'))
uh = importlib.util.module_from_spec(spec)
spec.loader.exec_module(uh)


def c_source(fn, f):
    L = open(os.path.join(uh.UCDIR, f)).read().split('\n')
    for i, l in enumerate(L):
        if re.match(r'^(?:static\s+)?(?:inline\s+)?\w[\w\s\*]*\b%s\s*\(' % re.escape(fn), l) and \
                not l.split('/*')[0].rstrip().endswith(';'):
            out = []
            for k in range(max(0, i - 2), len(L)):
                out.append('%5d: %s' % (k + 1, L[k]))
                if k > i and L[k].startswith('}'):
                    break
            return '\n'.join(out)
    return '(не найдено)'


def main():
    fn = sys.argv[1]
    cm = uh.c_map()
    vb, f = cm.get(fn, (None, None))
    try:
        for r in json.load(open(os.path.join(HERE, 'out/eq_all.json'))):
            if r['fn'] == fn:
                print('== eqcheck:', r['status'], r.get('diffs', [{}])[0].get('d', '') if r.get('diffs') else '')
    except Exception:
        pass
    print('== C (%s):' % f)
    print(c_source(fn, f) if f else '?')
    if vb and '--no-asm' not in sys.argv:
        print('== vendor %s @0x%x (%d Б):' % (vb['name'], vb['addr'], vb['size']))
        d = subprocess.run([uh.OD, '-d', '--start-address=%d' % vb['addr'],
                            '--stop-address=%d' % (vb['addr'] + vb['size']), uh.VELF],
                           capture_output=True, text=True).stdout
        names = {b['addr']: b['name'] for b in uh.blocks}
        for l in d.splitlines()[7:]:
            m = re.search(r';([0-9a-f]{6})\b', l)
            l = re.sub(r'<[^>]*>', '', l)
            if m and int(m.group(1), 16) in names:
                l += '   ; ' + names[int(m.group(1), 16)]
            print(l)


if __name__ == '__main__':
    main()
