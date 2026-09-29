/* hwd_abif_rx_table_config_vga_gain @ 0x8cc4a0, 272 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 *   hwd_abif_rx_table_config_vga_gain: Row %d, index %d, is_q %d --> not a legal vga_gain_val
 *                                    : vga_gain_val %d,
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_vga_gain_step, hwd_abif__config_vga_rows, hwf_calib_bb_gain_create_table
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit1, fw_log__emit3, fw_sysassert_fatal
 */
	.section .text.hwd_abif_rx_table_config_vga_gain,"ax",@progbits
	.global hwd_abif_rx_table_config_vga_gain
hwd_abif_rx_table_config_vga_gain:
	.global L_8cc4a0
L_8cc4a0:
	push_s blink
L_8cc4a2:
	bl L_8c02b8
L_8cc4a6:
	mov_s r14,r0
L_8cc4a8:
	mov_s r16,r1
L_8cc4aa:
	mov_s r17,r2
L_8cc4ac:
	brge.d r1,0x5,L_8cc4e6
L_8cc4b0:
	mov_s r13,r3
L_8cc4b2:
	brlt r16,0x1,L_8cc4e6
	.global L_8cc4b6
L_8cc4b6:
	brge r17,0x2,L_8cc4fc
	.global L_8cc4ba
L_8cc4ba:
	cmp_s r14,0x40
L_8cc4bc:
	bge L_8cc512
	.global L_8cc4c0
L_8cc4c0:
	sub.f r0,r16,0x1
L_8cc4c4:
	beq_s L_8cc57e
L_8cc4c6:
	cmp_s r0,0x1
L_8cc4c8:
	cmp.ne r0,0x2
L_8cc4cc:
	cmp.ne r0,0x3
L_8cc4d0:
	bne_s L_8cc57e
L_8cc4d2:
	brhs r13,0x6,L_8cc540
L_8cc4d6:
	ldb.x r13,[0x8030d0,r13]
L_8cc4de:
	add r0,pcl,0xa
L_8cc4e2:
	add1_s r0,r0,r13
L_8cc4e4:
	j_s [r0]
	.global L_8cc4e6
L_8cc4e6:
	mov_s r0,blink
L_8cc4e8:
	mov_s r2,0x1019954
L_8cc4ee:
	mov_s r1,0xc4
L_8cc4f0:
	bset_s r1,r1,0xc
L_8cc4f2:
	bl.d L_8c82c0
L_8cc4f6:
	mov r3,0x475
L_8cc4fa:
	b_s L_8cc4b6
	.global L_8cc4fc
L_8cc4fc:
	mov_s r0,blink
L_8cc4fe:
	mov_s r2,0x1019954
L_8cc504:
	mov_s r1,0xc5
L_8cc506:
	bset_s r1,r1,0xc
L_8cc508:
	bl.d L_8c82c0
L_8cc50c:
	mov r3,0x476
L_8cc510:
	b_s L_8cc4ba
	.global L_8cc512
L_8cc512:
	mov_s r0,blink
L_8cc514:
	mov_s r2,0x1019954
L_8cc51a:
	mov_s r1,0xf6
L_8cc51c:
	bset_s r1,r1,0xc
L_8cc51e:
	bl.d L_8c82c0
L_8cc522:
	mov r3,0x477
L_8cc526:
	b_s L_8cc4c0
L_8cc528:
	mov_s r13,0x2
L_8cc52a:
	b_s L_8cc57e
L_8cc52c:
	mov_s r13,0x1
L_8cc52e:
	b_s L_8cc57e
L_8cc530:
	mov_s r13,0x6
L_8cc532:
	b_s L_8cc57e
L_8cc534:
	mov_s r13,0x3
L_8cc536:
	b_s L_8cc57e
L_8cc538:
	mov_s r13,0x5
L_8cc53a:
	b_s L_8cc57e
L_8cc53c:
	mov_s r13,0x7
L_8cc53e:
	b_s L_8cc57e
	.global L_8cc540
L_8cc540:
	mov_s r2,0x10199e0
L_8cc546:
	mov_s r0,0x6
L_8cc548:
	mov_s r1,0x1
L_8cc54a:
	mov_s r3,r14
L_8cc54c:
	mov r4,r16
L_8cc550:
	bl.d L_8ee034
L_8cc554:
	mov r5,r17
L_8cc558:
	mov_s r2,0x1019a3c
L_8cc55e:
	mov_s r0,0x6
L_8cc560:
	mov_s r1,0x1
L_8cc562:
	bl.d L_8edfcc
L_8cc566:
	mov_s r3,r13
L_8cc568:
	mov_s r0,blink
L_8cc56a:
	mov_s r2,0x1019954
L_8cc570:
	mov_s r1,0x12f9
L_8cc576:
	bl.d L_8c82c0
L_8cc57a:
	mov r3,0x4ad
	.global L_8cc57e
L_8cc57e:
	rsub r0,r16,0x4
L_8cc582:
	extb_s r0,r0
L_8cc584:
	add2 r0,r0,r17
L_8cc588:
	add_s r0,r0,0x8004f8
L_8cc58e:
	ldb_s r1,[r0,0x14]
L_8cc590:
	ldb_s r2,[r0,0x1c]
L_8cc592:
	add2_s r1,r1,r14
L_8cc594:
	mov_s r0,0x88a208
L_8cc59a:
	add2_s r0,r0,r1
L_8cc59c:
	ld_s r3,[r0]
L_8cc59e:
	mov_s r1,0x7
L_8cc5a0:
	asl_s r1,r1,r2
L_8cc5a2:
	bic_s r3,r3,r1
L_8cc5a4:
	asl_s r13,r13,r2
L_8cc5a6:
	or_s r3,r3,r13
L_8cc5a8:
	st_s r3,[r0]
L_8cc5aa:
	b L_8c031c
L_8cc5ae:
	nop_s
