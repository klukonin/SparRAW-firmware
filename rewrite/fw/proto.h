/* Сгенерировано tools/gen_fw_proto.py — не редактировать. */
#ifndef FW_PROTO_H
#define FW_PROTO_H
#include "types.h"
#include "calib.h"
#include "calib_engine.h"
#include "fwq_tx.h"
#include "mbox.h"
#include "radio_mgr.h"
#include "sched.h"
#include "temp_sense.h"
#include "vring_schd.h"

struct app_ies;
struct arc_ap_cfg;
struct ba_setup_sm;
struct ba_wait_sm;
struct basic_sm;
struct bcon_post_info;
struct brd_block_info;
struct brd_bounds;
struct brd_if;
struct brd_section_info;
struct brd_win;
struct calib_engine;
struct calib_est;
struct calib_obj;
struct calib_scheme;
struct calib_silent_rssi;
struct channels_switch_sm;
struct conn;
struct conn_disc_sm;
struct conn_msm;
struct dashboard;
struct dband_info;
struct ese_alloc;
struct ese_sched;
struct ese_slot;
struct find_mngr;
struct find_sm;
struct fw_mailbox;
struct fw_sysapi_mgr;
struct fwq_tx;
struct fwq_tx_stats;
struct ie_iter;
struct ie_ref;
struct ieee80211_addba;
struct ieee80211_addba_resp;
struct ieee80211_assoc_resp;
struct ieee80211_delba;
struct ieee80211_hdr;
struct ieee80211_qos_hdr;
struct if_gain_meas;
struct link_stats_sm;
struct ll_ageing_det;
struct ll_bcn_det;
struct ll_ka_det;
struct llist;
struct lm_if;
struct lm_sm;
struct lmac_cmd_bcn_sweep;
struct lmac_cmd_echo;
struct lmac_cmd_ina_det;
struct lmac_evt_ba_timeout;
struct lmac_evt_bf_done;
struct lmac_evt_field_rsp;
struct lmac_evt_link_lost;
struct lmac_evt_ps_peer;
struct lmac_evt_queue_deleted;
struct lmac_evt_rs_done;
struct lmac_evt_typed;
struct lmac_evt_u32;
struct lmac_mac_cfg_src;
struct lmac_mbox;
struct lmac_rs_result;
struct macq_ba_desc;
struct macq_desc;
struct macq_mode_desc;
struct macq_qdesc;
struct macq_sector_desc;
struct maintain_sm;
struct mbox_entry;
struct mbox_hdr;
struct mbox_ring;
struct mbox_ring_hw;
struct mem_pool;
struct mid;
struct mid_bss;
struct mid_disc;
struct mid_sec;
struct mlme_sm;
struct operational_mbox;
struct phy_apu_res;
struct phy_monitor;
struct phy_rx_stats;
struct pring;
struct prs_rule;
struct ps_ctx;
struct psvc;
struct radio_mgr;
struct rf_auto_fill;
struct rf_obj;
struct rf_reg_pair;
struct rf_sector_sel_req;
struct rfc_rgf_req;
struct ring_idx;
struct rm_ch_switch_sm;
struct rm_chan;
struct rm_main_sm;
struct rm_queue;
struct rm_req;
struct rx_ba_win_params;
struct rx_desc;
struct rx_dma_ring;
struct rx_mgmt_ei;
struct rx_pkt;
struct rx_pkt_srvs;
struct rx_pkt_srvs_vt2;
struct rx_ring;
struct scan_mngr;
struct scan_passive_info;
struct scan_peer;
struct sched_scheme;
struct ss_cfg_s;
struct stream_ctx;
struct stream_sm;
struct swc_psc_sm;
struct sysapi_energy_stats;
struct sysapi_lut;
struct tx_desc;
struct tx_pkt;
struct tx_probe_param;
struct tx_retry;
struct tx_ring;
struct txq_ring_param;
struct u_schd_task;
struct u_schd_tq;
struct ut_bf_stats;
struct ut_cmd;
struct ut_rsp;
struct vring_rec;
struct vring_schd;
struct vring_schd_if;
struct vring_tbl_entry;
struct wil_vs_old;
struct wil_vs_tlv;
struct wmi_add_cipher_key_cmd;
struct wmi_add_debug_tx_pckt_cmd;
struct wmi_bcast_vring_cfg_cmd;
struct wmi_bcon_ctrl_cmd;
struct wmi_bf_trig_cmd;
struct wmi_brp_set_ant_limit_cmd;
struct wmi_connect_cmd;
struct wmi_delete_cipher_key_cmd;
struct wmi_disconnect_sta_cmd;
struct wmi_fixed_scheduling_config_cmd;
struct wmi_fixed_scheduling_ul_config_cmd;
struct wmi_get_detailed_rs_res_cmd;
struct wmi_get_rf_sector_params_cmd;
struct wmi_get_selected_rf_sector_index_cmd;
struct wmi_link_maintain_cfg_read_cmd;
struct wmi_link_maintain_cfg_write_cmd;
struct wmi_mbox;
struct wmi_new_sta_cmd;
struct wmi_notify_req_cmd;
struct wmi_p2p_cfg_cmd;
struct wmi_pcp_start_cmd;
struct wmi_pmc_cmd;
struct wmi_port_allocate_cmd;
struct wmi_prio_tx_sectors_number_cmd;
struct wmi_prio_tx_sectors_order_cmd;
struct wmi_prio_tx_sectors_set_default_cfg_cmd;
struct wmi_rcp_addba_resp_cmd;
struct wmi_rcp_delba_cmd;
struct wmi_rf_mgmt_cmd;
struct wmi_rf_pwr_on_delay_cmd;
struct wmi_rf_sector_get_req;
struct wmi_rf_sector_set_req;
struct wmi_rf_xpm_read_cmd;
struct wmi_rf_xpm_write_cmd;
struct wmi_rs_cfg_cmd;
struct wmi_scheduling_scheme_cmd;
struct wmi_set_appie_cmd;
struct wmi_set_cca_indications_bi_avg_num_cmd;
struct wmi_set_high_power_table_params_cmd;
struct wmi_set_mac_address_cmd;
struct wmi_set_multi_directed_omnis_config_cmd;
struct wmi_set_passphrase_cmd;
struct wmi_set_pcp_channel_cmd;
struct wmi_set_rf_sector_params_cmd;
struct wmi_set_sectors_cmd;
struct wmi_set_selected_rf_sector_index_cmd;
struct wmi_set_ssid_cmd;
struct wmi_sparraw_tdma_cfg_cmd;
struct wmi_sparraw_tx_power_cmd;
struct wmi_start_scan_cmd;
struct wmi_sw_ring_cfg;
struct wmi_sw_tx_req_cmd;
struct wmi_temp_sense_cmd;
struct wmi_ut_cmd;
struct wmi_vring_ba_en_cmd;
struct wmi_vring_cfg;
struct wmi_vring_cfg_schd;
struct wmi_vring_switch_timing_config_cmd;
union mac_addr;

