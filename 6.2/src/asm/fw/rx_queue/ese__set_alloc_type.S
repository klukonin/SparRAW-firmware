/* ese__set_alloc_type @ 0x8e4220, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_macq__program_offload_desc
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, ese__bits_set16h_s0_w3, ese__bits_set32_s3_w29, memset0_words
 * Глобалы (через gp): 0x8002a8
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ese__set_alloc_type
ese__set_alloc_type:
	.global L_8e4220
L_8e4220:
	push_s blink
L_8e4222:
	bl L_8c01dc
L_8e4226:
	mov_s r14,r0
L_8e4228:
	mov_s r16,r1
L_8e422a:
	mov_s r13,r2
L_8e422c:
	mov_s r15,0x0
L_8e422e:
	bl.d L_8c1cd8
L_8e4232:
	mov_s r1,0x10
L_8e4234:
	st_s r15,[r14]
L_8e4236:
	brhs.d r13,0x5,L_8e426e
L_8e423a:
	stw_s r15,[r14,0x4]
L_8e423c:
	ldb.x r13,[0x802810,r13]
L_8e4244:
	add r1,pcl,0xa
L_8e4248:
	add1_s r1,r1,r13
L_8e424a:
	j_s.d [r1]
L_8e424c:
	ld_s r0,[r14,0xc]
L_8e424e:
	bclr_s r0,r0,0x17
L_8e4250:
	bclr_s r0,r0,0x18
L_8e4252:
	bclr_s r0,r0,0x19
	.global L_8e4254
L_8e4254:
	st_s r0,[r14,0xc]
L_8e4256:
	bclr_s r0,r0,0x1a
L_8e4258:
	st_s r0,[r14,0xc]
L_8e425a:
	b_s L_8e426e
L_8e425c:
	bset_s r0,r0,0x17
L_8e425e:
	bset_s r0,r0,0x18
L_8e4260:
	bset_s r0,r0,0x19
L_8e4262:
	b_s L_8e4254
L_8e4264:
	or r0,r0,0x7800000
L_8e426c:
	st_s r0,[r14,0xc]
	.global L_8e426e
L_8e426e:
	add_s r0,r14,0x6
L_8e4270:
	mov_s r1,0x0
L_8e4272:
	bl.d L_8ed2e0
L_8e4276:
	cmp r16,0x2
L_8e427a:
	mov_s r0,0x1
L_8e427c:
	sub_s.ne r0,r0,r0
L_8e427e:
	ld_s r2,[r14,0x8]
L_8e4280:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_8e4282:
	bic r2,r2,0x5
L_8e4286:
	bclr_s r0,r0,0x0
L_8e4288:
	or_s r2,r2,r0
L_8e428a:
	bset r0,r2,0x0
L_8e428e:
	bclr_s r2,r2,0x1
L_8e4290:
	st_s r0,[r14,0x8]
L_8e4292:
	ld_s r0,[gp,0x124]
L_8e4294:
	bset_s r2,r2,0x0
L_8e4296:
	bmsk_s r0,r0,0x0
L_8e4298:
	asl_s r0,r0
L_8e429a:
	or_s r0,r0,r2
L_8e429c:
	st_s r0,[r14,0x8]
L_8e429e:
	add r0,r14,0x8
L_8e42a2:
	bl L_8ed4e4
L_8e42a6:
	b L_8c0244
L_8e42aa:
	bclr_s r0,r0,0x17
L_8e42ac:
	bclr_s r0,r0,0x18
L_8e42ae:
	bclr_s r0,r0,0x19
L_8e42b0:
	bset_s r0,r0,0x17
L_8e42b2:
	bset_s r0,r0,0x18
L_8e42b4:
	b_s L_8e4254
L_8e42b6:
	nop_s
