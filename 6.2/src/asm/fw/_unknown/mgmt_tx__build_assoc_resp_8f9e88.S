/* mgmt_tx__build_assoc_resp_8f9e88 @ 0x8f9e88, 296 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ASSOC RESP header %d bytes, so far %d bytes, pkt at 0x%8X
 *   ASSOC RESP fields %d bytes, so far %d bytes, pkt at 0x%8X
 *   ASSOC RESP internal IEs are built
 *   ASSOC RESP internal & External IEs %d len
 *   Build serv: Assoc Req 60GHz Capability length %d total %d
 *   TX MGMT SRVS: Build assoc resp cid = %d, len %d
 * Зовут его: mlme_sm_802458__action_8c5cfc, mlme_sm_802458__action_8f1080
 * Зовёт сам: __ld_r22_to_r13_ret, __st_r22_to_r13, app_ies__set_buffer, frame_builder__assoc_resp_fix_fields, fw_log_emit0, fw_log_emit1, fw_log_emit2, fw_log_emit3, hexdump_words, ie__push_wfa_vendor, ies_block__is_empty, ies_block__merge
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mgmt_tx__build_assoc_resp_8f9e88
mgmt_tx__build_assoc_resp_8f9e88:
	.global L_8f9e88
L_8f9e88:
	push_s blink
L_8f9e8a:
	bl L_8c01c4
L_8f9e8e:
	sub sp,sp,0x110
L_8f9e92:
	mov_s r16,r0
L_8f9e94:
	mov_s r17,r1
L_8f9e96:
	mov_s r18,r2
L_8f9e98:
	mov_s r14,r3
L_8f9e9a:
	st_s r0,[sp,0x0]
L_8f9e9c:
	add_s r3,r3,0x1c
L_8f9e9e:
	mov_s r0,r2
L_8f9ea0:
	mov_s r1,r16
L_8f9ea2:
	bl.d L_8d7db8
L_8f9ea6:
	mov_s r2,0x1
L_8f9ea8:
	mov_s r1,0x1013ad8
L_8f9eae:
	ld r4,[sp]
L_8f9eb2:
	mov_s r0,0x2d
L_8f9eb4:
	mov_s r2,0x18
L_8f9eb6:
	bl.d L_8dcd00
L_8f9eba:
	mov_s r3,0x0
L_8f9ebc:
	ld_s r0,[sp,0x0]
L_8f9ebe:
	bl.d L_8c9790
L_8f9ec2:
	mov_s r1,0x18
L_8f9ec4:
	ld_s r0,[sp,0x0]
L_8f9ec6:
	add3 r15,r18,0x9
L_8f9eca:
	add_s r0,r0,0x18
L_8f9ecc:
	st_s r0,[sp,0x0]
L_8f9ece:
	mov_s r1,r15
L_8f9ed0:
	bl.d L_8f4f20
L_8f9ed4:
	mov_s r2,r14
L_8f9ed6:
	mov_s r13,r0
L_8f9ed8:
	mov_s r1,0x1013b14
L_8f9ede:
	ld r4,[sp]
L_8f9ee2:
	mov_s r0,0x2d
L_8f9ee4:
	mov_s r2,r13
L_8f9ee6:
	bl.d L_8dcd00
L_8f9eea:
	mov_s r3,0x18
L_8f9eec:
	ld_s r0,[sp,0x0]
L_8f9eee:
	bl.d L_8c9790
L_8f9ef2:
	mov_s r1,r13
L_8f9ef4:
	ld_s r0,[sp,0x0]
L_8f9ef6:
	add r20,r13,0x18
L_8f9efa:
	add_s r0,r0,r13
L_8f9efc:
	st_s r0,[sp,0x0]
L_8f9efe:
	mov_s r0,r15
L_8f9f00:
	bl.d L_8cb844
L_8f9f04:
	mov_s r1,0x1
L_8f9f06:
	bl.d L_8da1c0
L_8f9f0a:
	mov_s r21,r0
L_8f9f0c:
	extw r20,r20
L_8f9f10:
	breq_s r0,0,L_8f9f2e
L_8f9f12:
	mov_s r1,0x1013b50
L_8f9f18:
	bl.d L_8dcba8
L_8f9f1c:
	mov_s r0,0x2d
L_8f9f1e:
	ldb_s r2,[r14,0x8]
L_8f9f20:
	ld_s r0,[sp,0x0]
L_8f9f22:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8f9f24:
	extb_s r2,r2
L_8f9f26:
	bl.d L_8f4fa0
L_8f9f2a:
	mov_s r1,r15
L_8f9f2c:
	b_s L_8f9f6a
	.global L_8f9f2e
L_8f9f2e:
	ldb_s r2,[r14,0x8]
L_8f9f30:
	add r19,sp,0x4
L_8f9f34:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8f9f36:
	extb_s r2,r2
L_8f9f38:
	mov_s r0,r19
L_8f9f3a:
	bl.d L_8f4fa0
L_8f9f3e:
	mov_s r1,r15
L_8f9f40:
	mov_s r22,r0
L_8f9f42:
	mov_s r1,0x1013b74
L_8f9f48:
	mov_s r0,0x2d
L_8f9f4a:
	bl.d L_8dcc10
L_8f9f4e:
	mov_s r2,r22
L_8f9f50:
	add3 r13,sp,0x20
L_8f9f54:
	add_s r0,r13,0x4
L_8f9f56:
	mov_s r1,r19
L_8f9f58:
	mov_s r2,r22
L_8f9f5a:
	bl.d L_8e693c
L_8f9f5e:
	mov_s r3,0x0
L_8f9f60:
	mov_s r0,sp
L_8f9f62:
	mov_s r1,r21
L_8f9f64:
	bl.d L_8ddfd0
L_8f9f68:
	add_s r2,r13,0x4
	.global L_8f9f6a
L_8f9f6a:
	add r13,r20,r0
L_8f9f6e:
	extw_s r13,r13
L_8f9f70:
	add r1,r18,0xa
L_8f9f74:
	add r0,r16,r13
L_8f9f78:
	bl.d L_8e1c94
L_8f9f7c:
	mov_s r2,0x0
L_8f9f7e:
	extw_s r2,r0
L_8f9f80:
	add_s r13,r13,r2
L_8f9f82:
	extw_s r13,r13
L_8f9f84:
	mov_s r1,0x1013a6c
L_8f9f8a:
	mov_s r0,0x2d
L_8f9f8c:
	bl.d L_8dcc80
L_8f9f90:
	mov_s r3,r13
L_8f9f92:
	st r13,[r17]
L_8f9f96:
	ldb_s r2,[r14,0x8]
L_8f9f98:
	mov_s r1,0x1013ba0
L_8f9f9e:
	mov_s r0,0x2d
L_8f9fa0:
	bl.d L_8dcc80
L_8f9fa4:
	mov_s r3,r13
L_8f9fa6:
	b.d L_8c0214
L_8f9faa:
	add sp,sp,0x110
L_8f9fae:
	nop_s
