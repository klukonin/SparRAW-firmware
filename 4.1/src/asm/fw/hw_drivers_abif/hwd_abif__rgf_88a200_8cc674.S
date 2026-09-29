/* hwd_abif__rgf_88a200_8cc674 @ 0x8cc674, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_bb_gain_dc__vga_dc_fine, calib_lo_leakage_step, calib_lo_leakage_substep, calib_lo_power_measure, calib_lo_power_step, calib_lo_power_substep, calib_mngr_step_a, calib_mngr_step_b, hwd_abif__config_vga_rows
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.hwd_abif__rgf_88a200_8cc674,"ax",@progbits
	.global hwd_abif__rgf_88a200_8cc674
hwd_abif__rgf_88a200_8cc674:
	.global L_8cc674
L_8cc674:
	push_s blink
L_8cc676:
	bl L_8c02c4
L_8cc67a:
	mov_s r13,r0
L_8cc67c:
	bclr.f r0,r0,0x0
L_8cc680:
	mov_s r14,r1
L_8cc682:
	bne_s L_8cc6a4
	.global L_8cc684
L_8cc684:
	bic.f 0x0,r14,0x3f
L_8cc688:
	bne_s L_8cc6b8
	.global L_8cc68a
L_8cc68a:
	mov_s r0,0x88a200
L_8cc690:
	ld_s r1,[r0,0x4]
L_8cc692:
	asl_s r14,r14
L_8cc694:
	bclr_s r1,r1,0x0
L_8cc696:
	or_s r1,r1,r13
L_8cc698:
	bic r1,r1,0x7e
L_8cc69c:
	or_s r14,r14,r1
L_8cc69e:
	st_s r14,[r0,0x4]
L_8cc6a0:
	b L_8c0334
	.global L_8cc6a4
L_8cc6a4:
	mov_s r0,blink
L_8cc6a6:
	mov_s r2,0x1019954
L_8cc6ac:
	mov_s r1,0xad
L_8cc6ae:
	bl.d L_8c82c0
L_8cc6b2:
	mov r3,0x254
L_8cc6b6:
	b_s L_8cc684
	.global L_8cc6b8
L_8cc6b8:
	mov_s r0,blink
L_8cc6ba:
	mov_s r2,0x1019954
L_8cc6c0:
	mov_s r1,0xae
L_8cc6c2:
	bl.d L_8c82c0
L_8cc6c6:
	mov r3,0x254
L_8cc6ca:
	b_s L_8cc68a