u32 Calib_Measure_VGA_Gains (void);                                                                  /* calib.c */
void FWQ_TX_AVAILABILITY_init (void);                                                                /* fwq_tx.c */
void FWQ_TX_AVAILABILITY_remove_packet (u32 q, u32 f);                                               /* fwq_tx.c */
void IF_GAIN_GAIN (u32 mode, u32 sub, u32 act, struct if_gain_meas *out);                            /* calib.c */
u32 SDP_hwd_sdp_is_defined_sdp (u32 i);                                                              /* hw_init.c */
void SDP_sdp_drive_value (u32 value, u32 port);                                                      /* hw_init.c */
void SDP_sdp_init_2 (u32 i);                                                                         /* hw_init.c */
u32 STREAM_MGR_ADD (struct stream_ctx *ctx, const struct wmi_vring_cfg *cfg, u32 mpdu);              /* stream_mgr.c */
u32 TX_API_alloc_tx_payload (void);                                                                  /* fwq_tx.c */
void TX_API_free_memory (u32 payload);                                                               /* fwq_tx.c */
void TX_API_handle_completed_packets (struct fwq_tx *q);                                             /* fwq_tx.c */
void TX_API_post_tx_payload (u32 payload, u32 mid);                                                  /* mlme.c */
u32 TX_API_send_dband_bcon (u32 payload, u16 len, tx_done_fn wb, tx_sent_fn cb, struct bcon_post_info *info, u32 channel); /* stubs.c */
void TX_INTERNAL_API_connection (u32 cid);                                                           /* fwq_tx.c */
void abif_ack_unmask_fs_unlock_irq (void);                                                           /* car.c */
void abif_ack_unmask_pll_unlock_irq (void);                                                          /* car.c */
void abif_agc_field_rmw (u32 idx, u32 col, u32 sel, u32 d);                                          /* calib_hw.c */
u32 abif_get_rx_table_index_force_val (void);                                                        /* calib_hw.c */
void abif_mask_fs_unlock_irq (void);                                                                 /* car.c */
void abif_mask_pll_unlock_irq (void);                                                                /* power_halt.c */
void abif_mode_switch (u32 on);                                                                      /* power_halt.c */
void abif_power_up_analog (u32 on);                                                                  /* car.c */
void abif_set_3bit_all_chains (u32 v);                                                               /* calib_hw.c */
void abif_set_ctrl48_bit18 (u32 on);                                                                 /* power_halt.c */
void abif_set_nibble_all_chains (u32 v);                                                             /* calib_hw.c */
void abort (void);                                                                                   /* assert.c */
void add_bcon (struct mid *obj);                                                                     /* stubs.c */
void add_discovery_bcon (struct mid *mid_e, u32 scan_type);                                          /* stubs.c */
void agc_get_table_pair (const struct calib_silent_rssi *p, u32 flag, u32 *out1, u32 *out2);         /* calib.c */
struct dband_info *alloc_dband_info (void);                                                          /* scan_mngr.c */
u8 *app_ie_find_by_eid (struct app_ies *block, u32 eid);                                             /* wmi_cmd.c */
void app_ie_print_ies (struct app_ies *block);                                                       /* wmi_cmd.c */
u32 app_ie_remove_tlv (struct app_ies *b, u32 tlv_id);                                               /* stubs.c */
u8 *app_ie_walk_list (struct ie_iter *it);                                                           /* mgmt_tx.c */
u32 app_ies_clear (struct app_ies *b);                                                               /* wmi_cmd.c */
void app_ies_set_buffer (struct app_ies *block, const void *buf, u32 len, u32 frame_type);           /* mgmt_tx.c */
u32 approx_magnitude (u32 a0, u32 a1);                                                               /* calib.c */
u32 approx_magnitude_b (struct calib_obj *obj, u32 b, u32 c);                                        /* calib.c */
void arc_action_point_arm (const struct arc_ap_cfg *cfg);                                            /* hw_init.c */
void arc_action_point_install_default (void);                                                        /* stubs.c */
void assert_notify_host (void);                                                                      /* sysassert.c */
void assert_restore_hw_for_dump (void);                                                              /* sysassert.c */
void assoc_ready_check_trig (struct mid *mid);                                                       /* conn.c */
void ba_addba_req_tx_done (u32 pl, u32 status, u32 a2);                                              /* ba.c */
void ba_on_uc_timeout_evt (const struct lmac_evt_ba_timeout *e);                                     /* lmac_evt.c */
void ba_retry_flow (struct ba_setup_sm *b);                                                          /* ba.c */
void ba_setup_act_abort (struct ba_setup_sm *b);                                                     /* ba.c */
void ba_setup_act_arm_retry (struct ba_setup_sm *b);                                                 /* ba.c */
void ba_setup_act_finish (struct ba_setup_sm *b);                                                    /* ba.c */
void ba_setup_act_req_sent (struct ba_setup_sm *b);                                                  /* ba.c */
void ba_setup_act_resp (struct ba_setup_sm *b, const struct ieee80211_addba_resp *r);                /* ba.c */
void ba_setup_act_send_req (struct ba_setup_sm *b);                                                  /* ba.c */
void ba_setup_act_start (struct ba_setup_sm *b);                                                     /* ba.c */
void ba_setup_act_store (struct ba_setup_sm *b, u32 win, u32 timeout, u32 amsdu);                    /* ba.c */
void ba_setup_act_success (struct ba_setup_sm *b);                                                   /* ba.c */
void ba_setup_act_suspend (struct ba_setup_sm *b);                                                   /* ba.c */
void ba_setup_act_tx_failed (struct ba_setup_sm *b);                                                 /* ba.c */
void ba_setup_close_all_timers (struct ba_setup_sm *b);                                              /* ba.c */
void ba_setup_close_global_timer (struct ba_setup_sm *b);                                            /* ba.c */
void ba_setup_close_resp_timer (struct ba_setup_sm *b);                                              /* ba.c */
void ba_setup_close_retry_timer (struct ba_setup_sm *b);                                             /* ba.c */
void ba_setup_global_timeout_cb (u32 arg, u32 a1);                                                   /* ba.c */
void ba_setup_resp_timeout_cb (u32 arg, u32 a1);                                                     /* ba.c */
void ba_setup_retry_timeout_cb (u32 arg, u32 a1);                                                    /* ba.c */
void ba_sm_addba_at_08 (const struct vring_tbl_entry *e, struct macq_qdesc *buf, u32 a2, u32 a3, u32 a4, u32 a5, u32 a6); /* tx_queue.c */
void ba_sm_addba_at_10 (const struct vring_tbl_entry *e, struct macq_qdesc *buf, u32 a2, u32 a3, u32 a4, u32 a5); /* tx_helpers.c */
void ba_sm_build_addba_params (struct vring_tbl_entry *e, u32 mode, u32 a2, u32 a3, u32 a4, u32 a5); /* ba.c */
void ba_sm_evt_type (struct stream_ctx *obj, u32 evt, u32 a0, u32 a1, u32 a2);                       /* tx_helpers.c */
u32 ba_sm_get_param_byte6 (const struct stream_sm *s);                                               /* ba.c */
u32 ba_sm_get_param_byte7 (const struct stream_sm *s);                                               /* ba.c */
void ba_sm_prepare_ba_td (struct mbox_ring *r, u32 alloc);                                           /* pool.c */
void ba_sm_send_addba_req (struct stream_sm *s, u32 token, u32 win, u32 timeout, u32 amsdu);         /* ba.c */
void ba_sm_send_delba (struct stream_sm *s, u32 reason);                                             /* ba.c */
void ba_sm_setup_result (const struct ieee80211_addba *f, struct conn *conn);                        /* action.c */
void backoff_add_and_schedule (struct tx_retry *o, u32 a);                                           /* fwq_tx.c */
void bad_beacons_check_counter (struct ll_bcn_det *o);                                               /* l2mgr.c */
void bad_beacons_detector_arm (struct ll_bcn_det *o);                                                /* link_loss.c */
void bad_beacons_detector_stop_monitoring (struct ll_bcn_det *a);                                    /* discovery.c */
void baseband_identify (void);                                                                       /* phy.c */
u32 basic_calib_check_online_estimation_condition (struct calib_obj *obj);                           /* calib_engine.c */
void basic_calib_estimation_post (struct calib_obj *obj, u32 mask);                                  /* calib_engine.c */
void basic_calib_estimation_pre (struct calib_obj *obj, u32 mask);                                   /* calib_engine.c */
s32 basic_calib_get_bb_temperature (u32 a);                                                          /* calib_engine.c */
u32 basic_calib_is_temperature_changed (struct calib_obj *obj, u32 thr, s32 cur, s32 *last);         /* calib_engine.c */
void basic_calib_set_fragments_num (struct calib_obj *obj, u32 mask, struct calib_est *out);         /* calib_engine.c */
u32 basic_calib_sparrow_estimation_alg (struct calib_obj *obj, u32 mask, struct calib_est *out);     /* calib_engine.c */
void basic_sm_bind_descriptor (void *obj, const void *desc);                                         /* power.c */
void basic_sm_do_transition (void *obj, u32 ev, u32 a0, u32 a1, u32 a2);                             /* power.c */
void basic_sm_error_handler (const void *obj);                                                       /* power.c */
void basic_sm_handle_event (void *obj, u32 ev, u32 a0, u32 a1, u32 a2);                              /* power.c */
void bcn_tx_init_bi_cfg (volatile struct lmac_cmd_bcn_sweep *cmd, u32 w0, u32 w1);                   /* pcp_ext.c */
void bcn_tx_init_ss_params (volatile struct lmac_cmd_bcn_sweep *cmd, u32 w0, u32 w1);                /* pcp_ext.c */
void bcon_bits_set16_s7_w3 (u8 *p, u32 v);                                                           /* stubs.c */
void bcon_post_send_cb (struct bcon_post_info *info, u32 sent);                                      /* stubs.c */
void bcon_tx_build_step (struct mid_bss *mid, u32 a1);                                               /* stubs.c */
void ber_stats_snapshot (u32 *ctx);                                                                  /* calib.c */
u32 ber_test_accumulate_counters (u32 *ctx);                                                         /* calib.c */
void ber_test_copy_counters (u32 *dst, const u32 *ctx);                                              /* calib.c */
void ber_test_measure (struct calib_obj *obj, u32 *ctx, u32 *best_xy, u32 *best_metric);             /* calib.c */
u32 bf_insert_field (u32 word, u32 value, u32 shift, u32 width);                                     /* macq.c */
u32 bf_req_is_claimable (struct fw_sysapi_mgr *req, u32 id);                                         /* misc_ext_sysapi.c */
u32 bit_iter_has_more (const u32 *p);                                                                /* power.c */
u32 bitmap_alloc_bit (u32 *p);                                                                       /* power.c */
u32 bitmap_expand_byte4_to_list (const struct calib_est *rfm, u8 *list);                             /* calib.c */
u32 bits_lowest_set_bit8 (u32 v);                                                                    /* misc_ext.c */
void bits_set16h_s0_w2 (void *p, u32 v);                                                             /* tx_helpers.c */
void bits_set16h_s0_w4 (u16 *p, u32 v);                                                              /* tx_api.c */
void bits_set16h_s4_w5 (void *p, u32 v);                                                             /* mac_parser.c */
void bits_set16h_s5_w2 (u16 *p, u32 v);                                                              /* tx_api.c */
u32 bits_set32_s0_w12 (u32 w, u32 v);                                                                /* macq.c */
void bits_set32_s0_w4 (u32 *p, u32 v);                                                               /* rx_chain.c */
void bits_set32_s16_w12 (void *p, u32 v);                                                            /* tx_helpers.c */
u32 bits_set32_s16_w4 (u32 w, u32 v);                                                                /* macq.c */
void bits_set32_s16_w4_ptr (u32 *p, u32 v);                                                          /* calib.c */
void bits_set32_s16_w5 (u32 *p, u32 v);                                                              /* tx_helpers.c */
u32 bits_set32_s24_w7 (u32 w, u32 v);                                                                /* macq.c */
void bits_set32_s4_w12 (void *p, u32 v);                                                             /* tx_helpers.c */
u32 bits_set32_s8_w3 (u32 w, u32 v);                                                                 /* macq.c */
void bits_set8_s6_w2 (u8 *p, u32 v);                                                                 /* tx_api.c */
void bits_set_s8_w5 (u32 *p, u32 v);                                                                 /* tx_helpers.c */
void bits_set_word (u32 *p, u32 start, u32 width, u32 v);                                            /* util.c */
u32 bits_sign_extend_n (u32 value, u32 n);                                                           /* phy.c */
void boot_fill_addr_tables (void);                                                                   /* boot.c */
void boot_force_production_mode (void);                                                              /* platform.c */
u32 boot_init_named_object (void *obj, void *name, u32 off, void *dst);                              /* stubs.c */
void boot_init_subsystems (struct dashboard *dash);                                                  /* subsys.c */
void boot_install_diag_magic (void);                                                                 /* stubs.c */
void boot_load_from_flash (void);                                                                    /* flash.c */
void boot_publish_ids (void);                                                                        /* platform.c */
u32 boot_read_strap_bit (void);                                                                      /* platform.c */
void boot_save_mac_address (u8 *mac);                                                                /* flash.c */
void bootloader_version_log (void);                                                                  /* log.c */
void brd_if_base_vt_module_rf_base (struct brd_if *o, struct brd_section_info *info, u32 blk_idx);   /* brd_if.c */
u32 brd_if_base_vt_read (struct brd_if *o, u32 k, u8 *out);                                          /* brd_if.c */
void brd_if_build_tx_sector_list (struct brd_if *o);                                                 /* brd_if.c */
void brd_if_clear_block_info (struct brd_block_info *blk);                                           /* brd_if.c */
struct llist *brd_if_multi_array_get_chunk_8cbbc4 (struct fwq_tx *q, u32 ch);                        /* fwq_tx.c */
u32 brd_if_vt_get_block_info (struct brd_if *o, const struct brd_section_info *info, u32 blk_idx, struct brd_block_info *blk); /* brd_if.c */
u32 brd_if_vt_get_chunk (struct brd_if *o, const struct brd_section_info *info, const struct brd_block_info *blk, u32 idx, struct rf_reg_pair *out, u32 per_chunk, const struct brd_bounds *bounds); /* brd_if.c */
u32 brd_if_vt_get_section_info (struct brd_if *o, u32 id, struct brd_section_info *info);            /* brd_if.c */
void brd_if_vt_module_rf_base (struct brd_if *o, struct brd_section_info *info, u32 blk_idx);        /* brd_if.c */
u32 brd_if_vt_num_tx_sectors (struct brd_if *o);                                                     /* brd_if.c */
u32 brd_if_vt_read (struct brd_if *o, u32 k, u8 *out);                                               /* brd_if.c */
const u8 *brd_if_vt_tx_sectors (struct brd_if *o);                                                   /* brd_if.c */
void brd_section_info_reset (struct brd_section_info *info);                                         /* brd_if.c */
void bss_bi_ctrl_pcp_ready_set (struct mid_bss *mid, u32 security_en);                               /* stubs.c */
void bss_set_active (struct mid_bss *obj);                                                           /* wmi_cmd.c */
void bss_set_mode (struct mid_bss *o, u32 mode);                                                     /* mid.c */
u32 builder_push_dmg_parameters (u8 *dst, const struct mid *obj);                                    /* stubs.c */
void bytes_pick4_by_index (const calib_u8x4_t *idx, calib_u8x4_t lim, calib_row8_t r1, calib_row8_t r2, calib_row8_t r3, calib_row8_t r4, calib_u8x4_t *out); /* calib.c */
void calib_battery_phy_step (u32 shift, calib_vga_pt_t *out, calib_batt_meas_t *meas);               /* calib.c */
void calib_battery_prepare (calib_batt_meas_t *out, u32 shift);                                      /* calib.c */
u32 calib_bb_gain_dc_check_online_estimation_condition (struct calib_obj *obj);                      /* calib_engine.c */
u32 calib_bb_gain_pack_row (const u8 *src, u32 flag);                                                /* calib.c */
void calib_bits_set32_s20_w12 (u32 *p, u32 v);                                                       /* calib.c */
struct calib_scheme *calib_cfg_get_scheme (u32 pcp_ap, u32 st);                                      /* calib_engine.c */
void calib_classify_by_thresholds (struct calib_silent_rssi *obj, u32 module_idx);                   /* calib.c */
void calib_corr_estimate_and_apply_rx_gain (void);                                                   /* calib.c */
s32 calib_delta (u32 a, u32 b, u32 c);                                                               /* calib.c */
void calib_engine_abort_all (void);                                                                  /* calib_engine.c */
void calib_engine_accumulate_if_enabled (u32 dt);                                                    /* calib.c */
struct calib_obj *calib_engine_get_by_index (u32 idx);                                               /* power.c */
void calib_engine_init_all (void);                                                                   /* power.c */
void calib_engine_on_abort (struct calib_engine *sm);                                                /* calib_engine.c */
void calib_engine_on_calib_done (struct calib_engine *sm);                                           /* calib_engine.c */
void calib_engine_on_frag_done (struct calib_engine *sm);                                            /* calib_engine.c */
void calib_engine_on_lock_radio (struct calib_engine *sm);                                           /* calib_engine.c */
void calib_engine_on_ready_for_correction (struct calib_engine *sm);                                 /* calib.c */
void calib_engine_on_start (struct calib_engine *sm);                                                /* calib_engine.c */
void calib_engine_sm_init (struct calib_engine *sm, u32 idx, struct calib_obj *obj);                 /* power.c */
u32 calib_if_gain_is_radio_lock_needed (struct calib_obj *obj);                                      /* calib_engine.c */
u32 calib_if_gain_main (struct calib_obj *obj, u32 mask, u32 a2, u32 a3, struct calib_est *a4);      /* calib.c */
void calib_if_gain_post (struct calib_obj *obj, u32 mask);                                           /* calib.c */
void calib_if_gain_pre (struct calib_obj *obj, u32 mask);                                            /* calib.c */
void calib_keep_closest (calib_vga_pt_t *best, s32 val, calib_u8x4_t g, s32 target);                 /* calib.c */
u32 calib_lo_leakage_is_radio_lock_needed (struct calib_obj *obj);                                   /* calib_engine.c */
u32 calib_lo_leakage_main (struct calib_obj *obj, u32 mask, u32 a2, u32 a3, struct calib_est *a4);   /* calib.c */
void calib_lo_leakage_post (struct calib_obj *obj, u32 mask);                                        /* calib.c */
void calib_lo_leakage_pre (struct calib_obj *obj, u32 mask);                                         /* calib.c */
void calib_lo_leakage_prepare_ctx (s32 *ctx, s32 x, s32 y, s32 step, s32 kx, s32 ky);                /* calib.c */
void calib_lo_leakage_step (struct calib_obj *obj, u8 *dc);                                          /* calib.c */
void calib_lo_leakage_substep (struct calib_obj *obj, const u8 *dc);                                 /* calib.c */
void calib_lo_leakage_sweep (struct calib_obj *obj, u32 *out_x, u32 *out_y, const u32 *steps);       /* calib.c */
u32 calib_lo_power_is_radio_lock_needed (struct calib_obj *obj);                                     /* calib_engine.c */
u32 calib_lo_power_main (struct calib_obj *obj, u32 mask, u32 a2, u32 a3, struct calib_est *a4);     /* calib.c */
void calib_lo_power_measure (u32 idx, u32 shift, calib_vga_pt_t *res);                               /* calib.c */
void calib_lo_power_post (struct calib_obj *obj, u32 mask);                                          /* calib.c */
void calib_lo_power_pre (struct calib_obj *obj, u32 mask);                                           /* calib.c */
void calib_lo_power_save_level (u32 v);                                                              /* calib.c */
void calib_lo_power_step (u32 bits3, u32 nibble, u32 *fields, u32 level);                            /* calib.c */
void calib_lo_power_step_save_mode (u32 bits3, u32 nibble, u32 *fields, u32 level);                  /* calib.c */
void calib_lo_power_substep (u32 *out, u32 idx, u32 target);                                         /* calib.c */
void calib_lo_set_result (u32 *p, u32 a, u32 b, u32 c, u32 d);                                       /* calib.c */
void calib_log_if_nonzero (u32 a, u32 flag);                                                         /* calib.c */
void calib_mgr_ut (const struct wmi_ut_cmd *c);                                                      /* wmi_h_misc.c */
void calib_mngr_engine_start (u32 idx, u32 mask, u32 periodic, u32 nfrag, u32 pause, calib_done_fn cb, u32 cb_a0, u32 cb_a1); /* calib_engine.c */
void calib_mngr_engine_step (struct calib_engine *eng, u32 mask, u32 periodic, u32 nfrag, u32 pause, calib_done_fn cb, u32 cb_a0, u32 cb_a1); /* calib_engine.c */
void calib_mngr_start_scheme (const struct calib_scheme *scheme);                                    /* calib_engine.c */
void calib_mngr_system_state_evt_handler (u32 st, u32 ch);                                           /* radio_mgr.c */
struct calib_silent_rssi *calib_obj4_reset_d4 (void);                                                /* power.c */
void calib_obj_reset_results (struct calib_obj *o);                                                  /* calib.c */
void calib_release_hw_thunk (void);                                                                  /* calib.c */
void calib_req_fill (struct calib_est *dst, u32 unused, u32 val, u32 byte, u32 val2);                /* calib.c */
u32 *calib_results_addr_800a28 (void);                                                               /* calib.c */
u32 *calib_results_addr_800a34 (void);                                                               /* calib.c */
void calib_row_step (u32 row, const calib_u8x4_t *idx, calib_u8x4_t lim, calib_row8_t r1, calib_row8_t r2, calib_row8_t r3, calib_row8_t r4, u32 mode, u32 col, calib_vga_pt_t *meas, u8 *dc); /* calib.c */
void calib_sar_enable_path (u32 sar_off, u32 release);                                               /* calib.c */
u32 calib_sar_is_radio_lock_needed (struct calib_obj *obj);                                          /* calib_engine.c */
u32 calib_sar_main (struct calib_obj *obj, u32 mask, u32 a2, u32 a3, struct calib_est *a4);          /* calib.c */
void calib_sar_post (struct calib_obj *obj, u32 mask);                                               /* calib.c */
void calib_sar_pre (struct calib_obj *obj, u32 mask);                                                /* calib.c */
u32 calib_sar_step (u32 idx, u32 n, u32 avg, u32 thr);                                               /* calib.c */
void calib_sar_step2 (u32 shift);                                                                    /* calib.c */
void calib_setup_loopback_hw (u32 acquire, u32 abif, u32 phy, u32 sar, u32 shift);                   /* calib.c */
void calib_setup_loopback_hw_b (u32 acquire, u32 abif, u32 phy, u32 corr, u32 shift);                /* calib.c */
void calib_setup_loopback_rx_path (void);                                                            /* calib.c */
void calib_silent_rssi_ctor (struct calib_silent_rssi *obj);                                         /* calib.c */
void calib_silent_rssi_flag_step (u32 a0, u32 a1, u32 a2, u32 a3);                                   /* calib.c */
u32 calib_silent_rssi_is_radio_lock_needed (struct calib_obj *obj);                                  /* calib_engine.c */
u32 calib_silent_rssi_main (struct calib_obj *o, u32 mask, u32 a2, u32 a3, struct calib_est *a4);    /* calib.c */
void calib_silent_rssi_post (struct calib_obj *obj, u32 mask);                                       /* calib.c */
void calib_silent_rssi_pre (struct calib_obj *obj, u32 mask);                                        /* calib.c */
void calib_silent_rssi_set_fragments_num (struct calib_obj *obj, u32 mask, struct calib_est *out);   /* calib_engine.c */
u32 calib_silent_rssi_sparrow_correction_alg (struct calib_obj *obj, u32 mask, u32 frag, u32 nfrag, struct calib_est *est); /* calib.c */
u32 calib_silent_rssi_sparrow_estimation_alg (struct calib_obj *obj, u32 mask, struct calib_est *out); /* calib_engine.c */
u32 calib_silent_rssi_sparrow_find_agc_start (struct calib_silent_rssi *obj, u32 val, u32 idx, u32 thr, u32 *out); /* calib.c */
u32 calib_silent_rssi_sparrow_find_rf_gain (struct calib_silent_rssi *obj, u32 idx, u32 mode, s32 target); /* calib.c */
u32 calib_silent_rssi_sparrow_run_calibration_fragment (struct calib_silent_rssi *obj, u32 mask, u32 idx, u32 count, const struct calib_est *rfm); /* calib.c */
void calib_silent_rssi_sparrow_set_agc_start_val (struct calib_silent_rssi *obj, u32 val, u32 idx);  /* calib.c */
u32 calib_silent_rssi_step (struct calib_silent_rssi *obj, u32 mask, const struct calib_est *rfm);   /* calib.c */
u32 calib_vga_coarse (calib_u8x4_t lim, calib_row8_t r1, calib_row8_t r2, calib_row8_t r3, calib_row8_t r4, calib_vga_pt_t meas, calib_vga_pt_t best, calib_u8x4_t *prev, calib_u8x4_t *cur, calib_u8x4_t *keep, calib_u8x4_t *dc, u32 *retry, u8 *next_col, u32 col, u8 *col_out, u32 first, u32 *status); /* calib.c */
void calib_vga_coarse_limit (calib_u8x4_t lim, calib_row8_t r1, calib_row8_t r2, calib_row8_t r3, calib_row8_t r4, calib_u8x4_t *idx, u32 val, u8 *next_col, u32 col, u32 flag, u8 *col_out, u32 *status); /* calib.c */
u32 calib_vga_gain_step (u32 lo, u32 hi);                                                            /* calib.c */
u32 calib_vga_is_radio_lock_needed (struct calib_obj *obj);                                          /* calib_engine.c */
u32 calib_vga_main (struct calib_obj *obj, u32 mask, u32 a2, u32 a3, struct calib_est *a4);          /* calib.c */
void calib_vga_post (struct calib_obj *obj, u32 mask);                                               /* calib.c */
void calib_vga_pre (struct calib_obj *obj, u32 mask);                                                /* calib.c */
void calib_vt_method1_noop (struct calib_obj *a);                                                    /* stubs.c */
void calib_vtable_setup (void);                                                                      /* stubs.c */
u32 calibrate_baseband_gain (struct calib_silent_rssi *obj, u32 mask, const struct calib_est *rfm);  /* calib.c */
void car_enable_pll3_and_wait (u32 on);                                                              /* car.c */
void car_enable_pll3_and_wait_on (void);                                                             /* car.c */
u32 car_get_pll3_status_bit3 (void);                                                                 /* car.c */
void chan_sw_set_active_channel (u32 v);                                                             /* power.c */
void channel_check_range (u32 ch, u32 a, u32 b);                                                     /* ut_hw_drivers.c */
void channel_est_clamp_64 (struct fw_sysapi_mgr *mgr, u32 timeout, u_schd_fn cb);                    /* phy_ext.c */
void channel_est_stack_args (u32 type, u32 w0, u32 w1, u32 w2);                                      /* phy_ext.c */
void channel_estimation_cmd_start (struct fw_sysapi_mgr *mgr, const u8 *p, u32 timeout, u32 ctx0, u32 ctx1); /* phy_ext.c */
void channels_switch_sm_abort_dwelling (struct channels_switch_sm *cs);                              /* discovery.c */
void channels_switch_sm_action_abort_allocate (struct channels_switch_sm *cs);                       /* scan.c */
void channels_switch_sm_action_allocate_radio (struct channels_switch_sm *cs);                       /* scan.c */
void channels_switch_sm_action_dwelling_stopped (struct channels_switch_sm *cs);                     /* scan.c */
void channels_switch_sm_action_pop_ch_and_tune (struct channels_switch_sm *cs);                      /* scan.c */
void channels_switch_sm_action_radio_tunned (struct channels_switch_sm *cs, u32 a0);                 /* scan.c */
void channels_switch_sm_action_scan_complete (struct channels_switch_sm *cs, u32 a0);                /* scan.c */
void channels_switch_sm_action_start_dwelling (struct channels_switch_sm *cs);                       /* scan.c */
void channels_switch_sm_alloc_timeout_cb (u32 a0, u32 a1);                                           /* scan.c */
void channels_switch_sm_channel_switched_cb (struct rm_req *x, u32 cs);                              /* scan.c */
void channels_switch_sm_dwell_timeout_cb (u32 cs, u32 a1);                                           /* scan.c */
void channels_switch_sm_radio_allocated_cb (struct rm_req *x, u32 cs);                               /* scan.c */
void channels_switch_sm_scan_abort_tunning (struct channels_switch_sm *cs);                          /* scan.c */
void channels_switch_sm_scan_timeout_cb (u32 a0, u32 a1);                                            /* scan.c */
u32 channels_switch_sm_switch_to_channel (u32 ch);                                                   /* chan_sw.c */
void check_rf_boardfile (struct rf_obj *this);                                                       /* rf.c */
u32 cid_pair_matches (struct sched_scheme *obj, u32 a, u32 b);                                       /* rx.c */
u32 class_calib_lo_power_estimation_alg (struct calib_obj *o, u32 mask, struct calib_est *out);      /* calib_engine.c */
void cnt_handler_clear_all (void);                                                                   /* hw_init.c */
void conn_abort (struct conn *conn, u32 flag);                                                       /* discovery.c */
void conn_alloc_and_fill (u32 a0, u32 a1, const struct macq_qdesc *a2, u32 a3);                      /* tx_helpers.c */
void conn_alloc_and_link (u32 kind, u32 a1, u32 mid);                                                /* conn.c */
void conn_alloc_and_link_kind1 (u32 a1, u32 mid);                                                    /* conn.c */
void conn_arm_retry_timer (struct conn *conn, u32 restart);                                          /* link_loss.c */
void conn_check_field_50 (struct conn *conn);                                                        /* discovery.c */
void conn_config_txss_and_sta (struct conn *conn);                                                   /* mlme.c */
void conn_disc_detail_set (u32 cid, u32 detail);                                                     /* conn.c */
void conn_disc_detail_set_mid (struct mid *mid, u32 detail);                                         /* conn.c */
u32 conn_disc_detail_take (u32 cid);                                                                 /* conn.c */
void conn_disc_sm_disassoc_sent_cb (u32 payload, u32 status, u32 a2);                                /* link_sm.c */
void conn_disconnect (struct conn *conn, u32 reason, u32 protocol);                                  /* discovery.c */
u32 conn_get_cid (struct lm_if *lm);                                                                 /* conn.c */
u32 conn_get_cid_of_obj (struct lm_sm *l);                                                           /* conn.c */
u32 conn_get_mid_idx (struct lm_if *lm);                                                             /* conn.c */
void conn_inject_evt4 (struct conn *conn);                                                           /* fwq_tx.c */
void conn_link_up_task (u32 a0, u32 v);                                                              /* conn.c */
void conn_linkup_ntf (struct conn *conn, u32 v);                                                     /* conn.c */
void conn_main_sm_action_step_b (struct lm_if *lm);                                                  /* conn.c */
void conn_main_sm_bcon_rx_timeout_evt (u32 a0, u32 a1);                                              /* conn.c */
void conn_main_sm_inject_bcon_rx (struct conn *conn, struct rx_pkt *pkt);                            /* scan_mngr.c */
void conn_main_sm_linkup_ntf (struct conn_msm *sm, u32 a0);                                          /* conn.c */
void conn_main_sm_start_disc (struct conn_msm *sm, u32 reason, u32 protocol);                        /* conn.c */
u32 conn_mgr_activate_conn (struct conn *conn, u32 flag);                                            /* discovery.c */
void conn_mgr_add_to_rinking_list (struct conn *conn);                                               /* discovery.c */
struct conn *conn_mgr_alloc_cid (void);                                                              /* scan_mngr.c */
u32 conn_mgr_allocate_cid_db_element (struct conn *conn, u32 *out);                                  /* discovery.c */
void conn_mgr_bi_evt_all_conns (void);                                                               /* link_loss.c */
struct conn *conn_mgr_by_cid (u32 cid);                                                              /* tx_helpers.c */
u32 conn_mgr_find_in_ranking_list_fw (struct conn *conn);                                            /* discovery.c */
u32 conn_mgr_find_reusable_cid (void);                                                               /* scan_mngr.c */
void conn_mgr_free_cid_db_element (u32 cid);                                                         /* discovery.c */
void conn_mgr_link_down_evt (struct conn *conn);                                                     /* discovery.c */
void conn_mgr_link_up_evt (struct conn *conn, u32 v);                                                /* conn.c */
u32 conn_mgr_ranking_remove (struct conn *conn);                                                     /* conn.c */
void conn_mgr_start_link_loss_monitoring (struct conn *conn);                                        /* link_loss.c */
void conn_mgr_system_state_evt_handler (u32 st, u32 arg);                                            /* l2mgr.c */
void conn_msm_arm_bcon_timer (struct conn_msm *sm);                                                  /* conn.c */
void conn_msm_log_state (struct conn_msm *sm);                                                       /* conn.c */
void conn_msm_on_assoc_done (struct conn_msm *sm);                                                   /* conn.c */
void conn_msm_on_bcon_rx (struct conn_msm *sm, u32 a0, struct rx_pkt *pkt);                          /* conn.c */
void conn_msm_on_bcon_rx_key_assoc (void);                                                           /* conn.c */
void conn_msm_on_disc_complete (struct conn_msm *sm, u32 a0, u32 a1);                                /* conn.c */
void conn_msm_on_key_installed (struct conn_msm *sm);                                                /* conn.c */
void conn_msm_on_linkup_ready (struct conn_msm *sm, u32 a0);                                         /* conn.c */
void conn_msm_on_lm_started (struct conn_msm *sm);                                                   /* conn.c */
void conn_msm_on_lm_started_early (struct conn_msm *sm);                                             /* conn.c */
void conn_msm_on_own_assoc (struct conn_msm *sm);                                                    /* conn.c */
void conn_msm_on_own_start_link (struct conn_msm *sm, u32 a0, u32 a1);                               /* conn.c */
void conn_msm_on_own_start_link_unres (struct conn_msm *sm, u32 cid, u32 a1);                        /* conn.c */
void conn_notify_link_via_l2mgr (struct mid *mid, struct conn *conn, u32 v);                         /* conn.c */
void conn_post_lm_started (u32 a0, u32 a1);                                                          /* conn.c */
u32 conn_sec_mode_not_1 (struct conn *conn);                                                         /* discovery.c */
void conn_set_rf_params_from_caps (struct conn *p);                                                  /* l2mgr.c */
void conn_sm_handle_event (struct conn *conn, u32 ev, u32 a0, u32 a1, u32 a2);                       /* ba.c */
void conn_snapshot_step (struct lm_if *lm, const void *e);                                           /* scan_mngr.c */
u32 conn_tbl_slot_is_free (struct conn *e);                                                          /* scan.c */
void conn_teardown_mac_rules (struct conn *conn);                                                    /* discovery.c */
void conn_update_bf_id_on_rs_done (struct conn *conn, u32 mcs);                                      /* bf_result.c */
u32 connection_bf_id_at_6c (struct conn *conn);                                                      /* link_loss.c */
void connection_cmp_bf_id (struct conn *conn, u32 v);                                                /* link_loss.c */
void connection_init (struct conn *conn, const u8 *mac, struct mid *mid);                            /* discovery.c */
void connection_init_fields (struct conn *conn);                                                     /* discovery.c */
void connection_on_bf_result (struct conn *conn, u32 st, u32 a2);                                    /* bf_result.c */
void connection_store_ptr (struct lm_if *a, struct conn *conn);                                      /* discovery.c */
void ctor_array_847b48 (void);                                                                       /* ctors.c */
void ctor_array_854dd4 (void);                                                                       /* ctors.c */
void ctor_calib_classes (void);                                                                      /* ctors.c */
void ctor_calib_engines (void);                                                                      /* ctors.c */
void ctor_debug_mbox_vtable (void);                                                                  /* ctors.c */
void ctor_empty_8005b8 (void);                                                                       /* ctors.c */
void ctor_fwq_tx_vtables (void);                                                                     /* ctors.c */
void ctor_g8002f0_vtable (void);                                                                     /* ctors.c */
void ctor_obj_80426c_vtable (void);                                                                  /* ctors.c */
void ctor_obj_8042c8 (void);                                                                         /* ctors.c */
void ctor_obj_804dbc_vtables (void);                                                                 /* ctors.c */
void ctor_obj_804e90_vtable (void);                                                                  /* ctors.c */
void ctor_obj_805170 (void);                                                                         /* ctors.c */
void ctor_obj_805234 (void);                                                                         /* ctors.c */
void ctor_obj_8052e4 (void);                                                                         /* ctors.c */
void ctor_obj_805fe4_vtable (void);                                                                  /* ctors.c */
void ctor_obj_80676c_vtable (void);                                                                  /* ctors.c */
void ctor_obj_842840_vtables (void);                                                                 /* ctors.c */
void ctor_obj_84e7e0_vtable (void);                                                                  /* ctors.c */
void ctor_operational_mbox_vtable (void);                                                            /* ctors.c */
void ctor_pairs_804914 (void);                                                                       /* ctors.c */
void ctor_scan_timeout_and_sm_802fb4 (void);                                                         /* ctors.c */
void ctor_sm_802234_id (void);                                                                       /* ctors.c */
void ctor_sm_802338_id (void);                                                                       /* ctors.c */
void ctor_sm_802458_id (void);                                                                       /* ctors.c */
void ctor_sm_802754_id (void);                                                                       /* ctors.c */
void ctor_sm_802758_id (void);                                                                       /* ctors.c */
void ctor_sm_802940_id (void);                                                                       /* ctors.c */
void ctor_sm_802b08_id (void);                                                                       /* ctors.c */
void ctor_sm_802b64_id (void);                                                                       /* ctors.c */
void ctor_sm_802cc4_id (void);                                                                       /* ctors.c */
void ctor_sm_802da0_id (void);                                                                       /* ctors.c */
void ctor_sm_802f58_id (void);                                                                       /* ctors.c */
void ctor_sm_8030e0_id (void);                                                                       /* ctors.c */
void ctor_sm_8030f4_id (void);                                                                       /* ctors.c */
void ctor_swc_psc_sm (void);                                                                         /* ctors.c */
void ctor_u_schd_timer_vtables (void);                                                               /* ctors.c */
void dashboard_add_connection (struct conn *conn);                                                   /* conn.c */
void dashboard_bf_results (const struct lmac_evt_bf_done *e, struct conn *conn);                     /* bf_result.c */
u32 dbi_write (u32 addr, u32 data, u32 a2, u32 a3, u32 a4, u32 a5, u32 a6, u32 a7, u32 a8);          /* pcie.c */
struct wmi_mbox *debug_mbox_get_or_init (void);                                                      /* stubs.c */
void detector_arm_timer (struct psvc *obj);                                                          /* discovery.c */
void detector_init_common (struct psvc *o, u32 a1, u32 a2, u32 a3, u32 a4);                          /* l2mgr.c */
u32 detector_slot_is_bound (struct ll_bcn_det *o);                                                   /* l2mgr.c */
void disc_flush_sm_init (struct conn_disc_sm *a, struct conn_msm *msm);                              /* discovery.c */
void disc_on_fw_tx_stopped (struct conn_disc_sm *d);                                                 /* link_sm.c */
void disc_on_lms_stopped (struct conn_disc_sm *d);                                                   /* link_sm.c */
void disc_on_mlme_disc_done (struct conn_disc_sm *d, u32 reason, u32 proto);                         /* link_sm.c */
void disc_on_own_disc_done (struct conn_disc_sm *d);                                                 /* link_sm.c */
void disc_on_own_start (struct conn_disc_sm *d, u32 reason, u32 proto);                              /* link_sm.c */
void disc_on_ready_for_flush (struct conn_disc_sm *d);                                               /* link_sm.c */
void disc_on_sw_data_stopped (struct conn_disc_sm *d);                                               /* link_sm.c */
void disc_sm_sw_data_stopped (void);                                                                 /* rx_chain.c */
void disc_wait_for_disconnect_action (struct conn_disc_sm *d);                                       /* link_sm.c */
void disc_wait_timeout_cb (u32 a0, u32 a1);                                                          /* link_sm.c */
void disconnect_by_peer (u32 mid, struct conn *conn, u32 reason, u32 protocol);                      /* mlme.c */
u32 discovery_handle_probe_req (struct mid_disc *obj, struct rx_pkt *pkt);                           /* discovery.c */
u32 discovery_handle_probe_resp (struct mid_disc *obj, struct rx_pkt *pkt);                          /* discovery.c */
void discovery_init_probe_entry (struct conn *conn, struct rx_pkt *pkt, struct mid *bss_ctx);        /* discovery.c */
void discovery_inject_probe_evt (struct find_mngr *obj, struct rx_pkt *pkt);                         /* discovery.c */
u32 discovery_is_ssid_approved (struct mid_disc *obj, struct rx_pkt *pkt);                           /* discovery.c */
void discovery_rx_pkt_handler (struct mid_disc *obj, struct rx_pkt *pkt);                            /* discovery.c */
void discovery_rx_start (u32 discovery);                                                             /* scan.c */
void discovery_rx_stop (void);                                                                       /* scan.c */
int discovery_ssid_matches (const u8 *a, const u8 *b, u32 c);                                        /* discovery.c */
void discovery_tsf_wa (struct mid_disc *obj, u32 ch, u32 a3, u32 mid);                               /* scan.c */
u32 dma_is_idle (u32 q, u32 log);                                                                    /* vring.c */
void dma_mgr_configure_ring (u32 a, u32 b, u32 c, u32 d, u32 e, u32 f, u32 g, u32 h);                /* dma_ring.c */
u32 dma_mgr_queue_state_is_0 (u32 q);                                                                /* fwq_tx.c */
u32 dma_mgr_queue_state_is_1 (u32 q);                                                                /* fwq_tx.c */
void dma_mgr_reset_queue_0x19 (void);                                                                /* fwq_tx.c */
void dma_mgr_reset_queue_0x1a (void);                                                                /* fwq_tx.c */
void dma_mgr_setup_queue_pair (struct fwq_tx *q, u32 mode, struct fwq_tx_stats *stats, u32 macq, u32 dma, u32 base, u32 size); /* fwq_tx.c */
void dma_offload_pack_decap_cfg (u32 a0, u32 a1, u32 a2, u32 a3, u32 a4, u32 a5);                    /* rx_chain.c */
void dma_set_881b24_bit1 (void);                                                                     /* tx_helpers.c */
void dma_set_881b94_bits45 (u32 a0, u32 a1);                                                         /* rx_chain.c */
void dmaq_hw_reset_ptrs (u32 vr);                                                                    /* ba.c */
void dmg_bcon_build_allocations (struct mid *a, struct rx_pkt *b);                                   /* rx.c */
u32 dmg_bcon_rx_handler (struct mid_disc *obj, struct rx_pkt *pkt);                                  /* scan_mngr.c */
void dmg_cap_build_sta_capability (struct mid_bss *obj, const u8 *sta_addr);                         /* wmi_cmd.c */
void dpal_cpl_timeout_evt (u32 v);                                                                   /* dma_ring.c */
void dpal_cpl_timeout_task (u32 a0, u32 a1);                                                         /* vectors.c */
u32 eapol_frame_builder_build (u32 obj, u8 *buf, u32 *out_len, struct conn *ctx, u32 to_ds, const void *src, u32 len); /* vt_misc.c */
void ese_alloc_to_slot (struct sched_scheme *obj, u32 a, const struct ese_alloc *b);                 /* rx.c */
void ese_bits_set16h_s0_w3 (void *p, u32 v);                                                         /* rx_chain.c */
void ese_bits_set32_s3_w29 (void *p, u32 v);                                                         /* rx_chain.c */
u32 ese_peer_cid_by_aid (struct sched_scheme *obj, u32 a, u32 b);                                    /* rx.c */
void ese_rx_on_own_beacon (const struct rx_pkt *pkt);                                                /* rx.c */
void ese_set_alloc_type (void *p, u32 mode, u32 type, u32 flag);                                     /* rx_chain.c */
void ese_slot_table_add (struct ese_sched *obj, const void *slot);                                   /* rx.c */
void event_flush_q_done (const struct lmac_evt_u32 *e);                                              /* lmac_evt.c */
void evt_fixed_scheduling_enabled (const struct lmac_evt_typed *e);                                  /* lmac_evt.c */
void evt_get_selected_rf_sector_index_done (struct rf_sector_sel_req *r, u8 *e);                     /* lmac_evt.c */
void evt_ring_push_1c (u32 type, u32 code, u32 data);                                                /* pool.c */
void evt_set_selected_rf_sector_index_done (struct rf_sector_sel_req *r, u8 *e);                     /* lmac_evt.c */
void field_set_0x00_8d0a44 (u32 a0, u32 a1, u32 a2, u32 a3, u32 a4, u32 a5, u32 a6);                 /* dma_ring.c */
void field_set_0x00_8d8db8 (u32 *a, u32 b);                                                          /* pool.c */
void field_set_0x00_8db5bc (u32 v);                                                                  /* misc_ext.c */
void field_set_0x00_8dbc94 (u32 v);                                                                  /* misc_ext.c */
void field_set_0x00_8dbe88 (u32 type, u32 v);                                                        /* misc_ext.c */
void field_set_0x00_8e5dfc (u32 *a, u32 b);                                                          /* power.c */
void field_set_0x00_8e6f2c (struct rf_obj *obj, u32 v);                                              /* misc_ext.c */
void field_set_0x08_8d8eb4 (struct rm_ch_switch_sm *cs, struct rm_main_sm *sm);                      /* radio_mgr.c */
struct u_schd_task *field_set_0x19_8caf4c (struct u_schd_task *t);                                   /* power.c */
void find_main_sm_bcon (struct find_sm *f, struct rx_pkt *pkt);                                      /* link_sm.c */
struct conn *find_main_sm_bcon_args (struct mid *mid, const void *mac, const void *snap, u32 a3, u32 a4); /* lmac_evt.c */
u32 find_main_sm_bcon_lookup (struct mid *mid, const void *key, const void *e, u32 a3, struct conn **out, u32 a5, u32 a6, u32 a7); /* scan_mngr.c */
struct dband_info *find_main_sm_bcon_step (const struct llist *list, const u8 *key);                 /* scan_mngr.c */
u32 find_main_sm_first_detection (struct find_sm *obj, const void *ptr, u32 field);                  /* rx.c */
void find_main_sm_stop (struct find_sm *f);                                                          /* link_sm.c */
u32 find_mngr_detect_discovery_bcon (struct find_mngr *obj, struct rx_pkt *bcn);                     /* rx.c */
void find_sm_on_bcon_searching (struct find_sm *f, struct rx_pkt *pkt, u32 type);                    /* link_sm.c */
void find_sm_on_beamforming (struct find_sm *f, struct conn *c, u32 status);                         /* link_sm.c */
void find_sm_on_link_up (struct find_mngr *f, struct conn *conn, u32 v);                             /* conn.c */
void find_sm_on_probe_req_listening (struct find_sm *f, struct rx_pkt *pkt);                         /* link_sm.c */
void find_sm_on_probe_req_searching (struct find_sm *f, struct rx_pkt *pkt);                         /* link_sm.c */
void find_sm_on_radio_ready_listen (struct find_sm *f);                                              /* link_sm.c */
void find_sm_on_start (struct find_sm *f);                                                           /* link_sm.c */
void find_sm_on_start_listen_searching (struct find_sm *f);                                          /* link_sm.c */
void find_sm_on_start_search (struct find_sm *f);                                                    /* link_sm.c */
void find_sm_on_stop_searching (struct find_sm *f);                                                  /* link_sm.c */
void find_sm_radio_allocated_cb (struct rm_req *req, u32 arg);                                       /* link_sm.c */
void find_sm_radio_tuned_cb (struct rm_req *req, u32 f);                                             /* link_sm.c */
void find_sm_start_listen (struct conn *conn, u32 cid);                                              /* discovery.c */
void find_sm_start_search (struct scan_mngr *scan, u8 *cmd, u32 a2, u32 a3);                         /* scan.c */
u32 fixed_sched_get_entry_count (void);                                                              /* tx_queue.c */
void flash_cfg_set_bb_sensor_calib (u16 a, u16 b);                                                   /* flash.c */
void flash_cfg_set_lo_power_gc_ctrl (s8 v);                                                          /* flash.c */
void flash_cfg_set_lo_power_stg2_bias (u8 v);                                                        /* flash.c */
void flash_cfg_set_lo_power_xif_gc (u32 v);                                                          /* flash.c */
u32 frame_build_addba_req (struct ieee80211_addba *d, u32 token, u32 win, u32 tid, u32 timeout, u32 ssn, u32 amsdu); /* ba.c */
u32 frame_build_addba_resp (struct ieee80211_addba_resp *d, u32 token, u32 win, u32 tid, u32 timeout, u32 status, u32 amsdu); /* ba.c */
u32 frame_build_delba (struct ieee80211_delba *d, u32 initiator, u32 tid, u32 reason);               /* ba.c */
void free_dband_info (struct dband_info *entry);                                                     /* discovery.c */
void fw2uc_signal_halt_and_wait_ack (void);                                                          /* power.c */
void fw2uc_signal_wake_and_wait_ack (void);                                                          /* power.c */
s64 fw_ashr64 (s64 v, u32 n);                                                                        /* stubs.c */
void fw_boot_log_versions (void);                                                                    /* stubs.c */
s32 fw_divmod_signed (s32 a, s32 b);                                                                 /* pool.c */
u32 fw_divmod_unsigned (u32 a, u32 b);                                                               /* pool.c */
void fw_image_info_set_flavor (u32 v);                                                               /* log.c */
void fw_init_link_defaults (void);                                                                   /* stubs.c */
void fw_log_emit0 (u32 hdr, u32 token);                                                              /* log.c */
void fw_log_emit1 (u32 hdr, u32 token, u32 a0);                                                      /* log.c */
void fw_log_emit2 (u32 hdr, u32 token, u32 a0, u32 a1);                                              /* log.c */
void fw_log_emit3 (u32 hdr, u32 token, u32 a0, u32 a1, u32 a2);                                      /* log.c */
void fw_log_emit_str1 (u32 hdr, u32 token, u32 s0);                                                  /* log.c */
void fw_log_emit_str2 (u32 hdr, u32 token, u32 s0, u32 s1);                                          /* log.c */
void fw_log_emit_str3 (u32 hdr, u32 token, u32 s0, u32 s1, u32 s2);                                  /* misc_ext.c */
void fw_log_init_ring (void);                                                                        /* log.c */
u32 fw_mailbox_is_empty (const struct mbox_ring *r);                                                 /* tx_helpers.c */
void fw_main (void);                                                                                 /* main.c */
void fw_stats_blk_init (void);                                                                       /* stubs.c */
void fw_status_set_assert_marker (u32 v);                                                            /* platform.c */
void fw_status_set_state (u32 v);                                                                    /* platform.c */
void fw_sysapi_mgr_channel_estimation_cmd_complete (struct fw_sysapi_mgr *mgr, u32 status);          /* phy_ext.c */
void fw_sysapi_mgr_complete_pending_request (struct fw_sysapi_mgr *mgr, u32 a, const void *b);       /* lmac_evt.c */
void fw_sysapi_mgr_get_flush_statistics_cmd_start (struct fw_sysapi_mgr *mgr, const u32 *ctx);       /* sysapi_stats.c */
void fw_sysapi_mgr_get_rssi_and_snr_statistics (struct fw_sysapi_mgr *mgr, u32 n, u32 locked, const u32 *rssi, const u32 *idx, struct sysapi_energy_stats *out); /* sysapi_stats.c */
void fw_sysapi_mgr_mac_ampdu_statistics_cmd_start (struct fw_sysapi_mgr *o, const u8 *filter, u32 timeout, const u32 *req); /* mac_ext.c */
void fw_sysapi_mgr_phy_rx_statistics_cmd_start (struct fw_sysapi_mgr *mgr, const u8 *p, u32 timeout, const u32 *ctx); /* phy_ext.c */
void fw_sysapi_mgr_send_evt2host (struct fw_sysapi_mgr *mgr, u32 status, const void *data, u32 len, const u32 *ctx); /* sysapi_stats.c */
void fw_sysapi_mgr_start_energy_statistics (struct fw_sysapi_mgr *mgr, const u8 *p, u32 count, u32 timeout, const u32 *ctx); /* phy_ext.c */
void fw_sysapi_mgr_start_plcp_header (struct fw_sysapi_mgr *mgr, const u8 *prm, u32 timeout, const u32 *ctx); /* sysapi_stats.c */
u32 fw_sysapi_mgr_start_sysapi_cmd (struct fw_sysapi_mgr *mgr, u32 id, const u32 *ctx);              /* sysapi_stats.c */
u32 fw_sysapi_mgr_stop_sysapi_cmd (struct fw_sysapi_mgr *mgr, u32 id);                               /* sysapi_stats.c */
void fw_sysapi_send_measure_evt (struct fw_sysapi_mgr *mgr, volatile const struct phy_rx_stats *st); /* sysapi_stats.c */
void fw_sysapi_start_ampdu_stats (u32 a0, u32 a1, u32 a2, u32 a3, u32 a4, u32 timeout, u32 ctx0, u32 ctx1); /* sysapi_stats.c */
void fw_sysapi_start_phy_rx_stats (u32 a0, u32 a1, u32 a2, u32 a3, u32 a4, u32 timeout, u32 ctx0, u32 ctx1); /* phy_ext.c */
void fw_sysapi_start_rx_pkt_phy_data (u32 a0, u32 a1, u32 a2, u32 a3, u32 a4, u32 timeout, u32 ctx0, u32 ctx1); /* phy_ext.c */
void fw_sysassert_fatal (void *caller, u32 code);                                                    /* sysassert.c */
void fw_version_log (u32 a0, u32 a1, u32 a2, u32 a3);                                                /* log.c */
void fw_version_log_date (u8 a0, u8 a1, u8 a2, u8 a3, u8 a4, u8 a5);                                 /* log.c */
u32 fwq_tx_add_packet (struct fwq_tx *q, struct tx_pkt *pkt, u32 ch);                                /* fwq_tx.c */
u32 fwq_tx_count_below_limit (void);                                                                 /* rx.c */
void fwq_tx_enable_queue (struct fwq_tx *q, u32 ch);                                                 /* fwq_tx.c */
struct tx_pkt *fwq_tx_find_packet (struct fwq_tx *q, struct llist *list, u32 cid);                   /* fwq_tx.c */
u32 fwq_tx_flush_by_prio (struct fwq_tx *q, u32 cid, struct llist *dst);                             /* fwq_tx.c */
u32 fwq_tx_flush_list_packets_by_cid (struct fwq_tx *q, u32 cid, struct llist *dst, struct llist *src); /* fwq_tx.c */
void fwq_tx_flush_timer_cb (u32 a0, u32 a1);                                                         /* link_sm.c */
u32 fwq_tx_get_count (void);                                                                         /* rx.c */
void fwq_tx_handle_completion (struct rx_dma_ring *r, struct llist *list);                           /* rx.c */
void fwq_tx_handle_completion_thunk (struct rx_ring *obj, struct llist *list);                       /* rx.c */
void fwq_tx_init (struct fwq_tx *q, u32 mode, struct fwq_tx_stats *stats);                           /* fwq_tx.c */
u32 fwq_tx_long_retry_failures (struct fwq_tx *q, struct llist *list);                               /* fwq_tx.c */
void fwq_tx_on_flush_done (struct fwq_tx *q, u32 cid, struct llist *list);                           /* fwq_tx.c */
u32 fwq_tx_queue_step (struct fwq_tx *q);                                                            /* fwq_tx.c */
void fwq_tx_retry_task (u32 a0, u32 a1);                                                             /* fwq_tx.c */
void fwq_tx_vt_enable_ring (struct fwq_tx *q);                                                       /* fwq_tx.c */
void fwq_tx_vt_handle_completion (struct fwq_tx *q, struct llist *list);                             /* fwq_tx.c */
u32 fwq_tx_vt_send_next (struct fwq_tx *q);                                                          /* fwq_tx.c */
u32 get_min_failures_mid_biggest_range_index (u32 *arr);                                             /* rf.c */
void get_rf_sector_params_handle (struct wmi_rf_sector_get_req *self);                               /* wmi_h_bf.c */
u32 get_rf_sector_params_set (struct wmi_rf_sector_get_req *self, const struct wmi_get_rf_sector_params_cmd *cmd, struct wmi_mbox *mb); /* wmi_h_bf.c */
void get_rx_pkt_phy_data_cmd_complete (struct fw_sysapi_mgr *mgr, const u32 *body);                  /* phy_ext.c */
void get_rx_pkt_phy_data_cmd_start (struct fw_sysapi_mgr *mgr, const u8 *p, u32 timeout, u32 ctx0, u32 ctx1); /* phy_ext.c */
u32 get_selected_rf_sector_index_set (struct rf_sector_sel_req *self, const struct wmi_get_selected_rf_sector_index_cmd *cmd, struct wmi_mbox *mb); /* wmi_h_bf.c */
void gpio_pulse_880b60_18 (void);                                                                    /* hw_init.c */
void gpio_pulse_880b60_19 (void);                                                                    /* hw_init.c */
void gpio_reset_config (void);                                                                       /* hw_init.c */
void gpio_set_pin_func_and_dump (u32 func, u32 pin);                                                 /* hw_init.c */
void gpio_write_ctrl_b84 (u32 v);                                                                    /* hw_init.c */
void handle_omni_sector_info (struct rf_obj *this, const struct brd_win *bnd);                       /* rf.c */
void hexdump_words (const void *ptr, u32 len);                                                       /* scan_mngr.c */
void host_if_bf_ctrl_hal (struct wmi_mbox *mb, const void *cmd, u32 mid);                            /* wmi_h_bf.c */
void host_if_connect_rf_kill (const struct wmi_connect_cmd *cmd, u32 mid);                           /* wmi_cmd.c */
void host_if_get_status_hal (struct wmi_mbox *mb, const void *cmd, u32 mid);                         /* wmi_h_sta.c */
void host_if_read_rf_xpm (struct wmi_mbox *mb, const struct wmi_rf_xpm_read_cmd *cmd);               /* wmi_h_misc.c */
void *host_if_send_pair (void);                                                                      /* tx_helpers.c */
void host_if_send_scan_complete (u32 mid);                                                           /* wmi_cmd.c */
void host_if_set_sectors_hal (struct wmi_mbox *mb, const struct wmi_set_sectors_cmd *cmd);           /* wmi_h_bf.c */
void host_if_write_rf_xpm (struct wmi_mbox *mb, const struct wmi_rf_xpm_write_cmd *cmd);             /* wmi_h_misc.c */
void host_irq_mask_awake_tsf (void);                                                                 /* isr.c */
void host_irq_raise_fw_error (void);                                                                 /* host_irq.c */
void host_irq_raise_fw_ready (void);                                                                 /* host_irq.c */
void hw_cfg_set_8004fc_and_levels (u32 a, u32 b, u32 c);                                             /* misc_ext.c */
void hw_ch_enable_once (u32 ch, u32 on, u32 period);                                                 /* stubs.c */
void hw_modes_apply_power_mode (u32 mode, u32 *flags);                                               /* power_halt.c */
void hw_modes_enable_pll (void);                                                                     /* power_halt.c */
void hw_modes_pll_bypass (void);                                                                     /* power_halt.c */
void hw_modes_pll_engage (void);                                                                     /* power_halt.c */
void hw_modes_program_rf_clocks (u32 on);                                                            /* power_halt.c */
void hw_modes_set_loopback (u32 on, u32 b);                                                          /* calib_hw.c */
void hw_personality_detect (void);                                                                   /* hw_init.c */
u32 hw_personality_read_strap (u32 i);                                                               /* hw_init.c */
void hw_pll_mode_switch (u32 on, u32 arg);                                                           /* power_halt.c */
u32 hw_poll_bit (u32 addr, u32 mask, u32 want);                                                      /* hw_init.c */
void hw_poll_fail (u32 addr, u32 mask);                                                              /* hw_init.c */
void hw_sysapi_channel_estimation (u32 a0, u32 a1, u32 a2, u32 a3, u32 a4, u32 timeout, u32 ctx0, u32 ctx1); /* phy_ext.c */
u32 hw_sysapi_force_mcs (u32 a, u32 b, u32 c);                                                       /* sysapi_stats.c */
void hw_sysapi_get_beamforming_statistics (struct wmi_mbox *mb, const struct ut_cmd *cmd);           /* sysapi_stats.c */
u32 hw_sysapi_get_rx_energy_data_free_run (u32 *out);                                                /* phy_ext.c */
void hw_sysapi_get_rx_packet_energy_statistics (u32 a0, u32 a1, u32 a2, u32 a3, u32 a4, u32 count, u32 timeout, const u32 *ctx); /* phy_ext.c */
void hw_sysapi_plcp_header (u32 a0, u32 a1, u32 a2, u32 a3, u32 a4, u32 timeout, const u32 *ctx);    /* sysapi_stats.c */
u32 hw_sysapi_rfc_fetch_rgf_util (struct rfc_rgf_req *o);                                            /* rf_sector.c */
u32 hw_sysapi_rfc_read_write_rgf (struct rfc_rgf_req *obj);                                          /* rf_sector.c */
void hw_sysapi_rx_alloc_and_store (u32 a, u32 b);                                                    /* lmac.c */
u32 hw_sysapi_rx_omni_sector_set (u32 s);                                                            /* scan.c */
void hw_sysapi_set_freq_ratio (u32 i, u32 v1, u32 v2);                                               /* sysapi_stats.c */
void hwd_abif_adc_clk_ctrl (u32 on);                                                                 /* car.c */
void hwd_abif_adc_sar_vreg_ctrl (u32 on);                                                            /* abif_ext.c */
void hwd_abif_battery_config (u32 a, u32 b);                                                         /* calib_hw.c */
void hwd_abif_bgap_ctrl (u32 on);                                                                    /* power_halt.c */
void hwd_abif_caf_lpbk_mode (u32 v);                                                                 /* car.c */
void hwd_abif_caf_phy_control_mode (u32 on);                                                         /* abif_ext.c */
void hwd_abif_caf_pwdn_mode (u32 v);                                                                 /* car.c */
void hwd_abif_config_vga_rows (u32 idx, const u8 *gain);                                             /* calib_hw.c */
void hwd_abif_dvs_if_splitter_enable (u32 v);                                                        /* car.c */
void hwd_abif_dvs_lo_splitter_config_buf_val (u32 a, u32 b);                                         /* car.c */
void hwd_abif_dvs_lo_splitter_enable (u32 v);                                                        /* car.c */
void hwd_abif_dvs_rf_activate (u32 v);                                                               /* car.c */
void hwd_abif_dvs_rfca_activate (u32 en, u32 mask);                                                  /* abif_ext.c */
void hwd_abif_dvs_rfca_cmd_enable (u32 a, u8 *b);                                                    /* car.c */
void hwd_abif_dvs_rfca_config_en (u32 mask);                                                         /* abif_ext.c */
void hwd_abif_fs_off (u32 a);                                                                        /* car.c */
void hwd_abif_fs_on (u32 v);                                                                         /* car.c */
u32 hwd_abif_get_88af00 (void);                                                                      /* calib_hw.c */
void hwd_abif_lpbk_mode_switches_config (u32 a, u32 b, u32 c);                                       /* car.c */
void hwd_abif_out_to_bump_ctl (u32 en, u32 sel);                                                     /* abif_ext.c */
void hwd_abif_rfc_clk_ctrl (u32 on);                                                                 /* car.c */
void hwd_abif_rfc_divider_restart (u32 a);                                                           /* car.c */
void hwd_abif_rgf_880b00 (u32 on);                                                                   /* power_halt.c */
void hwd_abif_rgf_889380 (u32 on);                                                                   /* car.c */
void hwd_abif_rosc_ctrl (u32 on);                                                                    /* wmi.c */
void hwd_abif_rx_prepare_ifrx_pwdn (u32 a);                                                          /* calib_hw.c */
void hwd_abif_rx_prepare_rvga_pwdn (u32 v);                                                          /* abif_ext.c */
u32 hwd_abif_rx_prepared_ifrx_pwdn_get (void);                                                       /* calib_hw.c */
u32 hwd_abif_rx_prepared_rvga_pwdn_get (void);                                                       /* abif_ext.c */
void hwd_abif_rx_rgf_config_sar_dc (u32 idx, u32 b, u32 c, u32 v);                                   /* abif_ext.c */
void hwd_abif_rx_rgf_config_sar_gain (u32 unused, u32 idx, u32 c, u32 v);                            /* abif_ext.c */
u32 hwd_abif_rx_rgf_read_sar_dc (u32 a, u32 b, u32 c);                                               /* calib_hw.c */
void hwd_abif_rx_rgf_sar_dc_load (void);                                                             /* calib_hw.c */
void hwd_abif_rx_rgf_update_sar_dc (u32 a, u32 b, u32 c);                                            /* calib_hw.c */
void hwd_abif_rx_table_config_ifrx_ctrl (u32 idx, u32 field, u32 val);                               /* calib_hw.c */
void hwd_abif_rx_table_config_ifrx_gain (u32 row, u32 v);                                            /* abif_ext.c */
void hwd_abif_rx_table_config_sar_dc (u32 row, u32 idx, u32 b, u32 c, u32 v);                        /* abif_ext.c */
void hwd_abif_rx_table_config_vga_atten (u32 idx, u32 col, u32 sel, u32 val);                        /* calib_hw.c */
void hwd_abif_rx_table_config_vga_bias (u32 row, u32 a, u32 v);                                      /* car.c */
void hwd_abif_rx_table_config_vga_bias_all_rows (u32 a0, u32 a1, u32 a2, u32 a3);                    /* car.c */
void hwd_abif_rx_table_config_vga_dc (u32 idx, u32 col, u32 sel, u32 val);                           /* calib_hw.c */
void hwd_abif_rx_table_config_vga_dc_dac_pwdn (u32 row, u32 v);                                      /* abif_ext.c */
void hwd_abif_rx_table_config_vga_gain (u32 idx, u32 col, u32 sel, u32 val);                         /* calib_hw.c */
void hwd_abif_rx_table_config_vga_stg1_fine_bias (u32 row, u32 a, u32 v);                            /* car.c */
void hwd_abif_rx_table_config_vga_stg1_fine_bias_all_rows (u32 a0, u32 a1, u32 a2);                  /* car.c */
void hwd_abif_rx_table_force_reload (void);                                                          /* abif_ext.c */
u32 hwd_abif_rx_table_index_force_en_get (void);                                                     /* calib_hw.c */
void hwd_abif_rx_table_index_force_mode (u32 mode, u32 idx);                                         /* chan_sw.c */
u32 hwd_abif_rx_table_read_vga_atten (u32 row, u32 stage, u32 b);                                    /* abif_ext.c */
u32 hwd_abif_rx_table_read_vga_bias (u32 row, u32 stage);                                            /* abif_ext.c */
u32 hwd_abif_rx_table_read_vga_dc (u32 idx, u32 col, u32 sel);                                       /* calib_hw.c */
u32 hwd_abif_rx_table_read_vga_gain (u32 idx, u32 col, u32 sel);                                     /* calib_hw.c */
u32 hwd_abif_rx_table_read_vga_stg1_fine_bias (u32 row, u32 b);                                      /* abif_ext.c */
void hwd_abif_rx_table_write_row (u32 row, const u32 *in);                                           /* abif_ext.c */
void hwd_abif_sar_cal_dc_rgf_clear_all (void);                                                       /* calib_hw.c */
void hwd_abif_sar_dc_config_rgf_mode (u32 v);                                                        /* calib_hw.c */
u32 hwd_abif_sar_dc_config_rgf_mode_get (void);                                                      /* calib_hw.c */
u32 hwd_abif_sensor_get_comp_out (void);                                                             /* temp_service.c */
void hwd_abif_sensor_measure_start (u32 on);                                                         /* temp_service.c */
void hwd_abif_sensor_set_bgp_params (u32 a, u32 b, u32 c);                                           /* abif_ext.c */
void hwd_abif_sensor_set_comp_value (u32 v);                                                         /* temp_service.c */
void hwd_abif_sensor_set_thermal_mode (u32 on);                                                      /* temp_service.c */
void hwd_abif_set_agc_column (u32 idx, u32 sel, const u8 *val);                                      /* calib_hw.c */
void hwd_abif_tx_table_config_dac_fssel (u32 idx, u32 v);                                            /* calib_hw.c */
void hwd_abif_tx_table_config_iftx_ctrl (u32 idx, u32 field, u32 val);                               /* calib_hw.c */
void hwd_abif_tx_table_config_iftx_gain (u32 row, u32 v);                                            /* abif_ext.c */
void hwd_abif_tx_table_config_lo_leak_ctrl (u32 idx, u32 field, u32 val);                            /* calib_hw.c */
void hwd_abif_tx_table_config_lo_leak_gain (u32 idx, u32 field, u32 val);                            /* calib_hw.c */
void hwd_abif_tx_table_config_tx_mixer_gate_ctrl (u32 row, u32 v);                                   /* abif_ext.c */
void hwd_abif_tx_table_config_xif_ctrl (u32 row, u32 v);                                             /* abif_ext.c */
void hwd_abif_tx_table_config_xif_gain (u32 idx, u32 v);                                             /* calib_hw.c */
void hwd_abif_tx_table_force_reload (void);                                                          /* abif_ext.c */
u32 hwd_abif_tx_table_index_force_en_get (void);                                                     /* calib_hw.c */
void hwd_abif_tx_table_index_force_mode (u32 mode, u32 idx);                                         /* calib_hw.c */
u32 hwd_abif_tx_table_index_force_val_get (void);                                                    /* calib_hw.c */
void hwd_abif_tx_table_read_dac_fssel (u32 row, u32 *out);                                           /* abif_ext.c */
void hwd_abif_txrx_table_index_lpbk_mode (u32 a0, u32 a1);                                           /* calib_hw.c */
void hwd_abif_uses_rgf_889380 (u32 a0, u32 a1);                                                      /* car.c */
void hwd_abif_uses_rgf_889480 (u32 flag);                                                            /* car.c */
void hwd_abif_uses_rgf_889480_8ced4c (u32 on);                                                       /* abif_ext.c */
void hwd_abif_uses_rgf_88a208_8cf5fc (u32 row, u32 *out);                                            /* abif_ext.c */
void hwd_abif_uses_rgf_88af80 (s32 v);                                                               /* flash.c */
u32 hwd_abif_uses_rgf_88af80_8ce614 (void);                                                          /* calib_hw.c */
void hwd_abif_xtal_ctrl (u32 on);                                                                    /* wmi.c */
void hwd_apply_table_entry (struct fw_sysapi_mgr *ctx, u32 *out, const u64 *pa, const u64 *pb, const u64 *pc, const u64 *pd); /* misc_ext_sysapi.c */
void hwd_apply_table_entry_b (struct fw_sysapi_mgr *ctx, u32 *out, u32 a2, u32 a3, u32 a4, u32 a5, u32 a6, u32 a7); /* misc_ext_sysapi.c */
void hwd_apply_table_entry_c (struct fw_sysapi_mgr *ctx, u32 *out, u64 a, u64 b);                    /* misc_ext_sysapi.c */
void hwd_args_to_regs (u32 a, u32 b, u32 c, u32 d);                                                  /* stubs.c */
void hwd_args_to_regs_default (u32 a);                                                               /* calib_hw.c */
void hwd_dma_ack_881c44 (u32 a, u32 b);                                                              /* dma.c */
void hwd_dma_ack_rx_ring (u32 value, u32 sync_flag);                                                 /* rx.c */
void hwd_dma_bad_cause (void);                                                                       /* dma.c */
u32 hwd_dma_get_881bf0_bit27 (void);                                                                 /* power_halt.c */
u32 hwd_dma_get_881c80 (u32 idx);                                                                    /* dma.c */
u32 hwd_dma_get_rings_with_data (void);                                                              /* vring.c */
void hwd_dma_init (void);                                                                            /* dma.c */
u32 hwd_dma_macq_reg_addr (u32 idx);                                                                 /* stream_mgr.c */
void hwd_dma_op (u32 a, u32 b);                                                                      /* dma.c */
void hwd_dma_program_vring_desc (u32 vr, u32 lo, u32 hi, u32 size);                                  /* vring.c */
void hwd_dma_raise_host_fw_int (u32 a);                                                              /* host_irq.c */
u32 hwd_dma_read_8812d4 (void);                                                                      /* link_diag.c */
u32 hwd_dma_read_8813c8 (void);                                                                      /* vring.c */
u32 hwd_dma_read_8813f0 (void);                                                                      /* vring.c */
u32 hwd_dma_read_rx_tx_status (void);                                                                /* rx.c */
u32 hwd_dma_read_status (void);                                                                      /* dma.c */
void hwd_dma_reset_ring (u32 idx);                                                                   /* dma_ring.c */
void hwd_dma_reset_vring (u32 vr);                                                                   /* vring.c */
void hwd_dma_set_881c00 (u32 a);                                                                     /* dma.c */
void hwd_dma_set_power_mode_map (u32 mode);                                                          /* power_halt.c */
void hwd_dma_set_ring_base (u32 idx, u32 a1, u32 a2, u32 a3, u32 a4, u32 a5);                        /* dma_ring.c */
void hwd_dma_set_ring_field_99e0 (u32 idx, u32 value);                                               /* dma_ring.c */
void hwd_dma_set_ring_field_9a10 (u32 idx, u32 value);                                               /* dma_ring.c */
void hwd_dma_uses_rgf_881000 (u32 a0, u32 a1, u32 a2);                                               /* dma_ring.c */
void hwd_dma_uses_rgf_881c00_8d0b14 (u32 v, u32 flag);                                               /* dma.c */
void hwd_dma_write_881c38 (u32 v, u32 flag);                                                         /* dma.c */
void hwd_dma_write_ring_reg (u32 ring, u32 v);                                                       /* fwq_tx.c */
void hwd_mac_enable_multicast (void);                                                                /* mac_bringup.c */
void hwd_mac_parser_set_rx_filter (u32 obj, u32 flag);                                               /* mac_parser.c */
void hwd_mac_set_power_mode_map (u32 mode);                                                          /* power_halt.c */
void hwd_mac_sxd_mode_neutral (void);                                                                /* mac.c */
void hwd_mac_sxd_rx_mode_entry (void);                                                               /* mac.c */
void hwd_mac_sxd_tx_phy_frame_start (void);                                                          /* phy_ext.c */
void hwd_mac_trigger_sxd_tx_mode (u32 a);                                                            /* calib_hw.c */
void hwd_mac_uses_rgf_886200 (u32 v);                                                                /* calib_hw.c */
void hwd_pcie_clear_88b000_bits (void);                                                              /* pcie.c */
void hwd_pcie_config_lnkctl (u32 *out);                                                              /* pcie.c */
void hwd_pcie_exit_l1 (u32 on);                                                                      /* host_irq.c */
u32 hwd_pcie_get_882b80 (void);                                                                      /* pcie.c */
u32 hwd_pcie_get_88b0c0_state4 (void);                                                               /* pcie.c */
u32 hwd_pcie_get_ltssm_state (void);                                                                 /* pcie.c */
u32 hwd_pcie_is_ep_under_serdes (void);                                                              /* pcie.c */
u32 hwd_pcie_is_l1_state (void);                                                                     /* pcie.c */
void hwd_pcie_l1_pm_sub_ctl_get (u32 *out);                                                          /* pcie.c */
void hwd_pcie_l1_pm_sub_ctl_set (u32 *v);                                                            /* pcie.c */
void hwd_pcie_l1_sub_timing_config (void);                                                           /* pcie.c */
void hwd_pcie_lnkctl_set (u32 *v);                                                                   /* pcie.c */
u32 hwd_pcie_ltssm_is_l1_idle (void);                                                                /* pcie.c */
void hwd_pcie_port1_serdes_reset (u32 flag);                                                         /* pcie.c */
void hwd_pcie_set_clk_gating (u32 on);                                                               /* power_halt.c */
void hwd_pcie_set_low_power (u32 v);                                                                 /* pcie.c */
void hwd_pcie_set_mode_map (u32 mode);                                                               /* power_halt.c */
void hwd_pcie_uses_rgf_880c00 (void);                                                                /* pcie.c */
void hwd_phy_dbg_clk_enable (u32 on);                                                                /* calib_hw.c */
u32 hwd_phy_dbg_clk_enable_get (void);                                                               /* calib_hw.c */
void hwd_phy_enable_880a80 (u32 on);                                                                 /* power_halt.c */
void hwd_phy_enable_880b00 (u32 on);                                                                 /* power_halt.c */
u32 hwd_phy_get_883180 (void);                                                                       /* calib_hw.c */
int hwd_phy_get_883b80 (void);                                                                       /* phy.c */
void hwd_phy_get_884100 (u8 *out);                                                                   /* calib_hw.c */
u32 hwd_phy_get_rx_swap_iq (void);                                                                   /* calib_hw.c */
u32 hwd_phy_get_tx_swap_iq (void);                                                                   /* calib_hw.c */
void hwd_phy_init (void);                                                                            /* phy.c */
void hwd_phy_online_dc_measurement_read (u32 idx, s16 *out);                                         /* phy_ext.c */
void hwd_phy_online_gain_measurement_read (u32 idx, u16 *out);                                       /* phy_ext.c */
void hwd_phy_online_measurement_completed (void);                                                    /* phy_ext.c */
void hwd_phy_online_measurement_config (u32 a0, u32 a1, u32 a2, u32 a3, u32 a4, u32 a5);             /* phy_ext.c */
void hwd_phy_online_measurement_start (void);                                                        /* phy_ext.c */
void hwd_phy_online_measurement_stop (void);                                                         /* phy_ext.c */
u32 hwd_phy_online_sar_measurement_valid (void);                                                     /* phy_ext.c */
void hwd_phy_power_up_seq (u32 on);                                                                  /* power_halt.c */
void hwd_phy_pwr_fw (u32 value);                                                                     /* power_halt.c */
void hwd_phy_read_sar_sample (u32 idx, u32 *out);                                                    /* calib_hw.c */
void hwd_phy_recording_get (u32 off, u32 n, u32 *out);                                               /* phy_ext.c */
void hwd_phy_recording_mode_set (u32 mode, u32 save_rx, u32 trig, u32 src, u32 len);                 /* phy_ext.c */
void hwd_phy_rx_agc_index_force_mode (u32 en, u32 idx);                                              /* calib_hw.c */
void hwd_phy_rx_agc_steps_disable (u32 on);                                                          /* chan_sw.c */
u32 hwd_phy_rx_apu_calc (u32 a0, u32 a1, u32 a2, u32 a3, u32 a4, u32 a5, struct phy_apu_res *out);   /* phy_ext.c */
void hwd_phy_rx_cal_corr (s32 *out);                                                                 /* calib_hw.c */
void hwd_phy_rx_cal_corr_config (u32 period, u32 en, s32 freq);                                      /* calib_hw.c */
void hwd_phy_rx_cal_gain_measurement_read (u32 idx, u32 *out);                                       /* phy_ext.c */
void hwd_phy_rx_enable (u32 val);                                                                    /* mac_bringup.c */
void hwd_phy_rx_ina_det_mode (u32 v);                                                                /* calib_hw.c */
u32 hwd_phy_rx_is_enabled (void);                                                                    /* phy_ext.c */
void hwd_phy_rx_postdist_dc_enable (u32 en);                                                         /* phy_ext.c */
void hwd_phy_rx_postdist_dc_per_sar_mode (u32 v);                                                    /* phy_ext.c */
void hwd_phy_rx_postdist_force_dc_config (s32 i, s32 q);                                             /* phy_ext.c */
void hwd_phy_rx_postdist_force_dc_set (u32 v);                                                       /* phy_ext.c */
void hwd_phy_rx_postdist_sar_dc_config (s32 sar, s32 iq, u32 v);                                     /* phy_ext.c */
void hwd_phy_rx_read_and_parse_brp_ram (u32 unused, u32 row, u8 *out, u32 len);                      /* phy_ext.c */
void hwd_phy_rx_sar_cal_measurement_config (u32 en, u32 a1, u32 a2, u32 a3, u32 a4, u32 a5);         /* calib_hw.c */
void hwd_phy_rx_sar_measurement_completed (void);                                                    /* calib_hw.c */
void hwd_phy_rx_sar_measurement_start (void);                                                        /* calib_hw.c */
void hwd_phy_rx_sar_rssi_measure (u32 n, s32 *out);                                                  /* phy_ext.c */
void hwd_phy_rx_set_agc_start_val_and_gain_array (u32 start, u32 arr);                               /* calib_hw.c */
void hwd_phy_rx_statistics_clear (void);                                                             /* calib_hw.c */
void hwd_phy_rx_statistics_lock (void);                                                              /* calib_hw.c */
void hwd_phy_self_digital_loopback (u32 v);                                                          /* phy_ext.c */
void hwd_phy_self_mode_exit (void);                                                                  /* calib_hw.c */
void hwd_phy_self_rx_mode_entry (void);                                                              /* calib_hw.c */
void hwd_phy_self_tx_mode_entry (void);                                                              /* calib_hw.c */
void hwd_phy_set_rx_swap_iq (u32 mode);                                                              /* calib_hw.c */
void hwd_phy_set_tx_swap_iq (u32 mode);                                                              /* calib_hw.c */
void hwd_phy_store_txrx_swap_iq (void);                                                              /* phy.c */
void hwd_phy_tx_ctrl_884070 (u32 v);                                                                 /* calib_hw.c */
void hwd_phy_tx_enable (u32 val);                                                                    /* mac_bringup.c */
void hwd_phy_tx_play_buffer_start (u32 en, u32 len, u32 val);                                        /* phy_ext.c */
void hwd_phy_tx_play_buffer_stop (void);                                                             /* phy_ext.c */
void hwd_phy_tx_predist_atten_man_config (u32 en, u32 a1, u32 a2);                                   /* calib_hw.c */
void hwd_phy_tx_predist_dc_config (u32 en, u32 i, u32 q);                                            /* phy_ext.c */
void hwd_phy_tx_predist_iq_config (u32 en, u32 a, u32 b);                                            /* phy_ext.c */
void hwd_phy_tx_self_transmit (u32 n, u32 a1, u32 a2, u32 a3);                                       /* calib_hw.c */
void hwd_phy_tx_self_transmit_wait_completion (void);                                                /* calib_hw.c */
void hwd_phy_tx_singen_config (s32 f0, s32 f1, u32 amp);                                             /* calib_hw.c */
void hwd_phy_tx_singen_transmit (u32 v);                                                             /* calib_hw.c */
void hwd_phy_uses_rgf_880c00_8d1d04 (u32 on);                                                        /* power_halt.c */
void hwd_phy_uses_rgf_880c00_8d1d34 (u32 mode);                                                      /* power_halt.c */
u32 hwd_phy_uses_rgf_883100 (u32 base, u32 d1, u32 d2, u32 d3, u32 d4);                              /* calib_hw.c */
void hwd_program_889_group (u32 v);                                                                  /* rf.c */
void hwd_program_rf_regs_seq (u32 rf, u32 idx, u32 sel, u32 v0, u32 v1, u32 v2, u32 v3, u32 v4, u32 v5, u8 v6); /* calib_hw.c */
void hwd_rfc_powerdown_deep_all_rfs_fw (void);                                                       /* chan_sw.c */
void hwd_rfc_powerup_deep_all_rfs_fw (void);                                                         /* wmi.c */
void hwd_rfc_read_calibrate (u32 count);                                                             /* rf.c */
u8 hwd_rfc_read_get_result (void);                                                                   /* rf.c */
u32 hwd_rfc_read_handle_driver_input (void);                                                         /* rf.c */
u32 hwd_rfc_read_rgf (u32 a, u32 b);                                                                 /* rf.c */
u8 hwd_rfc_read_sector_chain (u32 rf, u32 sector, u32 tx, u32 chain);                                /* rf_sector.c */
u32 hwd_rfc_read_sector_reg (u32 rf, u32 sector, u32 tx, u32 idx);                                   /* rf_sector.c */
void hwd_rfc_sector_dist_gain_set (u32 rf, u32 sector, u32 tx, u32 idx, u32 val, s32 commit);        /* rf_sector.c */
void hwd_rfc_sector_edge_gain_set (u32 rf, u32 sector, u32 tx, u32 chain, u32 val, s32 commit);      /* rf_sector.c */
void hwd_rfc_sector_edge_phase_set (u32 rf, u32 sector, u32 tx, s32 chain, u32 val, s32 commit);     /* rf_sector.c */
void hwd_rfc_sector_x16_state_set (u32 rf, u32 sector, u32 tx, u32 idx, u32 val, s32 commit);        /* rf_sector.c */
void hwd_rfc_tx_power_cfg (u32 a);                                                                   /* rf.c */
void hwd_rfc_uses_rgf_889100 (void);                                                                 /* rf.c */
void hwd_rfc_write_core_fw (u32 a, u32 b, u32 c, u32 d);                                             /* rf.c */
void hwd_rfc_write_core_fw_mode1 (u32 a);                                                            /* rf.c */
u32 hwd_rfc_write_verify (u32 a, u32 b, u32 c, u32 d);                                               /* rf.c */
u32 hwd_rfc_xpm_get_data_output (u32 rf, u8 *dst, u32 wait, u32 max_iter);                           /* otp.c */
void hwd_sdp_drive_value (u32 value, u32 pin);                                                       /* hw_init.c */
void hwd_setup_pair (u32 a, u32 b);                                                                  /* rf.c */
u32 hwd_spi_poll_done (u32 a);                                                                       /* spi.c */
u32 hwd_spi_read (u32 offset, u32 len, void *buf);                                                   /* spi.c */
void hwd_spi_release_lock (void);                                                                    /* spi.c */
void hwd_wait_pll_lock (void);                                                                       /* misc_ext.c */
void hwf_calib_acquire_hw (void);                                                                    /* calib.c */
void hwf_calib_all (void);                                                                           /* calib.c */
void hwf_calib_bb_gain_args (calib_vga_pt_t meas, const calib_u8x4_t *idx, calib_u8x4_t lim, calib_row8_t r1, calib_row8_t r2, calib_row8_t r3, calib_row8_t r4); /* calib.c */
void hwf_calib_bb_gain_create_table (u32 *tbl, calib_vga_pt_t best, calib_u8x4_t lim, calib_row8_t r1, calib_row8_t r2, calib_row8_t r3, calib_row8_t r4); /* calib.c */
u32 hwf_calib_bb_gain_rows (calib_u8x4_t lim, calib_row8_t r1, calib_row8_t r2, calib_row8_t r3, calib_row8_t r4, calib_vga_pt_t *out, u32 *tbl); /* calib.c */
u32 hwf_calib_lo_power_flow (u32 mode, u32 nibble, u32 f0, u32 f1, u32 f2, u32 level, u32 rf);       /* calib.c */
void hwf_calib_release_hw (void);                                                                    /* calib.c */
void hwf_calib_restore_path (void);                                                                  /* calib.c */
u32 hwf_calib_sar_alg (u32 skip_step2, u32 thr, u32 idx);                                            /* calib.c */
void hwf_dc_calib_fix_dac1 (u32 lo, u32 hi, u32 mode);                                               /* calib.c */
void hwf_if_gain_apply_agc_table (u32 a0);                                                           /* calib.c */
void hwf_rf_config (u32 ch);                                                                         /* rf_sector.c */
void hwf_rf_wait_ready_log (void);                                                                   /* rf.c */
void hwf_rf_wait_reset_done (u32 a);                                                                 /* rf.c */
void hwf_rf_xpm_cfg_get (u32 rf, u32 *cfg);                                                          /* mac_ext.c */
void hwf_rf_xpm_cfg_set (u32 rf, const u32 *cfg);                                                    /* mac_ext.c */
u32 hwf_rf_xpm_enter_cfg_mode (u32 rf, u32 mode);                                                    /* mac_ext.c */
u32 hwf_rf_xpm_program_bit (u32 rf, u32 bit_addr, u32 wait, u32 trials);                             /* wmi_h_misc.c */
u32 hwf_rf_xpm_program_byte (u32 rf, u32 bit_addr, u32 val, u32 wait, u32 trials, u32 verify);       /* wmi_h_misc.c */
u32 hwf_rf_xpm_read_block (u32 rf, u32 addr, u32 len, void *dst);                                    /* otp.c */
u32 hwf_rf_xpm_read_byte (u32 rf, u32 bit_addr, u8 *dst);                                            /* otp.c */
u32 hwf_rf_xpm_write_block (u32 rf, u32 addr, u32 len, const u8 *src, u32 wait, u32 trials, u32 verify); /* wmi_h_misc.c */
void hwf_sector_rf_chain_get (u32 rf, u32 sector, u32 tx, u32 chain, u8 *out);                       /* rf_sector.c */
void hwf_sector_rf_chain_set (u32 rf, u32 sector, u32 tx, u32 chain, u32 edge_gain, u32 edge_phase, u32 dist_gain, s32 commit); /* rf_sector.c */
void hwf_set_agc_index_1c (struct calib_obj *obj, u32 x, u32 y);                                     /* calib.c */
u32 hwf_vga_dc_calibrate (u32 idx, u32 sel, u32 shift, u32 thr, u32 col);                            /* calib.c */
s32 hwf_vga_dc_measure (u32 sel, u32 shift);                                                         /* calib.c */
void hwm_analog_channel_switch (u32 ch, u32 v1, u32 v2);                                             /* chan_sw.c */
void hwm_analog_channel_switch_thunk (u32 ch);                                                       /* chan_sw.c */
void hwm_analog_prepare_buf (u32 a);                                                                 /* stubs.c */
void hwm_analog_select_active_rf_module (u32 mask);                                                  /* rf_sector.c */
void hwm_apply_channel_config (u32 on);                                                              /* chan_sw.c */
void hwm_apply_mode_flags (u32 mode, u32 *flags);                                                    /* power_halt.c */
void hwm_calib_set_loopback_mode (u32 flag);                                                         /* rf.c */
void hwm_measure_33khz_wait (void);                                                                  /* power.c */
u32 hwm_power_33kHz_clk_detector (void);                                                             /* power.c */
u32 hwm_probe_33khz_clk (void);                                                                      /* power.c */
void hwm_reset_analog_block (void);                                                                  /* stubs.c */
void hwm_set_analog_path (u32 on, u32 tx_idx, u32 rx_idx);                                           /* calib_hw.c */
void hwm_start_33khz_measure (u32 a);                                                                /* power.c */
void ie_iter_init (struct ie_iter *it, struct app_ies *list);                                        /* mgmt_tx.c */
struct conn *ie_list_first (struct mid *e, u32 cid);                                                 /* link_sm.c */
u32 ie_push_dmg_capabilities (u8 *dst, u8 *src, u32 flag);                                           /* mgmt_tx.c */
u32 ie_push_edca (u8 *dst, const struct mid_bss *mid);                                               /* mgmt_tx.c */
u32 ie_push_eid151_len10 (u8 *dst, const u8 *src);                                                   /* mgmt_tx.c */
u32 ie_push_eid190_len4 (u8 *dst, const u8 *src);                                                    /* mgmt_tx.c */
u32 ie_push_qos_capability (u8 *dst);                                                                /* mgmt_tx.c */
u32 ie_push_raw (u8 *dst, const u8 *src);                                                            /* mgmt_tx.c */
u32 ie_push_ssid (u8 *dst, const u8 *ssid, u32 len);                                                 /* mgmt_tx.c */
u32 ie_push_wfa_vendor (u8 *dst, const u8 *src, u32 flag);                                           /* mgmt_tx.c */
u32 ies_block_is_empty (const struct app_ies *block);                                                /* mgmt_tx.c */
u32 ies_block_merge (u32 *dest_block, struct app_ies *internal_block, struct app_ies *external_block); /* mgmt_tx.c */
u32 if_gain (u32 a0);                                                                                /* calib.c */
void if_gain_apply_delta (s32 delta, struct if_gain_meas *out);                                      /* calib.c */
u32 if_gain_compute_correction (u32 a0, const struct if_gain_meas *a1);                              /* calib.c */
u32 if_gain_get_scaled (u32 n);                                                                      /* calib.c */
s32 if_gain_scale_value (u32 a, u32 c);                                                              /* calib.c */
void init_rf_hw (struct rf_obj *this);                                                               /* rf.c */
void install_key_handle (struct conn *conn);                                                         /* discovery.c */
void install_key_parse_flags (u32 k, u32 i, u32 f);                                                  /* tx_helpers.c */
void irq_ack_880b00 (u32 a);                                                                         /* sched.c */
void irq_disable_all (void);                                                                         /* irq.c */
void irq_disable_line1 (void);                                                                       /* irq.c */
void irq_disable_line2 (void);                                                                       /* irq.c */
void irq_enable_all (void);                                                                          /* irq.c */
void irq_enable_line1 (void);                                                                        /* irq.c */
void irq_enable_line2 (void);                                                                        /* irq.c */
void irq_set_level (u32 irq, u32 level);                                                             /* irq.c */
void isr_880b50_dispatch_causes (void);                                                              /* isr.c */
void isr_caf_icr_889470 (void);                                                                      /* vectors.c */
void isr_instruction_error (u32 blink, u32 ilink2, const u32 *regs);                                 /* vectors.c */
void isr_mac_886028 (void);                                                                          /* vectors.c */
void isr_mac_icr_886e40 (void);                                                                      /* vectors.c */
void isr_mac_icr_887010 (void);                                                                      /* vectors.c */
void isr_mac_icr_88702c (void);                                                                      /* vectors.c */
void isr_memory_error (u32 blink, u32 sp, u32 ilink1, u32 ilink2);                                   /* vectors.c */
void isr_pcie_debug (void);                                                                          /* vectors.c */
void isr_pcie_ltssm (void);                                                                          /* vectors.c */
void isr_pcie_main (void);                                                                           /* vectors.c */
void isr_step_22f70_80044c (void);                                                                   /* isr.c */
void isr_vring_dma_fw (void);                                                                        /* vring.c */
void iter_init (u32 *it, const struct llist *list);                                                  /* vring.c */
void *iter_next (u32 *it);                                                                           /* vring.c */
void ka_check_peer_state (struct ll_ka_det *obj);                                                    /* discovery.c */
u32 ka_detector_is_enabled (struct ll_ka_det *d);                                                    /* link_loss.c */
void ka_necessity_detector_start_monitoring (struct ll_ka_det *det);                                 /* link_loss.c */
void ka_necessity_detector_task (struct psvc *svc, u32 count);                                       /* link_loss.c */
struct scan_peer *l2_mgr_connect_next (struct scan_mngr *obj, const u8 *key, u32 band);              /* discovery.c */
void l2_mgr_high_false_alarm_secondary_lock_cb (struct fw_sysapi_mgr *req, const u32 *res);          /* misc_ext_sysapi.c */
void l2_mgr_lmac_high_false_alarm_evt_handler (void);                                                /* lmac_evt.c */
void l2_mgr_lmac_new_link_evt_handler (const struct lmac_evt_bf_done *e, u32 st);                    /* lmac_evt.c */
void l2_mgr_set_rf_params (u32 cid, u32 a1, u32 a2);                                                 /* l2mgr.c */
void l2_offload_cfg_rx_decap (const u8 *p);                                                          /* rx_chain.c */
void l2_offload_set_own_mac_addr (const u8 *m);                                                      /* wmi_cmd.c */
void l2_offload_set_rx_decap_cfg (u32 cfg);                                                          /* rx_chain.c */
u32 l2mgr_aborting_scan (u32 mid);                                                                   /* wmi_cmd.c */
void l2mgr_apply_key_to_prings (struct conn *conn);                                                  /* l2mgr_key.c */
void l2mgr_apply_mac_address (struct mid_bss *obj, const u8 *mac);                                   /* wmi_cmd.c */
void l2mgr_bringup_pair (u32 val);                                                                   /* mac_bringup.c */
void l2mgr_config_security (struct mid_sec *obj, u32 dot11_auth, u32 auth, u32 group_crypto, u32 a4, u32 wpa_offload); /* wmi_cmd.c */
void l2mgr_connect (const struct wmi_connect_cmd *cmd, u32 mid);                                     /* wmi_cmd.c */
struct rm_req *l2mgr_connect_args (rm_req_cb cb, u32 arg, u32 mid);                                  /* wmi_cmd.c */
void l2mgr_connect_multi_omni (const struct wmi_connect_cmd *cmd, u32 mid);                          /* wmi_cmd.c */
void l2mgr_connect_radio_cb (struct rm_req *req, u32 arg);                                           /* wmi_cmd.c */
void l2mgr_connect_setup (const struct wmi_connect_cmd *cmd, u32 mid);                               /* wmi_cmd.c */
void l2mgr_data_port_open_and_keys (u32 a0, u32 a1);                                                 /* conn.c */
void l2mgr_del_sta (const struct wmi_disconnect_sta_cmd *cmd, u32 mid, struct wmi_mbox *mb);         /* wmi_h_sta.c */
void l2mgr_disconnect (u32 mid, u32 reason, u32 protocol);                                           /* wmi_cmd.c */
void l2mgr_disconnect_mid (u32 mid, u32 reason, u32 protocol);                                       /* wmi_cmd.c */
void l2mgr_disconnect_sta (u32 mid, const u8 *mac, u32 protocol);                                    /* conn.c */
void l2mgr_init (void);                                                                              /* l2mgr.c */
void l2mgr_init_frame_pool (void);                                                                   /* pool.c */
u32 l2mgr_is_busy_flag_set (u32 op);                                                                 /* wmi_cmd.c */
void l2mgr_link_lost_radio_cb (struct rm_req *a, u32 t0);                                            /* l2mgr_key.c */
void l2mgr_mac_bringup (void);                                                                       /* l2mgr.c */
u32 l2mgr_mac_started_log (u32 mid, const u8 *mac, const u8 *ssid, u32 ssid_len);                    /* mid.c */
void l2mgr_new_sta (const struct wmi_new_sta_cmd *cmd, u32 mid, struct wmi_mbox *mb);                /* wmi_h_sta.c */
void l2mgr_notify_link_up (struct mid_disc *o, struct conn *conn, u32 v);                            /* conn.c */
void l2mgr_on_lmac_ready (void);                                                                     /* l2mgr.c */
void l2mgr_p2p_cfg (const struct wmi_p2p_cfg_cmd *cmd, u32 mid);                                     /* wmi_h_pcp.c */
void l2mgr_pcp_stop (u32 mid);                                                                       /* rf_kill.c */
void l2mgr_pending_op_clear (u32 op);                                                                /* wmi_cmd.c */
void l2mgr_pending_op_set (u32 op);                                                                  /* wmi_cmd.c */
void l2mgr_post_bringup (void);                                                                      /* l2mgr.c */
u32 l2mgr_program_args (const struct vring_tbl_entry *e, const void *p1, const void *p2, u8 a3, u8 a4, u8 a5); /* stream_mgr.c */
void l2mgr_program_assoc_vring (u32 a0, u32 cid, const u8 *peer, const u8 *own, u32 type, u32 a5);   /* conn.c */
void l2mgr_scan_complete_handle (u32 mid, u32 resume);                                               /* scan.c */
void l2mgr_scan_start (struct mid_disc *obj, struct wmi_start_scan_cmd *cmd, u32 a2, u32 a3);        /* wmi_cmd.c */
void l2mgr_send_acs_scan_complete_evt (u32 status, u32 mid, u32 dwell_ms, u32 filled, const struct scan_passive_info *info); /* scan.c */
void l2mgr_send_data_port_open_evt (u32 cid, u32 mid);                                               /* conn.c */
void l2mgr_send_disconnect_evt (const u8 *bssid, u32 proto_reason, u32 reason, u32 mid);             /* wmi_cmd.c */
void l2mgr_send_host_event (u32 mid, u32 cid);                                                       /* conn.c */
void l2mgr_send_listen_started (u32 status, u32 mid);                                                /* link_sm.c */
void l2mgr_send_pbss_joined_evt (struct conn *conn);                                                 /* conn.c */
void l2mgr_send_scan_complete_evt (u32 status, u32 mid);                                             /* wmi_cmd.c */
void l2mgr_send_search_started (u32 status, u32 mid);                                                /* link_sm.c */
void l2mgr_send_vring_cfg_done (u32 vring, u32 mac_qid, u32 status, u32 devid);                      /* tx.c */
void l2mgr_send_vring_en_evt (u32 vring, u32 chan);                                                  /* stream_mgr.c */
void l2mgr_set_app_ie (const struct wmi_set_appie_cmd *cmd, u32 mid);                                /* wmi_cmd.c */
void l2mgr_set_mac_address (const struct wmi_set_mac_address_cmd *cmd, u32 mid);                     /* wmi_cmd.c */
void l2mgr_set_ssid (const struct wmi_set_ssid_cmd *cmd, u32 mid);                                   /* wmi_cmd.c */
void l2mgr_start_discovery (u32 mid);                                                                /* wmi_h_pcp.c */
void l2mgr_start_listen (u32 mid);                                                                   /* wmi_h_pcp.c */
void l2mgr_start_search (u32 mid);                                                                   /* wmi_h_pcp.c */
void l2mgr_stop_discovery (u32 mid);                                                                 /* wmi_h_pcp.c */
u32 l2mgr_validate_connect (u32 mid, u32 channel);                                                   /* wmi_cmd.c */
u32 l2mgr_validate_scan (u32 mid);                                                                   /* wmi_cmd.c */
void l2mgr_wmi_scan_cmd (struct wmi_start_scan_cmd *cmd, u32 mid);                                   /* wmi_cmd.c */
void led_scheme_apply (u32 idx);                                                                     /* led.c */
void led_scheme_apply_off (u32 a0, u32 a1);                                                          /* led.c */
void led_scheme_init (u32 a);                                                                        /* stubs.c */
void link_lost_diag (void);                                                                          /* link_diag.c */
void link_lost_diag_dump_dma (void);                                                                 /* link_diag.c */
void link_lost_diag_dump_false_alarms (void);                                                        /* fwq_tx.c */
void link_lost_diag_dump_mac_rx (void);                                                              /* link_diag.c */
void link_lost_diag_dump_pcie (void);                                                                /* link_diag.c */
void link_lost_diag_dump_phy (void);                                                                 /* fwq_tx.c */
void link_lost_diag_dump_rf (const struct rf_obj *rf);                                               /* link_diag.c */
void link_lost_diag_noop_dump_hook (void);                                                           /* link_diag.c */
void link_lost_diag_part2 (void);                                                                    /* mlme.c */
void link_lost_diag_rx_status (void);                                                                /* misc_ext.c */
void link_stats_latency_timer_cb (u32 a0, u32 a1);                                                   /* link_sm.c */
void link_stats_on_latency_timer (struct link_stats_sm *s, u32 a);                                   /* link_sm.c */
void link_stats_on_pause (struct link_stats_sm *s);                                                  /* link_sm.c */
void link_stats_on_resume (struct link_stats_sm *s);                                                 /* link_sm.c */
void link_stats_on_start (struct link_stats_sm *s);                                                  /* link_sm.c */
void link_stats_on_stop (struct link_stats_sm *s);                                                   /* link_sm.c */
void link_stats_pack_conn_entry (const struct lmac_evt_bf_done *s, struct ut_bf_stats *d);           /* misc_ext.c */
void link_stats_report (struct link_stats_sm *s, u32 a);                                             /* link_sm.c */
void link_stats_report_timer_cb (u32 a0, u32 a1);                                                    /* link_sm.c */
void list_find_entry (struct u_schd_tq *q, struct u_schd_task *entry, u_schd_cmp_fn cmp);            /* sched.c */
void list_find_entry_b (void *list_obj, void *node, void *prev);                                     /* sched.c */
void list_find_entry_c (void *list_obj, void *node);                                                 /* sched.c */
void list_find_entry_d (void *list_obj, void *node);                                                 /* sched.c */
u32 list_has_items (u32 *it);                                                                        /* vring.c */
u32 ll_detector_is_armed (struct ll_ka_det *a);                                                      /* discovery.c */
u32 ll_detector_is_armed_b (struct ll_ageing_det *a);                                                /* discovery.c */
void llist_init (void *list);                                                                        /* sched.c */
void *llist_pop_front (void *list);                                                                  /* sched.c */
void lm_if_disable_link_loss_monitoring (struct lm_if *obj);                                         /* discovery.c */
void lm_if_inject_evt9 (struct lm_if *obj);                                                          /* wmi_cmd.c */
void lm_if_on_linkup_ready (struct lm_if *lm);                                                       /* conn.c */
void lm_if_set_cid (struct lm_if *obj, u8 cid);                                                      /* discovery.c */
void lm_if_stop_link_a (struct ll_ka_det *a);                                                        /* discovery.c */
void lm_if_stop_link_b (struct ll_ageing_det *a);                                                    /* discovery.c */
void lm_if_stop_link_loss_monitoring (struct lm_if *obj);                                            /* discovery.c */
void lm_main_sm_config_lmac_bf_sm (struct lm_sm *l, u32 a1);                                         /* conn.c */
void lm_notify_linkup (struct lm_if *lm, u32 v);                                                     /* conn.c */
u32 lm_sm_get_mid_idx (struct lm_sm *l);                                                             /* conn.c */
void lm_sm_on_bf_results_configured (struct lm_sm *l, const struct lmac_evt_bf_done *res);           /* link_sm.c */
void lm_sm_on_bf_results_wait_link (struct lm_sm *l, const struct lmac_evt_bf_done *res);            /* link_sm.c */
void lm_sm_on_link_lost (struct lm_sm *l);                                                           /* link_sm.c */
void lm_sm_on_link_stat_update (struct lm_sm *l, u32 a);                                             /* link_sm.c */
void lm_sm_on_linkup_done (struct lm_sm *l);                                                         /* link_sm.c */
void lm_sm_on_linkup_fail (struct lm_sm *l);                                                         /* link_sm.c */
void lm_sm_on_linkup_req_configured (struct lm_sm *l);                                               /* link_sm.c */
void lm_sm_on_linkup_req_idle (struct lm_sm *l, u32 a0);                                             /* link_sm.c */
void lm_sm_on_maintain_started (struct lm_sm *l);                                                    /* link_sm.c */
void lm_sm_on_pause (struct lm_sm *l);                                                               /* link_sm.c */
void lm_sm_on_resume_maintain (struct lm_sm *l);                                                     /* link_sm.c */
void lm_sm_on_start_maintain (struct lm_sm *l);                                                      /* link_sm.c */
void lm_sm_on_stop_link (struct lm_sm *l);                                                           /* link_sm.c */
void lm_sm_on_stop_link_maintain (struct lm_sm *l);                                                  /* link_sm.c */
void lm_sm_on_stop_link_wait (struct lm_sm *l);                                                      /* link_sm.c */
void lm_sm_post_evt6_via_owner (struct lm_if *lm);                                                   /* conn.c */
void *lmac_cmd_pool_alloc (void);                                                                    /* tx_helpers.c */
struct ese_slot *lmac_evt_entry_end (struct ese_sched *obj);                                         /* rx.c */
void lmac_if_abft_notify_evt (struct lmac_evt_bf_done *e);                                           /* lmac_evt.c */
void lmac_if_bf_done_and_new_link (struct lmac_evt_bf_done *e, u32 st);                              /* lmac_evt.c */
void lmac_if_bf_done_evt (struct lmac_evt_bf_done *e);                                               /* lmac_evt.c */
void lmac_if_bits_set32_s6_w26 (void *p, u32 v);                                                     /* mac_ext.c */
void lmac_if_build_bcon_cfg (volatile struct lmac_cmd_bcn_sweep *cmd, u32 a0, u32 w0, u32 w1);       /* pcp_ext.c */
void lmac_if_build_cmd_rings (struct lmac_mbox *mb);                                                 /* lmac.c */
void lmac_if_config_txss (u32 cid);                                                                  /* lmac.c */
void lmac_if_discovery_mode_cfg (u32 mode, u32 a1);                                                  /* wmi_cmd.c */
void lmac_if_echo_evt_handler (const struct lmac_cmd_echo *e);                                       /* lmac_evt.c */
void lmac_if_evt_fields (struct mbox_ring *r);                                                       /* tx_helpers.c */
u32 lmac_if_evt_first_field (struct ese_sched *obj);                                                 /* rx.c */
void lmac_if_evt_walk (struct sched_scheme *obj);                                                    /* rx.c */
void lmac_if_install_key (u32 idx, u32 a1, const void *key, u32 a3, u32 a4);                         /* link_sm.c */
void lmac_if_link_lost_evt_handler (const struct lmac_evt_link_lost *e);                             /* lmac_evt.c */
void lmac_if_lmac_ready_evt (void);                                                                  /* lmac.c */
void lmac_if_post_cmd (volatile void *body, u32 type, u32 len, u32 flags);                           /* tx_helpers.c */
void lmac_if_rs_done_evt (const struct lmac_evt_rs_done *e);                                         /* lmac_evt.c */
void lmac_if_rs_started (const struct lmac_evt_u32 *e);                                              /* lmac_evt.c */
void lmac_if_send_bcon_mgt (u32 a0, u32 a1, u32 w0, u32 w1, const u8 *mac);                          /* pcp_ext.c */
void lmac_if_send_cmd_0x00 (const struct lmac_mac_cfg_src *cfg, u32 a1, u32 a2);                     /* l2mgr.c */
void lmac_if_send_cmd_0x04 (u32 mode);                                                               /* lmac.c */
void lmac_if_send_cmd_0x08 (u32 a0, u32 a1, u32 pring, u32 vr, u32 f6, u32 f5, u32 flag);            /* vring.c */
void lmac_if_send_cmd_0x0f (u32 cid, u32 a1);                                                        /* link_sm.c */
void lmac_if_send_cmd_0x16_calib_b4 (void);                                                          /* lmac.c */
void lmac_if_send_cmd_0x23 (u32 a);                                                                  /* lmac.c */
void lmac_if_send_cmd_0x30 (u32 a, u32 b, u32 c);                                                    /* pcp_ext.c */
void lmac_if_send_cmd_0x47 (u32 vr, u32 on);                                                         /* vring.c */
void lmac_if_send_get_selected_rf_sector_index (const struct rf_sector_sel_req *self);               /* wmi_h_bf.c */
void lmac_if_send_init_cfg (void);                                                                   /* l2mgr.c */
void lmac_if_send_phy_ina_det_cfg (const struct lmac_cmd_ina_det *src);                              /* lmac.c */
void lmac_if_send_qset_ranges (void);                                                                /* l2mgr.c */
void lmac_if_send_set_selected_rf_sector_index (const struct rf_sector_sel_req *self);               /* wmi_h_bf.c */
void lmac_if_send_sta_cfg_05 (struct conn *a, u32 b);                                                /* discovery.c */
void lmac_if_trigger_bf (u32 cid, u32 a1);                                                           /* conn.c */
void lmac_if_ucode_event_dispatch (struct lmac_mbox *mb, u8 *evt);                                   /* lmac.c */
void lmac_if_ucode_evt_check_8 (struct lmac_evt_ps_peer *e, u32 st);                                 /* lmac_evt.c */
void lmac_if_ucode_init (void);                                                                      /* lmac.c */
void lmac_if_update_pct_stats (void);                                                                /* lmac_evt.c */
void lmac_mbox_drain_task (u32 a0, u32 a1);                                                          /* lmac.c */
u32 lmac_mbox_is_full (void);                                                                        /* scan_mngr.c */
u32 lo_power_calib_get_param_d0 (void);                                                              /* calib.c */
u32 lo_power_calib_get_state_obj (void);                                                             /* calib.c */
u32 lo_power_calib_get_table_idx (void);                                                             /* calib.c */
void lo_power_restore_rfc_field (void);                                                              /* power.c */
void low_sme_check_state_1 (struct mbox_ring *o, u32 payload, u32 a4, u32 a5);                       /* discovery.c */
void low_sme_scan_done_task (u32 a0, u32 a1);                                                        /* discovery.c */
void low_sme_send_evt2_body (struct fw_mailbox *mb, u32 payload, u32 a4, u32 a5);                    /* discovery.c */
void low_sme_send_evt2sw (void *payload, u32 evt, u32 len, u32 mid, u32 a4, u32 a5, u32 a6);         /* discovery.c */
void low_sme_send_rf_mgmt_status (void);                                                             /* rf_kill.c */
void low_sme_termination_check (u32 evt);                                                            /* discovery.c */
void low_sme_termination_check_thunk (u32 a0, u32 a1);                                               /* discovery.c */
void low_sme_wmi_rf_mgmt_cmd_handler (const struct wmi_rf_mgmt_cmd *cmd);                            /* wmi_h_misc.c */
void low_sme_wmi_scan_cmd_handler (struct wmi_start_scan_cmd *cmd, u32 mid);                         /* wmi_cmd.c */
u32 lut_find_index (const struct sysapi_lut *lut, u32 key);                                          /* bf_result.c */
void mac_ampdu_statistics_timeout_cb (struct fw_sysapi_mgr *o);                                      /* mac_ext.c */
void mac_apply_multicast_addr (struct mid *e, const u8 *mac);                                        /* wmi_cmd.c */
void mac_bringup_init_dma_ctrl (void);                                                               /* mac_bringup.c */
void mac_bringup_init_rx_desc (void);                                                                /* macq.c */
void mac_bringup_init_rx_fields (const u8 *desc, u32 arg);                                           /* macq.c */
void mac_bringup_init_seq (void);                                                                    /* mac_bringup.c */
void mac_bringup_init_tx_queues (void);                                                              /* mac_bringup.c */
void mac_bringup_prog_881000 (void);                                                                 /* mac_bringup.c */
void mac_bringup_prog_881b00 (void);                                                                 /* mac_bringup.c */
void mac_bringup_set_886a80_ctl_bit0 (void);                                                         /* mac_bringup.c */
void mac_enable_880bc0_b0 (void);                                                                    /* mac.c */
void mac_enable_bcast_ring (void);                                                                   /* stream_mgr.c */
void mac_filter_bits_set16h_s4_w2 (void *p, u32 v);                                                  /* tx_helpers.c */
void mac_filter_write_entries (u32 a, u32 b, u32 c);                                                 /* mac_parser.c */
void mac_filter_write_one (const u32 *mac, u32 n, u32 idx);                                          /* tx_helpers.c */
u32 mac_get_beacon_interval_us (void);                                                               /* rx.c */
u32 mac_get_bi_start_tsf (void);                                                                     /* rx.c */
void mac_hdr_copy_addr (const struct mid *p, void *d);                                               /* tx_helpers.c */
void mac_icr_mask_awake_tsf (void);                                                                  /* vectors.c */
void mac_mem_write_slot (u32 idx, u32 val, u32 n);                                                   /* vring.c */
void mac_parser_build_wildcard_rule (u32 a0);                                                        /* mac_parser.c */
void mac_parser_configure (u32 r0, u32 mode);                                                        /* mac_bringup.c */
void mac_parser_init (u32 obj);                                                                      /* mac_parser.c */
void mac_parser_install_default_rules (u32 obj);                                                     /* mac_parser.c */
void mac_parser_pack_rule_halfword (const struct prs_rule *buf, u32 val);                            /* mac_parser.c */
void mac_parser_rule_a (void);                                                                       /* mac_bringup.c */
void mac_parser_rule_b (u32 v);                                                                      /* mac_bringup.c */
void mac_parser_set_886200 (u32 a0, u32 a1, u32 a2, u32 a3);                                         /* mac_bringup.c */
void mac_parser_set_886260 (u32 idx, u32 val);                                                       /* mac_bringup.c */
void mac_parser_set_addr_886018 (const u8 *m);                                                       /* wmi_cmd.c */
void mac_parser_set_addr_886020 (const u8 *m);                                                       /* wmi_cmd.c */
void mac_parser_set_default_ctrl (void);                                                             /* mac_bringup.c */
void mac_parser_step_a (u32 obj);                                                                    /* mac_parser.c */
void mac_parser_step_b (u32 obj);                                                                    /* mac_parser.c */
void mac_parser_write_rule (const struct prs_rule *buf, u32 val, u32 field);                         /* mac_parser.c */
void mac_program_886c00_entry (u32 a, u32 b, u32 c);                                                 /* mlme.c */
void mac_read_880a2c_38 (u32 *a, u32 *b, u32 *c, u32 *d);                                            /* mac.c */
u32 mac_read_tsf64 (u32 unused, u32 *out, u32 wait);                                                 /* mac.c */
u32 mac_read_tsf_hi (u32 a);                                                                         /* mac.c */
void mac_reload_tsf64 (u32 a, u32 b);                                                                /* power.c */
void mac_ring_disable (u32 q);                                                                       /* vring.c */
void mac_ring_enable (u32 q, u32 en);                                                                /* vring.c */
u32 mac_rx_cnt_get_crc_total (void);                                                                 /* mac_ext.c */
u64 mac_rx_cnt_get_u64_bc (void);                                                                    /* mac_ext.c */
u32 mac_rx_stats_crc_err (void);                                                                     /* link_diag.c */
u32 mac_rx_stats_crc_ok (void);                                                                      /* link_diag.c */
void mac_set_880af8_afc_b25_b5 (u32 v);                                                              /* mac.c */
void mac_set_880af8_afc_b30_b6 (u32 v);                                                              /* mac.c */
void mac_set_880afc_bits26_31_fw (u32 on);                                                           /* power_halt.c */
void mac_set_880afc_bits9_11 (u32 on);                                                               /* mac.c */
void mac_set_880bc0_b0 (u32 v);                                                                      /* mac.c */
void mac_set_880bf0_mode_fw (u32 mode);                                                              /* power_halt.c */
void mac_set_886838_b0 (u32 val);                                                                    /* mac_bringup.c */
void mac_set_bits_880af4_f8_fc (u32 v);                                                              /* mac.c */
void mac_set_mcast_addr (const u8 *m);                                                               /* wmi_cmd.c */
void mac_set_own_addr (const u8 *m);                                                                 /* wmi_cmd.c */
void mac_set_usec_clk_div (u32 div, u32 reload);                                                     /* power_halt.c */
void mac_toggle_880288_b1 (void);                                                                    /* mac.c */
u32 mac_tx_cnt_delta_88_net_of_20 (void);                                                            /* vring.c */
u32 mac_tx_cnt_get_fail (void);                                                                      /* vring.c */
u32 mac_tx_cnt_get_ok (void);                                                                        /* vring.c */
u64 mac_tx_cnt_get_u64_14 (void);                                                                    /* mac_ext.c */
void macq_clear_886a28_low2 (void);                                                                  /* vring.c */
void macq_desc_read (void *d, u32 b, u32 c, u32 count, u32 e);                                       /* tx_helpers.c */
void macq_desc_read_typed (void *d, u32 b, u32 c, u32 dd, u32 e, u32 f, u32 g);                      /* tx_helpers.c */
void macq_desc_release_window (void);                                                                /* macq.c */
void macq_desc_wait_window_free (void);                                                              /* macq.c */
void macq_desc_write (const void *desc, u32 a1, u32 a2, u32 a3, u32 a4, u32 a5, u32 a6, u32 a7);     /* macq.c */
void macq_desc_write_type6 (const void *desc, u32 arg);                                              /* macq.c */
void macq_hw_disable_queue_fw (u32 idx);                                                             /* vring.c */
void macq_hw_set_low_nibble (u32 idx);                                                               /* dma_ring.c */
void macq_hw_sync_dma_wptr_fw (u32 vr, u32 q);                                                       /* vring.c */
void macq_kick_queue (u32 q);                                                                        /* vring.c */
void mailbox_debug_dump (struct mbox_ring *r);                                                       /* tx_helpers.c */
void maintain_ctx_set_field_9c (struct lm_if *lm, u32 v);                                            /* conn.c */
void maintain_sm_lt_timer_cb (u32 a0, u32 a1);                                                       /* link_sm.c */
void maintain_sm_on_bf_results (struct maintain_sm *m, const struct lmac_evt_bf_done *res);          /* link_sm.c */
void maintain_sm_on_bf_results_first (struct maintain_sm *m, const struct lmac_evt_bf_done *res);    /* link_sm.c */
void maintain_sm_on_fbf_fail (struct maintain_sm *m);                                                /* link_sm.c */
void maintain_sm_on_first_fbf_success (struct maintain_sm *m);                                       /* link_sm.c */
void maintain_sm_on_high_per (struct maintain_sm *m);                                                /* link_sm.c */
void maintain_sm_on_pause (struct maintain_sm *m);                                                   /* link_sm.c */
void maintain_sm_on_resume (struct maintain_sm *m);                                                  /* link_sm.c */
void maintain_sm_on_rs_results (struct maintain_sm *m, const struct lmac_rs_result *res);            /* link_sm.c */
void maintain_sm_on_start (struct maintain_sm *m);                                                   /* link_sm.c */
void maintain_sm_on_stop (struct maintain_sm *m);                                                    /* link_sm.c */
void maintain_sm_on_timer_active (struct maintain_sm *m);                                            /* link_sm.c */
void maintain_sm_on_timer_fbf_done (struct maintain_sm *m);                                          /* link_sm.c */
void maintain_sm_radio_locked_cb (struct rm_req *req, u32 arg);                                      /* link_sm.c */
void maintain_sm_release_radio_after_bf_evt (struct maintain_sm *m);                                 /* link_sm.c */
void maintain_sm_set_rs_params (struct lm_sm *l, u32 mode, u32 v);                                   /* link_sm.c */
void maintain_sm_window_timer_cb (u32 a0, u32 a1);                                                   /* link_sm.c */
void marlon_r_if_class_config_brp_sectors (u32 rf_mask);                                             /* rf.c */
u32 marlon_r_if_class_config_channel (struct rf_obj *this, u32 ch, u32 mode);                        /* rf.c */
u32 marlon_r_if_class_init_board_file_interface (struct rf_obj *rf);                                 /* brd_if.c */
u32 marlon_r_if_class_load_brd_parameters_section (struct rf_obj *rf, u32 per_chunk);                /* brd_if.c */
u32 marlon_r_if_class_load_brd_rf_cfg_section (struct rf_obj *rf, u32 sec, const struct brd_bounds *bounds, u32 per_chunk, u32 mode); /* brd_if.c */
void marlon_r_if_class_rf_hw_write_buffer (struct rf_obj *obj, u32 a1, const struct rf_reg_pair *buf, u32 len); /* calib.c */
u32 marlon_r_if_class_rf_write_with_block_retries (struct rf_obj *obj, u32 a1, const struct rf_reg_pair *buf, u32 len, u32 blk, u32 retries, u32 fatal); /* calib.c */
u32 marlon_r_if_read_step (struct rf_obj *this, u32 mode);                                           /* rf.c */
void mbox_dbg_evt_posted (struct wmi_mbox *mb);                                                      /* wmi_cmd.c */
void mbox_dbg_unmask_irq (struct wmi_mbox *mb);                                                      /* wmi_cmd.c */
void mbox_drain_debug (u32 a0, u32 a1);                                                              /* wmi_cmd.c */
void mbox_drain_operational (u32 a0, u32 a1);                                                        /* wmi_cmd.c */
void mbox_init_descriptor (struct wmi_mbox *m, struct mbox_ring_hw *hw, u32 rx_base, u32 tx_base, void *rx_buf, void *tx_buf, u32 rx_n, u32 tx_n, u32 *desc); /* mbox.c */
void mbox_op_evt_posted (struct wmi_mbox *mb);                                                       /* wmi_cmd.c */
void mbox_op_unmask_irq (struct wmi_mbox *mb);                                                       /* wmi_cmd.c */
u32 mbox_ring_advance (struct mbox_ring *r);                                                         /* tx_helpers.c */
u32 mdm_stt_rx_crc_ok (void);                                                                        /* misc_ext.c */
void *mem_pool_alloc_cell (struct mbox_ring *r);                                                     /* pool.c */
void *mem_pool_alloc_locked (struct fw_mailbox *mbox);                                               /* pool.c */
void *mem_pool_alloc_raw (struct mem_pool *p);                                                       /* pool.c */
void *mem_pool_allocate (struct mem_pool *p);                                                        /* pool.c */
void mem_pool_free (struct mem_pool *p, void *data);                                                 /* pool.c */
void mem_pool_free_8cb19c (u32 obj);                                                                 /* mbox.c */
void mem_pool_free_locked (struct mem_pool *p, void *data);                                          /* pool.c */
void mem_pool_free_locked_evt (struct u_schd_task *evt);                                             /* pool.c */
void mem_pool_free_thunk (struct rx_pkt *pkt);                                                       /* rx.c */
u32 mem_pool_get_field14 (const struct rx_dma_ring *r);                                              /* pool.c */
void mem_pool_init (struct mem_pool *p, void *base, u32 elem_size, u32 count);                       /* pool.c */
void mem_pool_link_free_list (struct mem_pool *p, u8 *base, u32 count);                              /* pool.c */
void mem_pool_put_block (struct rx_ring *o);                                                         /* mbox.c */
int memcmp_fw (const u8 *a, const u8 *b, u32 len);                                                   /* scan_mngr.c */
void memcpy_fw (void *dst, const void *src, u32 len);                                                /* util.c */
void memset0_words (void *dst, u32 len);                                                             /* util.c */
void memset_fw (void *dst, u32 val, u32 len);                                                        /* util.c */
void mgmt_pkt_clear (struct rx_pkt_srvs *tbl, struct rx_mgmt_ei *ei);                                /* discovery.c */
void mgmt_pkt_release (struct rx_pkt *pkt);                                                          /* discovery.c */
u32 mgmt_tx_append_probe_resp_ies (u8 *dst, struct mid_bss *mid, u32 flag);                          /* mgmt_tx.c */
u32 mgmt_tx_assoc_resp_tlv (u8 *dst, struct mid_bss *mobj, u32 aid);                                 /* mlme.c */
u32 mgmt_tx_begin_frame (u32 pl, u32 *len, const struct mid *mid, struct conn *conn, u32 subtype);   /* tx.c */
void mgmt_tx_build_assoc_req (u32 payload, u32 *out_len, struct mid *mid, struct conn *conn);        /* mlme.c */
void mgmt_tx_build_assoc_resp (u32 payload, u32 *out_len, struct mid *mid, struct conn *conn);       /* mlme.c */
void mgmt_tx_build_mac_header (const struct mid *mid, struct ieee80211_hdr *h, u32 subtype, const u8 *src_addr); /* tx.c */
void mgmt_tx_build_probe_req (u32 payload, u32 *out_len, struct mid *mid_e, struct conn *conn, const u8 *ssid_buf, u32 ssid_len); /* mgmt_tx.c */
void mgmt_tx_build_probe_resp (u32 payload, u32 *out_len, struct mid *mid_e, struct conn *conn, u32 frame_type); /* mgmt_tx.c */
u32 mgmt_tx_copy_addr_from_conn (u8 *dst, const struct mid *obj);                                    /* stubs.c */
u32 mgmt_tx_copy_addr_from_mid (u8 *dst, const struct mid *obj);                                     /* stubs.c */
u32 mgmt_tx_copy_ie_hdr (u8 *dst, const struct mid_bss *mid);                                        /* mgmt_tx.c */
u32 mgmt_tx_copy_ie_max96 (u8 *dst, const u8 *src, u32 len);                                         /* mgmt_tx.c */
u32 mgmt_tx_probe_resp_ies (u8 *dst, struct mid_bss *mid, const u8 *ssid, u32 ssid_len);             /* mgmt_tx.c */
u32 mgmt_tx_set_frame_control (u32 dst, const struct mid *obj);                                      /* stubs.c */
struct app_ies *mid_app_ie_block (struct mid_bss *obj, u32 type);                                    /* wmi_cmd.c */
void mid_apply_app_ies (struct mid *e, u32 type, u32 len, u32 buf);                                  /* wmi_cmd.c */
u32 mid_cid_by_aid (struct mid *obj, u32 aid);                                                       /* rx.c */
void mid_clear_rsn_ie_len (struct mid *e);                                                           /* wmi_cmd.c */
void mid_connect (struct mid *e, const union mac_addr *dst_mac, u32 a2);                             /* wmi_cmd.c */
void mid_copy_bssid (const struct mid_bss *obj, u8 *dst);                                            /* tx_helpers.c */
void mid_copy_mac_addr (u32 obj, u8 *dst);                                                           /* pcp_ext.c */
u32 mid_copy_ssid (const struct mid_bss *b, void *dst);                                              /* scan_mngr.c */
u32 mid_count_active_conns (struct mid *e);                                                          /* mid.c */
void mid_ctx_init_pools (void);                                                                      /* l2mgr.c */
u32 mid_disconnect_cmd (struct mid *obj, struct conn *e, u32 reason, u32 protocol);                  /* discovery.c */
struct app_ies *mid_get_bcon_additional_ies (struct mid_bss *mid, u32 frame_type);                   /* mgmt_tx.c */
u32 mid_get_field_0c (const struct sched_scheme *obj);                                               /* stubs.c */
void mid_link_acquis_step (struct conn *conn);                                                       /* scan_mngr.c */
struct conn *mid_link_acquisition (struct mid *mid, const void *key, const void *e, u32 a3, u32 a4); /* scan_mngr.c */
u32 mid_list_any_in_state2 (void);                                                                   /* wmi_cmd.c */
struct mid *mid_list_by_mid_fw (u32 mid);                                                            /* scan_mngr.c */
u32 mid_list_count_active (struct mid *mid);                                                         /* discovery.c */
void mid_list_disconnect_all (struct mid *obj, u32 reason, u32 protocol);                            /* discovery.c */
struct conn *mid_list_find_by (struct mid *obj, const void *key);                                    /* scan_mngr.c */
struct conn *mid_list_find_by_kind (struct mid *obj, u32 kind);                                      /* scan_mngr.c */
void mid_list_insert (struct mid *e);                                                                /* mid.c */
void mid_list_remove_entry (struct mid *obj, struct conn *entry);                                    /* discovery.c */
void mid_log_network_type (struct mid *e, u32 type);                                                 /* wmi_cmd.c */
u32 mid_lookup_at_48 (struct mid *mid);                                                              /* bf_result.c */
void mid_lookup_for_tx (struct mid *mid, u32 cid, u8 *out);                                          /* tx_api.c */
struct mid *mid_open (u32 mid);                                                                      /* mid.c */
void mid_replace_rsn_ie (struct mid_bss *obj, const u8 *ie);                                         /* wmi_cmd.c */
void mid_reset_bss_defaults (struct mid_bss *o, const u8 *mac, const u8 *ssid, u32 ssid_len, u32 mode); /* mid.c */
void mid_set_app_ie_block (struct mid_bss *obj, u32 type, u32 len, u32 buf);                         /* wmi_cmd.c */
void mid_set_default_rsn_ie (struct mid *e);                                                         /* wmi_cmd.c */
void mid_set_ssid (struct mid_bss *obj, const u8 *ssid, u32 len);                                    /* wmi_cmd.c */
u32 mid_state_is_2_or_3 (u32 mid);                                                                   /* tx_helpers.c */
u32 mid_type_of (const struct mid *mid);                                                             /* stream_mgr.c */
u8 mids_get_count (void);                                                                            /* scan_mngr.c */
void mlme_assoc_resp_timeout_cb (u32 a0, u32 a1);                                                    /* mlme.c */
void mlme_assoc_timeout_cb (u32 a0, u32 a1);                                                         /* mlme.c */
void mlme_assoc_tx_done_cb (u32 payload, u32 status, u32 a2);                                        /* mlme.c */
void mlme_ctrl_assoc_res_timeout_cb (u32 a0, u32 a1);                                                /* mlme.c */
void mlme_ctrl_del_sta_timeout_cb (u32 a0, u32 a1);                                                  /* mlme.c */
void mlme_ctrl_new_sta_timeout_cb (u32 a0, u32 a1);                                                  /* mlme.c */
u32 mlme_notify (struct mlme_sm *sm, u32 cid, u32 a2, u32 kind, u32 a4);                             /* mlme.c */
void mlme_rm_locked_cb (struct rm_req *req, u32 arg);                                                /* mlme.c */
void mlme_sm_association_done (u32 a0, u32 a1);                                                      /* conn.c */
void mlme_sm_disconnect_ev_handle (u32 a0, u32 code);                                                /* mlme.c */
void mlme_sm_on_assoc_reject (struct mlme_sm *sm, struct rx_pkt *pkt);                               /* mlme.c */
void mlme_sm_on_assoc_response (struct mlme_sm *sm, struct rx_pkt *pkt);                             /* mlme.c */
void mlme_sm_on_assoc_response_start (struct mlme_sm *sm);                                           /* mlme.c */
void mlme_sm_on_assoc_timeout (struct mlme_sm *sm, u32 a0, u32 a1, u32 cb);                          /* mlme.c */
void mlme_sm_on_connect (struct mlme_sm *sm, struct rx_pkt *pkt);                                    /* mlme.c */
void mlme_sm_on_ctrl_assoc_response_ret (struct mlme_sm *sm, const struct ieee80211_assoc_resp *cmd); /* mlme.c */
void mlme_sm_on_ctrl_del_sta (struct mlme_sm *sm, const struct wmi_disconnect_sta_cmd *cmd);         /* mlme.c */
void mlme_sm_on_ctrl_new_sta (struct mlme_sm *sm, u32 mac);                                          /* mlme.c */
void mlme_sm_on_data_port_open (struct mlme_sm *sm);                                                 /* mlme.c */
void mlme_sm_on_disassoc (struct mlme_sm *sm, struct rx_pkt *pkt);                                   /* mlme.c */
void mlme_sm_on_disconnect (struct mlme_sm *sm, struct rx_pkt *pkt, u32 reason, u32 cb);             /* mlme.c */
void mlme_sm_on_rm_channel_locked (struct mlme_sm *sm, u32 req);                                     /* mlme.c */
void mlme_sm_on_waitfor_ctrl_assoc_res (struct mlme_sm *sm);                                         /* mlme.c */
void mlme_sm_on_waitfor_ctrl_del_sta (struct mlme_sm *sm);                                           /* mlme.c */
void mlme_sm_send_disassoc (struct mlme_sm *sm, u32 reason, tx_done_fn cb);                          /* mlme.c */
u32 new_link_evt (void);                                                                             /* lmac_evt.c */
void notify_conn_flush_done (struct fwq_tx *q, u32 cid);                                             /* fwq_tx.c */
u32 obj_has_pending_1c_10 (const struct vring_schd *s);                                              /* vring.c */
void obj_set_field4_one (struct mid_bss *obj);                                                       /* discovery.c */
void obj_vt802458_ctor (struct mlme_sm *a, struct conn *conn);                                       /* discovery.c */
void obj_vt802744_ctor (struct conn_msm *a, struct conn *conn);                                      /* discovery.c */
void obj_vt80296c_ctor (struct stream_sm *s, struct stream_ctx *p);                                  /* tx_helpers.c */
void obj_vt802b50_ctor (struct ba_setup_sm *s, struct stream_sm *p);                                 /* tx_helpers.c */
void obj_vt802cc4_ctor (struct maintain_sm *a, struct lm_sm *l);                                     /* discovery.c */
void obj_vt802cc4_noop_vmethod (struct maintain_sm *a);                                              /* discovery.c */
void obj_vt802da0_ctor (struct lm_sm *a, struct lm_if *lm);                                          /* discovery.c */
void obj_vt802f58_ctor (struct link_stats_sm *a, struct maintain_sm *m);                             /* discovery.c */
void obj_vt803210_ctor (struct rm_main_sm *sm, struct radio_mgr *rm, struct rm_queue *queue);        /* radio_mgr.c */
u32 oob_mode_flags (const struct basic_sm *sm);                                                      /* wmi_cmd.c */
void operational_if_evt_send (u32 payload, u32 evt, u32 len, u32 mid, u32 a4, u32 a5, u32 a6);       /* discovery.c */
struct operational_mbox *operational_if_get_mbox (void);                                             /* stubs.c */
void operational_if_init_mbox_ptr (void);                                                            /* stubs.c */
struct operational_mbox *operational_if_mbox_init (mbox_evt_send_fn handler);                        /* stubs.c */
void otp_init (void);                                                                                /* otp.c */
const struct wil_vs_tlv *parse_wilocity_vs_find_tlv (u32 a0, const struct ie_ref *buf, u32 type);    /* mac_parser.c */
u32 parse_wilocity_vs_get_features_version_tracking (u32 a0, const struct ie_ref *buf);              /* mac_parser.c */
u32 parse_wilocity_vs_get_flag3 (u32 a0, const struct ie_ref *buf);                                  /* mac_parser.c */
u32 parse_wilocity_vs_get_version (u32 a0, const struct ie_ref *buf);                                /* mac_parser.c */
u32 pcie_ack_8e026c (void);                                                                          /* pcie.c */
void pcie_apply_mode_fw_8825c0 (u32 mode);                                                           /* power_halt.c */
void pcie_bits_set32_s2_w4 (u32 *p, u32 a, u32 b);                                                   /* pcie.c */
void pcie_clear_880c50_b2 (u32 a);                                                                   /* power.c */
void pcie_d3_d0_int_en (void);                                                                       /* pcie.c */
void pcie_dbi_ack_done (void);                                                                       /* pcie.c */
u32 pcie_dbi_read (u32 addr, u32 sz, u32 a2, u32 a3, u32 a4, u32 a5, u32 *out);                      /* pcie.c */
void pcie_dbi_set_addr (u32 v);                                                                      /* pcie.c */
void pcie_dbi_set_data (u32 v);                                                                      /* pcie.c */
void pcie_dbi_start_cmd (u32 a, u32 b, u32 c);                                                       /* pcie.c */
u32 pcie_dbi_transfer (u32 addr, u32 data, u32 sz, u32 a3, u32 a4, u32 a5, u32 a6, u32 a7, u32 a8);  /* pcie.c */
void pcie_enter_d3_int_en (void);                                                                    /* pcie.c */
void pcie_fix_max_read_req (void);                                                                   /* pcie.c */
void pcie_force_clear_l0s (void);                                                                    /* pcie.c */
void pcie_hp_ctrl_write_bit (u32 bit, u32 val);                                                      /* pcie.c */
void pcie_isr_code0_timer_task (u32 a0, u32 a1);                                                     /* vectors.c */
void pcie_l1ss_enable (void);                                                                        /* pcie.c */
void pcie_lp_set_byte_field (u32 bit, u32 val);                                                      /* pcie.c */
void pcie_mask_interrupts (void);                                                                    /* pcie.c */
void pcie_mask_l1_enter_irq (void);                                                                  /* pcie.c */
void pcie_mirror_link_bit (void);                                                                    /* pcie.c */
void pcie_perst_assert_int_en (void);                                                                /* pcie.c */
void pcie_perst_deassert_int_clear (void);                                                           /* pcie.c */
void pcie_perst_deassert_int_en (void);                                                              /* pcie.c */
void pcie_pm_host_config (void);                                                                     /* pcie.c */
void pcie_program_seq_fw_8825c0 (u32 v);                                                             /* pcie.c */
u32 pcie_read_app_debug_if (void);                                                                   /* link_diag.c */
void pcie_serdes_clear_flag_if_bit1 (void);                                                          /* pcie.c */
void pcie_serdes_init (void);                                                                        /* pcie.c */
void pcie_serdes_init_seq (void);                                                                    /* pcie.c */
void pcie_serdes_program_all (void);                                                                 /* pcie.c */
void pcie_set_880c50_b12 (u32 a);                                                                    /* power.c */
void pcie_set_event_bit (u32 bit);                                                                   /* host_irq.c */
void pcie_set_event_bit_19 (void);                                                                   /* host_irq.c */
void pcie_set_l1_bit11 (u32 *p);                                                                     /* mac_ext.c */
void pcie_toggle_880c50_bit2 (u32 on);                                                               /* mac_ext.c */
u32 pcie_wait_882644_ready (void);                                                                   /* pcie.c */
void pcp_bcon_wb (u32 payload, u32 status, u32 conn);                                                /* stubs.c */
void pcp_ready_timer_cb (u32 a0, u32 a1);                                                            /* conn.c */
void pcp_restart (struct mid_disc *o);                                                               /* conn.c */
void peer_check_flag_30 (struct ll_ageing_det *obj);                                                 /* discovery.c */
void periodic_service_run (struct psvc *svc);                                                        /* link_loss.c */
void periodic_service_start (struct psvc *svc, u32 mode);                                            /* link_loss.c */
u32 periodic_service_tick (struct psvc *svc, u32 delay);                                             /* link_loss.c */
void periodic_service_timer_expired (u32 a0, u32 a1);                                                /* link_loss.c */
u32 phy_get_88306c_6bit (void);                                                                      /* phy_ext.c */
u32 phy_get_88312c_6bit (void);                                                                      /* phy_ext.c */
u32 phy_get_885178_3bit (void);                                                                      /* phy_ext.c */
u32 phy_get_ina_rssi_adc_db (void);                                                                  /* calib_hw.c */
u32 phy_get_rx_ina_det_mode (void);                                                                  /* calib_hw.c */
void phy_load_88416c_table (u32 a);                                                                  /* phy.c */
void phy_monitor_on_system_state (struct phy_monitor *obj, u32 st, u32 idle, u32 conn);              /* phy_monitor.c */
void phy_program_channel_regs (u32 ch);                                                              /* phy.c */
void phy_read_rx_counters (u32 *out);                                                                /* calib_hw.c */
u32 phy_rx_read_rssi_adc (void);                                                                     /* phy_ext.c */
u32 phy_rx_read_rssi_adc_locked (void);                                                              /* phy_ext.c */
void phy_set_885178_3bit (u32 v);                                                                    /* phy_ext.c */
void phy_stats_dump (struct psvc *svc, u32 cnt);                                                     /* phy_monitor.c */
u32 platform_is_asic (void);                                                                         /* platform.c */
u32 platform_is_fpga (void);                                                                         /* platform.c */
void power_halt_seq (u32 a, struct ps_ctx *b);                                                       /* power.c */
void power_mngr_check_mode (u32 a);                                                                  /* power.c */
void power_mngr_init (void);                                                                         /* power.c */
void power_start_two_timers (void);                                                                  /* power.c */
struct vring_rec *pring_find_by_id (u32 vr);                                                         /* vring.c */
void pring_init_pool (void);                                                                         /* vring.c */
void pring_isr_dispatch (void);                                                                      /* vectors.c */
void pring_set_done_handler (pring_done_fn fn, u32 arg);                                             /* vring.c */
void pring_task_8e0ecc (u32 idx, u32 a1);                                                            /* vectors.c */
void pring_task_8e0edc (u32 idx, u32 a1);                                                            /* vectors.c */
void pring_task_8e0eec (u32 idx, u32 a1);                                                            /* vectors.c */
void print_input_filter_params (struct fw_sysapi_mgr *self, const u8 *p, u32 x);                     /* misc_ext_sysapi.c */
u32 probe_resp_ind (struct scan_mngr *scan, const void *bssid, const void *sa, u32 channel, u32 rssi, u32 snr); /* discovery.c */
void probe_resp_ind_done_cb (u32 payload, u32 status, u32 conn);                                     /* discovery.c */
void ps_mark_data_pending (u32 idx, u32 flag);                                                       /* fwq_tx.c */
void psc_req_reject (u32 cid, const u8 *f);                                                          /* action.c */
u32 push_cap_info (u8 *dst, const u8 *src);                                                          /* mgmt_tx.c */
void qdesc_build_by_type (struct macq_ba_desc *d, u32 type, u32 a2, u32 a3, u32 a4, u32 a5, u32 a6); /* mac_bringup.c */
u32 qdesc_cfg_is_override (void);                                                                    /* rx_chain.c */
void qh_write_by_flags_fw (u32 a, u32 b, struct macq_qdesc *c, u32 d);                               /* tx_helpers.c */
u32 qh_write_or_conn_alloc (u32 a, u32 b, struct macq_qdesc *c, u32 d);                              /* tx_helpers.c */
void queue_deleted_evt (const struct lmac_evt_queue_deleted *e);                                     /* lmac_evt.c */
u32 radio_get_channel (struct rf_obj *a);                                                            /* power.c */
void radio_mgr_alloc_request (struct mid_bss *obj, u32 idx);                                         /* misc_ext.c */
void radio_mgr_call_method_10 (struct rm_req *req);                                                  /* wmi_cmd.c */
u32 radio_mgr_get_current_channel (u32 *ch);                                                         /* rx.c */
void radio_mgr_init_global (void);                                                                   /* radio_mgr.c */
void radio_mgr_init_list (struct rm_queue *q, struct radio_mgr *owner);                              /* radio_mgr.c */
void radio_mgr_install_vtable (void);                                                                /* radio_mgr.c */
void radio_mgr_remove_request (struct rm_req *req);                                                  /* mlme.c */
void radio_mgr_req_callback_task (u32 req, u32 a1);                                                  /* radio_mgr.c */
struct rm_req *radio_mgr_request (rm_req_cb cb, u32 arg, u32 param, u32 ch, u32 mid);                /* lmac_evt.c */
void radio_mgr_set_primary_channel (u32 ch, u32 rx_on_w0, u32 rx_on_w4, u32 bcn_int, u32 sta_role, u32 mid); /* wmi_cmd.c */
void radio_mgr_unset_primary_channel (void);                                                         /* scan.c */
void radio_mgr_vt_callback (struct radio_mgr *self, struct rm_req *req);                             /* radio_mgr.c */
u32 radio_mgr_vt_cur_mid (struct radio_mgr *self);                                                   /* lmac_evt.c */
u32 radio_mgr_vt_get_channel (struct radio_mgr *self, u32 *out);                                     /* radio_mgr.c */
void radio_mgr_vt_inject_lock_evt (struct radio_mgr *self, u32 evt);                                 /* lmac_evt.c */
void radio_mgr_vt_lock_free (struct radio_mgr *self, struct rm_req *req);                            /* radio_mgr.c */
void radio_mgr_vt_release (struct radio_mgr *self, struct rm_req *req);                              /* radio_mgr.c */
struct rm_req *radio_mgr_vt_request_primary (struct radio_mgr *self, rm_req_cb cb, u32 arg, u32 mid); /* radio_mgr.c */
struct rm_req *radio_mgr_vt_request_secondary (struct radio_mgr *self, rm_req_cb cb, u32 arg, u32 param, u32 ch, u32 mid); /* radio_mgr.c */
void radio_mgr_vt_sec_tune (struct radio_mgr *self, rm_req_cb cb, u32 arg, struct rm_req *req, u32 param, u32 ch, u32 mid); /* radio_mgr.c */
void radio_mgr_vt_set_primary (struct radio_mgr *self, u32 set, u32 ch, u32 rx_on_w0, u32 rx_on_w4, u32 bcn_int, u32 sta_role, u32 mid); /* radio_mgr.c */
struct scan_mngr *radio_req_addr_of (u32 i);                                                         /* mid.c */
u32 regd_is_country_not_jp (void);                                                                   /* power.c */
u32 regd_is_country_us (void);                                                                       /* power.c */
u32 regd_is_unset_or_jp (void);                                                                      /* power.c */
void regulatory_domain_set_country_code (u32 v);                                                     /* discovery.c */
u32 remove_app_ie (u32 obj, u32 idx, u32 flag);                                                      /* stubs.c */
void return_field_type (const struct lmac_evt_field_rsp *e);                                         /* lmac_evt.c */
void rf_boardfile_read_platform_info (struct rf_obj *a, u32 *out0, u32 *out1, u32 *out2);            /* rf.c */
u32 rf_cfg_get_rf_mask_45e (struct rf_obj *p);                                                       /* rf.c */
void rf_chain_bits_set32_s22_w2 (u32 *p, u32 v);                                                     /* rf_sector.c */
void rf_chain_bits_set32_s29_w2 (u32 *p, u32 v);                                                     /* rf_sector.c */
void rf_chain_program_sector_desc (struct macq_sector_desc *d, u32 mode, u32 a2, u32 a3, u32 a4, u32 a5); /* mac_bringup.c */
void rf_chain_zero_and_program (u32 v);                                                              /* rf_sector.c */
u32 rf_check_rf_id (u32 rf, u32 name, u32 flag);                                                     /* otp.c */
void rf_check_state (const struct calib_silent_rssi *obj);                                           /* stubs.c */
u32 rf_comm_test (struct rf_obj *base, u8 idx);                                                      /* stubs.c */
u32 rf_configure_chain (u32 a, u32 b);                                                               /* rf.c */
u32 rf_configure_role_power (struct rf_obj *this);                                                   /* rf.c */
u32 rf_get_active_index (void);                                                                      /* stubs.c */
u32 rf_get_connected_mask (struct rf_obj *a);                                                        /* rf.c */
void rf_identify_type (struct rf_obj *this);                                                         /* rf.c */
u32 rf_if_num_tx_sectors (struct rf_obj *rf);                                                        /* brd_if.c */
const u8 *rf_if_tx_sectors (struct rf_obj *rf);                                                      /* lmac.c */
u32 rf_is_present (void);                                                                            /* rf.c */
void rf_kill_ack_irq (void);                                                                         /* isr.c */
void rf_kill_irq_task (u32 a0, u32 a1);                                                              /* isr.c */
void rf_kill_mask_irq (void);                                                                        /* isr.c */
void rf_kill_sm_init (u32 o);                                                                        /* l2mgr.c */
void rf_kill_unmask_irq (void);                                                                      /* isr.c */
u32 rf_mask_count_modules (const struct calib_est *rfm);                                             /* calib.c */
void rf_mgmt_sm_w_disable_disabled (u32 sm, u32 sw);                                                 /* rf_kill.c */
void rf_mgmt_sm_w_disable_enabled (u32 sm, u32 sw);                                                  /* rf_kill.c */
void rf_mgmt_sm_w_disable_pending (u32 sm, u32 sw);                                                  /* rf_kill.c */
void rf_mgmt_sm_w_enable_disabled (u32 sm, u32 sw);                                                  /* rf_kill.c */
void rf_mgmt_sm_w_enable_enabled (u32 sm, u32 sw);                                                   /* rf_kill.c */
void rf_power_off (void);                                                                            /* stubs.c */
void rf_restore_if_needed (u32 a);                                                                   /* stubs.c */
void rf_sector_commit_rx (u32 a, u32 b);                                                             /* calib_hw.c */
void rf_sector_commit_tx (u32 a, u32 b);                                                             /* calib_hw.c */
void rf_set_889494_low_nibble (u32 on);                                                              /* rf.c */
void rf_set_8894a0_field (u32 v);                                                                    /* calib_hw.c */
void rf_set_txrx_sets_save_fw (u32 a, u32 b, u32 *out1, u32 *out2);                                  /* rf.c */
void rf_tbl_lookup_by_module (const struct brd_if *o, u32 mod, u32 idx, u8 *start, u8 *cnt);         /* brd_if.c */
u32 rf_type_is_known (void);                                                                         /* rf.c */
u32 rf_type_is_marlon (void);                                                                        /* rf.c */
u32 rf_type_is_sparrow_r (void);                                                                     /* rf.c */
u32 rf_utils_auto_fill (const struct rf_auto_fill *buf, u32 mode);                                   /* rf.c */
u32 rf_utils_auto_fill_8021c8 (u32 rf, u32 mode);                                                    /* rf.c */
void rf_utils_auto_fill_set_pattern (const struct rf_auto_fill *buf);                                /* rf.c */
void rf_utils_fill_default_patterns (struct rf_obj *this);                                           /* rf.c */
void rfc_collect_rx_crc_stats (u32 mask, u32 *out);                                                  /* rf_sector.c */
void rfc_field_write (u32 p, u32 field, u32 val, u32 mask);                                          /* rf.c */
void rfc_pack_field_value (u32 unused, const u32 *src, u32 *dst, u32 a, u32 b, u32 c);               /* calib_hw.c */
void rfc_probe_modules (u32 mask, u8 *out);                                                          /* rf_sector.c */
u32 rfc_read_calib_block (u32 n);                                                                    /* rf.c */
u32 rfc_read_calib_get_min_failures (u32 *arr);                                                      /* rf.c */
u32 rfc_read_core_result_fw (u32 field, u32 *result);                                                /* rf.c */
void rfc_read_field_484 (u32 rf, u32 *out);                                                          /* calib_hw.c */
u32 rfc_read_or_dead (void);                                                                         /* rf.c */
void rfc_read_sector_params (u32 rf, u32 idx, u32 sel, u32 *o0, u32 *o1, u32 *o2, u32 *o3, u32 *o4, u32 *o5); /* wmi_h_bf.c */
void rfc_restore_txrx_sets_fw (void);                                                                /* rf.c */
void rfc_tx_power_tbl_load (void);                                                                   /* rf.c */
void rfc_write_chain_field (u32 p, u32 a, u32 b, u32 c);                                             /* rf.c */
void rfc_write_core_reg6 (u32 a, u32 b);                                                             /* rf.c */
void rfc_write_field_1136 (u32 a);                                                                   /* rf.c */
void rfc_write_field_434_2ec33 (void);                                                               /* rf.c */
void rfc_write_field_484 (u32 a0, u32 *in);                                                          /* rf.c */
void rfc_write_gain_idx_reg504 (const struct rf_obj *p, u32 a, u32 b);                               /* calib_hw.c */
void rfc_write_packed_fields (u32 a0, u32 a1, u32 a2, u32 a3, u32 a4, u32 a5, u32 a6, u32 a7);       /* rf.c */
u8 rfca_get_rf_mask (void);                                                                          /* rf.c */
void rfca_touch_rf_module (const struct calib_silent_rssi *obj, u32 bit, u32 flag);                  /* car.c */
void ring_init_desc (struct mbox_ring *r, struct mbox_entry *base, u32 len, struct mbox_ring_hw *hw, struct mem_pool *pool, u32 alloc, u32 pooled); /* pool.c */
u32 ring_is_full (const struct fw_mailbox *mb);                                                      /* scan_mngr.c */
void rm_ch_switch_sm_ch_switch_completed (struct rm_ch_switch_sm *cs);                               /* radio_mgr.c */
void rm_ch_switch_sm_desc_set_id (void);                                                             /* radio_mgr.c */
void rm_ch_switch_sm_fwtx_channel_stopped (void);                                                    /* fwq_tx.c */
void rm_ch_switch_sm_kick (struct rm_ch_switch_sm *cs, struct rm_chan *params);                      /* radio_mgr.c */
struct pring *rm_ch_switch_sm_notify_ch_switch_done (struct vring_schd *s, u32 t);                   /* vring.c */
void rm_ch_switch_sm_on_data_stopped (struct rm_ch_switch_sm *cs);                                   /* radio_mgr.c */
void rm_ch_switch_sm_on_fwtx_stopped (struct rm_ch_switch_sm *cs);                                   /* radio_mgr.c */
void rm_ch_switch_sm_on_ucode_rx_off (struct rm_ch_switch_sm *cs);                                   /* radio_mgr.c */
void rm_ch_switch_sm_on_ucode_rx_on (struct rm_ch_switch_sm *cs);                                    /* radio_mgr.c */
void rm_ch_switch_sm_switch_on (struct rm_ch_switch_sm *cs);                                         /* radio_mgr.c */
void rm_invalidate_tune_slot (struct rm_main_sm *sm);                                                /* radio_mgr.c */
void rm_main_sm_call_cb (struct rm_main_sm *sm, struct rm_req *req);                                 /* radio_mgr.c */
void rm_main_sm_enter_primary_non_locked (struct rm_main_sm *sm);                                    /* radio_mgr.c */
void rm_main_sm_get_next_prim_request (struct rm_main_sm *sm);                                       /* radio_mgr.c */
void rm_main_sm_get_next_request (struct rm_main_sm *sm);                                            /* radio_mgr.c */
void rm_main_sm_handle_lock_evt (struct rm_main_sm *sm, u32 evt);                                    /* lmac_evt.c */
void rm_main_sm_inject_lock_evt (u32 evt);                                                           /* lmac_evt.c */
void rm_main_sm_lock_primary (struct rm_main_sm *sm);                                                /* radio_mgr.c */
void rm_main_sm_mark_as_pending_removal (struct rm_main_sm *sm, struct rm_req *req);                 /* radio_mgr.c */
void rm_main_sm_primary_handle_free (struct rm_main_sm *sm, struct rm_req *req);                     /* radio_mgr.c */
void rm_main_sm_secondary_handle_free (struct rm_main_sm *sm, struct rm_req *req);                   /* radio_mgr.c */
void rm_main_sm_secondary_tune_done (struct rm_main_sm *sm, u32 ch, u32 param, u32 mid);             /* radio_mgr.c */
void rm_main_sm_switch_2_secondary (struct rm_main_sm *sm);                                          /* radio_mgr.c */
void rm_sm_desc_set_id (void);                                                                       /* radio_mgr.c */
void rm_sm_goto_idle (void);                                                                         /* radio_mgr.c */
void rm_sm_lock_secondary (struct rm_main_sm *sm);                                                   /* radio_mgr.c */
void rm_sm_primary_tune_done (struct rm_main_sm *sm, u32 ch, u32 param, u32 mid);                    /* radio_mgr.c */
void rm_sm_secondary_retune (struct rm_main_sm *sm, struct rm_req *req);                             /* radio_mgr.c */
void rm_sm_set_primary_and_switch (struct rm_main_sm *sm, const struct rm_chan *req);                /* radio_mgr.c */
void rm_sm_store_primary (struct rm_main_sm *sm, const struct rm_chan *req);                         /* radio_mgr.c */
void rm_sm_switch_2_primary (struct rm_main_sm *sm);                                                 /* radio_mgr.c */
void rm_sm_unset_primary_and_switch (struct rm_main_sm *sm);                                         /* radio_mgr.c */
u32 rx_api_drain_all_lists (struct ring_idx *ctx);                                                   /* rx_chain.c */
void rx_api_drain_list_drain (u32 idx, u32 a1);                                                      /* rx.c */
void rx_api_drain_list_init (struct rx_desc *d, u32 mask, u32 arg2, u32 arg3);                       /* rx.c */
void *rx_buf_alloc (void);                                                                           /* rx_chain.c */
void rx_chain_bits_set16h_s0_w12 (u16 *p, u32 v);                                                    /* rx_chain.c */
void rx_chain_build_desc (u32 *desc, u8 mode, u32 a2, u32 a3, u32 a4, u32 a5, u32 a6);               /* rx_chain.c */
void rx_chain_build_desc_b (void *desc, u32 mode, u32 value);                                        /* rx_chain.c */
void rx_chain_configure (u32 cfg, u32 a1, u32 a2, u32 a3, u32 a4);                                   /* rx_chain.c */
void rx_chain_configure_b (u32 cfg, u32 a1);                                                         /* rx_chain.c */
u32 rx_chain_get_cfg_mode (void);                                                                    /* wmi_cmd.c */
u32 rx_chain_reg_8813c8_addr (void);                                                                 /* rx_chain.c */
void rx_chain_set_payload_size (u32 v);                                                              /* dma_ring.c */
s32 rx_energy_calc_rssi_q4 (u32 adc, u32 gain, u32 a2, u32 a3);                                      /* phy_ext.c */
void rx_macq_bind_all_queues (u32 macq, u32 ring, u32 enable);                                       /* dma_ring.c */
void rx_macq_bind_queue (u32 macq_idx, u32 qtype, u32 ring_idx, u32 enable);                         /* dma_ring.c */
void rx_macq_bits_set32_s21_w5 (void *p, u32 v);                                                     /* mac_ext.c */
void rx_macq_bits_set32_s26_w2 (void *p, u32 v);                                                     /* mac_ext.c */
void rx_macq_build_ba_desc (struct macq_desc *dst, u32 len, const struct rx_ba_win_params *w, u32 mode); /* rx_chain.c */
u32 rx_macq_entry_addr (u32 idx);                                                                    /* macq.c */
u32 rx_macq_get_cfg_word (void);                                                                     /* macq.c */
void rx_macq_init (void);                                                                            /* l2mgr.c */
void rx_macq_pack_desc (u32 *desc, u32 a1, u32 a2, u32 a3, u32 a4, u32 a5, u32 a6, u32 a7);          /* rx_chain.c */
void rx_macq_program_ba_win (u32 cfg, u32 a1, u32 a2, u32 a3, u32 a4, u32 a5);                       /* rx_chain.c */
void rx_macq_program_desc_848018 (u32 cfg, u32 a1, u32 a2, u32 a3, u32 a4);                          /* rx_chain.c */
void rx_macq_program_desc_for_conn (struct conn *conn);                                              /* conn.c */
void rx_macq_program_offload_desc (void *p);                                                         /* rx_chain.c */
void rx_macq_program_offload_desc_with_b4 (u8 *p, u32 b4);                                           /* rx_chain.c */
void rx_macq_setup (u32 cfg, u32 mode, u32 a2, u32 a3, u32 a4, u32 a5, u32 a6, u32 a7, u32 a8);      /* macq.c */
void rx_mgmt_action_no_ack (struct rx_pkt *pkt);                                                     /* rx.c */
struct rx_mgmt_ei *rx_mgmt_find_free_ei (struct rx_pkt_srvs *ctx);                                   /* rx_mgmt.c */
u32 rx_mgmt_prepare (struct rx_pkt *pkt);                                                            /* rx_mgmt.c */
u32 rx_mgmt_prs_alloc_ei (struct rx_pkt_srvs *ctx, struct rx_pkt *pkt);                              /* rx_mgmt.c */
u32 rx_mgmt_prs_parse (struct rx_pkt_srvs *ctx, u8 *p, struct rx_mgmt_ei *ei, s32 len, u32 subtype, u32 type); /* rx_mgmt.c */
u32 rx_mgmt_prs_step (struct rx_pkt_srvs *ctx, u8 *p, struct rx_mgmt_ei *ei, s32 *len, u8 *cnt);     /* rx_mgmt.c */
void rx_mgmt_srvs_distribute (struct rx_pkt_srvs *obj, struct rx_pkt *pkt);                          /* rx.c */
void rx_pkt_handler (struct rx_pkt *pkt);                                                            /* mlme.c */
void rx_pkt_lookup_handler (struct rx_pkt_srvs *ctx, u8 *out);                                       /* rx.c */
void rx_pkt_mid_accepts (struct rx_pkt_srvs *obj, struct rx_pkt *pkt);                               /* rx.c */
void rx_pkt_srvs_dispatch (struct rx_pkt_srvs *obj, struct rx_pkt *pkt);                             /* rx.c */
void rx_pkt_srvs_dispatch_default (struct rx_pkt *pkt);                                              /* rx.c */
void rx_pkt_srvs_dispatch_thunk (const struct rx_pkt_srvs_vt2 **base2, struct rx_pkt *pkt);          /* vt_misc.c */
void rx_pkt_srvs_distribute_data (struct rx_pkt_srvs *obj, struct rx_pkt *pkt);                      /* rx.c */
void rx_pool_configure_ring (struct rx_ring *c, u32 r, u32 n, u32 m);                                /* l2mgr.c */
u32 rx_pool_configure_step (struct rx_dma_ring *p, u32 list, u32 count, u32 dma_ring);               /* rx_chain.c */
void rx_pool_init (void);                                                                            /* l2mgr.c */
void rx_pool_set_fields (struct ring_idx *p, u32 base, u32 size);                                    /* rx_chain.c */
void scan_abort (struct mid_disc *obj);                                                              /* wmi_cmd.c */
void scan_mngr_abort_scan (struct scan_mngr *obj);                                                   /* wmi_cmd.c */
void scan_mngr_calculate_passive_scan_info (struct scan_mngr *scan, u32 ch);                         /* scan.c */
void scan_mngr_clean_all_lists (struct scan_mngr *scan);                                             /* scan.c */
void scan_mngr_config_dwell_time (struct scan_mngr *scan, u32 dwell);                                /* scan.c */
void scan_mngr_connect (struct scan_mngr *scan, struct dband_info *e);                               /* scan_mngr.c */
void scan_mngr_connect_task (u32 a0, u32 a1);                                                        /* scan_mngr.c */
u32 scan_mngr_dband_beacon_ind (struct scan_mngr *scan, struct rx_pkt *pkt, u32 a2);                 /* scan_mngr.c */
void scan_mngr_dwelling_done (struct scan_mngr *scan, u32 flag);                                     /* scan.c */
struct channels_switch_sm *scan_mngr_entry_addr (u32 i);                                             /* mid.c */
void scan_mngr_free_channel_list (struct scan_mngr *obj);                                            /* wmi_cmd.c */
void scan_mngr_handle_abft_bf_result_in_scan (struct scan_mngr *s, const struct lmac_evt_bf_done *e); /* bf_result.c */
void scan_mngr_handle_link_up_event (struct scan_mngr *scan, struct conn *conn, u32 v);              /* conn.c */
void scan_mngr_init (struct scan_mngr *o, struct mid *e);                                            /* mid.c */
void scan_mngr_kick_scan_state_machine (struct scan_mngr *obj);                                      /* discovery.c */
void scan_mngr_prob_done (struct scan_mngr *scan, u32 reason, struct dband_info *entry);             /* discovery.c */
void scan_mngr_prob_timeout_cb (u32 a0, u32 a1);                                                     /* scan_mngr.c */
void scan_mngr_probe_req_tx_done_cb (u32 payload, u32 status, u32 a2);                               /* scan_mngr.c */
void scan_mngr_resume_scan (struct scan_mngr *obj);                                                  /* discovery.c */
void scan_mngr_save_initial_passive_scan_info (struct scan_mngr *scan, u32 ch);                      /* scan.c */
void scan_mngr_scan_done (struct scan_mngr *scan, u32 status);                                       /* scan.c */
void scan_mngr_send_prob_req (struct scan_mngr *scan, struct dband_info *e);                         /* scan_mngr.c */
u32 scan_mngr_set_rx_omni_sector (struct scan_mngr *scan);                                           /* scan.c */
void scan_mngr_sm_dwelling_ended (struct scan_mngr *scan);                                           /* scan.c */
void scan_mngr_sm_ready_for_dwelling (struct scan_mngr *scan);                                       /* scan.c */
void scan_mngr_sm_stopped_task (u32 a0, u32 a1);                                                     /* scan.c */
void scan_mngr_start_dwelling_task (u32 a0, u32 a1);                                                 /* scan.c */
void scan_mngr_start_scan (struct scan_mngr *scan, u8 *cmd, u32 a2, u32 a3);                         /* scan.c */
void scan_mngr_stop_dwelling (struct scan_mngr *scan);                                               /* scan.c */
void scan_mngr_system_state_evt_handler (u32 st, u32 arg);                                           /* l2mgr.c */
void scan_mngr_update_connected_scan_time (struct scan_mngr *scan);                                  /* scan.c */
u32 scan_mngr_update_step (struct scan_mngr *scan);                                                  /* scan.c */
void scan_resume (struct mid_disc *obj);                                                             /* discovery.c */
void scan_stop (struct mid_disc *obj);                                                               /* wmi_cmd.c */
u32 sched_alloc_changed (struct sched_scheme *obj, const struct ese_alloc *a, u32 c);                /* rx.c */
void sched_alloc_entry (const u32 *p, u32 tsf);                                                      /* misc_ext_sysapi.c */
void sched_apply_entry (struct fw_sysapi_mgr *req, const u32 *a1, const u32 *a2, u32 a3);            /* misc_ext_sysapi.c */
void sched_builder_build_if_present (struct sched_scheme *a);                                        /* rx.c */
void sched_builder_reset_alloc_list (struct ese_sched *a);                                           /* stubs.c */
void sched_program_alloc_slot_regs (u32 a, u32 b, u32 c);                                            /* rx.c */
void sched_step (struct operational_mbox **a, mbox_evt_send_fn b);                                   /* stubs.c */
void schedule_scheme_builder_build_allocations (struct sched_scheme *a);                             /* stubs.c */
void schedule_scheme_builder_build_allocations_from_beacon (struct sched_scheme *obj, const struct ie_ref *bcn); /* rx.c */
void schedule_scheme_sum_two (struct sched_scheme *obj);                                             /* rx.c */
void sdp_drive_pin_timed (u32 v);                                                                    /* hw_init.c */
void sdp_gpio_boot_init (void);                                                                      /* hw_init.c */
u32 sdp_gpio_personality_step (u32 i);                                                               /* hw_init.c */
u32 sdp_read_880b98_bit (u32 i);                                                                     /* misc_ext.c */
void sdp_set_defined_bit (u32 on, u32 bit);                                                          /* hw_init.c */
void sdp_set_level_and_init (u32 i, u32 v);                                                          /* misc_ext.c */
u32 sector_list_validate (struct ss_cfg_s *dst, const u8 *list, u32 a, u32 b);                       /* lmac.c */
void send_ba_status_report (const struct stream_ctx *ctx, u32 ringid, u32 status, u32 agg, u32 timeout, u32 amsdu); /* ba.c */
void set_old_wilocity_vs (struct mid_bss *dst, const struct wil_vs_old *src, u32 a2, u32 a3);        /* mac_parser.c */
s32 set_parse_ei (struct rx_pkt_srvs *ctx, u8 *p, struct rx_mgmt_ei *ei, u32 eid, u32 len, u32 rem, u32 type); /* rx_mgmt.c */
void set_rf_sector_params_handle (struct wmi_rf_sector_set_req *self);                               /* wmi_h_bf.c */
u32 set_rf_sector_params_set (struct wmi_rf_sector_set_req *self, const struct wmi_set_rf_sector_params_cmd *cmd, struct wmi_mbox *mb); /* wmi_h_bf.c */
u32 set_selected_rf_sector_index_set (struct rf_sector_sel_req *self, const struct wmi_set_selected_rf_sector_index_cmd *cmd, struct wmi_mbox *mb); /* wmi_h_bf.c */
void set_vendor_specific_version (struct conn *conn, struct rx_pkt *pkt, struct mid *bss_ctx);       /* discovery.c */
u32 silent_rssi_agc_param_const_2 (const struct calib_silent_rssi *obj, u32 idx);                    /* calib.c */
u32 silent_rssi_agc_param_const_4 (const struct calib_silent_rssi *obj, u32 idx);                    /* calib.c */
void silent_rssi_bits_set32_s0_w6 (u32 *p, u32 v);                                                   /* calib.c */
void silent_rssi_bits_set32_s12_w4 (u32 *p, u32 v);                                                  /* calib.c */
u32 silent_rssi_calibrate_single_rf_module (struct calib_silent_rssi *obj, u32 mask, u32 module_idx, const struct calib_est *rfm); /* calib.c */
u32 silent_rssi_hist_window_index (struct calib_silent_rssi *obj, u32 idx);                          /* calib.c */
void silent_rssi_load_params_a (struct calib_silent_rssi *obj);                                      /* calib.c */
void silent_rssi_load_params_b (struct calib_silent_rssi *o);                                        /* calib.c */
void silent_rssi_report_agc_tables (void);                                                           /* calib.c */
void silent_rssi_set_agc_search_window (u32 start, u32 arr);                                         /* calib.c */
void silent_rssi_set_rf_gain_index (struct calib_silent_rssi *obj, u32 idx, u32 a2, u32 a3, u32 a4, u32 a5); /* calib.c */
void sm_action_nop (void);                                                                           /* power.c */
void sm_action_nop_b (void);                                                                         /* power.c */
void sm_defer_call (void *obj, u32 event, u32 a2, u32 a3, u32 a4);                                   /* calib.c */
void sm_init_defer_pool (void);                                                                      /* stubs.c */
void sm_null_handler (struct fwq_tx *q);                                                             /* fwq_tx.c */
void sm_obj_store_desc (struct stream_ctx *d, u8 vr, struct conn *conn, u8 tid, u32 ba_en, u8 tbl_vr, u8 pring_type, u32 mid, u32 bcast); /* stream_mgr.c */
void sm_pring_all_wb_done_evt (const struct vring_tbl_entry *e, struct macq_qdesc *buf);             /* tx_queue.c */
void sm_pring_bind_vring (struct pring *p, u32 vr, u32 a2, u32 a3, u32 a4, struct vring_rec *entry); /* vring.c */
struct pring *sm_pring_by_index (u32 i);                                                             /* vring.c */
void sm_pring_cancel_timers (struct pring *p);                                                       /* vring.c */
void sm_pring_connectivity_task (u32 e, u32 i);                                                      /* vring.c */
void sm_pring_connectivity_update (struct pring *p, struct vring_rec *e);                            /* vring.c */
void sm_pring_count_and_sync_dma_wptr (struct pring *p);                                             /* vring.c */
void sm_pring_latch_tx_counters (void);                                                              /* vring.c */
void sm_pring_notify_step (struct vring_rec *e, u32 a);                                              /* vring.c */
void sm_pring_notify_vring_state (u32 i, struct vring_rec *e);                                       /* vring.c */
void sm_pring_slot_optimized (struct pring *p, struct vring_rec *e);                                 /* vring.c */
void sm_pring_slot_optimized_task (u32 e, u32 i);                                                    /* vring.c */
void sm_pring_state_step (struct pring *p);                                                          /* vring.c */
void sm_pring_stop_done (struct pring *p);                                                           /* vring.c */
void sm_pring_timeout (struct pring *p);                                                             /* vring.c */
void sm_pring_timeout_task (u32 i, u32 a1);                                                          /* vring.c */
void sort_scan_ch_list (const u8 *cmd, u32 *dst);                                                    /* scan.c */
void static_ctors_run (void);                                                                        /* ctors.c */
void stats_delta_since_baseline (struct fw_sysapi_mgr *req, u32 *out);                               /* misc_ext_sysapi.c */
void stats_log_counters (struct fw_sysapi_mgr *req);                                                 /* misc_ext_sysapi.c */
u32 stats_read_counter_by_id (u32 id, u32 *out);                                                     /* misc_ext_sysapi.c */
void stop_find_session (struct mid_disc *o);                                                         /* rf_kill.c */
const u8 *str_eq_n (const u8 *a, u8 c, u32 n);                                                       /* discovery.c */
void stream_ctx_vt_ba_agreed (struct stream_ctx *ctx, u32 win, u32 timeout, u32 amsdu);              /* ba.c */
void stream_ctx_vt_ba_failed (struct stream_ctx *ctx, u32 resume);                                   /* ba.c */
void stream_ctx_vt_ba_teardown (struct stream_ctx *ctx, u32 a0, u32 a1);                             /* ba.c */
void stream_ctx_vt_ready (struct stream_ctx *ctx);                                                   /* ba.c */
void stream_ctx_vt_remove (struct stream_ctx *ctx);                                                  /* ba.c */
void stream_ctx_vt_status (struct stream_ctx *ctx, u32 status);                                      /* ba.c */
void stream_ctx_vt_suspend (struct stream_ctx *ctx);                                                 /* ba.c */
void stream_ctx_vt_suspend_b (struct stream_ctx *ctx);                                               /* ba.c */
void stream_mgr_action (struct rx_pkt *pkt);                                                         /* action.c */
void stream_mgr_addba_req_handler (const struct ieee80211_addba *f, u32 cid);                        /* ba.c */
void stream_mgr_addba_rsp_handler (const struct ieee80211_addba_resp *f, u32 cid);                   /* ba.c */
void stream_mgr_ba_disable (u32 vr);                                                                 /* ba.c */
void stream_mgr_build_params (struct vring_tbl_entry *e, u32 mode, u32 flag, u32 tid);               /* ba.c */
void stream_mgr_check_vring (struct mem_pool *p, void *blk);                                         /* pool.c */
void stream_mgr_delba_handler (const struct ieee80211_delba *f, u32 cid);                            /* ba.c */
void stream_mgr_delba_tx_complete (u32 pl, u32 status, u32 a2);                                      /* ba.c */
void stream_mgr_delete_vring (u32 vring);                                                            /* stream_mgr.c */
void stream_mgr_install_ba_rule (u32 a, u32 b);                                                      /* stream_mgr.c */
void stream_mgr_on_count_zero (struct conn *conn);                                                   /* ba.c */
void stream_mgr_prepare_1f (u32 cid, u32 mask);                                                      /* discovery.c */
u32 stream_mgr_prepare_buf30_by_id (const struct vring_tbl_entry *e);                                /* ba.c */
u32 stream_mgr_pring_by_index (u32 vr);                                                              /* stream_mgr.c */
void stream_mgr_ready_for_modify (u32 idx, u32 a1);                                                  /* discovery.c */
void stream_mgr_ready_step (void);                                                                   /* discovery.c */
u32 stream_mgr_remove_conn_stream (struct conn *conn, u32 a1, u32 a2);                               /* ba.c */
void stream_params_copy_hdr (const struct vring_tbl_entry *e, struct macq_desc *d);                  /* ba.c */
void stream_sm_act_addba_rsp (struct stream_sm *s, u32 a0);                                          /* ba.c */
void stream_sm_act_ba_en (struct stream_sm *s, u32 a0, u32 a1, u32 a2);                              /* ba.c */
void stream_sm_act_dis_status (struct stream_sm *s);                                                 /* ba.c */
void stream_sm_act_en_status (struct stream_sm *s);                                                  /* ba.c */
void stream_sm_act_setup_done (struct stream_sm *s, u32 a0);                                         /* ba.c */
void stream_sm_act_setup_ev12 (struct stream_sm *s);                                                 /* ba.c */
void stream_sm_act_setup_ev2 (struct stream_sm *s);                                                  /* ba.c */
void stream_sm_act_setup_ev7 (struct stream_sm *s, u32 a0);                                          /* ba.c */
void stream_sm_act_teardown (struct stream_sm *s, u32 a0);                                           /* ba.c */
void stream_sm_act_vt1 (struct stream_sm *s, u32 a0, u32 a1);                                        /* ba.c */
void stream_sm_act_vt2 (struct stream_sm *s);                                                        /* ba.c */
void stream_sm_act_wait_ev1 (struct stream_sm *s);                                                   /* ba.c */
void stream_sm_act_wait_ev2 (struct stream_sm *s);                                                   /* ba.c */
void stream_sm_act_wait_ev3 (struct stream_sm *s, u32 a0);                                           /* ba.c */
void stream_sm_act_wait_ev3_suspend (struct stream_sm *s, u32 a0);                                   /* ba.c */
void sw_tx_mgmt_clear_link_ctx (void);                                                               /* mlme.c */
void sw_tx_mgmt_link_up_evt (struct conn *conn, u32 v);                                              /* mlme.c */
void sw_tx_mgmt_packet_release (u32 payload, u32 status, u32 mid, sw_tx_done_fn cb);                 /* mlme.c */
void sw_tx_mgmt_tx_complete_cb (u32 payload, u32 status, u32 a2);                                    /* mlme.c */
void sw_vring_ba_params (const struct vring_tbl_entry *e);                                           /* ba.c */
void sw_vring_program_ba_win (u32 q, u32 win);                                                       /* ba.c */
void swc_psc_sm_action_abort_scan (struct swc_psc_sm *sm, u32 a0);                                   /* scan.c */
void swc_psc_sm_action_complete_scan (struct swc_psc_sm *sm, u32 status);                            /* scan.c */
void swc_psc_sm_action_kick_channel_sw_sm (struct swc_psc_sm *sm);                                   /* scan.c */
void swc_psc_sm_action_start_scan (struct swc_psc_sm *sm, struct scan_mngr *scan);                   /* scan.c */
void swc_psc_sm_action_stop_dwelling (struct swc_psc_sm *sm);                                        /* scan.c */
void swc_psc_sm_ctor (struct swc_psc_sm *sm);                                                        /* scan.c */
void swc_psc_sm_sob_timeout_cb (u32 sm, u32 a1);                                                     /* scan.c */
void sys_state_broadcast (u32 st, u32 arg);                                                          /* l2mgr.c */
u32 sys_timer_read_now (void);                                                                       /* sched.c */
void sysapi_mgr_apply_ut_args (const struct ut_cmd *c, const u32 *ctx, u32 len);                     /* sysapi_stats.c */
u32 sysapi_mgr_stats_lut_find_index (struct fw_sysapi_mgr *mgr, u32 key);                            /* lmac_evt.c */
void sysassert_debug_hold (void);                                                                    /* sysassert.c */
void sysassert_dump_stack (void);                                                                    /* sysassert.c */
void sysassert_dump_ucode_int6 (void);                                                               /* sysassert.c */
void sysassert_dump_ucode_stack (void);                                                              /* sysassert.c */
void tdma_ap_update (struct mid *mid, const struct conn *exclude);                                   /* tdma.c */
u32 temp_get_active_rf (u32 a);                                                                      /* stubs.c */
u32 temp_get_rf_by_index (u32 a, u32 b);                                                             /* stubs.c */
void temp_sense_get_cached (temp_done_fn cb, u32 ctx);                                               /* lmac.c */
void temp_sense_on_system_state (u32 st, u32 idle, u32 conn);                                        /* l2mgr.c */
void temp_sense_schedule (u32 delay);                                                                /* l2mgr.c */
void temperature_service_timer_exp_handler (u32 a, u32 a1);                                          /* temp_service.c */
s32 time_cmp (u32 a0, u32 a1);                                                                       /* sched.c */
void timer_start (u32 a, u32 b, u32 c, u32 d);                                                       /* sched.c */
void timer_task_cancel (struct psvc *obj);                                                           /* discovery.c */
u32 tx_ageing_detector_is_enabled (struct ll_ageing_det *d);                                         /* link_loss.c */
void tx_api_bits_set8_s0_w6 (u8 *p, u32 v);                                                          /* tx_api.c */
void tx_api_call_mem_pool_alloc_err_cb (u32 h, u32 conn);                                            /* fwq_tx.c */
void tx_api_call_vmethod_04 (struct fwq_tx *q, struct llist *list);                                  /* fwq_tx.c */
void tx_api_count_completion_status (struct fwq_tx *q, u32 status);                                  /* fwq_tx.c */
void tx_api_free_memory (u32 tx);                                                                    /* pool.c */
u8 tx_api_get_mgmt_retry_limit (void);                                                               /* tx_api.c */
void tx_api_init_pools (void);                                                                       /* fwq_tx.c */
void tx_api_mask_from_queue (const struct rx_dma_ring *r);                                           /* dma.c */
void tx_api_reset_state_words (void);                                                                /* fwq_tx.c */
void tx_api_send_mgmt (struct conn *a0, u32 a1, u32 a2, u32 a3, u32 a4, tx_done_fn a5, u32 a6);      /* tx_api.c */
void tx_api_send_mgmt_with_cb (struct conn *conn, u32 a1, u32 a2, u32 payload, u32 len, u32 a5, u32 a6, tx_done_fn cb, u32 cat); /* mlme.c */
void tx_api_send_packet (struct conn *conn, u32 channel_type, u32 api_sel, u32 payload, u32 len, u32 retry_limit, u32 a6, u32 a7, u32 a8, tx_done_fn a9, u32 a10); /* tx_api.c */
void tx_api_stamp_seq_bytes (u8 *dst, u8 start, u32 len);                                            /* tx_api.c */
void tx_api_tx_complete_cb (void);                                                                   /* fwq_tx.c */
void tx_bcon_del_bcon (struct mid *mid_e);                                                           /* scan.c */
void tx_bcon_inject_evt4 (struct lm_sm *l, u32 e);                                                   /* scan_mngr.c */
void tx_desc_build (u32 e, struct tx_desc *d, u32 flags, u32 a3, u32 a4, u32 prio, u32 a6, u32 retry, u32 lifetime, u32 cid); /* fwq_tx.c */
u32 tx_desc_by_index (const struct ring_idx *r, u32 i);                                              /* fwq_tx.c */
void tx_desc_init_32 (struct tx_desc *d, u32 macq, u32 dma_it, u32 addr, u32 len, u32 ndesc);        /* fwq_tx.c */
u32 tx_desc_set_lifetime (u32 shift, u32 v);                                                         /* fwq_tx.c */
void tx_dma_build_desc (void *dst, const u16 *s0, const u16 *s1, u8 a3, u8 a4, u8 a5, u8 a6);        /* tx_helpers.c */
void tx_internal_api_conn_task (u32 cid, u32 a1);                                                    /* fwq_tx.c */
void tx_list_remove (struct llist *l, void *node);                                                   /* vring.c */
void tx_macq_api_step (void);                                                                        /* fwq_tx.c */
void tx_macq_config_ring_params (struct vring_tbl_entry *e, u32 a1, u32 a2, u32 start, u32 size, u32 mpdu); /* tx_queue.c */
u32 tx_macq_is_empty (const struct vring_tbl_entry *e, u32 log);                                     /* vring.c */
void tx_macq_setup (struct vring_tbl_entry *e, u32 mode, u32 a2, u32 a3, u32 a4, u32 a5, u32 a6, u32 a7); /* tx_queue.c */
void tx_macq_setup_params (struct vring_tbl_entry *e, u32 a1, u32 a2, u32 a3, u32 a4);               /* stream_mgr.c */
u32 tx_mgmt_build_step (u32 payload, struct mid *obj);                                               /* stubs.c */
void tx_mgmt_scan_probe_req (u32 payload, u32 *out_len, struct mid *mid_e, struct conn *conn, const struct tx_probe_param *param); /* mgmt_tx.c */
void tx_mgmt_srvs_build_dmg_beacon (u32 payload, u32 *out_len, struct mid *obj, u32 a3);             /* stubs.c */
void tx_ppdu_ageing_timeout_detector_start_monitoring (struct ll_ageing_det *det);                   /* link_loss.c */
void tx_ppdu_ageing_timeout_detector_task (struct psvc *svc, u32 count);                             /* link_loss.c */
void tx_probe_send_probe_req (u32 payload, struct mid *mid_e, struct conn *conn, const struct tx_probe_param *param, tx_done_fn cb); /* mgmt_tx.c */
void tx_probe_send_probe_resp (u32 payload, struct mid *bss_ctx, struct conn *conn, u32 flag, tx_done_fn cb); /* mgmt_tx.c */
void tx_queue_bits_set32_s0_w3 (void *p, u32 v);                                                     /* mac_ext.c */
void tx_queue_bits_set32_s14_w3 (void *p, u32 v);                                                    /* mac_ext.c */
void tx_queue_bits_set32_s17_w4 (void *p, u32 v);                                                    /* mac_ext.c */
void tx_queue_bits_set32_s20_w10 (void *p, u32 v);                                                   /* mac_ext.c */
void tx_queue_bits_set32_s6_w14 (void *p, u32 v);                                                    /* mac_ext.c */
void tx_queue_config_by_mode (struct macq_mode_desc *d, u32 mode);                                   /* mac_bringup.c */
void tx_queue_mgr_create_queue (u32 count, u32 first, u32 a2, u32 a3, u32 a4, u32 a5, u32 mpdu, u32 a7, u32 mode); /* tx_queue.c */
u32 tx_retry_vt_dma_ring (struct tx_retry *o);                                                       /* fwq_tx.c */
u32 tx_retry_vt_drain (struct tx_retry *o, struct llist *list, struct llist *src);                   /* fwq_tx.c */
void tx_retry_vt_init (struct tx_retry *o, u32 macq, u32 dma, u32 base, u32 size);                   /* fwq_tx.c */
void tx_retry_vt_nop (struct tx_retry *o);                                                           /* fwq_tx.c */
u32 tx_retry_vt_try_next (struct tx_retry *o);                                                       /* fwq_tx.c */
void tx_ring_advance_index (struct ring_idx *r, u32 *idx);                                           /* fwq_tx.c */
void tx_ring_complete (struct tx_ring *tr, struct llist *list, struct llist *sent);                  /* fwq_tx.c */
u32 tx_ring_dma_ring (struct tx_ring *tr);                                                           /* fwq_tx.c */
void tx_ring_enable (struct tx_ring *tr, u32 a1);                                                    /* fwq_tx.c */
void tx_ring_init (struct tx_ring *tr, u32 macq, u32 dma, u32 base, u32 size);                       /* fwq_tx.c */
u32 tx_ring_is_full (const struct ring_idx *r);                                                      /* fwq_tx.c */
u32 tx_ring_post_frame (struct tx_ring *tr, u32 payload, u32 len, u32 a3, u32 retry, u32 lifetime, u32 a6, u32 prio, u32 cid, u32 flags); /* fwq_tx.c */
void tx_send_packet_step (struct ieee80211_qos_hdr *q, u32 a1, u32 cid, u32 a3);                     /* tx_api.c */
void txpwr_brd_loaded (void);                                                                        /* tx_power.c */
u32 txq_ptp_sw_is_fifo_idle (u32 a);                                                                 /* vring.c */
void txq_ring_param_config_queue (struct macq_desc *d, u32 mpdu, const struct txq_ring_param *p, u32 type); /* tx_queue.c */
void txrx_mgr_handle_dma_irq (void);                                                                 /* rx.c */
void txrx_mgr_tx_complete_task (u32 idx, u32 a1);                                                    /* rx.c */
void txrx_sel (struct rf_obj *obj, u32 rf, u32 dir, u32 sector);                                     /* calib_hw.c */
void u_schd_add (u_schd_fn cb, u32 a1, u32 a2, u32 priority);                                        /* sched.c */
struct u_schd_task *u_schd_alloc_task (void);                                                        /* sched.c */
u32 u_schd_arm_timer (void);                                                                         /* sched.c */
u32 u_schd_calc_next_deadline (u32 *out_deadline, u32 *out_q);                                       /* sched.c */
void u_schd_cancel (u32 task);                                                                       /* sched.c */
u32 u_schd_deadline_less (struct u_schd_tq *q, u32 *out);                                            /* sched.c */
void u_schd_enqueue_ready (struct u_schd_task *task, u32 prio);                                      /* sched.c */
void u_schd_expire_timers (void);                                                                    /* sched.c */
void u_schd_expire_timers_thunk (void);                                                              /* sched.c */
void u_schd_fill_task_b (struct u_schd_task *t, u_schd_fn cb, u32 a0, u32 a1);                       /* sched.c */
void u_schd_hw_timer_a_start (u32 v);                                                                /* sched.c */
void u_schd_hw_timer_load_start (u32 a);                                                             /* sched.c */
void u_schd_hw_timer_set_compare (u32 v);                                                            /* sched.c */
void u_schd_init_queue (struct u_schd_tq *q);                                                        /* sched.c */
struct u_schd_task *u_schd_insert_timer (u32 q, u_schd_fn cb, u32 a0, u32 a1, u32 a2, u32 deadline, u32 a4, u32 a5); /* sched.c */
void u_schd_install_timer_vtables (void);                                                            /* sched.c */
void u_schd_irq_ack_thunk (u32 a);                                                                   /* sched.c */
u32 u_schd_now (void);                                                                               /* sched.c */
u32 u_schd_pop_expired (u32 q);                                                                      /* sched.c */
struct u_schd_task *u_schd_pop_ready (void);                                                         /* sched.c */
void u_schd_program_hw_timer (u32 v);                                                                /* sched.c */
void u_schd_reschedule (u32 q);                                                                      /* rx.c */
void u_schd_run (void);                                                                              /* sched.c */
u32 u_schd_schedule (u_schd_fn cb, u32 a0, u32 a1, u32 a2, u32 delay, u32 a4, u32 a5);               /* sched.c */
u32 u_schd_time_base_identity (struct u_schd_tq *q, u32 x);                                          /* sched.c */
u32 u_schd_time_base_tsf (struct u_schd_tq *q, u32 x);                                               /* sched.c */
void u_schd_timer_init (void);                                                                       /* sched.c */
u32 u_schd_timer_irq_pending (u32 v);                                                                /* sched.c */
void u_schd_timer_set_fields (struct u_schd_task *t, u32 deadline, u32 a4, u32 a5, u32 a2);          /* sched.c */
void uc_evt_mask_irq_and_defer_drain (void);                                                         /* isr.c */
void update_rf_xx_gains_tables (struct calib_silent_rssi *obj, u32 idx, u8 *a, u8 *b);               /* calib.c */
u32 user_icr_timer_bit (const u32 *timer, u32 v);                                                    /* sched.c */
struct ut_rsp *ut_begin_response (struct wmi_mbox *mb, u32 module, u32 subtype);                     /* ut_resp.c */
void ut_hw_drivers_check_index (u32 idx, u32 v);                                                     /* misc_ext.c */
void ut_hw_drivers_cmd_0x203 (void);                                                                 /* misc_ext.c */
void ut_hw_drivers_cmd_0x507 (u32 rf, u32 idx, u32 val);                                             /* misc_ext.c */
void ut_hw_drivers_cmd_0x508 (u32 rf, u32 idx, u32 v);                                               /* calib_hw.c */
u32 ut_hw_drivers_cmd_0x50f (u32 rf, u32 sector, u32 rx, u32 elem);                                  /* misc_ext.c */
u32 ut_hw_drivers_cmd_0x513 (u32 rf, u32 sector, u32 rx, u32 bit);                                   /* misc_ext.c */
void ut_hw_drivers_cmd_handler (struct wmi_mbox *mb, const struct ut_cmd *c);                        /* ut_hw_drivers.c */
u32 ut_hw_drivers_pair_2568 (u32 base, u32 d1, u32 d2, u32 d3, u32 d4);                              /* misc_ext.c */
void ut_hw_drivers_reply_not_supported (struct wmi_mbox *mb, const struct ut_cmd *c);                /* misc_ext.c */
void ut_hw_drivers_step_8f4480 (u32 func_mask, u32 out_mask, u32 val_mask);                          /* misc_ext.c */
void ut_hw_drivers_zero_result (u32 *out_b98, u32 *out_strap);                                       /* misc_ext.c */
void ut_hw_flows_operational_cmd_handler (struct wmi_mbox *mbox, const struct ut_cmd *cmd);          /* ut_flows.c */
void ut_hw_modes_chain_3 (u32 obj);                                                                  /* rf.c */
void ut_hw_modes_cmd_0x304_fw (u32 on, u32 arg);                                                     /* power_halt.c */
void ut_hw_modes_cmd_0x308 (u32 on, u32 *flags);                                                     /* power_halt.c */
void ut_hw_modes_cmd_0x30b (u32 on);                                                                 /* power_halt.c */
void ut_hw_modes_cmd_0x30c (u32 on);                                                                 /* misc_ext.c */
void ut_hw_modes_cmd_handler (struct wmi_mbox *mb, const struct ut_cmd *c);                          /* ut_hw_modes.c */
void ut_hw_modes_step (u32 on, u32 tx_idx, u32 rx_idx);                                              /* calib_hw.c */
void ut_module_hw_flows_log_101aa08 (u32 v, u32 a1);                                                 /* misc_ext.c */
void ut_module_hw_flows_sysapi_cmd_handler (struct wmi_mbox *mb, const struct ut_cmd *cmd);          /* sysapi_stats.c */
void ut_sysapi_flush_stats_start (const u32 *ctx);                                                   /* sysapi_stats.c */
void vendor_ie_build_wilocity (struct mid_bss *obj, u32 type, u32 f);                                /* wmi_cmd.c */
void vring_ack_and_unmask_irq (struct vring_rec *entry);                                             /* discovery.c */
struct vring_schd_if *vring_active_ring_table (void);                                                /* stream_mgr.c */
void vring_ba_en_race_check (u32 vr, u32 agg, u32 timeout, u32 amsdu);                               /* ba.c */
void vring_clear_hw_state (struct vring_rec *e);                                                     /* vring.c */
u32 vring_configure_tx (struct stream_ctx *desc, u32 idx, struct conn *cfg, u8 a3, u32 a4, u32 flag, u32 a6, u32 a7, u8 a8, u8 a9, u32 a10, u32 a11); /* stream_mgr.c */
struct stream_ctx *vring_ctx_alloc (void);                                                           /* stream_mgr.c */
void vring_enable_first_pending_gtk (void);                                                          /* ba.c */
struct vring_rec *vring_find_busy_index (u32 pring);                                                 /* vring.c */
u32 vring_get_pring_id (const struct stream_ctx *ctx);                                               /* stream_mgr.c */
u32 vring_get_pring_id_of_obj (const struct stream_sm *obj);                                         /* stream_mgr.c */
void vring_hw_clear_tx_ctl_bit0 (void);                                                              /* stream_mgr.c */
u32 vring_hw_field_addr_440c0c0 (u32 vr);                                                            /* vring.c */
u32 vring_hw_field_addr_440c100 (u32 vr);                                                            /* vring.c */
u32 vring_hw_read_status_bit (u32 idx);                                                              /* rx.c */
void vring_hw_set_ready_bit (u32 idx);                                                               /* vring.c */
void vring_hw_unmask_irq (u32 a, u32 flag);                                                          /* discovery.c */
u32 vring_is_empty (u32 vr, u32 log);                                                                /* ba.c */
u32 vring_is_empty_by_id (struct conn *conn);                                                        /* conn.c */
void vring_key_write_params (const struct vring_tbl_entry *entry, u32 flag, u32 key_idx);            /* discovery.c */
u32 vring_list_find (struct vring_schd *s, struct llist *list, u32 idx, struct vring_rec **entry);   /* vring.c */
void vring_program_macq_and_ba (const struct vring_tbl_entry *e, u32 start, u32 size);               /* vring.c */
void vring_reg_write_locked_0c (u32 val, u32 do_sync);                                               /* mac_bringup.c */
void vring_reg_write_locked_20 (u32 val, u32 do_sync);                                               /* dma_ring.c */
void vring_reg_write_locked_28 (u32 v, u32 flag);                                                    /* vring.c */
void vring_reg_write_locked_3c (u32 v, u32 flag);                                                    /* vring.c */
void vring_reinstall_key (const struct stream_ctx *s, u32 flag, u32 key_idx);                        /* discovery.c */
void vring_reinstall_keys_for_conn (struct conn *conn, u32 flag);                                    /* discovery.c */
void vring_schd_add_sniffer_vring (u32 id, u32 b, u32 c);                                            /* vring.c */
void vring_schd_alloc_pring (u32 vr);                                                                /* vring.c */
void vring_schd_alt_vt_add_vring (struct vring_schd_if *self, const struct wmi_sw_ring_cfg *cfg, struct stream_ctx *ctx, const struct wmi_vring_cfg_schd *schd, u32 en); /* vring.c */
void vring_schd_alt_vt_clear_time (struct vring_schd_if *self, u32 pr);                              /* vring.c */
void vring_schd_alt_vt_nop2 (struct vring_schd_if *self);                                            /* vring.c */
void vring_schd_alt_vt_nop4 (struct vring_schd_if *self, u32 vr);                                    /* vring.c */
void vring_schd_alt_vt_nop8 (struct vring_schd_if *self, u32 mask);                                  /* vring.c */
void vring_schd_alt_vt_reset (struct vring_schd_if *self);                                           /* vring.c */
void vring_schd_alt_vt_resume (struct vring_schd_if *self, u32 vr);                                  /* vring.c */
u32 vring_schd_alt_vt_ret0 (struct vring_schd_if *self, u32 mask);                                   /* vring.c */
void vring_schd_alt_vt_suspend (struct vring_schd_if *self, u32 vr);                                 /* vring.c */
u32 vring_schd_alt_vt_time_of_pring (struct vring_schd_if *self, u32 pr);                            /* vring.c */
u32 vring_schd_alt_vt_vring_of_pring (struct vring_schd_if *self, u32 pr);                           /* vring.c */
void vring_schd_bind_if_free (struct vring_schd *s, struct vring_rec *e, struct pring *p);           /* vring.c */
void vring_schd_disconnect_notify (u32 mid, u32 detail);                                             /* discovery.c */
void vring_schd_fill_vring_cfg (struct vring_rec *e, const struct stream_ctx *ctx, u32 prio, u32 slot, u32 bcast, u32 en); /* vring.c */
u32 vring_schd_find_bound (struct vring_schd *s, u32 vr, struct vring_rec **entry, struct pring **pring); /* vring.c */
void vring_schd_flush_response (u32 ring);                                                           /* lmac_evt.c */
u32 vring_schd_is_vring_ready (const struct vring_schd *s, u32 bit);                                 /* vring.c */
void vring_schd_move_ready_if_idle (u32 vr, u32 a1);                                                 /* vring.c */
void vring_schd_move_to_ready (struct vring_schd *s, struct vring_rec *e);                           /* vring.c */
void vring_schd_prohibit_cids (struct radio_mgr *rm);                                                /* vring.c */
void vring_schd_reconnect_next (u32 id, u32 arg);                                                    /* discovery.c */
void vring_schd_remove_vring (struct vring_schd *s, struct vring_rec *e);                            /* vring.c */
void vring_schd_resume_vring (struct lm_if *p);                                                      /* scan.c */
void vring_schd_stop_vring (struct vring_schd *s, struct pring *p);                                  /* vring.c */
void vring_schd_vt_add_vring (struct vring_schd_if *self, const struct wmi_sw_ring_cfg *cfg, struct stream_ctx *ctx, const struct wmi_vring_cfg_schd *schd, u32 en); /* vring.c */
void vring_schd_vt_allow (struct vring_schd_if *self, u32 mask);                                     /* vring.c */
void vring_schd_vt_clear_time (struct vring_schd_if *self, u32 pr);                                  /* vring.c */
void vring_schd_vt_delete_vring (struct vring_schd_if *self, u32 vr);                                /* vring.c */
u32 vring_schd_vt_prohibit (struct vring_schd_if *self, u32 mask);                                   /* vring.c */
void vring_schd_vt_reset (struct vring_schd_if *self);                                               /* vring.c */
void vring_schd_vt_reset_irq (struct vring_schd_if *self);                                           /* vring.c */
void vring_schd_vt_resume_vring (struct vring_schd_if *self, u32 vr);                                /* vring.c */
void vring_schd_vt_suspend_vring (struct vring_schd_if *self, u32 vr);                               /* vring.c */
u32 vring_schd_vt_time_of_pring (struct vring_schd_if *self, u32 pr);                                /* vring.c */
u32 vring_schd_vt_vring_of_pring (struct vring_schd_if *self, u32 pr);                               /* vring.c */
void vring_schdlr_isr_dispatch (void);                                                               /* vring.c */
struct vring_tbl_entry *vring_tbl_entry_addr (u32 idx);                                              /* tx_helpers.c */
struct stream_ctx *vring_tbl_find_by_id (struct conn *conn);                                         /* conn.c */
struct stream_ctx *vring_tbl_find_by_tid_cid (u32 tid, u32 cid);                                     /* ba.c */
void vring_tbl_init (void);                                                                          /* l2mgr.c */
struct stream_ctx *vring_tbl_ptr_by_index (u32 idx);                                                 /* ba.c */
void vring_wait_drain (u32 rq);                                                                      /* ba.c */
void wait_sm_act_delba (struct ba_wait_sm *w);                                                       /* ba.c */
void wait_sm_act_done (struct ba_wait_sm *w, u32 a0, u32 a1, u32 a2);                                /* ba.c */
void wait_sm_act_store (struct ba_wait_sm *w, u32 reason, u32 flag);                                 /* ba.c */
void wait_sm_init (struct ba_wait_sm *s, struct stream_sm *p);                                       /* tx_helpers.c */
void wbe_driver_link_up_task (u32 a0, u32 a1);                                                       /* vectors.c */
void wmi_abort_scan (u32 mid);                                                                       /* wmi_cmd.c */
void wmi_add_cipher_key (const struct wmi_add_cipher_key_cmd *cmd, u32 mid);                         /* wmi_h_sta.c */
void wmi_add_debug_tx_pckt (const struct wmi_add_debug_tx_pckt_cmd *cmd, u32 mid);                   /* wmi_h_misc.c */
void wmi_bcast_vring_cfg (const struct wmi_bcast_vring_cfg_cmd *cmd, u32 mid);                       /* wmi_h_pcp.c */
void wmi_bcon_ctrl (const struct wmi_bcon_ctrl_cmd *cmd, u32 mid);                                   /* wmi_h_pcp.c */
void wmi_beamforming_mgmt (struct wmi_mbox *mb, const void *cmd, u32 mid);                           /* wmi_h_bf.c */
void wmi_bf_control (const u8 *body, struct wmi_mbox *mb);                                           /* wmi_h_bf.c */
void wmi_brp_set_ant_limit (struct wmi_mbox *mb, const struct wmi_brp_set_ant_limit_cmd *cmd, u32 mid); /* wmi_h_bf.c */
void wmi_connect (const struct wmi_connect_cmd *cmd, u32 mid);                                       /* wmi_cmd.c */
void wmi_deep_echo (struct wmi_mbox *mb, u32 value);                                                 /* wmi_h_misc.c */
void wmi_delete_cipher_key (const struct wmi_delete_cipher_key_cmd *cmd, u32 mid);                   /* wmi_h_sta.c */
void wmi_disconnect (u32 mid);                                                                       /* wmi_cmd.c */
void wmi_enable_fixed_scheduling (struct wmi_mbox *mb, const void *cmd, u32 mid);                    /* wmi_h_bf.c */
void wmi_ese_cfg (const struct wmi_scheduling_scheme_cmd *cmd, u32 mid, struct wmi_mbox *mb);        /* wmi_h_bf.c */
void wmi_evt_alloc_and_fill (u32 a0);                                                                /* mbox.c */
void wmi_evt_build_and_post (struct fw_mailbox *mb, void *b, u32 c, u32 d, u32 e, u32 f, u32 g, u32 h); /* tx_helpers.c */
void wmi_evt_fill_payload (struct mbox_ring *ring, struct mbox_hdr *buffer);                         /* tx_helpers.c */
void wmi_evt_init_desc (struct pring *p, u32 id, u32 b, u32 c);                                      /* vring.c */
void wmi_evt_notify_fw_ready (void *mac, u32 mid);                                                   /* l2mgr.c */
void wmi_evt_post (struct wmi_mbox *mb, void *b, u32 c, u32 d, u32 e, u32 f, u32 g, u32 h);          /* tx_helpers.c */
void wmi_evt_send_command_not_supported (struct wmi_mbox *mb, u32 cmd_id, u32 reason, u32 mid);      /* wmi_cmd.c */
void wmi_evt_send_words (struct wmi_mbox *mb, volatile struct ut_rsp *buf, u32 len);                 /* ut_resp.c */
void wmi_evt_walk_list (struct mbox_ring *ring, struct mbox_entry *e);                               /* tx_helpers.c */
void wmi_fixed_scheduling_config (struct wmi_mbox *mb, const struct wmi_fixed_scheduling_config_cmd *cmd, u32 mid); /* wmi_h_bf.c */
void wmi_fixed_scheduling_ul_config (struct wmi_mbox *mb, const struct wmi_fixed_scheduling_ul_config_cmd *cmd, u32 mid); /* wmi_h_bf.c */
void wmi_fw_ver (struct wmi_mbox *mb, u32 mid);                                                      /* wmi_h_sta.c */
void wmi_get_assoc_list (struct wmi_mbox *mb, u32 mid);                                              /* wmi_h_sta.c */
void wmi_get_baseband_type (struct wmi_mbox *mb, u32 mid);                                           /* wmi_h_sta.c */
void wmi_get_cca_indications (struct wmi_mbox *mb, u32 mid);                                         /* wmi_h_sta.c */
void wmi_get_detailed_rs_res (struct wmi_mbox *mb, const struct wmi_get_detailed_rs_res_cmd *cmd, u32 mid); /* wmi_h_bf.c */
void wmi_get_pcp_channel (u32 mid, struct wmi_mbox *mb);                                             /* wmi_h_pcp.c */
void wmi_get_pcp_factor (u32 mid);                                                                   /* wmi_h_pcp.c */
void wmi_get_rf_status (struct wmi_mbox *mb, u32 mid);                                               /* wmi_h_sta.c */
void wmi_get_ssid (u32 mid, struct wmi_mbox *mb);                                                    /* wmi_h_sta.c */
void wmi_host_cmd_dispatch (struct wmi_mbox *mb, u8 *cmd);                                           /* wmi_cmd.c */
void wmi_link_maintain_cfg_read (const struct wmi_link_maintain_cfg_read_cmd *cmd);                  /* wmi_h_sta.c */
void wmi_link_maintain_cfg_write (const struct wmi_link_maintain_cfg_write_cmd *cmd);                /* wmi_h_sta.c */
void wmi_mac_addr_req (u32 mid, struct wmi_mbox *mb);                                                /* wmi_h_sta.c */
u32 wmi_network_type_ok (u32 nt);                                                                    /* wmi_cmd.c */
void wmi_notify_req (struct wmi_mbox *mb, const struct wmi_notify_req_cmd *cmd);                     /* wmi_h_sta.c */
void wmi_pcp_start (const struct wmi_pcp_start_cmd *cmd, u32 mid);                                   /* wmi_h_pcp.c */
void wmi_pmc (const struct wmi_pmc_cmd *cmd);                                                        /* wmi_h_misc.c */
void wmi_port_allocate (const struct wmi_port_allocate_cmd *cmd);                                    /* wmi_h_pcp.c */
void wmi_prio_tx_sectors_number (struct wmi_mbox *mb, const struct wmi_prio_tx_sectors_number_cmd *cmd, u32 mid); /* wmi_h_bf.c */
void wmi_prio_tx_sectors_order (struct wmi_mbox *mb, const struct wmi_prio_tx_sectors_order_cmd *cmd, u32 mid); /* wmi_h_bf.c */
void wmi_prio_tx_sectors_set_default_cfg (struct wmi_mbox *mb, const struct wmi_prio_tx_sectors_set_default_cfg_cmd *cmd, u32 mid); /* wmi_h_bf.c */
void wmi_pxmt_range_cfg (const u8 *body, u32 mid);                                                   /* wmi_h_misc.c */
void wmi_rcp_addba_resp (const struct wmi_rcp_addba_resp_cmd *cmd, u32 mid);                         /* ba.c */
void wmi_rcp_delba (const struct wmi_rcp_delba_cmd *cmd, u32 mid);                                   /* ba.c */
void wmi_reject_param (u32 cmd, u32 val, u32 off);                                                   /* wmi_cmd.c */
void wmi_rf_bringup_extra (void);                                                                    /* wmi.c */
void wmi_rf_pwr_on_delay (struct wmi_mbox *mb, const struct wmi_rf_pwr_on_delay_cmd *cmd, u32 mid);  /* wmi_h_misc.c */
void wmi_rs_cfg (struct wmi_mbox *mb, const struct wmi_rs_cfg_cmd *cmd, u32 mid);                    /* wmi_h_bf.c */
void wmi_set_active_silent_rssi_table (struct wmi_mbox *mb, u32 value, u32 mid);                     /* wmi_h_bf.c */
void wmi_set_ap_slot_size (struct wmi_mbox *mb, u32 value);                                          /* wmi_h_bf.c */
void wmi_set_cca_indications_bi_avg_num (const struct wmi_set_cca_indications_bi_avg_num_cmd *cmd, struct wmi_mbox *mb, u32 mid); /* wmi_h_bf.c */
void wmi_set_grant_mcs (struct wmi_mbox *mb, u32 value);                                             /* wmi_h_bf.c */
void wmi_set_high_power_table_params (const struct wmi_set_high_power_table_params_cmd *cmd, u32 mid, struct wmi_mbox *mb); /* wmi_h_bf.c */
void wmi_set_long_range (struct wmi_mbox *mb, const void *cmd, u32 mid);                             /* wmi_h_bf.c */
void wmi_set_multi_directed_omnis_config (struct wmi_mbox *mb, const struct wmi_set_multi_directed_omnis_config_cmd *cmd, u32 mid); /* wmi_h_bf.c */
void wmi_set_passphrase_handler (const struct wmi_set_passphrase_cmd *cmd, u32 mid);                 /* wmi_h_sta.c */
void wmi_set_pcp_channel (const struct wmi_set_pcp_channel_cmd *cmd);                                /* wmi_h_pcp.c */
void wmi_set_rf_sector_on (const void *cmd, struct wmi_mbox *mb);                                    /* wmi_h_bf.c */
void wmi_sparraw_tdma_cfg (const struct wmi_sparraw_tdma_cfg_cmd *cmd, u32 mid_id);                  /* tdma.c */
void wmi_sparraw_tx_power (const struct wmi_sparraw_tx_power_cmd *cmd);                              /* tx_power.c */
void wmi_sw_tx_req (const struct wmi_sw_tx_req_cmd *cmd, u32 mid);                                   /* wmi_h_pcp.c */
void wmi_temp_sense (struct wmi_mbox *mb, const struct wmi_temp_sense_cmd *cmd);                     /* wmi_h_sta.c */
void wmi_trigger_beamforming (const struct wmi_bf_trig_cmd *cmd, u32 mid);                           /* wmi_h_bf.c */
void wmi_ut_handler (struct wmi_mbox *mb, const void *payload);                                      /* wmi.c */
void wmi_vring_ba_dis (const u8 *cmd, u32 mid);                                                      /* ba.c */
void wmi_vring_ba_en (const struct wmi_vring_ba_en_cmd *cmd, u32 mid);                               /* ba.c */
void wmi_vring_cfg (void *cmd_p, u32 mid);                                                           /* tx.c */
void wmi_vring_cfg_with_847b34 (struct stream_ctx *c);                                               /* stream_mgr.c */
void wmi_vring_switch_config (struct wmi_mbox *mb, const struct wmi_vring_switch_timing_config_cmd *cmd, u32 mid); /* wmi_h_bf.c */
u32 xpm_accumulate_bits (void);                                                                      /* rf.c */
u32 xpm_block_check_inputs (u32 rf, u32 addr, u32 len, const void *dst, u32 max, u32 flag);          /* otp.c */
u32 xpm_byte_check_inputs (u32 rf, u32 bit_addr, u32 flag);                                          /* otp.c */
u32 xpm_enter_cfg_step (u32 rf, u32 mode, u32 flag);                                                 /* mac_ext.c */
const u32 *xpm_get_cfg_preset (u32 idx);                                                             /* mac_ext.c */
u32 xpm_read_3c8 (u32 rf);                                                                           /* mac_ext.c */
u32 xpm_read_3cc (u32 rf);                                                                           /* mac_ext.c */
u32 xpm_read_cfg_350 (u32 rf, u32 idx);                                                              /* mac_ext.c */
u32 xpm_read_cfg_378 (u32 rf, u32 idx);                                                              /* mac_ext.c */
void xpm_wave_rd_set (u32 rf, u32 idx, u32 v);                                                       /* mac_ext.c */
void xpm_write_3c8 (u32 rf, u32 v);                                                                  /* mac_ext.c */
void xpm_write_3cc (u32 rf, u32 v);                                                                  /* mac_ext.c */
void xpm_write_cfg_350 (u32 rf, u32 idx, u32 v);                                                     /* mac_ext.c */

#endif
