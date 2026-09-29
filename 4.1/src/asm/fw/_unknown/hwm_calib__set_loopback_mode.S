/* hwm_calib__set_loopback_mode @ 0x8d4c0c, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler, calib_lo_power_step, calib_mngr_step_a, calib_mngr_step_b, calib_silent_rssi__vt18, hwf_calib__prepare_hw, hwf_calib__release_hw, hwf_calib__setup_loopback, marlon_r_if_class__init_board_file_inteface
 * Зовёт сам: hwd_abif__rgf_88af80_8cb8d8, hwd_abif__set_sel_nibbles, hwd_mac__set_886d80_8ce294, set_reg_886dc8
 */
	.section .text.hwm_calib__set_loopback_mode,"ax",@progbits
	.global hwm_calib__set_loopback_mode
hwm_calib__set_loopback_mode:
	.global L_8d4c0c
L_8d4c0c:
	push_s blink
L_8d4c0e:
	breq_s r0,0,L_8d4c26
L_8d4c10:
	bl.d L_8cb8d8
L_8d4c14:
	mov_s r0,0x0
L_8d4c16:
	mov_s r0,0x3
L_8d4c18:
	mov_s r1,0x2
L_8d4c1a:
	bl.d L_8cbb20
L_8d4c1e:
	mov_s r2,0x0
L_8d4c20:
	bl L_8ce2ac
L_8d4c24:
	b_s L_8d4c2a
	.global L_8d4c26
L_8d4c26:
	bl L_8ce294
	.global L_8d4c2a
L_8d4c2a:
	pop_s blink
L_8d4c2c:
	j_s [blink]
L_8d4c2e:
	nop_s
