/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Наборы RF (RF-сеты) и параметры развёртки секторов, общие с ucode (vendor 6.2).
 * Блок 0x857730..0x8577b7 (вне DCCM) заполняет разбор
 * board-файла (handle_rf_sets_info / build_tx_sector_list, fw/brd_if.c) и RF-объект
 * (fw/rf.c); ucode читает его volatile (include/fwsh.h: FWSH(fwsh_sets, …), псевдонимы
 * fwsh_n_sets, fwsh_set_ranges).
 * Диапазоны секторов конфигураций по набору — rf_set_ranges (0x84783c, 8 × 64 Б; до таблицы
 * fixed-sched 0x847a3c). Символы — fw/fw.ld. */
#ifndef RF_SETS_H
#define RF_SETS_H
#include "types.h"
#include "fwsh.h"

/* RF_SETS_MAX, struct rf_sec_range, struct fwsh_sets (0x857730) и объект fwsh_sets — include/fwsh.h. */

extern struct rf_sec_range rf_set_ranges[RF_SETS_MAX][32]; /* 0x84783c */

#endif
