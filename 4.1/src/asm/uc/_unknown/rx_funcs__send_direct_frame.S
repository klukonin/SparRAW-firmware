/* rx_funcs__send_direct_frame @ 0x9358ac, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_funcs_step
 * Зовёт сам: __ld_r13_ret_uc, direct_tx__issue_cmd_33, direct_tx__push_payload, uc_wait_direct_tx_ready
 */
	.section .text.rx_funcs__send_direct_frame,"ax",@progbits
	.global rx_funcs__send_direct_frame
rx_funcs__send_direct_frame:
	.global L_9358ac
L_9358ac:
	push_s blink
L_9358ae:
	push_s r13
L_9358b0:
	mov_s r13,r0
L_9358b2:
	bl.d L_924ef4
L_9358b6:
	mov_s r1,0xa
L_9358b8:
	ld_s r0,[gp,-0x18]
L_9358ba:
	/* sub_s r0,r0,0x6 */
	.byte 0x66,0xb8
L_9358bc:
	st.as r0,[gp,-0x6]
L_9358c0:
	mov_s r0,0x33000443
L_9358c6:
	mov_s r32,r0
L_9358c8:
	st.ab r0,[r25,0x4]
L_9358cc:
	bclr r25,r25,0xa
L_9358d0:
	bl L_924f7c
L_9358d4:
	ldb r34,[r13, 0x10]
L_9358d8:
	ldb r34,[r13, 0x11]
L_9358dc:
	ldb r34,[r13, 0x12]
L_9358e0:
	ld_s r0,[gp,-0x18]
L_9358e2:
	/* sub_s r0,r0,0x3 */
	.byte 0x63,0xb8
L_9358e4:
	st.as r0,[gp,-0x6]
L_9358e8:
	ldb r33,[r13, 0x13]
L_9358ec:
	ldb_s r1,[r13,0x14]
L_9358ee:
	asl_s r1,r1,0x8
L_9358f0:
	or r33,r33,r1
L_9358f4:
	ldb_s r1,[r13,0x15]
L_9358f6:
	asl_s r1,r1,0x10
L_9358f8:
	or r33,r33,r1
L_9358fc:
	ldb_s r1,[r13,0x16]
L_9358fe:
	asl_s r1,r1,0x18
L_935900:
	or r33,r33,r1
L_935904:
	ld_s r0,[gp,-0x18]
L_935906:
	/* sub_s r0,r0,0x4 */
	.byte 0x64,0xb8
L_935908:
	st.as r0,[gp,-0x6]
L_93590c:
	ldb r34,[r13, 0x17]
L_935910:
	ld_s r0,[gp,-0x18]
L_935912:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_935914:
	bl.d L_924e6c
L_935918:
	st.as r0,[gp,-0x6]
L_93591c:
	b L_92028c
