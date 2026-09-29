/* power_halt_seq @ 0x8d4e10, 516 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: POWER_MNGR__halt, UT_HW_MODES_cmd_handler, power_deep_sleep_exit_step
 * Зовёт сам: __ld_r17_to_r13_ret, __lshrdi3, __st_r17_to_r13, abif__power_down_889300, abif__power_down_88af80, abif__wait_88afec_bit0_clear, arith64_op, get_reg881bf0_s27_w32, get_reg88b0c0_s2_w32, get_reg_88027c, get_reg_880b00_8d16dc, hw_modes__program_rf_clocks
 * Глобалы (через gp): 0x80021e
 */
	.section .text.power_halt_seq,"ax",@progbits
	.global power_halt_seq
power_halt_seq:
	.global L_8d4e10
L_8d4e10:
	push_s blink
L_8d4e12:
	bl L_8c02b8
L_8d4e16:
	mov_s r13,r1
L_8d4e18:
	mov_s r15,r2
L_8d4e1a:
	cmp_s r0,0x0
L_8d4e1c:
	mov_s r16,r3
L_8d4e1e:
	mov r17,r4
L_8d4e22:
	beq_s L_8d4f40
L_8d4e24:
	bl L_8cda0c
L_8d4e28:
	mov_s r14,0x8004f0
L_8d4e2e:
	st_s r0,[r14]
L_8d4e30:
	ld_s r0,[r13]
L_8d4e32:
	btst_s r0,0x0
L_8d4e34:
	bl.ne.d L_8d04b0
L_8d4e38:
	sub_s.ne r0,r0,r0
L_8d4e3a:
	ld_s r0,[r13]
L_8d4e3c:
	btst_s r0,0x1
L_8d4e3e:
	sub_s.ne r0,r0,r0
L_8d4e40:
	bl.ne.d L_8d04bc
L_8d4e44:
	mov.ne r1,0x1
L_8d4e48:
	ld_s r0,[r13]
L_8d4e4a:
	btst_s r0,0x2
L_8d4e4c:
	bl.ne.d L_8d46b8
L_8d4e50:
	sub_s.ne r0,r0,r0
L_8d4e52:
	ld_s r0,[r13]
L_8d4e54:
	btst_s r0,0x3
L_8d4e56:
	bl.ne.d L_8d5130
L_8d4e5a:
	mov.ne r0,0x1
L_8d4e5e:
	ld_s r0,[r13]
L_8d4e60:
	btst_s r0,0x4
L_8d4e62:
	bl.ne.d L_8d519c
L_8d4e66:
	mov.ne r0,0x1
L_8d4e6a:
	ld_s r0,[r13]
L_8d4e6c:
	bbit0 r0,0x5,L_8d4e78
L_8d4e70:
	add_s r1,r13,0x4
L_8d4e72:
	bl.d L_8d4da8
L_8d4e76:
	mov_s r0,0x1
	.global L_8d4e78
L_8d4e78:
	ld_s r1,[r13]
L_8d4e7a:
	btst_s r1,0x6
L_8d4e7c:
	lsr.ne r1,r1,0xa
L_8d4e80:
	mov.ne r0,0x1
L_8d4e84:
	bl.ne.d L_8d51e4
L_8d4e88:
	bmsk.ne r1,r1,0x0
L_8d4e8c:
	ld_s r0,[r13]
L_8d4e8e:
	bbit0 r0,0x7,L_8d4e9a
L_8d4e92:
	mov_s r0,0x1
L_8d4e94:
	bl.d L_8d5164
L_8d4e98:
	ld_s r1,[r14]
	.global L_8d4e9a
L_8d4e9a:
	ld_s r0,[r13]
L_8d4e9c:
	btst_s r0,0x8
L_8d4e9e:
	cmp.ne r15,0x0
L_8d4ea2:
	beq_s L_8d4f10
L_8d4ea4:
	ld_s r0,[r14]
L_8d4ea6:
	brne_s r0,0,L_8d4f10
L_8d4ea8:
	mov_s r15,0x80677c
L_8d4eae:
	mov_s r0,0x0
L_8d4eb0:
	mov_s r1,r15
L_8d4eb2:
	bl.d L_8e4840
L_8d4eb6:
	mov_s r2,r0
L_8d4eb8:
	sub.f r0,r16,0x332c
L_8d4ec0:
	sbc r1,r17,0x0
L_8d4ec4:
	ld_s r2,[r15]
L_8d4ec6:
	add.f r2,r2,0x1ae
L_8d4eca:
	ld_s r3,[r15,0x4]
L_8d4ecc:
	adc r3,r3,0x0
L_8d4ed0:
	sub.f r0,r0,r2
L_8d4ed4:
	sbc r1,r1,r3
L_8d4ed8:
	mov_s r2,0x1e
L_8d4eda:
	bl.d L_8c0568
L_8d4ede:
	mov_s r3,0x0
L_8d4ee0:
	mov_s r2,0xfba9
L_8d4ee6:
	bl.d L_8c070c
L_8d4eea:
	mov_s r3,0x0
L_8d4eec:
	bl.d L_8c0510
L_8d4ef0:
	mov_s r2,0x10
L_8d4ef2:
	bl L_8d77fc
L_8d4ef6:
	bl L_8d7678
L_8d4efa:
	bl L_8d7708
L_8d4efe:
	bl L_8cd568
