/* mac__program_tx_with_rate @ 0x92a318, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_rx__send_response, cf_end__send_frame, direct_tx_rx__program, internal_tx_step, tx_rate_select_and_program, txop_initiator_open_txop_flow
 */
	.section .text.mac__program_tx_with_rate,"ax",@progbits
	.global mac__program_tx_with_rate
mac__program_tx_with_rate:
	.global L_92a318
L_92a318:
	st.a r13,[sp,-0x8]
L_92a31c:
	st_s r14,[sp,0x4]
L_92a31e:
	mov_s r14,blink
L_92a320:
	asl_s r0,r0,0x8
L_92a322:
	or r13,r0,0x3
L_92a326:
	mov_s r2,0x1b001111
L_92a32c:
	mov r32,r2
L_92a330:
	st.ab r2,[r25,0x4]
L_92a334:
	bclr r25,r25,0xa
L_92a338:
	mov_s r1,0x161f0040
L_92a33e:
	mov_s r32,r1
L_92a340:
	st.ab r1,[r25,0x4]
L_92a344:
	bclr r25,r25,0xa
L_92a348:
	or r13,r13,0x17000000
L_92a350:
	mov r32,r13
L_92a354:
	st.ab r13,[r25,0x4]
L_92a358:
	bclr r25,r25,0xa
L_92a35c:
	nop_s
L_92a35e:
	nop_s
L_92a360:
	nop_s
L_92a362:
	mov_s blink,r14
L_92a364:
	ld_s r14,[sp,0x4]
L_92a366:
	j_s.d [blink]
L_92a368:
	ld.ab r13,[sp,0x8]
