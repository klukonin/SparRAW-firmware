/* UT_HW_DRIVERS_cmd_handler @ 0x8e5be8, 2348 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   UT_HW_DRIVERS_cmd_handler ut_subtype_id=0x%x
 *   ut_hw_drivers.c
 * Зовут его: wmi_ut_handler_dispatch
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, abif__power_up_analog, abif__program_rf_clock_and_wait, abif__set_88afa4_bit0_and_wait, abif__set_88afa4_bit1_and_wait, fw_log__emit1, fw_sysassert_fatal, get_reg88a204_s1_w32, get_reg_880a3c_8d7210, hwd_PHY_STORE_TXRX_SWAP_IQ, hwd__wait_pll_lock
 */
	.section .text.UT_HW_DRIVERS_cmd_handler,"ax",@progbits
	.global UT_HW_DRIVERS_cmd_handler
UT_HW_DRIVERS_cmd_handler:
	.global L_8e5be8
L_8e5be8:
	push_s blink
L_8e5bea:
	bl L_8c02b4
L_8e5bee:
	sub_s sp,sp,0x38
L_8e5bf0:
	mov_s r16,r0
L_8e5bf2:
	mov_s r14,r1
L_8e5bf4:
	mov_s r1,0xc
L_8e5bf6:
	mov_s r17,r1
L_8e5bf8:
	bl.d L_8e5b7c
L_8e5bfc:
	ldw_s r2,[r14,0x2]
L_8e5bfe:
	mov_s r15,r0
L_8e5c00:
	mov_s r2,0x1019bf4
L_8e5c06:
	mov_s r0,0x0
L_8e5c08:
	mov_s r1,0x2
L_8e5c0a:
	bl.d L_8edfcc
L_8e5c0e:
	ldw_s r3,[r14,0x2]
L_8e5c10:
	bl.d L_8d7210
L_8e5c14:
	mov_s r13,0x8
L_8e5c16:
	ldw_s r1,[r14,0x2]
L_8e5c18:
	breq_s r0,0,L_8e5c4e
L_8e5c1a:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8e5c1c:
	st_s r1,[r15,0x4]
L_8e5c1e:
	ld_s r0,[r14,0x4]
L_8e5c20:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e5c22:
	st_s r0,[r15,0x8]
L_8e5c24:
	ld_s r0,[r14,0x8]
L_8e5c26:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e5c28:
	st_s r0,[r15,0xc]
L_8e5c2a:
	ld_s r0,[r14,0xc]
L_8e5c2c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e5c2e:
	st_s r0,[r15,0x10]
L_8e5c30:
	ld_s r0,[r14,0x10]
L_8e5c32:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e5c34:
	st_s r0,[r15,0x14]
L_8e5c36:
	ld_s r0,[r14,0x14]
L_8e5c38:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e5c3a:
	st_s r0,[r15,0x18]
L_8e5c3c:
	ld_s r0,[r14,0x18]
L_8e5c3e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e5c40:
	st_s r0,[r15,0x1c]
L_8e5c42:
	ld_s r0,[r14,0x1c]
L_8e5c44:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e5c46:
	st_s r0,[r15,0x20]
L_8e5c48:
	b.d L_8e6506
L_8e5c4c:
	mov_s r2,0x24
	.global L_8e5c4e
L_8e5c4e:
	cmp r1,0x302
L_8e5c52:
	beq L_8e60a0
L_8e5c56:
	bgt L_8e5c7e
L_8e5c5a:
	cmp r1,0x301
L_8e5c5e:
	beq L_8e6092
L_8e5c62:
	sub r1,r1,0x101
L_8e5c66:
	cmp r1,0x102
L_8e5c6a:
	bhi L_8e64ec
L_8e5c6e:
	ldw.x.as r1,[0x803124,r1]
L_8e5c76:
	add r0,pcl,0xa
L_8e5c7a:
	add1_s r0,r0,r1
L_8e5c7c:
	j_s [r0]
	.global L_8e5c7e
L_8e5c7e:
	cmp r1,0x424
L_8e5c82:
	beq L_8e627e
L_8e5c86:
	bgt L_8e5cb4
L_8e5c8a:
	cmp r1,0x303
L_8e5c8e:
	beq L_8e60a8
L_8e5c92:
	cmp r1,0x304
L_8e5c96:
	beq L_8e60b0
L_8e5c9a:
	sub r1,r1,0x401
L_8e5c9e:
	cmp_s r1,0x22
L_8e5ca0:
	bhi L_8e64ec
L_8e5ca4:
	ldw.x.as r1,[0x80332c,r1]
L_8e5cac:
	add r0,pcl,0x8
L_8e5cb0:
	add1_s r0,r0,r1
L_8e5cb2:
	j_s [r0]
	.global L_8e5cb4
L_8e5cb4:
	cmp r1,0x503
L_8e5cb8:
	beq L_8e63e6
L_8e5cbc:
	bgt L_8e5cea
L_8e5cc0:
	cmp r1,0x502
L_8e5cc4:
	beq L_8e63d8
L_8e5cc8:
	cmp r1,0x501
L_8e5ccc:
	beq L_8e63d0
L_8e5cd0:
	sub r1,r1,0x425
L_8e5cd4:
	cmp_s r1,0x12
L_8e5cd6:
	bhi L_8e64ec
L_8e5cda:
	ldw.x.as r1,[0x803374,r1]
L_8e5ce2:
	add r0,pcl,0xa
L_8e5ce6:
	add1_s r0,r0,r1
L_8e5ce8:
	j_s [r0]
	.global L_8e5cea
L_8e5cea:
	cmp r1,0x602
L_8e5cee:
	beq L_8e64e4
L_8e5cf2:
	cmp r1,0x601
L_8e5cf6:
	beq L_8e64dc
L_8e5cfa:
	sub r1,r1,0x504
L_8e5cfe:
	cmp_s r1,0xf
