/* direct_tx__send_short_frame @ 0x93b32c, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft__send_ssw_feedback
 * Зовёт сам: __ld_r13_to_r13_ret, direct_tx__issue_cmd_33, direct_tx__program_cmd34, tx_fifo__write_bytes, uc_wait_direct_tx_ready
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global direct_tx__send_short_frame
direct_tx__send_short_frame:
	.global L_93b32c
L_93b32c:
	push_s blink
L_93b32e:
	push_s r13
L_93b330:
	mov_s r13,r0
L_93b332:
	mov_s r0,0x10
L_93b334:
	bl.d L_9257a8
L_93b338:
	mov_s r1,0x16
L_93b33a:
	mov_s r0,0x802b4c
L_93b340:
	bl.d L_9257f4
L_93b344:
	mov_s r1,0x4
L_93b346:
	ld_s r0,[gp,-0x14]
L_93b348:
	sub_s r0,r0,0xf
L_93b34a:
	st.as r0,[gp,-0x5]
L_93b34e:
	asl r0,r13,0x8
L_93b352:
	asl_s r13,r13,0xa
L_93b354:
	or r0,r0,0x330000e3
L_93b35c:
	or_s r13,r13,r0
L_93b35e:
	mov_s r32,r13
L_93b360:
	st.ab r13,[r25,0x4]
L_93b364:
	bclr r25,r25,0xa
L_93b368:
	bl L_925874
L_93b36c:
	mov_s r0,0x802b4c
L_93b372:
	ldb r34,[r0, 0x13]
L_93b376:
	mov_s r0,0x802b4c
L_93b37c:
	ldb r34,[r0, 0x14]
L_93b380:
	mov_s r0,0x802b4c
L_93b386:
	ldb r34,[r0, 0x15]
L_93b38a:
	ld_s r0,[gp,-0x14]
L_93b38c:
	/* sub_s r0,r0,0x3 */
	.byte 0x63,0xb8
L_93b38e:
	bl.d L_925774
L_93b392:
	st.as r0,[gp,-0x5]
L_93b396:
	b L_9202ac
L_93b39a:
	nop_s
