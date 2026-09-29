/* ut_hw_drivers_cmd_0x129 @ 0x8cc668, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_calib__acquire_hw
 */
	.section .text.ut_hw_drivers_cmd_0x129,"ax",@progbits
	.global ut_hw_drivers_cmd_0x129
ut_hw_drivers_cmd_0x129:
	.global L_8cc668
L_8cc668:
	mov_s r0,0x88a200
L_8cc66e:
	ld_s r0,[r0,0x4]
L_8cc670:
	j_s.d [blink]
L_8cc672:
	bmsk_s r0,r0,0x0
