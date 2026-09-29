/* mac__program_tx_with_qid @ 0x92d93c, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_q__tx_ppdu, macq__kick_queue_tx, tx_bcast_flow, txop_initiator_open_txop_flow, ucode_cmd_0x08_handler, ucode_cmd_0x0b_handler, vring__disconnect_flush
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__program_tx_with_qid
mac__program_tx_with_qid:
	.global L_92d93c
L_92d93c:
	st.a r13,[sp,-0x8]
L_92d940:
	st_s r14,[sp,0x4]
L_92d942:
	mov_s r14,blink
L_92d944:
	asl_s r0,r0,0x10
L_92d946:
	bset r13,r0,0x0
L_92d94a:
	mov_s r2,0x1b001111
L_92d950:
	mov r32,r2
L_92d954:
	st.ab r2,[r25,0x4]
L_92d958:
	bclr r25,r25,0xa
L_92d95c:
	or r13,r13,0x16000000
L_92d964:
	mov r32,r13
L_92d968:
	st.ab r13,[r25,0x4]
L_92d96c:
	bclr r25,r25,0xa
L_92d970:
	mov_s r1,0x17000003
L_92d976:
	mov_s r32,r1
L_92d978:
	st.ab r1,[r25,0x4]
L_92d97c:
	bclr r25,r25,0xa
L_92d980:
	nop_s
L_92d982:
	nop_s
L_92d984:
	nop_s
L_92d986:
	mov_s blink,r14
L_92d988:
	ld_s r14,[sp,0x4]
L_92d98a:
	j_s.d [blink]
L_92d98c:
	ld.ab r13,[sp,0x8]
