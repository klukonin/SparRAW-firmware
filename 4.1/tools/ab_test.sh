#!/bin/bash
# SPDX-License-Identifier: AGPL-3.0-or-later
: "${NODE_AP:?задай NODE_AP — адрес узла AP (.11)}" "${NODE_STA:?задай NODE_STA — адрес узла STA (.12)}"; export NODE_AP NODE_STA
node() { case $1 in 11) echo "$NODE_AP";; 12) echo "$NODE_STA";; *) echo "$1";; esac; }
# Прошивает узел указанным образом и держит его под наблюдением заданное
# время. Нужен, чтобы сравнивать варианты образа между собой: «упал через
# N минут» само по себе ничего не значит, значение имеет только разница с
# контрольным прогоном того же узла.
#   tools/ab_test.sh <образ> <минут> <метка>
set -u
IMG=$1; MIN=${2:-13}; TAG=${3:-$(basename "$IMG" .fw)}
NODE=${NODE:-${NODE_AP:?задай NODE_AP или NODE}}; PLUG=${PLUG:-${TAPO_AP:?задай TAPO_AP или PLUG}}
SSH="ssh -o StrictHostKeyChecking=no -o ConnectTimeout=6"
LOG="$(pwd)/build/soak-$TAG.log"
TAPO="$(pwd)/../../SparRAW-tools/host/tapo_plug.py"

up() {
    for i in $(seq 1 45); do
        sleep 8
        $SSH -o ConnectTimeout=4 "root@$NODE" true 2>/dev/null && return 0
    done
    return 1
}

echo "== $TAG: привожу узел в чувство =="
up || { python3 "$TAPO" "$PLUG" cycle 10 >/dev/null; up || { echo "узел не поднимается"; exit 1; }; }

echo "== $TAG: заливаю $IMG =="
scp -qO "$IMG" "root@$NODE:/tmp/ab.fw" || exit 1
$SSH "root@$NODE" 'cp -f /tmp/ab.fw /lib/firmware/wil6210.fw; sync; md5sum /lib/firmware/wil6210.fw
  (setsid sh -c "sleep 2; reboot" </dev/null >/dev/null 2>&1 &)'
up || { echo "после прошивки не поднялся — передёргиваю"; python3 "$TAPO" "$PLUG" cycle 10 >/dev/null; up || exit 1; }

echo "== $TAG: наблюдаю $MIN мин, лог $LOG =="
bash tools/soak.sh "$NODE" "$MIN" "$LOG"
F=$(grep -c 'НЕ ОТВЕЧАЕТ' "$LOG"); N=$(wc -l < "$LOG")
echo "== $TAG: сбоев $F из $N проб =="
grep -m1 'НЕ ОТВЕЧАЕТ' "$LOG" && echo "   (первый сбой выше)" || echo "   узел прожил весь прогон"
