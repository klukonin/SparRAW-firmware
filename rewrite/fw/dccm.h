/* Сгенерировано tools/gen_fw_data.py из fw/dccm_names.txt — не редактировать. */
/* Переменные DCCM fw по фиксированным адресам: определения — fw/fw_data.c (секции
 * .fwdata.<адрес>, значения — начальный образ vendor 6.2). */
#ifndef FW_DCCM_H
#define FW_DCCM_H
#include "types.h"

extern volatile u32 calib_silent_rssi_forced_rf_mask;  /* 0x800000: [gp,-0x184]: одноразовая маска RF silent RSSI (estimation_alg берёт её в результат оценки вместо проверки температуры RF и обнуляет) */
extern volatile u32 temp_bb_sensor_gain;             /* 0x800004: [gp,-0x180]: множитель BB-сенсора температуры (0x64f) */
extern volatile u32 pcie_marlon_compat;              /* 0x800008: [gp,-0x17c]: == 1 — совместимость wPCIeR с Marlon (pcie serdes init) */
extern volatile u32 conn_retry_delay;                /* 0x80000c: [gp,-0x178]: задержка таймера повтора соединения (1000000) */
extern volatile u32 bf_id_update_count;              /* 0x800010: [gp,-0x174]: счётчик записей BF id в [conn+0x18d] */
extern u32 macq_desc_default_bit0;                   /* 0x800014: [gp,-0x170]: бит 0 w1 дескриптора MACQ по умолчанию (rf_chain, 1) */
extern volatile u32 wmi_evt_ring_enabled;            /* 0x800018: [gp,-0x16c]: != 0 — события хосту через кольцо fw→host (в образе 1) */
extern volatile u32 dbg_assert_active;               /* 0x80001c: [gp,-0x168]: фатальный ассерт в обработке */
extern volatile u32 temp_period;                     /* 0x800020: [gp,-0x164]: период измерений службы температуры (×16 тиков u_schd) */
extern volatile u32 temp_min_delay;                  /* 0x800024: [gp,-0x160]: минимальная задержка до измерения температуры */
extern volatile u32 temp_rf_meas_flag;               /* 0x800028: [gp,-0x15c]: флаг измерения RF (в режиме 3 однократный) */
extern volatile u32 temp_rf_meas_mode;               /* 0x80002c: [gp,-0x158]: режим измерения RF (3 — однократный флаг) */
extern u32 rx_drop_all;                              /* 0x800030: [gp,-0x154]: != 0 — rx_pkt_srvs__dispatch освобождает каждый RX-кадр без разбора */
extern u32 tx_ring_cmpl_type19_count;                /* 0x800034: [gp,-0x150]: счётчик завершённых TX-дескрипторов типа 0x19 */
extern u32 tx_mgmt_cmpl_st5_count;                   /* 0x800038: [gp,-0x14c]: счётчик завершений mgmt со статусом 5 (кадр остаётся в pending) */
extern volatile u32 dbg_ucode_crash;                 /* 0x800050: [gp,-0x134]: 1 — сбой ucode (вектор 6), для fw_sysassert_fatal */
extern u32 boot_publish_id;                          /* 0x800058: [gp,-0x12c]: идентификатор для хоста (0x30201) → [board+0x2c] */
extern u32 fw_ver_build;                             /* 0x80005c: [gp,-0x128]: версия fw: build (vendor 6.2 — 1000) */
extern u32 fw_ver_major;                             /* 0x800060: [gp,-0x124]: версия fw: major (6) */
extern u32 fw_ver_minor;                             /* 0x800064: [gp,-0x120]: версия fw: minor (vendor 6.2 — 2) */
extern u32 fw_ver_sub;                               /* 0x800068: [gp,-0x11c]: версия fw: sub (vendor 6.2 — 0) */
extern volatile u32 vring_pair_mode;                 /* 0x80006c: [gp,-0x118]: режим vring_schd (1 — вариант 0x804e64) */
extern volatile u32 vring_switch_idle_th_us;         /* 0x800070: [gp,-0x114]: порог простоя vring (WMI_VRING_SWITCH_TIMING idle_th_usec) */
extern volatile u32 vring_switch_interval_us;        /* 0x800074: [gp,-0x110]: интервал переключения vring (WMI_VRING_SWITCH_TIMING interval_usec), период таймера связи pring */
extern u32 vring_slot_opt_delay;                     /* 0x800078: [gp,-0x10c]: задержка таймера slot_optimized pring (100000) */
extern u32 pring_bind_count;                         /* 0x80007c: [gp,-0x108]: счётчик привязок vring к pring */
extern u32 pring_stop_count;                         /* 0x800080: [gp,-0x104]: счётчик остановок очереди pring */
extern u32 pring_dma_wptr_sync_count;                /* 0x800084: [gp,-0x100]: счётчик синхронизаций DMA wptr pring */
extern volatile u32 mlme_assoc_resp_timeout_ms;      /* 0x800088: [gp,-0xfc]: таймаут ожидания после ASSOC_RESPONSE (мс, 3000) */
extern volatile u32 pcie_serdes_bit1_flag;           /* 0x800094: [gp,-0xf0]: обнуляется при бите 1 0x8825c0 (читателей не найдено) */
extern volatile u32 lm_bf_cfg_param;                 /* 0x800098: [gp,-0xec]: параметр [0] LMAC-команды 0x10 config_lmac_bf_sm (8) */
extern volatile u32 maintain_txss_timeout;           /* 0x80009c: [gp,-0xe8]: таймаут TXSS сопровождения (30000) */
extern volatile u32 pcp_mid_timer_flag;              /* 0x8000a0: [gp,-0xe4]: флаг PCP по mid (vendor: [0x8000a0 + mid·4], add2 + st.as [r0,-0x39]); пишут 0 pcp_start/stop__cancel_timer и vring_tbl__init, читателей не найдено */
extern volatile u32 temp_bb_mdeg;                    /* 0x8000a4: [gp,-0xe0]: температура BB (м°C, -1 — неизвестна) */
extern volatile u32 temp_pending_ctx;                /* 0x8000ac: [gp,-0xd8]: ctx ожидающего запроса температуры */
extern volatile u32 l2mgr_pending_ops;               /* 0x8000b0: [gp,-0xd4]: маска ожидающих операций l2mgr (0 скан, 1 connect, 2 disconnect…) */
extern volatile u32 tx_flush_cid_mask;               /* 0x8000b4: [gp,-0xd0]: маска cid в сбросе TX */
extern volatile u32 l2mgr_connect_mid;               /* 0x8000b8: [gp,-0xcc]: mid текущего CONNECT */
extern u32 chsw_cur_channel;                         /* 0x8000bc: [gp,-0xc8]: текущий канал переключателя каналов */
extern volatile u32 chsw_active_channel;             /* 0x8000c0: [gp,-0xc4]: активный канал (0xffff в образе); regd/mcs-проверки страны только при 0 */
extern volatile u32 wmi_connect_count;               /* 0x8000cc: [gp,-0xb8]: счётчик WMI_CONNECT_CMDID */
extern volatile u32 wmi_scan_count;                  /* 0x8000d0: [gp,-0xb4]: счётчик WMI_START_SCAN_CMDID */
extern u32 dbg_mbox_inited;                          /* 0x8000d4: [gp,-0xb0]: debug mbox инициализирован */
extern volatile u32 conn_false_alarm_timer;          /* 0x8000dc: [gp,-0xa8]: таймер проверки частоты ложных тревог (потерь связи) */
extern volatile u32 info_flow_timer;                 /* 0x8000ec: [gp,-0x98]: таймер информационного потока */
extern volatile u32 pcp_started;                     /* 0x8000f0: [gp,-0x94]: 1 — PCP запущен (pcp_start/pcp_stop cancel_timer) */
extern volatile u32 temp_last_meas_time;             /* 0x8000f4: [gp,-0x90]: время последнего измерения температуры (-1 — не было) */
extern volatile u32 wbe_link_up_timer;               /* 0x8000f8: [gp,-0x8c]: таймер «связь поднята» WBE_DRIVER */
extern volatile u32 calib_lo_power_fields;           /* 0x8000fc: [gp,-0x88]: указатель полей последнего шага LO-power */
extern volatile u32 lt_bf_max_goodput;               /* 0x800100: [gp,-0x84]: максимум TX goodput (long-term BF) */
extern volatile u32 maintain_paused;                 /* 0x800104: [gp,-0x80]: сопровождение линка на паузе */
extern u32 wmi_op_mbox_inited;                       /* 0x80010c: [gp,-0x78]: operational mbox инициализирован */
extern volatile u32 power_source;                    /* 0x80011c: [gp,-0x68]: источник питания из WMI_POWER_MGMT_CFG (у vendor — «ps_profile»); бит 0 — в PCP factor */
extern volatile u32 pcie_dbg_rearm_timer;            /* 0x800138: [gp,-0x4c]: таймер перевзвода отладочных прерываний PCIe (код 0) */
extern volatile u32 conn_link_lost_rm_req;           /* 0x80013c: [gp,-0x48]: заявка radio_mgr на обработку потери связи */
extern volatile u32 temp_radio_req;                  /* 0x800140: [gp,-0x44]: заявка radio_mgr службы температуры */
extern volatile u32 temp_stopping;                   /* 0x800150: [gp,-0x34]: служба температуры останавливается */
extern u32 calib_engine_sm_name_id;                  /* 0x800158: [gp,-0x2c]: ид строки имени автомата движка калибровки 0x802234 («CALIB_ENGINE») */
extern u32 maintain_sm_name_id;                      /* 0x80015c: [gp,-0x28]: ид строки имени maintain_sm 0x802cc4 («MAINTAIN_SM») */
extern u32 lm_sm_name_id;                            /* 0x800160: [gp,-0x24]: ид строки имени lm_sm 0x802da0 («LM_MAIN_SM») */
extern u32 link_stats_sm_name_id;                    /* 0x800164: [gp,-0x20]: ид строки имени автомата статистики линка 0x802f58 («LINK_STATS_SM») */
extern u32 tx_ch_switch_paused;                      /* 0x800168: [gp,-0x1c]: TX приостановлен для переключения канала */
extern u32 calib_sys_state;                          /* 0x800170: [gp,-0x14]: системное состояние калибровки (3/4 — ассоц.) */
extern volatile u32 temp_enabled;                    /* 0x800174: [gp,-0x10]: служба температуры разрешена (m_temp_enabled) */
extern volatile u32 rf_kill_stop_stages;             /* 0x800178: [gp,-0xc]: этапы останова RF kill (б0 TX, б1 скан, б2 PCP) */
extern volatile u32 temp_timer_task;                 /* 0x80017c: [gp,-0x8]: задача таймера службы температуры */
extern u32 sched_hw_deadline;                        /* 0x800180: [gp,-0x4]: срок, запрограммированный в аппаратный таймер u_schd */
extern u32 pring_done_arg;                           /* 0x80018c: [gp,0x8]: аргумент обработчика завершения остановки pring */
extern volatile u32 rf_kill_hw;                      /* 0x800190: [gp,0xc]: RF kill: аппаратный W_DISABLE */
extern volatile u32 rf_kill_sw;                      /* 0x800194: [gp,0x10]: RF kill: программный */
extern volatile u32 sched_ready_mask;                /* 0x80019c: [gp,0x18]: маска готовых приоритетов u_schd */
extern u32 rf_kill_sm_name_id;                       /* 0x8001b8: [gp,0x34]: ид строки имени rf_mgmt_sm 0x802338 («RF_KILL_SM») */
extern u32 mlme_sm_name_id;                          /* 0x8001bc: [gp,0x38]: ид строки имени автомата MLME 0x802458 («MLME_SM») */
extern u32 conn_msm_name_id;                         /* 0x8001c0: [gp,0x3c]: ид строки имени conn_main_sm 0x802744 («CONN_MSM») */
extern u32 disconn_sm_name_id;                       /* 0x8001c4: [gp,0x40]: ид строки имени автомата разрыва 0x8027a0 («DISCONN_SM») */
extern u32 ba_sm_name_id;                            /* 0x8001c8: [gp,0x44]: ид строки имени ba_sm 0x80296c («BA_SM») */
extern u32 ba_setup_sm_name_id;                      /* 0x8001cc: [gp,0x48]: ид строки имени ba_setup_sm 0x802b50 («BA_SETUP_SM») */
extern u32 wait_sm_name_id;                          /* 0x8001d0: [gp,0x4c]: ид имени wait_sm 0x802ba0 — в образе 0x802c25, не токен строки (так у vendor) */
extern u32 channels_switch_sm_name_id;               /* 0x8001d4: [gp,0x50]: ид строки имени channels_switch_sm 0x802fb4 («CHANNELS_SWITCH_SM») */
extern u32 swc_psc_sm_name_id;                       /* 0x8001d8: [gp,0x54]: ид строки имени swc_psc_sm 0x8030e0 («SWC_PSC_SM») */
extern u32 find_main_sm_name_id;                     /* 0x8001dc: [gp,0x58]: ид строки имени find_sm 0x8030f4 («FIND_MAIN_SM») */
extern u32 rm_sm_name_id;                            /* 0x8001e0: [gp,0x5c]: ид строки имени автомата rm_sm (журнал) */
extern u32 rm_chsw_sm_name_id;                       /* 0x8001e4: [gp,0x60]: ид строки имени автомата rm_ch_switch_sm (журнал) */
extern u32 mlme_sm_created;                          /* 0x8001f0: [gp,0x6c]: автомат 0x802458 (mlme_sm) создан */
extern u32 txq_count;                                /* 0x8001f4: [gp,0x70]: число TX-очередей (10) */
extern u32 u_schd_hw_timer_limit;                    /* 0x8001f8: [gp,0x74]: предел аппаратного таймера u_schd (0xa50; u_schd_timer_init → RGF 0x880248) */
extern u16 macq_reg_c70_val;                         /* 0x8001fc: [gp,0x78]: значение 0x886c70[15:0] (по умолчанию 0xc8) */
extern u16 macq_reg_c74_val;                         /* 0x8001fe: [gp,0x7a]: значение 0x886c74[7:0] (по умолчанию 0x40) */
extern volatile u16 macq_desc_mpdu_len;              /* 0x800200: [gp,0x7c]: поле w0[19:6] дескриптора MACQ (0x5dc / 0x320) */
extern u16 macq_desc_w1_len;                         /* 0x800202: [gp,0x7e]: поле w1[12:0] дескриптора MACQ (0x64 / 0x17) */
extern u16 macq_desc_field0e;                        /* 0x800204: [gp,0x80]: полуслово +0xe дескриптора MACQ */
extern volatile u16 dbg_pll5_unlock_count;           /* 0x800208: [gp,0x84]: счётчик прерываний PLL5 UNLOCK */
extern volatile u16 find_search_mult;                /* 0x80020a: [gp,0x86]: множитель длительности поиска (тихий режим) */
extern volatile u16 rx_chain_payload_size;           /* 0x80020c: [gp,0x88]: размер payload RX-цепочки */
extern volatile s16 temp_bb_otp_tamb;                /* 0x80020e: [gp,0x8a]: Tamb калибровки BB-сенсора из flash/OTP (flash_cfg__set_bb_sensor_calib, stw.as [gp,0x45]); -1 — нет (TEMPERATURE_SERVICE__consume_bb_sensor_calibration_parameters) */
extern volatile s16 temp_bb_otp_t0;                  /* 0x800210: [gp,0x8c]: начальная температура калибровки BB-сенсора (stw.as [gp,0x46]); -1 — нет */
extern volatile u16 l2mgr_connect_vs_mode;           /* 0x800212: [gp,0x8e]: параметр CONNECT (reserved1[0] или 1); == 1 — старый Wilocity VS */
extern volatile u16 regd_country_code;               /* 0x800214: [gp,0x90]: код страны (BE u16: 0x4a50 «JP», 0x5553 «US»; regulatory_domain__set_country_code, regd__is_country_*, mcs__is_restricted — ldw_s [gp,0x90]) */
extern u8 unk_800216;                                /* 0x800216: [gp,0x92]: vendor crt0 (0x8c16f2 stb r0,[gp,0x92]) обнуляет перед конструкторами; других обращений в vendor fw нет (поиск [gp,0x92]/0x800216 по 6.2/src/asm/fw) */
extern volatile u8 calib_lo_power_low_thr;           /* 0x800217: [gp,0x93]: нижний порог |I| (<< shift+2) LO power/battery; опорная коррекция VGA DC = порог + 2 (образ 8) */
extern u8 chsw_rx_table_index;                       /* 0x800218: [gp,0x94]: принудительный индекс RX-таблицы ABIF */
extern u8 chsw_rx_table_force;                       /* 0x800219: [gp,0x95]: != 0 — принудить индекс RX-таблицы ABIF */
extern u8 chsw_rx_agc_steps_disable;                 /* 0x80021a: [gp,0x96]: != 0 — запретить AGC-шаги RX в hwm__apply_channel_config */
extern volatile u8 link_bad_first_thr;               /* 0x80021b: [gp,0x97]: порог событий первого окна conn__check_bad_link (образ 20) */
extern volatile u8 link_bad_thr;                     /* 0x80021c: [gp,0x98]: порог событий окна conn__check_bad_link (образ 200) */
extern u8 calib_bb_gain_tbl_skip_mode3;              /* 0x80021d: [gp,0x99]: != 0 при режиме RF 3 — hwf_calib_bb_gain_create_table не строит таблицу (образ 1) */
extern volatile u8 temp_comp_clk_pulses;             /* 0x80021e: [gp,0x9a]: число тактов (бит 8 0x880b00) перед чтением компаратора сенсора */
extern u8 calib_all_lo_power_en;                     /* 0x80021f: [gp,0x9b]: != 0 — hwf_calib_all выполняет шаг LO power (образ 1) */
extern u8 calib_all_lo_power_reset_done;             /* 0x800220: [gp,0x9c]: 0 — первый раз сбросить результаты LO power (ставится 1), иначе прогон движка 0x80676c (образ 1) */
extern u8 calib_all_silent_rssi_en;                  /* 0x800221: [gp,0x9d]: == 1 — hwf_calib_all выполняет silent RSSI движка 4 по всем RF (образ 1) */
extern u8 calib_rx_gain_est_mode;                    /* 0x800222: [gp,0x9e]: режим calib_corr__estimate_and_apply_rx_gain: 0 — из сохранённого, 1 — два поиска, 2 — одно измерение (образ 1) */
extern u8 calib_rx_gain_est_offset;                  /* 0x800223: [gp,0x9f]: смещение индекса RX-таблицы при оценке RX-усиления (образ 3) */
extern volatile u8 calib_lo_power_meas_shift;        /* 0x800224: [gp,0xa0]: сдвиг измерения calib_lo_power_measure (substep / режим 2 оценки; образ 0xa) */
extern u8 calib_if_gain_always_apply;                /* 0x800225: [gp,0xa1]: == 1 — if_gain применяет AGC-таблицу и при повторной калибровке (образ 0) */
extern u8 calib_if_gain_force_agc_idx;               /* 0x800226: [gp,0xa2]: при режиме RF 3 и ≥ 1 — if_gain в конце применяет AGC-таблицу с этим индексом (образ 0xf) */
extern volatile u8 rf_if_gain_rssi_ofs;              /* 0x800227: [gp,0xa3]: поправка IF gain в расчёте RSSI (rx_energy__calc_rssi_q4, if_gain) */
extern u8 calib_if_gain_ref;                         /* 0x800228: [gp,0xa4]: опорный уровень IF gain ([0x8067bc+0x12]) в расчёте поправки if_gain (образ 0x17) */
extern u8 calib_if_gain_settle_delay;                /* 0x800229: [gp,0xa5]: пауза (×80 nop) после переключения петли CAF в IF_GAIN__GAIN; 0 — без паузы (образ 2) */
extern volatile u8 link_bad_win_enable;              /* 0x80022a: [gp,0xa6]: != 0 — взводить окно проверки плохой связи (channels_switch__check) */
extern u8 fw_build_day;                              /* 0x80022b: [gp,0xa7]: дата сборки fw — день («FW date = %02d/%02d/%d») */
extern u8 fw_build_hour;                             /* 0x80022c: [gp,0xa8]: время сборки fw — часы («FW time = %02d:%02d:%02d») */
extern u8 fw_build_min;                              /* 0x80022d: [gp,0xa9]: время сборки fw — минуты */
extern u8 fw_build_month;                            /* 0x80022e: [gp,0xaa]: дата сборки fw — месяц */
extern u8 fw_build_sec;                              /* 0x80022f: [gp,0xab]: время сборки fw — секунды */
extern u8 fw_build_year;                             /* 0x800230: [gp,0xac]: дата сборки fw — год (две цифры) */
extern volatile u8 conn_multi_omni_count;            /* 0x800231: [gp,0xad]: число направленных omni-секторов RX (WMI multi_directed_omnis, ≥ 1) */
extern u8 vring_pring_stop_max_polls;                /* 0x800232: [gp,0xae]: предел перевзводов таймера останова pring (образ 5) */
extern volatile u8 calib_lo_power_level;             /* 0x800233: [gp,0xaf]: сохранённый уровень LO power (calib_lo_power__save_level; образ 0xc) */
extern volatile u8 rf_fs8_unlock_fatal;              /* 0x800234: [gp,0xb0]: != 0 — «FS8 UNLOCK» (вектор 13, бит 7) → фатал 0x12ee */
extern volatile u8 rf_chain_sector_desc_f4;          /* 0x800235: [gp,0xb1]: поле 4..7 дескриптора сектора rf_chain; fixed_sched__start = 0 */
extern volatile u8 sched_fixed_active;               /* 0x800236: [gp,0xb2]: фиксированное расписание запущено (0 в STA, 1 в AP); режим окна MACQ */
extern u8 chsw_rx_agc_step_c0_lo;                    /* 0x800237: [gp,0xb3]: AGC-шаг → 0x8831c0[5:0] (hwd_phy__rx_agc_steps_disable(0); образ 0x1b) */
extern u8 chsw_rx_agc_step_c0_hi;                    /* 0x800238: [gp,0xb4]: AGC-шаг → 0x8831c0[11:6] (образ 0x1b) */
extern u8 chsw_rx_agc_step_c4_lo;                    /* 0x800239: [gp,0xb5]: AGC-шаг → 0x8831c4[5:0] (образ 0x1d) */
extern u8 chsw_rx_agc_step_c4_hi;                    /* 0x80023a: [gp,0xb6]: AGC-шаг → 0x8831c4[11:6] (образ 0x1d) */
extern volatile u8 calib_first_run_delay_en;         /* 0x80023b: [gp,0xb7]: первый запуск движка калибровки — с задержкой [0x800388] */
extern u8 qdesc_w3_field_a;                          /* 0x80023c: [gp,0xb8]: qdesc_cfg — поле слова 3 дескриптора очереди (биты 0..2) */
extern u8 qdesc_w4_field;                            /* 0x80023d: [gp,0xb9]: qdesc_cfg — поле слова 4 дескриптора очереди (биты 17..20) */
extern u8 qdesc_w3_field_b;                          /* 0x80023e: [gp,0xba]: qdesc_cfg — второе поле слова 3 дескриптора очереди (биты 14..16) */
extern volatile u8 rf_pll5_unlock_fatal;             /* 0x80023f: [gp,0xbb]: != 0 — «PLL5 UNLOCK» (вектор 13, бит 2) → фатал 0x12ec */
extern volatile u8 scan_find_default_channel;        /* 0x800240: [gp,0xbc]: канал find_sm по умолчанию ([find_mngr+0x10], образ 2) */
extern volatile u8 rf_kill_hw_force;                 /* 0x800241: [gp,0xbd]: != 0 — W_DISABLE считается RF kill без программного флага */
extern volatile u8 rf_active_mask;                   /* 0x800242: [gp,0xbe]: маска активного RF-модуля (младший бит маски RF; RFCA) */
extern volatile u8 rf_connected_mask;                /* 0x800243: [gp,0xbf]: маска подключённых RF-модулей (init_rf_hw; с сенсором температуры) */
extern u8 rf_restore_sets_delay;                     /* 0x800244: [gp,0xc0]: пауза rfc__restore_txrx_sets_fw (×32), растёт в powerup_deep */
extern u8 rf_rdac_val;                               /* 0x800245: [gp,0xc1]: результат калибровки BB RDAC (hwd_rfc_read_calibrate; поле 0x889154[15:12] − 6) */
extern u8 calib_silent_rssi_agc_ofs_mode3;           /* 0x800246: [gp,0xc2]: s8-поправка начального значения AGC silent RSSI при режиме RF 3 ([0x800508] − 11 + это; образ 6) */
extern volatile u8 bf_last_id;                       /* 0x800247: [gp,0xc3]: копия последнего BF id соединения ([conn+0x18d]) */
extern volatile u8 rx_chain_cfg_mode;                /* 0x800248: [gp,0xc4]: режим цепочки RX (rx_chain__get_cfg_mode; ×2 — размер окна, образ 0x20) */
extern volatile u8 dbg_sysassert_wmi_lock;           /* 0x800249: [gp,0xc5]: g_sysassert_wmi_lock — после ассерта ждать, пока отладчик не сбросит */
extern volatile u8 dbg_sysassert_hold;               /* 0x80024a: [gp,0xc6]: != 0 — после ассерта держать ядро и обслуживать mbox опросом */
extern u8 calib_silent_rssi_target_ofs_mode3;        /* 0x80024b: [gp,0xc7]: s8-поправка цели silent RSSI модуля при режиме RF 3 (+[obj+0xb4]; образ 0) */
extern volatile u8 wmi_notify_req_count;             /* 0x80024c: [gp,0xc8]: счётчик WMI_NOTIFY_REQ (0..59, wmi__bump_cmd_counter) */
extern volatile u8 ps_lmac_evt_cid_mask;             /* 0x80024d: [gp,0xc9]: байт 3 последнего PS-события LMAC — маска cid */
extern u8 calib_scheme_enabled;                      /* 0x80024e: [gp,0xca]: калибровка по схеме разрешена (1 после power_mngr_init на ASIC; у vendor PS-события 17/20 → 0, 18/21 → 1) */
extern volatile u8 wmi_sw_tx_cid;                    /* 0x80024f: [gp,0xcb]: cid соединения кадра SW TX (ждёт link_up_evt) */
extern u8 chsw_configured;                           /* 0x800250: [gp,0xcc]: канал уже настроен */
extern volatile u8 link_first_fbf_max_tries;         /* 0x800251: [gp,0xcd]: число попыток первого FBF до SELF_FBF_FAIL (образ 3) */
extern u8 chsw_pcp_ap_mode;                          /* 0x800252: [gp,0xce]: режим PCP/AP */
extern volatile u8 pcie_link_up_mask;                /* 0x800253: [gp,0xcf]: WBE_DRIVER::link_up_notif — биты пришедших уведомлений (7 — все) */
extern volatile u8 calib_lo_power_gc_ctrl;           /* 0x800254: [gp,0xd0]: LO power calib — GC ctrl (flash_cfg) */
extern volatile u8 calib_lo_power_stg2_bias;         /* 0x800255: [gp,0xd1]: LO power calib — stg2 bias (flash_cfg) */
extern volatile u8 calib_lo_power_xif_gc;            /* 0x800256: [gp,0xd2]: LO power calib — XIF GC (flash_cfg) */
extern volatile u8 tx_mgmt_retry_limit;              /* 0x800257: [gp,0xd3]: предел повторов mgmt-кадров − 1 (WMI set_mgmt_retry_limit) */
extern volatile u8 mid_open_bitmap;                  /* 0x800259: [gp,0xd5]: битовая карта открытых mid */
extern volatile u8 pcp_active_count;                 /* 0x80025a: [gp,0xd6]: число активных PCP */
extern volatile u8 conn_bf_id_win_len;               /* 0x80025b: [gp,0xd7]: длина скользящего окна BF id (степень 2) и предел повторов таймера */
extern u8 sched_hw_timer_queue;                      /* 0x80025c: [gp,0xd8]: очередь u_schd, на которую взведён HW-таймер (2 — нет) */
extern u32 phy_default_rx_swap_iq;                   /* 0x800260: [gp,0xdc]: g_default_rx_swap_iq — [0x883038] == 3 при загрузке (hwd_PHY_STORE_TXRX_SWAP_IQ); режим 2 set_rx_swap_iq (образ 3) */
extern u32 phy_default_tx_swap_iq;                   /* 0x800264: [gp,0xe0]: g_default_tx_swap_iq — [0x884028] == 3 при загрузке; режим 2 set_tx_swap_iq (образ 3) */
extern u8 boot_uc_shared_field28;                    /* 0x800270: [gp,0xec]: значение слова [ucode-конфиг [0x80016c]+0x28] при boot_publish_ids */
extern u8 calib_battery_thr[4];                      /* 0x800278: [gp,0xf4]: пороги battery-детектора по индексу (hwd_abif_battery_config → 0x88afbc), образ {0,3,5,9} */
extern volatile u8 calib_vga_dc_shift;               /* 0x80027c: [gp,0xf8]: сдвиг измерения VGA DC (hwf_vga_dc_calibrate; также shift петли calib__setup_loopback_hw_b; образ 0xd) */
extern volatile u8 calib_vga_dc_thr;                 /* 0x80027d: [gp,0xf9]: порог hwf_vga_dc_calibrate (образ 4) */
extern volatile u8 calib_vga_dc_fixed_gain;          /* 0x80027e: [gp,0xfa]: VGA gain на время калибровки VGA DC; < 0 (s8) — вместо усиления аттенюатор (образ 0xff) */
extern u8 disc_probe_sa_oui[3];                      /* 0x800280: [gp,0xfc]: OUI из SA кадра discovery (discovery__init_probe_entry); 04:ce:14 (Wilocity) без VS-элемента — features_ver = 0 */
extern volatile u16 sched_ext_b_hi;                  /* 0x800284: [gp,0x100]: 13-битное поле [28:16] регистра 0x88c06c (mid__program_88c068) */
extern volatile u16 sched_ext_a_hi;                  /* 0x800288: [gp,0x104]: 13-битное поле [28:16] регистра 0x88c068 */
extern volatile u16 sched_ext_b_lo;                  /* 0x80028c: [gp,0x108]: 13-битное поле [12:0] регистра 0x88c06c */
extern volatile u16 sched_ext_a_lo;                  /* 0x800290: [gp,0x10c]: 13-битное поле [12:0] регистра 0x88c068 */
extern volatile u16 pcie_l1_enter_count;             /* 0x800294: [gp,0x110]: счётчик прерываний LTSSM «вход в L1» (вектор 18) */
extern volatile u16 pcie_l1_exit_count;              /* 0x800296: [gp,0x112]: счётчик прерываний LTSSM «выход из L1» (вектор 18) */
extern volatile u16 dbg_sysassert_mbox_irq_count;    /* 0x800298: [gp,0x114]: счётчик причин mbox, обслуженных в ожидании после ассерта */
extern volatile u16 rf_fs8_unlock_count;             /* 0x80029a: [gp,0x116]: счётчик «FS8 UNLOCK» (вектор 13, бит 7) */
extern u16 qdesc_w10_field;                          /* 0x80029c: [gp,0x118]: qdesc_cfg — поле слова 10 дескриптора очереди (биты 20..29) */
extern u32 crt0_bss_clear_en;                        /* 0x8002a0: [gp,0x11c]: vendor crt0 (0x8c168c): != 0 — обнулить bss/periph перед fw_main (образ 1; наш start.S обнуляет всегда) */
extern u32 tx_api_state_word;                        /* 0x8002a4: [gp,0x120]: только обнуляется tx_api__reset_state_words (vendor не читает) */
extern volatile u32 rx_reorder_sw;                   /* 0x8002a8: [gp,0x124]: WMI_CFG_RX_CHAIN reorder_type == 1 (SW reorder) — HW reorder выкл. */
extern u32 ba_addba_retry_delay;                     /* 0x8002ac: [gp,0x128]: задержка повтора ADDBA Req, мкс (образ 100 мс) */
extern u32 ba_addba_resp_timeout;                    /* 0x8002b0: [gp,0x12c]: ожидание ADDBA Resp, мкс (образ 1 с) */
extern u32 ba_setup_total_timeout;                   /* 0x8002b8: [gp,0x134]: общий таймер установки BA, мкс (образ ≈32 с) */
extern volatile u32 link_bad_win_period;             /* 0x8002bc: [gp,0x138]: период окна conn__check_bad_link, мкс (образ 3 с) */
extern volatile u32 link_bad_first_thr_alt;          /* 0x8002c0: [gp,0x13c]: порог первого окна при бите 3 [0x803c20] (вместо link_bad_first_thr) */
extern volatile u32 link_bad_thr_alt;                /* 0x8002c4: [gp,0x140]: порог окна при бите 3 [0x803c20] (вместо link_bad_thr) */
extern volatile u32 temp_sense_disable;              /* 0x8002c8: [gp,0x144]: != 0 — запрет temp_sense__read_and_check */
extern volatile s32 temp_bb_calib_ofs;               /* 0x8002cc: [gp,0x148]: калибровка BB-сенсора ((T0 − Tamb) / 100) << 13 (consume_bb_sensor_calibration_parameters), прибавляется к отсчёту BB */
extern volatile u32 temp_bb_calibrated;              /* 0x8002d0: [gp,0x14c]: калибровка BB-сенсора из OTP получена */
extern volatile u32 pcp_bcon_interval;               /* 0x8002d4: [gp,0x150]: интервал бикона, TU (beacon_interval/PCP start; образ 100) */
extern volatile u32 fw_data_fresh_magic;             /* 0x8002d8: [gp,0x154]: 0x11111111 из образа → 0x22222222; иначе рестарт без перезагрузки образа */
extern u32 pring_tx_cnt_base_88;                     /* 0x8002dc: [gp,0x158]: база счётчика MAC TX [+0x88] (sm_pring_latch_tx_counters) */
extern volatile u32 pring_tx_cnt_base_10;            /* 0x8002e0: [gp,0x15c]: база счётчика MAC TX [+0x10] */
extern volatile u32 mlme_assoc_timeout_ms;           /* 0x8002e4: [gp,0x160]: таймер ассоциации, мс (образ 3000) */
extern volatile u32 link_high_per_check_en;          /* 0x8002e8: [gp,0x164]: EVT_CONSECUTIVE_HIGH_PER — проверять соединение */
extern volatile u32 mlme_host_ctrl_timeout_ms;       /* 0x8002ec: [gp,0x168]: ожидание решения хоста (split MAC), мс (образ 5000) */
extern volatile u32 eapol_builder_obj;               /* 0x8002f0: [gp,0x16c]: объект eapol_frame_builder (= vtable 0x8006f4) */
extern volatile u32 conn_assoc_ready_check_en;       /* 0x8002f4: [gp,0x170]: != 0 — assoc_ready_check_trig работает */
extern u32 bf_fail_inject_cnt;                       /* 0x8002f8: [gp,0x174]: счётчик событий BF done для имитации неудач */
extern u32 chsw_skip_calib_state;                    /* 0x8002fc: [gp,0x178]: != 0 — switch_on не шлёт калибровке системное состояние 1 */
extern volatile u32 phy_dbg_clk_delay;               /* 0x800300: [gp,0x17c]: одноразовая пауза ×80 после hwd_phy_dbg_clk_enable */
extern volatile u32 conn_skip_bcon_wait;             /* 0x800304: [gp,0x180]: != 0 — OWN_START_LINK без ожидания бикона пира */
extern u32 power_33khz_clk_detect;                   /* 0x800308: [gp,0x184]: результат hwm_power_33kHz_clk_detector (power_mngr_init) */
extern u32 bf_fail_inject_en;                        /* 0x80030c: [gp,0x188]: != 0 — каждое событие BF done, кроме N-го, — неудача */
extern volatile u32 mac_phy_irq_count;               /* 0x800310: [gp,0x18c]: счётчик прерывания MAC/PHY (вектор 12) */
extern u32 l2mgr_mac_post_bringup_en;                /* 0x800314: [gp,0x190]: != 0 — в конце l2mgr__mac_bringup доп. регистры MAC (l2mgr_post_bringup) */
extern u32 bf_fail_inject_period;                    /* 0x800318: [gp,0x194]: N для bf_fail_inject_en (образ 7) */
extern volatile u32 pcie_dbg_irq_count;              /* 0x80031c: [gp,0x198]: счётчик прерывания PCIe debug (вектор 15) */
extern volatile u32 pcie_dbg_fifo_irq_count;         /* 0x800328: [gp,0x1a4]: счётчик wbe_driver__pcie_debug_isr со статусом ≠ 0 */
extern u32 gpio19_pulse_count;                       /* 0x80032c: [gp,0x1a8]: счётчик импульсов GPIO 19 (0x880b60); сброс в debug_mbox__get_or_init */
extern volatile u32 dbg_mbox_draining;               /* 0x800330: [gp,0x1ac]: идёт mbox__drain_debug */
extern u32 txrx_dma_irq_count;                       /* 0x80033c: [gp,0x1b8] (ld.as [gp,0x6e]): число RX/TX-DMA прерываний (txrx_mgr_handle_dma_irq) */
extern u32 dma_cpl_timeout_val;                      /* 0x800340: [gp,0x1bc]: значение таймаута завершения DMA (0x881c88), записанное первым */
extern u32 dpal_cpl_timeout_seen;                    /* 0x800344: [gp,0x1c0]: таймаут завершения DPAL уже зафиксирован (значение в 0x800340), повтор с другим — ассерт */
extern volatile u32 pring_stop_timeout;              /* 0x800348: [gp,0x1c4]: таймаут остановки pring (420000) */
extern volatile u32 dbg_assert_caller;               /* 0x80034c: [gp,0x1c8]: адрес вызова последнего fw_sysassert_fatal */
extern volatile u32 dbg_assert_code;                 /* 0x800350: [gp,0x1cc]: код последнего fw_sysassert_fatal */
extern volatile u32 dbg_assert_code2;                /* 0x800354: [gp,0x1d0]: код последнего fw_sysassert_fatal (вторая копия, vendor пишет оба) */
extern u32 sysapi_hw_flows_log_timer;                /* 0x800358: [gp,0x1d4]: таймер периодического журнала HW flows (UT-команда 38), 0 — не запланирован */
extern u32 tx_fw2fw_test;                            /* 0x800368: [gp,0x1e4]: g_fw_2_fw_test: следующий кадр данных — тестовый FW2FW (WMI debug TX) */
extern u32 tx_lifetime_shift;                        /* 0x80036c: [gp,0x1e8]: сдвиг единиц lifetime TX-дескриптора (10) */
extern u32 l2_false_alarm_count;                     /* 0x800370: [gp,0x1ec]: счётчик ложных тревог (потерь связи) high false alarm */
extern u32 l2_false_alarm_lock_time;                 /* 0x800374: [gp,0x1f0]: длительность последнего захвата радио при потере связи (мкс×16) */
extern volatile u32 pcie_perst_assert_irq_en;        /* 0x800378: [gp,0x1f4]: разрешить прерывание PERST assert (1) */
extern volatile u32 pcie_perst_cfg_fix_en;           /* 0x80037c: [gp,0x1f8]: правка DBI 0x10/0x14 в pcie_perst_handler_step (1) */
extern u32 rf_rfc_div_restart_count;                 /* 0x800384: [gp,0x200]: счётчик перезапусков делителя RFC */
extern u32 calib_first_run_delay;                    /* 0x800388: [gp,0x204]: задержка первого запуска движка калибровки, мкс (20000) */
extern volatile u32 temp_first_meas_done;            /* 0x80038c: [gp,0x208]: первое измерение температуры выполнено (UT 10/32 — статус) */
extern u32 qdesc_txq_cfg_custom;                     /* 0x800390: [gp,0x20c]: != 0 — поля 0x886c70/c74/+0xe дескриптора из конфигурации, иначе дефолт */
extern u32 qdesc_cfg_override;                       /* 0x800394: [gp,0x210]: override конфигурации дескрипторов очередей/секторов (1) */
extern u32 qdesc_cfg_flag_bit3;                      /* 0x800398: [gp,0x214]: бит 3 слова 0 дескриптора (override-ветка) */
extern u32 qdesc_cfg_flag_bit13;                     /* 0x80039c: [gp,0x218]: бит 13 слова 1 дескриптора (override-ветка) */
extern u32 qdesc_txq_enable;                         /* 0x8003a0: [gp,0x21c]: «TXQ enable» дескриптора (кэш значения или дефолта 1) */
extern u32 qdesc_override_bit0;                      /* 0x8003a4: [gp,0x220]: бит 0 слова 1 секторного дескриптора при override (1) */
extern u32 qdesc_sector_field16;                     /* 0x8003a8: [gp,0x224]: поле 16..20 слова 0 секторного дескриптора, режим 4 (12) */
extern u32 qdesc_txq_enable_custom;                  /* 0x8003ac: [gp,0x228]: != 0 — qdesc_txq_enable из конфигурации, иначе 1 */
extern volatile u32 led_enabled;                     /* 0x8003b0: [gp,0x22c]: LED-драйвер включён (hw_ch_enable_once) */
extern volatile u32 led_rate_thr_high;               /* 0x8003b4: [gp,0x230]: порог goodput для LED-схемы 3 (60) */
extern volatile u32 led_rate_thr_low;                /* 0x8003b8: [gp,0x234]: порог goodput для LED-схемы 2 (иначе 1) */
extern volatile u32 led_scheme_channel;              /* 0x8003bc: [gp,0x238]: LED-канал текущей схемы (2) */
extern volatile u32 link_stats_latency_period;       /* 0x8003c0: [gp,0x23c]: период таймера задержки link_stats_sm (10000) */
extern volatile u32 link_det_log_interval;           /* 0x8003c4: [gp,0x240]: интервал журнала состояния детекторов (TSF, мкс) */
extern u32 lmac_ucode_ready;                         /* 0x8003c8: [gp,0x244]: ucode готов (EVENT_UCODE_READY), до этого LMAC-команды — ассерт */
extern volatile u32 bf_long_term_enable;             /* 0x8003cc: [gp,0x248]: разрешён долгосрочный BF-триггер (WMI_BF_CONTROL [7]) */
extern volatile u32 mac_cnt_clear_retry_count;       /* 0x8003d8: [gp,0x254]: повторы команды очистки счётчиков MAC (cnt_handler_clear_all) */
extern volatile u32 rx_macq_desc_cfg;                /* 0x8003dc: [gp,0x258]: слово конфигурации дескриптора RX MAC-очереди */
extern u32 rf_blkwr_last_fail_addr;                  /* 0x8003e0: [gp,0x25c]: первое слово (адрес) блока последней неудачной блочной записи RF */
extern u32 rf_blkwr_fail_count;                      /* 0x8003e4: [gp,0x260]: число неудачных блочных записей RF */
extern u32 rf_blkwr_retry_count;                     /* 0x8003e8: [gp,0x264]: суммарные повторы блоков записи RF */
extern u32 pcp_abft_sectors;                         /* 0x8003ec: [gp,0x268]: число секторов A-BFT (2..8, BCON_CTRL) */
extern u32 lmac_txop_limit;                          /* 0x8003f0: [gp,0x26c]: лимит TXOP для LMAC (2000; 0x500 в OOB) */
extern volatile u32 rx_mgmt_parsed_count;            /* 0x8003f4: [gp,0x270]: счётчик разобранных mgmt-кадров (rx_mgmt_prs__alloc_ei) */
extern u32 pcp_parser_rule2_en;                      /* 0x8003f8: [gp,0x274]: при старте PCP — правило MAC-парсера 2 = 0x3f02 */
extern u32 sta_key_timer_delay;                      /* 0x8003fc: [gp,0x278]: задержка таймеров установки ключа (10000) */
extern volatile u32 lm_linkup_fail_max;              /* 0x800400: [gp,0x27c]: неудач SELF_LINKUP подряд до «линк не поднят» (3) */
extern volatile u32 wmi_mbox_drain_active;           /* 0x800404: [gp,0x280]: идёт выборка mailbox WMI (для ассерта) */
extern volatile u32 hwm_33khz_poll_repeats;          /* 0x800414: [gp,0x290]: повторов «команда 0x63000002 + опрос» при ожидании 33 кГц (2) */
extern volatile u32 hwm_33khz_wait_repeats;          /* 0x800418: [gp,0x294]: повторов «команда 0x63000001 + выдержка» (2) */
extern u32 tx_cpl_err_count_en;                      /* 0x80041c: [gp,0x298]: считать TX-завершения с ошибкой в tx_cpl_err_count */
extern volatile u32 disc_probe_resp_rssi;            /* 0x800428: [gp,0x2a4]: RSSI последнего probe response (hwd_phy 0x883b80) */
extern volatile u32 boot_force_prod_mode_en;         /* 0x80042c: [gp,0x2a8]: MAIN(): принудительно включить production mode */
extern volatile u32 pcie_code0_isoc_restore_en;      /* 0x800440: [gp,0x2bc]: таймер кода 0: выключить обход ISOC и разрешить биты 9, 0 (1) */
extern volatile u32 pcie_code0_rearm_bit3_en;        /* 0x800444: [gp,0x2c0]: таймер кода 0: снова разрешить бит 3 отладочного блока (1) */
extern volatile u32 pcie_code0_timer_delay;          /* 0x800448: [gp,0x2c4]: задержка таймера кода 0 прерывания PCIe (30000000) */
extern u32 rf_kill_debounce_delay;                   /* 0x80044c: [gp,0x2c8]: задержка задачи RF kill после прерывания (2500) */
extern volatile u32 temp_rf_sensor_mult;             /* 0x800450: [gp,0x2cc]: множитель RF-сенсора температуры (5100) */
extern volatile u32 temp_rf_calibrated_mask;         /* 0x800454: [gp,0x2d0]: маска RF с прочитанной калибровкой сенсора */
extern u32 chsw_single_attempt;                      /* 0x800458: [gp,0x2d4]: != 0 — одна попытка переключения канала (иначе 10) */
extern u32 chsw_config_fail_count;                   /* 0x80045c: [gp,0x2d8]: счётчик неудач config_channel */
extern u32 rfc_wrv_last_fail_reg;                    /* 0x800460: [gp,0x2dc]: регистр последней неудачной записи RFC с проверкой */
extern u32 rfc_wrv_fail_count;                       /* 0x800464: [gp,0x2e0]: число неудачных записей RFC с проверкой */
extern u32 rfc_wrv_retry_count;                      /* 0x800468: [gp,0x2e4]: суммарные повторы записи RFC с проверкой */
extern u32 maint_initial_txss_timeout;               /* 0x80046c: [gp,0x2e8]: начальный таймаут TXSS maintain_sm до первого BF (10000000; 10000 при бите 6 0x803c20) */
extern u32 rx_short_frame_drop_count;                /* 0x800470: [gp,0x2ec]: счётчик RX-кадров короче 0x18 Б, отброшенных rx_pkt_srvs__dispatch */
extern volatile u32 mac_parser_mode_en;              /* 0x800474: [gp,0x2f0]: != 0 — режим MAC-парсера из аргумента, иначе 1 */
extern volatile u32 mac_parser_rule_f5_en;           /* 0x800478: [gp,0x2f4]: != 0 — поле 5 бит правила парсера пира = 0x1f */
extern volatile u32 disc_sw_data_active;             /* 0x80047c: [gp,0x2f8]: 1 при старте, 0 — SW-данные остановлены (disc_sm__sw_data_stopped); не читается */
extern u32 tx_cpl_err_count;                         /* 0x800480: [gp,0x2fc]: счётчик TX-завершений с ненулевым статусом */
extern volatile u32 scan_alloc_timeout;              /* 0x800484: [gp,0x300]: таймаут выделения радио для скана (1000000) */
extern volatile u32 scan_timeout;                    /* 0x800488: [gp,0x304]: таймаут скана (= 4·scan_alloc_timeout, конструктор) */
extern volatile u32 scan_validate_skip_state2;       /* 0x80048c: [gp,0x308]: разрешить пропуск проверки «MID в состоянии 2» при скане (1) */
extern volatile u32 sched_large_task_thr;            /* 0x8004a0: [gp,0x31c]: порог длительности задачи для журнала LARGE TASK (мкс×16, 100000) */
extern u8 dev_mac_addr[6];                           /* 0x8004a4: 0x8004a4: свой MAC-адрес (boot__save_mac_address из flash; l2mgr, PBSS, WMI_READY), образ 12:34:56:78:9a:bc */
extern u32 rf_sparrow_r_detect_en;                   /* 0x8004c0: [gp,0x33c]: разрешить распознавание Sparrow-R по счётчику RFC 0x428 (1) */
extern volatile u8 wmi_rf_sector_get_first;          /* 0x8004c4: [gp,0x340]: первый WMI_GET_RF_SECTOR_PARAMS — сбросить объект 0x80483c (1) */
extern volatile u8 wmi_rf_sector_set_first;          /* 0x8004c5: [gp,0x341]: первый WMI_SET_RF_SECTOR_PARAMS — сбросить объект 0x804848 (1) */
extern volatile u16 rf_pwr_on_hold;                  /* 0x8004c6: [gp,0x342]: выдержка включения RF, TSF (не меньше 0x2328; WMI_RF_PWR_ON_DELAY) */
extern volatile u16 rf_pwr_on_extra_delay;           /* 0x8004c8: [gp,0x344]: доп. задержка ×80×2 nop после SDP 4 = 1 (WMI_RF_PWR_ON_DELAY) */
extern u8 calib_lo_power_tidx_map[8];                /* 0x8004cc: 0x8004cc: индекс таблицы LO power режима 1 по lo_power_calib_get_table_idx (calib_lo_power_main), образ {0,0,0,4,0,4,4,6} */
extern volatile u32 scan_probe_timeout_us;           /* 0x8004e8: [gp,0x364]: таймаут ответа на probe при скане */
extern u32 bcon_pool_inited;                         /* 0x8004ec: 0x8004ec: пул 0x805a98 дескрипторов бикона инициализирован (лениво в add_bcon) */
extern u32 bcon_pool_empty_count;                    /* 0x8004f0: [gp,0x36c]: «pool is empty» — нет post-send-info для маяка (add_bcon) */
extern u32 led_blink_timer;                          /* 0x8004f4: [gp,0x370]: таймер LED-схемы (led_scheme_apply) */
extern volatile u32 rf_sysapi_rfc_req;               /* 0x8004f8: [gp,0x374]: заявка радио hw_sysapi_rfc_read_write_rgf, != 0 — занято */
extern volatile u8 hw_cfg_sdp_flags;                 /* 0x8004fc: [gp,0x378]: конфигурация SDP; пишет misc_ext.c, бит 0 (SDP 7 при выходе из deep sleep) больше не читается — сон вырезан */
extern volatile u32 rf_pwr_snap_tsf[2];              /* 0x800500: [gp,0x37c]: снимок TSF (64 бит) при снятии питания RF (sdp_drive_pin_timed v == 0); 0 — нет снимка */
extern u8 calib_agc_win_below;                       /* 0x800510: [gp,0x38c]: окно поиска AGC: вниз от старта (образ 4) */
extern u8 calib_agc_win_above;                       /* 0x800511: [gp,0x38d]: окно поиска AGC: вверх от старта (0x18) */
extern u8 calib_vga_dc_win_lo;                       /* 0x800512: [gp,0x38e]: окно VGA DC: нижняя граница (max(start − ниже, 1)) */
extern u8 calib_vga_dc_win_hi;                       /* 0x800513: [gp,0x38f]: окно VGA DC: верхняя граница (min(start + выше − 1, 0x3f)) */
extern u32 calib_vga_dc_fine_force;                  /* 0x800514: [gp,0x390]: разовый запрос G_RX_VGA_RANGE_CONFIG.VGA_DC_FINE_FORCE */
extern u8 calib_sar_idx;                             /* 0x800518: 0x800518: индекс/сдвиг SAR (calib_sar_step idx; маска петли 1<<idx), образ 0xc */
extern u8 calib_sar_thr;                             /* 0x800519: 0x800519: порог SAR-шага hwf_calib_sar_alg, образ 1 */
extern u8 calib_sar_skip_step2;                      /* 0x80051a: 0x80051a: != 0 — без calib_sar_step2 после SAR-итераций, образ 1 */
extern u32 calib_if_gain_retry_count;                /* 0x80051c: 0x80051c: число повторных if_gain (a0 = 1); 0 — при полной (a0 = 0) */
extern u32 ps_halt_dma_b27;                          /* 0x800520: бит 27 RGF DMA 0x881bf0, снятый в power_halt_seq (a = 1); 0 — шаг 7 при halt/wake */
extern volatile u32 phy_rx_stats_clear_time;         /* 0x800524: 0x800524: время u_schd последнего сброса статистики PHY RX */
extern volatile u8 abif_rx_stg1_fine_bias_sh[2];     /* 0x800530: сдвиг 4-битного fine-bias ступени 1 VGA по половине b (запись car.c, чтение abif_ext.c), образ {4,0xc} */
extern u8 abif_rx_vga_atten_sh[8];                   /* 0x800534: бит аттенюатора VGA, индекс (4 − col) + 4·sel (hwd_abif_rx_table_config_vga_atten) */
extern volatile u8 abif_rx_vga_atten_rd_sh[8];       /* 0x80053c: то же для чтения (hwd_abif_rx_table_read_vga_atten; копия таблицы) */
extern u8 abif_rx_vga_gain_word[8];                  /* 0x800544: слово строки RX-таблицы поля VGA gain, индекс (4 − col) + 4·sel (запись) */
extern u8 abif_rx_vga_gain_sh[8];                    /* 0x80054c: сдвиг 3-битного поля VGA gain (запись) */
extern u8 abif_rx_vga_dc_word[8];                    /* 0x800554: слово строки RX-таблицы поля VGA DC (запись) */
extern u8 abif_rx_vga_dc_sh[8];                      /* 0x80055c: сдвиг 5-битного поля VGA DC (запись) */
extern u8 abif_rx_vga_bias_sh[5];                    /* 0x800564: сдвиг 4-битного VGA bias ступени 1..5 (hwd_abif_rx_table_config_vga_bias) */
extern volatile u8 abif_rx_vga_bias_rd_sh[5];        /* 0x80056c: то же для чтения (hwd_abif_rx_table_read_vga_bias; копия таблицы) */
extern u8 abif_rx_vga_gain_rd_word[8];               /* 0x800574: слово поля VGA gain для чтения (hwd_abif_rx_table_read_vga_gain; копия) */
extern u8 abif_rx_vga_gain_rd_sh[8];                 /* 0x80057c: сдвиг поля VGA gain для чтения */
extern u8 abif_rx_vga_dc_rd_word[8];                 /* 0x800584: слово поля VGA DC для чтения (hwd_abif_rx_table_read_vga_dc; копия) */
extern u8 abif_rx_vga_dc_rd_sh[8];                   /* 0x80058c: сдвиг поля VGA DC для чтения */
extern u32 unk_800598[5];                            /* 0x800598: 0x800598: образ {1,0,0,0,1}; обращений vendor не найдено (код, указатели fw_data) */
extern u8 unk_8005c0;                                /* 0x8005c0: 0x8005c0: образ 1; поле +8 объекта 0x8005b8 (пустой конструктор 0x8c191c), обращений vendor не найдено */
extern u8 boot_halt_on_reset;                        /* 0x8005c1: 0x8005c1: == 1 — останов ядра (flag 1) при сбросе (vendor 0x8ed0d8 из cpu_reset_init; наш start.S не проверяет), образ 0 */
extern u32 fw_log_ring_en;                           /* 0x800968: 0x800968: 0 — ассерт 0xf8 при инициализации кольца журнала (в образе 1) */
extern u32 fw_log_module_names[15];                  /* 0x80096c: 0x80096c: имена модулей журнала fw («DRIVERS», «MAC_MON» … «WBE_MGR»); обращений vendor не найдено */
extern u32 calib_lo_power_rfc_packed[3];             /* 0x800a28: 0x800a28: RGF 484/488/492 RF с тетрадами 0xc (rfc__pack_field_value из calib_lo_power_rfc_saved) */
extern u32 calib_lo_power_rfc_saved[3];              /* 0x800a34: 0x800a34: исходные RGF 484/488/492 RF-модуля (rfc__read_field_484 в calib_obj__reset_results) */
extern u32 lmac_edca_cur_mode;                       /* 0x800c0c: 0x800c0c: последний режим EDCA-таблицы, посланный LMAC (команда 0x04); = — не слать */
extern u32 calib_engine_names[6];                    /* 0x800dc8: 0x800dc8: строки имён движков (журнал «Engine of %s is already active») */
extern u32 calib_engine_corr_count[6];               /* 0x800e08: 0x800e08: число шагов коррекции (READY_FOR_CORRECTION) движка */
extern volatile u32 temp_first_meas[9];              /* 0x80114c: первое измерение: [0] BB, [1 + i] RF i, м°C (perform_first_measurement_operations; UT 10/32) */
extern volatile u16 link_mcs_en_vec_lo;              /* 0x80149e: 0x80149e: разрешённые MCS, младшие 16 бит (0x1dde / 0x1de / 0x10) */
extern volatile u16 link_mcs_en_vec_hi;              /* 0x8014a0: 0x8014a0: разрешённые MCS, старшие 16 бит */
extern u8 calib_if_predist_atten_tbl[19];            /* 0x801954: аттенюатор предыскажения TX по индексу (IF_GAIN::GAIN out[2] < 0x13) */
extern u8 calib_if_dac_fssel_tbl[18];                /* 0x801968: DAC fssel TX по индексу (IF_GAIN::GAIN out[4] < 0x12) */
extern volatile u32 led_ch_used[3];                  /* 0x8019bc: флаг «канал LED ch уже включался» (led__set, ch < 3) */
extern volatile u32 rfc_cmd_count[8];                /* 0x8019cc: счётчик команд RFC по модулю RF 0..7 (rfc write, add2; rfc__probe_modules обнуляет, rfc__collect_rx_crc_stats читает) */
extern volatile u32 temp_rf_sensor_ofs[8];           /* 0x8019ec: поправка RF-сенсора температуры по индексу RF ((T0 − Tamb)·10) */
extern u32 rf_rdac_fail_cnt[10];                     /* 0x801a8c: счётчики сбоев свипа RDAC по ступени 0..9 (hwd_rfc_read_calibrate, -1 — ступень пропущена; get_min_failures_mid_biggest_range_index) */
extern volatile u8 abif_rx_sar_dc_word[32];          /* 0x801ab4: слово строки (8 слов) таблицы SAR DC 0x88a608, индекс (7 − idx) + 8·(c + 2b) */
extern volatile u8 abif_rx_sar_dc_sh[32];            /* 0x801ad4: сдвиг 5-битного поля SAR DC */
extern u32 abif_rx_vga_bias_word[5];                 /* 0x801af4: слово строки поля VGA bias ступени 1..5 (запись) */
extern volatile u32 abif_rx_vga_bias_rd_word[5];     /* 0x801b08: то же для чтения (копия) */
extern u32 unk_801b38[13];                           /* 0x801b38: образ {8,0x10,…,0x2000,0x7d00,-1}: степени двойки 8..8192, 32000, маркер -1. Обращений в vendor fw нет: ни литерала/limm 0x801b38..0x801b6b в коде (tools: поиск LE и middle-endian limm по .fw, 6.2/src/asm/fw), ни указателя в fw_data (RELOCS-NUM-fw: «середина линейного кода» — числа таблицы) */
extern s8 unk_801b84[32];                            /* 0x801b84: образ {-29 ×8, -21 ×22, 0, -21}: s8-таблица (вероятно пороги дБм по индексу). Обращений в vendor fw нет: ни литерала/limm 0x801b84..0x801ba3 в коде (поиск LE и middle-endian limm по .fw, 6.2/src/asm/fw), ни указателя в fw_data */
extern u32 rf_auto_fill_pat0[6];                     /* 0x801fec: шаблон 6 слов auto_fill по умолчанию (нули; rf_utils__fill_default_patterns) */
extern u32 calib_lo_power_cur_init[3];               /* 0x803694: исходные поля RFC 0x484 (нули образа) — копия в hwf_calib_lo_power_flow перед rfc_read_field_484 */
extern u32 calib_lo_power_packed_init[3];            /* 0x8036a0: исходные упакованные поля (нули образа) — hwf_calib_lo_power_flow → rfc_pack_field_value */
extern u32 calib_lo_leak_start_x;                    /* 0x8037ec: 0x8037ec: стартовая x поиска минимума LO-утечки (образ 0x40) */
extern u32 calib_lo_leak_start_y;                    /* 0x8037f0: 0x8037f0: стартовая y поиска минимума LO-утечки (образ 0x40) */
extern u32 calib_lo_leak_init_dc;                    /* 0x8037f4: 0x8037f4: исходные DC четырёх колонок (4 байта) для поиска LO-утечки */
extern s8 calib_sar_dc_init_max0;                    /* 0x803810: 0x803810: начальный max запаса SAR DC, половина 0 (-31; vendor читает ldw парой) */
extern s8 calib_sar_dc_init_max1;                    /* 0x803811: 0x803811: начальный max запаса SAR DC, половина 1 (-31) */
extern s8 calib_sar_dc_init_min0;                    /* 0x803812: 0x803812: начальный min запаса SAR DC, половина 0 (31) */
extern s8 calib_sar_dc_init_min1;                    /* 0x803813: 0x803813: начальный min запаса SAR DC, половина 1 (31) */
extern volatile u32 rfc_core_c_cmd_tmpl;             /* 0x803918: 0x803918: шаблон слова команды 0xc RFC-ядру (старшие 16 бит; прожиг OTP-бита) */
extern u8 pring_bind_vr_count[32];                   /* 0x805140: счётчик привязок по номеру vring (sm_pring__bind_vring, vr < 0x1f; на 10 — чтение диагностики DMA/MAC и сброс) */
extern volatile u32 sysapi_freq_ratio_args[3];       /* 0x806690: аргументы hw_sysapi__set_freq_ratio {канал, v1, v2} для колбэка радио (0x8ce458) */
extern volatile u32 dbg_trap_caller;                 /* 0x806a0c: 0x806a0c (DBG_TRAP_CALLER): fw_vendor_ptr_trap — первое место вызова (blink) */
extern volatile u32 dbg_trap_count;                  /* 0x806a10: 0x806a10 (DBG_TRAP_COUNT): fw_vendor_ptr_trap — число вызовов */
extern volatile u32 dbg_trap_arg0;                   /* 0x806a60: 0x806a60 (DBG_TRAP_ARGS+0): r0 первого вызова ловушки */
extern volatile u32 dbg_trap_arg1;                   /* 0x806a64: 0x806a64 (DBG_TRAP_ARGS+4): r1 */
extern volatile u32 dbg_trap_arg2;                   /* 0x806a68: 0x806a68 (DBG_TRAP_ARGS+8): r2 */
extern volatile u32 dbg_trap_arg3;                   /* 0x806a6c: 0x806a6c (DBG_TRAP_ARGS+0xc): r3 */

#endif
