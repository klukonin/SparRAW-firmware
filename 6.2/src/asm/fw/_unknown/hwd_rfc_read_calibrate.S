/* hwd_rfc_read_calibrate @ 0x8f3f7c, 560 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_rfc_read_calibrate: Got rfc calibration request with %d iterations. TSF: 0x%x
 *   hwd_rfc_read_calibrate - rfs: 0x%x
 *   hwd_rfc_read_calibrate - initial register rdac val: 0x%x
 *   hwd_rfc_read_calibrate - initial register hyst val: 0x%x
 *   hwd_rfc_read_calibrate: rf: 0x%x
 *   hwd_rfc_read_calibrate: rdac %d already failed in the pass - not testing it
 *   hwd_rfc_read_calibrate: tested rdac = %d, total failures for rdac: %d
 *   hwd_rfc_read_calibrate: best index = %d, rdac value: %d
 * Зовут его: UT_HW_DRIVERS_cmd_handler, lmac_if__lmac_ready_evt
 * Зовёт сам: __ld_r24_to_r13_ret, __st_r24_to_r13, bit_iter__has_more, bitmap__alloc_bit, field_set_0x00__8e5dfc, fw_log_emit0, fw_log_emit1, fw_log_emit2, fw_sysassert_fatal, get_min_failures_mid_biggest_range_index, hwd_abif__dvs_rfca_cmd_enable, hwd_rfc_read_handle_driver_input
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_rfc_read_calibrate
hwd_rfc_read_calibrate:
	.global L_8f3f7c
L_8f3f7c:
	push_s blink
L_8f3f7e:
	bl L_8c01bc
L_8f3f82:
	st.a r0,[sp,-0x1c]
L_8f3f86:
	mov_s r0,0x803908
L_8f3f8c:
	ld_s r2,[r0,0x1c]
L_8f3f8e:
	ld_s r1,[r0,0x20]
L_8f3f90:
	st_s r2,[sp,0x8]
L_8f3f92:
	st_s r1,[sp,0xc]
L_8f3f94:
	ld_s r1,[r0,0x24]
L_8f3f96:
	ld_s r0,[r0,0x28]
L_8f3f98:
	st_s r1,[sp,0x10]
L_8f3f9a:
	st_s r0,[sp,0x14]
L_8f3f9c:
	mov r21,0x889100
L_8f3fa4:
	ld r22,[r21, 0x54]
L_8f3fa8:
	mov r19,0x889280
L_8f3fb0:
	ld r17,[r19, 0x34]
L_8f3fb4:
	bl L_8ce9c4
L_8f3fb8:
	add_s r1,sp,0x8
L_8f3fba:
	st_s r0,[sp,0x4]
L_8f3fbc:
	mov_s r0,0x0
L_8f3fbe:
	bl.d L_8e9900
L_8f3fc2:
	mov_s r2,r0
L_8f3fc4:
	ld_s r2,[sp,0x0]
L_8f3fc6:
	mov_s r1,0x101eae0
L_8f3fcc:
	mov_s r0,0x20
L_8f3fce:
	bl.d L_8dcc80
L_8f3fd2:
	ld_s r3,[sp,0x8]
L_8f3fd4:
	bl L_8f41c8
L_8f3fd8:
	cmp_s r0,0x1
L_8f3fda:
	beq_s L_8f41a4
L_8f3fdc:
	mov r18,0x889080
L_8f3fe4:
	ld r0,[r18, 0x78]
L_8f3fe8:
	mov r24,0xc80000
L_8f3ff0:
	extw_s r0,r0
L_8f3ff2:
	or r0,r0,r24
L_8f3ff6:
	st r0,[r18, 0x78]
L_8f3ffa:
	mov r23,0x8042c8
L_8f4002:
	bl.d L_8ccb3c
L_8f4006:
	mov_s r0,r23
L_8f4008:
	mov_s r13,r0
L_8f400a:
	mov_s r1,0x101eb34
L_8f4010:
	mov_s r0,0x21
L_8f4012:
	bl.d L_8dcc10
L_8f4016:
	mov_s r2,r13
L_8f4018:
	add r16,sp,0x18
L_8f401c:
	mov_s r0,r16
L_8f401e:
	bl.d L_8e5dfc
L_8f4022:
	mov_s r1,r13
L_8f4024:
	mov_s r1,0x101eb58
L_8f402a:
	mov_s r0,0x21
L_8f402c:
	bl.d L_8dcc10
L_8f4030:
	mov_s r2,r22
L_8f4032:
	mov_s r1,0x101eb94
L_8f4038:
	mov_s r0,0x21
L_8f403a:
	bl.d L_8dcc10
L_8f403e:
	mov_s r2,r17
L_8f4040:
	b_s L_8f40f8
	.global L_8f4042
L_8f4042:
	bl.d L_8df444
L_8f4046:
	mov_s r0,r16
L_8f4048:
	mov_s r13,r0
L_8f404a:
	mov_s r12,0x1
L_8f404c:
	asl r0,r12,r0
L_8f4050:
	extb_s r0,r0
L_8f4052:
	bl.d L_8ce910
L_8f4056:
	mov_s r1,0x0
L_8f4058:
	mov_s r1,0x101ebd0
L_8f405e:
	mov_s r0,0x20
L_8f4060:
	bl.d L_8dcc10
L_8f4064:
	mov_s r2,r13
L_8f4066:
	st r22,[r21, 0x54]
L_8f406a:
	st r17,[r19, 0x34]
L_8f406e:
	bl.d L_8cae70
L_8f4072:
	mov_s r0,r23
L_8f4074:
	ld r0,[r19, 0x34]
L_8f4078:
	bic r0,r0,0x6
L_8f407c:
	bset_s r0,r0,0x1
L_8f407e:
	st r0,[r19, 0x34]
L_8f4082:
	mov_s r14,0x0
L_8f4084:
	b_s L_8f4096
	.global L_8f4086
L_8f4086:
	mov_s r1,0x101ebf4
L_8f408c:
	mov_s r0,0x20
L_8f408e:
	bl.d L_8dcc10
L_8f4092:
	mov_s r2,r15
	.global L_8f4094
L_8f4094:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8f4096
L_8f4096:
	brhs r14,0xa,L_8f40f8
L_8f409a:
	mov_s r13,0x801a8c
L_8f40a0:
	add2_s r13,r13,r14
L_8f40a2:
	ld_s r1,[r13]
L_8f40a4:
	mov r20,-0x1
L_8f40a8:
	add_s r0,r14,0x6
L_8f40aa:
	extb_s r15,r0
L_8f40ac:
	breq r1,r20,L_8f4086
L_8f40b0:
	bic.f r0,r0,-0xf1
L_8f40b4:
	bne_s L_8f40ee
	.global L_8f40b6
L_8f40b6:
	ld r0,[r21, 0x54]
L_8f40ba:
	asl r1,r15,0xc
L_8f40be:
	and r0,r0,0xffff0fff
L_8f40c6:
	or_s r0,r0,r1
L_8f40c8:
	st r0,[r21, 0x54]
L_8f40cc:
	bl.d L_8f3610
L_8f40d0:
	ld_s r0,[sp,0x0]
L_8f40d2:
	mov_s r3,r0
L_8f40d4:
	breq r0,r20,L_8f40dc
L_8f40d8:
	ld_s r0,[r13]
L_8f40da:
	add_s r3,r3,r0
	.global L_8f40dc
L_8f40dc:
	st_s r3,[r13]
L_8f40de:
	mov_s r1,0x101ec44
L_8f40e4:
	mov_s r0,0x20
L_8f40e6:
	bl.d L_8dcc80
L_8f40ea:
	mov_s r2,r15
L_8f40ec:
	b_s L_8f4094
	.global L_8f40ee
L_8f40ee:
	mov_s r0,blink
L_8f40f0:
	bl.d L_8c9b28
L_8f40f4:
	mov_s r1,0xac
L_8f40f6:
	b_s L_8f40b6
	.global L_8f40f8
L_8f40f8:
	bl.d L_8cdcc4
L_8f40fc:
	mov_s r0,r16
L_8f40fe:
	brne r0,0x0,L_8f4042
L_8f4102:
	mov_s r0,0x801a8c
L_8f4108:
	bl L_8f35a8
L_8f410c:
	extb_s r2,r0
L_8f410e:
	stb r0,[gp, 0xc1]
L_8f4112:
	breq r2,0xf,L_8f414e
L_8f4116:
	add_s r14,r2,0x6
L_8f4118:
	extb_s r13,r14
L_8f411a:
	mov_s r1,0x101ec8c
L_8f4120:
	mov_s r0,0x20
L_8f4122:
	bl.d L_8dcc80
L_8f4126:
	mov_s r3,r13
L_8f4128:
	bic.f r14,r14,-0xf1
L_8f412c:
	bne_s L_8f4144
	.global L_8f412e
L_8f412e:
	ld r0,[r21, 0x54]
L_8f4132:
	asl_s r13,r13,0xc
L_8f4134:
	and r0,r0,0xffff0fff
L_8f413c:
	or_s r0,r0,r13
L_8f413e:
	st r0,[r21, 0x54]
L_8f4142:
	b_s L_8f4170
	.global L_8f4144
L_8f4144:
	mov_s r0,blink
L_8f4146:
	bl.d L_8c9b28
L_8f414a:
	mov_s r1,0xac
L_8f414c:
	b_s L_8f412e
	.global L_8f414e
L_8f414e:
	mov_s r1,0x101ecc4
L_8f4154:
	bl.d L_8dcba8
L_8f4158:
	mov_s r0,0x20
L_8f415a:
	st r22,[r21, 0x54]
L_8f415e:
	st r17,[r19, 0x34]
L_8f4162:
	ld r0,[r21, 0x54]
L_8f4166:
	lsr_s r0,r0,0xc
L_8f4168:
	bmsk_s r0,r0,0x3
L_8f416a:
	/* sub_s r0,r0,0x6 */
	.byte 0x66,0xb8
L_8f416c:
	stb r0,[gp, 0xc1]
	.global L_8f4170
L_8f4170:
	ld_s r0,[sp,0x4]
L_8f4172:
	bl.d L_8ce910
L_8f4176:
	mov_s r1,0x0
L_8f4178:
	ld r0,[r18, 0x78]
L_8f417c:
	add_s r1,sp,0x10
L_8f417e:
	extw_s r0,r0
L_8f4180:
	or r0,r0,r24
L_8f4184:
	st r0,[r18, 0x78]
L_8f4188:
	mov_s r0,0x0
L_8f418a:
	bl.d L_8e9900
L_8f418e:
	mov_s r2,0x0
L_8f4190:
	ld_s r2,[sp,0x10]
L_8f4192:
	ld_s r0,[sp,0x8]
L_8f4194:
	mov_s r1,0x101ecf4
L_8f419a:
	sub r3,r2,r0
L_8f419e:
	bl.d L_8dcc80
L_8f41a2:
	mov_s r0,0x20
	.global L_8f41a4
L_8f41a4:
	b.d L_8c0204
L_8f41a8:
	add_s sp,sp,0x1c
L_8f41aa:
	nop_s
