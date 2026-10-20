/* gp_timer__stop @ 0x925998, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_manager_step_a, bi_manager_step_b, brp_init__flow, brp_responder_flow_enter, l1_task__reset_units, txss_init__wait_rss
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global gp_timer__stop
gp_timer__stop:
	.global L_925998
L_925998:
	st.a r13,[sp,-0x8]
L_92599c:
	st_s r14,[sp,0x4]
L_92599e:
	mov_s r14,blink
L_9259a0:
	mov_s r13,r0
L_9259a2:
	add_s r0,r0,0x52
L_9259a4:
	asl_s r0,r0,0x18
L_9259a6:
	mov_s r32,r0
L_9259a8:
	st.ab r0,[r25,0x4]
L_9259ac:
	bclr r25,r25,0xa
L_9259b0:
	/* add_s r13,0x6 */
	.byte 0x06,0xe5
L_9259b2:
	mov_s r1,0x49
L_9259b4:
	asl_s r1,r1,0x18
L_9259b6:
	bset r1,r1,r13
L_9259ba:
	mov_s r32,r1
L_9259bc:
	st.ab r1,[r25,0x4]
L_9259c0:
	bclr r25,r25,0xa
L_9259c4:
	mov_s blink,r14
L_9259c6:
	ld_s r14,[sp,0x4]
L_9259c8:
	j.d [blink]
L_9259cc:
	ld.ab r13,[sp,0x8]
