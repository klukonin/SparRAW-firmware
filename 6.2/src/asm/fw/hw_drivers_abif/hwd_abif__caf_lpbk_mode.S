/* hwd_abif__caf_lpbk_mode @ 0x8ce5e8, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: IF_GAIN__GAIN, UT_HW_DRIVERS_cmd_handler, calib__setup_loopback_hw, calib__setup_loopback_hw_b, calib__setup_loopback_rx_path, calib_corr__estimate_and_apply_rx_gain, calib_silent_rssi_sparrow__correction_alg, hw_modes__set_loopback, hwf__set_agc_index_1c, hwf_calib__release_hw
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__caf_lpbk_mode
hwd_abif__caf_lpbk_mode:
	.global L_8ce5e8
L_8ce5e8:
	push_s blink
L_8ce5ea:
	push_s r13
L_8ce5ec:
	mov_s r13,r0
L_8ce5ee:
	bclr.f r0,r0,0x0
L_8ce5f2:
	bne_s L_8ce608
	.global L_8ce5f4
L_8ce5f4:
	mov_s r1,0x88af80
L_8ce5fa:
	ld_s r0,[r1,0x68]
L_8ce5fc:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_8ce5fe:
	bclr_s r0,r0,0x2
L_8ce600:
	or_s r13,r13,r0
L_8ce602:
	st_s r13,[r1,0x68]
L_8ce604:
	b L_8c025c
	.global L_8ce608
L_8ce608:
	mov_s r0,blink
L_8ce60a:
	bl.d L_8c9b28
L_8ce60e:
	mov_s r1,0xac
L_8ce610:
	b_s L_8ce5f4
L_8ce612:
	nop_s
