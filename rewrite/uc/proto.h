/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* АВТОГЕНЕРАЦИЯ tools/gen_uc_proto.py — не править руками. */
#ifndef UC_PROTO_H
#define UC_PROTO_H
#include "../include/types.h"

struct arc_ap_cfg;
struct aw_win_s;
struct bi_ctx_s;
struct dtx_ctrl_frame;
struct dtx_grant_req;
struct fsched_peer_ctx;
struct lmac_cmd_bf_ctrl;
struct lmac_cmd_discovery;
struct lmac_cmd_fsched_peer;
struct lmac_cmd_mac_cfg;
struct lmac_cmd_maint_sta;
struct lmac_cmd_qset_ranges;
struct lmac_cmd_rf_chain;
struct lmac_cmd_rf_sector_sel;
struct lmac_cmd_role;
struct lmac_cmd_rs_cfg;
struct lmac_cmd_rx_on;
struct lmac_cmd_sel_nbr;
struct lmac_cmd_ss_order;
struct lmac_cmd_sta_byte2;
struct lmac_cmd_sta_cfg;
struct lmac_cmd_sta_field;
struct lmac_cmd_vring_cfg;
struct lmac_cmd_write_qh;
struct lmac_mac_regs;
struct mbox_ring_ctl;
struct pm_ctx_s;
struct qh_desc3_win;
struct rf_fill_info;
struct rx_meas_ctx;
struct sls_peer_rec;
struct sm_desc;
struct sm_obj;
struct ss_cfg_s;
struct ssw_ack_frame;
struct tx_ctx_s;
struct uc_mbox_ctx;
struct uc_ring;

