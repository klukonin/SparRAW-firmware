/* uc_irq_enable_l1 @ 0x9202e4, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.uc_irq_enable_l1,"ax",@progbits
	.global uc_irq_enable_l1
uc_irq_enable_l1:
L_9202e4:
	lr r0,[0xa]
L_9202e8:
	or r0,r0,0x2
L_9202ec:
	j.d [blink]
L_9202f0:
	flag r0
