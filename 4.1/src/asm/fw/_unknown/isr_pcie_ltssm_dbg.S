/* isr_pcie_ltssm_dbg @ 0x8c0ef4, 268 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PCIE UNIT_ICR_PORT0_LTSSM_DBG_1: UN HANDLED INTERRUPT (CAUSE=0x%X)
 *   interrupt_handlers.c
 * Зовёт сам: POWER_MNGR__deep_sleep_exit, fw_log__emit1, fw_sysassert_fatal, hwd_pcie__rgf_882f80, hwd_pcie_l1_enter_isr, hwd_pcie_l1_exit_isr, pcie_ltssm__code_to_index
 * Глобалы (через gp): 0x800280, 0x800282
 */
	.section .text.isr_pcie_ltssm_dbg,"ax",@progbits
	.global isr_pcie_ltssm_dbg
isr_pcie_ltssm_dbg:
L_8c0ef4:
	push_s r12
L_8c0ef6:
	st.a mhi,[sp,-0x4]
L_8c0efa:
	st.a mlo,[sp,-0x4]
L_8c0efe:
	push_s r0
L_8c0f00:
	push_s r1
L_8c0f02:
	push_s r2
L_8c0f04:
	push_s r3
L_8c0f06:
	st.a r4,[sp,-0x4]
L_8c0f0a:
	st.a r5,[sp,-0x4]
L_8c0f0e:
	st.a r6,[sp,-0x4]
L_8c0f12:
	st.a r7,[sp,-0x4]
L_8c0f16:
	st.a r8,[sp,-0x4]
L_8c0f1a:
	st.a r9,[sp,-0x4]
L_8c0f1e:
	st.a r10,[sp,-0x4]
L_8c0f22:
	st.a r11,[sp,-0x4]
L_8c0f26:
	push_s r13
L_8c0f28:
	push_s r14
L_8c0f2a:
	st.a r16,[sp,-0x4]
L_8c0f2e:
	st.a lp_count,[sp,-0x4]
L_8c0f32:
	lr r12,[0x2]
L_8c0f36:
	push_s r12
L_8c0f38:
	lr r12,[0x3]
L_8c0f3c:
	push_s r12
L_8c0f3e:
	push_s blink
L_8c0f40:
	bl.d L_8c7460
L_8c0f44:
	mov_s r0,0x2
L_8c0f46:
	bl.d L_8ce6e4
L_8c0f4a:
	mov_s r14,0x0
L_8c0f4c:
	mov_s r16,r0
L_8c0f4e:
	bl.d L_8ce894
L_8c0f52:
	mov_s r1,r14
L_8c0f54:
	breq_s r0,0,L_8c0f64
L_8c0f56:
	ldw_s r0,[gp,0x110]
L_8c0f58:
	mov_s r14,0x1
L_8c0f5a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c0f5c:
	bl.d L_8ce8d8
L_8c0f60:
	stw.as r0,[gp,0x88]
	.global L_8c0f64
L_8c0f64:
	mov_s r0,r16
L_8c0f66:
	mov_s r13,0x1
L_8c0f68:
	bl.d L_8ce894
L_8c0f6c:
	mov_s r1,r13
L_8c0f6e:
	breq_s r0,0,L_8c0f7e
L_8c0f70:
	ldw_s r0,[gp,0x112]
L_8c0f72:
	mov_s r14,r13
L_8c0f74:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c0f76:
	bl.d L_8ce938
L_8c0f7a:
	stw.as r0,[gp,0x89]
	.global L_8c0f7e
L_8c0f7e:
	brne_s r14,0,L_8c0fa6
L_8c0f80:
	mov_s r2,0x10004b0
L_8c0f86:
	mov_s r0,0x0
L_8c0f88:
	mov_s r1,r0
L_8c0f8a:
	bl.d L_8edfcc
L_8c0f8e:
	mov_s r3,r16
L_8c0f90:
	mov_s r0,blink
L_8c0f92:
	mov_s r2,0x1000250
L_8c0f98:
	mov_s r1,0x130c
L_8c0f9e:
	bl.d L_8c82c0
L_8c0fa2:
	mov r3,0x237
	.global L_8c0fa6
L_8c0fa6:
	pop_s blink
L_8c0fa8:
	pop_s r12
L_8c0faa:
	sr r12,[0x3]
L_8c0fae:
	pop_s r12
L_8c0fb0:
	sr r12,[0x2]
L_8c0fb4:
	pop_s r12
L_8c0fb6:
	mov_s lp_count,r12
L_8c0fb8:
	ld.ab r16,[sp,0x4]
L_8c0fbc:
	pop_s r14
L_8c0fbe:
	pop_s r13
L_8c0fc0:
	ld.ab r11,[sp,0x4]
L_8c0fc4:
	ld.ab r10,[sp,0x4]
L_8c0fc8:
	ld.ab r9,[sp,0x4]
L_8c0fcc:
	ld.ab r8,[sp,0x4]
L_8c0fd0:
	ld.ab r7,[sp,0x4]
L_8c0fd4:
	ld.ab r6,[sp,0x4]
L_8c0fd8:
	ld.ab r5,[sp,0x4]
L_8c0fdc:
	ld.ab r4,[sp,0x4]
L_8c0fe0:
	pop_s r3
L_8c0fe2:
	pop_s r2
L_8c0fe4:
	pop_s r1
L_8c0fe6:
	pop_s r0
L_8c0fe8:
	pop_s r12
L_8c0fea:
	mulu64 r12,0x1
L_8c0fee:
	mov 0x0,mlo
L_8c0ff2:
	pop_s r12
L_8c0ff4:
	sr r12,[0x12]
L_8c0ff8:
	pop_s r12
L_8c0ffa:
	j.f [ilink1]
L_8c0ffe:
	nop_s
