/* bf_sm__pop_request_fifo @ 0x9223b4, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__clear_sta, bf_sm__process_request_fifo
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, bf_sm__clear_pending, bf_sm__start_request
 */
	.section .text.bf_sm__pop_request_fifo,"ax",@progbits
	.global bf_sm__pop_request_fifo
bf_sm__pop_request_fifo:
	.global L_9223b4
L_9223b4:
	push_s blink
L_9223b6:
	bl L_920210
L_9223ba:
	push_s r0
L_9223bc:
	mov_s r15,r1
L_9223be:
	lr r13,[0xa]
L_9223c2:
	bclr r0,r13,0x1
L_9223c6:
	flag r0
L_9223ca:
	mov_s r2,0x800ef4
L_9223d0:
	ld_s r0,[r2,0x78]
L_9223d2:
	mov_s r1,0x800f64
L_9223d8:
	bmsk r3,r0,0x2
L_9223dc:
	ldb_s r14,[r1,r3]
L_9223de:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9223e0:
	st_s r0,[r2,0x78]
L_9223e2:
	ld_s r0,[r2,0x6c]
L_9223e4:
	asl_s r3,r14,0x2
L_9223e6:
	bclr r0,r0,r14
L_9223ea:
	st_s r0,[r2,0x6c]
L_9223ec:
	add1_s r3,r3,r3
L_9223ee:
	mov_s r0,0x0
L_9223f0:
	add_s r3,r3,r2
L_9223f2:
	st_s r0,[r3]
L_9223f4:
	ld_s r0,[r2,0x6c]
L_9223f6:
	breq_s r0,0,L_92241a
L_9223f8:
	ld_s r0,[r2,0x78]
L_9223fa:
	bmsk_s r0,r0,0x2
L_9223fc:
	ldb_s r0,[r1,r0]
L_9223fe:
	mov_s r2,0x801014
L_922404:
	asl_s r1,r0,0x3
L_922406:
	add3_s r1,r1,r1
L_922408:
	add_s r1,r1,0x8011b0
L_92240e:
	ld_s r3,[r1,0xc]
L_922410:
	ldw_s r1,[r1,0x10]
L_922412:
	st_s r3,[r2,0x14]
L_922414:
	bl.d L_92208c
L_922418:
	stw_s r1,[r2,0x18]
	.global L_92241a
L_92241a:
	brne_s r15,0,L_922434
L_92241c:
	ld_s r0,[sp,0x0]
L_92241e:
	bl.d L_922560
L_922422:
	mov_s r1,r14
L_922424:
	mov_s r1,0x800f74
L_92242a:
	ld_s r0,[r1,0x48]
L_92242c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92242e:
	st_s r0,[r1,0x48]
L_922430:
	st.as r0,[gp,-0xd]
	.global L_922434
L_922434:
	lr r0,[0xa]
L_922438:
	bic r13,r13,-0x3
L_92243c:
	or_s r13,r13,r0
L_92243e:
	flag r13
L_922442:
	b.d L_92027c
L_922446:
	add_s sp,sp,0x4
