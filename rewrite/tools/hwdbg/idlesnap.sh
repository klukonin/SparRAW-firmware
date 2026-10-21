#!/bin/bash
# SPDX-License-Identifier: AGPL-3.0-or-later
# idlesnap.sh <fw> <outdir> — reboot .12, fw load via plain ifup (no wpa_supplicant → no scan), snapshot all blobs
FW=$1; O=$2; mkdir -p $O
H=root@192.168.1.12
SSH="ssh -F /dev/null -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=8 -o LogLevel=ERROR"
TAPO=/home/evilwirelessman/Documents/WORK/60_GHZ/SparRAW/SparRAW-tools/host/tapo_plug.py
cat $FW | $SSH $H 'cat >/lib/firmware/wil6210.fw; sync'
python3 $TAPO 192.168.10.105 cycle 15 >/dev/null 2>&1; sleep 25
for i in $(seq 60); do $SSH $H true 2>/dev/null && break; sleep 3; done
$SSH $H 'echo Y > /sys/module/wil6210/parameters/no_fw_recovery; N=$(ls /sys/class/ieee80211/phy0/device/net/ | head -1); echo dev=$N; ip link set $N up; sleep 4;
  B=/sys/kernel/debug/ieee80211/phy0/wil6210; mkdir -p /tmp/is; for b in rgf rgf_ext mac_rgf_ext fw_data fw_peri uc_data AGC_tbl; do cat $B/blob_$b > /tmp/is/$b.bin; done; dmesg > /tmp/is/dmesg.txt'
$SSH $H 'cd /tmp/is && tar cf - .' | tar xf - -C $O
echo "$O: scans=$(grep -c 'cmd 0x0007' $O/dmesg.txt) ready=$(grep -c 'FW ready' $O/dmesg.txt) err=$(grep -c 'error detected' $O/dmesg.txt)"
