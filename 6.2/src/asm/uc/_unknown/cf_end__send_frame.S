/* cf_end__send_frame @ 0x938568, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx__send_and_await_rx_frame
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, direct_tx__program_cmd34, direct_tx__send_after_delay, mac__program_tx_with_rate
 * Глобалы (через gp): 0x800608, 0x80060c
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global cf_end__send_frame
cf_end__send_frame:
	.global L_938568
L_938568:
	push_s blink
L_93856a:
	bl L_92022c
L_93856e:
	mov_s r13,r0
L_938570:
	mov_s r14,r1
L_938572:
	push_s r2
L_938574:
	mov_s r15,r3
L_938576:
	mov r16,r4
L_93857a:
	mov_s r0,0x10
L_93857c:
	bl.d L_9257a8
L_938580:
	mov_s r1,r0
L_938582:
	bl.d L_92d8e8
L_938586:
	mov_s r0,r14
L_938588:
	st r14,[r16]
	.global L_93858c
L_93858c:
	mov_s r0,r43
L_93858e:
	bbit0 r0,0x1f,L_93858c
L_938592:
	mov_s r0,r51
L_938594:
	bmsk r1,r0,0x3
L_938598:
	st.as r1,[gp,0x38]
L_93859c:
	lsr_s r0,r0,0x4
L_93859e:
	st.as r0,[gp,0x39]
	.global L_9385a2
L_9385a2:
	mov_s r0,r45
L_9385a4:
	bbit0 r0,0x1f,L_9385a2
L_9385a8:
	breq_s r15,0,L_9385b8
L_9385aa:
	mov_s r0,0x18
L_9385ac:
	asl_s r0,r0,0x18
L_9385ae:
	mov_s r32,r0
L_9385b0:
	st.ab r0,[r25,0x4]
L_9385b4:
	bclr r25,r25,0xa
	.global L_9385b8
L_9385b8:
	ld_s r0,[r13]
L_9385ba:
	ld_s r1,[sp,0x0]
L_9385bc:
	bl.d L_938218
L_9385c0:
	mov_s r2,0x0
L_9385c2:
	ld_s r1,[r13,0x18]
L_9385c4:
	extb r0,r45
L_9385c8:
	and_s r0,r0,r1
L_9385ca:
	cmp_s r0,0x0
L_9385cc:
	mov_s r0,0x1
L_9385ce:
	sub_s.ne r0,r0,r0
L_9385d0:
	b.d L_920294
L_9385d4:
	add_s sp,sp,0x4
L_9385d6:
	nop_s
