/* fw_vector_15 @ 0x8c0be4, 272 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   UN HANDLED PCIE DEBUG INTERRUPT (CAUSE=0X%X)
 * Зовёт сам: dpal__cpl_timeout_log, fw_log_emit1, fw_sysassert_fatal, pcie_debug__code_to_index, pcie_debug__read_and_ack_cause, pxe__isoc_in_dir_bypass_off, pxe__isoc_in_dir_bypass_on, wbe_driver__pcie_debug_isr
 * Глобалы (через gp): 0x80031c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_vector_15
fw_vector_15:
	.global L_8c0be4
L_8c0be4:
	push_s r12
L_8c0be6:
	st.a mhi,[sp,-0x4]
L_8c0bea:
	st.a mlo,[sp,-0x4]
L_8c0bee:
	push_s r0
L_8c0bf0:
	push_s r1
L_8c0bf2:
	push_s r2
L_8c0bf4:
	push_s r3
L_8c0bf6:
	st.a r4,[sp,-0x4]
L_8c0bfa:
	st.a r5,[sp,-0x4]
L_8c0bfe:
	st.a r6,[sp,-0x4]
L_8c0c02:
	st.a r7,[sp,-0x4]
L_8c0c06:
	st.a r8,[sp,-0x4]
L_8c0c0a:
	st.a r9,[sp,-0x4]
L_8c0c0e:
	st.a r10,[sp,-0x4]
L_8c0c12:
	st.a r11,[sp,-0x4]
L_8c0c16:
	push_s r13
L_8c0c18:
	push_s r14
L_8c0c1a:
	st.a r16,[sp,-0x4]
L_8c0c1e:
	st.a lp_count,[sp,-0x4]
L_8c0c22:
	lr r12,[0x2]
L_8c0c26:
	push_s r12
L_8c0c28:
	lr r12,[0x3]
L_8c0c2c:
	push_s r12
L_8c0c2e:
	push_s blink
L_8c0c30:
	ld_s r0,[gp,0x198]
L_8c0c32:
	mov_s r13,0x0
L_8c0c34:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c0c36:
	bl.d L_8d11b8
L_8c0c3a:
	st.as r0,[gp,0x66]
L_8c0c3e:
	mov_s r16,r0
L_8c0c40:
	bl.d L_8d11c4
L_8c0c44:
	mov_s r1,r13
L_8c0c46:
	breq_s r0,0,L_8c0c4e
L_8c0c48:
	bl.d L_8f7e5c
L_8c0c4c:
	mov_s r13,0x1
	.global L_8c0c4e
L_8c0c4e:
	mov_s r0,r16
L_8c0c50:
	mov_s r14,0x1
L_8c0c52:
	bl.d L_8d11c4
L_8c0c56:
	mov_s r1,r14
L_8c0c58:
	breq_s r0,0,L_8c0c60
L_8c0c5a:
	bl.d L_8c9768
L_8c0c5e:
	mov_s r13,r14
	.global L_8c0c60
L_8c0c60:
	mov_s r0,r16
L_8c0c62:
	bl.d L_8d11c4
L_8c0c66:
	mov_s r1,0x2
L_8c0c68:
	breq_s r0,0,L_8c0c70
L_8c0c6a:
	bl.d L_8f7d10
L_8c0c6e:
	mov_s r13,0x1
	.global L_8c0c70
L_8c0c70:
	mov_s r0,r16
L_8c0c72:
	bl.d L_8d11c4
L_8c0c76:
	mov_s r1,0x3
L_8c0c78:
	breq_s r0,0,L_8c0c80
L_8c0c7a:
	bl.d L_8f7d18
L_8c0c7e:
	mov_s r13,0x1
	.global L_8c0c80
L_8c0c80:
	brne_s r13,0,L_8c0c9c
L_8c0c82:
	mov_s r1,0x1000264
L_8c0c88:
	mov_s r0,0x0
L_8c0c8a:
	bl.d L_8dcc10
L_8c0c8e:
	mov_s r2,r16
L_8c0c90:
	mov_s r0,blink
L_8c0c92:
	mov_s r1,0x11a9
L_8c0c98:
	bl L_8c9b28
	.global L_8c0c9c
L_8c0c9c:
	pop_s blink
L_8c0c9e:
	pop_s r12
L_8c0ca0:
	sr r12,[0x3]
L_8c0ca4:
	pop_s r12
L_8c0ca6:
	sr r12,[0x2]
L_8c0caa:
	pop_s r12
L_8c0cac:
	mov_s lp_count,r12
L_8c0cae:
	ld.ab r16,[sp,0x4]
L_8c0cb2:
	pop_s r14
L_8c0cb4:
	pop_s r13
L_8c0cb6:
	ld.ab r11,[sp,0x4]
L_8c0cba:
	ld.ab r10,[sp,0x4]
L_8c0cbe:
	ld.ab r9,[sp,0x4]
L_8c0cc2:
	ld.ab r8,[sp,0x4]
L_8c0cc6:
	ld.ab r7,[sp,0x4]
L_8c0cca:
	ld.ab r6,[sp,0x4]
L_8c0cce:
	ld.ab r5,[sp,0x4]
L_8c0cd2:
	ld.ab r4,[sp,0x4]
L_8c0cd6:
	pop_s r3
L_8c0cd8:
	pop_s r2
L_8c0cda:
	pop_s r1
L_8c0cdc:
	pop_s r0
L_8c0cde:
	pop_s r12
L_8c0ce0:
	mulu64 r12,0x1
L_8c0ce4:
	mov 0x0,mlo
L_8c0ce8:
	pop_s r12
L_8c0cea:
	sr r12,[0x12]
L_8c0cee:
	pop_s r12
L_8c0cf0:
	j.f [ilink1]
