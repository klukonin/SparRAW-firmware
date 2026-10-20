/* irq_disable_e1 @ 0x8c043c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.irq_disable_e1,"ax",@progbits
	.global irq_disable_e1
irq_disable_e1:
L_8c043c:
	lr r0,[0xa]
L_8c0440:
	bic r0,r0,0x2
L_8c0444:
	j.d [blink]
L_8c0448:
	flag r0
