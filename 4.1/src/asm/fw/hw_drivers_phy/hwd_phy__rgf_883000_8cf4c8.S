/* hwd_phy__rgf_883000_8cf4c8 @ 0x8cf4c8, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_phy.c
 * Зовут его: IF_GAIN__GAIN, UT_HW_DRIVERS_cmd_handler, calib_lo_leakage_substep, calib_lo_power_step, calib_mngr_step_a, calib_mngr_step_b, calib_silent_rssi__vt18, hwf_PHY_DIG_LOOPBACK_BER_TEST, hwf_PHY_IF_LOOPBACK_BER_TEST, hwf_calib__prepare_hw
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal
 */
	.section .text.hwd_phy__rgf_883000_8cf4c8,"ax",@progbits
	.global hwd_phy__rgf_883000_8cf4c8
hwd_phy__rgf_883000_8cf4c8:
	.global L_8cf4c8
L_8cf4c8:
	push_s blink
L_8cf4ca:
	push_s r13
L_8cf4cc:
	mov_s r13,r0
L_8cf4ce:
	bclr.f r0,r0,0x0
L_8cf4d2:
	bne_s L_8cf4e6
	.global L_8cf4d4
L_8cf4d4:
	mov_s r1,0x883000
L_8cf4da:
	ld_s r0,[r1,0x10]
L_8cf4dc:
	bclr_s r0,r0,0x0
L_8cf4de:
	or_s r13,r13,r0
L_8cf4e0:
	st_s r13,[r1,0x10]
L_8cf4e2:
	b L_8c033c
	.global L_8cf4e6
L_8cf4e6:
	mov_s r0,blink
L_8cf4e8:
	mov_s r2,0x1018690
L_8cf4ee:
	mov_s r1,0xac
L_8cf4f0:
	bl.d L_8c82c0
L_8cf4f4:
	mov r3,0x1c4
L_8cf4f8:
	b_s L_8cf4d4
L_8cf4fa:
	nop_s
