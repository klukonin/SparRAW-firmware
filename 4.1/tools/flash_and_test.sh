#!/bin/bash
# SPDX-License-Identifier: AGPL-3.0-or-later
: "${NODE_AP:?задай NODE_AP — адрес узла AP (.11)}" "${NODE_STA:?задай NODE_STA — адрес узла STA (.12)}"; export NODE_AP NODE_STA
node() { case $1 in 11) echo "$NODE_AP";; 12) echo "$NODE_STA";; *) echo "$1";; esac; }
# Прошивает узел стенда собранным образом и проверяет, что прошивка
# действительно та самая и что линк 60 ГГц работает.
#
#   tools/flash_and_test.sh [узел] [образ]
#
# Проверок три, и все три обязательны:
#   1. прошивка поднялась     — wmi_evt_ready в dmesg;
#   2. в памяти именно наш код — blob_fw_code сверяется с build/fw.bin
#      побайтово (это ловит и порчу образа, и подмену прошивки);
#   3. линк живой             — iperf3 через 60 ГГц.
set -u
NODE=${1:-$NODE_AP}
PEER=${2:-$NODE_STA}
IMG=${3:-build/wil6210-selfbuilt.fw}
SSH="ssh -o StrictHostKeyChecking=no -o ConnectTimeout=6"
T=$(mktemp -d)
trap 'rm -rf "$T"' EXIT

test -f "$IMG" || { echo "нет образа $IMG — сначала make fw"; exit 1; }
echo "== заливаю $IMG на $NODE =="
scp -qO "$IMG" "root@$NODE:/tmp/fw-new.fw" || exit 1
$SSH "root@$NODE" 'cp -f /tmp/fw-new.fw /lib/firmware/wil6210.fw && sync
  (setsid sh -c "sleep 2; reboot" </dev/null >/dev/null 2>&1 &)' || exit 1

echo "== жду загрузку =="
for i in $(seq 1 40); do
    sleep 6
    $SSH -o ConnectTimeout=4 "root@$NODE" true 2>/dev/null && { echo "поднялся через $((i*6)) с"; break; }
    [ "$i" = 40 ] && { echo "узел не поднялся — передёрни питание"; exit 1; }
done

echo "== 1. прошивка стартовала =="
# radio0 поднимаем только если он ещё не поднят: повторный wifi up на
# работающем 60 ГГц уводит узел в зависание внутри wil_reset (проверено).
$SSH "root@$NODE" 'iw dev | grep -q phy0- || wifi up radio0 2>/dev/null; sleep 12
  dmesg | grep -E "wmi_evt_ready|wil_wait_for_fw_ready" | tail -2' || exit 1

echo "== 2. код в памяти совпадает со сборкой =="
$SSH "root@$NODE" 'cat /sys/kernel/debug/ieee80211/phy0/wil6210/blob_fw_code > /tmp/code.bin'
scp -qO "root@$NODE:/tmp/code.bin" "$T/code.bin" || exit 1
python3 - "$T/code.bin" build/fw.bin <<'PY' || exit 1
import sys
dev = open(sys.argv[1], 'rb').read()
ours = open(sys.argv[2], 'rb').read()
n = len(ours)
bad = [i for i in range(n) if dev[i] != ours[i]]
if bad:
    print('   РАСХОЖДЕНИЕ: %d байт, первое по 0x%06x' % (len(bad), 0x8c0000 + bad[0]))
    sys.exit(1)
print('   совпало побайтово, %d байт' % n)
PY

echo "== 3. линк 60 ГГц =="
$SSH "root@$NODE" '(setsid iperf3 -s -D </dev/null >/dev/null 2>&1 &); sleep 1'
for i in $(seq 1 10); do
    R=$($SSH "root@$PEER" 'iperf3 -c 192.168.60.1 -t 5 -i 0 2>&1 | grep receiver' 2>/dev/null)
    [ -n "$R" ] && { echo "   $R"; exit 0; }
    sleep 6
done
echo "   линк не поднялся за минуту"
exit 1
