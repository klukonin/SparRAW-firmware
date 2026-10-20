/* hwd_rfc_write_core @ 0x92a3d8, 544 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR curr_blink=0x%x
 *   hwd_rfc_write_core busy set before write! (rfc_opcode=%d, rfc_addr=0x%x, rfc_data=0x%x)
 *   DO_WHILE_WITH_MAX_ITER OCCUR
 *   hwd_rfc_write_core busy set - go again!! (rfc_opcode=%d, rfc_addr=0x%x, rfc_data=0x%x)
 *   [NNL] mac_go_when_busy_err_cnt=%d
 * Зовут его: hw__power_step, hwd_rfc_powerdown_deep_all_rfs, hwd_rfc_read_rgf_uc, rf_utils__fill_step, rfc__clear_core_reg1, rfc__read_core_result, rfc__restore_txrx_sets, rfc__write_core_checked
 * Зовёт сам: uc_log__emit1, uc_log__emit3, uc_log__emit_snapshot, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global hwd_rfc_write_core
hwd_rfc_write_core:
	.global L_92a3d8
L_92a3d8:
	st.a r13,[sp,-0x1c]
L_92a3dc:
	st blink,[sp, 0x4]
L_92a3e0:
	st_s r14,[sp,0x8]
L_92a3e2:
	st_s r15,[sp,0xc]
L_92a3e4:
	st r16,[sp, 0x10]
L_92a3e8:
	st r17,[sp, 0x14]
L_92a3ec:
	st r18,[sp, 0x18]
L_92a3f0:
	mov_s r18,r0
L_92a3f2:
	mov_s r15,r1
L_92a3f4:
	cmp_s r0,0x10
L_92a3f6:
	mov_s r14,r2
L_92a3f8:
	bge.d L_92a4e0
L_92a3fc:
	mov r16,r3
	.global L_92a400
L_92a400:
	cmp r15,0x10
L_92a404:
	bge L_92a4f0
	.global L_92a408
L_92a408:
	cmp r14,0x7fff
L_92a410:
	bhi L_92a500
	.global L_92a414
L_92a414:
	mov_s r13,0x889000
L_92a41a:
	ld r3,[r13, 0xcc]
L_92a41e:
	bmsk r17,r15,0x3
L_92a422:
	btst_s r3,0x1d
L_92a424:
	bne.d L_92a510
L_92a428:
	asl r17,r17,0x4
	.global L_92a42c
L_92a42c:
	and.f 0x0,r17,0xffff8000
L_92a434:
	bne L_92a570
	.global L_92a438
L_92a438:
	ld r2,[r13, 0xd0]
L_92a43c:
	asl r17,r17,0x10
L_92a440:
	and r2,r2,0x8000ffff
L_92a448:
	or r2,r2,r17
L_92a44c:
	st r2,[r13, 0xd0]
L_92a450:
	ld r11,[r13, 0xd4]
L_92a454:
	st r14,[r13, 0xd4]
L_92a458:
	ld r10,[r13, 0xd8]
L_92a45c:
	st r16,[r13, 0xd8]
L_92a460:
	ld r3,[r13, 0xcc]
L_92a464:
	mov lp_count,0x30d40
L_92a46c:
	bset r3,r3,0x1e
L_92a470:
	st r3,[r13, 0xcc]
L_92a474:
	lp L_92a488
L_92a478:
	ld r4,[r13, 0xcc]
L_92a47c:
	btst r4,0x1d
L_92a480:
	beq_s L_92a488
L_92a482:
	nop_s
L_92a484:
	mov 0x0,0x0
	.global L_92a488
L_92a488:
	ld r9,[r13, 0xcc]
L_92a48c:
	bbit0 r9,0x1d,L_92a4a0
L_92a490:
	mov_s r2,blink
L_92a492:
	mov_s r1,0x1001e90
L_92a498:
	bl.d L_92d1d0
L_92a49c:
	mov r0,0x0
	.global L_92a4a0
L_92a4a0:
	ld r6,[r13, 0xcc]
L_92a4a4:
	btst r6,0x1d
L_92a4a8:
	bne L_92a580
	.global L_92a4ac
L_92a4ac:
	mov r5,0x8016ec
L_92a4b4:
	add2 r5,r5,r18
L_92a4b8:
	ld r4,[r5]
L_92a4bc:
	ld blink,[sp, 0x4]
L_92a4c0:
	add r4,r4,0x1
L_92a4c4:
	st r4,[r5]
L_92a4c8:
	ld_s r14,[sp,0x8]
L_92a4ca:
	ld_s r15,[sp,0xc]
L_92a4cc:
	ld r16,[sp, 0x10]
L_92a4d0:
	ld r17,[sp, 0x14]
L_92a4d4:
	ld r18,[sp, 0x18]
L_92a4d8:
	j.d [blink]
L_92a4dc:
	ld.ab r13,[sp,0x1c]
	.global L_92a4e0
L_92a4e0:
	mov_s r0,blink
L_92a4e2:
	mov_s r1,0x1135
L_92a4e8:
	bl L_926618
L_92a4ec:
	b L_92a400
	.global L_92a4f0
L_92a4f0:
	mov_s r0,blink
L_92a4f2:
	mov_s r1,0x45
L_92a4f4:
	bl.d L_926618
L_92a4f8:
	asl r1,r1,0x6
L_92a4fc:
	b L_92a408
	.global L_92a500
L_92a500:
	mov_s r0,blink
L_92a502:
	mov_s r1,0x1141
L_92a508:
	bl L_926618
L_92a50c:
	b L_92a414
	.global L_92a510
L_92a510:
	mov_s r1,0x100210c
L_92a516:
	mov_s r0,0x10
L_92a518:
	mov_s r2,r15
L_92a51a:
	mov_s r3,r14
L_92a51c:
	bl.d L_92d338
L_92a520:
	mov r4,r16
L_92a524:
	mov lp_count,0x30d40
L_92a52c:
	mov 0x0,0x0
L_92a530:
	lp L_92a540
L_92a534:
	ld r2,[r13, 0xcc]
L_92a538:
	btst_s r2,0x1d
L_92a53a:
	beq_s L_92a540
L_92a53c:
	mov 0x0,0x0
	.global L_92a540
L_92a540:
	ld r5,[r13, 0xcc]
L_92a544:
	btst r5,0x1d
L_92a548:
	beq_s L_92a42c
L_92a54a:
	mov_s r1,0x1001ec0
L_92a550:
	bl.d L_92d13c
L_92a554:
	mov r0,0x0
L_92a558:
	mov_s r0,blink
L_92a55a:
	mov_s r1,0x134a
L_92a560:
	bl L_926618
L_92a564:
	and.f 0x0,r17,0xffff8000
L_92a56c:
	beq L_92a438
	.global L_92a570
L_92a570:
	mov r0,blink
L_92a574:
	bl.d L_926618
L_92a578:
	mov r1,0xac
L_92a57c:
	b L_92a438
	.global L_92a580
L_92a580:
	mov_s r1,0x1002164
L_92a586:
	mov_s r0,0x10
L_92a588:
	mov_s r2,r15
L_92a58a:
	mov_s r3,r14
L_92a58c:
	bl.d L_92d338
L_92a590:
	mov r4,r16
L_92a594:
	ld.as r2,[r13,0x42]
L_92a598:
	mov_s r1,0x10021bc
L_92a59e:
	bmsk_s r2,r2,0xe
L_92a5a0:
	bl.d L_92d1d0
L_92a5a4:
	mov r0,0x10
L_92a5a8:
	ld r3,[r13, 0xcc]
L_92a5ac:
	mov lp_count,0x30d40
L_92a5b4:
	bset r3,r3,0x1e
L_92a5b8:
	st r3,[r13, 0xcc]
L_92a5bc:
	lp L_92a5d0
L_92a5c0:
	ld r7,[r13, 0xcc]
L_92a5c4:
	btst r7,0x1d
L_92a5c8:
	beq_s L_92a5d0
L_92a5ca:
	nop_s
L_92a5cc:
	mov 0x0,0x0
	.global L_92a5d0
L_92a5d0:
	ld r8,[r13, 0xcc]
L_92a5d4:
	btst r8,0x1d
L_92a5d8:
	beq_s L_92a4ac
L_92a5da:
	mov_s r1,0x1001ec0
L_92a5e0:
	bl.d L_92d13c
L_92a5e4:
	mov r0,0x0
L_92a5e8:
	mov_s r0,blink
L_92a5ea:
	mov_s r1,0x133d
L_92a5f0:
	bl L_926618
L_92a5f4:
	b_s L_92a4ac
L_92a5f6:
	nop_s
