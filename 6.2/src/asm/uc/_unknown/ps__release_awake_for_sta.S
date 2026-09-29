/* ps__release_awake_for_sta @ 0x93d980, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x0f_handler
 * Зовёт сам: internal_tx__clear_pending_bit, uc_res_vote__release
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ps__release_awake_for_sta
ps__release_awake_for_sta:
	.global L_93d980
L_93d980:
	st.a r13,[sp,-0x8]
L_93d984:
	st_s r14,[sp,0x4]
L_93d986:
	mov_s r14,blink
L_93d988:
	mov r13,r0
L_93d98c:
	bl.d L_92bd70
L_93d990:
	mov r0,0x6
L_93d994:
	bl.d L_92bb94
L_93d998:
	mov r0,0x6
L_93d99c:
	mov_s r2,0x0
L_93d99e:
	add r13,r13,0x174
L_93d9a2:
	stb_s r2,[r13]
L_93d9a4:
	ldb r0,[0x802194]
L_93d9ac:
	breq_s r0,0,L_93d9c4
L_93d9ae:
	norm r0,r0
L_93d9b2:
	rsub r1,r0,0x1e
L_93d9b6:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_93d9b8:
	add2_s r1,r1,r1
L_93d9ba:
	add_s r1,r1,0x857e38
L_93d9c0:
	stb_s r2,[r1,0x12]
L_93d9c2:
	stb_s r2,[r1,0x13]
	.global L_93d9c4
L_93d9c4:
	mov_s blink,r14
L_93d9c6:
	ld_s r14,[sp,0x4]
L_93d9c8:
	j.d [blink]
L_93d9cc:
	ld.ab r13,[sp,0x8]
