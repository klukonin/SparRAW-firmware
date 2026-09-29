/* uc_irq_set_level @ 0x9219b4, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_mode__unmask_all_events, bi_mode_init_substep, uc_timer__start
 */
	.section .text.uc_irq_set_level,"ax",@progbits
	.global uc_irq_set_level
uc_irq_set_level:
	.global L_9219b4
L_9219b4:
	lr r3,[0x200]
L_9219b8:
	bclr r2,r3,r0
L_9219bc:
	asl_s r1,r1,r0
L_9219be:
	or_s r1,r1,r2
L_9219c0:
	sr r1,[0x200]
L_9219c4:
	j_s [blink]
L_9219c6:
	nop_s