L_8d4f02:
	mov_s r1,0x41
L_8d4f04:
	mov_s r0,0x880280
L_8d4f0a:
	st_s r1,[r0]
L_8d4f0c:
	bl L_8cd124
	.global L_8d4f10
L_8d4f10:
	ld_s r0,[r13]
L_8d4f12:
	btst_s r0,0x9
L_8d4f14:
	beq_s L_8d5010
L_8d4f16:
	ld_s r0,[r14]
L_8d4f18:
	cmp_s r0,0x0
L_8d4f1a:
	bne_s L_8d5010
L_8d4f1c:
	bl L_8ce6f0
L_8d4f20:
	brne r0,0x5,L_8d5010
L_8d4f24:
	bl.d L_8d521c
L_8d4f28:
	mov_s r0,0x1
	.global L_8d4f2a
L_8d4f2a:
	bl L_8ce6f0
L_8d4f2e:
	brne r0,0x5,L_8d4f38
L_8d4f32:
	bl L_8d16dc
L_8d4f36:
	breq_s r0,0,L_8d4f2a
	.global L_8d4f38
L_8d4f38:
	bl.d L_8d521c
L_8d4f3c:
	mov_s r0,0x0
L_8d4f3e:
	b_s L_8d5010
	.global L_8d4f40
L_8d4f40:
	ld_s r0,[r13]
L_8d4f42:
	btst_s r0,0x8
L_8d4f44:
	cmp.ne r15,0x0
L_8d4f48:
	beq_s L_8d4fa0
L_8d4f4a:
	mov_s r0,0x8004f0
L_8d4f50:
	ld_s r0,[r0]
L_8d4f52:
	brne_s r0,0,L_8d4fa0
L_8d4f54:
	bl L_8cd14c
L_8d4f58:
	bl L_8cd0e0
L_8d4f5c:
	mov_s r1,0x40
L_8d4f5e:
	mov_s r0,0x880280
L_8d4f64:
	st_s r1,[r0]
L_8d4f66:
	bl L_8cd5b8
L_8d4f6a:
	bl L_8d76f8
L_8d4f6e:
	mov_s r1,0x0
L_8d4f70:
	mov_s r2,0x1e848a
L_8d4f76:
	bl.d L_8c070c
L_8d4f7a:
	mov_s r3,r1
L_8d4f7c:
	bl.d L_8c0510
L_8d4f80:
	mov_s r2,0x10
L_8d4f82:
	mov_s r3,0x80677c
L_8d4f88:
	ld_s r2,[r3]
L_8d4f8a:
	add.f r0,r0,r2
L_8d4f8e:
	ld_s r3,[r3,0x4]
L_8d4f90:
	adc r1,r1,r3
L_8d4f94:
	add.f r0,r0,0x3b5
L_8d4f98:
	bl.d L_8e499c
L_8d4f9c:
	adc r1,r1,0x0
	.global L_8d4fa0
L_8d4fa0:
	ld_s r0,[r13]
L_8d4fa2:
	bbit0 r0,0x7,L_8d4fb4
L_8d4fa6:
	mov_s r1,0x8004f0
L_8d4fac:
	mov_s r0,0x0
L_8d4fae:
	bl.d L_8d5164
L_8d4fb2:
	ld_s r1,[r1]
	.global L_8d4fb4
L_8d4fb4:
	ld_s r0,[r13]
L_8d4fb6:
	bbit0 r0,0x5,L_8d4fc2
L_8d4fba:
	add_s r1,r13,0x4
L_8d4fbc:
	bl.d L_8d4da8
L_8d4fc0:
	mov_s r0,0x0
	.global L_8d4fc2
L_8d4fc2:
	ld_s r1,[r13]
L_8d4fc4:
	btst_s r1,0x6
L_8d4fc6:
	lsr.ne r1,r1,0xa
L_8d4fca:
	sub_s.ne r0,r0,r0
L_8d4fcc:
	bl.ne.d L_8d51e4
L_8d4fd0:
	bmsk.ne r1,r1,0x0
L_8d4fd4:
	ld_s r0,[r13]
L_8d4fd6:
	btst_s r0,0x2
L_8d4fd8:
	bl.ne.d L_8d46b8
L_8d4fdc:
	mov.ne r0,0x1
L_8d4fe0:
	ld_s r0,[r13]
L_8d4fe2:
	btst_s r0,0x4
L_8d4fe4:
	bl.ne.d L_8d519c
L_8d4fe8:
	sub_s.ne r0,r0,r0
L_8d4fea:
	ld_s r0,[r13]
L_8d4fec:
	btst_s r0,0x3
L_8d4fee:
	bl.ne.d L_8d5130
L_8d4ff2:
	sub_s.ne r0,r0,r0
L_8d4ff4:
	ld_s r0,[r13]
L_8d4ff6:
	btst_s r0,0x1
L_8d4ff8:
	sub_s.ne r0,r0,r0
L_8d4ffa:
	bl.ne.d L_8d04bc
L_8d4ffe:
	mov.ne r1,r0
L_8d5002:
	ldb_s r0,[gp,0xae]
L_8d5004:
	ldb r1,[gp, 0xac]
L_8d5008:
	bl.d L_8cf8a8
L_8d500c:
	ldb r2,[gp, 0xad]
	.global L_8d5010
L_8d5010:
	b L_8c031c
