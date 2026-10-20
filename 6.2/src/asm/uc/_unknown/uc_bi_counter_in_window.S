/* uc_bi_counter_in_window @ 0x937474, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti__bi2_event_step
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_bi_counter_in_window
uc_bi_counter_in_window:
	.global L_937474
L_937474:
	push_s r13
L_937476:
	ld.as r2,[gp,-0x11]
L_93747a:
	mov_s r13,blink
L_93747c:
	and r2,r2,0xffff0fff
L_937484:
	bset r0,r2,0xe
L_937488:
	st.as r0,[gp,-0x11]
L_93748c:
	or r2,r2,0x1d004000
L_937494:
	mov r32,r2
L_937498:
	st.ab r2,[r25,0x4]
L_93749c:
	bclr r25,r25,0xa
L_9374a0:
	nop_s
L_9374a2:
	nop_s
L_9374a4:
	nop_s
L_9374a6:
	bmsk r1,r40,0x19
L_9374aa:
	ld r3,[0x8022a4]
L_9374b2:
	st.as r1,[gp,-0x14]
L_9374b6:
	sub_s r3,r3,0x19
L_9374b8:
	brlo.d r3,r1,L_9374c8
L_9374bc:
	mov r0,0x0
L_9374c0:
	brhs r1,0x9c4,L_9374cc
	.global L_9374c8
L_9374c8:
	mov r0,0x1
	.global L_9374cc
L_9374cc:
	extb_s r0,r0
L_9374ce:
	mov_s blink,r13
L_9374d0:
	j.d [blink]
L_9374d4:
	pop_s r13
L_9374d6:
	nop_s
