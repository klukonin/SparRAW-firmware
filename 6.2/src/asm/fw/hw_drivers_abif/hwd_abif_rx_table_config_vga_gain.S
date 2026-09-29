/* hwd_abif_rx_table_config_vga_gain @ 0x8cf418, 224 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_abif_rx_table_config_vga_gain: Row %d, index %d, is_q %d --> not a legal vga_gain_val
 *                                    : vga_gain_val %d,
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_vga_gain_step, hwd_abif__config_vga_rows, hwf_calib_bb_gain_create_table
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit1, fw_log_emit3, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif_rx_table_config_vga_gain
hwd_abif_rx_table_config_vga_gain:
	.global L_8cf418
L_8cf418:
	push_s blink
L_8cf41a:
	bl L_8c01dc
L_8cf41e:
	mov_s r15,r0
L_8cf420:
	mov_s r14,r1
L_8cf422:
	mov_s r16,r2
L_8cf424:
	brge.d r1,0x5,L_8cf45e
L_8cf428:
	mov_s r13,r3
L_8cf42a:
	brlt r14,0x1,L_8cf45e
	.global L_8cf42e
L_8cf42e:
	brge r16,0x2,L_8cf46a
	.global L_8cf432
L_8cf432:
	cmp_s r15,0x40
L_8cf434:
	bge L_8cf476
	.global L_8cf438
L_8cf438:
	sub.f r0,r14,0x1
L_8cf43c:
	beq_s L_8cf4c8
L_8cf43e:
	cmp_s r0,0x1
L_8cf440:
	cmp.ne r0,0x2
L_8cf444:
	cmp.ne r0,0x3
L_8cf448:
	bne_s L_8cf4c8
L_8cf44a:
	brhs r13,0x6,L_8cf49a
L_8cf44e:
	ldb.x r13,[0x803944,r13]
L_8cf456:
	add r0,pcl,0xa
L_8cf45a:
	add1_s r0,r0,r13
L_8cf45c:
	j_s [r0]
	.global L_8cf45e
L_8cf45e:
	mov_s r0,blink
L_8cf460:
	mov_s r1,0xc4
L_8cf462:
	bl.d L_8c9b28
L_8cf466:
	bset_s r1,r1,0xc
L_8cf468:
	b_s L_8cf42e
	.global L_8cf46a
L_8cf46a:
	mov_s r0,blink
L_8cf46c:
	mov_s r1,0xc5
L_8cf46e:
	bl.d L_8c9b28
L_8cf472:
	bset_s r1,r1,0xc
L_8cf474:
	b_s L_8cf432
	.global L_8cf476
L_8cf476:
	mov_s r0,blink
L_8cf478:
	mov_s r1,0xf6
L_8cf47a:
	bl.d L_8c9b28
L_8cf47e:
	bset_s r1,r1,0xc
L_8cf480:
	b_s L_8cf438
L_8cf482:
	mov_s r13,0x2
L_8cf484:
	b_s L_8cf4c8
L_8cf486:
	mov_s r13,0x1
L_8cf488:
	b_s L_8cf4c8
L_8cf48a:
	mov_s r13,0x6
L_8cf48c:
	b_s L_8cf4c8
L_8cf48e:
	mov_s r13,0x3
L_8cf490:
	b_s L_8cf4c8
L_8cf492:
	mov_s r13,0x5
L_8cf494:
	b_s L_8cf4c8
L_8cf496:
	mov_s r13,0x7
L_8cf498:
	b_s L_8cf4c8
	.global L_8cf49a
L_8cf49a:
	mov_s r1,0x101ef7c
L_8cf4a0:
	mov_s r0,0x16
L_8cf4a2:
	mov_s r2,r15
L_8cf4a4:
	mov_s r3,r14
L_8cf4a6:
	bl.d L_8dcd00
L_8cf4aa:
	mov r4,r16
L_8cf4ae:
	mov_s r1,0x101efd8
L_8cf4b4:
	mov_s r0,0x16
L_8cf4b6:
	bl.d L_8dcc10
L_8cf4ba:
	mov_s r2,r13
L_8cf4bc:
	mov_s r0,blink
L_8cf4be:
	mov_s r1,0x12f9
L_8cf4c4:
	bl L_8c9b28
	.global L_8cf4c8
L_8cf4c8:
	rsub r0,r14,0x4
L_8cf4cc:
	extb_s r0,r0
L_8cf4ce:
	add2 r0,r0,r16
L_8cf4d2:
	add_s r0,r0,0x800530
L_8cf4d8:
	ldb_s r1,[r0,0x14]
L_8cf4da:
	ldb_s r2,[r0,0x1c]
L_8cf4dc:
	add2_s r1,r1,r15
L_8cf4de:
	mov_s r0,0x88a208
L_8cf4e4:
	add2_s r0,r0,r1
L_8cf4e6:
	ld_s r3,[r0]
L_8cf4e8:
	mov_s r1,0x7
L_8cf4ea:
	asl_s r1,r1,r2
L_8cf4ec:
	bic_s r3,r3,r1
L_8cf4ee:
	asl_s r13,r13,r2
L_8cf4f0:
	or_s r3,r3,r13
L_8cf4f2:
	st_s r3,[r0]
L_8cf4f4:
	b L_8c0244
