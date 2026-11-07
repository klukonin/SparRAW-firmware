# SPDX-License-Identifier: AGPL-3.0-or-later
"""Постоянные DMG PHY (802.11-2020 табл. 20-30, 20-4), TXTIME (20.11.3) и межкадровые интервалы DMG (10.3.2.3);
общие для модулей постоянные MAC: TU (3.1), табл. 11-22, MIB DEFVAL, длины/TXTIME SSW-кадров, допуски IFS, BRP-времена,
A-BFT-формулы aSSDuration/aSSSlotTime, пределы общих подполей (9.5.x), AID (9.4.1.8). Каждая постоянная определена
только здесь; модули импортируют её (тесты обращаются к ней и через модуль). Время — Fraction, мкс.
Принятые трактовки спорных мест — PLAN.md, раздел «Принятые трактовки»."""
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
# 10.3.2.3.10: −0 % … +10 %·(aSlotTime − aAirPropagationTime)
MBIFS_TOL = Fr(1, 10) * (aSlotTime - aAirPropagationTime)


def lbifs(len_ssw=26):
    """10.3.2.3.11: LBIFS = TXTIME(SSW) + 2·SBIFS (SSW — control mode)."""
    return txtime_control(len_ssw) + 2 * aSBIFSTime


def ceil_to(x, y):
    """1.5: «Ceil (x, y), is the smallest multiple of y larger than or equal to x»."""
    x, y = Fr(x), Fr(y)
    return ceil(x / y) * y


def aifs(aifsn):
    """10.3.2.3.6 / 10.23.2.4: AIFS[AC] = AIFSN[AC]·aSlotTime + aSIFSTime."""
    return aifsn * aSlotTime + aSIFSTime


# ---- 10.3.2.3 — допуски на эфире ----
# 10.3.2.3.3 (DMG): SIFS «–0% or +10% × (aSlotTime – aAirPropagationTime)»; то же для MBIFS (10.3.2.3.10) и LBIFS
# (10.3.2.3.11) — текст 2020 и 2024 совпадает.
SIFS_TOL = Fr(1, 10) * (aSlotTime - aAirPropagationTime)
LBIFS_TOL = MBIFS_TOL
# СПОРНО → принято (PLAN.md «Принятые трактовки» №8): допуск PIFS для DMG не задан (10.3.2.3.4 ни в 2020, ни в 2024) —
# берём как у SIFS/MBIFS: −0 … +10 %·(aSlotTime − aAirPropagationTime).
PIFS_TOL = SIFS_TOL
# 10.3.2.3.8: SBIFS «not … less than aSBIFSTime or … more than aSBIFSTime + aSBIFSAccuracy»
SBIFS_MAX = SBIFS + aSBIFSAccuracy
PIFS = SIFS + aSlotTime                     # 10.3.7 (10-5)
DIFS = SIFS + 2 * aSlotTime                 # 10.3.7 (10-6)

# ---- длины и TXTIME кадров SLS (октеты с FCS) ----
LEN_SSW = 26        # рис. 9-54: FC 2 + Duration 2 + RA 6 + TA 6 + SSW 3 + SSW Feedback 3 + FCS 4
LEN_SSW_FB = 28     # рис. 9-55: … SSW Feedback 3 + BRP Request 4 + BLM 1 + FCS 4
LEN_SSW_ACK = 28    # рис. 9-56: та же структура
# 10.6.7.1: SSW-Feedback, SSW-Ack — DMG Control; SSW — Control «in all other cases» (кроме RXSS с RXSSTxRate, sls.py)
T_SSW = txtime_control(LEN_SSW)
T_SSW_FB = txtime_control(LEN_SSW_FB)
T_SSW_ACK = txtime_control(LEN_SSW_ACK)
LBIFS = lbifs(LEN_SSW)                      # 10.3.2.3.11: TXTIME(SSW) + 2×SBIFS

