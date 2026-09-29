/* ut_hw_drivers_cmd_0x41f @ 0x8cf118, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 */
	.section .text.ut_hw_drivers_cmd_0x41f,"ax",@progbits
	.global ut_hw_drivers_cmd_0x41f
ut_hw_drivers_cmd_0x41f:
	.global L_8cf118
L_8cf118:
	mov_s r2,0x885130
L_8cf11e:
	ld.as r2,[r2,r0]
L_8cf122:
	lsr r0,r2,0x10
L_8cf126:
	bmsk_s r0,r0,0xa
L_8cf128:
	stw_s r0,[r1]
L_8cf12a:
	bmsk_s r2,r2,0xa
L_8cf12c:
	j_s.d [blink]
L_8cf12e:
	stw_s r2,[r1,0x2]
