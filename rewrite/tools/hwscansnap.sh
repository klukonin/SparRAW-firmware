#!/bin/bash
# SPDX-License-Identifier: AGPL-3.0-or-later
# hwscansnap.sh <fw> <outdir> [wait_s] — снимки состояния в режиме СКАНА без ассоциации, чтобы
# сравнивать vendor и наш fw в одинаковых условиях: AP .11 выключен (wifi down), .12 грузит <fw>
# (ребут через Tapo), STA поднят и сканирует wait_s секунд; затем два снимка всех blob'ов
# (a_*, b_* с интервалом ~2 с: счётчики vs конфигурация) и dmesg; AP включается обратно.
FW=${1:?fw}; OUT=${2:?outdir}; W=${3:-25}
[ -s "$FW" ] || { echo "нет файла прошивки: $FW"; exit 2; }
mkdir -p "$OUT"
H=root@192.168.1.12; AP=root@192.168.1.11
SSH="ssh -F /dev/null -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=8 -o LogLevel=ERROR"
TAPO=$(dirname "$0")/../../../SparRAW-tools/host/tapo_plug.py
cat "$FW" | $SSH $H 'cat >/lib/firmware/wil6210.fw; sync' || exit 2
$SSH $AP 'wifi down' >/dev/null 2>&1
python3 "$TAPO" 192.168.10.105 cycle 15 >/dev/null 2>&1 || { echo "power-cycle failed"; exit 2; }
sleep 25
for i in $(seq 60); do $SSH $H true 2>/dev/null && break; sleep 3; done
$SSH $H "echo Y > /sys/module/wil6210/parameters/no_fw_recovery;
  uci set wireless.radio0.disabled=0; uci set wireless.default_radio0.disabled=0; wifi up radio0 >/dev/null 2>&1;
  sleep $W; B=/sys/kernel/debug/ieee80211/phy0/wil6210; mkdir -p /tmp/ss; rm -f /tmp/ss/*;
  for p in a b; do for b in rgf rgf_ext mac_rgf_ext AGC_tbl fw_data fw_peri uc_data; do cat \$B/blob_\$b > /tmp/ss/\${p}_\$b.bin; done; sleep 2; done;
  dmesg > /tmp/ss/dmesg.txt"
$SSH $H 'cd /tmp/ss && tar cf - .' | tar xf - -C "$OUT"
$SSH $AP 'wifi up; ip addr show br-lan | grep -q 10.60.0.11 || ip addr add 10.60.0.11/24 dev br-lan' >/dev/null 2>&1
echo "$OUT: $(grep -c 'cmd 0x0007' "$OUT/dmesg.txt") START_SCAN, FWERR $(grep -c 'error detected' "$OUT/dmesg.txt")"
