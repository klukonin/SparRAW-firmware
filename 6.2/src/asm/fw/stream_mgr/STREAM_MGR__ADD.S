/* STREAM_MGR__ADD @ 0x8c2dc4, 612 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   STREAM_MGR::ADD VRING to already added Vring index  %d.
 *   STREAM_MGR::Automatic BA AGREEMENT  of window %d, max_msdu_size %d
 *   STREAM_MGR:: wrong window %d (max_msdu_size %d).
 *   STREAM_MGR::VRING was added with IMM ACK policy (max_msdu_size = %d)
 *   ADD_VRING completed: V-ring #%d cid = %d mac_qid=%d
 *   vring_schd_ucode::ADD_VRING completed: V-ring #%d cid = %d mac_qid=%d
 * Зовут его: wmi_vring_cfg
 * Зовёт сам: __ld_r16_to_r13_ret, __ld_r19_to_r13_ret, __ld_r21_to_r13_ret, __st_r16_to_r13, __st_r19_to_r13, __st_r21_to_r13, conn_mgr__by_cid, fw_log_emit1, fw_log_emit2, fw_log_emit3, fw_sysassert_fatal, hwd_dma__macq_reg_addr
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global STREAM_MGR__ADD
STREAM_MGR__ADD:
	.global L_8c2dc4
L_8c2dc4:
	push_s blink
L_8c2dc6:
	bl L_8c01d0
L_8c2dca:
	mov_s r18,r0
L_8c2dcc:
	mov_s r17,r1
L_8c2dce:
	mov_s r16,r2
L_8c2dd0:
	ldb_s r14,[r0,0x7]
L_8c2dd2:
	ldb_s r0,[r1,0xd]
L_8c2dd4:
	bl.d L_8cbffc
L_8c2dd8:
	bmsk_s r0,r0,0x3
L_8c2dda:
	mov.f r13,r0
L_8c2dde:
	beq_s L_8c2e12
	.global L_8c2de0
L_8c2de0:
	mov_s r0,0x847f34
L_8c2de6:
	add2_s r0,r0,r14
L_8c2de8:
	ld_s r1,[r0,0x4c]
L_8c2dea:
	breq_s r1,0,L_8c2e20
L_8c2dec:
	mov_s r1,0x1010a3c
L_8c2df2:
	mov_s r0,0x2b
L_8c2df4:
	bl.d L_8dcc10
L_8c2df8:
	mov_s r2,r14
L_8c2dfa:
	bl.d L_8d083c
L_8c2dfe:
	mov_s r0,r14
L_8c2e00:
	mov_s r1,r0
L_8c2e02:
	ld_s r3,[r13,0x18]
L_8c2e04:
	mov_s r0,r14
L_8c2e06:
	mov_s r2,0x1
L_8c2e08:
	bl.d L_8f8e98
L_8c2e0c:
	ldb_s r3,[r3,0x10]
L_8c2e0e:
	mov_s r15,0x1
L_8c2e10:
	b_s L_8c2ef4
	.global L_8c2e12
L_8c2e12:
	mov_s r0,blink
L_8c2e14:
	mov_s r1,0x128a
L_8c2e1a:
	bl L_8c9b28
L_8c2e1e:
	b_s L_8c2de0
	.global L_8c2e20
L_8c2e20:
	st r18,[r0, 0x4c]
L_8c2e24:
	add3 r1,r13,0x1e
L_8c2e28:
	ldb_s r0,[r1]
L_8c2e2a:
	breq r0,0x2,L_8c2e34
L_8c2e2e:
	ld_s r0,[r1,0xc]
L_8c2e30:
	breq r0,0x0,L_8c2ebe
	.global L_8c2e34
L_8c2e34:
	ldb_s r0,[r13,0xa]
L_8c2e36:
	mov r19,0x1
L_8c2e3a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c2e3c:
	bl.d L_8cd080
L_8c2e40:
	stb_s r0,[r13,0xa]
L_8c2e42:
	ld_s r1,[r0]
L_8c2e44:
	add r3,r17,0x14
L_8c2e48:
	ld r5,[r1, 0xc]
L_8c2e4c:
	mov_s r1,r17
L_8c2e4e:
	mov_s r2,r18
L_8c2e50:
	jl.d [r5]
L_8c2e54:
	mov r4,r19
L_8c2e58:
	ldb_s r0,[r13,0x8]
L_8c2e5a:
	bl.d L_8dfc34
L_8c2e5e:
	mov_s r1,0x2
L_8c2e60:
	ldb r2,[r17, 0x13]
L_8c2e64:
	breq_s r2,0,L_8c2eac
L_8c2e66:
	mul64 r2,r16
L_8c2e6a:
	brlt 0x14000,mlo,L_8c2e9a
L_8c2e72:
	mov_s r1,0x1010a74
L_8c2e78:
	mov_s r0,0x2b
L_8c2e7a:
	bl.d L_8dcc80
L_8c2e7e:
	mov_s r3,r16
L_8c2e80:
	ld r0,[r18, 0x68]
L_8c2e84:
	ldb r1,[r17, 0x13]
L_8c2e88:
	mov_s r2,0x0
L_8c2e8a:
	ld r4,[r0, 0x18]
L_8c2e8e:
	mov_s r0,r18
L_8c2e90:
	jl.d [r4]
L_8c2e94:
	mov_s r3,0x0
L_8c2e96:
	mov_s r15,0x0
L_8c2e98:
	b_s L_8c2ec0
	.global L_8c2e9a
L_8c2e9a:
	mov_s r1,0x1010ab8
L_8c2ea0:
	mov_s r0,0x2b
L_8c2ea2:
	bl.d L_8dcc80
L_8c2ea6:
	mov_s r3,r16
L_8c2ea8:
	mov_s r15,r19
L_8c2eaa:
	b_s L_8c2ec0
	.global L_8c2eac
L_8c2eac:
	mov_s r1,0x1010aec
L_8c2eb2:
	mov_s r0,0x2b
L_8c2eb4:
	bl.d L_8dcc10
L_8c2eb8:
	mov_s r2,r16
L_8c2eba:
	mov_s r15,0x0
L_8c2ebc:
	b_s L_8c2ec0
	.global L_8c2ebe
L_8c2ebe:
	mov_s r15,0x1
	.global L_8c2ec0
L_8c2ec0:
	bl.d L_8d083c
L_8c2ec4:
	mov_s r0,r14
L_8c2ec6:
	mov_s r1,r0
L_8c2ec8:
	ld_s r3,[r13,0x18]
L_8c2eca:
	extb_s r2,r15
L_8c2ecc:
	mov_s r0,r14
L_8c2ece:
	bl.d L_8f8e98
L_8c2ed2:
	ldb_s r3,[r3,0x10]
L_8c2ed4:
	brne_s r15,0,L_8c2ef4
L_8c2ed6:
	ldb r0,[r13,0x124]
L_8c2ede:
	cmp_s r0,0x7
L_8c2ee0:
	mov_s r0,0x1
L_8c2ee2:
	sub_s.ne r0,r0,r0
L_8c2ee4:
	extb.f 0x0,r0
L_8c2ee8:
	beq_s L_8c2ef4
L_8c2eea:
	ld_s r1,[r13,0x18]
L_8c2eec:
	mov_s r0,r14
L_8c2eee:
	bl.d L_8f8ee4
L_8c2ef2:
	ldb_s r1,[r1,0x10]
	.global L_8c2ef4
L_8c2ef4:
	b.d L_8c022c
L_8c2ef8:
	mov_s r0,r15
L_8c2efa:
	nop_s
L_8c2efc:
	push_s blink
L_8c2efe:
	bl L_8c01c8
L_8c2f02:
	mov_s r17,r1
L_8c2f04:
	mov_s r14,r2
L_8c2f06:
	mov_s r15,r3
L_8c2f08:
	mov_s r0,0x804da8
L_8c2f0e:
	bl.d L_8c354c
L_8c2f12:
	mov r21,r4
L_8c2f16:
	mov.f r13,r0
L_8c2f1a:
	beq_s L_8c2f44
	.global L_8c2f1c
L_8c2f1c:
	mov_s r0,0x804dc0
L_8c2f22:
	bl.d L_8c25f4
L_8c2f26:
	mov_s r1,r13
L_8c2f28:
	ldb r19,[r14, 0x7]
L_8c2f2c:
	bl.d L_8cbed8
L_8c2f30:
	mov_s r0,r14
L_8c2f32:
	ld r20,[r14, 0xc]
L_8c2f36:
	mov_s r16,r0
L_8c2f38:
	mov_s r0,0x0
L_8c2f3a:
	breq r20,0x0,L_8c2f52
L_8c2f3e:
	mov_s r18,r0
L_8c2f40:
	mov_s r15,r0
L_8c2f42:
	b_s L_8c2f5a
	.global L_8c2f44
L_8c2f44:
	mov_s r0,blink
L_8c2f46:
	mov_s r1,0x12b7
L_8c2f4c:
	bl L_8c9b28
L_8c2f50:
	b_s L_8c2f1c
	.global L_8c2f52
L_8c2f52:
	breq_s r15,0,L_8c2fc0
	.global L_8c2f54
L_8c2f54:
	ldw r18,[r15]
L_8c2f58:
	ldw_s r15,[r15,0x2]
	.global L_8c2f5a
L_8c2f5a:
	bl.d L_8e292c
L_8c2f5e:
	mov_s r0,r19
L_8c2f60:
	ld r1,[r17]
L_8c2f64:
	mov_s r0,r19
L_8c2f66:
	ld r2,[r17, 0x4]
L_8c2f6a:
	bl.d L_8d0d0c
L_8c2f6e:
	ldw r3,[r17, 0x8]
L_8c2f72:
	extb r2,r16
L_8c2f76:
	mov_s r0,0x3
L_8c2f78:
	mov_s r17,r0
L_8c2f7a:
	mov_s r1,0x0
L_8c2f7c:
	mov_s r3,r19
L_8c2f7e:
	mov_s r4,r1
L_8c2f80:
	mov_s r5,r1
L_8c2f82:
	bl.d L_8dbb60
L_8c2f86:
	mov_s r6,r1
L_8c2f88:
	bl.d L_8ccfd8
L_8c2f8c:
	mov_s r0,r19
L_8c2f8e:
	stb r17,[r0, 0xc]
L_8c2f92:
	mov_s r1,0x100bb3c
L_8c2f98:
	mov_s r0,0x27
L_8c2f9a:
	mov_s r2,r19
L_8c2f9c:
	mov_s r3,r16
L_8c2f9e:
	bl.d L_8dcd00
L_8c2fa2:
	mov r4,r19
L_8c2fa6:
	extw r2,r18
L_8c2faa:
	extw_s r3,r15
L_8c2fac:
	mov_s r0,r13
L_8c2fae:
	mov_s r1,r14
L_8c2fb0:
	mov r4,r20
L_8c2fb4:
	bl.d L_8e78cc
L_8c2fb8:
	mov r5,r21
L_8c2fbc:
	b L_8c021c
	.global L_8c2fc0
L_8c2fc0:
	mov_s r0,blink
L_8c2fc2:
	mov_s r1,0x29
L_8c2fc4:
	/* bl.d 0x008c9b28 */
	.byte 0x66,0x0b,0x60,0x03
