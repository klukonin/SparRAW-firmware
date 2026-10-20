/* ut_hw_drivers_cmd_0x128 @ 0x8ccac8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_calib__acquire_hw
 */
	.section .text.ut_hw_drivers_cmd_0x128,"ax",@progbits
	.global ut_hw_drivers_cmd_0x128
ut_hw_drivers_cmd_0x128:
	.global L_8ccac8
L_8ccac8:
	mov_s r0,0x88a200
L_8ccace:
	ld_s r0,[r0,0x4]
L_8ccad0:
	lsr_s r0,r0,0x19
L_8ccad2:
	j_s.d [blink]
L_8ccad4:
	bmsk_s r0,r0,0x0
L_8ccad6:
	nop_s
