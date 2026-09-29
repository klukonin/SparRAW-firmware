# SPDX-License-Identifier: AGPL-3.0-or-later
# @category wil6210
# @runtime PyGhidra
# Выгрузить эталонный набор инструкций (текст + точные байты) из образа
# 4.1, покрывающий разные формы кодирования. Для сверки с ARC-ассемблером.
from collections import defaultdict
sp = currentProgram.getAddressFactory().getDefaultAddressSpace()
listing = currentProgram.getListing()
mem = currentProgram.getMemory()
# границы взяты с запасом: за концом загруженных данных инструкций нет
RANGES = [(0x8c0000, 0x900000), (0x920000, 0x940000)]

by_form = defaultdict(list)
for lo, hi in RANGES:
    ins = listing.getInstructionAt(sp.getAddress(lo)) or listing.getInstructionAfter(sp.getAddress(lo))
    while ins is not None and ins.getAddress().getOffset() < hi:
        off = ins.getAddress().getOffset(); L = ins.getLength()
        try:
            b = bytes(bytearray((mem.getByte(sp.getAddress(off + i)) & 0xff) for i in range(L)))
        except Exception:
            ins = ins.getNext(); continue
        t = ins.toString()
        mn = ins.getMnemonicString()
        # форма = мнемоника + длина + «силуэт» операндов
        ops = t[len(mn):].strip()
        shape = ''.join('#' if c.isdigit() else ('r' if c.isalpha() else c) for c in ops)[:24]
        by_form['%s|%d|%s' % (mn, L, shape)].append((off, b.hex(), t))
        ins = ins.getNext()

forms = sorted(by_form.items(), key=lambda kv: -len(kv[1]))
print('РАЗНЫХ ФОРМ %d' % len(forms))
for key, lst in forms[:180]:
    off, hexb, t = lst[0]
    print('REF 0x%08x %-18s %-3d %s' % (off, hexb, len(lst), t))
