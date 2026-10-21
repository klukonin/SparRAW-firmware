# выполняется на .12 (sh -s): тесты путей fw после подключения STA
PHY=$(ls /sys/kernel/debug/ieee80211/ | head -1); D=/sys/kernel/debug/ieee80211/$PHY/wil6210
IF=$(iw dev | sed -n 's/.*Interface \(.*\)/\1/p' | head -1)
P(){ ping -q -c 5 -W 1 10.60.0.11 2>/dev/null | sed -n 's/.* \([0-9]*\) packets received.*/\1/p'; }
# monitor (sniffer): смена типа основного интерфейса
ip link set $IF down; iw dev $IF set type monitor; ip link set $IF up; sleep 6
echo "T14 monitor type=$(iw dev $IF info | sed -n 's/.*type //p') rx=$(cat /sys/class/net/$IF/statistics/rx_packets)"
ip link set $IF down; iw dev $IF set type managed; ip link set $IF up
# PCIe hot reset: remove/rescan, затем wifi up и подключение
echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove; sleep 2; echo 1 > /sys/bus/pci/rescan; sleep 8
wifi up >/dev/null 2>&1; i=0; while [ $i -lt 60 ]; do IF=$(iw dev | sed -n 's/.*Interface \(.*\)/\1/p' | head -1); [ -n "$IF" ] && iw dev $IF link 2>/dev/null | grep -q Connected && break; sleep 1; i=$((i+1)); done
ip addr add 10.60.0.12/24 dev $IF 2>/dev/null; sleep 2
echo "T15 pcie_rescan if=$IF connect_s=$i ping $(P)/5 fwerr=$(dmesg | grep -c 'error detected')"
echo "T16 aer $(dmesg | grep -ciE 'AER: |link down|pcie.*error')"
