/* sm_pring__bind_vring @ 0x8c3fdc, 700 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   BIND:: Vring Index: %x. Vring availability: %x. Mtp/Bap availability: %x
 *   BIND:: Vring tail: %x. Vring head: %x
 *   BIND:: DMA RX PRING tail: %x. Vring head: %x
 *   BIND:: mpdu_retry_packets%d, mpdu_new_packets:%d
 *   sm_pring_connectivity.cpp
 *   Connect - Queue is not empty: Call 911!!!
 *   PTP Availibilty = %x m_vring_index %d (%d)!!!
 * Зовут его: sm_pring__notify_vring_state, vring_schd__bind_if_free
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, fw_log__emit0, fw_log__emit2, fw_log__emit3, fw_read_timer, fw_sysassert_fatal, get_p8003b4_48, get_p8003b4_50, get_reg_8813c8, get_reg_8813f0, get_reg_881c84
 */
	.section .text.sm_pring__bind_vring,"ax",@progbits
	.global sm_pring__bind_vring
sm_pring__bind_vring:
	.global L_8c3fdc
L_8c3fdc:
	push_s blink
L_8c3fde:
	bl L_8c02a8
L_8c3fe2:
	mov_s r14,r0
L_8c3fe4:
	mov_s r13,r1
L_8c3fe6:
	mov.f r18,r2
L_8c3fea:
	mov_s r20,r3
L_8c3fec:
	mov r19,r4
L_8c3ff0:
	mov_s r15,r5
L_8c3ff2:
	beq_s L_8c40c8
	.global L_8c3ff4
L_8c3ff4:
	ld_s r0,[r14,0x1c]
L_8c3ff6:
	brne r0,0x0,L_8c40de
	.global L_8c3ffa
L_8c3ffa:
	cmp_s r13,0x1f
L_8c3ffc:
	bcc L_8c40f4
	.global L_8c4000
L_8c4000:
	mov_s r0,0x0
L_8c4002:
	mov_s r17,r0
L_8c4004:
	st_s r0,[r14,0xc]
L_8c4006:
	add r16,r13,0x805be4
L_8c400e:
	ldb r0,[r16]
L_8c4012:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c4014:
	extb_s r0,r0
L_8c4016:
	stb r0,[r16]
L_8c401a:
	brne r0,0xa,L_8c40b0
L_8c401e:
	bl L_8cd9e0
L_8c4022:
	mov_s r4,r0
L_8c4024:
	mov_s r0,0x886f80
L_8c402a:
	ld r5,[r0, 0x1c]
L_8c402e:
	mov_s r0,0x886500
L_8c4034:
	ld r6,[r0, 0x48]
L_8c4038:
	mov_s r2,0x100eb40
L_8c403e:
	mov_s r0,0x7
L_8c4040:
	mov_s r1,0x2
L_8c4042:
	mov_s r3,r13
L_8c4044:
	bl.d L_8ee034
L_8c4048:
	or r5,r5,r6
L_8c404c:
	bl.d L_8cda9c
L_8c4050:
	mov_s r0,r13
L_8c4052:
	mov_s r21,r0
L_8c4054:
	bl.d L_8cdab0
L_8c4058:
	mov_s r0,r13
L_8c405a:
	mov_s r4,r0
L_8c405c:
	mov_s r2,0x100eb8c
L_8c4062:
	mov_s r0,0x7
L_8c4064:
	mov_s r1,0x2
L_8c4066:
	mov_s r3,r4
L_8c4068:
	bl.d L_8edff8
L_8c406c:
	mov r4,r21
L_8c4070:
	bl L_8cda7c
L_8c4074:
	bl.d L_8cda70
L_8c4078:
	mov_s r21,r0
L_8c407a:
	mov_s r4,r0
L_8c407c:
	mov_s r2,0x100ebb4
L_8c4082:
	mov_s r0,0x7
L_8c4084:
	mov_s r1,0x2
L_8c4086:
	bl.d L_8edff8
L_8c408a:
	mov_s r3,r21
L_8c408c:
	bl L_8d9ac8
L_8c4090:
	bl.d L_8d9ad0
L_8c4094:
	mov_s r21,r0
L_8c4096:
	mov_s r4,r0
L_8c4098:
	mov_s r2,0x100ebe4
L_8c409e:
	mov_s r0,0x7
L_8c40a0:
	mov_s r1,0x2
L_8c40a2:
	mov_s r3,r4
