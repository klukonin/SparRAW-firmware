/* peer_masks__or_into_8571c4 @ 0x9263d0, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw_worker__collect_awake_peers, ucode_cmd_0x47_handler
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, qh__build_descriptor_b, sta__find_by_byte, uc_evt__send_2e, uc_sysassert
 * Глобалы (через gp): 0x800570
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global peer_masks__or_into_8571c4
peer_masks__or_into_8571c4:
	.global L_9263d0
L_9263d0:
	push_s r13
L_9263d2:
	mov_s r1,r0
L_9263d4:
	b_s L_9263fc
	.global L_9263d6
L_9263d6:
	norm r0,r1
L_9263da:
	rsub r2,r0,0x1e
L_9263de:
	extb_s r2,r2
L_9263e0:
	mov_s r3,0x0
L_9263e2:
	ld_s r0,[gp,0x48]
L_9263e4:
	bset r3,r3,r2
L_9263e8:
	and_s r0,r0,r3
L_9263ea:
	mov_s r13,0x857180
L_9263f0:
	ld_s r3,[r13,0x44]
L_9263f2:
	bclr r1,r1,r2
L_9263f6:
	or_s r3,r3,r0
L_9263f8:
	st_s r3,[r13,0x44]
L_9263fa:
	extb_s r1,r1
	.global L_9263fc
L_9263fc:
	brne_s r1,0,L_9263d6
L_9263fe:
	j_s.d [blink]
L_926400:
	pop_s r13
L_926402:
	nop_s
	.global L_926404
L_926404:
	push_s blink
L_926406:
	bl L_92022c
L_92640a:
	mov_s r15,r0
L_92640c:
	mov_s r13,r1
L_92640e:
	bl.d L_9267ac
L_926412:
	mov_s r16,r2
L_926414:
	brhs.d r0,0x8,L_926436
L_926418:
	mov_s r14,r0
	.global L_92641a
L_92641a:
	add_s r15,r15,0x20
L_92641c:
	breq r16,0x0,L_926444
L_926420:
	ldb_s r0,[r15,0x9]
L_926422:
	bset r0,r0,r14
L_926426:
	stb_s r0,[r15,0x9]
L_926428:
	bl.d L_92d400
L_92642c:
	mov_s r0,r13
L_92642e:
	mov_s r2,r0
L_926430:
	mov_s r0,r13
L_926432:
	mov_s r1,0x1
L_926434:
	b_s L_926464
	.global L_926436
L_926436:
	mov_s r0,blink
L_926438:
	mov_s r1,0x1584
L_92643e:
	bl L_926618
L_926442:
	b_s L_92641a
	.global L_926444
L_926444:
	ldb_s r0,[r15,0x8]
L_926446:
	brne r14,r0,L_926450
L_92644a:
	stb_s r13,[r15,0xa]
L_92644c:
	stb_s r14,[r15,0xb]
L_92644e:
	b_s L_926468
	.global L_926450
L_926450:
	ldb_s r0,[r15,0x9]
L_926452:
	bclr r0,r0,r14
L_926456:
	stb_s r0,[r15,0x9]
L_926458:
	bl.d L_92d400
L_92645c:
	mov_s r0,r13
L_92645e:
	mov_s r2,r0
L_926460:
	mov_s r0,r13
L_926462:
	mov_s r1,0x0
	.global L_926464
L_926464:
	bl L_9278fc
	.global L_926468
L_926468:
	b L_920294
