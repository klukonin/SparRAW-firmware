/* uc_wait_event1_or_event4 @ 0x9367e4, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_responder__respond_flow, brp_init__exchange_request, brp_initiator_brp_transaction_flow, brp_responder_flow_enter, bti_bi2__track_best_metric, itx__wait_ack, itx__wait_ack_rf, itx__wait_cts, itx__wait_cts_b, itx__wait_cts_rf
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_wait_event1_or_event4
uc_wait_event1_or_event4:
	.global L_9367e4
L_9367e4:
	st.a r13,[sp,-0xc]
L_9367e8:
	st blink,[sp, 0x4]
L_9367ec:
	st_s r14,[sp,0x8]
L_9367ee:
	tst r42,r0
L_9367f2:
	mov_s r14,r0
L_9367f4:
	bne.d L_936858
L_9367f8:
	mov_s r13,r1
L_9367fa:
	tst r54,r13
L_9367fe:
	bne_s L_936858
L_936800:
	cmp r2,0x0
L_936804:
	beq.d L_936838
L_936808:
	mov.eq r4,r14
L_93680c:
	or r2,r2,0x23010000
L_936814:
	mov r32,r2
L_936818:
	st.ab r2,[r25,0x4]
L_93681c:
	bclr r25,r25,0xa
L_936820:
	mov r7,0x2000200
L_936828:
	mov r32,r7
L_93682c:
	st.ab r7,[r25,0x4]
L_936830:
	bclr r25,r25,0xa
L_936834:
	bset r4,r14,0x9
	.global L_936838
L_936838:
	nop_s
L_93683a:
	nop_s
L_93683c:
	mov 0x0,0x0
	.global L_936840
L_936840:
	tst r42,r4
L_936844:
	bne_s L_93684c
L_936846:
	tst r54,r13
L_93684a:
	beq_s L_936840
	.global L_93684c
L_93684c:
	tst r42,r14
L_936850:
	bne_s L_936858
L_936852:
	tst r54,r13
L_936856:
	beq_s L_936860
	.global L_936858
L_936858:
	b.d L_936864
L_93685c:
	mov r0,0x1
	.global L_936860
L_936860:
	mov r0,0x0
	.global L_936864
L_936864:
	ld blink,[sp, 0x4]
L_936868:
	ld_s r14,[sp,0x8]
L_93686a:
	j_s.d [blink]
L_93686c:
	ld.ab r13,[sp,0xc]
