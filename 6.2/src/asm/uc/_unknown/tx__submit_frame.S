/* tx__submit_frame @ 0x9396a0, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx__flow_sm2, internal_tx__flow_sm6, tx__send_and_await_rx_frame
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, mac__program_tx_result_ctx_uc
 * Глобалы (через gp): 0x800608, 0x80060c
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global tx__submit_frame
tx__submit_frame:
	.global L_9396a0
L_9396a0:
	push_s blink
L_9396a2:
	bl L_920230
L_9396a6:
	mov_s r13,r0
L_9396a8:
	mov_s r14,r2
L_9396aa:
	mov_s r15,r3
L_9396ac:
	bl.d L_92db20
L_9396b0:
	ld_s r0,[r0,0x4]
	.global L_9396b2
L_9396b2:
	mov_s r0,r43
L_9396b4:
	bbit0 r0,0x1f,L_9396b2
L_9396b8:
	mov_s r0,r51
L_9396ba:
	bmsk r1,r0,0x3
L_9396be:
	st.as r1,[gp,0x38]
L_9396c2:
	lsr_s r0,r0,0x4
L_9396c4:
	st.as r0,[gp,0x39]
	.global L_9396c8
L_9396c8:
	mov_s r0,r45
L_9396ca:
	bbit0 r0,0x1f,L_9396c8
L_9396ce:
	brne r14,0x1,L_9396e2
L_9396d2:
	bset_s r15,r15,0xf
L_9396d4:
	bset_s r15,r15,0x1b
L_9396d6:
	bset_s r15,r15,0x1c
L_9396d8:
	mov_s r32,r15
L_9396da:
	st.ab r15,[r25,0x4]
L_9396de:
	bclr r25,r25,0xa
	.global L_9396e2
L_9396e2:
	ld_s r1,[r13,0x18]
L_9396e4:
	extb r0,r45
L_9396e8:
	and_s r0,r0,r1
L_9396ea:
	cmp_s r0,0x0
L_9396ec:
	mov_s r0,0x1
L_9396ee:
	b.d L_92029c
L_9396f2:
	sub_s.ne r0,r0,r0
