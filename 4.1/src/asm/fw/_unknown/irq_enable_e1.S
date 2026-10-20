/* irq_enable_e1 @ 0x8c0394, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.irq_enable_e1,"ax",@progbits
	.global irq_enable_e1
irq_enable_e1:
L_8c0394:
	lr r0,[0xa]
L_8c0398:
	or r0,r0,0x2
L_8c039c:
	j.d [blink]
L_8c03a0:
	flag r0
