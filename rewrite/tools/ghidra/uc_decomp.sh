#!/bin/bash
# SPDX-License-Identifier: AGPL-3.0-or-later
# uc_decomp.sh <out.c> <hexaddr>... — декомпиляция функций vendor uc 6.2 в Ghidra (ARCompact).
# Проект создаётся один раз в $UC_GH_DIR (по умолчанию tools/ghidra/out, вне build/):
#   код .text uc-vendor.bin.elf @0x920000 + зеркало с 0 (0-базовые таблицы переходов),
#   данные vendor_uc_data.bin @0x800000, MMIO 0x880000.., gp=0x800528, имена из blocks.json.
set -e
OUT=${1:?out.c}; shift
HERE=$(cd "$(dirname "$0")" && pwd); REW=$(dirname "$(dirname "$HERE")")
WORK=$(dirname "$(dirname "$(dirname "$REW")")")
G=${GHIDRA:-$WORK/ghidra_12.1.3_PUBLIC}          # с установленным Processors/ARC
D=${UC_GH_DIR:-$HERE/out}
DATA=${UC_DATA:-$WORK/tools/vendor_uc_data.bin}
if [ ! -d "$D/proj/uc62.rep" ]; then
  mkdir -p "$D/proj"
  TC=$(python3 -c "import sys;sys.path.insert(0,'$REW/tools/arcemu');import cpu;print(cpu.TC)")
  ELF=$(python3 -c "import importlib.util as u;s=u.spec_from_file_location('uh','$REW/tools/uc_hybrid.py');m=u.module_from_spec(s);s.loader.exec_module(m);print(m.VELF)")
  "$TC/arc-elf32-objcopy" -O binary --only-section=.text "$ELF" "$D/uc_code.bin"
  python3 -c "import importlib.util as u;s=u.spec_from_file_location('uh','$REW/tools/uc_hybrid.py');m=u.module_from_spec(s);s.loader.exec_module(m);open('$D/names.txt','w').write(''.join('%x %s\n'%(b['addr'],b['name'].replace('__','_')) for b in m.blocks))"
  "$G/support/analyzeHeadless" "$D/proj" uc62 -import "$D/uc_code.bin" -loader BinaryLoader \
    -loader-baseAddr 0x920000 -processor "ARCompact:LE:32:default" -scriptPath "$HERE" \
    -preScript UcSetup.java "$D/names.txt" "$DATA" > "$D/import.log" 2>&1
fi
"$G/support/analyzeHeadless" "$D/proj" uc62 -process uc_code.bin -noanalysis -readOnly \
  -scriptPath "$HERE" -postScript UcDecomp.java "$(realpath -m "$OUT")" "$@" > "$D/decomp.log" 2>&1
echo "$OUT: $(grep -c '^// =====' "$OUT") функций"
