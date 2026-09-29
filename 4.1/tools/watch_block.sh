#!/bin/bash
# SPDX-License-Identifier: AGPL-3.0-or-later
: "${NODE_AP:?задай NODE_AP — адрес узла AP (.11)}" "${NODE_STA:?задай NODE_STA — адрес узла STA (.12)}"; export NODE_AP NODE_STA
node() { case $1 in 11) echo "$NODE_AP";; 12) echo "$NODE_STA";; *) echo "$1";; esac; }
# Следит за тем, цел ли переписанный блок в памяти узла.
#
# Свободный хвост области кода считается свободным по косвенным признакам
# (содержимое не меняется в работе и различается между загрузками — похоже
# на неинициализированную память). Это надо проверять прямо: раз в N секунд
# снимать blob_fw_code и сверять байты блока со сборкой.
#   tools/watch_block.sh <адрес hex> <длина> <минут> <лог>
set -u
AD=${1:-0x8f3b58}; LEN=${2:-34}; MIN=${3:-15}; LOG=${4:-build/watch.log}
NODE=${NODE:-${NODE_AP:?задай NODE_AP или NODE}}
SSH="ssh -o StrictHostKeyChecking=no -o ConnectTimeout=6"
T=$(mktemp -d); trap 'rm -rf "$T"' EXIT
: > "$LOG"
END=$(( $(date +%s) + MIN*60 ))
while [ "$(date +%s)" -lt "$END" ]; do
    if $SSH "root@$NODE" 'cat /sys/kernel/debug/ieee80211/phy0/wil6210/blob_fw_code > /tmp/c.bin' 2>/dev/null \
       && scp -qO "root@$NODE:/tmp/c.bin" "$T/c.bin" 2>/dev/null; then
        U=$($SSH "root@$NODE" 'cut -d" " -f1 /proc/uptime' 2>/dev/null)
        python3 - "$T/c.bin" build/fw.bin "$AD" "$LEN" "$U" >> "$LOG" <<'PY'
import sys, time
dev, ours, ad, n, up = open(sys.argv[1],'rb').read(), open(sys.argv[2],'rb').read(), \
    int(sys.argv[3],16)-0x8c0000, int(sys.argv[4]), sys.argv[5]
blk = 'цел' if dev[ad:ad+n] == ours[ad:ad+n] else 'ИСПОРЧЕН ' + dev[ad:ad+n].hex()
whole = sum(1 for i in range(len(ours)) if dev[i] != ours[i])
print('%s up=%s блок %s; расхождений во всём сегменте %d'
      % (time.strftime('%H:%M:%S'), up, blk, whole))
PY
    else
        echo "$(date +%T) узел не отвечает" >> "$LOG"
    fi
    sleep 30
done
echo "наблюдение окончено" >> "$LOG"
