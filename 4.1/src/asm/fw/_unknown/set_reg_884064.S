/* set_reg_884064 @ 0x8d0388, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: IF_GAIN__GAIN, UT_HW_DRIVERS_cmd_handler, calib_lo_leakage__vt20, calib_mngr_step_b
 */
	.section .text.set_reg_884064,"ax",@progbits
	.global set_reg_884064
set_reg_884064:
	.global L_8d0388
L_8d0388:
	mov_s r1,0x884000
L_8d038e:
	st_s r0,[r1,0x64]
L_8d0390:
	j_s [blink]
L_8d0392:
	nop_s
