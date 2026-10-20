/* mgmt_tx__build_assoc_resp @ 0x8f1c40, 324 байт.  Сгенерировано gen_asm_tree.py
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
 * Зовут его: mlme_sm__assoc_req_handle, mlme_sm__send_assoc
 * Зовёт сам: __ld_r22_to_r13_ret, __st_r22_to_r13, app_ies__set_buffer, frame_builder__assoc_resp_fix_fields, fw_log__emit0, fw_log__emit1, fw_log__emit2, fw_log__emit3, ie__push_wfa_vendor, ies_block__is_empty, ies_block__merge, log_hexdump
 */
	.section .text.mgmt_tx__build_assoc_resp,"ax",@progbits
	.global mgmt_tx__build_assoc_resp
mgmt_tx__build_assoc_resp:
	.global L_8f1c40
L_8f1c40:
	push_s blink
L_8f1c42:
	bl L_8c02a4
L_8f1c46:
	sub sp,sp,0x110
L_8f1c4a:
	mov_s r18,r0
L_8f1c4c:
	mov_s r16,r1
L_8f1c4e:
	mov_s r19,r2
L_8f1c50:
	mov_s r14,r3
L_8f1c52:
	st_s r0,[sp,0x0]
L_8f1c54:
	add_s r3,r3,0x10
L_8f1c56:
	mov_s r0,r2
L_8f1c58:
	mov_s r1,r18
L_8f1c5a:
	bl.d L_8ec5c0
L_8f1c5e:
	mov_s r2,0x1
L_8f1c60:
	mov_s r2,0x10105cc
L_8f1c66:
	ld r5,[sp]
L_8f1c6a:
	mov_s r0,0xd
L_8f1c6c:
	mov_s r1,0x2
L_8f1c6e:
	mov_s r3,0x18
L_8f1c70:
	bl.d L_8ee034
L_8f1c74:
	mov r4,0x0
L_8f1c78:
	ld_s r0,[sp,0x0]
L_8f1c7a:
	bl.d L_8c7f90
L_8f1c7e:
	mov_s r1,0x18
L_8f1c80:
	ld_s r0,[sp,0x0]
L_8f1c82:
	add3 r13,r19,0x9
L_8f1c86:
	add_s r0,r0,0x18
L_8f1c88:
	st_s r0,[sp,0x0]
L_8f1c8a:
	mov_s r1,r13
L_8f1c8c:
	bl.d L_8ec754
L_8f1c90:
	mov_s r2,r14
L_8f1c92:
	mov_s r15,r0
L_8f1c94:
	mov_s r2,0x1010608
L_8f1c9a:
	ld r5,[sp]
L_8f1c9e:
	mov_s r0,0xd
L_8f1ca0:
	mov_s r1,0x2
L_8f1ca2:
	mov_s r3,r15
L_8f1ca4:
	bl.d L_8ee034
L_8f1ca8:
	mov r4,0x18
L_8f1cac:
	ld_s r0,[sp,0x0]
L_8f1cae:
	bl.d L_8c7f90
L_8f1cb2:
	mov_s r1,r15
L_8f1cb4:
	ld_s r0,[sp,0x0]
L_8f1cb6:
	add r20,r15,0x18
L_8f1cba:
	add_s r0,r0,r15
L_8f1cbc:
	st_s r0,[sp,0x0]
L_8f1cbe:
	mov_s r0,r13
L_8f1cc0:
	bl.d L_8c97fc
L_8f1cc4:
	mov_s r1,0x1
L_8f1cc6:
	mov_s r21,r0
L_8f1cc8:
	ld.as r0,[r14,0x60]
L_8f1ccc:
	mov_s r15,0x1
L_8f1cce:
	cmp_s r0,0x0
L_8f1cd0:
	sub_s.ne r15,r15,r15
L_8f1cd2:
	bl.d L_8d70f0
L_8f1cd6:
	mov_s r0,r21
L_8f1cd8:
	extw r20,r20
L_8f1cdc:
	breq_s r0,0,L_8f1cfa
L_8f1cde:
	mov_s r2,0x1010644
L_8f1ce4:
	mov_s r0,0xd
L_8f1ce6:
	bl.d L_8edfb0
L_8f1cea:
	mov_s r1,0x2
L_8f1cec:
	ld_s r0,[sp,0x0]
L_8f1cee:
	mov_s r1,r13
L_8f1cf0:
	mov_s r2,r15
L_8f1cf2:
	bl.d L_8ec7e0
L_8f1cf6:
	ldb_s r3,[r14,0x8]
L_8f1cf8:
	b_s L_8f1d34
	.global L_8f1cfa
L_8f1cfa:
	add_s r0,sp,0x4
L_8f1cfc:
	mov_s r17,r0
L_8f1cfe:
	mov_s r1,r13
L_8f1d00:
	mov_s r2,r15
L_8f1d02:
	bl.d L_8ec7e0
L_8f1d06:
	ldb_s r3,[r14,0x8]
L_8f1d08:
	mov_s r22,r0
L_8f1d0a:
	mov_s r2,0x1010668
L_8f1d10:
	mov_s r0,0xd
L_8f1d12:
	mov_s r1,0x2
L_8f1d14:
	bl.d L_8edfcc
L_8f1d18:
	mov_s r3,r22
L_8f1d1a:
	add3 r13,sp,0x20
L_8f1d1e:
	add_s r0,r13,0x4
L_8f1d20:
	mov_s r1,r17
L_8f1d22:
	mov_s r2,r22
L_8f1d24:
	bl.d L_8e1afc
L_8f1d28:
	mov_s r3,0x0
L_8f1d2a:
	mov_s r0,sp
L_8f1d2c:
	mov_s r1,r21
L_8f1d2e:
	bl.d L_8da098
L_8f1d32:
	add_s r2,r13,0x4
	.global L_8f1d34
L_8f1d34:
	add r13,r20,r0
L_8f1d38:
	extw_s r13,r13
L_8f1d3a:
	add r1,r19,0xa
L_8f1d3e:
	add r0,r18,r13
L_8f1d42:
	bl.d L_8ef740
L_8f1d46:
	mov_s r2,0x0
L_8f1d48:
	extw_s r3,r0
L_8f1d4a:
	add r17,r13,r3
L_8f1d4e:
	extw r17,r17
L_8f1d52:
	mov_s r2,0x1010560
L_8f1d58:
	mov_s r0,0xd
L_8f1d5a:
	mov_s r1,0x2
L_8f1d5c:
	bl.d L_8edff8
L_8f1d60:
	mov r4,r17
L_8f1d64:
	st r17,[r16]
L_8f1d68:
	ldb_s r3,[r14,0x8]
L_8f1d6a:
	mov_s r2,0x1010694
L_8f1d70:
	mov_s r0,0xd
L_8f1d72:
	mov_s r1,0x2
L_8f1d74:
	bl.d L_8edff8
L_8f1d78:
	mov r4,r17
L_8f1d7c:
	b.d L_8c02f4
L_8f1d80:
	add sp,sp,0x110
