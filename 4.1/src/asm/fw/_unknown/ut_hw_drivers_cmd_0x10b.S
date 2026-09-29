/* ut_hw_drivers_cmd_0x10b @ 0x8cb7ec, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 */
	.section .text.ut_hw_drivers_cmd_0x10b,"ax",@progbits
	.global ut_hw_drivers_cmd_0x10b
ut_hw_drivers_cmd_0x10b:
	.global L_8cb7ec
L_8cb7ec:
	mov_s r1,0x88af00
L_8cb7f2:
	cmp_s r0,0x1
L_8cb7f4:
	ld_s r0,[r1,0x48]
L_8cb7f6:
	bic r0,r0,0x1f
L_8cb7fa:
	bset.eq r0,r0,0x3
L_8cb7fe:
	bset.ne r0,r0,0x4
L_8cb802:
	st_s r0,[r1,0x48]
L_8cb804:
	j_s [blink]
L_8cb806:
	nop_s
