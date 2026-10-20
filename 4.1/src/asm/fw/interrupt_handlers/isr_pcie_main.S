/* isr_pcie_main @ 0x8c0c4c, 672 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PCIE_ISR perst deassert interrupt...
 *   PCIE_ISR phy_pll_lock before wait == %d, cnt started at %d
 *   PCIE_ISR could not handle perst_deassert, got another perst assert !
 *   PCIE_ISR phy_pll_lock after wait == %d, cnt stopped at %d
 *   PCIE_ISR starting DBI writes...
 *   	>>> A2 PCIE SSID/SSVID Workaround
 *   PCIE_ISR could not start DBI writes, phy_pll_lock is not ready
 *   interrupt_handlers.c
 * Зовёт сам: POWER_MNGR__deep_sleep_exit, WBE_DRIVER__link_down_notif, WBE_DRIVER__link_up_notif, dbi_write_seq, fw_log__emit0, fw_log__emit2, fw_sysassert_fatal, get_reg88262c_s11_w32, hwd_pcie__get_882b80, hwd_pcie__rgf_882600, hwd_pcie_exit_l1, pcie__clear_dbi_gateway
 * Глобалы (через gp): 0x800354
 */
	.section .text.isr_pcie_main,"ax",@progbits
	.global isr_pcie_main
isr_pcie_main:
L_8c0c4c:
	push_s r12
L_8c0c4e:
	st.a mhi,[sp,-0x4]
L_8c0c52:
	st.a mlo,[sp,-0x4]
L_8c0c56:
	push_s r0
L_8c0c58:
	push_s r1
L_8c0c5a:
	push_s r2
L_8c0c5c:
	push_s r3
L_8c0c5e:
	st.a r4,[sp,-0x4]
L_8c0c62:
	st.a r5,[sp,-0x4]
L_8c0c66:
	st.a r6,[sp,-0x4]
L_8c0c6a:
	st.a r7,[sp,-0x4]
L_8c0c6e:
	st.a r8,[sp,-0x4]
L_8c0c72:
	st.a r9,[sp,-0x4]
L_8c0c76:
	st.a r10,[sp,-0x4]
L_8c0c7a:
	st.a r11,[sp,-0x4]
L_8c0c7e:
	push_s r13
L_8c0c80:
	push_s r14
L_8c0c82:
	push_s r15
L_8c0c84:
	st.a r16,[sp,-0x4]
L_8c0c88:
	st.a r17,[sp,-0x4]
L_8c0c8c:
	st.a lp_count,[sp,-0x4]
L_8c0c90:
	lr r12,[0x2]
L_8c0c94:
	push_s r12
L_8c0c96:
	lr r12,[0x3]
L_8c0c9a:
	push_s r12
L_8c0c9c:
	push_s blink
L_8c0c9e:
	bl.d L_8c7460
L_8c0ca2:
	mov_s r0,0x5
L_8c0ca4:
	bl.d L_8ce6d8
L_8c0ca8:
	mov_s r14,0x0
L_8c0caa:
	mov_s r16,r0
L_8c0cac:
	bl.d L_8ce788
L_8c0cb0:
	mov_s r1,r14
L_8c0cb2:
	cmp_s r0,0x0
L_8c0cb4:
	mov.eq r13,r14
L_8c0cb8:
	beq_s L_8c0cc4
L_8c0cba:
	bl.d L_8e91c4
L_8c0cbe:
	mov_s r13,0x1
L_8c0cc0:
	bl L_8e94c8
	.global L_8c0cc4
L_8c0cc4:
	mov_s r0,r16
L_8c0cc6:
	mov_s r15,0x1
L_8c0cc8:
	bl.d L_8ce788
L_8c0ccc:
	mov_s r1,r15
L_8c0cce:
	breq_s r0,0,L_8c0cd8
L_8c0cd0:
	bl.d L_8edb14
L_8c0cd4:
	mov_s r0,0x0
L_8c0cd6:
	mov_s r13,r15
	.global L_8c0cd8
L_8c0cd8:
	mov_s r0,r16
L_8c0cda:
	bl.d L_8ce788
L_8c0cde:
	mov_s r1,0x2
L_8c0ce0:
	breq_s r0,0,L_8c0cea
L_8c0ce2:
	bl.d L_8edb14
L_8c0ce6:
	mov_s r0,0x1
L_8c0ce8:
	mov_s r13,0x1
	.global L_8c0cea
L_8c0cea:
	mov_s r0,r16
L_8c0cec:
	bl.d L_8ce788
L_8c0cf0:
	mov_s r1,0x3
L_8c0cf2:
	breq_s r0,0,L_8c0cfc
L_8c0cf4:
	bl.d L_8edb14
