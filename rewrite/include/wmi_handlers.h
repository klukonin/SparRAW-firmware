/* SPDX-License-Identifier: AGPL-3.0-or-later */
#ifndef WMI_HANDLERS_H
#define WMI_HANDLERS_H
/* Обработчики WMI-команд, которые вызывает диспетчер wmi__host_cmd_dispatch (0x8de43c,
 * fw/wmi_cmd.c). Порядок аргументов — как их ставит vendor-диспетчер: mb — ящик хоста
 * (struct wmi_mbox, include/mbox.h: для ответа), тело команды — struct wmi_*_cmd
 * (include/wmi.h), mid — номер записи MID из wmi-заголовка. Тело, которое обработчик не
 * читает, — const void *. Таблица — docs/WMI-DISPATCH.md. Отсортировано по vendor-адресу. */
#include "types.h"
#include "wmi.h"

struct wmi_mbox;                                                        /* include/mbox.h */
struct rf_sector_sel_req;                                               /* include/mbox.h */

void wmi_deep_echo(struct wmi_mbox *mb, u32 value);                                          /* 0x8c87a4 wmi_deep_echo */
void host_if_get_status_hal(struct wmi_mbox *mb, const void *cmd, u32 mid);                  /* 0x8cccbc host_if__get_status_hal */
void get_rf_sector_params_handle(struct wmi_rf_sector_get_req *self);                       /* 0x8cd104 wmi_handler_get_rf_sector_params::handle */
void set_rf_sector_params_handle(struct wmi_rf_sector_set_req *self);                       /* 0x8cd14c wmi_handler_set_rf_sector_params::handle */
void lmac_if_send_get_selected_rf_sector_index(const struct rf_sector_sel_req *self);        /* 0x8cd198 lmac_if_send_get_selected_rf_sector_index */
void lmac_if_send_set_selected_rf_sector_index(const struct rf_sector_sel_req *self);        /* 0x8cd1c0 lmac_if_send_set_selected_rf_sector_index */
void wmi_beamforming_mgmt(struct wmi_mbox *mb, const void *cmd, u32 mid);                    /* 0x8dcfa8 wmi_beamforming_mgmt */
void host_if_bf_ctrl_hal(struct wmi_mbox *mb, const void *cmd, u32 mid);                     /* 0x8dd028 host_if__bf_ctrl_hal */
void wmi_brp_set_ant_limit(struct wmi_mbox *mb, const struct wmi_brp_set_ant_limit_cmd *cmd, u32 mid); /* 0x8dd068 wmi_brp_set_ant_limit */
void wmi_fw_ver(struct wmi_mbox *mb, u32 mid);                                               /* 0x8dd130 wmi_fw_ver */
void wmi_get_baseband_type(struct wmi_mbox *mb, u32 mid);                                    /* 0x8dd29c wmi_get_baseband_type */
void wmi_get_detailed_rs_res(struct wmi_mbox *mb, const struct wmi_get_detailed_rs_res_cmd *cmd, u32 mid); /* 0x8dd310 wmi_get_detailed_rs_res */
void wmi_get_rf_status(struct wmi_mbox *mb, u32 mid);                                        /* 0x8dd3c8 wmi_get_rf_status */
void wmi_notify_req(struct wmi_mbox *mb, const struct wmi_notify_req_cmd *cmd);              /* 0x8dd4b8 wmi__bump_cmd_counter */
void wmi_rs_cfg(struct wmi_mbox *mb, const struct wmi_rs_cfg_cmd *cmd, u32 mid);             /* 0x8dd528 wmi_rs_cfg */
void host_if_set_sectors_hal(struct wmi_mbox *mb, const struct wmi_set_sectors_cmd *cmd);    /* 0x8dd64c host_if__set_sectors_hal */
void host_if_read_rf_xpm(struct wmi_mbox *mb, const struct wmi_rf_xpm_read_cmd *cmd);        /* 0x8e363c host_if::read_rf_xpm_handler */
void host_if_write_rf_xpm(struct wmi_mbox *mb, const struct wmi_rf_xpm_write_cmd *cmd);      /* 0x8e36cc host_if::write_rf_xpm_handler */
void wmi_add_debug_tx_pckt(const struct wmi_add_debug_tx_pckt_cmd *cmd, u32 mid);            /* 0x8e55ac wmi_add_debug_tx_pckt */
u32 get_rf_sector_params_set(struct wmi_rf_sector_get_req *self,
                             const struct wmi_get_rf_sector_params_cmd *cmd, struct wmi_mbox *mb); /* 0x8e5e00 wmi_handler_get_rf_sector_params::set */