L_8c40a4:
	bl.d L_8edff8
L_8c40a8:
	mov r4,r21
L_8c40ac:
	stb r17,[r16]
	.global L_8c40b0
L_8c40b0:
	ld_s r1,[r14,0x18]
L_8c40b2:
	cmp_s r1,0x4
L_8c40b4:
	bhi L_8c427e
L_8c40b8:
	ldb r1,[0x801f34,r1]
L_8c40c0:
	add r0,pcl,0x8
L_8c40c4:
	add1_s r0,r0,r1
L_8c40c6:
	j_s [r0]
	.global L_8c40c8
L_8c40c8:
	mov_s r0,blink
L_8c40ca:
	mov_s r2,0x100ec18
L_8c40d0:
	mov_s r1,0x129d
L_8c40d6:
	bl.d L_8c82c0
L_8c40da:
	mov_s r3,0x37
L_8c40dc:
	b_s L_8c3ff4
	.global L_8c40de
L_8c40de:
	mov_s r0,blink
L_8c40e0:
	mov_s r2,0x100ec18
L_8c40e6:
	mov_s r1,0x129e
L_8c40ec:
	bl.d L_8c82c0
L_8c40f0:
	mov_s r3,0x38
L_8c40f2:
	b_s L_8c3ffa
	.global L_8c40f4
L_8c40f4:
	mov_s r0,blink
L_8c40f6:
	mov_s r2,0x100ec18
L_8c40fc:
	mov_s r1,0x1477
L_8c4102:
	bl.d L_8c82c0
L_8c4106:
	mov_s r3,0x39
L_8c4108:
	b_s L_8c4000
L_8c410a:
	ld_s r0,[r14,0x24]
L_8c410c:
	cmp_s r0,0x0
L_8c410e:
	bne_s L_8c422a
	.global L_8c4110
L_8c4110:
	ld_s r0,[r14,0x28]
L_8c4112:
	cmp_s r0,0x0
L_8c4114:
	bne_s L_8c4240
	.global L_8c4116
L_8c4116:
	st_s r15,[r14,0x14]
L_8c4118:
	extw_s r0,r13
L_8c411a:
	bl.d L_8d6ff8
L_8c411e:
	stw_s r13,[r14,0x2]
L_8c4120:
	mov_s r16,r0
L_8c4122:
	bl.d L_8cacc0
L_8c4126:
	ldw_s r0,[r14,0x2]
L_8c4128:
	mov_s r21,r0
L_8c412a:
	bl.d L_8d7084
L_8c412e:
	mov_s r1,0x0
L_8c4130:
	brne_s r0,0,L_8c4152
L_8c4132:
	mov_s r2,0x100ec34
L_8c4138:
	mov_s r0,0x7
L_8c413a:
	bl.d L_8edfb0
L_8c413e:
	mov_s r1,0x0
L_8c4140:
	mov_s r0,blink
L_8c4142:
	mov_s r2,0x100ec18
L_8c4148:
	mov_s r1,0x95
L_8c414a:
	/* asl_s r1,r1,0x5 */
	.byte 0x05,0xb9
L_8c414c:
	bl.d L_8c82c0
L_8c4150:
	mov_s r3,0x6c
	.global L_8c4152
L_8c4152:
	bl L_8e4694
L_8c4156:
	ldw_s r1,[r14,0x4]
L_8c4158:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8c415a:
	st_s r0,[r14,0x2c]
L_8c415c:
	mov_s r0,r21
L_8c415e:
	st r17,[r14, 0x34]
L_8c4162:
	bl.d L_8e5620
L_8c4166:
	ldw_s r2,[r14,0x8]
L_8c4168:
	bl L_8e50c4
L_8c416c:
	ldw_s r0,[r14,0x2]
L_8c416e:
	bl.d L_8e50ac
L_8c4172:
	mov_s r1,0x1
L_8c4174:
	mov_s r0,0x886a00
L_8c417a:
	ld_s r3,[r0,0x24]
L_8c417c:
	ldw r4,[r14, 0x2]
L_8c4180:
	lsr r13,r3,r4
L_8c4184:
	bbit1 r13,0x0,L_8c41ae
L_8c4188:
	mov_s r2,0x100ec60
L_8c418e:
	mov_s r0,0x7
L_8c4190:
	mov_s r1,0x0
L_8c4192:
	bl.d L_8ee034
L_8c4196:
	bmsk r5,r13,0x0
