#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Гибридный uc: vendor uc-бинарник, в котором выбранные функции заменены нашим C.

Каждая наша функция (секция .text.<имя> из build/uc/*.o) ставится ПО АДРЕСУ
соответствующей vendor-функции. Если не помещается в vendor-слот — на место
vendor-входа ставится `j <наша>` (8 Б), а тело кладётся в свободное место
(хвост ICCM + остатки слотов). Вызовы из нашего кода к НЕзаменённым функциям
резолвятся на vendor-адреса (--defsym). Так проверяется пофункциональная
эквивалентность: vendor fw + vendor uc с подменой части функций.

Соответствие C-имя → vendor-адрес: комментарий с адресом 0x92xxxx/0x93xxxx в
строке определения (или рядом), либо совпадение нормализованного имени.

Использование:
  uc_hybrid.py --select all|none|file:tx.c,rx.c|fn:a,b|exclude-fn:a,b  --out build/uc_hybrid.bin [--fw out.fw]
"""
import argparse, atexit, bisect, glob, json, os, re, shutil, struct, subprocess, sys, tempfile, collections

HERE = os.path.dirname(os.path.abspath(__file__))
REW = os.path.dirname(HERE)
FW = os.path.dirname(REW)
TC = (os.environ['ARC_DIR'] + '/bin') if os.environ.get('ARC_DIR') else \
    os.path.abspath(os.path.join(FW, '../../toolchain/arc_gnu_2021.03_prebuilt_elf32_le_linux_install/bin'))
OD, LD, OC, NM = (TC + '/arc-elf32-' + x for x in ('objdump', 'ld', 'objcopy', 'nm'))
VENDOR_FW = FW + '/images/openwrt/fw/wil6210_6.2.0.1000.fw'   # эталон — оригинал
BLOCKS = FW + '/6.2/src/asm/uc/blocks.json'
BASE, TOP = 0x920000, 0x940000
UCDIR = os.environ.get('UC_SRCDIR', REW + '/uc')
OBJDIR = os.environ.get('UC_OBJDIR', REW + '/build/uc')   # снимок объектов для долгой бисекции


def fresh_snapshot():
    """Снимок исходников + сборка С НУЛЯ во временный каталог (на всё время процесса).

    Правки рабочего дерева и устаревшие .o в build/ больше не влияют на прогон:
    UC_SRCDIR/UC_OBJDIR выставляются в окружение и наследуются дочерними процессами.
    Уже заданный UC_OBJDIR (снимок родителя) используется как есть."""
    global UCDIR, OBJDIR
    if os.environ.get('UC_OBJDIR'):
        return OBJDIR
    d = tempfile.mkdtemp(prefix='ucsnap.')
    atexit.register(shutil.rmtree, d, True)
    for x in ('Makefile', 'include', 'uc', 'fw'):
        (shutil.copytree if os.path.isdir(REW + '/' + x) else shutil.copy)(REW + '/' + x, d + '/' + x)
    os.makedirs(d + '/tools')
    shutil.copy(REW + '/tools/check_dccm.py', d + '/tools/')       # проверка карты DCCM (Makefile)
    r = subprocess.run(['make', '-s', '-C', d, '-j8', 'ARC_DIR=' + os.path.dirname(TC), 'build/uc.elf'],
                       capture_output=True, text=True)
    if r.returncode:
        raise SystemExit('сборка снимка не удалась:\n' + r.stdout + r.stderr)
    UCDIR = os.environ['UC_SRCDIR'] = d + '/uc'
    OBJDIR = os.environ['UC_OBJDIR'] = d + '/build/uc'
    print('снимок кода: %s' % d, file=sys.stderr)
    return OBJDIR

HEAD = struct.Struct('<HHI')
# rx_flow_handle_frame и rx_flow_step сами отправляют продолжение TXOP и возвращают 1 (uc/rx.c
# rx_txop_continue), rx_flow_run это учитывает; vendor-функции void (в r0 мусор) — по отдельности
# не менять (одна группа: выбор любой тянет все три).
PAIRS = [('rx_flow_run', 'rx_flow_handle_frame', 'rx_flow_step')]


def fw_segment(fw, addr):
    blob = open(fw, 'rb').read()
    off = 0
    while off + HEAD.size <= len(blob):
        typ, flags, size = HEAD.unpack_from(blob, off)
        p = blob[off + HEAD.size: off + HEAD.size + size]
        if typ == 2 and len(p) >= 4 and struct.unpack_from('<I', p, 0)[0] == addr:
            return p[4:]
        off += HEAD.size + size
    raise SystemExit('сегмент 0x%x не найден' % addr)


bj = json.load(open(BLOCKS))
blocks = sorted(bj['blocks'], key=lambda b: b['addr'])
VELF = FW + '/6.2/build/uc-vendor.bin.elf'


def external_mid_entries():
    """Цели переходов/вызовов из ДРУГИХ блоков в середину блока (скрытые входы)."""
    addrs = [b['addr'] for b in blocks]

    def blk(a):
        i = bisect.bisect_right(addrs, a) - 1
        return blocks[i] if i >= 0 and a < blocks[i]['addr'] + blocks[i]['size'] else None
    dis = subprocess.run([OD, '-d', VELF], capture_output=True, text=True).stdout
    res = {}
    for line in dis.splitlines():
        m = re.match(r'\s+([0-9a-f]+):\s+(?:[0-9a-f]{4}\s)+\s*(\S+)\s.*;([0-9a-f]{6})', line)
        if not m or m.group(2).startswith('lp'):
            continue
        a, t = int(m.group(1), 16), int(m.group(3), 16)
        sb, tb = blk(a), blk(t)
        if tb and sb is not tb and t != tb['addr'] and not tb['name'].startswith('__'):
            res.setdefault(t, tb['addr'])
    # абсолютные j/jl (обе проекции ICCM: 0-база и 0x92xxxx), напр. jl 0x1e2c0 -> uc_init
    for line in dis.splitlines():
        m = re.match(r'\s+([0-9a-f]+):\s+(?:[0-9a-f]{4}\s)+\s*(jl?|jl?\.\S+)\s+0x([0-9a-f]+)\b', line)
        if not m:
            continue
        a, v = int(m.group(1), 16), int(m.group(3), 16)
        for t in (v, v + 0x920000):
            sb, tb = blk(a), blk(t)
            if tb and sb is not tb and t != tb['addr'] and not tb['name'].startswith('__'):
                res.setdefault(t, tb['addr'])
    # константы-адреса кода в инструкциях (mov rX,0x92xxxx — регистрация колбэков)
    for line in dis.splitlines():
        m = re.match(r'\s+([0-9a-f]+):\s+(?:[0-9a-f]{4}\s)+\s*(mov|add|st)\S*\s+.*\b0x(9[23][0-9a-f]{4})\b', line)
        if not m:
            continue
        a, t = int(m.group(1), 16), int(m.group(3), 16)
        sb, tb = blk(a), blk(t)
        if tb and t != tb['addr'] and not tb['name'].startswith('__'):
            res.setdefault(t, tb['addr'])
    # указатели на код в vendor uc_data (таблицы из build_fw: автомат BI и одиночные слоты)
    try:
        import importlib.util
        spec = importlib.util.spec_from_file_location('bfw', os.path.join(HERE, 'build_fw.py'))
        bfw = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(bfw)
        ucd = fw_segment(VENDOR_FW, 0x940000)
        tg = [v[0] for v in bfw.UC_DATA_PTRS.values()]
        for base, n, step in bfw.SM_TABLES:
            for k in range(n):
                o = base - 0x800000 + k * step
                w = struct.unpack_from('<I', ucd, o)[0]
                tg.append(w + BASE if w < 0x20000 else w)
        for t in tg:
            tb = blk(t)
            if tb and t != tb['addr'] and not tb['name'].startswith('__'):
                res.setdefault(t, tb['addr'])
    except Exception as e:                    # noqa: BLE001
        print('WARN: указатели uc_data не учтены:', e)
    return res


MID = external_mid_entries()


def _vcb_symbols():
    import glob
    out = set()
    for f in glob.glob(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'uc', '*.c')):
        out.update(re.findall(r'VENDOR_CB\((9[23][0-9a-f]{4})\)', open(f).read()))
    return sorted('__vcb_' + x for x in out)


VCB = _vcb_symbols()
# скрытые входы, у которых есть своя C-функция (адрес в комментарии), — отдельные блоки
_split = set()
for _f in os.listdir(os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'uc')):
    if _f.endswith('.c'):
        for _c in re.findall(r'\(0x(9[23][0-9a-f]{4})\)', open(os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'uc', _f)).read()):
            _a = int(_c, 16)
            if _a in MID:
                _split.add(_a)
            else:
                # вход внутри блока, вызываемый только через указатель (uc_data/колбэк) — тоже
                # отдельный блок: иначе хвост блока считается свободным и затирается
                for _bb in blocks:
                    if _bb['addr'] < _a < _bb['addr'] + _bb['size']:
                        MID[_a] = _bb['addr']
                        _split.add(_a)
                        break
for _t in sorted(_split):
    _b = [b for b in blocks if b['addr'] <= _t < b['addr'] + b['size']][0]
    _end = _b['addr'] + _b['size']
    _b['size'] = _t - _b['addr']
    blocks.append(dict(name='%s@%x' % (_b['name'], _t), addr=_t, size=_end - _t, dir=_b['dir']))
    del MID[_t]
blocks.sort(key=lambda b: b['addr'])
FORCE_TRAMP = set(MID.values())      # блоки с оставшимися внешними средними входами
baddrs = [b['addr'] for b in blocks]
vstart = {b['addr']: b for b in blocks}


def block_of(a):
    i = bisect.bisect_right(baddrs, a) - 1
    if i >= 0 and a < blocks[i]['addr'] + blocks[i]['size']:
        return blocks[i]
    return None


def norm(s):
    return re.sub(r'_+', '_', s.lower())


def nosfx(s):
    return re.sub(r'_(9[23][0-9a-f]{4})$', '', norm(s))


vnorm = collections.defaultdict(list)
vnosfx = collections.defaultdict(list)
for b in blocks:
    vnorm[norm(b['name'])].append(b)
    vnosfx[nosfx(b['name'])].append(b)

DEFRE = re.compile(r'^(?:static\s+)?(?:inline\s+)?(?:const\s+)?(?:void|u8|u16|u32|u64|s8|s16|s32|int|unsigned|struct\s+\w+)\s+\**([A-Za-z_]\w*)\s*\(')


def c_map():
    """C-функция -> (vendor block | None, файл).

    Приоритет: (1) точное совпадение нормализованного имени с vendor-блоком;
    (2) адрес начала блока на строке определения; (3) адрес в первом комментарии
    тела вида «6.2 asm 0x...» или «/* ... (0x...)». Адреса из прочих строк НЕ
    используются — там обычно упоминаются вызываемые функции.
    """
    m = {}
    for f in sorted(os.listdir(UCDIR)):
        if not f.endswith('.c'):
            continue
        L = open(os.path.join(UCDIR, f)).read().split('\n')
        for i, l in enumerate(L):
            mm = DEFRE.match(l)
            if not mm:
                continue
            head = l.split('/*')[0].split('//')[0]
            if head.rstrip().endswith(';'):
                continue
            if '{' not in ' '.join(L[i:i + 3]):
                continue
            name = mm.group(1)
            vb = None
            mL = re.match(r'L_(9[23][0-9a-f]{4})$', name)      # адрес в имени
            if mL:
                vb = vstart.get(int(mL.group(1), 16))
            if vb is None and vnorm.get(norm(name)):
                vb = vnorm[norm(name)][0]
            if vb is None and nosfx(name) == norm(name) and len(vnosfx.get(nosfx(name), [])) == 1:
                vb = vnosfx[nosfx(name)][0]       # имя без адресного суффикса, кандидат единственный
            if vb is None:
                # (строка, шаблон): на строке определения — любой адрес;
                # в комментарии над определением и в первом комментарии тела —
                # только «6.2 asm 0x...» / «(0x...)»
                strict = r'(?:6\.2 asm |\()0x(9[23][0-9a-f]{4})\b'
                tries = [(l, r'0x(9[23][0-9a-f]{4})\b')]
                k = i - 1
                while k >= max(0, i - 4) and L[k].strip().startswith(('/*', '*')):
                    tries.append((L[k], strict))
                    k -= 1
                body = [x for x in L[i + 1:i + 4] if x.strip() not in ('{', '')]
                if body and body[0].strip().startswith('/*'):
                    tries.append((body[0], strict))
                for t, pat in tries:
                    for c in re.findall(pat, t):
                        b = vstart.get(int(c, 16))
                        if b:
                            vb = b
                            break
                    if vb:
                        break
            m.setdefault(name, (vb, f))
    # ассемблерные функции: метка «имя:» с «/* 0x9xxxxx» на той же строке
    # (или «.global имя» + такой комментарий у метки)
    for f in sorted(os.listdir(UCDIR)):
        if not f.endswith('.S'):
            continue
        for l in open(os.path.join(UCDIR, f)):
            mm = re.match(r'^(\w+):\s*/\*\s*0x(9[23][0-9a-f]{4})\b', l)
            if mm and vstart.get(int(mm.group(2), 16)):
                m.setdefault(mm.group(1), (vstart[int(mm.group(2), 16)], f))
    return m


def obj_sections():
    """секция .text.<fn> -> (obj, size)."""
    s = {}
    for o in sorted(os.listdir(OBJDIR)):
        if not o.endswith('.o'):
            continue
        p = os.path.join(OBJDIR, o)
        out = subprocess.run([OD, '-h', p], capture_output=True, text=True).stdout
        for line in out.splitlines():
            parts = line.split()
            if len(parts) >= 3 and parts[1].startswith(('.text.', '.rodata')):
                s.setdefault(parts[1], []).append((p, int(parts[2], 16)))
    return s


def undefined_refs(objs_secs):
    pass


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--select', default='all')
    ap.add_argument('--out', default=REW + '/build/uc_hybrid.bin')
    ap.add_argument('--fw', help='собрать .fw: vendor-образ с подменённым uc_code')
    ap.add_argument('--vendor-fw', default=VENDOR_FW)
    ap.add_argument('--report', default=REW + '/build/uc_hybrid.json')
    ap.add_argument('--work', default=REW + '/build/uc_hybrid', help='рабочий каталог (свой для параллельных сборок)')
    ap.add_argument('--list-only', action='store_true', help='только записать список выбранных функций в --report')
    ap.add_argument('--strict', action='store_true', help='не хватает места — ошибка (иначе функция остаётся vendor)')
    a = ap.parse_args()
    fresh_snapshot()

    cmap = c_map()
    secs = obj_sections()

    # кандидаты: C-функции с vendor-соответствием и секцией в .o
    cand = {}
    dup = collections.defaultdict(list)
    for name, (vb, f) in cmap.items():
        sec = '.text.' + name
        if vb is None or sec not in secs:
            continue
        objs = [x for x in secs[sec] if os.path.basename(x[0]) == f.replace('.c', '.o')] or secs[sec]
        cand[name] = dict(vb=vb, obj=objs[0][0], size=objs[0][1], file=f)
        dup[vb['addr']].append(name)
    # vendor-блок, который начинается безусловным переходом за свои пределы, — это
    # не функция, а вход внутрь другой (метка цикла и т. п.): замена даёт гибрид,
    # ломающий исходную функцию (ложные «виновники» бисекции). Такие не берём.
    jump_stub = set()
    asm_dir = os.path.join(REW, '..', '6.2', 'src', 'asm', 'uc')
    for f_ in glob.glob(os.path.join(asm_dir, '*', '*.S')):
        t = open(f_).read()
        m = re.search(r'@ 0x([0-9a-f]+), (\d+)', t)
        if not m:
            continue
        a0, sz = int(m.group(1), 16), int(m.group(2))
        ins = [l.strip() for l in t.split('\n') if l.startswith('\t') and not l.strip().startswith(('.', '/*'))]
        mm = re.match(r'^b(_s)? L_([0-9a-f]+)$', ins[0]) if ins else None
        if mm and not (a0 <= int(mm.group(2), 16) < a0 + sz):
            jump_stub.add(a0)
    for name in [n for n, c in cand.items() if c['vb']['addr'] in jump_stub]:
        del cand[name]
    # один vendor-блок -> одна C-функция (первая по совпадению имени, иначе первая)
    for addr, names in dup.items():
        if len(names) > 1:
            vb = vstart[addr]
            best = [n for n in names if norm(n) == norm(vb['name'])] or names[:1]
            for n in names:
                if n != best[0]:
                    cand[n]['dup_of'] = best[0]

    sel = a.select
    chosen = set()
    if sel == 'all':
        chosen = {n for n, c in cand.items() if 'dup_of' not in c}
    elif sel.startswith('file:'):
        fs = set(sel[5:].split(','))
        chosen = {n for n, c in cand.items() if c['file'] in fs and 'dup_of' not in c}
    elif sel.startswith('fn:'):
        chosen = set(sel[3:].split(',')) & set(cand)
    elif sel.startswith('exclude-fn:'):
        ex = set(sel[11:].split(','))
        chosen = {n for n, c in cand.items() if 'dup_of' not in c and n not in ex}
    elif sel.startswith('addr:'):
        lo, hi = (int(x, 16) for x in sel[5:].split('-'))
        chosen = {n for n, c in cand.items() if 'dup_of' not in c and lo <= c['vb']['addr'] < hi}
    elif sel.startswith('list:'):
        chosen = set(open(sel[5:]).read().split()) & set(cand)
    elif sel != 'none':
        sys.exit('bad --select')
    # пары, заменяемые только вместе (интерфейс между ними не vendor-совместим)
    for grp in PAIRS:
        if chosen & set(grp):
            chosen |= set(grp) & set(cand)
    if a.list_only:
        json.dump(dict(fns=sorted(chosen)), open(a.report, 'w'), indent=1)
        return

    # vendor-символы для НЕ заменённых функций (по C-именам)
    defsyms = {}
    for name, (vb, f) in cmap.items():
        if vb is not None and name not in chosen:
            defsyms[name] = vb['addr']

    # итеративно: добавить в сборку вспомогательные секции без vendor-аналога
    # (static-хелперы, libgcc millicode) — они пойдут в overflow
    work = a.work
    os.makedirs(work, exist_ok=True)
    extra = {}      # секция без vendor-аналога -> (obj, адрес)
    libgcc = subprocess.run([TC + '/arc-elf32-gcc', '-mcpu=arc600', '-print-libgcc-file-name'],
                            capture_output=True, text=True).stdout.strip()

    wdir = os.path.join(work, 'weak')
    os.makedirs(wdir, exist_ok=True)

    def weak(o):
        """Копия объекта со всеми глобальными символами weak: vendor-адреса из
        скрипта (сильные) перекрывают невыбранные C-функции."""
        w = os.path.join(wdir, os.path.basename(o))
        if not os.path.exists(w) or os.path.getmtime(w) < os.path.getmtime(o):
            subprocess.run([OC, '--weaken', o, w], check=True)
        return w

    def place_and_link(chosen, extra, overflow_plan):
        lines = ['SECTIONS {']
        for n in sorted(chosen, key=lambda n: cand[n]['vb']['addr']):
            c = cand[n]
            at = overflow_plan.get('.text.' + n, c['vb']['addr'])
            lines.append('  .text.%s 0x%x : { KEEP("%s"(.text.%s)) }' % (n, at, weak(c['obj']), n))
        for s, (o, at) in sorted(extra.items(), key=lambda x: x[1][1]):
            lines.append('  %s 0x%x : { KEEP("%s"(%s)) }' % (s, at, weak(o), s))
        lines.append('  .libgcc 0x%x : { *libgcc.a:*(.text .text.*) }' % libgcc_at[0])
        lines.append('  .rodata 0x%x : { *(.rodata .rodata.*) }' % libgcc_at[1])
        lines.append('  /DISCARD/ : { *(.comment) *(.ARC.attributes) *(.note*) *(.debug*) }')
        lines.append('}')
        # VENDOR_CB(): __vcb_<addr> = 0-базовый vendor-адрес (как хранил vendor)
        for vcb in VCB:
            lines.append('%s = 0x%x;' % (vcb, int(vcb[6:], 16) - BASE))
        for n, v in sorted(defsyms.items()):
            lines.append('%s = 0x%x;' % (n, v))
        ld = os.path.join(work, 'hy.ld')
        open(ld, 'w').write('\n'.join(lines) + '\n')
        objs = sorted({weak(cand[n]['obj']) for n in chosen} | {weak(o) for o, _ in extra.values()})
        elf = os.path.join(work, 'hy.elf')
        r = subprocess.run([LD, '-T', ld, '-o', elf, '--gc-sections', '-e', '0', '-Map', elf + '.map',
                            '--unresolved-symbols=report-all'] + objs + [libgcc],
                           capture_output=True, text=True)
        return elf, r

    # база — uc_code из эталонного .fw (оригинальный 6.2.0.1000)
    vorig = fw_segment(a.vendor_fw, BASE)
    vbin = bytearray(vorig) + b'\0' * (TOP - BASE - len(vorig))
    free = [[(BASE + len(vorig) + 3) & ~3, TOP]]   # хвост ICCM

    overflow = {}
    tramp = {}
    for n in sorted(chosen, key=lambda n: cand[n]['vb']['addr']):
        c = cand[n]
        vb = c['vb']
        if c['size'] <= vb['size'] and vb['addr'] not in FORCE_TRAMP:
            gap = vb['size'] - c['size']
            if gap >= 16:
                free.append([(vb['addr'] + c['size'] + 3) & ~3, vb['addr'] + vb['size']])
        else:
            if vb['size'] < 8:
                print('WARN: %s (%s) слот %d < 8, нельзя трамплин — пропуск' % (n, vb['name'], vb['size']))
                continue
            tramp[n] = vb['addr']
            if vb['size'] - 8 >= 16 and vb['addr'] not in FORCE_TRAMP:
                free.append([vb['addr'] + 8, vb['addr'] + vb['size']])
    chosen = {n for n in chosen if n in tramp or (cand[n]['size'] <= cand[n]['vb']['size']
                                                  and cand[n]['vb']['addr'] not in FORCE_TRAMP)}

    def alloc(size, align=4):
        free.sort(key=lambda f: f[1] - f[0])
        for f in free:
            s = (f[0] + align - 1) & ~(align - 1)
            if s + size <= f[1]:
                f[0] = s + size
                return s
        return None

    # libgcc (millicode сохранения регистров и т.п.) — явное место в свободной области;
    # выделяем ДО overflow-функций, иначе крупный набор не собирается вовсе
    libgcc_at = [alloc(0x280) if chosen else 0, alloc(0x100) if chosen else 0]
    if None in libgcc_at:
        sys.exit('нет места для libgcc')

    skipped = []
    for n in sorted(tramp, key=lambda n: -cand[n]['size']):
        at = alloc(cand[n]['size'])
        if at is None:
            if a.strict:
                sys.exit('нет места в overflow для %s (%d Б)' % (n, cand[n]['size']))
            skipped.append(n)                     # остаётся vendor-версия
            continue
        overflow['.text.' + n] = at
    for n in skipped:
        print('WARN: нет места в overflow для %s (%d Б) — оставлен vendor' % (n, cand[n]['size']))
        tramp.pop(n)
        chosen.discard(n)


    # недостающие секции: ищем по undefined
    secsz = {}
    elf = None
    for _ in range(20 if chosen else 0):
        elf, r = place_and_link(chosen, extra, overflow)
        und = sorted(set(re.findall(r"undefined reference to `([^']+)'", r.stderr)))
        placed = {'.text.' + n for n in chosen} | set(extra) | {'.libgcc', '.rodata'}
        orphans = []
        if os.path.exists(elf + '.map'):
            # секции-сироты: вход «<имя> 0xaddr 0xsize <obj>» вне явно размещённых
            mtxt = open(elf + '.map').read()
            mtxt = mtxt[mtxt.find('Linker script and memory map'):]     # без «Discarded input sections»
            for mm in re.finditer(r'^ (\.text\.\S+)\s+0x([0-9a-f]+)\s+0x([0-9a-f]+)\s+(\S+\.o)$',
                                  mtxt, re.M):
                sec, sz, obj = mm.group(1), int(mm.group(3), 16), mm.group(4)
                if sec not in placed and sz and (sec, obj) not in [(x[0], x[1]) for x in orphans]:
                    orphans.append((sec, obj, sz))
        if not und and not orphans:
            break
        for sec, wobj, sz in orphans:
            if sec in extra:
                sys.exit('одноимённые секции %s из разных объектов — не поддерживается' % sec)
            o = os.path.join(OBJDIR, os.path.basename(wobj))
            secsz[sec] = sz
            at = alloc(sz)
            if at is None:
                sys.exit('нет места для %s' % sec)
            extra[sec] = (o, at)
        if orphans:
            continue
        added = False
        for u in und:
            sec = '.text.' + u
            if sec in secs and u not in chosen and sec not in extra:
                o, sz = secs[sec][0]
                at = alloc(sz)
                if at is None:
                    sys.exit('нет места для хелпера %s' % u)
                extra[sec] = (o, at)
                added = True
        if not added:
            print('НЕРАЗРЕШЕНО:', und)
            sys.exit(1)
    if elf and r.returncode != 0:
        print(r.stderr[-3000:])
        sys.exit('ld failed')

    # отведённые интервалы для проверки раскладки
    allowed = {'.libgcc': (libgcc_at[0], libgcc_at[0] + 0x280),
               '.rodata': (libgcc_at[1], libgcc_at[1] + 0x100)}
    for n in chosen:
        c = cand[n]
        sec = '.text.' + n
        if sec in overflow:
            allowed[sec] = (overflow[sec], overflow[sec] + c['size'])
        else:
            allowed[sec] = (c['vb']['addr'], c['vb']['addr'] + c['vb']['size'])
    for sec, (o, at) in extra.items():
        allowed[sec] = (at, at + secsz.get(sec, secs[sec][0][1]))

    # наложить: тела + трамплины
    copied_end = BASE + len(vorig)
    raw = os.path.join(work, 'hy.raw')
    out = subprocess.run([OD, '-h', elf], capture_output=True, text=True).stdout if elf else ''

    for line in out.splitlines():
        p = line.split()
        if len(p) >= 4 and p[1].startswith(('.text', '.rodata', '.libgcc')) and p[1] != '.rodata' or \
           len(p) >= 4 and p[1] == '.rodata':
            sec, size, vma = p[1], int(p[2], 16), int(p[3], 16)
            if size == 0:
                continue
            if not (BASE <= vma and vma + size <= TOP):
                sys.exit('секция %s вне ICCM: 0x%x' % (sec, vma))
            lo, hi = allowed.get(sec, (None, None))
            if lo is None:
                sys.exit('секция %s без отведённого места (0x%x)' % (sec, vma))
            if not (lo <= vma and vma + size <= hi):
                sys.exit('секция %s [0x%x,0x%x) вне отведённого [0x%x,0x%x)' % (sec, vma, vma + size, lo, hi))
            subprocess.run([OC, '-O', 'binary', '--only-section=' + sec, elf, raw], check=True)
            data = open(raw, 'rb').read()
            vbin[vma - BASE:vma - BASE + len(data)] = data
            copied_end = max(copied_end, vma + len(data))
    syms = {}
    for line in (subprocess.run([NM, elf], capture_output=True, text=True).stdout if elf else '').splitlines():
        p = line.split()
        if len(p) == 3:
            syms[p[2]] = int(p[0], 16)
    for n, vaddr in tramp.items():
        tgt = syms[n] - BASE      # 0-база, как vendor-векторы (j 0x160)
        # j limm: 0x2020 0f80 + limm (middle-endian как в vendor-бинарнике)
        enc = bytes.fromhex('2020') [::-1] + bytes.fromhex('0f80')[::-1]
        limm = struct.pack('<HH', tgt >> 16, tgt & 0xffff)
        vbin[vaddr - BASE:vaddr - BASE + 8] = enc + limm

    end = (copied_end + 3) & ~3            # всё, что реально скопировано (вкл. .libgcc/.rodata)
    open(a.out, 'wb').write(bytes(vbin[:end - BASE]))
    rep = dict(chosen=len(chosen), inplace=len(chosen) - len(tramp), tramp=len(tramp),
               helpers=sorted(s for s in extra), bytes=sum(cand[n]['size'] for n in chosen))
    json.dump(dict(rep, fns=sorted(chosen), tramps=sorted(tramp)), open(a.report, 'w'), indent=1)
    print('гибрид: заменено %(chosen)d функций (на месте %(inplace)d, трамплин %(tramp)d), хелперов %(h)d, %(bytes)d Б'
          % dict(rep, h=len(extra)))

    if a.fw:
        mk_fw(a.vendor_fw, a.out, a.fw)


def mk_fw(vendor_fw, ucbin, out):
    blob = open(vendor_fw, 'rb').read()
    uc = open(ucbin, 'rb').read()
    recs, off = [], 0
    while off + HEAD.size <= len(blob):
        typ, flags, size = HEAD.unpack_from(blob, off)
        recs.append([typ, flags, bytearray(blob[off + HEAD.size: off + HEAD.size + size])])
        off += HEAD.size + size
    done = False
    for r in recs:
        if r[0] == 2 and len(r[2]) >= 4 and struct.unpack_from('<I', r[2], 0)[0] == BASE:
            p = struct.pack('<I', BASE) + uc
            if len(p) % 4:
                p += b'\0' * (4 - len(p) % 4)
            r[2] = bytearray(p)
            done = True
    assert done, 'uc_code сегмент не найден'
    import zlib
    body = bytearray()
    for typ, flags, p in recs:
        body += HEAD.pack(typ, flags, len(p)) + p
    # file header (type 6) — длина и crc как в build_fw.py
    struct.pack_into('<I', body, HEAD.size + 16, len(body))
    patched = bytearray(body)
    struct.pack_into('<I', patched, HEAD.size + 8, 0)
    struct.pack_into('<I', body, HEAD.size + 8, zlib.crc32(bytes(patched)) & 0xffffffff)
    open(out, 'wb').write(bytes(body))
    print('собран', out, len(body), 'Б')


if __name__ == '__main__':
    main()
