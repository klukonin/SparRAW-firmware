/* hwf_calib__restore_path @ 0x8d5eec, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_silent_rssi_sparrow__correction_alg, hwf_calib_all
 * Зовёт сам: hwd_mac__uses_rgf_886200, hwf_calib__release_hw, hwm__set_analog_path
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf_calib__restore_path
hwf_calib__restore_path:
	.global L_8d5eec
L_8d5eec:
	push_s blink
L_8d5eee:
	mov_s r0,0x0
L_8d5ef0:
	mov_s r1,r0
L_8d5ef2:
	bl.d L_8d7528
L_8d5ef6:
	mov_s r2,r0
L_8d5ef8:
	bl.d L_8d0fb4
L_8d5efc:
	mov_s r0,0x0
L_8d5efe:
	bl L_8d64c0
L_8d5f02:
	pop_s blink
L_8d5f04:
	j_s [blink]
L_8d5f06:
	nop_s
