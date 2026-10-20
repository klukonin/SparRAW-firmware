/* irq_disable_e2 @ 0x8c044c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.irq_disable_e2,"ax",@progbits
	.global irq_disable_e2
irq_disable_e2:
L_8c044c:
	lr r0,[0xa]
L_8c0450:
	bic r0,r0,0x4
L_8c0454:
	j.d [blink]
L_8c0458:
	flag r0
