/* uc_interrupt_vector_01 @ 0x920008, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.uc_interrupt_vector_01,"ax",@progbits
	.global uc_interrupt_vector_01
uc_interrupt_vector_01:
L_920008:
	/* j 0x00001548 */
	.byte 0x20,0x20,0x80,0x0f,0x00,0x00,0x48,0x15
