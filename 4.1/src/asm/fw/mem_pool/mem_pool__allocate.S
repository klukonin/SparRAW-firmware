/* mem_pool__allocate @ 0x8c2dc8, 444 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   mem_pool::allocate failed (m_allocated == m_num_of_cells) (m_allocated=%d)
 *   mem_pool.cpp
 *   mem_pool::allocate failed 1 (this=0x%08X)
 *   mem_pool::allocate BLINK=0x%08X
 *   mem_pool::allocate failed 3 (this=0x%08X)
 *   mem_pool::allocate m_p_last_freed=0x%08X
 *   mem_pool::allocate m_p_buffer=0x%08X
 *   mem_pool::allocate m_cell_size=0x%08X
 * Зовут его: TX_API__alloc_tx_payload, alloc_dband_info, conn_mgr__add_to_rinking_list, conn_mgr__alloc_cid, mbox__alloc_from_pool, mid__open, radio_manager__lock_primary, radio_manager__lock_secondary, ring__fill_from_pool, rx_api__alloc_rx_buffer
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_div_unsigned, fw_log__emit1, fw_sysassert_fatal
 */
	.section .text.mem_pool__allocate,"ax",@progbits
	.global mem_pool__allocate
mem_pool__allocate:
	.global L_8c2dc8
L_8c2dc8:
	push_s blink
L_8c2dca:
	bl L_8c02c4
L_8c2dce:
	mov_s r13,r0
L_8c2dd0:
	ld_s r0,[r0,0x4]
L_8c2dd2:
	breq_s r0,0,L_8c2dea
	.global L_8c2dd4
L_8c2dd4:
	ld_s r3,[r13,0xc]
L_8c2dd6:
	ld_s r0,[r13,0x10]
L_8c2dd8:
	brne r3,r0,L_8c2dfc
L_8c2ddc:
	mov_s r2,0x1001b94
L_8c2de2:
	mov_s r14,0x0
L_8c2de4:
	mov_s r0,0x0
L_8c2de6:
	mov_s r1,r0
L_8c2de8:
	b_s L_8c2f7a
	.global L_8c2dea
L_8c2dea:
	mov_s r0,blink
L_8c2dec:
	mov_s r2,0x1001b84
L_8c2df2:
	mov_s r1,0xe2
L_8c2df4:
	bl.d L_8c82c0
L_8c2df8:
	mov_s r3,0x2c
L_8c2dfa:
	b_s L_8c2dd4
	.global L_8c2dfc
L_8c2dfc:
	ld_s r0,[r13,0x4]
L_8c2dfe:
	ld_s r14,[r13]
L_8c2e00:
	rsub r0,r0,r14
L_8c2e04:
	bl.d L_8c03b4
L_8c2e08:
	ld_s r1,[r13,0x8]
L_8c2e0a:
	breq_s r1,0,L_8c2e3c
L_8c2e0c:
	mov_s r2,0x1001be0
L_8c2e12:
	mov_s r0,0x0
L_8c2e14:
	mov_s r1,r0
L_8c2e16:
	bl.d L_8edfcc
L_8c2e1a:
	mov_s r3,r13
L_8c2e1c:
	mov_s r3,blink
L_8c2e1e:
	mov_s r2,0x1001c0c
L_8c2e24:
	mov_s r0,0x0
L_8c2e26:
	bl.d L_8edfcc
L_8c2e2a:
	mov_s r1,r0
L_8c2e2c:
	mov_s r0,blink
L_8c2e2e:
	mov_s r2,0x1001b84
L_8c2e34:
	mov_s r1,0xe3
L_8c2e36:
	bl.d L_8c82c0
L_8c2e3a:
	mov_s r3,0x3d
	.global L_8c2e3c
L_8c2e3c:
	ld_s r0,[r13,0x4]
L_8c2e3e:
	cmp_s r0,r14
L_8c2e40:
	bhi L_8c2f5c
L_8c2e44:
	ld_s r2,[r13,0x8]
L_8c2e46:
	ld_s r1,[r13,0x10]
L_8c2e48:
	mulu64 r2,r1
L_8c2e4c:
	add_s r0,r0,mlo
L_8c2e4e:
	cmp_s r14,r0
L_8c2e50:
	bcc L_8c2f5c
	.global L_8c2e54
L_8c2e54:
	breq_s r14,0,L_8c2e60
L_8c2e56:
	ld_s r0,[r14]
L_8c2e58:
	st_s r0,[r13]
L_8c2e5a:
	ld_s r0,[r13,0xc]
L_8c2e5c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c2e5e:
	st_s r0,[r13,0xc]
	.global L_8c2e60
L_8c2e60:
	ld_s r1,[r13]
L_8c2e62:
	cmp_s r1,0x0
L_8c2e64:
	beq_s L_8c2f6e
L_8c2e66:
	ld_s r0,[r13,0x4]
L_8c2e68:
	rsub r0,r0,r1
L_8c2e6c:
	bl.d L_8c03b4
L_8c2e70:
	ld_s r1,[r13,0x8]
L_8c2e72:
	breq_s r1,0,L_8c2ed4
