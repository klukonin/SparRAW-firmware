/* get_reg_8802bc @ 0x8d752c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: deep_sleep_enter
 */
	.section .text.get_reg_8802bc,"ax",@progbits
	.global get_reg_8802bc
get_reg_8802bc:
	.global L_8d752c
L_8d752c:
	mov_s r0,0x8802bc
L_8d7532:
	ld_s r1,[r0,0x18]
L_8d7534:
	ld_s r0,[r0,0x1c]
L_8d7536:
	rsub.f r0,r0,r1
L_8d753a:
	j_s.d [blink]
L_8d753c:
	mov.ne r0,0x1
