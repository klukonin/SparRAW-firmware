/* vring__disconnect_flush @ 0x925c8c, 1040 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Flush VRing %d
 *   Vring disconnect flow timeout: PRING is idle pring_idx %d, update PRING SW_HEAD_4_RD
 *   Vring disconnect flow timeout: ptp_sm = 0x%x
 *   PTP was reset to Idle: Must be state 0, current ptp_sm state = 0x%x
 *   PTP stuck (but PFIFO2 sm != 5), resetting PTP g_ptp_stuck_on_sm_other %d
 *   Vring disconnect flow timeout: PRING is idle pring_idx %d, update PRING SW_HEAD_4_RD, ptp_was_reset %d
 *   After VRing flush (flush tries is %d, Max tries %d, WA cnt %d)
 *   After VRing close
 * Зовут его: l1_fixed_sched_ap__ev4_state4
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, dma_is_idle_uc, dma_is_tx_pipe_idle, dump_mac_buffer_bases, dump_pring_hw, mac__program_tx_with_qid, macq__flush_queue, macq__is_idle, macq_hw__commit_rptr, macq_hw__read_state0, macq_hw__read_state1
 * Глобалы (через gp): 0x800608, 0x80060c
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global vring__disconnect_flush
vring__disconnect_flush:
	.global L_925c8c
L_925c8c:
	push_s blink
L_925c8e:
	bl L_92021c
L_925c92:
	st.a r0,[sp,-0x14]
L_925c96:
	st_s r1,[sp,0x4]
L_925c98:
	mov_s r17,r2
L_925c9a:
	st_s r3,[sp,0x8]
L_925c9c:
	mov_s r13,0x0
L_925c9e:
	mov r19,0x1
L_925ca2:
	mov_s r1,0x1001b5c
L_925ca8:
	mov_s r0,0x21
L_925caa:
	bl.d L_92d1d0
L_925cae:
	ld_s r2,[sp,0x0]
L_925cb0:
	ld_s r0,[sp,0x0]
L_925cb2:
	bl.d L_925c0c
L_925cb6:
	mov_s r1,r17
L_925cb8:
	bl.d L_9384d4
L_925cbc:
	mov_s r0,0x1
L_925cbe:
	mov_s r20,r0
L_925cc0:
	st r17,[r0, 0x4]
L_925cc4:
	mov_s r16,r13
L_925cc6:
	mov_s r18,r13
L_925cc8:
	b.d L_92600a
L_925ccc:
	mov_s r15,r13
	.global L_925cce
L_925cce:
	cmp r16,0xf
L_925cd2:
	bcc L_92601a
L_925cd6:
	bl.d L_92609c
L_925cda:
	ld_s r0,[sp,0x0]
L_925cdc:
	add r16,r16,0x1
L_925ce0:
	breq_s r0,0,L_925cec
L_925ce2:
	ld_s r0,[sp,0x4]
L_925ce4:
	bl.d L_9290f4
L_925ce8:
	mov_s r1,0x1
L_925cea:
	breq_s r0,0,L_925d02
	.global L_925cec
L_925cec:
	bl.d L_92609c
L_925cf0:
	ld_s r0,[sp,0x0]
L_925cf2:
	cmp_s r0,0x0
L_925cf4:
	beq L_925e5c
L_925cf8:
	cmp_s r13,0x0
L_925cfa:
	beq L_926078
L_925cfe:
	b L_926002
	.global L_925d02
L_925d02:
	add r18,r18,0x1
L_925d06:
	cmp r18,0x8
L_925d0a:
	bcs L_925e54
L_925d0e:
	bl.d L_9291d8
L_925d12:
	ld_s r0,[sp,0x4]
L_925d14:
	mov_s r15,0x8006ec
L_925d1a:
	breq_s r0,0,L_925d32
L_925d1c:
	ld_s r0,[r15,0x4]
L_925d1e:
	mov_s r1,0x1001b6c
L_925d24:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_925d26:
	st_s r0,[r15,0x4]
L_925d28:
	mov_s r0,0x1
L_925d2a:
	bl.d L_92d1d0
L_925d2e:
	ld_s r2,[sp,0x4]
L_925d30:
	b_s L_925e3a
	.global L_925d32
L_925d32:
	mov_s r0,0x886a00
L_925d38:
	st 0x80000000,[r0, 0x48]
L_925d40:
	sync
L_925d44:
	mov_s r14,0x886a00
L_925d4a:
	ld_s r0,[r14,0x48]
L_925d4c:
	mov_s r1,0x1001bc4
L_925d52:
	bmsk_s r0,r0,0x2
L_925d54:
	st_s r0,[sp,0xc]
L_925d56:
	mov_s r0,0x1
L_925d58:
	bl.d L_92d1d0
L_925d5c:
	ld_s r2,[sp,0xc]
L_925d5e:
	ld_s r0,[sp,0xc]
L_925d60:
	brne r0,0x5,L_925db4
L_925d64:
	ld_s r0,[r15,0xc]
L_925d66:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_925d68:
	st_s r0,[r15,0xc]
L_925d6a:
	mov_s r0,0x0
L_925d6c:
	st_s r0,[r14,0x48]
L_925d6e:
	sync
L_925d72:
	st 0x40000000,[r14, 0x48]
L_925d7a:
	sync
L_925d7e:
	mov_s r0,0x50
L_925d80:
	mov lp_count,r0
L_925d84:
	nop_s
L_925d86:
	lp L_925d8e
L_925d8a:
	nop_s
L_925d8c:
	nop_s
	.global L_925d8e
L_925d8e:
	st 0x80000000,[r14, 0x48]
L_925d96:
	sync
L_925d9a:
	ld_s r2,[r14,0x48]
L_925d9c:
	mov_s r1,0x1001bf4
L_925da2:
	mov_s r0,0x1
L_925da4:
	bl.d L_92d1d0
L_925da8:
	bmsk_s r2,r2,0x2
L_925daa:
	mov_s r0,0x5dc0
L_925db0:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_925db2:
	b_s L_925e44
	.global L_925db4
L_925db4:
	bl L_92e8a8
L_925db8:
	brne r0,0x0,L_925e24
L_925dbc:
	ld_s r2,[r15,0x10]
L_925dbe:
	mov_s r1,0x1001c38
L_925dc4:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_925dc6:
	st_s r2,[r15,0x10]
L_925dc8:
	bl.d L_92d1d0
L_925dcc:
	mov_s r0,0x1
L_925dce:
	mov_s r0,0x0
L_925dd0:
	st_s r0,[r14,0x38]
L_925dd2:
	st_s r0,[r14,0x44]
L_925dd4:
	st_s r0,[r14,0x3c]
L_925dd6:
	st_s r0,[r14,0x48]
L_925dd8:
	sync
L_925ddc:
	st 0x40000000,[r14, 0x38]
L_925de4:
	sync
L_925de8:
	st 0x40000000,[r14, 0x44]
L_925df0:
	sync
L_925df4:
	st 0x40000000,[r14, 0x3c]
L_925dfc:
	sync
L_925e00:
	st 0x40000000,[r14, 0x48]
L_925e08:
	sync
L_925e0c:
	mov_s r0,0x5dc0
L_925e12:
	mov lp_count,r0
L_925e16:
	nop_s
L_925e18:
	lp L_925e20
L_925e1c:
	nop_s
L_925e1e:
	nop_s
	.global L_925e20
L_925e20:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_925e22:
	b_s L_925e52
	.global L_925e24
L_925e24:
	ld_s r0,[r15,0x8]
L_925e26:
	mov_s r1,0x1001c84
L_925e2c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_925e2e:
	st_s r0,[r15,0x8]
L_925e30:
	ld_s r2,[sp,0x4]
L_925e32:
	mov_s r0,0x1
L_925e34:
	bl.d L_92d27c
L_925e38:
	mov_s r3,r13
	.global L_925e3a
L_925e3a:
	bl.d L_92a640
L_925e3e:
	ld_s r0,[sp,0x4]
L_925e40:
	mov_s r0,0x7d
L_925e42:
	/* asl_s r0,r0,0x6 */
	.byte 0x06,0xb8
	.global L_925e44
