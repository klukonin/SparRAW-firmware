/* interrupt_handlers__isrs @ 0x8c0eec, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.interrupt_handlers__isrs,"ax",@progbits
	.global interrupt_handlers__isrs
interrupt_handlers__isrs:
	.byte 0x40
	.byte 0x87
L_8c0eee:
	nop_s
L_8c0ef0:
	j.f [ilink1]
