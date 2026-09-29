/* ut_hw_drivers_cmd_0x150 @ 0x8ccf90, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 */
	.section .text.ut_hw_drivers_cmd_0x150,"ax",@progbits
	.global ut_hw_drivers_cmd_0x150
ut_hw_drivers_cmd_0x150:
	.global L_8ccf90
L_8ccf90:
	mov_s r1,0x88a000
L_8ccf96:
	ld_s r0,[r1]
L_8ccf98:
	bclr_s r0,r0,0x0
L_8ccf9a:
	st_s r0,[r1]
L_8ccf9c:
	ld_s r0,[r1]
L_8ccf9e:
	bset_s r0,r0,0x0
L_8ccfa0:
	st_s r0,[r1]
L_8ccfa2:
	j_s [blink]
