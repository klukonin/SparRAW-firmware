# SPDX-License-Identifier: AGPL-3.0-or-later
"""Отчёт расхождений по эфиру (этап 2, rewrite/docs/ARCHITECTURE.md): сценарий (diff_scenario) исполняют ядро в
идеальной среде и прошивка в эмуляторе Sparrow (tests/unit/fw_scenario), журналы сравнивает diff_compare.

    cd rewrite/tests
    python3 -m ref.core.diff_report --scenario sls-1sta --build <каталог сборки с fw.elf и uc.elf>
    python3 -m ref.core.diff_report --scenario all --build <dir> --out-dir <dir>   # текст + JSON на каждый сценарий
    python3 -m ref.core.diff_report --scenario sls-1sta --against core            # ядро против ядра (без прошивки)
    python3 -m ref.core.diff_report --list

Этап 3 (адаптер Sparrow, tests/unit/adapter_sparrow.py) — режимы --against:
    core-sparrow   ядро на адаптере Sparrow против ядра в идеальной среде: где железо/модель MAC (точки разгрузки,
                   допущения H-*) расходятся со стандартом; прошивка не нужна;
    fw-sparrow     прошивка против ядра на адаптере Sparrow: где прошивка расходится со стандартом при том же железе
                   (нарушения модели MAC у обеих сторон — «модель MAC эмулятора»);
    mixed-ap       смешанная пара «точка-ядро + станция-прошивка» против ядра в идеальной среде;
    mixed-sta      смешанная пара «точка-прошивка + станция-ядро» против ядра в идеальной среде.

Сравнитель — не ядро: эмулятор и мост (tests/unit) он подключает лениво, внутри функций (unit_modules), поэтому
импорт модулей ref.core по-прежнему не тянет tests/unit (test_core_boundary). Прошивку в эмуляторе выгоднее гонять под
PyPy (tests/unit/README.md)."""
import argparse
import json
import os
import shutil
import sys
from dataclasses import asdict

from . import diff_compare as DC
from .diff_scenario import SCENARIOS, run_core

HERE = os.path.dirname(os.path.abspath(__file__))
UNIT = os.path.abspath(os.path.join(HERE, '..', '..', 'unit'))
REWRITE = os.path.abspath(os.path.join(HERE, '..', '..', '..'))


def _toolchain():
    """ARC_DIR для эмулятора (tools/arcemu берёт objdump оттуда) — как tests/unit/conftest."""
    if os.environ.get('ARC_DIR'):
        return os.environ['ARC_DIR']
    d = os.path.join(REWRITE, '..', 'toolchain', 'arc_gnu_2021.03_prebuilt_elf32_le_linux_install')
    if os.path.exists(os.path.join(d, 'bin', 'arc-elf32-gcc')):
        return os.path.abspath(d)
    g = shutil.which('arc-elf32-gcc')
    return os.path.dirname(os.path.dirname(g)) if g else None


def unit_modules(fw=False):
    """Мост эмулятора (ref_bridge2) и, при fw=True, исполнитель сценария на прошивке (fw_scenario) из tests/unit."""
    if UNIT not in sys.path:
        sys.path.insert(0, UNIT)
    import importlib
    RB = importlib.import_module('ref_bridge2')
    if not fw:
        return RB, None
    tc = _toolchain()
    if tc:
        os.environ['ARC_DIR'] = tc
    return RB, importlib.import_module('fw_scenario')


def sparrow_module():
    """Сценарий с ядром на адаптере Sparrow (tests/unit/sparrow_scenario) — лениво, как unit_modules."""
    unit_modules()
    import importlib
    return importlib.import_module('sparrow_scenario')


MODES = ('fw', 'core', 'core-sparrow', 'fw-sparrow', 'mixed-ap', 'mixed-sta')
NEED_FW = ('fw', 'fw-sparrow', 'mixed-ap', 'mixed-sta')


# =====================================================================================================================
def core_side(scn, RB, label='ядро'):
    from .scenario import AP_ADDR
    b = run_core(scn)
    j = b.journal
    side = DC.Side(label, j.to_air(AP_ADDR), j.to_snapshot(AP_ADDR, scn.bi_tu), AP_ADDR, scn.bi_tu, RB=RB,
                   meta=dict(done=b.done_ok, frames=len(j), end_us=float(b.sim.now)))
    side.bss = b
    return side