L_8c2e74:
	mov_s r2,0x1001c2c
L_8c2e7a:
	mov_s r0,0x0
L_8c2e7c:
	mov_s r1,r0
L_8c2e7e:
	bl.d L_8edfcc
L_8c2e82:
	mov_s r3,r13
L_8c2e84:
	mov_s r2,0x1001c58
L_8c2e8a:
	mov_s r0,0x0
L_8c2e8c:
	mov_s r1,r0
L_8c2e8e:
	bl.d L_8edfcc
L_8c2e92:
	ld_s r3,[r13]
L_8c2e94:
	mov_s r2,0x1001c84
L_8c2e9a:
	mov_s r0,0x0
L_8c2e9c:
	mov_s r1,r0
L_8c2e9e:
	bl.d L_8edfcc
L_8c2ea2:
	ld_s r3,[r13,0x4]
L_8c2ea4:
	mov_s r2,0x1001cac
L_8c2eaa:
	mov_s r0,0x0
L_8c2eac:
	mov_s r1,r0
L_8c2eae:
	bl.d L_8edfcc
L_8c2eb2:
	ld_s r3,[r13,0x8]
L_8c2eb4:
	mov_s r3,blink
L_8c2eb6:
	mov_s r2,0x1001c0c
L_8c2ebc:
	mov_s r0,0x0
L_8c2ebe:
	bl.d L_8edfcc
L_8c2ec2:
	mov_s r1,r0
L_8c2ec4:
	mov_s r0,blink
L_8c2ec6:
	mov_s r2,0x1001b84
L_8c2ecc:
	mov_s r1,0xe5
L_8c2ece:
	bl.d L_8c82c0
L_8c2ed2:
	mov_s r3,0x52
	.global L_8c2ed4
L_8c2ed4:
	ld_s r2,[r13]
L_8c2ed6:
	ld_s r0,[r13,0x4]
L_8c2ed8:
	brlo r2,r0,L_8c2eea
L_8c2edc:
	ld_s r3,[r13,0x8]
L_8c2ede:
	ld_s r1,[r13,0x10]
L_8c2ee0:
	mulu64 r3,r1
L_8c2ee4:
	add_s r0,r0,mlo
L_8c2ee6:
	brlo r2,r0,L_8c2f7e
	.global L_8c2eea
L_8c2eea:
	mov_s r2,0x1001cd4
L_8c2ef0:
	mov_s r0,0x0
L_8c2ef2:
	mov_s r1,r0
L_8c2ef4:
	bl.d L_8edfcc
L_8c2ef8:
	mov_s r3,r13
L_8c2efa:
	mov_s r2,0x1001d00
L_8c2f00:
	mov_s r0,0x0
L_8c2f02:
	mov_s r1,r0
L_8c2f04:
	bl.d L_8edfcc
L_8c2f08:
	ld_s r3,[r13]
L_8c2f0a:
	mov_s r2,0x1001d2c
L_8c2f10:
	mov_s r0,0x0
L_8c2f12:
	mov_s r1,r0
L_8c2f14:
	bl.d L_8edfcc
L_8c2f18:
	ld_s r3,[r13,0x4]
L_8c2f1a:
	mov_s r2,0x1001d58
L_8c2f20:
	mov_s r0,0x0
L_8c2f22:
	mov_s r1,r0
L_8c2f24:
	bl.d L_8edfcc
L_8c2f28:
	ld_s r3,[r13,0x8]
L_8c2f2a:
	mov_s r2,0x1001d84
L_8c2f30:
	mov_s r0,0x0
L_8c2f32:
	mov_s r1,r0
L_8c2f34:
	bl.d L_8edfcc
L_8c2f38:
	ld_s r3,[r13,0x10]
L_8c2f3a:
	mov_s r3,blink
L_8c2f3c:
	mov_s r2,0x1001c0c
L_8c2f42:
	mov_s r0,0x0
L_8c2f44:
	bl.d L_8edfcc
L_8c2f48:
	mov_s r1,r0
L_8c2f4a:
	mov_s r0,blink
L_8c2f4c:
	mov_s r2,0x1001b84
L_8c2f52:
	mov_s r1,0xe6
L_8c2f54:
	bl.d L_8c82c0
L_8c2f58:
	mov_s r3,0x5f
L_8c2f5a:
	b_s L_8c2f7e
	.global L_8c2f5c
L_8c2f5c:
	mov_s r0,blink
L_8c2f5e:
	mov_s r2,0x1001b84
L_8c2f64:
	mov_s r1,0xe4
L_8c2f66:
	bl.d L_8c82c0
L_8c2f6a:
	mov_s r3,0x3f
L_8c2f6c:
	b_s L_8c2e54
	.global L_8c2f6e
L_8c2f6e:
	mov_s r2,0x1001db0
L_8c2f74:
	mov_s r0,0x0
L_8c2f76:
	mov_s r1,0x1
L_8c2f78:
	mov_s r3,r13
	.global L_8c2f7a
L_8c2f7a:
	bl L_8edfcc
	.global L_8c2f7e
L_8c2f7e:
	b.d L_8c0334
L_8c2f82:
	mov_s r0,r14
