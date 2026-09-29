/* rladder__step_code @ 0x8c15b0, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_rladder_scan
 * Зовёт сам: ut_hw_drivers_cmd_0x126, ut_hw_drivers_cmd_0x127
 */
	.section .text.rladder__step_code,"ax",@progbits
	.global rladder__step_code
rladder__step_code:
	.global L_8c15b0
L_8c15b0:
	push_s blink
L_8c15b2:
	ldb.x r2,[r0]
L_8c15b6:
	add_s r1,r1,r2
L_8c15b8:
	sexb_s r1,r1
L_8c15ba:
	stb_s r1,[r0]
L_8c15bc:
	mov_s r0,0x0
L_8c15be:
	bl.d L_8ccc6c
L_8c15c2:
	bset r0,r0,r1
L_8c15c6:
	bl L_8ccb48
L_8c15ca:
	pop_s blink
L_8c15cc:
	j_s [blink]
L_8c15ce:
	nop_s
