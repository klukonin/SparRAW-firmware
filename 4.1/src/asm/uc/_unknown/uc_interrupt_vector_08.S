/* uc_interrupt_vector_08 @ 0x920040, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.uc_interrupt_vector_08,"ax",@progbits
	.global uc_interrupt_vector_08
uc_interrupt_vector_08:
L_920040:
	/* j 0x00001410 */
	.byte 0x20,0x20,0x80,0x0f,0x00,0x00,0x10,0x14
