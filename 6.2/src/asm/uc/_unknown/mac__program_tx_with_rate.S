/* mac__program_tx_with_rate @ 0x92d8e8, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_rx__send_response, cf_end__send_frame, direct_tx__send_from_desc, internal_tx__flow_sm2, internal_tx__flow_sm6, itx__tx_frame_3ies, tx__send_imm_response, tx__write_header_16, tx_bcast_flow, txop_initiator_open_txop_flow
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__program_tx_with_rate
mac__program_tx_with_rate:
	.global L_92d8e8
L_92d8e8:
	st.a r13,[sp,-0x8]
L_92d8ec:
	st_s r14,[sp,0x4]
L_92d8ee:
	mov_s r14,blink
L_92d8f0:
	asl_s r0,r0,0x8
L_92d8f2:
	or r13,r0,0x3
L_92d8f6:
	mov_s r2,0x1b001111
L_92d8fc:
	mov r32,r2
L_92d900:
	st.ab r2,[r25,0x4]
L_92d904:
	bclr r25,r25,0xa
L_92d908:
	mov_s r1,0x161f0040
L_92d90e:
	mov_s r32,r1
L_92d910:
	st.ab r1,[r25,0x4]
L_92d914:
	bclr r25,r25,0xa
L_92d918:
	or r13,r13,0x17000000
L_92d920:
	mov r32,r13
L_92d924:
	st.ab r13,[r25,0x4]
L_92d928:
	bclr r25,r25,0xa
L_92d92c:
	nop_s
L_92d92e:
	nop_s
L_92d930:
	nop_s
L_92d932:
	mov_s blink,r14
L_92d934:
	ld_s r14,[sp,0x4]
L_92d936:
	j_s.d [blink]
L_92d938:
	ld.ab r13,[sp,0x8]
