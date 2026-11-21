// SPDX-License-Identifier: AGPL-3.0-or-later
/* Функции, на которые ссылаются только данные (таблица автомата BI в uc_data,
 * колбэки VENDOR_CB) — удерживаем от --gc-sections в полном образе. */
#include "../include/types.h"

__attribute__((used, section(".uc_keep")))
static const void *const uc_keep[] = {
    bi_sm_on_bhi_to_aw_in_aw, bi_sm_on_bhi_to_dti_in_aw, bi_sm_on_dti_to_bti_in_aw, bi_sm_on_aw_to_dti_in_bti,
    bi_sm_on_event_in_dti, bi_sm_action_invalid, bi_sm_on_bti_to_abft, bi_sm_on_enter_aw,
    bi_sm_on_dti_to_bti, bi_sm_on_enter_dti,
    bf_req_report_energy_cb, bf_req_report_plcp_cb, bf_req_report_phystat_cb,
    bf_req_report_pkt_cb, bf_req_report_chest_cb, rf_gain_adjust_cb,
    abft_send_ssw_feedback, direct_tx_short_frame0_cb, direct_tx_short_frame2_cb,
    uc_init_cb_copy_rf_mask, uc_init_cb_rx_meas, uc_init_cb_bi_sm_name,
    uc_init_cb_cmdq, ucode_cmdq_handler, bf_done_report_build_send,
    /* основа PP/GP (uc/dynalloc.c, docs/TDMA.md §6): обмен в эфир ещё не подключён, расчёт сверяет
     * tests/unit/test_tdma_dynalloc.py */
    dyn_pp_poll, dyn_spr_duration, dyn_gp_grant_duration, dyn_poll_frame_init, dyn_spr_frame_init,
};