u32 abft_arm_response_window(void);                             /* bti.c */
u32 abft_resp_parse_fdbk(struct sls_peer_rec *dst);             /* bti.c */
void abft_responder_respond_flow(struct sls_peer_rec *r);       /* bti.c */
u32 abft_responder_tx_ssw(u32 a);                               /* bti.c */
void abft_send_ssw_feedback(u32 a);                             /* bti.c */
void abif_set_88a204_field(u32 a, u32 b);                       /* tail.c */
void abif_set_enable_bit(u32 a);                                /* tail.c */
void arc_program_action_point(const struct arc_ap_cfg *a);      /* tail.c */
void arc_protect_addr_uc(u32 a, u32 b, u32 c);                  /* tail.c */
void aw_compute_tbtt_from_hw(u32 a, u32 *out);                  /* bti.c */
void aw_fold_peer_masks(u32 a, u32 b, u32 c);                   /* bti.c */
void aw_open_event_mask(void);                                  /* bti.c */
void aw_set_new_tbtt(struct pm_ctx_s *p);                       /* bti.c */
void aw_start_window(struct aw_win_s *w, u32 b);                /* bti.c */
void aw_worker_collect_awake_peers(struct aw_win_s *w);         /* bti.c */
u32 aw_worker_read_dma_881c84(void);                            /* bti.c */
u32 background_bi_step(void);                                   /* tail.c */
void background_task_dispatch(void);                            /* sched.c */
void bap_q_avail_check(u32 a, u32 b, u32 c);                    /* tail.c */
void basic_sm_bind_descriptor_uc(struct sm_obj *a, const struct sm_desc *b); /* util.c */
void bcon_txss_program_sector(u32 a, u32 b, u32 c);             /* tail.c */
u32 bcon_txss_sweep_step(u32 a, u32 b, u32 c, u32 d, u32 e, u32 f); /* tail.c */
void bf_abort_noop_hook(u32 a);                                 /* bf.c */
void bf_abort_step(u32 a);                                      /* bf.c */
void bf_abort_to_state11(u32 a);                                /* bf.c */
u32 bf_abort_unexpected(u32 a0, u32 a1);                        /* bf.c */
void bf_clear_all_sta(void);                                    /* bf.c */
void bf_clear_pending_and_notify(u32 a);                        /* bf.c */
void bf_clear_sta_bit_state34(u32 bit, u32 st);                 /* bf.c */
void bf_ctx_dispatch_by_role(struct sls_peer_rec *a);           /* bf.c */
void bf_enter_mode3(u32 a, u32 b);                              /* bf.c */
void bf_flow_exit(u32 a0);                                      /* bf.c */
void bf_gpc_program_mac_by_mode_b(u32 a0);                      /* bf.c */
void bf_init_globals(void);                                     /* bf.c */
void bf_init_sm(u32 a, u32 b);                                  /* bf.c */
void bf_metrics_reset_and_stamp(void);                          /* bf.c */
void bf_pause_sta_tx(u32 a0, u32 a1);                           /* bf.c */
void bf_pending_clear_bit(u32 bit);                             /* bf.c */
void bf_pending_set_bit(u32 bit);                               /* bf.c */
void bf_req_claim_and_report_23(struct rx_meas_ctx *m);         /* bf.c */
void bf_req_claim_and_report_2b(struct rx_meas_ctx *m);         /* bf.c */
u32 bf_req_dequeue_head(u32 a0, u32 a1);                        /* bf.c */
u32 bf_req_enqueue(u32 a0, u32 a1, u32 a2);                     /* bf.c */
void bf_req_report_20_cb(struct rx_meas_ctx *m);                /* cmd.c */
void bf_req_report_21_cb(struct rx_meas_ctx *m);                /* cmd.c */
void bf_req_report_26_cb(struct rx_meas_ctx *m);                /* cmd.c */
u32 bf_req_try_claim(struct rx_meas_ctx *m, u32 kind);          /* bf.c */
void bf_reset_sta(u32 a0, u32 a1);                              /* bf.c */
void bf_reset_sta_slot(u32 a0);                                 /* bf.c */
void bf_resume_sta_tx(u32 a0, u32 a1);                          /* bf.c */
u32 bf_sm_brp_init_result(u32 a0);                              /* bf.c */
void bf_sm_brp_noop_hook_a(void);                               /* bf.c */
void bf_sm_brp_noop_hook_b(void);                               /* bf.c */
u32 bf_sm_brp_resp_result(u32 a);                               /* bf.c */
u32 bf_sm_clear_slot_diag(void);                                /* bf.c */
u32 bf_sm_dispatch_by_state(u32 sta);                           /* bf.c */
u32 bf_sm_on_brp_init(u32 a0);                                  /* bf.c */
u32 bf_sm_on_brp_resp(u32 a0);                                  /* bf.c */
u32 bf_sm_on_txss_init(u32 a0);                                 /* bf.c */
u32 bf_sm_on_txss_resp(u32 a0);                                 /* bf.c */
void bf_sm_process_request_fifo(void);                          /* bf.c */
u32 bf_sm_run_sta(u32 sta);                                     /* bf.c */
void bf_sm_set_sta_state(u32 sta, u32 state);                   /* bf.c */
void bf_sm_set_state(u32 sta, u32 state);                       /* bf.c */
u32 bf_sm_txss_init_result(u32 a0);                             /* bf.c */
u32 bf_sm_txss_resp_result(u32 a0);                             /* bf.c */
void bf_store_flow_status(u32 idx, u32 v);                      /* bf.c */
void bf_trigger_for_mid(u32 a0);                                /* bf.c */
void bf_txss_reset_report_ctx(void);                            /* bf.c */
void bg_task_call_cb20(struct rx_meas_ctx *m);                  /* util.c */
void bi_after_enter_aw(struct bi_ctx_s *c);                     /* bi.c */
void bi_after_enter_dti(struct bi_ctx_s *c);                    /* bi.c */
void bi_bti_timer_step(u32 a, u32 b);                           /* bi.c */
void bi_cfg_fill_slot_desc(u32 a, u32 b);                       /* bi.c */
void bi_cfg_pack_words_78_7c(u32 a, u32 b);                     /* bi.c */
void bi_cfg_pack_words_thunk(u32 a);                            /* bi.c */
void bi_cfg_tick_counters(void);                                /* bi.c */
void bi_ctrl_program_mac_bcon(void);                            /* bi.c */
void bi_ctx_clear_counters(struct pm_ctx_s *p);                 /* bi.c */
void bi_ctx_clear_state_words(void);                            /* bi.c */
void bi_ctx_clear_word0(u32 a);                                 /* bi.c */
void bi_ctx_set_active(struct bi_ctx_s *c);                     /* bi.c */
void bi_dispatch_by_role(struct bi_ctx_s *c);                   /* bi.c */
void bi_dti_step(void);                                         /* bi.c */
void bi_init_set_mac_arg_pair(u32 a, u32 b);                    /* bi.c */
void bi_latch_tsf_and_reset(u32 a);                             /* cmd.c */
u32 bi_manager_eval_bcon_slot(struct aw_win_s *w, u8 *out, u32 *out_word); /* bi.c */
void bi_manager_start_tx_or_initiator(void);                    /* bi.c */
void bi_manager_step_a(struct bi_ctx_s *c);                     /* bi.c */
void bi_manager_step_b(struct sls_peer_rec *r);                 /* bi.c */
void bi_mode_init_sequence(void);                               /* boot.c */
void bi_mode_init_sta_table(void);                              /* stubs.c */
void bi_mode_init_substep(void);                                /* stubs.c */
void bi_mode_load_cmd1e_operand(void);                          /* stubs.c */
void bi_mode_program_mac_timing(void);                          /* stubs.c */
void bi_mode_set_1000_units165(struct aw_win_s *w);             /* bi.c */
u32 bi_remaining_time_us(void);                                 /* bi.c */
void bi_run_bti_cycle(struct bi_ctx_s *c);                      /* bi.c */
void bi_rx_send_response(u32 a, u32 rate, u32 b, u32 flag);     /* bi.c */
void bi_rx_slot_handler(struct aw_win_s *w);                    /* bi.c */
u32 bi_rx_start_rx_window(u32 a, u32 b);                        /* bi.c */
void bi_sm_action_92150c(u32 obj);                              /* bi.c */
void bi_sm_action_92153c(u32 obj);                              /* bi.c */
void bi_sm_action_92156c(void);                                 /* bi.c */
void bi_sm_action_923a5c(void);                                 /* bi.c */
void bi_sm_action_9262e8(void);                                 /* bi.c */
void bi_sm_action_92646c(u32 a);                                /* bi.c */
void bi_sm_action_935a08(u32 obj);                              /* bi.c */
void bi_sm_action_935a94(u32 obj);                              /* bi.c */
void bi_sm_action_935b4c(u32 obj, u32 a);                       /* bi.c */
void bi_sm_action_935d0c(u32 obj);                              /* bi.c */
void bi_sm_init(void);                                          /* bi.c */
u32 bi_state_from_g800600(void);                                /* bi.c */
void bi_timing_snapshot_b(void);                                /* bi.c */
u64 bi_tsf_delta64(u32 a, u32 b);                               /* bi.c */
void bi_tx_check_idle_and_start_uc(u32 a);                      /* bf.c */
u32 bit_iter_has_more_uc(u32 a);                                /* bi.c */
u32 bit_scan_msb(u32 a);                                        /* fsched.c */
void bits_set_u8_s0_w5_uc(u32 ptr, u32 value);                  /* bi.c */
void bits_set_u8_s0_w6_uc(u32 ptr, u32 value);                  /* bi.c */
void bits_set_u8_s0_w7_uc(u32 ptr, u32 value);                  /* bi.c */
void bits_set_u8_s3_w5_uc(u32 ptr, u32 value);                  /* bi.c */
void bits_set_u8_s6_w2_uc(u32 ptr, u32 value);                  /* bi.c */
u32 bitstream_push(u32 a, u32 b, u32 c, u32 d);                 /* fsched.c */
void boot_uc_init_g800610(void);                                /* boot.c */
void boot_uc_init_more(struct rx_meas_ctx *m);                  /* tail.c */
void boot_uc_init_structs(void);                                /* boot.c */
void boot_uc_init_tail(void);                                   /* sched.c */
void boot_uc_set_88000c(u32 v);                                 /* boot.c */
void brp_init_ctx(u32 a);                                       /* brp.c */
u32 brp_init_exchange_request(void);                            /* brp.c */
void brp_init_flow(u32 a);                                      /* brp.c */
void brp_init_reset_ctx(u32 a);                                 /* brp.c */
void brp_init_tx_request(void);                                 /* brp.c */
u32 brp_initiator_brp_transaction_flow(void);                   /* brp.c */
void brp_initiator_flow_successful_receive_training(u32 a);     /* brp.c */
u32 brp_is_peer_ctrl_frame(void);                               /* brp.c */
void brp_iterate_rf_mask(u32 a);                                /* brp.c */
u32 brp_parse_request_fields(u32 a);                            /* brp.c */
void brp_pick_sector_cfg(u32 a);                                /* brp.c */
u32 brp_program_and_measure(u32 a, u32 b, u32 c);               /* brp.c */
void brp_program_mac_sequence_uc(void);                         /* brp.c */
void brp_rank_insert(u32 a, u32 b, u32 c);                      /* brp.c */
void brp_read_rf_id(u32 a);                                     /* brp.c */
void brp_responder_flow_enter(u32 a);                           /* brp.c */
void brp_responder_transmission_flow(void);                     /* brp.c */
void brp_restore_sectors(u32 a);                                /* brp.c */
void brp_rf_module_done(u32 a);                                 /* brp.c */
void brp_rf_store_cfg(u32 a, u32 b, u32 c);                     /* brp.c */
void brp_rf_store_module_byte(u32 a);                           /* brp.c */
void brp_select_cfg_by_snr(u32 a, u32 b, u32 c, u32 d, u32 e, u32 f); /* brp.c */
void brp_set_phy_884060(u32 a);                                 /* brp.c */
void brp_set_tx_sector_id(u32 ptr, u32 value);                  /* brp.c */
u32 brp_split_id(u32 a);                                        /* brp.c */
void brp_update_omni_sector_idx(u32 a, u32 b);                  /* brp.c */
void brp_write_reg_pair(u32 a, u32 b);                          /* brp.c */
void bti_arm_period_gp0(void);                                  /* bti.c */
u32 bti_bi2_event_step(struct bi_ctx_s *c);                     /* bti.c */
u32 bti_bi2_gp2_end_flag(void);                                 /* bti.c */
void bti_bi2_track_best_metric(struct bi_ctx_s *c);             /* bti.c */
void bti_clear_cid_sweep_counters(void);                        /* bti.c */
void bti_clear_sweep_counters(u32 a);                           /* bti.c */
void bti_count_sweep_round(struct bi_ctx_s *c);                 /* bti.c */
void bti_dispatch_sweep_step(struct bi_ctx_s *c, u32 b);        /* bti.c */
void bti_measure_frame_duration(u32 a);                         /* bti.c */
u32 bti_prepare_sweep_set(struct bi_ctx_s *c, u32 kind);        /* bti.c */
u32 bti_r54_event_bit6(void);                                   /* bti.c */
void bti_request_bf_metric(void);                               /* bti.c */
void bti_reset_sweep_state(struct bi_ctx_s *c);                 /* bti.c */
void bti_transmitter_bi2_flow(struct bi_ctx_s *c);              /* bti.c */
void bti_tx_program_bi2_regs(u32 a);                            /* bti.c */
u32 bti_worker_bi2_step(u32 a, u32 b);                          /* bti.c */
void bti_worker_bti_transmitter_beacon_sweep_flow(struct bi_ctx_s *c); /* bti.c */
void buf_check_bounds(struct uc_ring *r);                       /* util.c */
void buf_fill_ff(struct rx_meas_ctx *m);                        /* tail.c */
u32 cf_end_send_frame(struct tx_ctx_s *a, u32 b, u32 c, u32 d, u32 e); /* tail.c */
void clk_gate_880b00(u32 a);                                    /* util.c */
void config_brp_rf(u32 a, u32 b);                               /* tail.c */
void cpu_aux28_set_bits12(void);                                /* boot.c */
void delay_800_iters(void);                                     /* util.c */
void direct_tx_build_desc(const struct sls_peer_rec *s, u32 *b); /* tx.c */
void direct_tx_init_rx_desc(struct dtx_ctrl_frame *a, u32 b, u32 c); /* tx.c */
void direct_tx_issue_cmd_33(void);                              /* tx.c */
void direct_tx_program_cmd34(u32 a, u32 b);                     /* tx.c */
void direct_tx_send_after_delay(u32 a, u32 b, u32 c);           /* tx.c */
u32 direct_tx_send_ctrl_frame(const struct dtx_grant_req *a);   /* tx.c */
u32 direct_tx_send_from_desc(u32 desc, u32 sta, u32 use_cfg, u32 cfg_hi, u32 rf_cfg, u32 rate, u32 len); /* tx.c */
void direct_tx_send_short_frame(u32 a);                         /* tx.c */
void direct_tx_send_with_seq(u32 a, u32 b, u32 c);              /* tx.c */
void direct_tx_short_frame0_cb(void);                           /* cmd.c */
void direct_tx_short_frame2_cb(void);                           /* cmd.c */
void direct_tx_step(struct sls_peer_rec *a);                    /* tail.c */
void disable_tsf_event(void);                                   /* tail.c */
u32 dma_is_idle_uc(u32 q, u32 verbose);                         /* misc.c */
u32 dma_is_tx_pipe_idle(u32 a, u32 b, u32 c);                   /* misc.c */
void dma_mac_cfg_880c14(u32 a);                                 /* misc.c */
void dma_mac_cfg_880c28(u32 a);                                 /* misc.c */
void dma_mac_cfg_880c2c(u32 v);                                 /* phy.c */
u32 dma_read_881c28(void);                                      /* txss.c */
void dma_write_881c28(u32 v);                                   /* txss.c */
u32 dmaq_hw_read_ptr(u32 q);                                    /* txss.c */
void dti_alloc_dispatch(struct bi_ctx_s *c);                    /* tail.c */
void dti_alloc_scheduled_event_thunk(u32 *wake);                /* tail.c */
void dti_worker_scheduled_dti_allocation_event(u32 *wake);      /* tail.c */
void dump_mac_buffer_bases(u32 a, u32 b);                       /* misc.c */
u32 dump_pring_hw(u32 q);                                       /* misc.c */
void dump_vring_pring_info(u32 q);                              /* misc.c */
void evt_queue_noop_lock_hook(void);                            /* util.c */
void evt_queue_take_locked(struct uc_mbox_ctx *a, u32 a1, u32 a2, u32 a3); /* tail.c */
void field_set_0x00_934998(u32 a);                              /* bi.c */
void field_set_0x00_934b8c(u32 a, u32 b);                       /* misc.c */
u32 fixed_sched_check_slot_flag(struct fsched_peer_ctx *p);     /* l1.c */
u32 fixed_sched_is_engaged(void);                               /* fsched.c */
void fixed_sched_manager_decrement_curr_sta_rd_counter(struct fsched_peer_ctx *p); /* l1.c */
u32 fixed_sched_read_slot_id(struct fsched_peer_ctx *p);        /* l1.c */
void fixed_sched_run_tx_slot(void);                             /* l1.c */
u16 fixed_sched_slot_cfg_u16_2(struct fsched_peer_ctx *p);      /* l1.c */
void fixed_sched_slot_prepare(u32 a);                           /* l1.c */
void fixed_sched_slot_setup(struct fsched_peer_ctx *p);         /* l1.c */
u32 fixed_sched_slot_word8(struct fsched_peer_ctx *p);          /* l1.c */
void frame_hdr_init(struct dtx_ctrl_frame *dst, u32 arg1, u32 arg2, const struct dtx_grant_req *src); /* misc.c */
void fsched_ap_copy_slot_byte1(struct fsched_peer_ctx *p);      /* fsched.c */
u32 fsched_ap_next_station(struct fsched_peer_ctx *p);          /* fsched.c */
u32 fsched_ap_poll_station(struct fsched_peer_ctx *p);          /* fsched.c */
u32 fsched_ap_start_slot(void);                                 /* fsched.c */
u32 fsched_ap_station_done(struct fsched_peer_ctx *p);          /* fsched.c */
u32 fsched_arm_slot_from_cfg(void);                             /* fsched.c */
u32 fsched_arm_slot_timer(u32 a);                               /* fsched.c */
void fsched_bf_req_clear(struct fsched_peer_ctx *p, u32 idx);   /* misc.c */
void fsched_bf_req_set(struct fsched_peer_ctx *p, u32 idx);     /* bf.c */
u8 fsched_cur_entry_byte0(struct fsched_peer_ctx *p);           /* fsched.c */
u8 fsched_cur_entry_byte1(struct fsched_peer_ctx *p);           /* fsched.c */
void fsched_drop_station(u32 bit);                              /* fsched.c */
u8 fsched_get_cur_idx(struct fsched_peer_ctx *p);               /* fsched.c */
void fsched_log_phase(u32 phase, u32 idx);                      /* fsched.c */
void fsched_peer_add(struct fsched_peer_ctx *p, u32 idx);       /* misc.c */
void fsched_peer_clear_qid(struct fsched_peer_ctx *p, u32 idx); /* misc.c */
void fsched_peer_deactivate(struct fsched_peer_ctx *p, u32 idx); /* misc.c */
void fsched_peer_set_qid(struct fsched_peer_ctx *p, u32 idx, u32 qid); /* misc.c */
u32 fsched_pick_queue_r41(u32 a);                               /* fsched.c */
u32 fsched_pick_ready_queue(u32 a);                             /* fsched.c */
void fsched_run_tx_slot_twice(void);                            /* fsched.c */
u32 fsched_rx_slot(void);                                       /* fsched.c */
u8 fsched_slot_byte0(struct fsched_peer_ctx *p);                /* fsched.c */
void fsched_slot_clear_f2(struct fsched_peer_ctx *p);           /* fsched.c */
void fsched_slot_clear_f3(struct fsched_peer_ctx *p);           /* fsched.c */
void fsched_slot_clear_f4(struct fsched_peer_ctx *p);           /* fsched.c */
u32 fsched_slot_f3_positive(struct fsched_peer_ctx *p);         /* fsched.c */
u16 fsched_slot_half4(struct fsched_peer_ctx *p);               /* fsched.c */
void fsched_slot_inc_f2(struct fsched_peer_ctx *p);             /* fsched.c */
u32 fsched_slot_inc_f4_reached_7(struct fsched_peer_ctx *p);    /* fsched.c */
u32 fsched_test_mask2c_bit(struct fsched_peer_ctx *p, u32 bit); /* fsched.c */
u32 fsched_time_left_class(u32 a);                              /* fsched.c */
u32 fsched_tx_ctrl_frame(void);                                 /* fsched.c */
void fwif_write_qh(const struct lmac_cmd_write_qh *c);          /* cmd.c */
void g_80212c_reset(void);                                      /* bf.c */
u32 get_mem_857744_x2(void);                                    /* util.c */
u32 get_mem_857744_x2_928308(void);                             /* tail.c */
void get_selected_rf_sector_index_cmd_handler(const struct lmac_cmd_rf_sector_sel *c); /* cmd.c */
void gp0_arm_usec_b(u32 usec);                                  /* tail.c */
void gp_timer_arm(u32 a, u32 b, u32 c, u32 d);                  /* tail.c */
void gp_timer_stop(u32 a);                                      /* bi.c */
u32 grant_detect_step(u32 a, u32 b, u32 c);                     /* tail.c */
void handle_bf_triggers(u32 cid, u32 set);                      /* tail.c */
void handle_pmc_triggers(u32 trigger, u32 param);               /* tail.c */
void hw_bring_up_phy_dma(u32 a0, u32 a1);                       /* tail.c */
void hw_power_sequence_rf(u32 a0, u32 a1);                      /* tail.c */
void hw_power_step(u32 a0);                                     /* tail.c */
void hwd_abif_rfc_divider_restart_uc(void);                     /* misc.c */
void hwd_dma_set_mode_map(u32 a);                               /* misc.c */
void hwd_phy_init_2(void);                                      /* phy.c */
void hwd_phy_pwr(u32 v);                                        /* phy.c */
void hwd_phy_rx_set_agc_start_val_and_gain_array_uc(u32 a, u32 b); /* misc.c */
void hwd_phy_set_mode_uc(u32 mode);                             /* phy.c */
void hwd_phy_uses_rgf_881000_9296e0(u32 v);                     /* phy.c */
void hwd_phy_uses_rgf_881000_929730(u32 v);                     /* phy.c */
void hwd_phy_uses_rgf_883000(u32 v);                            /* phy.c */
void hwd_phy_uses_rgf_883800_929af4(u32 *out);                  /* phy.c */
void hwd_phy_uses_rgf_883800_929b94(u32 *out);                  /* phy.c */
void hwd_phy_uses_rgf_884000(u32 v);                            /* phy.c */
u32 hwd_rfc_auto_fill_verify(const struct rf_fill_info *f, u32 b, u32 c); /* misc.c */
void hwd_rfc_powerdown_deep_all_rfs(void);                      /* misc.c */
void hwd_rfc_powerup_deep_all_rfs(void);                        /* misc.c */
u32 hwd_rfc_read_rgf_uc(u32 a, u32 b);                          /* txss.c */
void hwd_rfc_write_core(u32 a, u32 b, u32 c, u32 d);            /* txss.c */
void internal_tx_check_idle(u32 a);                             /* tx.c */
void internal_tx_clear_exclude_mask(void);                      /* tx.c */
void internal_tx_clear_pending(u32 a);                          /* tx.c */
void internal_tx_clear_pending_bit(u32 bit);                    /* tx.c */
void internal_tx_drop_event_mask_and_publish(void);             /* tx.c */
void internal_tx_flow_sm2(u32 a);                               /* tx.c */
void internal_tx_isr(void);                                     /* tail.c */
void internal_tx_noop_isr_hook(void);                           /* tx.c */
void internal_tx_set_pending_flag(void);                        /* tx.c */
void irq_init_event_masks(void);                                /* tail.c */
u32 irq_safe_deref_field_04(struct uc_mbox_ctx *m);             /* boot.c */
u32 itx_rr_pick_pending_b(u32 out);                             /* tx.c */
u32 itx_wait_ack(void);                                         /* tx.c */
u32 itx_wait_cts_b(void);                                       /* tx.c */
void keep_alive_arm_slot(u32 a);                                /* cmd.c */
void l1_enter_fixed_sched(u32 a);                               /* l1.c */
u32 l1_fixed_sched_ap_ev4_state2(u32 a);                        /* tail.c */
u32 l1_fixed_sched_ap_ev4_state4(u32 a);                        /* tail.c */
void l1_fixed_sched_ap_sm(u32 a);                               /* tail.c */
void l1_fixed_sched_event_entry(void);                          /* l1.c */
void l1_fixed_sched_sta_sm(u32 a);                              /* tail.c */
void l1_on_event4(void);                                        /* l1.c */
u32 l1_rx_then_check_bf_abort(void);                            /* l1.c */
void l1_snapshot_bi_counter(void);                              /* l1.c */
void l1_task_check_pending(void);                               /* l1.c */
void l1_task_dispatch(u32 a, u32 b);                            /* l1.c */
void l1_task_entry(u32 mode);                                   /* l1.c */
void l1_task_entry_uc(void);                                    /* l1.c */
void l1_task_kick_and_dispatch_uc(void);                        /* l1.c */
void l1_task_main_step(void);                                   /* l1.c */
void l1_task_mask_halt_req_and_defer(void);                     /* l1.c */
void l1_task_mask_wake_req_and_defer(void);                     /* l1.c */
void l1_task_phase_of(struct bi_ctx_s *c);                      /* l1.c */
void l1_task_report_link_lost(void);                            /* l1.c */
void l1_task_reset_units(void);                                 /* l1.c */
u32 l1_task_rx_flow_thunk(void);                                /* l1.c */
u32 l1_task_rx_flow_thunk_b(void);                              /* l1.c */
void l1_task_select_by_mode(void);                              /* l1.c */
void l1_task_step_fixed_sched(void);                            /* l1.c */
void l2_handle_watchdog(void);                                  /* tail.c */
void l2_task_entry(u32 a);                                      /* l1.c */
void l2_task_kick_mac_events(void);                             /* l1.c */
void l2_task_report_error_bits(void);                           /* l1.c */
void list_push_locked(struct uc_ring *r, u32 entry);            /* tail.c */
u32 mac_arm_events_0xc00(void);                                 /* mac.c */
u32 mac_build_qset_mask(const struct lmac_mac_regs *a);         /* mac.c */
void mac_cfg_set_gp20_default_15748(void);                      /* mac.c */
void mac_clk_div165(u32 a, u32 out);                            /* mac.c */
void mac_cmd_0f_step(struct pm_ctx_s *p);                       /* mac.c */
void mac_cmd_29000001(void);                                    /* mac.c */
void mac_cmd_56_57(void);                                       /* mac.c */
void mac_core_write_3d_0200(void);                              /* mac.c */
void mac_core_write_3e_then_3d_0007(void);                      /* mac.c */
void mac_ddc_mask_all_on(void);                                 /* mac.c */
void mac_ddc_mask_bit3(void);                                   /* boot.c */
void mac_evt_enable_bit_sync(u32 a);                            /* mac.c */
void mac_evt_enable_bit_sync_b(u32 a);                          /* mac.c */
void mac_evt_select_timer_group(u32 a);                         /* stubs.c */
void mac_fill_mode_nibbles(u32 mode);                           /* mac.c */
u16 mac_get_beacon_interval_tu_uc(void);                        /* mac.c */
void mac_ifs_restore_sifs(void);                                /* mac.c */
void mac_load_tx_key(const u32 *key);                           /* mac.c */
void mac_mem_addr_of_slot(u32 a, u32 b, u32 c);                 /* tail.c */
void mac_mode_enter_idle_seq(u32 a);                            /* mac.c */
void mac_mode_kick(struct sls_peer_rec *a);                     /* bf.c */
void mac_mode_program_c(struct sls_peer_rec *a);                /* tail.c */
void mac_mode_send_direct_frame(u32 a);                         /* mac.c */
void mac_mode_switch_after_ppdu(u32 a);                         /* mac.c */
void mac_mode_switch_core_and_rf(u32 a);                        /* mac.c */
void mac_mode_switch_sequence(u32 a);                           /* tail.c */
void mac_prepare_txrx_window(struct tx_ctx_s *a, u32 b);        /* tail.c */
void mac_prog_cmd02_body(void);                                 /* tail.c */
void mac_program_13ab6680(void);                                /* boot.c */
void mac_program_13ab6680_b(void);                              /* mac.c */
void mac_program_4f_52(u32 a, u32 b);                           /* mac.c */
void mac_program_886e0c_20b(u32 a);                             /* tail.c */
u32 mac_program_deadline_slack(u32 a, u32 b, u32 c);            /* mac.c */
void mac_program_qset_slots(void);                              /* mac.c */
void mac_program_rx_window(u32 a, u32 b, u32 c);                /* tail.c */
void mac_program_tx_beacon(void);                               /* mac.c */
void mac_program_tx_common(void);                               /* mac.c */
void mac_program_tx_result_ctx_uc(u32 a, u32 b, u32 c);         /* tx.c */
void mac_program_tx_with_qid(u32 qid);                          /* mac.c */
void mac_program_tx_with_rate(u32 rate);                        /* mac.c */
void mac_publish_masks(void);                                   /* bf.c */
void mac_q_tx_ppdu(struct tx_ctx_s *a, u32 b);                  /* tail.c */
void mac_q_tx_ppdu_3009(struct tx_ctx_s *a);                    /* tail.c */
void mac_q_tx_ppdu_cmd08(u32 a, u32 b);                         /* tail.c */
void mac_qset_reset_masks(void);                                /* mac.c */
void mac_read_bi_start_tsf64_uc(u32 a, u32 *out, u32 wait);     /* mac.c */
u32 mac_read_time_88c120(void);                                 /* mac.c */
void mac_read_tsf64_uc(u32 *out);                               /* mac.c */
u32 mac_read_usec_to_tbtt_uc(u32 a);                            /* mac.c */
u32 mac_replicate_bit_mask(const struct lmac_mac_regs *a);      /* mac.c */
void mac_rf_switch_cmd1f(u32 a);                                /* cmd.c */
void mac_rx_off_seq(void);                                      /* mac.c */
void mac_select_all_sectors_and_wait(void);                     /* mac.c */
void mac_select_rf_module_cmd31(u32 a, u32 b);                  /* mac.c */
void mac_set_880afc_bits(u32 a);                                /* mac.c */
void mac_set_880bf0_mode(u32 mode);                             /* mac.c */
void mac_set_chain_mask_924f00(void);                           /* mac.c */
void mac_set_chain_modes(u32 a);                                /* mac.c */
void mac_set_cid_mcs_uc(u32 a, u32 b);                          /* mac.c */
void mac_set_mode_0000(void);                                   /* mac.c */
u32 mac_set_mode_a000(u32 a);                                   /* mac.c */
void mac_set_rf_chain_state(u32 a, u32 b);                      /* mac.c */
void mac_set_rf_chain_state_with_sta_sector(void);              /* mac.c */
void mac_set_sector_arg_and_select_all(u32 a);                  /* mac.c */
void mac_set_slot_mask_924000(void);                            /* mac.c */
void mac_set_slot_timing_886f60(void);                          /* mac.c */
void mac_wait_event_r42_or_r40(u32 a, u32 b);                   /* mac.c */
u32 macq_desc_read_uc(u32 addr, u32 unused);                    /* txss.c */
void macq_desc_write_uc(u32 addr, u32 value);                   /* txss.c */
void macq_flush_queue(u32 a, u32 b, u32 c);                     /* l1.c */
void macq_hw_clear_2d8(u32 q);                                  /* mac.c */
void macq_hw_commit_rptr(u32 q);                                /* mac.c */
void macq_hw_disable_queue(u32 q);                              /* mac.c */
u32 macq_hw_read_rptr(u32 q);                                   /* mac.c */
u32 macq_hw_read_state0(u32 q);                                 /* mac.c */
u32 macq_hw_read_state1(u32 q);                                 /* mac.c */
u32 macq_hw_read_wptr(u32 q);                                   /* mac.c */
void macq_hw_set_ctrl_bit(u32 q);                               /* mac.c */
void macq_hw_sync_dma_wptr(u32 a, u32 q, u32 dma);              /* mac.c */
u32 macq_hw_trigger_read_state(u32 q);                          /* mac.c */
u32 macq_is_idle(u32 a);                                        /* l1.c */
void macq_kick_queue_tx(u32 q, u32 b, u32 c);                   /* misc.c */
u32 macq_probe_empty(u32 q);                                    /* mac.c */
u32 macq_read_hw_queue_word(u32 q);                             /* mac.c */
void mailbox_debug_dump_uc(struct uc_ring *r);                  /* stubs.c */
u32 mailbox_free_space(struct uc_ring *r);                      /* stubs.c */
void mask_bit_from_index_plus8(u32 a, u32 b);                   /* l1.c */
void *memcpy_uc(void *dst, const void *src, u32 len);          /* mem.c */
void *memset(void *d, int c, unsigned int n);                  /* uutil.c */
void *memset0_words_uc(void *dst, u32 len);                    /* mem.c */
void *memset_uc(void *dst, u8 v, u32 n);                       /* mem.c */
void mtp_get_tx_permission(struct tx_ctx_s *a, u32 b);          /* tail.c */
u8 mtp_queue_byte_by_index(u32 idx);                            /* rate_search.c */
u32 mtp_queue_release_mgmt(struct tx_ctx_s *a, u32 b, u32 c, u32 d); /* tail.c */
void mtp_service_dispatch(u32 a, u32 b, u32 c, u32 d);          /* tail.c */
u32 nav_read_hw_duration_flag(u32 *out);                        /* txss.c */
u32 notify_aoa(u32 a);                                          /* tail.c */
void notify_aoa_build(u32 arg0, u32 arg1, u32 arg2);            /* tail.c */
void obj_vt801adc_ctor(struct sm_obj *a);                       /* util.c */
u32 peer_lookup_if_fixed_sched(u32 a0);                         /* txss.c */
u32 peer_lookup_or_ff(struct fsched_peer_ctx *p, u32 qid);      /* txss.c */
void peer_masks_apply_op(struct pm_ctx_s *p, u32 op, u32 val);  /* misc.c */
void peer_masks_or_into_8571c4(u32 a);                          /* misc.c */
void peer_masks_or_sta_bit_into_8571c4(u32 a);                  /* bf.c */
void peer_masks_update_sta_bit(struct fsched_peer_ctx *p, u32 sta, u32 set); /* misc.c */
void peer_slots_scan_by_masks(u32 a);                           /* misc.c */
void phy_params_snapshot(u32 a, u32 b);                         /* tail.c */
u32 phy_read_signal_gain_adc_db(void);                          /* phy.c */
u32 phy_read_signal_gain_adc_db_sfd_locked(void);               /* phy.c */
void phy_rx_set_ina_det_mode_uc(u32 a);                         /* phy.c */
void phy_set_88306c_field(u32 v);                               /* phy.c */
u32 phy_signal_gain_adc_in_range(void);                         /* phy.c */
void phy_stats_accumulate_to_shared(struct rx_meas_ctx *m, u32 b); /* tail.c */
void phy_stats_clear_counters_88395c(void);                     /* phy.c */
void phy_stats_clear_counters_883960(void);                     /* phy.c */
void pm_event_mask_restore(void);                               /* tail.c */
void pm_event_mask_save_all_on(void);                           /* tail.c */
void pm_wake_sequence(void);                                    /* bi.c */
void pmc_stop_recording(void);                                  /* tail.c */
u32 popcount8(u32 a);                                           /* util.c */
u32 power_manager_scale_counters_ms(void);                      /* power.c */
void power_manager_tick_if_elapsed(void);                       /* power.c */
u32 power_mngr_stats_calc_delta(u32 a);                         /* power.c */
void power_mngr_stats_mark_base(u32 a);                         /* power.c */
void ppdu_unpack_desc_word(u32 a, u32 *o0, u32 *o1, u32 *o2, u32 *o3, u32 *o4, u32 *o5); /* phy.c */
void qh_build_descriptor(u32 a, u32 b, struct qh_desc3_win *d); /* txss.c */
u32 qh_build_descriptor_b(u32 a);                               /* txss.c */
void qh_pack_descriptor(u32 dst, u32 a, u32 count, u32 c, u32 flag, u32 loopcnt, u32 copycnt); /* txss.c */
void qh_read_desc_window(u32 dst, u32 a1, u32 a2, u32 a3, u32 count); /* txss.c */
void qh_reset_desc_window(void);                                /* txss.c */
void qh_wait_desc_window_ready(void);                           /* txss.c */
void qh_write_by_flags(u32 a, u32 b, u32 c, u32 d);             /* txss.c */
void qh_write_desc_window(u32 data, u32 a1, u32 a2, u32 a3, u32 a4, u32 a5, u32 a6, u32 count); /* txss.c */
void qh_write_while_dma_open_check(u32 a);                      /* tail.c */
u32 qset1_mask_any_pending_uc(u32 a);                           /* tail.c */
u32 queue_sel_get_qset4(u32 a);                                 /* tail.c */
void rate_search_apply_mcs(u32 a, u32 b);                       /* rate_search.c */
void rate_search_commit_mcs(struct tx_ctx_s *a);                /* tail.c */
u8 rate_search_current_mcs(u32 a);                              /* rate_search.c */
u8 rate_search_current_mcs_b(u32 a);                            /* rate_search.c */
u32 rate_search_pick_tx_params(struct tx_ctx_s *a, u32 b);      /* tail.c */
u32 rate_search_reset_stats(struct tx_ctx_s *a, u32 b);         /* tail.c */
u32 rf_compute_tx_rx_sets(void);                                /* txss.c */
void rf_gain_adjust_cb(u32 a, u32 b);                           /* cmd.c */
void rf_power_seq_and_save(u32 a);                              /* txss.c */
void rf_select_sector_cmd41(u32 a, u32 b);                      /* txss.c */
void rf_set_normal_mode(u32 a);                                 /* txss.c */
void rf_set_txrx_sets_save(u32 a, u32 b, u32 *o0, u32 *o1);     /* txss.c */
void rf_store_last_module_index(void);                          /* txss.c */
void rf_update_active_antenna(u32 a, u32 b);                    /* txss.c */
u32 rf_utils_auto_fill_uc(const struct rf_fill_info *f, u32 b); /* tail.c */
void rf_utils_auto_fill_with_byte(u32 a, u32 b);                /* brp.c */
void rf_utils_fill_step(u32 a0, u32 a1, u32 a2, u32 a3);        /* tail.c */
void rf_write_sector_awv(u32 a, u32 b);                         /* txss.c */
void rfc_clear_core_reg1(u32 a);                                /* txss.c */
void rfc_issue_cmd_10(u32 a);                                   /* txss.c */
u32 rfc_issue_cmd_20_uc(u32 a, u32 b);                          /* txss.c */
u32 rfc_read_core_result(u32 a0, u32 a1, u32 a2);               /* txss.c */
void rfc_restore_txrx_sets(void);                               /* txss.c */
void rfc_write_core_checked(u32 a, u32 b, u32 c);               /* txss.c */
void rfca_access_sector_other_rf(u32 a);                        /* tail.c */
u8 rfca_get_rf_mask_uc(void);                                   /* brp.c */
void rfca_select_rf_uc(u32 a, u32 b);                           /* tail.c */
u32 rng_rand_below(u32 a);                                      /* util.c */
void rs_abort(u32 a);                                           /* bf.c */
void rs_end(void);                                              /* tail.c */
u32 rs_is_sta_enabled(u32 a);                                   /* rate_search.c */
u32 rs_start(u32 a, u32 b);                                     /* cmd.c */
u32 rss_wait_get(u32 a);                                        /* util.c */
void rx_arm_window(void);                                       /* rx.c */
void rx_arm_window_b(void);                                     /* rx.c */
u32 rx_arm_window_c(void);                                      /* rx.c */
u32 rx_capture_match_filter(struct rx_meas_ctx *m);             /* rx.c */
void rx_cfg_select_sta(u32 a);                                  /* rx.c */
u32 rx_check_g8005f8_bit24(void);                               /* rx.c */
void rx_check_mode_2(struct rx_meas_ctx *m, u32 b);             /* rx.c */
u32 rx_dispatch_by_g_8005f8(void);                              /* rx.c */
void rx_enter_listen_mode(void);                                /* rx.c */
void rx_flow_accumulate_busy_time(u32 a);                       /* rx.c */
u32 rx_flow_handle_frame(struct tx_ctx_s *a);                   /* rx.c */
void rx_flow_latch_phy_8014e8(u32 a);                           /* tail.c */
void rx_flow_latch_phy_8014e8_930da4(void);                     /* util.c */
void rx_flow_latch_phy_8014e8__930da4(void);                    /* rx.c */
void rx_flow_measure_snr_select_best(void);                     /* rx.c */
u32 rx_flow_run(void);                                          /* rx.c */
u32 rx_flow_run_and_check_bf_abort(u32 a);                      /* rx.c */
void rx_flow_send_imm_response(void);                           /* rx.c */
void rx_flow_step(struct tx_ctx_s *a, u32 b);                   /* rx.c */
u32 rx_flow_substep_uc(struct tx_ctx_s *a);                     /* rx.c */
void rx_funcs_handle_ppdu_report(void);                         /* rx.c */
s32 rx_funcs_record_level_8020f8_8020fc(u32 a);                 /* util.c */
u32 rx_funcs_rx_flow(void);                                     /* rx.c */
void rx_funcs_send_direct_frame(u32 a);                         /* tail.c */
u32 rx_get_required_response(struct tx_ctx_s *frame, u32 *out); /* rx.c */
void rx_handle_brp_frame(void);                                 /* rx.c */
void rx_handle_status_flags(struct tx_ctx_s *a);                /* rx.c */
u32 rx_is_brp_frame(void);                                      /* rx.c */
void rx_listen_set_flag_and_stamp_tsf(void);                    /* rx.c */
void rx_mac_prepare(void);                                      /* rx.c */
void rx_meas_append_sample(struct rx_meas_ctx *m, u32 mp);      /* rx.c */
void rx_meas_capture_frame(struct rx_meas_ctx *m, u32 mp);      /* rx.c */
void rx_meas_finish_with_8830ec(struct rx_meas_ctx *m);         /* rx.c */
void rx_mode_configure(u32 a, u32 b);                           /* bf.c */
void rx_nav_arm_flag_if_enabled(void);                          /* rx.c */
void rx_nav_clear_flags(void);                                  /* rx.c */
void rx_nav_set_flag_b1_if_enabled(u32 a);                      /* rx.c */
void rx_nav_set_from_duration(u32 a, u32 b, u32 c, u32 d);      /* rx.c */
void rx_nav_update(u32 a, u32 b, u32 c, u32 d);                 /* rx.c */
void rx_parse_ssw_field(u32 dst0, u32 dst1, u32 dst2);          /* rx.c */
u32 rx_ppdu_is_ack(void);                                       /* rx.c */
u32 rx_ppdu_is_cts_b(void);                                     /* rx.c */
u32 rx_program_mac_and_wait(struct tx_ctx_s *a);                /* rx.c */
void rx_resp_finish_restore_rx(u32 a, u32 b, u32 c);            /* rx.c */
void rx_send_dmg_cts(void);                                     /* rx.c */
void rx_send_response_frame(void);                              /* rx.c */
void rx_switch_to_rx_mode(void);                                /* rx.c */
void rx_update_nav_from_frame(u32 a);                           /* rx.c */
u32 sched_bitmap_next_set_bit(u32 a, u32 b);                    /* rate_search.c */
u32 sched_bitmap_prev_set_bit(u32 a, u32 b);                    /* rate_search.c */
void sched_cfg_merge_update(const struct lmac_cmd_write_qh *sr); /* tail.c */
u32 sector_mem_addr_of(u32 a);                                  /* txss.c */
void sends_pmc_mark_aaab02(struct fsched_peer_ctx *p, u32 b);   /* tail.c */
void sends_pmc_mark_aaab20(u32 a);                              /* tail.c */
void set_selected_rf_sector_index_cmd_handler(const struct lmac_cmd_rf_sector_sel *c); /* cmd.c */
void set_tsf_event(u32 a);                                      /* tail.c */
void sls_build_ssw_ack(struct ssw_ack_frame *f, u32 idx, u32 flag); /* txss.c */
void sls_clear_rx_state(void);                                  /* txss.c */
u32 sls_rx_ssw_frame(void);                                     /* txss.c */
void sls_send_ssw_ack(u32 a, u32 b);                            /* txss.c */
void ss_copy_cfg_from_cmd(const struct lmac_cmd_ss_order *c);   /* cmd.c */
u32 ss_plan_next_sector(u32 a, u32 b);                          /* tail.c */
void ss_update_frames_number(u32 a);                            /* cmd.c */
void sta_apply_bf_result(u32 a, u32 b);                         /* txss.c */
void sta_apply_rx_sector_and_mcs(u32 a);                        /* txss.c */
void sta_ctx_reset_counters(struct pm_ctx_s *p, u32 a1);        /* tail.c */
u32 sta_find_by_byte(struct fsched_peer_ctx *p, u32 qid);       /* txss.c */
u32 sta_get_sweep_byte(u32 a, u32 out);                         /* txss.c */
u8 sta_link_byte_by_index(u32 idx);                             /* rate_search.c */
u32 sta_queue_class(u32 a, u32 b);                              /* txss.c */
void sta_reset_link_state(u32 a, u32 b, u32 c);                 /* txss.c */
void sta_set_rx_sector(u32 a, u32 b);                           /* txss.c */
void sta_set_tx_sector(u32 a, u32 b, u32 c, u32 d);             /* txss.c */
u32 sta_tbl_find_by_mac(u32 a);                                 /* tail.c */
u32 sxd_hal_wait_slot2_busy(u32 n);                             /* sxd.c */
u32 sxd_hal_wait_slot2_busy2(u32 n);                            /* sxd.c */
void sxd_hal_write_qset_field(u32 a, u32 b);                    /* sxd.c */
void timer_list_init(void);                                     /* util.c */
void timer_list_insert_sorted(u32 obj, u32 prio, u32 order);    /* stubs.c */
u32 tx_await_rx_or_timeout(void);                               /* tx.c */
void tx_bcast_flow(u32 a);                                      /* tail.c */
void tx_cca_check_and_send(struct tx_ctx_s *a, u32 b, u32 c, u32 d); /* tx.c */
struct tx_ctx_s *tx_ctx_alloc_next(u32 a);                     /* stubs.c */
void tx_ctx_post_status(struct pm_ctx_s *p, u32 arg, u32 type); /* tx.c */
void tx_fifo_write_bytes(u32 src, u32 len);                     /* mem.c */
void tx_flow_arm_88606c_0x102(void);                            /* tx.c */
u32 tx_flow_substep(struct tx_ctx_s *a);                        /* tail.c */
void tx_initiator_flow_fixed_scheduling(u32 a);                 /* tail.c */
void tx_initiator_reset_slot_counters(u32 a);                   /* tx.c */
void tx_mtp_queue_gate(u32 a);                                  /* tail.c */
void tx_non_data_flow_fixed_scheduling(u32 a);                  /* tail.c */
void tx_pick_slot_for_peer(u32 a, u32 b, u32 c);                /* tx.c */
void tx_program_vector_rf(u32 a, u32 b);                        /* tx.c */
u32 tx_send_and_await_rx_frame(struct tx_ctx_s *a, u32 b, u32 c, u32 d); /* tx.c */
void tx_send_imm_response(u32 a, u32 b, u32 c);                 /* tx.c */
void tx_slot_dispatch(u32 a);                                   /* tx.c */
u32 tx_slot_pick_queue(u32 a, u32 b);                           /* tx.c */
void tx_sta_flow_loop(struct tx_ctx_s *a);                      /* tx.c */
void tx_sta_run_txop(struct tx_ctx_s *ctx);                     /* tx.c */
u32 tx_sta_wait_slot_and_tx(struct tx_ctx_s *a, u32 b);         /* tx.c */
u32 tx_submit_frame(struct tx_ctx_s *a, u32 b, u32 c, u32 d);   /* tx.c */
void txop_apply_limits_regs(u32 a0);                            /* txss.c */
u32 txop_await_cts_ppdu(struct tx_ctx_s *a, u32 b);             /* txss.c */
void txop_clear_dma_ctl_bit1(void);                             /* txss.c */
u32 txop_initiator_open_txop_flow(struct tx_ctx_s *a);          /* tail.c */
u32 txop_pick_ctrl_code_by_peer(struct tx_ctx_s *a);            /* txss.c */
u8 txq_fifo_ptp_idle_snapshot(void);                            /* txss.c */
void txrx_api_cmd_step(const struct lmac_cmd_rx_on *a);         /* cmd.c */
void txrx_api_step_b_uc(u32 a);                                 /* cmd.c */
void txrx_api_step_c(u32 a, u32 b);                             /* cmd.c */
void txrx_umac_if_config_pmc_triggers_handler(u32 a);           /* cmd.c */
void txss_init_flow(u32 a);                                     /* bf.c */
void txss_init_send_fdbk_wait_ack(u32 a);                       /* tail.c */
void txss_init_send_ssw_fdbk(u32 a, u32 b, u32 c);              /* tail.c */
u32 txss_init_wait_rss(u32 a, u32 b);                           /* tail.c */
void txss_order_known_sectors_first(u32 dst, u32 src);          /* txss.c */
u32 txss_program_tx_frame(u32 a, u32 b, u32 c, u32 d, u32 e);   /* txss.c */
void txss_rank_best_sector(void);                               /* txss.c */
void txss_resp_flow(u32 a);                                     /* bf.c */
u32 txss_resp_wait_fdbk(u32 a);                                 /* tail.c */
u32 txss_resp_wait_iss_end(u32 a, u32 rss);                     /* tail.c */
void txss_set_sweep_param(u32 s, const struct ss_cfg_s *p, u32 a2, u32 a3, u32 a4, u32 a5); /* txss.c */
void txss_store_sector_ranking(u32 a, u32 b);                   /* txss.c */
u32 txss_sweep_duration_for_sta(u32 a);                         /* txss.c */
void txss_sweep_timing(u32 out, u32 byte1, u32 byte2);          /* txss.c */
u32 uc_ap_read_match_value(u32 a);                              /* uutil.c */
u8 uc_ap_read_triggered_mask(void);                             /* uutil.c */
void uc_assert(u32 caller, u32 code);                           /* misc.c */
u32 uc_bi_counter_in_window(u32 a);                             /* uutil.c */
void uc_check_g8004f4_0_1_2(void);                              /* uutil.c */
u32 uc_clk_now(void);                                           /* util.c */
u32 uc_clk_since(u32 *last);                                    /* util.c */
void uc_delay_clk(u32 clk);                                     /* util.c */
u64 uc_divmod_signed_qr(s32 a, s32 b);                          /* mem.c */
u32 uc_divmod_unsigned(u32 n, u32 d);                           /* mem.c */
u64 uc_divmod_unsigned_qr(u32 n, u32 d);                        /* mem.c */
void uc_evt_build_and_post_report(const struct sls_peer_rec *p, u32 flag); /* misc.c */
void uc_evt_enqueue(u32 evt, u32 type, u32 size, u32 a);        /* evt.c */
u32 uc_evt_queue_peek_field04(void);                            /* evt.c */
void uc_evt_queue_put(struct uc_mbox_ctx *m, u32 evt, u32 type, u32 cmd_id, u32 len, u32 mid, u32 c, u32 d, u32 e); /* evt.c */
void uc_evt_send_20(u32 a);                                     /* evt.c */
void uc_evt_send_21(u8 a0, const void *a1);                     /* evt.c */
void uc_evt_send_23(u32 src);                                   /* evt.c */
void uc_evt_send_26(u32 a);                                     /* evt.c */
void uc_evt_send_29_sync(u32 a);                                /* evt.c */
void uc_evt_send_2b(u8 a);                                      /* evt.c */
void uc_evt_send_2c_tsf(u32 a, u32 b, u32 c);                   /* evt.c */
void uc_evt_send_2e(u32 a, u32 b, u32 c);                       /* evt.c */
void uc_evt_send_30(const u32 *a);                              /* evt.c */
u32 uc_field_0x24_is_zero(struct uc_mbox_ctx *m);               /* uutil.c */
u32 uc_indirect_is_zero(struct uc_ring *r);                     /* uutil.c */
void uc_init(void);                                             /* boot.c */
void uc_init_cb_801aec(void);                                   /* boot.c */
void uc_init_cb_cmdq(void);                                     /* boot.c */
void uc_init_cb_copy_8006b7(void);                              /* boot.c */
void uc_init_cb_globals(void);                                  /* boot.c */
void uc_init_cb_more(void);                                     /* boot.c */
void uc_init_globals(struct fsched_peer_ctx *p);                /* uutil.c */
void uc_irq_set_level(u32 a, u32 b);                            /* uutil.c */
u32 uc_list_head_field4(struct uc_ring *r);                     /* uutil.c */
void uc_list_insert_by_prio(u32 obj);                           /* util.c */
void uc_log_emit1(u32 lvl, u32 token, u32 a0);                  /* bf.c */
void uc_log_emit2(u32 lvl, u32 token, u32 a0, u32 a1);          /* bf.c */
void uc_log_emit3(u32 lvl, u32 token, u32 a0, u32 a1, u32 a2);  /* stubs.c */
void uc_log_emit_snapshot(u32 a, u32 b);                        /* stubs.c */
void uc_log_init_ring(void);                                    /* stubs.c */
void uc_mailbox_init_rings(struct uc_mbox_ctx *m);              /* stubs.c */
u32 uc_mailbox_ring_reg_addr(void);                             /* uutil.c */
void uc_main(void);                                             /* boot.c */
void uc_pm_enter_idle(u32 a);                                   /* uutil.c */
void uc_queue_dispatch_and_commit(struct uc_mbox_ctx *m);       /* misc.c */
u32 uc_queue_peek_head_word1(struct uc_ring *r);                /* uutil.c */
u32 uc_read_bi_sync(void);                                      /* uutil.c */
u32 uc_read_tsf_lo(void);                                       /* stubs.c */
void uc_res_vote_acquire(u32 a);                                /* uutil.c */
void uc_res_vote_release(u32 a);                                /* uutil.c */
void uc_ring_init_desc(struct uc_ring *r, u32 base, u32 size, struct mbox_ring_ctl *ctl, u32 e, u32 f, u32 g); /* uutil.c */
void uc_send_evt_get_rf_sector_done(u32 a);                     /* evt.c */
void uc_send_evt_link_lost(const void *a);                      /* evt.c */
void uc_send_evt_mac_monitor(u32 a);                            /* evt.c */
void uc_send_evt_ps_awake_peer(u32 a);                          /* evt.c */
void uc_send_evt_rs_done(const void *a);                        /* evt.c */
void uc_send_evt_rs_started(u32 a);                             /* evt.c */
void uc_send_evt_set_rf_sector_done(u32 a);                     /* evt.c */
void uc_send_evt_sta_update_field_rsp(u32 a, u32 b);            /* evt.c */
void uc_send_evt_typed(u32 a, u32 b);                           /* evt.c */
void uc_send_evt_ucode_ready(void);                             /* boot.c */
void uc_set_evt_id_5c(u32 a);                                   /* uutil.c */
u64 uc_shl64(u32 lo, u32 hi, u32 shift);                        /* mem.c */
void uc_sleep_until_event(u32 a, u32 b);                        /* uutil.c */
u32 uc_sm_handle_event(struct sm_obj *obj, u32 ev, u32 a2);     /* uutil.c */
u32 uc_spin_until_event(u32 mask);                              /* mac.c */
void uc_spin_until_event4(u32 a);                               /* uutil.c */
void uc_spin_until_event4_r0_100(void);                         /* bf.c */
void uc_sysassert_emit_mac_trace(u32 a);                        /* misc.c */
void uc_sysassert_idle_hist(void);                              /* misc.c */
u32 uc_sysassert_read_hw_state3(void);                          /* phy.c */
void uc_sysassert_scan_stack(u32 a);                            /* misc.c */
void uc_sysassert_snapshot_mac(u32 a, u32 b, u32 wait);         /* misc.c */
void uc_sysassert_write_code(u32 a);                            /* uutil.c */
void uc_timer_start(u32 a, u32 b, u32 c, u32 d);                /* boot.c */
u32 uc_tsf_elapsed(u32 a);                                      /* uutil.c */
u32 uc_tx_is_idle(void);                                        /* uutil.c */
void uc_wait_direct_tx_ready(void);                             /* uutil.c */
u32 uc_wait_event1_or_event4(u32 a, u32 b, u32 c);              /* bti.c */
u32 uc_wait_event_busy(u32 a, u32 b);                           /* stubs.c */
void uc_wait_one_event(u32 a);                                  /* uutil.c */
void uc_wait_two_events(u32 a, u32 b, u32 c);                   /* uutil.c */
void ucode_cmd08_noop_hook(void);                               /* cmd.c */
void ucode_cmd_0b_apply(struct ss_cfg_s *d, const struct ss_cfg_s *s); /* cmd.c */
void ucode_cmd_0x00_handler(const struct lmac_cmd_mac_cfg *c);  /* cmd.c */
void ucode_cmd_0x01_handler(const struct lmac_cmd_rx_on *c);    /* cmd.c */
void ucode_cmd_0x03_handler(u32 a);                             /* cmd.c */
void ucode_cmd_0x04_handler_uc(u32 a);                          /* cmd.c */
void ucode_cmd_0x05_handler(const struct lmac_cmd_sta_cfg *c);  /* cmd.c */
void ucode_cmd_0x07_handler(const struct lmac_cmd_qset_ranges *c); /* cmd.c */
void ucode_cmd_0x08_handler(const struct lmac_cmd_vring_cfg *c); /* cmd.c */
void ucode_cmd_0x0b_handler(u32 a);                             /* cmd.c */
void ucode_cmd_0x0c_handler(u32 a);                             /* cmd.c */
void ucode_cmd_0x0f_handler(const struct lmac_cmd_maint_sta *c); /* cmd.c */
void ucode_cmd_0x10_handler(const struct lmac_cmd_bf_ctrl *c);  /* cmd.c */
void ucode_cmd_0x11_handler(u32 a);                             /* cmd.c */
void ucode_cmd_0x12_handler_uc(u32 a);                          /* cmd.c */
void ucode_cmd_0x13_handler(const struct lmac_cmd_rs_cfg *c);   /* cmd.c */
void ucode_cmd_0x16_handler(u32 a);                             /* cmd.c */
void ucode_cmd_0x18_handler(const struct lmac_cmd_sta_field *c); /* cmd.c */
void ucode_cmd_0x19_handler(const struct lmac_cmd_rf_chain *c); /* cmd.c */
void ucode_cmd_0x1b_handler(const struct lmac_cmd_role *c);     /* power.c */
void ucode_cmd_0x20_handler(u32 a);                             /* cmd.c */
void ucode_cmd_0x21_set_txop_limits(u32 a);                     /* cmd.c */
void ucode_cmd_0x23_handler(u32 a);                             /* cmd.c */
void ucode_cmd_0x24_handler(const struct lmac_cmd_discovery *c); /* cmd.c */
void ucode_cmd_0x26_handler(u32 a);                             /* cmd.c */
u32 ucode_cmd_0x28_handler(struct rx_meas_ctx *m, u32 b, u32 c); /* cmd.c */
void ucode_cmd_0x29_handler(struct rx_meas_ctx *m, u32 b);      /* cmd.c */
void ucode_cmd_0x2a_handler(struct rx_meas_ctx *m, u32 b);      /* cmd.c */
void ucode_cmd_0x2b_handler(struct rx_meas_ctx *m, u32 b);      /* cmd.c */
void ucode_cmd_0x2e_handler(struct rx_meas_ctx *m, u32 b);      /* cmd.c */
void ucode_cmd_0x2f_handler(struct rx_meas_ctx *m, u32 b);      /* cmd.c */
void ucode_cmd_0x30_handler_uc(const struct lmac_cmd_sta_byte2 *c); /* cmd.c */
void ucode_cmd_0x32_handler(const struct lmac_cmd_sta_byte2 *c); /* cmd.c */
void ucode_cmd_0x37_handler(struct rx_meas_ctx *m, u32 b);      /* cmd.c */
void ucode_cmd_0x38_handler(struct rx_meas_ctx *m, u32 b);      /* cmd.c */
void ucode_cmd_0x3b_handler(u32 a);                             /* cmd.c */
void ucode_cmd_0x3c_handler(struct rx_meas_ctx *m, u32 b);      /* cmd.c */
void ucode_cmd_0x3d_handler(struct rx_meas_ctx *m, u32 b);      /* cmd.c */
void ucode_cmd_0x41_handler(u32 a);                             /* cmd.c */
void ucode_cmd_0x47_handler(const struct lmac_cmd_fsched_peer *c); /* cmd.c */
void ucode_cmd_0x48_handler(u32 a);                             /* cmd.c */
void ucode_cmd_0x49_handler(u32 a);                             /* cmd.c */
void ucode_cmd_0x4a_handler(u32 a);                             /* cmd.c */
u32 ucode_cmd_28_apply(struct rx_meas_ctx *m, u32 b);           /* cmd.c */
void ucode_cmd_apply_mac_cfg(u32 a);                            /* cmd.c */
void ucode_cmd_dispatch(u32 a, u32 b);                          /* cmd.c */
void ucode_cmd_echo(u32 a);                                     /* cmd.c */
void ucode_cmd_load_table_803124_803128(u32 a, u32 b);          /* misc.c */
void ucode_cmd_load_table_803124_803128_920b1c(u32 a, u32 b);   /* util.c */
void ucode_cmd_selective_neighbor_cfg(const struct lmac_cmd_sel_nbr *c); /* cmd.c */
void ucode_cmd_trigger_bf(u32 a);                               /* cmd.c */
void ucode_cmdq_handler(struct uc_mbox_ctx *m, u32 item);       /* misc.c */
void ucode_pm_set_busy_flag(u32 a);                             /* uutil.c */
void ucode_pm_stamp_tsf_slots(void);                            /* uutil.c */
void update_sector_sweep_frames_number(u32 a, u32 b);           /* tail.c */
void vring_disconnect_flush(u32 a, u32 b, u32 c, u32 d);        /* tail.c */
void vring_is_empty_uc(u32 v);                                  /* boot.c */
u32 vring_is_empty_uc_quiet(u32 a);                             /* util.c */
void wmi_cmd_txss_set_sectors_number(u32 a);                    /* cmd.c */
void wmi_cmd_txss_set_sectors_order(const struct lmac_cmd_ss_order *c); /* cmd.c */

#endif
