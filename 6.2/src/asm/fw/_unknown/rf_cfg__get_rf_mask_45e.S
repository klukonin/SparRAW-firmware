/* rf_cfg__get_rf_mask_45e @ 0x8ccb3c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: TEMPERATURE_SERVICE__read_rf_sensor_calibration_parameters, basic_calib_sparrow__estimation_alg, calib__setup_loopback_hw, calib__setup_loopback_hw_b, calib__setup_loopback_rx_path, calib__start_scheme4, calib_corr__estimate_and_apply_rx_gain, calib_silent_rssi_sparrow__correction_alg, calibrate_baseband_gain, deep_sleep_exit
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf_cfg__get_rf_mask_45e
rf_cfg__get_rf_mask_45e:
	.global L_8ccb3c
L_8ccb3c:
	ldb r0,[r0,0x45e]
L_8ccb44:
	j_s [blink]
L_8ccb46:
	nop_s
