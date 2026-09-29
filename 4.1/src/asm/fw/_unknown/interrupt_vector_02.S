/* interrupt_vector_02 @ 0x8c0010, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.interrupt_vector_02,"ax",@progbits
	.global interrupt_vector_02
interrupt_vector_02:
L_8c0010:
	/* j 0x00000774 */
	.byte 0x20,0x20,0x80,0x0f,0x00,0x00,0x74,0x07
