# Утилиты прошивки: битовые поля, милли-код, аксессоры, мелкие функции

Каталог мелких общих функций fw: вставка битовых полей, милли-код сохранения
регистров, привязка описателей автоматов, аксессоры полей и глобалов, заглушки и
хвосты, парсер MAC-кадров, статистика, загрузка, таймеры, память и списки. Механизмы
общие для 4.1.0.1000 и 6.2.0.1000 **[обе]** (тот же тулчейн и те же идиомы —
[TOOLCHAIN.md](TOOLCHAIN.md), [REWRITING.md](REWRITING.md)); перечни ниже — блоки 6.2.
Аналогичный каталог 4.1 — [4.1/docs/MISC.md §14](../4.1/docs/MISC.md#14-каталог-битовые-поля-аксессоры-фрагменты-41).

Метки: **[код]** — по листингу, **[выз]** — роль по вызывающим. Запись адреса:
`имя` 0x… — адрес 6.2; «/ 4.1 0x…» — адрес той же функции в 4.1 (по совпадению тела —
`6.2/ref/CORRELATION-FW.txt`, по таблице [NAMES-FROM-62](../4.1/docs/NAMES-FROM-62.md)
или по имени); если в 4.1 имя другое, оно указано; без пометки 4.1 — соответствие не
установлено.

## 1. Семейство `bf_set_sN_wM` **[код]**

12-байтовые переходники `mov r10,N ; b.d общий ; mov r11,M−1` — вставка
поля ширины M со сдвигом N (как в 4.1: r10 = сдвиг, r11+1 = ширина). Общие
тела: `bf__set_field_byte_fw`, `bf__set_field_half_fw`, `bf__set_field_word_fw`
(читают слово по указателю, вставляют через `bf__insert_field_fw`, пишут
обратно), `bf__set_field_u16_le`, `bf__set_field_u32_bytewise`.
Весь список: `dmg_cap__bits_set16_s3_w8` 0x8ed19c, `sta_rec__bits_set16_s5_w5` 0x8ed1b4, `dmg_cap__bits_set16_s5_w6` 0x8ed1c0, `frame__bits_set16_s6_w10` 0x8ed1cc, `bits__set16_s6_w6` 0x8ed1d8, `bcon__bits_set16_s6_w7` 0x8ed1e4, `bcon__bits_set16_s7_w3` 0x8ed1f0, `bits__set16_s7_w5` 0x8ed1fc, `bcon__bits_set16_s7_w6` 0x8ed208, `bits__set16_s7_w7` 0x8ed214, `dmg_cap__bits_set32b_s4_w24` 0x8ed220, `bits__set8_s0_w2` 0x8ed22c, `bits__set8_s0_w4` 0x8ed238, `sta_rec__bits_set8_s0_w5` 0x8ed244, `tx_api__bits_set8_s0_w6` 0x8ed250, `dmg_cap__bits_set8_s1_w3` 0x8ed25c, `bits__set8_s2_w4` 0x8ed268, `bits__set8_s2_w5` 0x8ed274, `bits__set8_s2_w6` 0x8ed280, `frame__bits_set8_s3_w5` 0x8ed28c, `bits__set8_s4_w2` 0x8ed298, `bits__set8_s4_w4` 0x8ed2a4, `bcon__bits_set8_s5_w3` 0x8ed2b0, `bits__set8_s6_w2` 0x8ed2bc, `rx_chain__bits_set16h_s0_w12` 0x8ed2c8, `bits__set16h_s0_w2` 0x8ed2d4, `ese__bits_set16h_s0_w3` 0x8ed2e0, `bits__set16h_s0_w4` 0x8ed2ec, `bits__set16h_s2_w2` 0x8ed2f8, `mac_filter__bits_set16h_s4_w2` 0x8ed304, `bits__set16h_s4_w4` 0x8ed310, `bits__set16h_s4_w5` 0x8ed31c, `bits__set16h_s5_w2` 0x8ed328, `tx_desc__bits_set32_s0_w10` 0x8ed334, `bits__set32_s0_w12` 0x8ed340, `bits__set32_s0_w13` 0x8ed34c, `bits__set32_s0_w2` 0x8ed358, `tx_queue__bits_set32_s0_w3` 0x8ed364, `bits__set32_s0_w5` 0x8ed37c, `silent_rssi__bits_set32_s0_w6` 0x8ed388, `pcp_factor__bits_set32_s0_w7` 0x8ed394, `bits__set32_s12_w12` 0x8ed3a0, `silent_rssi__bits_set32_s12_w4` 0x8ed3ac, `boot__bits_set32_s13_w2` 0x8ed3b8, `bits__set32_s14_w2` 0x8ed3c4, `tx_queue__bits_set32_s14_w3` 0x8ed3d0, `boot__bits_set32_s15_w17` 0x8ed3dc, `bits__set32_s16_w12` 0x8ed3e8, `bits__set32_s16_w4` 0x8ed3f4, `bits__set32_s16_w5` 0x8ed400, `bits__set32_s16_w7` 0x8ed40c, `tx_queue__bits_set32_s17_w4` 0x8ed418, `tx_queue__bits_set32_s20_w10` 0x8ed424, `rx_macq__bits_set32_s21_w5` 0x8ed43c, `rf_chain__bits_set32_s22_w2` 0x8ed448, `bits__set32_s24_w2` 0x8ed460, `fw_stats_blk__bits_set32_s24_w4` 0x8ed46c, `ftm_main_sm__bits_set32_s24_w5` 0x8ed478, `bits__set32_s24_w7` 0x8ed484, `rx_macq__bits_set32_s26_w2` 0x8ed490, `pcie__bits_set32_s27_w5` 0x8ed49c, `bits__set32_s28_w4` 0x8ed4a8, `rf_chain__bits_set32_s29_w2` 0x8ed4b4, `bits__set32_s29_w3` 0x8ed4c0, `bits__set32_s2_w2` 0x8ed4cc, `pcie__bits_set32_s2_w4` 0x8ed4d8, `ese__bits_set32_s3_w29` 0x8ed4e4, `bits__set32_s4_w12` 0x8ed4f0, `bits__set32_s4_w2` 0x8ed4fc, `fwq_tx__bits_set32_s4_w28` 0x8ed508, `bits__set32_s4_w3` 0x8ed514, `bits__set32_s4_w4` 0x8ed520, `bits__set32_s4_w5` 0x8ed52c, `mid__bits_set32_s5_w5` 0x8ed538, `tx_queue__bits_set32_s6_w14` 0x8ed544, `lmac_if__bits_set32_s6_w26` 0x8ed550, `pcp_factor__bits_set32_s7_w8` 0x8ed55c, `rx_chain__bits_set32_s8_w12` 0x8ed568, `qdesc__bits_set32_s8_w3` 0x8ed574, `bits__set_s8_w5` 0x8ed580, `bf__set_field_u16_le` 0x8edc34 / 4.1 `bf_unaligned16` 0x8e888c, `bf__set_field_u32_bytewise` 0x8edc60 / 4.1 `bf_unaligned32` 0x8e88b8, `bf__set_field_word_fw` 0x8edcb8 / 4.1 `bf_word_set` 0x8e8910, `bf__set_field_byte_fw` 0x8edccc / 4.1 `bf_byte_set` 0x8e8924, `bf__set_field_half_fw` 0x8edce0 / 4.1 `bf_half_set` 0x8e8938.

## 2. Привязка описателей автоматов

Через `basic_sm__bind_descriptor`; адрес
в имени = описатель из [SM-TABLES.txt](../6.2/ref/SM-TABLES.txt): `obj_vt8030e0__ctor` 0x8c179c, `obj_vt802f58__ctor` 0x8d8dc0, `wait_sm__init` 0x8d8e24, `calib_engine__sm_init` 0x8d8e5c, `field_set_0x08__8d8eb4` 0x8d8eb4, `obj_vt80296c__ctor` 0x8d9230, `obj_vt802b50__ctor` 0x8f5280, `ftm_state_sm__init` 0x8f52a4, `obj_vt802cc4__ctor` 0x8f52bc, `disc_flush_sm__init` 0x8f5310.

## 3. Аксессоры полей

`field_get/set_0xNN` — чтение/запись поля объекта по
смещению NN; имя точно по коду: `field_set_0x04__8c1864` 0x8c1864, `field_set_0x04__8c1870` 0x8c1870, `conn_mgr__start_all_detector_services` 0x8c40f8, `ps_conn__post_disassoc_evt` 0x8c6994, `maintain_sm__set_rs_params_of_ctx70` 0x8c6cbc, `field_set_0x19__8caf4c` 0x8caf4c, `mid__get_aw_len` 0x8cb914, `calib_obj__get_byte_b4` 0x8cbbbc, `conn__get_cid_via_field8` 0x8cbec0, `conn_mgr__first_active` 0x8cc254, `mid__get_field_0c` 0x8cc360, `maintain_sm__get_mid_idx` 0x8cc3d4, `rm_req__get_next` 0x8cc65c, `bitmap__expand_byte4_to_list` 0x8ccafc, `link_stats__get_sta_word64` 0x8ccb50, `link_stats__get_sta_word58` 0x8ccf64, `ies__iter_has_more` 0x8cdcd0, `ut_hw_flows__field_set_thunk` 0x8ce408, `if_gain__get_scaled` 0x8d6064, `field_set_0x00__8d8db8` 0x8d8db8, `field_set_0x1c__8d9c3c` 0x8d9c3c, `ftm__is_responder_enabled` 0x8da560, `conn__notify_link_via_l2mgr` 0x8dace4, `ba__on_uc_timeout_evt` 0x8dc430, `lm_sm__post_evt6_via_owner` 0x8ddbb4, `mem_pool__get_field14` 0x8e0904, `rfc__write_gain_idx_reg504` 0x8e62dc, `field_set_0x58__8e6788` 0x8e6788, `sched_builder__build_if_present` 0x8ea86c, `maintain_ctx__set_field_9c` 0x8ea9c8, `vring__is_empty_by_id` 0x8ebe64, `scan_mngr__set_rx_omni_sector` 0x8f8f44.

## 4. Геттеры и сеттеры глобалов и регистров

Имя = адрес: `macq_desc__wait_window_free` 0x8c50e4, `macq_desc__release_window` 0x8c5238, `ps_cfg__set_ps_flags` 0x8c9944, `boot__force_production_mode` 0x8cadec / 4.1 `set_reg_880ab8` 0x8c918c, `ps_cfg__get_byte_a` 0x8cb8a4 / 4.1 `get_g_8035f2` 0x8c9868, `lmac_if__get_evt_byte3` 0x8cb910, `calib_engine__get_by_index` 0x8cbb84, `qdesc_cfg__get_w10_field` 0x8cc2f0, `qdesc_cfg__get_w3_field_a` 0x8cc2f4, `qdesc_cfg__get_w3_field_b` 0x8cc2f8, `qdesc_cfg__get_w14_field` 0x8cc2fc, `qdesc_cfg__get_w4_field` 0x8cc300, `qdesc_cfg__get_flag_bit13` 0x8cc304, `txq_cfg__c70_value_or_default` 0x8cc308, `txq_cfg__enable_or_default` 0x8cc31c, `txq_cfg__c74_value_or_default` 0x8cc330, `qdesc_cfg__get_w13_field` 0x8cc344, `lo_power_calib__get_state_obj` 0x8cc3a4, `lo_power_calib__get_table_idx` 0x8cc3a8, `ps_cfg__get_byte_8` 0x8cc660 / 4.1 `get_g_8035f0` 0x8ca458, `rf__get_active_index` 0x8ccb20, `link_stats__counter64_a_thunk` 0x8ccb64, `fixed_sched__get_entry_count` 0x8ccec8, `link_stats__counter64_b_thunk` 0x8ccf78, `pcie__clear_880c50_b2` 0x8d0444 / 4.1 `rgf_reg_880c00_8cd5b8` 0x8cd5b8, `mid__reset_sched_alloc_regs` 0x8d0e48 / 4.1 `set_reg_88c048_x2` 0x8ce0fc, `hwd_mac__sxd_tx_phy_frame_start` 0x8d1044, `hwd_pcie__d3_d0_int_en` 0x8d11a8, `hwd_pcie__enter_d3_int_en` 0x8d1240, `sdp__icr_unmask_bit` 0x8d477c / 4.1 `set_reg_880b00_8d16cc` 0x8d16cc, `hw__has_cause_880b54` 0x8d478c / 4.1 `get_reg_880b00_8d16dc` 0x8d16dc, `regd__is_country_not_jp` 0x8da3d8, `dma_mgr__queue_state_is_0` 0x8da544, `mcs__is_restricted` 0x8da568, `power_halt__read_88027c` 0x8da7f0 / 4.1 `get_reg_88027c` 0x8d76f8, `power_halt__rearm_awake_tsf_irq` 0x8da800 / 4.1 `set_reg_880b50_x2` 0x8d7708, `power_halt__set_wake_time64` 0x8da8e4 / 4.1 `set_reg_880200` 0x8d77fc, `mac__enable_880bc0_b0` 0x8da8f4, `mac_rx_cnt__get_mcs0_crc_err` 0x8dd77c, `mac_rx_cnt__get_mcs0_crc_ok` 0x8dd784, `mac_tx_cnt__delta_10_since_base` 0x8dd78c, `mac_rx_cnt__get_u64_bc` 0x8dd798, `mac_tx_cnt__get_u64_14` 0x8dd7a4, `mac_rx_cnt__get_crc_total` 0x8dd7ac, `mac_rx_cnt__get_crc_ok` 0x8dd8b0, `vring_hw__clear_tx_ctl_bit0` 0x8df5b4 / 4.1 `rgf_reg_881b00_8db324` 0x8db324, `flash_cfg__set_bb_sensor_calib` 0x8e62fc, `power_mngr__set_ps_ctx_d90` 0x8e678c, `power_mngr__set_ps_ctx_da0` 0x8e6798, `flash_cfg__set_lo_power_gc_ctrl` 0x8e689c, `flash_cfg__set_lo_power_stg2_bias` 0x8e68a4, `flash_cfg__set_lo_power_xif_gc` 0x8e68ac, `sys_timer__read_now` 0x8e916c, `u_schd__hw_timer_load_start` 0x8e9178 / 4.1 `set_reg_880200_8e42d8` 0x8e42d8, `u_schd__hw_timer_a_start` 0x8e91a4 / 4.1 `set_reg_880200_8e4304` 0x8e4304, `fw_image_info__set_flavor` 0x8f33ac / 4.1 `set_reg_880a10` 0x8ebbf4, `gpio__write_ctrl_b84` 0x8f4480, `tx_api__reset_state_words` 0x8f5270.

## 5. Заглушки, листья и хвосты

`stub_ret_*` — `j_s [blink]`; `tail_*` —
переход в функцию из имени; `leaf_*` — лист без вызовов, смысл по вызывающим
в соответствующих разделах: `cpu__aux28_set_bits12_fw` 0x8c02a4, `cxx__vec_nop_ctor_thunk` 0x8c1cd0, `cxx__vec_nop_ctor_ret0` 0x8c1cd4, `crt0__jump_to_rom_3c364` 0x8c1d6c, `lmac_cmd_pool__alloc` 0x8c3284, `obj_vt802cc4__noop_vmethod` 0x8c67b8, `ka__period_for_snr` 0x8c6b4c / 4.1 `frag_8c5db8` 0x8c5db8, `maintain_sm__set_rs_params_of_conn` 0x8c6cb4, `mid__copy_mac_addr` 0x8c75b0 / 4.1 `tail_memcpy_fw` 0x8e1aa4, `vring__clear_pair_words` 0x8c984c, `tx_ppdu_ageing__hook_ret0` 0x8cbb80, `u_schd__now_hw_timer_thunk` 0x8cc100, `power_mngr__defaults_addr` 0x8cc1f4, `calib__results_addr_800a28` 0x8cc39c, `ts_ring__time_delta_a_thunk` 0x8cc3bc, `ts_ring__time_delta_b_thunk` 0x8cc3c0, `conn__get_radio_ctx_byte10` 0x8cc414, `silent_rssi__agc_param_const_2` 0x8cca84, `silent_rssi__agc_param_const_4` 0x8ccb18, `rs__copy_detailed_result` 0x8ccb48, `mid__sched_scheme_addr` 0x8ccb74, `stream_mgr__prepare_buf30_by_id` 0x8cccb4, `ftm__ctx_addr` 0x8ccf04, `link_stats__pack_conn_entry` 0x8cdd7c, `host_irq__raise_fw_ready` 0x8d0cf4, `host_irq__raise_fw_error` 0x8d0cfc, `ut_hw_drivers__noop_hook` 0x8d1b28, `macq_hw__sync_dma_wptr_fw` 0x8d4708, `fw_main__noop_init_hook` 0x8d9390, `hw_ch__noop_hook_a` 0x8da78c, `hw_ch__noop_hook_b` 0x8da7fc, `lmac_cmd__fill_rx_on_fields` 0x8dc25c, `sys_state__broadcast_16` 0x8dd8e4, `rm__llist_pop_front_thunk` 0x8e0bc8, `macq_desc__read_t1_w0_n2` 0x8e4430 / 4.1 `tail_vring__write_macq_desc_8df898` 0x8df898, `macq_desc__read_t1_w2_n1` 0x8e443c / 4.1 `tail_vring__write_macq_desc_8df8a4` 0x8df8a4, `tof__init_session_defaults` 0x8e64bc, `boot__save_mac_address` 0x8e68f0 / 4.1 `tail_memcpy_fw` 0x8e1aa4, `ps_cfg__noop_apply_hook` 0x8e74d4, `fw_main__enter_main_loop` 0x8ea698, `lmac_if__rs_done_noop_hook` 0x8eacac, `ut_sysapi__flush_stats_start` 0x8ebbbc, `brd_if__noop_hook_b` 0x8ebd10, `brd_if__noop_hook_c` 0x8ebd14, `boot__fill_sysapi_3c_thunk` 0x8f0000, `bf_req__is_claimable` 0x8f5cac.

## 6. Милли-код

Сохранение/восстановление регистров; милли-код ARC, как в 4.1:
`__st_gp_to_r13` 0x8c01b4 / 4.1 0x8c0294, `__st_r25_to_r13` 0x8c01b8 / 4.1 0x8c0298, `__st_r24_to_r13` 0x8c01bc / 4.1 0x8c029c, `__st_r23_to_r13` 0x8c01c0 / 4.1 0x8c02a0, `__st_r22_to_r13` 0x8c01c4 / 4.1 0x8c02a4, `__st_r21_to_r13` 0x8c01c8 / 4.1 0x8c02a8, `__st_r20_to_r13` 0x8c01cc / 4.1 0x8c02ac, `__st_r19_to_r13` 0x8c01d0 / 4.1 0x8c02b0, `__st_r18_to_r13` 0x8c01d4 / 4.1 0x8c02b4, `__st_r17_to_r13` 0x8c01d8 / 4.1 0x8c02b8, `__st_r16_to_r13` 0x8c01dc / 4.1 0x8c02bc, `__st_r15_to_r13` 0x8c01e0 / 4.1 0x8c02c0, `__st_r14_to_r13` 0x8c01e4 / 4.1 0x8c02c4, `__st_r13_to_r13` 0x8c01e8, `__ld_gp_to_r13_ret` 0x8c01f4 / 4.1 0x8c02d4, `__ld_r25_to_r13_ret` 0x8c01fc / 4.1 0x8c02dc, `__ld_r24_to_r13_ret` 0x8c0204 / 4.1 0x8c02e4, `__ld_r23_to_r13_ret` 0x8c020c / 4.1 0x8c02ec, `__ld_r22_to_r13_ret` 0x8c0214 / 4.1 0x8c02f4, `__ld_r21_to_r13_ret` 0x8c021c / 4.1 0x8c02fc, `__ld_r20_to_r13_ret` 0x8c0224 / 4.1 0x8c0304, `__ld_r19_to_r13_ret` 0x8c022c / 4.1 0x8c030c, `__ld_r18_to_r13_ret` 0x8c0234 / 4.1 0x8c0314, `__ld_r17_to_r13_ret` 0x8c023c / 4.1 0x8c031c, `__ld_r16_to_r13_ret` 0x8c0244 / 4.1 0x8c0324, `__ld_r15_to_r13_ret` 0x8c024c / 4.1 0x8c032c, `__ld_r14_to_r13_ret` 0x8c0254 / 4.1 0x8c0334, `__ld_r13_to_r13_ret` 0x8c025c.

## 7. Парсер MAC-кадров (фильтры приёма 0x886000–0x886400)

Шаги
инициализации `mac_parser__init`: `macq_desc__read_typed` 0x8c4f1c, `mac_parser__pack_rule_halfword` 0x8df6a4 / 4.1 0x8db5bc, `mac_parser__rule_b` 0x8dfde4 / 4.1 0x8dbd14, `mac_parser_step_b` 0x8dfe14 / 4.1 0x8dbd44, `mac_parser_step_a` 0x8dfee4 / 4.1 0x8dbe14, `rx_macq__pack_desc` 0x8e4340, `rx_macq__build_ba_desc` 0x8e4448.

## 8. Статистика (UT/sysapi)

`link_stats__calc_throughput_mbps` 0x8c5554 / 4.1 0x8c4a00,
`stats__read_counter_by_id` 0x8dd7b8, `ber_test__copy_counters` 0x8f5cd0 / 4.1 0x8ed830,
`ber_test__accumulate_counters` 0x8f5cdc / 4.1 0x8ed83c, `mac_ampdu_statistics_timeout_cb`
0x8f6370 — окно A-MPDU-статистики по таймеру, затем стоп команды.

## 9. Загрузка и версии

`fw_version__log` 0x8f3414 / 4.1 0x8ebc58, `fw_version__log_date` 0x8f33b8 / 4.1 0x8ebc00, `obj__store3_thunk` 0x8c17b4, `obj_vt8005e4__ctor` 0x8c180c, `obj_vt8005c4__ctor` 0x8c187c, `memset_fw` 0x8ddf84 / 4.1 0x8da04c, `calib_silent_rssi__ctor` 0x8f0004, `fw_log__init_ring` 0x8dcb1c, `fw__init_link_defaults` 0x8f53dc, `calib_engine__init_all` 0x8f50c8, `fw_stats_blk__init` 0x8f538c, `obj__store3` 0x8d8fdc / 4.1 0x8d5ebc, `deferred_cb__run_all` 0x8c1ca0 —
вызываются из `fw_main`/`boot__install_handler_ptrs`/`fw_boot__log_versions`
(печать «FW version = %d.%d.%d», «FW date»); `calib_engine__init_all`
выбирает начальный канал и настраивает автомат калибровок 0x802234.

## 10. Таймеры и часы

`timer__start` 0x8e94a0 / 4.1 0x8e4610, `power_halt__start_timer` 0x8e9558 / 4.1 0x8e46c8, `mac__set_usec_clk_div` 0x8e99dc / 4.1 `mac__program_gp_timer` 0x8e4920, `mac__reload_tsf64` 0x8e9a58 / 4.1 `mac__load_gp_timer_value` 0x8e499c, `mac__read_bi_start_tsf64` 0x8e9890 / 4.1 `mac__wait_counter_ready` 0x8e47d0, `irq_ack_880b00` 0x8e9190 / 4.1 0x8e42f0, `pcie__toggle_880c50_bit2` 0x8d029c, `periodic_service__tick` 0x8e4828 / 4.1 0x8dfb6c, `detector__deadline_is_unset` 0x8da2ac / 4.1 0x8d71f4
— `timer__start` задаёт уровень прерывания таймера (`irq_set_level`);
`periodic_service__tick` — тик периодической службы детекторов (перевзвод
через `u_schd__schedule`); `pcie__toggle_880c50_bit2` — ожидание захвата PLL
(0x880c00) с «DO_WHILE_WITH_MAX_ITER».

## 11. Память и списки

`mem_pool__put_block` 0x8c6414 / 4.1 0x8c5740, `mem_pool__free__8cb19c` 0x8cb19c / 4.1 `mem_pool__free_8062c4` 0x8c9578, `mem_pool__tag_block` 0x8e7474 / 4.1 0x8e2344, `mgmt_pkt__clear` 0x8cb160 / 4.1 0x8c953c, `list__insert_sorted_801b1c__8e1174` 0x8e1174 / 4.1 `list_80182c__insert_sorted` 0x8dd000, `div_round_up` 0x8cbea0 / 4.1 0x8c9d5c, `bit_length` 0x8c7cd4 / 4.1 0x8c6c38, `shl64_fw` 0x8c05f4 / 4.1 0x8c053c, `approx_magnitude_b` 0x8dc660 / 4.1 0x8d8f50, `range_check_lt3` 0x8da75c, `wmi_evt__alloc_and_fill` 0x8cb07c, `buf30__prepare_and_call_8c50f8` 0x8dd8ec.

## 12. MID/IE/BSS

`mid__reset_ssid` 0x8c4df8 / 4.1 0x8c4498, `mid__reset_10b_at_248` 0x8c4e04 / 4.1 0x8c44a4, `mid__reset_ie_area` 0x8c4e20 / 4.1 0x8c44c0, `mid__field_18_step` 0x8cbf18, `mid__copy_bssid_8e211c` 0x8ccea4 / 4.1 0x8e211c, `mid_list__count_active` 0x8cb7a0 / 4.1 0x8c9798, `ie_list__first` 0x8cbfc8 / 4.1 0x8c9e10, `ie_iter__init` 0x8e5de8 / 4.1 0x8e112c, `app_ies__clear` 0x8c6784 / 4.1 0x8c5a00, `app_ie__remove_tlv` 0x8e255c / 4.1 0x8de1a4, `app_ie__find_by_eid` 0x8cc2b8, `vendor_ie__write_at_282` 0x8ebcd4 / 4.1 0x8e7098, `verify_pbc` 0x8ebd68 / 4.1 0x8e7134, `dmg_cap__build_sta_capability` 0x8e6598, `edca__fill_default_ac_params` 0x8e63f4, `mid__init_sched_scheme` 0x8d96fc, `mid__program_88c068` 0x8d0e14, `rf__get_module_info` 0x8f3704
— `dmg_cap__build_sta_capability` (276 Б) заполняет битовые поля
возможностей BSS (ширины 3/8/2/24/6 — в т. ч. поле со сдвигом 3 и шириной 8,
как Max Associated STA Number у AP/PCP Capability в 4.1) **[выз]**;
`edca__fill_default_ac_params` — EDCA по умолчанию (поля 4/2 бит);
`verify_pbc` — сверка PBC из Wilocity VS при ассоциации;
`rf__get_module_info` — состояние RF для `wmi_get_rf_status`.

## 13. Тракт/MAC

`qdesc__build_by_type` 0x8fa224, `rx_chain__build_desc` 0x8e40d4, `rx_chain__build_desc_b` 0x8e41a8, `sched__init_default_alloc_table` 0x8ca388, `vring_tbl__find_by_id` 0x8cce14, `vring_tbl__ptr_by_index` 0x8cce84, `wmi_vring_cfg__with_847b34` 0x8cb204, `vring__vcall_14_x2` 0x8e0e28, `ba__schedule_timeout_update` 0x8ead48, `fw2uc__signal_halt_and_wait_ack` 0x8db148, `fw_log__emit2_tsf` 0x8dce04, `hwd__apply_table_entry` 0x8f2e0c, `hwd__apply_table_entry_b` 0x8f2e74, `hwd__apply_table_entry_c` 0x8f8f60, `mac__set_880bc0_b0` 0x8e860c, `ts_ring__push_sample` 0x8dd6d4 —
`rx_chain__build_desc` / `rx_chain__build_desc_b` — два шаблона цепочки RX
(`rx_chain__configure(_b)`), `qdesc__build_by_type` — шаблон дескриптора
очереди для `mac_bringup__init_seq` и ADDBA; `hwd__apply_table_entry*` —
применение записей таблицы 0x8012f0 (64-битные маски); роль прочих не
установлена.

## 14. Остальное

`add_0c_ret` 0x8cc364, `mlme__assoc_timeout_cb` 0x8f1054, `maintain_sm__config_mcs_en_vec` 0x8c7000 / 4.1 0x8c62a4, `process_expected_bf_results` 0x8e11f8 / 4.1 0x8dd084, `oob__mode_flags` 0x8ccac8, `hw_cfg__set_8004fc_and_levels` 0x8ce060, `bf_ctrl__lowest_trigger_bit` 0x8d97d4, `fw_sysapi__start_phy_rx_stats` 0x8ce0d4, `fw_sysapi__start_ampdu_stats` 0x8ce088, `stats__delta_since_baseline` 0x8f64f4, `sysapi_mgr__apply_ut_args` 0x8cdd60, `ut_hw_cmd_0x008` 0x8eacb0 / 4.1 0x8e59d8
— роли по вызывающим в разделах выше (maintain_sm, UT, PS) **[выз]**.

## Не установлено

* Роли части утилит разделов «Тракт/MAC» и «Остальное».

## Источники

* `6.2/src/asm/fw/blocks.json`, `4.1/src/asm/fw/blocks.json`, `6.2/ref/CORRELATION-FW.txt`,
  [6.2/ref/SM-TABLES.txt](../6.2/ref/SM-TABLES.txt).
* [REWRITING.md](REWRITING.md) (милли-код и аксессоры при переписывании на C),
  [4.1/docs/MISC.md](../4.1/docs/MISC.md).
