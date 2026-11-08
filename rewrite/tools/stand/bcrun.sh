#!/bin/bash
# SPDX-License-Identifier: AGPL-3.0-or-later
# bcrun.sh <fw> <tag> — как rdrun.sh, но без iperf: точка с multicast_to_unicast=0 (опция hostapd в uci без
# commit — живёт до следующей перезагрузки), захват 40 с с записями данных (низкая нагрузка), пауза,
# широковещательный ping точки (15 × 1 с) и ответы станции, затем ping по адресу; проверка TA CTS-to-self точки.
. "$(dirname "$0")/stand_lib.sh"
F=${1:?образ .fw}; T=${2:?метка}
boot_pair "$F" "uci set wireless.default_radio0.multicast_to_unicast=0"
ap_up; sta_up
$SSH "$STA" 'sysctl -qw net.ipv4.icmp_echo_ignore_broadcasts=0'
for h in "$AP" "$STA"; do echo "${h##*.} $(ver "$h")"; done
APMAC=$(mac "$AP")
for h in "$AP" "$STA"; do cap_start "$h" 40 rx,tx,rxqos,txqos; done
sleep 4
echo "AP m2u flag: $($SSH "$AP" 'cat /sys/kernel/debug/ieee80211/phy*/wil6210/multicast_to_unicast 2>/dev/null | head -1')"
SI=$($SSH "$STA" "iw dev | sed -n 's/.*Interface \(.*sta0\)/\1/p'")
RX0=$($SSH "$STA" "cat /sys/class/net/$SI/statistics/rx_packets")
BC=${AP_IP%.*}.255
echo "bcast ping: $($SSH "$AP" "ping -c 15 -i 1 -W 3 $BC 2>&1 | grep -E 'transmitted|bad|denied'")"
echo "STA rx_packets delta after bcast ping: $(( $($SSH "$STA" "cat /sys/class/net/$SI/statistics/rx_packets") - RX0 ))"
echo "unicast ping: $($SSH "$AP" "ping -c 10 -i 1 -W 3 $STA_IP 2>&1 | grep -E 'transmitted'")"
sleep 2
for h in "$AP" "$STA"; do echo "${h##*.} FWERR $(fwerr "$h")"; cap_fetch "$h" "$OUT/${T}_${h##*.}.pcap"; done
cd "$R/tests" && python3 - "$OUT/${T}_${AP##*.}.pcap" "$APMAC" <<'PY'
import sys, collections
sys.path.insert(0, '.')
from ref.air_pcap import read_pcap
ap = bytes.fromhex(sys.argv[2].replace(':', ''))
c = collections.Counter()
for r in read_pcap(sys.argv[1], 'ap'):
    if r.tx and r.kind == 'DMG CTS' and len(r.raw) >= 16 and r.raw[4:10] == ap:
        c[r.raw[10:16].hex(':')] += 1
print('AP CTS-to-self TA:', dict(c))
PY
