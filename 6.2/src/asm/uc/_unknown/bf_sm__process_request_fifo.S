/* bf_sm__process_request_fifo @ 0x921d50, 600 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bf_sm_handler in state:%u:%u non_idle_mask:%x
 *   BF state failure, but the BRP mode was already set; cid: %d
 *   BF state failure; move to non-deferred BRP; cid: %d
 *   bf_db_p->p_brp_cfg_info is NULL;  cid: %d was deleted
 * Зовут его: boot_uc__init_tail
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, bf__abort_step, bf__clear_pending_and_notify, bf__pause_sta_tx, bf_pending__set_bit, bf_req__dequeue_head, bf_sm__brp_init_result, bf_sm__brp_resp_result, bf_sm__set_sta_state, bf_sm__txss_init_result, bf_sm__txss_resp_result
 * Глобалы (через gp): 0x8005b6, 0x8005b8, 0x8005dc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf_sm__process_request_fifo
bf_sm__process_request_fifo:
	.global L_921d50
L_921d50:
	push_s blink
L_921d52:
	bl L_920224
L_921d56:
	mov_s r15,0x80207c
L_921d5c:
	ld_s r0,[r15,0x34]
L_921d5e:
	mov_s r13,0x801ffc
L_921d64:
	cmp_s r0,0x0
L_921d66:
	beq.d L_921fa4
L_921d6a:
	mov r18,0x0
L_921d6e:
	bl.d L_93c874
L_921d72:
	mov_s r0,r18
L_921d74:
	bl L_93c658
L_921d78:
	ld_s r0,[r15,0x40]
L_921d7a:
	mov_s r1,0x8020b4
L_921d80:
	bmsk_s r0,r0,0x2
L_921d82:
	ldb_s r14,[r1,r0]
L_921d84:
	asl_s r0,r14,0x2
L_921d86:
	add2_s r0,r0,r0
L_921d88:
	add_s r13,r13,r0
L_921d8a:
	ld_s r0,[r13,0x4]
L_921d8c:
	breq_s r0,0,L_921da8
L_921d8e:
	ld_s r0,[r13]
L_921d90:
	breq r0,0x3,L_921da8
L_921d94:
	ld_s r2,[r13]
L_921d96:
	mov_s r1,0x1000c3c
L_921d9c:
	ld_s r3,[r13,0x4]
L_921d9e:
	ld r4,[r15, 0x34]
L_921da2:
	bl.d L_92d338
L_921da6:
	mov_s r0,0x20
	.global L_921da8
L_921da8:
	st.as r14,[gp,-0x2e]
L_921dac:
	ld_s r0,[r13,0x4]
L_921dae:
	ld_s r0,[r13]
L_921db0:
	ld_s r1,[r13]
L_921db2:
	cmp_s r1,0x12
L_921db4:
	bhi L_921f76
L_921db8:
	ldb r1,[0x801804,r1]
L_921dc0:
	add r0,pcl,0x8
L_921dc4:
	add1_s r0,r0,r1
L_921dc6:
	j_s [r0]
L_921dc8:
	mov_s r15,0x0
L_921dca:
	mov_s r16,r15
L_921dcc:
	b_s L_921e98
L_921dce:
	mov_s r0,r14
L_921dd0:
	mov_s r1,0x0
L_921dd2:
	bl.d L_921900
L_921dd6:
	mov_s r2,0x1
L_921dd8:
	mov_s r0,0x3
L_921dda:
	bl.d L_92ba54
L_921dde:
	mov_s r1,r14
L_921de0:
	mov_s r0,r14
L_921de2:
	mov_s r1,0x3
L_921de4:
	b_s L_921e68
L_921de6:
	bl.d L_93b840
L_921dea:
	mov_s r0,r14
L_921dec:
	breq_s r0,0,L_921e3a
L_921dee:
	breq r0,0x2,L_921e32
L_921df2:
	brne r0,0x1,L_921e3a
L_921df6:
	b_s L_921e08
L_921df8:
	bl.d L_93bdf0
L_921dfc:
	mov_s r0,r14
L_921dfe:
	breq_s r0,0,L_921e3a
L_921e00:
	breq r0,0x2,L_921e32
L_921e04:
	brne r0,0x1,L_921e2e
	.global L_921e08
L_921e08:
	mov_s r0,0x8021d8
L_921e0e:
	ldb_s r0,[r0,0x5]
L_921e10:
	brne r0,0x1,L_921e28
L_921e14:
	mov_s r0,0x80217c
L_921e1a:
	ldb_s r0,[r0,0x18]
L_921e1c:
	btst r0,r14
L_921e20:
	mov.ne r0,r14
L_921e24:
	mov_s r1,0x9
L_921e26:
	bne_s L_921e36
	.global L_921e28
L_921e28:
	mov_s r0,r14
L_921e2a:
	mov_s r1,0xd
L_921e2c:
	b_s L_921e36
	.global L_921e2e
L_921e2e:
	brne r0,0x3,L_921e3a
	.global L_921e32
L_921e32:
	mov_s r0,r14
L_921e34:
	mov_s r1,0xb
	.global L_921e36
L_921e36:
	bl L_92b220
	.global L_921e3a
L_921e3a:
	bl.d L_9216f8
L_921e3e:
	mov_s r0,0x1
L_921e40:
	b_s L_921f7e
L_921e42:
	mov_s r0,r14
L_921e44:
	mov_s r1,0x0
L_921e46:
	bl.d L_921900
L_921e4a:
	mov_s r2,0x1
L_921e4c:
	mov_s r0,r14
L_921e4e:
	mov_s r1,0x9
L_921e50:
	b_s L_921e68
L_921e52:
	bl.d L_922494
L_921e56:
	mov_s r0,r14
L_921e58:
	cmp_s r0,0x0
L_921e5a:
	beq_s L_921f7e
L_921e5c:
	breq r0,0x2,L_921e78
L_921e60:
	brne r0,0x1,L_921e8a
	.global L_921e64
L_921e64:
	mov_s r0,r14
L_921e66:
	mov_s r1,0xd
	.global L_921e68
L_921e68:
	bl L_92b220
L_921e6c:
	b_s L_921e8a
L_921e6e:
	bl.d L_922e74
L_921e72:
	mov_s r0,r14
L_921e74:
	brne r0,0x2,L_921e7e
	.global L_921e78
L_921e78:
	mov_s r0,r14
L_921e7a:
	mov_s r1,0xe
L_921e7c:
	b_s L_921e68
	.global L_921e7e
L_921e7e:
	breq r0,0x1,L_921e64
L_921e82:
	mov_s r0,blink
L_921e84:
	bl.d L_926618
L_921e88:
	mov_s r1,0x14
	.global L_921e8a
L_921e8a:
	bl.d L_921824
L_921e8e:
	mov_s r0,r14
L_921e90:
	b_s L_921f7e
L_921e92:
	mov_s r15,0x1
L_921e94:
	mov r16,0x1
	.global L_921e98
L_921e98:
	ld_s r0,[r13]
L_921e9a:
	brne r0,0x11,L_921ee6
L_921e9e:
	ld_s r0,[gp,0xb4]
L_921ea0:
	cmp_s r0,0x1
L_921ea2:
	mov.eq r0,0x3
L_921ea6:
	bl.eq.d L_92ba54
L_921eaa:
	mov.eq r1,r14
L_921eae:
	mov r17,0x0
L_921eb2:
	ldw_s r0,[gp,0x8e]
L_921eb4:
	bset r17,r17,r14
L_921eb8:
	tst r0,r17
L_921ebc:
	beq_s L_921ece
L_921ebe:
	mov_s r1,0x1000c6c
L_921ec4:
	mov_s r0,0x20
L_921ec6:
	bl.d L_92d1d0
L_921eca:
	mov_s r2,r14
L_921ecc:
	b_s L_921ee6
	.global L_921ece
L_921ece:
	mov_s r1,0x1000ca8
L_921ed4:
	mov_s r0,0x10
L_921ed6:
	bl.d L_92d1d0
L_921eda:
	mov_s r2,r14
L_921edc:
	ldw_s r0,[gp,0x90]
L_921ede:
	bic r0,r0,r17
L_921ee2:
	stw.as r0,[gp,0x48]
	.global L_921ee6
L_921ee6:
	mov_s r0,r14
L_921ee8:
	bl.d L_92b220
L_921eec:
	mov_s r1,0x0
L_921eee:
	bl.d L_9258b0
L_921ef2:
	mov_s r0,r14
L_921ef4:
	ld_s r0,[r13,0xc]
L_921ef6:
	brne_s r0,0,L_921f08
L_921ef8:
	mov_s r1,0x1000cdc
L_921efe:
	mov_s r0,0x20
L_921f00:
	bl.d L_92d1d0
L_921f04:
	mov_s r2,r14
L_921f06:
	b_s L_921f34
	.global L_921f08
L_921f08:
	ld_s r0,[r13,0xc]
L_921f0a:
	ld_s r3,[r0]
L_921f0c:
	ld r17,[r13, 0x10]
L_921f10:
	cmp_s r3,0x0
L_921f12:
	mov.ne r0,r15
L_921f16:
	mov.ne r1,r14
L_921f1a:
	jlne.d [r3]
L_921f1e:
	mov.ne r2,r16
L_921f22:
	breq r17,0x0,L_921f34
L_921f26:
	mov_s r0,0x1
L_921f28:
	mov_s r1,r14
L_921f2a:
	mov_s r3,r17
L_921f2c:
	jl_s.d [r3]
L_921f2e:
	mov_s r2,0x0
L_921f30:
	st r18,[r13, 0x10]
	.global L_921f34
L_921f34:
	mov_s r0,r15
L_921f36:
	bl.d L_921b38
L_921f3a:
	mov_s r1,0x0
L_921f3c:
	ld_s r1,[r13,0x4]
L_921f3e:
	ld_s r0,[r13]
L_921f40:
	/* asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_921f42:
	or_s r0,r0,r1
L_921f44:
	mov_s r1,0x801ffc
L_921f4a:
	st.as r0,[r1,0x49]
L_921f4e:
	ld_s r0,[gp,-0x34]
L_921f50:
	brne r0,0x2,L_921f7e
L_921f54:
	ldb r0,[r1,0x198]
L_921f5c:
	breq_s r0,0,L_921f7e
L_921f5e:
	brne r16,0x1,L_921f7e
L_921f62:
	mov_s r0,0x2
L_921f64:
	bl.d L_92f4bc
L_921f68:
	mov_s r1,r14
L_921f6a:
	mov_s r0,0x801c18
L_921f70:
	bl L_9356cc
L_921f74:
	b_s L_921f7e
	.global L_921f76
L_921f76:
	mov_s r0,blink
L_921f78:
	bl.d L_926618
L_921f7c:
	mov_s r1,0x15
	.global L_921f7e
L_921f7e:
	ld_s r0,[r13,0x4]
L_921f80:
	ld_s r1,[r13]
L_921f82:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_921f84:
	or_s r0,r0,r1
L_921f86:
	bmsk_s r0,r0,0xb
L_921f88:
	or r0,r0,0xfaa000
L_921f90:
	mov_s r32,r0
L_921f92:
	st.ab r0,[r25,0x4]
L_921f96:
	bclr r25,r25,0xa
L_921f9a:
	mov_s r1,0x8020fc
L_921fa0:
	ld_s r0,[r1,0x24]
L_921fa2:
	st_s r0,[r1,0x28]
	.global L_921fa4
L_921fa4:
	b L_920284
