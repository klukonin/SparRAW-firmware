/* uc_interrupt_vector_12 @ 0x920060, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.uc_interrupt_vector_12,"ax",@progbits
	.global uc_interrupt_vector_12
uc_interrupt_vector_12:
L_920060:
	/* j 0x00001220 */
	.byte 0x20,0x20,0x80,0x0f,0x00,0x00,0x20,0x12
