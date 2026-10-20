/* hwd_abif_rx_table_read_vga_gain @ 0x8cf788, 192 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_abif_rx_table_read_vga_gain: Row %d, index %d, is_q %d --> not a legal vga_gain_val
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_vga_gain_step
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit3, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif_rx_table_read_vga_gain
hwd_abif_rx_table_read_vga_gain:
	.global L_8cf788
L_8cf788:
	push_s blink
L_8cf78a:
	bl L_8c01dc
L_8cf78e:
	mov_s r14,r0
L_8cf790:
	mov_s r13,r1
L_8cf792:
	brge.d r1,0x5,L_8cf7ec
L_8cf796:
	mov_s r16,r2
L_8cf798:
	brlt r13,0x1,L_8cf7ec
	.global L_8cf79c
L_8cf79c:
	brge r16,0x2,L_8cf7fa
	.global L_8cf7a0
L_8cf7a0:
	cmp_s r14,0x40
L_8cf7a2:
	bge L_8cf808
	.global L_8cf7a6
L_8cf7a6:
	rsub r3,r13,0x4
L_8cf7aa:
	extb.f r3,r3
L_8cf7ae:
	add2 r0,r3,r16
L_8cf7b2:
	add_s r0,r0,0x800570
L_8cf7b8:
	ldb_s r1,[r0,0x4]
L_8cf7ba:
	ldb_s r2,[r0,0xc]
L_8cf7bc:
	mov_s r0,0x88a208
L_8cf7c2:
	add2_s r1,r1,r14
L_8cf7c4:
	ld.as r0,[r0,r1]
L_8cf7c8:
	lsr_s r0,r0,r2
L_8cf7ca:
	bmsk_s r0,r0,0x2
L_8cf7cc:
	cmp.ne r3,0x1
L_8cf7d0:
	cmp.ne r3,0x2
L_8cf7d4:
	bne_s L_8cf844
L_8cf7d6:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8cf7d8:
	brhs r0,0x7,L_8cf82e
L_8cf7dc:
	ldb.x r0,[0x80394c,r0]
L_8cf7e4:
	add r1,pcl,0x8
L_8cf7e8:
	add1_s r1,r1,r0
L_8cf7ea:
	j_s [r1]
	.global L_8cf7ec
L_8cf7ec:
	mov_s r0,blink
L_8cf7ee:
	mov_s r1,0x12d0
L_8cf7f4:
	bl L_8c9b28
L_8cf7f8:
	b_s L_8cf79c
	.global L_8cf7fa
L_8cf7fa:
	mov_s r0,blink
L_8cf7fc:
	mov_s r1,0x12d1
L_8cf802:
	bl L_8c9b28
L_8cf806:
	b_s L_8cf7a0
	.global L_8cf808
L_8cf808:
	mov_s r0,blink
L_8cf80a:
	mov_s r1,0x12cd
L_8cf810:
	bl L_8c9b28
L_8cf814:
	b_s L_8cf7a6
L_8cf816:
	mov_s r0,0x0
L_8cf818:
	b_s L_8cf844
L_8cf81a:
	mov_s r0,0x1
L_8cf81c:
	b_s L_8cf844
L_8cf81e:
	mov_s r0,0x2
L_8cf820:
	b_s L_8cf844
L_8cf822:
	mov_s r0,0x3
L_8cf824:
	b_s L_8cf844
L_8cf826:
	mov_s r0,0x4
L_8cf828:
	b_s L_8cf844
L_8cf82a:
	mov_s r0,0x5
L_8cf82c:
	b_s L_8cf844
	.global L_8cf82e
L_8cf82e:
	mov_s r13,0x7
L_8cf830:
	mov_s r1,0x101f010
L_8cf836:
	mov_s r0,0x16
L_8cf838:
	mov_s r2,r14
L_8cf83a:
	bl.d L_8dcd00
L_8cf83e:
	mov r4,r16
L_8cf842:
	mov_s r0,r13
	.global L_8cf844
L_8cf844:
	b L_8c0244