L_8c2fc8:
	/* _asl_s r1,r1,0x7 */
	.byte 0x07,0xb9
L_8c2fca:
	b_s L_8c2f54
L_8c2fcc:
	push_s blink
L_8c2fce:
	bl L_8c01dc
L_8c2fd2:
	mov_s r15,r0
L_8c2fd4:
	mov_s r14,r1
L_8c2fd6:
	ldb r16,[r2, 0x7]
L_8c2fda:
	bl.d L_8cbed8
L_8c2fde:
	mov_s r0,r2
L_8c2fe0:
	mov_s r13,r0
L_8c2fe2:
	/* add_s r15,0x4 */
	.byte 0x04,0xe7
L_8c2fe4:
	add_s r15,r15,r0
L_8c2fe6:
	stb r16,[r15]
L_8c2fea:
	bl.d L_8d09a0
L_8c2fee:
	mov_s r0,r16
L_8c2ff0:
	ld_s r1,[r14]
L_8c2ff2:
	mov_s r0,r16
L_8c2ff4:
	ld_s r2,[r14,0x4]
L_8c2ff6:
	bl.d L_8d0d0c
L_8c2ffa:
	ldw_s r3,[r14,0x8]
L_8c2ffc:
	extb_s r2,r13
L_8c2ffe:
	mov_s r0,0x3
L_8c3000:
	mov_s r1,0x0
L_8c3002:
	mov_s r3,r16
L_8c3004:
	mov_s r4,r1
L_8c3006:
	mov_s r5,r1
L_8c3008:
	bl.d L_8dbb60
L_8c300c:
	mov_s r6,r1
L_8c300e:
	mov_s r1,0x100bca8
L_8c3014:
	mov_s r0,0x27
L_8c3016:
	mov_s r2,r16
L_8c3018:
	mov_s r3,r13
L_8c301a:
	bl.d L_8dcd00
L_8c301e:
	mov r4,r16
L_8c3022:
	b L_8c0244
L_8c3026:
	nop_s
