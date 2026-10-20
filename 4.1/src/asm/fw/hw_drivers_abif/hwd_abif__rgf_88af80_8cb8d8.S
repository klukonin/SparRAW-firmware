/* hwd_abif__rgf_88af80_8cb8d8 @ 0x8cb8d8, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: IF_GAIN__GAIN, UT_HW_DRIVERS_cmd_handler, calib_lo_power_step, calib_mngr_step_a, calib_mngr_step_b, calib_silent_rssi__vt18, hw_modes__set_loopback, hwf__set_agc_index_1c, hwf_calib__prepare_hw, hwf_calib__release_hw
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal
 */
	.section .text.hwd_abif__rgf_88af80_8cb8d8,"ax",@progbits
	.global hwd_abif__rgf_88af80_8cb8d8
hwd_abif__rgf_88af80_8cb8d8:
	.global L_8cb8d8
L_8cb8d8:
	push_s blink
L_8cb8da:
	push_s r13
L_8cb8dc:
	mov_s r13,r0
L_8cb8de:
	bclr.f r0,r0,0x0
L_8cb8e2:
	bne_s L_8cb8f8
	.global L_8cb8e4
L_8cb8e4:
	mov_s r1,0x88af80
L_8cb8ea:
	ld_s r0,[r1,0x68]
L_8cb8ec:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_8cb8ee:
	bclr_s r0,r0,0x2
L_8cb8f0:
	or_s r13,r13,r0
L_8cb8f2:
	st_s r13,[r1,0x68]
L_8cb8f4:
	b L_8c033c
	.global L_8cb8f8
L_8cb8f8:
	mov_s r0,blink
L_8cb8fa:
	mov_s r2,0x1019954
L_8cb900:
	mov_s r1,0xac
L_8cb902:
	bl.d L_8c82c0
L_8cb906:
	mov r3,0x1ce
L_8cb90a:
	b_s L_8cb8e4
