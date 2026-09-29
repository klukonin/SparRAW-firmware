/* hwd_abif__rx_table_index_force_mode @ 0x8cf5a8, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib__setup_loopback_hw, calib__setup_loopback_rx_path, calib_corr__estimate_and_apply_rx_gain, calib_lo_leakage_step, calib_lo_leakage_substep, calib_lo_power_measure, calib_lo_power_substep, calib_silent_rssi_sparrow__correction_alg, hwd_abif__config_vga_rows
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__rx_table_index_force_mode
hwd_abif__rx_table_index_force_mode:
	.global L_8cf5a8
L_8cf5a8:
	push_s blink
L_8cf5aa:
	bl L_8c01e4
L_8cf5ae:
	mov_s r13,r0
L_8cf5b0:
	bclr.f r0,r0,0x0
L_8cf5b4:
	mov_s r14,r1
L_8cf5b6:
	bne_s L_8cf5d8
	.global L_8cf5b8
L_8cf5b8:
	bic.f 0x0,r14,0x3f
L_8cf5bc:
	bne_s L_8cf5e2
	.global L_8cf5be
L_8cf5be:
	mov_s r0,0x88a200
L_8cf5c4:
	ld_s r1,[r0,0x4]
L_8cf5c6:
	asl_s r14,r14
L_8cf5c8:
	bclr_s r1,r1,0x0
L_8cf5ca:
	or_s r1,r1,r13
L_8cf5cc:
	bic r1,r1,0x7e
L_8cf5d0:
	or_s r14,r14,r1
L_8cf5d2:
	st_s r14,[r0,0x4]
L_8cf5d4:
	b L_8c0254
	.global L_8cf5d8
L_8cf5d8:
	mov_s r0,blink
L_8cf5da:
	bl.d L_8c9b28
L_8cf5de:
	mov_s r1,0xad
L_8cf5e0:
	b_s L_8cf5b8
	.global L_8cf5e2
L_8cf5e2:
	mov_s r0,blink
L_8cf5e4:
	bl.d L_8c9b28
L_8cf5e8:
	mov_s r1,0xae
L_8cf5ea:
	b_s L_8cf5be
