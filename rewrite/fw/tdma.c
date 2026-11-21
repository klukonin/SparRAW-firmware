/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* TDMA точки (open): DTI по Extended Schedule (802.11-2020 9.4.2.131, 10.39.6) между связанными станциями. Включается
 * сам при TDMA_MIN_STA (2) и более станциях, при меньшем числе снимается — весь DTI снова CBAP (CBAP Only = 1). Хост
 * задаёт вкл./выкл., порог и режим командой WMI_SPARRAW_TDMA_CFG (0x0f10, tools/tdma_ctl.sh); по умолчанию включён,
 * режим — простое деление. Подробно — docs/TDMA.md.
 *
 * Расписание псевдостатическое (B7 = 1, один блок): каждый BI одинаково.
 *  - Окна начинаются после BTI и A-BFT: T0 = n·(TXTIME(маяк) + SBIFS) + MBIFS + L·aSSSlotTime(FSS) + MBIFS
 *    (10.39.2, 10.42.5.2; A-BFT закладывается в каждый BI — окна обходят его и там, где его нет).
 *  - Первое — общее CBAP {Source = Destination = 255}: вход новых станций (запрос ассоциации, SLS) —
 *    без него у станции без своего окна нет права начать обмен (10.39.5).
 *  - Простое деление (WMI_SPARRAW_TDMA_MODE_EQUAL, решение 2026-10-23): затем по одному CBAP {Source = AID станции i,
 *    Destination = AID точки} равной длины: по 10.39.5 начинать обмен в окне могут только станция i и точка — трафик
 *    в обе стороны без опросов и RD. Своя таблица окон точки (ese_slot_tbl) не заполняется: точка — назначение каждого
 *    окна и по 10.39.5 может начинать обмен в любом.
 *  - Строгий (WMI_SPARRAW_TDMA_MODE_SP, решение 2026-11-07 — open, потому что это стандарт): на станцию i два SP
 *    равной длины — точка → станция i и станция i → точка (10.39.6.2: в SP начинает обмен только источник, получатель
 *    только отвечает, прочие молчат). Между SP — не меньше aDMGPPMinListeningTime (у всех SP общая STA — точка,
 *    10.39.6.2 «should»). Truncatable = Extendable = 0 (усечение 10.39.8 и продление 10.39.9 — следующий этап). Окна,
 *    где точка начинает обмен (общее CBAP, SP точка → станция i, CBAP остатка BI), — в своей таблице ese_own_tbl:
 *    по ней uc точки открывает передачу только к получателю окна и не начинает обмен в SP станций (uc/ese_dti.c);
 *    в аппаратный массив SP её закладывает тот же обход (lmac_if_evt_walk), что у таблицы станции.
 *  - Между соседними окнами — Tguard (10.39.6.5), A = dot11MaxLostBeacons = 4 (псевдостатические),
 *    C = aDMGTSFAccuracy = 20 ppm, D = BI, + aSIFSTime 3 мкс + aAirPropagationTime 0,1 мкс + aTSFResolution 1 мкс.
 * ESE добавляется в блок IE маяка (тип 0) к IE хоста, а не вместо них (vendor-сборщик блок заменял). */
#include "../include/types.h"
#include "../include/fwq_tx.h"
#include "../include/ieee80211.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/mid.h"
#include "../include/conn.h"
#include "../include/fwsh.h"
#include "../include/sched_scheme.h"
#include "../include/abft_cfg.h"
#include "../include/wmi.h"
#include "../include/clk.h"
#define CLK_MHZ clk_mhz_of_n(MMIO32(CLK_PLL_N_REG))   /* такт ядра fw (include/clk.h) */
#include "../uc/ifs.h"                      /* макросы TXTIME/IFS в тактах ядра */

/* aSSSlotTime (10.42.5.2) в тактах — та же формула, что abft_slot_clk() в uc/abft.h (тот заголовок в fw не
 * включается: в нём функции uc): aAirPropagationTime (17) + aSSDuration + MBIFS + aSSFBDuration + MBIFS,
 * aSSDuration = (поле FSS + 1)·(TXTIME(SSW) + SBIFS) − SBIFS, aSSFBDuration = TXTIME(SSW-Feedback). */
