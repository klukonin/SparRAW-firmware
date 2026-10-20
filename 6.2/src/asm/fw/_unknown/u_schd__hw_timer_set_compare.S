/* u_schd__hw_timer_set_compare @ 0x8e9160, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__hw_timer_set_compare_thunk
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global u_schd__hw_timer_set_compare
u_schd__hw_timer_set_compare:
	.global L_8e9160
L_8e9160:
	mov_s r1,0x880200
L_8e9166:
	st_s r0,[r1,0x4c]
L_8e9168:
	j_s [blink]
L_8e916a:
	nop_s
