/* ut_hw_drivers_cmd_0x137 @ 0x8ccfa4, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_calib__acquire_hw
 */
	.section .text.ut_hw_drivers_cmd_0x137,"ax",@progbits
	.global ut_hw_drivers_cmd_0x137
ut_hw_drivers_cmd_0x137:
	.global L_8ccfa4
L_8ccfa4:
	mov_s r0,0x88a000
L_8ccfaa:
	ld_s r0,[r0]
L_8ccfac:
	j_s.d [blink]
L_8ccfae:
	bmsk_s r0,r0,0x0
