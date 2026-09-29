/* sm_pring__state_step @ 0x8e5358, 204 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   sm_pring_connectivity.cpp
 *   Do nothing.
 * Зовут его: tail_sm_pring__state_step
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit0, fw_read_timer, fw_sysassert_fatal, u_schd__cancel, u_schd__schedule, vring__reg_write_locked_28, vring__reg_write_locked_3c, vring_hw__clear_enable_bit
 * Глобалы (через gp): 0x800334
 */
	.section .text.sm_pring__state_step,"ax",@progbits
	.global sm_pring__state_step
sm_pring__state_step:
	.global L_8e5358
L_8e5358:
	push_s blink
L_8e535a:
	bl L_8c02c0
L_8e535e:
	ld_s r1,[r0,0x18]
L_8e5360:
	brhs.d r1,0x5,L_8e540a
L_8e5364:
	mov_s r14,r0
L_8e5366:
	ldb.x r1,[0x801f3c,r1]
L_8e536e:
	add r0,pcl,0xa
L_8e5372:
	add1_s r0,r0,r1
L_8e5374:
	j_s [r0]
L_8e5376:
	mov_s r0,0x3
L_8e5378:
	ldw_s r15,[r14]
L_8e537a:
	st_s r0,[r14,0x18]
L_8e537c:
	add_s r15,r15,0x8
L_8e537e:
	mov_s r0,0x0
L_8e5380:
	bset r0,r0,r15
L_8e5384:
	bl.d L_8cd6ac
L_8e5388:
	mov_s r1,0x1
L_8e538a:
	ld_s r0,[r14,0x28]
L_8e538c:
	mov_s r13,0x0
L_8e538e:
	breq_s r0,0,L_8e5396
L_8e5390:
	bl L_8c7794
L_8e5394:
	st_s r13,[r14,0x28]
	.global L_8e5396
L_8e5396:
	ld_s r0,[r14,0x24]
L_8e5398:
	breq_s r0,0,L_8e53a0
L_8e539a:
	bl L_8c7794
L_8e539e:
	st_s r13,[r14,0x24]
	.global L_8e53a0
L_8e53a0:
	bl L_8e4694
L_8e53a4:
	st_s r13,[r14,0x34]
L_8e53a6:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8e53a8:
	st_s r0,[r14,0x30]
L_8e53aa:
	bl.d L_8cdf50
L_8e53ae:
	ldw_s r0,[r14]
L_8e53b0:
	ld_s r0,[gp,-0xf0]
L_8e53b2:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e53b4:
	st.as r0,[gp,-0x3c]
L_8e53b8:
	ld_s r0,[r14,0x1c]
L_8e53ba:
	brne_s r0,0,L_8e53e4
	.global L_8e53bc
L_8e53bc:
	mov_s r2,0x0
L_8e53be:
	ld.as r4,[gp,0x71]
L_8e53c2:
	mov_s r0,0x1cc50
L_8e53c8:
	ldw_s r1,[r14]
L_8e53ca:
	mov_s r3,0x1
L_8e53cc:
	mov_s r5,r2
L_8e53ce:
	bl.d L_8dc92c
L_8e53d2:
	mov_s r6,r2
L_8e53d4:
	st_s r0,[r14,0x1c]
L_8e53d6:
	mov_s r0,0x0
L_8e53d8:
	bset r0,r0,r15
L_8e53dc:
	bl.d L_8cd6dc
L_8e53e0:
	mov_s r1,0x1
L_8e53e2:
	b_s L_8e5420
	.global L_8e53e4
L_8e53e4:
	mov_s r0,blink
L_8e53e6:
	mov_s r2,0x100ec18
L_8e53ec:
	mov_s r1,0xe8
L_8e53ee:
	bset_s r1,r1,0xc
L_8e53f0:
	bl.d L_8c82c0
L_8e53f4:
	mov r3,0x115
L_8e53f8:
	b_s L_8e53bc
L_8e53fa:
	mov_s r2,0x100ec90
L_8e5400:
	mov_s r0,0x7
L_8e5402:
	bl.d L_8edfb0
L_8e5406:
	mov_s r1,0x2
L_8e5408:
	b_s L_8e5420
	.global L_8e540a
L_8e540a:
	mov_s r0,blink
L_8e540c:
	mov_s r2,0x100ec18
L_8e5412:
	mov_s r1,0x12a5
L_8e5418:
	bl.d L_8c82c0
L_8e541c:
	mov r3,0x125
	.global L_8e5420
L_8e5420:
	b L_8c032c
