/* dma_is_tx_pipe_idle @ 0x926184, 276 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   dma_is_tx_pipe_idle: TX PIPE is not idle, g_tx_pipe_idle_cases 0x%x
 * Зовут его: l1_fixed_sched_ap__ev4_state4, vring__disconnect_flush
 * Зовёт сам: __ld_r24_to_r13_ret, __st_r24_to_r13, dma__read_881c28, dma_is_idle_uc, macq__is_idle, macq_hw__read_rptr, macq_hw__read_state0, macq_hw__read_state1, macq_hw__trigger_read_state, txq__fifo_ptp_idle_snapshot, uc_log__emit1
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global dma_is_tx_pipe_idle
dma_is_tx_pipe_idle:
	.global L_926184
L_926184:
	push_s blink
L_926186:
	bl L_92020c
L_92618a:
	push_s r0
L_92618c:
	mov_s r14,r1
L_92618e:
	mov_s r13,r2
L_926190:
	bl.d L_929088
L_926194:
	mov_s r0,r1
L_926196:
	cmp_s r13,0x0
L_926198:
	bls.d L_92627e
L_92619c:
	mov_s r24,r0
L_92619e:
	mov_s r0,r13
	.global L_9261a0
L_9261a0:
	mov_s r22,r0
L_9261a2:
	mov_s r0,r14
L_9261a4:
	mov_s r13,0x0
L_9261a6:
	bl.d L_9290f4
L_9261aa:
	mov_s r1,r13
L_9261ac:
	mov_s r19,r0
L_9261ae:
	bl.d L_929088
L_9261b2:
	mov_s r0,r14
L_9261b4:
	cmp r24,r0
L_9261b8:
	mov r16,0x1
L_9261bc:
	sub.ne r16,r16,r16
L_9261c0:
	bl.d L_928fcc
L_9261c4:
	mov_s r0,r14
L_9261c6:
	cmp_s r0,0x0
L_9261c8:
	mov r17,0x1
L_9261cc:
	bl.d L_928fa8
L_9261d0:
	sub.ne r17,r17,r17
L_9261d4:
	add r2,r14,0x8
L_9261d8:
	mov_s r1,0x0
L_9261da:
	bset r1,r1,r2
L_9261de:
	and_s r0,r0,r1
L_9261e0:
	sub.f r18,r0,0x0
L_9261e4:
	bl.d L_92e8a8
L_9261e8:
	mov.ne r18,0x1
L_9261ec:
	mov_s r20,r0
L_9261ee:
	bl.d L_92609c
L_9261f2:
	ld_s r0,[sp,0x0]
L_9261f4:
	mov r21,0x1
L_9261f8:
	mov_s r15,r0
L_9261fa:
	bl.d L_929020
L_9261fe:
	mov_s r0,r14
L_926200:
	mov_s r23,r0
L_926202:
	bl.d L_929044
L_926206:
	mov_s r0,r14
L_926208:
	cmp r23,r0
L_92620c:
	mov_s r0,0x1
L_92620e:
	sub_s.ne r0,r0,r0
L_926210:
	cmp r19,0x0
L_926214:
	cmp.ne r16,0x0
L_926218:
	cmp.ne r17,0x0
L_92621c:
	cmp.ne r18,0x0
L_926220:
	cmp.ne r20,0x0
L_926224:
	cmp.ne r15,0x0
L_926228:
	cmp.ne r0,0x0
L_92622c:
	mov.ne r13,r21
L_926230:
	extb.f 0x0,r13
L_926234:
	/* asl_s r0,r0,0x7 */
	.byte 0x07,0xb8
L_926236:
	/* asl_s r15,r15,0x6 */
	.byte 0x06,0xbf
L_926238:
	or_s r0,r0,r15
L_92623a:
	asl r1,r20,0x5
L_92623e:
	or_s r0,r0,r1
L_926240:
	asl r1,r18,0x4
L_926244:
	or_s r1,r1,r0
L_926246:
	asl r0,r17,0x3
L_92624a:
	or_s r1,r1,r0
L_92624c:
	asl r0,r16,0x2
L_926250:
	or_s r1,r1,r0
L_926252:
	asl r0,r19
L_926256:
	or_s r0,r0,r1
L_926258:
	extb_s r2,r0
L_92625a:
	mov_s r1,0x80070c
L_926260:
	stb_s r0,[r1,0x2]
L_926262:
	beq_s L_926282
L_926264:
	mov_s r0,0x28
L_926266:
	mov lp_count,r0
L_92626a:
	nop_s
L_92626c:
	lp L_926274
L_926270:
	nop_s
L_926272:
	nop_s
	.global L_926274
L_926274:
	sub r0,r22,0x1
L_926278:
	cmp_s r0,0x0
L_92627a:
	bhi L_9261a0
	.global L_92627e
L_92627e:
	mov_s r0,0x1
L_926280:
	b_s L_926290
	.global L_926282
L_926282:
	mov_s r1,0x1001b18
L_926288:
	bl.d L_92d1d0
L_92628c:
	mov_s r0,0x21
L_92628e:
	mov_s r0,0x0
	.global L_926290
L_926290:
	b.d L_920254
L_926294:
	add_s sp,sp,0x4
L_926296:
	nop_s
