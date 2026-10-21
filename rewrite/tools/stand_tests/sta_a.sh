# выполняется на .12 (sh -s): тесты путей fw после подключения STA
PHY=$(ls /sys/kernel/debug/ieee80211/ | head -1); D=/sys/kernel/debug/ieee80211/$PHY/wil6210
IF=$(iw dev | sed -n 's/.*Interface \(.*\)/\1/p' | head -1)
P(){ ping -q -c 5 -W 1 10.60.0.11 2>/dev/null | sed -n 's/.* \([0-9]*\) packets received.*/\1/p'; }
echo "T00 ping_before $(P)/5 if=$IF"
echo "T01 temp $(cat $D/temp | tr '\n' ' ')"
echo "T02 fw $(cat $D/fw_version) caps $(cat $D/fw_capabilities)"
echo "T03 sta_connected $(cat $D/stations | grep -c connected) link_stats_lines $(cat $D/link_stats 2>&1 | wc -l)"
echo "T04 bf_lines $(cat $D/bf 2>&1 | grep -c .)"
M=$(iw dev $IF link | sed -n 's/^Connected to \([0-9a-f:]*\).*/\1/p')
echo "add 1 32 0" > $D/back; echo "T05 back_add rc=$?"; sleep 1
echo "del_tx 1 1" > $D/back; echo "T06 back_deltx rc=$?"; sleep 2; echo "T06b ping $(P)/5"
echo "del_rx 0 0 1" > $D/back; echo "T07 back_delrx rc=$?"; sleep 2; echo "T07b ping $(P)/5"
echo 1 > $D/led_cfg; R1=$?; sleep 1; echo 0 > $D/led_cfg; echo "T08 led rc=$R1/$?"
echo "alloc 8 256" > $D/pmccfg; R=$?; sleep 1; N=$(cat $D/pmcdata 2>/dev/null | wc -c); echo free > $D/pmccfg; echo "T09 pmc alloc_rc=$R data_bytes=$N $(cat $D/pmccfg | grep -i 'status')"
echo -ne '\x00\x00\x03\x08\x00\x00\x00\x00\x78\x56\x34\x12' > $D/wmi_send; echo "T10 wmi_echo rc=$?"
MB=$(echo $M | sed 's/:/\\x/g; s/^/\\x/')
echo -ne "\x00\x00\x91\x09\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x02\x01\x02\x00\x0a\x00\x00${MB}\x00\x00" > $D/wmi_send; echo "T11 ftm_start rc=$? peer=$M"
sleep 4
echo "T12 ping_after_tests $(P)/5"
