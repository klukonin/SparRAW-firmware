/* ut_hw_drivers_cmd_0x131 @ 0x8cb8b0, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, ut_hw_modes_cmd_0x304
 */
	.section .text.ut_hw_drivers_cmd_0x131,"ax",@progbits
	.global ut_hw_drivers_cmd_0x131
ut_hw_drivers_cmd_0x131:
	.global L_8cb8b0
L_8cb8b0:
	mov_s r1,0x889300
L_8cb8b6:
	cmp_s r0,0x1
L_8cb8b8:
	ld_s r0,[r1,0x64]
L_8cb8ba:
	bset.eq r0,r0,0x0
L_8cb8be:
	bclr.ne r0,r0,0x0
L_8cb8c2:
	st_s r0,[r1,0x64]
L_8cb8c4:
	j_s [blink]
L_8cb8c6:
	nop_s
