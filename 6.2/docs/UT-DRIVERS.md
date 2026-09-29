# UT-подкоманды драйверов 6.2: код → функция

Таблица подкоманд модуля драйверов `WMI_UNIT_TEST` (0x900, см. [WMI.md](../../docs/WMI.md))
в 6.2.0.1000: код → функция-обработчик. Функции драйверов по блокам —
[HW-DRIVERS.md](../../docs/HW-DRIVERS.md).

## Источник

Таблицы переходов `UT_HW_DRIVERS_cmd_handler` @0x8eaec8 **[код]**: u16-таблицы
0x8039f4, 0x803a4c, 0x803a94, цепочки сравнений и таблицы 0x803ab4 (0x301–0x305),
0x803ac0 (0x402–0x42d), 0x803b18 (0x430–0x438), 0x803b2c (0x503–0x50c),
0x803b40 (0x50e–0x517), 0x803b54 (0x519–0x51d); коды 0x170, 0x202, 0x602 — одиночные
сравнения в цепочке (ветки 0x8eafe4, 0x8eb016, 0x8eb120); сигнатуры аргументов сверены с
cmd-структурами пака 11ad. «Функция» — первый вызов в ветке (иногда вспомогательная,
а не сама операция). Имя из пака — перечисление `WMI_UT_MODULE_DRIVERS_CMD` в
`wmi/wmiUT.xml` пака 11ad 7.5 **[пак]**.

## Соответствие нумерации пака

Нумерация пака 11ad совпадает со Sparrow лишь частично: имена пака **не переносить без
проверки**; колонка «проверка» показывает, чем подкреплено соответствие.

* По собственной лог-строке функции: совпало 7, расходится 8, без собственной строки 183;
  0x170 совпадает по строке ветки диспетчера.
* По сигнатурам аргументов нумерация пака совпадает в ABIF 0x101–0x162 (кроме 0x146) и
  PHY 0x401–0x42b, 0x430–0x438; расходится в 0x146, 0x171, 0x42c–0x42e.
* Обработчики 0x50e/0x510/0x512/0x514 в таблице 0x803b40 не сведены к блоку.
* `wmi_evt__send_command_not_supported` @0x8e5728 — ветка «не поддерживается».

