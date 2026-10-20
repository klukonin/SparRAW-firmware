/* ut_hw_drivers_cmd_0x151 @ 0x8cc654, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 */
	.section .text.ut_hw_drivers_cmd_0x151,"ax",@progbits
	.global ut_hw_drivers_cmd_0x151
ut_hw_drivers_cmd_0x151:
	.global L_8cc654
L_8cc654:
	mov_s r1,0x88a200
L_8cc65a:
	ld_s r0,[r1,0x4]
L_8cc65c:
	bclr_s r0,r0,0x0
L_8cc65e:
	st_s r0,[r1,0x4]
L_8cc660:
	ld_s r0,[r1,0x4]
L_8cc662:
	bset_s r0,r0,0x0
L_8cc664:
	st_s r0,[r1,0x4]
L_8cc666:
	j_s [blink]
