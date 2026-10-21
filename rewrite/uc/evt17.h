/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Отчёт 0x44 Б (17 слов) для uc_send_evt_bf_done / uc_send_evt_new_link. */
#ifndef UC_EVT17_H
#define UC_EVT17_H
void uc_send_evt_bf_done(u32, u32, u32, u32, u32, u32, u32, u32,
                         u32, u32, u32, u32, u32, u32, u32, u32, u32);
void uc_send_evt_new_link(u32, u32, u32, u32, u32, u32, u32, u32,
                          u32, u32, u32, u32, u32, u32, u32, u32, u32);
#define EVT17(w) w[0], w[1], w[2], w[3], w[4], w[5], w[6], w[7], w[8], w[9], \
                 w[10], w[11], w[12], w[13], w[14], w[15], w[16]
#endif
