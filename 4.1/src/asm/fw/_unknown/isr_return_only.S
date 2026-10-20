/* isr_return_only @ 0x8c0b2c, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.isr_return_only,"ax",@progbits
	.global isr_return_only
isr_return_only:
L_8c0b2c:
	j.f [ilink1]
