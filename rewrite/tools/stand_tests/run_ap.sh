#!/bin/bash
# run_ap.sh <fw> <tag> — .12 AP (KEEP=1), с .11 (vendor STA): IE маяка/probe, станции; на .12: BA, статистика; затем .11 обратно в AP
D0=$(cd $(dirname $0) && pwd); cd $D0/../..
S="ssh -F /dev/null -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=8 -o LogLevel=ERROR"
O=${OUT:-/tmp/stand_tests}/$2; mkdir -p $O
KEEP=1 IPERF=5 tools/hwboot_ap.sh $1 60 > $O/boot.txt 2>&1
grep -E 'RESULT|^up|^down|ping replies' $O/boot.txt | tr '\n' ' '; echo
$S root@192.168.1.11 'iw dev phy0-sta0 scan dump -u 2>/dev/null' > $O/scan_dump.txt
$S root@192.168.1.11 'iw dev phy0-sta0 scan -u 2>/dev/null' > $O/scan_fresh.txt
$S root@192.168.1.12 'D=/sys/kernel/debug/ieee80211/phy0/wil6210; echo "A01 stations $(cat $D/stations | grep -c "\[")"; echo "A02 link_stats $(cat $D/link_stats 2>&1 | wc -l)"; cat $D/temp | tr "\n" " "; echo; echo "add 1 32 0" > $D/back; sleep 1; echo "A03 back_add $(cat $D/back | grep Last)"; echo "A04 mids $(cat $D/mids | tr "\n" " ")"; iw dev phy0-ap0 station dump | grep -E "Station|rx bytes|tx bytes" | tr "\n" " "; echo' > $O/ap_suite.txt 2>&1
$S root@192.168.1.12 'cat /sys/kernel/debug/ieee80211/phy0/wil6210/blob_fw_peri' > $O/peri.bin 2>/dev/null
python3 tools/hwdbg/fwlog.py $O/peri.bin > $O/fwlog.txt 2>&1
cat $O/ap_suite.txt
# восстановление .11 как AP WL60TEST (как restore в hwboot_ap.sh)
$S root@192.168.1.11 'killall iperf3 2>/dev/null; ip addr flush dev phy0-sta0 2>/dev/null; uci set wireless.default_radio0.mode=ap; uci set wireless.default_radio0.network=lan; uci set wireless.default_radio0.ssid=WL60TEST; fw4 reload; wifi down; sleep 2; wifi up radio0; sleep 5; ip addr show br-lan | grep -q 10.60.0.11 || ip addr add 10.60.0.11/24 dev br-lan; iperf3 -s -D' >/dev/null 2>&1
