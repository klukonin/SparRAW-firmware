/* rx_funcs__send_direct_frame @ 0x93b2b8, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sls__send_ssw_ack
 * Зовёт сам: __ld_r13_to_r13_ret, direct_tx__issue_cmd_33, tx_fifo__write_bytes, uc_wait_direct_tx_ready
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx_funcs__send_direct_frame
rx_funcs__send_direct_frame:
	.global L_93b2b8
L_93b2b8:
	push_s blink
L_93b2ba:
	push_s r13
L_93b2bc:
	mov_s r13,r0
L_93b2be:
	bl.d L_9257f4
L_93b2c2:
	mov_s r1,0xa
L_93b2c4:
	ld_s r0,[gp,-0x14]
L_93b2c6:
	/* sub_s r0,r0,0x6 */
	.byte 0x66,0xb8
L_93b2c8:
	st.as r0,[gp,-0x5]
L_93b2cc:
	mov_s r0,0x33000443
L_93b2d2:
	mov_s r32,r0
L_93b2d4:
	st.ab r0,[r25,0x4]
L_93b2d8:
	bclr r25,r25,0xa
L_93b2dc:
	bl L_925874
L_93b2e0:
	ldb r34,[r13, 0x10]
L_93b2e4:
	ldb r34,[r13, 0x11]
L_93b2e8:
	ldb r34,[r13, 0x12]
L_93b2ec:
	ld_s r0,[gp,-0x14]
L_93b2ee:
	/* sub_s r0,r0,0x3 */
	.byte 0x63,0xb8
L_93b2f0:
	st.as r0,[gp,-0x5]
L_93b2f4:
	ldb r33,[r13, 0x13]
L_93b2f8:
	ldb_s r1,[r13,0x14]
L_93b2fa:
	asl_s r1,r1,0x8
L_93b2fc:
	or r33,r33,r1
L_93b300:
	ldb_s r1,[r13,0x15]
L_93b302:
	asl_s r1,r1,0x10
L_93b304:
	or r33,r33,r1
L_93b308:
	ldb_s r1,[r13,0x16]
L_93b30a:
	asl_s r1,r1,0x18
L_93b30c:
	or r33,r33,r1
L_93b310:
	ld_s r0,[gp,-0x14]
L_93b312:
	/* sub_s r0,r0,0x4 */
	.byte 0x64,0xb8
L_93b314:
	st.as r0,[gp,-0x5]
L_93b318:
	ldb r34,[r13, 0x17]
L_93b31c:
	ld_s r0,[gp,-0x14]
L_93b31e:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_93b320:
	bl.d L_925774
L_93b324:
	st.as r0,[gp,-0x5]
L_93b328:
	b L_9202ac
