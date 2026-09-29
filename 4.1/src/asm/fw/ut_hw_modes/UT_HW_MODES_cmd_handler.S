/* UT_HW_MODES_cmd_handler @ 0x8e6e5c, 456 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   UT_HW_MODES_cmd_handler ut_subtype_id=0x%x
 *   ut_hw_modes.c
 * Зовут его: wmi_ut_handler_dispatch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit1, fw_sysassert_fatal, get_reg_880a3c_8d7210, hw_modes__apply_power_mode, hw_modes__enable_pll, hw_modes__pll_bypass, hw_modes__pll_engage, hw_modes__program_rf_clocks, hw_modes__set_loopback, hwd_phy__power_up_seq
 */
	.section .text.UT_HW_MODES_cmd_handler,"ax",@progbits
	.global UT_HW_MODES_cmd_handler
UT_HW_MODES_cmd_handler:
	.global L_8e6e5c
L_8e6e5c:
	push_s blink
L_8e6e5e:
	bl L_8c02bc
L_8e6e62:
	mov_s r16,r0
L_8e6e64:
	mov_s r14,r1
L_8e6e66:
	mov_s r1,0xb
L_8e6e68:
	bl.d L_8e5b7c
L_8e6e6c:
	ldw_s r2,[r14,0x2]
L_8e6e6e:
	mov_s r13,r0
L_8e6e70:
	mov_s r2,0x1018460
L_8e6e76:
	mov_s r0,0x0
L_8e6e78:
	mov_s r1,0x2
L_8e6e7a:
	bl.d L_8edfcc
L_8e6e7e:
	ldw_s r3,[r14,0x2]
L_8e6e80:
	bl L_8d7210
L_8e6e84:
	ldw_s r1,[r14,0x2]
L_8e6e86:
	breq_s r0,0,L_8e6eba
L_8e6e88:
	/* add_s r1,0x2 */
	.byte 0x02,0xe1
L_8e6e8a:
	st_s r1,[r13,0x4]
L_8e6e8c:
	ld_s r0,[r14,0x4]
L_8e6e8e:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8e6e90:
	st_s r0,[r13,0x8]
L_8e6e92:
	ld_s r0,[r14,0x8]
L_8e6e94:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8e6e96:
	st_s r0,[r13,0xc]
L_8e6e98:
	ld_s r0,[r14,0xc]
L_8e6e9a:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8e6e9c:
	st_s r0,[r13,0x10]
L_8e6e9e:
	ld_s r0,[r14,0x10]
L_8e6ea0:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8e6ea2:
	st_s r0,[r13,0x14]
L_8e6ea4:
	ld_s r0,[r14,0x14]
L_8e6ea6:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8e6ea8:
	st_s r0,[r13,0x18]
L_8e6eaa:
	ld_s r0,[r14,0x18]
L_8e6eac:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8e6eae:
	st_s r0,[r13,0x1c]
L_8e6eb0:
	ld_s r0,[r14,0x1c]
L_8e6eb2:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8e6eb4:
	st_s r0,[r13,0x20]
L_8e6eb6:
	mov_s r2,0x24
L_8e6eb8:
	b_s L_8e7018
	.global L_8e6eba
L_8e6eba:
	cmp r1,0x302
L_8e6ebe:
	beq_s L_8e6f82
L_8e6ec0:
	bgt L_8e6f1a
L_8e6ec4:
	cmp r1,0x200
L_8e6ec8:
	beq_s L_8e6f4e
L_8e6eca:
	bgt_s L_8e6ee6
L_8e6ecc:
	sub.f r1,r1,0x101
L_8e6ed0:
	beq_s L_8e6f36
L_8e6ed2:
	breq r1,0x1,L_8e6f3e
L_8e6ed6:
	breq r1,0x2,L_8e6f46
L_8e6eda:
	cmp_s r1,0x3
L_8e6edc:
	bne_s L_8e7000
L_8e6ede:
	bl L_8d4c58
L_8e6ee2:
	mov_s r0,0x1
L_8e6ee4:
	b_s L_8e7014
	.global L_8e6ee6
L_8e6ee6:
	cmp r1,0x203
L_8e6eea:
	beq_s L_8e6f66
L_8e6eec:
	bgt_s L_8e6f04
L_8e6eee:
	cmp r1,0x201
L_8e6ef2:
	beq_s L_8e6f5a
L_8e6ef4:
	cmp r1,0x202
L_8e6ef8:
	bne_s L_8e7000
L_8e6efa:
	bl.d L_8d4c0c
L_8e6efe:
	ld_s r0,[r14,0x4]
L_8e6f00:
	mov_s r0,0x1
L_8e6f02:
	b_s L_8e7014
	.global L_8e6f04
L_8e6f04:
	cmp r1,0x205
L_8e6f08:
	beq_s L_8e6f74
L_8e6f0a:
	cmp r1,0x301
L_8e6f0e:
	bne_s L_8e7000
L_8e6f10:
	bl.d L_8d5130
L_8e6f14:
	ld_s r0,[r14,0x4]
L_8e6f16:
	mov_s r0,0x1
L_8e6f18:
	b_s L_8e7014
	.global L_8e6f1a
L_8e6f1a:
	sub r1,r1,0x303
L_8e6f1e:
	cmp_s r1,0x9
L_8e6f20:
	bhi L_8e7000
L_8e6f24:
	ldb.x r1,[0x802f24,r1]