L_8c0cf8:
	mov_s r0,0x2
L_8c0cfa:
	mov_s r13,0x1
	.global L_8c0cfc
L_8c0cfc:
	mov_s r0,r16
L_8c0cfe:
	bl.d L_8ce788
L_8c0d02:
	mov_s r1,0x4
L_8c0d04:
	breq_s r0,0,L_8c0d0e
L_8c0d06:
	bl.d L_8eda38
L_8c0d0a:
	mov_s r0,0x0
L_8c0d0c:
	mov_s r13,0x1
	.global L_8c0d0e
L_8c0d0e:
	mov_s r0,r16
L_8c0d10:
	bl.d L_8ce788
L_8c0d14:
	mov_s r1,0x5
L_8c0d16:
	breq r0,0x0,L_8c0dfe
L_8c0d1a:
	mov_s r2,0x1000298
L_8c0d20:
	mov_s r0,0x0
L_8c0d22:
	bl.d L_8edfb0
L_8c0d26:
	mov_s r1,0x2
L_8c0d28:
	bl.d L_8ce578
L_8c0d2c:
	mov_s r0,0x1
L_8c0d2e:
	mov r17,0x186a0
L_8c0d36:
	bl.d L_8ce738
L_8c0d3a:
	mov_s r13,r14
L_8c0d3c:
	mov_s r3,r0
L_8c0d3e:
	mov_s r2,0x10002c0
L_8c0d44:
	mov_s r0,0x0
L_8c0d46:
	mov_s r1,0x2
L_8c0d48:
	bl.d L_8edff8
L_8c0d4c:
	mov r4,r17
L_8c0d50:
	b_s L_8c0d62
	.global L_8c0d52
L_8c0d52:
	bl L_8ce72c
L_8c0d56:
	bl.d L_8ce738
L_8c0d5a:
	mov_s r14,r0
L_8c0d5c:
	mov_s r13,r0
L_8c0d5e:
	breq_s r14,0,L_8c0d6e
L_8c0d60:
	brne_s r13,0,L_8c0d7e
	.global L_8c0d62
L_8c0d62:
	sub r17,r17,0x1
L_8c0d66:
	cmp r17,-0x1
L_8c0d6a:
	bne_s L_8c0d52
L_8c0d6c:
	b_s L_8c0d96
	.global L_8c0d6e
L_8c0d6e:
	mov_s r2,0x10002fc
L_8c0d74:
	mov_s r0,0x0
L_8c0d76:
	bl.d L_8edfb0
L_8c0d7a:
	mov_s r1,0x2
L_8c0d7c:
	b_s L_8c0d96
	.global L_8c0d7e
L_8c0d7e:
	bl L_8ce738
L_8c0d82:
	mov_s r2,0x1000344
L_8c0d88:
	mov_s r3,r0
L_8c0d8a:
	mov_s r0,0x0
L_8c0d8c:
	mov_s r1,0x2
L_8c0d8e:
	bl.d L_8edff8
L_8c0d92:
	mov r4,r17
	.global L_8c0d96
L_8c0d96:
	breq_s r14,0,L_8c0df0
L_8c0d98:
	breq_s r13,0,L_8c0dcc
L_8c0d9a:
	mov_s r2,0x1000380
L_8c0da0:
	mov_s r0,0x0
L_8c0da2:
	bl.d L_8edfb0
L_8c0da6:
	mov_s r1,0x2
L_8c0da8:
	bl L_8ea418
L_8c0dac:
	mov_s r2,0x10003a0
L_8c0db2:
	mov_s r0,0x0
L_8c0db4:
	bl.d L_8edfb0
L_8c0db8:
	mov_s r1,0x1
L_8c0dba:
	bl L_8eecc8
L_8c0dbe:
	bl L_8ea124
L_8c0dc2:
	bl L_8e94c8
L_8c0dc6:
	bl L_8ea418
L_8c0dca:
	b_s L_8c0df0
	.global L_8c0dcc
L_8c0dcc:
	mov_s r2,0x10003c4
L_8c0dd2:
	mov_s r0,0x0
L_8c0dd4:
	bl.d L_8edfb0
L_8c0dd8:
	mov_s r1,r0
L_8c0dda:
	mov_s r0,blink
L_8c0ddc:
	mov_s r2,0x1000250
L_8c0de2:
	mov_s r1,0x11aa
L_8c0de8:
	bl.d L_8c82c0
L_8c0dec:
	mov r3,0x1c2
	.global L_8c0df0
L_8c0df0:
	bl.d L_8ce578
L_8c0df4:
	mov_s r0,0x0
L_8c0df6:
	bl.d L_8dc3a4
L_8c0dfa:
	mov_s r0,0x5
