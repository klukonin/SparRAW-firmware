/* u_schd__now_hw_timer_thunk @ 0x8cc100, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__now
 * Зовёт сам: sys_timer__read_now
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global u_schd__now_hw_timer_thunk
u_schd__now_hw_timer_thunk:
	.global L_8cc100
L_8cc100:
	b L_8e916c
	.global L_8cc104
L_8cc104:
	ld r2,[r0, 0x88]
L_8cc108:
	st_s r2,[r1]
L_8cc10a:
	j_s.d [blink]
L_8cc10c:
	ld r0,[r0, 0x8c]
L_8cc110:
	b.d L_8cc104
L_8cc114:
	add_s r0,r0,0x28
L_8cc116:
	nop_s
