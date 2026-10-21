#!/bin/bash
# probe.sh <fw> <outdir> [wait_s] — загрузить образ, wifi up, через wait_s снять blob fw_data/fw_peri/uc_data/rgf
FW=$1; O=$2; W=${3:-12}; mkdir -p $O
R=/home/evilwirelessman/Documents/WORK/60_GHZ/SparRAW/SparRAW-firmware
H=root@192.168.1.12
SSH="ssh -F /dev/null -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=8 -o LogLevel=ERROR"
TAPO="python3 $R/../SparRAW-tools/host/tapo_plug.py 192.168.10.105 cycle 15"
alive() { for i in $(seq ${1:-40}); do $SSH $H true 2>/dev/null && return 0; sleep 3; done; return 1; }
alive 3 || { $TAPO >/dev/null 2>&1; sleep 30; alive 60 || { echo STAND-DOWN; exit 1; }; }
cat $FW | $SSH $H 'cat >/lib/firmware/wil6210.fw; sync'
$TAPO >/dev/null 2>&1; sleep 25; alive 60 || { echo STAND-DOWN; exit 1; }
timeout $((W+60)) $SSH $H "echo Y > /sys/module/wil6210/parameters/no_fw_recovery 2>/dev/null;
  uci set wireless.radio0.disabled=0; uci set wireless.default_radio0.disabled=0; (wifi up radio0 >/dev/null 2>&1 &); sleep $W;
  B=/sys/kernel/debug/ieee80211/phy0/wil6210; mkdir -p /tmp/pb; for b in fw_data fw_peri uc_data rgf; do cat \$B/blob_\$b > /tmp/pb/\$b.bin; done;
  dmesg | grep wil6210 | tail -8 > /tmp/pb/dmesg.txt" >/dev/null 2>&1
alive 5 || { echo HANG; $TAPO >/dev/null 2>&1; sleep 30; alive 60; exit 0; }
$SSH $H 'cd /tmp/pb && tar cf - .' | tar xf - -C $O; ls -la $O | awk '{print $5, $9}' | tail -5
