/* hwm__set_analog_path @ 0x8d4bd4, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler, calib_lo_power_step, hwf_PHY_IF_LOOPBACK_BER_TEST, hwf_calib__release_hw, hwf_calib__restore_path
 * Зовёт сам: __ld_r13_ret, hwd_abif__rgf_88a000_8cd018, hwd_abif__rgf_88af80_8cb8d8, hwd_abif__set_sel_nibbles
 */
	.section .text.hwm__set_analog_path,"ax",@progbits
	.global hwm__set_analog_path
hwm__set_analog_path:
	.global L_8d4bd4
L_8d4bd4:
	push_s blink
L_8d4bd6:
	push_s r13
L_8d4bd8:
	mov_s r13,r0
L_8d4bda:
	mov_s r0,r1
L_8d4bdc:
	bl.d L_8cd018
L_8d4be0:
	mov_s r1,r2
L_8d4be2:
	breq_s r13,0,L_8d4bf6
L_8d4be4:
	mov_s r0,0x3
L_8d4be6:
	mov_s r1,r0
L_8d4be8:
	bl.d L_8cbb20
L_8d4bec:
	mov_s r2,0x0
L_8d4bee:
	bl.d L_8cb8d8
L_8d4bf2:
	mov_s r0,0x1
L_8d4bf4:
	b_s L_8d4c06
	.global L_8d4bf6
L_8d4bf6:
	bl.d L_8cb8d8
L_8d4bfa:
	mov_s r0,0x0
L_8d4bfc:
	mov_s r0,0x3
L_8d4bfe:
	mov_s r1,0x2
L_8d4c00:
	bl.d L_8cbb20
L_8d4c04:
	mov_s r2,0x0
	.global L_8d4c06
L_8d4c06:
	b L_8c033c
L_8d4c0a:
	nop_s