L_8e5d00:
	bhi L_8e64ec
L_8e5d04:
	ldw.x.as r1,[0x80339c,r1]
L_8e5d0c:
	add r0,pcl,0x8
L_8e5d10:
	add1_s r0,r0,r1
L_8e5d12:
	j_s [r0]
L_8e5d14:
	bl.d L_8cbbc0
L_8e5d18:
	ld_s r0,[r14,0x4]
L_8e5d1a:
	b L_8e639a
L_8e5d1e:
	bl.d L_8cb7c0
L_8e5d22:
	ld_s r0,[r14,0x4]
L_8e5d24:
	b L_8e639a
L_8e5d28:
	bl.d L_8cd088
L_8e5d2c:
	ld_s r0,[r14,0x4]
L_8e5d2e:
	b L_8e639a
L_8e5d32:
	bl.d L_8cbd30
L_8e5d36:
	ld_s r0,[r14,0x4]
L_8e5d38:
	b L_8e639a
L_8e5d3c:
	ld_s r0,[r14,0x4]
L_8e5d3e:
	/* bl.d 0x008cba10 */
	.byte 0xd6,0x0c,0xef,0xf2
L_8e5d42:
	/* _sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8e5d44:
	b L_8e639a
L_8e5d48:
	bl L_8cb9dc
L_8e5d4c:
	b L_8e639a
L_8e5d50:
	bl.d L_8cbcb8
L_8e5d54:
	ld_s r0,[r14,0x4]
L_8e5d56:
	b L_8e639a
L_8e5d5a:
	bl.d L_8cb94c
L_8e5d5e:
	ld_s r0,[r14,0x4]
L_8e5d60:
	b L_8e639a
L_8e5d64:
	bl.d L_8cb9a8
L_8e5d68:
	ld_s r0,[r14,0x4]
L_8e5d6a:
	b L_8e639a
L_8e5d6e:
	bl.d L_8cb8d8
L_8e5d72:
	ld_s r0,[r14,0x4]
L_8e5d74:
	b L_8e639a
L_8e5d78:
	bl.d L_8cb7ec
L_8e5d7c:
	ld_s r0,[r14,0x4]
L_8e5d7e:
	b L_8e639a
L_8e5d82:
	bl.d L_8cb8b0
L_8e5d86:
	ld_s r0,[r14,0x4]
L_8e5d88:
	b L_8e639a
L_8e5d8c:
	ldb_s r0,[r14,0x4]
L_8e5d8e:
	ldb_s r1,[r14,0x8]
L_8e5d90:
	bl.d L_8cc834
L_8e5d94:
	ldb_s r2,[r14,0xc]
L_8e5d96:
	b_s L_8e5f86
L_8e5d98:
	ldb_s r0,[r14,0x4]
L_8e5d9a:
	ldb_s r1,[r14,0x8]
L_8e5d9c:
	bl.d L_8cc314
L_8e5da0:
	ldb_s r2,[r14,0xc]
L_8e5da2:
	b L_8e639a
L_8e5da6:
	ldb_s r0,[r14,0x4]
L_8e5da8:
	bl.d L_8cc7b8
L_8e5dac:
	ldb_s r1,[r14,0x8]
L_8e5dae:
	st_s r0,[r15,0x8]
L_8e5db0:
	mov_s r2,r17
L_8e5db2:
	b.d L_8e6504
L_8e5db6:
	mov_s r0,0x1
L_8e5db8:
	ldb_s r0,[r14,0x4]
L_8e5dba:
	mov_s r13,sp
L_8e5dbc:
	bl.d L_8cc6dc
L_8e5dc0:
	mov_s r1,r13
L_8e5dc2:
	add r0,r15,0x8
L_8e5dc6:
	mov_s r1,r13
L_8e5dc8:
	bl.d L_8c0460
L_8e5dcc:
	mov_s r2,r17
	.global L_8e5dce
L_8e5dce:
	mov_s r2,0x14
L_8e5dd0:
	b.d L_8e6504
L_8e5dd4:
	mov_s r0,0x1
L_8e5dd6:
	add r0,r14,0x8
L_8e5dda:
	mov_s r1,sp
L_8e5ddc:
	bl.d L_8c0460
L_8e5de0:
	mov_s r2,r17
L_8e5de2:
	mov_s r1,sp
L_8e5de4:
	bl.d L_8cca2c
L_8e5de8:
	ldb_s r0,[r14,0x4]
L_8e5dea:
	b L_8e639a
L_8e5dee:
	bl L_8ccfa4
L_8e5df2:
	b_s L_8e5f86
L_8e5df4:
	bl L_8cd008
L_8e5df8:
	b_s L_8e5f86
L_8e5dfa:
	ldb_s r0,[r14,0x4]
L_8e5dfc:
	ldb_s r1,[r14,0x8]
L_8e5dfe:
	bl.d L_8ccbd0
L_8e5e02:
	ldb_s r2,[r14,0xc]
L_8e5e04:
	b L_8e639a
L_8e5e08:
	ldb_s r0,[r14,0x4]
L_8e5e0a:
	bl.d L_8cd018
L_8e5e0e:
	ldb_s r1,[r14,0x8]
L_8e5e10:
	b L_8e639a
L_8e5e14:
	ldb_s r0,[r14,0x4]
L_8e5e16:
	ldb_s r1,[r14,0x8]
L_8e5e18:
	bl.d L_8cbb20
L_8e5e1c:
	ldb_s r2,[r14,0xc]
L_8e5e1e:
	b L_8e639a
L_8e5e22:
	ld_s r0,[r14,0x4]
L_8e5e24:
	bl.d L_8ccfb0
L_8e5e28:
	ldb_s r1,[r14,0x8]
L_8e5e2a:
	b L_8e639a
L_8e5e2e:
	ld_s r0,[r14,0x4]
L_8e5e30:
	bl.d L_8cc674
L_8e5e34:
	ldb_s r1,[r14,0x8]
L_8e5e36:
	b L_8e639a
L_8e5e3a:
	bl.d L_8cca94
L_8e5e3e:
	ld_s r0,[r14,0x4]
L_8e5e40:
	b L_8e639a
L_8e5e44:
	ldb_s r0,[r14,0x4]
L_8e5e46:
	ldb_s r1,[r14,0x8]
L_8e5e48:
	ldb_s r2,[r14,0xc]
L_8e5e4a:
	bl.d L_8cbe6c
L_8e5e4e:
	ldb_s r3,[r14,0x10]
L_8e5e50:
	b L_8e639a
L_8e5e54:
	ldb_s r0,[r14,0x4]
L_8e5e56:
	ldb_s r1,[r14,0x8]
L_8e5e58:
	bl.d L_8cbf98
L_8e5e5c:
	ldb.x r2,[r14, 0xc]
L_8e5e60:
	b L_8e639a
L_8e5e64:
	bl L_8cbf84
L_8e5e68:
	b L_8e639a
L_8e5e6c:
	ldb_s r0,[r14,0x4]
L_8e5e6e:
	ldb_s r1,[r14,0x8]
L_8e5e70:
	bl.d L_8cbf5c
L_8e5e74:
	ldb_s r2,[r14,0xc]
L_8e5e76:
	b L_8e639a
L_8e5e7a:
	bl L_8cca78
L_8e5e7e:
	b L_8e639a
L_8e5e82:
	ldb_s r0,[r14,0x4]
L_8e5e84:
	ldb_s r1,[r14,0x8]
L_8e5e86:
	ldb_s r2,[r14,0xc]
L_8e5e88:
	bl.d L_8cbef8
L_8e5e8c:
	ldb_s r3,[r14,0x10]
L_8e5e8e:
	b L_8e639a
L_8e5e92:
	ldb r4,[r14, 0x14]
L_8e5e96:
	ldb_s r0,[r14,0x4]
L_8e5e98:
	ldb_s r1,[r14,0x8]
L_8e5e9a:
	ldb_s r2,[r14,0xc]
L_8e5e9c:
	bl.d L_8cc188
L_8e5ea0:
	ldb_s r3,[r14,0x10]
L_8e5ea2:
	b L_8e639a
L_8e5ea6:
	ldb_s r0,[r14,0x4]
L_8e5ea8:
	ldb_s r1,[r14,0x8]
L_8e5eaa:
	ldb_s r2,[r14,0xc]
L_8e5eac:
	bl.d L_8cc4a0
L_8e5eb0:
	ldb_s r3,[r14,0x10]
L_8e5eb2:
	b L_8e639a
L_8e5eb6:
	ldb_s r0,[r14,0x4]
L_8e5eb8:
	ldb_s r1,[r14,0x8]
L_8e5eba:
	ldb_s r2,[r14,0xc]
L_8e5ebc:
	bl.d L_8cc3c8
L_8e5ec0:
	ldb_s r3,[r14,0x10]
L_8e5ec2:
	b L_8e639a
L_8e5ec6:
	ldb_s r0,[r14,0x4]
L_8e5ec8:
	bl.d L_8cc45c
L_8e5ecc:
	ldb_s r1,[r14,0x8]
L_8e5ece:
	b L_8e639a
L_8e5ed2:
	ldb_s r0,[r14,0x4]
L_8e5ed4:
	ldb_s r1,[r14,0x8]
L_8e5ed6:
	bl.d L_8cc0c8
L_8e5eda:
	ldb_s r2,[r14,0xc]
L_8e5edc:
	b L_8e639a
L_8e5ee0:
	ldb_s r0,[r14,0x4]
L_8e5ee2:
	bl.d L_8cc140
L_8e5ee6:
	ldb_s r1,[r14,0x8]
L_8e5ee8:
	b L_8e639a
L_8e5eec:
	ldb_s r0,[r14,0x4]
L_8e5eee:
	bl.d L_8cccb4
L_8e5ef2:
	ldb_s r1,[r14,0x8]
L_8e5ef4:
	b L_8e639a
L_8e5ef8:
	ldb_s r0,[r14,0x4]
L_8e5efa:
	bl.d L_8ccec0
L_8e5efe:
	ldb_s r1,[r14,0x8]
L_8e5f00:
	b L_8e639a
L_8e5f04:
	ldb_s r0,[r14,0x4]
L_8e5f06:
	ldb_s r1,[r14,0x8]
L_8e5f08:
	bl.d L_8cce38
L_8e5f0c:
	ldb_s r2,[r14,0xc]
L_8e5f0e:
	b L_8e639a
L_8e5f12:
	ldb_s r0,[r14,0x4]
L_8e5f14:
	ldb_s r1,[r14,0x8]
L_8e5f16:
	bl.d L_8ccdac
L_8e5f1a:
	ldb_s r2,[r14,0xc]
L_8e5f1c:
	b L_8e639a
L_8e5f20:
	ldb_s r0,[r14,0x4]
L_8e5f22:
	ldb_s r1,[r14,0x8]
L_8e5f24:
	bl.d L_8cccf4
L_8e5f28:
	ldb_s r2,[r14,0xc]
L_8e5f2a:
	b L_8e639a
L_8e5f2e:
	ldb_s r0,[r14,0x4]
L_8e5f30:
	bl.d L_8ccd6c
L_8e5f34:
	ldb_s r1,[r14,0x8]
L_8e5f36:
	b L_8e639a
L_8e5f3a:
	ldb_s r0,[r14,0x4]
L_8e5f3c:
	bl.d L_8ccf48
L_8e5f40:
	ldb_s r1,[r14,0x8]
L_8e5f42:
	b L_8e639a
L_8e5f46:
	ldb_s r0,[r14,0x4]
L_8e5f48:
	bl.d L_8ccf00
L_8e5f4c:
	ldb_s r1,[r14,0x8]
L_8e5f4e:
	b L_8e639a
L_8e5f52:
	bl.d L_8ccc78
L_8e5f56:
	ld_s r0,[r14,0x4]
L_8e5f58:
	b L_8e639a
L_8e5f5c:
	bl.d L_8ccb7c
L_8e5f60:
	ld_s r0,[r14,0x4]
L_8e5f62:
	b L_8e639a
L_8e5f66:
	bl.d L_8ccc6c
L_8e5f6a:
	ld_s r0,[r14,0x4]
L_8e5f6c:
	b L_8e639a
L_8e5f70:
	bl L_8ccb48
L_8e5f74:
	b_s L_8e5f86
L_8e5f76:
	bl L_8ccac8
L_8e5f7a:
	b_s L_8e5f86
L_8e5f7c:
	bl L_8cc668
L_8e5f80:
	b_s L_8e5f86
L_8e5f82:
	bl L_8cc6cc
	.global L_8e5f86
L_8e5f86:
	st_s r0,[r15,0x8]
L_8e5f88:
	mov_s r0,0x1
L_8e5f8a:
	b.d L_8e6504
L_8e5f8e:
	mov_s r2,0xc
L_8e5f90:
	bl.d L_8cbd8c
L_8e5f94:
	ldb_s r0,[r14,0x4]
L_8e5f96:
	b L_8e639a
L_8e5f9a:
	bl L_8cbe4c
L_8e5f9e:
	b_s L_8e5f86
L_8e5fa0:
	bl.d L_8cbe14
L_8e5fa4:
	ldb_s r0,[r14,0x4]
L_8e5fa6:
	b L_8e639a
L_8e5faa:
	bl L_8cbe5c
L_8e5fae:
	b_s L_8e5f86
L_8e5fb0:
	ld_s r1,[r14,0x8]
L_8e5fb2:
	ldb_s r0,[r14,0x4]
L_8e5fb4:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
L_8e5fb6:
	bmsk_s r1,r1,0x1
L_8e5fb8:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8e5fba:
	ldb_s r2,[r14,0xc]
L_8e5fbc:
	extb_s r1,r1
L_8e5fbe:
	bl.d L_8cc278
L_8e5fc2:
	ldb_s r3,[r14,0x10]
L_8e5fc4:
	b L_8e639a
L_8e5fc8:
	ldb_s r0,[r14,0x4]
L_8e5fca:
	ldb_s r1,[r14,0x8]
L_8e5fcc:
	bl.d L_8cc728
L_8e5fd0:
	ldb_s r2,[r14,0xc]
L_8e5fd2:
	b_s L_8e5f86
L_8e5fd4:
	ldb_s r0,[r14,0x4]
L_8e5fd6:
	ldb_s r1,[r14,0x8]
L_8e5fd8:
	bl.d L_8cc5b0
L_8e5fdc:
	ldb_s r2,[r14,0xc]
L_8e5fde:
	b L_8e639a
L_8e5fe2:
	ldb_s r0,[r14,0x4]
L_8e5fe4:
	bl.d L_8cc9a0
L_8e5fe8:
	ldb_s r1,[r14,0x8]
L_8e5fea:
	b_s L_8e5f86
L_8e5fec:
	ld_s r0,[r14,0x4]
L_8e5fee:
	bl.d L_8cb808
L_8e5ff2:
	ld_s r1,[r14,0x8]
L_8e5ff4:
	b L_8e639a
L_8e5ff8:
	ldb_s r0,[r14,0x4]
L_8e5ffa:
	ldb_s r1,[r14,0x8]
L_8e5ffc:
	bl.d L_8cc8c0
L_8e6000:
	ldb_s r2,[r14,0xc]
L_8e6002:
	b_s L_8e5f86
L_8e6004:
	bl L_8ccf90
L_8e6008:
	b L_8e639a
L_8e600c:
	bl L_8cc654
L_8e6010:
	b L_8e639a
L_8e6014:
	ld_s r0,[r14,0x8]
L_8e6016:
	mov_s r1,sp
L_8e6018:
	stb_s r0,[sp,0x0]
L_8e601a:
	ld_s r0,[r14,0xc]
L_8e601c:
	stb r0,[sp, 0x1]
L_8e6020:
	ld_s r0,[r14,0x10]
L_8e6022:
	stb r0,[sp, 0x2]
L_8e6026:
	ld_s r0,[r14,0x14]
L_8e6028:
	stb r0,[sp, 0x3]
L_8e602c:
	bl.d L_8cc07c
L_8e6030:
	ldb_s r0,[r14,0x4]
L_8e6032:
	b L_8e639a
L_8e6036:
	ld_s r0,[r14,0xc]
L_8e6038:
	mov_s r2,sp
L_8e603a:
	stb_s r0,[sp,0x0]
L_8e603c:
	ld_s r0,[r14,0x10]
L_8e603e:
	stb r0,[sp, 0x1]
L_8e6042:
	ld_s r0,[r14,0x14]
L_8e6044:
	stb r0,[sp, 0x2]
L_8e6048:
	ld_s r0,[r14,0x18]
L_8e604a:
	stb r0,[sp, 0x3]
L_8e604e:
	ldb_s r0,[r14,0x4]
L_8e6050:
	bl.d L_8cc050
L_8e6054:
	ldb_s r1,[r14,0x8]
L_8e6056:
	b L_8e639a
L_8e605a:
	ldb_s r0,[r14,0x4]
L_8e605c:
	ldb_s r1,[r14,0x8]
L_8e605e:
	bl.d L_8cc61c
L_8e6062:
	ldb_s r2,[r14,0xc]
L_8e6064:
	b L_8e639a
L_8e6068:
	ldb_s r0,[r14,0x4]
L_8e606a:
	ldb_s r1,[r14,0x8]
L_8e606c:
	ldb_s r2,[r14,0xc]
L_8e606e:
	bl.d L_8cc398
L_8e6072:
	ldb_s r3,[r14,0x10]
L_8e6074:
	b L_8e639a
L_8e6078:
	bl L_8cd560
L_8e607c:
	b L_8e639a
L_8e6080:
	bl.d L_8cd590
L_8e6084:
	ld_s r0,[r14,0x4]
L_8e6086:
	b L_8e639a
L_8e608a:
	bl L_8cd54c
L_8e608e:
	b L_8e639a
	.global L_8e6092
L_8e6092:
	bl.d L_8ce2bc
L_8e6096:
	ldb_s r0,[r14,0x4]
L_8e6098:
	mov_s r0,0x1
L_8e609a:
	b.d L_8e6504
L_8e609e:
	mov_s r2,r13
	.global L_8e60a0
L_8e60a0:
	bl L_8ce2ac
L_8e60a4:
	b L_8e639a
	.global L_8e60a8
L_8e60a8:
	bl L_8ce294
L_8e60ac:
	b L_8e639a
	.global L_8e60b0
L_8e60b0:
	bl L_8ce300
L_8e60b4:
	b L_8e639a
L_8e60b8:
	bl L_8cfd88
L_8e60bc:
	b L_8e639a
L_8e60c0:
	bl L_8cfd48
L_8e60c4:
	b L_8e639a
L_8e60c8:
	bl L_8cfcdc
L_8e60cc:
	b L_8e639a
L_8e60d0:
	bl.d L_8cfca8
L_8e60d4:
	ld_s r0,[r14,0x4]
L_8e60d6:
	b L_8e639a
L_8e60da:
	bl.d L_8ceed4
L_8e60de:
	ld_s r0,[r14,0x4]
L_8e60e0:
	b L_8e639a
L_8e60e4:
	bl.d L_8cf4fc
L_8e60e8:
	ld_s r0,[r14,0x4]
L_8e60ea:
	b L_8e639a
L_8e60ee:
	ldw_s r0,[r14,0x4]
L_8e60f0:
	ld_s r1,[r14,0x8]
L_8e60f2:
	ldb_s r2,[r14,0xc]
L_8e60f4:
	bl.d L_8d01e8
L_8e60f8:
	ld_s r3,[r14,0x10]
L_8e60fa:
	b L_8e639a
L_8e60fe:
	bl L_8d02ac
L_8e6102:
	b L_8e639a
L_8e6106:
	ld_s r0,[r14,0x4]
L_8e6108:
	ld_s r1,[r14,0x8]
L_8e610a:
	bl.d L_8d0318
L_8e610e:
	ldb_s r2,[r14,0xc]
L_8e6110:
	b L_8e639a
L_8e6114:
	bl.d L_8d0388
L_8e6118:
	ld_s r0,[r14,0x4]
L_8e611a:
	b L_8e639a
L_8e611e:
	ldb_s r0,[r14,0x4]
L_8e6120:
	ld_s r1,[r14,0x8]
L_8e6122:
	bl.d L_8cff30
L_8e6126:
	ld_s r2,[r14,0xc]
L_8e6128:
	b L_8e639a
L_8e612c:
	bl L_8d003c
L_8e6130:
	b L_8e639a
L_8e6134:
	ld_s r0,[r14,0x4]
L_8e6136:
	ldw_s.x r1,[r14,0x8]
L_8e6138:
	bl.d L_8d0168
L_8e613c:
	ldw_s.x r2,[r14,0xc]
L_8e613e:
	b L_8e639a
L_8e6142:
	ld_s r0,[r14,0x4]
L_8e6144:
	ldb_s r1,[r14,0x8]
L_8e6146:
	bl.d L_8d006c
L_8e614a:
	ldb_s r2,[r14,0xc]
L_8e614c:
	b L_8e639a
L_8e6150:
	ld_s r0,[r14,0x4]
L_8e6152:
	ldw_s.x r1,[r14,0x8]
L_8e6154:
	bl.d L_8d00f0
L_8e6158:
	ldw_s.x r2,[r14,0xc]
L_8e615a:
	b L_8e639a
L_8e615e:
	bl.d L_8cf4c8
L_8e6162:
	ld_s r0,[r14,0x4]
L_8e6164:
	b L_8e639a
L_8e6168:
	ld_s r0,[r14,0x4]
L_8e616a:
	brhs r0,0x4,L_8e6176
	.global L_8e616e
L_8e616e:
	bl.d L_8cf958
L_8e6172:
	ld_s r0,[r14,0x4]
L_8e6174:
	b_s L_8e618c
	.global L_8e6176
L_8e6176:
	mov_s r0,blink
L_8e6178:
	mov_s r2,0x1019c24
L_8e617e:
	mov_s r1,0xd
L_8e6180:
	bset_s r1,r1,0xc
L_8e6182:
	bl.d L_8c82c0
L_8e6186:
	mov r3,0x31f
L_8e618a:
	b_s L_8e616e
	.global L_8e618c
L_8e618c:
	mov_s r0,0x1
L_8e618e:
	b.d L_8e6504
L_8e6192:
	mov_s r2,0x8
L_8e6194:
	bl.d L_8cf588
L_8e6198:
	ld_s r0,[r14,0x4]
L_8e619a:
	b L_8e639a
L_8e619e:
	ld_s r0,[r14,0x4]
L_8e61a0:
	bl.d L_8cf52c
L_8e61a4:
	ldb_s r1,[r14,0x8]
L_8e61a6:
	b L_8e639a
L_8e61aa:
	ld_s r0,[r14,0x4]
L_8e61ac:
	/* bl.d 0x008cf83c */
	.byte 0x92,0x0e,0xaf,0xf4