def fw_side(scn, build, RB, FS, label='прошивка', save=None):
    r = FS.run_cfg(scn, build)
    if save:
        import pickle
        with open(save, 'wb') as f:
            pickle.dump(dict(snapshot=r.snapshot, notes=list(r.notes)), f)
    return fw_side_from(scn, r.snapshot, RB, FS, label, meta=dict(
        notes=list(r.notes), marks_us={k: v / 165 for k, v in r.marks.items()}, frames=len(r.snapshot['frames']),
        late=[str(x) for x in getattr(r, 'late', [])]))


def fw_side_from(scn, snap, RB, FS, label='прошивка', meta=None):
    """Сторона прошивки по готовому снимку (ref_bridge2.snapshot)."""
    from .. import fields as F
    ap = bytes(FS.F.AP_MAC)
    names = {ap: 'AP'}
    stas = [m for m in snap['nodes'] if bytes(m) != ap]
    for i, m in enumerate(stas):
        names[bytes(m)] = 'STA' if len(stas) == 1 else f'STA{i + 1}'
    air = DC.snapshot_air(snap, ap, names)
    return DC.Side(label, air, snap, F.mac_str(ap), scn.bi_tu, RB=RB, emulator=True, meta=meta or {})


def _names(snap, ap):
    names = {ap: 'AP'}
    stas = [m for m in snap['nodes'] if bytes(m) != ap]
    for i, m in enumerate(stas):
        names[bytes(m)] = 'STA' if len(stas) == 1 else f'STA{i + 1}'
    return names


def sparrow_side_from(scn, r, RB, label, impl, core_nodes=()):
    """Сторона по прогону sparrow_scenario (ядро на адаптере или смешанная пара): снимок → Air, модель MAC — у всех
    узлов (emulator=True)."""
    from .. import fields as F
    SS = sparrow_module()
    ap = bytes(SS.F.AP_MAC)
    snap = r.snapshot
    air = DC.snapshot_air(snap, ap, _names(snap, ap))
    meta = dict(done=r.done, notes=list(r.notes), frames=len(snap['frames']))
    if getattr(r, 'delivered', None):
        meta['delivered'] = r.delivered
    side = DC.Side(label, air, snap, F.mac_str(ap), scn.bi_tu, RB=RB, emulator=True, meta=meta, impl=impl,
                   core_nodes=core_nodes)
    if impl == 'mixed':
        from collections import Counter
        by = Counter(side.evs[v.idx].tx_node for v in side.viol if 0 <= v.idx < len(side.evs))
        meta['нарушения судей по передатчику'] = {f'{n}({"ядро" if n in core_nodes else "прошивка"})': k
                                                  for n, k in sorted(by.items())}
    side.run = r
    return side


def core_sparrow_side(scn, RB, label='ядро-Sparrow'):
    return sparrow_side_from(scn, sparrow_module().run_core(scn), RB, label, 'core')


def mixed_side(scn, role, build, RB, preset='core'):
    """Смешанная пара по сценарию: role 'ap' — точка-ядро, 'sta' — станция-ядро; preset — набор выбора реализации
    ядра (sparrow_scenario.PRESETS: 'core' — как в идеальной среде, 'compat' — ближе к узлам прошивки)."""
    SS = sparrow_module()
    r = SS.run_mixed_cfg(scn, role, build, **SS.PRESETS[preset])
    label = ('пара точка-ядро' if role == 'ap' else 'пара станция-ядро') + ('' if preset == 'core' else f' ({preset})')
    side = sparrow_side_from(scn, r, RB, label, 'mixed', core_nodes=('AP',) if role == 'ap' else ('STA',))
    side.meta['preset'] = preset
    return side


def compare_sides(scn, A, B):
    return run_notes(A) + DC.compare(A, B, scn.n_sta)


def run_notes(A):
    """Замечания прогона прошивки (fw_scenario.Run.notes) — аспект «прогон»: срыв эмуляции (uc_assert узла под моделью
    MAC/эфира — модель или uc, решает стенд) и недоставленные данные — «неопределённо»; сравнение идёт по журналу до
    этой точки."""
    return [DC.Diff('прогон', n, n, '—', DC.UNDEF, '', 'эмулятор не дошёл до конца сценария — сравнение по журналу до '
                    'срыва' if n.startswith('эмулятор') else 'итог прогона прошивки') for n in A.meta.get('notes', ())]


def core_vs_core(scn, RB, seed=None):
    """Ядро против ядра (интеграция: 0 расхождений) — сторона A с тем же или другим seed."""
    A = core_side(scn if seed is None else scn.with_(seed=seed), RB, 'ядро-A')
    B = core_side(scn, RB, 'ядро-B')
    return A, B, compare_sides(scn, A, B)