#define TDMA_ABFT_SLOT_CLK(fss) (((fss) + 1u) * (DMG_TXTIME_SSW_CLK + DMG_SBIFS_CLK) - DMG_SBIFS_CLK + \
                                 17u + DMG_MBIFS_CLK + DMG_TXTIME_SSW_ACK_CLK + DMG_MBIFS_CLK)

#ifndef TDMA_MIN_STA
#define TDMA_MIN_STA 2u                     /* станций для включения по умолчанию (WMI_SPARRAW_TDMA_CFG — свой порог) */
#endif
#define TDMA_COMMON_US     2000u            /* общее окно CBAP 255→255 */
#define TDMA_MAX_STA       SPARRAW_MAX_STA  /* CONN_MAX */
#define EID_EXT_SCHED_IE   0x90u
#define ESE_FIELD_LEN      15u
#define TSF_ACC_PPM        20u              /* aDMGTSFAccuracy (Table 20-30) */
#define TDMA_MIN_WIN_US    1000u            /* окно станции (простое деление) / SP (строгий) — не меньше 1 мс */
#define TDMA_SP_MAX_US     32767u           /* Allocation Block Duration SP: 1…32 767 (9.4.2.131) */
#define TDMA_CBAP_MAX_US   65535u           /* … CBAP: 1…65 535 */
#define TDMA_LISTEN_US     150u             /* aDMGPPMinListeningTime (Table 11-22; 10.39.6.2 «should») */
#define ESE_FIELDS_MAX     17u              /* полей Allocation в одном элементе: Length ≤ 255, 15 октетов поле */
#define ESE_TYPE_SP        0u               /* Allocation Type (Table 9-257) */
#define ESE_TYPE_CBAP      1u

/* Tguard (10.39.6.5) для двух соседних псевдостатических окон, мкс (вверх). */
static u32 tdma_guard_us(u32 bi_us)
{
    /* ⌈2·(A+1)·C·D·10^-6⌉ (10.39.6.5); целая часть D в секундах отдельно — без переполнения u32 при больших BI */
    const u32 k = 2u * (DOT11_MAX_LOST_BEACONS + 1u) * TSF_ACC_PPM;
    u32 us = (bi_us / 1000000u) * k + ((bi_us % 1000000u) * k + 999999u) / 1000000u;
    return us + 3u /* SIFS */ + 1u /* T_P 0,1 → вверх */ + 1u /* T_TR */;
}

/* Конец BTI + A-BFT от TBTT, мкс (вверх): ese_len — сколько байт ESE добавится к маяку. */
static u32 tdma_dti_start_us(const struct mid *mid, u32 ese_len)
{
    u32 n = fwsh_total_sectors != 0 ? fwsh_total_sectors : 1u;
    u32 ant = fwsh_n_rx_ant > 1 ? fwsh_n_rx_ant : 1u;
    /* длина текущего маяка уже включает прежний ESE (пересборка каждый BI) — заменить его новым */
    u32 L = FWSH(fwsh_diag, bcn_psdu_len) + ese_len;
    const struct app_ies *blk = mid_app_ie_block((struct mid_bss *)&mid->bss, 0);
    const u8 *ie = (const u8 *)blk->buf;
    for (u32 i = 0; ie != 0 && i + 2u <= blk->len && i + 2u + ie[i + 1] <= blk->len; i += 2u + ie[i + 1]) {
        if (ie[i] == EID_EXT_SCHED_IE && L > 2u + ie[i + 1]) {
            L -= 2u + ie[i + 1];
            break;
        }
    }
    if (L < 6u)
        L = 6u;
    u32 bcn_clk = DMG_CTRL_TXTIME_CLK(L) + DMG_SBIFS_CLK;
    u32 bti_clk = n * ant * bcn_clk;
    u32 slots = (u32)mid->bss.abft_len + 1u;
    u32 abft_clk = DMG_MBIFS_CLK + slots * TDMA_ABFT_SLOT_CLK(ABFT_FSS_FIELD);
    return (bti_clk + abft_clk + DMG_MBIFS_CLK + DMG_CLK_PER_US - 1u) / DMG_CLK_PER_US;
}

