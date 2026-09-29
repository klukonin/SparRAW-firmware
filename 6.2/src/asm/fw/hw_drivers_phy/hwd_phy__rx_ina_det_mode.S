/* hwd_phy__rx_ina_det_mode @ 0x8d2630, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: IF_GAIN__GAIN, UT_HW_DRIVERS_cmd_handler, calib__setup_loopback_hw, calib__setup_loopback_rx_path, calib_lo_leakage_substep, calib_silent_rssi_sparrow__correction_alg, fw_sysassert_fatal, hwf_calib__release_hw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__rx_ina_det_mode
hwd_phy__rx_ina_det_mode:
	.global L_8d2630
L_8d2630:
	mov_s r1,0x883100
L_8d2636:
	st_s r0,[r1,0x50]
L_8d2638:
	j_s [blink]
L_8d263a:
	nop_s
