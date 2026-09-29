/* uc_irq_enable @ 0x9202d4, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_main_init
 */
	.section .text.uc_irq_enable,"ax",@progbits
	.global uc_irq_enable
uc_irq_enable:
	.global L_9202d4
L_9202d4:
	lr r0,[0xa]
L_9202d8:
	or r0,r0,0x6
L_9202dc:
	j.d [blink]
L_9202e0:
	flag r0
