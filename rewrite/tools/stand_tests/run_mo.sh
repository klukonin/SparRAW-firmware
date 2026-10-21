#!/bin/bash
D0=$(cd $(dirname $0) && pwd); cd $D0/../..
S="ssh -F /dev/null -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=8 -o LogLevel=ERROR"
O=${OUT:-/tmp/stand_tests}/mo_$2; rm -rf $O; mkdir -p $O
tools/hwboot.sh $1 90 > $O/boot.txt 2>&1; grep -o 'RESULT: [a-z]*' $O/boot.txt
timeout 120 $S root@192.168.1.12 'sh -s' < $(dirname $0)/mo.sh
mkdir -p $O/rec; $S root@192.168.1.12 'cd /tmp/mo && tar cf - *.bin' | tar xf - -C $O/rec; for f in $O/rec/*.bin; do python3 tools/hwdbg/fwlog.py $f 2>/dev/null; done | awk '{print $2" "$0}' | sort -u | cut -d' ' -f2- > $O/fwlog.txt
grep -iE 'multi|omni|CONNECT_CMD|connect\(\)|WMI_CONNECT|0xa04|directed' $O/fwlog.txt | cut -c19-150 | tail -14
