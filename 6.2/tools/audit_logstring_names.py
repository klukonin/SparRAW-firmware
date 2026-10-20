#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Ревизия имён, взятых из лог-строк: подтверждает ли блок своё имя.

Ловушка, ради которой написано (найдена на 6.2, блок 0x8de394): имя
берут по ПЕРВОЙ лог-строке блока, а блок печатает ещё сотню совсем
других. Так диспетчер команд WMI со 115 строками «[HOST CMD] WMI_*»
получил имя `mlme_notify` — по единственной первой строке. Метрика
покрытия такое засчитывает, а читатель листинга оказывается обманут.

Проверка: имя блока должно встречаться хотя бы в одной его строке.
Отдельно выделяются блоки, где имя подтверждено ОДНОЙ строкой из многих
— чем больше остальных строк, тем вероятнее, что имя от соседа или от
вызываемой функции, а не от самого блока.
"""
import argparse, json, re


def norm(s):
    return re.sub(r'[^a-z0-9]', '', s.lower())


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--anno', required=True)
    ap.add_argument('--min-strings', type=int, default=4,
                    help='с какого числа строк считать имя подозрительным')
    a = ap.parse_args()
    anno = json.load(open(a.anno))

    nostr = confirmed = 0
    unconfirmed, thin = [], []
    for nm, v in sorted(anno.items()):
        if nm.startswith(('sub_', 'blk_', 'FUN_')):
            continue
        ss = v.get('strings') or []
        if not ss:
            nostr += 1
            continue
        key = norm(nm.replace('__', '::'))
        hits = [s for s in ss if key and key in norm(s)]
        if not hits:
            unconfirmed.append((nm, len(ss), ss[0][:64]))
        else:
            confirmed += 1
            if len(ss) >= a.min_strings and len(hits) * 4 <= len(ss):
                thin.append((nm, len(hits), len(ss), ss[0][:52]))

    print('имён со строками: подтверждено %d, НЕ подтверждено %d, '
          'без строк вовсе %d' % (confirmed, len(unconfirmed), nostr))
    print('\n--- имя не встречается НИ В ОДНОЙ строке блока ---')
    for nm, n, s in sorted(unconfirmed, key=lambda x: -x[1])[:25]:
        print('  %-46s строк %3d  первая: %s' % (nm[:46], n, s))
    print('\n--- имя подтверждено малой долей строк (вероятно, от соседа) ---')
    for nm, h, n, s in sorted(thin, key=lambda x: -x[2])[:20]:
        print('  %-40s %d из %3d строк  первая: %s' % (nm[:40], h, n, s))


if __name__ == '__main__':
    main()
