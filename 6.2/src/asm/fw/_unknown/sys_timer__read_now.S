/* sys_timer__read_now @ 0x8e916c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__now_hw_timer_thunk
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sys_timer__read_now
sys_timer__read_now:
	.global L_8e916c
L_8e916c:
	mov_s r0,0x880200
L_8e9172:
	ld_s r0,[r0,0x54]
L_8e9174:
	j_s [blink]
L_8e9176:
	nop_s
