/* interrupt_vector_01 @ 0x8c0008, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.interrupt_vector_01,"ax",@progbits
	.global interrupt_vector_01
interrupt_vector_01:
L_8c0008:
	/* j 0x000013a0 */
	.byte 0x20,0x20,0x80,0x0f,0x00,0x00,0xa0,0x13
