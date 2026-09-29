/* rladder__step_code @ 0x8c15e4, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_rladder_scan
 * Зовёт сам: hwd_abif__sensor_get_comp_out, hwd_abif__sensor_set_comp_value
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rladder__step_code
rladder__step_code:
	.global L_8c15e4
L_8c15e4:
	push_s blink
L_8c15e6:
	ldb.x r2,[r0]
L_8c15ea:
	add_s r1,r1,r2
L_8c15ec:
	sexb_s r1,r1
L_8c15ee:
	stb_s r1,[r0]
L_8c15f0:
	mov_s r0,0x0
L_8c15f2:
	bl.d L_8cfaa0
L_8c15f6:
	bset r0,r0,r1
L_8c15fa:
	bl L_8cf9b0
L_8c15fe:
	pop_s blink
L_8c1600:
	j_s [blink]
L_8c1602:
	nop_s
