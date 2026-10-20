/* ut_hw_drivers_cmd_0x434 @ 0x8cef3c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_calib__acquire_hw
 */
	.section .text.ut_hw_drivers_cmd_0x434,"ax",@progbits
	.global ut_hw_drivers_cmd_0x434
ut_hw_drivers_cmd_0x434:
	.global L_8cef3c
L_8cef3c:
	mov_s r0,0x883d00
L_8cef42:
	ld_s r0,[r0,0x60]
L_8cef44:
	bxor r0,r0,0x0
L_8cef48:
	j_s.d [blink]
L_8cef4a:
	bmsk_s r0,r0,0x0