L_925e44:
	mov lp_count,r0
L_925e48:
	nop_s
L_925e4a:
	lp L_925e52
L_925e4e:
	nop_s
L_925e50:
	nop_s
	.global L_925e52
L_925e52:
	mov_s r15,0x1
	.global L_925e54
L_925e54:
	mov_s r0,0x7d
L_925e56:
	/* b.d 0x0092607c */
	.byte 0x29,0x02,0x20,0x00
L_925e5a:
	/* _asl_s r0,r0,0x6 */
	.byte 0x06,0xb8
	.global L_925e5c
L_925e5c:
	mov_s r0,0x886500
L_925e62:
	ld_s r0,[r0,0x6c]
L_925e64:
	bmsk.f 0x0,r0,0x3
L_925e68:
	mov.ne r0,blink
L_925e6c:
	bl.ne.d L_926618
L_925e70:
	mov.ne r1,0x3
L_925e74:
	mov_s r0,0x1c000006
L_925e7a:
	mov_s r32,r0
L_925e7c:
	st.ab r0,[r25,0x4]
L_925e80:
	bclr r25,r25,0xa
L_925e84:
	asl r1,r19,0x3
L_925e88:
	or r1,r1,0x46000003
L_925e90:
	asl r0,r17,0x4
L_925e94:
	or_s r0,r0,r1
