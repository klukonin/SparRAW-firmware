/* u_schd__hw_timer_a_start @ 0x8e91a4, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__timer_init
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global u_schd__hw_timer_a_start
u_schd__hw_timer_a_start:
	.global L_8e91a4
L_8e91a4:
	push_s blink
L_8e91a6:
	mov_s r1,0x880200
L_8e91ac:
	st_s r0,[r1,0x8]
L_8e91ae:
	mov_s r0,0x65
L_8e91b0:
	st_s r0,[r1,0x24]
L_8e91b2:
	sync
L_8e91b6:
	pop_s blink
L_8e91b8:
	j_s [blink]
L_8e91ba:
	nop_s
