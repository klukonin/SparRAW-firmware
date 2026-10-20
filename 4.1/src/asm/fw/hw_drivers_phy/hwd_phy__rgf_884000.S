/* hwd_phy__rgf_884000 @ 0x8cf4fc, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_phy.c
 * Зовут его: IF_GAIN__GAIN, UT_HW_DRIVERS_cmd_handler, calib_lo_power_step, calib_mngr_step_a, calib_mngr_step_b, calib_silent_rssi__vt18, fw_sysassert_fatal, hwf_PHY_DIG_LOOPBACK_BER_TEST, hwf_PHY_IF_LOOPBACK_BER_TEST, hwf_calib__prepare_hw
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal
 */
	.section .text.hwd_phy__rgf_884000,"ax",@progbits
	.global hwd_phy__rgf_884000
hwd_phy__rgf_884000:
	.global L_8cf4fc
L_8cf4fc:
	push_s blink
L_8cf4fe:
	push_s r13
L_8cf500:
	mov_s r13,r0
L_8cf502:
	bclr.f r0,r0,0x0
L_8cf506:
	bne_s L_8cf51a
	.global L_8cf508
L_8cf508:
	mov_s r1,0x884000
L_8cf50e:
	ld_s r0,[r1,0x8]
L_8cf510:
	bclr_s r0,r0,0x0
L_8cf512:
	or_s r13,r13,r0
L_8cf514:
	st_s r13,[r1,0x8]
L_8cf516:
	b L_8c033c
	.global L_8cf51a
L_8cf51a:
	mov_s r0,blink
L_8cf51c:
	mov_s r2,0x1018690
L_8cf522:
	mov_s r1,0xac
L_8cf524:
	bl.d L_8c82c0
L_8cf528:
	mov_s r3,0xe3
L_8cf52a:
	b_s L_8cf508
