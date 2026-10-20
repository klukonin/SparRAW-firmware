/* uc_interrupt_vector_00 @ 0x920000, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.uc_interrupt_vector_00,"ax",@progbits
	.global uc_interrupt_vector_00
uc_interrupt_vector_00:
L_920000:
	/* j 0x00000140 */
	.byte 0x20,0x20,0x80,0x0f,0x00,0x00,0x40,0x01