# =====================================================================================================================
def to_json(scn, A, B, diffs):
    s = asdict(scn)
    s['edca'] = {str(k): v for k, v in scn.edca.items()}
    return dict(scenario=s, limits=scn.limits(), sides={A.label: A.meta, B.label: B.meta},
                summary=DC.summary(diffs), diffs=[d.as_dict() for d in diffs])


def _fmt(v):
    if isinstance(v, dict) and set(v) >= {'min', 'median', 'max'}:
        return f'min {float(v["min"]):.3f} / медиана {float(v["median"]):.3f} / max {float(v["max"]):.3f} (n={v["n"]})'
    s = str(DC._jsonable(v))
    return s if len(s) <= 240 else s[:237] + '…'


def to_text(scn, A, B, diffs, examples=2):
    L = [f'=== Сценарий {scn.name}: {scn.title} ===',
         f'параметры: станций {scn.n_sta}, BF {scn.bf}, BI {scn.bi_tu} TU, вверх {scn.ul_bytes} Б, '
         f'вниз {scn.dl_bytes} Б, '
         f'MSDU {scn.msdu_len} Б, секторы {scn.ap_sectors}/{scn.sta_sectors}, A-BFT {scn.abft_slots}×{scn.fss}, '
         f'TXOP AC_BE {scn.txop_be_us} мкс, seed {scn.seed}',
         'ограничения сценария:'] + [f'  - {x}' for x in scn.limits()]
    for S in (A, B):
        L.append(f'{S.label}: ' + ', '.join(f'{k}={v}' for k, v in S.meta.items()))
        for n in getattr(S, 'judge_notes', [])[:5]:
            L.append(f'  судья: {n}')
    sm = DC.summary(diffs)
    L.append('сводка: ' + '; '.join(f'{c}: {n}' for c, n in sm.items()))
    for c in DC.CLASSES:
        ds = [d for d in diffs if d.cls == c]
        if not ds:
            continue
        L.append('')
        L.append(f'--- {c} ({len(ds)}) ---')
        for d in sorted(ds, key=lambda d: (DC.ASPECTS.index(d.aspect), d.key)):
            L.append(f'[{d.aspect}] {d.key}' + (f'  ({d.clause})' if d.clause else ''))
            L.append(f'    {A.label}: {_fmt(d.a)}')
            L.append(f'    {B.label}: {_fmt(d.b)}')
            if d.why:
                L.append(f'    почему: {d.why}')
            if d.hyp:
                L.append(f'    допущение/разгрузка: {d.hyp}')
            for side, where, msg in d.examples[:examples * 2]:
                L.append(f'    пример ({side}): {where}' + (f' — {msg}' if msg else ''))
    return '\n'.join(L)


def run_scenario(name, build=None, against='fw', RB=None, FS=None, save=None, load=None, preset='core'):
    """Сценарий name: сторона A — прошивка (build; load — готовый снимок pickle от --save-snapshot), ядро, ядро на
    адаптере Sparrow или смешанная пара; сторона B — ядро в идеальной среде (fw-sparrow: ядро на адаптере Sparrow).
    Смешанные пары — только сценарии с одной станцией (иначе None)."""
    scn = SCENARIOS[name]
    if RB is None:
        RB, FS = unit_modules(fw=(against in NEED_FW))
    if against.startswith('mixed') and scn.n_sta != 1:
        return None
    if against == 'fw-sparrow':
        B = core_sparrow_side(scn, RB)
    else:
        B = core_side(scn, RB)
    if against == 'core':
        A = core_side(scn, RB, 'ядро-A')
    elif against == 'core-sparrow':
        A = core_sparrow_side(scn, RB)
    elif against in ('mixed-ap', 'mixed-sta'):
        A = mixed_side(scn, against.split('-')[1], build, RB, preset)
    elif load:
        import pickle
        with open(load, 'rb') as f:
            d = pickle.load(f)
        A = fw_side_from(scn, d['snapshot'], RB, FS, meta=dict(notes=d.get('notes', []), snapshot=load,
                                                               frames=len(d['snapshot']['frames'])))
    else:
        A = fw_side(scn, build, RB, FS, save=save)
    return scn, A, B, compare_sides(scn, A, B)


