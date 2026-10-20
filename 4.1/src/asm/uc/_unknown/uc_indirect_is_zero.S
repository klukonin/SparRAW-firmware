/* uc_indirect_is_zero @ 0x928fc0, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_field_0x24_is_zero
 */
	.section .text.uc_indirect_is_zero,"ax",@progbits
	.global uc_indirect_is_zero
uc_indirect_is_zero:
	.global L_928fc0
L_928fc0:
	ld_s r1,[r0]
L_928fc2:
	ld_s r0,[r1]
L_928fc4:
	rsub.f r0,r0,0x1
L_928fc8:
	j.d [blink]
L_928fcc:
	mov.cs r0,0x0