/* MinBHIDuration (DMG BSS Parameter Configuration, рис. 9-557): наименьшая длительность BHI, мкс (вниз). A-BFT есть не в
 * каждом BI (N BIs A-BFT), ATI нет — наименьший BHI — один BTI: n маяков развёртки (секторы × RX-антенны) через SBIFS,
 * TXTIME — Control PHY от длины текущего маяка (как tdma_dti_start_us). */
u32 bss_min_bhi_us(const struct mid *mid)
{
    (void)mid;
    u32 n = fwsh_total_sectors != 0 ? fwsh_total_sectors : 1u;
    u32 ant = fwsh_n_rx_ant > 1 ? fwsh_n_rx_ant : 1u;
    u32 L = FWSH(fwsh_diag, bcn_psdu_len);
    if (L < 6u)
        L = 6u;
    return (n * ant * (DMG_CTRL_TXTIME_CLK(L) + DMG_SBIFS_CLK) - DMG_SBIFS_CLK) / DMG_CLK_PER_US;
}

static void tdma_fill_ese_alloc_field(u8 *f, u32 id, u32 type, u32 src, u32 dst, u32 start, u32 dur)
{
    for (u32 i = 0; i < ESE_FIELD_LEN; i++)
        f[i] = 0;
    /* Allocation Control (рис. 9-564): ID B0..B3, Allocation Type B4..B6, Pseudo-static B7; Truncatable B8 и
     * Extendable B9 — 0 (CBAP: резерв; SP: усечение/продление ещё не поддержаны) */
    f[0] = (u8)((id & 0xfu) | (type << 4) | (1u << 7) /* pseudo-static */);
    /* PCP Active (B10) = 1: 10.39.6.1 — AP ставит 1 во всех аллокациях ESE; 9.4.2.131 — PCP, когда он источник или
     * назначение окна; в общем окне точка тоже принимает (энергосбережения точки нет) */
    f[1] = (u8)(1u << (10 - 8));
    f[4] = (u8)src;
    f[5] = (u8)dst;
    f[6] = (u8)start;
    f[7] = (u8)(start >> 8);
    f[8] = (u8)(start >> 16);
    f[9] = (u8)(start >> 24);
    f[10] = (u8)dur;
    f[11] = (u8)(dur >> 8);
    f[12] = 1;                              /* Number of Blocks; Allocation Block Period — резерв при одном блоке */
}

/* Блок IE маяка (тип 0): все IE, кроме прежнего ESE, плюс ese (len 0 — только убрать ESE). Порядок в кадре —
 * tx_mgmt_srvs_build_dmg_beacon (табл. 9-45). Общий для TDMA точки и расписания хоста (fw/wmi_h_bf.c). */
void mid_set_beacon_ese(struct mid *mid, const u8 *ese, u32 len)
{
    struct app_ies *blk = mid_app_ie_block(&mid->bss, 0);
    const u8 *old = (const u8 *)blk->buf;
    u32 olen = old != 0 ? blk->len : 0u;
    u32 buf = TX_API_alloc_tx_payload();
    u8 *d = (u8 *)buf;
    u32 n = 0;
    for (u32 i = 0; i + 2u <= olen && i + 2u + old[i + 1] <= olen; i += 2u + old[i + 1]) {
        if (old[i] == EID_EXT_SCHED_IE)
            continue;
        memcpy_fw(d + n, old + i, 2u + old[i + 1]);
        n += 2u + old[i + 1];
    }
    if (n + len <= sizeof(((struct tx_pkt *)0)->payload)) {   /* исправлено: IE хоста до 1024 Б + ESE до 257 Б — за буфер */
        memcpy_fw(d + n, ese, len);
        n += len;
    } else {
        fw_log_emit2(0x2b, LS_FW(BCON_IE_DROPPED), EID_EXT_SCHED_IE, n);
    }
    if (n == 0) {
        TX_API_free_memory(buf);
        buf = 0;
    }
    mid_set_app_ie_block(&mid->bss, 0, n, buf);
}

