#!/bin/bash
# SPDX-License-Identifier: AGPL-3.0-or-later
# assocrun.sh <fw> <tag> — вход станции в записи: точка (.11) перезагрузкой на образе, захват точки (с записями
# данных, без нагрузки) CAP_S с (по умолчанию 200) начинается ДО перезагрузки станции; станция (.12) перезагрузкой
# в роль STA на том же образе — в записи её вход после загрузки: A-BFT/SLS, Probe/Association, первые кадры после
# ассоциации. Захват длинный: загрузка станции ~60–90 с, затем вход. Результат: $OUT/<tag>_11.pcap.
. "$(dirname "$0")/stand_lib.sh"
F=${1:?образ .fw}; T=${2:?метка}
CAP_S=${CAP_S:-200}
boot_ap "$F" || { echo "точка не поднялась — запись не делаю"; exit 1; }
ap_up
echo "${AP##*.} $(ver "$AP")"
cap_start "$AP" "$CAP_S" rx,tx,rxqos,txqos
t0=$(date +%s)
sleep 3
boot_sta "$F" || echo "станция: проверки не прошли (см. выше) — запись всё равно забираю"
echo "станция готова через $(( $(date +%s) - t0 )) с от начала захвата"
sta_up
$SSH "$STA" "dmesg | grep -m1 -E 'successful connection|wmi_evt_connect' | cut -c1-120; echo \"${STA##*.} \$(dmesg | sed -n 's/.*FW ver\. \([^(]*\)(.*/\1/p' | tail -1)\""
left=$(( t0 + CAP_S + 3 - $(date +%s) ))
if [ $left -gt 0 ]; then echo "жду конца захвата: $left с"; sleep $left; fi
for h in "$AP" "$STA"; do echo "${h##*.} FWERR $(fwerr "$h")"; done
cap_fetch "$AP" "$OUT/${T}_${AP##*.}.pcap"
echo "pcap: $OUT/${T}_${AP##*.}.pcap"
cd "$R/tests" && python3 - "$OUT/${T}_${AP##*.}.pcap" <<'PY'
import sys, collections
sys.path.insert(0, '.')
from ref.air_pcap import read_pcap
rs = list(read_pcap(sys.argv[1], 'ap'))
c = collections.Counter((('TX' if r.tx else 'rx'), r.kind) for r in rs)
print('kinds:', {f'{a} {k}': v for (a, k), v in sorted(c.items()) if k not in ('A-MPDU',)})
PY
