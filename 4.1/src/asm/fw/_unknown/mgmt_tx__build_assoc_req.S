/* mgmt_tx__build_assoc_req @ 0x8f1b00, 320 байт.  Сгенерировано gen_asm_tree.py
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
 * Зовут его: mlme_sm__send_assoc
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, app_ies__set_buffer, fw_log__emit0, fw_log__emit1, fw_log__emit2, fw_log__emit3, ie__push_wfa_vendor, ies_block__is_empty, ies_block__merge, log_hexdump, mgmt_tx__assoc_req_fixed_fields
 */
	.section .text.mgmt_tx__build_assoc_req,"ax",@progbits
	.global mgmt_tx__build_assoc_req
mgmt_tx__build_assoc_req:
	.global L_8f1b00
L_8f1b00:
	push_s blink
L_8f1b02:
	bl L_8c02a8
L_8f1b06:
	sub sp,sp,0x110
L_8f1b0a:
	mov_s r14,r0
L_8f1b0c:
	mov_s r18,r1
L_8f1b0e:
	mov_s r20,r2
L_8f1b10:
	mov_s r13,r3
L_8f1b12:
	st_s r0,[sp,0x0]
L_8f1b14:
	add_s r3,r3,0x10
L_8f1b16:
	mov_s r0,r2
L_8f1b18:
	mov_s r1,r14
L_8f1b1a:
	bl.d L_8ec5c0
L_8f1b1e:
	mov_s r2,0x0
L_8f1b20:
	ld_s r0,[sp,0x0]
L_8f1b22:
	add3 r15,r20,0x9
L_8f1b26:
	add_s r0,r0,0x18
L_8f1b28:
	st_s r0,[sp,0x0]
L_8f1b2a:
	mov_s r1,r15
L_8f1b2c:
	bl.d L_8ec6d0
L_8f1b30:
	mov_s r2,r13
L_8f1b32:
	mov_s r16,r0
L_8f1b34:
	mov_s r2,0x10104ac
L_8f1b3a:
	ld r5,[sp]
L_8f1b3e:
	mov_s r0,0xd
L_8f1b40:
	mov_s r1,0x2
L_8f1b42:
	mov_s r3,r16
L_8f1b44:
	bl.d L_8ee034
L_8f1b48:
	mov r4,0x18
L_8f1b4c:
	mov_s r0,r14
L_8f1b4e:
	bl.d L_8c7f90
L_8f1b52:
	mov_s r1,r16
L_8f1b54:
	ld_s r0,[sp,0x0]
L_8f1b56:
	add r21,r16,0x18
L_8f1b5a:
	add_s r0,r0,r16
L_8f1b5c:
	st_s r0,[sp,0x0]
L_8f1b5e:
	mov_s r0,r15
L_8f1b60:
	bl.d L_8c97fc
L_8f1b64:
	mov_s r1,0x0
L_8f1b66:
	mov_s r19,r0
L_8f1b68:
	ld.as r0,[r13,0x60]
L_8f1b6c:
	mov r16,0x1
L_8f1b70:
	cmp_s r0,0x0
L_8f1b72:
	sub.ne r16,r16,r16
L_8f1b76:
	extw r21,r21
L_8f1b7a:
	breq r19,0x0,L_8f1ba2
L_8f1b7e:
	bl.d L_8d70f0
L_8f1b82:
	mov_s r0,r19
L_8f1b84:
	breq_s r0,0,L_8f1ba2
L_8f1b86:
	mov_s r2,0x10104e8
L_8f1b8c:
	mov_s r0,0xd
L_8f1b8e:
	bl.d L_8edfb0
L_8f1b92:
	mov_s r1,0x2
L_8f1b94:
	ld_s r0,[sp,0x0]
L_8f1b96:
	mov_s r1,r15
L_8f1b98:
	bl.d L_8ec6f4
L_8f1b9c:
	mov_s r2,r16
L_8f1b9e:
	mov_s r15,r0
L_8f1ba0:
	b_s L_8f1bec
	.global L_8f1ba2
L_8f1ba2:
	add_s r0,sp,0x4
L_8f1ba4:
	mov_s r17,r0
L_8f1ba6:
	mov_s r1,r15
L_8f1ba8:
	bl.d L_8ec6f4
L_8f1bac:
	mov_s r2,r16
L_8f1bae:
	mov_s r16,r0
L_8f1bb0:
	mov_s r2,0x101050c
L_8f1bb6:
	mov_s r0,0xd
L_8f1bb8:
	mov_s r1,0x2
L_8f1bba:
	bl.d L_8edfcc
L_8f1bbe:
	mov_s r3,r16
L_8f1bc0:
	add3 r15,sp,0x20
L_8f1bc4:
	add_s r0,r15,0x4
L_8f1bc6:
	mov_s r1,r17
L_8f1bc8:
	mov_s r2,r16
L_8f1bca:
	bl.d L_8e1afc
L_8f1bce:
	mov_s r3,0x0
L_8f1bd0:
	mov_s r0,sp
L_8f1bd2:
	mov_s r1,r19
L_8f1bd4:
	bl.d L_8da098
L_8f1bd8:
	add_s r2,r15,0x4
L_8f1bda:
	mov_s r15,r0
L_8f1bdc:
	mov_s r2,0x101052c
L_8f1be2:
	mov_s r0,0xd
L_8f1be4:
	mov_s r1,0x2
L_8f1be6:
	bl.d L_8edfcc
L_8f1bea:
	mov_s r3,r16
	.global L_8f1bec
L_8f1bec:
	add_s r15,r15,r21
L_8f1bee:
	extw_s r15,r15
L_8f1bf0:
	add r1,r20,0xa
L_8f1bf4:
	add_s r0,r14,r15
L_8f1bf6:
	bl.d L_8ef740
L_8f1bfa:
	mov_s r2,0x0
L_8f1bfc:
	extw_s r3,r0
L_8f1bfe:
	add r16,r15,r3
L_8f1c02:
	extw r16,r16
L_8f1c06:
	mov_s r2,0x1010560
L_8f1c0c:
	mov_s r0,0xd
L_8f1c0e:
	mov_s r1,0x2
L_8f1c10:
	bl.d L_8edff8
L_8f1c14:
	mov r4,r16
L_8f1c18:
	st r16,[r18]
L_8f1c1c:
	mov_s r0,r14
L_8f1c1e:
	bl.d L_8c7f90
L_8f1c22:
	mov_s r1,r16
L_8f1c24:
	mov_s r2,0x101059c
L_8f1c2a:
	ld r4,[r18]
L_8f1c2e:
	mov_s r0,0xd
L_8f1c30:
	mov_s r1,0x2
L_8f1c32:
	bl.d L_8edff8
L_8f1c36:
	ldb_s r3,[r13,0x8]
L_8f1c38:
	b.d L_8c02fc
L_8f1c3c:
	add sp,sp,0x110
