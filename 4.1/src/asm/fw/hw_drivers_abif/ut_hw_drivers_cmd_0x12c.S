/* ut_hw_drivers_cmd_0x12c @ 0x8cbe4c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_calib__acquire_hw
 */
	.section .text.ut_hw_drivers_cmd_0x12c,"ax",@progbits
	.global ut_hw_drivers_cmd_0x12c
ut_hw_drivers_cmd_0x12c:
	.global L_8cbe4c
L_8cbe4c:
	mov_s r0,0x88ae00
L_8cbe52:
	ld_s r0,[r0,0x60]
L_8cbe54:
	lsr_s r0,r0,0xb
L_8cbe56:
	j_s.d [blink]
L_8cbe58:
	bmsk_s r0,r0,0x2
L_8cbe5a:
	nop_s
