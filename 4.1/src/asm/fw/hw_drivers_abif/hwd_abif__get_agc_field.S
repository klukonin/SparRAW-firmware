/* hwd_abif__get_agc_field @ 0x8cc834, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, abif__agc_field_rmw, calib_lo_leakage_step, calib_lo_power_measure, calib_row_step, hwf_vga_dc__calibrate
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.hwd_abif__get_agc_field,"ax",@progbits
	.global hwd_abif__get_agc_field
hwd_abif__get_agc_field:
	.global L_8cc834
L_8cc834:
	push_s blink
L_8cc836:
	bl L_8c02c0
L_8cc83a:
	mov_s r13,r0
L_8cc83c:
	mov_s r14,r1
L_8cc83e:
	brge.d r1,0x5,L_8cc878
L_8cc842:
	mov_s r15,r2
L_8cc844:
	brlt r14,0x1,L_8cc878
	.global L_8cc848
L_8cc848:
	brge r15,0x2,L_8cc890
	.global L_8cc84c
L_8cc84c:
	cmp_s r13,0x40
L_8cc84e:
	bge L_8cc8a8
	.global L_8cc852
L_8cc852:
	rsub r0,r14,0x4
L_8cc856:
	extb_s r0,r0
L_8cc858:
	add2_s r0,r0,r15
L_8cc85a:
	add_s r0,r0,0x800538
L_8cc860:
	ldb_s r1,[r0,0x14]
L_8cc862:
	ldb_s r2,[r0,0x1c]
L_8cc864:
	mov_s r0,0x88a208
L_8cc86a:
	add2_s r1,r1,r13
L_8cc86c:
	ld.as r0,[r0,r1]
L_8cc870:
	lsr_s r0,r0,r2
L_8cc872:
	b.d L_8c032c
L_8cc876:
	bmsk_s r0,r0,0x4
	.global L_8cc878
L_8cc878:
	mov_s r0,blink
L_8cc87a:
	mov_s r2,0x1019954
L_8cc880:
	mov_s r1,0x12d1
L_8cc886:
	bl.d L_8c82c0
L_8cc88a:
	mov r3,0x4d7
L_8cc88e:
	b_s L_8cc848
	.global L_8cc890
L_8cc890:
	mov_s r0,blink
L_8cc892:
	mov_s r2,0x1019954
L_8cc898:
	mov_s r1,0x12d3
L_8cc89e:
	bl.d L_8c82c0
L_8cc8a2:
	mov r3,0x4d8
L_8cc8a6:
	b_s L_8cc84c
	.global L_8cc8a8
L_8cc8a8:
	mov_s r0,blink
L_8cc8aa:
	mov_s r2,0x1019954
L_8cc8b0:
	mov_s r1,0x12cf
L_8cc8b6:
	bl.d L_8c82c0
L_8cc8ba:
	mov r3,0x4d9
L_8cc8be:
	b_s L_8cc852
