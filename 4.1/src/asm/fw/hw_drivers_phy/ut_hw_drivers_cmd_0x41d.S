/* ut_hw_drivers_cmd_0x41d @ 0x8cf1a8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 */
	.section .text.ut_hw_drivers_cmd_0x41d,"ax",@progbits
	.global ut_hw_drivers_cmd_0x41d
ut_hw_drivers_cmd_0x41d:
	.global L_8cf1a8
L_8cf1a8:
	mov_s r0,0x885000
L_8cf1ae:
	ld_s r0,[r0,0x4]
L_8cf1b0:
	lsr_s r0,r0,0xc
L_8cf1b2:
	j_s.d [blink]
L_8cf1b4:
	bmsk_s r0,r0,0x0
L_8cf1b6:
	nop_s
