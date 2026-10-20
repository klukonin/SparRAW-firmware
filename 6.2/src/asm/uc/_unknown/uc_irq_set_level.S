/* uc_irq_set_level @ 0x921018, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_mode_init_substep, irq__init_event_masks, uc_timer__start
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_irq_set_level
uc_irq_set_level:
	.global L_921018
L_921018:
	lr r3,[0x200]
L_92101c:
	bclr r2,r3,r0
L_921020:
	asl_s r1,r1,r0
L_921022:
	or_s r1,r1,r2
L_921024:
	sr r1,[0x200]
L_921028:
	j_s [blink]
L_92102a:
	nop_s
