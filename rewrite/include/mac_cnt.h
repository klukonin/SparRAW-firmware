/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Блоки аппаратных счётчиков MAC (MMIO): RX 0x8872c4, TX 0x887744. fw обращается к ним
 * через указатели в DCCM [gp,0x24c] = 0x8003d0 и [gp,0x250] = 0x8003d4 (как vendor).
 * Имена полей — по функциям vendor (mac_rx_cnt__*, mac_tx_cnt__*); смысл безымянных
 * счётчиков TX не установлен. */
#ifndef MAC_CNT_H
#define MAC_CNT_H
#include "types.h"

#define MAC_CNT_OFF(t, f, o) _Static_assert(__builtin_offsetof(t, f) == (o), #t "." #f)

#define MAC_RX_CNT_MCS_N 14

/* Счётчики RX (0x8872c4). */
struct mac_rx_cnt {
    volatile u32 rsv_00;
    volatile u32 crc_err;                      /* 0x04: mac_rx_cnt__get_crc_total (+ crc_ok) */
    volatile u32 crc_ok;                       /* 0x08 */
    volatile u32 rsv_0c;
    volatile u32 crc_err_mcs[MAC_RX_CNT_MCS_N];   /* 0x10: по id (stats__read_counter_by_id); [0] — MCS0 */
    volatile u32 crc_ok_mcs[MAC_RX_CNT_MCS_N];    /* 0x48: парные к crc_err_mcs (+0x38) */
    volatile u32 rsv_80[15];
    volatile u32 cnt64_lo;                     /* 0xbc: u64 (mac_rx_cnt__get_u64_bc) */
    volatile u32 cnt64_hi;                     /* 0xc0 */
};
MAC_CNT_OFF(struct mac_rx_cnt, crc_err, 0x04);
MAC_CNT_OFF(struct mac_rx_cnt, crc_err_mcs, 0x10);
MAC_CNT_OFF(struct mac_rx_cnt, crc_ok_mcs, 0x48);
MAC_CNT_OFF(struct mac_rx_cnt, cnt64_lo, 0xbc);
_Static_assert(sizeof(struct mac_rx_cnt) == 0xc4, "mac_rx_cnt");

/* Счётчики TX (0x887744). */
struct mac_tx_cnt {
    volatile u32 rsv_00[4];
    volatile u32 cnt_10;                       /* 0x10: база pring_tx_cnt_base_10 */
    volatile u32 cnt64_lo;                     /* 0x14: u64 (mac_tx_cnt__get_u64_14) */
    volatile u32 cnt64_hi;                     /* 0x18 */
    volatile u32 rsv_1c;
    volatile u32 cnt_20;                       /* 0x20: вычитается в mac_tx_cnt__delta_88_net_of_20 */
    volatile u32 rsv_24[9];
    volatile u32 ok;                           /* 0x48: mac_tx_cnt__get_ok */
    volatile u32 rsv_4c;
    volatile u32 fail;                         /* 0x50: mac_tx_cnt__get_fail */
    volatile u32 rsv_54[13];
    volatile u32 cnt_88;                       /* 0x88: база pring_tx_cnt_base_88 */
};
MAC_CNT_OFF(struct mac_tx_cnt, cnt_10, 0x10);
MAC_CNT_OFF(struct mac_tx_cnt, cnt64_lo, 0x14);
MAC_CNT_OFF(struct mac_tx_cnt, cnt_20, 0x20);
MAC_CNT_OFF(struct mac_tx_cnt, ok, 0x48);
MAC_CNT_OFF(struct mac_tx_cnt, fail, 0x50);
MAC_CNT_OFF(struct mac_tx_cnt, cnt_88, 0x88);
_Static_assert(sizeof(struct mac_tx_cnt) == 0x8c, "mac_tx_cnt");

extern struct mac_rx_cnt mac_rx_cnt_regs;      /* 0x8872c4 (fw.ld) */
extern struct mac_tx_cnt mac_tx_cnt_regs;      /* 0x887744 (fw.ld) */
extern struct mac_rx_cnt *volatile mac_rx_cnt_blk;   /* 0x8003d0: [gp,0x24c] */
extern struct mac_tx_cnt *volatile mac_tx_cnt_blk;   /* 0x8003d4: [gp,0x250] */

#endif
