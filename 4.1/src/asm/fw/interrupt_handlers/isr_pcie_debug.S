/* isr_pcie_debug @ 0x8c0b30, 284 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   UN HANDLED PCIE DEBUG INTERRUPT (CAUSE=0X%X)
 *   interrupt_handlers.c
 * Зовёт сам: dpal__cpl_timeout_log, fw_log__emit1, fw_sysassert_fatal, pcie_debug__code_to_index, rgf_reg_882680, tail_WBE_DRIVER__pxe_isoc_in_dir_bypass, tail_WBE_DRIVER__pxe_isoc_in_dir_bypass_8ef904, wbe_driver__pcie_debug_isr
 * Глобалы (через gp): 0x800308
 */
	.section .text.isr_pcie_debug,"ax",@progbits
	.global isr_pcie_debug
isr_pcie_debug:
L_8c0b30:
	push_s r12
L_8c0b32:
	st.a mhi,[sp,-0x4]
L_8c0b36:
	st.a mlo,[sp,-0x4]
L_8c0b3a:
	push_s r0
L_8c0b3c:
	push_s r1
L_8c0b3e:
	push_s r2
L_8c0b40:
	push_s r3
L_8c0b42:
	st.a r4,[sp,-0x4]
L_8c0b46:
	st.a r5,[sp,-0x4]
L_8c0b4a:
	st.a r6,[sp,-0x4]
L_8c0b4e:
	st.a r7,[sp,-0x4]
L_8c0b52:
	st.a r8,[sp,-0x4]
L_8c0b56:
	st.a r9,[sp,-0x4]
L_8c0b5a:
	st.a r10,[sp,-0x4]
L_8c0b5e:
	st.a r11,[sp,-0x4]
L_8c0b62:
	push_s r13
L_8c0b64:
	push_s r14
L_8c0b66:
	st.a r16,[sp,-0x4]
L_8c0b6a:
	st.a lp_count,[sp,-0x4]
L_8c0b6e:
	lr r12,[0x2]
L_8c0b72:
	push_s r12
L_8c0b74:
	lr r12,[0x3]
L_8c0b78:
	push_s r12
L_8c0b7a:
	push_s blink
L_8c0b7c:
	ld_s r0,[gp,0x198]
L_8c0b7e:
	mov_s r13,0x0
L_8c0b80:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c0b82:
	bl.d L_8ce474
L_8c0b86:
	st.as r0,[gp,0x66]
L_8c0b8a:
	mov_s r16,r0
L_8c0b8c:
	bl.d L_8ce480
L_8c0b90:
	mov_s r1,r13
L_8c0b92:
	breq_s r0,0,L_8c0b9a
L_8c0b94:
	bl.d L_8efa7c
L_8c0b98:
	mov_s r13,0x1
	.global L_8c0b9a
L_8c0b9a:
	mov_s r0,r16
L_8c0b9c:
	mov_s r14,0x1
L_8c0b9e:
	bl.d L_8ce480
L_8c0ba2:
	mov_s r1,r14
L_8c0ba4:
	breq_s r0,0,L_8c0bac
L_8c0ba6:
	bl.d L_8c7f68
L_8c0baa:
	mov_s r13,r14
	.global L_8c0bac
L_8c0bac:
	mov_s r0,r16
L_8c0bae:
	bl.d L_8ce480
L_8c0bb2:
	mov_s r1,0x2
L_8c0bb4:
	breq_s r0,0,L_8c0bbc
L_8c0bb6:
	bl.d L_8ef8fc
L_8c0bba:
	mov_s r13,0x1
	.global L_8c0bbc
L_8c0bbc:
	mov_s r0,r16
L_8c0bbe:
	bl.d L_8ce480
L_8c0bc2:
	mov_s r1,0x3
L_8c0bc4:
	breq_s r0,0,L_8c0bcc
L_8c0bc6:
	bl.d L_8ef904
L_8c0bca:
	mov_s r13,0x1
	.global L_8c0bcc
L_8c0bcc:
	brne_s r13,0,L_8c0bf4
L_8c0bce:
	mov_s r2,0x1000268
L_8c0bd4:
	mov_s r0,0x0
L_8c0bd6:
	mov_s r1,r0
L_8c0bd8:
	bl.d L_8edfcc
L_8c0bdc:
	mov_s r3,r16
L_8c0bde:
	mov_s r0,blink
L_8c0be0:
	mov_s r2,0x1000250
L_8c0be6:
	mov_s r1,0x11a9
L_8c0bec:
	bl.d L_8c82c0
L_8c0bf0:
	mov r3,0x154
	.global L_8c0bf4
L_8c0bf4:
	pop_s blink
L_8c0bf6:
	pop_s r12
L_8c0bf8:
	sr r12,[0x3]
L_8c0bfc:
	pop_s r12
L_8c0bfe:
	sr r12,[0x2]
L_8c0c02:
	pop_s r12
L_8c0c04:
	mov_s lp_count,r12
L_8c0c06:
	ld.ab r16,[sp,0x4]
L_8c0c0a:
	pop_s r14
L_8c0c0c:
	pop_s r13
L_8c0c0e:
	ld.ab r11,[sp,0x4]
L_8c0c12:
	ld.ab r10,[sp,0x4]
L_8c0c16:
	ld.ab r9,[sp,0x4]
L_8c0c1a:
	ld.ab r8,[sp,0x4]
L_8c0c1e:
	ld.ab r7,[sp,0x4]
L_8c0c22:
	ld.ab r6,[sp,0x4]
L_8c0c26:
	ld.ab r5,[sp,0x4]
L_8c0c2a:
	ld.ab r4,[sp,0x4]
L_8c0c2e:
	pop_s r3
L_8c0c30:
	pop_s r2
L_8c0c32:
	pop_s r1
L_8c0c34:
	pop_s r0
L_8c0c36:
	pop_s r12
L_8c0c38:
	mulu64 r12,0x1
L_8c0c3c:
	mov 0x0,mlo
L_8c0c40:
	pop_s r12
L_8c0c42:
	sr r12,[0x12]
L_8c0c46:
	pop_s r12
L_8c0c48:
	j.f [ilink1]
