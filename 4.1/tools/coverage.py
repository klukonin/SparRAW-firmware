#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Доля байт с настоящими именами.

Не считаются машинные имена (sub_/blk_/FUN_/thunk_) и имена по лог-строке
(fwlog_/uclog_/live_): лог-строка — не имя функции, у десятка разных
функций она одна и та же. Список должен совпадать с tools/audit_names.py."""
import json,re
BAD=('sub_','blk_','FUN_','thunk_','fwlog_','uclog_','live_')
for seg in ('fw','uc'):
    m=json.load(open('src/asm/%s/blocks.json'%seg))
    b=m['blocks']
    named=[x for x in b if not x['name'].startswith(BAD)]
    nb=sum(x['size'] for x in named); ab=sum(x['size'] for x in b)
    print("%-3s блоков %5d  настоящих имён %5d  байт %6d/%6d = %.1f%%"%(seg,len(b),len(named),nb,ab,100*nb/ab))
    left=[x for x in b if x['name'].startswith(('sub_','blk_'))]
    print("    осталось безымянных: %d блоков, %d байт"%(len(left),sum(x['size'] for x in left)))
