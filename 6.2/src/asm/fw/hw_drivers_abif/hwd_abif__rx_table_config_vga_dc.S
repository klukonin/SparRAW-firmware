/* hwd_abif__rx_table_config_vga_dc @ 0x8cf36c, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, abif__agc_field_rmw, calib_lo_leakage__sweep, calib_lo_leakage_step, calib_lo_leakage_substep, calib_vga_gain_step, hwd_abif__set_agc_column, hwf_dc_calib_fix_dac1, hwf_vga_dc__calibrate
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__rx_table_config_vga_dc
hwd_abif__rx_table_config_vga_dc:
	.global L_8cf36c
L_8cf36c:
	push_s blink
L_8cf36e:
	bl L_8c01dc
L_8cf372:
	mov_s r14,r0
L_8cf374:
	mov_s r13,r1
L_8cf376:
	mov_s r15,r2
L_8cf378:
	brge.d r1,0x5,L_8cf3bc
L_8cf37c:
	mov_s r16,r3
L_8cf37e:
	brlt r13,0x1,L_8cf3bc
	.global L_8cf382
L_8cf382:
	brge r15,0x2,L_8cf3c8
	.global L_8cf386
L_8cf386:
	cmp_s r14,0x40
L_8cf388:
	bge L_8cf3d4
	.global L_8cf38c
L_8cf38c:
	rsub r0,r13,0x4
L_8cf390:
	extb_s r0,r0
L_8cf392:
	add2_s r0,r0,r15
L_8cf394:
	add_s r0,r0,0x800550
L_8cf39a:
	ldb_s r1,[r0,0x4]
L_8cf39c:
	ldb_s r2,[r0,0xc]
L_8cf39e:
	add2_s r1,r1,r14
L_8cf3a0:
	mov_s r0,0x88a208
L_8cf3a6:
	add2_s r0,r0,r1
L_8cf3a8:
	ld_s r3,[r0]
L_8cf3aa:
	mov_s r1,0x1f
L_8cf3ac:
	asl_s r1,r1,r2
L_8cf3ae:
	bic_s r3,r3,r1
L_8cf3b0:
	asl r1,r16,r2
L_8cf3b4:
	or_s r3,r3,r1
L_8cf3b6:
	st_s r3,[r0]
L_8cf3b8:
	b L_8c0244
	.global L_8cf3bc
L_8cf3bc:
	mov_s r0,blink
L_8cf3be:
	mov_s r1,0xf7
L_8cf3c0:
	bl.d L_8c9b28
L_8cf3c4:
	bset_s r1,r1,0xc
L_8cf3c6:
	b_s L_8cf382
	.global L_8cf3c8
L_8cf3c8:
	mov_s r0,blink
L_8cf3ca:
	mov_s r1,0xf8
L_8cf3cc:
	bl.d L_8c9b28
L_8cf3d0:
	bset_s r1,r1,0xc
L_8cf3d2:
	b_s L_8cf386
	.global L_8cf3d4
L_8cf3d4:
	mov_s r0,blink
L_8cf3d6:
	mov_s r1,0xf9
L_8cf3d8:
	bl.d L_8c9b28
L_8cf3dc:
	bset_s r1,r1,0xc
L_8cf3de:
	b_s L_8cf38c
