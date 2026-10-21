// SPDX-License-Identifier: AGPL-3.0-or-later
/* Функции, на которые ссылаются только данные (таблица автомата BI в uc_data,
 * колбэки VENDOR_CB) — удерживаем от --gc-sections в полном образе. */
#include "../include/types.h"

__attribute__((used, section(".uc_keep")))
static const void *const uc_keep[] = {
    bi_sm_action_92150c, bi_sm_action_92153c, bi_sm_action_92156c, bi_sm_action_923a5c,
    bi_sm_action_9262e8, bi_sm_action_92646c, bi_sm_action_935a08, bi_sm_action_935a94,
    bi_sm_action_935b4c, bi_sm_action_935d0c,
    bf_req_report_20_cb, bf_req_report_21_cb, bf_req_report_26_cb,
    bf_req_claim_and_report_23, bf_req_claim_and_report_2b, rf_gain_adjust_cb,
    abft_send_ssw_feedback, direct_tx_short_frame0_cb, direct_tx_short_frame2_cb,
    uc_init_cb_globals, uc_init_cb_copy_8006b7, uc_init_cb_more, uc_init_cb_801aec,
    uc_init_cb_cmdq, ucode_cmdq_handler, notify_aoa_build,
};