def main(argv=None):
    ap = argparse.ArgumentParser(description='Отчёт расхождений по эфиру: прошивка в эмуляторе против ядра DMG MAC')
    ap.add_argument('--scenario', default='sls-1sta', help='имя сценария или all')
    ap.add_argument('--build', help='каталог сборки (fw.elf, uc.elf); по умолчанию SPARRAW_UNIT_BUILD')
    ap.add_argument('--against', choices=MODES, default='fw',
                    help='fw — прошивка против ядра; core — ядро против ядра; core-sparrow — ядро на Sparrow против '
                         'ядра; fw-sparrow — прошивка против ядра на Sparrow; mixed-ap/mixed-sta — смешанная пара '
                         'против ядра')
    ap.add_argument('--mixed-preset', choices=('core', 'compat'), default='core',
                    help='смешанная пара: выбор реализации ядра — как в идеальной среде (core) или ближе к узлам '
                         'прошивки (compat: пауза SME, кадры управления на MCS 0, ответ через 4,95 мкс)')
    ap.add_argument('--json', help='файл JSON (для одного сценария)')
    ap.add_argument('--out-dir', help='каталог: <сценарий>.txt и <сценарий>.json')
    ap.add_argument('--examples', type=int, default=2)
    ap.add_argument('--save-snapshot', help='сохранить снимок эфира прошивки (pickle; с --out-dir — <сценарий>.pkl)',
                    action='store_true')
    ap.add_argument('--load-snapshot', help='каталог/файл снимков прошивки (<сценарий>.pkl) вместо прогона эмулятора')
    ap.add_argument('--list', action='store_true')
    a = ap.parse_args(argv)
    if a.list:
        for s in SCENARIOS.values():
            print(f'{s.name:16} {s.title}')
        return 0
    names = list(SCENARIOS) if a.scenario == 'all' else [a.scenario]
    build = a.build or os.environ.get('SPARRAW_UNIT_BUILD')
    if a.against in NEED_FW and not build and not a.load_snapshot:
        ap.error('нужен --build (или SPARRAW_UNIT_BUILD) с fw.elf и uc.elf')
    RB, FS = unit_modules(fw=(a.against in NEED_FW))
    total, allj = {}, {}
    for n in names:
        save = os.path.join(a.out_dir or '.', n + '.pkl') if a.save_snapshot else None
        load = a.load_snapshot
        if load and os.path.isdir(load):
            load = os.path.join(load, n + '.pkl')
        res = run_scenario(n, build, a.against, RB, FS, save=save, load=load, preset=a.mixed_preset)
        if res is None:
            print(f'=== Сценарий {n}: пропущен (смешанная пара — одна станция) ===\n')
            continue
        scn, A, B, diffs = res
        txt = to_text(scn, A, B, diffs, a.examples)
        js = to_json(scn, A, B, diffs)
        print(txt)
        print()
        if a.out_dir:
            os.makedirs(a.out_dir, exist_ok=True)
            open(os.path.join(a.out_dir, n + '.txt'), 'w').write(txt + '\n')
            json.dump(js, open(os.path.join(a.out_dir, n + '.json'), 'w'), ensure_ascii=False, indent=1)
        if a.json and len(names) == 1:
            json.dump(js, open(a.json, 'w'), ensure_ascii=False, indent=1)
        total[n] = js['summary']
        allj[n] = js
    if len(names) > 1:
        txt = cross_summary(total, allj)
        print(txt)
        if a.out_dir:
            open(os.path.join(a.out_dir, 'SUMMARY.txt'), 'w').write(txt + '\n')
    return 0


def cross_summary(total, allj):
    """Итог по сценариям: счёт по классам и уникальные расхождения (класс, аспект, ключ) → сценарии."""
    L = ['=== Итог по сценариям ===']
    for n, sm in total.items():
        L.append(f'{n:16} ' + '; '.join(f'{c}: {k}' for c, k in sm.items()))
    agg = {}
    for n, js in allj.items():
        for d in js['diffs']:
            agg.setdefault((d['cls'], d['aspect'], d['key']), []).append(n)
    for c in DC.CLASSES:
        ks = sorted((k for k in agg if k[0] == c), key=lambda k: (DC.ASPECTS.index(k[1]), k[2]))
        L.append('')
        L.append(f'--- {c}: {len(ks)} уникальных ---')
        for k in ks:
            L.append(f'  [{k[1]}] {k[2]} — {", ".join(agg[k])}')
    return '\n'.join(L)


if __name__ == '__main__':
    sys.exit(main())
