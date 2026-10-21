PHY=$(ls /sys/kernel/debug/ieee80211/ | head -1); D=/sys/kernel/debug/ieee80211/$PHY/wil6210; IF=$(iw dev | sed -n 's/.*Interface \(.*\)/\1/p' | head -1)
rm -rf /tmp/mo; mkdir -p /tmp/mo; ( n=0; while [ ! -e /tmp/mo/stop ]; do cat $D/blob_fw_peri > /tmp/mo/$n.bin; n=$((n+1)); usleep 300000; done ) &
echo -ne '\x00\x00\x04\x0a\x00\x00\x00\x00\x02\x00\x00\x00' > $D/wmi_send; echo "M1 set_multi_omni rc=$?"
sleep 1; wpa_cli -i $IF disconnect >/dev/null; sleep 3; echo "M1b state $(iw dev $IF link | head -1)"; wpa_cli -i $IF reconnect >/dev/null
i=0; while [ $i -lt 40 ]; do iw dev $IF link | grep -q Connected && break; sleep 1; i=$((i+1)); done
sleep 5; echo "M2 reconnect_s=$i ping $(ping -q -c 5 -W 1 10.60.0.11 | sed -n 's/.* \([0-9]*\) packets received.*/\1/p')/5 $(iw dev $IF link | head -1)"
touch /tmp/mo/stop; sleep 1
