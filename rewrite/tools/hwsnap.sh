#!/bin/bash
# SPDX-License-Identifier: AGPL-3.0-or-later
# [TRAFFIC=0] hwsnap.sh <fw> <outdir> [n] — живые снимки памяти uc под трафиком (для eqcheck --vdata):
#   hwboot.sh (ребут .12) -> адреса linktest -> iperf3 в фоне -> n снимков debugfs blob_uc_data
#   (+ fw_peri, rgf) в <outdir>/sNN_*.bin с интервалом ~1 с.
FW=${1:?fw}; OUT=${2:?outdir}; N=${3:-16}
D=$(dirname "$0")
mkdir -p "$OUT"
SSH="ssh -F /dev/null -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=8 -o LogLevel=ERROR"
STA=root@192.168.1.12; AP=root@192.168.1.11
"$D/hwboot.sh" "$FW" 60 | tee "$OUT/hwboot.txt" | grep -E "FWERR|RESULT"
grep -q "RESULT: \(assoc\|data\)" "$OUT/hwboot.txt" || { echo "нет ассоциации"; exit 1; }
$SSH $AP 'sysctl -qw net.ipv4.conf.all.arp_ignore=1 net.ipv4.conf.all.arp_announce=2;
  ip addr show br-lan | grep -q 10.60.0.11 || ip addr add 10.60.0.11/24 dev br-lan;
  killall iperf3 2>/dev/null; iperf3 -s -D >/dev/null 2>&1'
$SSH $STA "sysctl -qw net.ipv4.conf.all.arp_ignore=1 net.ipv4.conf.all.arp_announce=2;
  ip addr show phy0-sta0 | grep -q 10.60.0.12 || ip addr add 10.60.0.12/24 dev phy0-sta0;
  [ ${TRAFFIC:-1} = 1 ] && { (iperf3 -c 10.60.0.11 -t 30 -b 300M --bidir >/dev/null 2>&1 &); sleep 3; };
  B=/sys/kernel/debug/ieee80211/phy0/wil6210; mkdir -p /tmp/sn; rm -f /tmp/sn/*;
  for i in \$(seq -w 1 $N); do cat \$B/blob_uc_data > /tmp/sn/s\${i}_uc_data.bin;
    cat \$B/blob_fw_peri > /tmp/sn/s\${i}_fw_peri.bin; cat \$B/blob_rgf > /tmp/sn/s\${i}_rgf.bin; sleep 1; done;
  dmesg | grep -c 'error detected' > /tmp/sn/fwerr.txt"
$SSH $STA 'cd /tmp/sn && tar cf - .' | tar xf - -C "$OUT"
echo "снимков: $(ls "$OUT"/s*_uc_data.bin | wc -l), FWERR: $(cat "$OUT/fwerr.txt")"
