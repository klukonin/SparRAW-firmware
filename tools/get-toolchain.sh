#!/bin/sh
# Скачивает пребилд ARC GNU 2021.03 (elf32 LE, Linux) в ./toolchain.
# Именно эта версия: ассемблер прошивки сверен с ней побайтово.
set -e
cd "$(dirname "$0")/.."
REL=arc-2021.03-release
TGZ=arc_gnu_2021.03_prebuilt_elf32_le_linux_install.tar.gz
URL=https://github.com/foss-for-synopsys-dwc-arc-processors/toolchain/releases/download/$REL/$TGZ
[ -d toolchain/arc_gnu_2021.03_prebuilt_elf32_le_linux_install ] && { echo "уже есть"; exit 0; }
mkdir -p toolchain
curl -L -o toolchain/$TGZ "$URL"
tar -C toolchain -xzf toolchain/$TGZ
rm toolchain/$TGZ
toolchain/arc_gnu_2021.03_prebuilt_elf32_le_linux_install/bin/arc-elf32-as --version | head -1
