#!/bin/bash
D0=$(cd $(dirname $0) && pwd); cd $D0/../..
S="ssh -F /dev/null -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=8 -o LogLevel=ERROR"
O=${OUT:-/tmp/stand_tests}/$2; rm -rf $O; mkdir -p $O
tools/hwboot.sh $1 90 > $O/boot.txt 2>&1; grep -o 'RESULT: [a-z]*' $O/boot.txt
timeout 200 $S root@192.168.1.12 'sh -s' < $(dirname $0)/sta_a.sh > $O/suite.txt 2>&1
$S root@192.168.1.12 'cat /sys/kernel/debug/ieee80211/phy0/wil6210/blob_fw_peri' > $O/peri.bin 2>/dev/null
python3 tools/hwdbg/fwlog.py $O/peri.bin > $O/fwlog.txt 2>&1
timeout 400 $S root@192.168.1.12 'sh -s' < $(dirname $0)/sta_b.sh >> $O/suite.txt 2>&1; echo "partB rc=$?" >> $O/suite.txt
$S root@192.168.1.12 'dmesg' > $O/dmesg.txt 2>/dev/null
cat $O/suite.txt
