/* irq_enable_e2 @ 0x8c03a4, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.irq_enable_e2,"ax",@progbits
	.global irq_enable_e2
irq_enable_e2:
L_8c03a4:
	lr r0,[0xa]
L_8c03a8:
	or r0,r0,0x4
L_8c03ac:
	j.d [blink]
L_8c03b0:
	flag r0
