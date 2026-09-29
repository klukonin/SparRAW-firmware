#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Сверяет собранный сегмент с вендорским и печатает, чем они разошлись.

Пока дерево целиком ассемблерное, расхождений быть не должно — это и есть
проверка, что исходники полны и точны.  Как только часть блоков переписана
на C, расхождения ожидаемы: тогда важен лишь список затронутых участков.
"""
import sys

ours, ref, name = open(sys.argv[1], 'rb').read(), open(sys.argv[2], 'rb').read(), sys.argv[3]
if ours == ref:
    print('%s: побайтовое совпадение' % name)
    sys.exit()
n = min(len(ours), len(ref))
diff = [i for i in range(n) if ours[i] != ref[i]]
rs, st, pr = [], None, None
for i in diff:
    if st is None:
        st = i
    elif i > pr + 8:
        rs.append((st, pr)); st = i
    pr = i
if st is not None:
    rs.append((st, pr))
print('%s: наш %d байт, вендорский %d; различий %d байт в %d участках'
      % (name, len(ours), len(ref), len(diff), len(rs)))
for s, e in rs[:20]:
    print('   0x%06x..0x%06x' % (s, e))
if len(rs) > 20:
    print('   ... ещё %d участков' % (len(rs) - 20))
