/* fw_vector_16 @ 0x8c0cf4, 620 байт.  Сгенерировано gen_asm_tree.py
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
 *       >>> A2 PCIE SSID/SSVID Workaround
 *   PCIE_ISR could not start DBI writes, phy_pll_lock is not ready
 *   PCIE_ISR perst assert interrupt...
 * Зовёт сам: POWER_MNGR__deep_sleep_exit, WBE_DRIVER__link_down_notif, WBE_DRIVER__link_up_notif, ba_setup_sm__addba_resp, fw_log_emit0, fw_log_emit2, fw_sysassert_fatal, hwd_pcie__get_882b80, hwd_pcie__rgf_882600, hwd_pcie_exit_l1, isr16__pcie_l1_latency_wa, pcie__clear_dbi_gateway
 * Глобалы (через gp): 0x800378
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_vector_16
fw_vector_16:
	.global L_8c0cf4
L_8c0cf4:
	push_s r12
L_8c0cf6:
	st.a mhi,[sp,-0x4]
L_8c0cfa:
	st.a mlo,[sp,-0x4]
L_8c0cfe:
	push_s r0
L_8c0d00:
	push_s r1
L_8c0d02:
	push_s r2
L_8c0d04:
	push_s r3
L_8c0d06:
	st.a r4,[sp,-0x4]
L_8c0d0a:
	st.a r5,[sp,-0x4]
L_8c0d0e:
	st.a r6,[sp,-0x4]
L_8c0d12:
	st.a r7,[sp,-0x4]
L_8c0d16:
	st.a r8,[sp,-0x4]
L_8c0d1a:
	st.a r9,[sp,-0x4]
L_8c0d1e:
	st.a r10,[sp,-0x4]
L_8c0d22:
	st.a r11,[sp,-0x4]
L_8c0d26:
	push_s r13
L_8c0d28:
	push_s r14
L_8c0d2a:
	push_s r15
L_8c0d2c:
	st.a r16,[sp,-0x4]
L_8c0d30:
	st.a lp_count,[sp,-0x4]
L_8c0d34:
	lr r12,[0x2]
L_8c0d38:
	push_s r12
L_8c0d3a:
	lr r12,[0x3]
L_8c0d3e:
	push_s r12
L_8c0d40:
	push_s blink
L_8c0d42:
	bl.d L_8c8a34
L_8c0d46:
	mov_s r0,0x5
L_8c0d48:
	bl.d L_8d13d4
L_8c0d4c:
	mov_s r14,0x0
L_8c0d4e:
	mov_s r16,r0
L_8c0d50:
	bl.d L_8d1484
L_8c0d54:
	mov_s r1,r14
L_8c0d56:
	cmp_s r0,0x0
L_8c0d58:
	mov.eq r13,r14
L_8c0d5c:
	beq_s L_8c0d68
L_8c0d5e:
	bl.d L_8f0a44
L_8c0d62:
	mov_s r13,0x1
L_8c0d64:
	bl L_8f0d28
	.global L_8c0d68
L_8c0d68:
	mov_s r0,r16
L_8c0d6a:
	mov_s r15,0x1
L_8c0d6c:
	bl.d L_8d1484
L_8c0d70:
	mov_s r1,r15
L_8c0d72:
	breq_s r0,0,L_8c0d7c
L_8c0d74:
	bl.d L_8f5ea8
L_8c0d78:
	mov_s r0,0x0
L_8c0d7a:
	mov_s r13,r15
	.global L_8c0d7c
L_8c0d7c:
	mov_s r0,r16
L_8c0d7e:
	bl.d L_8d1484
L_8c0d82:
	mov_s r1,0x2
L_8c0d84:
	breq_s r0,0,L_8c0d8e
L_8c0d86:
	bl.d L_8f5ea8
L_8c0d8a:
	mov_s r0,0x1
L_8c0d8c:
	mov_s r13,0x1
	.global L_8c0d8e
L_8c0d8e:
	mov_s r0,r16
L_8c0d90:
	bl.d L_8d1484
L_8c0d94:
	mov_s r1,0x3
L_8c0d96:
	breq_s r0,0,L_8c0da0
L_8c0d98:
	bl.d L_8f5ea8
L_8c0d9c:
	mov_s r0,0x2
L_8c0d9e:
	mov_s r13,0x1
	.global L_8c0da0
L_8c0da0:
	mov_s r0,r16
L_8c0da2:
	bl.d L_8d1484
L_8c0da6:
	mov_s r1,0x4
L_8c0da8:
	breq_s r0,0,L_8c0db2
L_8c0daa:
	bl.d L_8f5dd4
L_8c0dae:
	mov_s r0,0x0
L_8c0db0:
	mov_s r13,0x1
	.global L_8c0db2
L_8c0db2:
	mov_s r0,r16
L_8c0db4:
	bl.d L_8d1484
L_8c0db8:
	mov_s r1,0x5
L_8c0dba:
	breq r0,0x0,L_8c0e82
L_8c0dbe:
	mov_s r1,0x1000294
L_8c0dc4:
	bl.d L_8dcba8
L_8c0dc8:
	mov_s r0,0x20
L_8c0dca:
	bl.d L_8d12ac
L_8c0dce:
	mov_s r0,0x1
L_8c0dd0:
	mov_s r13,0x186a0
L_8c0dd6:
	bl.d L_8d1434
L_8c0dda:
	mov_s r15,r14
L_8c0ddc:
	mov_s r2,r0
L_8c0dde:
	mov_s r1,0x10002bc
L_8c0de4:
	mov_s r0,0x20
L_8c0de6:
	bl.d L_8dcc80
L_8c0dea:
	mov_s r3,r13
L_8c0dec:
	b_s L_8c0dfe
	.global L_8c0dee
L_8c0dee:
	bl L_8d1428
L_8c0df2:
	bl.d L_8d1434
L_8c0df6:
	mov_s r14,r0
L_8c0df8:
	mov_s r15,r0
L_8c0dfa:
	breq_s r14,0,L_8c0e08
L_8c0dfc:
	brne_s r15,0,L_8c0e16
	.global L_8c0dfe
L_8c0dfe:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8c0e00:
	cmp r13,-0x1
L_8c0e04:
	bne_s L_8c0dee
L_8c0e06:
	b_s L_8c0e2a
	.global L_8c0e08
L_8c0e08:
	mov_s r1,0x10002f8
L_8c0e0e:
	bl.d L_8dcba8
L_8c0e12:
	mov_s r0,0x20
L_8c0e14:
	b_s L_8c0e2a
	.global L_8c0e16
L_8c0e16:
	bl L_8d1434
L_8c0e1a:
	mov_s r1,0x1000340
L_8c0e20:
	mov_s r2,r0
L_8c0e22:
	mov_s r0,0x20
L_8c0e24:
	bl.d L_8dcc80
L_8c0e28:
	mov_s r3,r13
	.global L_8c0e2a
L_8c0e2a:
	breq_s r14,0,L_8c0e74
L_8c0e2c:
	breq_s r15,0,L_8c0e5c
L_8c0e2e:
	mov_s r1,0x100037c
L_8c0e34:
	bl.d L_8dcba8
L_8c0e38:
	mov_s r0,0x20
L_8c0e3a:
	bl L_8f1b6c
L_8c0e3e:
	mov_s r1,0x100039c
L_8c0e44:
	bl.d L_8dcba8
L_8c0e48:
	mov_s r0,0x10
L_8c0e4a:
	bl L_8e05ec
L_8c0e4e:
	bl L_8f173c
L_8c0e52:
	bl L_8f0d28
L_8c0e56:
	bl L_8f1b6c
L_8c0e5a:
	b_s L_8c0e74
	.global L_8c0e5c
L_8c0e5c:
	mov_s r1,0x10003c4
L_8c0e62:
	bl.d L_8dcba8
L_8c0e66:
	mov_s r0,0x0
L_8c0e68:
	mov_s r0,blink
L_8c0e6a:
	mov_s r1,0x11aa
L_8c0e70:
	bl L_8c9b28
	.global L_8c0e74
L_8c0e74:
	bl.d L_8d12ac
L_8c0e78:
	mov_s r0,0x0
L_8c0e7a:
	bl.d L_8e0470
L_8c0e7e:
	mov_s r0,0x5
L_8c0e80:
	mov_s r13,0x1
	.global L_8c0e82
L_8c0e82:
	mov_s r0,r16
L_8c0e84:
	bl.d L_8d1484
L_8c0e88:
	mov_s r1,0x6
L_8c0e8a:
	breq_s r0,0,L_8c0eb8
L_8c0e8c:
	ld_s r0,[gp,0x1f4]
L_8c0e8e:
	breq_s r0,0,L_8c0eb8
L_8c0e90:
	mov_s r1,0x1000404
L_8c0e96:
	bl.d L_8dcba8
L_8c0e9a:
	mov_s r0,0x20
L_8c0e9c:
	bl L_8d1428
L_8c0ea0:
	brne_s r0,0,L_8c0eaa
L_8c0ea2:
	bl.d L_8e0470
L_8c0ea6:
	mov_s r0,0x6
L_8c0ea8:
	b_s L_8c0eb6
	.global L_8c0eaa
L_8c0eaa:
	mov_s r1,0x1000428
L_8c0eb0:
	bl.d L_8dcba8
L_8c0eb4:
	mov_s r0,0x20
	.global L_8c0eb6
L_8c0eb6:
	mov_s r13,0x1
	.global L_8c0eb8
L_8c0eb8:
	mov_s r0,r16
L_8c0eba:
	bl.d L_8d1484
L_8c0ebe:
	mov_s r1,0x8
L_8c0ec0:
	breq_s r0,0,L_8c0ed6
L_8c0ec2:
	mov_s r1,0x1000470
L_8c0ec8:
	bl.d L_8dcba8
L_8c0ecc:
	mov_s r0,0x20
L_8c0ece:
	bl.d L_8e0470
L_8c0ed2:
	mov_s r0,0x8
L_8c0ed4:
	mov_s r13,0x1
	.global L_8c0ed6
L_8c0ed6:
	mov_s r0,r16
L_8c0ed8:
	bl.d L_8d1484
L_8c0edc:
	mov_s r1,0x9
L_8c0ede:
	breq_s r0,0,L_8c0ef4
L_8c0ee0:
	mov_s r1,0x1000490
L_8c0ee6:
	bl.d L_8dcba8
L_8c0eea:
	mov_s r0,0x20
L_8c0eec:
	bl.d L_8e0470
L_8c0ef0:
	mov_s r0,0x9
L_8c0ef2:
	mov_s r13,0x1
	.global L_8c0ef4
L_8c0ef4:
	cmp_s r13,0x0
L_8c0ef6:
	mov.eq r0,blink
L_8c0efa:
	mov.eq r1,0x11ab
L_8c0f02:
	bl.eq L_8c9b28
L_8c0f06:
	pop_s blink
L_8c0f08:
	pop_s r12
L_8c0f0a:
	sr r12,[0x3]
L_8c0f0e:
	pop_s r12
L_8c0f10:
	sr r12,[0x2]
L_8c0f14:
	pop_s r12
L_8c0f16:
	mov_s lp_count,r12
L_8c0f18:
	ld.ab r16,[sp,0x4]
L_8c0f1c:
	pop_s r15
L_8c0f1e:
	pop_s r14
L_8c0f20:
	pop_s r13
L_8c0f22:
	ld.ab r11,[sp,0x4]
L_8c0f26:
	ld.ab r10,[sp,0x4]
L_8c0f2a:
	ld.ab r9,[sp,0x4]
L_8c0f2e:
	ld.ab r8,[sp,0x4]
L_8c0f32:
	ld.ab r7,[sp,0x4]
L_8c0f36:
	ld.ab r6,[sp,0x4]
L_8c0f3a:
	ld.ab r5,[sp,0x4]
L_8c0f3e:
	ld.ab r4,[sp,0x4]
L_8c0f42:
	pop_s r3
L_8c0f44:
	pop_s r2
L_8c0f46:
	pop_s r1
L_8c0f48:
	pop_s r0
L_8c0f4a:
	pop_s r12
L_8c0f4c:
	mulu64 r12,0x1
L_8c0f50:
	mov 0x0,mlo
L_8c0f54:
	pop_s r12
L_8c0f56:
	sr r12,[0x12]
L_8c0f5a:
	pop_s r12
L_8c0f5c:
	j.f [ilink1]
