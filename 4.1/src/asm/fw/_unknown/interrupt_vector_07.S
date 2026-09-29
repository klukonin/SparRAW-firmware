/* interrupt_vector_07 @ 0x8c0038, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.interrupt_vector_07,"ax",@progbits
	.global interrupt_vector_07
interrupt_vector_07:
L_8c0038:
	/* j 0x00016f4c */
	.byte 0x20,0x20,0x80,0x0f,0x01,0x00,0x4c,0x6f
