#!/bin/bash
# SPDX-License-Identifier: AGPL-3.0-or-later
: "${NODE_AP:?задай NODE_AP — адрес узла AP (.11)}" "${NODE_STA:?задай NODE_STA — адрес узла STA (.12)}"; export NODE_AP NODE_STA
node() { case $1 in 11) echo "$NODE_AP";; 12) echo "$NODE_STA";; *) echo "$1";; esac; }
# Серия передёргиваний питания с подсчётом порчи списков планировщика.
# Нужна, чтобы отличить «иногда бывает» от «бывает всегда»: одиночная
# загрузка ничего не доказывает ни в ту, ни в другую сторону.
#   tools/boot_series.sh <сколько> <лог>
set -u
N=${1:-5}; LOG=${2:-build/boots.log}
NODE=${NODE:-${NODE_AP:?задай NODE_AP или NODE}}; PLUG=${PLUG:-${TAPO_AP:?задай TAPO_AP или PLUG}}
SSH="ssh -o StrictHostKeyChecking=no -o ConnectTimeout=6"
: > "$LOG"
for k in $(seq 1 "$N"); do
    python3 ../../SparRAW-tools/host/tapo_plug.py "$PLUG" cycle 10 >/dev/null 2>&1
    up=нет
    for i in $(seq 1 40); do
        sleep 8
        $SSH -o ConnectTimeout=4 "root@$NODE" true 2>/dev/null && { up=$((i*8)); break; }
    done
    if [ "$up" = нет ]; then
        echo "$k: не поднялся" >> "$LOG"; continue
    fi
    sleep 20
    r=$($SSH "root@$NODE" 'printf "порчи=%s нагрузка=%s netcon=%s" \
          "$(dmesg|grep -c list_add)" "$(cut -d\  -f1 /proc/loadavg)" \
          "$(grep -c netcon /proc/consoles)"' 2>/dev/null)
    echo "$k: поднялся за ${up}с, $r" >> "$LOG"
done
echo "серия окончена" >> "$LOG"
