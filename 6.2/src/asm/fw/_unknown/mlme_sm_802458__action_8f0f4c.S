/* mlme_sm_802458__action_8f0f4c @ 0x8f0f4c, 224 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ASSOC RESP event.
 *   Assoc Res: Vendor specific Passphrase+++++++++++++++++++
 *   Assoc Res: NO Vendor specific +++++++++++++++++++
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log_emit0, fw_sysassert_fatal, mgmt_pkt__release, mlme__parse_wilocity_vs, mlme_notify, u_schd__cancel, u_schd__schedule
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mlme_sm_802458__action_8f0f4c
mlme_sm_802458__action_8f0f4c:
	.global L_8f0f4c
L_8f0f4c:
	push_s blink
L_8f0f4e:
	bl L_8c01d8
L_8f0f52:
	sub_s sp,sp,0x4
L_8f0f54:
	mov_s r14,r0
L_8f0f56:
	ld_s r0,[gp,-0xfc]
L_8f0f58:
	mov_s r13,r1
L_8f0f5a:
	mulu64 r0,0x3e8
L_8f0f5e:
	mov_s r1,0x1011608
L_8f0f64:
	mov r17,mlo
L_8f0f68:
	bl.d L_8dcba8
L_8f0f6c:
	mov_s r0,0x2a
L_8f0f6e:
	ld_s r0,[r14,0x14]
L_8f0f70:
	mov_s r15,0x0
L_8f0f72:
	breq_s r0,0,L_8f0f7a
L_8f0f74:
	bl L_8c8de0
L_8f0f78:
	st_s r15,[r14,0x14]
	.global L_8f0f7a
L_8f0f7a:
	ld_s r1,[r14,0x20]
L_8f0f7c:
	ld_s r0,[r1,0x18]
L_8f0f7e:
	ld_s r0,[r0,0x50]
L_8f0f80:
	cmp_s r0,0x1
L_8f0f82:
	mov_s r0,0x1
L_8f0f84:
	sub_s.ne r0,r0,r0
L_8f0f86:
	extb.f 0x0,r0
L_8f0f8a:
	beq_s L_8f0ff8
L_8f0f8c:
	ld_s r0,[r1,0x28]
L_8f0f8e:
	brne_s r0,0,L_8f0ff8
L_8f0f90:
	stw r15,[sp]
L_8f0f94:
	ld_s r0,[r14,0x20]
L_8f0f96:
	ld_s r0,[r0,0x18]
L_8f0f98:
	add3 r16,r0,0x9
L_8f0f9c:
	breq_s r13,0,L_8f0fc6
	.global L_8f0f9e
L_8f0f9e:
	ld_s r1,[r13,0xc]
L_8f0fa0:
	ld r0,[r1, 0xa4]
L_8f0fa4:
	breq_s r0,0,L_8f0fd4
L_8f0fa6:
	add r1,r1,0xa0
L_8f0faa:
	mov_s r2,sp
L_8f0fac:
	bl.d L_8df860
L_8f0fb0:
	mov_s r0,r16
L_8f0fb2:
	ldw r1,[sp]
L_8f0fb6:
	cmp_s r1,0x0
L_8f0fb8:
	cmp.ne r0,0x0
L_8f0fbc:
	beq_s L_8f0fe0
L_8f0fbe:
	mov_s r1,0x101161c
L_8f0fc4:
	b_s L_8f0fda
	.global L_8f0fc6
L_8f0fc6:
	mov_s r0,blink
L_8f0fc8:
	mov_s r1,0x11fc
L_8f0fce:
	bl L_8c9b28
L_8f0fd2:
	b_s L_8f0f9e
	.global L_8f0fd4
L_8f0fd4:
	mov_s r1,0x1011658
	.global L_8f0fda
L_8f0fda:
	bl.d L_8dcba8
L_8f0fde:
	mov_s r0,0x2a
	.global L_8f0fe0
L_8f0fe0:
	ld_s r0,[r14,0x20]
L_8f0fe2:
	st_s r13,[r14,0x2c]
L_8f0fe4:
	ld_s r1,[r0,0x18]
L_8f0fe6:
	ld_s r0,[r13,0xc]
L_8f0fe8:
	ldw r0,[r0, 0xca]
L_8f0fec:
	stb_s r0,[r1,0x8]
L_8f0fee:
	ld_s r0,[r14,0x20]
L_8f0ff0:
	stb_s r15,[r0,0x9]
L_8f0ff2:
	bl.d L_8cb180
L_8f0ff6:
	mov_s r0,r13
	.global L_8f0ff8
L_8f0ff8:
	mov_s r0,0x32228
L_8f0ffe:
	mov_s r1,r14
L_8f1000:
	mov_s r2,0x0
L_8f1002:
	mov_s r3,0x1
L_8f1004:
	mov r4,r17
L_8f1008:
	mov_s r5,r2
L_8f100a:
	bl.d L_8e0c0c
L_8f100e:
	mov_s r6,r2
L_8f1010:
	st_s r0,[r14,0x14]
L_8f1012:
	ld_s r1,[r14,0x20]
L_8f1014:
	mov_s r0,r14
L_8f1016:
	ldb_s r1,[r1,0x8]
L_8f1018:
	mov_s r2,0x1
L_8f101a:
	mov_s r3,0x4
L_8f101c:
	bl.d L_8de394
L_8f1020:
	mov r4,0x0
L_8f1024:
	b.d L_8c023c
L_8f1028:
	add_s sp,sp,0x4
L_8f102a:
	nop_s
