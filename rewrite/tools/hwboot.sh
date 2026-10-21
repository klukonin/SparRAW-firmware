#!/bin/bash
# SPDX-License-Identifier: AGPL-3.0-or-later
# [REC=<dir> RECS=40 RECSTEP=20] hwboot.sh <fw> [timeout_s] — тест прошивки на .12 ТОЛЬКО через ребут:
#   залить /lib/firmware/wil6210.fw -> power-cycle .12 -> поднять STA (uci без commit)
#   -> ждать FW ready / ассоциацию с .11. Печатает RESULT: data|assoc|ready|noready
#   (data — после ассоциации есть ответы на ping 10.60.0.12 -> 10.60.0.11 за 15 с; счётчик rx packets
#   в простое ненадёжен: у здоровых загрузок бывает 0, у застрявших 1).
#   REC=<dir>: с wifi up RECS секунд каждые RECSTEP сотых с (~0.2 с) снимать blob_${RECBLOB:-uc_data} в <dir>/<uptime_cs>.bin (+ dmesg.txt) —
#   чтобы поймать первые секунды после ассоциации.
#   NORECOV=1: no_fw_recovery=Y; при FWERR в <REC>/err/ — blob rgf/fw_peri/uc_data/mac_rgf_ext (живое состояние).
FW=${1:?fw}; T=${2:-60}
[ -s "$FW" ] || { echo "нет файла прошивки: $FW"; exit 2; }
# наши образы собирать только tools/mkfw.sh (с нуля, с отпечатком исходников <fw>.src)
case "$FW" in *wil6210_6.2.0.1000.fw) ;; *)
  [ -s "${FW%.fw}.src" ] && echo "src: $(cat "${FW%.fw}.src")" || echo "ВНИМАНИЕ: $FW собран не через mkfw.sh (нет .src)";; esac
H=root@192.168.1.12
SSH="ssh -F /dev/null -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=8 -o LogLevel=ERROR"
TAPO=$(dirname "$0")/../../../SparRAW-tools/host/tapo_plug.py
cat "$FW" | $SSH $H 'cat >/lib/firmware/wil6210.fw; sync; md5sum /lib/firmware/wil6210.fw | cut -c1-12' || exit 2
# AP .11 может держать «зависшую» запись .12 часами и не принимать новую ассоциацию
$SSH root@192.168.1.11 'iw dev phy0-ap0 station del 24:18:1d:26:d4:7b' >/dev/null 2>&1
# ...и перестаёт слать маяки (vendor тоже не находит сеть) — перезапуск wifi AP, параллельно загрузке .12
$SSH root@192.168.1.11 'wifi down; sleep 2; wifi up; ip addr del 10.60.0.11/24 dev phy0-ap0 2>/dev/null; ip addr show br-lan | grep -q 10.60.0.11 || ip addr add 10.60.0.11/24 dev br-lan' >/dev/null 2>&1
python3 "$TAPO" 192.168.10.105 cycle 15 >/dev/null 2>&1 || { echo "power-cycle failed"; exit 2; }
sleep 25
for i in $(seq 60); do $SSH $H true 2>/dev/null && break; sleep 3; done
[ -n "$REC" ] && $SSH $H "rm -rf /tmp/rec; mkdir -p /tmp/rec; B=/sys/kernel/debug/ieee80211/phy0/wil6210;
  (end=0; nx=0; while :; do read u _ </proc/uptime; cs=\${u%.*}\${u#*.}; [ \$end = 0 ] && end=\$((cs+${RECS:-40}00));
   [ \$cs -ge \$end ] && break; [ \$cs -ge \$nx ] && { for b in ${RECBLOB:-uc_data}; do cat \$B/blob_\$b >/tmp/rec/\$cs.\$b.bin 2>/dev/null; done; nx=\$((cs+${RECSTEP:-20})); }; done; touch /tmp/rec/done) </dev/null >/dev/null 2>&1 &"
[ -n "$NORECOV" ] && $SSH $H 'echo Y > /sys/module/wil6210/parameters/no_fw_recovery'
$SSH $H "uci set wireless.radio0.disabled=0; uci set wireless.default_radio0.disabled=0; wifi up radio0 >/dev/null 2>&1;
  r=noready; for i in \$(seq $((T/3))); do sleep 3;
    dmesg | grep -q 'FW ready after' && r=ready;
    iw dev phy0-sta0 link 2>/dev/null | grep -q Connected && { r=assoc; break; }; done;
  dmesg | grep -vE 'WMI_DBG' | grep -E 'FW ver|FW ready|Firmware|error detected|wmi_echo|Connect |Disconnect' | tail -8;
  iw dev phy0-sta0 link 2>/dev/null | grep -E 'Connected|signal|bitrate';
  if [ \$r = assoc ]; then ip addr add 10.60.0.12/24 dev phy0-sta0 2>/dev/null;
    pr=\$(ping -q -c ${PINGN:-15} -i 1 -W 1 10.60.0.11 2>/dev/null | sed -n 's/.* \\([0-9]*\\) packets received.*/\\1/p');
    rx=\$(iw dev phy0-sta0 station dump 2>/dev/null | sed -n 's/.*rx packets:[[:space:]]*//p' | head -1);
    echo \"ping replies: \${pr:-0}/${PINGN:-15} rx packets: \$rx\"; [ \"\${pr:-0}\" -gt 0 ] && r=data; fi;
  sleep ${HOLD:-0}; echo FWERR: \$(dmesg | grep -c 'error detected');
  echo RESULT: \$r"
[ -n "$NORECOV" ] && [ -n "$REC" ] && $SSH $H 'dmesg | grep -q "error detected" && { D=/sys/kernel/debug/ieee80211/phy0/wil6210; mkdir -p /tmp/rec/err;
  for b in rgf fw_peri uc_data mac_rgf_ext rgf_ext; do cat $D/blob_$b > /tmp/rec/err/$b.bin 2>/dev/null; done; }'
[ -n "$REC" ] && { mkdir -p "$REC"; $SSH $H 'while [ ! -e /tmp/rec/done ]; do sleep 1; done; dmesg >/tmp/rec/dmesg.txt; cd /tmp/rec && tar cf - .' | tar xf - -C "$REC"; }
