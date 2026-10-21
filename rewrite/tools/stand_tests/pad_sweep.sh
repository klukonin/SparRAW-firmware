#!/bin/bash
# SPDX-License-Identifier: AGPL-3.0-or-later
# pad_sweep.sh <site> <K,K,...> <sta|ap> [N] — запас пути в инструкциях (uc/dbg.h UC_PAD):
#   для каждого K собрать образ (fw + uc, K=0 — рабочая сборка) и N кругов прогнать сценарий,
#   чередуя K внутри круга (стенд нестабилен — судить только по сериям вперемешку).
#   sta: hwboot.sh (.12 STA) + linktest (ping 15 с, iperf3 IPERF_S=20 с в обе стороны);
#   ap:  hwboot_ap.sh (.12 AP) с IPERF=IPERF_S.
#   Строка на прогон: K, RESULT, FWERR, ping/iperf, коды assert uc из dmesg.
#   Окружение: ENC/KEY — как у hwboot.sh; OUT — каталог образов и журналов (по умолчанию /tmp/pad_sweep).
set -u
SITE=${1:?site}; KS=${2:?K-list}; SC=${3:?sta|ap}; N=${4:-3}
REW=$(cd "$(dirname "$0")/../.." && pwd)
ARC=${ARC_DIR:-$REW/../../toolchain/arc_gnu_2021.03_prebuilt_elf32_le_linux_install}
[ -d "$ARC" ] || ARC=$(git -C "$REW" rev-parse --path-format=absolute --git-common-dir)/../../../toolchain/arc_gnu_2021.03_prebuilt_elf32_le_linux_install
OUT=${OUT:-/tmp/pad_sweep}; mkdir -p "$OUT"
SSH="ssh -F /dev/null -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=8 -o LogLevel=ERROR"
img() {  # $1 = K → путь к образу
  local k=$1 f="$OUT/pad_${SITE}_$1.fw" b="$OUT/build_${SITE}_$1" d=""
  [ "$k" != 0 ] && d="-DUC_PAD_SITE=$SITE -DUC_PAD_K=$k"
  if [ ! -s "$f" ]; then
    rm -rf "$b"
    make -s -C "$REW" -j16 ARC_DIR="$ARC" BUILD="$b" UC_DBG="$d" >/dev/null 2>"$b.err" || { cat "$b.err" >&2; return 1; }
    python3 "$REW/tools/build_fw.py" --elf "$b/fw.elf" --uc-elf "$b/uc.elf" \
      --vendor "$REW/../images/openwrt/fw/wil6210_6.2.0.1000.fw" --out "$f" \
      --objcopy "$ARC/bin/arc-elf32-objcopy" >/dev/null || return 1
  fi
  echo "$f"
}
for k in ${KS//,/ }; do img "$k" >/dev/null || exit 1; done
echo "# site=$SITE K=$KS sc=$SC N=$N ENC=${ENC:-none} $(date +%F_%T)"
for i in $(seq "$N"); do
  for k in ${KS//,/ }; do
    f=$(img "$k")
    if [ "$SC" = sta ]; then
      r=$("$REW/tools/hwboot.sh" "$f" 90 2>&1 | grep -E "RESULT|FWERR|failed" | tr '\n' ' ')
      l=""; echo "$r" | grep -q "RESULT: data" && l=$("$REW/tools/linktest.sh" 15 ${IPERF_S:-20} 2>&1 | tail -1 | sed 's/ radio_tx.*//')
      h=root@192.168.1.12
    else
      r=$(IPERF=${IPERF_S:-20} "$REW/tools/hwboot_ap.sh" "$f" 60 2>&1 | grep -E "RESULT|FWERR|ping replies|^up|^down|failed" | tr '\n' ' ')
      l=""; h=root@192.168.1.12
    fi
    a=$($SSH $h "dmesg | grep -oE 'error detected.*|ucode assert.*|uc_assert.*|0x00000026|0x00006000' | sort | uniq -c | head -3" 2>/dev/null | tr '\n' ' ')
    $SSH $h dmesg > "$OUT/dmesg_${SITE}_${k}_$i.txt" 2>/dev/null
    echo "K=$k #$i: $r $l ${a:+| $a}"
  done
done
