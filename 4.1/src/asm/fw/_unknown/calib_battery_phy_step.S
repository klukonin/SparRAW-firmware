/* calib_battery_phy_step @ 0x8d3dcc, 336 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_lo_power_measure
 * Зовёт сам: __ld_r23_to_r13_ret, __st_r23_to_r13, calib__delta_80161c, calib_battery__check_limits, hwd_abif_battery_config, hwd_phy__rgf_883000_8cf74c
 */
	.section .text.calib_battery_phy_step,"ax",@progbits
	.global calib_battery_phy_step
calib_battery_phy_step:
	.global L_8d3dcc
L_8d3dcc:
	push_s blink
L_8d3dce:
	bl L_8c02a0
L_8d3dd2:
	sub_s sp,sp,0x3c
L_8d3dd4:
	mov_s r14,r0
L_8d3dd6:
	mov_s r15,r1
L_8d3dd8:
	mov_s r16,r2
L_8d3dda:
	mov_s r12,0x1
L_8d3ddc:
	asl r0,r12,r0
L_8d3de0:
	mov_s r1,0x1
L_8d3de2:
	mov_s r13,0x0
L_8d3de4:
	bl.d L_8cf74c
L_8d3de8:
	mov_s r2,r13
L_8d3dea:
	mov_s r0,0x3
L_8d3dec:
	bl.d L_8cb808
L_8d3df0:
	mov_s r1,r13
L_8d3df2:
	add_s r0,sp,0xc
L_8d3df4:
	bl.d L_8d40c0
L_8d3df8:
	mov_s r1,r14
L_8d3dfa:
	mov_s r0,0x2
L_8d3dfc:
	bl.d L_8cb808
L_8d3e00:
	mov_s r1,r13
L_8d3e02:
	mov_s r0,sp
L_8d3e04:
	bl.d L_8d40c0
L_8d3e08:
	mov_s r1,r14
L_8d3e0a:
	mov_s r0,0x1
L_8d3e0c:
	bl.d L_8cb808
L_8d3e10:
	mov_s r1,r13
L_8d3e12:
	mov_s r0,r16
L_8d3e14:
	bl.d L_8d40c0
L_8d3e18:
	mov_s r1,r14
L_8d3e1a:
	mov_s r0,r13
L_8d3e1c:
	bl.d L_8cb808
L_8d3e20:
	mov_s r1,r13
L_8d3e22:
	ld_s r2,[sp,0x0]
L_8d3e24:
	ld r1,[r16]
L_8d3e28:
	sub r0,r2,r1
L_8d3e2c:
	abs r4,r0
L_8d3e30:
	ldb r0,[sp, 0x9]
L_8d3e34:
	brne_s r0,0,L_8d3e42
L_8d3e36:
	ldb r0,[r16, 0x9]
L_8d3e3a:
	cmp_s r0,0x0
L_8d3e3c:
	mov.eq r19,r13
L_8d3e40:
	beq_s L_8d3e46
	.global L_8d3e42
L_8d3e42:
	mov r19,0x1
	.global L_8d3e46
L_8d3e46:
	ld_s r0,[sp,0xc]
L_8d3e48:
	ldb r5,[sp, 0x8]
L_8d3e4c:
	sub r3,r0,r2
L_8d3e50:
	abs r23,r3
L_8d3e54:
	ldb_s r3,[sp,0x14]
L_8d3e56:
	mov_s r2,0x0
L_8d3e58:
	cmp_s r3,0x0
L_8d3e5a:
	cmp.eq r5,0x0
L_8d3e5e:
	mov.ne r2,0x1
L_8d3e62:
	mov_s r20,r2
L_8d3e64:
	sub_s r0,r0,r1
L_8d3e66:
	abs r17,r0
L_8d3e6a:
	rsub r0,r14,0x19
L_8d3e6e:
	mov r21,0x0
L_8d3e72:
	bset r21,r21,r0
L_8d3e76:
	add r1,r21,0x15c92492
L_8d3e7e:
	rsub r22,r14,0x1a
L_8d3e82:
	asr r0,r4,0x2
L_8d3e86:
	asr r1,r1,r22
L_8d3e8a:
	bl.d L_8d3f1c
L_8d3e8e:
	mov_s r2,r14
L_8d3e90:
	mov_s r18,r0
L_8d3e92:
	add r1,r21,0x3c5b6db7
L_8d3e9a:
	asr r0,r17,0x2
L_8d3e9e:
	asr r1,r1,r22
L_8d3ea2:
	bl.d L_8d3f1c
L_8d3ea6:
	mov_s r2,r14
L_8d3ea8:
	mov_s r17,r0
L_8d3eaa:
	add r1,r21,0x26924925
L_8d3eb2:
	asr r0,r23,0x2
L_8d3eb6:
	asr r1,r1,r22
L_8d3eba:
	bl.d L_8d3f1c
L_8d3ebe:
	mov_s r2,r14
L_8d3ec0:
	st r17,[r15]
L_8d3ec4:
	stb r20,[r15, 0x4]
L_8d3ec8:
	stb r19,[r15, 0x5]
L_8d3ecc:
	sub r1,r18,r0
L_8d3ed0:
	abs_s r1,r1
L_8d3ed2:
	cmp_s r1,0x8000
L_8d3ed8:
	mov_s r1,0x1
L_8d3eda:
	ldb_s r0,[sp,0x14]
L_8d3edc:
	sub.le r1,r1,r1
L_8d3ee0:
	cmp_s r0,0x0
L_8d3ee2:
	mov_s r0,0x1
L_8d3ee4:
	sub_s.ne r0,r0,r0
L_8d3ee6:
	tst_s r0,r1
L_8d3ee8:
	beq_s L_8d3eee
L_8d3eea:
	st r18,[r15]
	.global L_8d3eee
L_8d3eee:
	ldb_s r0,[sp,0x14]
L_8d3ef0:
	ldb_s r1,[sp,0x8]
L_8d3ef2:
	cmp_s r0,0x1
L_8d3ef4:
	mov_s r0,0x1
L_8d3ef6:
	sub_s.ne r0,r0,r0
L_8d3ef8:
	cmp_s r1,0x0
L_8d3efa:
	mov_s r1,0x1
L_8d3efc:
	sub_s.ne r1,r1,r1
L_8d3efe:
	and_s r0,r0,r1
L_8d3f00:
	ldb r1,[r16, 0x9]
L_8d3f04:
	cmp_s r1,0x0
L_8d3f06:
	mov_s r1,0x1
L_8d3f08:
	sub_s.ne r1,r1,r1
L_8d3f0a:
	tst_s r1,r0
L_8d3f0c:
	beq_s L_8d3f14
L_8d3f0e:
	st r18,[r15]
L_8d3f12:
	stb_s r13,[r15,0x4]
	.global L_8d3f14
L_8d3f14:
	b.d L_8c02ec
L_8d3f18:
	add_s sp,sp,0x3c
L_8d3f1a:
	nop_s
