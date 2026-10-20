/* basic_calib_sparrow__estimation_alg @ 0x8c9da0, 1164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   basic_calib_sparrow::estimation_alg correction NEEDED - BB temperature=%d [Celsius]
 *   basic_calib_sparrow::estimation_alg correction NEEDED - RF[%d] temperature=%d
 *   basic_calib_sparrow::estimation_alg correction NEEDED - ONLINE Estimation
 *   class_calib_lo_power::estimation_alg: Calibration will be skipped due to failure to read temperature of RF module #%d
 *   class_calib_lo_power::check_online_estimation_condition: state changed, perform correction bb: %d [Celsius] %u
 *   calib_silent_rssi_sparrow::estimation_alg correction NEEDED - BB temperature=%d [Celsius]
 *   silent_rssi: rf_threshold FORCED to RF targets vec 0x%x
 *   calib_silent_rssi_sparrow::estimation_alg correction NEEDED - RF[%d] temperature=%d
 * Зовут его: calib_engine__on_start
 * Зовёт сам: __ld_r15_to_r13_ret, __ld_r20_to_r13_ret, __ld_r23_to_r13_ret, __st_r15_to_r13, __st_r20_to_r13, __st_r23_to_r13, basic_calib__check_g8000a4, bit_iter__has_more, bitmap__alloc_bit, class_calib_lo_power__change_state_by_temperature, field_set_0x00__8e5dfc, fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global basic_calib_sparrow__estimation_alg
basic_calib_sparrow__estimation_alg:
	.global L_8c9da0
L_8c9da0:
	sub_s sp,sp,0x4
L_8c9da2:
	push_s blink
L_8c9da4:
	bl L_8c01e0
L_8c9da8:
	mov_s r13,r0
L_8c9daa:
	ld_s r0,[r0,0x24]
L_8c9dac:
	mov_s r15,r2
L_8c9dae:
	ld_s r2,[r0,0x8]
L_8c9db0:
	mov_s r14,r1
L_8c9db2:
	jl_s.d [r2]
L_8c9db4:
	mov_s r0,r13
L_8c9db6:
	ld_s r0,[r13,0x24]
L_8c9db8:
	mov_s r1,r14
L_8c9dba:
	ld_s r3,[r0,0xc]
L_8c9dbc:
	mov_s r0,r13
L_8c9dbe:
	jl_s.d [r3]
L_8c9dc0:
	mov_s r2,r15
L_8c9dc2:
	mov_s r15,r0
L_8c9dc4:
	ld_s r0,[r13,0x24]
L_8c9dc6:
	ld_s r2,[r0,0x10]
L_8c9dc8:
	mov_s r0,r13
L_8c9dca:
	jl_s.d [r2]
L_8c9dcc:
	mov_s r1,r14
L_8c9dce:
	mov_s r0,r15
L_8c9dd0:
	mov_s r12,0x8
L_8c9dd2:
	b L_8c024e
L_8c9dd6:
	nop_s
L_8c9dd8:
	sub_s sp,sp,0x4
L_8c9dda:
	push_s blink
L_8c9ddc:
	bl L_8c01c0
L_8c9de0:
	sub_s sp,sp,0x4
L_8c9de2:
	mov_s r17,r1
L_8c9de4:
	mov_s r13,r0
L_8c9de6:
	add r23,r0,0x4
L_8c9dea:
	mov_s r18,r2
L_8c9dec:
	mov_s r0,0x0
L_8c9dee:
	st_s r0,[r2]
L_8c9df0:
	stb_s r0,[r2,0x4]
L_8c9df2:
	mov r19,0x1
L_8c9df6:
	bl.d L_8cb91c
L_8c9dfa:
	mov_s r0,r19
L_8c9dfc:
	mov_s r14,r0
L_8c9dfe:
	btst r17,0x0
L_8c9e02:
	btst.eq r17,0x1
L_8c9e06:
	btst.eq r17,0x2
L_8c9e0a:
	beq_s L_8c9f14
L_8c9e0c:
	btst r17,0x0
L_8c9e10:
	mov.eq r16,0x0
L_8c9e14:
	beq_s L_8c9e42
L_8c9e16:
	lsr r1,r17,0x4
L_8c9e1a:
	ld_s r0,[r13,0x24]
L_8c9e1c:
	sexb_s r1,r1
L_8c9e1e:
	ld r4,[r0, 0x14]
L_8c9e22:
	mov_s r0,r13
L_8c9e24:
	mov_s r2,r14
L_8c9e26:
	jl.d [r4]
L_8c9e2a:
	mov_s r3,r13
L_8c9e2c:
	mov.f r16,r0
L_8c9e30:
	beq_s L_8c9e42
L_8c9e32:
	st_s r14,[r13]
L_8c9e34:
	mov_s r1,0x100a104
L_8c9e3a:
	mov_s r0,0x26
L_8c9e3c:
	bl.d L_8dcc10
L_8c9e40:
	mov_s r2,r14
	.global L_8c9e42
L_8c9e42:
	btst r17,0x1
L_8c9e46:
	mov.eq r22,0x0
L_8c9e4a:
	beq_s L_8c9ea0
L_8c9e4c:
	mov_s r0,0x8042c8
L_8c9e52:
	bl.d L_8ccb3c
L_8c9e56:
	mov r20,sp
L_8c9e5a:
	mov_s r1,r0
L_8c9e5c:
	bl.d L_8e5dfc
L_8c9e60:
	mov_s r0,r20
L_8c9e62:
	mov r22,0x0
L_8c9e66:
	b_s L_8c9e98
	.global L_8c9e68
L_8c9e68:
	bl.d L_8df444
L_8c9e6c:
	mov_s r0,r20
L_8c9e6e:
	brhs.d r0,0x8,L_8c9ea8
L_8c9e72:
	mov_s r14,r0
	.global L_8c9e74
L_8c9e74:
	mov_s r0,r14
L_8c9e76:
	bl.d L_8cca40
L_8c9e7a:
	mov_s r1,0x1
L_8c9e7c:
	mov_s r21,r0
L_8c9e7e:
	lsr r1,r17,0xc
L_8c9e82:
	sexb_s r1,r1
L_8c9e84:
	add_s r3,r13,0x4
L_8c9e86:
	ld_s r0,[r13,0x24]
L_8c9e88:
	add2_s r3,r3,r14
L_8c9e8a:
	ld r4,[r0, 0x14]
L_8c9e8e:
	mov_s r0,r13
L_8c9e90:
	jl.d [r4]
L_8c9e94:
	mov_s r2,r21
L_8c9e96:
	brne_s r0,0,L_8c9eb6
	.global L_8c9e98
L_8c9e98:
	bl.d L_8cdcc4
L_8c9e9c:
	mov_s r0,r20
L_8c9e9e:
	brne_s r0,0,L_8c9e68
	.global L_8c9ea0
L_8c9ea0:
	bbit1 r17,0x2,L_8c9ee0
L_8c9ea4:
	mov_s r14,0x0
L_8c9ea6:
	b_s L_8c9efa
	.global L_8c9ea8
L_8c9ea8:
	mov_s r0,blink
L_8c9eaa:
	mov_s r1,0x1484
L_8c9eb0:
	bl L_8c9b28
L_8c9eb4:
	b_s L_8c9e74
	.global L_8c9eb6
L_8c9eb6:
	ldb r0,[r18, 0x4]
L_8c9eba:
	add2 r12,r23,r14
L_8c9ebe:
	bset r0,r0,r14
L_8c9ec2:
	stb r0,[r18, 0x4]
L_8c9ec6:
	st r21,[r12]
L_8c9eca:
	mov_s r1,0x100a158
L_8c9ed0:
	mov_s r0,0x26
L_8c9ed2:
	mov_s r2,r14
L_8c9ed4:
	bl.d L_8dcc80
L_8c9ed8:
	mov_s r3,r21
L_8c9eda:
	mov r22,0x1
L_8c9ede:
	b_s L_8c9e98
	.global L_8c9ee0
L_8c9ee0:
	ld_s r0,[r13,0x24]
L_8c9ee2:
	ld_s r1,[r0,0x28]
L_8c9ee4:
	jl_s.d [r1]
L_8c9ee6:
	mov_s r0,r13
L_8c9ee8:
	mov.f r14,r0
L_8c9eec:
	beq_s L_8c9efa
L_8c9eee:
	mov_s r1,0x100a1a8
L_8c9ef4:
	bl.d L_8dcba8
L_8c9ef8:
	mov_s r0,0x26
	.global L_8c9efa
L_8c9efa:
	mov_s r0,0x0
L_8c9efc:
	cmp r16,0x0
L_8c9f00:
	cmp.eq r22,0x0
L_8c9f04:
	cmp.eq r14,0x0
L_8c9f08:
	mov.eq r14,r0
L_8c9f0c:
	beq_s L_8c9f10
L_8c9f0e:
	mov_s r14,0x1
	.global L_8c9f10
L_8c9f10:
	extb_s r14,r14
L_8c9f12:
	b_s L_8c9f16
	.global L_8c9f14
L_8c9f14:
	mov_s r14,r19
	.global L_8c9f16
L_8c9f16:
	brne r14,0x1,L_8c9f52
L_8c9f1a:
	ld_s r0,[r13,0x24]
L_8c9f1c:
	mov_s r1,r17
L_8c9f1e:
	ld_s r3,[r0,0x2c]
L_8c9f20:
	mov_s r0,r13
L_8c9f22:
	jl_s.d [r3]
L_8c9f24:
	mov_s r2,r18
L_8c9f26:
	ld_s r0,[r13,0x24]
L_8c9f28:
	ld_s r1,[r0,0x24]
L_8c9f2a:
	jl_s.d [r1]
L_8c9f2c:
	mov_s r0,r13
L_8c9f2e:
	breq_s r0,0,L_8c9f42
L_8c9f30:
	breq r0,0x1,L_8c9f4a
L_8c9f34:
	mov_s r0,blink
L_8c9f36:
	mov_s r1,0x12e7
L_8c9f3c:
	bl L_8c9b28
L_8c9f40:
	b_s L_8c9f56
	.global L_8c9f42
L_8c9f42:
	mov_s r0,0x2
L_8c9f44:
	st r0,[r18]
L_8c9f48:
	b_s L_8c9f56
	.global L_8c9f4a
L_8c9f4a:
	mov_s r0,0x3
L_8c9f4c:
	st r0,[r18]
L_8c9f50:
	b_s L_8c9f56
	.global L_8c9f52
L_8c9f52:
	st r19,[r18]
	.global L_8c9f56
L_8c9f56:
	mov_s r0,r14
L_8c9f58:
	mov_s r12,0x8
L_8c9f5a:
	b.d L_8c020e
L_8c9f5e:
	add_s sp,sp,0x4
L_8c9f60:
	sub_s sp,sp,0x4
L_8c9f62:
	push_s blink
L_8c9f64:
	bl L_8c01cc
L_8c9f68:
	sub_s sp,sp,0x4
L_8c9f6a:
	mov_s r13,r0
L_8c9f6c:
	mov_s r15,r2
L_8c9f6e:
	mov r18,0x0
L_8c9f72:
	mov_s r0,0x1
L_8c9f74:
	mov_s r16,r0
L_8c9f76:
	st_s r0,[r2]
L_8c9f78:
	bl.d L_8cb91c
L_8c9f7c:
	stb r18,[r2, 0x4]
L_8c9f80:
	st_s r0,[r13]
L_8c9f82:
	mov_s r3,0x800fd0
L_8c9f88:
	mov_s r1,r0
L_8c9f8a:
	ld r4,[r3, 0x4]
L_8c9f8e:
	mov_s r0,r13
L_8c9f90:
	ld r5,[r3, 0x8]
L_8c9f94:
	ld r6,[r3, 0xc]
L_8c9f98:
	ld_s r2,[r13,0x4c]
L_8c9f9a:
	bl.d L_8c5c68
L_8c9f9e:
	ld_s r3,[r3]
L_8c9fa0:
	st_s r0,[r13,0x4c]
L_8c9fa2:
	ld_s r0,[r13]
L_8c9fa4:
	mov r19,-0x1
L_8c9fa8:
	cmp_s r0,r19
L_8c9faa:
	mov_s r0,r18
L_8c9fac:
	beq_s L_8ca064
L_8c9fae:
	stb_s r0,[r15,0x4]
L_8c9fb0:
	mov_s r0,0x8042c8
L_8c9fb6:
	bl L_8ccb3c
L_8c9fba:
	mov_s r1,r0
L_8c9fbc:
	mov_s r0,sp
L_8c9fbe:
	bl.d L_8e5dfc
L_8c9fc2:
	mov_s r17,r0
L_8c9fc4:
	b_s L_8c9fd2
	.global L_8c9fc6
L_8c9fc6:
	bl.d L_8df444
L_8c9fca:
	mov_s r0,r17
L_8c9fcc:
	brlo.d r0,0x8,L_8c9fe6
L_8c9fd0:
	mov_s r14,r0
	.global L_8c9fd2
L_8c9fd2:
	bl.d L_8cdcc4
L_8c9fd6:
	mov_s r0,r17
L_8c9fd8:
	brne_s r0,0,L_8c9fc6
L_8c9fda:
	ld_s r0,[r13,0x4c]
L_8c9fdc:
	brne_s r0,0,L_8ca038
L_8c9fde:
	ldb_s r0,[r15,0x4]
L_8c9fe0:
	brne_s r0,0,L_8ca038
L_8c9fe2:
	mov_s r3,0x0
L_8c9fe4:
	b_s L_8ca03a
	.global L_8c9fe6
L_8c9fe6:
	bl.d L_8cca40
L_8c9fea:
	mov_s r1,0x1
L_8c9fec:
	mov_s r1,r0
L_8c9fee:
	add2 r20,r13,r14
L_8c9ff2:
	st r0,[r20, 0x4]
L_8c9ff6:
	breq r0,r19,L_8ca028
L_8c9ffa:
	mov_s r3,0x800fe0
L_8ca000:
	ld r4,[r3, 0x4]
L_8ca004:
	mov_s r0,r13
L_8ca006:
	ld r5,[r3, 0x8]
L_8ca00a:
	ld r6,[r3, 0xc]
L_8ca00e:
	ld r2,[r20, 0x2c]
L_8ca012:
	bl.d L_8c5c68
L_8ca016:
	ld_s r3,[r3]
L_8ca018:
	st r0,[r20, 0x2c]
L_8ca01c:
	breq_s r0,0,L_8c9fd2
L_8ca01e:
	ldb_s r0,[r15,0x4]
L_8ca020:
	bset r0,r0,r14
L_8ca024:
	stb_s r0,[r15,0x4]
L_8ca026:
	b_s L_8c9fd2
	.global L_8ca028
L_8ca028:
	mov_s r1,0x100a340
L_8ca02e:
	mov_s r0,0x16
L_8ca030:
	bl.d L_8dcc10
L_8ca034:
	mov_s r2,r14
L_8ca036:
	b_s L_8c9fd2
	.global L_8ca038
L_8ca038:
	mov_s r3,0x1
	.global L_8ca03a
L_8ca03a:
	ld_s r0,[r13,0x28]
L_8ca03c:
	cmp_s r3,r0
L_8ca03e:
	mov_s r0,0x0
L_8ca040:
	beq_s L_8ca056
L_8ca042:
	st_s r3,[r13,0x28]
L_8ca044:
	mov_s r14,0x1
L_8ca046:
	mov_s r1,0x100a3b8
L_8ca04c:
	mov_s r0,0x26
L_8ca04e:
	bl.d L_8dcc80
L_8ca052:
	ld_s r2,[r13]
L_8ca054:
	mov_s r0,r14
	.global L_8ca056
L_8ca056:
	st r18,[r15]
L_8ca05a:
	cmp_s r0,0x1
L_8ca05c:
	mov_s r1,0x3
L_8ca05e:
	mov.ne r1,r16
L_8ca062:
	st_s r1,[r15]
	.global L_8ca064
L_8ca064:
	mov_s r12,0x8
L_8ca066:
	b.d L_8c0226
L_8ca06a:
	add_s sp,sp,0x4
L_8ca06c:
	sub_s sp,sp,0x4
L_8ca06e:
	push_s blink
L_8ca070:
	bl L_8c01c0
L_8ca074:
	sub_s sp,sp,0x4
L_8ca076:
	mov_s r18,r1
L_8ca078:
	mov_s r14,r0
L_8ca07a:
	add r23,r0,0x4
L_8ca07e:
	mov_s r17,r2
L_8ca080:
	mov r20,0x0
L_8ca084:
	st r20,[r2]
L_8ca088:
	stb r20,[r2, 0x4]
L_8ca08c:
	mov r19,0x1
L_8ca090:
	bl.d L_8cb91c
L_8ca094:
	mov_s r0,r19
L_8ca096:
	mov_s r13,r0
L_8ca098:
	btst r18,0x0
L_8ca09c:
	btst.eq r18,0x1
L_8ca0a0:
	btst.eq r18,0x2
L_8ca0a4:
	beq_s L_8ca1ce
L_8ca0a6:
	btst r18,0x0
L_8ca0aa:
	mov.eq r16,0x0
L_8ca0ae:
	beq_s L_8ca0dc
L_8ca0b0:
	lsr r1,r18,0x4
L_8ca0b4:
	ld_s r0,[r14,0x24]
L_8ca0b6:
	sexb_s r1,r1
L_8ca0b8:
	ld r4,[r0, 0x14]
L_8ca0bc:
	mov_s r0,r14
L_8ca0be:
	mov_s r2,r13
L_8ca0c0:
	jl.d [r4]
L_8ca0c4:
	mov_s r3,r14
L_8ca0c6:
	mov.f r16,r0
L_8ca0ca:
	beq_s L_8ca0dc
L_8ca0cc:
	st_s r13,[r14]
L_8ca0ce:
	mov_s r1,0x1009f7c
L_8ca0d4:
	mov_s r0,0x26
L_8ca0d6:
	bl.d L_8dcc10
L_8ca0da:
	mov_s r2,r13
	.global L_8ca0dc
L_8ca0dc:
	ld_s r0,[gp,-0x184]
L_8ca0de:
	breq_s r0,0,L_8ca0fc
L_8ca0e0:
	extb_s r2,r0
L_8ca0e2:
	stb r0,[r17, 0x4]
L_8ca0e6:
	mov_s r13,0x1
L_8ca0e8:
	mov_s r1,0x1009fd8
L_8ca0ee:
	bl.d L_8dcc10
L_8ca0f2:
	mov_s r0,0x26
L_8ca0f4:
	st.as r20,[gp,-0x61]
L_8ca0f8:
	mov_s r22,r13
L_8ca0fa:
	b_s L_8ca15a
	.global L_8ca0fc
L_8ca0fc:
	btst r18,0x1
L_8ca100:
	mov.eq r22,0x0
L_8ca104:
	beq_s L_8ca15a
L_8ca106:
	mov_s r0,0x8042c8
L_8ca10c:
	bl.d L_8ccb3c
L_8ca110:
	mov r20,sp
L_8ca114:
	mov_s r1,r0
L_8ca116:
	bl.d L_8e5dfc
L_8ca11a:
	mov_s r0,r20
L_8ca11c:
	mov r22,0x0
L_8ca120:
	b_s L_8ca152
	.global L_8ca122
L_8ca122:
	bl.d L_8df444
L_8ca126:
	mov_s r0,r20
L_8ca128:
	brhs.d r0,0x8,L_8ca162
L_8ca12c:
	mov_s r13,r0
	.global L_8ca12e
L_8ca12e:
	mov_s r0,r13
L_8ca130:
	bl.d L_8cca40
L_8ca134:
	mov_s r1,0x1
L_8ca136:
	mov_s r21,r0
L_8ca138:
	lsr r1,r18,0xc
L_8ca13c:
	sexb_s r1,r1
L_8ca13e:
	add_s r3,r14,0x4
L_8ca140:
	ld_s r0,[r14,0x24]
L_8ca142:
	add2_s r3,r3,r13
L_8ca144:
	ld r4,[r0, 0x14]
L_8ca148:
	mov_s r0,r14
L_8ca14a:
	jl.d [r4]
L_8ca14e:
	mov_s r2,r21
L_8ca150:
	brne_s r0,0,L_8ca170
	.global L_8ca152
L_8ca152:
	bl.d L_8cdcc4
L_8ca156:
	mov_s r0,r20
L_8ca158:
	brne_s r0,0,L_8ca122
	.global L_8ca15a
L_8ca15a:
	bbit1 r18,0x2,L_8ca19a
L_8ca15e:
	mov_s r13,0x0
L_8ca160:
	b_s L_8ca1b4
	.global L_8ca162
L_8ca162:
	mov_s r0,blink
L_8ca164:
	mov_s r1,0x1485
L_8ca16a:
	bl L_8c9b28
L_8ca16e:
	b_s L_8ca12e
	.global L_8ca170
L_8ca170:
	ldb r0,[r17, 0x4]
L_8ca174:
	add2 r12,r23,r13
L_8ca178:
	bset r0,r0,r13
L_8ca17c:
	stb r0,[r17, 0x4]
L_8ca180:
	st r21,[r12]
L_8ca184:
	mov_s r1,0x100a010
L_8ca18a:
	mov_s r0,0x26
L_8ca18c:
	mov_s r2,r13
L_8ca18e:
	bl.d L_8dcc80
L_8ca192:
	mov_s r3,r21
L_8ca194:
	mov r22,0x1
L_8ca198:
	b_s L_8ca152
	.global L_8ca19a
L_8ca19a:
	ld_s r0,[r14,0x24]
L_8ca19c:
	ld_s r1,[r0,0x28]
L_8ca19e:
	jl_s.d [r1]
L_8ca1a0:
	mov_s r0,r14
L_8ca1a2:
	mov.f r13,r0
L_8ca1a6:
	beq_s L_8ca1b4
L_8ca1a8:
	mov_s r1,0x100a064
L_8ca1ae:
	bl.d L_8dcba8
L_8ca1b2:
	mov_s r0,0x26
	.global L_8ca1b4
L_8ca1b4:
	mov_s r0,0x0
L_8ca1b6:
	cmp r16,0x0
L_8ca1ba:
	cmp.eq r22,0x0
L_8ca1be:
	cmp.eq r13,0x0
L_8ca1c2:
	mov.eq r13,r0
L_8ca1c6:
	beq_s L_8ca1ca
L_8ca1c8:
	mov_s r13,0x1
	.global L_8ca1ca
L_8ca1ca:
	extb_s r13,r13
L_8ca1cc:
	b_s L_8ca1d0
	.global L_8ca1ce
L_8ca1ce:
	mov_s r13,r19
	.global L_8ca1d0
L_8ca1d0:
	brne r13,0x1,L_8ca20c
L_8ca1d4:
	ld_s r0,[r14,0x24]
L_8ca1d6:
	mov_s r1,r18
L_8ca1d8:
	ld_s r3,[r0,0x2c]
L_8ca1da:
	mov_s r0,r14
L_8ca1dc:
	jl_s.d [r3]
L_8ca1de:
	mov_s r2,r17
L_8ca1e0:
	ld_s r0,[r14,0x24]
L_8ca1e2:
	ld_s r1,[r0,0x24]
L_8ca1e4:
	jl_s.d [r1]
L_8ca1e6:
	mov_s r0,r14
L_8ca1e8:
	breq_s r0,0,L_8ca1fc
L_8ca1ea:
	breq r0,0x1,L_8ca204
L_8ca1ee:
	mov_s r0,blink
L_8ca1f0:
	mov_s r1,0x1564
L_8ca1f6:
	bl L_8c9b28
L_8ca1fa:
	b_s L_8ca210
	.global L_8ca1fc
L_8ca1fc:
	mov_s r0,0x2
L_8ca1fe:
	st r0,[r17]
L_8ca202:
	b_s L_8ca210
	.global L_8ca204
L_8ca204:
	mov_s r0,0x3
L_8ca206:
	st r0,[r17]
L_8ca20a:
	b_s L_8ca210
	.global L_8ca20c
L_8ca20c:
	st r19,[r17]
	.global L_8ca210
L_8ca210:
	mov_s r0,r13
L_8ca212:
	mov_s r12,0x8
L_8ca214:
	b.d L_8c020e
L_8ca218:
	add_s sp,sp,0x4
L_8ca21a:
	nop_s
L_8ca21c:
	sub_s sp,sp,0x4
L_8ca21e:
	j_s.d [blink]
L_8ca220:
	add_s sp,sp,0x4
L_8ca222:
	nop_s
L_8ca224:
	sub_s sp,sp,0x4
L_8ca226:
	j_s.d [blink]
L_8ca228:
	add_s sp,sp,0x4
L_8ca22a:
	nop_s
