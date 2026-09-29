/* fw_vector_18 @ 0x8c0f64, 256 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PCIE UNIT_ICR_PORT0_LTSSM_DBG_1: UN HANDLED INTERRUPT (CAUSE=0x%X)
 * Зовёт сам: POWER_MNGR__deep_sleep_exit, fw_log_emit1, fw_sysassert_fatal, fw_vector_18__pair, hwd_pcie__rgf_882f80, hwd_pcie_l1_enter_isr, pcie_ltssm__code_to_index
 * Глобалы (через gp): 0x800294, 0x800296
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_vector_18
fw_vector_18:
	.global L_8c0f64
L_8c0f64:
	push_s r12
L_8c0f66:
	st.a mhi,[sp,-0x4]
L_8c0f6a:
	st.a mlo,[sp,-0x4]
L_8c0f6e:
	push_s r0
L_8c0f70:
	push_s r1
L_8c0f72:
	push_s r2
L_8c0f74:
	push_s r3
L_8c0f76:
	st.a r4,[sp,-0x4]
L_8c0f7a:
	st.a r5,[sp,-0x4]
L_8c0f7e:
	st.a r6,[sp,-0x4]
L_8c0f82:
	st.a r7,[sp,-0x4]
L_8c0f86:
	st.a r8,[sp,-0x4]
L_8c0f8a:
	st.a r9,[sp,-0x4]
L_8c0f8e:
	st.a r10,[sp,-0x4]
L_8c0f92:
	st.a r11,[sp,-0x4]
L_8c0f96:
	push_s r13
L_8c0f98:
	push_s r14
L_8c0f9a:
	st.a r16,[sp,-0x4]
L_8c0f9e:
	st.a lp_count,[sp,-0x4]
L_8c0fa2:
	lr r12,[0x2]
L_8c0fa6:
	push_s r12
L_8c0fa8:
	lr r12,[0x3]
L_8c0fac:
	push_s r12
L_8c0fae:
	push_s blink
L_8c0fb0:
	bl.d L_8c8a34
L_8c0fb4:
	mov_s r0,0x2
L_8c0fb6:
	bl.d L_8d13e0
L_8c0fba:
	mov_s r14,0x0
L_8c0fbc:
	mov_s r16,r0
L_8c0fbe:
	bl.d L_8d158c
L_8c0fc2:
	mov_s r1,r14
L_8c0fc4:
	breq_s r0,0,L_8c0fd4
L_8c0fc6:
	ldw_s r0,[gp,0x110]
L_8c0fc8:
	mov_s r14,0x1
L_8c0fca:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c0fcc:
	bl.d L_8d15d0
L_8c0fd0:
	stw.as r0,[gp,0x88]
	.global L_8c0fd4
L_8c0fd4:
	mov_s r0,r16
L_8c0fd6:
	mov_s r13,0x1
L_8c0fd8:
	bl.d L_8d158c
L_8c0fdc:
	mov_s r1,r13
L_8c0fde:
	breq_s r0,0,L_8c0fee
L_8c0fe0:
	ldw_s r0,[gp,0x112]
L_8c0fe2:
	mov_s r14,r13
L_8c0fe4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c0fe6:
	bl.d L_8d162c
L_8c0fea:
	stw.as r0,[gp,0x89]
	.global L_8c0fee
L_8c0fee:
	brne_s r14,0,L_8c100a
L_8c0ff0:
	mov_s r1,0x10004b0
L_8c0ff6:
	mov_s r0,0x0
L_8c0ff8:
	bl.d L_8dcc10
L_8c0ffc:
	mov_s r2,r16
L_8c0ffe:
	mov_s r0,blink
L_8c1000:
	mov_s r1,0x130c
L_8c1006:
	bl L_8c9b28
	.global L_8c100a
L_8c100a:
	pop_s blink
L_8c100c:
	pop_s r12
L_8c100e:
	sr r12,[0x3]
L_8c1012:
	pop_s r12
L_8c1014:
	sr r12,[0x2]
L_8c1018:
	pop_s r12
L_8c101a:
	mov_s lp_count,r12
L_8c101c:
	ld.ab r16,[sp,0x4]
L_8c1020:
	pop_s r14
L_8c1022:
	pop_s r13
L_8c1024:
	ld.ab r11,[sp,0x4]
L_8c1028:
	ld.ab r10,[sp,0x4]
L_8c102c:
	ld.ab r9,[sp,0x4]
L_8c1030:
	ld.ab r8,[sp,0x4]
L_8c1034:
	ld.ab r7,[sp,0x4]
L_8c1038:
	ld.ab r6,[sp,0x4]
L_8c103c:
	ld.ab r5,[sp,0x4]
L_8c1040:
	ld.ab r4,[sp,0x4]
L_8c1044:
	pop_s r3
L_8c1046:
	pop_s r2
L_8c1048:
	pop_s r1
L_8c104a:
	pop_s r0
L_8c104c:
	pop_s r12
L_8c104e:
	mulu64 r12,0x1
L_8c1052:
	mov 0x0,mlo
L_8c1056:
	pop_s r12
L_8c1058:
	sr r12,[0x12]
L_8c105c:
	pop_s r12
L_8c105e:
	j.f [ilink1]
L_8c1062:
	nop_s
