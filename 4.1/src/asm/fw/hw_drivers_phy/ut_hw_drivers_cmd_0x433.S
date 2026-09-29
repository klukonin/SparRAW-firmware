/* ut_hw_drivers_cmd_0x433 @ 0x8cf964, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_calib__acquire_hw
 */
	.section .text.ut_hw_drivers_cmd_0x433,"ax",@progbits
	.global ut_hw_drivers_cmd_0x433
ut_hw_drivers_cmd_0x433:
	.global L_8cf964
L_8cf964:
	mov_s r0,0x883100
L_8cf96a:
	ld_s r0,[r0,0x50]
L_8cf96c:
	j_s [blink]
L_8cf96e:
	nop_s
