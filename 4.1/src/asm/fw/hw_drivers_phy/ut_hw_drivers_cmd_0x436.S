/* ut_hw_drivers_cmd_0x436 @ 0x8cf130, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 */
	.section .text.ut_hw_drivers_cmd_0x436,"ax",@progbits
	.global ut_hw_drivers_cmd_0x436
ut_hw_drivers_cmd_0x436:
	.global L_8cf130
L_8cf130:
	mov_s r0,0x885000
L_8cf136:
	ld_s r0,[r0,0x4]
L_8cf138:
	bbit0 r0,0xc,L_8cf130
L_8cf13c:
	j_s [blink]
L_8cf13e:
	nop_s
