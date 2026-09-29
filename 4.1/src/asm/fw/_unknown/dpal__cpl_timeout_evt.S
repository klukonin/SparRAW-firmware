/* dpal__cpl_timeout_evt @ 0x8c7e98, 208 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DPAL CPL TO Event: cpl_valid_vector = 0x%08X cpl_cnt0 = 0x%08X cpl_cnt1 = 0x%08X
 *   DPAL CPL TO Event: cpl_cnt2 = 0x%08X cpl_cnt3 = 0x%08X cpl_cnt4 = 0x%08X
 *   DPAL CPL TO Event: cpl_cnt5 = 0x%08X cpl_cnt6 = 0x%08X cpl_cnt7 = 0x%08X
 *   DB2 DOCK - GBE Completion Timeout Disconnect
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, fw_log__emit0, fw_log__emit3, l2mgr__wmi_disconnect_log, pcie__clear_cpl_timeout
 */
	.section .text.dpal__cpl_timeout_evt,"ax",@progbits
	.global dpal__cpl_timeout_evt
dpal__cpl_timeout_evt:
L_8c7e98:
	push_s blink
L_8c7e9a:
	bl L_8c02a8
L_8c7e9e:
	mov_s r0,0x882d00
L_8c7ea4:
	ld_s r3,[r0,0x8]
L_8c7ea6:
	ld_s r15,[r0,0xc]
L_8c7ea8:
	extb_s r3,r3
L_8c7eaa:
	ld_s r1,[r0,0xc]
L_8c7eac:
	bmsk r21,r15,0x4
L_8c7eb0:
	lsr_s r1,r1,0x8
L_8c7eb2:
	ld_s r14,[r0,0xc]
L_8c7eb4:
	bmsk r20,r1,0x4
L_8c7eb8:
	lsr_s r14,r14,0x10
L_8c7eba:
	ld_s r2,[r0,0xc]
L_8c7ebc:
	bmsk_s r14,r14,0x4
L_8c7ebe:
	lsr_s r2,r2,0x18
L_8c7ec0:
	bmsk r16,r2,0x4
L_8c7ec4:
	ld_s r2,[r0,0x10]
L_8c7ec6:
	mov_s r1,0x2
L_8c7ec8:
	ld_s r13,[r0,0x10]
L_8c7eca:
	bmsk r18,r2,0x4
L_8c7ece:
	lsr_s r13,r13,0x8
L_8c7ed0:
	ld_s r2,[r0,0x10]
L_8c7ed2:
	bmsk_s r13,r13,0x4
L_8c7ed4:
	lsr_s r2,r2,0x10
L_8c7ed6:
	ld_s r0,[r0,0x10]
L_8c7ed8:
	bmsk r19,r2,0x4
L_8c7edc:
	lsr_s r0,r0,0x18
L_8c7ede:
	bmsk r17,r0,0x4
L_8c7ee2:
	mov_s r2,0x1003bcc
L_8c7ee8:
	mov_s r0,0xf
L_8c7eea:
	mov r4,r21
L_8c7eee:
	bl.d L_8ee034
L_8c7ef2:
	mov r5,r20
L_8c7ef6:
	mov_s r2,0x1003c20
L_8c7efc:
	mov_s r0,0xf
L_8c7efe:
	mov_s r1,0x2
L_8c7f00:
	mov_s r3,r14
L_8c7f02:
	mov r4,r16
L_8c7f06:
	bl.d L_8ee034
L_8c7f0a:
	mov r5,r18
L_8c7f0e:
	mov_s r2,0x1003c6c
L_8c7f14:
	mov_s r0,0xf
L_8c7f16:
	mov_s r1,0x2
L_8c7f18:
	mov_s r3,r13
L_8c7f1a:
	mov r4,r19
L_8c7f1e:
	bl.d L_8ee034
L_8c7f22:
	mov r5,r17
L_8c7f26:
	cmp r21,0x7
L_8c7f2a:
	cmp.eq r20,0x7
L_8c7f2e:
	bne_s L_8c7f5e
L_8c7f30:
	brge r18,r14,L_8c7f5e
L_8c7f34:
	brne r14,r16,L_8c7f5e
L_8c7f38:
	brge r19,r18,L_8c7f5e
L_8c7f3c:
	brne r13,r18,L_8c7f5e
L_8c7f40:
	brlt r19,0x1,L_8c7f5e
L_8c7f44:
	brne r19,r17,L_8c7f5e
L_8c7f48:
	mov_s r2,0x1003cb8
L_8c7f4e:
	mov_s r0,0xf
L_8c7f50:
	bl.d L_8edfb0
L_8c7f54:
	mov_s r1,0x1
L_8c7f56:
	bl.d L_8eb448
L_8c7f5a:
	mov_s r0,0x1
L_8c7f5c:
	b_s L_8c7f62
	.global L_8c7f5e
L_8c7f5e:
	bl L_8f28d4
	.global L_8c7f62
L_8c7f62:
	b L_8c02fc
L_8c7f66:
	nop_s