# ---- BRP (10.3.2.3.9, 10.42.3.1, 20.11.3) ----
# 10.3.2.3.9: «BRPIFS is defined to be equal to aBRPIFS+10%» — максимум; «The corresponding minimum time is SIFS».
BRPIFS = BRPIFS_MAX                         # 44 мкс
BRPIFS_MIN = SIFS
# 10.42.3.1 b): транзакция завершена, если «BRPIFS plus aSlotTime has elapsed since the last transmission from the
# beam refinement initiator … without a response»
BRP_TXN_TIMEOUT = BRPIFS + aSlotTime        # 49 мкс
# 20.11.3: T_TRN-Unit = aBRPTRNBlock × T_C
T_TRN_UNIT = aBRPTRNBlock * Tc
# 20.11.3: минимальный Data field BRP PPDU в SC — (α·β + γ)·T_C, α = aBRPminSCblocks, β = aSCBlockSize,
# γ = aSCGILength (20.9.2.2.4)
T_BRP_DATA_MIN_SC = (aBRPminSCblocks * aSCBlockSize + aSCGILength) * Tc

# ---- 3.1 / табл. 11-22 — DMG MAC sublayer attribute values ----
TU = Fr(1024)                               # 3.1: «time unit (TU): … equal to 1024 µs»
# PLAN.md №13: все величины табл. 11-22 здесь — в мкс (TU → мкс при определении), MIB-значения в TU — целые TU.
aMaxBIDuration = 1000 * TU                  # «aMaxBIDuration 1000 TUs» → мкс
aMinChannelTime = aMaxBIDuration            # «aMinChannelTime  aMaxBIDuration» → мкс
aMinBTIPeriod = 4
aTSFResolution = Fr(1)                      # «aTSFResolution 1 µs»
aDMGTSFAccuracy = 20                        # «aDMGTSFAccuracy 20 ppm» (= 11.1.3.9 ± 20 ppm)
aSSFramesPerSlot = 4
aMinAllocationDeliveryTime = Fr(300)        # «300 µs»
aDMGPPMinListeningTime = Fr(150)            # «150 µs»
aMaxABFTAccessPeriod = 2
aMinNAVTimersNumber = 2                     # «aMinNAVTimersNumber 2» — число NAV при нескольких NAV (10.39.10)

# ---- MIB (приложение C), DEFVAL, общие для нескольких модулей ----
# PLAN.md №10 — dot11MaxLostBeacons: SYNTAX 1..32, DEFVAL { 4 }; 11.1.3.3.3: «A DMG AP shall set dot11MaxLostBeacons to
# the value of the aMinBTIPeriod parameter» — то же число 4.
DOT11_MAX_LOST_BEACONS = 4
assert DOT11_MAX_LOST_BEACONS == aMinBTIPeriod
DOT11_MIN_BHI_DURATION = Fr(5000)           # dot11MinBHIDuration DEFVAL { 5000 } мкс
DOT11_MAX_BF_TIME = 4                       # dot11MaxBFTime DEFVAL { 4 } интервалов маяка (10.42.1; T2 рис. 10-91)
# dot11DMGOperationEntry (C.3): dot11MinPPDuration DEFVAL { 200 } мкс (10.39.7.1, 10.39.7.3), dot11SPIdleTimeout
# DEFVAL { 200 } мкс (10.39.6.7); dot11DMGBeamformingConfigEntry: dot11AntennaSwitchingTime DEFVAL { 0 } мкс (A_k в
# (10-18), 10.39.7.2) — mlme (MIB из DMG Operation), schedule/sp/dynalloc
DOT11_MIN_PP_DURATION = 200
DOT11_SP_IDLE_TIMEOUT = 200
DOT11_ANTENNA_SWITCHING_TIME = 0
# 9.4.2.128, рис. 9-557: AssocRespConfirmTime — «in units of 50 milliseconds»
ASSOC_RESP_CONFIRM_UNIT = Fr(50000)
# dot11BeamTrackingTimeLimit: SYNTAX Unsigned32 (0..65535), UNITS "microseconds", DEFVAL { 10000 } (C.3); 9.4.2.127.4:
# поле DMG STA Beam Tracking Time Limit несёт это значение; 65 535 — «по умолчанию» (табл. 10-31)
DOT11_BEAM_TRACKING_TIME_LIMIT = Fr(10000)
BT_TIME_LIMIT_DEFAULT_CODE = 65535

