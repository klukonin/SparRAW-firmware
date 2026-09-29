/* mgmt_tx__build_assoc_req @ 0x8f9d5c, 300 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ASSOC REQ fields %d bytes, so far %d bytes, pkt at 0x%8X
 *   ASSOC REQ internal IEs are built
 *   ASSOC REQ internal IEs len %d.
 *   ASSOC REQ internal & External IEs are built len %d.
 *   Build serv: Assoc Req 60GHz Capability length %d total %d
 *   TX MGMT SRVS: Build assoc req cid = %d, len %d
 * Зовут его: mlme_sm_802458__action_8c5cfc
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, app_ies__set_buffer, fw_log_emit0, fw_log_emit1, fw_log_emit2, fw_log_emit3, hexdump_words, ie__push_wfa_vendor, ies_block__is_empty, ies_block__merge, mgmt_tx__assoc_req_fixed_fields
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mgmt_tx__build_assoc_req
mgmt_tx__build_assoc_req:
	.global L_8f9d5c
L_8f9d5c:
	push_s blink
L_8f9d5e:
	bl L_8c01c8
L_8f9d62:
	sub sp,sp,0x110
L_8f9d66:
	mov_s r14,r0
L_8f9d68:
	mov_s r19,r1
L_8f9d6a:
	mov_s r20,r2
L_8f9d6c:
	mov_s r16,r3
L_8f9d6e:
	st_s r0,[sp,0x0]
L_8f9d70:
	add_s r3,r3,0x1c
L_8f9d72:
	mov_s r0,r2
L_8f9d74:
	mov_s r1,r14
L_8f9d76:
	bl.d L_8d7db8
L_8f9d7a:
	mov_s r2,0x0
L_8f9d7c:
	ld_s r0,[sp,0x0]
L_8f9d7e:
	add3 r15,r20,0x9
L_8f9d82:
	add_s r0,r0,0x18
L_8f9d84:
	st_s r0,[sp,0x0]
L_8f9d86:
	mov_s r1,r15
L_8f9d88:
	bl.d L_8f4e9c
L_8f9d8c:
	mov_s r2,r16
L_8f9d8e:
	mov_s r13,r0
L_8f9d90:
	mov_s r1,0x10139b8
L_8f9d96:
	ld r4,[sp]
L_8f9d9a:
	mov_s r0,0x2d
L_8f9d9c:
	mov_s r2,r13
L_8f9d9e:
	bl.d L_8dcd00
L_8f9da2:
	mov_s r3,0x18
L_8f9da4:
	mov_s r0,r14
L_8f9da6:
	bl.d L_8c9790
L_8f9daa:
	mov_s r1,r13
L_8f9dac:
	ld_s r0,[sp,0x0]
L_8f9dae:
	add r21,r13,0x18
L_8f9db2:
	add_s r0,r0,r13
L_8f9db4:
	st_s r0,[sp,0x0]
L_8f9db6:
	mov_s r0,r15
L_8f9db8:
	bl.d L_8cb844
L_8f9dbc:
	mov_s r1,0x0
L_8f9dbe:
	mov_s r13,r0
L_8f9dc0:
	ld.as r0,[r16,0x61]
L_8f9dc4:
	mov r17,0x1
L_8f9dc8:
	cmp_s r0,0x0
L_8f9dca:
	sub.ne r17,r17,r17
L_8f9dce:
	extw r21,r21
L_8f9dd2:
	breq_s r13,0,L_8f9df6
L_8f9dd4:
	bl.d L_8da1c0
L_8f9dd8:
	mov_s r0,r13
L_8f9dda:
	breq_s r0,0,L_8f9df6
L_8f9ddc:
	mov_s r1,0x10139f4
L_8f9de2:
	bl.d L_8dcba8
L_8f9de6:
	mov_s r0,0x2d
L_8f9de8:
	ld_s r0,[sp,0x0]
L_8f9dea:
	mov_s r1,r15
L_8f9dec:
	bl.d L_8f4ec0
L_8f9df0:
	mov_s r2,r17
L_8f9df2:
	mov_s r13,r0
L_8f9df4:
	b_s L_8f9e3c
	.global L_8f9df6
L_8f9df6:
	add_s r0,sp,0x4
L_8f9df8:
	mov_s r18,r0
L_8f9dfa:
	mov_s r1,r15
L_8f9dfc:
	bl.d L_8f4ec0
L_8f9e00:
	mov_s r2,r17
L_8f9e02:
	mov_s r17,r0
L_8f9e04:
	mov_s r1,0x1013a18
L_8f9e0a:
	mov_s r0,0x2d
L_8f9e0c:
	bl.d L_8dcc10
L_8f9e10:
	mov_s r2,r17
L_8f9e12:
	add3 r15,sp,0x20
L_8f9e16:
	add_s r0,r15,0x4
L_8f9e18:
	mov_s r1,r18
L_8f9e1a:
	mov_s r2,r17
L_8f9e1c:
	bl.d L_8e693c
L_8f9e20:
	mov_s r3,0x0
L_8f9e22:
	mov_s r0,sp
L_8f9e24:
	mov_s r1,r13
L_8f9e26:
	bl.d L_8ddfd0
L_8f9e2a:
	add_s r2,r15,0x4
L_8f9e2c:
	mov_s r13,r0
L_8f9e2e:
	mov_s r1,0x1013a38
L_8f9e34:
	mov_s r0,0x2d
L_8f9e36:
	bl.d L_8dcc10
L_8f9e3a:
	mov_s r2,r17
	.global L_8f9e3c
L_8f9e3c:
	add_s r13,r13,r21
L_8f9e3e:
	extw_s r13,r13
L_8f9e40:
	add r1,r20,0xa
L_8f9e44:
	add_s r0,r14,r13
L_8f9e46:
	bl.d L_8e1c94
L_8f9e4a:
	mov_s r2,0x0
L_8f9e4c:
	extw_s r2,r0
L_8f9e4e:
	add_s r13,r13,r2
L_8f9e50:
	extw_s r13,r13
L_8f9e52:
	mov_s r1,0x1013a6c
L_8f9e58:
	mov_s r0,0x2d
L_8f9e5a:
	bl.d L_8dcc80
L_8f9e5e:
	mov_s r3,r13
L_8f9e60:
	st r13,[r19]
L_8f9e64:
	mov_s r0,r14
L_8f9e66:
	bl.d L_8c9790
L_8f9e6a:
	mov_s r1,r13
L_8f9e6c:
	ldb r2,[r16, 0x8]
L_8f9e70:
	mov_s r1,0x1013aa8
L_8f9e76:
	mov_s r0,0x2d
L_8f9e78:
	bl.d L_8dcc80
L_8f9e7c:
	ld r3,[r19]
L_8f9e80:
	b.d L_8c021c
L_8f9e84:
	add sp,sp,0x110
