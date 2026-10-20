/* ut_hw_drivers_cmd_0x12e @ 0x8cbe5c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 */
	.section .text.ut_hw_drivers_cmd_0x12e,"ax",@progbits
	.global ut_hw_drivers_cmd_0x12e
ut_hw_drivers_cmd_0x12e:
	.global L_8cbe5c
L_8cbe5c:
	mov_s r0,0x88ae00
L_8cbe62:
	ld_s r0,[r0,0x60]
L_8cbe64:
	lsr_s r0,r0,0x2
L_8cbe66:
	j_s.d [blink]
L_8cbe68:
	extb_s r0,r0
L_8cbe6a:
	nop_s