u32 set_rf_sector_params_set(struct wmi_rf_sector_set_req *self,
                             const struct wmi_set_rf_sector_params_cmd *cmd, struct wmi_mbox *mb); /* 0x8e5e84 wmi_handler_set_rf_sector_params::set */
u32 get_selected_rf_sector_index_set(struct rf_sector_sel_req *self,
                                     const struct wmi_get_selected_rf_sector_index_cmd *cmd,
                                     struct wmi_mbox *mb);                                   /* 0x8e5f44 wmi_get_selected_rf_sector_index */
u32 set_selected_rf_sector_index_set(struct rf_sector_sel_req *self,
                                     const struct wmi_set_selected_rf_sector_index_cmd *cmd,
                                     struct wmi_mbox *mb);                                   /* 0x8e5fb4 wmi_set_selected_rf_sector_index */
void wmi_set_active_silent_rssi_table(struct wmi_mbox *mb, u32 table, u32 mid);              /* 0x8e6120 wmi_set_active_silent_rssi_table */
void wmi_set_ap_slot_size(struct wmi_mbox *mb, u32 slot_size);                               /* 0x8e6178 wmi_set_ap_slot_size */
void wmi_set_grant_mcs(struct wmi_mbox *mb, u32 mcs);                                        /* 0x8e66ac wmi_set_grant_mcs */
void wmi_rf_pwr_on_delay(struct wmi_mbox *mb, const struct wmi_rf_pwr_on_delay_cmd *cmd, u32 mid); /* 0x8e6e40 wmi_rf_pwr_on_delay */
void wmi_vring_switch_config(struct wmi_mbox *mb, const struct wmi_vring_switch_timing_config_cmd *cmd,
                             u32 mid);                                                       /* 0x8e7340 wmi_vring_switch_config */
void wmi_temp_sense(struct wmi_mbox *mb, const struct wmi_temp_sense_cmd *cmd);              /* 0x8e909c wmi__cmd_arg_check */
void wmi_bf_control(const u8 *body, struct wmi_mbox *mb);                                    /* 0x8ec068 wmi_bf_control */
void l2mgr_del_sta(const struct wmi_disconnect_sta_cmd *cmd, u32 mid, struct wmi_mbox *mb);  /* 0x8ec184 l2_mgr::wmi_cmd_handler_del_sta */
void wmi_get_ssid(u32 mid, struct wmi_mbox *mb);                                             /* 0x8ec264 wmi_get_ssid */
void l2mgr_new_sta(const struct wmi_new_sta_cmd *cmd, u32 mid, struct wmi_mbox *mb);         /* 0x8ec2b8 l2_mgr::wmi_cmd_handler_new_sta */
void wmi_set_high_power_table_params(const struct wmi_set_high_power_table_params_cmd *cmd, u32 mid,
                                     struct wmi_mbox *mb);                                   /* 0x8ec3f0 wmi_set_high_power_table_params */
void wmi_delete_cipher_key(const struct wmi_delete_cipher_key_cmd *cmd, u32 mid);            /* 0x8ec4bc wmi_delete_cipher_key */
void wmi_enable_fixed_scheduling(struct wmi_mbox *mb, const void *cmd, u32 mid);             /* 0x8ec500 wmi_enable_fixed_scheduling */
void wmi_fixed_scheduling_config(struct wmi_mbox *mb, const struct wmi_fixed_scheduling_config_cmd *cmd,
                                 u32 mid);                                                   /* 0x8ec56c wmi_fixed_scheduling_config */
void wmi_fixed_scheduling_ul_config(struct wmi_mbox *mb, const struct wmi_fixed_scheduling_ul_config_cmd *cmd,
                                    u32 mid);                                                /* 0x8ec5fc wmi_fixed_scheduling_ul_config */
void wmi_get_assoc_list(struct wmi_mbox *mb, u32 mid);                                       /* 0x8ec68c wmi_get_assoc_list */
void wmi_mac_addr_req(u32 mid, struct wmi_mbox *mb);                                         /* 0x8ec724 wmi_mac_addr_req */
void wmi_link_maintain_cfg_read(const struct wmi_link_maintain_cfg_read_cmd *cmd);           /* 0x8ec7b0 wmi_link_maintain_cfg_read */
void wmi_link_maintain_cfg_write(const struct wmi_link_maintain_cfg_write_cmd *cmd);         /* 0x8ec7f8 wmi_link_maintain_cfg_write */
void wmi_bcon_ctrl(const struct wmi_bcon_ctrl_cmd *cmd, u32 mid);                            /* 0x8ec840 wmi_pcp_start_cmd_handler */
void wmi_pcp_start(const struct wmi_pcp_start_cmd *cmd, u32 mid);                            /* 0x8ec91c wmi_pcp_start */
void wmi_pxmt_range_cfg(const u8 *body, u32 mid);                                            /* 0x8ec9d0 wmi_pxmt_range_cfg */
void low_sme_wmi_rf_mgmt_cmd_handler(const struct wmi_rf_mgmt_cmd *cmd);                     /* 0x8ec9e8 low_sme::wmi_rf_mgmt_cmd_handler */
void wmi_set_long_range(struct wmi_mbox *mb, const void *cmd, u32 mid);                      /* 0x8ecdcc wmi_set_long_range */
void wmi_set_multi_directed_omnis_config(struct wmi_mbox *mb,
                                         const struct wmi_set_multi_directed_omnis_config_cmd *cmd,
                                         u32 mid);                                           /* 0x8ece20 wmi_set_multi_directed_omnis_config_cmd */
