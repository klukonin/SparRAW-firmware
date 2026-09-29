/* irq_set_level @ 0x8c3bd8, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_main, timer__start
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global irq_set_level
irq_set_level:
	.global L_8c3bd8
L_8c3bd8:
	lr r2,[0x200]
L_8c3bdc:
	bclr r2,r2,r0
L_8c3be0:
	asl_s r1,r1,r0
L_8c3be2:
	or_s r1,r1,r2
L_8c3be4:
	sr r1,[0x200]
L_8c3be8:
	j_s [blink]
L_8c3bea:
	nop_s