| код | имя в паке 11ad | функция 6.2 | проверка |
|---|---|---|---|
| 0x101 | hwd_abif_pll_ctrl | abif__power_up_analog @0x8cec90 | — |
| 0x102 | hwd_abif_adc_clk_ctrl | hwd_abif__adc_clk_ctrl @0x8ce4ec | — |
| 0x103 | hwd_abif_xtal_ctrl | hwd_abif__xtal_ctrl @0x8cffc4 | — |
| 0x104 | hwd_abif_rosc_ctrl | hwd_abif__rosc_ctrl @0x8ceddc | — |
| 0x105 | hwd_abif_fs_on | hwd_abif__fs_on @0x8cea38 | — |
| 0x106 | hwd_abif_fs_off | hwd_abif__fs_off @0x8cea04 | — |
| 0x107 | hwd_abif_rfc_clk_ctrl | hwd_abif__rfc_clk_ctrl @0x8ced74 | — |
| 0x108 | hwd_abif_caf_phy_control_mode | hwd_abif__caf_phy_control_mode @0x8ce648 | — |
| 0x109 | hwd_abif_caf_pwdn_mode | hwd_abif__caf_pwdn_mode @0x8ce690 | — |
| 0x10a | hwd_abif_caf_lpbk_mode | hwd_abif__caf_lpbk_mode @0x8ce5e8 | — |
| 0x10b | hwd_abif_adc_sar_vreg_ctrl | hwd_abif__adc_sar_vreg_ctrl @0x8ce518 | — |
| 0x10c | hwd_abif_txrx_table_index_lpbk_mode | hwd_abif__txrx_table_index_lpbk_mode @0x8cff68 | — |
| 0x10d | hwd_abif_lpbk_mode_switches_config | hwd_abif__lpbk_mode_switches_config @0x8ceb2c | — |
| 0x10e | hwd_abif_tx_table_index_force_mode | hwd_abif__tx_table_index_force_mode @0x8cfef8 | — |
| 0x10f | hwd_abif_rx_table_index_force_mode | hwd_abif__rx_table_index_force_mode @0x8cf5a8 | — |
| 0x110 | hwd_abif_sar_dc_config_rgf_mode | hwd_abif__sar_dc_config_rgf_mode @0x8cf91c | — |
| 0x111 | hwd_abif_rx_rgf_config_sar_dc | hwd_abif__rx_rgf_config_sar_dc @0x8ceee0 | — |
| 0x112 | hwd_abif_rx_rgf_update_sar_dc | hwd_abif__rx_rgf_update_sar_dc @0x8cefdc | — |
| 0x113 | hwd_abif_rx_rgf_sar_dc_load | hwd_abif__rx_rgf_sar_dc_load @0x8cefc8 | — |
| 0x114 | hwd_abif_rx_rgf_read_sar_dc | hwd_abif__rx_rgf_read_sar_dc @0x8cefa0 | — |
| 0x115 | hwd_abif_sar_cal_dc_rgf_clear_all | hwd_abif__sar_cal_dc_rgf_clear_all @0x8cf900 | — |
| 0x116 | hwd_abif_rx_rgf_config_sar_gain | hwd_abif__rx_rgf_config_sar_gain @0x8cef50 | — |
| 0x117 | hwd_abif_rx_table_config_sar_dc | hwd_abif__rx_table_config_sar_dc @0x8cf19c | — |
| 0x118 | hwd_abif_rx_table_config_vga_gain | hwd_abif_rx_table_config_vga_gain @0x8cf418 | совпало (своя строка) |
| 0x119 | hwd_abif_rx_table_config_vga_dc | hwd_abif__rx_table_config_vga_dc @0x8cf36c | — |
| 0x11a | hwd_abif_rx_table_read_ifrx_ctrl | wmi_evt__send_command_not_supported @0x8e5728 | — |
| 0x11b | hwd_abif_rx_table_config_ifrx_ctrl | hwd_abif__rx_table_config_ifrx_ctrl @0x8cf0f8 | — |
| 0x11c | hwd_abif_rx_table_config_ifrx_gain | hwd_abif__rx_table_config_ifrx_gain @0x8cf15c | — |
| 0x11d | hwd_abif_tx_table_config_dac_fssel | hwd_abif__tx_table_config_dac_fssel @0x8cfc80 | — |
| 0x11e | hwd_abif_tx_table_config_lo_leak_gain | hwd_abif__tx_table_config_lo_leak_gain @0x8cfdbc | — |
| 0x11f | hwd_abif_tx_table_config_lo_leak_ctrl | hwd_abif__tx_table_config_lo_leak_ctrl @0x8cfd50 | — |
| 0x120 | hwd_abif_tx_table_config_iftx_ctrl | hwd_abif__tx_table_config_iftx_ctrl @0x8cfcb4 | — |
| 0x121 | hwd_abif_tx_table_config_iftx_gain | hwd_abif__tx_table_config_iftx_gain @0x8cfd18 | — |
| 0x122 | hwd_abif_tx_table_config_xif_gain | hwd_abif__tx_table_config_xif_gain @0x8cfe9c | — |
| 0x123 | hwd_abif_tx_table_config_xif_ctrl | hwd_abif__tx_table_config_xif_ctrl @0x8cfe5c | — |
| 0x124 | hwd_abif_sensor_set_thermal_mode | hwd_abif__sensor_set_thermal_mode @0x8cfaac | — |
| 0x125 | hwd_abif_sensor_measure_start | hwd_abif__sensor_measure_start @0x8cf9e4 | — |
| 0x126 | hwd_abif_sensor_set_comp_value | hwd_abif__sensor_set_comp_value @0x8cfaa0 | — |
| 0x127 | hwd_abif_sensor_get_comp_out | hwd_abif__sensor_get_comp_out @0x8cf9b0 | — |
| 0x128 | hwd_abif_sar_dc_config_rgf_mode_get | hwd_abif__sar_dc_config_rgf_mode_get @0x8cf948 | — |
| 0x129 | hwd_abif_rx_table_index_force_en_get | hwd_abif__rx_table_index_force_en_get @0x8cf59c | — |
| 0x12a | hwd_abif_rx_table_index_force_val_get | abif__get_rx_table_index_force_val @0x8cf5ec | — |
| 0x12b | hwd_abif_rx_prepare_ifrx_pwdn | hwd_abif__rx_prepare_ifrx_pwdn @0x8cee2c | — |
| 0x12c | hwd_abif_rx_prepared_ifrx_pwdn_get | hwd_abif__rx_prepared_ifrx_pwdn_get @0x8ceec0 | — |
| 0x12d | hwd_abif_rx_prepare_rvga_pwdn | hwd_abif__rx_prepare_rvga_pwdn @0x8cee94 | — |
| 0x12e | hwd_abif_rx_prepared_rvga_pwdn_get | hwd_abif__rx_prepared_rvga_pwdn_get @0x8ceed0 | — |
| 0x12f | hwd_abif_tx_table_config_tx_mixer_gate_ctrl | hwd_abif__tx_table_config_tx_mixer_gate_ctrl @0x8cfe24 | — |
| 0x130 | hwd_abif_rx_table_config_vga_dc_dac_pwdn | hwd_abif__rx_table_config_vga_dc_dac_pwdn @0x8cf3e0 | — |
| 0x131 | hwd_abif_bgap_ctrl | hwd_abif__bgap_ctrl @0x8ce5c0 | — |
| 0x132 | hwd_abif_rx_table_read_vga_dc | hwd_abif__rx_table_read_vga_dc @0x8cf718 | — |
| 0x133 | hwd_abif_rx_table_config_vga_bias | hwd_abif__rx_table_config_vga_bias @0x8cf2cc | — |
| 0x134 | hwd_abif_rx_table_read_vga_bias | hwd_abif__rx_table_read_vga_bias @0x8cf6b0 | — |
| 0x135 | hwd_abif_rx_table_read_row | hwd_abif__uses_rgf_88a208_8cf5fc @0x8cf5fc | — |
| 0x136 | hwd_abif_rx_table_write_row | hwd_abif__rx_table_write_row @0x8cf8c0 | — |
| 0x137 | hwd_abif_tx_table_index_force_en_get | hwd_abif__tx_table_index_force_en_get @0x8cfeec | — |
| 0x138 | hwd_abif_tx_table_index_force_val_get | hwd_abif__tx_table_index_force_val_get @0x8cff3c | — |
| 0x139 | hwd_abif_sensor_set_bgp_params | hwd_abif__sensor_set_bgp_params @0x8cfa24 | — |
| 0x13a | hwd_abif_tx_table_config_dig_atten | wmi_evt__send_command_not_supported @0x8e5728 | — |
| 0x13b | hwd_abif_tx_table_read_dig_atten | wmi_evt__send_command_not_supported @0x8e5728 | — |
| 0x13c | hwd_abif_tx_table_read_dac_fssel_ext | wmi_evt__send_command_not_supported @0x8e5728 | — |
| 0x13d | hwd_abif_tx_table_config_dac_fssel_ext | wmi_evt__send_command_not_supported @0x8e5728 | — |
| 0x13e | - | wmi_evt__send_command_not_supported @0x8e5728 | — |
| 0x13f | - | wmi_evt__send_command_not_supported @0x8e5728 | — |
| 0x140 | hwd_abif_rx_table_config_vga_atten | hwd_abif__rx_table_config_vga_atten @0x8cf250 | — |
| 0x141 | hwd_abif_rx_table_read_vga_atten | hwd_abif__rx_table_read_vga_atten @0x8cf640 | — |
| 0x142 | hwd_abif_rx_table_config_vga_stg1_fine_bias | hwd_abif__rx_table_config_vga_stg1_fine_bias @0x8cf4f8 | — |
| 0x143 | hwd_abif_rx_table_read_vga_stg1_fine_bias | hwd_abif__rx_table_read_vga_stg1_fine_bias @0x8cf848 | — |
| 0x144 | hwd_abif_battery_config | hwd_abif_battery_config @0x8ce534 | совпало (своя строка) |
| 0x145 | hwd_abif_rx_table_read_vga_gain | hwd_abif_rx_table_read_vga_gain @0x8cf788 | совпало (своя строка) |
| 0x146 | hwd_abif_rx_table_read_sar_dc | hwd_abif__tx_table_read_dac_fssel @0x8cff4c | расходится: своя строка ABIF_TX_TABLE_READ_DAC_FSSEL |
| 0x147 | - | wmi_evt__send_command_not_supported @0x8e5728 | — |
| 0x148 | - | wmi_evt__send_command_not_supported @0x8e5728 | — |
| 0x149 | - | wmi_evt__send_command_not_supported @0x8e5728 | — |
| 0x14a | - | wmi_evt__send_command_not_supported @0x8e5728 | — |
| 0x14b | - | wmi_evt__send_command_not_supported @0x8e5728 | — |
| 0x14c | - | wmi_evt__send_command_not_supported @0x8e5728 | — |
| 0x14d | - | wmi_evt__send_command_not_supported @0x8e5728 | — |
| 0x14e | - | wmi_evt__send_command_not_supported @0x8e5728 | — |
| 0x14f | - | wmi_evt__send_command_not_supported @0x8e5728 | — |
| 0x150 | hwd_abif_tx_table_force_reload | hwd_abif__tx_table_force_reload @0x8cfed8 | — |
| 0x151 | hwd_abif_rx_table_force_reload | hwd_abif__rx_table_force_reload @0x8cf588 | — |
| 0x152 | hwd_abif_rx_table_all_vgas_gain_config_n_force | hwd_abif__config_vga_rows @0x8cf0ac | — |
| 0x153 | hwd_abif_rx_table_all_vgas_dacs_config | hwd_abif__set_agc_column @0x8cf080 | — |
| 0x154 | hwd_abif_rx_table_config_vga_stg1_fine_bias_all_rows | hwd_abif__rx_table_config_vga_stg1_fine_bias_all_rows @0x8cf550 | — |
| 0x155 | hwd_abif_rx_table_config_vga_bias_all_rows | hwd_abif__rx_table_config_vga_bias_all_rows @0x8cf33c | — |
| 0x156 | hwd_abif_dvs_rf_activate | hwd_abif__dvs_rf_activate @0x8ce838 | — |
| 0x157 | hwd_abif_dvs_rfca_activate | hwd_abif__dvs_rfca_activate @0x8ce89c | — |
| 0x158 | hwd_abif_dvs_rfca_cmd_enable | hwd_abif__dvs_rfca_cmd_enable @0x8ce910 | — |
| 0x159 | hwd_abif_dvs_if_splitter_enable | hwd_abif__dvs_if_splitter_enable @0x8ce6b8 | — |
| 0x15a | - | wmi_evt__send_command_not_supported @0x8e5728 | — |
| 0x15b | - | wmi_evt__send_command_not_supported @0x8e5728 | — |
| 0x15c | - | wmi_evt__send_command_not_supported @0x8e5728 | — |
| 0x15d | - | wmi_evt__send_command_not_supported @0x8e5728 | — |
| 0x15e | - | wmi_evt__send_command_not_supported @0x8e5728 | — |
| 0x15f | - | wmi_evt__send_command_not_supported @0x8e5728 | — |
| 0x160 | hwd_abif_dvs_lo_splitter_enable | hwd_abif__dvs_lo_splitter_enable @0x8ce794 | — |
| 0x161 | hwd_abif_dvs_lo_splitter_config_buf_val | hwd_abif__dvs_lo_splitter_config_buf_val @0x8ce6fc | — |
| 0x162 | hwd_abif_dvs_rfca_config_en | hwd_abif__dvs_rfca_config_en @0x8ce9d4 | — |
| 0x163 | hwd_abif_tx_set_gain_per_mcs | ut_hw_drivers__check_index @0x8cfc0c | — |
| 0x164 | - | rfca__get_rf_mask @0x8ce9c4 | — |
| 0x170 | hwd_abif_set_freq_ratio | channel__check_range @0x8cfadc | совпало (строка ветки диспетчера ABIF_SET_FREQ_RATIO) |
| 0x171 | hwd_abif_bgap_bias_init | hwd_abif__out_to_bump_ctl @0x8cebdc | расходится: своя строка ABIF_OUT_TO_BUMP_CTL, два аргумента (в паке без аргументов) |
| 0x201 | hwd_car_sys_clk_165mhz_activate | car__enable_pll3_and_wait_on @0x8d03ec | — |
| 0x202 | hwd_car_sys_clk_xtal_activate | hwd__wait_pll_lock @0x8d041c | — |
| 0x203 | hwd_car_sys_clk_10khz_activate | ut_hw_drivers_cmd_0x203 @0x8d03d8 | — |
| 0x301 | hwd_mac_trigger_sxd_tx_mode | hwd_mac__trigger_sxd_tx_mode @0x8d1008 | — |
| 0x302 | hwd_mac_sxd_rx_mode_entry | hwd_mac__sxd_rx_mode_entry @0x8d0ff8 | — |
| 0x303 | hwd_mac_sxd_mode_neutral | hwd_mac__sxd_mode_neutral @0x8d0fe0 | — |
| 0x304 | hwd_mac_sxd_tx_phy_frame_start | hwd_mac__sxd_tx_phy_frame_start @0x8d1044 | — |
| 0x305 | - | field_set_0x00__8db5bc @0x8db5bc | — |
| 0x401 | hwd_phy_self_tx_mode_entry | hwd_phy__self_tx_mode_entry @0x8d2be4 | — |
| 0x402 | hwd_phy_self_rx_mode_entry | hwd_phy__self_rx_mode_entry @0x8d2ba4 | — |
| 0x403 | hwd_phy_self_mode_exit | hwd_phy__self_mode_exit @0x8d2b38 | — |
| 0x404 | hwd_phy_self_digital_loopback | hwd_phy__self_digital_loopback @0x8d2b0c | — |
| 0x405 | hwd_phy_dbg_clk_enable | hwd_phy_dbg_clk_enable @0x8d1bc0 | — |
| 0x406 | hwd_phy_rgf_tx_en | hwd_phy__tx_enable @0x8d21d0 | — |
| 0x407 | hwd_phy_tx_self_transmit | hwd_phy__tx_self_transmit @0x8d2f88 | — |
| 0x408 | hwd_phy_tx_self_transmit_wait_completion | hwd_phy__tx_self_transmit_wait_completion @0x8d3024 | — |
| 0x409 | hwd_phy_tx_singen_config | hwd_phy__tx_singen_config @0x8d3090 | — |
| 0x40a | hwd_phy_tx_singen_transmit | hwd_phy__tx_singen_transmit @0x8d3100 | — |
| 0x40b | hwd_phy_tx_play_buffer_start | hwd_phy__tx_play_buffer_start @0x8d2d40 | — |
| 0x40c | hwd_phy_tx_play_buffer_stop | hwd_phy__tx_play_buffer_stop @0x8d2e18 | — |
| 0x40d | hwd_phy_tx_predist_iq_config | hwd_phy__tx_predist_iq_config @0x8d2f1c | — |
| 0x40e | hwd_phy_tx_predist_atten_man_config | hwd_phy__tx_predist_atten_man_config @0x8d2e48 | — |
| 0x40f | hwd_phy_tx_predist_dc_config | hwd_phy__tx_predist_dc_config @0x8d2eb8 | — |
| 0x410 | hwd_phy_rgf_rx_en | hwd_phy__rx_enable @0x8d219c | — |
| 0x411 | hwd_phy_rx_ina_det_mode | hwd_phy__rx_ina_det_mode @0x8d2630 | — |
| 0x412 | hwd_phy_rx_agc_steps_disable | hwd_phy__rx_agc_steps_disable @0x8d2260 | — |
| 0x413 | hwd_phy_rx_agc_index_force_mode | hwd_phy__rx_agc_index_force_mode @0x8d2218 | — |
| 0x414 | hwd_phy_rx_channel_freq_ratio_switch | phy__program_channel_regs @0x8d24fc | — |
| 0x415 | - | wmi_evt__send_command_not_supported @0x8e5728 | — |
| 0x416 | hwd_phy_rx_postdist_dc_enable | hwd_phy__rx_postdist_dc_enable @0x8d26d0 | — |
| 0x417 | hwd_phy_rx_postdist_dc_per_sar_mode | hwd_phy__rx_postdist_dc_per_sar_mode @0x8d2700 | — |
| 0x418 | hwd_phy_rx_postdist_sar_dc_config | hwd_phy__rx_postdist_sar_dc_config @0x8d2784 | — |
| 0x419 | hwd_phy_rx_postdist_force_dc_set | hwd_phy__rx_postdist_force_dc_set @0x8d2758 | — |
| 0x41a | hwd_phy_rx_postdist_force_dc_config | hwd_phy__rx_postdist_force_dc_config @0x8d2728 | — |
| 0x41b | hwd_phy_online_measurement_config | hwd_phy__online_measurement_config @0x8d1df0 | — |
| 0x41c | hwd_phy_online_measurement_start | hwd_phy__online_measurement_start @0x8d1e34 | — |
| 0x41d | hwd_phy_online_sar_measurement_valid | hwd_phy__online_sar_measurement_valid @0x8d1e58 | — |
| 0x41e | hwd_phy_online_dc_measurement_read | hwd_phy__online_dc_measurement_read @0x8d1d94 | — |
| 0x41f | hwd_phy_online_gain_measurement_read | hwd_phy__online_gain_measurement_read @0x8d1dc8 | — |
| 0x420 | hwd_phy_rx_statistics_lock | hwd_phy__rx_statistics_lock @0x8d2b00 | — |
| 0x421 | hwd_phy_rx_statistics_clear | hwd_phy__rx_statistics_clear @0x8d2ae4 | — |
| 0x422 | hwd_phy_rx_get_statistics | phy__read_rx_counters @0x8d25e8 | — |
| 0x423 | hwd_phy_rx_cal_corr_config | hwd_phy__rx_cal_corr_config @0x8d2418 | — |
| 0x424 | hwd_phy_rx_cal_corr | hwd_phy__rx_cal_corr @0x8d23a0 | — |
| 0x425 | hwd_phy_rx_sar_cal_measurement_config | hwd_phy__rx_sar_cal_measurement_config @0x8d28ec | — |
| 0x426 | hwd_phy_rx_sar_measurement_start | hwd_phy__rx_sar_measurement_start @0x8d2958 | — |
| 0x427 | hwd_phy_rx_sar_measurement_completed | hwd_phy__rx_sar_measurement_completed @0x8d2920 | — |
| 0x428 | hwd_phy_rx_cal_dc_measurement_read | hwd_phy__read_sar_sample @0x8d2474 | — |
| 0x429 | hwd_phy_rx_cal_gain_measurement_read | hwd_phy__rx_cal_gain_measurement_read @0x8d24bc | — |
| 0x42a | hwd_phy_rx_apu_calc | hwd_phy__rx_apu_calc @0x8d2314 | — |
| 0x42b | hwd_phy_recording_mode_set | hwd_phy__recording_mode_set @0x8d1fc8 | — |
| 0x42c | hwd_phy_rx_cal_corr_input_config | hwd_phy_recording_get @0x8d1f24 | расходится: hwd_phy_recording_get |
| 0x42d | hwd_phy_rx_get_rec_last_address | memset0_words @0x8c1cd8 | — |
| 0x42e | hwd_phy_recording_mode_set_ext | hwd_phy_rx_sar_rssi_measure @0x8d2968 | расходится: hwd_phy_rx_sar_rssi_measure |
| 0x430 | hwd_phy_store_txrx_swap_iq | hwd_PHY_STORE_TXRX_SWAP_IQ @0x8d2d10 | совпало (своя строка) |
| 0x431 | hwd_phy_set_tx_swap_iq | hwd_phy__set_tx_swap_iq @0x8d2c98 | — |
| 0x432 | hwd_phy_set_rx_swap_iq | hwd_phy__set_rx_swap_iq @0x8d2c1c | — |
| 0x433 | hwd_phy_rx_ina_det_mode_get | phy__get_rx_ina_det_mode @0x8d263c | — |
| 0x434 | hwd_phy_dbg_clk_enable_get | hwd_phy__dbg_clk_enable_get @0x8d1c20 | — |
| 0x435 | hwd_phy_online_measurement_stop | hwd_phy__online_measurement_stop @0x8d1e48 | — |
| 0x436 | hwd_phy_online_measurement_completed | hwd_phy__online_measurement_completed @0x8d1de0 | — |
| 0x437 | hwd_phy_rx_set_agc_start | ut_hw_drivers__pair_2568 @0x8d2a50 | — |
| 0x438 | hwd_phy_tof_get_tx_rx_offset | tof__get_tx_offset @0x8d46ac | — |
| 0x501 | hwd_rfc_activate | hwd__program_889_group @0x8d31dc | — |
| 0x502 | hwd_rfc_write_core | hwd_rfc_write_core_fw @0x8d415c | совпало (своя строка) |
| 0x503 | hwd_rfc_write_rgf | rfc_field_write @0x8d4308 | — |
| 0x504 | hwd_rfc_read_rgf | hwd_rfc_read_rgf @0x8d3588 | совпало (своя строка) |
| 0x505 | hwd_rfc_rx_sect_on | rf_sector_commit_rx @0x8d37dc | — |
| 0x506 | hwd_rfc_tx_sect_on | rf_sector_commit_tx @0x8d40d8 | — |
| 0x507 | hwd_rfc_rx_sectgain_on | ut_hw_drivers_cmd_0x507 @0x8d3808 | — |
| 0x508 | hwd_rfc_tx_sectgain_on | ut_hw_drivers_cmd_0x508 @0x8d4104 | — |
| 0x509 | hwd_rfc_powerdown | hwd_rfc_write_core_fw_mode1 @0x8d33ec | — |
| 0x50a | hwd_rf_caf_powerdown_deep | hwd__setup_pair @0x8d33f8 | расходится: hwd_RFC_POWERDOWN_DEEP_ENTRY |
| 0x50b | hwd_rfc_rf_reset | hwd_rfc__uses_rgf_889100 @0x8d37a8 | — |
| 0x50c | hwd_rfc_sector_edge_gain_set | hwd_rfc_sector_edge_gain_set @0x8d39f8 | совпало (своя строка) |
| 0x50d | hwd_rfc_sector_edge_gain_get | hwd_rfc__read_sector_chain @0x8d3954 | — |
| 0x50e | hwd_rfc_sector_edge_phase_set | — | — |
| 0x50f | hwd_rfc_sector_edge_phase_get | ut_hw_drivers_cmd_0x50f @0x8d3b90 | — |
| 0x510 | hwd_rfc_sector_dist_gain_set | — | — |
| 0x511 | hwd_rfc_sector_dist_gain_get | hwd_rfc__read_sector_reg @0x8d3850 | — |
| 0x512 | hwd_rfc_sector_x16_state_set | — | — |
| 0x513 | hwd_rfc_sector_x16_state_get | ut_hw_drivers_cmd_0x513 @0x8d3d64 | — |
| 0x514 | hwd_rfc_write_sector_tlna2 | — | — |
| 0x515 | hwd_rfc_read_sector | rfc_read_sector_params @0x8d3678 | — |
| 0x516 | hwd_rfc_xpm_wave_wr_set | rfc__probe_modules @0x8d3fb4 | — |
| 0x517 | hwd_rfc_xpm_wave_wr_get | rfc__collect_rx_crc_stats @0x8d4010 | — |
| 0x518 | hwd_rfc_xpm_wave_rd_set | xpm__wave_rd_set @0x8d4670 | — |
| 0x519 | hwd_rfc_xpm_wave_rd_get | xpm__read_cfg_378 @0x8d4660 | — |
| 0x51a | hwd_rfc_txrx_watchdog_set | xpm__write_cfg_350 @0x8d4650 | — |
| 0x51b | hwd_rfc_txrx_watchdog_get | xpm__read_cfg_350 @0x8d4640 | — |
| 0x51c | hwd_rfc_edge_gain_offset_entry_set | hwd_rfc_read_rgf @0x8d3588 | расходится: hwd_rfc_read_rgf |
| 0x51d | hwd_rfc_edge_gain_offset_entry_get | hwd_rfc_read_rgf @0x8d3588 | расходится: hwd_rfc_read_rgf |
| 0x51e | hwd_rfc_edge_iref_entry_set | hwd_rfc_read_calibrate @0x8f3f7c | расходится: hwd_rfc_read_calibrate |
| 0x601 | hwd_pcie_port1_serdes_reset | hwd_pcie__port1_serdes_reset @0x8d1a00 | — |
| 0x602 | hwd_pcie_memory_pm | hwd_pcie__set_mode_map @0x8d18e8 | — |
| 0x610 | - | ut_hw_drivers__zero_result @0x8f3ed8 | — |
| 0x611 | - | ut_hw_drivers__step_8f4480 @0x8f3f1c | — |

## Замечания

* 0x50a: имя пака `hwd_rf_caf_powerdown_deep`, собственная строка функции —
  `hwd_RFC_POWERDOWN_DEEP_ENTRY`; по смыслу (powerdown deep) совпадают, по имени
  расходятся — в таблице отнесено к расходящимся.
* 0x171: в паке без аргументов, в 6.2 — два аргумента.

## Не установлено

* Блоки обработчиков 0x50e, 0x510, 0x512, 0x514.
* Соответствие имён пака для строк без собственной лог-строки (колонка «проверка» = «—»).
