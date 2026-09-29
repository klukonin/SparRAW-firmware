/* hwd_phy__tx_enable @ 0x8d21d0, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: IF_GAIN__GAIN, UT_HW_DRIVERS_cmd_handler, calib__setup_loopback_hw, calib__setup_loopback_hw_b, calib__setup_loopback_rx_path, calib_corr__estimate_and_apply_rx_gain, calib_silent_rssi_sparrow__correction_alg, fw_sysassert_fatal, hwf_calib__release_hw, hwm__apply_channel_config
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__tx_enable
hwd_phy__tx_enable:
	.global L_8d21d0
L_8d21d0:
	push_s blink
L_8d21d2:
	push_s r13
L_8d21d4:
	mov_s r13,r0
L_8d21d6:
	bclr.f r0,r0,0x0
L_8d21da:
	bne_s L_8d21ee
	.global L_8d21dc
L_8d21dc:
	mov_s r1,0x884000
L_8d21e2:
	ld_s r0,[r1,0x8]
L_8d21e4:
	bclr_s r0,r0,0x0
L_8d21e6:
	or_s r13,r13,r0
L_8d21e8:
	st_s r13,[r1,0x8]
L_8d21ea:
	b L_8c025c
	.global L_8d21ee
L_8d21ee:
	mov_s r0,blink
L_8d21f0:
	bl.d L_8c9b28
L_8d21f4:
	mov_s r1,0xac
L_8d21f6:
	b_s L_8d21dc
