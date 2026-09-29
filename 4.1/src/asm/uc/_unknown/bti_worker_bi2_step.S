/* bti_worker_bi2_step @ 0x923ba8, 204 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti__bi2_event_step, bti_worker__collect_bf_metric
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, uc_wait_event_busy
 * Глобалы (через gp): 0x80057c
 */
	.section .text.bti_worker_bi2_step,"ax",@progbits
	.global bti_worker_bi2_step
bti_worker_bi2_step:
	.global L_923ba8
L_923ba8:
	push_s blink
L_923baa:
	bl L_920214
L_923bae:
	mov_s r14,r0
L_923bb0:
	mov_s r13,r1
L_923bb2:
	mov_s r0,0x0
L_923bb4:
	bset_s r0,r0,0x10
L_923bb6:
	bl.d L_931808
L_923bba:
	mov_s r1,0x0
L_923bbc:
	ldb_s r0,[gp,-0xf3]
L_923bbe:
	brne_s r0,0,L_923bdc
L_923bc0:
	ldb_s r0,[gp,-0xf9]
L_923bc2:
	bmsk_s r0,r0,0x0
L_923bc4:
	bset_s r0,r0,0x19
L_923bc6:
	bset_s r0,r0,0x1c
L_923bc8:
	bset_s r0,r0,0x1d
L_923bca:
	mov_s r32,r0
L_923bcc:
	st.ab r0,[r25,0x4]
L_923bd0:
	bclr r25,r25,0xa
L_923bd4:
	ldb_s r0,[gp,-0xf9]
L_923bd6:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_923bd8:
	stb r0,[gp, -0xf9]
	.global L_923bdc
L_923bdc:
	ld_s r0,[gp,0x54]
L_923bde:
	mov_s r1,0x801458
L_923be4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_923be6:
	st.as r0,[gp,0x15]
L_923bea:
	ld_s r0,[r1,0x38]
L_923bec:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_923bee:
	st_s r0,[r1,0x38]
L_923bf0:
	mov_s r0,0x2011000
L_923bf6:
	mov_s r32,r0
L_923bf8:
	st.ab r0,[r25,0x4]
L_923bfc:
	bclr r25,r25,0xa
L_923c00:
	mov_s r2,0x804010
L_923c06:
	brne_s r14,0,L_923c10
L_923c08:
	breq_s r13,0,L_923c10
L_923c0a:
	bmsk r0,r38,0x0
L_923c0e:
	b_s L_923c4c
	.global L_923c10
L_923c10:
	mov_s r3,0x801e68
L_923c16:
	ldb_s r13,[r3,0x10]
L_923c18:
	ldb_s r1,[r2,0x4]
L_923c1a:
	mov_s r0,0x0
L_923c1c:
	brne r13,r1,L_923c4a
L_923c20:
	ldb_s r13,[r3,0x11]
L_923c22:
	ldb_s r1,[r2,0x5]
L_923c24:
	brne r13,r1,L_923c4a
L_923c28:
	ldb_s r13,[r3,0x12]
L_923c2a:
	ldb_s r1,[r2,0x6]
L_923c2c:
	brne r13,r1,L_923c4a
L_923c30:
	ldb_s r13,[r3,0x13]
L_923c32:
	ldb_s r1,[r2,0x7]
L_923c34:
	brne r13,r1,L_923c4a
L_923c38:
	ldb_s r13,[r3,0x14]
L_923c3a:
	ldb_s r1,[r2,0x8]
L_923c3c:
	brne r13,r1,L_923c4a
L_923c40:
	ldb_s r3,[r3,0x15]
L_923c42:
	ldb_s r1,[r2,0x9]
L_923c44:
	cmp_s r3,r1
L_923c46:
	mov.eq r0,0x1
	.global L_923c4a
L_923c4a:
	extb_s r0,r0
	.global L_923c4c
L_923c4c:
	breq_s r0,0,L_923c6e
L_923c4e:
	mov_s r1,0x80088c
L_923c54:
	ldb r2,[r1, 0x50]
L_923c58:
	/* asl_s r2,r2,0x3 */
	.byte 0x03,0xba
L_923c5a:
	add2_s r2,r2,r2
L_923c5c:
	add_s r2,r2,0x8008ac
L_923c62:
	ldb_s r1,[r2,0x5]
L_923c64:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_923c66:
	extb_s r1,r1
L_923c68:
	stb_s r1,[r2,0x5]
L_923c6a:
	mov_s r1,0x1
L_923c6c:
	stb_s r1,[r2,0x6]
	.global L_923c6e
L_923c6e:
	b L_920284
L_923c72:
	nop_s
