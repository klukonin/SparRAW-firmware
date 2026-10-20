#!/bin/bash
# SPDX-License-Identifier: AGPL-3.0-or-later
: "${NODE_AP:?задай NODE_AP — адрес узла AP (.11)}" "${NODE_STA:?задай NODE_STA — адрес узла STA (.12)}"; export NODE_AP NODE_STA
node() { case $1 in 11) echo "$NODE_AP";; 12) echo "$NODE_STA";; *) echo "$1";; esac; }
# Держит узел под наблюдением: раз в 20 с спрашивает uptime и пишет в лог.
# Нужен, чтобы отличить нестабильность прошивки от нестабильности узла:
# «упал через N минут» имеет смысл только рядом с контрольным прогоном.
#   tools/soak.sh <узел> <минут> <файл-лога>
NODE=${1:-$NODE_AP}; MIN=${2:-12}; LOG=${3:-/tmp/soak.log}
SSH="ssh -o StrictHostKeyChecking=no -o ConnectTimeout=6"
: > "$LOG"
END=$(( $(date +%s) + MIN*60 ))
while [ "$(date +%s)" -lt "$END" ]; do
    T=$(( END - $(date +%s) ))
    if U=$(timeout 10 $SSH "root@$NODE" 'cat /proc/uptime; iw dev|grep -c phy0-' 2>/dev/null); then
        echo "$(date +%T) жив: $(echo $U|tr '\n' ' ')" >> "$LOG"
    else
        echo "$(date +%T) НЕ ОТВЕЧАЕТ (осталось ${T}с)" >> "$LOG"
    fi
    sleep 20
done
echo "наблюдение окончено" >> "$LOG"
