/* field_set_0x00__920cd4 @ 0x920cd4, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x08_handler
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global field_set_0x00__920cd4
field_set_0x00__920cd4:
	.global L_920cd4
L_920cd4:
	add2_s r1,r1,r1
L_920cd6:
	add_s r0,r0,r1
L_920cd8:
	j_s.d [blink]
L_920cda:
	stb_s r2,[r0]
