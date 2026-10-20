/* interrupt_vector_04 @ 0x8c0020, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.interrupt_vector_04,"ax",@progbits
	.global interrupt_vector_04
interrupt_vector_04:
L_8c0020:
	/* j 0x00001000 */
	.byte 0x20,0x20,0x80,0x0f,0x00,0x00,0x00,0x10
