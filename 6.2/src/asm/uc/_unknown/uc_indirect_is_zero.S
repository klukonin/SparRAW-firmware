/* uc_indirect_is_zero @ 0x92be20, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_field_0x24_is_zero
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_indirect_is_zero
uc_indirect_is_zero:
	.global L_92be20
L_92be20:
	ld_s r1,[r0]
L_92be22:
	ld_s r0,[r1]
L_92be24:
	rsub.f r0,r0,0x1
L_92be28:
	j.d [blink]
L_92be2c:
	mov.cs r0,0x0
