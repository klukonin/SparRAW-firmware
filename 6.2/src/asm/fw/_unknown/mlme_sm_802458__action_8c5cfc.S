/* mlme_sm_802458__action_8c5cfc @ 0x8c5cfc, 360 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Send ASSOC REQ len %d
 *   Send ASSOC RESP len %d
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r16_to_r13_ret, __st_r16_to_r13, conn__get_cid_of_obj, fw_log_emit1, fw_sysassert_fatal, lmac_if_trigger_bf, mgmt_tx__build_assoc_req, mgmt_tx__build_assoc_resp_8f9e88, sm__defer_call, tx_api__send_mgmt_with_cb, u_schd__cancel
 * Глобалы (через gp): 0x8002e4
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mlme_sm_802458__action_8c5cfc
mlme_sm_802458__action_8c5cfc:
	.global L_8c5cfc
L_8c5cfc:
	push_s blink
L_8c5cfe:
	bl L_8c01dc
L_8c5d02:
	sub_s sp,sp,0x8
L_8c5d04:
	mov_s r14,r0
L_8c5d06:
	mov_s r13,0x0
L_8c5d08:
	ld_s r0,[gp,0x160]
L_8c5d0a:
	st_s r13,[sp,0x4]
L_8c5d0c:
	mulu64 r0,0x3e8
L_8c5d10:
	mov r16,mlo
L_8c5d14:
	ld_s r0,[r14,0x14]
L_8c5d16:
	mov_s r15,0x1
L_8c5d18:
	st_s r1,[r14,0x10]
L_8c5d1a:
	st_s r15,[r14,0x8]
L_8c5d1c:
	breq_s r0,0,L_8c5d24
L_8c5d1e:
	bl L_8c8de0
L_8c5d22:
	st_s r13,[r14,0x14]
	.global L_8c5d24
L_8c5d24:
	ld_s r0,[r14,0x20]
L_8c5d26:
	ld_s r0,[r0,0x18]
L_8c5d28:
	ld_s r0,[r0,0x50]
L_8c5d2a:
	cmp_s r0,0x1
L_8c5d2c:
	mov_s r0,0x1
L_8c5d2e:
	sub_s.ne r0,r0,r0
L_8c5d30:
	extb.f 0x0,r0
L_8c5d34:
	bne_s L_8c5d40
L_8c5d36:
	mov_s r0,0x803c20
L_8c5d3c:
	ldb_s r0,[r0,0x8]
L_8c5d3e:
	brne_s r0,0,L_8c5d48
	.global L_8c5d40
L_8c5d40:
	bl L_8c3414
L_8c5d44:
	st_s r0,[r14,0x24]
L_8c5d46:
	breq_s r0,0,L_8c5d72
	.global L_8c5d48
L_8c5d48:
	ld_s r3,[r14,0x20]
L_8c5d4a:
	ld_s r2,[r3,0x18]
L_8c5d4c:
	ld_s r0,[r2,0x50]
L_8c5d4e:
	cmp_s r0,0x1
L_8c5d50:
	mov_s r0,0x1
L_8c5d52:
	sub_s.ne r0,r0,r0
L_8c5d54:
	extb.f 0x0,r0
L_8c5d58:
	beq_s L_8c5d80
L_8c5d5a:
	add_s r1,sp,0x4
L_8c5d5c:
	bl.d L_8f9d5c
L_8c5d60:
	ld_s r0,[r14,0x24]
L_8c5d62:
	mov_s r1,0x10114e4
L_8c5d68:
	mov_s r0,0x2a
L_8c5d6a:
	bl.d L_8dcc10
L_8c5d6e:
	ld_s r2,[sp,0x4]
L_8c5d70:
	b_s L_8c5d8a
	.global L_8c5d72
L_8c5d72:
	mov_s r0,blink
L_8c5d74:
	mov_s r1,0x11fa
L_8c5d7a:
	bl L_8c9b28
L_8c5d7e:
	b_s L_8c5d48
	.global L_8c5d80
L_8c5d80:
	mov_s r0,0x803c20
L_8c5d86:
	ldb_s r0,[r0,0x8]
L_8c5d88:
	breq_s r0,0,L_8c5d8e
	.global L_8c5d8a
L_8c5d8a:
	mov_s r13,0x0
L_8c5d8c:
	b_s L_8c5da6
	.global L_8c5d8e
L_8c5d8e:
	add_s r1,sp,0x4
L_8c5d90:
	bl.d L_8f9e88
L_8c5d94:
	ld_s r0,[r14,0x24]
L_8c5d96:
	mov_s r1,0x10114fc
L_8c5d9c:
	mov_s r0,0x2a
L_8c5d9e:
	bl.d L_8dcc10
L_8c5da2:
	ld_s r2,[sp,0x4]
L_8c5da4:
	mov_s r13,0x4
	.global L_8c5da6
L_8c5da6:
	ld_s r0,[r14,0x20]
L_8c5da8:
	ld_s r0,[r0,0x18]
L_8c5daa:
	ld_s r0,[r0,0x50]
L_8c5dac:
	cmp_s r0,0x1
L_8c5dae:
	mov_s r0,0x1
L_8c5db0:
	sub_s.ne r0,r0,r0
L_8c5db2:
	extb.f 0x0,r0
L_8c5db6:
	mov.eq r0,r14
L_8c5dba:
	mov.eq r1,0x3
L_8c5dbe:
	mov.eq r2,0x0
L_8c5dc2:
	mov.eq r3,r2
L_8c5dc6:
	bl.eq.d L_8e7044
L_8c5dca:
	mov.eq r4,r2
L_8c5dce:
	ld_s r0,[r14,0x20]
L_8c5dd0:
	ld_s r0,[r0,0x18]
L_8c5dd2:
	ld_s r0,[r0,0x50]
L_8c5dd4:
	cmp_s r0,0x1
L_8c5dd6:
	mov_s r0,0x1
L_8c5dd8:
	sub_s.ne r0,r0,r0
L_8c5dda:
	extb.f 0x0,r0
L_8c5dde:
	bne_s L_8c5dea
L_8c5de0:
	mov_s r0,0x803c20
L_8c5de6:
	ldb_s r0,[r0,0x8]
L_8c5de8:
	brne_s r0,0,L_8c5e34
	.global L_8c5dea
L_8c5dea:
	ld_s r0,[sp,0x4]
L_8c5dec:
	breq_s r0,0,L_8c5e3a
	.global L_8c5dee
L_8c5dee:
	ldw r4,[sp, 0x4]
L_8c5df2:
	mov r7,0x31fb0
L_8c5dfa:
	st_s r13,[sp,0x0]
L_8c5dfc:
	ld_s r0,[r14,0x20]
L_8c5dfe:
	mov_s r1,0x0
L_8c5e00:
	mov_s r2,0x1
L_8c5e02:
	ld_s r3,[r14,0x24]
L_8c5e04:
	mov r5,0x7
L_8c5e08:
	bl.d L_8e5a28
L_8c5e0c:
	mov r6,0x50
L_8c5e10:
	ld_s r0,[r14,0x14]
L_8c5e12:
	st_s r15,[r14,0xc]
L_8c5e14:
	brne_s r0,0,L_8c5e34
L_8c5e16:
	mov_s r0,L_8f1054-0x8c0000
L_8c5e1c:
	mov_s r1,r14
L_8c5e1e:
	mov_s r2,0x0
L_8c5e20:
	mov_s r3,0x1
L_8c5e22:
	mov r4,r16
L_8c5e26:
	mov r5,0x0
L_8c5e2a:
	bl.d L_8e0c0c
L_8c5e2e:
	mov r6,0x0
L_8c5e32:
	st_s r0,[r14,0x14]
	.global L_8c5e34
L_8c5e34:
	b.d L_8c0244
L_8c5e38:
	add_s sp,sp,0x8
	.global L_8c5e3a
L_8c5e3a:
	mov_s r0,blink
L_8c5e3c:
	mov_s r1,0x11fb
L_8c5e42:
	bl L_8c9b28
L_8c5e46:
	b_s L_8c5dee
L_8c5e48:
	push_s blink
L_8c5e4a:
	ld_s r0,[r1,0x24]
L_8c5e4c:
	breq_s r0,0,L_8c5e60
L_8c5e4e:
	mov_s r0,0x1
L_8c5e50:
	st_s r0,[r1,0x28]
L_8c5e52:
	bl.d L_8cbeb8
L_8c5e56:
	ld_s r0,[r1,0x8]
L_8c5e58:
	extb_s r0,r0
L_8c5e5a:
	bl.d L_8dc228
L_8c5e5e:
	mov_s r1,0x0
	.global L_8c5e60
L_8c5e60:
	pop_s blink
L_8c5e62:
	j_s [blink]
