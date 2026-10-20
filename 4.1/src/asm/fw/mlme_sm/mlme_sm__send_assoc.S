/* mlme_sm__send_assoc @ 0x8c4f08, 268 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Send ASSOC REQ len %d
 *   mlme_sm.cpp
 *   Send ASSOC RESP len %d
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r17_to_r13_ret, __st_r17_to_r13, basic_sm__store_pending_event, fw_log__emit1, fw_sysassert_fatal, log_hexdump, mgmt_tx__build_assoc_req, mgmt_tx__build_assoc_resp, tx_api__send_mgmt_with_cb, u_schd__cancel, u_schd__schedule
 * Глобалы (через gp): 0x8002d4
 */
	.section .text.mlme_sm__send_assoc,"ax",@progbits
	.global mlme_sm__send_assoc
mlme_sm__send_assoc:
L_8c4f08:
	push_s blink
L_8c4f0a:
	bl L_8c02b8
L_8c4f0e:
	sub_s sp,sp,0x8
L_8c4f10:
	mov_s r13,r0
L_8c4f12:
	mov_s r14,0x0
L_8c4f14:
	ld_s r0,[gp,0x164]
L_8c4f16:
	st_s r14,[sp,0x4]
L_8c4f18:
	mulu64 r0,0x3e8
L_8c4f1c:
	mov r16,mlo
L_8c4f20:
	ld_s r0,[r13,0x38]
L_8c4f22:
	mov_s r15,0x1
L_8c4f24:
	st_s r1,[r13,0x34]
L_8c4f26:
	st_s r15,[r13,0x2c]
L_8c4f28:
	breq_s r0,0,L_8c4f30
L_8c4f2a:
	bl L_8c7794
L_8c4f2e:
	st_s r14,[r13,0x38]
	.global L_8c4f30
L_8c4f30:
	bl L_8c2c80
L_8c4f34:
	st_s r0,[r13,0x40]
L_8c4f36:
	breq_s r0,0,L_8c4f64
	.global L_8c4f38
L_8c4f38:
	ld_s r3,[r13,0x3c]
L_8c4f3a:
	mov_s r14,0x0
L_8c4f3c:
	ld_s r2,[r3,0xc]
L_8c4f3e:
	ld_s r1,[r2,0x50]
L_8c4f40:
	cmp_s r1,0x1
L_8c4f42:
	mov_s r1,0x1
L_8c4f44:
	sub_s.ne r1,r1,r1
L_8c4f46:
	extb.f 0x0,r1
L_8c4f4a:
	add_s r1,sp,0x4
L_8c4f4c:
	beq_s L_8c4f7e
L_8c4f4e:
	bl L_8f1b00
L_8c4f52:
	mov_s r2,0x100f390
L_8c4f58:
	mov_s r0,0xa
L_8c4f5a:
	mov_s r1,0x2
L_8c4f5c:
	bl.d L_8edfcc
L_8c4f60:
	ld_s r3,[sp,0x4]
L_8c4f62:
	b_s L_8c4fa6
	.global L_8c4f64
L_8c4f64:
	mov_s r0,blink
L_8c4f66:
	mov_s r2,0x100f220
L_8c4f6c:
	mov_s r1,0x11fa
L_8c4f72:
	bl.d L_8c82c0
L_8c4f76:
	mov r3,0x160
L_8c4f7a:
	ld_s r0,[r13,0x40]
L_8c4f7c:
	b_s L_8c4f38
	.global L_8c4f7e
L_8c4f7e:
	bl.d L_8f1c40
L_8c4f82:
	mov r17,0x4
L_8c4f86:
	mov_s r2,0x100f3a8
L_8c4f8c:
	mov_s r0,0xa
L_8c4f8e:
	mov_s r1,0x2
L_8c4f90:
	bl.d L_8edfcc
L_8c4f94:
	ld_s r3,[sp,0x4]
L_8c4f96:
	mov_s r0,r13
L_8c4f98:
	mov_s r1,0x3
L_8c4f9a:
	mov_s r2,r14
L_8c4f9c:
	mov_s r3,r14
L_8c4f9e:
	bl.d L_8e20c0
L_8c4fa2:
	mov_s r4,r14
L_8c4fa4:
	mov_s r14,r17
	.global L_8c4fa6
L_8c4fa6:
	ld_s r0,[sp,0x4]
L_8c4fa8:
	breq_s r0,0,L_8c4ffe
	.global L_8c4faa
L_8c4faa:
	ld_s r0,[r13,0x40]
L_8c4fac:
	bl.d L_8c7f90
L_8c4fb0:
	ld_s r1,[sp,0x4]
L_8c4fb2:
	mov r7,0x2a8f0
L_8c4fba:
	ldw r4,[sp, 0x4]
L_8c4fbe:
	st_s r14,[sp,0x0]
L_8c4fc0:
	ld_s r0,[r13,0x3c]
L_8c4fc2:
	mov_s r1,0x0
L_8c4fc4:
	mov_s r2,0x1
L_8c4fc6:
	ld_s r3,[r13,0x40]
L_8c4fc8:
	mov r5,0x7
L_8c4fcc:
	bl.d L_8e0e08
L_8c4fd0:
	mov r6,0x50
L_8c4fd4:
	ld_s r0,[r13,0x38]
L_8c4fd6:
	st_s r15,[r13,0x30]
L_8c4fd8:
	brne_s r0,0,L_8c4ff8
L_8c4fda:
	mov_s r0,0x29918
L_8c4fe0:
	mov_s r1,r13
L_8c4fe2:
	mov_s r2,0x0
L_8c4fe4:
	mov_s r3,0x1
L_8c4fe6:
	mov r4,r16
L_8c4fea:
	mov r5,0x0
L_8c4fee:
	bl.d L_8dc92c
L_8c4ff2:
	mov r6,0x0
L_8c4ff6:
	st_s r0,[r13,0x38]
	.global L_8c4ff8
L_8c4ff8:
	b.d L_8c031c
L_8c4ffc:
	add_s sp,sp,0x8
	.global L_8c4ffe
L_8c4ffe:
	mov_s r0,blink
L_8c5000:
	mov_s r2,0x100f220
L_8c5006:
	mov_s r1,0x11fb
L_8c500c:
	bl.d L_8c82c0
L_8c5010:
	mov r3,0x179