/* Allocation Start — TSF начала окна (9.4.2.131); станция по 10.39.6.4 игнорирует псевдостатическую
 * аллокацию, начало которой при приёме маяка уже прошло (obsolete). Маяк собирается один раз
 * (add_bcon), поэтому расписание пересобирается каждый BI — в середине BI, с Allocation Start
 * следующего BI (vendor 4.1 так же переиздавал ESE каждый BI; 6.2 ставил начало один раз). */
static void tdma_refresh_cb(u32 a0, u32 a1)
{
    struct mid *mid = (struct mid *)a0;
    (void)a1;
    mid->sched->tdma_armed = 0;
    if (mid->sched->tdma_owned != 0)
        tdma_ap_update(mid, 0);             /* пересобрать и взвести снова */
}

static void tdma_arm(struct mid *mid)
{
    struct sched_scheme *ss = mid->sched;
    if (ss->tdma_armed != 0)
        return;
    u32 bi = mac_get_beacon_interval_us();
    u32 off = MMIO32(HW_MAC_TSF_LO) - mac_get_bi_start_tsf();
    u32 mid_bi = bi / 2u;
    u32 delay = off < mid_bi ? mid_bi - off : bi - off + mid_bi;
    if (delay < 0x20u)
        delay += bi;
    ss->tdma_armed = 1;
    u_schd_schedule(tdma_refresh_cb, (u32)mid, 0, 1, delay, 0, 0);
}

/* Своя таблица окон точки (строгий TDMA) снята: обход снова по ese_slot_tbl (пустой), uc у точки окон не ищет
 * (ese_slot_tbl.mode ≠ ESE_TBL_MODE_OWN) — передача по всему DTI, как без расписания. Записи, уже заложенные в
 * аппаратный массив SP, отрабатывают вхолостую: uc точки без своего расписания по ним только открывает передачу
 * (uc/ese_dti.c), подкачка (событие 0x29) из пустой таблицы ничего не закладывает (lmac_if_evt_walk). Зовёт и путь
 * расписания хоста (WMI 0xa01, fw/wmi_h_bf.c) — до сборки своей таблицы. */
void tdma_own_release(struct sched_scheme *ss)
{
    struct ese_sched *e = ss->ese;
    if (e->tbl != &ese_own_tbl)
        return;
    ese_own_tbl.count = 0;
    ese_slot_tbl.count = 0;
    ese_slot_tbl.mode = 0;
    e->tbl = &ese_slot_tbl;
    e->cur = 0;
    ss->ese_n = 0;
    ss->ese_hash[0] = ss->ese_hash[1] = ss->ese_hash[2] = 0;
}

/* Снять расписание TDMA (если было): весь DTI — CBAP, маяк без ESE. */
static void tdma_clear(struct mid *mid)
{
    struct sched_scheme *ss = mid->sched;
    if (ss->built == 0)
        return;
    tdma_own_release(ss);
    ss->tdma_owned = 0;
    fw_log_emit0(0x2b, 0x1014510);          /* «Clearing scheme» */
    ss->built = 0;                          /* CBAP Only = 1 (builder_push_dmg_parameters) */
    mid_set_beacon_ese(mid, 0, 0);
    add_bcon(mid);
}

/* Окно своей таблицы точки (ese_own_tbl): начинать обмен можно (б7), peer — маска cid получателей; rx_tail — мкс от
 * конца окна до конца следующего SP получателя к точке (там точка — назначение, uc наводит на него приём), 0 — нет. */
static void tdma_own_slot(struct ese_slot *s, u32 id, u32 type, u32 peer, u32 src, u32 dst, u32 off, u32 dur,
                          u32 rx_tail)
{
    s->ctrl = 0;
    s->ctrl_b0 = (u8)((id & 0xfu) | (type << ESE_SLOT_TYPE_SHIFT) | ESE_SLOT_MAY_INIT);
    s->peer_cid = (u8)peer;
    s->src_aid = (u8)src;
    s->dst_aid = (u8)dst;
    s->start = off;
    s->dur = (u16)dur;
    s->rx_tail_us = (u16)rx_tail;
}

