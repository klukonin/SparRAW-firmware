/* ut_hw_drivers_cmd_0x108 @ 0x8cb94c, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 */
	.section .text.ut_hw_drivers_cmd_0x108,"ax",@progbits
	.global ut_hw_drivers_cmd_0x108
ut_hw_drivers_cmd_0x108:
	.global L_8cb94c
L_8cb94c:
	mov_s r1,0x88af80
L_8cb952:
	cmp_s r0,0x1
L_8cb954:
	ld_s r0,[r1,0x68]
L_8cb956:
	bset.eq r0,r0,0x0
L_8cb95a:
	bclr.ne r0,r0,0x0
L_8cb95e:
	st_s r0,[r1,0x68]
L_8cb960:
	j_s [blink]
L_8cb962:
	nop_s
