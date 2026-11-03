# SPDX-License-Identifier: AGPL-3.0-or-later
"""Постоянные DMG PHY (802.11-2020 табл. 20-30, 20-4), TXTIME (20.11.3) и межкадровые интервалы DMG (10.3.2.3).
Время — Fraction, мкс."""
from fractions import Fraction as Fr
from math import ceil

# ---- Table 20-30 — DMG PHY characteristics ----
aSIFSTime = Fr(3)
aRIFSTime = Fr(1)
aSBIFSTime = Fr(1)
aSBIFSAccuracy = Fr(3, 100)
aSlotTime = Fr(5)
aAirPropagationTime = Fr(1, 10)
aBRPIFS = Fr(40)
aCWmin = 15
aCWmax = 1023
aBRPminSCblocks = 18
aBRPTRNBlock = 4992
aSCGILength = 64
aSCBlockSize = 512
aPPDUMaxTime = Fr(2000)
aPSDUMaxLength = 262143
# aRxPHYStartDelay: control mode 10 µs, SC 3,6 µs
aRxPHYStartDelay = {'control': Fr(10), 'sc': Fr(36, 10)}

# ---- Table 20-4 — Timing-related parameters ----
Fc = 1760                                   # МГц
Tc = Fr(1, Fc)                              # мкс
Tseq = 128 * Tc
T_STF = 17 * Tseq
T_CE = 9 * Tseq
T_HEADER = 2 * aSCBlockSize * Tc
T_STF_CM = 50 * Tseq
T_CE_CM = T_CE

# ---- Table 20-15 — DMG SC MCS (базовые 1..12): (NCBPS, повтор ρ, код R) ----
SC_MCS = {
    1: (1, 2, Fr(1, 2)), 2: (1, 1, Fr(1, 2)), 3: (1, 1, Fr(5, 8)), 4: (1, 1, Fr(3, 4)), 5: (1, 1, Fr(13, 16)),
    6: (2, 1, Fr(1, 2)), 7: (2, 1, Fr(5, 8)), 8: (2, 1, Fr(3, 4)), 9: (2, 1, Fr(13, 16)),
    10: (4, 1, Fr(1, 2)), 11: (4, 1, Fr(5, 8)), 12: (4, 1, Fr(3, 4)),
}
# Table 20-19 — NCBPB по отображению (NCBPS = 1/2/4/6 → BPSK/QPSK/16-QAM/64-QAM)
NCBPB = {1: 448, 2: 896, 4: 1792, 6: 2688}


def ldpc_lcw(R):
    """20.5.3.2.3.3 a): LCW — 624 при R = 7/8, 504 при 2/3, 468 при 5/6, иначе 672."""
    return {Fr(7, 8): 624, Fr(2, 3): 504, Fr(5, 6): 468}.get(R, 672)


def sc_ncw(length, mcs):
    """20.5.3.2.3.3 a): NCW = ⌈Length·8 / ((LCW/ρ)·R)⌉ (не BRP)."""
    ncbps, rho, R = SC_MCS[mcs]
    lcw = ldpc_lcw(R)
    return ceil(Fr(length * 8) / (Fr(lcw, rho) * R))


def sc_nblks(length, mcs):
    """20.5.3.2.3.3 d): NBLKS = ⌈NCW·LCW / NCBPB⌉."""
    ncbps, rho, R = SC_MCS[mcs]
    return ceil(Fr(sc_ncw(length, mcs) * ldpc_lcw(R), NCBPB[ncbps]))


def txtime_sc(length, mcs):
    """20.11.3, SC, NTRN = 0: T_STF + T_CE + T_header + T_Data; T_Data = (NBLKS·aSCBlockSize + aSCGILength)·Tc
    (табл. 20-4)."""
    t_data = (sc_nblks(length, mcs) * aSCBlockSize + aSCGILength) * Tc
    return T_STF + T_CE + T_HEADER + t_data


def control_ncw(length):
    """20.4.3.3.3 3): NCW = 1 + ⌈(Length − 6)·8 / LCWD⌉, LCWD = 168."""
    return 1 + ceil(Fr((length - 6) * 8, 168))


def txtime_control(length):
    """20.11.3, control mode, NTRN = 0: T_STF-CM + T_CE-CM + (11·8 + (Length − 6)·8 + NCW·168)·Tc·32."""
    return T_STF_CM + T_CE_CM + (11 * 8 + (length - 6) * 8 + control_ncw(length) * 168) * Tc * 32


def txtime(length, mcs):
    """MCS 0 — control mode, 1..12 — SC."""
    return txtime_control(length) if mcs == 0 else txtime_sc(length, mcs)


# ---- 10.3.2.3 — межкадровые интервалы DMG ----
SIFS = aSIFSTime                            # 10.3.2.3.3
SBIFS = aSBIFSTime                          # 10.3.2.3.8
MBIFS = 3 * aSIFSTime                       # 10.3.2.3.10
BRPIFS_MAX = aBRPIFS * Fr(11, 10)           # 10.3.2.3.9: aBRPIFS + 10 %, минимум — SIFS
MBIFS_TOL = Fr(1, 10) * (aSlotTime - aAirPropagationTime)   # 10.3.2.3.10: −0 % … +10 %·(aSlotTime − aAirPropagationTime)


def lbifs(len_ssw=26):
    """10.3.2.3.11: LBIFS = TXTIME(SSW) + 2·SBIFS (SSW — control mode)."""
    return txtime_control(len_ssw) + 2 * aSBIFSTime


def aifs(aifsn):
    """10.3.2.3.6 / 10.23.2.4: AIFS[AC] = AIFSN[AC]·aSlotTime + aSIFSTime."""
    return aifsn * aSlotTime + aSIFSTime


CLK_MHZ = 165


def us_to_clk(t):
    """Время в такты 165 МГц (вверх) — только для сравнения с эмулятором."""
    return ceil(Fr(t) * CLK_MHZ)
