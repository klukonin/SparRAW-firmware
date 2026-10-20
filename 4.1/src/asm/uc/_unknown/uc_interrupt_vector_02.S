/* uc_interrupt_vector_02 @ 0x920010, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.uc_interrupt_vector_02,"ax",@progbits
	.global uc_interrupt_vector_02
uc_interrupt_vector_02:
L_920010:
	/* j 0x00001170 */
	.byte 0x20,0x20,0x80,0x0f,0x00,0x00,0x70,0x11
