/* get_reg88a204_s1_w32 @ 0x8cc6cc, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_lo_leakage_run, calib_lo_leakage_step, calib_lo_leakage_substep, hwf_calib__acquire_hw
 */
	.section .text.get_reg88a204_s1_w32,"ax",@progbits
	.global get_reg88a204_s1_w32
get_reg88a204_s1_w32:
	.global L_8cc6cc
L_8cc6cc:
	mov_s r0,0x88a200
L_8cc6d2:
	ld_s r0,[r0,0x4]
L_8cc6d4:
	lsr_s r0,r0
L_8cc6d6:
	j_s.d [blink]
L_8cc6d8:
	bmsk_s r0,r0,0x5
L_8cc6da:
	nop_s
