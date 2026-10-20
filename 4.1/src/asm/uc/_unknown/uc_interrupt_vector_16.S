/* uc_interrupt_vector_16 @ 0x920080, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.uc_interrupt_vector_16,"ax",@progbits
	.global uc_interrupt_vector_16
uc_interrupt_vector_16:
L_920080:
	/* j 0x00001360 */
	.byte 0x20,0x20,0x80,0x0f,0x00,0x00,0x60,0x13
