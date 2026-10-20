/* calib_lo_power_substep @ 0x8d24e4, 172 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_lo_power_step
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, calib_lo_power_measure, hwd_abif__rgf_88a200_8cc674
 */
	.section .text.calib_lo_power_substep,"ax",@progbits
	.global calib_lo_power_substep
calib_lo_power_substep:
	.global L_8d24e4
L_8d24e4:
	push_s blink
L_8d24e6:
	bl L_8c02a8
L_8d24ea:
	sub_s sp,sp,0x10
L_8d24ec:
	mov_s r17,r0
L_8d24ee:
	mov_s r14,r1
L_8d24f0:
	mov_s r16,r2
L_8d24f2:
	ldb r21,[gp, 0x9a]
L_8d24f6:
	mov_s r0,0x0
L_8d24f8:
	mov_s r20,r0
L_8d24fa:
	mov_s r15,0xff
L_8d24fc:
	mov_s r2,r0
L_8d24fe:
	mov_s r18,r15
L_8d2500:
	mov_s r13,r15
L_8d2502:
	mov_s r19,r0
L_8d2504:
	b_s L_8d2512
	.global L_8d2506
L_8d2506:
	mov_s r14,r15
	.global L_8d2508
L_8d2508:
	mov r20,0x1
	.global L_8d250c
L_8d250c:
	mov_s r2,r13
L_8d250e:
	mov_s r18,r0
L_8d2510:
	mov_s r19,r1
	.global L_8d2512
L_8d2512:
	brne r20,0x0,L_8d257c
L_8d2516:
	mov_s r0,0x0
L_8d2518:
	bl.d L_8cc674
L_8d251c:
	mov_s r1,r0
L_8d251e:
	mov_s r0,0x1
L_8d2520:
	bl.d L_8cc674
L_8d2524:
	mov_s r1,r14
L_8d2526:
	add_s r2,sp,0x8
L_8d2528:
	mov_s r0,r14
L_8d252a:
	bl.d L_8d3f40
L_8d252e:
	mov_s r1,r21
L_8d2530:
	ld_s r2,[sp,0x8]
L_8d2532:
	mov_s r0,0x0
L_8d2534:
	brlt.d r2,0x0,L_8d2540
L_8d2538:
	bset_s r0,r0,0xf
L_8d253a:
	add_s r0,r0,r2
L_8d253c:
	asr_s r0,r0,0x10
L_8d253e:
	b_s L_8d2546
	.global L_8d2540
L_8d2540:
	sub_s r0,r0,r2
L_8d2542:
	asr_s r0,r0,0x10
L_8d2544:
	neg_s r0,r0
	.global L_8d2546
L_8d2546:
	sexb_s r0,r0
L_8d2548:
	sub r1,r16,r0
L_8d254c:
	sexb_s r1,r1
L_8d254e:
	abs_s r0,r1
L_8d2550:
	cmp_s r1,0x0
L_8d2552:
	extb_s r0,r0
L_8d2554:
	mov.eq r13,r2
L_8d2558:
	beq_s L_8d2508
L_8d255a:
	brlt r18,r0,L_8d2506
L_8d255e:
	rsub r3,r19,0x0
L_8d2562:
	breq r1,r3,L_8d2506
L_8d2566:
	brlt r1,0x1,L_8d2570
L_8d256a:
	sub_s r3,r14,0x1
L_8d256c:
	extb_s r3,r3
L_8d256e:
	b_s L_8d2574
	.global L_8d2570
L_8d2570:
	add_s r3,r14,0x1
L_8d2572:
	extb_s r3,r3
	.global L_8d2574
L_8d2574:
	mov_s r13,r2
L_8d2576:
	mov_s r15,r14
L_8d2578:
	mov_s r14,r3
L_8d257a:
	b_s L_8d250c
	.global L_8d257c
L_8d257c:
	stb_s r14,[sp,0x0]
L_8d257e:
	ld_s r1,[sp,0x0]
L_8d2580:
	st r2,[r17, 0x4]
L_8d2584:
	st r1,[r17]
L_8d2588:
	b.d L_8c02fc
L_8d258c:
	add_s sp,sp,0x10
L_8d258e:
	nop_s