/* Окна своей таблицы точки → ese_own_tbl и аппаратный массив SP. Расписание пересобирается каждый BI (Allocation
 * Start), а раскладка окон от начала BI та же: обход (schedule_scheme_start_at_next_bi — два прохода по 4 записи,
 * дальше подкачка по событию uc 0x29) — только при её смене, иначе в массив легли бы повторные записи того же BI. */
static void tdma_own_apply(struct sched_scheme *ss, const struct ese_slot *w, u32 n)
{
    const u8 *p = (const u8 *)w;
    u32 h = 0x811c9du;
    for (u32 i = 0; i < n * sizeof(struct ese_slot); i++)
        h = ((h ^ p[i]) * 0x193u) & 0xffffffu;
    u32 old = ss->ese_hash[0] | ((u32)ss->ese_hash[1] << 8) | ((u32)ss->ese_hash[2] << 16);
    if (ss->ese->tbl == &ese_own_tbl && ss->ese_n == n && old == h)
        return;
    struct ese_sched *e = ss->ese;
    ese_own_tbl.count = 0;                  /* uc между записями видит «окон нет» — передача закрыта, не открыта */
    memcpy_fw(&ese_own_tbl.slot[0], w, n * sizeof(struct ese_slot));
    ese_own_tbl.count = (u8)n;
    ese_slot_tbl.count = 0;
    ese_slot_tbl.mode = ESE_TBL_MODE_OWN;
    e->tbl = &ese_own_tbl;
    e->cur = 0;
    ss->ese_n = (u8)n;
    ss->ese_hash[0] = (u8)h;
    ss->ese_hash[1] = (u8)(h >> 8);
    ss->ese_hash[2] = (u8)(h >> 16);
    schedule_scheme_start_at_next_bi(ss);
}

/* Строгий TDMA (10.39.6.2): общее CBAP, на станцию i — SP точка → i и SP i → точка, при длинном BI — CBAP остатка.
 * aid/cid — станции в порядке списка соединений. */
