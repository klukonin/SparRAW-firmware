# SPDX-License-Identifier: AGPL-3.0-or-later
# shellcheck shell=bash
# shellcheck disable=SC2034,SC2016
# stand_lib.sh — общее для ручных записей на стенде (rdrun.sh, bcrun.sh, assocrun.sh; подключается через «.»).
# Узлы — node_boot.sh (docs/STAND.md): reboot -f, затем драйвер командой с прошивкой итерации (tmpfs, роль без commit,
# network reload до insmod, insmod, network.wireless up). Однократно на каждом узле: node_boot.sh --install <host>.
# После загрузки — адреса 10.60.0.x, sysctl, iperf3 -s: обычные команды.
#
# Переменные (со значениями по умолчанию):
#   AP=root@192.168.1.11  STA=root@192.168.1.12  SSID=WL60TEST  STA_NET=wl60  AP_IP=10.60.0.11  STA_IP=10.60.0.12
#   BRD_MD5=e17714311e27  — ожидаемый md5 платы (префикс) на обоих узлах; пусто — не проверять
#   TAPO_AP / TAPO_STA    — адрес розетки: node_boot.sh снимет питание (один раз), если узел не поднялся после reboot
#   MODPARAMS=""          — параметры insmod обоих узлов через пробел (напр. "no_fw_recovery=Y fw_log_level=7")
#   IRQ_CPU=2             — маска CPU прерываний wil6210 станции; OUT=./standout — каталог результатов
D0=$(cd "$(dirname "$0")" && pwd)
R=$(cd "$D0/../.." && pwd)                       # rewrite/
SSH="ssh -F /dev/null -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=ERROR -o ConnectTimeout=4"
AP=${AP:-root@192.168.1.11}
STA=${STA:-root@192.168.1.12}
SSID=${SSID:-WL60TEST}
STA_NET=${STA_NET:-wl60}
AP_IP=${AP_IP:-10.60.0.11}
STA_IP=${STA_IP:-10.60.0.12}
IRQ_CPU=${IRQ_CPU:-2}
BRD_MD5=${BRD_MD5-e17714311e27}
export BRD_MD5
OUT=${OUT:-$PWD/standout}
mkdir -p "$OUT"
MP=()
for p in $MODPARAMS; do MP+=(--modparam "$p"); done

# boot_ap <fw> [аргументы node_boot.sh…] / boot_sta <fw> [аргументы…] — итерация (reboot, драйвер командой); код node_boot.sh
boot_ap() {
	local fw=$1; shift
	"$D0/node_boot.sh" "$AP" --role ap --ssid "$SSID" --fw "$fw" "${MP[@]}" ${TAPO_AP:+--tapo "$TAPO_AP"} "$@"
}
boot_sta() {
	local fw=$1; shift
	"$D0/node_boot.sh" "$STA" --role sta --ssid "$SSID" --network "$STA_NET" --fw "$fw" "${MP[@]}" ${TAPO_STA:+--tapo "$TAPO_STA"} "$@"
}

# boot_pair <fw> [uci точки] — оба узла параллельно (точка и станция грузятся одновременно, станция ждёт точку);
# любая непройденная проверка — выход
boot_pair() {
	local fw=$1 uci=$2 pa ra rs
	boot_ap "$fw" ${uci:+--uci "$uci"} & pa=$!
	boot_sta "$fw"; rs=$?
	wait $pa; ra=$?
	if [ $ra -ne 0 ] || [ $rs -ne 0 ]; then
		echo "подготовка узлов не прошла (точка $ra, станция $rs) — запись не делаю"; exit 1
	fi
}

# ap_up / sta_up — после загрузки: адрес, ARP, (точка) iperf3 -s; (станция) прерывания на IRQ_CPU, ping точки
ap_up() {
	$SSH "$AP" "ip addr show br-lan | grep -q 'inet $AP_IP/' || ip addr add $AP_IP/24 dev br-lan; sysctl -qw net.ipv4.conf.all.arp_ignore=1 net.ipv4.conf.all.arp_announce=2; killall iperf3 2>/dev/null; sleep 1; iperf3 -s -D"
}
sta_up() {
	$SSH "$STA" "I=\$(iw dev | sed -n 's/.*Interface \(.*sta0\)/\1/p'); ip addr show \$I | grep -q 'inet $STA_IP/' || ip addr add $STA_IP/24 dev \$I; sysctl -qw net.ipv4.conf.all.arp_ignore=1 net.ipv4.conf.all.arp_announce=2; for i in \$(grep wil6210 /proc/interrupts | cut -d: -f1); do echo $IRQ_CPU > /proc/irq/\$i/smp_affinity; done; sleep 2; ping -c 2 -W 1 $AP_IP | tail -1"
}

# ver <host> — версия загруженной fw (wmi_evt_ready) и md5 файла
ver() {
	$SSH "$1" 'dmesg | sed -n "s/.*FW ver\. \([^(]*\)(.*/\1/p" | tail -1; md5sum /lib/firmware/wil6210.fw | cut -c1-12' | tr '\n' ' '
}

fwerr() {
	$SSH "$1" 'dmesg | grep -c "Firmware error"'
}

# cap_start <host> <сек> [маска] — захват PMC (docs/CAPTURE.md) в /tmp/cap.pcap узла; cap_fetch <host> <файл>
cap_start() {
	local mask=${3:+ mask=$3}
	$SSH "$1" "P=\$(ls -d /sys/kernel/debug/ieee80211/phy*/wil6210 | head -1); echo 'start $2$mask' > \$P/capture; (wilcap wilmon0 $(($2 - 1)) > /tmp/cap.pcap 2>/dev/null &)"
}
cap_fetch() {
	$SSH "$1" 'cat /tmp/cap.pcap' > "$2"
}

# mac <host> — MAC интерфейса wil6210 (не монитор захвата)
mac() {
	$SSH "$1" 'for i in $(iw dev | sed -n "s/.*Interface //p"); do case $i in wilmon*) ;; *) cat /sys/class/net/$i/address; break;; esac; done'
}