L_8c419a:
	mov_s r0,blink
L_8c419c:
	mov_s r2,0x100ec18
L_8c41a2:
	mov_s r1,0x12a1
L_8c41a8:
	bl.d L_8c82c0
L_8c41ac:
	mov_s r3,0x8a
	.global L_8c41ae
L_8c41ae:
	ldw_s r0,[r14]
L_8c41b0:
	mov_s r1,r20
L_8c41b2:
	bl.d L_8cd794
L_8c41b6:
	ldw_s r2,[r14,0x2]
L_8c41b8:
	ld_s r0,[gp,-0xf4]
L_8c41ba:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c41bc:
	st.as r0,[gp,-0x3d]
L_8c41c0:
	mov_s r0,0x2
L_8c41c2:
	st_s r0,[r14,0x18]
L_8c41c4:
	brne r16,0x0,L_8c4292
L_8c41c8:
	mov_s r0,0x24e90
L_8c41ce:
	mov_s r1,r15
L_8c41d0:
	ldw_s r2,[r14]
L_8c41d2:
	mov_s r3,0x1
L_8c41d4:
	mov r4,r18
L_8c41d8:
	mov r5,0x0
L_8c41dc:
	bl.d L_8dc92c
L_8c41e0:
	mov r6,r5
L_8c41e4:
	bl.d L_8d9ad8
L_8c41e8:
	st_s r0,[r14,0x24]
L_8c41ea:
	st_s r0,[r14,0x10]
L_8c41ec:
	mov_s r0,0x24edc
L_8c41f2:
	mov_s r1,r15
L_8c41f4:
	ldw_s r2,[r14]
L_8c41f6:
	mov_s r3,0x1
L_8c41f8:
	mov r4,r19
L_8c41fc:
	mov r5,0x0
L_8c4200:
	bl.d L_8dc92c
L_8c4204:
	mov r6,r5
L_8c4208:
	st_s r0,[r14,0x28]
L_8c420a:
	ldw_s r1,[r14]
L_8c420c:
	mov_s r0,0x0
L_8c420e:
	bset r0,r0,r1
L_8c4212:
	bl.d L_8cd6dc
L_8c4216:
	mov_s r1,0x1
L_8c4218:
	ldw_s r0,[r14]
L_8c421a:
	mov_s r12,0x1
L_8c421c:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8c421e:
	asl r0,r12,r0
L_8c4222:
	bl.d L_8cd6ac
L_8c4226:
	mov_s r1,0x1
L_8c4228:
	b_s L_8c4292
	.global L_8c422a
L_8c422a:
	mov_s r0,blink
L_8c422c:
	mov_s r2,0x100ec18
L_8c4232:
	mov_s r1,0x129f
L_8c4238:
	bl.d L_8c82c0
L_8c423c:
	mov_s r3,0x5e
L_8c423e:
	b_s L_8c4110
	.global L_8c4240
L_8c4240:
	mov_s r0,blink
L_8c4242:
	mov_s r2,0x100ec18
L_8c4248:
	mov_s r1,0xe6
L_8c424a:
	bset_s r1,r1,0xc
L_8c424c:
	bl.d L_8c82c0
L_8c4250:
	mov_s r3,0x5f
L_8c4252:
	b_s L_8c4116
L_8c4254:
	ld_s r0,[r14,0x14]
L_8c4256:
	brne r15,r0,L_8c4292
L_8c425a:
	ld_s r0,[r14,0x24]
L_8c425c:
	brne_s r0,0,L_8c4292
L_8c425e:
	mov_s r0,0x24e90
L_8c4264:
	mov_s r1,r15
L_8c4266:
	ldw_s r2,[r14]
L_8c4268:
	mov_s r3,0x1
L_8c426a:
	mov r4,r18
L_8c426e:
	mov r5,0x0
L_8c4272:
	bl.d L_8dc92c
L_8c4276:
	mov r6,r5
L_8c427a:
	st_s r0,[r14,0x24]
L_8c427c:
	b_s L_8c4292
	.global L_8c427e
L_8c427e:
	mov_s r0,blink
L_8c4280:
	mov_s r2,0x100ec18
L_8c4286:
	mov_s r1,0x12a2
L_8c428c:
	bl.d L_8c82c0
L_8c4290:
	mov_s r3,0xbd
	.global L_8c4292
L_8c4292:
	b L_8c02fc
L_8c4296:
	nop_s