L_8e6f2c:
	add r2,pcl,0xa
L_8e6f30:
	add1_s r2,r2,r1
L_8e6f32:
	j_s.d [r2]
L_8e6f34:
	ld_s r0,[r14,0x4]
	.global L_8e6f36
L_8e6f36:
	bl L_8d4ca4
L_8e6f3a:
	mov_s r0,0x1
L_8e6f3c:
	b_s L_8e7014
	.global L_8e6f3e
L_8e6f3e:
	bl L_8d4c70
L_8e6f42:
	mov_s r0,0x1
L_8e6f44:
	b_s L_8e7014
	.global L_8e6f46
L_8e6f46:
	bl L_8d4c8c
L_8e6f4a:
	mov_s r0,0x1
L_8e6f4c:
	b_s L_8e7014
	.global L_8e6f4e
L_8e6f4e:
	ld_s r0,[r14,0x4]
L_8e6f50:
	/* bl.d 0x008d4b3c */
	.byte 0xee,0x0b,0xef,0xf6
L_8e6f54:
	/* _sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8e6f56:
	mov_s r0,0x1
L_8e6f58:
	b_s L_8e7014
	.global L_8e6f5a
L_8e6f5a:
	ld_s r0,[r14,0x4]
L_8e6f5c:
	bl.d L_8d4c30
L_8e6f60:
	ldb_s r1,[r14,0x8]
L_8e6f62:
	mov_s r0,0x1
L_8e6f64:
	b_s L_8e7014
	.global L_8e6f66
L_8e6f66:
	ld_s r0,[r14,0x4]
L_8e6f68:
	ldb_s r1,[r14,0x8]
L_8e6f6a:
	bl.d L_8d4bd4
L_8e6f6e:
	ldb_s r2,[r14,0xc]
L_8e6f70:
	mov_s r0,0x1
L_8e6f72:
	b_s L_8e7014
	.global L_8e6f74
L_8e6f74:
	ld_s r0,[r14,0x4]
L_8e6f76:
	ldb_s r1,[r14,0x8]
L_8e6f78:
	bl.d L_8d4aa8
L_8e6f7c:
	ldb_s r2,[r14,0xc]
L_8e6f7e:
	mov_s r0,0x1
L_8e6f80:
	b_s L_8e7014
	.global L_8e6f82
L_8e6f82:
	bl.d L_8d519c
L_8e6f86:
	ld_s r0,[r14,0x4]
L_8e6f88:
	mov_s r0,0x1
L_8e6f8a:
	b_s L_8e7014
L_8e6f8c:
	bl.d L_8d51e4
L_8e6f90:
	mov_s r1,0x0
L_8e6f92:
	mov_s r0,0x1
L_8e6f94:
	b_s L_8e7014
L_8e6f96:
	bl.d L_8d5164
L_8e6f9a:
	mov_s r1,0x0
L_8e6f9c:
	mov_s r0,0x1
L_8e6f9e:
	b_s L_8e7014
L_8e6fa0:
	mov_s r1,0x8017ac
L_8e6fa6:
	bl L_8d5014
L_8e6faa:
	mov_s r0,0x1
L_8e6fac:
	b_s L_8e7014
L_8e6fae:
	mov_s r1,0x8017b0
L_8e6fb4:
	bl L_8d4d5c
L_8e6fb8:
	mov_s r0,0x1
L_8e6fba:
	b_s L_8e7014
L_8e6fbc:
	bl L_8d50e4
L_8e6fc0:
	mov_s r0,0x1
L_8e6fc2:
	b_s L_8e7014
L_8e6fc4:
	mov_s r1,0x8017a8
L_8e6fca:
	bl L_8d4da8
L_8e6fce:
	mov_s r0,0x1
L_8e6fd0:
	b_s L_8e7014
L_8e6fd2:
	mov_s r1,0x8017a4
L_8e6fd8:
	mov_s r2,0x0
L_8e6fda:
	mov_s r3,0x0
L_8e6fdc:
	bl.d L_8d4e10
L_8e6fe0:
	mov r4,0x0
L_8e6fe4:
	mov_s r0,0x1
L_8e6fe6:
	b_s L_8e7014
L_8e6fe8:
	bl L_8d508c
L_8e6fec:
	mov_s r0,0x1
L_8e6fee:
	b_s L_8e7014
L_8e6ff0:
	bl L_8d521c
L_8e6ff4:
	mov_s r0,0x1
L_8e6ff6:
	b_s L_8e7014
L_8e6ff8:
	bl L_8d51d0
L_8e6ffc:
	mov_s r0,0x1
L_8e6ffe:
	b_s L_8e7014
	.global L_8e7000
L_8e7000:
	mov_s r0,blink
L_8e7002:
	mov_s r2,0x101848c
L_8e7008:
	mov_s r1,0x5b
L_8e700a:
	bset_s r1,r1,0xc
L_8e700c:
	bl.d L_8c82c0
L_8e7010:
	mov_s r3,0xe7
L_8e7012:
	mov_s r0,0x0
	.global L_8e7014
L_8e7014:
	st_s r0,[r13,0x4]
L_8e7016:
	mov_s r2,0x8
	.global L_8e7018
L_8e7018:
	mov_s r0,r16
L_8e701a:
	bl.d L_8e5b94
L_8e701e:
	mov_s r1,r13
L_8e7020:
	b L_8c0324