L_925e96:
	bset_s r0,r0,0xe
L_925e98:
	mov_s r32,r0
L_925e9a:
	st.ab r0,[r25,0x4]
L_925e9e:
	bclr r25,r25,0xa
L_925ea2:
	mov_s r1,0x8022c8
L_925ea8:
	ld_s r0,[r1,0x14]
L_925eaa:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_925eac:
	st_s r0,[r1,0x14]
	.global L_925eae
L_925eae:
	mov_s r0,r53
L_925eb0:
	bbit0 r0,0x2,L_925eae
L_925eb4:
	ld_s r0,[gp,-0x44]
L_925eb6:
	and r0,r0,0xfff0ffff
L_925ebe:
	bset r1,r0,0x10
L_925ec2:
	or r0,r0,0x1d010000
L_925eca:
	st.as r1,[gp,-0x11]
L_925ece:
	mov_s r32,r0
L_925ed0:
	st.ab r0,[r25,0x4]
L_925ed4:
	bclr r25,r25,0xa
L_925ed8:
	nop_s
L_925eda:
	nop_s
L_925edc:
	nop_s
	.global L_925ede
L_925ede:
	mov_s r0,r47
L_925ee0:
	bbit1 r0,0x0,L_925ede
L_925ee4:
	ld_s r0,[sp,0x8]
L_925ee6:
	asl_s r0,r0,0x8
L_925ee8:
	bset_s r0,r0,0x1a
L_925eea:
	bset_s r0,r0,0x1e
L_925eec:
	or r0,r0,r17
L_925ef0:
	bset_s r0,r0,0x13
L_925ef2:
	bset_s r0,r0,0x15
L_925ef4:
	mov_s r32,r0
L_925ef6:
	st.ab r0,[r25,0x4]
L_925efa:
	bclr r25,r25,0xa
L_925efe:
	mov_s r0,0x45000001
L_925f04:
	mov_s r32,r0
L_925f06:
	st.ab r0,[r25,0x4]
L_925f0a:
	bclr r25,r25,0xa
L_925f0e:
	mov_s r0,0x460001f1
L_925f14:
	mov_s r32,r0
L_925f16:
	st.ab r0,[r25,0x4]
L_925f1a:
	bclr r25,r25,0xa
L_925f1e:
	bl.d L_92d93c
L_925f22:
	ld r0,[r20, 0x4]
	.global L_925f26
L_925f26:
	mov_s r0,r43
L_925f28:
	bbit0 r0,0x1f,L_925f26
L_925f2c:
	mov_s r0,r51
L_925f2e:
	bmsk r1,r0,0x3
L_925f32:
	st.as r1,[gp,0x38]
L_925f36:
	lsr_s r0,r0,0x4
L_925f38:
	st.as r0,[gp,0x39]
	.global L_925f3c
L_925f3c:
	mov_s r0,r45
L_925f3e:
	bbit0 r0,0x1f,L_925f3c
L_925f42:
	mov_s r14,0x0
L_925f44:
	b_s L_925f48
	.global L_925f46
L_925f46:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_925f48
L_925f48:
	brhs r14,0xa,L_925f72
L_925f4c:
	mov r0,0x320
L_925f50:
	mov lp_count,r0
L_925f54:
	nop_s
L_925f56:
	lp L_925f5e
L_925f5a:
	nop_s
L_925f5c:
	nop_s
	.global L_925f5e
L_925f5e:
	bl.d L_929020
L_925f62:
	ld_s r0,[sp,0x4]
L_925f64:
	st_s r0,[sp,0x10]
L_925f66:
	bl.d L_929044
L_925f6a:
	ld_s r0,[sp,0x4]
L_925f6c:
	ld_s r1,[sp,0x10]
