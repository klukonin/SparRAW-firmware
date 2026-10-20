/* bi_manager_step_b @ 0x922258, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi__run_bti_cycle
 * Зовёт сам: gp_timer__stop, memset0_words_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi_manager_step_b
bi_manager_step_b:
	.global L_922258
L_922258:
	push_s r13
L_92225a:
	mov_s r13,blink
L_92225c:
	mov r0,0x802f32
L_922264:
	bl.d L_920a84
L_922268:
	mov r1,0x2
L_92226c:
	bl.d L_925998
L_922270:
	mov r0,0x0
L_922274:
	bl.d L_925998
L_922278:
	mov r0,0x1
L_92227c:
	bl.d L_925998
L_922280:
	mov r0,0x2
L_922284:
	mov_s r0,0x54
L_922286:
	asl_s r0,r0,0x18
L_922288:
	mov r32,r0
L_92228c:
	st.ab r0,[r25,0x4]
L_922290:
	bclr r25,r25,0xa
L_922294:
	mov_s r1,0x54
L_922296:
	asl_s r1,r1,0x18
L_922298:
	mov r32,r1
L_92229c:
	st.ab r1,[r25,0x4]
L_9222a0:
	bclr r25,r25,0xa
L_9222a4:
	mov_s r2,0x49000100
L_9222aa:
	mov_s r32,r2
L_9222ac:
	st.ab r2,[r25,0x4]
L_9222b0:
	bclr r25,r25,0xa
L_9222b4:
	mov_s r3,0x51000284
L_9222ba:
	mov_s r32,r3
L_9222bc:
	st.ab r3,[r25,0x4]
L_9222c0:
	bclr r25,r25,0xa
L_9222c4:
	mov r4,0x54000508
L_9222cc:
	mov r32,r4
L_9222d0:
	st.ab r4,[r25,0x4]
L_9222d4:
	bclr r25,r25,0xa
L_9222d8:
	mov_s blink,r13
L_9222da:
	j_s.d [blink]
L_9222dc:
	pop_s r13
L_9222de:
	nop_s
