/* internal_tx__pending_sm @ 0x928e68, 196 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   internal_tx.c
 *   internal TX pending sm = %d
 * Зовут его: tx_initiator_flow
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, bf_pending__set_bit, bf_sm__step_by_state, bi_tx__check_idle_and_start, internal_tx_step, set_g_80067c, stub_ret_9329f4, uc_pending__clear_bit, uc_sta_ctx__reset, uc_sysassert
 * Глобалы (через gp): 0x8005b0
 */
	.section .text.internal_tx__pending_sm,"ax",@progbits
	.global internal_tx__pending_sm
internal_tx__pending_sm:
	.global L_928e68
L_928e68:
	push_s blink
L_928e6a:
	bl L_920210
L_928e6e:
	mov_s r13,r0
L_928e70:
	mov_s r14,0x800674
L_928e76:
	ld_s r0,[r14]
L_928e78:
	brne_s r0,0,L_928e8a
L_928e7a:
	mov_s r0,blink
L_928e7c:
	mov_s r2,0x10021bc
L_928e82:
	mov_s r1,0x61
L_928e84:
	bl.d L_925548
L_928e88:
	mov_s r3,0x7e
	.global L_928e8a
L_928e8a:
	ld_s r0,[r14]
L_928e8c:
	ld_s r1,[r14,0x8]
L_928e8e:
	bic_s r0,r0,r1
L_928e90:
	norm r0,r0
L_928e94:
	bl.d L_928ca8
L_928e98:
	rsub r14,r0,0x1e
L_928e9c:
	mov_s r2,0x80209c
L_928ea2:
	ldb_s r0,[r2,0x5]
L_928ea4:
	mov_s r3,0x10021cc
L_928eaa:
	bbit0 r0,0x2,L_928ed4
L_928eae:
	ld_s r0,[r2]
L_928eb0:
	mov_s r1,0x8020b0
L_928eb6:
	add_s r15,r0,0x1
L_928eb8:
	extb_s r15,r15
L_928eba:
	add2 r15,r1,r15
L_928ebe:
	st_s r14,[r15]
L_928ec0:
	bmsk_s r3,r3,0x13
L_928ec2:
	or r3,r3,0xa6100000
L_928eca:
	extb_s r15,r0
L_928ecc:
	add2_s r1,r1,r15
L_928ece:
	st_s r3,[r1]
L_928ed0:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_928ed2:
	st_s r0,[r2]
	.global L_928ed4
L_928ed4:
	breq r14,0x1,L_928f1a
L_928ed8:
	breq r14,0x2,L_928f22
L_928edc:
	brne r14,0x3,L_928f26
L_928ee0:
	bl.d L_931f54
L_928ee4:
	mov_s r0,0x1
L_928ee6:
	st.as r0,[gp,0x22]
L_928eea:
	mov_s r14,0x3
L_928eec:
	st_s r14,[r0,0xc]
L_928eee:
	ld_s r0,[r13]
L_928ef0:
	mov_s r1,0x857849
L_928ef6:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_928ef8:
	add2_s r0,r0,r0
L_928efa:
	ldb_s r1,[r1,r0]
L_928efc:
	ld_s r0,[gp,0x88]
L_928efe:
	st_s r1,[r0,0x10]
L_928f00:
	bl.d L_9221f8
L_928f04:
	ld_s r0,[gp,-0xbc]
L_928f06:
	bl.d L_928f6c
L_928f0a:
	mov_s r0,r14
L_928f0c:
	bl.d L_921f58
L_928f10:
	mov_s r0,0x0
L_928f12:
	bl.d L_931a78
L_928f16:
	mov_s r0,0x2
L_928f18:
	b_s L_928f26
	.global L_928f1a
L_928f1a:
	bl.d L_9329f4
L_928f1e:
	mov_s r0,r13
L_928f20:
	b_s L_928f26
	.global L_928f22
L_928f22:
	bl L_9339f0
	.global L_928f26
L_928f26:
	b L_92027c
L_928f2a:
	nop_s
