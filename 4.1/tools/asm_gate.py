#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Гейт ассемблера: собрать эталонные инструкции из образа и сверить байты.

Приём: инструкции раскладываются по их НАСТОЯЩИМ адресам через .org от базы
сегмента, файл линкуется по этой базе -> PC-относительные переходы (bl/b/br)
кодируются так же, как в оригинале. Затем побайтовое сравнение.

  asm_gate.py refset.txt --as arc-elf32-as --ld arc-elf32-ld [--cpu arc700]
"""
import argparse, os, re, subprocess, sys, tempfile

REGS = re.compile(r'^(r\d+|blink|sp|gp|fp|ilink[12]|pcl|lp_count|mlo|mhi|mmid)$')

def normalize(t):
    """Ghidra-рендеринг -> синтаксис GNU as. Различия, найденные гейтом ассемблера."""
    mn, _, ops = t.partition(' ')
    ops = ops.strip()
    base = mn.split('.')[0]
    # 1) косвенный переход: Ghidra "j_s blink" -> GNU "j_s [blink]"
    if base in ('j', 'j_s', 'jl', 'jl_s') and REGS.match(ops):
        return '%s [%s]' % (mn, ops)
    # 2) .as-адресация: Ghidra печатает БАЙТОВОЕ смещение, gas ждёт уже
    #    поделённое на 4 (поле масштабируется аппаратно)
    if '.as' in mn:
        m = re.match(r'^(.*\[)([^,\]]+),\s*(-?0x[0-9a-fA-F]+|-?\d+)(\].*)$', ops)
        if m:
            v = int(m.group(3), 0)
            if v % 4 == 0:
                sign = '-' if v < 0 else ''
                ops = '%s%s,%s0x%x%s' % (m.group(1), m.group(2), sign, abs(v) // 4, m.group(4))
                return '%s %s' % (mn, ops)
    # 3) сдвиг на 1: Ghidra печатает "lsr a,b,1", gas ждёт выделенную
    #    двухоперандную форму "lsr a,b" (другой опкод)
    if base in ('lsr', 'asl', 'asr', 'ror') and re.match(r'^[^,]+,[^,]+,\s*(0x1|1)$', ops):
        return '%s %s' % (mn, ops.rsplit(',', 1)[0])
    # 4) компактные add_s/sub_s: Ghidra печатает 2 операнда, GNU требует 3
    if base in ('add_s', 'sub_s'):
        parts = [x.strip() for x in ops.split(',')]
        if len(parts) == 2:
            return '%s %s,%s,%s' % (mn, parts[0], parts[0], parts[1])
    return t

def parse(path):
    rows = []
    for l in open(path):
        if not l.startswith('REF'): continue
        p = l.split(None, 4)
        addr = int(p[1], 16); hexb = p[2]; text = p[4].rstrip('\n')
        raw = text.lstrip('_').strip()               # _ = слот задержки в выводе Ghidra
        rows.append((addr, bytes.fromhex(hexb), normalize(raw), raw))
    rows.sort()
    return rows

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('refset')
    ap.add_argument('--as', dest='as_', default='arc-elf32-as')
    ap.add_argument('--ld', default='arc-elf32-ld')
    ap.add_argument('--objcopy', default='arc-elf32-objcopy')
    ap.add_argument('--cpu', default='arc700')
    ap.add_argument('--base', default=None, help='база сегмента (hex); по умолчанию по первому адресу')
    ap.add_argument('-v', '--verbose', action='store_true')
    a = ap.parse_args()

    rows = parse(a.refset)

    total = ok = bad = 0
    fails = []
    TGT = re.compile(r'(.*?)(0x[0-9a-fA-F]+)\s*$')

    def try_build(wd, addr, text, mode, target=None):
        """mode: 'plain' | 'sym' (цель = внешний символ, ld её разрешает)
                 | 'label' (цель = локальная метка на нужном расстоянии)
        Возвращает байты, начинающиеся с адреса addr, или строку с ошибкой."""
        src = os.path.join(wd, 'i.s'); obj = os.path.join(wd, 'i.o')
        elf = os.path.join(wd, 'i.elf'); binf = os.path.join(wd, 'i.bin')
        link_at = addr; skip = 0
        if mode == 'plain':
            body = '\t.text\n\t%s\n' % text
            ldx = []
        elif mode == 'sym':
            body = '\t.text\n\t.extern __t\n\t%s\n' % TGT.sub(r'\1__t', text)
            ldx = ['--defsym', '__t=0x%x' % target]
        else:
            d = target - addr
            if d >= 0:
                body = '\t.text\n\t%s\n\t.space %d\n1:\n' % (TGT.sub(r'\g<1>1f', text), max(d - 16, 0))
            else:
                skip = addr - target
                body = '\t.text\n1:\n\t.space %d\n\t%s\n' % (skip, TGT.sub(r'\g<1>1b', text))
                link_at = target
            ldx = []
        open(src, 'w').write(body)
        r = subprocess.run([a.as_, '-mcpu=' + a.cpu, '-o', obj, src],
                           capture_output=True, text=True)
        if r.returncode != 0:
            return 'НЕ ПРИНЯТА: ' + r.stderr.strip().split('\n')[-1].split('Error: ')[-1][:80]
        r = subprocess.run([a.ld, '-Ttext=0x%x' % link_at, '-o', elf, obj] + ldx,
                           capture_output=True, text=True)
        if r.returncode != 0:
            return 'ЛИНКОВКА: ' + r.stderr.strip().split('\n')[-1][:80]
        subprocess.run([a.objcopy, '-O', 'binary', elf, binf], check=True, capture_output=True)
        return open(binf, 'rb').read()[skip:]

    with tempfile.TemporaryDirectory() as wd:
        for addr, b, t, raw in rows:
            total += 1
            m = TGT.match(t)
            tgt = int(m.group(2), 16) if m and m.group(2).startswith('0x') else None
            # цель похожа на адрес кода -> это переход, а не константа
            is_branch = tgt is not None and (0x8c0000 <= tgt < 0x940000) and \
                        t.split()[0].split('.')[0] in (
                        'b','bl','bne','beq','blt','bge','bhi','bls','bcc','bcs',
                        'bmi','bpl','bvs','bvc','bgt','ble','blo','bhs',
                        'b_s','bne_s','beq_s','bgt_s','bge_s','blt_s','ble_s',
                        'bhi_s','bhs_s','blo_s','bls_s','bl_s',
                        'brne','breq','brlt','brge','brlo','brhs',
                        'brne_s','breq_s','lp','jl')
            if not is_branch:
                got = try_build(wd, addr, t, 'plain')
            else:
                got = try_build(wd, addr, t, 'sym', tgt)
                if isinstance(got, str) or got[:len(b)] != b:
                    alt = try_build(wd, addr, t, 'label', tgt)
                    if not isinstance(alt, str):
                        got = alt
            if (isinstance(got, str) or got[:len(b)] != b) and raw != t:
                alt = try_build(wd, addr, raw, 'plain')   # вдруг исходная запись точнее
                if not isinstance(alt, str) and alt[:len(b)] == b:
                    got = alt
            if isinstance(got, str):
                bad += 1; fails.append((addr, t, got)); continue
            if got[:len(b)] == b: ok += 1
            else:
                bad += 1
                fails.append((addr, t, 'ожидалось %s, получено %s' % (b.hex(), got[:len(b)].hex())))

    print('ВСЕГО %d  СОВПАЛО %d  РАСХОЖДЕНИЙ %d' % (total, ok, bad))
    for addr, t, why in fails[:40]:
        print('  0x%06x  %-34s %s' % (addr, t, why))
    if len(fails) > 40: print('  ... ещё %d' % (len(fails) - 40))
    return 0 if bad == 0 else 1

if __name__ == '__main__':
    sys.exit(main())
