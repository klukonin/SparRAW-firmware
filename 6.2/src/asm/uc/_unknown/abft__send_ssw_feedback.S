/* abft__send_ssw_feedback @ 0x93b39c, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_responder__tx_ssw
 * Зовёт сам: direct_tx__issue_cmd_33, direct_tx__program_cmd34, direct_tx__send_short_frame, tx_fifo__write_bytes, uc_wait_direct_tx_ready
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global abft__send_ssw_feedback
abft__send_ssw_feedback:
	.global L_93b39c
L_93b39c:
	push_s blink
L_93b39e:
	mov_s r0,0x10
L_93b3a0:
	bl.d L_9257a8
L_93b3a4:
	mov_s r1,0x16
L_93b3a6:
	mov_s r0,0x802b4c
L_93b3ac:
	bl.d L_9257f4
L_93b3b0:
	mov_s r1,0xa
L_93b3b2:
	ld_s r0,[gp,-0x14]
L_93b3b4:
	sub_s r0,r0,0x9
L_93b3b6:
	st.as r0,[gp,-0x5]
L_93b3ba:
	mov_s r0,0x330004c3
L_93b3c0:
	mov_s r32,r0
L_93b3c2:
	st.ab r0,[r25,0x4]
L_93b3c6:
	bclr r25,r25,0xa
L_93b3ca:
	bl L_925874
L_93b3ce:
	mov_s r0,0x802b4c
L_93b3d4:
	ldb r34,[r0, 0x13]
L_93b3d8:
	mov_s r0,0x802b4c
L_93b3de:
	ldb r34,[r0, 0x14]
L_93b3e2:
	mov_s r0,0x802b4c
L_93b3e8:
	ldb r34,[r0, 0x15]
L_93b3ec:
	ld_s r0,[gp,-0x14]
L_93b3ee:
	/* sub_s r0,r0,0x3 */
	.byte 0x63,0xb8
L_93b3f0:
	bl.d L_925774
L_93b3f4:
	st.as r0,[gp,-0x5]
L_93b3f8:
	pop_s blink
L_93b3fa:
	j_s [blink]
L_93b3fc:
	b.d L_93b32c
L_93b400:
	mov_s r0,0x0
L_93b402:
	nop_s
L_93b404:
	b.d L_93b32c
L_93b408:
	mov_s r0,0x2
L_93b40a:
	nop_s
