/* ut_hw_drivers_cmd_0x126 @ 0x8ccc6c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, rladder__step_code
 */
	.section .text.ut_hw_drivers_cmd_0x126,"ax",@progbits
	.global ut_hw_drivers_cmd_0x126
ut_hw_drivers_cmd_0x126:
	.global L_8ccc6c
L_8ccc6c:
	mov_s r1,0x889300
L_8ccc72:
	st_s r0,[r1,0x68]
L_8ccc74:
	j_s [blink]
L_8ccc76:
	nop_s