L_8e61b0:
	/* _sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8e61b2:
	b L_8e639a
L_8e61b6:
	bl.d L_8cfa04
L_8e61ba:
	ld_s r0,[r14,0x4]
L_8e61bc:
	b L_8e639a
L_8e61c0:
	bl.d L_8cfa40
L_8e61c4:
	ld_s r0,[r14,0x4]
L_8e61c6:
	b_s L_8e639a
L_8e61c8:
	ldb_s r0,[r14,0x4]
L_8e61ca:
	ldb_s r1,[r14,0x8]
L_8e61cc:
	bl.d L_8cfad8
L_8e61d0:
	ldb.x r2,[r14, 0xc]
L_8e61d4:
	b_s L_8e639a
L_8e61d6:
	bl.d L_8cfaa4
L_8e61da:
	ld_s r0,[r14,0x4]
L_8e61dc:
	b_s L_8e639a
L_8e61de:
	ldb.x r0,[r14, 0x4]
L_8e61e2:
	bl.d L_8cfa74
L_8e61e6:
	ldb.x r1,[r14, 0x8]
L_8e61ea:
	b_s L_8e639a
L_8e61ec:
	ld_s r0,[r14,0x4]
L_8e61ee:
	brhs r0,0x8,L_8e6208
	.global L_8e61f2
L_8e61f2:
	ldw r4,[r14, 0x14]
L_8e61f6:
	ldb r5,[r14, 0x18]
L_8e61fa:
	ld_s r0,[r14,0x4]
L_8e61fc:
	ldb_s r1,[r14,0x8]
L_8e61fe:
	ldb_s r2,[r14,0xc]
L_8e6200:
	bl.d L_8cf140
L_8e6204:
	ldw_s r3,[r14,0x10]
L_8e6206:
	b_s L_8e618c
	.global L_8e6208
L_8e6208:
	mov_s r0,blink
L_8e620a:
	mov_s r2,0x1019c24
L_8e6210:
	mov_s r1,0x16
L_8e6212:
	bset_s r1,r1,0xc
L_8e6214:
	bl.d L_8c82c0
L_8e6218:
	mov r3,0x34b
L_8e621c:
	b_s L_8e61f2
L_8e621e:
	bl L_8cf184
L_8e6222:
	b_s L_8e639a
L_8e6224:
	bl L_8cf1a8
L_8e6228:
	b.d L_8e6504
L_8e622c:
	mov_s r2,r13
L_8e622e:
	mov_s r1,sp
L_8e6230:
	bl.d L_8cf0e4
L_8e6234:
	ldb_s r0,[r14,0x4]
L_8e6236:
	b.d L_8e5f86
L_8e623a:
	ld_s r0,[sp,0x0]
L_8e623c:
	mov_s r1,sp
L_8e623e:
	bl.d L_8cf118
L_8e6242:
	ldb_s r0,[r14,0x4]
L_8e6244:
	b.d L_8e5f86
L_8e6248:
	ld_s r0,[sp,0x0]
L_8e624a:
	bl L_8cfc9c
L_8e624e:
	b_s L_8e639a
L_8e6250:
	bl L_8cfc80
L_8e6254:
	b_s L_8e639a
L_8e6256:
	mov_s r13,sp
L_8e6258:
	bl.d L_8cf8e8
L_8e625c:
	mov_s r0,r13
L_8e625e:
	add r0,r15,0x8
L_8e6262:
	mov_s r1,r13
L_8e6264:
	bl.d L_8c0460
L_8e6268:
	mov_s r2,0x38
L_8e626a:
	mov_s r2,0x40
L_8e626c:
	b.d L_8e6504
L_8e6270:
	mov_s r0,0x1
L_8e6272:
	ld_s r0,[r14,0x4]
L_8e6274:
	ldb_s r1,[r14,0x8]
L_8e6276:
	bl.d L_8cf74c
L_8e627a:
	ld_s r2,[r14,0xc]
L_8e627c:
	b_s L_8e639a
	.global L_8e627e
L_8e627e:
	bl.d L_8cf6f8
L_8e6282:
	mov_s r0,sp
L_8e6284:
	ld_s r1,[sp,0x0]
L_8e6286:
	mov_s r2,0x10
L_8e6288:
	ld_s r0,[sp,0x4]
L_8e628a:
	st_s r1,[r15,0x8]
L_8e628c:
	st_s r0,[r15,0xc]
L_8e628e:
	b.d L_8e6504
L_8e6292:
	mov_s r0,0x1
L_8e6294:
	ld_s r0,[r14,0x4]
L_8e6296:
	brhs r0,0x8,L_8e62b8
	.global L_8e629a
L_8e629a:
	ld r4,[r14, 0x18]
L_8e629e:
	mov_s r13,0x1
L_8e62a0:
	ld_s r1,[r14,0x4]
L_8e62a2:
	mov_s r0,r13
L_8e62a4:
	ldb_s r2,[r14,0x8]
L_8e62a6:
	ldb_s r3,[r14,0xc]
L_8e62a8:
	bl.d L_8cfb94
L_8e62ac:
	mov r5,0x0
L_8e62b0:
	mov_s r2,0x8
L_8e62b2:
	b.d L_8e6504
L_8e62b6:
	mov_s r0,r13
	.global L_8e62b8
L_8e62b8:
	mov_s r0,blink
L_8e62ba:
	mov_s r2,0x1019c24
L_8e62c0:
	mov_s r1,0x1f
L_8e62c2:
	bset_s r1,r1,0xc
L_8e62c4:
	bl.d L_8c82c0
L_8e62c8:
	mov r3,0x393
L_8e62cc:
	b_s L_8e629a
L_8e62ce:
	bl L_8cfc0c
L_8e62d2:
	b_s L_8e639a
L_8e62d4:
	bl L_8cfbc8
L_8e62d8:
	b_s L_8e639a
L_8e62da:
	ldb_s r0,[r14,0x4]
L_8e62dc:
	add_s r13,sp,0x8
L_8e62de:
	bl.d L_8cf7b4
L_8e62e2:
	mov_s r1,r13
L_8e62e4:
	add r0,r15,0x8
L_8e62e8:
	mov_s r1,r13
L_8e62ea:
	bl.d L_8c0460
L_8e62ee:
	mov_s r2,0x10
	.global L_8e62f0
L_8e62f0:
	mov_s r2,0x18
L_8e62f2:
	b.d L_8e6504
L_8e62f6:
	mov_s r0,0x1
L_8e62f8:
	ldb_s r0,[r14,0x4]
L_8e62fa:
	add_s r13,sp,0x8
L_8e62fc:
	bl.d L_8cf7fc
L_8e6300:
	mov_s r1,r13
L_8e6302:
	add r0,r15,0x8
L_8e6306:
	mov_s r1,r13
L_8e6308:
	bl.d L_8c0460
L_8e630c:
	mov_s r2,0x10
L_8e630e:
	b_s L_8e62f0
L_8e6310:
	ldw.x r4,[r14, 0x14]
L_8e6314:
	add r18,sp,0x8
L_8e6318:
	ldw.x r5,[r14, 0x18]
L_8e631c:
	ldb_s r0,[r14,0x4]
L_8e631e:
	ldw_s.x r1,[r14,0x8]
L_8e6320:
	ldw_s.x r2,[r14,0xc]
L_8e6322:
	ldw_s.x r3,[r14,0x10]
L_8e6324:
	bl.d L_8cf664
L_8e6328:
	mov r6,r18
L_8e632c:
	add r0,r15,0x8
L_8e6330:
	mov_s r1,r18
L_8e6332:
	bl.d L_8c0460
L_8e6336:
	mov_s r2,r17
L_8e6338:
	b L_8e5dce
L_8e633c:
	ld_s r0,[r14,0x10]
L_8e633e:
	brhs r0,0xd,L_8e635a
	.global L_8e6342
L_8e6342:
	ld_s r0,[r14,0x14]
L_8e6344:
	brhs r0,0x20,L_8e6370
	.global L_8e6348
L_8e6348:
	ld r4,[r14, 0x14]
L_8e634c:
	ldb_s r0,[r14,0x4]
L_8e634e:
	ld_s r1,[r14,0x8]
L_8e6350:
	ld_s r2,[r14,0xc]
L_8e6352:
	bl.d L_8cf2a4
L_8e6356:
	ld_s r3,[r14,0x10]
L_8e6358:
	b_s L_8e618c
	.global L_8e635a
L_8e635a:
	mov_s r0,blink
L_8e635c:
	mov_s r2,0x1019c24
L_8e6362:
	mov_s r1,0x25
L_8e6364:
	bset_s r1,r1,0xc
L_8e6366:
	bl.d L_8c82c0
L_8e636a:
	mov r3,0x3c6
L_8e636e:
	b_s L_8e6342
	.global L_8e6370
L_8e6370:
	mov_s r0,blink
L_8e6372:
	mov_s r2,0x1019c24
L_8e6378:
	mov_s r1,0x2e
L_8e637a:
	bset_s r1,r1,0xc
L_8e637c:
	bl.d L_8c82c0
L_8e6380:
	mov r3,0x3c7
L_8e6384:
	b_s L_8e6348
L_8e6386:
	bl L_8cfef4
L_8e638a:
	b_s L_8e639a
L_8e638c:
	bl.d L_8cfe5c
L_8e6390:
	ld_s r0,[r14,0x4]
L_8e6392:
	b_s L_8e639a
L_8e6394:
	bl.d L_8cfdc0
L_8e6398:
	ld_s r0,[r14,0x4]
	.global L_8e639a
L_8e639a:
	mov_s r2,r13
L_8e639c:
	mov_s r0,0x1
L_8e639e:
	b_s L_8e6504
L_8e63a0:
	bl L_8cf964
L_8e63a4:
	b L_8e5f86
L_8e63a8:
	bl L_8cef3c
L_8e63ac:
	b L_8e5f86
L_8e63b0:
	bl L_8cf198
L_8e63b4:
	b_s L_8e639a
L_8e63b6:
	bl L_8cf130
L_8e63ba:
	b_s L_8e639a
L_8e63bc:
	ldb r4,[r14, 0x14]
L_8e63c0:
	ldb_s r0,[r14,0x4]
L_8e63c2:
	ldb_s r1,[r14,0x8]
L_8e63c4:
	ldb_s r2,[r14,0xc]
L_8e63c6:
	bl.d L_8cfc1c
L_8e63ca:
	ldb_s r3,[r14,0x10]
L_8e63cc:
	b L_8e5f86
	.global L_8e63d0
L_8e63d0:
	bl.d L_8d0394
L_8e63d4:
	ld_s r0,[r14,0x4]
L_8e63d6:
	b_s L_8e639a
	.global L_8e63d8
L_8e63d8:
	ldb_s r0,[r14,0x4]
L_8e63da:
	ldb_s r1,[r14,0x8]
L_8e63dc:
	ld_s r2,[r14,0xc]
L_8e63de:
	bl.d L_8d0f80
L_8e63e2:
	ld_s r3,[r14,0x10]
L_8e63e4:
	b_s L_8e639a
	.global L_8e63e6
L_8e63e6:
	ld_s r1,[r14,0x4]
L_8e63e8:
	mov_s r0,0x0
L_8e63ea:
	bl.d L_8d113c
L_8e63ee:
	ld_s r2,[r14,0x8]
L_8e63f0:
	b_s L_8e639a
L_8e63f2:
	mov_s r0,0x0
L_8e63f4:
	bl.d L_8d04fc
L_8e63f8:
	ld_s r1,[r14,0x4]
L_8e63fa:
	b L_8e5f86
L_8e63fe:
	mov_s r0,0x0
L_8e6400:
	bl.d L_8d073c
L_8e6404:
	ldb_s r1,[r14,0x4]
L_8e6406:
	b_s L_8e639a
L_8e6408:
	mov_s r0,0x0
L_8e640a:
	bl.d L_8d0ef4
L_8e640e:
	ldb_s r1,[r14,0x4]
L_8e6410:
	b_s L_8e639a
L_8e6412:
	ldb_s r1,[r14,0x4]
L_8e6414:
	mov_s r0,0x0
L_8e6416:
	bl.d L_8d0770
L_8e641a:
	ldb_s r2,[r14,0x8]
L_8e641c:
	b_s L_8e639a
L_8e641e:
	ldb_s r1,[r14,0x4]
L_8e6420:
	mov_s r0,0x0
L_8e6422:
	bl.d L_8d0f28
L_8e6426:
	ldb_s r2,[r14,0x8]
L_8e6428:
	b_s L_8e639a
L_8e642a:
	bl.d L_8d04b0
L_8e642e:
	mov_s r0,0x0
L_8e6430:
	b_s L_8e639a
L_8e6432:
	mov_s r0,0x0
L_8e6434:
	bl.d L_8d04bc
L_8e6438:
	ld_s r1,[r14,0x4]
L_8e643a:
	b_s L_8e639a
L_8e643c:
	bl.d L_8d0704
L_8e6440:
	mov_s r0,0x0
L_8e6442:
	b_s L_8e639a
L_8e6444:
	ldb r4,[r14, 0x14]
L_8e6448:
	ldb r5,[r14, 0x18]
L_8e644c:
	ldb_s r0,[r14,0x4]
L_8e644e:
	ldb_s r1,[r14,0x8]
L_8e6450:
	ldb_s r2,[r14,0xc]
L_8e6452:
	bl.d L_8d0960
L_8e6456:
	ldb_s r3,[r14,0x10]
L_8e6458:
	b_s L_8e639a
L_8e645a:
	ldb_s r0,[r14,0x4]
L_8e645c:
	ldb_s r1,[r14,0x8]
L_8e645e:
	ldb_s r2,[r14,0xc]
L_8e6460:
	bl.d L_8d08bc
L_8e6464:
	ldb_s r3,[r14,0x10]
L_8e6466:
	b L_8e5f86
L_8e646a:
	ldb r4,[r14, 0x14]
L_8e646e:
	ldb r5,[r14, 0x18]
L_8e6472:
	ldb_s r0,[r14,0x4]
L_8e6474:
	ldb_s r1,[r14,0x8]
L_8e6476:
	ldb_s r2,[r14,0xc]
L_8e6478:
	bl.d L_8d0b58
L_8e647c:
	ldb_s r3,[r14,0x10]
L_8e647e:
	b_s L_8e639a
L_8e6480:
	ldb_s r0,[r14,0x4]
L_8e6482:
	ldb_s r1,[r14,0x8]
L_8e6484:
	ldb_s r2,[r14,0xc]
L_8e6486:
	bl.d L_8d0ae4
L_8e648a:
	ldb_s r3,[r14,0x10]
L_8e648c:
	b L_8e5f86
L_8e6490:
	ldb r4,[r14, 0x14]
L_8e6494:
	ldb r5,[r14, 0x18]
L_8e6498:
	ldb_s r0,[r14,0x4]
L_8e649a:
	ldb_s r1,[r14,0x8]
L_8e649c:
	ldb_s r2,[r14,0xc]
L_8e649e:
	bl.d L_8d0800
L_8e64a2:
	ldb_s r3,[r14,0x10]
L_8e64a4:
	b_s L_8e639a
L_8e64a6:
	ldb_s r0,[r14,0x4]
L_8e64a8:
	ldb_s r1,[r14,0x8]
L_8e64aa:
	ldb_s r2,[r14,0xc]
L_8e64ac:
	bl.d L_8d07c8
L_8e64b0:
	ldb_s r3,[r14,0x10]
L_8e64b2:
	b L_8e5f86
L_8e64b6:
	ldb r4,[r14, 0x14]
L_8e64ba:
	ldb r5,[r14, 0x18]
L_8e64be:
	ldb_s r0,[r14,0x4]
L_8e64c0:
	ldb_s r1,[r14,0x8]
L_8e64c2:
	ldb_s r2,[r14,0xc]
L_8e64c4:
	bl.d L_8d0cf8
L_8e64c8:
	ldb_s r3,[r14,0x10]
L_8e64ca:
	b_s L_8e639a
L_8e64cc:
	ldb_s r0,[r14,0x4]
L_8e64ce:
	ldb_s r1,[r14,0x8]
L_8e64d0:
	ldb_s r2,[r14,0xc]
L_8e64d2:
	bl.d L_8d0cbc
L_8e64d6:
	ldb_s r3,[r14,0x10]
L_8e64d8:
	b L_8e5f86
	.global L_8e64dc
L_8e64dc:
	bl.d L_8ced44
L_8e64e0:
	ld_s r0,[r14,0x4]
L_8e64e2:
	b_s L_8e639a
	.global L_8e64e4
L_8e64e4:
	bl.d L_8cec0c
L_8e64e8:
	ld_s r0,[r14,0x4]
L_8e64ea:
	b_s L_8e639a
	.global L_8e64ec
L_8e64ec:
	mov_s r0,blink
L_8e64ee:
	mov_s r2,0x1019c24
L_8e64f4:
	mov_s r1,0x2f
L_8e64f6:
	bset_s r1,r1,0xc
L_8e64f8:
	bl.d L_8c82c0
L_8e64fc:
	mov r3,0x49e
L_8e6500:
	mov_s r2,0x8
L_8e6502:
	mov_s r0,0x0
	.global L_8e6504
L_8e6504:
	st_s r0,[r15,0x4]
	.global L_8e6506
L_8e6506:
	mov_s r0,r16
L_8e6508:
	bl.d L_8e5b94
L_8e650c:
	mov_s r1,r15
L_8e650e:
	b.d L_8c0314
L_8e6512:
	add_s sp,sp,0x38
