/* interrupt_vector_03 @ 0x8c0018, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.interrupt_vector_03,"ax",@progbits
	.global interrupt_vector_03
interrupt_vector_03:
L_8c0018:
	/* j 0x00016f24 */
	.byte 0x20,0x20,0x80,0x0f,0x01,0x00,0x24,0x6f