L_925f6e:
	brne r1,r0,L_925f46
	.global L_925f72
L_925f72:
	mov r19,0x0
L_925f76:
	b_s L_92600a
	.global L_925f78
L_925f78:
	mov_s r1,0x0
L_925f7a:
	mov_s r0,0x886a00
L_925f80:
	st_s r1,[r0,0x38]
L_925f82:
	st_s r1,[r0,0x44]
L_925f84:
	st_s r1,[r0,0x3c]
L_925f86:
	st_s r1,[r0,0x48]
L_925f88:
	sync
L_925f8c:
	mov_s r0,0x886a00
L_925f92:
	st 0x40000000,[r0, 0x38]
L_925f9a:
	sync
L_925f9e:
	mov_s r0,0x886a00
L_925fa4:
	st 0x40000000,[r0, 0x44]
L_925fac:
	sync
L_925fb0:
	mov_s r0,0x886a00
L_925fb6:
	st 0x40000000,[r0, 0x3c]
L_925fbe:
	sync
L_925fc2:
	mov_s r0,0x886a00
L_925fc8:
	st 0x40000000,[r0, 0x48]
L_925fd0:
	sync
L_925fd4:
	mov_s r1,0x8006ec
L_925fda:
	ld_s r0,[r1,0x14]
L_925fdc:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_925fde:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_925fe0:
	st_s r0,[r1,0x14]
L_925fe2:
	bl.d L_9291d8
L_925fe6:
	ld_s r0,[sp,0x4]
L_925fe8:
	mov_s r32,r13
L_925fea:
	st.ab r13,[r25,0x4]
L_925fee:
	bclr r25,r25,0xa
L_925ff2:
	mov_s r0,0xff22
L_925ff8:
	mov_s r32,r0
L_925ffa:
	st.ab r0,[r25,0x4]
L_925ffe:
	bclr r25,r25,0xa
	.global L_926002
L_926002:
	bl L_92e8a8
L_926006:
	breq r0,0x0,L_925f78
	.global L_92600a
L_92600a:
	ld_s r0,[sp,0x0]
L_92600c:
	ld_s r1,[sp,0x4]
L_92600e:
	bl.d L_926184
L_926012:
	mov_s r2,0xa
L_926014:
	cmp_s r0,0x0
L_926016:
	beq L_925cce
	.global L_92601a
L_92601a:
	brhs r16,0xf,L_92608c
	.global L_92601e
L_92601e:
	mov_s r1,0x8006ec
L_926024:
	ldb r3,[r1, 0x24]
L_926028:
	brhs r3,r16,L_926034
L_92602c:
	extb r3,r16
L_926030:
	stb r16,[r1, 0x24]
	.global L_926034
L_926034:
	ld_s r13,[r1]
L_926036:
	breq_s r15,0,L_92603c
L_926038:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_92603a:
	st_s r13,[r1]
	.global L_92603c
L_92603c:
	mov_s r1,0x1001cec
L_926042:
	mov_s r0,0x11
L_926044:
	mov_s r2,r16
L_926046:
	bl.d L_92d338
L_92604a:
	mov_s r4,r13
L_92604c:
	ld_s r0,[sp,0x0]
L_92604e:
	bl.d L_925c0c
L_926052:
	mov_s r1,r17
L_926054:
	ld_s r0,[sp,0x0]
L_926056:
	ld_s r1,[sp,0x4]
L_926058:
	bl.d L_925b7c
L_92605c:
	mov_s r2,r17
L_92605e:
	mov_s r1,0x1001d2c
L_926064:
	bl.d L_92d13c
L_926068:
	mov_s r0,0x11
L_92606a:
	ld_s r0,[sp,0x0]
L_92606c:
	bl.d L_925c0c
L_926070:
	mov_s r1,r17
L_926072:
	b.d L_920274
L_926076:
	add_s sp,sp,0x14
	.global L_926078
L_926078:
	mov r0,0x320
	.global L_92607c
L_92607c:
	mov lp_count,r0
L_926080:
	nop_s
L_926082:
	lp L_92608a
L_926086:
	nop_s
L_926088:
	nop_s
	.global L_92608a
L_92608a:
	b_s L_92600a
	.global L_92608c
L_92608c:
	mov_s r0,blink
L_92608e:
	mov_s r1,0x158f
L_926094:
	bl L_926618
L_926098:
	b_s L_92601e
L_92609a:
	nop_s
