/* rfca__get_rf_mask @ 0x8ce9c4, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: TEMPERATURE_SERVICE__read_rf_sensor_calibration_parameters, UT_HW_DRIVERS_cmd_handler, calibrate_baseband_gain, hw_sysapi_rfc_fetch_rgf_util, hwd_rfc_read_calibrate, marlon_r_if__read_step
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rfca__get_rf_mask
rfca__get_rf_mask:
	.global L_8ce9c4
L_8ce9c4:
	mov_s r0,0x889480
L_8ce9ca:
	ld_s r0,[r0,0x8]
L_8ce9cc:
	lsr_s r0,r0,0x8
L_8ce9ce:
	j_s.d [blink]
L_8ce9d0:
	extb_s r0,r0
L_8ce9d2:
	nop_s
