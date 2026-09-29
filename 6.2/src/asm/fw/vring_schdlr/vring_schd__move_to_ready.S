/* vring_schd__move_to_ready @ 0x8c24b0, 256 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   High Priority #%d V-ring -> moved to ready queue.
 * Зовут его: vring_schd__alloc_pring, vring_schd__move_ready_if_idle, vring_schd__resume_vring
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit1, fw_sysassert_fatal, list__find_entry_d, rm_ch_switch_sm__notify_ch_switch_done, vring__reg_write_locked_28, vring__reg_write_locked_3c, vring_hw__set_ready_bit, vring_schd__bind_if_free, vring_schd__is_vring_ready, vring_schd__stop_vring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring_schd__move_to_ready
vring_schd__move_to_ready:
	.global L_8c24b0
L_8c24b0:
	push_s blink
L_8c24b2:
	bl L_8c01dc
L_8c24b6:
	mov_s r15,r0
L_8c24b8:
	ldb_s r0,[r1,0xb]
L_8c24ba:
	brhs.d r0,0x2,L_8c24f0
L_8c24be:
	mov_s r14,r1
	.global L_8c24c0
L_8c24c0:
	mov_s r0,r15
L_8c24c2:
	bl.d L_8c5b44
L_8c24c6:
	ldb_s r1,[r14,0x8]
L_8c24c8:
	mov.f r13,r0
L_8c24cc:
	beq_s L_8c2580
L_8c24ce:
	ld r16,[r13, 0x14]
L_8c24d2:
	brne r16,0x0,L_8c24fe
L_8c24d6:
	mov_s r0,0x804dbc
L_8c24dc:
	bl.d L_8c655c
L_8c24e0:
	ldb_s r1,[r14,0xa]
L_8c24e2:
	brne_s r0,0,L_8c24fe
L_8c24e4:
	mov_s r0,r15
L_8c24e6:
	mov_s r1,r14
L_8c24e8:
	bl.d L_8c7160
L_8c24ec:
	mov_s r2,r13
L_8c24ee:
	b_s L_8c259c
	.global L_8c24f0
L_8c24f0:
	mov_s r0,blink
L_8c24f2:
	mov_s r1,0x1475
L_8c24f8:
	bl L_8c9b28
L_8c24fc:
	b_s L_8c24c0
	.global L_8c24fe
L_8c24fe:
	ldb_s r0,[r14,0x8]
L_8c2500:
	breq r0,0x1,L_8c2564
	.global L_8c2504
L_8c2504:
	ldb_s r0,[r14,0xb]
L_8c2506:
	brne r0,0x1,L_8c252a
L_8c250a:
	mov_s r1,0x100bb08
L_8c2510:
	mov_s r0,0x27
L_8c2512:
	bl.d L_8dcc10
L_8c2516:
	ldb_s r2,[r14,0x9]
L_8c2518:
	breq r16,0x0,L_8c2572
	.global L_8c251c
L_8c251c:
	mov_s r1,0x4
L_8c251e:
	st r1,[r16, 0x24]
L_8c2522:
	mov_s r0,r15
L_8c2524:
	bl.d L_8e80cc
L_8c2528:
	mov_s r1,r13
	.global L_8c252a
L_8c252a:
	ldb_s r1,[r14,0xb]
L_8c252c:
	add r0,r15,0x10
L_8c2530:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8c2532:
	add1_s r1,r1,r1
L_8c2534:
	add_s r0,r0,r1
L_8c2536:
	bl.d L_8c25f4
L_8c253a:
	mov_s r1,r14
L_8c253c:
	mov_s r0,0x2
L_8c253e:
	st_s r0,[r14,0x24]
L_8c2540:
	ldw_s r1,[r13]
L_8c2542:
	mov_s r0,0x0
L_8c2544:
	bset r0,r0,r1
L_8c2548:
	bl.d L_8d0538
L_8c254c:
	mov_s r1,0x0
L_8c254e:
	bl.d L_8d0598
L_8c2552:
	ldw_s r0,[r13]
L_8c2554:
	ldw_s r1,[r13]
L_8c2556:
	mov_s r0,0x0
L_8c2558:
	bset r0,r0,r1
L_8c255c:
	bl.d L_8d0568
L_8c2560:
	mov_s r1,0x1
L_8c2562:
	b_s L_8c259c
	.global L_8c2564
L_8c2564:
	mov_s r0,blink
L_8c2566:
	mov_s r1,0x140e
L_8c256c:
	bl L_8c9b28
L_8c2570:
	b_s L_8c2504
	.global L_8c2572
L_8c2572:
	mov_s r0,blink
L_8c2574:
	mov_s r1,0x147c
L_8c257a:
	bl L_8c9b28
L_8c257e:
	b_s L_8c251c
	.global L_8c2580
L_8c2580:
	ldb_s r0,[r14,0x8]
L_8c2582:
	breq r0,0x1,L_8c25a0
	.global L_8c2586
L_8c2586:
	ldb_s r1,[r14,0xb]
L_8c2588:
	add r0,r15,0x10
L_8c258c:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8c258e:
	add1_s r1,r1,r1
L_8c2590:
	add_s r0,r0,r1
L_8c2592:
	bl.d L_8c25f4
L_8c2596:
	mov_s r1,r14
L_8c2598:
	mov_s r0,0x2
L_8c259a:
	st_s r0,[r14,0x24]
	.global L_8c259c
L_8c259c:
	b L_8c0244
	.global L_8c25a0
L_8c25a0:
	mov_s r0,blink
L_8c25a2:
	mov_s r1,0x140d
L_8c25a8:
	bl L_8c9b28
L_8c25ac:
	b_s L_8c2586
L_8c25ae:
	nop_s
