#!/bin/bash
# SPDX-License-Identifier: AGPL-3.0-or-later
# rdrun.sh <fw> <tag> — оба узла — итерация с образом (reboot, драйвер командой; точка .11, станция .12, node_boot.sh), счётчики uc до/после,
# захват PMC 30 с на обоих узлах + iperf вверх/вниз. Результат: $OUT/<tag>_{11,12}.pcap.
# Счётчики — слова blob_uc_data по смещениям текущего отладочного образа (BUSY_OFF, NOEVT_OFF); ANALYZE="<команда>" —
# разбор, вызывается с двумя pcap (точки и станции).
. "$(dirname "$0")/stand_lib.sh"
F=${1:?образ .fw}; T=${2:?метка}
BUSY_OFF=${BUSY_OFF:-0x10c2}; NOEVT_OFF=${NOEVT_OFF:-0x574}; DEFER_OFF=${DEFER_OFF:-0x1100}   # mac_mon_report.rx_defer_late
CNT="D=\$(ls -d /sys/kernel/debug/ieee80211/phy*/wil6210 | head -1); echo \"busy_race=\$(dd if=\$D/blob_uc_data bs=1 skip=\$(($BUSY_OFF)) count=2 2>/dev/null | hexdump -e '1/2 \"%u\"') noevt=\$(dd if=\$D/blob_uc_data bs=1 skip=\$(($NOEVT_OFF)) count=4 2>/dev/null | hexdump -e '1/4 \"%u\"') defer_late=\$(dd if=\$D/blob_uc_data bs=1 skip=\$(($DEFER_OFF)) count=4 2>/dev/null | hexdump -e '1/4 \"%u\"')\""
boot_pair "$F"
ap_up; sta_up
# PRE_AP="<команда>" — на точке после подъёма пары и до записи (напр. «sh /tmp/tdma_ctl.sh strict 1»: настройка
# прошивки живёт до её перезагрузки); PRE_AP_FILE — файл, который сначала кладётся в /tmp точки
[ -n "$PRE_AP_FILE" ] && cat "$PRE_AP_FILE" | $SSH "$AP" "cat > /tmp/$(basename "$PRE_AP_FILE")"
[ -n "$PRE_AP" ] && echo "PRE_AP: $($SSH "$AP" "$PRE_AP" 2>&1 | tail -2 | tr '\n' ' ')"
for h in "$AP" "$STA"; do echo "${h##*.} $(ver "$h") до: $($SSH "$h" "$CNT")"; done
# CAPMASK — маска захвата (CAPTURE.md 5.1); по умолчанию rx,tx,evpath: события PMC дают метки TX ответов MAC и при
# кодах 2/6 (air_pcap.restore_tx_stamps)
for h in "$AP" "$STA"; do cap_start "$h" 30 "${CAPMASK:-rx,tx,evpath}"; done
# POSTCAP="<команда>" — на обоих узлах сразу после старта записи (напр. запись регистра PMC через debugfs mem_write);
# REGDUMP="<адрес> <число слов>" — слова памяти устройства (debugfs mem_addr/mem_val) в $OUT/<tag>_<узел>.regs
[ -n "$POSTCAP" ] && for h in "$AP" "$STA"; do echo "${h##*.} POSTCAP: $($SSH "$h" "$POSTCAP" 2>&1 | tail -1)"; done
if [ -n "$REGDUMP" ]; then set -- $REGDUMP
	for h in "$AP" "$STA"; do $SSH "$h" "D=\$(ls -d /sys/kernel/debug/ieee80211/phy*/wil6210 | head -1); i=0; while [ \$i -lt $2 ]; do printf '0x%x\n' \$(($1 + 4 * i)) > \$D/mem_addr; cat \$D/mem_val; i=\$((i + 1)); done" > "$OUT/${T}_${h##*.}.regs"; done
fi
sleep 2
$SSH "$STA" "timeout 15 iperf3 -c $AP_IP -t 8 2>&1 | grep receiver; timeout 15 iperf3 -c $AP_IP -t 8 -R 2>&1 | grep receiver"
sleep 15
for h in "$AP" "$STA"; do
	echo "${h##*.} после: $($SSH "$h" "$CNT") FWERR $(fwerr "$h")"
	cap_fetch "$h" "$OUT/${T}_${h##*.}.pcap"
	# UCTRACE=1 — журнал uc (debugfs uc_trace; нужен insmod uc_trace_ms=…, напр. MODPARAMS="uc_trace_ms=100")
	# UCDATA=1 — снимок памяти данных uc (кольцо меток UC_STAMP: последние ~1,5 с)
	[ -n "$UCDATA" ] && $SSH "$h" 'cat /sys/kernel/debug/ieee80211/phy*/wil6210/blob_uc_data' > "$OUT/${T}_${h##*.}.uc_data.bin"
	[ -n "$UCTRACE" ] && $SSH "$h" 'cat /sys/kernel/debug/ieee80211/phy*/wil6210/uc_trace' > "$OUT/${T}_${h##*.}.uctrace"
done
echo "pcap: $OUT/${T}_${AP##*.}.pcap $OUT/${T}_${STA##*.}.pcap"
[ -n "$ANALYZE" ] && $ANALYZE "$OUT/${T}_${AP##*.}.pcap" "$OUT/${T}_${STA##*.}.pcap"
exit 0
