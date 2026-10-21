#!/bin/bash
# SPDX-License-Identifier: AGPL-3.0-or-later
# linktest.sh [ping_s] [iperf_s] — проверка радиолинка .12 (STA) ↔ .11 (AP) после hwboot.sh:
#   временные адреса 10.60.0.12 (phy0-sta0) / 10.60.0.11 (br-lan AP), без uci commit;
#   arp_ignore=1, чтобы трафик не ушёл по Ethernet; ping (стабильность) и iperf3 в обе стороны.
# Печатает: LINK ping_loss=<%> rtt=<avg> up=<Мбит/с> down=<Мбит/с> radio_tx/rx (байты станции).
P=${1:-60}; I=${2:-10}
SSH="ssh -F /dev/null -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=8 -o LogLevel=ERROR"
STA=root@192.168.1.12; AP=root@192.168.1.11
$SSH $AP 'sysctl -qw net.ipv4.conf.all.arp_ignore=1 net.ipv4.conf.all.arp_announce=2;
  ip addr show br-lan | grep -q 10.60.0.11 || ip addr add 10.60.0.11/24 dev br-lan;
  killall iperf3 2>/dev/null; iperf3 -s -D >/dev/null 2>&1'
$SSH $STA 'sysctl -qw net.ipv4.conf.all.arp_ignore=1 net.ipv4.conf.all.arp_announce=2;
  ip addr show phy0-sta0 | grep -q 10.60.0.12 || ip addr add 10.60.0.12/24 dev phy0-sta0' || exit 2
b0=$($SSH $STA "iw dev phy0-sta0 station dump | awk '/tx bytes/{t=\$3}/rx bytes/{r=\$3}END{print t+0, r+0}'")
pl=$($SSH $STA "ping -q -c $P -i 1 -W 1 10.60.0.11 2>&1 | tail -2")
loss=$(echo "$pl" | sed -n 's/.* \([0-9.]*\)% packet loss.*/\1/p'); rtt=$(echo "$pl" | sed -n 's|.*= [0-9.]*/\([0-9.]*\)/.*|\1|p')
up=$($SSH $STA "iperf3 -c 10.60.0.11 -t $I -f m 2>&1 | grep -E 'sender' | awk '{for(i=1;i<=NF;i++) if(\$i ~ /bits\/sec/) print \$(i-1)}'")
dn=$($SSH $STA "iperf3 -c 10.60.0.11 -t $I -R -f m 2>&1 | grep -E 'receiver' | awk '{for(i=1;i<=NF;i++) if(\$i ~ /bits\/sec/) print \$(i-1)}'")
b1=$($SSH $STA "iw dev phy0-sta0 station dump | awk '/tx bytes/{t=\$3}/rx bytes/{r=\$3}END{print t+0, r+0}'")
st=$($SSH $STA "iw dev phy0-sta0 link | grep -c Connected")
echo "LINK connected=$st ping_loss=${loss:-100}% rtt=${rtt:--} up=${up:-0} down=${dn:-0} radio_tx/rx: $b0 -> $b1"
