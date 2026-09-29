/* mid_ctx__at @ 0x8ebd14, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__open_reset_state
 */
	.section .text.mid_ctx__at,"ax",@progbits
	.global mid_ctx__at
mid_ctx__at:
	.global L_8ebd14
L_8ebd14:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8ebd16:
	add3_s r0,r0,r0
L_8ebd18:
	add_s r0,r0,0x805d08
L_8ebd1e:
	j_s [blink]
