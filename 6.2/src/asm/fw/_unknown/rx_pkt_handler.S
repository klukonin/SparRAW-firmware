/* rx_pkt_handler @ 0x8e3d08, 516 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rx_pkt_handler invalid cid , stype %x length %d- drop pkt
 *   rx_pkt_handler cid %d,  assoc req, split_mac_en=%d
 *   Received  ASSOC_REQ while disconnecting - packet will be dropped.
 *   Received redundant ASSOC_REQ with retry bit set - packet will be dropped
 *   <<---- [HOST EVENT] WMI_RX_MGMT_PACKET_EVENTID ASSOC Req pkt Pass to host %d
 *   <<---- [HOST EVENT] WMI_RX_MGMT_PACKET_EVENTID DISASSOC pkt Pass to host %d
 *   m_assoc_sent = %d
 *   saving disassoc pkt
 * Зовут его: rx_mgmt_srvs__distribute
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, basic_sm__handle_event, conn_mgr__by_cid, fw_log_emit0, fw_log_emit1, fw_log_emit2, fw_log_emit3, fw_sysassert_fatal, low_sme__send_evt2sw, mem_pool__free_thunk, mgmt_pkt__release
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_pkt_handler
rx_pkt_handler:
	.global L_8e3d08
L_8e3d08:
	push_s blink
L_8e3d0a:
	bl L_8c01d0
L_8e3d0e:
	mov_s r14,r0
L_8e3d10:
	add r16,r0,0x20
L_8e3d14:
	bl.d L_8cc3dc
L_8e3d18:
	ldb r0,[r16, 0x15]
L_8e3d1c:
	bl.d L_8cbffc
L_8e3d20:
	ldb r0,[r16, 0x16]
L_8e3d24:
	mov_s r13,r0
L_8e3d26:
	bl.d L_8e3c3c
L_8e3d2a:
	mov_s r0,r14
L_8e3d2c:
	ld_s r0,[r14,0x8]
L_8e3d2e:
	ldw_s r3,[r0]
L_8e3d30:
	lsr_s r3,r3,0x4
L_8e3d32:
	bmsk_s r3,r3,0x3
L_8e3d34:
	brne_s r13,0,L_8e3d48
L_8e3d36:
	mov_s r1,0x10110f4
L_8e3d3c:
	mov_s r0,0x1a
L_8e3d3e:
	mov_s r2,r3
L_8e3d40:
	bl.d L_8dcc80
L_8e3d44:
	ld_s r3,[r14,0x30]
L_8e3d46:
	b_s L_8e3e20
	.global L_8e3d48
L_8e3d48:
	cmp_s r3,0xa
L_8e3d4a:
	bhi L_8e3eec
L_8e3d4e:
	ldb r10,[0x802540,r3]
L_8e3d56:
	add r0,pcl,0xc
L_8e3d5a:
	add1 r0,r0,r10
L_8e3d5e:
	j_s [r0]
L_8e3d60:
	ldb_s r2,[r13,0x8]
L_8e3d62:
	mov_s r1,0x1011130
L_8e3d68:
	mov_s r0,0x2a
L_8e3d6a:
	mov r17,0x803c20
L_8e3d72:
	bl.d L_8dcc80
L_8e3d76:
	ldb r3,[r17, 0x8]
L_8e3d7a:
	ldb r0,[r13,0x124]
L_8e3d82:
	mov_s r15,0x0
L_8e3d84:
	brne r0,0x8,L_8e3d96
L_8e3d88:
	mov_s r15,0x1
L_8e3d8a:
	mov_s r1,0x1011164
L_8e3d90:
	bl.d L_8dcba8
L_8e3d94:
	mov_s r0,0x1a
	.global L_8e3d96
L_8e3d96:
	mov_s r18,r15
L_8e3d98:
	add3 r15,r13,0x1e
L_8e3d9c:
	ld_s r0,[r15,0xc]
L_8e3d9e:
	brne_s r0,0,L_8e3da4
	.global L_8e3da0
L_8e3da0:
	mov_s r0,0x0
L_8e3da2:
	b_s L_8e3dbe
	.global L_8e3da4
L_8e3da4:
	ld_s r0,[r14,0x8]
L_8e3da6:
	ldb_s r0,[r0,0x1]
L_8e3da8:
	bbit0 r0,0x3,L_8e3da0
L_8e3dac:
	mov r19,0x1
L_8e3db0:
	mov_s r1,0x10111a8
L_8e3db6:
	bl.d L_8dcba8
L_8e3dba:
	mov_s r0,0x1a
L_8e3dbc:
	mov_s r0,r19
	.global L_8e3dbe
L_8e3dbe:
	ld_s r2,[r13,0x18]
L_8e3dc0:
	ld_s r2,[r2,0x50]
L_8e3dc2:
	mov_s r1,0x0
L_8e3dc4:
	cmp_s r2,0x2
L_8e3dc6:
	cmp.ne r2,0x3
L_8e3dca:
	mov.eq r1,0x1
L_8e3dce:
	extb.f 0x0,r1
L_8e3dd2:
	beq_s L_8e3e20
L_8e3dd4:
	cmp_s r0,0x0
L_8e3dd6:
	cmp.eq r18,0x0
L_8e3dda:
	bne_s L_8e3e20
L_8e3ddc:
	ldb r0,[r17, 0x8]
L_8e3de0:
	brne r0,0x1,L_8e3e1a
L_8e3de4:
	mov_s r1,0x10111f4
L_8e3dea:
	bl.d L_8dcba8
L_8e3dee:
	mov_s r0,0x2a
L_8e3df0:
	ld_s r2,[r14,0x30]
L_8e3df2:
	add r0,r14,0x28
L_8e3df6:
	add_s r2,r2,0x10
L_8e3df8:
	extw_s r2,r2
L_8e3dfa:
	mov_s r1,0x61
L_8e3dfc:
	/* asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_8e3dfe:
	ldb r3,[r16, 0x15]
L_8e3e02:
	mov r4,0x1
L_8e3e06:
	mov r5,0x0
L_8e3e0a:
	bl.d L_8e5474
L_8e3e0e:
	mov r6,r4
L_8e3e12:
	st_s r14,[r15,0x30]
L_8e3e14:
	mov_s r0,r15
L_8e3e16:
	mov_s r1,0x9
L_8e3e18:
	b_s L_8e3ecc
	.global L_8e3e1a
L_8e3e1a:
	mov_s r0,r15
L_8e3e1c:
	mov_s r1,0x0
L_8e3e1e:
	b_s L_8e3e4a
	.global L_8e3e20
L_8e3e20:
	bl.d L_8cb180
L_8e3e24:
	mov_s r0,r14
L_8e3e26:
	bl.d L_8cb15c
L_8e3e2a:
	mov_s r0,r14
L_8e3e2c:
	b_s L_8e3f08
L_8e3e2e:
	add3 r0,r13,0x1e
L_8e3e32:
	ld_s r1,[r0,0xc]
L_8e3e34:
	breq_s r1,0,L_8e3e20
L_8e3e36:
	ldb_s r2,[r0]
L_8e3e38:
	breq r2,0x2,L_8e3e20
L_8e3e3c:
	ld_s r1,[r14,0xc]
L_8e3e3e:
	ldw r1,[r1, 0xcc]
L_8e3e42:
	brne_s r1,0,L_8e3e4e
L_8e3e44:
	breq r2,0x1,L_8e3e20
L_8e3e48:
	mov_s r1,0x4
	.global L_8e3e4a
L_8e3e4a:
	mov_s r2,r14
L_8e3e4c:
	b_s L_8e3ece
	.global L_8e3e4e
L_8e3e4e:
	mov_s r1,0x5
L_8e3e50:
	b_s L_8e3e4a
L_8e3e52:
	ldb r0,[r13,0x124]
L_8e3e5a:
	breq r0,0x8,L_8e3ede
L_8e3e5e:
	ldb.a r0,[r13,0xf0]
L_8e3e62:
	brne_s r0,0,L_8e3e6a
L_8e3e64:
	ld_s r0,[r13,0xc]
L_8e3e66:
	breq r0,0x0,L_8e3ede
	.global L_8e3e6a
L_8e3e6a:
	mov_s r0,0x803c20
L_8e3e70:
	ldb_s r0,[r0,0x8]
L_8e3e72:
	brne r0,0x1,L_8e3ed8
L_8e3e76:
	mov_s r1,0x1011244
L_8e3e7c:
	bl.d L_8dcba8
L_8e3e80:
	mov_s r0,0x2a
L_8e3e82:
	ld_s r2,[r14,0x30]
L_8e3e84:
	add r0,r14,0x28
L_8e3e88:
	add_s r2,r2,0x10
L_8e3e8a:
	extw_s r2,r2
L_8e3e8c:
	mov_s r1,0x61
L_8e3e8e:
	/* asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_8e3e90:
	ldb r3,[r16, 0x15]
L_8e3e94:
	mov r4,0x1
L_8e3e98:
	mov r5,0x0
L_8e3e9c:
	bl.d L_8e5474
L_8e3ea0:
	mov r6,r4
L_8e3ea4:
	mov_s r1,0x1011290
L_8e3eaa:
	mov_s r0,0x2a
L_8e3eac:
	bl.d L_8dcc10
L_8e3eb0:
	ld_s r2,[r13,0xc]
L_8e3eb2:
	ld_s r0,[r13,0xc]
L_8e3eb4:
	breq_s r0,0,L_8e3ed8
L_8e3eb6:
	mov_s r1,0x10112a4
L_8e3ebc:
	bl.d L_8dcba8
L_8e3ec0:
	mov_s r0,0x2a
L_8e3ec2:
	st_s r14,[r13,0x30]
L_8e3ec4:
	mov_s r0,0x8
L_8e3ec6:
	stw_s r0,[r13,0x2a]
L_8e3ec8:
	mov_s r0,r13
L_8e3eca:
	mov_s r1,0xc
	.global L_8e3ecc
L_8e3ecc:
	mov_s r2,0x0
	.global L_8e3ece
L_8e3ece:
	mov_s r3,0x0
L_8e3ed0:
	bl.d L_8d9b6c
L_8e3ed4:
	mov_s r4,r3
L_8e3ed6:
	b_s L_8e3f08
	.global L_8e3ed8
L_8e3ed8:
	mov_s r0,r13
L_8e3eda:
	mov_s r1,0x2
L_8e3edc:
	b_s L_8e3e4a
	.global L_8e3ede
L_8e3ede:
	mov_s r1,0x10112b8
L_8e3ee4:
	bl.d L_8dcba8
L_8e3ee8:
	mov_s r0,0x1a
L_8e3eea:
	b_s L_8e3e20
	.global L_8e3eec
L_8e3eec:
	mov_s r1,0x10112fc
L_8e3ef2:
	ld r4,[r14, 0x30]
L_8e3ef6:
	mov_s r0,0x1a
L_8e3ef8:
	bl.d L_8dcd00
L_8e3efc:
	ldb_s r2,[r13,0x8]
L_8e3efe:
	mov_s r0,blink
L_8e3f00:
	mov_s r1,0x9
L_8e3f02:
	bl.d L_8c9b28
L_8e3f06:
	asl_s r1,r1,0x9
	.global L_8e3f08
L_8e3f08:
	b L_8c022c
