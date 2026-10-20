/* gp_timer__arm @ 0x93512c, 184 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp_responder_flow_enter, txss_init__send_fdbk_wait_ack, txss_init__wait_rss, txss_resp__wait_iss_end
 * Зовёт сам: uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global gp_timer__arm
gp_timer__arm:
	.global L_93512c
L_93512c:
	st.a r13,[sp,-0x10]
L_935130:
	st blink,[sp, 0x4]
L_935134:
	st_s r14,[sp,0x8]
L_935136:
	st_s r15,[sp,0xc]
L_935138:
	mov r14,r0
L_93513c:
	and.f 0x0,r1,0xff000000
L_935144:
	bne.d L_9351d4
L_935148:
	mov r15,r1
	.global L_93514c
L_93514c:
	add1 r3,r14,0x29
L_935150:
	asl_s r3,r3,0x18
L_935152:
	mov_s r32,r3
L_935154:
	st.ab r3,[r25,0x4]
L_935158:
	bclr r25,r25,0xa
L_93515c:
	add r6,r14,0x6
L_935160:
	mov r7,0x49000000
L_935168:
	bset r2,r7,r6
L_93516c:
	mov r32,r2
L_935170:
	st.ab r2,[r25,0x4]
L_935174:
	bclr r25,r25,0xa
L_935178:
	add r4,r14,0x6
L_93517c:
	mov r5,0x49000000
L_935184:
	bset r1,r5,r4
L_935188:
	mov r32,r1
L_93518c:
	st.ab r1,[r25,0x4]
L_935190:
	bclr r25,r25,0xa
L_935194:
	add r13,r14,0x4f
L_93519c:
	asl_s r13,r13,0x18
L_93519e:
	or_s r13,r13,r15
L_9351a0:
	mov r32,r13
L_9351a4:
	st.ab r13,[r25,0x4]
L_9351a8:
	bclr r25,r25,0xa
L_9351ac:
	nop_s
L_9351ae:
	nop_s
L_9351b0:
	nop_s
L_9351b2:
	add_s r14,r14,0x52
L_9351b4:
	asl_s r14,r14,0x18
L_9351b6:
	or r0,r14,0xb
L_9351ba:
	mov_s r32,r0
L_9351bc:
	st.ab r0,[r25,0x4]
L_9351c0:
	bclr r25,r25,0xa
L_9351c4:
	ld blink,[sp, 0x4]
L_9351c8:
	ld_s r14,[sp,0x8]
L_9351ca:
	ld_s r15,[sp,0xc]
L_9351cc:
	j.d [blink]
L_9351d0:
	ld.ab r13,[sp,0x10]
	.global L_9351d4
L_9351d4:
	mov r0,blink
L_9351d8:
	bl.d L_926618
L_9351dc:
	mov r1,0x51
L_9351e0:
	b_s L_93514c
L_9351e2:
	nop_s
