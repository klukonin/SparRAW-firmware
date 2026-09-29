/* mac__program_tx_with_qid @ 0x92a36c, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_counter__program_0008, mtp_queue__release_mgmt, tx_rate_select_and_program, txop_initiator_open_txop_flow, ucode_cmd__bi_config, ucode_cmd__queue_delete
 */
	.section .text.mac__program_tx_with_qid,"ax",@progbits
	.global mac__program_tx_with_qid
mac__program_tx_with_qid:
	.global L_92a36c
L_92a36c:
	st.a r13,[sp,-0x8]
L_92a370:
	st_s r14,[sp,0x4]
L_92a372:
	mov_s r14,blink
L_92a374:
	asl_s r0,r0,0x10
L_92a376:
	bset r13,r0,0x0
L_92a37a:
	mov_s r2,0x1b001111
L_92a380:
	mov r32,r2
L_92a384:
	st.ab r2,[r25,0x4]
L_92a388:
	bclr r25,r25,0xa
L_92a38c:
	or r13,r13,0x16000000
L_92a394:
	mov r32,r13
L_92a398:
	st.ab r13,[r25,0x4]
L_92a39c:
	bclr r25,r25,0xa
L_92a3a0:
	mov_s r1,0x17000003
L_92a3a6:
	mov_s r32,r1
L_92a3a8:
	st.ab r1,[r25,0x4]
L_92a3ac:
	bclr r25,r25,0xa
L_92a3b0:
	nop_s
L_92a3b2:
	nop_s
L_92a3b4:
	nop_s
L_92a3b6:
	mov_s blink,r14
L_92a3b8:
	ld_s r14,[sp,0x4]
L_92a3ba:
	j_s.d [blink]
L_92a3bc:
	ld.ab r13,[sp,0x8]
