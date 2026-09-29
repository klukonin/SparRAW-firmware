/* link_stats__report @ 0x8e7cf8, 360 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   LINK_STATS CID:%u MCS0_FRAMES_CRC_OK=%d MCS0_FRAMES_CRC_ERR=%d
 *   LINK_STATS TX_GOODPUT=%d RX_GOODPUT=%d PER=%d
 *   per(%u) too big for too long(%u) request bf for cid:%u
 * Зовут его: sm_802f58__action_8e0048, sm_802f58__action_8e2be4
 * Зовёт сам: __ld_r22_to_r13_ret, __st_r22_to_r13, conn__get_cid_via_field8, fw_divmod64_signed, fw_log_emit3, led__update_by_link_rate, link_stats__calc_goodput, link_stats__counter64_a_thunk, link_stats__counter64_b_thunk, link_stats__phy_counters, link_stats_sm__arm_report_timer, mac_rx_cnt__get_mcs0_crc_err
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global link_stats__report
link_stats__report:
	.global L_8e7cf8
L_8e7cf8:
	push_s blink
L_8e7cfa:
	bl L_8c01c4
L_8e7cfe:
	sub_s sp,sp,0x10
L_8e7d00:
	mov_s r13,r0
L_8e7d02:
	mov_s r22,r1
L_8e7d04:
	bl.d L_8cbec0
L_8e7d08:
	ld_s r0,[r0,0x10]
L_8e7d0a:
	mov r21,0x0
L_8e7d0e:
	extb_s r0,r0
L_8e7d10:
	bl.d L_8e9524
L_8e7d14:
	st_s r0,[sp,0x0]
L_8e7d16:
	mov_s r20,r0
L_8e7d18:
	bl.d L_8ccf78
L_8e7d1c:
	mov_s r0,r13
L_8e7d1e:
	mov_s r16,r0
L_8e7d20:
	mov_s r18,r1
L_8e7d22:
	bl.d L_8ccb64
L_8e7d26:
	mov_s r0,r13
L_8e7d28:
	mov_s r19,r0
L_8e7d2a:
	mov_s r17,r1
L_8e7d2c:
	bl.d L_8e0288
L_8e7d30:
	mov_s r0,r21
L_8e7d32:
	ld_s r1,[r13,0x38]
L_8e7d34:
	ld_s r2,[r13,0x18]
L_8e7d36:
	sub r0,r20,r1
L_8e7d3a:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8e7d3c:
	ld_s r1,[r13,0x14]
L_8e7d3e:
	st_s r0,[sp,0x4]
L_8e7d40:
	sub.f r0,r16,r1
L_8e7d44:
	sbc r1,r18,r2
L_8e7d48:
	bl.d L_8c05f4
L_8e7d4c:
	mov_s r2,0x3
L_8e7d4e:
	ld_s r2,[sp,0x4]
L_8e7d50:
	bl.d L_8c047c
L_8e7d54:
	mov_s r3,r21
L_8e7d56:
	st_s r0,[r13,0x1c]
L_8e7d58:
	mov_s r15,0x880a3c
L_8e7d5e:
	st_s r0,[r15,0x1c]
L_8e7d60:
	ld r4,[r13, 0x20]
L_8e7d64:
	ld r6,[r13, 0x24]
L_8e7d68:
	sub.f r5,r19,r4
L_8e7d6c:
	sbc r1,r17,r6
L_8e7d70:
	mov_s r0,r5
L_8e7d72:
	bl.d L_8c05f4
L_8e7d76:
	mov_s r2,0x3
L_8e7d78:
	ld_s r2,[sp,0x4]
L_8e7d7a:
	bl.d L_8c047c
L_8e7d7e:
	mov_s r3,r21
L_8e7d80:
	st_s r0,[r13,0x28]
L_8e7d82:
	st_s r0,[r15,0x20]
L_8e7d84:
	add_s r3,sp,0x8
L_8e7d86:
	add_s r2,sp,0xc
L_8e7d88:
	mov_s r0,r13
L_8e7d8a:
	bl.d L_8c5468
L_8e7d8e:
	mov_s r1,r3
L_8e7d90:
	mov_s r0,0x853900
L_8e7d96:
	ld_s r0,[r0,0x24]
L_8e7d98:
	add r14,r13,0x20
L_8e7d9c:
	st_s r0,[r13,0x34]
L_8e7d9e:
	ld_s r0,[sp,0x8]
L_8e7da0:
	st_s r0,[r15,0x30]
L_8e7da2:
	st r20,[r13, 0x38]
L_8e7da6:
	st r16,[r13, 0x14]
L_8e7daa:
	st r18,[r13, 0x18]
L_8e7dae:
	st r19,[r13, 0x20]
L_8e7db2:
	st r17,[r13, 0x24]
L_8e7db6:
	ld_s r0,[gp,-0x84]
L_8e7db8:
	ld_s r1,[r13,0x1c]
L_8e7dba:
	cmp_s r0,r1
L_8e7dbc:
	mov.hi r1,r0
L_8e7dc0:
	st.as r1,[gp,-0x21]
L_8e7dc4:
	ld_s r0,[r13,0x28]
L_8e7dc6:
	ld_s r1,[r13,0x1c]
L_8e7dc8:
	bl.d L_8da8cc
L_8e7dcc:
	add_s r0,r0,r1
L_8e7dce:
	ldb_s r0,[r14,0x1c]
L_8e7dd0:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e7dd2:
	extb_s r0,r0
L_8e7dd4:
	cmp_s r0,0x64
L_8e7dd6:
	stb_s r0,[r14,0x1c]
L_8e7dd8:
	bne_s L_8e7e12
L_8e7dda:
	bl L_8dd784
L_8e7dde:
	bl.d L_8dd77c
L_8e7de2:
	mov_s r16,r0
L_8e7de4:
	mov_s r4,r0
L_8e7de6:
	ld_s r2,[sp,0x0]
L_8e7de8:
	mov_s r1,0x1014e3c
L_8e7dee:
	mov_s r0,0x20
L_8e7df0:
	bl.d L_8dcd00
L_8e7df4:
	mov_s r3,r16
L_8e7df6:
	ld r4,[sp, 0x8]
L_8e7dfa:
	mov_s r1,0x1014e7c
L_8e7e00:
	ld_s r2,[r15,0x1c]
L_8e7e02:
	mov_s r0,0x20
L_8e7e04:
	bl.d L_8dcd00
L_8e7e08:
	ld_s r3,[r15,0x20]
L_8e7e0a:
	bl L_8d27d8
L_8e7e0e:
	stb r21,[r14, 0x1c]
	.global L_8e7e12
L_8e7e12:
	ld_s r0,[sp,0x8]
L_8e7e14:
	cmp_s r0,0x5a
L_8e7e16:
	bls_s L_8e7e48
L_8e7e18:
	cmp r0,-0x1
L_8e7e1c:
	beq_s L_8e7e48
L_8e7e1e:
	ldb_s r3,[r14,0x1d]
L_8e7e20:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_8e7e22:
	extb_s r3,r3
L_8e7e24:
	brlt.d r3,0x5,L_8e7e4c
L_8e7e28:
	stb_s r3,[r14,0x1d]
L_8e7e2a:
	mov_s r15,0x0
L_8e7e2c:
	ld_s r2,[sp,0x8]
L_8e7e2e:
	mov_s r1,0x1014eac
L_8e7e34:
	mov_s r0,r15
L_8e7e36:
	bl.d L_8dcd00
L_8e7e3a:
	ld r4,[sp]
L_8e7e3e:
	stb_s r15,[r14,0x1d]
L_8e7e40:
	bl.d L_8e2904
L_8e7e44:
	ld_s r0,[r13,0x10]
L_8e7e46:
	b_s L_8e7e4c
	.global L_8e7e48
L_8e7e48:
	mov_s r0,0x0
L_8e7e4a:
	stb_s r0,[r14,0x1d]
	.global L_8e7e4c
L_8e7e4c:
	cmp r22,0x0
L_8e7e50:
	bl.eq.d L_8e4910
L_8e7e54:
	mov.eq r0,r13
L_8e7e58:
	b.d L_8c0214
L_8e7e5c:
	add_s sp,sp,0x10
L_8e7e5e:
	nop_s
