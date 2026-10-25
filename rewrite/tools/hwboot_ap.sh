#!/bin/bash
# SPDX-License-Identifier: AGPL-3.0-or-later
# [KEEP=1] [IPERF=10] [NORECOV=1 REC=<dir>] [SNAP=<file>] [STA_FW=<fw>|vendor] hwboot_ap.sh <fw> [timeout_s] — тест прошивки .12
#   в режиме AP (PCP); роли стенда меняются: .11 временно STA, .12 (тестируемый образ) — AP с SSID WL60RW; всё через uci без commit.
#   Прошивка станции .11: по умолчанию тот же образ <fw> (vendor STA 6.2 к точке AP по стандарту не ассоциируется:
#   ждёт PCP Association Ready = 1, а у AP это подполе зарезервировано, 9.3.4.2); STA_FW=vendor — vendor fw .11,
#   STA_FW=<файл> — свой образ. В конце .11 возвращается на vendor fw (wil6210.fw.vendor-backup), если не KEEP=1.
#   Порядок: залить fw на .12 -> .11 в STA (ищет WL60RW) -> power-cycle .12 -> AP на .12 ->
#   ждать FW ready / станцию в `iw station dump` .12 / Connected на .11 -> ping 10.60.0.11 -> 10.60.0.12
#   (+ iperf3 в обе стороны, если IPERF=<с>). Печатает RESULT: data|assoc|ready|noready.
#   Сервер iperf3 на .12 — на cpu2 (taskset 4): прерывания wil6210 на cpu0, softirq приёма ~1 Гбит/с занимает
#   его на 100 %; сервер, попавший на cpu0, давал ~740 Мбит/с вверх вместо ~1000 (стенд 2026-10-23).
#   Интерфейсы phy0-* вне зон fw4 (input REJECT) — временное nft accept на обоих.
#   В конце .11 возвращается в AP WL60TEST (как память ap11), если не KEEP=1.
FW=${1:?fw}; T=${2:-90}
[ -s "$FW" ] || { echo "нет файла прошивки: $FW"; exit 2; }
[ -s "${FW%.fw}.src" ] && echo "src: $(cat "${FW%.fw}.src")"
SSH="ssh -F /dev/null -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=8 -o LogLevel=ERROR"
AP=root@192.168.1.12; ST=root@192.168.1.11
TAPO=$(dirname "$0")/../../../SparRAW-tools/host/tapo_plug.py
# из git worktree вне дерева SparRAW: искать SparRAW-tools рядом с основной копией репозитория
[ -f "$TAPO" ] || TAPO=$(git -C "$(dirname "$0")" rev-parse --path-format=absolute --git-common-dir)/../../SparRAW-tools/host/tapo_plug.py
# ENC=psk2|sae KEY=<пароль>: шифрование на .12 (uci без commit; после power-cycle прежние правки теряются)
ENCSET=""; [ -n "$ENC" ] && ENCSET="uci set wireless.default_radio0.encryption=$ENC; uci set wireless.default_radio0.key='${KEY:-SparRAW60test}';"
STA_FW=${STA_FW:-$FW}
restore() {
  [ -n "$KEEP" ] && return
  [ "$STA_FW" != vendor ] && $SSH $ST 'cp /lib/firmware/wil6210.fw.vendor-backup /lib/firmware/wil6210.fw; sync' >/dev/null 2>&1
  # адрес phy0-sta0 переживает смену режима (тот же netdev станет phy0-ap0 — порт br-lan) — снять
  $SSH $ST 'killall iperf3 2>/dev/null; ip addr flush dev phy0-sta0 2>/dev/null; uci set wireless.default_radio0.mode=ap; uci set wireless.default_radio0.network=lan;
    uci set wireless.default_radio0.ssid=WL60TEST; fw4 reload; wifi down; sleep 2; wifi up radio0; sleep 5;
    ip addr show br-lan | grep -q 10.60.0.11 || ip addr add 10.60.0.11/24 dev br-lan; iperf3 -s -D' >/dev/null 2>&1
}
trap restore EXIT
cat "$FW" | $SSH $AP 'rm -f /tmp/snap_peri.bin; cat >/lib/firmware/wil6210.fw; sync; md5sum /lib/firmware/wil6210.fw | cut -c1-12' || exit 2
if [ "$STA_FW" != vendor ]; then
  [ -s "$STA_FW" ] || { echo "нет файла прошивки станции: $STA_FW"; exit 2; }
  cat "$STA_FW" | $SSH $ST 'cat >/lib/firmware/wil6210.fw; sync' || exit 2
fi
$SSH $ST 'killall iperf3 2>/dev/null; wifi down; sleep 2; uci set wireless.default_radio0.mode=sta; uci delete wireless.default_radio0.network;
  uci set wireless.default_radio0.ssid=WL60RW; ip addr del 10.60.0.11/24 dev br-lan; wifi up radio0' >/dev/null 2>&1
