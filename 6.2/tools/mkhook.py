#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Трамплины-хуки: перехват вендорской функции без потери её кода.

Идея: в начало целевой функции пишется переход в наш обработчик; вытесненные
инструкции переносятся в трамплин, который после нашего кода выполняет их и
возвращается в исходный поток.

Тонкости ARC, из-за которых это нельзя делать «в лоб»:
  * инструкции разной длины (2/4/6/8 Б) — вытеснять можно только целиком;
  * **слот задержки**: у перехода с суффиксом .d следующая инструкция является
    его частью. Разорвать пару = сломать поток;
  * PC-относительные инструкции при переносе меняют смысл. Переходы с известной
    целью мы переписываем текстом (линкер посчитает новое смещение), а `lp`
    (аппаратный цикл) переносить нельзя вообще — такой хук отклоняется;
  * ассемблер не всегда выдаёт ту же кодировку, что в образе, поэтому
    непереходные инструкции переносятся ДОСЛОВНО байтами.

Две фазы (адрес нашего обработчика известен только после линковки):
  analyze  -> трамплин (.S) + ld-фрагмент с адресами возврата
  overlay  -> после сборки: собрать патч-переход и выдать overlay для wil_syms
"""
import argparse, os, re, subprocess, sys, tempfile

BR_RE = re.compile(r';([0-9a-f]+)\s+<')          # objdump помечает цель перехода
INSN_RE = re.compile(r'^\s*([0-9a-f]+):\s+((?:[0-9a-f]{4}\s+)+)\s*(\S+)\s*(.*)$')
BRANCH_MN = ('b', 'bl', 'br', 'j', 'jl', 'lp')

def disasm(tools, blob, base, lo, hi):
    """Дизассемблировать участок сырого сегмента через .incbin + ld + objdump."""
    with tempfile.TemporaryDirectory() as wd:
        s = os.path.join(wd, 'w.s')
        open(s, 'w').write('\t.section .text,"ax"\n\t.incbin "%s"\n' % os.path.abspath(blob))
        o, e = os.path.join(wd, 'w.o'), os.path.join(wd, 'w.elf')
        subprocess.run([tools['as'], '-mcpu=' + tools['cpu'], '-o', o, s], check=True,
                       capture_output=True)
        subprocess.run([tools['ld'], '-Ttext=0x%x' % base, '-o', e, o],
                       check=True, capture_output=True)
        r = subprocess.run([tools['objdump'], '-d', '--start-address=0x%x' % lo,
                            '--stop-address=0x%x' % hi, e],
                           check=True, capture_output=True, text=True)
    out = []
    for line in r.stdout.split('\n'):
        m = INSN_RE.match(line)
        if not m:
            continue
        addr = int(m.group(1), 16)
        words = m.group(2).split()
        raw = b''.join(bytes.fromhex(w)[::-1] for w in words)   # objdump печатает полусловами
        mn, ops = m.group(3), m.group(4).strip()
        tgt = None
        mt = BR_RE.search(line)
        if mt:
            tgt = int(mt.group(1), 16)
        out.append(dict(addr=addr, raw=raw, mn=mn, ops=ops, tgt=tgt, text=line.strip()))
    return out

def pick(insns, at, need=4):
    """Набрать вытесняемые инструкции: не меньше need байт и не разрывая слот задержки."""
    chosen, total = [], 0
    i = 0
    while i < len(insns):
        ins = insns[i]
        chosen.append(ins); total += len(ins['raw']); i += 1
        # у перехода с .d следующая инструкция — его слот задержки
        if ins['mn'].endswith('.d') or '.d' in ins['mn']:
            if i < len(insns):
                chosen.append(insns[i]); total += len(insns[i]['raw']); i += 1
            else:
                return None, 'слот задержки за границей разбора'
            continue
        if total >= need:
            break
    if total < need:
        return None, 'не набралось %d байт' % need
    return chosen, None

def main():
    ap = argparse.ArgumentParser()
    sub = ap.add_subparsers(dest='cmd', required=True)
    for name in ('analyze', 'overlay'):
        p = sub.add_parser(name)
        p.add_argument('--at', required=True, help='адрес перехватываемой функции, hex')
        p.add_argument('--bin', default='../blobs/kit-6200/seg_008c0000.bin')
        p.add_argument('--base', default='0x8c0000')
        p.add_argument('--tools', default=None, help='каталог bin тулчейна')
        p.add_argument('--cpu', default='arc600')
        if name == 'analyze':
            p.add_argument('--handler', required=True, help='имя нашей C-функции')
            p.add_argument('--out-asm', default=None)
            p.add_argument('--out-ld', default='ld/hooks.ld')
        else:
            p.add_argument('--elf', default='build/ext.elf')
            p.add_argument('--out', default=None)
    a = ap.parse_args()

    tdir = a.tools or os.environ.get('ARC_BIN') or '.'
    tools = dict(as_=os.path.join(tdir, 'arc-elf32-as'),
                 ld=os.path.join(tdir, 'arc-elf32-ld'),
                 objdump=os.path.join(tdir, 'arc-elf32-objdump'),
                 nm=os.path.join(tdir, 'arc-elf32-nm'),
                 cpu=a.cpu)
    tools['as'] = tools['as_']
    at, base = int(a.at, 16), int(a.base, 16)

    if a.cmd == 'analyze':
        insns = disasm(tools, a.bin, base, at, at + 48)
        chosen, err = pick(insns, at)
        if err:
            print('ОТКАЗ: ' + err); return 1
        body, provides = [], []
        for ins in chosen:
            head = ins['mn'].split('.')[0]
            if head == 'lp':
                print('ОТКАЗ: в вытесняемой области аппаратный цикл lp — переносить нельзя')
                print('   ' + ins['text']); return 1
            if ins['tgt'] is not None and head in BRANCH_MN:
                sym = '__hook_tgt_%08x' % ins['tgt']
                # переход переписываем ТЕКСТОМ: линкер пересчитает смещение
                body.append('\t%s %s\t/* было: %s */' % (ins['mn'], sym, ins['text']))
                provides.append('PROVIDE(%s = 0x%08x);' % (sym, ins['tgt']))
            else:
                body.append('\t.byte ' + ','.join('0x%02x' % c for c in ins['raw'])
                            + '\t/* %s */' % ins['text'])
        ret = chosen[-1]['addr'] + len(chosen[-1]['raw'])
        n = ret - at
        provides.append('PROVIDE(__hook_ret_%08x = 0x%08x);' % (at, ret))
        asm = a.out_asm or 'src/ext/hook_%08x.S' % at
        os.makedirs(os.path.dirname(asm) or '.', exist_ok=True)
        open(asm, 'w').write(
            '/* СГЕНЕРИРОВАНО tools/mkhook.py — хук на 0x%08x, вытеснено %d Б.\n'
            ' * Поток: патч в 0x%08x -> __hook_%08x -> %s() -> вытесненные\n'
            ' * инструкции -> возврат в 0x%08x. */\n'
            '\t.section .text.ext,"ax"\n\t.global __hook_%08x\n__hook_%08x:\n'
            '\t/* сохранить аргументы и blink: наш обработчик их затрёт */\n'
            '\tst.a r0,[sp,-4]\n\tst.a r1,[sp,-4]\n\tst.a r2,[sp,-4]\n\tst.a r3,[sp,-4]\n'
            '\tst.a r4,[sp,-4]\n\tst.a r5,[sp,-4]\n\tst.a r6,[sp,-4]\n\tst.a r7,[sp,-4]\n'
            '\tst.a r12,[sp,-4]\n\tst.a blink,[sp,-4]\n'
            '\tbl %s\n'
            '\tld.ab blink,[sp,4]\n\tld.ab r12,[sp,4]\n'
            '\tld.ab r7,[sp,4]\n\tld.ab r6,[sp,4]\n\tld.ab r5,[sp,4]\n\tld.ab r4,[sp,4]\n'
            '\tld.ab r3,[sp,4]\n\tld.ab r2,[sp,4]\n\tld.ab r1,[sp,4]\n\tld.ab r0,[sp,4]\n'
            '\t/* вытесненные инструкции оригинала */\n%s\n'
            '\tb __hook_ret_%08x\n'
            % (at, n, at, at, a.handler, ret, at, at, a.handler,
               '\n'.join(body), at))
        with open(a.out_ld, 'a' if os.path.exists(a.out_ld) else 'w') as f:
            if f.tell() == 0:
                f.write('/* СГЕНЕРИРОВАНО tools/mkhook.py: адреса для трамплинов */\n')
            f.write('\n'.join(sorted(set(provides))) + '\n')
        print('хук на 0x%08x: вытеснено %d Б, возврат в 0x%08x' % (at, n, ret))
        for ins in chosen:
            print('   ' + ins['text'])
        print('трамплин: %s   адреса: %s' % (asm, a.out_ld))
        return 0

    # ---- overlay: собрать патч-переход, зная адрес обработчика после линковки
    r = subprocess.run([tools['nm'], a.elf], capture_output=True, text=True, check=True)
    sym = '__hook_%08x' % at
    addr = None
    for l in r.stdout.split('\n'):
        p = l.split()
        if len(p) == 3 and p[2] == sym:
            addr = int(p[0], 16)
    if addr is None:
        print('в %s нет символа %s — сначала make ext' % (a.elf, sym)); return 1
    insns = disasm(tools, a.bin, base, at, at + 48)
    chosen, err = pick(insns, at)
    if err:
        print('ОТКАЗ: ' + err); return 1
    n = chosen[-1]['addr'] + len(chosen[-1]['raw']) - at
    with tempfile.TemporaryDirectory() as wd:
        s = os.path.join(wd, 'p.s')
        # заполняем хвост nop_s, чтобы длина совпала с вытесненной областью
        pad = (n - 4) // 2
        open(s, 'w').write('\t.section .text,"ax"\n\t.extern __h\n\tb __h\n'
                           + '\tnop_s\n' * pad)
        o, e, b = os.path.join(wd, 'p.o'), os.path.join(wd, 'p.elf'), os.path.join(wd, 'p.bin')
        subprocess.run([tools['as'], '-mcpu=' + tools['cpu'], '-o', o, s], check=True,
                       capture_output=True)
        subprocess.run([tools['ld'], '-Ttext=0x%x' % at, '--defsym', '__h=0x%x' % addr,
                        '-o', e, o], check=True, capture_output=True)
        subprocess.run([tools['objdump'].replace('objdump', 'objcopy'), '-O', 'binary', e, b],
                       check=True, capture_output=True)
        data = open(b, 'rb').read()[:n]
    out = a.out or 'build/hook_%08x.ovl' % at
    os.makedirs(os.path.dirname(out) or '.', exist_ok=True)
    open(out, 'w').write('0x%08x: %s\n' % (at, data.hex()))
    print('патч для 0x%08x -> %s (%d Б): %s' % (at, sym, len(data), data.hex()))
    print('overlay: %s   применять: wil_syms.py patch IMAGE.fw --overlay %s' % (out, out))
    return 0

if __name__ == '__main__':
    sys.exit(main())
