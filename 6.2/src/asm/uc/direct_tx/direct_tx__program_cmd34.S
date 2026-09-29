/* direct_tx__program_cmd34 @ 0x9257a8, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft__send_ssw_feedback, bi_rx__send_response, brp_init__tx_request, brp_responder_transmission_flow, cf_end__send_frame, direct_tx__send_from_desc, direct_tx__send_short_frame, direct_tx_step, internal_tx__flow_sm2, internal_tx__flow_sm6
 * Глобалы (через gp): 0x8005ba
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global direct_tx__program_cmd34
direct_tx__program_cmd34:
	.global L_9257a8
L_9257a8:
	st.a r13,[sp,-0xc]
L_9257ac:
	st blink,[sp, 0x4]
L_9257b0:
	st_s r14,[sp,0x8]
L_9257b2:
	mov_s r13,r0
L_9257b4:
	mov_s r14,r1
L_9257b6:
	mov_s r1,0x33000001
L_9257bc:
	mov r32,r1
L_9257c0:
	st.ab r1,[r25,0x4]
L_9257c4:
	bclr r25,r25,0xa
L_9257c8:
	st.as r14,[gp,-0x5]
L_9257cc:
	stw.as r13,[gp,0x49]
L_9257d0:
	or r14,r14,0x34000000
L_9257d8:
	asl r0,r13,0x10
L_9257dc:
	or_s r0,r0,r14
L_9257de:
	mov_s r32,r0
L_9257e0:
	st.ab r0,[r25,0x4]
L_9257e4:
	bclr r25,r25,0xa
L_9257e8:
	ld blink,[sp, 0x4]
L_9257ec:
	ld_s r14,[sp,0x8]
L_9257ee:
	j_s.d [blink]
L_9257f0:
	ld.ab r13,[sp,0xc]
