/* scan_mngr__dband_beacon_ind @ 0x8c6dc8, 480 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::dband_beacon_ind() uCode mailbox is full, ignore this beacon indication BSSID: ADDR-%04X%08X
 *   scan_mngr::dband_beacon_ind() Scan while connect. Ignoring beacon of BSSID#%x%x MID#%d.
 *   scan_mngr::dband_beacon_ind() exit. maximum allocation for pending list is WMI_MAX_ASSOC_STA(8)
 *   scan_mngr::dband_beacon_ind() exit. p_dband_info == NULL
 *   scan_mngr::dband_beacon_ind() Adding DMG BEACON from BSSID: ADDR-%04X%08X discovery_mode=%d.
 *   [NNL] container:%d
 *   scan_mngr::dband_beacon_ind() no probing in passive scan
 *   scan_mngr::dband_beacon_ind() trigger start_connection_cb.
 * Зовут его: discovery__handle_rx_frame
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, alloc_dband_info, bitmap__alloc_bit, bitmap__any_free, bitmap__init, fw_log__emit0, fw_log__emit1, fw_log__emit2, fw_log__emit3, get_g_800242, llist__insert
 */
	.section .text.scan_mngr__dband_beacon_ind,"ax",@progbits
	.global scan_mngr__dband_beacon_ind
scan_mngr__dband_beacon_ind:
	.global L_8c6dc8
L_8c6dc8:
	push_s blink
L_8c6dca:
	bl L_8c02b4
L_8c6dce:
	mov_s r15,r0
L_8c6dd0:
	ld_s r0,[r1,0xc]
L_8c6dd2:
	ld_s r13,[r1,0x8]
L_8c6dd4:
	ld r0,[r0, 0xc0]
L_8c6dd8:
	mov_s r17,r1
L_8c6dda:
	ldb_s r0,[r0]
L_8c6ddc:
	sub_s sp,sp,0x4
L_8c6dde:
	lsr r18,r0
L_8c6de2:
	ld r0,[r15, 0x84]
L_8c6de6:
	ldb_s r0,[r0]
L_8c6de8:
	cmp_s r0,0x4
L_8c6dea:
	/* add_s r13,0x4 */
	.byte 0x04,0xe5
L_8c6dec:
	bne_s L_8c6fa0
L_8c6dee:
	ld r0,[r15, 0x88]
L_8c6df2:
	cmp_s r0,0x1
L_8c6df4:
	beq_s L_8c6fa0
L_8c6df6:
	bl L_8ca258
L_8c6dfa:
	mov_s r1,r0
L_8c6dfc:
	mov_s r0,sp
L_8c6dfe:
	bl.d L_8e1140
L_8c6e02:
	mov_s r16,r0
L_8c6e04:
	b_s L_8c6e1a
	.global L_8c6e06
L_8c6e06:
	bl.d L_8db194
L_8c6e0a:
	mov_s r0,r16
L_8c6e0c:
	bl L_8ca1b0
L_8c6e10:
	mov_s r14,r0
L_8c6e12:
	bl.d L_8ca1f8
L_8c6e16:
	mov_s r1,0x1
L_8c6e18:
	brne_s r0,0,L_8c6e50
	.global L_8c6e1a
L_8c6e1a:
	bl.d L_8cb680
L_8c6e1e:
	mov_s r0,r16
L_8c6e20:
	brne_s r0,0,L_8c6e06
L_8c6e22:
	mov_s r0,0x805d88
L_8c6e28:
	ldw_s r1,[r0,0x14]
L_8c6e2a:
	mov_s r16,r0
L_8c6e2c:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8c6e2e:
	extw_s r1,r1
L_8c6e30:
	bl.d L_8d85cc
L_8c6e34:
	stw_s r1,[r0,0x14]
L_8c6e36:
	brne r0,0x1,L_8c6e9e
L_8c6e3a:
	mov_s r2,0x1013140
L_8c6e40:
	ldw r4,[r13, 0x4]
L_8c6e44:
	mov_s r0,0x9
L_8c6e46:
	mov_s r1,0x1
L_8c6e48:
	bl.d L_8edff8
L_8c6e4c:
	ld_s r3,[r13]
L_8c6e4e:
	b_s L_8c6fa0
	.global L_8c6e50
L_8c6e50:
	add2 r1,r14,0x15
L_8c6e54:
	ldb_s r2,[r1]
L_8c6e56:
	ldb_s r0,[r13]
L_8c6e58:
	brne r2,r0,L_8c6e1a
L_8c6e5c:
	ldb_s r2,[r1,0x1]
L_8c6e5e:
	ldb_s r0,[r13,0x1]
L_8c6e60:
	brne r2,r0,L_8c6e1a
L_8c6e64:
	ldb_s r2,[r1,0x2]
L_8c6e66:
	ldb_s r0,[r13,0x2]
L_8c6e68:
	brne r2,r0,L_8c6e1a
L_8c6e6c:
	ldb_s r2,[r1,0x3]
L_8c6e6e:
	ldb_s r0,[r13,0x3]
L_8c6e70:
	brne r2,r0,L_8c6e1a
L_8c6e74:
	ldb_s r2,[r1,0x4]
L_8c6e76:
	ldb_s r0,[r13,0x4]
L_8c6e78:
	brne r2,r0,L_8c6e1a
L_8c6e7c:
	ldb_s r1,[r1,0x5]
L_8c6e7e:
	ldb_s r0,[r13,0x5]
L_8c6e80:
	brne r1,r0,L_8c6e1a
L_8c6e84:
	ldb r5,[r14, 0x10]
L_8c6e88:
	mov_s r2,0x10131a8
