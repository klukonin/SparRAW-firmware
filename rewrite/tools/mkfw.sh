#!/bin/bash
# SPDX-License-Identifier: AGPL-3.0-or-later
# mkfw.sh <out.fw> — образ для теста на железе, собранный С НУЛЯ:
#   чистый временный BUILD -> make -> build_fw.py (uc поверх vendor 6.2.0.1000).
#   Рядом кладёт <out>.elf (для addr2line) и <out>.src — отпечаток исходников,
#   чтобы любой результат теста можно было однозначно сопоставить с кодом.
set -e -o pipefail
OUT=${1:?out.fw}
REW=$(cd "$(dirname "$0")/.." && pwd)
export PATH=$REW/../../../toolchain/arc_gnu_2021.03_prebuilt_elf32_le_linux_install/bin:$PATH
B=$(mktemp -d "${TMPDIR:-/tmp}/mkfw.XXXXXX")
trap 'rm -rf "$B"' EXIT
make -s -C "$REW" -j8 BUILD="$B" "$B/uc.elf" 2>&1 | grep -E "error|Error" && exit 1
python3 "$REW/tools/build_fw.py" --uc-elf "$B/uc.elf" \
    --vendor "$REW/../images/openwrt/fw/wil6210_6.2.0.1000.fw" --out "$OUT" | tail -1
cp "$B/uc.elf" "${OUT%.fw}.elf"
# отпечаток: sha256 по всем исходникам uc + заголовкам + Makefile
( cd "$REW"; git rev-parse --short HEAD 2>/dev/null || echo nogit
  cat Makefile include/*.h uc/*.c uc/*.S uc/*.h uc/uc.ld | sha256sum | cut -c1-16 ) \
  | paste -sd' ' > "${OUT%.fw}.src"
echo "src: $(cat "${OUT%.fw}.src")"
