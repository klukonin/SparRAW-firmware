/* hwd_phy__rx_enable @ 0x8d219c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: IF_GAIN__GAIN, UT_HW_DRIVERS_cmd_handler, calib__setup_loopback_hw, calib__setup_loopback_hw_b, calib__setup_loopback_rx_path, calib_corr__estimate_and_apply_rx_gain, calib_lo_leakage_substep, calib_silent_rssi_sparrow__correction_alg, hwf_calib__release_hw, hwm__apply_channel_config
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__rx_enable
hwd_phy__rx_enable:
	.global L_8d219c
L_8d219c:
	push_s blink
L_8d219e:
	push_s r13
L_8d21a0:
	mov_s r13,r0
L_8d21a2:
	bclr.f r0,r0,0x0
L_8d21a6:
	bne_s L_8d21ba
	.global L_8d21a8
L_8d21a8:
	mov_s r1,0x883000
L_8d21ae:
	ld_s r0,[r1,0x10]
L_8d21b0:
	bclr_s r0,r0,0x0
L_8d21b2:
	or_s r13,r13,r0
L_8d21b4:
	st_s r13,[r1,0x10]
L_8d21b6:
	b L_8c025c
	.global L_8d21ba
L_8d21ba:
	mov_s r0,blink
L_8d21bc:
	bl.d L_8c9b28
L_8d21c0:
	mov_s r1,0xac
L_8d21c2:
	b_s L_8d21a8
