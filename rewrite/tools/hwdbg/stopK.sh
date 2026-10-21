#!/bin/bash
# stopK.sh <N> [ref] — как stopN.sh, плюс живой kmsg (/proc/kmsg → $o/kmsg.txt) и проверка uptime: blob
# читается, только если .12 не перезагрузился (иначе в blob мусор DCCM после power-on). Spin в
# любом файле fw: PATCHPY=tools/hwdbg/spinat.py SPIN_FILE=lmac.c SPIN_AT="<точная строка>"
N=$1; REF=${2:-HEAD}
SP=${SP:-/tmp/fwdbg}; mkdir -p $SP
A=/home/evilwirelessman/Documents/WORK/60_GHZ/toolchain/arc_gnu_2021.03_prebuilt_elf32_le_linux_install
R=/home/evilwirelessman/Documents/WORK/60_GHZ/SparRAW/SparRAW-firmware
export PATH=$A/bin:$PATH
H=root@192.168.1.12
SSH="ssh -F /dev/null -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=8 -o LogLevel=ERROR"
TAPO="python3 $R/../SparRAW-tools/host/tapo_plug.py 192.168.10.105 cycle 15"
o=$SP/stop/$N; rm -rf $o; mkdir -p $o; d=$SP/wts_$N
cd $R && git worktree add -q --detach $d $REF
sed -i 's|^static void trace_step(u32 n) { \*(volatile u32 \*)0x806a00 = n; }|static void trace_step(u32 n) { *(volatile u32 *)0x806a00 = n; if (n == '$N') for (;;) *(volatile u32 *)0x806a04 = 0x5709; }|' $d/rewrite/fw/main.c
[ -n "$PATCHPY" ] && python3 "$PATCHPY" $d/rewrite/fw/main.c; grep -q "0x5709" $d/rewrite/fw/main.c || { echo "$N PATCHFAIL"; git worktree remove --force $d; exit 1; }
(cd $d/rewrite && make -s ARC_DIR=$A BUILD=$o/b $o/b/fw.elf >/dev/null 2>&1)
git worktree remove --force $d; git worktree prune
python3 $R/rewrite/tools/build_fw.py --elf $o/b/fw.elf --uc-elf $SP/bm/uc.elf --vendor $R/images/openwrt/fw/wil6210_6.2.0.1000.fw --out $o/fw.fw $BUILDFW_ARGS >/dev/null || { echo "$N NOBUILD"; exit 1; }
alive() { for i in $(seq ${1:-40}); do $SSH $H true 2>/dev/null && return 0; sleep 3; done; return 1; }
alive 3 || { $TAPO >/dev/null 2>&1; sleep 30; alive 60 || { echo "$N STAND-DOWN"; exit 1; }; }
cat $o/fw.fw | $SSH $H 'cat >/lib/firmware/wil6210.fw; sync'
$TAPO >/dev/null 2>&1; sleep 25; alive 60 || { echo "$N STAND-DOWN"; exit 1; }
(timeout 70 $SSH -o ServerAliveInterval=2 -o ServerAliveCountMax=2 $H 'echo 8 > /proc/sys/kernel/printk; cat /proc/kmsg' > $o/kmsg.txt 2>&1 &); sleep 2
timeout 60 $SSH $H 'echo Y > /sys/module/wil6210/parameters/no_fw_recovery 2>/dev/null;
  uci set wireless.radio0.disabled=0; uci set wireless.default_radio0.disabled=0; (wifi up radio0 >/dev/null 2>&1 &); sleep 12; echo up' >/dev/null 2>&1
sleep 15; UP=$(timeout 10 $SSH $H 'cut -d. -f1 /proc/uptime' 2>/dev/null); echo "$N uptime=$UP"
grep -o "FW ready after [0-9]* ms\|Firmware not ready" $o/kmsg.txt | head -1
if [ -n "$UP" ] && [ "$UP" -gt 40 ]; then
  timeout 40 $SSH $H 'cat /sys/kernel/debug/ieee80211/phy0/wil6210/blob_fw_data > /tmp/fwd.bin; dmesg | grep wil6210 | tail -6' > $o/dmesg.txt 2>&1
  timeout 40 $SSH $H 'cat /tmp/fwd.bin' > $o/fwd.bin 2>/dev/null
  python3 -c "
import struct,sys
b=open('$o/fwd.bin','rb').read()
w=lambda a: struct.unpack_from('<I',b,a-0x800000)[0] if len(b)>a-0x800000+3 else -1
print('$N ALIVE step=0x%x spin=0x%x a54=0x%x a60=0x%x len=%d' % (w(0x806a00), w(0x806a04), w(0x800a54), w(0x800a60), len(b)))"
  grep -o "FW ready after [0-9]* ms\|Firmware not ready" $o/dmesg.txt | head -1
else
  echo "$N HANG"; $TAPO >/dev/null 2>&1; sleep 30; alive 60 >/dev/null
fi
