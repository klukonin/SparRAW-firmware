/* rf_power_off @ 0x8e2fa8, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rf_power_off(): Powering off RF HW
 * Зовут его: fw_main, marlon_r_if_class__config_channel, marlon_r_if_class__init_board_file_interface
 * Зовёт сам: fw_log_emit0, sdp__drive_pin_timed
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf_power_off
rf_power_off:
	.global L_8e2fa8
L_8e2fa8:
	push_s blink
L_8e2faa:
	mov_s r1,0x1005a54
L_8e2fb0:
	bl.d L_8dcba8
L_8e2fb4:
	mov_s r0,0x10
L_8e2fb6:
	bl.d L_8d6e88
L_8e2fba:
	mov_s r0,0x0
L_8e2fbc:
	pop_s blink
L_8e2fbe:
	j_s [blink]