static __attribute__((noinline)) void tdma_sp_build(struct mid *mid, const u8 *aid, const u8 *cid, u32 n)
{
    struct sched_scheme *ss = mid->sched;
    u32 bi = mac_get_beacon_interval_us();
    u32 g = tdma_guard_us(bi);
    u32 gl = g > TDMA_LISTEN_US ? g : TDMA_LISTEN_US;
    u32 nf = 1u + 2u * n;                   /* полей ESE: общее CBAP + 2 SP на станцию */
    u32 nmax = nf < ESE_FIELDS_MAX ? nf + 1u : nf;
    /* T0 — по длине маяка с наибольшим ESE (с CBAP остатка): окна не раньше конца BHI при любом исходе ниже */
    u32 t0 = tdma_dti_start_us(mid, 2u + nmax * ESE_FIELD_LEN) + g;
    /* T0, общее CBAP, Tguard, 2n SP через max(Tguard, aDMGPPMinListeningTime), Tguard до TBTT */
    u32 fixed = t0 + TDMA_COMMON_US + g + (2u * n - 1u) * gl + g;
    if (fixed + 2u * n * TDMA_MIN_WIN_US > bi) {
        tdma_clear(mid);                    /* BI мал для SP всех станций (как в простом делении) */
        return;
    }
    u32 w = (bi - fixed) / (2u * n);
    if (w > TDMA_SP_MAX_US)
        w = TDMA_SP_MAX_US;
    u32 sp_end = t0 + TDMA_COMMON_US + g + 2u * n * w + (2u * n - 1u) * gl;
    u32 rest = 0;                           /* CBAP остатка BI (SP упёрлись в 32 767 мкс) */
    if (nf < ESE_FIELDS_MAX && bi - sp_end >= 2u * g + TDMA_MIN_WIN_US) {
        rest = bi - sp_end - 2u * g;
        if (rest > TDMA_CBAP_MAX_US)
            rest = TDMA_CBAP_MAX_US;
        nf++;
    }
    u32 buf = TX_API_alloc_tx_payload();   /* до 2 + 17·15 = 257 Б — не на стеке */
    u8 *ie = (u8 *)buf;
    struct ese_slot own[ESE_OWN_SLOTS_N];
    u32 no = 0;
    u32 base = mac_get_bi_start_tsf() + bi; /* Allocation Start — TSF в следующем BI */
    u32 t = t0, k = 0;
    u8 ap = mid->aid;                       /* AID точки — 0 (9.4.1.8) */
    ie[0] = EID_EXT_SCHED_IE;
    ie[1] = (u8)(nf * ESE_FIELD_LEN);
    tdma_fill_ese_alloc_field(&ie[2], 0, ESE_TYPE_CBAP, 0xff, 0xff, base + t, TDMA_COMMON_US);
    tdma_own_slot(&own[no++], 0, ESE_TYPE_CBAP, 0xff, 0xff, 0xff, t, TDMA_COMMON_US, 0);
    t += TDMA_COMMON_US + g;
    k = 1;
    for (u32 i = 0; i < n; i++) {
        /* Allocation ID 1 у обеих: кортеж (Source AID, Destination AID, Allocation ID) различается адресами */
        tdma_fill_ese_alloc_field(&ie[2u + k++ * ESE_FIELD_LEN], 1, ESE_TYPE_SP, ap, aid[i], base + t, w);
        if (no < ESE_OWN_SLOTS_N)
            tdma_own_slot(&own[no++], 1, ESE_TYPE_SP, 1u << cid[i], ap, aid[i], t, w, gl + w);   /* за ним SP i → точка */
        t += w + gl;
        tdma_fill_ese_alloc_field(&ie[2u + k++ * ESE_FIELD_LEN], 1, ESE_TYPE_SP, aid[i], ap, base + t, w);
        t += w + gl;
    }
    if (rest != 0) {
        t = sp_end + g;
        tdma_fill_ese_alloc_field(&ie[2u + k++ * ESE_FIELD_LEN], 0, ESE_TYPE_CBAP, 0xff, 0xff, base + t, rest);
        if (no < ESE_OWN_SLOTS_N)
            tdma_own_slot(&own[no++], 0, ESE_TYPE_CBAP, 0xff, 0xff, 0xff, t, rest, 0);
    }
    ss->built = 1;                          /* CBAP Only = 0 */
    ss->tdma_owned = 1;
    mid_set_beacon_ese(mid, ie, 2u + nf * ESE_FIELD_LEN);
    TX_API_free_memory(buf);
    tdma_own_apply(ss, own, no);
    add_bcon(mid);
    tdma_arm(mid);
    fw_log_emit3(0x2b, LS_FW(TDMA_SP_SCHED), n, w, g);
}

/* Простое деление: общее CBAP и по CBAP станция i → точка (10.39.5). */
static __attribute__((noinline)) void tdma_equal_build(struct mid *mid, const u8 *aid, u32 n)
{
    struct sched_scheme *ss = mid->sched;
    u8 ie[2u + (TDMA_MAX_STA + 1u) * ESE_FIELD_LEN];
    u32 ese_len = 2u + (n + 1u) * ESE_FIELD_LEN;
    u32 bi = mac_get_beacon_interval_us();
    u32 g = tdma_guard_us(bi);
    u32 t0 = tdma_dti_start_us(mid, ese_len) + g;
    u32 need = t0 + TDMA_COMMON_US + (n + 1u) * g + n * TDMA_MIN_WIN_US;
    if (need >= bi) {
        /* BI мал для окон всех станций — расписание снимается: иначе в маяке оставался прежний ESE с
         * Allocation Start прошлого BI (устаревшая аллокация, 10.39.6.1), а таймер пересборки не взводился */
        tdma_clear(mid);
        return;
    }
    u32 w = (bi - t0 - TDMA_COMMON_US - (n + 1u) * g) / n;
    if (w > TDMA_CBAP_MAX_US)
        w = TDMA_CBAP_MAX_US;               /* Allocation Block Duration — u16, мкс (9.4.2.131) */
    u32 base = mac_get_bi_start_tsf() + bi;  /* Allocation Start — TSF в следующем BI */
    ie[0] = EID_EXT_SCHED_IE;
    ie[1] = (u8)(ese_len - 2u);
    u32 t = t0;
    tdma_fill_ese_alloc_field(&ie[2], 0, ESE_TYPE_CBAP, 0xff, 0xff, base + t, TDMA_COMMON_US);
    t += TDMA_COMMON_US + g;
    for (u32 i = 0; i < n; i++) {
        tdma_fill_ese_alloc_field(&ie[2u + (i + 1u) * ESE_FIELD_LEN], i + 1u, ESE_TYPE_CBAP, aid[i], mid->aid, base + t,
                                  w);
        t += w + g;
    }
    ss->built = 1;                          /* CBAP Only = 0 */
    ss->tdma_owned = 1;
    mid_set_beacon_ese(mid, ie, ese_len);
    add_bcon(mid);
    tdma_arm(mid);
    fw_log_emit1(0x2b, 0x1014450, n + 1u); /* «Number of slots in cmd» */
}

