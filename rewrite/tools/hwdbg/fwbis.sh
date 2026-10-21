#!/bin/bash
# fwbis.sh <commit> -> печатает "<commit> READY <ms>" | "<commit> NOREADY" | "<commit> NOBUILD"
SP=${SP:-/tmp/fwdbg}; mkdir -p $SP
A=/home/evilwirelessman/Documents/WORK/60_GHZ/toolchain/arc_gnu_2021.03_prebuilt_elf32_le_linux_install
R=/home/evilwirelessman/Documents/WORK/60_GHZ/SparRAW/SparRAW-firmware
export PATH=$A/bin:$PATH
c=$1; d=$SP/wtb_$c; o=$SP/fwbis/$c; mkdir -p $o
cd $R && git worktree add -q --detach $d $c
(cd $d/rewrite && make -s ARC_DIR=$A BUILD=$o/b $o/b/fw.elf >/dev/null 2>&1)
cd $R && git worktree remove --force $d; git worktree prune
[ -s $o/b/fw.elf ] || { echo "$c NOBUILD"; exit 0; }
python3 $R/rewrite/tools/build_fw.py --elf $o/b/fw.elf --uc-elf $SP/bm/uc.elf --vendor $R/images/openwrt/fw/wil6210_6.2.0.1000.fw --out $o/fw.fw >/dev/null
timeout 420 $R/rewrite/tools/hwboot.sh $o/fw.fw 30 > $o/boot.out 2>&1
m=$(grep -o "FW ready after [0-9]* ms" $o/boot.out | head -1 | grep -o "[0-9]*")
[ -n "$m" ] && echo "$c READY $m" || echo "$c NOREADY"
