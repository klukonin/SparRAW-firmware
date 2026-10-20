/* hwd_abif__set_agc_field @ 0x8cc3c8, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, abif__agc_field_rmw, calib_lo_leakage_run, calib_lo_leakage_step, calib_lo_leakage_substep, calib_vga_gain_step, hwd_abif__set_agc_column, hwf_dc_calib_fix_dac1, hwf_vga_dc__calibrate
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.hwd_abif__set_agc_field,"ax",@progbits
	.global hwd_abif__set_agc_field
hwd_abif__set_agc_field:
	.global L_8cc3c8
L_8cc3c8:
	push_s blink
L_8cc3ca:
	bl L_8c02bc
L_8cc3ce:
	mov_s r14,r0
L_8cc3d0:
	mov_s r13,r1
L_8cc3d2:
	mov_s r15,r2
L_8cc3d4:
	brge.d r1,0x5,L_8cc418
L_8cc3d8:
	mov_s r16,r3
L_8cc3da:
	brlt r13,0x1,L_8cc418
	.global L_8cc3de
L_8cc3de:
	brge r15,0x2,L_8cc42e
	.global L_8cc3e2
L_8cc3e2:
	cmp_s r14,0x40
L_8cc3e4:
	bge L_8cc444
	.global L_8cc3e8
L_8cc3e8:
	rsub r0,r13,0x4
L_8cc3ec:
	extb_s r0,r0
L_8cc3ee:
	add2_s r0,r0,r15
L_8cc3f0:
	add_s r0,r0,0x800518
L_8cc3f6:
	ldb_s r1,[r0,0x4]
L_8cc3f8:
	ldb_s r2,[r0,0xc]
L_8cc3fa:
	add2_s r1,r1,r14
L_8cc3fc:
	mov_s r0,0x88a208
L_8cc402:
	add2_s r0,r0,r1
L_8cc404:
	ld_s r3,[r0]
L_8cc406:
	mov_s r1,0x1f
L_8cc408:
	asl_s r1,r1,r2
L_8cc40a:
	bic_s r3,r3,r1
L_8cc40c:
	asl r1,r16,r2
L_8cc410:
	or_s r3,r3,r1
L_8cc412:
	st_s r3,[r0]
L_8cc414:
	b L_8c0324
	.global L_8cc418
L_8cc418:
	mov_s r0,blink
L_8cc41a:
	mov_s r2,0x1019954
L_8cc420:
	mov_s r1,0xf7
L_8cc422:
	bset_s r1,r1,0xc
L_8cc424:
	bl.d L_8c82c0
L_8cc428:
	mov r3,0x504
L_8cc42c:
	b_s L_8cc3de
	.global L_8cc42e
L_8cc42e:
	mov_s r0,blink
L_8cc430:
	mov_s r2,0x1019954
L_8cc436:
	mov_s r1,0xf8
L_8cc438:
	bset_s r1,r1,0xc
L_8cc43a:
	bl.d L_8c82c0
L_8cc43e:
	mov r3,0x505
L_8cc442:
	b_s L_8cc3e2
	.global L_8cc444
L_8cc444:
	mov_s r0,blink
L_8cc446:
	mov_s r2,0x1019954
L_8cc44c:
	mov_s r1,0xf9
L_8cc44e:
	bset_s r1,r1,0xc
L_8cc450:
	bl.d L_8c82c0
L_8cc454:
	mov r3,0x506
L_8cc458:
	b_s L_8cc3e8
L_8cc45a:
	nop_s
