/* PS_CONNECTION__awake_peer_ntf @ 0x8c3f1c, 336 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   g_dbg_psc_transition INCREASE_PS
 *   g_dbg_psc_transition DECREASE_PS
 *   PS_CONNECTION::awake_peer_ntf - notification type: %d, is_doze_bi=%d, PS mode: %d
 * Зовут его: PS_NONASSOC_SM__ps_reenter_done
 * Зовёт сам: __ld_r15_to_r13_ret, __ld_r17_to_r13_ret, __st_r15_to_r13, __st_r17_to_r13, basic_sm__handle_event, fw_log_emit0, fw_log_emit3, scan_mngr__sob_awake_bi_ntf
 * Глобалы (через gp): 0x800268, 0x800269, 0x800320, 0x800324
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global PS_CONNECTION__awake_peer_ntf
PS_CONNECTION__awake_peer_ntf:
	.global L_8c3f1c
L_8c3f1c:
	push_s blink
L_8c3f1e:
	bl L_8c01d8
L_8c3f22:
	mov_s r13,r0
L_8c3f24:
	ld_s r0,[gp,0x19c]
L_8c3f26:
	mov_s r16,r1
L_8c3f28:
	mov_s r17,r2
L_8c3f2a:
	breq_s r0,0,L_8c3f6e
L_8c3f2c:
	ld_s r0,[gp,0x1a0]
L_8c3f2e:
	cmp_s r0,0x0
L_8c3f30:
	beq_s L_8c4022
L_8c3f32:
	mov_s r14,0x0
L_8c3f34:
	brne r0,0x1,L_8c3f4a
L_8c3f38:
	mov_s r1,0x1002568
L_8c3f3e:
	bl.d L_8dcba8
L_8c3f42:
	mov_s r0,0x2e
L_8c3f44:
	add_s r0,r13,0x4
L_8c3f46:
	mov_s r1,0x0
L_8c3f48:
	b_s L_8c3f5e
	.global L_8c3f4a
L_8c3f4a:
	brne r0,0x2,L_8c3f68
L_8c3f4e:
	mov_s r1,0x100258c
L_8c3f54:
	bl.d L_8dcba8
L_8c3f58:
	mov_s r0,0x2e
L_8c3f5a:
	add_s r0,r13,0x4
L_8c3f5c:
	mov_s r1,0x1
	.global L_8c3f5e
L_8c3f5e:
	mov_s r2,0x0
L_8c3f60:
	mov_s r3,r2
L_8c3f62:
	bl.d L_8d9b6c
L_8c3f66:
	mov_s r4,r2
	.global L_8c3f68
L_8c3f68:
	st.as r14,[gp,0x68]
L_8c3f6c:
	b_s L_8c4022
	.global L_8c3f6e
L_8c3f6e:
	ld_s r0,[r13]
L_8c3f70:
	breq r0,0x0,L_8c4022
L_8c3f74:
	ld_s r0,[r13,0x34]
L_8c3f76:
	add_s r14,r13,0x4
L_8c3f78:
	ld_s r0,[r0,0x18]
L_8c3f7a:
	ldb r4,[r14]
L_8c3f7e:
	ld.as r15,[r0,0x8f]
L_8c3f82:
	mov_s r1,0x10025b0
L_8c3f88:
	ld r2,[r17, 0x8]
L_8c3f8c:
	mov_s r0,0x2e
L_8c3f8e:
	bl.d L_8dcd00
L_8c3f92:
	ldb r3,[r17, 0x1]
L_8c3f96:
	ld r0,[r17, 0x8]
L_8c3f9a:
	brne r0,0x0,L_8c4022
L_8c3f9e:
	mov_s r0,0x0
L_8c3fa0:
	breq r16,0x0,L_8c3fe0
L_8c3fa4:
	ldb_s r1,[r13,0x14]
L_8c3fa6:
	stb_s r0,[r13,0x15]
L_8c3fa8:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8c3faa:
	extb_s r1,r1
L_8c3fac:
	stb_s r1,[r13,0x14]
L_8c3fae:
	ldb_s r0,[gp,0xe5]
L_8c3fb0:
	cmp_s r1,r0
L_8c3fb2:
	mov_s r1,0x1
L_8c3fb4:
	ld_s r0,[r15,0x78]
L_8c3fb6:
	sub.lt r1,r1,r1
L_8c3fba:
	breq_s r0,0,L_8c3fd2
L_8c3fbc:
	ldb_s r0,[r14]
L_8c3fbe:
	brne r0,0x2,L_8c4004
	.global L_8c3fc2
L_8c3fc2:
	mov_s r0,r14
L_8c3fc4:
	mov_s r1,0x0
	.global L_8c3fc6
L_8c3fc6:
	mov_s r2,0x0
L_8c3fc8:
	mov_s r3,r2
L_8c3fca:
	bl.d L_8d9b6c
L_8c3fce:
	mov_s r4,r2
L_8c3fd0:
	b_s L_8c4004
	.global L_8c3fd2
L_8c3fd2:
	breq_s r1,0,L_8c4004
L_8c3fd4:
	ldb_s r0,[r14]
L_8c3fd6:
	brne r0,0x4,L_8c4004
L_8c3fda:
	mov_s r0,r14
L_8c3fdc:
	mov_s r1,0x1
L_8c3fde:
	b_s L_8c3fc6
	.global L_8c3fe0
L_8c3fe0:
	ldb_s r1,[r13,0x15]
L_8c3fe2:
	stb_s r0,[r13,0x14]
L_8c3fe4:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8c3fe6:
	extb_s r1,r1
L_8c3fe8:
	stb_s r1,[r13,0x15]
L_8c3fea:
	ldb_s r0,[gp,0xe4]
L_8c3fec:
	mov_s r2,0x1
L_8c3fee:
	cmp_s r1,r0
L_8c3ff0:
	ldb_s r1,[r14]
L_8c3ff2:
	sub.lt r2,r2,r2
L_8c3ff6:
	ld_s r0,[r15,0x78]
L_8c3ff8:
	brne r1,0x2,L_8c4004
L_8c3ffc:
	cmp_s r0,0x0
L_8c3ffe:
	cmp.eq r2,0x0
L_8c4002:
	bne_s L_8c3fc2
	.global L_8c4004
L_8c4004:
	ld_s r0,[r15,0x78]
L_8c4006:
	breq_s r0,0,L_8c4022
L_8c4008:
	ld.as r0,[r15,0x73]
L_8c400c:
	brne_s r0,0,L_8c4022
L_8c400e:
	ldb_s r0,[r14]
L_8c4010:
	brne r0,0x4,L_8c4022
L_8c4014:
	ldb r0,[r17, 0x1]
L_8c4018:
	cmp_s r0,0x0
L_8c401a:
	bl.eq.d L_8e74d8
L_8c401e:
	mov.eq r0,r15
	.global L_8c4022
L_8c4022:
	b L_8c023c
L_8c4026:
	nop_s
	.global L_8c4028
L_8c4028:
	push_s blink
L_8c402a:
	bl L_8c01e0
L_8c402e:
	mov_s r14,r0
L_8c4030:
	ldb_s r0,[r0,0x2]
L_8c4032:
	ldb_s r15,[r14,0x3]
L_8c4034:
	or_s r15,r15,r0
L_8c4036:
	ldb r13,[gp, 0xf0]
L_8c403a:
	b_s L_8c4064
	.global L_8c403c
L_8c403c:
	norm r0,r13
L_8c4040:
	rsub r2,r0,0x1e
L_8c4044:
	extb_s r2,r2
L_8c4046:
	mul64 r2,0x88
L_8c404a:
	asr r1,r15,r2
L_8c404e:
	bclr r13,r13,r2
L_8c4052:
	bmsk_s r1,r1,0x0
L_8c4054:
	add r0,mlo,0x803db0
L_8c405c:
	extb_s r13,r13
L_8c405e:
	bl.d L_8c3f1c
L_8c4062:
	mov_s r2,r14
	.global L_8c4064
L_8c4064:
	brne_s r13,0,L_8c403c
L_8c4066:
	b L_8c024c
L_8c406a:
	nop_s