/* Пересобрать расписание точки: связь или разрыв станции (exclude — разрываемое соединение). */
void tdma_ap_update(struct mid *mid, const struct conn *exclude)
{
    u8 aid[TDMA_MAX_STA], cid[TDMA_MAX_STA];
    u32 n = 0, it;
    struct sched_scheme *ss = mid->sched;
    if (mid->bss.mode != 2 && mid->bss.mode != 3)
        return;                             /* только AP/PCP */
    iter_init(&it, &mid->conns);
    while (list_has_items(&it) && n < TDMA_MAX_STA) {
        struct conn *c = (struct conn *)iter_next(&it);
        u32 st = c->msm.sm.state;
        /* связанная станция: состояние 5..7 (ASSOCIATED, WAIT_FOR_LM_START, KEY_ASSOC). AID: при SME
         * хоста — из его ответа (conn->aid, mlme_sm_on_ctrl_assoc_response_ret); при SME прошивки
         * conn->aid = 0, а в Assoc Response уходит cid + 1 (mgmt_tx_build_assoc_resp). */
        if (c != exclude && st >= 5 && st <= 7) {
            aid[n] = c->aid != 0 ? c->aid : (u8)(c->cid + 1u);
            cid[n++] = c->cid;
        }
    }
    if (ss->built != 0 && ss->tdma_owned == 0)
        return;                             /* расписание задал хост (WMI 0xa01) — не трогать */
    u32 min = ss->ese->tdma_min_sta != 0 ? ss->ese->tdma_min_sta : TDMA_MIN_STA;
    if (ss->ese->tdma_off != 0 || n < min) {
        tdma_clear(mid);
        return;
    }
    if (ss->ese->tdma_mode == WMI_SPARRAW_TDMA_MODE_SP) {
        tdma_sp_build(mid, aid, cid, n);
        return;
    }
    tdma_own_release(ss);                   /* из строгого — в простое деление */
    tdma_equal_build(mid, aid, n);
}

/* WMI_SPARRAW_TDMA_CFG (0x0f10): включить/выключить TDMA точки, порог и режим; применяется сразу. Неизвестный режим —
 * команда отвергается целиком (журнал), прежняя настройка остаётся. */
void wmi_sparraw_tdma_cfg(const struct wmi_sparraw_tdma_cfg_cmd *cmd, u32 mid_id)
{
    struct mid *mid = mid_list_by_mid_fw(mid_id);
    if (mid == 0)
        return;
    if (cmd->mode != WMI_SPARRAW_TDMA_MODE_EQUAL && cmd->mode != WMI_SPARRAW_TDMA_MODE_SP) {
        fw_log_emit3(0, LS_FW(WMI_BAD_PARAM), WMI_SPARRAW_TDMA_CFG_CMDID, cmd->mode,
                     __builtin_offsetof(struct wmi_sparraw_tdma_cfg_cmd, mode));
        return;
    }
    mid->sched->ese->tdma_off = cmd->enable == 0 ? 1u : 0u;
    mid->sched->ese->tdma_min_sta = cmd->min_sta;
    mid->sched->ese->tdma_mode = cmd->mode;
    fw_log_emit3(0x2b, LS_FW(TDMA_CFG), cmd->enable, cmd->min_sta, cmd->mode);
    tdma_ap_update(mid, 0);
}
