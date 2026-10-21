#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Генерирует fw/proto.h — прототипы всех нестатических функций, определённых в fw/*.c.

Подключается через -include для fw/*.o (Makefile): одно объявление на функцию вместо
локальных копий в каждом файле; gcc ловит расхождения локальных объявлений и вызовов
с определением. Сигнатуры берутся у самого gcc (-aux-info), а не регулярками.
  gen_fw_proto.py [--check]      (--check: код 1, если proto.h устарел)
Нужен arc-elf32-gcc в PATH.
Если сигнатура функции изменилась, а в её файле она вызывается раньше определения,
генератор её не выведет (gcc: conflicting types) — поправить строку в fw/proto.h вручную
и запустить снова.
"""
import os, re, subprocess, sys, tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
REW = os.path.dirname(HERE)
FW = os.path.join(REW, 'fw')
OUT = os.path.join(FW, 'proto.h')
CFLAGS = ['-mcpu=arc600', '-std=c11', '-Os', '-ffreestanding', '-fno-builtin', '-nostdlib',
          '-mno-sdata', '-Iinclude', '-fsyntax-only', '-include', 'fw/dccm.h']
ENT = re.compile(r'^/\* (\S+):(\d+):NF \*/ (.*?) /\*.*\*/$')


def collect():
    defs = {}
    with tempfile.TemporaryDirectory() as d:
        for f in sorted(os.listdir(FW)):
            if not f.endswith('.c') or f == 'fw_data.c':   # только данные; ссылается на proto.h
                continue
            aux = os.path.join(d, f + '.aux')
            # текущий proto.h без строк этого файла: объявления остальных функций есть
            # (локальных прототипов в .c нет), а с устаревшими своими — не конфликтуем
            # 1) с полным proto.h; 2) если сигнатуры изменились — без строк функций, на которые
            # gcc сказал «conflicting types» (остальные свои нужны: вызов до определения)
            cc = ['arc-elf32-gcc'] + CFLAGS + ['-aux-info', aux, 'fw/' + f]
            inc = ['-include', OUT] if os.path.exists(OUT) else []
            r = subprocess.run(cc[:1] + inc + cc[1:], cwd=REW, capture_output=True, text=True)
            if r.returncode != 0 and inc:
                bad = set(re.findall(r"conflicting types for '(\w+)'", r.stderr))
                tmp = os.path.join(d, 'proto_' + f + '.h')
                open(tmp, 'w').write(''.join(l for l in open(OUT)
                                             if not any(re.search(r'\b%s\s*\(' % b, l) for b in bad)))
                r = subprocess.run(cc[:1] + ['-include', tmp] + cc[1:], cwd=REW,
                                   capture_output=True, text=True)
            if r.returncode != 0:
                sys.exit('gen_fw_proto: fw/%s не компилируется:\n%s' % (f, r.stderr[-2000:]))
            for l in open(aux):
                m = ENT.match(l.rstrip())
                if not m or os.path.normpath(m.group(1)) != 'fw/' + f:
                    continue
                decl = m.group(3).strip()
                if decl.startswith('static '):
                    continue
                if decl.startswith('extern '):
                    decl = decl[len('extern '):]
                name = re.search(r'(\w+)\s*\(', decl).group(1)
                defs.setdefault(name, (decl, f))
    return defs


BASIC = {'void', 'u8', 'u16', 'u32', 'u64', 's8', 's16', 's32', 's64', 'int', 'unsigned', 'char',
         'short', 'long', 'signed', 'const', 'volatile', 'struct', 'bool', '_Bool', 'float',
         'double', 'size_t', 'uintptr_t', 'union'}


def typedef_headers():
    """{тип: заголовок include/*.h, где он объявлен typedef'ом}"""
    res = {}
    inc = os.path.join(REW, 'include')
    for h in sorted(os.listdir(inc)):
        if not h.endswith('.h'):
            continue
        t = re.sub(r'/\*.*?\*/', ' ', open(os.path.join(inc, h)).read(), flags=re.S)
        i = 0
        while True:
            m = re.compile(r'\btypedef\b').search(t, i)
            if not m:
                break
            j, d = m.end(), 0
            while j < len(t) and not (t[j] == ';' and d == 0):   # конец typedef — ';' вне скобок
                d += {'{': 1, '}': -1}.get(t[j], 0)
                j += 1
            nm = re.search(r'(\w+)\s*(?:\[[^\]]*\]\s*)*$|\(\s*\*\s*(\w+)\s*\)\s*\(.*$', t[m.end():j], re.S)
            if nm:
                res.setdefault(nm.group(1) or nm.group(2), h)
            i = j + 1
    return res


def render(defs):
    th = typedef_headers()
    heads, skipped = set(), []
    for name in list(defs):
        decl = defs[name][0]
        params = decl[decl.index('('):]
        rt = decl[:decl.index(name)]
        words = set(re.findall(r'\b[A-Za-z_]\w*\b', rt + ' ' + params))
        struct_tags = set(re.findall(r'\b(?:struct|union)\s+(\w+)', decl))
        # слова-типы: не базовые, не теги struct, не имена параметров (за ними , или ) или [)
        pnames = set(re.findall(r'(\w+)\s*(?:[,)\[])', params))
        unk = {w for w in words if w not in BASIC and w not in struct_tags and w not in pnames
               and w != name}
        miss = [w for w in unk if w not in th]
        if miss:
            skipped.append((name, defs[name][1], miss))
            del defs[name]
            continue
        heads |= {th[w] for w in unk}
    alld = ' '.join(d for d, _ in defs.values())
    tags = sorted(set(re.findall(r'\bstruct\s+(\w+)', alld)))
    utags = sorted(set(re.findall(r'\bunion\s+(\w+)', alld)))
    out = ['/* Сгенерировано tools/gen_fw_proto.py — не редактировать. */',
           '#ifndef FW_PROTO_H', '#define FW_PROTO_H', '#include "types.h"']
    out += ['#include "%s"' % h for h in sorted(heads)] + ['']
    for n, f, m in skipped:
        print('пропущено (тип не в include/):', n, f, m, file=sys.stderr)
    out += ['struct %s;' % t for t in tags] + ['union %s;' % t for t in utags] + ['']
    for name in sorted(defs):
        decl, f = defs[name]
        out.append('%-100s /* %s */' % (decl, f))
    out += ['', '#endif', '']
    return '\n'.join(out)


def main():
    txt = render(collect())
    if '--check' in sys.argv:
        cur = open(OUT).read() if os.path.exists(OUT) else ''
        sys.exit(0 if cur == txt else 1)
    open(OUT, 'w').write(txt)
    print('fw/proto.h:', txt.count('\n'), 'строк')


if __name__ == '__main__':
    main()