python3 "$TAPO" 192.168.10.105 cycle 15 >/dev/null 2>&1 || { echo "power-cycle failed"; exit 2; }
sleep 25
for i in $(seq 60); do $SSH $AP true 2>/dev/null && break; sleep 3; done
[ -n "$NORECOV" ] && $SSH $AP 'echo Y > /sys/module/wil6210/parameters/no_fw_recovery'
dump() {  # NORECOV=1 REC=<dir>: при FWERR — blob'ы .12 и dmesg в <dir>
  [ -n "$SNAP" ] && $SSH $AP "cat /tmp/snap_peri.bin" >"$SNAP"
  [ -n "$REC" ] || return; mkdir -p "$REC"
  $SSH $AP 'D=/sys/kernel/debug/ieee80211/phy0/wil6210; rm -rf /tmp/rec; mkdir -p /tmp/rec; dmesg >/tmp/rec/dmesg.txt
    dmesg | grep -q "error detected" && for b in rgf fw_peri fw_data uc_data mac_rgf_ext rgf_ext; do cat $D/blob_$b >/tmp/rec/$b.bin 2>/dev/null; done
    cd /tmp/rec && tar cf - .' | tar xf - -C "$REC"; }
$SSH $AP "$ENCSET uci set wireless.radio0.disabled=0; uci set wireless.default_radio0.disabled=0; uci set wireless.default_radio0.mode=ap;
  uci set wireless.default_radio0.ssid=WL60RW; wifi up radio0 >/dev/null 2>&1;
  r=noready; for i in \$(seq $((T/3))); do sleep 3;
    dmesg | grep -q 'FW ready after' && r=ready;
    iw dev phy0-ap0 info 2>/dev/null | grep -q 'type AP' && [ \$r = ready ] && r=apup;
    [ \$r = apup ] && [ ! -e /tmp/snap_peri.bin ] && { sleep 2; cat /sys/kernel/debug/ieee80211/phy0/wil6210/blob_fw_peri >/tmp/snap_peri.bin; };
    iw dev phy0-ap0 station dump 2>/dev/null | grep -q Station && { r=assoc; break; }; done;
  dmesg | grep -vE 'WMI_DBG' | grep -E 'FW ver|FW ready|Firmware|error detected|wmi_echo|Connect |Disconnect|pcp|PCP' | tail -10;
  iw dev phy0-ap0 info 2>/dev/null | grep -E 'ssid|type|channel'; iw dev phy0-ap0 station dump 2>/dev/null | grep -E 'Station|signal|bitrate';
  ip addr add 10.60.0.12/24 dev phy0-ap0 2>/dev/null; nft insert rule inet fw4 input iifname phy0-ap0 accept; sysctl -qw net.ipv4.conf.all.arp_ignore=1 net.ipv4.conf.all.arp_announce=2;
  killall iperf3 2>/dev/null; taskset 4 iperf3 -s -D 2>/dev/null || iperf3 -s -D; echo AP: \$r" | tee /dev/stderr | grep -q 'AP: assoc' || { echo RESULT: $($SSH $AP "dmesg | grep -q 'FW ready after' && echo ready || echo noready"); $SSH $AP "echo FWERR: \$(dmesg | grep -c 'error detected')"; dump; exit 1; }
$SSH $ST "sysctl -qw net.ipv4.conf.all.arp_ignore=1 net.ipv4.conf.all.arp_announce=2;
  for i in \$(seq 10); do iw dev phy0-sta0 link 2>/dev/null | grep -q Connected && break; sleep 1; done;
  iw dev phy0-sta0 link | grep -E 'Connected|SSID|signal|bitrate'; ip addr add 10.60.0.11/24 dev phy0-sta0 2>/dev/null;
  nft insert rule inet fw4 input iifname phy0-sta0 accept;
  ip neigh flush dev phy0-sta0;   # MAC AP .12 меняется между загрузками (24:/26:) — старая ARP-запись
  pr=\$(ping -q -c 15 -i 1 -W 1 10.60.0.12 2>/dev/null | sed -n 's/.* \\([0-9]*\\) packets received.*/\\1/p');
  echo \"ping replies: \${pr:-0}/15\"; r=assoc; [ \"\${pr:-0}\" -gt 0 ] && r=data;
  if [ -n '$IPERF' ] && [ \$r = data ]; then
    echo up \$(iperf3 -c 10.60.0.12 -t ${IPERF:-10} -f m 2>&1 | awk '/sender/{for(i=1;i<=NF;i++) if(\$i ~ /bits\\/sec/) print \$(i-1)}');
    echo down \$(iperf3 -c 10.60.0.12 -t ${IPERF:-10} -R -f m 2>&1 | awk '/receiver/{for(i=1;i<=NF;i++) if(\$i ~ /bits\\/sec/) print \$(i-1)}'); fi;
  echo RESULT: \$r"
$SSH $AP "sleep ${HOLD:-0}; iw dev phy0-ap0 station dump | grep -E 'Station|tx bytes|rx bytes|tx failed'; echo FWERR: \$(dmesg | grep -c 'error detected')"
dump