L_8c6e8e:
	ldw r4,[r13, 0x4]
L_8c6e92:
	mov_s r0,0x9
L_8c6e94:
	mov_s r1,0x2
L_8c6e96:
	bl.d L_8ee034
L_8c6e9a:
	ld_s r3,[r13]
L_8c6e9c:
	b_s L_8c6fa0
	.global L_8c6e9e
L_8c6e9e:
	mov_s r0,r15
L_8c6ea0:
	bl.d L_8f020c
L_8c6ea4:
	mov_s r1,r13
L_8c6ea6:
	cmp_s r0,0x0
L_8c6ea8:
	bne_s L_8c6fa0
L_8c6eaa:
	add r0,r15,0xc
L_8c6eae:
	bl.d L_8f020c
L_8c6eb2:
	mov_s r1,r13
L_8c6eb4:
	brne r0,0x0,L_8c6fa0
L_8c6eb8:
	ld_s r0,[r15]
L_8c6eba:
	brlo r0,0x8,L_8c6ece
L_8c6ebe:
	mov_s r2,0x1013200
	.global L_8c6ec4
L_8c6ec4:
	mov_s r0,0x9
L_8c6ec6:
	bl.d L_8edfb0
L_8c6eca:
	mov_s r1,0x1
L_8c6ecc:
	b_s L_8c6fa0
	.global L_8c6ece
L_8c6ece:
	bl L_8e94a4
L_8c6ed2:
	mov.f r14,r0
L_8c6ed6:
	bne_s L_8c6ee0
L_8c6ed8:
	mov_s r2,0x1013260
L_8c6ede:
	b_s L_8c6ec4
	.global L_8c6ee0
L_8c6ee0:
	add r0,r14,0x8
L_8c6ee4:
	mov_s r1,r13
L_8c6ee6:
	bl.d L_8c0460
L_8c6eea:
	mov_s r2,0x6
L_8c6eec:
	mov_s r0,0x3
L_8c6eee:
	add r13,r14,0x20
L_8c6ef2:
	stb_s r0,[r13,0x18]
L_8c6ef4:
	mov_s r0,0x1
L_8c6ef6:
	stb_s r0,[r13,0x19]
L_8c6ef8:
	mov_s r0,0x0
L_8c6efa:
	st_s r0,[r14,0x3c]
L_8c6efc:
	ld r1,[r17, 0xc]
L_8c6f00:
	breq_s r1,0,L_8c6f1a
L_8c6f02:
	ldb_s r2,[r1,0x9]
L_8c6f04:
	brlt r2,0x1,L_8c6f1a
L_8c6f08:
	add r0,r14,0x10
L_8c6f0c:
	bl.d L_8c0460
L_8c6f10:
	ld_s r1,[r1,0xc]
L_8c6f12:
	ld r0,[r17, 0xc]
L_8c6f16:
	ldb_s r0,[r0,0x9]
L_8c6f18:
	stb_s r0,[r13,0x10]
	.global L_8c6f1a
L_8c6f1a:
	mov_s r0,r15
L_8c6f1c:
	bl.d L_8c1fc4
L_8c6f20:
	mov_s r1,r14
L_8c6f22:
	ldw r0,[r16, 0x16]
L_8c6f26:
	mov_s r2,0x101329c
L_8c6f2c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c6f2e:
	extw_s r0,r0
L_8c6f30:
	stw r0,[r16, 0x16]
L_8c6f34:
	ld r4,[r14, 0x8]
L_8c6f38:
	mov_s r0,0x9
L_8c6f3a:
	ldw_s r3,[r14,0xc]
L_8c6f3c:
	mov_s r1,0x2
L_8c6f3e:
	bl.d L_8ee034
L_8c6f42:
	bmsk r5,r18,0x0
L_8c6f46:
	mov_s r2,0x10132fc
L_8c6f4c:
	mov_s r0,0x9
L_8c6f4e:
	mov_s r1,0x2
L_8c6f50:
	bl.d L_8edfcc
L_8c6f54:
	ld_s r3,[r14,0x4]
L_8c6f56:
	ld r0,[r17, 0x8]
L_8c6f5a:
	bl.d L_8c7f90
L_8c6f5e:
	ld r1,[r17, 0x30]
L_8c6f62:
	ld_s r0,[r15,0x6c]
L_8c6f64:
	cmp_s r0,0x2
L_8c6f66:
	mov_s r0,0x1
L_8c6f68:
	sub_s.ne r0,r0,r0
L_8c6f6a:
	extb.f 0x0,r0
L_8c6f6e:
	beq_s L_8c6f82
L_8c6f70:
	mov_s r2,0x1013310
L_8c6f76:
	mov_s r0,0x9
L_8c6f78:
	bl.d L_8edfb0
L_8c6f7c:
	mov_s r1,0x2
L_8c6f7e:
	mov_s r0,0x1
L_8c6f80:
	b_s L_8c6fa2
	.global L_8c6f82
L_8c6f82:
	mov_s r2,0x101334c
L_8c6f88:
	mov_s r0,0x9
L_8c6f8a:
	bl.d L_8edfb0
L_8c6f8e:
	mov_s r1,0x2
L_8c6f90:
	mov_s r0,0x31280
L_8c6f96:
	mov_s r1,r15
L_8c6f98:
	mov_s r2,r14
L_8c6f9a:
	bl.d L_8c2ac8
L_8c6f9e:
	mov_s r3,0x1
	.global L_8c6fa0
L_8c6fa0:
	mov_s r0,0x0
	.global L_8c6fa2
L_8c6fa2:
	b.d L_8c0314
L_8c6fa6:
	add_s sp,sp,0x4
