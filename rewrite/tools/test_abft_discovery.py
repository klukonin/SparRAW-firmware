#!/usr/bin/env python3
"""Модульная проверка условий Discovery Mode в A-BFT (802.11-2020 10.42.5.1) — uc/abft.h на хосте.
usage: test_abft_discovery.py [путь к rewrite/uc/abft.h]
Собирает векторы DMG Beacon (кадр: FC 2, Duration 2, BSSID 6, Timestamp 8, SSW 3, BI 2, BI Control 6 @23,
DMG Parameters 1 @29, Clustering Control 8 @30 — 9.3.4.2), извлекает из abft.h abft_bcn_ra_is_own /
abft_bcn_addressed_to_us / abft_discovery_ok, компилирует gcc вместе с заглушками (bcn_rx, rx_buf, роль, MMIO
собственного адреса) и сверяет с эталоном на Python, написанным по тексту стандарта."""
import itertools, os, re, subprocess, sys, tempfile

OWN = bytes.fromhex('24181d243b0b')
OTHER = bytes.fromhex('26181d26d47b')
BCAST = b'\xff' * 6
MCAST = bytes.fromhex('01005e000001')

def ref_ok(cc, disc, bss_type, ra, role):
    """10.42.5.1: при Discovery Mode = 1 — одно из условий; групповой, кроме широковещательного, — членство неизвестно."""
    if not disc: return 1
    if not cc: return 1
    if not (ra[0] & 1): return int(ra == OWN)
    if ra != BCAST: return 0
    return int(bss_type == 0 or bss_type == role)   # табл. 9-69: 0 — любая роль

def ref_addr(cc, disc, ra):
    return int(cc and disc and ra == OWN)

def main():
    path = sys.argv[1] if len(sys.argv) > 1 else os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'uc', 'abft.h')
    h = open(path).read()
    a = h.index('#define ABFT_BCN_RA_OFF'); b = h.index('return bt == role;\n}', a) + len('return bt == role;\n}')
    body = h[a:b]
    vecs = []
    for cc, disc, bt, ra, (role_ap, role_raw, role) in itertools.product(
            (0, 1), (0, 1), (0, 1, 2, 3), (OWN, OTHER, BCAST, MCAST),
            ((0, 1, 1), (1, 2, 3), (1, 3, 2))):   # не-AP STA, AP, PCP (режим cmd 0x1b)
        f = bytearray(40)
        f[23] = cc | (disc << 1) | (2 << 2)    # + Next Beacon для вида
        f[29] = bt | 0x10
        f[30:36] = ra
        vecs.append((bytes(f), role_ap, role_raw, ref_ok(cc, disc, bt, ra, role), ref_addr(cc, disc, ra)))
    c = ['#include <stdio.h>', '#include <stdint.h>', 'typedef uint8_t u8; typedef uint16_t u16; typedef uint32_t u32; typedef int32_t s32;',
         'struct { u8 bi_ctrl[6]; u32 bss_type; } bcn_rx; u8 rx_buf_mem[64]; u32 uc_role_ap, uc_role; u32 mmio_lo, mmio_hi;',
         '#define rx_buf (rx_buf_mem + 0x10 - 0x10)', '#define HW_MAC_OWN_ADDR_LO 1', '#define HW_MAC_OWN_ADDR_HI 2',
         '#define MMIO32(x) ((x) == 1 ? mmio_lo : mmio_hi)', body,
         'static const u8 V[][40] = {']
    for f, *_ in vecs:
        c.append('{' + ','.join(str(x) for x in f) + '},')
    c.append('}; static const u32 R[][2] = {' + ','.join('{%d,%d}' % (ra, rr) for _, ra, rr, *_ in vecs) + '};')
    c.append('int main(void){ mmio_lo = %d; mmio_hi = %d;' % (int.from_bytes(OWN[:4], 'little'), int.from_bytes(OWN[4:], 'little')))
    c.append(' for (unsigned i = 0; i < sizeof V / sizeof V[0]; i++) { for (int k = 0; k < 40; k++) rx_buf_mem[k] = V[i][k];'
             ' bcn_rx.bi_ctrl[0] = V[i][23]; bcn_rx.bss_type = V[i][29] & 3; uc_role_ap = R[i][0]; uc_role = R[i][1];'
             ' printf("%u %u\\n", abft_discovery_ok(), abft_bcn_addressed_to_us()); } return 0; }')
    d = tempfile.mkdtemp()
    open(d + '/t.c', 'w').write('\n'.join(c))
    subprocess.run(['gcc', '-O2', '-Wall', '-o', d + '/t', d + '/t.c'], check=True)
    out = subprocess.run([d + '/t'], capture_output=True, text=True, check=True).stdout.split('\n')
    bad = 0
    for i, (f, ra, rr, eok, ead) in enumerate(vecs):
        got = tuple(int(x) for x in out[i].split())
        if got != (eok, ead):
            bad += 1
            print('НЕ СОВПАЛО: CC %d Disc %d BSS %d RA %s роль %d: uc %s, эталон %s' % (f[23] & 1, (f[23] >> 1) & 1, f[29] & 3, f[30:36].hex(), rr, got, (eok, ead)))
    print('векторов %d, расхождений %d; разрешено передавать: %d' % (len(vecs), bad, sum(v[3] for v in vecs)))
    sys.exit(1 if bad else 0)

if __name__ == '__main__':
    main()
