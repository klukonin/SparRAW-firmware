#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Указатели на vendor-код в vendor fw_data → наши функции.

vendor fw_data (кладётся в образ как есть) содержит указатели на vendor-код в младшем
отображении ICCM (значение = адрес - 0x8c0000): таблицы методов, автоматы состояний,
колбэки. Проверенный список — 6.2/ref/RELOCS-OK-fw.txt (строки `data <место> <значение>`).
Нашего кода по этим адресам нет, поэтому каждое такое слово заменяется ПОЛНЫМ адресом
нашего порта (0x8cxxxx; вызов по младшему отображению наш код не исполняет — проверено
на стенде), а если порта нет — адресом fw_vendor_ptr_trap.

Порт vendor-функции находится:
  1. по комментарию над определением, где первым стоит vendor-адрес `(0x8xxxxx`;
  2. по имени: vendor `a__b` / `a::b` ↔ наше `a_b` (без учёта регистра).
"""
import glob, os, re, struct, subprocess

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
REF = os.path.join(ROOT, '..', '6.2', 'ref')
TRAP = 'fw_vendor_ptr_trap'
CODE_BASE = 0x8c0000

# __attribute__((...)) — с одним уровнем вложенных скобок: section(".textlate"), weak, ...
DEF_RE = re.compile(r'^(?:VENDOR_PTR_TARGET\s+)?(?:__attribute__\(\((?:[^()]|\([^()]*\))*\)\)\s*)*'
                    r'(?:static\s+)?(?:inline\s+)?'
                    r'(?:const\s+)?(?:struct\s+)?(?:unsigned\s+|signed\s+)?\w+[\s\*]+(\w+)\s*\(([^;]*)$')


def norm(n):
    return re.sub(r'_+', '_', n.replace('::', '_')).lower().strip('_')


def vendor_names():
    vn = {}
    for l in open(os.path.join(REF, 'SYMS.txt')):
        p = l.split()
        if len(p) >= 5 and p[0] == 'SYM':
            vn.setdefault(int(p[1], 16), p[4])
    for l in open(os.path.join(REF, 'NAMES-EXTRA.txt')):
        m = re.match(r'\s*(0x[0-9a-fA-F]+)\s+(\S+)', l)
        if m:
            vn[int(m.group(1), 16)] = m.group(2)
    return vn


def comment_map(src_dir):
    """vendor-адрес → множество имён наших функций (по комментарию над определением)."""
    cm = {}
    for f in sorted(glob.glob(os.path.join(src_dir, 'fw', '*.c'))):
        lines = open(f, encoding='utf-8').read().split('\n')
        for i, l in enumerate(lines):
            if not l or l[0] in ' \t#/*}':
                continue
            m = DEF_RE.match(l)
            if not m or m.group(1) in ('if', 'while', 'for', 'switch', 'return'):
                continue
            # блок комментария непосредственно над определением (или на той же строке)
            j = i - 1
            block = []
            while j >= 0 and lines[j].strip() and (lines[j].lstrip().startswith(('/*', '*'))
                                                  or lines[j].rstrip().endswith('*/')):
                block.insert(0, lines[j])
                j -= 1
            text = ' '.join(block) + ' ' + l
            a = re.search(r'\(0x(8[c-f][0-9a-f]{4})\b', text)
            if a:
                cm.setdefault(int(a.group(1), 16), set()).add(m.group(1))
    return cm


def our_symbols(elf, nm):
    syms, dup = {}, set()
    for l in subprocess.run([nm, elf], capture_output=True, text=True).stdout.splitlines():
        p = l.split()
        if len(p) == 3 and p[1] in 'Tt':
            if p[2] in syms:
                dup.add(p[2])
            syms[p[2]] = int(p[0], 16)
    for d in dup:
        del syms[d]
    return syms


def build_map(elf, nm, src_dir=ROOT):
    vn = vendor_names()
    cm = comment_map(src_dir)
    syms = our_symbols(elf, nm)
    if TRAP not in syms:
        syms[TRAP] = 0   # ловушки больше нет (fw_data целиком из C): неперенесённый указатель → 0, сверка покажет отличие
    by_norm = {norm(k): k for k in syms}
    our_addrs = {}
    for va_, names in cm.items():
        for n in names:
            our_addrs.setdefault(n, set()).add(va_)

    def resolve(va):
        cand = sorted(n for n in cm.get(va, ()) if n in syms)
        how = 'comment'
        if not cand:
            v = vn.get(va)
            n = by_norm.get(norm(v)) if v else None
            # имя в NAMES-EXTRA бывает приписано нескольким адресам: не брать порт,
            # у которого в комментарии стоит другой vendor-адрес
            if n and not (our_addrs.get(n, set()) - {va}):
                cand, how = [n], 'name'
        if len(set(syms[c] for c in cand)) == 1:
            return cand[0], how
        if cand:
            return None, 'ambiguous:' + ','.join(cand)
        return None, 'missing'
    return vn, syms, resolve


def relocs():
    out = []
    for l in open(os.path.join(REF, 'RELOCS-OK-fw.txt')):
        p = l.split()
        if len(p) >= 3 and p[0] == 'data':
            out.append((int(p[1], 16), int(p[2], 16)))
    return out


def relocate_fw_data(payload, elf, nm, report=None):
    """payload — запись fw_data (адрес 0x900000 + данные с DCCM 0x800000)."""
    vn, syms, resolve = build_map(elf, nm)
    # отладка (бисекция): FW_RELOC_MODE=all|ports|traps, FW_RELOC_RANGE=lo:hi (адреса fw_data)
    mode = os.environ.get('FW_RELOC_MODE', 'all')
    rlo, rhi = [int(x, 16) for x in os.environ.get('FW_RELOC_RANGE', '0:ffffffff').split(':')]
    b = bytearray(payload)
    n_port = n_trap = 0
    lines = []
    for addr, val in relocs():
        off = 4 + addr - 0x800000
        if off + 4 > len(b):
            lines.append('skip  0x%06x 0x%05x (вне записи)' % (addr, val))
            continue
        cur = struct.unpack_from('<I', b, off)[0]
        if cur != val:
            raise SystemExit('fw_data 0x%x: ожидали 0x%x, там 0x%x' % (addr, val, cur))
        va = CODE_BASE + val
        if not (rlo <= addr < rhi):
            continue
        name, how = resolve(va)
        if (mode == 'ports' and not name) or (mode == 'traps' and name):
            continue
        if name:
            n_port += 1
        else:
            name, n_trap = TRAP, n_trap + 1
        struct.pack_into('<I', b, off, syms[name])   # полный адрес: младшее отображение наш код не исполняет
        lines.append('%-5s 0x%06x 0x%06x %-40s -> %s' % ('port' if name != TRAP else 'trap', addr, va,
                                                       vn.get(va, '?'), name if name != TRAP else how))
    if report:
        open(report, 'w').write('\n'.join(lines) + '\n')
    print('fw_data: указателей на vendor-код: %d → наш порт %d, ловушка %d' % (n_port + n_trap, n_port, n_trap))
    return bytes(b)
