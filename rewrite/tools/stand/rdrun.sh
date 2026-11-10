#!/bin/bash
# SPDX-License-Identifier: AGPL-3.0-or-later
# rdrun.sh <fw> <tag> — оба узла — итерация с образом (reboot, драйвер командой; точка .11, станция .12, node_boot.sh), счётчики uc до/после,
# захват PMC 30 с на обоих узлах + iperf вверх/вниз. Результат: $OUT/<tag>_{11,12}.pcap.
# Счётчики — слова blob_uc_data по смещениям текущего отладочного образа (BUSY_OFF, NOEVT_OFF); ANALYZE="<команда>" —
# разбор, вызывается с двумя pcap (точки и станции).
. "$(dirname "$0")/stand_lib.sh"
F=${1:?образ .fw}; T=${2:?метка}
BUSY_OFF=${BUSY_OFF:-0x10c2}; NOEVT_OFF=${NOEVT_OFF:-0x574}
CNT="D=\$(ls -d /sys/kernel/debug/ieee80211/phy*/wil6210 | head -1); echo \"busy_race=\$(dd if=\$D/blob_uc_data bs=1 skip=\$(($BUSY_OFF)) count=2 2>/dev/null | hexdump -e '1/2 \"%u\"') noevt=\$(dd if=\$D/blob_uc_data bs=1 skip=\$(($NOEVT_OFF)) count=4 2>/dev/null | hexdump -e '1/4 \"%u\"')\""
boot_pair "$F"
ap_up; sta_up
# PRE_AP="<команда>" — на точке после подъёма пары и до записи (напр. «sh /tmp/tdma_ctl.sh strict 1»: настройка
# прошивки живёт до её перезагрузки); PRE_AP_FILE — файл, который сначала кладётся в /tmp точки
[ -n "$PRE_AP_FILE" ] && cat "$PRE_AP_FILE" | $SSH "$AP" "cat > /tmp/$(basename "$PRE_AP_FILE")"
[ -n "$PRE_AP" ] && echo "PRE_AP: $($SSH "$AP" "$PRE_AP" 2>&1 | tail -2 | tr '\n' ' ')"
for h in "$AP" "$STA"; do echo "${h##*.} $(ver "$h") до: $($SSH "$h" "$CNT")"; done
for h in "$AP" "$STA"; do cap_start "$h" 30; done
sleep 2
$SSH "$STA" "timeout 15 iperf3 -c $AP_IP -t 8 2>&1 | grep receiver; timeout 15 iperf3 -c $AP_IP -t 8 -R 2>&1 | grep receiver"
sleep 15
for h in "$AP" "$STA"; do
	echo "${h##*.} после: $($SSH "$h" "$CNT") FWERR $(fwerr "$h")"
	cap_fetch "$h" "$OUT/${T}_${h##*.}.pcap"
done
echo "pcap: $OUT/${T}_${AP##*.}.pcap $OUT/${T}_${STA##*.}.pcap"
[ -n "$ANALYZE" ] && $ANALYZE "$OUT/${T}_${AP##*.}.pcap" "$OUT/${T}_${STA##*.}.pcap"
exit 0
