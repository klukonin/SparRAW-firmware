/* stream_mgr__ready_for_modify @ 0x8e23a4, 208 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   STREAM_MGR::ready_for_modify: stream was already removed
 * Зовёт сам: __ld_r13_to_r13_ret, __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__handle_event, conn_mgr__by_cid, fw_log_emit0, fw_sysassert_fatal, stream_mgr__prepare_buf30_by_id, stream_mgr__ready_step, vring__get_pring_id, vring_tbl__entry_addr
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global stream_mgr__ready_for_modify
stream_mgr__ready_for_modify:
	.global L_8e23a4
L_8e23a4:
	push_s blink
L_8e23a6:
	bl L_8c01e4
L_8e23aa:
	mov_s r1,0x847f34
L_8e23b0:
	sub r1,r1,0x400
L_8e23b4:
	add2_s r1,r1,r0
L_8e23b6:
	ld r13,[r1,0x44c]
L_8e23be:
	brne_s r13,0,L_8e23ce
L_8e23c0:
	mov_s r1,0x1010a00
L_8e23c6:
	bl.d L_8dcba8
L_8e23ca:
	mov_s r0,0x1b
L_8e23cc:
	b_s L_8e23f6
	.global L_8e23ce
L_8e23ce:
	ldb_s r0,[r13,0x7]
L_8e23d0:
	breq r0,0x9,L_8e23f6
L_8e23d4:
	ld_s r0,[r13,0xc]
L_8e23d6:
	brne_s r0,0,L_8e23ee
L_8e23d8:
	bl.d L_8cbed8
L_8e23dc:
	mov_s r0,r13
L_8e23de:
	bl L_8cbffc
L_8e23e2:
	mov.f r14,r0
L_8e23e6:
	beq_s L_8e23fa
	.global L_8e23e8
L_8e23e8:
	bl.d L_8e8310
L_8e23ec:
	mov_s r0,r14
	.global L_8e23ee
L_8e23ee:
	ld_s r0,[r13,0x68]
L_8e23f0:
	ld_s r1,[r0,0x10]
L_8e23f2:
	jl_s.d [r1]
L_8e23f4:
	mov_s r0,r13
	.global L_8e23f6
L_8e23f6:
	b L_8c0254
	.global L_8e23fa
L_8e23fa:
	mov_s r0,blink
L_8e23fc:
	mov_s r1,0x128e
L_8e2402:
	bl L_8c9b28
L_8e2406:
	b_s L_8e23e8
L_8e2408:
	push_s blink
L_8e240a:
	push_s r13
L_8e240c:
	mov_s r13,r0
L_8e240e:
	bl.d L_8ccfd8
L_8e2412:
	ldb_s r0,[r0,0x7]
L_8e2414:
	mov_s r1,0x847adc
L_8e241a:
	ldb_s r1,[r1,0x5]
L_8e241c:
	brne_s r1,0,L_8e2426
L_8e241e:
	bl L_8cccb4
L_8e2422:
	stw r0,[r13, 0x5c]
	.global L_8e2426
L_8e2426:
	add r0,r13,0x10
L_8e242a:
	ldb_s r1,[r0,0x8]
L_8e242c:
	cmp_s r1,0x6
L_8e242e:
	mov_s r1,0x1
L_8e2430:
	sub_s.ne r1,r1,r1
L_8e2432:
	extb.f 0x0,r1
L_8e2436:
	mov_s r2,0x0
L_8e2438:
	bne_s L_8e243e
	.global L_8e243a
L_8e243a:
	mov_s r1,r2
L_8e243c:
	b_s L_8e2446
	.global L_8e243e
L_8e243e:
	ldb_s r1,[r0]
L_8e2440:
	brne r1,0x1,L_8e243a
L_8e2444:
	mov_s r1,0x1
	.global L_8e2446
L_8e2446:
	extb.f 0x0,r1
L_8e244a:
	bne_s L_8e2458
L_8e244c:
	ldb_s r1,[r0]
L_8e244e:
	cmp_s r1,0x3
L_8e2450:
	cmp.ne r1,0x4
L_8e2454:
	mov_s r1,0x0
L_8e2456:
	bne_s L_8e245a
	.global L_8e2458
L_8e2458:
	mov_s r1,0x1
	.global L_8e245a
L_8e245a:
	extb.f 0x0,r1
L_8e245e:
	mov.ne r1,0x2
L_8e2462:
	sub_s.ne r2,r2,r2
L_8e2464:
	mov.ne r3,r2
L_8e2468:
	bl.ne.d L_8d9b6c
L_8e246c:
	mov.ne r4,r2
L_8e2470:
	b L_8c025c
