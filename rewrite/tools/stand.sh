#!/bin/bash
# SPDX-License-Identifier: AGPL-3.0-or-later
# stand.sh <fw> [nsta] [nap] — STA ×n (+linktest) и AP ×n
cd /home/evilwirelessman/Documents/WORK/60_GHZ/SparRAW/SparRAW-firmware/rewrite
F=$1; NS=${2:-3}; NA=${3:-1}
for i in $(seq $NS); do r=$(tools/hwboot.sh $F 90 2>&1 | grep -E "RESULT|FWERR|failed" | tr '\n' ' '); l=""; echo "$r" | grep -q "RESULT: data" && l=$(tools/linktest.sh 15 8 2>&1 | tail -1 | cut -c1-80); echo "STA #$i: $r $l"; done
for i in $(seq $NA); do r=$(IPERF=8 tools/hwboot_ap.sh $F 60 2>&1 | grep -E "RESULT|FWERR|ping replies|^up|^down|failed" | tr '\n' ' '); echo "AP #$i: $r"; done
