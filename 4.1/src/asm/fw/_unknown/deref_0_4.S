/* deref_0_4 @ 0x8ca7f4, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mbox__ring_init
 */
	.section .text.deref_0_4,"ax",@progbits
	.global deref_0_4
deref_0_4:
	.global L_8ca7f4
L_8ca7f4:
	ld_s r0,[r0]
L_8ca7f6:
	j_s.d [blink]
L_8ca7f8:
	ld_s r0,[r0,0x4]
L_8ca7fa:
	nop_s
