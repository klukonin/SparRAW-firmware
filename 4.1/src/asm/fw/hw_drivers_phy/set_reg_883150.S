/* set_reg_883150 @ 0x8cf958, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: IF_GAIN__GAIN, UT_HW_DRIVERS_cmd_handler, calib_lo_leakage_substep, calib_mngr_step_a, calib_silent_rssi__vt18, fw_sysassert_fatal, hwf_PHY_IF_LOOPBACK_BER_TEST, hwf_calib__prepare_hw, hwf_calib__release_hw
 */
	.section .text.set_reg_883150,"ax",@progbits
	.global set_reg_883150
set_reg_883150:
	.global L_8cf958
L_8cf958:
	mov_s r1,0x883100
L_8cf95e:
	st_s r0,[r1,0x50]
L_8cf960:
	j_s [blink]
L_8cf962:
	nop_s
