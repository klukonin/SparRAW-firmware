/* tail_hwd_rfc_write_core @ 0x8d04b0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_lo_power_step, calib_mngr_step_a, hwf_calib__prepare_hw, hwf_calib__setup_loopback, power_halt_seq
 * Зовёт сам: hwd_rfc_write_core
 */
	.section .text.tail_hwd_rfc_write_core,"ax",@progbits
	.global tail_hwd_rfc_write_core
tail_hwd_rfc_write_core:
	.global L_8d04b0
L_8d04b0:
	mov_s r1,0x1
L_8d04b2:
	mov_s r2,0x0
L_8d04b4:
	b.d L_8d0f80
L_8d04b8:
	mov_s r3,r2
L_8d04ba:
	nop_s
