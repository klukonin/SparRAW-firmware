#!/bin/bash
# SPDX-License-Identifier: AGPL-3.0-or-later
# hwerrdump.sh <fw> <outdir> — тест через ребут .12 с no_fw_recovery=1: после
# «Firmware error detected» снимает debugfs blob_* (живая память) в <outdir>.
FW=${1:?fw}; OUT=${2:?outdir}
[ -s "$FW" ] || { echo "нет файла прошивки: $FW"; exit 2; }
mkdir -p "$OUT"
H=root@192.168.1.12
SSH="ssh -F /dev/null -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=8 -o LogLevel=ERROR"
TAPO=$(dirname "$0")/../../../SparRAW-tools/host/tapo_plug.py
cat "$FW" | $SSH $H 'cat >/lib/firmware/wil6210.fw; sync; md5sum /lib/firmware/wil6210.fw | cut -c1-12' || exit 2
$SSH root@192.168.1.11 'iw dev phy0-ap0 station del 24:18:1d:26:d4:7b; wifi down; sleep 3; wifi up' >/dev/null 2>&1
sleep 10
python3 "$TAPO" 192.168.10.105 cycle 15 >/dev/null 2>&1 || { echo "power-cycle failed"; exit 2; }
sleep 25
for i in $(seq 60); do $SSH $H true 2>/dev/null && break; sleep 3; done
$SSH $H "echo Y > /sys/module/wil6210/parameters/no_fw_recovery;
  uci set wireless.radio0.disabled=0; uci set wireless.default_radio0.disabled=0; wifi up radio0 >/dev/null 2>&1;
  for i in \$(seq ${WAIT:-40}); do sleep 1; dmesg | grep -q 'error detected' && break; done;
  sleep 2;
  D=/sys/kernel/debug/ieee80211/phy0/wil6210; mkdir -p /tmp/ed;
  for b in uc_data uc_code fw_peri fw_data rgf rgf_ext mac_rgf_ext upper; do cat \$D/blob_\$b > /tmp/ed/\$b.bin 2>/dev/null; done;
  for a in 0x857014 0x857018 0x94055c 0x940558; do echo \$a > \$D/mem_addr; cat \$D/mem_val; done > /tmp/ed/slots.txt;
  a=\$((0x940000)); while [ \$a -lt \$((0x940400)) ]; do printf '0x%x' \$a > \$D/mem_addr; cat \$D/mem_val; a=\$((a+4)); done > /tmp/ed/ring.txt;
  dmesg | grep -vE 'WMI_DBG' > /tmp/ed/dmesg.txt" 
$SSH $H 'cd /tmp/ed && tar cf - .' | tar xf - -C "$OUT"
grep -E "FW ready|error detected" "$OUT/dmesg.txt" | tail -4; cat "$OUT/slots.txt"
