/* halt_loop @ 0x8c01fc, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.halt_loop,"ax",@progbits
	.global halt_loop
halt_loop:
	.global L_8c01fc
L_8c01fc:
	/* b 0x008c01fc */
	.byte 0x00,0x00,0x00,0x00
