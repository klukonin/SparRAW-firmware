/* gpio__write_ctrl_b84 @ 0x8f4480, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: gpio__reset_config, ut_hw_drivers__step_8f4480
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global gpio__write_ctrl_b84
gpio__write_ctrl_b84:
	.global L_8f4480
L_8f4480:
	mov_s r1,0x880b80
L_8f4486:
	st_s r0,[r1,0x4]
L_8f4488:
	j_s [blink]
L_8f448a:
	nop_s
