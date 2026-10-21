#!/bin/bash
# Сборка HEAD в $SP/bold без git stash (в репо лежит чужой stash@{0}): отдельный worktree.
set -e
SP=${SP:-/tmp/fwdbg}; mkdir -p $SP
A=/home/evilwirelessman/Documents/WORK/60_GHZ/toolchain/arc_gnu_2021.03_prebuilt_elf32_le_linux_install
R=/home/evilwirelessman/Documents/WORK/60_GHZ/SparRAW/SparRAW-firmware
cd $R
git worktree remove --force $SP/wt_bold 2>/dev/null || true
git worktree prune
git worktree add -q --detach $SP/wt_bold HEAD
rm -rf $SP/bold
(cd $SP/wt_bold/rewrite && make -s ARC_DIR=$A BUILD=$SP/bold $SP/bold/uc.elf >/dev/null 2>&1)
git worktree remove --force $SP/wt_bold
git worktree prune
ls $SP/bold/uc.elf >/dev/null && echo "bold: HEAD $(git log --oneline -1 | cut -c1-8)"