# ---- A-BFT: aSSDuration, aSSFBDuration (табл. 11-22), aSSSlotTime (10.42.5.2) ----
FSS_MAX = 16                                # 9.3.4.2: FSS — 4 бита, «number of SSW frames allowed minus one»
# СПОРНО → принято (PLAN.md №1): FSS в формулах — ЧИСЛО КАДРОВ (= поле FSS + 1); рис. 10-75 (2020) / 10-89 (2024).


def ss_duration(fss_frames, t_ssw=T_SSW):
    """Табл. 11-22: aSSDuration = (FSS – 1) × SBIFS + FSS × TXTIME(SSW); FSS — число кадров (поле + 1)."""
    assert 1 <= fss_frames <= FSS_MAX
    return (fss_frames - 1) * SBIFS + fss_frames * Fr(t_ssw)


def ss_fb_duration(t_ssw_fb=T_SSW_FB):
    """Табл. 11-22: aSSFBDuration = TXTIME(SSW-Feedback)."""
    return Fr(t_ssw_fb)


def ss_slot_time(fss_frames, t_ssw=T_SSW, t_ssw_fb=T_SSW_FB):
    """10.42.5.2: aSSSlotTime = aAirPropagationTime + aSSDuration + MBIFS + aSSFBDuration + MBIFS (рис. 10-76)."""
    return aAirPropagationTime + ss_duration(fss_frames, t_ssw) + MBIFS + ss_fb_duration(t_ssw_fb) + MBIFS


# СПОРНО → принято (PLAN.md №4): допуски проверки A-BFT на эфире (TSF точки). Первая SSW слота — в [начало слота, +
# aAirPropagationTime] (слагаемое aAirPropagationTime в aSSSlotTime «accounts for the propagation delay»); последняя
# SSW — не позже начала слота + aAirPropagationTime + aSSDuration; SSW-Feedback — в [слот − aSSFBDuration − MBIFS, +
# MBIFS_TOL] (опоздание — как у MBIFS, 10.3.2.3.10; раньше — нельзя: MBIFS после RSS −0 %).
ABFT_SSW_START_TOL = aAirPropagationTime
ABFT_FB_TOL = MBIFS_TOL

# ---- общие пределы подполей и адреса ----
CDOWN_MAX = 511         # 9.5.1: CDOWN 9 бит, «Possible values range from 0 to 511»
SECTOR_ID_MAX = 63      # 9.5.1: Sector ID 6 бит; 9.5.3: Sector Select «0 to 63»
ANT_ID_MAX = 3          # 9.5.1: DMG Antenna ID 2 бита
L_RX_MAX = 16           # 9.5.4: «The L-RX subfield contains an unsigned integer between 0 and 16»
# 9.5.4: «If the PPDU is transmitted using a pattern that is not a sector … this subfield is set to 0x63».
# СПОРНО → принято (PLAN.md №7): 0x63 = 99 не помещается в 6 бит TX Sector ID (2020 и 2024 одинаково) → 63 (все
# единицы).
TX_SECTOR_NOT_SWEPT = 63
TSF_LOW_MOD = 1 << 32   # 9.4.2.131: «Allocation Start … lower 4 octets of the TSF»
# 9.4.1.8: DMG AID «1 to 254. The value 255 is reserved as the broadcast AID, and the value 0 corresponds to the AP
# or PCP»
AID_AP_PCP = 0
AID_BROADCAST = 255
# 9.4.2.131, табл. 9-257: AllocationType — биты 4–6 как число (B4 — младший); 9.5.2 ссылается туда же
ALLOC_SP, ALLOC_CBAP, ALLOC_SP_1G08, ALLOC_CBAP_1G08 = 0, 1, 2, 3
# 10.42.1: «number of sectors per DMG antenna shall not be greater than 64», «total number of sectors across all DMG
# antennas … not greater than 128»
MAX_SECTORS_PER_ANT = 64
MAX_SECTORS_TOTAL = 128
BCAST = 'ff:ff:ff:ff:ff:ff'                 # 9.2.4.3.2: broadcast address — все единицы


CLK_MHZ = 165


def us_to_clk(t):
    """Время в такты 165 МГц (вверх) — только для сравнения с эмулятором."""
    return ceil(Fr(t) * CLK_MHZ)
