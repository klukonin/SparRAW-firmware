/* bf__abort_unexpected @ 0x92b254, 324 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ABORT unexpected BF of new sta  sta_id=%d request_fifo_head=%d
 *   ABORT unexpected BF of defualt sta  sta_id=%d request_fifo_head=%d
 * Зовут его: l1__rx_then_check_bf_abort, rx_flow__run_and_check_bf_abort, rx_funcs__rx_flow
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, bf__abort_step, bf__reset_sta_slot, bf_req__enqueue, sls__clear_rx_state, uc_log__emit2
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf__abort_unexpected
bf__abort_unexpected:
	.global L_92b254
L_92b254:
	push_s blink
L_92b256:
	bl L_920218
L_92b25a:
	mov_s r13,r0
L_92b25c:
	mov_s r14,0x80207c
L_92b262:
	ld_s r0,[r14,0x34]
L_92b264:
	mov r21,0x801ffc
L_92b26c:
	cmp_s r0,0x0
L_92b26e:
	beq_s L_92b384
L_92b270:
	ld_s r2,[r14,0x40]
L_92b272:
	mov r17,0x8020b4
L_92b27a:
	bmsk_s r2,r2,0x2
L_92b27c:
	ldb r0,[r17,r2]
L_92b280:
	breq r13,r0,L_92b354
L_92b284:
	ld_s r2,[r14,0x34]
L_92b286:
	mov_s r0,0x0
L_92b288:
	bbit0 r2,0x8,L_92b2a2
L_92b28c:
	ld_s r3,[r14,0x34]
L_92b28e:
	mov_s r2,0x1
L_92b290:
	bbit1 r3,r13,L_92b2a2
L_92b294:
	ld_s r3,[r14,0x40]
L_92b296:
	bmsk_s r3,r3,0x2
L_92b298:
	ldb r3,[r17,r3]
L_92b29c:
	cmp_s r3,0x8
L_92b29e:
	mov.eq r0,r2
	.global L_92b2a2
L_92b2a2:
	extb.f 0x0,r0
L_92b2a6:
	bne_s L_92b33e
L_92b2a8:
	ld_s r0,[r14,0x40]
L_92b2aa:
	mov r19,0xb
L_92b2ae:
	bmsk_s r0,r0,0x2
L_92b2b0:
	ldb r16,[r17,r0]
L_92b2b4:
	mov r18,0x0
L_92b2b8:
	mov r20,0x35
L_92b2bc:
	asl r15,r16,0x2
L_92b2c0:
	add2_s r15,r15,r15
L_92b2c2:
	add_s r15,r15,r21
L_92b2c4:
	breq r13,0x8,L_92b314
L_92b2c8:
	mov_s r1,0x1000bb8
L_92b2ce:
	mov_s r0,0x21
L_92b2d0:
	mov_s r2,r13
L_92b2d2:
	bl.d L_92d27c
L_92b2d6:
	mov_s r3,r16
L_92b2d8:
	ld_s r0,[r14,0x34]
L_92b2da:
	asl_s r1,r13,0x2
L_92b2dc:
	bclr r0,r0,r16
L_92b2e0:
	st_s r0,[r14,0x34]
L_92b2e2:
	ld_s r0,[r14,0x34]
L_92b2e4:
	add2_s r1,r1,r1
L_92b2e6:
	bset r0,r0,r13
L_92b2ea:
	st_s r0,[r14,0x34]
L_92b2ec:
	ld_s r0,[r14,0x40]
L_92b2ee:
	bmsk_s r0,r0,0x2
L_92b2f0:
	add_s r0,r0,r17
L_92b2f2:
	stb_s r13,[r0]
L_92b2f4:
	add r0,r21,r1
L_92b2f8:
	st r19,[r0]
L_92b2fc:
	st r18,[r0, 0x4]
L_92b300:
	st r20,[r0, 0x4]
L_92b304:
	st r19,[r15]
L_92b308:
	st r18,[r15, 0x4]
L_92b30c:
	st r20,[r15, 0x4]
L_92b310:
	mov_s r0,r13
L_92b312:
	b_s L_92b332
	.global L_92b314
L_92b314:
	mov_s r1,0x1000bf8
L_92b31a:
	mov_s r0,0x21
L_92b31c:
	mov_s r2,r13
L_92b31e:
	bl.d L_92d27c
L_92b322:
	mov_s r3,r16
L_92b324:
	st r19,[r15]
L_92b328:
	st r18,[r15, 0x4]
L_92b32c:
	st r20,[r15, 0x4]
L_92b330:
	mov_s r0,r16
	.global L_92b332
L_92b332:
	bl L_921824
L_92b336:
	bl L_92ed50
L_92b33a:
	mov_s r0,0x0
L_92b33c:
	b_s L_92b392
	.global L_92b33e
L_92b33e:
	ld_s r0,[r14,0x34]
L_92b340:
	bclr_s r0,r0,0x8
L_92b342:
	st_s r0,[r14,0x34]
L_92b344:
	ld_s r0,[r14,0x34]
L_92b346:
	bset r0,r0,r13
L_92b34a:
	st_s r0,[r14,0x34]
L_92b34c:
	ld_s r0,[r14,0x40]
L_92b34e:
	bmsk_s r0,r0,0x2
L_92b350:
	add_s r0,r0,r17
L_92b352:
	stb_s r13,[r0]
	.global L_92b354
L_92b354:
	mov_s r3,0x0
L_92b356:
	asl_s r0,r13,0x2
L_92b358:
	add2_s r0,r0,r0
L_92b35a:
	add r2,r21,r0
L_92b35e:
	st_s r1,[r2]
L_92b360:
	st_s r3,[r2,0x4]
L_92b362:
	mov_s r1,0x857e49
L_92b368:
	ldb_s r0,[r1,r0]
L_92b36a:
	bic r0,r0,-0x41
L_92b36e:
	sub.f r0,r0,0x0
L_92b372:
	mov.ne r0,0x1
L_92b376:
	extb.f 0x0,r0
L_92b37a:
	bl.ne.d L_92484c
L_92b37e:
	mov.ne r0,r13
L_92b382:
	b_s L_92b390
	.global L_92b384
L_92b384:
	mov_s r2,0x800fec
L_92b38a:
	bl.d L_921bd4
L_92b38e:
	extb_s r0,r13
	.global L_92b390
L_92b390:
	mov_s r0,0x1
	.global L_92b392
L_92b392:
	b L_92026c
L_92b396:
	nop_s
