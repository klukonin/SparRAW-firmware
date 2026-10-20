/* wmi_handler_set_rf_sector_params__set_rf_sector_params @ 0x8cd410, 292 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   wmi_handler_set_rf_sector_params::set_rf_sector_params(): Writing RF Sector: rfc_idx=%d, sector_idx=%d, sector_type=%d,
 *   [NNL] psh_hi=0x%X, psh_lo=0x%X, etype0=0x%X,
 *   [NNL] etype1=0x%X, etype2=0x%X, dtype_swch_off=0x%X,
 * Зовут его: dma__set_881b24_bit1
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, bit_iter__has_more, bitmap__alloc_bit, field_set_0x00__8e5dfc, fw_log_emit3, fw_sysassert_fatal, hwd__program_rf_regs_seq, hwd_abif__dvs_rfca_cmd_enable, mem_pool__alloc_locked, memset0_words, rf_cfg__get_rf_mask_45e
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_handler_set_rf_sector_params__set_rf_sector_params
wmi_handler_set_rf_sector_params__set_rf_sector_params:
	.global L_8cd410
L_8cd410:
	push_s blink
L_8cd412:
	bl L_8c01c8
L_8cd416:
	sub_s sp,sp,0x10
L_8cd418:
	mov_s r13,r0
L_8cd41a:
	bl.d L_8c33d0
L_8cd41e:
	ld r0,[r0, 0xc4]
L_8cd422:
	mov_s r18,r0
L_8cd424:
	bl.d L_8c1cd8
L_8cd428:
	mov_s r1,0x1
L_8cd42a:
	mov_s r0,0x0
L_8cd42c:
	mov_s r19,r0
L_8cd42e:
	stb_s r0,[sp,0x8]
L_8cd430:
	mov_s r0,0x8042c8
L_8cd436:
	bl.d L_8ccb3c
L_8cd43a:
	add_s r14,sp,0x8
L_8cd43c:
	mov_s r2,r0
L_8cd43e:
	ldb_s r1,[r13,0x3]
L_8cd440:
	add_s r0,sp,0xc
L_8cd442:
	mov_s r17,r0
L_8cd444:
	bl.d L_8e5dfc
L_8cd448:
	and_s r1,r1,r2
L_8cd44a:
	b_s L_8cd4f2
	.global L_8cd44c
L_8cd44c:
	bl.d L_8df444
L_8cd450:
	mov_s r0,r17
L_8cd452:
	mov_s r16,r0
L_8cd454:
	cmp_s r0,0x8
L_8cd456:
	mov.cc r0,blink
L_8cd45a:
	mov.cc r1,0x1499
L_8cd462:
	bl.cc L_8c9b28
L_8cd466:
	mov_s r0,0x0
L_8cd468:
	bset r0,r0,r16
L_8cd46c:
	extb_s r0,r0
L_8cd46e:
	bl.d L_8ce910
L_8cd472:
	mov_s r1,r14
L_8cd474:
	mov r21,0x0
L_8cd478:
	asl r15,r16,0x3
L_8cd47c:
	add1_s r15,r15,r15
L_8cd47e:
	add r20,r13,0x4
L_8cd482:
	add r14,r20,r15
L_8cd486:
	ldb_s r1,[r13,0x2]
L_8cd488:
	extb r0,r16
L_8cd48c:
	cmp_s r1,0x1
L_8cd48e:
	mov_s r2,0x1
L_8cd490:
	ld r4,[r14, 0x4]
L_8cd494:
	sub_s.ne r2,r2,r2
L_8cd496:
	ld r5,[r14, 0x8]
L_8cd49a:
	ld r6,[r14, 0xc]
L_8cd49e:
	ld_s r1,[r14,0x14]
L_8cd4a0:
	ld r7,[r14, 0x10]
L_8cd4a4:
	st_s r1,[sp,0x0]
L_8cd4a6:
	mov_s r1,0xff
L_8cd4a8:
	st_s r1,[sp,0x4]
L_8cd4aa:
	ldw_s r1,[r13]
L_8cd4ac:
	bl.d L_8d4338
L_8cd4b0:
	ld_s r3,[r14]
L_8cd4b2:
	mov_s r1,0x10084cc
L_8cd4b8:
	ldb r4,[r13, 0x2]
L_8cd4bc:
	mov_s r0,0x20
L_8cd4be:
	mov_s r2,r16
L_8cd4c0:
	bl.d L_8dcd00
L_8cd4c4:
	ldw_s r3,[r13]
L_8cd4c6:
	mov_s r1,0x10080f8
L_8cd4cc:
	ld r4,[r14, 0x8]
L_8cd4d0:
	mov_s r0,0x20
L_8cd4d2:
	ld_s r2,[r14]
L_8cd4d4:
	bl.d L_8dcd00
L_8cd4d8:
	ld_s r3,[r14,0x4]
L_8cd4da:
	add_s r15,r15,r20
L_8cd4dc:
	ld r4,[r15, 0x14]
L_8cd4e0:
	mov_s r1,0x1008128
L_8cd4e6:
	ld_s r2,[r14,0xc]
L_8cd4e8:
	mov_s r0,0x20
L_8cd4ea:
	bl.d L_8dcd00
L_8cd4ee:
	ld_s r3,[r14,0x10]
L_8cd4f0:
	mov_s r14,r21
	.global L_8cd4f2
L_8cd4f2:
	bl.d L_8cdcc4
L_8cd4f6:
	mov_s r0,r17
L_8cd4f8:
	brne r0,0x0,L_8cd44c
L_8cd4fc:
	ldb_s r0,[sp,0x8]
L_8cd4fe:
	bl.d L_8ce910
L_8cd502:
	mov_s r1,0x0
L_8cd504:
	stb r19,[r18]
L_8cd508:
	st r19,[sp]
L_8cd50c:
	ld r0,[r13, 0xc4]
L_8cd510:
	mov_s r1,r18
L_8cd512:
	mov_s r2,0x0
L_8cd514:
	mov_s r3,0x19a1
L_8cd51a:
	mov r4,0x1
L_8cd51e:
	mov r5,0x0
L_8cd522:
	mov r6,0x0
L_8cd526:
	bl.d L_8e4fc4
L_8cd52a:
	mov r7,0x0
L_8cd52e:
	b.d L_8c021c
L_8cd532:
	add_s sp,sp,0x10