L_8c0dfc:
	mov_s r13,0x1
	.global L_8c0dfe
L_8c0dfe:
	mov_s r0,r16
L_8c0e00:
	bl.d L_8ce788
L_8c0e04:
	mov_s r1,0x6
L_8c0e06:
	breq_s r0,0,L_8c0e38
L_8c0e08:
	ld_s r0,[gp,0x1e4]
L_8c0e0a:
	breq_s r0,0,L_8c0e38
L_8c0e0c:
	mov_s r2,0x1000404
L_8c0e12:
	mov_s r0,0x0
L_8c0e14:
	bl.d L_8edfb0
L_8c0e18:
	mov_s r1,0x2
L_8c0e1a:
	bl L_8ce72c
L_8c0e1e:
	brne_s r0,0,L_8c0e28
L_8c0e20:
	bl.d L_8dc3a4
L_8c0e24:
	mov_s r0,0x6
L_8c0e26:
	b_s L_8c0e36
	.global L_8c0e28
L_8c0e28:
	mov_s r2,0x1000428
L_8c0e2e:
	mov_s r0,0x0
L_8c0e30:
	bl.d L_8edfb0
L_8c0e34:
	mov_s r1,0x2
	.global L_8c0e36
L_8c0e36:
	mov_s r13,0x1
	.global L_8c0e38
L_8c0e38:
	mov_s r0,r16
L_8c0e3a:
	bl.d L_8ce788
L_8c0e3e:
	mov_s r1,0x8
L_8c0e40:
	breq_s r0,0,L_8c0e58
L_8c0e42:
	mov_s r2,0x1000470
L_8c0e48:
	mov_s r0,0x0
L_8c0e4a:
	bl.d L_8edfb0
L_8c0e4e:
	mov_s r1,0x2
L_8c0e50:
	bl.d L_8dc3a4
L_8c0e54:
	mov_s r0,0x8
L_8c0e56:
	mov_s r13,0x1
	.global L_8c0e58
L_8c0e58:
	mov_s r0,r16
L_8c0e5a:
	bl.d L_8ce788
L_8c0e5e:
	mov_s r1,0x9
L_8c0e60:
	breq_s r0,0,L_8c0e78
L_8c0e62:
	mov_s r2,0x1000490
L_8c0e68:
	mov_s r0,0x0
L_8c0e6a:
	bl.d L_8edfb0
L_8c0e6e:
	mov_s r1,0x2
L_8c0e70:
	bl.d L_8dc3a4
L_8c0e74:
	mov_s r0,0x9
L_8c0e76:
	mov_s r13,0x1
	.global L_8c0e78
L_8c0e78:
	brne_s r13,0,L_8c0e90
L_8c0e7a:
	mov_s r0,blink
L_8c0e7c:
	mov_s r2,0x1000250
L_8c0e82:
	mov_s r1,0x11ab
L_8c0e88:
	bl.d L_8c82c0
L_8c0e8c:
	mov r3,0x202
	.global L_8c0e90
L_8c0e90:
	pop_s blink
L_8c0e92:
	pop_s r12
L_8c0e94:
	sr r12,[0x3]
L_8c0e98:
	pop_s r12
L_8c0e9a:
	sr r12,[0x2]
L_8c0e9e:
	pop_s r12
L_8c0ea0:
	mov_s lp_count,r12
L_8c0ea2:
	ld.ab r17,[sp,0x4]
L_8c0ea6:
	ld.ab r16,[sp,0x4]
L_8c0eaa:
	pop_s r15
L_8c0eac:
	pop_s r14
L_8c0eae:
	pop_s r13
L_8c0eb0:
	ld.ab r11,[sp,0x4]
L_8c0eb4:
	ld.ab r10,[sp,0x4]
L_8c0eb8:
	ld.ab r9,[sp,0x4]
L_8c0ebc:
	ld.ab r8,[sp,0x4]
L_8c0ec0:
	ld.ab r7,[sp,0x4]
L_8c0ec4:
	ld.ab r6,[sp,0x4]
L_8c0ec8:
	ld.ab r5,[sp,0x4]
L_8c0ecc:
	ld.ab r4,[sp,0x4]
L_8c0ed0:
	pop_s r3
L_8c0ed2:
	pop_s r2
L_8c0ed4:
	pop_s r1
L_8c0ed6:
	pop_s r0
L_8c0ed8:
	pop_s r12
L_8c0eda:
	mulu64 r12,0x1
L_8c0ede:
	mov 0x0,mlo
L_8c0ee2:
	pop_s r12
L_8c0ee4:
	sr r12,[0x12]
L_8c0ee8:
	pop_s r12
L_8c0eea:
	.byte 0x20,0x20
