#!/bin/bash
# SPDX-License-Identifier: AGPL-3.0-or-later
# logburst.sh <fw> <outdir> [n] — ребут .12 с <fw>, wifi up и n снимков blob_fw_peri подряд (~каждые
# 0.2–0.4 с) в <outdir>/pNN.bin (+ uNN.bin uc_data; при RGF=1 ещё rNN.bin rgf; EXTRA="blob …" — <blob>_NN.bin) — чтобы поймать
# журнал fw в короткий момент (кольцо 4 КБ).
FW=$1; O=$2; N=${3:-40}; mkdir -p $O
H=root@192.168.1.12; R=$(dirname "$0")/../../..
SSH="ssh -F /dev/null -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=8 -o LogLevel=ERROR"
TAPO="python3 $R/../SparRAW-tools/host/tapo_plug.py 192.168.10.105 cycle 15"
cat $FW | $SSH $H 'cat >/lib/firmware/wil6210.fw; sync'
$SSH root@192.168.1.11 'wifi down; sleep 2; wifi up' >/dev/null 2>&1
$TAPO >/dev/null 2>&1; sleep 25
for i in $(seq 60); do $SSH $H true 2>/dev/null && break; sleep 3; done
$SSH $H "echo Y > /sys/module/wil6210/parameters/no_fw_recovery; uci set wireless.radio0.disabled=0; uci set wireless.default_radio0.disabled=0;
  (wifi up radio0 >/dev/null 2>&1 &); B=/sys/kernel/debug/ieee80211/phy0/wil6210; mkdir -p /tmp/lb; rm -f /tmp/lb/*; sleep 2;
  i=10; while [ \$i -lt \$((10+$N)) ]; do cat \$B/blob_fw_peri > /tmp/lb/p\$i.bin 2>/dev/null; cat \$B/blob_uc_data > /tmp/lb/u\$i.bin 2>/dev/null; [ "${RGF:-0}" = 1 ] && cat \$B/blob_rgf > /tmp/lb/r\$i.bin 2>/dev/null; for x in ${EXTRA:-}; do cat \$B/blob_\$x > /tmp/lb/\${x}_\$i.bin 2>/dev/null; done; i=\$((i+1)); done; dmesg > /tmp/lb/dmesg.txt"
$SSH $H 'cd /tmp/lb && tar cf - .' | tar xf - -C $O
ls $O | wc -l