void wmi_set_passphrase_handler(const struct wmi_set_passphrase_cmd *cmd, u32 mid);          /* 0x8ece64 wmi_set_passphrase_handler */
void wmi_set_rf_sector_on(const void *cmd, struct wmi_mbox *mb);                             /* 0x8eceb8 wmi_set_rf_sector_on_cmd_handler */
void wmi_prio_tx_sectors_set_default_cfg(struct wmi_mbox *mb,
                                         const struct wmi_prio_tx_sectors_set_default_cfg_cmd *cmd,
                                         u32 mid);                                           /* 0x8ecf54 wmi_prio_tx_sectors_set_default_cfg */
void wmi_prio_tx_sectors_number(struct wmi_mbox *mb, const struct wmi_prio_tx_sectors_number_cmd *cmd,
                                u32 mid);                                                    /* 0x8ecfa0 wmi_prio_tx_sectors_number */
void wmi_prio_tx_sectors_order(struct wmi_mbox *mb, const struct wmi_prio_tx_sectors_order_cmd *cmd,
                               u32 mid);                                                     /* 0x8ecfec wmi_prio_tx_sectors_order */
void wmi_bcast_vring_cfg(const struct wmi_bcast_vring_cfg_cmd *cmd, u32 mid);                /* 0x8fb4e0 wmi_bcast_vring_cfg */
void wmi_get_cca_indications(struct wmi_mbox *mb, u32 mid);                                  /* 0x8fb598 wmi__post_pct_stats_evt */
void wmi_get_pcp_channel(u32 mid, struct wmi_mbox *mb);                                      /* 0x8fb5ec wmi_get_pcp_channel */
void wmi_get_pcp_factor(u32 mid);                                                            /* 0x8fb648 wmi_get_pcp_factor */
void l2mgr_p2p_cfg(const struct wmi_p2p_cfg_cmd *cmd, u32 mid);                              /* 0x8fb69c l2_mgr::wmi_cmd_handler_p2p_cfg */
void wmi_pmc(const struct wmi_pmc_cmd *cmd);                                                 /* 0x8fb738 wmi_pmc */
void wmi_port_allocate(const struct wmi_port_allocate_cmd *cmd);                             /* 0x8fb77c wmi_port_allocate */
void wmi_ese_cfg(const struct wmi_scheduling_scheme_cmd *cmd, u32 mid, struct wmi_mbox *mb); /* 0x8fbb20 wmi_ese_cfg */
void wmi_set_cca_indications_bi_avg_num(const struct wmi_set_cca_indications_bi_avg_num_cmd *cmd,
                                        struct wmi_mbox *mb, u32 mid);                       /* 0x8fbbe8 wmi_set_cca_indications_bi_avg_num */
void wmi_set_pcp_channel(const struct wmi_set_pcp_channel_cmd *cmd);                         /* 0x8fbcc4 wmi_set_pcp_channel */
void l2mgr_start_discovery(u32 mid);                                                         /* 0x8fbd1c l2mgr__start_discovery */
void l2mgr_start_listen(u32 mid);                                                            /* 0x8fbd3c l2_mgr::wmi_cmd_handler_start_listen */
void l2mgr_start_search(u32 mid);                                                            /* 0x8fbd90 l2_mgr::wmi_cmd_handler_start_search */
void l2mgr_stop_discovery(u32 mid);                                                          /* 0x8fbde4 l2mgr__stop_discovery */
void wmi_sw_tx_req(const struct wmi_sw_tx_req_cmd *cmd, u32 mid);                            /* 0x8fbe18 wmi_sw_tx_req */
void wmi_add_cipher_key(const struct wmi_add_cipher_key_cmd *cmd, u32 mid);                  /* 0x8fbf7c wmi_add_cipher_key */
void wmi_trigger_beamforming(const struct wmi_bf_trig_cmd *cmd, u32 mid);                    /* 0x8fc11c wmi_trigger_beamforming_cmdid */

#endif
